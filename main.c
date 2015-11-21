//
//  main.c
//  ProyectoOrganizacion
//
//  Created by Kevin on 11/20/15.
//  Copyright © 2015 Kevin. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
void sumaHexadecimal(char a, char b);
void sumaDecimal();

int main(int argc, const char * argv[]) {
    int seleccion;
    do{
        printf("Proyecto de 1er Parcial de Organización y Arquitectura de Computadores!\nIntegrantes: \n");
        printf("\t - Kevin Campuzano.\n");
        printf("\t - Oswaldo Bayona.\n");
        printf("\t - Jorge Enrique.\n");
        do{
            printf("\t\t\t\t Bienvenido.\n");
            printf("\t 1. Sumar números decimales.\n");
            printf("\t 2. Sumar números hexadecimales.\n");
            printf("\t 3. Sumar numeros decimales y hexadecimales\n");
            printf("\t 4. Salir.\n");
            printf("Escriba su opción:\n");
            scanf("%i",&seleccion);
        }while (seleccion !=1 && seleccion !=2 && seleccion !=3 && seleccion !=4);
        
        if(seleccion == 1){ /* Sumatoria Decimales*/
            sumaDecimal();
        }
    }while (seleccion !=4);
}


void sumaDecimal (){
    double sum;
    char a[256], b[256];
    printf("\t\t\t*** Suma de Decimales ***\n");
    printf("\n Ingrese 1er Número: ");
    fgets (a, 100, stdin);
    printf("\n Ingrese 2do Número: ");
    fgets (b, 100, stdin);
    sum = atof(a) + atof(b);
    printf("\n %s + %s = %f \n", a,b,sum);
}

void sumaHexadecimal(char a, char b){
    
}






