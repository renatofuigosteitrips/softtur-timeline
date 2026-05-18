# Timeline de Bugs — Implantação SoftTur

Dashboard interativo para acompanhamento dos bugs encontrados durante a implantação do ERP SoftTur na Fui Gostei Trips.

## Estrutura

```
timeline-github/
├── index.html              ← Interface (timeline + admin + chamados inline)
├── dados-timeline.js       ← Base de dados (43 bugs + 34 chamados + conversas)
├── edits.json              ← Edições humanas (status, observações)
├── tracker-bugs.xlsx       ← Planilha para download
├── imagens/                ← 113 evidências WhatsApp (screenshots, PDFs)
└── tomticket-anexos/       ← 120 imagens/PDFs dos chamados TomTicket
    ├── {chamado_id}/       ← Anexos formais (55 arquivos)
    └── _inline/{id}/       ← Screenshots inline (65 arquivos)
```

## Como usar

### Visualização
Abra `index.html` no navegador. Funciona localmente (`file://`) e via GitHub Pages.

### Chamados TomTicket
Cada bug que teve chamado aberto mostra uma seção colapsável "🎫 Chamados" com a conversa completa (cliente vs atendente) e imagens inline.

### Modo Admin
1. Clique em **🔧 Admin** no canto superior direito
2. Edite status, adicione observações e evidências por bug
3. Edições ficam no localStorage e podem ser exportadas como `edits.json`

### Persistir edições no repositório
1. No modo Admin, clique **📤 Exportar Edições**
2. Salve o `edits.json` na raiz do repositório
3. Commit e push — as edições carregam automaticamente para todos

## Camadas de dados

```
dados-timeline.js   →  Base bruta (43 bugs, 34 chamados, 141 msgs, 1041 refs WhatsApp)
      +
edits.json          →  Edições humanas (persistem entre rodadas)
      =
Visão final         →  Merge automático ao carregar a página
```

## Setup GitHub Pages

1. Criar repositório `softtur-timeline`
2. Upload de toda a pasta
3. Settings → Pages → Deploy from branch → main → / (root)
4. Acessar em `https://SEU-USUARIO.github.io/softtur-timeline/`

## Tecnologias

- HTML/CSS/JS puro (zero dependências)
- Design responsivo dark theme
- Filtros: severidade, status, rodada, fonte (IMP/COM/STR)
- Conversas WhatsApp com 3 grupos + chamados TomTicket inline
- Lightbox para imagens, busca em tempo real
