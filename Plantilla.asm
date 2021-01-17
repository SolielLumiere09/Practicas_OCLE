.model small

.stack 100h
	
	LOCALS
	include procs.inc
	
.data
	


.code
	
	main proc
	mov ax, @data
	mov ds, ax
	

	
	
	
	mov ax, 4c00h
	int 21h
	endp
end