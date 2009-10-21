%{
note

	description: "Scanners for Eiffel parsers"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class EIFFEL_SCANNER

inherit
	EIFFEL_SCANNER_SKELETON

	STRING_HANDLER

create
	make

%}

%x SPECIAL_STR VERBATIM_STR1 VERBATIM_STR2 VERBATIM_STR3 PRAGMA
%option line position nodefault outfile="eiffel_scanner.e"

D		[0-9]
I		{D}(({D}|_)*{D})?
H		([0-9]|[A-F]|[a-f])
O		[0-7]
B		[0-1]
E		(((e|E)[+-]?{D}+)?)
A		([a-z]|[A-Z])
X		([a-z]|[A-Z]|[0-9]|_)
T		[0-9][0-9][0-9]
U		([0-9]|[0-9][0-9]|[0-9][0-9][0-9])

%%

-- Breaks

[ \t\r\n]+ { ast_factory.create_break_as (Current)  }

[ \t\r\n]*/"--" {
				last_break_as_start_position := position
				last_break_as_start_line := line
				last_break_as_start_column := column
				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				set_start_condition (PRAGMA)
		}

<PRAGMA> {
	"--#line".*	{
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				last_line_pragma := ast_factory.new_line_pragma (Current)
			}

	"--".*	{
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
			}

	[ \t\r\n]+	{
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
			}

	. {
			less (0)
			ast_factory.create_break_as_with_data (roundtrip_token_buffer,
																last_break_as_start_line,
																last_break_as_start_column,
																last_break_as_start_position,
																roundtrip_token_buffer.count)
			set_start_condition (INITIAL)
		}

	<<EOF>> {
			ast_factory.create_break_as_with_data (roundtrip_token_buffer,
																last_break_as_start_line,
																last_break_as_start_column,
																last_break_as_start_position,
																roundtrip_token_buffer.count)
			set_start_condition (INITIAL)
			}
}

-- Symbols

";"			{
				last_symbol_as_value := ast_factory.new_symbol_as (TE_SEMICOLON, Current)
				last_token := TE_SEMICOLON
			}
":"			{
				last_symbol_as_value := ast_factory.new_symbol_as (TE_COLON, Current)
				last_token := TE_COLON
			}
","			{
				last_symbol_as_value := ast_factory.new_symbol_as (TE_COMMA, Current)
				last_token := TE_COMMA
			}
".."		{
				last_symbol_as_value := ast_factory.new_symbol_as (TE_DOTDOT, Current)
				last_token := TE_DOTDOT
			}
"?"			{
				last_symbol_as_value := ast_factory.new_symbol_as (TE_QUESTION, Current)
				last_token := TE_QUESTION
			}
"~"			{
				last_symbol_as_value := ast_factory.new_symbol_as (TE_TILDE, Current)
				last_token := TE_TILDE
			}
"."			{
				last_symbol_as_value := ast_factory.new_symbol_as (TE_DOT, Current)
				last_token := TE_DOT
			}
"$"			{
				last_symbol_as_value := ast_factory.new_symbol_as (TE_ADDRESS, Current)
				last_token := TE_ADDRESS
			}
":="		{
				last_symbol_as_value := ast_factory.new_symbol_as (TE_ASSIGNMENT, Current)
				last_token := TE_ASSIGNMENT
			}
"?="		{
				last_symbol_as_value := ast_factory.new_symbol_as (TE_ACCEPT, Current)
				last_token := TE_ACCEPT
			}
"="			{
				last_symbol_as_value := ast_factory.new_symbol_as (TE_EQ, Current)
				last_token := TE_EQ
			}
"<"			{
				last_symbol_as_value := ast_factory.new_symbol_as (TE_LT, Current)
				last_token := TE_LT
			}
">"			{
				last_symbol_as_value := ast_factory.new_symbol_as (TE_GT, Current)
				last_token := TE_GT
			}
"<="		{
				last_symbol_as_value := ast_factory.new_symbol_as (TE_LE, Current)
				last_token := TE_LE
			}
">="		{
				last_symbol_as_value := ast_factory.new_symbol_as (TE_GE, Current)
				last_token := TE_GE
			}
"/~"			{
				last_symbol_as_value := ast_factory.new_symbol_as (TE_NOT_TILDE, Current)
				last_token := TE_NOT_TILDE
			}
"/="		{
				last_symbol_as_value := ast_factory.new_symbol_as (TE_NE, Current)
				last_token := TE_NE
			}
"("			{
				last_symbol_as_value := ast_factory.new_symbol_as (TE_LPARAN, Current)
				last_token := TE_LPARAN
			}
")"			{
				last_symbol_as_value := ast_factory.new_symbol_as (TE_RPARAN, Current)
				last_token := TE_RPARAN
			}
"{"			{
				last_symbol_as_value := ast_factory.new_symbol_as (TE_LCURLY, Current)
				last_token := TE_LCURLY
			}
"}"			{
				last_symbol_as_value := ast_factory.new_symbol_as (TE_RCURLY, Current)
				last_token := TE_RCURLY
			}
"["			{
				last_symbol_as_value := ast_factory.new_square_symbol_as (TE_LSQURE, Current)
				last_token := TE_LSQURE
			}
"]"			{
				last_symbol_as_value := ast_factory.new_square_symbol_as (TE_RSQURE, Current)
				last_token := TE_RSQURE
			}
"+"			{
				last_symbol_as_value := ast_factory.new_symbol_as (TE_PLUS, Current)
				last_token := TE_PLUS
			}
"-"			{
				last_symbol_as_value := ast_factory.new_symbol_as (TE_MINUS, Current)
				last_token := TE_MINUS
			}
"*"			{
				last_symbol_as_value := ast_factory.new_symbol_as (TE_STAR, Current)
				last_token := TE_STAR
			}
"/"			{
				last_symbol_as_value := ast_factory.new_symbol_as (TE_SLASH, Current)
				last_token := TE_SLASH
			}
"^"			{
				last_symbol_as_value := ast_factory.new_symbol_as (TE_POWER, Current)
				last_token := TE_POWER
			}
"->"  		{
				last_symbol_as_value := ast_factory.new_symbol_as (TE_CONSTRAIN, Current)
				last_token := TE_CONSTRAIN
			}
"!"			{
				last_symbol_as_value := ast_factory.new_symbol_as (TE_BANG, Current)
				last_token := TE_BANG
			}
"<<"		{
				last_symbol_as_value := ast_factory.new_symbol_as (TE_LARRAY, Current)
				last_token := TE_LARRAY
			}
">>"		{
				last_symbol_as_value := ast_factory.new_symbol_as (TE_RARRAY, Current)
				last_token := TE_RARRAY
			}
"//"		{
				last_symbol_as_value := ast_factory.new_symbol_as (TE_DIV, Current)
				last_token := TE_DIV
			}
"\\\\"		{
				last_symbol_as_value := ast_factory.new_symbol_as (TE_MOD, Current)
				last_token := TE_MOD
			}


-- Free operators

(@|#|\||&)[@#0-9a-zA-Z_!\$&\'\(\)\*\+\,\-\./:;<>=\?\[\\\]\^\`\{\}\|\~]* {
				last_token := TE_FREE
				process_id_as
			}


-- Reserved words

[aA][cC][rR][oO][sS][sS] {
				if syntax_version = provisional_syntax then
					last_keyword_as_value := ast_factory.new_keyword_as (TE_ACROSS, Current)
					last_token := TE_ACROSS
				else
					process_id_as
					last_token := TE_ID
					if has_syntax_warning then
						report_one_warning (
							create {SYNTAX_WARNING}.make (line, column, filename,
								once "Provisional keyword `across' is used as identifier."))
					end
				end
			}
[aA][gG][eE][nN][tT]	{
				last_keyword_as_value := ast_factory.new_keyword_as (TE_AGENT, Current)
				last_token := TE_AGENT
			}
[aA][lL][iI][aA][sS]	{
				last_keyword_as_value := ast_factory.new_keyword_as (TE_ALIAS, Current)
				last_token := TE_ALIAS
			}
[aA][lL][lL]	{
				last_keyword_as_value := ast_factory.new_keyword_as (TE_ALL, Current)
				last_token := TE_ALL
			}
[aA][nN][dD]	{
				last_keyword_as_value := ast_factory.new_keyword_as (TE_AND, Current)
				last_token := TE_AND
			}
[aA][sS]	{
				last_keyword_as_value := ast_factory.new_keyword_as (TE_AS, Current)
				last_token := TE_AS
			}
[aA][sS][sS][iI][gG][nN] {
				last_keyword_id_value := ast_factory.new_keyword_id_as (TE_ASSIGN, Current)
				last_token := TE_ASSIGN
			}
[aA][tT][tT][aA][cC][hH][eE][dD] {
				if syntax_version /= obsolete_64_syntax then
					last_keyword_id_value := ast_factory.new_keyword_id_as (TE_ATTACHED, Current)
					last_token := TE_ATTACHED
				else
					process_id_as
					last_token := TE_ID
					if has_syntax_warning then
						report_one_warning (
							create {SYNTAX_WARNING}.make (line, column, filename,
								once "Keyword `attached' is used as identifier."))
					end
				end
			}
[aA][tT][tT][rR][iI][bB][uU][tT][eE] {
				if syntax_version /= obsolete_64_syntax then
					last_keyword_id_value := ast_factory.new_keyword_id_as (TE_ATTRIBUTE, Current)
					last_token := TE_ATTRIBUTE
				else
					process_id_as
					last_token := TE_ID
					if has_syntax_warning then
						report_one_warning (
							create {SYNTAX_WARNING}.make (line, column, filename,
								once "Keyword `attribute' is used as identifier."))
					end
				end
			}
[bB][iI][tT]	{
				last_keyword_as_value := ast_factory.new_keyword_as (TE_BIT, Current)
				last_token := TE_BIT
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (line, column, filename,
							once "The `bit' keyword will be removed in the future according to ECMA Eiffel and should not be used."))
				end
			}
[cC][hH][eE][cC][kK]	{
				last_keyword_as_value := ast_factory.new_keyword_as (TE_CHECK, Current)
				last_token := TE_CHECK
			}
[cC][lL][aA][sS][sS]	{
				last_keyword_as_value := ast_factory.new_keyword_as (TE_CLASS, Current)
				last_token := TE_CLASS
			}
[cC][oO][nN][vV][eE][rR][tT]	{
				last_keyword_as_value := ast_factory.new_keyword_as (TE_CONVERT, Current)
				last_token := TE_CONVERT
			}
[cC][rR][eE][aA][tT][eE]	{
				last_keyword_as_value := ast_factory.new_keyword_as (TE_CREATE, Current)
				last_token := TE_CREATE
			}
[cC][rR][eE][aA][tT][iI][oO][nN]	{
				last_keyword_as_value := ast_factory.new_creation_keyword_as (Current)
				last_token := TE_CREATION
			}
[cC][uU][rR][rR][eE][nN][tT]	{
				last_current_as_value := ast_factory.new_current_as (Current)
				last_token := TE_CURRENT
			}
[dD][eE][bB][uU][gG]	{
				last_keyword_as_value := ast_factory.new_keyword_as (TE_DEBUG, Current)
				last_token := TE_DEBUG
			}
[dD][eE][fF][eE][rR][rR][eE][dD]	{
				last_deferred_as_value := ast_factory.new_deferred_as (Current)
				last_token := TE_DEFERRED
			}
[dD][eE][tT][aA][cC][hH][aA][bB][lL][eE]	{
				if syntax_version /= obsolete_64_syntax then
					last_keyword_id_value := ast_factory.new_keyword_id_as (TE_DETACHABLE, Current)
					last_token := TE_DETACHABLE
				else
					process_id_as
					last_token := TE_ID
					if has_syntax_warning then
						report_one_warning (
							create {SYNTAX_WARNING}.make (line, column, filename,
								once "Keyword `detachable' is used as identifier."))
					end
				end
			}
[dD][oO]	{
				last_keyword_as_value := ast_factory.new_keyword_as (TE_DO, Current)
				last_token := TE_DO
			}
[eE][lL][sS][eE]	{
				last_keyword_as_value := ast_factory.new_keyword_as (TE_ELSE, Current)
				last_token := TE_ELSE
			}
[eE][lL][sS][eE][iI][fF]	{
				last_keyword_as_value := ast_factory.new_keyword_as (TE_ELSEIF, Current)
				last_token := TE_ELSEIF
			}
[eE][nN][dD]	{
				last_keyword_as_value := ast_factory.new_end_keyword_as (Current)
				last_token := TE_END
			}
[eE][nN][sS][uU][rR][eE]	{
				last_keyword_as_value := ast_factory.new_keyword_as (TE_ENSURE, Current)
				last_token := TE_ENSURE
			}
[eE][xX][pP][aA][nN][dD][eE][dD]	{
				last_keyword_as_value := ast_factory.new_keyword_as (TE_EXPANDED, Current)
				last_token := TE_EXPANDED
			}
[eE][xX][pP][oO][rR][tT]	{
				last_keyword_as_value := ast_factory.new_keyword_as (TE_EXPORT, Current)
				last_token := TE_EXPORT
			}
[eE][xX][tT][eE][rR][nN][aA][lL]	{
				last_keyword_as_value := ast_factory.new_keyword_as (TE_EXTERNAL, Current)
				last_token := TE_EXTERNAL
			}
[fF][aA][lL][sS][eE]	{
				last_bool_as_value := ast_factory.new_boolean_as (False, Current)
				last_token := TE_FALSE
			}
[fF][eE][aA][tT][uU][rR][eE]	{
				last_keyword_as_value := ast_factory.new_keyword_as (TE_FEATURE, Current)
				last_token := TE_FEATURE
			}
[fF][rR][oO][mM]	{
				last_keyword_as_value := ast_factory.new_keyword_as (TE_FROM, Current)
				last_token := TE_FROM
			}
[fF][rR][oO][zZ][eE][nN]	{
				last_keyword_as_value := ast_factory.new_frozen_keyword_as (Current)
				last_token := TE_FROZEN
			}
[iI][fF]	{
				last_keyword_as_value := ast_factory.new_keyword_as (TE_IF, Current)
				last_token := TE_IF
			}
[iI][mM][pP][lL][iI][eE][sS]	{
				last_keyword_as_value := ast_factory.new_keyword_as (TE_IMPLIES, Current)
				last_token := TE_IMPLIES
			}
[iI][nN][dD][eE][xX][iI][nN][gG]	{
				if syntax_version /= ecma_syntax then
					last_keyword_as_value := ast_factory.new_keyword_as (TE_INDEXING, Current)
					last_token := TE_INDEXING
				else
					process_id_as
					last_token := TE_ID
				end
			}
[iI][nN][fF][iI][xX]	{
				last_keyword_as_value := ast_factory.new_infix_keyword_as (Current)
				last_token := TE_INFIX
			}
[iI][nN][hH][eE][rR][iI][tT]	{
				last_keyword_as_value := ast_factory.new_keyword_as (TE_INHERIT, Current)
				last_token := TE_INHERIT
			}
[iI][nN][sS][pP][eE][cC][tT]	{
				last_keyword_as_value := ast_factory.new_keyword_as (TE_INSPECT, Current)
				last_token := TE_INSPECT
			}
[iI][nN][vV][aA][rR][iI][aA][nN][tT]	{
				last_keyword_as_value := ast_factory.new_keyword_as (TE_INVARIANT, Current)
				last_token := TE_INVARIANT
			}
[iI][sS]	{
				last_keyword_as_value := ast_factory.new_keyword_as (TE_IS, Current)
				last_token := TE_IS
			}
[lL][iI][kK][eE]	{
				last_keyword_as_value := ast_factory.new_keyword_as (TE_LIKE, Current)
				last_token := TE_LIKE
			}
[lL][oO][cC][aA][lL]	{
				last_keyword_as_value := ast_factory.new_keyword_as (TE_LOCAL, Current)
				last_token := TE_LOCAL
			}
[lL][oO][oO][pP]	{
				last_keyword_as_value := ast_factory.new_keyword_as (TE_LOOP, Current)
				last_token := TE_LOOP
			}
[nN][oO][tT]	{
				last_keyword_as_value := ast_factory.new_keyword_as (TE_NOT, Current)
				last_token := TE_NOT
			}
[nN][oO][tT][eE]	{
				if syntax_version /= obsolete_64_syntax then
					last_keyword_as_value := ast_factory.new_keyword_as (TE_NOTE, Current)
					last_token := TE_NOTE
				else
					process_id_as
					last_token := TE_ID
					if has_syntax_warning then
						report_one_warning (
							create {SYNTAX_WARNING}.make (line, column, filename,
								once "Keyword `note' is used as identifier."))
					end
				end
			}
[oO][bB][sS][oO][lL][eE][tT][eE]	{
				last_keyword_as_value := ast_factory.new_keyword_as (TE_OBSOLETE, Current)
				last_token := TE_OBSOLETE
			}
[oO][lL][dD]	{
				last_keyword_as_value := ast_factory.new_keyword_as (TE_OLD, Current)
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
				last_keyword_as_value := ast_factory.new_once_string_keyword_as (text,  line, column, position, 4)
				last_token := TE_ONCE_STRING
			}
[oO][nN][cC][eE]([ \t\r\n]|"--".*\n)+/\"	{
				last_keyword_as_value := ast_factory.new_once_string_keyword_as (text_substring (1, 4),  line, column, position, 4)
					-- Assume all trailing characters are in the same line (which would be false if '\n' appears).
				ast_factory.create_break_as_with_data (text_substring (5, text_count), line, column + 4, position + 4, text_count - 4)
				last_token := TE_ONCE_STRING
			}

[oO][nN][cC][eE]	{
				last_keyword_as_value := ast_factory.new_keyword_as (TE_ONCE, Current)
				last_token := TE_ONCE
			}
[oO][nN][lL][yY]	{
				last_token := TE_ID
				process_id_as
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (line, column, filename,
							once "Use of `only', possibly a new keyword in future definition of `Eiffel'."))
				end
			}
[oO][rR]	{
				last_keyword_as_value := ast_factory.new_keyword_as (TE_OR, Current)
				last_token := TE_OR
			}
[pP][aA][rR][tT][iI][aA][lL][ \t\r\n]*[cC][lL][aA][sS][sS] {
				last_keyword_as_value := ast_factory.new_keyword_as (TE_PARTIAL_CLASS, Current)
				last_token := TE_PARTIAL_CLASS
			}
[pP][rR][eE][cC][uU][rR][sS][oO][rR]	{
				last_keyword_as_value := ast_factory.new_precursor_keyword_as (Current)
				last_token := TE_PRECURSOR
			}
[pP][rR][eE][fF][iI][xX]	{
				last_keyword_as_value := ast_factory.new_prefix_keyword_as (Current)
				last_token := TE_PREFIX
			}
[rR][eE][dD][eE][fF][iI][nN][eE]	{
				last_keyword_as_value := ast_factory.new_keyword_as (TE_REDEFINE, Current)
				last_token := TE_REDEFINE
			}
[rR][eE][fF][eE][rR][eE][nN][cC][eE] {
				last_keyword_as_value := ast_factory.new_keyword_as (TE_REFERENCE, Current)
				last_token := TE_REFERENCE
			}
[rR][eE][nN][aA][mM][eE]	{
				last_keyword_as_value := ast_factory.new_keyword_as (TE_RENAME, Current)
				last_token := TE_RENAME
			}
[rR][eE][qQ][uU][iI][rR][eE]	{
				last_keyword_as_value := ast_factory.new_keyword_as (TE_REQUIRE, Current)
				last_token := TE_REQUIRE
			}
[rR][eE][sS][cC][uU][eE]	{
				last_keyword_as_value := ast_factory.new_keyword_as (TE_RESCUE, Current)
				last_token := TE_RESCUE
			}
[rR][eE][sS][uU][lL][tT]	{
				last_result_as_value := ast_factory.new_result_as (Current)
				last_token := TE_RESULT
			}
[rR][eE][tT][rR][yY]	{
				last_retry_as_value := ast_factory.new_retry_as (Current)
				last_token := TE_RETRY
			}
[sS][eE][lL][eE][cC][tT]	{
				last_keyword_as_value := ast_factory.new_keyword_as (TE_SELECT, Current)
				last_token := TE_SELECT
			}
[sS][eE][pP][aA][rR][aA][tT][eE]	{
				last_keyword_as_value := ast_factory.new_keyword_as (TE_SEPARATE, Current)
				last_token := TE_SEPARATE
			}
[sS][oO][mM][eE] {
				if syntax_version = provisional_syntax then
					last_keyword_as_value := ast_factory.new_keyword_as (TE_SOME, Current)
					last_token := TE_SOME
				else
					process_id_as
					last_token := TE_ID
					if has_syntax_warning then
						report_one_warning (
							create {SYNTAX_WARNING}.make (line, column, filename,
								once "Provisional keyword `some' is used as identifier."))
					end
				end
			}
[sS][tT][rR][iI][pP]	{
				last_keyword_as_value := ast_factory.new_keyword_as (TE_STRIP, Current)
				last_token := TE_STRIP
			}
[tT][hH][eE][nN]	{
				last_keyword_as_value := ast_factory.new_keyword_as (TE_THEN, Current)
				last_token := TE_THEN
			}
[tT][rR][uU][eE]	{
				last_bool_as_value := ast_factory.new_boolean_as (True, Current)
				last_token := TE_TRUE
			}
[tT][uU][pP][lL][eE] {
				last_token := TE_TUPLE
				process_id_as
			}
[uU][nN][dD][eE][fF][iI][nN][eE]	{
				last_keyword_as_value := ast_factory.new_keyword_as (TE_UNDEFINE, Current)
				last_token := TE_UNDEFINE
			}
[uU][nN][iI][qQ][uU][eE]	{
				last_unique_as_value := ast_factory.new_unique_as (Current)
				last_token := TE_UNIQUE
			}
[uU][nN][tT][iI][lL]	{
				last_keyword_as_value := ast_factory.new_keyword_as (TE_UNTIL, Current)
				last_token := TE_UNTIL
			}
[vV][aA][rR][iI][aA][nN][tT]	{
				last_keyword_as_value := ast_factory.new_keyword_as (TE_VARIANT, Current)
				last_token := TE_VARIANT
			}
[vV][oO][iI][dD] {
				last_void_as_value := ast_factory.new_void_as (Current)
				last_token := TE_VOID
			}
[wW][hH][eE][nN]	{
				last_keyword_as_value := ast_factory.new_keyword_as (TE_WHEN, Current)
				last_token := TE_WHEN
			}
[xX][oO][rR]	{
				last_keyword_as_value := ast_factory.new_keyword_as (TE_XOR, Current)
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
				last_id_as_value := ast_factory.new_filled_bit_id_as (Current)

				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (line, column, filename,
							once "Use of bit syntax will be removed in the future according to ECMA Eiffel and should not be used."))
				end
			}


-- Integers

{I}		|
{I}/".."	{		-- This a trick to avoid having:
					--     when 1..2 then
					-- to be be erroneously recognized as:
					--     `when' `1.' `.2' `then'
					-- instead of:
					--     `when' `1' `..' `2' `then'

				token_buffer.wipe_out
				append_text_to_string (token_buffer)
				last_token := TE_INTEGER
			}

0[xX]{H}(({H}|_)*{H})?	{		-- Recognizes hexadecimal integer numbers.
				token_buffer.wipe_out
				append_text_to_string (token_buffer)
				last_token := TE_INTEGER
			}

0[cC]{O}(({O}|_)*{O})?	{		-- Recognizes octal integer numbers.
				token_buffer.wipe_out
				append_text_to_string (token_buffer)
				last_token := TE_INTEGER
			}

0[bB]{B}(({B}|_)*{B})?	{		-- Recognizes binary integer numbers.
				token_buffer.wipe_out
				append_text_to_string (token_buffer)
				last_token := TE_INTEGER
			}

0[bBcC]{H}(({H}|_)*{H})?	{		-- Recognizes erronous binary and octal numbers.
				report_invalid_integer_error (token_buffer)
			}


-- Reals

({D}*\.{D}+{E})|({D}+\.{D}*{E})|(({U}(_{T})*)?\.({T}_)*{U}{E})|({U}(_{T})*\.(({T}_)*{U})?{E}) {
				token_buffer.wipe_out
				append_text_to_string (token_buffer)
				token_buffer.to_lower
				last_token := TE_REAL
			}


-- Characters

\'[^%\n']\'	{
				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_char_as_value := ast_factory.new_character_as (text_item (2), line, column, position, text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			}
\'\'\'		{
					-- This is not correct Eiffel!
				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_char_as_value := ast_factory.new_character_as ('%'', line, column, position, text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			}
\'%A\'		{
				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_char_as_value := ast_factory.new_character_as ('%A', line, column, position, text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			}
\'%B\'		{
				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_char_as_value := ast_factory.new_character_as ('%B', line, column, position, text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			}
\'%C\'		{
				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_char_as_value := ast_factory.new_character_as ('%C', line, column, position, text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			}
\'%D\'		{
				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_char_as_value := ast_factory.new_character_as ('%D', line, column, position, text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			}
\'%F\'		{
				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_char_as_value := ast_factory.new_character_as ('%F', line, column, position, text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			}
\'%H\'		{
				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_char_as_value := ast_factory.new_character_as ('%H', line, column, position, text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			}
\'%L\'		{
				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_char_as_value := ast_factory.new_character_as ('%L', line, column, position, text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			}
\'%N\'		{
				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_char_as_value := ast_factory.new_character_as ('%N', line, column, position, text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			}
\'%Q\'		{
				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_char_as_value := ast_factory.new_character_as ('%Q', line, column, position, text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			}
\'%R\'		{
				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_char_as_value := ast_factory.new_character_as ('%R', line, column, position, text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			}
\'%S\'		{
				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_char_as_value := ast_factory.new_character_as ('%S', line, column, position, text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			}
\'%T\'		{
				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_char_as_value := ast_factory.new_character_as ('%T', line, column, position, text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			}
\'%U\'		{
				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_char_as_value := ast_factory.new_character_as ('%U', line, column, position, text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			}
\'%V\'		{
				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_char_as_value := ast_factory.new_character_as ('%V', line, column, position, text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			}
\'%%\'		{
				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_char_as_value := ast_factory.new_character_as ('%%', line, column, position, text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			}
\'%\'\'		{
				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_char_as_value := ast_factory.new_character_as ('%'', line, column, position, text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			}
\'%\"\'		{
				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_char_as_value := ast_factory.new_character_as ('%"', line, column, position, text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			}
\'%\(\'		{
				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_char_as_value := ast_factory.new_character_as ('%(', line, column, position, text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			}
\'%\)\'		{
				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_char_as_value := ast_factory.new_character_as ('%)', line, column, position, text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			}
\'%<\'		{
				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_char_as_value := ast_factory.new_character_as ('%<', line, column, position, text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			}
\'%>\'		{
				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				last_char_as_value := ast_factory.new_character_as ('%>', line, column, position, text_count, roundtrip_token_buffer)
				last_token := TE_CHAR
			}
\'%\/[0-9]+\/\'	|
\'%\/0[xX]{H}(({H}|_)*{H})?\/\' |
\'%\/0[cC]{O}(({O}|_)*{O})?\/\' |
\'%\/0[bB]{B}(({B}|_)*{B})?\/\' {
				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				token_buffer.wipe_out
					-- We discard the '%/ and the final /'.
				append_text_substring_to_string (4, text_count - 2, token_buffer)
				last_char_as_value := ast_factory.new_character_value_as (Current, token_buffer, roundtrip_token_buffer)
				last_token := TE_CHAR
			}

\'%\/0[bBcC]{H}(({H}|_)*{H})?\/\'	{
				report_invalid_integer_error (token_buffer)
			}


\'.{0,2}			|
\'%\/[0-9]+(\/)?	{
					-- Unrecognized character.
					-- (catch-all rules (no backing up))
				report_character_missing_quote_error (text)
			}


-- Strings

\""<"\"		{
				process_simple_string_as (TE_STR_LT)
			}
\"">"\"		{
				process_simple_string_as (TE_STR_GT)
			}
\""<="\"	{
				process_simple_string_as (TE_STR_LE)
			}
\"">="\"	{
				process_simple_string_as (TE_STR_GE)
			}
\""+"\"		{
				process_simple_string_as (TE_STR_PLUS)
			}
\""-"\"		{
				process_simple_string_as (TE_STR_MINUS)
			}
\""*"\"		{
				process_simple_string_as (TE_STR_STAR)
			}
\""/"\"		{
				process_simple_string_as (TE_STR_SLASH)
			}
\""^"\"		{
				process_simple_string_as (TE_STR_POWER)
			}
\""//"\"	{
				process_simple_string_as (TE_STR_DIV)
			}
\""\\\\"\"	{
				process_simple_string_as (TE_STR_MOD)
			}
\""[]"\"	{
				process_simple_string_as (TE_STR_BRACKET)
			}
\"[aA][nN][dD]\"	{
				process_simple_string_as (TE_STR_AND)
			}
\"[aA][nN][dD]\ [tT][hH][eE][nN]\"	{
				process_simple_string_as (TE_STR_AND_THEN)
			}
\"[iI][mM][pP][lL][iI][eE][sS]\"	{
				process_simple_string_as (TE_STR_IMPLIES)
			}
\"[nN][oO][tT]\"	{
				process_simple_string_as (TE_STR_NOT)
			}
\"[oO][rR]\"	{
				process_simple_string_as (TE_STR_OR)
			}
\"[oO][rR]\ [eE][lL][sS][eE]\"	{
				process_simple_string_as (TE_STR_OR_ELSE)
			}
\"[xX][oO][rR]\"	{
				process_simple_string_as (TE_STR_XOR)
			}
\"(@|#|\||&)[@#0-9a-zA-Z_!\$&\'\(\)\*\+\,\-\./:;<>=\?\[\\\]\^\`\{\}\|\~]*\"	{
				process_simple_string_as (TE_STR_FREE)
			}
\"\"		{
				process_simple_string_as (TE_EMPTY_STRING)
			}
\"[^%\n"]+\" {
					-- Regular string.
				process_simple_string_as (TE_STRING)
			}
\"[^\n"]*[\[\{]/[ \t\r]*\n {
					-- Verbatim string.
				token_buffer.wipe_out
				verbatim_marker.wipe_out
				if text_item (text_count) = '[' then
					verbatim_marker.append_character (']')
				else
					verbatim_marker.append_character ('}')
				end
				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				append_text_substring_to_string (2, text_count - 1, verbatim_marker)
				start_location.set_position (line, column, position, text_count)
				set_start_condition (VERBATIM_STR3)
			}
<VERBATIM_STR3>{
		-- Discard space characters at the
		-- end of Verbatim_string_opener.
	[ \t\r]*\n {
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				set_start_condition (VERBATIM_STR1)
			}
	.		{
					-- No final bracket-double-quote.
				append_text_to_string (token_buffer)
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
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
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
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
						token_buffer.wipe_out
					end
					if verbatim_marker.item (1) = ']' then
						align_left (token_buffer)
					else
						verbatim_common_columns := 0
					end
					if token_buffer.is_empty then
							-- Empty string.
						last_string_as_value := ast_factory.new_verbatim_string_as ("",
							verbatim_marker.substring (2, verbatim_marker.count), verbatim_marker.item (1) = ']',
							start_location.line, start_location.column, start_location.position,
							position + text_count - start_location.position, verbatim_common_columns, roundtrip_token_buffer)
						last_token := TE_EMPTY_VERBATIM_STRING
					else
						last_string_as_value := ast_factory.new_verbatim_string_as (cloned_string (token_buffer),
							verbatim_marker.substring (2, verbatim_marker.count), verbatim_marker.item (1) = ']',
							start_location.line, start_location.column, start_location.position,
							position + text_count - start_location.position, verbatim_common_columns, roundtrip_token_buffer)
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
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				append_text_to_string (token_buffer)
				set_start_condition (VERBATIM_STR2)
			}
	[^"\n]*\n {
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				append_text_to_string (token_buffer)
				if token_buffer.count > 2 and then token_buffer.item (token_buffer.count - 1) = '%R' then
						-- Remove \r in \r\n.
					token_buffer.remove (token_buffer.count - 1)
				end
			}
	[^"\n]* {
					-- No final bracket-double-quote.
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
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
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				append_text_to_string (token_buffer)
				if token_buffer.count > 2 and then token_buffer.item (token_buffer.count - 1) = '%R' then
						-- Remove \r in \r\n.
					token_buffer.remove (token_buffer.count - 1)
				end
				set_start_condition (VERBATIM_STR1)
			}
	.*		{
					-- No final bracket-double-quote.
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
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
				ast_factory.set_buffer (roundtrip_token_buffer, Current)
				token_buffer.wipe_out
				if text_count > 1 then
					append_text_substring_to_string (2, text_count, token_buffer)
				end
				start_location.set_position (line, column, position, text_count)
				set_start_condition (SPECIAL_STR)
			}
<SPECIAL_STR>{
	[^%\n"]+	{
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				append_text_to_string (token_buffer)
			}
	%A		{
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'A')
				token_buffer.append_character ('%A')
			}
	%B		{
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'B')
				token_buffer.append_character ('%B')
			}
	%C		{
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'C')
				token_buffer.append_character ('%C')
			}
	%D		{
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'D')
				token_buffer.append_character ('%D')
			}
	%F		{
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'F')
				token_buffer.append_character ('%F')
			}
	%H		{
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'H')
				token_buffer.append_character ('%H')
			}
	%L		{
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'L')
				token_buffer.append_character ('%L')
			}
	%N		{
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'N')
				token_buffer.append_character ('%N')
			}
	%Q		{
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'Q')
				token_buffer.append_character ('%Q')
			}
	%R		{
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'R')
				token_buffer.append_character ('%R')
			}
	%S		{
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'S')
				token_buffer.append_character ('%S')
			}
	%T		{
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'T')
				token_buffer.append_character ('%T')
			}
	%U		{
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'U')
				token_buffer.append_character ('%U')
			}
	%V		{
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', 'V')
				token_buffer.append_character ('%V')
			}
	%%		{
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '%%')
				token_buffer.append_character ('%%')
			}
	%\'		{
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '%'')
				token_buffer.append_character ('%'')
			}
	%\"		{
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '%"')
				token_buffer.append_character ('%"')
			}
	%\(		{
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '(')
				token_buffer.append_character ('%(')
			}
	%\)		{
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', ')')
				token_buffer.append_character ('%)')
			}
	%<		{
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '<')
				token_buffer.append_character ('%<')
			}
	%>		{
				ast_factory.append_two_characters_to_buffer (roundtrip_token_buffer, '%%', '>')
				token_buffer.append_character ('%>')
			}
	%\/[0-9]{1,3}\/	{
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				process_string_character_code (text_substring (3, text_count - 1).to_integer)
			}
	%[ \t\r\n]+%	{
					-- This regular expression should actually be: %\n[ \t\r]*%
					-- Left as-is for compatibility with previous releases.
			ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
			}
	[^%\n"]*\"	{
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
				if text_count > 1 then
					append_text_substring_to_string (1, text_count - 1, token_buffer)
				end
				set_start_condition (INITIAL)
				if token_buffer.is_empty then
						-- Empty string.
					last_string_as_value := ast_factory.new_string_as (
						cloned_string (token_buffer), start_location.line, start_location.column,
						start_location.position,
						position + text_count - start_location.position, roundtrip_token_buffer)
					last_token := TE_EMPTY_STRING
				else
					last_string_as_value := ast_factory.new_string_as (
						cloned_string (token_buffer), start_location.line, start_location.column,
						start_location.position,
						position + text_count - start_location.position, roundtrip_token_buffer)
					last_token := TE_STRING
					if token_buffer.count > maximum_string_length then
						report_too_long_string (token_buffer)
					end
				end
			}
	%		{
					-- Bad special character.
				ast_factory.append_text_to_buffer (roundtrip_token_buffer, Current)
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

note
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EIFFEL_SCANNER
