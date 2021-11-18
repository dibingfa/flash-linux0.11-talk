### 为什么不能直接给 ds 寄存器赋值立即数？
这个我不知道原因，但确实不能，读者给出了一个好的回答链接：https://www.zhihu.com/question/43608287

### 初始时 ds 指向了 0x07c0，那 cs 寄存器初始是多少？
见 Intel 手册 Volume 3A Chapter 9 PROCESSOR MANAGEMENT AND INITIALIZATION
![image](https://user-images.githubusercontent.com/25787738/141229578-e6c75b45-4048-43ba-a5e7-6c8d9d0ae53c.png)

### 请问一下这里0x7c00加上第一扇区512字节的内容，这里应该为0x8c00才对吧？
这个问题在于没有理解两个事，一个是内存地址是表示 1 byte，并不是 1 bit。第二个是，一个内存地址是表示一个字节的低端位置，并不是高端位置。

当然，这只是个规定而已，具体见 Intel 手册 Volume 1 Chapter 1.3.1 Bit and Byte Order，这里还有个小端序的知识点，是这个问题的延伸。

![image](https://user-images.githubusercontent.com/25787738/141405075-282ba4df-31e7-4c31-ab58-533e29994a02.png)

### 昨天的两行代码后执行完后，且在ds没有更改之前，是不是以后的执行的每一条指令的物理地址都等于0x07c0<<4 + 偏移地址？
这个问题本身错了，在于不清楚 ds 寄存器只是数据访问的基地址，而不是代码。具体见 Intel 手册 Volume-1 3.4.2 Segment Registers，里面清晰表达了访问代码、数据、栈用的都是哪个段寄存器。

![image](https://user-images.githubusercontent.com/25787738/141405471-44a45263-df37-418a-bc47-3bf1f3729f64.png)

### CPU 刚启动时为什么能直接访问 BIOS 的代码？
@解答人：ShengHui
