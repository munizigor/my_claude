# CLAUDE.md — [NOME DO PROJETO]

<!--
TEMPLATE — tipo de entrega: SOFTWARE. Instruções de preenchimento (apagar este
bloco ao finalizar):

- Copiado para a raiz do projeto no início do trabalho: o método abaixo já vale
  desde a primeira sessão. As seções entre [colchetes] são preenchidas no gate
  de design, antes da primeira linha de código.
- Este arquivo ESPECIALIZA o contrato global (~/.claude/CLAUDE.md) — não repita
  nada que já está lá (pareamento, ciclo, gates, /clear). Instrução duplicada
  consome atenção do modelo e cria conflito de versão.
- Este é o ÚNICO CLAUDE.md do projeto — nunca criar outro na raiz (nem via
  /init).
- Aqui entra o método de software (invariante entre projetos deste tipo) e o
  que é ESPECÍFICO deste projeto e ESTÁVEL entre sessões. Decisão de iteração
  vai em .claude/PLANO.md; documentação extensa vai em ./docs/ (referencie,
  não cole).
- Se o arquivo preenchido (comentários apagados) passar de ~120 linhas, mova
  conteúdo para ./docs/ e deixe só o ponteiro.
- Durante a construção, `#` no início de uma mensagem grava correções aqui sem
  editar na mão.
-->

## Contexto de Negócio (3 linhas, máximo)

<!-- Se o projeto passou pelo modo descoberta, preencher a partir do POV e
     da persona registrados em .claude/DESCOBERTA.md. -->

[O que o sistema faz, para quem, e qual problema resolve. Ex.: "API de
interoperabilidade entre centrais de despacho 193 (CBMDF) e 192 (SAMU/DF).
Usuários: operadores de despacho. Restrições: LGPD, contrato FHIR R4."]

## Método — o que cada etapa do ciclo significa aqui

### Planejar
- Incrementos são **user stories**: "Como [papel], quero [ação] para [valor]",
  com critérios de aceitação verificáveis. Múltiplos módulos → quebrar antes em
  épicos e tratar um épico por vez pelo ciclo completo.

### Gate de design (antes da primeira linha de código)
- Arquitetura em texto curto ou diagrama simples: componentes, fluxo de dados,
  contratos/interfaces. Só o necessário para as stories da iteração.
- Incerteza técnica → **spike**: protótipo descartável, com tempo limitado,
  antes de comprometer o design.
- Preencher aqui a stack travada e os comandos. **Gate:** design e stack
  aprovados — a partir daqui começa o Produzir.

### Produzir — TDD obrigatório
- Escreva o teste que falha → **mostre a saída falhando** → implemente o mínimo
  para passar → refatore. Nessa ordem. O teste é a "evidência de aceitação antes
  do trabalho" que o contrato global exige.
- Commits pequenos e frequentes, Conventional Commits em português (`feat:`,
  `fix:`, `test:`, `refactor:`).
- Refatoração contínua: ao tocar código com dívida, melhore-o — em commit
  separado da funcionalidade.

### Verificar
- Além dos unitários do TDD: teste ponta a ponta, como um usuário faria.
- Suíte completa verde antes de declarar qualquer story concluída. Build sempre
  verde: teste quebrado bloqueia tudo.
- Nunca desative, pule ou enfraqueça um teste para "fazer passar". Se o teste
  está errado, explique e proponha a correção.

### Entregar (small releases)
- Releases pequenos e frequentes. Antes de qualquer deploy: checklist explícito
  (testes verdes, migrações revisadas, rollback definido).
- **Documentação em `./docs/` faz parte da release, não é opcional:**
  - 1º ciclo: visão geral e objetivo de negócio, processo de negócio suportado
    (`./docs/processo-negocio.md`), arquitetura e stack, modelo de dados,
    endpoints/contratos, como rodar/testar/deployar, ADRs curtos.
  - Releases seguintes: atualizar o que mudou + `./docs/CHANGELOG.md`.

## Stack Travada (sem alternativas — decidida no gate de design)

- Runtime: [ex.: Node.js 22 LTS + TypeScript 5.x, `strict: true`]
- Backend: [ex.: NestJS 11]
- Banco: [ex.: PostgreSQL 16 + Prisma 6]
- Cache/filas: [ex.: Redis 7 — ou remover linha se não usar]
- Mensageria: [ex.: RabbitMQ — ou remover linha se não usar]
- Testes: [ex.: Jest + Supertest; testcontainers para integração]
- Lint/format: [ex.: ESLint + Prettier, config no repo]
- Ambiente: [ex.: Docker Compose (`compose.yaml` na raiz)]

Desvio desta stack = parar e consultar o Navegador. Não sugerir troca.

<!-- Ponto de partida (aplicar onde couber; desvio decidido pelo Navegador):
     DDD; Padrão Digital de Governo (gitlab.com/govbr-ds/govbr-ds); Docker +
     Compose; Node.js/TypeScript; NestJS (API); Next.js (front); PostgreSQL +
     Prisma; Redis; RabbitMQ (filas) ou Kafka (streaming) — justificar. Não
     reinventar a roda: preferir open-source consolidado a código próprio. -->

## Comandos

<!-- O modelo usa exatamente estes comandos. Se o projeto usa make,
     pnpm, poetry etc., ajuste aqui E no settings.json (allow). -->

- `npm run test` — suíte completa com cobertura
- `npm run test:watch` — TDD loop
- `npm run check` — lint + type-check + testes (gate antes de commit)
- `npm run dev` — sobe ambiente local
- `npx prisma migrate dev --name <nome>` — nova migração

## Arquitetura e Estrutura

<!-- Resumo em ~10 linhas. O desenho completo vive em ./docs/arquitetura.md -->

```
src/
├── domain/          # entidades e regras de negócio puras (sem I/O)
├── application/     # casos de uso; orquestram domain + ports
├── infrastructure/  # Prisma, Redis, filas — implementações de ports
└── api/             # controllers, DTOs, validação de entrada
```

- Dependências apontam para dentro: `api → application → domain`.
  `domain` não importa nada das outras camadas.
- Detalhes: ver `./docs/arquitetura.md` e `./docs/modelo-dados.md`.

## Convenções Específicas do Projeto

<!-- Só o que difere do óbvio ou do global. Exemplos comuns: -->

- Nomes de domínio em pt-BR (`Ocorrencia`, `Despacho`); resto do código em inglês.
- Timestamps de domínio sempre em `America/Sao_Paulo`; persistência em UTC.
- Erros de negócio: exceções tipadas de `src/domain/errors/`; nunca `throw new Error(string)`.
- DTOs de entrada validados com [ex.: class-validator/Zod]; nada entra em `application` sem validação.
- [Regra de integração externa, se houver. Ex.: "Payloads FHIR validados
  contra o profile em ./docs/contratos/ antes de enviar."]

## Estratégia de Testes (metas deste projeto)

- `domain`: unit puros, sem I/O — cobertura mínima [95]%
- `application`: unit com fakes/mocks de ports — [90]%
- `infrastructure`: integração com banco real via testcontainers
- `api`: contract tests contra o schema OpenAPI
- `npm run check` falha (e bloqueia o commit) com cobertura global < [85]% ou suíte vermelha

## O que NUNCA fazer (específico deste projeto)

- Não editar migrações já aplicadas; sempre criar nova migração.
- Não usar `any` ou `@ts-ignore` sem comentário justificando em uma linha.
- Não criar endpoint sem atualizar o contrato OpenAPI e o teste de contrato.
- [Adicionar proibições descobertas durante a construção — via `#`]

## Lições Aprendidas

<!-- Seção alimentada pelo atalho `#` durante as sessões. Podar
     periodicamente: o que virou convenção sobe para a seção acima;
     o que ficou obsoleto sai. -->

- [vazio no início do projeto]
