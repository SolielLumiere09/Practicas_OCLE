.model small

.stack 100h
	
	include procs.inc 
	LOCALS
.data
	
	msg db 10,13,"Introduce un numero mayor o igual que ", 0
	msg0 db 10,13,0
	datoAnterior db 0
	
	
.code
	main proc
		mov ax, @data
		mov ds, ax
		
		call clrscr
		mov al, 30h ;copiar en AL el ASCII del numero 0 para poder imprimirlo 
		
		mov [datoAnterior], al
		lea dx, msg
		
		
	@@while_do: ;While para comparar que el numero introducido sea mayor o igual que el numero anterior introducido 
			cmp al, [datoAnterior] ;comparar numero actual introducido y el numero anterior introducido
			
			jb @@end_While_do ;si el numero introducido es menor que el anterior introducido, el ciclo termina 
			
			call puts ;imprimir msg
			call putchar ;imprimir caracter introducido
			
			lea dx, msg0
			call puts ;imprimir msg0
			
			lea dx, msg 
			
			mov [datoAnterior], al ;guardar el numero actual en datoAnterior
			call getchar ; Capturar un numero nuevo y guardarlo en AL 
			
			jmp @@while_do
			
	@@end_While_do:
		
	
	
		call getch 
		mov ah, 4ch
		mov al, 0
		int 21h
	endp
end