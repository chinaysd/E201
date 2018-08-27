/* MAIN.C file
 * 
 * Copyright (c) 2002-2005 STMicroelectronics
 */
/*
	@function: E201CRRL
	@date:2017/7/24
	@author:marco
	@version:V0.0.2_beta
*/

#include "stm8s_conf.h"
#include "system.h"

void main(void){

	System_Init();
	
	while (1){

		System_Handle();
	}
}