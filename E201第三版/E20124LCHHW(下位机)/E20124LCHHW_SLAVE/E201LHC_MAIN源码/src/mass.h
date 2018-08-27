/*
	@brief:��Ħ
*/
#ifndef _MASS_H_
#define _MASS_H_

#include "stm8s_conf.h"

/*
	��Ħ
*/
/*
	��Ħ��λʹ��
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
	����л�ʱ�䶨��
*/
#define M_500MS							500			// 50ms
#define M_1S							1000			
#define M_SWITCH_VALUES					60000		// 1�����л�һ��ģʽ
#define M_AUTO_CLOSE_TIME_VALUE			1800		// 0.5h  

/*
	ģʽ����:
		ģʽ1:M1 ��-->M2��-->M1��M2��	0.5sѭ��
		ģʽ2:M1��-->M2�� 					1Sѭ��
		ģʽ3:M1M2��-->M1M2ͣ				1Sѭ��
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
	u8 msge_Status;		// ���״̬
	u8 SwitchCntFlag;	// ���ģʽ�ֻ�
	u16 SwitchCnt;
	u8 FreFlag;			// Ƶ��
	u8 FreCnt;			// Ƶ������
	u8 MassFlag;			// ��Ħ����
	u8 MotoA_Status;	// ״̬
	u8 MotoB_Status;
	
	u16 AutoCloseCnt;
	u8 AutoCloseCntFlag;
}
MASS_PARA;














/*
	��Ħ����
*/
void Mass_Handle(void);
/*
	���ʱ�䴦��
*/
void MassTimeHandle(void);

void Mass_Deinit(void);



#endif
