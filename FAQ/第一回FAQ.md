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
可以分两部分来解释：1.CPU的硬件通路可以直接访问BIOS的地址。2.CPU复位后的硬件地址在BIOS所在的地址。  
首先解释1。在设计CPU时会把CPU可以访问的地址进行划分，包括片内的ram，寄存器等，和片外的ROM，DDR，其他外设等。当CPU访问这些被提前划分好的地址时，会有不同的手段。比如对于 `UINT32 a=*(volatile UINT32)0x1000;` 来说，如果`0x1000`地址被分配至片内ram，则CPU会通过片内总线读取这段地址，如果被分配至片外，则会通过相应的总线进行访问。BIOS通常指代存在BIOS芯片中的程序，而BIOS芯片实际上就是一个ROM存储器，大部分是FLASH，BIOS程序由厂商固化至其中。CPU的硬件通路可直接通过外设总线（通常是SPI）访问其中内容。  
再来解释2。CPU在上电复位后一定是从一个确定的地址启动，该地址（在PC机的结构下）被分配至BIOS所在的地址，并由内部硬件逻辑控制。其他类型的CPU可能会被分配至其他片内/片外存储器上，如51在0地址启动，MIPS大多在`0xBF400000`,不同的CPU复位启动地址可能会不同。 如果想了解更多可继续向下看，本人也不专业，仅做原理说明。   
咨询了一下大佬，硬件复位逻辑EDA的实现大致如下：
```
always@(negedge rstn or posedeg clk)
 if(~rst)
  begin
   reg<=0;
  end
 else
  begin
   reg<=wire;
  end
```
简单解释下就是，当芯片复位（假设高有效）之前，寄存器会被赋一个初值，且如果RST没有被放开则所有的逻辑都会被强制拉住，不会有任何动作。RST有效之后，硬件逻辑才会开始工作，对于CPU来讲就从指令地址寄存器（已被初始化）中取到第一个指令的地址，如果从这个地址拿到了有效指令，那么就开始一条一条的跑下去了。因而可以看到，硬件复位地址完全由设计人员决定，不必太过于纠结为何如此，仅需参考芯片手册即可。  
