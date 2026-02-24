# Deployment

## GitHub Pages Setup

The simplest way to deploy Markflow docs is with GitHub Actions and GitHub Pages.

### Enable GitHub Pages

1. Go to your repository on GitHub
2. Navigate to **Settings > Pages**
3. Under **Source**, select **GitHub Actions**
4. Save

### Create Workflow File

Create `.github/workflows/deploy-docs.yml` in your repo:

```yaml
name: Deploy Docs

on:
  push:
    branches: [main]

permissions:
  contents: read
  pages: write
  id-token: write

concurrency:
  group: pages
  cancel-in-progress: true

jobs:
  deploy:
    runs-on: ubuntu-latest
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    steps:
      - uses: actions/checkout@v4

      - name: Build docs
        run: |
          chmod +x ./markflow
          ./markflow build --prebake --source ./docs --output ./site --config ./docs/.env

      - uses: actions/configure-pages@v5

      - uses: actions/upload-pages-artifact@v3
        with:
          path: ./site

      - id: deployment
        uses: actions/deploy-pages@v4
```

Push to `main` and your docs will be live at `https://<user>.github.io/<repo>/`.

## The Workflow Explained

The workflow does four things:

1. **Checks out** the repo
2. **Builds** the docs using `markflow build` with pre-baked local content from `./docs`
3. **Uploads** the `./site` directory as a Pages artifact
4. **Deploys** to GitHub Pages

The `--prebake --source ./docs` flags embed all Markdown into the HTML so no runtime API calls are needed.

The `--config ./docs/.env` flag uses a separate config file for the docs site. This lets you keep the docs config separate from any project-level `.env`.

When `MARKFLOW_LLM_FRIENDLY` is enabled (the default for `--source` builds), the output directory will also contain `llms.txt`, `llms-full.txt`, and `api.json` — these are deployed alongside `index.html` automatically.

## Custom Domain

To use a custom domain:

1. Go to **Settings > Pages** in your GitHub repo
2. Enter your custom domain under **Custom domain**
3. Add a `CNAME` file to the build output, or add it to the workflow:

```yaml
      - name: Build docs
        run: |
          chmod +x ./markflow
          ./markflow build --prebake --source ./docs --output ./site --config ./docs/.env
          echo "docs.yoursite.com" > ./site/CNAME
```

## Other Hosting

### Netlify

```bash
markflow build --prebake --source ./docs --output ./dist
```

Set the build command and publish directory in your Netlify config:

```toml
# netlify.toml
[build]
  command = "chmod +x ./markflow && ./markflow build --prebake --source ./docs --output ./dist --config ./docs/.env"
  publish = "dist"
```

### Vercel

Create a `vercel.json`:

```json
{
  "buildCommand": "chmod +x ./markflow && ./markflow build --prebake --source ./docs --output ./dist --config ./docs/.env",
  "outputDirectory": "dist"
}
```

### Any Static Host

Markflow outputs `index.html` along with LLM-friendly files (`llms.txt`, `llms-full.txt`, `api.json`). Upload the entire output directory to any static hosting provider — S3, Cloudflare Pages, Firebase Hosting, or just drop it on any web server.
