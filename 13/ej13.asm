.model small

.stack 100h
	
	LOCALS
	include procs.inc
	
.data
	msg db "Introduzca la tarifa Horaria ", 0
	msg2 db "Introduzca las horas trabajdas ", 0
	msg3 db "El salario semanal es de ", 0
	
	buffer db 5 dup (?)
	tarifaHoraria dw ?
	horasTrabajadas dw ?


.code
	
	main proc
	mov ax, @data
	mov ds, ax
	
	call clrscr

	call capture; capturar datos
	
	call calculate
	
	mov ax, 4c00h
	int 21h
	endp
	
	capture proc
		
		push ax
		push bx
		
		lea bx, msg
		call puts
		
		lea bx, buffer
		call scanString; leer desde teclado 
		call atoi; convertir la cadena capturada a valor numerico 
		mov [tarifaHoraria], ax; Capturar tarifa Horaria
		
		lea bx, msg2
		call puts
		lea bx, buffer
		call scanString; leer desde teclado
		call atoi; convertir la cadena capturada a numero 
		mov [horasTrabajadas], ax; Capturar Horas trabajadas
		
		pop bx
		pop ax
		
	ret
	endp
	
	calculate proc
		
		push ax
		push bx
		push dx
		
		
		mov ax, [tarifaHoraria]
		mul word ptr [horasTrabajadas]
		mov bx, 7; AX = TarifaHoraria x HorasTrabajadas x 7
		mul bx
		
		lea bx, msg3
		call puts
		
		lea bx, buffer
		call itoa; Convertir AX a cadena numerica para imprimirla en pantalla
		call puts; imprimir resultado
		
		pop dx
		pop bx
		pop ax
		
	ret
	endp
	
	
end