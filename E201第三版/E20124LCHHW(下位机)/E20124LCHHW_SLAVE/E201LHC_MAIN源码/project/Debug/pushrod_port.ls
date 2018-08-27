   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.8 - 03 Dec 2008
  46                     ; 24 u8 Pushrod_Port_Init(u8 ID){
  48                     	switch	.text
  49  0000               _Pushrod_Port_Init:
  51  0000 88            	push	a
  52       00000000      OFST:	set	0
  55                     ; 25 	if(ID == 0){
  57  0001 4d            	tnz	a
  58  0002 262a          	jrne	L72
  59                     ; 26 		GPIO_Init(PUSH1A_PORT, PUSH1A_PIN, GPIO_MODE_OUT_PP_HIGH_FAST);
  61  0004 4bf0          	push	#240
  62  0006 4b20          	push	#32
  63  0008 ae500a        	ldw	x,#20490
  64  000b cd0000        	call	_GPIO_Init
  66  000e 85            	popw	x
  67                     ; 27 		PUSH1A_Set(0);
  69  000f 4b20          	push	#32
  70  0011 ae500a        	ldw	x,#20490
  71  0014 cd0000        	call	_GPIO_WriteLow
  73  0017 84            	pop	a
  74                     ; 28 		GPIO_Init(PUSH1B_PORT, PUSH1B_PIN, GPIO_MODE_OUT_PP_HIGH_FAST);
  76  0018 4bf0          	push	#240
  77  001a 4b10          	push	#16
  78  001c ae500a        	ldw	x,#20490
  79  001f cd0000        	call	_GPIO_Init
  81  0022 85            	popw	x
  82                     ; 29 		PUSH1B_Set(0);
  84  0023 4b10          	push	#16
  85  0025 ae500a        	ldw	x,#20490
  86  0028 cd0000        	call	_GPIO_WriteLow
  88  002b 84            	pop	a
  90  002c 202e          	jra	L13
  91  002e               L72:
  92                     ; 30 	}else if(ID == 1){
  94  002e 7b01          	ld	a,(OFST+1,sp)
  95  0030 a101          	cp	a,#1
  96  0032 262d          	jrne	L33
  97                     ; 31 		GPIO_Init(PUSH2A_PORT, PUSH2A_PIN, GPIO_MODE_OUT_PP_HIGH_FAST);
  99  0034 4bf0          	push	#240
 100  0036 4b08          	push	#8
 101  0038 ae500a        	ldw	x,#20490
 102  003b cd0000        	call	_GPIO_Init
 104  003e 85            	popw	x
 105                     ; 32 		PUSH2A_Set(0);
 107  003f 4b08          	push	#8
 108  0041 ae500a        	ldw	x,#20490
 109  0044 cd0000        	call	_GPIO_WriteLow
 111  0047 84            	pop	a
 112                     ; 33 		GPIO_Init(PUSH2B_PORT, PUSH2B_PIN, GPIO_MODE_OUT_PP_HIGH_FAST);
 114  0048 4bf0          	push	#240
 115  004a 4b04          	push	#4
 116  004c ae500a        	ldw	x,#20490
 117  004f cd0000        	call	_GPIO_Init
 119  0052 85            	popw	x
 120                     ; 34 		PUSH2B_Set(0);
 122  0053 4b04          	push	#4
 123  0055 ae500a        	ldw	x,#20490
 124  0058 cd0000        	call	_GPIO_WriteLow
 126  005b 84            	pop	a
 128  005c               L13:
 129                     ; 38 	return 1;
 131  005c a601          	ld	a,#1
 134  005e 5b01          	addw	sp,#1
 135  0060 81            	ret
 136  0061               L33:
 137                     ; 36 		return 0;
 139  0061 4f            	clr	a
 142  0062 5b01          	addw	sp,#1
 143  0064 81            	ret
 188                     ; 48 u8 Pushrod_Port_Set(u8 ID,u8 Status){
 189                     	switch	.text
 190  0065               _Pushrod_Port_Set:
 192  0065 89            	pushw	x
 193       00000000      OFST:	set	0
 196                     ; 49 	if(ID == 0){
 198  0066 9e            	ld	a,xh
 199  0067 4d            	tnz	a
 200  0068 2650          	jrne	L16
 201                     ; 50 		if(Status == 0){
 203  006a 9f            	ld	a,xl
 204  006b 4d            	tnz	a
 205  006c 2615          	jrne	L36
 206                     ; 51 			PUSH1A_Set(0),PUSH1B_Set(0);
 208  006e 4b20          	push	#32
 209  0070 ae500a        	ldw	x,#20490
 210  0073 cd0000        	call	_GPIO_WriteLow
 212  0076 84            	pop	a
 213  0077 4b10          	push	#16
 214  0079 ae500a        	ldw	x,#20490
 215  007c cd0000        	call	_GPIO_WriteLow
 217  007f 84            	pop	a
 219  0080 cc010a        	jra	L77
 220  0083               L36:
 221                     ; 52 		}else if(Status == 1){
 223  0083 7b02          	ld	a,(OFST+2,sp)
 224  0085 a101          	cp	a,#1
 225  0087 2614          	jrne	L76
 226                     ; 53 			PUSH1A_Set(0),PUSH1B_Set(1);
 228  0089 4b20          	push	#32
 229  008b ae500a        	ldw	x,#20490
 230  008e cd0000        	call	_GPIO_WriteLow
 232  0091 84            	pop	a
 233  0092 4b10          	push	#16
 234  0094 ae500a        	ldw	x,#20490
 235  0097 cd0000        	call	_GPIO_WriteHigh
 237  009a 84            	pop	a
 239  009b 206d          	jra	L77
 240  009d               L76:
 241                     ; 54 		}else if(Status == 2){
 243  009d 7b02          	ld	a,(OFST+2,sp)
 244  009f a102          	cp	a,#2
 245  00a1 2614          	jrne	L37
 246                     ; 55 			PUSH1A_Set(1),PUSH1B_Set(0);
 248  00a3 4b20          	push	#32
 249  00a5 ae500a        	ldw	x,#20490
 250  00a8 cd0000        	call	_GPIO_WriteHigh
 252  00ab 84            	pop	a
 253  00ac 4b10          	push	#16
 254  00ae ae500a        	ldw	x,#20490
 255  00b1 cd0000        	call	_GPIO_WriteLow
 257  00b4 84            	pop	a
 259  00b5 2053          	jra	L77
 260  00b7               L37:
 261                     ; 57 			return 0;
 263  00b7 4f            	clr	a
 265  00b8 2052          	jra	L01
 266  00ba               L16:
 267                     ; 59 	}else if(ID == 1){
 269  00ba 7b01          	ld	a,(OFST+1,sp)
 270  00bc a101          	cp	a,#1
 271  00be 2651          	jrne	L101
 272                     ; 60 		if(Status == 0){
 274  00c0 0d02          	tnz	(OFST+2,sp)
 275  00c2 2614          	jrne	L301
 276                     ; 61 			PUSH2A_Set(0),PUSH2B_Set(0);
 278  00c4 4b08          	push	#8
 279  00c6 ae500a        	ldw	x,#20490
 280  00c9 cd0000        	call	_GPIO_WriteLow
 282  00cc 84            	pop	a
 283  00cd 4b04          	push	#4
 284  00cf ae500a        	ldw	x,#20490
 285  00d2 cd0000        	call	_GPIO_WriteLow
 287  00d5 84            	pop	a
 289  00d6 2032          	jra	L77
 290  00d8               L301:
 291                     ; 62 		}else if(Status == 1){
 293  00d8 7b02          	ld	a,(OFST+2,sp)
 294  00da a101          	cp	a,#1
 295  00dc 2614          	jrne	L701
 296                     ; 63 			PUSH2A_Set(0),PUSH2B_Set(1);
 298  00de 4b08          	push	#8
 299  00e0 ae500a        	ldw	x,#20490
 300  00e3 cd0000        	call	_GPIO_WriteLow
 302  00e6 84            	pop	a
 303  00e7 4b04          	push	#4
 304  00e9 ae500a        	ldw	x,#20490
 305  00ec cd0000        	call	_GPIO_WriteHigh
 307  00ef 84            	pop	a
 309  00f0 2018          	jra	L77
 310  00f2               L701:
 311                     ; 64 		}else if(Status == 2){
 313  00f2 7b02          	ld	a,(OFST+2,sp)
 314  00f4 a102          	cp	a,#2
 315  00f6 2616          	jrne	L311
 316                     ; 65 			PUSH2A_Set(1),PUSH2B_Set(0);
 318  00f8 4b08          	push	#8
 319  00fa ae500a        	ldw	x,#20490
 320  00fd cd0000        	call	_GPIO_WriteHigh
 322  0100 84            	pop	a
 323  0101 4b04          	push	#4
 324  0103 ae500a        	ldw	x,#20490
 325  0106 cd0000        	call	_GPIO_WriteLow
 327  0109 84            	pop	a
 329  010a               L77:
 330                     ; 72 	return 1;
 332  010a a601          	ld	a,#1
 334  010c               L01:
 336  010c 85            	popw	x
 337  010d 81            	ret
 338  010e               L311:
 339                     ; 67 			return 0;
 341  010e 4f            	clr	a
 343  010f 20fb          	jra	L01
 344  0111               L101:
 345                     ; 70 		return 0;
 347  0111 4f            	clr	a
 349  0112 20f8          	jra	L01
 362                     	xdef	_Pushrod_Port_Set
 363                     	xdef	_Pushrod_Port_Init
 364                     	xref	_GPIO_WriteLow
 365                     	xref	_GPIO_WriteHigh
 366                     	xref	_GPIO_Init
 385                     	end
