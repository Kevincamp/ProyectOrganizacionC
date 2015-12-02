#Proyecto de Organizacion and arquitectura de computadores
#Autores:
#Oswaldo Bayona 
#Kevin Campuzano
#Jorge Vergara


		.data
saludo: 	.asciiz "Proyecto de 1er Parcial de Organización y Arquitectura de Computadores:\n\n"
opuno: 		.asciiz "1. Sumar números decimales\n"
opdos: 		.asciiz "2. Sumar números hexadecimales\n"
optres: 	.asciiz "3. Sumar números decimales o hexadecimales\n"
salir:		.asciiz "4. Salir\n"
menuTitulo: 	.asciiz "Escoga una opcion: \n"
errorOp:	.asciiz "*** Opcion incorrecta ***\n"
salida:		.asciiz "El programa ha terminado"

pedirNumero:	.asciiz "Ingrece un numero: "
buffer:		.space  20 #space para leer un numero


.text
main:	la $a0, saludo		# Imprimir el saludo usando syscall 4
	li $v0, 4
	syscall
	
Menu:	la $a0, opuno		# Imprimir la opcion uno del menu usando syscall 4
	li $v0, 4
	syscall

	la $a0, opdos		# Imprimir la opcion dos del menu usando syscall 4
	li $v0, 4
	syscall
	
	la $a0, optres		# Imprimir la opcion tres del menu usando syscall 4
	li $v0, 4
	syscall
	
	
	la $a0, salir		# Imprimir la opcion cuatro del menu usando syscall 4
	li $v0, 4
	syscall
	
	la $a0, menuTitulo	# Imprimir: Ingrese una opcion
	li $v0, 4
	syscall
	
	li $v0, 5		# Leer el numero entero
	syscall
	
	add $s1, $v0, $zero	#copy the opcion in $t1
	
Case1:	addi $s0, $zero, 1	#t0 = 1
	bne $s1, $s0, Case2	# si $t1 no es igual a 1 saltar al Case2
	
	la $a0, opuno		# Imprimir la opcion uno del menu usando syscall 4
	li $v0, 4
	syscall
	
leerNumero:
	la $a0, pedirNumero	# Imprimir: Ingrese un numero
	li $v0, 4
	syscall
	
	li      $v0, 8		#leer string usando syscall 8
    	la      $a0, buffer	#guardar el string en un buffer
    	li      $a1, 20		#configurando el tamanio del buffer
    	syscall
	
	la $a0, buffer  #pasar direccion de buffer
	jal compararSaltoLinea  #llamar compara cadena Vacia, si es vacia retorna
	add $t3, $zero, $v0  #copiar el resultado a $t3
	
	beq $t3, $zero, leerNumero 
	
	j Menu			#regresar al Menu
	
	
Case2:	addi $s0, $zero, 2	#t0 = 2
	bne $s1, $s0, Case3	# si $t1 no es igual a 2 saltar al Case3
	
	la $a0, opdos		# Imprimir la opcion dos del menu usando syscall 4
	li $v0, 4
	syscall
	
	j Menu			#regresar al Menu

Case3: 	addi $s0, $zero, 3	#t0 = 3
	bne $s1, $s0, Salir	# si $t1 no es igual a 3 saltar a Salir
	
	la $a0, optres		# Imprimir la opcion tres del menu usando syscall 4
	li $v0, 4
	syscall
	
	j Menu			#regresar al Menu
	

Salir: 	addi $s0, $zero, 4	#t0 = 4
	bne $s1, $s0, Default	# si $t1 no es igual a 4 saltar al Default
	la $a0, salida		# Imprimir la despedida
	li $v0, 4
	syscall
	
	li $v0, 10		#finish the program
	syscall
	

Default:la $a0, errorOp		# Imprimir mensaje de error
	li $v0, 4
	syscall
	j Menu	
	
	
	
compararSaltoLinea: #Esta funcion recibe una cadena y si es igual al salto de linea retorna 1, caso contario retorna 0.
	add $t0, $a0, $zero #copiar el puntero al string

	lb $t1 ($t0)  #load byte
	
	addi $t4, $zero, 10
	bne $t1, $t4, novacio
	addi $v0, $zero, 1 #v0 = 1 es igual a la cadena vacia
	jr $ra #regresar al programa principal


	novacio: #la cadena no es vacia
	add $v0, $zero, $zero #v0 = 0
	jr $ra #regresar al programa principal





	
