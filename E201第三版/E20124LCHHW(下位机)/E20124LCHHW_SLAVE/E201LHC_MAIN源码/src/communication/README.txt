#һôô�Ƽ�����ͨѶЭ��

��˵����
1��start 
	�̶��ֽڣ�0X55
2��ID
	0X01 -> 1#
	...
3������λ
	0x01 -> ���
	0x02 -> ��������
	0x03 -> �Ƹ�
	0x04 -> ��Ħ
4������λ
	���-> 
		0X01 OPEN 
		0X00 CLOSE
	��������-> 
		0X00 A_CLOSE 
		0X01 A_COOL 
		0X02 A_HEAT
	�Ƹ�-> 
		0X00 STOP 
		0X01 A_OPEN 
		0X02 A_CLOSE 
		0X03 A_STOP 
		0X04 B_OPEN 
		0X05 B_CLOSE 
		0X06 B_STOP
	��Ħ-> 
		0X00 CLOSE 
		0X01 OPEN 
5��checksum
	unsigned char(1 + 2 + 3 + 4)
6������λ
	�̶��ֽڣ�0X0D 0X0A