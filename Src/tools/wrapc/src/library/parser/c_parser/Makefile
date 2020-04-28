# General tools
RM=del
GOBO_BIN=$(ISE_EIFFEL)/library/gobo/spec/$(ISE_PLATFORM)/bin

# Gobo flag for gelex
GOBO_LEX_FLAGS=-z --pragma=noline
GOBO_LEX="$(GOBO_BIN)/gelex" $(GOBO_LEX_FLAGS)

# Gobo flag for geyaxx
# To have verbose mode, simply add -v FILE_NAME
GOBO_YACC_FLAGS=--pragma=noline -x -v ewg_c_parser.txt
GOBO_YACC="$(GOBO_BIN)/geyacc" $(GOBO_YACC_FLAGS)

all: ewg_c_scanner.e ewg_c_parser.e

ewg_c_scanner.e: ewg_c_scanner.l
	$(GOBO_LEX) -o $@ $?

ewg_c_parser.e: ewg_c_parser.y
	$(GOBO_YACC) -t EWG_C_TOKENS -o $@ $?

clean:
	$(RM) ewg_c_scanner.e
	$(RM) ewg_c_parser.e
