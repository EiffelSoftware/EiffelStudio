%{
indexing

	description: "Scanners for Eiffel parsers"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class EIFFEL_SCANNER

inherit

	EIFFEL_SCANNER_SKELETON
	STRING_HANDLER

creation

	make

%}

%x SPECIAL_STR VERBATIM_STR1 VERBATIM_STR2 VERBATIM_STR3
%option nodefault outfile="eiffel_scanner.e"

D		[0-9]
H		([0-9]|[A-F]|[a-f])
O		[0-7]
E		(((e|E)[+-]?{D}+)?)
A		([a-z]|[A-Z])
X		([a-z]|[A-Z]|[0-9]|_)
W		[ \t\n\r]
T		[0-9][0-9][0-9]
U		([0-9]|[0-9][0-9]|[0-9][0-9][0-9])

%%


-- Comments

"--".*			current_position.go_to (text_count)


-- Separators

[ \t\r]+		current_position.go_to (text_count)
\n+			{
				line_number := line_number + text_count
				current_position.go_to (text_count)
				current_position.set_line_number (line_number)
			}


-- Symbols

";"			{
				current_position.go_to (1)
				last_token := TE_SEMICOLON
			}
":"			{
				current_position.go_to (1)
				last_token := TE_COLON
			}
","			{
				current_position.go_to (1)
				last_token := TE_COMMA
			}
".."		{
				current_position.go_to (2)
				last_token := TE_DOTDOT
			}
"?"			{
				current_position.go_to (1)
				last_token := TE_QUESTION
			}
"~"			{
				current_position.go_to (1)
				last_token := TE_TILDE
			}
"}~"		{
				current_position.go_to (2)
				last_token := TE_CURLYTILDE
			}
"."			{
				current_position.go_to (1)
				last_token := TE_DOT
			}
"$"			{
				current_position.go_to (1)
				last_token := TE_ADDRESS
			}
":="		{
				current_position.go_to (2)
				last_token := TE_ASSIGN
			}
"?="		{
				current_position.go_to (2)
				last_token := TE_ACCEPT
			}
"="			{
				current_position.go_to (1)
				last_token := TE_EQ
			}
"<"			{
				current_position.go_to (1)
				last_token := TE_LT
			}
">"			{
				current_position.go_to (1)
				last_token := TE_GT
			}
"<="		{
				current_position.go_to (2)
				last_token := TE_LE
			}
">="		{
				current_position.go_to (2)
				last_token := TE_GE
			}
"/="		{
				current_position.go_to (2)
				last_token := TE_NE
			}
"("			{
				current_position.go_to (1)
				last_token := TE_LPARAN
			}
")"			{
				current_position.go_to (1)
				last_token := TE_RPARAN
			}
"{"			{
				current_position.go_to (1)
				last_token := TE_LCURLY
			}
"}"			{
				current_position.go_to (1)
				last_token := TE_RCURLY
			}
"["			{
				current_position.go_to (1)
				last_token := TE_LSQURE
			}
"]"			{
				current_position.go_to (1)
				last_token := TE_RSQURE
			}
"+"			{
				current_position.go_to (1)
				last_token := TE_PLUS
			}
"-"			{
				current_position.go_to (1)
				last_token := TE_MINUS
			}
"*"			{
				current_position.go_to (1)
				last_token := TE_STAR
			}
"/"			{
				current_position.go_to (1)
				last_token := TE_SLASH
			}
"^"			{
				current_position.go_to (1)
				last_token := TE_POWER
			}
"->"  		{
				current_position.go_to (2)
				last_token := TE_CONSTRAIN
			}
"!"			{
				current_position.go_to (1)
				last_token := TE_BANG
			}
"<<"		{
				current_position.go_to (2)
				last_token := TE_LARRAY
			}
">>"		{
				current_position.go_to (2)
				last_token := TE_RARRAY
			}
"//"		{
				current_position.go_to (2)
				last_token := TE_DIV
			}
"\\\\"		{
				current_position.go_to (2)
				last_token := TE_MOD
			}


-- Free operators

(@|#|\||&)[@#0-9a-zA-Z_!\$&\'\(\)\*\+\,\-\./:;<>=\?\[\\\]\^\`\{\}\|\~]*	{

					-- Note: Free operators are converted to lower-case.
				token_buffer.clear_all
				append_text_to_string (token_buffer)
				token_buffer.to_lower
				current_position.go_to (token_buffer.count)
				last_token := TE_FREE
			}


-- Reserved words

[aA][gG][eE][nN][tT]	{
				current_position.go_to (5)
				last_token := TE_AGENT
			}
[aA][lL][iI][aA][sS]	{
				current_position.go_to (5)
				last_token := TE_ALIAS
			}
[aA][lL][lL]	{
				current_position.go_to (3)
				last_token := TE_ALL
			}
[aA][nN][dD]	{
				current_position.go_to (3)
				last_token := TE_AND
			}
[aA][sS]	{
				current_position.go_to (2)
				last_token := TE_AS
			}
[bB][iI][tT]	{
				current_position.go_to (3)
				last_token := TE_BIT
			}
[cC][hH][eE][cC][kK]	{
				current_position.go_to (5)
				last_token := TE_CHECK
			}
[cC][lL][aA][sS][sS]	{
				current_position.go_to (5)
				last_token := TE_CLASS
			}
[cC][rR][eE][aA][tT][eE]	{
				current_position.go_to (6)
				last_token := TE_CREATE
			}
[cC][rR][eE][aA][tT][iI][oO][nN]	{
				current_position.go_to (8)
				last_token := TE_CREATION
			}
[cC][uU][rR][rR][eE][nN][tT]	{
				current_position.go_to (7)
				last_token := TE_CURRENT
			}
[dD][eE][bB][uU][gG]	{
				current_position.go_to (5)
				last_token := TE_DEBUG
			}
[dD][eE][fF][eE][rR][rR][eE][dD]	{
				current_position.go_to (8)
				last_token := TE_DEFERRED
			}
[dD][oO]	{
				current_position.go_to (2)
				last_token := TE_DO
			}
[eE][lL][sS][eE]	{
				current_position.go_to (4)
				last_token := TE_ELSE
			}
[eE][lL][sS][eE][iI][fF]	{
				current_position.go_to (6)
				last_token := TE_ELSEIF
			}
[eE][nN][dD]	{
				current_position.go_to (3)
				last_token := TE_END
			}
[eE][nN][sS][uU][rR][eE]	{
				current_position.go_to (6)
				last_token := TE_ENSURE
			}
[eE][xX][pP][aA][nN][dD][eE][dD]	{
				current_position.go_to (8)
				last_token := TE_EXPANDED
			}
[eE][xX][pP][oO][rR][tT]	{
				current_position.go_to (6)
				last_token := TE_EXPORT
			}
[eE][xX][tT][eE][rR][nN][aA][lL]	{
				current_position.go_to (8)
				last_token := TE_EXTERNAL
			}
[fF][aA][lL][sS][eE]	{
				current_position.go_to (5)
				last_token := TE_FALSE
			}
[fF][eE][aA][tT][uU][rR][eE]	{
				current_position.go_to (7)
				last_token := TE_FEATURE
			}
[fF][rR][oO][mM]	{
				current_position.go_to (4)
				last_token := TE_FROM
			}
[fF][rR][oO][zZ][eE][nN]	{
				current_position.go_to (6)
				last_token := TE_FROZEN
			}
[iI][fF]	{
				current_position.go_to (2)
				last_token := TE_IF
			}
[iI][mM][pP][lL][iI][eE][sS]	{
				current_position.go_to (7)
				last_token := TE_IMPLIES
			}
[iI][nN][dD][eE][xX][iI][nN][gG]	{
				current_position.go_to (8)
				last_token := TE_INDEXING
			}
[iI][nN][fF][iI][xX]	{
				current_position.go_to (5)
				last_token := TE_INFIX
			}
[iI][nN][hH][eE][rR][iI][tT]	{
				current_position.go_to (7)
				last_token := TE_INHERIT
			}
[iI][nN][sS][pP][eE][cC][tT]	{
				current_position.go_to (7)
				last_token := TE_INSPECT
			}
[iI][nN][vV][aA][rR][iI][aA][nN][tT]	{
				current_position.go_to (9)
				last_token := TE_INVARIANT
			}
[iI][sS]	{
				current_position.go_to (2)
				last_token := TE_IS
			}
[lL][iI][kK][eE]	{
				current_position.go_to (4)
				last_token := TE_LIKE
			}
[lL][oO][cC][aA][lL]	{
				current_position.go_to (5)
				last_token := TE_LOCAL
			}
[lL][oO][oO][pP]	{
				current_position.go_to (4)
				last_token := TE_LOOP
			}
[nN][oO][tT]	{
				current_position.go_to (3)
				last_token := TE_NOT
			}
[oO][bB][sS][oO][lL][eE][tT][eE]	{
				current_position.go_to (8)
				last_token := TE_OBSOLETE
			}
[oO][lL][dD]	{
				current_position.go_to (3)
				last_token := TE_OLD
			}
[oO][nN][cC][eE]	{
				current_position.go_to (4)
				last_token := TE_ONCE
			}
[oO][rR]	{
				current_position.go_to (2)
				last_token := TE_OR
			}
[pP][rR][eE][cC][uU][rR][sS][oO][rR]	{
				current_position.go_to (9)
				last_token := TE_PRECURSOR
			}
[pP][rR][eE][fF][iI][xX]	{
				current_position.go_to (6)
				last_token := TE_PREFIX
			}
[rR][eE][dD][eE][fF][iI][nN][eE]	{
				current_position.go_to (8)
				last_token := TE_REDEFINE
			}
[rR][eE][nN][aA][mM][eE]	{
				current_position.go_to (6)
				last_token := TE_RENAME
			}
[rR][eE][qQ][uU][iI][rR][eE]	{
				current_position.go_to (7)
				last_token := TE_REQUIRE
			}
[rR][eE][sS][cC][uU][eE]	{
				current_position.go_to (6)
				last_token := TE_RESCUE
			}
[rR][eE][sS][uU][lL][tT]	{
				current_position.go_to (6)
				last_token := TE_RESULT
			}
[rR][eE][tT][rR][yY]	{
				current_position.go_to (5)
				last_token := TE_RETRY
			}
[sS][eE][lL][eE][cC][tT]	{
				current_position.go_to (6)
				last_token := TE_SELECT
			}
[sS][eE][pP][aA][rR][aA][tT][eE]	{
				current_position.go_to (8)
				last_token := TE_SEPARATE
			}
[sS][tT][rR][iI][pP]	{
				current_position.go_to (5)
				last_token := TE_STRIP
			}
[tT][hH][eE][nN]	{
				current_position.go_to (4)
				last_token := TE_THEN
			}
[tT][rR][uU][eE]	{
				current_position.go_to (4)
				last_token := TE_TRUE
			}
[uU][nN][dD][eE][fF][iI][nN][eE]	{
				current_position.go_to (8)
				last_token := TE_UNDEFINE
			}
[uU][nN][iI][qQ][uU][eE]	{
				current_position.go_to (6)
				last_token := TE_UNIQUE
			}
[uU][nN][tT][iI][lL]	{
				current_position.go_to (5)
				last_token := TE_UNTIL
			}
[vV][aA][rR][iI][aA][nN][tT]	{
				current_position.go_to (7)
				last_token := TE_VARIANT
			}
[wW][hH][eE][nN]	{
				current_position.go_to (4)
				last_token := TE_WHEN
			}
[xX][oO][rR]	{
				current_position.go_to (3)
				last_token := TE_XOR
			}


-- Identifiers

[bB][oO][oO][lL][eE][aA][nN]	{
				current_position.go_to (7)
				last_token := TE_BOOLEAN_ID
			}
[cC][hH][aA][rR][aA][cC][tT][eE][rR]	{
				current_position.go_to (9)
				last_token := TE_CHARACTER_ID
			}
[dD][oO][uU][bB][lL][eE]	{
				current_position.go_to (6)
				last_token := TE_DOUBLE_ID
			}
[iI][nN][tT][eE][gG][eE][rR]_8	{
				current_position.go_to (9)
				last_token := TE_INTEGER_8_ID
			}
[iI][nN][tT][eE][gG][eE][rR]_16	{
				current_position.go_to (10)
				last_token := TE_INTEGER_16_ID
			}
[iI][nN][tT][eE][gG][eE][rR]	{
				current_position.go_to (7)
				last_token := TE_INTEGER_ID
			}
[iI][nN][tT][eE][gG][eE][rR]_64	{
				current_position.go_to (10)
				last_token := TE_INTEGER_64_ID
			}
[nN][oO][nN][eE]	{
				current_position.go_to (4)
				last_token := TE_NONE_ID
			}
[pP][oO][iI][nN][tT][eE][rR]	{
				current_position.go_to (7)
				last_token := TE_POINTER_ID
			}
[rR][eE][aA][lL]	{
				current_position.go_to (4)
				last_token := TE_REAL_ID
			}
[wW][iI][dD][eE]_[cC][hH][aA][rR][aA][cC][tT][eE][rR]	{
				current_position.go_to (14)
				last_token := TE_WIDE_CHAR_ID
			}
{A}{X}*		{
					-- Note: Identifiers are converted to lower-case.
				token_buffer.clear_all
				append_text_to_string (token_buffer)
				token_buffer.to_lower
				current_position.go_to (token_buffer.count)
				last_token := TE_ID
			}


-- Bits

[0-1]+[bB]	{
				token_buffer.clear_all
				append_text_substring_to_string (1, text_count - 1, token_buffer)
				current_position.go_to (token_buffer.count + 1)
				last_token := TE_A_BIT
			}


-- Integers

{D}+		|
{D}+/".."	{		-- This a trick to avoid having:
					--     when 1..2 then
					-- to be be erroneously recognized as:
					--     `when' `1.' `.2' `then'
					-- instead of:
					--     `when' `1' `..' `2' `then'

				token_buffer.clear_all
				append_text_to_string (token_buffer)
				current_position.go_to (token_buffer.count)
				last_token := TE_INTEGER
			}

({U}(_{T})*)	{
				token_buffer.clear_all
				append_without_underscores (text, token_buffer)
				current_position.go_to (text_count)
				last_token := TE_INTEGER
			}

[0][xX]{H}+	{		-- Recognizes hexadecimal integer numbers.
				token_buffer.clear_all
				append_text_to_string (token_buffer)
				current_position.go_to (text_count)
				last_token := TE_INTEGER
			}

-- Reals

({D}*\.{D}+{E})|({D}+\.{D}*{E})|(({U}(_{T})*)?\.({T}_)*{U}{E})|({U}(_{T})*\.(({T}_)*{U})?{E}) {
				token_buffer.clear_all
				append_text_to_string (token_buffer)
				token_buffer.to_lower
				current_position.go_to (text_count)
				last_token := TE_REAL
			}


-- Characters

\'[^%\n']\'	{
				token_buffer.clear_all
				token_buffer.append_character (text_item (2))
				current_position.go_to (3)
				last_token := TE_CHAR
			}
\'\'\'		{
					-- This is not correct Eiffel!
				token_buffer.clear_all
				token_buffer.append_character ('%'')
				current_position.go_to (3)
				last_token := TE_CHAR
			}
\'%A\'		{
				token_buffer.clear_all
				token_buffer.append_character ('%A')
				current_position.go_to (4)
				last_token := TE_CHAR
			}
\'%B\'		{
				token_buffer.clear_all
				token_buffer.append_character ('%B')
				current_position.go_to (4)
				last_token := TE_CHAR
			}
\'%C\'		{
				token_buffer.clear_all
				token_buffer.append_character ('%C')
				current_position.go_to (4)
				last_token := TE_CHAR
			}
\'%D\'		{
				token_buffer.clear_all
				token_buffer.append_character ('%D')
				current_position.go_to (4)
				last_token := TE_CHAR
			}
\'%F\'		{
				token_buffer.clear_all
				token_buffer.append_character ('%F')
				current_position.go_to (4)
				last_token := TE_CHAR
			}
\'%H\'		{
				token_buffer.clear_all
				token_buffer.append_character ('%H')
				current_position.go_to (4)
				last_token := TE_CHAR
			}
\'%L\'		{
				token_buffer.clear_all
				token_buffer.append_character ('%L')
				current_position.go_to (4)
				last_token := TE_CHAR
			}
\'%N\'		{
				token_buffer.clear_all
				token_buffer.append_character ('%N')
				current_position.go_to (4)
				last_token := TE_CHAR
			}
\'%Q\'		{
				token_buffer.clear_all
				token_buffer.append_character ('%Q')
				current_position.go_to (4)
				last_token := TE_CHAR
			}
\'%R\'		{
				token_buffer.clear_all
				token_buffer.append_character ('%R')
				current_position.go_to (4)
				last_token := TE_CHAR
			}
\'%S\'		{
				token_buffer.clear_all
				token_buffer.append_character ('%S')
				current_position.go_to (4)
				last_token := TE_CHAR
			}
\'%T\'		{
				token_buffer.clear_all
				token_buffer.append_character ('%T')
				current_position.go_to (4)
				last_token := TE_CHAR
			}
\'%U\'		{
				token_buffer.clear_all
				token_buffer.append_character ('%U')
				current_position.go_to (4)
				last_token := TE_CHAR
			}
\'%V\'		{
				token_buffer.clear_all
				token_buffer.append_character ('%V')
				current_position.go_to (4)
				last_token := TE_CHAR
			}
\'%%\'		{
				token_buffer.clear_all
				token_buffer.append_character ('%%')
				current_position.go_to (4)
				last_token := TE_CHAR
			}
\'%\'\'		{
				token_buffer.clear_all
				token_buffer.append_character ('%'')
				current_position.go_to (4)
				last_token := TE_CHAR
			}
\'%\"\'		{
				token_buffer.clear_all
				token_buffer.append_character ('%"')
				current_position.go_to (4)
				last_token := TE_CHAR
			}
\'%\(\'		{
				token_buffer.clear_all
				token_buffer.append_character ('%(')
				current_position.go_to (4)
				last_token := TE_CHAR
			}
\'%\)\'		{
				token_buffer.clear_all
				token_buffer.append_character ('%)')
				current_position.go_to (4)
				last_token := TE_CHAR
			}
\'%<\'		{
				token_buffer.clear_all
				token_buffer.append_character ('%<')
				current_position.go_to (4)
				last_token := TE_CHAR
			}
\'%>\'		{
				token_buffer.clear_all
				token_buffer.append_character ('%>')
				current_position.go_to (4)
				last_token := TE_CHAR
			}
\'%\/[0-9]+\/\'	{
				current_position.go_to (text_count)
				process_character_code (text_substring (4, text_count - 2).to_integer)
			}
\'.{0,2}			|
\'%\/[0-9]+(\/)?	{
					-- Unrecognized character.
					-- (catch-all rules (no backing up))
				current_position.go_to (text_count)
				report_character_missing_quote_error (text)
			}


-- Strings

\""<"\"		{
				current_position.go_to (3)
				last_token := TE_STR_LT
			}
\"">"\"		{
				current_position.go_to (3)
				last_token := TE_STR_GT
			}
\""<="\"	{
				current_position.go_to (4)
				last_token := TE_STR_LE
			}
\"">="\"	{
				current_position.go_to (4)
				last_token := TE_STR_GE
			}
\""+"\"		{
				current_position.go_to (3)
				last_token := TE_STR_PLUS
			}
\""-"\"		{
				current_position.go_to (3)
				last_token := TE_STR_MINUS
			}
\""*"\"		{
				current_position.go_to (3)
				last_token := TE_STR_STAR
			}
\""/"\"		{
				current_position.go_to (3)
				last_token := TE_STR_SLASH
			}
\""^"\"		{
				current_position.go_to (3)
				last_token := TE_STR_POWER
			}
\""//"\"	{
				current_position.go_to (4)
				last_token := TE_STR_DIV
			}
\""\\\\"\"	{
				current_position.go_to (4)
				last_token := TE_STR_MOD
			}
\"[aA][nN][dD]\"	{
				token_buffer.clear_all
				append_text_substring_to_string (2, 4, token_buffer)
				current_position.go_to (5)
				last_token := TE_STR_AND
			}
\"[aA][nN][dD]\ [tT][hH][eE][nN]\"	{
				token_buffer.clear_all
				append_text_substring_to_string (2, 9, token_buffer)
				current_position.go_to (10)
				last_token := TE_STR_AND_THEN
			}
\"[iI][mM][pP][lL][iI][eE][sS]\"	{
				token_buffer.clear_all
				append_text_substring_to_string (2, 8, token_buffer)
				current_position.go_to (9)
				last_token := TE_STR_IMPLIES
			}
\"[nN][oO][tT]\"	{
				token_buffer.clear_all
				append_text_substring_to_string (2, 4, token_buffer)
				current_position.go_to (5)
				last_token := TE_STR_NOT
			}
\"[oO][rR]\"	{
				token_buffer.clear_all
				append_text_substring_to_string (2, 3, token_buffer)
				current_position.go_to (4)
				last_token := TE_STR_OR
			}
\"[oO][rR]\ [eE][lL][sS][eE]\"	{
				token_buffer.clear_all
				append_text_substring_to_string (2, 8, token_buffer)
				current_position.go_to (9)
				last_token := TE_STR_OR_ELSE
			}
\"[xX][oO][rR]\"	{
				token_buffer.clear_all
				append_text_substring_to_string (2, 4, token_buffer)
				current_position.go_to (5)
				last_token := TE_STR_XOR
			}
\"(@|#|\||&)[@#0-9a-zA-Z_!\$&\'\(\)\*\+\,\-\./:;<>=\?\[\\\]\^\`\{\}\|\~]*\"	{
				token_buffer.clear_all
				append_text_substring_to_string (2, text_count - 1, token_buffer)
				current_position.go_to (text_count)
				last_token := TE_STR_FREE
			}
\"\"		{
					-- Empty string.
				current_position.go_to (2)
				last_token := TE_EMPTY_STRING
			}
\"[^%\n"]+\" {
					-- Regular string.
				token_buffer.clear_all
				append_text_substring_to_string (2, text_count - 1, token_buffer)
				current_position.go_to (text_count)
				last_token := TE_STRING
			}
\"[^\n"%]*\[/[ \t\r]*\n {
					-- Verbatim string.
				token_buffer.clear_all
				verbatim_marker.clear_all
				append_text_substring_to_string (2, text_count - 1, verbatim_marker)
				current_position.go_to (text_count)
				set_start_condition (VERBATIM_STR3)
			}
<VERBATIM_STR3>{
		-- Discard space characters at the
		-- end of Verbatim_string_opener.
	[ \t\r]*\n {
				line_number := line_number + 1
				current_position.go_to (text_count)
				current_position.set_line_number (line_number)
				set_start_condition (VERBATIM_STR1)
			}
	.		{
					-- No final bracket-double-quote.
				current_position.go_to (text_count)
				append_text_to_string (token_buffer)
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			}
	<<EOF>>	{
					-- No final bracket-double-quote.
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			}
}
<VERBATIM_STR1>{
		-- Read one line of a verbatim string body
		-- from the beginning of line.
	[ \t\r]*\][^%\n"]*\" {
				if is_verbatim_string_closer then
					current_position.go_to (text_count)
					set_start_condition (INITIAL)
						-- Remove the trailing new-line.
					if token_buffer.count >= 2 then
						check new_line: token_buffer.item (token_buffer.count) = '%N' end
						if token_buffer.item (token_buffer.count - 1) = '%R' then
								-- Under Windows a we have \r\n.
								-- Remove both characters.
							token_buffer.set_count (token_buffer.count - 2)
						else
							token_buffer.set_count (token_buffer.count - 1)
						end
					elseif token_buffer.count = 1 then
						check new_line: token_buffer.item (1) = '%N' end
						token_buffer.clear_all
					end
					if token_buffer.is_empty then
							-- Empty string.
						last_token := TE_EMPTY_VERBATIM_STRING
					else
						last_token := TE_VERBATIM_STRING
					end
				else
					current_position.go_to (text_count)
					append_text_to_string (token_buffer)
					set_start_condition (VERBATIM_STR2)
				end
			}
	[^"\n]*\" {
				current_position.go_to (text_count)
				append_text_to_string (token_buffer)
				set_start_condition (VERBATIM_STR2)
			}
	[^"\n]*\n {
				line_number := line_number + 1
				current_position.go_to (text_count)
				current_position.set_line_number (line_number)
				append_text_to_string (token_buffer)
			}
	[^"\n]* {
					-- No final bracket-double-quote.
				current_position.go_to (text_count)
				append_text_to_string (token_buffer)
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			}
	<<EOF>>	{
					-- No final bracket-double-quote.
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			}
}
<VERBATIM_STR2>{
		-- Read remaining characters of a line
		-- in verbatim string body.
	.*\n	{
				line_number := line_number + 1
				current_position.go_to (text_count)
				current_position.set_line_number (line_number)
				append_text_to_string (token_buffer)
				set_start_condition (VERBATIM_STR1)
			}
	.*		{
					-- No final bracket-double-quote.
				current_position.go_to (text_count)
				append_text_to_string (token_buffer)
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			}
	<<EOF>>	{
					-- No final bracket-double-quote.
				set_start_condition (INITIAL)
				report_missing_end_of_verbatim_string_error (token_buffer)
			}
}
\"[^%\n"]*	{
					-- String with special characters.
				token_buffer.clear_all
				if text_count > 1 then
					append_text_substring_to_string (2, text_count, token_buffer)
				end
				current_position.go_to (text_count)
				set_start_condition (SPECIAL_STR)
			}
<SPECIAL_STR>{
	[^%\n"]+	{
				current_position.go_to (text_count)
				append_text_to_string (token_buffer)
			}
	%A		{
				current_position.go_to (2)
				token_buffer.append_character ('%A')
			}
	%B		{
				current_position.go_to (2)
				token_buffer.append_character ('%B')
			}
	%C		{
				current_position.go_to (2)
				token_buffer.append_character ('%C')
			}
	%D		{
				current_position.go_to (2)
				token_buffer.append_character ('%D')
			}
	%F		{
				current_position.go_to (2)
				token_buffer.append_character ('%F')
			}
	%H		{
				current_position.go_to (2)
				token_buffer.append_character ('%H')
			}
	%L		{
				current_position.go_to (2)
				token_buffer.append_character ('%L')
			}
	%N		{
				current_position.go_to (2)
				token_buffer.append_character ('%N')
			}
	%Q		{
				current_position.go_to (2)
				token_buffer.append_character ('%Q')
			}
	%R		{
				current_position.go_to (2)
				token_buffer.append_character ('%R')
			}
	%S		{
				current_position.go_to (2)
				token_buffer.append_character ('%S')
			}
	%T		{
				current_position.go_to (2)
				token_buffer.append_character ('%T')
			}
	%U		{
				current_position.go_to (2)
				token_buffer.append_character ('%U')
			}
	%V		{
				current_position.go_to (2)
				token_buffer.append_character ('%V')
			}
	%%		{
				current_position.go_to (2)
				token_buffer.append_character ('%%')
			}
	%\'		{
				current_position.go_to (2)
				token_buffer.append_character ('%'')
			}
	%\"		{
				current_position.go_to (2)
				token_buffer.append_character ('%"')
			}
	%\(		{
				current_position.go_to (2)
				token_buffer.append_character ('%(')
			}
	%\)		{
				current_position.go_to (2)
				token_buffer.append_character ('%)')
			}
	%<		{
				current_position.go_to (2)
				token_buffer.append_character ('%<')
			}
	%>		{
				current_position.go_to (2)
				token_buffer.append_character ('%>')
			}
	%\/[0-9]{1,3}\/	{
				current_position.go_to (text_count)
				process_string_character_code (text_substring (3, text_count - 1).to_integer)
			}
	%[ \t\r\n]+%	{
					-- This regular expression should actually be: %\n[ \t\r]*%
					-- Left as-is for compatibility with previous releases.
				line_number := line_number + text.occurrences ('%N')
				current_position.go_to (text_count)
				current_position.set_line_number (line_number)
			}
	[^%\n"]*\"	{
				if text_count > 1 then
					append_text_substring_to_string (1, text_count - 1, token_buffer)
				end
				current_position.go_to (text_count)
				set_start_condition (INITIAL)
				if token_buffer.is_empty then
						-- Empty string.
					last_token := TE_EMPTY_STRING
				else
					last_token := TE_STRING
				end
			}
	%		{
					-- Bad special character.
				current_position.go_to (1)
				set_start_condition (INITIAL)
				report_string_bad_special_character_error
			}
	\n		{
					-- No final double-quote.
				line_number := line_number + 1
				current_position.go_to (1)
				current_position.set_line_number (line_number)
				set_start_condition (INITIAL)
				report_string_missing_quote_error (token_buffer)
			}
	<<EOF>>	{
					-- No final double-quote.
				set_start_condition (INITIAL)
				report_string_missing_quote_error (token_buffer)
			}
}


-- Miscellaneous

<<EOF>>		{
				if inherit_context then
					inherit_context := False
					last_token := TE_END
				else
					terminate
				end
			}
.			{
				current_position.go_to (1)
				report_unknown_token_error (text_item (1))
			}


%%

end -- class EIFFEL_SCANNER


--|----------------------------------------------------------------
--| Copyright (C) 1992-2000, Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited
--| without prior agreement with Interactive Software Engineering.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://eiffel.com
--|----------------------------------------------------------------
