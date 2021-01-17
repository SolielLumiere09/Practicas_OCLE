.model small


.stack 100h
	
	include procs.inc 
	LOCALS
	

.data
	


.code
	
	main proc
		mov ax, @data
		mov ds, ax
		

		
		mov ah, 4ch
		mov al, 0
		int 21h
		
	endp
	
	
end