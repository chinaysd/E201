#include "stm8s_conf.h"



/*
	io port
*/
#define COOL_PORT			GPIOD
#define COOL_PIN				GPIO_PIN_7
#define HEAT_PORT			GPIOD
#define HEAT_PIN				GPIO_PIN_4
#define FAN_PORT				GPIOA
#define FAN_PIN				GPIO_PIN_1

/*
	init
*/
unsigned char CH_Port_Init(unsigned char ID){
	if(ID == 0){
		GPIO_Init(COOL_PORT, COOL_PIN, GPIO_MODE_OUT_PP_HIGH_FAST);
		GPIO_WriteLow(COOL_PORT, COOL_PIN);
		GPIO_Init(HEAT_PORT, HEAT_PIN, GPIO_MODE_OUT_PP_HIGH_FAST);
		GPIO_WriteLow(HEAT_PORT, HEAT_PIN);
		GPIO_Init(FAN_PORT, FAN_PIN, GPIO_MODE_OUT_PP_HIGH_FAST);
		GPIO_WriteLow(FAN_PORT, FAN_PIN);
	}else{
		return 0;
	}
	return 1;
}


unsigned char CH_Port_Cool_Set(unsigned char ID,unsigned char Status){
	if(ID == 0){
		if(Status == 0){
			GPIO_WriteLow(COOL_PORT, COOL_PIN);
		}else if(Status == 1){
			GPIO_WriteHigh(COOL_PORT, COOL_PIN);
		}else{
			return 0;
		}
	}else {
		return 0;
	}
	return 1;
}

unsigned char CH_Port_Heat_Set(unsigned char ID,unsigned char Status){
	if(ID == 0){
		if(Status == 0){
			GPIO_WriteLow(HEAT_PORT, HEAT_PIN);
		}else if(Status == 1){
			GPIO_WriteHigh(HEAT_PORT, HEAT_PIN);
		}else{
			return 0;
		}
	}else{
		return 0;
	}
	return 1;
}

unsigned char CH_Port_Fan_Set(unsigned char ID,unsigned char Status){
	if(ID == 0){
		if(Status == 0){
			GPIO_WriteLow(FAN_PORT, FAN_PIN);
		}else if(Status == 1){
			GPIO_WriteHigh(FAN_PORT, FAN_PIN);
		}else{
			return 0;
		}
	}else{
		return 0;
	}
	return 1;
}

unsigned char CH_Port_Adc_Init(unsigned char ID){
	if(ID == 0){
		GPIO_Init(GPIOB, GPIO_PIN_1, GPIO_MODE_IN_FL_NO_IT);
		ADC1_DeInit();
		ADC1_Init(ADC1_CONVERSIONMODE_SINGLE,ADC1_CHANNEL_1,ADC1_PRESSEL_FCPU_D2,\
		ADC1_EXTTRIG_TIM,DISABLE,ADC1_ALIGN_RIGHT,ADC1_SCHMITTTRIG_ALL,DISABLE);
		ADC1_ITConfig(ADC1_IT_EOC,DISABLE);
		ADC1_Cmd(ENABLE);
	}else{
		return 0;
	}
	return 1;
}


