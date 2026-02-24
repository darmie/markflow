# CLI Reference

## markflow init

Creates a `.env` configuration file in the current directory with all available options and sensible defaults.

```bash
markflow init
```

If a `.env` already exists, you'll be prompted to confirm before overwriting.

**Output:** a `.env` file ready to edit with your repo details.

## markflow build

Generates a single `index.html` from the template and your configuration.

```bash
markflow build [options]
```

### --output

```bash
markflow build --output ./public
```

Sets the output directory. Defaults to `./dist`. The directory is created if it doesn't exist.

### --prebake

```bash
markflow build --prebake
```

Embeds Markdown content directly into the HTML file at build time. Without this flag, the generated page fetches content from the GitHub API at runtime.

Pre-baking is recommended for:
- Static hosting (GitHub Pages, Netlify, Vercel)
- Offline documentation
- Faster page loads

### --source

```bash
markflow build --prebake --source ./docs
```

Specifies a local directory of Markdown files to pre-bake. The directory is scanned recursively for `.md`, `.markdown`, and `.mdx` files.

Without `--source`, pre-baking fetches files from GitHub using the API (requires `GITHUB_TOKEN` for private repos or to avoid rate limits).

### --config

```bash
markflow build --config ./my-config.env
```

Path to the configuration file. Defaults to `.env` in the current directory.

### --serve

```bash
markflow build --prebake --source ./docs --serve
```

Starts a local preview server immediately after the build completes. This combines `build` and `serve` into a single command.

### --port

```bash
markflow build --prebake --source ./docs --serve --port 8080
```

Sets the server port when using `--serve`. Defaults to `3000`. This flag is only used when `--serve` is also passed.

### Combined Examples

Build with pre-baked local content:

```bash
markflow build --prebake --source ./docs --output ./dist
```

Build and preview in one step:

```bash
markflow build --prebake --source ./docs --serve
```

Build with pre-baked GitHub content:

```bash
GITHUB_TOKEN=ghp_xxx markflow build --prebake --output ./public
```

Build without pre-baking (dynamic mode):

```bash
markflow build --output ./site
```

## markflow serve

Starts a local HTTP server to preview your built docs.

```bash
markflow serve [options]
```

Requires either `python3` or `npx` to be installed.

### --port

```bash
markflow serve --port 8080
```

Server port. Defaults to `3000`.

### --dir

```bash
markflow serve --dir ./public
```

Directory to serve. Defaults to `./dist`.

### Example

```bash
markflow build --prebake --source ./docs
markflow serve --port 4000
# Open http://localhost:4000
```

Or use `--serve` on the build command to combine both steps:

```bash
markflow build --prebake --source ./docs --serve --port 4000
```

## Version and Help

```bash
markflow --version   # prints: markflow 0.1.0
markflow -v          # same

markflow --help      # show usage summary
markflow -h          # same
```
