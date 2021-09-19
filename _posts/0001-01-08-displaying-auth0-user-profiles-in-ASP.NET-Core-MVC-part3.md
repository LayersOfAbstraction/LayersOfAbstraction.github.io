---
layout: post
title:  "Displaying Auth0 user profiles in ASP.NET Core 5.0 (part 3)"
#published: false
---

[Previously I showed you how to auto renew a token]({% link  _posts/0001-01-07-displaying-auth0-user-profiles-in-ASP.NET-Core-MVC-part2.md %}). We can improve the performance as well. will look at storing our JWT in a distributed cache service to help us improve the performance and scalability of our ASP.NET 5 MVC client application and store it in a database.

Do you know what a cache is? It just helps your computer retrieve data faster from a server by using your computer's RAM. 

But what exactly is a distributed cache? Microsoft puts it nicely.

_A distributed cache is a cache shared by multiple app servers, typically maintained as an external service to the app servers that access it. A distributed cache can improve the performance and scalability of an ASP.NET Core app, especially when the app is hosted by a cloud service or a server farm._

[Link here.](https://docs.microsoft.com/en-us/aspnet/core/performance/caching/distributed?view=aspnetcore-5.0) So your app may become very big. And you may be pushing a lot of changes to production. That means the more load it has, the more likely it crashes. A distributed  divides that load by being split into a series of nodes.

We are going to use SQL Server Database to configure that or to be more exact we will configure localdb which is a development version of SQL Server.
