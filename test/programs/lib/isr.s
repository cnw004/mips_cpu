#
# File: isr.s
# Description: Interrupt service routine handler function
# Author: Colin Heinzmann
#

.global __isr

.text
__isr:
	nop										# stall for 5 cycles to flush out the pipeline
	nop
	nop
	nop
	nop
	li $t0, 0							# run the exit function
	beq $v0, $t0, __isr_exit
	nop

__isr_print:						# prints a character from $a0 to the screen
	sb $a0, 0x1000
	jr $ra
	nop

__isr_exit:							# writes to the exit controller
	li $t0, 0
	sb $t0, 0x1001
	jr $ra
	nop
