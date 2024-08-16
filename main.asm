#include da biblioteca
.include "string.asm"


.data
	string1: .asciiz "Ola mundo!" #10 caracteres
	espaco: .asciiz "               "
	string2: .asciiz "ola mundo." #10 caracteres
	espaco2: .asciiz "               "
	string3: .asciiz " Hello World!" #13 caracteres
	espaco3: .asciiz "               "
	string4: .asciiz "Silvio, "
	espaco4: .asciiz "               "

	result_strcat_1: .asciiz "Silvio, Ola mundo!"
	result_strcat_2: .asciiz "Ola mundo!"
	result_strncat_1: .asciiz "ola mundo. He"
	result_strncat_2: .asciiz " Hello World!"
	result_strncpy_1: .asciiz "Ola"
	result_strncpy_2: .asciiz "Ola mundo!"

	quebra_linha: .asciiz "\n"
	separador: .asciiz "--------------\n"
	nota: .asciiz "Nota: "


	
.text
.globl main #define o main como um label global	
	main: 
	
		li $s0, 0 #aqui vai ser somada a nota para mostar no finnal
		
	
	chamada_strlen:
		
		#carregando os endere�os
		la $a0, string1		#"Ola mundo!"
		
		#chamando a fun��o strlen
		jal strlen
		
		#valor esperado: 10
		li $t0, 10
		bne $t0, $v0, chamada_strcmp 
		addi $s0, $s0, 1	#se acertou o resultdo soma 1 a nota
		
#---------------------------------------------------------------------------------------------------
	
	chamada_strcmp:
		#carregando as variaveis
		la	$a0, string1	#"Ola mundo!"
		la	$a1, string2	#"ola mundo."

		#chamada da fun��o strcmp
		jal strcmp
		
		#valor esperado: 0
		li $t0, 0
		bne $t0, $v0, chamada_strcmp2 
		addi $s0, $s0, 1	#se acertou o resultdo soma 1 a nota
		
		#------------------------------------------
		#	Mostrando Resultado
		#------------------------------------------		
		# li	$v0, 1			#passa o parametro de imprimir inteiro para $v0
		# syscall				#chamada do sistema
	
	chamada_strcmp2:
		#carregando as variaveis
		la	$a0, string1	#"Ola mundo!"
		la	$a1, string3	#" Hello World!"

		#chamada da fun��o strcmp
		jal strcmp
		
		#valor esperado:  -1
		li $t0, -1
		bne $t0, $v0, chamada_strcmp3 
		addi $s0, $s0, 1	#se acertou o resultdo soma 1 a nota
		
		#------------------------------------------
		#	Mostrando Resultado
		#------------------------------------------		
		# li	$v0, 1			#passa o parametro de imprimir inteiro para $v0
		# syscall				#chamada do sistema

	chamada_strcmp3:
		#carregando as variaveis
		la	$a0, string1	#"Ola mundo!"
		la	$a1, string4	#"Silvio, "

		#chamada da fun��o strcmp
		jal strcmp
		
		#valor esperado: 1
		li $t0, 1
		bne $t0, $v0, chamada_strcat 
		addi $s0, $s0, 1	#se acertou o resultdo soma 1 a nota
		
		#------------------------------------------
		#	Mostrando Resultado
		#------------------------------------------		
		# li	$v0, 1			#passa o parametro de imprimir inteiro para $v0
		# syscall				#chamada do sistema
	
		# j main		#retorna para o main ao fim da execu��o	

#---------------------------------------------------------------------------------------------------		
	chamada_strcat: 
	
	 	#mensagem de leitura e lendo as Strings
		la $a0, string4  #string de destino: "Silvio, "
		la $a1, string1  #string src: "Ola mundo!"
		
		#chamando a fun��o strcat
		jal strcat			#Retorna o endereco de stringDestino, no caso, n�o precisa ser utilizado...
		#-------------------------------
		#	mostrando o resultado
		#-------------------------------
				
		
		#resultado esperado: "Silvio, Ola mundo!"
		la $a0, string4
		la $a1, result_strcat_1
		jal stringIguais

		#Se for o resultado esperao: retora 1, senao 0
		li $t0, 1
		bne $t0, $v0, chamada_strcat_2 
		addi $s0, $s0, 1	#soma 1 a nota final
	
	chamada_strcat_2:
		#para verificar se a string de origem se manteve igual
		#resultado esperado: "Ola mundo!"
		la $a0, string1
		la $a1, result_strcat_2
		jal stringIguais

		#Se for o resultado esperao: retora 1, senao 0
		li $t0, 1
		bne $t0, $v0, chamada_strncat 
		addi $s0, $s0, 1	#soma 1 a nota final

	    # j main		#retorna para o main ao fim da execu��o								
	#---------------------------------------------------------------------------------------------
		
	chamada_strncat: 
	
	 	#mensagem de leitura e lendo as Strings
		la $a0, string2  #string de destino: "ola mundo."
		la $a1, string3  #string src: " Hello World!"
		li $a2, 3
	
		#chamando a fun��o strncat
		jal strncat			#Retorna o endereco de stringDestino, no caso, n�o precisa ser utilizado...

		#resultado esperado: "ola mundo. He"
		la $a0, string2
		la $a1, result_strncat_1
		jal stringIguais

		#Se for o resultado esperao: retora 1, senao 0
		li $t0, 1
		bne $t0, $v0, chamada_strncat_2 
		addi $s0, $s0, 1	#soma 1 a nota final

	chamada_strncat_2:
		#resultado esperado: " Hello World!"
		la $a0, string3
		la $a1, result_strncat_2
		jal stringIguais

		#Se for o resultado esperao: retora 1, senao 0
		li $t0, 1
		bne $t0, $v0, chamada_strncpy 
		addi $s0, $s0, 1	#soma 1 a nota final

		#-------------------------------
		#	mostrando o resultado
		#-------------------------------
		# la	$a0, string2			#carrega o endereco da string de destino
		# li	$v0, 4				# especifica o servido de impressao para string
		# syscall					# imprime
	
		# #para verificar se a string de origem se manteve igual
		# la	$a0, string3			#carrega o endereco da string de origem
		# li	$v0, 4				# especifica o servido de impressao para string
		# syscall					# imprime

	    # j main		#retorna para o main ao fim da execu��o	
	
#---------------------------------------------------------------------------------------------
		
	chamada_strncpy: 
	
        #mensagem de leitura e lendo as Strings
		la $a0, string2  #string de destino:" Hello World!"
		la $a1, string1  #string src: "Ola mundo!"
		li $a2, 3
      	
      	#chama a funcao
      	jal strncpy			#Retorna o endereco de stringDestino, no caso, n�o precisa ser utilizado...
      	
		#resultado esperado: "Ola"
		la $a0, string2
		la $a1, result_strncpy_1
		jal stringIguais

		#Se for o resultado esperao: retora 1, senao 0
		li $t0, 1
		bne $t0, $v0, chamada_strncpy_2 
		addi $s0, $s0, 1	#soma 1 a nota final
     	
	chamada_strncpy_2:
		#resultado esperado: "Ola mundo!"
		la $a0, string1
		la $a1, result_strncpy_2
		jal stringIguais

		#Se for o resultado esperao: retora 1, senao 0
		li $t0, 1
		bne $t0, $v0, fim_prog 
		addi $s0, $s0, 1	#soma 1 a nota final
		
		#----------------------------
     	# Mostrando o resultado
     	#----------------------------
     	# la	$a0, string2			#carrega o endereco da string de destino
		# li	$v0, 4				# especifica o servido de impressao para string
		# syscall					# imprime
	
		# #para verificar se a string de origem se manteve igual
		# la	$a0, string1			#carrega o endereco da string de origem
		# li	$v0, 4				# especifica o servido de impressao para string
		# syscall					# imprime 

	 	# j main		#retorna para o main ao fim da execu��o	
	#---------------------------------------------------------------------------------------------		
		
	fim_prog:
		la $a0, nota
		li $v0, 4	# imprime "nota: "
		syscall
		add $a0, $s0, $zero
		li $v0, 1
		syscall
		
		li $v0, 10	# Finalizar o programa
		syscall		#executa a diretiva


### Funcao Auxiliar para verificar se as strings são iguais
stringIguais:
	# add $t0, $a0, $zero #coipa $a0 para temporario
	# #imprime a string1
	# li $v0, 4
	# syscall
	# #imprime quebra de linha
	# la $a0, quebra_linha	
	# li $v0, 4
	# syscall
	
	# #imprime a string2
	# add $a0, $a1, $zero #copia $a1 para $a0 so para imprimir 
	# li $v0, 4
	# syscall
	# #imprime quebra de linha
	# la $a0, quebra_linha	
	# li $v0, 4
	# syscall
	# #imprime separador "----"
	# la $a0, separador	
	# li $v0, 4
	# syscall
	addi $sp, $sp, -4 # Reserva de espaço em pilha
	sw $ra, 0($sp)	# Salva valor de $ra na pilha

	#imprime as strings que estao em $a0 e $a1
	jal printStrings
	
	add $a0, $t0, $zero #retaura $a0 do temporario
	
	addi 	$sp, $sp, -4		#ajusta pilha para mais 1 item
	sw	$s0, 0($sp)		#salva $s0
	add	$s0, $zero, $zero	# i = 0+0
	li $v0, 1 #return comeca com "true"
L1:	add	$t1, $s0, $a1		#endere�o de y[i] em $t1
	lb	$t2, 0($t1)		# $t2 = y[i]
	add	$t3, $s0, $a0		#endere�o de x[i] em $t3
	lb	$t4, 0($t3)		#4t4 = x[i]
	bne	$t2, $t4, Diff		#se o caractere y[i] == x[i] continua - senao termina
	beq	$t2, $zero, L2		#se y[i] == 0 (fim da string) vai para L2
	addi	$s0, $s0, 1		# i = i+1
	j	L1			# vai para L1
Diff: li $v0, 0
L2: 	lw	$s0, 0($sp)		# y[i] == 0; fim da string; restura $s0
	addi	$sp, $sp, 4		#retira 1 word da pilha	
	
	lw $ra, 0($sp)	# Restaura valor de $ra na pilha
	addi $sp, $sp, 4 # Desaloca de espaço em pilha	
	jr	$ra			#retorna


printStrings:
	add $t0, $a0, $zero #coipa $a0 para $t0
	add $t1, $a1, $zero #coipa $a1 para $t1
	#imprime a string1 que já esta em $a0
	li $v0, 4
	syscall
	#imprime quebra de linha
	la $a0, quebra_linha	
	li $v0, 4
	syscall
	
	#imprime a string2
	add $a0, $a1, $zero #copia $a1 para $a0 so para imprimir 
	li $v0, 4
	syscall
	#imprime quebra de linha
	la $a0, quebra_linha	
	li $v0, 4
	syscall
	#imprime separador "----"
	la $a0, separador	
	li $v0, 4
	syscall
	add $a0, $t0, $zero #restaura o valor de $a0
	add $a1, $t1, $zero #restaura o valor de $a1
	jr $ra