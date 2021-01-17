.model small

.stack 100h
	
	LOCALS
	include procs.inc
	
.data
	msg db "Introduzca los grados celsius: ", 0
	msg2 db "Esa cantidad en Fahrenheit es igual a: ", 0
	
	aux db 5 dup (?), 0
	
	salto db 10, 13, 0
.code
	
	main proc
	mov ax, @data
	mov ds, ax
	
	call clrscr
	
	lea bx, msg 
	call puts ; imprimir mensaje 
	
	lea bx, aux
	call scanString ; leer cadena y guardar el offset en BX 
	call atoi ; convertirla a numero y almacenarla en AX 
	
	mov dx, 0
	mov cx, 5
	mov bx, 9 
	; F = C * 9 / 5 + 32
	
	mul bx ; C * 9	
	div cx ; C * 9 / 5
	add ax, 32d; C * 9 / 5 + 32
	

	lea bx, msg2
	call puts ;Imprimir msg2 
	call printNumber; Imprimir numero en AX 
	
	
		
	
	mov ax, 4c00h
	int 21h
	endp
	
	
end