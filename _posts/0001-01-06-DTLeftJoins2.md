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

## DbInitializer

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

## Call context and seed method

Now we call the context instance, the seed method and pass it to the
context. Then dispose the context when the seeding is complete. In
**Program.cs** delete any code in the `Main` method and add this all to
the method.

## Program.cs

```
public static void Main(string[] args)
{
    DbProviderFactories.RegisterFactory("System.Data.SqlClient", SqlClientFactory.Instance);

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

You could write all the views in DataTables but it is easier to first
auto generate all the CRUD view pages and controllers using Entity
Framework Core from the models we made and edit the pages later. We will
generate in the scaffolding engine.

The scafolding engine on Windows CLI 3.1 Core still has problems so if this command...

`dotnet aspnet-codegenerator controller -name IngredientController -m Ingredient -dc CookingContext -outDir Controllers`

Does not work for you like it didn't for me and results in this error: 
`No code generators found with the name 'controller'
   at Microsoft.VisualStudio.Web.CodeGeneration.CodeGeneratorsLocator.GetCodeGenerator(String codeGeneratorName)`

Then it would mean you need to generate the controller and views in Visual Studio which works easier. However because the interface is harder to navigate, cumbersome and because we are not using Visual Studio and I don't want to put you through more pain, how about I just give you the Controller code instead so you can use it to generate the Views. Just incase that
command doesn't work. 

Create a new  `RecipeIngredientsController.cs` in the Controllers folder and add this code.  

```
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using DTEditorLeftJoinSample.Data;
using DTEditorLeftJoinSample.Models;
using DataTables;
using Microsoft.Extensions.Configuration;

namespace DTEditorLeftJoinSample.Controllers
{
    public class RecipeIngredientsController : Controller
    {
        private readonly CookingContext _context;


        private readonly IConfiguration _config;

        public RecipeIngredientsController(CookingContext context, IConfiguration config)
        {
            _context = context;
            _config = config;
        }

        // GET: RecipeIngredients
        public IActionResult Index()
        {
            return View();
        }

        public IActionResult LeftJoinRecipesAndIngredientsOntoRecipeIngredient()
        {
            //DECLARE database connection.
            string connectionString = _config.GetConnectionString("DefaultConnection");
            //CREATE debatable instance.
            using (var db = new Database("sqlserver", connectionString))
            {
                //CREATE Editor instance with starting table.
                var response = new Editor(db, "tblRecipeIngredient")
                    .Field(new Field("tblRecipeIngredient.Quantity"))
                    .Field(new Field("tblRecipe.Description"))                     
                    .Field(new Field("tblIngredient.IngredientName"))
                     //JOIN from tblIngredient column RecipeID linked from tblRecipe column ID
                    //and IngredientID linked from tblUser column ID.                    
                    .LeftJoin("tblRecipe ", " tblRecipe.ID ", "=", " tblRecipeIngredient.RecipeID")
                    .LeftJoin("tblIngredient ", " tblIngredient.ID ", "=", " tblRecipeIngredient.IngredientID")
                    .Process(HttpContext.Request)
                    .Data();
                return Json(response);
            }
        }


        // GET: RecipeIngredients/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var recipeIngredient = await _context.RecipeIngredient
                .Include(r => r.Ingredient)
                .Include(r => r.Recipe)
                .FirstOrDefaultAsync(m => m.ID == id);
            if (recipeIngredient == null)
            {
                return NotFound();
            }

            return View(recipeIngredient);
        }

        // GET: RecipeIngredients/Create
        public IActionResult Create()
        {
            ViewData["IngredientID"] = new SelectList(_context.Ingredient, "ID", "ID");
            ViewData["RecipeID"] = new SelectList(_context.Recipe, "ID", "ID");
            return View();
        }

        // POST: RecipeIngredients/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("ID,RecipeID,IngredientID,Quantity")] RecipeIngredient recipeIngredient)
        {
            if (ModelState.IsValid)
            {
                _context.Add(recipeIngredient);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            ViewData["IngredientID"] = new SelectList(_context.Ingredient, "ID", "ID", recipeIngredient.IngredientID);
            ViewData["RecipeID"] = new SelectList(_context.Recipe, "ID", "ID", recipeIngredient.RecipeID);
            return View(recipeIngredient);
        }

        // GET: RecipeIngredients/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var recipeIngredient = await _context.RecipeIngredient.FindAsync(id);
            if (recipeIngredient == null)
            {
                return NotFound();
            }
            ViewData["IngredientID"] = new SelectList(_context.Ingredient, "ID", "ID", recipeIngredient.IngredientID);
            ViewData["RecipeID"] = new SelectList(_context.Recipe, "ID", "ID", recipeIngredient.RecipeID);
            return View(recipeIngredient);
        }

        // POST: RecipeIngredients/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("ID,RecipeID,IngredientID,Quantity")] RecipeIngredient recipeIngredient)
        {
            if (id != recipeIngredient.ID)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(recipeIngredient);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!RecipeIngredientExists(recipeIngredient.ID))
                    {
                        return NotFound();
                    }
                    else
                    {
                        throw;
                    }
                }
                return RedirectToAction(nameof(Index));
            }
            ViewData["IngredientID"] = new SelectList(_context.Ingredient, "ID", "ID", recipeIngredient.IngredientID);
            ViewData["RecipeID"] = new SelectList(_context.Recipe, "ID", "ID", recipeIngredient.RecipeID);
            return View(recipeIngredient);
        }

        // GET: RecipeIngredients/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var recipeIngredient = await _context.RecipeIngredient
                .Include(r => r.Ingredient)
                .Include(r => r.Recipe)
                .FirstOrDefaultAsync(m => m.ID == id);
            if (recipeIngredient == null)
            {
                return NotFound();
            }

            return View(recipeIngredient);
        }

        // POST: RecipeIngredients/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var recipeIngredient = await _context.RecipeIngredient.FindAsync(id);
            _context.RecipeIngredient.Remove(recipeIngredient);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool RecipeIngredientExists(int id)
        {
            return _context.RecipeIngredient.Any(e => e.ID == id);
        }
    }
}
```

