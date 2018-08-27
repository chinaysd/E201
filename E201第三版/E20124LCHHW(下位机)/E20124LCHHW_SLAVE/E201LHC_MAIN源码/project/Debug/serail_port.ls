   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.8 - 03 Dec 2008
  57                     ; 8 unsigned char Serial_Port_Init(unsigned char ID,unsigned long BaudRate){
  59                     	switch	.text
  60  0000               _Serial_Port_Init:
  62  0000 88            	push	a
  63       00000000      OFST:	set	0
  66                     ; 17   	if(ID == 1){	
  68  0001 a101          	cp	a,#1
  69  0003 263a          	jrne	L33
  70                     ; 18 		UART2_DeInit();
  72  0005 cd0000        	call	_UART2_DeInit
  74                     ; 19 		UART2_Init(BaudRate, UART2_WORDLENGTH_8D, UART2_STOPBITS_1, \
  74                     ; 20 			UART2_PARITY_NO, UART2_SYNCMODE_CLOCK_DISABLE, UART2_MODE_TXRX_ENABLE);
  76  0008 4b0c          	push	#12
  77  000a 4b80          	push	#128
  78  000c 4b00          	push	#0
  79  000e 4b00          	push	#0
  80  0010 4b00          	push	#0
  81  0012 1e0b          	ldw	x,(OFST+11,sp)
  82  0014 89            	pushw	x
  83  0015 1e0b          	ldw	x,(OFST+11,sp)
  84  0017 89            	pushw	x
  85  0018 cd0000        	call	_UART2_Init
  87  001b 5b09          	addw	sp,#9
  88                     ; 21 		UART2_ITConfig(UART2_IT_RXNE,ENABLE);
  90  001d 4b01          	push	#1
  91  001f ae0255        	ldw	x,#597
  92  0022 cd0000        	call	_UART2_ITConfig
  94  0025 84            	pop	a
  95                     ; 22 		UART2_ITConfig(UART2_IT_TXE, DISABLE);
  97  0026 4b00          	push	#0
  98  0028 ae0277        	ldw	x,#631
  99  002b cd0000        	call	_UART2_ITConfig
 101  002e 84            	pop	a
 102                     ; 23 		UART2_ClearFlag(UART2_FLAG_RXNE);
 104  002f ae0020        	ldw	x,#32
 105  0032 cd0000        	call	_UART2_ClearFlag
 107                     ; 24 		UART2_Cmd(ENABLE);
 109  0035 a601          	ld	a,#1
 110  0037 cd0000        	call	_UART2_Cmd
 113                     ; 28 	return 1;
 115  003a a601          	ld	a,#1
 118  003c 5b01          	addw	sp,#1
 119  003e 81            	ret
 120  003f               L33:
 121                     ; 26 		return 0;
 123  003f 4f            	clr	a
 126  0040 5b01          	addw	sp,#1
 127  0042 81            	ret
 163                     ; 31 u8  UART2_SentByte(u8 data){
 164                     	switch	.text
 165  0043               _UART2_SentByte:
 167  0043 88            	push	a
 168       00000000      OFST:	set	0
 171  0044               L75:
 172                     ; 32 	while(UART2_GetFlagStatus(UART2_FLAG_TXE)==RESET);
 174  0044 ae0080        	ldw	x,#128
 175  0047 cd0000        	call	_UART2_GetFlagStatus
 177  004a 4d            	tnz	a
 178  004b 27f7          	jreq	L75
 179                     ; 33 	UART2_SendData8((u8)data);
 181  004d 7b01          	ld	a,(OFST+1,sp)
 182  004f cd0000        	call	_UART2_SendData8
 184                     ; 34 	return 1;
 186  0052 a601          	ld	a,#1
 189  0054 5b01          	addw	sp,#1
 190  0056 81            	ret
 244                     ; 37 u8 UART2_SentString(u8 *data,u16 len){
 245                     	switch	.text
 246  0057               _UART2_SentString:
 248  0057 89            	pushw	x
 249  0058 89            	pushw	x
 250       00000002      OFST:	set	2
 253                     ; 38 	u16 i=0;
 255  0059 5f            	clrw	x
 256  005a 1f01          	ldw	(OFST-1,sp),x
 258  005c 200f          	jra	L511
 259  005e               L111:
 260                     ; 40 		UART2_SentByte(data[i]);
 262  005e 1e03          	ldw	x,(OFST+1,sp)
 263  0060 72fb01        	addw	x,(OFST-1,sp)
 264  0063 f6            	ld	a,(x)
 265  0064 addd          	call	_UART2_SentByte
 267                     ; 39 	for(;i<len;i++){
 269  0066 1e01          	ldw	x,(OFST-1,sp)
 270  0068 1c0001        	addw	x,#1
 271  006b 1f01          	ldw	(OFST-1,sp),x
 272  006d               L511:
 275  006d 1e01          	ldw	x,(OFST-1,sp)
 276  006f 1307          	cpw	x,(OFST+5,sp)
 277  0071 25eb          	jrult	L111
 278                     ; 42 	return 1;
 280  0073 a601          	ld	a,#1
 283  0075 5b04          	addw	sp,#4
 284  0077 81            	ret
 309                     ; 45 u8 UART2_RevByte(void){
 310                     	switch	.text
 311  0078               _UART2_RevByte:
 315  0078               L331:
 316                     ; 46 	while(UART2_GetFlagStatus(UART2_FLAG_RXNE)==RESET);
 318  0078 ae0020        	ldw	x,#32
 319  007b cd0000        	call	_UART2_GetFlagStatus
 321  007e 4d            	tnz	a
 322  007f 27f7          	jreq	L331
 323                     ; 47 	return (UART2_ReceiveData8());
 325  0081 cd0000        	call	_UART2_ReceiveData8
 329  0084 81            	ret
 342                     	xdef	_UART2_RevByte
 343                     	xdef	_UART2_SentString
 344                     	xdef	_UART2_SentByte
 345                     	xdef	_Serial_Port_Init
 346                     	xref	_UART2_ClearFlag
 347                     	xref	_UART2_GetFlagStatus
 348                     	xref	_UART2_SendData8
 349                     	xref	_UART2_ReceiveData8
 350                     	xref	_UART2_ITConfig
 351                     	xref	_UART2_Cmd
 352                     	xref	_UART2_Init
 353                     	xref	_UART2_DeInit
 372                     	end
