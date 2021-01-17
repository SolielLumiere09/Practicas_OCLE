.model small


.stack 100h
    
    LOCALS
    

.data
    msg db "Introduce dos letras MAYUSCULAS", 10, 13, 0
    salto db 10,13,0
    dato db ?

.code
    .startup
    main proc
        mov ax, @data
        mov ds, ax
        
        call clrscr
        
        lea dx, msg
        call puts
        
        call getchar
        mov [dato], al
        call getchar
        
        lea dx, salto
        call puts
        
@@if:   cmp [dato], al ;if(ah < al) -> else(ah >= al)
        jae @@else
        
        push ax
        mov al, [dato]
        call putchar
        pop ax
        call putchar
        jmp @@end_if

@@else:     call putchar
            mov al, [dato]
            call putchar

@@end_if:
        
        
        mov ah, 4ch
        mov al, 0
        int 21h
        
    endp
    
puts proc
       
       push ax
       push bx
        
       mov bx, dx
       
@@while:    cmp byte ptr [bx], 0h
            je @@end_while
            
            mov al, byte ptr[bx] 
            mov ah, 0eh
            int 10h
            inc bx
            jmp @@while
       
       
@@end_while:
        pop bx
        pop ax
        
        ret    
	endp
    
    
    getchar proc
    
        push bp
        push ax
        mov bp, sp
        
        mov ah, 1h
        int 21h
        
        mov ah, [bp + 1]
        pop bp
        pop bp

    ret    
    endp 
    
    putchar proc
        
         push ax
         
         mov ah, 0eh
         int 10h
         
         pop ax
    
    
    ret    
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
   