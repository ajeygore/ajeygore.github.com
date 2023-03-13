---
layout: experiments
title: Fun with strategy generation
published: true
categories: tech
description: Pun on StratBros
lead_image: blog/software_perspective.png
---
<script src="/assets/scripts/wardley-strategy.js"></script>

<br/>


Recently Dan North notices Simon Wardley's Heroku hosted Strategy Generator went out of action. The strategy generator is a pun on many stratbros who come in
as strategic advisor and come up with something that seems very reasonable and extremely convincing.

So here is machine, helping you with that. Click on button below to get a strategy for your company, and if you don't like it, press the button again.
This button generators random convincingly appropriate strategy.

On top of that, I have wrote a prompt engineered strategy to be used with Chat GPT3, you can copy this prompt and use as input for ChatGPT and it will give you an eleaborate strategy.

PS: This was a 2 hours fun with JavaScript.


<hr/>
<button onclick="renderStrategy()"> Get a Strategy!</button>
<br/>

<br/>
<div id="strategy_text">Click a button above to get a strategy</div>
<br/>
<button id="copy_strategy_button" onclick="copyStrategyText()" style="display:none;">Copy Strategy</button>
<hr/>

<button onclick="getChatGPTPrompt()"> Get ChatGPT prompt </button>
<br/>
<br/>
<div id="chat_gpt_prompt">Click the button above to get a strategy</div>
<br/>
<button id="copy_gpt_button" onclick="copyGPTPromptText()" style="display:none;">Copy GPT Prompt</button>
<br/>
<hr/>

**Back story**

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">Oh noes! <a
        href="https://twitter.com/swardley?ref_src=twsrc%5Etfw">@swardley</a>&#39;s Strategy Generator has fallen off
    the internets!<a href="https://t.co/5LbIk0xwwt">https://t.co/5LbIk0xwwt</a></p>&mdash; Daniel Terhorst-North
    (@tastapod) <a href="https://twitter.com/tastapod/status/1598256647948103680?ref_src=twsrc%5Etfw">December 1,
        2022</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

I was intrigued, but it wasn't hosted on Heroku anymore, and I kind of wanted to play with it. So I decided to host it myself, and also add a few features.

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">Which blogpost? I might write it for you.</p>&mdash; Ajey Gore
    (@AjeyGore) <a href="https://twitter.com/AjeyGore/status/1598264857790656513?ref_src=twsrc%5Etfw">December 1,
        2022</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

Simon was kind enough to share the original blog post and then I got on with it.

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">Which blogpost? I might write it for you.
<blockquote class="twitter-tweet"><p lang="en" dir="ltr">Bill West has the code on github - <a
        href="https://t.co/N01IUIeg5l">https://t.co/N01IUIeg5l</a><br><br>The original blog post is ... <a
        href="https://t.co/R16yLoNyz4">https://t.co/R16yLoNyz4</a></p>&mdash; Simon Wardley (@swardley) <a
        href="https://twitter.com/swardley/status/1598267705970364418?ref_src=twsrc%5Etfw">December 1, 2022</a>
</blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

Now, here it is, hosted on my blog. And fantastic thing about it that all this code including most of the text is
written by github-copilot.

Have Fun!

<br/>

<hr/>

<script>
    function renderHTML() {
        let strategy = wardleyStrategyGenerator();
        // get all words

        let nouns = wardleyNouns();
        let pluralNouns = wardleyPluralNouns();
        let adjectives = wardleyAdjectives();
        let allWords = nouns.concat(pluralNouns, adjectives);
        // if strategy contains words from allwords then highlight them in bold

        for (var i = 0; i < allWords.length; i++) {
            strategy = strategy.replace(allWords[i], "<b>" + allWords[i] + "</b>");
        }
        return strategy;
    }

    function renderStrategy() {
        document.getElementById("strategy_text").innerHTML = renderHTML();

        document.getElementById("copy_strategy_button").style.display = "block";

    }

    function getChatGPTPrompt() {
        document.getElementById("chat_gpt_prompt").innerHTML = "Make a more convincing strategy by adding a few words with statistics and growth projections for my business to the prompt below. <br/>" + renderHTML();

        //add copy button so that text can be copied
        document.getElementById("copy_gpt_button").style.display = "block";

    }

    function copyGPTPromptText() {
        var text = document.getElementById("chat_gpt_prompt").innerText;
        navigator.clipboard.writeText(text);
    }

    function copyStrategyText() {
        var text = document.getElementById("strategy_text").innerText;
        navigator.clipboard.writeText(text);
    }

</script>
