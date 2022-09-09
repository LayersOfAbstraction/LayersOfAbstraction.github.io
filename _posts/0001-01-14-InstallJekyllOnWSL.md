---
title: "How to install Jekyll on WSL and add a new site"
date: "2022-05-28"
published: True
layout: post
---

## Introduction

**Distro used:** I used Ubuntu 20.04 (Focal) as Ubuntu 22.04 (Jammy) isn't compatible with the Brightbox Personal Package Archive or ppa:brightbox/ruby-ng .
You should have either these or later.

**Used the following libaries, please do NOT install just yet:**

```
jekyll 4.2.2
node v10.19.0
rbenv 1.2.0-16-gc4395e5
```

They all worked for me!

I honestly just attempted to install the latest versions.

I went to [this forum](https://softans.com/question/error-while-executing-gem-gemfilepermissionerror-you-dont-have-write-permissions-for-the-var-lib-gems-2-7-0-directory/) to work out how to install Ruby effectively as installing it can be a pain.

```
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

Jekyll should now be installed. You can check with, `jekyll -v`  

Now the next error was really annoying. If you have gone to the directory and done bundle init then you will get an error which will look similar to the one [found here.](https://github.com/jekyll/jekyll/issues/8523)

To fix it use this command to add it as.

```
bundle add webrick
```

You should installed Jekyll completely. It can be a pain to install but once it's running, it's god's gift to the world. Anyone can get started and use it.
