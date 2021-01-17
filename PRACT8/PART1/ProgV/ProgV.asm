.model small


.stack 100h
	
	include procs.inc 
	LOCALS
	

.data
	


.code
	
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
		
@@for_j:	mov al, '*'
			call putchar
			loop @@for_j
			inc bx
			jmp @@end_if
				
@@else:	mov cx, bx

@@for_j2:	mov al, '*'
			call putchar
			loop @@for_j2
			dec bx
			
@@end_if:	mov al, 10
			call putchar
			pop cx
			loop @@for_i
		


		
		mov ah, 4ch
		mov al, 0
		int 21h
		
	endp
	
	
end