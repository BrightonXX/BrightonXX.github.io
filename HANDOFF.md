# 交接文档 · Brighton's Blog 改版

> 给下个 session 的 agent。用户 Brighton 在做 Hugo 博客从老主题迁移到卡片化设计。本会话做了大量修复 + 一个进行中的 Apple 风缩放 hero。**用户审美要求高、性子急,改之前先用工具查清楚(别靠记忆猜,他会上火),改之后必须截图/curl 验证。**

## 项目概况
- **路径**:`/Users/brighton/Desktop/ProjectFinal/Web/blog/`
- **SSG**:Hugo v0.154.5+extended
- **主题**:hugo-theme-cleanwhite(git submodule,`themes/hugo-theme-cleanwhite/`)
- **线上**:https://brightonxx.github.io/(repo: BrightonXX/BrightonXX.github.io)
- **本地预览**:`hugo server -D -s /Users/brighton/Desktop/ProjectFinal/Web/blog`(注意 `-s` 指源目录,工作区不是 git 根,git 命令要 `git -C <blog路径>`)
- **作者**:`BrightonXX <x2005jiay@gmail.com>`(commit 不加 co-author)

## 架构要点
- **首页/Archive/Tags/About 是双列内部滚动**:`.home-posts`(height calc(100vh - 60px - 18px))> `.row`(flex) > `.post-container`(flex:1, overflow-y:auto,内部滚动) + `.sidebar-container`(fixed 280px,内部滚动)。**不是 body 滚动**——scroll 监听要绑 `.post-container`,不是 window。
- **文章详情页**:`.post-article > .container > .row`(改成了 flex,为了 catalog sticky),三列(reading-tools / 正文 / catalog)。catalog sticky 靠 `.catalog-container{position:sticky}` + 父级 `.row` flex。
- **样式**:`static/css/override.css`(**untracked 新文件**,核心),加载在 head.html 内联 style 之后(优先级高)。设计 token 在 `:root`(--bg/--surface/--accent #0085a1/--r 12px/--shadow-sm/md 等),暗色 `html[data-theme="dark"]`。
- **模板查找**:首页 `layouts/index.html` → `portfolio.html` partial → `posts.html`(含 hero + 打字机 + 缩放 JS) → `post_list.html`(文章卡片 + load-more 按钮) → `post_load_more_js.html`(无限滚动 JS)。

## 本会话已完成(都已验证)
1. **catalog 目录填充**:`layouts/partials/footer.html` 极简化时丢了主题的 `generateCatalog`,目录永远空。已移植回 footer.html(在 `{{ if not (eq (.Param "showtoc") false) }}` 里)。
2. **文章页 sticky 失效**:`layouts/partials/head.html` 把 `.post-article > .container > .row` 改 `display:flex; align-items:flex-start`(原来 float col 上 Safari sticky 失效,catalog 滚走)。
3. **load-more 点不动**:`layouts/partials/post_load_more_js.html`(新建)——把 JS 从 posts.html 提取成 partial,`post_list.html` 末尾引用,这样首页(posts.html)和 tag 页(tag.html)都用 post_list 就都有 JS。`tag.html` 还删了重复的传统分页条。
4. **focus-status 卡片扁平化**:原来立体(渐变+投影+pill badge)。重构成 B+ 版:左 3px accent 条(状态色) + badge 去框(纯文字) + ghost 按钮 + dot 涟漪(box-shadow currentColor)。在 `override.css` 的 `.sidebar-container .focus-status-*` 段。sidebar.html 删了 focus section 上方的 `<hr>`。
5. **footer 一屏**:`override.css` `.home-posts{height:calc(100vh - 60px - 18px)}`(减去 navbar 60 + footer ~18),footer 不再溢出视口。
6. **page-head 左 padding**:Tags/Archive/About 标题两行字("Tags/X tags" 等)之前左 10px(和文章卡片 24px 不对齐,像贴边消失)。改成 24px 对齐文章卡片。
7. **sidebar tags 行距 + 备份**:`blog-backup-pre-redesign-20260630.tar.gz`(65M,源码级,在 `Web/` 目录外)。

## ⚠️ Apple 风缩放 hero(进行中,核心未完成)

**目标**:首次进首页 → 全屏大圆角卡片(背景图 + Brighton's Blog + slogan)→ 往下滚 → 缩成横向小卡片(= Tags 页 tag-card 同款)→ 继续滚卡片正常上划划走(不淡出)→ 文章涌上。一次性(sessionStorage),第二次进默认卡片但 scroll 仍响应。仅首页。

**代码位置**:
- `layouts/partials/posts.html` 末尾 `<script>`(IIFE)——hero 缩放全部逻辑。
- `static/css/override.css` `.home-intro.is-hero` / `.is-collapsed` / `.post-container .js-post-stream`。

**当前机制**(最新一版):
- `is-hero`:`position:sticky; top:0; z-index:3; height:calc(100vh-78px)`。sticky 钉顶,height 固定(占位不变,避免 scroll 跳动)。
- JS `update(scroll)`:smoothstep(p)插值 `height`(fullH→72) + `margin-bottom`(fullH-h 补偿占位) + `border-radius`(28→12) + `box-shadow`(→shadow-sm) + `padding`(0/40/40 → 14/18/14,=tag-card) + 字体(title 60→16, sub 24→12.5,=tag-card__name/count)。
- 文章列表 `.js-post-stream` 加 `translateY((p-e)*RANGE)` 跟随 smoothstep(否则 hero 非线性 vs 文章线性脱节)。
- `RANGE > scroll` 后:`hero.style.transform = translateY(-(scroll-RANGE))` 卡片上划划走(不淡出)。
- `RANGE = fullH - cardH`。
- 第二次进(sessionStorage `homeHeroPlayed`):也走 is-hero,但 `pc.scrollTop = RANGE`(初始卡片态,不播全屏动画),scroll up 仍能恢复。
- `?replay=1` URL 参数:强制重播(忽略 sessionStorage),测试用。

**用户反馈的未解决问题**(按重要度):
1. **缩放和文章移动还是有点脱节**:hero 用 smoothstep(慢-快-慢),文章用 translateY 补偿同步,但用户说仍有"一开始拉瞬间重合一下,再拉间距突然变大"。补偿公式 `(p-e)*RANGE` 不完全对——可能要重新推导 stream translateY,或干脆 hero 改线性(放弃 smoothstep 苹果感)。
2. **缩完卡片和 Tags 的 tag-card 还有微小差别**:已对齐 padding 14/18、radius 12、shadow-sm、字体 16/12.5,但 hero 有背景图 + 2 行(title+slogan),tag-card 是 flex(name+count)。用户说"必须一样"。可能要去看 `.tag-card` 实际渲染,逐属性对齐。
3. **最后阶段两卡片紧贴**:stream margin-top 现在是 48px,RANGE 后 hero translateY 划走时和第一篇文章的间距会变(划走速度 1:1 跟 scroll)。
4. **cardH=72 太小可能也成问题**:hero 缩到 72px,标题 16px,品牌标题偏小。

**测试方法**:`http://localhost:1313/?replay=1` → 慢慢滚。headless 截图要建 wrapper(`static/hero-real.html`,iframe 首页 + `pc.scrollTop=s; pc.dispatchEvent(new Event('scroll'))`——**注意:headless 里 programmatic scrollTop 不自动触发 scroll event,必须 dispatchEvent;且 rAF 在 virtual-time 不推进,所以 scroll listener 要直接调 update 不能包 rAF**)。

## 待办
- **[高] hero 缩放优化**:脱节 + 卡片同款(见上)。
- **[中] push**:`git -C <blog> add -A && commit && push origin main`。改动量大且交织(override.css 一个文件含所有样式),建议一个大 commit(feat: 首页改版 + 迁移修复)。push 前确认 hero 状态用户满意。
- **[低] LAST POSTS sidebar padding**:用户说上下不平衡(顶部 5px / 底部 2px),说要 balance,后来搁置了。`.sidebar-container > section{padding:5px 0 2px}`。

## 临时文件(用完删,别 commit)
- `static/hero-real.html`(hero 截图 wrapper)
- `static/proto/`(更早的首页原型对比页,a.html/b.html/c.html/d.html/index.html)

## 关键文件清单
| 文件 | 作用 |
|------|------|
| `static/css/override.css` | 核心样式(untracked),设计 token + 所有改版样式 + hero 缩放 CSS |
| `layouts/partials/posts.html` | 首页 hero + 打字机 + **hero 缩放 JS** |
| `layouts/partials/post_list.html` | 文章卡片 + load-more 按钮(末尾引用 post_load_more_js) |
| `layouts/partials/post_load_more_js.html` | 无限滚动 JS(新) |
| `layouts/partials/footer.html` | 极简 footer + generateCatalog(JS 目录生成) |
| `layouts/partials/head.html` | head + 内联 CSS(catalog sticky flex、focus-status 基础、暗色) |
| `layouts/partials/sidebar.html` | 侧栏(focus-status、tags、last-posts) |
| `hugo.toml` | 配置(social: email/rss/github/zhihu) |

## 用户偏好(踩过的坑)
- **别用 body{display:flex}** 破坏 Bootstrap 布局(之前炸过,要求回滚)。
- **改前查 CSS 值,别靠记忆**:他发现 page-head 左 padding 不对,我靠记忆说"没改",其实该 grep。
- **截图用 chrome headless**:`"/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" --headless=new --disable-gpu --hide-scrollbars --force-device-scale-factor=1 --screenshot=/tmp/x.png --window-size=1440,900 --virtual-time-budget=5000 URL`。多 agent 分析图用 `mcp__zai-mcp-server__analyze_image`。
- 他要"认真做,不要原型",但其实需要对比时还是会接受演示页(`?v=` / `?s=` URL param 切换)。
