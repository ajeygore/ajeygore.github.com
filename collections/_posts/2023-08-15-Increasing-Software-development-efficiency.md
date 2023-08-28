---
layout: post
title: Untangling Software Development
published: false
categories: Culture, Software Engineering
description: Essay on software engineering.
lead_image: blog/software_perspective.png
---

<p><img src="/assets/images/blog/software_perspective.png" alt="Software generation" class="responsive" /></p>

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

If these things resonate with you then read on.

One of the most fundamental flaw, we all have copied "big organisation's behaviors" to our small companies. One such behavior is PR based development or GitOps based workflow. These are mostly suited for big companies, low trust environment, solo-developers and no team ownership. We do not want any of these things, but still, we go for this.

Not only this, we try to copy org structures, we tried to copy the way their engineering managers work - while we do not need engineering managers in early stages, we immediately go hire CTO or CPO - while founders have to play these roles. Anyway! enough of whining about this, lets focus back on untangling software development.

So, when people complain to me about this, I have always given them a four-step approch to most probably fix these issues, but the approach has to be taken holisticly and should be implemented incrementaly, else this does not work.
