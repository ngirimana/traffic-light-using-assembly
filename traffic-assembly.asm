

    

; PIC16F877A Configuration Bit Settings

; Assembly source line config statements

#include "p16f877a.inc"

; CONFIG
; __config 0x3FFB
; __CONFIG _FOSC_EXTRC & _WDTE_OFF & _PWRTE_OFF & _BOREN_ON & _LVP_ON & _CPD_OFF & _WRT_OFF & _CP_OFF

    STATUS equ 03h  ;selecting bank   
 
    RP0 equ 05
 
    RP1 equ 06
 
    PORTA equ 05h ;bank0
    
    TRISA equ 85h ;bank1
 
    COUNTER equ 20h ;the counter for one delay loop
 
    org 00h   
    clrw  ; clear  W register
	
    ;selecting bank0
    BCF STATUS,RP0;RP0=0
    BCF STATUS,RP1;RP1=0
    
    CLRF PORTA; initialization portA
    
    ;switch to bank 1 for TRISA register
    BSF STATUS,RP0;RP0=1 to select bank1
    
    CLRF TRISA 
    
    ;RP1 is already o from the previous step
	
    ;next we make sure that all pin in PORTA are output
    MOVLW 0X00 ; clear w register
    MOVWF TRISA ; SET PORT A as output
    
    ;back to bank0 for working with portA
    BCF STATUS,RP0;RP0=0
    
    ;now let us turn on all pinS aoutput
SART MOVLW 0x01
     MOVWF PORTA ;turn on pin 1 on port A
	
      ;delay
     MOVLW 0xff;decimal 255
     MOVWF COUNTER;set counter 1 to 0xff load the counter 255
     
Loop1 DECFSZ COUNTER,1; subtract 1 from 255
      GOTO Loop1 ; if counter 1 zero then carry on
      
      MOVLW 0x02  ;load w with 00000000
      MOVWF PORTA ;turn on 2 pin on  PORTA 
	  
      ;delay
      MOVLW 0xff  ;can be 0x01  to delay
      MOVWF COUNTER ; set counter 1to 0xff
      
Loop2 DECFSZ COUNTER,1  ; subtract 1 from 255
      GOTO Loop2 ; if counter 1 is  zero then carry on
      
      MOVLW 0x04  ;load w with 00000000
      MOVWF PORTA ;turn on  pin 3 PORTA 
	  
      ;delay
      MOVLW 0xff  ;can be 0x01  to delay
      MOVWF COUNTER ; set counter 1to 0xff 
     
Loop3 DECFSZ COUNTER,1  ; subtract 1 from 255
      GOTO Loop3 ; if counter 1 is  zero then carry on
 
      GOTO SART
     
end
	   




