---
layout: post
title: The Sapling
published: true
categories: Essay
description: "Architecture isn't a blueprint you draw upfront. Software grows like a tree from a sapling, and the real work is the shared, early, one-way decisions that keep it alive."
lead_image: blog/og/upfront-design-isn't-for-building-software.png
---

<div class="post-epigraph">
  <p>A blueprint is finished before the building starts. Software is never finished, and that's the whole point.</p>
</div>

We borrowed the word "architecture" from civil engineering, and we've been paying for the loan ever since. Say "software architect" and everyone pictures the same thing: a diagram of boxes and arrows pointing in every direction, living on a wiki nobody opens. It looks coherent. Then the system gets built, the diagram and the code drift apart, and you're left asking what the architecture was even for.

The mistake is treating architecture as something you finish upfront.

<hr class="ornament" />

## What civil engineering can't teach you

In civil engineering, once the design is signed and construction starts, you don't deviate. The integrity of the building depends on following the blueprint exactly. You might add a floor or a wing, but you do not move the load-bearing walls.

Software is the opposite. Changing direction mid-build is hard, but it's always possible, and often it's the right call. Architecture in software is a direction, not a contract. And because software is built incrementally rather than poured all at once, the elaborate upfront diagram and the fifty-slide deck aren't just unnecessary. They're counterproductive. This is the whole premise of agile: stay adaptable as the system grows.

> Architecture has to respect the malleable nature of software. Agility is the ability to change things as you build them.

<hr class="ornament" />

## Architecture grows, it isn't drawn

The honest analogy isn't a blueprint becoming a building. It's a sapling becoming a tree, the same way you grow a team or an org. You don't know exactly who will join next year. You do know the direction they should head.

Melvin Conway saw the link decades ago:

> [Any organization that designs a system] will produce a design whose structure is a copy of the organization's communication structure.

I've watched [Conway's Law](https://en.wikipedia.org/wiki/Conway%27s_law) hold in company after company. The teams whose shape mirrors their software ship more reliably. The structures travel together:

<table class="table table-striped table-bordered">
  <thead>
    <tr>
      <th>Software architecture</th>
      <th>Organisation shape</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Monolith</td>
      <td>Mostly one team</td>
    </tr>
    <tr>
      <td>Synchronous microservices</td>
      <td>A team per service, shared services owned by all; 1–10 teams, more messaging</td>
    </tr>
    <tr>
      <td>Async microservices + infrastructure</td>
      <td>10–100 teams, SRE islands, heavier async communication; documentation becomes critical for shared context</td>
    </tr>
    <tr>
      <td>Distributed</td>
      <td>100+ teams</td>
    </tr>
  </tbody>
</table>

So architecture and modularity evolve with the organisation; they aren't fixed upfront. The move from monolith to microservices is the classic example, and with it come database caches, async jobs, separate cron scheduling, splitting reads from writes, each one adopted to absorb new complexity rather than because a diagram called for it. That this evolution can also slow delivery down is real, and a topic for another post.

<hr class="ornament" />

## What a gardener knows

If software grows like a tree, the question is which decisions keep it growing instead of killing it.

A gardener doesn't control the tree. They share an understanding of the few things that matter: when to water, when to move it into shade, when to feed it, how much moisture to hold. Software teams need the same shared understanding, of the tech stack, of a consistent style, of how problems get solved here. None of it has to be big. It has to be agreed.

> The hardest part of growing a tree isn't any single task. It's that everyone tending it agrees on when to do what, including when you're not there.

Without that, you get a truck factor and a dead sapling. Architecture is the same: mostly a small set of early decisions that anyone can make correctly, as long as the team agrees on them.

Martin Fowler made the point at [OSCON in 2015](https://www.youtube.com/watch?v=DngAZyWMGR0), and again when I argued MVC patterns with him on a visit to India:

> As long as the Model, View and Controller are doing their jobs, it doesn't matter whether you render the model on the backend and send it to the browser, or fetch the data and render it in JavaScript.

Let the architecture evolve. Keep a common understanding of how the components talk to each other. Write that understanding down as principles, and the system scales.

You'll also prune. Sometimes you cut a branch to keep the tree's shape, discarding or reimplementing a part of the system and ignoring the sunk cost. Sometimes you stake it, leaning on a SaaS product in the early days for strength you don't need to build yourself yet.

<hr class="ornament" />

## A tech constitution

The decisions that shape the tree are mostly one-way doors, in Jeff Bezos's sense: expensive to reverse. Your tech stack, language, databases, automation, even which SaaS you depend on, all one-way, all changeable in theory, all costly in practice. Hiring is the same kind of decision.

Write them down. That document is your tech strategy, and in a real sense it is your architecture: a shared understanding of the early, one-way decisions. Call it a tech constitution for your product engineering org.

A few things make it real:

* Standardise across languages, databases, caching, communication, services, and code structure.
* Keep a quality checklist that every change clears before production.
* Use that standardisation to move people between teams without friction.
* Be explicit about what to build, and how to build and integrate it.
* Treat architecture as the central guiding principle, not a notion on a wiki.
* Automate day-one setup so newcomers get context fast.
* Reduce the dependency on any one person for architecture decisions.
* Prefer convention over configuration.
* Make testing a first-class part of the lifecycle, not an afterthought.

<hr class="ornament" />

## The Gordian knot

As Group CTO in a previous org, I inherited a cacophony of stacks: Java next to Scala, Python next to JavaScript, each marching to its own drum, with no shared structure and no coherent way for services to talk. That was our architecture disaster.

The fix wasn't a grand redesign. We agreed on a common language, narrowed the sprawl of languages and databases to a standard set, and wrapped them in a templatised code structure. The capstone was a plain checklist of quality gates every change cleared before production.

That did two things. It caught problems, and it turned our engineers into people who could move between teams without relearning the world each time, because the world was the same shape everywhere. Onboarding stopped depending on a tour guide. Newcomers got a compass instead.

That is the purpose civil architecture serves too: everyone knows what to do and how to do it, so the work moves. The difference is that software gets there without the big upfront design. It gets there through a shared understanding, one any engineer can explain to any other, of **what to build, and how to build and integrate it well.**

More to come.
