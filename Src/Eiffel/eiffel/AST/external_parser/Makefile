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

all: external_scanner.e external_parser.e

external_scanner.e: external.l
	$(GOBO_LEX) -o $@ $?
	$(SYNTAX_UPDATER) .

external_parser.e: external.y
	$(GOBO_YACC) -t EXTERNAL_TOKENS -o $@ $?
	$(SYNTAX_UPDATER) .
