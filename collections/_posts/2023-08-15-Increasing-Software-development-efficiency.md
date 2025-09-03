---
layout: post
title: Untangling developer velocity
published: false
categories: Culture, Software Engineering
description: Essay on software engineering.
lead_image: blog/software_perspective.png
---

One of the most common question I get asked is how do we release software reliably? 

Reliable software does not fail, changes are applied gracefully and we have confidence that our changes won't break anything.

Software is super soft in terms of changes, companies spent millions of dollars ensuring software qualities, and thus spending way more time verifying software quality.

During development process, software changes are frequent and sometimes deadly. Frequent, becuase everyone needs to write code, everyday. And deadly 
because in later stages of development, we can't keep track of all changes, that can break other parts of Software.

When we start a project/product and start writing software, we almost know every functionality. Entropy is directly propertional to change or granularity.
Same applies to software development. Many startups come to me after few months for example six, twelve or eighteen months.

And the common questions - How do we increase speed, reduce bugs and focus on shipping than fixing. If you also feel that

* Features don't get released
* Even if they get released we don't have confidence that what will work and what won't?
* Our QA cycles are long, and everyone kind of stuck during that process?

And you have few frequently occuring themes in your conversations with team mates.

**The Symptoms**

* People work on bugs than stories
* Feature delivery perceived super slow
* QA Cycles are days instead of hours
* Even with QA cycles, things slip, features get delayed
* End of iteration, people working on PR merges
* Too many dependencies

**What makes it better?**

If you know that when you release software, it won't break. That's when you release it on demand. What can help us with that?


**Trust**

One of the most fundamental flaw, we all have copied "big organisation's behaviors" to our small company. One such behavior is PR based development or GitOps based workflow. These are mostly suited for big companies, low trust environment, solo-developers and no team ownership. We do not want any of these things, but still, we go for this. The biggest reason is some where we don't trust the code and logic produced by people. So we ask them to submit the PR. The time submit the PR, we look at it, sometimes we commment back or we just merge it. Now, that's the first problem, because PR only comes when work is complete. While our dev is busy working on PR, other files have changed, because others are also working and merging the PRs. 

Give this cycle of PR based development, we end up working on merging, resolving conflicts and end up checking in code that might be breaking some other parts, the reason, in early days we don't write tests, because mannual testing is more effective since scope is small, and we are happy with it. When team size goes up, and software starts getting bigger and bigger. Now we can't check all functionality - the absense of automated tests gives birth of exceptionally large and disproportionate manual QA department. 

First thing we need to do, give trust by default, instead of doing PR based development and rewiew process, ask seniors to sit with developers and review the code and correct it then and there, and let them merge as soon as possible. Ask them to write code with feature flags and commit daily.

Trust is first step towards team ownership.

**Tests**

Absense of a sensible test suite is more common that ever. 

Not only this, we try to copy org structures, we tried to copy the way their engineering managers work - while we do not need engineering managers in early stages, we immediately go hire CTO or CPO - while founders have to play these roles. Anyway! enough of whining about this, lets focus back on untangling software development.

Vast majoritity of people don't understand their work as Engineering managers, your hands are tied, because you know that nobody loves their job and theY dont lke their jobs, 
