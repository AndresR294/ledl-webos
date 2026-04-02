#!/data/data/com.termux/files/usr/bin/bash
set -euo pipefail

echo "🚀 LEDL MASTER MERGER iniciado..."

# -------- CONFIG --------
USER="andres290487"
BASE="$HOME/LEDL_MASTER"
TMP="$BASE/tmp"

mkdir -p "$TMP"
cd "$BASE"

git init
git checkout -b main

# -------- LISTA DE REPOS --------
REPOS=(
"plataforma-ledl"
"ECOSISTEMA"
"LEDL"
"te-hacemos-los-mandados"
"mis-archivos-publicos"
"LEDL_Plataforma"
"angular"
"nextjs"
"fasthtml"
)

# -------- LOOP --------
for repo in "${REPOS[@]}"; do
  echo "📦 Procesando $repo..."

  URL="https://github.com/$USER/$repo.git"

  git remote add "$repo" "$URL" 2>/dev/null || true
  git fetch "$repo"

  git subtree add --prefix="$repo" "$repo" main || \
  git subtree add --prefix="$repo" "$repo" master || \
  echo "⚠️ fallback falló en $repo"

done

# -------- COMMIT FINAL --------
git commit -m "🔥 LEDL MASTER: integración total de repos" || true

echo ""
echo "✅ MASTER LISTO"
echo "📁 Ruta: $BASE"
