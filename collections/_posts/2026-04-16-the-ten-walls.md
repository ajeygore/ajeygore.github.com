---
layout: post
title: "The Ten Walls"
published: true
categories: [AI, Building, Products]
description: "In my last post I wrote about the small island of delight — the agent — surrounded by a sea of ops work. This is the map of that sea. Ten walls people keep hitting when they try to run their own AI agent, and what each one actually costs."
lead_image: blog/the_ten_walls.svg
---

<div class="footnote">
<strong>&ldquo;Each wall, on its own, is solvable. That's the problem.&rdquo;</strong>
<p/>
</div>

#### Drawing the map

In my [last post](/content/the-small-island-of-delight) I wrote about the small island of delight — the agent itself — surrounded by a sea of ops work. The note that followed that post was the most common: *okay, I feel this. What are the walls, exactly? Name them. Make me a list so I can tell whether I'm about to hit one.*

Fair.

This is that list. Ten things I keep seeing people run into when they try to run their own AI agent. I'm going to go through each one directly — what it is, what it feels like when it hits, what it actually costs. No pitches. Just the map.

A small note before we start. Most of these walls look trivial in isolation. Docker, right? TLS, sure. Memory, obviously. None of them is the problem. The *accumulation* is the problem. When you hit one, you lose an evening. When you hit six in a quarter, you lose the habit of using the agent.

⸻

#### 1. Infrastructure turns into a second job

This is the first and loudest complaint, and it's not even close. People spend more hours on Docker, YAML, SSH, uptime, VPS sizing, and restart scripts than they spend talking to their agent. The official Docker setup needs at least 2GB of RAM. Cheap $5 hosts get OOM-killed in the middle of the night. You open a DigitalOcean community thread and watch people literally write "gave up."

What hurts here isn't that the infrastructure is hard. It's that you're doing infrastructure work to get to the interesting part, which is the agent. The ratio is backwards. You should be spending most of your time on what the agent does. Instead you're spending most of your time keeping the agent alive.

**The test:** if a power cut or a kernel update would silently take your agent down and you wouldn't know for a day, you're on the wrong side of this wall.

⸻

#### 2. The agent's memory quietly gives up

Everyone's favourite bug. OpenClaw gives you 100-200K tokens of context window, which sounds like a lot until you realise tool calls and file reads eat it in an afternoon. When the window fills, compaction kicks in — summarising older messages to free up space. And anything that wasn't already written to long-term memory gets smoothed into a summary or disappears.

The pattern looks like this: the agent is brilliant for the first two weeks. Then, almost imperceptibly, it starts re-asking things you already told it. Brand guidelines. Your tone of voice. Your team's name. You find yourself re-explaining, and you start wondering whether it's you or the agent. It's the agent.

People solve this by bolting on Mem0, Cognee, QMD, knowledge graphs — pick your acronym. Each works. None of them is the user's job.

**The test:** ask your agent, today, about something you told it three weeks ago. If it stumbles, this is the wall you're hitting.

⸻

#### 3. Security is a moving target you didn't sign up to track

138 CVEs in 63 days. 135,000 exposed OpenClaw instances found on public IPs. 824 malicious skills planted in ClawHub, with around 12% of the registry compromised at some point. None of this is hypothetical. These are numbers from February and March of this year.

The honest truth is that self-hosting an AI agent in 2026 is like running your own mail server. Can you do it? Yes. Should a non-specialist do it? Almost never. The attack surface is enormous, the threat landscape changes weekly, and the consequences of a mistake include someone else operating your agent — with your API keys, your data, your credentials.

Most people I talk to have no idea their gateway is bound to `0.0.0.0`. They don't have a firewall. Their fail2ban is aspirational. And they have no way to tell if something has gone wrong.

**The test:** if you were breached last Tuesday, how long until you'd know?

⸻

#### 4. Token bills arrive with a personality

This one bites quietly and then all at once. OpenClaw's heartbeat feature wakes the agent every thirty minutes by default, and every heartbeat carries the full session context. Add tool calls, long context windows, and a premium model, and you can burn a million tokens in an afternoon without trying.

I've seen this pattern several times now. Someone sets up their agent. First week, the bill is tiny — they didn't use it much. Second week, more use, bill creeps up. Somewhere in week three, they check their provider dashboard for an unrelated reason and see a number that makes them close the laptop. The blog post "burned 1.8 million tokens in a month and got a $3,600 bill" is not a thought experiment. That's someone's real Tuesday.

The fix is routing — cheap models for easy tasks, premium for complex ones — plus heartbeat tuning, plus budget caps. All of it is doable. None of it is the user's job.

**The test:** can you tell me, within 10%, what your agent cost you yesterday?

⸻

#### 5. The skills marketplace is a minefield with good lighting

OpenClaw's skills are MCP servers, which means they're essentially little programs that run with full access to whatever you give them. The public marketplace — ClawHub — is open to anyone. One security study found 36.82% of community skills contained vulnerabilities. Another found 824 skills that were straight-up malicious, dressed up with professional documentation and innocent names.

The tricky part is that skills are the *good* thing about OpenClaw. The whole point is extensibility — agents that can actually do useful things in the world. So you need skills. But every skill you install is a supply chain decision, and almost no one is treating it that way. They're treating it like installing a browser extension. That's how credentials leak.

**The test:** name the last three skills you installed, and tell me who maintains them.

⸻

#### 6. Multi-agent setups collapse under their own weight

This one surprises people. Once your morning briefing works, it's natural to think — *what if I had one agent for writing, one for research, one for ops?* Seems obvious. Seems like the future.

It turns out fewer than 10% of teams who attempt multi-agent setups keep them running. The coordination problems are brutal. Agents on a shared channel talk over each other, duplicate work, hand off in loops, argue. Every handoff burns tokens because every agent summarises before passing the baton. The concurrency caps hit faster than you'd expect. And debugging a multi-agent failure means tracing across multiple context windows that didn't see the same thing.

Most "multi-agent" stories you read online are really one agent with better prompting. That's often the right move. But when you genuinely need orchestration, OpenClaw gives you a pile of primitives and a lot of homework.

**The test:** if two of your agents had to hand work off to each other, could you trace the handoff when it broke?

⸻

#### 7. Observability is three weekends you didn't know you owed

OpenClaw added OpenTelemetry support in v2026.2, which is wonderful, and means you can now wire up your own observability stack. Prometheus. Grafana. Tempo or Jaeger for traces. A log aggregator. Dashboards. Alerts.

None of this comes out of the box. It's all homework. And the people who need observability the most — the ones whose agents are doing real work — are precisely the ones who can least afford the three weekends it takes to build the stack. So they don't build it. They run blind. Until something breaks and they're debugging with `grep` on a log file at 11 PM.

This is the oldest story in ops. The tools are open and free. The time to make them useful is the real cost.

**The test:** if your agent took an action you didn't expect last week, could you find out what and why, in under 15 minutes?

⸻

#### 8. Upgrades force an ugly choice

OpenClaw ships fast. v2026.3.22 alone landed 13 breaking changes along with 45+ new features. Old directory structures (`.moltbot`), old environment variable names (`CLAWDBOT_*`, `MOLTBOT_*`) get deprecated without fallback paths. If you're on a version with known security issues, you have to upgrade. If you upgrade, something in your setup breaks.

I've watched people hit this and freeze. They know they shouldn't stay on a vulnerable version. They also know an upgrade is going to eat a weekend, and possibly break the skill they've been building their workflow around. So they delay. The vulnerable window stretches. Eventually something forces their hand, usually the wrong way.

This is the classic unowned-maintenance problem. The agent is core to your workflow, but nobody is on the hook for keeping it current. So it falls to the person with the least time — you.

**The test:** what version are you on, and when did you last check for updates?

⸻

#### 9. The moment you want to share, you can't

Solo use is the default assumption. Everything about OpenClaw — auth, config, channels, skills — assumes one person, one agent, one machine. The moment someone on your team says "can I have access too?" you discover that the answer is an hour of manual allowlists, Discord role hacks, and per-channel DM scopes.

There is no native RBAC. There is no team workspace. There is no way for one person to own the infrastructure and another person to own the agent's behaviour. Community projects like Clawith and Mission Control exist to fill the gap, but they're separate installs, with their own learning curves and maintenance.

Most real use cases become team use cases eventually. The agent that drafts your newsletter also drafts your cofounder's newsletter. The agent that watches your CI pipeline also watches your team's CI pipeline. When that transition happens, people quietly stop using it together and go back to using it alone.

**The test:** how would you give a colleague access to your agent for one week, then take it back?

⸻

#### 10. You don't know when the agent is wrong

This is the quietest wall, and in some ways the scariest. Agents hallucinate tool calls. They drift from goals in long sessions. They pattern-match on things that look like the user's intent but aren't. And you often don't know it happened until someone downstream points it out.

There's an emerging benchmark called PinchBench that targets ≥80% task completion and ≤5% tool-call error. Good targets. Also — 5% tool error is one in twenty. If your agent is acting on your behalf twenty times a day, one of those actions is likely wrong, in a way that might not be obvious.

The DIY answer is to build your own evals, approval gates, dry-run modes. Each of those is a small engineering project. Most people just... don't. They cross their fingers and hope the agent's next action is a good one.

**The test:** the last time your agent did something for you, how confident were you that it did the right thing — not the thing that looked like the right thing?

⸻

#### Why I keep writing this down

I don't list these to be dramatic. I list them because every single person I've helped with OpenClaw has hit at least three of these walls, and most have hit six or seven. The failure mode isn't hitting a wall — it's hitting several, losing motivation, and quietly giving up on the agent.

That's the outcome I most want to prevent. The agents themselves are extraordinary. The use cases are real. The value is there. What's missing is a way to get to the value without the detour through the ops checklist.

Every wall on this list has a solution. Some are small — better defaults. Some are medium — a cost dashboard, an activity log, a curated skill registry. Some are genuinely hard — persistent memory, multi-agent coordination, team RBAC done properly.

None of them are the user's job.

That's the bet I'm making with ClawStation. Take the walls down, one by one, in an order that matches the pain. Don't ask the user to become an infrastructure engineer, a security engineer, a memory architect, and an observability expert just to have an AI assistant that actually assists them.

The island should get bigger. The sea should get smaller. And the interesting work — the thing you wanted when you first got excited about agents — should be most of what you do.

⸻

If you're hitting one of these walls right now, or you've hit one and walked away, I'd love to hear which one. The map gets better every time someone tells me where they got stuck.

More to come.
