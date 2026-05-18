---
layout: post
title: Enterprise Infrastructure Series Part 3 - Configuration Automation
published: true
categories:
- Automation
- chef
- Configuration Management
---

In the last two posts I went about how to get basic virutalization and  why configuration management is necessary. In this part I will explain  about setting up a Chef server and how to setup basic provisioning, In part 4 I will explain on how can we go about automated provisioning using OpenVZ and monitoring those instances.



**Let's put the requirements upfront --**



1. We should be able to create containers using any virtualization provider, in this case OpenVZ.
2. We should be able to manage configurations for each servers - name  resolution, package update mirror server, time zones and ssh key  infrastructure information
3. We should be able to have centralized logging, monitoring and  accounting for various projects - in TW we have dozens of projects and  we wanted to have accurate accounting for these projects - such as how  many VMs have been used by a project, how much computing power has been  utilized and how much disk space has been used.
4. We should be able to reliably recreate any infrastructure server using this automation.



This  is a typical chicken and egg problem -- if we do not have any  configuration management tool, how do we configure the first hardware  server? And if we do not have any containers, then how do we setup the  first server? So the answer lies in one basic principle -- configure  anything manually first and then we should not require to do it manually  next time, we should automate it for next time - we kept this principle in mind.


So in short what I did was to setup a hardware node and then create OpenVZ containers for setting up first Chef server.

I downloaded CentOS 6 OpenVZ template from here [http://download.openvz.org/template/precreated/](http://download.openvz.org/template/precreated/) and first thing was to install the Chef server, our aim was to create a  self scaling private cloud based on OpenVZ - where we can add more  hardware on demand, which provides HA and load balancing.
 Since configuration management allows us to define configuration as  source code, we should be able to redeploy that source code on any  server thus recreating that server reliably when ever we have lost it or  due to mis-configuration we have malfunction.



My team settled on following tool set --



1. Ruby for scripting everything
2. Chef from OpsCode for configuration management
3. MCollective for infrastructure orchestration
4. Nagios for monitoring
5. GrayLog2 for centralized logging
6. Bind as name server
7. CentOS as default Linux flavor


So for configuration automation - we started with following list.

1. OpenVZ server **[(covered in Part 1)](http://(covered in Part 1))** and later provision containers using Chef Server.
2. Chef server - and then make it chef client so that we can re-setup in future.
3. Bind, where we can add and remove entries and add CNAMEs as well.
4. Nagios server, when ever a node* is created using Chef, it automagically gets picked up by Nagios for monitoring.
5. GrayLog2 - for logging and analysis.
6. A reporting tool for infrastructure reports regarding utilization and accounting for this infrastructure.


**Getting started with Chef server setup in 3 easy steps**.

Please read **[this](http://ajeygore.in/part-2-automating-infrastructure)** post for chef basics. FrameOS have been doing awesome job in Linux + Ruby ecosystem, they have stable and latest ruby packages, we will be using FrameOS RBEL repo for setting up our chef server, although FrameOS blog mentions how to install chef easily, I will be kind of re-iterating same thing here but I will cover how do we continue setting up client, knife UI on your machine and verify chef client run. While you can use OpsCode client recipes - we will most probably will not use them because they are influenced hugely with Ubuntu Linux. Since we will be using RHEL/CentOS combo where ever possible - so we will end up modifying those scripts, so lets start with basic scripts on our own.



**1. Setup**



To Setup chef on your CentOS 6 box - you can refer to **[this](http://blog.frameos.org/2011/05/19/installing-chef-server-0-10-in-rhel-6-scientificlinux-6/)** post or use following shell script (trust me this is one of the few place we will be using shell script, mostly we will be using ruby to do our scripting as well, but since our bare bone container may or may not have ruby, we should use shell script to setup chef and then use ruby everywhere else), become root and execute these 4 statements



```
rpm -Uvh http://rbel.frameos.org/rbel6
yum install rubygem-chef-server
service iptables stop
setup-chef-server.sh
```





Once you are done with this setup, we are ready to hit chef server! so lets get going and setup our first chef client and a repo. Chef needs recipes which form a cookbook and in ideal scenario one of many cookbooks form a role which gets applied to a node*. **Now login to [http://your-chef-server:4040](http://your-chef-server:4040) user: admin password: chef321go**



**2. Admin Client**



After loggin in as Admin, you will have to change default admin password - keep a note of it, after this, create user name for yourself. And create a client for yourself as well.



User name is required if you want to operate web-ui and client is required for knife to be able to help you manage roles, cookbooks, recipe and nodes on chef.



**3. Repository Setup**



Unlike puppet, Chef does not need a repository, what you do is to create repository for yourself and then upload cookbooks/recipes/nodes/roles from the repository to chef server. For basic stuff, you should have something like this





```
.. (up a dir)
/Users/ajeygore/Documents/workspace/chef/
|+checksums/
|+cookbooks/
|+data_bags/
|+databags/
|+environments/
|+nodes/
|+roles/
`-scripts/
```





once you have setup repository, you might want to check it in Git or something similar. After this you will create a .chef directrory inside chef repo. Install chef client on your machine, and run knife configure. Once you have setup knife - enter **knife node list** as command and you should see empty node list.



That concludes our setup for Chef Client, In next post, I will conclude how can we start automating monitoring and basic setups with Chef, including provisioning. I hope by now you understand how chef works and how recipes work, its time to write a simple recipe which changes MOTD on linux machine to the motd of your choice.



*A node is a machine - whether its virtual, containers or physical box
