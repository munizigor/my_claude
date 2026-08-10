# my_claude

Meu sistema de trabalho com o Claude Code — não só configurações, mas o modo
de trabalhar completo: contrato de pareamento e ciclo com gates (`CLAUDE.md`
global), skill de descoberta (Design Thinking), template de `CLAUDE.md` de
projeto, stack de referência e fundação GitHub (templates de issue/PR, CI,
ruleset e scripts de bootstrap). Versionado para reaplicar entre máquinas e
repositórios.

## Estrutura

```
.
├── user/
│   ├── CLAUDE.md      # instruções globais → ~/.claude/CLAUDE.md
│   ├── settings.json  # permissões e tema  → ~/.claude/settings.json
│   ├── skills/
│   │   └── descoberta/  # skill /descoberta → ~/.claude/skills/descoberta/
│   └── github/        # scripts gh + labels/ruleset (rodam daqui; sem symlink)
├── project/
│   ├── CLAUDE.md      # template de projeto → <raiz-do-projeto>/CLAUDE.md
│   └── .github/       # templates de issue/PR + CI → copiados p/ cada repo novo
└── docs/              # referências (stack, fundação GitHub)
```

- **`user/`** — configuração global, aplicada a todas as sessões do usuário.
  A subpasta `user/github/` é exceção: ferramentas executadas a partir deste
  repositório, não symlinkadas para `~/.claude`.
- **`project/`** — template a ser copiado para a raiz de cada projeto e
  preenchido (ele especializa o global; não repete o que já está lá).

## Instalação

Vincule os arquivos globais ao diretório `~/.claude` (symlink mantém o repo
como fonte da verdade; edições passam a versionadas automaticamente):

```bash
mkdir -p ~/.claude/skills
ln -sf  "$(pwd)/user/CLAUDE.md"              ~/.claude/CLAUDE.md
ln -sf  "$(pwd)/user/settings.json"          ~/.claude/settings.json
ln -sfn "$(pwd)/user/skills/descoberta"      ~/.claude/skills/descoberta
```

Prefere copiar em vez de vincular? Troque `ln -sf` por `cp`.

Para um novo projeto, copie o template e preencha os placeholders:

```bash
cp project/CLAUDE.md /caminho/do/projeto/CLAUDE.md
```

## Fundação GitHub

Para preparar um repositório novo com labels, milestones, Project v2,
templates de issue/PR e CI, use o bootstrap (requer `gh` autenticado e `jq`):

```bash
cd user/github
./bootstrap.sh OWNER/REPO /caminho/do/clone/local
```

Fluxo completo, passos manuais (ruleset, automações do Projects) e ajustes
por projeto: ver [`docs/github-fundacao.md`](docs/github-fundacao.md).
