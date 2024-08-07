# String Assembly

- Pequena biblioteca implementada em MIPS assembly capaz de realizar operações de maniulação de texto (string).

## Principais funções

### strlen

- Recebe um ponteiro que indica uma string e retorna quantos caracteres essa string possui.

### strcmp

- Compara duas strings em relação ao seu tamanho (do caracter mais à esquerda até o mais à direita) e retorna um inteiro. Se primeira string é menor que a segunda retorna -1. Se a segunda string é maior que a segunda retornar 1. Se as strings têm o mesmo comprimento retornar 0.

### strcat

- Recebe o endereço de uma string no registrador $a0 e outro endereço de string no registrador $a1 e concatenar a segunda string no final da primeira.

### strncat

- Faz a mesma coisa que o strcat, porém recebe um inteiro n como argumento e concatena só os n primeiros caracteres.

### strncpy

- Recebe o endereço de uma string no registrador $a0, outro endereço de string no registrador $a1, um inteiro n em $a2 e concatenar os n primeiros caracters da segunda string no endereço da primeira.