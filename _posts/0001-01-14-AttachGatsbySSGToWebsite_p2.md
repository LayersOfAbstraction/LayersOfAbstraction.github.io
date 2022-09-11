---
title: "How to turn your web portfolio into personal blogging website with Gatsby part 2"
date: "2022-05-28"
published: false
layout: post
---

## Introduction ##

In the previous blog we learned how to convert a website from HTML with css to React. The only thing we didn't do was render the Sidebar and the logo.

- In this tutorial you will recreate the sidebar in Gatsby and isolate it into a separate styled-component complete with it's own css styles.
- Learn to share data bettween components.
- You will see how great React styled-components are for UI design as they are lowly coupled and highly cohesive. Making them more reusable.
- To do this you will have to install styled-components and Gatsby which you should have done in the previous Blog.
- Why Should you bother? Well you will be creating your own UI components which you could put online for other people to use such as people in your project team.

## Sorry no jQuery ##

jQuery does not know of React's existence so it can cause conflicts as jquery manipulates the DOM directly while React is more loosely coupled. We have to this time reinvent the while with the sidebar as it was written with jQuery. Besides we can use it again later.

I cannot take full credit for how to create the sidebar. I learned how to do it here but had to adjust a few properties and colours that were not present [in the tutorial.](https://www.youtube.com/watch?v=6cb56Luubd4)

When we open the red encircled hamburger icon and open it we want to open the headings on the page so we can go back to other pages.
  
We want that to appear as well in the white section at the top if the screen is not minimized. You can't see the white space where I have encircled it but if you were to fully maximize the web page, you would see it.

<img src="../images/AttachGatsbySSGToWebsite/Screen%20Shot%202022-06-01%20at%209.36.28%20pm.png" class="image fit" alt="Image showing we will have link to blog on top right and nav bar"/><br>

## Link the minimized Navbar button and Home button ##

We will have to link the blog on top right and navbar.
