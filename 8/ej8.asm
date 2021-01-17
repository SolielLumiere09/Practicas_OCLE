.model small

.stack 100h
	
	LOCALS
	include procs.inc
	
.data
	msg db 10, 13, "El numero de caracteres introducidos fue ", 0


.code
	
	main proc
	mov ax, @data
	mov ds, ax
	
	call clrscr
	mov bx, 0
	
			call getch; Lectura de caracter sin eco
@@while:	cmp al, byte ptr 30h; el ciclio termina si se introduce un 0
			je @@end_while
			call putchar; Imprimir caracter si no es un '0'
			call getch; Retorna en AL el caracter leido
			inc bx
			jmp @@while
@@end_While:

		mov ax, bx
		
		lea bx, msg
		call puts; imprimir mensaje
		call printNumber; imprimir numero de caracteres leidos
		
	
	
	mov ax, 4c00h
	int 21h
	endp
end