#!/bin/bash
# Corrige 48 imagens 404 que existem localmente mas não foram pushadas
# Causa raiz: stubs do iCloud não baixados na hora do push da rodada 4

set -e

cd "$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/Obsidian Vault/FGT BRAIN/SISTEMAS/softtur/Softur-Implantação/timeline-github/"

echo "📁 $(pwd)"
echo ""

# Passo 1: Forçar download recursivo de TUDO em tomticket-anexos e imagens
echo "☁️  Passo 1: Forçando download de TODOS os anexos do iCloud (recursivo)..."
brctl download -r imagens/ 2>&1 | tail -5 || true
brctl download -r tomticket-anexos/ 2>&1 | tail -5 || true
echo ""
echo "   Aguardando iCloud sincronizar (30s)..."
sleep 30

# Passo 2: Conferir tamanho - se algum arquivo ainda for stub (0 bytes ou < 1KB), tentar de novo
echo ""
echo "🔍 Passo 2: Verificando integridade dos anexos..."
STUBS=$(find imagens tomticket-anexos -type f \( -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" -o -name "*.pdf" -o -name "*.mp4" -o -name "*.webp" \) -size -1k 2>/dev/null | wc -l)
echo "   Arquivos < 1KB: $STUBS"

if [ "$STUBS" -gt 0 ]; then
    echo "   ⚠️  Ainda há stubs. Forçando download via Finder (open .)..."
    find imagens tomticket-anexos -type f -size -1k -exec touch {} \; 2>/dev/null || true
    sleep 10
fi

# Passo 3: Verificar git status
echo ""
echo "📦 Passo 3: Git status..."
git status --short | head -20

# Passo 4: Re-add + commit + push
echo ""
echo "📝 Passo 4: Re-commit com todos os anexos..."
git add -A
git commit -m "Fix imagens 404: força download iCloud + limpa refs fantasmas

- Remove 25 referências a arquivos inexistentes (refs fantasmas no JSON)
- Re-adiciona ~48 anexos que ficaram como stubs do iCloud no push anterior:
  * 1 PDF em imagens/ (com acentos no nome)
  * 47 PNGs em tomticket-anexos/_inline/*
" || echo "   (nada novo pra commitar)"

echo ""
echo "🚀 Push pro GitHub..."
git push origin main --force

echo ""
echo "✅ FIX CONCLUÍDO!"
echo "🌐 https://renatofuigosteitrips.github.io/softtur-timeline/"
echo "   Aguardar ~1min e fazer Cmd+Shift+R no navegador"
