.model small


.stack 100h

    LOCALS
    

.data
    
    vaca db "vaca", 0
    perro db "perro", 0
    tigre db "tigre", 0
    lobo db "lobo", 0
    mono db "mono", 0
    msg db "Introduce un animal", 13, 10, 0
    cad db 10 dup (?), 10, 13, 0
    
    omtp1 db "La vaca dice MUU", 10, 13, 0
    omtp2 db "el Perro dice WOOF", 10, 13, 0
    omtp3 db "el tigre dice ROAR", 10, 13, 0
    omtp4 db "el lobo dice AUUU", 10, 13, 0
    omtp5 db "el mono dice UUHAHAH", 10, 13, 0
    
    flag db 0
    

.code
    .startup
    main proc
        mov ax, @data
        mov ds, ax
        
        call clrscr
        
        lea dx, msg 
        lea bx, cad
        
        call puts
        
@@do_while: call getchar 
@@if:       cmp al, 13  ;if(al != 13) else if(al == 13)
            je @@end_if
            mov byte ptr [bx], al
        
@@end_if:   inc bx
            cmp al, 13
            jne @@do_while ;do while(al != 13)
            
@@end_do_while: lea bx, cad
                lea di, vaca
                mov ah, 0

                call strcmp
        
@@if_1: cmp ah, 1
        jne @@end_if_1
        lea dx, omtp1
        call puts
        mov ah, 0
            
@@end_if_1: 
            lea bx, cad
            lea di, perro
            mov ah, 0

            call strcmp
        
@@if_2: cmp ah, 1
        jne @@end_if_2
        lea dx, omtp2
        call puts
        mov ah, 0
            
@@end_if_2: 
        lea bx, cad
        lea di, tigre
        mov ah, 0

        call strcmp
        
@@if_3: cmp ah, 1
        jne @@end_if_3
        lea dx, omtp3
        call puts
        mov ah, 0
        
@@end_if_3: 
        lea bx, cad
        lea di, lobo
        mov ah, 0

        call strcmp
        
@@if_4: cmp ah, 1
        jne @@end_if_4
        lea dx, omtp4
        call puts
        mov ah, 0
        
@@end_if_4:
        
        lea bx, cad
        lea di, mono
        mov ah, 0

        call strcmp
        
@@if_5: cmp ah, 1
        jne @@end_if_5
        lea dx, omtp5
        call puts
        mov ah, 0
            
@@end_if_5:
        

        mov ah, 4ch
        mov al, 0
        int 21h
        
    endp
    
    strcmp proc
                
        mov ah, 0       
@@while:    mov al, byte ptr [di]
            cmp [bx], al ;while (al == [bx])
            jne @@end_while
            
@@if:   cmp al, 0
        jne @@end_if
        mov ah, 1
        jmp @@end_while
        @@end_if:           
            
        inc bx
        inc di
        jmp @@while
@@end_while:

    ret
    endp
    
       puts proc
       
       push ax
       push bx
        
       mov bx, dx
       
       @@while:
            
            cmp byte ptr [bx], 0h
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
