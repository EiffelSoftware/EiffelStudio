# General tools
RM=del
GOBO_BIN=$(ISE_EIFFEL)/library/gobo/spec/$(ISE_PLATFORM)/bin
#GOBO_BIN=$(EIFFEL_SRC)/contrib/library/gobo/bin
SYNTAX_UPDATER="$(ISE_EIFFEL)/tools/spec/$(ISE_PLATFORM)/bin/syntax_updater"

# Gobo flag for gelex
GOBO_LEX_FLAGS=-z --pragma=noline
GOBO_LEX="$(GOBO_BIN)/gelex" $(GOBO_LEX_FLAGS)

all: eb_command_scanner.e

eb_command_scanner.e: command_scanner.l
	$(GOBO_LEX) -o $@ $?
	$(SYNTAX_UPDATER) .

clean:
	$(RM) eb_command_scanner.e

