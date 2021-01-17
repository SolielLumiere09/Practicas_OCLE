.model small

.stack 100h
	
	LOCALS
	include procs.inc
	
.data
	msg db "Introduce un numero ", 0
	msg1 db "Es primo ", 0
	msg2 db "No es primo ", 0
	
	
	number dw ?
	buffer db 5 dup (?), 0

.code
	
	main proc
	mov ax, @data
	mov ds, ax
	
	call clrscr
	call capture; capturar datos 
	
	call prime; Procedimiento que retorna en AX un 1 si el numero es primo, 0 si no es primo 
	
@@if:	cmp ax, 0
		je @@else
		lea bx, msg1
		call puts; Para el caso que sea primo
		jmp @@end_if
		
@@else:	
		lea bx, msg2
		call puts; Para el caso que no sea primo
		

@@end_if:
	
	
	
	mov ax, 4c00h
	int 21h
	endp
	
	capture proc
	
		push ax
		push bx
		
		lea bx, msg 
		call puts ;imprimir mensaje 
		
		lea bx, buffer
		call scanString ;leer cadena desde teclado 
		call atoi ;convertirla a entero y almacenarla en AX 
		mov [number], ax ;Guardar AX 
		
		pop bx
		pop ax
		
	ret
	endp
	
	prime proc; Retorna en AX si es primo o no 
		
		mov ax, [number]
		mov bx, 2
		
@@while:	cmp bx, ax
			jae @@end1; si el numero es mayor que dos al hacer el ciclio, es primo 
			
			mov dx, 0
			div bx; Ir dividiendo el numero mientras sea mayor que 2 
			
@@if:		cmp dx, 0; Si el residuo es 0, no es primo
			je @@end0
			inc bx; Incrementar el divisor 
			mov ax, [number]
			jmp @@while
			
@@end_while:

@@end0:
		mov ax, 0; Si no es primo
		ret
		
@@end1:	
		mov ax, 1; si es primo
	ret
	endp
	
	
	
	
end