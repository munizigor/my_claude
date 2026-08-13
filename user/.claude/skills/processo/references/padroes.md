# Catálogo de padrões de redesenho

Consultado na Etapa 2 da skill `/processo`. Percorra a lista inteira: aplique o
que couber justificando, e registre o que descartou e por quê — descarte
silencioso vira ponto cego. A coluna "R2 típica" indica qual norma interna
costuma travar o padrão; é ali que a proposta de mudança precisa mirar.

| Padrão | Quando se aplica | R2 típica que trava |
|---|---|---|
| **Triagem por complexidade/valor** | Volume alto com casos de risco muito desigual passando pelo mesmo rito | Norma que fixa rito único, sem faixas |
| **Padronização** | Objeto recorre com variação pequena (mesmo tipo de contrato, pedido, parecer) | Exigência de análise individual mesmo para objeto idêntico |
| **Decisão por exceção** | O caso típico é aprovado em >90% das vezes e a análise não muda o resultado | Norma que exige manifestação expressa para todo caso |
| **Antecipação de gates** | A verificação que mais reprova está no fim da fila, depois de trabalho já feito | Sequência de etapas fixada em manual ou sistema |
| **Paralelização** | Etapas sequenciais que não consomem a saída uma da outra | Fluxo linear cristalizado em workflow de sistema |
| **Rebaixamento da alçada** | Instância alta decide caso de baixo valor/risco por hábito, não por competência | Tabela de alçada desatualizada; delegação nunca formalizada |
| **Eliminação de handoffs** | Demanda atravessa várias unidades para voltar ao ponto de origem | Desenho organizacional por especialidade, não por fluxo |
| **Automação com validação humana** | Alta frequência × esforço, com decisão que exige assinatura de alguém | Exigência de elaboração manual onde a lei só pede a assinatura |
| **Poka-yoke na origem** | Retrabalho concentrado em erro de preenchimento que só aparece adiante | Formulário livre; sistema que aceita entrada incompleta |
| **Agregação/consolidação** | Demandas de mesma natureza tratadas uma a uma ao longo do ano | Cultura de atendimento por demanda, sem calendário |
| **Acordos de longo prazo** | N ciclos completos por ano para o mesmo objeto | Preferência por contratação pontual |
| **Instrumentação** | Nenhum nó tem prazo visível nem dono de indicador | Ausência de SLA formal; painel inexistente |

## Regras de aplicação

- **Automação exige volume.** Frequência × esforço primeiro; se o nó roda 4
  vezes por ano, automatizar é custo. Padronização e poka-yoke normalmente
  entregam mais barato que automação.
- **Rebaixar alçada nunca atravessa competência indelegável (R1).** Se a
  competência é do titular por lei, o padrão a usar é decisão por exceção — não
  delegação.
- **Antecipar gate antes de paralelizar.** Paralelizar etapas que serão
  descartadas por uma reprovação tardia multiplica o desperdício.
- **Todo padrão aplicado gera KPI.** Sem indicador, o redesenho não é
  verificável e a onda seguinte não tem benchmark de disparo.
