---
layout: post
title: "How to retrieve data from related tables in DataTables with ASP.NET MVC Core 3.1"
published: false
---

[Previously I showed you how to create an SQL Left Join using DataTables in ASP.NET MVC Core 2.2.]({% link _posts/0001-01-05-DTLeftJoins.md  %}) Now that 2.2 is no longer getting security updates it is time to upgrade to 3.1.

I have completed demo which you can download [here in 3.1](https://github.com/LayersOfAbstraction/DTEditorLeftJoinSample). You can also go back through previous commits in the demo where I have listed the version it has upgraded to. You should know that I have methodically upgraded it from 2.2 to 3.0 and 3.1 as that is how Microsoft have done it in their migration tutorial guides.

Don't worry I will show you how to build the project from scratch so you don't have to migrate it from different frameworks. That's no way to treat a reader!

## Setup the development environment ##

First we use Visual Studio Code. You should already. If not just download it [here](https://code.visualstudio.com/download#). You should be able to do it in your any of the listed operating system as the framework we use is open source though I will be doing this in Windows 10. I like to use the portable version in case I must rush to install it on a new machine.

## Download and setup .NET Core 3.1 ##

First check to see if you have .NET Core 3.1 already installed by using `dotnet --info`.


If you see any `3.1.100` or `3.1.402` listed then you should be ok to skip to the next heading.


```
//.NET Core CLI output
.NET SDKs installed:
  2.1.202 [C:\Program Files\dotnet\sdk]
  2.1.508 [C:\Program Files\dotnet\sdk]
  2.1.509 [C:\Program Files\dotnet\sdk]
  2.2.108 [C:\Program Files\dotnet\sdk]
  2.2.401 [C:\Program Files\dotnet\sdk]
  3.0.103 [C:\Program Files\dotnet\sdk]
  3.1.100 [C:\Program Files\dotnet\sdk]
  3.1.402 [C:\Program Files\dotnet\sdk]
  5.0.100 [C:\Program Files\dotnet\sdk]
  5.0.101 [C:\Program Files\dotnet\sdk]
```

Not seeing it? Then go here [download and install it](https://dotnet.microsoft.com/download), then use the same command to see if either `3.1.100` or `3.1.402` is listed.

## Switch versions ##

Let us manually set our version to our target version by creating a json file in our project directory with these commands. 

`dotnet new globaljson --sdk-version 3.1.402`

You may get warned that creating this template will make changes to existing files. If so just run this command else skip to the next instruction.

`dotnet new globaljson --sdk-version 3.1.402 --force`

Now check if we have successfully switched versions `dotnet --version`. We should get the following number. 

`3.1.402`

If we have, then we are ready to create a new ASP.NET Core MVC app in that version. 

## Create new project ##

Use this command to create project folder and files. `dotnet new mvc -o DTEditorLeftJoinSample`

Load project directory in VS Code and watch a new window open that displays only the project folder and files. When you execute this command you can close the previous VS Code window. 

`code DTEditorLeftJoinSample`

Now before we continue we must ensure we have a trusted certificate if you don't already have one.

`dotnet dev-certs https --trust`

## Run new project ##

Fire up the project with the command `dotnet watch run` and you should be able to navigate to the url that is listed in the terminal that ASP.NET Core is listening on. Click on it and make sure the template is functioning ok before continuing.  

If that all works then **_PLEASE DELETE_** your `global.json` file so we don't get versions confused. Also I suggest you terminate your watch using Ctrl + c.

## Update .csproj file ##

