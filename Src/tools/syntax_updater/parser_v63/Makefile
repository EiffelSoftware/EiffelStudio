# Gobo flag for gelex
GOBO_LEX="$(ISE_EIFFEL)/library/gobo/spec/$(ISE_PLATFORM)/bin/gelex" -z

# Gobo flag for geyaxx
# To have verbose mode, simply add -v FILE_NAME
GOBO_YACC="$(ISE_EIFFEL)/library/gobo/spec/$(ISE_PLATFORM)/bin/geyacc" --new_typing --pragma=noline -x

all: eiffel_scanner.e eiffel_parser.e

eiffel_scanner.e: eiffel.l
	$(GOBO_LEX) -o $@ $?

eiffel_parser.e: eiffel.y
	$(GOBO_YACC) -t EIFFEL_TOKENS -o $@ $?
