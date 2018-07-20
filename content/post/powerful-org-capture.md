+++
title = "强大的org-capture"
date = 2018-07-20T15:00:59+08:00
draft = false
comments = true
mathjax = false
categories = [ "Software", "emacs" ]
tags = [ "emacs", "org-mode" ]
+++

Capture是Org mode中一个非常重要的功能，它可以：

1.  capture 可以预先设置记录内容的模板和存储入口；
2.  capture 提供统一的输入入口；
3.  capture 用完即走，不干扰当前工作流；


## Capture模板

默认Capture模板样式如下：

```el
'("t" "Task" entry (file+headline "" "Tasks") "* TODO %?\n  %u\n  %a")
```
<!--more-->

这个模板包含五个部分，分别是：

| 模板组成    | 对应默认模板中的内容       | 描述               |
| :---------- | :------------------------- | :----------------- |
| key         | "t"                        | 用来选择模板的字符 |
| description | "Task"                     | 展示用的模板的描述 |
| type        | entry                      | 新增内容的类型     |
| target      | (file+headline "" "Tasks") | 新增内容的存储位置 |
| template    | "* TODO %?\n %u\n %a"      | 新增内容的模板     |

### 新增内容的类型type

| type           | description                                        |
| :------------- | :-------------------------------------             |
| entry          | 带有 headline 的一个 Org mode 节点，如"* headline" |
| item           | 一个列表项，如"- item"                             |
| checkitem      | 一个 checkbox 列表项，如"[ ] item"                 |
| table-line     | 一个表格行                                         |
| plain          | 普通文本                                           |

### 新增内容的存储位置target

| type                   | description                       | example                                                      |
| :--------------------- | :-------------------------------- | :----------------------------------------------------------- |
| file                   | 文件                              | (file "path/to/file")                                        |
| id                     | 特定 ID 的某个 headline           | (id "id of existing Org entry")                              |
| file+headline          | 文件的某个唯一的 headline         | (file+headline "path/to/file" "node headline")               |
| file+olp               | 文件中的 headline 路径            | (file+olp "path/to/file" "Level 1 heading" "Level 2" ...)    |
| file+regexp            | 文件中被正则匹配的 headline       | (file+regexp "path/to/file" "regexp to find location")       |
| file+datetree          | 文件中当日所在的 datetree         | (file+datetree "path/to/file")                               |
| file+datetree+prompt   | 文件中的 datetree，弹出日期选择   | (file+datetree+prompt "path/to/file")                        |
| file+weektree          | 文件中当日所在的 weektree         | (file+weektree "path/to/file")                               |
| file+weektree+prompt   | 文件中的 weektree，弹出日期选择   | (file+weektree+prompt "path/to/file")                        |
| file+function          | 文件中被函数匹配的位置            | (file+function "path/to/file" function-finding-location)     |
| clock                  | 当前正在计时中的任务所在的位置    | (clock)                                                      |
| function               | 自定义函数匹配的位置              | (function function-finding-location)                         |

### 新增内容的模板template

* 时间和日期相关

| 标记     | 描述                                                                 |
| :------- | :------------------------------------------------------------------- |
| %<...>   | 自定义格式的 timestamp，如: %<%Y-%m-%d>，会得到 <2018-03-04 日>      |
| %t       | 当前仅包含日期的 timestamp，如: <2018-03-04 日>                      |
| %T       | 当前包含日期和时间的 timestamp，如: <2018-03-04 日 19:26>            |
| %u       | 当前包含日期的未激活的 timestamp，如: [2018-03-04 日]                |
| %U       | 当前包含日期和时间的未激活的 timestamp，如: [2018-03-04 日 19:26]    |
| %\^t     | 类似 %t，但是弹出日历让用户选择日期                                  |
| %\^T     | 类似 %T，但是弹出日历让用户选择日期和时间                            |
| %\^u     | 类似 %u，但是弹出日历让用户选择日期                                  |
| %\^U     | 类似 %U，但是弹出日历让用户选择日期和时间                            |

* 剪切板相关

| 标记   | 描述                                       |
| :----- | :----------------------------------------- |
| %c     | 当前 kill ring 中的第一条内容              |
| %x     | 当前系统剪贴板中的内容                     |
| %\^C   | 交互式地选择 kill ring 或剪贴板中的内容    |
| %\^L   | 类似 %\^C，但是将选中的内容作为链接插入    |

* 标签相关

| 标记   | 描述                                                             |
| :----- | :--------------------------------------------------------------- |
| %\^g   | 交互式地输入标签，并用 target 所在文件中的标签进行补全           |
| %\^G   | 类似 %\^g，但用所有 org-agenda-files 涉及文件中的标签进行补全    |

* 文件相关

| 标记      | 描述                                           |
| :-------- | :--------------------------------------------- |
| %[file]   | 插入文件 /file/ 中的内容                       |
| %f        | 执行 org-capture 时当前 buffer 对应的文件名    |
| %F        | 类似 %f，但输入该文件的绝对路径                |

* 任务相关

| 标记   | 描述                      |
| :----- | :------------------------ |
| %k     | 当前在计时的任务的标题    |
| %K     | 当前在计时的任务的链接    |

* 外部链接的信息

| link type      | description                                                                                    |
| :------------- | :--------------------------------------------------------------------------------------------- |
| bbdb           | [BBDB](https://www.emacswiki.org/emacs/CategoryBbdb) 联系人数据库记录链接                      |
| irc            | IRC 会话链接                                                                                   |
| vm             | [View Mail](https://www.emacswiki.org/emacs/CategoryViewMail) 邮件阅读器中的消息、目录链接     |
| wl             | [Wunder Lust](https://www.emacswiki.org/emacs/WanderLust) 邮件/新闻阅读器中的消息、目录链接    |
| mh             | [MH-E](https://www.emacswiki.org/emacs/MH-E) 邮件用户代理中的消息、目录链接                    |
| mew            | [MEW](https://www.emacswiki.org/emacs/Mew) 邮件阅读器中的消息链接                              |
| rmail          | Emacs 的默认邮件阅读器 [Rmail](https://www.emacswiki.org/emacs/Rmail) 中的消息链接             |
| gnus           | [GNUS](http://www.gnus.org/) 邮件/新闻阅读器中的群组、消息等资源链接                           |
| eww/w3/w3m     | 在 eww/w3/w3m 中存储的网页链接                                                                 |
| calendar       | 日历链接                                                                                       |
| org-protocol   | 遵循 org-protocol 协议的外部应用链接                                                           |

eww 可用的特殊标记有如下三个：

| 标记            | 描述                              |
| :-------------- | :-------------------------------- |
| %:type          | 固定值，eww                       |
| %:link          | 页面的链接                        |
| %:description   | 页面的标题，如无则为页面的链接    |

org-protocol 可用的特殊标记有如下六个：

| 标记            | 描述                                                |
| :-------------- | :-------------------------------------------------- |
| %:type          | 链接的类型，如 http/https/ftp 等                    |
| %:link          | 链接地址，在 org-protocol 里的 url 字段             |
| %:description   | 链接的标题，在 org-protocol 里的 title 字段         |
| %:annotation    | 靠 url 和 title 完成的 org 格式的链接               |
| %:initial       | 链接上选中的文本，在 org-protocol 里的 body 字段    |
| %:query         | org-protocol 上除掉开头和子协议部分的剩下部分       |

## Capture模板示例

### 用 org-capture 做任务管理

```el
(add-to-list 'org-capture-templates '("t" "Tasks"))
(add-to-list 'org-capture-templates
             '("tt" "Task" entry
               (file+headline "task.org" "Task")
               "* TODO %^{任务名}\n%u\n%a\n" :clock-in t :clock-resume t))
(add-to-list 'org-capture-templates
             '("tw" "Work Task" entry
               (file+headline "work.org" "Work")
               "* TODO %^{任务名}\n%u\n%a\n" :clock-in t :clock-resume t))
```

这里需要新建普通任务和工作任务，因此可以创建一个任务分组。

### 用 org-capture 新建博客文章

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
                 (function dotemacs-org-hugo-new-subtree-post-capture-template)))
```


