#---------------------------------------------------------------------
# Arquivo	: Makefile
# Conteúdo	: compilar o programa
# Autor		: Rafael Martins Gomes
# Histórico	: 2023-05-01 - arquivo criado
#---------------------------------------------------------------------
# Opções	: make all - compila tudo
#		: make clean - remove objetos e executável
#---------------------------------------------------------------------

CC = gcc
LIBS = -lm
SRC = src
OBJ = obj
INC = include
BIN = bin
OBJS = $(OBJ)/main.o
CFLAGS = -Wall -c -ftest-coverage -I $(INC)

EXE = $(BIN)/main

all: run
run:     	$(EXE)
	$(EXE) -o 'saida.txt' -s 400 -n 10

$(BIN)/main: $(OBJS)
	$(CC) -o $(BIN)/main $(OBJS) $(LIBS)

$(OBJ)/main.o: $(HDRS) $(SRC)/gerarvbin.c
	$(CC) $(CFLAGS) -o $(OBJ)/main.o $(SRC)/gerarvbin.c
	
clean:
	rm -f $(EXE) $(OBJS) gmon.out saida.txt