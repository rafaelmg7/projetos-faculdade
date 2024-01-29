#---------------------------------------------------------------------
# Arquivo	: Makefile
# Conteúdo	: compilar o programa operation
# Autor		: Rafael Martins Gomes
# Histórico	: 2023-04-16 - arquivo criado
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
OBJS = $(OBJ)/main.o $(OBJ)/queue.o $(OBJ)/stack.o $(OBJ)/memlog.o
HDRS = $(INC)/queue.h $(INC)/stack.h $(INC)/memlog.h
CFLAGS = -Wall -c -I $(INC)

EXE = $(BIN)/main

all: run
run:     	$(EXE)
	$(EXE)

$(BIN)/main: $(OBJS)
	$(CC) -pg -o $(BIN)/main $(OBJS) $(LIBS)

$(OBJ)/main.o: $(HDRS) $(SRC)/main.c
	$(CC) $(CFLAGS) -o $(OBJ)/main.o $(SRC)/main.c

$(OBJ)/queue.o: $(HDRS) $(SRC)/queue.c
	$(CC) $(CFLAGS) -o $(OBJ)/queue.o $(SRC)/queue.c

$(OBJ)/stack.o: $(HDRS) $(SRC)/stack.c
	$(CC) $(CFLAGS) -o $(OBJ)/stack.o $(SRC)/stack.c

$(OBJ)/memlog.o: $(HDRS) $(SRC)/memlog.c
	$(CC) $(CFLAGS) -o $(OBJ)/memlog.o $(SRC)/memlog.c

	
clean:
	rm -f $(EXE) $(OBJS) gmon.out