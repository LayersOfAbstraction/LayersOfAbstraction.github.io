---
layout: post
title: "Assigning Users In ASP.NET Core MVC 6 with DataTables Editor PART 2"
published: false
---

Earlier I showed you [how to set up your ASP.NET Core project for basic CRUD operations. Now we will customize the UI to use DataTables Editor]({% link _posts/0001-01-09-DTLeftJoins3.md %}) Let 

# Install DataTables #

We will have to edit the index and install DataTables Editor server-side
libraries to render the related fields from another table. Enter this
into the Package Management Console.

`dotnet add package DataTables-Editor-Server`

Our priority is to activate DataTables Editor in the backend controller
and then write the code to link the View up to our controller. Remember
the backend will use DataTables Editor server-side libraries which are
free.

The front-end DataTables Editor libraries are not free so we won't use
that. The front end will instead use DataTables which is also free and
is compatible with EF Core as long as you aren't rendering foreign keys.

We need to install DataTables too. There are two ways of doing that.

## OPTION 1 host it from DataTables CDN ##

We reference the javascript and css libraries from DataTables Content
Delivery Network. Add the following code to the head in our
_Layout.cshtml file.

```html
<link rel="stylesheet" href="//cdn.datatables.net/1.10.22/css/jquery.dataTables.min.css"/>
```

Go ahead and add this under the footer in the body with all the other
scripts. Make sure you load it AFTER any jquery libraries you have in your project.

```html
<script type="text/javascript" charset="utf8" src="//cdn.datatables.net/1.10.22/js/jquery.dataTables.js"></script>
```

## OPTION 2 Local download ##

The other way is by doing a local download which can be useful should you need everthing to run offline during a demo where you want to convince your team or boss to use it and present it in a prototype so you could get the funding to use the client side libraries eventually.

Make sure you declare the following code in the head of our ``_Layout.cshtml`` file. Add this in the ``head`` tag.

```html

<link rel="stylesheet" href="//cdn.datatables.net/1.10.22/css/jquery.dataTables.min.css"/>
```

Go ahead and add this under the footer in the body with all the other
scripts. Make sure you load it AFTER any jquery libraries you have in your project.

```html
<script src="~/lib/datatables/js/jquery.dataTables.min.js"></script>
<script src="~/lib/datatables/js/dataTables.bootstrap4.min.js"></script>
```

I will show you the two options in regard to local download. If you want the easiest download, you can just use option 2.1 and skip the next option.

### OPTION 2.1 Go to Library Manager (LibMan) to install DataTables ###

We can use Visual Studio's built in library acquisition tool (LibMan)
to download DataTables. We will do that now.

1. Go to Project in Solution explorer.
2. Right Click Project and select Add.
3. Select Client-Side Library.
4. In the new windows Do not change provider and leave as cdnjs.
5. Type into the "Library" field, ``datatables@1.10.21`` unless
a later value is available.

The files will be aquried through LibMan and delivered through a CDN(Conent Delivery Network) to your local system at which point they can be used locally, and offline.

<img src="../images/DTLeftJoins3/Use_(LibMan)_to_install_DataTables.gif" class="image fit" alt="Use LibMan to install DT"/>

### OPTION 2.2 Go to website to download and install files ###

We can download the library from here to go [here to download the files.](https://datatables.net/download/) and leave the defaults. There should be steps on what to do.

## Call database directly from Program or Startup ##

Now we will need to bypass our RecipeIngredient model to later bind our controller directly to the database using 

``DbProviderFactories.RegisterFactory``. Remember you can't use entity framework with DataTables Editor server-side libraries unless you edit the controller to bypass our dependency injection models and hardcode the database tables directly from SQL Server.

To avoid all that you would have to pay for the clientside libraries so instead we just have to break a few MVC rules to use DataTables Editor for free.

 Enter this into Program.cs.

```csharp
// Register the factory in the method `Main`
DbProviderFactories.RegisterFactory("System.Data.SqlClient", SqlClientFactory.Instance);
```

## Bypass model and hardcode tblRecipeIngredient from controller ##

We have declare that we are using DataTables in the application. Go to our ``Data/GlobalNamespaces.cs`` folder and add this.

```csharp
global using DataTables;
```

Then go to your our RecipeIngredient controller.

Now and add this method.

```csharp
public ActionResult LeftJoinRecipesAndIngredientsOntoRecipeIngredient()
{
    //DECLARE database connection.
    string connectionString = _config.GetConnectionString("DefaultConnection");

    //CREATE database instance.
    using (var db = new Database("sqlserver", connectionString))
    {
        //CREATE Editor instance with starting table.
        var response = new Editor(db, "tblRecipeIngredient")
            .Field(new Field("tblRecipeIngredient.Quantity"))
            .Field(new Field("tblRecipe.Title"))
            .Field(new Field("tblIngredient.IngredientName"))

            //JOIN from tblIngredient column RecipeID linked from tblRecipe column ID
            //AND IngredientID linked from tblIngredient column ID.  
            .LeftJoin("tblRecipe ", " tblRecipe.ID ", "=", " tblRecipeIngredient.RecipeID")
            .LeftJoin("tblIngredient ", " tblIngredient.ID ", "=", " tblRecipeIngredient.IngredientID")
            .Process(HttpContext.Request)
            .Data();
        return Json(response);
    }
}
```

Add an IConfiguration object to get the connection string and make sure it's value is set in the constructor.

I will break it down for you with comments. As you can see I am breaking MVC traditions here and instead are connecting  the database directly from this method.

Make sure your RecipeIngredientsController constructor matches mine and make sure your
Index method matches! It will look different.

```csharp
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

public ActionResult LeftJoinRecipesAndIngredientsOntoRecipeIngredient()
{
    //DECLARE database connection.
    string connectionString = _config.GetConnectionString("DefaultConnection");

    //CREATE database instance.
    using (var db = new Database("sqlserver", connectionString))
    {
        //CREATE Editor instance with starting table.
        var response = new Editor(db, "tblRecipeIngredient")
            .Field(new Field("tblRecipeIngredient.Quantity"))
            .Field(new Field("tblRecipe.Title"))
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
```

Most of the comments should explain what is happening. I am specifying a
single table for editing with additional optional data inserted into the
table from other tables. i.e I am joining up tables to
tblRecipeIngredient by performing an SQL Left Join and then formatting
it into a json object which will be passed to the front end. Notice I am
creating a DataTables Editor server instance which is free. The front
end ones however are not so we will have to use DataTables to fix that
in the front-end.

With the back end code complete let's go to our front end.

## Rewrite view Index in DataTables ##

Go to this directory Views\\RecipeIngredients\\ and look at the code now
in the Index.cshtml.

```html
@model IEnumerable<DTEditorLeftJoinSample.Models.RecipeIngredient>
@{
    ViewData["Title"] = "Index";
}

<h1>Index</h1>

<p>
    <a asp-action="Create">Create New</a>
</p>
<table class="table">
    <thead>
        <tr>
            <th>
                @Html.DisplayNameFor(model => model.Quantity)
            </th>
            <th>
                @Html.DisplayNameFor(model => model.Recipe)
            </th>
            <th>
                @Html.DisplayNameFor(model => model.Ingredient)
            </th>
            <th></th>
        </tr>
    </thead>
    <tbody>
@foreach (var item in Model) {
        <tr>
            <td>
                @Html.DisplayFor(modelItem => item.Quantity)
            </td>
            <td>
                @Html.DisplayFor(modelItem => item.Recipe.ID)
            </td>
            <td>
                @Html.DisplayFor(modelItem => item.Ingredient.ID)
            </td>
            <td>
                <a asp-action="Edit" asp-route-id="@item.ID">Edit</a> |
                <a asp-action="Details" asp-route-id="@item.ID">Details</a> |
                <a asp-action="Delete" asp-route-id="@item.ID">Delete</a>
            </td>
        </tr>
}
    </tbody>
</table>
```

We are going to edit most of this. So change the model title to this.

```html
@model DTEditorLeftJoinSample.Models.RecipeIngredient
```

Now change the html table class value “table” to the ID value of recipeIngredientTable.

```html
<table id="RecipeIngredientTable" class="table thead-light table-bordered dt-responsive">
```

Erase all the code in the tbody tag so it looks like this.

```html
<tbody></tbody>
```

Now add all this just under the outside of the closing **</table>** tag. We
will break it down as much as possible.

```html
@section scripts{
    <script>
    $.fn.dataTable.ext.errMode = 'throw';
    function renderDT_RowId(data) {
        return data.replace('row_', '');
    };
    var oTable = $('#recipeIngredientTable').DataTable({
        "ajax": {
            type: "POST",
            "url": "@Url.Action("LeftJoinRecipesAndIngredientsOntoRecipeIngredient")"
        },
        "columns": [
             "data": "tblRecipe.Title"},
            { "data": "tblIngredient.IngredientName"},
            { "data": "tblRecipeIngredient.Quantity" },
            {
                "data": null,
                "render": function (value) {
                    return '<a href="/RecipeIngredients/Details/' + renderDT_RowId(value.dT_RowId) + '"button type="button" class="btn btn-primary btn-block">Details</a> <br> '
                        + '<a href="/RecipeIngredients/Edit/' + renderDT_RowId(value.dT_RowId) + '"button type="button" class="btn btn-info btn-block">Edit </a> <br> '
                        + '<a href="/RecipeIngredients/Delete/' + renderDT_RowId(value.dT_RowId) + '"button type="button" class="btn btn-primary btn-block">Delete</a>';
                }
            }
            ]
    });
    </script>
}
```

The oTable object contains the ID of our table header which is more
maintainable. We can link the header up with the rest of our oTable
object. Below that we are making an ajax request to get the name of our
controller method which will display all the data we specified in the
backend controller.

When we fire up the program we should be able to tell if our backend is
communicating with our frontend.

We need the primary key value so ASP knows which record to request from our database when we
perform CRUD operations. Notice the renderDT_RowId method where I am
calling the buttons that link to the other views Details, Edit and
Delete.

```csharp
renderDT_RowId(value.DT_RowId)
```

That will store each PK value in RAM which also allows us to render the
records.

Now your entire Index.cshtml view should look like this.

```html
@model DTEditorLeftJoinSample.Models.RecipeIngredient
@{
    ViewData["Title"] = "Index";
}

<h1>Index</h1>

<p>
    <a asp-action="Create">Create New</a>
</p>
<table id="recipeIngredientTable" class="table thead-light table-bordered dt-responsive">
    <thead>
        <tr>
            <th>
                @Html.DisplayNameFor(model => model.Recipe)
            </th>
            <th>
                @Html.DisplayNameFor(model => model.Ingredient)
            </th>
            <th>
                @Html.DisplayNameFor(model => model.Quantity)
            </th>
            <th></th>
        </tr>
    </thead>
    <tbody></tbody>
</table>
@section scripts{
    <script>
    function renderDT_RowId(data) {
        return data.replace('row_', '');
    };
    var oTable = $('#recipeIngredientTable').DataTable({
        "ajax": {
            type: "POST",
            "url": "@Url.Action("LeftJoinRecipesAndIngredientsOntoRecipeIngredient")",
            "dataSrc": function (result) {
                return result.data;
                }
        },
        "columns": [
            { "data": "tblRecipe.Title" },
            { "data": "tblIngredient.IngredientName"},
            { "data": "tblRecipeIngredient.Quantity" },
            { "data": null,
                "render": function (value) {
                    return '<a href="/RecipeIngredients/Details/' + renderDT_RowId(value.DT_RowId) + '"button type="button" class="btn btn-primary btn-block">Details</a> <br> '
                        + '<a href="/RecipeIngredients/Edit/' + renderDT_RowId(value.DT_RowId) + '"button type="button" class="btn btn-info btn-block">Edit </a> <br> '
                        + '<a href="/RecipeIngredients/Delete/' + renderDT_RowId(value.DT_RowId) + '"button type="button" class="btn btn-primary btn-block">Delete</a>';
                }
            }
            ]
    });
    </script>
}
```

## Run it one last time and enjoy 😊 ##

Run your program now and go to the Index. It should work perfectly. You
can see the power and functionality that DataTables brings. As you can
see it has sorting searching and if you put in more records you will
even be able to divide it up into multiple pages and decide how many get
shown.

If we did that all in Entity Framework Core the code required would be
substantially longer and give us nowhere as much functionality.

<img src="../images/DTLeftJoins/demo5.gif" class="image fit" alt="demo5"/>