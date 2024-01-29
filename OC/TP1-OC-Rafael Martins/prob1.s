.data
vetor: .word 10 3 7 2
.text
##### START MODIFIQUE AQUI START #####
#
# Este espaço é para você definir as suas constantes e vetores auxiliares.
#
la x7, vetor # endereço vetor
addi x28, x0, 4 # tamanho vetor
addi x12, x0, 0 # i = 0
addi x13, x0, 2 # salvando o valor 2
addi x10, x0, 0 # num pares
addi x11, x0, 0 # num impares
##### END MODIFIQUE AQUI END #####
.text
jal x1, contador
addi x14, x0, 2 # utilizado para correção
beq x14, x10, FIM # Verifica # de pares
beq x14, x11, FIM # Verifica # de ímpares
##### START MODIFIQUE AQUI START #####
contador:
slli x29, x12, 2 # i * 4
add x30, x7, x29 # Vai para a posição i do vetor
lw x15, 0(x30) # Guarda o item na posição i do vetor
rem x31, x15, x13 # Pega o resto da divisão do item do vetor por 2
beq x31, x0, par # Se o resto for 0, é par
bne x31, x0, impar # Caso contrário, é ímpar

par:
addi x10, x10, 1 # Incrementa o número de pares
addi x12, x12, 1 # Incrementa o i
blt x12, x28, contador # Se ainda tiverem elementos no vetor, repete o loop

jalr x0, 0(x1)

impar:
addi x11, x11, 1 # Incrementa o número de ímpares
addi x12, x12, 1 # Incrementa o i
blt x12, x28, contador # Se ainda tiverem elementos no vetor, repete o loop

jalr x0, 0(x1)
##### END MODIFIQUE AQUI END #####
FIM: addi x0, x0, 1