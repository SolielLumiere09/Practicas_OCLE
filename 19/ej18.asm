.model small

.stack 100h
	
	LOCALS
	include procs.inc
	
.data
	
	array dw 10,23,18,43,87,23,12,56,45,53
	msg db "El valor minimo del arreglo es ", 0
	msg1 db 10,13,"El valor maximo del arreglo es ", 0
	msg2 db 10,13, "El Promedio es ", 0

.code
	
	main proc
	mov ax, @data
	mov ds, ax
	
	call clrscr
	
	lea bx, msg 
	call puts ; imprimir msg
	
	lea bx, array
	call min ; Calcular el minimo del arreglo 
	call printNumber; imprimirlo 
	
	lea bx, msg1 
	call puts ;imprimir msg1
	
	lea bx, array
	call max; calcular maximo del arreglo 
	call printNumber; imprimirlo 
	
	lea bx, msg2
	call puts; imprimir msg2
	
	lea bx, array
	call promedio; calcular promedio
	call printNumber; imprimirlo 
	
	
	mov ax, 4c00h
	int 21h
	endp
	
	
	promedio proc; retorna en AX el promedio del arreglo, recibe en BX el offset del arreglo
		
		
		push bx
		push cx
		push dx
		
		mov cx, 10
		
		mov ax, 0
@@nxt:	
		add ax, [bx]; Ir acumuladno la suma 
		add bx, 2
		
		loop @@nxt
		
		mov cx, 10
		mov dx, 0
		div cx; divirlo entre el total 
		
		pop dx
		pop cx
		pop bx
		
	ret
	endp
	
	
	
	
	min proc; retorna en AX el valor minimo del arreglo 
		
		push bx
		push cx
		
		mov ax, [bx]
		mov cx, 10
@@nxt:	
		
		
@@if:	cmp ax, [bx]; if(AX < [BX]) swap 
		jbe @@end_if
		mov ax, [bx]

@@end_if:
		add bx, 2
		loop @@nxt
		
		pop cx
		pop bx 
	
	
	ret
	endp
	
	max proc; retorna en AX el valor maximo del arreglo 
	
		push bx
		push cx
		
		mov ax, [bx]
		mov cx, 10
@@nxt:	
		
		
@@if:	cmp ax, [bx]; if(AX > [BX]) swap 
		jae @@end_if
		mov ax, [bx]

@@end_if:
		add bx, 2
		loop @@nxt
		
		pop cx
		pop bx 
	
	
	
	ret
	endp
	
	
	
	
end