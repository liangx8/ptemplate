
#include <avr/io.h>
    .global reset
    .section .vectors,"ax"
reset:
        rjmp    startup
        rjmp    __vector_1
        rjmp    __vector_2
        rjmp    __vector_3
        rjmp    __vector_4
        rjmp    __vector_5
        rjmp    __vector_6
        rjmp    __vector_7
        rjmp    __vector_8
        rjmp    __vector_9
        rjmp    __vector_10
        rjmp    __vector_11
        rjmp    __vector_12
        rjmp    __vector_13
        rjmp    __vector_14
        rjmp    __vector_15
        rjmp    __vector_16
        rjmp    __vector_17
        rjmp    __vector_18
        rjmp    __vector_19
        rjmp    __vector_20
        rjmp    __vector_21
        rjmp    __vector_22
        rjmp    __vector_23
        rjmp    __vector_24
        rjmp    __vector_25
.weak __vector_1
.set __vector_1,default_handler
.weak __vector_2
.set __vector_2,default_handler
.weak __vector_3
.set __vector_3,default_handler
.weak __vector_4
.set __vector_4,default_handler
.weak __vector_5
.set __vector_5,default_handler
.weak __vector_6
.set __vector_6,default_handler
.weak __vector_7
.set __vector_7,default_handler
.weak __vector_8
.set __vector_8,default_handler
.weak __vector_9
.set __vector_9,default_handler
.weak __vector_10
.set __vector_10,default_handler
.weak __vector_11
.set __vector_11,default_handler
.weak __vector_12
.set __vector_12,default_handler
.weak __vector_13
.set __vector_13,default_handler
.weak __vector_14
.set __vector_14,default_handler
.weak __vector_15
.set __vector_15,default_handler
.weak __vector_16
.set __vector_16,default_handler
.weak __vector_17
.set __vector_17,default_handler
.weak __vector_18
.set __vector_18,default_handler
.weak __vector_19
.set __vector_19,default_handler
.weak __vector_20
.set __vector_20,default_handler
.weak __vector_21
.set __vector_21,default_handler
.weak __vector_22
.set __vector_22,default_handler
.weak __vector_23
.set __vector_23,default_handler
.weak __vector_24
.set __vector_24,default_handler
.weak __vector_25
.set __vector_25,default_handler
    .section .text
startup:
    clr     r1
    ldi     r16,hi8(RAMEND)
    out     _SFR_IO_ADDR(SPH),r16
    ldi     r16,lo8(RAMEND)
    out     _SFR_IO_ADDR(SPL),r16
    rjmp    main
default_handler:
reti
