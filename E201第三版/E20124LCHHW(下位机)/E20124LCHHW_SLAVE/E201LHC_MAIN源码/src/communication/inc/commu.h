#ifndef COMMU_H_
#define COMMU_H_



#define BUF_SIZE		7

#define Get_Low(x)		x & 0XFF
#define Get_High(x)		(x >> 8) & 0XFF
#define Get_32bit(x,y)		((x << 8) | y) & 0XFFFF


#define START_FIELD		0X55
#define STOP_MESSAGE	0X0D0A

typedef enum{
	NONE = 0,
	NUM1 = 0x01
}MESSAGE_ID;

typedef enum{
	FUNC_NONE = 0,
	LED_FUNC,
	CH_FUNC,
	PUSHROD_FUNC,
	MASSAGE_FUNC
}FUNC_TYPE_t;

typedef enum{
	FOOT_LED_OFF = 0,
	FOOT_LED_ON,
	FOOT_MAX
}FOOT_LED_STA_t;

typedef enum{
	CH_A_OFF = 0,
	CH_A_COOL,
	CH_A_HEAT
}CH_STA_t;

typedef enum{
	MASS_OFF = 0,
	MASS_ON ,
	MASS_MAX
}MASS_STA_t;

typedef enum{
	WARM_OFF = 0,
	WARM_ON,
	WARM_MAX
}WARM_CLOTH_STA_t;

typedef enum{
	PUSHROD_STOP = 0,
	PUSHROD_A_OPEN,
	PUSHROD_A_CLOSE,
	PUSHROD_A_STOP,
	PUSHROD_B_OPEN,
	PUSHROD_B_CLOSE,
	PUSHROD_B_STOP
}PUSHROD_STA_t;

typedef enum{
	MASSAGE_OFF = 0,
	MESSAGE_ON
}MESSAGE_STA_t;

typedef enum{
	CONT_NONE = 0,
	CONT_LED_ON = 0X0001,
	CONT_LED_OFF = 0X0002,
	CONT_CH_A_OFF = 0X0004,
	CONT_CH_A_COOL = 0X0008,
	CONT_CH_A_HEAT = 0X0010,
	CONT_PUSHROD_STOP = 0X0020,
	CONT_PUSHROD_A_OPEN = 0X0040,
	CONT_PUSHROD_A_CLOSE =0X0080,
	CONT_PUSHROD_A_STOP = 0X0100,
	CONT_PUSHROD_B_OPEN = 0X0200,
	CONT_PUSHROD_B_CLOSE = 0X0400,
	CONT_PUSHROD_B_STOP = 0X0800,
	CONT_MASS_ON = 0X1000,
	CONT_MASS_OFF = 0X2000,
	CONT_WARM_CLOTH_ON = 0X4000,
	CONT_WARM_CLOTH_OFF = 0X8000,
	CONT_MAX = 0X9000
}CONTROL_TYPE_t;


/*
	@brief : custom data format
*/
typedef struct {
	unsigned char Start;
	unsigned char MessageID;
	unsigned char Cont1;
	unsigned char Cont2;
	unsigned char Checksum;
	unsigned char Stop1;
	unsigned char Stop2;
}DATA_FORMAT_t;


typedef union{
	DATA_FORMAT_t Data_Format;
	unsigned char Buf[BUF_SIZE];
}COMMU_BUF_t;


















unsigned char Commu_Init(void);

unsigned char Commu_Sent(COMMU_BUF_t *p);

/*serial */
void Serial_Rev_IQH(void);
unsigned char Serial_Get_Status(void);




















#endif
