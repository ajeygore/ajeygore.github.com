---
layout: post
title: What are we building?
published: true
categories: Essay
description: Most early-stage products are built custom, one line of code at a time, when they could be assembled from a small set of well-understood building blocks. The question that forces that shift is the same one, asked again and again — what are we building?
lead_image: blog/what_are_we_building.png
---

<div class="footnote">
<strong>&ldquo;Most of what you think you need to build has already been figured out. You just need to know which blocks to pick up.&rdquo;</strong>
<p/>
</div>

#### The question that keeps simplifying things

Engineers over-engineer. Not because we want to — because we want a perfect, future-proof, scalable, modular system. Something that will handle whatever comes, however it comes, for as long as anyone might need it.

Which sounds great, until you notice that almost no one asked for any of that. You were hired to build a tech-enabled business. Not a technology showcase. Somewhere between "we need a pricing page" and the third architecture diagram, the original business got quietly demoted.

There's one question I keep coming back to. I used to ask it of myself. Now I ask it of founders who want my opinion on their stack. It sounds almost naïve, which is exactly why it works.

*What are we building?*

⸻

#### The Absolute WHAT

You know the [Five Whys](https://en.wikipedia.org/wiki/Five_whys) — the technique for tracing a problem to its root cause by asking "why?" until you can't. This is its sibling. Call it the **Absolute WHAT**. You ask "what are we building?" and then you ask it again about the answer. And again.

*"We're building a marketplace to connect sellers and consumers."*

What are we actually building?

*"An e-commerce portal."*

What are we actually building?

*"A catalog. A cart. A way to take payment. A way to get the thing to the person."*

And now you're somewhere useful. Every time you ask the question, the answer gets smaller, more concrete, more honest. Buzzwords fall off. The thing you're really making becomes visible. That clarity is the difference between shipping in six weeks and rewriting in six months.

⸻

#### The pattern hiding in plain sight

Here's the part most founders are surprised by. Once you've asked "what are we building?" enough times, you stop seeing your business as unique at the component level. It isn't. Almost no B2C business is.

Think about it. You could be selling pet food, chocolates, bedsheets, or gifts. Underneath, you need the same four things:

*A **content system** — to list what you have and describe it. A **order system** — to handle cart, pricing, discounts, promotions. A **payment system** — to take money and tell the order system it's done. A **logistics system** — to move the thing, physical or virtual, from you to the customer.*

That's it. That's 80% of a B2C product, sketched on the back of a napkin. Your unique thing lives in how you combine these blocks, in the customer you serve, in the story you tell. Not in whether you built your own payments layer from scratch.

I've watched teams spend a quarter building bespoke payments infrastructure because they were convinced their case was special. It wasn't. It never is. The special part was upstream.

⸻

#### Software as abstracted building blocks

This is the shift. Stop thinking of software as lines of code you write, and start thinking of it as a small set of **abstracted building blocks** you pick up, connect, and extend when necessary.

Each block has a clear input, a clear output, and a single job to do well. Your CMS is a block. Your OMS is a block. Your payment gateway integration is a block. Authentication is a block. Notifications are a block. Each one knows nothing about the others beyond what it's told.

When you build this way, four things happen quietly:

*You move faster, because most of your first release is assembly rather than invention. You stay flexible, because swapping one block for another is a small change, not a rewrite. You debug faster, because when something breaks it breaks inside a single block. And you can hire simpler people, because a clean block is a clean thing to understand.*

None of this requires microservices. None of it requires Kubernetes. A well-structured monolith with clean module boundaries is a pile of abstracted building blocks with fewer failure modes. The modularity is in your head and in your code, not in your infrastructure.

⸻

#### What people get wrong

Two mistakes I see all the time.

**The first — treating every module as custom.** A team says "we're different, our orders flow differently, we need a custom OMS." They spend three months building what Shopify, Medusa, or a fifty-line service could have given them on day one. Then they hit the actual business problem they were avoiding — which was never the OMS.

**The second — jumping to microservices to prove the modularity.** Microservices are a deployment choice, not a design choice. They buy you independent scaling and independent deployment at the cost of network complexity, eventual consistency, and a distributed systems problem you didn't sign up for. [CAP theorem](https://en.wikipedia.org/wiki/CAP_theorem) doesn't care about your pitch deck. Start with modules. Graduate to services only when a specific piece of your product genuinely needs its own scaling envelope. Usually that's year two or three, not week six.

The point of modular thinking is to keep your *options* open, not to pre-commit to the most complex option available.

⸻

#### How to actually use this

Next time you're in a planning session — yours or someone else's — try this. Take whatever is on the whiteboard and ask the question. *What are we building?* Listen to the answer, and ask it again.

Keep going until the answer is small enough to fit in one breath. That's your spine. Then ask — *which blocks make this up?* You'll usually find four or five. Some you'll build. Most you'll buy or pull off the shelf. The one or two that are genuinely unique to your business — that's where your engineering time should go.

Everything else is a block. Treat it like one.

⸻

**Most of what you think you need to build has already been figured out.** Someone, somewhere, has built a version of it and made it available. Your job isn't to rebuild it. Your job is to know which blocks to pick up, where to put them, and what to build between them that no one else can.

That's the whole game.

#### References
* [Five Whys](https://en.wikipedia.org/wiki/Five_whys)
* [Fallacies of distributed computing](https://en.wikipedia.org/wiki/Fallacies_of_distributed_computing)
* [CAP Theorem](https://en.wikipedia.org/wiki/CAP_theorem)
* [No Silver Bullet, essential vs accidental complexity](https://en.wikipedia.org/wiki/No_Silver_Bullet)
* [Modular programming](https://en.wikipedia.org/wiki/Modular_programming)
* [Abstraction in software engineering](https://en.wikipedia.org/wiki/Abstraction_(software_engineering))
