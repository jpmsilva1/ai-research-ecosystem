## E01: Efficiency Comparison of LLM-Wiki vs Traditional RAG
- **Verifies**: C01
- **Setup**:
  - Model: Claude 3.5 Sonnet / Gemini 1.5 Pro
  - Hardware: Standard API access
  - Dataset: 50 scientific papers on a niche topic.
  - System: Setup A (Standard RAG indexing raw PDFs) vs Setup B (LLM-Wiki maintaining compiled markdown summaries and concepts).
- **Procedure**:
  1. Ingest all 50 papers into both setups.
  2. Ask 5 complex synthesis questions requiring multi-paper reasoning.
  3. Record the number of tokens used at query time and the time to first byte.
- **Metrics**: Query context tokens (count), Latency (seconds), Synthesis quality (1-5 scale).
- **Expected outcome**:
  - Setup B uses significantly fewer context tokens at query time than Setup A.
  - Setup B has lower query latency than Setup A.
- **Baselines**: Standard naive RAG.
- **Dependencies**: none

## E02: Autonomous Maintenance Drift Rate
- **Verifies**: C02
- **Setup**:
  - Model: Claude 3.5 Sonnet
  - Hardware: Standard API access
  - Dataset: 100 sequential daily journal entries.
  - System: LLM-Wiki configured with strict schema conventions (`AGENTS.md`).
- **Procedure**:
  1. Sequentially ingest the 100 entries one by one.
  2. Have the agent autonomously update the `index.md`, cross-references, and `log.md`.
  3. Perform a human review of the wiki structure after ingestion is complete.
- **Metrics**: Broken links (count), Hallucinated entities (count), Contradictions preserved (count).
- **Expected outcome**:
  - The LLM maintains near-perfect structural integrity (very low broken links) with minimal hallucinated entities.
- **Baselines**: Human-maintained wiki.
- **Dependencies**: none

## E03: Impact of the Lint Operation on Wiki Health
- **Verifies**: C01, C02
- **Setup**:
  - Model: Gemini 1.5 Pro
  - System: A pre-existing LLM-Wiki with artificially injected broken links, contradictions, and orphan pages (n=20 errors).
- **Procedure**:
  1. Execute the Lint Operation ($Op_{lint}$).
  2. Allow the LLM to autonomously patch the identified issues.
- **Metrics**: Errors identified (count), Errors successfully resolved (count).
- **Expected outcome**:
  - The LLM successfully identifies and resolves the vast majority of injected structural errors.
- **Baselines**: None.
- **Dependencies**: E02
