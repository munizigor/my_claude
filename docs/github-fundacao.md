# Fundação GitHub — user/github/ e project/.github/

Artefatos do my_claude, na mesma divisão do repositório:
**user/github/** = políticas e ferramentas suas (valem para qualquer
repositório; executadas a partir do clone do my_claude — não são
symlinkadas para `~/.claude`);
**project/** = artefatos commitados em cada repositório novo.

## Estrutura

```
user/github/
├── bootstrap.sh          # aplica tudo num repositório novo (um comando)
├── setup-labels.sh       # cria/sincroniza labels a partir de labels.json
├── setup-project.sh      # cria Project v2 + campos + vincula ao repo
├── setup-milestones.sh   # cria milestones (edite a lista antes)
├── labels.json           # vocabulário padrão de labels (17 + label claude)
└── ruleset-main.json     # política de proteção da main (importar via UI)

project/
└── .github/
    ├── pull_request_template.md      # checklist TDD + processo
    ├── workflows/ci.yml              # check "test" exigido pelo ruleset
    └── ISSUE_TEMPLATE/
        ├── funcionalidade.yml        # problema, contexto, critério de aceite
        ├── bug.yml                   # reprodução + severidade
        └── config.yml                # bloqueia issues em branco
```

## Uso — repositório novo (caminho rápido)

```bash
cd my_claude/user/github
gh auth refresh -s project     # só na primeira vez

./bootstrap.sh OWNER/REPO ~/caminho/do/clone
```

O bootstrap copia `project/` para o clone, cria labels, milestones e o
Project v2. Atenção: a cópia inclui o `project/CLAUDE.md` (template com
placeholders, preenchido no gate da Fase 3 do ciclo — ver `user/CLAUDE.md`).
Depois dele, três passos manuais:

1. Revisar, commitar e fazer push dos arquivos copiados.
2. Importar `user/github/ruleset-main.json`: Settings → Rules → Rulesets → Import.
3. Ativar as automações do Projects (⋯ → Workflows) e criar as views.

## Uso — passo a passo avulso

Cada script roda sozinho se você quiser aplicar só uma parte:
`./setup-labels.sh OWNER/REPO`, etc.

## Ajustes por projeto

- **`ci.yml`**: o exemplo assume Node/npm; ajuste os comandos à stack do
  projeto. O nome do job (`test`) precisa bater com o `context` do ruleset.
- **`config.yml`** dos issue forms: trocar `OWNER/REPO` no link de
  Discussions ou remover o bloco.
- **`setup-milestones.sh`**: editar a lista de entregas antes de rodar.
- **Ruleset**: em trabalho solo, reduza `required_approving_review_count`
  para `0` (o GitHub não deixa aprovar o próprio PR); volte para `1` quando
  o Claude Code abrir PRs via Action. Rulesets em repositório privado exigem
  plano pago — alternativa gratuita: Branch protection rules clássicas.

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

## O ciclo completo

Issue nasce pelo form → cai em Triagem sozinha → triagem diária de 5 min
(Prioridade + Esforço; `GG` → quebrar em sub-issues) → issues delegáveis
recebem `label:claude` e menção `@claude` → PR com `Closes #NN` → ruleset
segura o merge até check verde + sua aprovação → merge fecha a issue e as
automações movem tudo para Done.
