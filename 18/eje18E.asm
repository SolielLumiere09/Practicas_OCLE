.model small

.stack 100h
	
	LOCALS
	include procs.inc
	
.data
	
	msg1 db "Es palindroma", 10, 13, 0
	msg2 db "No es palindroma", 10, 13, 0
	
	buffer db 30 dup (?)

	
.code
	
	main proc
	mov ax, @data
	mov ds, ax
	
	call clrscr
	
	lea si, buffer
	call getCadParam; Obtener cadena 
	
	lea bx, buffer; 
	call palindrome; Verificar si es palindroma 
	
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

	getCadParam proc; Obtener la cadena que esta en el parametro por linea de comando 
		
		push bx
		push ax
		push si
		push es
		
		mov ah, 62h
		int 21h
		mov es, bx
		
		mov bx, 82h

		
@@while:	cmp es: [bx], byte ptr 13; Fin de la linea de parametros 
			je @@end_While
			
			mov al, es : [bx]	
			mov [si], al; Ir copiando caracter por caracter en buffer 
			
			inc bx
			inc si
			jmp @@while
			
@@end_While:
			
			mov [si], byte ptr 0
			
		pop es
		pop si
		pop ax
		pop bx
		
	
	endp
	
	
	
end