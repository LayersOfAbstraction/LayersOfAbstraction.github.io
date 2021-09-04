---
layout: post
title:  "Displaying Auth0 user profiles in ASP.NET Core 5.0 (part 2)"
published: false
---
Earlier I showed you how to Display Auth0 user profiles in ASP.NET Core 5.0 but did not show you how to automatically renew the token. 

If you haven't noticed yet you'll see you can't get the users and will be returned this exception.

```
`ErrorApiException: {"statusCode":401,"error":"Unauthorized","message":"Expired token received 
for JSON Web Token validation","attributes": {"error":"Expired token received for JSON Web 
Token validation"}}`
```
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

## Install Auth0 Authentication API SDK ##

We need access to the ClientCredentialsTokenRequest Class which lies in the Auth0.AuthenticationApi.
Download this into one your project to access. 

```
dotnet add package Auth0.AuthenticationApi --version 7.7.0
```

## Copy these library folders from repository into your project ##

Please, [star this repository if you are logged in and clone it!](https://github.com/nikaburu/Example.Auth0.AuthenticationApi)
It is a version of the Identity Model library we will be using to renew the token 
automatically. 

Make sure you have cloned and extracted the repository. The folders you need to copy across from the repository are:

- AccessTokenManagement
- Services

Copy them into your project now.

## Paste new Auth0ManagementApi and Identity Model logic into our Home Controller ##

Go into Controllers\HomeController and declare these three models at the top of your code above
the namespace.

```
using Auth0.ManagementApi.Paging;
using Example.Auth0.AuthenticationApi.Services;
using System.Threading;
```

We need to create a list and tell C# that we are using IUserService. So in the controller
create an IPagedList, declare that you are using the IUserService and pass it 
to the constructor. Also use the CancellationToken class to cancel retrieval of Auth0 
refresh token if unsuccessful. It should be in System.Threading. 
 

```
public IPagedList<Auth0.ManagementApi.Models.User> Users { get; private set; }
private readonly IUserService _userService;

public HomeController(IUserService userService)
{
    _userService = userService;
}
```

Now let's get to the action method being passed to the view which is GetAllAuth0Users()

This is what looked like in our part one to this tutorial.

```
public async Task <IActionResult> GetAllAuth0Users()
{
    //Get token
    var apiClient = new ManagementApiClient(Auth0UserProfileDisplayStarterKit.ViewModels.ConstantStrings.strToken, new Uri ("https://dev-dgdfgfdgf324.au.auth0.com/api/v2/"));
    //Get all auth0 users that have this application
    var allUsers = await apiClient.Users.GetAllAsync(new Auth0.ManagementApi.Models.GetUsersRequest(), new Auth0.ManagementApi.Paging.PaginationInfo());
    //Read each Auth0 user by field
    var renderedUsers = allUsers.Select(u => new User
    {                
        //Split their full name into first and last name if there is a space
        UserFirstName = u.FullName.Contains(' ') ? u.FullName.Split(' ')[0] : "no space",
        UserLastName = u.FullName.Contains(' ') ? u.FullName.Split(' ')[1] : "no space",
        //Get user profile email
        UserContactEmail = u.Email
    }).ToList();

    return Json(renderedUsers);
}
```

Now change it this.

```
/// <summary>
/// Display Auth0 users from list.
/// </summary>
/// <param name="cancellationToken">Notify application any action should be canceled</param>
/// <returns></returns>
public async Task <IActionResult> GetAllAuth0Users(CancellationToken cancellationToken)
{            
    //Get new token using Auth0ManagementApi with IUserService to interface with Identity Model library.
    var allUsers = await _userService.GetUsersAsync(new GetUsersRequest(), new PaginationInfo(), cancellationToken);
    //Get all auth0 user's first name, last name and email
    var renderedUsers = allUsers.Select(u => new Auth0UserProfileDisplayStarterKit.ViewModels.User
    {                
        UserFirstName = u.FullName.Contains(' ') ? u.FullName.Split(' ')[0] : "no space",
        UserLastName = u.FullName.Contains(' ') ? u.FullName.Split(' ')[1] : "no space",
        UserContactEmail = u.Email
    }).ToList();
    return Json(renderedUsers);
}
```

A lot of it is self explanatory from the comments I wrote. The big changes are we are no longer
using the Auth0ManagementApiClient class methods or the constant string we made earlier.
So you can delete that ConstantStrings class.

We are instead using the Auth0ManagementApi methods to get the Users Profiles we have 
connected to our application in Auth0 Dashboard. And we are using the IUserService which we
declared in the constructor to interface with the Identity Model library and get us a 
refresh token.

We also get the CancellationToken using this method.

```
public async Task OnGet(CancellationToken cancellationToken)
{
    Users = await _userService.GetUsersAsync(new GetUsersRequest(), new PaginationInfo(), cancellationToken);
}
```


## Get Access Token ##

Now we need to create two models to help us create access token. Here is the code for class LoginAuthentication.

```
using Auth0.AuthenticationApi;

//Insert into your own namespace 

    public class LoginAuthentication
    {

        public static Auth0Token Login(string ClientID, string ClientSecret, string domain)
        {
            var authenticationApiClient = new AuthenticationApiClient(domain);
            var token =  authenticationApiClient.GetTokenAsync(new Auth0.AuthenticationApi.Models.ClientCredentialsTokenRequest
            {                
                ClientId = ClientID,
                ClientSecret = ClientSecret,
                Audience = "https://dev-dgdfgfdgf324.au.auth0.com/api/v2/"
            }).Result;
            return new Auth0Token {strAuthToken = token.AccessToken};   
        }
    }

```

Now we need to add AcccessTokenManagement references to Startup.ConfigureServices. Code looks like this.

```
services.AddAccessTokenManagement(Configuration); 
services.AddTransient<IUserService, UserService>();
```

## Make token globally accessible ##

[//]: # (Up to step 8/10)









