---
layout: post
section-type: post
title: Distributed OSGi, an elegant way to distribute software
category: design
tags: [ 'software' ]
---
Before talking about distribution, I will talk a little about OSGi.

This platform was primarily intended to work on mobile device.
Therefore, it has been design to be light and focusing on the principal (<a href="Distributed OSGi, an elegant way to distribute software">KISS Principle</a>).

Every developer who had used Java programming more than just some Hello World tests, will understand the Jar Hell and the fun with the Class-path.
OSGi has too primary goals, first its modular system which allow to manage module (they call it Bundle) life-cycle, module version management and module dependencies. It’s particularly important for applications who need to run with small memory to only load what is necessary.
The second important goal of the core of OSGi is its service registry, once again focus on the minimum and just allow a module to register its services on the registry in a really purely manner.

The OSGi consortium create many default service, some very generic (logging, security, web server), other more dedicated to a mobile platform (Power Management, Device Access, …).

Today, OSGi specification has spread to the enterprise world, most Application Server vendor bundle their infrastructure with OSGi within its core (JBoss, WebSphere, Glassfish, Jonas, Spring DM…).

As you probably know, or you starting to understand, OSGI seat right on top of the JVM and act as a kernel in our application. What will you say, if, now, without having to change one line of code, you can distribute your bundle on separated node. Nice on paper, DOSGi bring you that.

Today, only one implementation of OSGI 4 R4.2 (which contains DOSGi) is implemented by Apache CXF based on Web Services. I’m pretty sure tomorrow, other implementation will emerge with more performing RPC-like protocols.

At the OSGi service level, you will be able to discuss transparently with another service without knowing where the service is hosted. You just have to choose only at deployment phase where you want to distribute or not some of your services.

Going a step ahead, Eclipse Foundation is working on two promising project around this approach. Since Eclipse RCP choose OSGi for managing its plug-in on client, they had remove completely the old client/server paradigm. You can just using a service wherever it is hosted.

There are two different projects on Eclipse Incubation around this approach :

    <a href="http://www.eclipse.org/riena/">Eclipse Riena</a> : This framework being develop is the foundation to develop multi-tier application by exposing services in a transparent way.
    <a href="http://www.eclipse.org/corona/>Eclipse Corona</a> : Using events and actions on top of OSGi, this project aims to deliver a very efficient interaction between eclipse clients and server side to allow collaboration tools.

For those of you who are Netbeans addict, I know there are some, really, somewhere in the back of the classroom :). Hopefully for you guys, <a href="http://eppleton.sharedhost.de/blog/?p=701">people from the Netbeans community</a> are doing some research to make OSGi bundle first class citizen in your favorite RCP :).