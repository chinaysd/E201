#ifndef BSP_I2C_H_
#define BSP_I2C_H_


#include "sc93f833X_C.h"

/**
	@brief:I2C �ӻ���ַ
*/
#define I2C_ADDR					0X5A

/**
	@brief:�ж������
*/
#define I2C_INT					P21

/**
	@brief:�ж��������
*/
#define I2C_IntSet(x)				(I2C_INT = x)
#define I2C_IntGet()				(I2C_INT)






void Bsp_I2cInit(void);


#endif

