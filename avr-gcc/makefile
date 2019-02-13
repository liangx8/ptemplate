ARCH=avr-
FORMAT=ihex
MCU=atmega48


AVRDUDE_TARGET = -c usbasp -p m48
AVRDUDE = avrdude

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

LFLAGS= -T avr.ld

HEXSIZE = ${SIZE} --target=${FORMAT} ${HEX}
ELFSIZE = ${SIZE} --mcu=${MCU} ${ELF}

all:sizebefore ${HEX} sizeafter ${LSS}
${HEX}:${ELF}
	${OBJCOPY} -O ${FORMAT} -R .eeprom -R .fuse -R .lock $< $@
${ELF}:${OBJS}
	${CC} $^ --output $@ ${LFLAGS}

sizebefore:
	@if test -f ${ELF}; then echo; echo "size before"; $(ELFSIZE); \
	2>/dev/null; echo; fi
sizeafter:
	@if test -f ${ELF}; then echo; echo "size after"; $(ELFSIZE); \
	2>/dev/null; echo; fi

${LSS}:${ELF}
	${OBJDUMP} -h -S -z $< >$@

disa:${HEX}
	${OBJDUMP} -m avr -D $< > disa.lss
fuse:
	$(AVRDUDE) ${AVRDUDE_TARGET} -U lfuse:w:0x62:m -U hfuse:w:0xdf:m -U efuse:w:0xfe:m
lock:
	$(AVRDUDE) ${AVRDUDE_TARGET} -U lock:w:0xfc:m
burn:$(TARGET).hex
	$(AVRDUDE) ${AVRDUDE_TARGET} -U flash:w:$<:i

readflash:
	$(AVRDUDE) ${AVRDUDE_TARGET} -U flash:r:"flash.hex":i

clean:
	rm -rf ${OBJS} ${HEX} ${ELF} *.lss


.c.o:
	${CC} -c ${CFLAGS} $< -o $@
.S.o:
	${CC} -c ${CFLAGS} -g $< -o $@
