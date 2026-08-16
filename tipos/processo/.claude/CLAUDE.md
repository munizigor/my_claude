# CLAUDE.md — [NOME DO PROJETO]

<!--
TEMPLATE — tipo de entrega: PROCESSO. Instruções de preenchimento (apagar este
bloco ao finalizar):

- Copiado para a raiz do projeto no início do trabalho: o método abaixo já vale
  desde a primeira sessão. As seções entre [colchetes] são preenchidas quando a
  informação existir — nunca inventadas.
- Este é o ÚNICO CLAUDE.md do projeto — nunca criar outro na raiz (nem via
  /init).
- Este arquivo ESPECIALIZA o contrato global (~/.claude/CLAUDE.md) — não repita
  nada que já está lá (pareamento, ciclo, gates, /clear). O mapeamento em si
  (R1/R2/R3, formato dos nós, Mermaid, antipadrões de mapa) vive na skill
  /processo — referencie, não cole.
- Aqui entra o método de entrega de processo (invariante entre projetos deste
  tipo) e o que é ESPECÍFICO deste projeto e ESTÁVEL entre sessões. Decisão de
  iteração vai em .claude/PLANO.md; documentação extensa vai em ./docs/.
- Se passar de ~120 linhas, mova conteúdo para ./docs/ e deixe só o ponteiro.
- Durante o trabalho, `#` no início de uma mensagem grava correções aqui sem
  editar na mão.
-->

## Contexto de Negócio (3 linhas, máximo)

<!-- Se o projeto passou pelo modo descoberta, preencher a partir do POV e
     da persona registrados em .claude/DESCOBERTA.md. -->

[Qual processo, quem o opera, qual dor. Ex.: "Fluxo de autorização de despesa
da diretoria X. Operadores: 4 analistas e 2 ordenadores. Dor: 40 dias de
tramitação média, 30% de retrabalho por devolução."]

## Método — o que cada etapa do ciclo significa aqui

A entrega é o processo funcionando melhor — medido em quem o opera, não o
documento que o descreve. O ciclo completo vai até a implantação; um projeto
pode parar no gate do desenho quando implantar não estiver ao nosso alcance —
decisão do Navegador, registrada em `.claude/PLANO.md`.

### Entender (complementa o global) — empatia obrigatória
- **Quem opera o processo é ouvido antes de o processo ser mapeado.** Piloto
  entrega roteiro de entrevista/observação (5–7 perguntas abertas, sem induzir
  solução — mesmo formato do Empatizar da `/descoberta`); Navegador faz o
  campo; Piloto consolida separando fato de interpretação.
- Documento e norma dizem como o processo *deveria* ser; só a escuta diz como
  ele *é* — e onde dói.
- Sem acesso aos operadores: registrar como restrição, seguir com hipóteses
  marcadas `[hipótese]` e concentrar a validação no piloto. Dor ou persona sem
  escuta nunca vira fato.

### Desenho (gate) — rodar `/processo`
- A skill produz o AS-IS, o TO-BE e o roadmap em ondas (`.claude/PROCESSO.md`).
  A escuta do Entender alimenta o AS-IS: dor relatada entra no nó em que ocorre.
- AS-IS validado por quem opera, sempre que possível — não só pelo Navegador.
- Nó com solução não clara → `/descoberta`, levando o "Como poderíamos…?".
- **Gate:** TO-BE aprovado.

### Planejar — pacotes de mudança
- Incremento = **pacote de mudança** implantável ponta a ponta: revisão de uma
  R2, eliminação de uma R3, um novo rito, um gate de triagem. Extraído das
  ondas do roadmap; um pacote por vez.
- Priorização por valor × esforço: **R3 primeiro** (o ganho mais barato que
  existe), depois os quick wins da primeira onda. Máximo valor com o esforço
  necessário — não o máximo de mudança.

### Produzir — teste de mesa obrigatório (o TDD deste tipo)
- **Antes de implantar, passe casos reais recentes pelo fluxo novo** e mostre
  onde travam. O teste de mesa é a evidência de aceitação que vem antes do
  trabalho; caso que trava = teste falhando — ajustar o desenho até passar.
- KPI e baseline do pacote definidos **antes** de produzir. Sem baseline:
  medir o processo atual antes de mudá-lo — nunca meta inventada com ar de
  precisão.
- Produtos típicos de um pacote: minuta de norma, POP, roteiro de treinamento,
  formulário/template, comunicado.

### Verificar — piloto antes de generalizar
- Implantar primeiro com volume ou tempo limitado (uma equipe, um mês, um tipo
  de caso); medir o KPI contra o baseline; só então generalizar.
- Ao reportar: **os números reais**, não impressões. KPI que piorou também se
  reporta — e volta o desenho.

### Entregar (small releases)
- Implantação = norma publicada **+ pessoas treinadas + comunicação a quem
  opera**. O documento sozinho não muda comportamento.
- **DoD por outcome, não output:** "norma publicada" não conclui um pacote;
  "KPI medido no piloto" conclui.
- Documentação em `./docs/` faz parte da entrega: manual/POP escrito a partir
  do TO-BE aprovado (não do zero), lista das normas revisadas,
  `./docs/CHANGELOG.md` por pacote implantado.

## Convenções Específicas do Projeto

<!-- Só o que difere do óbvio ou do global. Exemplos comuns: -->

- Fontes de verdade: [normas, contratos, manuais — com hierarquia entre elas]
- Sistemas em uso no processo: [ex.: SEI, planilha X — e quem tem acesso]
- Atores e alçadas: [quem decide o quê; competências indelegáveis]
- [Rito de publicação de norma interna deste órgão, se houver]

## O que NUNCA fazer (específico deste tipo)

- Não implantar pacote sem teste de mesa com casos reais.
- Não fazer big-bang onde cabe piloto.
- Não mudar o trabalho de alguém que não foi ouvido — ou, no mínimo,
  comunicado antes.
- Não declarar sucesso por output (norma publicada, fluxo desenhado); sucesso
  é o KPI no piloto.
- [Adicionar proibições descobertas durante o trabalho — via `#`]

## Lições Aprendidas

<!-- Seção alimentada pelo atalho `#` durante as sessões. Podar
     periodicamente: o que virou convenção sobe para a seção acima;
     o que ficou obsoleto sai. -->

- [vazio no início do projeto]
