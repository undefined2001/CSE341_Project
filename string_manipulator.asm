.MODEL SMALL
.STACK 100H

.DATA 
    MENU_1 DB "1. ENCRYPT STRING.$"
    MENU_2 DB 13, 10, "2. DECRYPT STRING.$"
    MENU_3 DB 13, 10, "3. REVERSE STRING.$"
    MENU_4 DB 13, 10, "4. MAKE UPPERCASE.$"
    MENU_5 DB 13, 10, "5, MAKE LOWERCASE.$"
    MENU_6 DB 13, 10, "SELECT AN OPTION FROM ABOVE: $" 
    
    MSG_1 DB 13, 10, "ENTER THE LENGTH OF YOUR STRING(1-9): $" 
    MSG_2 DB 13, 10, "ENTER YOUR STRING: $" 
    MSG_3 DB 13, 10, "YOUR OUTPUT IS: $" 
    MSG_4 DB 13, 10, "ENTER YOUR STRING(ALL UPPER CASE): $"
    MSG_5 DB 13, 10, "ENTER YOUR STRING(ALL LOWER CASE): $"
   
STRING_LENGTH DB ?
STRING_ARRAY DB 20 DUP(0)
ENC_STRING_ARRAY DB 20 DUP(0)


.CODE
    PROC MAIN
    MOV AX, @DATA
    MOV DS, AX
    
    ;This section is for Printing the menu
    PRINT_MENU:
        LEA DX, MENU_1
        MOV AH, 09H  
        INT 21H  
        LEA DX, MENU_2
        MOV AH, 09H  
        INT 21H
        LEA DX, MENU_3
        MOV AH, 09H  
        INT 21H
        LEA DX, MENU_4
        MOV AH, 09H  
        INT 21H
        LEA DX, MENU_5
        MOV AH, 09H  
        INT 21H
        LEA DX, MENU_6
        MOV AH, 09H 
        INT 21H 
    ;End of the menu section
    
    
 
    MOV AH, 01H
    INT 21H 
    SUB AL, 30H
    CMP AL, 1
    JE ENCRYPTION
    CMP AL, 2
    JE DECRYPTION
    CMP AL, 3
    JE STRING_REVERS
    CMP AL, 4
    JE STRING_UPPERCASE
    CMP AL, 5
    JE STRING_LOWERCASE
    
             
    ;THIS PART IS FOR ENCRYPTION
    ENCRYPTION:
        LEA DX, MSG_1
        MOV AH, 09H 
        INT 21H
        
        MOV AH, 01H
        INT 21H 
        SUB AL, 30H
        MOV STRING_LENGTH, AL
        
        LEA DX, MSG_2
        MOV AH, 09H 
        INT 21H
               
        MOV CH, 0
        MOV CL, STRING_LENGTH
        MOV SI, 0  
        
    TAKING_INPUT:
        MOV AH, 01H
        INT 21H
        MOV STRING_ARRAY[SI], AL
        XOR AL, STRING_LENGTH
        MOV ENC_STRING_ARRAY[SI], AL
        INC SI
    LOOP TAKING_INPUT 
                         
        MOV CH, 0
        MOV CL, STRING_LENGTH
        MOV SI, 0
        LEA DX, MSG_3
        MOV AH, 09H 
        INT 21H
    PRINTING:
        MOV DH, 0
        MOV DL, ENC_STRING_ARRAY[SI]
        MOV AH, 02H
        INC SI
        INT 21H
    LOOP PRINTING 
    JMP EXIT    
    ;END OF ENCRYPTION  
    
    ;THIS PART IS FOR DECRTPYION
    DECRYPTION:
        LEA DX, MSG_1
        MOV AH, 09H 
        INT 21H
        
        MOV AH, 01H
        INT 21H 
        SUB AL, 30H
        MOV STRING_LENGTH, AL
        
        LEA DX, MSG_2
        MOV AH, 09H 
        INT 21H
               
        MOV CH, 0
        MOV CL, STRING_LENGTH
        MOV SI, 0  
        
    TAKING_INPUT_2:
        MOV AH, 01H
        INT 21H
        MOV STRING_ARRAY[SI], AL
        XOR AL, STRING_LENGTH
        MOV ENC_STRING_ARRAY[SI], AL
        INC SI
    LOOP TAKING_INPUT_2 
                         
        MOV CH, 0
        MOV CL, STRING_LENGTH
        MOV SI, 0
        LEA DX, MSG_3
        MOV AH, 09H 
        INT 21H
    PRINTING_2:
        MOV DH, 0
        MOV DL, ENC_STRING_ARRAY[SI]
        MOV AH, 02H
        INC SI
        INT 21H
    LOOP PRINTING_2
    JMP EXIT  
    ;END OF DECRTPYION 
    
    
    ;THIS PART IS FOR REVERSING STRING
    STRING_REVERS:
        LEA DX, MSG_1
        MOV AH, 09H 
        INT 21H
        
        MOV AH, 01H
        INT 21H 
        SUB AL, 30H
        MOV STRING_LENGTH, AL
        
        LEA DX, MSG_2
        MOV AH, 09H 
        INT 21H
               
        MOV CH, 0
        MOV CL, STRING_LENGTH
        MOV SI, 0 
    TAKING_INPUT_3:
        MOV AH, 01H
        INT 21H
        
        MOV STRING_ARRAY[SI], AL
        INC SI
    LOOP TAKING_INPUT_3 
    
        MOV CH, 0
        MOV CL, STRING_LENGTH
        ADD CL, 1
        MOV AH, 0
        MOV AL, STRING_LENGTH
        MOV SI, AX
        LEA DX, MSG_3
        MOV AH, 09 
        INT 21H 
    REVERSE_PRINTING:
        MOV DH, 0
        MOV DL, STRING_ARRAY[SI]
        MOV AH, 02H
        DEC SI
        INT 21H
    LOOP REVERSE_PRINTING
    JMP EXIT  
    ;END OF STRING REVERSE
    
    ;THIS SECTION IS FOR STRING ALL LOWERCASE
    STRING_LOWERCASE:
        LEA DX, MSG_1
        MOV AH, 09H 
        INT 21H
        
        MOV AH, 01H
        INT 21H 
        SUB AL, 30H
        MOV STRING_LENGTH, AL
        
        LEA DX, MSG_4
        MOV AH, 09H 
        INT 21H
               
        MOV CH, 0
        MOV CL, STRING_LENGTH
        MOV SI, 0 
    TAKING_INPUT_4:
        MOV AH, 01H
        INT 21H
        ADD AL, 20H
        MOV STRING_ARRAY[SI], AL
        INC SI
    LOOP TAKING_INPUT_4
        MOV CH, 0
        MOV CL, STRING_LENGTH
        MOV SI, 0
        LEA DX, MSG_3
        MOV AH, 09H 
        INT 21H
    PRINTING_LOWRCASE:
        MOV DH, 0
        MOV DL, STRING_ARRAY[SI]
        MOV AH, 02H
        INC SI
        INT 21H
    LOOP PRINTING_LOWRCASE 
    JMP EXIT
    ;END OF STRING ALL LOWERCASE
    
    ;THIS SECTION IS FOR STRING ALL UPPERCASE
    STRING_UPPERCASE:
        LEA DX, MSG_1
        MOV AH, 09H 
        INT 21H
        
        MOV AH, 01H
        INT 21H 
        SUB AL, 30H
        MOV STRING_LENGTH, AL
        
        LEA DX, MSG_5
        MOV AH, 09H 
        INT 21H
               
        MOV CH, 0
        MOV CL, STRING_LENGTH
        MOV SI, 0 
    TAKING_INPUT_5:
        MOV AH, 01H
        INT 21H
        SUB AL, 20H
        MOV STRING_ARRAY[SI], AL
        INC SI
    LOOP TAKING_INPUT_5
        MOV CH, 0
        MOV CL, STRING_LENGTH
        MOV SI, 0
        LEA DX, MSG_3
        MOV AH, 09H 
        INT 21H
    PRINTING_UPPERCASE:
        MOV DH, 0
        MOV DL, STRING_ARRAY[SI]
        MOV AH, 02H
        INC SI
        INT 21H
    LOOP PRINTING_UPPERCASE 
    JMP EXIT
    ;END OF STRING ALL UPPERCASE  
    
EXIT:    
    ENDP MAIN
END MAIN
