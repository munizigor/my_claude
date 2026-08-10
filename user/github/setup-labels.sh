#!/usr/bin/env bash
# Cria/atualiza as labels de labels.json no repositório.
# Uso: ./setup-labels.sh OWNER/REPO
# Requisitos: gh (autenticado) e jq

set -euo pipefail

REPO="${1:?Uso: ./setup-labels.sh OWNER/REPO}"

jq -c '.[]' labels.json | while read -r label; do
  name=$(echo "$label" | jq -r '.name')
  color=$(echo "$label" | jq -r '.color')
  desc=$(echo "$label" | jq -r '.description')

  if gh label create "$name" --repo "$REPO" --color "$color" --description "$desc" 2>/dev/null; then
    echo "✔ criada:     $name"
  else
    gh label edit "$name" --repo "$REPO" --color "$color" --description "$desc"
    echo "↻ atualizada: $name"
  fi
done

echo
echo "Labels padrão do GitHub que você pode remover (opcional):"
echo "  gh label delete 'good first issue' --repo $REPO --yes"
echo "  gh label delete 'help wanted' --repo $REPO --yes"
echo "  gh label delete 'invalid' --repo $REPO --yes"
echo "  gh label delete 'wontfix' --repo $REPO --yes"
echo "  gh label delete 'duplicate' --repo $REPO --yes"
echo "  gh label delete 'enhancement' --repo $REPO --yes"
echo "  gh label delete 'bug' --repo $REPO --yes"
echo "  gh label delete 'question' --repo $REPO --yes"
