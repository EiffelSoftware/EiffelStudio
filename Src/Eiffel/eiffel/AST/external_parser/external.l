%{
indexing
	description: "Scanners for external parsers"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class EXTERNAL_SCANNER

inherit

    YY_COMPRESSED_SCANNER_SKELETON
		rename
			make as make_compressed_scanner_skeleton
		redefine
			reset
		end

	EXTERNAL_TOKENS
		export {NONE} all end

create
    make
%}

%option nodefault position outfile="external_scanner.e"

A		([a-z]|[A-Z]|[0-9]|_|&)
X		([a-z]|[A-Z]|[0-9]|_|\+|\.|\]|\[|%,\ |=|&)
N		[0-9]

%%

-- Separators

[ \t\r]+
\n+

-- Symbols

":"			{
				last_token := TE_COLON
			}
"("			{
				last_token := TE_LPARAN
			}
")"			{
				last_token := TE_RPARAN
			}
","			{
				last_token := TE_COMMA
			}
"*"			{
				last_token := TE_STAR
			}
"&"			{
				last_token := TE_ADDRESS
			}
"<"			{
				last_token := TE_LT
			}
">"			{
				last_token := TE_GT
			}				
"\""		{
				last_token := TE_DQUOTE
			}

-- Reserved words
[aA][cC][cC][eE][sS][sS]	{
				last_token := TE_ACCESS
			}
[bB][lL][oO][cC][kK][iI][nN][gG]	{
				last_token := TE_BLOCKING
			}
[bB][uU][iI][lL][tT]_[iI][nN]	{
				last_token := TE_BUILT_IN
			}
[cC]		{
				last_token := TE_C_LANGUAGE
			}
[cC][_][wW][iI][tT][hH][oO][uU][tT][cC][uU][rR][rR][eE][nN][tT]	{
				last_token := TE_C_LANGUAGE
			}
[cC][_][iI][nN][lL][iI][nN][eE][wW][iI][tT][hH][oO][uU][tT][cC][uU][rR][rR][eE][nN][tT]	{
				last_token := TE_C_LANGUAGE
			}
[cC][+][+]	{
				last_token := TE_CPP_LANGUAGE
			}
"const" {
				last_token := TE_CONST
			}
[cC][rR][eE][aA][tT][oO][rR]	{
				last_token := TE_CREATOR
			}
[dD][eE][fF][eE][rR][rR][eE][dD]	{
				last_token := TE_DEFERRED
			}
[dD][eE][lL][eE][tT][eE]	{
				last_token := TE_DELETE
			}
[dD][lL][lL]	{
				last_token := TE_DLL_LANGUAGE
			}
[dD][lL][lL][wW][iI][nN]	{
				last_token := TE_DLLWIN_LANGUAGE
			}
[eE][nN][uU][mM]	{
				last_token := TE_ENUM
			}
[fF][iI][eE][lL][dD]	{
				last_token := TE_FIELD
			}
[gG][eE][tT][_][pP][rR][oO][pP][eE][rR][tT][yY]	{
				last_token := TE_GET_PROPERTY
			}
[iI][lL]	{
				last_token := TE_IL_LANGUAGE
			}
[iI][nN][lL][iI][nN][eE]	{
				last_token := TE_INLINE
			}
[jJ][vV][mM]	{
				last_token := TE_JAVA_LANGUAGE
			}
[mM][aA][cC][rR][oO]	{
				last_token := TE_MACRO
			}
[oO][pP][eE][rR][aA][tT][oO][rR]	{
				last_token := TE_OPERATOR
			}
[sS][eE][tT][_][fF][iI][eE][lL][dD]	{
				last_token := TE_SET_FIELD
			}
[sS][eE][tT][_][pP][rR][oO][pP][eE][rR][tT][yY]	{
				last_token := TE_SET_PROPERTY
			}
[sS][eE][tT][_][sS][tT][aA][tT][iI][cC][_][fF][iI][eE][lL][dD]	{
				last_token := TE_SET_STATIC_FIELD
			}
[sS][iI][gG][nN][aA][tT][uU][rR][eE]	{
				last_token := TE_SIGNATURE
			}
"signed" {
				last_token := TE_SIGNED
			}
[sS][tT][aA][tT][iI][cC]	{
				last_token := TE_STATIC
			}
[sS][tT][aA][tT][iI][cC][_][fF][iI][eE][lL][dD]	{
				last_token := TE_STATIC_FIELD
			}
[sS][tT][rR][uU][cC][tT]	{
				last_token := TE_STRUCT
			}
[tT][yY][pP][eE]	{
				last_token := TE_TYPE
			}
"unsigned" {
				last_token := TE_UNSIGNED
			}
[uU][sS][eE]	{
				last_token := TE_USE
			}

-- Identifiers
[@]{N}*		{
				token_buffer.clear_all
				append_text_to_string (token_buffer)
				token_buffer.remove_head (1)
				last_token := TE_INTEGER
			}

[@]{A}{X}*	{
					-- To escape external keywords.
				token_buffer.clear_all
				append_text_to_string (token_buffer)
				token_buffer.remove_head (1)
				last_token := TE_ID
			}

{A}{X}*		{
					-- Traditional identifier
				token_buffer.clear_all
				append_text_to_string (token_buffer)
				last_token := TE_ID
			}
(("-")|("/")|("\\")|{X})+ {
					-- Special identifier for include files that specifies
					-- a path, e.g. <sys/timeb.h>, <windows\file.h>, or path
					-- that includes an hyphenation.
				token_buffer.clear_all
				append_text_to_string (token_buffer)
				last_token := TE_FILE_ID
			}

.
			
%%

feature {NONE} -- Initialization

	make is
			-- Create a new external scanner.
		do
			make_with_buffer (Empty_buffer)
			create token_buffer.make (Initial_buffer_size)
		end

feature -- Initialization

	reset is
			-- Reset scanner before scanning next input source.
			-- (This routine can be called in wrap before scanning
			-- another input buffer.)
		do
			Precursor
			token_buffer.clear_all
		end

feature -- Access

	token_buffer: STRING
			-- Buffer for lexial tokens

	last_value: ANY
			-- Semantic value to be passed to the parser

feature {NONE} -- Constants

	Initial_buffer_size: INTEGER is 1024 
				-- Initial size for `token_buffer'

invariant
	token_buffer_not_void: token_buffer /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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

end -- class EXTERNAL_SCANNER
