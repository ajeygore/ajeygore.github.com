---
layout: post
title: "How VPN automation ended up becoming a Single Sign On Server — Part 2"
date: 2017-02-01
published: true
categories: ["Engineering"]
description: "In part 1 of this blog, we covered the process of how we used an OpenVPN server to authenticate with our rest based Gate service by hitting…"
---

In part 1 of this blog, we covered the process of how we used an OpenVPN server to authenticate with our rest based Gate service by hitting a URL with username and MFA token. But in order to address the issue of users accessing our portals, we needed to turn to CAS to find a solution. We will cover the approach that we used, in this blog.

### Integrating CAS with rest based MFA system

At this time, the JaSig CAS community was implementing MFA support, but it wasn’t what we wanted. We wanted a simpler and more usable solution, and they were not looking to support Google MFA. What we needed was a custom authentication handler which can take user name and token, talk to our service over http and authenticate.

We took a dirty shortcut and implemented a custom authentication handler. This would take the Gate server’s address from an environment variable and try to hit the URL with user name and password. After experimenting with this for a day, we ended up writing the [first module for our rest based server](https://github.com/gate-sso/cas_gate). A single file, and our job was done.

Now the portals that had the concept of users, could integrate with it using a simple SAML implementation. For portals that didn’t, we turned to Apache CAS integrations. The Apache HTTP server protected the portals and asked users to authenticate using “Gate”.

But we still had one issue: Login to our servers. There are many solutions to this. A typical configuration management system allows you to grant access to specific users to specific servers. Or you can use LDAP to centralize this. Our first hunch was to just go and implement an LDAP server — and then use *pam_ldap* and *nss_ldap* with *mkhomedir.so*. But while implementing LDAP, we realised that we needed to sync those users, and while we could allow them to upload their ssh public key to ldap and then centralize auth, it was still a cumbersome process.

A second approach came up. We thought, “Why not sync all Gate’s active users to LDAP, have a UI to upload public key to gate and sync that with LDAP?”. The idea worked and we could do that pretty easily; but LDAP was still in between, and if the sync did not happen immediately, the user would be left out of the Linux system. To work around this, we wrote a ‘hook’ : whenever there was change in the public key, it would go and write to LDAP. However, this was still a roundabout way and not very clean. While it did not make any difference to user, we had one more systems to take care of, behind the scenes.

That is when we had the brainwave of writing a PAM module and NSS module to authenticate and lookup users in the Linux system. With a little bit of research, we found out that newer versions of SSH provide AuthorizedKeysCommand and AuthorizedKeysUser combinations to hookup any script, which can provide a public key for a user name given as argument to AuthorizedKeysCommand.

So, if we could provide all Gate’s users to the Linux systems and then provide their public keys based on user names, then we could remove LDAP in the middle.

A quick google search revealed that people had already done some experiments around this, but they were not very generic. Moreover, their code did reference implementation. We got excited about the possibility of writing **nss** and **pam** modules with SSH Integration — those can lookup the user, group and shadow information from a web server, authenticate user with web server and lookup the public key as well.

Now the problem statement became very clear.

> **Provide a system which allows any Linux server to lookup a user into NSS, authenticate using PAM and create home directory with pam_mkhomedir.so and then possibly lookup the user’s public key.**

And three days down, we solved the first problem — a system which allows Linux servers to lookup user using *nss_switch*. Our [https://github.com/gate-sso/nss_gate](https://giuthub.com/gate-sso/nss_gate) module provided exactly that, and then combined with [https://github.com/gate-sso/pam_gate](https://github.com/gate-sso/pam_gate) module, we could authenticate a user and then if password authentication was to be bypassed then *sshd_config* will use AuthorizedKeysCommand to lookup the key at Gate server and let the user log in.

This allows a user to login to any system, as long as they have access to Gate. This wasn’t ideal; we wanted to make sure that Gate’s users are not given access to any arbitrary system but only to system that they were supposed to login to. This could be controlled at two places:

1. PAM module should not authenticate if user is not authorized to login to the box
2. AuthorizedKeysCommand should not return appropriate key if user is not authorized to login to the box.

### So how do you restrict a user login to a server?

Pattern matching for IP address and host name was the way to go forward, given that we record user specific host names per user. Since some servers can be behind a single firewall, we supplied the IP address from PAM and AuthorizedKeysCommand — and then we could check that against our patterns file.

For example, if all the staging boxes are named as s-* then adding a host pattern of *s-** will allow users to specific hosts whose name is s-*. Or, you can match IP address as well. Given this, now we could control users in following way:

1. Check if user is active, else fail authentication across board
2. Check if user has pattern matching with host name then allow access
3. Check if user has pattern matching with IP Address then allow access

Now given this, we could make sure that users access only authorized systems and have a central place to manage access. We could also just disable users on Gate’s UI, to ensure that they wouldn’t be able to have access to our VPN service, internal portals, SaaS services which allow SAML login (jira, confluence etc) and Linux boxes!

And that’s how Gate-SSO — A rest based SSO server coupled with CAS and MFA is now key to any access within Go-Jek.

For more information on Gate, please checkout [https://gate-sso.github.io](https://gate-sso.github.io/) or [https://github.com/gate-sso](https://github.com/gate-sso) for all module details. If you want to add features to gate, please create a fork and send us the pull request!

The good news is that this implementation saved around 40 hours of user management effort every week at Go-Jek and we implemented everything in 6 days.

### The Build Vs Buy debate

On hindsight, we debated a lot about the need to build something like this, as opposed to purchasing an off the shelf system, as there are many out there.

But we learnt that sometimes, if you start building things that complement each other, on top of these simple implementations — you are likely to end up with something pretty significant.

There is always an argument around build vs buy, in today’s SaaS heavy world. In most cases, it is better value to buy rather than build; but sometimes we take this argument to the extreme and end up paying for pretty small things. As a result, our developers start forgetting how the basic building blocks for the internet work. Again, the argument is that in the connected world you just purchase small services and put them together to work for you. And this is perfectly fine given the multiple choices we have today. But there is a need to balance learning vs leaning on something else, build vs buy another service or host it yourself vs cloud based solution. Given the complexity and scale we deal with at Go-Jek, I think it’s very important to have that balance a bit skewed towards build.Having said that, it’s important to build it right, and always coupled with strategic thinking.

Once we start implementing this thought process, we end up creating a balanced software ecosystem with smart choices around it — those choices end up creating a better trusted and stable deployment ecosystem for you and your team.

So, the next time, when someone says, let’s just use SNS, say to them: “Why don’t you ‘assemble’ an SMTP service with SPF records and TLS?” and see if they give it a shot. You might not end up using it, but at least they will know how it works!

### About Author

![Image](https://cdn-images-1.medium.com/max/600/1*sRq6kxVuhym8Mh9JCNPxqA.png)
*Ajey Gore (Go-Jek CTO)*

With 17 years of experience in building core technology strategy across diverse domains, Ajey has helped several businesses through technology transformations @ Thoughtworks and CodeIgnition.
Ajey is the founder of Codeingnition and an active influencer in the technology community.
