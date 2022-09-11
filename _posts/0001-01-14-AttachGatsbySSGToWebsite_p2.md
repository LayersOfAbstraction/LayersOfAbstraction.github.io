---
title: "How to turn your web portfolio into personal blogging website with Gatsby part 2"
date: "2022-05-28"
#published: false
layout: post
---

## Introduction ##

In the previous blog we learned how to convert a website from HTML with css to React. The only thing we didn't do was render the Sidebar and the logo.

- In this tutorial you will recreate the sidebar in Gatsby and isolate it into a separate styled-component complete with it's own css styles.
- Learn to share data bettween components.
- You will see how great React styled-components are for UI design as they are lowly coupled and highly cohesive. Making them more reusable.
- To do this you will have to install styled-components and Gatsby which you should have done in the previous Blog.
- Why Should you bother? Well you might want to change your site to use a blogging framework that will make you better at one of the most widely available technologies on the jobs market.

## Sorry no jQuery ##

jQuery does not know of React's existence so it can cause conflicts as jquery manipulates the DOM directly while React is more loosely coupled. We have to this time reinvent the while with the sidebar as it was written with jQuery. Besides we can use it again later.

I cannot take full credit for...

## Link the minimized Navbar button and Home button ##

We will have to link the blog on top right and navbar.
