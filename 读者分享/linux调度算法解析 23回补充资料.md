23回补充内容 by sn：

0.11 的调度函数 schedule，在文件 kernel/sched.c 中定义为：

```c
while (1) {
    c = -1; next = 0; i = NR_TASKS; p = &task[NR_TASKS];

// 找到 counter 值最大的就绪态进程
    while (--i) {
        if (!*--p)    continue;
        if ((*p)->state == TASK_RUNNING && (*p)->counter > c)
            c = (*p)->counter, next = i;
    }

// 如果有 counter 值大于 0 的就绪态进程，则退出
    if (c) break;

// 如果没有：
// 所有进程的 counter 值除以 2 衰减后再和 priority 值相加，
// 产生新的时间片
    for(p = &LAST_TASK ; p > &FIRST_TASK ; --p)
          if (*p) (*p)->counter = ((*p)->counter >> 1) + (*p)->priority;
}

// 切换到 next 进程
switch_to(next);
```


由上面的程序可以看出，0.11 的调度算法是选取 `counter` 值最大的就绪进程进行调度。
当没有 counter 值大于 0 的就绪进程时，要对所有的进程做 `(*p)->counter = ((*p)->counter >> 1) + (*p)->priority`。
其效果是对所有的进程（**包括阻塞态进程**）都进行 counter 的衰减，并再累加 priority 值。这样，对正被阻塞的进程来说，其此时的counter不为0，那么计算后得到的counter大于就绪态进程。
于是可知，**一个进程在阻塞队列中停留的时间越长，其优先级越大，被分配的时间片也就会越大**。


所以总的来说，Linux 0.11 的进程调度是一种**综合考虑进程优先级并能动态反馈调整时间片的轮转调度算法**。



## 进程 counter 是如何初始化的

首先回答第一个问题，显然这个值是在 fork() 中设定的。Linux 0.11 的 `fork()` 会调用 `copy_process()` 来完成从父进程信息拷贝（所以才称其为 fork），看看 `copy_process()` 的实现，会发现其中有下面两条语句：

```c
// 用来复制父进程的PCB数据信息，包括 priority 和 counter
*p = *current;

// 初始化 counter
p->counter = p->priority;
// 因为父进程的counter数值已发生变化，而 priority 不会，所以上面的第二句代码将p->counter 设置成 p->priority。
// 每个进程的 priority 都是继承自父亲进程的，除非它自己改变优先级。
```

①假设没有改变优先级，时间片的初值就是进程 0 的 priority，即宏 INIT_TASK 中定义的：
```c
#define INIT_TASK \
    { 0,15,15,
// 上述三个值分别对应 state、counter 和 priority;
```

## 当进程的时间片用完时，被重新赋成何值？

接下来回答第二个问题，当就绪进程的 counter 为 0 时，不会被调度（schedule 要选取 counter 最大的，大于 0 的进程），而当所有的就绪态进程的 counter 都变成 0 时，会执行下面的语句：

```c
(*p)->counter = ((*p)->counter >> 1) + (*p)->priority;
```
算出的新的 counter 值也等于 priority，即初始时间片的大小。
