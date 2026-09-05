#ifndef _APU_H
	#define _APU_H

	#define APU_SQR_ONE_DV (*(volatile unsigned char*)0x4000)
	#define APU_SQR_ONE_PER_LO (*(volatile unsigned char*)0x4002)
	#define APU_SQR_ONE_PER_HI (*(volatile unsigned char*)0x4003)

	#define APU_SQR_TWO_DV (*(volatile unsigned char*)0x4004)
	#define APU_SQR_TWO_PER_LO (*(volatile unsigned char*)0x4006)
	#define APU_SQR_TWO_PER_HI (*(volatile unsigned char*)0x4007)

	#define APU_TRI_MUTE (*(volatile unsigned char*)0x4008)
	#define APU_TRI_PER_LO (*(volatile unsigned char*)0x400A)
	#define APU_TRI_PER_HI (*(volatile unsigned char*)0x400B)

	#define APU_NOISE_VOL (*(volatile unsigned char*)0x400C)
	#define APU_NOISE_CTRL (*(volatile unsigned char*)0x400E)
	#define APU_NOISE_LENGTH (*(volatile unsigned char*)0x400F)

	#define APU_DMC_CTRL (*(volatile unsigned char*)0x4010)
	#define APU_DMC_LOAD_COUNTER (*(volatile unsigned char*)0x4011)
	#define APU_DMC_SAMPLE_ADDR (*(volatile unsigned char*)0x4012)
	#define APU_DMC_SAMPLE_LENGTH (*(volatile unsigned char*)0x4013)

	#define APU_STATUS (*(volatile unsigned char*)0x4015)
	#define APU_FRAME_COUNTER (*(volatile unsigned char*)0x4017)

	void apu_init();

#endif
