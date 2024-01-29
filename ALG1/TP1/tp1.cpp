#include <iostream>
#include <sstream>
#include <math.h>
#include <vector>
#include <map>
#include <algorithm>

#define ADJACENTE_NAO_VISITADO false
#define ADJACENTE_VISITADO true

using namespace std;

/**
 * @brief Estrutura que representa um ponto no plano cartesiano.
 * @param x Coordenada x do ponto.
 * @param y Coordenada y do ponto.
 * @param id Identificador do ponto.
 * @param listaAdjacencia Lista de adjacência do ponto.
 * @param adjacentesVisitados Mapa que indica se um ponto adjacente já foi visitado.
*/
typedef struct Ponto {
    double x, y;
    int id;
   
    std::vector<int> listaAdjacencia;
    std::map<int, bool> adjacentesVisitados;


    Ponto(double x_, double y_, int id_): x(x_), y(y_), id(id_) {};

    bool operator==(const struct Ponto& p) const{
        return (x == p.x && y == p.y);
    }

    bool operator!=(const struct Ponto& p) const{
        return (x != p.x || y != p.y);
    }

}Ponto_t;

// Coeficiente da reta orientada de p para q.
double InclinacaoRelativa(const Ponto_t& p, const Ponto_t& q) {
    double angle = atan2(q.y - p.y, q.x - p.x);
    if (angle < 0) {
        angle += 2 * M_PI;
    }
    return angle;
}

/**
 * @brief Função que realiza uma busca em profundidade para encontrar as faces de um grafo.
 * @param v Ponto inicial da busca.
 * @param idPai Identificador do ponto pai, i.e., do ponto anterior ao ponto v.
 * @param vertices_face Vetor que armazena os identificadores dos pontos que compõem uma face.
 * @param vertices Vetor que armazena os pontos do grafo.
 * @return Retorna true se a busca encontrou uma face e false caso contrário.
*/
bool DFSzinho(Ponto_t& v, int idPai, std::vector<int>& vertices_face, std::vector<Ponto_t>& vertices){
    vertices_face.push_back(v.id);
    
    // Encontra o ponto anterior na lista de adjacência e define o ponto posterior a ele como o próximo a ser visitado. 
    auto proximo = std::find(v.listaAdjacencia.begin(), v.listaAdjacencia.end(), idPai);
    ++proximo;
    if(proximo == v.listaAdjacencia.end()){
        proximo = v.listaAdjacencia.begin();
    }

    // Se o ponto atual é o ponto inicial, o tamanho do vetor de pontos da face é maior que 3 e o próximo ponto já foi visitados, então encontramos uma face.
    if(vertices_face.size() > 3 && vertices_face.front() == vertices_face.back() && v.adjacentesVisitados[*proximo] == ADJACENTE_VISITADO){
        return true;
    }

    // Se o próximo ponto ainda não foi visitado, então fazemos uma busca em profundidade a partir dele.
    if (v.adjacentesVisitados[*proximo] == ADJACENTE_NAO_VISITADO){
        v.adjacentesVisitados[*proximo] = ADJACENTE_VISITADO;
        return DFSzinho(vertices[*proximo - 1], v.id, vertices_face, vertices);
    }
    
    // Se chegou até aqui, deu biziu.
    return false;
}

/**
 * @brief Função que obtém as faces de um grafo.
 * @param vertices Vetor que armazena os pontos do grafo.
 * @return Retorna um vetor de vetores de inteiros, onde cada vetor de inteiros representa uma face. Os inteiros representam os identificadores dos pontos que compõem a face.
*/
std::vector<std::vector<int>> pegaFaces(std::vector<Ponto_t>& vertices){
    std::vector<std::vector<int>> faces;
    std::vector<int> vertices_face;

    // Para cada ponto do grafo, fazemos uma busca em profundidade a partir dele.
    for(auto& vertice : vertices){
        for(auto& adj : vertice.listaAdjacencia){
            vertices_face.push_back(vertice.id);
            vertice.adjacentesVisitados[adj] = ADJACENTE_VISITADO;

            // Se a busca em profundidade encontrou uma face, então adicionamos ela ao vetor de faces.
            if(DFSzinho(vertices[adj - 1], vertice.id, vertices_face, vertices)){
                faces.push_back(vertices_face);
            }

            vertices_face.clear();
        }
    }

    return faces;
}


int main(){

    int nVertices;
    int nArestas;
    int contadorId = 1;
    std::string line;

    std::getline(std::cin, line);
    std::istringstream iss(line);
    iss >> nVertices >> nArestas;
    
    std::vector<Ponto_t> vertices;

    line.clear();

    while(std::getline(std::cin, line)){
        std::istringstream iss(line);
        double x, y;
        iss >> x >> y;

        Ponto_t p(x, y, contadorId);
        contadorId++;

        int grau;
        iss >> grau;

        for(int i = 0; i < grau; i++){
            int adj;
            iss >> adj;
            p.listaAdjacencia.push_back(adj);
            p.adjacentesVisitados[adj] = ADJACENTE_NAO_VISITADO;
        }

        vertices.push_back(p);
    }

    line.clear();

    // Ordena a lista de adjacência de cada ponto de acordo com a inclinação relativa entre os pontos.
    for(auto& vertice : vertices){
        std::sort(vertice.listaAdjacencia.begin(), vertice.listaAdjacencia.end(), [&](int a, int b){
            return InclinacaoRelativa(vertice, vertices[a-1]) < InclinacaoRelativa(vertice, vertices[b-1]);
        });
    }

    std::vector<std::vector<int>> faces = pegaFaces(vertices);

    std::cout << faces.size() << std::endl;
    for (auto face : faces){
        std::cout << face.size() << " ";
        for(auto ponto : face){
            std::cout << ponto << " ";
        }
        std::cout << std::endl;
    }

    vertices.clear();
    faces.clear();

    return 0;
}