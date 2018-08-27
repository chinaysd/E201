/*
	@brief:按摩
*/
#ifndef _MASS_H_
#define _MASS_H_

#include "stm8s_conf.h"

/*
	按摩
*/
/*
	按摩部位使能
*/
#define M1_CONT 		1
#define M2_CONT			1
#define M3_CONT 		0
#define M4_CONT			0
#define M5_CONT 		0


#if M1_CONT
#define M1_PORT				GPIOB
#define M1_PIN				GPIO_PIN_3
#define M1_WriteHigh()		{GPIO_WriteHigh(M1_PORT, M1_PIN);}
#define M1_WriteLow()		{GPIO_WriteLow(M1_PORT, M1_PIN);}
#endif

#if M2_CONT
#define M2_PORT				GPIOB
#define M2_PIN				GPIO_PIN_2
#define M2_WriteHigh()		{GPIO_WriteHigh(M2_PORT, M2_PIN);}
#define M2_WriteLow()		{GPIO_WriteLow(M2_PORT, M2_PIN);}
#endif

#if M3_CONT
#define M3_PORT				GPIOB
#define M3_PIN				GPIO_PIN_4
#define M3_WriteHigh()		{GPIO_WriteHigh(M3_PORT,M3_PIN);}
#define M3_WriteLow()		{GPIO_WriteLow(M3_PORT, M3_PIN);}
#endif

#if M4_CONT
#define M4_PORT				GPIOD
#define M4_PIN				GPIO_PIN_0
#define M4_WriteHigh()		{GPIO_WriteHigh(M4_PORT, M4_PIN);}
#define M4_WriteLow()		{GPIO_WriteLow(M4_PORT, M4_PIN);}
#endif

#if M5_CONT
#define M5_PORT				GPIOB
#define M5_PIN				GPIO_PIN_5
#define M5_WriteHigh()		{GPIO_WriteHigh(M5_PORT, M5_PIN);}
#define M5_WriteLow()		{GPIO_WriteLow(M5_PORT, M5_PIN);}
#endif

#define Mass_Init()			{\
								GPIO_Init(M1_PORT, M1_PIN, GPIO_MODE_OUT_PP_HIGH_FAST);\
								GPIO_WriteLow(M1_PORT, M1_PIN);\
								GPIO_Init(M2_PORT, M2_PIN, GPIO_MODE_OUT_PP_HIGH_FAST);\
								GPIO_WriteLow(M2_PORT, M2_PIN);\
							}


/*
	马达切换时间定义
*/
#define M_500MS							500			// 50ms
#define M_1S							1000			
#define M_SWITCH_VALUES					60000		// 1分钟切换一次模式
#define M_AUTO_CLOSE_TIME_VALUE			1800		// 0.5h  

/*
	模式定义:
		模式1:M1 开-->M2开-->M1，M2关	0.5s循环
		模式2:M1开-->M2开 					1S循环
		模式3:M1M2开-->M1M2停				1S循环
*/
typedef enum
{
	M_MODE_1,
	M_MODE_2,
	M_MODE_3,
	M_MODE_NOFUN
}
MASS_MODE;

typedef struct
{
	MASS_MODE Mass_Mode;
	
	u16 TimeCnt;
	u8 TimeCntFlag;
	u8 msge_Status;		// 马达状态
	u8 SwitchCntFlag;	// 马达模式轮换
	u16 SwitchCnt;
	u8 FreFlag;			// 频率
	u8 FreCnt;			// 频率设置
	u8 MassFlag;			// 按摩功能
	u8 MotoA_Status;	// 状态
	u8 MotoB_Status;
	
	u16 AutoCloseCnt;
	u8 AutoCloseCntFlag;
}
MASS_PARA;














/*
	按摩处理
*/
void Mass_Handle(void);
/*
	马达时间处理
*/
void MassTimeHandle(void);

void Mass_Deinit(void);



#endif
