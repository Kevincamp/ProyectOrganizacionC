#Proyecto de Organizacion and arquitectura de computadores
#Autores:
#Oswaldo Bayona 
#Kevin Campuzano
#Jorge Vergara


		.data
saludo: 	.asciiz "Proyecto de 1er Parcial de Organización y Arquitectura de Computadores:\n\n"
opuno: 		.asciiz "\n1. Sumar números decimales\n"
opdos: 		.asciiz "2. Sumar números hexadecimales\n"
optres: 	.asciiz "3. Sumar números decimales o hexadecimales\n"
salir:		.asciiz "4. Salir\n"
menuTitulo: 	.asciiz "Escoga una opcion: \n"
errorOp:	.asciiz "*** Opcion incorrecta ***\n"
salida:		.asciiz "El programa ha terminado\n"

pedirNumero:	.asciiz "\nIngrese un numero: "
buffer:		.space  20 #space para leer un numero
errorDato:	.asciiz "Dato incorrecto\n"
bien:		.asciiz "bien\n"
numdigitos:	.asciiz "\nnumero Digitos: "
exponente:	.asciiz "\nexponente: "
numero:		.asciiz "\nNumero: "
acumulado:	.asciiz "\nLa Suma es: "
msgpow:		.asciiz "\npow: "
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
	add $s2,$zero,$zero   	#$s2=0, acu=0
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
	la $a0,buffer
	jal stringDecimal
	# acumular el numero
	add $s2,$s2,$v0
	j Case1_leerNumero #pedir otro numero
	
	
	Case1_Sumar: #si se ingresa un salto de linea se suman los numeros
	la $a0, acumulado
	li $v0, 4
	syscall
	add $a0,$s2,$zero
	li $v0, 1
	syscall
	
	j Menu			#regresar al Menu
	
	
Case2:	addi $s0, $zero, 2	#s0 = 2
	bne $s1, $s0, Case3	# si $s1 no es igual a 2 saltar al Case3
	add $s2, $zero,$zero 	#s2 = 0, acu = 0 
	la $a0, opdos		# Imprimir la opcion dos del menu usando syscall 4
	li $v0, 4
	syscall
	
	Case2_leerNumero:
	la $a0, pedirNumero 	#Se imprime: Ingrese un numero
	li $v0, 4
	syscall
	
	li $v0, 8		# leer string usando syscall 8
	la $a0, buffer		# guarda el string en un buffer
	li $a1, 20		# se configura el tamano del buffer
	syscall
	
	la $a0, buffer 		# pasar la direccion del buffer
	jal compararSaltoLinea	# llamar a comparar si es un salto de linea
	add $t1, $zero, $v0	# copia el resultado a $t1
	bne $t1, $zero, Case2_Sumar	# Si es igual a 1, se pasa a sumar los numeros
	
	la $a0, buffer		# pasar la direccion del buffer a $a0
	jal esNumeroHexadecimal	# compruebo si el numero es hexadecimal
	bne  $v0, $zero, Case2_Guardar # si es uno, se guarda ese numero
	
	#si no es uno, mostrar error y pedir otro numero
	la $a0, errorDato
	li $v0, 4
	syscall
	j Case2_leerNumero 	# pedir otro numero
	
	Case2_Guardar:
	la $a0, bien
	li $v0,4
	syscall
	la $a0,buffer
	jal stringHexadecimal
	# acumular el numero
	add $s2,$s2,$v0
	j Case2_leerNumero #pedir otro numero
	
	
	Case2_Sumar: #si se ingresa un salto de linea se suman los numeros
	la $a0, acumulado
	li $v0, 4
	syscall
	add $a0,$s2,$zero
	li $v0, 1
	syscall
	
	j Menu			#regresar al Menu

Case3: 	addi $s0, $zero, 3	#t0 = 3
	bne $s1, $s0, Salir	# si $t1 no es igual a 3 saltar a Salir
	
	la $a0, optres		# Imprimir la opcion tres del menu usando syscall 4
	li $v0, 4
	syscall
	
	Case3_leerNumero:
	la $a0, pedirNumero 	#Se imprime: Ingrese un numero
	li $v0, 4
	syscall
	
	li $v0, 8		# leer string usando syscall 8
	la $a0, buffer		# guarda el string en un buffer
	li $a1, 20		# se configura el tamano del buffer
	syscall
	
	la $a0, buffer 		# pasar la direccion del buffer
	jal compararSaltoLinea	# llamar a comparar si es un salto de linea
	add $t1, $zero, $v0	# copia el resultado a $t1
	bne $t1, $zero, Case3_Sumar	# Si es igual a 1, se pasa a sumar los numeros
	
	#compruebo si el numero es decimal
	la $a0, buffer		# pasar la direccion del buffer a $a0
	jal esNumeroDecimal	# compruebo si el numero es hexadecimal
	bne  $v0, $zero, Case3_Guardar_Decimal # si es uno, se guarda ese numero decimal
	
	#comrpuebo si el numero comienza con 0x
	la $a0, buffer         #pasar la direccion del buffer a $a0
	jal comienza_con_0x    #compruebo si el string comienza con 0X
	bne $v0, $zero, Case3_comprobar_Hexadecimal # si el resultado es 1, comienza con 0x y hay que comprobar el resto de la cadena
	
	#si no es uno, mostrar error y pedir otro numero
	la $a0, errorDato
	li $v0, 4
	syscall
	j Case3_leerNumero 	# pedir otro numero
	
	Case3_Guardar_Decimal:
	la $a0, bien
	li $v0,4
	syscall
	la $a0,buffer
	jal stringDecimal
	# acumular el numero
	add $s2,$s2,$v0
	j Case3_leerNumero #pedir otro numero
	
	Case3_comprobar_Hexadecimal:
	la $a0, buffer         #pasar la direccion del buffer a $a0
	addi $a0, $a0, 2       #mover el puntero dos posiciones
	jal esNumeroHexadecimal  #compruebo si el resto de la cadena es hexadecimal
	bne $v0, $zero, Case3_Guardar_Hexadecimal #si es uno se guarda ese numero hexadecimal
	#si no es uno, mostrar error y pedir otro numero
	la $a0, errorDato
	li $v0, 4
	syscall
	j Case3_leerNumero 	# pedir otro numero
	
	Case3_Guardar_Hexadecimal:
	la $a0, bien
	li $v0,4
	syscall
	la $a0,buffer
	addi $a0, $a0, 2 #muevo el puntero dos posiciones
	jal stringHexadecimal
	# acumular el numero
	add $s2,$s2,$v0
	j Case3_leerNumero #pedir otro numero
	
	
	Case3_Sumar: #si se ingresa un salto de linea se suman los numeros
	la $a0, acumulado
	li $v0, 4
	syscall
	add $a0,$s2,$zero
	li $v0, 1
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
	addi $sp, $sp, -8 #reservar espacio para dos items
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

stringDecimal:#esta funcion recibe una cadena de caracter y retorna la cadena trasformada en numero
	add $t0, $a0,$zero # $t0=string
	addi $sp,$sp,-8 # desplazo la pila
	sw $ra,0($sp) # guardo la direccion del programa que me llamo
	sw $t0,4($sp) #guardo el string del numero
	jal contarDigitos
	add $t2,$zero,$v0 # i=numCaracteres
	lw $ra,0($sp) #obtengo la direccion del programa que me llamo
	lw $t0,4($sp)
	addi $sp,$sp,8 #regreso al valor anterior de la pila
	addi $t4,$zero,10 #registro para verificar el enter
	add $t3,$zero,$zero # se inicializa la variable que contendra el numero,result=0
	subi $t2,$t2,1 #i--
	loop_StringDecimal: 	
		lb $t1,0($t0) #cargo 1 byte en $t1, $t1=*String
		addi $t0,$t0,1 #desplaso el puntero de t0 al siguiente byte, String++
		beq $t1,$t4,exit_StringDecimal #si el byte es igual al entre terminar la funcion
		addi $a0,$zero,10 #primer argumento de pow
		add $a1,$zero,$t2 # segundo argumento de pow
		addi $sp,$sp,-24 #despazo el stack
		sw $ra,0($sp) #guardamos la direccion de la funcion que me llamo
		sw $t0,4($sp) # guardamos el t0
		sw $t1,8($sp) #guardamos el t1
		sw $t2,12($sp) #guardamos el t2
		sw $t3,16($sp) #guardamos el t3
		sw $t4,20($sp) #guardamos el t4
		jal pow # llamo a la funcion para calcular 10^i
		lw $ra,0($sp) #recupero la direccion de la funcion que me llamo
		lw $t0,4($sp) #recupero t0
		lw $t1,8($sp) #recupero t1
		lw $t2,12($sp) #recupero t2
		lw $t3,16($sp) #recupero t3
		lw $t4,20($sp) #recupero t4
		addi $sp,$sp,24 # regreso el stack
		subi $t1,$t1,48 #obtenego el equivalente entero del numero
		add $t5,$zero,$v0 #guardo el 10^i en $t5
		mul $t5,$t5,$t1
		mflo $t5
		add $t3,$t3,$t5 # result=result +n*10^i
		subi $t2,$t2,1 # i--
		j loop_StringDecimal
	exit_StringDecimal:
	#imprimo el mensaje digito
	la $a0,numero
	li $v0, 4
	syscall
	#imprimo el numero
	add $a0,$zero,$t3
	addi $v0,$zero,1
	syscall
	add $v0,$zero,$t3
	jr $ra
	
contarDigitos: #esta funcion recibe la cadena de numero y retorna el numero de digitos que tiene
	add $t0, $a0,$zero # $t0=string
	addi $t4,$zero,10 #registro para verificar el enter
	add $t3,$zero,$zero
	add $t5,$zero,$zero # se inicializa la variable que contendra el numero,result=0
	loop_contarDigito: 	lb $t1,0($t0) #cargo 1 byte en $t1, $t1=*String
		addi $t0,$t0,1 #desplazo el puntero de t0 al siguiente byte, String++
		beq $t1,$t4,exit_contarDigito #si el byte es igual al entre terminar la funcion
		addi $t5,$t5,1 # result++
		j loop_contarDigito
	exit_contarDigito:
	add $v0,$zero,$t5
	jr $ra

pow: # esta funcion retorna a0^a1
	add $t0,$zero,$a0
	add $t1,$zero,$a1
	addi $t2,$zero,1
	loop_pow:slt $t3, $zero,$t1 # $a1 > 0 - 1
		beq $t3,$zero,exit_pow # si a1 
		mul $t2,$t2,$t0
		mflo $t2
		subi $t1,$t1,1
		j loop_pow
	exit_pow:
	add $v0,$zero,$t2
	jr $ra
	
esNumeroHexadecimal: # #esta funcion recibe una cadena y retorn 1 si es un numero hexadecimal y un cero si no lo es.
	add $t0, $a0 ,$zero # copio el puntero al string
	
	loop_esNumeroHexadecimal:
	lb $t1($t0)
	
	addi $t2, $zero,10 # 10 es el salto de linea
	
	beq $t1, $t2 , end_esNumeroHexadecimal # llega al final del arreglo, es decir hasta el salto de linea se acaba
	
	#llamar a la funcion esHexadecimal
	addi $sp, $sp, -8 # reservo el espacio para dos items
	sw $t0, 4($sp) # guardo el temporal en una pila
	sw $ra, 0($sp) # guardo la direccion de retorno
	
	add $a0, $zero, $t1
	jal esCaracterHexadecimal
	
	lw $ra, 0($sp) # recupera la direccion de retorno
	lw $t0, 4($sp) # recupera temporal t0
	addi $sp, $sp, 8 #ajustar el tope de la pila
	
	beq $v0, $zero, test_isDecimal
	addi $t0, $t0, 1 # continua con el siguiente byte
	j loop_esNumeroHexadecimal
	
	end_esNumeroHexadecimal: # si es hexadecimal
	addi $v0, $zero,1
	jr $ra
	
	test_isDecimal:
	#llamar a la funcion esHexadecimal
	addi $sp, $sp, -8 # reservo el espacio para dos items
	sw $t0, 4($sp) # guardo el temporal en una pila
	sw $ra, 0($sp) # guardo la direccion de retorno
	add $a0, $zero, $t1
	jal esDigitoDecimal
	lw $ra, 0($sp) # recupera la direccion de retorno
	lw $t0, 4($sp) # recupera temporal t0
	addi $sp, $sp, 8 #ajustar el tope de la pila
	beq $v0, $zero, fail_numeroHexadecimal 
	addi $t0, $t0, 1 # continua con el siguiente byte
	j loop_esNumeroHexadecimal
	
	
	fail_numeroHexadecimal:
	add $v0, $zero, $zero
	jr $ra
	

esCaracterHexadecimal: #recibe un caracter y retorna 1 si es una letra (a - f) y 0 si no lo es
	slti $t0, $a0, 97 #si $a0 es menor que 97 retorna 0
	
	bne $t0, $zero, noCaracterHexadecimal # si $a0 < 97 y no es hexadecimal
	
	slti $t0, $a0, 103 # si $a0 < 102 retornar 0
	beq $t0, $zero, noCaracterHexadecimal # si no es igual a cero es mayor que 71, no es hexadecimal
	
	addi $v0, $zero, 1 # si es hexadecimal, retorna 1
	jr $ra
	
	noCaracterHexadecimal:
	add $v0, $zero, $zero
	jr $ra 

	
stringHexadecimal:#esta funcion recibe una cadena de caracteres (formato hexadecimal) y retorna la cadena trasformada en numero decimal
	add $t0, $a0,$zero # $t0=string
	addi $sp,$sp,-8 # desplazo la pila
	sw $ra,0($sp) # guardo la direccion del programa que me llamo
	sw $t0,4($sp) #guardo el string del numero
	jal contarDigitos
	add $t2,$zero,$v0 # i=numCaracteres ent $t2
	lw $ra,0($sp) #obtengo la direccion del programa que me llamo
	lw $t0,4($sp)
	addi $sp,$sp,8 #regreso al valor anterior de la pila
	addi $t4,$zero,10 #registro para verificar el enter
	add $t3,$zero,$zero # se inicializa la variable que contendra el numero,result = 0
	subi $t2,$t2,1 #i - -
	loop_StringHexdecimal: 	
		lb $t1,0($t0) #cargo 1 byte en $t1, $t1=*String
		addi $t0,$t0,1 #desplaso el puntero de t0 al siguiente byte, String++
		beq $t1,$t4,exit_StringHexadecimal #si el byte es igual al enter terminar la funcion
		addi $a0,$zero,16 #primer argumento de pow, base 16
		add $a1,$zero,$t2 # segundo argumento de pow, i
		addi $sp,$sp,-24 #despazo el stack
		sw $ra,0($sp) #guardamos la direccion de la funcion que me llamo
		sw $t0,4($sp) # guardamos el t0
		sw $t1,8($sp) #guardamos el t1
		sw $t2,12($sp) #guardamos el t2
		sw $t3,16($sp) #guardamos el t3
		sw $t4,20($sp) #guardamos el t4
		jal pow # llamo a la funcion para calcular 10^i
		add $t5, $zero, $v0 #copio el resultado en $t5
		
		lw $ra,0($sp) #recupero la direccion de la funcion que me llamo
		lw $t0,4($sp) #recupero t0
		lw $t1,8($sp) #recupero t1
		lw $t2,12($sp) #recupero t2
		lw $t3,16($sp) #recupero t3
		lw $t4,20($sp) #recupero t4
		addi $sp,$sp,24 # regreso el stack
		
		#debo preuntar si es decimal el numero, llamando a la funcion es digito
		addi $sp, $sp, -8 # reservo el espacio para dos items
		sw $t0, 4($sp) # guardo el temporal en una pila
		sw $ra, 0($sp) # guardo la direccion de retorno
		add $a0, $zero, $t1
		jal esDigitoDecimal
		lw $ra, 0($sp) # recupera la direccion de retorno
		lw $t0, 4($sp) # recupera temporal t0
		addi $sp, $sp, 8 #ajustar el tope de la pila
		beq $v0, $zero, convertHexadecimal #si no es decimal, entonces debe ser hexadecimal
		
		subi $t1,$t1,48 #obtenego el equivalente entero del numero
		mul $t5,$t5,$t1 # multiplico $t1 por 10 ^ i
		mflo $t5
		add $t3,$t3,$t5 # result=result +n*10^i
		subi $t2,$t2,1 # i--
		j loop_StringHexdecimal
		
		#convertir letras hexadecimales de (a-f) a numeros
		convertHexadecimal:
		subi $t6, $t1, 97  # resto 97, que es el valor de a
		addi $t1, $t6, 10  # sumo 10 a la diferencia anterior 
		mul $t5,$t5,$t1 # multiplico $t1 por 10 ^ i
		mflo $t5
		add $t3,$t3,$t5 # result=result +n*10^i
		subi $t2,$t2,1 # i--
		j loop_StringHexdecimal
		
		
	exit_StringHexadecimal:
	#imprimo el mensaje digito
	la $a0,numero
	li $v0, 4
	syscall
	#imprimo el numero
	add $a0,$zero,$t3
	addi $v0,$zero,1
	syscall
	add $v0,$zero,$t3
	jr $ra	


comienza_con_0x: #devuelve 1 si la cadena empieza con "0x"y 0 caso contrario
	
	lb $t0, 0($a0) #cargo el primer caracter
	addi $t1, $zero, 48 # 48 es cero en ascii
	bne $t0, $t1, no_comienza_con_0x
	
	addi $a0, $a0, 1 #muevo el puntero
	lb $t0, 0($a0) #cargo el segundo caracter
	addi $t1, $zero, 120 # 120 es el ascii de la x
	bne $t0, $t1, no_comienza_con_0x
	
	addi $v0, $zero, 1
	jr $ra
	
	no_comienza_con_0x:
	add $v0, $zero, $zero
	jr $ra 
	

	
	

