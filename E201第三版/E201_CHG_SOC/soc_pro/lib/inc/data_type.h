
#ifndef DATA_TYPE_C_HEADER
#define DATA_TYPE_C_HEADER

typedef bit 			    BOOL; 		// ����������λ������
typedef unsigned char		CHAR;		// �ַ�����
typedef unsigned char 		INT8U; 		// �޷���8λ���ͱ���  
typedef signed char 		INT8S; 		// �з���8λ���ͱ���  
typedef unsigned int 		INT16U; 	// �޷���16λ���ͱ��� 
typedef signed int 		    INT16S; 	// �з���16λ���ͱ���
typedef unsigned long 		INT32U; 	// �޷���32λ���ͱ���
typedef signed long 		INT32S; 	// �з���32λ���ͱ��� 
typedef float 			    FP32; 		// �����ȸ�����(32λ����) 
typedef double 			    FP64; 		// ˫���ȸ�����(64λ����)

#define	uchar	unsigned	char
#define	uint	unsigned	int
#define	uint32	unsigned	double	int

#define		BS(SFR,NUM)		(SFR|=(1<<NUM))		//bitλ��1
#define		BC(SFR,NUM)		(SFR&=~(1<<NUM))	//��bitλ

#define 	True		1
#define 	False		0
#define 	Enable		1
#define 	Disable		0

#define		BIT0	0x01
#define		BIT1	0x02
#define		BIT2	0x04
#define		BIT3	0x08
#define		BIT4	0x10
#define		BIT5	0x20
#define		BIT6	0x40
#define		BIT7	0x80
#define		BIT8	0x0100
#define		BIT9	0x0200

#endif
