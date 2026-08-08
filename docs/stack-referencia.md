# Stack de Referência

Sugestões para o gate da Fase 3 (Design). **Aplicar cada item onde couber —
não forçar tudo em todo projeto.** Desvios são permitidos com justificativa
técnica, decididos pelo Navegador.

- Arquitetura: **Domain Driven Design**
- Design Pattern: **Padrão Digital de Governo** — https://gitlab.com/govbr-ds/govbr-ds/
- Conteinerização: **Docker** e **Docker Compose**
- Runtime/linguagem: **Node.js** (TypeScript)
- Backend/API: **NestJS**
- Frontend/fullstack: **Next.js**
- Banco relacional: **PostgreSQL** com ORM **Prisma**
- Cache/sessões/filas leves: **Redis**
- Mensageria: **RabbitMQ** (filas de tarefas, comandos) ou **Kafka** (streaming
  de eventos, alto volume) — justificar a escolha

Antes de adotar: evite reinventar a roda. Prefira bibliotecas open-source
consolidadas, ativas e validadas pela comunidade. Se houver solução padrão de
mercado para o problema, sugira sua adoção em vez de código proprietário.
