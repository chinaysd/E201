#include "pushrod.h"
#include "timeout.h"


TIMEOUT_PARA Pushrod_Timer[PUSHROD_NUM];




/**
	@function: pushrod low-layer initialize
	@brief: init example

	for(i = 0;i < PUSHROD_NUM;i++){
		Pushrod_APP_Init(Push_Para[i]);
	}
*/
u8 Pushrod_APP_Init(Push_Para_t *p){
	extern  u8 Pushrod_Port_Init(u8 ID);

	return Pushrod_Port_Init(p->ID);
}

u8 Pushrod_Handle(Push_ID_t ID,Push_Status_t Status){
	extern u8 Pushrod_Port_Set(u8 ID,u8 Status);

	return Pushrod_Port_Set(ID,Status);
}

static u8 Pushrod_Open(Push_Para_t *p){
	if(p->ID > PUSHROD_NUM)
		return 0;
	p->Push_Status= PUSH_OPEN;
	#ifdef PUSHROD_GET_RUNNING_STATUS
	p->IsRun = TRUE;
	#endif
	return Pushrod_Handle(p->ID, PUSH_OPEN);
}

static u8 Pushrod_Close(Push_Para_t *p){
	if(p->ID > PUSHROD_NUM)
		return 0;
	p->Push_Status = PUSH_CLOSE;
	#ifdef PUSHROD_GET_RUNNING_STATUS
	p->IsRun = TRUE;
	#endif
	return Pushrod_Handle(p->ID, PUSH_CLOSE);
}

static u8 Pushrod_Stop(Push_Para_t *p){
	if(p->ID > PUSHROD_NUM)
		return 0;
	p->Push_Status = PUSH_STOP;
	#ifdef PUSHROD_GET_RUNNING_STATUS
	p->IsRun = FALSE;
	#endif
	return Pushrod_Handle(p->ID, PUSH_STOP);
}

/*
	@brief : 推杆供应用层调用的接口
	@para :p 传入的推杆对象
		     Status 推杆工作的状态	
	@notice: 里面有延时程序，需要轮询执行
*/
#ifdef PUSHROD_REVERSING_DELAY
u8 Pushrod_APP_Handle(Push_Para_t *p,Push_Status_t Status){
	Push_Status_t sta = Status;
	static u8 flag[PUSHROD_NUM] = {0};
	#ifdef PUSHROD_REVERSE_SWITCH
	if(p->Push_Status != sta && !p->ReverseFlag){
	#else
	if(p->Push_Status != sta){
	#endif
		if(!flag[p->ID]){
			flag[p->ID] = TRUE;
			TimeOut_Record(&Pushrod_Timer[p->ID], PUSH_SWITCH_DELAY_VALUE);
			Pushrod_Stop(p);
		}
	}else{
		flag[p->ID] = TRUE;
		if(Status == PUSH_STOP){
			Pushrod_Stop(p);
		}else if(Status == PUSH_OPEN){
			#ifdef PUSHROD_REVERSE_SWITCH
			if(p->ReverseFlag){
				Pushrod_Close(p);
			}else{
				Pushrod_Open(p);
			}
			#else
			Pushrod_Open(p);
			#endif
		}else if(Status == PUSH_CLOSE){
			#ifdef PUSHROD_REVERSE_SWITCH
			if(p->ReverseFlag){
				Pushrod_Open(p);
			}else{
				Pushrod_Close(p);
			}
			#else
			Pushrod_Close(p);
			#endif
		}else
			return 0;
	}
	
	if(TimeOutDet_Check(&Pushrod_Timer[p->ID])){
		flag[p->ID] = FALSE;
		if(Status == PUSH_STOP){
			Pushrod_Stop(p);
		}else if(Status == PUSH_OPEN){
			#ifdef PUSHROD_REVERSE_SWITCH
			if(p->ReverseFlag){
				Pushrod_Close(p);
			}else{
				Pushrod_Open(p);
			}
			#else
			Pushrod_Open(p);
			#endif
		}else if(Status == PUSH_CLOSE){
			#ifdef PUSHROD_REVERSE_SWITCH
			if(p->ReverseFlag){
				Pushrod_Open(p);
			}else{
				Pushrod_Close(p);
			}
			#else
			Pushrod_Close(p);
			#endif
		}else
			return 0;
	}

	return 1;
}
#else
u8 Pushrod_APP_Handle(Push_Para_t *p,Push_Status_t Status){
	if(Status == PUSH_STOP){
		Pushrod_Stop(p);
	}else if(Status == PUSH_OPEN){
		#ifdef PUSHROD_REVERSE_SWITCH
		if(p->ReverseFlag){
			Pushrod_Close(p);
		}else{
			Pushrod_Open(p);
		}
		#else
		Pushrod_Open(p);
		#endif
	}else if(Status == PUSH_CLOSE){
		#ifdef PUSHROD_REVERSE_SWITCH
		if(p->ReverseFlag){
			Pushrod_Open(p);
		}else{
			Pushrod_Close(p);
		}
		#else
		Pushrod_Close(p);
		#endif
	}else{
		return 0;
	}

	return 1;
}
#endif

#ifdef PUSHROD_GET_RUNNING_STATUS
unsigned char Pushrod_GetStatus(Push_Para_t *p){
	return p->IsRun;
}
#endif