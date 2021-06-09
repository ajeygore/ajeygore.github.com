---
layout: post
title: A tale of food stall, a monolith story!
published: false
categories: ['lessons', 'essay', architecture']
---


Few cult food outlets start their humble beginnings as hawker. A hawker stall is typically a one person shop. The person knows one thing and one thing better, cooks a truly tasty dish and that brings people to his stall all the time. Over the period of time, his popularity grows. Opexill starts increasing his stock, brings more raw material, but he is kind of getting busy, and not able to handle customers. Few problems start come up, First, he spent a lot of time in providing change. So he found an elegant solution, keep very rounded to currency notes prices. Like instead of charging 8 or 12 - he started charging 10 or 15, that kind of made the frequented currency notes available, and returning change was easy as well. Friction solved! And he gained some speed there... From there popularity increased and sold much more food. Given the popularity, Opexill had to find a way to make dishes faster, and then he went on to implementing more ways to speed up the 'customer experience' and want them to serve them faster...

###### When your food stall becomes popular!

* Make all the items's availability available to customer in advance, tell them if something is not available, started putting a small menu with only available things, so people don't have to ask what's available and what' not.
* Start prep for some main ingredients, like chopping veggies, pre-cook some portions, and prepare all the condiments before hand - when she started, she was doing everything on the spot - in software world we call it "runtime", but she started doing something close to "compile-time".
* Look for more contact less ways to accept payments, start accepting payments through online, QR codeb based systems.
* Note down order patterns and do more ahead of time food preparation.

But all these could not solve the problem in a holistic way, all these measures meant buying more time to ramp up operations. But She needed to do something more drastic. The customer service time was getting impacted, the popularity was increasing but having a customers' wait time increased to upto 90 minutes, long queue, caused frustration, she could not multitask sometime, some time cooking multiple dishes caused few dished to get served undercooked (bad response) or some of them needed to redo entire things, we kind of messed up (internal server error) or few times, she could not update the availability of certain food items, and after receiving the order she realiesed she does not have it anymore (resource not available) - oh man, while it was amazing to see the growth, the frustration started coming in. She was a solo warrior and working in monolith mode... And certainly wanted to make sure that she keep serving. Oh what needs to be done?

###### The responsibilities

It was very evident and clear that she can't keep up with everything, she needed help, what if she hired a help who can do exactly same thing as she does, and so that they can serve customers but one person needs to do only 1/2 the customers. That sounded like an idea which could work, she roped in her brother, who just graduated from college, and was looking to do something parttime. She realised that she needs extra capacity only during the rush hour, this worked out perfectly. Things changed, circumstances changed, life became little easier, and they could serve more customers, word of mouth did the magic. People were startled with sudden improvement in customer service. 

> Better performance, time to serve, brings better customer experience
