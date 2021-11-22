			iAPX 86 Interrupt Primer
			------------------------

			     by Ralf Brown
				 12/87
		    Updated 6/88, 4/90, 9/92, 1/97


What is an interrupt?
---------------------
   An interrupt is a hardware signal that tells the CPU to temporarily
   stop what it is doing and go do something else.  Without interrupts,
   the CPU would have to constantly check for external events; with
   interrupts, the CPU can work on something else and still respond to
   an event as soon as it occurs. 

   CPUs typically have an instruction to disable interrupts for use
   when a section of code has to run without being disturbed by
   external events.  Because of this, most CPUs also have a special
   interrupt called a Non-Maskable Interrupt (NMI), which is responded
   to even when all other interrupts are disabled.  The NMI is used to
   signal calamities such as memory failure or imminent power loss.

Why so many different interrupts?
---------------------------------
   The 8086 family of processors has the ability to recognize 256
   different interrupts.  They also have the ability to let a program
   invoke any of these interrupts with a special instruction, known as
   a software interrupt (as opposed to a hardware interrupt which is
   signalled from outside the processor).  Software interrupts are
   treated just like hardware interrupts, except that they are never
   disabled and do not result in an acknowledgement to other chips in
   the computer.  The software interrupt instruction on the 8086 family
   is called INT, and is given the number of the interrupt.  Thus an
   INT 21h instruction invokes interrupt number 33 decimal.

   Other processors also have software interrupts, though they often
   use different names, such as the Motorola 68000 family TRAP
   instruction, the Intel 8080 RST (ReSTart) instruction, or many
   mainframes' SVC (SuperVisor Call). 

   Since a program can invoke an interrupt by number rather than by its
   address (as it has to in calling subroutines), interrupts are a
   convenient way of providing services without having to recompile a
   program whenever the address of the code providing the service
   changes.  This also allows a user program to enhance the services
   provided by directing the interrupt to itself.  These enhanced
   services can then be made available to other programs.

How does an interrupt work in real-address mode?
------------------------------------------------
   The 8086 reserves the lowest 1024 bytes of memory for a table (IVT,
   Interrupt Vector Table) containing the addresses for each of the 256
   possible interrupts.  When an interrupt occurs (hardware or
   software), the processor multiplies its number by 4 and looks at the
   resulting memory location to find the address of the piece of code
   which handles the interrupt.  It then places the current address in
   the program and the processor flags on the stack, and jumps to the
   beginning of the interrupt handler.

   When the interrupt handler finishes, it invokes a special
   instruction to return from the interrupt.  This instruction takes
   the previously saved flags and program address off of the stack and
   places them back in the appropriate registers in the CPU.

   The interrupt handler has to be careful to preserve any registers
   that it uses which are not used to communicate results to the
   program that invoked the interrupt.  If the interrupt can be
   triggered by a hardware interrupt (only certain ones can on IBM
   PC's, XT's, and AT's), then the interrupt handler has to preserve
   ALL registers, since the interrupt could have happened anywhere.

How does an interrupt work in protected mode?
---------------------------------------------
   The 80286 and later processors can also operate in protected mode,
   in which case the interrupt handling is somewhat different.  First,
   the interrupt table consists of eight-byte descriptors instead of
   four-byte addresses, and need not be located at physical address
   zero, nor contain the full 256 entries (the address and size of the
   Interrupt Descriptor Table (IDT) may be manipulated with the LIDT
   and SIDT instructions).

   Second, in protected mode, the descriptor for an interrupt number
   specifies HOW control is transferred to the interrupt handler.
   Three types of transfer are possible: Interrupt Gate, Trap Gate,
   and Task Gate.  The first two types transfer control to a handler
   running in the same process as the active program, while a Task Gate
   performs a complete context switch in order to invoke a handler in
   a different process from the active program.  Interrupt and Trap
   gates are identical except that an Interrupt Gate will clear IF
   and thus disable interrupts, while a Trap Gate leaves IF unchanged.

How does an interrupt work in virtual-86 (V86) mode?
----------------------------------------------------
   The 80386 and later processors provide a virtual-8086 mode which is
   a protected mode that appears to software to be the same as Real
   mode.  Because it is a protected mode, however, interrupts and
   various other actions that potentially affect system integrity do
   not execute directly, but instead invoke a supervisor program running
   in standard protected mode.  Thus, whenever a program running in
   V86 mode invokes an interrupt call, the CPU switches to protected
   mode and transfers control to the interrupt handler specified by
   the protected-mode IDT, rather than the real-mode IVT.  The
   supervisor program may handle the interrupt call in any way it
   likes, but typically switches the CPU back into V86 mode and jumps
   to the address specified in the real-mode IVT (a process which is
   known as "reflecting" the interrupt).


GLOSSARY
--------
API (Application Program[ming] Interface)
   An API is the set of function calls and services that a program
   makes available to other processes (applications).  Each function or
   service has a set format which specifies the values to be supplied
   by the caller and the values which are returned. Because of this
   interface specification, the underlying organization of the function
   or service can be changed without affecting the applications which
   use it.  For example, the DOS INT 21h file access functions remained
   unchanged between DOS 2.x and DOS 3.x, even though the internal data
   structures and code organization changed significantly.

IDT (Interrupt Descriptor Table)

IVT (Interrupt Vector Table)

NMI (Non-Maskable Interrupt)
   Most external (hardware) interrupts can be disabled by the CLI
   (CLear Interrupt enable flag) instruction when the CPU is executing
   critical code that should not be interrupted, such as switching from
   one stack to another.  However, there are some situations so dire
   that the CPU must act on them immediately no matter what else it is
   doing, even if it has disabled interrupts.  The Non-Maskable
   Interrupt serves precisely this purpose, as it cannot be disabled
   (masked) by the CPU.
