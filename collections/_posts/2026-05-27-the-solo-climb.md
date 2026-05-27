---
layout: post
title: "The Solo Climb"
published: true
categories: [AI, Engineering, Engineering Practices]
description: "We all watched Free Solo and took the wrong lesson. Honnold didn't remove the harness — he internalised it until the external gear became redundant. Most teams attempting the 100x shape are trying to skip that part. This is about what Honnold actually did."
lead_image: blog/og/the-solo-climb.png
---

<div class="post-epigraph">
  <p>Everyone in engineering started using the word "harness" around the same time. I think I know where it came from.</p>
</div>

## The part nobody wants to build

We all watched Free Solo.

If you haven't: Alex Honnold climbed El Capitan — three thousand feet of vertical granite in Yosemite — without a rope. No protection. Nothing between him and the ground. The documentary won an Oscar and, somewhere in the years that followed, quietly handed the word "harness" to every engineering conversation I've been part of. *We need a harness. The harness isn't strong enough. Who owns the harness?* I can't prove the etymology but I'd bet on it.

Here's the thing most people forget about Free Solo, or maybe never noticed. Honnold didn't decide one morning to climb without a rope. He spent years on that exact route — with the rope, with the harness, with all the protection — until he had memorised every hold, every transition, every sequence across three thousand feet of rock. He rehearsed the crux sections until his body could execute them in the dark. He didn't remove the external safety until he'd built something harder to see and far harder to build: internal safety, so thorough that nothing on the wall could surprise him.

The harness didn't disappear. It moved inward.

> Honnold didn't remove the harness. He internalised it until the external gear became redundant.

The software industry watched that film and took the wrong lesson. What people heard: *you can climb without protection if you're good enough.* What the film actually shows: *to climb without external protection, you first build internal protection so thorough that nothing can catch you unprepared.* Honnold's years of roped climbing weren't the cautious version of the climb. They were the harness — just built into his body and his preparation rather than clipped to his belt.

The teams that genuinely run at 100x — the solo senior plus agents doing the work of eight, the small team that ships like a large one — they didn't remove the harness. They built a different kind, and they built it first. That's the half the romance never shows.

If you read [The Anatomy of an AI-Native Org](/content/the-anatomy-of-an-ai-native-org) and felt the pull of it, I get it. I felt it too, and I've watched it work this year on teams I respect. But most of the teams I talk to who want that shape are attempting the free solo without doing what Honnold did first.

This post is about what Honnold actually did. What the harness is. What it has to hold. Where it snaps. What "strong enough" actually means when the climber is one person plus agents, and the team that used to catch the fall isn't on the wall anymore.

<hr class="ornament" />

## What load-bearing actually means

Let me define what I mean by *harness*, because the word is starting to get used as a vibe.

A harness, in the sense I'm using it, is the set of systems that together can answer one question with confidence: *is this change correct enough to ship?* That's it. The question doesn't change because the author is an agent. The question doesn't change because the team is smaller. The question gets harder — because the velocity of the change went up, and the team that used to look over the change went away.

Load-bearing means: when an agent opens a PR at 11pm on a Friday, and the senior engineer is asleep, the harness either holds or doesn't. There is no review meeting. There is no second pair of eyes. There is no Monday standup that catches it. If the change is wrong and the harness doesn't catch it, the change goes to production, and the user finds the bug before you do.

That is the load. Everything else — the dashboards, the rituals, the post-incident retros — is what you do *after* the harness has already failed.

> Load-bearing means: when the change goes wrong and nobody is awake, the harness either holds or doesn't.

You can see why most teams' "harness" isn't load-bearing. A test suite that passes 90% of the time isn't a harness. A spec document nobody operates from isn't a harness. A staging environment the team has stopped trusting isn't a harness. None of those held the human team either — they just got papered over by review meetings and manual QA passes. The agent removes the paper.

<hr class="ornament" />

## The solo climb is the load test

*The reason this matters now and didn't matter as much before.*

The old org had a lot of redundancy in it. I argued [for twenty years](/content/the-tests-we-skipped) that the redundancy was hiding a missing harness. Most teams disagreed, quietly, by carrying on. The disagreement was tenable because the redundancy was real. A weak harness, plus six engineers plus a QA team plus a manager who knew the codebase plus a long release cycle, is a system that mostly catches mistakes. Not elegantly. Not cheaply. But catches them.

The new shape — the solo senior plus agents — has the redundancy stripped out. That's the whole point of the shape. It's how the 100x leverage shows up. It's also why the harness has to be load-bearing in a way it never quite had to be before.

If you're the senior engineer in that shape, you are climbing solo. The agent is the rope you're trusting to pull weight, and the harness is the only thing between you and the ground. The team that used to catch you is not on the wall.

This is not a metaphor that gets less literal the closer you look at it. It gets more literal.

> The solo climb is the load test. If the harness was weak before, the climb is what tells you.

I keep getting asked by founders and senior engineers whether the 100x shape is real, whether their team is "ready for it." The honest answer in most cases is: the shape is real, your team is not ready, and the reason your team is not ready is the harness. Not the agents. Not the skill of the senior engineer. The harness. It's nearly always the harness.

<hr class="ornament" />

## The invisible load

*Why software engineers skip the gear check that climbers never do.*

A climber two hundred feet up a granite face knows exactly what the harness is for. The consequence of bad gear is immediate, physical, and irreversible. Nobody argues about whether to clip in. Nobody says "let's skip the gear check this sprint." The feedback loop is closed in the worst possible way, and everyone on the wall knows it.

Software doesn't work like that. The consequence of a missing eval suite is a bug in production three weeks from now, found by a user who emails support, turned into a ticket, escalated eventually to engineering, assigned to someone, debugged across a few days, fixed in a PR nobody reviews carefully because the pressure is on to close the sprint. Distributed. Invisible at each step. Nobody felt the fall. The load was spread across twelve people and thirty days until it became noise.

This is the strategic gap most leaders I talk to can't quite name. They understand risk in the abstract. They've read the incident reports. But software risk doesn't register the way physical risk does, because the feedback loop is too slow and the consequence too diffuse. You skip the harness and nothing happens today. Nothing happens this sprint. The cost is real and it's being paid — it's just being paid by people you're not counting in the same column.

I felt this clearly when building [clawstation.ai](https://clawstation.ai). There's a moment in every serious build where the harness stops being best practice and becomes concrete — the actual difference between shipping and explaining. The failure doesn't announce itself as failure. It arrives as slowness. The release that takes longer than expected. The agent that shipped something technically correct and completely wrong. The bug in a place nobody was watching. The invisible load was always there. The harness is what makes it visible before it becomes a disaster.

> The invisible load doesn't announce itself. It arrives as slowness, as noise, as a bug in a place nobody was watching.

Building software is not as life-threatening as a solo climb. That's precisely the problem. The visceral urgency that makes climbers inspect every piece of gear before they leave the ground — that urgency is absent in software. The stakes feel deferrable. So teams defer the harness. The load builds, invisibly, until the first time they actually need it to hold.

The strategic misread, in almost every team I've seen take this seriously too late, is thinking *the harness is for when things go wrong.* The harness is for when things are going *right* — when you're moving fast, shipping daily, trusting agents to do work a team used to do under supervision. The harness isn't the recovery plan. It's what makes the speed possible without the invisible load becoming the visible disaster.

<hr class="ornament" />

## Where harnesses snap

I've watched enough of these systems get stress-tested this year to have an opinion about where they fail. Five patterns keep showing up.

**The harness is theatre.** Tests exist. They pass. Nobody trusts them, because everyone on the team knows which tests are checking something real and which are checking that the function got called. The CI build runs. People watch the build pass. People still manually verify the feature before shipping, because the build's green light has lost its meaning. This is the [PR-rubber-stamp pattern](/content/the-tests-we-skipped) wearing a new costume. The shape of the lie is identical.

**The harness has gaps the team has stopped naming.** The integration test that always flakes, so the team marks it as expected. The eval that takes too long to run, so it only runs on main. The contract test that broke six months ago and got disabled "temporarily." Every gap was once a known issue. Then it became background noise. Then it became invisible. The agent ships through the gap, and the team finds out in production.

**The harness only covers the happy path.** Most test suites I see are extensive on the cases the team already understands and thin on the cases the team is afraid of. Concurrency. Partial failure. Migrations under load. Edge cases at the data layer. The agent will write code that hits the cases the suite doesn't cover, because the agent doesn't know which cases the team has been quietly avoiding for years.

**The harness has no eval for *what good means*.** Tests can tell you the function returned the right value. Tests cannot tell you the feature actually solved the user's problem. A real harness includes the eval layer — the one above the unit tests that asks, *did this change accomplish the thing it was meant to accomplish?* Most teams don't have this layer. Most teams have never built it. The Harness PM lane [I wrote about last week](/content/ai-ate-my-role-whats-next) exists precisely because this gap is real and someone has to own it.

**The harness has no safe failure mode.** When the harness catches something, what happens? In a healthy system, the change doesn't ship and the author finds out fast. In most systems I see, the harness flags something, the alert goes to a channel nobody watches, and the change ships anyway because the gate isn't actually a gate. A harness that warns but doesn't stop is not a harness. It's a notification.

> A harness that warns but doesn't stop is not a harness. It's a notification.

Notice none of these failures are about the agent. All of them existed in the human-only world. The agent just exercised them faster than the team had a way to respond.

<hr class="ornament" />

## The gear list

If you're a senior engineer or an EM or a founder thinking about what a real harness looks like — the kind that holds when the climb is solo — here is what I'd insist on. Not as a checklist for compliance. As gear I'd inspect before I let the climb begin.

**Specs that are operated from.** Not specs that live in a Notion page nobody opens. Specs that are the input to the agent, the source for the eval suite, and the artefact the team reviews when something breaks. If the spec isn't load-bearing in the system itself, it isn't a spec. It's documentation.

**A test suite the team trusts enough to ship on.** Green build means *ship.* Red build means *don't.* No "we manually verified anyway." No "the test is known to flake." If the team can't honestly say a green build is enough to push to production, the test suite isn't a harness — it's a comfort blanket.

**An eval suite for "did the change solve the right problem."** Above the unit tests. Closer to the user. The eval is what catches the change that passes every unit test and still does the wrong thing. This is the work [QA roles are evolving into](/content/ai-ate-my-role-whats-next), and the teams that don't build it will keep being surprised by features that ship green and land wrong.

**A sandboxed environment the agent can actually operate in.** Not "the agent has full prod access and we're hoping it doesn't break anything." Not "the agent has no access and a human has to copy-paste everything it suggests." A real sandbox — bounded, observable, reversible — where the agent can do work without the blast radius of a mistake reaching the user.

**Gates that actually gate.** The build either goes to production or it doesn't. The eval either passes or it doesn't. The approval either fires or it doesn't. No "we'll let it through this time." Every soft gate is a hole, and every hole gets exploited eventually — not maliciously, just statistically.

**Agent-of-agent review.** One agent writes. Another reviews. A third runs the tests. None of them are the senior engineer, who is doing the work the [Anatomy](/content/the-anatomy-of-an-ai-native-org) post said survives — designing the system, holding judgement, owning the outcome. The agent-on-agent layer is what makes the climb scalable. It's also the layer most teams haven't built yet, because they're still pretending the senior engineer can review every PR by hand.

**Observability the senior engineer actually reads.** Not dashboards. Not alerts that fire into dead channels. The five or six signals that, if any of them moves, the senior wants to know inside the hour. The harness only protects you if you can see when it's about to fail.

That's the gear. None of it is new. Some of it I've been writing about for a decade. The novelty is the urgency, not the practice.

<hr class="ornament" />

## What "strong enough" means

Strong enough is not a checklist score. Strong enough is a question you can answer honestly: *if the senior engineer goes on holiday for two weeks, and the agents keep shipping, do I trust what comes out the other side?*

If the answer is yes, the harness is strong enough.

If the answer is "well, mostly, but," the harness is not strong enough, and the *but* is the gap that will eventually become the incident.

If the answer is no — and for most teams I talk to, the honest answer is no — then the climb is not yet a climb you should be taking solo. The team is not yet a team that can run the 100x shape. Build the harness first. Then climb.

> The climb without the harness isn't ambition. It's a fall in slow motion.

I don't say this to slow anyone down. The opposite. The teams that build the harness *first* are the teams that get to take the climb the rest of the industry is still talking about. The 100x leverage is real. The small-team-plus-agents shape is real. The harness is what makes both real things survivable. Without it, the 100x team is just a faster way to ship a bug.

<hr class="ornament" />

## The climb is fine. It's the gear that gets you killed.

Climbers know this. The mountain doesn't kill you. The fall doesn't kill you. The gear that didn't hold is what kills you — and the moment to inspect the gear is before you leave the ground, not at the top of the pitch when you've already started to slip.

The new shape of software work is, for the first time, a shape where the climber is climbing solo. The agents are doing work a team used to do. The senior engineer is the only judgement in the system. The harness is the only protection between a wrong change and a production user.

If you're a founder and your team is leaning into the 100x shape, ask the harness question first. Not the agent question. Not the headcount question. The harness question. *If the senior engineer goes quiet for two weeks, what holds?* If the answer is *nothing solid,* you don't have a team. You have a climber and a rope and a wish.

If you're a senior engineer and the romance of the solo climb is pulling at you — I get it. It's pulling at me too. The work is more interesting than it's ever been. The leverage is real. But check your gear before you leave the ground. The agents are not going to check it for you, and the team that used to is gone.

The climb is fine. It's the gear that gets you killed.

More to come.
