# General tools
RM=del

# Gobo flag for gelex
GOBO_LEX_FLAGS=-z
GOBO_LEX=$(GOBO)\bin\gelex $(GOBO_LEX_FLAGS)

all: comment_scanner.e

comment_scanner.e: comment_scanner.l
	$(GOBO_LEX) -o $@ $?
