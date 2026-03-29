---
layout: post
title: "The Expensive Thing"
published: true
categories: [AI, Leadership, Engineering Management]
description: "Every conversation about AI agents celebrates speed. But the hardest problem isn't building agents — it's deciding what 'correct' means. When execution is nearly free, judgment becomes the expensive thing."
lead_image: blog/the_expensive_thing.svg
---

<div class="footnote">
<strong>&ldquo;If expertise is approaching free, what becomes expensive?&rdquo;</strong>
<p/>
</div>

#### What everyone in the agent conversation is missing

Every conversation I've had in the past few months — with founders, board members, investors, government leaders — lands on the same narrative. Agents are here. They write code, handle customer calls, compress drug discovery from months to hours. Move fast or die.

I agree with almost all of it. And yet the conversation keeps missing the hard part.

There's a heuristic making the rounds: *AI agents can replace human execution wherever the output is verifiable.* Wherever you can check whether the work is correct, an agent can do it.

This sounds clean. It's also the most dangerous idea in tech right now — not because it's wrong, but because it hides the real question. The hardest problem in the age of agents isn't building them. It's deciding what "correct" means.

⸻

#### Verification is the work

I spent years scaling a platform from about 300,000 to 120 million monthly orders across Southeast Asia. At peak, we were running ~900 microservices, pushing thousands of deployments a week, with hundreds of engineers making changes every day — sometimes every hour. The engineering was hard. But the hardest part was never writing the code. It was defining what "working correctly" meant across all of that surface area.

What does "correct" mean for an ETA algorithm in Jakarta traffic versus Ho Chi Minh City? What does a "successful" driver allocation look like when you're balancing earnings fairness, customer wait time, and fleet utilisation simultaneously? When hundreds of engineers are shipping into ~900 microservices around the clock, "correct" isn't one definition — it's thousands of definitions, all shifting, all context-dependent. These aren't edge cases. They're the entire job.

And they're precisely the kind of judgment that agents cannot perform for you.

Think about it outside of software. A hiring rubric. A regulatory approval. A financial audit. In each case, someone had to define what "good" looks like *before* anyone could evaluate the output. The evaluator's job looks mechanical — check the boxes, verify the criteria. But the person who designed the criteria? That was the real work. That was the judgment call.

Agents are the same. Everyone celebrates the agent that writes the fix, runs the tests, and deploys it without a human touching it. Sounds like magic. But someone designed those tests. Someone defined what "passing" means. Someone built the entire scaffolding that makes autonomous deployment safe. That human work is invisible in the narrative, but it's the load-bearing wall.

**The danger isn't that agents will fail to execute. They're getting scary good at execution. The danger is that organisations will deploy agents against poorly defined problems and mistake fast for correct.**

⸻

#### It's not a tech problem. It's a management problem.

The prevailing narrative frames this as adopters versus laggards. I think the real split is different. It's between organisations that can change how decisions get made and those that can't.

Here's a number that should bother everyone: 88% of firms use AI, but only 6% see real gains. That's not a technology adoption gap. Tools are easy to buy. That's an organisational design gap. The 6% have done something much harder than purchasing AI — they've reorganised authority, changed decision structures, rebuilt workflows around what agents can and cannot do.

**AI adoption is not a procurement decision. It's a management topology change.**

Most organisations aren't built for this. They have approval chains designed for a world where humans execute every step. Middle management layers whose entire purpose is coordinating human workers. Incentive structures that reward activity over outcome.

Agents don't fix any of this. They amplify it. Good decisions get executed faster. Bad decisions — or the more common disease, *no* decisions — also get executed faster. If your organisation struggles to define what success looks like today, agents will just help you fail at speed.

⸻

#### The legacy delusion

One more thing, because I keep hearing it — especially in Singapore: *agentic coding will finally crack legacy modernisation.*

I've spent a career in legacy systems. The productivity claims are probably true for the coding part. They're also probably irrelevant. Legacy migration doesn't die because of engineering capacity. It dies because nobody documented the business rules, because data quality issues only surface at migration time, and because every legacy system has stakeholders who benefit from it staying exactly as it is.

**The bottleneck was never writing code. It was the courage to commit to change and the patience to understand what the existing system actually does.** Agents don't solve courage. They don't solve consensus.

⸻

#### So what actually plays?

If verification is the key insight, then the strategic question isn't "where can I deploy agents?" It's "where have I already built the infrastructure that makes agent deployment safe?"

**Define "correct" before you automate.** The organisations seeing real gains aren't the ones that moved fastest. They're the ones that spent time on success criteria, test infrastructure, and feedback loops that catch failures early. Unsexy work. Also the moat.

**Reorganise around verification, not execution.** If agents handle execution, the human job becomes designing verification systems, defining quality, and handling the ambiguous cases agents can't resolve. Your org chart should reflect this. Practically, this means your Monday morning standup changes. Instead of "what did we ship?" the question becomes "what did we validate?" Instead of tracking output, you're tracking whether the output was *right*. The team that used to have ten engineers building features now has three engineers and seven people defining acceptance criteria, designing test harnesses, and monitoring outcomes. That's the reorganisation. It's uncomfortable because it demotes the act of building and promotes the act of judging. Most engineering cultures resist this. The ones that don't will win.

**Build for the judgment layer.** The premium doesn't just shift from executors to problem-framers. It shifts to people who can define what "good" looks like when the answer isn't obvious. That's taste. That's context. That's knowing how systems behave in the real world because you've shipped things that broke and had to figure out why.

**Be sceptical of speed.** Everyone's celebrating compression — months to hours, years to days. Speed matters, but only downstream of correctness. Compressing timelines without compressing the validation process is just faster failure.

⸻

#### The builder's edge

Here's the thing the current conversation gets right, even if nobody says it quite this way: the age of agents rewards builders.

Not builders as in people who write code. Builders as in people who spot problems, construct solutions, iterate, and take responsibility for whether things work. People who've shipped things that broke at 3 AM. Who have scar tissue from production incidents and systems that behaved nothing like they did in testing.

Agents are force multipliers for this kind of person. They shrink the cost of trying. They compress the iteration loop. A single person with the right tools can now produce what used to require a large organisation.

But agents don't replace the instinct for where a system will fail. They don't replace the discipline to define what success looks like before you start building. They don't give you taste.

The question I hear most is some version of: *if you were building from scratch today, knowing that expertise is approaching free, what would you build?*

Good question. But I'd reframe it.

**If expertise is approaching free, what becomes expensive?**

Judgment. The ability to define "correct" in a world where execution costs nearly nothing. The institutional muscle to verify outcomes, not just produce them. The taste to know what's worth building in the first place.

That's the expensive thing.
