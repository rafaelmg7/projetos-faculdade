#include <iostream>
#include <sstream>
#include <math.h>
#include <vector>
#include <utility>
#include <algorithm>
#include <stdio.h>
#include <tuple>

using namespace std;

typedef struct manobra{
    long long int tempo;
    long long int pontuacao;
} Manobra_t;

#define MARCADO 1
#define NAO_MARCADO 0

int numSecoes;
int numManobras;

std::vector<Manobra_t> manobras;

std::vector<long long int> bonificacoes;
std::vector<long long int> tempos_secoes;

std::vector<std::vector<long long int>> dp(102, std::vector<long long int>(1024));
std::vector<std::vector<long long int>> manobras_usadas(102, std::vector<long long int>(1024));

std::vector<std::vector<Manobra_t>> matrix(1024, std::vector<Manobra_t>(1024));

std::vector<std::vector<int>> marcados(101, std::vector<int>(1024, 0));

/**
 * Função que gera todas as combinações entre uma manobra e a manobra anterior.
*/
void geraCombinacoesManobras(){
    long long int tamanho = manobras.size();
    
    for(int mask1 = 0; mask1 < (1 << tamanho); mask1++){
        int indice = mask1;
        std::vector<long long int> auxVector;

        for(int bitIndice = 0; bitIndice < tamanho; bitIndice++){
            auxVector.push_back(indice & 1);
            indice >>= 1;
        }

        for(int mask2 = 0; mask2 < (1 << tamanho); mask2++){
            long long int pontuacao = 0;
            long long int contador = 0;
            long long int tempo = 0;
            long long int ponto = 0;
            int indice2 = mask2;

            for(int k = 0; k < tamanho; k++){
                if(indice2 & 1){
                    contador++;
                    ponto = manobras[k].pontuacao;

                    if(auxVector[k]){
                        ponto /= 2;
                    }
                    pontuacao += ponto;
                    tempo += manobras[k].tempo;
                }
                indice2 >>= 1;
            }

            pontuacao *= contador;
            matrix[mask1][mask2].pontuacao = pontuacao;
            matrix[mask1][mask2].tempo = tempo;
        }
    }

}


/**
 * Função que calcula a pontuação máxima e as manobras usadas para todas as seções.
 * @return A pontuação máxima e um vetor contendo o número de manobras e as manobras usadas em cada seção.
*/
std::tuple<long long int, std::vector<std::pair<int, std::vector<int>>>> obtemTravessiaRadical(){

    geraCombinacoesManobras();
    int i, j, k, anterior;
  
    // Para cada seção...
    for(i = 1; i < numSecoes + 2; i++){
        
        // Para cada combinação de manobras...
        for(j = 0; j < (1 << numManobras); j++){
            
            // Para cada combinação de manobras da seção anterior...
            for(k = 0; k < (1 << numManobras); k++){
                long long int tempo_combinacao = matrix[k][j].tempo;
                
                // Só calcula se a combinação de manobras puder ser realizada no tempo da seção atual.
                if(tempo_combinacao <= tempos_secoes[i - 1]){
                    long long int valor_somado = (matrix[k][j].pontuacao * bonificacoes[i - 1]);
                    dp[i][j] = std::max(dp[i][j], dp[i - 1][k] + valor_somado);

                    // Se mudou a pontuação, guarda o índice da manobra da seção anterior.
                    if(dp[i][j] == dp[i - 1][k] + valor_somado){
                        anterior = k;
                        manobras_usadas[i][j] = k;
                    }
                }
            }

            // Se estiver na linha "extra", já calculou o que queria - não há mais o que fazer.
            if(j == 0 && i == numSecoes + 1){
                break;
            }
        }
    }

    std::vector<std::pair<int, std::vector<int>>> manobras_selecionadas(numSecoes + 1);
    int indiceManobra = anterior;
    int temp;

    // Agora, para cada seção, calcula o número de manobras e as manobras usadas. Para isso, usa o vetor de índices das manobras usadas.
    for(i = numSecoes; i > 0; i--){
        std::vector<int> manobras1;
        int contador = 0;
        temp = indiceManobra;

        for(j = 0; j < numManobras; j++){
            if((indiceManobra & 1)){
                contador++;
                manobras1.push_back(j + 1);
            }
            indiceManobra >>= 1;
        }

        manobras_selecionadas.push_back(std::make_pair(contador, manobras1));

        indiceManobra = manobras_usadas[i][temp];
    }

    std::reverse(manobras_selecionadas.begin(), manobras_selecionadas.end());


    return std::make_tuple(dp[numSecoes + 1][0], manobras_selecionadas);
}

int main(){
    long long int n = 0;
    long long int k = 0;

    std::cin >> n >> k;

    numSecoes = n;
    numManobras = k;

    for(int i = 0; i < n; i++){
        long long int bonificacao = 0;
        long long int tempo = 0;

        std::cin >> bonificacao >> tempo;
        
        bonificacoes.push_back(bonificacao);
        tempos_secoes.push_back(tempo);
    }
    
    bonificacoes.push_back(1);
    tempos_secoes.push_back(100001);

    Manobra_t manobra;
    for(int i = 0; i < k; i++){
        long long int ponto = 0;
        long long int tempo2 = 0;
        
        std::cin >> ponto >> tempo2;
        
        manobra.pontuacao = ponto;
        manobra.tempo = tempo2;
        manobras.push_back(manobra);
    }

    std::tuple<long long int, std::vector<std::pair<int, std::vector<int>>>> par = obtemTravessiaRadical();

    std::cout << std::get<0>(par) << std::endl;
    
    std::vector<std::pair<int, std::vector<int>>> manobras_selecionadas = std::get<1>(par);
    
    // Imprime o número de manobras e as manobras usadas em cada seção.
    for(int i = 0; i < n; i++){
        std::cout << manobras_selecionadas[i].first << " ";
        for(int j = 0; j < manobras_selecionadas[i].first; j++){
            std::cout << manobras_selecionadas[i].second[j] << " ";
        }
        std::cout << std::endl;
    }

    return 0;
}