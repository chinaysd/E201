#include "stm8s_conf.h"


u16 Get_Temp(u8 ID){
	extern u8 CH_Port_Adc_Init(u8 ID);
	#define SCAN_NUM		7
	u16 temp[SCAN_NUM],s1,z,ADCdata;
	u8 s,j,k,i;
	
	CH_Port_Adc_Init(ID);
	
	for(i = 0;i < SCAN_NUM;i ++){
		s = 20;
		ADC1_StartConversion();
		do{
			s1 = ADC1_GetFlagStatus(ADC1_FLAG_EOC);
			s --;
		}
		while((s1 == 0)&&(s != 0));
		if(s == 0)
			return 0;
		temp[i] = ADC1_GetConversionValue();
		ADC1_ClearFlag(ADC1_FLAG_EOC);
	}
	ADC1_Cmd(DISABLE);		
	
	for(j = 0;j < SCAN_NUM;j ++){
		for(k = j;k < SCAN_NUM;k ++) {
			if(temp[j] >= temp[k]) {
				z = temp[j];   
				temp[j] = temp[k];   
				temp[k] = z;
			}		 
		}
	}
	
	temp[0] = temp[6] = 0;                            
	ADCdata = (u16)((temp[1] + temp[2] + temp[3] + temp[4] + temp[5]) / 5);	

	return ADCdata;
}


