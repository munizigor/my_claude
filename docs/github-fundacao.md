# Fundação GitHub — user/.github/ e project/.github/

Artefatos do my_claude, na mesma divisão do repositório:
**user/.github/** = políticas e ferramentas suas (valem para qualquer
repositório; executadas a partir do clone do my_claude — nada aqui é
instalado em `~/`);
**project/** = espelho da raiz de um repositório novo, commitado em cada um.

## Estrutura

```
user/.github/
├── bootstrap.sh          # aplica tudo num repositório novo (um comando)
├── setup-labels.sh       # cria/sincroniza labels a partir de labels.json
├── setup-project.sh      # cria Project v2 + campos + vincula ao repo
├── setup-milestones.sh   # cria milestones (edite a lista antes)
├── labels.json           # vocabulário padrão de labels (12 + label claude)
└── ruleset-main.json     # política de proteção da main (importar via UI)

project/
├── .claude/
│   └── CLAUDE.md                     # template de memória do projeto (Fase 3)
└── .github/
    ├── pull_request_template.md      # checklist TDD + processo
    ├── workflows/ci.yml              # check "test" exigido pelo ruleset
    ├── workflows/claude.yml          # responde a menções @claude (ver seção)
    └── ISSUE_TEMPLATE/
        ├── funcionalidade.yml        # problema, contexto, critério de aceite
        ├── bug.yml                   # reprodução + severidade
        └── config.yml                # bloqueia issues em branco
```

## Uso — repositório novo (caminho rápido)

```bash
cd my_claude/user/.github
gh auth refresh -s project     # só na primeira vez

./bootstrap.sh OWNER/REPO ~/caminho/do/clone
```

O bootstrap copia `project/` para o clone — o repo de destino nasce com o
layout final: `.github/` completo e `.claude/CLAUDE.md` (template com
placeholders, preenchido no gate da Fase 3 do ciclo — ver
`user/.claude/CLAUDE.md`; o Claude Code lê esse caminho nativamente).
Depois dele, três passos manuais:

1. Revisar, commitar e fazer push dos arquivos copiados.
2. Importar `user/.github/ruleset-main.json`: Settings → Rules → Rulesets → Import.
3. Ativar as automações do Projects (⋯ → Workflows) e criar as views.

## Uso — passo a passo avulso

Cada script roda sozinho se você quiser aplicar só uma parte:
`./setup-labels.sh OWNER/REPO`, etc.

**Prioridade tem dono único:** o campo **Prioridade** do Project v2, definido
na triagem. Não existem labels de prioridade; o dropdown "Prioridade sugerida"
do issue form é só a sugestão de quem abre.

## Ajustes por projeto

- **`ci.yml`**: o exemplo assume Node/npm; ajuste os comandos à stack do
  projeto. O nome do job (`test`) precisa bater com o `context` do ruleset.
- **`config.yml`** dos issue forms: trocar `OWNER/REPO` no link de
  Discussions ou remover o bloco.
- **`setup-milestones.sh`**: editar a lista de entregas antes de rodar.
- **`claude.yml`**: exige o GitHub App do Claude instalado e o secret de
  autenticação configurado (ver seção "Fluxo @claude" abaixo). Sem isso, o
  workflow simplesmente nunca dispara — pode ficar no repo sem custo.
- **Ruleset**: o default é `required_approving_review_count: 0`, que serve o
  trabalho solo (o GitHub não deixa aprovar o próprio PR). Suba para `1`
  quando o fluxo `@claude` estiver ativo e os PRs do Claude forem a via
  principal — você aprova os PRs dele; PRs abertos por você continuam sem
  auto-aprovação. Rulesets em repositório privado exigem plano pago —
  alternativa gratuita: Branch protection rules clássicas.

## Automações do Projects (UI — 2 minutos)

No projeto → **⋯ → Workflows**:

| Workflow | Configuração |
|---|---|
| Auto-add to project | `is:issue,pr is:open` no repositório |
| Item added to project | Status → Triagem |
| Pull request merged | Status → Done |
| Item closed | Status → Done |
| Auto-archive items | `is:closed updated:<@today-2w` |

Campo **Status**: `Triagem → Backlog → Em andamento → Em revisão → Done`.

Views sugeridas: Board por Status; Tabela filtrada em Triagem ordenada por
Prioridade; Tabela agrupada por Entrega; Board filtrado por `label:claude`.

## Fluxo @claude (Action)

`project/.github/workflows/claude.yml` responde a menções `@claude` em
issues, comentários e reviews: o Claude Code roda no Actions, implementa e
abre PR. O arquivo viaja com `project/` no bootstrap, mas só funciona depois
de dois pré-requisitos no repositório (uma vez cada):

1. **Caminho fácil:** rode `/install-github-app` no Claude Code do terminal —
   instala o GitHub App e configura o secret sozinho.
2. **Manual:** instale o [Claude GitHub App](https://github.com/apps/claude)
   no repositório e crie o secret `ANTHROPIC_API_KEY`. Assinantes Pro/Max
   podem usar `CLAUDE_CODE_OAUTH_TOKEN` no lugar (gerado com
   `claude setup-token`) — ajuste o input correspondente no `claude.yml`.

Com o App ativo, considere subir o ruleset para
`required_approving_review_count: 1` (ver Ajustes por projeto).

## O ciclo completo

Issue nasce pelo form → cai em Triagem sozinha → triagem diária de 5 min
(Prioridade + Esforço; `GG` → quebrar em sub-issues) → issues delegáveis
recebem `label:claude` e menção `@claude` → a Action implementa e abre PR
com `Closes #NN` → ruleset segura o merge até check verde (+ sua aprovação,
com review count em `1`) → merge fecha a issue e as automações movem tudo
para Done.
