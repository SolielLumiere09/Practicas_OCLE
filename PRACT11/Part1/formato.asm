; La función _Funcion de ensamblador debera
; ser declarada en C como prototipo:
;
; extern void Funcion(void);
.DOSSEG
.MODEL small
.CODE


PUBLIC _Funcion

		;EXTRN _<nombre de la variable> ; si se requiere accesar
		;a una variable global
		
_Funcion PROC ;
 

 push bp ;  Protocolo de entrada
 mov bp,sp ; para funcion C
 
				 ; \ Procedimiento a
				 ; > realizar en ensamblador
				 ; / si la funcion recibe parametros, se accede a ellos 
				 ;/ a partir de [bp + 4]
				 ;/ el primer parametro (de izquierda a derecha) esta en [bp + 4]
				 ;/ el segundo esta en [bp + 6] 
				 ;/ el tercero en [bp + 8] y asi sucesivamente 

 pop bp ; \ Protocolo de salida
 ret ; > para función en C
_Funcion ENDP ; /
 END
 
; Tabla para retornar valores
; ==============================================================
; Tipo de Valor Lacalidad para el Valor
; --------------------------------------------------------------
; unsigned char, char, enum 								AX
; unsigned short, short 									AX
; unsigned int, int 										AX
; unsigned long, long 										DX:AX
; float, double, long double 								Dirección offset
; struct y union 											Dirección offset
; near * 													AX
; far * 													DX:AX
; ============================================================== 