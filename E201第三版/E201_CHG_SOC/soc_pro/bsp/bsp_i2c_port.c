#include "sc93f833X_C.h"

// simulate iic  
// chg
#define SDA0_Read()	P15
#define SDA0_Set(x)	((x) ? (P15 = 1): (P15 = 0))

#define SCL0_Read()	P14
#define SCL0_Set(x)	((x) ? (P14 = 1) : (P14 = 0))

int IIC_Port_Init(int ID){
	if(ID == 0){
		//GPIO_Init(SDA0_PORT, SDA0_PIN, GPIO_MODE_OUT_PP_HIGH_FAST);
		//SDA0_Set(1);
		//GPIO_Init(SCL0_PORT, SCL0_PIN, GPIO_MODE_OUT_PP_HIGH_FAST);
		//SCL0_Set(1);
		P1CON |= 0X30;
		P1 |= 0X30;
	}
	return 1;
}
/*
	Func : 0 ->IN ;1 ->OUT
*/
int IIC_Port_SDA_Set(int ID,int Func){
	if(ID == 0){
		if(Func == 0){
			P1CON &= ~0X20;
		}else if(Func == 1){
			P1CON |= 0X20;
		}else{
			return 0;
		}
	}
	return 0;
	
}
/*
	Func : 0->SDA 1->SCL
	Data: 0->out 0;
*/
int IIC_Port_Write(int ID,int Func,int Data){
	if(ID == 0){
		if(Func == 0){
			SDA0_Set(Data);
		}else if(Func == 1){
			SCL0_Set(Data);
		}else{
			return 0;
		}
	}
	return 0;

}

int IIC_Port_Read(int ID ,int Func ){
	if(ID == 0){
		if(Func == 0){
			return SDA0_Read();
		}else if(Func == 1){
			return SCL0_Read();
		}else{
			return 0;
		}
	}
	return 0;
}

