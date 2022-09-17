---
title: "How to install Jekyll on WSL"
date: "2022-09-11"
published: false
layout: post
---

## Introduction

- In this tutorial you will configure Windows 10 to use the Jekyll SSG (Static Site Generator) on WSL (Windows Subsystem for Linux).
- If you do not want to install Linux or in a virtual machine just to use Jekyll, then good news you can use WSL on Windows!
- To do this you will have to install Node.js and Ruby in WSL.
- Should you bother? Only if you are new to blogging and do not already use a content management system that is doing you well.
  
Jekyll was the first static site generator I ever used as Github uses it for their site. After writing several blogs I can see why they use it. 10 times better than manually creating
every single HTML paragraph tag which was what I used to do.

**Distro used:** I used Ubuntu 20.04 (Focal) as Ubuntu 22.04 (Jammy) isn't compatible with the Brightbox Personal Package Archive or ppa:brightbox/ruby-ng which will need to insttall the Ruby language which Jekyll runs on.

**Used the following libaries, please do NOT install just yet:**

```text
jekyll 4.2.2
node v10.19.0
rbenv 1.2.0-16-gc4395e5
```

I honestly just attempted to install the latest versions.

## All this just to install Ruby

```text
sudo apt-get update -y && sudo apt-get upgrade -y
sudo apt-add-repository ppa:brightbox/ruby-ng
sudo apt-get update

cd $HOME
sudo apt-get update
sudo apt install curl
curl -sL <https://deb.nodesource.com/setup_19.x> | sudo -E bash -
curl -sS <https://dl.yarnpkg.com/debian/pubkey.gpg> | sudo apt-key add -
echo "deb <https://dl.yarnpkg.com/debian/> stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update
sudo apt-get install git-core zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev nodejs yarn

cd
git clone <https://github.com/rbenv/rbenv.git> ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
exec $SHELL

git clone <https://github.com/rbenv/ruby-build.git> ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
exec $SHELL

rbenv install 3.0.1
rbenv global 3.0.1
ruby -v

gem update
gem install jekyll bundle
```

Credit goes to the user known as [*Jimmy*. Advise, the version of Node he uses is outdated.](https://softans.com/question/error-while-executing-gem-gemfilepermissionerror-you-dont-have-write-permissions-for-the-var-lib-gems-2-7-0-directory/)

## Now we just have to install Jekyll

Jekyll should now be installed. You can check with, `jekyll -v`  

Now the next error was really annoying. If you have gone to the directory and done bundle init then you will get an error which will look similar to the one [found here.](https://github.com/jekyll/jekyll/issues/8523)

To fix it use this command to add it as.

```text
bundle add webrick
```

You should have installed Jekyll completely. It can be hard to install but once it's running, it is super easy to use. The Gatsby team for example have gone as far as to say that static site generators are more environmentally friendly as they do not use a database. Anyone can get started using it and write really about anything, it doesn't even have to be about programming. Just please, when blogging objectively, do not let it turn to hate.

## What should I do now?

If you don't have a pre existing site then perfect because it will be easier to use Jekyll as you just have to download their themes now. This blog can help you get started in learning how to [publish your own blogs from Jekyll to GithubPages](https://www.smashingmagazine.com/2014/08/build-blog-jekyll-github-pages/) which allows you to host your static site for free. You might consider getting a domain name though for your site.
