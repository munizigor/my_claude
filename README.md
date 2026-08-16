# my_claude

Meu sistema de trabalho com o Claude Code — não só configurações, mas o modo
de trabalhar completo: contrato de pareamento e ciclo com gates (`CLAUDE.md`
<<<<<<< HEAD
global), skill de descoberta (Design Thinking), template de `CLAUDE.md` de
projeto e stack de referência. Versionado para reaplicar entre máquinas e
repositórios.
=======
global), skills de descoberta (Design Thinking) e de processo (mapa decisório
AS-IS/TO-BE), template de `CLAUDE.md` de projeto, stack de referência e fundação
GitHub (templates de issue/PR, CI, ruleset e scripts de bootstrap). Versionado
para reaplicar entre máquinas e repositórios.
>>>>>>> a524fcdcdac06316869e72a3b1924b5b9afedcce

## Estrutura

As pastas espelham o destino real: `user/.claude/` é a imagem de `~/.claude/`
e `project/` é a imagem da raiz de um repositório novo.

```
.
├── user/
<<<<<<< HEAD
│   └── .claude/       # espelho de ~/.claude/ (instalado via symlink)
│       ├── CLAUDE.md      # instruções globais
│       ├── settings.json  # permissões e tema
│       └── skills/
│           └── descoberta/  # skill /descoberta
├── project/           # espelho da raiz de um repo novo (copiado à mão)
│   └── .claude/
│       ├── CLAUDE.md      # template de memória do projeto (preenchido na Fase 3)
│       └── settings.json  # permissões do projeto
└── docs/              # referências (stack)
=======
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
>>>>>>> a524fcdcdac06316869e72a3b1924b5b9afedcce
```

- **`user/.claude/`** — configuração global, aplicada a todas as sessões.
- **`project/`** — copiado para cada repositório novo; o `CLAUDE.md`
  especializa o global (não repete o que já está lá) e o Claude Code o lê
  nativamente em `.claude/CLAUDE.md`.

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

Para um projeto novo, copie os artefatos de `project/` para a raiz do
repositório:

```bash
cp -r project/. /caminho/do/projeto/
```

O `.claude/CLAUDE.md` copiado é um template — preencha-o no gate da Fase 3
(design aprovado), conforme as instruções no próprio arquivo.
