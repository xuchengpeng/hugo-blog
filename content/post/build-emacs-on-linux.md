+++
title = "Build Emacs on Linux"
date = 2018-09-19T17:12:20+08:00
draft = false
comments = true
mathjax = false
categories = [ "Software", "emacs" ]
tags = [ "emacs", "Linux", "Ubuntu" ]
+++

Build Emacs 26.1 on Ubuntu:

```shell
sudo apt-get update
sudo apt-get install build-essential
sudo apt-get build-dep emacs24
cd emacs-26.1
./configure --prefix=/usr/local/
sudo make -j4
sudo make install
```

<!--more-->
