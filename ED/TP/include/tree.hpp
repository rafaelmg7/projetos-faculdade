/**
 * @file   tree.hpp
 * @brief  Arquivo contendo a definição de uma árvore binária
 * @author Rafael Martins Gomes
 * @date   2023-04-22
 */

#pragma once

#ifndef __TREE_hpp__
#define __TREE_hpp__


/* Inclusões */
#include "node.hpp"

bool isOperator(DataType_t op); 
bool isNum(const std::string& str);

/**
 * Representação de uma árvore binária. Nela, cada nó guarda um dado e pode ter dois filhos.
 * A árvore binária é usada para armazenar uma expressão numérica. Cada nó contém um termo da expressão, representado como uma string.
*/
class Tree {
    public:
        Tree();
        ~Tree();

        void buildTree(DataType_t expressao);
        bool isEmpty();
        void traverse(int type);
        double returnResult();
        void deleteAll();

    private:
        void deleteRecursively(Node *node);
        void preOrder(Node *node);
        void inOrder(Node *node);
        void postOrder(Node *node);
        double solveExpression(Node *node);

        // Apontador para o primeiro nó, i.e, a raiz da árvore.
        Node *root;
};

#endif // __TREE_hpp__