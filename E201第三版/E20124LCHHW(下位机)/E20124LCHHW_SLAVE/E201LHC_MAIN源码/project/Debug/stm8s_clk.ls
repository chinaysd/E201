   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.8 - 03 Dec 2008
   4                     .const:	section	.text
   5  0000               _HSIDivFactor:
   6  0000 01            	dc.b	1
   7  0001 02            	dc.b	2
   8  0002 04            	dc.b	4
   9  0003 08            	dc.b	8
  10  0004               _CLKPrescTable:
  11  0004 01            	dc.b	1
  12  0005 02            	dc.b	2
  13  0006 04            	dc.b	4
  14  0007 08            	dc.b	8
  15  0008 0a            	dc.b	10
  16  0009 10            	dc.b	16
  17  000a 14            	dc.b	20
  18  000b 28            	dc.b	40
  47                     ; 67 void CLK_DeInit(void)
  47                     ; 68 {
  49                     	switch	.text
  50  0000               _CLK_DeInit:
  54                     ; 70     CLK->ICKR = CLK_ICKR_RESET_VALUE;
  56  0000 350150c0      	mov	20672,#1
  57                     ; 71     CLK->ECKR = CLK_ECKR_RESET_VALUE;
  59  0004 725f50c1      	clr	20673
  60                     ; 72     CLK->SWR  = CLK_SWR_RESET_VALUE;
  62  0008 35e150c4      	mov	20676,#225
  63                     ; 73     CLK->SWCR = CLK_SWCR_RESET_VALUE;
  65  000c 725f50c5      	clr	20677
  66                     ; 74     CLK->CKDIVR = CLK_CKDIVR_RESET_VALUE;
  68  0010 351850c6      	mov	20678,#24
  69                     ; 75     CLK->PCKENR1 = CLK_PCKENR1_RESET_VALUE;
  71  0014 35ff50c7      	mov	20679,#255
  72                     ; 76     CLK->PCKENR2 = CLK_PCKENR2_RESET_VALUE;
  74  0018 35ff50ca      	mov	20682,#255
  75                     ; 77     CLK->CSSR = CLK_CSSR_RESET_VALUE;
  77  001c 725f50c8      	clr	20680
  78                     ; 78     CLK->CCOR = CLK_CCOR_RESET_VALUE;
  80  0020 725f50c9      	clr	20681
  82  0024               L52:
  83                     ; 79     while ((CLK->CCOR & CLK_CCOR_CCOEN)!= 0)
  85  0024 c650c9        	ld	a,20681
  86  0027 a501          	bcp	a,#1
  87  0029 26f9          	jrne	L52
  88                     ; 81     CLK->CCOR = CLK_CCOR_RESET_VALUE;
  90  002b 725f50c9      	clr	20681
  91                     ; 82     CLK->HSITRIMR = CLK_HSITRIMR_RESET_VALUE;
  93  002f 725f50cc      	clr	20684
  94                     ; 83     CLK->SWIMCCR = CLK_SWIMCCR_RESET_VALUE;
  96  0033 725f50cd      	clr	20685
  97                     ; 85 }
 100  0037 81            	ret
 237                     ; 517 void CLK_SYSCLKConfig(CLK_Prescaler_TypeDef CLK_Prescaler)
 237                     ; 518 {
 238                     	switch	.text
 239  0038               _CLK_SYSCLKConfig:
 241  0038 88            	push	a
 242       00000000      OFST:	set	0
 245                     ; 523     if (((uint8_t)CLK_Prescaler & (uint8_t)0x80) == 0x00) /* Bit7 = 0 means HSI divider */
 247  0039 a580          	bcp	a,#128
 248  003b 2614          	jrne	L301
 249                     ; 525         CLK->CKDIVR &= (uint8_t)(~CLK_CKDIVR_HSIDIV);
 251  003d c650c6        	ld	a,20678
 252  0040 a4e7          	and	a,#231
 253  0042 c750c6        	ld	20678,a
 254                     ; 526         CLK->CKDIVR |= (uint8_t)((uint8_t)CLK_Prescaler & (uint8_t)CLK_CKDIVR_HSIDIV);
 256  0045 7b01          	ld	a,(OFST+1,sp)
 257  0047 a418          	and	a,#24
 258  0049 ca50c6        	or	a,20678
 259  004c c750c6        	ld	20678,a
 261  004f 2012          	jra	L501
 262  0051               L301:
 263                     ; 530         CLK->CKDIVR &= (uint8_t)(~CLK_CKDIVR_CPUDIV);
 265  0051 c650c6        	ld	a,20678
 266  0054 a4f8          	and	a,#248
 267  0056 c750c6        	ld	20678,a
 268                     ; 531         CLK->CKDIVR |= (uint8_t)((uint8_t)CLK_Prescaler & (uint8_t)CLK_CKDIVR_CPUDIV);
 270  0059 7b01          	ld	a,(OFST+1,sp)
 271  005b a407          	and	a,#7
 272  005d ca50c6        	or	a,20678
 273  0060 c750c6        	ld	20678,a
 274  0063               L501:
 275                     ; 534 }
 278  0063 84            	pop	a
 279  0064 81            	ret
 369                     ; 592 uint32_t CLK_GetClockFreq(void)
 369                     ; 593 {
 370                     	switch	.text
 371  0065               _CLK_GetClockFreq:
 373  0065 5209          	subw	sp,#9
 374       00000009      OFST:	set	9
 377                     ; 595     uint32_t clockfrequency = 0;
 379  0067 96            	ldw	x,sp
 380  0068 1c0005        	addw	x,#OFST-4
 381  006b cd0000        	call	c_ltor
 383                     ; 596     CLK_Source_TypeDef clocksource = CLK_SOURCE_HSI;
 385  006e 7b09          	ld	a,(OFST+0,sp)
 386  0070 97            	ld	xl,a
 387                     ; 597     uint8_t tmp = 0, presc = 0;
 389  0071 7b09          	ld	a,(OFST+0,sp)
 390  0073 97            	ld	xl,a
 393  0074 7b09          	ld	a,(OFST+0,sp)
 394  0076 97            	ld	xl,a
 395                     ; 600     clocksource = (CLK_Source_TypeDef)CLK->CMSR;
 397  0077 c650c3        	ld	a,20675
 398  007a 6b09          	ld	(OFST+0,sp),a
 399                     ; 602     if (clocksource == CLK_SOURCE_HSI)
 401  007c 7b09          	ld	a,(OFST+0,sp)
 402  007e a1e1          	cp	a,#225
 403  0080 2642          	jrne	L351
 404                     ; 604         tmp = (uint8_t)(CLK->CKDIVR & CLK_CKDIVR_HSIDIV);
 406  0082 c650c6        	ld	a,20678
 407  0085 a418          	and	a,#24
 408  0087 6b09          	ld	(OFST+0,sp),a
 409                     ; 605         tmp = (uint8_t)(tmp >> 3);
 411  0089 7b09          	ld	a,(OFST+0,sp)
 412  008b 44            	srl	a
 413  008c 44            	srl	a
 414  008d 44            	srl	a
 415  008e 6b09          	ld	(OFST+0,sp),a
 416                     ; 606         presc = HSIDivFactor[tmp];
 418  0090 7b09          	ld	a,(OFST+0,sp)
 419  0092 5f            	clrw	x
 420  0093 97            	ld	xl,a
 421  0094 d60000        	ld	a,(_HSIDivFactor,x)
 422  0097 6b09          	ld	(OFST+0,sp),a
 423                     ; 607         clockfrequency = HSI_VALUE / presc;
 425  0099 7b09          	ld	a,(OFST+0,sp)
 426  009b b703          	ld	c_lreg+3,a
 427  009d 3f02          	clr	c_lreg+2
 428  009f 3f01          	clr	c_lreg+1
 429  00a1 3f00          	clr	c_lreg
 430  00a3 96            	ldw	x,sp
 431  00a4 1c0001        	addw	x,#OFST-8
 432  00a7 cd0000        	call	c_rtol
 434  00aa ae2400        	ldw	x,#9216
 435  00ad bf02          	ldw	c_lreg+2,x
 436  00af ae00f4        	ldw	x,#244
 437  00b2 bf00          	ldw	c_lreg,x
 438  00b4 96            	ldw	x,sp
 439  00b5 1c0001        	addw	x,#OFST-8
 440  00b8 cd0000        	call	c_ludv
 442  00bb 96            	ldw	x,sp
 443  00bc 1c0005        	addw	x,#OFST-4
 444  00bf cd0000        	call	c_rtol
 447  00c2 201c          	jra	L551
 448  00c4               L351:
 449                     ; 609     else if ( clocksource == CLK_SOURCE_LSI)
 451  00c4 7b09          	ld	a,(OFST+0,sp)
 452  00c6 a1d2          	cp	a,#210
 453  00c8 260c          	jrne	L751
 454                     ; 611         clockfrequency = LSI_VALUE;
 456  00ca aef400        	ldw	x,#62464
 457  00cd 1f07          	ldw	(OFST-2,sp),x
 458  00cf ae0001        	ldw	x,#1
 459  00d2 1f05          	ldw	(OFST-4,sp),x
 461  00d4 200a          	jra	L551
 462  00d6               L751:
 463                     ; 615         clockfrequency = HSE_VALUE;
 465  00d6 ae2400        	ldw	x,#9216
 466  00d9 1f07          	ldw	(OFST-2,sp),x
 467  00db ae00f4        	ldw	x,#244
 468  00de 1f05          	ldw	(OFST-4,sp),x
 469  00e0               L551:
 470                     ; 618     return((uint32_t)clockfrequency);
 472  00e0 96            	ldw	x,sp
 473  00e1 1c0005        	addw	x,#OFST-4
 474  00e4 cd0000        	call	c_ltor
 478  00e7 5b09          	addw	sp,#9
 479  00e9 81            	ret
 514                     	xdef	_CLKPrescTable
 515                     	xdef	_HSIDivFactor
 516                     	xdef	_CLK_GetClockFreq
 517                     	xdef	_CLK_SYSCLKConfig
 518                     	xdef	_CLK_DeInit
 519                     	xref.b	c_lreg
 520                     	xref.b	c_x
 539                     	xref	c_ludv
 540                     	xref	c_rtol
 541                     	xref	c_ltor
 542                     	end
