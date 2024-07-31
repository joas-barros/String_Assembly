# Nome: Joás Gabriel Barros de Sousa
# Matrícula: 2023011092

.text
#########################################
# Função: unsigned int strlen( char *s) #
#########################################
# Recebe o ponteiro para uma string e retorna a quantidade de caracteres da string fora o '/0'
strlen:
	# Ajustando a pilha
	addi $sp, $sp, -4 # Cria espaço para um elemento de 4 bytes na pilha
	sw $s0, 0($sp)	# Bota o registrador $s0 na primeira posição da pilha
	addi $s0, $zero, 0  # Contador de caracteres "i", começando com i = 0 
loop_strlen:
	add $t0, $s0, $a0 # Armazena em $t0 o endereço do argumento mais o contador "$t0 = s[i]"
	lb $t1, 0($t0) # Armazena o caractere do endereço $t0 em $t1
	beq $t1, 0, saida_strlen # Verifica se s[i] == '/0' indicando o fim da string e saindo do loop
	addi $s0, $s0, 1 # Caso não seja, adiciona 1 ao contador "i++"
	j loop_strlen # Volta para o loop para conta mais um caractere
saida_strlen:
	add $v0, $s0, $zero # Armazena o contador em $v0 para retornar o valor
	lw $s0, 0($sp) # Carrega o valor na pilha em $s0
	addi $sp, $sp, 4 # Libera espaço na pilha
	jr $ra # Retorna ao endereço de chamada da função


#########################################
# Função: int strcmp( char *s, char *t) #
#########################################
# Recebe dois ponteiros de string e compara o tamanho de cada uma a partir da primeira string
# Se o tamanho da primeira string for maior que a segunda, irá retornar 1
# Se o tamanho da primeira string for menor que a segunda, irá retornar -1
# Se as duas tiverem o mesmo tamanho,irá retornar 0
strcmp:
	
	addi $sp, $sp, -12 # Liberando espaço na pilha
	# Armazenando o endereço de retorno e argumentos
	sw $ra, 8($sp)
	sw $a0, 4($sp)
	sw $a1, 0($sp)
	
	# Chama a função strlen com o endereço da primeira string em $a0, retornando assim a tamanho dela
	jal strlen
	
	
	lw $a0, 0($sp) # Recupera o endereço do segundo argumento na pilha para o $a0
	sw $v0, 0($sp) # Salva o tamanho da primeira string na pilha
	
	# Chama a função para encontrar o tamanho da segunda string
	jal strlen
	
	lw $t0, 0($sp) # Carrega o tamanho da string 1 para $t0 da pilha
	add $t1, $v0, $zero # Carrega o tamanho da string 2 para $t1 do retorno da função

	bne $t0, $t1, diferente # Verifica se o tamanho das duas strings é diferente
	addi $v0, $zero, 0 # Caso não seja retorna zero na função
saida_strcmp:
	
	# Retira os dois últimos elementos da pilha	
	lw $a0, 4($sp)  
	lw $ra, 8($sp)
	
	addi $sp, $sp, 12 # Libera espaço na pilha
	jr $ra # Retorna ao endereço de chamada da função
diferente:
	
	slt $v0, $t1, $t0 # Caso o tamanho da string 2 seja menor que o tamanho da string 1, atribui 1 ao retorno
	bne $v0, 1, menor # Caso o tamanho da string 1 seja menor, desvia a execução para o label menor
	j saida_strcmp # Encaminha para a saida da função
menor:
	addi $v0, $zero, -1 # Atrigui o valor de retorno como -1
	j saida_strcmp # Encaminha para a saida da função


################################################
# Função: char *strcat( char *dest, char *src) #
################################################
# Recebe o ponteiro para duas strings e concatena a string scr no final da string dest
strcat:
	# Reservando espaço para 3 elementos na pilha
	addi $sp, $sp, -12
	# Passando os valores para a pilha
	sw $ra, 8($sp)
	sw $s0, 4($sp)
	sw $s1, 0($sp)
	
	# Chama a função para encontrar o tamanho da primeira string
	jal strlen
	add $s0, $v0, $zero # Armazena o tamanho da string em $s0
	
	add $s0, $s0, $a0 # Armazena em $s0 o endereço do último caractere da primeira string
	add $s1, $zero, $a1 # Armazena o endereço do primeiro caractere da segunda string
	
	lb $t0, 0($s1) # Carrega o primeiro caractere da segunda string para $t0
	sb $t0, 0($s0) # Substitui o caractere '/0' da primeira string pelo primeiro caractere da segunda string
loop_strcat:
	# Acrescenta em 1 o endereço das duas strings
	addi $s0, $s0, 1
	addi $s1, $s1, 1
	
	
	lb $t0, 0($s1) # Carregando o caractere da segunda string para $t0
	beq $t0, 0, saida_strcat # Verificando se $t0 é '/0' para sair do loop
	sb $t0, 0($s0) # Passando o caractere para a segunda string
	j loop_strcat # Volta pra loop
saida_strcat:
	
	sb $zero, 0($s0) # Atribui '\0' ao último caractere da primeira string finalizando a concatenação
	addi $v0, $zero, 0 #Para não retornar nada 
	
	# Liberando os valores armazenados na pilha	
	lw $s1, 0($sp) 
	lw $s0, 4($sp)
	lw $ra, 8($sp)
	
	addi $sp, $sp, 12 # Retornando o ponteiro da pilha para o local original
	jr $ra #volta ao programa principal


############################################################
# Função: char *strncat( char *dest, char *src, int count) #
############################################################
# Recebe o ponteiro para duas strings, juntamente com um valor inteiro, e concatena os primeiros count caracteres da string scr no final da string dest
strncat:
	# Reservando espaço para 4 elementos na pilha
	addi $sp, $sp, -16
	# Passando os valores para a pilha
	sw $ra, 12($sp)
	sw $s0, 8($sp)
	sw $s1, 4($sp)
	sw $s2, 0($sp)
	
	jal strlen # Chama a função para encontrar o tamanho da primeira string
	add $s0, $v0, $zero # Armazena o tamanho da string em $s0
	
	add $s0, $s0, $a0 # Armazena em $s0 o endereço do último caractere da primeira string
	add $s1, $zero, $a1 # Armazena o endereço do primeiro caractere da segunda string
	add $s2, $a2, $zero # Armazena em $s2 o valor de count
	
	addi $t1, $zero, 1 # Atribui o valor 1 ao contador
	lb $t0, 0($s1) # Carrega o primeiro caractere da segunda string em $t0
	sb $t0, 0($s0) # Carrega o primeiro caractere da segunda string no caractere '/0' da primeira string	
loop_strncat:
	# Acrescenta em 1 o endereço das duas strings
	addi $s0, $s0, 1
	addi $s1, $s1, 1
	
	lb $t0, 0($s1) # Carregando o caractere da segunda string para $t0
	beq $t1, $s2, saida_strncat # Verificando se o contador é igual ao count
	sb $t0, 0($s0) # Caso não seja, carrega o caractere na primeira string
	addi $t1, $t1, 1 # Adiciona 1 ao contador
	j loop_strncat # Volta pro loop
saida_strncat:
	sb $zero, 0($s0) # Atribui '\0' ao último caractere da primeira string finalizando a concatenação
	addi $v0, $zero, 0 #Para não retornar nada 
	
	# Liberando os valores armazenados na pilha
	lw $s2, 0($sp)	
	lw $s1, 4($sp)
	lw $s0, 8($sp)
	lw $ra, 12($sp)
	
	addi $sp, $sp, 16  # Retornando o ponteiro da pilha para o local original
	jr $ra # volta ao programa principal


############################################################
# Função: char *strncpy( char *dest, char *src, int count) #
############################################################
# Recebe o ponteiro para duas strings, juntamente com um valor inteiro, e copia os count primeiros caracteres de src em dest
strncpy:
	# Reservando espaço para 2 elementos na pilha
	addi $sp, $sp, -8
	# Passando os valores para a pilha
	sw $s1, 4($sp)
	sw $s0, 0($sp)
	
	addi $s0, $zero, 0 # Contador i = 0
	add $s1, $zero, $a2 # Atribui o valor de count em $s1
loop_strncpy:
	add $t0, $a0, $s0 # $t0 = dest[i]
	add $t1, $a1, $s0 # $t1 = src[i]
	
	lb $t2, 0($t1) # Caractere src[i] em $t2
	beq $s0, $s1, saida_strncpy # Verifica se o contador é igual ao count (criterio de parada)
	sb $t2, 0($t0) # Caso não seja, carregamos o caractere de src[i] em dest[i]
	addi $s0, $s0, 1 # Acrescentamos no contador (i++)
	j loop_strncpy # Voltamos no loop
saida_strncpy:
	sb $zero, 0($t0) # Atribui '\0' ao último caractere da primeira string
	
	# Liberando os valores armazenados na pilha
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	
	addi $sp, $sp, 8 # Retornando o ponteiro da pilha para o local original
	addi $v0, $zero, 0 #Para não retornar nada
	jr $ra # volta ao programa principal


