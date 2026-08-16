---
name: processo
description: Modo processo — usar quando a dor está no processo de negócio, não no software. Mapeia a árvore decisória AS-IS, valida com o Navegador e redesenha o TO-BE classificando restrições em fixas, revisáveis e falsas; a saída separa o que se resolve por ato interno do que exige software.
---

# Modo Processo (Mapa Decisório AS-IS / TO-BE)

Entender **como o trabalho é decidido hoje** e redesenhá-lo, antes de decidir se
a solução é software. Roda em Plan Mode (somente leitura, fora os artefatos do
ciclo). Pressupõe o
**Entender** cumprido: `.claude/PROBLEMA.md` aprovado.

São mapas **decisórios**, não fluxogramas de tarefa: o objeto é *onde alguém
decide algo* — quem decide, com base em quê, o que muda em cada ramo. Tarefa
executória entra só como consequência de um nó. **Nunca entregue os dois mapas
de uma vez:** TO-BE sobre AS-IS não validado propaga erro.

## Quando usar / não usar

- **Usar:** a dor é de processo (retrabalho, handoffs, alçada, prazo); antes de
  decidir automatizar qualquer coisa; quando "sempre foi assim" aparece como
  justificativa de uma etapa.
- **Não usar:** processo já mapeado e estável — ir direto ao ciclo. Solução
  desconhecida mas processo irrelevante é `/descoberta`. Incerteza apenas
  *técnica* de solução já escolhida é **spike**.
- **Combina com `/descoberta`, não compete:** `/processo` responde *como o
  trabalho é decidido hoje*; `/descoberta`, *qual solução construir*.

## Papéis

- **Piloto (Claude)** mapeia, classifica restrições, redesenha e instrumenta.
- **Navegador (usuário)** confirma que o AS-IS reflete a operação real e decide
  sobre revisar norma interna.
- O Piloto **nunca inventa fundamento normativo**: artigo, cláusula ou política
  não verificada vai para Caveats como `[a confirmar]`, nunca sustenta um
  redesenho.

Registro em `.claude/PROCESSO.md`, atualizado ao fim de cada etapa (mesmo padrão
do `.claude/PLANO.md`).

## Etapa 0 — Enquadramento

Atores, restrições, objetivo e critérios de sucesso são **lidos de
`.claude/PROBLEMA.md`** — não os levante de novo. Falta estabelecer:

- **Recorte:** o evento que inicia e a entrega que encerra. Sem os dois
  extremos, não comece.
- **Fontes de verdade:** leis, contratos, políticas, normas internas, manuais,
  SLAs, documentação de sistemas.
- **Sistemas em uso** em cada etapa.
- **Maturidade de medição:** há baseline de tempo/custo/volume? Se não, o TO-BE
  terá KPIs *propostos*, não metas calibradas.

**Economia:** havendo informação suficiente, avance declarando as "Premissas de
leitura". Faltando algo essencial, faça **uma única rodada de no máximo 3
perguntas**, as mais críticas primeiro.

## Classificação de restrições (o eixo do método)

Toda restrição citada recebe uma das três classificações. É isso que separa um
mapa útil de um desenho de caixinhas.

| Tipo | O que é | Tratamento |
|------|---------|-----------|
| **R1 — Fixa** | Lei, regulamento externo, contrato vigente, limite físico, competência indelegável | Inviolável. O TO-BE é 100% conforme. |
| **R2 — Revisável** | Norma interna, política da casa, desenho organizacional, ferramenta adotada | É a alavanca do redesenho. Toda mudança proposta nomeia qual R2 precisa mudar. |
| **R3 — Falsa** | Hábito, "sempre foi assim", interpretação conservadora sem base, legado tratado como imutável | **Sinalizar explicitamente.** É a fonte mais barata de ganho. |

No AS-IS, classifique. No TO-BE, respeite R1, redesenhe R2, elimine R3.

## Etapa 1 — Mapa AS-IS

Descreve, **não** prescreve. Nada de melhorias aqui; dores entram só quando
relatadas pelo Navegador. Se você se pegou escrevendo "deveria", errou de
artefato.

Para cada nó (D1, D1.1, D2…): **(a)** a pergunta decisória, em forma de
pergunta; **(b)** as ramificações em "SE… ENTÃO…"; **(c)** o decisor competente;
**(d)** o fundamento e sua classificação R1/R2/R3; **(e)** o artefato que
registra a decisão; **(f)** a consequência de cada ramo; **(g)** quando
conhecidos, tempo médio, volume, retrabalho e dor relatada.

Estrutura do documento: **TL;DR** (3–6 bullets: quantos nós, quantas
macroetapas, onde estão os gargalos) → **Key Findings** (o que muda o
entendimento do processo) → **Details** (macroetapas com seus nós) →
**Diagrama Mermaid** → **Tabela-resumo** (`nº | pergunta decisória |
alternativas | decisor | fundamento (R1/R2/R3) | artefato gerado`) →
**Caveats** (o que não foi confirmado, fonte secundária, o que validar com quem
opera).

**Gate:** o Navegador confirma que o mapa reflete a operação real.

## Etapa 2 — Mapa TO-BE

Respeita R1, altera R2, elimina R3. Pode renumerar, fundir ou eliminar nós do
AS-IS. Antes de fechar, percorra `references/padroes.md` e justifique o que
aplicou — e o que descartou e por quê.

Para cada nó: **(a)** o que muda vs. AS-IS e por quê; **(b)** o decisor
proposto, preservando competências indelegáveis; **(c)** automação e sistema de
apoio; **(d)** ponto de validação humana obrigatória; **(e)** KPI do nó;
**(f)** o fundamento da mudança e qual R2 precisa ser revista.

Obrigatórios no documento:

- **Gate de triagem na entrada** (prefixo `G`): trilhos por complexidade, valor
  ou risco — rito simplificado × rito completo — sempre que o volume justificar.
- **Roadmap em ondas:** 0–3 meses (quick wins), 3–12 (estruturação), 12+
  (transformação), separando o que depende só de ato interno, o que exige
  articulação externa e o que exige tecnologia. Cada onda termina com um
  **benchmark de disparo** para a seguinte.
- **Normas internas a revisar** e **competências indelegáveis preservadas**,
  ambas nominalmente e com fundamento.
- **Tabela-resumo:** `nº | pergunta decisória | o que muda vs AS-IS | decisor
  proposto | automação | validação humana | KPI | fundamento`.

**Gate:** TO-BE aprovado.

## Convenções dos mapas

- **Numeração hierárquica:** D1, D1.1, D1.2, D2… Gates recebem prefixo `G`.
- **Ramificações sempre em "SE… ENTÃO…"**, nunca em prosa corrida.
- **Mermaid:** `flowchart TD`, um `subgraph` por macroetapa. Decisões em `{}`,
  ações em `[]`, início/fim em `([])`. Rótulos sem acento e sem `(`, `)`, `:`,
  `%`, `/` dentro dos colchetes — use hífen; esses caracteres quebram o parser.
  **O diagrama precisa compilar.** Modelo mínimo:

  ```mermaid
  flowchart TD
    subgraph Triagem
      I([Solicitacao recebida]) --> G1{Valor acima do limite de dispensa}
      G1 -->|SE sim ENTAO rito completo| D1{Autoridade competente autoriza}
      G1 -->|SE nao ENTAO rito simplificado| A1[Registrar dispensa - art 75 inciso II]
    end
    D1 -->|SE autoriza ENTAO segue| F([Contratacao formalizada])
  ```
- **Fundamentação precisa:** cite artigo/inciso/cláusula, nunca "a legislação
  prevê".
- **Fontes** listadas ao final, priorizando a primária (a norma, o contrato, o
  manual) sobre comentário secundário.
- **Havendo ferramenta de busca**, verifique se a norma citada continua vigente
  e se valores/limites foram atualizados — não confie na memória para número
  que muda por ato anual.

## Antipadrões

- **AS-IS contaminado:** descrever o processo já com as melhorias embutidas.
- **KPI sem baseline:** sem medição hoje, diga que a meta será calibrada após
  medir — não invente alvo numérico com ar de precisão.
- **Automação sem volume:** automatizar nó que roda 4 vezes por ano é custo,
  não ganho. Justifique por frequência × esforço.
- **Redesenho que viola R1:** proposta que dependa de mudar norma externa é
  marcada como tal e vai para a onda 3.
- **Nó sem decisor:** se ninguém decide, não é nó — é tarefa.
- **Diagrama que não compila.**

## Saída — ponte para o ciclo normal

Com o TO-BE aprovado, o Piloto separa os nós redesenhados em três destinos:

1. **Ato interno** — revisão de R2 ou eliminação de R3, sem software. Nem todo
   problema pede tecnologia; este é o resultado mais barato que existe. Quando
   a entrega do projeto é o próprio processo (tipo processo), estes nós viram
   os pacotes de mudança do Planejar; caso contrário, saem do ciclo como lista
   nominal de normas a revisar.
2. **Software com solução clara** → **Planejar**: cada nó automatizado vira um
   incremento, com o KPI do nó como critério de aceitação.
3. **Software com solução não clara** → **`/descoberta`**, levando o nó
   reformulado como "Como poderíamos…?".

Feche `.claude/PROCESSO.md` com AS-IS validado, TO-BE, roadmap e a bifurcação.
Havendo destino 2, o ciclo recomeça no Planejar — o Entender já foi cumprido
antes da skill. Sendo a entrega software, o TO-BE aprovado é a fonte de
`./docs/processo-negocio.md` na release: escreva-o a partir daqui, não do zero.
