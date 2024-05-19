---
layout: post
title:  "Migrate from ASP.NET Core MVC 3.0 to 3.1"
---

[_NOTE: This is a continuation of our previous post_]({% link _posts/0001-01-01-migration-from-.NET-Core-2.2-to-3.0.md  %}) that showed us how to convert our ASP.NET MVC Core 2.2 application to 3.0. As 3.0 is not supported any longer we must upgrade the framework to 3.1 which still has LTS.

## Download my project or continue with the one you made from the previous blog. ##

In the last blog I have already shown how you can create a new ASP.NET Core MVC app by version. Here you can just [download my 3.0 demo](https://github.com/LayersOfAbstraction/2.2_to_3.0_migration_project) (migrated from 2.2) and use that as a template.

Again just like the previous blog, we're going to use the KISS principle (Keep it Simple Stupid) or as I like to say (Keep It Stupid Simple). So we're just focusing on getting it up and running in 3.1. Nothing fancy.

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

## Update current framework to .NET Core 3.1 ##

Ok so change 2.2_to_3.0_migration_project.csproj from this..

```
<Project Sdk="Microsoft.NET.Sdk.Web">

  <PropertyGroup>
    <TargetFramework>netcoreapp3.0</TargetFramework>
    <AddRazorSupportForMvc>true</AddRazorSupportForMvc>
  </PropertyGroup>

  <ItemGroup>
    <PackageReference Include="Microsoft.AspNetCore.Diagnostics.EntityFrameworkCore" Version="3.0.0" />
    <PackageReference Include="Microsoft.AspNetCore.Identity.EntityFrameworkCore" Version="3.0.0" />
    <PackageReference Include="Microsoft.AspNetCore.Identity.UI" Version="3.0.0" />
    <PackageReference Include="Microsoft.AspNetCore.Mvc.NewtonsoftJson" Version="3.0.0" />
    <PackageReference Include="Microsoft.EntityFrameworkCore.SqlServer" Version="3.0.0" />
    <PackageReference Include="Microsoft.EntityFrameworkCore.Tools" Version="3.0.0" />
  </ItemGroup>

</Project>
```
To this.

```
<Project Sdk="Microsoft.NET.Sdk.Web">

  <PropertyGroup>
    <TargetFramework>netcoreapp3.1</TargetFramework>
    <AddRazorSupportForMvc>true</AddRazorSupportForMvc>
  </PropertyGroup>

  <ItemGroup>
    <PackageReference Include="Microsoft.AspNetCore.Diagnostics.EntityFrameworkCore" Version="3.1.1" />
    <PackageReference Include="Microsoft.AspNetCore.Identity.EntityFrameworkCore" Version="3.1.1" />
    <PackageReference Include="Microsoft.AspNetCore.Identity.UI" Version="3.1.1" />
    <PackageReference Include="Microsoft.AspNetCore.Mvc.NewtonsoftJson" Version="3.1.1" />
    <PackageReference Include="Microsoft.AspNetCore.Mvc.Razor.RuntimeCompilation" Version="3.1.1" Condition="'$(Configuration)' == 'Debug'" />
    <PackageReference Include="Microsoft.EntityFrameworkCore.SqlServer" Version="3.1.1" />
    <PackageReference Include="Microsoft.EntityFrameworkCore.Tools" Version="3.1.1" />
  </ItemGroup>

</Project>
```

Interestingly enough in ASP.NET Core 3.0 they (Microsoft) advise you to use NewtonsoftJson again. As the majority of users preferred it over the later version known as System.Text.Json. Use `dotnet watch run` and check the localhost url. If it runs in Chrome then you should have successfully ported the project from 3.0 to 3.1. Nice work.

Again I have a [completed demo of this project](https://github.com/LayersOfAbstraction/3.0_to_3.1_migration_project) I converted myself from 3.0 to 3.1 so if you got problems you can look at it. 

Hopefully this will serve as the groundwork for you to port more complex projects over to 3.1!