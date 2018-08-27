   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.8 - 03 Dec 2008
  45                     ; 18 unsigned char CH_Port_Init(unsigned char ID){
  47                     	switch	.text
  48  0000               _CH_Port_Init:
  52                     ; 19 	if(ID == 0){
  54  0000 4d            	tnz	a
  55  0001 263f          	jrne	L72
  56                     ; 20 		GPIO_Init(COOL_PORT, COOL_PIN, GPIO_MODE_OUT_PP_HIGH_FAST);
  58  0003 4bf0          	push	#240
  59  0005 4b80          	push	#128
  60  0007 ae500f        	ldw	x,#20495
  61  000a cd0000        	call	_GPIO_Init
  63  000d 85            	popw	x
  64                     ; 21 		GPIO_WriteLow(COOL_PORT, COOL_PIN);
  66  000e 4b80          	push	#128
  67  0010 ae500f        	ldw	x,#20495
  68  0013 cd0000        	call	_GPIO_WriteLow
  70  0016 84            	pop	a
  71                     ; 22 		GPIO_Init(HEAT_PORT, HEAT_PIN, GPIO_MODE_OUT_PP_HIGH_FAST);
  73  0017 4bf0          	push	#240
  74  0019 4b10          	push	#16
  75  001b ae500f        	ldw	x,#20495
  76  001e cd0000        	call	_GPIO_Init
  78  0021 85            	popw	x
  79                     ; 23 		GPIO_WriteLow(HEAT_PORT, HEAT_PIN);
  81  0022 4b10          	push	#16
  82  0024 ae500f        	ldw	x,#20495
  83  0027 cd0000        	call	_GPIO_WriteLow
  85  002a 84            	pop	a
  86                     ; 24 		GPIO_Init(FAN_PORT, FAN_PIN, GPIO_MODE_OUT_PP_HIGH_FAST);
  88  002b 4bf0          	push	#240
  89  002d 4b02          	push	#2
  90  002f ae5000        	ldw	x,#20480
  91  0032 cd0000        	call	_GPIO_Init
  93  0035 85            	popw	x
  94                     ; 25 		GPIO_WriteLow(FAN_PORT, FAN_PIN);
  96  0036 4b02          	push	#2
  97  0038 ae5000        	ldw	x,#20480
  98  003b cd0000        	call	_GPIO_WriteLow
 100  003e 84            	pop	a
 102                     ; 29 	return 1;
 104  003f a601          	ld	a,#1
 107  0041 81            	ret
 108  0042               L72:
 109                     ; 27 		return 0;
 111  0042 4f            	clr	a
 114  0043 81            	ret
 159                     ; 33 unsigned char CH_Port_Cool_Set(unsigned char ID,unsigned char Status){
 160                     	switch	.text
 161  0044               _CH_Port_Cool_Set:
 163  0044 89            	pushw	x
 164       00000000      OFST:	set	0
 167                     ; 34 	if(ID == 0){
 169  0045 9e            	ld	a,xh
 170  0046 4d            	tnz	a
 171  0047 2625          	jrne	L55
 172                     ; 35 		if(Status == 0){
 174  0049 9f            	ld	a,xl
 175  004a 4d            	tnz	a
 176  004b 260b          	jrne	L75
 177                     ; 36 			GPIO_WriteLow(COOL_PORT, COOL_PIN);
 179  004d 4b80          	push	#128
 180  004f ae500f        	ldw	x,#20495
 181  0052 cd0000        	call	_GPIO_WriteLow
 183  0055 84            	pop	a
 185  0056 200f          	jra	L76
 186  0058               L75:
 187                     ; 37 		}else if(Status == 1){
 189  0058 7b02          	ld	a,(OFST+2,sp)
 190  005a a101          	cp	a,#1
 191  005c 260d          	jrne	L36
 192                     ; 38 			GPIO_WriteHigh(COOL_PORT, COOL_PIN);
 194  005e 4b80          	push	#128
 195  0060 ae500f        	ldw	x,#20495
 196  0063 cd0000        	call	_GPIO_WriteHigh
 198  0066 84            	pop	a
 200  0067               L76:
 201                     ; 45 	return 1;
 203  0067 a601          	ld	a,#1
 205  0069 2001          	jra	L01
 206  006b               L36:
 207                     ; 40 			return 0;
 209  006b 4f            	clr	a
 211  006c               L01:
 213  006c 85            	popw	x
 214  006d 81            	ret
 215  006e               L55:
 216                     ; 43 		return 0;
 218  006e 4f            	clr	a
 220  006f 20fb          	jra	L01
 265                     ; 48 unsigned char CH_Port_Heat_Set(unsigned char ID,unsigned char Status){
 266                     	switch	.text
 267  0071               _CH_Port_Heat_Set:
 269  0071 89            	pushw	x
 270       00000000      OFST:	set	0
 273                     ; 49 	if(ID == 0){
 275  0072 9e            	ld	a,xh
 276  0073 4d            	tnz	a
 277  0074 2625          	jrne	L311
 278                     ; 50 		if(Status == 0){
 280  0076 9f            	ld	a,xl
 281  0077 4d            	tnz	a
 282  0078 260b          	jrne	L511
 283                     ; 51 			GPIO_WriteLow(HEAT_PORT, HEAT_PIN);
 285  007a 4b10          	push	#16
 286  007c ae500f        	ldw	x,#20495
 287  007f cd0000        	call	_GPIO_WriteLow
 289  0082 84            	pop	a
 291  0083 200f          	jra	L521
 292  0085               L511:
 293                     ; 52 		}else if(Status == 1){
 295  0085 7b02          	ld	a,(OFST+2,sp)
 296  0087 a101          	cp	a,#1
 297  0089 260d          	jrne	L121
 298                     ; 53 			GPIO_WriteHigh(HEAT_PORT, HEAT_PIN);
 300  008b 4b10          	push	#16
 301  008d ae500f        	ldw	x,#20495
 302  0090 cd0000        	call	_GPIO_WriteHigh
 304  0093 84            	pop	a
 306  0094               L521:
 307                     ; 60 	return 1;
 309  0094 a601          	ld	a,#1
 311  0096 2001          	jra	L41
 312  0098               L121:
 313                     ; 55 			return 0;
 315  0098 4f            	clr	a
 317  0099               L41:
 319  0099 85            	popw	x
 320  009a 81            	ret
 321  009b               L311:
 322                     ; 58 		return 0;
 324  009b 4f            	clr	a
 326  009c 20fb          	jra	L41
 371                     ; 63 unsigned char CH_Port_Fan_Set(unsigned char ID,unsigned char Status){
 372                     	switch	.text
 373  009e               _CH_Port_Fan_Set:
 375  009e 89            	pushw	x
 376       00000000      OFST:	set	0
 379                     ; 64 	if(ID == 0){
 381  009f 9e            	ld	a,xh
 382  00a0 4d            	tnz	a
 383  00a1 2625          	jrne	L151
 384                     ; 65 		if(Status == 0){
 386  00a3 9f            	ld	a,xl
 387  00a4 4d            	tnz	a
 388  00a5 260b          	jrne	L351
 389                     ; 66 			GPIO_WriteLow(FAN_PORT, FAN_PIN);
 391  00a7 4b02          	push	#2
 392  00a9 ae5000        	ldw	x,#20480
 393  00ac cd0000        	call	_GPIO_WriteLow
 395  00af 84            	pop	a
 397  00b0 200f          	jra	L361
 398  00b2               L351:
 399                     ; 67 		}else if(Status == 1){
 401  00b2 7b02          	ld	a,(OFST+2,sp)
 402  00b4 a101          	cp	a,#1
 403  00b6 260d          	jrne	L751
 404                     ; 68 			GPIO_WriteHigh(FAN_PORT, FAN_PIN);
 406  00b8 4b02          	push	#2
 407  00ba ae5000        	ldw	x,#20480
 408  00bd cd0000        	call	_GPIO_WriteHigh
 410  00c0 84            	pop	a
 412  00c1               L361:
 413                     ; 75 	return 1;
 415  00c1 a601          	ld	a,#1
 417  00c3 2001          	jra	L02
 418  00c5               L751:
 419                     ; 70 			return 0;
 421  00c5 4f            	clr	a
 423  00c6               L02:
 425  00c6 85            	popw	x
 426  00c7 81            	ret
 427  00c8               L151:
 428                     ; 73 		return 0;
 430  00c8 4f            	clr	a
 432  00c9 20fb          	jra	L02
 471                     ; 78 unsigned char CH_Port_Adc_Init(unsigned char ID){
 472                     	switch	.text
 473  00cb               _CH_Port_Adc_Init:
 477                     ; 79 	if(ID == 0){
 479  00cb 4d            	tnz	a
 480  00cc 2635          	jrne	L302
 481                     ; 80 		GPIO_Init(GPIOB, GPIO_PIN_1, GPIO_MODE_IN_FL_NO_IT);
 483  00ce 4b00          	push	#0
 484  00d0 4b02          	push	#2
 485  00d2 ae5005        	ldw	x,#20485
 486  00d5 cd0000        	call	_GPIO_Init
 488  00d8 85            	popw	x
 489                     ; 81 		ADC1_DeInit();
 491  00d9 cd0000        	call	_ADC1_DeInit
 493                     ; 82 		ADC1_Init(ADC1_CONVERSIONMODE_SINGLE,ADC1_CHANNEL_1,ADC1_PRESSEL_FCPU_D2,\
 493                     ; 83 		ADC1_EXTTRIG_TIM,DISABLE,ADC1_ALIGN_RIGHT,ADC1_SCHMITTTRIG_ALL,DISABLE);
 495  00dc 4b00          	push	#0
 496  00de 4bff          	push	#255
 497  00e0 4b08          	push	#8
 498  00e2 4b00          	push	#0
 499  00e4 4b00          	push	#0
 500  00e6 4b00          	push	#0
 501  00e8 ae0001        	ldw	x,#1
 502  00eb 4f            	clr	a
 503  00ec 95            	ld	xh,a
 504  00ed cd0000        	call	_ADC1_Init
 506  00f0 5b06          	addw	sp,#6
 507                     ; 84 		ADC1_ITConfig(ADC1_IT_EOC,DISABLE);
 509  00f2 4b00          	push	#0
 510  00f4 ae0080        	ldw	x,#128
 511  00f7 cd0000        	call	_ADC1_ITConfig
 513  00fa 84            	pop	a
 514                     ; 85 		ADC1_Cmd(ENABLE);
 516  00fb a601          	ld	a,#1
 517  00fd cd0000        	call	_ADC1_Cmd
 520                     ; 89 	return 1;
 522  0100 a601          	ld	a,#1
 525  0102 81            	ret
 526  0103               L302:
 527                     ; 87 		return 0;
 529  0103 4f            	clr	a
 532  0104 81            	ret
 545                     	xdef	_CH_Port_Adc_Init
 546                     	xdef	_CH_Port_Fan_Set
 547                     	xdef	_CH_Port_Heat_Set
 548                     	xdef	_CH_Port_Cool_Set
 549                     	xdef	_CH_Port_Init
 550                     	xref	_GPIO_WriteLow
 551                     	xref	_GPIO_WriteHigh
 552                     	xref	_GPIO_Init
 553                     	xref	_ADC1_ITConfig
 554                     	xref	_ADC1_Cmd
 555                     	xref	_ADC1_Init
 556                     	xref	_ADC1_DeInit
 575                     	end
