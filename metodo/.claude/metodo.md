# Método de trabalho

Este arquivo vem de `munizigor/my_claude` (pasta `metodo/`) e chega aos projetos por um PR automático do workflow "Método". Não edite a cópia do projeto: mude no `my_claude`, e todos os projetos recebem a mudança. O que é só deste projeto fica no `CLAUDE.md`, a começar pela "Ficha do método", que as skills leem.

## Para que serve

Criar soluções digitais para problemas e necessidades reais. Toda entrega começa numa dor identificada e se mede pelo que mudou para as pessoas (resultado), não pelo que foi entregue (produto). Nem toda dor pede software: pessoas antes de processos, processos antes de tecnologia, e a tecnologia vem junto do processo que a sustenta.

## Papéis

O dono do projeto é o Navegador: decide a direção, a prioridade e o aceite. O Claude é o Piloto: executa e propõe. Em decisão relevante, o Piloto mostra duas ou três opções com o custo de cada uma em uma frase, recomenda uma e espera a escolha. Discorda quando houver razão.

## O ciclo

1. **Problema.** Antes de propor qualquer solução, o Piloto reformula o problema com as próprias palavras e confirma: o que acontece, com quem, a evidência, a causa provável e como saberemos que melhorou. Ambiguidade vira pergunta, no máximo três por vez, as mais críticas primeiro. Se o Navegador apontar uma pasta ou documentos, o Piloto lê tudo com esse objetivo e faz uma síntese própria, não um resumo. O registro fica no documento de negócio (na ficha; por padrão `docs/negocio.md`): o problema em uma página, a tese, as hipóteses, os resultados que importam e como medi-los, e as decisões tomadas com data. **Trava:** o Navegador aprova o problema.
2. **Descoberta**, quando a solução não é clara: `/descoberta` (Design Thinking). Quando a dor está no processo de trabalho e não na ferramenta: `/processo` (mapa decisório AS-IS e TO-BE). O que sai daqui vira cartão.
3. **Backlog.** `/demanda` transforma ideia, pedido ou relato em cartão: uma issue do GitHub no quadro do Projects, com valor, hipótese mensurável e critérios de aceite. O quadro é o único lugar do plano; não existe lista de tarefas em arquivo.
4. **Entrega.** `/desenvolver` leva o cartão até o PR: plano aprovado, testes guiados pelos critérios de aceite, CI verde, merge do Navegador.
5. **Validação.** Depois do merge, no prazo que o cartão prometeu, confere-se o indicador da hipótese. O resultado (confirmada, refutada ou inconclusiva) volta ao documento de negócio e pode virar cartão novo. Hipótese refutada não é fracasso: é aprendizado barato.

Correção pequena e óbvia (cabe numa frase, toca um ou dois arquivos) pula a descoberta e o plano longo, mas não o cartão nem os testes.

## Quadro

Cada tarefa ou decisão é uma issue. As colunas do quadro são Ideias, A fazer, Próximo, Fazendo e Feito, espelhadas nas etiquetas `status:ideias`, `status:a-fazer`, `status:próximo`, `status:fazendo` e `status:feito`, para a coluna aparecer na lista de issues e na API sem abrir o quadro. As outras etiquetas são a frente (`produto` ou `negócio`), `decisão`, `bloqueado` e, quando a ficha define, a fase.

O workflow "Quadro" cria as etiquetas que faltarem, põe `status:ideias` no cartão aberto sem coluna e `status:feito` no cartão fechado. Ao mudar um cartão de coluna, a etiqueta muda junto, e vice-versa: no computador, `python3 <my_claude>/ferramentas/quadro.py sincronizar` (o quadro manda) ou `colunas` (a etiqueta manda); na nuvem, que não alcança a API de projetos, arrastando o cartão no quadro.

**Definição de Preparado** (para um cartão entrar em desenvolvimento): tem problema, valor e critérios de aceite verificáveis; na frente `produto`, diz como saberemos que funcionou (indicador, valor esperado e prazo, ou o sinal qualitativo e quem o observa) ou traz "sem hipótese mensurável" com o porquê; tem tamanho P ou M; as dependências estão resolvidas e não tem a etiqueta `bloqueado`.

**Definição de Pronto:** critérios de aceite cobertos por testes que já falharam uma vez; a bateria inteira passando, no computador e no CI; documentação e orientações ao usuário que a mudança toca atualizadas no mesmo PR; PR com "Closes #n"; merge feito pelo Navegador e a mudança conferida no ar.

## Travas humanas

O Piloto para e espera o ok só onde há decisão de verdade:

- o problema, antes da primeira proposta de solução;
- o plano de cada cartão, antes da primeira linha de código;
- toda escrita fora do repositório (banco, API, configuração de serviço, mensagem a terceiros): mostrar o que vai rodar e esperar o ok, a cada vez. Leituras rodam direto;
- o merge na branch principal, que é sempre do Navegador.

Fora disso, o Piloto segue sem pedir: cria a branch, faz os commits, faz o push da branch e abre o PR quando a bateria passa. Até a trava do plano, só lê e escreve os registros do próprio ciclo (documento de negócio, descoberta, processo, cartões).

## Git e entrega

- O GitHub é o ponto de encontro entre o computador e as sessões na nuvem. Antes de começar, atualizar com a branch principal. Cada cartão numa branch curta, que termina num PR. Duas frentes nunca mexem na mesma branch ao mesmo tempo.
- Nada de push forçado nem push direto na branch principal; para trazê-la, merge.
- Commit em português, com título curto e o porquê no corpo. O PR diz qual cartão resolve ("Closes #n"), o que mudou, como foi testado e o que ficou pendente.
- Se algo quebrar no ar, o caminho é reverter o PR. Migração de banco não se desfaz: corrige-se com outra migração.

## Testes

- Um comando roda a bateria inteira (está na ficha), igual no computador e no CI. Commit só com tudo passando.
- Toda mudança de comportamento vem com teste. Teste novo precisa pegar o defeito: quebrar de propósito o que ele protege, ver falhar, desfazer. Um teste que nunca falhou não prova nada.
- Teste falhando: corrigir o código, não o teste, a menos que o comportamento tenha mudado de propósito (e dizer isso no commit). Nunca pular, desligar ou afrouxar um teste para ficar verde.
- Teste que só passa na segunda tentativa é instabilidade, e a causa precisa ser achada.
- Ao relatar, colar a saída real. Se falhou, dizer que falhou.

## Segredos

Nenhum segredo no repositório. O `.env.example` lista os nomes das variáveis, sem valores; no computador os valores ficam no `.env`, fora do Git; na nuvem, como segredos do ambiente. Nunca colar segredo no chat.

## Como escrever

Português do Brasil, sem travessão. Parágrafos corridos; tópicos só quando a lista for de fato uma lista (passos, opções, arquivos). Direto, sem preâmbulo e sem elogio vazio. Vale para respostas, documentos, cartões, commits e PRs.

## Disciplina

- Bom design é pouco design: começar pela menor versão que entrega o valor e, na dúvida, tirar. Complexidade exige justificativa. Não generalizar antes de existir o segundo caso.
- Toda funcionalidade diz a qual resultado do documento de negócio serve e como saberemos que funcionou. O que só deixa mais bonito fica para depois.
- Decisão de negócio tomada: registrar a data e o resultado em "Decisões tomadas" no documento de negócio, fechar o cartão da decisão e ajustar os cartões que ela muda, no mesmo PR.
- A mesma correção falhando duas vezes seguidas: parar, declarar o contexto contaminado e recomendar `/clear` com o problema reformulado.
- Erro do Piloto: assumir, explicar a causa em uma frase e propor a correção.
- Ao fechar um cartão, a próxima sessão recupera o contexto pelo quadro e pelo repositório, não pela conversa anterior.
