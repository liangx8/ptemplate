/* Default linker script, for normal executables */
/* Copyright (C) 2014-2018 Free Software Foundation, Inc.
   Copying and distribution of this script, with or without modification,
   are permitted in any medium without royalty provided the copyright
   notice and this notice are preserved.  */
OUTPUT_FORMAT("elf32-avr","elf32-avr","elf32-avr")
OUTPUT_ARCH(avr:4)
__TEXT_REGION_LENGTH__ = DEFINED(__TEXT_REGION_LENGTH__) ? __TEXT_REGION_LENGTH__ : 8K;
__DATA_REGION_LENGTH__ = DEFINED(__DATA_REGION_LENGTH__) ? __DATA_REGION_LENGTH__ : 0xffa0;
__EEPROM_REGION_LENGTH__ = DEFINED(__EEPROM_REGION_LENGTH__) ? __EEPROM_REGION_LENGTH__ : 64K;
__FUSE_REGION_LENGTH__ = DEFINED(__FUSE_REGION_LENGTH__) ? __FUSE_REGION_LENGTH__ : 1K;
__LOCK_REGION_LENGTH__ = DEFINED(__LOCK_REGION_LENGTH__) ? __LOCK_REGION_LENGTH__ : 1K;
__SIGNATURE_REGION_LENGTH__ = DEFINED(__SIGNATURE_REGION_LENGTH__) ? __SIGNATURE_REGION_LENGTH__ : 1K;
__USER_SIGNATURE_REGION_LENGTH__ = DEFINED(__USER_SIGNATURE_REGION_LENGTH__) ? __USER_SIGNATURE_REGION_LENGTH__ : 1K;
MEMORY
{
  text   (rx)   : ORIGIN = 0, LENGTH = __TEXT_REGION_LENGTH__
  data   (rw!x) : ORIGIN = 0x800060, LENGTH = __DATA_REGION_LENGTH__
  eeprom (rw!x) : ORIGIN = 0x810000, LENGTH = __EEPROM_REGION_LENGTH__
  fuse      (rw!x) : ORIGIN = 0x820000, LENGTH = __FUSE_REGION_LENGTH__
  lock      (rw!x) : ORIGIN = 0x830000, LENGTH = __LOCK_REGION_LENGTH__
  signature (rw!x) : ORIGIN = 0x840000, LENGTH = __SIGNATURE_REGION_LENGTH__
  user_signatures (rw!x) : ORIGIN = 0x850000, LENGTH = __USER_SIGNATURE_REGION_LENGTH__
}
SECTIONS
{
  .text   :
  {
    *(.vectors)
    KEEP(*(.vectors))
  }  > text
  .data          :
  {
    *(.data)
     *(.data*)
  }  > data AT> text
  .bss  ADDR(.data) + SIZEOF (.data)   : AT (ADDR (.bss))
  {
     __bss_start = .;
    *(.bss)
     *(.bss*)
     __bss_end = .;
  }  > data
  .noinit  ADDR(.bss) + SIZEOF (.bss)  :  AT (ADDR (.noinit))
  {
     PROVIDE (__noinit_start = .) ;
    *(.noinit*)
     PROVIDE (__noinit_end = .) ;
     _end = . ;
     PROVIDE (__heap_start = .) ;
  }  > data
  .eeprom  :
  {
    /* See .data above...  */
    KEEP(*(.eeprom*))
     __eeprom_end = . ;
  }  > eeprom
  .fuse  :
  {
    KEEP(*(.fuse))
    KEEP(*(.lfuse))
    KEEP(*(.hfuse))
    KEEP(*(.efuse))
  }  > fuse
  .lock  :
  {
    KEEP(*(.lock*))
  }  > lock
  .signature  :
  {
    KEEP(*(.signature*))
  }  > signature
}
