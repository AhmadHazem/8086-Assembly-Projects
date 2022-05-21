INCLUDE "emu8086.inc"

JMP START

DATA SEGMENT
    PACKET  DW    0      ;NUMBER OF PACKETS TO BE TRANSMITTED
    N       DW    0         ;NUMBER OF TRANSMITTED PACKETS AND DETECT 128 CYCLE
    N2      DW    0         ;NUMBER OF TRANSMISSION  
    MSG1    DW   "Enter number of packets: ",0
    MSG2    DW    "Number of Transmissions: ",0
   
DATA ENDS  

CODE SEGMENT

ASSUME DS:DATA CS:CODE 

START:
       MOV CX, DATA         ;DECLARATION OF DATA SEGEMENT
	   MOV DS, CX   
	   DEFINE_SCAN_NUM
       DEFINE_PRINT_STRING
       DEFINE_PRINT_NUM
       DEFINE_PRINT_NUM_UNS 
       DEFINE_CLEAR_SCREEN  
       
	   LEA SI,MSG1
	   CAll PRINT_STRING
	   CALL SCAN_NUM
	   MOV PACKET,CX
	   

LOOP2: INC N2               ;INCREASING NUMBER OF TRANSMISSOIN MADE
       INC N                ;INCREASING NUMBER OF PACKETS TRANSMITTED
       DEC PACKET           ;DECREASING NUMBER OF PACKETS TO BE TRANSMITTED
       
       CMP N,64
       JB  ELSE             ;IF NUMBER OF PACKETS TRANSMITTED IS LESS THAN 64     
       
       INC N
       DEC PACKET 
       JMP DONE 
       
ELSE:  MOV CX,N
       SHL N,1
       SUB N,CX             ;EL VALUE EL GDEDA - EL ADEMA
       MOV CX,N 
       CMP CX,PACKET        ;CHECK IF NUMBER OF LEFT TO BE TRANSMITTED IS SMALLER THAN TRANSFERRED PACKETS AT THAT TIME
       JA  BREAK
       JE  BREAK
       SUB PACKET,CX
       ADD N,CX             ; RESTORE THE OLD VALUE OF N
       
       



DONE:  CMP  PACKET,0
       JB   BREAK
       JE   BREAK
       CMP  N,128
       JNE  END
       MOV  N,0
END:   JMP  LOOP2  

BREAK:
       PRINT 0AH
       PRINT 0DH
       LEA  SI,MSG2
       CALL PRINT_STRING
       MOV  AX,N2   
       CALL PRINT_NUM_UNS       
	        
	       
CODE ENDS

END START

ret