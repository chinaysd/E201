   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.8 - 03 Dec 2008
   4                     	xref	_CH_Port_Adc_Init
   5                     	xref	_CH_Port_Init
 108                     ; 21 unsigned char CH_App_Init(CH_PARA_t *p){
 110                     	switch	.text
 111  0000               _CH_App_Init:
 113  0000 89            	pushw	x
 114       00000000      OFST:	set	0
 117                     ; 24 	CH_Port_Init(p->ID);
 119  0001 f6            	ld	a,(x)
 120  0002 cd0000        	call	_CH_Port_Init
 122                     ; 25 	CH_Port_Adc_Init(p->ID);
 124  0005 1e01          	ldw	x,(OFST+1,sp)
 125  0007 f6            	ld	a,(x)
 126  0008 cd0000        	call	_CH_Port_Adc_Init
 128                     ; 26 }
 131  000b 85            	popw	x
 132  000c 81            	ret
 135                     	xref	_Get_Temp
 171                     ; 29 static unsigned int CH_Get_Temp(CH_PARA_t *p){
 172                     	switch	.text
 173  000d               L17_CH_Get_Temp:
 177                     ; 32 	return Get_Temp(p->ID);
 179  000d f6            	ld	a,(x)
 180  000e cd0000        	call	_Get_Temp
 184  0011 81            	ret
 187                     	switch	.ubsct
 188  0000               L511_Flag:
 189  0000 00            	ds.b	1
 248                     ; 36 static unsigned char CH_Stop_Handle(CH_PARA_t *p){
 249                     	switch	.text
 250  0012               L311_CH_Stop_Handle:
 252  0012 89            	pushw	x
 253  0013 88            	push	a
 254       00000001      OFST:	set	1
 257                     ; 40 		p->Abnormal_DetFlag = FALSE;
 259  0014 6f02          	clr	(2,x)
 260                     ; 42 	ret = CH_Port_Cool_Set(p->ID, CH_CLOSE) && CH_Port_Heat_Set(p->ID, CH_CLOSE);
 262  0016 5f            	clrw	x
 263  0017 1602          	ldw	y,(OFST+1,sp)
 264  0019 90f6          	ld	a,(y)
 265  001b 95            	ld	xh,a
 266  001c cd0000        	call	_CH_Port_Cool_Set
 268  001f 4d            	tnz	a
 269  0020 2710          	jreq	L21
 270  0022 5f            	clrw	x
 271  0023 1602          	ldw	y,(OFST+1,sp)
 272  0025 90f6          	ld	a,(y)
 273  0027 95            	ld	xh,a
 274  0028 cd0000        	call	_CH_Port_Heat_Set
 276  002b 4d            	tnz	a
 277  002c 2704          	jreq	L21
 278  002e a601          	ld	a,#1
 279  0030 2001          	jra	L41
 280  0032               L21:
 281  0032 4f            	clr	a
 282  0033               L41:
 283  0033 6b01          	ld	(OFST+0,sp),a
 284                     ; 44 	if(p->Status != CH_STOP_MODE){
 286  0035 1e02          	ldw	x,(OFST+1,sp)
 287  0037 6d01          	tnz	(1,x)
 288  0039 2706          	jreq	L741
 289                     ; 45 		p->Status = CH_STOP_MODE;
 291  003b 1e02          	ldw	x,(OFST+1,sp)
 292  003d 6f01          	clr	(1,x)
 293                     ; 46 		Flag = 0;
 295  003f 3f00          	clr	L511_Flag
 296  0041               L741:
 297                     ; 49 	if(Flag == 0){
 299  0041 3d00          	tnz	L511_Flag
 300  0043 2623          	jrne	L151
 301                     ; 50 		Flag = 1;
 303  0045 35010000      	mov	L511_Flag,#1
 304                     ; 51 		TimeOut_Record(&CH_Stop_Timer[p->ID -1], CH_STOP_TIME);
 306  0049 ae3a98        	ldw	x,#15000
 307  004c 89            	pushw	x
 308  004d ae0000        	ldw	x,#0
 309  0050 89            	pushw	x
 310  0051 1e06          	ldw	x,(OFST+5,sp)
 311  0053 f6            	ld	a,(x)
 312  0054 97            	ld	xl,a
 313  0055 a608          	ld	a,#8
 314  0057 42            	mul	x,a
 315  0058 1d0008        	subw	x,#8
 316  005b 01            	rrwa	x,a
 317  005c ab37          	add	a,#L3_CH_Stop_Timer
 318  005e 2401          	jrnc	L61
 319  0060 5c            	incw	x
 320  0061               L61:
 321  0061 5f            	clrw	x
 322  0062 97            	ld	xl,a
 323  0063 cd0000        	call	_TimeOut_Record
 325  0066 5b04          	addw	sp,#4
 326  0068               L151:
 327                     ; 54 	if(TimeOutDet_Check(&CH_Stop_Timer[p->ID -1])){
 329  0068 1e02          	ldw	x,(OFST+1,sp)
 330  006a f6            	ld	a,(x)
 331  006b 97            	ld	xl,a
 332  006c a608          	ld	a,#8
 333  006e 42            	mul	x,a
 334  006f 1d0008        	subw	x,#8
 335  0072 01            	rrwa	x,a
 336  0073 ab37          	add	a,#L3_CH_Stop_Timer
 337  0075 2401          	jrnc	L02
 338  0077 5c            	incw	x
 339  0078               L02:
 340  0078 5f            	clrw	x
 341  0079 97            	ld	xl,a
 342  007a cd0000        	call	_TimeOutDet_Check
 344  007d cd0000        	call	c_lrzmp
 346  0080 270d          	jreq	L351
 347                     ; 55 		ret &= CH_Port_Fan_Set(p->ID, CH_CLOSE);
 349  0082 5f            	clrw	x
 350  0083 1602          	ldw	y,(OFST+1,sp)
 351  0085 90f6          	ld	a,(y)
 352  0087 95            	ld	xh,a
 353  0088 cd0000        	call	_CH_Port_Fan_Set
 355  008b 1401          	and	a,(OFST+0,sp)
 356  008d 6b01          	ld	(OFST+0,sp),a
 357  008f               L351:
 358                     ; 58 	return ret;
 360  008f 7b01          	ld	a,(OFST+0,sp)
 363  0091 5b03          	addw	sp,#3
 364  0093 81            	ret
 367                     	switch	.ubsct
 368  0001               L751_Flag:
 369  0001 00            	ds.b	1
 428                     ; 65 static unsigned char CH_Cool_Handle(CH_PARA_t *p){
 429                     	switch	.text
 430  0094               L551_CH_Cool_Handle:
 432  0094 89            	pushw	x
 433  0095 88            	push	a
 434       00000001      OFST:	set	1
 437                     ; 69 		p->Abnormal_DetFlag = FALSE;
 439  0096 6f02          	clr	(2,x)
 440                     ; 71 	ret = CH_Port_Fan_Set(p->ID, CH_OPEN);
 442  0098 ae0001        	ldw	x,#1
 443  009b 1602          	ldw	y,(OFST+1,sp)
 444  009d 90f6          	ld	a,(y)
 445  009f 95            	ld	xh,a
 446  00a0 cd0000        	call	_CH_Port_Fan_Set
 448  00a3 6b01          	ld	(OFST+0,sp),a
 449                     ; 73 	if(p->Status != CH_COOL_MODE){
 451  00a5 1e02          	ldw	x,(OFST+1,sp)
 452  00a7 e601          	ld	a,(1,x)
 453  00a9 a101          	cp	a,#1
 454  00ab 2708          	jreq	L112
 455                     ; 74 		p->Status = CH_COOL_MODE;
 457  00ad 1e02          	ldw	x,(OFST+1,sp)
 458  00af a601          	ld	a,#1
 459  00b1 e701          	ld	(1,x),a
 460                     ; 75 		Flag = 0;
 462  00b3 3f01          	clr	L751_Flag
 463  00b5               L112:
 464                     ; 78 	if(Flag == 0){
 466  00b5 3d01          	tnz	L751_Flag
 467  00b7 2635          	jrne	L312
 468                     ; 79 		Flag = 1;
 470  00b9 35010001      	mov	L751_Flag,#1
 471                     ; 80 		TimeOut_Record(&CH_Cool_Timer[p->ID -1], CH_START_TIME);
 473  00bd ae2710        	ldw	x,#10000
 474  00c0 89            	pushw	x
 475  00c1 ae0000        	ldw	x,#0
 476  00c4 89            	pushw	x
 477  00c5 1e06          	ldw	x,(OFST+5,sp)
 478  00c7 f6            	ld	a,(x)
 479  00c8 97            	ld	xl,a
 480  00c9 a608          	ld	a,#8
 481  00cb 42            	mul	x,a
 482  00cc 1d0008        	subw	x,#8
 483  00cf 01            	rrwa	x,a
 484  00d0 ab2f          	add	a,#L5_CH_Cool_Timer
 485  00d2 2401          	jrnc	L42
 486  00d4 5c            	incw	x
 487  00d5               L42:
 488  00d5 5f            	clrw	x
 489  00d6 97            	ld	xl,a
 490  00d7 cd0000        	call	_TimeOut_Record
 492  00da 5b04          	addw	sp,#4
 493                     ; 81 		CH_Port_Cool_Set(p->ID, CH_CLOSE);		// first close module
 495  00dc 5f            	clrw	x
 496  00dd 1602          	ldw	y,(OFST+1,sp)
 497  00df 90f6          	ld	a,(y)
 498  00e1 95            	ld	xh,a
 499  00e2 cd0000        	call	_CH_Port_Cool_Set
 501                     ; 82 		CH_Port_Heat_Set(p->ID, CH_CLOSE);
 503  00e5 5f            	clrw	x
 504  00e6 1602          	ldw	y,(OFST+1,sp)
 505  00e8 90f6          	ld	a,(y)
 506  00ea 95            	ld	xh,a
 507  00eb cd0000        	call	_CH_Port_Heat_Set
 509  00ee               L312:
 510                     ; 85 	if(TimeOutDet_Check(&CH_Cool_Timer[p->ID -1])){
 512  00ee 1e02          	ldw	x,(OFST+1,sp)
 513  00f0 f6            	ld	a,(x)
 514  00f1 97            	ld	xl,a
 515  00f2 a608          	ld	a,#8
 516  00f4 42            	mul	x,a
 517  00f5 1d0008        	subw	x,#8
 518  00f8 01            	rrwa	x,a
 519  00f9 ab2f          	add	a,#L5_CH_Cool_Timer
 520  00fb 2401          	jrnc	L62
 521  00fd 5c            	incw	x
 522  00fe               L62:
 523  00fe 5f            	clrw	x
 524  00ff 97            	ld	xl,a
 525  0100 cd0000        	call	_TimeOutDet_Check
 527  0103 cd0000        	call	c_lrzmp
 529  0106 271e          	jreq	L512
 530                     ; 86 		ret &= CH_Port_Cool_Set(p->ID, CH_OPEN);	// delay to complete
 532  0108 ae0001        	ldw	x,#1
 533  010b 1602          	ldw	y,(OFST+1,sp)
 534  010d 90f6          	ld	a,(y)
 535  010f 95            	ld	xh,a
 536  0110 cd0000        	call	_CH_Port_Cool_Set
 538  0113 1401          	and	a,(OFST+0,sp)
 539  0115 6b01          	ld	(OFST+0,sp),a
 540                     ; 87 		ret &= CH_Port_Heat_Set(p->ID, CH_OPEN);
 542  0117 ae0001        	ldw	x,#1
 543  011a 1602          	ldw	y,(OFST+1,sp)
 544  011c 90f6          	ld	a,(y)
 545  011e 95            	ld	xh,a
 546  011f cd0000        	call	_CH_Port_Heat_Set
 548  0122 1401          	and	a,(OFST+0,sp)
 549  0124 6b01          	ld	(OFST+0,sp),a
 550  0126               L512:
 551                     ; 90 	return ret;
 553  0126 7b01          	ld	a,(OFST+0,sp)
 556  0128 5b03          	addw	sp,#3
 557  012a 81            	ret
 560                     	bsct
 561  0000               L522_num:
 562  0000 0000          	dc.w	0
 563                     	switch	.ubsct
 564  0002               L122_Flag:
 565  0002 00            	ds.b	1
 566  0003               L332_SoftwareDelay:
 567  0003 000000000000  	ds.b	16
 568  0013               L132_Flag2:
 569  0013 0000          	ds.b	2
 570  0015               L722_Flag1:
 571  0015 0000          	ds.b	2
 702                     ; 95 static unsigned char CH_Heat_Handle(CH_PARA_t *p){
 703                     	switch	.text
 704  012b               L712_CH_Heat_Handle:
 706  012b 89            	pushw	x
 707  012c 5204          	subw	sp,#4
 708       00000004      OFST:	set	4
 711                     ; 97 	unsigned int ret = 0,temp = 0;
 713  012e 1e01          	ldw	x,(OFST-3,sp)
 716  0130 1e03          	ldw	x,(OFST-1,sp)
 717                     ; 98 	ret = CH_Port_Fan_Set(p->ID, CH_OPEN);
 719  0132 ae0001        	ldw	x,#1
 720  0135 1605          	ldw	y,(OFST+1,sp)
 721  0137 90f6          	ld	a,(y)
 722  0139 95            	ld	xh,a
 723  013a cd0000        	call	_CH_Port_Fan_Set
 725  013d 5f            	clrw	x
 726  013e 97            	ld	xl,a
 727  013f 1f01          	ldw	(OFST-3,sp),x
 728                     ; 100 	if(p->Status != CH_HEAT_MODE){
 730  0141 1e05          	ldw	x,(OFST+1,sp)
 731  0143 e601          	ld	a,(1,x)
 732  0145 a102          	cp	a,#2
 733  0147 2708          	jreq	L133
 734                     ; 101 		p->Status = CH_HEAT_MODE;
 736  0149 1e05          	ldw	x,(OFST+1,sp)
 737  014b a602          	ld	a,#2
 738  014d e701          	ld	(1,x),a
 739                     ; 102 		Flag = 0;
 741  014f 3f02          	clr	L122_Flag
 742  0151               L133:
 743                     ; 105 	if(Flag == 0){
 745  0151 3d02          	tnz	L122_Flag
 746  0153 2635          	jrne	L333
 747                     ; 106 		Flag = 1;
 749  0155 35010002      	mov	L122_Flag,#1
 750                     ; 107 		TimeOut_Record(&CH_Heat_Timer[p->ID -1], CH_START_TIME);
 752  0159 ae2710        	ldw	x,#10000
 753  015c 89            	pushw	x
 754  015d ae0000        	ldw	x,#0
 755  0160 89            	pushw	x
 756  0161 1e09          	ldw	x,(OFST+5,sp)
 757  0163 f6            	ld	a,(x)
 758  0164 97            	ld	xl,a
 759  0165 a608          	ld	a,#8
 760  0167 42            	mul	x,a
 761  0168 1d0008        	subw	x,#8
 762  016b 01            	rrwa	x,a
 763  016c ab27          	add	a,#L7_CH_Heat_Timer
 764  016e 2401          	jrnc	L23
 765  0170 5c            	incw	x
 766  0171               L23:
 767  0171 5f            	clrw	x
 768  0172 97            	ld	xl,a
 769  0173 cd0000        	call	_TimeOut_Record
 771  0176 5b04          	addw	sp,#4
 772                     ; 108 		CH_Port_Cool_Set(p->ID, CH_CLOSE);		// first close module
 774  0178 5f            	clrw	x
 775  0179 1605          	ldw	y,(OFST+1,sp)
 776  017b 90f6          	ld	a,(y)
 777  017d 95            	ld	xh,a
 778  017e cd0000        	call	_CH_Port_Cool_Set
 780                     ; 109 		CH_Port_Heat_Set(p->ID, CH_CLOSE);
 782  0181 5f            	clrw	x
 783  0182 1605          	ldw	y,(OFST+1,sp)
 784  0184 90f6          	ld	a,(y)
 785  0186 95            	ld	xh,a
 786  0187 cd0000        	call	_CH_Port_Heat_Set
 788  018a               L333:
 789                     ; 112 	if(TimeOutDet_Check(&CH_Heat_Timer[p->ID -1])){
 791  018a 1e05          	ldw	x,(OFST+1,sp)
 792  018c f6            	ld	a,(x)
 793  018d 97            	ld	xl,a
 794  018e a608          	ld	a,#8
 795  0190 42            	mul	x,a
 796  0191 1d0008        	subw	x,#8
 797  0194 01            	rrwa	x,a
 798  0195 ab27          	add	a,#L7_CH_Heat_Timer
 799  0197 2401          	jrnc	L43
 800  0199 5c            	incw	x
 801  019a               L43:
 802  019a 5f            	clrw	x
 803  019b 97            	ld	xl,a
 804  019c cd0000        	call	_TimeOutDet_Check
 806  019f cd0000        	call	c_lrzmp
 808  01a2 2603          	jrne	L64
 809  01a4 cc02d3        	jp	L533
 810  01a7               L64:
 811                     ; 113 		temp = CH_Get_Temp(p);		// cyclic heat
 813  01a7 1e05          	ldw	x,(OFST+1,sp)
 814  01a9 cd000d        	call	L17_CH_Get_Temp
 816  01ac 1f03          	ldw	(OFST-1,sp),x
 817                     ; 115 		if(temp == 0 || temp == 1023){
 819  01ae 1e03          	ldw	x,(OFST-1,sp)
 820  01b0 2707          	jreq	L143
 822  01b2 1e03          	ldw	x,(OFST-1,sp)
 823  01b4 a303ff        	cpw	x,#1023
 824  01b7 2640          	jrne	L733
 825  01b9               L143:
 826                     ; 116 			if(p->Abnormal_DetFlag == FALSE){
 828  01b9 1e05          	ldw	x,(OFST+1,sp)
 829  01bb 6d02          	tnz	(2,x)
 830  01bd 263a          	jrne	L733
 831                     ; 117 				p->Abnormal_DetFlag = TRUE;
 833  01bf 1e05          	ldw	x,(OFST+1,sp)
 834  01c1 a601          	ld	a,#1
 835  01c3 e702          	ld	(2,x),a
 836                     ; 118 				TimeOut_restart(&CH_Heat_Abnormal_Timer[p->ID -1]);
 838  01c5 1e05          	ldw	x,(OFST+1,sp)
 839  01c7 f6            	ld	a,(x)
 840  01c8 97            	ld	xl,a
 841  01c9 a608          	ld	a,#8
 842  01cb 42            	mul	x,a
 843  01cc 1d0008        	subw	x,#8
 844  01cf 01            	rrwa	x,a
 845  01d0 ab1f          	add	a,#L11_CH_Heat_Abnormal_Timer
 846  01d2 2401          	jrnc	L63
 847  01d4 5c            	incw	x
 848  01d5               L63:
 849  01d5 5f            	clrw	x
 850  01d6 97            	ld	xl,a
 851  01d7 cd0000        	call	_TimeOut_restart
 853                     ; 119 				TimeOut_Record(&CH_Heat_Abnormal_Timer[p->ID -1], CH_ABNORMAL_TIME);
 855  01da ae0bb8        	ldw	x,#3000
 856  01dd 89            	pushw	x
 857  01de ae0000        	ldw	x,#0
 858  01e1 89            	pushw	x
 859  01e2 1e09          	ldw	x,(OFST+5,sp)
 860  01e4 f6            	ld	a,(x)
 861  01e5 97            	ld	xl,a
 862  01e6 a608          	ld	a,#8
 863  01e8 42            	mul	x,a
 864  01e9 1d0008        	subw	x,#8
 865  01ec 01            	rrwa	x,a
 866  01ed ab1f          	add	a,#L11_CH_Heat_Abnormal_Timer
 867  01ef 2401          	jrnc	L04
 868  01f1 5c            	incw	x
 869  01f2               L04:
 870  01f2 5f            	clrw	x
 871  01f3 97            	ld	xl,a
 872  01f4 cd0000        	call	_TimeOut_Record
 874  01f7 5b04          	addw	sp,#4
 875  01f9               L733:
 876                     ; 123 		if(TimeOutDet_Check(&CH_Heat_Abnormal_Timer[p->ID -1]) && p->Abnormal_DetFlag){
 878  01f9 1e05          	ldw	x,(OFST+1,sp)
 879  01fb f6            	ld	a,(x)
 880  01fc 97            	ld	xl,a
 881  01fd a608          	ld	a,#8
 882  01ff 42            	mul	x,a
 883  0200 1d0008        	subw	x,#8
 884  0203 01            	rrwa	x,a
 885  0204 ab1f          	add	a,#L11_CH_Heat_Abnormal_Timer
 886  0206 2401          	jrnc	L24
 887  0208 5c            	incw	x
 888  0209               L24:
 889  0209 5f            	clrw	x
 890  020a 97            	ld	xl,a
 891  020b cd0000        	call	_TimeOutDet_Check
 893  020e cd0000        	call	c_lrzmp
 895  0211 2603cc0299    	jreq	L543
 897  0216 1e05          	ldw	x,(OFST+1,sp)
 898  0218 6d02          	tnz	(2,x)
 899  021a 277d          	jreq	L543
 900                     ; 126 			switch(num){		// loop heat 
 902  021c be00          	ldw	x,L522_num
 904                     ; 155 					break;
 905  021e 5d            	tnzw	x
 906  021f 2708          	jreq	L532
 907  0221 5a            	decw	x
 908  0222 273c          	jreq	L732
 909  0224               L142:
 910                     ; 154 					num = 0;
 912  0224 5f            	clrw	x
 913  0225 bf00          	ldw	L522_num,x
 914                     ; 155 					break;
 916  0227 206c          	jra	L153
 917  0229               L532:
 918                     ; 128 					Flag2 = 0;
 920  0229 5f            	clrw	x
 921  022a bf13          	ldw	L132_Flag2,x
 922                     ; 129 					if(!Flag1){
 924  022c be15          	ldw	x,L722_Flag1
 925  022e 2615          	jrne	L353
 926                     ; 130 						Flag1 = 1;
 928  0230 ae0001        	ldw	x,#1
 929  0233 bf15          	ldw	L722_Flag1,x
 930                     ; 131 						TimeOut_Record(&SoftwareDelay[0], 4000);
 932  0235 ae0fa0        	ldw	x,#4000
 933  0238 89            	pushw	x
 934  0239 ae0000        	ldw	x,#0
 935  023c 89            	pushw	x
 936  023d ae0003        	ldw	x,#L332_SoftwareDelay
 937  0240 cd0000        	call	_TimeOut_Record
 939  0243 5b04          	addw	sp,#4
 940  0245               L353:
 941                     ; 133 					if(TimeOutDet_Check(&SoftwareDelay[0])){
 943  0245 ae0003        	ldw	x,#L332_SoftwareDelay
 944  0248 cd0000        	call	_TimeOutDet_Check
 946  024b cd0000        	call	c_lrzmp
 948  024e 2745          	jreq	L153
 949                     ; 134 						CH_Port_Cool_Set(p->ID, CH_CLOSE);
 951  0250 5f            	clrw	x
 952  0251 1605          	ldw	y,(OFST+1,sp)
 953  0253 90f6          	ld	a,(y)
 954  0255 95            	ld	xh,a
 955  0256 cd0000        	call	_CH_Port_Cool_Set
 957                     ; 135 						num = 1;
 959  0259 ae0001        	ldw	x,#1
 960  025c bf00          	ldw	L522_num,x
 961  025e 2035          	jra	L153
 962  0260               L732:
 963                     ; 141 					Flag1 = 0;
 965  0260 5f            	clrw	x
 966  0261 bf15          	ldw	L722_Flag1,x
 967                     ; 142 					if(!Flag2){
 969  0263 be13          	ldw	x,L132_Flag2
 970  0265 2615          	jrne	L753
 971                     ; 143 						Flag2 = 1;
 973  0267 ae0001        	ldw	x,#1
 974  026a bf13          	ldw	L132_Flag2,x
 975                     ; 144 						TimeOut_Record(&SoftwareDelay[1], 10000);
 977  026c ae2710        	ldw	x,#10000
 978  026f 89            	pushw	x
 979  0270 ae0000        	ldw	x,#0
 980  0273 89            	pushw	x
 981  0274 ae000b        	ldw	x,#L332_SoftwareDelay+8
 982  0277 cd0000        	call	_TimeOut_Record
 984  027a 5b04          	addw	sp,#4
 985  027c               L753:
 986                     ; 146 					if(TimeOutDet_Check(&SoftwareDelay[1])){
 988  027c ae000b        	ldw	x,#L332_SoftwareDelay+8
 989  027f cd0000        	call	_TimeOutDet_Check
 991  0282 cd0000        	call	c_lrzmp
 993  0285 270e          	jreq	L153
 994                     ; 147 						CH_Port_Cool_Set(p->ID, CH_OPEN);
 996  0287 ae0001        	ldw	x,#1
 997  028a 1605          	ldw	y,(OFST+1,sp)
 998  028c 90f6          	ld	a,(y)
 999  028e 95            	ld	xh,a
1000  028f cd0000        	call	_CH_Port_Cool_Set
1002                     ; 148 						num = 0;
1004  0292 5f            	clrw	x
1005  0293 bf00          	ldw	L522_num,x
1006  0295               L153:
1007                     ; 158 			return 0XFF;
1009  0295 a6ff          	ld	a,#255
1011  0297 203c          	jra	L44
1012  0299               L543:
1013                     ; 161 		if(temp < CH_HEAT_STOP_VALUE){
1015  0299 1e03          	ldw	x,(OFST-1,sp)
1016  029b a30154        	cpw	x,#340
1017  029e 2416          	jruge	L363
1018                     ; 162 			ret &= CH_Port_Cool_Set(p->ID, CH_CLOSE);
1020  02a0 5f            	clrw	x
1021  02a1 1605          	ldw	y,(OFST+1,sp)
1022  02a3 90f6          	ld	a,(y)
1023  02a5 95            	ld	xh,a
1024  02a6 cd0000        	call	_CH_Port_Cool_Set
1026  02a9 5f            	clrw	x
1027  02aa 97            	ld	xl,a
1028  02ab 01            	rrwa	x,a
1029  02ac 1402          	and	a,(OFST-2,sp)
1030  02ae 01            	rrwa	x,a
1031  02af 1401          	and	a,(OFST-3,sp)
1032  02b1 01            	rrwa	x,a
1033  02b2 1f01          	ldw	(OFST-3,sp),x
1035  02b4 201d          	jra	L533
1036  02b6               L363:
1037                     ; 163 		}else if(temp > CH_HEAT_START_VALUE){
1039  02b6 1e03          	ldw	x,(OFST-1,sp)
1040  02b8 a30164        	cpw	x,#356
1041  02bb 2516          	jrult	L533
1042                     ; 164 			ret &= CH_Port_Cool_Set(p->ID, CH_OPEN);
1044  02bd ae0001        	ldw	x,#1
1045  02c0 1605          	ldw	y,(OFST+1,sp)
1046  02c2 90f6          	ld	a,(y)
1047  02c4 95            	ld	xh,a
1048  02c5 cd0000        	call	_CH_Port_Cool_Set
1050  02c8 5f            	clrw	x
1051  02c9 97            	ld	xl,a
1052  02ca 01            	rrwa	x,a
1053  02cb 1402          	and	a,(OFST-2,sp)
1054  02cd 01            	rrwa	x,a
1055  02ce 1401          	and	a,(OFST-3,sp)
1056  02d0 01            	rrwa	x,a
1057  02d1 1f01          	ldw	(OFST-3,sp),x
1058  02d3               L533:
1059                     ; 168 	return ret;
1061  02d3 7b02          	ld	a,(OFST-2,sp)
1063  02d5               L44:
1065  02d5 5b06          	addw	sp,#6
1066  02d7 81            	ret
1116                     ; 172 unsigned char CH_Handle(CH_PARA_t *p,CH_STATUS_t Status){
1117                     	switch	.text
1118  02d8               _CH_Handle:
1120  02d8 89            	pushw	x
1121       00000000      OFST:	set	0
1124                     ; 173 	if(Status == CH_STOP_MODE){
1126  02d9 0d05          	tnz	(OFST+5,sp)
1127  02db 2605          	jrne	L514
1128                     ; 174 		return CH_Stop_Handle(p);
1130  02dd cd0012        	call	L311_CH_Stop_Handle
1133  02e0 200b          	jra	L25
1134  02e2               L514:
1135                     ; 177 	else if(Status == CH_COOL_MODE){
1137  02e2 7b05          	ld	a,(OFST+5,sp)
1138  02e4 a101          	cp	a,#1
1139  02e6 2607          	jrne	L124
1140                     ; 178 		return CH_Cool_Handle(p);
1142  02e8 1e01          	ldw	x,(OFST+1,sp)
1143  02ea cd0094        	call	L551_CH_Cool_Handle
1146  02ed               L25:
1148  02ed 85            	popw	x
1149  02ee 81            	ret
1150  02ef               L124:
1151                     ; 182 	else if(Status == CH_HEAT_MODE){
1153  02ef 7b05          	ld	a,(OFST+5,sp)
1154  02f1 a102          	cp	a,#2
1155  02f3 2607          	jrne	L524
1156                     ; 183 		return CH_Heat_Handle(p);
1158  02f5 1e01          	ldw	x,(OFST+1,sp)
1159  02f7 cd012b        	call	L712_CH_Heat_Handle
1162  02fa 20f1          	jra	L25
1163  02fc               L524:
1164                     ; 187 		return 0;
1166  02fc 4f            	clr	a
1168  02fd 20ee          	jra	L25
1218                     ; 196 int CH_Cool_Heat_Moudle_Set(CH_PARA_t *p,unsigned char Status){
1219                     	switch	.text
1220  02ff               _CH_Cool_Heat_Moudle_Set:
1222  02ff 89            	pushw	x
1223       00000000      OFST:	set	0
1226                     ; 197 	if(p->ID == 0){
1228  0300 7d            	tnz	(x)
1229  0301 264a          	jrne	L554
1230                     ; 198 		if(Status == 0){
1232  0303 0d05          	tnz	(OFST+5,sp)
1233  0305 261f          	jrne	L754
1234                     ; 199 			CH_Port_Cool_Set(p->ID, 0);
1236  0307 5f            	clrw	x
1237  0308 1601          	ldw	y,(OFST+1,sp)
1238  030a 90f6          	ld	a,(y)
1239  030c 95            	ld	xh,a
1240  030d cd0000        	call	_CH_Port_Cool_Set
1242                     ; 200 			CH_Port_Heat_Set(p->ID, 0);
1244  0310 5f            	clrw	x
1245  0311 1601          	ldw	y,(OFST+1,sp)
1246  0313 90f6          	ld	a,(y)
1247  0315 95            	ld	xh,a
1248  0316 cd0000        	call	_CH_Port_Heat_Set
1250                     ; 201 			CH_Port_Fan_Set(p->ID, 1);
1252  0319 ae0001        	ldw	x,#1
1253  031c 1601          	ldw	y,(OFST+1,sp)
1254  031e 90f6          	ld	a,(y)
1255  0320 95            	ld	xh,a
1256  0321 cd0000        	call	_CH_Port_Fan_Set
1259  0324 2028          	jra	L564
1260  0326               L754:
1261                     ; 202 		}else if(Status == 1){
1263  0326 7b05          	ld	a,(OFST+5,sp)
1264  0328 a101          	cp	a,#1
1265  032a 2622          	jrne	L564
1266                     ; 203 			CH_Port_Cool_Set(p->ID, 1);
1268  032c ae0001        	ldw	x,#1
1269  032f 1601          	ldw	y,(OFST+1,sp)
1270  0331 90f6          	ld	a,(y)
1271  0333 95            	ld	xh,a
1272  0334 cd0000        	call	_CH_Port_Cool_Set
1274                     ; 204 			CH_Port_Heat_Set(p->ID, 1);
1276  0337 ae0001        	ldw	x,#1
1277  033a 1601          	ldw	y,(OFST+1,sp)
1278  033c 90f6          	ld	a,(y)
1279  033e 95            	ld	xh,a
1280  033f cd0000        	call	_CH_Port_Heat_Set
1282                     ; 205 			CH_Port_Fan_Set(p->ID, 0);
1284  0342 5f            	clrw	x
1285  0343 1601          	ldw	y,(OFST+1,sp)
1286  0345 90f6          	ld	a,(y)
1287  0347 95            	ld	xh,a
1288  0348 cd0000        	call	_CH_Port_Fan_Set
1290  034b 2001          	jra	L564
1291  034d               L554:
1292                     ; 208 		return 0;
1294  034d 5f            	clrw	x
1296  034e               L564:
1297                     ; 210 }
1298  034e               L65:
1301  034e 5b02          	addw	sp,#2
1302  0350 81            	ret
1378                     	xref	_CH_Port_Fan_Set
1379                     	xref	_CH_Port_Heat_Set
1380                     	xref	_CH_Port_Cool_Set
1381                     	switch	.ubsct
1382  0017               L31_CH_Heat_Software:
1383  0017 000000000000  	ds.b	8
1384  001f               L11_CH_Heat_Abnormal_Timer:
1385  001f 000000000000  	ds.b	8
1386  0027               L7_CH_Heat_Timer:
1387  0027 000000000000  	ds.b	8
1388  002f               L5_CH_Cool_Timer:
1389  002f 000000000000  	ds.b	8
1390  0037               L3_CH_Stop_Timer:
1391  0037 000000000000  	ds.b	8
1392                     	xref	_TimeOutDet_Check
1393                     	xref	_TimeOut_restart
1394                     	xref	_TimeOut_Record
1395                     	xdef	_CH_Cool_Heat_Moudle_Set
1396                     	xdef	_CH_Handle
1397                     	xdef	_CH_App_Init
1417                     	xref	c_lrzmp
1418                     	end
