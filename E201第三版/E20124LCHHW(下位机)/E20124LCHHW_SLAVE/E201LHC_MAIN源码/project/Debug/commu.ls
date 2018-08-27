   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.8 - 03 Dec 2008
   4                     	xref	_Serial_Port_Init
  34                     ; 3 unsigned char Commu_Init(void){
  36                     	switch	.text
  37  0000               _Commu_Init:
  41                     ; 6 	return Serial_Port_Init(1,(unsigned long)9600);
  43  0000 ae2580        	ldw	x,#9600
  44  0003 89            	pushw	x
  45  0004 ae0000        	ldw	x,#0
  46  0007 89            	pushw	x
  47  0008 a601          	ld	a,#1
  48  000a cd0000        	call	_Serial_Port_Init
  50  000d 5b04          	addw	sp,#4
  53  000f 81            	ret
  56                     	xref	_Serial_SentByte
 184                     ; 9 unsigned char Commu_Sent(COMMU_BUF_t *p){
 185                     	switch	.text
 186  0010               _Commu_Sent:
 188  0010 89            	pushw	x
 189  0011 88            	push	a
 190       00000001      OFST:	set	1
 193                     ; 12 	for(i = 0;i < BUF_SIZE;i ++)
 195  0012 0f01          	clr	(OFST+0,sp)
 196  0014               L301:
 197                     ; 13 		Serial_SentByte(p->Buf[i]);
 199  0014 7b02          	ld	a,(OFST+1,sp)
 200  0016 97            	ld	xl,a
 201  0017 7b03          	ld	a,(OFST+2,sp)
 202  0019 1b01          	add	a,(OFST+0,sp)
 203  001b 2401          	jrnc	L01
 204  001d 5c            	incw	x
 205  001e               L01:
 206  001e 02            	rlwa	x,a
 207  001f f6            	ld	a,(x)
 208  0020 cd0000        	call	_Serial_SentByte
 210                     ; 12 	for(i = 0;i < BUF_SIZE;i ++)
 212  0023 0c01          	inc	(OFST+0,sp)
 215  0025 7b01          	ld	a,(OFST+0,sp)
 216  0027 a107          	cp	a,#7
 217  0029 25e9          	jrult	L301
 218                     ; 14 	return 1;
 220  002b a601          	ld	a,#1
 223  002d 5b03          	addw	sp,#3
 224  002f 81            	ret
 237                     	xdef	_Commu_Sent
 238                     	xdef	_Commu_Init
 257                     	end
