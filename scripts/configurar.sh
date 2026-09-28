#!/usr/bin/env bash
# Substitui os placeholders do README pelos seus dados reais.
# Uso:
#   bash scripts/configurar.sh <usuario-github> <linkedin-slug> <portfolio-sem-https> <email>
# Exemplo:
#   bash scripts/configurar.sh johnny johnny-difery difery.com.br contato@exemplo.com
# Deixe um argumento como "-" para manter o placeholder correspondente.
set -euo pipefail

if [ "$#" -ne 4 ]; then
  sed -n '2,8p' "$0"; exit 1
fi

cd "$(dirname "$0")/.."
files=(README.md)
[ -f ../difery-showcase/README.md ] && files+=(../difery-showcase/README.md)

replace() {
  [ "$2" = "-" ] && return 0
  for f in "${files[@]}"; do
    sed -i.bak "s|$1|$2|g" "$f" && rm -f "$f.bak"
  done
}

replace SEU_USUARIO   "$1"
replace SEU_LINKEDIN  "$2"
replace SEU_PORTFOLIO "$3"
replace SEU_EMAIL     "$4"

echo "Pronto. Placeholders restantes:"
grep -n "SEU_" "${files[@]}" || echo "  nenhum"
