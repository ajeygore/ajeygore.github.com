---
layout: post
title: "The Why and the What"
published: true
categories: [AI, Leadership, Teams]
description: "For thirty years the org chart was a translation pipeline — business asked why, product defined what, engineering translated to how. AI just ate the translation step. What's left is a team that looks nothing like the one you have today."
lead_image: blog/the-why-and-the-what.svg
---

<div class="footnote">
<strong>&ldquo;The middle of the org chart was always translation work. Translation just got cheap.&rdquo;</strong>
<p/>
</div>

#### The org chart we never named

If you draw the org chart of any software company built in the last thirty years and squint, the same shape shows up.

There's a small group at the top deciding *why* — why we exist, why this market, why now. Below them, a slightly larger group deciding *what* — what to build, what to ship, what to cut. And underneath both of those, the broad middle of the company, the part where the headcount actually lives — the *how*. Engineers, project managers, scrum masters, tech leads, engineering managers, program managers, who took the *what* and translated it into code, into tickets, into deployments, into release notes, into Slack messages in #releases.

I've been part of every layer. I've sat in the *why* room. I've run the *what* meetings. I've shipped a lot of *how*. I've also argued, for a long time and in a lot of rooms, that the middle of that pyramid was bigger than it needed to be — that leaders should be co-workers, not reviewers, and that managers who only managed were a tax the team paid for the privilege of having a status meeting. That argument never quite landed either. Same shape as [the one I lost about tests](/content/the-tests-we-skipped) — the cost was paid in slow, distributed ways that nobody in the room wanted to add up.

What's on my mind a year into the agent shift is that the bill is finally getting itemised. And the line that's getting cut is the one I've been pointing at for years.

Most of what we did in the middle was translation.

Business intent translated into product spec. Product spec translated into JIRA ticket. JIRA ticket translated into a branch name and a PR. PR translated into deployment. Deployment translated into a release note. Release note translated into a status update. Status update translated back upward into business language. Each step had its own ceremony, its own job title, its own meeting cadence. A whole industry of frameworks — Agile, SAFe, Spotify model, you name it — grew up around making the translation pipeline more efficient.

We were, mostly, glorified translators. I include myself in that. I include most of the best engineers I've worked with. The work was real and hard and required taste, but the *shape* of it was conversion. Take the thing in this language, output the thing in that language. Repeat.

⸻

#### What AI actually ate

The agent conversation keeps getting framed as "AI replaces engineers" or "AI replaces customer service" or "AI replaces analysts." All of those framings are slightly wrong. AI didn't come for a job title. AI came for a *task type*, and the task type it came for was translation.

If your job was mostly converting one well-defined input into a well-defined output — natural language to SQL, requirements to code, ticket to PR, design spec to working component, log line to incident report, customer email to ticket — your task got compressed by an order of magnitude. Doesn't matter what your title was. The task was translation. The task got cheap.

The two ends of the pipeline didn't get cheap. Defining *why* — the business reason, the strategic call, the bet — is harder than ever, because the cost of executing on a bad why just dropped to nearly zero, which means more bad whys are going to ship, faster, with more confidence. Defining *what* — the product call, the cut decision, the "we will not build that even though we could" — is harder than ever, because the cheaper execution gets, the more options you have, and judgement under abundance is its own discipline.

The middle is what got eaten. And the middle is where most of the org chart lives.

Hold that honestly. Not as a doom story. As a fact about the shape of work.

⸻

#### The manager who doesn't contribute

Here's a hard one, because it's about people I've worked with and respected. I've also been making this argument, in less direct language, for years — so this isn't a new position, it's an old one with sharper teeth.

A lot of engineering managers exist to coordinate translation. They run the standup. They unblock the ticket. They negotiate priority across teams. They write the status update. They translate engineering progress upward into business language and business priorities downward into engineering language.

That work was real. It was load-bearing. The pipeline didn't run without it.

But if the pipeline itself is shrinking — if the layers between *why* and shipped code are collapsing because agents can carry more of the conversion themselves — then the manager whose entire job was coordinating the translators has a problem. The work that justified the role is dissolving.

I've watched two patterns emerge over the last year. One is denial — managers who quietly defend the rituals (the standup, the status meeting, the JIRA hygiene) because the rituals are what make the role visible. The other is the shift — managers who started writing again, designing again, defining again. Who picked up an agent themselves, not to prove a point, but because the org chart underneath them got smaller and the only way to stay useful was to be in the work.

I don't think every manager needs to write code. I do think every manager needs to *contribute* — to the *why*, to the *what*, to the design of the harness, to the verification of the output. Coordination on its own is no longer enough. **If a manager isn't contributing to the why, the what, or the trust system that holds the how, it's hard to say what they're doing.**

This isn't a vendetta against managers. I've been one. I've hired dozens. The ones I'm most worried about are the ones who optimised so hard for being good at the translation pipeline that they forgot how to do the work that sat underneath the pipeline. The pipeline is getting smaller. The work underneath is getting bigger.

⸻

#### What the new team actually looks like

I've been sketching this on whiteboards with founders for months. Here's the rough shape that keeps showing up.

A small group of people defining *why*, mostly unchanged. The *why* layer was always thin and is going to stay thin, because conviction doesn't scale linearly with headcount. You don't need more people to decide why; you need a few people who decide it well.

A larger group than before defining *what*. Not "product managers" in the old sense — not the ticket-writing, JIRA-grooming, sprint-planning archetype. People who can sit between the *why* and the agent, hold the context of what's actually being built, and make the dozens of small calls per day about what "good" looks like. This is taste work. This is judgement work. This is what [The Expensive Thing](/content/the-expensive-thing) was about. The ratio of *what* people to *how* people is going to flip in the next two years, and most teams are not ready for it.

A much smaller group of people doing *how* — and the *how* people who remain are doing the hardest *how* work. Not ticket conversion. Architecture. Trust systems. Performance. The 5% of the codebase the agent shouldn't touch unsupervised. The harness from [The Tests We Skipped](/content/the-tests-we-skipped) — the specs, the eval suites, the golden builds, the agent-of-agent review patterns. Someone has to design that harness. That someone is an engineer with deep judgement, and there are fewer of them on each team than there used to be, but each of them is doing dramatically more.

And then the agents themselves, doing the bulk of the conversion work. Writing the PR. Updating the doc. Filing the ticket. Drafting the release note. Reviewing each other's outputs.

The team that's left is smaller in headcount and broader in skill at every level. The middle thinned. The ends thickened. Coordination collapsed. Contribution went up.

⸻

#### Hands-on, redefined

The phrase "hands-on" used to mean writing code. It still does, sometimes. But the deeper meaning is being in the work — close enough to the output that you can see when it's wrong, opinionated enough about the input that you can define what right looks like.

A founder writing prompts that drive an agent's product roadmap is hands-on. A CTO designing the eval suite that gates production deploys is hands-on. A staff engineer specifying the contracts an agent must respect when modifying core code is hands-on. None of them are necessarily writing the code anymore. All of them are in the work. This is what I said years ago when I wrote that leaders should be co-workers, not reviewers — that *passing down comments* was the cheap version of leadership, and the real version was *showing what's possible by doing it.* The agent era doesn't change the principle. It removes the alibi.

What's *not* hands-on is approving JIRA tickets in batches. Running a status meeting where everyone reads off their updates. Writing a strategy doc that nobody operates from. Sitting in the layer above the work, translating between what the team did this week and what the business wants next week. That layer is shrinking. The hands-on layer is the layer that survives.

This is uncomfortable for a lot of senior people. It was uncomfortable for me, when I started really sitting with it during the sabbatical. There's an emotional reflex to defend the role you spent a decade earning. But the role *was* the org chart — and the org chart is changing.

⸻

#### What this means if you're hiring

Stop hiring for translation. Stop writing job descriptions that read like they were generated from a 2018 engineering ladder. Senior engineers whose pitch is "I can convert tickets to PRs faster than the next person" are going to be very confused, very soon, about what they're doing every day. You don't need them. You need engineers who can define a harness, hold the line on quality, and design systems an agent can safely operate inside.

Stop hiring engineering managers whose primary skill is coordination. Hire managers who can contribute — to design, to definition, to the trust system. The standup-runner archetype is over.

Hire more *what* people. Not product managers as ticket factories. *What* people who can hold a thesis, define "good" in ambiguous situations, and operate the agent themselves rather than handing intent over a wall to someone else.

Hire fewer people total. This is the hard one to say out loud. The team that does the same amount of work next year is going to have meaningfully fewer people. Not because the people were bad. Because the translation layer collapsed. Pretending otherwise leads to bloated orgs that move slower despite better tools, which is the worst of both worlds.

⸻

#### What this means if you're an engineer

Don't compete with the agent on translation. The agent will win. The agent will keep winning, faster, every quarter.

Pick up the work the agent can't do. Define what "correct" means. Build the harness. Hold judgement. Take responsibility for outcomes the agent can't be accountable for. Move toward the *what* and the *why* without abandoning the *how* — because the *how* people who survive are the ones who can still operate at the deepest layer when something genuinely hard breaks.

The middle is the dangerous place to be right now. Not because middle people are bad. Because the middle is where the translation work was concentrated, and the translation work is the work that's going.

The good news — and I keep saying this because I believe it — is that this is a paradigm shift, not a job crisis. The work that's left is more interesting and more valuable than the work that's leaving. Defining the *why* and the *what* is more rewarding than running the standup. Designing the harness is more rewarding than approving the ticket. The shape of the team is changing because the shape of the work is changing, and the work is getting closer to what we always said we wanted it to be — judgement-heavy, hands-on, outcome-owning.

⸻

#### The org chart, finally

I started this post with the shape of the old org chart. *Why* at the top, *what* in the middle, *how* in the broad bottom layer, with a manager class running the seams.

The new shape is different. The *why* layer stays. The *what* layer grows. The *how* layer shrinks but gets harder. The manager class either contributes or disappears. The agents do the conversion work, with a harness around them.

That's not a layoff plan. It's an evolution of what work is. And every leader I'm talking to is feeling some version of it, even when they can't quite name it yet.

The work was always the *why* and the *what*. We just spent thirty years pretending the *how* was the work, because the *how* was where the headcount was, and headcount was where the budget was, and budget was where the org chart was. The headcount is going to move. The org chart is going to follow.

The teams that figure out the new shape first are going to look unrecognisable to their competitors. Smaller. Stranger. More opinionated. Closer to the work. The harness from [The Tests We Skipped](/content/the-tests-we-skipped) is what makes this shape safe to operate — without it, the small team plus agents is a faster way to ship the wrong thing. With it, the small team plus agents is what the rest of the org chart used to look like before we built the translation pipeline on top of it.

That's the shape I'm watching for. That's the shape I think wins. And — for what it's worth — that's the shape I've been arguing for in different language for a long time. The agents are the deadline that finally makes the room move.

More to come.
