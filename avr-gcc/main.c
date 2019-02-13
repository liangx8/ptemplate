#include <stdint.h>
#include <avr/io.h>
#include <avr/interrupt.h>


register uint8_t pwm_on asm("r2");
register uint8_t pwm_off asm("r3");
register uint8_t tcnt2h asm("r4");
register uint8_t tcnt0h asm("r5");
register uint8_t sreg_save asm("r6");

int main(void)
{
	while(1){
		PORTB = pwm_on;
	}
}


ISR(TIMER2_OVF_vect,ISR_NAKED){
	asm volatile("in %0,%1" : "=r" (sreg_save) : "I" (_SFR_IO_ADDR(SREG)));
	tcnt2h++;
	asm volatile("out %1,%0" : "=r" (sreg_save) : "I" (_SFR_IO_ADDR(SREG)));
	reti();
}
ISR(TIMER1_COMPA_vect,ISR_NAKED){
	// 消除编译 mov r24,r3 这句多余的代码,在中断中没有环境保存会影响程序运行
	asm volatile("out %1,%0" :"=r" (pwm_off) :"I" (_SFR_IO_ADDR(PORTD)): );
	//PORTD &= (uint8_t)~_BV(AN);
	reti();
}
ISR(TIMER1_OVF_vect,ISR_NAKED){
	asm volatile("out %1,%0" :"=r" (pwm_on) :"I" (_SFR_IO_ADDR(PORTD)): );
	//PORTD |= _BV(AN);
	reti();
}
ISR(TIMER0_OVF_vect,ISR_NAKED){
	asm volatile("in %0,%1" : "=r" (sreg_save) : "I" (_SFR_IO_ADDR(SREG)));
	tcnt0h++;
	//  asm volatile("set");
	asm volatile("out %1,%0" : "=r" (sreg_save) : "I" (_SFR_IO_ADDR(SREG)));
	reti();
}
