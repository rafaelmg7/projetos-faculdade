CC = gcc
LIBS = -lm
SRC = src
OBJ = obj
INC = include
BIN = bin
OBJS = $(OBJ)/arvexp.o
CFLAGS = -Wall -c -I $(INC)

EXE = $(BIN)/arvexp

all: run
run:     	$(EXE)
# Para visualizar os tempos, rode o comando "time bin/arvexp" no terminal.

$(BIN)/arvexp: $(OBJS)
# Os parâmetros 'm' e 'CARGA' podem ser alterados para testar o programa.
	$(CC) -Dm=200 -DCARGA=10000 -o $(BIN)/arvexp $(OBJS) $(LIBS)

$(OBJ)/arvexp.o: $(SRC)/arvexp.c
	$(CC) $(CFLAGS) -o $(OBJ)/arvexp.o $(SRC)/arvexp.c
	
clean:
	rm -f $(EXE) $(OBJS)