#ifndef PUSHROD_H_
#define PUSHROD_H_

/*
	@brief : 推杆底层驱动(中间件层)
	@version:V4.0
	@author:marco
*/

#include "stm8s_conf.h"

/*
	@brief:	key mode:do not need to delay ;other mode:need to delay
			push rod do not need the reversing latency 
*/
//#define PUSHROD_REVERSING_DELAY
/**
	@function: 推杆换向延时时间
*/
#define PUSH_SWITCH_DELAY_VALUE			300		  //ms

/*
	@function: reverse switch
			defaults to shut down
	@brief: can use a switch ,to control the push rod reverse
*/
#define PUSHROD_REVERSE_SWITCH	

/*
	@function :get push rod running status 
*/
#define PUSHROD_GET_RUNNING_STATUS	

/**
	@function: 推杆使能
*/
#define PUSHROD_NUM						(2)

/*	@brief : for initial push rod 
	@example :	Push_Para_t PushRod[2];
				PushRod[PUSHROD_A] = PushRod[0]
				PushRod[PUSHROD_B] = PushRod[1]
*/
#define PUSHROD_A						(0)
#define PUSHROD_B						(1)
#define PUSHROD_C						(2)
#define PUSHROD_D						(3)
/**
	@function: 推杆工作的传入消息命令
*/
typedef enum{
	p_STOP=0,
	p_PUSHA_OPEN,
	p_PUSHA_CLOSE,
	p_PUSHB_OPEN,
	p_PUSHB_CLOSE,
	p_PUSHAB_RESET,
	p_PUSHAB_STOP,
	p_PUSHC_OPEN,
	p_PUSHC_CLOSE,
	p_PUSHD_OPEN,
	p_PUSHD_CLOSE,
	p_PUSHCD_RESET,
	p_PUSHCD_STOP
	
}Pushrod_Cmd_t;

        
typedef enum{
	PUSH_STOP = 0,
	PUSH_OPEN,
	PUSH_CLOSE
}
Push_Status_t;

typedef enum{
	PUSH_NONE = 0,
	PUSHA
#if PUSHROD_NUM > 1
	,
	PUSHB
#endif
#if PUSHROD_NUM == 3
	,
	PUSHC
#endif
}
Push_ID_t;

typedef struct Push_Para{
	u8 ID;
	#ifdef PUSHROD_REVERSE_SWITCH
	u8 ReverseFlag;
	#endif
	#ifdef PUSHROD_GET_RUNNING_STATUS
	u8 IsRun;
	#endif
	Push_Status_t Push_Status;
}Push_Para_t;



/**********************************************************/
/**
	@function: 推杆硬件初始化
*/
u8 Pushrod_APP_Init(Push_Para_t *p);

u8 Pushrod_APP_Handle(Push_Para_t *p,Push_Status_t Status);
#ifdef PUSHROD_GET_RUNNING_STATUS
unsigned char Pushrod_GetStatus(Push_Para_t *p);
#endif
/*
	direct operation
*/
u8 Pushrod_Handle(Push_ID_t ID,Push_Status_t Status);



#endif
