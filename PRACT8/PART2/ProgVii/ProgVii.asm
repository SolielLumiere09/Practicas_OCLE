.model small


.stack 100h

    LOCALS
    

.data
    msg db "Introduce dos letras, una mayuscula y otra minuscula", 13, 10, 0
    datos db 2 dup (?)
    msg1 db "La letra mayuscula es ", 0
    msg2 db "La letra minuscula es ", 0
    salto db 10,13,0
    


.code
    .startup
    main proc
        mov ax, @data
        mov ds, ax
        
		call clrscr
		
        lea dx, msg
        call puts
        
        lea bx, datos
        
        call getchar
        mov [bx], al
        
        call getchar
        mov bx[1], al
        
        lea dx, salto
        call puts
        
        mov dl, 65
        mov cx, 25
@@for:
            
@@if:
                cmp [bx], dl
                jnz @@end_if
                mov dh, 1 ;dh si es 1 indica que el primer caracter es la mayuscula 
                jmp @@end_for       
                
@@end_if:
            
        inc dl   
        loop @@for
@@end_for:
        
        
@@if2:	cmp dh, 1
		jnz @@else2
		
		lea dx, salto
		call puts
		
		lea dx, msg1
		call puts
		
		mov al, [bx]
		call putchar
		
		lea dx, salto
		call puts
		
		
		lea dx, msg2
		call puts
		
		mov al, bx[1]
		call putchar
		
		jmp @@end_if2
            
@@else2:	
		lea dx, salto
		call puts
		
		lea dx, msg1
		call puts
		
		mov al, [bx + 1]
		call putchar
		
		lea dx, salto
		call puts
		
		lea dx, msg2
		call puts
		
		mov al, [bx]
		call putchar
		
        
@@end_if2:

        mov ah, 4ch
        mov al, 0
        int 21h
        
    endp
    
    
    puts proc
       
       push ax
       push bx
        
       mov bx, dx
       
@@while:	cmp byte ptr [bx], 0h
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