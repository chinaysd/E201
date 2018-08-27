#include "bsp_pwm.h"
#include "data_type.h"
#include <string.h>

static Pwm_Para_t Pwm_Para;

void Bsp_PWMInit(void){
	PWMCON = 0x13;			
	PWMPRD  = 100;			
	PWMCFG  = 0x12;			
	PWMDTY1 = 0xbf;    		 	
	PWMDTYA = 0x00;
	IE1|=0X02;
}

void Bsp_PwmHandle() interrupt 8{
	PWMCON &=~0X40; 				
	if(Pwm_Para.cnt ++ >Pwm_Para.base_cnt){
		Pwm_Para.cnt = 0;
		
		if(PWMDTY1 == 0){
			Pwm_Para.down_flag = True;
			Pwm_Para.up_flag = False;
			Pwm_Para.base_cnt = 300;
		}

		if(PWMDTY1 == 0xbf){
			Pwm_Para.down_flag = False;
			Pwm_Para.up_flag = True;
			Pwm_Para.base_cnt = 150;
		}
		
		if(Pwm_Para.down_flag)			
			PWMDTY1 ++;
		if(Pwm_Para.up_flag)			
			PWMDTY1 --;
	}
}

void Bsp_PwmOff(void){
	memset((void*)&Pwm_Para,0,sizeof(Pwm_Para_t));
	PWMCON &= ~0x80;
	PWMPRD = 0;
	PWMDTY1 = 0;
}

void Bsp_PwnFullOn(void){
	memset((void*)&Pwm_Para,0,sizeof(Pwm_Para_t));
	PWMCON &= ~0x80;
	PWMPRD = 0;
	PWMDTY1 = 0xff;
}

void Bsp_PwmON(void){
	Bsp_PWMInit();
	PWMCON |= 0x80;
}

