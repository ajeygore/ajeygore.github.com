---
layout: post
title: mongo or not to mongo
published: true
categories: []
---
Literally means - to ask or not :-) But over here my context is bit different.

After taking a brief break from ThoughtWorks, I joined hoppr, a different kind of mobile startup with focus on location based services.&nbsp;

Hoppr is checkin based service but on SMS and USSD - we display interactive ivr like menu for USSD and provide with options on SMS based on user's location - and users can checkin. I joined hoppr when it was already deployed on six telco operators in India. It was just amazing that how this new cocept was picking up at different places in India and how people with mobile handsets are behaving on USSD as smart phone application.

We get a lot of checkins everyday - and since telcos were introduced gradually, every one of it was different database and different jsp files - if you live in telco world, you will know how APIs work and how java is national language at telco eco system. Anyway, I decided that we need a big re-write to bring all telco interfaces at one place and also bring a unified experience from end user perspective and from administration point of view as well.

We embarked on big rewrite with JRuby, Rails, Torquebox, JMS, Sinatra, Java, HornetQ and most important decision was to go with MongoDB. And we have been in for surprises and as well as some shocks. Here are few of them...
- MongoDB is hated all over place - and sometimes its praised, but similar services to us like FourSquare use it &nbsp;big time
- We ran out of option for clustering because Telco's data center allowed on one box and that was kind of disaster, but we are finding out options in terms of containers and thin services (do what ever is required for basic checkin and rest all goes as delayed job, few seconds, using JMS)
- MongoDB not only increased development cycle, but speed for queries is just amazing when, we did not have to write migrations for our rails application, that would have been night mare - like we have millions of user checkin records and if we have to add a column - then most probably we would have to take downtime.
- Our schema changes were very rapid and it works better as continuous delivery, our tasks or document structure was growing as features&nbsp;
- We used embedded documents at first, but later realized that we don't have to do something like that because it was not very great for reporting.
- Since MongoDB is not a relational database, we had tought time for reporting, it runs as as rake tasks and produces reports using models and its slow... but we know that for big data we have to eventually move to ETL and we will use some opensource tool.

In all MongoDB has been good for us with a lot of learning, few things like locking whole database for every write has been a pain - but we have been using delayed job coupled with lot of caching using redis - more on that in next blog&nbsp;

There are mongo haters - and if you are one of them, I would like to say that MongoDB is not an RDBMS, so you should not treat it like one and then get frustrated - use it for right things, mongo queries one in 4+ million records within milliseconds and that has been charm.As far as technology goes, we have mixed technology and have started using percona db for a lot of stuff, so that has been great as well. lets see where do we go from here...&nbsp;

So far, for us it has been Mongo and never been like "WTF why did we choose Mongo" but we have not been shying to say where it did not work for us, but after ETL hopefully we will never go down that path.
