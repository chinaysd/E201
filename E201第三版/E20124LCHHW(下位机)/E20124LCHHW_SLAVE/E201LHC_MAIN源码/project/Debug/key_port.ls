   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.8 - 03 Dec 2008
  44                     ; 11 u8 Key_Port_Read(u8 num){
  46                     	switch	.text
  47  0000               _Key_Port_Read:
  49  0000 88            	push	a
  50       00000000      OFST:	set	0
  53                     ; 12 	if(num == 1){
  55  0001 a101          	cp	a,#1
  56  0003 260d          	jrne	L72
  57                     ; 13 		return GPIO_ReadInputPin(SW1_PORT, SW1_PIN);
  59  0005 4b40          	push	#64
  60  0007 ae500a        	ldw	x,#20490
  61  000a cd0000        	call	_GPIO_ReadInputPin
  63  000d 5b01          	addw	sp,#1
  66  000f 5b01          	addw	sp,#1
  67  0011 81            	ret
  68  0012               L72:
  69                     ; 14 	}else if(num == 2){
  71  0012 7b01          	ld	a,(OFST+1,sp)
  72  0014 a102          	cp	a,#2
  73  0016 260d          	jrne	L33
  74                     ; 15 		return GPIO_ReadInputPin(SW2_PORT, SW2_PIN);
  76  0018 4b80          	push	#128
  77  001a ae500a        	ldw	x,#20490
  78  001d cd0000        	call	_GPIO_ReadInputPin
  80  0020 5b01          	addw	sp,#1
  83  0022 5b01          	addw	sp,#1
  84  0024 81            	ret
  85  0025               L33:
  86                     ; 17 		return 0;
  88  0025 4f            	clr	a
  91  0026 5b01          	addw	sp,#1
  92  0028 81            	ret
 116                     ; 21 u8 Key_Port_Init(void){
 117                     	switch	.text
 118  0029               _Key_Port_Init:
 122                     ; 22 	GPIO_Init(SW1_PORT, SW1_PIN, GPIO_MODE_IN_PU_NO_IT);
 124  0029 4b40          	push	#64
 125  002b 4b40          	push	#64
 126  002d ae500a        	ldw	x,#20490
 127  0030 cd0000        	call	_GPIO_Init
 129  0033 85            	popw	x
 130                     ; 23 	GPIO_Init(SW2_PORT, SW2_PIN, GPIO_MODE_IN_PU_NO_IT); 
 132  0034 4b40          	push	#64
 133  0036 4b80          	push	#128
 134  0038 ae500a        	ldw	x,#20490
 135  003b cd0000        	call	_GPIO_Init
 137  003e 85            	popw	x
 138                     ; 24 	return 1;
 140  003f a601          	ld	a,#1
 143  0041 81            	ret
 156                     	xdef	_Key_Port_Init
 157                     	xdef	_Key_Port_Read
 158                     	xref	_GPIO_ReadInputPin
 159                     	xref	_GPIO_Init
 178                     	end
