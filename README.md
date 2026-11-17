# my_claude

Meu método para criar soluções digitais para problemas e necessidades reais com o Claude Code: da dor identificada ao cartão no quadro, do cartão ao código no ar, e do código no ar à medida do que mudou para as pessoas. Ele junta o contrato e as skills de descoberta que nasceram aqui com o fluxo de backlog, entrega e CI testado no dia a dia da Didatum.

## O ciclo

1. **Problema.** A dor, quem sofre, a evidência, a tese e as hipóteses, no `docs/negocio.md` do projeto. Trava: o Navegador aprova o problema.
2. **Descoberta**, quando a solução não é clara: `/descoberta` (Design Thinking) ou, se a dor está no processo de trabalho, `/processo` (mapa decisório AS-IS e TO-BE).
3. **Backlog.** `/demanda` transforma ideia em cartão (issue do GitHub, no quadro do Projects) com valor, hipótese mensurável e critérios de aceite.
4. **Entrega.** `/desenvolver` leva o cartão até o PR: plano aprovado, testes guiados pelos critérios, CI verde, merge do Navegador.
5. **Validação.** No prazo que o cartão prometeu, confere-se o indicador; o aprendizado volta ao documento de negócio.

As regras completas estão em [`metodo/.claude/metodo.md`](metodo/.claude/metodo.md).

## O que tem aqui

```
metodo/                  o que vai para cada projeto e se mantém em dia sozinho
  .claude/metodo.md        o contrato: papéis, ciclo, quadro, travas, git, testes, escrita
  .claude/skills/          demanda, desenvolver, descoberta, processo
modelos/                 copiados uma vez, na criação do projeto, e depois do projeto
  comum/                   docs/negocio.md e os workflows Quadro e Método
  software/                CLAUDE.md com a ficha do método e .claude/settings.json
  processo/                o mesmo, para quando a entrega é um processo redesenhado
.claude/skills/          novo-projeto: põe um repositório no método
.github/workflows/       atualizar-metodo.yml e quadro.yml (reutilizáveis) e testes.yml
ferramentas/             instalar_metodo.sh e quadro.py
user/.claude/            preferências pessoais, só para o computador
testes/rodar.sh          a bateria deste repositório
```

Se uma regra vale para qualquer projeto, ela fica em `metodo/`. Se depende do projeto (comando de teste, documento de negócio, escritas que pedem ok, conferências antes do PR), ela fica na "Ficha do método" do `CLAUDE.md` do projeto, e as skills leem de lá. Um tipo de entrega novo nasce de um projeto que pedir, extraído do que funcionou, nunca desenhado por antecipação. Skill é procedimento que se roda; `CLAUDE.md` é memória permanente.

## Como o método chega aos projetos

Cada projeto guarda uma cópia do método no próprio repositório (`.claude/metodo.md`, importado na primeira linha do `CLAUDE.md`, e as skills em `.claude/skills/`). É isso que faz o método valer igual no computador e nas sessões do Claude Code na nuvem, que só enxergam o que está no repositório: plugins e a pasta `~/.claude` não chegam lá.

Para a cópia não envelhecer, o workflow "Método" de cada projeto roda toda segunda, compara a cópia com a versão daqui e, se algo mudou, abre um PR no projeto. A cópia nunca se edita no projeto: melhora-se aqui, e todos recebem. Skills próprias de um projeto convivem com as do método e não são tocadas.

O workflow "Quadro" de cada projeto chama o daqui: cria as etiquetas do método que faltarem e mantém a etiqueta de coluna junto com o quadro.

## Começar um projeto

Crie o repositório no GitHub e abra uma sessão do Claude Code com ele e com este `my_claude` (na nuvem, anexe os dois à sessão). Rode `/novo-projeto`: ele instala o método, copia o modelo do tipo de entrega, abre o PR e começa pelo passo "Problema". O mesmo vale para um projeto que já existe adotar o método; aí a skill propõe a fusão com o `CLAUDE.md` que ele já tem.

Depois do merge desse PR, duas coisas só o dono do repositório faz no GitHub: marcar "Allow GitHub Actions to create and approve pull requests" em Settings > Actions > General, e criar o quadro (a skill explica os dois caminhos).

## No computador

As preferências pessoais e a skill `/novo-projeto` ficam disponíveis em qualquer pasta com symlinks:

```bash
mkdir -p ~/.claude/skills
ln -sf  "$(pwd)/user/.claude/CLAUDE.md"               ~/.claude/CLAUDE.md
ln -sf  "$(pwd)/user/.claude/settings.json"           ~/.claude/settings.json
ln -sfn "$(pwd)/.claude/skills/novo-projeto"          ~/.claude/skills/novo-projeto
```

Quem usava a instalação antiga: os symlinks `~/.claude/skills/descoberta`, `~/.claude/skills/processo` e `~/.claude/tipos` apontam para pastas que não existem mais e podem ser apagados; as skills agora chegam por projeto.

Para mexer no quadro pela linha de comando (precisa do `gh` com `gh auth refresh -s project`), de dentro da pasta do projeto: `python3 <my_claude>/ferramentas/quadro.py criar|sincronizar|colunas`.

## Testes

`bash testes/rodar.sh` confere que o método se instala e se atualiza sem estragar as skills próprias de um projeto, que as skills se apresentam direito, que os modelos importam o método, que as ferramentas compilam e que nenhum texto tem travessão. O GitHub roda a mesma bateria em cada PR.

Este repositório é público: nada de cliente, dado pessoal ou segredo entra aqui.
