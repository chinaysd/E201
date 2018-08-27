   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.8 - 03 Dec 2008
   4                     	bsct
   5  0000               _InsBaseNum:
   6  0000 00000000      	dc.l	0
  36                     ; 6 void TimeOutDet_Init(void)
  36                     ; 7 {
  38                     	switch	.text
  39  0000               _TimeOutDet_Init:
  43                     ; 8 	InsBaseNum=0;
  45  0000 ae0000        	ldw	x,#0
  46  0003 bf02          	ldw	_InsBaseNum+2,x
  47  0005 ae0000        	ldw	x,#0
  48  0008 bf00          	ldw	_InsBaseNum,x
  49                     ; 9 }
  52  000a 81            	ret
  77                     ; 12 void TimeOutDet_DecHandle(void)
  77                     ; 13 {
  78                     	switch	.text
  79  000b               _TimeOutDet_DecHandle:
  83                     ; 14 	InsBaseNum++;
  85  000b ae0000        	ldw	x,#_InsBaseNum
  86  000e a601          	ld	a,#1
  87  0010 cd0000        	call	c_lgadc
  89                     ; 15 }
  92  0013 81            	ret
 116                     ; 17 clock_time_t TimeOut_BaseValue(void)
 116                     ; 18 {
 117                     	switch	.text
 118  0014               _TimeOut_BaseValue:
 122                     ; 19 	return InsBaseNum;
 124  0014 ae0000        	ldw	x,#_InsBaseNum
 125  0017 cd0000        	call	c_ltor
 129  001a 81            	ret
 197                     ; 24 void TimeOut_Record(TIMEOUT_PARA * TimeOutPara,clock_time_t timeoutvalue)
 197                     ; 25 
 197                     ; 26 {
 198                     	switch	.text
 199  001b               _TimeOut_Record:
 201  001b 89            	pushw	x
 202       00000000      OFST:	set	0
 205                     ; 27 	TimeOutPara->RecordValue=TimeOut_BaseValue();
 207  001c adf6          	call	_TimeOut_BaseValue
 209  001e 1e01          	ldw	x,(OFST+1,sp)
 210  0020 cd0000        	call	c_rtol
 212                     ; 28 	TimeOutPara->timeoutcnt=timeoutvalue;
 214  0023 1e01          	ldw	x,(OFST+1,sp)
 215  0025 7b08          	ld	a,(OFST+8,sp)
 216  0027 e707          	ld	(7,x),a
 217  0029 7b07          	ld	a,(OFST+7,sp)
 218  002b e706          	ld	(6,x),a
 219  002d 7b06          	ld	a,(OFST+6,sp)
 220  002f e705          	ld	(5,x),a
 221  0031 7b05          	ld	a,(OFST+5,sp)
 222  0033 e704          	ld	(4,x),a
 223                     ; 29 }
 226  0035 85            	popw	x
 227  0036 81            	ret
 265                     ; 32 void TimeOut_restart(TIMEOUT_PARA *TimeOutPara)
 265                     ; 33 {	
 266                     	switch	.text
 267  0037               _TimeOut_restart:
 269  0037 89            	pushw	x
 270       00000000      OFST:	set	0
 273                     ; 34 	TimeOutPara->RecordValue = TimeOut_BaseValue();
 275  0038 adda          	call	_TimeOut_BaseValue
 277  003a 1e01          	ldw	x,(OFST+1,sp)
 278  003c cd0000        	call	c_rtol
 280                     ; 35 }
 283  003f 85            	popw	x
 284  0040 81            	ret
 322                     ; 37 clock_time_t TimeOutDet_Check(TIMEOUT_PARA * TimeOutPara)
 322                     ; 38 {
 323                     	switch	.text
 324  0041               _TimeOutDet_Check:
 326  0041 89            	pushw	x
 327       00000000      OFST:	set	0
 330                     ; 39 	return (((clock_time_t)(InsBaseNum-TimeOutPara->RecordValue)>=TimeOutPara->timeoutcnt)?1:0);
 332  0042 ae0000        	ldw	x,#_InsBaseNum
 333  0045 cd0000        	call	c_ltor
 335  0048 1e01          	ldw	x,(OFST+1,sp)
 336  004a cd0000        	call	c_lsub
 338  004d 1e01          	ldw	x,(OFST+1,sp)
 339  004f 1c0004        	addw	x,#4
 340  0052 cd0000        	call	c_lcmp
 342  0055 2505          	jrult	L02
 343  0057 ae0001        	ldw	x,#1
 344  005a 2001          	jra	L22
 345  005c               L02:
 346  005c 5f            	clrw	x
 347  005d               L22:
 348  005d cd0000        	call	c_itolx
 352  0060 5b02          	addw	sp,#2
 353  0062 81            	ret
 377                     	xdef	_InsBaseNum
 378                     	xdef	_TimeOutDet_Check
 379                     	xdef	_TimeOut_restart
 380                     	xdef	_TimeOut_Record
 381                     	xdef	_TimeOut_BaseValue
 382                     	xdef	_TimeOutDet_DecHandle
 383                     	xdef	_TimeOutDet_Init
 402                     	xref	c_itolx
 403                     	xref	c_lcmp
 404                     	xref	c_lsub
 405                     	xref	c_rtol
 406                     	xref	c_ltor
 407                     	xref	c_lgadc
 408                     	end
