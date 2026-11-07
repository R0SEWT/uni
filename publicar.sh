#!/usr/bin/env bash
# Publica uni.rosewt.dev: la portada (sitio/index.html), las reglas (sitio/_redirects) y la función de
# borde que agrega la barra final (netlify/edge-functions/barra.ts). Las entregas no se suben desde
# aquí: cada una se publica desde el repo de su curso, en su propio sitio de Netlify.
#
#   bash publicar.sh ["mensaje"]
#
# Sin --no-build a propósito: el paso de build (vacío, ver netlify.toml) es el que empaqueta la
# función de borde. Requiere la CLI de Netlify con sesión iniciada, o npx, que la descarga.
set -euo pipefail
cd "$(dirname "$0")"

if command -v netlify >/dev/null 2>&1; then netlify=(netlify); else netlify=(npx -y netlify-cli); fi
sitio_id="6cebaa41-d7c1-416c-b065-a74558afac07"   # uni-rosewt (cuenta r0sewt)
commit="$(git rev-parse --short HEAD 2>/dev/null || echo sin-commit)"
"${netlify[@]}" deploy --prod --dir sitio --site "$sitio_id" --message "${1:-publicar.sh desde $commit}"
echo "publicado: https://uni.rosewt.dev"
