   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.8 - 03 Dec 2008
  32                     ; 47 void UART2_DeInit(void)
  32                     ; 48 {
  34                     	switch	.text
  35  0000               _UART2_DeInit:
  39                     ; 51     (void) UART2->SR;
  41  0000 c65240        	ld	a,21056
  42  0003 97            	ld	xl,a
  43                     ; 52     (void)UART2->DR;
  45  0004 c65241        	ld	a,21057
  46  0007 97            	ld	xl,a
  47                     ; 54     UART2->BRR2 = UART2_BRR2_RESET_VALUE;  /*  Set UART2_BRR2 to reset value 0x00 */
  49  0008 725f5243      	clr	21059
  50                     ; 55     UART2->BRR1 = UART2_BRR1_RESET_VALUE;  /*  Set UART2_BRR1 to reset value 0x00 */
  52  000c 725f5242      	clr	21058
  53                     ; 57     UART2->CR1 = UART2_CR1_RESET_VALUE; /*  Set UART2_CR1 to reset value 0x00  */
  55  0010 725f5244      	clr	21060
  56                     ; 58     UART2->CR2 = UART2_CR2_RESET_VALUE; /*  Set UART2_CR2 to reset value 0x00  */
  58  0014 725f5245      	clr	21061
  59                     ; 59     UART2->CR3 = UART2_CR3_RESET_VALUE; /*  Set UART2_CR3 to reset value 0x00  */
  61  0018 725f5246      	clr	21062
  62                     ; 60     UART2->CR4 = UART2_CR4_RESET_VALUE; /*  Set UART2_CR4 to reset value 0x00  */
  64  001c 725f5247      	clr	21063
  65                     ; 61     UART2->CR5 = UART2_CR5_RESET_VALUE; /*  Set UART2_CR5 to reset value 0x00  */
  67  0020 725f5248      	clr	21064
  68                     ; 62     UART2->CR6 = UART2_CR6_RESET_VALUE; /*  Set UART2_CR6 to reset value 0x00  */
  70  0024 725f5249      	clr	21065
  71                     ; 64 }
  74  0028 81            	ret
 395                     .const:	section	.text
 396  0000               L01:
 397  0000 00000064      	dc.l	100
 398                     ; 80 void UART2_Init(uint32_t BaudRate, UART2_WordLength_TypeDef WordLength, UART2_StopBits_TypeDef StopBits, UART2_Parity_TypeDef Parity, UART2_SyncMode_TypeDef SyncMode, UART2_Mode_TypeDef Mode)
 398                     ; 81 {
 399                     	switch	.text
 400  0029               _UART2_Init:
 402  0029 520e          	subw	sp,#14
 403       0000000e      OFST:	set	14
 406                     ; 82     uint8_t BRR2_1 = 0, BRR2_2 = 0;
 408  002b 7b05          	ld	a,(OFST-9,sp)
 409  002d 97            	ld	xl,a
 412  002e 7b06          	ld	a,(OFST-8,sp)
 413  0030 97            	ld	xl,a
 414                     ; 83     uint32_t BaudRate_Mantissa = 0, BaudRate_Mantissa100 = 0;
 416  0031 96            	ldw	x,sp
 417  0032 1c000b        	addw	x,#OFST-3
 418  0035 cd0000        	call	c_ltor
 422  0038 96            	ldw	x,sp
 423  0039 1c0007        	addw	x,#OFST-7
 424  003c cd0000        	call	c_ltor
 426                     ; 86     assert_param(IS_UART2_BAUDRATE_OK(BaudRate));
 428                     ; 87     assert_param(IS_UART2_WORDLENGTH_OK(WordLength));
 430                     ; 88     assert_param(IS_UART2_STOPBITS_OK(StopBits));
 432                     ; 89     assert_param(IS_UART2_PARITY_OK(Parity));
 434                     ; 90     assert_param(IS_UART2_MODE_OK((uint8_t)Mode));
 436                     ; 91     assert_param(IS_UART2_SYNCMODE_OK((uint8_t)SyncMode));
 438                     ; 94     UART2->CR1 &= (uint8_t)(~UART2_CR1_M);
 440  003f 72195244      	bres	21060,#4
 441                     ; 96     UART2->CR1 |= (uint8_t)WordLength; 
 443  0043 c65244        	ld	a,21060
 444  0046 1a15          	or	a,(OFST+7,sp)
 445  0048 c75244        	ld	21060,a
 446                     ; 99     UART2->CR3 &= (uint8_t)(~UART2_CR3_STOP);
 448  004b c65246        	ld	a,21062
 449  004e a4cf          	and	a,#207
 450  0050 c75246        	ld	21062,a
 451                     ; 101     UART2->CR3 |= (uint8_t)StopBits; 
 453  0053 c65246        	ld	a,21062
 454  0056 1a16          	or	a,(OFST+8,sp)
 455  0058 c75246        	ld	21062,a
 456                     ; 104     UART2->CR1 &= (uint8_t)(~(UART2_CR1_PCEN | UART2_CR1_PS  ));
 458  005b c65244        	ld	a,21060
 459  005e a4f9          	and	a,#249
 460  0060 c75244        	ld	21060,a
 461                     ; 106     UART2->CR1 |= (uint8_t)Parity;
 463  0063 c65244        	ld	a,21060
 464  0066 1a17          	or	a,(OFST+9,sp)
 465  0068 c75244        	ld	21060,a
 466                     ; 109     UART2->BRR1 &= (uint8_t)(~UART2_BRR1_DIVM);
 468  006b 725f5242      	clr	21058
 469                     ; 111     UART2->BRR2 &= (uint8_t)(~UART2_BRR2_DIVM);
 471  006f c65243        	ld	a,21059
 472  0072 a40f          	and	a,#15
 473  0074 c75243        	ld	21059,a
 474                     ; 113     UART2->BRR2 &= (uint8_t)(~UART2_BRR2_DIVF);
 476  0077 c65243        	ld	a,21059
 477  007a a4f0          	and	a,#240
 478  007c c75243        	ld	21059,a
 479                     ; 116     BaudRate_Mantissa    = ((uint32_t)CLK_GetClockFreq() / (BaudRate << 4));
 481  007f 96            	ldw	x,sp
 482  0080 1c0011        	addw	x,#OFST+3
 483  0083 cd0000        	call	c_ltor
 485  0086 a604          	ld	a,#4
 486  0088 cd0000        	call	c_llsh
 488  008b 96            	ldw	x,sp
 489  008c 1c0001        	addw	x,#OFST-13
 490  008f cd0000        	call	c_rtol
 492  0092 cd0000        	call	_CLK_GetClockFreq
 494  0095 96            	ldw	x,sp
 495  0096 1c0001        	addw	x,#OFST-13
 496  0099 cd0000        	call	c_ludv
 498  009c 96            	ldw	x,sp
 499  009d 1c000b        	addw	x,#OFST-3
 500  00a0 cd0000        	call	c_rtol
 502                     ; 117     BaudRate_Mantissa100 = (((uint32_t)CLK_GetClockFreq() * 100) / (BaudRate << 4));
 504  00a3 96            	ldw	x,sp
 505  00a4 1c0011        	addw	x,#OFST+3
 506  00a7 cd0000        	call	c_ltor
 508  00aa a604          	ld	a,#4
 509  00ac cd0000        	call	c_llsh
 511  00af 96            	ldw	x,sp
 512  00b0 1c0001        	addw	x,#OFST-13
 513  00b3 cd0000        	call	c_rtol
 515  00b6 cd0000        	call	_CLK_GetClockFreq
 517  00b9 a664          	ld	a,#100
 518  00bb cd0000        	call	c_smul
 520  00be 96            	ldw	x,sp
 521  00bf 1c0001        	addw	x,#OFST-13
 522  00c2 cd0000        	call	c_ludv
 524  00c5 96            	ldw	x,sp
 525  00c6 1c0007        	addw	x,#OFST-7
 526  00c9 cd0000        	call	c_rtol
 528                     ; 121     BRR2_1 = (uint8_t)((uint8_t)(((BaudRate_Mantissa100 - (BaudRate_Mantissa * 100))
 528                     ; 122                         << 4) / 100) & (uint8_t)0x0F); 
 530  00cc 96            	ldw	x,sp
 531  00cd 1c000b        	addw	x,#OFST-3
 532  00d0 cd0000        	call	c_ltor
 534  00d3 a664          	ld	a,#100
 535  00d5 cd0000        	call	c_smul
 537  00d8 96            	ldw	x,sp
 538  00d9 1c0001        	addw	x,#OFST-13
 539  00dc cd0000        	call	c_rtol
 541  00df 96            	ldw	x,sp
 542  00e0 1c0007        	addw	x,#OFST-7
 543  00e3 cd0000        	call	c_ltor
 545  00e6 96            	ldw	x,sp
 546  00e7 1c0001        	addw	x,#OFST-13
 547  00ea cd0000        	call	c_lsub
 549  00ed a604          	ld	a,#4
 550  00ef cd0000        	call	c_llsh
 552  00f2 ae0000        	ldw	x,#L01
 553  00f5 cd0000        	call	c_ludv
 555  00f8 b603          	ld	a,c_lreg+3
 556  00fa a40f          	and	a,#15
 557  00fc 6b05          	ld	(OFST-9,sp),a
 558                     ; 123     BRR2_2 = (uint8_t)((BaudRate_Mantissa >> 4) & (uint8_t)0xF0);
 560  00fe 96            	ldw	x,sp
 561  00ff 1c000b        	addw	x,#OFST-3
 562  0102 cd0000        	call	c_ltor
 564  0105 a604          	ld	a,#4
 565  0107 cd0000        	call	c_lursh
 567  010a b603          	ld	a,c_lreg+3
 568  010c a4f0          	and	a,#240
 569  010e b703          	ld	c_lreg+3,a
 570  0110 3f02          	clr	c_lreg+2
 571  0112 3f01          	clr	c_lreg+1
 572  0114 3f00          	clr	c_lreg
 573  0116 b603          	ld	a,c_lreg+3
 574  0118 6b06          	ld	(OFST-8,sp),a
 575                     ; 125     UART2->BRR2 = (uint8_t)(BRR2_1 | BRR2_2);
 577  011a 7b05          	ld	a,(OFST-9,sp)
 578  011c 1a06          	or	a,(OFST-8,sp)
 579  011e c75243        	ld	21059,a
 580                     ; 127     UART2->BRR1 = (uint8_t)BaudRate_Mantissa;           
 582  0121 7b0e          	ld	a,(OFST+0,sp)
 583  0123 c75242        	ld	21058,a
 584                     ; 130     UART2->CR2 &= (uint8_t)~(UART2_CR2_TEN | UART2_CR2_REN);
 586  0126 c65245        	ld	a,21061
 587  0129 a4f3          	and	a,#243
 588  012b c75245        	ld	21061,a
 589                     ; 132     UART2->CR3 &= (uint8_t)~(UART2_CR3_CPOL | UART2_CR3_CPHA | UART2_CR3_LBCL);
 591  012e c65246        	ld	a,21062
 592  0131 a4f8          	and	a,#248
 593  0133 c75246        	ld	21062,a
 594                     ; 134     UART2->CR3 |= (uint8_t)((uint8_t)SyncMode & (uint8_t)(UART2_CR3_CPOL | \
 594                     ; 135                                               UART2_CR3_CPHA | UART2_CR3_LBCL));
 596  0136 7b18          	ld	a,(OFST+10,sp)
 597  0138 a407          	and	a,#7
 598  013a ca5246        	or	a,21062
 599  013d c75246        	ld	21062,a
 600                     ; 137     if ((uint8_t)(Mode & UART2_MODE_TX_ENABLE))
 602  0140 7b19          	ld	a,(OFST+11,sp)
 603  0142 a504          	bcp	a,#4
 604  0144 2706          	jreq	L302
 605                     ; 140         UART2->CR2 |= (uint8_t)UART2_CR2_TEN;
 607  0146 72165245      	bset	21061,#3
 609  014a 2004          	jra	L502
 610  014c               L302:
 611                     ; 145         UART2->CR2 &= (uint8_t)(~UART2_CR2_TEN);
 613  014c 72175245      	bres	21061,#3
 614  0150               L502:
 615                     ; 147     if ((uint8_t)(Mode & UART2_MODE_RX_ENABLE))
 617  0150 7b19          	ld	a,(OFST+11,sp)
 618  0152 a508          	bcp	a,#8
 619  0154 2706          	jreq	L702
 620                     ; 150         UART2->CR2 |= (uint8_t)UART2_CR2_REN;
 622  0156 72145245      	bset	21061,#2
 624  015a 2004          	jra	L112
 625  015c               L702:
 626                     ; 155         UART2->CR2 &= (uint8_t)(~UART2_CR2_REN);
 628  015c 72155245      	bres	21061,#2
 629  0160               L112:
 630                     ; 159     if ((uint8_t)(SyncMode & UART2_SYNCMODE_CLOCK_DISABLE))
 632  0160 7b18          	ld	a,(OFST+10,sp)
 633  0162 a580          	bcp	a,#128
 634  0164 2706          	jreq	L312
 635                     ; 162         UART2->CR3 &= (uint8_t)(~UART2_CR3_CKEN); 
 637  0166 72175246      	bres	21062,#3
 639  016a 200a          	jra	L512
 640  016c               L312:
 641                     ; 166         UART2->CR3 |= (uint8_t)((uint8_t)SyncMode & UART2_CR3_CKEN);
 643  016c 7b18          	ld	a,(OFST+10,sp)
 644  016e a408          	and	a,#8
 645  0170 ca5246        	or	a,21062
 646  0173 c75246        	ld	21062,a
 647  0176               L512:
 648                     ; 168 }
 651  0176 5b0e          	addw	sp,#14
 652  0178 81            	ret
 707                     ; 176 void UART2_Cmd(FunctionalState NewState)
 707                     ; 177 {
 708                     	switch	.text
 709  0179               _UART2_Cmd:
 713                     ; 179     if (NewState != DISABLE)
 715  0179 4d            	tnz	a
 716  017a 2706          	jreq	L542
 717                     ; 182         UART2->CR1 &= (uint8_t)(~UART2_CR1_UARTD);
 719  017c 721b5244      	bres	21060,#5
 721  0180 2004          	jra	L742
 722  0182               L542:
 723                     ; 187         UART2->CR1 |= UART2_CR1_UARTD; 
 725  0182 721a5244      	bset	21060,#5
 726  0186               L742:
 727                     ; 189 }
 730  0186 81            	ret
 862                     ; 206 void UART2_ITConfig(UART2_IT_TypeDef UART2_IT, FunctionalState NewState)
 862                     ; 207 {
 863                     	switch	.text
 864  0187               _UART2_ITConfig:
 866  0187 89            	pushw	x
 867  0188 89            	pushw	x
 868       00000002      OFST:	set	2
 871                     ; 208     uint8_t uartreg = 0, itpos = 0x00;
 873  0189 7b01          	ld	a,(OFST-1,sp)
 874  018b 97            	ld	xl,a
 877  018c 7b02          	ld	a,(OFST+0,sp)
 878  018e 97            	ld	xl,a
 879                     ; 211     assert_param(IS_UART2_CONFIG_IT_OK(UART2_IT));
 881                     ; 212     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 883                     ; 215     uartreg = (uint8_t)((uint16_t)UART2_IT >> 0x08);
 885  018f 7b03          	ld	a,(OFST+1,sp)
 886  0191 6b01          	ld	(OFST-1,sp),a
 887                     ; 218     itpos = (uint8_t)((uint8_t)1 << (uint8_t)((uint8_t)UART2_IT & (uint8_t)0x0F));
 889  0193 7b04          	ld	a,(OFST+2,sp)
 890  0195 a40f          	and	a,#15
 891  0197 5f            	clrw	x
 892  0198 97            	ld	xl,a
 893  0199 a601          	ld	a,#1
 894  019b 5d            	tnzw	x
 895  019c 2704          	jreq	L61
 896  019e               L02:
 897  019e 48            	sll	a
 898  019f 5a            	decw	x
 899  01a0 26fc          	jrne	L02
 900  01a2               L61:
 901  01a2 6b02          	ld	(OFST+0,sp),a
 902                     ; 220     if (NewState != DISABLE)
 904  01a4 0d07          	tnz	(OFST+5,sp)
 905  01a6 273a          	jreq	L133
 906                     ; 223         if (uartreg == 0x01)
 908  01a8 7b01          	ld	a,(OFST-1,sp)
 909  01aa a101          	cp	a,#1
 910  01ac 260a          	jrne	L333
 911                     ; 225             UART2->CR1 |= itpos;
 913  01ae c65244        	ld	a,21060
 914  01b1 1a02          	or	a,(OFST+0,sp)
 915  01b3 c75244        	ld	21060,a
 917  01b6 2066          	jra	L743
 918  01b8               L333:
 919                     ; 227         else if (uartreg == 0x02)
 921  01b8 7b01          	ld	a,(OFST-1,sp)
 922  01ba a102          	cp	a,#2
 923  01bc 260a          	jrne	L733
 924                     ; 229             UART2->CR2 |= itpos;
 926  01be c65245        	ld	a,21061
 927  01c1 1a02          	or	a,(OFST+0,sp)
 928  01c3 c75245        	ld	21061,a
 930  01c6 2056          	jra	L743
 931  01c8               L733:
 932                     ; 231         else if (uartreg == 0x03)
 934  01c8 7b01          	ld	a,(OFST-1,sp)
 935  01ca a103          	cp	a,#3
 936  01cc 260a          	jrne	L343
 937                     ; 233             UART2->CR4 |= itpos;
 939  01ce c65247        	ld	a,21063
 940  01d1 1a02          	or	a,(OFST+0,sp)
 941  01d3 c75247        	ld	21063,a
 943  01d6 2046          	jra	L743
 944  01d8               L343:
 945                     ; 237             UART2->CR6 |= itpos;
 947  01d8 c65249        	ld	a,21065
 948  01db 1a02          	or	a,(OFST+0,sp)
 949  01dd c75249        	ld	21065,a
 950  01e0 203c          	jra	L743
 951  01e2               L133:
 952                     ; 243         if (uartreg == 0x01)
 954  01e2 7b01          	ld	a,(OFST-1,sp)
 955  01e4 a101          	cp	a,#1
 956  01e6 260b          	jrne	L153
 957                     ; 245             UART2->CR1 &= (uint8_t)(~itpos);
 959  01e8 7b02          	ld	a,(OFST+0,sp)
 960  01ea 43            	cpl	a
 961  01eb c45244        	and	a,21060
 962  01ee c75244        	ld	21060,a
 964  01f1 202b          	jra	L743
 965  01f3               L153:
 966                     ; 247         else if (uartreg == 0x02)
 968  01f3 7b01          	ld	a,(OFST-1,sp)
 969  01f5 a102          	cp	a,#2
 970  01f7 260b          	jrne	L553
 971                     ; 249             UART2->CR2 &= (uint8_t)(~itpos);
 973  01f9 7b02          	ld	a,(OFST+0,sp)
 974  01fb 43            	cpl	a
 975  01fc c45245        	and	a,21061
 976  01ff c75245        	ld	21061,a
 978  0202 201a          	jra	L743
 979  0204               L553:
 980                     ; 251         else if (uartreg == 0x03)
 982  0204 7b01          	ld	a,(OFST-1,sp)
 983  0206 a103          	cp	a,#3
 984  0208 260b          	jrne	L163
 985                     ; 253             UART2->CR4 &= (uint8_t)(~itpos);
 987  020a 7b02          	ld	a,(OFST+0,sp)
 988  020c 43            	cpl	a
 989  020d c45247        	and	a,21063
 990  0210 c75247        	ld	21063,a
 992  0213 2009          	jra	L743
 993  0215               L163:
 994                     ; 257             UART2->CR6 &= (uint8_t)(~itpos);
 996  0215 7b02          	ld	a,(OFST+0,sp)
 997  0217 43            	cpl	a
 998  0218 c45249        	and	a,21065
 999  021b c75249        	ld	21065,a
1000  021e               L743:
1001                     ; 260 }
1004  021e 5b04          	addw	sp,#4
1005  0220 81            	ret
1062                     ; 267 void UART2_IrDAConfig(UART2_IrDAMode_TypeDef UART2_IrDAMode)
1062                     ; 268 {
1063                     	switch	.text
1064  0221               _UART2_IrDAConfig:
1068                     ; 269     assert_param(IS_UART2_IRDAMODE_OK(UART2_IrDAMode));
1070                     ; 271     if (UART2_IrDAMode != UART2_IRDAMODE_NORMAL)
1072  0221 4d            	tnz	a
1073  0222 2706          	jreq	L314
1074                     ; 273         UART2->CR5 |= UART2_CR5_IRLP;
1076  0224 72145248      	bset	21064,#2
1078  0228 2004          	jra	L514
1079  022a               L314:
1080                     ; 277         UART2->CR5 &= ((uint8_t)~UART2_CR5_IRLP);
1082  022a 72155248      	bres	21064,#2
1083  022e               L514:
1084                     ; 279 }
1087  022e 81            	ret
1122                     ; 287 void UART2_IrDACmd(FunctionalState NewState)
1122                     ; 288 {
1123                     	switch	.text
1124  022f               _UART2_IrDACmd:
1128                     ; 290     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1130                     ; 292     if (NewState != DISABLE)
1132  022f 4d            	tnz	a
1133  0230 2706          	jreq	L534
1134                     ; 295         UART2->CR5 |= UART2_CR5_IREN;
1136  0232 72125248      	bset	21064,#1
1138  0236 2004          	jra	L734
1139  0238               L534:
1140                     ; 300         UART2->CR5 &= ((uint8_t)~UART2_CR5_IREN);
1142  0238 72135248      	bres	21064,#1
1143  023c               L734:
1144                     ; 302 }
1147  023c 81            	ret
1206                     ; 311 void UART2_LINBreakDetectionConfig(UART2_LINBreakDetectionLength_TypeDef UART2_LINBreakDetectionLength)
1206                     ; 312 {
1207                     	switch	.text
1208  023d               _UART2_LINBreakDetectionConfig:
1212                     ; 314     assert_param(IS_UART2_LINBREAKDETECTIONLENGTH_OK(UART2_LINBreakDetectionLength));
1214                     ; 316     if (UART2_LINBreakDetectionLength != UART2_LINBREAKDETECTIONLENGTH_10BITS)
1216  023d 4d            	tnz	a
1217  023e 2706          	jreq	L764
1218                     ; 318         UART2->CR4 |= UART2_CR4_LBDL;
1220  0240 721a5247      	bset	21063,#5
1222  0244 2004          	jra	L174
1223  0246               L764:
1224                     ; 322         UART2->CR4 &= ((uint8_t)~UART2_CR4_LBDL);
1226  0246 721b5247      	bres	21063,#5
1227  024a               L174:
1228                     ; 324 }
1231  024a 81            	ret
1352                     ; 336 void UART2_LINConfig(UART2_LinMode_TypeDef UART2_Mode, 
1352                     ; 337                      UART2_LinAutosync_TypeDef UART2_Autosync, 
1352                     ; 338                      UART2_LinDivUp_TypeDef UART2_DivUp)
1352                     ; 339 {
1353                     	switch	.text
1354  024b               _UART2_LINConfig:
1356  024b 89            	pushw	x
1357       00000000      OFST:	set	0
1360                     ; 341     assert_param(IS_UART2_SLAVE_OK(UART2_Mode));
1362                     ; 342     assert_param(IS_UART2_AUTOSYNC_OK(UART2_Autosync));
1364                     ; 343     assert_param(IS_UART2_DIVUP_OK(UART2_DivUp));
1366                     ; 345     if (UART2_Mode != UART2_LIN_MODE_MASTER)
1368  024c 9e            	ld	a,xh
1369  024d 4d            	tnz	a
1370  024e 2706          	jreq	L155
1371                     ; 347         UART2->CR6 |=  UART2_CR6_LSLV;
1373  0250 721a5249      	bset	21065,#5
1375  0254 2004          	jra	L355
1376  0256               L155:
1377                     ; 351         UART2->CR6 &= ((uint8_t)~UART2_CR6_LSLV);
1379  0256 721b5249      	bres	21065,#5
1380  025a               L355:
1381                     ; 354     if (UART2_Autosync != UART2_LIN_AUTOSYNC_DISABLE)
1383  025a 0d02          	tnz	(OFST+2,sp)
1384  025c 2706          	jreq	L555
1385                     ; 356         UART2->CR6 |=  UART2_CR6_LASE ;
1387  025e 72185249      	bset	21065,#4
1389  0262 2004          	jra	L755
1390  0264               L555:
1391                     ; 360         UART2->CR6 &= ((uint8_t)~ UART2_CR6_LASE );
1393  0264 72195249      	bres	21065,#4
1394  0268               L755:
1395                     ; 363     if (UART2_DivUp != UART2_LIN_DIVUP_LBRR1)
1397  0268 0d05          	tnz	(OFST+5,sp)
1398  026a 2706          	jreq	L165
1399                     ; 365         UART2->CR6 |=  UART2_CR6_LDUM;
1401  026c 721e5249      	bset	21065,#7
1403  0270 2004          	jra	L365
1404  0272               L165:
1405                     ; 369         UART2->CR6 &= ((uint8_t)~ UART2_CR6_LDUM);
1407  0272 721f5249      	bres	21065,#7
1408  0276               L365:
1409                     ; 371 }
1412  0276 85            	popw	x
1413  0277 81            	ret
1448                     ; 379 void UART2_LINCmd(FunctionalState NewState)
1448                     ; 380 {
1449                     	switch	.text
1450  0278               _UART2_LINCmd:
1454                     ; 381     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1456                     ; 383     if (NewState != DISABLE)
1458  0278 4d            	tnz	a
1459  0279 2706          	jreq	L306
1460                     ; 386         UART2->CR3 |= UART2_CR3_LINEN;
1462  027b 721c5246      	bset	21062,#6
1464  027f 2004          	jra	L506
1465  0281               L306:
1466                     ; 391         UART2->CR3 &= ((uint8_t)~UART2_CR3_LINEN);
1468  0281 721d5246      	bres	21062,#6
1469  0285               L506:
1470                     ; 393 }
1473  0285 81            	ret
1508                     ; 400 void UART2_SmartCardCmd(FunctionalState NewState)
1508                     ; 401 {
1509                     	switch	.text
1510  0286               _UART2_SmartCardCmd:
1514                     ; 403     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1516                     ; 405     if (NewState != DISABLE)
1518  0286 4d            	tnz	a
1519  0287 2706          	jreq	L526
1520                     ; 408         UART2->CR5 |= UART2_CR5_SCEN;
1522  0289 721a5248      	bset	21064,#5
1524  028d 2004          	jra	L726
1525  028f               L526:
1526                     ; 413         UART2->CR5 &= ((uint8_t)(~UART2_CR5_SCEN));
1528  028f 721b5248      	bres	21064,#5
1529  0293               L726:
1530                     ; 415 }
1533  0293 81            	ret
1569                     ; 423 void UART2_SmartCardNACKCmd(FunctionalState NewState)
1569                     ; 424 {
1570                     	switch	.text
1571  0294               _UART2_SmartCardNACKCmd:
1575                     ; 426     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1577                     ; 428     if (NewState != DISABLE)
1579  0294 4d            	tnz	a
1580  0295 2706          	jreq	L746
1581                     ; 431         UART2->CR5 |= UART2_CR5_NACK;
1583  0297 72185248      	bset	21064,#4
1585  029b 2004          	jra	L156
1586  029d               L746:
1587                     ; 436         UART2->CR5 &= ((uint8_t)~(UART2_CR5_NACK));
1589  029d 72195248      	bres	21064,#4
1590  02a1               L156:
1591                     ; 438 }
1594  02a1 81            	ret
1651                     ; 446 void UART2_WakeUpConfig(UART2_WakeUp_TypeDef UART2_WakeUp)
1651                     ; 447 {
1652                     	switch	.text
1653  02a2               _UART2_WakeUpConfig:
1657                     ; 448     assert_param(IS_UART2_WAKEUP_OK(UART2_WakeUp));
1659                     ; 450     UART2->CR1 &= ((uint8_t)~UART2_CR1_WAKE);
1661  02a2 72175244      	bres	21060,#3
1662                     ; 451     UART2->CR1 |= (uint8_t)UART2_WakeUp;
1664  02a6 ca5244        	or	a,21060
1665  02a9 c75244        	ld	21060,a
1666                     ; 452 }
1669  02ac 81            	ret
1705                     ; 460 void UART2_ReceiverWakeUpCmd(FunctionalState NewState)
1705                     ; 461 {
1706                     	switch	.text
1707  02ad               _UART2_ReceiverWakeUpCmd:
1711                     ; 462     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1713                     ; 464     if (NewState != DISABLE)
1715  02ad 4d            	tnz	a
1716  02ae 2706          	jreq	L717
1717                     ; 467         UART2->CR2 |= UART2_CR2_RWU;
1719  02b0 72125245      	bset	21061,#1
1721  02b4 2004          	jra	L127
1722  02b6               L717:
1723                     ; 472         UART2->CR2 &= ((uint8_t)~UART2_CR2_RWU);
1725  02b6 72135245      	bres	21061,#1
1726  02ba               L127:
1727                     ; 474 }
1730  02ba 81            	ret
1753                     ; 481 uint8_t UART2_ReceiveData8(void)
1753                     ; 482 {
1754                     	switch	.text
1755  02bb               _UART2_ReceiveData8:
1759                     ; 483     return ((uint8_t)UART2->DR);
1761  02bb c65241        	ld	a,21057
1764  02be 81            	ret
1798                     ; 491 uint16_t UART2_ReceiveData9(void)
1798                     ; 492 {
1799                     	switch	.text
1800  02bf               _UART2_ReceiveData9:
1802  02bf 89            	pushw	x
1803       00000002      OFST:	set	2
1806                     ; 493   uint16_t temp = 0;
1808  02c0 5f            	clrw	x
1809  02c1 1f01          	ldw	(OFST-1,sp),x
1810                     ; 495   temp = ((uint16_t)(((uint16_t)((uint16_t)UART2->CR1 & (uint16_t)UART2_CR1_R8)) << 1));
1812  02c3 c65244        	ld	a,21060
1813  02c6 5f            	clrw	x
1814  02c7 a480          	and	a,#128
1815  02c9 5f            	clrw	x
1816  02ca 02            	rlwa	x,a
1817  02cb 58            	sllw	x
1818  02cc 1f01          	ldw	(OFST-1,sp),x
1819                     ; 497   return (uint16_t)((((uint16_t)UART2->DR) | temp) & ((uint16_t)0x01FF));
1821  02ce c65241        	ld	a,21057
1822  02d1 5f            	clrw	x
1823  02d2 97            	ld	xl,a
1824  02d3 01            	rrwa	x,a
1825  02d4 1a02          	or	a,(OFST+0,sp)
1826  02d6 01            	rrwa	x,a
1827  02d7 1a01          	or	a,(OFST-1,sp)
1828  02d9 01            	rrwa	x,a
1829  02da 01            	rrwa	x,a
1830  02db a4ff          	and	a,#255
1831  02dd 01            	rrwa	x,a
1832  02de a401          	and	a,#1
1833  02e0 01            	rrwa	x,a
1836  02e1 5b02          	addw	sp,#2
1837  02e3 81            	ret
1871                     ; 505 void UART2_SendData8(uint8_t Data)
1871                     ; 506 {
1872                     	switch	.text
1873  02e4               _UART2_SendData8:
1877                     ; 508     UART2->DR = Data;
1879  02e4 c75241        	ld	21057,a
1880                     ; 509 }
1883  02e7 81            	ret
1917                     ; 516 void UART2_SendData9(uint16_t Data)
1917                     ; 517 {
1918                     	switch	.text
1919  02e8               _UART2_SendData9:
1921  02e8 89            	pushw	x
1922       00000000      OFST:	set	0
1925                     ; 519     UART2->CR1 &= ((uint8_t)~UART2_CR1_T8);                  
1927  02e9 721d5244      	bres	21060,#6
1928                     ; 522     UART2->CR1 |= (uint8_t)(((uint8_t)(Data >> 2)) & UART2_CR1_T8); 
1930  02ed 54            	srlw	x
1931  02ee 54            	srlw	x
1932  02ef 9f            	ld	a,xl
1933  02f0 a440          	and	a,#64
1934  02f2 ca5244        	or	a,21060
1935  02f5 c75244        	ld	21060,a
1936                     ; 525     UART2->DR   = (uint8_t)(Data);                    
1938  02f8 7b02          	ld	a,(OFST+2,sp)
1939  02fa c75241        	ld	21057,a
1940                     ; 527 }
1943  02fd 85            	popw	x
1944  02fe 81            	ret
1967                     ; 534 void UART2_SendBreak(void)
1967                     ; 535 {
1968                     	switch	.text
1969  02ff               _UART2_SendBreak:
1973                     ; 536     UART2->CR2 |= UART2_CR2_SBK;
1975  02ff 72105245      	bset	21061,#0
1976                     ; 537 }
1979  0303 81            	ret
2013                     ; 544 void UART2_SetAddress(uint8_t UART2_Address)
2013                     ; 545 {
2014                     	switch	.text
2015  0304               _UART2_SetAddress:
2017  0304 88            	push	a
2018       00000000      OFST:	set	0
2021                     ; 547     assert_param(IS_UART2_ADDRESS_OK(UART2_Address));
2023                     ; 550     UART2->CR4 &= ((uint8_t)~UART2_CR4_ADD);
2025  0305 c65247        	ld	a,21063
2026  0308 a4f0          	and	a,#240
2027  030a c75247        	ld	21063,a
2028                     ; 552     UART2->CR4 |= UART2_Address;
2030  030d c65247        	ld	a,21063
2031  0310 1a01          	or	a,(OFST+1,sp)
2032  0312 c75247        	ld	21063,a
2033                     ; 553 }
2036  0315 84            	pop	a
2037  0316 81            	ret
2071                     ; 561 void UART2_SetGuardTime(uint8_t UART2_GuardTime)
2071                     ; 562 {
2072                     	switch	.text
2073  0317               _UART2_SetGuardTime:
2077                     ; 564     UART2->GTR = UART2_GuardTime;
2079  0317 c7524a        	ld	21066,a
2080                     ; 565 }
2083  031a 81            	ret
2117                     ; 589 void UART2_SetPrescaler(uint8_t UART2_Prescaler)
2117                     ; 590 {
2118                     	switch	.text
2119  031b               _UART2_SetPrescaler:
2123                     ; 592     UART2->PSCR = UART2_Prescaler;
2125  031b c7524b        	ld	21067,a
2126                     ; 593 }
2129  031e 81            	ret
2286                     ; 601 FlagStatus UART2_GetFlagStatus(UART2_Flag_TypeDef UART2_FLAG)
2286                     ; 602 {
2287                     	switch	.text
2288  031f               _UART2_GetFlagStatus:
2290  031f 89            	pushw	x
2291  0320 88            	push	a
2292       00000001      OFST:	set	1
2295                     ; 603     FlagStatus status = RESET;
2297  0321 0f01          	clr	(OFST+0,sp)
2298                     ; 606     assert_param(IS_UART2_FLAG_OK(UART2_FLAG));
2300                     ; 609     if (UART2_FLAG == UART2_FLAG_LBDF)
2302  0323 a30210        	cpw	x,#528
2303  0326 2610          	jrne	L5511
2304                     ; 611         if ((UART2->CR4 & (uint8_t)UART2_FLAG) != (uint8_t)0x00)
2306  0328 9f            	ld	a,xl
2307  0329 c45247        	and	a,21063
2308  032c 2706          	jreq	L7511
2309                     ; 614             status = SET;
2311  032e a601          	ld	a,#1
2312  0330 6b01          	ld	(OFST+0,sp),a
2314  0332 2039          	jra	L3611
2315  0334               L7511:
2316                     ; 619             status = RESET;
2318  0334 0f01          	clr	(OFST+0,sp)
2319  0336 2035          	jra	L3611
2320  0338               L5511:
2321                     ; 622     else if (UART2_FLAG == UART2_FLAG_SBK)
2323  0338 1e02          	ldw	x,(OFST+1,sp)
2324  033a a30101        	cpw	x,#257
2325  033d 2611          	jrne	L5611
2326                     ; 624         if ((UART2->CR2 & (uint8_t)UART2_FLAG) != (uint8_t)0x00)
2328  033f c65245        	ld	a,21061
2329  0342 1503          	bcp	a,(OFST+2,sp)
2330  0344 2706          	jreq	L7611
2331                     ; 627             status = SET;
2333  0346 a601          	ld	a,#1
2334  0348 6b01          	ld	(OFST+0,sp),a
2336  034a 2021          	jra	L3611
2337  034c               L7611:
2338                     ; 632             status = RESET;
2340  034c 0f01          	clr	(OFST+0,sp)
2341  034e 201d          	jra	L3611
2342  0350               L5611:
2343                     ; 635     else if ((UART2_FLAG == UART2_FLAG_LHDF) || (UART2_FLAG == UART2_FLAG_LSF))
2345  0350 1e02          	ldw	x,(OFST+1,sp)
2346  0352 a30302        	cpw	x,#770
2347  0355 2707          	jreq	L7711
2349  0357 1e02          	ldw	x,(OFST+1,sp)
2350  0359 a30301        	cpw	x,#769
2351  035c 2614          	jrne	L5711
2352  035e               L7711:
2353                     ; 637         if ((UART2->CR6 & (uint8_t)UART2_FLAG) != (uint8_t)0x00)
2355  035e c65249        	ld	a,21065
2356  0361 1503          	bcp	a,(OFST+2,sp)
2357  0363 2706          	jreq	L1021
2358                     ; 640             status = SET;
2360  0365 a601          	ld	a,#1
2361  0367 6b01          	ld	(OFST+0,sp),a
2363  0369 2002          	jra	L3611
2364  036b               L1021:
2365                     ; 645             status = RESET;
2367  036b 0f01          	clr	(OFST+0,sp)
2368  036d               L3611:
2369                     ; 663     return  status;
2371  036d 7b01          	ld	a,(OFST+0,sp)
2374  036f 5b03          	addw	sp,#3
2375  0371 81            	ret
2376  0372               L5711:
2377                     ; 650         if ((UART2->SR & (uint8_t)UART2_FLAG) != (uint8_t)0x00)
2379  0372 c65240        	ld	a,21056
2380  0375 1503          	bcp	a,(OFST+2,sp)
2381  0377 2706          	jreq	L7021
2382                     ; 653             status = SET;
2384  0379 a601          	ld	a,#1
2385  037b 6b01          	ld	(OFST+0,sp),a
2387  037d 20ee          	jra	L3611
2388  037f               L7021:
2389                     ; 658             status = RESET;
2391  037f 0f01          	clr	(OFST+0,sp)
2392  0381 20ea          	jra	L3611
2427                     ; 693 void UART2_ClearFlag(UART2_Flag_TypeDef UART2_FLAG)
2427                     ; 694 {
2428                     	switch	.text
2429  0383               _UART2_ClearFlag:
2431  0383 89            	pushw	x
2432       00000000      OFST:	set	0
2435                     ; 695     assert_param(IS_UART2_CLEAR_FLAG_OK(UART2_FLAG));
2437                     ; 698     if (UART2_FLAG == UART2_FLAG_RXNE)
2439  0384 a30020        	cpw	x,#32
2440  0387 2606          	jrne	L1321
2441                     ; 700         UART2->SR = (uint8_t)~(UART2_SR_RXNE);
2443  0389 35df5240      	mov	21056,#223
2445  038d 201e          	jra	L3321
2446  038f               L1321:
2447                     ; 703     else if (UART2_FLAG == UART2_FLAG_LBDF)
2449  038f 1e01          	ldw	x,(OFST+1,sp)
2450  0391 a30210        	cpw	x,#528
2451  0394 2606          	jrne	L5321
2452                     ; 705         UART2->CR4 &= (uint8_t)(~UART2_CR4_LBDF);
2454  0396 72195247      	bres	21063,#4
2456  039a 2011          	jra	L3321
2457  039c               L5321:
2458                     ; 708     else if (UART2_FLAG == UART2_FLAG_LHDF)
2460  039c 1e01          	ldw	x,(OFST+1,sp)
2461  039e a30302        	cpw	x,#770
2462  03a1 2606          	jrne	L1421
2463                     ; 710         UART2->CR6 &= (uint8_t)(~UART2_CR6_LHDF);
2465  03a3 72135249      	bres	21065,#1
2467  03a7 2004          	jra	L3321
2468  03a9               L1421:
2469                     ; 715         UART2->CR6 &= (uint8_t)(~UART2_CR6_LSF);
2471  03a9 72115249      	bres	21065,#0
2472  03ad               L3321:
2473                     ; 717 }
2476  03ad 85            	popw	x
2477  03ae 81            	ret
2559                     ; 732 ITStatus UART2_GetITStatus(UART2_IT_TypeDef UART2_IT)
2559                     ; 733 {
2560                     	switch	.text
2561  03af               _UART2_GetITStatus:
2563  03af 89            	pushw	x
2564  03b0 89            	pushw	x
2565       00000002      OFST:	set	2
2568                     ; 734     ITStatus pendingbitstatus = RESET;
2570  03b1 7b02          	ld	a,(OFST+0,sp)
2571  03b3 97            	ld	xl,a
2572                     ; 735     uint8_t itpos = 0;
2574  03b4 7b01          	ld	a,(OFST-1,sp)
2575  03b6 97            	ld	xl,a
2576                     ; 736     uint8_t itmask1 = 0;
2578  03b7 7b02          	ld	a,(OFST+0,sp)
2579  03b9 97            	ld	xl,a
2580                     ; 737     uint8_t itmask2 = 0;
2582  03ba 7b02          	ld	a,(OFST+0,sp)
2583  03bc 97            	ld	xl,a
2584                     ; 738     uint8_t enablestatus = 0;
2586  03bd 7b02          	ld	a,(OFST+0,sp)
2587  03bf 97            	ld	xl,a
2588                     ; 741     assert_param(IS_UART2_GET_IT_OK(UART2_IT));
2590                     ; 744     itpos = (uint8_t)((uint8_t)1 << (uint8_t)((uint8_t)UART2_IT & (uint8_t)0x0F));
2592  03c0 7b04          	ld	a,(OFST+2,sp)
2593  03c2 a40f          	and	a,#15
2594  03c4 5f            	clrw	x
2595  03c5 97            	ld	xl,a
2596  03c6 a601          	ld	a,#1
2597  03c8 5d            	tnzw	x
2598  03c9 2704          	jreq	L27
2599  03cb               L47:
2600  03cb 48            	sll	a
2601  03cc 5a            	decw	x
2602  03cd 26fc          	jrne	L47
2603  03cf               L27:
2604  03cf 6b01          	ld	(OFST-1,sp),a
2605                     ; 746     itmask1 = (uint8_t)((uint8_t)UART2_IT >> (uint8_t)4);
2607  03d1 7b04          	ld	a,(OFST+2,sp)
2608  03d3 4e            	swap	a
2609  03d4 a40f          	and	a,#15
2610  03d6 6b02          	ld	(OFST+0,sp),a
2611                     ; 748     itmask2 = (uint8_t)((uint8_t)1 << itmask1);
2613  03d8 7b02          	ld	a,(OFST+0,sp)
2614  03da 5f            	clrw	x
2615  03db 97            	ld	xl,a
2616  03dc a601          	ld	a,#1
2617  03de 5d            	tnzw	x
2618  03df 2704          	jreq	L67
2619  03e1               L001:
2620  03e1 48            	sll	a
2621  03e2 5a            	decw	x
2622  03e3 26fc          	jrne	L001
2623  03e5               L67:
2624  03e5 6b02          	ld	(OFST+0,sp),a
2625                     ; 751     if (UART2_IT == UART2_IT_PE)
2627  03e7 1e03          	ldw	x,(OFST+1,sp)
2628  03e9 a30100        	cpw	x,#256
2629  03ec 261c          	jrne	L7031
2630                     ; 754         enablestatus = (uint8_t)((uint8_t)UART2->CR1 & itmask2);
2632  03ee c65244        	ld	a,21060
2633  03f1 1402          	and	a,(OFST+0,sp)
2634  03f3 6b02          	ld	(OFST+0,sp),a
2635                     ; 757         if (((UART2->SR & itpos) != (uint8_t)0x00) && enablestatus)
2637  03f5 c65240        	ld	a,21056
2638  03f8 1501          	bcp	a,(OFST-1,sp)
2639  03fa 270a          	jreq	L1131
2641  03fc 0d02          	tnz	(OFST+0,sp)
2642  03fe 2706          	jreq	L1131
2643                     ; 760             pendingbitstatus = SET;
2645  0400 a601          	ld	a,#1
2646  0402 6b02          	ld	(OFST+0,sp),a
2648  0404 2064          	jra	L5131
2649  0406               L1131:
2650                     ; 765             pendingbitstatus = RESET;
2652  0406 0f02          	clr	(OFST+0,sp)
2653  0408 2060          	jra	L5131
2654  040a               L7031:
2655                     ; 768     else if (UART2_IT == UART2_IT_LBDF)
2657  040a 1e03          	ldw	x,(OFST+1,sp)
2658  040c a30346        	cpw	x,#838
2659  040f 261c          	jrne	L7131
2660                     ; 771         enablestatus = (uint8_t)((uint8_t)UART2->CR4 & itmask2);
2662  0411 c65247        	ld	a,21063
2663  0414 1402          	and	a,(OFST+0,sp)
2664  0416 6b02          	ld	(OFST+0,sp),a
2665                     ; 773         if (((UART2->CR4 & itpos) != (uint8_t)0x00) && enablestatus)
2667  0418 c65247        	ld	a,21063
2668  041b 1501          	bcp	a,(OFST-1,sp)
2669  041d 270a          	jreq	L1231
2671  041f 0d02          	tnz	(OFST+0,sp)
2672  0421 2706          	jreq	L1231
2673                     ; 776             pendingbitstatus = SET;
2675  0423 a601          	ld	a,#1
2676  0425 6b02          	ld	(OFST+0,sp),a
2678  0427 2041          	jra	L5131
2679  0429               L1231:
2680                     ; 781             pendingbitstatus = RESET;
2682  0429 0f02          	clr	(OFST+0,sp)
2683  042b 203d          	jra	L5131
2684  042d               L7131:
2685                     ; 784     else if (UART2_IT == UART2_IT_LHDF)
2687  042d 1e03          	ldw	x,(OFST+1,sp)
2688  042f a30412        	cpw	x,#1042
2689  0432 261c          	jrne	L7231
2690                     ; 787         enablestatus = (uint8_t)((uint8_t)UART2->CR6 & itmask2);
2692  0434 c65249        	ld	a,21065
2693  0437 1402          	and	a,(OFST+0,sp)
2694  0439 6b02          	ld	(OFST+0,sp),a
2695                     ; 789         if (((UART2->CR6 & itpos) != (uint8_t)0x00) && enablestatus)
2697  043b c65249        	ld	a,21065
2698  043e 1501          	bcp	a,(OFST-1,sp)
2699  0440 270a          	jreq	L1331
2701  0442 0d02          	tnz	(OFST+0,sp)
2702  0444 2706          	jreq	L1331
2703                     ; 792             pendingbitstatus = SET;
2705  0446 a601          	ld	a,#1
2706  0448 6b02          	ld	(OFST+0,sp),a
2708  044a 201e          	jra	L5131
2709  044c               L1331:
2710                     ; 797             pendingbitstatus = RESET;
2712  044c 0f02          	clr	(OFST+0,sp)
2713  044e 201a          	jra	L5131
2714  0450               L7231:
2715                     ; 803         enablestatus = (uint8_t)((uint8_t)UART2->CR2 & itmask2);
2717  0450 c65245        	ld	a,21061
2718  0453 1402          	and	a,(OFST+0,sp)
2719  0455 6b02          	ld	(OFST+0,sp),a
2720                     ; 805         if (((UART2->SR & itpos) != (uint8_t)0x00) && enablestatus)
2722  0457 c65240        	ld	a,21056
2723  045a 1501          	bcp	a,(OFST-1,sp)
2724  045c 270a          	jreq	L7331
2726  045e 0d02          	tnz	(OFST+0,sp)
2727  0460 2706          	jreq	L7331
2728                     ; 808             pendingbitstatus = SET;
2730  0462 a601          	ld	a,#1
2731  0464 6b02          	ld	(OFST+0,sp),a
2733  0466 2002          	jra	L5131
2734  0468               L7331:
2735                     ; 813             pendingbitstatus = RESET;
2737  0468 0f02          	clr	(OFST+0,sp)
2738  046a               L5131:
2739                     ; 817     return  pendingbitstatus;
2741  046a 7b02          	ld	a,(OFST+0,sp)
2744  046c 5b04          	addw	sp,#4
2745  046e 81            	ret
2781                     ; 846 void UART2_ClearITPendingBit(UART2_IT_TypeDef UART2_IT)
2781                     ; 847 {
2782                     	switch	.text
2783  046f               _UART2_ClearITPendingBit:
2785  046f 89            	pushw	x
2786       00000000      OFST:	set	0
2789                     ; 848     assert_param(IS_UART2_CLEAR_IT_OK(UART2_IT));
2791                     ; 851     if (UART2_IT == UART2_IT_RXNE)
2793  0470 a30255        	cpw	x,#597
2794  0473 2606          	jrne	L1631
2795                     ; 853         UART2->SR = (uint8_t)~(UART2_SR_RXNE);
2797  0475 35df5240      	mov	21056,#223
2799  0479 2011          	jra	L3631
2800  047b               L1631:
2801                     ; 856     else if (UART2_IT == UART2_IT_LBDF)
2803  047b 1e01          	ldw	x,(OFST+1,sp)
2804  047d a30346        	cpw	x,#838
2805  0480 2606          	jrne	L5631
2806                     ; 858         UART2->CR4 &= (uint8_t)~(UART2_CR4_LBDF);
2808  0482 72195247      	bres	21063,#4
2810  0486 2004          	jra	L3631
2811  0488               L5631:
2812                     ; 863         UART2->CR6 &= (uint8_t)(~UART2_CR6_LHDF);
2814  0488 72135249      	bres	21065,#1
2815  048c               L3631:
2816                     ; 865 }
2819  048c 85            	popw	x
2820  048d 81            	ret
2833                     	xdef	_UART2_ClearITPendingBit
2834                     	xdef	_UART2_GetITStatus
2835                     	xdef	_UART2_ClearFlag
2836                     	xdef	_UART2_GetFlagStatus
2837                     	xdef	_UART2_SetPrescaler
2838                     	xdef	_UART2_SetGuardTime
2839                     	xdef	_UART2_SetAddress
2840                     	xdef	_UART2_SendBreak
2841                     	xdef	_UART2_SendData9
2842                     	xdef	_UART2_SendData8
2843                     	xdef	_UART2_ReceiveData9
2844                     	xdef	_UART2_ReceiveData8
2845                     	xdef	_UART2_ReceiverWakeUpCmd
2846                     	xdef	_UART2_WakeUpConfig
2847                     	xdef	_UART2_SmartCardNACKCmd
2848                     	xdef	_UART2_SmartCardCmd
2849                     	xdef	_UART2_LINCmd
2850                     	xdef	_UART2_LINConfig
2851                     	xdef	_UART2_LINBreakDetectionConfig
2852                     	xdef	_UART2_IrDACmd
2853                     	xdef	_UART2_IrDAConfig
2854                     	xdef	_UART2_ITConfig
2855                     	xdef	_UART2_Cmd
2856                     	xdef	_UART2_Init
2857                     	xdef	_UART2_DeInit
2858                     	xref	_CLK_GetClockFreq
2859                     	xref.b	c_lreg
2860                     	xref.b	c_x
2879                     	xref	c_lursh
2880                     	xref	c_lsub
2881                     	xref	c_smul
2882                     	xref	c_ludv
2883                     	xref	c_rtol
2884                     	xref	c_llsh
2885                     	xref	c_ltor
2886                     	end
