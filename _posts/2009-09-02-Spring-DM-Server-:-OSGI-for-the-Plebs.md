---
layout: post
section-type: post
title: Spring DM Server - OSGI for the Plebs
category: tech
tags: [ 'software' ]
---
As you will probably discover, OSGI community is a very vibrant community. I will continue my articles around OSGi with some thought on the Spring flavor of OSGI as a plaform.

Spring DM Server is a product based on Spring OSGI open source project which have a goal (like always with Spring) to  encapsulate OSGI plateform to let you focus on your business code.

Then, here an insight of what Spring brings to OSGI…

Usually, OSGi services (obviously we are in the SOA world) has to be declared by using an API, OSGI Dynamic Service allow you to declare by configuration your service but you can’t manage services dependencies (half of the path has been done, “dommage”). Here an example how to declare and get service reference within OSGI :

{% highlight java %}
class Activator extends BundleActivator {
 public void start(BundleContext context) {
  MySecondService s2 = context.getService(
    context.getServiceReference(MySecondService.class.getName(), null));
  MyServiceImpl s1 = new MyServiceImpl();
  s1.setMySecondService(s2);
  context.registerService(MyService.class, s1, null);
  }
}
{% endhighlight %}

It almost enough, still, you need to write some code and your application need to have OSGI jar during your test. Also, if you don’t want to deploy you application within different environment (OSGI, regular JEE, plain J2SE…), it will be difficult.

Here comes Spring and its magical IoC pattern (ok , it is not a patent of Spring :)). Soon I will write a long article around Dependency Injection pattern.

By applying the IoC pattern, you can define and make the dependencies of your OSGI service within a simple XML file. The benefices are evident, no more code attached to OSGi, less code to write (and maintain), and automatic management of dependencies (in theory…).

In addition of the OSGI platform, Spring DM Server comes with Tomcat to help you deploy your web application. If you don’t need the full JEE stack, Spring DM could be the solution. It allow you to use old plain War and also a new concept based on OSGI (quite similar to Tomcat Webclass loader) which allow a War to use (by using OSGI dependencies) shared jar.
Much more powerful than the old Tomcat approach where you were literally in a sandbox. Here you can manage what can be shared/exposed to your wars.

I will not go too much in details on Spring DM, the idea here is really to focus on the OSGi part. So, at least too related things are missing which make developer being frustrated.
First, they are no way to set a start level within the application context files of Spring OSGI configuration. The second issue, more related to OSGI itself, mandate developer to use PAR (“multiple bundle” packaging made in Spring) to deploy your application, which is dangerous; you tend to tight yourself to a particular application server.

Nothing is perfect in this world, Java and its class-path make developer life difficult with the Jar Hell, OSGI came with a new buzz word, the “bundle dependencies hassle”.

You can find Spring DM OSGI (or Spring DM Kernel) within <a href="http://felix.apache.org/site/apache-felix-karaf.html">Felix Karaf</a>, a Apache project in incubation which has the goal to create core services on top of OSGI (Provisionning, Dynamic declaration (Spring DM), SSH Access, and many other killer features).

Karaf was first developed within Apache ServiceMix project (the Apache ESB). So, there is still many thing related to it. However, Karaf seems to be a really promising project as it cover many issue needed in the entreprise world OSGI itself had let aside (Its primary plateform was the Mobile industry).

With almost all major vendor adopting OSGI, Spring OSGI (open source project) or Spring DM Server (Spring product) could play a great part. Spring philosophy (I hope it will stay this way…) to focus on the principal (KISS Principle) might be a good solution for small and medium business who need to develop web application without all the payload of JEE.