---
title: "How to turn your web portfolio into personal blogging website with Gatsby"
date: "2022-05-28"
#published: false
layout: post
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

And who knows maybe he will make a video about that himself. For now we are going to expand on what has already been done. So I have made my forked version and done a pull request. It may or may not be accepted. So I will give you a link to my fork as the completed project but if you want to do this from scratch here's Joshua's repo.

## Clone Joshua's repo ##

```html
cd src
git clone https://github.com/JoshuaFluke/joshuafluke.github.io
cd joshuafluke.github.io
```

Let's begin!

You can delete the following files. generic.html and elements.html. We will not use them.

//TODO

_______INSERT COMPLETED PROJECT LINK_______

## Install the dependencies ##

You need to have installed Gatsby, Node.js and git. Run the following commands in your terminal to ensure you have installed them.

```
node -v
git --version
gatsby --version

```

If one of these commands does not return a version number then you need to go here to install the dependencies.

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

![]()

<img src="../images/AttachGatsbySSGToWebsite/Screen%20Shot%202022-06-01%20at%209.36.28%20pm.png" class="image fit" alt="Image showing we will have link to blog on top right and nav bar"/>


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

You will be directed to go through a series of prompts in the once you install.

```
What would you like to call your site?
✔ · Portfolio Blogging site
```


You can just select the default area to save the site to. As long as it does not exist outside of your porfolio project.
```
What would you like to name the folder where your site will be created?
✔ Desktop/ gatsby-integration
```

After that you just select the JavaScript prompt and you have generated the site.

```
Will you be using JavaScript or TypeScript?
❯ JavaScript
  TypeScript
```

Select no I will add it later. Yes a Content Management System is more powerful than a Static Site Generator but if you are not using something like Wordpress as some sort of back end then there isn't much point especially if you're just trying to write some blogs.

```
· Will you be using a CMS?
✔ No (or I'll add it later)
```

When it asks if you want to add a styling system, your answer is likely no unless you are creating styling template from Gatsby as in you are not using the styling we already have.

```
✔ Would you like to install a styling system?
· No (or I'll add it later)
```

In this case we are using a HTML5Up theme with some Unsplash photos so we want to reuse the theme we made. Not have to create a new one and fiddle with the styling. Select no.

Now just select done. We can install plugins later.

```
✔ Would you like to install additional features with other plugins?
· Done
```

I'm not going to explain the next prompt, just press "y" when you see it.

It should tell you if your site got set up.

## Put the gatsby generated files in the root ##

You heard right. After all we're doing a merge here. Just go inside the folder `gatsby-integration` and cut and paste everything into the root.

## Run the site ##

The Gatsby site should run when we fire up the local development server. First we have to go to the root the folder  we run the following command. You will be using this a lot!

```
gatsby develop
```

IF that didn't work then you may need the Gatsby development server.

```
npm run develop
```

## Transform the raw html to JSX ##

An arduous task? There is a way to ease the transformation. In fact most what you see will simply get thrown into the <></> section. We would have to rewrite a few key words, for example class is a reserved html word so in JSX it will become className.

We can use Find and Replace for some of these words later which we will do but there is a better way though which takes some of the effort away. [Use transform](https://transform.tools/html-to-jsx).

We will take a bottom up approach here. Copy your entire index.html file into the HTML window of the transform page and you should see the resulting transformed code in the JSX section. Here is a copy of the HTML.

```html
<!DOCTYPE HTML>
<!--
	Massively by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>
	<head>
		<title>Massively by HTML5 UP</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="assets/css/main.css" />
		<noscript><link rel="stylesheet" href="assets/css/noscript.css" /></noscript>
	</head>
	<body class="is-preload">

		<!-- Wrapper -->
			<div id="wrapper" class="fade-in">

				<!-- Intro -->
					<div id="intro">
						<h1>My Portfolio</h1>
						<p>A showcase of my projects and my abilities.</p>
						<ul class="actions">
							<li><a href="#header" class="button icon solo fa-arrow-down scrolly">Continue</a></li>
						</ul>
					</div>

				<!-- Header -->
					<header id="header">
						<a href="index.html" class="logo">Massively</a>
					</header>

				<!-- Nav -->
					<nav id="nav">
						<ul class="links">
							<li class="active"><a href="index.html">This is Massively</a></li>
						</ul>
						<ul class="icons">
							<li><a href="#" class="icon fa-linkedin"><span class="label">Instagram</span></a></li>
							<li><a href="#" class="icon fa-github"><span class="label">GitHub</span></a></li>
						</ul>
					</nav>

				<!-- Main -->
					<div id="main">

						<!-- Featured Post -->
							<article class="post featured">
								<header class="major">
									
									<h2><a href="#">My Name is  Joshua Fluke</a></h2>
									<p>I'm a passionate developer but more importantly I'm passionate about technology.</p>
								</header>
								<a href="#" class="image main"><img src="images/pic01.jpg" alt="" /></a>
								<ul class="actions special">
									<li><a href="#" class="button large">Check it out</a></li>
								</ul>
							</article>

						<!-- Posts -->
							<section class="posts">
								<article>
									<header>
										
										<h2><a href="#">Project 1<br />
										ipsum faucibus</a></h2>
									</header>
									<a href="#" class="image fit"><img src="images/pic02.jpg" alt="" /></a>
									<p>Donec eget ex magna. Interdum et malesuada fames ac ante ipsum primis in faucibus. Pellentesque venenatis dolor imperdiet dolor mattis sagittis magna etiam.</p>
									<ul class="actions special">
										<li><a href="#" class="button">Full Story</a></li>
									</ul>
								</article>
								<article>
									<header>
										
										<h2><a href="#">Project 2<br />
										imperdiet lorem</a></h2>
									</header>
									<a href="#" class="image fit"><img src="images/pic03.jpg" alt="" /></a>
									<p>Donec eget ex magna. Interdum et malesuada fames ac ante ipsum primis in faucibus. Pellentesque venenatis dolor imperdiet dolor mattis sagittis magna etiam.</p>
									<ul class="actions special">
										<li><a href="#" class="button">Full Story</a></li>
									</ul>
								</article>
							</section>

						<!-- Footer -->
							

					</div>

				<!-- Footer -->
					<footer id="footer">
						<section class="split contact">
							<section class="alt">
								<h3>Address</h3>
								<p>1234 Somewhere Road #87257<br />
								Nashville, TN 00000-0000</p>
							</section>
							<section>
								<h3>Phone</h3>
								<p><a href="#">(000) 000-0000</a></p>
							</section>
							<section>
								<h3>Email</h3>
								<p><a href="#">info@untitled.tld</a></p>
							</section>
							<section>
								<h3>Social</h3>
								<ul class="icons alt">
									<li><a href="#" class="icon alt fa-twitter"><span class="label">Twitter</span></a></li>
									<li><a href="#" class="icon alt fa-facebook"><span class="label">Facebook</span></a></li>
									<li><a href="#" class="icon alt fa-instagram"><span class="label">Instagram</span></a></li>
									<li><a href="#" class="icon alt fa-github"><span class="label">GitHub</span></a></li>
								</ul>
							</section>
						</section>
					</footer>

				<!-- Copyright -->
					<div id="copyright">
						<ul><li>&copy; Untitled</li><li>Design: <a href="https://html5up.net">HTML5 UP</a></li></ul>
					</div>

			</div>

		<!-- Scripts -->
			<script src="assets/js/jquery.min.js"></script>
			<script src="assets/js/jquery.scrollex.min.js"></script>
			<script src="assets/js/jquery.scrolly.min.js"></script>
			<script src="assets/js/browser.min.js"></script>
			<script src="assets/js/breakpoints.min.js"></script>
			<script src="assets/js/util.js"></script>
			<script src="assets/js/main.js"></script>

	</body>
</html>
```

You will see the JSX appear on the JSX window. Notice the changes. Some words like class have been changed to className, this is because class is a reserved word for implementing JavaScript
classes and transform is avoiding those conflict. Also you will notice the bootstrap class image fit

Now go to the settings button and tick the section `Create Function Component` then press confirm. I will do a snapshot to make sure you know where to go just below this next snippet.

<img src="../images/AttachGatsbySSGToWebsite/UsingTransform.gif" class="image fit" alt="Image showing we will have link to blog on top right and nav bar"/>

Now copy the entire JSX file contents and create a new file under your pages folder called
index.js. As you may have guessed this will hold the JSX code. In case that URL no longer works the code should look like this. Very similar!

```jsx
export const Foo = () => (
  <>
    {/*
	Massively by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
*/}
    <title>Massively by HTML5 UP</title>
    <meta charSet="utf-8" />
    <meta
      name="viewport"
      content="width=device-width, initial-scale=1, user-scalable=no"
    />
    <link rel="stylesheet" href="assets/css/main.css" />
    <noscript>
      &lt;link rel="stylesheet" href="assets/css/noscript.css" /&gt;
    </noscript>
    {/* Wrapper */}
    <div id="wrapper" className="fade-in">
      {/* Intro */}
      <div id="intro">
        <h1>My Portfolio</h1>
        <p>A showcase of my projects and my abilities.</p>
        <ul className="actions">
          <li>
            <a
              href="#header"
              className="button icon solo fa-arrow-down scrolly"
            >
              Continue
            </a>
          </li>
        </ul>
      </div>
      {/* Header */}
      <header id="header">
        <a href="index.html" className="logo">
          Massively
        </a>
      </header>
      {/* Nav */}
      <nav id="nav">
        <ul className="links">
          <li className="active">
            <a href="index.html">This is Massively</a>
          </li>
        </ul>
        <ul className="icons">
          <li>
            <a href="#" className="icon fa-linkedin">
              <span className="label">Instagram</span>
            </a>
          </li>
          <li>
            <a href="#" className="icon fa-github">
              <span className="label">GitHub</span>
            </a>
          </li>
        </ul>
      </nav>
      {/* Main */}
      <div id="main">
        {/* Featured Post */}
        <article className="post featured">
          <header className="major">
            <h2>
              <a href="#">My Name is Joshua Fluke</a>
            </h2>
            <p>
              I'm a passionate developer but more importantly I'm passionate
              about technology.
            </p>
          </header>
          <a href="#" className="image main">
            <img src="images/pic01.jpg" alt="" />
          </a>
          <ul className="actions special">
            <li>
              <a href="#" className="button large">
                Check it out
              </a>
            </li>
          </ul>
        </article>
        {/* Posts */}
        <section className="posts">
          <article>
            <header>
              <h2>
                <a href="#">
                  Project 1<br />
                  ipsum faucibus
                </a>
              </h2>
            </header>
            <a href="#" className="image fit">
              <img src="images/pic02.jpg" alt="" />
            </a>
            <p>
              Donec eget ex magna. Interdum et malesuada fames ac ante ipsum
              primis in faucibus. Pellentesque venenatis dolor imperdiet dolor
              mattis sagittis magna etiam.
            </p>
            <ul className="actions special">
              <li>
                <a href="#" className="button">
                  Full Story
                </a>
              </li>
            </ul>
          </article>
          <article>
            <header>
              <h2>
                <a href="#">
                  Project 2<br />
                  imperdiet lorem
                </a>
              </h2>
            </header>
            <a href="#" className="image fit">
              <img src="images/pic03.jpg" alt="" />
            </a>
            <p>
              Donec eget ex magna. Interdum et malesuada fames ac ante ipsum
              primis in faucibus. Pellentesque venenatis dolor imperdiet dolor
              mattis sagittis magna etiam.
            </p>
            <ul className="actions special">
              <li>
                <a href="#" className="button">
                  Full Story
                </a>
              </li>
            </ul>
          </article>
        </section>
        {/* Footer */}
      </div>
      {/* Footer */}
      <footer id="footer">
        <section className="split contact">
          <section className="alt">
            <h3>Address</h3>
            <p>
              1234 Somewhere Road #87257
              <br />
              Nashville, TN 00000-0000
            </p>
          </section>
          <section>
            <h3>Phone</h3>
            <p>
              <a href="#">(000) 000-0000</a>
            </p>
          </section>
          <section>
            <h3>Email</h3>
            <p>
              <a href="#">info@untitled.tld</a>
            </p>
          </section>
          <section>
            <h3>Social</h3>
            <ul className="icons alt">
              <li>
                <a href="#" className="icon alt fa-twitter">
                  <span className="label">Twitter</span>
                </a>
              </li>
              <li>
                <a href="#" className="icon alt fa-facebook">
                  <span className="label">Facebook</span>
                </a>
              </li>
              <li>
                <a href="#" className="icon alt fa-instagram">
                  <span className="label">Instagram</span>
                </a>
              </li>
              <li>
                <a href="#" className="icon alt fa-github">
                  <span className="label">GitHub</span>
                </a>
              </li>
            </ul>
          </section>
        </section>
      </footer>
      {/* Copyright */}
      <div id="copyright">
        <ul>
          <li>© Untitled</li>
          <li>
            Design: <a href="https://html5up.net">HTML5 UP</a>
          </li>
        </ul>
      </div>
    </div>
    {/* Scripts */}
  </>
)

```

## Create Link up the ##

 Now let's create a layout component in the following directory. Run this command.

 ```
src/components/l
 ```

 