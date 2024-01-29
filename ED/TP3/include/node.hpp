/**
 * @file   node.hpp
 * @brief  Arquivo contendo a definição de um nó da árvore
 * @author Rafael Martins Gomes
 * @date   2023-06-28
 */

#pragma once

#ifndef __NODE_hpp__
#define __NODE_hpp__

#include <string>

typedef struct DataType{
    char symbol;
    int frequency;
}DataType_t;

/**
 * Classe com informações de um nó da árvore.
 * O nó contém um dado do tipo string e apontadores para os filhos da esquerda e da direita.
*/
class Node {
    public:
        /**
         * Construtor que inicaliza um novo nó.
         * @param data Dado a ser inserido na árvore.
        */
        Node(DataType_t data){
            this->data = data;
            left = nullptr;
            right = nullptr;
        };

        /**
         * Overload do operador de comparação.
        */
        bool operator<(const Node& rhs) const{
            return data.frequency < rhs.data.frequency;
        }

    private:
        DataType_t data;
        Node *left;
        Node *right;

    friend class Tree;
};

#endif // __NODE_hpp__