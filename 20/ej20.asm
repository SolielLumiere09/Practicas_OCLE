.model small

.stack 100h
	
	LOCALS
	include procs.inc
	
.data
	
	msg db "Introduzca enteros", 10, 13, 0
	msg2 db 10, 13,"El promedio es ", 0
	msg3 db 10, 13, "El Minimo es ",0
	msg4 db 10, 13,"El Maximo es ",0
	msg5 db "Los elementos en el arreglo son ", 10, 13, 0
	
	
	
	buffer db 5 dup (?), 0
	array dw 20 dup (?), 0
	tam dw 0
	
	

.code
	
	main proc
	mov ax, @data
	mov ds, ax
	
	call clrscr
	
	call capture ; capturar elementos
	
	call clrscr
	
	lea bx, msg5
	call puts ; imprimir msg5
	
	lea bx, array
	call printArray ; Imprimir arreglo 
	
	call promedio; calcular promedio e imprimirlo
	
	call MIN ; calcular valor minimo del arreglo e imprimirlo
	
	call MAX ; calcular valor maximo del arreglo e imprimirlo 
	
	mov ax, 4c00h
	int 21h
	endp
	
	
	capture proc; Capturar datos 
		
		push ax
		push bx
		push si
		
		lea bx, msg
		call puts ; imprimir mensaje 
		lea si, array
@@do_while:	
			lea bx, buffer
			call scanString
			call atoi
			mov [si], ax
			add si, 2
			inc word ptr [tam]
			cmp ax, word ptr 0
			jne @@do_while
			
			dec word ptr [tam]
			
		pop si
		pop bx
		pop ax
		
	ret
	endp
	
	printArray proc ; LLega en BX el offset del arreglo y lo imprime en pantalla
			
			push ax
			push bx
		
@@while:	cmp [bx], word ptr 0
			je @@end_while
			mov ax, [bx]
			call printNumber
			mov al, ' '
			call putchar
			add bx, 2
			jmp @@while
			
@@end_while:
			
			pop bx
			pop ax
	
	ret
	endp
	
	promedio proc; recibe en bx el offset de array, calcula el promedio y lo muestra en pantalla 
		
		push ax
		push bx
		push cx
		push dx
		
		mov cx, [tam]
		mov ax, 0
		
@@nxt:	add ax, [bx]
		add bx, 2; Este ciclio realiza la suma de todos los elementos del array 
		loop @@nxt
		
		mov dx, 0
		div word ptr [tam] ; division entre el tamaño total
		lea bx, msg2
		call puts
		call printNumber
		
		pop dx
		pop cx
		pop bx
		pop ax
		
		
	ret
	endp
	
	MIN proc ; Procedimiento para calcular numero menor del arreglo puntado por BX 
		
		push ax
		push bx
		push cx
		
		mov cx, [tam]
		mov ax, [bx]
		
@@nxt:	
		
@@if:	cmp ax, [bx]
		jbe @@end_if
		mov ax, [bx]
		

@@end_if:
		add bx, 2
		loop @@nxt
		
		lea bx, msg3
		call puts
		call printNumber
		
		pop cx
		pop bx 
		pop ax
	
	ret
	endp
	
	MAX proc ; Procedimiento para calcular numero menor del arreglo puntado por BX y lo imprime en pantalla
		
		push ax
		push bx
		push cx
		
		mov cx, [tam]
		mov ax, [bx]
		
@@nxt:	
		
@@if:	cmp ax, [bx]
		ja @@end_if
		mov ax, [bx]
		

@@end_if:
		add bx, 2
		loop @@nxt
		
		lea bx, msg4
		call puts
		call printNumber
		
		pop cx
		pop bx 
		pop ax
		
	
	ret
	endp
	
	
end