#include "cool_heat.h"
#include "timeout.h"

#include "stm8s_conf.h"

static TIMEOUT_PARA CH_Stop_Timer[CH_NUM];
#ifdef CH_COOL_FUNC_ENABLE
static TIMEOUT_PARA CH_Cool_Timer[CH_NUM];
#endif
#ifdef CH_HEAT_FUNC_ENABLE
static TIMEOUT_PARA CH_Heat_Timer[CH_NUM];
static TIMEOUT_PARA CH_Heat_Abnormal_Timer[CH_NUM];
static TIMEOUT_PARA CH_Heat_Software[CH_NUM];

#endif

extern unsigned char CH_Port_Cool_Set(unsigned char ID,unsigned char Status);
extern unsigned char CH_Port_Heat_Set(unsigned char ID,unsigned char Status);
extern unsigned char CH_Port_Fan_Set(unsigned char ID,unsigned char Status);

unsigned char CH_App_Init(CH_PARA_t *p){
	extern unsigned char CH_Port_Init(unsigned char ID);	
	extern unsigned char CH_Port_Adc_Init(unsigned char ID);
	CH_Port_Init(p->ID);
	CH_Port_Adc_Init(p->ID);
}

#ifdef CH_HEAT_FUNC_ENABLE
static unsigned int CH_Get_Temp(CH_PARA_t *p){
	extern unsigned int Get_Temp(unsigned char ID);

	return Get_Temp(p->ID);
}
#endif

static unsigned char CH_Stop_Handle(CH_PARA_t *p){
	static unsigned char Flag;
	unsigned char ret;
	#ifdef CH_HEAT_FUNC_ENABLE
		p->Abnormal_DetFlag = FALSE;
	#endif
	ret = CH_Port_Cool_Set(p->ID, CH_CLOSE) && CH_Port_Heat_Set(p->ID, CH_CLOSE);
	
	if(p->Status != CH_STOP_MODE){
		p->Status = CH_STOP_MODE;
		Flag = 0;
	}
	
	if(Flag == 0){
		Flag = 1;
		TimeOut_Record(&CH_Stop_Timer[p->ID -1], CH_STOP_TIME);
	}

	if(TimeOutDet_Check(&CH_Stop_Timer[p->ID -1])){
		ret &= CH_Port_Fan_Set(p->ID, CH_CLOSE);
	}
	
	return ret;
}

#ifdef CH_COOL_FUNC_ENABLE
/*
	heat = cool = 1: COOL MODE
*/
static unsigned char CH_Cool_Handle(CH_PARA_t *p){
	static unsigned char Flag;
	unsigned char ret;
	#ifdef CH_HEAT_FUNC_ENABLE
		p->Abnormal_DetFlag = FALSE;
	#endif
	ret = CH_Port_Fan_Set(p->ID, CH_OPEN);
	
	if(p->Status != CH_COOL_MODE){
		p->Status = CH_COOL_MODE;
		Flag = 0;
	}

	if(Flag == 0){
		Flag = 1;
		TimeOut_Record(&CH_Cool_Timer[p->ID -1], CH_START_TIME);
		CH_Port_Cool_Set(p->ID, CH_CLOSE);		// first close module
		CH_Port_Heat_Set(p->ID, CH_CLOSE);
	}

	if(TimeOutDet_Check(&CH_Cool_Timer[p->ID -1])){
		ret &= CH_Port_Cool_Set(p->ID, CH_OPEN);	// delay to complete
		ret &= CH_Port_Heat_Set(p->ID, CH_OPEN);
	}
	
	return ret;
}
#endif

#ifdef CH_HEAT_FUNC_ENABLE
static unsigned char CH_Heat_Handle(CH_PARA_t *p){
	static unsigned char Flag,Flag1;
	unsigned int ret = 0,temp = 0;
	ret = CH_Port_Fan_Set(p->ID, CH_OPEN);
	
	if(p->Status != CH_HEAT_MODE){
		p->Status = CH_HEAT_MODE;
		Flag = 0;
	}

	if(Flag == 0){
		Flag = 1;
		TimeOut_Record(&CH_Heat_Timer[p->ID -1], CH_START_TIME);
		CH_Port_Cool_Set(p->ID, CH_CLOSE);		// first close module
		CH_Port_Heat_Set(p->ID, CH_CLOSE);
	}

	if(TimeOutDet_Check(&CH_Heat_Timer[p->ID -1])){
		temp = CH_Get_Temp(p);		// cyclic heat
		// found sensor abnormal
		if(temp == 0 || temp == 1023){
			if(p->Abnormal_DetFlag == FALSE){
				p->Abnormal_DetFlag = TRUE;
				TimeOut_restart(&CH_Heat_Abnormal_Timer[p->ID -1]);
				TimeOut_Record(&CH_Heat_Abnormal_Timer[p->ID -1], CH_ABNORMAL_TIME);
			}
		}
		// detected abnormal sensor ,switch to use software method 
		if(TimeOutDet_Check(&CH_Heat_Abnormal_Timer[p->ID -1]) && p->Abnormal_DetFlag){
			static int num = 0, Flag1,Flag2;
			static TIMEOUT_PARA SoftwareDelay[2];
			switch(num){		// loop heat 
				case 0:{
					Flag2 = 0;
					if(!Flag1){
						Flag1 = 1;
						TimeOut_Record(&SoftwareDelay[0], 4000);
					}
					if(TimeOutDet_Check(&SoftwareDelay[0])){
						CH_Port_Cool_Set(p->ID, CH_CLOSE);
						num = 1;
					}
					break;
				}

				case 1:{
					Flag1 = 0;
					if(!Flag2){
						Flag2 = 1;
						TimeOut_Record(&SoftwareDelay[1], 10000);
					}
					if(TimeOutDet_Check(&SoftwareDelay[1])){
						CH_Port_Cool_Set(p->ID, CH_OPEN);
						num = 0;
					}
					break;
				}

				default:{
					num = 0;
					break;
				}
			}
			return 0XFF;
		}
		// nomal detect use ADC 
		if(temp < CH_HEAT_STOP_VALUE){
			ret &= CH_Port_Cool_Set(p->ID, CH_CLOSE);
		}else if(temp > CH_HEAT_START_VALUE){
			ret &= CH_Port_Cool_Set(p->ID, CH_OPEN);
		}
	}
	
	return ret;
}
#endif

unsigned char CH_Handle(CH_PARA_t *p,CH_STATUS_t Status){
	if(Status == CH_STOP_MODE){
		return CH_Stop_Handle(p);
	}
	#ifdef CH_COOL_FUNC_ENABLE
	else if(Status == CH_COOL_MODE){
		return CH_Cool_Handle(p);
	}
	#endif
	#ifdef CH_HEAT_FUNC_ENABLE
	else if(Status == CH_HEAT_MODE){
		return CH_Heat_Handle(p);
	}
	#endif
	else{
		return 0;
	}
}

/*
	@function: set cool_heat moudle status
	@brief: 	Status = 0  -->OFF
			Status = 1  -->ON
*/
int CH_Cool_Heat_Moudle_Set(CH_PARA_t *p,unsigned char Status){
	if(p->ID == 0){
		if(Status == 0){
			CH_Port_Cool_Set(p->ID, 0);
			CH_Port_Heat_Set(p->ID, 0);
			CH_Port_Fan_Set(p->ID, 1);
		}else if(Status == 1){
			CH_Port_Cool_Set(p->ID, 1);
			CH_Port_Heat_Set(p->ID, 1);
			CH_Port_Fan_Set(p->ID, 0);
		}
	}else{
		return 0;
	}
}
