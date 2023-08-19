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
docker cp 'C:\Users\Jordan Nash\Pitcher8.mdf' efa4a1650823:/var/opt/mssql/data'
``````

the first value would be the path we are copying it from where's efa4a1650823 can be the Container ID. 