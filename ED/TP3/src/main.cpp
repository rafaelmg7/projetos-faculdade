#include <iostream>
#include <iomanip>
#include <fstream>
#include <bitset>

#include "huffmanCoding.hpp"

int main(int argc, char *argv[]){
    if(argc != 4){
        std::cout << "Erro: número inválido de comandos digitado." << std::endl;
        return 1;
    }

    std::string command(argv[1]), filename1(argv[2]), filename2(argv[3]), text, aux;
    std::string outputText;

    std::ifstream file1;
    std::ofstream file2;

    HuffmanCoding huffmanCoding;

    try
    {
        if(command == "-c"){
            file1.open(filename1);
            file2.open(filename2, std::ios::binary);

            // Armazena o texto a ser codificado na string text
            if(file1.is_open()){
                while(getline(file1, aux)){
                    text += aux;
                }
                file1.close();
            }else{
                ExcecaoArquivoIncorreto e;
                throw e;
            }

            if(text.length() == 0){
                ExcecaoArquivoVazio e;
                throw e;
            }

            // Etapas para compactação:
            // 1. Popula a tabela de frequências
            // 2. Popula a lista de nós
            // 3. Constrói a árvore de Huffman
            // 4. Constrói a tabela de códigos
            // 5. Codifica o texto
            // 6. Salva o texto compactado no arquivo de saída
            // 7. Salva a tabela de frequências no arquivo de saída

            huffmanCoding.populateFrequenciesTable(text);
            huffmanCoding.populateList();
            huffmanCoding.buildTree();
            huffmanCoding.buildCodesTable();

            outputText = huffmanCoding.codeText(text);

            huffmanCoding.saveCodedText(outputText, file2);

            file2.close();

            huffmanCoding.saveFrequenciesTable(filename2);

            std::cout << "The coded text was saved in " << filename2 << "." << std::endl;
            std::cout << "The frequencies table was saved in " << filename2.substr(0, filename2.find('.')) << "_cod.txt." << std::endl;
        }
        else if(command == "-d"){
            file1.open(filename1, std::ios::binary | std::ios::ate);
            file2.open(filename2);

            if(!file1.is_open() || !file2.is_open()){
                ExcecaoArquivoIncorreto e;
                throw e;
            }

            std::string codingDataFileName = filename1.substr(0, filename1.find('.')) + "_cod.txt";
            
            std::streamsize fileSize = file1.tellg();
            file1.seekg(0, std::ios::beg);

            // Armazena o texto a ser decodificado (em binário) na string binaryString
            std::string binaryString(fileSize, ' ');
            if (!file1.read(&binaryString[0], fileSize)) {
                ExcecaoArquivoIncorreto e;
                throw e;
            }

            if(binaryString.length() == 0){
                ExcecaoArquivoVazio e;
                throw e;
            }

            file1.close();

            // Passa o texto em binário para uma string legível
            std::string stringWithCodedText;
            for (unsigned char auxChar : binaryString) {
                std::bitset<8> bits(auxChar);
                stringWithCodedText += bits.to_string();
            }

            // Etapas para descompactação:
            // 1. Constrói a tabela de frequências usando o arquivo no qual ela foi salva
            // 2. Popula a lista de nós
            // 3. Constrói a árvore de Huffman
            // 4. Constrói a tabela de códigos
            // 5. Decodifica o texto
            // 6. Salva o texto descompactado no arquivo de saída

            int numChars = huffmanCoding.buildFrequenciesTable(codingDataFileName);
            huffmanCoding.populateList();
            huffmanCoding.buildTree();
            huffmanCoding.buildCodesTable();

            outputText = huffmanCoding.decodeText(stringWithCodedText, numChars);

            file2 << outputText;
            file2.close();

            std::cout << "The decoded text was saved in " << filename2 << "." << std::endl;
        }else{
            ExcecaoComandoInvalido e;
            throw e;
        }
    }
    catch(ExcecaoArquivoIncorreto &e){
        std::cerr << e.what() << '\n';
    }
    catch(ExcecaoComandoInvalido &e){
        std::cerr << e.what() << '\n';
    }
    catch(ExcecaoArquivoTabelaFrequencias &e){
        std::cerr << e.what() << '\n';
    }
    catch(ExcecaoArquivoVazio &e){
        std::cerr << e.what() << '\n';
    }

    return 0;
}