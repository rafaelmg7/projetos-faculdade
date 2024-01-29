#include <iostream>
#include <cstring>
#include <cstdlib>
#include <fstream>

#include "tree.hpp"

/**
 * Cria uma árvore vazia.
*/
Tree::Tree(){
    root = nullptr;
}

/**
 * Destrutor da classe. Remove todos os nós da árvore com uma função auxiliar.
*/
Tree::~Tree(){
    deleteAll();
}

/**
 * Verifica se a árvore está vazia.
 * @return "true" se a árvore estiver vazia (i.e., se a raiz não for algum nó) e "false" caso contrário.
*/
bool Tree::isEmpty(){
    return (root == nullptr);
}

/**
 * Constrói a árvore de Huffman a partir de uma lista de nós.
 * Aqui, pega-se os dois primeiros nós da lista (que têm as menores frequências), cria-se um novo nó com a soma das frequências dos dois nós e insere-se esse novo nó na lista.
 * Esse processo é repetido até que reste apenas um nó na lista, que será a raiz da árvore.
 * @param nodesList Lista de nós ordenada por frequência.
*/
void Tree::buildTree(List<Node *> *nodesList){
    Node *left, *right, *newNode;
    DataType_t data;

    while(nodesList->getSize() > 1){  
        left = nodesList->deleteFirst();
        right = nodesList->deleteFirst();
        data = {'*', left->data.frequency + right->data.frequency};
        newNode = new Node(data);
        newNode->left = left;
        newNode->right = right;

        nodesList->insertOrdered(newNode);
    }

    this->root = nodesList->deleteFirst();
}

/**
 * Constrói uma tabela de códigos a partir da árvore de Huffman.
 * @param codesTable Tabela de códigos a ser preenchida.
 * @see buildCodesTableAux()
*/
void Tree::buildCodesTable(std::string codesTable[]){
    std::string code = "";
    buildCodesTableAux(root, code, codesTable);
}

/**
 * Função auxiliar para construir a tabela de códigos.
 * @param node Nó atual.
 * @param code Código atual.
 * @param codesTable Tabela de códigos a ser preenchida.
*/
void Tree::buildCodesTableAux(Node *node, std::string code, std::string codesTable[]){
    if(node->left == nullptr && node->right == nullptr){
        codesTable[node->data.symbol] = code;
    }else{
        buildCodesTableAux(node->left, code + '0', codesTable);
        buildCodesTableAux(node->right, code + '1', codesTable);
    }
}

/**
 * Decodifica um texto a partir da árvore de Huffman.
 * @param text Texto a ser decodificado.
 * @param numChars Número de caracteres a serem decodificados.
 * @return Texto decodificado.
*/
std::string Tree::decodeText(const std::string& codedText, int numChars){
    std::string decodedText = "";
    Node *aux = root;

    for(char bit : codedText){
        if(numChars == 0){
            break;
        }

        if(bit == '0'){
            aux = aux->left;
        }else{
            aux = aux->right;
        }

        if(aux->left == nullptr && aux->right == nullptr){
            decodedText += aux->data.symbol;
            aux = root;
            numChars--;
        }
    }
    return decodedText;
}

void Tree::printTree(){
    printTreeAux(root);
}

void Tree::printTreeAux(Node *node){
    if(node != nullptr){
        printTreeAux(node->left);
        std::cout << node->data.symbol << " " << node->data.frequency << std::endl;
        printTreeAux(node->right);
    }
}


/**
 * Apaga um nó da árvore e seus descendentes recursivamente, passando pelas sub-árvores da esquerda e da direita e deletando-as.
 * @param node Nó a ser removido.
*/
void Tree::deleteRecursively(Node *node){
    if(node != nullptr){
        deleteRecursively(node->left);
        deleteRecursively(node->right);
        delete node;
    }
}

/**
 * Apaga todos os nós da árvore.
*/
void Tree::deleteAll(){
    deleteRecursively(root);
    root = nullptr;
}