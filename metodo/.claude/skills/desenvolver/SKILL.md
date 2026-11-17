---
name: desenvolver
description: Leva um cartão do quadro (issue do GitHub) até o código entregue, com testes, PR e conferência no ar, seguindo o método (.claude/metodo.md) e a ficha do projeto no CLAUDE.md. "/desenvolver 111" desenvolve o cartão 111; "/desenvolver" sem número monta a esteira, escolhendo um ou mais cartões para fazer em sequência. Use quando alguém pedir para desenvolver, implementar ou "tocar" um cartão.
---

# /desenvolver: do cartão ao código no ar

A `/demanda` transforma uma ideia em cartão; esta skill transforma o cartão em código entregue. As regras gerais (travas, git, testes, segredos) estão em `.claude/metodo.md`, e o que é deste projeto (comando de teste, onde ficam os testes, escritas que pedem ok, conferências antes do PR, como conferir no ar) está na "Ficha do método" do `CLAUDE.md` e nas seções seguintes dele. Esta skill dá a ordem e aponta para essas regras, sem repeti-las.

**Travas humanas, sempre.** O plano espera o ok do Navegador antes de qualquer código. Toda escrita fora do repositório espera o ok. Push e PR saem direto quando a bateria passa; o merge é sempre do Navegador.

## Com ou sem número

- **`/desenvolver <n>`:** desenvolve o cartão `#n`, a partir do passo 1.
- **`/desenvolver` sem número:** monta a esteira antes de tudo.
  1. Leia o documento de negócio e os cartões abertos. Priorize os de `status:fazendo` esquecidos, depois `status:próximo`, depois `status:a-fazer`; dentro disso, o que tem prazo e o que destrava outros cartões.
  2. Proponha uma esteira curta, de um a três cartões, em ordem, com uma linha de porquê para cada um e a dependência entre eles. Cartões da frente `negócio` não entram: não são código.
  3. Espere o ok da esteira. Depois, cada cartão segue os passos abaixo, um de cada vez, cada um na sua branch e no seu PR. Um cartão que depende de outro ainda não mergeado espera o merge; não empilhe branches.

## Passos para cada cartão

### 1. Pronto para começar

Leia o cartão inteiro (corpo e comentários) e confira a Definição de Preparado do método. Se faltar algo, não comece: sem critérios de aceite ou sem a hipótese, proponha completá-los pela `/demanda`; tamanho G, proponha a divisão; dependência aberta, diga qual e pare.

### 2. Abrir o trabalho

- Atualize com a branch principal e crie uma branch curta só para este cartão, com um nome que diga o que ela faz.
- Passe o cartão para `status:fazendo` e lembre que a coluna do quadro precisa acompanhar (método, seção "Quadro").

### 3. Planejar e esperar o ok

Leia o código que o cartão toca antes de propor qualquer coisa. Mostre um plano curto:

- o que muda, arquivo por arquivo, em poucas linhas;
- **cada critério de aceite e o teste que vai prová-lo**, no lugar que a ficha indica;
- se há mudança de banco, dado novo de usuário, escrita fora do repositório ou mudança visível para o usuário;
- o que fica fora, se o cartão der margem a crescer.

Espere o ok. Se o plano mudar muito no caminho, mostre de novo.

### 4. Testes guiados pelos critérios de aceite

Escreva os testes de cada critério junto com o código. Depois de implementar, **quebre de propósito o que cada teste novo protege, veja falhar e desfaça**. Um teste que nunca falhou não prova nada.

### 5. Implementar com segurança

- Dado novo tem regra de acesso e teste de quem lê e quem grava. Nada de segredo no repositório.
- Siga as regras próprias do projeto que a ficha e o `CLAUDE.md` listam (o que não vai para o ar, arquivos gerados, termos de uso, separação de camadas).
- Faça só o necessário para o cartão. Dívida encontrada no caminho vira cartão, não desvio.

### 6. Banco e serviços externos, quando houver

- Mudança de estrutura é arquivo novo de migração, nunca edição de uma já aplicada, e de preferência só acrescenta: o que está no ar precisa continuar funcionando com o banco novo. Remover o que ficou velho é outro cartão.
- Confira o histórico do ambiente antes de aplicar, mostre o que vai rodar e espere o ok. Aplique primeiro no ambiente de teste, se a ficha tiver um, depois na produção.
- A mudança no banco vai para a produção **antes** do merge do código que depende dela.

### 7. Revisar antes do commit

- A bateria inteira passando (comando na ficha); commit só assim.
- Faça as conferências que a ficha lista para antes do PR (design system, protótipo de referência, guia do usuário, tour, documentação).
- Releia o próprio diff como um revisor faria; num cartão M, use também o `/code-review`.

### 8. Entregar

- Commit em português, com título curto e o porquê no corpo, terminando com "Closes #n".
- Faça o push da branch e abra o PR sem esperar o ok, só com a bateria passando inteira. O PR leva "Closes #n" na descrição, o que mudou, como foi testado e o que fica pendente.
- Depois do push, confira os checks do PR; check vermelho se corrige na mesma branch. Mudança visível: confira a prévia antes de recomendar o merge, quando o projeto tiver prévia. Nunca mergear o PR.

### 9. Depois do merge

- Confira a publicação e o que ficou no ar, do jeito que a ficha descreve: o que o cartão mudou está lá, e o que não deve ir para o ar continua fora.
- Se algo quebrar no ar, o caminho é reverter o PR.

### 10. Relato

Termine com: o que mudou, quais testes cobrem cada critério de aceite, a hipótese do cartão e a data do merge (para a validação saber o que conferir e desde quando), o que foi conferido no ar e o que ficou pendente com o Navegador (merge, coluna do quadro, uma decisão). Na esteira, diga qual é o próximo cartão e espere o sinal para seguir.
