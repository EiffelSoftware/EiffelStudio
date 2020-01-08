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
GOBO_YACC_FLAGS=--pragma=noline -x
GOBO_YACC="$(GOBO_BIN)/geyacc" $(GOBO_YACC_FLAGS)

all: code_inheritance_clause_scanner.e code_inheritance_clause_parser.e

code_inheritance_clause_scanner.e: inheritance_clause.l
	$(GOBO_LEX) -o $@ $?
	$(SYNTAX_UPDATER) .

code_inheritance_clause_parser.e: inheritance_clause.y
	$(GOBO_YACC) -t CODE_INHERITANCE_CLAUSE_TOKENS -o $@ $?
	$(SYNTAX_UPDATER) .

clean:
	$(RM) code_inheritance_clause_scanner.e code_inheritance_clause_parser.e
	
