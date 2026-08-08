# my_claude

Repositório com minhas configurações do Claude Code: `CLAUDE.md` de usuário
(global), template de `CLAUDE.md` de projeto e `settings.json`. Serve para
versionar e reaplicar essas configs entre máquinas.

## Estrutura

```
.
├── user/
│   ├── CLAUDE.md      # instruções globais → ~/.claude/CLAUDE.md
│   └── settings.json  # permissões e tema  → ~/.claude/settings.json
└── project/
    └── CLAUDE.md      # template de projeto → <raiz-do-projeto>/CLAUDE.md
```

- **`user/`** — configuração global, aplicada a todas as sessões do usuário.
- **`project/`** — template a ser copiado para a raiz de cada projeto e
  preenchido (ele especializa o global; não repete o que já está lá).

## Instalação

Vincule os arquivos globais ao diretório `~/.claude` (symlink mantém o repo
como fonte da verdade; edições passam a versionadas automaticamente):

```bash
mkdir -p ~/.claude
ln -sf "$(pwd)/user/CLAUDE.md"     ~/.claude/CLAUDE.md
ln -sf "$(pwd)/user/settings.json" ~/.claude/settings.json
```

Prefere copiar em vez de vincular? Troque `ln -sf` por `cp`.

Para um novo projeto, copie o template e preencha os placeholders:

```bash
cp project/CLAUDE.md /caminho/do/projeto/CLAUDE.md
```
