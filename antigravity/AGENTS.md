# Regras Globais: Integração de Memória Persistente (Zettelkasten)

Abaixo estão as regras absolutas para garantir que o Antigravity utilize o Obsidian como uma Memória de Estado Persistente. 
Estas regras resolvem o problema de amnésia entre as sessões.

<RULE[user_global]>
# Antigravity Brain (Obsidian Vault Integration)

## 1. Consciência do Vault
Você tem acesso a um cofre centralizado de Memória de Estado Persistente. Esse cofre armazena o histórico das suas pesquisas, decisões arquiteturais e mapas de código. Siga estritamente as regras de Zettelkasten abaixo ao interagir com ele.

## 2. Regras do Zettelkasten (Criação de Notas)
- Use `[[wikilinks]]` sempre que mencionar outra nota para conectá-las.
- Toda nota nova criada no Vault DEVE ter um cabeçalho Frontmatter YAML com `title`, `tags`, e `date`.
- Salve notas de conhecimento consolidado (sobre papers, tutoriais ou arquitetura) na pasta `/permanent/`.
- Nomes de arquivo devem usar kebab-case (ex: `arquitetura-backend.md`).

## 3. Comandos de Sessão (Protocolos de Memória)

### O Protocolo `/salvar`
Quando o usuário disser "/salvar" ou pedir para documentar o fim da sessão:
1. Crie imediatamente um log na pasta `logs/YYYY-MM-DD-assunto.md`.
2. Registre: O que foi feito na sessão, decisões tomadas, e as pendências (o que falta fazer).
3. Adicione `[[wikilinks]]` para qualquer conceito chave mencionado.

### O Protocolo `/retomar`
Quando o usuário disser "/retomar" ou pedir para recuperar o contexto:
1. Liste e leia autonomamente os últimos arquivos da pasta `logs/`.
2. Faça um breve resumo para o usuário afirmando: "Segundo nossos registros, paramos em X e o próximo passo é Y."

## 4. Integração com Graphify
Sempre que for necessário mapear o codebase ou quando o usuário pedir para gerar o grafo:
1. O output do mapeamento estrutural do código deve ser armazenado na pasta `/graphify/nome-do-projeto/`.
2. Priorize ler o grafo na pasta do Obsidian antes de tentar ler todos os arquivos brutos do repositório novamente.

</RULE[user_global]>
