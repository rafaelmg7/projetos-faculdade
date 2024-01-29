#include <iostream>
#include <sstream>
#include <math.h>
#include <vector>
#include <set>
#include <algorithm>
#include <stdio.h>

using namespace std;

/**
 * @brief Estrutura que representa um vértice
*/
typedef struct Vertice {
    long long int id; // ID do vértice
    long long int tTravessia; // tTravessia (tempo de travessia) para chegar ao vértice
    long long int tConstrucao; // Tempo de construção da aresta que leva ao vértice
    long long int idPai; // ID do pai do vértice
    long long int rank; // Tamanho da componente conexa do vértice
   
    std::vector<long long int> listaArestas; // Lista de índices das arestas que chegam no vértice

    Vertice(long long int id_): id(id_) {tTravessia = 0x3f3f3f3f3f3f; tConstrucao = 0; idPai = -1; rank = 0;};

    /**
     * Sobrecarga do operador < para ordenar os vértices pelo tTravessia
     * @param p Vértice a ser comparado
     * @return true se o tTravessia do vértice for menor que o tTravessia do vértice p ou se o tTravessia for igual e o tempo de construção for menor
    */
    bool operator<(const struct Vertice& p) const{
        return (tTravessia < p.tTravessia || (tTravessia == p.tTravessia && tConstrucao < p.tConstrucao));
    }

    /**
     * Sobrecarga do operador > para ordenar os vértices pelo tTravessia
     * @param p Vértice a ser comparado
     * @return true se o tTravessia do vértice for maior que o tTravessia do vértice p ou se o tTravessia for igual e o tempo de construção for maior
    */
    bool operator>(const struct Vertice& p) const{
        return (tTravessia > p.tTravessia || (tTravessia == p.tTravessia && tConstrucao > p.tConstrucao));
    }

}Vertice_t;

/**
 * @brief Estrutura que representa uma aresta
*/
typedef struct Aresta{
    long long int idVertice1; // ID do vértice 1
    long long int idVertice2; // ID do vértice 2
    long long int tConstrucao, tTravessia; // Tempos de construção e travessia da aresta
    long long int custoConstrucao; // Custo de construção da aresta

    Aresta(long long int idVertice1_, long long int idVertice2_, long long int tConstrucao_, long long int tTravessia_, long long int custoConstrucao_): idVertice1(idVertice1_), idVertice2(idVertice2_), tConstrucao(tConstrucao_), tTravessia(tTravessia_), custoConstrucao(custoConstrucao_) {};

}Aresta_t;

/**
 * Sobrecarga do operador < para ordenar as arestas pelo tempo de construção
 * @param a Aresta a ser comparada
 * @param b Aresta a ser comparada
 * @return true se o tempo de construção da aresta a for menor que o tempo de construção da aresta b
*/
bool compareBytConstrucao(const Aresta_t& a, const Aresta_t& b){
    return a.tConstrucao < b.tConstrucao;
}

/**
 * Sobrecarga do operador < para ordenar as arestas pelo custo de construção
 * @param a Aresta a ser comparada
 * @param b Aresta a ser comparada
 * @return true se o custo de construção da aresta a for menor que o custo de construção da aresta b
*/
bool compareBycustoConstucao(const Aresta_t& a, const Aresta_t& b){
    return a.custoConstrucao < b.custoConstrucao;
}

/**
 * @brief Comparador para ordenar os vértices pelo tTravessia
*/
struct compareBytTravessia{
    bool operator()(const Vertice_t& a, const Vertice_t& b) const {
        return a.tTravessia < b.tTravessia || (a.tTravessia == b.tTravessia && a.tConstrucao < b.tConstrucao);
    }
};

/**
 * @brief Implementação do algoritmo de Dijkstra para encontrar o tempo de travessia para chegar em cada vértice e o primeiro ano no qual as distâncias colocadas são mutuamente realizáveis
*/
long long int dijkstra(std::vector<Vertice_t>& vertices, std::vector<Aresta_t>& arestas){
    vertices[0].tTravessia = 0;

    // Variável que armazenará o primeiro ano no qual as distâncias colocadas são mutuamente realizáveis
    long long int a1 = vertices[0].tConstrucao;

    std::vector<int> visitados(vertices.size() + 1, 0);

    std::set<Vertice_t, compareBytTravessia> fila;
    fila.insert(vertices[0]);

    while(!fila.empty()){
        Vertice_t u = *fila.begin();
        fila.erase(u);
        
        // Se o vértice ja foi visitado, passa pro próximo vértice na fila
        if(visitados[u.id - 1] == 0){
            visitados[u.id - 1] = 1;
        }else{
            continue;
        }

        // Se o tempo de construcao da aresta que leva ao vértice for maior que o maior tempo de construcao ate o momento, atualiza o maior tempo de construcao
        if(u.tConstrucao > a1){
            a1 = u.tConstrucao;
        }

        // Percorre todas as arestas que chegam no vértice
        for(auto& indiceAresta : u.listaArestas){

            // Se o vértice u for o vértice 1 da aresta, o vértice v é o vértice 2 da aresta, senão o vértice v é o vértice 1 da aresta
            Vertice_t& v = arestas[indiceAresta].idVertice1 == u.id ? vertices[arestas[indiceAresta].idVertice2 - 1] : vertices[arestas[indiceAresta].idVertice1 - 1];
            
            // Se o tTravessia for maior que o tempo de travessia do vértice atual mais o tempo de travessia da aresta que leva ao vértice, atualiza o tTravessia do vértice
            if(v.tTravessia > u.tTravessia + arestas[indiceAresta].tTravessia){
                v.tTravessia = u.tTravessia + arestas[indiceAresta].tTravessia;
                v.tConstrucao = arestas[indiceAresta].tConstrucao;
                fila.insert(v);
            }

            // Se o tTravessia for igual, verifica se o tempo de construcao da aresta que leva ao vértice é menor que o tempo de construcao da aresta que leva ao vértice atual  
            else if(v.tTravessia == u.tTravessia + arestas[indiceAresta].tTravessia){
                if(v.tConstrucao > arestas[indiceAresta].tConstrucao){
                    v.tConstrucao = arestas[indiceAresta].tConstrucao;
                    fila.insert(v);
                }
            }
        }
    }

    // Imprime os tempos de travessia para chegar em cada vértice
    for(auto& v : vertices){
        std::cout << v.tTravessia << std::endl;
    }

    return a1;
}

/**
 * @brief Operação que cria um conjunto com um único elemento
 * @param vertices Vetor de vértices
*/
void makeSet(std::vector<Vertice_t>& vertices){
    for(auto& vertice : vertices){
        vertice.idPai = vertice.id;
        vertice.rank = 0;
    }
}

/**
 * @brief Operação que encontra o conjunto ao qual um elemento pertence
 * @param vertices Vetor de vértices
 * @param id ID do vértice
 * @return ID da raíz do conjunto
*/
long long int findSet(std::vector<Vertice_t>& vertices, long long int id){
    if(vertices[id - 1].idPai != id){
        vertices[id - 1].idPai = findSet(vertices, vertices[id - 1].idPai);
    }
    return vertices[id - 1].idPai;
}

/**
 * @brief Operação que une dois conjuntos disjuntos
 * @param vertices Vetor de vértices
 * @param x ID do vértice 1
 * @param y ID do vértice 2
*/
void unionSet(std::vector<Vertice_t>& vertices, long long int x, long long int y){
    
    // Se os vértices estiverem no mesmo conjunto, não precisa fazer nada
    if(x == y){
        return;
    }

    // Se os ranks estiverem desiguais, transformamos a raíz de posto mais alto no pai da raíz de posto mais baixo
    if(vertices[x - 1].rank > vertices[y - 1].rank){
        vertices[y - 1].idPai = x;
    }
    // Caso contrário, escolhemos y como o pai e incrementamos seu posto  
    else{
        vertices[x - 1].idPai = y;
        if(vertices[x - 1].rank == vertices[y - 1].rank){
            vertices[y - 1].rank++;
        }
    }
}

/**
 * @brief Implementação do algoritmo de Kruskal para encontrar o primeiro ano a partir do qual todos os vértices são alcançáveis saindo do vértice 1
 * Esse algoritmo usa a heurística de união por rank e compressão de caminhos
 * @param vertices Vetor de vértices
 * @param arestas Vetor de arestas
 * @return Primeiro ano a partir do qual todos os vértices são alcançáveis saindo do vértice 1
*/
long long int kruskal(std::vector<Vertice_t>& vertices, std::vector<Aresta_t>& arestas){
    makeSet(vertices);

    // Ordena as arestas pelo tempo de construção
    std::sort(arestas.begin(), arestas.end(), compareBytConstrucao);

    // for(auto& aresta : arestas){
    //     std::cout << "pinto: " << aresta.tConstrucao << std::endl;
    // }
    
    long long int ano = 0;
    
    // Percorre o vetor de arestas unindo os vértices que não estão no mesmo conjunto e atualizando o ano desejado à medida que passe-se por uma aresta de maior ano
    for(auto& aresta : arestas){
        Vertice_t& v1 = vertices[aresta.idVertice1 - 1];
        Vertice_t& v2 = vertices[aresta.idVertice2 - 1];

        long long int set1 = findSet(vertices, v1.id);
        long long int set2 = findSet(vertices, v2.id);
    
        if(set1 != set2){
            if(aresta.tConstrucao > ano){
                ano = aresta.tConstrucao;
            }
            unionSet(vertices, set1, set2);
        }
    }

    return ano;
}

/**
 * @brief Implementação do algoritmo de Kruskal para encontrar o menor custo necessário para conectar tudo
 * @param vertices Vetor de vértices
 * @param arestas Vetor de arestas
 * @return Menor custo
*/
long long int kruskal2(std::vector<Vertice_t>& vertices, std::vector<Aresta_t>& arestas){

    makeSet(vertices);

    // Ordena as arestas pelo custo de construção
    std::sort(arestas.begin(), arestas.end(), compareBycustoConstucao);
    
    long long int custo = 0;

    // Percorre o vetor de arestas unindo os vértices que não estão no mesmo conjunto e incremendando o custo de construção   
    for(auto& aresta : arestas){
        Vertice_t& v1 = vertices[aresta.idVertice1 - 1];
        Vertice_t& v2 = vertices[aresta.idVertice2 - 1];
    
        long long int set1 = findSet(vertices, v1.id);
        long long int set2 = findSet(vertices, v2.id);
    
        if(set1 != set2){
            custo += aresta.custoConstrucao;
            unionSet(vertices, set1, set2);
        }
    }

    return custo;
}

int main(){

    int nVertices;
    int nArestas;
    int contadorArestas = 0;

    scanf("%d %d", &nVertices, &nArestas);
    
    std::vector<Vertice_t> vertices;
    std::vector<Aresta_t> arestas;

    // Insere todos os possíveis vértices no vetor de vértices de antemão
    for(int i = 0; i < nVertices; i++){
        vertices.push_back(Vertice_t(i + 1));
    }

    // Lê as próximas linhas da entrada, atualizando as listas de arestas nos vértices e o vetor de arestas
    for(int i = 0; i < nArestas; i++){
        long long int u, v, a, l, c;
        
        scanf("%lld %lld %lld %lld %lld", &u, &v, &a, &l, &c);
        
        vertices[u - 1].listaArestas.push_back(contadorArestas);
        vertices[v - 1].listaArestas.push_back(contadorArestas);
        
        Aresta_t aresta(u, v, a, l, c);
        arestas.push_back(aresta);
        
        contadorArestas++;
    }

    std::cout << dijkstra(vertices, arestas) << std::endl;
    std::cout << kruskal(vertices, arestas) << std::endl;
    std::cout << kruskal2(vertices, arestas) << std::endl;

    return 0;
}