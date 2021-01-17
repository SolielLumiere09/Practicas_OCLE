.model small


.stack 100h
	
	include procs.inc 
	LOCALS
	

.data
	msg db "Introduce dos letras MAYUSCULAS", 10, 13, 0
	salto db 10,13,0
	dato db ?

.code
	
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
		
@@if:	cmp [dato], al ;if(ah < al) -> else(ah >= al)
		jae @@else
			
		push ax
		mov al, [dato]
		call putchar
		pop ax
		call putchar
		jmp @@end_if

@@else:	call putchar
		mov al, [dato]
		call putchar
		@@end_if:
		
		
		mov ah, 4ch
		mov al, 0
		int 21h
		
	endp
	
	
end