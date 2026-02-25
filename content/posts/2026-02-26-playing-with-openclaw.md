---
title: "这两天在玩 OpenClaw"
date: 2026-02-26T02:00:00+08:00
draft: false
description: "MacBook 的含金量还在上升"
tags: ["OpenClaw", "Agent", "Life", "随笔", "tech", "workflow"]
categories: []
author: "Brighton"
image: "img/openclaw-cover.png"
thumbnail: "img/openclaw-cover.png"
---

<div class="article-description" style="text-align: center; font-size: 1.3em; color: #555; margin: 20px 0 30px 0; font-weight: 500;">MacBook 的含金量还在上升</div>

<div style="text-align: center;">
<img src="/img/openclaw-pipeline.png" alt="OpenClaw Pipeline" style="max-width: 80%; height: auto; border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.1);">
</div>

MacBook 的含金量还在上升。

了解我的都知道去年下半年，我的主力机从拯救者替换成 MacBook Air M4 了，原本只是为了轻便和续航，以及拯救 Ubuntu 灾难级别的桌面表现，有时候我确实要复现环境需要，弄个远程还是方便多了。然后，拯救者现在变成了固定在宿舍网口的 Ubuntu 20.04 自用服务器，用 tailscale 公网 ssh + Claude Code 调教的舒服的一，解决了没有公网 ipv4 以及 ssh 原生命令行不好用的情况（额，我有时候真的把 CC 当做一个智能命令行使用）。

<!-- more -->

最近 AI Agent 平台 OpenClaw 非常火，我看了下感觉有点融不进去我的工作 pipeline，感觉都是文科生工作，但还是探索了一下。OpenClaw 的部署需要一个能长期联网服务器，你说巧不巧，塞到拯救者里面了，完全不需要购入 Mac Mini。

玩了一段之后，说实话还在摸索。目前初步设计了一个信息整合的 pipeline，关注科技和财经等，定时早晚投送到我的 tgbot 里面。后面也许还可以玩一些交易的东西，也许给他几十个 usdt 自己玩？或者量化交易韭菜初体验？（我的 HSBC 和 ZA 搞好了，还获得了老妈的巨量天使轮。可惜的是好像没有找到合适的 api，或者说合适的 api 平台如 ibkr 狗与 \_\_\_\_\_ 不得入内）

api 方面还是继续用的 z.ai 的 coding plan。我当时 lite 用腻了，发现 pro 还有速度提升，就升级了，90 块 1 个月还算能接受。接入龙虾之后 2 天就用了 1 亿多 tokens，智谱老总真得亏得坐公交。关键是我还是老套餐，没有周限额的用 glm-5，含金量又上升了，90 块用出了 900 块的效果。我还用不完小时限额，给了个 api 到朋友的龙虾！

虽然开学了，但这个是真的好玩，一玩几个小时就过去了，等我忙里偷忙继续探索这玩意吧，确实可能性太多了。

---

对了，附上我目前的 pipeline 输出，大概看上去还有模有样的，我还在微调以及加新的玩意，主要是可以设计定时任务太方便了：

<div style="text-align: center;">
<img src="/img/openclaw-link.png" alt="OpenClaw Pipeline" style="max-width: 80%; height: auto; border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.1);">
</div>

<details>
<summary style="cursor: pointer; font-weight: bold; color: #007bff;">👇 点击展开查看：Brighton的小秘书完整输出示例 (2026-02-26)</summary>

<br>

## 📰 Brighton的小秘书 - 完整信息汇总

🕐 2026年2月26日 01:52 GMT+8 (Refresh)

### 🔥 重磅关注 (深度分析)

**【NVDA 财报今晚盘后公布：AI 市场的最大考验】**

• "Nvidia's earnings report comes at a critical time for the US stock market with investors increasingly nervous about the outlook for artificial intelligence"
• "The tech-heavy Nasdaq 100 rose 1.2% ahead of earnings"
• "More than solid results and forecasts, Nvidia will need to manage expectations around the sustainability of margins amid an AI spending frenzy"

📊 **核心数据：**
• 期权隐含波动仅 5.6%（三年来最小）
• 市场预期：EPS $1.53，营收 $65.8B
• 关键看点：Blackwell 芯片销量、中国区收入、毛利率

💡 **深度分析：**
NVDA 当前市值 $4.5T，占标普 500 约 6.7%。财报结果将决定：

1. AI 投资热潮是否可持续
2. 科技股短期走向
3. 市场对 AI 估值重新评估

来源：Bloomberg, Yahoo Finance, MarketPulse

---

**【OpenAI 与 Anthropic 毛利率危机：AI 盈利模式的严峻考验】**

• "OpenAI去年毛利率从40%降至33%，低于其自身预测的46%"
• "OpenAI推理成本同比增长约四倍，达84亿美元，高于其去年夏天预测的66亿美元"
• "付费用户占比仅约5%，近半数推理成本用于支撑非付费用户"
• "Sora视频生成工具对服务器算力消耗远高于文本查询"

📊 **财务数据：**
• OpenAI：毛利率 40%→33%，推理成本 $84B
• Anthropic：毛利率从-94%改善，但预计2025年40%（低于目标10个百分点）
• 付费用户效率：算力利润率从35%升至70%

💡 **深度分析：**

1. 推理成本失控：云服务商按需资源溢价推高成本
2. 免费用户负担：95%用户免费，消耗50%推理成本
3. 产品结构：Sora、推理模型算力消耗远超预期
4. 长期目标：2030年毛利率67%，但挑战巨大

影响：AI 行业盈利模式面临考验，可能影响整体估值

来源：The Information via 华尔街见闻

---

**【AMD 与 Meta 达成重大 AI 芯片合作：NVDA 的有力竞争者】**

• "AMD stock surges 14% on Meta AI partnership deal"
• "AMD Just Won Another Massive AI Chip Deal. Its Stock Is Soaring"
• "Is AMD Stock Going to $300 After the Meta Platforms Deal?"

📊 **市场影响：**
• AMD 股价大涨 14%
• Meta 选择 AMD 作为 AI 基础设施供应商
• 市场预期 AMD 或达 $300

💡 **深度分析：**
AMD 正在成为 NVDA 在 AI 芯片市场的有力竞争者。Meta 的大单意味着：

1. 大客户开始多元化供应商
2. AI 芯片市场竞争加剧
3. NVDA 的垄断地位受到挑战

来源：Yahoo Finance

---

### 📊 市场情绪分析

**【美股情绪】**

• **VIX 波动率：达到 2026 年峰值** 🔴
  - "VIX surged to levels not seen since the turbulent period"
  - 2/24 软件股恐慌，AI 担忧加剧

• **Fear & Greed：极度恐慌** 🔴
  - Crypto Fear & Greed Index: ~17 (极度恐慌)
  - S&P 500 Software Index 跌 20%

• **情绪：恐慌中等待 NVDA 财报方向** 🔴
  - AI spending skepticism 上升
  - 投资者 nervous about AI outlook

**【A股情绪】**

• **恐贪指数：结构分化** 🟠
  - 大盘蓝筹：中性平衡
  - 创业板/科创板：极寒地带（历史低位）

• **资金流向：主力抄底** 🟢
  - 散户：割肉离场
  - 主力：逆势加仓
  - "散户恐惧时主力贪婪"

**【港股情绪】**

• **恐贪指数：分化严重** 🟠
  - 恒指：热度较高
  - 科技股：情绪低迷

• **资金流向：南向资金回流** 🟢
  - 2/25：反弹，资金回流

---

### 📊 美股动态

**【2/25 市场表现】**
• 道指涨 370 点，科技股反弹
• 纳指涨 1.2%，静待 NVDA 财报
• 现货黄金日内涨超 1%

**【七巨头动态】**
• NVDA：财报在即，期权隐含波动5.6%
• AMD：因 Meta 合作大涨 14%
• META：AI 基础设施投资加速

---

### 🇭🇰 港股异动

**【2/25 反弹】**
• 恒生指数涨 0.66%，科技指数跌 0.19%
• 2/23：恒指涨 2.29%，科指涨 3.32%
• 美团涨近 7%，腾讯、阿里涨超 3%

**【核心观点】**
• AI 取代软件的悲观情绪缓解
• 科网股回暖
• 南向资金回流

---

### 🤖 AI 领域

**【中国 AI 大模型格局】**
• 第一梯队：阿里通义千问、字节豆包、百度文心
• 第二梯队：DeepSeek、Kimi、智谱 GLM
• 春节红包大战：四大巨头狂撒超 50 亿

**【技术突破】**
• Guide Labs 发布可解释 LLM Steerling-8B
• Google Gemini 3.1 Pro：1M 上下文，ARC-AGI-2 达 77.1%
• Claude vs GPT vs Gemini: 2026 模型对比

---

### 🔬 学术论文

**【arXiv 最新】**
• cs.AI/cs.LG 最新论文持续更新
• 可解释 LLM 成为热点
• 多模态模型进展

**【GitHub 趋势】**
• AI Agent 项目持续火热
• LLM 推理优化工具
• 开源模型生态繁荣

---

### 💰 其他要闻

**【CoreWeave 85 亿美元融资】**
• 以 AI 芯片 + Meta 云合同为抵押
• 利率约 6%，获 A- 评级
• 摩根士丹利与三菱日联参与

**【Fed 政策】**
• 维持利率 3.5%-3.75% 不变
• 2026 或降息两次
• 就业疲软，通胀高企

**【甲骨文】**
• 奥本海默上调至"跑赢"
• 目标价 $185
• 大跌之后即是买入机会

---

⏰ **定时推送：** 早间 9:30 | 晚间 20:00
🔍 **突发监测：** 每小时 (8:00-23:00)
📊 **情绪分析：** 每次推送自动更新

</details>
