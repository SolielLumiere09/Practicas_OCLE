.model small

.stack 100h
	
	LOCALS
	include procs.inc
	
.data
	msg db "Introduce 3 numeros usando enter", 10, 13, 0
	msg1 db "El numero que es la suma de los otros dos es ", 0
	msg2 db "Ninguno es la suma de los otros dos ", 0
	
	buffer db 5 dup (?), 0
	
	n1 dw ?
	n2 dw ?
	n3 dw ?
	
.code
	
	main proc
	mov ax, @data
	mov ds, ax
	
	call clrscr
	
	call capture; capturar datos
	call compareNumbers; comparar numeros 
	
	
	
	mov ax, 4c00h
	int 21h
	endp
	
	capture proc ;capturar datos 
		
		push ax
		push bx
		
		lea bx, msg 
		call puts ; Imprimir msg 
		
		lea bx, buffer
		call scanString ;capturar un cadena de numeros en el buffer 
		call atoi ;convertirla a entero 
		mov [n1], ax ;guardar el primer numero 
		
		call scanString; Leer segundo numero 
		call atoi; Convertirlo a numero 
		mov [n2], ax ;Guardar el segundo numero 
		
		call scanString; Leer tercer numero 
		call atoi; convertirlo a numero 
		mov [n3], ax ;guardar el tercer numero
		
		pop bx
		pop ax
		
	ret
	endp
	
	compareNumbers proc ;realizar las comparaciones de los numeros 
		
		;Para el caso de n1 = n2 + n3
		mov cx, [n1]
		mov ax, [n2]; n2 + n3
		add ax, [n3]
		
		lea bx, msg1
		
@@if_n1:	cmp cx, ax
			jne @@else_n1
			mov ax, cx
			call puts 
			call printNumber
			jmp @@end_if_n1
@@else_n1:	
			;Para el caso de n2 = n1 + n3
			mov cx, [n2]
			mov ax, [n1]
			add ax, [n3]
		
@@if_n2:	cmp cx, ax
			jne @@else_n2
			mov ax, cx
			call puts 
			call printNumber
			jmp @@end_if_n2
@@else_n2:				
			
		;Para el caso de n3 = n2 + n1
			mov cx, [n3]
			mov ax, [n1]
			add ax, [n2]
		
@@if_n3:	cmp cx, ax
			jne @@else_n3
			mov ax, cx
			call puts 
			call printNumber
			jmp @@end_if_n3
			
@@else_n3:	lea bx, msg2
			call puts

@@end_if_n3:
		
			

@@end_if_n2:
			

			
@@end_if_n1:
		

@@end:
	ret
	endp
	
	
	
end