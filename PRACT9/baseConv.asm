.model small

.stack 100h

	LOCALS

.data
    
    msg db "Introduce un numero: ", 0
	msg2 db "Introduzca la base de entrada: ", 0
	msg3 db "Introduzca la base de salida: ", 0
	msg4 db "El valor en la base de salida es -> ", 0
    strNumber db 16 dup (?), 0
	baseEntrada db 2 dup (?), 0
	baseFinal db 2 dup (?), 0

.code

    main proc

        mov ax, @data        
        mov ds, ax; inicializar segmento de datos DS 
        
        call clrscr ;limpiar pantalla
		
		lea bx, msg
		call puts
		
		lea bx, strNumber 
		call scanString ;Capturar una cadena introducida por el usuario y guardarla en strNumber
		
		lea bx, msg2
		call puts
		
		lea bx, baseEntrada
		call scanString; capturar una cadena introducida por el usuario y guardarla en baseEntrada
		
		lea bx, msg3
		call puts

		lea bx, baseFinal
		call scanString; capturar una cadena introducida por el usuario y guardarla en baseFinal
		
				
		lea bx, msg4
		call puts
		
		
		call changeBase; Procedimiento para convertir entre bases de numeros
		
		
        mov ax, 4c00h
        int 21h
    endp
    
	

	changeBase proc ;Procedimiento que Guarda en AX el valor a ser convertido, 
					;en BX la base final del numero y CX base de entrada del 
					;numero
		push ax
		push cx
		push bx ;Guardar registros que se utilizaran
		
		lea bx, baseFinal
		mov cx, 10
		call atoi; convertir la cadena baseFinal a Decimal y guardarla en AX
		push ax ; se guarda el valor decimal de baseFinal
		
		lea bx, baseEntrada
		call atoi; convertir la cadena baseEntrada a decimal y guardarla en AX
		
		mov cx, ax ; Se captura la baseEntrada en CX 
		
		lea bx, strNumber
		call atoi ;Se convierte la cadena strNumber a decinal basada en a la base introduida por el usuario en CX y se guarda en AX
		
		pop bx ; se Guarda el valor de la baseFinal en BX 

		mov cx, 0
		mov dx, 0
		
@@while:	cmp ax, bx ; ciclio para dividir el valor de AX entre BX hmientras AX sea mayor o igual que BX 
			jb @@end_while
			
			div bx
			push dx ; enviar residuo a la pila 
			mov dx, 0
			inc cx
			jmp @@while
			
@@end_while:
			inc cx
			push ax
			
@@next:		pop ax ; sacar el primer residuo de la pila, basandose en el principio LIFO


@@if:	cmp al, 10 ; Para saber si el residuo es mayor o igual a 10 en case de que la base de salida sea hexadecimal
		jb @@else
		
		add al, '7' ;en caso de que el residuo este entre 10-15
		jmp @@end_if
@@else:
		add al, '0' ; en caso de que el residuo este entre 0 - 9

@@end_if:
			call putchar; imprimir AL 
			loop @@next
			
		pop bx
		pop cx
		pop ax ; recuperar registros utilizados
		
			
	ret
	endp
	
	
	atoi proc ;recibe en BX la cadena y en CX la base original de la cadena (atoi(cadena, base)) retorna la cadena en decimal en AX
		
			
			mov ax, 0
			push dx
			push bx
			push cx
		
@@while:	cmp [bx], byte ptr 0
			jz @@end_while

@@if:		cmp [bx],  byte ptr 'A'
			jb @@else
			mul cx
			mov dx, ax
			mov ax, 0
			mov al, byte ptr [bx]
			cbw
			sub ax, word ptr '7'
			add dx, ax
			mov ax, dx
			jmp @@end_if
@@else:		
			mul cx
			mov dx, ax
			mov ax, 0
			mov al, byte ptr [bx]
			cbw
			sub ax, word ptr '0'
			add dx, ax
			mov ax, dx

@@end_if:	inc bx
			jmp @@while
			
@@end_while:



		
		pop cx
		pop bx
		pop dx
		
		
	ret
	endp
	
	
	scanString proc ;Procedimiento para que el usuario introduzca una cadena hasta que precione ENTER 
		
		push ax
		push bx
		
		call getchar
		
@@while:	cmp al, 13
			je @@end_while
			
			mov [bx], al
			call getchar
			inc bx
			jmp @@while
@@end_while:
			
		pop bx
		pop ax
		
	ret
	endp
	
	
	
	
   puts proc ;imprimir una cadena apuntada por BX y terminada en 0
       
       push ax
       push bx
       
@@while:	cmp byte ptr [bx], 0h
			je @@end_while
            
			mov al, byte ptr[bx] 
			call putchar
			inc bx
			jmp @@while
       
@@end_while:
       
       pop bx
       pop ax

    ret    
    endp
    
    
    
    clrscr proc
        
        push ax
        mov ah, 0h
        mov al, 2h
        int 10h
        pop ax
        
    ret
    endp
    
    
    
    putchar proc ;Imprimir un caracter
        
        push ax
        push dx
        
        mov dl, al
        mov ah, 2h
        int 21h
        
        pop dx
        pop ax

    ret    
    endp
    
    
    getchar proc; Obtener un caracter desde el teclado y retornarlo en AL 
        
        mov ah, 1h
        int 21h
        
    ret
    endp
    

	
	
end