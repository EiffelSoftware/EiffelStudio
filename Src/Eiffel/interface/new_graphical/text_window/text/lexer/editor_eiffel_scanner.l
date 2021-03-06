%{
note
	description:"Scanners for Eiffel parsers"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Arnaud PICHERY from an Eric Bezault model"
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

class EDITOR_EIFFEL_SCANNER

inherit

	EDITOR_EIFFEL_SCANNER_SKELETON	

create
	make
%}

%x VERBATIM_STR1
%option outfile="editor_eiffel_scanner.e"

D		([0-9])
B		([0-1])
O		([0-7])
H		([0-9A-Fa-f])
A		([0-9A-Za-z])

-- NON_ASCII: Identical to all code points of Unicode excluding 0 - 127.

UTF8_char	{UTF8_1}|{UTF8_2}|{UTF8_3}|{UTF8_4}
NON_ASCII	{UTF8_2}|{UTF8_3}|{UTF8_4}
UTF8_1		[\x00-\x7F]
UTF8_2		[\xC2-\xDF]{UTF8_tail}
UTF8_3		(\xE0[\xA0-\xBF]{UTF8_tail})|([\xE1-\xEC]({UTF8_tail}{2}))|(\xED[\x80-\x9F]{UTF8_tail})|([\xEE-\xEF]({UTF8_tail}{2}))
UTF8_4		(\xF0[\x90-\xBF]({UTF8_tail}{2}))|([\xF1-\xF3]({UTF8_tail}{3}))|(\xF4[\x80-\x8F]({UTF8_tail}{2}))
UTF8_tail	[\x80-\xBF]

%%

----------/** Separators **/----------------------------------------------------

[ ]+				{
					curr_token := new_space (text_count)
					update_token_list
					}
[\t]+				{
					if not in_comments then
						curr_token := new_tabulation (text_count)
					else
						curr_token := new_comment (text)
					end
					update_token_list
					}
\r\n				{
					curr_token := new_eol (True)
					update_token_list
					in_comments := False
					}
\n					{
					curr_token := new_eol (False)
					update_token_list
					in_comments := False
					}
\r					{
					curr_token := new_text (text)
					update_token_list
					}


----------/** Eiffel comments **/-----------------------------------------------

"--"				{ 
						-- comments
					curr_token := new_comment (text)
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
"$"					|
\xE2\x9F\xA6				|
\xE2\x9F\xA7				{
						-- Symbols
					if not in_comments then
						curr_token := new_text (text)
					else
						curr_token := new_comment (text)
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
"/~"				|
"-"					|
"+"					|
"*"					|
"/"					|
"^"					|
"="					|
">"					|
"<"					|
"~"					{ 
						-- Operator Symbol
					if not in_comments then
						curr_token := new_operator (text)					
					else
						curr_token := new_comment (text)
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
									if in_comments then
											-- Comment.
										curr_token := new_comment (text)
									else
											-- Keyword.
										curr_token := new_keyword (text)
									end
									update_token_list
								}

[aA][cC][rR][oO][sS][sS]		|
[aA][tT][tT][aA][cC][hH][eE][dD]		|
[aA][tT][tT][rR][iI][bB][uU][tT][eE]		|
[dD][eE][tT][aA][cC][hH][aA][bB][lL][eE]	|
[nN][oO][tT][eE]				|
[sS][oO][mM][eE]				{
							if in_comments then
									-- Comment
								curr_token := new_comment (text)
							elseif syntax_version /= {EIFFEL_SCANNER}.obsolete_syntax then
									-- Keyword
								curr_token := new_keyword (text)
							else
									-- Identifier
								curr_token := new_text (text)
							end
							update_token_list
						}

[iI][nN][dD][eE][xX][iI][nN][gG]		{
							if in_comments then
									-- Comment
								curr_token := new_comment (text)
							elseif
								syntax_version = {EIFFEL_SCANNER}.obsolete_syntax or else
								syntax_version = {EIFFEL_SCANNER}.transitional_syntax
							then
									-- Keyword
								curr_token := new_keyword (text)
							else
								curr_token := new_text (text)
							end
							update_token_list
						}


----------/** Eiffel identifiers **/--------------------------------------------

[A-Z][A-Z0-9_]*							{
										if not in_comments then
											if is_current_group_valid then
												tmp_classes := current_group.class_by_name (text, True)
												if not tmp_classes.is_empty then
													curr_token := new_class (text)
													curr_token.set_pebble (stone_of_class (tmp_classes.first))
												else
													curr_token := new_text (text)
												end
											else
												curr_token := new_text (text)
											end							
										else
											curr_token := new_comment (text)
										end
										update_token_list
										}


[a-zA-Z][a-zA-Z0-9_]*					{
										if not in_comments then
											curr_token := new_text (text)											
										else
											curr_token := new_comment (text)
										end
										update_token_list
										}


----------/** Eiffel free operators **/-----------------------------------------

([@#|&][^%" \t\r\n]*)|{NON_ASCII}					{
										if not in_comments then
											curr_token := new_operator (text)
										else
											curr_token := new_comment (text)
										end
										update_token_list
										}
	-- Note: Accepts non-printable characters as well,
	-- provided that they are not break characters.


----------/** Eiffel characters **/---------------------------------------------

\'([^%\n']|{NON_ASCII})\'	|
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
\'%>\' {
		if not in_comments then
			curr_token := new_character (text)
		else
			curr_token := new_comment (text)
		end
		update_token_list
	}

\'%\/[0-9]+\/\' {
		if not in_comments then
			code_ := text_substring (4, text_count - 2).to_integer
			if code_ > {CHARACTER}.Max_value then
					-- Character error. Consedered as text.
				curr_token := new_text (text)
			else
				curr_token := new_character (text)
			end						
		else
			curr_token := new_comment (text)
		end
		update_token_list
	}

\'([^' \t\r\n]|{NON_ASCII})+ {
			-- Character error. Catch-all rules (no backing up)
		if not in_comments then
			curr_token := new_text (text)
		else
			curr_token := new_comment (text)
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

 \"([^\n"%]|{NON_ASCII})*[\[\{]/[ \t\r]* {
 		if not in_comments then
				-- Verbatim string opener.
			curr_token := new_string (text)
			update_token_list
			in_verbatim_string := True
			start_of_verbatim_string := True
			set_start_condition (VERBATIM_STR1)
		else
			curr_token := new_comment (text)
			update_token_list
		end
	}

<VERBATIM_STR1>{
	[ \t\r]*[\]\}]([^%\n"]|{NON_ASCII})*\" {
				-- Verbatim string closer, possibly.
			curr_token := new_string (text)						
			end_of_verbatim_string := True
			in_verbatim_string := False
			set_start_condition (INITIAL)
			update_token_list
		}
	[ ]+ {
			curr_token := new_space (text_count)
			update_token_list						
		}
					
	[\t]+ {
			curr_token := new_tabulation (text_count)
			update_token_list						
		}
					
	\r\n {
			curr_token := new_eol (True)
			update_token_list
			in_comments := False
		}
	\n {
			curr_token := new_eol (False)
			update_token_list
			in_comments := False
		}
	\r {
			curr_token := new_text (text)
			update_token_list
		}
	\" {
			curr_token := new_string (text)
			update_token_list
		}
	([^\n\ \t\"]|{NON_ASCII})* {
			curr_token := new_string (text)
			update_token_list
		}
	}

[%\"]([^\n\"%]|{NON_ASCII}|%\"|%A|%B|%C|%D|%F|%H|%L|%N|%Q|%R|%S|%T|%U|%V|%%|%\'|%\(|%\)|%<|%>|%\/[0-9]{1,3}\/)*[%\"] {
			-- Eiffel String
		if not in_comments then						
			curr_token := new_string (text)
		else
			curr_token := new_comment (text)
		end
		update_token_list
	}

----------/** Eiffel integers **/-----------------------------------------------

{D}(({D}|_)*{D})?			|
0[xX]{H}(({H}|_)*{H})?			|
0[cC]{O}(({O}|_)*{O})?			|
0[bB]{B}(({B}|_)*{B})? {
			-- Eiffel Integer
		if not in_comments then
			curr_token := new_number (text)
		else
			curr_token := new_comment (text)
		end
		update_token_list
	}


0[xX]{A}(({A}|_)*{A})?			|
0[cC]{A}(({A}|_)*{A})?			|
0[bB]{A}(({A}|_)*{A})?			|
{D}(({A}|_)*{A})? {
			-- Bad Eiffel Integer
		if not in_comments then
			curr_token := new_text (text)
		else
			curr_token := new_comment (text)
		end
		update_token_list
	}

---------/** Eiffel reals **/---------------------------------------------------

[0-9]+\./[^.0-9]					|
[0-9]+\.[0-9]*[eE][+-]?[0-9]+		|
[0-9]*\.[0-9]+([eE][+-]?[0-9]+)?	|
[0-9]{1,3}(_[0-9]{3})+\./[^.0-9]	|
[0-9]{1,3}(_[0-9]{3})*\.([0-9]{1,3}(_[0-9]{3})*)?[eE][+-]?[0-9]{1,3}(_[0-9]{3})*	|
([0-9]{1,3}(_[0-9]{3})*)?\.[0-9]{1,3}(_[0-9]{3})*([eE][+-]?[0-9]{1,3}(_[0-9]{3})*)? {
			-- Eiffel reals & doubles
		if not in_comments then		
			curr_token := new_number (text)
		else
			curr_token := new_comment (text)
		end
		update_token_list
	}

		-- The first and fourth expressions use a trailing context
		-- to make sure that an integer followed by two dots is
		-- not recognized as a real followed by a dot.

----------/** Comments enable/disable **/-----------------------------------------

\`([^%\n\`']|{NON_ASCII})+\`					|
\`([^%\n\`']|{NON_ASCII})+\' {
		curr_token := new_text_in_comment (text)
		update_token_list
	}

--------------------------------------------------------------------------------

<<EOF>>			terminate
. {
			-- Error (considered as text)
		if not in_comments then
			curr_token := new_text (text)
		else
			curr_token := new_comment (text)
		end
		update_token_list
	}

--------------------------------------------------------------------------------
%%

note
	copyright:	"Copyright (c) 1984-2019, Eiffel Software"
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
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
