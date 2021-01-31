---
layout: post
title:  "Displaying Auth0 user profiles in ASP.NET Core 5.0"
published: false
---

So maybe you want the end user to not have to manually enter into the database what they already entered into Auth0 user profile. Instead your users may want to automatically select them in your client application and add them into the database. In this blog we will learn how to do that by using the Auth0 Management API and ASP.NET 5.0, (not called .NET Core).

## Login ##

If you are new to Auth0 I highly recommend you create an [account](https://auth0.com/signup?&signUpData=%7B%22category%22%3A%22button%22%7D&email=undefined) and tenant for the region nearest to you if you want to build it here build the [demo we will use.](https://github.com/LayersOfAbstraction/Auth0UserProfileDisplayStarterKit) The quickstart uses .NET Core 3.1 but I will show you how to migrate the sample over. 

Make sure you've read through the entire quickstart before going further in this blog.

You can start at the beginning of that quickstart if you want to better understand but what I am planning to do is migrate the quickstart to .NET 5. Download the quickstart and run it to make sure it works. Once you're done we will create all the users in Auth0.

Login to the Auth0 Dashboard. Highly advise you use the new interface when you are prompted to switch to it. It's much easier to navigate from the previous design. If you accidentally close the prompt and don't enable the new dashboard interface then this [doc will tell you how to enable it.](https://auth0.com/docs/get-started/dashboard/upcoming-dashboard-changes#december-2020) 


## Create Test data ##

We need to create email aliases which are basically different user names that link to the same user which is you. There are lots of tools out there for this. I recommend you use gamil to set up your email aliases. Outlook does not support this. Here is how to do it:

* Go to your Gmail dashboard.
* Click the dropdown arrow (just next to the search box).
* In the ‘To’ field, enter your disposable address: yourname+useless@gmail.com.
* If you just don’t want to see messages sent to your Gmail account, select the ‘Skip the inbox’ option. If you’ve used a specific address to identify (say) a mailing list, you might want to apply a Gmail label instead.
* Click on ‘Create Filter’ and you’re done.

Let's get back to the project and create the users. On the left navigate to the User Management tab and select Users and create the following users. 







