#ifndef APP_H_
#define APP_H_

#include "sc93f833X_C.h"
#include "timeout.h"

/**
	@brief:配置WDT功能
*/
#define CLEAR_WDT()				(WDTCON  = 0x10)		

/**
	@brief:长按检测时间
*/
#define LONG_PRESS_TIME			1500

#define ONLINE_TIME				200
#define LED_DIS_TIME				3000

#define Get_I2C_INT()				P17

#define I2C_READ_ADDR			0X5B
#define I2C_WRITE_ADDR			0X5A

#define WARM_AUTO_CLOSE			3600
#define HEAT_AUTO_CLOSE			3600
#define COOL_AUTO_CLOSE			7200
#define MASS_AUTO_CLOSE			1800
#define SYSTEM_AUTO_CLOSE		14400	

/**
	@breif:LED 脚位定义(拿起塑壳，从右往左看)
*/			
#define   LED0_PIN              	 	P23
#define   LED1_PIN              	 	P24
#define   LED2_PIN               		P25
#define   LED3_PIN               		P22
#define   LED4_PIN               		P50
#define   LED5_PIN               		P51
#define 	BACK_LIGHT				P01
#define 	RED_LED					  P27

/**
	@brief:触摸按键对应的值，跟LED一个方向
*/
enum{
	CHG_KEY0_VALUE = 0X40,
	CHG_KEY1_VALUE = 0X20,
	CHG_KEY2_VALUE = 0X10,
	CHG_KEY3_VALUE = 0X08,
	CHG_KEY4_VALUE = 0X04,
	CHG_KEY5_VALUE = 0X01,
};

enum{
	TP_KEY0_VALUE = 0X01,
	TP_KEY1_VALUE = 0X02,
	TP_KEY2_VALUE = 0X04,
	TP_KEY3_VALUE = 0X08,
	TP_KEY4_VALUE = 0X10,
	TP_KEY5_VALUE = 0X20,
};

/*
	key indicator
*/
enum{
	TP_KEY0_LED = 0XFE,
	TP_KEY1_LED = 0XFD,
	TP_KEY2_LED = 0XFB,
	TP_KEY3_LED = 0XF7,
	TP_KEY4_LED = 0XEF,
	TP_KEY5_LED = 0XDF,
	TP_BACKLIGHT_LED = 0X40		
};

enum{
	ON = 0,
	OFF
};

typedef enum{
	STOP_MODE = 0,
	HEAT_MODE,
	COOL_MODE
}Heat_Cool_Sta_t;

typedef void (*Key_Handle_t)(void);

typedef struct{
	unsigned char LockDetFlag[2],LockFlag;			/*<处理按键锁键>*/
	Heat_Cool_Sta_t HC_Sta;
	unsigned char TP_GetKey,Chg_GetKey;			
	unsigned char Tp_LedSta,Tp_LedStaBak;			/*<记录LED灯状态>*/
	unsigned char Tp_CurKey,Chg_CurKey;	
	TIMEOUT_PARA LockLong_DetTimer[2];
	unsigned int SentData;
	unsigned char FootLedSta;
    unsigned char MASSAGESta;
    unsigned char WarmSta;
	unsigned char Pushrod_Status;
	unsigned char UpDataFlag;
	unsigned char ShutDownFlag;
	unsigned char OnLineCnt,OnLineFlag;
    unsigned char MassAutoClsFlag,WarmAutoClsFlag;
	unsigned char CoolAutoClsFlag,HeatAutoClsFlag,SystemAutoClsFlag,TpLedDisCntFlag;
	unsigned int CoolAutoCnt,HeatAutoCnt,SystemAutoCnt,TpLedDisCnt;
    unsigned int MassAutoCnt,WarmAutoCnt;
	
}App_Para_t;







void App_Init(void);
void App_Handle(void);

#endif
