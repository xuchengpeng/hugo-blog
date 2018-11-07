+++
title = "Ubuntu安装Samba"
date = 2018-11-07T08:59:03+08:00
draft = false
comments = true
mathjax = false
categories = [ "Technology", "Linux" ]
tags = [ "Linux", "Samba", "Ubuntu" ]
+++

```shell
apt-get install samba
```

修改 /etc/samba/smb.conf 文件：
```
[share]
  path = /
  available = yes
  valid users = root
  read only = no
  browseable = yes
  public = yes
  writable = yes
```

修改Samba登陆的密码：
```shell
smbpasswd -a root
```

> 这里也可以使用非root用户，必须是Linux系统中已存在的用户。

重启Samba服务：
```shell
/etc/init.d/smbd restart
```
<!--more-->

