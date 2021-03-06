+++
title = "Open vSwitch"
date = 2018-09-11T11:09:50+08:00
draft = false
comments = true
mathjax = false
categories = [ "Technology", "Cloud" ]
tags = [ "Open vSwitch", "OVS", "OpenFlow" ]
+++

Open vSwitch 是一个基于Apache 2 license的多层软件交换机。 我们的目标是实现一个支持标准管理接口的，开放转发功能以支持编程扩展和控制的交换机平台。

Open vSwitch 非常适合在VM环境中用作虚拟交换机。 除了将标准控制和可视化接口暴露给虚拟网络层外，它还旨在支持跨越多个物理服务器的分布式系统。 Open vSwitch 支持多种基于Linux的虚拟化技术，包括 Xen/XenServer, KVM, 及 VirtualBox。

大部分代码是平台无关的C编码，可以轻松地移植到其他环境中。 当前版本的 Open vSwitch 支持以下功能：

* 具有trunk和access口的标准 802.1Q VLAN 功能
* 上游交换机上连接或不链接LACP的NIC
* NetFlow, sFlow(R), 及镜像，以提高可视化
* QoS 配置，加上策列
* Geneve, GRE, VXLAN, STT, 及 LISP 隧道
* 802.1ag 连接故障管理
* OpenFlow 1.0 加大量扩展
* 具有C和Python绑定的事物配置数据库
* 使用Linux内核模块的高性能转发
* Linux 内核模块支持 Linux 3.10及以上版本。

Open vSwitch 也可以完全在用户空间运行，无需内核模块协助。 这个用户空间实现应该比基于内核的交换机更容易进行移植。 用户空间中的OVS可以访问Linux或DPDK设备。

> 使用用户空间实现，且没有用DPDK做加速处理的OVS被认为是测试性的，具有性能成本。

<!--more-->

### What's here?

OVS的主要组成成分如下：

* ovs-vswitchd, 实现交换机的守护进程，与Linux内核模块共同实现基于流的报文交换。
* ovsdb-server, 一个轻量级的数据库，ovs-vswitchd 查询以获取其配置信息。
* ovs-dpctl, 用于配置交换机内核模块的工具。
* Citrix XenServer and Red Hat Enterprise Linux中用于构建RPM包的脚本和规范。 XenServer RPMs 允许将Open vSwitch安装在Citrix XenServer主机上，作为替代其交换机的附加功能。
* ovs-vsctl, 用于查询和更新 ovs-vswitchd 的配置的实用程序。
* ovs-appctl, 一个向Open vSwitch守护进程发送命令的程序。

Open vSwitch 还提供了一些工具：

* ovs-ofctl, 用于查询和控制OpenFlow交换机和控制器的应用程序。
* ovs-pki, 用于创建和管理OpenFlow交换机的公钥设施的程序。
* ovs-testcontroller, 一个简单的OpenFlow控制器，对于测试非常有用(尽管不能用于生产)。
* tcpdump的补丁，使其能够解析OpenFlow消息。

### Wht Open vSwitch?

Hypervisors需要桥接VM和外部环境之间的流量。 在基于Linux的hypervisors中，这意味着使用Linux内置的L2交换机(Linux桥)，因为它是快速可靠的。 既然如此，为什么还要使用Open vSwitch呢？

主要原因是Open vSwitch针对的是多服务器的虚拟化部署，这是Linux桥不太适合的场景。 这些环境的特征通常是高度动态的端点，维护逻辑抽象，有时候还会与专用交换硬件集成。

Open vSwitch的如下特性和设计考虑有助于应对上面的需求。

#### 状态迁移

与网络实体（例如虚拟机）相关联的所有网络状态都应易于识别，并且可以在不同主机之间迁移。 这些状态包括传统的 “软状态” (如L2学习表中的条目)，L3 转发状态，策略路由状态，ACLs，QoS 策略，监控配置（例如NetFlow, IPFIX, sFlow）等。

Open vSwitch支持在实例之间配置和迁移慢/快网络状态。 例如，如果VM在终端主机之间迁移，则不仅可以迁移关联的配置(SPAN规则，ACLs，QoS)，而且可以迁移任何实时网络状态(包括有些难以重建的现有状态)。 此外，Open vSwitch状态是通过实际的数据模型进行打包和支持，允许开发结构化的系统。

#### 响应网络动态

虚拟环境通常以高变化率为特征。虚拟机迁移，在时间轴上移动，逻辑网络环境改变等等。

Open vSwitch支持许多功能，允许网络控制系统在环境变化时进行响应和调整。 包括简单的计数和可视化支持，如NetFlow, IPFIX, 和 sFlow。 但更有用的是，Open vSwitch支持远程触发的网络状态数据库(OVSDB)。因此，一段编排软件可以“观察”网络的各个方面，并在它们发生变化时进行响应。

Open vSwitch还支持OpenFlow作为远程控制流量的方法。 这有许多作用，包括通过检查链路状态流量（如LLDP、CDP、OSPF等）进行全局网络发现等。

#### 维护逻辑标签

分布式虚拟交换机（如VMware vDS 和 Cisco’s Nexus 1000V）通常通过在网络数据包中附加或操纵标签来维护网络中的逻辑上那个下文。 这可以用于唯一标识一个虚拟机（以一种抵御硬件欺骗的方式），或者保存一些仅在逻辑域中相关的其他上下文。 构建分布式虚拟交换机的许多问题就是有效和正确地管理这些标签。

Open vSwitch包含多个指定和维护标记规则的方法，所有这些方法都可以由远程编排程序访问。 此外，在许多情况下，这些标签规则以优化的形式存储，因此，他们不必与重量级网络设备耦合。 这使得数千个标记或地址重映射规则可以配配置、更改、迁移。

同样，Open vSwitch支持GRE实现，可以处理数千个同时的GRE隧道，并支持远程配置，以进行隧道创建、配置和删除。 这可以用于连接不同数据中心的专用VM网络。

#### 硬件集成

Open vSwitch的转发路径(内核中的数据通路)被设计为适合将数据包处理”下载”到硬件芯片组，无论是状态经典的硬件交换机机箱中，还是在终端主机NIC中。 这允许Open vSwitch控制路径能够控制数据转发由纯软件实现或硬件交换机实现。

现在已经有许多人在进行将Open vSwitch移植到硬件芯片组上了。 包括许多商业芯片厂商(如Broadcom 和 Marvell)以及许多供应商特定的硬件平台。

硬件集成的优点不仅在于虚拟化环境中的性能。 如果物理交换机还提供了Open vSwitch抽象控制，则可以使用同样的自动化网络控制机制来管理裸机和虚拟化主机环境。

#### 小结

在许多方面上，Open vSwitch的设计目标与以前的虚拟机管理程序网络栈不同，主要集中在大规模的基于Linux的虚拟化环境中对自动化和动态网络控制的需求。

Open vSwitch 的目标是尽可能保持内核中的代码尽可能少（除非性能所必须），并在适用时重新使用现有的子系统（如Open vSwitch现有的QoS栈）。 从Linux3.3开始，Open vSwitch作为内核的一部分被包含，用户空间实用程序的封装在大多数流行发行版本中都可用。
