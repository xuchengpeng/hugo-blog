+++
title = "Shell - Here Documents"
date = 2018-10-30T14:19:55+08:00
draft = false
comments = true
mathjax = false
categories = [ "Technology", "Linux" ]
tags = [ "Shell", "Linux" ]
+++

Here Documents 是 Shell 中的一种特殊的重定向方式，用来将输入重定向到一个交互式 Shell 脚本或程序。

它的基本的形式如下：

```sh
command << delimiter
    document
delimiter
```

它的作用是将两个 delimiter 之间的内容(document) 作为输入传递给 command。

> 注意：
>
> * 结尾的delimiter 一定要顶格写，前面不能有任何字符，后面也不能有任何字符，包括空格和 tab 缩进。
> * 开始的delimiter前后的空格会被忽略掉。

<!--more-->

### 实例

在命令行中通过 wc -l 命令计算行数：

```sh
$ wc -l << EOF
    欢迎来到
    菜鸟教程
    www.runoob.com
EOF
3          # 输出结果为 3 行
$
```

我们也可以将 Here Documents 用在脚本中，例如：

```sh
#!/bin/bash
# author:菜鸟教程
# url:www.runoob.com

cat << EOF
欢迎来到
菜鸟教程
www.runoob.com
EOF
```

执行以上脚本，输出结果：

```sh
欢迎来到
菜鸟教程
www.runoob.com
```

