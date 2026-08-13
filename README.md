# my_claude

Meu sistema de trabalho com o Claude Code — não só configurações, mas o modo
de trabalhar completo: contrato de pareamento e ciclo com gates (`CLAUDE.md`
global), skills de descoberta (Design Thinking) e de processo (mapa decisório
AS-IS/TO-BE), template de `CLAUDE.md` de projeto, stack de referência e fundação
GitHub (templates de issue/PR, CI, ruleset e scripts de bootstrap). Versionado
para reaplicar entre máquinas e repositórios.

## Estrutura

As pastas espelham o destino real: `user/.claude/` é a imagem de `~/.claude/`
e `project/` é a imagem da raiz de um repositório novo.

```
.
├── user/
│   ├── .claude/       # espelho de ~/.claude/ (instalado via symlink)
│   │   ├── CLAUDE.md      # instruções globais
│   │   ├── settings.json  # permissões e tema
│   │   └── skills/
│   │       ├── descoberta/  # skill /descoberta
│   │       └── processo/    # skill /processo
│   └── .github/       # scripts gh + labels/ruleset (rodam daqui; nada instala)
├── project/           # espelho da raiz de um repo novo (copiado no bootstrap)
│   ├── .claude/
│   │   └── CLAUDE.md  # template de memória do projeto (preenchido na Fase 3)
│   └── .github/       # templates de issue/PR + workflows de CI e @claude
└── docs/              # referências (stack, fundação GitHub)
```

- **`user/.claude/`** — configuração global, aplicada a todas as sessões.
- **`user/.github/`** — exceção ao espelho: ferramentas executadas a partir
  deste repositório, nada é instalado em `~/`.
- **`project/`** — copiado para cada repositório novo pelo bootstrap; o
  `CLAUDE.md` especializa o global (não repete o que já está lá) e o Claude
  Code o lê nativamente em `.claude/CLAUDE.md`.

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

Para um novo projeto sem passar pelo bootstrap, copie só o template:

```bash
mkdir -p /caminho/do/projeto/.claude
cp project/.claude/CLAUDE.md /caminho/do/projeto/.claude/CLAUDE.md
```

## Fundação GitHub

Para preparar um repositório novo com labels, milestones, Project v2,
templates de issue/PR e CI, use o bootstrap (requer `gh` autenticado e `jq`):

```bash
cd user/.github
./bootstrap.sh OWNER/REPO /caminho/do/clone/local
```

Fluxo completo, passos manuais (ruleset, automações do Projects) e ajustes
por projeto: ver [`docs/github-fundacao.md`](docs/github-fundacao.md).
