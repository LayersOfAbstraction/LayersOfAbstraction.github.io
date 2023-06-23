---
title: "Splitting a Gatsby site into communicative reusable components"
date: "2022-05-28"
published: false
layout: post
---

## Introduction ##

In the previous blog we learned how to convert a website from HTML with css to Gatsby. The only thing we didn't do was render the Sidebar and the logo.

- In this tutorial you will recreate the sidebar in Gatsby and isolate it into a separate styled-component complete with it's own css styles.
- Learn to share data between components.
- You will see how great React styled-components are for UI design as they are lowly coupled and highly cohesive. Making them more reusable.
- Why Should you bother? Well you will be creating your own UI components which you could put online for other people to use such as people in your own project team.

## Perquisites ##

-You should already know how to compile Gatsby. If you do not then please see [my previous blog.]({% link _posts/0001-01-13-AttachGatsbySSGToWebsite.md %})
-You should know about CSS especially the difference between internal and external style sheets.
-You should know about HTML DOM.

## Sorry no jQuery ##

jQuery does not know of React's existence so it can cause conflicts as jquery manipulates the DOM directly while React is more loosely coupled. We have to reinvent the wheel with the "sidebar" element as it was written with jQuery. Besides we can use it again later.

I cannot take full credit for how to create the sidebar. Only how to abstract it! I learned how to do it here but had to adjust a few properties and colours that were not present [in the tutorial.](https://www.youtube.com/watch?v=6cb56Luubd4)

When we open the red encircled hamburger icon we want the sidebar to appear with the headings on the page so we can go back to other pages.
  
We want that to appear as well in the white section at the top if the screen is not minimized. You can't see the white space where I have encircled it but if you were to fully maximize the web page, you would see it.

<img src="../images/AttachGatsbySSGToWebsite/Screen%20Shot%202022-06-01%20at%209.36.28%20pm.png" class="image fit" alt="Image showing we will have link to blog on top right and nav bar"/><br>

## Install styled components ##

We will have to link the navbar which you cannot see here as it only appears at full size and the sidebar which is controlled by the hamburger icon on the top right.

Install styled components using this command in your local console

```text
npm install gatsby-plugin-styled-components styled-components babel-plugin-styled-components
```

After that we need to tell our project to explicitly use it in our gatsby-config.js file. If it is not there, you just need to create it in the root of your Gatsby site folder.

```jsx
module.exports = {
    plugins: [`gatsby-plugin-styled-components`],
}
```

## Create the minimized Hamburger button with styled components ##

We are going to create a styled component inside our index.js file.
In your index.js file add this to your imports list.

```jsx
import styled, {createGlobalStyle} from "styled-components"
```
Place this just below your imports. You may find this to be similar to internal CSS styles. We will abstract them later.

Here we are overriding any default styling using the createGlobalStyle component so it will apply any styles from our sidebar to all the pages we use it in. Hope that makes sense?

```jsx
const Global = createGlobalStyle`
  body, html{
    margin: 0;
    padding: 0;
    overflow-x: hidden;
  }
`
```

Now we create the style component Hamburger button. We will call it MenuIcon.

We are fixing it to the page regardless of where user scrolls.
Keep in mind inside MenuIcon we are setting the z-index value at 999 so when the sidebar is toggled open, the hamburger icon will wrap over it.

The first-child is creating the first bar while nth-child(2) and nth-child(2) are the 2nd and third hamburger bars of the icon.

The transform property is holding instructions for the bars to turn into an x shape upon the user clicking it.

```jsx

const MenuIcon = styled.button`
  position: fixed;
  top: 2rem;
  right: 2rem;
  display: flex;
  flex-direction: column;
  justify-content: space-around;
  width: 1.5rem;
  height: 1.5rem;
  background: transparent;
  border: none;
  cursor: pointer;
z-index: 999;

  div {
    width: 1.5rem;
    height: 0.2rem;
    background: white;
    border-radius: 5px;
    transform-origin: 1px;
    position: relative;
    transition: opacity 300ms, transform 300ms;

    :first-child{
      transform: ${({nav}) => (nav ? 'rotate(45deg)': 'rotate(0)')}
    } 
    
    :nth-child(2){
      opacity: ${({nav}) => (nav ? "0" : "1")}
    } 
    
    :nth-child(3){
      transform: ${({nav}) => (nav ? 'rotate(-45deg)': 'rotate(0)')}
    }
  }  
`
```

Make sure it is outside your page component. In the last tutorial it was named the "Home" component.

## Create the menu links in our hamburger button ##

This contains the look and feel of the menu display when we click on the hamburger icon. Important thing to note is we are keeping the
position of the menu fixed!

Else it will not stay fixed on the page when the user scrolls up and down. Also we I have set the value of z-index to 998 so
it can wrap over any other elements on the page.

```jsx


const Menulinks = styled.nav`
  display: flex;
  flex-direction: column;
  justify-content: center;
  text-align: center;
  height: 100vh;
  width: 25%;
  position: fixed;
  transition: 300ms;
  background-color: black;
  top: 0;
  right: 0;
  z-index: 998;
  transform: ${({ nav }) => (nav ? "translateX(0)" : "translateX(100%)")};

  ul{
    list-style-type: none;
  }

  li{
    margin-top: 1rem
  }

   a{
     text-decoration: none; 
     color: white;
     font-size: 1.5rem;
     transition: color 300ms;
   }

  :hover {
    color: #6ab4ff    
  }
`
```

We have now finished the initial style of the styled components! Now we have to declare and export them!

## Declaring and exporting styled components in our sidebar ##

In your page component just under `const Home = () => {` please add the following.

```jsx
const [nav, showNav] = useState(false)
```

now under your jsx "wrapper" tag you should add this. Copy and paste it.

```jsx
<Global />
<MenuIcon nav={nav} onClick={() => showNav(!nav)}>
  {/* Each <div> corresponds to the 3 bars*/}
  <div/>
  <div/>
  <div/>
</MenuIcon>

<Menulinks nav={nav}>
  <ul>
    <Link to="#">Blog</Link>
  </ul>
  <ul>
    <Link to="#">home</Link>
  </ul>
  <h3>Social</h3>
  {/* Sidebar Icon list*/}
  <ul className="icons alt">
    <li><Link to="#" class="icon alt fa-twitter"><span class="label">Twitter</span></Link></li>
    <li><Link to="#" class="icon alt fa-facebook"><span class="label">Facebook</span></Link></li>
    <li><a href="#" class="icon alt fa-instagram"><span class="label">Instagram</span></a></li>
    <li><a href="#" class="icon alt fa-github"><span class="label">GitHub</span></a></li>
  </ul>
</Menulinks> 
```

When you run `gatsby develop` you should see the component appear on the webpage. There should be a hamburger icon on the very top right. It's very important the sidebar remains fixed to the page as you can put a table of contents on it down the track. I will not be doing that however for these tutorials.

## Abstract the component to it's own file ##

In your src folder, create a `Components` folder. Imagine if you had a gaming console with controllers hardwired to it. Wouldn't it be cool if you could have them as a separate component to the console just like with a TV remote control?

Even better what if you could reuse the same wireless gaming controllers for other consoles like at your friends place? That's the great thing with components. We can make the sidebar more portable.

Create a file in the components folder. Call it `sidebar.js`. The code we have created for the sidebar can just be cut and pasted into it. Yep that means all the code in this tutorial from before this heading can be cut and pasted into that file. But what I will do first is show you how to create the component structure to hold the code. Let me break it down.

```jsx
//sidebar.js
import styled, {createGlobalStyle} from "styled-components"
import React, { useState} from "react"
import { Link } from "gatsby"

const Global = createGlobalStyle`
  body, html{
    margin: 0;
    padding: 0;
    overflow-x: hidden;
  }
`
const MenuIcon = styled.button`
  position: fixed;
  top: 2rem;
  right: 2rem;
  display: flex;
  flex-direction: column;
  justify-content: space-around;
  width: 1.5rem;
  height: 1.5rem;
  background: transparent;
  border: none;
  cursor: pointer;
  z-index: 999;

  div {
    width: 1.5rem;
    height: 0.2rem;
    background: white;
    border-radius: 5px;
    transform-origin: 1px;
    position: relative;
    transition: opacity 300ms, transform 300ms;

    :first-child{
      transform: ${({nav}) => (nav ? 'rotate(45deg)': 'rotate(0)')}
    } 
    

    :nth-child(2){
      opacity: ${({nav}) => (nav ? "0" : "1")}
    } 
    
    :nth-child(3){
      transform: ${({nav}) => (nav ? 'rotate(-45deg)': 'rotate(0)')}
    }
  }  
`

const Menulinks = styled.nav`
  display: flex;
  flex-direction: column;
  justify-content: center;
  text-align: center;
  height: 100vh;
  width: 25%;
  position: fixed;
  transition: 300ms;
  background-color: black;
  top: 0;
  right: 0;
  z-index: 998;
  transform: ${({ nav }) => (nav ? "translateX(0)" : "translateX(100%)")};

  ul{
    list-style-type: none;
  }

  li{
    margin-top: 1rem
  }


   a{
     text-decoration: none; 
     color: white;
     font-size: 1.5rem;
     transition: color 300ms;
   }

  :hover {
    color: #6ab4ff    
  }
`

export const Sidebar =  () => {
  const [nav, showNav] = useState(false);
return(
<>
<Global />
          <MenuIcon nav={nav} onClick={() => showNav(!nav)}>
            <div/>
            <div/>
            <div/>
          </MenuIcon>
          <Menulinks nav={nav}>
            <ul>
              <Link to="#">Blog</Link>
            </ul>
            <ul>
              <Link to="#">home</Link>
            </ul>
            <h3>Social</h3>
            <ul className="icons alt">
            <li>
            <a href="https://github.com/LayersOfAbstraction/layersofabstraction.github.io/" className="icon fa-github">
              <span className="label">GitHub</span>
            </a>
          </li>
          <li>
            <a href="https://www.linkedin.com/in/jordan-nash-87b042173/" className="icon fa-linkedin">
              <span className="label">LinkedIn</span>
            </a>
          </li>
            </ul>
          </Menulinks>
    </>
  );
}
```

I learned the styling from [this awesome video](https://www.youtube.com/watch?v=6cb56Luubd4) by Chris DeSilva. Please advise I did make some tweaks to it.