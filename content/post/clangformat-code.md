+++
title = "Clang-Format code"
date = 2018-12-22T14:39:11+08:00
draft = false
comments = true
mathjax = false
categories = [ "Tools" ]
tags = [ "clang-format", "SourceInsight", "astyle" ]
+++

Download clang-format from [http://llvm.org](http://llvm.org).

Examples:

```shell
clang-format -style=LLVM -i test.c
clang-format -style=Google -dump-config > google.clang-format
```
<!--more-->

You can use your own `.clang-format` or `_clang-format` configuration file.

```
---
BasedOnStyle: LLVM
---
Language: Cpp
AccessModifierOffset: -4
AlignEscapedNewlines: Left
AllowShortIfStatementsOnASingleLine: true
AllowShortLoopsOnASingleLine: true
BreakBeforeBraces: Custom
BraceWrapping:
  AfterFunction: true
ColumnLimit: 0
ConstructorInitializerAllOnOneLineOrOnePerLine: true
IncludeCategories:
  - Regex:    '^<ext/.*\.h>'
    Priority: 2
  - Regex:    '^<.*\.h>'
    Priority: 1
  - Regex:    '^<.*'
    Priority: 2
  - Regex:    '.*'
    Priority: 3
IndentCaseLabels: true
IndentWidth: 4
ObjCBlockIndentWidth: 4
SortIncludes: false
SortUsingDeclarations: false
SpacesBeforeTrailingComments: 2
UseTab: Never
TabWidth: 4
---
Language: Java
...


```
