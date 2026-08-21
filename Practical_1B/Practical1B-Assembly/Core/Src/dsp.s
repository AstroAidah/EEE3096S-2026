/*
 * dsp.s
 * EEE3096S 2026 - Practical 1B, Task 4
 * Cycle-counted ADC to DAC loop with a 45 degree phase delay
 *
 * Student 1 : Mati Taimu  TMXMAT005
 * Student 2 : Idah Sumbi  SMBIDA001
 */

    .syntax unified
    .thumb
    .cpu    cortex-m0
    .fpu    softvfp

    .global DSP_Loop
    .type   DSP_Loop, %function

@ ---------------------------------------------------------------------------
@ Peripheral addresses
@ ---------------------------------------------------------------------------
    .equ ADC_DR,      0x40012440
    .equ DAC_DHR12R1, 0x40007408

    .section .text.DSP_Loop, "ax", %progbits

@ ===========================================================================
@ ENTRY POINT
@ ===========================================================================
DSP_Loop:
    @ Setup registers outside the timed loop
    LDR R0, =ADC_DR
    LDR R1, =DAC_DHR12R1

loop:
    @ --- SAMPLE AND OUTPUT ------------------------------------------------
    @ TODO 1: Read the current ADC conversion from the Data Register.
    LDR R2, [R0] @places whats being pointed at with R0 and puts it in R2
    
    @ TODO 2: Write the value straight out to the DAC Data Register.
    STR R2, [R1] @take whats in R2 and put it where R1 is pointing

    @ --- DELAY SETUP ------------------------------------------------------
    @ TODO 3: Calculate the required cycle target for a 45-degree phase 
    @         delay on a 1 kHz sine wave running at an 8 MHz system clock.
    @         Load your inner loop counter and insert any NOP padding 
    @         needed to hit your exact target.
    MOVS R3, #248  @countdown from 248
    NOP

delay_loop:
    @ --- INNER LOOP -------------------------------------------------------
    @ TODO 4: Implement the counted delay loop.
    @         (Remember to use flag-updating arithmetic so your branch works).
    SUBS R3, R3, #1 @R3=R3-1
    BNE  delay_loop

    @ --- REPEAT -----------------------------------------------------------
    @ TODO 5: Branch back to the start of the main 'loop'.
    B loop
    
    @ ----------------------------------------------------------------------
    @ NOTE: You must calculate your exact cycle budget, showing the cost 
    @ of every instruction and loop iteration, and document it in your report.
    @ ----------------------------------------------------------------------

    .size DSP_Loop, .-DSP_Loop
