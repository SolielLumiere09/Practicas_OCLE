.model small

.stack 100h
	
	LOCALS
	include procs.inc
	
.data

	msg1 db "Es primo ", 0
	msg2 db "No es primo ", 0
	
	
	number dw ?

.code
	
	main proc
	mov ax, @data
	mov ds, ax
	
	call clrscr
	
	mov cx, 1
	call getParam; Obtener el primer parametro que llega y almacenarlo en AX
	mov [number], ax; Guardar el parametro 
	
	call prime
	
@@if:	cmp ax, 0
		je @@else
		lea bx, msg1
		call puts
		jmp @@end_if
		
@@else:	
		lea bx, msg2
		call puts
		

@@end_if:
	
	
	
	mov ax, 4c00h
	int 21h
	endp
	
	
	prime proc; Retorna en AX si es primo o no 
		
		mov ax, [number]
		mov bx, 2
		
@@while:	cmp bx, ax
			jae @@end1
			
			mov dx, 0
			div bx
			
@@if:		cmp dx, 0
			je @@end0
			inc bx
			mov ax, [number]
			jmp @@while
			
@@end_while:

@@end0:
		mov ax, 0
		ret
		
@@end1:	
		mov ax, 1
	ret
	endp
	
	
	
	
end