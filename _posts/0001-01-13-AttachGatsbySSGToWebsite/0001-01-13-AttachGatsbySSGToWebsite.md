---
title: "How to turn your web portfolio into personal blogging website with Gatsby"
date: "2022-05-28"
published: false
---

## What is this for? ##

A few years back I watched a [video by Joshua Fluke](https://www.youtube.com/watch?v=u-RLu_8kwA0) that taught me how to host a git repo as a GitHub Pages portfolio website without paying any money.

How cool! To think a few years ago I was paying to host my portfolio on Winhost where I was making no revenue. But I wanted to go one step better. I wanted to share the
knowledge of people who busted their guts
trying to assist me. I wanted to make a blog about it.

But I didn't want to host the blogs on hackernoon
or another platform when I had a working domain
I had brought for the github Pages repo.

To get around that I used Jekyll which works well but if you want to learn React or have trouble grasping the concepts that's where
you can use Gatsby to not only write awesome blogs but also learn about React components on the side and syntax.

## Exciting! How to get started? ##

So today we are going to use a portfolio website from Joshua Fluke's original tutorial and turn it into a blogging platform.

And who knows maybe he will make a video about that himself. For now we are going to expand on what has already been done. So I have made my forked version and done a pull request. It may or may not be accepted. So I will give you a link to my fork.

_______INSERT LINK_______

## Install the dependencies ##

You need to have installed Gatsby, Node.js and git. Run the following commands in your terminal to ensure you have installed them.

```
node -v
git --version
gatsby --version

```

If one of these commands does not return a version number than you need to go here to install the dependencies.

- [Node.js](https://nodejs.dev/download)
- [git](https://git-scm.com/download/win)

- For gatsby CLI use this command. Can only be
done after you have installed Gatsby.

```
npm install -g gatsby-cli
```

Use these tools in whatever text editor or IDE you are comfortable with.

Keep in mind I am running this as a Docker container so if you just
have Docker you can use that instead to run this project.

But I will not get into how to do that.

## Watch Joshua Fluke's video or download his portfolio to start with ##

If you did not want to watch the video on how to create the github pages portfolio, that is ok you can just [download this portfolio](https://github.com/JoshuaFluke/joshuafluke.github.io) Joshua Fluke made.

Make sure you can run the static html files first. If you are using Visual Studio For that I advise you install the LiveServer extension.

Then simply open index.html in the root folder and go to the button below on the blue bar that says Go Live. You should see this.  

![](Screen%20Shot%202022-06-01%20at%209.36.28%20pm.png)

It's ok if you don't and are using a different text editor/IDE. Just make sure you can run the static website for now before creating the blogging template. When we open the red encircled hamburger icon and open it we want a to open our blog's table of contents.

We want that to appear as well in the white section if the screen is not minimized you can't see the white space where I have encircled it but if you were to fully maximize the web page, you would see it.

## Generate the Gatsby site template ##

But first we need to generate the template we are going to use to build the Gatsby site. We do this in the command line.

Type the following commands.

```
gatsby new
```

This is optional if you want to update the Gatsby CLI.  

```
npm install -g gatsby-cli
```

