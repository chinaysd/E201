   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.8 - 03 Dec 2008
   4                     	bsct
   5  0000               L3_Key_Msg:
   6  0000 00            	dc.b	0
  43                     ; 33 static void Tim4_Init(void)
  43                     ; 34 {
  45                     	switch	.text
  46  0000               L51_Tim4_Init:
  50                     ; 35 	TIM4_DeInit();
  52  0000 cd0000        	call	_TIM4_DeInit
  54                     ; 36 	TIM4_TimeBaseInit( TIM4_PRESCALER_32,Delay-1);
  56  0003 ae004a        	ldw	x,#74
  57  0006 a605          	ld	a,#5
  58  0008 95            	ld	xh,a
  59  0009 cd0000        	call	_TIM4_TimeBaseInit
  61                     ; 37 	TIM4_PrescalerConfig(TIM4_PRESCALER_32,TIM4_PSCRELOADMODE_IMMEDIATE);
  63  000c ae0001        	ldw	x,#1
  64  000f a605          	ld	a,#5
  65  0011 95            	ld	xh,a
  66  0012 cd0000        	call	_TIM4_PrescalerConfig
  68                     ; 38 	TIM4_ARRPreloadConfig(ENABLE);
  70  0015 a601          	ld	a,#1
  71  0017 cd0000        	call	_TIM4_ARRPreloadConfig
  73                     ; 39 	TIM4_ITConfig( TIM4_IT_UPDATE , ENABLE);
  75  001a ae0001        	ldw	x,#1
  76  001d a601          	ld	a,#1
  77  001f 95            	ld	xh,a
  78  0020 cd0000        	call	_TIM4_ITConfig
  80                     ; 40 	TIM4_UpdateDisableConfig(DISABLE);
  82  0023 4f            	clr	a
  83  0024 cd0000        	call	_TIM4_UpdateDisableConfig
  85                     ; 41 	TIM4_UpdateRequestConfig( TIM4_UPDATESOURCE_GLOBAL);
  87  0027 4f            	clr	a
  88  0028 cd0000        	call	_TIM4_UpdateRequestConfig
  90                     ; 42 	TIM4_Cmd(ENABLE );
  92  002b a601          	ld	a,#1
  93  002d cd0000        	call	_TIM4_Cmd
  95                     ; 43 }
  98  0030 81            	ret
 126                     ; 49 static void Iwdg_Init(void)
 126                     ; 50 {	
 127                     	switch	.text
 128  0031               L53_Iwdg_Init:
 132                     ; 51 	IWDG_Enable();
 134  0031 cd0000        	call	_IWDG_Enable
 136                     ; 52 	IWDG_WriteAccessCmd(IWDG_WriteAccess_Enable);
 138  0034 a655          	ld	a,#85
 139  0036 cd0000        	call	_IWDG_WriteAccessCmd
 141                     ; 53 	IWDG_SetPrescaler(IWDG_Prescaler_256);
 143  0039 a606          	ld	a,#6
 144  003b cd0000        	call	_IWDG_SetPrescaler
 146                     ; 54 	IWDG_SetReload(0XFF);
 148  003e a6ff          	ld	a,#255
 149  0040 cd0000        	call	_IWDG_SetReload
 151                     ; 55 	IWDG_ReloadCounter();
 153  0043 cd0000        	call	_IWDG_ReloadCounter
 155                     ; 56 }
 158  0046 81            	ret
 183                     ; 58 static System_Sundry_Init(void){
 184                     	switch	.text
 185  0047               L74_System_Sundry_Init:
 189                     ; 60 	GPIO_Init(FOOT_LED_PORT, FOOT_LED_PIN, GPIO_MODE_OUT_PP_HIGH_FAST);
 191  0047 4bf0          	push	#240
 192  0049 4b04          	push	#4
 193  004b ae500f        	ldw	x,#20495
 194  004e cd0000        	call	_GPIO_Init
 196  0051 85            	popw	x
 197                     ; 61 	GPIO_WriteLow(FOOT_LED_PORT, FOOT_LED_PIN);
 199  0052 4b04          	push	#4
 200  0054 ae500f        	ldw	x,#20495
 201  0057 cd0000        	call	_GPIO_WriteLow
 203  005a 84            	pop	a
 204                     ; 62 	GPIO_Init(SUB_LED_PORT, SUB_LED_PIN, GPIO_MODE_OUT_PP_HIGH_FAST);
 206  005b 4bf0          	push	#240
 207  005d 4b04          	push	#4
 208  005f ae5000        	ldw	x,#20480
 209  0062 cd0000        	call	_GPIO_Init
 211  0065 85            	popw	x
 212                     ; 63 	GPIO_WriteLow(SUB_LED_PORT, SUB_LED_PIN);
 214  0066 4b04          	push	#4
 215  0068 ae5000        	ldw	x,#20480
 216  006b cd0000        	call	_GPIO_WriteLow
 218  006e 84            	pop	a
 219                     ; 64 	GPIO_Init(sys_FAN_LED_PORT, sys_FAN_LED_PIN, GPIO_MODE_OUT_PP_HIGH_FAST);
 221  006f 4bf0          	push	#240
 222  0071 4b08          	push	#8
 223  0073 ae500f        	ldw	x,#20495
 224  0076 cd0000        	call	_GPIO_Init
 226  0079 85            	popw	x
 227                     ; 65 	GPIO_WriteLow(sys_FAN_LED_PORT, sys_FAN_LED_PIN);
 229  007a 4b08          	push	#8
 230  007c ae500f        	ldw	x,#20495
 231  007f cd0000        	call	_GPIO_WriteLow
 233  0082 84            	pop	a
 234                     ; 66 }
 237  0083 81            	ret
 286                     ; 69 void System_Init(void){
 287                     	switch	.text
 288  0084               _System_Init:
 290  0084 89            	pushw	x
 291       00000002      OFST:	set	2
 294                     ; 70 	int i = 0;
 296  0085 5f            	clrw	x
 297  0086 1f01          	ldw	(OFST-1,sp),x
 298                     ; 71 	System_Sundry_Init();
 300  0088 adbd          	call	L74_System_Sundry_Init
 302                     ; 72 	KEY_Init();
 304  008a cd0000        	call	_KEY_Init
 306                     ; 73 	Mass_Init();
 308  008d 4bf0          	push	#240
 309  008f 4b08          	push	#8
 310  0091 ae5005        	ldw	x,#20485
 311  0094 cd0000        	call	_GPIO_Init
 313  0097 85            	popw	x
 316  0098 4b08          	push	#8
 317  009a ae5005        	ldw	x,#20485
 318  009d cd0000        	call	_GPIO_WriteLow
 320  00a0 84            	pop	a
 323  00a1 4bf0          	push	#240
 324  00a3 4b04          	push	#4
 325  00a5 ae5005        	ldw	x,#20485
 326  00a8 cd0000        	call	_GPIO_Init
 328  00ab 85            	popw	x
 331  00ac 4b04          	push	#4
 332  00ae ae5005        	ldw	x,#20485
 333  00b1 cd0000        	call	_GPIO_WriteLow
 335  00b4 84            	pop	a
 336                     ; 74 	for(i = 0; i < PUSHROD_NUM ;i ++){	
 339  00b5 5f            	clrw	x
 340  00b6 1f01          	ldw	(OFST-1,sp),x
 341  00b8               L77:
 342                     ; 75 		Pushrod[i].ID = i;
 344  00b8 7b02          	ld	a,(OFST+0,sp)
 345  00ba 1e01          	ldw	x,(OFST-1,sp)
 346  00bc 58            	sllw	x
 347  00bd 58            	sllw	x
 348  00be e718          	ld	(L5_Pushrod,x),a
 349                     ; 76 		Pushrod_APP_Init(&Pushrod[i]);
 351  00c0 1e01          	ldw	x,(OFST-1,sp)
 352  00c2 58            	sllw	x
 353  00c3 58            	sllw	x
 354  00c4 01            	rrwa	x,a
 355  00c5 ab18          	add	a,#L5_Pushrod
 356  00c7 2401          	jrnc	L41
 357  00c9 5c            	incw	x
 358  00ca               L41:
 359  00ca 5f            	clrw	x
 360  00cb 97            	ld	xl,a
 361  00cc cd0000        	call	_Pushrod_APP_Init
 363                     ; 74 	for(i = 0; i < PUSHROD_NUM ;i ++){	
 365  00cf 1e01          	ldw	x,(OFST-1,sp)
 366  00d1 1c0001        	addw	x,#1
 367  00d4 1f01          	ldw	(OFST-1,sp),x
 370  00d6 9c            	rvf
 371  00d7 1e01          	ldw	x,(OFST-1,sp)
 372  00d9 a30002        	cpw	x,#2
 373  00dc 2fda          	jrslt	L77
 374                     ; 78 	for(i = 0; i< CH_NUM; i ++){
 376  00de 5f            	clrw	x
 377  00df 1f01          	ldw	(OFST-1,sp),x
 378  00e1               L501:
 379                     ; 79 		CH_Para[i].ID = i;
 381  00e1 7b02          	ld	a,(OFST+0,sp)
 382  00e3 1e01          	ldw	x,(OFST-1,sp)
 383  00e5 90ae0003      	ldw	y,#3
 384  00e9 cd0000        	call	c_imul
 386  00ec e70f          	ld	(L11_CH_Para,x),a
 387                     ; 80 		CH_App_Init(&CH_Para[i]);
 389  00ee 1e01          	ldw	x,(OFST-1,sp)
 390  00f0 90ae0003      	ldw	y,#3
 391  00f4 cd0000        	call	c_imul
 393  00f7 01            	rrwa	x,a
 394  00f8 ab0f          	add	a,#L11_CH_Para
 395  00fa 2401          	jrnc	L61
 396  00fc 5c            	incw	x
 397  00fd               L61:
 398  00fd 5f            	clrw	x
 399  00fe 97            	ld	xl,a
 400  00ff cd0000        	call	_CH_App_Init
 402                     ; 78 	for(i = 0; i< CH_NUM; i ++){
 404  0102 1e01          	ldw	x,(OFST-1,sp)
 405  0104 1c0001        	addw	x,#1
 406  0107 1f01          	ldw	(OFST-1,sp),x
 409  0109 9c            	rvf
 410  010a 1e01          	ldw	x,(OFST-1,sp)
 411  010c a30001        	cpw	x,#1
 412  010f 2fd0          	jrslt	L501
 413                     ; 82 	Tim4_Init();
 415  0111 cd0000        	call	L51_Tim4_Init
 417                     ; 83 	Iwdg_Init();
 419  0114 cd0031        	call	L53_Iwdg_Init
 421                     ; 84 	TimeOutDet_Init();
 423  0117 cd0000        	call	_TimeOutDet_Init
 425                     ; 86 	Commu_Init();
 427  011a cd0000        	call	_Commu_Init
 429                     ; 87 	TimeOut_Record(&Timeout, COMMU_TIMEOUT_VALUE);
 431  011d ae1388        	ldw	x,#5000
 432  0120 89            	pushw	x
 433  0121 ae0000        	ldw	x,#0
 434  0124 89            	pushw	x
 435  0125 ae0007        	ldw	x,#L31_Timeout
 436  0128 cd0000        	call	_TimeOut_Record
 438  012b 5b04          	addw	sp,#4
 439                     ; 88 	enableInterrupts();
 442  012d 9a            rim
 444                     ; 89 }
 448  012e 85            	popw	x
 449  012f 81            	ret
 503                     ; 95 void System_Handle(void){
 504                     	switch	.text
 505  0130               _System_Handle:
 507  0130 89            	pushw	x
 508       00000002      OFST:	set	2
 511                     ; 97 	IWDG_ReloadCounter();
 513  0131 cd0000        	call	_IWDG_ReloadCounter
 515                     ; 102 	Key_Msg = KEY_Scan();
 517  0134 cd0000        	call	_KEY_Scan
 519  0137 b700          	ld	L3_Key_Msg,a
 520                     ; 104 	if(Key_Msg == MSG_KEY2_LONGPRESS || Key_Msg == MSG_KEY3_LONGPRESS){
 522  0139 b600          	ld	a,L3_Key_Msg
 523  013b a107          	cp	a,#7
 524  013d 2706          	jreq	L331
 526  013f b600          	ld	a,L3_Key_Msg
 527  0141 a10b          	cp	a,#11
 528  0143 2604          	jrne	L131
 529  0145               L331:
 530                     ; 105 		Pushrod[PUSHROD_A].ReverseFlag = TRUE;
 532  0145 35010019      	mov	L5_Pushrod+1,#1
 533  0149               L131:
 534                     ; 107 	if(Key_Msg == MSG_KEY2_LONGPRESS_RE || Key_Msg == MSG_KEY3_LONGPRESS_RE){
 536  0149 b600          	ld	a,L3_Key_Msg
 537  014b a108          	cp	a,#8
 538  014d 2706          	jreq	L731
 540  014f b600          	ld	a,L3_Key_Msg
 541  0151 a10c          	cp	a,#12
 542  0153 2602          	jrne	L531
 543  0155               L731:
 544                     ; 108 		Pushrod[PUSHROD_A].ReverseFlag = FALSE;
 546  0155 3f19          	clr	L5_Pushrod+1
 547  0157               L531:
 548                     ; 111 	if(Key_Msg == MSG_KEY1_LONGPRESS || Key_Msg == MSG_KEY3_LONGPRESS){
 550  0157 b600          	ld	a,L3_Key_Msg
 551  0159 a103          	cp	a,#3
 552  015b 2706          	jreq	L341
 554  015d b600          	ld	a,L3_Key_Msg
 555  015f a10b          	cp	a,#11
 556  0161 2604          	jrne	L141
 557  0163               L341:
 558                     ; 112 		Pushrod[PUSHROD_B].ReverseFlag = TRUE;
 560  0163 3501001d      	mov	L5_Pushrod+5,#1
 561  0167               L141:
 562                     ; 114 	if(Key_Msg == MSG_KEY1_LONGPRESS_RE || Key_Msg == MSG_KEY3_LONGPRESS_RE){
 564  0167 b600          	ld	a,L3_Key_Msg
 565  0169 a104          	cp	a,#4
 566  016b 2706          	jreq	L741
 568  016d b600          	ld	a,L3_Key_Msg
 569  016f a10c          	cp	a,#12
 570  0171 2602          	jrne	L541
 571  0173               L741:
 572                     ; 115 		Pushrod[PUSHROD_B].ReverseFlag = FALSE;
 574  0173 3f1d          	clr	L5_Pushrod+5
 575  0175               L541:
 576                     ; 122 	if(Rev_Msg.PushRod_Sta == PUSHROD_STOP || Rev_Msg.PushRod_Sta == PUSHROD_A_STOP ||Rev_Msg.PushRod_Sta == PUSHROD_B_STOP){
 578  0175 3d14          	tnz	L7_Rev_Msg+2
 579  0177 270c          	jreq	L351
 581  0179 b614          	ld	a,L7_Rev_Msg+2
 582  017b a103          	cp	a,#3
 583  017d 2706          	jreq	L351
 585  017f b614          	ld	a,L7_Rev_Msg+2
 586  0181 a106          	cp	a,#6
 587  0183 2623          	jrne	L151
 588  0185               L351:
 589                     ; 123 		Pushrod_APP_Handle(&Pushrod[PUSHROD_A], PUSH_STOP);
 591  0185 4b00          	push	#0
 592  0187 ae0018        	ldw	x,#L5_Pushrod
 593  018a cd0000        	call	_Pushrod_APP_Handle
 595  018d 84            	pop	a
 596                     ; 125 		Pushrod_APP_Handle(&Pushrod[PUSHROD_B], PUSH_STOP);
 598  018e 4b00          	push	#0
 599  0190 ae001c        	ldw	x,#L5_Pushrod+4
 600  0193 cd0000        	call	_Pushrod_APP_Handle
 602  0196 84            	pop	a
 604  0197               L751:
 605                     ; 149 	if(Rev_Msg.Cool_Heat_Sta == CH_A_OFF){
 607  0197 3d13          	tnz	L7_Rev_Msg+1
 608  0199 2665          	jrne	L102
 609                     ; 150 		CH_Handle(&CH_Para[CH_A],CH_STOP_MODE);
 611  019b 4b00          	push	#0
 612  019d ae000f        	ldw	x,#L11_CH_Para
 613  01a0 cd0000        	call	_CH_Handle
 615  01a3 84            	pop	a
 617  01a4 ac530253      	jpf	L302
 618  01a8               L151:
 619                     ; 127 	}else if(Rev_Msg.PushRod_Sta == PUSHROD_A_OPEN){
 621  01a8 b614          	ld	a,L7_Rev_Msg+2
 622  01aa a101          	cp	a,#1
 623  01ac 260b          	jrne	L161
 624                     ; 128 		Pushrod_APP_Handle(&Pushrod[PUSHROD_A], PUSH_OPEN);
 626  01ae 4b01          	push	#1
 627  01b0 ae0018        	ldw	x,#L5_Pushrod
 628  01b3 cd0000        	call	_Pushrod_APP_Handle
 630  01b6 84            	pop	a
 632  01b7 20de          	jra	L751
 633  01b9               L161:
 634                     ; 129 	}else if(Rev_Msg.PushRod_Sta == PUSHROD_A_CLOSE){
 636  01b9 b614          	ld	a,L7_Rev_Msg+2
 637  01bb a102          	cp	a,#2
 638  01bd 260b          	jrne	L561
 639                     ; 130 		Pushrod_APP_Handle(&Pushrod[PUSHROD_A], PUSH_CLOSE);
 641  01bf 4b02          	push	#2
 642  01c1 ae0018        	ldw	x,#L5_Pushrod
 643  01c4 cd0000        	call	_Pushrod_APP_Handle
 645  01c7 84            	pop	a
 647  01c8 20cd          	jra	L751
 648  01ca               L561:
 649                     ; 133 	else if(Rev_Msg.PushRod_Sta == PUSHROD_B_OPEN){
 651  01ca b614          	ld	a,L7_Rev_Msg+2
 652  01cc a104          	cp	a,#4
 653  01ce 260b          	jrne	L171
 654                     ; 134 		Pushrod_APP_Handle(&Pushrod[PUSHROD_B], PUSH_OPEN);
 656  01d0 4b01          	push	#1
 657  01d2 ae001c        	ldw	x,#L5_Pushrod+4
 658  01d5 cd0000        	call	_Pushrod_APP_Handle
 660  01d8 84            	pop	a
 662  01d9 20bc          	jra	L751
 663  01db               L171:
 664                     ; 135 	}else if(Rev_Msg.PushRod_Sta == PUSHROD_B_CLOSE){
 666  01db b614          	ld	a,L7_Rev_Msg+2
 667  01dd a105          	cp	a,#5
 668  01df 260b          	jrne	L571
 669                     ; 136 		Pushrod_APP_Handle(&Pushrod[PUSHROD_B], PUSH_CLOSE);
 671  01e1 4b02          	push	#2
 672  01e3 ae001c        	ldw	x,#L5_Pushrod+4
 673  01e6 cd0000        	call	_Pushrod_APP_Handle
 675  01e9 84            	pop	a
 677  01ea 20ab          	jra	L751
 678  01ec               L571:
 679                     ; 140 		Pushrod_APP_Handle(&Pushrod[PUSHROD_A], PUSH_STOP);
 681  01ec 4b00          	push	#0
 682  01ee ae0018        	ldw	x,#L5_Pushrod
 683  01f1 cd0000        	call	_Pushrod_APP_Handle
 685  01f4 84            	pop	a
 686                     ; 142 		Pushrod_APP_Handle(&Pushrod[PUSHROD_B], PUSH_STOP);
 688  01f5 4b00          	push	#0
 689  01f7 ae001c        	ldw	x,#L5_Pushrod+4
 690  01fa cd0000        	call	_Pushrod_APP_Handle
 692  01fd 84            	pop	a
 693  01fe 2097          	jra	L751
 694  0200               L102:
 695                     ; 151 	}else if(Rev_Msg.Cool_Heat_Sta == CH_A_COOL){
 697  0200 b613          	ld	a,L7_Rev_Msg+1
 698  0202 a101          	cp	a,#1
 699  0204 261f          	jrne	L502
 700                     ; 152 		if(Pushrod_GetStatus(&Pushrod[PUSHROD_A])){
 702  0206 ae0018        	ldw	x,#L5_Pushrod
 703  0209 cd0000        	call	_Pushrod_GetStatus
 705  020c 4d            	tnz	a
 706  020d 270b          	jreq	L702
 707                     ; 153 			CH_Cool_Heat_Moudle_Set(&CH_Para[CH_A],0);
 709  020f 4b00          	push	#0
 710  0211 ae000f        	ldw	x,#L11_CH_Para
 711  0214 cd0000        	call	_CH_Cool_Heat_Moudle_Set
 713  0217 84            	pop	a
 715  0218 2039          	jra	L302
 716  021a               L702:
 717                     ; 155 			CH_Handle(&CH_Para[CH_A],CH_COOL_MODE);
 719  021a 4b01          	push	#1
 720  021c ae000f        	ldw	x,#L11_CH_Para
 721  021f cd0000        	call	_CH_Handle
 723  0222 84            	pop	a
 724  0223 202e          	jra	L302
 725  0225               L502:
 726                     ; 157 	}else if(Rev_Msg.Cool_Heat_Sta == CH_A_HEAT){
 728  0225 b613          	ld	a,L7_Rev_Msg+1
 729  0227 a102          	cp	a,#2
 730  0229 261f          	jrne	L512
 731                     ; 158 		if(Pushrod_GetStatus(&Pushrod[PUSHROD_A])){
 733  022b ae0018        	ldw	x,#L5_Pushrod
 734  022e cd0000        	call	_Pushrod_GetStatus
 736  0231 4d            	tnz	a
 737  0232 270b          	jreq	L712
 738                     ; 159 			CH_Cool_Heat_Moudle_Set(&CH_Para[CH_A],0);
 740  0234 4b00          	push	#0
 741  0236 ae000f        	ldw	x,#L11_CH_Para
 742  0239 cd0000        	call	_CH_Cool_Heat_Moudle_Set
 744  023c 84            	pop	a
 746  023d 2014          	jra	L302
 747  023f               L712:
 748                     ; 161 			CH_Handle(&CH_Para[CH_A],CH_HEAT_MODE);
 750  023f 4b02          	push	#2
 751  0241 ae000f        	ldw	x,#L11_CH_Para
 752  0244 cd0000        	call	_CH_Handle
 754  0247 84            	pop	a
 755  0248 2009          	jra	L302
 756  024a               L512:
 757                     ; 164 		CH_Handle(&CH_Para[CH_A],CH_STOP_MODE);
 759  024a 4b00          	push	#0
 760  024c ae000f        	ldw	x,#L11_CH_Para
 761  024f cd0000        	call	_CH_Handle
 763  0252 84            	pop	a
 764  0253               L302:
 765                     ; 169 	if(Rev_Msg.Foot_Led_Sta == FOOT_LED_OFF){
 767  0253 3d12          	tnz	L7_Rev_Msg
 768  0255 2614          	jrne	L522
 769                     ; 170 		Foot_Led_Set(0);
 771  0257 4b04          	push	#4
 772  0259 ae500f        	ldw	x,#20495
 773  025c cd0000        	call	_GPIO_WriteLow
 775  025f 84            	pop	a
 776                     ; 171 		Sub_Led_Set(0);
 778  0260 4b04          	push	#4
 779  0262 ae5000        	ldw	x,#20480
 780  0265 cd0000        	call	_GPIO_WriteLow
 782  0268 84            	pop	a
 784  0269 2012          	jra	L722
 785  026b               L522:
 786                     ; 173 		Foot_Led_Set(1);
 788  026b 4b04          	push	#4
 789  026d ae500f        	ldw	x,#20495
 790  0270 cd0000        	call	_GPIO_WriteHigh
 792  0273 84            	pop	a
 793                     ; 174 		Sub_Led_Set(1);
 795  0274 4b04          	push	#4
 796  0276 ae5000        	ldw	x,#20480
 797  0279 cd0000        	call	_GPIO_WriteHigh
 799  027c 84            	pop	a
 800  027d               L722:
 801                     ; 179 	if(Rev_Msg.ucWarn_Cloth_Sta == WARM_ON){
 803  027d b616          	ld	a,L7_Rev_Msg+4
 804  027f a101          	cp	a,#1
 805  0281 260b          	jrne	L132
 806                     ; 180 		sys_FAN_LED_SET(1);
 808  0283 4b08          	push	#8
 809  0285 ae500f        	ldw	x,#20495
 810  0288 cd0000        	call	_GPIO_WriteHigh
 812  028b 84            	pop	a
 814  028c 200d          	jra	L332
 815  028e               L132:
 816                     ; 181 	}else if(Rev_Msg.ucWarn_Cloth_Sta == WARM_OFF){
 818  028e 3d16          	tnz	L7_Rev_Msg+4
 819  0290 2609          	jrne	L332
 820                     ; 182 		sys_FAN_LED_SET(0);
 822  0292 4b08          	push	#8
 823  0294 ae500f        	ldw	x,#20495
 824  0297 cd0000        	call	_GPIO_WriteLow
 826  029a 84            	pop	a
 827  029b               L332:
 828                     ; 187 	if(Rev_Msg.ucMass_Sta == MASS_ON){
 830  029b b617          	ld	a,L7_Rev_Msg+5
 831  029d a101          	cp	a,#1
 832  029f 2605          	jrne	L732
 833                     ; 188 		Mass_Handle();
 835  02a1 cd0000        	call	_Mass_Handle
 838  02a4 2007          	jra	L142
 839  02a6               L732:
 840                     ; 189 	}else if(Rev_Msg.ucMass_Sta == MASS_OFF){
 842  02a6 3d17          	tnz	L7_Rev_Msg+5
 843  02a8 2603          	jrne	L142
 844                     ; 190 		Mass_Deinit();
 846  02aa cd0000        	call	_Mass_Deinit
 848  02ad               L142:
 849                     ; 196 	if(Serial_Get_Status()){
 851  02ad cd0000        	call	_Serial_Get_Status
 853  02b0 4d            	tnz	a
 854  02b1 2603          	jrne	L42
 855  02b3 cc0380        	jp	L542
 856  02b6               L42:
 857                     ; 197 		unsigned int Rev_Data = 0;
 859  02b6 5f            	clrw	x
 860  02b7 1f01          	ldw	(OFST-1,sp),x
 861                     ; 198 		TimeOut_Record(&Timeout, COMMU_TIMEOUT_VALUE);
 863  02b9 ae1388        	ldw	x,#5000
 864  02bc 89            	pushw	x
 865  02bd ae0000        	ldw	x,#0
 866  02c0 89            	pushw	x
 867  02c1 ae0007        	ldw	x,#L31_Timeout
 868  02c4 cd0000        	call	_TimeOut_Record
 870  02c7 5b04          	addw	sp,#4
 871                     ; 200 		if(Rev_Para.Data_Format.MessageID != NUM1){
 873  02c9 b601          	ld	a,_Rev_Para+1
 874  02cb a101          	cp	a,#1
 875                     ; 206 		if(Rev_Para.Data_Format.Checksum != (unsigned char)(Rev_Para.Data_Format.MessageID + Rev_Para.Data_Format.Cont2+ 
 875                     ; 207 			Rev_Para.Data_Format.Start + Rev_Para.Data_Format.Cont1)){
 877  02cd b601          	ld	a,_Rev_Para+1
 878  02cf bb03          	add	a,_Rev_Para+3
 879  02d1 bb00          	add	a,_Rev_Para
 880  02d3 bb02          	add	a,_Rev_Para+2
 881  02d5 b104          	cp	a,_Rev_Para+4
 882                     ; 214 		Rev_Data = Get_32bit(Rev_Para.Data_Format.Cont1, Rev_Para.Data_Format.Cont2);
 884  02d7 b602          	ld	a,_Rev_Para+2
 885  02d9 5f            	clrw	x
 886  02da 97            	ld	xl,a
 887  02db 4f            	clr	a
 888  02dc 02            	rlwa	x,a
 889  02dd 01            	rrwa	x,a
 890  02de ba03          	or	a,_Rev_Para+3
 891  02e0 02            	rlwa	x,a
 892  02e1 1f01          	ldw	(OFST-1,sp),x
 893  02e3 01            	rrwa	x,a
 894                     ; 215 		if(Rev_Data & CONT_LED_ON){
 896  02e4 7b02          	ld	a,(OFST+0,sp)
 897  02e6 a501          	bcp	a,#1
 898  02e8 2706          	jreq	L352
 899                     ; 216 			Rev_Msg.Foot_Led_Sta = FOOT_LED_ON;
 901  02ea 35010012      	mov	L7_Rev_Msg,#1
 903  02ee 2008          	jra	L552
 904  02f0               L352:
 905                     ; 217 		}else if(Rev_Data & CONT_LED_OFF){
 907  02f0 7b02          	ld	a,(OFST+0,sp)
 908  02f2 a502          	bcp	a,#2
 909  02f4 2702          	jreq	L552
 910                     ; 218 			Rev_Msg.Foot_Led_Sta = FOOT_LED_OFF;
 912  02f6 3f12          	clr	L7_Rev_Msg
 913  02f8               L552:
 914                     ; 220 		if(Rev_Data & CONT_CH_A_OFF){
 916  02f8 7b02          	ld	a,(OFST+0,sp)
 917  02fa a504          	bcp	a,#4
 918  02fc 2704          	jreq	L162
 919                     ; 221 			Rev_Msg.Cool_Heat_Sta = CH_A_OFF;
 921  02fe 3f13          	clr	L7_Rev_Msg+1
 923  0300 2016          	jra	L362
 924  0302               L162:
 925                     ; 222 		}else if(Rev_Data & CONT_CH_A_COOL){
 927  0302 7b02          	ld	a,(OFST+0,sp)
 928  0304 a508          	bcp	a,#8
 929  0306 2706          	jreq	L562
 930                     ; 223 			Rev_Msg.Cool_Heat_Sta = CH_A_COOL;
 932  0308 35010013      	mov	L7_Rev_Msg+1,#1
 934  030c 200a          	jra	L362
 935  030e               L562:
 936                     ; 224 		}else if(Rev_Data & CONT_CH_A_HEAT){
 938  030e 7b02          	ld	a,(OFST+0,sp)
 939  0310 a510          	bcp	a,#16
 940  0312 2704          	jreq	L362
 941                     ; 225 			Rev_Msg.Cool_Heat_Sta = CH_A_HEAT;
 943  0314 35020013      	mov	L7_Rev_Msg+1,#2
 944  0318               L362:
 945                     ; 227 		if(Rev_Data & CONT_PUSHROD_STOP){
 947  0318 7b02          	ld	a,(OFST+0,sp)
 948  031a a520          	bcp	a,#32
 949  031c 2704          	jreq	L372
 950                     ; 228 			Rev_Msg.PushRod_Sta = PUSHROD_STOP;
 952  031e 3f14          	clr	L7_Rev_Msg+2
 954  0320 202e          	jra	L572
 955  0322               L372:
 956                     ; 229 		}else if(Rev_Data & CONT_PUSHROD_A_OPEN){
 958  0322 7b02          	ld	a,(OFST+0,sp)
 959  0324 a540          	bcp	a,#64
 960  0326 2706          	jreq	L772
 961                     ; 230 			Rev_Msg.PushRod_Sta = PUSHROD_A_OPEN;
 963  0328 35010014      	mov	L7_Rev_Msg+2,#1
 965  032c 2022          	jra	L572
 966  032e               L772:
 967                     ; 231 		}else if(Rev_Data & CONT_PUSHROD_A_CLOSE){
 969  032e 7b02          	ld	a,(OFST+0,sp)
 970  0330 a580          	bcp	a,#128
 971  0332 2706          	jreq	L303
 972                     ; 232 			Rev_Msg.PushRod_Sta = PUSHROD_A_CLOSE;
 974  0334 35020014      	mov	L7_Rev_Msg+2,#2
 976  0338 2016          	jra	L572
 977  033a               L303:
 978                     ; 233 		}else if(Rev_Data & CONT_PUSHROD_B_OPEN){
 980  033a 7b01          	ld	a,(OFST-1,sp)
 981  033c a502          	bcp	a,#2
 982  033e 2706          	jreq	L703
 983                     ; 234 			Rev_Msg.PushRod_Sta = PUSHROD_B_OPEN;
 985  0340 35040014      	mov	L7_Rev_Msg+2,#4
 987  0344 200a          	jra	L572
 988  0346               L703:
 989                     ; 235 		}else if(Rev_Data & CONT_PUSHROD_B_CLOSE){
 991  0346 7b01          	ld	a,(OFST-1,sp)
 992  0348 a504          	bcp	a,#4
 993  034a 2704          	jreq	L572
 994                     ; 236 			Rev_Msg.PushRod_Sta = PUSHROD_B_CLOSE;
 996  034c 35050014      	mov	L7_Rev_Msg+2,#5
 997  0350               L572:
 998                     ; 239 		if(Rev_Data & CONT_MASS_ON){
1000  0350 7b01          	ld	a,(OFST-1,sp)
1001  0352 a510          	bcp	a,#16
1002  0354 2706          	jreq	L513
1003                     ; 240 			Rev_Msg.ucMass_Sta = MASS_ON;
1005  0356 35010017      	mov	L7_Rev_Msg+5,#1
1007  035a 2008          	jra	L713
1008  035c               L513:
1009                     ; 241 		}else if(Rev_Data & CONT_MASS_OFF){
1011  035c 7b01          	ld	a,(OFST-1,sp)
1012  035e a520          	bcp	a,#32
1013  0360 2702          	jreq	L713
1014                     ; 242 			Rev_Msg.ucMass_Sta = MASS_OFF;
1016  0362 3f17          	clr	L7_Rev_Msg+5
1017  0364               L713:
1018                     ; 245 		if(Rev_Data & CONT_WARM_CLOTH_ON){
1020  0364 7b01          	ld	a,(OFST-1,sp)
1021  0366 a540          	bcp	a,#64
1022  0368 2706          	jreq	L323
1023                     ; 246 			Rev_Msg.ucWarn_Cloth_Sta = WARM_ON;
1025  036a 35010016      	mov	L7_Rev_Msg+4,#1
1027  036e 2008          	jra	L523
1028  0370               L323:
1029                     ; 247 		}else if(Rev_Data & CONT_WARM_CLOTH_OFF){
1031  0370 7b01          	ld	a,(OFST-1,sp)
1032  0372 a580          	bcp	a,#128
1033  0374 2702          	jreq	L523
1034                     ; 248 			Rev_Msg.ucWarn_Cloth_Sta = WARM_OFF;
1036  0376 3f16          	clr	L7_Rev_Msg+4
1037  0378               L523:
1038                     ; 251 		memset(Rev_Para.Buf,0,sizeof(Rev_Para.Buf));
1040  0378 ae0007        	ldw	x,#7
1041  037b               L22:
1042  037b 6fff          	clr	(_Rev_Para-1,x)
1043  037d 5a            	decw	x
1044  037e 26fb          	jrne	L22
1045  0380               L542:
1046                     ; 257 	if(TimeOutDet_Check(&Timeout) && !Serial_Get_Status()){
1048  0380 ae0007        	ldw	x,#L31_Timeout
1049  0383 cd0000        	call	_TimeOutDet_Check
1051  0386 cd0000        	call	c_lrzmp
1053  0389 2704          	jreq	L133
1055  038b cd0000        	call	_Serial_Get_Status
1057  038e 4d            	tnz	a
1058  038f               L133:
1059                     ; 264 }
1062  038f 85            	popw	x
1063  0390 81            	ret
1701                     	switch	.ubsct
1702  0000               _buf:
1703  0000 000000000000  	ds.b	7
1704                     	xdef	_buf
1705  0007               L31_Timeout:
1706  0007 000000000000  	ds.b	8
1707  000f               L11_CH_Para:
1708  000f 000000        	ds.b	3
1709  0012               L7_Rev_Msg:
1710  0012 000000000000  	ds.b	6
1711  0018               L5_Pushrod:
1712  0018 000000000000  	ds.b	8
1713                     	xref.b	_Rev_Para
1714                     	xref	_Mass_Deinit
1715                     	xref	_Mass_Handle
1716                     	xref	_memset
1717                     	xref	_TimeOutDet_Check
1718                     	xref	_TimeOut_Record
1719                     	xref	_TimeOutDet_Init
1720                     	xref	_CH_Cool_Heat_Moudle_Set
1721                     	xref	_CH_Handle
1722                     	xref	_CH_App_Init
1723                     	xref	_Serial_Get_Status
1724                     	xref	_Commu_Init
1725                     	xref	_Pushrod_GetStatus
1726                     	xref	_Pushrod_APP_Handle
1727                     	xref	_Pushrod_APP_Init
1728                     	xref	_KEY_Scan
1729                     	xref	_KEY_Init
1730                     	xdef	_System_Handle
1731                     	xdef	_System_Init
1732                     	xref	_TIM4_ARRPreloadConfig
1733                     	xref	_TIM4_PrescalerConfig
1734                     	xref	_TIM4_UpdateRequestConfig
1735                     	xref	_TIM4_UpdateDisableConfig
1736                     	xref	_TIM4_ITConfig
1737                     	xref	_TIM4_Cmd
1738                     	xref	_TIM4_TimeBaseInit
1739                     	xref	_TIM4_DeInit
1740                     	xref	_IWDG_Enable
1741                     	xref	_IWDG_ReloadCounter
1742                     	xref	_IWDG_SetReload
1743                     	xref	_IWDG_SetPrescaler
1744                     	xref	_IWDG_WriteAccessCmd
1745                     	xref	_GPIO_WriteLow
1746                     	xref	_GPIO_WriteHigh
1747                     	xref	_GPIO_Init
1748                     	xref.b	c_x
1768                     	xref	c_lrzmp
1769                     	xref	c_imul
1770                     	end
