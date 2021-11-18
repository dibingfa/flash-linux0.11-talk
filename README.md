## 品读 Linux 0.11 核心代码

<p align='center'>
<a href="https://www.github.com/sunym1993" target="_blank"><img src="https://img.shields.io/badge/作者-闪客sun-2277cc.svg?style=flat-square&logo=GitHub"></a>
<a href="https://user-images.githubusercontent.com/25787738/141248489-c7dc20c1-cc5d-4a2d-bb5d-b5d8f9182058.jpg" target="_blank"><img src="https://img.shields.io/badge/公众号-低并发编程-009977.svg?style=flat-square&logo=WeChat"></a>
</p>

**目标**：带大家把 Linux 0.11 核心代码与操作系统的设计思想啃下来

**首发地址**：公众号 低并发编程

![qrcode_for_gh_711c6efc893a_258](https://user-images.githubusercontent.com/25787738/141248489-c7dc20c1-cc5d-4a2d-bb5d-b5d8f9182058.jpg)

**发文时间**：每周一和每周四

**开篇词**：[闪客新系列！你管这破玩意叫操作系统源码](https://mp.weixin.qq.com/s/tvbkGLfhDq03xxM-FZ4zuA)

**一些非必须的资料**：[资料包](https://github.com/sunym1993/flash-linux0.11-talk/tree/main/%E4%B8%80%E4%BA%9B%E9%9D%9E%E5%BF%85%E8%A6%81%E7%9A%84%E8%B5%84%E6%96%99)

**一些共性的问题**：[FAQ](https://github.com/sunym1993/flash-linux0.11-talk/tree/main/FAQ)

**一些读者分享和见解**：[读者分享](https://github.com/sunym1993/flash-linux0.11-talk/tree/main/%E8%AF%BB%E8%80%85%E5%88%86%E4%BA%AB)

**还有个有趣的事情大家可以共同参与进来**：[Intel手册翻译计划](https://github.com/sunym1993/flash-linux0.11-talk/tree/main/Intel%20%E6%89%8B%E5%86%8C%E4%B8%AD%E6%96%87%E7%89%88)

---

**架构图**

![架构图](https://user-images.githubusercontent.com/25787738/141248934-7b48b96c-dbb6-4f9e-a438-6f6f414c8113.png)

---

### 已发布文章：

[开篇词](https://mp.weixin.qq.com/s/tvbkGLfhDq03xxM-FZ4zuA)

* **第一部分：进入内核前的苦力活**

   * [第一回 最开始的两行代码](https://mp.weixin.qq.com/s/LIsqRX51W7d_yw-HN-s2DA)
   * [第二回 自己给自己挪个地儿](https://mp.weixin.qq.com/s/U-txDYt0YqLh5EeFOcB4NQ)
   * [第三回 做好最最基础的准备工作](https://mp.weixin.qq.com/s/90QBJ-lP_-du2qQJxNF-Fw)

* **第二部分：大战前期的初始化工作**

* **第三部分：一个新进程的诞生**

* **第四部分：shell 程序的到来**

* **第五部分：从一个命令的执行看操作系统各模块的运作**

* **第六部分：操作系统哲学与思想**
