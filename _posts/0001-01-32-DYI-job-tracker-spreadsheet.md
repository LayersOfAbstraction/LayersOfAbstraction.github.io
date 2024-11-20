---
layout: post
title: DYI job tracker with AutoHotkey macros
subtitle: "Striking the Hydra's heart"
date: "2024-09-22"
published: false
---

## Introduction

<img src="../images/0001-01-31/russian_house.png" class="image fit" alt="Russian House"/>

Disclaimer: This is only for people using Windows. The frustration of "messing up" in a job search 
is too real. Often it is probably not your fault. Only you have several you want to apply for in 
several job boards "Linked In", "Glassdoor" and "Indeed".
How does one keep track?? 

Excel? Well spreadsheets are something many organizations move a way from but for your 
own job search, why not?

Automation. Sometimes you want to hyperlink your tailored resume/cover letter for each job 
and not have applied for and navigate through less folders to simply do that. 
You could use a Visual Basic macro but what if you want to do this outside of Excel?

AutoHotkey is the answer. An open source scripting language made with C++. Very easy to implement.
As my Software Development teacher once said "if you are repeatedly doing things several times, 
there is probably a better way to do it."

# What are we learning?

In short we are learning:

- Automation.
- Debugging.
- Logging.

So let's say we are in a directory saying, "job tracker". And underneath that we have several folders for each company say "Google"
and "Amazon" and then under those we have several "job title" folders. What if we had one and were navigating back and forth to 
that folder to make changes. Wouldn't be good if we could make one less click.

So rather than navigating into Google and then it's only subfolder "Staff Software Engineer" what if it just opens it up automatically?
Well AutoHotkey can listen for that on startup. If you're interested, let's see how.

# Create the spreadsheet (optional)

You can skip this if you want to build your own.

## REFERENCES:

