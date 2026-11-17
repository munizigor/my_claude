#!/usr/bin/env bash
# Copia o método (a pasta metodo/ do my_claude) para um projeto, ou o atualiza.
#
#   bash ferramentas/instalar_metodo.sh <pasta do my_claude> <pasta do projeto>
#
# Troca só as skills que são do método e o .claude/metodo.md; as skills próprias do projeto
# ficam. Skill que saiu do método sai do projeto (a lista do que veio fica em
# .claude/metodo.skills). Grava em .claude/metodo.versao um resumo do conteúdo, para o PR
# automático dizer de qual versão se trata. Rodar duas vezes seguidas não muda nada.
set -euo pipefail

if [ $# -ne 2 ]; then
  sed -n '2,9p' "$0" | sed 's/^# \{0,1\}//'
  exit 2
fi
origem=$(cd "$1" && pwd)/metodo/.claude
destino=$(cd "$2" && pwd)/.claude
[ -f "$origem/metodo.md" ] || { echo "Não achei $origem/metodo.md: a primeira pasta precisa ser o my_claude." >&2; exit 1; }

mkdir -p "$destino/skills"

if [ -f "$destino/metodo.skills" ]; then
  while IFS= read -r antiga; do
    [ -n "$antiga" ] && [ ! -d "$origem/skills/$antiga" ] && rm -rf "${destino:?}/skills/$antiga"
  done < "$destino/metodo.skills"
fi

: > "$destino/metodo.skills"
for pasta in "$origem"/skills/*/; do
  nome=$(basename "$pasta")
  rm -rf "${destino:?}/skills/$nome"
  cp -R "$pasta" "$destino/skills/$nome"
  echo "$nome" >> "$destino/metodo.skills"
done

cp "$origem/metodo.md" "$destino/metodo.md"

(cd "$origem" && find . -type f | LC_ALL=C sort | xargs sha256sum) | sha256sum | cut -c1-7 > "$destino/metodo.versao"

echo "Método $(cat "$destino/metodo.versao") instalado em $destino: $(paste -sd' ' "$destino/metodo.skills")"
