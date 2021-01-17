.model small

.stack 100h
	
	LOCALS
	include procs.inc
	
.data
	
	msg db "Introduce cuatro numeros ",10, 13, 0
	msg1 db "El mayor de ellos es ", 0
	
	array dw 4 dup (?)
	buffer db 5 dup (?)
	
	salto db 10, 13
	
	i dw 0

.code
	
	main proc
	mov ax, @data
	mov ds, ax
	
	call clrscr
	
	call capture ; capturar datos 
	
	lea bx, array
	mov cx, 4
	
	mov ax, [bx]
	
@@nxt:	
		
@@if:	cmp ax, [bx]; Comparar cual de todos es el mayor 
		jae @@end_if
		mov ax, [bx]; si el numero actual es menor que el siguiente hacer swap
		
@@end_if:
		add bx, 2; sumo dos porque el arreglo es de tipo word 
		loop @@nxt; Repetir para recorrer el arreglo
	
		lea bx, msg1
		call puts; imprimir msg1
		call printNumber; imprimir mayor 
	
	
	
	mov ax, 4c00h
	int 21h
	endp
	
	capture proc
		
		push ax
		push bx
		push di
		
		lea di, array
		
		lea bx, msg
		call puts ;imprimir mensaje 
		
		
		call scanString ;capturar cadena de numeros
		call atoi; convertirlos decimal
		mov [di], ax ; Guardar el primer elemento en el arreglo 
		add di, 2 
		
		call scanString ;capturar cadena de numeros
		call atoi; convertirlos decimal
		mov [di], ax ; Guardar el segundo elemento en el arreglo
		add di, 2 
		
		call scanString ;capturar cadena de numeros
		call atoi; convertirlos decimal
		mov [di], ax ; Guardar el tercer elemento en el arreglo
		add di, 2 
		
		call scanString ;capturar cadena de numeros
		call atoi; convertirlos decimal
		mov [di], ax ;Guardar el cuarto elemento en el arreglo
		
		
		pop di
		pop bx
		pop ax
		
	ret
	endp
	
end