%{
indexing
	description:"Scanners for Eiffel parsers"
	author:     "Arnaud PICHERY from an Eric Bezault model"
	date:       "$Date$"
	revision:   "$Revision$"

class EDITOR_EIFFEL_SCANNER

inherit

	EDITOR_SCANNER

	EDITOR_EIFFEL_SCANNER_SKELETON	

create
	make
%}

%x VERBATIM_STR1
%option outfile="editor_eiffel_scanner.e"

D		([0-9])
H		([0-9A-Fa-f])

%%

----------/** Separators **/----------------------------------------------------

[\r]+				-- Ignore carriage return
[ ]+				{
					create {EDITOR_TOKEN_SPACE} curr_token.make(text_count)
					update_token_list
					}
[\t]+				{
					if not in_comments then
						create {EDITOR_TOKEN_TABULATION} curr_token.make(text_count)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					}
\n+					{
					from i_ := 1 until i_ > text_count loop
						create {EDITOR_TOKEN_EOL} curr_token.make
						update_token_list
						i_ := i_ + 1
					end
					in_comments := False
					}


----------/** Eiffel comments **/-----------------------------------------------

"--"				{ 
						-- comments
					create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					in_comments := True	
					update_token_list					
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
					if not in_comments then
						create {EDITOR_TOKEN_TEXT} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					}

"//"				|
"\\\\"				|
"/="				|
">="				|
"<="				|
"->"				|
".."				|
"<<"				|
">>"				|
"?="				|
":="				|
"-"					|
"+"					|
"*"					|
"/"					|
"^"					|
"="					|
">"					|
"<"					{ 
						-- Operator Symbol
					if not in_comments then
						create {EDITOR_TOKEN_OPERATOR} curr_token.make(text)					
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					}

----------/** Reserved words **/------------------------------------------------

"!!"									|
[aA][gG][eE][nN][tT]					|
[aA][lL][iI][aA][sS]					|
[aA][lL][lL]						|
[aA][nN][dD]						|
[aA][sS]						|
[aA][sS][sS][iI][gG][nN]				|
[bB][iI][tT]					|
[cC][hH][eE][cC][kK]					|
[cC][lL][aA][sS][sS]					|
[cC][oO][nN][vV][eE][rR][tT]			|
[cC][rR][eE][aA][tT][eE]				|
[cC][rR][eE][aA][tT][iI][oO][nN]		|
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
[iI][nN][dD][eE][xX][iI][nN][gG]		|
[iI][nN][fF][iI][xX]				|
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
[pP][rR][eE][cC][uU][rR][sS][oO][rR]	|
[pP][rR][eE][fF][iI][xX]		|
[rR][eE][fF][eE][rR][eE][nN][cC][eE]	|
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
[vV][oO][iI][dD]						|
[wW][hH][eE][nN]						|
[xX][oO][rR]							{
										-- Keyword
										if not in_comments then
											create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
										}


----------/** Eiffel identifiers **/--------------------------------------------

[A-Z][A-Z0-9_]*							{
										if not in_comments then
											if is_current_group_valid then
												tmp_classes := current_group.class_by_name (text, True)
												if not tmp_classes.is_empty then
													create {EDITOR_TOKEN_CLASS} curr_token.make (text)
													curr_token.set_pebble (stone_of_class (tmp_classes.first))
												else
													create {EDITOR_TOKEN_TEXT} curr_token.make (text)
												end
											else
												create {EDITOR_TOKEN_TEXT} curr_token.make (text)
											end							
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
										}


[a-zA-Z][a-zA-Z0-9_]*					{
										if not in_comments then
												create {EDITOR_TOKEN_TEXT} curr_token.make(text)											
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
										}


----------/** Eiffel free operators **/-----------------------------------------

[@#|&][^%" \t\r\n]*						{
										if not in_comments then
											create {EDITOR_TOKEN_TEXT} curr_token.make(text)										
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
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
					if not in_comments then
						create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					}

\'%\/[0-9]+\/\'		{
					if not in_comments then
						code_ := text_substring (4, text_count - 2).to_integer
						if code_ > {CHARACTER}.Max_value then
							-- Character error. Consedered as text.
							create {EDITOR_TOKEN_TEXT} curr_token.make(text)
						else
							create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
						end						
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					}

\'.{1,2}			|
\'%\/[0-9]+(\/)?	{
					-- Character error. Catch-all rules (no backing up)
					if not in_comments then
						create {EDITOR_TOKEN_TEXT} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					}


----------/** Eiffel strings **/------------------------------------------------

-- We accept here a fully formed Eiffel string which is complete, i.e:
-- 1 - whatever but `"' and '\n' except '%"' which is enclosed in
--     between (","), (",%), (%,%) or (%,")
-- We also accept beginning of a string, i.e:
-- 2 - whatever that start with either `"' or `%' and that does
--     not finishes with a `"' or `%'. Because we needed to support
--     the special character such as %N, %T,... we have to list all of
--     them in the second expression.

 \"[^\n"%]*\[/[ \t\r]*	{
 				if not in_comments then
						-- Verbatim string opener.
					create {EDITOR_TOKEN_STRING} curr_token.make(text)
					update_token_list
					in_verbatim_string := True
					start_of_verbatim_string := True
					set_start_condition (VERBATIM_STR1)
				else
					create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					update_token_list
				end
			}

\"[^\n"%]*\{/[ \t\r]*	{
				if not in_comments then
						-- Verbatim string opener.
					create {EDITOR_TOKEN_STRING} curr_token.make(text)
					update_token_list
					in_verbatim_string := True
					start_of_verbatim_string := True
					set_start_condition (VERBATIM_STR1)
				else
					create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					update_token_list
				end				
			}

<VERBATIM_STR1>{
	[\r]+					-- Ignore carriage return
	[ \t\r]*\][^%\n"]*\" 	{
							-- Verbatim string closer, possibly.
						create {EDITOR_TOKEN_STRING} curr_token.make(text)						
						end_of_verbatim_string := True
						in_verbatim_string := False
						set_start_condition (INITIAL)
						update_token_list
					}
	
	[ \t\r]*\}[^%\n"]*\" 	{
							-- Verbatim string closer, possibly.
						create {EDITOR_TOKEN_STRING} curr_token.make(text)						
						end_of_verbatim_string := True
						in_verbatim_string := False
						set_start_condition (INITIAL)
						update_token_list
					}	
	
	[ ]+				{
						create {EDITOR_TOKEN_SPACE} curr_token.make(text_count)
						update_token_list						
					}
					
	[\t]+				{						
						create {EDITOR_TOKEN_TABULATION} curr_token.make(text_count)
						update_token_list						
					}
					
	\n+				{
						from i_ := 1 until i_ > text_count loop
							create {EDITOR_TOKEN_EOL} curr_token.make
							update_token_list
							i_ := i_ + 1
						end						
					}
					
	[^\n\ \t]*			{
						create {EDITOR_TOKEN_STRING} curr_token.make(text)
						update_token_list
					}
	}

[%\"]([^\n\"]|%\")*(\"|%)	|
[%\"]([^\n\"\%]|%\"|%A|%B|%C\%D|%F|%H|%L|%N|%Q|%R|%S|%T|%U|%V|%%|%\'|%\(|%\)|%<|%>|%\/[0-9]{1,3}\/)*		{
					-- Eiffel String
					if not in_comments then						
						create {EDITOR_TOKEN_STRING} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					}

----------/** Eiffel bits **/---------------------------------------------------

[0-1]+[bB]			{
					-- Eiffel Bit
					if not in_comments then
						create {EDITOR_TOKEN_NUMBER} curr_token.make(text)						
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					}
						
----------/** Eiffel integers **/-----------------------------------------------

{D}(({D}|_)*{D})?			|
0[xX]{H}(({H}|_)*{H})?	{
						-- Eiffel Integer
						if not in_comments then
							create {EDITOR_TOKEN_NUMBER} curr_token.make(text)
						else
							create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
						end
						update_token_list
						}
[0-9_]+					{
							-- Eiffel Integer Error (considered as text)
						if not in_comments then
							create {EDITOR_TOKEN_TEXT} curr_token.make(text)
						else
							create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
						end
						update_token_list
						}

---------/** Eiffel reals **/---------------------------------------------------

[0-9]+\./[^.0-9]					|
[0-9]+\.[0-9]*[eE][+-]?[0-9]+		|
[0-9]*\.[0-9]+([eE][+-]?[0-9]+)?	|
[0-9]{1,3}(_[0-9]{3})+\./[^.0-9]	|
[0-9]{1,3}(_[0-9]{3})*\.([0-9]{1,3}(_[0-9]{3})*)?[eE][+-]?[0-9]{1,3}(_[0-9]{3})*	|
([0-9]{1,3}(_[0-9]{3})*)?\.[0-9]{1,3}(_[0-9]{3})*([eE][+-]?[0-9]{1,3}(_[0-9]{3})*)?	{
							-- Eiffel reals & doubles
						if not in_comments then		
							create {EDITOR_TOKEN_NUMBER} curr_token.make(text)
						else
							create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
						end
						update_token_list
						}

		-- The first and fourth expressions use a trailing context
		-- to make sure that an integer followed by two dots is
		-- not recognized as a real followed by a dot.

----------/** Comments enable/disable **/-----------------------------------------

\`[^%\n']+\'					{
					create {EDITOR_TOKEN_TEXT} curr_token.make(text)
					update_token_list
					}

--------------------------------------------------------------------------------

<<EOF>>			terminate
.				{
					-- Error (considered as text)
				if not in_comments then
					create {EDITOR_TOKEN_TEXT} curr_token.make(text)
				else
					create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
				end
				update_token_list
				}

--------------------------------------------------------------------------------
%%
end -- EDITOR_EIFFEL_SCANNER
