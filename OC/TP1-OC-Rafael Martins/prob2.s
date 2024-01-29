.data
	vetor: .word 200, 190, 340, 100 # exemplo
.text
 
##### START MODIFIQUE AQUI START #####
#
# Este espaço é para você definir as suas constantes e vetores auxiliares.
#
la a0, vetor # endereço vetor
addi a1, x0, 4 # tamanho vetor
addi x13, x0, 0 # i = 0
addi a2, x0, 201 # variável auxiliar para calcular os reajustes
addi t0, x0, 0 # contador de salários acima do limiar
##### END MODIFIQUE AQUI END #####
 
.text 
	jal ra, main 
    #  utilizado para correção (considerando um limiar de 200 para o vetor de exemplo após a aplicação do reajuste.
    addi a4, x0, 3 # configurando a quantidade de salários acima do limiar de 200.
    beq a4, t0, FIM # Verifica a quantidade de salários acima do limiar.

	main: 
##### START MODIFIQUE AQUI START #####
 		addi sp, sp, -4 # Aloca espaço para o ra na pilha
        sw ra, 0(sp) # Guarda o conteúdo de ra na pilha
        jal ra, aplica_reajuste # Vai para a instrução de reajuste
        lw ra, 0(sp) # Recupera o conteúdo anterior de ra na pilha para retornar ao ponto correto
        addi x2, x2, 8 # Desaloca o espaço na pilha
        jalr x0, 0(ra) # Volta pra instrução que chamou a main
##### END MODIFIQUE AQUI END #####
	aplica_reajuste:
    	beq x13, a1, acaba_loop # Caso não haja mais iterações a serem realizadas, finaliza o loop
    	slli x29, x13, 2 # i * 4
		add x30, a0, x29 # Vai para a posição i do vetor
 		lw x15, 0(x30) # Guarda o item na posição i do vetor
        srli x31, x15, 1 # Faz um shift para direita para dividir o número por 2 (50% do salário)
        add x15, x15, x31 # Obtém agora o salário reajustado
        addi x13, x13, 1 # Incrementa o i
        bge x15, a2, conta_acima # Se o salário estiver acima do limiar, vai para a parte do programa que conta isso
        beq x0, x0, aplica_reajuste # Repete o loop
    
    conta_acima:
    	addi t0, t0, 1 # Incrementa o contador de salários acima do limiar
        beq x0, x0, aplica_reajuste # Repete o loop
        
    acaba_loop:
    	jalr x0, 0(ra)
    	
##### START MODIFIQUE AQUI START #####
 		
##### END MODIFIQUE AQUI END #####
FIM: addi x0, x0, 1