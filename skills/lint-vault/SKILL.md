---
name: lint-vault
description: "Triggered when the user types /lint or asks to health-check the Obsidian Vault. Scans the wiki/ directory to identify structural issues, orphan pages, broken wikilinks, stale index entries, and contradictions."
---
# Vault Lint Operation

When this skill is invoked, perform the following autonomous health-check on the user's Obsidian Vault:

## Phase 1: Structural Integrity
1. Read `/wiki/index.md` and extract all listed page references.
2. List all actual `.md` files inside `/wiki/` (including subdirectories: `entities/`, `concepts/`, `synthesis/`).
3. Identify:
   - **Stale index entries**: Pages listed in `index.md` that no longer exist on disk.
   - **Unlisted pages**: Pages on disk that are not cataloged in `index.md`.

## Phase 2: Link Integrity
1. Scan all `.md` files inside `/wiki/` for `[[wikilinks]]`.
2. Identify:
   - **Broken wikilinks**: Links pointing to pages that do not exist.
   - **Orphan pages**: Pages with zero inbound wikilinks from other pages.

## Phase 3: Content Health
1. Scan `wiki/concepts/` and `wiki/entities/` pages for YAML frontmatter.
2. Identify:
   - **Missing frontmatter**: Pages lacking `title`, `tags`, or `date` fields.
   - **Empty pages**: Files with no meaningful content beyond the frontmatter.

## Phase 4: Report
Generate a structured markdown report with:
- Total pages scanned.
- Issues found per category (stale, unlisted, broken links, orphans, missing frontmatter).
- Suggested fixes for each issue.
- Ask the user: "Would you like me to auto-fix these issues?"

If the user approves fixes:
- Remove stale entries from `index.md`.
- Add unlisted pages to `index.md`.
- Add missing frontmatter to pages that lack it.
- Append a `lint` entry to `/wiki/changelog.md`.
