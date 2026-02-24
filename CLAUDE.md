# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal blog built with Jekyll and the Featherweight theme. The site is deployed to GitHub Pages via GitHub Actions and features blog posts about AI, machine learning, and web development.

## Architecture

### Jekyll Site Structure

- **_config.yml**: Main Jekyll configuration. Uses the Featherweight theme (v0.7.15) with extensive compression and optimization settings.
- **_posts/**: Blog posts in Markdown format. Each post follows the naming convention `YYYY-MM-DD-post-title.md` and includes front matter with layout, title, and categories. Images are stored in corresponding `_posts/YYYY-MM-DD-post-title/` subdirectories.
- **_layouts/**: Custom HTML layouts for special post types (e.g., `python-post.html`, `the-dark-forest.html`). These add specialized CSS styling to posts.
- **_includes/**: Reusable content snippets (e.g., `contact.md`) included via Liquid tags.
- **index.md**: Homepage using the default layout, displays blog post list in a table format.

### GitHub Actions Workflows

1. **build-jekyll.yml**: Triggered on push to main. Builds the Jekyll site and deploys to the `gh-pages` branch using the `jeffreytse/jekyll-deploy-action`.
2. **rss-to-readme.yml**: Scheduled daily at 8 AM (or manual trigger). Updates the main README.md with latest blog posts from the RSS feed.

### Theme Configuration

The Featherweight theme is configured with aggressive compression and optimization features enabled in `_config.yml`:
- CSS compression, SEO metadata, reading time estimates
- Page size reporting, favicon support
- Social URLs, resume section, blog post listings
- Zopfli and Brotli compression plugins for bandwidth optimization

## Development Commands

### Quick Start (Using Makefile)

```bash
# Install dependencies
make install

# Start dev server with live reload (http://localhost:4000/blog/)
make serve
# or
make dev

# Build the site
make build

# Clean build artifacts
make clean
```

### Building and Testing Locally (Direct Commands)

```bash
# Install dependencies
bundle install

# Serve locally with live reload (typically http://localhost:4000/blog/)
bundle exec jekyll serve --livereload

# Build the site
bundle exec jekyll build

# Build for production (mimics GitHub Pages environment)
JEKYLL_ENV=production bundle exec jekyll build

# Clean build artifacts
bundle exec jekyll clean
```

### Creating New Blog Posts

1. Create a new file in `_posts/` with the format: `YYYY-MM-DD-post-title.md`
2. Add front matter:
   ```yaml
   ---
   layout: post
   title: Your Post Title
   categories: [Category1, Category2]
   ---
   ```
3. If using images, create a corresponding directory: `_posts/YYYY-MM-DD-post-title/`
4. Reference images in posts as: `![alt text](/_posts/YYYY-MM-DD-post-title/image.png)`

### Deployment

Deployment is automatic via GitHub Actions when pushing to the `main` branch. The site is built and deployed to the `gh-pages` branch, then served at https://cutwell.github.io/blog/.

## Important Notes

- The site URL is configured as `https://cutwell.github.io/blog/` - all internal links should account for the `/blog/` base path.
- Posts support the `<!--more-->` tag to create post excerpts.
- Custom layouts in `_layouts/` can be specified in post front matter to apply special styling.
- The RSS feed is limited to 10 items and updates daily (configured via `feed_items` in `_config.yml`).
