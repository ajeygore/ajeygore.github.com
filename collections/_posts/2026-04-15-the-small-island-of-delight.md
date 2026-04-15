---
layout: post
title: "The Small Island of Delight"
published: true
categories: [AI, Building, Products]
description: "It started with a friend weighing a dedicated Mac against a VM full of config. It turned into a question I can't stop thinking about — what blockers are keeping people from actually using AI? ClawStation is my attempt at an answer."
lead_image: blog/why_clawstation.svg
---

<div class="footnote">
<strong>&ldquo;The tool is free. The friction is not.&rdquo;</strong>
<p/>
</div>

#### It started with a friend

Few months ago, a friend pinged me late one evening. He's a founder — not a developer, but deeply tech-first. The kind of person who reads release notes for fun, runs Homebrew updates on a Sunday, tries every new AI tool the week it drops. He'd been playing with OpenClaw for a while. Getting the Gateway up, wiring Telegram, experimenting with skills. He loves this stuff.

His question was simple. Run OpenClaw on a dedicated Mac sitting in his home office, with full access to everything — or set up a VM and wire it up properly with all the bells and whistles?

The Mac was tempting. Low effort. Plug it in, install, done. But it felt fragile — a power cut, a reboot at the wrong time, a macOS update that decides to restart overnight, and the whole thing is down. Not to mention he's on the road often.

The VM was the "proper" path. Reproducible, backed up, restartable, safe. But then we started listing what "proper" actually meant. Ubuntu image. Firewall. SSH keys. TLS. Bot tokens. A reverse proxy. Some form of monitoring. Log rotation. Restart-on-crash. Backups. A plan for what happens when OpenClaw pushes a breaking change next month.

He could *follow* all of it. He just didn't want to *own* all of it. He's a founder. He wanted to spend his Saturday playing with the agent and seeing what he could build with it. Not managing Ubuntu.

We spent the afternoon doing the VM path anyway. We got it working. He was happy. And somewhere between the third certbot renewal check and the fourth "wait, why is the gateway returning 502," we looked at each other and had the same thought.

*Why is this so much work? It shouldn't be.*

⸻

#### The first version was small

That week, I started writing a tiny script to automate what we'd done manually. Provision a server. Install OpenClaw. Wire up Telegram. Give him back a URL and a dashboard. I wasn't trying to build a company. I was trying to save the next friend who asked.

Then another friend asked. Then another. Most of them were people like him — founders, investors, tech-curious folks who loved to tinker but didn't want their weekends turning into sysadmin duty. A few had already tried and quietly given up, OpenClaw running on a laptop somewhere, forgotten after the first month.

And somewhere in there, I started thinking about my son. He's young, he's curious, he's the kind of kid who will absolutely want his own AI agent — and he should have one. Not one he rents from a big company. One that's his. That he can shape, teach, play with, break, and learn from. But I'm not going to hand him a Digital Ocean droplet and a TLS guide. He'd love the agent. He'd hate the setup. And that would be the wrong lesson.

At some point I realised I'd had the same conversation half a dozen times in a month. Each time with someone who was genuinely excited about what AI agents could do, and each time watching that excitement get sanded down by the yak-shaving required to run one.

So I asked myself — why not just let everyone in on this?

Not in a grand startup pitch way. In a small, "this seems useful, let's make it easy for more people" way. That's how ClawStation started. One evening, one friend, one decision between a Mac and a VM, and a growing certainty that this shouldn't be as hard as it was.

No market analysis. No pitch deck. No competitive landscape slide. Just — if I can take the hard part out of this for one friend, I can take it out for a lot of people. Including, eventually, my son.

⸻

#### What I kept seeing

Something funny happens when you put a product in front of real people. They tell you things the product teams and the Twitter threads and the hot takes never quite capture.

The people I was helping weren't developers. But they weren't non-technical either. They were the people in the middle — the investors who know what a Docker container is but don't want to debug one, the founders who can read a log file but don't want to spend Sunday tailing it, the curious tinkerers who love the *outcome* of tech but not the drudgery of keeping it alive. That's a huge and mostly unserved group.

The pain wasn't that they couldn't understand the infrastructure. The pain was that understanding it didn't save them from having to *run* it. You didn't get to build cool agent workflows. You got to debug why your TLS cert didn't renew. You didn't get to explore memory strategies. You got to figure out why the VPS ran out of RAM at 3 AM and took the agent down with it.

People fell in love with their agents. That part I expected. What I didn't expect was how quickly they hit the *next* wall, and the one after that.

The morning briefing worked beautifully — until the API bill arrived and they didn't know why it was $180. The content automation was magical — until the agent "forgot" the brand guidelines halfway through a newsletter. The bot was a lifesaver — until it was down one Tuesday and nobody could tell whether it was OpenClaw, the VPS, the network, or a skill gone rogue.

I started keeping a list. Not because I needed a feature roadmap, but because I kept hearing the same ten or twelve things. Memory that fills up. Token costs that surprise people. Security vulnerabilities arriving faster than anyone can patch them. Skills from the open marketplace that turn out to be malware. Upgrades that break everything. Teams that want to share an agent and can't.

Each of these, on its own, is a solvable problem. The people I was helping could solve any one of them if they really had to. But **none of them signed up to solve solvable problems.** They signed up to play with AI. To build something. To see what was possible. The agent was supposed to be the point. Instead, **the agent was the small island of delight surrounded by a sea of ops work.**

⸻

#### The bigger thing

I've been thinking about something for a while — and wrote about it in my [last post](/content/the-expensive-thing). When execution gets cheap, judgment becomes the expensive thing. Agents compress execution to nearly zero. The question is what you actually do with that.

And the more I talk to people trying to use agents, the more I think the answer is: *not enough yet*. Not because they don't want to. Not because they can't grasp it. But because the plumbing keeps pulling them back from the interesting work.

88% of firms are using AI. Only 6% see real gains. That gap isn't because the tools are bad. The tools are remarkable. The gap is because most people — and most organisations — are still stuck at step one. Getting the thing running. Keeping it running. Trusting it enough to let it do real work.

I've seen this pattern my whole career. At Gojek we scaled from 300,000 to 120 million monthly orders. At ThoughtWorks, at CodeIgnition, at every company I've advised — the hardest problems were never the ones in the spotlight. They were the quiet, boring, unglamorous ones sitting between a great idea and a working system. The plumbing. The wiring. The stuff nobody wants to think about but everyone depends on.

AI agents have the exact same problem. And right now, the plumbing is eating the time of exactly the people who should be out there exploring what these tools can actually do.

⸻

#### So what are we actually doing?

Honestly, I'm still figuring it out. ClawStation today is a simple thing — you sign in with Google, pick a model, connect a messaging channel, and in under a minute you have a personal AI assistant running on dedicated, secured infrastructure. No Docker. No YAML. No TLS renewal at 2 AM. It just works, and you still get SSH, a terminal, file access — the keys to the kingdom, if and when you want them.

That's the principle. **Remove the forced plumbing, not the control.** If you want to go deep, we don't stop you. If you just want the agent running so you can get on with the interesting part, you don't pay the infrastructure tax to get there.

But that's the beginning, not the end.

The thing I keep coming back to is the list I've been keeping — the walls that real people hit. Cost intelligence so you stop being surprised by the bill. Memory that actually persists across sessions. Security built in, not bolted on. Managed upgrades so you're not stuck choosing between "vulnerable" and "broken." Skills you can actually trust. Team workspaces for the inevitable moment when one person's agent becomes three people's agent.

None of this is glamorous. None of it is the stuff that makes for viral demos. But it's the stuff between where we are and where we should be — where the island of delight is big enough that you don't notice the sea anymore.

That's the mission I'm slowly growing into. Not "let's build another AI platform." More like — **how do we get everyone on AI, and what blockers can we solve along the way?**

And when I say everyone, I mean it. Founders. Investors. Curious tinkerers. Small teams. My son, eventually. Anyone who wants to find out what they can do with a thinking, tool-using, always-on assistant — without first becoming their own IT department.

⸻

#### Why this, why now

I took a pause this year. Wrote about [that too](/content/the-space-between-chapters). One of the unexpected things about slowing down is that it makes space for the small ideas — the ones that start with a friend's question on a random evening, not with a strategy document.

ClawStation is one of those ideas. I don't know exactly what it will become. I know what it's solving for right now, and I know who it's for — the people who love what AI can do and have hit the wall of what it takes to run. The founder, the investor, the tinkerer, the small team, the parent who wants their kid to grow up with this stuff, not watch it from behind a paywall.

And I know the direction. Each wall people hit is a blocker between them and the value AI can actually deliver. If I can take those walls down, one by one, quietly and well, then maybe a few more of the 88% become part of the 6%. Maybe a few more Saturdays get spent playing instead of yak-shaving. Maybe a few more kids get to grow up with an agent that's genuinely theirs.

That seems worth doing.

⸻

#### Back to shipping

If you're someone who's been wrangling with OpenClaw and hit a wall — I'd love to hear where you got stuck. If you're someone who got it running and is now wrestling with memory or cost or security — I want to hear that too. These are the conversations that have shaped ClawStation so far, and they'll keep shaping it.

The tool is free. The friction is not. My whole bet is that if we can remove the friction, the island gets bigger on its own.

More to come.
