   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.8 - 03 Dec 2008
  32                     ; 43 void TIM4_DeInit(void)
  32                     ; 44 {
  34                     	switch	.text
  35  0000               _TIM4_DeInit:
  39                     ; 45     TIM4->CR1 = TIM4_CR1_RESET_VALUE;
  41  0000 725f5340      	clr	21312
  42                     ; 46     TIM4->IER = TIM4_IER_RESET_VALUE;
  44  0004 725f5341      	clr	21313
  45                     ; 47     TIM4->CNTR = TIM4_CNTR_RESET_VALUE;
  47  0008 725f5344      	clr	21316
  48                     ; 48     TIM4->PSCR = TIM4_PSCR_RESET_VALUE;
  50  000c 725f5345      	clr	21317
  51                     ; 49     TIM4->ARR = TIM4_ARR_RESET_VALUE;
  53  0010 35ff5346      	mov	21318,#255
  54                     ; 50     TIM4->SR1 = TIM4_SR1_RESET_VALUE;
  56  0014 725f5342      	clr	21314
  57                     ; 51 }
  60  0018 81            	ret
 166                     ; 59 void TIM4_TimeBaseInit(TIM4_Prescaler_TypeDef TIM4_Prescaler, uint8_t TIM4_Period)
 166                     ; 60 {
 167                     	switch	.text
 168  0019               _TIM4_TimeBaseInit:
 172                     ; 66     TIM4->PSCR = (uint8_t)(TIM4_Prescaler);
 174  0019 9e            	ld	a,xh
 175  001a c75345        	ld	21317,a
 176                     ; 68     TIM4->ARR = (uint8_t)(TIM4_Period);
 178  001d 9f            	ld	a,xl
 179  001e c75346        	ld	21318,a
 180                     ; 69 }
 183  0021 81            	ret
 238                     ; 79 void TIM4_Cmd(FunctionalState NewState)
 238                     ; 80 {
 239                     	switch	.text
 240  0022               _TIM4_Cmd:
 244                     ; 86     if (NewState != DISABLE)
 246  0022 4d            	tnz	a
 247  0023 2706          	jreq	L511
 248                     ; 88         TIM4->CR1 |= TIM4_CR1_CEN;
 250  0025 72105340      	bset	21312,#0
 252  0029 2004          	jra	L711
 253  002b               L511:
 254                     ; 92         TIM4->CR1 &= (uint8_t)(~TIM4_CR1_CEN);
 256  002b 72115340      	bres	21312,#0
 257  002f               L711:
 258                     ; 94 }
 261  002f 81            	ret
 319                     ; 106 void TIM4_ITConfig(TIM4_IT_TypeDef TIM4_IT, FunctionalState NewState)
 319                     ; 107 {
 320                     	switch	.text
 321  0030               _TIM4_ITConfig:
 323  0030 89            	pushw	x
 324       00000000      OFST:	set	0
 327                     ; 113     if (NewState != DISABLE)
 329  0031 9f            	ld	a,xl
 330  0032 4d            	tnz	a
 331  0033 2709          	jreq	L151
 332                     ; 116         TIM4->IER |= (uint8_t)TIM4_IT;
 334  0035 9e            	ld	a,xh
 335  0036 ca5341        	or	a,21313
 336  0039 c75341        	ld	21313,a
 338  003c 2009          	jra	L351
 339  003e               L151:
 340                     ; 121         TIM4->IER &= (uint8_t)(~TIM4_IT);
 342  003e 7b01          	ld	a,(OFST+1,sp)
 343  0040 43            	cpl	a
 344  0041 c45341        	and	a,21313
 345  0044 c75341        	ld	21313,a
 346  0047               L351:
 347                     ; 123 }
 350  0047 85            	popw	x
 351  0048 81            	ret
 387                     ; 131 void TIM4_UpdateDisableConfig(FunctionalState NewState)
 387                     ; 132 {
 388                     	switch	.text
 389  0049               _TIM4_UpdateDisableConfig:
 393                     ; 138     if (NewState != DISABLE)
 395  0049 4d            	tnz	a
 396  004a 2706          	jreq	L371
 397                     ; 140         TIM4->CR1 |= TIM4_CR1_UDIS;
 399  004c 72125340      	bset	21312,#1
 401  0050 2004          	jra	L571
 402  0052               L371:
 403                     ; 144         TIM4->CR1 &= (uint8_t)(~TIM4_CR1_UDIS);
 405  0052 72135340      	bres	21312,#1
 406  0056               L571:
 407                     ; 146 }
 410  0056 81            	ret
 468                     ; 156 void TIM4_UpdateRequestConfig(TIM4_UpdateSource_TypeDef TIM4_UpdateSource)
 468                     ; 157 {
 469                     	switch	.text
 470  0057               _TIM4_UpdateRequestConfig:
 474                     ; 163     if (TIM4_UpdateSource != TIM4_UPDATESOURCE_GLOBAL)
 476  0057 4d            	tnz	a
 477  0058 2706          	jreq	L522
 478                     ; 165         TIM4->CR1 |= TIM4_CR1_URS;
 480  005a 72145340      	bset	21312,#2
 482  005e 2004          	jra	L722
 483  0060               L522:
 484                     ; 169         TIM4->CR1 &= (uint8_t)(~TIM4_CR1_URS);
 486  0060 72155340      	bres	21312,#2
 487  0064               L722:
 488                     ; 171 }
 491  0064 81            	ret
 559                     ; 220 void TIM4_PrescalerConfig(TIM4_Prescaler_TypeDef Prescaler, TIM4_PSCReloadMode_TypeDef TIM4_PSCReloadMode)
 559                     ; 221 {
 560                     	switch	.text
 561  0065               _TIM4_PrescalerConfig:
 565                     ; 228     TIM4->PSCR = (uint8_t)Prescaler;
 567  0065 9e            	ld	a,xh
 568  0066 c75345        	ld	21317,a
 569                     ; 231     TIM4->EGR = (uint8_t)TIM4_PSCReloadMode;
 571  0069 9f            	ld	a,xl
 572  006a c75343        	ld	21315,a
 573                     ; 232 }
 576  006d 81            	ret
 612                     ; 240 void TIM4_ARRPreloadConfig(FunctionalState NewState)
 612                     ; 241 {
 613                     	switch	.text
 614  006e               _TIM4_ARRPreloadConfig:
 618                     ; 247     if (NewState != DISABLE)
 620  006e 4d            	tnz	a
 621  006f 2706          	jreq	L103
 622                     ; 249         TIM4->CR1 |= TIM4_CR1_ARPE;
 624  0071 721e5340      	bset	21312,#7
 626  0075 2004          	jra	L303
 627  0077               L103:
 628                     ; 253         TIM4->CR1 &= (uint8_t)(~TIM4_CR1_ARPE);
 630  0077 721f5340      	bres	21312,#7
 631  007b               L303:
 632                     ; 255 }
 635  007b 81            	ret
 683                     ; 359 void TIM4_ClearFlag(TIM4_FLAG_TypeDef TIM4_FLAG)
 683                     ; 360 {
 684                     	switch	.text
 685  007c               _TIM4_ClearFlag:
 689                     ; 366     TIM4->SR1 = (uint8_t)(~TIM4_FLAG);
 691  007c 43            	cpl	a
 692  007d c75342        	ld	21314,a
 693                     ; 368 }
 696  0080 81            	ret
 732                     ; 408 void TIM4_ClearITPendingBit(TIM4_IT_TypeDef TIM4_IT)
 732                     ; 409 {
 733                     	switch	.text
 734  0081               _TIM4_ClearITPendingBit:
 738                     ; 415     TIM4->SR1 = (uint8_t)(~TIM4_IT);
 740  0081 43            	cpl	a
 741  0082 c75342        	ld	21314,a
 742                     ; 416 }
 745  0085 81            	ret
 758                     	xdef	_TIM4_ClearITPendingBit
 759                     	xdef	_TIM4_ClearFlag
 760                     	xdef	_TIM4_ARRPreloadConfig
 761                     	xdef	_TIM4_PrescalerConfig
 762                     	xdef	_TIM4_UpdateRequestConfig
 763                     	xdef	_TIM4_UpdateDisableConfig
 764                     	xdef	_TIM4_ITConfig
 765                     	xdef	_TIM4_Cmd
 766                     	xdef	_TIM4_TimeBaseInit
 767                     	xdef	_TIM4_DeInit
 786                     	end
