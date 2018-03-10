#define PCA9956_ADDR_1 0x0A

#define OutputGain_LED 0x96

#define Outputmode_LED 0xAA

#define MODE_1   0x00
#define MODE_2   0x01

#define LEDOUT0   0x02
#define LEDOUT1   0x03
#define LEDOUT2   0x04
#define LEDOUT3   0x05
#define LEDOUT4   0x06
#define LEDOUT5   0x07

#define PWM0 0x0A
#define PWM1 0x0B
#define PWM2 0x0C
#define PWM3 0x0D
#define PWM4 0x0E
#define PWM5 0x0F
#define PWM6 0x10
#define PWM7 0x11
#define PWM8 0x12
#define PWM9 0x13
#define PWM10 0x14
#define PWM11 0x15
#define PWM12 0x16
#define PWM13 0x17
#define PWM14 0x18
#define PWM15 0x19
#define PWM16 0x1A
#define PWM17 0x1B
#define PWM18 0x1C
#define PWM19 0x1D
#define PWM20 0x1E
#define PWM21 0x1F
#define PWM22 0x20
#define PWM23 0x21


#define IREF0 0x22
#define IREF1 0x23
#define IREF2 0x24


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
       //----------------------------------------------------------------------------------------
      // MCP23017 => PCA9956 CS/ = 0
      //----------------------------------------------------------------------------------------


       InitI2C2();

         if (ModuleAddress<=0x0D)
         {
                PrintString ("condition _1");
                Expander_Write_Byte(EXPAND_ADDR, GPIOB_BANK0,0x00);

                Expander_Write_Byte(EXPAND_ADDR, IODIRA_BANK0, 0x00);       // Set Expander's PORTA to be output
                Expander_Write_Byte(EXPAND_ADDR, GPIOA_BANK0,0x00); // reset
                Expander_Write_Byte(EXPAND_ADDR, GPIOA_BANK0,MCP_OE[ModuleAddress - 10]);
         }
        if (ModuleAddress>=0x0E)
        {
                PrintString ("condition _2");
                Expander_Write_Byte(EXPAND_ADDR, GPIOA_BANK0,0x00);

                Expander_Write_Byte(EXPAND_ADDR, IODIRB_BANK0, 0x00);       // Set Expander's PORTB to be output
                Expander_Write_Byte(EXPAND_ADDR, GPIOB_BANK0,0x00); // reset
                Expander_Write_Byte(EXPAND_ADDR, GPIOB_BANK0,MCP_OE[ModuleAddress - 14]);
        }





PCA9956_Write_Byte(ModuleAddress, IREFALL, OutputGain_LED);

PCA9956_Write_Byte(ModuleAddress, LEDOUT0, Outputmode_LED); //V
PCA9956_Write_Byte(ModuleAddress, LEDOUT1, Outputmode_LED); //V
PCA9956_Write_Byte(ModuleAddress, LEDOUT2, Outputmode_LED); //V
PCA9956_Write_Byte(ModuleAddress, LEDOUT3, Outputmode_LED); //V
PCA9956_Write_Byte(ModuleAddress, LEDOUT4, Outputmode_LED); //V
PCA9956_Write_Byte(ModuleAddress, LEDOUT5, Outputmode_LED); //V

//----------------------------------------------------------------------------------------
// PCA9956 alluler une lED
//----------------------------------------------------------------------------------------

      switch (N_LED)
             {
              case 0:
                     PrintString ("case_0");
                     PCA9956_Write_Byte(ModuleAddress, PWM0, blue);
                     PCA9956_Write_Byte(ModuleAddress, PWM1, green);
                     PCA9956_Write_Byte(ModuleAddress, PWM2, red);
                     PCA9956_Write_Byte(ModuleAddress, PWM3, blue);
                     PCA9956_Write_Byte(ModuleAddress, PWM4, green);
                     PCA9956_Write_Byte(ModuleAddress, PWM5, red);

                     break;
              case 1:
                     PrintString ("case_1");
                     PCA9956_Write_Byte(ModuleAddress, PWM6, blue);
                     PCA9956_Write_Byte(ModuleAddress, PWM7, green);
                     PCA9956_Write_Byte(ModuleAddress, PWM8, red);
                     PCA9956_Write_Byte(ModuleAddress, PWM9, blue);
                     PCA9956_Write_Byte(ModuleAddress, PWM10, green);
                     PCA9956_Write_Byte(ModuleAddress, PWM11, red);

                     break;
              case 2:
                     PrintString ("case_2");
                     PCA9956_Write_Byte(ModuleAddress, PWM12, blue);
                     PCA9956_Write_Byte(ModuleAddress, PWM13, green);
                     PCA9956_Write_Byte(ModuleAddress, PWM14, red);
                     PCA9956_Write_Byte(ModuleAddress, PWM15, blue);
                     PCA9956_Write_Byte(ModuleAddress, PWM16, green);
                     PCA9956_Write_Byte(ModuleAddress, PWM17, red);

                     break;
              case 3:
                     PrintString ("case_3");
                     PCA9956_Write_Byte(ModuleAddress, PWM18, blue);
                     PCA9956_Write_Byte(ModuleAddress, PWM19, green);
                     PCA9956_Write_Byte(ModuleAddress, PWM20, red);
                     PCA9956_Write_Byte(ModuleAddress, PWM21, blue);
                     PCA9956_Write_Byte(ModuleAddress, PWM22, green);
                     PCA9956_Write_Byte(ModuleAddress, PWM23, red);

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
MCP(adress,256, 256, 80, compteur); //(char ModuleAddress,int red, int green, int blue, char N_LED)
Delay_ms (50);
MCP(adress,80, 256, 256, compteur); //(char ModuleAddress,int red, int green, int blue, char N_LED)
Delay_ms (50);
MCP(adress,256, 80, 256, compteur); //(char ModuleAddress,int red, int green, int blue, char N_LED)
Delay_ms (50);

}
}

}

void MCP2(char ModuleAddress,int red, int green, int blue, char N_LED)
{
       //----------------------------------------------------------------------------------------
      // MCP23017 => PCA9956 CS/ = 0
      //----------------------------------------------------------------------------------------


       InitI2C2();


                Expander_Write_Byte(EXPAND_ADDR, IODIRA_BANK0, 0x00);       // Set Expander's PORTA to be output
                Expander_Write_Byte(EXPAND_ADDR, GPIOA_BANK0,0x00); // reset
                Expander_Write_Byte(EXPAND_ADDR, GPIOA_BANK0,MCP_OE[0x55]);
                Expander_Write_Byte(EXPAND_ADDR, IODIRB_BANK0, 0x00);       // Set Expander's PORTB to be output
                Expander_Write_Byte(EXPAND_ADDR, GPIOB_BANK0,0x00); // reset
                Expander_Write_Byte(EXPAND_ADDR, GPIOB_BANK0,MCP_OE[0x55]);






PCA9956_Write_Byte(ModuleAddress, IREFALL, OutputGain_LED);

PCA9956_Write_Byte(ModuleAddress, LEDOUT0, Outputmode_LED); //V
PCA9956_Write_Byte(ModuleAddress, LEDOUT1, Outputmode_LED); //V
PCA9956_Write_Byte(ModuleAddress, LEDOUT2, Outputmode_LED); //V
PCA9956_Write_Byte(ModuleAddress, LEDOUT3, Outputmode_LED); //V
PCA9956_Write_Byte(ModuleAddress, LEDOUT4, Outputmode_LED); //V
PCA9956_Write_Byte(ModuleAddress, LEDOUT5, Outputmode_LED); //V

//----------------------------------------------------------------------------------------
// PCA9956 alluler une lED
//----------------------------------------------------------------------------------------

      switch (N_LED)
             {
              case 0:
                     PrintString ("case_0");
                     PCA9956_Write_Byte(ModuleAddress, PWM0, blue);
                     PCA9956_Write_Byte(ModuleAddress, PWM1, green);
                     PCA9956_Write_Byte(ModuleAddress, PWM2, red);
                     PCA9956_Write_Byte(ModuleAddress, PWM3, blue);
                     PCA9956_Write_Byte(ModuleAddress, PWM4, green);
                     PCA9956_Write_Byte(ModuleAddress, PWM5, red);

                     break;
              case 1:
                     PrintString ("case_1");
                     PCA9956_Write_Byte(ModuleAddress, PWM6, blue);
                     PCA9956_Write_Byte(ModuleAddress, PWM7, green);
                     PCA9956_Write_Byte(ModuleAddress, PWM8, red);
                     PCA9956_Write_Byte(ModuleAddress, PWM9, blue);
                     PCA9956_Write_Byte(ModuleAddress, PWM10, green);
                     PCA9956_Write_Byte(ModuleAddress, PWM11, red);

                     break;
              case 2:
                     PrintString ("case_2");
                     PCA9956_Write_Byte(ModuleAddress, PWM12, blue);
                     PCA9956_Write_Byte(ModuleAddress, PWM13, green);
                     PCA9956_Write_Byte(ModuleAddress, PWM14, red);
                     PCA9956_Write_Byte(ModuleAddress, PWM15, blue);
                     PCA9956_Write_Byte(ModuleAddress, PWM16, green);
                     PCA9956_Write_Byte(ModuleAddress, PWM17, red);

                     break;
              case 3:
                     PrintString ("case_3");
                     PCA9956_Write_Byte(ModuleAddress, PWM18, blue);
                     PCA9956_Write_Byte(ModuleAddress, PWM19, green);
                     PCA9956_Write_Byte(ModuleAddress, PWM20, red);
                     PCA9956_Write_Byte(ModuleAddress, PWM21, blue);
                     PCA9956_Write_Byte(ModuleAddress, PWM22, green);
                     PCA9956_Write_Byte(ModuleAddress, PWM23, red);

                     break;
              default:
                      printString ("Error 1.1");
                      break;
              }



}