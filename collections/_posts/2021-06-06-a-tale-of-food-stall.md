---
layout: post
title: A tale of a food stall, from monolith to microservices
published: true
categories: ['lessons', 'essay', 'architecture']
description: An evolution journey of a monolith hawker stall to a micro-services enabled restaurant.
lead_image: blog/food-stall-evolution.svg
---
<div class="footnote">
Source : Creative Commons <a href="https://www.flickr.com/photos/25802865@N08/12826250854" width="100%" height="100%"> Flicker </a>
<p/>
</div>

Few cult food outlets start their humble beginnings as hawker. A hawker stall is typically a one person shop. The person knows one thing and one thing better, cooks a truly tasty dish and that brings people to his stall all the time. Over the period of time, their popularity grows and they scale their operations for better customer service, profit and growth. This is the story of Opexill, a foodstall hawker, who started selling fastfood. When her popularity increased, she would exhaust everything in 2 hours. There was opportunity to serve more and earn more. So she starts by increasing her raw material stock, brings more raw material, but she is getting busier day by day, and not able to handle customers. 

> <u>One person show</u> has it's advantages. But there are disadvantages as well. Mostly around scaling up the operations. Eventually serving more customers gets little challenging, and that's a good problem to have.

Few problems start come up, First, he spent a lot of time in providing change. So he found an elegant solution, keep very rounded to currency notes prices. Like instead of charging 8 or 12 - he started charging 10 or 15, that kind of made the frequented currency notes available, and returning change was easy as well. Friction solved! And he gained some speed there... From there popularity increased and sold much more food. Given the popularity, Opexill had to find a way to make dishes faster, and then he went on to implementing more ways to speed up the 'customer experience' and want them to serve them faster.

 When your food stall becomes popular!

* Make all the items's availability available to customer in advance, tell them if something is not available, started putting a small menu with only available things, so people don't have to ask what's available and what' not.
* Start prep for some main ingredients, like chopping veggies, pre-cook some portions, and prepare all the condiments before hand - when she started, she was doing everything on the spot - in software world we call it "runtime", but she started doing something close to "compile-time".
* Look for more contact less ways to accept payments, start accepting payments through online, QR codeb based systems.
* Note down order patterns and do more ahead of time food preparation.

But all these could not solve the problem in a holistic way, all these measures meant buying more time to ramp up operations. But She needed to do something more drastic. The customer service time was getting impacted, the popularity was increasing but having a customers' wait time increased to upto 90 minutes, long queue, caused frustration, she could not multitask sometime, some time cooking multiple dishes caused few dished to get served undercooked (bad response) or some of them needed to redo entire things, we kind of messed up (internal server error) or few times, she could not update the availability of certain food items, and after receiving the order she realiesed she does not have it anymore (resource not available) - oh man, while it was amazing to see the growth, the frustration started coming in. She was a solo warrior and working in monolith mode... And certainly wanted to make sure that she keep serving. Oh what needs to be done?

###### The responsibilities

It was very evident and clear that she can't keep up with everything, she needed help, what if she hired a help who can do exactly same thing as she does, and so that they can serve customers but one person needs to do only 1/2 the customers. That sounded like an idea which could work, she roped in her brother, who just graduated from college, and was looking to do something parttime. She realised that she needs extra capacity only during the rush hour, this worked out perfectly. Things changed, circumstances changed, life became little easier, and they could serve more customers, word of mouth did the magic. People were startled with sudden improvement in customer service. 

> Better performance such as time to serve, brings better customer experience, in turn brings more customers.

###### Sharing responsibilities and resources

So sharing all work loads helped. More customers means Opexill needed more 'servers' to serve. She roped in her cousins, friends, and they were doing amazing... but over time, it was clear that few tasks were getting some conflicts. Since there were not many cash registers, everyone accessing cash registers, made others wait to just give change out... or shared resources such as cooking pans, because two or more people waiting to perform the same task - but unless one can finish it others can't do anything - for example, if they needed to grill the burger, they were holding the patty and standing there while others were flipping the burgers. This wasn't good, suddenly, a solution which brought speed, was bringing slowdowns, and some bottlenecks in the system were pretty visible.

> Opexill thought about it. There has to be a solution, what if each one of just does one thing at a time? but does it to the perfection, repeatedly. 

That might work? doing one thing and one thing only, might be a good way, so we are locking on resources, because providing each one with a grill or pan was not only expensive, it took more space and it wasn't efficient, because then it will be like having many food stall with exact same setup. There are multiple issues with this

* We aren't utilising our resources very nicely - containers, pans, cooking grills etc
* In this process, each of these will be undertutilised when we we are doing some other tasks
* This also takes up a lot of space, that is not what we wanted.

Opexill wanted to increase the businesss by properly utilizing the resources and people, but the first solution, solved the problem of handling customers, but it kind of created internal bottlenecks when people started waiting for access of resources.

> They scaled by repeating the entire workflow while this wasn't sustainable, it served their customer well, but now, it was time to think through something better.

###### From builder to assemblers

What if we can define steps to cook all dishes, and everyone cooks part of it, She has seen it working fast-food pasta shops, or even at fast food chains. "That could work", She thought. "Why not give it a shot", she sat down, defined the process to cook various ingredients separately and at the end someone would assemble the dish with all pre-cooked ingredients, or provide more, if we run out of hands there, we will add more assemblers. May be, we can give it a try. May be it will work. May be...

So, now things went little differently. We separated tasks by responsibilities and not everyone was doing everything... things changed, people were performing "micro" tasks rather doing them in "macro or mono way"... The "micro" tasks seemed like way to go.

Next day, new change, everyone was super excited, we had one person for each of the tasks. 1 person to take order and money, one person to chop ingredients, one person for stir frying and one person to assemble the dish... things started moving with a flow. 


There were few hiccups, sometimes, the person took the order, and yelled it inside, unless someone has responded or acknowledged the order, he won't take another order, the reason was that cashier wanted to be in "sync" with kitchen, but sometime the reply came too late...  basically this went on for every other person as well... they needed to figure out that their order is taken and wanted to make sure that next step will be executed. But other person can not respond to them unless he finishes the previous tasks, it was kind of problematic, what if they can write the order details or next step, and since it's gonna move up in the service chain, they can assume that it will get fixed... eventually. 

> Asynchronus messaging and eventual consistency are foundations of distributed "micro" services. 

So, they created a paper based message passing system, write downt the order, and put it in the work tray in the kitchen, then someone would pick up the order and they will exactly know what needs to be done. And what role they are playing in that process. It became very important for them to define the how everyone will take part in building that order. So that they can kind of "Fire the order and forget about it, because they know by nature of process, it will _eventually_ happen"

> Orchestration plays a big role, when you have fan out (go build your part) and fan in (now assemble everything).

So now everyone had their role to play, from taking orders, to provide cooked/chopped ingredients and then assembling the order as well. If you look very closely, this is how micro services architecture works, but evolution is very important.

> Every architecture can evolve into a micro services architecture, but only if there is a need. And the only need can be about scaling the parts of services based on demand.

Sometime, you can keep a large bunch of functionality at one place, yet, fan out very small (micro) but highly utilised functionality.


###### The age of assemblers

While this post talks about fictional hawker and it's just a story. But on the other hand, as software developers, we should also think about us as Assemblers vs builders. Our job is to provide better consumer experience. It may not be necessary for us to build every part of software ourselves, but the more strategic point of view should be around providing the best experience to our end users. Thinking from that point of view will help us prioritise the feature delivery by either buying off the shelf or building from scratch. I think this requires another post, but I am sure that era of assemblers has arrived.

