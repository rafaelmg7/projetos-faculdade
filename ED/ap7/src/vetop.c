//---------------------------------------------------------------------
// Arquivo      : vetop.c
// Conteudo     : programa de avaliacao do TAD VET 
// Autor        : Wagner Meira Jr. (meira@dcc.ufmg.br)
// Historico    : 2022-04-01 - arquivo criado
// 		  2023-05-16 - time measurement 
//---------------------------------------------------------------------

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <getopt.h>
#include <string.h>
#include <time.h>
#include "../include/vet.h"
#include "../include/msgassert.h" 

// definicoes de operacoes a serem testadas
#define OPSOMA 1
#define OPPRODUTOINTERNO 2
#define OPNORMA 3
#define OPHEAP 4
#define OPSHELL 5

typedef struct opt{
  int opescolhida;
  int tamini;
  int tamfim;
  int tampasso;
} opt_tipo;

void uso()
// Descricao: imprime as opcoes de uso
// Entrada: nao tem
// Saida: impressao das opcoes de linha de comando
{
  fprintf(stderr,"vetop\n");
  fprintf(stderr,"\t-i <int>\t(dimensao inicial)\n");
  fprintf(stderr,"\t-f <int>\t(dimensao final)\n");
  fprintf(stderr,"\t-t <int>\t(passo experimental)\n");
  fprintf(stderr,"\t-s \t\t(somar vetores) \n");
  fprintf(stderr,"\t-p \t\t(produto interno de dois vetores) \n");
  fprintf(stderr,"\t-n \t\t(norma vetor)\n");
}


void parse_args(int argc,char ** argv, opt_tipo * opt)
// Descricao: le as opcoes da linha de comando e inicializa variaveis
// Entrada: argc, argv, opt
// Saida: opt
{
     // variaveis externas do getopt
     extern char * optarg;
     extern int optind;

     // variavel auxiliar
     int c;

     // inicializacao variaveis globais para opcoes
     opt->opescolhida = -1;
     opt->tamini = -1;
     opt->tamfim = -1;
     opt->tampasso = -1;

     // getopt - letra indica a opcao, : junto a letra indica parametro
     // no caso de escolher mais de uma operacao, vale a ultima
     while ((c = getopt(argc, argv, "i:f:t:spnhel")) != EOF){
       switch(c) {
         case 'p':
		  avisoAssert(opt->opescolhida==-1,
		              "Mais de uma operacao escolhida");
	          opt->opescolhida = OPPRODUTOINTERNO;
                  break;
         case 's':
		  avisoAssert(opt->opescolhida==-1,
		              "Mais de uma operacao escolhida");
	          opt->opescolhida = OPSOMA;
                  break;
         case 'n':
		  avisoAssert(opt->opescolhida==-1,
		              "Mais de uma operacao escolhida");
	          opt->opescolhida = OPNORMA;
                  break;
        case 'e':
		  avisoAssert(opt->opescolhida==-1,
		              "Mais de uma operacao escolhida");
	          opt->opescolhida = OPHEAP;
                  break;
        case 'l':
		  avisoAssert(opt->opescolhida==-1,
		              "Mais de uma operacao escolhida");
	          opt->opescolhida = OPSHELL;
                  break;
         case 'i': 
	          opt->tamini = atoi(optarg);
		  break;
         case 'f': 
	          opt->tamfim = atoi(optarg);
		  break;
         case 't': 
	          opt->tampasso = atoi(optarg);
		  break;
         case 'h':
         default:
                  uso();
                  exit(1);

       }
     }
     // verificacao da consistencia das opcoes
     erroAssert(opt->opescolhida>0,"vetop - necessario escolher operacao");
     erroAssert(opt->tamini>0, "vetop - tamanho do vetor tem que ser positivo");
     erroAssert(opt->tamini<MAXTAM, "vetop - tamanho do vetor tem que ser positivo");
     erroAssert(opt->tamfim>0, "vetop - tamanho do vetor tem que ser positivo");
     erroAssert(opt->tamfim<MAXTAM, "vetop - tamanho do vetor tem que ser positivo");
}

void clkDiff(struct timespec t1, struct timespec t2,
                   struct timespec * res)
// Descricao: calcula a diferenca entre t2 e t1, que e armazenada em res
// Entrada: t1, t2
// Saida: res
{
  if (t2.tv_nsec < t1.tv_nsec){
    // ajuste necessario, utilizando um segundo de tv_sec
    res-> tv_nsec = 1000000000+t2.tv_nsec-t1.tv_nsec;
    res-> tv_sec = t2.tv_sec-t1.tv_sec-1;
  } else {
    // nao e necessario ajuste
    res-> tv_nsec = t2.tv_nsec-t1.tv_nsec;
    res-> tv_sec = t2.tv_sec-t1.tv_sec;
  }
}

// void Refaz(int Esq, int Dir, vetor_tipo *A){
//     int i, j; 
//     double x;
//     i = Esq;
//     j = (i * 2) + 1;
//     x = A->v[i];
//     while (j <= Dir){
//         if (j < Dir)
//             if (A->v[j] < A->v[j+1]) j++;
//         if (x >= A->v[j]) break;
//         A->v[i] = A->v[j];
//         i = j; 
//         j = (i * 2) + 1;
//     }
//     A->v[i] = x;
// }

// void Constroi(vetor_tipo *A, int n) {
//     int Esq;
//     Esq = (n / 2) + 1;
//     while ((Esq) > 0) { 
//         Esq--;
//         Refaz(Esq - 1, n, A);
//     }
// }


// void Heapsort(vetor_tipo *A, int n) {
//     int Esq, Dir;
//     double x;
//     Constroi(A, n); /* constroi o heap */
//     Esq = 0; Dir = n-1;
//     while (Dir > 0)
//     { /* ordena o vetor */
//         x = A->v[0]; 
//         A->v[0] = A->v[Dir]; 
//         A->v[Dir] = x; 
//         Dir--;
//         Refaz(Esq, Dir, A);
//     }
// }




int main(int argc, char ** argv)
// Descricao: programa principal para execucao de operacoes de matrizes 
// Entrada: argc e argv
// Saida: depende da operacao escolhida
{
  // ate 3 matrizes sao utilizadas, dependendo da operacao
  vetor_tipo a, b, c;
  opt_tipo opt;
  // FILE *arquivo = fopen("teste.csv", "wt");
  // avaliar linha de comando
  parse_args(argc,argv,&opt);
  struct timespec inittp, endtp, restp;
  double norma, prodinterno;
  int retp, tam;

  for (tam=opt.tamini; tam<=opt.tamfim; tam*=opt.tampasso){
    // execucao dependente da operacao escolhida
    switch (opt.opescolhida){
      case OPSOMA:
         // cria vetores a e b aleatorios, que sao somados para o vetor c
  	 // vetor c é impresso e todos os vetores sao destruidos
         criaVetor(&a,tam,0);
         inicializaVetorAleatorio(&a);
         criaVetor(&b,tam,1);
         inicializaVetorAleatorio(&b);
         criaVetor(&c,tam,2);
         inicializaVetorNulo(&c);
  	 retp = clock_gettime(CLOCK_MONOTONIC, &inittp);
         somaVetores(&a,&b,&c);
  	 retp = clock_gettime(CLOCK_MONOTONIC, &endtp);
         clkDiff(inittp, endtp, &restp);
  	 printf("Tempo Execucao %d : %ld.%ld\n",tam,restp.tv_sec,restp.tv_nsec);
         destroiVetor(&a);
         destroiVetor(&b);
         destroiVetor(&c);
  	 break;
      case OPPRODUTOINTERNO:
         // cria vetores a e b aleatorios, e calcula o seu produto interno
         criaVetor(&a,tam,0);
         inicializaVetorAleatorio(&a);
         criaVetor(&b,tam,1);
         inicializaVetorAleatorio(&b);
  	 retp = clock_gettime(CLOCK_MONOTONIC, &inittp);
         prodinterno = produtoInternoVetores(&a,&b);
  	 retp = clock_gettime(CLOCK_MONOTONIC, &endtp);
         clkDiff(inittp, endtp, &restp);
  	 printf("Tempo Execucao %d: %ld.%ld\n",tam,restp.tv_sec,restp.tv_nsec);
         destroiVetor(&a);
         destroiVetor(&b);
  	 break;
      case OPNORMA:
         // cria vetor aleatorio e calcula sua norma
         criaVetor(&a,tam,0);
         inicializaVetorAleatorio(&a);
  	 retp = clock_gettime(CLOCK_MONOTONIC, &inittp);
  	 norma = normaVetor(&a);
  	 retp = clock_gettime(CLOCK_MONOTONIC, &endtp);
         clkDiff(inittp, endtp, &restp);
  	 printf("Tempo Execucao %d: %ld.%ld\n",tam,restp.tv_sec,restp.tv_nsec);
         destroiVetor(&a);
  	 break;
      case OPHEAP:
         criaVetor(&a,tam,0);
         inicializaVetorAleatorio(&a);
         criaVetor(&b, tam, 1);
         for(int i = 0; i < tam; i++){
          b.v[i] = a.v[i];
         }
  	 retp = clock_gettime(CLOCK_MONOTONIC, &inittp);
         Heapsort(&a, tam);
  	 retp = clock_gettime(CLOCK_MONOTONIC, &endtp);
         clkDiff(inittp, endtp, &restp);
  	 printf("Tempo Execucao %d: %ld.%ld\n",tam,restp.tv_sec,restp.tv_nsec);

    //  fprintf(arquivo, "%d, ", tam);
    //  fprintf(arquivo, "%ld.00%ld, ",restp.tv_sec,restp.tv_nsec);
     
     retp = clock_gettime(CLOCK_MONOTONIC, &inittp);
         Shellsort(&b, tam);
  	 retp = clock_gettime(CLOCK_MONOTONIC, &endtp);
         clkDiff(inittp, endtp, &restp);
  	 printf("Tempo Execucao shell %d: %ld.%ld\n",tam,restp.tv_sec,restp.tv_nsec);

    //  fprintf(arquivo, "%ld.00%ld\n",restp.tv_sec,restp.tv_nsec);
         destroiVetor(&a);
         destroiVetor(&b);

         break;
     default:
           // nao deve ser executado, pois ha um erroAssert em parse_args
         uso();
  	 exit(1);
    }
  }
  // fclose(arquivo);
  return 0;
}

