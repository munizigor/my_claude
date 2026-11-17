---
name: novo-projeto
description: Começa um projeto novo no método do my_claude, ou faz um projeto existente adotar o método. Instala as skills e o contrato, copia o modelo do tipo de entrega (software ou processo), o documento de negócio e os workflows do quadro e do método, abre o PR e começa pelo passo "Problema". Use quando alguém disser "novo projeto", "começar um projeto", "aplicar o método neste repositório" ou digitar /novo-projeto.
---

# /novo-projeto: um projeto no método

O `my_claude` guarda o método (`metodo/`) e os modelos (`modelos/`); esta skill põe os dois num repositório. A raiz do `my_claude` é a pasta que contém `metodo/` e `modelos/`, três níveis acima deste arquivo. Numa sessão na nuvem, o `my_claude` precisa estar anexado à sessão junto com o projeto; no computador, use o clone local.

## 1. Combinar o começo

Pergunte, numa mensagem só, o que não estiver claro:

- **O repositório.** Ele precisa existir no GitHub (quem cria é o Navegador). Projeto novo ou existente?
- **O tipo de entrega:** `software` (a entrega é um sistema), `processo` (a entrega é um processo de trabalho redesenhado) ou nenhum dos dois (segue só o método, sem modelo; se o padrão se repetir em outro projeto, vira um tipo novo, nunca antes).
- **A dor, numa frase**, e quem sofre com ela. É só o ponto de partida: o passo "Problema" vem depois.

## 2. Instalar

Numa branch nova do projeto (`metodo`):

1. `bash <my_claude>/ferramentas/instalar_metodo.sh <my_claude> <projeto>`: skills e `.claude/metodo.md`.
2. Copie os modelos **sem sobrescrever** nada que já exista (`cp -Rn`): primeiro `modelos/comum/` (documento de negócio e os workflows `quadro.yml` e `metodo.yml`), depois `modelos/<tipo>/` (`CLAUDE.md` e `.claude/settings.json`).
3. **Projeto existente** que já tem `CLAUDE.md`: não sobrescreva. Proponha a fusão: a primeira linha passa a ser `@.claude/metodo.md`, entra a "Ficha do método" preenchida com o que o projeto já diz, e sai do `CLAUDE.md` tudo o que o método já cobre (para não haver duas versões da mesma regra). Skill própria com o mesmo nome de uma do método: mostre as diferenças e pergunte qual fica; o que for só do projeto vira item da ficha. Mesma coisa para um `docs/negocio.md` ou um `quadro.yml` que já existam. Mostre a fusão e espere o ok antes de gravar.
4. Preencha no `CLAUDE.md` só o que já se sabe (nome, Navegador, a dor em uma frase); o resto fica entre colchetes até o passo "Problema" e a trava do plano do primeiro cartão.

## 3. Entregar a instalação

Commit ("Instala o método do my_claude", com o porquê no corpo), push da branch e PR para a branch principal. O merge é do Navegador. Diga no PR e na resposta o que só o Navegador pode fazer no GitHub:

- **Settings > Actions > General:** marcar "Allow GitHub Actions to create and approve pull requests", para o workflow "Método" abrir os PRs de atualização.
- **O quadro.** No computador: `python3 <my_claude>/ferramentas/quadro.py criar --titulo=<nome>`, de dentro da pasta do projeto. Pela página do GitHub: criar um Project em modo Board, ligá-lo ao repositório, deixar as colunas Ideias, A fazer, Próximo, Fazendo e Feito, e nos Workflows do Project ligar "Item added to project" para Ideias, "Item closed" para Feito e "Auto-add to project" para as issues do repositório.
- **As etiquetas** são criadas pelo workflow "Quadro" na primeira issue, ou já, rodando-o à mão na aba Actions.

## 4. Começar o ciclo

Com a instalação no PR, comece o passo "Problema" do método: reformule a dor com as suas palavras, faça as perguntas que faltarem (no máximo três por vez) e escreva o `docs/negocio.md` com o Navegador até ele aprovar o problema. Depois, conforme o caso, `/descoberta`, `/processo` ou direto `/demanda` para os primeiros cartões.
