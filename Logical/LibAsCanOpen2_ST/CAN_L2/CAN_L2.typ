(********************************************************************
 * COPYRIGHT -- Bernecker + Rainer
 ********************************************************************
 * Program: CAN_L2
 * File: CAN_L2.typ
 * Author: Bernecker + Rainer
 * Created: March 30, 2009
 ********************************************************************
 * Local data types of program CAN_L2
 ********************************************************************)

TYPE
	CAN_L2_typ : 	STRUCT 
		step : USINT;
		device : STRING[80];
		Data : ARRAY[0..7] OF USINT;
		CANopenRegisterCOBID_0 : CANopenRegisterCOBID;
		CANopenRegisterCOBID_1 : CANopenRegisterCOBID;
		CANopenPDORead8_0 : CANopenPDORead8;
		CANopenPDOWrite8_0 : CANopenPDOWrite8;
		CANopenNMT_0 : CANopenNMT;
	END_STRUCT;
END_TYPE
