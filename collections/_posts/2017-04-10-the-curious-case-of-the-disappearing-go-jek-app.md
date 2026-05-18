---
layout: post
title: "The Curious Case of the Disappearing GO-JEK App"
date: 2017-04-10
published: true
categories: ["Gojek", "Reflection"]
description: "On April Fools day our app disappeared from the Apple Store. While this sounds like a prank, it was anything but."
---

![Image](https://cdn-images-1.medium.com/max/600/1*gjPIP4NZLGBf7LfRWKxFrA.png)
*GO-POINTS, GO-JEK’s loyalty program*

On April Fools day our app disappeared from the Apple Store. While this sounds like a prank, it was anything but.

The day before, we discovered we were dealing with a hard-to-reproduce bug on our iOS app that had shipped with our most recent release on March 30th. By the morning of the 31st, our alerts notified us that we were logging out customers more frequently than expected and that login attempts were also on the rise.

From a security standpoint, our team has created a series of automated filters and alerts that deal with simple fake signups and password checkers, and scale up to handling some pretty sophisticated attacks on a daily basis. We constantly filter out fake traffic at multiple levels of the system in a manner that’s transparent to legitimate customers using our products.

It was this security system which was kicking in and logging users out because the bug was causing their activity to look ‘suspicious’.

**What Changed?**

At our scale, across our sixteen products, we track billions of app activity events daily in order to help us troubleshoot issues and improve our customer’s experience. The bug affected one of these events which then ran afoul of our automated security, resulting in that user being logged out.

The intersection of events that triggered the bug could happen several times a day for a typical customer.

**The Dilemma**

The release in question carried several crucial security features to protect our customers that had taken substantial development effort, ones we were unwilling to roll back except as a last resort. But this release *also* resulted in a non-trivial percentage of our iOS based customers being logged out repeatedly.

So, we decided to unlist the app, and push hard over the weekend and fix the underlying issue.

**Why did we unlist our app**

We could have continued listing our app while we were fixing issues, but that would have made so many more iOS users uncomfortable over the weekend, making it harder for them to get a ride or their favorite food or a cleaner. We always put our customers’ interests first and it is one of the principles that makes us what we are.

So our app was gone for 16 hours, and we had to face a lot of flak, but in the end, it was all good. We were back in action after 16 hours with a more robust app that protected our user’s security without compromising the experience.
