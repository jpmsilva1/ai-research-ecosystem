# Constraints and Boundary Conditions

## 1. Context Window Limitations
The Ingest Operation ($Op_{ingest}$) often requires the LLM to touch 10-15 files. This relies heavily on modern large context windows and the ability to emit structured multi-file edits reliably.

## 2. Token Costs
Running the Query Operation ($Op_{query}$) on a fully compiled wiki is highly efficient. However, running $Op_{ingest}$ is computationally expensive as it requires deep reasoning over the raw source and the global wiki context to integrate correctly.

## 3. Multi-modal limits
LLMs currently struggle to natively read markdown with inline images in a single pass. The workaround is to have the LLM read text first, then explicitly view referenced local images.
