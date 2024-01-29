#include "passeio.h"

int main() {
    // Inicializa o gerador de números aleatórios
    srand(time(NULL));

    // Especifica a posição inicial do cavalo
    int xInicial = 1; // Exemplo: Linha 1
    int yInicial = 1; // Exemplo: Coluna 1

    // Inicia o passeio do cavalo a partir da posição inicial
    passeio(xInicial, yInicial);

    int xAleatorio = (rand() % N) + 1;
    int yAleatorio = (rand() % N) + 1;

    // Inicia o passeio do cavalo a partir de uma posição aleatória
    passeio(xAleatorio, yAleatorio);

    return 0;
}
