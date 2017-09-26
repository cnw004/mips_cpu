.global puts

.text
puts:
  add $t0, $a0, $zero               # x = $a0
  puts_loop:                        # -- start of the loop --
  lb $t1, 0($t0)                    # memory[x] get the character
  beqz $t1, puts_loop_end           # branch if char is 0
  nop
  sb $t1, 0x1000($zero)             # write byte to 0x1000 to output on MMIO
  addi $t0, $t0, 1                  # x += 1
  j puts_loop                       # go back to the top of the loop
  puts_loop_end:                    # -- end of the loop --
  li $v0, 0                         # load 0 into v0
  jr $ra
