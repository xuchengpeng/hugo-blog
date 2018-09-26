+++
title = "Go语言匿名结构"
date = 2018-09-26T16:47:46+08:00
draft = false
comments = true
mathjax = false
categories = [ "Study", "Go" ]
tags = [ "Go" ]
+++

Go语言也提供了继承，但是采用了组合的文法，所以我们将其称为匿名组合：

```go
type Base struct {
    Name string
}

func (base *Base) Foo() { ... }
func (base *Base) Bar() { ... }

type Foo struct {
    Base
    ...
}

func (foo *Foo) Bar() {
    foo.Base.Bar()
    ...
}
```

以上代码定义了一个Base类（实现了Foo()和Bar()两个成员方法），然后定义了一个Foo类，该类从Base类“继承”并改写了Bar()方法（该方法实现时先调用了基类的Bar()方法）。

在“派生类”Foo没有改写“基类”Base的成员方法时，相应的方法就被“继承”，例如在上面的例子中，调用foo.Foo()和调用foo.Base.Foo()效果一致。
<!--more-->

与其他语言不同，Go语言很清晰地告诉你类的内存布局是怎样的。此外，在Go语言中你还可以随心所欲地修改内存布局，如：

```go
type Foo struct {
    ... // 其他成员
    Base
}
```

这段代码从语义上来说，和上面给的例子并无不同，但内存布局发生了改变。“基类”Base的数据放在了“派生类”Foo的最后。

另外，在Go语言中，你还可以以指针方式从一个类型“派生”：

```go
type Foo struct {
    *Base
    ...
}
```

这段Go代码仍然有“派生”的效果，只是Foo创建实例的时候，需要外部提供一个Base类实例的指针。

在C++ 语言中其实也有类似的功能，那就是虚基类，但是它非常让人难以理解，一般C++的开发者都会遗忘这个特性。相比之下，Go语言以一种非常容易理解的方式提供了一些原本期望用虚基类才能解决的设计难题。

在Go语言官方网站提供的*Effective Go*中曾提到匿名组合的一个小价值，值得在这里再提一下。首先我们可以定义如下的类型，它匿名组合了一个log.Logger指针：

```go
type Job struct {
    Command string
    *log.Logger
}
```

在合适的赋值后，我们在Job类型的所有成员方法中可以很舒适地借用所有log.Logger提供的方法。比如如下的写法：

```go
func (job *Job)Start() {
    job.Log("starting now...")
    ... // 做一些事情
    job.Log("started.")
}
```

对于Job的实现者来说，他甚至根本就不用意识到log.Logger类型的存在，这就是匿名组合的魅力所在。在实际工作中，只有合理利用才能最大发挥这个功能的价值。

需要注意的是，不管是非匿名的类型组合还是匿名组合，被组合的类型所包含的方法虽然都升级成了外部这个组合类型的方法，但其实它们被组合方法调用时接收者并没有改变。比如上面这个Job例子，即使组合后调用的方式变成了job.Log(...)，但Log函数的接收者仍然是log.Logger指针，因此在Log中不可能访问到job的其他成员方法和变量。

这其实也很容易理解，毕竟被组合的类型并不知道自己会被什么类型组合，当然就没法在实现方法时去使用那个未知的“组合者”的功能了。

另外，我们必须关注一下接口组合中的名字冲突问题，比如如下的组合：

```go
type X struct {
    Name string
}

type Y struct {
    X
    Name string
}
```

组合的类型和被组合的类型都包含一个Name成员，会不会有问题呢？答案是否定的。所有的Y类型的Name成员的访问都只会访问到最外层的那个Name变量，X.Name变量相当于被隐藏起来了。

那么下面这样的场景呢：

```go
type Logger struct {
    Level int
}

type Y struct {
    *Logger
    Name string
    *log.Logger
}
```

显然这里会有问题。因为之前已经提到过，匿名组合类型相当于以其类型名称（去掉包名部分）作为成员变量的名字。按此规则，Y类型中就相当于存在两个名为Logger的成员，虽然类型不同。因此，我们预期会收到编译错误。

有意思的是，这个编译错误并不是一定会发生的。假如这两个Logger在定义后再也没有被用过，那么编译器将直接忽略掉这个冲突问题，直至开发者开始使用其中的某个Logger。
