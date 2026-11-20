---
name: demanda
description: Transforma uma ideia, um pedido ou um relato solto (texto, áudio transcrito, print) num item do Product Backlog, no formato de cartão do quadro (issue do GitHub), seguindo o Guia do Scrum, o método (.claude/metodo.md) e a ficha do projeto no CLAUDE.md. Use quando alguém pedir para "colocar na fila", "abrir um cartão", "registrar uma demanda" ou digitar /demanda.
---

# /demanda: da ideia ao item do Product Backlog

Quem chama a skill traz uma ideia em qualquer forma. O trabalho é transformá-la num item do Product Backlog pronto para o refinamento: claro, ligado ao porquê do negócio, com critérios de aceite verificáveis e as etiquetas do quadro. As regras gerais estão em `.claude/metodo.md`; o que é deste projeto (documento de negócio, resultados, fases, onde se mede o uso, onde ficam os testes, regras de marca) está na "Ficha do método" do `CLAUDE.md`. Leia os dois antes de começar.

## Princípios do Scrum que esta skill segue

- **O Product Owner ordena o backlog.** A skill sugere fase e diz a que o item serve, mas não decide a prioridade: o cartão nasce em `status:ideias`, a menos que quem pediu diga outra coluna. Mover para "Próximo" é decisão do Navegador.
- **A Definição de Pronto é do time, não do item.** Ela está no método. Não repetir no cartão; os critérios de aceite ficam só com o que é específico deste item.
- **Valor antes de solução.** O cartão diz o problema e quem ganha com ele resolvido antes de dizer como fazer. Uma solução proposta entra como sugestão, aberta ao refinamento.
- **Sem formato obrigatório.** O Guia do Scrum não exige história de usuário. Use o formato abaixo.
- **Item pequeno o bastante.** Se não couber num PR só, proponha dividir em itens menores, cada um entregando valor sozinho.

## Passos

### 1. Entender a demanda

Separe o problema observado, quem sofre com ele, a evidência (relato, print, dado) e qualquer solução já imaginada. Se faltar algo essencial para escrever o problema ou o valor, pergunte antes de seguir, numa pergunta só e objetiva. Não pergunte o que dá para descobrir lendo o repositório.

Se o problema ainda não está claro, ou se há várias soluções possíveis e nenhuma óbvia, diga isso e proponha passar antes pela `/descoberta`; se a dor estiver no processo de trabalho, pela `/processo`. Um cartão de descoberta também é um cartão válido.

### 2. Conferir o contexto

- Leia o documento de negócio indicado na ficha: os resultados que importam, a tese, as hipóteses e as decisões tomadas.
- Liste os cartões abertos do repositório e procure duplicata ou cartão relacionado. Se já existir um cartão que cobre a ideia, mostre e proponha complementá-lo em vez de abrir outro.
- Diga a qual resultado o item serve e a qual hipótese, decisão ou cartão ele se liga. Se não servir a nenhum, avise e pergunte se é para registrar mesmo assim. O que só deixa mais bonito, sem mexer em nenhum resultado, vai para a fase mais tardia da ficha.
- Separe necessidade de preferência. Pergunte se o pedido atende a todos os que usam o sistema ou é gosto de quem pediu. Se for necessidade, a mudança vale para todos. Se for preferência, não mude o padrão de todos: veja se o que já existe atende (e diga como), ou proponha a personalização mínima, aplicando a outros casos uma escolha que já exista antes de criar uma nova, e só até onde personalizar faz sentido. Diga no cartão qual dos dois casos é e ponha no "Fora do escopo" o que ficou de fora.
- Aplique as regras próprias do projeto que a ficha listar para cartões (marca, design system, público).
- Quando a demanda for uma escolha de negócio a fazer (preço, contrato, quem paga), o item é uma decisão: etiqueta `decisão`, frente `negócio`, e o corpo lista as opções e o que falta saber para decidir.
- Escolha como saberemos que funcionou. A métrica sai, de preferência, de um indicador do documento de negócio ou dos dados de uso que a ficha aponta. Se a métrica depender de algo que ainda não é registrado, diga isso no cartão e inclua nos critérios de aceite registrar o que falta. Sem medida possível, use um sinal qualitativo e diga quem o observa.

### 3. Escrever o item

Título curto, no infinitivo ou como resultado, sem prefixo de tipo. Corpo nesta ordem, em parágrafos curtos e com listas só onde houver lista de fato:

```markdown
<O problema, em um ou dois parágrafos: o que acontece hoje, para quem, e a evidência (com data e origem quando houver).>

**Valor.** <A qual resultado serve e como. A hipótese, decisão ou cartão relacionado, com #n.>

**Como saberemos que funcionou.** <Hipótese: se fizermos X, o indicador Y vai de A para B em N semanas, e de onde vem o número. Sem medida possível, o sinal qualitativo que vale e quem o observa. Em correção, infraestrutura ou frente negócio: "Sem hipótese mensurável", com o porquê.>

**Proposta.** <O que fazer, como sugestão aberta ao refinamento. Pode ter uma lista curta.>

**Fora do escopo.** <O que este item não faz, para não crescer no meio do caminho. Omitir se não houver nada a dizer.>

**Critérios de aceite.**
- <Comportamento verificável, que vira teste no lugar que a ficha indica.>
- <...>

**Dependências.** <Cartões ou decisões de que depende, com #n. Omitir se não houver.>

**Tamanho.** <P (cabe numa sessão), M (um PR maior) ou G (dividir antes de começar), com uma linha de porquê.>
```

Os critérios de aceite são o coração do item: cada um descreve um comportamento observável ("o relatório sai com o total por mês"), não uma tarefa ("mudar a consulta"). Três a seis costumam bastar.

"Como saberemos que funcionou" é o par dos critérios de aceite: eles dizem se a entrega foi construída certo; a hipótese diz se era a coisa certa, e é o que se confere na validação, depois do merge. Todo cartão da frente `produto` sai com ela; quando faltar linha de base, escreva a direção e o prazo e diga que a linha de base sai da primeira medição.

### 4. Escolher as etiquetas

- **Frente:** `produto` ou `negócio`.
- **Fase:** uma das fases da ficha, quando o projeto usar fases.
- **Coluna:** `status:ideias` por padrão.
- **Extras:** `decisão` quando for uma decisão; `bloqueado` quando depender de algo que ainda não pode andar.

### 5. Mostrar e esperar o ok

Mostre o título, as etiquetas e o corpo completos, mais uma linha dizendo a que o item serve e se encontrou cartão parecido. Se sugerir dividir, mostre os itens separados. Crie a issue só depois do ok; ajuste o que for pedido e mostre de novo se a mudança for grande.

### 6. Criar e avisar

- Crie a issue com o título, o corpo e as etiquetas aprovados. Termine o corpo com o rodapé de atribuição que as instruções da sessão pedem para publicações no GitHub, quando houver.
- Responda com o link do cartão.
- Cartão novo entra em "Ideias" no quadro. Se a etiqueta de coluna for outra, lembre que a coluna precisa acompanhar (método, seção "Quadro").
- Não comece a implementar: registrar uma demanda não é pedido para fazê-la.
