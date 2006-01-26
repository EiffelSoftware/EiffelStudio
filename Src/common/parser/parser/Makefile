# General tools
RM=del

# Gobo flag for gelex
GOBO_LEX_FLAGS=-z
GOBO_LEX=$(GOBO)\bin\gelex $(GOBO_LEX_FLAGS)

# Gobo flag for geyaxx
# To have verbose mode, simply add -v FILE_NAME
GOBO_YACC_FLAGS=--new_typing --pragma=noline -x
GOBO_YACC=$(GOBO)\bin\geyacc $(GOBO_YACC_FLAGS)

all: eiffel_scanner.e eiffel_parser.e

eiffel_scanner.e: eiffel.l
	$(GOBO_LEX) -o $@ $?

eiffel_parser.e: eiffel.y
	$(GOBO_YACC) -t EIFFEL_TOKENS -o $@ $?
