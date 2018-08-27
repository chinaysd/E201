#ifndef TABLE_KEY_H_
#define TABLE_KEY_H_

#include "stm8s_conf.h"

// to shake time
#define DETECTION_TIME			50		// ms

//the total number of table	
#define TABLE_NUM				1

// table IO defintion
#define DETECTION_PORT			GPIOC
#define DETECTION_PIN			GPIO_PIN_5



typedef enum {
	FOUND_INSERT = 0,
	CONFIRM_INSERT,
	FOUND_REMOVE,
	CONFIRM_REMOVE
}TABLE_STATUS_t;

typedef struct _TABLE_PARA{
	u8 ID;
	u8 InsertFlag;
	u8 (*Read)(struct _TABLE_PARA *p);
	TABLE_STATUS_t Table_Status;
}TABLE_PARA;










u8 Table_Detection_Init(TABLE_PARA *p);

u8 Table_Read(TABLE_PARA *p);

void Table_Detection_Scan(TABLE_PARA *p);

u8 Table_Get_Flag(TABLE_PARA *p);


#endif
