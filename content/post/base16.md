+++
title = "base16 - An architecture for building themes"
date = 2018-03-08T15:47:16+08:00
description = "An architecture for building themes based on carefully chosen syntax highlighting using a base of sixteen colours. Base16 provides a set of guidelines detailing how to style syntax and how to code a builder for compiling base16 schemes and templates."
categories = [ "emacs", "Themes"]
tags = [ "base16", "emacs"]
+++

![](/images/base16.png)

[An architecture for building themes](http://chriskempson.com/projects/base16) based on carefully chosen syntax highlighting using a base of sixteen colours. Base16 provides a set of guidelines detailing how to style syntax and how to code a builder for compiling base16 schemes and templates.

<!--more-->

## Styling Guidelines

Base16 aims to group similar language constructs with a single color, e.g. float, ints and doubles would belong to the same colour group. The colors chosen for the default theme were chosen to be easily separatable but scheme designer should pick whatever colours they desire e.g. base0B (green by default) could be replaced with red. However, there are general guidelines below that stipulate what base0B should be used to highlight when designing templates for editors.

Since describing syntax highlighting can be tricky, please see [base16-vim](https://github.com/chriskempson/base16-vim/) and [base16-textmate](https://github.com/chriskempson/base16-textmate/) for reference. Though it should be noted that each editor will have some discrepancies due the fact that editors generally have different syntax highlighting engines.

Colors base00 to base07 are typically variations of a shade and run from darkest to lighest. These colors are used for foreground and background, status bars, line highlighting and such. Colors base08 to base0F are typically individual colors used for types, operators, names and variables. In order to create a dark theme colors base00 to base07 should span from dark to light. For a light theme these colours should span from light to dark.

- **base00** - Default Background
- **base01** - Lighter Background (Used for status bars)
- **base02** - Selection Background
- **base03** - Comments, Invisibles, Line Highlighting
- **base04** - Dark Foreground (Used for status bars)
- **base05** - Default Foreground, Caret, Delimiters, Operators
- **base06** - Light Foreground (Not often used)
- **base07** - Light Background (Not often used)
- **base08** - Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
- **base09** - Integers, Boolean, Constants, XML Attributes, Markup Link Url
- **base0A** - Classes, Markup Bold, Search Text Background
- **base0B** - Strings, Inherited Class, Markup Code, Diff Inserted
- **base0C** - Support, Regular Expressions, Escape Characters, Markup Quotes
- **base0D** - Functions, Methods, Attribute IDs, Headings
- **base0E** - Keywords, Storage, Selector, Markup Italic, Diff Changed
- **base0F** - Deprecated, Opening/Closing Embedded Language Tags e.g. <?php ?>

## [base16-emacs](https://github.com/belak/base16-emacs)

```el
(use-package base16-theme
  :ensure t
  :config
  (load-theme 'base16-tomorrow-night t)
  )
```

Theme previews can be found [here](https://belak.github.io/base16-emacs/).
