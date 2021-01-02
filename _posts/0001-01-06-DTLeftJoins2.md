---
layout: post
title: "How to retrieve data from related tables in DataTables with ASP.NET MVC Core 3.1"
published: false
---

[Previously I showed you how to create an SQL Left Join using DataTables in ASP.NET MVC Core 2.2.]({% link _posts/0001-01-05-DTLeftJoins.md  %}) Now that 2.2 is no longer getting security updates it is time to upgrade to 3.1.

I have completed demo which you can download [here in 3.1](https://github.com/LayersOfAbstraction/DTEditorLeftJoinSample). You can also go back through previous commits in the demo where I have listed the version it has upgraded to. You should know that I have methodically upgraded it from 2.2 to 3.0 and 3.1 as that is how Microsoft have done it in their migration tutorial guides.

Don't worry I will show you how to build the project from scratch so you don't have to migrate it from different frameworks. That's no way to treat a reader!

## Setup the development environment

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

