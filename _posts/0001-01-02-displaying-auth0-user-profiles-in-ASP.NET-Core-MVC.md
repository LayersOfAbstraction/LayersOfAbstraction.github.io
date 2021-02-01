---
layout: post
title:  "Displaying Auth0 user profiles in ASP.NET Core 5.0"
#published: false
---

So maybe you want the end user to not have to manually enter into the database what they already entered into Auth0 user profile. Instead your users may want to automatically select them in your client application and add them into the database. In this blog we will learn how to do that by using the Auth0 Management API and ASP.NET 5.0, (not called .NET Core).

## Login ##

If you are new to Auth0 I highly recommend you create an [account](https://auth0.com/signup?&signUpData=%7B%22category%22%3A%22button%22%7D&email=undefined) and tenant for the region nearest to you if you want to build it here build the [demo we will use.](https://github.com/LayersOfAbstraction/Auth0UserProfileDisplayStarterKit) The quickstart uses .NET Core 3.1 but I will show you how to migrate the sample over. 

Make sure you've read through the entire quickstart before going further in this blog.

You can start at the beginning of that quickstart if you want to better understand but what I am planning to do is migrate the quickstart to .NET 5. Download the quickstart and run it to make sure it works. Once you're done we will create all the users in Auth0.

Login to the Auth0 Dashboard. Highly advise you use the new interface when you are prompted to switch to it. It's much less cumbersome from the previous design. If you accidentally close the prompt and don't enable the new dashboard interface then this [doc will tell you how to enable it.](https://auth0.com/docs/get-started/dashboard/upcoming-dashboard-changes#december-2020) 


## Create Test email ##

We should create email aliases which are basically different user names that link to the same user which is you. There are lots of tools out there for this. I use Gmail to set up email aliases. Outlook does not support this. You can use whatever tool you're already comfortable with to do this but here is how to do it in Gmail:

* Go to your Gmail dashboard.
* Click the dropdown arrow (just next to the search box).
* In the ‘To’ field, enter your disposable address: yourname+useless@gmail.com.
* If you just don’t want to see messages sent to your Gmail account, select the ‘Skip the inbox’ option. If you’ve used a specific address to identify (say) a mailing list, you might want to apply a Gmail label instead.
* Click on ‘Create Filter’ and you’re done.

## Create database connection in Auth0. ##

Let's get back to Auth0 dashboard and create the database connection where we can create a bridge between our application and the Auth0 user sample profiles matching this connection.

1. Go to the "Authentication" tab and then to "Database".

2. Now go to the "Create DB Connection" tab and select the red button saying "Create DB Connection"

3. For the connection name call it "Auth0UserSampleProfileConn"  

4. If you're not sure select to Disable sign ups then leave the "Disable Sign Ups" switch alone. You may not just want
anyone to be able to access your application.

5. Hit the Create button. 

## Create Test user in Auth0 ##

Let's create the users now in the same dashboard.

1. On the left navigate to the User Management tab and select Users and create the following users. 

2. Copy and paste the password you wrote down and email. In this case you could use a password manager like I am or just some password book. 

NOTE: Might want to make a new folder for your Auth0 users in your password manager if you create them so they don't get mixed up with your real password accounts info.  

3. Chose the connection that you created earlier in the Database connections.  

![User](../images/Displaying-auth0-user-profiles-in-ASP.NET-Core-MVC/Create_Auth0_DB_Connection_And_User.gif){:width="539px"}






