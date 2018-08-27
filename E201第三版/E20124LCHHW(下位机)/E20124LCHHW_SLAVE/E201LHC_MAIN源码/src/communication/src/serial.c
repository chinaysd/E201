#include "stm8s_conf.h"
#include "commu.h"
#include "string.h"

/*global variables*/
COMMU_BUF_t Rev_Para;

/* private varialbes*/
static u8 Rx_Num;


u8 Serial_Init(u8 ID,uint32_t BaudRate){
	extern u8 Serial_Port_Init(u8 ID,uint32_t BaudRate);	

	return Serial_Port_Init(ID,BaudRate);
}

u8 Serial_SentByte(u8 data){
	extern u8  UART2_SentByte(u8 data);

	return UART2_SentByte(data);
}


u8 Serial_RevByte(void){
	extern u8 UART2_RevByte(void);
	
	return UART2_RevByte();
}

/*
	@function : interrupt receive routines
*/
void Serial_Rev_IQH(void){
	u8 res;
	if(UART2_GetITStatus(UART2_IT_RXNE)!=RESET){
		res=UART2_ReceiveData8();
		if((Rx_Num & 0x80) == 0){
			if(Rx_Num & 0x40)	{// 接收到了0x0d
				if(res != 0x0a)		
					Rx_Num = 0;
				else
					Rx_Num |= 0x80;		//  接收完成
			}
			else{
				if(res == 0x0d)
					Rx_Num |= 0x40;
				else{
					Rev_Para.Buf[Rx_Num] = res;
					Rx_Num ++;
					if(Rev_Para.Buf[0] != START_FIELD)		// start field is correct
						Rx_Num = 0;
					if(Rx_Num > BUF_SIZE){
						Rx_Num = 0;
					}
				}
			}
		}
	}
}

/*
	@brief : return 1 -> receive complete
*/
u8 Serial_Get_Status(void){
	if(Rx_Num & 0x80){
		Rx_Num = 0;
		return 1;
	}else{
		return 0;
	}
}

