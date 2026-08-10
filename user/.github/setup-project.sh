#!/usr/bin/env bash
# Cria um Project v2 com campos customizados e vincula ao repositório.
# Uso: ./setup-project.sh OWNER OWNER/REPO "Nome do Projeto"
# Requisitos: gh autenticado com escopo project (gh auth refresh -s project)

set -euo pipefail

OWNER="${1:?Uso: ./setup-project.sh OWNER OWNER/REPO \"Nome do Projeto\"}"
REPO="${2:?Informe OWNER/REPO como segundo argumento}"
TITLE="${3:-Gestão de Trabalho}"

echo "Criando projeto \"$TITLE\" para $OWNER..."
PROJECT_URL=$(gh project create --owner "$OWNER" --title "$TITLE" --format json --jq '.url')
PROJECT_NUMBER=$(echo "$PROJECT_URL" | grep -oE '[0-9]+$')
echo "✔ Projeto criado: $PROJECT_URL"

echo "Criando campos customizados..."

gh project field-create "$PROJECT_NUMBER" --owner "$OWNER" \
  --name "Prioridade" --data-type SINGLE_SELECT \
  --single-select-options "🔴 Alta,🟠 Média,🟢 Baixa"
echo "✔ Campo: Prioridade"

gh project field-create "$PROJECT_NUMBER" --owner "$OWNER" \
  --name "Esforço" --data-type SINGLE_SELECT \
  --single-select-options "P (até 2h),M (meio dia),G (1-2 dias),GG (quebrar em sub-issues)"
echo "✔ Campo: Esforço"

gh project field-create "$PROJECT_NUMBER" --owner "$OWNER" \
  --name "Entrega" --data-type TEXT
echo "✔ Campo: Entrega (vincule ao milestone correspondente)"

echo "Vinculando o repositório $REPO ao projeto..."
gh project link "$PROJECT_NUMBER" --owner "$OWNER" --repo "$REPO"
echo "✔ Repositório vinculado"

echo
echo "Pronto! Próximos passos manuais (UI, 2 minutos) — ver LEIA-ME:"
echo "  1. Ativar automações em $PROJECT_URL/workflows"
echo "  2. Criar as views sugeridas"
