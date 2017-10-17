.text
.global puts

# puts uses syscall 4, $a0 is the address of a
# null terminated string.
# the cpu simulator will have to trap this and
# generate a $display call

puts:
    li $v0, 4
    j loop

loop:
  lw $a1, 0($a0)
  addi $a0 $a0, 4
  beq $a1, $zero, exit
  syscall



exit:
  li $v0, 10
  syscall
