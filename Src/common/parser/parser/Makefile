# General tools
RM=del

# Gobo flag for gelex
GOBO_LEX_FLAGS=-z
GOBO_LEX=$(GOBO)\bin\gelex $(GOBO_LEX_FLAGS)

# Gobo flag for geyaxx
# To have verbose mode, simply add -v FILE_NAME
GOBO_YACC_FLAGS=-x
GOBO_YACC=$(GOBO)\bin\geyacc $(GOBO_YACC_FLAGS)

all: eiffel_scanner.e external_scanner.e eiffel_parser.e external_parser.e cluster_indexing_parser.e

eiffel_scanner.e: eiffel.l
	$(GOBO_LEX) $?

external_scanner.e: external.l
	$(GOBO_LEX) $?

eiffel_parser.e: eiffel.y
	$(GOBO_YACC) -t EIFFEL_TOKENS -o $@ $?

external_parser.e: external.y
	$(GOBO_YACC) -t EXTERNAL_TOKENS -o $@ $?

cluster_indexing_parser.e: cluster_indexing.y
	$(GOBO_YACC) -t DUMMY -o $@ $?
	$(RM) dummy.e
