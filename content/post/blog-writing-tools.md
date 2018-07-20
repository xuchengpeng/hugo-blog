+++
title = "博客写作工具"
date = 2018-07-20T09:20:28+08:00
draft = false
comments = true
mathjax = false
categories = [ "Tools" ]
tags = [ "emacs", "Hugo", "orgmode", "ox-hugo" ]
+++

基本的工具用途：

* [Hugo](https://gohugo.io/)：用来发布博客；
* [orgmode](https://orgmode.org/)：写org格式的博文；
* [ox-hugo](https://github.com/kaushalmodi/ox-hugo)：将org博文导出为Markdown格式文件；

<!--more-->

## 使用org-capture创建博文

```el
(with-eval-after-load 'org-capture
  (defun dotemacs-org-hugo-new-subtree-post-capture-template ()
    "Returns `org-capture' template string for new Hugo post.
     See `org-capture-templates' for more information."
    (let* ((title (read-from-minibuffer "Post Title: ")) ;Prompt to enter the post title
           (fname (org-hugo-slug title))
           (date (format-time-string (org-time-stamp-format :long :inactive) (org-current-time))))
      (mapconcat #'identity
                 `(
                   ,(concat "* TODO " title)
                   ":PROPERTIES:"
                   ,(concat ":EXPORT_FILE_NAME: " fname)
                   ,(concat ":EXPORT_DATE: " date)
                   ":EXPORT_HUGO_CUSTOM_FRONT_MATTER: :comments true :mathjax false"
                   ":END:"
                   "%?\n")          ;Place the cursor here finally
                 "\n")))
  
  (add-to-list 'org-capture-templates
               '("h"                ;`org-capture' binding + h
                 "Hugo post"
                 entry
                 ;; It is assumed that below file is present in `org-directory'
                 ;; and that it has a "Hugo Posts" heading. It can even be a
                 ;; symlink pointing to the actual location of all-posts.org!
                 (file+olp "hugo-posts.org" "Hugo Posts")
                 (function dotemacs-org-hugo-new-subtree-post-capture-template))))
)
```

使用org-capture前先在`org-directory`目录创建`hugo-posts.org`文件，并且其中已包含一级标题`* Hugo Posts`，新创建的博文将在这个标题下。

## 使用ox-hugo导出博文

### 导出前设置

在`hugo-posts.org`文件头部增加以下内容：

```org
#+HUGO_BASE_DIR: e:/GitHub/xuchengpeng.github.io/
#+HUGO_SECTION: post
#+TITLE:
#+DATE:
#+HUGO_AUTO_SET_LASTMOD: t
#+HUGO_CATEGORIES: hugo test
#+HUGO_TAGS: hugo
#+HUGO_DRAFT: false
```

`HUGO_BASE_DIR`和`HUGO_SECTION`根据实际情况而定，`HUGO_CATEGORIES`和`HUGO_TAGS`可为当前要导出的博文设定分类和标签。

### 导出方法

`C-c C-e H H` 导出单个子树到Markdown文件，一般一个子树就是一篇文章；

`C-c C-e H A` 导出所有子树到Markdown文件，会为每篇文章都导出一个Markdown文件。

