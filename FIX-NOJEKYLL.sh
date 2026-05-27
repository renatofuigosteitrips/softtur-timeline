#!/bin/bash
# Corrige imagens 404 do _inline/ adicionando .nojekyll (desabilita Jekyll do GitHub Pages)
# CAUSA RAIZ DESCOBERTA: Jekyll ignora pastas que começam com "_" (como tomticket-anexos/_inline/)

set -e

cd "$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/Obsidian Vault/FGT BRAIN/SISTEMAS/softtur/Softur-Implantação/timeline-github/"

echo "📁 $(pwd)"
echo ""

# Confirma que .nojekyll existe (Claude já criou)
if [ ! -f .nojekyll ]; then
    touch .nojekyll
    echo "✅ Criado .nojekyll"
else
    echo "✅ .nojekyll já existe"
fi
ls -la .nojekyll

echo ""
echo "📦 git add + commit..."
git add .nojekyll
git add -A
git commit -m "Adiciona .nojekyll - desabilita Jekyll que ignorava pasta _inline/

Causa raiz dos 48 anexos 404: GitHub Pages usa Jekyll por padrão, que
filtra pastas com prefixo underscore (_inline, _drafts, etc). Esses
~47 anexos em tomticket-anexos/_inline/ ficavam invisíveis.

Com .nojekyll na raiz, GitHub Pages serve TODOS os arquivos como estão." || echo "(nada pra commitar)"

echo ""
echo "🚀 Push..."
git push origin main --force

echo ""
echo "✅ FIX CONCLUÍDO!"
echo "🌐 https://renatofuigosteitrips.github.io/softtur-timeline/"
echo "   Aguardar ~1min + Cmd+Shift+R"
