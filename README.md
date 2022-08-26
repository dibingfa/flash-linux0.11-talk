## 品读 Linux 0.11 核心代码

<p align='center'>
<a href="https://www.github.com/sunym1993" target="_blank"><img src="https://img.shields.io/badge/作者-闪客sun-2277cc.svg?style=flat-square&logo=GitHub"></a>
<a href="https://user-images.githubusercontent.com/25787738/141248489-c7dc20c1-cc5d-4a2d-bb5d-b5d8f9182058.jpg" target="_blank"><img src="https://img.shields.io/badge/公众号-低并发编程-009977.svg?style=flat-square&logo=WeChat"></a>
</p>

**目标**：带大家把 Linux 0.11 核心代码与操作系统的设计思想啃下来

**首发地址**：公众号 低并发编程

![qrcode_for_gh_711c6efc893a_258](https://user-images.githubusercontent.com/25787738/141248489-c7dc20c1-cc5d-4a2d-bb5d-b5d8f9182058.jpg)

**发文时间**：每周一和每周四

**互动方式**：微信群（关注公众号并回复“os”）

**创作番外故事**：[知识星球](https://mp.weixin.qq.com/s/NFUgJ4-hIyrs1sQr8AUCvA)

**开篇词**：[闪客新系列！你管这破玩意叫操作系统源码](https://mp.weixin.qq.com/s/tvbkGLfhDq03xxM-FZ4zuA)

**一些非必须的资料**：[资料包](https://github.com/sunym1993/flash-linux0.11-talk/tree/main/%E4%B8%80%E4%BA%9B%E9%9D%9E%E5%BF%85%E8%A6%81%E7%9A%84%E8%B5%84%E6%96%99)

**一些共性的问题**：[FAQ](https://github.com/sunym1993/flash-linux0.11-talk/tree/main/FAQ)

**一些读者分享和见解**：[读者分享](https://github.com/sunym1993/flash-linux0.11-talk/tree/main/%E8%AF%BB%E8%80%85%E5%88%86%E4%BA%AB)

**还有个有趣的事情大家可以共同参与进来**：[Intel手册翻译计划](https://github.com/sunym1993/flash-linux0.11-talk/tree/main/Intel%20%E6%89%8B%E5%86%8C%E4%B8%AD%E6%96%87%E7%89%88)

当然，欢迎大家一同维护这个项目，有关操作系统普及的各种信息，都可以发起 PR 提交

---

**架构图**

![架构图](https://user-images.githubusercontent.com/25787738/163914291-4aba48d7-f49e-4557-a4c4-d9ff07a20894.png)

---

### 已发布文章：

[开篇词](https://mp.weixin.qq.com/s/tvbkGLfhDq03xxM-FZ4zuA)

* **第一部分：进入内核前的苦力活**

   * [第1回 最开始的两行代码](https://mp.weixin.qq.com/s/LIsqRX51W7d_yw-HN-s2DA)
   * [第2回 自己给自己挪个地儿](https://mp.weixin.qq.com/s/U-txDYt0YqLh5EeFOcB4NQ)
   * [第3回 做好最最基础的准备工作](https://mp.weixin.qq.com/s/90QBJ-lP_-du2qQJxNF-Fw)
   * [第4回 把自己在硬盘里的其他部分也放到内存来](https://mp.weixin.qq.com/s/hStc-y-sabP-KwJUDUesTw)
   * [第5回 进入保护模式前的最后一次折腾内存](https://mp.weixin.qq.com/s/5s_nmrWRZbA_4mkNKOQ2Cg)
   * [第6回 先解决段寄存器的历史包袱问题](https://mp.weixin.qq.com/s/p1a6QxYZyMpJF__uBSE1Kg)
   * [第7回 六行代码就进入了保护模式](https://mp.weixin.qq.com/s/S5zarr9BmLhUHAmdmeNypA)
   * [第8回 烦死了又要重新设置一遍 idt 和 gdt](https://mp.weixin.qq.com/s/ssQKFMehxZxWT9i6mdRtXg)
   * [第9回 Intel 内存管理两板斧：分段与分页](https://mp.weixin.qq.com/s/q2wU9IbX54t_GAuc9V5r7A)
   * [第10回 进入 main 函数前的最后一跃！](https://mp.weixin.qq.com/s/ISyaX5zPWRw_d-9zvZUPUg)
   * [第一部分总结与回顾](https://mp.weixin.qq.com/s/8bP3feeF_A13j7ysWur_JQ)

* **第二部分：大战前期的初始化工作**

   * [第11回 整个操作系统就20几行代码](https://mp.weixin.qq.com/s/kYBrMgHt7C9EmAcwJIPIxg)
   * [第12回 管理内存前先划分出三个边界值](https://mp.weixin.qq.com/s/eoBFcgm0QrHOVi_WoS7PwA)
   * [第13回 主内存初始化 mem_init](https://mp.weixin.qq.com/s/_rTmjHIDCV9ADiJlfo5B3g)
   * [第14回 中断初始化 trap_init](https://mp.weixin.qq.com/s/sFp_388qRncB-jpJeRzCGQ)
   * [第15回 块设备请求项初始化 blk_dev_init](https://mp.weixin.qq.com/s/pIbVY1XPCktxGogc4lI1Bw)
   * [第16回 控制台初始化 tty_init](https://mp.weixin.qq.com/s/yIrzEWUUuZC9OsiuU_lOaw)
   * [第17回 时间初始化 time_init](https://mp.weixin.qq.com/s/y26MMfj8pP5PmbKDZBT5-A)
   * [第18回 进程调度初始化 sched_init](https://mp.weixin.qq.com/s/j4FYWUSX_2gpDb_h4vEFqQ)
   * [第19回 缓冲区初始化 buffer_init](https://mp.weixin.qq.com/s/X8BSbf1qShS11_fzfyOhTg)
   * [第20回 硬盘初始化 hd_init](https://mp.weixin.qq.com/s/803C9jHxIe42i9BrNzEvPA)
   * [第二部分总结与回顾](https://mp.weixin.qq.com/s/Hf9B1ww1wFxiUDkWb0obeQ)

* **第三部分：一个新进程的诞生**

   * [第21回 新进程诞生全局概述](https://mp.weixin.qq.com/s/H_OCZ2ZtGHWHge_rYKCkJw)
   * [第22回 从内核态切换到用户态](https://mp.weixin.qq.com/s/AVl6R2N9d_sldkhfvC6aEw)
   * [第23回 如果让你来设计进程调度](https://mp.weixin.qq.com/s/Sf9vV7RCnVDlBKXx5jXs1Q)
   * [第24回 从一次定时器滴答来看进程调度](https://mp.weixin.qq.com/s/yFre8Qv_ZCtjRkTS49n6rw)
   * [第25回 通过 fork 看一次系统调用流程](https://mp.weixin.qq.com/s/rYBSH_AZDwgc8knSKDSSxA)
   * [第26回 fork 中进程基本信息的复制](https://mp.weixin.qq.com/s/8cy-xX3ekeqHelrFcYFkvw)
   * [第27回 fork 中进程内存规划的问题](https://mp.weixin.qq.com/s/d2pHFSbTLb-nv2C_RfKlVA)
   * [第三部分总结与回顾](https://mp.weixin.qq.com/s/V_Ryxox3iDCO994FzkSFfA)
   * [第28回 番外篇 - 我居然会认为权威书籍写错了...](https://mp.weixin.qq.com/s/JzCy_4RPhy17_G6KbY3f2g)
   * [第29回 番外篇 - 让我们一起来写本书？](https://mp.weixin.qq.com/s/NFUgJ4-hIyrs1sQr8AUCvA)
   * [第30回 番外篇 - 写时复制就这么几行代码](https://mp.weixin.qq.com/s/Pdnmys_hGoToZN193rfnoQ)

* **第四部分：shell 程序的到来**

   * [第31回 | 拿到硬盘信息](http://mp.weixin.qq.com/s?__biz=Mzk0MjE3NDE0Ng==&mid=2247502161&idx=1&sn=219186a1e587f40308515852d293aaf4&chksm=c2c5b3fcf5b23aead170092d4042abd54b272694cbaac3f750eb3adea584ee29653c72ad2915&scene=21#wechat_redirect)
   * [第32回 | 加载根文件系统](http://mp.weixin.qq.com/s?__biz=Mzk0MjE3NDE0Ng==&mid=2247502181&idx=1&sn=b6dcbd1d2cf930002852008a1c4e6a65&chksm=c2c5b3c8f5b23ade1532b725995dbc3b0138202555e44a6e308b84d668a2ef3041eb5cf77f86&scene=21#wechat_redirect)
   * [第33回 | 打开终端设备文件](http://mp.weixin.qq.com/s?__biz=Mzk0MjE3NDE0Ng==&mid=2247502230&idx=1&sn=44e023bf0b9b37261e35a6e3722bc57f&chksm=c2c5b33bf5b23a2d10a9dd36606c497f41a1c3dced57845ce7ef12741a348fab82beba462a8a&scene=21#wechat_redirect)
   * [第34回 | 进程2的创建](http://mp.weixin.qq.com/s?__biz=Mzk0MjE3NDE0Ng==&mid=2247502269&idx=1&sn=19f6831de5bac0d8a588b80757dbb1f4&chksm=c2c5b310f5b23a0633df6a75e36f4dae515e9d9aee1fa046888573e3d60e62752612edae536a&scene=21#wechat_redirect)
   * [第35回 | execve 加载并执行 shell 程序](http://mp.weixin.qq.com/s?__biz=Mzk0MjE3NDE0Ng==&mid=2247502475&idx=1&sn=4fcdbaa03bf6a1ca04db4013309c6aa3&chksm=c2c5b026f5b2393049efca68c429df5038fa0f317eea79fbd9ec2c661c3ec12b47a0701376a7&scene=21#wechat_redirect)
   * [第36回 | 缺页中断](http://mp.weixin.qq.com/s?__biz=Mzk0MjE3NDE0Ng==&mid=2247502511&idx=1&sn=eacddbb11dd2402c561a611f708ee045&chksm=c2c5b002f5b23914ccd645d94bdc59e0322776f71f41e6744fddeca2bfa027d12a25ec6bfc8a&scene=21#wechat_redirect)
   * [第37回 | shell 程序跑起来了](http://mp.weixin.qq.com/s?__biz=Mzk0MjE3NDE0Ng==&mid=2247502581&idx=1&sn=df3f2c19ce511ac24145091892f47837&chksm=c2c5b058f5b2394ee095d679071b43c23853dc86d5cfd4cc961568643110ab734f635b899984&scene=21#wechat_redirect)
   * [第38回 | 操作系统启动完毕](http://mp.weixin.qq.com/s?__biz=Mzk0MjE3NDE0Ng==&mid=2247502613&idx=1&sn=d7e85595323d3de138e5ac52bf8e61dd&chksm=c2c5b1b8f5b238ae8785f45bf83434839689e7e5a697026d9ebde5738f11a83c4379a16c349f&scene=21#wechat_redirect)
   * [第39回 | 番外篇 - Linux 0.11 内核调试](http://mp.weixin.qq.com/s?__biz=Mzk0MjE3NDE0Ng==&mid=2247502498&idx=1&sn=01cf816694f74ca8437374a9aa23ab64&chksm=c2c5b00ff5b23919c43ac96a38bc8b09f42ea17f92ea933157db3e7f0c77bb876bf7d0524afa&scene=21#wechat_redirect)
   * [第40回 | 番外篇 - 为什么你怎么看也看不懂](http://mp.weixin.qq.com/s?__biz=Mzk0MjE3NDE0Ng==&mid=2247502517&idx=1&sn=d6a20fb6ad50da584ac32e60823a1834&chksm=c2c5b018f5b2390e690c465aa35d822d14a23a2b76587303e9374aca431a718e1b104569efe4&scene=21#wechat_redirect)
   * [第四部分总结与回顾](http://mp.weixin.qq.com/s?__biz=Mzk0MjE3NDE0Ng==&mid=2247502650&idx=1&sn=ad947d70d372a1bc46741c459fd0ef9a&chksm=c2c5b197f5b23881a5e61c5581300beb4b3f1db8cab79eabec22fd847f1cdc0e11d3a713fd9f&scene=21#wechat_redirect)

* **第五部分：从一个命令的执行看操作系统各模块的运作**

   * [第41回 | 番外篇 - 跳票是不可能的](http://mp.weixin.qq.com/s?__biz=Mzk0MjE3NDE0Ng==&mid=2247502821&idx=1&sn=0ffa47028dfa013ead148f06d90fbb33&chksm=c2c5b148f5b2385e7d3f213517eb387ff85a1d94977788a2558e31194c5dcd0afb003c98ecaf&scene=21#wechat_redirect)
   * [第42回 | 用键盘输入一条命令](http://mp.weixin.qq.com/s?__biz=Mzk0MjE3NDE0Ng==&mid=2247502876&idx=1&sn=2c34491abd6ea14c9c7ccc3d2d9827c1&chksm=c2c5b6b1f5b23fa7bdf9c3e2bf811b84da937d30a2c9825ceba8a57c2c3e8e157dedae0bfc8d&scene=21#wechat_redirect)
   * [第43回 | shell 程序读取你的命令](http://mp.weixin.qq.com/s?__biz=Mzk0MjE3NDE0Ng==&mid=2247502944&idx=1&sn=cf2601b43a4bc3f89d7a517cbf7fd588&chksm=c2c5b6cdf5b23fdb306af852e9293bb64df019bffa3c403e6fa59b856b7bddd77a42e5fc75eb&scene=21#wechat_redirect)
   * [第44回 | 进程的阻塞与唤醒](https://mp.weixin.qq.com/s/HFQL5d-C24DKjQbYAQfl8g)
   * [第45回 | 解析并执行 shell 命令](http://mp.weixin.qq.com/s?__biz=Mzk0MjE3NDE0Ng==&mid=2247503139&idx=1&sn=652316c29be5ba983fbb658ce58443d8&chksm=c2c5b78ef5b23e980870ff66f066a624f9a5d61bd73f550d5579e745f60335dfb489dcf977d8&scene=21#wechat_redirect)
   * [第46回 | 读硬盘数据全流程](http://mp.weixin.qq.com/s?__biz=Mzk0MjE3NDE0Ng==&mid=2247503204&idx=1&sn=e00ee5e3584a7ecfaaec47ccf63c0555&chksm=c2c5b7c9f5b23edfd17396399772549674b5233add6062c4d236d4727650b3bd97742a202967&scene=21#wechat_redirect)
   * [第47回 | 读取硬盘数据的细节](http://mp.weixin.qq.com/s?__biz=Mzk0MjE3NDE0Ng==&mid=2247503228&idx=1&sn=e73ea3c148ecb7a15c9ef93b36b8a5cb&chksm=c2c5b7d1f5b23ec7f92fd29e2fe179d3122ed5180fb8054a0859afa1391c5c4314cf8c05ba45&scene=21#wechat_redirect)
   * [第48回 | 信号](https://mp.weixin.qq.com/s?__biz=Mzk0MjE3NDE0Ng==&mid=2247503287&idx=1&sn=62e5c9ea5142960a4cb02e18e2a6bdb3&chksm=c2c5b71af5b23e0cfaeb5151397436f213e82ffe0673b8a841b7b557815d377ca9ae563f19d0&scene=178&cur_album_id=2123743679373688834#rd)

## Star History

[![Star History Chart](https://api.star-history.com/svg?repos=sunym1993/flash-linux0.11-talk&type=Date)](https://star-history.com/#sunym1993/flash-linux0.11-talk&Date)

