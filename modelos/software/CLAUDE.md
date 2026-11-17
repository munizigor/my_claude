@.claude/metodo.md

# [Nome do projeto]

<!--
Modelo SOFTWARE do my_claude. A linha de cima importa o método (.claude/metodo.md), que chega
e se atualiza por PR do workflow "Método"; este arquivo guarda só o que é deste projeto.
Os [colchetes] se preenchem quando a informação existir, nunca inventada: o contexto e a ficha
no passo "Problema", a stack e os comandos na trava do plano do primeiro cartão. Apagar este
comentário quando não houver mais colchetes. Passou de umas 120 linhas, mover o detalhe para
docs/ e deixar só o ponteiro. Nunca criar outro CLAUDE.md (nem pelo /init).
-->

[Em até três linhas: o que o sistema faz, para quem e qual problema resolve. Detalhe em `docs/negocio.md`.]

## Ficha do método

As skills (`/demanda`, `/desenvolver`, `/descoberta`, `/processo`) leem daqui o que é deste projeto.

- **Navegador:** [nome]. Faz o merge na `main`, pelo GitHub.
- **Documento de negócio:** `docs/negocio.md`.
- **Resultados que toda funcionalidade serve:** [um ou dois, como estão no documento de negócio].
- **Fases do quadro:** [ex.: `fase-0` a `fase-2` e `depois-do-piloto`; ou "sem fases"].
- **Dados de uso para medir:** [onde estão os eventos e as consultas que respondem "funcionou?"; ou "ainda não há registro de uso"].
- **Bateria de testes:** `[npm test]`, em [N] minutos; testes novos em [`testes/`].
- **Escritas que esperam o ok:** [banco de produção e de teste, configuração do serviço de login, envio de e-mail...].
- **Conferências antes do PR:** [guia do usuário, design system, protótipo de referência; ou "nenhuma além do método"].
- **Publicação:** [como vai para o ar e como conferir: deploy a cada push na `main`, prévia por PR, endereço].

## Stack

[Decidida na trava do plano do primeiro cartão. Desvio daqui para frente é decisão do Navegador.]

<!-- Ponto de partida, do mais enxuto ao mais robusto; escolher o menor que serve (bom design é
pouco design):
- Enxuta (padrão): site estático (HTML, CSS e JS sem build) com Supabase para login, banco e
  arquivos; publicação no Cloudflare Workers; testes com node:test, Playwright e PGlite.
- Robusta, quando houver integração pesada, filas ou equipe maior: Node.js com TypeScript,
  NestJS, PostgreSQL com Prisma, Redis, Docker Compose; testes com Jest e testcontainers.
Preferir software livre consolidado a código próprio. -->

## Comandos

- `[npm test]`: a bateria inteira, igual à do CI.
- [`npm run dev`: sobe o ambiente local, se houver.]

## Arquitetura

[Em umas dez linhas: as partes, por onde o dado passa e onde cada coisa mora. O desenho completo vai em `docs/`.]

## Convenções do projeto

[Só o que difere do óbvio ou do método. Ex.: nomes de domínio em português; datas em `America/Sao_Paulo` na tela e em UTC no banco; o que não vai para o ar.]

## O que nunca fazer

- Não editar migração já aplicada; sempre criar uma nova.
- [Proibições descobertas no caminho.]

## Lições aprendidas

[Vazio no começo. O que virar convenção sobe para a seção acima; o que ficar velho sai.]
