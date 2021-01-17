.model small

.stack 100h
	
	LOCALS
	include procs.inc
	
.data
	
	msg db "Introduzca la longitud del lado: ", 0
	msg1 db "El perimetro es igual a: ", 0
	msg2 db "El area es igual a: ", 0
	
	lado dw ?
	aux db 3 dup (?), 0
.code
	
	main proc
	mov ax, @data
	mov ds, ax
	
	call clrscr 
	
	call capture ; capturar lado del cuadrado y se queda en AX 
	call perimeter; imprimir perimetro
	call area ; imprimir el area 
	
	mov ax, 4c00h
	int 21h
	endp
	
	capture proc
		
		lea bx, msg
		call puts ; imprimir msg 
		lea bx, aux
		call scanString; capturar el lado y guardarlo en la variable aux como cadena
		call atoi ;me convierte la cadena capturada a valor en AX 
		mov [lado], ax
		
	ret
	endp
	
	perimeter proc ; calcular perimetro 
		
		push bx
		push ax
		
		mov ax, [lado]
		mov bx, 4
		mul bx; Multiplicar el lado x 4
		lea bx, msg1
		call puts; impriir msg1 
		call printNumber; calcular e imprimir perimetro 
		
		mov al, 10
		call putchar
		mov al, 13; Imprimir salto de linea 
		call putchar 
		
		pop ax
		pop bx
		
	ret	
	endp
	
	area proc
		
		push ax
		push bx
		
		mov ax, [lado]
		mul ax; Elevar lado al cuadrado 
		
		lea bx, msg2
		call puts;Imprimir msg2 
		call printNumber ; Imprimir y calcular el area del cuadrado
		
		pop bx
		pop ax
	ret
	endp
	
	
end