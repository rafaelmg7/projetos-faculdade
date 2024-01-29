#---------------------------------------------------------------------
# Arquivo	: Makefile
# Conteúdo	: compilar o programa operation
# Autor		: Rafael Martins Gomes
# Histórico	: 2023-03-30 - arquivo criado
#---------------------------------------------------------------------
# Opções	: make all - compila tudo
#		: make clean - remove objetos e executável
#---------------------------------------------------------------------

CC = g++
LIBS = -lm
SRC = src
# ENT = $(SRC)/entities
OBJ = obj
INC = include
BIN = bin
OBJS = $(OBJ)/main.o $(OBJ)/fatorial.o $(OBJ)/fibonacci.o
HDRS = $(INC)/fatorial.h $(INC)/fibonacci.h
CFLAGS = -Wall -c -pg -ftest-coverage -I $(INC)

EXE = $(BIN)/main

all: run
run:     	$(EXE)
	$(EXE) fibonacci 5
	gprof $(EXE) gmon.out | more > fibonacci.txt
	$(EXE) fatorial 5
	gprof $(EXE) gmon.out | more > fatorial.txt

$(BIN)/main: $(OBJS)
	$(CC) -pg -o $(BIN)/main $(OBJS) $(LIBS)

$(OBJ)/main.o: $(HDRS) $(SRC)/main.c
	$(CC) $(CFLAGS) -o $(OBJ)/main.o $(SRC)/main.c

$(OBJ)/fatorial.o: $(HDRS) $(SRC)/fatorial.c
	$(CC) $(CFLAGS) -o $(OBJ)/fatorial.o $(SRC)/fatorial.c

$(OBJ)/fibonacci.o: $(HDRS) $(SRC)/fibonacci.c
	$(CC) $(CFLAGS) -o $(OBJ)/fibonacci.o $(SRC)/fibonacci.c


	
clean:
	rm -f $(EXE) $(OBJS) gmon.out