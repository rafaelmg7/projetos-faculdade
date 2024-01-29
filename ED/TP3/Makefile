#---------------------------------------------------------------------
# Arquivo	: Makefile
# Conteúdo	: compilar o programa main
# Autor		: Rafael Martins Gomes
# Histórico	: 2023-07-03 - arquivo criado
#---------------------------------------------------------------------
# Opções	: make all - compila tudo
#		: make clean - remove objetos e executável
#---------------------------------------------------------------------

CC = g++
LIBS = -lm
SRC = src
OBJ = obj
INC = include
BIN = bin
OBJS = $(OBJ)/main.o $(OBJ)/huffmanCoding.o $(OBJ)/tree.o
HDRS = $(INC)/item.hpp $(INC)/list.hpp $(INC)/node.hpp $(INC)/tree.hpp $(INC)/huffmanCoding.hpp
CFLAGS = -Wall -c -I $(INC)

EXE = $(BIN)/main

ARGS := $(word 2,$(MAKECMDGOALS)) $(word 3,$(MAKECMDGOALS))
$(eval $(ARGS):;@:)

ARGS2 := $(word 3,$(MAKECMDGOALS)) $(word 4,$(MAKECMDGOALS))
$(eval $(ARGS):;@:)

all: run

run: $(EXE)
	$(EXE) -c $(ARGS)
	$(EXE) -d $(ARGS2)

$(BIN)/main: $(OBJS)
	$(CC) -g -o $(BIN)/main $(OBJS) $(LIBS)

$(OBJ)/main.o: $(HDRS) $(SRC)/main.cpp
	$(CC) $(CFLAGS) -o $(OBJ)/main.o $(SRC)/main.cpp

$(OBJ)/huffmanCoding.o: $(HDRS) $(SRC)/huffmanCoding.cpp
	$(CC) $(CFLAGS) -o $(OBJ)/huffmanCoding.o $(SRC)/huffmanCoding.cpp

$(OBJ)/tree.o: $(HDRS) $(SRC)/tree.cpp
	$(CC) $(CFLAGS) -o $(OBJ)/tree.o $(SRC)/tree.cpp

clean:
	rm -f $(EXE) $(OBJS) *_cod.txt*