# Nome: Joás Gabriel Barros de Sousa
# Matrícula: 2023011092
.data
	nome: .asciiz "Gabriel"
	sobrenome: .asciiz "sara"
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


main:
	la $a0, nome
	la $a1, sobrenome
	jal strcmp
	
	add $a0, $v0, $zero
	li $v0, 1
	syscall	
