---
layout: post
title:  "Displaying Auth0 user profiles in ASP.NET Core 5.0 (part 2)"
published: false
---
Eariler I showed you how to Display Auth0 user profiles in ASP.NET Core 5.0 but did not show you how to automatically renew the token. 

If you haven't noticed yet you'll see you can't get the users and will be returned a `ErrorApiException: {"statusCode":401,"error":"Unauthorized","message":"Expired token received for JSON Web Token validation","attributes":{"error":"Expired token received for JSON Web Token validation"}}`

If we did it the same way we did it in part one then we would have to manually regenerate the token in Auth0 dashboard and hardcode it again! 😭

Or...

We could request a refresh token from the Auth0 Dashboard. 

Also we left the token string in our project tree which can be dangerous if you commit the token to source control. You want to declare it outside of your project and  
