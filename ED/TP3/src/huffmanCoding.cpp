#include <iostream>
#include <fstream>
#include <cstring>
#include <cstdlib>
#include <cctype>

#include "huffmanCoding.hpp"

/**
 * Cria um objeto da classe HuffmanCoding.
*/
HuffmanCoding::HuffmanCoding(){
    int i;
    for (i = 0; i < 128; i++){
        frequencies[i] = 0;
    }
    tree = new Tree();
    nodesList = new List<Node *>();
    numChars = 0;
}

/**
 * Popula a tabela de frequências com base no texto a ser codificado.
 * @param text Texto a ser codificado.
*/
void HuffmanCoding::populateFrequenciesTable(const std::string& text){
    int i;
    for(i = 0; i < text.length(); i++){
        frequencies[text[i]]++;
        numChars++;
    }
}

/**
 * Popula a lista de nós com base na tabela de frequências e no texto a ser codificado.
 * A lista contém os símbolos (caracteres) que aparecem no texto e suas respectivas frequências. Ela é ordenada por frequência.
*/
void HuffmanCoding::populateList(){
    int i;

    for(i = 0; i < 128; i++){
        if(frequencies[i] != 0){
            DataType_t data = {char(i), frequencies[i]};
            Node *newNode = new Node(data);
            nodesList->insertOrdered(newNode);
        }
    }
}

/**
 * Constrói a árvore de Huffman a partir da lista de nós.
 * É usada a função buildTree() da classe Tree.
 * @see Tree::buildTree()
*/
void HuffmanCoding::buildTree(){
    tree->buildTree(nodesList);
}

/**
 * Constrói a tabela de códigos com base na árvore de Huffman.
 * @see Tree::buildCodesTable()
*/
void HuffmanCoding::buildCodesTable(){
    tree->buildCodesTable(codesTable);
}


/**
 * Codifica um texto.
 * @param text Texto a ser codificado.
 * @return Texto codificado.
*/
std::string HuffmanCoding::codeText(const std::string& text) {
    std::string codedText = "";

    for (char c : text) {
        codedText += codesTable[static_cast<unsigned char>(c)];
    }

    return codedText;
}

/**
 * Salva o texto codificado em um arquivo binário.
 * @param codedText Texto codificado.
 * @param outFile Arquivo binário a ser salvo.
*/
void HuffmanCoding::saveCodedText(const std::string& codedText, std::ofstream& outFile) {
    
    unsigned char buffer = 0;
    int bufferLength = 0;
    int remainingBits = codedText.size() % 8;

    for (char bit : codedText) {
        buffer <<= 1;
        buffer |= (bit - '0');

        bufferLength++;

        if (bufferLength == 8) {
            outFile.put(buffer);
            buffer = 0;
            bufferLength = 0;
        }
    }

    if (remainingBits > 0) {
        buffer <<= (8 - remainingBits);
        outFile.put(buffer);
    }
}

/**
 * Salva a tabela de códigos em um arquivo de texto.
 * @param fileName Nome do arquivo de texto a ser salvo.
*/
void HuffmanCoding::saveFrequenciesTable(std::string fileName){
    int i;
    std::string newFileName = fileName.substr(0, fileName.find('.')) + "_cod.txt";
    std::ofstream file(newFileName);

    for(i = 0; i < 128; i++){
        if(frequencies[i] != 0){
            file << char(i) << " " << frequencies[i] << std::endl;
        }
    }

    // Caractere especial para indicar o número de caracteres do texto original
    file << char(200) << " " << numChars << std::endl;

    file.close();
}

/** ------------------------------------------------- FUNÇÕES USADAS NA DECODIFICAÇÃO -------------------------------------------------------*/


/**
 * Constrói a tabela de frequências a partir de um arquivo de texto com as informações de codificação (dados da tabela de frequências).
 * Aqui, pega-se cada linha do arquivo, que contém um símbolo e seu número de ocorrências, e insere-se essas informações na tabela de frequências.
 * @param codingInformations Nome do arquivo de texto com as informações de codificação.
 * @return Número de caracteres do texto original.
*/
int HuffmanCoding::buildFrequenciesTable(const std::string& codingInformations){
    std::string line;
    std::ifstream codingFile(codingInformations);
    if(!codingFile.is_open()){
        ExcecaoArquivoTabelaFrequencias e;
        throw e;
    }

    int numChars = 0;

    while(std::getline(codingFile, line)){
        char symbol = line[0];
    
        std::string code;

        for(int i = 2; i < line.size(); i++){
            code += line[i];
        }

        // Se achou o caractere especial (que deve estar no final do arquivo), pega o número de caracteres do texto original
        if(symbol == char(200)){
            numChars = std::stoi(code);
            continue;
        }

        frequencies[symbol] = std::stoi(code);
    }

    codingFile.close();

    if(numChars == 0){
        ExcecaoArquivoTabelaFrequencias e;
        throw e;
    }

    return numChars;
}


/**
 * Decodifica um texto.
 * @param text Texto a ser decodificado.
 * @return Texto decodificado.
*/
std::string HuffmanCoding::decodeText(const std::string& codedText, int numChars) {
    return (tree->decodeText(codedText, numChars));
}

/** ------------------------------------------------------------------------------------------------------------------------------------*/

/**
 * Destrói um objeto da classe HuffmanCoding.
 * @see Tree::~Tree()
 * @see List::~List()
*/
HuffmanCoding::~HuffmanCoding(){
    delete tree;
    delete nodesList;
}