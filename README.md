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
`tipos/software/` é a imagem da raiz de um repositório novo.

```
.
├── user/
│   └── .claude/           # espelho de ~/.claude/ (instalado via symlink)
│       ├── CLAUDE.md          # o contrato
│       ├── settings.json      # permissões e tema
│       └── skills/
│           ├── descoberta/    # /descoberta — Design Thinking
│           └── processo/      # /processo — mapa decisório AS-IS/TO-BE
└── tipos/
    └── software/          # espelho da raiz de um repo novo (copiado à mão)
        └── .claude/
            ├── CLAUDE.md      # método de software + memória do projeto
            └── settings.json  # permissões do projeto
```

Existe um tipo só porque existe um tipo só em uso. O segundo nasce de um projeto
real que pediu — extraído do que funcionou, nunca desenhado por antecipação.

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
```

Prefere copiar em vez de vincular? Troque `ln -sf` por `cp`.

Para um projeto novo, copie o tipo de entrega para a raiz do repositório:

```bash
cp -r tipos/software/. /caminho/do/projeto/
```

O `.claude/CLAUDE.md` copiado já traz o método valendo desde a primeira sessão;
as seções entre `[colchetes]` são preenchidas no gate de design, antes da
primeira linha de código.
