   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.8 - 03 Dec 2008
  32                     ; 47 void EXTI_DeInit(void)
  32                     ; 48 {
  34                     	switch	.text
  35  0000               _EXTI_DeInit:
  39                     ; 49     EXTI->CR1 = EXTI_CR1_RESET_VALUE;
  41  0000 725f50a0      	clr	20640
  42                     ; 50     EXTI->CR2 = EXTI_CR2_RESET_VALUE;
  44  0004 725f50a1      	clr	20641
  45                     ; 51 }
  48  0008 81            	ret
 173                     ; 64 void EXTI_SetExtIntSensitivity(EXTI_Port_TypeDef Port, EXTI_Sensitivity_TypeDef SensitivityValue)
 173                     ; 65 {
 174                     	switch	.text
 175  0009               _EXTI_SetExtIntSensitivity:
 177  0009 89            	pushw	x
 178       00000000      OFST:	set	0
 181                     ; 68     assert_param(IS_EXTI_PORT_OK(Port));
 183                     ; 69     assert_param(IS_EXTI_SENSITIVITY_OK(SensitivityValue));
 185                     ; 72     switch (Port)
 187  000a 9e            	ld	a,xh
 189                     ; 94     default:
 189                     ; 95         break;
 190  000b 4d            	tnz	a
 191  000c 270e          	jreq	L12
 192  000e 4a            	dec	a
 193  000f 271d          	jreq	L32
 194  0011 4a            	dec	a
 195  0012 272e          	jreq	L52
 196  0014 4a            	dec	a
 197  0015 2742          	jreq	L72
 198  0017 4a            	dec	a
 199  0018 2756          	jreq	L13
 200  001a 2064          	jra	L311
 201  001c               L12:
 202                     ; 74     case EXTI_PORT_GPIOA:
 202                     ; 75         EXTI->CR1 &= (uint8_t)(~EXTI_CR1_PAIS);
 204  001c c650a0        	ld	a,20640
 205  001f a4fc          	and	a,#252
 206  0021 c750a0        	ld	20640,a
 207                     ; 76         EXTI->CR1 |= (uint8_t)(SensitivityValue);
 209  0024 c650a0        	ld	a,20640
 210  0027 1a02          	or	a,(OFST+2,sp)
 211  0029 c750a0        	ld	20640,a
 212                     ; 77         break;
 214  002c 2052          	jra	L311
 215  002e               L32:
 216                     ; 78     case EXTI_PORT_GPIOB:
 216                     ; 79         EXTI->CR1 &= (uint8_t)(~EXTI_CR1_PBIS);
 218  002e c650a0        	ld	a,20640
 219  0031 a4f3          	and	a,#243
 220  0033 c750a0        	ld	20640,a
 221                     ; 80         EXTI->CR1 |= (uint8_t)((uint8_t)(SensitivityValue) << 2);
 223  0036 7b02          	ld	a,(OFST+2,sp)
 224  0038 48            	sll	a
 225  0039 48            	sll	a
 226  003a ca50a0        	or	a,20640
 227  003d c750a0        	ld	20640,a
 228                     ; 81         break;
 230  0040 203e          	jra	L311
 231  0042               L52:
 232                     ; 82     case EXTI_PORT_GPIOC:
 232                     ; 83         EXTI->CR1 &= (uint8_t)(~EXTI_CR1_PCIS);
 234  0042 c650a0        	ld	a,20640
 235  0045 a4cf          	and	a,#207
 236  0047 c750a0        	ld	20640,a
 237                     ; 84         EXTI->CR1 |= (uint8_t)((uint8_t)(SensitivityValue) << 4);
 239  004a 7b02          	ld	a,(OFST+2,sp)
 240  004c 97            	ld	xl,a
 241  004d a610          	ld	a,#16
 242  004f 42            	mul	x,a
 243  0050 9f            	ld	a,xl
 244  0051 ca50a0        	or	a,20640
 245  0054 c750a0        	ld	20640,a
 246                     ; 85         break;
 248  0057 2027          	jra	L311
 249  0059               L72:
 250                     ; 86     case EXTI_PORT_GPIOD:
 250                     ; 87         EXTI->CR1 &= (uint8_t)(~EXTI_CR1_PDIS);
 252  0059 c650a0        	ld	a,20640
 253  005c a43f          	and	a,#63
 254  005e c750a0        	ld	20640,a
 255                     ; 88         EXTI->CR1 |= (uint8_t)((uint8_t)(SensitivityValue) << 6);
 257  0061 7b02          	ld	a,(OFST+2,sp)
 258  0063 97            	ld	xl,a
 259  0064 a640          	ld	a,#64
 260  0066 42            	mul	x,a
 261  0067 9f            	ld	a,xl
 262  0068 ca50a0        	or	a,20640
 263  006b c750a0        	ld	20640,a
 264                     ; 89         break;
 266  006e 2010          	jra	L311
 267  0070               L13:
 268                     ; 90     case EXTI_PORT_GPIOE:
 268                     ; 91         EXTI->CR2 &= (uint8_t)(~EXTI_CR2_PEIS);
 270  0070 c650a1        	ld	a,20641
 271  0073 a4fc          	and	a,#252
 272  0075 c750a1        	ld	20641,a
 273                     ; 92         EXTI->CR2 |= (uint8_t)(SensitivityValue);
 275  0078 c650a1        	ld	a,20641
 276  007b 1a02          	or	a,(OFST+2,sp)
 277  007d c750a1        	ld	20641,a
 278                     ; 93         break;
 280  0080               L33:
 281                     ; 94     default:
 281                     ; 95         break;
 283  0080               L311:
 284                     ; 97 }
 287  0080 85            	popw	x
 288  0081 81            	ret
 346                     ; 106 void EXTI_SetTLISensitivity(EXTI_TLISensitivity_TypeDef SensitivityValue)
 346                     ; 107 {
 347                     	switch	.text
 348  0082               _EXTI_SetTLISensitivity:
 352                     ; 109     assert_param(IS_EXTI_TLISENSITIVITY_OK(SensitivityValue));
 354                     ; 112     EXTI->CR2 &= (uint8_t)(~EXTI_CR2_TLIS);
 356  0082 721550a1      	bres	20641,#2
 357                     ; 113     EXTI->CR2 |= (uint8_t)(SensitivityValue);
 359  0086 ca50a1        	or	a,20641
 360  0089 c750a1        	ld	20641,a
 361                     ; 114 }
 364  008c 81            	ret
 410                     ; 121 EXTI_Sensitivity_TypeDef EXTI_GetExtIntSensitivity(EXTI_Port_TypeDef Port)
 410                     ; 122 {
 411                     	switch	.text
 412  008d               _EXTI_GetExtIntSensitivity:
 414  008d 88            	push	a
 415       00000001      OFST:	set	1
 418                     ; 123     uint8_t value = 0;
 420  008e 0f01          	clr	(OFST+0,sp)
 421                     ; 126     assert_param(IS_EXTI_PORT_OK(Port));
 423                     ; 128     switch (Port)
 426                     ; 145     default:
 426                     ; 146         break;
 427  0090 4d            	tnz	a
 428  0091 270e          	jreq	L341
 429  0093 4a            	dec	a
 430  0094 2714          	jreq	L541
 431  0096 4a            	dec	a
 432  0097 271c          	jreq	L741
 433  0099 4a            	dec	a
 434  009a 2725          	jreq	L151
 435  009c 4a            	dec	a
 436  009d 2730          	jreq	L351
 437  009f 2035          	jra	L302
 438  00a1               L341:
 439                     ; 130     case EXTI_PORT_GPIOA:
 439                     ; 131         value = (uint8_t)(EXTI->CR1 & EXTI_CR1_PAIS);
 441  00a1 c650a0        	ld	a,20640
 442  00a4 a403          	and	a,#3
 443  00a6 6b01          	ld	(OFST+0,sp),a
 444                     ; 132         break;
 446  00a8 202c          	jra	L302
 447  00aa               L541:
 448                     ; 133     case EXTI_PORT_GPIOB:
 448                     ; 134         value = (uint8_t)((uint8_t)(EXTI->CR1 & EXTI_CR1_PBIS) >> 2);
 450  00aa c650a0        	ld	a,20640
 451  00ad a40c          	and	a,#12
 452  00af 44            	srl	a
 453  00b0 44            	srl	a
 454  00b1 6b01          	ld	(OFST+0,sp),a
 455                     ; 135         break;
 457  00b3 2021          	jra	L302
 458  00b5               L741:
 459                     ; 136     case EXTI_PORT_GPIOC:
 459                     ; 137         value = (uint8_t)((uint8_t)(EXTI->CR1 & EXTI_CR1_PCIS) >> 4);
 461  00b5 c650a0        	ld	a,20640
 462  00b8 a430          	and	a,#48
 463  00ba 4e            	swap	a
 464  00bb a40f          	and	a,#15
 465  00bd 6b01          	ld	(OFST+0,sp),a
 466                     ; 138         break;
 468  00bf 2015          	jra	L302
 469  00c1               L151:
 470                     ; 139     case EXTI_PORT_GPIOD:
 470                     ; 140         value = (uint8_t)((uint8_t)(EXTI->CR1 & EXTI_CR1_PDIS) >> 6);
 472  00c1 c650a0        	ld	a,20640
 473  00c4 a4c0          	and	a,#192
 474  00c6 4e            	swap	a
 475  00c7 44            	srl	a
 476  00c8 44            	srl	a
 477  00c9 a403          	and	a,#3
 478  00cb 6b01          	ld	(OFST+0,sp),a
 479                     ; 141         break;
 481  00cd 2007          	jra	L302
 482  00cf               L351:
 483                     ; 142     case EXTI_PORT_GPIOE:
 483                     ; 143         value = (uint8_t)(EXTI->CR2 & EXTI_CR2_PEIS);
 485  00cf c650a1        	ld	a,20641
 486  00d2 a403          	and	a,#3
 487  00d4 6b01          	ld	(OFST+0,sp),a
 488                     ; 144         break;
 490  00d6               L551:
 491                     ; 145     default:
 491                     ; 146         break;
 493  00d6               L302:
 494                     ; 149     return((EXTI_Sensitivity_TypeDef)value);
 496  00d6 7b01          	ld	a,(OFST+0,sp)
 499  00d8 5b01          	addw	sp,#1
 500  00da 81            	ret
 536                     ; 157 EXTI_TLISensitivity_TypeDef EXTI_GetTLISensitivity(void)
 536                     ; 158 {
 537                     	switch	.text
 538  00db               _EXTI_GetTLISensitivity:
 540  00db 88            	push	a
 541       00000001      OFST:	set	1
 544                     ; 160     uint8_t value = 0;
 546  00dc 0f01          	clr	(OFST+0,sp)
 547                     ; 163     value = (uint8_t)(EXTI->CR2 & EXTI_CR2_TLIS);
 549  00de c650a1        	ld	a,20641
 550  00e1 a404          	and	a,#4
 551  00e3 6b01          	ld	(OFST+0,sp),a
 552                     ; 165     return((EXTI_TLISensitivity_TypeDef)value);
 554  00e5 7b01          	ld	a,(OFST+0,sp)
 557  00e7 5b01          	addw	sp,#1
 558  00e9 81            	ret
 571                     	xdef	_EXTI_GetTLISensitivity
 572                     	xdef	_EXTI_GetExtIntSensitivity
 573                     	xdef	_EXTI_SetTLISensitivity
 574                     	xdef	_EXTI_SetExtIntSensitivity
 575                     	xdef	_EXTI_DeInit
 594                     	end
