+++
title = "EditorConfig"
date = 2018-08-21T12:37:18+08:00
draft = false
comments = true
mathjax = false
categories = [ "Tools" ]
tags = [ "EditorConfig" ]
+++

[EditorConfig](https://editorconfig.org/)可以帮助开发者在不同的编辑器和IDE之间定义和维护一致的代码风格。EditorConfig包含一个用于定义代码格式的文件和一批编辑器插件，这些插件可以让编辑器读取配置文件并依此格式化代码。EditorConfig的配置文件十分易读，并且可以很好的在VCS（Version Control System）下工作。

### EditorConfig配置文件是什么样子的？

以下是一个用于Python和Java的行尾和缩进风格.editorconfig配置文件。

```ini
# EditorConfig is awesome: https://EditorConfig.org

# top-most EditorConfig file
root = true

# Unix-style newlines with a newline ending every file
[*]
end_of_line = lf
insert_final_newline = true

# Matches multiple files with brace expansion notation
# Set default charset
[*.{js,py}]
charset = utf-8

# 4 space indentation
[*.py]
indent_style = space
indent_size = 4

# Tab indentation (no size specified)
[Makefile]
indent_style = tab

# Indentation override for all JS under lib directory
[lib/**.js]
indent_style = space
indent_size = 2

# Matches the exact files either package.json or .travis.yml
[{package.json,.travis.yml}]
indent_style = space
indent_size = 2
```

查看更多使用EditorConfig的[项目](https://github.com/editorconfig/editorconfig/wiki/Projects-Using-EditorConfig)。

<!--more-->

### 在哪里存放配置文件

当打开一个文件时，EditorConfig插件会在打开文件的目录和其每一级父目录查找.editorconfig文件，直到有一个配置文件root=true。

EditorConfig配置文件从上往下读取，并且路径最近的文件最后被读取。匹配的配置属性按照属性应用在代码上，所以最接近代码文件的属性优先级最高。

Windows 用户：在资源管理器创建.editorconfig文件，可以先创建.editorconfig.文件，系统会自动重名为.editorconfig。

### 文件格式详情

EditorConfig文件使用INI格式，目的是可以与[Python ConfigParser Library](https://docs.python.org/2/library/configparser.html)兼容，但是允许在分段名（译注：原文是section names）中使用“and”。分段名是全局的文件路径，格式类似于gitignore。斜杠(/)作为路径分隔符，#或者;作为注释。注释应该单独占一行。EditorConfig文件使用UTF-8格式、CRLF或LF作为换行符。

#### 通配符

| 通配符       | 说明                                           |
|:-------------|:-----------------------------------------------|
| *            | 匹配除/之外的任意字符串                        |
| **           | 匹配任意字符串                                 |
| ?            | 匹配任意单个字符                               |
| [name]       | 匹配任意name中的单个字符                       |
| [!name]      | 匹配任意非name中的单个字符                     |
| {s1,s2,s3}   | 匹配任意给定的字符串(以逗号分隔)               |
| {num1..num2} | 匹配任意num1和num2之间的整数，可以是正数或负数 |

特殊字符可以用`\`转义，以使其不被认为是通配符。

#### 支持的属性

注意不是每个插件都支持所有的属性，这个[Wiki](https://github.com/editorconfig/editorconfig/wiki/EditorConfig-Properties)中有所有的属性列表。

* indent_style：tab为hard-tabs，space为soft-tabs。
* indent_size：设置整数表示规定每级缩进的列数和soft-tabs的宽度（译注：空格数）。如果设定为tab，则会使用tab_width的值（如果已指定）。
* tab_width：设置整数用于指定替代tab的列数。默认值就是indent_size的值，一般无需指定。
* end_of_line：定义换行符，支持lf、cr和crlf。
* charset：编码格式，支持latin1、utf-8、utf-8-bom、utf-16be和utf-16le。
* trim_trailing_whitespace：设为true表示会除去换行行首的任意空白字符，false反之。
* insert_final_newline：设为true表明使文件以一个空白行结尾，false反之。
* root：表明是最顶层的配置文件，发现设为true时，才会停止查找.editorconfig文件。

### Emacs使用EditorConfig

```el
(use-package editorconfig
  :ensure t
  :config
  (editorconfig-mode 1))
```
