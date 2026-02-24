# Advanced

## Pre-baking Content

Pre-baking embeds Markdown content directly into the HTML at build time. This eliminates runtime API calls, making the page load instantly and work offline.

### From Local Files

```bash
markflow build --prebake --source ./docs
```

This scans the `./docs` directory recursively for `.md`, `.markdown`, and `.mdx` files. Each file is base64-encoded and embedded in the output HTML.

The directory structure is preserved. Files are sorted alphabetically, so use numeric prefixes to control page order:

```
docs/
├── 01-intro.md       → Page 1
├── 02-setup.md       → Page 2
├── guides/
│   ├── 01-basics.md  → Page 3 (in "guides" section)
│   └── 02-advanced.md → Page 4
```

### From GitHub API

```bash
markflow build --prebake
```

Without `--source`, pre-baking fetches files from the GitHub repository configured in your `.env`. This is useful for CI pipelines where the docs live in a different repo.

### GITHUB_TOKEN

For private repos or to avoid GitHub API rate limits (60 requests/hour unauthenticated), set a token:

```bash
GITHUB_TOKEN=ghp_xxxxxxxxxxxx markflow build --prebake
```

Or add it to your `.env`:

```env
GITHUB_TOKEN=ghp_xxxxxxxxxxxx
```

In GitHub Actions, use the built-in token:

```yaml
- name: Build docs
  env:
    GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
  run: |
    chmod +x ./markflow
    ./markflow build --prebake --output ./site --config ./docs/.env
```

## Giscus Comments

Markflow supports [Giscus](https://giscus.app) for GitHub Discussions-powered comments on every page.

### Setup Giscus

1. Install the [Giscus app](https://github.com/apps/giscus) on your repo
2. Enable **Discussions** in your repo settings
3. Create a discussion category (e.g., "Docs Comments")

### Configuration

Add to your `.env`:

```env
MARKFLOW_GISCUS_REPO=your-org/your-repo
MARKFLOW_GISCUS_CATEGORY=Docs Comments
```

Comments will appear at the bottom of every page. Each page gets its own discussion thread based on the page path.

Leave `MARKFLOW_GISCUS_REPO` blank to disable comments entirely.

## Branch Switcher

When enabled, a dropdown appears at the top of the sidebar listing all branches and tags in the repository.

```env
MARKFLOW_BRANCH_SWITCHER=true
```

This lets readers switch between versions of your documentation — useful for projects with multiple release branches.

The branch list is fetched from the GitHub API at runtime. It works in both dynamic and pre-baked modes (in pre-baked mode, switching branches fetches content from GitHub for the new branch).

## Markdown Conventions

### File Organization

Markflow groups files into sections based on directory structure:

```
docs/
├── 01-intro.md            → "root" section
├── 02-quickstart.md       → "root" section
├── guides/
│   ├── 01-basics.md       → "guides" section
│   └── 02-advanced.md     → "guides" section
└── reference/
    ├── 01-api.md           → "reference" section
    └── 02-config.md        → "reference" section
```

Top-level files appear first, followed by subdirectory sections. Within each section, files are sorted alphabetically.

### Heading Hierarchy

Your heading structure controls the navigation:

| Heading | Role | Where it appears |
|---------|------|-----------------|
| `# H1` | Page title | Header bar |
| `## H2` | Step | Numbered items in the sidebar |
| `### H3` | Sub-step | Indented under active step in sidebar |
| `#### H4` | Sub-sub-step | Further indented under active step |

A typical page structure:

```markdown
# Page Title

## First Step

Content for step 1.

### Details

More details shown as a sub-item.

## Second Step

Content for step 2.
```

### Supported Markdown Features

Markflow uses [marked.js](https://marked.js.org/) for rendering with full GitHub Flavored Markdown support:

- Headings, paragraphs, blockquotes
- Ordered and unordered lists
- Fenced code blocks with syntax highlighting (via highlight.js)
- Tables
- Images and links
- Inline code, bold, italic, strikethrough
- Horizontal rules
- Task lists
