---
layout: post
title:  "How to securely connect from any OS to your AWS EC2 instance."
date: "2023-09-21"
published: false
---

## Introduction

![teal LED panel image](../images/0001-01-25/adi-goldstein-EUsVwEOsblE-unsplash%20(1).jpg)
>_Photo by <a href="https://unsplash.com/@adigold1?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Adi Goldstein</a> on <a href="https://unsplash.com/photos/EUsVwEOsblE?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>_
  
Let's be honest. The documentation for setting up and connecting to an EC2 instance is pretty confusing. But it doesn't have to be. And you can save money in process and even improve your quality of life if you work on more than one computer. 

## Why would you even want to do this?

1. If you work in an organization and work with a database. It's going to be harder to version control that database if you have it stored in a shared folder like Dropbox. That been said you still need to copy down the version of the database. 

2. The more your application is developed in the cloud the less dependencies your team have to manually install to debug. 
   
3. It will enhance your quality of life and allow you to get outside more on your laptop without having to keep track of relational databases on two different computers, (if you use more than one computer). Rather you may want to go out to a coffee shop/library during the day and do CRUD operations on the database from there.  

## Don't use AWS CLI

Absolutely no need for that. What we can use instead is **EC2 Instance Connect** from their dashboard and **Open SSH** from the command line. 

The only thing you need to ensure is you save a key pair you created with your instance on your local computer. 

If you haven't and have already created your instance then sorry you need to make a new one and do this from the start. 

It's the only way to securely connect from your OS without having to use some Windows GUI stuff like PuTTY since I assume you're on Windows. If not it doesn't matter as Open SSH is platform independent.

## Setting up your instance

Once you've set up your AWS account go into sign in.