---
layout: post
section-type: post
title: Annotation or not
category: design
tags: [ 'software' ]
---
Java, as a mainstream programming language evolves to always trying to fit the latest needs. One big leap has been introduced in Java 5, with several language changes.
One of them was the possibility to do some meta-programming. Big word isn’t it? Indeed, meta-programming.

In Object Oriented Language like Java, you will usually construct your software using object (cars, tires, engines …) and methods (move, turn, explode …) to describe your business into something computer will understand.
Sound simple right?, in theory, this is pretty simple.
Things become difficult when we need to save data, display things to a screen, connect to the network.
Software engineer has invented APIs (Application Programming Interface) to help application developer to interact with 3rdParty libraries in general and display, network or system libraries in particular.

This is when our code start to be un-maintainable because we mix business code (cars, tires, engines) with technical plumbing (readfile, display, connect).

Java 5 has introduced annotations, a mechanism allowing to give information to our object without being part of it. Meta-programming.
One simple example is the old “deprecated” keyword.

In java, you can say that a method will soon disappear, and to say that, you just need to “annotate” your method.

Today, many frameworks are “annotations” based, meaning you can describe your software behavior without even writting a line of code, just writting some annotations to your business code to make the “plumbing”.

After a while working with annotations, you will find it can become even more messy than an old <a href="http://en.wikipedia.org/wiki/Spaghetti_code">spagetty plate</a>.
So, where are the limit, where should I use annotations, where should I not?

My opinion is, annotations are good for describing your code, but as soon as your annotation “does” something (@Inject, @In, @DoesSomethingWithoutTellingWhat :)), you should avoid them.

To give you some examples, Hibernate in java allow to annotate your model (tires, cars, engines, …) and say what IS your model and describe it.
Hibernate will pickup from this meta-information and save your data into a database.
At the opposite, you will find Jboss Seam where everything is made of annotations, you can actually “do” plenty of stuff using annotation, this is where i found annotations useless.
It doesn’t help code readability nor performance. It’s just a lazy approach to do stuff you don’t understand.

Obviously people will like them because they can produce something working in 5 minutes.
But what after these fives minutes, it will took more times to understand what the annotations are currently doing than reading simple line of codes.