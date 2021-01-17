.model small


.stack 100h
    
.data
    
    msg db "Hola Mundo", 13, 10, '$'

.code
    .startup
    main proc
        mov ax, @data
        mov ds, ax
        
        call clrscr
        
        lea dx, msg
        push ax
        
        mov ah, 9h
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