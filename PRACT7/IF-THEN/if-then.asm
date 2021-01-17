.model small

.stack 100h

	include procs.inc
	LOCALS
.data
	
	msg1 db "Introduce un numero ",10,13,0
	msg2 db 10,13,"Es el numero que estaba pensando", 10,13,0

.code
	
	main proc
		mov ax, @data ;inicializar segmento de datos DS
		mov ds, ax
		
		call clrscr ;limpiar pantalla
		
		lea dx, msg1
		call puts; imprime msg1 
			
		call getchar ;capturar un caracter y se guarda en AL
			
	@@if:cmp al, 39h ;compara el caracter capturado con el ASCII 39h que es el numeor 9 
			 jnz @@then ;si no son iguales no se hace el if
			 
			 lea dx, msg2 
			 call puts ;si el caracter introducido coincide con 39h se imprime un mensaje 
	@@then:
		
	call getch
		
	mov ah, 4ch
	mov al, 0 ;finalizar programa
	int 21h
	endp
end