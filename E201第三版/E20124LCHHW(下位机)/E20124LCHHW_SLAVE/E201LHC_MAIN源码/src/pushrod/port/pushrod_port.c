#include "stm8s_conf.h"


/**
	pushrod macro
*/
#define PUSH1A_PORT 			GPIOC
#define PUSH1A_PIN 			GPIO_PIN_5
#define PUSH1A_Set(x)			((x)?(GPIO_WriteHigh(PUSH1A_PORT, PUSH1A_PIN)):(GPIO_WriteLow(PUSH1A_PORT, PUSH1A_PIN)))
#define PUSH1B_PORT 			GPIOC
#define PUSH1B_PIN 			GPIO_PIN_4
#define PUSH1B_Set(x)			((x)?(GPIO_WriteHigh(PUSH1B_PORT, PUSH1B_PIN)):(GPIO_WriteLow(PUSH1B_PORT, PUSH1B_PIN)))
#define PUSH2A_PORT 			GPIOC
#define PUSH2A_PIN 			GPIO_PIN_3
#define PUSH2A_Set(x)			((x)?(GPIO_WriteHigh(PUSH2A_PORT, PUSH2A_PIN)):(GPIO_WriteLow(PUSH2A_PORT, PUSH2A_PIN)))
#define PUSH2B_PORT 			GPIOC
#define PUSH2B_PIN 			GPIO_PIN_2
#define PUSH2B_Set(x)			((x)?(GPIO_WriteHigh(PUSH2B_PORT, PUSH2B_PIN)):(GPIO_WriteLow(PUSH2B_PORT, PUSH2B_PIN)))

/*
	pushrod io init
	id start from 0 increamtal
*/
u8 Pushrod_Port_Init(u8 ID){
	if(ID == 0){
		GPIO_Init(PUSH1A_PORT, PUSH1A_PIN, GPIO_MODE_OUT_PP_HIGH_FAST);
		PUSH1A_Set(0);
		GPIO_Init(PUSH1B_PORT, PUSH1B_PIN, GPIO_MODE_OUT_PP_HIGH_FAST);
		PUSH1B_Set(0);
	}else if(ID == 1){
		GPIO_Init(PUSH2A_PORT, PUSH2A_PIN, GPIO_MODE_OUT_PP_HIGH_FAST);
		PUSH2A_Set(0);
		GPIO_Init(PUSH2B_PORT, PUSH2B_PIN, GPIO_MODE_OUT_PP_HIGH_FAST);
		PUSH2B_Set(0);
	}else{
		return 0;
	}	
	return 1;
}

/*
	@function : low driver
	@para : ID -> push rod num
		      Status : 	0 ->STOP
		      			1 ->OPEN
		      			2 ->CLOSE
*/
u8 Pushrod_Port_Set(u8 ID,u8 Status){
	if(ID == 0){
		if(Status == 0){
			PUSH1A_Set(0),PUSH1B_Set(0);
		}else if(Status == 1){
			PUSH1A_Set(0),PUSH1B_Set(1);
		}else if(Status == 2){
			PUSH1A_Set(1),PUSH1B_Set(0);
		}else{
			return 0;
		}
	}else if(ID == 1){
		if(Status == 0){
			PUSH2A_Set(0),PUSH2B_Set(0);
		}else if(Status == 1){
			PUSH2A_Set(0),PUSH2B_Set(1);
		}else if(Status == 2){
			PUSH2A_Set(1),PUSH2B_Set(0);
		}else{
			return 0;
		}
	}else{
		return 0;
	}
	return 1;
}

