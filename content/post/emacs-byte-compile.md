+++
title = "Byte Compile Elisp Files"
date = 2018-07-26T12:54:14+08:00
draft = false
comments = true
mathjax = false
categories = [ "Software", "emacs" ]
tags = [ "emacs" ]
+++

Emacs lisp files can be byte compiled.

Byte compiled elisp file has “.elc” suffix (aka extension). Normal elisp file has “.el” suffix.

## Advantage of Byte Compiled Elisp File

Byte compiled elisp files will load faster, and also run faster. (by a simple test of a loop, it seems to run about 4 times faster.)

Another advantage is that byte compiling will often tell you errors or warning in your elisp code that you normally wouldn't know.
<!--more-->

## Loading Byte Compiled File

In your init file, when you use **load**, if you want emacs to load the byte compiled file if it exists, you should not include the “.el” suffix. For example, do it like this:

```elisp
;; load elisp file, use byte compiled version (.elc) if exist
(load "my_emacs_keybinding") ; no file name extension here
```

## How to Byte Compile

There are several ways to byte compile elisp files. The simplest and most useful are:

* `Alt+x` **byte-compile-file**, it'll prompt for a file name.
* In dired, `Alt+x` **dired-mark-files-regexp** 【% m】 on “.el” files, then `Alt+x` **dired-do-byte-compile** 【B】.

## Byte Compile

`Alt+x` **byte-recompile-directory** to batch byte compile all elisp files in current dir and sub-directory, if a “.elc” for the file exists, and has a file timestamp older than the “.el” file.

Evaluate (byte-recompile-directory directory_path 0) to recompile every “.el” file. (regardless whether “.elc” exists.), but still compare timestamp.

Evaluate (byte-recompile-directory directory_path 0 t) to recompile every “.el” file. (regardless whether “.elc” exists and regardless of timestamp.)

Evaluate (byte-recompile-directory directory_path nil t) to byte compile all “.el” file that has a existing “.elc” file. (regardless of timestamp.)

## Recompile When Upgrade

When you upgrade to a new emcas version, or upgrade packages, or bring over your byte compiled elisp directory from one machine to another, you should recompile your elisp files, because often, emacs has some incompatible elisp changes, and big packages may fail without recompile.

