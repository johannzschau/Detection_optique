/*
 * Project name:
     Expand2 click (Demonstration of mikroBUS Expand2 click board)
 * Copyright:
     (c) Mikroelektronika, 2015.
 * Revision History:
     20150408:
       - initial release (DM);
 * Description:
     This code writes data to expander's PortB and reads it from expander's PortA.
     Result is shown on EasyTFT on development board.
 * Test configuration:
     MCU:             STM32F107VC
                      http://www.st.com/st-web-ui/static/active/en/resource/technical/document/reference_manual/CD00171190.pdf
     Dev. Board:      EasyMx PRO v7 for STM32
                      http://www.mikroe.com/eng/products/view/852/easymx-pro-v7-for-stm32/
     Oscillator:      HS-PLL 72.0000 MHz
                      http://www.mikroe.com/store/components/displays/
     ext. modules:    Expand2 click board click
                      http://www.mikroe.com/click/expand2/
     SW:              mikroC PRO for ARM
                      http://www.mikroe.com/mikroc/arm/
 * NOTES:
     - Place Expand2 click board at the mikroBUS socket 1 on the EasyMx Pro v7 board.
     - Put EasyTFT in its socket, turn on backlight using the SW11.3
 */

#include "EXPAND2click.h"
#include "resources.h"

#define EXPAND_ADDR 0x05

sbit EXPAND_RST at GPIOC_ODR.B2;

unsigned char i = 0, old_res = 0, res;

void DrawScr(){
  TFT_Fill_Screen(CL_WHITE);
  TFT_Set_Pen(CL_Black, 1);
  TFT_Line(20, 220, 300, 220);
  TFT_LIne(20,  46, 300,  46);
  TFT_Set_Font(&HandelGothic_BT21x22_Regular, CL_RED, FO_HORIZONTAL);
  TFT_Write_Text("EXPAND click  TEST", 75, 14);
  TFT_Set_Font(&Verdana12x13_Regular, CL_BLACK, FO_HORIZONTAL);
  TFT_Write_Text("EasyMX PRO v7 for STM32", 19, 223);
  TFT_Set_Font(&Verdana12x13_Regular, CL_RED, FO_HORIZONTAL);
  TFT_Write_Text("www.mikroe.com", 200, 223);
  TFT_Set_Font(&TFT_defaultFont, CL_BLACK, FO_HORIZONTAL);
}

void DrawLed(short No, char fill){
char xcoo, ycoo;

  if (fill)
    TFT_Set_Brush(1, CL_RED, 1, LEFT_TO_RIGHT, CL_PURPLE, CL_RED);
  else
    TFT_Set_Brush(1, CL_WHITE, 0, LEFT_TO_RIGHT, CL_BLACK, CL_WHITE);

  xcoo = 180 - (No / 4) * 40;
  ycoo = 190 - (No % 4) * 30;
  TFT_Circle(xcoo, ycoo, 10);
}

void DrawLeds(){
  TFT_Write_Text("PORTB   LEDs", 120, 60);
  TFT_Set_Brush(1, CL_WHITE, 0, LEFT_TO_RIGHT, CL_BLACK, CL_WHITE);

  for (i = 0; i < 8; i ++)
    DrawLed(i, 0);
}

void InitMCU(){     //  Init MCU function
  GPIO_Digital_Output(&GPIOC_BASE, _GPIO_PINMASK_2);           // Set GPIOC pin 2 as digital output
  I2C1_Init_Advanced(400000, &_GPIO_MODULE_I2C1_PB67);         //I2C config
  Delay_ms(100);
  
  // Init TFT
  TFT_Init_ILI9341_8bit(320, 240);
  TFT_Set_Default_Mode();
  Delay_ms(1000);
  TFT_BLED = 1;
}

void main(){
unsigned char IO;

  InitMCU();
  EXPAND_Reset();

  Expander_Write_Byte(EXPAND_ADDR, IODIRA_BANK0, 0x00);       // Set Expander's PORTA to be output
  Expander_Write_Byte(EXPAND_ADDR, IODIRB_BANK0, 0xFF);       // Set Expander's PORTB to be input
  Expander_Write_Byte(EXPAND_ADDR, GPPUB_BANK0, 0xFF);        // Set pull-ups to all of the Expander's PORTB pins

  DrawScr();
  DrawLeds();

  while(1) {                                                  // Endless loop
    Expander_Write_Byte(EXPAND_ADDR, OLATA_BANK0, GPIOD_IDR); // Write PORTD to expander's PORTA
    res = Expander_Read_Byte(EXPAND_ADDR, GPIOB_BANK0);       // Read expander's PORTB

    if (res != old_res){
      old_res = res;
      for (i = 0; i < 8; i ++){                               // Display expander's PORTB
        DrawLed(i, res % 2);
        res = res / 2;
      }
      Delay_ms(100);
    }
  }
}