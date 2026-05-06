---
layout: post
title: "The Tests We Skipped"
published: true
categories: [AI, Engineering, Engineering Practices]
description: "I argued for tests, trunk-based development, and against the PR-rubber-stamp ritual for twenty years. Most teams didn't listen. Now AI is shipping in hours, the bugs are shipping in hours, and the industry is rediscovering — under new names — every practice we used to skip."
lead_image: blog/the-tests-we-skipped.svg
---

<div class="footnote">
<strong>&ldquo;The argument I lost for twenty years is the argument the industry is now winning, by accident, through the back door.&rdquo;</strong>
<p/>
</div>

#### A position I held for twenty years

For most of my career I argued *for* writing tests.

Not quietly. In standups, in team rooms, in conference talks, in 1:1s with engineers I was trying to convince. I pushed for trunk-based development. I pushed for unit tests as the way you knew you hadn't broken something that worked yesterday. I pushed against the pull request culture as it actually got practiced — not against review, but against the theatre of review we'd built around it.

Most people didn't listen.

That's not a complaint. That's the starting condition. The conversation about AI and engineering has, in the last six months, started circling back to almost every position some of us were holding for twenty years — quietly losing the argument every quarter, watching the bug tracker fill up, getting the half-eye-rolls in standup. The new wrinkle is that the people rediscovering these positions are calling them new things. Spec-driven development. Eval-first engineering. Verifiable execution. New labels. Same practices.

This time, the industry doesn't have a choice.

⸻

#### The argument for tests, in plain language

The argument was always simple, and I've made it a thousand times.

You write a unit test for two reasons. One: you want to know, today, that the code you just wrote does the thing you think it does. Two: you want to know, six months from now when somebody else changes something nearby, that *the thing your code did then still works now*. That's it. Tests are not paperwork. They're the thing that lets you sleep on Sunday.

The bug that comes back. The regression nobody saw coming. The release that broke a feature nobody was thinking about. Tests are the only protection any team has against those, and the protection is cumulative — every test you write today is a test that catches you next year, next refactor, next migration. Nothing else in software has that property. Documentation rots. Tribal knowledge walks out the door. Tests, if you keep them green, just keep working.

The argument against tests was always the same: tests waste time. *I'd rather ship.*

What that argument always dropped was the time on the other side of the ledger. Manual QA, run by hand, every release. The same regression test, executed by a human, again and again and again, because the team didn't trust their automation enough to skip the manual pass. The bug that came back in production six weeks later because nobody wrote the test that would have caught it. The 4am incident. The customer escalation. The Sunday spent rolling back a release.

You weren't saving time. You were deferring it onto people you weren't counting in the same column. Often QA. Often support. Often the on-call engineer at 2am. The cost was always paid. The lie was that it wasn't.

⸻

#### The PR ritual, and the responsibility it quietly moved

This is the other position I lost for twenty years. The agent conversation is finally surfacing it.

The argument: pull requests, as practiced in most teams, do not catch bugs. They perform the catching of bugs.

Here's how it actually works in most places. An engineer writes some code. Opens a PR. The senior engineer assigned to review pulls up the diff in the browser, scrolls through it, leaves a comment about a variable name, suggests a tiny structural tweak, hits approve. They almost never check the branch out. They almost never run the tests against it. They almost never trace a function through the codebase to see what else it touches. The review takes ten or fifteen minutes — for changes that took the author days to write.

That ten-minute review accomplishes something almost worse than nothing. The author of the code, the moment the senior engineer hits "approve," mentally transfers responsibility for the change. *They wrote it. The senior reviewed it. It must be fine.* When it breaks two weeks later, nobody quite owns it. Two pairs of eyes were on it. Neither pair did the actual work of verification. And nobody on the team wants to be the one to say so out loud.

I argued for years that this was upside down. That the right model was simpler: the person who writes the code is the person who pushes it to production. Full stop. Review is a conversation, not an absolution. The confidence to push has to come from the author's own knowledge that nothing is broken — and the only way an author can know nothing is broken is if there are tests, run automatically, in a build they trust, on every commit.

**No tests, no confidence. No confidence, no push.**

The PR-as-rubber-stamp pattern was a comfortable lie that let everyone feel good about the process without anyone doing the work the process was supposed to be doing. It was a way to look like we cared about quality without paying the cost. I lost that argument too. Most teams kept the ritual. Most teams kept being surprised when production broke.

⸻

#### What the AI conversation is finally surfacing

Here's the part that's funny, in a tired way. Watch the AI safety conversation closely for a minute. Eval suites. Tool-call sandboxes. Approval gates. Agent-of-agent review patterns where one agent writes the code and another reviews it and a third runs the tests. Specs as a first-class artifact. Spec-driven development.

Read those phrases as someone who's been at this a while, and you'll notice something. None of them are new.

Spec-driven development is BDD, and ATDD before it, and *executable specifications* before that. Eval suites are integration tests with a different audience. Agent-of-agent review is what code review was always supposed to be — finally executed by something with the patience to actually check the branch out, run the tests, and trace the change through the codebase. Approval gates are what release management always was, before "shipping fast" turned the gate into a sticker. Specs are specs. Tests are tests.

The conversation isn't inventing engineering rigour. It's rediscovering it.

What's different is the loop. When AI ships your feature in three hours, the bugs ship in three hours too. Your blast radius compressed from a sprint to an afternoon. The instalment plan you were paying on quietly for twenty years just got called in. You can't dodge the cost anymore by spreading it across enough days that nobody feels it.

The teams that argued against tests for two decades are now standing up eval suites because they have to. The teams that argued against trunk-based development are now adopting it because long-lived branches don't survive a codebase being modified by agents. The teams that built the PR-rubber-stamp ritual are now watching agents review each other's code and quietly wondering what their senior engineers were doing in those ten-minute reviews all those years.

**The agents didn't break the system. The agents just ran fast enough that the broken system stopped being invisible.**

⸻

#### The harness was always the work

You can put a harness on AI. You should. Eval suites, sandboxes, approval gates, dry-run modes, agent-of-agent review — all of it good, all of it necessary.

But here's the thing nobody is saying out loud. Every harness you build for the agent works for the human too. The eval that catches the agent's mistake catches the engineer's. The acceptance criteria that pin down the agent's task pin down the engineer's. The golden build that fails when the agent's PR breaks something fails the same way when a human breaks it. You're not building infrastructure for AI. You're building the infrastructure you should have had all along — the infrastructure some of us were asking for in 2008, in 2014, in 2019 — and the agent's arrival is just the deadline that finally moved the room.

The argument I lost for twenty years is the argument the industry is now winning, by accident, through the back door, because agents made the cost of *not* having the harness suddenly visible.

I'm not bitter about this. I'm relieved. The work I always wanted teams to do is the work teams are finally doing — not because they were convinced, but because the loop got short enough that they had no choice. I'll take wins however they come.

⸻

#### Spec-driven development, and other rediscoveries

I keep getting sent posts about spec-driven development as if it were a revelation. The first time someone DM'd me a thread on it, I laughed for a minute and then I felt old.

Specs were always the answer. BDD tried to make specs executable. ATDD tried to make them the source of truth. *Living documentation* was a phrase people used in the 2010s to describe exactly this. None of it caught on widely, because writing the spec felt slow and shipping felt urgent, and the cost of skipping the spec was paid by someone else, later — usually a QA engineer, a support team, or a 2am pager.

Now the spec is the thing the agent reads. It's also the thing the test suite is generated from. It's also the thing the eval is built against. Specs aren't optional anymore because without them the agent is guessing and the team is hoping. So we get spec-driven development. Same idea, sharper teeth, new name.

I'll take it. I don't care what we call it. If the rebrand is what it takes for teams to finally take specs seriously, I'll cheer the rebrand. Some of the best ideas in software take twenty years to get accepted, and they usually need a new name to get there.

⸻

#### The tests we skipped

I think about the engineers who argued with me, in standups, ten years ago, about whether we should have a test for this. I think about the teams that picked the PR ritual over actual review. I think about the people who said *we don't have time for tests* and meant *we don't have time for the work of being right.*

I'm not angry about any of it. Most of those people were doing what the industry was telling them to do. The industry has finally stopped telling them that. The shape of the work is making the case I couldn't make, and making it more convincingly than I ever could, because the cost of skipping the harness shows up now in three hours instead of three quarters.

The tests we skipped are the tests the industry now has to write. Not because AI demands it. Because the work always demanded it, and the slow blast radius of the old world was the only thing letting us pretend otherwise.

The good news is that the work is finally easy enough to do. The bad news is that the excuse is finally bad enough to call.

More to come.
