---
layout: post
title: "Security — Vulnerabilities lifecycle at GoJek"
date: 2017-03-31
published: true
categories: ["Gojek", "Security"]
description: "Recently, Our friends over at Fallible published a set of vulnerabilities…"
---

Recently, Our friends over at Fallible published a set of [vulnerabilities](https://hackernoon.com/security-vulnerabilities-in-go-jek-a9126b33788c) [https://hackernoon.com/security-vulnerabilities-in-go-jek-a9126b33788c] that they had discovered a while ago, **more than a year**, While these are old vulnerabilities does not negate the importance of the discovery or disclosure. We; at GO-JEK take security very seriously and value transparency. At the time that they reported the issues, we were already aware of them and were taking active steps to correct them. But since sometimes perception outlives the reality.

Here is the status for the reported vulnerabilities:

**Vulnerability #1 Ride History Data Leak**

This vulnerability has been fixed. The authorization header is checked which means that you must be a valid, active user of GO-JEK and have logged in with the correct credentials. An attacker will have to first guess the unique user id number and only if he gets the correct number will he be able to view the data.

**Vulnerability # 2 Order details Leak**

This vulnerability has been fixed. Again, this was an incident where the Authorization header was not checked. The Fallible post does not carry any additional information save for a screenshot. The vulnerability does not mention the location of the vulnerability. This was a vulnerability that was isolated to the GO-BOX service. It allowed an attacker to view the order details for GO-BOX orders that has been completed.

**Vulnerability # 3 Users Data Leak**

This vulnerability has been fixed. One more case where the Authorization header isn’t checked. The post does not mention that an attacker must guess the Order number before he was able to call this API. Only on guessing the right order number does the attacker gain access to the specific order information.

**Unconfirmed # 4 Get other user’s Android notifications for GO-JEK**

We do not have further information on this vulnerability from Fallible. We are aware that Android and iOS push notifications are not meant for delivering sensitive information to users and therefore do not place either personally identifiable information nor do we send any sensitive data over Push Notifications.

**Unreported Write APIs**

Fallible also reports that there are some APIs that they can use to corrupt user data. The mention of the cancellation reason manipulation was again a known bug that has been fixed.

Since the bugs were reported we have corrected the vulnerabilities and have increased measures to review and strengthen our security. Some of the steps we have taken are:

1. GO-JEK has a strong in-house red-team that conducts active penetration tests of our infrastructure and application on a daily basis. As our platform continues to grow and evolve, we rely a lot on automation of scans and regular checks on critical areas of information leakage and authentication.
2. GO-JEK has engaged with two well-known and reputable security consulting companies to conduct in-depth penetration testing projects with us. This is an ongoing exercise at GO-JEK involving more industry leading security consulting companies.
3. GO-JEK has a private bug bounty program that is run by BugCrowd [[https://bugcrowd.com/](https://bugcrowd.com/)]. This program invites security researchers from all over the globe to participate in a controlled security assessment exercise where they will be rewarded with cash for reporting weaknesses in our security.

The above steps have proven very effective in discovering and solving security issues quickly. Our commitment to solving security related issues is embodied in our entire technology leadership team and engineers.

We would like to point out that the best way **to** **engage with us is to join our bug bounty program**. Since it is a private program, **please email us at** [**bugcrowd@go-jek.com**](mailto:bugcrowd@go-jek.com)

If you have no interest in participating in our bug bounty program but would like **to report vulnerabilities** then please **email us at** [**security-bugs@go-jek.com**](mailto:security@go-jek.com)**.**

We welcome an opportunity to work with security researchers that practice responsible disclosure. Work with us in a responsible manner in disclosing bugs and we will be happy to acknowledge you and reward you for your findings. Disclosing bugs in systems is a very serious exercise, it is imperative that you conduct yourself in a manner that first do no harm to the greater group of end-users. Also, disclosures should always be specific. Unconfirmed, un-researched, or vague disclosures do not serve any purpose other than to cause panic or uncertainty. We will always be transparent at GO-JEK in dealing with and acknowledging disclosed vulnerabilities.

For more information or comments please do not hesitate to reach out to us, our CISO [Sheran Gunasekara](https://www.linkedin.com/in/sheran/)
