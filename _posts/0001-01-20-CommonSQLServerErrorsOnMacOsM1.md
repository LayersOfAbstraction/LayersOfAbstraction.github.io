---
layout: post
title:  "Common errors when connecting an SQL Server Docker container to a .NET application on MacOS M1"
date: "2023-03-31"
published: false
---

Some errors in SQL Server are clear enough. Abstract that from a Docker Container and suddenly it's a whole new layer of complexity.

Is the docker image compatible?
Is my connection string off?
Does Mac m1 not like SQL Server even in Docker?
Am I even using the correct image.

I will explain some of them and what they could mean so you can improve your problem solving skills.

```dotnetcli
A network-related or instance-specific error occurred while establishing a connection to SQL Server. The server was not found or was not accessible. Verify that the instance name is correct and that SQL Server is configured to allow remote connections. (provider: TCP Provider, error: 40 - Could not open a connection to SQL Server: Could not open a connection to SQL Server)
```

This can be a result of you not having the container running in the backend. To check it is running, use the following command: 

```dotnetcli
CONTAINER ID   IMAGE                              COMMAND                  CREATED       STATUS                           PORTS      NAMES
172708f67480   mcr.microsoft.com/azure-sql-edge   "/opt/mssql/bin/perm…"   13 days ago   Exited (255) About an hour ago   1401/tcp, 0.0.0.0:1433->1433/tcp   sql
```

The image doesn't support ARM64.


To fix that see this awesome post by Maarten Merken