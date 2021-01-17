.model small


.stack 100h
    
    LOCALS
    
.data
    i dw 5
    j dw 5
    


.code
    .startup
    
    main proc
        mov ax, @data
        mov ds, ax
        
        call clrscr
       
        mov cx, [i]
@@for_i:              ;for (i = 5; i >= 0; i--)
        
        push cx 
        mov cx, [j]
        
@@for_j:    mov dl, '*'
            
            mov ah, 2h
            int 21h ;putchar
            
            loop @@for_j
            
@@end_for_j:
        mov dl, 10
        
        mov ah, 2h
        int 21h ;putchar
        
        pop cx 
        
    loop @@for_i
	
@@end_for_i:
    
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