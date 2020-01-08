# General tools
RM=del
GOBO_BIN=$(ISE_EIFFEL)/library/gobo/spec/$(ISE_PLATFORM)/bin
GOBO_BIN=$(EIFFEL_SRC)/contrib/library/gobo/bin
SYNTAX_UPDATER="$(ISE_EIFFEL)/tools/spec/$(ISE_PLATFORM)/bin/syntax_updater"

# Gobo flag for gelex
GOBO_LEX_FLAGS=-z --pragma=noline
GOBO_LEX="$(GOBO_BIN)/gelex" $(GOBO_LEX_FLAGS)

# Gobo flag for geyaxx
# To have verbose mode, simply add -v FILE_NAME
GOBO_YACC_FLAGS=--pragma=noline -x
GOBO_YACC="$(GOBO_BIN)/geyacc" $(GOBO_YACC_FLAGS)

all: classname_finder.e

classname_finder.e: classname_finder.l
	$(GOBO_LEX) $?
	$(SYNTAX_UPDATER) .

clean:
	$(RM) classname_finder.e
