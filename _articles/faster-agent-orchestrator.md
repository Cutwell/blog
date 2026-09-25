---
layout: post
title: 
categories:
  - AI
last-updated: 2026-05-20
draft: true
---

Agentic systems are moving beyond simple single-agent paradigms - the idea of using multiple agents in an "orchestrator - sub-agent" pattern has existed almost as long as the agentic pattern itself, but its viability has varied over time.

One of the core issues is that the orchestrator adds significant overhead to the system, but in the case of routing natural-language queries to appropriate sub-agents, there isn't an obvious alternative that doesn't require changes to your UX.

That being said, we can always experiment with deep learning, rather than following the current practice of utilising an LLM call for every natural-language issue.

---

To define our problem more robustly:

1. Using an LLM as an agentic orchestrator is undesirable, especially if it's sole purpose is to route to sub-agents: you waste money (tokens) and time waiting for a massive model to process your response.
2. Small models can execute in a fraction of the time, and raise reasonable performance on domain-specific problems (such as classifying queries towards the most appropriate sub-agent).
3. If router performance isn't matching llm-as-a-router, modern frameworks support a fallback option - if the routed sub-agent can't answer the query, it can re-route to a better agent to answer. This has zero performance loss vs. the "llm-as-a-router" model as the initial small model routing is practically instantaneous.

---

