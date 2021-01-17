.model small

.stack 100h

	include procs.inc
	LOCALS
.data
	
	msg1 db "Introduzca dos numeros", 10, 13, 0
	msg2 db 10,13, "El mayor es ", 0
	salto db 10,13,0
	dato db ?

.code
	
	main proc
		mov ax, @data ;inicializar segmento de datos DS
		mov ds, ax
		
		call clrscr ;limpiar pantalla
		
		lea dx, msg1
		call puts ;imprimir msg1
		
		call getchar ;obtener un caracter desde teclado y guardarlo en AL
		mov [dato], al ;copiar el caracter capturado a la variable dato
		
		lea dx, salto
		call puts ;imprimir un salto de linea
		
		call getchar ;obtener otro caracter desde teclado
		lea dx, msg2;
		
	@@if:	cmp [dato], al ;comparar cual numero es mayor
			jb @@else ;si 'dato' es menor, pasa al @@else, caso contrario continua
			
			mov al, [dato] ;copiar 'dato' al regitro AL ya que es el mayor 
			call puts ;imprimir msg2
			call putchar ;imprimir caracter o valor contenido en AL
			jmp @@end_if ;terminar if
			
			
	@@else:
			call puts ;imprimir msg2
			call putchar;imprimir el valor del registro AL ya que es el mayor
			
	@@end_if:
	
		call getch
		
		mov ah, 4ch
		mov al, 0 ;finalizar programa
		int 21h
	endp
end