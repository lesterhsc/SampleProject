(********************************************************************
 * COPYRIGHT -- Bernecker + Rainer
 ********************************************************************
 * Program: CAN_L2
 * File: CAN_L2.st
 * Author: Bernecker + Rainer
 * Created: March 30, 2009
 ********************************************************************
 * Implementation of program CAN_L2
 ********************************************************************)

PROGRAM _INIT

(* General assignments *)
CAN_L2.device:= 'SS1.IF2';  (* determine Interface *)

END_PROGRAM


PROGRAM _CYCLIC

CASE CAN_L2.step OF
	
	0: (* Register COB ID for reading *)
	
		CAN_L2.CANopenRegisterCOBID_0.enable:= 1;
		CAN_L2.CANopenRegisterCOBID_0.pDevice:= ADR(CAN_L2.device);
		CAN_L2.CANopenRegisterCOBID_0.cobid:= 16#182;
		CAN_L2.CANopenRegisterCOBID_0.inscribe:= TRUE;
		CAN_L2.CANopenRegisterCOBID_0;  (* Call function block *)
		IF CAN_L2.CANopenRegisterCOBID_0.status = ERR_OK THEN  (* OK *)
			CAN_L2.step:= 1; (* next step *)
		ELSIF CAN_L2.CANopenRegisterCOBID_0.status = ERR_FUB_BUSY THEN (* FBK not yet finished *)
			(* busy *)
		ELSE  (* Error step *)
			CAN_L2.step:= 10;
		END_IF
		
	1: (* Register COB ID for writing *)
	
		CAN_L2.CANopenRegisterCOBID_1.enable:= 1;
		CAN_L2.CANopenRegisterCOBID_1.pDevice:= ADR(CAN_L2.device);
		CAN_L2.CANopenRegisterCOBID_1.cobid:= 16#202;
		CAN_L2.CANopenRegisterCOBID_1.inscribe:= TRUE;
		CAN_L2.CANopenRegisterCOBID_1;  (* Call function block *)
		IF CAN_L2.CANopenRegisterCOBID_1.status = ERR_OK THEN  (* OK *)
			CAN_L2.step:= 2; (* next step *)
		ELSIF CAN_L2.CANopenRegisterCOBID_1.status = ERR_FUB_BUSY THEN (* FBK not yet finished *)
			(* busy *)
		ELSE  (* Error step *)
			CAN_L2.step:= 10;
		END_IF
		
	2:  (*Send NMT "Start remote nodes" *)
	
		CAN_L2.CANopenNMT_0.enable:= 1;
		CAN_L2.CANopenNMT_0.pDevice:= ADR(CAN_L2.device);
		CAN_L2.CANopenNMT_0.node:= 2;  (* node ID 2 *)
		CAN_L2.CANopenNMT_0.state:= coSTART_REMOTE_NODE;  (* Command start remote node *)
		CAN_L2.CANopenNMT_0;  (* Call function block *)
		IF CAN_L2.CANopenNMT_0.status = ERR_OK THEN  (* OK *)
			CAN_L2.step:= 3; (* next step *)
		ELSIF CAN_L2.CANopenNMT_0.status = ERR_FUB_BUSY THEN (* FBK not yet finished *)
			(* busy *)
		ELSE  (* Error step *)
			CAN_L2.step:= 10;
		END_IF		
		
	3: (* Read TPDO1 from IO node *)
	
		CAN_L2.CANopenPDORead8_0.enable:= 1;
		CAN_L2.CANopenPDORead8_0.pDevice:= ADR(CAN_L2.device);
		CAN_L2.CANopenPDORead8_0.cobid:= 16#182;  (* TPDO1 COB ID *)
		CAN_L2.CANopenPDORead8_0;  (* Call function block *)
		IF CAN_L2.CANopenPDORead8_0.status = ERR_OK THEN  (* OK *)
			CAN_L2.step:= 4; (* next step *)
		ELSIF CAN_L2.CANopenPDORead8_0.status = ERR_FUB_BUSY THEN (* FBK not yet finished *)
			(* busy *)
		ELSE  (* Error step *)
			CAN_L2.step:= 10;
		END_IF
		
	4: (* Write RPDO1 to IO node *)
	
		CAN_L2.CANopenPDOWrite8_0.enable:= 1;
		CAN_L2.CANopenPDOWrite8_0.pDevice:= ADR(CAN_L2.device);
		CAN_L2.CANopenPDOWrite8_0.cobid:= 16#202;  (* RPDO1 COB ID *)
		CAN_L2.CANopenPDOWrite8_0.data0:= CAN_L2.Data[0];  (* Data written to the IO device *)
		CAN_L2.CANopenPDOWrite8_0.datalen:= 8;  (* Length of PDO *)
		CAN_L2.CANopenPDOWrite8_0;  (* Call function block *)
		IF CAN_L2.CANopenPDOWrite8_0.status = ERR_OK THEN  (* OK *)
			CAN_L2.Data[0]:= CAN_L2.Data[0] + 1;  (* running counter *)
			CAN_L2.step:= 3; (* next step *)
		ELSIF CAN_L2.CANopenPDOWrite8_0.status = ERR_FUB_BUSY THEN (* FBK not yet finished *)
			(* busy *)
		ELSE  (* Error step *)
			CAN_L2.step:= 10;
		END_IF
END_CASE



END_PROGRAM
