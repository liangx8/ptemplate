ARCH=avr-
FORMAT=ihex
MCU=atmega48


CC=${ARCH}gcc
AS=${ARCH}as
OBJCOPY=${ARCH}objcopy
OBJDUMP=${ARCH}objdump
SIZE=${ARCH}size
HEX=main.hex
ELF=main.elf
LSS=main.lss

CSOURCE=$(shell ls *.c)
ASOURCE=$(shell ls *.S)

OBJS=${CSOURCE:.c=.o} ${ASOURCE:.S=.o}
CFLAGS=-c
CFLAGS += -O2 -Wall
CFLAGS += -mmcu=${MCU}
CFLAGS += -nodefaultlibs
CFLAGS += -nostartfiles

LFLAGS= #-T avr.ld

all:${HEX} ${LSS}
${HEX}:${ELF}
	${OBJCOPY} -O ${FORMAT} -R .eeprom -R .fuse -R .lock $< $@
${ELF}:${OBJS}
	${CC} $^ --output $@ ${LFLAGS}
${LSS}:${ELF}
	${OBJDUMP} -h -S -z $< >$@
.c.o:
	${CC} -c ${CFLAGS} $< -o $@
.S.o:
	${CC} -c ${CFLAGS} -g $< -o $@
clean:
	rm -rf ${OBJS} ${HEX} ${ELF} ${LSS}