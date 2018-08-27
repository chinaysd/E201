#include "bsp_i2c.h"

/*****************************************************************************
 * Function	  : Bsp_IntInit
 * Description   : ��ʼ��I2C�ж�����Ϊ���ģʽ
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
 * Description   : ����I2Cģ��
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






