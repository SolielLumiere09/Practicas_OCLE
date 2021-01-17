.model small

.stack 100h
	
	LOCALS
	include procs.inc
	
.data
	
	msg db "Introduzca una palabra", 10, 13, 0
	msg1 db "Es palindroma", 10, 13, 0
	msg2 db "No es palindroma", 10, 13, 0
	
	buffer db 30 dup (?)


.code
	
	main proc
	mov ax, @data
	mov ds, ax
	
	call clrscr
	
	lea bx, msg 
	call puts; imprimir msg 
	lea bx, buffer
	call scanString; Capturar cadena en Buffer 
	
	call palindrome; Retorna en AX 1 si es palindroma, 0 si no lo es 
	
@@if:	cmp ax, 0
		je @@else
		lea bx, msg1
		call puts
		jmp @@endif
		
@@else:	
		lea bx, msg2
		call puts

@@endif:
	
	mov ax, 4c00h
	int 21h
	endp
	
	palindrome proc; Retorna AX = 1 si la palabra apuntada por BX es palindromo
 		
			
		push bx
		push di
		push dx
			
			
			push bx
@@while:	cmp [bx], byte ptr 0 ;calcular longitud de cadena y tenerla en CX
			je @@endWhile
			inc bx
			jmp @@while
			
@@endWhile:
			mov di, bx; di contiene el final de la cadena
			sub di, 1; Menos 1 por el fin de cadena
			pop bx ;bx contiene el inicio de la cadena 
			
@@while2:	cmp bx, di
			jae @@ret1
		
			mov dl, [bx]; para poder comparar guardo en dl el caracter temporalmente
			
@@if:		cmp dl, [di]	
			jne @@ret0
			inc bx ; comparando el inicio con el final 
			dec di
@@end_if:
			jmp @@while2

@@endWhile2:

@@ret0:
		pop dx
		pop di
		pop bx
		mov ax, 0
		ret
		
@@ret1:

		pop dx
		pop di
		pop bx
		
		mov ax, 1
	
	ret
	endp
	
	
	
end