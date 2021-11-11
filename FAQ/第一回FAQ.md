### 为什么不能直接给 ds 寄存器赋值立即数？
这个我不知道原因，但确实不能，读者给出了一个好的回答链接：https://www.zhihu.com/question/43608287

### 初始时 ds 指向了 0x07c0，那 cs 寄存器初始是多少？
见 Intel 手册 Volume 3A Chapter 9 PROCESSOR MANAGEMENT AND INITIALIZATION
![image](https://user-images.githubusercontent.com/25787738/141229578-e6c75b45-4048-43ba-a5e7-6c8d9d0ae53c.png)
