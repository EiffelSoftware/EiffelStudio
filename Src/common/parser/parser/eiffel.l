%{
indexing

	description: "Scanners for Eiffel parsers"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class EIFFEL_SCANNER

inherit
	EIFFEL_SCANNER_SKELETON
		redefine
			read_token
		end

	STRING_HANDLER

create
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
T		[0-9][0-9][0-9]
U		([0-9]|[0-9][0-9]|[0-9][0-9][0-9])

%%


-- Comments

"--".*			current_position.go_to (text_count)


-- Separators

[ \t\r]+		current_position.go_to (text_count)
\n+			{
				line_number := line_number + text_count
				current_position.reset_column_positions
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
				if not Case_sensitive then
					token_buffer.to_lower
				end
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
[aA][sS][sS][iI][gG][nN] {
					-- Note: Identifiers are converted to lower-case.
				token_buffer.clear_all
				append_text_to_string (token_buffer)
				if not Case_sensitive then
					token_buffer.to_lower
				end

				current_position.go_to (6)
				last_token := TE_ID
				if has_syntax_warning then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (current_position.start_position,
							current_position.end_position, filename, 0,
							"Use of `assign', possibly a new keyword in future definition of `Eiffel'."))
				end
			}
[aA][tT][tT][rR][iI][bB][uU][tT][eE] {
					-- Note: Identifiers are converted to lower-case.
				token_buffer.clear_all
				append_text_to_string (token_buffer)
				if not Case_sensitive then
					token_buffer.to_lower
				end

				current_position.go_to (9)
				last_token := TE_ID
				if has_syntax_warning then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (current_position.start_position,
							current_position.end_position, filename, 0,
							"Use of `attribute', possibly a new keyword in future definition of `Eiffel'."))
				end
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
[cC][oO][nN][vV][eE][rR][tT]	{
				current_position.go_to (7)
				last_token := TE_CONVERT
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

{A}{X}*		{
					-- Note: Identifiers are converted to lower-case.
				token_buffer.clear_all
				append_text_to_string (token_buffer)
				if not Case_sensitive then
					token_buffer.to_lower
				end
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
				if not Case_sensitive then
					token_buffer.to_lower
				end
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
				current_position.reset_column_positions
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
				current_position.reset_column_positions
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
				current_position.reset_column_positions
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
				current_position.reset_column_positions	
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
				current_position.reset_column_positions	
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

feature -- Scanning

	read_token is
			-- Read a token from `input_buffer'.
			-- Make result available in `last_token'.
			--| Redefined for performance reasons.
		local
			yy_cp, yy_bp: INTEGER
			yy_current_state: INTEGER
			yy_next_state: INTEGER
			yy_matched_count: INTEGER
			yy_act: INTEGER
			yy_goto: INTEGER
			yy_c: INTEGER
			yy_found: BOOLEAN
			yy_rejected_line: INTEGER
			yy_rejected_column: INTEGER
			yy_rejected_position: INTEGER
		do
				-- This routine is implemented with a loop whose body
				-- is a big inspect instruction. This is a mere
				-- translation of C gotos into Eiffel. Needless to
				-- say that I'm not very proud of this piece of code.
				-- However I performed some benchmarks and the results
				-- were that this implementation runs amazingly faster
				-- than an alternative implementation with no loop nor
				-- inspect instructions and where every branch of the
				-- old inspect instruction was written in a separate
				-- routine. I think that the performance penalty is due
				-- to the routine call overhead and the depth of the call
				-- stack. Anyway, I prefer to provide you with a big and
				-- ugly but fast scanning routine rather than a nice and
				-- slow version. I hope you won't blame me for that! :-)
			from
				last_token := yyUnknown_token
				yy_goto := yyNext_token
			until
				last_token /= yyUnknown_token
			loop
				inspect yy_goto
				when yyNext_token then
					if yy_more_flag then
						yy_more_len := yy_end - yy_start
						yy_more_flag := False
					else
						yy_more_len := 0
						line := yy_line
						column := yy_column
						position := yy_position
					end
					yy_cp := yy_end
						-- `yy_bp' is the position of the first
						-- character of the current token.
					yy_bp := yy_cp
						-- Find the start state.
					yy_current_state := yy_start_state + yy_at_beginning_of_line
					if yyReject_or_variable_trail_context then
							-- Set up for storing up states.
						yy_state_stack.put (yy_current_state, 0)
						yy_state_count := 1
					end
					yy_goto := yyMatch
				when yyMatch then
						-- Find the next match.
					from
						if yy_ec /= Void then
							yy_c := yy_ec.item (yy_content.item (yy_cp).code)
						else
							yy_c := yy_content.item (yy_cp).code
						end
						if
							not yyReject_or_variable_trail_context and then
							yy_accept.item (yy_current_state) /= 0
						then
								-- Save the backing-up info before computing
								-- the next state because we always compute one
								-- more state than needed - we always proceed
								-- until we reach a jam state.
							yy_last_accepting_state := yy_current_state
							yy_last_accepting_cpos := yy_cp
						end
						from until
							yy_chk.item (yy_base.item (yy_current_state) + yy_c) = yy_current_state
						loop
							yy_current_state := yy_def.item (yy_current_state)
							if
								yy_meta /= Void and then
								yy_current_state >= yyTemplate_mark
							then
									-- We've arranged it so that templates are
									-- never chained to one another. This means
									-- we can afford to make a very simple test
									-- to see if we need to convert to `yy_c''s
									-- meta-equivalence class without worrying
									-- about erroneously looking up the meta
									-- equivalence class twice.
								yy_c := yy_meta.item (yy_c)
							end
						end
						yy_current_state := yy_nxt.item (yy_base.item (yy_current_state) + yy_c)
						if yyReject_or_variable_trail_context then
							yy_state_stack.put (yy_current_state, yy_state_count)
							yy_state_count := yy_state_count + 1
						end
						yy_cp := yy_cp + 1
					until
						yy_current_state = yyJam_state
					loop
						if yy_ec /= Void then
							yy_c := yy_ec.item (yy_content.item (yy_cp).code)
						else
							yy_c := yy_content.item (yy_cp).code
						end
						if
							not yyReject_or_variable_trail_context and then
							yy_accept.item (yy_current_state) /= 0
						then
								-- Save the backing-up info before computing
								-- the next state because we always compute one
								-- more state than needed - we always proceed
								-- until we reach a jam state.
							yy_last_accepting_state := yy_current_state
							yy_last_accepting_cpos := yy_cp
						end
						from until
							yy_chk.item (yy_base.item (yy_current_state) + yy_c) = yy_current_state
						loop
							yy_current_state := yy_def.item (yy_current_state)
							if
								yy_meta /= Void and then
								yy_current_state >= yyTemplate_mark
							then
									-- We've arranged it so that templates are
									-- never chained to one another. This means
									-- we can afford to make a very simple test
									-- to see if we need to convert to `yy_c''s
									-- meta-equivalence class without worrying
									-- about erroneously looking up the meta
									-- equivalence class twice.
								yy_c := yy_meta.item (yy_c)
							end
						end
						yy_current_state := yy_nxt.item (yy_base.item (yy_current_state) + yy_c)
						if yyReject_or_variable_trail_context then
							yy_state_stack.put (yy_current_state, yy_state_count)
							yy_state_count := yy_state_count + 1
						end
						yy_cp := yy_cp + 1
					end
					if not yyReject_or_variable_trail_context then
							-- Do the guaranteed-needed backing up
							-- to find out the match.
						yy_cp := yy_last_accepting_cpos
						yy_current_state := yy_last_accepting_state
					end
					yy_goto := yyFind_action
				when yyFind_action then
						-- Find the action number.
					if not yyReject_or_variable_trail_context then
						yy_act := yy_accept.item (yy_current_state)
						yy_goto := yyDo_action
					else
						yy_state_count := yy_state_count - 1
						yy_current_state := yy_state_stack.item (yy_state_count)
						yy_lp := yy_accept.item (yy_current_state)
						yy_goto := yyFind_rule
					end
				when yyFind_rule then
						-- We branch here when backing up.
					check reject_used: yyReject_or_variable_trail_context end
					from yy_found := False until yy_found loop
						if
							yy_lp /= 0 and
							yy_lp < yy_accept.item (yy_current_state + 1)
						then
							yy_act := yy_acclist.item (yy_lp)
							if yyVariable_trail_context then
								if
									yy_act < - yyNb_rules or
									yy_looking_for_trail_begin /= 0
								then
									if yy_act = yy_looking_for_trail_begin then
										yy_looking_for_trail_begin := 0
										yy_act := - yy_act - yyNb_rules
										yy_found := True
									else
										yy_lp := yy_lp + 1
									end
								elseif yy_act < 0 then
									yy_looking_for_trail_begin := yy_act - yyNb_rules
									if yyReject_used then
											-- Remember matched text in case
											-- we back up due to `reject'.
										yy_full_match := yy_cp
										yy_full_state := yy_state_count
										yy_full_lp := yy_lp
									end
									yy_lp := yy_lp + 1
								else
									yy_full_match := yy_cp
									yy_full_state := yy_state_count
									yy_full_lp := yy_lp
									yy_found := True
								end
							else
								yy_full_match := yy_cp
								yy_found := True
							end
						else
							yy_cp := yy_cp - 1
							yy_state_count := yy_state_count - 1
							yy_current_state := yy_state_stack.item (yy_state_count)
							yy_lp := yy_accept.item (yy_current_state)
						end
					end
					yy_rejected_line := yy_line
					yy_rejected_column := yy_column
					yy_rejected_position := yy_position
					yy_goto := yyDo_action
				when yyDo_action then
						-- Set up `text' before action.
					yy_bp := yy_bp - yy_more_len
					yy_start := yy_bp
					yy_end := yy_cp
					debug ("GELEX")
					end
					yy_goto := yyNext_token
						-- Semantic actions.
					if yy_act = 0 then
							-- Must back up.
						if not yyReject_or_variable_trail_context then
								-- Backing-up info for compressed tables is
								-- taken after `yy_cp' has been incremented
								-- for the next state.
							yy_cp := yy_last_accepting_cpos
							yy_bp := yy_bp + yy_more_len
							yy_current_state := yy_last_accepting_state
							yy_goto := yyFind_action
						else
							last_token := yyError_token
							fatal_error ("fatal scanner internal error: no action found")
						end
					elseif yy_act = yyEnd_of_buffer then
							-- Amount of text matched not including
							-- the EOB character.
						yy_matched_count := yy_cp - yy_bp - 1
							-- Note that here we test for `yy_end' "<="
							-- to the position of the first EOB in the buffer,
							-- since `yy_end' will already have been 
							-- incremented past the NULL character (since all
							-- states make transitions on EOB to the 
							-- end-of-buffer state). Contrast this with the
							-- test in `read_character'.
						if yy_end <= input_buffer.count + 1 then
								-- This was really a NULL character.
							yy_end := yy_bp + yy_matched_count
							yy_current_state := yy_previous_state
								-- We're now positioned to make the NULL
								-- transition. We couldn't have
								-- `yy_previous_state' go ahead and do it
								-- for us because it doesn't know how to deal
								-- with the possibility of jamming (and we
								-- don't want to build jamming into it because
								-- then it will run more slowly).
							yy_next_state := yy_null_trans_state (yy_current_state)
							yy_bp := yy_bp + yy_more_len
							if yy_next_state /= 0 then
									-- Consume the NULL character.
								yy_cp := yy_end + 1
								yy_end := yy_cp
								yy_current_state := yy_next_state
								yy_goto := yyMatch
							else
								if yyReject_or_variable_trail_context then
										-- Still need to initialize `yy_cp',
										-- though `yy_current_state' was set
										-- up by `yy_previous_state'.
									yy_cp := yy_end
										-- Remove the state which was inserted
										-- in `yy_state_stack' by the call to
										-- `yy_null_trans_state'.
									yy_state_count := yy_state_count - 1
								else
										-- Do the guaranteed-needed backing up
										-- then figure out the match.
									yy_cp := yy_last_accepting_cpos
									yy_current_state := yy_last_accepting_state
								end
								yy_goto := yyFind_action
							end
						else
								-- Do not take the EOB character
								-- into account.
							yy_end := yy_end - 1
							yy_refill_input_buffer
							if input_buffer.filled then
								yy_current_state := yy_previous_state
								yy_cp := yy_end
								yy_bp := yy_start + yy_more_len
								yy_goto := yyMatch
							elseif
								yy_end - yy_start - yy_more_len /= 0
							then
									-- Some text has been matched prior to
									-- the EOB. First process it.
								yy_current_state := yy_previous_state
								yy_cp := yy_end
								yy_bp := yy_start + yy_more_len
								yy_goto := yyFind_action
							else
									-- Only the EOB character has been matched, 
									-- so treat this as a final EOF.
								if wrap then
									yy_bp := yy_start
									yy_cp := yy_end
									yy_execute_eof_action ((yy_start_state - 1) // 2)
								end
							end
						end
					else
						yy_execute_action (yy_act)
						if yy_rejected then
							yy_rejected := False
							yy_line := yy_rejected_line
							yy_column := yy_rejected_column
							yy_position := yy_rejected_position
								-- Restore position backed-over text.
							yy_cp := yy_full_match
							if yyVariable_trail_context then
									-- Restore original accepting position.
								yy_lp := yy_full_lp
									-- Restore original state.
								yy_state_count := yy_full_state
									-- Restore current state.
								yy_current_state := yy_state_stack.item (yy_state_count - 1)
							end
							yy_lp := yy_lp + 1
							yy_goto := yyFind_rule
						end
					end
				end
			end
			debug ("GELEX")
				print_last_token
			end
		end

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
