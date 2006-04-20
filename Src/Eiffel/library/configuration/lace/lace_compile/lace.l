%{
indexing

	description: "Scanners for Lace parsers"
	status: "See notice at end of class"
	date: "$Date: 2005-04-03 22:36:39 -0700 (Sun, 03 Apr 2005) $"
	revision: "$Revision: 82645 $"

class LACE_SCANNER

inherit

	LACE_SCANNER_SKELETON

creation

	make

%}

%x IN_STR
%option nodefault line position outfile="lace_scanner.e"

A		([a-z]|[A-Z])
X		([a-z]|[A-Z]|[0-9]|_)

%%


-- Comments

"--".*		{
				if is_windows then
					comments.append (text_substring (1, text_count - 1) + "%N")
				else
					comments.append (text_substring (1, text_count) + "%N")
				end
			}

-- Separators

[ \t\r]+
\n+	


-- Symbols

";"			{
				last_token := LAC_SEMICOLON
			}
":"			{
				last_token := LAC_COLON
			}
","			{
				last_token := LAC_COMMA
			}
"("			{
				last_token := LAC_LEFT_PARAM
			}
")"			{
				last_token := LAC_RIGHT_PARAM
			}


-- Reserved words

[aA][dD][aA][pP][tT]	{
				last_token := LAC_ADAPT
			}
[aA][lL][lL]	{
				last_token := LAC_ALL
			}
[aA][sS]	{
				last_token := LAC_AS
			}
[aA][sS][sS][eE][mM][bB][lL][yY] {
				last_token := LAC_ASSEMBLY
			}
[aA][sS][sS][eE][rR][tT][iI][oO][nN]	{
				last_token := LAC_ASSERTION
			}
[cC][hH][eE][cC][kK]	{
				last_token := LAC_CHECK
			}
[cC][lL][uU][sS][tT][eE][rR]	{
				last_token := LAC_CLUSTER
			}
[cC][rR][eE][aA][tT][eE]	{
				last_token := LAC_CREATION
			}
[cC][rR][eE][aA][tT][iI][oO][nN]	{
				last_token := LAC_CREATION
			}
[dD][eE][bB][uU][gG]	{
				last_token := LAC_DEBUG
			}
[dD][iI][sS][aA][bB][lL][eE][dD]_[dD][eE][bB][uU][gG]	{
				last_token := LAC_DISABLED_DEBUG
			}
[dD][eE][fF][aA][uU][lL][tT]	{
				last_token := LAC_DEFAULT
			}
[eE][nN][dD]	{
				last_token := LAC_END
			}
[eE][nN][sS][uU][rR][eE]	{
				last_token := LAC_ENSURE
			}
[eE][xX][cC][lL][uU][dD][eE]	{
				last_token := LAC_EXCLUDE
			}
[dD][eE][pP][eE][nN][dD]	{
				last_token := LAC_DEPEND
			}
[eE][xX][pP][oO][rR][tT]	{
				last_token := LAC_EXPORT
			}
[eE][xX][tT][eE][rR][nN][aA][lL]	{
				last_token := LAC_EXTERNAL
			}
[gG][eE][nN][eE][rR][aA][tT][eE]	{
				last_token := LAC_GENERATE
			} 

[iI][gG][nN][oO][rR][eE]	{
				last_token := LAC_IGNORE
			}
[iI][nN][cC][lL][uU][dD][eE]	{
				last_token := LAC_INCLUDE
			}
[iI][nN][vV][aA][rR][iI][aA][nN][tT]	{
				last_token := LAC_INVARIANT
			}
[lL][iI][bB][rR][aA][rR][yY]	{
				last_token := LAC_LIBRARY
			}
[lL][oO][oO][pP]	{
				last_token := LAC_LOOP
			}
[nN][oO]	{
				last_token := LAC_NO
			}
[oO][pP][tT][iI][mM][iI][zZ][eE]	{
				last_token := LAC_OPTIMIZE
			}
[oO][pP][tT][iI][oO][nN]	{
				last_token := LAC_OPTION
			}
[pP][rR][eE][cC][oO][mM][pP][iI][lL][eE][dD]	{
				last_token := LAC_PRECOMPILED
			}
[pP][rR][eE][fF][iI][xX] {
				last_token := LAC_PREFIX
			}
[rR][eE][nN][aA][mM][eE]	{
				last_token := LAC_RENAME
			}
[rR][eE][qQ][uU][iI][rR][eE]	{
				last_token := LAC_REQUIRE
			}
[rR][oO][oO][tT]	{
				last_token := LAC_ROOT
			}
[sS][yY][sS][tT][eE][mM]	{
				last_token := LAC_SYSTEM
			}
[tT][rR][aA][cC][eE]	{
				last_token := LAC_TRACE
			}
[uU][sS][eE]	{
				last_token := LAC_USE
			}
[vV][iI][sS][iI][bB][lL][eE]	{
				last_token := LAC_VISIBLE
			}
[yY][eE][sS]	{
				last_token := LAC_YES
			}


-- Identifiers

{A}{X}*		{
					-- Note: Identifiers are converted to lower-case.
				token_buffer.clear_all
				append_text_to_string (token_buffer)
				token_buffer.to_lower
				last_token := LAC_IDENTIFIER
			}


-- Strings

\"\"		{
					-- Empty string.
				report_string_empty_error
				last_token := LAC_STRING
			}
\"[^%\n"]+\" {
				token_buffer.clear_all
				append_text_substring_to_string (2, text_count - 1, token_buffer)
				last_token := LAC_STRING
			}
\"[^%\n"]*	{
				token_buffer.clear_all
				if text_count > 1 then
					append_text_substring_to_string (2, text_count, token_buffer)
				end
				set_start_condition (IN_STR)
			}
<IN_STR>{
	[^%\n"]+	{
				append_text_to_string (token_buffer)
			}
	%A		{
				token_buffer.append_character ('%A')
			}
	%B		{
				token_buffer.append_character ('%B')
			}
	%C		{
				token_buffer.append_character ('%C')
			}
	%D		{
				token_buffer.append_character ('%D')
			}
	%F		{
				token_buffer.append_character ('%F')
			}
	%H		{
				token_buffer.append_character ('%H')
			}
	%L		{
				token_buffer.append_character ('%L')
			}
	%N		{
				token_buffer.append_character ('%N')
			}
	%Q		{
				token_buffer.append_character ('%Q')
			}
	%R		{
				token_buffer.append_character ('%R')
			}
	%S		{
				token_buffer.append_character ('%S')
			}
	%T		{
				token_buffer.append_character ('%T')
			}
	%U		{
				token_buffer.append_character ('%U')
			}
	%V		{
				token_buffer.append_character ('%V')
			}
	%%		{
				token_buffer.append_character ('%%')
			}
	%\'		{
				token_buffer.append_character ('%'')
			}
	%\"		{
				token_buffer.append_character ('%"')
			}
	%\(		{
				token_buffer.append_character ('%(')
			}
	%\)		{
				token_buffer.append_character ('%)')
			}
	%<		{
				token_buffer.append_character ('%<')
			}
	%>		{
				token_buffer.append_character ('%>')
			}
	%\/[0-9]{1,3}\/	{
				process_string_character_code (text_substring (3, text_count - 1).to_integer)
			}
	%[ \t\r\n]+%	{
					-- This regular expression should actually be: %\n[ \t\r]*%
					-- Left as-is for compatibility with previous releases.
			}
	[^%\n"]*\"	{
				if text_count > 1 then
					append_text_substring_to_string (1, text_count - 1, token_buffer)
				end
				set_start_condition (INITIAL)
				if token_buffer.is_empty then
					report_string_empty_error
				end
				last_token := LAC_STRING
			}
	%		{
					-- Bad special character.
				set_start_condition (INITIAL)
				report_string_bad_special_character_error
			}
	\n		{
					-- No final double-quote.
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
