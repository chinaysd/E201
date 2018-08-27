/*
	@function: implement your table inserted into the detection function
	@version :v0.1
	@create time :2017/2/18
	@change time:
*/
#include "table_key.h"
#include "timeout.h"

static TIMEOUT_PARA Table_Timer[TABLE_NUM];



/*****************************************************************************
 * Function     	: Table_Detection_Init
 * Description 	: table detection initialize
 * Input         	: TABLE_PARA *p
 * Output        : None
 * Return        : init result
 * Others        : 
 * Record
 * 1.Date        : 2018/2/18
 *   Author      : marco
 *   Modification: 

*****************************************************************************/
u8 Table_Detection_Init(TABLE_PARA *p){
	if(p->ID == 1){		
		GPIO_Init(DETECTION_PORT, DETECTION_PIN, GPIO_MODE_IN_PU_NO_IT);
	}
	else{
		return 0;
	}
	return 1;
}

/*****************************************************************************
 * Function     	: Table_Read
 * Description 	: read detection port 
 * Input         	: TABLE_PARA *p
 * Output        : None
 * Return        : read result
 * Others        : 
 * Record
 * 1.Date        : 2018/2/18
 *   Author      : marco
 *   Modification: 

*****************************************************************************/
u8 Table_Read(TABLE_PARA *p){
	if(p->ID == 1){
		return GPIO_ReadInputPin(DETECTION_PORT, DETECTION_PIN);
	}else{
		return 0;
	}
}

/*****************************************************************************
 * Function     	: Table_Detection_Scan
 * Description 	: detection scan
 * Input         	: TABLE_PARA *p
 * Output        : None
 * Return        : None
 * Others        : the main program polling
 * Record
 * 1.Date        : 2018/2/18
 *   Author      : marco
 *   Modification: 

*****************************************************************************/
void Table_Detection_Scan(TABLE_PARA *p){
	switch(p->Table_Status){
		case FOUND_INSERT:{
			if(p->Read(p) == 0){
				p->Table_Status = CONFIRM_INSERT;
				TimeOut_Record(&Table_Timer[p->ID - 1], DETECTION_TIME);
			}
			break;
		}
		
		case CONFIRM_INSERT:{
			if(TimeOutDet_Check(&Table_Timer[p->ID - 1])){
				if(p->Read(p) == 0){
					p->InsertFlag = TRUE;
					p->Table_Status = FOUND_REMOVE;
				}else{
					p->InsertFlag = FALSE;
					p->Table_Status = FOUND_INSERT;
				}
			}
			break;
		}
		
		case FOUND_REMOVE:{
			if(p->Read(p)){
				p->Table_Status = CONFIRM_REMOVE;
				TimeOut_Record(&Table_Timer[p->ID - 1], DETECTION_TIME);
			}
			break;
		}
		
		case CONFIRM_REMOVE:{
			if(TimeOutDet_Check(&Table_Timer[p->ID - 1])){
				if(p->Read(p)){
					p->InsertFlag = FALSE;
					p->Table_Status = FOUND_INSERT;
				}else{
					p->InsertFlag = TRUE;
					p->Table_Status = FOUND_REMOVE;
				}
			}
			break;
		}
		
		default:{
			p->Table_Status = FOUND_INSERT;
			break;
		}
	}
}

/*****************************************************************************
 * Function     	: Table_Get_Flag
 * Description 	: get insert flag
 * Input         	: TABLE_PARA *p
 * Output        : None
 * Return        : insert result
 * Others        : 
 * Record
 * 1.Date        : 2018/2/18
 *   Author      : marco
 *   Modification: 

*****************************************************************************/
u8 Table_Get_Flag(TABLE_PARA *p){
	return p->InsertFlag;
}




