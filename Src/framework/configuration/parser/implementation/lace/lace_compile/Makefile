# General tools
RM=del
SYNTAX_UPDATER="$(ISE_EIFFEL)/tools/spec/$(ISE_PLATFORM)/bin/syntax_updater"

# Gobo flag for gelex
GOBO_LEX_FLAGS=-z --pragma=noline
GOBO_LEX="$(ISE_EIFFEL)/library/gobo/spec/$(ISE_PLATFORM)/bin/gelex" $(GOBO_LEX_FLAGS)

# Gobo flag for geyaxx
# To have verbose mode, simply add -v FILE_NAME
GOBO_YACC_FLAGS=--new_typing --pragma=noline -x
GOBO_YACC="$(ISE_EIFFEL)/library/gobo/spec/$(ISE_PLATFORM)/bin/geyacc" $(GOBO_YACC_FLAGS)

all: lace_parser.e lace_scanner.e classname_finder.e

lace_scanner.e: lace.l
	$(GOBO_LEX) -o $@ $?
	$(SYNTAX_UPDATER) .

classname_finder.e: classname_finder.l
	$(GOBO_LEX) $?
	$(SYNTAX_UPDATER) .

lace_parser.e: lace.y
	$(GOBO_YACC) -t LACE_TOKENS -o $@ $?
	$(SYNTAX_UPDATER) .
