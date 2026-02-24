# Getting Started

## Install Markflow

### One-liner Install

Run this in your terminal:

```bash
curl -sL https://raw.githubusercontent.com/darmie/markflow/main/install.sh | bash
```

This downloads `markflow` and `template.html` to `~/.markflow/` and adds it to your PATH.

After installation, restart your shell or run:

```bash
export PATH="$HOME/.markflow:$PATH"
```

### Manual Install

Clone the repo and use the script directly:

```bash
git clone https://github.com/darmie/markflow.git
cd markflow
chmod +x ./markflow
./markflow --version
```

You can also copy `markflow` and `template.html` to any directory on your PATH.

## Initialize a Project

Navigate to your project and run:

```bash
markflow init
```

This creates a `.env` file with all available configuration options. Open it and set your repo details:

```env
MARKFLOW_REPO_OWNER=your-org
MARKFLOW_REPO_NAME=your-repo
MARKFLOW_REPO_BRANCH=main
MARKFLOW_REPO_ROOT=docs
```

## Write Your First Doc

Create a `docs/` folder and add a Markdown file:

```bash
mkdir docs
```

Create `docs/01-hello.md`:

```markdown
# Hello World

## Welcome

This is your first Markflow page. Each `## heading` becomes a numbered step in the sidebar.

## Writing Content

Write standard Markdown — headings, lists, code blocks, images, links — everything works.

### Code Example

Use fenced code blocks with a language tag:

    ```python
    print("Hello from Markflow!")
    ```

## Next Steps

Add more `.md` files to the `docs/` folder. Each file becomes a page in the dropdown.
```

### File Naming Convention

Files are sorted alphabetically. Use numeric prefixes to control order:

```
docs/
├── 01-introduction.md
├── 02-getting-started.md
├── 03-configuration.md
└── 04-advanced.md
```

### Heading Hierarchy

- `# H1` — page title (displayed in the header, not in the sidebar)
- `## H2` — numbered steps in the sidebar
- `### H3` / `#### H4` — sub-items under the active step

## Build and Preview

Build your docs into a single HTML file:

```bash
markflow build --prebake --source ./docs --output ./dist
```

Then preview locally:

```bash
markflow serve
```

Open `http://localhost:3000` in your browser. You should see your docs rendered with a step sidebar, page dropdown, and syntax highlighting.
