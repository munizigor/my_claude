#!/usr/bin/env bash
# Cria milestones no repositório.
# Uso: ./setup-milestones.sh OWNER/REPO
# Edite a lista abaixo com suas entregas reais antes de rodar.

set -euo pipefail

REPO="${1:?Uso: ./setup-milestones.sh OWNER/REPO}"

# Formato: "Título|Descrição|Data-limite (YYYY-MM-DD ou vazio)"
MILESTONES=(
  "MVP|Entregável mínimo funcionando de ponta a ponta|"
  "Piloto com usuários|Protótipo de valor validado com usuários reais|"
  "v1.0|Primeira versão estável em produção|"
)

for m in "${MILESTONES[@]}"; do
  IFS='|' read -r title desc due <<< "$m"
  args=(-f "title=$title" -f "description=$desc")
  [ -n "$due" ] && args+=(-f "due_on=${due}T23:59:59Z")

  gh api "repos/$REPO/milestones" "${args[@]}" --silent \
    && echo "✔ criado: $title" \
    || echo "⚠ já existe ou falhou: $title"
done
