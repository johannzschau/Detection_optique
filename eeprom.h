#define eeprom_Address  0x50


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
eeprom_Write_Byte(eeprom_Address,0x00,0xAB);
PrintString (" ");
PrintDecimal(eeprom_Read_Byte(eeprom_Address,0x00));
PrintString (" ");
PrintString ("-----------------------------");
}
