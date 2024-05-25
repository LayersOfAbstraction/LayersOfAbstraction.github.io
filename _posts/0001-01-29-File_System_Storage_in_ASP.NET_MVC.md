---
layout: post
title:  Managing File Storage Part 1
subtitle: "Bridging the Gap: ASP.NET MVC Service Interface Reusability"
date: "2024-05-20"
published: false
---

<img src="../images/0001-01-29/Title-maximalfocus-unsplash.jpg" class="image fit" alt="Picture showing disposable email"/>
Photo by <a href="https://unsplash.com/@maximalfocus?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">Maximalfocus</a> on <a href="Textures & Patterns">Unsplash</a>
  
## Introduction

In this tutorial you'll learn to create and see an index of files to download in your local filesystem, using ASP.NET 8 MVC and C#.  

⚠ I won't be covering large file uploads. Only buffered (small files).

You'll create clean, thin controllers with no model property references, by using service classes and interfaces that interact with your models. This will make your code more reusable.

I will show you this in a moment. I am hopping to make this into a 3 part series, the second one will be for updating and deleting from the View file actions and the last will show how to link file references to a database so their records can track which file in the file system links to what record. 

We generally store files in a file system instead of a database like Access or MySQL, as documented on Microsoft Learn.

- It can handle larger uploads.
- Less expensive than using a cloud data storage service, especially if the data is on premises.
- Images and video files depending on their size are especially heavy on the database unless stored outside.

## Perquisites and setup

Do this in either a text editor, or an IDE that you know supports .NET 8 or if you hate locally installing dependencies, you can always find a Docker image for it. 

Visual Studio 2022 should have this already built in so I will quickly walk you through it:

1. Select `Create a new project`. 
2. Select from the available templates: `ASP.NET Core Web App (Model-View-Controller)` and hit next.
3. Name your project what you want. I named it as `File-Upload-Downloader`, and hit next.
4. In the Additional Information window, select .NET 8.0. 
5. (OPTIONAL). Highly recommend you tick `Enable Docker`. The reason beeing is because if you reinstall Windows then it makes your application more portable in the future so you don't have to install .NET 8. Set the Docker OS as `Linux` so you can use it outside of Windows if applicable.
6. Hit Create.

## What the structure looks like?

<img src="../images/0001-01-29/MyClassDiagram.jpg" class="image fit" alt="Picture showing disposable email"/>

We will create the models, then service and interfaces and after that we will just have the create the Controller and Views.

First we will break this into a series of tasks. My first one is upload files.

## Uploading files

First we will create a model and interface that will be the intermediary between our controller and service class to upload the files. 

### FileModel

Create a new folder in your project called `FileViewModels` and then under that create a model called `FileModel`.

```csharp
public class FileModel
{
    public IFormFile? File { get; set; }
    public string? FileName { get; set; }
    public string? FileExtension { get; set; }
    public long FileSize { get; set; }
    public bool UploadResult { get; set; }
}
```

This will be our view model representing a single file running in memory. We'll use the IFormFile primarily for uploading buffered files while the FileName property will be used for reading them.

## IBufferedFileService

If you are not aware of what an interface is, then there is no shame in checking [this out](https://learn.microsoft.com/en-us/training/paths/get-started-c-sharp-part-1/). That aside this is what it would look like. We will be implementing our service through here as a child and upload more methods later. For now you want to create this method. 


```csharp
public interface IBufferedFileService
{
    Task<bool> UploadFile(IFormFile file);
}
```

### REFERENCES:

_Rick-Anderson (2023). Upload files in ASP.NET Core. [online] learn.microsoft.com. Available at: [https://learn.microsoft.com/en-us/aspnet/core/mvc/models/file-uploads?view=aspnetcore-8.0#storage-scenarios](https://learn.microsoft.com/en-us/aspnet/core/mvc/models/file-uploads?view=aspnetcore-8.0#storage-scenarios) [Accessed 21 May 2024]._

_link, G., Facebook, Twitter, Pinterest, Email and Apps, O. (2022). ASP.NET Core 6: Downloading Files from the Server. [online] Available at: [https://www.webnethelper.com/2022/01/aspnet-core-6-downloading-files-from.html](https://www.webnethelper.com/2022/01/aspnet-core-6-downloading-files-from.html) [Accessed 23 May 2024]._

_Anon, (2022). File Upload in ASP.NET Core 6 - Detailed Guide | Pro Code Guide. [online] Available at: [https://procodeguide.com/programming/file-upload-in-aspnet-core/](https://procodeguide.com/programming/file-upload-in-aspnet-core/) [Accessed 24 May 2024]._
‌