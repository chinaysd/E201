#include "system.h"
#include "key.h"
#include "pushrod.h"
#include "commu.h"
#include "cool_heat.h"
#include "timeout.h"
#include <string.h>
#include "mass.h"

typedef struct {
	u8 Foot_Led_Sta;
	u8 Cool_Heat_Sta;
	u8 PushRod_Sta;
	u8 Message_Sta;
	unsigned char ucWarn_Cloth_Sta,
				ucMass_Sta;
}SYSTEM_MESSAGE_t;



// private variable
extern COMMU_BUF_t Rev_Para;
static t_KEY_MSG Key_Msg = MSG_KEY_NONE;
static Push_Para_t Pushrod[PUSHROD_NUM];
static SYSTEM_MESSAGE_t Rev_Msg;
static CH_PARA_t CH_Para[CH_NUM];
static TIMEOUT_PARA Timeout;
/*
	TIM4 
	1MS
*/
#define Delay 		75//	319
static void Tim4_Init(void)
{
	TIM4_DeInit();
	TIM4_TimeBaseInit( TIM4_PRESCALER_32,Delay-1);
	TIM4_PrescalerConfig(TIM4_PRESCALER_32,TIM4_PSCRELOADMODE_IMMEDIATE);
	TIM4_ARRPreloadConfig(ENABLE);
	TIM4_ITConfig( TIM4_IT_UPDATE , ENABLE);
	TIM4_UpdateDisableConfig(DISABLE);
	TIM4_UpdateRequestConfig( TIM4_UPDATESOURCE_GLOBAL);
	TIM4_Cmd(ENABLE );
}


/*
	ø¥√≈π∑
*/
static void Iwdg_Init(void)
{	
	IWDG_Enable();
	IWDG_WriteAccessCmd(IWDG_WriteAccess_Enable);
	IWDG_SetPrescaler(IWDG_Prescaler_256);
	IWDG_SetReload(0XFF);
	IWDG_ReloadCounter();
}

static System_Sundry_Init(void){
	// foot led
	GPIO_Init(FOOT_LED_PORT, FOOT_LED_PIN, GPIO_MODE_OUT_PP_HIGH_FAST);
	GPIO_WriteLow(FOOT_LED_PORT, FOOT_LED_PIN);
	GPIO_Init(SUB_LED_PORT, SUB_LED_PIN, GPIO_MODE_OUT_PP_HIGH_FAST);
	GPIO_WriteLow(SUB_LED_PORT, SUB_LED_PIN);
	GPIO_Init(sys_FAN_LED_PORT, sys_FAN_LED_PIN, GPIO_MODE_OUT_PP_HIGH_FAST);
	GPIO_WriteLow(sys_FAN_LED_PORT, sys_FAN_LED_PIN);
}
COMMU_BUF_t buf;

void System_Init(void){
	int i = 0;
	System_Sundry_Init();
	KEY_Init();
	Mass_Init();
	for(i = 0; i < PUSHROD_NUM ;i ++){	
		Pushrod[i].ID = i;
		Pushrod_APP_Init(&Pushrod[i]);
	}
	for(i = 0; i< CH_NUM; i ++){
		CH_Para[i].ID = i;
		CH_App_Init(&CH_Para[i]);
	}
	Tim4_Init();
	Iwdg_Init();
	TimeOutDet_Init();
	
	Commu_Init();
	TimeOut_Record(&Timeout, COMMU_TIMEOUT_VALUE);
	enableInterrupts();
}





void System_Handle(void){
	/*refresh IWDG*/
	IWDG_ReloadCounter();
	/*********************************************************************
		push rod the reverse handle
	**********************************************************************/
	#if 1
	Key_Msg = KEY_Scan();

	if(Key_Msg == MSG_KEY2_LONGPRESS || Key_Msg == MSG_KEY3_LONGPRESS){
		Pushrod[PUSHROD_A].ReverseFlag = TRUE;
	}
	if(Key_Msg == MSG_KEY2_LONGPRESS_RE || Key_Msg == MSG_KEY3_LONGPRESS_RE){
		Pushrod[PUSHROD_A].ReverseFlag = FALSE;
	}
	#if PUSHROD_NUM > 1
	if(Key_Msg == MSG_KEY1_LONGPRESS || Key_Msg == MSG_KEY3_LONGPRESS){
		Pushrod[PUSHROD_B].ReverseFlag = TRUE;
	}
	if(Key_Msg == MSG_KEY1_LONGPRESS_RE || Key_Msg == MSG_KEY3_LONGPRESS_RE){
		Pushrod[PUSHROD_B].ReverseFlag = FALSE;
	}
	#endif
	#endif
	/*********************************************************************
		handle pushrod message
	**********************************************************************/
	if(Rev_Msg.PushRod_Sta == PUSHROD_STOP || Rev_Msg.PushRod_Sta == PUSHROD_A_STOP ||Rev_Msg.PushRod_Sta == PUSHROD_B_STOP){
		Pushrod_APP_Handle(&Pushrod[PUSHROD_A], PUSH_STOP);
		#if PUSHROD_NUM > 1
		Pushrod_APP_Handle(&Pushrod[PUSHROD_B], PUSH_STOP);
		#endif
	}else if(Rev_Msg.PushRod_Sta == PUSHROD_A_OPEN){
		Pushrod_APP_Handle(&Pushrod[PUSHROD_A], PUSH_OPEN);
	}else if(Rev_Msg.PushRod_Sta == PUSHROD_A_CLOSE){
		Pushrod_APP_Handle(&Pushrod[PUSHROD_A], PUSH_CLOSE);
	}
	#if PUSHROD_NUM > 1
	else if(Rev_Msg.PushRod_Sta == PUSHROD_B_OPEN){
		Pushrod_APP_Handle(&Pushrod[PUSHROD_B], PUSH_OPEN);
	}else if(Rev_Msg.PushRod_Sta == PUSHROD_B_CLOSE){
		Pushrod_APP_Handle(&Pushrod[PUSHROD_B], PUSH_CLOSE);
	}
	#endif
	else{
		Pushrod_APP_Handle(&Pushrod[PUSHROD_A], PUSH_STOP);
		#if PUSHROD_NUM > 1
		Pushrod_APP_Handle(&Pushrod[PUSHROD_B], PUSH_STOP);
		#endif
	}
	/*********************************************************************
		handle cool_heat moudle message
		if push rod is running,turn off cool_heat moudle
	**********************************************************************/	
	if(Rev_Msg.Cool_Heat_Sta == CH_A_OFF){
		CH_Handle(&CH_Para[CH_A],CH_STOP_MODE);
	}else if(Rev_Msg.Cool_Heat_Sta == CH_A_COOL){
		if(Pushrod_GetStatus(&Pushrod[PUSHROD_A])){
			CH_Cool_Heat_Moudle_Set(&CH_Para[CH_A],0);
		}else{
			CH_Handle(&CH_Para[CH_A],CH_COOL_MODE);
		}
	}else if(Rev_Msg.Cool_Heat_Sta == CH_A_HEAT){
		if(Pushrod_GetStatus(&Pushrod[PUSHROD_A])){
			CH_Cool_Heat_Moudle_Set(&CH_Para[CH_A],0);
		}else{
			CH_Handle(&CH_Para[CH_A],CH_HEAT_MODE);
		}
	}else{
		CH_Handle(&CH_Para[CH_A],CH_STOP_MODE);
	}
	/*********************************************************************
		foot led control
	**********************************************************************/
	if(Rev_Msg.Foot_Led_Sta == FOOT_LED_OFF){
		Foot_Led_Set(0);
		Sub_Led_Set(0);
	}else{
		Foot_Led_Set(1);
		Sub_Led_Set(1);
	}
	/*********************************************************************
		warn cloth control
	**********************************************************************/
	if(Rev_Msg.ucWarn_Cloth_Sta == WARM_ON){
		sys_FAN_LED_SET(1);
	}else if(Rev_Msg.ucWarn_Cloth_Sta == WARM_OFF){
		sys_FAN_LED_SET(0);
	}
	/*********************************************************************
		mass control
	**********************************************************************/
	if(Rev_Msg.ucMass_Sta == MASS_ON){
		Mass_Handle();
	}else if(Rev_Msg.ucMass_Sta == MASS_OFF){
		Mass_Deinit();
	}
	/*********************************************************************
		receive touch IC message 
	**********************************************************************/
	#if 1
	if(Serial_Get_Status()){
		unsigned int Rev_Data = 0;
		TimeOut_Record(&Timeout, COMMU_TIMEOUT_VALUE);
		/* err*/
		if(Rev_Para.Data_Format.MessageID != NUM1){
	//		Rev_Msg.Foot_Led_Sta = FOOT_LED_OFF;
	//		Rev_Msg.Cool_Heat_Sta = CH_A_OFF;
	//		Rev_Msg.PushRod_Sta = PUSHROD_STOP;
	//		OverFlow_Flag = TRUE;
		}
		if(Rev_Para.Data_Format.Checksum != (unsigned char)(Rev_Para.Data_Format.MessageID + Rev_Para.Data_Format.Cont2+ 
			Rev_Para.Data_Format.Start + Rev_Para.Data_Format.Cont1)){
	//		Rev_Msg.Foot_Led_Sta = FOOT_LED_OFF;
	//		Rev_Msg.Cool_Heat_Sta = CH_A_OFF;
	//		Rev_Msg.PushRod_Sta = PUSHROD_STOP;
	//		OverFlow_Flag = TRUE;
		}
		// updata the system state
		Rev_Data = Get_32bit(Rev_Para.Data_Format.Cont1, Rev_Para.Data_Format.Cont2);
		if(Rev_Data & CONT_LED_ON){
			Rev_Msg.Foot_Led_Sta = FOOT_LED_ON;
		}else if(Rev_Data & CONT_LED_OFF){
			Rev_Msg.Foot_Led_Sta = FOOT_LED_OFF;
		}
		if(Rev_Data & CONT_CH_A_OFF){
			Rev_Msg.Cool_Heat_Sta = CH_A_OFF;
		}else if(Rev_Data & CONT_CH_A_COOL){
			Rev_Msg.Cool_Heat_Sta = CH_A_COOL;
		}else if(Rev_Data & CONT_CH_A_HEAT){
			Rev_Msg.Cool_Heat_Sta = CH_A_HEAT;
		}
		if(Rev_Data & CONT_PUSHROD_STOP){
			Rev_Msg.PushRod_Sta = PUSHROD_STOP;
		}else if(Rev_Data & CONT_PUSHROD_A_OPEN){
			Rev_Msg.PushRod_Sta = PUSHROD_A_OPEN;
		}else if(Rev_Data & CONT_PUSHROD_A_CLOSE){
			Rev_Msg.PushRod_Sta = PUSHROD_A_CLOSE;
		}else if(Rev_Data & CONT_PUSHROD_B_OPEN){
			Rev_Msg.PushRod_Sta = PUSHROD_B_OPEN;
		}else if(Rev_Data & CONT_PUSHROD_B_CLOSE){
			Rev_Msg.PushRod_Sta = PUSHROD_B_CLOSE;
		}
		
		if(Rev_Data & CONT_MASS_ON){
			Rev_Msg.ucMass_Sta = MASS_ON;
		}else if(Rev_Data & CONT_MASS_OFF){
			Rev_Msg.ucMass_Sta = MASS_OFF;
		}

		if(Rev_Data & CONT_WARM_CLOTH_ON){
			Rev_Msg.ucWarn_Cloth_Sta = WARM_ON;
		}else if(Rev_Data & CONT_WARM_CLOTH_OFF){
			Rev_Msg.ucWarn_Cloth_Sta = WARM_OFF;
		}
		
		memset(Rev_Para.Buf,0,sizeof(Rev_Para.Buf));
	}
	#endif
	/*********************************************************************
		handle abnormal situation
	**********************************************************************/
	if(TimeOutDet_Check(&Timeout) && !Serial_Get_Status()){
		// reset all mudule
	//	Rev_Msg.Cool_Heat_Sta = CH_STOP_MODE;
	//	Rev_Msg.Foot_Led_Sta = FOOT_LED_OFF;
	//	Rev_Msg.Message_Sta = 0;
	//	Rev_Msg.PushRod_Sta = PUSHROD_STOP;
	}
}
