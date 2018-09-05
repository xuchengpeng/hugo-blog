+++
title = "Emacs Proxy"
date = 2018-09-05T12:51:10+08:00
draft = false
comments = true
mathjax = false
categories = [ "Software", "emacs" ]
tags = [ "emacs" ]
+++

```el
(setq url-proxy-services '(("no_proxy" . "^\\(localhost\\|10.*\\)")
                           ("http" . "proxy.com:80")
                           ("https" . "proxy.com:80")))

```

<!--more-->

