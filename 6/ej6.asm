.model small

.stack 100h
	
	LOCALS
	include procs.inc
	
.data
	msg db "Introduzca la cantidad de metros ", 0
	msg1 db "El pulgadas son ", 0
	msg2 db "En pies son ", 0
	
	metros dw ?
	
	buffer db 5 dup (?), 0
	salto db 10, 13, 0

.code
	
	main proc
	mov ax, @data
	mov ds, ax
	
	call clrscr
		
	call capture; Capturar datos
	call calculate; Calcular datos 
	
	
	
	mov ax, 4c00h
	int 21h
	endp
	
	capture proc; capturar datos 
		push bx
		push ax 
		
		lea bx, msg 
		call puts; Imprimir msg 
		
		lea bx, buffer
		call scanString ; capturar cadena en buffer
		call atoi ; convertri esa cadena a numero y guardarla en AX 
		mov [metros], ax; guardar en metros el dato 
		
		pop ax
		pop bx 
	ret
	endp
	
	calculate proc
		
		mov ax, [metros]
		mov bx, 39 
					; 1m = 39 pulg 
					; [metros] = x 
					; x = [metros] * 39
		mul bx 
		; AX contiene la cantidad de metros en pulgadas 
		
		lea bx, msg1
		call puts ; imprimir msg1
		call printNumber; Imprime el contenido de AX
		; AX esta en pulgadas 
		
		
		mov dx, 0
		mov bx, 12; 1ft = 12 inch 
					;X = [AX]
					; X = [AX] / 12
		div bx ; Ahora AX esta en pies 
		
		lea bx, salto
		call puts; Imprimir un salto de linea 
	
		lea bx, msg2
		call puts; imprimir msg2
		call printNumber; imprimir numero contenido en AX 
		
	ret
	endp
	
	
	
end