.model small


.stack 100h
    
    LOCALS
    

.data
    


.code
    .startup
    main proc
        mov ax, @data
        mov ds, ax
        
		call clrscr
		
        mov cx, 9
        mov bx, 1
        
@@for_i:
            push cx
@@if:	cmp cx, 5
		jbe @@else
		mov cx, bx
		
@@for_j:	mov dl, '*'
			mov ah, 2h
			int 21h
			loop @@for_j
			inc bx	
			jmp @@end_if
			
@@else:	mov cx, bx
		@@for_j2:
                    
		mov dl, '*'
		mov ah, 2h
		int 21h
                    
                    
		loop @@for_j2
		dec bx
            
@@end_if:	
			mov dl, 10
            mov ah, 2h
            int 21h
            
            pop cx
        loop @@for_i
        


        
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