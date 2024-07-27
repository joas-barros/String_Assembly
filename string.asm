# Nome: Joás Gabriel Barros de Sousa
# Matrícula: 2023011092
.data
	nome: .asciiz "Gabriel"
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

main:
	la $a0, nome
	jal strlen
	
	add $a0, $v0, $zero
	li $v0, 1
	syscall	