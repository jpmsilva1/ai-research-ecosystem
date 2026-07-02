# Guia de Uso: Core Pack (Acadêmico)

Este guia ensina você a tirar o máximo proveito do ecossistema voltado para Pesquisa Científica e Engenharia Reversa de Artigos, reduzindo drasticamente o tempo de revisão de literatura.

## 1. Mapeamento Profundo (Deep Research)
Quando você começar um projeto novo e precisar descobrir o estado da arte:
1. Abra o seu LLM (Antigravity/Claude).
2. Peça: *"Inicie uma varredura profunda (`deep-research`) sobre o tema X, foque em papers dos últimos 3 anos."*
3. O LLM utilizará motores de busca avançados (Semantic Scholar) para achar e ler dezenas de resumos e retornará um relatório com referências.

## 2. O Ecossistema ARA (Agent-Native Research Artifact)
Para que o LLM não sofra alucinações ao ler PDFs, transformamos papers em "Artefatos Nativos para Agentes" (ARA).
1. Baixe o PDF do seu paper alvo (usando a `papers-skill`).
2. Diga ao agente: *"Compile este PDF em um ARA usando a skill `ara-compiler`."*
3. O agente isolará tabelas, afirmações (claims) e dados experimentais do PDF e salvará no seu Obsidian (na pasta `ara/`). Assim, você cria uma base de dados científica perfeita.

## 3. Escrita de Artigos (ML Paper Writing)
Na hora de compilar o seu código em um artigo para NeurIPS ou ICML:
1. Peça ao agente: *"Escreva a seção de Metodologia do nosso artigo usando a skill `ml-paper-writing` baseando-se no nosso experimento."*
2. Para os gráficos: *"Invoque a skill `academic-plotting` para gerar uma figura de qualidade de publicação (matplotlib) mostrando a curva de Loss do nosso último run."*
