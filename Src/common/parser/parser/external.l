%{
indexing
	description: "Scanners for external parsers"
	status: "See notice at end of class"
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

%option nodefault outfile="external_scanner.e"

A		([a-z]|[A-Z]|[0-9]|_|&)
X		([a-z]|[A-Z]|[0-9]|_|\+|\.|]|[|%,\ |=|&)

%%

-- Separators

[ \t\r]+		current_position.go_to (text_count)
\n+				current_position.go_to (text_count)

-- Symbols

":"			{
				current_position.go_to (1)
				last_token := TE_COLON
			}
"("			{
				current_position.go_to (1)
				last_token := TE_LPARAN
			}
")"			{
				current_position.go_to (1)
				last_token := TE_RPARAN
			}
","			{
				current_position.go_to (1)
				last_token := TE_COMMA
			}
"*"			{
				current_position.go_to (1)
				last_token := TE_STAR
			}
"&"			{
				current_position.go_to (1)
				last_token := TE_ADDRESS
			}
"<"			{
				current_position.go_to (1)
				last_token := TE_LT
			}
">"			{
				current_position.go_to (1)
				last_token := TE_GT
			}				
"\""		{
				current_position.go_to (1)
				last_token := TE_DQUOTE
			}

-- Reserved words
[aA][cC][cC][eE][sS][sS]	{
				current_position.go_to (6)
				last_token := TE_ACCESS
			}
[cC]		{
				current_position.go_to (1)
				last_token := TE_C_LANGUAGE
			}
[cC][_][wW][iI][tT][hH][oO][uU][tT][cC][uU][rR][rR][eE][nN][tT]	{
				current_position.go_to (16)
				last_token := TE_C_LANGUAGE
			}
[cC][_][iI][nN][lL][iI][nN][eE][wW][iI][tT][hH][oO][uU][tT][cC][uU][rR][rR][eE][nN][tT]	{
				current_position.go_to (22)
				last_token := TE_C_LANGUAGE
			}
[cC][+][+]	{
				current_position.go_to (3)
				last_token := TE_CPP_LANGUAGE
			}
[cC][rR][eE][aA][tT][oO][rR]	{
				current_position.go_to (7)
				last_token := TE_CREATOR
			}
[dD][eE][fF][eE][rR][rR][eE][dD]	{
				current_position.go_to (8)
				last_token := TE_DEFERRED
			}
[dD][eE][lL][eE][tT][eE]	{
				current_position.go_to (6)
				last_token := TE_DELETE
			}
[dD][lL][lL]	{
				current_position.go_to (3)
				last_token := TE_DLL_LANGUAGE
			}
[dD][lL][lL][wW][iI][nN]	{
				current_position.go_to (6)
				last_token := TE_DLLWIN_LANGUAGE
			}
[eE][nN][uU][mM]	{
				current_position.go_to (4)
				last_token := TE_ENUM
			}
[fF][iI][eE][lL][dD]	{
				current_position.go_to (5)
				last_token := TE_FIELD
			}
[gG][eE][tT][_][pP][rR][oO][pP][eE][rR][tT][yY]	{
				current_position.go_to (12)
				last_token := TE_GET_PROPERTY
			}
[iI][lL]	{
				current_position.go_to (2)
				last_token := TE_IL_LANGUAGE
			}
[iI][nN][lL][iI][nN][eE]	{
				current_position.go_to (6)
				last_token := TE_INLINE
			}
[jJ][vV][mM]	{
				current_position.go_to (3)
				last_token := TE_JAVA_LANGUAGE
			}
[mM][aA][cC][rR][oO]	{
				current_position.go_to (5)
				last_token := TE_MACRO
			}
[oO][pP][eE][rR][aA][tT][oO][rR]	{
				current_position.go_to (8)
				last_token := TE_OPERATOR
			}
[sS][eE][tT][_][fF][iI][eE][lL][dD]	{
				current_position.go_to (9)
				last_token := TE_SET_FIELD
			}
[sS][eE][tT][_][pP][rR][oO][pP][eE][rR][tT][yY]	{
				current_position.go_to (12)
				last_token := TE_SET_PROPERTY
			}
[sS][eE][tT][_][sS][tT][aA][tT][iI][cC][_][fF][iI][eE][lL][dD]	{
				current_position.go_to (16)
				last_token := TE_SET_STATIC_FIELD
			}
[sS][iI][gG][nN][aA][tT][uU][rR][eE]	{
				current_position.go_to (9)
				last_token := TE_SIGNATURE
			}
[sS][tT][aA][tT][iI][cC]	{
				current_position.go_to (6)
				last_token := TE_STATIC
			}
[sS][tT][aA][tT][iI][cC][_][fF][iI][eE][lL][dD]	{
				current_position.go_to (12)
				last_token := TE_STATIC_FIELD
			}
[sS][tT][rR][uU][cC][tT]	{
				current_position.go_to (6)
				last_token := TE_STRUCT
			}
[tT][yY][pP][eE]	{
				current_position.go_to (4)
				last_token := TE_TYPE
			}
[uU][sS][eE]	{
				current_position.go_to (3)
				last_token := TE_USE
			}

-- Identifiers
{A}{X}*		{
				token_buffer.clear_all
				append_text_to_string (token_buffer)
				current_position.go_to (token_buffer.count)
				last_token := TE_ID
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

end -- class EXTERNAL_SCANNER


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
