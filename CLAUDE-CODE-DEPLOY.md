---
tipo: processo
area: sistemas
status: ativo
papel: leaf
tags:
  - softtur
  - timeline
  - deploy
  - github-pages
  - claude-code
criado: 2026-04-21
atualizado: 2026-05-24
aliases:
  - Claude Code Deploy SoftTur Timeline
  - Deploy Timeline GitHub Softtur
---

# Prompt para Claude Code — Deploy da Timeline no GitHub

Cole este prompt inteiro no Claude Code (terminal):

---

Preciso que você faça o deploy da timeline de bugs do SoftTur no GitHub. O projeto está em:

```
~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Obsidian Vault/FGT-Cerebro/SISTEMAS/softtur/Softur-Implantação/timeline-github/
```

## Passo 1: Limpar lixo

Dentro dessa pasta, delete estes arquivos/pastas que são lixo de versões anteriores:
- `dados-timeline.js.bak`
- `dados-timeline.json.bak`
- `index.html.bak`
- `copiar-chamados.sh`
- `dados-timeline.json` (versão antiga, agora é .js)
- pasta `chamados/` inteira (tentativa falha, tem arquivos vazios)
- qualquer `.DS_Store`

## Passo 2: Forçar download das imagens do iCloud

Os arquivos em `tomticket-anexos/` podem ser stubs do iCloud (tamanho reportado mas 0 blocks em disco). Force o download:

```bash
find ~/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/Obsidian\ Vault/FGT-Cerebro/SISTEMAS/softtur/Softur-Implantação/timeline-github/tomticket-anexos -type f -exec brctl download {} \;
```

Espere 30 segundos e verifique que nenhum arquivo tem 0 bytes:
```bash
find tomticket-anexos -type f -empty | wc -l
```
Deve retornar 0. Se não, espere mais e tente de novo.

IMPORTANTE: Se o `brctl download` não resolver (arquivos continuam com 0 bytes), os arquivos originais com conteúdo real estão em:
```
~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Obsidian Vault/FGT-Cerebro/tomticket-anexos/
```
Delete a pasta `tomticket-anexos/` dentro de `timeline-github/` e copie novamente do original. Se o original também for stub, abra no Finder primeiro para forçar download.

## Passo 3: Verificar estrutura final

A pasta deve ficar assim (e SOMENTE assim):
```
timeline-github/
├── .gitignore
├── README.md
├── index.html              (≈36KB)
├── dados-timeline.js       (≈748KB)
├── edits.json              (≈4KB)
├── tracker-bugs.xlsx
├── imagens/                (113 arquivos - screenshots WhatsApp)
└── tomticket-anexos/       (120 arquivos - imagens dos chamados TomTicket)
    ├── 21764/
    ├── 21798/
    ├── 21889/
    ├── 22067/
    ├── ... (24 pastas de chamados)
    └── _inline/
        ├── 21624/
        ├── 21706/
        ├── ... (31 pastas de screenshots inline)
```

## Passo 4: Git init e push

O repositório remoto é: `https://github.com/renatofuigosteitrips/softtur-timeline.git`

Se o repo já existe no GitHub com conteúdo anterior, faça force push. Se não existe, crie-o primeiro via `gh repo create renatofuigosteitrips/softtur-timeline --private` (ou público se preferir).

```bash
cd ~/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/Obsidian\ Vault/FGT-Cerebro/SISTEMAS/softtur/Softur-Implantação/timeline-github/
git init
git add -A
git commit -m "v3: 43 bugs, 34 chamados integrados, 233 imagens, conversas WhatsApp + TomTicket"
git branch -M main
git remote add origin https://github.com/renatofuigosteitrips/softtur-timeline.git
git push -u origin main --force
```

## Passo 5: Ativar GitHub Pages

Depois do push, ative GitHub Pages:
```bash
gh api repos/renatofuigosteitrips/softtur-timeline/pages -X POST -f source.branch=main -f source.path=/
```

Ou via Settings → Pages → Deploy from branch → main → / (root).

O site ficará em: `https://renatofuigosteitrips.github.io/softtur-timeline/`

## Passo 6: Verificar

Abra o site e confirme:
1. Timeline carrega com 43 bugs
2. Filtros funcionam (severidade, status, rodada)
3. Clique em algum chamado (🎫) — deve expandir com conversa e imagens
4. Imagens dos chamados carregam (thumbnails clicáveis)
5. Lightbox abre ao clicar nas imagens

---

## Conexões

- README do projeto: [[Timeline Bugs SoftTur]]
- Hub do sistema: [[hub-softtur]]
