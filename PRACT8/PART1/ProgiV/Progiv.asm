.model small


.stack 100h
	
	include procs.inc 
	LOCALS
	
.data
	i dw 5
	j dw 5
	


.code
	
	main proc
		mov ax, @data
		mov ds, ax
		
		call clrscr
		mov cx, [i]
@@for_i:	push cx 
			mov cx, [j]	              ;for (i = 5; i >= 0; i--)
			
@@for_j:	mov al, '*'
			call putchar
			loop @@for_j
			
@@end_for_j:	mov al, 10
				call putchar
				pop cx 
		
	loop @@for_i
@@end_for_i:

		mov ah, 4ch
		mov al, 0
		int 21h
		
	endp
	
	
end