#!/usr/bin/env bash
# Bootstrap de repositório novo: copia os artefatos de project/ e aplica
# labels, milestones e Project v2 usando as ferramentas de user/.github/.
#
# Uso:   ./bootstrap.sh OWNER/REPO /caminho/do/clone/local
# Exemplo: ./bootstrap.sh igor/meu-projeto ~/dev/meu-projeto
#
# Requisitos: gh autenticado (com escopo project: gh auth refresh -s project) e jq.
# Rodar a partir da pasta user/.github/ do my_claude.

set -euo pipefail

REPO="${1:?Uso: ./bootstrap.sh OWNER/REPO /caminho/do/clone/local}"
LOCAL="${2:?Informe o caminho do clone local como segundo argumento}"
OWNER="${REPO%%/*}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_TEMPLATE="$SCRIPT_DIR/../../project"

echo "══ 1/4 Copiando artefatos de project/ para $LOCAL"
cp -rv "$PROJECT_TEMPLATE/." "$LOCAL/"
echo "   → Revise, commite e faça push antes de importar o ruleset."

echo "══ 2/4 Labels"
(cd "$SCRIPT_DIR" && ./setup-labels.sh "$REPO")

echo "══ 3/4 Milestones"
(cd "$SCRIPT_DIR" && ./setup-milestones.sh "$REPO")

echo "══ 4/4 Project v2"
read -rp "Nome do projeto no Projects [Gestão de Trabalho]: " TITLE
(cd "$SCRIPT_DIR" && ./setup-project.sh "$OWNER" "$REPO" "${TITLE:-Gestão de Trabalho}")

echo
echo "✔ Bootstrap concluído. Passos manuais restantes:"
echo "  1. Commit + push dos arquivos copiados em $LOCAL"
echo "  2. Importar user/.github/ruleset-main.json: Settings → Rules → Rulesets → Import"
echo "  3. Ativar workflows do Projects e criar as views (ver LEIA-ME)"
