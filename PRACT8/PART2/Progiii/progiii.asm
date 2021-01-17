.model small


.stack 100h

    LOCALS
    

.data
    msg db "Ingrese HEX",13,10,'$'
    msg2 db " En decimal es ", '$'
    msg3 db " No valido",10,13, '$'
    num db 30h,31h,32h,33h,34h,35h,36h,37h,38h,39h


.code
    
    main proc
        mov ax, @data
        mov ds, ax
		
		call clrscr
        
        lea dx, msg
        
        push ax
        mov ah, 9h ;imprimir cadena 
        int 21h
        pop ax
        
        lea dx, msg2
        
        mov ah, 1h
        int 21h ;call getchar
        
        
    ;switch (AL)
@@case_A:	cmp al, 'A'
            jne @@case_B
            
            push ax
            mov ah, 9h ;imprimir cadena 
            int 21h
            pop ax
            
            mov dl, num[1]
            
            mov ah, 2h
            int 21h ;putchar
            
            mov dl, num[0]
            
            mov ah, 2h
            int 21h ;putchar
            
            jmp @@break
            
@@case_B:   cmp al, 'B'
            jne @@case_C
            
            push ax
            mov ah, 9h ;imprimir cadena 
            int 21h
            pop ax
        
            mov dl, num[1]
            
            mov ah, 2h
            int 21h ;putchar
            
            mov ah, 2h
            int 21h ;putchar
            
            jmp @@break

@@case_C:   cmp al, 'C'
            jne @@case_D
            
            push ax
            mov ah, 9h ;imprimir cadena 
            int 21h
            pop ax
            
            mov dl, num[1]
            
            mov ah, 2h
            int 21h ;putchar
            
            mov dl, num[2]
            
            mov ah, 2h
            int 21h ;putchar
            
            jmp @@break

@@case_D:   cmp al, 'D'
            jne @@case_E
            
            push ax
            mov ah, 9h ;imprimir cadena 
            int 21h
            pop ax
            
            mov dl, num[1]
            
            mov ah, 2h
            int 21h ;putchar
            
            mov dl, num[3]
            
            mov ah, 2h
            int 21h ;putchar
            
            jmp @@break
    
@@case_E:	cmp al, 'E'
            jne @@case_F
            
            push ax
            mov ah, 9h ;imprimir cadena 
            int 21h
            pop ax
            
            mov dl, num[1]
            
            mov ah, 2h
            int 21h ;putchar
            
            mov dl, num[4]
            
            mov ah, 2h
            int 21h ;putchar
            
            jmp @@break
    
@@case_F:	cmp al, 'F'
            jne @@case_Default
            
            push ax
            mov ah, 9h ;imprimir cadena 
            int 21h
            pop ax
            
            mov dl, num[1]
            
            mov ah, 2h
            int 21h ;putcharr
            
            mov dl, num[5]
            
            mov ah, 2h
            int 21h ;putchar
            
            jmp @@break
    
@@case_Default:
            lea dx, msg3
            
            push ax
            mov ah, 9h ;imprimir cadena 
            int 21h
            pop ax
            
@@break:
     

        mov ah, 7h
        int 21h ;putchar
            
        mov ah, 4ch
        mov al, 0
        int 21h
        
    endp
	
	clrscr proc
        
        push ax
        mov ah, 0h
        mov al, 2h
        int 10h
        pop ax
    
    
    ret
    endp
    
    
end