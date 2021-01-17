.model small

.stack 100h
	
	LOCALS
	include procs.inc
	
.data
	msg db "Introduzca un numero ", 10, 13, 0
	msg2 db "El cuadrado de ese numero es ", 0
	
	cad db 3 dup (0), 0
	
.code
	
	main proc
	mov ax, @data
	mov ds, ax
	
	call clrscr; limpiar pantalla
	
	lea bx, msg
	call puts ;imprimir msg
	
	lea bx, cad
	call scanString ;Lee una cadena desde teclado y la almacena en donde apunta BX
	call atoi ; me regresa en AX la cadena capturada convertida en numero 
	mul ax
	
	lea bx, msg2
	call puts;imprimir msg2
	
	call printNumber;imprime el numero contendi en AX
	
	
	
	
	mov ax, 4c00h
	int 21h
	endp
end