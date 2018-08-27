#ifndef KEY_H_
#define KEY_H_

#include "stm8s_conf.h"


/**
	@function: °´¼üÉ¨ÃèµÄÊ±¼ä¶¨Òå
	@brief: Ê±»ù125us
*/
#define 	KEY_SCAN_TIME			20				//	20ms		
#define 	KEY_JITTER_TIME			20				// 	20ms
#define 	KEY_CP_TIME				1500				//	ms
#define 	KEY_CPH_TIME			1600				//  200ms	³¤°´±£³Ö´¥·¢Ê±¼

/**
	@function:msg
	@brief:  Ö§³Ö¶Ì°´£¬³¤°´£¬³¤°´±£³Ö£¬³¤°´·ÅÊÖ
*/ 
typedef enum
{
	MSG_KEY_NONE=0,
	MSG_KEY1_PRESS,
	MSG_KEY1_SHORT_PRESS,
	MSG_KEY1_LONGPRESS,
	MSG_KEY1_LONGPRESS_RE,
	MSG_KEY2_PRESS,
	MSG_KEY2_SHORT_PRESS,
	MSG_KEY2_LONGPRESS,
	MSG_KEY2_LONGPRESS_RE,
	MSG_KEY3_PRESS,
	MSG_KEY3_SHORT_PRESS,
	MSG_KEY3_LONGPRESS,
	MSG_KEY3_LONGPRESS_RE,
	MSG_KEY4_PRESS,
	MSG_KEY4_SHORT_PRESS,
	MSG_KEY4_LONGPRESS,
	MSG_KEY4_LONGPRESS_RE,
	MSG_KEY5_PRESS,
	MSG_KEY5_SHORT_PRESS,
	MSG_KEY5_LONGPRESS,
	MSG_KEY5_LONGPRESS_RE,
	MSG_KEY6_PRESS,
	MSG_KEY6_SHORT_PRESS,
	MSG_KEY6_LONGPRESS,
	MSG_KEY6_LONGPRESS_RE,
	MSG_KEY7_PRESS,
	MSG_KEY7_SHORT_PRESS,
	MSG_KEY7_LONGPRESS,
	MSG_KEY7_LONGPRESS_RE,
	MSG_KEY8_PRESS,
	MSG_KEY8_SHORT_PRESS,
	MSG_KEY8_LONGPRESS,
	MSG_KEY8_LONGPRESS_RE,
	MSG_KEY9_PRESS,
	MSG_KEY9_SHORT_PRESS,
	MSG_KEY9_LONGPRESS,
	MSG_KEY9_LONGPRESS_RE
}t_KEY_MSG;



















/************************************************************/

/**
	@function:IO ºÍ°´¼üÉ¨Ãè×´Ì¬µÄ³õÊ¼»¯
*/
void KEY_Init(void);

/**
	@function:°´¼üµÄÉ¨Ãè
	@return :t_KEY_MSG ÀàÐÍµÄÏûÏ¢£¬ÏûÏ¢¼¯ÔÚt_KEY_MSGÖÐ¶¨Òå
*/
t_KEY_MSG KEY_Scan(void);

#endif