#include "bsp_uart.h"
#include "sys_config.h"
#include "data_type.h"

#include <string.h>

Bsp_Tx_t Tx_Buf;

/*****************************************************************************
 * Function	  : Bsp_UartInit1
 * Description   : 串口初始化
 * Input           : void  
 * Output		  : None
 * Return		  : 
 * Others		  : 
 * Record
 * 1.Date		  : 20180403
 *   Author       : marco
 *   Modification: Created function

*****************************************************************************/
int Bsp_UartInit(unsigned char id){
#if 0
	if(id == BSP_UART0_ID){
		SCON=0x50;
		PCON|=0x80;
		T2CON&=~0x30;
		TMCON|=0x02;
		TMOD&=0x0f;
		TMOD|=0x20;
		TH1=256 - SYS_FRE_SET/BSP_BAURATE/16/2*2;
		TR1=0;
		TR1=1;
		EUART=0;
		return 0;
	}else 
	#endif
	if(id == BSP_UART1_ID){
		unsigned int baud_set = 0;
		OTCON = 0XC0;
		SSCON0 = 0X50;
		baud_set = (unsigned int)(SYS_FRE_SET/16/BSP_BAURATE);
		SSCON1 = baud_set%256;
		SSCON2 = baud_set/256;
		IE1 = 0x01;      //开启SSI中断
		P2CON |= 0X01;	// 必须设置IO口，否则则为输入状态
		P20 = 1;
		return 0;
	}	
	return -1;
}

/*****************************************************************************
 * Function	  : Bsp_UartSendBuf
 * Description   : 串口发送数据
 * Input           : unsigned char id    
			    unsigned char *buf  
			    unsigned int len    
 * Output		  : None
 * Return		  : 
 * Others		  : 
 * Record
 * 1.Date		  : 20180409
 *   Author       : marco
 *   Modification: Created function

*****************************************************************************/
void Bsp_UartSendBuf(unsigned char id,unsigned char *buf,unsigned int len){
	if(id == BSP_UART0_ID){
		while(len --){
			TI = 0;
			SBUF = *buf++;
			while(!TI);
		}
	}else if(id == BSP_UART1_ID){
		if(!Tx_Buf.flag){
			if(len > BSP_UART1_SIZE)
				return ;
			memset((void*)&Tx_Buf,0,sizeof(Bsp_Tx_t));
			memcpy(Tx_Buf.buf,buf,len);
			Tx_Buf.len = len;
			Tx_Buf.flag = True;
			/*<开启传输>*/
			SSDAT = Tx_Buf.buf[0];
		}
	}
}



