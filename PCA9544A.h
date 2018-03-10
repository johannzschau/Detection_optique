#define PCA9544A_Address_1   0x70
#define PCA9544A_Address_2   0x71
#define PCA9544A_Address_3   0x72
#define PCA9544A_Address_4   0x73
#define PCA9544A_Address_5   0x74
#define PCA9544A_Address_6   0x75
#define PCA9544A_Address_7   0x76
#define PCA9544A_Address_8   0x77

#define PCA9544A_no_channel_selected 0x00
#define PCA9544A_channel_0   0x04
#define PCA9544A_channel_1   0x05
#define PCA9544A_channel_2   0x06
#define PCA9544A_channel_3   0x07

#define PCA9544A_register    0x00


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

PCA9544A_Write_Byte(PCA9544A_Address_1 ,PCA9544A_register,PCA9544A_no_channel_selected);
PCA9544A_Write_Byte(PCA9544A_Address_2 ,PCA9544A_register,PCA9544A_no_channel_selected);
PCA9544A_Write_Byte(PCA9544A_Address_3 ,PCA9544A_register,PCA9544A_no_channel_selected);
PCA9544A_Write_Byte(PCA9544A_Address_4 ,PCA9544A_register,PCA9544A_no_channel_selected);
PCA9544A_Write_Byte(PCA9544A_Address_5 ,PCA9544A_register,PCA9544A_no_channel_selected);
PCA9544A_Write_Byte(PCA9544A_Address_6 ,PCA9544A_register,PCA9544A_no_channel_selected);
PCA9544A_Write_Byte(PCA9544A_Address_7 ,PCA9544A_register,PCA9544A_no_channel_selected);
PCA9544A_Write_Byte(PCA9544A_Address_8 ,PCA9544A_register,PCA9544A_no_channel_selected);

}