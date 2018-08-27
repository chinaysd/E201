   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.8 - 03 Dec 2008
  33                     ; 49 INTERRUPT_HANDLER(NonHandledInterrupt, 25)
  33                     ; 50 {
  34                     	switch	.text
  35  0000               f_NonHandledInterrupt:
  39                     ; 54 }
  42  0000 80            	iret
  64                     ; 62 INTERRUPT_HANDLER_TRAP(TRAP_IRQHandler)
  64                     ; 63 {
  65                     	switch	.text
  66  0001               f_TRAP_IRQHandler:
  70                     ; 67 }
  73  0001 80            	iret
  95                     ; 73 INTERRUPT_HANDLER(TLI_IRQHandler, 0)
  95                     ; 74 
  95                     ; 75 {
  96                     	switch	.text
  97  0002               f_TLI_IRQHandler:
 101                     ; 79 }
 104  0002 80            	iret
 126                     ; 86 INTERRUPT_HANDLER(AWU_IRQHandler, 1)
 126                     ; 87 {
 127                     	switch	.text
 128  0003               f_AWU_IRQHandler:
 132                     ; 91 }
 135  0003 80            	iret
 157                     ; 98 INTERRUPT_HANDLER(CLK_IRQHandler, 2)
 157                     ; 99 {
 158                     	switch	.text
 159  0004               f_CLK_IRQHandler:
 163                     ; 103 }
 166  0004 80            	iret
 189                     ; 110 INTERRUPT_HANDLER(EXTI_PORTA_IRQHandler, 3)
 189                     ; 111 {
 190                     	switch	.text
 191  0005               f_EXTI_PORTA_IRQHandler:
 195                     ; 115 }
 198  0005 80            	iret
 221                     ; 122 INTERRUPT_HANDLER(EXTI_PORTB_IRQHandler, 4)
 221                     ; 123 {
 222                     	switch	.text
 223  0006               f_EXTI_PORTB_IRQHandler:
 227                     ; 128 }
 230  0006 80            	iret
 253                     ; 135 INTERRUPT_HANDLER(EXTI_PORTC_IRQHandler, 5)
 253                     ; 136 {
 254                     	switch	.text
 255  0007               f_EXTI_PORTC_IRQHandler:
 259                     ; 141 }
 262  0007 80            	iret
 285                     ; 148 INTERRUPT_HANDLER(EXTI_PORTD_IRQHandler, 6)
 285                     ; 149 {
 286                     	switch	.text
 287  0008               f_EXTI_PORTD_IRQHandler:
 291                     ; 154 }
 294  0008 80            	iret
 317                     ; 161 INTERRUPT_HANDLER(EXTI_PORTE_IRQHandler, 7)
 317                     ; 162 {
 318                     	switch	.text
 319  0009               f_EXTI_PORTE_IRQHandler:
 323                     ; 174 }
 326  0009 80            	iret
 348                     ; 221 INTERRUPT_HANDLER(SPI_IRQHandler, 10)
 348                     ; 222 {
 349                     	switch	.text
 350  000a               f_SPI_IRQHandler:
 354                     ; 226 }
 357  000a 80            	iret
 380                     ; 233 INTERRUPT_HANDLER(TIM1_UPD_OVF_TRG_BRK_IRQHandler, 11)
 380                     ; 234 {
 381                     	switch	.text
 382  000b               f_TIM1_UPD_OVF_TRG_BRK_IRQHandler:
 386                     ; 241 }
 389  000b 80            	iret
 412                     ; 248 INTERRUPT_HANDLER(TIM1_CAP_COM_IRQHandler, 12)
 412                     ; 249 {
 413                     	switch	.text
 414  000c               f_TIM1_CAP_COM_IRQHandler:
 418                     ; 253 }
 421  000c 80            	iret
 444                     ; 287  INTERRUPT_HANDLER(TIM2_UPD_OVF_BRK_IRQHandler, 13)
 444                     ; 288 {
 445                     	switch	.text
 446  000d               f_TIM2_UPD_OVF_BRK_IRQHandler:
 450                     ; 290 }
 453  000d 80            	iret
 476                     ; 297  INTERRUPT_HANDLER(TIM2_CAP_COM_IRQHandler, 14)
 476                     ; 298 {
 477                     	switch	.text
 478  000e               f_TIM2_CAP_COM_IRQHandler:
 482                     ; 302 }
 485  000e 80            	iret
 508                     ; 312  INTERRUPT_HANDLER(TIM3_UPD_OVF_BRK_IRQHandler, 15)
 508                     ; 313  {
 509                     	switch	.text
 510  000f               f_TIM3_UPD_OVF_BRK_IRQHandler:
 514                     ; 317  }
 517  000f 80            	iret
 540                     ; 324  INTERRUPT_HANDLER(TIM3_CAP_COM_IRQHandler, 16)
 540                     ; 325  {
 541                     	switch	.text
 542  0010               f_TIM3_CAP_COM_IRQHandler:
 546                     ; 329  }
 549  0010 80            	iret
 571                     ; 364 INTERRUPT_HANDLER(I2C_IRQHandler, 19)
 571                     ; 365 {
 572                     	switch	.text
 573  0011               f_I2C_IRQHandler:
 577                     ; 369 }
 580  0011 80            	iret
 603                     ; 377  INTERRUPT_HANDLER(UART2_TX_IRQHandler, 20)
 603                     ; 378  {
 604                     	switch	.text
 605  0012               f_UART2_TX_IRQHandler:
 609                     ; 382  }
 612  0012 80            	iret
 636                     ; 389  INTERRUPT_HANDLER(UART2_RX_IRQHandler, 21)
 636                     ; 390  {
 637                     	switch	.text
 638  0013               f_UART2_RX_IRQHandler:
 640  0013 3b0002        	push	c_x+2
 641  0016 be00          	ldw	x,c_x
 642  0018 89            	pushw	x
 643  0019 3b0002        	push	c_y+2
 644  001c be00          	ldw	x,c_y
 645  001e 89            	pushw	x
 648                     ; 394     	Serial_Rev_IQH();
 650  001f cd0000        	call	_Serial_Rev_IQH
 652                     ; 395  }
 655  0022 85            	popw	x
 656  0023 bf00          	ldw	c_y,x
 657  0025 320002        	pop	c_y+2
 658  0028 85            	popw	x
 659  0029 bf00          	ldw	c_x,x
 660  002b 320002        	pop	c_x+2
 661  002e 80            	iret
 683                     ; 444  INTERRUPT_HANDLER(ADC1_IRQHandler, 22)
 683                     ; 445  {
 684                     	switch	.text
 685  002f               f_ADC1_IRQHandler:
 689                     ; 449  }
 692  002f 80            	iret
 718                     ; 470  INTERRUPT_HANDLER(TIM4_UPD_OVF_IRQHandler, 23)
 718                     ; 471  {
 719                     	switch	.text
 720  0030               f_TIM4_UPD_OVF_IRQHandler:
 722  0030 3b0002        	push	c_x+2
 723  0033 be00          	ldw	x,c_x
 724  0035 89            	pushw	x
 725  0036 3b0002        	push	c_y+2
 726  0039 be00          	ldw	x,c_y
 727  003b 89            	pushw	x
 730                     ; 475 	TIM4_ClearFlag(TIM4_FLAG_UPDATE); 
 732  003c a601          	ld	a,#1
 733  003e cd0000        	call	_TIM4_ClearFlag
 735                     ; 476   	TimeOutDet_DecHandle();
 737  0041 cd0000        	call	_TimeOutDet_DecHandle
 739                     ; 477 	MassTimeHandle();
 741  0044 cd0000        	call	_MassTimeHandle
 743                     ; 478  }
 746  0047 85            	popw	x
 747  0048 bf00          	ldw	c_y,x
 748  004a 320002        	pop	c_y+2
 749  004d 85            	popw	x
 750  004e bf00          	ldw	c_x,x
 751  0050 320002        	pop	c_x+2
 752  0053 80            	iret
 775                     ; 486 INTERRUPT_HANDLER(EEPROM_EEC_IRQHandler, 24)
 775                     ; 487 {
 776                     	switch	.text
 777  0054               f_EEPROM_EEC_IRQHandler:
 781                     ; 492 }
 784  0054 80            	iret
 796                     	xref	_MassTimeHandle
 797                     	xref	_Serial_Rev_IQH
 798                     	xref	_TimeOutDet_DecHandle
 799                     	xdef	f_EEPROM_EEC_IRQHandler
 800                     	xdef	f_TIM4_UPD_OVF_IRQHandler
 801                     	xdef	f_ADC1_IRQHandler
 802                     	xdef	f_UART2_TX_IRQHandler
 803                     	xdef	f_UART2_RX_IRQHandler
 804                     	xdef	f_I2C_IRQHandler
 805                     	xdef	f_TIM3_CAP_COM_IRQHandler
 806                     	xdef	f_TIM3_UPD_OVF_BRK_IRQHandler
 807                     	xdef	f_TIM2_CAP_COM_IRQHandler
 808                     	xdef	f_TIM2_UPD_OVF_BRK_IRQHandler
 809                     	xdef	f_TIM1_UPD_OVF_TRG_BRK_IRQHandler
 810                     	xdef	f_TIM1_CAP_COM_IRQHandler
 811                     	xdef	f_SPI_IRQHandler
 812                     	xdef	f_EXTI_PORTE_IRQHandler
 813                     	xdef	f_EXTI_PORTD_IRQHandler
 814                     	xdef	f_EXTI_PORTC_IRQHandler
 815                     	xdef	f_EXTI_PORTB_IRQHandler
 816                     	xdef	f_EXTI_PORTA_IRQHandler
 817                     	xdef	f_CLK_IRQHandler
 818                     	xdef	f_AWU_IRQHandler
 819                     	xdef	f_TLI_IRQHandler
 820                     	xdef	f_TRAP_IRQHandler
 821                     	xdef	f_NonHandledInterrupt
 822                     	xref	_TIM4_ClearFlag
 823                     	xref.b	c_x
 824                     	xref.b	c_y
 843                     	end
