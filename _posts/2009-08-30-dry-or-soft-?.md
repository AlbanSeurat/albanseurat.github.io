---
layout: post
section-type: post
title: dry or soft ?
category: design
tags: [ 'software' ]
---
The dry principle, <a href='http://en.wikipedia.org/wiki/Don%27t_repeat_yourself'>Don’t Repeat yourself</a> is the second principles in my series of architecture principle I will write on.

Every piece of knowledge must have a single, unambiguous, authoritative representation within a system.

I’m often talking about “meaning”, every piece of software should have only one meaning, other says responsibility. Therefore, if we have applying correctly this pattern, every times we have to made a change into our software, we don’t have to re-factor the whole stack. Exception of the cross-cutting concern (i18n, security, logging, …), modifying a module should not impact another module.

I’m not fan of code generator (someday i will write an article on that :)), but for the sake of this principle, I think i would prefer having some code generation than having to copy/paste code. As long as the code generated is NEVER modified, it’s fine.

A simple example I have used lately, I’ve made some test on GWT (Google Web Kit) to see if it’s mature enough to be used in my company.

When in GWT, you want to publish a “service” to your GUI you have to use 2 interfaces:

{% highlight java %}
public interface EchoService extends RemoteService {
  public String echoString(String stringToEcho);
}
{% endhighlight %}

and

{% highlight java %}
public interface EchoServiceAsync {
  void echoString(String stringToEcho, AsyncCallback async);
}
{% endhighlight %}

You write the first piece of code, which will be a simple RPC service usable within GWT, and the framework could generate for you (to allow async call) the second interface. It’s preventing you to have to write yourself this piece of code. It seems really minor but the principle is really well understandable with this simple case.

Talking of copy/paste, another part related with the DRY principle is to apply the OnceAndOnlyOnce pattern. Sometimes, I’m saying to myself, I should create a driver which deactivate copy/paste on developper computer :).

Copy/Paste; there are two major issue by using the copy/paste “approach”, first you likely hand up having more bugs in your software.  I’m pretty sure, that if Gartner :) made some analysis on the bug causes in the software industry, copy/paste will certainty be in the top 3.
Have you already try to make a software evolve when most of the code is a crappy copy/paste with just few changes between copy. Believe me, you will, one day, and this day, your week (and maybe more) will be boring :). You end up having to re-factor all the code with the certain probability to introduce a bug. We have to factorize upfront!

DRY doesn’t mean “being lazy”, although lazy could be a pattern it’s not the subject here :). We should don’t hesitate to always refactore our code, every times we add some portion of code even it’s not ours.

Steve Balmer like to put word in your head just with just a little insistence :), I would apply its pattern : “Factorize, Factorize, Factorize!!!” your code