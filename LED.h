#define EXPAND_ADDR 0x20
#define PCA9956_ADDR_1 0x0A
#define OutputGain_LED 0x01



char MCP_OE[5] = {0xFD, 0xF7,0xDF,0x7F};
char N_LED =0;
int compteur = 1;
int adress = 0x14;


void MCP(char ModuleAddress,int red, int green, int blue, char N_LED)
{
       //----------------------------------------------------------------------------------------
      // MCP23017 => PCA9956 CS/ = 0
      //----------------------------------------------------------------------------------------




         if (ModuleAddress<=0x0D)
                PrintString ("condition _1");
         {      EXPAND_Reset();
                Expander_Write_Byte(EXPAND_ADDR, IODIRA_BANK0, 0x00);       // Set Expander's PORTB to be output
                Expander_Write_Byte(EXPAND_ADDR, GPIOA_BANK0,MCP_OE[ModuleAddress - 10]);
         }
        if (ModuleAddress>=0x0E)
        {
                PrintString ("condition _2");
                EXPAND_Reset();
                Expander_Write_Byte(EXPAND_ADDR, 0x01, 0x00);       // Set Expander's PORTB to be output
                Expander_Write_Byte(EXPAND_ADDR, 0x13,MCP_OE[ModuleAddress - 14]); // Set Expander's PORTA to be 0xFD



        }


PCA9956_Write_Byte(ModuleAddress, IREFALL, OutputGain_LED);

//----------------------------------------------------------------------------------------
// PCA9956 alluler une lED
//----------------------------------------------------------------------------------------

      switch (N_LED)
             {
              case 1:
                     PrintString ("case_1");
                     PCA9956_Write_Byte(ModuleAddress, PWM0, blue);
                     PCA9956_Write_Byte(ModuleAddress, PWM1, green);
                     PCA9956_Write_Byte(ModuleAddress, PWM2, red);
                     PCA9956_Write_Byte(ModuleAddress, LEDOUT0, 0x3F); //V
                     break;
              case 2:
                     PrintString ("case_2");
                     PCA9956_Write_Byte(ModuleAddress, PWM3, blue);
                     PCA9956_Write_Byte(ModuleAddress, PWM4, green);
                     PCA9956_Write_Byte(ModuleAddress, PWM5, red);
                     PCA9956_Write_Byte(ModuleAddress, LEDOUT0, 0xC0);  //V
                     PCA9956_Write_Byte(ModuleAddress, LEDOUT1, 0xF0);
                     break;
              case 3:
                     PrintString ("case_3");
                     PCA9956_Write_Byte(ModuleAddress, PWM6, blue);
                     PCA9956_Write_Byte(ModuleAddress, PWM7, green);
                     PCA9956_Write_Byte(ModuleAddress, PWM8, red);
                     PCA9956_Write_Byte(ModuleAddress, LEDOUT1, 0x0F);
                     PCA9956_Write_Byte(ModuleAddress, LEDOUT2, 0xC0); //V
                     break;
              case 4:
                     PrintString ("case_4");
                     PCA9956_Write_Byte(ModuleAddress, PWM9, blue);
                     PCA9956_Write_Byte(ModuleAddress, PWM10, green);
                     PCA9956_Write_Byte(ModuleAddress, PWM11, red);
                     PCA9956_Write_Byte(ModuleAddress, LEDOUT2, 0x3F);  //V
                     break;
              case 5:
                     PrintString ("case_5");
                     PCA9956_Write_Byte(ModuleAddress, PWM12, blue);
                     PCA9956_Write_Byte(ModuleAddress, PWM13, green);
                     PCA9956_Write_Byte(ModuleAddress, PWM14, red);
                     PCA9956_Write_Byte(ModuleAddress, LEDOUT3, 0xFC); //V
                     break;
              case 6:
                     PrintString ("case_6");
                     PCA9956_Write_Byte(ModuleAddress, PWM15, blue);
                     PCA9956_Write_Byte(ModuleAddress, PWM16, green);
                     PCA9956_Write_Byte(ModuleAddress, PWM17, red);
                     PCA9956_Write_Byte(ModuleAddress, LEDOUT3, 0x03);
                     PCA9956_Write_Byte(ModuleAddress, LEDOUT4, 0xF0);
                     break;
              case 7:
                     PrintString ("case_7");
                     PCA9956_Write_Byte(ModuleAddress, PWM18, blue);
                     PCA9956_Write_Byte(ModuleAddress, PWM19, green);
                     PCA9956_Write_Byte(ModuleAddress, PWM20, red);
                     PCA9956_Write_Byte(ModuleAddress, LEDOUT4, 0x0F);
                     PCA9956_Write_Byte(ModuleAddress, LEDOUT5, 0xC0);
                     break;
              case 8:
                     PrintString ("case_8");
                     PCA9956_Write_Byte(ModuleAddress, PWM21, blue);
                     PCA9956_Write_Byte(ModuleAddress, PWM22, green);
                     PCA9956_Write_Byte(ModuleAddress, PWM23, red);
                     PCA9956_Write_Byte(ModuleAddress, LEDOUT5, 0x3F);
                     break;
              default:
                      printString ("Error 1.1");
                      break;
              }

