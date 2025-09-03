---
layout: post
title: Tuning performance with Java - on Linux systems
published: true
categories: []
lead_image: blog/java-performance-tuning.svg
---

I love java, rather jvm - well, as technology and have been making use of it. Java world is full of rock solid implementations about technologies and have a huge software library eco system to deliver things with rock solid performance. It also makes a very good candidate for dependable technology. Recently, we choose java at backend for everything we do in ruby :-) So everything ruby becomes everything java at the backend. There are many advantages of this approach - a nice language to work with (ruby) and nice dependable technology at production environment (jvm) - in short, we use jruby with torquebox. But there are caveats and as its true with every tool - "if you didn't use it right, it won't give you right results"


When check-in rush happened last week at hoppr - it melted our servers to levels of not able to breath within given time frame. Our code looked right, we were doing everything right and making sure that our code is well optimized for what ever we can - although we had to make some changes to our code the way we look up db entries and other information, but that did not help at all for making service perform to the levels we wanted. We did not have enough time to react because service would go down pretty frequently – we started investigating to figure out what’s causing it.

##The first culprit - memory

At prima facie it looked like we were running out of memory, well its true and it was true – and the easiest way to deal with it to add more ram. Unfortunately we did not have that option, we had to make service work within limited memory and make sure that it does not go out of memory.

“Out of memory” error occurs for several reasons –

We increased limits for user processes and open file – since everything is file in linux including sockets and tends towards memory allocation, but that did not solve the problems we had 1000s of open sockets and still it would cause it to get out of memory.

##The second cultprit - network protocol

Next tuning was around fixing networking parameters – like decrease FIN_WAIT, TIME_WAIT parameters to 5 seconds, we then added options to recycle sockets, increased WMEM and RMEM parameters to use large data size to transporting data – so that with one socket connection we can send upto 640kb data – which resulted in less round trips

Using big pages was another tuning which we had to implement so that we can take advantage of java using big memory pages instead of smaller ones and perform better.

##The third culprit - defaults in app container

When we were done with OS level settings, we turned towards torquebox and found many things which could be fixed – we increased thread pools, put threads execution times within 3 seconds (since we had to complete processing within 200ms) and thread wait to max 5 seconds.

##The fourth culprit - default jvms gc

Lastly we looked at JVM itself – if you do have multiple cores and huge memory – then set –Xms and –mXM to same value – so JVM does not have to struggle to allocate memory, since we knew that its going to consume that much, we should have done that earlier. GC also plays a huge part in it and we ran GC every 15 minutes instead of every hour, made it run parallel and allocated 25% CPU to it – that way we ensured that we collected what ever we littered in last 15 minutes – we do a lot of check-ins and most probably they did not need to dangle around for an hour.


In summary, The learning was fun – it required reading a lot of core-dumps, jmx monitoring and looking at threads very carefully, but solved our problems and hopefully we will be able to scale better.

The default settings are pretty relaxed in OS and JVM. But these settings won’t always work for everyone, the bigger learning was that adding more cpu and memory will not solve a problem. We know that our existing system still has limits – to how many check-ins we can handle per hour, but at least now we know that what works and when…
