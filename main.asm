#include da biblioteca
.include "string.asm"


.data
	msgmain1: .asciiz " \n Escolha uma das opcoes abaixo:\n1 - strlen\n2 - strcmp\n3 - strcat\n4 - strncat\n5 - strncpy\n0 - Sair"
	string1: .asciiz "Ola mundo!" #10 caracteres
	string2: .asciiz "ola mundo." #10 caracteres
	string3: .asciiz " Hello World!" #13 caracteres
	string4: .asciiz "Silvio, "

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
	
		# la $a0, msgmain1 #passa o endere�o da mensagem inicial para $a0
		# li $v0, 4    #passa o c�digo do call para mostrar a mensagem
		# syscall      #executa a diretiva que mostra a mensagem
	
		# li $v0, 5    #passa o c�digo do call para ler um inteiro
		# syscall	     #executa a diretiva para ler um inteiro, a resposta fica em $v0

		li $s0, 0 #aqui vai ser somada a nota para mostar no finnal
		
		# beq $v0, 1, chamada_strlen #testa as op��es para executar os m�todos que o usu�rio escolher
		# beq $v0, 2, chamada_strcmp 
		# beq $v0, 3, chamada_strcat
		# beq $v0, 4, chamada_strncat
		# beq $v0, 5, chamada_strncpy
		# beq $v0, 0, exitmain
	
		# j main #se n�o for escolhida nenhuma op��o, retorna para o main
	
	chamada_strlen:
		
		#carregando os endere�os
		la $a0, string1		#"Ola mundo!"
		
		#chamando a fun��o strlen
		jal strlen
		
		#valor esperado: 10
		li $t0, 10
		bne $t0, $v0, chamada_strcmp 
		addi $s0, $s0, 1	#se acertou o resultdo soma 1 a nota
		
		#-------------------------------
		#	mostrando o resultado
		#-------------------------------
		# li $v0, 1		#imprime inteiro 
		# syscall			#chamada do sistema	
			
		# j main		#retorna para o main ao fim da execu��o		
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
		li $s2, 3
	
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
		la $a0, string2
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
		li $s2, 3
      	
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
	add $t0, $a0, $zero #coipa $a0 para temporario
	#imprime a string1
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
	jr	$ra			#retorna
