#ifndef _Function_Init_H_
#define _Function_Init_H_

#include "intrins.H"
#define uchar unsigned char
#define uint unsigned int
	
extern void IO_Init(void);
extern void BTM_Init(void);
extern void EX_Init(void);
extern void LCD_Init(void);
extern void Timer_Init(void);
extern void PWM_Init(void);
extern void Uart0_Init(void);
extern void Uart1_Init(void);
extern void ADC_Init(void);
extern void ADC_TS_Init(void);     //采温度传感器电压值
extern void IAP_Init(void);
extern void TWI_Init(void);
extern void SPI_Init(void);

extern unsigned int ADCValue;
#endif