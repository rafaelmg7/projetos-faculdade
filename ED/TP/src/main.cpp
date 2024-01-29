#include <iostream>
#include <iomanip>
#include <sstream>
#include <fstream>
#include <unistd.h>
#include <sys/time.h>
#include <sys/resource.h>

#include "leitura.hpp"

int main(){
    std::string comando;
    
    Leitura leitura;
    struct timespec start, finish;
    struct rusage start_user, end_user;
    double clock, sys, user;
    std::string tipo;

    getrusage(RUSAGE_SELF, &start_user);
    clock_gettime(CLOCK_MONOTONIC, &start);

    while(getline(std::cin, comando)){
        std::istringstream iss(comando);
        try{
            std::string aux;
            iss >> aux;
            comando.erase(comando.find(aux), aux.length());
            
            if(aux == "LER"){
                std::string exp, temp;
                iss >> tipo;
                comando.erase(comando.find(tipo), (tipo.length() + 1));
                leitura.armazenaExpressao(comando, tipo);

                std::cout << "EXPRESSAO OK: ";
                
                if(tipo == "INFIXA"){
                    leitura.imprimeInfixa();
                }else if(tipo == "POSFIXA"){
                    leitura.imprimePosfixa();
                }
            }else if(aux == "INFIXA"){
                std::cout << "INFIXA: ";
                leitura.imprimeInfixa();
            }else if(aux == "POSFIXA"){
                std::cout << "POSFIXA: ";
                leitura.imprimePosfixa();
            }else if(aux == "RESOLVE"){
                std::cout << "VAL: ";
                leitura.imprimeResultado();
            }else{
                ExcecaoComandoInvalido e;
                throw e;
            }

        }catch(ExcecaoExpressaoInvalida e){
            std::cout << "ERRO: EXP NAO VALIDA" << std::endl;
            break;
        }catch(ExcecaoExpressaoInexistente e){
            std::cout << "ERRO: EXP NAO EXISTE" << std::endl;
            break;
        }catch(ExcecaoComandoInvalido e){
            std::cout << "ERRO: COMANDO INVALIDO" << std::endl;
            break;
        }catch(ExcecaoTipoInvalido e){
            std::cout << "ERRO: TIPO NAO VALIDO" << std::endl;
            break;
        }
    }

    getrusage(RUSAGE_SELF, &end_user);
    clock_gettime(CLOCK_MONOTONIC, &finish);

    clock = (finish.tv_sec - start.tv_sec) + (finish.tv_nsec - start.tv_nsec)/10e9;
    sys = (end_user.ru_stime.tv_sec - start_user.ru_stime.tv_sec) + (end_user.ru_stime.tv_usec - start_user.ru_stime.tv_usec)/10e6;
    user = (end_user.ru_utime.tv_sec - start_user.ru_utime.tv_sec) + (end_user.ru_utime.tv_usec - start_user.ru_utime.tv_usec)/10e6;

    clock /= 8;
    clock *= 1000;

    // Para ver os tempos de relógio, usuário e sistema do programa, "descomente" a linha abaixo.
    // std::cout << "Tempo relógio: " << clock << " Tempo usuário: " << sys << " Tempo sistema: " << user << std::endl;

    return 0;
}