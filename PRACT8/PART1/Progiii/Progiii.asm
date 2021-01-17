.model small


.stack 100h
	
	include procs.inc 
	LOCALS
	

.data
	msg db "Ingrese HEX",13,10,0
	msg2 db " En decimal es ", 0
	msg3 db " No valido",10,13,0
	num db 30h,31h,32h,33h,34h,35h,36h,37h,38h,39h


.code
	
	main proc
		mov ax, @data
		mov ds, ax
			
		call clrscr	
		
		lea dx, msg
		call puts
		
		lea dx, msg2
		
		call getchar
		
		
	;switch (AL)
@@case_A:	cmp al, 'A'
			jne @@case_B
			call puts
			mov al, num[1]
			call putchar
			mov al, num[0]
			call putchar
			jmp @@break
			
@@case_B:	cmp al, 'B'
			jne @@case_C
			call puts
			mov al, num[1]
			call putchar
			call putchar
			jmp @@break

@@case_C:	cmp al, 'C'
			jne @@case_D
			call puts
			mov al, num[1]
			call putchar
			mov al, num[2]
			call putchar
			jmp @@break

@@case_D:	cmp al, 'D'
			jne @@case_E
			call puts
			mov al, num[1]
			call putchar
			mov al, num[3]
			call putchar
			jmp @@break
	
@@case_E	cmp al, 'E'
			jne @@case_F
			call puts
			mov al, num[1]
			call putchar
			mov al, num[4]
			call putchar
			jmp @@break
	
@@case_F:	cmp al, 'F'
			jne @@case_Default
			call puts
			mov al, num[1]
			call putchar
			mov al, num[5]
			call putchar
			jmp @@break
	
@@case_Default:	lea dx, msg3
				call puts
@@break:
	 

		call getch
		mov ah, 4ch
		mov al, 0
		int 21h
		
	endp
	
	
end