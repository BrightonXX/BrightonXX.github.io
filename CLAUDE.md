# Blog Documentation

## Blog Location
- **Local**: `/Users/brighton/Desktop/ProjectFinal/Web/blog/`
- **Remote**: https://brightonxx.github.io/
- **Repository**: BrightonXX/BrightonXX.github.io

## Tech Stack
- **Static Site Generator**: Hugo v0.154.5+extended
- **Theme**: hugo-theme-cleanwhite (git submodule)
- **Hosting**: GitHub Pages
- **Deployment**: GitHub Actions (automatic on push)
- **Comments**: Giscus (GitHub Discussions-based)
- **Analytics**: Google Analytics 4 (G-LQJH3PGC48)

## Key Configuration
- **Language**: English (hasCJKLanguage: true for Chinese support)
- **Content Type**: "posts" (plural, not "post") - CRITICAL
- **Navigation**: All Posts, TAGS, WORKS, ARCHIVE, ABOUT
- **Slogan**: "Move Fast and Break Things"

## Directory Structure
```
blog/
├── content/
│   ├── posts/          # Blog articles
│   ├── about/          # About page (bilingual)
│   ├── works/          # Works/Projects page
│   └── tags/           # Tags taxonomy
├── static/img/         # All images (cover, avatar, etc.)
├── layouts/
│   ├── posts/single.html      # Custom post template
│   ├── partials/
│   │   ├── comments.html      # Giscus config
│   │   ├── head.html          # Custom head
│   │   ├── portfolio.html     # Homepage listing
│   │   └── sidebar.html       # Sidebar
│   ├── shortcodes/
│   │   └── album-review.html  # BrightFork shortcode
│   ├── taxonomy/tag.html      # Tag page
│   └── archive.html
└── hugo.toml
```

---

## Creating a New Blog Post

### 1. Create Markdown File
Location: `content/posts/YYYY-MM-DD-title.md`

```yaml
---
title: "Article Title"
date: 2026-01-20T23:45:00+08:00
draft: false  # CRITICAL: must be false to publish
description: "Article description for SEO"
keywords: ["keyword1", "keyword2"]
tags: ["tag1", "tag2"]
categories: []
author: "Brighton"
header_image: "img/cover-image.jpg"
image: "img/cover-image.jpg"
thumbnail: "img/cover-image.jpg"
---
```

**Important:**
- Use `<!-- more -->` to create summary/excerpt on homepage
- Tags and categories must be arrays: `["tag1", "tag2"]`
- Date must be in the PAST (Hugo doesn't generate future-dated posts by default)

### 2. Add Cover Image
```bash
cp /path/to/image.jpg /Users/brighton/Desktop/ProjectFinal/Web/blog/static/img/cover-image.jpg
```

**Naming Convention:** Use descriptive filenames, NOT random names
- ✅ Good: `close-to-the-edge.jpg`, `illinois.jpg`
- ❌ Bad: `hugo-blog-cover.jpg`, `IMG_1234.jpg`

**Image Compression:**
```bash
sips -s format jpeg -s formatOptions 50 image.jpg --out image.jpg
```

**HEIC to JPG:**
```bash
sips -s format jpeg image.heic --out image.jpg
```

### 3. Deploy
```bash
cd /Users/brighton/Desktop/ProjectFinal/Web/blog
git add -A && git commit -m "Add post: title" && git push origin main
```

---

## BrightFork Music Review Series

### Album Review Shortcode
```markdown
{{< album-review
    image="img/album-cover.jpg"
    score="9.5"
    artist="Artist Name"
    album="Album Title"
    year="1972"
    genre="Progressive Rock"
>}}
```

### Article Formatting
- **No H1 title** (header already shows title)
- Use centered subtitles:
  ```html
  <p style="text-align: center; font-size: 1.2em; color: #666; margin: 30px 0 20px 0;">🎵 Section Title</p>
  ```

### Example Post Structure
```markdown
---
title: "BrightFork #0: 2025 音乐总结篇"
date: 2026-01-21T19:00:00+08:00
tags: ["BrightFork", "Music", "Review"]
---

Introduction paragraph...

<!-- more -->

<p style="text-align: center; font-size: 1.2em; color: #666;">🎵 Annual Song</p>

{{< album-review ... >}}

Review content...
```

---

## Bilingual About Page

### Files
- `content/about/index.md` - English version (WITH front matter)
- `content/about/index-zh.md` - Chinese version (NO front matter)

### Critical Rule
English version must have:
```yaml
---
layout: page
multilingual: true
---
```

Chinese version must NOT have front matter - start directly with content.

---

## Common Issues & Solutions

| Issue | Solution | Reason |
|-------|----------|--------|
| Cover image not displaying on article page | Ensure `layouts/posts/single.html` exists | Hugo template lookup prioritizes section-specific templates |
| Archive page empty | Use `"Type" "posts"` (plural) | Content type is "posts" not "post" |
| Comments appearing on non-article pages | Add `(eq .Section "posts")` check in comments.html | Comments should only appear on blog posts |
| Featured tags empty | Set `featured_condition_size = 0` in hugo.toml | Default 1 means tags need >1 posts |
| KaTeX font 404 errors | Create empty `layouts/partials/math/katex-fonts.html` | Theme's default KaTeX CDN is broken |
| Future posts not appearing | Set date in the PAST or use `--buildFuture` | Hugo doesn't generate future-dated posts by default |
| Homepage shows no posts | In portfolio.html, use `"Type" "posts"` | Same plural issue |
| Sidebar "LAST POSTS" empty | In sidebar.html, use `"Type" "posts"` | Same plural issue |

---

## Custom Features Implemented

### 1. Vercount Page View Counter
- **Location**: `layouts/partials/head.html` (script), `layouts/posts/single.html` & `sidebar.html` (display)
- **Usage**: `busuanzi_value_page_pv`, `busuanzi_value_site_pv`, `busuanzi_value_site_uv`
- **Display**: Article page "· 100 views", Sidebar "100 views · 50 visitors"

### 2. Smart Typing Effect
- **Location**: `layouts/partials/head.html`
- Only plays when entering from non-slogan page, skips between slogan pages

### 3. Code Block Enhancements
- Padding: 10px top/bottom, 16px left/right
- Copy button on hover (top-right)
- "Copy" → "Copied!" (2 second reset)

### 4. Lightbox for Images
- **Library**: Lightbox2
- Click to enlarge, wrap around navigation

### 5. Tag Page Title
- **Location**: `layouts/taxonomy/tag.html`
- H1: "Searched for [tagname]", Subtitle: "Tag · X posts"

---

## WeChat Article Imports
- **Title Format**: "[公众号搬运] Original Title"
- **Tags**: `["Life", "随笔"]`
- Centered description div, year image at bottom (50% width)

---

## Quick Commands
```bash
hugo server -D              # Local preview with drafts
hugo --minify               # Build
rm -rf resources/ public/ && hugo --minify  # Clean rebuild
git add -A && git commit -m "msg" && git push origin main
hugo new posts/YYYY-MM-DD-title.md  # Create new post
```
