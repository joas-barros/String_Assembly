.include "string.asm"

.data
	nome: .asciiz "Joas "
	sobrenome: .asciiz "Gabriel"
	sobrename: .asciiz "Gabriel"
	name: .asciiz "Joas"
	vazio: .asciiz "       "
	barros: .asciiz "Barros"
	espaco: .asciiz "\n"
	
.globl main
	
.text
main:
	la $a0, nome
	jal strlen
	addi $a0, $v0, 0
	li $v0, 1
	syscall
	
	la $a0, espaco
	li $v0, 4
	syscall
	
	la $a0, nome
	la $a1, sobrenome
	jal strcmp
	addi $a0, $v0, 0
	li $v0, 1
	syscall
	
	la $a0, espaco
	li $v0, 4
	syscall
	
	la $a0, nome
	la $a1, sobrenome
	jal strcat
	li $v0, 4
	syscall
	
	la $a0, espaco
	li $v0, 4
	syscall
	
	la $a0, name
	la $a1, sobrename
	addi $a2, $zero, 3
	jal strncat
	li $v0, 4
	syscall
	
	la $a0, espaco
	li $v0, 4
	syscall
	
	la $a0, vazio
	la $a1, barros
	addi $a2, $zero, 4
	jal strncpy
	li $v0, 4
	syscall
	
	li $v0, 10
	syscall
	
