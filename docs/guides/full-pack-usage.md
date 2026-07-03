# Full Pack Usage Guide (Enterprise Engineering)

The **Full Pack** transforms your LLM interface into a complete "IT Department in a box," providing access to over 130 advanced engineering tools. This guide details the complete taxonomy of skills available, categorized by software lifecycle phases.

## 1. Data Engineering & Database Management
Tools for constructing robust data pipelines, migrating schemas, and optimizing database performance.

- `data-engineering-data-pipeline`: Batch and streaming data processing architectures.
- `data-engineering-data-driven-feature`: Feature engineering guided by A/B testing and insights.
- `data-quality-frameworks`: Validation pipelines (Great Expectations, dbt tests).
- `database-migration`: Schema migrations across ORMs with zero-downtime strategies.
- `database-migrations-migration-observability`: CDC and migration monitoring infrastructure.
- `database-migrations-sql-migrations`: SQL migrations for PostgreSQL, MySQL, SQL Server.
- `database-cloud-optimization-cost-optimize`: Cost optimization across AWS, Azure, GCP.
- `claimable-postgres`: Ephemeral PostgreSQL database provisioning.
- `neon-postgres`: Serverless Postgres connection pooling and branching.
- `postgres-best-practices`: Supabase-driven Postgres optimization.
- `postgresql`: PostgreSQL schema design and constraints.
- `nosql-expert`: Distributed NoSQL (Cassandra, DynamoDB) single-table design.
- `vector-database-engineer`: Pinecone, Weaviate, Milvus, and pgvector integrations.
- `vector-index-tuning`: HNSW parameter optimization and scaling.
- `drizzle-orm-expert`: Drizzle ORM type-safe queries and schema design.
- `prisma-expert`: Prisma ORM migrations and relational modeling.
- `sql-optimization-patterns`: Query plan analysis and indexing strategies.

## 2. Data Science & Analytics
Tools for statistical validation and visual storytelling.

- `data-scientist`: Advanced analytics, statistical modeling, and hypothesis testing.
- `data-storytelling`: Transforming raw data into compelling narrative structures.
- `polars`: High-performance in-memory DataFrame operations (replacing Pandas).
- `plotly`: Interactive visualization engineering for dashboards.

## 3. Machine Learning & AI Engineering
End-to-end tools for deploying, training, and tracking machine learning models.

- `distributed-gpu-engineer`: SLURM, Ray, and PyTorch DDP scaling. *(Authored by João P. M. Silva)*
- `academic-rebuttal-simulator`: Simulates academic peer review and rebuttal drafting. *(Authored by João P. M. Silva)*
- `experiment-sweeper`: Hydra configs and Weights & Biases hyperparameter sweeps. *(Authored by João P. M. Silva)*
- `ml-engineer`: PyTorch/TensorFlow production systems and model serving.
- `ml-pipeline-workflow`: E2E MLOps pipeline orchestration.
- `mlops-engineer`: Experiment tracking (MLflow, Kubeflow) and model registries.
- `ai-ml`: General LLM application and RAG implementations.
- `ai-engineering-toolkit`: Prompt evaluation, budget planning, and RAG architectures.
- `rag-engineer`: Retrieval-Augmented Generation chunking and retrieval optimization.
- `embedding-strategies`: Selection and optimization of embedding models.
- `llm-app-patterns`: Production patterns for LLM apps (Dify-inspired).
- `local-llm-expert`: Local inference (Ollama, vLLM) and VRAM optimization.
- `recsys-pipeline-architect`: Composable recommendation and ranking pipelines.
- `similarity-search-patterns`: Nearest neighbor querying and vector search.
- `seek-and-analyze-video`: Persistent video intelligence and visual memory analysis.

## 4. Architecture & Software Design
Frameworks for planning complex, scalable backend systems.

- `architecture`: Foundational architectural decision-making.
- `architecture-patterns`: Clean Architecture, Hexagonal, and DDD principles.
- `architect-review`: Master software architect reviews.
- `architecture-decision-records`: Authoring formal ADRs.
- `c4-architecture-c4-architecture`: Comprehensive C4 generation.
- `c4-code`, `c4-component`, `c4-container`, `c4-context`: Specialized C4 level documentation.
- `domain-driven-design`: Complete DDD routing.
- `ddd-context-mapping`, `ddd-strategic-design`, `ddd-tactical-patterns`: DDD modeling execution.
- `event-sourcing-architect`: Event-driven and CQRS pattern implementation.
- `event-store-design`: Event store persistence patterns.
- `cqrs-implementation`: Command Query Responsibility Segregation routing.
- `projection-patterns`: Read model and projection building.
- `microservices-patterns`: Distributed systems and service boundaries.
- `saga-orchestration`: Distributed transaction management.
- `graphql-architect`: GraphQL federation, caching, and schema design.
- `saas-multi-tenant`: Multi-tenant isolation and row-level security.
- `site-architecture`: Website hierarchy and internal linking.
- `software-architecture`: Quality-focused development guidelines.
- `nodejs-best-practices`: Async patterns, security, and Node.js architecture.

## 5. DevOps, Cloud & Deployment
Infrastructure as Code, orchestration, and continuous delivery pipelines.

- `devops-deploy`: CI/CD, AWS Lambda, SAM, and monitoring.
- `devops-troubleshooter`: Rapid incident response and debugging.
- `docker-expert`: Multi-stage builds and container hardening.
- `kubernetes-architect`: Enterprise container orchestration.
- `k8s-manifest-generator`: Automated generation of Deployments, Services, and PVCs.
- `k8s-security-policies`: Implementation of RBAC and NetworkPolicies.
- `kubestellar-console`: Multi-cluster Kubernetes management.
- `helm-chart-scaffolding`: Helm chart creation and packaging.
- `gitops-workflow`: ArgoCD and Flux implementation patterns.
- `deployment-engineer`: Advanced deployment automation.
- `deployment-pipeline-design`: Multi-stage CI/CD pipeline architecture.
- `deployment-procedures`: Safe deployment workflows and rollback strategies.
- `deployment-validation-config-validate`: Application configuration validation.
- `deploy-to-vercel`: Vercel deployments and preview generation.
- `github-actions-advanced`: Hardened GitHub Actions workflows (OIDC, matrix builds).
- `terraform-aws-modules`: AWS-specific reusable Terraform modules.
- `terraform-module-library`: Cloud-agnostic infrastructure module patterns.
- `terraform-skill`, `terraform-specialist`: Advanced IaC and state management.
- `mise-configurator`: Toolchain standardization environments.
- `observability-monitoring-monitor-setup`: Distributed tracing and log aggregation.
- `observability-monitoring-slo-implement`: Error budgets and SLI/SLO formulation.
- `grafana-dashboards`: Production-ready observability dashboards.
- `service-mesh-observability`: Istio and Linkerd monitoring patterns.

## 6. Testing & Quality Assurance
Comprehensive testing strategies ensuring system robustness.

- `tdd-orchestrator`: Multi-agent TDD workflow coordination.
- `tdd-workflow`, `tdd-workflows`, `tdd-workflows-tdd-cycle`: RED-GREEN-REFACTOR cycles.
- `tdd-workflows-tdd-green`, `tdd-workflows-tdd-red`, `tdd-workflows-tdd-refactor`: Phase-specific execution.
- `test-driven-development`: Pre-implementation test planning.
- `testing-patterns`: Jest factories and mocking strategies.
- `bats-testing-patterns`: Bash script testing.
- `unit-testing-test-generate`: Widespread unit test generation and edge-case focus.
- `k6-load-testing`: API scalability and load scenarios.
- `lambdatest-agent-skills`: E2E, mobile, and cross-browser testing automation.
- `screen-reader-testing`: Accessibility validation.
- `pypict-skill`: Pairwise test generation.
- `temporal-python-testing`: Workflow testing approaches.
- `vibecode-production-qa-validator`: Next.js launch-readiness checklists.
- `mock-hunter`: Deep audit for hardcoded values and mock endpoints.

## 7. Security & Incident Response
System hardening, penetration testing, and emergency mitigation.

- `aegisops-ai`: DevSecOps, Linux kernel patches, and K8s compliance auditing.
- `incident-response-incident-response`: Immediate emergency management.
- `incident-response-smart-fix`: AI-assisted observability and debugging pipelines.
- `incident-runbook-templates`: Playbooks for detection, triage, and mitigation.
- `network-101`: Network service enumeration and pentesting labs.
- `sqlmap-database-pentesting`: Automated SQL injection detection.

## 8. Documentation & Code Refactoring
Tools for maintaining clean codebases and pristine documentation.

- `docs-architect`: Automated technical manual generation from code analysis.
- `production-code-audit`: Systematic transformation of legacy code to corporate standards.
- `ponytail`, `ponytail-help`: The minimalist approach, forcing the laziest working solutions (YAGNI).
- `ponytail-audit`: Whole-repo scans for over-engineering and bloat.
- `ponytail-debt`: Harvesting technical debt markers into persistent ledgers.
- `ponytail-review`: Strict PR reviews hunting for speculative abstractions.

## 9. Persistent Memory & Workflow Integration
Tools enabling the Zettelkasten state machine and project intelligence.

- `antigravity-guide`: Deep guidance on utilizing the Antigravity ecosystem.
- `data-structure-protocol`: Persistent structural memory for codebase navigation without full-repo scans.
- `graphify`: AST knowledge graph generation and community detection.
- `resume-session`: Autonomously reads previous Obsidian logs to restore context.
- `save-session`: Autonomously extracts decisions and outputs session logs into the Vault.
- `clarity-gate`: Pre-ingestion epistemic verification for RAG document quality.
- `notebooklm`: Direct Gemini integration for document querying.
