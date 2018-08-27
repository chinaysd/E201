#include "bsp_i2c.h"

/*****************************************************************************
 * Function	  : Bsp_IntInit
 * Description   : 初始化I2C中断引脚为输出模式
 * Input           : void  
 * Output		  : None
 * Return		  : static
 * Others		  : 
 * Record
 * 1.Date		  : 20180404
 *   Author       : marco
 *   Modification: Created function

*****************************************************************************/
static void Bsp_IntInit(void){
	P2CON |= 0X02; 
}

/*****************************************************************************
 * Function	  : Bsp_I2cInit
 * Description   : 配置I2C模块
 * Input           : void  
 * Output		  : None
 * Return		  : 
 * Others		  : 
 * Record
 * 1.Date		  : 20180404
 *   Author       : marco
 *   Modification: Created function

*****************************************************************************/
void Bsp_I2cInit(void){
	OTCON = 0x80;
	SSCON1 = I2C_ADDR;
	SSCON0 = 0x88;
	IE1 |=0x01;
	/*<int init>*/
	Bsp_IntInit();
	I2C_IntSet(1);
}






