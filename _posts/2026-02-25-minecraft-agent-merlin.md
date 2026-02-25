---
layout: post
title: Merlin - Building a better chatbot than Microsoft/Mojang
categories:
  - AI
---

## The competition - who is Merl? ![merl](/_posts/2026-02-25-minecraft-agent-merlin/merl.webp)

[Merl](https://help.minecraft.net/hc/en-us/articles/38053285673229-About-Merl-the-Minecraft-Support-Virtual-Agent) is a Minecraft AI agent build by Microsoft/Mojang, to help users visiting the Minecraft help center.

![merl UI](/_posts/2026-02-25-minecraft-agent-merlin/merl-screenshot.webp)

Visually, the agent is interesting, but as soon as you start communicating with it you realise it seems to know nothing about the game it claims to support.

I'm a long-time Minecraft fan, creating an account way back in 2012 and playing periodically ever since. Chatting to Merl it felt as if none of the staff at Mojang had any input on this agent, which is unfortunate as it has become somewhat notorious in the community.

So why is it bad? Let's look at an example (and compare against our own agent, Merlin, for fun):

|Merl ![merl](/_posts/2026-02-25-minecraft-agent-merlin/merl.webp)|Merlin ![merl](/_posts/2026-02-25-minecraft-agent-merlin/merlin.webp)|
|:--:|:--:|
|![merl answering how long a creeper takes to explode](/_posts/2026-02-25-minecraft-agent-merlin/merl-creeper-question.webp)|![merlin answering how long a creeper takes to explode](/_posts/2026-02-25-minecraft-agent-merlin/merlin-creeper-question.webp)|

First of all, Merl doesn't even try to answer the question - which is strange since it's likely utilising the same family of LLM models as ChatGPT in the background, [who can answer it just fine when asked](https://chatgpt.com/share/699ef865-f014-8006-976a-716e39ef917e). What this indicates is that some highly restrictive filtering / model armour is in place to prevent Merl from answering questions wrong / going off-topic, at the cost of a far worse user experience.

Next, note exactly what Merl replies with - they "don't have that information in the knowledge base". It's likely that Merl is a simple [RAG](https://en.wikipedia.org/wiki/Retrieval-augmented_generation) chatbot, with a small set of articles from the Minecraft help center to guide it's answers. Because Merl is only available on the help center website, it is reasonable for us to assume it has highly limited scope - in fact it even says so in it's welcome message ("I can answer questions you have about the Help Articles on this site.").

So why is this a disappointment to the community? Let's dig into it.

### Issue #1 - the "big bad"

Merl is an AI agent, powered by a large language model. This form of AI is highly controversial, particularly amongst Gen Z / Alpha (the primary audiences for Minecraft). Although the business world has adopted AI into the heart of it's practices, other communities, particularly gamers, have been more resistant to what is often percieved as "low value" or (graphically) "AI slop" products that either remove humans from the process of game creation (AI concept art, assets, voice acting, code), or try to force adoption where it's unwelcome (such as Merl).

These concerns are valid - Microsoft's aqcuisition of Mojang was seen as a red flag and a sign of impending [enshittification](https://en.wikipedia.org/wiki/Enshittification). Since then, the studio has largely avoided being obviously absorbed into Microsoft / being affected by its infamous product culture, but some see peripheral products like Merl as a sign of things to come.

### Issue #2 - not worth your attention

Putting aside Microsoft politics, it's important to also consider the product in isolation. Whilst Merl is capable of answering help center articles quickly, this limited scope severely limits its use and is often overlooked by pundits. Whilst this oversight is likely deliberate for some, it is fair to expect a Minecraft chatbot to be able to answer questions about the game itself.

Minecraft is a game about exploration and discovery, with limited tutorials and in-game information about how to proceed. In the past, users have relied on fan-made forums to learn about game mechanics and share knowledge, and in the age of Generative AI it is reasonable to expect an agent like Merl to be able to answer those same questions.

Except, as we've seen, it can't. 

## Enter Merlin

<div style="width:100%;aspect-ratio:16/9;">
<iframe width="100%" height="100%" src="https://www.youtube.com/embed/vWg5fiL5OQM?si=nUPegPSvdBJZEelu&controls=0&rel=0&modestbranding=1&iv_load_policy=3" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>
</div>

Onto the engineering section of this blog post - how I made Merlin. As we saw in the side-by-side comparison, our own chatbot seems to lack any of the flaws of Merl, but how was this achieved?

First, let's talk about tooling. Merlin has only two tools available to it:

1. Recipe Search (fuzzy search 1000+ JSON recipes)
2. Wiki Search (fetch content from [help.minecraft.net](help.minecraft.net) or [minecraft.wiki](minecraft.wiki))

#### Recipe search

* Agent searches using keywords, and recieves relevant recipes.
* Recipes are JSON objects with information about the recipe grid, ingredients required, alternative recipes, etc.

The visualisation for this tool was important - in Minecraft players can interact with a number of in-game interfaces to craft new resources, cook food, or upgrade their gear, and I wanted to render these recipes for users rather than rely on clunky textual descriptions. The solution already existed inside the JSON objects - a structured format detailing how to render each recipe, and the appropriate interface to use.

|Crafting a furnace|Cooking steak|Upgrading an axe to Netherite|
|:--:|:--:|:--:|
|![furnace recipe](/_posts/2026-02-25-minecraft-agent-merlin/furnace-recipe.webp)|![steak recipe](/_posts/2026-02-25-minecraft-agent-merlin/steak-recipe.webp)|![netherite axe recipe](/_posts/2026-02-25-minecraft-agent-merlin/netherite-axe-recipe.webp)|

In my opinion, small details like this elevate a chatbot experience.

#### Wiki search

* Similar to recipe tool - search using keywords, to retrieve wiki documents
* Searches across both the official [help.minecraft.net](help.minecraft.net) and unofficial [minecraft.wiki](minecraft.wiki) wikis for Minecraft information.
* The behaviour for each site is slightly different:
  * [help.minecraft.net](help.minecraft.net) is a small list of articles, pre-cached locally.
  * [minecraft.wiki](minecraft.wiki) is much larger (hundreds of articles), so we leverage a 2 step process: 1) load a search page to list relevant articles based on search query, 2) return the most relevant page. This 2-step process adds a small amount of latency, but allows us to leverage the [minecraft.wiki](minecraft.wiki) search engine, resulting in better results.

Visualisation of wiki searches is less about engagement and more about attribution - by linking back to wiki pages the agent searches for, we build trust in the agent, as the user understands where answers are coming from and can self-verify information when needed.

|Reading the "Creeper" wiki page|
|:--:|
|![creeper wiki](/_posts/2026-02-25-minecraft-agent-merlin/creeper-wiki.webp)|

### Full-stack engineering

After establishing the agent tooling, wrapping it together with a tool-capable LLM (I chose Claude Haiku 4.5) and deploying as an API was trivial. We're not concerning ourselves with full productionisation for this demo, so we skipped steps like user authentication or a database to store conversations.

![Merlin in Blockbench](/_posts/2026-02-25-minecraft-agent-merlin/blockbench.webp)

Building the frontend was interesting - I've plenty of chatbot experience, but I've never worked with 3d scenes. To animate Merlin I utilised [Blockbench](https://www.blockbench.net/), a desktop app with specific features for rendering Minecraft skins onto a pre-made 3d model. I animated his various reactions using keyframes, and despite it being my first attempt with such software I'm pleased with how he turned out.

As for the background, I dug into the assets of Merl and found they're placed in a real 3d scene. To avoid going too deeply down a 3d rabbit hole for a GenAI project, I took a shortcut - I loaded up Minecraft, created a set in-game, loaded the [Bare Bones](https://www.planetminecraft.com/texture-pack/bare-bones/) texture pack, and used a screenshot (sometimes quick hacks can look just as good as the real thing...).

## What's next?

I don't plan on releasing Merlin as a public service - running a public chatbot in 2026 is just a good way to burn credits. However I do plan to revisit this project as part of a planned weekend project on web-LLMs, as it seems Merlin has a recieved a fair amount of interest on [Reddit](https://www.reddit.com/r/PhoenixSC/comments/1pxzy5m/i_coded_merls_wiser_more_capable_older_brother/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button), from players looking for an AI companion for the game.
