# my_claude

Meu sistema de trabalho com o Claude Code — não só configurações, mas o modo
de trabalhar completo: contrato de pareamento e ciclo com gates (`CLAUDE.md`
global), skill de descoberta (Design Thinking), template de `CLAUDE.md` de
projeto e stack de referência. Versionado para reaplicar entre máquinas e
repositórios.

## Estrutura

As pastas espelham o destino real: `user/.claude/` é a imagem de `~/.claude/`
e `project/` é a imagem da raiz de um repositório novo.

```
.
├── user/
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
```

Prefere copiar em vez de vincular? Troque `ln -sf` por `cp`.

Para um projeto novo, copie os artefatos de `project/` para a raiz do
repositório:

```bash
cp -r project/. /caminho/do/projeto/
```

O `.claude/CLAUDE.md` copiado é um template — preencha-o no gate da Fase 3
(design aprovado), conforme as instruções no próprio arquivo.
