+++
title = "Cmder | Console Emulator"
date = 2018-09-05T09:31:48+08:00
draft = false
comments = true
mathjax = false
categories = [ "Tools" ]
tags = [ "Cmder", "ConEmu" ]
+++

> Cmder is a software package created out of pure frustration over the absence of nice console emulators on Windows. It is based on amazing software, and spiced up with the Monokai color scheme and a custom prompt layout, looking sexy from the start.

### 增加 Cmder Here

1. 添加环境变量 `CMDER_HOME`设定为Cmder安装目录`D:\Software\cmder\`；
2. 将`%CMDER_HOME%`添加到`PATH`环境变量中；
3. 在cmd中执行`Cmder.exe /REGISTER ALL`注册右键菜单；
4. 修改Cmder初始任务，设定为`*cmd /k ""%ConEmuDir%\..\init.bat" " -new_console:d:%CD%`。

<!--more-->

### 中文乱码

在`Environment`中增加`set LANG=zh_CN.UTF-8`。

