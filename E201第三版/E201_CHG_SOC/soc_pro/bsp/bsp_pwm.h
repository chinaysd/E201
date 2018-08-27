#ifndef BSP_PWM_H_
#define BSP_PWM_H_

#include "sc93f833X_C.h"


typedef struct{
	unsigned int cnt,base_cnt;
	unsigned char down_flag,up_flag;
}Pwm_Para_t;












void Bsp_PWMInit(void);
void Bsp_PwmOff(void);
void Bsp_PwmON(void);
void Bsp_PwnFullOn(void);


#endif
