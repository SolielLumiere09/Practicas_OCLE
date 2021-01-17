.model small

.stack 100h
	
	LOCALS
	include procs.inc
	
.data
	
	number dw 65535
	buffer db 5 dup (?), 0
	
.code
	
	main proc
	mov ax, @data
	mov ds, ax
	
	call clrscr
	
	mov ax, [number]
	lea bx, buffer
	call itoa ; Convertir un numero en AX a cadena y almacenarlo donde apunta BX 
	call puts; imprimir la cadena Buffer que contiene al numero
	
	
	
	
	
	mov ax, 4c00h
	int 21h
	endp
end