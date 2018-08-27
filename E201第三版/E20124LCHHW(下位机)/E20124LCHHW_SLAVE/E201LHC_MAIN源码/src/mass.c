#include "stm8s_conf.h"
#include "mass.h"


MASS_PARA Mass_Para;

void Mass_Deinit(void){
	Mass_Para.Mass_Mode=M_MODE_1;		// ģʽ��0
	Mass_Para.FreCnt=0;
	Mass_Para.SwitchCnt=0;
	Mass_Para.MassFlag = FALSE;
	M1_WriteLow();
	M2_WriteLow();
}
/*
	@brief: ��Ħ����
*/
void Mass_Handle(void)
{
	static u8 Mode1_Cnt=0;
	static u8 Mode2_Cnt=0;
	static u8 Mode3_Cnt=0;
	
	Mass_Para.SwitchCntFlag=TRUE;
	Mass_Para.MassFlag = TRUE;
	// ģʽ�Զ��л�
	if(Mass_Para.SwitchCnt>M_SWITCH_VALUES)
	{
		Mass_Para.SwitchCnt=0;
		Mass_Para.TimeCnt=0;		// ����ģʽҪ����0
		if(Mass_Para.Mass_Mode++>M_MODE_3)
		{
			Mass_Para.Mass_Mode=M_MODE_1;
		}
	}

	switch(Mass_Para.Mass_Mode)
	{
		case M_MODE_1:
		{
			Mass_Para.TimeCntFlag=TRUE;
			if(Mass_Para.TimeCnt>M_500MS)
			{
				Mass_Para.TimeCnt=0;
				
				if(Mode1_Cnt++>3)
					Mode1_Cnt=1;
				
				if(Mode1_Cnt==1)
				{
					Mass_Para.MotoA_Status=TRUE;
					Mass_Para.MotoB_Status=FALSE;
				}
				else if(Mode1_Cnt==2)
				{
					Mass_Para.MotoA_Status=FALSE;
					Mass_Para.MotoB_Status=TRUE;
				}
				else if(Mode1_Cnt==3)
				{
					Mass_Para.MotoA_Status=FALSE;
					Mass_Para.MotoB_Status=FALSE;
				}
			}
			break;
		}
		case M_MODE_2:
		{
			Mass_Para.TimeCntFlag=TRUE;
			if(Mass_Para.TimeCnt>M_1S)
			{
				Mass_Para.TimeCnt=0;
				Mode2_Cnt=~Mode2_Cnt;
				if(Mode2_Cnt)
				{
					Mass_Para.MotoA_Status=TRUE;
					Mass_Para.MotoB_Status=FALSE;
				}
				else 
				{
					Mass_Para.MotoA_Status=FALSE;
					Mass_Para.MotoB_Status=TRUE;	
				}
			}
			break;
		}
		case M_MODE_3:
		{
			Mass_Para.TimeCntFlag=TRUE;
			if(Mass_Para.TimeCnt>M_500MS)
			{
				Mass_Para.TimeCnt=0;
				Mode3_Cnt=~Mode3_Cnt;
				if(Mode3_Cnt)
				{
					Mass_Para.MotoA_Status=TRUE;
					Mass_Para.MotoB_Status=TRUE;	
				}
				else 
				{
					Mass_Para.MotoA_Status=FALSE;
					Mass_Para.MotoB_Status=FALSE;	
				}
			}
			break;
		}
		default:
		{
			Mass_Para.Mass_Mode=M_MODE_1;
			break;
		}
	}
}

/*
	���ʱ�䴦��
*/
void MassTimeHandle(void)
{
	static u16 cnt=0;
	
	if(Mass_Para.TimeCntFlag)
		Mass_Para.TimeCnt++;
	
	if(Mass_Para.SwitchCntFlag)
		Mass_Para.SwitchCnt++;
	/* Ƶ������*/
	/*
		7ms ��; 3ms ��
	*/
	if(Mass_Para.MassFlag)		// �ڰ�Ħģʽ��Ҫ����Ƶ������
	{
		Mass_Para.FreCnt++;
		
		if(Mass_Para.FreCnt<7)
		{
			if(Mass_Para.MotoA_Status)
			{
				M1_WriteHigh();
			}
			else
			{
				M1_WriteLow();
			}
			if(Mass_Para.MotoB_Status)
			{
				M2_WriteHigh();
			}	
			else
			{
				M2_WriteLow();
			}	
		}
		else if(Mass_Para.FreCnt>11)
		{
			M1_WriteLow();
			M2_WriteLow();
			Mass_Para.FreCnt=0;
		}
	}
	/*
		��Ħ�Զ��ر�
	*/
	if(Mass_Para.AutoCloseCntFlag)
	{
		if(cnt++>1000)		// 1S
		{
			cnt=0;
			if(Mass_Para.AutoCloseCnt<60000)
				Mass_Para.AutoCloseCnt++;
		}
	}
	else
		cnt=0;
}













