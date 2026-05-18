---
layout: post
title: Enterprise Infrastructure Series Part 2 - Need for Configuration Management
published: true
categories:
- Automation
- chef
- Configuration Management
- infrastructure
---

I lead "Continuous Delivery" group aka DevOps group within ThoughtWorks. One of main principles we follow within our group is that we should automate almost everything possible. In last post we setup OpenVZ container virtualization - but system administrators should worry more about on how can they make sure that their environment configurations and machine setup is repeatable, easily backed up and restored, also provisioned on demand. Usually this is accomplished using scripts or also sometimes using more sophisticated tools like CFEngine.

Last few years, we have seen infrastructure being a commodity and you do not really have to setup a private scalable infrastructure unless you have huge requirement around security - but even when you setup this infrastructure on public cloud or manage your own cloud, you still need configuration management automation to deal with issues I mentioned earlier. So our next quest was, how can we leverage OpenVZ's virtualization technology and get pre-configured containers on demand. With this we started configuring small parts of infrastructure to make sure that we can inject scripts in almost every piece of software, so to starting a machine should not be a problem.

We created a sub-zone in our infrastructure which will not be part of corporate active directory - there were few reasons behind doing so.

1. We did not want to take risk of messing corporate DNS system if something goes wrong.
2. Its always easy to manage a sub-domain with not much complex DNS system to make sure that debugging it in early days, restarting dns server or even restarting infrastructure machines does not impact everyone.
3. We added forward in corporate name servers to point subdomain to our domain and also configured our dns server to forward everything to main corporate DNS servers - this way we complied with corporate DNS policy.
4. We could add and remove dns entries using scripts.

Once we had DNS server setup, We moved ahead with creating Containers or VMs, but we wanted to make sure that all servers should have right DNS settings and they should change, if we change our DNS servers, that means we wanted to automate configuration for DNS settings on each of clients. And thats when an automated configuration management was required.

In ThoughtWorks we have been using puppet for a while, its pretty nice tool and system admin friendly, but we wanted something more - where we can use some centralized place to query about servers and their attributes, while you can do this with mcollective + puppet. We decided to use **Chef** for server side atttributes, configuration queries and a powerful CLI - **knife! And last thing was that everything was ruby!** There are numerous articles about puppet vs chef and this isn't! We made a choice 6 years back, it was puppet, and we made a choice in 2010, and it was chef! You can do almost everything I am describing here using puppet + mcollective!

**As soon as you want to ensure correct configuration for system, packages and services, you might want to look at some configuration management tool. We needed to manage 100s of nodes or servers or virtual machine, and we wanted to make it such a way, that we do not have to login to machine even for once! we will see in next parts hows that possible!**

So lets talk about Chef a little bit more, before we go ahead into details for next steps.

**Chef** works in client server mode, a Chef server contains information about client as defined by system administrators. In Chef terminology we call client - Node. A node has some part of play in infrastructure, either it computes or provides a service. My favorite example is a web server - suppose we need to configure a web server. A web server requires a package which provides web server service, in Linux most probably **apache httpd** has been defacto standard across Linux ecosystem - So when a client talks to Chef server, Chef server looks for node with client name and see what definitions it needs to tell client - it might look as simple as below example node definition

```
{
  "name": "vm100-081.sc01.twcorp.com",
  "chef_environment": "_default",
  "normal": {
    "tags": [
      "web_app01_production"

    ]
  },
  "run_list": [
    "role[web_app_server]",
    "role[dns_client]"
  ]
}
```

This node says that it runs httpd_s erver_role, dns_client role - and tagged as web_app01_production, this means that - some how client will figure out what needs to done when you apply a specific role. And if we query chef server asking it - "provide me list of all nodes which have web_app01_production as tag" and this node should be listed over here. If you notice the node name, its following some convention which tells us about node location and also ip address information - we will talk about that later, but lets talk about roles!

To install a package or to do some specific tasks, you create a recipe! If you need to do multiple tasks - you club them and call it cookbook! once you have multiple cookbooks, you can create a role and then you apply that role to a node! for example, a httpd server might have recipe to install http server, recipe for installing and configuring mysql and some proxy configuration, also it might configure your rails app as well! so thats what your web_app_server role needs!

```
name "web_app_server"
description "sets up web server for application"
run_list "recipe[apache_httpd]", "recipe[ruby_1_9_2]", "recipe[mysql_server]"
default_attributes({'mysql' => {'users' => { "'web_app'@'localhost'" => '' }, 'databases' => ["web_app_prod", "web_app_configurations"]}})
```

As you can see, it tells some how to run those recipes (cookbooks) on this specific node. So now if you want to create N+ servers for your web app, you can create those many instances in OpenVZ (takes less than 5 minutes) and just apply web_app_server_role, and if you have a proxy configuration, you can ask chef client to query server for web_app_server role nodes and generate proxy configuration.

This was just a concept, for more information please read [http://wiki.opscode.com/display/chef/Chef+Basics](http://wiki.opscode.com/display/chef/Chef+Basics) I will be explaining about setting up chef server and a simple client in next post in simple steps
