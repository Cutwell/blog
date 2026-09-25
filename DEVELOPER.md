# Developer Guide

## Prerequisites

- [rbenv](https://github.com/rbenv/rbenv) with Ruby 3.3.10 (see `.ruby-version`)
- Bundler (`gem install bundler`)

## Setup

```bash
make install
# or: bundle install
```

## Local development

```bash
make serve
# or: bundle exec jekyll serve --livereload
```

Opens at **http://localhost:4000/blog/**. The site hot-reloads on file changes.

## Build

```bash
make build
# or: bundle exec jekyll build

# Production build (matches GitHub Pages environment)
JEKYLL_ENV=production bundle exec jekyll build
```

Output is written to `_site/`.

## Clean

```bash
make clean
# or: bundle exec jekyll clean
```

## Creating a post

1. Add a file to `_posts/` named `YYYY-MM-DD-post-title.md`.
2. Include front matter:
   ```yaml
   ---
   layout: post
   title: Your Post Title
   categories: [Category1, Category2]
   ---
   ```
3. For images, create a matching directory `_posts/YYYY-MM-DD-post-title/` and reference them as:
   ```markdown
   ![alt text](/_posts/YYYY-MM-DD-post-title/image.png)
   ```
4. Use `<!--more-->` to set the excerpt boundary shown in search results and the RSS feed.

## Custom layouts

Special post layouts live in `_layouts/`. Specify one in front matter:

```yaml
layout: python        # adds GitHub-style syntax highlighting CSS
layout: the-dark-forest  # animated dark background with parallax scroll
```

## Deployment

Pushing to `main` triggers the GitHub Actions workflow (`.github/workflows/build-jekyll.yml`), which builds the site and deploys it to the `gh-pages` branch. The live site is at **https://cutwell.github.io/blog/**.

No manual deployment step is needed.

## Project structure

```
_config.yml          # site configuration (name, URL, plugins, compression)
_layouts/            # HTML layout templates
  compress.html      # Liquid-based HTML minifier (wraps all layouts)
  default.html       # base layout — navbar, dark mode, search overlay
  post.html          # blog post layout (reading time, home link, footer)
  python.html        # extends post with syntax highlighting styles
  the-dark-forest.html  # extends post with animated background
_includes/
  header.html        # <head> tag, favicons, SEO, dark-mode init script
  main.css           # global styles (inlined at build time)
  post.css           # post-specific styles, inlined by post.html
  contact.md         # footer links, rendered by post.html
  reading-time.html  # reading-time estimate snippet
  seo.html           # Open Graph / Twitter Card meta tags
_posts/              # blog posts (Markdown + image subdirectories)
.github/workflows/   # CI/CD — build/deploy and README RSS updater
```
