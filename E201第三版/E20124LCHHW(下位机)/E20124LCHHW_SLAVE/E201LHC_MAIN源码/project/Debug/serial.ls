   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.8 - 03 Dec 2008
   4                     	xref	_Serial_Port_Init
  54                     ; 12 u8 Serial_Init(u8 ID,uint32_t BaudRate){
  56                     	switch	.text
  57  0000               _Serial_Init:
  59  0000 88            	push	a
  60       00000000      OFST:	set	0
  63                     ; 15 	return Serial_Port_Init(ID,BaudRate);
  65  0001 1e06          	ldw	x,(OFST+6,sp)
  66  0003 89            	pushw	x
  67  0004 1e06          	ldw	x,(OFST+6,sp)
  68  0006 89            	pushw	x
  69  0007 cd0000        	call	_Serial_Port_Init
  71  000a 5b04          	addw	sp,#4
  74  000c 5b01          	addw	sp,#1
  75  000e 81            	ret
  78                     	xref	_UART2_SentByte
 111                     ; 18 u8 Serial_SentByte(u8 data){
 112                     	switch	.text
 113  000f               _Serial_SentByte:
 117                     ; 21 	return UART2_SentByte(data);
 119  000f cd0000        	call	_UART2_SentByte
 123  0012 81            	ret
 126                     	xref	_UART2_RevByte
 148                     ; 25 u8 Serial_RevByte(void){
 149                     	switch	.text
 150  0013               _Serial_RevByte:
 154                     ; 28 	return UART2_RevByte();
 156  0013 cd0000        	call	_UART2_RevByte
 160  0016 81            	ret
 198                     ; 34 void Serial_Rev_IQH(void){
 199                     	switch	.text
 200  0017               _Serial_Rev_IQH:
 202  0017 88            	push	a
 203       00000001      OFST:	set	1
 206                     ; 36 	if(UART2_GetITStatus(UART2_IT_RXNE)!=RESET){
 208  0018 ae0255        	ldw	x,#597
 209  001b cd0000        	call	_UART2_GetITStatus
 211  001e 4d            	tnz	a
 212  001f 2747          	jreq	L101
 213                     ; 37 		res=UART2_ReceiveData8();
 215  0021 cd0000        	call	_UART2_ReceiveData8
 217  0024 6b01          	ld	(OFST+0,sp),a
 218                     ; 38 		if((Rx_Num & 0x80) == 0){
 220  0026 b600          	ld	a,L3_Rx_Num
 221  0028 a580          	bcp	a,#128
 222  002a 263c          	jrne	L101
 223                     ; 39 			if(Rx_Num & 0x40)	{// 接收到了0x0d
 225  002c b600          	ld	a,L3_Rx_Num
 226  002e a540          	bcp	a,#64
 227  0030 2710          	jreq	L501
 228                     ; 40 				if(res != 0x0a)		
 230  0032 7b01          	ld	a,(OFST+0,sp)
 231  0034 a10a          	cp	a,#10
 232  0036 2704          	jreq	L701
 233                     ; 41 					Rx_Num = 0;
 235  0038 3f00          	clr	L3_Rx_Num
 237  003a 202c          	jra	L101
 238  003c               L701:
 239                     ; 43 					Rx_Num |= 0x80;		//  接收完成
 241  003c 721e0000      	bset	L3_Rx_Num,#7
 242  0040 2026          	jra	L101
 243  0042               L501:
 244                     ; 46 				if(res == 0x0d)
 246  0042 7b01          	ld	a,(OFST+0,sp)
 247  0044 a10d          	cp	a,#13
 248  0046 2606          	jrne	L511
 249                     ; 47 					Rx_Num |= 0x40;
 251  0048 721c0000      	bset	L3_Rx_Num,#6
 253  004c 201a          	jra	L101
 254  004e               L511:
 255                     ; 49 					Rev_Para.Buf[Rx_Num] = res;
 257  004e b600          	ld	a,L3_Rx_Num
 258  0050 5f            	clrw	x
 259  0051 97            	ld	xl,a
 260  0052 7b01          	ld	a,(OFST+0,sp)
 261  0054 e701          	ld	(_Rev_Para,x),a
 262                     ; 50 					Rx_Num ++;
 264  0056 3c00          	inc	L3_Rx_Num
 265                     ; 51 					if(Rev_Para.Buf[0] != START_FIELD)		// start field is correct
 267  0058 b601          	ld	a,_Rev_Para
 268  005a a155          	cp	a,#85
 269  005c 2702          	jreq	L121
 270                     ; 52 						Rx_Num = 0;
 272  005e 3f00          	clr	L3_Rx_Num
 273  0060               L121:
 274                     ; 53 					if(Rx_Num > BUF_SIZE){
 276  0060 b600          	ld	a,L3_Rx_Num
 277  0062 a108          	cp	a,#8
 278  0064 2502          	jrult	L101
 279                     ; 54 						Rx_Num = 0;
 281  0066 3f00          	clr	L3_Rx_Num
 282  0068               L101:
 283                     ; 60 }
 286  0068 84            	pop	a
 287  0069 81            	ret
 311                     ; 65 u8 Serial_Get_Status(void){
 312                     	switch	.text
 313  006a               _Serial_Get_Status:
 317                     ; 66 	if(Rx_Num & 0x80){
 319  006a b600          	ld	a,L3_Rx_Num
 320  006c a580          	bcp	a,#128
 321  006e 2705          	jreq	L531
 322                     ; 67 		Rx_Num = 0;
 324  0070 3f00          	clr	L3_Rx_Num
 325                     ; 68 		return 1;
 327  0072 a601          	ld	a,#1
 330  0074 81            	ret
 331  0075               L531:
 332                     ; 70 		return 0;
 334  0075 4f            	clr	a
 337  0076 81            	ret
 454                     	xdef	_Serial_RevByte
 455                     	xdef	_Serial_SentByte
 456                     	xdef	_Serial_Init
 457                     	switch	.ubsct
 458  0000               L3_Rx_Num:
 459  0000 00            	ds.b	1
 460  0001               _Rev_Para:
 461  0001 000000000000  	ds.b	7
 462                     	xdef	_Rev_Para
 463                     	xdef	_Serial_Get_Status
 464                     	xdef	_Serial_Rev_IQH
 465                     	xref	_UART2_GetITStatus
 466                     	xref	_UART2_ReceiveData8
 486                     	end
