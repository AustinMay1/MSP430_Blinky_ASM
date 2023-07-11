;-------------------------------------------------------------------------------
; MSP430 Assembler Code Template for use with TI Code Composer Studio
;
;
;-------------------------------------------------------------------------------
            .cdecls C,LIST,"msp430.h"       ; Include device header file
            
;-------------------------------------------------------------------------------
            .def    RESET                   ; Export program entry-point to
                                            ; make it known to linker.
;-------------------------------------------------------------------------------
            .text                           ; Assemble into program memory.
            .retain                         ; Override ELF conditional linking
                                            ; and retain current section.
            .retainrefs                     ; And retain any sections that have
                                            ; references to current section.

;-------------------------------------------------------------------------------
RESET       mov.w   #__STACK_END,SP         ; Initialize stackpointer
StopWDT     mov.w   #WDTPW|WDTHOLD,&WDTCTL  ; Stop watchdog timer


;-------------------------------------------------------------------------------
; Main loop here : Blink LED1
;-------------------------------------------------------------------------------
init:
			bic.w	#0001h,  &PM5CTL0 		;
			bis.b	#01h,	 &P1DIR			; setting the p1.0 as output (p1.0 = LED1)

main:
			xor.b 	#01h, 	 &P1OUT			; toggle p1.0 (LED1)
			mov.w 	#0FFFFh, R4				; puts number in Reg4
delay:
			dec.w 	R4						; decrement Reg4
			jnz   	delay					; repeat until R4=0

			jmp	  	main					; repeat main loop
            nop
;-------------------------------------------------------------------------------
; Stack Pointer definition
;-------------------------------------------------------------------------------
            .global __STACK_END
            .sect   .stack
            
;-------------------------------------------------------------------------------
; Interrupt Vectors
;-------------------------------------------------------------------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET
            
