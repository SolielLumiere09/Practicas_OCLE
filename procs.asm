dosseg

.model small
	
	LOCALS
	
.code

	public getchar
	public putchar
	public puts
	public clrscr
	public atoi
	public scanString
	public itoa
	public printNumber
	public getch
	public atoiParam
	public getParam
	public printSignedNumber

	
	
	clrscr proc ;limpiar pantalla
		push ax
		
		mov ah, 0
		mov al, 2h
		int 10h
		
		pop ax
	ret
	endp
	
	
	getchar proc; obtiene un caracter desde teclado y lo almacena en AL
		
		push bx
		mov bx, ax
		
		mov ah, 1h
		int 21h
		
		mov ah, bh
		
		pop bx
	ret
	endp
	
	putchar proc ;imprime un caracter contenido en AL
		
		push bx
		push dx
		
		
		mov bx, ax
		
		mov dl, al
		mov ah, 2h
		int 21h
		
		mov ah, bh
		
		pop dx
		pop bx
		
	ret
	endp
	
	puts proc ;imprime una cadena recibiendo su offset en BX
		
		push ax
		push bx
		
@@while:	cmp [bx], byte ptr 0
			je @@end_While
			
			mov al, [bx]
			call putchar
			inc bx
			jmp @@while
@@end_While:
		
		pop bx
		pop ax
		
	ret
	endp
	
   	atoi proc ;convierte una cadena apuntada por BX a numero y la almacena en AX
			
			push dx
			push cx
			push bx
			
			mov ax, 0
			mov dx, 0
			mov cx, 10

@@while:	cmp [bx], byte ptr 0
			je @@end_While
			mul cx
			mov cl, [bx]
			sub cl, 30h
			add ax, cx
			mov cx, 10 
			inc bx
			jmp @@while
			
@@end_While:
			mov [bx], byte ptr 0
            
            pop bx
            pop cx
            pop dx
			
	ret
	endp
	
	scanString proc ; Captura una cadena y la va almacenando donde apunta BX 
			
			push bx
			push ax
			
			call getchar ; retorna en AL el caracter capurado
@@while:	cmp al, 13d
			je @@end_While
			mov [bx], al
			inc bx
			call getchar
			jmp @@while
@@end_While:
			mov [bx], byte ptr 0
			
			pop ax
			pop bx
	ret
	endp
	
	itoa proc ;recibe en AX, lo convierte en cadena y lo almacena en una cadena puntada por BX 
		
		push ax
		push bx
		push cx
		push dx
		push si
		
		mov cx, 0
		mov si, 10
		
		mov dx, 0
		
@@do_while:	div si
			push dx
			mov dx, 0
			inc cx
			cmp ax, 0
			jne @@do_while
@@end_do_While:


@@nxt:	pop ax
		add al, 30h
		mov [bx], al
		inc bx
		loop @@nxt
		
		mov [bx], byte ptr 0
			
		pop si	
		pop dx
		pop cx
		pop bx
		pop ax
	ret
	endp
	
	printNumber proc ;imprime un numero contenido en AX 
		
		push ax
		push bx
		push cx
		push dx
		
		mov bx, 10
		mov cx, 0
		mov dx, 0
		
@@do_while: div bx
			push dx
			mov dx, 0
			inc cx
			cmp ax, word ptr 0
			jne @@do_while
@@end_do_While:

@@nxt:	pop ax
		add al, 30h
		call putchar
		
		loop @@nxt
		
		pop dx
		pop cx
		pop bx
		pop ax
		
	ret
	endp
		
	getch proc; Lectura de caracter sin eco
		
		push bx
		
		mov bx, ax
		
		mov ah, 8h
		int 21h
		
		mov ah, bh
		
		pop bx
		
	ret
	endp
	
	
	atoiParam proc; Convierte un parametro por linea de comando a numero y lo retorna en AX, se requiere DS como PSP 
		push dx
		push cx
		push bx
		
		mov ax, 0
		mov dx, 0
		mov cx, 10

@@while:	cmp [bx], byte ptr ' '
			je @@end_While
			cmp [bx], byte ptr 13
			je @@end_While
			mul cx
			mov cl, [bx]
			sub cl, 30h
			add ax, cx
			mov cx, 10 
			inc bx
			jmp @@while
		
@@end_While:
		
		pop bx
		pop cx
		pop dx
			
	ret
	endp
	
	getParam proc; retorna en AX el parametro por linea de comandos NUMERICO dado por cx
			
		push bx
		push si 
		push ds
		push cx
		
		
	    mov ah, 62h
		int 21h
		mov ds, bx
		
		mov bx, 80h
		
@@while:	cmp cx, 0
			je @@end_while
			
@@if:		cmp [bx], byte ptr ' '
			jne @@end_if
			dec cx
			
@@end_if:
			inc bx
			jmp @@while
@@end_while:
			
			call atoiParam
		
		pop cx
		pop ds
		pop si
		pop bx
	
	ret
	endp
	
	printSignedNumber proc; Recibe en AX el numero y se imprime con signo
		
		push ax
		
@@if:	cmp ax, 0
		jge @@else ;Es positivo
		
		push ax
		mov al, '-'; Es negativo
		call putchar
		pop ax
		
		neg ax
		call printNumber
		
		jmp @@end_if

@@else:	call printNumber
		
	
@@end_if:
		
		
		pop ax
	
	ret
	endp
	
	

end