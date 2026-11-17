#!/usr/bin/env bash
# Bateria do my_claude: bash testes/rodar.sh (a mesma do CI). Confere que o método se instala e
# se atualiza sem estragar o que é do projeto, que as skills se apresentam direito, que os
# modelos importam o método, que as ferramentas compilam e que o texto segue o combinado.
set -uo pipefail
cd "$(dirname "$0")/.."
raiz=$(pwd)
falhas=0
ok() { echo "ok   $1"; }
falha() { echo "FALHA $1"; falhas=$((falhas + 1)); }
confere() { if eval "$2"; then ok "$1"; else falha "$1"; fi; }

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

# 1. Instalar num projeto que já tem uma skill própria e uma skill velha do método
projeto="$tmp/projeto"
mkdir -p "$projeto/.claude/skills/propria" "$projeto/.claude/skills/velha"
echo propria > "$projeto/.claude/skills/propria/SKILL.md"
echo velha > "$projeto/.claude/skills/velha/SKILL.md"
echo velha > "$projeto/.claude/metodo.skills"
echo "lixo antigo" > "$projeto/.claude/metodo.md"
bash ferramentas/instalar_metodo.sh "$raiz" "$projeto" > /dev/null

for s in metodo/.claude/skills/*/; do
  nome=$(basename "$s")
  confere "instala a skill $nome igual à origem" "diff -r '$s' '$projeto/.claude/skills/$nome' > /dev/null"
done
confere "instala o metodo.md igual à origem" "cmp -s metodo/.claude/metodo.md '$projeto/.claude/metodo.md'"
confere "mantém a skill própria do projeto" "[ -f '$projeto/.claude/skills/propria/SKILL.md' ]"
confere "remove a skill que saiu do método" "[ ! -e '$projeto/.claude/skills/velha' ]"
confere "não lista a skill própria como do método" "! grep -qx propria '$projeto/.claude/metodo.skills'"
confere "grava a versão com 7 caracteres" "grep -qxE '[0-9a-f]{7}' '$projeto/.claude/metodo.versao'"

# 2. Rodar de novo não muda nada
antes=$(cd "$projeto" && find . -type f | LC_ALL=C sort | xargs sha256sum)
bash ferramentas/instalar_metodo.sh "$raiz" "$projeto" > /dev/null
depois=$(cd "$projeto" && find . -type f | LC_ALL=C sort | xargs sha256sum)
confere "segunda instalação não muda nada" "[ \"\$antes\" = \"\$depois\" ]"

# 3. A versão muda quando o método muda
copia="$tmp/my_claude"
mkdir -p "$copia" && cp -R metodo ferramentas "$copia/"
echo "mudança" >> "$copia/metodo/.claude/metodo.md"
v1=$(cat "$projeto/.claude/metodo.versao")
bash ferramentas/instalar_metodo.sh "$copia" "$projeto" > /dev/null
confere "a versão muda quando o método muda" "[ \"\$v1\" != \"\$(cat '$projeto/.claude/metodo.versao')\" ]"

# 4. Sem argumentos, explica o uso e falha; com pasta errada, falha
confere "sem argumentos, falha" "! bash ferramentas/instalar_metodo.sh > /dev/null 2>&1"
confere "origem que não é o my_claude, falha" "! bash ferramentas/instalar_metodo.sh '$tmp' '$projeto' > /dev/null 2>&1"

# 5. Cada skill tem name igual à pasta e description
for f in metodo/.claude/skills/*/SKILL.md .claude/skills/*/SKILL.md; do
  pasta=$(basename "$(dirname "$f")")
  confere "$f: name igual à pasta" "sed -n '2p' '$f' | grep -qx 'name: $pasta'"
  confere "$f: tem description" "sed -n '1,5p' '$f' | grep -q '^description: .\{40,\}'"
done

# 6. Os modelos importam o método na primeira linha
for f in modelos/*/CLAUDE.md; do
  confere "$f importa o método" "[ \"\$(head -1 '$f')\" = '@.claude/metodo.md' ]"
done

# 7. As ferramentas compilam e os workflows são YAML válido
confere "quadro.py compila" "python3 -c \"import ast,sys; ast.parse(open('ferramentas/quadro.py').read())\""
confere "scripts de shell sem erro de sintaxe" "bash -n ferramentas/instalar_metodo.sh && bash -n testes/rodar.sh"
if python3 -c 'import yaml' 2> /dev/null; then
  for f in .github/workflows/*.yml modelos/comum/.github/workflows/*.yml; do
    confere "$f é YAML válido" "python3 -c \"import yaml; yaml.safe_load(open('$f'))\""
  done
else
  echo "pula YAML (sem PyYAML)"
fi

# 8. Sem travessão em nenhum texto (combinado de escrita)
travessoes=$(grep -rln "$(printf '\342\200\224')" --include='*.md' --include='*.yml' --include='*.sh' --include='*.py' --include='*.json' . | grep -v '^./.git/')
confere "nenhum travessão${travessoes:+ (em: $travessoes)}" "[ -z \"\$travessoes\" ]"

echo
if [ "$falhas" -eq 0 ]; then echo "Tudo certo."; else echo "$falhas falha(s)."; exit 1; fi
