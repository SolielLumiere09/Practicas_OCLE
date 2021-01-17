.model small


.stack 100h
	
	include procs.inc 
	LOCALS
	

.data
	msg db "Introduce dos letras, una mayuscula y otra minuscula", 13, 10, 0
	datos db 2 dup (?)
	msg1 db "La letra mayuscula es ", 0
	msg2 db "La letra minuscula es ", 0
	salto db 10,13,0
	


.code
	
	main proc
		mov ax, @data
		mov ds, ax
		
		call clrscr
		
		lea dx, msg
		call puts
		
		lea bx, datos
		
		call getchar
		mov byte ptr [bx], al
		
		call getchar
		mov byte ptr bx[1], al
		
		lea dx, salto
		call puts
		
		mov dl, 65
		mov cx, 25
@@for:
			
@@if:	cmp byte ptr [bx], dl
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
			
		mov al, byte ptr [bx]
		call putchar
			
		lea dx, salto
		call puts
		
			
		lea dx, msg2
		call puts
			
		mov al, byte ptr bx[1]
		call putchar
		
		jmp @@end_if2
			
@@else2:	lea dx, salto
			call puts
			
			lea dx, msg1
			call puts
			
			mov al, byte ptr [bx + 1]
			call putchar
			
			lea dx, salto
			call puts
			
			lea dx, msg2
			call puts
			
			mov al, byte ptr [bx]
			call putchar
			
		
@@end_if2:
		
		
		
		mov ah, 4ch
		mov al, 0
		int 21h
		
	endp
	
	
end