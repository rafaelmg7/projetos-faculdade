/**
 * @file   tree.hpp
 * @brief  Arquivo contendo a definição de uma árvore binária
 * @author Rafael Martins Gomes
 * @date   2023-06-28
 */

#pragma once

#ifndef __TREE_hpp__
#define __TREE_hpp__


/* Inclusões */
#include "node.hpp"
#include "list.hpp"
#include <fstream>

/**
 * Representação de uma árvore binária. Nela, cada nó guarda um dado e pode ter dois filhos.
 * A árvore binária é usada para armazenar uma expressão numérica. Cada nó contém um termo da expressão, representado como uma string.
*/
class Tree {
    public:
        Tree();
        ~Tree();

        void buildTree(List<Node *> *nodesList);
        void buildCodesTable(std::string codesTable[]);
        void buildCodesTableAux(Node *node, std::string code, std::string codesTable[]);
        std::string decodeText(const std::string& codedText, int numChars);
        bool isEmpty();
        void deleteAll();
        void printTree();
        void printTreeAux(Node *node);

    private:
        void deleteRecursively(Node *node);

        // Apontador para o primeiro nó, i.e, a raiz da árvore.
        Node *root;
        int height;

        friend class Codes;
};

#endif // __TREE_hpp__