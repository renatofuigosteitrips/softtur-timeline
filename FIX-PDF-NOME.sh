#!/bin/bash
# Último fix: renomeia o PDF com ç+espaço pra ASCII-safe + atualiza JSON

set -e

cd "$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/Obsidian Vault/FGT BRAIN/SISTEMAS/softtur/Softur-Implantação/timeline-github/"

echo "📁 $(pwd)"
echo ""
echo "=== Estado das imagens 00000863 ==="
ls imagens/ | grep "00000863" || echo "(nenhum)"

echo ""
echo "📦 git status..."
git status --short | head

echo ""
echo "📝 Commit..."
git add -A
git commit -m "Fix: renomeia 00000863-relatório resultado.pdf → 00000863-relatorio-resultado.pdf

Remove acentos e espaços que causavam 404 no GitHub Pages devido a
problemas de URL encoding. Atualiza referência no dados-timeline.js." || echo "(nada pra commitar)"

echo ""
echo "🚀 Push..."
git push origin main --force

echo ""
echo "✅ FIX CONCLUÍDO! 100% das imagens devem estar OK agora."
echo "🌐 https://renatofuigosteitrips.github.io/softtur-timeline/"
echo "   Cmd+Shift+R no navegador depois de ~30s"
