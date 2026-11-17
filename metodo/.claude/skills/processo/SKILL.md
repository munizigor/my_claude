---
name: processo
description: Modo processo, para quando a dor está no processo de trabalho e não na ferramenta. Mapeia a árvore decisória AS-IS, valida com o Navegador e redesenha o TO-BE classificando as restrições em fixas, revisáveis e falsas; a saída separa o que se resolve por ato interno do que pede software, e vira cartões pela /demanda. Use quando alguém falar em retrabalho, fluxo, tramitação, alçada, "sempre foi assim" ou digitar /processo.
---

# /processo: mapa decisório AS-IS e TO-BE

Entender **como o trabalho é decidido hoje** e redesenhá-lo, antes de decidir se a solução é software. Pressupõe o passo "Problema" do método cumprido: o problema aprovado no documento de negócio (ficha do `CLAUDE.md`). Até o TO-BE aprovado, o Piloto só lê e escreve o registro do processo.

São mapas **decisórios**, não fluxogramas de tarefa: o objeto é *onde alguém decide algo*, quem decide, com base em quê e o que muda em cada ramo. Tarefa executória entra só como consequência de um nó. **Nunca entregue os dois mapas de uma vez:** TO-BE sobre AS-IS não validado propaga erro.

## Quando usar e quando não usar

- **Usar:** a dor é de processo (retrabalho, passagens de mão, alçada, prazo); antes de decidir automatizar qualquer coisa; quando "sempre foi assim" aparece como justificativa de uma etapa.
- **Não usar:** processo já mapeado e estável: ir direto à `/demanda`. Solução desconhecida mas processo irrelevante é `/descoberta`. Incerteza apenas técnica de solução já escolhida é **spike**.
- **Combina com a `/descoberta`, não compete:** a `/processo` responde *como o trabalho é decidido hoje*; a `/descoberta`, *qual solução construir*.

## Papéis

- **O Piloto (Claude)** mapeia, classifica restrições, redesenha e instrumenta.
- **O Navegador** confirma que o AS-IS reflete a operação real e decide sobre revisar norma interna.
- O Piloto **nunca inventa fundamento normativo**: artigo, cláusula ou política não verificada vai para as ressalvas como `[a confirmar]` e nunca sustenta um redesenho.

O registro fica em `docs/processo-<tema>.md`, atualizado ao fim de cada etapa e versionado no Git.

## Etapa 0: Enquadramento

Atores, restrições, objetivo e critérios de sucesso são **lidos do documento de negócio**, não levantados de novo. Falta estabelecer:

- **Recorte:** o evento que inicia e a entrega que encerra. Sem os dois extremos, não comece.
- **Fontes de verdade:** leis, contratos, políticas, normas internas, manuais, acordos de prazo, documentação de sistemas.
- **Sistemas em uso** em cada etapa.
- **Maturidade de medição:** há linha de base de tempo, custo ou volume? Se não, o TO-BE terá indicadores *propostos*, não metas calibradas.

**Economia:** havendo informação suficiente, avance declarando as "Premissas de leitura". Faltando algo essencial, faça **uma única rodada de no máximo 3 perguntas**, as mais críticas primeiro.

## Classificação de restrições (o eixo do método)

Toda restrição citada recebe uma das três classificações. É isso que separa um mapa útil de um desenho de caixinhas.

| Tipo | O que é | Tratamento |
|------|---------|-----------|
| **R1, fixa** | Lei, regulamento externo, contrato vigente, limite físico, competência indelegável | Inviolável. O TO-BE é 100% conforme. |
| **R2, revisável** | Norma interna, política da casa, desenho organizacional, ferramenta adotada | É a alavanca do redesenho. Toda mudança proposta nomeia qual R2 precisa mudar. |
| **R3, falsa** | Hábito, "sempre foi assim", interpretação conservadora sem base, legado tratado como imutável | **Sinalizar explicitamente.** É a fonte mais barata de ganho. |

No AS-IS, classifique. No TO-BE, respeite R1, redesenhe R2, elimine R3.

## Etapa 1: Mapa AS-IS

Descreve, **não** prescreve. Nada de melhorias aqui; dores entram só quando relatadas pelo Navegador ou por quem opera. Se você se pegou escrevendo "deveria", errou de artefato.

Para cada nó (D1, D1.1, D2...): **(a)** a pergunta decisória, em forma de pergunta; **(b)** as ramificações em "SE... ENTÃO..."; **(c)** o decisor competente; **(d)** o fundamento e sua classificação R1, R2 ou R3; **(e)** o artefato que registra a decisão; **(f)** a consequência de cada ramo; **(g)** quando conhecidos, tempo médio, volume, retrabalho e dor relatada.

Estrutura do documento: **Resumo** (3 a 6 itens: quantos nós, quantas macroetapas, onde estão os gargalos), **Achados** (o que muda o entendimento do processo), **Detalhes** (macroetapas com seus nós), **Diagrama Mermaid**, **Tabela-resumo** (`nº | pergunta decisória | alternativas | decisor | fundamento (R1/R2/R3) | artefato gerado`) e **Ressalvas** (o que não foi confirmado, fonte secundária, o que validar com quem opera).

**Gate:** o Navegador confirma que o mapa reflete a operação real.

## Etapa 2: Mapa TO-BE

Respeita R1, altera R2, elimina R3. Pode renumerar, fundir ou eliminar nós do AS-IS. Antes de fechar, percorra `references/padroes.md` e justifique o que aplicou, e o que descartou e por quê.

Para cada nó: **(a)** o que muda em relação ao AS-IS e por quê; **(b)** o decisor proposto, preservando competências indelegáveis; **(c)** automação e sistema de apoio; **(d)** ponto de validação humana obrigatória; **(e)** indicador do nó; **(f)** o fundamento da mudança e qual R2 precisa ser revista.

Obrigatórios no documento:

- **Gate de triagem na entrada** (prefixo `G`): trilhos por complexidade, valor ou risco, rito simplificado ou rito completo, sempre que o volume justificar.
- **Roteiro em ondas:** 0 a 3 meses (ganhos rápidos), 3 a 12 (estruturação), 12 ou mais (transformação), separando o que depende só de ato interno, o que exige articulação externa e o que exige tecnologia. Cada onda termina com um **critério de disparo** para a seguinte.
- **Normas internas a revisar** e **competências indelegáveis preservadas**, ambas nominalmente e com fundamento.
- **Tabela-resumo:** `nº | pergunta decisória | o que muda | decisor proposto | automação | validação humana | indicador | fundamento`.

**Gate:** TO-BE aprovado.

## Convenções dos mapas

- **Numeração hierárquica:** D1, D1.1, D1.2, D2... Gates recebem o prefixo `G`.
- **Ramificações sempre em "SE... ENTÃO..."**, nunca em prosa corrida.
- **Mermaid:** `flowchart TD`, um `subgraph` por macroetapa. Decisões em `{}`, ações em `[]`, início e fim em `([])`. Rótulos sem acento e sem `(`, `)`, `:`, `%`, `/` dentro dos colchetes (use hífen); esses caracteres quebram o parser. **O diagrama precisa compilar.** Modelo mínimo:

  ```mermaid
  flowchart TD
    subgraph Triagem
      I([Solicitacao recebida]) --> G1{Valor acima do limite de dispensa}
      G1 -->|SE sim ENTAO rito completo| D1{Autoridade competente autoriza}
      G1 -->|SE nao ENTAO rito simplificado| A1[Registrar dispensa - art 75 inciso II]
    end
    D1 -->|SE autoriza ENTAO segue| F([Contratacao formalizada])
  ```
- **Fundamentação precisa:** cite artigo, inciso ou cláusula, nunca "a legislação prevê".
- **Fontes** listadas ao final, priorizando a primária (a norma, o contrato, o manual) sobre comentário secundário.
- **Havendo ferramenta de busca**, verifique se a norma citada continua vigente e se valores e limites foram atualizados; não confie na memória para número que muda por ato anual.

## Antipadrões

- **AS-IS contaminado:** descrever o processo já com as melhorias embutidas.
- **Indicador sem linha de base:** sem medição hoje, diga que a meta será calibrada depois de medir; não invente alvo numérico com ar de precisão.
- **Automação sem volume:** automatizar nó que roda 4 vezes por ano é custo, não ganho. Justifique por frequência e esforço.
- **Redesenho que viola R1:** proposta que dependa de mudar norma externa é marcada como tal e vai para a onda 3.
- **Nó sem decisor:** se ninguém decide, não é nó, é tarefa.
- **Diagrama que não compila.**

## Saída: ponte para o backlog

Com o TO-BE aprovado, o Piloto separa os nós redesenhados em três destinos:

1. **Ato interno:** revisão de R2 ou eliminação de R3, sem software. É o resultado mais barato que existe. Quando a entrega do projeto é o próprio processo (modelo processo), estes nós viram os pacotes de mudança, um cartão cada; nos outros casos, saem como lista nominal de normas a revisar.
2. **Software com solução clara:** cada nó automatizado vira um cartão pela `/demanda`, com o indicador do nó no "Como saberemos que funcionou".
3. **Software com solução não clara:** `/descoberta`, levando o nó reformulado como "Como poderíamos...?".

Feche `docs/processo-<tema>.md` com o AS-IS validado, o TO-BE, o roteiro e a bifurcação, e registre a decisão no documento de negócio. Sendo a entrega software, o TO-BE aprovado é a fonte da documentação do processo de negócio na primeira entrega: escreva-a a partir daqui, não do zero.
