unsigned long value ;
unsigned long Can_Init_Flags;
unsigned char Can_Send_Flags, Can_Rcv_Flags;                   // can flags
unsigned char Rx_Data_Len;                                   // received data length in bytes
char RxTx_Data[8];
unsigned char compt;



char Rx_Data[8];                                            // can rx/tx data buffer
char Msg_Rcvd;                                               // reception flag
const long ID_1st = 8, ID_2nd = 37;  // ID TX
long Rx_ID;
char menu ;





void Trame_Test (void)
{
  RxTx_Data[0] =1;      // set initial data to be sent
  RxTx_Data[1] =2;
  RxTx_Data[2] =3;
  RxTx_Data[3] =4;
  RxTx_Data[4] =5;
  RxTx_Data[5] =6;
  RxTx_Data[6] =7;

}


void Send_Can ( void )
{
CAN1Write(ID_1st, RxTx_Data, 7, Can_Send_Flags); // send initial message

 for (compt=0;compt<=30;compt++) {  // endless loop
    Msg_Rcvd = CAN1Read(0, &Rx_ID , Rx_Data , &Rx_Data_Len, &Can_Rcv_Flags);  // receive message
    if (((Rx_ID == ID_2nd)||Rx_ID == ID_1st) && Msg_Rcvd) {                                        // if message received check id
      //GPIOE_ODR  = RxTx_Data[0] << 8;                                           // id correct, output data at PORTE
      //RxTx_Data[0]++ ;  // increment received data
       Delay_ms(10);
      CAN1Write(ID_1st,RxTx_Data, 1, Can_Send_Flags);
      break ;
    }
     if (compt >= 30){PrintString ("!!!!!!! time-out !!!!!!!!");}
    }

    }


void initCAN (void)
 {
const unsigned int SJW     =  1;   // Synchronisation Seg (Tq)
const unsigned int BRP     =  4;   // divisseur baudrate
const unsigned int PHSEG1  =  5;  // phase Segment
const unsigned int PHSEG2  =  2;
const unsigned int PROPSEG =  8;


GPIO_Digital_Input(&GPIOB_BASE, _GPIO_PINMASK_8);
GPIO_Digital_Output(&GPIOB_BASE, _GPIO_PINMASK_9);
GPIOE_ODR  = 0;

  Can_Init_Flags = 0;                                       //
  Can_Send_Flags = 0;                                       // clear flags
  Can_Rcv_Flags  = 0;                                       //

  Can_Send_Flags = _CAN_TX_STD_FRAME &                      //     with CANWrite
                   _CAN_TX_NO_RTR_FRAME;

  Can_Init_Flags = _CAN_CONFIG_AUTOMATIC_RETRANSMISSION &              // form value to be used
                   _CAN_CONFIG_RX_FIFO_NOT_LOCKED_ON_OVERRUN &         // with CANInit
                   _CAN_CONFIG_TIME_TRIGGERED_MODE_DISABLED &
                   _CAN_CONFIG_TX_FIFO_PRIORITY_BY_IDINTIFIER &
                   _CAN_CONFIG_WAKE_UP;

  CAN1InitializeAdvanced(SJW, BRP, PHSEG1, PHSEG2, PROPSEG,Can_Init_Flags, &_GPIO_MODULE_CAN1_PB89); // Initialize CAN module   (125Kb/s uc 8Mhz)

  CANSetFilterScale32(0, _CAN_FILTER_ENABLED & _CAN_FILTER_ID_MASK_MODE & _CAN_FILTER_STD_MSG, ID_2nd, -1);

  CAN1SetOperationMode(_CAN_OperatingMode_Normal); // set NORMAL mode
  }
  
  void TEST_CAN()
{
PrintString ("---------init can---------");
initCAN ();  // init can PB8,9 (125Kb/S uc 8Mhz)
Delay_100ms();
Trame_Test ();
Send_Can ();
}