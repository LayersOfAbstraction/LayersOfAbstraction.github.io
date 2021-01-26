---
layout: post
title:  "Displaying Auth0 user profiles in ASP.NET Core 5.0"
published: false
---

So maybe you want the end user to not have to manually enter into their database that they already entered into Auth0 user profile. In this blog we will learn how to do that by using the Auth0 Management API and ASP.NET 5.0, (not called .NET Core).

If you are new to Auth0 I highly recommend you create an [account](https://auth0.auth0.com/login?state=g6Fo2SBiWDB6SDhqaDBNUzAwWUJLVUdaN3Q5YmNGM2c5b3k3TKN0aWTZIDdJYUd3OWRlUXhlLTBrRkVyclNrQTBfVVRtci1Vd2cxo2NpZNkgYkxSOVQ1YXI2bkZ0RE80ekVyR1hkb3FNQ000aU5aU1Y&client=bLR9T5ar6nFtDO4zErGXdoqMCM4iNZSV&protocol=oauth2&response_type=code&redirect_uri=https%3A%2F%2Fauth0.com%2Fauth%2Fcallback&scope=openid%20profile%20email) and tenant for the region nearest to you if you want to test it and use this Quickstart here to build the [demo we will use.](https://auth0.com/docs/quickstart/webapp/aspnet-core-3/03-authorization) I am using .NET Core 3.1 but this should still work fine. 

