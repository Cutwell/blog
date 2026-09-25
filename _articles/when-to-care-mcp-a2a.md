---
layout: post
title: MCP, A2A, and when to care
categories:
  - AI
last-updated: 2026-05-22
draft: true
---

The Model context protocol (MCP) and the Agent to agent protocol (A2A) are both popular concepts trying to formalise the most basic issues with agents:

1. How do you unify tooling so a provider (e.g.: GitHub) can share tools with consumers (developers, customers, etc.) that enable agents to perform platform actions?
2. How do we allow agents to communicate (for the purpose of delegation, etc.) in a framework-agnostic manner?

The current answers are MCP and A2A, respectively.

---

## Threat factors

Let's zoom out first: what is the point of MCP? The core offering is to provide tools in a quick plug-and-play method. What are those tools? For a lot of providers, they're interfaces for their existing API offerings, possibly with some wrapping to make LLM interaction easier. The idea is that developers don't need to maintain their own tools, making provider integrations faster, and allowing for the provider to offer the tool implementation that works best.

These benefits are strong, but also present some obvious issues:

1. Developers don't own 100% of their agent code - tools are injected into agent context after the agent makes a generic `list_tools` call.
2. Trusting providers to offer the best tool implementation assumes a generic "one-size-fits-all" tool will fit your use-case. Often this is not the case.
3. When tool calls are made, context can be egressed from your agent environment. Tools don't execute locally, they execute in the providers environment.

For a single-purpose agent these concerns might be unwarranted, but consider an agent that accesses internal data _and_ uses MCP tools - this data might be egressed to the provider accidentally (or maliciously) - at best a compliance failure, at worse a security breach.

Let's consider A2A as well: swap out tools for sub-agents and the landscape looks exactly the same - A2A lets agents communicate and delegate work to other agents, which is great as long as you can trust every agent in the chain, otherwise its a threat.

---

## When to care?

The message I'm trying to convey is not that MCP and A2A are fads - they've persisted long enough to be burgeoning on "standards" for the fledgling agentic industry - but instead that they should only be applied in specific scenarios and with proper respect to their weaknesses. Shoehorning a protocol for the sake of experimentation should be reserved for test projects and initiatives, not serious production work.

### When should you use MCP?

|Scenario|MCP?|
|:---:|:---:|
|Single agent with simple custom tools|No, introducing MCP here (i.e.: to separate your agent and tools) is over-engineering, as MCP would just introduce a latency with no benefit.|
|Single agent with an slow/sensitive tool|Yes, MCP would be beneficial here - moving the expensive tool to a separate environment would allow it to e.g.: be sandboxed for data privacy / security, or ran on a high powered machine. An agent server should be highly async and non-blocking, so moving expensive tool processes out of the environment makes sense.|
|Multiple agents with shared tools|Yes, this is the golden use-case of MCP - in this case the tools can be internally developer, or from a provider - custom MCP servers work just as well as provider-offered MCP.|

### When should you use A2A?

This problem is easier - most modern frameworks (ADK, LangGraph, etc.) all support A2A natively, meaning as long as you develop with one of these frameworks then you're already A2A compliant. Wether you should be bringing external agents into your agents environment via A2A, however, depends on the threat factors we set out above.