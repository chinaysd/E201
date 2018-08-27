#include "stm8s_conf.h"



#define SW1_PORT 			GPIOC
#define SW1_PIN 				GPIO_PIN_6
#define SW2_PORT 			GPIOC
#define SW2_PIN 				GPIO_PIN_7


u8 Key_Port_Read(u8 num){
	if(num == 1){
		return GPIO_ReadInputPin(SW1_PORT, SW1_PIN);
	}else if(num == 2){
		return GPIO_ReadInputPin(SW2_PORT, SW2_PIN);
	}else{
		return 0;
	}
}

u8 Key_Port_Init(void){
	GPIO_Init(SW1_PORT, SW1_PIN, GPIO_MODE_IN_PU_NO_IT);
	GPIO_Init(SW2_PORT, SW2_PIN, GPIO_MODE_IN_PU_NO_IT); 
	return 1;
}
