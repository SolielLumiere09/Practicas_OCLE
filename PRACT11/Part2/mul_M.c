#include<stdio.h>

extern void Mul_Matrixs(int M1[][3], int M2[][3], int R[][3]);

void main()
{
	int i, j;
	
	int M1[3][3] = 
	{
		1,2,3,
		4,-5,6,
		7,8,-9
	};
	
	int M2[3][3] = 
	{
		-10,11,12,
		13,-14,15,
		16,17,18,
	};
	
	int R[3][3];
	
	system("cls");//limpiar panralla
	
	Mul_Matrixs(M1, M2, R);//Invoco a la funcion para multiplicar matrices 
	
	for(i = 0; i < 3; i++)
	{
		for(j = 0; j < 3; j++)
		{
			printf("%+d ", R[i][j]);//Imprimir matriz 
		}
		printf("\n\r");
		
	}

}