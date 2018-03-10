_EXTI1_IRQHandler:
;Optique.c,42 :: 		void EXTI1_IRQHandler() iv IVT_INT_EXTI1 ics ICS_AUTO
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Optique.c,44 :: 		while (1)
L_EXTI1_IRQHandler0:
;Optique.c,46 :: 		PrintString ("interrupt ");
MOVW	R0, #lo_addr(?lstr1_Optique+0)
MOVT	R0, #hi_addr(?lstr1_Optique+0)
BL	_PrintString+0
;Optique.c,47 :: 		Delay_100ms();
BL	_Delay_100ms+0
;Optique.c,48 :: 		}
IT	AL
BAL	L_EXTI1_IRQHandler0
;Optique.c,49 :: 		}
L_end_EXTI1_IRQHandler:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _EXTI1_IRQHandler
_ScanDecimal:
;gla.h,12 :: 		void ScanDecimal(int *t)
; t start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; t end address is: 0 (R0)
; t start address is: 0 (R0)
MOV	R4, R0
; t end address is: 0 (R0)
;gla.h,14 :: 		while (1) {                     // Endless loop
L_ScanDecimal2:
;gla.h,15 :: 		if (UART1_Data_Ready()) {     // If data is received
; t start address is: 16 (R4)
; t start address is: 16 (R4)
; t end address is: 16 (R4)
BL	_UART1_Data_Ready+0
CMP	R0, #0
IT	EQ
BEQ	L_ScanDecimal4
; t end address is: 16 (R4)
;gla.h,16 :: 		uart_rd = UART1_Read();     // read the received data
; t start address is: 16 (R4)
BL	_UART1_Read+0
MOVW	R1, #lo_addr(_uart_rd+0)
MOVT	R1, #hi_addr(_uart_rd+0)
STRB	R0, [R1, #0]
;gla.h,17 :: 		UART1_Write(uart_rd);
UXTB	R1, R0
UXTH	R0, R1
BL	_UART1_Write+0
;gla.h,18 :: 		*t = uart_rd ;
MOVW	R1, #lo_addr(_uart_rd+0)
MOVT	R1, #hi_addr(_uart_rd+0)
LDRB	R1, [R1, #0]
STRH	R1, [R4, #0]
; t end address is: 16 (R4)
;gla.h,19 :: 		break;       // and send data via UART
IT	AL
BAL	L_ScanDecimal3
;gla.h,20 :: 		}
L_ScanDecimal4:
;gla.h,21 :: 		}
; t start address is: 16 (R4)
; t end address is: 16 (R4)
IT	AL
BAL	L_ScanDecimal2
L_ScanDecimal3:
;gla.h,22 :: 		}
L_end_ScanDecimal:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _ScanDecimal
_PrintString:
;gla.h,28 :: 		void PrintString(char t [])
; t start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; t end address is: 0 (R0)
; t start address is: 0 (R0)
;gla.h,30 :: 		uart (t);
; t end address is: 0 (R0)
BL	_UART1_Write_Text+0
;gla.h,31 :: 		UART1_Write(10);
MOVS	R0, #10
BL	_UART1_Write+0
;gla.h,32 :: 		UART1_Write(13);
MOVS	R0, #13
BL	_UART1_Write+0
;gla.h,33 :: 		}
L_end_PrintString:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _PrintString
_PrintDecimal:
;gla.h,37 :: 		void PrintDecimal(int t)
; t start address is: 0 (R0)
SUB	SP, SP, #12
STR	LR, [SP, #0]
; t end address is: 0 (R0)
; t start address is: 0 (R0)
;gla.h,40 :: 		ByteToStr(t, text);
ADD	R1, SP, #4
UXTB	R0, R0
; t end address is: 0 (R0)
BL	_ByteToStr+0
;gla.h,41 :: 		Uart1_write_text (text);
ADD	R1, SP, #4
MOV	R0, R1
BL	_UART1_Write_Text+0
;gla.h,42 :: 		}
L_end_PrintDecimal:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _PrintDecimal
_InitI2C2:
;gla.h,46 :: 		void InitI2C2()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;gla.h,49 :: 		GPIO_Digital_Output(&GPIOB_BASE, _GPIO_PINMASK_10);           // Set GPIOC pin 10 as digital output
MOVW	R1, #1024
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Output+0
;gla.h,50 :: 		GPIO_Digital_Output(&GPIOB_BASE, _GPIO_PINMASK_11);           // Set GPIOC pin 11 as digital output
MOVW	R1, #2048
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Output+0
;gla.h,51 :: 		I2C2_Init_Advanced(100000, &_GPIO_MODULE_I2C2_PB10_11);         //I2C config 100kbps
MOVW	R1, #lo_addr(__GPIO_MODULE_I2C2_PB10_11+0)
MOVT	R1, #hi_addr(__GPIO_MODULE_I2C2_PB10_11+0)
MOVW	R0, #34464
MOVT	R0, #1
BL	_I2C2_Init_Advanced+0
;gla.h,52 :: 		Delay_ms(100);
MOVW	R7, #4521
MOVT	R7, #4
NOP
NOP
L_InitI2C25:
SUBS	R7, R7, #1
BNE	L_InitI2C25
NOP
NOP
;gla.h,53 :: 		}
L_end_InitI2C2:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _InitI2C2
_InitI2C1:
;gla.h,57 :: 		void InitI2C1()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;gla.h,60 :: 		GPIO_Digital_Output(&GPIOB_BASE, _GPIO_PINMASK_6);           // Set GPIOC pin 10 as digital output
MOVW	R1, #64
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Output+0
;gla.h,61 :: 		GPIO_Digital_Output(&GPIOB_BASE, _GPIO_PINMASK_7);
MOVW	R1, #128
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Output+0
;gla.h,63 :: 		I2C1_Init_Advanced(100000, &_GPIO_MODULE_I2C1_PB67);
MOVW	R1, #lo_addr(__GPIO_MODULE_I2C1_PB67+0)
MOVT	R1, #hi_addr(__GPIO_MODULE_I2C1_PB67+0)
MOVW	R0, #34464
MOVT	R0, #1
BL	_I2C1_Init_Advanced+0
;gla.h,64 :: 		I2C_Set_Active(&I2C1_Start, &I2C1_Read, &I2C1_Write); // Sets the I2C1 module active
MOVW	R2, #lo_addr(_I2C1_Write+0)
MOVT	R2, #hi_addr(_I2C1_Write+0)
MOVW	R1, #lo_addr(_I2C1_Read+0)
MOVT	R1, #hi_addr(_I2C1_Read+0)
MOVW	R0, #lo_addr(_I2C1_Start+0)
MOVT	R0, #hi_addr(_I2C1_Start+0)
BL	_I2C_Set_Active+0
;gla.h,65 :: 		Delay_ms(100);
MOVW	R7, #4521
MOVT	R7, #4
NOP
NOP
L_InitI2C17:
SUBS	R7, R7, #1
BNE	L_InitI2C17
NOP
NOP
;gla.h,66 :: 		}
L_end_InitI2C1:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _InitI2C1
_setupGPIO:
;gla.h,71 :: 		void setupGPIO()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;gla.h,73 :: 		GPIO_Config(&GPIOA_BASE, _GPIO_PINMASK_LOW, _GPIO_CFG_PULL_UP|_GPIO_CFG_DIGITAL_INPUT); // résistance de pull-up par programmation
MOVS	R2, #194
MOVW	R1, #255
MOVW	R0, #lo_addr(GPIOA_BASE+0)
MOVT	R0, #hi_addr(GPIOA_BASE+0)
BL	_GPIO_Config+0
;gla.h,74 :: 		GPIO_Config(&GPIOA_BASE, _GPIO_PINMASK_8, _GPIO_CFG_PULL_UP|_GPIO_CFG_DIGITAL_INPUT); // résistance de pull-up par programmation
MOVS	R2, #194
MOVW	R1, #256
MOVW	R0, #lo_addr(GPIOA_BASE+0)
MOVT	R0, #hi_addr(GPIOA_BASE+0)
BL	_GPIO_Config+0
;gla.h,75 :: 		}
L_end_setupGPIO:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _setupGPIO
_Trame_Test:
;can.h,20 :: 		void Trame_Test (void)
;can.h,22 :: 		RxTx_Data[0] =1;      // set initial data to be sent
MOVS	R1, #1
MOVW	R0, #lo_addr(_RxTx_Data+0)
MOVT	R0, #hi_addr(_RxTx_Data+0)
STRB	R1, [R0, #0]
;can.h,23 :: 		RxTx_Data[1] =2;
MOVS	R1, #2
MOVW	R0, #lo_addr(_RxTx_Data+1)
MOVT	R0, #hi_addr(_RxTx_Data+1)
STRB	R1, [R0, #0]
;can.h,24 :: 		RxTx_Data[2] =3;
MOVS	R1, #3
MOVW	R0, #lo_addr(_RxTx_Data+2)
MOVT	R0, #hi_addr(_RxTx_Data+2)
STRB	R1, [R0, #0]
;can.h,25 :: 		RxTx_Data[3] =4;
MOVS	R1, #4
MOVW	R0, #lo_addr(_RxTx_Data+3)
MOVT	R0, #hi_addr(_RxTx_Data+3)
STRB	R1, [R0, #0]
;can.h,26 :: 		RxTx_Data[4] =5;
MOVS	R1, #5
MOVW	R0, #lo_addr(_RxTx_Data+4)
MOVT	R0, #hi_addr(_RxTx_Data+4)
STRB	R1, [R0, #0]
;can.h,27 :: 		RxTx_Data[5] =6;
MOVS	R1, #6
MOVW	R0, #lo_addr(_RxTx_Data+5)
MOVT	R0, #hi_addr(_RxTx_Data+5)
STRB	R1, [R0, #0]
;can.h,28 :: 		RxTx_Data[6] =7;
MOVS	R1, #7
MOVW	R0, #lo_addr(_RxTx_Data+6)
MOVT	R0, #hi_addr(_RxTx_Data+6)
STRB	R1, [R0, #0]
;can.h,30 :: 		}
L_end_Trame_Test:
BX	LR
; end of _Trame_Test
_Send_Can:
;can.h,33 :: 		void Send_Can ( void )
SUB	SP, SP, #4
STR	LR, [SP, #0]
;can.h,35 :: 		CAN1Write(ID_1st, RxTx_Data, 7, Can_Send_Flags); // send initial message
MOVW	R0, #lo_addr(_Can_Send_Flags+0)
MOVT	R0, #hi_addr(_Can_Send_Flags+0)
LDRB	R0, [R0, #0]
UXTB	R3, R0
MOVS	R2, #7
MOVW	R1, #lo_addr(_RxTx_Data+0)
MOVT	R1, #hi_addr(_RxTx_Data+0)
MOV	R0, #8
BL	_CAN1Write+0
;can.h,37 :: 		for (compt=0;compt<=30;compt++) {  // endless loop
MOVS	R1, #0
MOVW	R0, #lo_addr(_compt+0)
MOVT	R0, #hi_addr(_compt+0)
STRB	R1, [R0, #0]
L_Send_Can9:
MOVW	R0, #lo_addr(_compt+0)
MOVT	R0, #hi_addr(_compt+0)
LDRB	R0, [R0, #0]
CMP	R0, #30
IT	HI
BHI	L_Send_Can10
;can.h,38 :: 		Msg_Rcvd = CAN1Read(0, &Rx_ID , Rx_Data , &Rx_Data_Len, &Can_Rcv_Flags);  // receive message
MOVW	R0, #lo_addr(_Can_Rcv_Flags+0)
MOVT	R0, #hi_addr(_Can_Rcv_Flags+0)
PUSH	(R0)
MOVW	R3, #lo_addr(_Rx_Data_Len+0)
MOVT	R3, #hi_addr(_Rx_Data_Len+0)
MOVW	R2, #lo_addr(_Rx_Data+0)
MOVT	R2, #hi_addr(_Rx_Data+0)
MOVW	R1, #lo_addr(_Rx_ID+0)
MOVT	R1, #hi_addr(_Rx_ID+0)
MOVS	R0, #0
BL	_CAN1Read+0
ADD	SP, SP, #4
MOVW	R1, #lo_addr(_Msg_Rcvd+0)
MOVT	R1, #hi_addr(_Msg_Rcvd+0)
STRB	R0, [R1, #0]
;can.h,39 :: 		if (((Rx_ID == ID_2nd)||Rx_ID == ID_1st) && Msg_Rcvd) {                                        // if message received check id
MOVW	R0, #lo_addr(_Rx_ID+0)
MOVT	R0, #hi_addr(_Rx_ID+0)
LDR	R0, [R0, #0]
CMP	R0, #37
IT	EQ
BEQ	L__Send_Can127
MOVW	R0, #lo_addr(_Rx_ID+0)
MOVT	R0, #hi_addr(_Rx_ID+0)
LDR	R0, [R0, #0]
CMP	R0, #8
IT	EQ
BEQ	L__Send_Can126
IT	AL
BAL	L_Send_Can16
L__Send_Can127:
L__Send_Can126:
MOVW	R0, #lo_addr(_Msg_Rcvd+0)
MOVT	R0, #hi_addr(_Msg_Rcvd+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L__Send_Can128
L__Send_Can124:
;can.h,42 :: 		Delay_ms(10);
MOVW	R7, #26665
MOVT	R7, #0
NOP
NOP
L_Send_Can17:
SUBS	R7, R7, #1
BNE	L_Send_Can17
NOP
NOP
;can.h,43 :: 		CAN1Write(ID_1st,RxTx_Data, 1, Can_Send_Flags);
MOVW	R0, #lo_addr(_Can_Send_Flags+0)
MOVT	R0, #hi_addr(_Can_Send_Flags+0)
LDRB	R0, [R0, #0]
UXTB	R3, R0
MOVS	R2, #1
MOVW	R1, #lo_addr(_RxTx_Data+0)
MOVT	R1, #hi_addr(_RxTx_Data+0)
MOV	R0, #8
BL	_CAN1Write+0
;can.h,44 :: 		break ;
IT	AL
BAL	L_Send_Can10
;can.h,45 :: 		}
L_Send_Can16:
;can.h,39 :: 		if (((Rx_ID == ID_2nd)||Rx_ID == ID_1st) && Msg_Rcvd) {                                        // if message received check id
L__Send_Can128:
;can.h,46 :: 		if (compt >= 30){PrintString ("!!!!!!! time-out !!!!!!!!");}
MOVW	R0, #lo_addr(_compt+0)
MOVT	R0, #hi_addr(_compt+0)
LDRB	R0, [R0, #0]
CMP	R0, #30
IT	CC
BCC	L_Send_Can19
MOVW	R0, #lo_addr(?lstr2_Optique+0)
MOVT	R0, #hi_addr(?lstr2_Optique+0)
BL	_PrintString+0
L_Send_Can19:
;can.h,37 :: 		for (compt=0;compt<=30;compt++) {  // endless loop
MOVW	R1, #lo_addr(_compt+0)
MOVT	R1, #hi_addr(_compt+0)
LDRB	R0, [R1, #0]
ADDS	R0, R0, #1
STRB	R0, [R1, #0]
;can.h,47 :: 		}
IT	AL
BAL	L_Send_Can9
L_Send_Can10:
;can.h,49 :: 		}
L_end_Send_Can:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Send_Can
_initCAN:
;can.h,52 :: 		void initCAN (void)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;can.h,61 :: 		GPIO_Digital_Input(&GPIOB_BASE, _GPIO_PINMASK_8);
MOVW	R1, #256
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Input+0
;can.h,62 :: 		GPIO_Digital_Output(&GPIOB_BASE, _GPIO_PINMASK_9);
MOVW	R1, #512
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Output+0
;can.h,63 :: 		GPIOE_ODR  = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
;can.h,65 :: 		Can_Init_Flags = 0;                                       //
MOVS	R0, #0
MOVW	R3, #lo_addr(_Can_Init_Flags+0)
MOVT	R3, #hi_addr(_Can_Init_Flags+0)
STR	R0, [R3, #0]
;can.h,66 :: 		Can_Send_Flags = 0;                                       // clear flags
MOVS	R0, #0
MOVW	R2, #lo_addr(_Can_Send_Flags+0)
MOVT	R2, #hi_addr(_Can_Send_Flags+0)
STRB	R0, [R2, #0]
;can.h,67 :: 		Can_Rcv_Flags  = 0;                                       //
MOVS	R1, #0
MOVW	R0, #lo_addr(_Can_Rcv_Flags+0)
MOVT	R0, #hi_addr(_Can_Rcv_Flags+0)
STRB	R1, [R0, #0]
;can.h,70 :: 		_CAN_TX_NO_RTR_FRAME;
MOVS	R0, #255
STRB	R0, [R2, #0]
;can.h,76 :: 		_CAN_CONFIG_WAKE_UP;
MOV	R0, #-1
STR	R0, [R3, #0]
;can.h,78 :: 		CAN1InitializeAdvanced(SJW, BRP, PHSEG1, PHSEG2, PROPSEG,Can_Init_Flags, &_GPIO_MODULE_CAN1_PB89); // Initialize CAN module   (125Kb/s uc 8Mhz)
MOVW	R2, #lo_addr(__GPIO_MODULE_CAN1_PB89+0)
MOVT	R2, #hi_addr(__GPIO_MODULE_CAN1_PB89+0)
MOV	R1, #-1
MOVW	R0, #8
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
MOVW	R3, #2
MOVW	R2, #5
MOVW	R1, #4
MOVW	R0, #1
BL	_CAN1InitializeAdvanced+0
ADD	SP, SP, #12
;can.h,80 :: 		CANSetFilterScale32(0, _CAN_FILTER_ENABLED & _CAN_FILTER_ID_MASK_MODE & _CAN_FILTER_STD_MSG, ID_2nd, -1);
MOV	R3, #-1
MOV	R2, #37
MOVS	R1, #247
MOVS	R0, #0
BL	_CANSetFilterScale32+0
;can.h,82 :: 		CAN1SetOperationMode(_CAN_OperatingMode_Normal); // set NORMAL mode
MOVS	R0, #1
BL	_CAN1SetOperationMode+0
;can.h,83 :: 		}
L_end_initCAN:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _initCAN
_TEST_CAN:
;can.h,85 :: 		void TEST_CAN()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;can.h,87 :: 		PrintString ("---------init can---------");
MOVW	R0, #lo_addr(?lstr3_Optique+0)
MOVT	R0, #hi_addr(?lstr3_Optique+0)
BL	_PrintString+0
;can.h,88 :: 		initCAN ();  // init can PB8,9 (125Kb/S uc 8Mhz)
BL	_initCAN+0
;can.h,89 :: 		Delay_100ms();
BL	_Delay_100ms+0
;can.h,90 :: 		Trame_Test ();
BL	_Trame_Test+0
;can.h,91 :: 		Send_Can ();
BL	_Send_Can+0
;can.h,92 :: 		}
L_end_TEST_CAN:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _TEST_CAN
_EXPAND_Reset:
;expand2click.h,274 :: 		void EXPAND_Reset(){
;expand2click.h,275 :: 		EXPAND_RST = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;expand2click.h,276 :: 		Delay_ms(5);
MOVW	R7, #13331
MOVT	R7, #0
NOP
NOP
L_EXPAND_Reset20:
SUBS	R7, R7, #1
BNE	L_EXPAND_Reset20
NOP
NOP
NOP
NOP
;expand2click.h,277 :: 		EXPAND_RST = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;expand2click.h,278 :: 		Delay_ms(5);
MOVW	R7, #13331
MOVT	R7, #0
NOP
NOP
L_EXPAND_Reset22:
SUBS	R7, R7, #1
BNE	L_EXPAND_Reset22
NOP
NOP
NOP
NOP
;expand2click.h,279 :: 		EXPAND_RST = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;expand2click.h,280 :: 		Delay_ms(1);
MOVW	R7, #2665
MOVT	R7, #0
NOP
NOP
L_EXPAND_Reset24:
SUBS	R7, R7, #1
BNE	L_EXPAND_Reset24
NOP
NOP
;expand2click.h,281 :: 		}
L_end_EXPAND_Reset:
BX	LR
; end of _EXPAND_Reset
_Expander_Read_Byte:
;expand2click.h,283 :: 		char Expander_Read_Byte(char ModuleAddress, char RegAddress){
; RegAddress start address is: 4 (R1)
; ModuleAddress start address is: 0 (R0)
SUB	SP, SP, #8
STR	LR, [SP, #0]
UXTB	R10, R0
; RegAddress end address is: 4 (R1)
; ModuleAddress end address is: 0 (R0)
; ModuleAddress start address is: 40 (R10)
; RegAddress start address is: 4 (R1)
;expand2click.h,287 :: 		reg_data[0]=RegAddress;
ADD	R2, SP, #4
STRB	R1, [R2, #0]
; RegAddress end address is: 4 (R1)
;expand2click.h,289 :: 		I2C2_Start();
BL	_I2C2_Start+0
;expand2click.h,290 :: 		I2C2_Write(AddressCode|ModuleAddress,reg_data,1,END_MODE_RESTART);
ADD	R3, SP, #4
ORR	R2, R10, #32
MOV	R1, R3
MOVW	R3, #0
UXTB	R0, R2
MOVS	R2, #1
BL	_I2C2_Write+0
;expand2click.h,291 :: 		I2C2_Read(AddressCode|ModuleAddress,reg_data,1,END_MODE_STOP);
ADD	R3, SP, #4
ORR	R2, R10, #32
; ModuleAddress end address is: 40 (R10)
MOV	R1, R3
MOVW	R3, #1
UXTB	R0, R2
MOVS	R2, #1
BL	_I2C2_Read+0
;expand2click.h,293 :: 		temp=reg_data[0];
ADD	R2, SP, #4
LDRB	R2, [R2, #0]
;expand2click.h,294 :: 		return temp;
UXTB	R0, R2
;expand2click.h,295 :: 		}
L_end_Expander_Read_Byte:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _Expander_Read_Byte
_Expander_Write_Byte:
;expand2click.h,297 :: 		void Expander_Write_Byte(char ModuleAddress,char RegAddress, char Data_) {
; Data_ start address is: 8 (R2)
; RegAddress start address is: 4 (R1)
; ModuleAddress start address is: 0 (R0)
SUB	SP, SP, #8
STR	LR, [SP, #0]
UXTB	R5, R0
; Data_ end address is: 8 (R2)
; RegAddress end address is: 4 (R1)
; ModuleAddress end address is: 0 (R0)
; ModuleAddress start address is: 20 (R5)
; RegAddress start address is: 4 (R1)
; Data_ start address is: 8 (R2)
;expand2click.h,300 :: 		reg_data[0]=RegAddress;
ADD	R3, SP, #4
STRB	R1, [R3, #0]
; RegAddress end address is: 4 (R1)
;expand2click.h,301 :: 		reg_data[1]=Data_;
ADDS	R3, R3, #1
STRB	R2, [R3, #0]
; Data_ end address is: 8 (R2)
;expand2click.h,303 :: 		I2C2_Start();
BL	_I2C2_Start+0
;expand2click.h,304 :: 		I2C2_Write(AddressCode|ModuleAddress,reg_data,2,END_MODE_STOP);
ADD	R4, SP, #4
ORR	R3, R5, #32
; ModuleAddress end address is: 20 (R5)
MOVS	R2, #2
MOV	R1, R4
UXTB	R0, R3
MOVW	R3, #1
BL	_I2C2_Write+0
;expand2click.h,305 :: 		}
L_end_Expander_Write_Byte:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _Expander_Write_Byte
_PCA9956_Write_Byte:
;pca9956.h,52 :: 		void PCA9956_Write_Byte(char ModuleAddress,char RegAddress, char Data_) {
; Data_ start address is: 8 (R2)
; RegAddress start address is: 4 (R1)
; ModuleAddress start address is: 0 (R0)
SUB	SP, SP, #8
STR	LR, [SP, #0]
UXTB	R5, R0
; Data_ end address is: 8 (R2)
; RegAddress end address is: 4 (R1)
; ModuleAddress end address is: 0 (R0)
; ModuleAddress start address is: 20 (R5)
; RegAddress start address is: 4 (R1)
; Data_ start address is: 8 (R2)
;pca9956.h,55 :: 		reg_data[0]=RegAddress;
ADD	R3, SP, #4
STRB	R1, [R3, #0]
; RegAddress end address is: 4 (R1)
;pca9956.h,56 :: 		reg_data[1]=Data_;
ADDS	R3, R3, #1
STRB	R2, [R3, #0]
; Data_ end address is: 8 (R2)
;pca9956.h,58 :: 		I2C2_Start();
BL	_I2C2_Start+0
;pca9956.h,59 :: 		I2C2_Write(ModuleAddress,reg_data,2,END_MODE_STOP);
ADD	R3, SP, #4
MOVS	R2, #2
MOV	R1, R3
MOVW	R3, #1
UXTB	R0, R5
; ModuleAddress end address is: 20 (R5)
BL	_I2C2_Write+0
;pca9956.h,60 :: 		}
L_end_PCA9956_Write_Byte:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _PCA9956_Write_Byte
_MCP:
;pca9956.h,61 :: 		void MCP(char ModuleAddress,int red, int green, int blue, char N_LED)
; red start address is: 4 (R1)
; ModuleAddress start address is: 0 (R0)
SUB	SP, SP, #12
STR	LR, [SP, #0]
UXTB	R11, R0
SXTH	R12, R1
STRH	R2, [SP, #4]
STRH	R3, [SP, #8]
; red end address is: 4 (R1)
; ModuleAddress end address is: 0 (R0)
; ModuleAddress start address is: 44 (R11)
; red start address is: 48 (R12)
LDRB	R4, [SP, #12]
STRB	R4, [SP, #12]
;pca9956.h,68 :: 		InitI2C2();
BL	_InitI2C2+0
;pca9956.h,70 :: 		if (ModuleAddress<=0x0D)
CMP	R11, #13
IT	HI
BHI	L_MCP26
;pca9956.h,72 :: 		PrintString ("condition _1");
MOVW	R4, #lo_addr(?lstr4_Optique+0)
MOVT	R4, #hi_addr(?lstr4_Optique+0)
MOV	R0, R4
BL	_PrintString+0
;pca9956.h,73 :: 		Expander_Write_Byte(EXPAND_ADDR, GPIOB_BANK0,0x00);
MOVS	R2, #0
MOVS	R1, #19
MOVS	R0, #32
BL	_Expander_Write_Byte+0
;pca9956.h,75 :: 		Expander_Write_Byte(EXPAND_ADDR, IODIRA_BANK0, 0x00);       // Set Expander's PORTA to be output
MOVS	R2, #0
MOVS	R1, #0
MOVS	R0, #32
BL	_Expander_Write_Byte+0
;pca9956.h,76 :: 		Expander_Write_Byte(EXPAND_ADDR, GPIOA_BANK0,0x00); // reset
MOVS	R2, #0
MOVS	R1, #18
MOVS	R0, #32
BL	_Expander_Write_Byte+0
;pca9956.h,77 :: 		Expander_Write_Byte(EXPAND_ADDR, GPIOA_BANK0,MCP_OE[ModuleAddress - 10]);
SUB	R5, R11, #10
SXTH	R5, R5
MOVW	R4, #lo_addr(_MCP_OE+0)
MOVT	R4, #hi_addr(_MCP_OE+0)
ADDS	R4, R4, R5
LDRB	R4, [R4, #0]
UXTB	R2, R4
MOVS	R1, #18
MOVS	R0, #32
BL	_Expander_Write_Byte+0
;pca9956.h,78 :: 		}
L_MCP26:
;pca9956.h,79 :: 		if (ModuleAddress>=0x0E)
CMP	R11, #14
IT	CC
BCC	L_MCP27
;pca9956.h,81 :: 		PrintString ("condition _2");
MOVW	R4, #lo_addr(?lstr5_Optique+0)
MOVT	R4, #hi_addr(?lstr5_Optique+0)
MOV	R0, R4
BL	_PrintString+0
;pca9956.h,82 :: 		Expander_Write_Byte(EXPAND_ADDR, GPIOA_BANK0,0x00);
MOVS	R2, #0
MOVS	R1, #18
MOVS	R0, #32
BL	_Expander_Write_Byte+0
;pca9956.h,84 :: 		Expander_Write_Byte(EXPAND_ADDR, IODIRB_BANK0, 0x00);       // Set Expander's PORTB to be output
MOVS	R2, #0
MOVS	R1, #1
MOVS	R0, #32
BL	_Expander_Write_Byte+0
;pca9956.h,85 :: 		Expander_Write_Byte(EXPAND_ADDR, GPIOB_BANK0,0x00); // reset
MOVS	R2, #0
MOVS	R1, #19
MOVS	R0, #32
BL	_Expander_Write_Byte+0
;pca9956.h,86 :: 		Expander_Write_Byte(EXPAND_ADDR, GPIOB_BANK0,MCP_OE[ModuleAddress - 14]);
SUB	R5, R11, #14
SXTH	R5, R5
MOVW	R4, #lo_addr(_MCP_OE+0)
MOVT	R4, #hi_addr(_MCP_OE+0)
ADDS	R4, R4, R5
LDRB	R4, [R4, #0]
UXTB	R2, R4
MOVS	R1, #19
MOVS	R0, #32
BL	_Expander_Write_Byte+0
;pca9956.h,87 :: 		}
L_MCP27:
;pca9956.h,93 :: 		PCA9956_Write_Byte(ModuleAddress, IREFALL, OutputGain_LED);
MOVS	R2, #150
MOVS	R1, #64
UXTB	R0, R11
BL	_PCA9956_Write_Byte+0
;pca9956.h,95 :: 		PCA9956_Write_Byte(ModuleAddress, LEDOUT0, Outputmode_LED); //V
MOVS	R2, #170
MOVS	R1, #2
UXTB	R0, R11
BL	_PCA9956_Write_Byte+0
;pca9956.h,96 :: 		PCA9956_Write_Byte(ModuleAddress, LEDOUT1, Outputmode_LED); //V
MOVS	R2, #170
MOVS	R1, #3
UXTB	R0, R11
BL	_PCA9956_Write_Byte+0
;pca9956.h,97 :: 		PCA9956_Write_Byte(ModuleAddress, LEDOUT2, Outputmode_LED); //V
MOVS	R2, #170
MOVS	R1, #4
UXTB	R0, R11
BL	_PCA9956_Write_Byte+0
;pca9956.h,98 :: 		PCA9956_Write_Byte(ModuleAddress, LEDOUT3, Outputmode_LED); //V
MOVS	R2, #170
MOVS	R1, #5
UXTB	R0, R11
BL	_PCA9956_Write_Byte+0
;pca9956.h,99 :: 		PCA9956_Write_Byte(ModuleAddress, LEDOUT4, Outputmode_LED); //V
MOVS	R2, #170
MOVS	R1, #6
UXTB	R0, R11
BL	_PCA9956_Write_Byte+0
;pca9956.h,100 :: 		PCA9956_Write_Byte(ModuleAddress, LEDOUT5, Outputmode_LED); //V
MOVS	R2, #170
MOVS	R1, #7
UXTB	R0, R11
BL	_PCA9956_Write_Byte+0
;pca9956.h,106 :: 		switch (N_LED)
IT	AL
BAL	L_MCP28
;pca9956.h,108 :: 		case 0:
L_MCP30:
;pca9956.h,109 :: 		PrintString ("case_0");
MOVW	R4, #lo_addr(?lstr6_Optique+0)
MOVT	R4, #hi_addr(?lstr6_Optique+0)
MOV	R0, R4
BL	_PrintString+0
;pca9956.h,110 :: 		PCA9956_Write_Byte(ModuleAddress, PWM0, blue);
LDRSH	R2, [SP, #8]
MOVS	R1, #10
UXTB	R0, R11
BL	_PCA9956_Write_Byte+0
;pca9956.h,111 :: 		PCA9956_Write_Byte(ModuleAddress, PWM1, green);
LDRSH	R2, [SP, #4]
MOVS	R1, #11
UXTB	R0, R11
BL	_PCA9956_Write_Byte+0
;pca9956.h,112 :: 		PCA9956_Write_Byte(ModuleAddress, PWM2, red);
UXTB	R2, R12
MOVS	R1, #12
UXTB	R0, R11
BL	_PCA9956_Write_Byte+0
;pca9956.h,113 :: 		PCA9956_Write_Byte(ModuleAddress, PWM3, blue);
LDRSH	R2, [SP, #8]
MOVS	R1, #13
UXTB	R0, R11
BL	_PCA9956_Write_Byte+0
;pca9956.h,114 :: 		PCA9956_Write_Byte(ModuleAddress, PWM4, green);
LDRSH	R2, [SP, #4]
MOVS	R1, #14
UXTB	R0, R11
BL	_PCA9956_Write_Byte+0
;pca9956.h,115 :: 		PCA9956_Write_Byte(ModuleAddress, PWM5, red);
UXTB	R2, R12
; red end address is: 48 (R12)
MOVS	R1, #15
UXTB	R0, R11
; ModuleAddress end address is: 44 (R11)
BL	_PCA9956_Write_Byte+0
;pca9956.h,117 :: 		break;
IT	AL
BAL	L_MCP29
;pca9956.h,118 :: 		case 1:
L_MCP31:
;pca9956.h,119 :: 		PrintString ("case_1");
; red start address is: 48 (R12)
; ModuleAddress start address is: 44 (R11)
MOVW	R4, #lo_addr(?lstr7_Optique+0)
MOVT	R4, #hi_addr(?lstr7_Optique+0)
MOV	R0, R4
BL	_PrintString+0
;pca9956.h,120 :: 		PCA9956_Write_Byte(ModuleAddress, PWM6, blue);
LDRSH	R2, [SP, #8]
MOVS	R1, #16
UXTB	R0, R11
BL	_PCA9956_Write_Byte+0
;pca9956.h,121 :: 		PCA9956_Write_Byte(ModuleAddress, PWM7, green);
LDRSH	R2, [SP, #4]
MOVS	R1, #17
UXTB	R0, R11
BL	_PCA9956_Write_Byte+0
;pca9956.h,122 :: 		PCA9956_Write_Byte(ModuleAddress, PWM8, red);
UXTB	R2, R12
MOVS	R1, #18
UXTB	R0, R11
BL	_PCA9956_Write_Byte+0
;pca9956.h,123 :: 		PCA9956_Write_Byte(ModuleAddress, PWM9, blue);
LDRSH	R2, [SP, #8]
MOVS	R1, #19
UXTB	R0, R11
BL	_PCA9956_Write_Byte+0
;pca9956.h,124 :: 		PCA9956_Write_Byte(ModuleAddress, PWM10, green);
LDRSH	R2, [SP, #4]
MOVS	R1, #20
UXTB	R0, R11
BL	_PCA9956_Write_Byte+0
;pca9956.h,125 :: 		PCA9956_Write_Byte(ModuleAddress, PWM11, red);
UXTB	R2, R12
; red end address is: 48 (R12)
MOVS	R1, #21
UXTB	R0, R11
; ModuleAddress end address is: 44 (R11)
BL	_PCA9956_Write_Byte+0
;pca9956.h,127 :: 		break;
IT	AL
BAL	L_MCP29
;pca9956.h,128 :: 		case 2:
L_MCP32:
;pca9956.h,129 :: 		PrintString ("case_2");
; red start address is: 48 (R12)
; ModuleAddress start address is: 44 (R11)
MOVW	R4, #lo_addr(?lstr8_Optique+0)
MOVT	R4, #hi_addr(?lstr8_Optique+0)
MOV	R0, R4
BL	_PrintString+0
;pca9956.h,130 :: 		PCA9956_Write_Byte(ModuleAddress, PWM12, blue);
LDRSH	R2, [SP, #8]
MOVS	R1, #22
UXTB	R0, R11
BL	_PCA9956_Write_Byte+0
;pca9956.h,131 :: 		PCA9956_Write_Byte(ModuleAddress, PWM13, green);
LDRSH	R2, [SP, #4]
MOVS	R1, #23
UXTB	R0, R11
BL	_PCA9956_Write_Byte+0
;pca9956.h,132 :: 		PCA9956_Write_Byte(ModuleAddress, PWM14, red);
UXTB	R2, R12
MOVS	R1, #24
UXTB	R0, R11
BL	_PCA9956_Write_Byte+0
;pca9956.h,133 :: 		PCA9956_Write_Byte(ModuleAddress, PWM15, blue);
LDRSH	R2, [SP, #8]
MOVS	R1, #25
UXTB	R0, R11
BL	_PCA9956_Write_Byte+0
;pca9956.h,134 :: 		PCA9956_Write_Byte(ModuleAddress, PWM16, green);
LDRSH	R2, [SP, #4]
MOVS	R1, #26
UXTB	R0, R11
BL	_PCA9956_Write_Byte+0
;pca9956.h,135 :: 		PCA9956_Write_Byte(ModuleAddress, PWM17, red);
UXTB	R2, R12
; red end address is: 48 (R12)
MOVS	R1, #27
UXTB	R0, R11
; ModuleAddress end address is: 44 (R11)
BL	_PCA9956_Write_Byte+0
;pca9956.h,137 :: 		break;
IT	AL
BAL	L_MCP29
;pca9956.h,138 :: 		case 3:
L_MCP33:
;pca9956.h,139 :: 		PrintString ("case_3");
; red start address is: 48 (R12)
; ModuleAddress start address is: 44 (R11)
MOVW	R4, #lo_addr(?lstr9_Optique+0)
MOVT	R4, #hi_addr(?lstr9_Optique+0)
MOV	R0, R4
BL	_PrintString+0
;pca9956.h,140 :: 		PCA9956_Write_Byte(ModuleAddress, PWM18, blue);
LDRSH	R2, [SP, #8]
MOVS	R1, #28
UXTB	R0, R11
BL	_PCA9956_Write_Byte+0
;pca9956.h,141 :: 		PCA9956_Write_Byte(ModuleAddress, PWM19, green);
LDRSH	R2, [SP, #4]
MOVS	R1, #29
UXTB	R0, R11
BL	_PCA9956_Write_Byte+0
;pca9956.h,142 :: 		PCA9956_Write_Byte(ModuleAddress, PWM20, red);
UXTB	R2, R12
MOVS	R1, #30
UXTB	R0, R11
BL	_PCA9956_Write_Byte+0
;pca9956.h,143 :: 		PCA9956_Write_Byte(ModuleAddress, PWM21, blue);
LDRSH	R2, [SP, #8]
MOVS	R1, #31
UXTB	R0, R11
BL	_PCA9956_Write_Byte+0
;pca9956.h,144 :: 		PCA9956_Write_Byte(ModuleAddress, PWM22, green);
LDRSH	R2, [SP, #4]
MOVS	R1, #32
UXTB	R0, R11
BL	_PCA9956_Write_Byte+0
;pca9956.h,145 :: 		PCA9956_Write_Byte(ModuleAddress, PWM23, red);
UXTB	R2, R12
; red end address is: 48 (R12)
MOVS	R1, #33
UXTB	R0, R11
; ModuleAddress end address is: 44 (R11)
BL	_PCA9956_Write_Byte+0
;pca9956.h,147 :: 		break;
IT	AL
BAL	L_MCP29
;pca9956.h,148 :: 		default:
L_MCP34:
;pca9956.h,149 :: 		printString ("Error 1.1");
MOVW	R4, #lo_addr(?lstr10_Optique+0)
MOVT	R4, #hi_addr(?lstr10_Optique+0)
MOV	R0, R4
BL	_PrintString+0
;pca9956.h,150 :: 		break;
IT	AL
BAL	L_MCP29
;pca9956.h,151 :: 		}
L_MCP28:
; red start address is: 48 (R12)
; ModuleAddress start address is: 44 (R11)
LDRB	R4, [SP, #12]
CMP	R4, #0
IT	EQ
BEQ	L_MCP30
LDRB	R4, [SP, #12]
CMP	R4, #1
IT	EQ
BEQ	L_MCP31
LDRB	R4, [SP, #12]
CMP	R4, #2
IT	EQ
BEQ	L_MCP32
LDRB	R4, [SP, #12]
CMP	R4, #3
IT	EQ
BEQ	L_MCP33
; ModuleAddress end address is: 44 (R11)
; red end address is: 48 (R12)
IT	AL
BAL	L_MCP34
L_MCP29:
;pca9956.h,155 :: 		}
L_end_MCP:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _MCP
_test_led:
;pca9956.h,158 :: 		void test_led()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;pca9956.h,160 :: 		for (adress = 10 ; adress <= 17 ; adress++)
MOVS	R1, #10
SXTH	R1, R1
MOVW	R0, #lo_addr(_adress+0)
MOVT	R0, #hi_addr(_adress+0)
STRH	R1, [R0, #0]
L_test_led35:
MOVW	R0, #lo_addr(_adress+0)
MOVT	R0, #hi_addr(_adress+0)
LDRSH	R0, [R0, #0]
CMP	R0, #17
IT	GT
BGT	L_test_led36
;pca9956.h,162 :: 		for (compteur = 0 ; compteur <= 3 ; compteur++)
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_compteur+0)
MOVT	R0, #hi_addr(_compteur+0)
STRH	R1, [R0, #0]
L_test_led38:
MOVW	R0, #lo_addr(_compteur+0)
MOVT	R0, #hi_addr(_compteur+0)
LDRSH	R0, [R0, #0]
CMP	R0, #3
IT	GT
BGT	L_test_led39
;pca9956.h,164 :: 		MCP(adress,256, 256, 80, compteur); //(char ModuleAddress,int red, int green, int blue, char N_LED)
MOVW	R0, #lo_addr(_compteur+0)
MOVT	R0, #hi_addr(_compteur+0)
LDRSH	R1, [R0, #0]
MOVW	R0, #lo_addr(_adress+0)
MOVT	R0, #hi_addr(_adress+0)
LDRSH	R0, [R0, #0]
PUSH	(R1)
MOVS	R3, #80
SXTH	R3, R3
MOVW	R2, #256
SXTH	R2, R2
MOVW	R1, #256
SXTH	R1, R1
BL	_MCP+0
ADD	SP, SP, #4
;pca9956.h,165 :: 		Delay_ms (50);
MOVW	R7, #2259
MOVT	R7, #2
NOP
NOP
L_test_led41:
SUBS	R7, R7, #1
BNE	L_test_led41
NOP
NOP
NOP
NOP
;pca9956.h,166 :: 		MCP(adress,80, 256, 256, compteur); //(char ModuleAddress,int red, int green, int blue, char N_LED)
MOVW	R0, #lo_addr(_compteur+0)
MOVT	R0, #hi_addr(_compteur+0)
LDRSH	R1, [R0, #0]
MOVW	R0, #lo_addr(_adress+0)
MOVT	R0, #hi_addr(_adress+0)
LDRSH	R0, [R0, #0]
PUSH	(R1)
MOVW	R3, #256
SXTH	R3, R3
MOVW	R2, #256
SXTH	R2, R2
MOVS	R1, #80
SXTH	R1, R1
BL	_MCP+0
ADD	SP, SP, #4
;pca9956.h,167 :: 		Delay_ms (50);
MOVW	R7, #2259
MOVT	R7, #2
NOP
NOP
L_test_led43:
SUBS	R7, R7, #1
BNE	L_test_led43
NOP
NOP
NOP
NOP
;pca9956.h,168 :: 		MCP(adress,256, 80, 256, compteur); //(char ModuleAddress,int red, int green, int blue, char N_LED)
MOVW	R0, #lo_addr(_compteur+0)
MOVT	R0, #hi_addr(_compteur+0)
LDRSH	R1, [R0, #0]
MOVW	R0, #lo_addr(_adress+0)
MOVT	R0, #hi_addr(_adress+0)
LDRSH	R0, [R0, #0]
PUSH	(R1)
MOVW	R3, #256
SXTH	R3, R3
MOVS	R2, #80
SXTH	R2, R2
MOVW	R1, #256
SXTH	R1, R1
BL	_MCP+0
ADD	SP, SP, #4
;pca9956.h,169 :: 		Delay_ms (50);
MOVW	R7, #2259
MOVT	R7, #2
NOP
NOP
L_test_led45:
SUBS	R7, R7, #1
BNE	L_test_led45
NOP
NOP
NOP
NOP
;pca9956.h,162 :: 		for (compteur = 0 ; compteur <= 3 ; compteur++)
MOVW	R1, #lo_addr(_compteur+0)
MOVT	R1, #hi_addr(_compteur+0)
LDRSH	R0, [R1, #0]
ADDS	R0, R0, #1
STRH	R0, [R1, #0]
;pca9956.h,171 :: 		}
IT	AL
BAL	L_test_led38
L_test_led39:
;pca9956.h,160 :: 		for (adress = 10 ; adress <= 17 ; adress++)
MOVW	R1, #lo_addr(_adress+0)
MOVT	R1, #hi_addr(_adress+0)
LDRSH	R0, [R1, #0]
ADDS	R0, R0, #1
STRH	R0, [R1, #0]
;pca9956.h,172 :: 		}
IT	AL
BAL	L_test_led35
L_test_led36:
;pca9956.h,174 :: 		}
L_end_test_led:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _test_led
_MCP2:
;pca9956.h,176 :: 		void MCP2(char ModuleAddress,int red, int green, int blue, char N_LED)
; red start address is: 4 (R1)
; ModuleAddress start address is: 0 (R0)
SUB	SP, SP, #12
STR	LR, [SP, #0]
UXTB	R11, R0
SXTH	R12, R1
STRH	R2, [SP, #4]
STRH	R3, [SP, #8]
; red end address is: 4 (R1)
; ModuleAddress end address is: 0 (R0)
; ModuleAddress start address is: 44 (R11)
; red start address is: 48 (R12)
LDRB	R4, [SP, #12]
STRB	R4, [SP, #12]
;pca9956.h,183 :: 		InitI2C2();
BL	_InitI2C2+0
;pca9956.h,186 :: 		Expander_Write_Byte(EXPAND_ADDR, IODIRA_BANK0, 0x00);       // Set Expander's PORTA to be output
MOVS	R2, #0
MOVS	R1, #0
MOVS	R0, #32
BL	_Expander_Write_Byte+0
;pca9956.h,187 :: 		Expander_Write_Byte(EXPAND_ADDR, GPIOA_BANK0,0x00); // reset
MOVS	R2, #0
MOVS	R1, #18
MOVS	R0, #32
BL	_Expander_Write_Byte+0
;pca9956.h,188 :: 		Expander_Write_Byte(EXPAND_ADDR, GPIOA_BANK0,MCP_OE[0x55]);
MOVW	R4, #lo_addr(_MCP_OE+85)
MOVT	R4, #hi_addr(_MCP_OE+85)
LDRB	R4, [R4, #0]
UXTB	R2, R4
MOVS	R1, #18
MOVS	R0, #32
BL	_Expander_Write_Byte+0
;pca9956.h,189 :: 		Expander_Write_Byte(EXPAND_ADDR, IODIRB_BANK0, 0x00);       // Set Expander's PORTB to be output
MOVS	R2, #0
MOVS	R1, #1
MOVS	R0, #32
BL	_Expander_Write_Byte+0
;pca9956.h,190 :: 		Expander_Write_Byte(EXPAND_ADDR, GPIOB_BANK0,0x00); // reset
MOVS	R2, #0
MOVS	R1, #19
MOVS	R0, #32
BL	_Expander_Write_Byte+0
;pca9956.h,191 :: 		Expander_Write_Byte(EXPAND_ADDR, GPIOB_BANK0,MCP_OE[0x55]);
MOVW	R4, #lo_addr(_MCP_OE+85)
MOVT	R4, #hi_addr(_MCP_OE+85)
LDRB	R4, [R4, #0]
UXTB	R2, R4
MOVS	R1, #19
MOVS	R0, #32
BL	_Expander_Write_Byte+0
;pca9956.h,198 :: 		PCA9956_Write_Byte(ModuleAddress, IREFALL, OutputGain_LED);
MOVS	R2, #150
MOVS	R1, #64
UXTB	R0, R11
BL	_PCA9956_Write_Byte+0
;pca9956.h,200 :: 		PCA9956_Write_Byte(ModuleAddress, LEDOUT0, Outputmode_LED); //V
MOVS	R2, #170
MOVS	R1, #2
UXTB	R0, R11
BL	_PCA9956_Write_Byte+0
;pca9956.h,201 :: 		PCA9956_Write_Byte(ModuleAddress, LEDOUT1, Outputmode_LED); //V
MOVS	R2, #170
MOVS	R1, #3
UXTB	R0, R11
BL	_PCA9956_Write_Byte+0
;pca9956.h,202 :: 		PCA9956_Write_Byte(ModuleAddress, LEDOUT2, Outputmode_LED); //V
MOVS	R2, #170
MOVS	R1, #4
UXTB	R0, R11
BL	_PCA9956_Write_Byte+0
;pca9956.h,203 :: 		PCA9956_Write_Byte(ModuleAddress, LEDOUT3, Outputmode_LED); //V
MOVS	R2, #170
MOVS	R1, #5
UXTB	R0, R11
BL	_PCA9956_Write_Byte+0
;pca9956.h,204 :: 		PCA9956_Write_Byte(ModuleAddress, LEDOUT4, Outputmode_LED); //V
MOVS	R2, #170
MOVS	R1, #6
UXTB	R0, R11
BL	_PCA9956_Write_Byte+0
;pca9956.h,205 :: 		PCA9956_Write_Byte(ModuleAddress, LEDOUT5, Outputmode_LED); //V
MOVS	R2, #170
MOVS	R1, #7
UXTB	R0, R11
BL	_PCA9956_Write_Byte+0
;pca9956.h,211 :: 		switch (N_LED)
IT	AL
BAL	L_MCP247
;pca9956.h,213 :: 		case 0:
L_MCP249:
;pca9956.h,214 :: 		PrintString ("case_0");
MOVW	R4, #lo_addr(?lstr11_Optique+0)
MOVT	R4, #hi_addr(?lstr11_Optique+0)
MOV	R0, R4
BL	_PrintString+0
;pca9956.h,215 :: 		PCA9956_Write_Byte(ModuleAddress, PWM0, blue);
LDRSH	R2, [SP, #8]
MOVS	R1, #10
UXTB	R0, R11
BL	_PCA9956_Write_Byte+0
;pca9956.h,216 :: 		PCA9956_Write_Byte(ModuleAddress, PWM1, green);
LDRSH	R2, [SP, #4]
MOVS	R1, #11
UXTB	R0, R11
BL	_PCA9956_Write_Byte+0
;pca9956.h,217 :: 		PCA9956_Write_Byte(ModuleAddress, PWM2, red);
UXTB	R2, R12
MOVS	R1, #12
UXTB	R0, R11
BL	_PCA9956_Write_Byte+0
;pca9956.h,218 :: 		PCA9956_Write_Byte(ModuleAddress, PWM3, blue);
LDRSH	R2, [SP, #8]
MOVS	R1, #13
UXTB	R0, R11
BL	_PCA9956_Write_Byte+0
;pca9956.h,219 :: 		PCA9956_Write_Byte(ModuleAddress, PWM4, green);
LDRSH	R2, [SP, #4]
MOVS	R1, #14
UXTB	R0, R11
BL	_PCA9956_Write_Byte+0
;pca9956.h,220 :: 		PCA9956_Write_Byte(ModuleAddress, PWM5, red);
UXTB	R2, R12
; red end address is: 48 (R12)
MOVS	R1, #15
UXTB	R0, R11
; ModuleAddress end address is: 44 (R11)
BL	_PCA9956_Write_Byte+0
;pca9956.h,222 :: 		break;
IT	AL
BAL	L_MCP248
;pca9956.h,223 :: 		case 1:
L_MCP250:
;pca9956.h,224 :: 		PrintString ("case_1");
; red start address is: 48 (R12)
; ModuleAddress start address is: 44 (R11)
MOVW	R4, #lo_addr(?lstr12_Optique+0)
MOVT	R4, #hi_addr(?lstr12_Optique+0)
MOV	R0, R4
BL	_PrintString+0
;pca9956.h,225 :: 		PCA9956_Write_Byte(ModuleAddress, PWM6, blue);
LDRSH	R2, [SP, #8]
MOVS	R1, #16
UXTB	R0, R11
BL	_PCA9956_Write_Byte+0
;pca9956.h,226 :: 		PCA9956_Write_Byte(ModuleAddress, PWM7, green);
LDRSH	R2, [SP, #4]
MOVS	R1, #17
UXTB	R0, R11
BL	_PCA9956_Write_Byte+0
;pca9956.h,227 :: 		PCA9956_Write_Byte(ModuleAddress, PWM8, red);
UXTB	R2, R12
MOVS	R1, #18
UXTB	R0, R11
BL	_PCA9956_Write_Byte+0
;pca9956.h,228 :: 		PCA9956_Write_Byte(ModuleAddress, PWM9, blue);
LDRSH	R2, [SP, #8]
MOVS	R1, #19
UXTB	R0, R11
BL	_PCA9956_Write_Byte+0
;pca9956.h,229 :: 		PCA9956_Write_Byte(ModuleAddress, PWM10, green);
LDRSH	R2, [SP, #4]
MOVS	R1, #20
UXTB	R0, R11
BL	_PCA9956_Write_Byte+0
;pca9956.h,230 :: 		PCA9956_Write_Byte(ModuleAddress, PWM11, red);
UXTB	R2, R12
; red end address is: 48 (R12)
MOVS	R1, #21
UXTB	R0, R11
; ModuleAddress end address is: 44 (R11)
BL	_PCA9956_Write_Byte+0
;pca9956.h,232 :: 		break;
IT	AL
BAL	L_MCP248
;pca9956.h,233 :: 		case 2:
L_MCP251:
;pca9956.h,234 :: 		PrintString ("case_2");
; red start address is: 48 (R12)
; ModuleAddress start address is: 44 (R11)
MOVW	R4, #lo_addr(?lstr13_Optique+0)
MOVT	R4, #hi_addr(?lstr13_Optique+0)
MOV	R0, R4
BL	_PrintString+0
;pca9956.h,235 :: 		PCA9956_Write_Byte(ModuleAddress, PWM12, blue);
LDRSH	R2, [SP, #8]
MOVS	R1, #22
UXTB	R0, R11
BL	_PCA9956_Write_Byte+0
;pca9956.h,236 :: 		PCA9956_Write_Byte(ModuleAddress, PWM13, green);
LDRSH	R2, [SP, #4]
MOVS	R1, #23
UXTB	R0, R11
BL	_PCA9956_Write_Byte+0
;pca9956.h,237 :: 		PCA9956_Write_Byte(ModuleAddress, PWM14, red);
UXTB	R2, R12
MOVS	R1, #24
UXTB	R0, R11
BL	_PCA9956_Write_Byte+0
;pca9956.h,238 :: 		PCA9956_Write_Byte(ModuleAddress, PWM15, blue);
LDRSH	R2, [SP, #8]
MOVS	R1, #25
UXTB	R0, R11
BL	_PCA9956_Write_Byte+0
;pca9956.h,239 :: 		PCA9956_Write_Byte(ModuleAddress, PWM16, green);
LDRSH	R2, [SP, #4]
MOVS	R1, #26
UXTB	R0, R11
BL	_PCA9956_Write_Byte+0
;pca9956.h,240 :: 		PCA9956_Write_Byte(ModuleAddress, PWM17, red);
UXTB	R2, R12
; red end address is: 48 (R12)
MOVS	R1, #27
UXTB	R0, R11
; ModuleAddress end address is: 44 (R11)
BL	_PCA9956_Write_Byte+0
;pca9956.h,242 :: 		break;
IT	AL
BAL	L_MCP248
;pca9956.h,243 :: 		case 3:
L_MCP252:
;pca9956.h,244 :: 		PrintString ("case_3");
; red start address is: 48 (R12)
; ModuleAddress start address is: 44 (R11)
MOVW	R4, #lo_addr(?lstr14_Optique+0)
MOVT	R4, #hi_addr(?lstr14_Optique+0)
MOV	R0, R4
BL	_PrintString+0
;pca9956.h,245 :: 		PCA9956_Write_Byte(ModuleAddress, PWM18, blue);
LDRSH	R2, [SP, #8]
MOVS	R1, #28
UXTB	R0, R11
BL	_PCA9956_Write_Byte+0
;pca9956.h,246 :: 		PCA9956_Write_Byte(ModuleAddress, PWM19, green);
LDRSH	R2, [SP, #4]
MOVS	R1, #29
UXTB	R0, R11
BL	_PCA9956_Write_Byte+0
;pca9956.h,247 :: 		PCA9956_Write_Byte(ModuleAddress, PWM20, red);
UXTB	R2, R12
MOVS	R1, #30
UXTB	R0, R11
BL	_PCA9956_Write_Byte+0
;pca9956.h,248 :: 		PCA9956_Write_Byte(ModuleAddress, PWM21, blue);
LDRSH	R2, [SP, #8]
MOVS	R1, #31
UXTB	R0, R11
BL	_PCA9956_Write_Byte+0
;pca9956.h,249 :: 		PCA9956_Write_Byte(ModuleAddress, PWM22, green);
LDRSH	R2, [SP, #4]
MOVS	R1, #32
UXTB	R0, R11
BL	_PCA9956_Write_Byte+0
;pca9956.h,250 :: 		PCA9956_Write_Byte(ModuleAddress, PWM23, red);
UXTB	R2, R12
; red end address is: 48 (R12)
MOVS	R1, #33
UXTB	R0, R11
; ModuleAddress end address is: 44 (R11)
BL	_PCA9956_Write_Byte+0
;pca9956.h,252 :: 		break;
IT	AL
BAL	L_MCP248
;pca9956.h,253 :: 		default:
L_MCP253:
;pca9956.h,254 :: 		printString ("Error 1.1");
MOVW	R4, #lo_addr(?lstr15_Optique+0)
MOVT	R4, #hi_addr(?lstr15_Optique+0)
MOV	R0, R4
BL	_PrintString+0
;pca9956.h,255 :: 		break;
IT	AL
BAL	L_MCP248
;pca9956.h,256 :: 		}
L_MCP247:
; red start address is: 48 (R12)
; ModuleAddress start address is: 44 (R11)
LDRB	R4, [SP, #12]
CMP	R4, #0
IT	EQ
BEQ	L_MCP249
LDRB	R4, [SP, #12]
CMP	R4, #1
IT	EQ
BEQ	L_MCP250
LDRB	R4, [SP, #12]
CMP	R4, #2
IT	EQ
BEQ	L_MCP251
LDRB	R4, [SP, #12]
CMP	R4, #3
IT	EQ
BEQ	L_MCP252
; ModuleAddress end address is: 44 (R11)
; red end address is: 48 (R12)
IT	AL
BAL	L_MCP253
L_MCP248:
;pca9956.h,260 :: 		}
L_end_MCP2:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _MCP2
_PCA9544A_Write_Byte:
;pca9544a.h,19 :: 		void PCA9544A_Write_Byte(char ModuleAddress,char RegAddress, char Data_) {
; Data_ start address is: 8 (R2)
; RegAddress start address is: 4 (R1)
; ModuleAddress start address is: 0 (R0)
SUB	SP, SP, #8
STR	LR, [SP, #0]
UXTB	R5, R0
; Data_ end address is: 8 (R2)
; RegAddress end address is: 4 (R1)
; ModuleAddress end address is: 0 (R0)
; ModuleAddress start address is: 20 (R5)
; RegAddress start address is: 4 (R1)
; Data_ start address is: 8 (R2)
;pca9544a.h,22 :: 		reg_data[0]=RegAddress;
ADD	R3, SP, #4
STRB	R1, [R3, #0]
; RegAddress end address is: 4 (R1)
;pca9544a.h,23 :: 		reg_data[1]=Data_;
ADDS	R3, R3, #1
STRB	R2, [R3, #0]
; Data_ end address is: 8 (R2)
;pca9544a.h,25 :: 		I2C1_Start();
BL	_I2C1_Start+0
;pca9544a.h,26 :: 		I2C1_Write(ModuleAddress,reg_data,2,END_MODE_STOP);
ADD	R3, SP, #4
MOVS	R2, #2
MOV	R1, R3
MOVW	R3, #1
UXTB	R0, R5
; ModuleAddress end address is: 20 (R5)
BL	_I2C1_Write+0
;pca9544a.h,27 :: 		}
L_end_PCA9544A_Write_Byte:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _PCA9544A_Write_Byte
_PCA9544A_Read_Byte:
;pca9544a.h,29 :: 		char PCA9544A_Read_Byte(char ModuleAddress, char RegAddress){
; RegAddress start address is: 4 (R1)
; ModuleAddress start address is: 0 (R0)
SUB	SP, SP, #8
STR	LR, [SP, #0]
UXTB	R10, R0
; RegAddress end address is: 4 (R1)
; ModuleAddress end address is: 0 (R0)
; ModuleAddress start address is: 40 (R10)
; RegAddress start address is: 4 (R1)
;pca9544a.h,33 :: 		reg_data[0]=RegAddress;
ADD	R2, SP, #4
STRB	R1, [R2, #0]
; RegAddress end address is: 4 (R1)
;pca9544a.h,35 :: 		I2C1_Start();
BL	_I2C1_Start+0
;pca9544a.h,36 :: 		I2C1_Write(ModuleAddress,reg_data,1,END_MODE_RESTART);
ADD	R2, SP, #4
MOVW	R3, #0
MOV	R1, R2
MOVS	R2, #1
UXTB	R0, R10
BL	_I2C1_Write+0
;pca9544a.h,37 :: 		I2C1_Read(ModuleAddress,reg_data,1,END_MODE_STOP);
ADD	R2, SP, #4
MOVW	R3, #1
MOV	R1, R2
MOVS	R2, #1
UXTB	R0, R10
; ModuleAddress end address is: 40 (R10)
BL	_I2C1_Read+0
;pca9544a.h,39 :: 		temp=reg_data[0];
ADD	R2, SP, #4
LDRB	R2, [R2, #0]
;pca9544a.h,40 :: 		return temp;
UXTB	R0, R2
;pca9544a.h,41 :: 		}
L_end_PCA9544A_Read_Byte:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _PCA9544A_Read_Byte
_close_PCA9544:
;pca9544a.h,42 :: 		void close_PCA9544 ()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;pca9544a.h,45 :: 		PCA9544A_Write_Byte(PCA9544A_Address_1 ,PCA9544A_register,PCA9544A_no_channel_selected);
MOVS	R2, #0
MOVS	R1, #0
MOVS	R0, #112
BL	_PCA9544A_Write_Byte+0
;pca9544a.h,46 :: 		PCA9544A_Write_Byte(PCA9544A_Address_2 ,PCA9544A_register,PCA9544A_no_channel_selected);
MOVS	R2, #0
MOVS	R1, #0
MOVS	R0, #113
BL	_PCA9544A_Write_Byte+0
;pca9544a.h,47 :: 		PCA9544A_Write_Byte(PCA9544A_Address_3 ,PCA9544A_register,PCA9544A_no_channel_selected);
MOVS	R2, #0
MOVS	R1, #0
MOVS	R0, #114
BL	_PCA9544A_Write_Byte+0
;pca9544a.h,48 :: 		PCA9544A_Write_Byte(PCA9544A_Address_4 ,PCA9544A_register,PCA9544A_no_channel_selected);
MOVS	R2, #0
MOVS	R1, #0
MOVS	R0, #115
BL	_PCA9544A_Write_Byte+0
;pca9544a.h,49 :: 		PCA9544A_Write_Byte(PCA9544A_Address_5 ,PCA9544A_register,PCA9544A_no_channel_selected);
MOVS	R2, #0
MOVS	R1, #0
MOVS	R0, #116
BL	_PCA9544A_Write_Byte+0
;pca9544a.h,50 :: 		PCA9544A_Write_Byte(PCA9544A_Address_6 ,PCA9544A_register,PCA9544A_no_channel_selected);
MOVS	R2, #0
MOVS	R1, #0
MOVS	R0, #117
BL	_PCA9544A_Write_Byte+0
;pca9544a.h,51 :: 		PCA9544A_Write_Byte(PCA9544A_Address_7 ,PCA9544A_register,PCA9544A_no_channel_selected);
MOVS	R2, #0
MOVS	R1, #0
MOVS	R0, #118
BL	_PCA9544A_Write_Byte+0
;pca9544a.h,52 :: 		PCA9544A_Write_Byte(PCA9544A_Address_8 ,PCA9544A_register,PCA9544A_no_channel_selected);
MOVS	R2, #0
MOVS	R1, #0
MOVS	R0, #119
BL	_PCA9544A_Write_Byte+0
;pca9544a.h,54 :: 		}
L_end_close_PCA9544:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _close_PCA9544
_VCNL4020_Write_Byte:
;vcnl4020.h,107 :: 		void VCNL4020_Write_Byte(char ModuleAddress,char RegAddress, char Data_) {
; Data_ start address is: 8 (R2)
; RegAddress start address is: 4 (R1)
; ModuleAddress start address is: 0 (R0)
SUB	SP, SP, #8
STR	LR, [SP, #0]
UXTB	R5, R0
; Data_ end address is: 8 (R2)
; RegAddress end address is: 4 (R1)
; ModuleAddress end address is: 0 (R0)
; ModuleAddress start address is: 20 (R5)
; RegAddress start address is: 4 (R1)
; Data_ start address is: 8 (R2)
;vcnl4020.h,110 :: 		reg_data[0]=RegAddress;
ADD	R3, SP, #4
STRB	R1, [R3, #0]
; RegAddress end address is: 4 (R1)
;vcnl4020.h,111 :: 		reg_data[1]=Data_;
ADDS	R3, R3, #1
STRB	R2, [R3, #0]
; Data_ end address is: 8 (R2)
;vcnl4020.h,113 :: 		I2C1_Start();
BL	_I2C1_Start+0
;vcnl4020.h,114 :: 		I2C1_Write(ModuleAddress,reg_data,2,END_MODE_STOP);
ADD	R3, SP, #4
MOVS	R2, #2
MOV	R1, R3
MOVW	R3, #1
UXTB	R0, R5
; ModuleAddress end address is: 20 (R5)
BL	_I2C1_Write+0
;vcnl4020.h,115 :: 		}
L_end_VCNL4020_Write_Byte:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _VCNL4020_Write_Byte
_VCNL4020_Read_Byte:
;vcnl4020.h,117 :: 		char VCNL4020_Read_Byte(char ModuleAddress, char RegAddress){
; RegAddress start address is: 4 (R1)
; ModuleAddress start address is: 0 (R0)
SUB	SP, SP, #8
STR	LR, [SP, #0]
UXTB	R10, R0
; RegAddress end address is: 4 (R1)
; ModuleAddress end address is: 0 (R0)
; ModuleAddress start address is: 40 (R10)
; RegAddress start address is: 4 (R1)
;vcnl4020.h,121 :: 		reg_data[0]=RegAddress;
ADD	R2, SP, #4
STRB	R1, [R2, #0]
; RegAddress end address is: 4 (R1)
;vcnl4020.h,123 :: 		I2C1_Start();
BL	_I2C1_Start+0
;vcnl4020.h,124 :: 		I2C1_Write(ModuleAddress,reg_data,1,END_MODE_RESTART);
ADD	R2, SP, #4
MOVW	R3, #0
MOV	R1, R2
MOVS	R2, #1
UXTB	R0, R10
BL	_I2C1_Write+0
;vcnl4020.h,125 :: 		I2C1_Read(ModuleAddress,reg_data,1,END_MODE_STOP);
ADD	R2, SP, #4
MOVW	R3, #1
MOV	R1, R2
MOVS	R2, #1
UXTB	R0, R10
; ModuleAddress end address is: 40 (R10)
BL	_I2C1_Read+0
;vcnl4020.h,127 :: 		temp=reg_data[0];
ADD	R2, SP, #4
LDRB	R2, [R2, #0]
;vcnl4020.h,128 :: 		return temp;
UXTB	R0, R2
;vcnl4020.h,129 :: 		}
L_end_VCNL4020_Read_Byte:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _VCNL4020_Read_Byte
_InitVCNL4020_Periodic2:
;vcnl4020.h,131 :: 		void InitVCNL4020_Periodic2(char N_Sensor, char band)// sensor 0 to 3 & band 0 to 7
SUB	SP, SP, #24
STR	LR, [SP, #0]
STRB	R0, [SP, #8]
STRB	R1, [SP, #12]
;vcnl4020.h,136 :: 		int i = 1;
;vcnl4020.h,138 :: 		char adress_PCA9544 = (PCA9544A_Address_1 + band);
LDRB	R2, [SP, #12]
ADDS	R2, #112
STRB	R2, [SP, #4]
;vcnl4020.h,139 :: 		char PCA9544A_channel = (PCA9544A_channel_0+N_Sensor);
LDRB	R2, [SP, #8]
ADDS	R2, R2, #4
STRB	R2, [SP, #5]
;vcnl4020.h,141 :: 		unsigned char ID=0;
;vcnl4020.h,142 :: 		unsigned char Command=0;
;vcnl4020.h,143 :: 		unsigned char Current=0;
;vcnl4020.h,144 :: 		unsigned int ProxiValue_H=0;
;vcnl4020.h,145 :: 		unsigned int ProxiValue_L=0;
;vcnl4020.h,146 :: 		unsigned int SummeProxiValue_H=0;
;vcnl4020.h,147 :: 		unsigned int SummeProxiValue_L=0;
;vcnl4020.h,148 :: 		unsigned int AverageProxiValue_H=0;
;vcnl4020.h,149 :: 		unsigned int AverageProxiValue_L=0;
;vcnl4020.h,150 :: 		unsigned int AmbiValue=0;
;vcnl4020.h,151 :: 		unsigned char InterruptStatus=0;
;vcnl4020.h,152 :: 		unsigned char InterruptControl=0;
;vcnl4020.h,156 :: 		InitI2C1();
BL	_InitI2C1+0
;vcnl4020.h,157 :: 		PrintString ("adress : ");
MOVW	R2, #lo_addr(?lstr16_Optique+0)
MOVT	R2, #hi_addr(?lstr16_Optique+0)
MOV	R0, R2
BL	_PrintString+0
;vcnl4020.h,158 :: 		PrintDecimal(adress_PCA9544);
LDRB	R0, [SP, #4]
BL	_PrintDecimal+0
;vcnl4020.h,159 :: 		printString ("PCA9544A_channel : ");
MOVW	R2, #lo_addr(?lstr17_Optique+0)
MOVT	R2, #hi_addr(?lstr17_Optique+0)
MOV	R0, R2
BL	_PrintString+0
;vcnl4020.h,160 :: 		PrintString ("\n ");
MOVW	R2, #lo_addr(?lstr18_Optique+0)
MOVT	R2, #hi_addr(?lstr18_Optique+0)
MOV	R0, R2
BL	_PrintString+0
;vcnl4020.h,161 :: 		PrintDecimal(PCA9544A_channel);
LDRB	R0, [SP, #5]
BL	_PrintDecimal+0
;vcnl4020.h,162 :: 		PrintString ("\n ");
MOVW	R2, #lo_addr(?lstr19_Optique+0)
MOVT	R2, #hi_addr(?lstr19_Optique+0)
MOV	R0, R2
BL	_PrintString+0
;vcnl4020.h,163 :: 		close_PCA9544 (); // stop all activities
BL	_close_PCA9544+0
;vcnl4020.h,165 :: 		PCA9544A_Write_Byte(adress_PCA9544,PCA9544A_register,PCA9544A_channel);// Opening the i2C port
LDRB	R2, [SP, #5]
MOVS	R1, #0
LDRB	R0, [SP, #4]
BL	_PCA9544A_Write_Byte+0
;vcnl4020.h,167 :: 		VCNL4020_Write_Byte(VCNL4020_Address,REGISTER_COMMAND,COMMAND_ALL_DISABLE);
MOVS	R2, #0
MOVS	R1, #128
MOVS	R0, #19
BL	_VCNL4020_Write_Byte+0
;vcnl4020.h,169 :: 		VCNL4020_Write_Byte(VCNL4020_Address,REGISTER_PROX_RATE,PROX_MEASUREMENT_RATE_31);
MOVS	R2, #4
MOVS	R1, #130
MOVS	R0, #19
BL	_VCNL4020_Write_Byte+0
;vcnl4020.h,171 :: 		VCNL4020_Write_Byte(VCNL4020_Address,REGISTER_COMMAND,COMMAND_PROX_ENABLE | COMMAND_SELFTIMED_MODE_ENABLE);
MOVS	R2, #3
MOVS	R1, #128
MOVS	R0, #19
BL	_VCNL4020_Write_Byte+0
;vcnl4020.h,174 :: 		INTERRUPT_THRES_ENABLE | INTERRUPT_COUNT_EXCEED_1);
MOVS	R2, #2
;vcnl4020.h,173 :: 		VCNL4020_Write_Byte(VCNL4020_Address,registerADDR_INTERRUPT,INTERRUPT_THRES_SEL_PROX |
MOVS	R1, #137
MOVS	R0, #19
;vcnl4020.h,174 :: 		INTERRUPT_THRES_ENABLE | INTERRUPT_COUNT_EXCEED_1);
BL	_VCNL4020_Write_Byte+0
;vcnl4020.h,177 :: 		SummeProxiValue_H = 0;
MOVS	R2, #0
STRH	R2, [SP, #16]
;vcnl4020.h,178 :: 		SummeProxiValue_L = 0;
MOVS	R2, #0
STRH	R2, [SP, #18]
;vcnl4020.h,179 :: 		for (i=0; i<30; i++) {
MOVS	R2, #0
SXTH	R2, R2
STRH	R2, [SP, #14]
L_InitVCNL4020_Periodic254:
LDRSH	R2, [SP, #14]
CMP	R2, #30
IT	GE
BGE	L_InitVCNL4020_Periodic255
;vcnl4020.h,180 :: 		do { // wait on prox data ready bit
L_InitVCNL4020_Periodic257:
;vcnl4020.h,181 :: 		Command = VCNL4020_Read_Byte(VCNL4020_Address,REGISTER_COMMAND) ;// read command register
MOVS	R1, #128
MOVS	R0, #19
BL	_VCNL4020_Read_Byte+0
;vcnl4020.h,183 :: 		} while (!(Command & COMMAND_MASK_PROX_DATA_READY)); // prox data ready ?
AND	R2, R0, #32
UXTB	R2, R2
CMP	R2, #0
IT	EQ
BEQ	L_InitVCNL4020_Periodic257
;vcnl4020.h,185 :: 		ProxiValue_H = (VCNL4020_Read_Byte(VCNL4020_Address,registerADDR_RESULT_HIGH));// read prox value
MOVS	R1, #135
MOVS	R0, #19
BL	_VCNL4020_Read_Byte+0
; ProxiValue_H start address is: 0 (R0)
;vcnl4020.h,186 :: 		SummeProxiValue_H += ProxiValue_H; // Summary of all measured prox values
LDRH	R2, [SP, #16]
ADDS	R2, R2, R0
; ProxiValue_H end address is: 0 (R0)
STRH	R2, [SP, #16]
;vcnl4020.h,188 :: 		ProxiValue_L = (VCNL4020_Read_Byte(VCNL4020_Address,registerADDR_RESULT_LOW));// read prox value
MOVS	R1, #136
MOVS	R0, #19
BL	_VCNL4020_Read_Byte+0
; ProxiValue_L start address is: 0 (R0)
;vcnl4020.h,189 :: 		SummeProxiValue_L += ProxiValue_L; // Summary of all measured prox values
LDRH	R2, [SP, #18]
ADDS	R2, R2, R0
; ProxiValue_L end address is: 0 (R0)
STRH	R2, [SP, #18]
;vcnl4020.h,179 :: 		for (i=0; i<30; i++) {
LDRSH	R2, [SP, #14]
ADDS	R2, R2, #1
STRH	R2, [SP, #14]
;vcnl4020.h,190 :: 		}
IT	AL
BAL	L_InitVCNL4020_Periodic254
L_InitVCNL4020_Periodic255:
;vcnl4020.h,191 :: 		AverageProxiValue_H = SummeProxiValue_H/30; // calculate average
LDRH	R3, [SP, #16]
MOVS	R2, #30
UDIV	R4, R3, R2
UXTH	R4, R4
; AverageProxiValue_H start address is: 40 (R10)
UXTH	R10, R4
;vcnl4020.h,192 :: 		AverageProxiValue_L = SummeProxiValue_L/30; // calculate average
LDRH	R3, [SP, #18]
MOVS	R2, #30
UDIV	R2, R3, R2
STRH	R2, [SP, #20]
;vcnl4020.h,194 :: 		VCNL4020_Write_Byte(VCNL4020_Address,registerADDR_HIGH_THERSHOLD_H,AverageProxiValue_H+1);
ADDS	R2, R4, #1
UXTB	R2, R2
MOVS	R1, #140
MOVS	R0, #19
BL	_VCNL4020_Write_Byte+0
;vcnl4020.h,195 :: 		VCNL4020_Write_Byte(VCNL4020_Address,registerADDR_HIGH_THERSHOLD_L,(AverageProxiValue_L + 10));
LDRH	R2, [SP, #20]
ADDS	R2, #10
UXTB	R2, R2
MOVS	R1, #141
MOVS	R0, #19
BL	_VCNL4020_Write_Byte+0
;vcnl4020.h,197 :: 		VCNL4020_Write_Byte(VCNL4020_Address,registerADDR_LOW_THERSHOLD_H,AverageProxiValue_H-1);
SUB	R2, R10, #1
UXTB	R2, R2
MOVS	R1, #138
MOVS	R0, #19
BL	_VCNL4020_Write_Byte+0
;vcnl4020.h,198 :: 		VCNL4020_Write_Byte(VCNL4020_Address,registerADDR_LOW_THERSHOLD_L,(AverageProxiValue_L - 10));
LDRH	R2, [SP, #20]
SUBS	R2, #10
UXTB	R2, R2
MOVS	R1, #139
MOVS	R0, #19
BL	_VCNL4020_Write_Byte+0
;vcnl4020.h,205 :: 		PrintString ("\n-----------------HIGH_THRES--------------------- : ");
MOVW	R2, #lo_addr(?lstr20_Optique+0)
MOVT	R2, #hi_addr(?lstr20_Optique+0)
MOV	R0, R2
BL	_PrintString+0
;vcnl4020.h,206 :: 		PrintDecimal(AverageProxiValue_H ) ;
SXTH	R0, R10
; AverageProxiValue_H end address is: 40 (R10)
BL	_PrintDecimal+0
;vcnl4020.h,207 :: 		PrintString ("\n\n");
MOVW	R2, #lo_addr(?lstr21_Optique+0)
MOVT	R2, #hi_addr(?lstr21_Optique+0)
MOV	R0, R2
BL	_PrintString+0
;vcnl4020.h,208 :: 		PrintString ("\n-----------------LOW_THRES--------------------- : ");
MOVW	R2, #lo_addr(?lstr22_Optique+0)
MOVT	R2, #hi_addr(?lstr22_Optique+0)
MOV	R0, R2
BL	_PrintString+0
;vcnl4020.h,209 :: 		PrintDecimal(AverageProxiValue_L ) ;
LDRH	R0, [SP, #20]
BL	_PrintDecimal+0
;vcnl4020.h,210 :: 		PrintString ("\n\n");
MOVW	R2, #lo_addr(?lstr23_Optique+0)
MOVT	R2, #hi_addr(?lstr23_Optique+0)
MOV	R0, R2
BL	_PrintString+0
;vcnl4020.h,213 :: 		do {
L_InitVCNL4020_Periodic260:
;vcnl4020.h,214 :: 		Command = VCNL4020_Read_Byte(VCNL4020_Address,REGISTER_COMMAND) ;// read command register
MOVS	R1, #128
MOVS	R0, #19
BL	_VCNL4020_Read_Byte+0
; Command start address is: 44 (R11)
UXTB	R11, R0
;vcnl4020.h,215 :: 		} while (!(Command & (COMMAND_MASK_PROX_DATA_READY | COMMAND_MASK_AMBI_DATA_READY))); // data ready ?
AND	R2, R0, #96
UXTB	R2, R2
CMP	R2, #0
IT	EQ
BEQ	L_InitVCNL4020_Periodic260
;vcnl4020.h,218 :: 		InterruptStatus = VCNL4020_Read_Byte(VCNL4020_Address,REGISTER_INTERRUPT_STATUS) ;
MOVS	R1, #142
MOVS	R0, #19
BL	_VCNL4020_Read_Byte+0
;vcnl4020.h,220 :: 		if (InterruptStatus & INTERRUPT_STATUS_THRES_HI) {
AND	R2, R0, #1
UXTB	R2, R2
CMP	R2, #0
IT	EQ
BEQ	L_InitVCNL4020_Periodic263
;vcnl4020.h,222 :: 		VCNL4020_Write_Byte(VCNL4020_Address,REGISTER_INTERRUPT_STATUS,0x01); // clear Interrupt Status
MOVS	R2, #1
MOVS	R1, #142
MOVS	R0, #19
BL	_VCNL4020_Write_Byte+0
;vcnl4020.h,225 :: 		PrintString ("\nclear Interrupt Status\n");
MOVW	R2, #lo_addr(?lstr24_Optique+0)
MOVT	R2, #hi_addr(?lstr24_Optique+0)
MOV	R0, R2
BL	_PrintString+0
;vcnl4020.h,226 :: 		}
L_InitVCNL4020_Periodic263:
;vcnl4020.h,228 :: 		if (Command & COMMAND_MASK_PROX_DATA_READY) {
AND	R2, R11, #32
UXTB	R2, R2
; Command end address is: 44 (R11)
CMP	R2, #0
IT	EQ
BEQ	L_InitVCNL4020_Periodic264
;vcnl4020.h,229 :: 		PrintString ("\n");
MOVW	R2, #lo_addr(?lstr25_Optique+0)
MOVT	R2, #hi_addr(?lstr25_Optique+0)
MOV	R0, R2
BL	_PrintString+0
;vcnl4020.h,230 :: 		PrintString ("RESULT : ");
MOVW	R2, #lo_addr(?lstr26_Optique+0)
MOVT	R2, #hi_addr(?lstr26_Optique+0)
MOV	R0, R2
BL	_PrintString+0
;vcnl4020.h,232 :: 		PrintDecimal(VCNL4020_Read_Byte(VCNL4020_Address,registerADDR_RESULT_HIGH)) ;
MOVS	R1, #135
MOVS	R0, #19
BL	_VCNL4020_Read_Byte+0
BL	_PrintDecimal+0
;vcnl4020.h,233 :: 		PrintString (" ");
MOVW	R2, #lo_addr(?lstr27_Optique+0)
MOVT	R2, #hi_addr(?lstr27_Optique+0)
MOV	R0, R2
BL	_PrintString+0
;vcnl4020.h,234 :: 		PrintDecimal(VCNL4020_Read_Byte(VCNL4020_Address,registerADDR_RESULT_LOW)) ;
MOVS	R1, #136
MOVS	R0, #19
BL	_VCNL4020_Read_Byte+0
BL	_PrintDecimal+0
;vcnl4020.h,235 :: 		PrintString ("\n\n");
MOVW	R2, #lo_addr(?lstr28_Optique+0)
MOVT	R2, #hi_addr(?lstr28_Optique+0)
MOV	R0, R2
BL	_PrintString+0
;vcnl4020.h,236 :: 		PrintString ("\n\nStatus : ");
MOVW	R2, #lo_addr(?lstr29_Optique+0)
MOVT	R2, #hi_addr(?lstr29_Optique+0)
MOV	R0, R2
BL	_PrintString+0
;vcnl4020.h,237 :: 		PrintDecimal(VCNL4020_Read_Byte(VCNL4020_Address,REGISTER_INTERRUPT_STATUS)) ;
MOVS	R1, #142
MOVS	R0, #19
BL	_VCNL4020_Read_Byte+0
BL	_PrintDecimal+0
;vcnl4020.h,238 :: 		PrintString ("\n\n");
MOVW	R2, #lo_addr(?lstr30_Optique+0)
MOVT	R2, #hi_addr(?lstr30_Optique+0)
MOV	R0, R2
BL	_PrintString+0
;vcnl4020.h,239 :: 		MCP((0x0A+band),80, 256, 256, N_Sensor); //(char ModuleAddress,int red, int green, int blue, char N_LED)
LDRB	R2, [SP, #12]
ADDW	R3, R2, #10
LDRB	R2, [SP, #8]
PUSH	(R2)
MOVW	R2, #256
SXTH	R2, R2
MOVS	R1, #80
SXTH	R1, R1
UXTB	R0, R3
MOVW	R3, #256
SXTH	R3, R3
BL	_MCP+0
ADD	SP, SP, #4
;vcnl4020.h,240 :: 		PrintString ("\n-----------------CHANNEL_1--------------------- : ");
MOVW	R2, #lo_addr(?lstr31_Optique+0)
MOVT	R2, #hi_addr(?lstr31_Optique+0)
MOV	R0, R2
BL	_PrintString+0
;vcnl4020.h,241 :: 		PrintDecimal(N_Sensor) ;
LDRB	R0, [SP, #8]
BL	_PrintDecimal+0
;vcnl4020.h,242 :: 		PrintString ("\n\n");
MOVW	R2, #lo_addr(?lstr32_Optique+0)
MOVT	R2, #hi_addr(?lstr32_Optique+0)
MOV	R0, R2
BL	_PrintString+0
;vcnl4020.h,243 :: 		PrintString ("\n-----------------BAND_1--------------------- : ");
MOVW	R2, #lo_addr(?lstr33_Optique+0)
MOVT	R2, #hi_addr(?lstr33_Optique+0)
MOV	R0, R2
BL	_PrintString+0
;vcnl4020.h,244 :: 		PrintDecimal(band) ;
LDRB	R0, [SP, #12]
BL	_PrintDecimal+0
;vcnl4020.h,245 :: 		PrintString ("\n\n");
MOVW	R2, #lo_addr(?lstr34_Optique+0)
MOVT	R2, #hi_addr(?lstr34_Optique+0)
MOV	R0, R2
BL	_PrintString+0
;vcnl4020.h,247 :: 		}
L_InitVCNL4020_Periodic264:
;vcnl4020.h,248 :: 		}
L_end_InitVCNL4020_Periodic2:
LDR	LR, [SP, #0]
ADD	SP, SP, #24
BX	LR
; end of _InitVCNL4020_Periodic2
_InitVCNL4020:
;vcnl4020.h,250 :: 		void InitVCNL4020()// 1 to 32
SUB	SP, SP, #4
STR	LR, [SP, #0]
;vcnl4020.h,253 :: 		InitI2C1();
BL	_InitI2C1+0
;vcnl4020.h,254 :: 		close_PCA9544 ();
BL	_close_PCA9544+0
;vcnl4020.h,255 :: 		PCA9544A_Write_Byte(0X70,0x00,0x04); // test
MOVS	R2, #4
MOVS	R1, #0
MOVS	R0, #112
BL	_PCA9544A_Write_Byte+0
;vcnl4020.h,256 :: 		PrintString ("PCA9544A_ACK");
MOVW	R0, #lo_addr(?lstr35_Optique+0)
MOVT	R0, #hi_addr(?lstr35_Optique+0)
BL	_PrintString+0
;vcnl4020.h,257 :: 		VCNL4020_Write_Byte(VCNL4020_Address,registerADDR_Proximity,0x01);
MOVS	R2, #1
MOVS	R1, #130
MOVS	R0, #19
BL	_VCNL4020_Write_Byte+0
;vcnl4020.h,258 :: 		PrintString ("VCNL4020_ACK");
MOVW	R0, #lo_addr(?lstr36_Optique+0)
MOVT	R0, #hi_addr(?lstr36_Optique+0)
BL	_PrintString+0
;vcnl4020.h,259 :: 		VCNL4020_Write_Byte(VCNL4020_Address,registerADDR_IR_LED,0x14);// 140 mA for IR_LED
MOVS	R2, #20
MOVS	R1, #131
MOVS	R0, #19
BL	_VCNL4020_Write_Byte+0
;vcnl4020.h,260 :: 		PrintString ("VCNL4020_ACK_2");
MOVW	R0, #lo_addr(?lstr37_Optique+0)
MOVT	R0, #hi_addr(?lstr37_Optique+0)
BL	_PrintString+0
;vcnl4020.h,261 :: 		VCNL4020_Write_Byte(VCNL4020_Address,registerADDR_Command,0x08);// Start a single measurement for proximity
MOVS	R2, #8
MOVS	R1, #128
MOVS	R0, #19
BL	_VCNL4020_Write_Byte+0
;vcnl4020.h,262 :: 		PrintString ("VCNL4020_ACK_2");
MOVW	R0, #lo_addr(?lstr38_Optique+0)
MOVT	R0, #hi_addr(?lstr38_Optique+0)
BL	_PrintString+0
;vcnl4020.h,263 :: 		Delay_100ms();
BL	_Delay_100ms+0
;vcnl4020.h,264 :: 		}
L_end_InitVCNL4020:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _InitVCNL4020
_InitVCNL4020_Periodic3:
;vcnl4020.h,266 :: 		void InitVCNL4020_Periodic3(char N_Sensor, char band)// sensor 0 to 3 & band 0 to 7
SUB	SP, SP, #24
STR	LR, [SP, #0]
STRB	R0, [SP, #8]
STRB	R1, [SP, #12]
;vcnl4020.h,271 :: 		int i = 1;
;vcnl4020.h,273 :: 		char adress_PCA9544 = (PCA9544A_Address_1 + band);
LDRB	R2, [SP, #12]
ADDS	R2, #112
STRB	R2, [SP, #4]
;vcnl4020.h,274 :: 		char PCA9544A_channel = (PCA9544A_channel_0+N_Sensor);
LDRB	R2, [SP, #8]
ADDS	R2, R2, #4
STRB	R2, [SP, #5]
;vcnl4020.h,276 :: 		unsigned char ID=0;
;vcnl4020.h,277 :: 		unsigned char Command=0;
;vcnl4020.h,278 :: 		unsigned char Current=0;
;vcnl4020.h,279 :: 		unsigned int ProxiValue_H=0;
;vcnl4020.h,280 :: 		unsigned int ProxiValue_L=0;
;vcnl4020.h,281 :: 		unsigned int SummeProxiValue_H=0;
;vcnl4020.h,282 :: 		unsigned int SummeProxiValue_L=0;
;vcnl4020.h,283 :: 		unsigned int AverageProxiValue_H=0;
;vcnl4020.h,284 :: 		unsigned int AverageProxiValue_L=0;
;vcnl4020.h,285 :: 		unsigned int AmbiValue=0;
;vcnl4020.h,286 :: 		unsigned char InterruptStatus=0;
;vcnl4020.h,287 :: 		unsigned char InterruptControl=0;
;vcnl4020.h,291 :: 		InitI2C1();
BL	_InitI2C1+0
;vcnl4020.h,292 :: 		PrintString ("adress : ");
MOVW	R2, #lo_addr(?lstr39_Optique+0)
MOVT	R2, #hi_addr(?lstr39_Optique+0)
MOV	R0, R2
BL	_PrintString+0
;vcnl4020.h,293 :: 		PrintDecimal(adress_PCA9544);
LDRB	R0, [SP, #4]
BL	_PrintDecimal+0
;vcnl4020.h,294 :: 		printString ("PCA9544A_channel : ");
MOVW	R2, #lo_addr(?lstr40_Optique+0)
MOVT	R2, #hi_addr(?lstr40_Optique+0)
MOV	R0, R2
BL	_PrintString+0
;vcnl4020.h,295 :: 		PrintString ("\n ");
MOVW	R2, #lo_addr(?lstr41_Optique+0)
MOVT	R2, #hi_addr(?lstr41_Optique+0)
MOV	R0, R2
BL	_PrintString+0
;vcnl4020.h,296 :: 		PrintDecimal(PCA9544A_channel);
LDRB	R0, [SP, #5]
BL	_PrintDecimal+0
;vcnl4020.h,297 :: 		PrintString ("\n ");
MOVW	R2, #lo_addr(?lstr42_Optique+0)
MOVT	R2, #hi_addr(?lstr42_Optique+0)
MOV	R0, R2
BL	_PrintString+0
;vcnl4020.h,298 :: 		close_PCA9544 (); // stop all activities
BL	_close_PCA9544+0
;vcnl4020.h,300 :: 		PCA9544A_Write_Byte(adress_PCA9544,PCA9544A_register,PCA9544A_channel);// Opening the i2C port
LDRB	R2, [SP, #5]
MOVS	R1, #0
LDRB	R0, [SP, #4]
BL	_PCA9544A_Write_Byte+0
;vcnl4020.h,302 :: 		VCNL4020_Write_Byte(VCNL4020_Address,REGISTER_COMMAND,COMMAND_ALL_DISABLE);
MOVS	R2, #0
MOVS	R1, #128
MOVS	R0, #19
BL	_VCNL4020_Write_Byte+0
;vcnl4020.h,304 :: 		VCNL4020_Write_Byte(VCNL4020_Address,REGISTER_PROX_RATE,PROX_MEASUREMENT_RATE_31);
MOVS	R2, #4
MOVS	R1, #130
MOVS	R0, #19
BL	_VCNL4020_Write_Byte+0
;vcnl4020.h,306 :: 		VCNL4020_Write_Byte(VCNL4020_Address,REGISTER_COMMAND,COMMAND_PROX_ENABLE | COMMAND_SELFTIMED_MODE_ENABLE);
MOVS	R2, #3
MOVS	R1, #128
MOVS	R0, #19
BL	_VCNL4020_Write_Byte+0
;vcnl4020.h,309 :: 		INTERRUPT_THRES_ENABLE | INTERRUPT_COUNT_EXCEED_1);
MOVS	R2, #2
;vcnl4020.h,308 :: 		VCNL4020_Write_Byte(VCNL4020_Address,registerADDR_INTERRUPT,INTERRUPT_THRES_SEL_PROX |
MOVS	R1, #137
MOVS	R0, #19
;vcnl4020.h,309 :: 		INTERRUPT_THRES_ENABLE | INTERRUPT_COUNT_EXCEED_1);
BL	_VCNL4020_Write_Byte+0
;vcnl4020.h,312 :: 		SummeProxiValue_H = 0;
MOVS	R2, #0
STRH	R2, [SP, #16]
;vcnl4020.h,313 :: 		SummeProxiValue_L = 0;
MOVS	R2, #0
STRH	R2, [SP, #18]
;vcnl4020.h,314 :: 		for (i=0; i<10; i++) {
MOVS	R2, #0
SXTH	R2, R2
STRH	R2, [SP, #14]
L_InitVCNL4020_Periodic365:
LDRSH	R2, [SP, #14]
CMP	R2, #10
IT	GE
BGE	L_InitVCNL4020_Periodic366
;vcnl4020.h,315 :: 		do { // wait on prox data ready bit
L_InitVCNL4020_Periodic368:
;vcnl4020.h,316 :: 		Command = VCNL4020_Read_Byte(VCNL4020_Address,REGISTER_COMMAND) ;// read command register
MOVS	R1, #128
MOVS	R0, #19
BL	_VCNL4020_Read_Byte+0
;vcnl4020.h,318 :: 		} while (!(Command & COMMAND_MASK_PROX_DATA_READY)); // prox data ready ?
AND	R2, R0, #32
UXTB	R2, R2
CMP	R2, #0
IT	EQ
BEQ	L_InitVCNL4020_Periodic368
;vcnl4020.h,320 :: 		ProxiValue_H = (VCNL4020_Read_Byte(VCNL4020_Address,registerADDR_RESULT_HIGH));// read prox value
MOVS	R1, #135
MOVS	R0, #19
BL	_VCNL4020_Read_Byte+0
; ProxiValue_H start address is: 0 (R0)
;vcnl4020.h,321 :: 		SummeProxiValue_H += ProxiValue_H; // Summary of all measured prox values
LDRH	R2, [SP, #16]
ADDS	R2, R2, R0
; ProxiValue_H end address is: 0 (R0)
STRH	R2, [SP, #16]
;vcnl4020.h,323 :: 		ProxiValue_L = (VCNL4020_Read_Byte(VCNL4020_Address,registerADDR_RESULT_LOW));// read prox value
MOVS	R1, #136
MOVS	R0, #19
BL	_VCNL4020_Read_Byte+0
; ProxiValue_L start address is: 0 (R0)
;vcnl4020.h,324 :: 		SummeProxiValue_L += ProxiValue_L; // Summary of all measured prox values
LDRH	R2, [SP, #18]
ADDS	R2, R2, R0
; ProxiValue_L end address is: 0 (R0)
STRH	R2, [SP, #18]
;vcnl4020.h,314 :: 		for (i=0; i<10; i++) {
LDRSH	R2, [SP, #14]
ADDS	R2, R2, #1
STRH	R2, [SP, #14]
;vcnl4020.h,325 :: 		}
IT	AL
BAL	L_InitVCNL4020_Periodic365
L_InitVCNL4020_Periodic366:
;vcnl4020.h,326 :: 		AverageProxiValue_H = SummeProxiValue_H/10; // calculate average
LDRH	R3, [SP, #16]
MOVS	R2, #10
UDIV	R4, R3, R2
UXTH	R4, R4
; AverageProxiValue_H start address is: 40 (R10)
UXTH	R10, R4
;vcnl4020.h,327 :: 		AverageProxiValue_L = SummeProxiValue_L/10; // calculate average
LDRH	R3, [SP, #18]
MOVS	R2, #10
UDIV	R2, R3, R2
STRH	R2, [SP, #20]
;vcnl4020.h,329 :: 		VCNL4020_Write_Byte(VCNL4020_Address,registerADDR_HIGH_THERSHOLD_H,AverageProxiValue_H+1);
ADDS	R2, R4, #1
UXTB	R2, R2
MOVS	R1, #140
MOVS	R0, #19
BL	_VCNL4020_Write_Byte+0
;vcnl4020.h,330 :: 		VCNL4020_Write_Byte(VCNL4020_Address,registerADDR_HIGH_THERSHOLD_L,(AverageProxiValue_L ));
LDRH	R2, [SP, #20]
MOVS	R1, #141
MOVS	R0, #19
BL	_VCNL4020_Write_Byte+0
;vcnl4020.h,332 :: 		VCNL4020_Write_Byte(VCNL4020_Address,registerADDR_LOW_THERSHOLD_H,AverageProxiValue_H-1);
SUB	R2, R10, #1
UXTB	R2, R2
MOVS	R1, #138
MOVS	R0, #19
BL	_VCNL4020_Write_Byte+0
;vcnl4020.h,333 :: 		VCNL4020_Write_Byte(VCNL4020_Address,registerADDR_LOW_THERSHOLD_L,(AverageProxiValue_L));
LDRH	R2, [SP, #20]
MOVS	R1, #139
MOVS	R0, #19
BL	_VCNL4020_Write_Byte+0
;vcnl4020.h,340 :: 		PrintString ("\n-----------------HIGH_THRES--------------------- : ");
MOVW	R2, #lo_addr(?lstr43_Optique+0)
MOVT	R2, #hi_addr(?lstr43_Optique+0)
MOV	R0, R2
BL	_PrintString+0
;vcnl4020.h,341 :: 		PrintDecimal(AverageProxiValue_H ) ;
SXTH	R0, R10
; AverageProxiValue_H end address is: 40 (R10)
BL	_PrintDecimal+0
;vcnl4020.h,342 :: 		PrintString ("\n\n");
MOVW	R2, #lo_addr(?lstr44_Optique+0)
MOVT	R2, #hi_addr(?lstr44_Optique+0)
MOV	R0, R2
BL	_PrintString+0
;vcnl4020.h,343 :: 		PrintString ("\n-----------------LOW_THRES--------------------- : ");
MOVW	R2, #lo_addr(?lstr45_Optique+0)
MOVT	R2, #hi_addr(?lstr45_Optique+0)
MOV	R0, R2
BL	_PrintString+0
;vcnl4020.h,344 :: 		PrintDecimal(AverageProxiValue_L ) ;
LDRH	R0, [SP, #20]
BL	_PrintDecimal+0
;vcnl4020.h,345 :: 		PrintString ("\n\n");
MOVW	R2, #lo_addr(?lstr46_Optique+0)
MOVT	R2, #hi_addr(?lstr46_Optique+0)
MOV	R0, R2
BL	_PrintString+0
;vcnl4020.h,348 :: 		do {
L_InitVCNL4020_Periodic371:
;vcnl4020.h,349 :: 		Command = VCNL4020_Read_Byte(VCNL4020_Address,REGISTER_COMMAND) ;// read command register
MOVS	R1, #128
MOVS	R0, #19
BL	_VCNL4020_Read_Byte+0
; Command start address is: 44 (R11)
UXTB	R11, R0
;vcnl4020.h,350 :: 		} while (!(Command & (COMMAND_MASK_PROX_DATA_READY | COMMAND_MASK_AMBI_DATA_READY))); // data ready ?
AND	R2, R0, #96
UXTB	R2, R2
CMP	R2, #0
IT	EQ
BEQ	L_InitVCNL4020_Periodic371
;vcnl4020.h,353 :: 		InterruptStatus = VCNL4020_Read_Byte(VCNL4020_Address,REGISTER_INTERRUPT_STATUS) ;
MOVS	R1, #142
MOVS	R0, #19
BL	_VCNL4020_Read_Byte+0
;vcnl4020.h,355 :: 		if (InterruptStatus & INTERRUPT_STATUS_THRES_HI) {
AND	R2, R0, #1
UXTB	R2, R2
CMP	R2, #0
IT	EQ
BEQ	L_InitVCNL4020_Periodic374
;vcnl4020.h,357 :: 		VCNL4020_Write_Byte(VCNL4020_Address,REGISTER_INTERRUPT_STATUS,0x01); // clear Interrupt Status
MOVS	R2, #1
MOVS	R1, #142
MOVS	R0, #19
BL	_VCNL4020_Write_Byte+0
;vcnl4020.h,360 :: 		PrintString ("\nclear Interrupt Status\n");
MOVW	R2, #lo_addr(?lstr47_Optique+0)
MOVT	R2, #hi_addr(?lstr47_Optique+0)
MOV	R0, R2
BL	_PrintString+0
;vcnl4020.h,361 :: 		}
L_InitVCNL4020_Periodic374:
;vcnl4020.h,363 :: 		if (Command & COMMAND_MASK_PROX_DATA_READY) {
AND	R2, R11, #32
UXTB	R2, R2
; Command end address is: 44 (R11)
CMP	R2, #0
IT	EQ
BEQ	L_InitVCNL4020_Periodic375
;vcnl4020.h,364 :: 		PrintString ("\n");
MOVW	R2, #lo_addr(?lstr48_Optique+0)
MOVT	R2, #hi_addr(?lstr48_Optique+0)
MOV	R0, R2
BL	_PrintString+0
;vcnl4020.h,365 :: 		PrintString ("RESULT : ");
MOVW	R2, #lo_addr(?lstr49_Optique+0)
MOVT	R2, #hi_addr(?lstr49_Optique+0)
MOV	R0, R2
BL	_PrintString+0
;vcnl4020.h,367 :: 		PrintDecimal(VCNL4020_Read_Byte(VCNL4020_Address,registerADDR_RESULT_HIGH)) ;
MOVS	R1, #135
MOVS	R0, #19
BL	_VCNL4020_Read_Byte+0
BL	_PrintDecimal+0
;vcnl4020.h,368 :: 		PrintString (" ");
MOVW	R2, #lo_addr(?lstr50_Optique+0)
MOVT	R2, #hi_addr(?lstr50_Optique+0)
MOV	R0, R2
BL	_PrintString+0
;vcnl4020.h,369 :: 		PrintDecimal(VCNL4020_Read_Byte(VCNL4020_Address,registerADDR_RESULT_LOW)) ;
MOVS	R1, #136
MOVS	R0, #19
BL	_VCNL4020_Read_Byte+0
BL	_PrintDecimal+0
;vcnl4020.h,370 :: 		PrintString ("\n\n");
MOVW	R2, #lo_addr(?lstr51_Optique+0)
MOVT	R2, #hi_addr(?lstr51_Optique+0)
MOV	R0, R2
BL	_PrintString+0
;vcnl4020.h,371 :: 		PrintString ("\n\nStatus : ");
MOVW	R2, #lo_addr(?lstr52_Optique+0)
MOVT	R2, #hi_addr(?lstr52_Optique+0)
MOV	R0, R2
BL	_PrintString+0
;vcnl4020.h,372 :: 		PrintDecimal(VCNL4020_Read_Byte(VCNL4020_Address,REGISTER_INTERRUPT_STATUS)) ;
MOVS	R1, #142
MOVS	R0, #19
BL	_VCNL4020_Read_Byte+0
BL	_PrintDecimal+0
;vcnl4020.h,373 :: 		PrintString ("\n\n");
MOVW	R2, #lo_addr(?lstr53_Optique+0)
MOVT	R2, #hi_addr(?lstr53_Optique+0)
MOV	R0, R2
BL	_PrintString+0
;vcnl4020.h,374 :: 		MCP((0x0A+band),80, 256, 256, N_Sensor); //(char ModuleAddress,int red, int green, int blue, char N_LED)
LDRB	R2, [SP, #12]
ADDW	R3, R2, #10
LDRB	R2, [SP, #8]
PUSH	(R2)
MOVW	R2, #256
SXTH	R2, R2
MOVS	R1, #80
SXTH	R1, R1
UXTB	R0, R3
MOVW	R3, #256
SXTH	R3, R3
BL	_MCP+0
ADD	SP, SP, #4
;vcnl4020.h,375 :: 		PrintString ("\n-----------------CHANNEL_1--------------------- : ");
MOVW	R2, #lo_addr(?lstr54_Optique+0)
MOVT	R2, #hi_addr(?lstr54_Optique+0)
MOV	R0, R2
BL	_PrintString+0
;vcnl4020.h,376 :: 		PrintDecimal(N_Sensor) ;
LDRB	R0, [SP, #8]
BL	_PrintDecimal+0
;vcnl4020.h,377 :: 		PrintString ("\n\n");
MOVW	R2, #lo_addr(?lstr55_Optique+0)
MOVT	R2, #hi_addr(?lstr55_Optique+0)
MOV	R0, R2
BL	_PrintString+0
;vcnl4020.h,378 :: 		PrintString ("\n-----------------BAND_1--------------------- : ");
MOVW	R2, #lo_addr(?lstr56_Optique+0)
MOVT	R2, #hi_addr(?lstr56_Optique+0)
MOV	R0, R2
BL	_PrintString+0
;vcnl4020.h,379 :: 		PrintDecimal(band) ;
LDRB	R0, [SP, #12]
BL	_PrintDecimal+0
;vcnl4020.h,380 :: 		PrintString ("\n\n");
MOVW	R2, #lo_addr(?lstr57_Optique+0)
MOVT	R2, #hi_addr(?lstr57_Optique+0)
MOV	R0, R2
BL	_PrintString+0
;vcnl4020.h,382 :: 		}
L_InitVCNL4020_Periodic375:
;vcnl4020.h,383 :: 		}
L_end_InitVCNL4020_Periodic3:
LDR	LR, [SP, #0]
ADD	SP, SP, #24
BX	LR
; end of _InitVCNL4020_Periodic3
_DS28CM00R_Read_Byte:
;ds28cm.h,18 :: 		char DS28CM00R_Read_Byte(char ModuleAddress, char RegAddress){
; RegAddress start address is: 4 (R1)
; ModuleAddress start address is: 0 (R0)
SUB	SP, SP, #8
STR	LR, [SP, #0]
UXTB	R10, R0
; RegAddress end address is: 4 (R1)
; ModuleAddress end address is: 0 (R0)
; ModuleAddress start address is: 40 (R10)
; RegAddress start address is: 4 (R1)
;ds28cm.h,22 :: 		reg_data[0]=RegAddress;
ADD	R2, SP, #4
STRB	R1, [R2, #0]
; RegAddress end address is: 4 (R1)
;ds28cm.h,24 :: 		I2C2_Start();
BL	_I2C2_Start+0
;ds28cm.h,25 :: 		I2C2_Write(ModuleAddress,reg_data,1,END_MODE_RESTART);
ADD	R2, SP, #4
MOVW	R3, #0
MOV	R1, R2
MOVS	R2, #1
UXTB	R0, R10
BL	_I2C2_Write+0
;ds28cm.h,26 :: 		I2C2_Read(ModuleAddress,reg_data,1,END_MODE_STOP);
ADD	R2, SP, #4
MOVW	R3, #1
MOV	R1, R2
MOVS	R2, #1
UXTB	R0, R10
; ModuleAddress end address is: 40 (R10)
BL	_I2C2_Read+0
;ds28cm.h,28 :: 		temp=reg_data[0];
ADD	R2, SP, #4
LDRB	R2, [R2, #0]
;ds28cm.h,29 :: 		return temp;
UXTB	R0, R2
;ds28cm.h,30 :: 		}
L_end_DS28CM00R_Read_Byte:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _DS28CM00R_Read_Byte
_DS28CM00R_Write_Byte:
;ds28cm.h,32 :: 		void DS28CM00R_Write_Byte(char ModuleAddress,char RegAddress, char Data_) {
; Data_ start address is: 8 (R2)
; RegAddress start address is: 4 (R1)
; ModuleAddress start address is: 0 (R0)
SUB	SP, SP, #8
STR	LR, [SP, #0]
UXTB	R5, R0
; Data_ end address is: 8 (R2)
; RegAddress end address is: 4 (R1)
; ModuleAddress end address is: 0 (R0)
; ModuleAddress start address is: 20 (R5)
; RegAddress start address is: 4 (R1)
; Data_ start address is: 8 (R2)
;ds28cm.h,35 :: 		reg_data[0]=RegAddress;
ADD	R3, SP, #4
STRB	R1, [R3, #0]
; RegAddress end address is: 4 (R1)
;ds28cm.h,36 :: 		reg_data[1]=Data_;
ADDS	R3, R3, #1
STRB	R2, [R3, #0]
; Data_ end address is: 8 (R2)
;ds28cm.h,38 :: 		I2C2_Start();
BL	_I2C2_Start+0
;ds28cm.h,39 :: 		I2C2_Write(ModuleAddress,reg_data,2,END_MODE_STOP);
ADD	R3, SP, #4
MOVS	R2, #2
MOV	R1, R3
MOVW	R3, #1
UXTB	R0, R5
; ModuleAddress end address is: 20 (R5)
BL	_I2C2_Write+0
;ds28cm.h,40 :: 		}
L_end_DS28CM00R_Write_Byte:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _DS28CM00R_Write_Byte
_Read_serial_number:
;ds28cm.h,41 :: 		void Read_serial_number()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;ds28cm.h,43 :: 		InitI2C2();
BL	_InitI2C2+0
;ds28cm.h,44 :: 		PrintString ("---------serial_number---------");
MOVW	R0, #lo_addr(?lstr58_Optique+0)
MOVT	R0, #hi_addr(?lstr58_Optique+0)
BL	_PrintString+0
;ds28cm.h,45 :: 		PrintDecimal(DS28CM00R_Read_Byte(DS28CM00R_Address,Serial_Number_1));
MOVS	R1, #1
MOVS	R0, #80
BL	_DS28CM00R_Read_Byte+0
BL	_PrintDecimal+0
;ds28cm.h,46 :: 		PrintString (" ");
MOVW	R0, #lo_addr(?lstr59_Optique+0)
MOVT	R0, #hi_addr(?lstr59_Optique+0)
BL	_PrintString+0
;ds28cm.h,47 :: 		PrintDecimal(DS28CM00R_Read_Byte(DS28CM00R_Address,Serial_Number_2));
MOVS	R1, #2
MOVS	R0, #80
BL	_DS28CM00R_Read_Byte+0
BL	_PrintDecimal+0
;ds28cm.h,48 :: 		PrintString (" ");
MOVW	R0, #lo_addr(?lstr60_Optique+0)
MOVT	R0, #hi_addr(?lstr60_Optique+0)
BL	_PrintString+0
;ds28cm.h,49 :: 		PrintDecimal(DS28CM00R_Read_Byte(DS28CM00R_Address,Serial_Number_3));
MOVS	R1, #3
MOVS	R0, #80
BL	_DS28CM00R_Read_Byte+0
BL	_PrintDecimal+0
;ds28cm.h,50 :: 		PrintString (" ");
MOVW	R0, #lo_addr(?lstr61_Optique+0)
MOVT	R0, #hi_addr(?lstr61_Optique+0)
BL	_PrintString+0
;ds28cm.h,51 :: 		PrintDecimal(DS28CM00R_Read_Byte(DS28CM00R_Address,Serial_Number_4));
MOVS	R1, #4
MOVS	R0, #80
BL	_DS28CM00R_Read_Byte+0
BL	_PrintDecimal+0
;ds28cm.h,52 :: 		PrintString (" ");
MOVW	R0, #lo_addr(?lstr62_Optique+0)
MOVT	R0, #hi_addr(?lstr62_Optique+0)
BL	_PrintString+0
;ds28cm.h,53 :: 		PrintDecimal(DS28CM00R_Read_Byte(DS28CM00R_Address,Serial_Number_5));
MOVS	R1, #5
MOVS	R0, #80
BL	_DS28CM00R_Read_Byte+0
BL	_PrintDecimal+0
;ds28cm.h,54 :: 		PrintString (" ");
MOVW	R0, #lo_addr(?lstr63_Optique+0)
MOVT	R0, #hi_addr(?lstr63_Optique+0)
BL	_PrintString+0
;ds28cm.h,55 :: 		PrintDecimal(DS28CM00R_Read_Byte(DS28CM00R_Address,Serial_Number_6));
MOVS	R1, #6
MOVS	R0, #80
BL	_DS28CM00R_Read_Byte+0
BL	_PrintDecimal+0
;ds28cm.h,56 :: 		PrintString (" ");
MOVW	R0, #lo_addr(?lstr64_Optique+0)
MOVT	R0, #hi_addr(?lstr64_Optique+0)
BL	_PrintString+0
;ds28cm.h,57 :: 		PrintDecimal(DS28CM00R_Read_Byte(DS28CM00R_Address,Serial_Number_7));
MOVS	R1, #7
MOVS	R0, #80
BL	_DS28CM00R_Read_Byte+0
BL	_PrintDecimal+0
;ds28cm.h,58 :: 		PrintString ("\n");
MOVW	R0, #lo_addr(?lstr65_Optique+0)
MOVT	R0, #hi_addr(?lstr65_Optique+0)
BL	_PrintString+0
;ds28cm.h,59 :: 		}
L_end_Read_serial_number:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Read_serial_number
_eeprom_Write_Byte:
;eeprom.h,4 :: 		void eeprom_Write_Byte(char ModuleAddress,char RegAddress, char Data_) {
; Data_ start address is: 8 (R2)
; RegAddress start address is: 4 (R1)
; ModuleAddress start address is: 0 (R0)
SUB	SP, SP, #8
STR	LR, [SP, #0]
UXTB	R5, R0
; Data_ end address is: 8 (R2)
; RegAddress end address is: 4 (R1)
; ModuleAddress end address is: 0 (R0)
; ModuleAddress start address is: 20 (R5)
; RegAddress start address is: 4 (R1)
; Data_ start address is: 8 (R2)
;eeprom.h,7 :: 		reg_data[0]=RegAddress;
ADD	R3, SP, #4
STRB	R1, [R3, #0]
; RegAddress end address is: 4 (R1)
;eeprom.h,8 :: 		reg_data[1]=Data_;
ADDS	R3, R3, #1
STRB	R2, [R3, #0]
; Data_ end address is: 8 (R2)
;eeprom.h,10 :: 		I2C1_Start();
BL	_I2C1_Start+0
;eeprom.h,11 :: 		I2C1_Write(ModuleAddress,reg_data,2,END_MODE_STOP);
ADD	R3, SP, #4
MOVS	R2, #2
MOV	R1, R3
MOVW	R3, #1
UXTB	R0, R5
; ModuleAddress end address is: 20 (R5)
BL	_I2C1_Write+0
;eeprom.h,12 :: 		}
L_end_eeprom_Write_Byte:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _eeprom_Write_Byte
_eeprom_Read_Byte:
;eeprom.h,14 :: 		char eeprom_Read_Byte(char ModuleAddress, char RegAddress){
; RegAddress start address is: 4 (R1)
; ModuleAddress start address is: 0 (R0)
SUB	SP, SP, #8
STR	LR, [SP, #0]
UXTB	R10, R0
; RegAddress end address is: 4 (R1)
; ModuleAddress end address is: 0 (R0)
; ModuleAddress start address is: 40 (R10)
; RegAddress start address is: 4 (R1)
;eeprom.h,18 :: 		reg_data[0]=RegAddress;
ADD	R2, SP, #4
STRB	R1, [R2, #0]
; RegAddress end address is: 4 (R1)
;eeprom.h,20 :: 		I2C1_Start();
BL	_I2C1_Start+0
;eeprom.h,21 :: 		I2C1_Write(ModuleAddress,reg_data,1,END_MODE_RESTART);
ADD	R2, SP, #4
MOVW	R3, #0
MOV	R1, R2
MOVS	R2, #1
UXTB	R0, R10
BL	_I2C1_Write+0
;eeprom.h,22 :: 		I2C1_Read(ModuleAddress,reg_data,1,END_MODE_STOP);
ADD	R2, SP, #4
MOVW	R3, #1
MOV	R1, R2
MOVS	R2, #1
UXTB	R0, R10
; ModuleAddress end address is: 40 (R10)
BL	_I2C1_Read+0
;eeprom.h,24 :: 		temp=reg_data[0];
ADD	R2, SP, #4
LDRB	R2, [R2, #0]
;eeprom.h,25 :: 		return temp;
UXTB	R0, R2
;eeprom.h,26 :: 		}
L_end_eeprom_Read_Byte:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _eeprom_Read_Byte
_TEST_EEPROM:
;eeprom.h,27 :: 		void TEST_EEPROM()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;eeprom.h,29 :: 		InitI2C1();
BL	_InitI2C1+0
;eeprom.h,30 :: 		PrintString ("---------TEST_EEPROM---------");
MOVW	R0, #lo_addr(?lstr66_Optique+0)
MOVT	R0, #hi_addr(?lstr66_Optique+0)
BL	_PrintString+0
;eeprom.h,31 :: 		eeprom_Write_Byte(eeprom_Address,0x00,0xAB);
MOVS	R2, #171
MOVS	R1, #0
MOVS	R0, #80
BL	_eeprom_Write_Byte+0
;eeprom.h,32 :: 		PrintString (" ");
MOVW	R0, #lo_addr(?lstr67_Optique+0)
MOVT	R0, #hi_addr(?lstr67_Optique+0)
BL	_PrintString+0
;eeprom.h,33 :: 		PrintDecimal(eeprom_Read_Byte(eeprom_Address,0x00));
MOVS	R1, #0
MOVS	R0, #80
BL	_eeprom_Read_Byte+0
BL	_PrintDecimal+0
;eeprom.h,34 :: 		PrintString (" ");
MOVW	R0, #lo_addr(?lstr68_Optique+0)
MOVT	R0, #hi_addr(?lstr68_Optique+0)
BL	_PrintString+0
;eeprom.h,35 :: 		PrintString ("-----------------------------");
MOVW	R0, #lo_addr(?lstr69_Optique+0)
MOVT	R0, #hi_addr(?lstr69_Optique+0)
BL	_PrintString+0
;eeprom.h,36 :: 		}
L_end_TEST_EEPROM:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _TEST_EEPROM
_main:
;Optique.c,69 :: 		void main()
;Optique.c,72 :: 		UART1_Init (9600);
MOVW	R0, #9600
BL	_UART1_Init+0
;Optique.c,74 :: 		PrintString ("Programme 3.1.2--Detection Optique--Oscillateur : 8Mhz ");
MOVW	R0, #lo_addr(?lstr70_Optique+0)
MOVT	R0, #hi_addr(?lstr70_Optique+0)
BL	_PrintString+0
;Optique.c,76 :: 		setupGPIO();
BL	_setupGPIO+0
;Optique.c,78 :: 		Read_serial_number();
BL	_Read_serial_number+0
;Optique.c,80 :: 		TEST_EEPROM();
BL	_TEST_EEPROM+0
;Optique.c,82 :: 		MCP(0x0A,256, 256, 256, 0); //(char ModuleAddress,int red, int green, int blue, char N_LED)
MOVS	R0, #0
PUSH	(R0)
MOVW	R3, #256
SXTH	R3, R3
MOVW	R2, #256
SXTH	R2, R2
MOVW	R1, #256
SXTH	R1, R1
MOVS	R0, #10
BL	_MCP+0
ADD	SP, SP, #4
;Optique.c,84 :: 		TEST_CAN();
BL	_TEST_CAN+0
;Optique.c,86 :: 		for (bands = 0 ; bands <= 7 ; bands++)
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_bands+0)
MOVT	R0, #hi_addr(_bands+0)
STRH	R1, [R0, #0]
L_main76:
MOVW	R0, #lo_addr(_bands+0)
MOVT	R0, #hi_addr(_bands+0)
LDRSH	R0, [R0, #0]
CMP	R0, #7
IT	GT
BGT	L_main77
;Optique.c,88 :: 		for (compteur = 0 ; compteur <= 3 ; compteur++)
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_compteur+0)
MOVT	R0, #hi_addr(_compteur+0)
STRH	R1, [R0, #0]
L_main79:
MOVW	R0, #lo_addr(_compteur+0)
MOVT	R0, #hi_addr(_compteur+0)
LDRSH	R0, [R0, #0]
CMP	R0, #3
IT	GT
BGT	L_main80
;Optique.c,90 :: 		InitVCNL4020_Periodic3(compteur,bands);// sensor 0 to 3 & band 0 to 7
MOVW	R0, #lo_addr(_bands+0)
MOVT	R0, #hi_addr(_bands+0)
LDRSH	R1, [R0, #0]
MOVW	R0, #lo_addr(_compteur+0)
MOVT	R0, #hi_addr(_compteur+0)
LDRSH	R0, [R0, #0]
BL	_InitVCNL4020_Periodic3+0
;Optique.c,88 :: 		for (compteur = 0 ; compteur <= 3 ; compteur++)
MOVW	R1, #lo_addr(_compteur+0)
MOVT	R1, #hi_addr(_compteur+0)
LDRSH	R0, [R1, #0]
ADDS	R0, R0, #1
STRH	R0, [R1, #0]
;Optique.c,91 :: 		}
IT	AL
BAL	L_main79
L_main80:
;Optique.c,86 :: 		for (bands = 0 ; bands <= 7 ; bands++)
MOVW	R1, #lo_addr(_bands+0)
MOVT	R1, #hi_addr(_bands+0)
LDRSH	R0, [R1, #0]
ADDS	R0, R0, #1
STRH	R0, [R1, #0]
;Optique.c,92 :: 		}
IT	AL
BAL	L_main76
L_main77:
;Optique.c,94 :: 		while (1)
L_main82:
;Optique.c,96 :: 		interrupt ();
BL	_interrupt+0
;Optique.c,97 :: 		}
IT	AL
BAL	L_main82
;Optique.c,100 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
_interrupt:
;Optique.c,108 :: 		void interrupt ()
SUB	SP, SP, #8
STR	LR, [SP, #0]
;Optique.c,110 :: 		unsigned char Command = 0;
;Optique.c,111 :: 		unsigned char InterruptStatus=0;
;Optique.c,112 :: 		unsigned char channel =0;
MOVS	R0, #0
STRB	R0, [SP, #4]
MOVS	R0, #0
STRB	R0, [SP, #5]
;Optique.c,113 :: 		unsigned char N_LED =0;
;Optique.c,114 :: 		unsigned char band =0;
;Optique.c,115 :: 		unsigned char compt=0;
; compt start address is: 48 (R12)
MOVW	R12, #0
;Optique.c,118 :: 		setupGPIO();
BL	_setupGPIO+0
;Optique.c,120 :: 		if(GPIOA_IDRbits.IDR1 == 0||GPIOA_IDRbits.IDR2 == 0||GPIOA_IDRbits.IDR3 == 0||GPIOA_IDRbits.IDR4 == 0||GPIOA_IDRbits.IDR5 == 0||GPIOA_IDRbits.IDR6 == 0||GPIOA_IDRbits.IDR7 == 0||GPIOA_IDRbits.IDR8 == 0)
MOVW	R1, #lo_addr(GPIOA_IDRbits+0)
MOVT	R1, #hi_addr(GPIOA_IDRbits+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L__interrupt137
MOVW	R1, #lo_addr(GPIOA_IDRbits+0)
MOVT	R1, #hi_addr(GPIOA_IDRbits+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L__interrupt136
MOVW	R1, #lo_addr(GPIOA_IDRbits+0)
MOVT	R1, #hi_addr(GPIOA_IDRbits+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L__interrupt135
MOVW	R1, #lo_addr(GPIOA_IDRbits+0)
MOVT	R1, #hi_addr(GPIOA_IDRbits+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L__interrupt134
MOVW	R1, #lo_addr(GPIOA_IDRbits+0)
MOVT	R1, #hi_addr(GPIOA_IDRbits+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L__interrupt133
MOVW	R1, #lo_addr(GPIOA_IDRbits+0)
MOVT	R1, #hi_addr(GPIOA_IDRbits+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L__interrupt132
MOVW	R1, #lo_addr(GPIOA_IDRbits+0)
MOVT	R1, #hi_addr(GPIOA_IDRbits+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L__interrupt131
MOVW	R1, #lo_addr(GPIOA_IDRbits+0)
MOVT	R1, #hi_addr(GPIOA_IDRbits+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L__interrupt130
; compt end address is: 48 (R12)
IT	AL
BAL	L_interrupt86
L__interrupt137:
; compt start address is: 48 (R12)
L__interrupt136:
L__interrupt135:
L__interrupt134:
L__interrupt133:
L__interrupt132:
L__interrupt131:
L__interrupt130:
;Optique.c,122 :: 		close_PCA9544 (); // stop all activities
BL	_close_PCA9544+0
;Optique.c,124 :: 		if (GPIOA_IDRbits.IDR1 == 0){channel=PCA9544A_Read_Byte(PCA9544A_Address_1, PCA9544A_register);band=0;}
MOVW	R1, #lo_addr(GPIOA_IDRbits+0)
MOVT	R1, #hi_addr(GPIOA_IDRbits+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	NE
BNE	L_interrupt87
MOVS	R1, #0
MOVS	R0, #112
BL	_PCA9544A_Read_Byte+0
STRB	R0, [SP, #4]
MOVS	R0, #0
STRB	R0, [SP, #5]
L_interrupt87:
;Optique.c,125 :: 		if (GPIOA_IDRbits.IDR2 == 0){channel=PCA9544A_Read_Byte(PCA9544A_Address_2, PCA9544A_register);band=1;}
MOVW	R1, #lo_addr(GPIOA_IDRbits+0)
MOVT	R1, #hi_addr(GPIOA_IDRbits+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	NE
BNE	L_interrupt88
MOVS	R1, #0
MOVS	R0, #113
BL	_PCA9544A_Read_Byte+0
STRB	R0, [SP, #4]
MOVS	R0, #1
STRB	R0, [SP, #5]
L_interrupt88:
;Optique.c,126 :: 		if (GPIOA_IDRbits.IDR3 == 0){channel=PCA9544A_Read_Byte(PCA9544A_Address_3, PCA9544A_register);band=2;}
MOVW	R1, #lo_addr(GPIOA_IDRbits+0)
MOVT	R1, #hi_addr(GPIOA_IDRbits+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	NE
BNE	L_interrupt89
MOVS	R1, #0
MOVS	R0, #114
BL	_PCA9544A_Read_Byte+0
STRB	R0, [SP, #4]
MOVS	R0, #2
STRB	R0, [SP, #5]
L_interrupt89:
;Optique.c,127 :: 		if (GPIOA_IDRbits.IDR4 == 0){channel=PCA9544A_Read_Byte(PCA9544A_Address_4, PCA9544A_register);band=3;}
MOVW	R1, #lo_addr(GPIOA_IDRbits+0)
MOVT	R1, #hi_addr(GPIOA_IDRbits+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	NE
BNE	L_interrupt90
MOVS	R1, #0
MOVS	R0, #115
BL	_PCA9544A_Read_Byte+0
STRB	R0, [SP, #4]
MOVS	R0, #3
STRB	R0, [SP, #5]
L_interrupt90:
;Optique.c,128 :: 		if (GPIOA_IDRbits.IDR5 == 0){channel=PCA9544A_Read_Byte(PCA9544A_Address_5, PCA9544A_register);band=4;}
MOVW	R1, #lo_addr(GPIOA_IDRbits+0)
MOVT	R1, #hi_addr(GPIOA_IDRbits+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	NE
BNE	L_interrupt91
MOVS	R1, #0
MOVS	R0, #116
BL	_PCA9544A_Read_Byte+0
STRB	R0, [SP, #4]
MOVS	R0, #4
STRB	R0, [SP, #5]
L_interrupt91:
;Optique.c,129 :: 		if (GPIOA_IDRbits.IDR6 == 0){channel=PCA9544A_Read_Byte(PCA9544A_Address_6, PCA9544A_register);band=5;}
MOVW	R1, #lo_addr(GPIOA_IDRbits+0)
MOVT	R1, #hi_addr(GPIOA_IDRbits+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	NE
BNE	L_interrupt92
MOVS	R1, #0
MOVS	R0, #117
BL	_PCA9544A_Read_Byte+0
STRB	R0, [SP, #4]
MOVS	R0, #5
STRB	R0, [SP, #5]
L_interrupt92:
;Optique.c,130 :: 		if (GPIOA_IDRbits.IDR7 == 0){channel=PCA9544A_Read_Byte(PCA9544A_Address_7, PCA9544A_register);band=6;}
MOVW	R1, #lo_addr(GPIOA_IDRbits+0)
MOVT	R1, #hi_addr(GPIOA_IDRbits+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	NE
BNE	L_interrupt93
MOVS	R1, #0
MOVS	R0, #118
BL	_PCA9544A_Read_Byte+0
STRB	R0, [SP, #4]
MOVS	R0, #6
STRB	R0, [SP, #5]
L_interrupt93:
;Optique.c,131 :: 		if (GPIOA_IDRbits.IDR8 == 0){channel=PCA9544A_Read_Byte(PCA9544A_Address_8, PCA9544A_register);band=7;}
MOVW	R1, #lo_addr(GPIOA_IDRbits+0)
MOVT	R1, #hi_addr(GPIOA_IDRbits+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	NE
BNE	L_interrupt94
MOVS	R1, #0
MOVS	R0, #119
BL	_PCA9544A_Read_Byte+0
STRB	R0, [SP, #4]
MOVS	R0, #7
STRB	R0, [SP, #5]
L_interrupt94:
;Optique.c,133 :: 		channel = (channel&0xF0);
LDRB	R0, [SP, #4]
AND	R0, R0, #240
UXTB	R0, R0
;Optique.c,134 :: 		channel = (channel>>4);
LSRS	R0, R0, #4
STRB	R0, [SP, #4]
; compt end address is: 48 (R12)
UXTB	R10, R12
;Optique.c,135 :: 		while (channel != 1)
L_interrupt95:
; compt start address is: 40 (R10)
LDRB	R0, [SP, #4]
CMP	R0, #1
IT	EQ
BEQ	L_interrupt96
;Optique.c,137 :: 		channel = channel>>1;
LDRB	R0, [SP, #4]
LSRS	R0, R0, #1
STRB	R0, [SP, #4]
;Optique.c,138 :: 		compt = compt++;
; compt start address is: 4 (R1)
UXTB	R1, R10
; compt end address is: 40 (R10)
ADDS	R0, R1, #1
; compt end address is: 4 (R1)
; compt start address is: 48 (R12)
UXTB	R12, R0
;Optique.c,139 :: 		}
UXTB	R10, R12
; compt end address is: 48 (R12)
IT	AL
BAL	L_interrupt95
L_interrupt96:
;Optique.c,140 :: 		channel=compt;
; compt start address is: 40 (R10)
STRB	R10, [SP, #4]
; compt end address is: 40 (R10)
;Optique.c,142 :: 		PrintString ("\n-----------------CHANNEL--------------------- : ");
MOVW	R0, #lo_addr(?lstr71_Optique+0)
MOVT	R0, #hi_addr(?lstr71_Optique+0)
BL	_PrintString+0
;Optique.c,143 :: 		PrintDecimal(channel) ;
LDRB	R0, [SP, #4]
BL	_PrintDecimal+0
;Optique.c,144 :: 		PrintString ("\n\n");
MOVW	R0, #lo_addr(?lstr72_Optique+0)
MOVT	R0, #hi_addr(?lstr72_Optique+0)
BL	_PrintString+0
;Optique.c,145 :: 		PrintString ("\n-----------------BAND--------------------- : ");
MOVW	R0, #lo_addr(?lstr73_Optique+0)
MOVT	R0, #hi_addr(?lstr73_Optique+0)
BL	_PrintString+0
;Optique.c,146 :: 		PrintDecimal(band) ;
LDRB	R0, [SP, #5]
BL	_PrintDecimal+0
;Optique.c,147 :: 		PrintString ("\n\n");
MOVW	R0, #lo_addr(?lstr74_Optique+0)
MOVT	R0, #hi_addr(?lstr74_Optique+0)
BL	_PrintString+0
;Optique.c,149 :: 		PCA9544A_Write_Byte((PCA9544A_Address_1+band),PCA9544A_register,(PCA9544A_channel_0+channel));
LDRB	R0, [SP, #4]
ADDS	R1, R0, #4
LDRB	R0, [SP, #5]
ADDS	R0, #112
UXTB	R2, R1
MOVS	R1, #0
UXTB	R0, R0
BL	_PCA9544A_Write_Byte+0
;Optique.c,150 :: 		PrintString ("\n-----------------ACK 1.1.1--------------------- : ");
MOVW	R0, #lo_addr(?lstr75_Optique+0)
MOVT	R0, #hi_addr(?lstr75_Optique+0)
BL	_PrintString+0
;Optique.c,152 :: 		do  {
L_interrupt97:
;Optique.c,153 :: 		Command = VCNL4020_Read_Byte(VCNL4020_Address,REGISTER_COMMAND) ;// read command register
MOVS	R1, #128
MOVS	R0, #19
BL	_VCNL4020_Read_Byte+0
STRB	R0, [SP, #6]
;Optique.c,154 :: 		} while (!(Command & (COMMAND_MASK_PROX_DATA_READY | COMMAND_MASK_AMBI_DATA_READY))); // data ready ?
AND	R0, R0, #96
UXTB	R0, R0
CMP	R0, #0
IT	EQ
BEQ	L_interrupt97
;Optique.c,156 :: 		InterruptStatus = VCNL4020_Read_Byte(VCNL4020_Address,REGISTER_INTERRUPT_STATUS) ;
MOVS	R1, #142
MOVS	R0, #19
BL	_VCNL4020_Read_Byte+0
STRB	R0, [SP, #7]
;Optique.c,158 :: 		if (InterruptStatus & INTERRUPT_STATUS_THRES_HI)
AND	R0, R0, #1
UXTB	R0, R0
CMP	R0, #0
IT	EQ
BEQ	L_interrupt100
;Optique.c,160 :: 		VCNL4020_Write_Byte(VCNL4020_Address,REGISTER_INTERRUPT_STATUS,0x01); // clear Interrupt Status
MOVS	R2, #1
MOVS	R1, #142
MOVS	R0, #19
BL	_VCNL4020_Write_Byte+0
;Optique.c,161 :: 		PrintString ("\n-----------------clear Interrupt Status--------------------- : ");
MOVW	R0, #lo_addr(?lstr76_Optique+0)
MOVT	R0, #hi_addr(?lstr76_Optique+0)
BL	_PrintString+0
;Optique.c,162 :: 		MCP((PCA9956_ADDR_1+band),256, 80, 256, channel); //(char ModuleAddress,int red, int green, int blue, char N_LED)
LDRB	R1, [SP, #4]
LDRB	R0, [SP, #5]
ADDS	R0, #10
PUSH	(R1)
MOVW	R3, #256
SXTH	R3, R3
MOVS	R2, #80
SXTH	R2, R2
MOVW	R1, #256
SXTH	R1, R1
UXTB	R0, R0
BL	_MCP+0
ADD	SP, SP, #4
;Optique.c,163 :: 		Delay_100ms();
BL	_Delay_100ms+0
;Optique.c,164 :: 		PrintString ("\n-----------------ACK 1.1.2--------------------- : ");
MOVW	R0, #lo_addr(?lstr77_Optique+0)
MOVT	R0, #hi_addr(?lstr77_Optique+0)
BL	_PrintString+0
;Optique.c,165 :: 		InitVCNL4020_Periodic2(channel,band);
LDRB	R1, [SP, #5]
LDRB	R0, [SP, #4]
BL	_InitVCNL4020_Periodic2+0
;Optique.c,166 :: 		}
L_interrupt100:
;Optique.c,167 :: 		if (InterruptStatus & INTERRUPT_STATUS_THRES_LO)
LDRB	R0, [SP, #7]
AND	R0, R0, #2
UXTB	R0, R0
CMP	R0, #0
IT	EQ
BEQ	L_interrupt101
;Optique.c,169 :: 		VCNL4020_Write_Byte(VCNL4020_Address,REGISTER_INTERRUPT_STATUS,0x02); // clear Interrupt Status
MOVS	R2, #2
MOVS	R1, #142
MOVS	R0, #19
BL	_VCNL4020_Write_Byte+0
;Optique.c,170 :: 		PrintString ("\n-----------------clear Interrupt Status--------------------- : ");
MOVW	R0, #lo_addr(?lstr78_Optique+0)
MOVT	R0, #hi_addr(?lstr78_Optique+0)
BL	_PrintString+0
;Optique.c,171 :: 		MCP((PCA9956_ADDR_1+band),256, 256, 80, channel); //(char ModuleAddress,int red, int green, int blue, char N_LED)
LDRB	R1, [SP, #4]
LDRB	R0, [SP, #5]
ADDS	R0, #10
PUSH	(R1)
MOVS	R3, #80
SXTH	R3, R3
MOVW	R2, #256
SXTH	R2, R2
MOVW	R1, #256
SXTH	R1, R1
UXTB	R0, R0
BL	_MCP+0
ADD	SP, SP, #4
;Optique.c,172 :: 		Delay_100ms();
BL	_Delay_100ms+0
;Optique.c,173 :: 		PrintString ("\n-----------------ACK 1.1.3--------------------- : ");
MOVW	R0, #lo_addr(?lstr79_Optique+0)
MOVT	R0, #hi_addr(?lstr79_Optique+0)
BL	_PrintString+0
;Optique.c,174 :: 		InitVCNL4020_Periodic2(channel,band);
LDRB	R1, [SP, #5]
LDRB	R0, [SP, #4]
BL	_InitVCNL4020_Periodic2+0
;Optique.c,175 :: 		}
L_interrupt101:
;Optique.c,177 :: 		if (Command & COMMAND_MASK_PROX_DATA_READY)
LDRB	R0, [SP, #6]
AND	R0, R0, #32
UXTB	R0, R0
CMP	R0, #0
IT	EQ
BEQ	L_interrupt102
;Optique.c,179 :: 		PrintString ("\n");
MOVW	R0, #lo_addr(?lstr80_Optique+0)
MOVT	R0, #hi_addr(?lstr80_Optique+0)
BL	_PrintString+0
;Optique.c,180 :: 		PrintString ("RESULT : ");
MOVW	R0, #lo_addr(?lstr81_Optique+0)
MOVT	R0, #hi_addr(?lstr81_Optique+0)
BL	_PrintString+0
;Optique.c,182 :: 		PrintDecimal(VCNL4020_Read_Byte(VCNL4020_Address,registerADDR_RESULT_HIGH)) ;
MOVS	R1, #135
MOVS	R0, #19
BL	_VCNL4020_Read_Byte+0
BL	_PrintDecimal+0
;Optique.c,183 :: 		PrintString (" ");
MOVW	R0, #lo_addr(?lstr82_Optique+0)
MOVT	R0, #hi_addr(?lstr82_Optique+0)
BL	_PrintString+0
;Optique.c,184 :: 		PrintDecimal(VCNL4020_Read_Byte(VCNL4020_Address,registerADDR_RESULT_LOW)) ;
MOVS	R1, #136
MOVS	R0, #19
BL	_VCNL4020_Read_Byte+0
BL	_PrintDecimal+0
;Optique.c,185 :: 		PrintString ("\n\n");
MOVW	R0, #lo_addr(?lstr83_Optique+0)
MOVT	R0, #hi_addr(?lstr83_Optique+0)
BL	_PrintString+0
;Optique.c,186 :: 		PrintString ("\n\nStatus : ");
MOVW	R0, #lo_addr(?lstr84_Optique+0)
MOVT	R0, #hi_addr(?lstr84_Optique+0)
BL	_PrintString+0
;Optique.c,187 :: 		PrintDecimal(VCNL4020_Read_Byte(VCNL4020_Address,REGISTER_INTERRUPT_STATUS)) ;
MOVS	R1, #142
MOVS	R0, #19
BL	_VCNL4020_Read_Byte+0
BL	_PrintDecimal+0
;Optique.c,188 :: 		PrintString ("\n\n");
MOVW	R0, #lo_addr(?lstr85_Optique+0)
MOVT	R0, #hi_addr(?lstr85_Optique+0)
BL	_PrintString+0
;Optique.c,190 :: 		PrintString ("\n-----------------ACK 1.1.2--------------------- : ");
MOVW	R0, #lo_addr(?lstr86_Optique+0)
MOVT	R0, #hi_addr(?lstr86_Optique+0)
BL	_PrintString+0
;Optique.c,191 :: 		}
L_interrupt102:
;Optique.c,192 :: 		}
IT	AL
BAL	L_interrupt103
L_interrupt86:
;Optique.c,195 :: 		MCP((PCA9956_ADDR_1+band),256, 256, 256, channel); //(char ModuleAddress,int red, int green, int blue, char N_LED)
LDRB	R1, [SP, #4]
LDRB	R0, [SP, #5]
ADDS	R0, #10
PUSH	(R1)
MOVW	R3, #256
SXTH	R3, R3
MOVW	R2, #256
SXTH	R2, R2
MOVW	R1, #256
SXTH	R1, R1
UXTB	R0, R0
BL	_MCP+0
ADD	SP, SP, #4
;Optique.c,197 :: 		}
L_interrupt103:
;Optique.c,201 :: 		}
L_end_interrupt:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _interrupt
_interrupt2:
;Optique.c,209 :: 		void interrupt2 ()
SUB	SP, SP, #8
STR	LR, [SP, #0]
;Optique.c,213 :: 		unsigned char Command = 0;
;Optique.c,214 :: 		unsigned char InterruptStatus=0;
;Optique.c,215 :: 		unsigned char channel =0;
MOVS	R0, #0
STRB	R0, [SP, #4]
MOVS	R0, #0
STRB	R0, [SP, #5]
;Optique.c,216 :: 		unsigned char band =0;
;Optique.c,217 :: 		unsigned char compt=0;
;Optique.c,220 :: 		setupGPIO();
BL	_setupGPIO+0
;Optique.c,222 :: 		if(GPIOA_IDRbits.IDR1 == 0||GPIOA_IDRbits.IDR2 == 0||GPIOA_IDRbits.IDR3 == 0||GPIOA_IDRbits.IDR4 == 0||GPIOA_IDRbits.IDR5 == 0||GPIOA_IDRbits.IDR6 == 0||GPIOA_IDRbits.IDR7 == 0||GPIOA_IDRbits.IDR8 == 0)
MOVW	R1, #lo_addr(GPIOA_IDRbits+0)
MOVT	R1, #hi_addr(GPIOA_IDRbits+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L__interrupt2146
MOVW	R1, #lo_addr(GPIOA_IDRbits+0)
MOVT	R1, #hi_addr(GPIOA_IDRbits+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L__interrupt2145
MOVW	R1, #lo_addr(GPIOA_IDRbits+0)
MOVT	R1, #hi_addr(GPIOA_IDRbits+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L__interrupt2144
MOVW	R1, #lo_addr(GPIOA_IDRbits+0)
MOVT	R1, #hi_addr(GPIOA_IDRbits+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L__interrupt2143
MOVW	R1, #lo_addr(GPIOA_IDRbits+0)
MOVT	R1, #hi_addr(GPIOA_IDRbits+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L__interrupt2142
MOVW	R1, #lo_addr(GPIOA_IDRbits+0)
MOVT	R1, #hi_addr(GPIOA_IDRbits+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L__interrupt2141
MOVW	R1, #lo_addr(GPIOA_IDRbits+0)
MOVT	R1, #hi_addr(GPIOA_IDRbits+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L__interrupt2140
MOVW	R1, #lo_addr(GPIOA_IDRbits+0)
MOVT	R1, #hi_addr(GPIOA_IDRbits+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L__interrupt2139
IT	AL
BAL	L_interrupt2106
L__interrupt2146:
L__interrupt2145:
L__interrupt2144:
L__interrupt2143:
L__interrupt2142:
L__interrupt2141:
L__interrupt2140:
L__interrupt2139:
;Optique.c,224 :: 		close_PCA9544 (); // stop all activities
BL	_close_PCA9544+0
;Optique.c,226 :: 		if (GPIOA_IDRbits.IDR1 == 0){number_LED=PCA9544A_Read_Byte(PCA9544A_Address_1, PCA9544A_register);band=0;channel = channel (number_LED);MCP2((PCA9956_ADDR_1+band),256, 80, 256, channel);}
MOVW	R1, #lo_addr(GPIOA_IDRbits+0)
MOVT	R1, #hi_addr(GPIOA_IDRbits+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	NE
BNE	L_interrupt2107
MOVS	R1, #0
MOVS	R0, #112
BL	_PCA9544A_Read_Byte+0
MOVW	R1, #lo_addr(_number_LED+0)
MOVT	R1, #hi_addr(_number_LED+0)
STRB	R0, [R1, #0]
MOVS	R1, #0
STRB	R1, [SP, #5]
BL	_channel+0
STRB	R0, [SP, #4]
UXTB	R1, R0
LDRB	R0, [SP, #5]
ADDS	R0, #10
PUSH	(R1)
MOVW	R3, #256
SXTH	R3, R3
MOVS	R2, #80
SXTH	R2, R2
MOVW	R1, #256
SXTH	R1, R1
UXTB	R0, R0
BL	_MCP2+0
ADD	SP, SP, #4
L_interrupt2107:
;Optique.c,227 :: 		if (GPIOA_IDRbits.IDR2 == 0){number_LED=PCA9544A_Read_Byte(PCA9544A_Address_2, PCA9544A_register);band=1;channel = channel (number_LED);MCP2((PCA9956_ADDR_1+band),256, 80, 256, channel);}
MOVW	R1, #lo_addr(GPIOA_IDRbits+0)
MOVT	R1, #hi_addr(GPIOA_IDRbits+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	NE
BNE	L_interrupt2108
MOVS	R1, #0
MOVS	R0, #113
BL	_PCA9544A_Read_Byte+0
MOVW	R1, #lo_addr(_number_LED+0)
MOVT	R1, #hi_addr(_number_LED+0)
STRB	R0, [R1, #0]
MOVS	R1, #1
STRB	R1, [SP, #5]
BL	_channel+0
STRB	R0, [SP, #4]
UXTB	R1, R0
LDRB	R0, [SP, #5]
ADDS	R0, #10
PUSH	(R1)
MOVW	R3, #256
SXTH	R3, R3
MOVS	R2, #80
SXTH	R2, R2
MOVW	R1, #256
SXTH	R1, R1
UXTB	R0, R0
BL	_MCP2+0
ADD	SP, SP, #4
L_interrupt2108:
;Optique.c,228 :: 		if (GPIOA_IDRbits.IDR3 == 0){number_LED=PCA9544A_Read_Byte(PCA9544A_Address_3, PCA9544A_register);band=2;channel = channel (number_LED);MCP2((PCA9956_ADDR_1+band),256, 80, 256, channel);}
MOVW	R1, #lo_addr(GPIOA_IDRbits+0)
MOVT	R1, #hi_addr(GPIOA_IDRbits+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	NE
BNE	L_interrupt2109
MOVS	R1, #0
MOVS	R0, #114
BL	_PCA9544A_Read_Byte+0
MOVW	R1, #lo_addr(_number_LED+0)
MOVT	R1, #hi_addr(_number_LED+0)
STRB	R0, [R1, #0]
MOVS	R1, #2
STRB	R1, [SP, #5]
BL	_channel+0
STRB	R0, [SP, #4]
UXTB	R1, R0
LDRB	R0, [SP, #5]
ADDS	R0, #10
PUSH	(R1)
MOVW	R3, #256
SXTH	R3, R3
MOVS	R2, #80
SXTH	R2, R2
MOVW	R1, #256
SXTH	R1, R1
UXTB	R0, R0
BL	_MCP2+0
ADD	SP, SP, #4
L_interrupt2109:
;Optique.c,229 :: 		if (GPIOA_IDRbits.IDR4 == 0){number_LED=PCA9544A_Read_Byte(PCA9544A_Address_4, PCA9544A_register);band=3;channel = channel (number_LED);MCP2((PCA9956_ADDR_1+band),256, 80, 256, channel);}
MOVW	R1, #lo_addr(GPIOA_IDRbits+0)
MOVT	R1, #hi_addr(GPIOA_IDRbits+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	NE
BNE	L_interrupt2110
MOVS	R1, #0
MOVS	R0, #115
BL	_PCA9544A_Read_Byte+0
MOVW	R1, #lo_addr(_number_LED+0)
MOVT	R1, #hi_addr(_number_LED+0)
STRB	R0, [R1, #0]
MOVS	R1, #3
STRB	R1, [SP, #5]
BL	_channel+0
STRB	R0, [SP, #4]
UXTB	R1, R0
LDRB	R0, [SP, #5]
ADDS	R0, #10
PUSH	(R1)
MOVW	R3, #256
SXTH	R3, R3
MOVS	R2, #80
SXTH	R2, R2
MOVW	R1, #256
SXTH	R1, R1
UXTB	R0, R0
BL	_MCP2+0
ADD	SP, SP, #4
L_interrupt2110:
;Optique.c,230 :: 		if (GPIOA_IDRbits.IDR5 == 0){number_LED=PCA9544A_Read_Byte(PCA9544A_Address_5, PCA9544A_register);band=4;channel = channel (number_LED);MCP2((PCA9956_ADDR_1+band),256, 80, 256, channel);}
MOVW	R1, #lo_addr(GPIOA_IDRbits+0)
MOVT	R1, #hi_addr(GPIOA_IDRbits+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	NE
BNE	L_interrupt2111
MOVS	R1, #0
MOVS	R0, #116
BL	_PCA9544A_Read_Byte+0
MOVW	R1, #lo_addr(_number_LED+0)
MOVT	R1, #hi_addr(_number_LED+0)
STRB	R0, [R1, #0]
MOVS	R1, #4
STRB	R1, [SP, #5]
BL	_channel+0
STRB	R0, [SP, #4]
UXTB	R1, R0
LDRB	R0, [SP, #5]
ADDS	R0, #10
PUSH	(R1)
MOVW	R3, #256
SXTH	R3, R3
MOVS	R2, #80
SXTH	R2, R2
MOVW	R1, #256
SXTH	R1, R1
UXTB	R0, R0
BL	_MCP2+0
ADD	SP, SP, #4
L_interrupt2111:
;Optique.c,231 :: 		if (GPIOA_IDRbits.IDR6 == 0){number_LED=PCA9544A_Read_Byte(PCA9544A_Address_6, PCA9544A_register);band=5;channel = channel (number_LED);MCP2((PCA9956_ADDR_1+band),256, 80, 256, channel);}
MOVW	R1, #lo_addr(GPIOA_IDRbits+0)
MOVT	R1, #hi_addr(GPIOA_IDRbits+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	NE
BNE	L_interrupt2112
MOVS	R1, #0
MOVS	R0, #117
BL	_PCA9544A_Read_Byte+0
MOVW	R1, #lo_addr(_number_LED+0)
MOVT	R1, #hi_addr(_number_LED+0)
STRB	R0, [R1, #0]
MOVS	R1, #5
STRB	R1, [SP, #5]
BL	_channel+0
STRB	R0, [SP, #4]
UXTB	R1, R0
LDRB	R0, [SP, #5]
ADDS	R0, #10
PUSH	(R1)
MOVW	R3, #256
SXTH	R3, R3
MOVS	R2, #80
SXTH	R2, R2
MOVW	R1, #256
SXTH	R1, R1
UXTB	R0, R0
BL	_MCP2+0
ADD	SP, SP, #4
L_interrupt2112:
;Optique.c,232 :: 		if (GPIOA_IDRbits.IDR7 == 0){number_LED=PCA9544A_Read_Byte(PCA9544A_Address_7, PCA9544A_register);band=6;channel = channel (number_LED);MCP2((PCA9956_ADDR_1+band),256, 80, 256, channel);}
MOVW	R1, #lo_addr(GPIOA_IDRbits+0)
MOVT	R1, #hi_addr(GPIOA_IDRbits+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	NE
BNE	L_interrupt2113
MOVS	R1, #0
MOVS	R0, #118
BL	_PCA9544A_Read_Byte+0
MOVW	R1, #lo_addr(_number_LED+0)
MOVT	R1, #hi_addr(_number_LED+0)
STRB	R0, [R1, #0]
MOVS	R1, #6
STRB	R1, [SP, #5]
BL	_channel+0
STRB	R0, [SP, #4]
UXTB	R1, R0
LDRB	R0, [SP, #5]
ADDS	R0, #10
PUSH	(R1)
MOVW	R3, #256
SXTH	R3, R3
MOVS	R2, #80
SXTH	R2, R2
MOVW	R1, #256
SXTH	R1, R1
UXTB	R0, R0
BL	_MCP2+0
ADD	SP, SP, #4
L_interrupt2113:
;Optique.c,233 :: 		if (GPIOA_IDRbits.IDR8 == 0){number_LED=PCA9544A_Read_Byte(PCA9544A_Address_8, PCA9544A_register);band=7;channel = channel (number_LED);MCP2((PCA9956_ADDR_1+band),256, 80, 256, channel);}
MOVW	R1, #lo_addr(GPIOA_IDRbits+0)
MOVT	R1, #hi_addr(GPIOA_IDRbits+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	NE
BNE	L_interrupt2114
MOVS	R1, #0
MOVS	R0, #119
BL	_PCA9544A_Read_Byte+0
MOVW	R1, #lo_addr(_number_LED+0)
MOVT	R1, #hi_addr(_number_LED+0)
STRB	R0, [R1, #0]
MOVS	R1, #7
STRB	R1, [SP, #5]
BL	_channel+0
STRB	R0, [SP, #4]
UXTB	R1, R0
LDRB	R0, [SP, #5]
ADDS	R0, #10
PUSH	(R1)
MOVW	R3, #256
SXTH	R3, R3
MOVS	R2, #80
SXTH	R2, R2
MOVW	R1, #256
SXTH	R1, R1
UXTB	R0, R0
BL	_MCP2+0
ADD	SP, SP, #4
L_interrupt2114:
;Optique.c,236 :: 		PrintString ("\n-----------------CHANNEL--------------------- : ");
MOVW	R0, #lo_addr(?lstr87_Optique+0)
MOVT	R0, #hi_addr(?lstr87_Optique+0)
BL	_PrintString+0
;Optique.c,237 :: 		PrintDecimal(channel) ;
LDRB	R0, [SP, #4]
BL	_PrintDecimal+0
;Optique.c,238 :: 		PrintString ("\n\n");
MOVW	R0, #lo_addr(?lstr88_Optique+0)
MOVT	R0, #hi_addr(?lstr88_Optique+0)
BL	_PrintString+0
;Optique.c,239 :: 		PrintString ("\n-----------------BAND--------------------- : ");
MOVW	R0, #lo_addr(?lstr89_Optique+0)
MOVT	R0, #hi_addr(?lstr89_Optique+0)
BL	_PrintString+0
;Optique.c,240 :: 		PrintDecimal(band) ;
LDRB	R0, [SP, #5]
BL	_PrintDecimal+0
;Optique.c,241 :: 		PrintString ("\n\n");
MOVW	R0, #lo_addr(?lstr90_Optique+0)
MOVT	R0, #hi_addr(?lstr90_Optique+0)
BL	_PrintString+0
;Optique.c,243 :: 		PCA9544A_Write_Byte((PCA9544A_Address_1+band),PCA9544A_register,(PCA9544A_channel_0+channel));
LDRB	R0, [SP, #4]
ADDS	R1, R0, #4
LDRB	R0, [SP, #5]
ADDS	R0, #112
UXTB	R2, R1
MOVS	R1, #0
UXTB	R0, R0
BL	_PCA9544A_Write_Byte+0
;Optique.c,244 :: 		PrintString ("\n-----------------ACK 1.1.1--------------------- : ");
MOVW	R0, #lo_addr(?lstr91_Optique+0)
MOVT	R0, #hi_addr(?lstr91_Optique+0)
BL	_PrintString+0
;Optique.c,246 :: 		do  {
L_interrupt2115:
;Optique.c,247 :: 		Command = VCNL4020_Read_Byte(VCNL4020_Address,REGISTER_COMMAND) ;// read command register
MOVS	R1, #128
MOVS	R0, #19
BL	_VCNL4020_Read_Byte+0
STRB	R0, [SP, #6]
;Optique.c,248 :: 		} while (!(Command & (COMMAND_MASK_PROX_DATA_READY | COMMAND_MASK_AMBI_DATA_READY))); // data ready ?
AND	R0, R0, #96
UXTB	R0, R0
CMP	R0, #0
IT	EQ
BEQ	L_interrupt2115
;Optique.c,250 :: 		InterruptStatus = VCNL4020_Read_Byte(VCNL4020_Address,REGISTER_INTERRUPT_STATUS) ;
MOVS	R1, #142
MOVS	R0, #19
BL	_VCNL4020_Read_Byte+0
STRB	R0, [SP, #7]
;Optique.c,252 :: 		if (InterruptStatus & INTERRUPT_STATUS_THRES_HI)
AND	R0, R0, #1
UXTB	R0, R0
CMP	R0, #0
IT	EQ
BEQ	L_interrupt2118
;Optique.c,254 :: 		VCNL4020_Write_Byte(VCNL4020_Address,REGISTER_INTERRUPT_STATUS,0x01); // clear Interrupt Status
MOVS	R2, #1
MOVS	R1, #142
MOVS	R0, #19
BL	_VCNL4020_Write_Byte+0
;Optique.c,255 :: 		PrintString ("\n-----------------clear Interrupt Status--------------------- : ");
MOVW	R0, #lo_addr(?lstr92_Optique+0)
MOVT	R0, #hi_addr(?lstr92_Optique+0)
BL	_PrintString+0
;Optique.c,256 :: 		MCP2((PCA9956_ADDR_1+band),256, 80, 256, channel); //(char ModuleAddress,int red, int green, int blue, char N_LED)
LDRB	R1, [SP, #4]
LDRB	R0, [SP, #5]
ADDS	R0, #10
PUSH	(R1)
MOVW	R3, #256
SXTH	R3, R3
MOVS	R2, #80
SXTH	R2, R2
MOVW	R1, #256
SXTH	R1, R1
UXTB	R0, R0
BL	_MCP2+0
ADD	SP, SP, #4
;Optique.c,257 :: 		Delay_100ms();
BL	_Delay_100ms+0
;Optique.c,258 :: 		PrintString ("\n-----------------ACK 1.1.2--------------------- : ");
MOVW	R0, #lo_addr(?lstr93_Optique+0)
MOVT	R0, #hi_addr(?lstr93_Optique+0)
BL	_PrintString+0
;Optique.c,259 :: 		InitVCNL4020_Periodic3(channel,band);
LDRB	R1, [SP, #5]
LDRB	R0, [SP, #4]
BL	_InitVCNL4020_Periodic3+0
;Optique.c,260 :: 		}
L_interrupt2118:
;Optique.c,261 :: 		if (InterruptStatus & INTERRUPT_STATUS_THRES_LO)
LDRB	R0, [SP, #7]
AND	R0, R0, #2
UXTB	R0, R0
CMP	R0, #0
IT	EQ
BEQ	L_interrupt2119
;Optique.c,263 :: 		VCNL4020_Write_Byte(VCNL4020_Address,REGISTER_INTERRUPT_STATUS,0x02); // clear Interrupt Status
MOVS	R2, #2
MOVS	R1, #142
MOVS	R0, #19
BL	_VCNL4020_Write_Byte+0
;Optique.c,264 :: 		PrintString ("\n-----------------clear Interrupt Status--------------------- : ");
MOVW	R0, #lo_addr(?lstr94_Optique+0)
MOVT	R0, #hi_addr(?lstr94_Optique+0)
BL	_PrintString+0
;Optique.c,265 :: 		MCP2((PCA9956_ADDR_1+band),256, 256, 80, channel); //(char ModuleAddress,int red, int green, int blue, char N_LED)
LDRB	R1, [SP, #4]
LDRB	R0, [SP, #5]
ADDS	R0, #10
PUSH	(R1)
MOVS	R3, #80
SXTH	R3, R3
MOVW	R2, #256
SXTH	R2, R2
MOVW	R1, #256
SXTH	R1, R1
UXTB	R0, R0
BL	_MCP2+0
ADD	SP, SP, #4
;Optique.c,266 :: 		Delay_100ms();
BL	_Delay_100ms+0
;Optique.c,267 :: 		PrintString ("\n-----------------ACK 1.1.3--------------------- : ");
MOVW	R0, #lo_addr(?lstr95_Optique+0)
MOVT	R0, #hi_addr(?lstr95_Optique+0)
BL	_PrintString+0
;Optique.c,268 :: 		InitVCNL4020_Periodic3(channel,band);
LDRB	R1, [SP, #5]
LDRB	R0, [SP, #4]
BL	_InitVCNL4020_Periodic3+0
;Optique.c,269 :: 		}
L_interrupt2119:
;Optique.c,271 :: 		if (Command & COMMAND_MASK_PROX_DATA_READY)
LDRB	R0, [SP, #6]
AND	R0, R0, #32
UXTB	R0, R0
CMP	R0, #0
IT	EQ
BEQ	L_interrupt2120
;Optique.c,273 :: 		PrintString ("\n");
MOVW	R0, #lo_addr(?lstr96_Optique+0)
MOVT	R0, #hi_addr(?lstr96_Optique+0)
BL	_PrintString+0
;Optique.c,274 :: 		PrintString ("RESULT : ");
MOVW	R0, #lo_addr(?lstr97_Optique+0)
MOVT	R0, #hi_addr(?lstr97_Optique+0)
BL	_PrintString+0
;Optique.c,276 :: 		PrintDecimal(VCNL4020_Read_Byte(VCNL4020_Address,registerADDR_RESULT_HIGH)) ;
MOVS	R1, #135
MOVS	R0, #19
BL	_VCNL4020_Read_Byte+0
BL	_PrintDecimal+0
;Optique.c,277 :: 		PrintString (" ");
MOVW	R0, #lo_addr(?lstr98_Optique+0)
MOVT	R0, #hi_addr(?lstr98_Optique+0)
BL	_PrintString+0
;Optique.c,278 :: 		PrintDecimal(VCNL4020_Read_Byte(VCNL4020_Address,registerADDR_RESULT_LOW)) ;
MOVS	R1, #136
MOVS	R0, #19
BL	_VCNL4020_Read_Byte+0
BL	_PrintDecimal+0
;Optique.c,279 :: 		PrintString ("\n\n");
MOVW	R0, #lo_addr(?lstr99_Optique+0)
MOVT	R0, #hi_addr(?lstr99_Optique+0)
BL	_PrintString+0
;Optique.c,280 :: 		PrintString ("\n\nStatus : ");
MOVW	R0, #lo_addr(?lstr100_Optique+0)
MOVT	R0, #hi_addr(?lstr100_Optique+0)
BL	_PrintString+0
;Optique.c,281 :: 		PrintDecimal(VCNL4020_Read_Byte(VCNL4020_Address,REGISTER_INTERRUPT_STATUS)) ;
MOVS	R1, #142
MOVS	R0, #19
BL	_VCNL4020_Read_Byte+0
BL	_PrintDecimal+0
;Optique.c,282 :: 		PrintString ("\n\n");
MOVW	R0, #lo_addr(?lstr101_Optique+0)
MOVT	R0, #hi_addr(?lstr101_Optique+0)
BL	_PrintString+0
;Optique.c,284 :: 		PrintString ("\n-----------------ACK 1.1.2--------------------- : ");
MOVW	R0, #lo_addr(?lstr102_Optique+0)
MOVT	R0, #hi_addr(?lstr102_Optique+0)
BL	_PrintString+0
;Optique.c,285 :: 		}
L_interrupt2120:
;Optique.c,286 :: 		}
IT	AL
BAL	L_interrupt2121
L_interrupt2106:
;Optique.c,289 :: 		MCP2((PCA9956_ADDR_1+band),256, 256, 256, channel); //(char ModuleAddress,int red, int green, int blue, char N_LED)
LDRB	R1, [SP, #4]
LDRB	R0, [SP, #5]
ADDS	R0, #10
PUSH	(R1)
MOVW	R3, #256
SXTH	R3, R3
MOVW	R2, #256
SXTH	R2, R2
MOVW	R1, #256
SXTH	R1, R1
UXTB	R0, R0
BL	_MCP2+0
ADD	SP, SP, #4
;Optique.c,291 :: 		}
L_interrupt2121:
;Optique.c,295 :: 		}
L_end_interrupt2:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _interrupt2
_channel:
;Optique.c,296 :: 		char channel (char channel_)
; channel_ start address is: 0 (R0)
; channel_ end address is: 0 (R0)
; channel_ start address is: 0 (R0)
;Optique.c,298 :: 		compt=0;
MOVS	R2, #0
MOVW	R1, #lo_addr(_compt+0)
MOVT	R1, #hi_addr(_compt+0)
STRB	R2, [R1, #0]
;Optique.c,299 :: 		channel_ = (channel_&0xF0);
AND	R0, R0, #240
UXTB	R0, R0
; channel_ end address is: 0 (R0)
;Optique.c,300 :: 		channel_ = (channel_>>4);
LSRS	R0, R0, #4
UXTB	R0, R0
; channel_ start address is: 0 (R0)
; channel_ end address is: 0 (R0)
;Optique.c,301 :: 		while (channel_ != 1)
L_channel122:
; channel_ start address is: 0 (R0)
CMP	R0, #1
IT	EQ
BEQ	L_channel123
;Optique.c,303 :: 		channel_ = channel_>>1;
LSRS	R0, R0, #1
UXTB	R0, R0
;Optique.c,304 :: 		compt = compt++;
MOVW	R2, #lo_addr(_compt+0)
MOVT	R2, #hi_addr(_compt+0)
LDRB	R1, [R2, #0]
ADDS	R1, R1, #1
STRB	R1, [R2, #0]
;Optique.c,305 :: 		}
; channel_ end address is: 0 (R0)
IT	AL
BAL	L_channel122
L_channel123:
;Optique.c,307 :: 		return channel_;
MOVW	R1, #lo_addr(_compt+0)
MOVT	R1, #hi_addr(_compt+0)
LDRB	R0, [R1, #0]
;Optique.c,308 :: 		}
L_end_channel:
BX	LR
; end of _channel
