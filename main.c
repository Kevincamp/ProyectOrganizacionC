//
//  main.c
//  ProyectoOrganizacion
//
//  Created by Kevin on 11/20/15.
//  Copyright © 2015 Kevin. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
void sumaHexadecimal();
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
    char a[256];
    int b = 0 , c = 0;
    printf("\t\t\t*** Suma de Decimales ***\n");
    while(c == 0)
    {
        gets(a);
        if(a!=""){
            b = atoi(a) + b;
            c = 0;
        }
        else{
            c = 1;
        }
    }
    printf("La sumatoria es %i", &b);
}

/*void sumaHexadecimal(){
    char a[256], b[256], result[256];
    printf("\t\t\t*** Suma de Hexadecimales ***\n");
    printf("\n Ingrese 1er Número: ");
    scanf("%s", a);
    printf("\n Ingrese 2do Número: ");
    scanf("%s", b);
}*/






