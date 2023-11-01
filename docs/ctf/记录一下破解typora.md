# 了解了一下一种关于注入Node.js的破解Typora之法

因为我是一个`Misc`手嘛，所以比起他们那些`Bin`手，我只能试试去网上找工具来破解Typora了

## 起因

首先我的电脑在*2023年9月20日*因为网络原因（无法连接`Wifi`，而且DHCP分配不到IP）

所以我重装了电脑。然而有一些记录的需求但是重装电脑后没有Typora。

而我以前写Typora的时候，Typora还是免费的（最后一个免费版0.99，到了1.0就开始付费了）

所以重新下了一个，偶然感觉应该会有网上的破解，果然。
![](assets/image-20230925032302161.png)

## 发现

### 操作过程

- [一劳永逸破解 Typora 全系列 · Issue #8 · moxiaobei1993/blog (github.com)](https://github.com/moxiaobei1993/blog/issues/8)

### 破解验证脚本

- [DiamondHunters/NodeInject_Hook_example: A hooking example for NodeInject (github.com)](https://github.com/DiamondHunters/NodeInject_Hook_example)

### 自动注入代码工具

- [DiamondHunters/NodeInject: An inject tools for injecting js code into electron application (github.com)](https://github.com/DiamondHunters/NodeInject)

## 使用

### 首先我们先下载一个Typora,即使是这里下的也是可以的哦.

- [Typora 官方中文站 (typoraio.cn)](https://typoraio.cn/)



### 然后我们去GitHub上Clone这上面提过的两个项目

### 1.破解验证脚本 

https://github.com/DiamondHunters/NodeInject_Hook_example

### 2.自动注入代码工具

https://github.com/DiamondHunters/NodeInject

```bash
mkdir typora_hack											#创建一个地址用于放这两个项目
cd typora_hack   											#进入创建的文件夹内
git clone https://github.com/DiamondHunters/NodeInject_Hook_example.git   	#clone破解验证脚本
git clone https://github.com/DiamondHunters/NodeInject.git				   #clone自动注入代码工具
```

