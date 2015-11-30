//
//  main.c
//  ProyectoOrganizacion
//
//  Created by Kevin on 11/20/15.
//  Copyright © 2015 Kevin. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
void sumaDecimal();
void anadirNumero();
void mostrarResultado();

struct numero
{
    int num;
    struct numero *sgte;
    
};
 struct numero *primero, *ultimo;

void anadirNumero()
{
    char a[256];
    struct numero *numero;
    numero = (struct numero *)malloc(sizeof(struct numero));
    if (numero == NULL){printf("No hay memoria disponible");}
    
    printf("\nNuevo numero:"); fflush(stdout);
    gets(a);
    int compare = strncmp(a," ",1);
    /*Compare si ingresa el enter*/
    if (compare != 0){
        numero->num = atoi(a);
        numero->sgte = NULL;
        
        if(primero == NULL){
            primero = numero;
            ultimo = numero;
        }else{
            ultimo->sgte = numero;
            ultimo = numero;
        }
    }
    else{
        mostrarResultado();
    }
}

void mostrarResultado(){
    struct numero *auxiliar;
    int i, sum = 0;
    i = 0;
    
    auxiliar = primero;
    while(auxiliar == NULL){
        sum = sum + auxiliar->num;
        auxiliar = auxiliar->sgte;
        i++;
    }
    if (i == 0) {
        printf("\nLa lista esta vacia!!.\n");
    }
    else {
        printf("el total es: %d", sum);
    }
}

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
            anadirNumero();
        }
    }while (seleccion !=4);
}






