# my_claude

Meu sistema de trabalho com o Claude Code. Duas camadas, só isso:

- **O contrato** (`user/.claude/CLAUDE.md`) — como trabalhamos, independente do
  que está sendo entregue: papéis, ciclo Entender → Planejar → Produzir →
  Entregar, gates de aprovação e regras permanentes. Vale para software,
  documento, processo ou decisão.
- **O tipo de entrega** (`tipos/<tipo>/`) — o método concreto: ferramentas,
  comandos e o que conta como evidência. Copiado para a raiz do projeto no
  início do trabalho.

Se uma instrução vale para qualquer entrega, é contrato. Se só faz sentido com
uma ferramenta na mão, é tipo. Nada é duplicado entre os dois.

## Estrutura

As pastas espelham o destino real: `user/.claude/` é a imagem de `~/.claude/` e
cada `tipos/<tipo>/` é a imagem da raiz de um repositório novo.

```
.
├── user/
│   └── .claude/           # espelho de ~/.claude/ (instalado via symlink)
│       ├── CLAUDE.md          # o contrato
│       ├── settings.json      # permissões e tema
│       └── skills/
│           ├── descoberta/    # /descoberta — Design Thinking
│           └── processo/      # /processo — mapa decisório AS-IS/TO-BE
└── tipos/                 # espelhos da raiz de um repo novo (copiados à mão)
    ├── software/          # entrega: sistema — TDD, stack travada, releases
    │   └── .claude/       # CLAUDE.md (método + memória) e settings.json
    └── processo/          # entrega: processo redesenhado — escuta de quem
        └── .claude/       # opera, teste de mesa, piloto medido por KPI
```

Cada tipo existente nasceu de uso real. Um tipo novo nasce de um projeto que
pedir — extraído do que funcionou, nunca desenhado por antecipação.

Skill é procedimento que se roda (`/descoberta`, `/processo`); `CLAUDE.md` é
memória permanente. É esse o critério para decidir onde algo novo entra.

## Instalação

Vincule os arquivos globais ao diretório `~/.claude` (symlink mantém o repo
como fonte da verdade; edições passam a versionadas automaticamente):

```bash
mkdir -p ~/.claude/skills
ln -sf  "$(pwd)/user/.claude/CLAUDE.md"          ~/.claude/CLAUDE.md
ln -sf  "$(pwd)/user/.claude/settings.json"      ~/.claude/settings.json
ln -sfn "$(pwd)/user/.claude/skills/descoberta"  ~/.claude/skills/descoberta
ln -sfn "$(pwd)/user/.claude/skills/processo"    ~/.claude/skills/processo
ln -sfn "$(pwd)/tipos"                           ~/.claude/tipos
```

O último symlink torna os templates alcançáveis de qualquer sessão — é por ele
que o contrato copia o tipo no início de um projeto.

Prefere copiar em vez de vincular? Troque `ln -sf` por `cp`.

Para um projeto novo, copie o tipo de entrega para a raiz do repositório:

```bash
cp -r tipos/software/. /caminho/do/projeto/   # entrega é um sistema
cp -r tipos/processo/. /caminho/do/projeto/   # entrega é um processo
```

O `.claude/CLAUDE.md` copiado já traz o método valendo desde a primeira sessão;
as seções entre `[colchetes]` são preenchidas nos gates, conforme as instruções
no próprio arquivo.
