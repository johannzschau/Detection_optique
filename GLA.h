
# define uart Uart1_write_text
char uart_rd;
int nombre;




/**************************************************************************************************
*Envoyer une  variables décimale sur l'UART
**************************************************************************************************/
void ScanDecimal(int *t)
{
  while (1) {                     // Endless loop
    if (UART1_Data_Ready()) {     // If data is received
      uart_rd = UART1_Read();     // read the received data
      UART1_Write(uart_rd);
  *t = uart_rd ;
      break;       // and send data via UART
    }
  }
  }


/**************************************************************************************************
*Envoyer du Texte sur l'UART
**************************************************************************************************/
void PrintString(char t [])
{
uart (t);
UART1_Write(10);
UART1_Write(13);
}
/**************************************************************************************************
*Envoyer des chiffres sur l'UART
**************************************************************************************************/
void PrintDecimal(int t)
{
char text [6] ;
ByteToStr(t, text);
Uart1_write_text (text);
}
/**************************************************************************************************
*INIT_I2C_2
**************************************************************************************************/
void InitI2C2()

{     //  Init MCU function
  GPIO_Digital_Output(&GPIOB_BASE, _GPIO_PINMASK_10);           // Set GPIOC pin 10 as digital output
  GPIO_Digital_Output(&GPIOB_BASE, _GPIO_PINMASK_11);           // Set GPIOC pin 11 as digital output
  I2C2_Init_Advanced(100000, &_GPIO_MODULE_I2C2_PB10_11);         //I2C config 100kbps
  Delay_ms(100);
}
/**************************************************************************************************
*INIT_I2C_1
**************************************************************************************************/
void InitI2C1()

{     //  Init MCU function
  GPIO_Digital_Output(&GPIOB_BASE, _GPIO_PINMASK_6);           // Set GPIOC pin 10 as digital output
  GPIO_Digital_Output(&GPIOB_BASE, _GPIO_PINMASK_7);
// Initialize the I2C1 module with 100Kbps speed on PORTB
I2C1_Init_Advanced(100000, &_GPIO_MODULE_I2C1_PB67);
I2C_Set_Active(&I2C1_Start, &I2C1_Read, &I2C1_Write); // Sets the I2C1 module active
  Delay_ms(100);
}
/**************************************************************************************************
*SETUP_GPIO
**************************************************************************************************/

void setupGPIO()
{
GPIO_Config(&GPIOA_BASE, _GPIO_PINMASK_LOW, _GPIO_CFG_PULL_UP|_GPIO_CFG_DIGITAL_INPUT); // résistance de pull-up par programmation
GPIO_Config(&GPIOA_BASE, _GPIO_PINMASK_8, _GPIO_CFG_PULL_UP|_GPIO_CFG_DIGITAL_INPUT); // résistance de pull-up par programmation
}

