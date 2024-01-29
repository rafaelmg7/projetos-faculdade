/**
 * @file   huffmanCoding.hpp
 * @brief  Arquivo contendo a definição da classe HuffmanCoding, que implementa o algoritmo de Huffman para compressão de arquivos de texto, e suas exceções, que são lançadas quando ocorre algum erro durante a execução do programa. As exceções são:
 * - ExcecaoArquivoIncorreto: lançada quando o arquivo de entrada não pode ser aberto.
 * - ExcecaoArquivoTabelaFrequencias: lançada quando o arquivo de frequências não pode ser aberto ou quando o arquivo de frequências está vazio.
 * - ExcecaoComandoInvalido: lançada quando o comando digitado pelo usuário é inválido.
 * - ExcecaoArquivoVazio: lançada quando o arquivo de entrada está vazio.
 * 
 * @author Rafael Martins Gomes
 * @date   2023-07-01
 */

#pragma once

#ifndef __HUFFMANCODING_hpp__
#define __HUFFMANCODING_hpp__

#include <string>
#include "list.hpp"
#include "tree.hpp"

/* Exceptions */
struct ExcecaoArquivoIncorreto : public std::exception {
    const char * what () const throw () {
        return "Erro ao abrir o arquivo";
    }
};

struct ExcecaoArquivoTabelaFrequencias : public std::exception {
    const char * what () const throw () {
        return "Erro: arquivo de frequências inválido";
    }
};

struct ExcecaoComandoInvalido : public std::exception {
    const char * what () const throw () {
        return "Erro: comando inválido";
    }
};

struct ExcecaoArquivoVazio : public std::exception {
    const char * what () const throw () {
        return "Erro: arquivo vazio";
    }
};


class HuffmanCoding{
    public:
        HuffmanCoding();
        ~HuffmanCoding();

        void populateFrequenciesTable(const std::string& text);
        void populateList();
        void buildTree();
        void buildCodesTable();
        std::string codeText(const std::string& text);
        void saveCodedText(const std::string& codedText, std::ofstream& outFile);
        void saveFrequenciesTable(std::string fileName);
        int buildFrequenciesTable(const std::string& codingInformations);
        std::string decodeText(const std::string& codedText, int numChars);
        
    private:
        int frequencies[128];
        int numChars;
        List<Node *> *nodesList;
        Tree *tree;
        std::string codesTable[128];
};

#endif // __HUFFMANCODING_hpp__
