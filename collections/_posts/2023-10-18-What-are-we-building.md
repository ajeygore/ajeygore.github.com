---
layout: post
title: What are we building?
published: true
categories: Essay
description: If startups think in Modular and abstraction based systems as identified above they can build simpler product with the most efficiency.
lead_image: blog/what_are_we_building.png
---

<p><img src="/assets/images/blog/what_are_we_building.png" alt="Software generation" class="responsive" />
</p>

##### THIS IS A DRAFT

Engineers over-engineer, not because they want to but because they want to have a perfect, future proof, scalable and modular system. 
It should be able to scale up and down in future, and also it should have feature friendly modular design.


Many times this over-engineering is the result of intent to achieve technical excellence, while they are looking to build a tech-enabled business, 
it's not something that should be the primary focus, having a tech co-founder, having a view on building the best tech, or thinking about creating unique intellectual property. At times, this has proven to be counter-intuitive. 

One of the ways to avoid this to ask a question - at a basic abstraction level, I used to think myself "What are we building?" and now I turn to our founders and people who ask for my opinions -  "What are you building?"
I have always asked this question to my teams, and now since I work with many founders, I ask the same question to the founders - "What are you building?"

"What are you building" can be a great question, it's like asking [five WHYs](https://en.wikipedia.org/wiki/Five_whys)?
* **Five Whys** help us navigate through a problem to it's solution, I think applying **Absolute WHAT** might help us in understanding the startup journey, core-idea and how we think about building and navigating prioritisation in early days.

So back to the question, When I ask "what are you building" again and again, the intent it to simplify what are we building - we can start with saying that we are building a market place to connect sellers to consumers, if you ask that question again, "but what are you really building?" we might say that we are building an e-commerce portal
**The Absolute WHATs are something equivalent to a discovery of core idea, and helps you decide multiple things**
* It tells you as to what are you building?
* It also helps you creating a guideline around build vs buy thought process
* It also tells you what's the core product, and how can we always get focussed 

Dumbing it down, what are you building, what are you NOT building and also what are things that  matter while building, because they play a crucial role in your ability to deliver faster or better? Things such as
* Essential complexity vs Accidental complexity
* CAP Theorem

And many time we end up in their quick-sand and it's tough to come out without a major rewrite or firebreak, and that's not something you want to get into in early days.

So how do we think about what are you building? Essentially we are building some kind of systems, think about a B2C idea about selling pet food, chocolates, bed-sheets, gifts? What's the common minimum system we can find as pattern across all these business ideas? All these systems require a **content management system**, an **order management system**,  a **payment system** and a **logistics system**

Let's just elaborate this a bit.
* **Content Management System** will provide the features for listing your SKUs, and limited product availability information - when we start, we do not have to worry about warehousing, because we are just starting up, few things can be extension on CMS but at the scale, we might choose to put them in a separate module.
* **Order Management System** takes care of orders that may involve shopping cart, pricing, discounts and promotions etc.
* **Payment System** is pretty obvious - it manages the payments, at the start it just integrates with a payment gateway, and tells the order management system that order payment has been fulfilled and ready for the next step.
* **Logistics System** handles order shipping - physical or virtual.

Many startups go through similar systems, many startups are powerhouse of innovation. And in these times people often underestimate the **The Power of Modular and Abstraction-Based Systems**
In the throes of innovation, it's easy for startups to get swept away by buzz words, complex systems or just by latest toy in the market, eg by microservices, they often take the center stage. Not because they are the best, but because every scaled system uses them in some form.
While there's no denying the potential benefits of such structures, it's crucial to first consider a simpler and more effective approach: modular and abstraction-based systems. This philosophy can guide startups to design efficient products that seamlessly integrate essential components like OMS (Order Management System), CMS (Content Management System), CRM (Customer Relationship Management), and payment systems.
*  #### 0. **Identifying the WHATS**
    The first step towards building a scalable and modular system is identifying the components - that build up your entire product. It can be few, or many, but you need to be able to figure out basic building blocks. And most of the time, that's the step **ZERO**
*  #### 1. **Focus on Core Needs First**
    While it's tempting to jump on the latest architectural trend, startups need to consider their immediate and core requirements. Often, these involve basic functions like order processing, content management, customer management, and payments. By first designing systems around these core components, startups can ensure they are serving the most immediate customer needs efficiently.
* #### 2. **Scalability Through Simplicity**
    A modular system is akin to building with LEGO blocks. Each module, or "block," is designed to perform a specific function and can be plugged into the larger system. This approach ensures that as the startup grows, new modules can be easily added or current ones can be enhanced without disturbing the entire system.
* #### 3. **Cost and Time Efficiency**
    In the early stages, resources are limited. Building complex systems can be resource-intensive, both in terms of time and money. In contrast, a modular approach allows for the incremental development of functionalities, letting startups deploy vital features faster and at a lower cost.
* #### 4. **Reduced Complexity = Reduced Maintenance**
    Every software system requires maintenance, but complex architectures intensify this need. With modular systems, problems can be isolated to specific modules, making troubleshooting and updates more straightforward.
* #### 5. **Enhanced Flexibility for Future Adaptations**
    The digital landscape is continually evolving. With an abstraction-based system, startups can easily swap out, update, or integrate new technologies and platforms as they emerge, without overhauling their entire software framework.
* #### 6. **Business-Unit-Centric Design**
    By focusing on core modules that cater directly to business to serve customers needs effectively (like OMS, CMS, CRM, etc.), startups inherently prioritise the internal workflow experience and thus end up with resulting frictionless user experience experience. This can lead to a more intuitive simpler and efficient features. And simple and smoother user journeys.
* #### 7. **Avoiding the Microservices Trap**
    One of the most important architecture advise I give to people is While microservices can offer scalability and flexibility, they come with their own set of challenges, especially for young startups. They often demand extensive coordination, infrastructure overhead, and can lead to intricacies in managing inter-service communications. Starting simple with a modular design can give startups the breathing space they need to understand if and when to transition to a microservices architecture. And another reason is that **Microservices** are bound by **CAP Theorem**, and you do not want to deal with this early on.

For startups, the initial stages are all about finding product-market fit, catering to user needs, and doing so efficiently. While it's essential to keep an eye on future scalability and flexibility, the immediate goal should be to provide value. Embracing a modular and abstraction-based approach can be the key to achieving this balance, allowing startups to build efficient, adaptable, and customer-centric B2C products.

So next time when are you in a building journey, ask this to yourself and your teammates - What are we building? We are building a e-commerce platform for teens and their needs. That's fine, but what are we building underneath as tech platform? and then watch out for those answers, and that's where you start your tech building journey!

#### References
* [Five Whys](https://en.wikipedia.org/wiki/Five_whys)
* [Fallacies of distributed computing](https://en.wikipedia.org/wiki/Fallacies_of_distributed_computing)
* [CAP Theorem](https://en.wikipedia.org/wiki/CAP_theorem)
* [No Silver Bullet, essential vs accidental complexity](https://en.wikipedia.org/wiki/No_Silver_Bullet)
* [Modular programming](https://en.wikipedia.org/wiki/Modular_programming)
* [Abstraction in software engineering](https://en.wikipedia.org/wiki/Abstraction_(software_engineering))
