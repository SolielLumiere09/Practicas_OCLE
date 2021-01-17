.model small

.stack 100h
	
	LOCALS
	include procs.inc
	
.data
	numero db "65535", 0
	
.code
	
	main proc
	mov ax, @data
	mov ds, ax
	
	call clrscr
	lea bx, numero
	call atoi ; Transforma una cadena apuntada por BX a numero y la almacena en AX 
	call printNumber; Imprime un numero contenido en AX 

	
	
	
	mov ax, 4c00h
	int 21h
	endp
end