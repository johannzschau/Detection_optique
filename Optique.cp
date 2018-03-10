#line 1 "C:/Users/Guardian/Desktop/Prodetics5/Optique.c"
#line 9 "C:/Users/Guardian/Desktop/Prodetics5/Optique.c"
void PrintFload(float fnum);
void PrintString(char t []);
void ScanDecimal(int *t) ;
void InitI2C2();
void InitI2C1();
void InitVCNL4020();
void InitVCNL4020_Periodic(char N_Sensor);
void close_PCA9544 ();
void interrupt ();
void interrupt2 ();
void setupGPIO();
void test_led();
void InitVCNL4020_Periodic2(char N_Sensor, char band);
void Read_serial_number();
void TEST_EEPROM();
void TEST_CAN();
void initCAN (void);
void Send_Can ( void );
void MCP(char ModuleAddress,int red, int green, int blue, char N_LED);
void MCP2(char ModuleAddress,int red, int green, int blue, char N_LED);
void InitVCNL4020();
void InitVCNL4020_Periodic(char N_Sensor);
void close_PCA9544 ();
void interrupt ();
void setupGPIO();
void test_led();
void InitVCNL4020_Periodic2(char N_Sensor, char band);
void Read_serial_number();
void TEST_EEPROM();
void TEST_CAN();
void Expander_Write_Byte(char ModuleAddress,char RegAddress, char Data_);
void Expander_Read_Byte(char ModuleAddress, char RegAddress);

void EXTI1_IRQHandler() iv IVT_INT_EXTI1 ics ICS_AUTO
{
 while (1)
 {
 PrintString ("interrupt ");
 Delay_100ms();
 }
}

char channel (char channel_);

int oldstate= 0;
char data_[256];
sbit EXPAND_RST at GPIOC_ODR.B2;
char number_LED =0;
int bands = 0;
#line 1 "c:/users/guardian/desktop/prodetics5/gla.h"


char uart_rd;
int nombre;
#line 12 "c:/users/guardian/desktop/prodetics5/gla.h"
void ScanDecimal(int *t)
{
 while (1) {
 if (UART1_Data_Ready()) {
 uart_rd = UART1_Read();
 UART1_Write(uart_rd);
 *t = uart_rd ;
 break;
 }
 }
 }
#line 28 "c:/users/guardian/desktop/prodetics5/gla.h"
void PrintString(char t [])
{
 Uart1_write_text  (t);
UART1_Write(10);
UART1_Write(13);
}
#line 37 "c:/users/guardian/desktop/prodetics5/gla.h"
void PrintDecimal(int t)
{
char text [6] ;
ByteToStr(t, text);
Uart1_write_text (text);
}
#line 46 "c:/users/guardian/desktop/prodetics5/gla.h"
void InitI2C2()

{
 GPIO_Digital_Output(&GPIOB_BASE, _GPIO_PINMASK_10);
 GPIO_Digital_Output(&GPIOB_BASE, _GPIO_PINMASK_11);
 I2C2_Init_Advanced(100000, &_GPIO_MODULE_I2C2_PB10_11);
 Delay_ms(100);
}
#line 57 "c:/users/guardian/desktop/prodetics5/gla.h"
void InitI2C1()

{
 GPIO_Digital_Output(&GPIOB_BASE, _GPIO_PINMASK_6);
 GPIO_Digital_Output(&GPIOB_BASE, _GPIO_PINMASK_7);

I2C1_Init_Advanced(100000, &_GPIO_MODULE_I2C1_PB67);
I2C_Set_Active(&I2C1_Start, &I2C1_Read, &I2C1_Write);
 Delay_ms(100);
}
#line 71 "c:/users/guardian/desktop/prodetics5/gla.h"
void setupGPIO()
{
GPIO_Config(&GPIOA_BASE, _GPIO_PINMASK_LOW, _GPIO_CFG_PULL_UP|_GPIO_CFG_DIGITAL_INPUT);
GPIO_Config(&GPIOA_BASE, _GPIO_PINMASK_8, _GPIO_CFG_PULL_UP|_GPIO_CFG_DIGITAL_INPUT);
}
#line 1 "c:/users/guardian/desktop/prodetics5/can.h"
unsigned long value ;
unsigned long Can_Init_Flags;
unsigned char Can_Send_Flags, Can_Rcv_Flags;
unsigned char Rx_Data_Len;
char RxTx_Data[8];
unsigned char compt;



char Rx_Data[8];
char Msg_Rcvd;
const long ID_1st = 8, ID_2nd = 37;
long Rx_ID;
char menu ;





void Trame_Test (void)
{
 RxTx_Data[0] =1;
 RxTx_Data[1] =2;
 RxTx_Data[2] =3;
 RxTx_Data[3] =4;
 RxTx_Data[4] =5;
 RxTx_Data[5] =6;
 RxTx_Data[6] =7;

}


void Send_Can ( void )
{
CAN1Write(ID_1st, RxTx_Data, 7, Can_Send_Flags);

 for (compt=0;compt<=30;compt++) {
 Msg_Rcvd = CAN1Read(0, &Rx_ID , Rx_Data , &Rx_Data_Len, &Can_Rcv_Flags);
 if (((Rx_ID == ID_2nd)||Rx_ID == ID_1st) && Msg_Rcvd) {


 Delay_ms(10);
 CAN1Write(ID_1st,RxTx_Data, 1, Can_Send_Flags);
 break ;
 }
 if (compt >= 30){PrintString ("!!!!!!! time-out !!!!!!!!");}
 }

 }


void initCAN (void)
 {
const unsigned int SJW = 1;
const unsigned int BRP = 4;
const unsigned int PHSEG1 = 5;
const unsigned int PHSEG2 = 2;
const unsigned int PROPSEG = 8;


GPIO_Digital_Input(&GPIOB_BASE, _GPIO_PINMASK_8);
GPIO_Digital_Output(&GPIOB_BASE, _GPIO_PINMASK_9);
GPIOE_ODR = 0;

 Can_Init_Flags = 0;
 Can_Send_Flags = 0;
 Can_Rcv_Flags = 0;

 Can_Send_Flags = _CAN_TX_STD_FRAME &
 _CAN_TX_NO_RTR_FRAME;

 Can_Init_Flags = _CAN_CONFIG_AUTOMATIC_RETRANSMISSION &
 _CAN_CONFIG_RX_FIFO_NOT_LOCKED_ON_OVERRUN &
 _CAN_CONFIG_TIME_TRIGGERED_MODE_DISABLED &
 _CAN_CONFIG_TX_FIFO_PRIORITY_BY_IDINTIFIER &
 _CAN_CONFIG_WAKE_UP;

 CAN1InitializeAdvanced(SJW, BRP, PHSEG1, PHSEG2, PROPSEG,Can_Init_Flags, &_GPIO_MODULE_CAN1_PB89);

 CANSetFilterScale32(0, _CAN_FILTER_ENABLED & _CAN_FILTER_ID_MASK_MODE & _CAN_FILTER_STD_MSG, ID_2nd, -1);

 CAN1SetOperationMode(_CAN_OperatingMode_Normal);
 }

 void TEST_CAN()
{
PrintString ("---------init can---------");
initCAN ();
Delay_100ms();
Trame_Test ();
Send_Can ();
}
#line 1 "c:/users/guardian/desktop/prodetics5/expand2click.h"
#line 272 "c:/users/guardian/desktop/prodetics5/expand2click.h"
extern sfr sbit EXPAND_RST;

void EXPAND_Reset(){
 EXPAND_RST = 1;
 Delay_ms(5);
 EXPAND_RST = 0;
 Delay_ms(5);
 EXPAND_RST = 1;
 Delay_ms(1);
}

char Expander_Read_Byte(char ModuleAddress, char RegAddress){
 char temp;
 char reg_data[2];

 reg_data[0]=RegAddress;

 I2C2_Start();
 I2C2_Write( (0b0010 << 4) |ModuleAddress,reg_data,1,END_MODE_RESTART);
 I2C2_Read( (0b0010 << 4) |ModuleAddress,reg_data,1,END_MODE_STOP);

 temp=reg_data[0];
 return temp;
}

void Expander_Write_Byte(char ModuleAddress,char RegAddress, char Data_) {
 char reg_data[2];

 reg_data[0]=RegAddress;
 reg_data[1]=Data_;

 I2C2_Start();
 I2C2_Write( (0b0010 << 4) |ModuleAddress,reg_data,2,END_MODE_STOP);
}
#line 1 "c:/users/guardian/desktop/prodetics5/pca9956.h"
#line 48 "c:/users/guardian/desktop/prodetics5/pca9956.h"
int adress = 0x14;
int compteur = 1;
char MCP_OE[5] = {0xFD, 0xF7,0xDF,0x7F};

void PCA9956_Write_Byte(char ModuleAddress,char RegAddress, char Data_) {
 char reg_data[2];

 reg_data[0]=RegAddress;
 reg_data[1]=Data_;

 I2C2_Start();
 I2C2_Write(ModuleAddress,reg_data,2,END_MODE_STOP);
}
void MCP(char ModuleAddress,int red, int green, int blue, char N_LED)
{





 InitI2C2();

 if (ModuleAddress<=0x0D)
 {
 PrintString ("condition _1");
 Expander_Write_Byte( 0x20 ,  0x13 ,0x00);

 Expander_Write_Byte( 0x20 ,  0x00 , 0x00);
 Expander_Write_Byte( 0x20 ,  0x12 ,0x00);
 Expander_Write_Byte( 0x20 ,  0x12 ,MCP_OE[ModuleAddress - 10]);
 }
 if (ModuleAddress>=0x0E)
 {
 PrintString ("condition _2");
 Expander_Write_Byte( 0x20 ,  0x12 ,0x00);

 Expander_Write_Byte( 0x20 ,  0x01 , 0x00);
 Expander_Write_Byte( 0x20 ,  0x13 ,0x00);
 Expander_Write_Byte( 0x20 ,  0x13 ,MCP_OE[ModuleAddress - 14]);
 }





PCA9956_Write_Byte(ModuleAddress,  0x40 ,  0x96 );

PCA9956_Write_Byte(ModuleAddress,  0x02 ,  0xAA );
PCA9956_Write_Byte(ModuleAddress,  0x03 ,  0xAA );
PCA9956_Write_Byte(ModuleAddress,  0x04 ,  0xAA );
PCA9956_Write_Byte(ModuleAddress,  0x05 ,  0xAA );
PCA9956_Write_Byte(ModuleAddress,  0x06 ,  0xAA );
PCA9956_Write_Byte(ModuleAddress,  0x07 ,  0xAA );





 switch (N_LED)
 {
 case 0:
 PrintString ("case_0");
 PCA9956_Write_Byte(ModuleAddress,  0x0A , blue);
 PCA9956_Write_Byte(ModuleAddress,  0x0B , green);
 PCA9956_Write_Byte(ModuleAddress,  0x0C , red);
 PCA9956_Write_Byte(ModuleAddress,  0x0D , blue);
 PCA9956_Write_Byte(ModuleAddress,  0x0E , green);
 PCA9956_Write_Byte(ModuleAddress,  0x0F , red);

 break;
 case 1:
 PrintString ("case_1");
 PCA9956_Write_Byte(ModuleAddress,  0x10 , blue);
 PCA9956_Write_Byte(ModuleAddress,  0x11 , green);
 PCA9956_Write_Byte(ModuleAddress,  0x12 , red);
 PCA9956_Write_Byte(ModuleAddress,  0x13 , blue);
 PCA9956_Write_Byte(ModuleAddress,  0x14 , green);
 PCA9956_Write_Byte(ModuleAddress,  0x15 , red);

 break;
 case 2:
 PrintString ("case_2");
 PCA9956_Write_Byte(ModuleAddress,  0x16 , blue);
 PCA9956_Write_Byte(ModuleAddress,  0x17 , green);
 PCA9956_Write_Byte(ModuleAddress,  0x18 , red);
 PCA9956_Write_Byte(ModuleAddress,  0x19 , blue);
 PCA9956_Write_Byte(ModuleAddress,  0x1A , green);
 PCA9956_Write_Byte(ModuleAddress,  0x1B , red);

 break;
 case 3:
 PrintString ("case_3");
 PCA9956_Write_Byte(ModuleAddress,  0x1C , blue);
 PCA9956_Write_Byte(ModuleAddress,  0x1D , green);
 PCA9956_Write_Byte(ModuleAddress,  0x1E , red);
 PCA9956_Write_Byte(ModuleAddress,  0x1F , blue);
 PCA9956_Write_Byte(ModuleAddress,  0x20 , green);
 PCA9956_Write_Byte(ModuleAddress,  0x21 , red);

 break;
 default:
 printString ("Error 1.1");
 break;
 }



}


void test_led()
{
 for (adress = 10 ; adress <= 17 ; adress++)
 {
 for (compteur = 0 ; compteur <= 3 ; compteur++)
{
MCP(adress,256, 256, 80, compteur);
Delay_ms (50);
MCP(adress,80, 256, 256, compteur);
Delay_ms (50);
MCP(adress,256, 80, 256, compteur);
Delay_ms (50);

}
}

}

void MCP2(char ModuleAddress,int red, int green, int blue, char N_LED)
{





 InitI2C2();


 Expander_Write_Byte( 0x20 ,  0x00 , 0x00);
 Expander_Write_Byte( 0x20 ,  0x12 ,0x00);
 Expander_Write_Byte( 0x20 ,  0x12 ,MCP_OE[0x55]);
 Expander_Write_Byte( 0x20 ,  0x01 , 0x00);
 Expander_Write_Byte( 0x20 ,  0x13 ,0x00);
 Expander_Write_Byte( 0x20 ,  0x13 ,MCP_OE[0x55]);






PCA9956_Write_Byte(ModuleAddress,  0x40 ,  0x96 );

PCA9956_Write_Byte(ModuleAddress,  0x02 ,  0xAA );
PCA9956_Write_Byte(ModuleAddress,  0x03 ,  0xAA );
PCA9956_Write_Byte(ModuleAddress,  0x04 ,  0xAA );
PCA9956_Write_Byte(ModuleAddress,  0x05 ,  0xAA );
PCA9956_Write_Byte(ModuleAddress,  0x06 ,  0xAA );
PCA9956_Write_Byte(ModuleAddress,  0x07 ,  0xAA );





 switch (N_LED)
 {
 case 0:
 PrintString ("case_0");
 PCA9956_Write_Byte(ModuleAddress,  0x0A , blue);
 PCA9956_Write_Byte(ModuleAddress,  0x0B , green);
 PCA9956_Write_Byte(ModuleAddress,  0x0C , red);
 PCA9956_Write_Byte(ModuleAddress,  0x0D , blue);
 PCA9956_Write_Byte(ModuleAddress,  0x0E , green);
 PCA9956_Write_Byte(ModuleAddress,  0x0F , red);

 break;
 case 1:
 PrintString ("case_1");
 PCA9956_Write_Byte(ModuleAddress,  0x10 , blue);
 PCA9956_Write_Byte(ModuleAddress,  0x11 , green);
 PCA9956_Write_Byte(ModuleAddress,  0x12 , red);
 PCA9956_Write_Byte(ModuleAddress,  0x13 , blue);
 PCA9956_Write_Byte(ModuleAddress,  0x14 , green);
 PCA9956_Write_Byte(ModuleAddress,  0x15 , red);

 break;
 case 2:
 PrintString ("case_2");
 PCA9956_Write_Byte(ModuleAddress,  0x16 , blue);
 PCA9956_Write_Byte(ModuleAddress,  0x17 , green);
 PCA9956_Write_Byte(ModuleAddress,  0x18 , red);
 PCA9956_Write_Byte(ModuleAddress,  0x19 , blue);
 PCA9956_Write_Byte(ModuleAddress,  0x1A , green);
 PCA9956_Write_Byte(ModuleAddress,  0x1B , red);

 break;
 case 3:
 PrintString ("case_3");
 PCA9956_Write_Byte(ModuleAddress,  0x1C , blue);
 PCA9956_Write_Byte(ModuleAddress,  0x1D , green);
 PCA9956_Write_Byte(ModuleAddress,  0x1E , red);
 PCA9956_Write_Byte(ModuleAddress,  0x1F , blue);
 PCA9956_Write_Byte(ModuleAddress,  0x20 , green);
 PCA9956_Write_Byte(ModuleAddress,  0x21 , red);

 break;
 default:
 printString ("Error 1.1");
 break;
 }



}
#line 1 "c:/users/guardian/desktop/prodetics5/pca9544a.h"
#line 19 "c:/users/guardian/desktop/prodetics5/pca9544a.h"
void PCA9544A_Write_Byte(char ModuleAddress,char RegAddress, char Data_) {
 char reg_data[2];

 reg_data[0]=RegAddress;
 reg_data[1]=Data_;

 I2C1_Start();
 I2C1_Write(ModuleAddress,reg_data,2,END_MODE_STOP);
}

char PCA9544A_Read_Byte(char ModuleAddress, char RegAddress){
 char temp;
 char reg_data[2];

 reg_data[0]=RegAddress;

 I2C1_Start();
 I2C1_Write(ModuleAddress,reg_data,1,END_MODE_RESTART);
 I2C1_Read(ModuleAddress,reg_data,1,END_MODE_STOP);

 temp=reg_data[0];
 return temp;
}
void close_PCA9544 ()
{

PCA9544A_Write_Byte( 0x70  , 0x00 , 0x00 );
PCA9544A_Write_Byte( 0x71  , 0x00 , 0x00 );
PCA9544A_Write_Byte( 0x72  , 0x00 , 0x00 );
PCA9544A_Write_Byte( 0x73  , 0x00 , 0x00 );
PCA9544A_Write_Byte( 0x74  , 0x00 , 0x00 );
PCA9544A_Write_Byte( 0x75  , 0x00 , 0x00 );
PCA9544A_Write_Byte( 0x76  , 0x00 , 0x00 );
PCA9544A_Write_Byte( 0x77  , 0x00 , 0x00 );

}
#line 1 "c:/users/guardian/desktop/prodetics5/vcnl4020.h"
#line 107 "c:/users/guardian/desktop/prodetics5/vcnl4020.h"
void VCNL4020_Write_Byte(char ModuleAddress,char RegAddress, char Data_) {
 char reg_data[2];

 reg_data[0]=RegAddress;
 reg_data[1]=Data_;

 I2C1_Start();
 I2C1_Write(ModuleAddress,reg_data,2,END_MODE_STOP);
}

char VCNL4020_Read_Byte(char ModuleAddress, char RegAddress){
 char temp;
 char reg_data[2];

 reg_data[0]=RegAddress;

 I2C1_Start();
 I2C1_Write(ModuleAddress,reg_data,1,END_MODE_RESTART);
 I2C1_Read(ModuleAddress,reg_data,1,END_MODE_STOP);

 temp=reg_data[0];
 return temp;
}

void InitVCNL4020_Periodic2(char N_Sensor, char band)

{


 int i = 1;

 char adress_PCA9544 = ( 0x70  + band);
 char PCA9544A_channel = ( 0x04 +N_Sensor);

 unsigned char ID=0;
 unsigned char Command=0;
 unsigned char Current=0;
 unsigned int ProxiValue_H=0;
 unsigned int ProxiValue_L=0;
 unsigned int SummeProxiValue_H=0;
 unsigned int SummeProxiValue_L=0;
 unsigned int AverageProxiValue_H=0;
 unsigned int AverageProxiValue_L=0;
 unsigned int AmbiValue=0;
 unsigned char InterruptStatus=0;
 unsigned char InterruptControl=0;



InitI2C1();
PrintString ("adress : ");
PrintDecimal(adress_PCA9544);
printString ("PCA9544A_channel : ");
PrintString ("\n ");
PrintDecimal(PCA9544A_channel);
PrintString ("\n ");
close_PCA9544 ();

PCA9544A_Write_Byte(adress_PCA9544, 0x00 ,PCA9544A_channel);

 VCNL4020_Write_Byte( 0x13 , (0x80) , (0x00) );

 VCNL4020_Write_Byte( 0x13 , (0x82) , (0x04) );

 VCNL4020_Write_Byte( 0x13 , (0x80) , (0x02)  |  (0x01) );

 VCNL4020_Write_Byte( 0x13 , 0x89 , (0x00)  |
  (0x02)  |  (0x00) );


 SummeProxiValue_H = 0;
 SummeProxiValue_L = 0;
 for (i=0; i<30; i++) {
 do {
Command = VCNL4020_Read_Byte( 0x13 , (0x80) ) ;

 } while (!(Command &  (0x20) ));

 ProxiValue_H = (VCNL4020_Read_Byte( 0x13 , 0x87 ));
 SummeProxiValue_H += ProxiValue_H;

 ProxiValue_L = (VCNL4020_Read_Byte( 0x13 , 0x88 ));
 SummeProxiValue_L += ProxiValue_L;
 }
 AverageProxiValue_H = SummeProxiValue_H/30;
 AverageProxiValue_L = SummeProxiValue_L/30;

 VCNL4020_Write_Byte( 0x13 , 0x8C ,AverageProxiValue_H+1);
 VCNL4020_Write_Byte( 0x13 , 0x8D ,(AverageProxiValue_L + 10));

 VCNL4020_Write_Byte( 0x13 , 0x8A ,AverageProxiValue_H-1);
 VCNL4020_Write_Byte( 0x13 , 0x8B ,(AverageProxiValue_L - 10));






 PrintString ("\n-----------------HIGH_THRES--------------------- : ");
 PrintDecimal(AverageProxiValue_H ) ;
 PrintString ("\n\n");
 PrintString ("\n-----------------LOW_THRES--------------------- : ");
 PrintDecimal(AverageProxiValue_L ) ;
 PrintString ("\n\n");


 do {
Command = VCNL4020_Read_Byte( 0x13 , (0x80) ) ;
 } while (!(Command & ( (0x20)  |  (0x40) )));


 InterruptStatus = VCNL4020_Read_Byte( 0x13 , (0x8e) ) ;

 if (InterruptStatus &  (0x01) ) {

 VCNL4020_Write_Byte( 0x13 , (0x8e) ,0x01);


 PrintString ("\nclear Interrupt Status\n");
 }

 if (Command &  (0x20) ) {
 PrintString ("\n");
 PrintString ("RESULT : ");

PrintDecimal(VCNL4020_Read_Byte( 0x13 , 0x87 )) ;
 PrintString (" ");
PrintDecimal(VCNL4020_Read_Byte( 0x13 , 0x88 )) ;
PrintString ("\n\n");
PrintString ("\n\nStatus : ");
PrintDecimal(VCNL4020_Read_Byte( 0x13 , (0x8e) )) ;
PrintString ("\n\n");
MCP((0x0A+band),80, 256, 256, N_Sensor);
 PrintString ("\n-----------------CHANNEL_1--------------------- : ");
 PrintDecimal(N_Sensor) ;
 PrintString ("\n\n");
 PrintString ("\n-----------------BAND_1--------------------- : ");
 PrintDecimal(band) ;
 PrintString ("\n\n");

 }
}

void InitVCNL4020()

{
InitI2C1();
close_PCA9544 ();
PCA9544A_Write_Byte(0X70,0x00,0x04);
PrintString ("PCA9544A_ACK");
VCNL4020_Write_Byte( 0x13 , 0x82 ,0x01);
PrintString ("VCNL4020_ACK");
VCNL4020_Write_Byte( 0x13 , 0x83 ,0x14);
PrintString ("VCNL4020_ACK_2");
VCNL4020_Write_Byte( 0x13 , 0x80 ,0x08);
PrintString ("VCNL4020_ACK_2");
Delay_100ms();
}

void InitVCNL4020_Periodic3(char N_Sensor, char band)

{


 int i = 1;

 char adress_PCA9544 = ( 0x70  + band);
 char PCA9544A_channel = ( 0x04 +N_Sensor);

 unsigned char ID=0;
 unsigned char Command=0;
 unsigned char Current=0;
 unsigned int ProxiValue_H=0;
 unsigned int ProxiValue_L=0;
 unsigned int SummeProxiValue_H=0;
 unsigned int SummeProxiValue_L=0;
 unsigned int AverageProxiValue_H=0;
 unsigned int AverageProxiValue_L=0;
 unsigned int AmbiValue=0;
 unsigned char InterruptStatus=0;
 unsigned char InterruptControl=0;



InitI2C1();
PrintString ("adress : ");
PrintDecimal(adress_PCA9544);
printString ("PCA9544A_channel : ");
PrintString ("\n ");
PrintDecimal(PCA9544A_channel);
PrintString ("\n ");
close_PCA9544 ();

PCA9544A_Write_Byte(adress_PCA9544, 0x00 ,PCA9544A_channel);

 VCNL4020_Write_Byte( 0x13 , (0x80) , (0x00) );

 VCNL4020_Write_Byte( 0x13 , (0x82) , (0x04) );

 VCNL4020_Write_Byte( 0x13 , (0x80) , (0x02)  |  (0x01) );

 VCNL4020_Write_Byte( 0x13 , 0x89 , (0x00)  |
  (0x02)  |  (0x00) );


 SummeProxiValue_H = 0;
 SummeProxiValue_L = 0;
 for (i=0; i<10; i++) {
 do {
Command = VCNL4020_Read_Byte( 0x13 , (0x80) ) ;

 } while (!(Command &  (0x20) ));

 ProxiValue_H = (VCNL4020_Read_Byte( 0x13 , 0x87 ));
 SummeProxiValue_H += ProxiValue_H;

 ProxiValue_L = (VCNL4020_Read_Byte( 0x13 , 0x88 ));
 SummeProxiValue_L += ProxiValue_L;
 }
 AverageProxiValue_H = SummeProxiValue_H/10;
 AverageProxiValue_L = SummeProxiValue_L/10;

 VCNL4020_Write_Byte( 0x13 , 0x8C ,AverageProxiValue_H+1);
 VCNL4020_Write_Byte( 0x13 , 0x8D ,(AverageProxiValue_L ));

 VCNL4020_Write_Byte( 0x13 , 0x8A ,AverageProxiValue_H-1);
 VCNL4020_Write_Byte( 0x13 , 0x8B ,(AverageProxiValue_L));






 PrintString ("\n-----------------HIGH_THRES--------------------- : ");
 PrintDecimal(AverageProxiValue_H ) ;
 PrintString ("\n\n");
 PrintString ("\n-----------------LOW_THRES--------------------- : ");
 PrintDecimal(AverageProxiValue_L ) ;
 PrintString ("\n\n");


 do {
Command = VCNL4020_Read_Byte( 0x13 , (0x80) ) ;
 } while (!(Command & ( (0x20)  |  (0x40) )));


 InterruptStatus = VCNL4020_Read_Byte( 0x13 , (0x8e) ) ;

 if (InterruptStatus &  (0x01) ) {

 VCNL4020_Write_Byte( 0x13 , (0x8e) ,0x01);


 PrintString ("\nclear Interrupt Status\n");
 }

 if (Command &  (0x20) ) {
 PrintString ("\n");
 PrintString ("RESULT : ");

PrintDecimal(VCNL4020_Read_Byte( 0x13 , 0x87 )) ;
 PrintString (" ");
PrintDecimal(VCNL4020_Read_Byte( 0x13 , 0x88 )) ;
PrintString ("\n\n");
PrintString ("\n\nStatus : ");
PrintDecimal(VCNL4020_Read_Byte( 0x13 , (0x8e) )) ;
PrintString ("\n\n");
MCP((0x0A+band),80, 256, 256, N_Sensor);
 PrintString ("\n-----------------CHANNEL_1--------------------- : ");
 PrintDecimal(N_Sensor) ;
 PrintString ("\n\n");
 PrintString ("\n-----------------BAND_1--------------------- : ");
 PrintDecimal(band) ;
 PrintString ("\n\n");

 }
}
#line 1 "c:/users/guardian/desktop/prodetics5/ds28cm.h"
#line 18 "c:/users/guardian/desktop/prodetics5/ds28cm.h"
char DS28CM00R_Read_Byte(char ModuleAddress, char RegAddress){
 char temp;
 char reg_data[2];

 reg_data[0]=RegAddress;

 I2C2_Start();
 I2C2_Write(ModuleAddress,reg_data,1,END_MODE_RESTART);
 I2C2_Read(ModuleAddress,reg_data,1,END_MODE_STOP);

 temp=reg_data[0];
 return temp;
}

void DS28CM00R_Write_Byte(char ModuleAddress,char RegAddress, char Data_) {
 char reg_data[2];

 reg_data[0]=RegAddress;
 reg_data[1]=Data_;

 I2C2_Start();
 I2C2_Write(ModuleAddress,reg_data,2,END_MODE_STOP);
}
void Read_serial_number()
{
InitI2C2();
PrintString ("---------serial_number---------");
PrintDecimal(DS28CM00R_Read_Byte( 0x50 , 0x01 ));
PrintString (" ");
PrintDecimal(DS28CM00R_Read_Byte( 0x50 , 0x02 ));
PrintString (" ");
PrintDecimal(DS28CM00R_Read_Byte( 0x50 , 0x03 ));
PrintString (" ");
PrintDecimal(DS28CM00R_Read_Byte( 0x50 , 0x04 ));
PrintString (" ");
PrintDecimal(DS28CM00R_Read_Byte( 0x50 , 0x05 ));
PrintString (" ");
PrintDecimal(DS28CM00R_Read_Byte( 0x50 , 0x06 ));
PrintString (" ");
PrintDecimal(DS28CM00R_Read_Byte( 0x50 , 0x07 ));
PrintString ("\n");
}
#line 1 "c:/users/guardian/desktop/prodetics5/eeprom.h"



void eeprom_Write_Byte(char ModuleAddress,char RegAddress, char Data_) {
 char reg_data[2];

 reg_data[0]=RegAddress;
 reg_data[1]=Data_;

 I2C1_Start();
 I2C1_Write(ModuleAddress,reg_data,2,END_MODE_STOP);
}

char eeprom_Read_Byte(char ModuleAddress, char RegAddress){
 char temp;
 char reg_data[2];

 reg_data[0]=RegAddress;

 I2C1_Start();
 I2C1_Write(ModuleAddress,reg_data,1,END_MODE_RESTART);
 I2C1_Read(ModuleAddress,reg_data,1,END_MODE_STOP);

 temp=reg_data[0];
 return temp;
}
void TEST_EEPROM()
{
InitI2C1();
PrintString ("---------TEST_EEPROM---------");
eeprom_Write_Byte( 0x50 ,0x00,0xAB);
PrintString (" ");
PrintDecimal(eeprom_Read_Byte( 0x50 ,0x00));
PrintString (" ");
PrintString ("-----------------------------");
}
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for arm/include/stdio.h"
#line 69 "C:/Users/Guardian/Desktop/Prodetics5/Optique.c"
void main()
{

UART1_Init (9600);

PrintString ("Programme 3.1.2--Detection Optique--Oscillateur : 8Mhz ");

setupGPIO();

Read_serial_number();

TEST_EEPROM();

MCP(0x0A,256, 256, 256, 0);

TEST_CAN();

 for (bands = 0 ; bands <= 7 ; bands++)
 {
 for (compteur = 0 ; compteur <= 3 ; compteur++)
 {
 InitVCNL4020_Periodic3(compteur,bands);
 }
 }

while (1)
 {
 interrupt ();
 }


}
#line 108 "C:/Users/Guardian/Desktop/Prodetics5/Optique.c"
void interrupt ()
{
unsigned char Command = 0;
unsigned char InterruptStatus=0;
unsigned char channel =0;
unsigned char N_LED =0;
unsigned char band =0;
unsigned char compt=0;


setupGPIO();

 if(GPIOA_IDRbits.IDR1 == 0||GPIOA_IDRbits.IDR2 == 0||GPIOA_IDRbits.IDR3 == 0||GPIOA_IDRbits.IDR4 == 0||GPIOA_IDRbits.IDR5 == 0||GPIOA_IDRbits.IDR6 == 0||GPIOA_IDRbits.IDR7 == 0||GPIOA_IDRbits.IDR8 == 0)
 {
 close_PCA9544 ();

 if (GPIOA_IDRbits.IDR1 == 0){channel=PCA9544A_Read_Byte( 0x70 ,  0x00 );band=0;}
 if (GPIOA_IDRbits.IDR2 == 0){channel=PCA9544A_Read_Byte( 0x71 ,  0x00 );band=1;}
 if (GPIOA_IDRbits.IDR3 == 0){channel=PCA9544A_Read_Byte( 0x72 ,  0x00 );band=2;}
 if (GPIOA_IDRbits.IDR4 == 0){channel=PCA9544A_Read_Byte( 0x73 ,  0x00 );band=3;}
 if (GPIOA_IDRbits.IDR5 == 0){channel=PCA9544A_Read_Byte( 0x74 ,  0x00 );band=4;}
 if (GPIOA_IDRbits.IDR6 == 0){channel=PCA9544A_Read_Byte( 0x75 ,  0x00 );band=5;}
 if (GPIOA_IDRbits.IDR7 == 0){channel=PCA9544A_Read_Byte( 0x76 ,  0x00 );band=6;}
 if (GPIOA_IDRbits.IDR8 == 0){channel=PCA9544A_Read_Byte( 0x77 ,  0x00 );band=7;}

 channel = (channel&0xF0);
 channel = (channel>>4);
 while (channel != 1)
 {
 channel = channel>>1;
 compt = compt++;
 }
 channel=compt;

 PrintString ("\n-----------------CHANNEL--------------------- : ");
 PrintDecimal(channel) ;
 PrintString ("\n\n");
 PrintString ("\n-----------------BAND--------------------- : ");
 PrintDecimal(band) ;
 PrintString ("\n\n");

 PCA9544A_Write_Byte(( 0x70 +band), 0x00 ,( 0x04 +channel));
 PrintString ("\n-----------------ACK 1.1.1--------------------- : ");

 do {
 Command = VCNL4020_Read_Byte( 0x13 , (0x80) ) ;
 } while (!(Command & ( (0x20)  |  (0x40) )));

 InterruptStatus = VCNL4020_Read_Byte( 0x13 , (0x8e) ) ;

 if (InterruptStatus &  (0x01) )
 {
 VCNL4020_Write_Byte( 0x13 , (0x8e) ,0x01);
 PrintString ("\n-----------------clear Interrupt Status--------------------- : ");
 MCP(( 0x0A +band),256, 80, 256, channel);
 Delay_100ms();
 PrintString ("\n-----------------ACK 1.1.2--------------------- : ");
 InitVCNL4020_Periodic2(channel,band);
 }
 if (InterruptStatus &  (0x02) )
 {
 VCNL4020_Write_Byte( 0x13 , (0x8e) ,0x02);
 PrintString ("\n-----------------clear Interrupt Status--------------------- : ");
 MCP(( 0x0A +band),256, 256, 80, channel);
 Delay_100ms();
 PrintString ("\n-----------------ACK 1.1.3--------------------- : ");
 InitVCNL4020_Periodic2(channel,band);
 }

 if (Command &  (0x20) )
 {
 PrintString ("\n");
 PrintString ("RESULT : ");

 PrintDecimal(VCNL4020_Read_Byte( 0x13 , 0x87 )) ;
 PrintString (" ");
 PrintDecimal(VCNL4020_Read_Byte( 0x13 , 0x88 )) ;
 PrintString ("\n\n");
 PrintString ("\n\nStatus : ");
 PrintDecimal(VCNL4020_Read_Byte( 0x13 , (0x8e) )) ;
 PrintString ("\n\n");

 PrintString ("\n-----------------ACK 1.1.2--------------------- : ");
 }
 }
 else
 {
 MCP(( 0x0A +band),256, 256, 256, channel);

 }



}
#line 209 "C:/Users/Guardian/Desktop/Prodetics5/Optique.c"
void interrupt2 ()
{


unsigned char Command = 0;
unsigned char InterruptStatus=0;
unsigned char channel =0;
unsigned char band =0;
unsigned char compt=0;


setupGPIO();

 if(GPIOA_IDRbits.IDR1 == 0||GPIOA_IDRbits.IDR2 == 0||GPIOA_IDRbits.IDR3 == 0||GPIOA_IDRbits.IDR4 == 0||GPIOA_IDRbits.IDR5 == 0||GPIOA_IDRbits.IDR6 == 0||GPIOA_IDRbits.IDR7 == 0||GPIOA_IDRbits.IDR8 == 0)
 {
 close_PCA9544 ();

 if (GPIOA_IDRbits.IDR1 == 0){number_LED=PCA9544A_Read_Byte( 0x70 ,  0x00 );band=0;channel = channel (number_LED);MCP2(( 0x0A +band),256, 80, 256, channel);}
 if (GPIOA_IDRbits.IDR2 == 0){number_LED=PCA9544A_Read_Byte( 0x71 ,  0x00 );band=1;channel = channel (number_LED);MCP2(( 0x0A +band),256, 80, 256, channel);}
 if (GPIOA_IDRbits.IDR3 == 0){number_LED=PCA9544A_Read_Byte( 0x72 ,  0x00 );band=2;channel = channel (number_LED);MCP2(( 0x0A +band),256, 80, 256, channel);}
 if (GPIOA_IDRbits.IDR4 == 0){number_LED=PCA9544A_Read_Byte( 0x73 ,  0x00 );band=3;channel = channel (number_LED);MCP2(( 0x0A +band),256, 80, 256, channel);}
 if (GPIOA_IDRbits.IDR5 == 0){number_LED=PCA9544A_Read_Byte( 0x74 ,  0x00 );band=4;channel = channel (number_LED);MCP2(( 0x0A +band),256, 80, 256, channel);}
 if (GPIOA_IDRbits.IDR6 == 0){number_LED=PCA9544A_Read_Byte( 0x75 ,  0x00 );band=5;channel = channel (number_LED);MCP2(( 0x0A +band),256, 80, 256, channel);}
 if (GPIOA_IDRbits.IDR7 == 0){number_LED=PCA9544A_Read_Byte( 0x76 ,  0x00 );band=6;channel = channel (number_LED);MCP2(( 0x0A +band),256, 80, 256, channel);}
 if (GPIOA_IDRbits.IDR8 == 0){number_LED=PCA9544A_Read_Byte( 0x77 ,  0x00 );band=7;channel = channel (number_LED);MCP2(( 0x0A +band),256, 80, 256, channel);}


 PrintString ("\n-----------------CHANNEL--------------------- : ");
 PrintDecimal(channel) ;
 PrintString ("\n\n");
 PrintString ("\n-----------------BAND--------------------- : ");
 PrintDecimal(band) ;
 PrintString ("\n\n");

 PCA9544A_Write_Byte(( 0x70 +band), 0x00 ,( 0x04 +channel));
 PrintString ("\n-----------------ACK 1.1.1--------------------- : ");

 do {
 Command = VCNL4020_Read_Byte( 0x13 , (0x80) ) ;
 } while (!(Command & ( (0x20)  |  (0x40) )));

 InterruptStatus = VCNL4020_Read_Byte( 0x13 , (0x8e) ) ;

 if (InterruptStatus &  (0x01) )
 {
 VCNL4020_Write_Byte( 0x13 , (0x8e) ,0x01);
 PrintString ("\n-----------------clear Interrupt Status--------------------- : ");
 MCP2(( 0x0A +band),256, 80, 256, channel);
 Delay_100ms();
 PrintString ("\n-----------------ACK 1.1.2--------------------- : ");
 InitVCNL4020_Periodic3(channel,band);
 }
 if (InterruptStatus &  (0x02) )
 {
 VCNL4020_Write_Byte( 0x13 , (0x8e) ,0x02);
 PrintString ("\n-----------------clear Interrupt Status--------------------- : ");
 MCP2(( 0x0A +band),256, 256, 80, channel);
 Delay_100ms();
 PrintString ("\n-----------------ACK 1.1.3--------------------- : ");
 InitVCNL4020_Periodic3(channel,band);
 }

 if (Command &  (0x20) )
 {
 PrintString ("\n");
 PrintString ("RESULT : ");

 PrintDecimal(VCNL4020_Read_Byte( 0x13 , 0x87 )) ;
 PrintString (" ");
 PrintDecimal(VCNL4020_Read_Byte( 0x13 , 0x88 )) ;
 PrintString ("\n\n");
 PrintString ("\n\nStatus : ");
 PrintDecimal(VCNL4020_Read_Byte( 0x13 , (0x8e) )) ;
 PrintString ("\n\n");

 PrintString ("\n-----------------ACK 1.1.2--------------------- : ");
 }
 }
 else
 {
 MCP2(( 0x0A +band),256, 256, 256, channel);

 }



}
 char channel (char channel_)
 {
 compt=0;
 channel_ = (channel_&0xF0);
 channel_ = (channel_>>4);
 while (channel_ != 1)
 {
 channel_ = channel_>>1;
 compt = compt++;
 }
 channel_=compt;
 return channel_;
 }
