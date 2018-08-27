#include "stm8s_conf.h"



/*
	@function : serial communicate initialize
*/
unsigned char Serial_Port_Init(unsigned char ID,unsigned long BaudRate){
	/* USART configured as follow:
        - BaudRate = BaudRate   
        - Word Length = 8 Bits
        - One Stop Bit
        - no parity
        - Receive and transmit enabled
        - UART Clock disabled
  */
  	if(ID == 1){	
		UART2_DeInit();
		UART2_Init(BaudRate, UART2_WORDLENGTH_8D, UART2_STOPBITS_1, \
			UART2_PARITY_NO, UART2_SYNCMODE_CLOCK_DISABLE, UART2_MODE_TXRX_ENABLE);
		UART2_ITConfig(UART2_IT_RXNE,ENABLE);
		UART2_ITConfig(UART2_IT_TXE, DISABLE);
		UART2_ClearFlag(UART2_FLAG_RXNE);
		UART2_Cmd(ENABLE);
	}else{
		return 0;
	}
	return 1;
}

u8  UART2_SentByte(u8 data){
	while(UART2_GetFlagStatus(UART2_FLAG_TXE)==RESET);
	UART2_SendData8((u8)data);
	return 1;
}

u8 UART2_SentString(u8 *data,u16 len){
	u16 i=0;
	for(;i<len;i++){
		UART2_SentByte(data[i]);
	}
	return 1;
}

u8 UART2_RevByte(void){
	while(UART2_GetFlagStatus(UART2_FLAG_RXNE)==RESET);
	return (UART2_ReceiveData8());
}



