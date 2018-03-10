/*
Programme 3.1.2
Nom du projet: Detection Optique
Oscillateur : 8Mhz


*/

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
void  Expander_Read_Byte(char ModuleAddress, char RegAddress);

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

# include "GLA.h"
# include "can.h"
# include "EXPAND2click.h"
# include "PCA9956.h"
# include "PCA9544A.h"
# include "VCNL4020.h"
# include "DS28CM.h"
# include "eeprom.h"
# include <stdio.h>

void main()
{

UART1_Init (9600);

PrintString ("Programme 3.1.2--Detection Optique--Oscillateur : 8Mhz ");

setupGPIO();

Read_serial_number();

TEST_EEPROM();

MCP(0x0A,256, 256, 256, 0); //(char ModuleAddress,int red, int green, int blue, char N_LED)

TEST_CAN();

   for (bands = 0 ; bands <= 7 ; bands++)
  {
       for (compteur = 0 ; compteur <= 3 ; compteur++)
       {
        InitVCNL4020_Periodic3(compteur,bands);// sensor 0 to 3 & band 0 to 7
       }
  }
  
while (1)
      {
       interrupt ();
      }


}


/**************************************************************************************************
*Fonction interruption
**************************************************************************************************/


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
      close_PCA9544 (); // stop all activities
      
      if (GPIOA_IDRbits.IDR1 == 0){channel=PCA9544A_Read_Byte(PCA9544A_Address_1, PCA9544A_register);band=0;}
      if (GPIOA_IDRbits.IDR2 == 0){channel=PCA9544A_Read_Byte(PCA9544A_Address_2, PCA9544A_register);band=1;}
      if (GPIOA_IDRbits.IDR3 == 0){channel=PCA9544A_Read_Byte(PCA9544A_Address_3, PCA9544A_register);band=2;}
      if (GPIOA_IDRbits.IDR4 == 0){channel=PCA9544A_Read_Byte(PCA9544A_Address_4, PCA9544A_register);band=3;}
      if (GPIOA_IDRbits.IDR5 == 0){channel=PCA9544A_Read_Byte(PCA9544A_Address_5, PCA9544A_register);band=4;}
      if (GPIOA_IDRbits.IDR6 == 0){channel=PCA9544A_Read_Byte(PCA9544A_Address_6, PCA9544A_register);band=5;}
      if (GPIOA_IDRbits.IDR7 == 0){channel=PCA9544A_Read_Byte(PCA9544A_Address_7, PCA9544A_register);band=6;}
      if (GPIOA_IDRbits.IDR8 == 0){channel=PCA9544A_Read_Byte(PCA9544A_Address_8, PCA9544A_register);band=7;}
      
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
      
      PCA9544A_Write_Byte((PCA9544A_Address_1+band),PCA9544A_register,(PCA9544A_channel_0+channel));
       PrintString ("\n-----------------ACK 1.1.1--------------------- : ");

          do  {
               Command = VCNL4020_Read_Byte(VCNL4020_Address,REGISTER_COMMAND) ;// read command register
               } while (!(Command & (COMMAND_MASK_PROX_DATA_READY | COMMAND_MASK_AMBI_DATA_READY))); // data ready ?
                 // read interrupt status register
                  InterruptStatus = VCNL4020_Read_Byte(VCNL4020_Address,REGISTER_INTERRUPT_STATUS) ;
                 // check interrupt status for High Threshold
                    if (InterruptStatus & INTERRUPT_STATUS_THRES_HI) 
                       {
                        VCNL4020_Write_Byte(VCNL4020_Address,REGISTER_INTERRUPT_STATUS,0x01); // clear Interrupt Status
                        PrintString ("\n-----------------clear Interrupt Status--------------------- : ");
                        MCP((PCA9956_ADDR_1+band),256, 80, 256, channel); //(char ModuleAddress,int red, int green, int blue, char N_LED)
                        Delay_100ms();
                        PrintString ("\n-----------------ACK 1.1.2--------------------- : ");
                        InitVCNL4020_Periodic2(channel,band);
                        }
                          if (InterruptStatus & INTERRUPT_STATUS_THRES_LO)
                       {
                        VCNL4020_Write_Byte(VCNL4020_Address,REGISTER_INTERRUPT_STATUS,0x02); // clear Interrupt Status
                        PrintString ("\n-----------------clear Interrupt Status--------------------- : ");
                        MCP((PCA9956_ADDR_1+band),256, 256, 80, channel); //(char ModuleAddress,int red, int green, int blue, char N_LED)
                        Delay_100ms();
                        PrintString ("\n-----------------ACK 1.1.3--------------------- : ");
                        InitVCNL4020_Periodic2(channel,band);
                        }
 // prox value ready for using
                     if (Command & COMMAND_MASK_PROX_DATA_READY)
                        {
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

                        PrintString ("\n-----------------ACK 1.1.2--------------------- : ");
                        }
     }
     else
     {
        MCP((PCA9956_ADDR_1+band),256, 256, 256, channel); //(char ModuleAddress,int red, int green, int blue, char N_LED)

     }



}


/**************************************************************************************************
*Fonction interruption test 2
**************************************************************************************************/


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
      close_PCA9544 (); // stop all activities

      if (GPIOA_IDRbits.IDR1 == 0){number_LED=PCA9544A_Read_Byte(PCA9544A_Address_1, PCA9544A_register);band=0;channel = channel (number_LED);MCP2((PCA9956_ADDR_1+band),256, 80, 256, channel);}
      if (GPIOA_IDRbits.IDR2 == 0){number_LED=PCA9544A_Read_Byte(PCA9544A_Address_2, PCA9544A_register);band=1;channel = channel (number_LED);MCP2((PCA9956_ADDR_1+band),256, 80, 256, channel);}
      if (GPIOA_IDRbits.IDR3 == 0){number_LED=PCA9544A_Read_Byte(PCA9544A_Address_3, PCA9544A_register);band=2;channel = channel (number_LED);MCP2((PCA9956_ADDR_1+band),256, 80, 256, channel);}
      if (GPIOA_IDRbits.IDR4 == 0){number_LED=PCA9544A_Read_Byte(PCA9544A_Address_4, PCA9544A_register);band=3;channel = channel (number_LED);MCP2((PCA9956_ADDR_1+band),256, 80, 256, channel);}
      if (GPIOA_IDRbits.IDR5 == 0){number_LED=PCA9544A_Read_Byte(PCA9544A_Address_5, PCA9544A_register);band=4;channel = channel (number_LED);MCP2((PCA9956_ADDR_1+band),256, 80, 256, channel);}
      if (GPIOA_IDRbits.IDR6 == 0){number_LED=PCA9544A_Read_Byte(PCA9544A_Address_6, PCA9544A_register);band=5;channel = channel (number_LED);MCP2((PCA9956_ADDR_1+band),256, 80, 256, channel);}
      if (GPIOA_IDRbits.IDR7 == 0){number_LED=PCA9544A_Read_Byte(PCA9544A_Address_7, PCA9544A_register);band=6;channel = channel (number_LED);MCP2((PCA9956_ADDR_1+band),256, 80, 256, channel);}
      if (GPIOA_IDRbits.IDR8 == 0){number_LED=PCA9544A_Read_Byte(PCA9544A_Address_8, PCA9544A_register);band=7;channel = channel (number_LED);MCP2((PCA9956_ADDR_1+band),256, 80, 256, channel);}


      PrintString ("\n-----------------CHANNEL--------------------- : ");
      PrintDecimal(channel) ;
      PrintString ("\n\n");
      PrintString ("\n-----------------BAND--------------------- : ");
      PrintDecimal(band) ;
      PrintString ("\n\n");

      PCA9544A_Write_Byte((PCA9544A_Address_1+band),PCA9544A_register,(PCA9544A_channel_0+channel));
       PrintString ("\n-----------------ACK 1.1.1--------------------- : ");

          do  {
               Command = VCNL4020_Read_Byte(VCNL4020_Address,REGISTER_COMMAND) ;// read command register
               } while (!(Command & (COMMAND_MASK_PROX_DATA_READY | COMMAND_MASK_AMBI_DATA_READY))); // data ready ?
                 // read interrupt status register
                  InterruptStatus = VCNL4020_Read_Byte(VCNL4020_Address,REGISTER_INTERRUPT_STATUS) ;
                 // check interrupt status for High Threshold
                    if (InterruptStatus & INTERRUPT_STATUS_THRES_HI)
                       {
                        VCNL4020_Write_Byte(VCNL4020_Address,REGISTER_INTERRUPT_STATUS,0x01); // clear Interrupt Status
                        PrintString ("\n-----------------clear Interrupt Status--------------------- : ");
                        MCP2((PCA9956_ADDR_1+band),256, 80, 256, channel); //(char ModuleAddress,int red, int green, int blue, char N_LED)
                        Delay_100ms();
                        PrintString ("\n-----------------ACK 1.1.2--------------------- : ");
                        InitVCNL4020_Periodic3(channel,band);
                        }
                          if (InterruptStatus & INTERRUPT_STATUS_THRES_LO)
                       {
                        VCNL4020_Write_Byte(VCNL4020_Address,REGISTER_INTERRUPT_STATUS,0x02); // clear Interrupt Status
                        PrintString ("\n-----------------clear Interrupt Status--------------------- : ");
                        MCP2((PCA9956_ADDR_1+band),256, 256, 80, channel); //(char ModuleAddress,int red, int green, int blue, char N_LED)
                        Delay_100ms();
                        PrintString ("\n-----------------ACK 1.1.3--------------------- : ");
                        InitVCNL4020_Periodic3(channel,band);
                        }
 // prox value ready for using
                     if (Command & COMMAND_MASK_PROX_DATA_READY)
                        {
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

                        PrintString ("\n-----------------ACK 1.1.2--------------------- : ");
                        }
     }
     else
     {
        MCP2((PCA9956_ADDR_1+band),256, 256, 256, channel); //(char ModuleAddress,int red, int green, int blue, char N_LED)

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