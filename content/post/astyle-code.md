+++
title = "使用AStyle格式化代码"
date = 2018-12-20T18:59:10+08:00
draft = false
comments = true
mathjax = false
categories = [ "Tools" ]
tags = [ "astyle", "SourceInsight" ]
+++

从 [astyle.sourceforge.net](http://astyle.sourceforge.net/) 下载安装 astyle。

```shell
AStyle.exe -A8 -s4 -k3 -W3 -S -p -xn -xc -xk -xV -xf -xh -H -Y -w -xW -n -c -z2 /path/to/code.c
```

* -A8 Linux style
* -s4 4个空格缩进
* -k3 指针*靠近变量
* -W3 引用&靠近变量
* -S switch下的case添加缩进
* -p 在操作符两边添加空格
* -xn 花括号在namespace之后
* -xc 花括号在class之后
* -xk 花括号在extern "C"之后
* -xV do-while语句中，while在关闭花括号之后
* -xf 函数定义中，返回类型和函数名在同一行
* -xh 函数声明中，返回类型和函数名在同一行
* -H 在if,for,while...之后添加空格
* -Y 缩进注释
* -w 宏定义换行后缩进
* -xW 嵌套预处理缩进
* -n 不生成备份文件
* -c tab转换为空格
* -z2 linux(LF)换行

<!--more-->

linux编译astyle：

```shell
cd astyle/build/gcc
make
cp ./bin/astyle /usr/bin
```
