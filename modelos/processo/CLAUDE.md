@.claude/metodo.md

# [Nome do projeto]

<!--
Modelo PROCESSO do my_claude: a entrega é o processo funcionando melhor, medido em quem o opera,
não o documento que o descreve. A linha de cima importa o método (.claude/metodo.md), que chega
e se atualiza por PR do workflow "Método"; este arquivo guarda só o que é deste projeto e o que
o método significa quando a entrega é processo. Os [colchetes] se preenchem quando a informação
existir, nunca inventada. O mapeamento em si (R1, R2, R3, formato dos nós, Mermaid) vive na
skill /processo: referencie, não cole. Nunca criar outro CLAUDE.md (nem pelo /init).
-->

[Em até três linhas: qual processo, quem o opera e qual a dor. Ex.: "Fluxo de autorização de despesa da diretoria X. Operadores: 4 analistas e 2 ordenadores. Dor: 40 dias de tramitação média, 30% de retrabalho por devolução."]

## Ficha do método

- **Navegador:** [nome]. Aceita cada pacote e faz o merge na `main`, pelo GitHub.
- **Documento de negócio:** `docs/negocio.md`.
- **Resultados que toda mudança serve:** [ex.: tempo de tramitação, retrabalho].
- **Fases do quadro:** as ondas do roteiro do TO-BE (`onda-1`, `onda-2`, `onda-3`).
- **Dados para medir:** [onde estão o tempo, o volume e o retrabalho de hoje; ou "sem linha de base: medir antes de mudar"].
- **Bateria de testes:** o teste de mesa de cada pacote, registrado em `docs/`.
- **Escritas que esperam o ok:** [publicação de norma, mensagem a quem opera, mudança em sistema do órgão].
- **Publicação:** [o rito de publicação de norma interna e quem assina].

## O método quando a entrega é processo

Um projeto pode parar no TO-BE aprovado quando implantar não estiver ao nosso alcance; a decisão é do Navegador e fica registrada no documento de negócio.

**Problema: escuta obrigatória.** Quem opera o processo é ouvido antes de o processo ser mapeado. O Piloto entrega o roteiro de entrevista ou observação (5 a 7 perguntas abertas, sem induzir solução, no mesmo formato do Empatizar da `/descoberta`), o Navegador faz o campo e o Piloto consolida separando fato de interpretação. Documento e norma dizem como o processo *deveria* ser; só a escuta diz como ele *é*, e onde dói. Sem acesso a quem opera: registrar como restrição, seguir com hipóteses marcadas `[hipótese]` e concentrar a validação no piloto.

**Desenho: `/processo`.** A escuta alimenta o AS-IS: a dor relatada entra no nó em que ocorre. O AS-IS é validado por quem opera, sempre que possível, e não só pelo Navegador. Nó com solução não clara vai para a `/descoberta`. Trava: TO-BE aprovado.

**Backlog: pacotes de mudança.** Cada cartão é um pacote implantável de ponta a ponta: a revisão de uma R2, a eliminação de uma R3, um rito novo, um gate de triagem. Prioridade por valor e esforço: R3 primeiro (o ganho mais barato que existe), depois os ganhos rápidos da primeira onda.

**Entrega: teste de mesa antes de implantar.** Passar casos reais recentes pelo fluxo novo e mostrar onde travam; caso que trava é teste falhando, e o desenho se ajusta até passar. O indicador e a linha de base do pacote se definem antes de produzir; sem linha de base, medir o processo atual antes de mudá-lo. Produtos típicos de um pacote: minuta de norma, procedimento operacional, roteiro de treinamento, formulário, comunicado.

**Validação: piloto antes de generalizar.** Implantar primeiro com volume ou tempo limitado (uma equipe, um mês, um tipo de caso), medir o indicador contra a linha de base e só então generalizar. Relatar os números reais; indicador que piorou também se relata, e o desenho volta. Pronto é o indicador medido no piloto, não a norma publicada.

**Implantação** é norma publicada, pessoas treinadas e comunicação a quem opera. O documento sozinho não muda comportamento. O manual ou procedimento se escreve a partir do TO-BE aprovado, não do zero.

## Convenções do projeto

- **Fontes de verdade:** [normas, contratos, manuais, com a hierarquia entre elas].
- **Sistemas em uso no processo:** [ex.: SEI, planilha X, e quem tem acesso].
- **Atores e alçadas:** [quem decide o quê; competências indelegáveis].

## O que nunca fazer

- Não implantar pacote sem teste de mesa com casos reais.
- Não fazer mudança de uma vez onde cabe piloto.
- Não mudar o trabalho de alguém que não foi ouvido ou, no mínimo, avisado antes.
- [Proibições descobertas no caminho.]

## Lições aprendidas

[Vazio no começo.]
