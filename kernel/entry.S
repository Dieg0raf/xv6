        # qemu -kernel loads the kernel at 0x80000000
        # and causes each hart (i.e. CPU) to jump there.
        # kernel.ld causes the following code to
        # be placed at 0x80000000.
.section .text
.global _entry
_entry:
        # set up a stack for C.
        # stack0 is declared in start.c,
        # with a 4096-byte stack per CPU.
        # sp = stack0 + ((hartid + 1) * 4096)

        # MOST RISC-V instructions
        # instruction destination, source1, source2

        # Immediate
        # instruction destination, immediate_value

        # Function Call
        # call label

        la sp, stack0 # (Load address) of stack0 into sp (stack pointer)
        li a0, 1024*4 # (Load Immediate) value 4096 into register a0
        csrr a1, mhartid # (Control and Status Register Read) - Reads mhartid(machine hardware thread ID) into a1 (gives us CPU core number 0,1,2,etc.)
                         # Each CPU stack = kernel stack each CPU will use when executing kernel code
        addi a1, a1, 1 # (Add Immediate) value 1 to the hard ID (CPU 0 becomes 1, CPU 1 becomes 2, etc.)
        mul a0, a0, a1  # (Multiply) - a0 = a0 * a1
        add sp, sp, a0 # (Add) - adds the values in sp and a0, stores result in sp
        # jump to start() in start.c
        call start
spin:
        j spin
