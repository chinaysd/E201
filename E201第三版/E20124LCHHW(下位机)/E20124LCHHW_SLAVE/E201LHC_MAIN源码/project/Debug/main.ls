   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.8 - 03 Dec 2008
  34                     ; 15 void main(void){
  36                     	switch	.text
  37  0000               _main:
  41                     ; 17 	System_Init();
  43  0000 cd0000        	call	_System_Init
  45  0003               L12:
  46                     ; 21 		System_Handle();
  48  0003 cd0000        	call	_System_Handle
  51  0006 20fb          	jra	L12
  64                     	xdef	_main
  65                     	xref	_System_Handle
  66                     	xref	_System_Init
  85                     	end
