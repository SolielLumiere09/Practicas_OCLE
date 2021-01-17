model small

.stack 100h

	include procs.inc 
	LOCALS

.data
	
	msg db "Adivina la tecla que estoy pensando",10,13,0
	msg2 db "la letra 'o' es la tecla que estaba pensando,  CORRECTO!!! ",10,13,0
	
.code 

	main proc
		mov ax, @data
		mov ds, ax
		
		call clrscr ;Limpiar pantalla
		
		lea dx, msg 
		
		
	@@do_While: ;Compara si el caracter introducido corresponde a la 'o' 
			
			call puts ;imprimir msgo
			call getch ;obtener un caracter y guardarlo en AL
			
			cmp al, 6fh ;comparar AL con el ASCII de la 'o'
			jnz @@do_While ;si AL no coincide con 'o' repite el ciclo 
			
			lea dx, msg2 
			call puts ;imprmir msg2 
			
			call getch 
			
		
		mov ah, 4ch
		mov al, 0
		int 21h
		
	endp
end
