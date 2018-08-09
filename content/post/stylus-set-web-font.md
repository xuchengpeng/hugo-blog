+++
title = "Stylus 自定义网页字体"
date = 2018-05-23T10:27:11+08:00
draft = false
comments = true
mathjax = false
categories = [ "Technology", "Web" ]
tags = [ "Stylus", "Stylish", "CSS" ]
+++



使用 Stylus 可以直接使用 [userstyles 网站](https://userstyles.org/) 提供的模板，很多下载后几乎不用设定即可使用，前提是现在电脑上安装相应的字体。

这里推荐一款 [ForceMyFont](https://userstyles.org/styles/100473/004-forcemyfonts-chinese-firefoxchromeie-catcat520) 的模板，可以设定的选项非常丰富，前提也是需要在电脑上安装你选择的字体。

你也可以自定义字体CSS的样式，在 Chrome 浏览器中，这里使用 Stylus 插件，编写新的样式，代码如下：
```css
*{font-weight:500!important;}
*{font-family: Arial, "思源宋体"!important;}
```
第一行设定字重，第二行设定英文字体和中文字体。如果要添加字体阴影，可以添加以下代码：
```css
*{text-shadow:0.01em 0.01em 0.01em #999999 !important;}
```
其中的数值依次代表阴影的 X 轴偏移、Y 轴偏移、阴影大小，以及字体颜色。
<!--more-->

网页上的图标显示成框框，可用以下办法解决：
```css
*:not([class*="icon"]):not(i) {
    font-family: "DejaVu Sans Mono", "思源黑体 Regular" !important;
}
```

我的自己使用的思源黑体配置：
```css
@namespace url(http://www.w3.org/1999/xhtml);

html,
[lang=zh-CN] {
    font-family: "Source Han Sans SC", "Source Han Sans", "HanHei SC", "Microsoft YaHei", sans-serif;
}

[lang=zh-TW] {
    font-family: "Source Han Sans TC", "Source Han Sans", "HanHei TC", "Microsoft JhengHei", sans-serif;
}

[lang=zh-HK] {
    font-family: "Source Han Sans TC", "Source Han Sans", "HanHei TC", "Microsoft JhengHei", sans-serif;
}

[lang=ja-JP] {
    font-family: "Source Han Sans", "Yu Gothic", sans-serif;
}

[lang=ko-KR] {
    font-family: "Source Han Sans K", "Source Han Sans", "Malgun Gothic", sans-serif;
}

body,
input,
textarea,
keygen,
select,
button {
    font-family: inherit;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    text-rendering: optimizeLegibility;
}


/* 字体替换：西里尔字母 */

@font-face {
    font-family: "Arial";
    src: local("Source Han Sans SC");
}

@font-face {
    font-family: "Tahoma";
    src: local("Source Han Sans SC");
}

@font-face {
    font-family: "Verdana";
    src: local("Source Han Sans SC");
}

@font-face {
    font-family: "Helvetica Neue";
    src: local("Source Han Sans SC");
}

@font-face {
    font-family: "Helvetica";
    src: local("Source Han Sans SC");
}

@font-face {
    font-family: "Segoe UI";
    src: local("Source Han Sans SC");
}

@font-face {
    font-family: "Courier";
    src: local("Source Code Pro");
}

@font-face {
    font-family: "Courier New";
    src: local("Source Code Pro");
}

@font-face {
    font-family: "Consolas";
    src: local("Source Code Pro");
}


/* 字体替换：中文 (简体) */

@font-face {
    font-family: "SimSun";
    src: local("Source Han Sans SC");
}

@font-face {
    font-family: "SimSun-ExtB";
    src: local("Source Han Sans SC");
}

@font-face {
    font-family: "宋体";
    src: local("Source Han Sans SC");
}

@font-face {
    font-family: "NSimSun";
    src: local("Source Han Sans SC");
}

@font-face {
    font-family: "新宋体";
    src: local("Source Han Sans SC");
}

@font-face {
    font-family: "SimHei";
    src: local("Source Han Sans SC");
}

@font-face {
    font-family: "黑体";
    src: local("Source Han Sans SC");
}

@font-face {
    font-family: "Microsoft YaHei";
    src: local("Source Han Sans SC");
}

@font-face {
    font-family: "微软雅黑";
    src: local("Source Han Sans SC");
}

@font-face {
    font-family: "STHeiti SC";
    src: local("PingFang SC");
}


/* 字体替换：中文 (繁體) */

@font-face {
    font-family: "MingLiU";
    src: local("Source Han Sans TC");
}

@font-face {
    font-family: "MingLiU-ExtB";
    src: local("Source Han Sans TC");
}

@font-face {
    font-family: "MingLiU_HKSCS";
    src: local("Source Han Sans TC");
}

@font-face {
    font-family: "MingLiU_HKSCS-ExtB";
    src: local("Source Han Sans TC");
}

@font-face {
    font-family: "PMingLiU";
    src: local("Source Han Sans TC");
}

@font-face {
    font-family: "PMingLiU-ExtB";
    src: local("Source Han Sans TC");
}

@font-face {
    font-family: "Microsoft JhengHei";
    src: local("Source Han Sans TC");
}

@font-face {
    font-family: "微軟正黑體";
    src: local("Source Han Sans TC");
}

@font-face {
    font-family: "STHeiti TC";
    src: local("PingFang TC");
}
```
