.model small

.stack 100h
	
	LOCALS
	include procs.inc
	
.data
	
	msg db "Introduzca la altura del cilindro ", 0
	msg1 db "Introduzca el radio de la base ", 0
	msg2 db "El area del cilindro es ", 0
	msg3 db "El Volumen del cilindro es ", 0
	
	
	aux db 3 dup(0), 0
	
	altura dw ?
	radio dw ?
	PI dw 3	
	
.code
	
	main proc
	mov ax, @data
	mov ds, ax
	
	call clrscr
	
	lea bx, msg 
	call puts 
	lea bx, aux
	call scanString; capturo la cadena 
	call atoi ; la convierto a numero  
	mov [altura], ax ; La altura se guarda en AX 
	
	lea bx, msg1 
	call puts 
	lea bx, aux
	call scanString; capturo la cadena 
	call atoi ; la convierto a numero 
	mov [radio], ax ; el radio se guarda en AX 
	
	;Area = 2 * PI * r * h + 2 * PI * r * r 
	
	mov ax, 2
	mul word ptr [PI]
	mul word ptr [radio]
	mul word ptr [altura] ; Area lateral calculada en AX 
	
	mov bx, ax 
	
	mov ax, 2 
	mul word ptr [PI]
	mul word ptr [radio]
	mul word ptr [radio] ; Area de las dos bases calculada en AX 
	
	;sumar area lateral y area de las dos bases 
	
	add ax, bx 
	
	lea bx, msg2
	call puts
	call printNumber; imprimir area total
	
	push ax
	mov al, 13
	call putchar; Este bloque de codigo es para imprimir un salto de linea 
	mov al, 10
	call putchar
	pop ax
	
	;V = PI * r * r * h
	mov ax, 1
	mul word ptr [PI]
	mul word ptr [radio]
	mul word ptr [radio]
	mul word ptr [altura]
	
	
	
	lea bx, msg3
	call puts
	call printNumber ; Imprimir Volumen 
	
	mov ax, 4c00h
	int 21h
	endp
end