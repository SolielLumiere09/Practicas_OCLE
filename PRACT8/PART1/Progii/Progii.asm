.model small


.stack 100h
    
    include procs.inc 
    LOCALS
    

.data
    
    msg1 db "Ingresa un numero", 13, 10, 0
    msg2 db 13,10,"El numero es ", 0
    result db 3 dup(?), 0
    


.code
    
    main proc
        mov ax, @data
        mov ds, ax
        
        call clrscr 
        lea bx, result
        
        lea dx, msg1
        call puts
        
        call getchar
        mov [bx], al
        
        call getchar
        

@@if:	cmp al, 13 ;  
        je @@end_if
        inc bx
        mov [bx], al
        
        call getchar
@@if_2:	cmp al, 13
        je @@end_if
        inc bx
        mov [bx], al
    
@@end_if:
    
        lea dx, msg2
        call puts
        lea dx, result
        call puts
        
        
        mov ah, 4ch
        mov al, 0
        int 21h
        
    endp
    
    
end