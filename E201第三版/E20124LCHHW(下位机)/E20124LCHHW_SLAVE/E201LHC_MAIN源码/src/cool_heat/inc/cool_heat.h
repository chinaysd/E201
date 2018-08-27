#ifndef COOL_HEAT_H_
#define COOL_HEAT_H_

/*
	@brief : ÀäÄýÆ¬µ×²ãÇý¶¯(ÖÐ¼ä¼þ²ã)
	@version:V1.0
	@author:marco
*/

#ifndef CH_OPEN
#define CH_OPEN		1
#endif

#ifndef CH_CLOSE
#define CH_CLOSE		0
#endif

/*
	cool_heat module began to work ,there must bu a delay
	especially when switch  !!!
*/
#define CH_START_TIME		10000			// 10S		

#define CH_STOP_TIME			15000			// 15S

/*
	If module problems, such as short circuit, open circuit
	switch to the software time and method
*/
#define CH_ABNORMAL_TIME	3000
/*
	heat range
*/
#define CH_HEAT_START_VALUE		355
#define CH_HEAT_STOP_VALUE		340		//
/*
	the total number of cool_heat moudle
*/
#define CH_NUM				1
#define CH_A					0
/*enable cool mode
	default :	enable
*/
#define CH_COOL_FUNC_ENABLE
/*enable heat mode
	default : enable
*/
#define CH_HEAT_FUNC_ENABLE



typedef enum{
	CH_STOP_MODE = 0
	#ifdef CH_COOL_FUNC_ENABLE
	,CH_COOL_MODE
	#endif
	#ifdef CH_HEAT_FUNC_ENABLE
	,CH_HEAT_MODE
	#endif
}CH_STATUS_t;

typedef struct _CH_PARA{
	unsigned char ID;
	CH_STATUS_t Status;
	#ifdef CH_HEAT_FUNC_ENABLE
	unsigned char Abnormal_DetFlag;
	#endif
}CH_PARA_t;









unsigned char CH_App_Init(CH_PARA_t *p);

unsigned char CH_Handle(CH_PARA_t *p,CH_STATUS_t Status);

int CH_Cool_Heat_Moudle_Set(CH_PARA_t *p,unsigned char Status);



#endif
