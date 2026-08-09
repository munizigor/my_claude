---
name: descoberta
description: Modo descoberta (Design Thinking) — usar quando o problema é entendido mas a solução não é clara. Conduz Empatizar → Definir → Idear → Prototipar → Testar com papéis Piloto/Navegador explícitos; a saída alimenta a Fase 2 do ciclo e o CLAUDE.md do projeto.
---

# Modo Descoberta (Design Thinking)

Processo para descobrir **qual** solução construir, antes do ciclo normal de
trabalho. Roda em Plan Mode (somente leitura). Pressupõe a Fase 1 cumprida:
o problema já está validado; o que falta é a solução.

## Quando usar / não usar

- **Usar:** problema validado mas sem solução óbvia; múltiplas abordagens
  plausíveis; dor do usuário mal compreendida.
- **Não usar:** solução já conhecida ou determinada por restrição externa
  (contrato, norma) — ir direto ao ciclo normal. Incerteza apenas *técnica*
  de uma solução já escolhida é caso de **spike** (Fase 3), não de descoberta.

## Papéis

- **Piloto (Claude) facilita:** prepara roteiros, consolida dados, gera
  protótipos, aponta vieses e lacunas.
- **Navegador (usuário) faz o campo:** fala com usuários reais, testa
  protótipos com eles, traz os dados de volta.
- O Piloto **nunca inventa dados de usuário**. Persona ou dor sem entrevista
  é hipótese e fica marcada como `[hipótese]` até ser validada na Etapa 5.

Todo registro vai em `.claude/DESCOBERTA.md` na raiz do projeto, atualizado
ao fim de cada etapa (mesmo padrão do `.claude/PLANO.md`).

## Etapa 1 — Empatizar

- Piloto entrega: roteiro de entrevista (5–7 perguntas abertas, sem induzir
  solução), quem entrevistar/observar e o que registrar.
- Navegador traz: notas das conversas e observações (bruto serve).
- Piloto consolida: dores, ganhos e citações relevantes, separando fato de
  interpretação.
- Sem acesso a usuários? Registrar como restrição e seguir com hipóteses
  explícitas — a validação fica concentrada na Etapa 5.
- **Gate:** Navegador confirma que as dores refletem a realidade.

## Etapa 2 — Definir

- Sintetizar em POV: "**[usuário]** precisa de **[necessidade]** porque
  **[insight]**". Necessidade é do usuário, não uma feature.
- 1 persona (2 se houver papéis realmente distintos), baseada nos dados da
  Etapa 1.
- Reformular o desafio como "**Como poderíamos...?**" — amplo o bastante
  para admitir várias soluções, restrito o bastante para ser atacável.
- **Gate:** POV e "Como poderíamos...?" aprovados por escrito.

## Etapa 3 — Idear

- Piloto propõe 5–8 conceitos de solução genuinamente distintos (incluindo
  1 conservador e 1 radical), uma frase cada. Navegador acrescenta os dele.
- Sem julgamento durante a geração. Depois, avaliar juntos: impacto na dor ×
  esforço × risco. Navegador escolhe 1–2 conceitos para prototipar.
- **Gate:** conceitos escolhidos.

## Etapa 4 — Prototipar

- Protótipo = o artefato **mais barato** que testa a hipótese central do
  conceito: fluxo em texto, mockup HTML estático, CLI fake com dados
  hardcoded, planilha. Descartável por definição — não é o início do produto.
- Antes de construir, declarar: "este protótipo testa a hipótese X".
  Timebox por protótipo (Piloto sugere, Navegador decide).
- **Gate:** protótipo pronto + roteiro de teste (tarefas para o usuário
  executar sozinho, sem tutorial).

## Etapa 5 — Testar

- Navegador testa com usuários reais (ou stakeholders); Piloto fornece o
  roteiro e as perguntas de observação ("onde travou?", "o que esperava que
  acontecesse?").
- Piloto consolida por hipótese: **validada**, **refutada** ou
  **inconclusiva**. Refutada não é fracasso — é aprendizado barato: voltar
  à Etapa 3 (ou à 2, se a própria dor estava errada).
- **Gate final:** Navegador declara por escrito a solução escolhida e por quê.

## Saída — ponte para o ciclo normal

Com o gate final aprovado, o Piloto entrega:

1. `.claude/DESCOBERTA.md` fechado: POV, persona, conceitos descartados
   (e por quê) e solução validada.
2. Insumos para o `CLAUDE.md` do projeto: o Contexto de Negócio (3 linhas)
   sai direto do POV + persona.
3. Handoff para a **Fase 2** do ciclo normal: as hipóteses validadas viram
   as primeiras user stories.

O ciclo recomeça na Fase 2 (Planejamento) — a Fase 1 já foi cumprida pela
descoberta.
