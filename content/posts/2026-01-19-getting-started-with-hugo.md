---
title: "Getting Started with Hugo: Build Your Static Blog"
date: 2026-01-18T20:45:00+08:00
draft: false
keywords: ["Hugo", "Static Site Generator", "Web Development", "Blogging"]
description: "Learn how to create a static blog with Hugo, from installation to deployment on GitHub Pages."
tags: ["tutorial", "hugo", "web development"]
categories: []
author: "Brighton"
image: "img/getting-started-hugo.jpg"
thumbnail: "img/getting-started-hugo.jpg"
---

<div class="article-description" style="text-align: center; font-size: 1.3em; color: #555; margin: 20px 0 30px 0; font-weight: 500;">从安装到部署GitHub Pages的完整指南</div>

Hugo is a fast and flexible static site generator that makes building websites fun again. In this post, I'll share my experience of setting up this blog with Hugo and deploying it to GitHub Pages.

## Why Hugo?

When I decided to start a blog, I evaluated several options:

- **WordPress**: Powerful but requires database and hosting
- **Jekyll**: Good, but slow build times for large sites
- **Hugo**: Blazing fast, single binary, no dependencies

Hugo won me over with its speed - it can build this entire site in under 100ms!

## Installation

Installing Hugo is straightforward:

```bash
# On macOS with Homebrew
brew install hugo

# Verify installation
hugo version
```

## Creating Your First Site

```bash
# Create a new site
hugo new site my-blog

# Add a theme (using cleanwhite theme)
cd my-blog
git submodule add https://github.com/zhaohuabing/hugo-theme-cleanwhite themes/hugo-theme-cleanwhite
```

## Writing Your First Post

```bash
# Create a new post
hugo new posts/my-first-post.md
```

Edit the markdown file with your content. Remember to add a cover image:

<!-- more -->

## Building and Deployment

Build your site:

```bash
hugo --minify
```

The generated files will be in the `public/` directory, ready for deployment.

## GitHub Pages Deployment

The easiest way to deploy is using GitHub Actions:

1. Push your Hugo site to GitHub
2. Enable GitHub Pages in repository settings
3. Add the GitHub Actions workflow file
4. Push changes - automatic deployment!

## Tips and Tricks

### Organization

- Keep your images in `static/img/`
- Use `tags` and `categories` for better content organization
- Create `_index.md` files for section pages

### Performance

- Always use `--minify` flag for production builds
- Optimize images before adding them
- Enable caching headers on your server

### Content

- Use `<!-- more -->` to create summary/excerpt on homepage
- Add meaningful tags for better discoverability
- Write compelling descriptions for SEO

## Conclusion

Hugo makes blogging simple and fast. This entire blog was built with Hugo, and I'm happy with the results. The combination of Hugo + GitHub Pages provides a free, fast, and reliable hosting solution.

Have questions? Feel free to reach out or leave a comment below!

---

Happy blogging! 🚀
