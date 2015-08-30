---
layout: post
section-type: post
title: Why performance doesn’t matter!
category: design
tags: [ 'software' ]
---
Actually it does matter. It is just not always the right moment to optimize your code. There are several patterns applied properly at the start of most project helping you worrying about performance at a later stage. Obviously this won’t help if you need to do highly CPU demanding processing (neuronal network, nuclear bomb simulation, …).

*First*, the most  important design pattern to apply for performance and scalability is to being stateless. Keeping state in memory from the start of the project is premature optimization, it will prevent further development because you will have to leave with this small tiny stuff which does fast but not flexible for change. I’ve been working in different scenario and not being stateless has ALWAYS been a massive issue which require a lot of re-factoring for … nothing (in term of features). Never, whatsoever, do a state-full component, never. Take parameter, Compute, save in a persistence layer. That’s all! Ok, it’s a little provocative.

If you have done your design right, it will be very easy afterward to proxy your code and cache it only when it’s necessary, doing this in a second development phase allow to add/remove at will (even more when using <a href="http://en.wikipedia.org/wiki/Dependency_injection">Dependency Injection</a> pattern) your cache.

You will also have simpler unit test in place since you will not have to test when you keep state in memory, so it will be easier to re-factorize afterward.

*Second*, design/develop against “contract”/interface, you should always specify APIs first. Relying on an interface allows you to change the implementation afterward if you need more performance and re-factorize a specific API. It doesn’t cost in term of performance (<a href="http://www.codersource.net/c/c-tutorials/c-virtual-function.aspx">virtual invocation</a> has minor impact in C++ and <a href="http://www.brics.dk/~mis/dOvs/jvmspec/ref--35.html">mandatory</a> in JAVA anyway).

It permits also to “inject” a cache in the middle without changing the contract between the two parties for instance if you have a network I/O between them.

*Third*, always favoring API over DTOs/Values Object, DTOs over state-full component. Their is a very simple reason of doing that, it’s easier to proxy an API using its contract than optimizing a DTO/value object.

Obviously you won’t be able to do that all the times and you might need to transfer Object/Message or even having a state-full component (Session Management in a web farm for instance…), but the rules would be to always think API first, DTO only if necessary and state-full component ~~when you’ve got your manager asking for something very quick and dirty :)~~.

*Forth*, (it grows…), always prefer event based approach. To gives you some examples, if you do processing which imply I/O, actually, if you do computer programming, you will always encounter I/O.

Anyway, let’s say you want to create a very fast and powerful HTTP server (<a href="http://translate.google.com/translate?js=y&prev=_t&hl=fr&ie=UTF-8&layout=1&eotf=1&u=http%3A%2F%2Fwww.lesmotsontunsens.com%2Fseguela-rolex-rate-sa-vie-50-ans-video-3391&sl=fr&tl=en">something everyone should have made before 50 if he doesn’t want to fail in its life<a/> :)), you will then create a multi-threaded server which create a new thread for each new client. You will miserably fail. How a CPU can handle 10000 thread with 2Mo each (by default on most OS) of memory allocated to it.

Most (all) of the modern operating system allows you to listen to events (in different manner) coming from the operating system. It’s help a lot, by removing the cost of calling a system call which implies various cost i will not explain here, and having a thread waiting for something to happen, being awaken, etc.

To design a powerful HTTP server (lighttpd, Nynx, …), you will have few threads (one by CPU is enough if you just want to serve static pages) and you will just register to events coming from the Operating System. Less context switch, 1 thread by CPU, less system calls and no wait which imply on a multi-CPU platform a lot of drawback when we talk about data bus (in the motherboard).

This pattern has to be applied every time you have I/O which can be blocked or slow compare to your processing. SAX handling when you parse an XML document is an event approach, Observation pattern is an event approach, etc…

*Fifth*, which is quite straight-forward, follow <a href="http://www.amazon.com/Design-Patterns-Elements-Reusable-Object-Oriented/dp/0201633612">GoF design patterns</a>, and more generically the <a href="http://en.wikipedia.org/wiki/Separation_of_concerns">*separation of concerns*</a> principle. It’s not necessary to know 200 design patterns to cover 300 use-cases, just the GoF are fine enough to manage your needs and if you fill it’s not the right move, just look at <a href="http://en.wikipedia.org/wiki/Design_pattern_%28computer_science%29">this page</a> to figure out if you really need more.

Let me give you an example.

I’ve been involved during my career in a project where one of the goal was to render web page using some sort of configuration files which contains details of the page. The legacy code was a bunch of functions actually doing “printf” stuff. It was a mess, un-maintainable, slow and not really bug-free.

My first re-factoring action has been to model our page using the <a href="http://en.wikipedia.org/wiki/Composite_pattern">Composite pattern</a> representing an object tree of the page and using the <a href="http://en.wikipedia.org/wiki/Visitor_pattern">Visitor pattern</a> to make CSS, JS and HTML being rendered (CSSVisitor, JSVisitor, …). It make the page been rendered several times faster (HTML very clean, JS and CSS being cache by the browser) and even more flexible since we can render any kind of content from our model. Nice, simple, KISS.

To summarize, this “principles” are the *primary steps* for a performing and scalable application.

It will not prevent you to do profiling nor putting cache in place afterward, but it will help you do that efficiently without compromising the bunch of features your product owner, customer, whatever the name of your “features requester” is called have asked for.

Performance is ALWAYS a trade-off between I/O and memory, at the end, it will always end-up being a cache to prevent I/O to happens. You can re-invent multiple technique to improve performance, but even if you look at the CPU level, with its register and its cache, there is no secret, “caching” is the only viable option.

Now, it’s time to profile and optimize your algorithms :), think about putting load balancing (easy since your services are stateless), put in place caches at many levels (within your code with WeakHashMap, against a database with NoSQL databases, some HTTP proxy if you want to serve web pages, …). Having created your source code following this rules will permits to do that quickly almost without re-factoring.