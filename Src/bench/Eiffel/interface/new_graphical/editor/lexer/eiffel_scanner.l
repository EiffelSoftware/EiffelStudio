%{
indexing

	description:

		"Scanners for Eiffel parsers"

	author:     "Eric Bezault <ericb@gobo.demon.co.uk>"
	copyright:  "Copyright (c) 1998, Eric Bezault"
	date:       "$Date$"
	revision:   "$Revision$"

class EIFFEL_SCANNER

inherit

	YY_COMPRESSED_SCANNER_SKELETON
		rename
			make as make_compressed_scanner_skeleton,
			reset as reset_compressed_scanner_skeleton
		end

	EIFFEL_TOKENS
		export
			{NONE} all
		end

	UT_CHARACTER_CODES
		export
			{NONE} all
		end

	KL_IMPORTED_INTEGER_ROUTINES
	KL_IMPORTED_STRING_ROUTINES
	KL_SHARED_PLATFORM
	KL_SHARED_EXCEPTIONS
	KL_SHARED_ARGUMENTS

creation
	make

%}

%option outfile="eiffel_scanner.e"

%%

----------/** Separators **/----------------------------------------------------

[\r]+				-- Ignore carriage return
[ ]+				{
					create {EDITOR_TOKEN_SPACE} curr_token.make(text_count)
					analysed_tokens.extend(curr_token)
					}
[\t]+				{
					create {EDITOR_TOKEN_TABULATION} curr_token.make(text_count)
					analysed_tokens.extend(curr_token)
					}
\n+					-- Do nothing. It's an error since we are only analysing lines


----------/** Eiffel comments **/-----------------------------------------------

"--".*				{ 
						-- comments
					create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					analysed_tokens.extend(curr_token)
					}

----------/** Eiffel symbols **/------------------------------------------------

"."					|
";"					|
","					|
":"					|
"!"					|
"("					|
")"					|
"{"					|
"}"					|
"["					|
"]"					|
"$"					{
						-- Symbols
					create {EDITOR_TOKEN_TEXT} curr_token.make(text)
					analysed_tokens.extend(curr_token)
					}

"//"|"\\\\"|"/="|">="|"<="|"->"|".."|"<<"|">>"|"?="|":="|"-"|"+"|"*"|"/"|"^"|"="|">"|"<"	{ 
						-- Operator Symbol 
					create {EDITOR_TOKEN_OPERATOR} curr_token.make(text)
					analysed_tokens.extend(curr_token)
					}

----------/** Reserved words **/------------------------------------------------

"!!"									|
[cC][rR][eE][aA][tT][iI][oO][nN]		|
[cC][rR][eE][aA][tT][eE]				{
										-- Create/Creation keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										analysed_tokens.extend(curr_token)
										}

[aA][lL][iI][aA][sS]					|
[aA][lL][lL]|[aA][nN][dD]				|
[aA][sS]|[bB][iI][tT]					|
[cC][hH][eE][cC][kK]					|
[cC][lL][aA][sS][sS]					|
[cC][uU][rR][rR][eE][nN][tT]			|
[dD][eE][bB][uU][gG]					|
[dD][eE][fF][eE][rR][rR][eE][dD]		|
[dD][oO]								|
[eE][lL][sS][eE]						|
[eE][lL][sS][eE][iI][fF]				|
[eE][nN][dD]							|
[eE][nN][sS][uU][rR][eE]				|
[eE][xX][pP][aA][nN][dD][eE][dD]		|
[eE][xX][pP][oO][rR][tT]				|
[eE][xX][tT][eE][rR][nN][aA][lL]		|
[fF][aA][lL][sS][eE]					|
[fF][eE][aA][tT][uU][rR][eE]			|
[fF][rR][oO][mM]						|
[fF][rR][oO][zZ][eE][nN]				|
[iI][fF]								|
[iI][mM][pP][lL][iI][eE][sS]			|
[iI][nN][dD][eE][xX][iI][nN][gG]		{
										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										analysed_tokens.extend(curr_token)
										}
						
[iI][nN][fF][iI][xX]					{
										is_operator := True
										-- infix Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										analysed_tokens.extend(curr_token)
										}
[iI][nN][hH][eE][rR][iI][tT]			|
[iI][nN][sS][pP][eE][cC][tT]			|
[iI][nN][vV][aA][rR][iI][aA][nN][tT]	|
[iI][sS]								|
[lL][iI][kK][eE]						|
[lL][oO][cC][aA][lL]					|
[lL][oO][oO][pP]						|
[nN][oO][tT]							|
[oO][bB][sS][oO][lL][eE][tT][eE]		|
[oO][lL][dD]							|
[oO][nN][cC][eE]						|
[oO][rR]								|
[pP][rR][eE][cC][uU][rR][sS][oO][rR]	{
										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										analysed_tokens.extend(curr_token)
										}

[pP][rR][eE][fF][iI][xX]				{
										is_operator := True
										-- Prefix Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										analysed_tokens.extend(curr_token)
										}
[rR][eE][dD][eE][fF][iI][nN][eE]		|
[rR][eE][nN][aA][mM][eE]				|
[rR][eE][qQ][uU][iI][rR][eE]			|
[rR][eE][sS][cC][uU][eE]				|
[rR][eE][sS][uU][lL][tT]				|
[rR][eE][tT][rR][yY]					|
[sS][eE][lL][eE][cC][tT]				|
[sS][eE][pP][aA][rR][aA][tT][eE]		|
[sS][tT][rR][iI][pP]					|
[tT][hH][eE][nN]						|
[tT][rR][uU][eE]						|
[uU][nN][dD][eE][fF][iI][nN][eE]		|
[uU][nN][iI][qQ][uU][eE]				|
[uU][nN][tT][iI][lL]					|
[vV][aA][rR][iI][aA][nN][tT]			|
[wW][hH][eE][nN]						|
[xX][oO][rR]							{
										-- Keyword
										create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										analysed_tokens.extend(curr_token)
										}


----------/** Eiffel identifiers **/--------------------------------------------

[a-zA-Z][a-zA-Z0-9_]*					{
										create {EDITOR_TOKEN_TEXT} curr_token.make(text)
										analysed_tokens.extend(curr_token)
										}


----------/** Eiffel free operators **/-----------------------------------------

[@#|&][^%" \t\r\n]*						{
										create {EDITOR_TOKEN_TEXT} curr_token.make(text)
										analysed_tokens.extend(curr_token)
										}
	-- Note: Accepts non-printable characters as well,
	-- provided that they are not break characters.


----------/** Eiffel characters **/---------------------------------------------

\'[^%\n']\'			|
\'%A\'				|
\'%B\'				|
\'%C\'				|
\'%D\'				|
\'%F\'				|
\'%H\'				|
\'%L\'				|
\'%N\'				|
\'%Q\'				|
\'%R\'				|
\'%S\'				|
\'%T\'				|
\'%U\'				|
\'%V\'				|
\'%%\'				|
\'%\'\'				|
\'%\"\'				|
\'%\(\'				|
\'%\)\'				|
\'%<\'				|
\'%>\'				{
					create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
					analysed_tokens.extend(curr_token)
					}

\'%\/[0-9]+\/\'		{
					code_ := text_substring (4, text_count - 2).to_integer
					if code_ > Platform.Maximum_character_code then
						-- Character error. Consedered as text.
						create {EDITOR_TOKEN_TEXT} curr_token.make(text)
					else
						create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
					end
					analysed_tokens.extend(curr_token)
					}

\'.{1,2}			|
\'%\/[0-9]+(\/)?	{
					-- Character error. Catch-all rules (no backing up)
					create {EDITOR_TOKEN_TEXT} curr_token.make(text)
					analysed_tokens.extend(curr_token)
					}


----------/** Eiffel strings **/------------------------------------------------

\".*\"				|
\%.*\"				|
\".*\%				{
					-- Eiffel String
					create {EDITOR_TOKEN_STRING} curr_token.make(text)
					analysed_tokens.extend(curr_token)
					}

----------/** Eiffel bits **/---------------------------------------------------

[0-1]+[bB]			{
					-- Eiffel Bit
					create {EDITOR_TOKEN_NUMBER} curr_token.make(text)
					analysed_tokens.extend(curr_token)
					}
						
----------/** Eiffel integers **/-----------------------------------------------

[0-9]+					|
[0-9]{1,3}(_[0-9]{3})+	{
						-- Eiffel Integer
						create {EDITOR_TOKEN_NUMBER} curr_token.make(text)
						analysed_tokens.extend(curr_token)
						}
[0-9_]+					{
						-- Eiffel Integer Error (considered as text)
						create {EDITOR_TOKEN_TEXT} curr_token.make(text)
						analysed_tokens.extend(curr_token)
						}

---------/** Eiffel reals **/---------------------------------------------------

[0-9]+\./[^.0-9]					|
[0-9]+\.[0-9]*[eE][+-]?[0-9]+		|
[0-9]*\.[0-9]+([eE][+-]?[0-9]+)?	|
[0-9]{1,3}(_[0-9]{3})+\./[^.0-9]	|
[0-9]{1,3}(_[0-9]{3})*\.([0-9]{1,3}(_[0-9]{3})*)?[eE][+-]?[0-9]{1,3}(_[0-9]{3})*	|
([0-9]{1,3}(_[0-9]{3})*)?\.[0-9]{1,3}(_[0-9]{3})*([eE][+-]?[0-9]{1,3}(_[0-9]{3})*)?	{
							-- Eiffel reals & doubles
						create {EDITOR_TOKEN_NUMBER} curr_token.make(text)
						analysed_tokens.extend(curr_token)
						}

		-- The first and fourth expressions use a trailing context
		-- to make sure that an integer followed by two dots is
		-- not recognized as a real followed by a dot.

--------------------------------------------------------------------------------

<<EOF>>			terminate
.				{
					-- Error (considered as text)
				create {EDITOR_TOKEN_TEXT} curr_token.make(text)
				analysed_tokens.extend(curr_token)
				}

--------------------------------------------------------------------------------
%%

feature {NONE} -- Local variables

	i_, nb_: INTEGER
	char_: CHARACTER
	str_: STRING
	code_: INTEGER

feature {NONE} -- Initialization

	make is
			-- Create a new Eiffel scanner.
		do
			make_with_buffer (Empty_buffer)
			eif_buffer := STRING_.make (Init_buffer_size)
			eif_lineno := 1
		end

feature -- Start Job / Reinitialization 

	execute(a_string: STRING) is
			-- Analyze a string.
		do
			reset
			set_input_buffer (new_string_buffer(a_string))
			scan
		end

	reset is
			-- Reset scanner before scanning next input.
		do
			reset_compressed_scanner_skeleton
			eif_lineno := 1
			eif_buffer.wipe_out
			create analysed_tokens.make	-- create a new one, the old one
										-- is still "usable"
		end

feature -- Access

	curr_token: EDITOR_TOKEN

	analysed_tokens: EDITOR_LINE

	last_value: ANY
			-- Semantic value to be passed to the parser

	eif_buffer: STRING
			-- Buffer for lexial tokens

	eif_lineno: INTEGER
			-- Current line number

	is_operator: BOOLEAN
			-- Parsing an operator declaration?

feature {NONE} -- Processing

	process_operator (op: INTEGER): INTEGER is
			-- Process current token as operator `op' or as
			-- an Eiffel string depending on the context
		require
			text_count_large_enough: text_count > 2
		do
			if is_operator then
				is_operator := False
				Result := op
			else
				Result := E_STRING
				last_value := text_substring (2, text_count - 1)
			end
		end

feature {NONE} -- Constants

	Init_buffer_size: INTEGER is 80 
				-- Initial size for `eif_buffer'

invariant

	eif_buffer_not_void: eif_buffer /= Void

end -- class EIFFEL_SCANNER
