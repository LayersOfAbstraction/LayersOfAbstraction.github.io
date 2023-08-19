---
layout: post
title:  "How to migrate an SQL Server Database to a Docker Container."
date: "2023-07-13"
published: false
---

## Introduction:

Every time I had to reformat my computer over the years and re-install SQL Server I felt I was putting in more on my disk then I needed. I also got bogged down with having to keep track of which version of SQL Server I had installed previously. 

Docker simplifies this also as I plan on migrating my databases to the cloud. I also want to make it easy to have all dependencies self contained and portable in case I decide it is not worth keeping my database up there just for a pet project.

There a few issues I will address that can happen after migration.

## Copying a SQL Server Database to a Docker Container

If you are on Windows and don't know how to create a container for an SQL Server image I highly suggest you [go here](https://www.yogihosting.com/docker-aspnet-core-sql-server-crud/). Else if you are running the docker container from an Apple computer with an M1 chip, I highly recommend you [go here](https://medium.com/geekculture/docker-express-running-a-local-sql-server-on-your-m1-mac-8bbc22c49dc9)

Once you have created the container, it is time to port the database to it. This is the command to do it.

```dotnetcli
docker cp 'C:\Users\Jordan Nash\Pitcher8.mdf' efa4a1650823:/var/opt/mssql/data
``````

The first value would be the path we are copying our database from. In this case it is on a local windows file system. Where's efa4a1650823 is the Container ID.

After the colon character is the SQL Server container path where the database will be written to. If you don't know the container ID, simply run the command `docker ps -a`.

## Troubleshooting Read-Only Issues in a SQL Server account

When you open your database in a SQL Server client like Azure Data Studio, SQL Management Studio, Visual Studio etc you'll notice 

According to this awesome blog by [Anthony Nocentino](https://www.nocentino.com/posts/2021-09-25-container-file-permissions-and-sql/) user accounts and groups on the base OS likely don’t sync up with the user accounts and groups inside the container. 

