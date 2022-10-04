(********************************************************************
 * COPYRIGHT -- Bernecker + Rainer
 ********************************************************************
 * Program: SDO
 * File: SDO.st
 * Author: Bernecker + Rainer
 * Created: March 30, 2009
 ********************************************************************
 * Implementation of program SDO
 ********************************************************************)

PROGRAM _INIT

(* General assignments *)
SDO.device:= 'SS1.IF2';  (* determine Interface *)

END_PROGRAM


PROGRAM _CYCLIC

CASE SDO.step OF

	0: (* Read Device ID form IO node *)

		SDO.CANopenSDORead8_0.enable:= 1;
		SDO.CANopenSDORead8_0.pDevice:= ADR(SDO.device);
		SDO.CANopenSDORead8_0.node:= 2;  (* Node ID from IO device *)
		SDO.CANopenSDORead8_0.index:= 16#100A;  (* Index of IO device; BC0043 = Firmware version *)
		SDO.CANopenSDORead8_0.subindex:= 16#0000; (* Subindex of IO device *)
		SDO.CANopenSDORead8_0;  (* Call function block *)
		IF SDO.CANopenSDORead8_0.status = ERR_OK THEN  (* OK *)
			SDO.step:= 1; (* next step *)
		ELSIF SDO.CANopenSDORead8_0.status = ERR_FUB_BUSY THEN (* FBK not yet finished *)
			(* busy *)
		ELSE  (* Error step *)
			SDO.step:= 10;
		END_IF

	1: (* Configuration of AT6402 card on slot 2 *)
		(* Write Module ID to BC0043 *)
	
		SDO.CANopenSDOWrite8_0.enable:= 1;
		SDO.CANopenSDOWrite8_0.pDevice:= ADR(SDO.device);
		SDO.CANopenSDOWrite8_0.node:= 2;  (* Node ID from IO device *)
		SDO.CANopenSDOWrite8_0.index:= 16#2251;  (* Index of IO device; BC0043 = Parameter modul 2 *)
		SDO.CANopenSDOWrite8_0.subindex:= 16#01;  (* Subindex of IO device; BC0043 = Get configured module ID *)
		SDO.CANopenSDOWrite8_0.data0:= 16#A9;  (* low byte of module ID *)
		SDO.CANopenSDOWrite8_0.data1:= 16#1B;  (* high byte of module ID *)
		SDO.CANopenSDOWrite8_0.datalen:= 2;
		SDO.CANopenSDOWrite8_0;
		IF SDO.CANopenSDOWrite8_0.status = ERR_OK THEN  (* OK *)
			SDO.step:= 2; (* next step *)
		ELSIF SDO.CANopenSDOWrite8_0.status = ERR_FUB_BUSY THEN (* FBK not yet finished *)
			(* busy *)
		ELSE  (* Error step *)
			SDO.step:= 10;
		END_IF
		
	2: (* Configuration of AT6402 card on slot 2 *)
		(* Write Sensor Type J to AT6402 *)
		
		SDO.CANopenSDOWrite8_1.enable:= 1;
		SDO.CANopenSDOWrite8_1.pDevice:= ADR(SDO.device);
		SDO.CANopenSDOWrite8_1.node:= 2;  (* Node ID from IO device *)
		SDO.CANopenSDOWrite8_1.index:= 16#2251;  (* Index of IO device; BC0043 = Parameter modul 2 *)
		SDO.CANopenSDOWrite8_1.subindex:= 16#0A;  (* Subindex of IO device; BC0043 = Parameter 1 modul 2*)
		SDO.CANopenSDOWrite8_1.data0:= 16#02;  (* low byte of config data *)
		SDO.CANopenSDOWrite8_1.data1:= 16#00;  (* high byte of config data *)
		SDO.CANopenSDOWrite8_1.data2:= 16#1A;  (* low byte of register number *)
		SDO.CANopenSDOWrite8_1.data3:= 16#00;  (* high byte of register number *)
		SDO.CANopenSDOWrite8_1.datalen:= 4;
		SDO.CANopenSDOWrite8_1;
		IF SDO.CANopenSDOWrite8_1.status = ERR_OK THEN  (* OK *)
			SDO.step:= 3; (* next step *)
		ELSIF SDO.CANopenSDOWrite8_1.status = ERR_FUB_BUSY THEN (* FBK not yet finished *)
			(* busy *)
		ELSE  (* Error step *)
			SDO.step:= 10;
		END_IF
		
	3: (* Configuration of AT6402 card on slot 2 *)
		(* Disable input 2-6 *)

		SDO.CANopenSDOWrite8_2.enable:= 1;
		SDO.CANopenSDOWrite8_2.pDevice:= ADR(SDO.device);
		SDO.CANopenSDOWrite8_2.node:= 2;  (* Node ID from IO device *)
		SDO.CANopenSDOWrite8_2.index:= 16#2251;  (* Index of IO device; BC0043 = Parameter modul 2*)
		SDO.CANopenSDOWrite8_2.subindex:= 16#0B;  (* Subindex of IO device; BC0043 = Parameter 2 modul 2 *)
		SDO.CANopenSDOWrite8_2.data0:= 16#01;  (* low byte of config data *)
		SDO.CANopenSDOWrite8_2.data1:= 16#00;  (* high byte of config data *)
		SDO.CANopenSDOWrite8_2.data2:= 16#1B;  (* low byte of register number *)
		SDO.CANopenSDOWrite8_2.data3:= 16#00;  (* high byte of register number *)
		SDO.CANopenSDOWrite8_2.datalen:= 4;
		SDO.CANopenSDOWrite8_2;
		IF SDO.CANopenSDOWrite8_2.status = ERR_OK THEN  (* OK *)
			SDO.step:= 4; (* next step *)
		ELSIF SDO.CANopenSDOWrite8_2.status = ERR_FUB_BUSY THEN (* FBK not yet finished *)
			(* busy *)
		ELSE  (* Error step *)
			SDO.step:= 10;
		END_IF
	
	4: (* Configuration of AT6402 card on slot 2 *)
		(* Store configuration on BC0043 *)

		SDO.CANopenSDOWrite8_3.enable:= 1;
		SDO.CANopenSDOWrite8_3.pDevice:= ADR(SDO.device);
		SDO.CANopenSDOWrite8_3.node:= 2;  (* Node ID from IO device *)
		SDO.CANopenSDOWrite8_3.index:= 16#1010;  (* Index of IO device; BC0043 = Store parameter field *)
		SDO.CANopenSDOWrite8_3.subindex:= 16#01;  (* Subindex of IO device; BC0043 = save all parameter *)
		SDO.CANopenSDOWrite8_3.data0:= 16#73;  (* low byte of config data *)
		SDO.CANopenSDOWrite8_3.data1:= 16#61;  (* high byte of config data *)
		SDO.CANopenSDOWrite8_3.data2:= 16#76;  (* low byte of register number *)
		SDO.CANopenSDOWrite8_3.data3:= 16#65;  (* high byte of register number *)
		SDO.CANopenSDOWrite8_3.datalen:= 4;
		SDO.CANopenSDOWrite8_3;
		IF SDO.CANopenSDOWrite8_3.status = ERR_OK THEN  (* OK *)
			SDO.step:= 5; (* next step *)
		ELSIF SDO.CANopenSDOWrite8_3.status = ERR_FUB_BUSY THEN (* FBK not yet finished *)
			(* busy *)
		ELSE  (* Error step *)
			SDO.step:= 10;
		END_IF
	
END_CASE

END_PROGRAM
