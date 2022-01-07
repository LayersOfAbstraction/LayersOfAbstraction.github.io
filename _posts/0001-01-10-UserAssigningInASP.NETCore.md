---
layout: post
title: "Assigning Users In ASP.NET Core MVC 6 with DataTables Editor"
published: false
---

## Introduction ##

Assigning users from one table record to another and rendering it to the front end can be tricky but it can be done in serval ways. Our way will be via dataTables.net with ASP.NET Core MVC and SQL Server.

We will be dealing with at least 3 SQL Server database tables as shown in this diagram.

<p><img src="../images/UserAssigningInASP.NETCore/ERD.png" class="image fit" alt="Entity relationship diagram png file"/></p>

In most of my tutorials we have used Visual Studio. This time I will demo this in VS Code simply because we don't have to **leave** the command line nearly as much to get stuff done and the interface more scalable.

## Perquisites ##

I'm doing this on Windows 10. .NET Core is platform independent but if you use SQL Server on Mac then you will need to learn how to lunch it in Docker. This tutorial does not cover that.

First fire up VS Code and check in the below Terminal by running the command `dotnet --info`.

If you see any `6.0` listed then you should be ok to skip to the next heading.

```text
//.NET Core CLI output
.NET SDKs installed:
  3.1.415 [C:\Program Files\dotnet\sdk]
  5.0.209 [C:\Program Files\dotnet\sdk]
  5.0.301 [C:\Program Files\dotnet\sdk]
  5.0.303 [C:\Program Files\dotnet\sdk]
  5.0.403 [C:\Program Files\dotnet\sdk]
  6.0.100 [C:\Program Files\dotnet\sdk]
```

Not seeing it? Then go here [download and install it](https://dotnet.microsoft.com/download), then use the same command to see if `6.0`  is listed.

## We will be using MVC ##

We will use MVC here. If you want to know why we will use it over Razor, read on, else skip to next heading. You could do Razor Pages yes, and I have no problems with it but if you want more job opportunities using MVC over Razor Pages is better because:

- Razor Pages is easier to switch to later.
- The company you are interviewing may want to just stick with MVC.
- Later if you are not happy in your job using MVC you could create a presentation after you gain public speaking experience at meetups and respect in your team. You can show why Razor or why a JS framework like Angular, React or Vue are better choices (in the top 5 of the Stack Overflow Survey.)

## Create ASP.NET Core template and run it ##

.NET 6 is largely improved as it uses the minimal hosting model to allow us to have only the Program.cs file which will really reduce complexity.

Run this command.

```text
dotnet new mvc -o UserAssignDemo 
```

That will create the project folder with all the files required.

## Install following packages. ##

Go to the terminal and copy and paste these commands.

```text
dotnet add package Microsoft.EntityFrameworkCore --version 6.0.0
dotnet add package Microsoft.AspNetCore.Mvc.NewtonsoftJson --version 6.0.0
dotnet add package Microsoft.EntityFrameworkCore.Design --version 6.0.0
dotnet add package Microsoft.EntityFrameworkCore.SqlServer --version 6.0.0
dotnet add package Microsoft.VisualStudio.Web.CodeGeneration.Design --version 6.0.0
```

## Structure our namespaces ##

We need to create a Data folder in the root of our directory. After that create the class `Global namespaces`

Now in the Data folder add a empty .cs file called `GlobalNamespaces.cs` delete anything inside the file and copy and paste this into it.

```csharp
global using UserAssignDemo.Models;
global using Microsoft.EntityFrameworkCore;
global using System.ComponentModel.DataAnnotations;
global using UserAssignDemo.Data;
global using Microsoft.AspNetCore.Builder;
global using Microsoft.Extensions.DependencyInjection;
global using Microsoft.Extensions.Configuration;
global using Microsoft.Extensions.Hosting;
global using System.Collections.Generic;
global using System.Linq;
global using System.Data.Common;
global using Microsoft.Data.SqlClient;
global using System.Threading.Tasks;
global using Microsoft.AspNetCore.Mvc;
global using Microsoft.AspNetCore.Mvc.Rendering;  
global using System.ComponentModel.DataAnnotations.Schema;                            
```

Goodbye repetitive namespaces. C# 10 gives us the ability to minimize all the code files containing namespaces by centralizing them all into one file throughout our entire application.

## Create the 3 models for our project ##

We will create these 3 models in C# application. The structure of them looks like this in database diagram generated from SQL Server Management Studio. 

<img src="../images/UserAssigningInASP.NETCore/ERD.png" class="image fit" alt="Diagram showing 3 table relationship in PNG format"/>

We will start with one of them now. Instead of developing them in SQL Server Management Studio we will use Entity Framework to develop the database using the models made in C#. WARNING! Don't do this for big projects or projects that you feel may get big. Only do it when you are showing simple demos like this one.

### User.cs ###

Create a new empty file in the ```Models``` folder and call it this. The 3 properties UserFirstName, UserLastName, UserContactEmail will only display when we select a User that we have. 

```csharp
public class User
{
    public int ID { get; set; }
    public string? UserFirstName { get; set; }
    public string? UserLastName { get; set; }  
    public string? UserContactEmail{get;set;}          
    public string UserFullname => string.Format("{0} {1}", UserFirstName, UserLastName);
    public ICollection<Registration>? Registrations {get;set;}
}
```

### Job.cs ###

Same thing here.

```csharp
public class Job
{        
    
    public int ID { get; set; }
    public string? JobTitle { get; set; }
    public string? JobDescription { get; set; }
    public DateTime JobStartDate {get;set;}
    public DateTime JobDeadline {get;set;}
    public bool JobIsComplete{get;set;}

    public ICollection<Registration>? Registrations {get;set;}
}   
```

### Registration.cs ###



```csharp
public class Registration
{
    public int? ID {get;set;}
    public int? UserID { get; set; }
    public int? JobID { get; set; }
    public DateTime RegistrationDate {get;set;}        
    public User? User {get;set;}
    public Job? Job {get;set;}
}
```

We will create only one view and one controller in the .NET Core CLI from one of our models.