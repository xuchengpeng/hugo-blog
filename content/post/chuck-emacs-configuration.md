+++
title = "Chuck's Emacs Configuration"
date = 2018-03-26T07:33:23+08:00
draft = false
comments = true
mathjax = false
toc = true
categories = [ "Software", "emacs" ]
tags = [ "emacs", "use-package" ]
+++

## Install

```sh
$ git clone https://github.com/xuchengpeng/.emacs.d.git ~/.emacs.d
$ cd ~/.emacs.d
$ cp init.example.el init.el
```

## Customization

Change the configurations at the beginning of your `custom.el` or `init.el`, then restart emacs.

For example:
```el
(setq dotemacs-full-name "user name")           ; User full name
(setq dotemacs-mail-address "user@email.com")   ; Email address
(setq dotemacs-package-archives 'emacs-china)   ; Package repo: melpa, emacs-china, tuna or custom
(setq dotemacs-theme 'dotemacs-one)             ; Color theme: dotemacs-one, dotemacs-one-light...
(setq dotemacs-company-enable-yas t)            ; Enable/disable yasnippet for company: t or nil
```
<!--more-->
If `dotemacs-package-archives` is set to `custom`, you need to set `package-archives`.
```el
(setq dotemacs-package-archives 'custom)
(setq package-archives '(("gnu"   . "/home/user/elpa-mirror/gnu/")
                         ("melpa" . "/home/user/elpa-mirror/melpa/")
                         ("org"   . "/home/user/elpa-mirror/org/")))
```

Customize it with melpa, [emacs-china](https://elpa.emacs-china.org/) or [tuna](https://mirror.tuna.tsinghua.edu.cn/help/elpa/), or clone it from [elpa-mirror](https://github.com/xuchengpeng/elpa-mirror) to local disk.

## Install fonts(Optional)

Install your favorite fonts, or you can find some popular fonts [here](https://github.com/xuchengpeng/fonts).

For example:
```el
(setq dotemacs-font "Fira Mono")    ; default font
(setq dotemacs-cn-font "STXihei")   ; chinese font
(setq dotemacs-font-size 11)        ; default font size
(setq dotemacs-cn-font-size 16)     ; chinese font size
```

## Supported Emacs versions

The config should run on Emacs 25.2 or greater and is designed to degrade smoothly - see the [Travis build](https://travis-ci.org/xuchengpeng/.emacs.d).
