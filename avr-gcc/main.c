#include <avr/io.h>
#include <avr/interrupt.h>
#include <stdint.h>

//register uint8_t tcnt2h asm("r4");
register uint8_t tcnt0h asm("r5");
register uint8_t sreg_save asm("r6");

uint16_t tcnt2h;

void timer_init(void)
{
	// timer1(16 bit) setting
	// WGM1{3:0}=1000
	// CS1{2:0}=010 8 PRESCALE
	TCCR1A = 0;// WGM11 | WGM10;
	TCCR1B = _BV(CS11) | _BV(WGM13); // | WGM12 | WGM13;
	ICR1 = 20000; // TOP = 20000
	OCR1A = 2000;
	TIMSK1 = _BV(TOIE1) | _BV(OCF1A);

	// timer2(8bit) setting
	// WGM2{2:0}=101
	TCCR2A = _BV(WGM20);
	TCCR2B = _BV(WGM22) | _BV(CS21);
	OCR2A = 200;
	TIMSK2 = _BV(TOIE2);
}
void io_init(void)
{
	DDRB = 0b00000111;
	DDRC = _BV(3);
}
int main(void)
{
	io_init();
	timer_init();
	PORTB |= _BV(2);
	sei();
	while(1){
		//asm volatile("sbi %0,2"::"I"(_SFR_ADDR(PORTB)):);
		//PORTB |= _BV(2);
	}
}


ISR(TIMER1_OVF_vect,ISR_NAKED){
	//asm volatile("in %0,%1" : "=r" (sreg_save) : "I" (_SFR_IO_ADDR(SREG)));
	PORTC |= _BV(3);
	//asm volatile("out %1,%0" : "=r" (sreg_save) : "I" (_SFR_IO_ADDR(SREG)));
	reti();
}
ISR(TIMER1_COMPA_vect,ISR_NAKED){
	// 消除编译 mov r24,r3 这句多余的代码,在中断中没有环境保存会影响程序运行
	//asm volatile("out %1,%0" :"=r" (pwm_off) :"I" (_SFR_IO_ADDR(PORTD)): );
	//PORTD &= (uint8_t)~_BV(AN);
	PORTC &= ~(_BV(3));
	reti();
}
ISR(TIMER2_OVF_vect,ISR_NAKED){
	asm volatile("in %0,%1" : "=r" (sreg_save) : "I" (_SFR_IO_ADDR(SREG)));
	tcnt2h++;
	asm volatile("out %1,%0" : "=r" (sreg_save) : "I" (_SFR_IO_ADDR(SREG)));
	reti();
}