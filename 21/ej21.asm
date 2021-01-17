.model small

.stack 100h
	
	LOCALS
	include procs.inc

	
	
.data
	
	M1 dw 12 dup (?); 4 x 3
	M2 dw 12 dup (?); 3 x 4
	M3 dw 16 dup (?)
	
	buffer db 5 dup (?)
	temp db 0
	
	msg1 db "Introduzca los datos de la matriz 4 x 3", 10, 13, 0
	msg2 db "Introduzca los datos de la matriz 3 x 4", 10, 13, 0
	
	i dw 0
	j dw 0
	k dw 0
	
	

.code
	
	main proc
	mov ax, @data
	mov ds, ax
	
	call clrscr
	
	lea bx, msg1
	call puts
	lea bx, M1
	mov cx, 4
	mov dx, 3
	call captureM
	
	call clrscr
	
	lea bx, msg2
	call puts
	lea bx, M2
	mov cx, 3
	mov dx, 4
	call captureM
	
	call multiplyM
	
	call clrscr
	lea bx, M3
	mov cx,  4
	mov dx,  4
	call printM
	
	
	
	mov ax, 4c00h
	int 21h
	endp
	

	
	multiplyM proc; multiplicar las matrices para dar una resultante de 4x4 en M3
		
;BX = M1, SI = M2, DI = M3
		
		push bp
		mov bp, sp; Protocolo de entrada
		
		
		mov bx, [bp + 4]; Recibo la direccion de M1
		mov si, [bp + 6]; Recibo la direccion de M2
		mov di, [bp + 8]; Recibo la direccion de M3
		
		
		mov ax, 0
		push di; [bp + 10] = di
		push si; [bp + 8] = si
		push ax; [bp + 6] = sum
		push ax; [bp + 4] = k
		push ax; [bp + 2] = j
		push ax; [bp] = i  
		mov bp, sp ; Para direccionar entre las variables en la pila 
		
		
@@for_i:	cmp [bp], word ptr 3
			jae @@end_for_i
			
			mov [bp + 2], word ptr 0
@@for_j:	cmp [bp + 2], word ptr 3
			jae @@end_for_j
			
			mov [bp + 4], word ptr 0
@@for_k:	cmp [bp + 4], word ptr 2
			jae @@end_for_k
			
			;Obtener indice; index = file * MAX_COLUMNS + column 
			push di; se requiere por la tercera matriz [bp - 2]
			;para M1[i][k]
			mov ax, [bp]; i
			mov cx, 3; Maximo de columnas 
			mul cx ; Multiplica por MAX_COLUMNS
			add ax, [bp + 4]; sumale el indice k
			mov cx, 2
			mul cx; multiplica por dos por el tipo de dato
			mov di, ax
			mov ax, [bx + di]; Accedo al elemento de la matriz
			push ax; Guardo M1[i][k], ese elemento está en [bp - 4]
			
			
			;Para M2[k][j]
			push bx; Guardar BX
			mov ax, [bp + 4]; k
			mov cx, 3; Maximo de columnas 
			mul cx ; Multiplica por MAX_COLUMNS
			add ax, [bp + 2]; sumale el indice j
			mov cx, 2
			mul cx; multiplica por dos por el tipo de dato
			mov bx, ax
			mov ax, [si + bx]; Accedo al elemento de la matriz
			;AX = M2[k][j]
			pop bx; Recupero BX
			
			mul word ptr [bp - 4]; AX = M1[i][k] * M2[k][j]
			add [bp + 6], ax; SUM = SUM + AX
			
			pop ax; Sacar el dato de la pila 
			pop di; Recupero di 
			
			inc word ptr [bp + 4]
			jmp @@for_k
@@end_for_k:
			;para M3[i][j]
			mov ax, [bp]; i
			mov cx, 3; Maximo de columnas 
			mul cx ; Multiplica por MAX_COLUMNS
			add ax, [bp + 2]; sumale el indice j
			mov cx, 2
			mul cx; multiplica por dos por el tipo de dato
			
			push bx; Guardo BX por M1
			
			mov bx, ax; para direccionar con el indice
			mov ax, [bp + 6]
			mov [di + bx], ax; Accedo al elemento de la matriz
			mov [bp + 6], word ptr 0
			
			pop bx; Recupero BX para M1
			
			inc word ptr [bp + 2]
			jmp @@for_j
@@end_for_j:
			
			inc word ptr [bp]
			jmp @@for_i
@@end_for_i:			
			
		pop bp; quito  i de la pila 	
		pop bp; quito  j de la pila 
		pop bp; quito k de la pila	
		pop bp; quito sum de la pila 
		pop si; Recupero si
		pop di; recupero di 

		
		pop bp; protocolo de salida		
		ret
		endp
	
	
	
	printM proc; recibe en BX el offset de la matriz, en CX las filas y en DX las columnas y la imprime 
			
			push si
			push ax
			push bx
			push cx
			push dx
			
@@for_i:	cmp [i], cx
			jae @@end_for_i
			
			mov [j], 0
@@for_j:	cmp [j], dx
			jae @@end_for_j
			
			push dx
			
			mov ax, [i]; Indice = renglon * MAX_COlUMNAS + columa 
			mul dx ;renglon *  MAX_COlUMNAS 
			add ax, [j]; renglon *  MAX_COlUMNAS + columa
			
			mov si, ax
			mov al, [bx + si]; Accedo a la matriz 
			mov ah, 0
			call printNumber
			mov al, ' '
			call putchar
			
			pop dx

			inc word ptr [j]
			jmp @@for_j
@@end_for_j:	
			
			mov al, 10
			call putchar
			mov al, 13
			call putchar

			inc word ptr [i]
			jmp @@for_i
@@end_for_i:
			
			pop dx
			pop cx
			pop bx
			pop ax
			pop si
		
		
	ret
	endp
	
	captureM proc ;llega en BX el offset de la matriz a capturar debe ser tipo WORD, en CX las filas y DX columnas
		
		push ax
		push bx
		push si
		
		
@@for_i:	cmp [i], cx
			jae @@end_for_i
			
			mov [j], 0
@@for_j:	cmp [j], dx
			jae @@end_for_j
			
			call showIndice
			mov si, [j]
			
			push bx; guardo arreglo 
			lea bx, buffer
			call scanString ; capturo un dato desde teclado
			call atoi; lo convierto en numero y se almacena en AX
			pop bx; recupero el arreglo
			
			mov [bx + si], al ; guardo el dato en el arreglo
			
			inc [j]; el incremento es de dos por el tipo de dato WORD 
						
			jmp @@for_j
@@end_for_j:

			inc word ptr [i]
			add bx, dx; Pasar a la siguiente fila 
			jmp @@for_i
@@end_for_i:
			
			mov [i], 0
			mov [j], 0
		
		
		
		pop si
		pop bx
		pop ax
		
	
	ret
	endp
	
	showIndice proc ;procedimiento de ayuda para mostrar en pantalla el indice donde se capturará
		
		push ax
		
		mov al, '['
		call putchar 
		
		mov ax, [i]
		call printNumber
		
		mov al, ']'
		call putchar
		
		mov al, '['
		call putchar 
		
		mov ax, [j]
		call printNumber
		
		mov al, ']'
		call putchar
		
		mov al, '='
		call putchar
		
		mov al, ' '
		call putchar
		
		
		pop ax
		
		
	ret
	endp
	
	printMatrix proc
		
		
		
		
	ret
	endp
	
	
	
end