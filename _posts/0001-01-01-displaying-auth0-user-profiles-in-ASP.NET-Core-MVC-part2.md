---
layout: post
title:  "Displaying Auth0 user profiles in ASP.NET Core 5.0 (part 2)"
published: false
---
Earlier I showed you how to Display Auth0 user profiles in ASP.NET Core 5.0 but did not show you how to automatically renew the token. 

If you haven't noticed yet you'll see you can't get the users and will be returned this exception.

`ErrorApiException: {"statusCode":401,"error":"Unauthorized","message":"Expired token received for JSON Web Token validation","attributes":{"error":"Expired token received for JSON Web Token validation"}}`

If we did it the same way we did it in part one then we would have to manually regenerate the token in Auth0 dashboard and hardcoded it again!

Or...

We could request a refresh token from the Auth0 Dashboard and use that to generate a brand new token automatically. 

Also we left the token string in our project tree which can be dangerous if you commit the token to source control. You want to declare it outside of your project tree using either the ASP.NET Secrets Manager or an environment variable. 

In this article I will show you how to configure in memory token management.   

## Before starting ##

There are two ways you can complete this tutorial. You can:

1. Use the project you downloaded from the Auth0UserProfileDisplayStarterKit part1 blog and continue using that to follow along and complete this tutorial.

2. You can start from scratch and use the Part2 branch project I created for our Auth0UserProfileDisplayStarterKit with a link to the [starter kit project here](https://github.com/LayersOfAbstraction/Auth0UserProfileDisplayStarterKit/tree/part2). The project branch in that repository is created solely for this part2 blog.

I would personally use option 1 to get the most out of this tutorial.
If you haven't already seen my [Part1 blog](https://layersofabstraction.github.io/displaying-auth0-user-profiles-in-ASP.NET-Core-MVC-part1.html) for this tutorial you are advised to go through it to understand how to use Auth0.   

In this blog we are going to update our previous logic and use new technologies. 

## Copy these library folders from repository into your project ##

Please, please [star this repository if you are logged in and clone it!](https://github.com/nikaburu/Example.Auth0.AuthenticationApi)
It is a version of the Identity model library we will be using to renew the token 
automatically. 

Make sure you have cloned and extracted the repository. The folders you need to copy across from the repository are:

- AccessTokenManagement
- Services

Copy them into your project now.

## Paste logic into our controller ##

















