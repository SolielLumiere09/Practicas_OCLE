.model small


.stack 100h
    
    LOCALS
    

.data
    
    msg1 db "Ingresa un numero", 13, 10, '$'
    msg2 db 13,10,"El numero es ", '$'
    result db 3 dup(?), '$'
    


.code

    main proc

        mov ax, @data
        mov ds, ax
        
        call clrscr 
        lea bx, result
        
        lea dx, msg1
        
        push ax
        mov ah, 9h ;imprimir cadena 
        int 21h
        pop ax
        
        mov ah, 1h
        int 21h ;call getchar
        
        
        mov byte ptr [bx], al
        
        mov ah, 1h
        int 21h ;call getchar
        
@@if:   cmp al, 13   
        je @@end_if
        inc bx
        mov [bx], al
        
        mov ah, 1h
        int 21h ;call getchar
        
        
@@if_2: cmp al, 13
        je @@end_if
        inc bx
        mov [bx], al
    
@@end_if:
    
        lea dx, msg2
        
        push ax
        mov ah, 9h ;imprimir cadena 
        int 21h
        pop ax
        
        
        lea dx, result
        
        push ax
        mov ah, 9h ;imprimir cadena 
        int 21h
        pop ax
        
        
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