.model small

.stack 100h
	
	LOCALS
	include procs.inc
	
.data
	msg2 db "El cuadrado de ese numero es ", 0
	
	cad db 3 dup (0), 0
	
.code
	
	main proc
	mov ax, @data
	mov ds, ax
	
	call clrscr
	
	
	lea bx, msg2
	call puts;imprimir msg2
	
	mov cx, 1
	call getParam; Obtener el primer parametro de la linea de comandos
	mul ax;  obtener su cuadrado
	call printNumber; imprimir el numero

	mov ax, 4c00h
	int 21h
	endp
end