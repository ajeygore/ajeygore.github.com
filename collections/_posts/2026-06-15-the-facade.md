---
layout: post
title: "The Facade"
published: true
categories: [AI, Engineering, Engineering Practices, Testing]
description: "Vibe-coded software ships, demos, and even works. It still rots, because the engineering fundamentals underneath were never there. On cargo-cult engineering, the rent you pay for a facade, and why the model was never the moat."
keywords: "vibe coding, AI agents, software engineering fundamentals, cargo cult programming, design patterns, software architecture, microservices vs monolith, technical debt, engineering judgment, engineering leadership"
lead_image: blog/og/the-facade.png
---

<div class="post-epigraph">
  <p>A film set survives exactly one thing: the shot. The trouble starts when someone decides to move in.</p>
</div>

If you've ever been on a studio backlot, you've walked down a street that doesn't exist. A row of perfect storefronts: the saloon, the bank, the sheriff's office. A weathered sign that took someone a real afternoon to age just right. From the camera's position it's a town you'd believe completely.

Walk through any of the doors and you're standing in dirt, looking up at plywood braces and the back of the sign. There is no bank. There was never going to be a bank. The set was engineered to survive one thing: the shot. One angle, the right light, for as long as the camera rolls. It is exactly as much building as the scene requires, and not one board more.

<hr class="ornament" />

## Built to match the metric

I've watched a lot of software get built this year that is a film set. It runs, it demos beautifully, and everyone believes the town is real. It *is* real, for as long as the demo lasts. The work isn't fake. It's facade-deep, because that's all the shot asked for.

The demo is the obvious version. The quieter, more dangerous one is the metric. A facade is built to match whatever you point at it: the demo, the coverage number, the velocity chart, the Monday dashboard. Every surface gets dressed for what's measured, and nothing behind it has to be true.

AI is exceptional at building these facades. Point an agent at a feature and it hands you the storefront — screens, routes, file structure, a test file with the right name on it — faster than you can sketch the building behind it. The early success is real, and intoxicating. You got a town in an afternoon, and every metric came up green.

Then you move in. You put real users in the saloon and a real ledger in the bank, and you find out what the set never had to be: load-bearing. It matched the number it was built to match, never the load it was about to take.

**The danger isn't that vibe-coded software looks broken. It's that it looks finished, and the metrics agree.**

<hr class="ornament" />

## The island that built an airport

There's a reason the inside ends up empty, and Richard Feynman gave it the best name we have.

In a 1974 commencement talk, he described the cargo cults of the South Pacific. During the war, planes had landed on remote islands and unloaded riches the islanders had never seen. Then the war ended and the planes stopped. So some of them tried to bring the planes back. They cleared runways, built a control tower out of bamboo, carved headphones from wood and sat in them, lit fires along the strip, and marched the formations they'd watched the ground crews run. They reproduced the form perfectly.

No planes came. The towers and headphones never caused the planes; they were downstream signals of a machine the islanders couldn't see and hadn't built. Feynman called it cargo cult science: work that has all the apparatus of the real thing and misses the one part that made it work.

They weren't foolish. The ritual really had coincided with the planes.

That's the trap, and it's ours. Every engineering discipline is a ritual that once coincided with something real. AI now lets you perform the ritual at zero cost while the real thing never shows up.

**The rituals were never the engineering. They were the evidence of engineering. AI gives you the evidence for free.**

<hr class="ornament" />

## The planes the rituals used to bring

I'm working with a team that wants to transform itself with agents. Smart people, real ambition, roadmap pointed at autonomy. The best models are already in their editors, and everyone is prompt-engineering their way to features. Everyone is doing AI. Almost nobody is doing engineering with AI. Every time I get under the hood, I find the same thing: the basics are gone. Not missing. Gone, the way a habit goes when nobody remembers why they had it.

I asked one of their senior engineers what would happen if we dropped the PR review step.

**"Oh, that would put so many bugs into the system."**

**"But you review every change today, carefully. You still ship plenty of bugs. So what is the review actually catching?"**

**No answer. Silence!**

That's the whole post in one exchange. A ritual everyone defends and nobody can connect to the outcome it's meant to produce. It's the wooden headphones. The silence isn't anyone hiding something — it's that nobody has asked the question in years.

So before anyone in that building talks to me about agents, I make them walk the rituals back to the plane each one used to signal. Coverage was a signal that someone understood how the code breaks; "get it to ninety percent" buys the number and tests that assert a function was called, not that its answer was right. Review was a second mind reasoning about a change; *LGTM* on four hundred unread lines is the posture with the function gone. Continuous integration was proof the system still fit together; a long-lived branch with a green badge is a fire lit for a plane that isn't coming. I've called this [hopeless](/content/what's-hopeless-in-product-engineering) for a decade.

But those are symptoms. The disease is underneath the code, and it's worse. I keep meeting engineers — senior, shipping daily — who were never taught the machine they stand on. They can't tell you how a packet actually crosses a network, or how the OS decides which thread runs next. They've never read an RFC and aren't sure what one is for. Encapsulation is a word from a tutorial, not an instinct; design patterns are something the model inserts, not something they reach for; "scaling" means adding more pods. The form of a senior engineer is all there. The understanding the title used to require is gone.

It shows up loudest in architecture, where the calls now get made by fashion instead of reasoning. Microservices because that's what real companies do. Serverless because it's modern. Kubernetes because the conference talk had it. Almost nobody asks the questions that actually decide it: what's the load, how big is the team, what are the failure modes — and would a boring monolith absolutely rock for where this company is today? That is cargo cult at the architecture layer: copying the shape of what scaled somewhere else without understanding what made it right there and wrong here. I spent years learning which shapes survive ~900 services and which quietly kill you; none came from picking the fashionable box.

Underneath all of it sits the one thing that was never a ritual: **deciding what "correct" means before you build — and knowing the machine well enough to decide it.** When execution becomes free, [judgment becomes the expensive thing](/content/the-expensive-thing), and judgment is just fundamentals plus scar tissue: the two things the form always leaves out.

I went in to help that client build agents and spent the first month fixing things I'd have insisted on in 2010. You cannot automate past a discipline you never had. Agents don't install the engineering you skipped. They remove the last few humans who were quietly compensating for its absence.

**The form is perfect. The planes still don't land. And when you ask why, the room goes quiet.**

<hr class="ornament" />

## The bill in the mail

The cruel part is the timing. A facade doesn't fail on day one. It performs *best* on day one.

The demo lands. The first ship feels like magic. Velocity is euphoric: you stripped out everything that slowed you down, and nothing has come to collect yet. It's not fake. It's front-loaded. You borrowed the success from the future, and the bill is still in the mail.

Then the bill arrives, as load. And it rarely arrives as a clean collapse. This is the part that's probably you. Your software ships. It runs. It does real work, more than a demo. Does delivery feel like this: every feature needs monkey-patching the week after it lands, the bug queue never drains because you open six for every five you close, estimates slip, and the QA cycle that used to take three days now takes two weeks because nobody trusts the build? You're still shipping. You're just shipping with a hand permanently on the patch. The town didn't fall down. You're paying rent on the facade, and the rent goes up every sprint.

**The speed everyone is celebrating is the leading indicator of the bill, not the proof it's working.**

The reason Gojek's engineering became something people talked about wasn't speed. Plenty of places are fast. It's that the thing behind the storefront was a building. Hundreds of engineers shipping into nine-hundred-odd services, thousands of deploys a week: that surface does not survive on facades. It survived because the unglamorous work was done: somebody defined what "correct" meant for driver allocation city by city, the integration was real, the review was real, the harness [held weight](/content/the-solo-climb). We weren't fast *despite* the discipline. We were fast *because of* it.

<hr class="ornament" />

## What's behind a real wall

The fix is not "slow down." That's the lazy reading; the leverage is real and worth keeping. The fix is to rebuild the causation, not the ritual. Stop asking the agent for the coverage number and start asking it for the failure cases you're afraid of. Stop counting approvals and start demanding that something understands the change before it ships: a second engineer, or [an agent that reasons about the diff](/content/the-solo-climb) instead of stamping it.

Each of these was a compression of judgment into a habit. We let them go slack for years because six engineers, a QA team, and a slow release cycle absorbed the difference. The new shape strips that redundancy out: the discipline has to become deliberate again.

If you run the company, the move is smaller than a reorg and harder than one. Change the question you ask on Monday. Not "how fast did we ship," and not "is the dashboard green." Ask "what did we verify, and how do we know." A team optimizes for the question it's asked. Ask for the metric and you get the facade. Ask for the verification and you might get a building.

And don't confuse the engine for the win. Everyone will have a frontier model, cheap and roughly equal. AI is a multiplier: point it at a real engineering foundation and it compounds; point it at a facade and you get a bigger facade, faster. It helps only as much as the engineering underneath it is sound. The foundation you built is the win, not the model bolted on top.

**You don't get the plane by building a better tower. You get it by being the thing the tower was always pointing at.**

<hr class="ornament" />

## The town on the hill

The set is still standing. From the road it looks exactly like a town, better than a real one, because every board was placed for the camera and nothing is worn by use. That's the part that should worry you. A ruin looks like a ruin. A facade looks finished.

So the question to ask of anything you shipped this year isn't whether it works. It worked in the demo; that's what demos are for. The question is whether there's a building behind the front wall, or whether you just got fast at building front walls.

And the plane does land. That's the twist the cargo cult never had: every release ships. It just lands the way it lands on a muddy strip: in the dark, the whole team holding its breath, fingers crossed, hoping the gear holds one more time. You've learned to call that normal. It isn't. That dread is the rent, and it comes due every sprint.

Build the runway that actually leads somewhere, and the plane lands the boring way: on time, in daylight, nobody praying. That's the prize the speed never was. Not faster. Calm.

More to come.

<hr class="ornament" />

## References & further reading

* [Beware Cargo Cult Thinking](https://johnmjennings.com/beware-cargo-cult-thinking/) — John M. Jennings. The clearest short piece on cargo cult thinking as a cause-and-effect failure, with everyday examples and warning signs.
* [Cargo Cult Science](https://calteches.library.caltech.edu/51/2/CargoCult.htm) — Richard P. Feynman's 1974 Caltech commencement address, full text. The primary source for the metaphor. ([PDF version](http://calteches.library.caltech.edu/51/2/CargoCult.pdf).)
* [The Solo Climb](/content/the-solo-climb) — what a load-bearing harness actually is once the team that used to catch you is gone.
* [The Expensive Thing](/content/the-expensive-thing) — when execution becomes free, judgment becomes the expensive thing.
* [The Tests We Skipped](/content/the-tests-we-skipped) — the instalment plan on skipped discipline, and the day it gets called in.
