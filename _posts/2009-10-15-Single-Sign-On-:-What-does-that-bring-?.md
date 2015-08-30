---
layout: post
section-type: post
title: Single Sign-On - What does that bring ?
category: design
tags: [ 'software' ]
---
Buzz word, we are all talking buzz word, SSO is one of them. What is Single Sign-On by the way?

A brief description would say that Single Sign-on is a solution to allow an end-user to use different applications using the same credentials.
To give you an example, when I use modern web sites like Facebook, Dailymotion, yahoo I can use OpenID to connect to any of these applications.
OpenID keeps my user information and I may connect to any of theses websites with my OpenID ID :).

Another incarnation of SSO in the enterprise world is described by OASIS using SAML.
Security Assertion Markup Language is an XML based standard for exchanging authentication and authorization data between security domains, that is, between an identity provider (a producer of assertions) and a service provider (a consumer of assertions).

During the design of your application, security is one of the concern which should be handled before even writing a line of code.
A simple pattern to allow to interact within an SSO compliant environment is to manipulate a Cookie object which will be linked to a Session object needed to  keep information across different user request.
It’s a common pattern for web design but it could be applied to any application.

Whether you are using a SSO being able to keep session state for you (in a Servlet environment for example), or managing your session yourself using a database for instance, the Identity server will be able to link a particular user to this session object.

In a web environment, you can use CAS for example to centralize your authentication and authorization (<a href="http://www.ibm.com/developerworks/web/library/wa-singlesign/">source</a>):

The following are the main steps in the authentication protocol.

* The user attempts to access an application.  The user is redirected to the CAS login URL. The user is presented with a username/password dialog box.
* The user enters ID and password details and CAS attempts to authenticate the user. If authentication fails, the target application never hears about it — the user remains at the CAS server.
* If authentication succeeds, then CAS redirects the user back to the target application, appending a parameter called a ticket to the URL. CAS then attempts to create an in-memory cookie called a ticket-granting cookie. This is done to allow for automatic re-authentication later — if present, then it indicates that the user has already successfully logged in and the user avoids having to re-enter his username and password.
* The application then validates that this is a correct ticket and represents a valid user by calling the CAS serviceValidate URL and passing the ticket and service name as parameters. CAS checks that the supplied ticket is valid and is associated with the requested service. If validation is successful, CAS returns the username to the application.

Using the username, you can provision your rights and roles from it. Either you can redo the same operation on every request or keeping this information within the current session. The link between the “cookie” and the session is then established. The session store the credentials necessary to access to any resources protected by security.

This pattern might be used within any environment. <a href="http://cwiki.apache.org/confluence/display/SHIRO/Index">Apache Shiro</a> (previously JSecurity) has been driven by this approach where authorization, authentication and session management are available within the same framework.

Adding Session Management within a security framework allow to take advantages of powerful features very easily.
You can, for example, use Shiro in any environment (web or non web) where clustered or distributed sessions are desired.
If sessions are federated across multiple applications, the user’s authentication state can be shared too.
Log in once to any application and the others all recognize that log-in.
Very simple in mind and very powerful to use, the only drawback of this framework is that is not compatible with JaaS, the java authentication and authorization standard.