#ifndef SYSTEM_H_
#define SYSTEM_H_

#include "stm8s_conf.h"

/*
	communication overflow time 
*/
#define COMMU_TIMEOUT_VALUE						5000
/*
	foot led
*/
#define FOOT_LED_PORT	GPIOD
#define FOOT_LED_PIN		GPIO_PIN_2
#define Foot_Led_Set(x)	((x) ? (GPIO_WriteHigh(FOOT_LED_PORT, FOOT_LED_PIN)) : (GPIO_WriteLow(FOOT_LED_PORT, FOOT_LED_PIN)))


#define SUB_LED_PORT	GPIOA
#define SUB_LED_PIN		GPIO_PIN_2
#define Sub_Led_Set(x)	((x) ? (GPIO_WriteHigh(SUB_LED_PORT, SUB_LED_PIN)) : (GPIO_WriteLow(SUB_LED_PORT, SUB_LED_PIN)))

#define sys_FAN_LED_PORT	GPIOD
#define sys_FAN_LED_PIN		GPIO_PIN_3
#define sys_FAN_LED_SET(x)	((x) ? (GPIO_WriteHigh(sys_FAN_LED_PORT, sys_FAN_LED_PIN)) : (GPIO_WriteLow(sys_FAN_LED_PORT, sys_FAN_LED_PIN)))









void System_Init(void);
void System_Handle(void);



#endif
