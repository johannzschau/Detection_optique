#define VCNL4020_Address 0x13

#define registerADDR_Command 0x80
#define registerADDR_Product_ID 0x81
#define registerADDR_Proximity 0x82
#define registerADDR_IR_LED 0x83
#define registerADDR_RESULT_HIGH 0x87
#define registerADDR_RESULT_LOW 0x88
#define registerADDR_INTERRUPT 0x89

#define registerADDR_LOW_THERSHOLD_H 0x8A
#define registerADDR_LOW_THERSHOLD_L 0x8B

#define registerADDR_HIGH_THERSHOLD_H 0x8C
#define registerADDR_HIGH_THERSHOLD_L 0x8D

#define registerADDR_INTERRUPT_STATUS 0x8E

// registers
#define REGISTER_COMMAND (0x80)
#define REGISTER_ID (0x81)
#define REGISTER_PROX_RATE (0x82)
#define REGISTER_PROX_CURRENT (0x83)
#define REGISTER_AMBI_PARAMETER (0x84)
#define REGISTER_AMBI_VALUE (0x85)
#define REGISTER_PROX_VALUE (0x87)
#define REGISTER_INTERRUPT_CONTROL (0x89)
#define REGISTER_INTERRUPT_LOW_THRES (0x8a)
#define REGISTER_INTERRUPT_HIGH_THRES (0x8c)
#define REGISTER_INTERRUPT_STATUS (0x8e)
#define REGISTER_PROX_TIMING (0xf9)
#define REGISTER_AMBI_IR_LIGHT_LEVEL (0x90) // This register is not intended to be use by customer
// Bits in Command register (0x80)
#define COMMAND_ALL_DISABLE (0x00)
#define COMMAND_SELFTIMED_MODE_ENABLE (0x01)
#define COMMAND_PROX_ENABLE (0x02)
#define COMMAND_AMBI_ENABLE (0x04)
#define COMMAND_PROX_ON_DEMAND (0x08)
#define COMMAND_AMBI_ON_DEMAND (0x10)
#define COMMAND_MASK_PROX_DATA_READY (0x20)
#define COMMAND_MASK_AMBI_DATA_READY (0x40)
#define COMMAND_MASK_LOCK (0x80)
// Bits in Product ID Revision Register (0x81)
#define PRODUCT_MASK_REVISION_ID (0x0f)
#define PRODUCT_MASK_PRODUCT_ID (0xf0)
// Bits in Prox Measurement Rate register (0x82)
#define PROX_MEASUREMENT_RATE_2 (0x00) // DEFAULT
#define PROX_MEASUREMENT_RATE_4 (0x01)
#define PROX_MEASUREMENT_RATE_8 (0x02)
#define PROX_MEASUREMENT_RATE_16 (0x03)
#define PROX_MEASUREMENT_RATE_31 (0x04)
#define PROX_MEASUREMENT_RATE_62 (0x05)
#define PROX_MEASUREMENT_RATE_125 (0x06)
#define PROX_MEASUREMENT_RATE_250 (0x07)
#define PROX_MASK_MEASUREMENT_RATE (0x07)
// Bits in Proximity LED current setting (0x83)
#define PROX_MASK_LED_CURRENT (0x3f) // DEFAULT = 2
#define PROX_MASK_FUSE_PROG_ID (0xc0)
// Bits in Ambient Light Parameter register (0x84)
#define AMBI_PARA_AVERAGE_1 (0x00)
#define AMBI_PARA_AVERAGE_2 (0x01)
#define AMBI_PARA_AVERAGE_4 (0x02)
#define AMBI_PARA_AVERAGE_8 (0x03)
#define AMBI_PARA_AVERAGE_16 (0x04)
#define AMBI_PARA_AVERAGE_32 (0x05) // DEFAULT
#define AMBI_PARA_AVERAGE_64 (0x06)
#define AMBI_PARA_AVERAGE_128 (0x07)
#define AMBI_MASK_PARA_AVERAGE (0x07)
#define AMBI_PARA_AUTO_OFFSET_ENABLE (0x08) // DEFAULT enable
#define AMBI_MASK_PARA_AUTO_OFFSET (0x08)
#define AMBI_PARA_MEAS_RATE_1 (0x00)
#define AMBI_PARA_MEAS_RATE_2 (0x10) // DEFAULT
#define AMBI_PARA_MEAS_RATE_3 (0x20)
#define AMBI_PARA_MEAS_RATE_4 (0x30)
#define AMBI_PARA_MEAS_RATE_5 (0x40)
#define AMBI_PARA_MEAS_RATE_6 (0x50)
#define AMBI_PARA_MEAS_RATE_8 (0x60)
#define AMBI_PARA_MEAS_RATE_10 (0x70)
#define AMBI_MASK_PARA_MEAS_RATE (0x70)
#define AMBI_PARA_CONT_CONV_ENABLE (0x80)
#define AMBI_MASK_PARA_CONT_CONV (0x80) // DEFAULT disable
// Bits in Interrupt Control Register (x89)
#define INTERRUPT_THRES_SEL_PROX (0x00)
#define INTERRUPT_THRES_SEL_ALS (0x01)
#define INTERRUPT_THRES_ENABLE (0x02)
#define INTERRUPT_ALS_READY_ENABLE (0x04)
#define INTERRUPT_PROX_READY_ENABLE (0x08)
#define INTERRUPT_COUNT_EXCEED_1 (0x00) // DEFAULT
#define INTERRUPT_COUNT_EXCEED_2 (0x20)
#define INTERRUPT_COUNT_EXCEED_4 (0x40)
#define INTERRUPT_COUNT_EXCEED_8 (0x60)
#define INTERRUPT_COUNT_EXCEED_16 (0x80)
#define INTERRUPT_COUNT_EXCEED_32 (0xa0)
#define INTERRUPT_COUNT_EXCEED_64 (0xc0)
#define INTERRUPT_COUNT_EXCEED_128 (0xe0)
#define INTERRUPT_MASK_COUNT_EXCEED (0xe0)
// Bits in Interrupt Status Register (x8e)
#define INTERRUPT_STATUS_THRES_HI (0x01)
#define INTERRUPT_STATUS_THRES_LO (0x02)
#define INTERRUPT_STATUS_ALS_READY (0x04)
#define INTERRUPT_STATUS_PROX_READY (0x08)
#define INTERRUPT_MASK_STATUS_THRES_HI (0x01)
#define INTERRUPT_MASK_THRES_LO (0x02)
#define INTERRUPT_MASK_ALS_READY (0x04)
#define INTERRUPT_MASK_PROX_READY (0x08)

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

void InitVCNL4020_Periodic2(char N_Sensor, char band)// sensor 0 to 3 & band 0 to 7

{     //  Init MCU function


 int i = 1;

 char adress_PCA9544 = (PCA9544A_Address_1 + band);
 char PCA9544A_channel = (PCA9544A_channel_0+N_Sensor);

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


//PrintString ("I2C_INIT\n");
InitI2C1();
PrintString ("adress : ");
PrintDecimal(adress_PCA9544);
printString ("PCA9544A_channel : ");
PrintString ("\n ");
PrintDecimal(PCA9544A_channel);
PrintString ("\n ");
close_PCA9544 (); // stop all activities

PCA9544A_Write_Byte(adress_PCA9544,PCA9544A_register,PCA9544A_channel);// Opening the i2C port
 // stop all activities (necessary for changing proximity rate, see datasheet)
 VCNL4020_Write_Byte(VCNL4020_Address,REGISTER_COMMAND,COMMAND_ALL_DISABLE);
 // set proximity rate to 31/s
 VCNL4020_Write_Byte(VCNL4020_Address,REGISTER_PROX_RATE,PROX_MEASUREMENT_RATE_31);
 // enable prox in selftimed mode
 VCNL4020_Write_Byte(VCNL4020_Address,REGISTER_COMMAND,COMMAND_PROX_ENABLE | COMMAND_SELFTIMED_MODE_ENABLE);
 // set interrupt control for threshold
 VCNL4020_Write_Byte(VCNL4020_Address,registerADDR_INTERRUPT,INTERRUPT_THRES_SEL_PROX |
 INTERRUPT_THRES_ENABLE | INTERRUPT_COUNT_EXCEED_1);

// measure average of prox value
 SummeProxiValue_H = 0;
 SummeProxiValue_L = 0;
 for (i=0; i<30; i++) {
 do { // wait on prox data ready bit
Command = VCNL4020_Read_Byte(VCNL4020_Address,REGISTER_COMMAND) ;// read command register

 } while (!(Command & COMMAND_MASK_PROX_DATA_READY)); // prox data ready ?

 ProxiValue_H = (VCNL4020_Read_Byte(VCNL4020_Address,registerADDR_RESULT_HIGH));// read prox value
 SummeProxiValue_H += ProxiValue_H; // Summary of all measured prox values

 ProxiValue_L = (VCNL4020_Read_Byte(VCNL4020_Address,registerADDR_RESULT_LOW));// read prox value
 SummeProxiValue_L += ProxiValue_L; // Summary of all measured prox values
 }
 AverageProxiValue_H = SummeProxiValue_H/30; // calculate average
 AverageProxiValue_L = SummeProxiValue_L/30; // calculate average

 VCNL4020_Write_Byte(VCNL4020_Address,registerADDR_HIGH_THERSHOLD_H,AverageProxiValue_H+1);
 VCNL4020_Write_Byte(VCNL4020_Address,registerADDR_HIGH_THERSHOLD_L,(AverageProxiValue_L + 10));

 VCNL4020_Write_Byte(VCNL4020_Address,registerADDR_LOW_THERSHOLD_H,AverageProxiValue_H-1);
 VCNL4020_Write_Byte(VCNL4020_Address,registerADDR_LOW_THERSHOLD_L,(AverageProxiValue_L - 10));






      PrintString ("\n-----------------HIGH_THRES--------------------- : ");
      PrintDecimal(AverageProxiValue_H ) ;
      PrintString ("\n\n");
       PrintString ("\n-----------------LOW_THRES--------------------- : ");
      PrintDecimal(AverageProxiValue_L ) ;
      PrintString ("\n\n");

// wait on data ready bit
 do {
Command = VCNL4020_Read_Byte(VCNL4020_Address,REGISTER_COMMAND) ;// read command register
 } while (!(Command & (COMMAND_MASK_PROX_DATA_READY | COMMAND_MASK_AMBI_DATA_READY))); // data ready ?

 // read interrupt status register
 InterruptStatus = VCNL4020_Read_Byte(VCNL4020_Address,REGISTER_INTERRUPT_STATUS) ;
 // check interrupt status for High Threshold
 if (InterruptStatus & INTERRUPT_STATUS_THRES_HI) {

  VCNL4020_Write_Byte(VCNL4020_Address,REGISTER_INTERRUPT_STATUS,0x01); // clear Interrupt Status
  //Once an interrupt is generated the corresponding status bit goes to 1 and stays there unless it is cleared by writing a 1 in the corresponding
  //bit. The int pad will be pulled down while at least one of the status bit is 1.
  PrintString ("\nclear Interrupt Status\n");
 }
 // prox value ready for using
 if (Command & COMMAND_MASK_PROX_DATA_READY) {
 PrintString ("\n");
 PrintString ("RESULT : ");
 // print prox value and interrupt status on screen
PrintDecimal(VCNL4020_Read_Byte(VCNL4020_Address,registerADDR_RESULT_HIGH)) ;
 PrintString (" ");
PrintDecimal(VCNL4020_Read_Byte(VCNL4020_Address,registerADDR_RESULT_LOW)) ;
PrintString ("\n\n");
PrintString ("\n\nStatus : ");
PrintDecimal(VCNL4020_Read_Byte(VCNL4020_Address,REGISTER_INTERRUPT_STATUS)) ;
PrintString ("\n\n");
MCP((0x0A+band),80, 256, 256, N_Sensor); //(char ModuleAddress,int red, int green, int blue, char N_LED)
      PrintString ("\n-----------------CHANNEL_1--------------------- : ");
      PrintDecimal(N_Sensor) ;
      PrintString ("\n\n");
       PrintString ("\n-----------------BAND_1--------------------- : ");
      PrintDecimal(band) ;
      PrintString ("\n\n");

  }
}

void InitVCNL4020()// 1 to 32

{     //  Init MCU function
InitI2C1();
close_PCA9544 ();
PCA9544A_Write_Byte(0X70,0x00,0x04); // test
PrintString ("PCA9544A_ACK");
VCNL4020_Write_Byte(VCNL4020_Address,registerADDR_Proximity,0x01);
PrintString ("VCNL4020_ACK");
VCNL4020_Write_Byte(VCNL4020_Address,registerADDR_IR_LED,0x14);// 140 mA for IR_LED
PrintString ("VCNL4020_ACK_2");
VCNL4020_Write_Byte(VCNL4020_Address,registerADDR_Command,0x08);// Start a single measurement for proximity
PrintString ("VCNL4020_ACK_2");
Delay_100ms();
}

void InitVCNL4020_Periodic3(char N_Sensor, char band)// sensor 0 to 3 & band 0 to 7

{     //  Init MCU function


 int i = 1;

 char adress_PCA9544 = (PCA9544A_Address_1 + band);
 char PCA9544A_channel = (PCA9544A_channel_0+N_Sensor);

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


//PrintString ("I2C_INIT\n");
InitI2C1();
PrintString ("adress : ");
PrintDecimal(adress_PCA9544);
printString ("PCA9544A_channel : ");
PrintString ("\n ");
PrintDecimal(PCA9544A_channel);
PrintString ("\n ");
close_PCA9544 (); // stop all activities

PCA9544A_Write_Byte(adress_PCA9544,PCA9544A_register,PCA9544A_channel);// Opening the i2C port
 // stop all activities (necessary for changing proximity rate, see datasheet)
 VCNL4020_Write_Byte(VCNL4020_Address,REGISTER_COMMAND,COMMAND_ALL_DISABLE);
 // set proximity rate to 31/s
 VCNL4020_Write_Byte(VCNL4020_Address,REGISTER_PROX_RATE,PROX_MEASUREMENT_RATE_31);
 // enable prox in selftimed mode
 VCNL4020_Write_Byte(VCNL4020_Address,REGISTER_COMMAND,COMMAND_PROX_ENABLE | COMMAND_SELFTIMED_MODE_ENABLE);
 // set interrupt control for threshold
 VCNL4020_Write_Byte(VCNL4020_Address,registerADDR_INTERRUPT,INTERRUPT_THRES_SEL_PROX |
 INTERRUPT_THRES_ENABLE | INTERRUPT_COUNT_EXCEED_1);

// measure average of prox value
 SummeProxiValue_H = 0;
 SummeProxiValue_L = 0;
 for (i=0; i<10; i++) {
 do { // wait on prox data ready bit
Command = VCNL4020_Read_Byte(VCNL4020_Address,REGISTER_COMMAND) ;// read command register

 } while (!(Command & COMMAND_MASK_PROX_DATA_READY)); // prox data ready ?

 ProxiValue_H = (VCNL4020_Read_Byte(VCNL4020_Address,registerADDR_RESULT_HIGH));// read prox value
 SummeProxiValue_H += ProxiValue_H; // Summary of all measured prox values

 ProxiValue_L = (VCNL4020_Read_Byte(VCNL4020_Address,registerADDR_RESULT_LOW));// read prox value
 SummeProxiValue_L += ProxiValue_L; // Summary of all measured prox values
 }
 AverageProxiValue_H = SummeProxiValue_H/10; // calculate average
 AverageProxiValue_L = SummeProxiValue_L/10; // calculate average

 VCNL4020_Write_Byte(VCNL4020_Address,registerADDR_HIGH_THERSHOLD_H,AverageProxiValue_H+1);
 VCNL4020_Write_Byte(VCNL4020_Address,registerADDR_HIGH_THERSHOLD_L,(AverageProxiValue_L ));

 VCNL4020_Write_Byte(VCNL4020_Address,registerADDR_LOW_THERSHOLD_H,AverageProxiValue_H-1);
 VCNL4020_Write_Byte(VCNL4020_Address,registerADDR_LOW_THERSHOLD_L,(AverageProxiValue_L));






      PrintString ("\n-----------------HIGH_THRES--------------------- : ");
      PrintDecimal(AverageProxiValue_H ) ;
      PrintString ("\n\n");
       PrintString ("\n-----------------LOW_THRES--------------------- : ");
      PrintDecimal(AverageProxiValue_L ) ;
      PrintString ("\n\n");

// wait on data ready bit
 do {
Command = VCNL4020_Read_Byte(VCNL4020_Address,REGISTER_COMMAND) ;// read command register
 } while (!(Command & (COMMAND_MASK_PROX_DATA_READY | COMMAND_MASK_AMBI_DATA_READY))); // data ready ?

 // read interrupt status register
 InterruptStatus = VCNL4020_Read_Byte(VCNL4020_Address,REGISTER_INTERRUPT_STATUS) ;
 // check interrupt status for High Threshold
 if (InterruptStatus & INTERRUPT_STATUS_THRES_HI) {

  VCNL4020_Write_Byte(VCNL4020_Address,REGISTER_INTERRUPT_STATUS,0x01); // clear Interrupt Status
  //Once an interrupt is generated the corresponding status bit goes to 1 and stays there unless it is cleared by writing a 1 in the corresponding
  //bit. The int pad will be pulled down while at least one of the status bit is 1.
  PrintString ("\nclear Interrupt Status\n");
 }
 // prox value ready for using
 if (Command & COMMAND_MASK_PROX_DATA_READY) {
 PrintString ("\n");
 PrintString ("RESULT : ");
 // print prox value and interrupt status on screen
PrintDecimal(VCNL4020_Read_Byte(VCNL4020_Address,registerADDR_RESULT_HIGH)) ;
 PrintString (" ");
PrintDecimal(VCNL4020_Read_Byte(VCNL4020_Address,registerADDR_RESULT_LOW)) ;
PrintString ("\n\n");
PrintString ("\n\nStatus : ");
PrintDecimal(VCNL4020_Read_Byte(VCNL4020_Address,REGISTER_INTERRUPT_STATUS)) ;
PrintString ("\n\n");
MCP((0x0A+band),80, 256, 256, N_Sensor); //(char ModuleAddress,int red, int green, int blue, char N_LED)
      PrintString ("\n-----------------CHANNEL_1--------------------- : ");
      PrintDecimal(N_Sensor) ;
      PrintString ("\n\n");
       PrintString ("\n-----------------BAND_1--------------------- : ");
      PrintDecimal(band) ;
      PrintString ("\n\n");

  }
}