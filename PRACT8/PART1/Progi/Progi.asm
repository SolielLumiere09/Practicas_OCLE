.model small


.stack 100h
	
	include procs.inc 
	

.data
	
	msg db "Hola Mundo", 13, 10, 0

.code
	
	main proc
		mov ax, @data
		mov ds, ax
		
		call clrscr
		
		lea dx, msg
		call puts
		
		mov ah, 4ch
		mov al, 0
		int 21h
		
	endp
	
	
end