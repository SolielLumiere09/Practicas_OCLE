.model small

.stack 100h
	
	LOCALS
	include procs.inc
	
.data
	msg1 db "El perimetro es igual a ", 0
	msg2 db "El area es igual a  ", 0
	lado dw ?
.code
	
	main proc
	mov ax, @data
	mov ds, ax
	
	call clrscr 
	
	mov cx, 1
	call getParam; Obtener el primer parametro 
	mov [lado], ax; guardar el parametro 
	
	call perimeter; imprimir perimetro
	call area ; imprimir el area 
	
	mov ax, 4c00h
	int 21h
	endp
	
	
	perimeter proc ; calcular perimetro 
		
		push bx
		push ax
		
		mov ax, [lado]
		mov bx, 4
		mul bx
		lea bx, msg1
		call puts
		call printNumber; calcular e imprimir perimetro 
		mov al, 10
		call putchar
		mov al, 13
		call putchar 
		
		pop ax
		pop bx
		
	ret	
	endp
	
	area proc
		
		push ax
		push bx
		
		mov ax, [lado]
		mul ax
		
		lea bx, msg2
		call puts
		call printNumber ; Imprimir y calcular el area del cuadrado
		
		pop bx
		pop ax
	ret
	endp
	
	
end