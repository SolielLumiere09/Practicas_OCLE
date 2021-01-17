.model small

.stack 100h
	
	LOCALS
	include procs.inc
	
.data
	msg db "El cuadrado de 243 es = ", 0

.code
	
	main proc
	mov ax, @data
	mov ds, ax
	
	call clrscr
	
	lea bx, msg
	call puts; Imprimir mensaje
	
	mov ax, 243d
	mul ax ; DX:AX = AX * AX  
	
	call printNumber ;imprimir un numero contenido en AX
	
	mov ax, 4c00h
	int 21h
	endp
end