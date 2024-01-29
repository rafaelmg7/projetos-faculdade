/**
 * @file   convexHull.hpp
 * @brief  File containing the definition of a convex hull
 * @author Rafael Martins Gomes
 * @date   2023-06-01
 */

#pragma once

#ifndef __CONVEXHULL_hpp__
#define __CONVEXHULL_hpp__

#include "point.hpp"
#include "stack.hpp"

/* Exceptions */
struct ExcecaoCodigoInvalido : public std::exception {
   const char * what () const throw () {
      return "Código de escolha do algoritmo de ordenação/construção do fecho inválido";
   }
};

struct ExcecaoPontosInsuficientes : public std::exception {
   const char * what () const throw () {
      return "Número de pontos insuficiente para a criação de um polígono convexo";
   }
};

struct ExcecaoArquivoNaoEncontrado : public std::exception {
   const char * what () const throw () {
      return "Arquivo não encontrado";
   }
};

struct ExcecaoDivisaoPorZero : public std::exception {
   const char * what () const throw () {
      return "Divisão por zero";
   }
};

/**
 * Class representing a convex hull
*/
class ConvexHull {
    public:
        ConvexHull(Point *points1, int nPoints);
        ~ConvexHull();

        void createHull(int code);
        void printHull();
        
    private:
        Point* points;
        Point* hull;
        int nPoints;
        int nHull;
        
        void merge(int begin, int middle, int end);
        void mergeSort(int begin, int end);
        void bucketSort();
        void getBottomMostPoint();
        int getLeftMostPoint();
        void grahamScan(int sortingCode);
        void jarvisMarch();
};


#endif // __CONVEXHULL_hpp__