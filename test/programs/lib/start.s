#
# File: start.s
# Description: Startup code for microcontroller
#

.global __start

.text
__start:
  li $sp, 0x80f000                  # load the stack pointer to the bottom of the stack

  la $t0, __isr                     # set $t0 to the location of the ISR
  sw $t0, 0x00000000                # ^^

  jal main                          # jump to main
  nop

  li $v0, 0                         # send the "turn off" syscall operation
  syscall
