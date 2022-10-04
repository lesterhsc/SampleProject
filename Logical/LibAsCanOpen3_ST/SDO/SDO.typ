(********************************************************************
 * COPYRIGHT -- Bernecker + Rainer
 ********************************************************************
 * Program: SDO
 * File: SDO.typ
 * Author: Bernecker + Rainer
 * Created: March 30, 2009
 ********************************************************************
 * Local data types of program SDO
 ********************************************************************)

TYPE
	SDO_type : 	STRUCT 
		step : USINT;
		device : STRING[80];
		CANopenSDORead8_0 : CANopenSDORead8;
		CANopenSDOWrite8_0 : CANopenSDOWrite8;
		CANopenSDOWrite8_1 : CANopenSDOWrite8;
		CANopenSDOWrite8_2 : CANopenSDOWrite8;
		CANopenSDOWrite8_3 : CANopenSDOWrite8;
	END_STRUCT;
END_TYPE
