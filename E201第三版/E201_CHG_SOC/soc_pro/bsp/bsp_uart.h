#ifndef BSP_UART_H_
#define BSP_UART_H_

#include "sc93f833X_C.h"

/**
	@brief:串口波特率设置
*/
#define	BSP_BAURATE						9600

#define 	BSP_UART0_ID					0X01
#define 	BSP_UART1_ID					0X02

#define 	BSP_UART1_SIZE					7

typedef struct{
	unsigned char flag;
	unsigned int len,send_cnt;
	unsigned char buf[BSP_UART1_SIZE];
}Bsp_Tx_t;







int Bsp_UartInit(unsigned char id);
void Bsp_UartSendBuf(unsigned char id,unsigned char *buf,unsigned int len);

#endif





