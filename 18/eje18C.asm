.model small

.stack 100h
	
	LOCALS
	include procs.inc
	
.data
	msg1 db "El numero que es la suma de los otros dos es ", 0
	msg2 db "Ninguno es la suma de los otros dos ", 0
	
	buffer db 5 dup (?), 0
	
	n1 dw ?
	n2 dw ?
	n3 dw ?
	
.code
	
	main proc
	mov ax, @data
	mov ds, ax
	
	call clrscr
	
	mov cx, 1
	call getParam
	mov [n1], ax; obtener primer argumento
	
	mov cx, 2
	call getParam
	mov [n2], ax; obtener segundo argumento
	
	mov cx, 3
	call getParam
	mov [n3], ax; obtener tercer argumento 
	
	
	call compareNumbers
	
	
	
	mov ax, 4c00h
	int 21h
	endp
	
	
	compareNumbers proc ;realizar las comparaciones de los numeros 
		
		;Para el caso de n1 
		mov cx, [n1]
		mov ax, [n2]
		add ax, [n3]
		
		lea bx, msg1
		
@@if_n1:	cmp cx, ax
			jne @@else_n1
			mov ax, cx
			call puts 
			call printNumber
			jmp @@end_if_n1
@@else_n1:	
			;Ahora para n2 
			mov cx, [n2]
			mov ax, [n1]
			add ax, [n3]
		
@@if_n2:	cmp cx, ax
			jne @@else_n2
			mov ax, cx
			call puts 
			call printNumber
			jmp @@end_if_n2
@@else_n2:				
			
		;Ahora para n3
			mov cx, [n3]
			mov ax, [n1]
			add ax, [n2]
		
@@if_n3:	cmp cx, ax
			jne @@else_n3
			mov ax, cx
			call puts 
			call printNumber
			jmp @@end_if_n3
			
@@else_n3:	lea bx, msg2
			call puts

@@end_if_n3:
		
			

@@end_if_n2:
			

			
@@end_if_n1:
		

@@end:
	ret
	endp
	
	
	
end