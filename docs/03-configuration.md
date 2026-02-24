# Configuration

## The .env File

All Markflow configuration lives in a single `.env` file. Run `markflow init` to generate one with all options.

The build command reads this file and injects the values into the HTML template. You can use a different config file with `--config`:

```bash
markflow build --config ./docs/.env
```

## Repository Settings

These tell Markflow where to find your Markdown files.

### Owner and Name

```env
MARKFLOW_REPO_OWNER=your-org
MARKFLOW_REPO_NAME=your-repo
```

Required. The GitHub owner (user or organization) and repository name.

### Branch

```env
MARKFLOW_REPO_BRANCH=main
```

The default branch to load. Defaults to `main`.

### Root Directory

```env
MARKFLOW_REPO_ROOT=docs
```

If your Markdown files live in a subdirectory, set this to the path relative to the repo root. Leave blank if they're in the root.

### Branch Switcher

```env
MARKFLOW_BRANCH_SWITCHER=true
```

When enabled, a dropdown appears above the page selector letting readers switch between branches and tags. Set to `false` to hide it.

## Branding

### Brand Name

```env
MARKFLOW_BRAND_NAME=My Docs
```

Displayed in the header and browser tab title.

### Brand Logo

```env
MARKFLOW_BRAND_LOGO=
```

Accepts three formats:

1. **File path** — path to an `.svg` file (read and inlined at build time)
2. **URL** — rendered as an `<img>` tag
3. **Inline SVG** — raw `<svg>...</svg>` string

Leave blank to use the default document icon.

## Theme Colors

Markflow uses CSS custom properties for theming. Override any of these in your `.env`:

### Color Variables Reference

| Variable | Default | Purpose |
|----------|---------|---------|
| `MARKFLOW_ACCENT` | `#c4956a` | Primary accent color (links, active states) |
| `MARKFLOW_ACCENT_DIM` | `#9a7554` | Dimmed accent (borders, subtle highlights) |
| `MARKFLOW_ACCENT_BRIGHT` | `#daa87a` | Bright accent (hover states) |
| `MARKFLOW_BG_PRIMARY` | `#0a0a0c` | Main background |
| `MARKFLOW_BG_SECONDARY` | `#111116` | Sidebar, card backgrounds |
| `MARKFLOW_BG_TERTIARY` | `#18181f` | Hover backgrounds, raised surfaces |
| `MARKFLOW_TEXT_PRIMARY` | `#e8e6e3` | Main text color |
| `MARKFLOW_TEXT_SECONDARY` | `#9a9aab` | Secondary text (descriptions) |
| `MARKFLOW_TEXT_MUTED` | `#5e5e72` | Muted text (placeholders, hints) |
| `MARKFLOW_BORDER` | `#2a2a35` | Border color |
| `MARKFLOW_CODE_BG` | `#0d0d12` | Code block background |

### Example: Light Theme

```env
MARKFLOW_ACCENT=#2563eb
MARKFLOW_ACCENT_DIM=#1d4ed8
MARKFLOW_ACCENT_BRIGHT=#3b82f6
MARKFLOW_BG_PRIMARY=#ffffff
MARKFLOW_BG_SECONDARY=#f8fafc
MARKFLOW_BG_TERTIARY=#f1f5f9
MARKFLOW_TEXT_PRIMARY=#0f172a
MARKFLOW_TEXT_SECONDARY=#475569
MARKFLOW_TEXT_MUTED=#94a3b8
MARKFLOW_BORDER=#e2e8f0
MARKFLOW_CODE_BG=#f1f5f9
```

## Social Links

Add social media icons to the header. Leave a variable blank to hide that icon.

```env
MARKFLOW_SOCIAL_GITHUB=https://github.com/your-org/your-repo
MARKFLOW_SOCIAL_TWITTER=https://x.com/yourhandle
MARKFLOW_SOCIAL_DISCORD=https://discord.gg/invite
MARKFLOW_SOCIAL_LINKEDIN=https://linkedin.com/company/yourco
MARKFLOW_SOCIAL_YOUTUBE=https://youtube.com/@yourchannel
MARKFLOW_SOCIAL_WEBSITE=https://yoursite.com
```

All six are optional. Only icons with a URL will appear.
