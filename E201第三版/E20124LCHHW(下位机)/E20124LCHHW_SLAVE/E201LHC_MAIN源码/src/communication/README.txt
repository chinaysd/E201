#一么么科技串型通讯协议

包说明：
1、start 
	固定字节：0X55
2、ID
	0X01 -> 1#
	...
3、功能位
	0x01 -> 点灯
	0x02 -> 制冷制热
	0x03 -> 推杆
	0x04 -> 按摩
4、控制位
	点灯-> 
		0X01 OPEN 
		0X00 CLOSE
	制冷制热-> 
		0X00 A_CLOSE 
		0X01 A_COOL 
		0X02 A_HEAT
	推杆-> 
		0X00 STOP 
		0X01 A_OPEN 
		0X02 A_CLOSE 
		0X03 A_STOP 
		0X04 B_OPEN 
		0X05 B_CLOSE 
		0X06 B_STOP
	按摩-> 
		0X00 CLOSE 
		0X01 OPEN 
5、checksum
	unsigned char(1 + 2 + 3 + 4)
6、结束位
	固定字节：0X0D 0X0A