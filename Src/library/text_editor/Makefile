# General tools
RM=del
SYNTAX_UPDATER="$(ISE_EIFFEL)/tools/spec/$(ISE_PLATFORM)/bin/syntax_updater"

# Gobo flag for gelex
GOBO_LEX_FLAGS=-z --pragma=noline
GOBO_LEX="$(ISE_EIFFEL)/library/gobo/spec/$(ISE_PLATFORM)/bin/gelex" $(GOBO_LEX_FLAGS)

all: eiffel_scanner.e

eiffel_scanner.e: eiffel_scanner.l
	$(GOBO_LEX) -o $@ $?
	$(SYNTAX_UPDATER) .

