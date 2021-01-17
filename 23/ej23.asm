.model small

.stack 100h
	
	LOCALS
	include procs.inc
	
.data
	
	msg db "Rutina colocada con exito", 0


.code
	
	main proc
	mov ax, @data
	mov ds, ax
	
	call clrscr
	
	call getRSI
	
	
	mov ax, 4c00h
	int 21h
	endp
	
	setRSI proc; Llega en AX el vector, en BX el offset de la rutina y en DX el segmento de la RSI
		
		push ax
		push si; Guardar registros a utilizar
		push es
		
		push dx; guardar DX que contiene el segmento
		mov si, 4
		mul si; Multiplicar por 4 la posicion del vector
		pop dx; recuperar DX
		
		cli; No aceptar interrupciones
		mov si, ax; Para direccionar con SI en el vector 
		xor ax, ax
		mov es, ax; Poner en 0 ES para indicar el inicio del vector de interrupciones y direccionar 
		
		mov word ptr es:[si], bx; Poner el offset de la rutina en el vector 
		mov word ptr es:[si + 2], dx; Colocar el segmento en el vector, BX:DX queda colocada 
		sti; aceptar interrupciones
		
		pop es
		pop si; Recuperar registros 
		pop ax
	
	ret
	endp
	
	getRSI proc
		
		mov ax, 50h; La interrupcion será la 50h
		lea bx, myRSI; Pongo en bx el offset de mi interrupcion
		mov dx, cs; Pongo en DX el segmento de mi interrupcion
		call setRSI
		
		lea bx, msg
		int 50h; Ejecuto la interrupcion creada
		
		
	
	ret
	endp
	
	
	myRSI proc far; Por dar un ejemplo, llega en BX el offset de una cadena y la imprime 
		
		call puts
		
	iret
	endp
	
	
end