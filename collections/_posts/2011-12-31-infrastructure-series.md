---
layout: post
title: Enterprise Infrastructure Series
categories:
- Automation
- Configuration Management
- infrastructure
- Virtualization
---
I have been working on setting up internal cloud with my team, we have been using many technologies to build all these things together.

I will be publishing 4 part series on how did we put it all together, We will showcase that how easy few things are and how new age enterrprises can take advantage of new age tools like OpenVZ, LXC, Chef and other related tools.

We started our journey will hypervisors such as VMWare, Xen and KVM - there is enough documentation available for these and our experience with this was pretty traditional, since our infrastructure mainly runs on Linux with RoR applications - we really did not need full virtualization, but instead we needed something which is near native performance - we went through the journey of choices and finally decided that containers were the right platform choice.

After our container choices were done - we choose to experiment with two popular container based isolation providers - OpenVZ and LXC containers. Any infrastructure combination not only requires a virtualization but also requires a configuration management tools. At ThoughtWorks we have been using Puppet for almost 6 years now. Since most of my team members were rubyist, we decided to go towards complete ruby based environment and our obvvious choice was Chef.

In part 3 I will be showcasing how do we configure everything and part 4 will cover completing all aspects of infrastrucutre.

Lets get started with [Part 1 - Bootstrap OpenVZ](/thoughts/part-1-bootstrap-openvz)
