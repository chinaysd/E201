#include "key.h"
#include "timeout.h"
/**
	@function:按键检测状态
*/
typedef enum 
{
    KEY_STATE_IDLE,
    KEY_STATE_JITTER,
    KEY_STATE_PRESS_DOWN,
    KEY_STATE_CP

} KEY_STATE;


static TIMEOUT_PARA Read_Key_Timer,Key_Scan_Timer,Key_Wait_Timer;
static KEY_STATE	KeyState;


/**
	@function: 按键事件，更多按键时，对应增加按键按键
	
*/
static const u16 KeyEvent[][5]=
{
	//按键开始(按下)	    	短按						长按					长按保持				长按松开
	{MSG_KEY_NONE,				MSG_KEY_NONE,				MSG_KEY_NONE,			MSG_KEY_NONE,				MSG_KEY_NONE},			// 空，无用
	
	{MSG_KEY1_PRESS,			MSG_KEY1_SHORT_PRESS,		MSG_KEY1_LONGPRESS,	MSG_KEY_NONE,				MSG_KEY1_LONGPRESS_RE},							// key1
	{MSG_KEY2_PRESS,			MSG_KEY2_SHORT_PRESS,		MSG_KEY2_LONGPRESS,	MSG_KEY_NONE,				MSG_KEY2_LONGPRESS_RE},							// key2
	{MSG_KEY3_PRESS,			MSG_KEY3_SHORT_PRESS, 		MSG_KEY3_LONGPRESS, 	MSG_KEY_NONE,				MSG_KEY3_LONGPRESS_RE},							// key3
};

/**
	@function:	获取按键索引值
	根据按键的个数，需要做相应的修改
*/
static u8 GetKeyIndex(void)
{
	extern u8 Key_Port_Read(u8 num);
	
	u8 cnt=0,value=0;
	if(Key_Port_Read(1) == 0)
		cnt++,value=1;
	if(Key_Port_Read(2) == 0)
		cnt++,value=2;	
	return ((cnt > 1) ? 3 : (value));	
}

/**
	@function:IO 和按键扫描状态的初始化
*/
void KEY_Init(void){
	extern u8 Key_Port_Init(void);
	
	Key_Port_Init();
	KeyState=KEY_STATE_IDLE;
	TimeOut_Record(&Key_Scan_Timer,0);
}

/**
	@function:按键的扫描
	@return :t_KEY_MSG 类型的消息，消息集在t_KEY_MSG中定义
*/
t_KEY_MSG KEY_Scan(void){
	static u8 PreKeyIndex=0xFF;
	u8 KeyIndex;

	if(!(TimeOutDet_Check(&Key_Scan_Timer))){
		return MSG_KEY_NONE;
	}
	
	TimeOut_Record(&Key_Scan_Timer,KEY_SCAN_TIME);
	
	KeyIndex=GetKeyIndex();

	switch(KeyState){
		case KEY_STATE_IDLE:{
			if(!KeyIndex){
				return MSG_KEY_NONE;
			}
			
			PreKeyIndex = KeyIndex;
			TimeOut_Record(&Key_Wait_Timer,KEY_JITTER_TIME);
			KeyState = KEY_STATE_JITTER;
			break;
		}
		
		case KEY_STATE_JITTER:{
			if(PreKeyIndex != KeyIndex){
				KeyState = KEY_STATE_IDLE;
			}else if(TimeOutDet_Check(&Key_Wait_Timer)){
				TimeOut_Record(&Key_Wait_Timer,KEY_CP_TIME);
				KeyState = KEY_STATE_PRESS_DOWN;
				return KeyEvent[PreKeyIndex][0];
			}
			break;
		}

		case KEY_STATE_PRESS_DOWN:{
			if(PreKeyIndex != KeyIndex){
				KeyState = KEY_STATE_IDLE;
				return KeyEvent[PreKeyIndex][1];
			}else if(TimeOutDet_Check(&Key_Wait_Timer)){
				TimeOut_Record(&Key_Wait_Timer,KEY_CPH_TIME);
				KeyState = KEY_STATE_CP;
				return KeyEvent[PreKeyIndex][2];
			}
			break;
		}
		
		case KEY_STATE_CP:{
			if(PreKeyIndex != KeyIndex){
				KeyState = KEY_STATE_IDLE;
				return KeyEvent[PreKeyIndex][4];
			}else if(TimeOutDet_Check(&Key_Wait_Timer)){
				TimeOut_Record(&Key_Wait_Timer,KEY_CPH_TIME);
				return KeyEvent[PreKeyIndex][3];
			}
			break;
		}
		
		default:{
			KeyState = KEY_STATE_IDLE;
			break;
		}
	}
	return MSG_KEY_NONE;
}


