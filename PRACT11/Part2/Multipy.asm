dosseg

.model small

.code

	public _Mul_Matrixs
	
	
	_Mul_Matrixs proc
	;BX = M1, SI = M2, DI = R
		
		push bp
		mov bp, sp; Protocolo de entrada
		
		
		mov bx, [bp + 4]; Recibo la direccion de M1
		mov si, [bp + 6]; Recibo la direccion de M2
		mov di, [bp + 8]; Recibo la direccion de R
		
		
		mov ax, 0
		;Por convencion guardar los registros que no son de proposito general
		push di; [bp + 10] = di
		push si; [bp + 8] = si
		
		; "Declaracion" de variables locales
		push ax; [bp + 6] = sum
		push ax; [bp + 4] = k
		push ax; [bp + 2] = j
		push ax; [bp] = i  
		mov bp, sp ; Para direccionar entre las variables en la pila 
		
		
@@for_i:	cmp [bp], word ptr 3; for(i = 0; i < 3; i++)
			jae @@end_for_i
			
			mov [bp + 2], word ptr 0
@@for_j:	cmp [bp + 2], word ptr 3; for(j = 0; j < 3; j++)
			jae @@end_for_j
			
			mov [bp + 4], word ptr 0
@@for_k:	cmp [bp + 4], word ptr 3; for(k = 0; k < 3; k++)
			jae @@end_for_k
			
			;Obtener indice; index = file * MAX_COLUMNS + column 
			push di; se requiere por la tercera matriz [bp - 2]
			;para M1[i][k]
			mov ax, [bp]; i
			mov cx, 3; Maximo de columnas 
			imul cx ; Multiplica por MAX_COLUMNS
			add ax, [bp + 4]; sumale el indice k
			mov cx, 2
			imul cx; multiplica por dos por el tipo de dato que manejo que es WORD con signo
			mov di, ax
			mov ax, [bx + di]; Accedo al elemento de la matriz
			push ax; Guardo M1[i][k], ese elemento está en [bp - 4]
			
			
			;Para M2[k][j]
			push bx; Guardar BX
			mov ax, [bp + 4]; k
			mov cx, 3; Maximo de columnas 
			imul cx ; Multiplica por MAX_COLUMNS
			add ax, [bp + 2]; sumale el indice j
			mov cx, 2
			imul cx; multiplica por dos por el tipo de dato
			mov bx, ax
			mov ax, [si + bx]; Accedo al elemento de la matriz
			;AX = M2[k][j]
			pop bx; Recupero BX
			
			imul word ptr [bp - 4]; AX = M1[i][k] * M2[k][j]
			add [bp + 6], ax; SUM = SUM + AX
			
			pop ax; Sacar el dato de la pila 
			pop di; Recupero di 
			
			inc word ptr [bp + 4]
			jmp @@for_k
@@end_for_k:
			;para R[i][j]
			mov ax, [bp]; i
			mov cx, 3; Maximo de columnas 
			imul cx ; Multiplica por MAX_COLUMNS
			add ax, [bp + 2]; sumale el indice j
			mov cx, 2
			imul cx; multiplica por dos por el tipo de dato
			
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
		
end
