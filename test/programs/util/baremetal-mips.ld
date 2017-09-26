OUTPUT_ARCH(mips)
ENTRY(__start)
SECTIONS
{
  . = 0x400000;
  .text : { *(.text) }
  . = 0x800000;
  .data : {
  	*(.got)
    *(.sdata)
    *(.data)
    *(.sbss)
    *(.bss)
    *(.rodata)
  }

}
