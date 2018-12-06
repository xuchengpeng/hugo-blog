+++
title = "Emacs 根据时间切换主题"
date = 2018-12-06T09:07:28+08:00
draft = false
comments = true
mathjax = false
categories = [ "Software", "emacs" ]
tags = [ "emacs" ]
+++

根据时间，自动切换亮色和暗色主题。

```el
(setq day-theme 'light-blue)
(setq dark-theme 'misterioso)
(defun synchronize-theme ()
    (setq hour
        (string-to-number
            (substring (current-time-string) 11 13)))
    (if (member hour (number-sequence 6 18))
        (setq now day-theme)
        (setq now dark-theme))
    (load-theme now)
)
(run-with-timer 0 3600 'synchronize-theme)
```
自动切换主题的包：[circadian.el](https://github.com/guidoschmidt/circadian.el)
<!--more-->

