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

create
	make

%}

%x SPECIAL_STR VERBATIM_STR1 VERBATIM_STR2 VERBATIM_STR3
%option line position nodefault outfile="eiffel_scanner.e"

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

"--".*	


-- Separators

[ \t\r]+
\n+	

-- Symbols

";"			{
				last_token := TE_SEMICOLON
			}
":"			{
				last_token := TE_COLON
			}
","			{
				last_token := TE_COMMA
			}
".."		{
				last_token := TE_DOTDOT
			}
"?"			{
				last_token := TE_QUESTION
			}
"~"			{
				last_token := TE_TILDE
			}
"}~"		{
				last_token := TE_CURLYTILDE
			}
"."			{
				last_token := TE_DOT
			}
"$"			{
				last_token := TE_ADDRESS
			}
":="		{
				last_token := TE_ASSIGN
			}
"?="		{
				last_token := TE_ACCEPT
			}
"="			{
				last_token := TE_EQ
			}
"<"			{
				last_token := TE_LT
			}
">"			{
				last_token := TE_GT
			}
"<="		{
				last_token := TE_LE
			}
">="		{
				last_token := TE_GE
			}
"/="		{
				last_token := TE_NE
			}
"("			{
				last_token := TE_LPARAN
			}
")"			{
				last_token := TE_RPARAN
			}
"{"			{
				last_token := TE_LCURLY
			}
"}"			{
				last_token := TE_RCURLY
			}
"["			{
				last_token := TE_LSQURE
			}
"]"			{
				last_token := TE_RSQURE
			}
"+"			{
				last_token := TE_PLUS
			}
"-"			{
				last_token := TE_MINUS
			}
"*"			{
				last_token := TE_STAR
			}
"/"			{
				last_token := TE_SLASH
			}
"^"			{
				last_token := TE_POWER
			}
"->"  		{
				last_token := TE_CONSTRAIN
			}
"!"			{
				last_token := TE_BANG
			}
"<<"		{
				last_token := TE_LARRAY
			}
">>"		{
				last_token := TE_RARRAY
			}
"//"		{
				last_token := TE_DIV
			}
"\\\\"		{
				last_token := TE_MOD
			}


-- Free operators

(@|#|\||&)[@#0-9a-zA-Z_!\$&\'\(\)\*\+\,\-\./:;<>=\?\[\\\]\^\`\{\}\|\~]* {
				last_token := TE_FREE
				process_id_as
			}


-- Reserved words

[aA][gG][eE][nN][tT]	{
				last_token := TE_AGENT
			}
[aA][lL][iI][aA][sS]	{
				last_token := TE_ALIAS
			}
[aA][lL][lL]	{
				last_token := TE_ALL
			}
[aA][nN][dD]	{
				last_token := TE_AND
			}
[aA][sS]	{
				last_token := TE_AS
			}
[aA][sS][sS][iI][gG][nN] {
				last_token := TE_ID
				process_id_as
				if has_syntax_warning then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (line, column, filename,
							"Use of `assign', possibly a new keyword in future definition of `Eiffel'."))
				end
			}
[aA][tT][tT][rR][iI][bB][uU][tT][eE] {
				last_token := TE_ID
				process_id_as
				if has_syntax_warning then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (line, column, filename,
							"Use of `attribute', possibly a new keyword in future definition of `Eiffel'."))
				end
			}
[bB][iI][tT]	{
				last_token := TE_BIT
			}
[cC][hH][eE][cC][kK]	{
				last_token := TE_CHECK
			}
[cC][lL][aA][sS][sS]	{
				last_token := TE_CLASS
			}
[cC][oO][nN][vV][eE][rR][tT]	{
				last_token := TE_CONVERT
			}
[cC][rR][eE][aA][tT][eE]	{
				last_token := TE_CREATE
			}
[cC][rR][eE][aA][tT][iI][oO][nN]	{
				last_token := TE_CREATION
				last_location_as_value := ast_factory.new_location_as (line, column, position, 8)
			}
[cC][uU][rR][rR][eE][nN][tT]	{
				last_token := TE_CURRENT
				last_current_as_value := ast_factory.new_current_as (line, column, position, 7)
			}
[dD][eE][bB][uU][gG]	{
				last_token := TE_DEBUG
			}
[dD][eE][fF][eE][rR][rR][eE][dD]	{
				last_token := TE_DEFERRED
				last_deferred_as_value := ast_factory.new_deferred_as (line, column, position, 8)
			}
[dD][oO]	{
				last_token := TE_DO
			}
[eE][lL][sS][eE]	{
				last_token := TE_ELSE
			}
[eE][lL][sS][eE][iI][fF]	{
				last_token := TE_ELSEIF
			}
[eE][nN][dD]	{
				last_token := TE_END
				last_location_as_value := ast_factory.new_location_as (line, column, position, 3)
			}
[eE][nN][sS][uU][rR][eE]	{
				last_token := TE_ENSURE
			}
[eE][xX][pP][aA][nN][dD][eE][dD]	{
				last_token := TE_EXPANDED
			}
[eE][xX][pP][oO][rR][tT]	{
				last_token := TE_EXPORT
			}
[eE][xX][tT][eE][rR][nN][aA][lL]	{
				last_token := TE_EXTERNAL
			}
[fF][aA][lL][sS][eE]	{
				last_token := TE_FALSE
				last_bool_as_value := ast_factory.new_boolean_as (False, line, column, position, 5)
			}
[fF][eE][aA][tT][uU][rR][eE]	{
				last_token := TE_FEATURE
			}
[fF][rR][oO][mM]	{
				last_token := TE_FROM
			}
[fF][rR][oO][zZ][eE][nN]	{
				last_token := TE_FROZEN
			}
[iI][fF]	{
				last_token := TE_IF
			}
[iI][mM][pP][lL][iI][eE][sS]	{
				last_token := TE_IMPLIES
			}
[iI][nN][dD][eE][xX][iI][nN][gG]	{
				last_token := TE_INDEXING
			}
[iI][nN][fF][iI][xX]	{
				last_token := TE_INFIX
			}
[iI][nN][hH][eE][rR][iI][tT]	{
				last_token := TE_INHERIT
			}
[iI][nN][sS][pP][eE][cC][tT]	{
				last_token := TE_INSPECT
			}
[iI][nN][vV][aA][rR][iI][aA][nN][tT]	{
				last_token := TE_INVARIANT
			}
[iI][sS]	{
				last_token := TE_IS
			}
[lL][iI][kK][eE]	{
				last_token := TE_LIKE
			}
[lL][oO][cC][aA][lL]	{
				last_token := TE_LOCAL
			}
[lL][oO][oO][pP]	{
				last_token := TE_LOOP
			}
[nN][oO][tT]	{
				last_token := TE_NOT
			}
[oO][bB][sS][oO][lL][eE][tT][eE]	{
				last_token := TE_OBSOLETE
			}
[oO][lL][dD]	{
				last_token := TE_OLD
			}
-- We need to make the distinction between once keywords followed
-- by a manifest string and once keywords introducing a once-routine
-- because otherwise we would need to have two look-ahead tokens
-- to figure out that the first once keyword in the following example
-- in part of a once manifest string expression and the second is
-- part of the compound of the once routine:
--   f is
--      require
--         once "foo" /= Void
--      once
--         do_nothing
--      end
[oO][nN][cC][eE]/\"	{
				last_token := TE_ONCE_STRING
			}
[oO][nN][cC][eE][ \t\r\n]+/\"	{
				last_token := TE_ONCE_STRING
			}
[oO][nN][cC][eE]([ \t\r\n]|"--".*\n)+/\"	{
				last_token := TE_ONCE_STRING
			}
[oO][nN][cC][eE]	{
				last_token := TE_ONCE
			}
[oO][rR]	{
				last_token := TE_OR
			}
[pP][rR][eE][cC][uU][rR][sS][oO][rR]	{
				last_token := TE_PRECURSOR
				last_location_as_value := ast_factory.new_location_as (line, column, position, 9)
			}
[pP][rR][eE][fF][iI][xX]	{
				last_token := TE_PREFIX
			}
[rR][eE][dD][eE][fF][iI][nN][eE]	{
				last_token := TE_REDEFINE
			}
[rR][eE][fF][eE][rR][eE][nN][cC][eE] {
				last_token := TE_REFERENCE
			}
[rR][eE][nN][aA][mM][eE]	{
				last_token := TE_RENAME
			}
[rR][eE][qQ][uU][iI][rR][eE]	{
				last_token := TE_REQUIRE
			}
[rR][eE][sS][cC][uU][eE]	{
				last_token := TE_RESCUE
			}
[rR][eE][sS][uU][lL][tT]	{
				last_token := TE_RESULT
				last_result_as_value := ast_factory.new_result_as (line, column, position, 6)
			}
[rR][eE][tT][rR][yY]	{
				last_token := TE_RETRY
				last_retry_as_value := ast_factory.new_retry_as (line, column, position, 5)
			}
[sS][eE][lL][eE][cC][tT]	{
				last_token := TE_SELECT
			}
[sS][eE][pP][aA][rR][aA][tT][eE]	{
				last_token := TE_SEPARATE
			}
[sS][tT][rR][iI][pP]	{
				last_token := TE_STRIP
			}
[tT][hH][eE][nN]	{
				last_token := TE_THEN
			}
[tT][rR][uU][eE]	{
				last_token := TE_TRUE
				last_bool_as_value := ast_factory.new_boolean_as (True, line, column, position, 4)
			}
[uU][nN][dD][eE][fF][iI][nN][eE]	{
				last_token := TE_UNDEFINE
			}
[uU][nN][iI][qQ][uU][eE]	{
				last_token := TE_UNIQUE
				last_unique_as_value := ast_factory.new_unique_as (line, column, position, 6)
			}
[uU][nN][tT][iI][lL]	{
				last_token := TE_UNTIL
			}
[vV][aA][rR][iI][aA][nN][tT]	{
				last_token := TE_VARIANT
			}
[vV][oO][iI][dD] {
				last_token := TE_VOID
				last_void_as_value := ast_factory.new_void_as (line, column, position, 4)
			}
[wW][hH][eE][nN]	{
				last_token := TE_WHEN
			}
[xX][oO][rR]	{
				last_token := TE_XOR
			}


-- Identifiers

{A}{X}*		{
				last_token := TE_ID
				process_id_as
			}


-- Bits

[0-1]+[bB]	{
				last_token := TE_A_BIT
				last_id_as_value := ast_factory.new_filled_id_as (line, column,
					position, text_count - 1)
				if last_id_as_value /= Void then
					append_text_substring_to_string (1, text_count - 1, last_id_as_value)
				end
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
				last_token := TE_INTEGER
			}

({U}(_{T})*)	{
				token_buffer.clear_all
				append_text_to_string (token_buffer)
				last_token := TE_INTEGER
			}

0[xX]{H}(({H}|_)*{H})?	{		-- Recognizes hexadecimal integer numbers.
				token_buffer.clear_all
				append_text_to_string (token_buffer)
				last_token := TE_INTEGER
			}

-- Reals

({D}*\.{D}+{E})|({D}+\.{D}*{E})|(({U}(_{T})*)?\.({T}_)*{U}{E})|({U}(_{T})*\.(({T}_)*{U})?{E}) {
				token_buffer.clear_all
				append_text_to_string (token_buffer)
				if not Case_sensitive then
					token_buffer.to_lower
				end
				last_token := TE_REAL
			}


-- Characters

\'[^%\n']\'	{
				token_buffer.clear_all
				token_buffer.append_character (text_item (2))
				last_token := TE_CHAR
			}
\'\'\'		{
					-- This is not correct Eiffel!
				token_buffer.clear_all
				token_buffer.append_character ('%'')
				last_token := TE_CHAR
			}
\'%A\'		{
				token_buffer.clear_all
				token_buffer.append_character ('%A')
				last_token := TE_CHAR
			}
\'%B\'		{
				token_buffer.clear_all
				token_buffer.append_character ('%B')
				last_token := TE_CHAR
			}
\'%C\'		{
				token_buffer.clear_all
				token_buffer.append_character ('%C')
				last_token := TE_CHAR
			}
\'%D\'		{
				token_buffer.clear_all
				token_buffer.append_character ('%D')
				last_token := TE_CHAR
			}
\'%F\'		{
				token_buffer.clear_all
				token_buffer.append_character ('%F')
				last_token := TE_CHAR
			}
\'%H\'		{
				token_buffer.clear_all
				token_buffer.append_character ('%H')
				last_token := TE_CHAR
			}
\'%L\'		{
				token_buffer.clear_all
				token_buffer.append_character ('%L')
				last_token := TE_CHAR
			}
\'%N\'		{
				token_buffer.clear_all
				token_buffer.append_character ('%N')
				last_token := TE_CHAR
			}
\'%Q\'		{
				token_buffer.clear_all
				token_buffer.append_character ('%Q')
				last_token := TE_CHAR
			}
\'%R\'		{
				token_buffer.clear_all
				token_buffer.append_character ('%R')
				last_token := TE_CHAR
			}
\'%S\'		{
				token_buffer.clear_all
				token_buffer.append_character ('%S')
				last_token := TE_CHAR
			}
\'%T\'		{
				token_buffer.clear_all
				token_buffer.append_character ('%T')
				last_token := TE_CHAR
			}
\'%U\'		{
				token_buffer.clear_all
				token_buffer.append_character ('%U')
				last_token := TE_CHAR
			}
\'%V\'		{
				token_buffer.clear_all
				token_buffer.append_character ('%V')
				last_token := TE_CHAR
			}
\'%%\'		{
				token_buffer.clear_all
				token_buffer.append_character ('%%')
				last_token := TE_CHAR
			}
\'%\'\'		{
				token_buffer.clear_all
				token_buffer.append_character ('%'')
				last_token := TE_CHAR
			}
\'%\"\'		{
				token_buffer.clear_all
				token_buffer.append_character ('%"')
				last_token := TE_CHAR
			}
\'%\(\'		{
				token_buffer.clear_all
				token_buffer.append_character ('%(')
				last_token := TE_CHAR
			}
\'%\)\'		{
				token_buffer.clear_all
				token_buffer.append_character ('%)')
				last_token := TE_CHAR
			}
\'%<\'		{
				token_buffer.clear_all
				token_buffer.append_character ('%<')
				last_token := TE_CHAR
			}
\'%>\'		{
				token_buffer.clear_all
				token_buffer.append_character ('%>')
				last_token := TE_CHAR
			}
\'%\/[0-9]+\/\'	{
				process_character_code (text_substring (4, text_count - 2).to_integer)
			}
\'.{0,2}			|
\'%\/[0-9]+(\/)?	{
					-- Unrecognized character.
					-- (catch-all rules (no backing up))
				report_character_missing_quote_error (text)
			}


-- Strings

\""<"\"		{
				last_token := TE_STR_LT
			}
\"">"\"		{
				last_token := TE_STR_GT
			}
\""<="\"	{
				last_token := TE_STR_LE
			}
\"">="\"	{
				last_token := TE_STR_GE
			}
\""+"\"		{
				last_token := TE_STR_PLUS
			}
\""-"\"		{
				last_token := TE_STR_MINUS
			}
\""*"\"		{
				last_token := TE_STR_STAR
			}
\""/"\"		{
				last_token := TE_STR_SLASH
			}
\""^"\"		{
				last_token := TE_STR_POWER
			}
\""//"\"	{
				last_token := TE_STR_DIV
			}
\""\\\\"\"	{
				last_token := TE_STR_MOD
			}
\""[]"\"	{
				last_token := TE_STR_BRACKET
			}
\"[aA][nN][dD]\"	{
				token_buffer.clear_all
				append_text_substring_to_string (2, 4, token_buffer)
				last_token := TE_STR_AND
			}
\"[aA][nN][dD]\ [tT][hH][eE][nN]\"	{
				token_buffer.clear_all
				append_text_substring_to_string (2, 9, token_buffer)
				last_token := TE_STR_AND_THEN
			}
\"[iI][mM][pP][lL][iI][eE][sS]\"	{
				token_buffer.clear_all
				append_text_substring_to_string (2, 8, token_buffer)
				last_token := TE_STR_IMPLIES
			}
\"[nN][oO][tT]\"	{
				token_buffer.clear_all
				append_text_substring_to_string (2, 4, token_buffer)
				last_token := TE_STR_NOT
			}
\"[oO][rR]\"	{
				token_buffer.clear_all
				append_text_substring_to_string (2, 3, token_buffer)
				last_token := TE_STR_OR
			}
\"[oO][rR]\ [eE][lL][sS][eE]\"	{
				token_buffer.clear_all
				append_text_substring_to_string (2, 8, token_buffer)
				last_token := TE_STR_OR_ELSE
			}
\"[xX][oO][rR]\"	{
				token_buffer.clear_all
				append_text_substring_to_string (2, 4, token_buffer)
				last_token := TE_STR_XOR
			}
\"(@|#|\||&)[@#0-9a-zA-Z_!\$&\'\(\)\*\+\,\-\./:;<>=\?\[\\\]\^\`\{\}\|\~]*\"	{
				token_buffer.clear_all
				append_text_substring_to_string (2, text_count - 1, token_buffer)
				last_token := TE_STR_FREE
				if token_buffer.count > maximum_string_length then
					report_too_long_string (token_buffer)
				end
			}
\"\"		{
					-- Empty string.
				string_position := position
				last_token := TE_EMPTY_STRING
			}
\"[^%\n"]+\" {
					-- Regular string.
				string_position := position
				token_buffer.clear_all
				append_text_substring_to_string (2, text_count - 1, token_buffer)
				last_token := TE_STRING
				if token_buffer.count > maximum_string_length then
					report_too_long_string (token_buffer)
				end
			}
\"[^\n"]*[\[\{]/[ \t\r]*\n {
					-- Verbatim string.
				string_position := position
				token_buffer.clear_all
				verbatim_marker.clear_all
				if text_item (text_count) = '[' then
					verbatim_marker.append_character (']')
				else
					verbatim_marker.append_character ('}')
				end
				append_text_substring_to_string (2, text_count - 1, verbatim_marker)
				set_start_condition (VERBATIM_STR3)
			}
<VERBATIM_STR3>{
		-- Discard space characters at the
		-- end of Verbatim_string_opener.
	[ \t\r]*\n {
				set_start_condition (VERBATIM_STR1)
			}
	.		{
					-- No final bracket-double-quote.
				append_text_to_string (token_buffer)
				if token_buffer.count > 2 and then token_buffer.item (token_buffer.count - 1) = '%R' then
						-- Remove \r in \r\n.
					token_buffer.remove (token_buffer.count - 1)
				end
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
	[ \t\r]*[\]\}][^\n"]*\" {
				if is_verbatim_string_closer then
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
					if verbatim_marker.item (1) = ']' then
						if not has_old_verbatim_strings then
							align_left (token_buffer)
						end
						if has_old_verbatim_strings_warning then
							Error_handler.insert_warning (
								create {SYNTAX_WARNING}.make (line, column, filename,
									"Default verbatim string handling is changed to follow standard semantics %
									%with alignment instead of previous non-standard one without alignment."))
						end
					end
					if token_buffer.is_empty then
							-- Empty string.
						last_token := TE_EMPTY_VERBATIM_STRING
					else
						last_token := TE_VERBATIM_STRING
						if token_buffer.count > maximum_string_length then
							report_too_long_string (token_buffer)
						end
					end
				else
					append_text_to_string (token_buffer)
					set_start_condition (VERBATIM_STR2)
				end
			}
	[^"\n]*\" {
				append_text_to_string (token_buffer)
				set_start_condition (VERBATIM_STR2)
			}
	[^"\n]*\n {
				append_text_to_string (token_buffer)
				if token_buffer.count > 2 and then token_buffer.item (token_buffer.count - 1) = '%R' then
						-- Remove \r in \r\n.
					token_buffer.remove (token_buffer.count - 1)
				end
			}
	[^"\n]* {
					-- No final bracket-double-quote.
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
				append_text_to_string (token_buffer)
				if token_buffer.count > 2 and then token_buffer.item (token_buffer.count - 1) = '%R' then
						-- Remove \r in \r\n.
					token_buffer.remove (token_buffer.count - 1)
				end
				set_start_condition (VERBATIM_STR1)
			}
	.*		{
					-- No final bracket-double-quote.
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
				string_position := position
				token_buffer.clear_all
				if text_count > 1 then
					append_text_substring_to_string (2, text_count, token_buffer)
				end
				set_start_condition (SPECIAL_STR)
			}
<SPECIAL_STR>{
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
						-- Empty string.
					last_token := TE_EMPTY_STRING
				else
					last_token := TE_STRING
					if token_buffer.count > maximum_string_length then
						report_too_long_string (token_buffer)
					end
				end
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
