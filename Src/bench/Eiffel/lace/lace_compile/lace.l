%{
indexing

	description: "Scanners for Lace parsers"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class LACE_SCANNER

inherit

	LACE_SCANNER_SKELETON

creation

	make

%}

%x IN_STR
%option nodefault outfile="lace_scanner.e"

A		([a-z]|[A-Z])
X		([a-z]|[A-Z]|[0-9]|_)

%%


-- Comments

"--".*		{
				current_position.go_to (text_count)
				comment_list.extend (text_substring (1, text_count - 1))
			}

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
				last_token := LAC_SEMICOLON
			}
":"			{
				current_position.go_to (1)
				last_token := LAC_COLON
			}
","			{
				current_position.go_to (1)
				last_token := LAC_COMMA
			}
"("			{
				current_position.go_to (1)
				last_token := LAC_LEFT_PARAM
			}
")"			{
				current_position.go_to (1)
				last_token := LAC_RIGHT_PARAM
			}


-- Reserved words

[aA][dD][aA][pP][tT]	{
				current_position.go_to (5)
				last_token := LAC_ADAPT
			}
[aA][lL][lL]	{
				current_position.go_to (3)
				last_token := LAC_ALL
			}
[aA][sS]	{
				current_position.go_to (2)
				last_token := LAC_AS
			}
[aA][sS][sS][eE][rR][tT][iI][oO][nN]	{
				current_position.go_to (9)
				last_token := LAC_ASSERTION
			}
[cC][hH][eE][cC][kK]	{
				current_position.go_to (5)
				last_token := LAC_CHECK
			}
[cC][lL][uU][sS][tT][eE][rR]	{
				current_position.go_to (7)
				last_token := LAC_CLUSTER
			}
[cC][rR][eE][aA][tT][eE]	{
				current_position.go_to (6)
				last_token := LAC_CREATION
			}
[cC][rR][eE][aA][tT][iI][oO][nN]	{
				current_position.go_to (8)
				last_token := LAC_CREATION
			}
[dD][eE][bB][uU][gG]	{
				current_position.go_to (5)
				last_token := LAC_DEBUG
			}
[dD][iI][sS][aA][bB][lL][eE][dD]_[dD][eE][bB][uU][gG]	{
				current_position.go_to (14)
				last_token := LAC_DISABLED_DEBUG
			}
[dD][eE][fF][aA][uU][lL][tT]	{
				current_position.go_to (7)
				last_token := LAC_DEFAULT
			}
[eE][nN][dD]	{
				current_position.go_to (3)
				last_token := LAC_END
			}
[eE][nN][sS][uU][rR][eE]	{
				current_position.go_to (6)
				last_token := LAC_ENSURE
			}
[eE][xX][cC][lL][uU][dD][eE]	{
				current_position.go_to (7)
				last_token := LAC_EXCLUDE
			}
[dD][eE][pP][eE][nN][dD]	{
				current_position.go_to (6)
				last_token := LAC_DEPEND
			}
[eE][xX][pP][oO][rR][tT]	{
				current_position.go_to (6)
				last_token := LAC_EXPORT
			}
[eE][xX][tT][eE][rR][nN][aA][lL]	{
				current_position.go_to (8)
				last_token := LAC_EXTERNAL
			}
[gG][eE][nN][eE][rR][aA][tT][eE]	{
				current_position.go_to (8)
				last_token := LAC_GENERATE
			} 

[iI][gG][nN][oO][rR][eE]	{
				current_position.go_to (6)
				last_token := LAC_IGNORE
			}
[iI][nN][cC][lL][uU][dD][eE]	{
				current_position.go_to (7)
				last_token := LAC_INCLUDE
			}
[iI][nN][vV][aA][rR][iI][aA][nN][tT]	{
				current_position.go_to (9)
				last_token := LAC_INVARIANT
			}
[lL][iI][bB][rR][aA][rR][yY]	{
				current_position.go_to (7)
				last_token := LAC_LIBRARY
			}
[lL][oO][oO][pP]	{
				current_position.go_to (4)
				last_token := LAC_LOOP
			}
[nN][oO]	{
				current_position.go_to (2)
				last_token := LAC_NO
			}
[oO][pP][tT][iI][mM][iI][zZ][eE]	{
				current_position.go_to (8)
				last_token := LAC_OPTIMIZE
			}
[oO][pP][tT][iI][oO][nN]	{
				current_position.go_to (6)
				last_token := LAC_OPTION
			}
[pP][rR][eE][cC][oO][mM][pP][iI][lL][eE][dD]	{
				current_position.go_to (11)
				last_token := LAC_PRECOMPILED
			}
[rR][eE][nN][aA][mM][eE]	{
				current_position.go_to (6)
				last_token := LAC_RENAME
			}
[rR][eE][qQ][uU][iI][rR][eE]	{
				current_position.go_to (7)
				last_token := LAC_REQUIRE
			}
[rR][oO][oO][tT]	{
				current_position.go_to (4)
				last_token := LAC_ROOT
			}
[sS][yY][sS][tT][eE][mM]	{
				current_position.go_to (6)
				last_token := LAC_SYSTEM
			}
[tT][rR][aA][cC][eE]	{
				current_position.go_to (5)
				last_token := LAC_TRACE
			}
[uU][sS][eE]	{
				current_position.go_to (3)
				last_token := LAC_USE
			}
[vV][iI][sS][iI][bB][lL][eE]	{
				current_position.go_to (7)
				last_token := LAC_VISIBLE
			}
[yY][eE][sS]	{
				current_position.go_to (3)
				last_token := LAC_YES
			}


-- Identifiers

{A}{X}*		{
					-- Note: Identifiers are converted to lower-case.
				token_buffer.clear_all
				append_text_to_string (token_buffer)
				token_buffer.to_lower
				current_position.go_to (token_buffer.count)
				last_token := LAC_IDENTIFIER
			}


-- Strings

\"\"		{
					-- Empty string.
				current_position.go_to (2)
				report_string_empty_error
				last_token := LAC_STRING
			}
\"[^%\n"]+\" {
				token_buffer.clear_all
				append_text_substring_to_string (2, text_count - 1, token_buffer)
				current_position.go_to (text_count)
				last_token := LAC_STRING
			}
\"[^%\n"]*	{
				token_buffer.clear_all
				if text_count > 1 then
					append_text_substring_to_string (2, text_count, token_buffer)
				end
				current_position.go_to (text_count)
				set_start_condition (IN_STR)
			}
<IN_STR>{
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
					report_string_empty_error
				end
				last_token := LAC_STRING
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
				terminate
			}
.			{
				current_position.go_to (1)
				report_unknown_token_error (text_item (1))
			}


%%

end -- class LACE_SCANNER


--|----------------------------------------------------------------
--| Copyright (C) 1992-1999, Interactive Software Engineering Inc.
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
