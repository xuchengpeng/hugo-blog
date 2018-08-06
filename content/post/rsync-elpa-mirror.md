+++
title = "rsync elpa mirror"
date = 2018-08-06T16:48:15+08:00
draft = false
comments = true
mathjax = false
categories = [ "Tools" ]
tags = [ "rsync", "emacs" ]
+++

[rsync](https://rsync.samba.org/) is an open source utility that provides fast incremental file transfer. rsync is freely available under the GNU General Public License and is currently being maintained by Wayne Davison.

rsync is a file transfer program for Unix systems. rsync uses the "rsync algorithm" which provides a very fast method for bringing remote files into sync. It does this by sending just the differences in the files across the link, without requiring that both sets of files are present at one of the ends of the link beforehand.
Some features of rsync include

* can update whole directory trees and filesystems
* optionally preserves symbolic links, hard links, file ownership, permissions, devices and times
* requires no special privileges to install
* internal pipelining reduces latency for multiple files
* can use rsh, ssh or direct sockets as the transport
* supports anonymous rsync which is ideal for mirroring

<!--more-->

### rsync elpa mirror

```sh
rsync -avz --delete --progress rsync://elpa.gnu.org/elpa/ ./rsync/gnu
rsync -avz --delete --progress rsync://melpa.org/packages/ ./rsync/melpa
rsync -avz --delete --progress rsync://melpa.org/packages-stable/ ./rsync/melpa-stable
```

### Clone ELPA archive

Use [elpa-clone](https://github.com/dochang/elpa-clone) to clone elpa archive.

```sh
#!/bin/bash
set -ev
export TZ='Asia/Shanghai'

SCRIPTPATH=$(cd $(dirname $0); pwd -P) && cd $SCRIPTPATH
elpa_clone_path=.elpa-clone

rm -rf $elpa_clone_path
git clone --depth 1 https://github.com/dochang/elpa-clone.git $elpa_clone_path

function clone {
  echo "Updating mirror for $2 ($1)"
  emacs -l "$elpa_clone_path/elpa-clone.el" -nw --batch --eval="(elpa-clone \"$1\" \"$SCRIPTPATH/$2\")"
}

mkdir rsync

clone "rsync://elpa.gnu.org/elpa/" "./rsync/gnu"
clone "rsync://melpa.org/packages/" "./rsync/melpa"
clone "rsync://melpa.org/packages-stable/" "./rsync/melpa-stable"
clone "http://orgmode.org/elpa/" "./rsync/org"
```

