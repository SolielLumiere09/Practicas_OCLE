.model small

.stack 100h
	
	LOCALS
	include procs.inc
	
.data
	
	msg db 10, 13, "Hola mundo", 0
	char db '@'


.code
	
	main proc
	mov ax, @data
	mov ds, ax
	xor ax, ax
	
	call clrscr
	push es
	
	mov es, ax; numero de interrupcion x 4, 80h x 4 = 200h 
	mov word ptr es:[200h], offset INT80h;Se guarda el offset de la interrupcion
	mov word ptr es:[202h], cs;guardando segmento, Creando Interrupcion y colocandola en el vector de interrupcion 0000:0000 con CS
	pop es
	
	
	mov al, char
	mov ah, 1; Imprimir caracter usando la interrupcion creada
	int 80h
	
	
	
	lea bx, msg; Imprimir cadena apuntada por bx con la interrupcion creada
	mov ah, 2
	int 80h
	
	mov ax, 4c00h
	int 21h
	endp
	
	INT80h proc far; Definicion de la interrupcion
	
		push ax
		push dx
		
@@if:	cmp ah, 1
		jne @@else_if
		mov dl, al
		mov ah, 2h
		int 21h
		jmp @@end_if
		
@@else_if:	cmp ah, 2
			jne @@end_if
			call puts
@@end_if:


		pop dx
		pop ax
	iret
	endp
	
end