#ifndef BSP_I2C_H_
#define BSP_I2C_H_


#include "sc93f833X_C.h"

/**
	@brief:I2C 从机地址
*/
#define I2C_ADDR					0X5A

/**
	@brief:中断输出脚
*/
#define I2C_INT					P21

/**
	@brief:中断引脚输出
*/
#define I2C_IntSet(x)				(I2C_INT = x)
#define I2C_IntGet()				(I2C_INT)






void Bsp_I2cInit(void);


#endif

