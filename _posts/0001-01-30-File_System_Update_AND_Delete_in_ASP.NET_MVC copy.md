---
layout: post
title: Managing File Server Storage Part 2
subtitle: "Integrate reading, updating and deleting with file system storage"
date: "2024-09-22"
published: false
---



## Introduction

In a past [previous tutorial](https://consolecommando.net/File_System_Storage_in_ASP.NET_MVC) I haven't commenced for a while, (apologies) I showed how you could make an on premises file server storage solution with clean maintainable code that could be used in a real world solution. 

However it only showed how you could upload files and download each of them in a HTML table.

This second blog will be for updating and deleting files and the last will show how to link file references to a database so their records can track which file in the file system links to what record. 

Let us begin.

## Serve static files by testing Buffered/Index.cshtml page 

We want to serve static files from our webroot directory as shown in the previous blog. Essentially, in ASP.NET you will want to use `useStaticFiles()` method in the Program.cs file.

If you already have something like the following in your Index file.

```html
<img src="~/Uploads/MyImage.png" class="img" alt="Test">
```

You would be able to to test your index page and run it to ensure it can display a photo regardless of wether it is hardcoded or not. I currently have the image in my webroot directory. So upon rendering it would look like this.


Of course that's not how we would want it displayed and it already allows us to test that we can display images so you can already delete the line after completing the development phase.

Now for the fun part with integrating this into our current logic. I will assume you have completed part one of this tutorial. If not, now's the time!

## Overview of abstracting the logic



### References

Rick-Anderson (2024). Static files in ASP.NET Core. [online] Microsoft.com. Available at: https://learn.microsoft.com/en-us/aspnet/core/fundamentals/static-files?view=aspnetcore-8.0#serve-files-in-web-root [Accessed 26 Sep. 2024].

‌