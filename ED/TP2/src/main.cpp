#include <iostream>
#include <iomanip>
#include <sstream>
#include <fstream>
#include <unistd.h>
#include <sys/time.h>
#include <sys/resource.h>

#include "convexHull.hpp"

int main(int argc, char *argv[]){
    if(argc != 2){
        std::cout << "Usage: fecho <filename>" << std::endl;
        return -1;
    }

    struct timespec start, finish;
    double clock;

    ConvexHull *convex;
    Stack<Point> stack;
    Point *points;
    
    std::ifstream file;
    std::string filename(argv[1]);
    file.open(filename);
    if(!file.is_open()){
        ExcecaoArquivoNaoEncontrado e;
        throw e;
    }

    try
    {
        std::string line;

        int size = 0;
        Point aux;

        // Leitura dos pontos do arquivo
        while(std::getline(file, line)){
            std::istringstream iss(line);
            int x, y;
            iss >> x >> y;
            aux = Point(x, y);
            stack.push(aux);
            size++;
        }

        points = new Point[size];
        for(int i = 0; i < size; i++){
            points[i] = stack.pop();
        }
        std::string methods[] = {"MERGESORT", "INSERTIONSORT", "BUCKETSORT", "JARVIS"};

        // Execução dos algoritmos
        for(int i = 0; i < 4; i++){
            convex = new ConvexHull(points, size);
            clock_gettime(CLOCK_MONOTONIC, &start);
            convex->createHull(i);
            clock_gettime(CLOCK_MONOTONIC, &finish);

            clock = (finish.tv_sec - start.tv_sec) + (finish.tv_nsec - start.tv_nsec)/10e9;

            clock /= 8;
            clock *= 1000;

            if(i == 0){
                std::cout << "FECHO CONVEXO:" << std::endl;
                convex->printHull();
                std::cout << std::endl;
            }
            if(i < 3){
                std::cout << "GRAHAM+" << methods[i] << ": " << std::fixed << std::setprecision(4) << clock << std::endl;
            }
            else if(i == 3){
                std::cout << methods[i] << ": " << std::fixed << std::setprecision(4) << clock << std::endl;
            }
        }
    }
    // Tratamento de exceções
    catch(ExcecaoCodigoInvalido &e){
        std::cout << "Erro: " << e.what() << std::endl;
    }catch(ExcecaoPontosInsuficientes &e){
        std::cout << "Erro: " << e.what() << std::endl;
    }catch(ExcecaoArquivoNaoEncontrado &e){
        std::cout << "Erro: " << e.what() << std::endl;
        return -1;
    }

    delete convex;
    delete[] points;
    file.close();

    return 0;
}