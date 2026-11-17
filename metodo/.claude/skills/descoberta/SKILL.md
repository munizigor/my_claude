---
name: descoberta
description: Modo descoberta (Design Thinking), para quando o problema está entendido mas a solução não está clara. Conduz Empatizar, Definir, Idear, Prototipar e Testar, com os papéis de Piloto e Navegador explícitos; a saída vira cartões pela /demanda e alimenta o documento de negócio. Use quando alguém disser "não sei qual solução", "vamos explorar", "descoberta" ou digitar /descoberta.
---

# /descoberta: qual solução construir

Processo para descobrir **qual** solução construir, antes do backlog. Pressupõe o passo "Problema" do método cumprido: o problema está aprovado no documento de negócio (ficha do `CLAUDE.md`); o que falta é a solução. Até o gate final, o Piloto só lê e escreve o registro da descoberta e os protótipos descartáveis da Etapa 4.

## Quando usar e quando não usar

- **Usar:** problema validado mas sem solução óbvia; várias abordagens plausíveis; dor do usuário mal compreendida.
- **Não usar:** solução já conhecida ou determinada por restrição externa (contrato, norma): ir direto à `/demanda`. Incerteza apenas *técnica* de uma solução já escolhida é caso de **spike** (um cartão de protótipo com tempo limitado), não de descoberta. Dor no processo de trabalho, e não na ferramenta: `/processo`.

## Papéis

- **O Piloto (Claude) facilita:** prepara roteiros, consolida dados, gera protótipos, aponta vieses e lacunas.
- **O Navegador faz o campo:** fala com usuários reais, testa protótipos com eles, traz os dados de volta.
- O Piloto **nunca inventa dado de usuário**. Persona ou dor sem entrevista é hipótese e fica marcada como `[hipótese]` até ser validada na Etapa 5.

O registro fica em `docs/descoberta-<tema>.md`, atualizado ao fim de cada etapa e versionado no Git como o resto do projeto.

## Etapa 1: Empatizar

- O Piloto entrega o roteiro de entrevista (5 a 7 perguntas abertas, sem induzir solução), quem entrevistar ou observar e o que registrar.
- O Navegador traz as notas das conversas e observações; bruto serve.
- O Piloto consolida dores, ganhos e citações relevantes, separando fato de interpretação.
- Sem acesso a usuários: registrar como restrição e seguir com hipóteses explícitas; a validação fica concentrada na Etapa 5.
- **Gate:** o Navegador confirma que as dores refletem a realidade.

## Etapa 2: Definir

- Sintetizar o ponto de vista: "**[usuário]** precisa de **[necessidade]** porque **[insight]**". A necessidade é do usuário, não uma funcionalidade.
- Uma persona (duas, se houver papéis realmente distintos), baseada nos dados da Etapa 1.
- Reformular o desafio como "**Como poderíamos...?**", amplo o bastante para admitir várias soluções e restrito o bastante para ser atacável.
- **Gate:** ponto de vista e "Como poderíamos...?" aprovados por escrito.

## Etapa 3: Idear

- O Piloto propõe de 5 a 8 conceitos de solução genuinamente distintos, uma frase cada, incluindo um conservador, um radical e um sem tecnologia nova (só mudança de processo ou de comportamento). O Navegador acrescenta os dele.
- Sem julgamento durante a geração. Depois, avaliar juntos: impacto na dor, esforço e risco. O Navegador escolhe um ou dois conceitos para prototipar.
- **Gate:** conceitos escolhidos.

## Etapa 4: Prototipar

- Protótipo é o artefato **mais barato** que testa a hipótese central do conceito: fluxo em texto, página HTML estática, planilha, linha de comando com dados fixos. Descartável por definição; não é o começo do produto.
- Antes de construir, declarar: "este protótipo testa a hipótese X". Tempo limitado por protótipo: o Piloto sugere, o Navegador decide.
- **Gate:** protótipo pronto e roteiro de teste (tarefas para o usuário executar sozinho, sem tutorial).

## Etapa 5: Testar

- O Navegador testa com usuários reais (ou com quem decide); o Piloto fornece o roteiro e as perguntas de observação ("onde travou?", "o que esperava que acontecesse?").
- O Piloto consolida por hipótese: **validada**, **refutada** ou **inconclusiva**. Refutada é aprendizado barato: voltar à Etapa 3, ou à 2 se a própria dor estava errada.
- **Gate final:** o Navegador declara por escrito a solução escolhida e por quê.

## Saída: ponte para o backlog

Com o gate final aprovado, o Piloto:

1. Fecha `docs/descoberta-<tema>.md` com o ponto de vista, a persona, os conceitos descartados (e por quê) e a solução validada.
2. Atualiza o documento de negócio: hipóteses validadas ou refutadas, e a decisão tomada, com data.
3. Propõe os primeiros cartões pela `/demanda`, começando pelo menor incremento útil de ponta a ponta. A hipótese validada vira o "Como saberemos que funcionou" desses cartões.
