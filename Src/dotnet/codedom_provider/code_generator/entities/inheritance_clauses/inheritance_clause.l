%{
indexing
	description: "Scanners for snippet inheritance clauses"
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_INHERITANCE_CLAUSE_SCANNER

inherit
	YY_COMPRESSED_SCANNER_SKELETON
		rename
			make as make_compressed_scanner_skeleton
		redefine
			reset
		end

	CODE_INHERITANCE_CLAUSE_TOKENS
		export
			{NONE} all
		end

create
	make
%}
%option nodefault outfile="code_inheritance_clause_scanner.e"

A		([a-z]|[A-Z])
X		([a-z]|[A-Z]|[0-9]|_)

%%

-- Separators

[ \t\r]+		current_position.go_to (text_count)
\n+				current_position.go_to (text_count)

-- Symbols

","			{
				current_position.go_to (1)
				last_token := TE_COMMA
			}
";"			{
				current_position.go_to (1)
				last_token := TE_SEMICOLON
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

-- Reserved words
[aA][lL][lL]	{
				current_position.go_to (3)
				last_token := TE_ALL
			}
[aA][sS]	{
				current_position.go_to (2)
				last_token := TE_AS
			}
[bB][iI][tT]	{
				current_position.go_to (3)
				last_token := TE_BIT
			}
[cC][uU][rR][rR][eE][nN][tT]	{
				current_position.go_to (7)
				last_token := TE_CURRENT
			}
[eE][nN][dD]	{
				current_position.go_to (3)
				last_token := TE_END
			}
[eE][xX][pP][oO][rR][tT]	{
				current_position.go_to (6)
				last_token := TE_EXPORT
			}
[iI][nN][fF][iI][xX]	{
				current_position.go_to (5)
				last_token := TE_INFIX
			}
[iI][nN][hH][eE][rR][iI][tT]	{
				current_position.go_to (7)
				last_token := TE_INHERIT
			}
[lL][iI][kK][eE]	{
				current_position.go_to (4)
				last_token := TE_LIKE
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
[sS][eE][lL][eE][cC][tT]	{
				current_position.go_to (6)
				last_token := TE_SELECT
			}
[sS][eE][pP][aA][rR][aA][tT][eE]	{
				current_position.go_to (8)
				last_token := TE_SEPARATE
			}
[uU][nN][dD][eE][fF][iI][nN][eE]	{
				current_position.go_to (8)
				last_token := TE_UNDEFINE
			}

-- Identifiers

{A}{X}*		{
					-- Note: Identifiers are converted to lower-case.
				token_buffer.clear_all
				append_text_to_string (token_buffer)
				current_position.go_to (token_buffer.count)
				last_token := TE_ID
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

.			{
				current_position.go_to (1)
			}
%%

feature {NONE} -- Initialization

	make is
			-- Create a new external scanner.
		do
			make_with_buffer (Empty_buffer)
			!! token_buffer.make (Initial_buffer_size)
			!! current_position.reset
		end

feature -- Initialization

	reset is
			-- Reset scanner before scanning next input source.
			-- (This routine can be called in wrap before scanning
			-- another input buffer.)
		do
			Precursor
			token_buffer.clear_all
			current_position.reset
		end

feature -- Access

	token_buffer: STRING
			-- Buffer for lexial tokens

	current_position: TOKEN_LOCATION
			-- Position of last token read
	
	last_value: ANY
			-- Semantic value to be passed to the parser

feature {NONE} -- Constants

	Initial_buffer_size: INTEGER is 1024 
				-- Initial size for `token_buffer'

invariant
	token_buffer_not_void: token_buffer /= Void
	current_position_not_void: current_position /= Void

end -- class CODE_INHERITANCE_CLAUSE_SCANNER


--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------