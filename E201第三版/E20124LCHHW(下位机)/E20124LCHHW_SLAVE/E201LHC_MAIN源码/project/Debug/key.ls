   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.8 - 03 Dec 2008
   4                     .const:	section	.text
   5  0000               L31_KeyEvent:
   6  0000 0000          	dc.w	0
   7  0002 0000          	dc.w	0
   8  0004 0000          	dc.w	0
   9  0006 0000          	dc.w	0
  10  0008 0000          	dc.w	0
  11  000a 0001          	dc.w	1
  12  000c 0002          	dc.w	2
  13  000e 0003          	dc.w	3
  14  0010 0000          	dc.w	0
  15  0012 0004          	dc.w	4
  16  0014 0005          	dc.w	5
  17  0016 0006          	dc.w	6
  18  0018 0007          	dc.w	7
  19  001a 0000          	dc.w	0
  20  001c 0008          	dc.w	8
  21  001e 0009          	dc.w	9
  22  0020 000a          	dc.w	10
  23  0022 000b          	dc.w	11
  24  0024 0000          	dc.w	0
  25  0026 000c          	dc.w	12
  26                     	xref	_Key_Port_Read
  76                     ; 38 static u8 GetKeyIndex(void)
  76                     ; 39 {
  78                     	switch	.text
  79  0000               L51_GetKeyIndex:
  81  0000 89            	pushw	x
  82       00000002      OFST:	set	2
  85                     ; 42 	u8 cnt=0,value=0;
  87  0001 0f01          	clr	(OFST-1,sp)
  90  0003 0f02          	clr	(OFST+0,sp)
  91                     ; 43 	if(Key_Port_Read(1) == 0)
  93  0005 a601          	ld	a,#1
  94  0007 cd0000        	call	_Key_Port_Read
  96  000a 4d            	tnz	a
  97  000b 2606          	jrne	L74
  98                     ; 44 		cnt++,value=1;
 100  000d 0c01          	inc	(OFST-1,sp)
 101  000f a601          	ld	a,#1
 102  0011 6b02          	ld	(OFST+0,sp),a
 103  0013               L74:
 104                     ; 45 	if(Key_Port_Read(2) == 0)
 106  0013 a602          	ld	a,#2
 107  0015 cd0000        	call	_Key_Port_Read
 109  0018 4d            	tnz	a
 110  0019 2606          	jrne	L15
 111                     ; 46 		cnt++,value=2;	
 113  001b 0c01          	inc	(OFST-1,sp)
 114  001d a602          	ld	a,#2
 115  001f 6b02          	ld	(OFST+0,sp),a
 116  0021               L15:
 117                     ; 47 	return ((cnt > 1) ? 3 : (value));	
 119  0021 7b01          	ld	a,(OFST-1,sp)
 120  0023 a102          	cp	a,#2
 121  0025 2504          	jrult	L6
 122  0027 a603          	ld	a,#3
 123  0029 2002          	jra	L01
 124  002b               L6:
 125  002b 7b02          	ld	a,(OFST+0,sp)
 126  002d               L01:
 129  002d 85            	popw	x
 130  002e 81            	ret
 133                     	xref	_Key_Port_Init
 158                     ; 53 void KEY_Init(void){
 159                     	switch	.text
 160  002f               _KEY_Init:
 164                     ; 56 	Key_Port_Init();
 166  002f cd0000        	call	_Key_Port_Init
 168                     ; 57 	KeyState=KEY_STATE_IDLE;
 170  0032 3f00          	clr	L11_KeyState
 171                     ; 58 	TimeOut_Record(&Key_Scan_Timer,0);
 173  0034 ae0000        	ldw	x,#0
 174  0037 89            	pushw	x
 175  0038 ae0000        	ldw	x,#0
 176  003b 89            	pushw	x
 177  003c ae0009        	ldw	x,#L5_Key_Scan_Timer
 178  003f cd0000        	call	_TimeOut_Record
 180  0042 5b04          	addw	sp,#4
 181                     ; 59 }
 184  0044 81            	ret
 187                     	bsct
 188  0000               L36_PreKeyIndex:
 189  0000 ff            	dc.b	255
 521                     ; 65 t_KEY_MSG KEY_Scan(void){
 522                     	switch	.text
 523  0045               _KEY_Scan:
 525  0045 88            	push	a
 526       00000001      OFST:	set	1
 529                     ; 69 	if(!(TimeOutDet_Check(&Key_Scan_Timer))){
 531  0046 ae0009        	ldw	x,#L5_Key_Scan_Timer
 532  0049 cd0000        	call	_TimeOutDet_Check
 534  004c cd0000        	call	c_lrzmp
 536  004f 2604          	jrne	L732
 537                     ; 70 		return MSG_KEY_NONE;
 539  0051 4f            	clr	a
 542  0052 5b01          	addw	sp,#1
 543  0054 81            	ret
 544  0055               L732:
 545                     ; 73 	TimeOut_Record(&Key_Scan_Timer,KEY_SCAN_TIME);
 547  0055 ae0014        	ldw	x,#20
 548  0058 89            	pushw	x
 549  0059 ae0000        	ldw	x,#0
 550  005c 89            	pushw	x
 551  005d ae0009        	ldw	x,#L5_Key_Scan_Timer
 552  0060 cd0000        	call	_TimeOut_Record
 554  0063 5b04          	addw	sp,#4
 555                     ; 75 	KeyIndex=GetKeyIndex();
 557  0065 ad99          	call	L51_GetKeyIndex
 559  0067 6b01          	ld	(OFST+0,sp),a
 560                     ; 77 	switch(KeyState){
 562  0069 b600          	ld	a,L11_KeyState
 564                     ; 125 			break;
 565  006b 4d            	tnz	a
 566  006c 2712          	jreq	L56
 567  006e 4a            	dec	a
 568  006f 2733          	jreq	L76
 569  0071 4a            	dec	a
 570  0072 276a          	jreq	L17
 571  0074 4a            	dec	a
 572  0075 2603          	jrne	L61
 573  0077 cc011d        	jp	L37
 574  007a               L61:
 575  007a               L57:
 576                     ; 124 			KeyState = KEY_STATE_IDLE;
 578  007a 3f00          	clr	L11_KeyState
 579                     ; 125 			break;
 581  007c ac580158      	jpf	L342
 582  0080               L56:
 583                     ; 79 			if(!KeyIndex){
 585  0080 0d01          	tnz	(OFST+0,sp)
 586  0082 2604          	jrne	L542
 587                     ; 80 				return MSG_KEY_NONE;
 589  0084 4f            	clr	a
 592  0085 5b01          	addw	sp,#1
 593  0087 81            	ret
 594  0088               L542:
 595                     ; 83 			PreKeyIndex = KeyIndex;
 597  0088 7b01          	ld	a,(OFST+0,sp)
 598  008a b700          	ld	L36_PreKeyIndex,a
 599                     ; 84 			TimeOut_Record(&Key_Wait_Timer,KEY_JITTER_TIME);
 601  008c ae0014        	ldw	x,#20
 602  008f 89            	pushw	x
 603  0090 ae0000        	ldw	x,#0
 604  0093 89            	pushw	x
 605  0094 ae0001        	ldw	x,#L7_Key_Wait_Timer
 606  0097 cd0000        	call	_TimeOut_Record
 608  009a 5b04          	addw	sp,#4
 609                     ; 85 			KeyState = KEY_STATE_JITTER;
 611  009c 35010000      	mov	L11_KeyState,#1
 612                     ; 86 			break;
 614  00a0 ac580158      	jpf	L342
 615  00a4               L76:
 616                     ; 90 			if(PreKeyIndex != KeyIndex){
 618  00a4 b600          	ld	a,L36_PreKeyIndex
 619  00a6 1101          	cp	a,(OFST+0,sp)
 620  00a8 2706          	jreq	L742
 621                     ; 91 				KeyState = KEY_STATE_IDLE;
 623  00aa 3f00          	clr	L11_KeyState
 625  00ac ac580158      	jpf	L342
 626  00b0               L742:
 627                     ; 92 			}else if(TimeOutDet_Check(&Key_Wait_Timer)){
 629  00b0 ae0001        	ldw	x,#L7_Key_Wait_Timer
 630  00b3 cd0000        	call	_TimeOutDet_Check
 632  00b6 cd0000        	call	c_lrzmp
 634  00b9 2603          	jrne	L02
 635  00bb cc0158        	jp	L342
 636  00be               L02:
 637                     ; 93 				TimeOut_Record(&Key_Wait_Timer,KEY_CP_TIME);
 639  00be ae05dc        	ldw	x,#1500
 640  00c1 89            	pushw	x
 641  00c2 ae0000        	ldw	x,#0
 642  00c5 89            	pushw	x
 643  00c6 ae0001        	ldw	x,#L7_Key_Wait_Timer
 644  00c9 cd0000        	call	_TimeOut_Record
 646  00cc 5b04          	addw	sp,#4
 647                     ; 94 				KeyState = KEY_STATE_PRESS_DOWN;
 649  00ce 35020000      	mov	L11_KeyState,#2
 650                     ; 95 				return KeyEvent[PreKeyIndex][0];
 652  00d2 b600          	ld	a,L36_PreKeyIndex
 653  00d4 97            	ld	xl,a
 654  00d5 a60a          	ld	a,#10
 655  00d7 42            	mul	x,a
 656  00d8 d60001        	ld	a,(L31_KeyEvent+1,x)
 659  00db 5b01          	addw	sp,#1
 660  00dd 81            	ret
 661  00de               L17:
 662                     ; 101 			if(PreKeyIndex != KeyIndex){
 664  00de b600          	ld	a,L36_PreKeyIndex
 665  00e0 1101          	cp	a,(OFST+0,sp)
 666  00e2 270e          	jreq	L552
 667                     ; 102 				KeyState = KEY_STATE_IDLE;
 669  00e4 3f00          	clr	L11_KeyState
 670                     ; 103 				return KeyEvent[PreKeyIndex][1];
 672  00e6 b600          	ld	a,L36_PreKeyIndex
 673  00e8 97            	ld	xl,a
 674  00e9 a60a          	ld	a,#10
 675  00eb 42            	mul	x,a
 676  00ec d60003        	ld	a,(L31_KeyEvent+3,x)
 679  00ef 5b01          	addw	sp,#1
 680  00f1 81            	ret
 681  00f2               L552:
 682                     ; 104 			}else if(TimeOutDet_Check(&Key_Wait_Timer)){
 684  00f2 ae0001        	ldw	x,#L7_Key_Wait_Timer
 685  00f5 cd0000        	call	_TimeOutDet_Check
 687  00f8 cd0000        	call	c_lrzmp
 689  00fb 275b          	jreq	L342
 690                     ; 105 				TimeOut_Record(&Key_Wait_Timer,KEY_CPH_TIME);
 692  00fd ae0640        	ldw	x,#1600
 693  0100 89            	pushw	x
 694  0101 ae0000        	ldw	x,#0
 695  0104 89            	pushw	x
 696  0105 ae0001        	ldw	x,#L7_Key_Wait_Timer
 697  0108 cd0000        	call	_TimeOut_Record
 699  010b 5b04          	addw	sp,#4
 700                     ; 106 				KeyState = KEY_STATE_CP;
 702  010d 35030000      	mov	L11_KeyState,#3
 703                     ; 107 				return KeyEvent[PreKeyIndex][2];
 705  0111 b600          	ld	a,L36_PreKeyIndex
 706  0113 97            	ld	xl,a
 707  0114 a60a          	ld	a,#10
 708  0116 42            	mul	x,a
 709  0117 d60005        	ld	a,(L31_KeyEvent+5,x)
 712  011a 5b01          	addw	sp,#1
 713  011c 81            	ret
 714  011d               L37:
 715                     ; 113 			if(PreKeyIndex != KeyIndex){
 717  011d b600          	ld	a,L36_PreKeyIndex
 718  011f 1101          	cp	a,(OFST+0,sp)
 719  0121 270e          	jreq	L362
 720                     ; 114 				KeyState = KEY_STATE_IDLE;
 722  0123 3f00          	clr	L11_KeyState
 723                     ; 115 				return KeyEvent[PreKeyIndex][4];
 725  0125 b600          	ld	a,L36_PreKeyIndex
 726  0127 97            	ld	xl,a
 727  0128 a60a          	ld	a,#10
 728  012a 42            	mul	x,a
 729  012b d60009        	ld	a,(L31_KeyEvent+9,x)
 732  012e 5b01          	addw	sp,#1
 733  0130 81            	ret
 734  0131               L362:
 735                     ; 116 			}else if(TimeOutDet_Check(&Key_Wait_Timer)){
 737  0131 ae0001        	ldw	x,#L7_Key_Wait_Timer
 738  0134 cd0000        	call	_TimeOutDet_Check
 740  0137 cd0000        	call	c_lrzmp
 742  013a 271c          	jreq	L342
 743                     ; 117 				TimeOut_Record(&Key_Wait_Timer,KEY_CPH_TIME);
 745  013c ae0640        	ldw	x,#1600
 746  013f 89            	pushw	x
 747  0140 ae0000        	ldw	x,#0
 748  0143 89            	pushw	x
 749  0144 ae0001        	ldw	x,#L7_Key_Wait_Timer
 750  0147 cd0000        	call	_TimeOut_Record
 752  014a 5b04          	addw	sp,#4
 753                     ; 118 				return KeyEvent[PreKeyIndex][3];
 755  014c b600          	ld	a,L36_PreKeyIndex
 756  014e 97            	ld	xl,a
 757  014f a60a          	ld	a,#10
 758  0151 42            	mul	x,a
 759  0152 d60007        	ld	a,(L31_KeyEvent+7,x)
 762  0155 5b01          	addw	sp,#1
 763  0157 81            	ret
 764  0158               L342:
 765                     ; 128 	return MSG_KEY_NONE;
 767  0158 4f            	clr	a
 770  0159 5b01          	addw	sp,#1
 771  015b 81            	ret
 893                     	switch	.ubsct
 894  0000               L11_KeyState:
 895  0000 00            	ds.b	1
 896  0001               L7_Key_Wait_Timer:
 897  0001 000000000000  	ds.b	8
 898  0009               L5_Key_Scan_Timer:
 899  0009 000000000000  	ds.b	8
 900  0011               L3_Read_Key_Timer:
 901  0011 000000000000  	ds.b	8
 902                     	xref	_TimeOutDet_Check
 903                     	xref	_TimeOut_Record
 904                     	xdef	_KEY_Scan
 905                     	xdef	_KEY_Init
 925                     	xref	c_lrzmp
 926                     	end
