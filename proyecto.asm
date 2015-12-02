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
salida:		.asciiz "El programa ha terminado\n"

pedirNumero:	.asciiz "Ingrece un numero: "
buffer:		.space  20 #space para leer un numero
errorDato:	.asciiz "Dato incorrecto\n"
bien:		.asciiz "bien\n"
 

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
	
	Case1_leerNumero:
	la $a0, pedirNumero	# Imprimir: Ingrese un numero
	li $v0, 4
	syscall
	
	li      $v0, 8		#leer string usando syscall 8
    	la      $a0, buffer	#guardar el string en un buffer
    	li      $a1, 20		#configurando el tamanio del buffer
    	syscall
	
	la $a0, buffer  #pasar direccion de buffer
	jal compararSaltoLinea  #llamar compara si es un salto de linea
	add $t1, $zero, $v0  #copiar el resultado a $t1
	bne $t1, $zero, Case1_Sumar # si es igual a 1, se pasa a sumar los numeros
	
	la $a0, buffer #pasar la direccion del buffer a $a0
	jal esNumeroDecimal  #compruebo si el numero es decimal
	bne $v0, $zero, Case1_Guardar #si es uno, se guarda ese numero
	
	#si no es uno, mostrar error y pedir otro numero
	la $a0, errorDato
	li $v0, 4
	syscall
	j Case1_leerNumero #pedir otro numero
	
	Case1_Guardar:
	la $a0, bien
	li $v0, 4
	syscall
	# guardar el numero
	
	j Case1_leerNumero #pedir otro numero
	
	
	Case1_Sumar: #si se ingresa un salto de linea se suman los numeros
	la $a0, bien
	li $v0, 4
	syscall
	
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
	
	addi $t2, $zero, 10
	bne $t1, $t2, novacio
	addi $v0, $zero, 1 #v0 = 1 es igual a la cadena vacia
	jr $ra #regresar al programa principal


	novacio: #la cadena no es vacia
	add $v0, $zero, $zero #v0 = 0
	jr $ra #regresar al programa principal



esNumeroDecimal: #esta funcion recibe una cadena y retorn 1 si es un numero decimal y un cero no lo es.
	add $t0, $a0, $zero #copia el puntero al string
	
	loop_esNumeroDecimal:
	
	lb $t1($t0)
	
	addi $t2, $zero, 10 # 10 es el salto de linea
	
	beq $t1, $t2, end_esNumeroDecimal #llega al final del arreglo, es decir hasta el salto de linea
	
	#llamar a la funcion esDigitoDecimal
	addi $sp, $zero, -8 #reservar espacio para dos items
	sw $t0, 4($sp) #guardo el temporal en la pila
	sw $ra, 0($sp) #guardo la direccion de retorno
	
	add $a0, $zero, $t1
	jal esDigitoDecimal
	
	lw $ra, 0($sp) #recuperar direccion de retorno
	lw $t0, 4($sp) #recuperar temporal 0
	addi $sp, $sp, 8 #ajustar el tope de la pila
	
	
	beq $v0, $zero, fail_numeroDecimal
	addi $t0, $t0, 1 #continua con el siguiente byte
	j loop_esNumeroDecimal
	
	
	end_esNumeroDecimal: #si es decimal
	addi $v0, $zero, 1
	jr $ra
	
	fail_numeroDecimal:
	add $v0,$zero, $zero
	jr $ra
	

esDigitoDecimal: #Esta funcion recibe un caracter (1 byte) y retorna 1 si es un digito (0 - 9) y 0 si no lo es
	
	slti $t0, $a0, 48 #si $a0 es menor que 48 retornar 0
	
	bne $t0, $zero, noDigitoDecimal # si $a0 < 48 y no es digito
	
	slti $t0, $a0, 58 #si $a < 58 retornar 0
	beq $t0, $zero, noDigitoDecimal #si no es igual a cero es mayor que 58, no es digito
	
	addi $v0, $zero, 1 # si es digito, retorna 1
	jr $ra
	
	noDigitoDecimal:   
	add $v0, $zero, $zero #no es digito decimal retorna 0
	jr $ra
	
