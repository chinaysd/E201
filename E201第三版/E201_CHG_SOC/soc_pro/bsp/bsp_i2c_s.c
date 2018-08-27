#include "bsp_i2c_s.h"

extern int IIC_Port_Write(int ID,int Func,int Data);
extern int IIC_Port_Read(int ID ,int Func );
extern int IIC_Port_SDA_Set(int ID,int Func);

static void IIC_Delay_us(unsigned int Delay){
	unsigned char  j;
	while( Delay--){	
		for(j = IIC_DelayBaseValue;j > 0;j --);
	}
}

int IIC_Init(IIC_PARA_t *p){
	extern int IIC_Port_Init(int ID);
	return IIC_Port_Init(p->ID);
}

static void IIC_Start(IIC_PARA_t *p){
	IIC_Port_Write(p->ID, IIC_SDA, 1);
	IIC_Delay_us(IIC_DelayTime);
	IIC_Port_Write(p->ID, IIC_SCL, 1);
	IIC_Delay_us(IIC_DelayTime);
	IIC_Port_Write(p->ID, IIC_SDA, 0);
	IIC_Delay_us(IIC_DelayTime);
	IIC_Port_Write(p->ID, IIC_SCL, 0);
	IIC_Delay_us(IIC_DelayTime);
}

static int  IIC_WriteData(IIC_PARA_t *p,unsigned char Data){
	unsigned char i,AckStatus;
	for(i = 0;i < 8;i ++){
		if(Data & 0x80){
			IIC_Port_Write(p->ID, IIC_SDA, 1);
		}else{
			IIC_Port_Write(p->ID, IIC_SDA, 0);
		}
		Data <<= 1;
		IIC_Delay_us(IIC_DelayTime);
		IIC_Port_Write(p->ID, IIC_SCL, 1);
		IIC_Delay_us(IIC_DelayTime);
		IIC_Port_Write(p->ID, IIC_SCL, 0);
		IIC_Delay_us(IIC_DelayTime);  
	}   
	IIC_Port_SDA_Set(p->ID, IN);
	IIC_Port_Write(p->ID, IIC_SCL, 1);               
	IIC_Delay_us(IIC_DelayTime);
	
	if(IIC_Port_Read(p->ID,IIC_SDA)){  
		AckStatus = 0;
		
	}else{
		AckStatus = 1;
	}
	IIC_Port_Write(p->ID, IIC_SCL, 0);
	IIC_Delay_us(IIC_DelayTime);  
	IIC_Port_SDA_Set(p->ID, OUT);
	return AckStatus;
}

static void IIC_Stop(IIC_PARA_t *p){
	IIC_Port_Write(p->ID, IIC_SCL, 0);
	IIC_Delay_us(IIC_DelayTime);
	IIC_Port_Write(p->ID, IIC_SCL, 1);
	IIC_Delay_us(IIC_DelayTime);
	IIC_Port_Write(p->ID, IIC_SDA, 1);
	IIC_Delay_us(IIC_DelayTime);
	IIC_Delay_us(1000);
}

static void IIC_Nck(IIC_PARA_t *p){
	IIC_Port_Write(p->ID, IIC_SDA, 1);
	IIC_Delay_us(IIC_DelayTime);
	IIC_Port_Write(p->ID, IIC_SCL, 1);
	IIC_Delay_us(IIC_DelayTime);
	IIC_Port_Write(p->ID, IIC_SCL, 0);
	IIC_Delay_us(IIC_DelayTime);
	IIC_Port_Write(p->ID, IIC_SDA, 0);
	IIC_Delay_us(IIC_DelayTime);
}
#if 0
static void I2C_Ack(IIC_PARA_t *p){
	IIC_Port_Write(p->ID, IIC_SCL, 0);
	IIC_Delay_us(IIC_DelayTime);
	IIC_Port_Write(p->ID, IIC_SDA, 0);
	IIC_Delay_us(IIC_DelayTime);
	IIC_Port_Write(p->ID, IIC_SCL, 1);
	IIC_Delay_us(IIC_DelayTime);
	IIC_Port_Write(p->ID, IIC_SCL, 0);
	IIC_Delay_us(IIC_DelayTime);
}
#endif

static unsigned char IIC_ReadData(IIC_PARA_t *p){
	unsigned char Read = 0,j;
	IIC_Port_SDA_Set(p->ID, IN);
	IIC_Delay_us(IIC_DelayTime);
	for(j = 0;j < 8;j ++){
		IIC_Port_Write(p->ID, IIC_SCL, 1);
		IIC_Delay_us(IIC_DelayTime);
		if(IIC_Port_Read(p->ID,IIC_SDA)){
			 Read = Read |(0x80 >> j);
		}
		IIC_Port_Write(p->ID, IIC_SCL, 0);
		IIC_Delay_us(IIC_DelayTime);
	}
	IIC_Port_SDA_Set(p->ID, OUT);
	return Read;
}

int  IIC_Read_Data(IIC_PARA_t *p,unsigned char Add,unsigned char *Read_Data){
	IIC_Start(p);
	if(IIC_WriteData(p, Add) == 0){
		IIC_Stop(p);
		return 0;
	}
	*Read_Data = IIC_ReadData(p);
	IIC_Nck(p);
	IIC_Stop(p);
	return 1;
}

int  IIC_Write_Data(IIC_PARA_t *p,unsigned char Add,unsigned char Write_Data){
	IIC_Start(p);
	if(!IIC_WriteData(p, Add)){
		IIC_Stop(p);
		return 0;
	}
	if(!IIC_WriteData(p, Write_Data)){
		IIC_Stop(p);
		return 0;
	}
	IIC_Nck(p);
	IIC_Stop(p);
	return 1;
}



