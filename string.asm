# Nome: Joás Gabriel Barros de Sousa
# Matrícula: 2023011092
.data
	nome: .asciiz "Joas "
	sobrenome: .asciiz "Gabriel"
.globl main
.text

strlen:
	addi $sp, $sp, -4
	sw $s0, 0($sp)
	addi $s0, $zero, 0
L1:	add $t0, $s0, $a0
	lb $t1, 0($t0)
	beq $t1, 0, L2
	addi $s0, $s0, 1
	j L1
L2:	add $v0, $s0, $zero
	lw $s0, 0($sp)
	addi $sp, $sp, 4
	jr $ra


strcmp:
	addi $sp, $sp, -12
	
	sw $ra, 8($sp)
	sw $a0, 4($sp)
	sw $a1, 0($sp)
	
	jal strlen
	
	lw $a0, 0($sp)
	sw $v0, 0($sp)
	
	jal strlen
	
	lw $t0, 0($sp)
	add $t1, $v0, $zero

	bne $t0, $t1, diferente
	addi $v0, $zero, 0
saida_strcmp:	
	lw $a0, 4($sp)
	lw $ra, 8($sp)
	addi $sp, $sp, 12
	jr $ra
diferente:
	slt $v0, $t1, $t0
	bne $v0, 1, menor
	j saida_strcmp
menor:
	addi $v0, $zero, -1
	j saida_strcmp


strcat:
	addi $sp, $sp, -12
	sw $ra, 8($sp)
	sw $s0, 4($sp)
	sw $s1, 0($sp)
	
	jal strlen
	add $s0, $v0, $zero
	
	add $s0, $s0, $a0
	add $s1, $zero, $a1
	
	lb $t0, 0($s1)
	sb $t0, 0($s0)
loop_strcat:
	addi $s0, $s0, 1
	addi $s1, $s1, 1
	
	lb $t0, 0($s1)
	beq $t0, 0, saida_strcat
	sb $t0, 0($s0)
	j loop_strcat
saida_strcat:
	sb $zero, 0($s0)
	addi $v0, $zero, 0 #Para não retornar nada 	
	lw $s1, 0($sp)
	lw $s0, 4($sp)
	lw $ra, 8($sp)
	addi $sp, $sp, 12
	jr $ra #volta ao programa principal

main:
	la $a0, nome
	la $a1, sobrenome
	jal strcat
	
	#add $a0, $v0, $zero
	li $v0, 4
	syscall	
