.model small

.stack 100h
	
	include procs.inc 
	LOCALS
	
.data
	msg0 db "Introduce un caracter", 10, 13, 0
	msg db "Es la vocal ", 0
	msg2 db "No es una vocal", 10, 13, 0
	salto db 10,13,0

.code
	
	main proc
		mov ax, @data
		mov ds, ax
		
		lea dx, msg0
		call puts ;imprimir msg0
		
		call getchar ;capturar un caracter y almacenarlo en AL
		lea dx, salto
		call puts ;imprimir salto 
		lea dx, msg
		
	;cases que determinan si el caracter es una vocal a,e,i,o,u
	@@Case_A: 
			cmp al, 'a' 
			jnz @@case_E ;salto si se cumple la condicion 
			call puts ;imprimir msg
			call putchar ;si el caracter en AL es una 'a'
			jmp @@break
			
	@@case_E:
			cmp al, 'e'
			jnz @@case_I   ;salto si se cumple la condicion 
			call puts ;imprimir msg
			call putchar ;si el caracter en AL es una 'e'
			jmp @@break
			
	@@case_I: 
			cmp al, 'i'
			jnz @@case_O  ;salto si se cumple la condicion 
			call puts ;imprimir msg
			call putchar ;si el caracter en AL es una 'i'
			jmp @@break
			
	@@case_O:
			cmp al, 'o'
			jnz @@case_U  ;salto si se cumple la condicion 
			call puts ;imprimir msg
			call putchar  ;si el caracter en AL es una 'o'
			jmp @@break
			
	@@case_U:
			cmp al, 'u'
			jnz @@default  ;salto si se cumple la condicion 
			call puts ;imprimir msg
			call putchar ;si el caracter en AL es una 'u'
			jmp @@break
			
	@@default:
			lea dx, msg2
			call puts ;si el caracter introducido no es una vocal
			
	@@break:

		mov ah, 4ch
		mov al, 0
		int 21h
	endp
end

