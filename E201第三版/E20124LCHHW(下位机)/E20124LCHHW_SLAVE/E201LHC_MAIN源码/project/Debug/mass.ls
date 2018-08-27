   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.8 - 03 Dec 2008
  34                     ; 7 void Mass_Deinit(void){
  36                     	switch	.text
  37  0000               _Mass_Deinit:
  41                     ; 8 	Mass_Para.Mass_Mode=M_MODE_1;		// 模式归0
  43  0000 3f00          	clr	_Mass_Para
  44                     ; 9 	Mass_Para.FreCnt=0;
  46  0002 3f09          	clr	_Mass_Para+9
  47                     ; 10 	Mass_Para.SwitchCnt=0;
  49  0004 5f            	clrw	x
  50  0005 bf06          	ldw	_Mass_Para+6,x
  51                     ; 11 	Mass_Para.MassFlag = FALSE;
  53  0007 3f0a          	clr	_Mass_Para+10
  54                     ; 12 	M1_WriteLow();
  56  0009 4b08          	push	#8
  57  000b ae5005        	ldw	x,#20485
  58  000e cd0000        	call	_GPIO_WriteLow
  60  0011 84            	pop	a
  61                     ; 13 	M2_WriteLow();
  64  0012 4b04          	push	#4
  65  0014 ae5005        	ldw	x,#20485
  66  0017 cd0000        	call	_GPIO_WriteLow
  68  001a 84            	pop	a
  69                     ; 14 }
  73  001b 81            	ret
  76                     	bsct
  77  0000               L12_Mode1_Cnt:
  78  0000 00            	dc.b	0
  79  0001               L32_Mode2_Cnt:
  80  0001 00            	dc.b	0
  81  0002               L52_Mode3_Cnt:
  82  0002 00            	dc.b	0
 133                     .const:	section	.text
 134  0000               L01:
 135  0000 0000ea61      	dc.l	60001
 136                     ; 18 void Mass_Handle(void)
 136                     ; 19 {
 137                     	switch	.text
 138  001c               _Mass_Handle:
 142                     ; 24 	Mass_Para.SwitchCntFlag=TRUE;
 144  001c 35010005      	mov	_Mass_Para+5,#1
 145                     ; 25 	Mass_Para.MassFlag = TRUE;
 147  0020 3501000a      	mov	_Mass_Para+10,#1
 148                     ; 27 	if(Mass_Para.SwitchCnt>M_SWITCH_VALUES)
 150  0024 9c            	rvf
 151  0025 be06          	ldw	x,_Mass_Para+6
 152  0027 cd0000        	call	c_uitolx
 154  002a ae0000        	ldw	x,#L01
 155  002d cd0000        	call	c_lcmp
 157  0030 2f10          	jrslt	L56
 158                     ; 29 		Mass_Para.SwitchCnt=0;
 160  0032 5f            	clrw	x
 161  0033 bf06          	ldw	_Mass_Para+6,x
 162                     ; 30 		Mass_Para.TimeCnt=0;		// 更换模式要清下0
 164  0035 5f            	clrw	x
 165  0036 bf01          	ldw	_Mass_Para+1,x
 166                     ; 31 		if(Mass_Para.Mass_Mode++>M_MODE_3)
 168  0038 b600          	ld	a,_Mass_Para
 169  003a 3c00          	inc	_Mass_Para
 170  003c a103          	cp	a,#3
 171  003e 2502          	jrult	L56
 172                     ; 33 			Mass_Para.Mass_Mode=M_MODE_1;
 174  0040 3f00          	clr	_Mass_Para
 175  0042               L56:
 176                     ; 37 	switch(Mass_Para.Mass_Mode)
 178  0042 b600          	ld	a,_Mass_Para
 180                     ; 110 			break;
 181  0044 4d            	tnz	a
 182  0045 270b          	jreq	L72
 183  0047 4a            	dec	a
 184  0048 274a          	jreq	L13
 185  004a 4a            	dec	a
 186  004b 276b          	jreq	L33
 187  004d               L53:
 188                     ; 109 			Mass_Para.Mass_Mode=M_MODE_1;
 190  004d 3f00          	clr	_Mass_Para
 191                     ; 110 			break;
 193  004f cc00da        	jra	L37
 194  0052               L72:
 195                     ; 41 			Mass_Para.TimeCntFlag=TRUE;
 197  0052 35010003      	mov	_Mass_Para+3,#1
 198                     ; 42 			if(Mass_Para.TimeCnt>M_500MS)
 200  0056 be01          	ldw	x,_Mass_Para+1
 201  0058 a301f5        	cpw	x,#501
 202  005b 257d          	jrult	L37
 203                     ; 44 				Mass_Para.TimeCnt=0;
 205  005d 5f            	clrw	x
 206  005e bf01          	ldw	_Mass_Para+1,x
 207                     ; 46 				if(Mode1_Cnt++>3)
 209  0060 b600          	ld	a,L12_Mode1_Cnt
 210  0062 3c00          	inc	L12_Mode1_Cnt
 211  0064 a104          	cp	a,#4
 212  0066 2504          	jrult	L77
 213                     ; 47 					Mode1_Cnt=1;
 215  0068 35010000      	mov	L12_Mode1_Cnt,#1
 216  006c               L77:
 217                     ; 49 				if(Mode1_Cnt==1)
 219  006c b600          	ld	a,L12_Mode1_Cnt
 220  006e a101          	cp	a,#1
 221  0070 2608          	jrne	L101
 222                     ; 51 					Mass_Para.MotoA_Status=TRUE;
 224  0072 3501000b      	mov	_Mass_Para+11,#1
 225                     ; 52 					Mass_Para.MotoB_Status=FALSE;
 227  0076 3f0c          	clr	_Mass_Para+12
 229  0078 2060          	jra	L37
 230  007a               L101:
 231                     ; 54 				else if(Mode1_Cnt==2)
 233  007a b600          	ld	a,L12_Mode1_Cnt
 234  007c a102          	cp	a,#2
 235  007e 2608          	jrne	L501
 236                     ; 56 					Mass_Para.MotoA_Status=FALSE;
 238  0080 3f0b          	clr	_Mass_Para+11
 239                     ; 57 					Mass_Para.MotoB_Status=TRUE;
 241  0082 3501000c      	mov	_Mass_Para+12,#1
 243  0086 2052          	jra	L37
 244  0088               L501:
 245                     ; 59 				else if(Mode1_Cnt==3)
 247  0088 b600          	ld	a,L12_Mode1_Cnt
 248  008a a103          	cp	a,#3
 249  008c 264c          	jrne	L37
 250                     ; 61 					Mass_Para.MotoA_Status=FALSE;
 252  008e 3f0b          	clr	_Mass_Para+11
 253                     ; 62 					Mass_Para.MotoB_Status=FALSE;
 255  0090 3f0c          	clr	_Mass_Para+12
 256  0092 2046          	jra	L37
 257  0094               L13:
 258                     ; 69 			Mass_Para.TimeCntFlag=TRUE;
 260  0094 35010003      	mov	_Mass_Para+3,#1
 261                     ; 70 			if(Mass_Para.TimeCnt>M_1S)
 263  0098 be01          	ldw	x,_Mass_Para+1
 264  009a a303e9        	cpw	x,#1001
 265  009d 253b          	jrult	L37
 266                     ; 72 				Mass_Para.TimeCnt=0;
 268  009f 5f            	clrw	x
 269  00a0 bf01          	ldw	_Mass_Para+1,x
 270                     ; 73 				Mode2_Cnt=~Mode2_Cnt;
 272  00a2 3301          	cpl	L32_Mode2_Cnt
 273                     ; 74 				if(Mode2_Cnt)
 275  00a4 3d01          	tnz	L32_Mode2_Cnt
 276  00a6 2708          	jreq	L511
 277                     ; 76 					Mass_Para.MotoA_Status=TRUE;
 279  00a8 3501000b      	mov	_Mass_Para+11,#1
 280                     ; 77 					Mass_Para.MotoB_Status=FALSE;
 282  00ac 3f0c          	clr	_Mass_Para+12
 284  00ae 202a          	jra	L37
 285  00b0               L511:
 286                     ; 81 					Mass_Para.MotoA_Status=FALSE;
 288  00b0 3f0b          	clr	_Mass_Para+11
 289                     ; 82 					Mass_Para.MotoB_Status=TRUE;	
 291  00b2 3501000c      	mov	_Mass_Para+12,#1
 292  00b6 2022          	jra	L37
 293  00b8               L33:
 294                     ; 89 			Mass_Para.TimeCntFlag=TRUE;
 296  00b8 35010003      	mov	_Mass_Para+3,#1
 297                     ; 90 			if(Mass_Para.TimeCnt>M_500MS)
 299  00bc be01          	ldw	x,_Mass_Para+1
 300  00be a301f5        	cpw	x,#501
 301  00c1 2517          	jrult	L37
 302                     ; 92 				Mass_Para.TimeCnt=0;
 304  00c3 5f            	clrw	x
 305  00c4 bf01          	ldw	_Mass_Para+1,x
 306                     ; 93 				Mode3_Cnt=~Mode3_Cnt;
 308  00c6 3302          	cpl	L52_Mode3_Cnt
 309                     ; 94 				if(Mode3_Cnt)
 311  00c8 3d02          	tnz	L52_Mode3_Cnt
 312  00ca 270a          	jreq	L321
 313                     ; 96 					Mass_Para.MotoA_Status=TRUE;
 315  00cc 3501000b      	mov	_Mass_Para+11,#1
 316                     ; 97 					Mass_Para.MotoB_Status=TRUE;	
 318  00d0 3501000c      	mov	_Mass_Para+12,#1
 320  00d4 2004          	jra	L37
 321  00d6               L321:
 322                     ; 101 					Mass_Para.MotoA_Status=FALSE;
 324  00d6 3f0b          	clr	_Mass_Para+11
 325                     ; 102 					Mass_Para.MotoB_Status=FALSE;	
 327  00d8 3f0c          	clr	_Mass_Para+12
 328  00da               L37:
 329                     ; 113 }
 332  00da 81            	ret
 335                     	bsct
 336  0003               L721_cnt:
 337  0003 0000          	dc.w	0
 372                     	switch	.const
 373  0004               L41:
 374  0004 0000ea60      	dc.l	60000
 375                     ; 118 void MassTimeHandle(void)
 375                     ; 119 {
 376                     	switch	.text
 377  00db               _MassTimeHandle:
 381                     ; 122 	if(Mass_Para.TimeCntFlag)
 383  00db 3d03          	tnz	_Mass_Para+3
 384  00dd 2707          	jreq	L741
 385                     ; 123 		Mass_Para.TimeCnt++;
 387  00df be01          	ldw	x,_Mass_Para+1
 388  00e1 1c0001        	addw	x,#1
 389  00e4 bf01          	ldw	_Mass_Para+1,x
 390  00e6               L741:
 391                     ; 125 	if(Mass_Para.SwitchCntFlag)
 393  00e6 3d05          	tnz	_Mass_Para+5
 394  00e8 2707          	jreq	L151
 395                     ; 126 		Mass_Para.SwitchCnt++;
 397  00ea be06          	ldw	x,_Mass_Para+6
 398  00ec 1c0001        	addw	x,#1
 399  00ef bf06          	ldw	_Mass_Para+6,x
 400  00f1               L151:
 401                     ; 131 	if(Mass_Para.MassFlag)		// 在按摩模式，要进行频率设置
 403  00f1 3d0a          	tnz	_Mass_Para+10
 404  00f3 2754          	jreq	L351
 405                     ; 133 		Mass_Para.FreCnt++;
 407  00f5 3c09          	inc	_Mass_Para+9
 408                     ; 135 		if(Mass_Para.FreCnt<7)
 410  00f7 b609          	ld	a,_Mass_Para+9
 411  00f9 a107          	cp	a,#7
 412  00fb 2432          	jruge	L551
 413                     ; 137 			if(Mass_Para.MotoA_Status)
 415  00fd 3d0b          	tnz	_Mass_Para+11
 416  00ff 270b          	jreq	L751
 417                     ; 139 				M1_WriteHigh();
 419  0101 4b08          	push	#8
 420  0103 ae5005        	ldw	x,#20485
 421  0106 cd0000        	call	_GPIO_WriteHigh
 423  0109 84            	pop	a
 426  010a 2009          	jra	L161
 427  010c               L751:
 428                     ; 143 				M1_WriteLow();
 430  010c 4b08          	push	#8
 431  010e ae5005        	ldw	x,#20485
 432  0111 cd0000        	call	_GPIO_WriteLow
 434  0114 84            	pop	a
 435  0115               L161:
 436                     ; 145 			if(Mass_Para.MotoB_Status)
 438  0115 3d0c          	tnz	_Mass_Para+12
 439  0117 270b          	jreq	L361
 440                     ; 147 				M2_WriteHigh();
 442  0119 4b04          	push	#4
 443  011b ae5005        	ldw	x,#20485
 444  011e cd0000        	call	_GPIO_WriteHigh
 446  0121 84            	pop	a
 449  0122 2025          	jra	L351
 450  0124               L361:
 451                     ; 151 				M2_WriteLow();
 453  0124 4b04          	push	#4
 454  0126 ae5005        	ldw	x,#20485
 455  0129 cd0000        	call	_GPIO_WriteLow
 457  012c 84            	pop	a
 459  012d 201a          	jra	L351
 460  012f               L551:
 461                     ; 154 		else if(Mass_Para.FreCnt>11)
 463  012f b609          	ld	a,_Mass_Para+9
 464  0131 a10c          	cp	a,#12
 465  0133 2514          	jrult	L351
 466                     ; 156 			M1_WriteLow();
 468  0135 4b08          	push	#8
 469  0137 ae5005        	ldw	x,#20485
 470  013a cd0000        	call	_GPIO_WriteLow
 472  013d 84            	pop	a
 473                     ; 157 			M2_WriteLow();
 476  013e 4b04          	push	#4
 477  0140 ae5005        	ldw	x,#20485
 478  0143 cd0000        	call	_GPIO_WriteLow
 480  0146 84            	pop	a
 481                     ; 158 			Mass_Para.FreCnt=0;
 484  0147 3f09          	clr	_Mass_Para+9
 485  0149               L351:
 486                     ; 164 	if(Mass_Para.AutoCloseCntFlag)
 488  0149 3d0f          	tnz	_Mass_Para+15
 489  014b 2729          	jreq	L371
 490                     ; 166 		if(cnt++>1000)		// 1S
 492  014d be03          	ldw	x,L721_cnt
 493  014f 1c0001        	addw	x,#1
 494  0152 bf03          	ldw	L721_cnt,x
 495  0154 1d0001        	subw	x,#1
 496  0157 a303e9        	cpw	x,#1001
 497  015a 251d          	jrult	L102
 498                     ; 168 			cnt=0;
 500  015c 5f            	clrw	x
 501  015d bf03          	ldw	L721_cnt,x
 502                     ; 169 			if(Mass_Para.AutoCloseCnt<60000)
 504  015f 9c            	rvf
 505  0160 be0d          	ldw	x,_Mass_Para+13
 506  0162 cd0000        	call	c_uitolx
 508  0165 ae0004        	ldw	x,#L41
 509  0168 cd0000        	call	c_lcmp
 511  016b 2e0c          	jrsge	L102
 512                     ; 170 				Mass_Para.AutoCloseCnt++;
 514  016d be0d          	ldw	x,_Mass_Para+13
 515  016f 1c0001        	addw	x,#1
 516  0172 bf0d          	ldw	_Mass_Para+13,x
 517  0174 2003          	jra	L102
 518  0176               L371:
 519                     ; 174 		cnt=0;
 521  0176 5f            	clrw	x
 522  0177 bf03          	ldw	L721_cnt,x
 523  0179               L102:
 524                     ; 175 }
 527  0179 81            	ret
 687                     	switch	.ubsct
 688  0000               _Mass_Para:
 689  0000 000000000000  	ds.b	16
 690                     	xdef	_Mass_Para
 691                     	xdef	_Mass_Deinit
 692                     	xdef	_MassTimeHandle
 693                     	xdef	_Mass_Handle
 694                     	xref	_GPIO_WriteLow
 695                     	xref	_GPIO_WriteHigh
 715                     	xref	c_lcmp
 716                     	xref	c_uitolx
 717                     	end
