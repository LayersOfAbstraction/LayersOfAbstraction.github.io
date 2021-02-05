---
layout: post
title:  "Displaying Auth0 user profiles in ASP.NET Core 5.0"
#published: false
---

So maybe you want the end user to not have to manually enter into the database what they already entered into Auth0 user profile. Instead you may want to automatically display them from Auth0 and select them in your client application and add them into the database. In this blog we will learn how to do that by using the Auth0 Management API and ASP.NET 5.0, (not called .NET Core).

You can use what you want here. VS Code or Visual Studio. I will use VS Code in this blog.

## Important ##

Make sure you've read through the entire quickstart before going further in this blog.

You can start at the beginning of that quickstart if you want to better understand. Download the quickstart and run it to make sure it works. Once you're done we will create all the users in Auth0.

Login to Auth0 Dashboard. Highly advise you use the new interface when you are prompted to switch to it. It's much less cumbersome from the previous design. 

If you accidentally close the prompt and don't enable the new dashboard interface then this [doc will tell you how to enable it.](https://auth0.com/docs/get-started/dashboard/upcoming-dashboard-changes#december-2020) 

## Login ##

If you are new to Auth0 I highly recommend you create an [account](https://auth0.com/signup?&signUpData=%7B%22category%22%3A%22button%22%7D&email=undefined) and tenant for the region nearest to you. 

You can learn to use Auth0 by using [the quickstart written in .NET Core 3.1.](https://auth0.com/docs/quickstart/webapp/aspnet-core-3/02-user-profile) Because there is no .NET 5 quickstart I have migrated it into a [simple starter sample in .NET 5](https://github.com/LayersOfAbstraction/Auth0UserProfileDisplayStarterKit) you can use alongside this blog. 

## Create Application on the Auth0 server ##

Look at `appsettings.json` in you client app and make sure you replace the Domain Name, ClientID and ClientSecret with the one who have made for your application you have made in the Auth0 server. If you do not know how to do that:

1. Go to Auth0 Dashboard and select Applications. And under that select Applications and then pick a name like "User_Profile_Client_Display_App"
or My App.

2. Hit Regular Web App.

3. Hit Create.

4. Once created select the app where the triple dot is and and go to Settings. The application should contain each the values to copy and paste into your `appsettings.json` file on the client side. Copy them across now.

![Create_User_and_Db_conn](../images/Displaying-auth0-user-profiles-in-ASP.NET-Core-MVC/ChangeAuth0AppValuesToMatchProject.gif){:width="539px"}

## Create Test email ##

We should create email aliases which are basically different user names that link to the same user which is you. There are lots of tools out there for this. I use Gmail to set up email aliases. Outlook does not support this. You can use whatever tool you're already comfortable with to do this but here is how to do it in Gmail:

* Go to your Gmail dashboard.
* Click the dropdown arrow (just next to the search box).
* In the ‘To’ field, enter your disposable address: yourname+useless@gmail.com.
* If you just don’t want to see messages sent to your Gmail account, select the ‘Skip the inbox’ option. If you’ve used a specific address to identify (say) a mailing list, you might want to apply a Gmail label instead.
* Click on ‘Create Filter’ and you’re done.

## Create database connection in Auth0. ##

Let's get back to Auth0 dashboard and create the database connection where we can create a bridge between our application and the Auth0 user sample profiles matching this connection look at the strip on the left.

1. Go to the "Authentication" tab and then to "Database".

2. Now go to the "Create DB Connection" tab and select the red button saying "Create DB Connection"

3. For the connection name call it "Auth0UserSampleProfileConn"  

4. If you're not sure select to Disable sign ups then leave the "Disable Sign Ups" switch alone. You may not just want
anyone to be able to access your application.

5. Hit the Create button. 

## Create Test user in Auth0 ##

Let's create the users now in the same dashboard.

1. On the left navigate to the User Management tab and select Users and create the following users. 

2. Copy and paste the password you wrote down and email. In this case you could use a password manager like I am or just some password book. NOTE: Might want to make a new folder for your Auth0 users in your password manager if you create them so they don't get mixed up with your real password accounts info.  

3. Choose the connection that you created earlier in the Database connections.  

4. Hit create done.

Steps clear as mud? Don't know how to navigate? That's why I made an image showing how to do everything here.

![Create_User_and_Db_conn](../images/Displaying-auth0-user-profiles-in-ASP.NET-Core-MVC/Create_Auth0_DB_Connection_And_User.gif){:width="539px"}

## Install and configure Auth0 Authentication Management API ##

To get a list of users from Auth0 and read them in our application we have three ways of doing it. We can use the "export job", "User Import extension" or  the Auth0 Management API they wrote. 

We will use the API for this tutorial. Please note Auth0 limits the number of users you can return. If you exceed that limit [please click here and wait a few seconds before Auth0 automatically scrolls to the desired heading.](https://auth0.com/docs/api/management/v2#!/Users/get_users)

Go into the console windows and type this.

`dotnet add package Auth0.ManagementApi`

Now it should have installed into your project. We have declare the Management API namespace in the C# controller where we are going to render the users. 

We use do this in HomeController in the sample you downloaded. Go to `HomeController.cs` now and add the Auth0 Management API namespace.

```
using Auth0.ManagementApi;
```

If you have some familiarity with Object Orientated Programming you will know that we need to instance a class in order to use it. We need to do that with the ManagementApiClient class.  

```
// Replace YOUR_AUTH0_DOMAIN with the domain of your Auth0 tenant, e.g. mycompany.auth0.com
var client = new ManagementApiClient("YOUR_MANAGEMENT_TOKEN", "YOUR_AUTH0_DOMAIN");
```

You should already replace the dummy domain name with the one for your tenant. If you forgot, you just need to go back up the page. I provide all the steps for that. 

It's more tricky with generating the API JSON Web Tokens (JWTs) and inputing the name of it as it is so long and requires that you create and authorize a machine-to-machine application.
Let's do that now. [This link already shows how to do that](https://auth0.com/docs/tokens/management-api-access-tokens/create-and-authorize-a-machine-to-machine-application). 

## Create & Authorize a Test Application ## 

Make sure you selected the "Read Users" grant for now or have all the default ones enabled.
If you don't know which API to use, just use the Auth0 Management API.

When you are done return to this blog.  

 

