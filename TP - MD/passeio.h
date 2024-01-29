#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

#define N 8

int nMovimentos = 0, nRetrocessos = 0;

/**
 * Função que libera a memória alocada para uma matriz e suas linhas.
 * @param matrix Matriz (de 8 linhas) cuja memória será desalocada.
*/
void liberaMatriz(int **matrix){
  // Libera cada linha da matriz
  for (int i = 0; i < N; i++){
    free(matrix[i]);
  }
  free(matrix);
}

/**
 * Função que inicializa todas as posições da matriz que representa um tabuleiro de xadrez com -1.
 * @param tabuleiro Matriz NxN que representa um tabuleiro de xadrez.
*/
void inicializaTabuleiro(int tabuleiro[][N]){
    for(int i = 0; i < N; i++){
        for(int j = 0; j < N; j++){
            tabuleiro[i][j] = -1;
        }
    }
}

/**
 * Função que, aleatoriamente, muda a ordem das linhas da matriz (que, no caso, contém os movimentos que o cavalo pode realizar).
 * @param matriz Matriz a ser embaralhada
*/
void embaralhaMovimentos(int matriz[][2]){
  for (int i = 0; i < N; i++){
    // Pega um índice de uma linha aleatória da matriz para trocar com a linha i
    int r = rand() % N;
    for (int j = 0; j < 2; j++){
        int temp =  matriz[i][j];
        matriz[i][j] =  matriz[r][j];
        matriz[r][j] = temp;
    }
  }
}

/**
 * Função que verifica se uma casa pode ser visitada - isto é, se está dentro do tabuleiro e ainda não foi visitada.
 * @param tabuleiro Matriz NxN que representa um tabuleiro de xadrez.
 * @param x Índice da linha da casa a ser verificada.
 * @param y Índice da coluna da casa a ser verificada.
 * @return 1 caso a casa possa ser visitada ou 0 caso contrário.
*/
int movimentoPossivel(int tabuleiro[][N], int x, int y){
    // Se os índices estiverem dentro do tabuleiro e a casa não tiver sido visitada, então a posição é válida
    if(x < N && x >= 0 && y < N && y >= 0 && tabuleiro[x][y] == -1){
        return 1;
    }else{
        return 0;
    }
}

/**
 * Função que conta o número de casas acessíveis a partir de determinada casa.
 * @param tabuleiro Matriz NxN que representa um tabuleiro de xadrez.
 * @param casa Vetor que contém os índices {x, y} da casa a ser verificada
 * @param movimentos Matrix 8x2 que contém os movimentos a serem analisados. Pode ser vista também
 * como um vetor, no qual cada elemento é um movimento.
 * 
 * @return A acessibilidade (numero de casas que podem ser visitadas) da casa em questão
*/
int calculaAcessibilidade(int tabuleiro[][N], int casa[], int movimentos[][2]){
    int i, acess = 0;
    for(i = 0; i < N; i++){
        int novoX = casa[0] + movimentos[i][0];
        int novoY = casa[1] + movimentos[i][1];

        if(movimentoPossivel(tabuleiro, novoX, novoY)){
            acess++;
        }
    }
    
    return acess;
}

/**
 * Função que percorre os possíveis movimentos a partir da casa (x, y) e agrupa aqueles
 * que levam às posições com menor acessibilidade (número de casas acessíveis a partir daquela posição).
 * 
 * @param tabuleiro Matriz NxN que representa um tabuleiro de xadrez.
 * @param movimentos Matrix 8x2 que contém os movimentos a serem analisados. Pode ser vista também
 * como um vetor, no qual cada elemento é um movimento.
 * @param x Índice da linha da casa a ser verificada.
 * @param y Índice da coluna da casa a ser verificada.
 * 
 * @return Uma matriz contendo os melhores movimentos possíveis para a posição (x, y)
*/
int **selecionaMovimentos(int tabuleiro[][N], int movimentos[][2], int x, int y){
    int menorAcess = 10;
    int i, pos = 0;
    int **novoMovimentos = (int **) malloc (N * sizeof(int *));

    // Define uma ordem aleatória para os movimentos. Assim, é possível que hajam diferentes passeios para uma mesma posição inicial
    embaralhaMovimentos(movimentos);

    for(i = 0; i < N; i++){
        int prox[2] = {x + movimentos[i][0], y + movimentos[i][1]}; 

        novoMovimentos[i] = (int *) malloc (2 * sizeof(int));
        novoMovimentos[i][0] = 0;

        if(movimentoPossivel(tabuleiro, prox[0], prox[1])){
            // Calcula a acessibilidade da casa visitada naquele movimento
            int acess = calculaAcessibilidade(tabuleiro, prox, movimentos);

            // Se há uma casa com menor acessibilidade, define essa como a menor...
            if(acess < menorAcess) {
                menorAcess = acess;
                //... zera a matriz de movimentos...
                for (int row = 0; row < pos + 1; row++){
                    for (int col = 0; col < 2; ++col )
                    {
                        novoMovimentos[row][col] = 0;
                    }
                }
                pos = 0;
            }
            //... e coloca nela apenas aqueles com a menor acessibilidade.
            // Assim, guardaremos apenas os "melhores" movimentos (os que levam à menor acessibilidade possível a partir da casa atual)
            if (acess == menorAcess) {
                novoMovimentos[pos][0] = movimentos[i][0];
                novoMovimentos[pos][1] = movimentos[i][1];
                pos++;
            }
        }
    }

    return novoMovimentos;
}

/**
 * Função recursiva que "move" o cavalo a partir da posição (x, y) até passar por todas as casas do tabuleiro.
 * @param tabuleiro Matriz NxN que representa um tabuleiro de xadrez.
 * @param x Índice da linha da casa na qual o cavalo está.
 * @param y Índice da coluna da casa na qual o cavalo está.
 * @param marcador Número da casa visitada. Se essa é a 24ª casa visitada, então marcador = 24.
 * 
 * @return 1 caso tenha concluído o passeio e 0 caso contrário
*/
int andaCavalo(int tabuleiro[][N], int x, int y, int marcador){
    // Marca a casa visitada e conta o movimento
    tabuleiro[x][y] = marcador;
    nMovimentos++;
    
    // Se tiver visitado todas as N*N casas, o passeio está concluído!
    if(marcador == N*N){
        return 1;
    }

    int movimentos[8][2] = {{-1, 2}, {-2, 1}, {-2, -1}, {-1, -2}, {1, -2}, {2, -1}, {2, 1}, {1, 2}};
    
    // Seleciona os movimentos que levam à(s) casa(s) com menor acessibilidade
    int **selecaoMovimentos = selecionaMovimentos(tabuleiro, movimentos, x, y);
    int i = 0;

    // Tenta andar enquanto há movimentos a serem feitos
    while(selecaoMovimentos[i][0] != 0){
        int proximo[2] = {x + selecaoMovimentos[i][0], y + selecaoMovimentos[i][1]};

        // Vai para a próxima casa; se concluir o passeio, libera a memória alocada e volta à chamada inicial da função
        if(andaCavalo(tabuleiro, proximo[0], proximo[1], marcador+1)){
            liberaMatriz(selecaoMovimentos);
            return 1;
        }
        // Se não chegou ao final, teve que retroceder. Logo, conta o retrocesso, desmarca a casa visitada...
        else{
            nRetrocessos++;
            tabuleiro[proximo[0]][proximo[1]] = -1;
        }
        
        //... e tenta o próximo movimento
        i++;
    }
    
    // Se chegou até aqui, não há mais movimentos possíveis na casa atual. É necessário retroceder e tentar novos movimentos!
    return 0;
}

/**
 * Função de execução e impressão do passeio a partir da posição (x, y).
 * @param x Índice da linha da casa da qual o passeio começará.
 * @param y Índice da coluna da casa da qual o passeio começará.
*/
void passeio(int x, int y){

    // Verifica se a posição inicial está dentro do tabuleiro
    if(x > N || x < 1 || y > N || y < 1){
        printf("Posicao inicial invalida!\n");
        return;
    }

    int marcador = 1;

    int tabuleiro[N][N];
    inicializaTabuleiro(tabuleiro);

    FILE *saida = fopen("saida.txt","a");

    // Caso o passeio seja concluído com sucesso, imprime a matriz e o número de casas visitadas e retrocedidas num arquivo "saida.txt"
    if(andaCavalo(tabuleiro, x - 1, y - 1, marcador)){
        for(int i = 0; i < N; i++){
            for(int j = 0; j < N; j++){
                fprintf(saida, "%d ", tabuleiro[i][j]);
            }
            fprintf(saida, "\n");
        }
        fprintf(saida, "%d %d\n", nMovimentos, nRetrocessos);
    }

    // Ao finalizar o passeio e imprimí-lo no arquivo, zera os contadores e fecha o arquivo  
    nMovimentos = 0;
    nRetrocessos = 0;
    fclose(saida);
}