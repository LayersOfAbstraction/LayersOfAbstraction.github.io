---
layout: post
title: "How to retrieve data from related tables in DataTables with ASP.NET MVC Core 3.1"
publish: false
---

[Previously I showed you how to create an SQL Left Join using DataTables in ASP.NET MVC Core 2.2.]({% link _posts/0001-01-05-DTLeftJoins.md  %}) Now that 2.2 is no longer getting security updates it is time to upgrade to 3.1.

I have completed demo which you can [download here in 3.1](https://github.com/LayersOfAbstraction/DTEditorLeftJoinSample). You can also go back through previous commits in the demo where I have listed the version it has upgraded to. You should know that I have methodically upgraded it from 2.2 to 3.0 and 3.1 as that is how Microsoft have done it in their migration tutorial guides.

Don't worry I will show you how to build the project from scratch so you don't have to migrate it from different frameworks. That's no way to treat a reader!

## Create App In Visual Studio 2019 ##

Microsoft's ASP.NET Core team use Visual Studio for MVC tutorials with EF Core. So let's first open Visual Studio 2019 and create ASP.NET Core WebApplication Template. 

You can always play around with this app in VS Code later if you want once you complete it.

![VSNavigateToFolder](../images/DTLeftJoins/VSNavigateToFolder.png)

Make sure you have selected 3.1, have no authentication and have
configured for HTTPS.

![CreateNewASP.NETCoreWebApp](../images/DTLeftJoins/CreateNewASP.NETCoreWebApp.png)

After that create the project. We will now create a Recipe database 3 
different models, Recipe, RecipeIngredient and Ingredient. Create each 
of these classes in the model folder.

## Download and setup .NET Core 3.1 ##

First check to see if you have .NET Core 3.1 already installed by using in the Package Manager console `dotnet --info`.


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

## Update .csproj file ##

Open `DTEditorLeftJoinSample.csproj` and add all these packages so it looks like this. And make sure you hit yes to restore assets else you can reopen the project again to do it.

```
<Project Sdk="Microsoft.NET.Sdk.Web">
  <PropertyGroup>
    <TargetFramework>netcoreapp3.1</TargetFramework>
    <AddRazorSupportForMvc>true</AddRazorSupportForMvc>
  </PropertyGroup>


  <ItemGroup>
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

```
using DTEditorLeftJoinSample.Models;
using Microsoft.EntityFrameworkCore;

namespace DTEditorLeftJoinSample.Data
{
    public class CookingContext : DbContext
    {
        public CookingContext(DbContextOptions<CookingContext> options) : base(options)
        {
        }

        public DbSet<Recipe> Recipe { get; set; }
        public DbSet<Ingredient> Ingredient { get; set; }
        public DbSet<RecipeIngredient> RecipeIngredient { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Recipe>().ToTable("tblRecipe");
            modelBuilder.Entity<Ingredient>().ToTable("tblIngredient");
            modelBuilder.Entity<RecipeIngredient>().ToTable("tblRecipeIngredient ");
        }
    }
}
```

## Register CookingContext as service in Startup.cs

Register the CookingContext as a service in Startup.cs using dependency
injection where the ConfigureServices method is. You can do that by
adding this code to the method. Go to Startup.cs now.

```
services.AddDbContext<CookingContext>(options =>
options.UseSqlServer(Configuration.GetConnectionString("DefaultConnection")));                                     
```                                        

Now add these statements to the startup file.

```
using DTEditorLeftJoinSample.Data;
using Microsoft.EntityFrameworkCore;
```                                        

## Create data seed

Now we want to seed the database with test data. This is an optional
step but highly beneficial. If it does not work for you, the data can be
entered manually. In the Data folder create this file DbInitializer.cs
and insert this code.

```
using DTEditorLeftJoinSample.Models;
using System;
using System.Linq;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;

namespace DTEditorLeftJoinSample.Data
{
    public static class DbInitializer
    {
        public static void Initialize(CookingContext context)
        {
            context.Database.EnsureCreated();

            // Look for any tables.
            if (context.Recipe.Any() && context.Ingredient.Any() && context.RecipeIngredient.Any())
            {
                return;   // DB has been seeded
            }

            var recipes = new Recipe[]
            {
                new Recipe { Title =" Korean-Style Steak and Noodles with Kimchi", 
                Description="Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent sed pharetra neque. Curabitur laoreet eu lectus eu tempus. Fusce elementum arcu ut justo tincidunt mattis.", 
                Direction="1.Cras dignissim in neque a placerat." + "\r\n" + "2.Vestibulum vel vestibulum nunc." + "\r\n" +  "3. Vestibulum interdum est tellus, nec porta metus dignissim ut." 
                },
                new Recipe { Title =" Mashed Potatoes with Savory Thyme Granola", 
                Description=" Etiam aliquam, magna quis lobortis facilisis, lorem eros dignissim nulla, ultrices pulvinar orci lectus a ligula.", 
                Direction="1. Morbi fringilla, justo eu venenatis tempus, mauris leo ultricies magna, et aliquet mi lectus at nisi. Pellentesque vel gravida nunc. Donec in tortor lectus." + "\r\n" + "2.Vestibulum vel vestibulum nunc." + "\r\n" +  "3. Vestibulum interdum est tellus, nec porta metus dignissim ut."},
                new Recipe { Title ="Lemon Garlic Mashed Potatoes", 
                Description="Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.", 
                Direction="1. Maecenas ultricies pretium quam id placerat. Mauris in ligula gravida, vehicula justo faucibus, semper neque." + "\r\n" + "2. Proin sodales aliquam erat quis venenatis." + "\r\n" +  "3. Morbi consectetur libero id sagittis vestibulum."},
                new Recipe { Title =" Sour Cream and Corn Mashers", 
                Description=" Donec posuere pellentesque mi, ac suscipit tellus finibus id.", 
                Direction="1. Nulla placerat erat lorem, eget pellentesque dolor egestas vitae." + "\r\n" + "2. Proin sodales aliquam erat quis venenatis." + "\r\n" +  "3. Suspendisse ac purus lacinia, mollis velit aliquet, finibus arcu. Pellentesque molestie est in diam pulvinar, quis mattis justo volutpat."}
                            };
            foreach (Recipe r in recipes)
            {
                context.Recipe.AddRange(r);
            }
            context.SaveChanges();

            var ingredients = new Ingredient[]
            {
                new Ingredient{IngredientName="Duis eu ligula felis"},
                new Ingredient{IngredientName="Donec id mollis arcu"},
                new Ingredient{IngredientName="Cras nec enim luctus"}
            };
            foreach (Ingredient i in ingredients)
            {
                context.Ingredient.AddRange(i);
            }
            context.SaveChanges();

            var recipeIngredients = new RecipeIngredient[]
            {
                new RecipeIngredient{RecipeID=1, IngredientID=1, Quantity =4},
                new RecipeIngredient{RecipeID=2, IngredientID=2, Quantity =3},
                new RecipeIngredient{RecipeID=3, IngredientID=3, Quantity =15}
            };
            
            foreach (RecipeIngredient ri in recipeIngredients)
            {
                context.RecipeIngredient.AddRange(ri);
            }
            context.SaveChanges();             
        }
    }
}                                                                               
```                                        

We want to get the database context instance from dependency injection
container.

## Call context and seed method and register factory for DataTables

Now we call the context instance, the seed method and pass it to the 
context. Then dispose the context when the seeding is complete. In
**Program.cs** delete any code in the `Main` method and add this all to the method.

## Program.cs

```
public static void Main(string[] args)
{

    var host = CreateHostBuilder(args).Build();
        using (var scope = host.Services.CreateScope())
    {
        var services = scope.ServiceProvider;
        try
        {
            var context = services.GetRequiredService<CookingContext>();
            DbInitializer.Initialize(context);
        }
        catch (Exception ex)
        {
            var logger = services.GetRequiredService<ILogger<Program>>();
            logger.LogError(ex, "An error occurred while seeding the database.");
        }
    }
    host.Run();
}
```

Now add these statements

```
using DTEditorLeftJoinSample.Data;
using Microsoft.Extensions.DependencyInjection;
                                    
```

## Generate controllers and views with scaffolding engine

The scafolding engine on Windows CLI 3.1 Core still has problems so we will have to use Visual Studio's GUI to access the scaffolding engine and generate the items.




