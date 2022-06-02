---
title: "How to turn your web portfolio into personal blogging website with Gatsby"
date: "2022-05-28"
published: false
---

## What is this for? ##

A few years back I watched a video by Joshua Fluke that taught me how to host a git repo as a GitHub Pages portfolio website without paying any money.

<https://www.youtube.com/watch?v=u-RLu_8kwA0>

How cool! To think a few years ago I was paying to host my portfolio on Winhost where I was making no revenue. But I wanted to go one step better. I wanted to share the
knowledge of people who busted their guts
trying to assist me. I wanted to blog about it.

But I didn't want to host the blogs on hackernoon
or another platform when I had a working domain
I had brought for the github Pages repo.

To get around that I used Jekyll which works well but if you want to learn React or have trouble grasping the concepts that's where
you can use Gatsby to not only write awesome blogs about what you wrote but also learn about React components on the side and syntax.

## Exciting! How to get started? ##

So today we are going to use a forked repo from Joshua Fluke's original tutorial and turn it into a blogging platform.

And who knows maybe he will make a video about that himself. For now we are going to expand on what he has already been done. So I have made my forked version and done a pull request. It may or may not be accepted. So I will give you a link to my fork.

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

Use these tool in whatever text editor or IDE you are commfortable with.

Keep in mind I am running this as a Docker container so if you just
have Docker you can use that instead to run this project.

But I will not get into how to do that.

If you did not want to watch the video on how to create the github pages portfolio, that is ok. I will go through that.

Make sure you can run the static html files first. For that I advise you install the LiveServer extension. 

Then simply open index.html in the root folder and go to the buttopn below on the blue bar that says Go Live. You should see this.  

![](Screen%20Shot%202022-06-01%20at%209.36.28%20pm.png)

Ok when we open the red encirled hamburger icon