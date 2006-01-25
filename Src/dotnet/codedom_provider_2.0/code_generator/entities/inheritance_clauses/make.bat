@ECHO OFF
ECHO Generating scanner and parser for Eiffel inheritance clauses
IF "%GOBO%"=="" ECHO $GOBO is not defined...
IF "%GOBO%"=="" GOTO END

set path=%path%;%GOBO%\bin
IF EXIST code_inheritance_clause_scanner.e DEL code_inheritance_clause_scanner.e
IF EXIST code_inheritance_clause_tokens.e DEL code_inheritance_clause_tokens.e
IF EXIST code_inheritance_clause_parser.e DEL code_inheritance_clause_parser.e

gelex -z inheritance_clause.l
geyacc --new_typing --pragma=noline -x -t CODE_INHERITANCE_CLAUSE_TOKENS -o code_inheritance_clause_parser.e inheritance_clause.y

IF NOT EXIST code_inheritance_clause_scanner.e ECHO Scanner not generated!! (file code_inheritance_clause_scanner.e does not exist)
IF NOT EXIST code_inheritance_clause_parser.e ECHO Parser not generated!! (file code_inheritance_clause_parser.e does not exist)
IF NOT EXIST code_inheritance_clause_tokens.e ECHO Tokens not generated!! (file code_inheritance_clause_tokens.e does not exist)
:END
ECHO Done.