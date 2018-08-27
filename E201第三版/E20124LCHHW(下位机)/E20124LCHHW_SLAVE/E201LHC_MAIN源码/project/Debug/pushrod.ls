   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.8 - 03 Dec 2008
   4                     	xref	_Pushrod_Port_Init
 113                     ; 18 u8 Pushrod_APP_Init(Push_Para_t *p){
 115                     	switch	.text
 116  0000               _Pushrod_APP_Init:
 120                     ; 21 	return Pushrod_Port_Init(p->ID);
 122  0000 f6            	ld	a,(x)
 123  0001 cd0000        	call	_Pushrod_Port_Init
 127  0004 81            	ret
 130                     	xref	_Pushrod_Port_Set
 201                     ; 24 u8 Pushrod_Handle(Push_ID_t ID,Push_Status_t Status){
 202                     	switch	.text
 203  0005               _Pushrod_Handle:
 205  0005 89            	pushw	x
 206       00000000      OFST:	set	0
 209                     ; 27 	return Pushrod_Port_Set(ID,Status);
 211  0006 9f            	ld	a,xl
 212  0007 97            	ld	xl,a
 213  0008 7b01          	ld	a,(OFST+1,sp)
 214  000a 95            	ld	xh,a
 215  000b cd0000        	call	_Pushrod_Port_Set
 219  000e 85            	popw	x
 220  000f 81            	ret
 258                     ; 30 static u8 Pushrod_Open(Push_Para_t *p){
 259                     	switch	.text
 260  0010               L511_Pushrod_Open:
 262  0010 89            	pushw	x
 263       00000000      OFST:	set	0
 266                     ; 31 	if(p->ID > PUSHROD_NUM)
 268  0011 f6            	ld	a,(x)
 269  0012 a103          	cp	a,#3
 270  0014 2503          	jrult	L731
 271                     ; 32 		return 0;
 273  0016 4f            	clr	a
 275  0017 2016          	jra	L21
 276  0019               L731:
 277                     ; 33 	p->Push_Status= PUSH_OPEN;
 279  0019 1e01          	ldw	x,(OFST+1,sp)
 280  001b a601          	ld	a,#1
 281  001d e703          	ld	(3,x),a
 282                     ; 35 	p->IsRun = TRUE;
 284  001f 1e01          	ldw	x,(OFST+1,sp)
 285  0021 a601          	ld	a,#1
 286  0023 e702          	ld	(2,x),a
 287                     ; 37 	return Pushrod_Handle(p->ID, PUSH_OPEN);
 289  0025 ae0001        	ldw	x,#1
 290  0028 1601          	ldw	y,(OFST+1,sp)
 291  002a 90f6          	ld	a,(y)
 292  002c 95            	ld	xh,a
 293  002d add6          	call	_Pushrod_Handle
 296  002f               L21:
 298  002f 85            	popw	x
 299  0030 81            	ret
 337                     ; 40 static u8 Pushrod_Close(Push_Para_t *p){
 338                     	switch	.text
 339  0031               L141_Pushrod_Close:
 341  0031 89            	pushw	x
 342       00000000      OFST:	set	0
 345                     ; 41 	if(p->ID > PUSHROD_NUM)
 347  0032 f6            	ld	a,(x)
 348  0033 a103          	cp	a,#3
 349  0035 2503          	jrult	L361
 350                     ; 42 		return 0;
 352  0037 4f            	clr	a
 354  0038 2016          	jra	L61
 355  003a               L361:
 356                     ; 43 	p->Push_Status = PUSH_CLOSE;
 358  003a 1e01          	ldw	x,(OFST+1,sp)
 359  003c a602          	ld	a,#2
 360  003e e703          	ld	(3,x),a
 361                     ; 45 	p->IsRun = TRUE;
 363  0040 1e01          	ldw	x,(OFST+1,sp)
 364  0042 a601          	ld	a,#1
 365  0044 e702          	ld	(2,x),a
 366                     ; 47 	return Pushrod_Handle(p->ID, PUSH_CLOSE);
 368  0046 ae0002        	ldw	x,#2
 369  0049 1601          	ldw	y,(OFST+1,sp)
 370  004b 90f6          	ld	a,(y)
 371  004d 95            	ld	xh,a
 372  004e adb5          	call	_Pushrod_Handle
 375  0050               L61:
 377  0050 85            	popw	x
 378  0051 81            	ret
 416                     ; 50 static u8 Pushrod_Stop(Push_Para_t *p){
 417                     	switch	.text
 418  0052               L561_Pushrod_Stop:
 420  0052 89            	pushw	x
 421       00000000      OFST:	set	0
 424                     ; 51 	if(p->ID > PUSHROD_NUM)
 426  0053 f6            	ld	a,(x)
 427  0054 a103          	cp	a,#3
 428  0056 2503          	jrult	L702
 429                     ; 52 		return 0;
 431  0058 4f            	clr	a
 433  0059 2010          	jra	L22
 434  005b               L702:
 435                     ; 53 	p->Push_Status = PUSH_STOP;
 437  005b 1e01          	ldw	x,(OFST+1,sp)
 438  005d 6f03          	clr	(3,x)
 439                     ; 55 	p->IsRun = FALSE;
 441  005f 1e01          	ldw	x,(OFST+1,sp)
 442  0061 6f02          	clr	(2,x)
 443                     ; 57 	return Pushrod_Handle(p->ID, PUSH_STOP);
 445  0063 5f            	clrw	x
 446  0064 1601          	ldw	y,(OFST+1,sp)
 447  0066 90f6          	ld	a,(y)
 448  0068 95            	ld	xh,a
 449  0069 ad9a          	call	_Pushrod_Handle
 452  006b               L22:
 454  006b 85            	popw	x
 455  006c 81            	ret
 505                     ; 139 u8 Pushrod_APP_Handle(Push_Para_t *p,Push_Status_t Status){
 506                     	switch	.text
 507  006d               _Pushrod_APP_Handle:
 509  006d 89            	pushw	x
 510       00000000      OFST:	set	0
 513                     ; 140 	if(Status == PUSH_STOP){
 515  006e 0d05          	tnz	(OFST+5,sp)
 516  0070 2604          	jrne	L532
 517                     ; 141 		Pushrod_Stop(p);
 519  0072 adde          	call	L561_Pushrod_Stop
 522  0074 202f          	jra	L732
 523  0076               L532:
 524                     ; 142 	}else if(Status == PUSH_OPEN){
 526  0076 7b05          	ld	a,(OFST+5,sp)
 527  0078 a101          	cp	a,#1
 528  007a 2612          	jrne	L142
 529                     ; 144 		if(p->ReverseFlag){
 531  007c 1e01          	ldw	x,(OFST+1,sp)
 532  007e 6d01          	tnz	(1,x)
 533  0080 2706          	jreq	L342
 534                     ; 145 			Pushrod_Close(p);
 536  0082 1e01          	ldw	x,(OFST+1,sp)
 537  0084 adab          	call	L141_Pushrod_Close
 540  0086 201d          	jra	L732
 541  0088               L342:
 542                     ; 147 			Pushrod_Open(p);
 544  0088 1e01          	ldw	x,(OFST+1,sp)
 545  008a ad84          	call	L511_Pushrod_Open
 547  008c 2017          	jra	L732
 548  008e               L142:
 549                     ; 152 	}else if(Status == PUSH_CLOSE){
 551  008e 7b05          	ld	a,(OFST+5,sp)
 552  0090 a102          	cp	a,#2
 553  0092 2615          	jrne	L152
 554                     ; 154 		if(p->ReverseFlag){
 556  0094 1e01          	ldw	x,(OFST+1,sp)
 557  0096 6d01          	tnz	(1,x)
 558  0098 2707          	jreq	L352
 559                     ; 155 			Pushrod_Open(p);
 561  009a 1e01          	ldw	x,(OFST+1,sp)
 562  009c cd0010        	call	L511_Pushrod_Open
 565  009f 2004          	jra	L732
 566  00a1               L352:
 567                     ; 157 			Pushrod_Close(p);
 569  00a1 1e01          	ldw	x,(OFST+1,sp)
 570  00a3 ad8c          	call	L141_Pushrod_Close
 572  00a5               L732:
 573                     ; 166 	return 1;
 575  00a5 a601          	ld	a,#1
 577  00a7 2001          	jra	L62
 578  00a9               L152:
 579                     ; 163 		return 0;
 581  00a9 4f            	clr	a
 583  00aa               L62:
 585  00aa 85            	popw	x
 586  00ab 81            	ret
 623                     ; 171 unsigned char Pushrod_GetStatus(Push_Para_t *p){
 624                     	switch	.text
 625  00ac               _Pushrod_GetStatus:
 629                     ; 172 	return p->IsRun;
 631  00ac e602          	ld	a,(2,x)
 634  00ae 81            	ret
 682                     	switch	.ubsct
 683  0000               _Pushrod_Timer:
 684  0000 000000000000  	ds.b	16
 685                     	xdef	_Pushrod_Timer
 686                     	xdef	_Pushrod_Handle
 687                     	xdef	_Pushrod_GetStatus
 688                     	xdef	_Pushrod_APP_Handle
 689                     	xdef	_Pushrod_APP_Init
 709                     	end
