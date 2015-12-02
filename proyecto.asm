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
	
	add $t1, $v0, $zero	#copy the opcion in $t1
	
Case1:	addi $t0, $zero, 1	#t0 = 1
	bne $t1, $t0, Case2	# si $t1 no es igual a 1 saltar al Case2
	
	la $a0, opuno		# Imprimir la opcion uno del menu usando syscall 4
	li $v0, 4
	syscall
	
	j Menu			#regresar al Menu
	
	
Case2:	addi $t0, $zero, 2	#t0 = 2
	bne $t1, $t0, Case3	# si $t1 no es igual a 2 saltar al Case3
	
	la $a0, opdos		# Imprimir la opcion dos del menu usando syscall 4
	li $v0, 4
	syscall
	
	j Menu			#regresar al Menu

Case3: 	addi $t0, $zero, 3	#t0 = 3
	bne $t1, $t0, Salir	# si $t1 no es igual a 3 saltar a Salir
	
	la $a0, optres		# Imprimir la opcion tres del menu usando syscall 4
	li $v0, 4
	syscall
	
	j Menu			#regresar al Menu
	

Salir: 	addi $t0, $zero, 4	#t0 = 4
	bne $t1, $t0, Default	# si $t1 no es igual a 4 saltar al Default
	la $a0, salida		# Imprimir la despedida
	li $v0, 4
	syscall
	
	li $v0, 10		#finish the program
	syscall
	

Default:la $a0, errorOp		# Imprimir mensaje de error
	li $v0, 4
	syscall
	j Menu	
	