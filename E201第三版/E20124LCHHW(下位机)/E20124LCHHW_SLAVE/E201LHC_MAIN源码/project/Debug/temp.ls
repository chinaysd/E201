   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.8 - 03 Dec 2008
   4                     	xref	_CH_Port_Adc_Init
 123                     ; 4 u16 Get_Temp(u8 ID){
 125                     	switch	.text
 126  0000               _Get_Temp:
 128  0000 5216          	subw	sp,#22
 129       00000016      OFST:	set	22
 132                     ; 10 	CH_Port_Adc_Init(ID);
 134  0002 cd0000        	call	_CH_Port_Adc_Init
 136                     ; 12 	for(i = 0;i < SCAN_NUM;i ++){
 138  0005 0f07          	clr	(OFST-15,sp)
 139  0007               L76:
 140                     ; 13 		s = 20;
 142  0007 a614          	ld	a,#20
 143  0009 6b16          	ld	(OFST+0,sp),a
 144                     ; 14 		ADC1_StartConversion();
 146  000b cd0000        	call	_ADC1_StartConversion
 148  000e               L57:
 149                     ; 16 			s1 = ADC1_GetFlagStatus(ADC1_FLAG_EOC);
 151  000e a680          	ld	a,#128
 152  0010 cd0000        	call	_ADC1_GetFlagStatus
 154  0013 5f            	clrw	x
 155  0014 97            	ld	xl,a
 156  0015 1f05          	ldw	(OFST-17,sp),x
 157                     ; 17 			s --;
 159  0017 0a16          	dec	(OFST+0,sp)
 160                     ; 19 		while((s1 == 0)&&(s != 0));
 162  0019 1e05          	ldw	x,(OFST-17,sp)
 163  001b 2604          	jrne	L301
 165  001d 0d16          	tnz	(OFST+0,sp)
 166  001f 26ed          	jrne	L57
 167  0021               L301:
 168                     ; 20 		if(s == 0)
 170  0021 0d16          	tnz	(OFST+0,sp)
 171  0023 2605          	jrne	L501
 172                     ; 21 			return 0;
 174  0025 5f            	clrw	x
 176  0026 acf700f7      	jpf	L6
 177  002a               L501:
 178                     ; 22 		temp[i] = ADC1_GetConversionValue();
 180  002a cd0000        	call	_ADC1_GetConversionValue
 182  002d 9096          	ldw	y,sp
 183  002f 72a90008      	addw	y,#OFST-14
 184  0033 1703          	ldw	(OFST-19,sp),y
 185  0035 7b07          	ld	a,(OFST-15,sp)
 186  0037 905f          	clrw	y
 187  0039 9097          	ld	yl,a
 188  003b 9058          	sllw	y
 189  003d 72f903        	addw	y,(OFST-19,sp)
 190  0040 90ff          	ldw	(y),x
 191                     ; 23 		ADC1_ClearFlag(ADC1_FLAG_EOC);
 193  0042 a680          	ld	a,#128
 194  0044 cd0000        	call	_ADC1_ClearFlag
 196                     ; 12 	for(i = 0;i < SCAN_NUM;i ++){
 198  0047 0c07          	inc	(OFST-15,sp)
 201  0049 7b07          	ld	a,(OFST-15,sp)
 202  004b a107          	cp	a,#7
 203  004d 25b8          	jrult	L76
 204                     ; 25 	ADC1_Cmd(DISABLE);		
 206  004f 4f            	clr	a
 207  0050 cd0000        	call	_ADC1_Cmd
 209                     ; 27 	for(j = 0;j < SCAN_NUM;j ++){
 211  0053 0f16          	clr	(OFST+0,sp)
 212  0055               L701:
 213                     ; 28 		for(k = j;k < SCAN_NUM;k ++) {
 215  0055 7b16          	ld	a,(OFST+0,sp)
 216  0057 6b07          	ld	(OFST-15,sp),a
 218  0059 2070          	jra	L121
 219  005b               L511:
 220                     ; 29 			if(temp[j] >= temp[k]) {
 222  005b 96            	ldw	x,sp
 223  005c 1c0008        	addw	x,#OFST-14
 224  005f 1f03          	ldw	(OFST-19,sp),x
 225  0061 7b16          	ld	a,(OFST+0,sp)
 226  0063 5f            	clrw	x
 227  0064 97            	ld	xl,a
 228  0065 58            	sllw	x
 229  0066 72fb03        	addw	x,(OFST-19,sp)
 230  0069 9096          	ldw	y,sp
 231  006b 72a90008      	addw	y,#OFST-14
 232  006f 1701          	ldw	(OFST-21,sp),y
 233  0071 7b07          	ld	a,(OFST-15,sp)
 234  0073 905f          	clrw	y
 235  0075 9097          	ld	yl,a
 236  0077 9058          	sllw	y
 237  0079 72f901        	addw	y,(OFST-21,sp)
 238  007c fe            	ldw	x,(x)
 239  007d 90f3          	cpw	x,(y)
 240  007f 2548          	jrult	L521
 241                     ; 30 				z = temp[j];   
 243  0081 96            	ldw	x,sp
 244  0082 1c0008        	addw	x,#OFST-14
 245  0085 1f03          	ldw	(OFST-19,sp),x
 246  0087 7b16          	ld	a,(OFST+0,sp)
 247  0089 5f            	clrw	x
 248  008a 97            	ld	xl,a
 249  008b 58            	sllw	x
 250  008c 72fb03        	addw	x,(OFST-19,sp)
 251  008f fe            	ldw	x,(x)
 252  0090 1f05          	ldw	(OFST-17,sp),x
 253                     ; 31 				temp[j] = temp[k];   
 255  0092 96            	ldw	x,sp
 256  0093 1c0008        	addw	x,#OFST-14
 257  0096 1f03          	ldw	(OFST-19,sp),x
 258  0098 7b07          	ld	a,(OFST-15,sp)
 259  009a 5f            	clrw	x
 260  009b 97            	ld	xl,a
 261  009c 58            	sllw	x
 262  009d 72fb03        	addw	x,(OFST-19,sp)
 263  00a0 9096          	ldw	y,sp
 264  00a2 72a90008      	addw	y,#OFST-14
 265  00a6 1701          	ldw	(OFST-21,sp),y
 266  00a8 7b16          	ld	a,(OFST+0,sp)
 267  00aa 905f          	clrw	y
 268  00ac 9097          	ld	yl,a
 269  00ae 9058          	sllw	y
 270  00b0 72f901        	addw	y,(OFST-21,sp)
 271  00b3 89            	pushw	x
 272  00b4 fe            	ldw	x,(x)
 273  00b5 90ff          	ldw	(y),x
 274  00b7 85            	popw	x
 275                     ; 32 				temp[k] = z;
 277  00b8 96            	ldw	x,sp
 278  00b9 1c0008        	addw	x,#OFST-14
 279  00bc 1f03          	ldw	(OFST-19,sp),x
 280  00be 7b07          	ld	a,(OFST-15,sp)
 281  00c0 5f            	clrw	x
 282  00c1 97            	ld	xl,a
 283  00c2 58            	sllw	x
 284  00c3 72fb03        	addw	x,(OFST-19,sp)
 285  00c6 1605          	ldw	y,(OFST-17,sp)
 286  00c8 ff            	ldw	(x),y
 287  00c9               L521:
 288                     ; 28 		for(k = j;k < SCAN_NUM;k ++) {
 290  00c9 0c07          	inc	(OFST-15,sp)
 291  00cb               L121:
 294  00cb 7b07          	ld	a,(OFST-15,sp)
 295  00cd a107          	cp	a,#7
 296  00cf 258a          	jrult	L511
 297                     ; 27 	for(j = 0;j < SCAN_NUM;j ++){
 299  00d1 0c16          	inc	(OFST+0,sp)
 302  00d3 7b16          	ld	a,(OFST+0,sp)
 303  00d5 a107          	cp	a,#7
 304  00d7 2403cc0055    	jrult	L701
 305                     ; 37 	temp[0] = temp[6] = 0;                            
 307  00dc 5f            	clrw	x
 308  00dd 1f14          	ldw	(OFST-2,sp),x
 309  00df 5f            	clrw	x
 310  00e0 1f08          	ldw	(OFST-14,sp),x
 311                     ; 38 	ADCdata = (u16)((temp[1] + temp[2] + temp[3] + temp[4] + temp[5]) / 5);	
 313  00e2 1e0a          	ldw	x,(OFST-12,sp)
 314  00e4 72fb0c        	addw	x,(OFST-10,sp)
 315  00e7 72fb0e        	addw	x,(OFST-8,sp)
 316  00ea 72fb10        	addw	x,(OFST-6,sp)
 317  00ed 72fb12        	addw	x,(OFST-4,sp)
 318  00f0 a605          	ld	a,#5
 319  00f2 62            	div	x,a
 320  00f3 1f05          	ldw	(OFST-17,sp),x
 321                     ; 40 	return ADCdata;
 323  00f5 1e05          	ldw	x,(OFST-17,sp)
 325  00f7               L6:
 327  00f7 5b16          	addw	sp,#22
 328  00f9 81            	ret
 341                     	xdef	_Get_Temp
 342                     	xref	_ADC1_ClearFlag
 343                     	xref	_ADC1_GetFlagStatus
 344                     	xref	_ADC1_GetConversionValue
 345                     	xref	_ADC1_StartConversion
 346                     	xref	_ADC1_Cmd
 365                     	end
