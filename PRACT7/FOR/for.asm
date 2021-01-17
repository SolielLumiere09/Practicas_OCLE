.model small

.stack 100h
	
	include procs.inc
	LOCALS
	
.data

.code
	
	main proc
		
		mov ax, @data
		mov ds, ax
		
		mov al, 30h ;copiar el codigo ASCII del 0 al registro AL 
		
		mov cx, 10 ;cantidad de iteraciones a realizar
		
	@@for: ;for para imprmir los numeros del 0 al 9 en pantalla
			call putchar ;imprmir el caracter contenido en AL
			inc al; 
			loop @@for ;realizar el for hasta que CX llegue a 0 ya que loop primero decrementa y luego compara si CX = 0 
		
		call getch
		
		mov ah, 4ch
		mov al, 0
		int 21h
	
	endp
end