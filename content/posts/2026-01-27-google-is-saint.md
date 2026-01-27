---
title: "论谷歌为什么是圣人"
date: 2026-01-27T22:50:00+08:00
draft: false
keywords: ["Google", "AI", "Gemini", "Nano Banana"]
description: "我那颠沛流离的白嫖谷歌记录"
tags: ["Tech", "Life", "随笔", "Google", "workflow"]
categories: []
author: "Brighton"
header_image: "img/google_heading.png"
image: "img/google_heading.png"
thumbnail: "img/google_heading.png"
---

<div class="article-description" style="text-align: center; font-size: 1.3em; color: #555; margin: 20px 0 30px 0; font-weight: 500;">我那颠沛流离的白嫖谷歌记录</div>

## Proof 1：前AIStudio几乎Unlimited usage

不管你承不承认，Gemini 2.5Pro在25年前中段都是无敌的存在。我并非没有吃过细糠，使用过一段时间的GPT5订阅版，包括Thinking模型以及它自称很牛的Pro模型，但实际输出耗时和说人话程度都不如在AIStudio免费使用的2.5Pro。

2.5Pro也是第一个让我感觉到比我个人能力强，可以帮我干一些重活的模型。以及我的几次考试复习全部都是通过这个prompt辅助复习的，如果没有高效的模型，效率必然会大打折扣：

> 现在我正在进行这门科目的学习，你的要求如下，必须严格遵守：1.对于日常语言，你必须使用中文，但是如果遇到你认为必要或者关键的英语专业名词，可以适当使用英文表示或者双语对照（但是，如果专业名词或者关键词没有合适中文，可以不用双语），这不仅在这次解释中要遵循这个规则，在以后的对话中也要遵循。2.根据课件内的内容，首先大概的过一遍课件内所囊括的知识点，这一边是为了让我熟悉课件内容，并带有讲解。然后，仔细的讲每一页课件中所有知识点与细节(NOTICE: PAGE BY PAGE)，如果必要，附上例子（可以为知识点应用例子，也可以是代码块）。3.有些知识点稍微复杂和难理解，你可以在这之外适当加入一些容易理解的内容，但注意这种内容当且仅当你认为这个知识点很难理解。4.课件内无关的课程信息不需要讲解。然后，在最后，给出一些面向关键概念或者容易混淆、不易理解知识点的小测试（quiz）并附上解答。5.禁止在你的回答中加上cite或者[cite_start]，你只用线性过一遍课件。6.同时记住这个提示词，我们的对话会包括多次课件内容解释以及答疑解惑，在我提出的问题中你要积极使用课件知识，并且在我传入新的课件内容的时候要继续严格遵循以上规则。同时，如果你可以设置这次对话的标题，将其设置为 例如[CS203(if exist), or Compiler(if not found)][lecture number] Overview。

可惜，AIStudio现在已经被砍废，每日usage已经跌落到几乎不可用的地步（据说是每个模型10~20轮对话）。但是这并不妨碍，请看Proof 2。

## Proof 2：Google One 学生一年试用

13块在麦当劳吃不到一个1+1。但在闲鱼可以搞定sheerid认证和绑卡。我可以享用一年时长的学生试用Pro待遇，包括Antigravity（我这两天在尝试反向API弄到CC，但是我的账号地区一直有问题），几乎用不完的Gemini官网使用，以及2TB的网盘。

说实话，虽然我这样操作有欺诈嫌疑，但难道我不是大学生吗？（逃）

<div style="text-align: center; margin: 30px 0;">
<img src="/img/proof2.jpg" alt="Google One学生认证" style="max-width: 80%; height: auto;">
</div>

## Proof 3：Nano Banana Pro

我用的生图模型比较少，据说市面上有很多很强的生图模型，但是大多数都要收费。我之前都是用的一个enterprise试用一个月在用Nano Banana。有了上面的Google One之后，我也拥有了一年的无限制使用Nano Banana Pro权利。

什么叫你不知道这玩意有什么用？请看下面的例子：

<div style="text-align: center; margin: 30px 0;">
<img src="/img/demo_dl.png" alt="Nano Banana Pro一稿出效果" style="max-width: 80%; height: auto;">
<p style="color: #666; font-size: 0.9em;">Nano Banana Pro一稿出效果</p>
</div>

<div style="text-align: center; margin: 30px 0;">
<img src="/img/demo_cp.png" alt="Nano Banana Pro少量尝试效果，配部分人为的排版修改" style="max-width: 80%; height: auto;">
<p style="color: #666; font-size: 0.9em;">Nano Banana Pro少量尝试效果，配部分人为的排版修改</p>
</div>

<div style="text-align: center; margin: 30px 0;">
<img src="/img/demo_car.png" alt="Nano Banana Pro面对复杂场景的图片生成效果，多稿仍然有瑕疵，但勉强能看" style="max-width: 80%; height: auto;">
<p style="color: #666; font-size: 0.9em;">Nano Banana Pro面对复杂场景的图片生成效果，多稿仍然有瑕疵，但勉强能看</p>
</div>

至少在我这个学习阶段，面对一些report的图片需求，Nano Banana Pro已经足够胜任了。写一个简单的生成图像的prompt就能让report精致程度翻几番，实在是一个稳赚不赔的生意。

以及真的需要自己写prompt吗？其实来一个通用元prompt就够了：

> 帮我把这一块的内容转化成为一段用于生成图像的prompt。我们的图像风格应该是严谨的IEEE Trans插图风格，应该看起来简洁且干练。你需要先构思如何巧妙的转换成一个容易理解的配图，然后仔细的描述图片的每一个部分应该有哪些元素，元素之间的位置关系，以及硬编码一样的显式的写明在哪里应该写哪些文字。

大致流程图是这样的，这张图片怎么来的就不用再讲一遍了：

<div style="text-align: center; margin: 30px 0;">
<img src="/img/demo_pre.png" alt="流程图生成示例" style="max-width: 80%; height: auto;">
</div>

好吧。白嫖了谷歌这么多，的确是有点羞愧，要是以后有机会被谷歌剥削回去就能让我不这么羞愧了吧。
