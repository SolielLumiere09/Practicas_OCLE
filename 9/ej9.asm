.model small

.stack 100h
	
	LOCALS
	include procs.inc
	
.data
	
	i dw 3
	space db " ", 0
	msg db 10, 13, "La suma es igual a ", 0


.code
	
	main proc
	mov ax, @data
	mov ds, ax
	
	call clrscr
	mov ax, 0
	lea bx, space
	mov cx, 0 
		
@@for_i:	cmp [i], word ptr 99
			ja @@end_for_i
			
			add ax, word ptr 3; 
			add cx, ax
			call printNumber; Ir imprimiendo de 3 en 3
			call puts; Imprimir espacio 
						
			
			
@@inc_i:	add [i], word ptr 3
			jmp @@for_i

@@end_for_i:

	lea bx, msg
	call puts ; imprmir msg 
	
	mov ax, cx
	call printNumber; Imprimir suma total



	
	
	
	mov ax, 4c00h
	int 21h
	endp
end