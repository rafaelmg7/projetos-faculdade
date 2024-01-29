#include <iostream>
#include <cstdlib>
#include <cmath>

#include "convexHull.hpp"

/**
 * Construtor da classe ConvexHull.
 * @param points1 Pontos que serão utilizados para a construção da envoltória convexa
 * @param nPoints Número de pontos que serão utilizados para a construção da envoltória convexa
*/
ConvexHull::ConvexHull(Point *points1, int nPoints){
    if (nPoints < 3){
        ExcecaoPontosInsuficientes e;
        throw e;   
    }
    this->nPoints = nPoints;
    points = new Point[nPoints];
    for(int i = 0; i < nPoints; i++){
        this->points[i] = points1[i];
    }
    hull = nullptr;
    nHull = 0;
};

/**
 * Obtém o sentido da curva formada pelos pontos p1, p2 e p3.
 * @param point1 Primeiro ponto
 * @param point2 Segundo ponto
 * @param point3 Terceiro ponto
 * @return 0 se os pontos forem colineares, -1 se forem no sentido horário e 1 se forem no sentido anti-horário
*/
int ccw(Point point1, Point point2, Point point3)
{
    int val = (point2.y - point1.y) * (point3.x - point2.x) - (point2.x - point1.x) * (point3.y - point2.y);
 
    if (val == 0) return 0;
    else if (val > 0) return -1;
    else return 1;
}

/**
 * Compara dois pontos em relação a um ponto de referência.
 * @param point0 Ponto de referência
 * @param point1 Primeiro ponto
 * @param point2 Segundo ponto
 * @return -1 se o ponto 1 estiver mais próximo de p0 e 1 caso contrário
*/
int comparePoints(Point point0, Point point1, Point point2)
{
   int isCcw = ccw(point0, point1, point2);

   // Se os pontos forem colineares, o mais próximo de p0 ficará na frente
   if (isCcw == 0){
    int dist1 = (point0.x - point1.x) * (point0.x - point1.x) + (point0.x - point1.y) * (point0.y - point1.y);
    int dist2 = (point0.x - point2.x) * (point0.x - point2.x) + (point0.x - point2.y) * (point0.y - point2.y);

    if(dist1 < dist2){
        return -1;
    }else{
        return 1;
    }
   }

   // Se o sentido for anti-horário, p1 ficará na frente de p2
   else if(isCcw == 1){
        return -1;
   }
   // Caso contrário, teremos p2 na frente de p1
   else if(isCcw == -1){
        return 1;
   }
}

/**
 * Obtém o ponto mais baixo do conjunto de pontos.
*/
void ConvexHull::getBottomMostPoint(){
    int min = 0;
    int i;

    for(i = 1; i < nPoints; i++){
        // Se houver algum y menor, atualiza o mínimo.
        if(points[i].y < points[min].y){
            min = i;
        }
        // Em caso de empate, compara as coordenadas x e define como mínimo o mais à esquerda.
        else if(points[i].y == points[min].y){
            if(points[i].x < points[min].x){
                min = i;
            }
        }
    }
 
    // Coloca o ponto mais baixo na primeira posição do vetor
    Point aux = points[0];
    points[0] = points[min];
    points[min] = aux;
}

/**
 * Obtém o ponto mais à esquerda do conjunto de pontos.
 * @return O índice do ponto mais à esquerda
*/
int ConvexHull::getLeftMostPoint(){
    int min = 0;
    int i;

    for(i = 1; i < nPoints; i++){
        // Se houver algum x menor, atualiza o mínimo.
        if(points[i].x < points[min].x){
            min = i;
        }
        // Em caso de empate, compara as coordenadas y e define como mínimo o mais baixo.
        else if(points[i].x == points[min].x){
            if(points[i].y < points[min].y){
                min = i;
            }
        }
    }

    return min;
}

/**
 * Faz a junção de dois subvetores ordenados.
 * @param begin Índice do início do subvetor
 * @param middle Índice do meio do subvetor
 * @param end Índice do fim do subvetor
*/
void ConvexHull::merge(int begin, int middle, int end) {
    int nl = middle - begin + 1;
    int nr = end - middle;
    Point *valuesL = new Point[nl];
    Point *valuesR = new Point[nr];

    // Popula os vetores da esquerda e da direita
    for(int i = 0; i < nl; i++){
        valuesL[i].x = points[begin + i].x;
        valuesL[i].y = points[begin + i].y;
    }

    for(int j = 0; j < nr; j++){
        valuesR[j].x = points[middle + 1 + j].x;
        valuesR[j].y = points[middle + 1 + j].y;
    }

    int i = 0;
    int j = 0;
    int k = begin;
    while (i < nl && j < nr) {
        // Se o da esquerda for o menor, coloca ele no vetor de pontos
        if (comparePoints(points[0], valuesL[i], valuesR[j]) == -1) {
            points[k].x = valuesL[i].x;
            points[k].y = valuesL[i].y;
            i++;
        }
        // Caso contrário, coloca o da direita
        else if (comparePoints(points[0], valuesL[i], valuesR[j]) == 1){
            points[k].x = valuesR[j].x;
            points[k].y = valuesR[j].y;
            j++;
        }
        k++;
    }

    // Percorre os vetores da esquerda e da direita colocando os elementos restantes no vetor de pontos
    for(; i < nl; i++) {
        points[k].x = valuesL[i].x;
        points[k].y = valuesL[i].y;
        k++;
    }
    for(; j < nr; j++) {
        points[k].x = valuesR[j].x;
        points[k].y = valuesR[j].y;
        k++;
    }

    // Libera a memória
    delete[] valuesL;
    delete[] valuesR;
}

/**
 * Ordena um vetor de pontos recursivamente usando o algoritmo Merge Sort.
 * @param begin Índice do primeiro elemento do vetor.
 * @param end Índice do último elemento do vetor.
*/
void ConvexHull::mergeSort(int begin, int end){
    if(begin < end){
        int middle = (begin + end) / 2;
        mergeSort(begin, middle);
        mergeSort(middle + 1, end);
        merge(begin, middle, end);
    }
}

/**
 * Ordena um vetor de pontos usando o algoritmo Insertion Sort.
 * @param points Vetor de pontos a ser ordenado.
 * @param p0 Ponto mais baixo do vetor.
 * @param begin Índice do primeiro elemento do vetor a ser considerado na ordenação.
 * @param size Tamanho do vetor.
*/
void insertionSort(Point* points, Point p0, int begin, int size){ 
    int i,j;
    Point aux;
    for (i = begin + 1; i < size; i++) {
        aux = points[i];
        j = i - 1;
        while (j >= 0  && (comparePoints(p0, aux, points[j]) == -1)) {
            points[j + 1] = points[j];
            j--;
        }
        points[j + 1] = aux;
    }
}

/**
 * Ordena um vetor de pontos usando o algoritmo Bucket Sort.
*/
void ConvexHull::bucketSort(){
    int i, j, nBuckets;

    // O maior ângulo que podemos obter é 180. Sendo assim, dividimos o intervalo de 0 a 180 em 9 baldes.
    nBuckets = 9;

    Point **buckets = new Point*[nBuckets];
    int count[nBuckets];
    for(i = 0; i < nBuckets; i++){
        count[i] = 0;
        buckets[i] = new Point[nPoints];
    }

    for (i = 1; i < nPoints; i++){

        // Ignora pontos iguais ao ponto mais baixo
        if(points[i].x == points[0].x && points[i].y == points[0].y){
            continue;
        }

        // Calcula o ângulo entre o ponto mais baixo e o ponto atual e o converte para graus
        double angle = atan2(points[i].y - points[0].y, points[i].x - points[0].x) * 180 / M_PI;

        // Caso o ângulo seja negativo, soma 360 para que ele fique positivo
        if(angle < 0){
            angle += 360;
        }

        int index;

        // Mapeia o ângulo para um dos 9 baldes
        if(angle >= 0 && angle <= 20){
            index = 0;
        }else if(angle > 20 && angle <= 40){
            index = 1;
        }else if(angle > 40 && angle <= 60){
            index = 2;
        }else if(angle > 60 && angle <= 80){
            index = 3;
        }else if(angle > 80 && angle <= 100){
            index = 4;
        }else if(angle > 100 && angle <= 120){
            index = 5;
        }else if(angle > 120 && angle <= 140){
            index = 6;
        }else if(angle > 140 && angle <= 160){
            index = 7;
        }else if(angle > 160 && angle <= 180){
            index = 8;
        }

        buckets[index][count[index]++] = points[i];
    }

    // Ordena cada um dos baldes
    for(i = 0; i < nBuckets; i++){
        insertionSort(buckets[i], points[0], 0, count[i]);
    }

    int k = 1;
    // Insere os pontos ordenados de volta no vetor de pontos
    for(i = 0; i < nBuckets; i++){
        for(j = 0; j < count[i]; j++){
            points[k] = buckets[i][j];
            k++;
        }
    }
    
    for(i = 0; i < nBuckets; i++){
        delete[] buckets[i];
    }
    delete[] buckets;

}


/**
 * Cria um fecho convexo usando o algoritmo Graham Scan.
 * @param sortingCode Código que indica qual algoritmo de ordenação será usado para ordenar os pontos.
*/
void ConvexHull::grahamScan(int sortingCode){
    if(nPoints > 2){
        int i;

        Stack<Point> *stack = new Stack<Point>();

        // Pega o ponto mais baixo e o coloca na primeira posição do vetor
        getBottomMostPoint();

        switch (sortingCode)
        {
        case 0:
            mergeSort(1, nPoints - 1);
            break;

        case 1:
            insertionSort(points, points[0], 1, nPoints);
            break;

        case 2:
            bucketSort();
            break;
        default:
            break;
        }

        int newSize = 1;
        // Remove pontos colineares
        for (int i = 1; i < nPoints; i++)
        {   
            // Passa pelos pontos colineares ao ponto atual até chegar no mais distante
            for(; i < nPoints - 1; i++){
                if(ccw(points[0], points[i], points[i + 1]) != 0){
                    break;
                }
            }

            // Guarda apenas o ponto colinear mais distante
            points[newSize] = points[i];
            newSize++;
        }

        // Caso não haja pontos não-colineares o suficiente para fazer um fecho, não faz sentido continuar.
        if (newSize < 3){
            ExcecaoPontosInsuficientes e;
            throw e;
        }
        
        for(i = 0; i < newSize; i++){
            while(stack->getSize() >= 2 && ccw(stack->getSecond()->getData(), stack->getTop()->getData(), points[i]) <= 0){
                stack->pop();
            }
            stack->push(points[i]);
        }

        this->hull = new Point[stack->getSize()];
        this->nHull = stack->getSize();
        
        i = stack->getSize() - 1;

        // Desempilha os pontos da pilha e os coloca no vetor de fecho convexo
        while(!stack->isStackEmpty()){
            Point p = stack->getTop()->getData();
            hull[i--] = p;
            stack->pop();
        }

        delete stack;

    }else{
        ExcecaoPontosInsuficientes e;
        throw e;
    }
}

/**
 * Cria um fecho convexo usando o algoritmo Jarvis March.
*/
void ConvexHull::jarvisMarch(){
    if(nPoints > 2){
        int *indexes = new int[nPoints];
        int i, j;
        int endpoint;
        int min = getLeftMostPoint();

        i = 0;

        do{
            indexes[i] = min;
            endpoint = 0;

            for(j = 0; j < nPoints; j++){
                int isCcw = ccw(points[indexes[i]], points[j], points[endpoint]);
                int dist1 = (points[j].x - points[indexes[i]].x) * (points[j].x - points[indexes[i]].x) + (points[j].x - points[indexes[i]].y) * (points[j].y - points[indexes[i]].y);
                int dist2 = (points[endpoint].x - points[indexes[i]].x) * (points[endpoint].x - points[indexes[i]].x) + (points[endpoint].x - points[indexes[i]].y) * (points[endpoint].y - points[indexes[i]].y);
                if(endpoint == min || isCcw == 1 || (isCcw == 0 && dist1 > dist2)){
                    endpoint = j;
                }
            }
            i++;
            min = endpoint;
        }while(endpoint != indexes[0]);

        this->hull = new Point[i];

        for(j = 0; j < i; j++){
            this->hull[j] = points[indexes[j]];
        }

        this->nHull = i;

        delete[] indexes;
    }else{
        ExcecaoPontosInsuficientes e;
        throw e;
    }
}

/**
 * Cria um fecho convexo usando um dos algoritmos previamente implementados
 * @param code Código que indica qual algoritmo será usado para criar o fecho convexo.
 * 0 - Graham Scan com Merge Sort;
 * 1 - Graham Scan com Insertion Sort;
 * 2 - Graham Scan com Bucket Sort;
 * 3 - Jarvis March
 * @throw ExcecaoCodigoInvalido Caso o código passado não seja válido.
 * @see ConvexHull::grahamScan
 * @see ConvexHull::jarvisMarch
*/
void ConvexHull::createHull(int code){
    switch(code){
        case 0:
            this->grahamScan(code);
            break;
        case 1:
            this->grahamScan(code);
            break;
        case 2:
            this->grahamScan(code);
            break;
        case 3:
            this->jarvisMarch();
            break;
        default:
            ExcecaoCodigoInvalido e;
            throw e;
            break;
    }
}

/**
 * Imprime o fecho convexo.
*/
void ConvexHull::printHull(){
    for(int i = 0; i < this->nHull; i++){
        std::cout << hull[i].x << " " << hull[i].y << std::endl;
    }
}

/**
 * Destrutor da classe ConvexHull.
*/
ConvexHull::~ConvexHull(){
    delete[] points;
    delete[] hull;
}
