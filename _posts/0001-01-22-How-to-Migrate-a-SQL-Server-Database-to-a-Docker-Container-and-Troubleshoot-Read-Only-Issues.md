---
layout: post
title:  "How to migrate an SQL Server Database to a Docker Linux Container."
date: "2023-07-13"
published: true
---


![Silicon chip image](images\0001-01-22-How-to-Migrate-a-SQL-Server-Database-to-a-Docker-Container-and-Troubleshoot-Read-Only-Issues\s3___eu-west-1_dlcs-storage_2_8_B0005829.jpg)
>Image by Paul Griggs from <a href="https://wellcomecollection.org/works/fmtyyjd7/images?id=ufknyj7y">The Welcome Collection</a>

# Introduction

Every time I had to reformat my computer over the years and re-install SQL Server I felt I was putting in more on my disk than I needed. I also got bogged down with having to keep track of which version of SQL Server I had installed previously. 

Docker simplifies this also as I plan on migrating my databases to the cloud. I also want to make it easy to have all dependencies self contained and portable in case I decide it is not worth keeping my database up there just for a pet project.

There are a few issues I will address that can happen after migration. 

## Copying an SQL Server Database to a Docker Container

If you are on Windows and don't know how to create a container for an SQL Server image I highly suggest you [go here](https://www.yogihosting.com/docker-aspnet-core-sql-server-crud/). Else if you are running the docker container from an Apple computer with an M1 chip, I highly recommend you [go here](https://medium.com/geekculture/docker-express-running-a-local-sql-server-on-your-m1-mac-8bbc22c49dc9)

Once you have created the container, it is time to port the database to it. This is the command to do it.

```dotnetcli
docker cp 'C:\Users\Jordan Nash\Pitcher8.mdf' efa4a1650823:/var/opt/mssql/data
``````

The first value would be the path we are copying our database from. In this case it is on a local windows file system. Where's efa4a1650823 is the Container ID.

After the colon character is the SQL Server container path where the database will be written to. If you don't know the container ID, simply run the command `docker ps -a`.

## Troubleshooting Read-Only Issues in a SQL Server account

### Step 1. Set read-only to false:

When you open your database in a SQL Server client like Azure Data Studio, SQL Management Studio, Visual Studio etc you'll notice that the database is read only even though it may have had  write access when you originally didn't create/run the database in a container.

<img src="images\0001-01-22-How-to-Migrate-a-SQL-Server-Database-to-a-Docker-Container-and-Troubleshoot-Read-Only-Issues\database_as_read_only.png"  width="500" height="800"/>

If you attempt to right click on the properties and set the "read-only" value to false you will get this error message box in the SQL Server Management Studio for both the attached log file and MDF database file.

```dotnetcli
Alter failed for Database 'Pitcher8'. (Microsoft.SqlServer.Smo) 

ADDITIONAL INFORMATION: An exception occurred while executing a Transact-SQL statement or batch. (Microsoft.SqlServer.ConnectionInfo) 

Unable to open the physical file "/var/opt/mssql/data/Pitcher8.mdf". 
Operating system error 5: "5(Access is denied.)". 
Unable to open the physical file "/var/opt/mssql/data/Pitcher8_log.ldf". 
Operating system error 5: "5(Access is denied.)". 

Could not restart database "Pitcher8". Reverting to the previous status. ALTER DATABASE statement failed. 
(Microsoft SQL Server, Error: 5120) 

For help, click: https://learn.microsoft.com/en-us/sql/relational-databases/errors-events/mssqlserver-5120-database-engine-error?view=sql-server-ver16
```
None of the links really helped in my situation as the database was containerized and there were no related scenarios in that Microsoft article that dealt with containerized databases.

### Step 2. Run `sp_who2` stored procedure:

I tried to run the system stored procedure in the SQL Server query explorer `sp_who2` to find any processes that are messing with the permissions. The command showed an output of all available processes and none of them appeared to be the culprit. 

### Step 3. Run `xp_readerrorlog` stored procedure:

This command contains both system and user-defined event info. When I ran it to see the list of errors I had a lot to look through so I went to what was most recent and found this.

```
2023-08-16 11:45:37.770 spid52 [5]. Feature Status: PVS: 0. CTR: 0. ConcurrentPFSUpdate: 1.
2023-08-16 11:45:37.770 spid52 Starting up database 'Pitcher8'.
2023-08-16 11:45:37.790 spid52 Parallel redo is started for database 'Pitcher8' with worker pool size [8].
2023-08-16 11:45:37.800 spid52 Parallel redo is shutdown for database 'Pitcher8' with worker pool size [8].
2023-08-16 11:45:37.810 spid52 Synchronize Database 'Pitcher8' (5) with Resource Database.
2023-08-16 11:45:37.810 spid52 System objects could not be updated in database 'Pitcher8' because it is read-only.
2023-08-16 11:52:11.150 spid52 Setting database option READ_WRITE to ON for database 'Pitcher8'.

```

Ah, nice try. It told me what I already know though which was not helpful.

### Step 4. Check the permissions that the docker linux container may have assigned to the database:

So I explained my problem in a Microsoft SQL Server community forum. 

Javier gave his 2 cents.

<img src="../images\0001-01-22-How-to-Migrate-a-SQL-Server-Database-to-a-Docker-Container-and-Troubleshoot-Read-Only-Issues\Javier's_two_cents.png" class="image fit" alt="Javier's advice."/>


To simplify things, Javier is saying that this has nothing to do with the database but the account which the database is under. That account in this instance would be the container that generated the account, password, container name, etc.

According to this awesome blog by [Anthony Nocentino](https://www.nocentino.com/posts/2021-09-25-container-file-permissions-and-sql/): 

_The user accounts and groups on the base OS likely don’t sync up with the user accounts and groups inside the container._ 

That never occurred to me so I used one command to display the log and MDF file inside the container:
```
docker exec contai_Pitcher bash -c 'ls -lan /var/opt/mssql/data/Pitcher8*'
```
This was the output. The permissions show it was read-only in the container. It looks like Javier's hunch was right!

```
-rw-r----- 1 501 20 21474836480 Sep 24 14:23 Pitcher8.mdf 
-rw-r----- 1 501 20 1073741824 Sep 24 14:23 Pitcher8_log.ldf
```

It seemed somehow the SQL Server Docker image had assigned the read-only permissions by default!

I fixed that by running these 2 commands which allowed me to finally write to the database:

```
docker exec -u 0 MyContainer bash -c 'chown 10001:0 /var/opt/mssql/data/MyDatabase*'
docker exec -u 0 MyContainer bash -c 'chmod 660 /var/opt/mssql/data/MyDatabase*'
```

This output set the database to be written to and read from.

```
-rw-rw---- 1 mssql root 8388608 Aug 20 09:02 /var/opt/mssql/data/Pitcher8.mdf
-rw-rw---- 1 mssql root 1310720 Aug 20 09:02 /var/opt/mssql/data/Pitcher8_log.ldf
```

What an adventure! Follow me for more developer tricks and tips. I'm off to play the Witcher. Hope this helped!