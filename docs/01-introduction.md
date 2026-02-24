# Introduction

## What is Markflow

Markflow is a lightweight documentation generator that turns Markdown files into beautiful, step-by-step tutorial pages — inspired by Google Codelabs.

Point it at a folder of `.md` files (local or in a GitHub repo), and it produces a single `index.html` with:

- A numbered step sidebar derived from `h2` headings
- Sub-navigation from `h3`/`h4` headings under the active step
- A page dropdown to switch between files
- Syntax-highlighted code blocks
- Optional Giscus-powered comments on every page

No build pipeline, no Node.js runtime, no framework dependencies. Just a Bash script and an HTML template.

## Key Features

- **Zero dependencies** — pure Bash CLI, single-file HTML output
- **GitHub-native** — fetches Markdown directly from any public or private repo
- **Pre-baking** — embed content at build time for offline/static hosting
- **Theming** — 14 CSS variables for full color customization
- **Branch switching** — readers can toggle between branches and tags
- **Social links** — GitHub, Twitter/X, Discord, LinkedIn, YouTube, website
- **Giscus comments** — discussion threads on every page
- **Responsive** — works on desktop, tablet, and mobile

## How It Works

Markflow has two rendering modes:

### Dynamic Mode

The generated page fetches Markdown from the GitHub API at runtime. Great for always-up-to-date docs, but requires the reader to be online.

```
Reader opens page -> JS fetches repo tree -> fetches .md files -> renders with marked.js
```

### Pre-baked Mode

Markdown is base64-encoded and embedded into the HTML at build time. The page works fully offline — no API calls needed.

```
markflow build --prebake --source ./docs -> index.html with embedded content
```

## Architecture

Markflow consists of two files:

| File | Role |
|------|------|
| `markflow` | Bash CLI — reads `.env`, replaces placeholders in the template, optionally pre-bakes content |
| `template.html` | Single-page app — sidebar navigation, Markdown rendering, syntax highlighting, scroll spy |

The CLI takes `template.html`, injects your configuration (repo details, theme, branding, social links), and outputs a self-contained `index.html`.

```
.env config ---+
               +--> markflow build --> index.html
template.html -+
```
