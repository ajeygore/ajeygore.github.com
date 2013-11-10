---
layout: page
title: Code, Deploy, Automate
tagline: 
---
{% include JB/setup %}

Read [The utter stupid experience we had at The Lalit, Goa](http://ajeygore.in/rubyconf/the-lalit-goof-up.html)


## Why new blog? 

Well, posterous decided to move on with twitter, and then twitter decided to shutdown posterous. Thanks to both of them, now I learnt few new things and have better place for my blog as well.
Old links should hopefully work using github pages and jekyll aliases
    
## My Posts



<ul class="posts">
  {% for post in site.posts %}
    <li><span>{{ post.date | date_to_string }}</span> &raquo; <a href="{{ BASE_PATH }}{{ post.url }}">{{ post.title }}</a></li>
  {% endfor %}
</ul>

## To-Do
Since now, I don't host top level domain name as blog, now its more likely to eveolve into a better site, still experimenting :-)

