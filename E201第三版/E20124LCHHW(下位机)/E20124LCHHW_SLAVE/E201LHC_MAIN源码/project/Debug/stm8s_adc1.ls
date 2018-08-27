   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.8 - 03 Dec 2008
  32                     ; 48 void ADC1_DeInit(void)
  32                     ; 49 {
  34                     	switch	.text
  35  0000               _ADC1_DeInit:
  39                     ; 50     ADC1->CSR  = ADC1_CSR_RESET_VALUE;
  41  0000 725f5400      	clr	21504
  42                     ; 51     ADC1->CR1  = ADC1_CR1_RESET_VALUE;
  44  0004 725f5401      	clr	21505
  45                     ; 52     ADC1->CR2  = ADC1_CR2_RESET_VALUE;
  47  0008 725f5402      	clr	21506
  48                     ; 53     ADC1->CR3  = ADC1_CR3_RESET_VALUE;
  50  000c 725f5403      	clr	21507
  51                     ; 54     ADC1->TDRH = ADC1_TDRH_RESET_VALUE;
  53  0010 725f5406      	clr	21510
  54                     ; 55     ADC1->TDRL = ADC1_TDRL_RESET_VALUE;
  56  0014 725f5407      	clr	21511
  57                     ; 56     ADC1->HTRH = ADC1_HTRH_RESET_VALUE;
  59  0018 35ff5408      	mov	21512,#255
  60                     ; 57     ADC1->HTRL = ADC1_HTRL_RESET_VALUE;
  62  001c 35035409      	mov	21513,#3
  63                     ; 58     ADC1->LTRH = ADC1_LTRH_RESET_VALUE;
  65  0020 725f540a      	clr	21514
  66                     ; 59     ADC1->LTRL = ADC1_LTRL_RESET_VALUE;
  68  0024 725f540b      	clr	21515
  69                     ; 60     ADC1->AWCRH = ADC1_AWCRH_RESET_VALUE;
  71  0028 725f540e      	clr	21518
  72                     ; 61     ADC1->AWCRL = ADC1_AWCRL_RESET_VALUE;
  74  002c 725f540f      	clr	21519
  75                     ; 62 }
  78  0030 81            	ret
 529                     ; 85 void ADC1_Init(ADC1_ConvMode_TypeDef ADC1_ConversionMode, ADC1_Channel_TypeDef ADC1_Channel, ADC1_PresSel_TypeDef ADC1_PrescalerSelection, ADC1_ExtTrig_TypeDef ADC1_ExtTrigger, FunctionalState ADC1_ExtTriggerState, ADC1_Align_TypeDef ADC1_Align, ADC1_SchmittTrigg_TypeDef ADC1_SchmittTriggerChannel, FunctionalState ADC1_SchmittTriggerState)
 529                     ; 86 {
 530                     	switch	.text
 531  0031               _ADC1_Init:
 533  0031 89            	pushw	x
 534       00000000      OFST:	set	0
 537                     ; 102     ADC1_ConversionConfig(ADC1_ConversionMode, ADC1_Channel, ADC1_Align);
 539  0032 7b08          	ld	a,(OFST+8,sp)
 540  0034 88            	push	a
 541  0035 9f            	ld	a,xl
 542  0036 97            	ld	xl,a
 543  0037 7b02          	ld	a,(OFST+2,sp)
 544  0039 95            	ld	xh,a
 545  003a cd0121        	call	_ADC1_ConversionConfig
 547  003d 84            	pop	a
 548                     ; 104     ADC1_PrescalerConfig(ADC1_PrescalerSelection);
 550  003e 7b05          	ld	a,(OFST+5,sp)
 551  0040 ad3e          	call	_ADC1_PrescalerConfig
 553                     ; 109     ADC1_ExternalTriggerConfig(ADC1_ExtTrigger, ADC1_ExtTriggerState);
 555  0042 7b07          	ld	a,(OFST+7,sp)
 556  0044 97            	ld	xl,a
 557  0045 7b06          	ld	a,(OFST+6,sp)
 558  0047 95            	ld	xh,a
 559  0048 cd014f        	call	_ADC1_ExternalTriggerConfig
 561                     ; 114     ADC1_SchmittTriggerConfig(ADC1_SchmittTriggerChannel, ADC1_SchmittTriggerState);
 563  004b 7b0a          	ld	a,(OFST+10,sp)
 564  004d 97            	ld	xl,a
 565  004e 7b09          	ld	a,(OFST+9,sp)
 566  0050 95            	ld	xh,a
 567  0051 ad40          	call	_ADC1_SchmittTriggerConfig
 569                     ; 117     ADC1->CR1 |= ADC1_CR1_ADON;
 571  0053 72105401      	bset	21505,#0
 572                     ; 119 }
 575  0057 85            	popw	x
 576  0058 81            	ret
 611                     ; 127 void ADC1_Cmd(FunctionalState NewState)
 611                     ; 128 {
 612                     	switch	.text
 613  0059               _ADC1_Cmd:
 617                     ; 133     if (NewState != DISABLE)
 619  0059 4d            	tnz	a
 620  005a 2706          	jreq	L362
 621                     ; 135         ADC1->CR1 |= ADC1_CR1_ADON;
 623  005c 72105401      	bset	21505,#0
 625  0060 2004          	jra	L562
 626  0062               L362:
 627                     ; 139         ADC1->CR1 &= (uint8_t)(~ADC1_CR1_ADON);
 629  0062 72115401      	bres	21505,#0
 630  0066               L562:
 631                     ; 142 }
 634  0066 81            	ret
 790                     ; 200 void ADC1_ITConfig(ADC1_IT_TypeDef ADC1_IT, FunctionalState NewState)
 790                     ; 201 {
 791                     	switch	.text
 792  0067               _ADC1_ITConfig:
 794  0067 89            	pushw	x
 795       00000000      OFST:	set	0
 798                     ; 204     assert_param(IS_ADC1_IT_OK(ADC1_IT));
 800                     ; 205     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 802                     ; 207     if (NewState != DISABLE)
 804  0068 0d05          	tnz	(OFST+5,sp)
 805  006a 2709          	jreq	L353
 806                     ; 210         ADC1->CSR |= (uint8_t)ADC1_IT;
 808  006c 9f            	ld	a,xl
 809  006d ca5400        	or	a,21504
 810  0070 c75400        	ld	21504,a
 812  0073 2009          	jra	L553
 813  0075               L353:
 814                     ; 215         ADC1->CSR &= (uint8_t)((uint16_t)~(uint16_t)ADC1_IT);
 816  0075 7b02          	ld	a,(OFST+2,sp)
 817  0077 43            	cpl	a
 818  0078 c45400        	and	a,21504
 819  007b c75400        	ld	21504,a
 820  007e               L553:
 821                     ; 218 }
 824  007e 85            	popw	x
 825  007f 81            	ret
 861                     ; 226 void ADC1_PrescalerConfig(ADC1_PresSel_TypeDef ADC1_Prescaler)
 861                     ; 227 {
 862                     	switch	.text
 863  0080               _ADC1_PrescalerConfig:
 865  0080 88            	push	a
 866       00000000      OFST:	set	0
 869                     ; 230     assert_param(IS_ADC1_PRESSEL_OK(ADC1_Prescaler));
 871                     ; 233     ADC1->CR1 &= (uint8_t)(~ADC1_CR1_SPSEL);
 873  0081 c65401        	ld	a,21505
 874  0084 a48f          	and	a,#143
 875  0086 c75401        	ld	21505,a
 876                     ; 235     ADC1->CR1 |= (uint8_t)(ADC1_Prescaler);
 878  0089 c65401        	ld	a,21505
 879  008c 1a01          	or	a,(OFST+1,sp)
 880  008e c75401        	ld	21505,a
 881                     ; 237 }
 884  0091 84            	pop	a
 885  0092 81            	ret
 932                     ; 248 void ADC1_SchmittTriggerConfig(ADC1_SchmittTrigg_TypeDef ADC1_SchmittTriggerChannel, FunctionalState NewState)
 932                     ; 249 {
 933                     	switch	.text
 934  0093               _ADC1_SchmittTriggerConfig:
 936  0093 89            	pushw	x
 937       00000000      OFST:	set	0
 940                     ; 252     assert_param(IS_ADC1_SCHMITTTRIG_OK(ADC1_SchmittTriggerChannel));
 942                     ; 253     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 944                     ; 255     if (ADC1_SchmittTriggerChannel == ADC1_SCHMITTTRIG_ALL)
 946  0094 9e            	ld	a,xh
 947  0095 a1ff          	cp	a,#255
 948  0097 2620          	jrne	L714
 949                     ; 257         if (NewState != DISABLE)
 951  0099 9f            	ld	a,xl
 952  009a 4d            	tnz	a
 953  009b 270a          	jreq	L124
 954                     ; 259             ADC1->TDRL &= (uint8_t)0x0;
 956  009d 725f5407      	clr	21511
 957                     ; 260             ADC1->TDRH &= (uint8_t)0x0;
 959  00a1 725f5406      	clr	21510
 961  00a5 2078          	jra	L524
 962  00a7               L124:
 963                     ; 264             ADC1->TDRL |= (uint8_t)0xFF;
 965  00a7 c65407        	ld	a,21511
 966  00aa aaff          	or	a,#255
 967  00ac c75407        	ld	21511,a
 968                     ; 265             ADC1->TDRH |= (uint8_t)0xFF;
 970  00af c65406        	ld	a,21510
 971  00b2 aaff          	or	a,#255
 972  00b4 c75406        	ld	21510,a
 973  00b7 2066          	jra	L524
 974  00b9               L714:
 975                     ; 268     else if (ADC1_SchmittTriggerChannel < ADC1_SCHMITTTRIG_CHANNEL8)
 977  00b9 7b01          	ld	a,(OFST+1,sp)
 978  00bb a108          	cp	a,#8
 979  00bd 242f          	jruge	L724
 980                     ; 270         if (NewState != DISABLE)
 982  00bf 0d02          	tnz	(OFST+2,sp)
 983  00c1 2716          	jreq	L134
 984                     ; 272             ADC1->TDRL &= (uint8_t)(~(uint8_t)((uint8_t)0x01 << (uint8_t)ADC1_SchmittTriggerChannel));
 986  00c3 7b01          	ld	a,(OFST+1,sp)
 987  00c5 5f            	clrw	x
 988  00c6 97            	ld	xl,a
 989  00c7 a601          	ld	a,#1
 990  00c9 5d            	tnzw	x
 991  00ca 2704          	jreq	L02
 992  00cc               L22:
 993  00cc 48            	sll	a
 994  00cd 5a            	decw	x
 995  00ce 26fc          	jrne	L22
 996  00d0               L02:
 997  00d0 43            	cpl	a
 998  00d1 c45407        	and	a,21511
 999  00d4 c75407        	ld	21511,a
1001  00d7 2046          	jra	L524
1002  00d9               L134:
1003                     ; 276             ADC1->TDRL |= (uint8_t)((uint8_t)0x01 << (uint8_t)ADC1_SchmittTriggerChannel);
1005  00d9 7b01          	ld	a,(OFST+1,sp)
1006  00db 5f            	clrw	x
1007  00dc 97            	ld	xl,a
1008  00dd a601          	ld	a,#1
1009  00df 5d            	tnzw	x
1010  00e0 2704          	jreq	L42
1011  00e2               L62:
1012  00e2 48            	sll	a
1013  00e3 5a            	decw	x
1014  00e4 26fc          	jrne	L62
1015  00e6               L42:
1016  00e6 ca5407        	or	a,21511
1017  00e9 c75407        	ld	21511,a
1018  00ec 2031          	jra	L524
1019  00ee               L724:
1020                     ; 281         if (NewState != DISABLE)
1022  00ee 0d02          	tnz	(OFST+2,sp)
1023  00f0 2718          	jreq	L734
1024                     ; 283             ADC1->TDRH &= (uint8_t)(~(uint8_t)((uint8_t)0x01 << ((uint8_t)ADC1_SchmittTriggerChannel - (uint8_t)8)));
1026  00f2 7b01          	ld	a,(OFST+1,sp)
1027  00f4 a008          	sub	a,#8
1028  00f6 5f            	clrw	x
1029  00f7 97            	ld	xl,a
1030  00f8 a601          	ld	a,#1
1031  00fa 5d            	tnzw	x
1032  00fb 2704          	jreq	L03
1033  00fd               L23:
1034  00fd 48            	sll	a
1035  00fe 5a            	decw	x
1036  00ff 26fc          	jrne	L23
1037  0101               L03:
1038  0101 43            	cpl	a
1039  0102 c45406        	and	a,21510
1040  0105 c75406        	ld	21510,a
1042  0108 2015          	jra	L524
1043  010a               L734:
1044                     ; 287             ADC1->TDRH |= (uint8_t)((uint8_t)0x01 << ((uint8_t)ADC1_SchmittTriggerChannel - (uint8_t)8));
1046  010a 7b01          	ld	a,(OFST+1,sp)
1047  010c a008          	sub	a,#8
1048  010e 5f            	clrw	x
1049  010f 97            	ld	xl,a
1050  0110 a601          	ld	a,#1
1051  0112 5d            	tnzw	x
1052  0113 2704          	jreq	L43
1053  0115               L63:
1054  0115 48            	sll	a
1055  0116 5a            	decw	x
1056  0117 26fc          	jrne	L63
1057  0119               L43:
1058  0119 ca5406        	or	a,21510
1059  011c c75406        	ld	21510,a
1060  011f               L524:
1061                     ; 291 }
1064  011f 85            	popw	x
1065  0120 81            	ret
1122                     ; 303 void ADC1_ConversionConfig(ADC1_ConvMode_TypeDef ADC1_ConversionMode, ADC1_Channel_TypeDef ADC1_Channel, ADC1_Align_TypeDef ADC1_Align)
1122                     ; 304 {
1123                     	switch	.text
1124  0121               _ADC1_ConversionConfig:
1126  0121 89            	pushw	x
1127       00000000      OFST:	set	0
1130                     ; 307     assert_param(IS_ADC1_CONVERSIONMODE_OK(ADC1_ConversionMode));
1132                     ; 308     assert_param(IS_ADC1_CHANNEL_OK(ADC1_Channel));
1134                     ; 309     assert_param(IS_ADC1_ALIGN_OK(ADC1_Align));
1136                     ; 312     ADC1->CR2 &= (uint8_t)(~ADC1_CR2_ALIGN);
1138  0122 72175402      	bres	21506,#3
1139                     ; 314     ADC1->CR2 |= (uint8_t)(ADC1_Align);
1141  0126 c65402        	ld	a,21506
1142  0129 1a05          	or	a,(OFST+5,sp)
1143  012b c75402        	ld	21506,a
1144                     ; 316     if (ADC1_ConversionMode == ADC1_CONVERSIONMODE_CONTINUOUS)
1146  012e 9e            	ld	a,xh
1147  012f a101          	cp	a,#1
1148  0131 2606          	jrne	L174
1149                     ; 319         ADC1->CR1 |= ADC1_CR1_CONT;
1151  0133 72125401      	bset	21505,#1
1153  0137 2004          	jra	L374
1154  0139               L174:
1155                     ; 324         ADC1->CR1 &= (uint8_t)(~ADC1_CR1_CONT);
1157  0139 72135401      	bres	21505,#1
1158  013d               L374:
1159                     ; 328     ADC1->CSR &= (uint8_t)(~ADC1_CSR_CH);
1161  013d c65400        	ld	a,21504
1162  0140 a4f0          	and	a,#240
1163  0142 c75400        	ld	21504,a
1164                     ; 330     ADC1->CSR |= (uint8_t)(ADC1_Channel);
1166  0145 c65400        	ld	a,21504
1167  0148 1a02          	or	a,(OFST+2,sp)
1168  014a c75400        	ld	21504,a
1169                     ; 332 }
1172  014d 85            	popw	x
1173  014e 81            	ret
1219                     ; 344 void ADC1_ExternalTriggerConfig(ADC1_ExtTrig_TypeDef ADC1_ExtTrigger, FunctionalState NewState)
1219                     ; 345 {
1220                     	switch	.text
1221  014f               _ADC1_ExternalTriggerConfig:
1223  014f 89            	pushw	x
1224       00000000      OFST:	set	0
1227                     ; 348     assert_param(IS_ADC1_EXTTRIG_OK(ADC1_ExtTrigger));
1229                     ; 349     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1231                     ; 352     ADC1->CR2 &= (uint8_t)(~ADC1_CR2_EXTSEL);
1233  0150 c65402        	ld	a,21506
1234  0153 a4cf          	and	a,#207
1235  0155 c75402        	ld	21506,a
1236                     ; 354     if (NewState != DISABLE)
1238  0158 9f            	ld	a,xl
1239  0159 4d            	tnz	a
1240  015a 2706          	jreq	L715
1241                     ; 357         ADC1->CR2 |= (uint8_t)(ADC1_CR2_EXTTRIG);
1243  015c 721c5402      	bset	21506,#6
1245  0160 2004          	jra	L125
1246  0162               L715:
1247                     ; 362         ADC1->CR2 &= (uint8_t)(~ADC1_CR2_EXTTRIG);
1249  0162 721d5402      	bres	21506,#6
1250  0166               L125:
1251                     ; 366     ADC1->CR2 |= (uint8_t)(ADC1_ExtTrigger);
1253  0166 c65402        	ld	a,21506
1254  0169 1a01          	or	a,(OFST+1,sp)
1255  016b c75402        	ld	21506,a
1256                     ; 368 }
1259  016e 85            	popw	x
1260  016f 81            	ret
1284                     ; 380 void ADC1_StartConversion(void)
1284                     ; 381 {
1285                     	switch	.text
1286  0170               _ADC1_StartConversion:
1290                     ; 382     ADC1->CR1 |= ADC1_CR1_ADON;
1292  0170 72105401      	bset	21505,#0
1293                     ; 383 }
1296  0174 81            	ret
1340                     ; 392 uint16_t ADC1_GetConversionValue(void)
1340                     ; 393 {
1341                     	switch	.text
1342  0175               _ADC1_GetConversionValue:
1344  0175 5205          	subw	sp,#5
1345       00000005      OFST:	set	5
1348                     ; 395     uint16_t temph = 0;
1350  0177 1e04          	ldw	x,(OFST-1,sp)
1351                     ; 396     uint8_t templ = 0;
1353  0179 7b03          	ld	a,(OFST-2,sp)
1354  017b 97            	ld	xl,a
1355                     ; 398     if ((ADC1->CR2 & ADC1_CR2_ALIGN) != 0) /* Right alignment */
1357  017c c65402        	ld	a,21506
1358  017f a508          	bcp	a,#8
1359  0181 2719          	jreq	L555
1360                     ; 401         templ = ADC1->DRL;
1362  0183 c65405        	ld	a,21509
1363  0186 6b03          	ld	(OFST-2,sp),a
1364                     ; 403         temph = ADC1->DRH;
1366  0188 c65404        	ld	a,21508
1367  018b 5f            	clrw	x
1368  018c 97            	ld	xl,a
1369  018d 1f04          	ldw	(OFST-1,sp),x
1370                     ; 405         temph = (uint16_t)(templ | (uint16_t)(temph << (uint8_t)8));
1372  018f 1e04          	ldw	x,(OFST-1,sp)
1373  0191 4f            	clr	a
1374  0192 02            	rlwa	x,a
1375  0193 01            	rrwa	x,a
1376  0194 1a03          	or	a,(OFST-2,sp)
1377  0196 02            	rlwa	x,a
1378  0197 1f04          	ldw	(OFST-1,sp),x
1379  0199 01            	rrwa	x,a
1381  019a 2021          	jra	L755
1382  019c               L555:
1383                     ; 410         temph = ADC1->DRH;
1385  019c c65404        	ld	a,21508
1386  019f 5f            	clrw	x
1387  01a0 97            	ld	xl,a
1388  01a1 1f04          	ldw	(OFST-1,sp),x
1389                     ; 412         templ = ADC1->DRL;
1391  01a3 c65405        	ld	a,21509
1392  01a6 6b03          	ld	(OFST-2,sp),a
1393                     ; 414         temph = (uint16_t)((uint16_t)((uint16_t)templ << 6) | (uint16_t)((uint16_t)temph << 8));
1395  01a8 1e04          	ldw	x,(OFST-1,sp)
1396  01aa 4f            	clr	a
1397  01ab 02            	rlwa	x,a
1398  01ac 1f01          	ldw	(OFST-4,sp),x
1399  01ae 7b03          	ld	a,(OFST-2,sp)
1400  01b0 97            	ld	xl,a
1401  01b1 a640          	ld	a,#64
1402  01b3 42            	mul	x,a
1403  01b4 01            	rrwa	x,a
1404  01b5 1a02          	or	a,(OFST-3,sp)
1405  01b7 01            	rrwa	x,a
1406  01b8 1a01          	or	a,(OFST-4,sp)
1407  01ba 01            	rrwa	x,a
1408  01bb 1f04          	ldw	(OFST-1,sp),x
1409  01bd               L755:
1410                     ; 417     return ((uint16_t)temph);
1412  01bd 1e04          	ldw	x,(OFST-1,sp)
1415  01bf 5b05          	addw	sp,#5
1416  01c1 81            	ret
1594                     ; 558 FlagStatus ADC1_GetFlagStatus(ADC1_Flag_TypeDef Flag)
1594                     ; 559 {
1595                     	switch	.text
1596  01c2               _ADC1_GetFlagStatus:
1598  01c2 88            	push	a
1599  01c3 88            	push	a
1600       00000001      OFST:	set	1
1603                     ; 560     uint8_t flagstatus = 0;
1605  01c4 7b01          	ld	a,(OFST+0,sp)
1606  01c6 97            	ld	xl,a
1607                     ; 561     uint8_t temp = 0;
1609  01c7 7b01          	ld	a,(OFST+0,sp)
1610  01c9 97            	ld	xl,a
1611                     ; 564     assert_param(IS_ADC1_FLAG_OK(Flag));
1613                     ; 566     if ((Flag & 0x0F) == 0x01)
1615  01ca 7b02          	ld	a,(OFST+1,sp)
1616  01cc a40f          	and	a,#15
1617  01ce a101          	cp	a,#1
1618  01d0 2609          	jrne	L756
1619                     ; 569         flagstatus = (uint8_t)(ADC1->CR3 & ADC1_CR3_OVR);
1621  01d2 c65403        	ld	a,21507
1622  01d5 a440          	and	a,#64
1623  01d7 6b01          	ld	(OFST+0,sp),a
1625  01d9 2045          	jra	L166
1626  01db               L756:
1627                     ; 571     else if ((Flag & 0xF0) == 0x10)
1629  01db 7b02          	ld	a,(OFST+1,sp)
1630  01dd a4f0          	and	a,#240
1631  01df a110          	cp	a,#16
1632  01e1 2636          	jrne	L366
1633                     ; 574         temp = (uint8_t)(Flag & (uint8_t)0x0F);
1635  01e3 7b02          	ld	a,(OFST+1,sp)
1636  01e5 a40f          	and	a,#15
1637  01e7 6b01          	ld	(OFST+0,sp),a
1638                     ; 575         if (temp < 8)
1640  01e9 7b01          	ld	a,(OFST+0,sp)
1641  01eb a108          	cp	a,#8
1642  01ed 2414          	jruge	L566
1643                     ; 577             flagstatus = (uint8_t)(ADC1->AWSRL & (uint8_t)((uint8_t)1 << temp));
1645  01ef 7b01          	ld	a,(OFST+0,sp)
1646  01f1 5f            	clrw	x
1647  01f2 97            	ld	xl,a
1648  01f3 a601          	ld	a,#1
1649  01f5 5d            	tnzw	x
1650  01f6 2704          	jreq	L25
1651  01f8               L45:
1652  01f8 48            	sll	a
1653  01f9 5a            	decw	x
1654  01fa 26fc          	jrne	L45
1655  01fc               L25:
1656  01fc c4540d        	and	a,21517
1657  01ff 6b01          	ld	(OFST+0,sp),a
1659  0201 201d          	jra	L166
1660  0203               L566:
1661                     ; 581             flagstatus = (uint8_t)(ADC1->AWSRH & (uint8_t)((uint8_t)1 << (temp - 8)));
1663  0203 7b01          	ld	a,(OFST+0,sp)
1664  0205 a008          	sub	a,#8
1665  0207 5f            	clrw	x
1666  0208 97            	ld	xl,a
1667  0209 a601          	ld	a,#1
1668  020b 5d            	tnzw	x
1669  020c 2704          	jreq	L65
1670  020e               L06:
1671  020e 48            	sll	a
1672  020f 5a            	decw	x
1673  0210 26fc          	jrne	L06
1674  0212               L65:
1675  0212 c4540c        	and	a,21516
1676  0215 6b01          	ld	(OFST+0,sp),a
1677  0217 2007          	jra	L166
1678  0219               L366:
1679                     ; 586         flagstatus = (uint8_t)(ADC1->CSR & Flag);
1681  0219 c65400        	ld	a,21504
1682  021c 1402          	and	a,(OFST+1,sp)
1683  021e 6b01          	ld	(OFST+0,sp),a
1684  0220               L166:
1685                     ; 588     return ((FlagStatus)flagstatus);
1687  0220 7b01          	ld	a,(OFST+0,sp)
1690  0222 85            	popw	x
1691  0223 81            	ret
1735                     ; 597 void ADC1_ClearFlag(ADC1_Flag_TypeDef Flag)
1735                     ; 598 {
1736                     	switch	.text
1737  0224               _ADC1_ClearFlag:
1739  0224 88            	push	a
1740  0225 88            	push	a
1741       00000001      OFST:	set	1
1744                     ; 599     uint8_t temp = 0;
1746  0226 0f01          	clr	(OFST+0,sp)
1747                     ; 602     assert_param(IS_ADC1_FLAG_OK(Flag));
1749                     ; 604     if ((Flag & 0x0F) == 0x01)
1751  0228 a40f          	and	a,#15
1752  022a a101          	cp	a,#1
1753  022c 2606          	jrne	L517
1754                     ; 607         ADC1->CR3 &= (uint8_t)(~ADC1_CR3_OVR);
1756  022e 721d5403      	bres	21507,#6
1758  0232 204b          	jra	L717
1759  0234               L517:
1760                     ; 609     else if ((Flag & 0xF0) == 0x10)
1762  0234 7b02          	ld	a,(OFST+1,sp)
1763  0236 a4f0          	and	a,#240
1764  0238 a110          	cp	a,#16
1765  023a 263a          	jrne	L127
1766                     ; 612         temp = (uint8_t)(Flag & (uint8_t)0x0F);
1768  023c 7b02          	ld	a,(OFST+1,sp)
1769  023e a40f          	and	a,#15
1770  0240 6b01          	ld	(OFST+0,sp),a
1771                     ; 613         if (temp < 8)
1773  0242 7b01          	ld	a,(OFST+0,sp)
1774  0244 a108          	cp	a,#8
1775  0246 2416          	jruge	L327
1776                     ; 615             ADC1->AWSRL &= (uint8_t)~(uint8_t)((uint8_t)1 << temp);
1778  0248 7b01          	ld	a,(OFST+0,sp)
1779  024a 5f            	clrw	x
1780  024b 97            	ld	xl,a
1781  024c a601          	ld	a,#1
1782  024e 5d            	tnzw	x
1783  024f 2704          	jreq	L46
1784  0251               L66:
1785  0251 48            	sll	a
1786  0252 5a            	decw	x
1787  0253 26fc          	jrne	L66
1788  0255               L46:
1789  0255 43            	cpl	a
1790  0256 c4540d        	and	a,21517
1791  0259 c7540d        	ld	21517,a
1793  025c 2021          	jra	L717
1794  025e               L327:
1795                     ; 619             ADC1->AWSRH &= (uint8_t)~(uint8_t)((uint8_t)1 << (temp - 8));
1797  025e 7b01          	ld	a,(OFST+0,sp)
1798  0260 a008          	sub	a,#8
1799  0262 5f            	clrw	x
1800  0263 97            	ld	xl,a
1801  0264 a601          	ld	a,#1
1802  0266 5d            	tnzw	x
1803  0267 2704          	jreq	L07
1804  0269               L27:
1805  0269 48            	sll	a
1806  026a 5a            	decw	x
1807  026b 26fc          	jrne	L27
1808  026d               L07:
1809  026d 43            	cpl	a
1810  026e c4540c        	and	a,21516
1811  0271 c7540c        	ld	21516,a
1812  0274 2009          	jra	L717
1813  0276               L127:
1814                     ; 624         ADC1->CSR &= (uint8_t) (~Flag);
1816  0276 7b02          	ld	a,(OFST+1,sp)
1817  0278 43            	cpl	a
1818  0279 c45400        	and	a,21504
1819  027c c75400        	ld	21504,a
1820  027f               L717:
1821                     ; 626 }
1824  027f 85            	popw	x
1825  0280 81            	ret
1838                     	xdef	_ADC1_ClearFlag
1839                     	xdef	_ADC1_GetFlagStatus
1840                     	xdef	_ADC1_GetConversionValue
1841                     	xdef	_ADC1_StartConversion
1842                     	xdef	_ADC1_ExternalTriggerConfig
1843                     	xdef	_ADC1_ConversionConfig
1844                     	xdef	_ADC1_SchmittTriggerConfig
1845                     	xdef	_ADC1_PrescalerConfig
1846                     	xdef	_ADC1_ITConfig
1847                     	xdef	_ADC1_Cmd
1848                     	xdef	_ADC1_Init
1849                     	xdef	_ADC1_DeInit
1868                     	end
