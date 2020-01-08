# General tools
RM=del
SYNTAX_UPDATER="$(ISE_EIFFEL)/tools/spec/$(ISE_PLATFORM)/bin/syntax_updater"
GOBO_BIN=$(ISE_EIFFEL)/library/gobo/spec/$(ISE_PLATFORM)/bin
#GOBO_BIN=$(EIFFEL_SRC)/contrib/library/gobo/bin

# Gobo flag for gelex
GOBO_LEX_FLAGS=-z --pragma=noline
GOBO_LEX="$(GOBO_BIN)/gelex" $(GOBO_LEX_FLAGS)

# Gobo flag for geyaxx
# To have verbose mode, simply add -v FILE_NAME
GOBO_YACC_FLAGS= --pragma=noline -x
GOBO_YACC="$(GOBO_BIN)/geyacc" $(GOBO_YACC_FLAGS)

all: lace_parser.e lace_scanner.e

lace_scanner.e: lace.l
	$(GOBO_LEX) -o $@ $?
	$(SYNTAX_UPDATER) .

lace_parser.e: lace.y
	$(GOBO_YACC) -t LACE_TOKENS -o $@ $?
	$(SYNTAX_UPDATER) .

clean:
	$(RM) lace_parser.e lace_scanner.e lace_tokens.e
