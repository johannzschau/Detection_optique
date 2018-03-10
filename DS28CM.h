#define DS28CM00R_Address 0x50

#define Device_Family_Code 0x00

#define Serial_Number_1 0x01
#define Serial_Number_2 0x02
#define Serial_Number_3 0x03
#define Serial_Number_4 0x04
#define Serial_Number_5 0x05
#define Serial_Number_6 0x06
#define Serial_Number_7 0x07






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
PrintDecimal(DS28CM00R_Read_Byte(DS28CM00R_Address,Serial_Number_1));
PrintString (" ");
PrintDecimal(DS28CM00R_Read_Byte(DS28CM00R_Address,Serial_Number_2));
PrintString (" ");
PrintDecimal(DS28CM00R_Read_Byte(DS28CM00R_Address,Serial_Number_3));
PrintString (" ");
PrintDecimal(DS28CM00R_Read_Byte(DS28CM00R_Address,Serial_Number_4));
PrintString (" ");
PrintDecimal(DS28CM00R_Read_Byte(DS28CM00R_Address,Serial_Number_5));
PrintString (" ");
PrintDecimal(DS28CM00R_Read_Byte(DS28CM00R_Address,Serial_Number_6));
PrintString (" ");
PrintDecimal(DS28CM00R_Read_Byte(DS28CM00R_Address,Serial_Number_7));
PrintString ("\n");
}
