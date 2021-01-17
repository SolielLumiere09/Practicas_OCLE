.model small

.stack 100h
	
	LOCALS
	include procs.inc
	
.data
	msg db "Introduzca un numero ", 0
	msg1 db "Introduzca otro numero ", 0
	msg2 db "El maximo comun divisor es ", 0
	
	
	buffer db 5 dup (?), 0
	
	divisor dw ?
	dividendo dw ?

.code
	
	main proc
	mov ax, @data
	mov ds, ax
	
	call clrscr
	
	call capture; Capturar datos
	call MCM; Calcular maximo comun divisor 
	
	
	
	mov ax, 4c00h
	int 21h
	endp
	
	capture proc
		
		push ax
		push bx
		
		lea bx, msg 
		call puts; imprimir msg  
		
		lea bx, buffer
		call scanString; Lee cadena introducida por teclado
		call atoi ; convierte la cadena a numero y la almacena en AX 
		mov [dividendo], ax; Guarda el dividendo 
		
		lea bx, msg1
		call puts
		lea bx, buffer
		call scanString; ahora capturar el divisor
		call atoi ; se convierte a numero 
		mov [divisor], ax ; Guarda el divisor 
		
		pop bx
		pop ax
		
	ret
	endp
	
	MCM proc
		
		mov dx, 0
		mov ax, [dividendo]
		
@@do_while:
			mov dx, 0
			push [divisor]; guardar divisor
			div [divisor] ; AX cociente, DX residuo
			mov [divisor], dx; copiar nuevo divisor
			pop ax; recuperar divisor anterior para que sea el dividendo 
			cmp dx, word ptr 0
			jne @@do_while
@@end_do_while:
			; el resultado queda en AX
			
			lea bx, msg2
			call puts; imprimir msg2 
			call printNumber;imprimir maximo comun divisor

			
		
	
	ret
	endp
	
	
	
end