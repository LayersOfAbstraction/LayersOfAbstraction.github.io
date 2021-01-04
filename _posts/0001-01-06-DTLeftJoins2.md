---
layout: post
title: "How to retrieve data from related tables in DataTables with ASP.NET MVC Core 3.1"
# published: false
---

[Previously I showed you how to create an SQL Left Join using DataTables in ASP.NET MVC Core 2.2.]({% link _posts/0001-01-05-DTLeftJoins.md  %}) Now that 2.2 is no longer getting security updates it is time to upgrade to 3.1.

I have completed demo which you can [download here in 3.1](https://github.com/LayersOfAbstraction/DTEditorLeftJoinSample). You can also go back through previous commits in the demo where I have listed the version it has upgraded to. You should know that I have methodically upgraded it from 2.2 to 3.0 and 3.1 as that is how Microsoft have done it in their migration tutorial guides.

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

`dotnet new globaljson --sdk-version 3.1.100`

You may get warned that creating this template will make changes to existing files. If so just run this command else skip to the next instruction.

`dotnet new globaljson --sdk-version 3.1.100 --force`

Now check if we have successfully switched versions `dotnet --version`. We should get the following number. 

`3.1.100`

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

Open `DTEditorLeftJoinSample.csproj` and add all these packages so it looks like this. And make sure you hit yes to restore assets else you can reopen the project again to do it.

```
<Project Sdk="Microsoft.NET.Sdk.Web">
  <PropertyGroup>
    <TargetFramework>netcoreapp3.1</TargetFramework>
    <AddRazorSupportForMvc>true</AddRazorSupportForMvc>
  </PropertyGroup>


  <ItemGroup>
    <PackageReference Include="DataTables-Editor-Server" Version="1.9.5" />
    <PackageReference Include="Microsoft.AspNetCore.Mvc.NewtonsoftJson" Version="3.1.1" />    
    <PackageReference Include="Microsoft.EntityFrameworkCore.Design" Version="3.1.1" />
    <PackageReference Include="Microsoft.EntityFrameworkCore.SqlServer" Version="3.1.1" />
  </ItemGroup>
</Project>
```

We will now create a Recipe database 3
different models, Recipe, RecipeIngredient and Ingredient. Create each
of these classes in the model folder.

## Recipe
```
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace DTEditorLeftJoinSample.Models
{
    public class Recipe
    {
        public int ID { get; set; } 
        
        public string Title {get;set;}
        public string Descriptions {get;set;}
        public string Directions {get;set;} 

        public ICollection<RecipeIngredient> RecipeIngredient { get; set; }
    }
}
```
## RecipeIngredient

```
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace DTEditorLeftJoinSample.Models
{
    public class RecipeIngredient
    {
        public int ID { get; set; }

        [Display(Name = "Recipe ID")]
        public int RecipeID { get; set; }

        [Display(Name = "Ingredient ID")]
        public int IngredientID { get; set; }

        public int Quantity { get; set; }
        public Recipe Recipe { get; set; }
        public Ingredient Ingredient { get; set; }
    }
}
```                                        

## Create Ingredient class

```
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace DTEditorLeftJoinSample.Models
{
    public class Ingredient
    {
        public int ID { get; set; }
        [Display(Name = "Ingredient Name")]
        public string IngredientName { get; set; }

        public ICollection<RecipeIngredient> RecipeIngredient { get; set; }
    }
}                                  
```                                        

## Insert connection string into appsettings.json

Create the connection string in appsettings.json then copy and paste
this connection string there.
```
{
    "ConnectionStrings": {
        "DefaultConnection": "Server=(localdb)\\mssqllocaldb;Database=RecipeDB;Trusted_Connection=True;MultipleActiveResultSets=true"
    },
    "Logging": {
        "LogLevel": {
        "Default": "Warning"
        }
    },
    "AllowedHosts": "*"
}  
```

## Create CookingContext
Even though we cannot integrate Entity Framework Core directly with DataTables Editor, we can still generate the database via EF Core to use with the library. We will do this by creating the database context class. Create a Data folder and add this class.

using DTEditorLeftJoinSample.Models;
using Microsoft.EntityFrameworkCore;

namespace DTEditorLeftJoinSample.Data
{
    public class CookingContext : DbContext
    {
        public CookingContext(DbContextOptions options) : base(options)
        {
        }

        public DbSet Recipe { get; set; }
        public DbSet Ingredient {get;set;}
        public DbSet RecipeIngredient {get;set;}  
        
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity().ToTable("tblRecipe");
            modelBuilder.Entity().ToTable("tblIngredient");
            modelBuilder.Entity().ToTable("tblRecipeIngredient ");
        }
    }
}  