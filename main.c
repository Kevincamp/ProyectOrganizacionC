//
//  main.c
//  ProyectoOrganizacion
//
//  Created by Kevin on 11/20/15.
//  Copyright © 2015 Kevin. All rights reserved.
//

#include <stdio.h>
void sumaHexadecimal(char a, char b);

int main(int argc, const char * argv[]) {
    int x;
    printf("Proyecto de 1er Parcial de Organización y Arquitectura de Computadores!\n");
    printf("Integrantes: \n");
    printf("\t - Kevin Campuzano.\n");
    printf("\t - Oswaldo Bayona.\n");
    printf("\t - Jorge Enrique.\n");
    printf("*************************************************************************************\n");
    
    printf("\t\t\t\t Bienvenido.\n");
    printf("\t 1. Sumar números decimales.\n");
    printf("\t 2. Sumar números hexadecimales.\n");
    printf("\t 3. Sumar numeros decimales y hexadecimales\n");
    
    switch (x) {
        case 1:
            printf("Escogio opcion 1");
            break;
        case 2:
            printf("Escogio opcion 2");
            break;
        case 3:
            printf("Escogio opcion 3");
            break;
        default:
            printf("Error ingrese la opcion correcta.");
            break;
    }
    
    printf("Por favor escoja su opcion:\n");
    scanf("%i",&x);
    
    return 0;
    
}

void sumaHexadecimal(char a, char b){
    
}






