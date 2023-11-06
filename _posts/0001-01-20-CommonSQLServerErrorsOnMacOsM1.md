---
layout: post
title:  "Common errors when connecting an SQL Server Docker container to a .NET application on MacOS M1"
date: "2023-05-29"
published: true
---
<img src="../images/CommonSQLServerErrorsOnMacOsM1/pexels-markus-spiske-225769.jpg" class="image fit" alt="Title image of Matrix like art."/>

> Photo by Markus Spiske from [Pexels](https://www.pexels.com/@markusspiske/)


Some errors in SQL Server are clear enough. In a Docker Container that adds suddenly a whole new layer of complexity.

Is the docker image compatible?
Is my connection string off?
Does Mac m1 not like SQL Server even in Docker?
Am I even using the correct image?

I will explain some of them and what they could mean so you can make sense of these errors.


## You cannot connect to SQL Server ##

```dotnetcli
A network-related or instance-specific error occurred while establishing a connection to SQL Server.

The server was not found or was not accessible. 

Verify that the instance name is correct and that SQL Server is configured to allow remote connections. 

(provider: TCP Provider, error: 40 - Could not open a connection 
to SQL Server: Could not open a connection to SQL Server)
```

This can be a result of you not having the container running in the backend. To check it is running, use the following command: 

```dotnetcli
docker ps -a
```

This will bring up all the containers and their associated ID. As you can see the container we are using was not running.

```dotnetcli
CONTAINER ID   IMAGE                              COMMAND                  CREATED       STATUS                           PORTS      NAMES
172708f67480   mcr.microsoft.com/azure-sql-edge   "/opt/mssql/bin/perm…"   13 days ago   Exited (255) About an hour ago   1401/tcp, 0.0.0.0:1433->1433/tcp   sql
```

It could also be that the image you are using to create the container does not support SQL Server on Mac M1 at all. You may have not finished installing it. This brings me to the next problem.

## The image doesn't support ARM64 ##

You may get this after running the initial docker image.

```dotnetcli
WARNING: The requested image's platform (linux/amd64) does not match the detected host platform (linux/arm64/v8) and no specific platform was requested
```

If you did this successfully on Windows 10 but not MacOS M1 then you likely tried to use the official mssql-server-linux image.

[Some people](https://stackoverflow.com/questions/66662820/m1-docker-preview-and-keycloak-images-platform-linux-amd64-does-not-match-th) suggest appending `--platform linux/amd64` after `docker run`, which did not help for my case.  

What you really want is to use the [Azure SQL Edge image.](https://hub.docker.com/_/microsoft-azure-sql-edge)

This [awesome post](https://medium.com/agilix/docker-express-running-a-local-sql-server-express-204890cff699) by Maarten Merken covers it for Mac OS M1. 

## Login failed for user 'sa' ##

Arrggh, what does that even mean? This means you can access the SQL Server profile but not the actual database. It's not particularly helpful on it's own. Some things you want to do is ensure the connection string matches what's in your database server settings. Make sure they match.

If you use Windows or Mac like I do then Docker Desktop shows some very handy logs. When you open it just go to the following.

Containers -> Your container. After that you will be able to find the error message. 

<img src="../images/CommonSQLServerErrorsOnMacOsM1/WrongPassword.png" class="image fit" alt="Docker Desktop window showing error."/>

In our case it showed in verbatim that our password was wrong.

```
2023-05-29 12:45:28.78 Logon       Login failed for user 'SA'. Reason: Password did not match that for the login provided. [CLIENT: 172.17.0.1]
```
