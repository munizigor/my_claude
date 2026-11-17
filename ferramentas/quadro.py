"""Quadro do GitHub Projects de um projeto que segue o método do my_claude.

Cada tarefa ou decisão é uma issue do repositório. A coluna do quadro (campo Status) é espelhada
numa etiqueta `status:*`, para a coluna aparecer na lista de issues e na API do GitHub sem abrir
o quadro. Rode de dentro da pasta do projeto: o repositório sai do `git remote` origin, e o
quadro é o que está ligado ao repositório.

Uso, no computador (precisa do gh com acesso a projetos: `gh auth refresh -s project`):

    python3 <my_claude>/ferramentas/quadro.py criar        # cria o quadro, as colunas e põe cada issue aberta na coluna da etiqueta
    python3 <my_claude>/ferramentas/quadro.py sincronizar  # depois de mexer no quadro: atualiza as etiquetas pela coluna
    python3 <my_claude>/ferramentas/quadro.py colunas      # depois de mudar etiquetas: põe cada cartão na coluna da etiqueta
    --simular                  # mostra o que faria, sem gravar (vale para todos)
    --titulo=<nome>            # nome do quadro ao criar (padrão: o nome do repositório)

Cartão fechado vai sempre para "Feito", nos dois sentidos. As sessões do Claude Code na nuvem
não alcançam a API de projetos (GraphQL); lá só dá para criar e etiquetar issues.
"""
import json
import re
import subprocess
import sys


def repositorio():
    r = subprocess.run(['git', 'remote', 'get-url', 'origin'], capture_output=True, text=True)
    m = re.search(r'github\.com[:/]([^/]+)/([^/]+?)(?:\.git)?/?$', r.stdout.strip())
    if not m:
        sys.exit('Rode de dentro de um repositório cujo origin esteja no GitHub.')
    return m.group(1), m.group(2)


DONO, REPO = repositorio() if __name__ == '__main__' else ('', '')
TITULO = next((a.split('=', 1)[1] for a in sys.argv[1:] if a.startswith('--titulo=')), REPO)

COLUNAS = [  # (nome no quadro, etiqueta, cor do GitHub)
    ('Ideias', 'status:ideias', 'GRAY'),
    ('A fazer', 'status:a-fazer', 'BLUE'),
    ('Próximo', 'status:próximo', 'YELLOW'),
    ('Fazendo', 'status:fazendo', 'GREEN'),
    ('Feito', 'status:feito', 'PURPLE'),
]
ETIQUETA_DA_COLUNA = {n: e for n, e, _ in COLUNAS}
COLUNA_DA_ETIQUETA = {e: n for n, e, _ in COLUNAS}
SIMULAR = '--simular' in sys.argv


def gql(query, **variaveis):
    args = ['gh', 'api', 'graphql', '-f', f'query={query}']
    for k, v in variaveis.items():
        args += ['-F' if isinstance(v, int) else '-f', f'{k}={v}']
    r = subprocess.run(args, capture_output=True, text=True)
    if r.returncode:
        sys.exit(f'Erro na API do GitHub: {r.stderr.strip()}')
    dados = json.loads(r.stdout)
    if dados.get('errors'):
        sys.exit(f'Erro na API do GitHub: {dados["errors"]}')
    return dados['data']


def rest(*args):
    if SIMULAR:
        print('  [simulado] gh api', ' '.join(args))
        return
    subprocess.run(['gh', 'api', *args], check=True, capture_output=True)


def projeto():
    """O quadro ligado ao repositório, e o id do dono (para criar um, se não houver)."""
    d = gql('''query($dono: String!, $repo: String!) { repositoryOwner(login: $dono) { id }
        repository(owner: $dono, name: $repo) { projectsV2(first: 20) { nodes { id number title url } } } }''',
            dono=DONO, repo=REPO)
    quadros = d['repository']['projectsV2']['nodes']
    if len(quadros) > 1:
        quadros = [p for p in quadros if p['title'] == TITULO] or sys.exit(
            f'Há {len(quadros)} quadros ligados a {DONO}/{REPO}; diga qual com --titulo=<nome>.')
    return (quadros[0] if quadros else None), d['repositoryOwner']['id']


def campo_status(projeto_id):
    d = gql('''query($id: ID!) { node(id: $id) { ... on ProjectV2 {
        field(name: "Status") { ... on ProjectV2SingleSelectField { id options { id name } } } } } }''', id=projeto_id)
    return d['node']['field']


def issues_abertas():
    itens, depois = [], None
    while True:
        d = gql('''query($dono: String!, $repo: String!, $depois: String) { repository(owner: $dono, name: $repo) {
            issues(states: OPEN, first: 100, after: $depois) { pageInfo { hasNextPage endCursor }
              nodes { id number title labels(first: 20) { nodes { name } } } } } }''',
                dono=DONO, repo=REPO, **({'depois': depois} if depois else {}))
        bloco = d['repository']['issues']
        itens += bloco['nodes']
        if not bloco['pageInfo']['hasNextPage']:
            return itens
        depois = bloco['pageInfo']['endCursor']


def itens_do_quadro(projeto_id):
    itens, depois = [], None
    while True:
        d = gql('''query($id: ID!, $depois: String) { node(id: $id) { ... on ProjectV2 {
            items(first: 100, after: $depois) { pageInfo { hasNextPage endCursor }
              nodes { id
                status: fieldValueByName(name: "Status") { ... on ProjectV2ItemFieldSingleSelectValue { name } }
                content { ... on Issue { id number state labels(first: 20) { nodes { name } } } } } } } } }''',
                id=projeto_id, **({'depois': depois} if depois else {}))
        bloco = d['node']['items']
        itens += bloco['nodes']
        if not bloco['pageInfo']['hasNextPage']:
            return itens
        depois = bloco['pageInfo']['endCursor']


def criar():
    p, dono_id = projeto()
    if p:
        print(f'Quadro já existe: {p["url"]}')
    else:
        repo_id = gql('query($d: String!, $r: String!) { repository(owner: $d, name: $r) { id } }', d=DONO, r=REPO)['repository']['id']
        if SIMULAR:
            print(f'[simulado] criaria o quadro "{TITULO}" ligado a {DONO}/{REPO}')
            return
        p = gql('''mutation($dono: ID!, $titulo: String!, $repo: ID!) {
            createProjectV2(input: {ownerId: $dono, title: $titulo, repositoryId: $repo}) { projectV2 { id number title url } } }''',
                dono=dono_id, titulo=TITULO, repo=repo_id)['createProjectV2']['projectV2']
        print(f'Quadro criado: {p["url"]}')

    campo = campo_status(p['id'])
    if [o['name'] for o in campo['options']] != [n for n, _, _ in COLUNAS]:
        opcoes = ', '.join(f'{{name: "{n}", color: {c}, description: ""}}' for n, _, c in COLUNAS)
        if SIMULAR:
            print('[simulado] trocaria as colunas por', [n for n, _, _ in COLUNAS])
        else:
            gql(f'''mutation($campo: ID!) {{ updateProjectV2Field(input: {{fieldId: $campo, singleSelectOptions: [{opcoes}]}}) {{
                projectV2Field {{ ... on ProjectV2SingleSelectField {{ id }} }} }} }}''', campo=campo['id'])
            campo = campo_status(p['id'])
    opcao = {o['name']: o['id'] for o in campo['options']}

    no_quadro = {i['content']['number'] for i in itens_do_quadro(p['id']) if i.get('content')}
    for issue in issues_abertas():
        etiquetas = [l['name'] for l in issue['labels']['nodes']]
        coluna = next((COLUNA_DA_ETIQUETA[e] for e in etiquetas if e in COLUNA_DA_ETIQUETA), 'A fazer')
        if issue['number'] in no_quadro:
            continue
        print(f'#{issue["number"]} → {coluna}: {issue["title"]}')
        if SIMULAR:
            continue
        item = gql('''mutation($p: ID!, $c: ID!) { addProjectV2ItemById(input: {projectId: $p, contentId: $c}) { item { id } } }''',
                   p=p['id'], c=issue['id'])['addProjectV2ItemById']['item']['id']
        mover(p['id'], campo['id'], item, opcao[coluna])
    print('Pronto. No quadro, use a visão Board agrupada por Status.')


def mover(projeto_id, campo_id, item_id, opcao_id):
    gql('''mutation($p: ID!, $i: ID!, $f: ID!, $o: String!) { updateProjectV2ItemFieldValue(input: {
        projectId: $p, itemId: $i, fieldId: $f, value: {singleSelectOptionId: $o}}) { projectV2Item { id } } }''',
        p=projeto_id, i=item_id, f=campo_id, o=opcao_id)


def colunas():
    """O contrário de sincronizar: a etiqueta manda e o cartão vai para a coluna dela."""
    p, _ = projeto()
    if not p:
        sys.exit(f'Nenhum quadro ligado a {DONO}/{REPO}; rode primeiro o comando criar.')
    campo = campo_status(p['id'])
    opcao = {o['name']: o['id'] for o in campo['options']}
    mudou = 0
    for item in itens_do_quadro(p['id']):
        c = item.get('content')
        if not c or not c.get('number'):
            continue
        etiquetas = [l['name'] for l in c['labels']['nodes']]
        certa = 'Feito' if c['state'] == 'CLOSED' else next(
            (COLUNA_DA_ETIQUETA[e] for e in etiquetas if e in COLUNA_DA_ETIQUETA), None)
        atual = (item['status'] or {}).get('name')
        if not certa or certa == atual:
            continue
        mudou += 1
        print(f'#{c["number"]}: {atual or "sem coluna"} → {certa}')
        if not SIMULAR:
            mover(p['id'], campo['id'], item['id'], opcao[certa])
    print(f'{mudou} cartão(ões) mudado(s) de coluna.')


def sincronizar():
    p, _ = projeto()
    if not p:
        sys.exit(f'Nenhum quadro ligado a {DONO}/{REPO}; rode primeiro o comando criar.')
    mudou = 0
    for item in itens_do_quadro(p['id']):
        c = item.get('content')
        if not c or not c.get('number'):
            continue
        coluna = 'Feito' if c['state'] == 'CLOSED' else (item['status'] or {}).get('name')
        if coluna not in ETIQUETA_DA_COLUNA:
            continue
        certa = ETIQUETA_DA_COLUNA[coluna]
        atuais = [l['name'] for l in c['labels']['nodes'] if l['name'].startswith('status:')]
        if atuais == [certa]:
            continue
        mudou += 1
        print(f'#{c["number"]}: {atuais or "sem coluna"} → {certa}')
        for e in atuais:
            rest('-X', 'DELETE', f'repos/{DONO}/{REPO}/issues/{c["number"]}/labels/{e}')
        rest('-X', 'POST', f'repos/{DONO}/{REPO}/issues/{c["number"]}/labels', '-f', f'labels[]={certa}')
    print(f'{mudou} cartão(ões) com a etiqueta de coluna ajustada.')


if __name__ == '__main__':
    comando = next((a for a in sys.argv[1:] if not a.startswith('--')), '')
    {'criar': criar, 'sincronizar': sincronizar, 'colunas': colunas}.get(comando, lambda: sys.exit(__doc__))()
