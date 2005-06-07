indexing
	description:"Scanners for Eiffel parsers"
	author:     "Arnaud PICHERY from an Eric Bezault model"
	date:       "$Date$"
	revision:   "$Revision$"

class EDITOR_EIFFEL_SCANNER

inherit

	EDITOR_SCANNER

	SHARED_EIFFEL_PROJECT

create
	make

feature -- Status report

	valid_start_condition (sc: INTEGER): BOOLEAN is
			-- Is `sc' a valid start condition?
		do
			Result := (sc = INITIAL)
		end

feature {NONE} -- Implementation

	yy_build_tables is
			-- Build scanner tables.
		do
			yy_nxt := yy_nxt_template
			yy_chk := yy_chk_template
			yy_base := yy_base_template
			yy_def := yy_def_template
			yy_ec := yy_ec_template
			yy_meta := yy_meta_template
			yy_accept := yy_accept_template
			yy_acclist := yy_acclist_template
		end

	yy_execute_action (yy_act: INTEGER) is
			-- Execute semantic action.
		do
			inspect yy_act
when 1 then
--|#line 28 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 28")
end
-- Ignore carriage return
when 2 then
--|#line 29 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 29")
end

					create {EDITOR_TOKEN_SPACE} curr_token.make(text_count)
					update_token_list
					
when 3 then
--|#line 33 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 33")
end

					create {EDITOR_TOKEN_TABULATION} curr_token.make(text_count)
					update_token_list
					
when 4 then
--|#line 37 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 37")
end

					from i_ := 1 until i_ > text_count loop
						create {EDITOR_TOKEN_EOL} curr_token.make
						update_token_list
						i_ := i_ + 1
					end
					in_comments := False
					
when 5 then
--|#line 49 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 49")
end
 
						-- comments
					create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					update_token_list
					in_comments := True
					
when 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17 then
--|#line 58 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 58")
end

						-- Symbols
					if not in_comments then
						if not in_verbatim_string then
							create {EDITOR_TOKEN_TEXT} curr_token.make(text)
						else
							create {EDITOR_TOKEN_STRING} curr_token.make(text)
						end
						
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
when 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36 then
--|#line 84 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 84")
end
 
						-- Operator Symbol
					if not in_comments then
						if not in_verbatim_string then
							create {EDITOR_TOKEN_OPERATOR} curr_token.make(text)
						else
							create {EDITOR_TOKEN_STRING} curr_token.make(text)
						end
						
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
when 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99 then
--|#line 119 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 119")
end

										-- Keyword
										if not in_comments then
											if not in_verbatim_string then
												create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
											else
												create {EDITOR_TOKEN_STRING} curr_token.make(text)
											end
											
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
										
when 100 then
--|#line 199 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 199")
end

										if not in_comments then
											if not in_verbatim_string then
												if not Eiffel_universe.classes_with_name (text).is_empty then
												create {EDITOR_TOKEN_CLASS} curr_token.make(text)
											else
												create {EDITOR_TOKEN_TEXT} curr_token.make(text)
											end
											else
												create {EDITOR_TOKEN_STRING} curr_token.make(text)
											end
											
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
										
when 101 then
--|#line 218 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 218")
end

										if not in_comments then
											if not in_verbatim_string then
												create {EDITOR_TOKEN_TEXT} curr_token.make(text)
											else
												create {EDITOR_TOKEN_STRING} curr_token.make(text)
											end
											
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
										
when 102 then
--|#line 235 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 235")
end

										if not in_comments then
											if not in_verbatim_string then
												create {EDITOR_TOKEN_TEXT} curr_token.make(text)
											else
												create {EDITOR_TOKEN_STRING} curr_token.make(text)
											end
											
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
										
when 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124 then
--|#line 254 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 254")
end

					if not in_comments then
						if not in_verbatim_string then
							create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
						else
							create {EDITOR_TOKEN_STRING} curr_token.make(text)
						end

					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
when 125 then
--|#line 289 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 289")
end

					if not in_comments then
						if not in_verbatim_string then
							code_ := text_substring (4, text_count - 2).to_integer
							if code_ > {CHARACTER}.Max_value then
								-- Character error. Consedered as text.
								create {EDITOR_TOKEN_TEXT} curr_token.make(text)
							else
								create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
							end
						else
							create {EDITOR_TOKEN_STRING} curr_token.make(text)
						end
						
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
when 126, 127 then
--|#line 309 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 309")
end

					-- Character error. Catch-all rules (no backing up)
					if not in_comments then
						if not in_verbatim_string then
							create {EDITOR_TOKEN_TEXT} curr_token.make(text)
						else
							create {EDITOR_TOKEN_STRING} curr_token.make(text)
						end
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
when 128 then
--|#line 336 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 336")
end

					-- Verbatim string opener.
				create {EDITOR_TOKEN_STRING} curr_token.make(text)
				update_token_list
				in_verbatim_string := True
			
when 129 then
--|#line 343 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 343")
end

					-- Verbatim string opener.
				create {EDITOR_TOKEN_STRING} curr_token.make(text)
				update_token_list
				in_verbatim_string := True
			
when 130 then
--|#line 351 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 351")
end

					-- Verbatim string closer, possibly.
				create {EDITOR_TOKEN_STRING} curr_token.make(text)
				update_token_list	
				in_verbatim_string := False				
			
when 131 then
--|#line 358 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 358")
end

					-- Verbatim string closer, possibly.
				create {EDITOR_TOKEN_STRING} curr_token.make(text)
				update_token_list
				in_verbatim_string := False

when 132, 133 then
--|#line 366 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 366")
end

					-- Eiffel String
					if not in_comments then						
						create {EDITOR_TOKEN_STRING} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
when 134 then
--|#line 379 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 379")
end

					-- Eiffel Bit
					if not in_comments then
						if not in_verbatim_string then
							create {EDITOR_TOKEN_NUMBER} curr_token.make(text)
						else
							create {EDITOR_TOKEN_STRING} curr_token.make(text)
						end	
						
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
when 135, 136, 137, 138 then
--|#line 396 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 396")
end

						-- Eiffel Integer
						if not in_comments then
							if not in_verbatim_string then
								create {EDITOR_TOKEN_NUMBER} curr_token.make(text)
							else
								create {EDITOR_TOKEN_STRING} curr_token.make(text)
							end
							
						else
							create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
						end
						update_token_list
						
when 139 then
--|#line 413 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 413")
end

						-- Eiffel Integer Error (considered as text)
						if not in_comments then
							if not in_verbatim_string then
								create {EDITOR_TOKEN_TEXT} curr_token.make(text)
							else
								create {EDITOR_TOKEN_STRING} curr_token.make(text)
							end						

						else
							create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
						end
						update_token_list
						
when 140 then
	yy_end := yy_end - 1
--|#line 430 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 430")
end

							-- Eiffel reals & doubles
						if not in_comments then							
							if not in_verbatim_string then
								create {EDITOR_TOKEN_NUMBER} curr_token.make(text)
							else
								create {EDITOR_TOKEN_STRING} curr_token.make(text)
							end
						else
							create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
						end
						update_token_list
						
when 141, 142 then
--|#line 431 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 431")
end

							-- Eiffel reals & doubles
						if not in_comments then							
							if not in_verbatim_string then
								create {EDITOR_TOKEN_NUMBER} curr_token.make(text)
							else
								create {EDITOR_TOKEN_STRING} curr_token.make(text)
							end
						else
							create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
						end
						update_token_list
						
when 143 then
	yy_end := yy_end - 1
--|#line 433 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 433")
end

							-- Eiffel reals & doubles
						if not in_comments then							
							if not in_verbatim_string then
								create {EDITOR_TOKEN_NUMBER} curr_token.make(text)
							else
								create {EDITOR_TOKEN_STRING} curr_token.make(text)
							end
						else
							create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
						end
						update_token_list
						
when 144, 145 then
--|#line 434 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 434")
end

							-- Eiffel reals & doubles
						if not in_comments then							
							if not in_verbatim_string then
								create {EDITOR_TOKEN_NUMBER} curr_token.make(text)
							else
								create {EDITOR_TOKEN_STRING} curr_token.make(text)
							end
						else
							create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
						end
						update_token_list
						
when 146 then
--|#line 455 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 455")
end

					create {EDITOR_TOKEN_TEXT} curr_token.make(text)
					update_token_list
					
when 147 then
--|#line 463 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 463")
end

					-- Error (considered as text)
				if not in_comments then
					if not in_verbatim_string then
						create {EDITOR_TOKEN_TEXT} curr_token.make(text)
					else
						create {EDITOR_TOKEN_STRING} curr_token.make(text)
					end

				else
					create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
				end
				update_token_list
				
when 148 then
--|#line 0 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 0")
end
default_action
			else
				last_token := yyError_token
				fatal_error ("fatal scanner internal error: no action found")
			end
		end

	yy_execute_eof_action (yy_sc: INTEGER) is
			-- Execute EOF semantic action.
		do
			inspect yy_sc
when 0 then
--|#line 0 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 0")
end
terminate
			else
				terminate
			end
		end

feature {NONE} -- Table templates

	yy_nxt_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    4,    5,    6,    7,    8,    9,   10,   11,   12,
			   13,   14,   15,   16,   17,   18,   19,   20,   21,   22,
			   23,   24,   25,   26,   27,   28,   29,   30,   31,   32,
			   33,   34,   35,   36,   37,   38,   38,   39,   38,   38,
			   40,   38,   41,   42,   43,   38,   44,   45,   46,   47,
			   48,   49,   50,   38,   38,   51,   52,   53,   54,   55,
			   56,   57,   58,   59,   60,   61,   62,   63,   63,   64,
			   63,   63,   65,   63,   66,   67,   68,   63,   69,   70,
			   71,   72,   73,   74,   75,   63,   63,   76,   77,   78,
			  585,   79,   79,   79,  494,   83,   79,   79,   87,   79,

			   84,   88,   87,   94,   95,   88,   96,   98,  100,   99,
			   99,   99,  109,  110,  487,  101,   97,  111,  112,  102,
			  578,  103,  103,  104,  102,  136,  103,  103,  104,  114,
			  102,  105,  104,  104,  104,  137,  105,  114,  176,  385,
			  125,  146,  114,  385,   80,  147,   89,  385,   80,  114,
			  114,  372,   80,  106,  198,  198,  198,  138,  148,  174,
			  107,  119,  371,  105,  370,  107,  369,  139,  105,  119,
			  177,  107,  125,  149,  119,   81,  368,  150,   90,   81,
			  367,  119,  119,   81,  366,  106,  114,  114,  114,  114,
			  151,  175,  165,  198,  186,  114,  114,  114,  114,  114,

			  114,  115,  114,  114,  114,  114,  116,  114,  117,  114,
			  114,  114,  114,  118,  114,  114,  114,  114,  114,  114,
			  114,  119,  365,  364,  165,  114,  187,  119,  119,  119,
			  119,  119,  119,  120,  119,  119,  119,  119,  121,  119,
			  122,  119,  119,  119,  119,  123,  119,  119,  119,  119,
			  119,  119,  119,  114,  114,  114,  192,  114,  175,  177,
			  363,  187,  114,  114,  114,  114,  114,  114,  114,  114,
			  124,  114,  114,  114,  114,  114,  114,  114,  114,  114,
			  114,  114,  114,  114,  114,  114,  114,  114,  193,  119,
			  175,  177,  114,  187,  119,  119,  119,  119,  119,  119,

			  119,  119,  125,  119,  119,  119,  119,  119,  119,  119,
			  119,  119,  119,  119,  119,  119,  119,  119,  119,  119,
			  126,  114,  362,  114,  127,  160,  140,  128,  141,  152,
			  129,  161,  114,  130,  114,  193,  153,  154,  142,  361,
			  164,   87,  155,   87,   88,  360,  347,   78,  114,   79,
			   79,  359,  131,  119,  194,  119,  132,  162,  143,  133,
			  144,  156,  134,  163,  119,  135,  119,  193,  157,  158,
			  145,  166,  165,  178,  159,  182,  114,  114,  114,  138,
			  119,  167,  188,  168,  195,  183,  195,  169,  179,  139,
			  114,  358,  120,  357,  162,   87,  189,  121,   88,  122,

			  163,  355,   80,  170,  123,  180,  354,  184,  119,  119,
			  119,  138,  180,  171,  190,  172,  195,  185,  353,  173,
			  181,  139,  119,  143,  120,  144,  162,  181,  191,  121,
			  131,  122,  163,   81,  132,  145,  123,  133,  170,  156,
			  134,  149,  190,  135,  180,  150,  157,  158,  171,  114,
			  172,  184,  159,  243,  173,  143,  191,  144,  151,  181,
			   87,  185,  131,   88,  352,  348,  132,  145,   88,  133,
			  170,  156,  134,  149,  190,  135,  351,  150,  157,  158,
			  171,  119,  172,  184,  159,  243,  173,  346,  191,   79,
			  151,   79,   79,  185,   79,  209,   83,   79,   79,   82,

			   79,   84,  206,   87,  206,  206,  350,   87,   89,  207,
			   88,  207,  207,  200,   87,  197,  249,   88,  232,  232,
			  232,  236,  236,  236,  102,  200,  238,  238,  239,  197,
			  348,  233,  114,  347,  237,  102,  105,  239,  239,  239,
			   90,  242,  250,  196,   80,  114,  248,  244,  249,   80,
			  245,  114,  113,   80,  251,   89,  108,  234,   85,  241,
			  241,  241,   89,  233,  119,  107,  237,  246,  105,  253,
			  247,   82,  114,  243,  251,   81,  107,  119,  249,  246,
			   81,  262,  247,  119,   81,  202,  251,   90,  203,   92,
			   92,   92,   87,  754,   90,  347,  754,  204,  198,  246,

			  754,  253,  247,   92,  119,   92,  114,   92,   92,  205,
			  754,  258,   92,  263,   92,  356,  356,  356,   92,  754,
			   92,  754,  754,   92,   92,   92,   92,   92,   92,  210,
			  754,  114,  211,  212,  213,  214,  754,  754,  119,  754,
			  754,  215,  252,  259,  254,  255,  260,  216,  114,  217,
			  114,  218,  219,  220,  221,  257,  222,  256,  223,  259,
			  261,  263,  224,  119,  225,  114,  114,  226,  227,  228,
			  229,  230,  231,  754,  253,  754,  255,  255,  261,  264,
			  119,  266,  119,  265,  114,  267,  114,  257,  269,  257,
			  270,  259,  261,  263,  268,  114,  114,  119,  119,  272,

			  276,  279,  280,  274,  277,  271,  114,  275,  281,  278,
			  114,  266,  283,  266,  273,  267,  119,  267,  119,  114,
			  269,  114,  272,  114,  114,  282,  269,  119,  119,  754,
			  284,  272,  276,  279,  281,  276,  277,  273,  119,  277,
			  281,  279,  119,  286,  283,  285,  273,  287,  114,  295,
			  290,  119,  754,  119,  291,  119,  119,  283,  288,  298,
			  301,  289,  285,  114,  114,  292,  294,  114,  293,  303,
			  306,  299,  296,  114,  300,  290,  114,  285,  114,  291,
			  119,  295,  290,  302,  297,  305,  291,  307,  309,  304,
			  292,  298,  301,  293,  114,  119,  119,  292,  295,  119,

			  293,  303,  307,  299,  298,  119,  301,  308,  119,  114,
			  119,  114,  198,  198,  198,  303,  299,  305,  326,  307,
			  309,  305,  754,  327,  329,  754,  119,  754,  754,  331,
			  114,  324,  316,  322,  317,  325,  328,  323,  754,  309,
			  114,  119,  318,  119,  310,  319,  311,  320,  321,  114,
			  327,  198,  754,  340,  312,  327,  329,  313,  114,  314,
			  315,  331,  119,  324,  316,  324,  317,  325,  329,  325,
			  330,  339,  119,  341,  318,  114,  316,  319,  317,  320,
			  321,  119,  332,  335,  338,  341,  318,  333,  336,  319,
			  119,  320,  321,  342,  343,  114,  345,  114,  334,  337,

			  754,  114,  331,  339,  344,  341,  387,  119,   87,  754,
			  754,  347,  754,  388,  335,  335,  339,  754,  754,  336,
			  336,  349,  349,  349,  754,  343,  343,  119,  345,  119,
			  337,  337,  206,  119,  206,  206,  345,   87,  388,  207,
			   88,  207,  207,   87,   87,  388,  347,   88,  373,  373,
			  373,  374,  754,  374,  114,   92,  375,  375,  375,  390,
			  754,  233,  376,  376,  376,  377,  377,  377,  380,  754,
			  380,  114,  754,  381,  381,  381,  389,  102,  378,  382,
			  382,  383,  391,  392,  114,   89,  119,  234,  114,  105,
			  394,  390,   89,  233,  102,  396,  383,  383,  383,  386,

			  386,  386,  114,  119,  379,  393,  754,  398,  390,  400,
			  378,  114,  395,  114,  392,  392,  119,   90,  107,  114,
			  119,  105,  394,  399,   90,  402,  397,  396,  401,  405,
			  114,  114,  404,  114,  119,  107,  406,  394,  198,  398,
			  408,  400,  403,  119,  396,  119,  407,  114,  410,  415,
			  114,  119,  416,  114,  114,  400,  413,  402,  398,  411,
			  402,  406,  119,  119,  404,  119,  409,  114,  406,  418,
			  414,  420,  408,  412,  404,  426,  754,  114,  408,  119,
			  410,  416,  119,  114,  416,  119,  119,  417,  413,  114,
			  428,  413,  427,  421,  419,  423,  114,  114,  410,  119,

			  425,  418,  414,  420,  114,  414,  422,  426,  424,  119,
			  429,  431,  433,  430,  114,  119,  432,  434,  436,  418,
			  114,  119,  428,  437,  428,  423,  420,  423,  119,  119,
			  435,  114,  426,  438,  114,  440,  119,  114,  424,  442,
			  424,  114,  430,  432,  434,  430,  119,  114,  432,  434,
			  436,  114,  119,  444,  439,  438,  443,  441,  445,  446,
			  114,  754,  436,  119,  114,  438,  119,  440,  447,  119,
			  449,  442,  114,  119,  114,  114,  451,  448,  450,  119,
			  452,  454,  460,  119,  114,  444,  440,  453,  444,  442,
			  446,  446,  119,  455,  114,  462,  119,  457,  464,  114,

			  448,  461,  450,  459,  119,  114,  119,  119,  452,  448,
			  450,  456,  452,  454,  460,  458,  119,  465,  466,  454,
			  463,  468,  470,  475,  472,  457,  119,  462,  114,  457,
			  464,  119,  469,  462,  114,  460,  114,  119,  471,  467,
			  114,  474,  114,  458,  476,  477,  478,  458,  473,  466,
			  466,  480,  464,  468,  470,  476,  472,  479,  114,  482,
			  119,  114,  114,  481,  470,  754,  119,  754,  119,  754,
			  472,  468,  119,  474,  119,  754,  476,  478,  478,  348,
			  474,  754,  347,  480,   87,  754,  754,  347,  754,  480,
			  119,  482,  754,  119,  119,  482,   92,  483,  483,  483,

			  484,  356,  356,  356,   92,  485,  485,  485,  375,  375,
			  375,  754,  486,  486,  486,  488,  488,  488,  233,  489,
			  489,  489,  490,  754,  490,  754,  754,  491,  491,  491,
			  498,  114,  378,  492,  492,  492,  381,  381,  381,  493,
			  493,  493,  497,  495,  234,  382,  382,  383,  500,  502,
			  233,  487,  496,  496,  496,  105,  504,  495,  379,  383,
			  383,  383,  498,  119,  378,  114,  754,  501,  114,  114,
			  503,  506,  114,  507,  498,  499,  508,  114,  494,  114,
			  500,  502,  505,  510,  198,  511,  512,  105,  504,  114,
			  509,  198,  513,  514,  114,  516,  517,  119,  198,  502,

			  119,  119,  504,  506,  119,  508,  518,  500,  508,  119,
			  114,  119,  520,  522,  506,  510,  524,  512,  512,  515,
			  114,  119,  510,  114,  514,  514,  119,  516,  518,  519,
			  114,  114,  523,  526,  528,  521,  530,  527,  518,  114,
			  525,  114,  119,  531,  520,  522,  114,  114,  524,  532,
			  533,  516,  119,  534,  536,  119,  538,  754,  529,  114,
			  540,  520,  119,  119,  524,  526,  528,  522,  530,  528,
			  542,  119,  526,  119,  535,  532,  114,  544,  119,  119,
			  114,  532,  534,  539,  114,  534,  536,  114,  538,  537,
			  530,  119,  540,  541,  114,  114,  114,  543,  546,  545,

			  114,  114,  542,  548,  549,  550,  536,  114,  119,  544,
			  552,  114,  119,  547,  114,  540,  119,  554,  553,  119,
			  551,  538,  555,  556,  558,  542,  119,  119,  119,  544,
			  546,  546,  119,  119,  560,  548,  550,  550,  562,  119,
			  564,  114,  552,  119,  114,  548,  119,  559,  114,  554,
			  554,  563,  552,  557,  556,  556,  558,  114,  114,  566,
			  568,  114,  114,  114,  561,  570,  560,  565,  567,  114,
			  562,  569,  564,  119,  114,  572,  119,  574,  575,  560,
			  119,  571,  576,  564,  114,  558,  114,  573,  114,  119,
			  119,  566,  568,  119,  119,  119,  562,  570,  114,  566,

			  568,  119,  754,  570,  754,  754,  119,  572,  754,  574,
			  576,  754,   87,  572,  576,  347,  119,  754,  119,  574,
			  119,  485,  485,  485,   92,  577,  577,  577,  754,  754,
			  119,  580,  580,  580,  579,  581,  581,  581,  582,  582,
			  582,  583,  583,  583,  491,  491,  491,  114,  584,  584,
			  584,  586,  586,  586,  378,  587,  587,  587,  588,  588,
			  588,  583,  583,  583,  114,  592,  579,  114,  114,  590,
			  487,  198,  198,  198,  589,  114,  114,  594,  754,  119,
			  379,  591,  600,  114,  593,  595,  378,  585,  597,  596,
			  114,  602,  598,  114,  494,  599,  119,  592,  603,  119,

			  119,  114,  601,  604,  606,  608,  589,  119,  119,  594,
			  107,  610,  754,  592,  600,  119,  594,  597,  114,  612,
			  597,  598,  119,  602,  598,  119,  607,  600,  605,  609,
			  604,  114,  114,  119,  602,  604,  606,  608,  114,  114,
			  114,  614,  114,  610,  611,  616,  618,  615,  617,  613,
			  119,  612,  114,  619,  620,  621,  622,  624,  608,  623,
			  606,  610,  625,  119,  119,  114,  626,  114,  628,  630,
			  119,  119,  119,  614,  119,  631,  612,  616,  618,  616,
			  618,  614,  632,  634,  119,  620,  620,  622,  622,  624,
			  636,  624,  627,  114,  626,  638,  114,  119,  626,  119,

			  628,  630,  629,  114,  633,  635,  639,  632,  114,  114,
			  114,  640,  637,  642,  632,  634,  114,  644,  114,  114,
			  646,  114,  636,  645,  628,  119,  647,  638,  119,  641,
			  643,  114,  648,  650,  630,  119,  634,  636,  640,  114,
			  119,  119,  119,  640,  638,  642,  652,  754,  119,  644,
			  119,  119,  646,  119,  114,  646,  649,  656,  648,  651,
			  114,  642,  644,  119,  648,  650,  754,  653,  754,  653,
			  754,  119,  654,  654,  654,  654,  654,  654,  652,  655,
			  655,  655,  754,  234,  114,  754,  119,  754,  650,  656,
			  754,  652,  119,  583,  583,  583,  658,  658,  658,  659,

			  659,  659,  660,  660,  660,  668,  657,  661,  661,  661,
			  662,  662,  662,  663,  487,  663,  119,  114,  661,  661,
			  661,  665,  665,  665,  114,  114,  670,  672,  667,  114,
			  674,  669,  673,  114,  666,  585,  114,  668,  657,  114,
			  671,  675,  676,  114,  677,  114,  494,  678,  680,  119,
			  679,  114,  114,  682,  114,  754,  119,  119,  670,  672,
			  668,  119,  674,  670,  674,  119,  666,  684,  119,  686,
			  114,  119,  672,  676,  676,  119,  678,  119,  114,  678,
			  680,  685,  680,  119,  119,  682,  119,  114,  681,  114,
			  688,  690,  683,  114,  692,  689,  114,  694,  696,  684,

			  687,  686,  119,  114,  691,  698,  693,  114,  114,  114,
			  119,  699,  695,  686,  697,  114,  700,  114,  114,  119,
			  682,  119,  688,  690,  684,  119,  692,  690,  119,  694,
			  696,  114,  688,  702,  114,  119,  692,  698,  694,  119,
			  119,  119,  704,  700,  696,  701,  698,  119,  700,  119,
			  119,  114,  114,  114,  706,  754,  703,  654,  654,  654,
			  654,  654,  654,  119,  705,  702,  119,  707,  707,  707,
			  711,  711,  711,  708,  704,  708,  713,  702,  709,  709,
			  709,  754,  754,  119,  119,  119,  706,  710,  704,  710,
			  114,  719,  711,  711,  711,  114,  706,  712,  712,  712,

			  718,  114,  379,  661,  661,  661,  721,  723,  713,  585,
			  714,  714,  714,  661,  661,  661,  715,  715,  715,  716,
			  725,  716,  119,  719,  717,  717,  717,  119,  114,  713,
			  720,  722,  719,  119,  114,  114,  114,  724,  721,  723,
			  114,  726,  727,  114,  114,  114,  114,  729,  731,  730,
			  114,  728,  725,  114,  733,  379,  732,  735,  736,  754,
			  119,  713,  721,  723,  114,  737,  119,  119,  119,  725,
			  114,  739,  119,  727,  727,  119,  119,  119,  119,  729,
			  731,  731,  119,  729,  741,  119,  733,  734,  733,  735,
			  737,  114,  114,  114,  738,  740,  119,  737,  114,  114,

			  754,  114,  119,  739,  709,  709,  709,  742,  742,  742,
			  711,  711,  711,  711,  711,  711,  741,  754,  114,  735,
			  743,  743,  743,  119,  119,  119,  739,  741,  114,  114,
			  119,  119,  744,  119,  744,  748,  114,  745,  745,  745,
			  660,  660,  660,  717,  717,  717,  487,  746,  746,  746,
			  119,  114,  750,  713,  754,  114,  114,  752,  114,  751,
			  119,  119,  747,  114,  749,  114,  114,  748,  119,  707,
			  707,  707,  745,  745,  745,  753,  753,  753,  114,  379,
			  714,  714,  714,  119,  750,  713,  494,  119,  119,  752,
			  119,  752,  114,  754,  748,  119,  750,  119,  119,  743,

			  743,  743,  240,  240,  240,  384,  384,  384,  487,  754,
			  119,  384,  754,  754,  585,  754,  754,  754,  754,  494,
			   91,  754,  754,  754,  119,  754,   91,   91,   91,   91,
			   91,   91,   91,   91,   91,   91,   91,  754,  585,   86,
			   86,  754,   86,   86,   86,   86,   86,   86,   86,   86,
			   86,   86,   86,   86,   86,   86,   92,   92,  754,   92,
			   92,   92,   92,   92,   92,   92,   92,   92,   92,   92,
			   92,   92,   92,   93,   93,  754,   93,   93,   93,   93,
			   93,   93,   93,   93,   93,   93,   93,   93,   93,   93,
			   80,   80,  754,   80,   80,  754,   80,   80,   80,   80,

			   80,   80,   80,   80,   80,   80,   80,  199,  199,  754,
			  199,  199,  754,  754,  199,  199,  199,  199,  199,  199,
			  199,  199,  199,  199,  119,  119,  119,  119,  119,  119,
			  119,  119,  119,   81,   81,  754,   81,   81,  754,   81,
			   81,   81,   81,   81,   81,   81,   81,   81,   81,   81,
			  201,  201,  754,  201,  201,  201,  201,  201,  201,  201,
			  201,  201,  201,  201,  201,  201,  201,  208,  208,  754,
			  208,  208,  208,  208,  208,  208,  208,  208,  208,  208,
			  208,  208,  208,  208,  235,  235,  235,  235,  235,  235,
			  235,  754,  235,  235,  235,  235,  235,  235,  235,  235,

			  235,  664,  664,  664,  664,  664,  664,  664,  754,  664,
			  664,  664,  664,  664,  664,  664,  664,  664,    3,  754,
			  754,  754,  754,  754,  754,  754,  754,  754,  754,  754,
			  754,  754,  754,  754,  754,  754,  754,  754,  754,  754,
			  754,  754,  754,  754,  754,  754,  754,  754,  754,  754,
			  754,  754,  754,  754,  754,  754,  754,  754,  754,  754,
			  754,  754,  754,  754,  754,  754,  754,  754,  754,  754,
			  754,  754,  754,  754,  754,  754,  754,  754,  754,  754,
			  754,  754,  754,  754,  754,  754,  754,  754,  754,  754,
			  754,  754,  754,  754,  754,  754,  754,  754,  754,  754,

			  754,  754,  754,  754,  754,  754,  754, yy_Dummy>>)
		end

	yy_chk_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    5,
			  743,    5,    5,    7,  714,    7,    7,    8,   10,    8,

			    8,   10,   13,   14,   14,   13,   20,   21,   22,   21,
			   21,   21,   28,   28,  707,   22,   20,   30,   30,   23,
			  484,   23,   23,   23,   24,   35,   24,   24,   24,   35,
			   25,   23,   25,   25,   25,   35,   24,   38,   44,  385,
			   58,   37,   44,  384,    5,   37,   10,  240,    7,   37,
			   43,  231,    8,   23,   55,   55,   55,   35,   37,   43,
			   23,   35,  230,   23,  229,   24,  228,   35,   24,   38,
			   44,   25,   58,   37,   44,    5,  227,   37,   10,    7,
			  226,   37,   43,    8,  225,   23,   32,   32,   32,   47,
			   37,   43,   66,   55,   47,   32,   32,   32,   32,   32,

			   32,   32,   32,   32,   32,   32,   32,   32,   32,   32,
			   32,   32,   32,   32,   32,   32,   32,   32,   32,   32,
			   32,   47,  224,  223,   66,   32,   47,   32,   32,   32,
			   32,   32,   32,   32,   32,   32,   32,   32,   32,   32,
			   32,   32,   32,   32,   32,   32,   32,   32,   32,   32,
			   32,   32,   32,   33,   33,   33,   49,   49,   68,   69,
			  222,   72,   33,   33,   33,   33,   33,   33,   33,   33,
			   33,   33,   33,   33,   33,   33,   33,   33,   33,   33,
			   33,   33,   33,   33,   33,   33,   33,   33,   49,   49,
			   68,   69,   33,   72,   33,   33,   33,   33,   33,   33,

			   33,   33,   33,   33,   33,   33,   33,   33,   33,   33,
			   33,   33,   33,   33,   33,   33,   33,   33,   33,   33,
			   34,   34,  221,   36,   34,   40,   36,   34,   36,   39,
			   34,   40,   39,   34,   41,   74,   39,   39,   36,  220,
			   41,   92,   39,  201,   92,  219,  201,   78,   50,   78,
			   78,  218,   34,   34,   50,   36,   34,   40,   36,   34,
			   36,   39,   34,   40,   39,   34,   41,   74,   39,   39,
			   36,   42,   41,   45,   39,   46,   46,   45,   42,   60,
			   50,   42,   48,   42,   75,   46,   50,   42,   45,   60,
			   48,  217,   57,  216,   65,  202,   48,   57,  202,   57,

			   65,  214,   78,   42,   57,   45,  213,   46,   46,   45,
			   42,   60,   70,   42,   48,   42,   75,   46,  212,   42,
			   45,   60,   48,   61,   57,   61,   65,   70,   48,   57,
			   59,   57,   65,   78,   59,   61,   57,   59,   67,   64,
			   59,   62,   73,   59,   70,   62,   64,   64,   67,  114,
			   67,   71,   64,  120,   67,   61,   73,   61,   62,   70,
			   86,   71,   59,   86,  211,  203,   59,   61,  203,   59,
			   67,   64,   59,   62,   73,   59,  210,   62,   64,   64,
			   67,  114,   67,   71,   64,  120,   67,  199,   73,   79,
			   62,   79,   79,   71,   83,   93,   83,   83,   84,   82,

			   84,   84,   89,  205,   89,   89,  205,   89,   86,   90,
			   89,   90,   90,   81,   90,   80,  122,   90,   99,   99,
			   99,  102,  102,  102,  103,   77,  103,  103,  103,   53,
			  347,   99,  118,  347,  102,  104,  103,  104,  104,  104,
			   86,  115,  118,   52,   79,  115,  117,  116,  122,   83,
			  116,  117,   31,   84,  123,   89,   26,   99,    9,  107,
			  107,  107,   90,   99,  118,  103,  102,  121,  103,  125,
			  121,    6,  130,  115,  118,   79,  104,  115,  117,  116,
			   83,  130,  116,  117,   84,   88,  123,   89,   88,   88,
			   88,   88,  348,    3,   90,  348,    0,   88,  107,  121,

			    0,  125,  121,   88,  130,   88,  128,   88,   88,   88,
			    0,  128,   88,  130,   88,  215,  215,  215,   88,    0,
			   88,    0,    0,   88,   88,   88,   88,   88,   88,   94,
			    0,  124,   94,   94,   94,   94,    0,    0,  128,    0,
			    0,   94,  124,  128,  126,  131,  129,   94,  126,   94,
			  129,   94,   94,   94,   94,  132,   94,  127,   94,  133,
			  134,  135,   94,  124,   94,  127,  137,   94,   94,   94,
			   94,   94,   94,    0,  124,    0,  126,  131,  129,  136,
			  126,  138,  129,  136,  140,  138,  136,  132,  143,  127,
			  141,  133,  134,  135,  140,  141,  142,  127,  137,  144,

			  145,  149,  147,  142,  145,  141,  146,  142,  150,  146,
			  147,  136,  151,  138,  144,  136,  140,  138,  136,  148,
			  143,  152,  141,  153,  155,  148,  140,  141,  142,    0,
			  153,  144,  145,  149,  147,  142,  145,  141,  146,  142,
			  150,  146,  147,  154,  151,  157,  144,  154,  154,  162,
			  158,  148,    0,  152,  158,  153,  155,  148,  154,  163,
			  165,  154,  153,  164,  160,  158,  160,  169,  158,  170,
			  168,  163,  161,  166,  164,  154,  168,  157,  161,  154,
			  154,  162,  158,  166,  161,  171,  158,  172,  175,  167,
			  154,  163,  165,  154,  167,  164,  160,  158,  160,  169,

			  158,  170,  168,  163,  161,  166,  164,  174,  168,  179,
			  161,  174,  198,  198,  198,  166,  161,  171,  179,  172,
			  175,  167,    0,  181,  184,    0,  167,    0,    0,  185,
			  178,  180,  177,  178,  177,  180,  182,  178,    0,  174,
			  182,  179,  177,  174,  176,  177,  176,  177,  177,  176,
			  179,  198,    0,  189,  176,  181,  184,  176,  183,  176,
			  176,  185,  178,  180,  177,  178,  177,  180,  182,  178,
			  183,  190,  182,  191,  177,  188,  176,  177,  176,  177,
			  177,  176,  186,  187,  188,  189,  176,  186,  187,  176,
			  183,  176,  176,  192,  193,  194,  195,  192,  186,  187,

			    0,  242,  183,  190,  194,  191,  242,  188,  204,    0,
			    0,  204,    0,  243,  186,  187,  188,    0,    0,  186,
			  187,  204,  204,  204,    0,  192,  193,  194,  195,  192,
			  186,  187,  206,  242,  206,  206,  194,  206,  242,  207,
			  206,  207,  207,  577,  207,  243,  577,  207,  232,  232,
			  232,  233,    0,  233,  245,  577,  233,  233,  233,  246,
			    0,  232,  234,  234,  234,  236,  236,  236,  237,    0,
			  237,  248,    0,  237,  237,  237,  244,  238,  236,  238,
			  238,  238,  250,  251,  244,  206,  245,  232,  252,  238,
			  255,  246,  207,  232,  239,  257,  239,  239,  239,  241,

			  241,  241,  256,  248,  236,  254,    0,  259,  244,  261,
			  236,  254,  256,  258,  250,  251,  244,  206,  238,  262,
			  252,  238,  255,  260,  207,  263,  258,  257,  262,  265,
			  264,  260,  266,  265,  256,  239,  267,  254,  241,  259,
			  269,  261,  264,  254,  256,  258,  268,  270,  273,  275,
			  268,  262,  277,  275,  271,  260,  276,  263,  258,  274,
			  262,  265,  264,  260,  266,  265,  271,  274,  267,  279,
			  276,  281,  269,  274,  264,  285,    0,  278,  268,  270,
			  273,  275,  268,  280,  277,  275,  271,  278,  276,  282,
			  290,  274,  286,  282,  280,  283,  286,  284,  271,  274,

			  284,  279,  276,  281,  288,  274,  282,  285,  283,  278,
			  287,  288,  289,  291,  287,  280,  292,  293,  295,  278,
			  289,  282,  290,  296,  286,  282,  280,  283,  286,  284,
			  294,  296,  284,  298,  294,  299,  288,  300,  282,  303,
			  283,  304,  287,  288,  289,  291,  287,  297,  292,  293,
			  295,  302,  289,  307,  297,  296,  306,  302,  308,  309,
			  306,    0,  294,  296,  308,  298,  294,  299,  310,  300,
			  311,  303,  310,  304,  311,  313,  312,  316,  317,  297,
			  318,  319,  321,  302,  312,  307,  297,  313,  306,  302,
			  308,  309,  306,  314,  315,  324,  308,  320,  325,  314,

			  310,  322,  311,  315,  310,  322,  311,  313,  312,  316,
			  317,  314,  318,  319,  321,  320,  312,  326,  327,  313,
			  323,  329,  331,  334,  335,  314,  315,  324,  323,  320,
			  325,  314,  330,  322,  328,  315,  330,  322,  332,  328,
			  333,  336,  332,  314,  337,  338,  339,  320,  333,  326,
			  327,  341,  323,  329,  331,  334,  335,  340,  342,  343,
			  323,  344,  340,  342,  330,    0,  328,    0,  330,    0,
			  332,  328,  333,  336,  332,    0,  337,  338,  339,  350,
			  333,    0,  350,  341,  349,    0,    0,  349,    0,  340,
			  342,  343,    0,  344,  340,  342,  349,  349,  349,  349,

			  356,  356,  356,  356,  350,  373,  373,  373,  374,  374,
			  374,    0,  375,  375,  375,  376,  376,  376,  373,  377,
			  377,  377,  378,    0,  378,    0,    0,  378,  378,  378,
			  388,  387,  377,  379,  379,  379,  380,  380,  380,  381,
			  381,  381,  387,  382,  373,  382,  382,  382,  390,  392,
			  373,  375,  386,  386,  386,  382,  394,  383,  377,  383,
			  383,  383,  388,  387,  377,  389,    0,  391,  393,  391,
			  393,  396,  395,  397,  387,  389,  398,  397,  381,  399,
			  390,  392,  395,  400,  382,  401,  402,  382,  394,  401,
			  399,  386,  403,  404,  403,  406,  407,  389,  383,  391,

			  393,  391,  393,  396,  395,  397,  408,  389,  398,  397,
			  405,  399,  410,  413,  395,  400,  414,  401,  402,  405,
			  409,  401,  399,  412,  403,  404,  403,  406,  407,  409,
			  411,  415,  412,  416,  418,  411,  420,  417,  408,  421,
			  415,  417,  405,  422,  410,  413,  419,  422,  414,  424,
			  425,  405,  409,  426,  428,  412,  430,    0,  419,  427,
			  432,  409,  411,  415,  412,  416,  418,  411,  420,  417,
			  434,  421,  415,  417,  427,  422,  435,  438,  419,  422,
			  429,  424,  425,  431,  433,  426,  428,  431,  430,  429,
			  419,  427,  432,  433,  437,  439,  441,  437,  442,  441,

			  443,  445,  434,  446,  447,  448,  427,  447,  435,  438,
			  450,  449,  429,  445,  451,  431,  433,  452,  451,  431,
			  449,  429,  453,  454,  457,  433,  437,  439,  441,  437,
			  442,  441,  443,  445,  458,  446,  447,  448,  460,  447,
			  462,  455,  450,  449,  456,  445,  451,  456,  459,  452,
			  451,  461,  449,  455,  453,  454,  457,  461,  463,  464,
			  466,  465,  467,  469,  459,  472,  458,  463,  465,  473,
			  460,  471,  462,  455,  471,  474,  456,  476,  477,  456,
			  459,  473,  478,  461,  475,  455,  477,  475,  479,  461,
			  463,  464,  466,  465,  467,  469,  459,  472,  481,  463,

			  465,  473,    0,  471,    0,    0,  471,  474,    0,  476,
			  477,    0,  483,  473,  478,  483,  475,    0,  477,  475,
			  479,  485,  485,  485,  483,  483,  483,  483,    0,    0,
			  481,  486,  486,  486,  485,  487,  487,  487,  488,  488,
			  488,  489,  489,  489,  490,  490,  490,  497,  491,  491,
			  491,  492,  492,  492,  489,  493,  493,  493,  494,  494,
			  494,  495,  495,  495,  499,  502,  485,  503,  505,  496,
			  486,  496,  496,  496,  495,  507,  501,  508,    0,  497,
			  489,  501,  512,  513,  507,  509,  489,  491,  510,  509,
			  511,  516,  510,  515,  493,  511,  499,  502,  517,  503,

			  505,  517,  515,  518,  520,  522,  495,  507,  501,  508,
			  496,  524,    0,  501,  512,  513,  507,  509,  523,  526,
			  510,  509,  511,  516,  510,  515,  521,  511,  519,  523,
			  517,  521,  519,  517,  515,  518,  520,  522,  527,  525,
			  529,  530,  531,  524,  525,  532,  534,  531,  533,  529,
			  523,  526,  533,  535,  536,  537,  538,  540,  521,  539,
			  519,  523,  541,  521,  519,  539,  542,  543,  546,  548,
			  527,  525,  529,  530,  531,  549,  525,  532,  534,  531,
			  533,  529,  550,  552,  533,  535,  536,  537,  538,  540,
			  554,  539,  545,  547,  541,  556,  545,  539,  542,  543,

			  546,  548,  547,  555,  551,  553,  557,  549,  551,  553,
			  557,  558,  555,  560,  550,  552,  561,  564,  559,  563,
			  566,  567,  554,  565,  545,  547,  569,  556,  545,  559,
			  563,  565,  570,  572,  547,  555,  551,  553,  557,  573,
			  551,  553,  557,  558,  555,  560,  576,    0,  561,  564,
			  559,  563,  566,  567,  575,  565,  571,  582,  569,  575,
			  571,  559,  563,  565,  570,  572,    0,  579,    0,  579,
			    0,  573,  579,  579,  579,  580,  580,  580,  576,  581,
			  581,  581,    0,  582,  591,    0,  575,    0,  571,  582,
			    0,  575,  571,  583,  583,  583,  584,  584,  584,  585,

			  585,  585,  586,  586,  586,  594,  583,  587,  587,  587,
			  588,  588,  588,  589,  580,  589,  591,  593,  589,  589,
			  589,  590,  590,  590,  595,  596,  598,  600,  593,  599,
			  602,  596,  601,  603,  590,  584,  601,  594,  583,  605,
			  599,  607,  608,  609,  611,  607,  587,  612,  614,  593,
			  613,  615,  611,  618,  613,    0,  595,  596,  598,  600,
			  593,  599,  602,  596,  601,  603,  590,  620,  601,  622,
			  621,  605,  599,  607,  608,  609,  611,  607,  617,  612,
			  614,  621,  613,  615,  611,  618,  613,  619,  617,  623,
			  624,  626,  619,  627,  628,  625,  629,  630,  632,  620,

			  623,  622,  621,  625,  627,  634,  629,  631,  635,  633,
			  617,  637,  631,  621,  633,  637,  638,  639,  641,  619,
			  617,  623,  624,  626,  619,  627,  628,  625,  629,  630,
			  632,  643,  623,  646,  645,  625,  627,  634,  629,  631,
			  635,  633,  648,  637,  631,  645,  633,  637,  638,  639,
			  641,  647,  649,  651,  652,    0,  647,  653,  653,  653,
			  654,  654,  654,  643,  651,  646,  645,  655,  655,  655,
			  658,  658,  658,  656,  648,  656,  660,  645,  656,  656,
			  656,    0,    0,  647,  649,  651,  652,  657,  647,  657,
			  667,  670,  657,  657,  657,  669,  651,  659,  659,  659,

			  669,  671,  660,  661,  661,  661,  674,  676,  660,  658,
			  662,  662,  662,  663,  663,  663,  665,  665,  665,  666,
			  678,  666,  667,  670,  666,  666,  666,  669,  679,  665,
			  673,  675,  669,  671,  677,  673,  675,  677,  674,  676,
			  681,  683,  684,  683,  685,  687,  689,  690,  692,  691,
			  693,  689,  678,  691,  694,  665,  693,  696,  697,    0,
			  679,  665,  673,  675,  697,  698,  677,  673,  675,  677,
			  699,  702,  681,  683,  684,  683,  685,  687,  689,  690,
			  692,  691,  693,  689,  704,  691,  694,  695,  693,  696,
			  697,  695,  705,  718,  701,  703,  697,  698,  701,  703,

			    0,  720,  699,  702,  708,  708,  708,  709,  709,  709,
			  710,  710,  710,  711,  711,  711,  704,    0,  722,  695,
			  712,  712,  712,  695,  705,  718,  701,  703,  724,  726,
			  701,  703,  713,  720,  713,  729,  730,  713,  713,  713,
			  715,  715,  715,  716,  716,  716,  709,  717,  717,  717,
			  722,  728,  733,  715,    0,  732,  734,  737,  738,  736,
			  724,  726,  728,  736,  732,  740,  747,  729,  730,  742,
			  742,  742,  744,  744,  744,  745,  745,  745,  749,  715,
			  746,  746,  746,  728,  733,  715,  717,  732,  734,  737,
			  738,  736,  751,    0,  728,  736,  732,  740,  747,  753,

			  753,  753,  766,  766,  766,  767,  767,  767,  742,    0,
			  749,  767,    0,    0,  745,    0,    0,    0,    0,  746,
			  756,    0,    0,    0,  751,    0,  756,  756,  756,  756,
			  756,  756,  756,  756,  756,  756,  756,    0,  753,  755,
			  755,    0,  755,  755,  755,  755,  755,  755,  755,  755,
			  755,  755,  755,  755,  755,  755,  757,  757,    0,  757,
			  757,  757,  757,  757,  757,  757,  757,  757,  757,  757,
			  757,  757,  757,  758,  758,    0,  758,  758,  758,  758,
			  758,  758,  758,  758,  758,  758,  758,  758,  758,  758,
			  759,  759,    0,  759,  759,    0,  759,  759,  759,  759,

			  759,  759,  759,  759,  759,  759,  759,  760,  760,    0,
			  760,  760,    0,    0,  760,  760,  760,  760,  760,  760,
			  760,  760,  760,  760,  761,  761,  761,  761,  761,  761,
			  761,  761,  761,  762,  762,    0,  762,  762,    0,  762,
			  762,  762,  762,  762,  762,  762,  762,  762,  762,  762,
			  763,  763,    0,  763,  763,  763,  763,  763,  763,  763,
			  763,  763,  763,  763,  763,  763,  763,  764,  764,    0,
			  764,  764,  764,  764,  764,  764,  764,  764,  764,  764,
			  764,  764,  764,  764,  765,  765,  765,  765,  765,  765,
			  765,    0,  765,  765,  765,  765,  765,  765,  765,  765,

			  765,  768,  768,  768,  768,  768,  768,  768,    0,  768,
			  768,  768,  768,  768,  768,  768,  768,  768,  754,  754,
			  754,  754,  754,  754,  754,  754,  754,  754,  754,  754,
			  754,  754,  754,  754,  754,  754,  754,  754,  754,  754,
			  754,  754,  754,  754,  754,  754,  754,  754,  754,  754,
			  754,  754,  754,  754,  754,  754,  754,  754,  754,  754,
			  754,  754,  754,  754,  754,  754,  754,  754,  754,  754,
			  754,  754,  754,  754,  754,  754,  754,  754,  754,  754,
			  754,  754,  754,  754,  754,  754,  754,  754,  754,  754,
			  754,  754,  754,  754,  754,  754,  754,  754,  754,  754,

			  754,  754,  754,  754,  754,  754,  754, yy_Dummy>>)
		end

	yy_base_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,  593, 2518,   87,  568,   91,   95,  552,
			   91,    0, 2518,   95,   93, 2518, 2518, 2518, 2518, 2518,
			   89,   89,   89,  101,  106,  112,  530, 2518,   87, 2518,
			   91,  526,  166,  233,  284,   92,  286,  112,  100,  295,
			  288,  297,  341,  113,  105,  340,  339,  152,  353,  220,
			  311, 2518,  487,  522, 2518,  134,    0,  357,  103,  394,
			  346,  383,  412,    0,  405,  357,  149,  408,  212,  226,
			  379,  415,  219,  413,  299,  341, 2518,  518,  345,  487,
			  508,  506,  496,  492,  496, 2518,  453, 2518,  578,  500,
			  507,    0,  334,  484,  622,    0, 2518, 2518, 2518,  498,

			 2518, 2518,  501,  506,  517, 2518,    0,  539, 2518, 2518,
			 2518, 2518, 2518, 2518,  412,  508,  510,  514,  495,    0,
			  420,  530,  484,  507,  594,  521,  611,  628,  569,  613,
			  535,  612,  626,  617,  627,  615,  649,  629,  651,    0,
			  647,  658,  659,  641,  667,  656,  669,  673,  682,  661,
			  679,  669,  684,  686,  711,  687,    0,  701,  718,    0,
			  727,  741,  710,  728,  726,  712,  736,  757,  739,  730,
			  722,  753,  756,    0,  774,  755,  812,  800,  793,  772,
			  791,  777,  803,  821,  791,  780,  850,  851,  838,  816,
			  825,  836,  860,  861,  858,  850, 2518, 2518,  792,  476,

			 2518,  336,  388,  458,  901,  496,  930,  937, 2518, 2518,
			  465,  453,  407,  395,  390,  595,  382,  380,  340,  334,
			  328,  311,  249,  212,  211,  173,  169,  165,  155,  153,
			  151,  140,  928,  936,  942, 2518,  945,  953,  959,  976,
			   88,  979,  864,  871,  947,  917,  930,    0,  934,    0,
			  945,  946,  951,    0,  974,  959,  965,  948,  976,  957,
			  994,  980,  982,  979,  993,  996,  983, 1003, 1013, 1007,
			 1010, 1017,    0,  999, 1030, 1016, 1027, 1019, 1040, 1022,
			 1046, 1023, 1052, 1054, 1060, 1035, 1059, 1077, 1067, 1083,
			 1057, 1080, 1072, 1088, 1097, 1085, 1094, 1110, 1104, 1091,

			 1100,    0, 1114, 1096, 1104,    0, 1123, 1120, 1127, 1128,
			 1135, 1137, 1147, 1138, 1162, 1157, 1144, 1145, 1151, 1132,
			 1166, 1136, 1168, 1191, 1162, 1169, 1180, 1181, 1197, 1179,
			 1199, 1189, 1205, 1203, 1186, 1191, 1196, 1207, 1208, 1209,
			 1225, 1219, 1221, 1217, 1224,    0, 2518,  523,  585, 1277,
			 1272, 2518, 2518, 2518, 2518, 2518, 1281, 2518, 2518, 2518,
			 2518, 2518, 2518, 2518, 2518, 2518, 2518, 2518, 2518, 2518,
			 2518, 2518, 2518, 1285, 1288, 1292, 1295, 1299, 1307, 1313,
			 1316, 1319, 1325, 1339,   84,   80, 1332, 1294, 1282, 1328,
			 1301, 1332, 1314, 1331, 1317, 1335, 1324, 1340, 1343, 1342,

			 1335, 1352, 1353, 1357, 1358, 1373, 1349, 1359, 1369, 1383,
			 1366, 1393, 1386, 1371, 1370, 1394, 1387, 1404, 1401, 1409,
			 1387, 1402, 1410,    0, 1416, 1413, 1416, 1422, 1402, 1443,
			 1410, 1450, 1427, 1447, 1424, 1439,    0, 1457, 1437, 1458,
			    0, 1459, 1458, 1463,    0, 1464, 1454, 1470, 1471, 1474,
			 1464, 1477, 1476, 1485, 1486, 1504, 1507, 1475, 1494, 1511,
			 1485, 1520, 1509, 1521, 1513, 1524, 1516, 1525,    0, 1526,
			    0, 1537, 1531, 1532, 1526, 1547, 1537, 1549, 1553, 1551,
			    0, 1561,    0, 1605,  109, 1601, 1611, 1615, 1618, 1621,
			 1624, 1628, 1631, 1635, 1638, 1641, 1651, 1610,    0, 1627,

			    0, 1639, 1623, 1630,    0, 1631,    0, 1638, 1631, 1652,
			 1655, 1653, 1640, 1646,    0, 1656, 1645, 1664, 1669, 1695,
			 1671, 1694, 1673, 1681, 1663, 1702, 1677, 1701,    0, 1703,
			 1695, 1705, 1703, 1715, 1713, 1716, 1717, 1718, 1719, 1728,
			 1726, 1725, 1729, 1730,    0, 1759, 1735, 1756, 1723, 1738,
			 1745, 1771, 1750, 1772, 1757, 1766, 1749, 1773, 1778, 1781,
			 1765, 1779,    0, 1782, 1769, 1794, 1791, 1784,    0, 1789,
			 1795, 1823, 1800, 1802,    0, 1817, 1804,  936, 2518, 1852,
			 1855, 1859, 1824, 1873, 1876, 1879, 1882, 1887, 1890, 1898,
			 1901, 1847,    0, 1880, 1857, 1887, 1888,    0, 1883, 1892,

			 1879, 1899, 1897, 1896,    0, 1902,    0, 1908, 1909, 1906,
			    0, 1915, 1918, 1917, 1915, 1914,    0, 1941, 1906, 1950,
			 1925, 1933, 1921, 1952, 1942, 1966, 1962, 1956, 1946, 1959,
			 1950, 1970, 1956, 1972, 1963, 1971,    0, 1978, 1983, 1980,
			    0, 1981,    0, 1994,    0, 1997, 1985, 2014, 2000, 2015,
			    0, 2016, 2006, 2037, 2040, 2047, 2058, 2072, 2050, 2077,
			 2043, 2083, 2090, 2093, 2518, 2096, 2104, 2053,    0, 2058,
			 2049, 2064,    0, 2098, 2074, 2099, 2075, 2097, 2080, 2091,
			    0, 2103,    0, 2106, 2107, 2107,    0, 2108,    0, 2109,
			 2105, 2116, 2115, 2113, 2111, 2154, 2124, 2127, 2134, 2133,

			    0, 2161, 2138, 2162, 2151, 2155,    0,   55, 2184, 2187,
			 2190, 2193, 2200, 2217,   35, 2220, 2223, 2227, 2156,    0,
			 2164,    0, 2181,    0, 2191,    0, 2192,    0, 2214, 2187,
			 2199,    0, 2218, 2206, 2219,    0, 2226, 2224, 2221,    0,
			 2228,    0, 2249,   31, 2252, 2255, 2260, 2229,    0, 2241,
			    0, 2255,    0, 2279, 2518, 2338, 2319, 2355, 2372, 2389,
			 2406, 2415, 2432, 2449, 2466, 2483, 2293, 2296, 2500, yy_Dummy>>)
		end

	yy_def_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,  754,    1,  754,  754,  754,  754,  754,  754,  754,
			  755,  756,  754,  757,  758,  754,  754,  754,  754,  754,
			  754,  754,  754,  754,  754,  754,  754,  754,  754,  754,
			  754,  754,  754,  754,   33,   33,   33,   33,   33,   33,
			   33,   33,   33,   33,   33,   33,   33,   33,   33,   33,
			   33,  754,  754,  759,  754,  754,  760,  761,  761,  761,
			  761,  761,  761,  761,  761,  761,  761,  761,  761,  761,
			  761,  761,  761,  761,  761,  761,  754,  762,  754,  754,
			  759,  762,  754,  754,  754,  754,  755,  754,  763,  755,
			  755,  756,  757,  764,  764,  764,  754,  754,  754,  754,

			  754,  754,  765,  754,  754,  754,  766,  754,  754,  754,
			  754,  754,  754,  754,   33,   33,   33,   33,   33,  761,
			  761,  761,  761,  761,   33,  761,   33,   33,   33,   33,
			   33,  761,  761,  761,  761,  761,   33,   33,  761,  761,
			   33,   33,   33,  761,  761,  761,   33,   33,   33,  761,
			  761,  761,   33,   33,   33,   33,  761,  761,  761,  761,
			   33,   33,  761,  761,   33,  761,   33,   33,   33,   33,
			  761,  761,  761,  761,   33,  761,   33,  761,   33,   33,
			  761,  761,   33,   33,  761,  761,   33,  761,   33,   33,
			  761,  761,   33,  761,   33,  761,  754,  754,  754,  760,

			  754,  763,  757,  757,  763,  763,  755,  755,  754,  754,
			  754,  754,  754,  754,  754,  754,  754,  754,  754,  754,
			  754,  754,  754,  754,  754,  754,  754,  754,  754,  754,
			  754,  754,  754,  754,  754,  754,  754,  754,  754,  754,
			  767,  754,   33,  761,   33,   33,  761,  761,   33,  761,
			   33,  761,   33,  761,   33,  761,   33,  761,   33,  761,
			   33,  761,   33,  761,   33,   33,  761,  761,   33,  761,
			   33,   33,  761,  761,   33,   33,  761,  761,   33,  761,
			   33,  761,   33,  761,   33,  761,   33,   33,   33,   33,
			  761,  761,  761,  761,   33,  761,   33,   33,  761,  761,

			   33,  761,   33,  761,   33,  761,   33,  761,   33,  761,
			   33,   33,   33,   33,   33,   33,  761,  761,  761,  761,
			  761,  761,   33,   33,  761,  761,   33,  761,   33,  761,
			   33,  761,   33,   33,   33,  761,  761,  761,   33,  761,
			   33,  761,   33,  761,   33,  761,  754,  763,  763,  763,
			  763,  754,  754,  754,  754,  754,  754,  754,  754,  754,
			  754,  754,  754,  754,  754,  754,  754,  754,  754,  754,
			  754,  754,  754,  754,  754,  754,  754,  754,  754,  754,
			  754,  754,  754,  754,  767,  767,  754,   33,  761,   33,
			  761,   33,  761,   33,  761,   33,  761,   33,  761,   33,

			  761,   33,  761,   33,  761,   33,  761,   33,  761,   33,
			  761,   33,   33,  761,  761,   33,  761,   33,  761,   33,
			  761,   33,   33,  761,  761,   33,  761,   33,  761,   33,
			  761,   33,  761,   33,  761,   33,  761,   33,  761,   33,
			  761,   33,  761,   33,  761,   33,  761,   33,  761,   33,
			  761,   33,  761,   33,  761,   33,   33,  761,  761,   33,
			  761,   33,  761,   33,  761,   33,  761,   33,  761,   33,
			  761,   33,  761,   33,  761,   33,  761,   33,  761,   33,
			  761,   33,  761,  763,  754,  754,  754,  754,  754,  754,
			  754,  754,  754,  754,  754,  765,  754,   33,  761,   33,

			  761,   33,  761,   33,  761,   33,  761,   33,  761,   33,
			  761,   33,  761,   33,  761,   33,  761,   33,  761,   33,
			  761,   33,  761,   33,  761,   33,  761,   33,  761,   33,
			  761,   33,  761,   33,  761,   33,  761,   33,  761,   33,
			  761,   33,  761,   33,  761,   33,  761,   33,  761,   33,
			  761,   33,  761,   33,  761,   33,  761,   33,  761,   33,
			  761,   33,  761,   33,  761,   33,  761,   33,  761,   33,
			  761,   33,  761,   33,  761,   33,  761,  763,  754,  754,
			  754,  754,  754,  754,  754,  754,  754,  754,  754,  754,
			  768,   33,  761,   33,  761,   33,   33,  761,  761,   33,

			  761,   33,  761,   33,  761,   33,  761,   33,  761,   33,
			  761,   33,  761,   33,  761,   33,  761,   33,  761,   33,
			  761,   33,  761,   33,  761,   33,  761,   33,  761,   33,
			  761,   33,  761,   33,  761,   33,  761,   33,  761,   33,
			  761,   33,  761,   33,  761,   33,  761,   33,  761,   33,
			  761,   33,  761,  754,  754,  754,  754,  754,  754,  754,
			  754,  754,  754,  754,  754,  754,  754,   33,  761,   33,
			  761,   33,  761,   33,  761,   33,  761,   33,  761,   33,
			  761,   33,  761,   33,  761,   33,  761,   33,  761,   33,
			  761,   33,  761,   33,  761,   33,  761,   33,  761,   33,

			  761,   33,  761,   33,  761,   33,  761,  754,  754,  754,
			  754,  754,  754,  754,  754,  754,  754,  754,   33,  761,
			   33,  761,   33,  761,   33,  761,   33,  761,   33,  761,
			   33,  761,   33,  761,   33,  761,   33,  761,   33,  761,
			   33,  761,  754,  754,  754,  754,  754,   33,  761,   33,
			  761,   33,  761,  754,    0,  754,  754,  754,  754,  754,
			  754,  754,  754,  754,  754,  754,  754,  754,  754, yy_Dummy>>)
		end

	yy_ec_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    1,    1,    1,    1,    1,    1,    1,    1,    2,
			    3,    1,    1,    4,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    5,    6,    7,    8,    9,   10,    8,   11,
			   12,   13,   14,   15,   16,   17,   18,   19,   20,   21,
			   22,   22,   22,   22,   22,   22,   22,   22,   23,   24,
			   25,   26,   27,   28,    8,   29,   30,   31,   32,   33,
			   34,   35,   36,   37,   38,   39,   40,   41,   42,   43,
			   44,   45,   46,   47,   48,   49,   50,   51,   52,   53,
			   54,   55,   56,   57,   58,   59,   60,   61,   62,   63,

			   64,   65,   66,   67,   68,   69,   70,   71,   72,   73,
			   74,   75,   76,   77,   78,   79,   80,   81,   82,   83,
			   84,   85,   86,   87,    8,   88,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,

			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1, yy_Dummy>>)
		end

	yy_meta_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    1,    2,    3,    2,    4,    1,    5,    1,    1,
			    6,    7,    1,    1,    1,    1,    1,    1,    8,    1,
			    9,   10,   11,    1,    1,    1,    1,    1,    1,    9,
			    9,    9,    9,    9,    9,   12,   12,   12,   12,   12,
			   12,   12,   12,   12,   12,   12,   12,   12,   12,   12,
			   12,   12,   12,   13,   14,    1,    1,    1,    1,   15,
			    1,    9,    9,    9,    9,    9,    9,   12,   12,   12,
			   12,   12,   12,   12,   12,   12,   12,   12,   12,   12,
			   12,   12,   12,   12,   12,   16,   17,    1,    1, yy_Dummy>>)
		end

	yy_accept_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    1,    1,    1,    2,    4,    7,    9,   12,   15,
			   18,   21,   24,   27,   30,   32,   35,   38,   41,   44,
			   47,   50,   53,   56,   60,   64,   68,   71,   74,   77,
			   80,   83,   85,   89,   93,   97,  101,  105,  109,  113,
			  117,  121,  125,  129,  133,  137,  141,  145,  149,  153,
			  157,  161,  164,  166,  169,  172,  175,  177,  180,  183,
			  186,  189,  192,  195,  198,  201,  204,  207,  210,  213,
			  216,  219,  222,  225,  228,  231,  234,  237,  240,  241,
			  241,  241,  241,  242,  243,  244,  245,  246,  247,  248,
			  251,  254,  255,  256,  257,  258,  259,  260,  261,  262,

			  264,  265,  266,  266,  268,  270,  271,  271,  272,  273,
			  274,  275,  276,  277,  278,  280,  282,  284,  286,  289,
			  290,  291,  292,  293,  295,  297,  298,  300,  302,  304,
			  306,  308,  309,  310,  311,  312,  313,  315,  318,  319,
			  321,  323,  325,  327,  328,  329,  330,  332,  334,  336,
			  337,  338,  339,  342,  344,  346,  349,  351,  352,  353,
			  355,  357,  359,  360,  361,  363,  364,  366,  368,  370,
			  373,  374,  375,  376,  378,  380,  381,  383,  384,  386,
			  388,  389,  390,  392,  394,  395,  396,  398,  399,  401,
			  403,  404,  405,  407,  408,  410,  411,  412,  413,  414,

			  414,  415,  415,  417,  419,  419,  419,  421,  423,  424,
			  426,  427,  428,  429,  430,  431,  432,  433,  434,  435,
			  436,  437,  438,  439,  440,  441,  442,  443,  444,  445,
			  446,  447,  448,  450,  450,  450,  451,  453,  454,  456,
			  458,  459,  460,  462,  463,  465,  468,  469,  471,  474,
			  476,  478,  479,  482,  484,  486,  487,  489,  490,  492,
			  493,  495,  496,  498,  499,  501,  503,  504,  505,  507,
			  508,  511,  513,  515,  516,  518,  520,  521,  522,  524,
			  525,  527,  528,  530,  531,  533,  534,  536,  538,  540,
			  542,  543,  544,  545,  546,  548,  549,  551,  553,  554,

			  555,  558,  560,  562,  563,  566,  568,  570,  571,  573,
			  574,  576,  578,  580,  582,  584,  586,  587,  588,  589,
			  590,  591,  592,  594,  596,  597,  598,  600,  601,  603,
			  604,  606,  607,  609,  611,  613,  614,  615,  616,  618,
			  619,  621,  622,  624,  625,  628,  630,  631,  632,  633,
			  633,  634,  635,  636,  637,  638,  639,  640,  641,  642,
			  643,  644,  645,  646,  647,  648,  649,  650,  651,  652,
			  653,  654,  655,  656,  658,  658,  660,  660,  662,  662,
			  662,  662,  664,  666,  668,  669,  669,  670,  672,  673,
			  675,  676,  678,  679,  681,  682,  684,  685,  687,  688,

			  690,  691,  693,  694,  696,  697,  699,  700,  703,  705,
			  707,  708,  710,  712,  713,  714,  716,  717,  719,  720,
			  722,  723,  726,  728,  730,  731,  733,  734,  736,  737,
			  739,  740,  742,  743,  745,  746,  749,  751,  753,  754,
			  757,  759,  761,  762,  765,  767,  769,  770,  772,  773,
			  775,  776,  778,  779,  781,  782,  784,  786,  787,  788,
			  790,  791,  793,  794,  796,  797,  799,  800,  803,  805,
			  808,  810,  812,  813,  815,  816,  818,  819,  821,  822,
			  825,  827,  830,  832,  832,  833,  834,  836,  836,  836,
			  838,  838,  842,  842,  844,  844,  844,  846,  849,  851,

			  854,  856,  858,  859,  862,  864,  867,  869,  871,  872,
			  874,  875,  877,  878,  881,  883,  885,  886,  888,  889,
			  891,  892,  894,  895,  897,  898,  900,  901,  904,  906,
			  908,  909,  911,  912,  914,  915,  917,  918,  920,  921,
			  923,  924,  926,  927,  930,  932,  934,  935,  937,  938,
			  940,  941,  943,  944,  946,  947,  949,  950,  952,  953,
			  955,  956,  959,  961,  963,  964,  966,  967,  970,  972,
			  974,  975,  977,  978,  981,  983,  985,  986,  986,  987,
			  987,  989,  989,  990,  991,  995,  995,  995,  997,  997,
			  998,  998, 1001, 1003, 1005, 1006, 1009, 1011, 1013, 1014,

			 1016, 1017, 1019, 1020, 1023, 1025, 1028, 1030, 1032, 1033,
			 1036, 1038, 1040, 1041, 1043, 1044, 1047, 1049, 1051, 1052,
			 1054, 1055, 1057, 1058, 1060, 1061, 1063, 1064, 1066, 1067,
			 1069, 1070, 1072, 1073, 1075, 1076, 1079, 1081, 1083, 1084,
			 1087, 1089, 1092, 1094, 1097, 1099, 1101, 1102, 1104, 1105,
			 1108, 1110, 1112, 1113, 1113, 1114, 1114, 1114, 1114, 1118,
			 1118, 1119, 1120, 1120, 1120, 1121, 1122, 1123, 1126, 1128,
			 1130, 1131, 1134, 1136, 1138, 1139, 1141, 1142, 1144, 1145,
			 1148, 1150, 1153, 1155, 1157, 1158, 1161, 1163, 1166, 1168,
			 1170, 1171, 1173, 1174, 1176, 1177, 1179, 1180, 1182, 1183,

			 1186, 1188, 1190, 1191, 1193, 1194, 1197, 1199, 1200, 1200,
			 1201, 1201, 1203, 1203, 1203, 1204, 1205, 1205, 1206, 1209,
			 1211, 1214, 1216, 1219, 1221, 1224, 1226, 1229, 1231, 1233,
			 1234, 1237, 1239, 1241, 1242, 1245, 1247, 1249, 1250, 1253,
			 1255, 1258, 1260, 1261, 1263, 1263, 1265, 1266, 1269, 1271,
			 1274, 1276, 1279, 1281, 1283, 1283, yy_Dummy>>)
		end

	yy_acclist_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,  149,  147,  148,    3,  147,  148,    4,  148,    1,
			  147,  148,    2,  147,  148,   10,  147,  148,  133,  147,
			  148,  102,  147,  148,   17,  147,  148,  133,  147,  148,
			  147,  148,   11,  147,  148,   12,  147,  148,   31,  147,
			  148,   30,  147,  148,    8,  147,  148,   29,  147,  148,
			    6,  147,  148,   32,  147,  148,  135,  139,  147,  148,
			  135,  139,  147,  148,  135,  139,  147,  148,    9,  147,
			  148,    7,  147,  148,   36,  147,  148,   34,  147,  148,
			   35,  147,  148,  147,  148,  100,  101,  147,  148,  100,
			  101,  147,  148,  100,  101,  147,  148,  100,  101,  147,

			  148,  100,  101,  147,  148,  100,  101,  147,  148,  100,
			  101,  147,  148,  100,  101,  147,  148,  100,  101,  147,
			  148,  100,  101,  147,  148,  100,  101,  147,  148,  100,
			  101,  147,  148,  100,  101,  147,  148,  100,  101,  147,
			  148,  100,  101,  147,  148,  100,  101,  147,  148,  100,
			  101,  147,  148,  100,  101,  147,  148,  100,  101,  147,
			  148,   15,  147,  148,  147,  148,   16,  147,  148,   33,
			  147,  148,  139,  147,  148,  147,  148,  101,  147,  148,
			  101,  147,  148,  101,  147,  148,  101,  147,  148,  101,
			  147,  148,  101,  147,  148,  101,  147,  148,  101,  147,

			  148,  101,  147,  148,  101,  147,  148,  101,  147,  148,
			  101,  147,  148,  101,  147,  148,  101,  147,  148,  101,
			  147,  148,  101,  147,  148,  101,  147,  148,  101,  147,
			  148,  101,  147,  148,   13,  147,  148,   14,  147,  148,
			    3,    4,    1,    2,   37,  133,  132,  132, -128,  133,
			 -276, -129,  133, -277,  102,  133,  126,  126,  126,    5,
			   23,   24,  142,  145,   18,   20,  135,  139,  135,  139,
			  134,  139,   28,   25,   22,   21,   26,   27,  100,  101,
			  100,  101,  100,  101,  100,  101,   42,  100,  101,  101,
			  101,  101,  101,   42,  101,  100,  101,  101,  100,  101,

			  100,  101,  100,  101,  100,  101,  100,  101,  101,  101,
			  101,  101,  101,  100,  101,   53,  100,  101,  101,   53,
			  101,  100,  101,  100,  101,  100,  101,  101,  101,  101,
			  100,  101,  100,  101,  100,  101,  101,  101,  101,   65,
			  100,  101,  100,  101,  100,  101,   71,  100,  101,   65,
			  101,  101,  101,   71,  101,  100,  101,  100,  101,  101,
			  101,  100,  101,  101,  100,  101,  100,  101,  100,  101,
			   79,  100,  101,  101,  101,  101,   79,  101,  100,  101,
			  101,  100,  101,  101,  100,  101,  100,  101,  101,  101,
			  100,  101,  100,  101,  101,  101,  100,  101,  101,  100,

			  101,  100,  101,  101,  101,  100,  101,  101,  100,  101,
			  101,   19,  130,  139,  131,  132,  133,  132,  133, -128,
			  133, -129,  133,  126,  103,  126,  126,  126,  126,  126,
			  126,  126,  126,  126,  126,  126,  126,  126,  126,  126,
			  126,  126,  126,  126,  126,  126,  126,  126,  142,  145,
			  140,  142,  145,  140,  135,  139,  135,  139,  137,  139,
			  100,  101,  101,  100,  101,   40,  100,  101,  101,   40,
			  101,   41,  100,  101,   41,  101,  100,  101,  101,   44,
			  100,  101,   44,  101,  100,  101,  101,  100,  101,  101,
			  100,  101,  101,  100,  101,  101,  100,  101,  101,  100,

			  101,  100,  101,  101,  101,  100,  101,  101,   56,  100,
			  101,  100,  101,   56,  101,  101,  100,  101,  100,  101,
			  101,  101,  100,  101,  101,  100,  101,  101,  100,  101,
			  101,  100,  101,  101,  100,  101,  100,  101,  100,  101,
			  100,  101,  101,  101,  101,  101,  100,  101,  101,  100,
			  101,  100,  101,  101,  101,   75,  100,  101,   75,  101,
			  100,  101,  101,   77,  100,  101,   77,  101,  100,  101,
			  101,  100,  101,  101,  100,  101,  100,  101,  100,  101,
			  100,  101,  100,  101,  100,  101,  101,  101,  101,  101,
			  101,  101,  100,  101,  100,  101,  101,  101,  100,  101,

			  101,  100,  101,  101,  100,  101,  101,  100,  101,  100,
			  101,  100,  101,  101,  101,  101,  100,  101,  101,  100,
			  101,  101,  100,  101,  101,   99,  100,  101,   99,  101,
			  146,  132,  132,  132,  120,  118,  119,  121,  122,  127,
			  123,  124,  104,  105,  106,  107,  108,  109,  110,  111,
			  112,  113,  114,  115,  116,  117,  142,  145,  142,  145,
			  142,  145,  141,  144,  135,  139,  135,  139,  138,  139,
			  100,  101,  101,  100,  101,  101,  100,  101,  101,  100,
			  101,  101,  100,  101,  101,  100,  101,  101,  100,  101,
			  101,  100,  101,  101,  100,  101,  101,  100,  101,  101,

			   54,  100,  101,   54,  101,  100,  101,  101,  100,  101,
			  100,  101,  101,  101,  100,  101,  101,  100,  101,  101,
			  100,  101,  101,   63,  100,  101,  100,  101,   63,  101,
			  101,  100,  101,  101,  100,  101,  101,  100,  101,  101,
			  100,  101,  101,  100,  101,  101,   72,  100,  101,   72,
			  101,  100,  101,  101,   74,  100,  101,   74,  101,  100,
			  101,  101,   78,  100,  101,   78,  101,  100,  101,  101,
			  100,  101,  101,  100,  101,  101,  100,  101,  101,  100,
			  101,  101,  100,  101,  100,  101,  101,  101,  100,  101,
			  101,  100,  101,  101,  100,  101,  101,  100,  101,  101,

			   91,  100,  101,   91,  101,   92,  100,  101,   92,  101,
			  100,  101,  101,  100,  101,  101,  100,  101,  101,  100,
			  101,  101,   97,  100,  101,   97,  101,   98,  100,  101,
			   98,  101,  127,  142,  142,  145,  142,  145,  141,  142,
			  144,  145,  141,  144,  136,  139,   38,  100,  101,   38,
			  101,   39,  100,  101,   39,  101,  100,  101,  101,   45,
			  100,  101,   45,  101,   46,  100,  101,   46,  101,  100,
			  101,  101,  100,  101,  101,  100,  101,  101,   51,  100,
			  101,   51,  101,  100,  101,  101,  100,  101,  101,  100,
			  101,  101,  100,  101,  101,  100,  101,  101,  100,  101,

			  101,   61,  100,  101,   61,  101,  100,  101,  101,  100,
			  101,  101,  100,  101,  101,  100,  101,  101,  100,  101,
			  101,  100,  101,  101,  100,  101,  101,   73,  100,  101,
			   73,  101,  100,  101,  101,  100,  101,  101,  100,  101,
			  101,  100,  101,  101,  100,  101,  101,  100,  101,  101,
			  100,  101,  101,  100,  101,  101,   87,  100,  101,   87,
			  101,  100,  101,  101,  100,  101,  101,   90,  100,  101,
			   90,  101,  100,  101,  101,  100,  101,  101,   95,  100,
			  101,   95,  101,  100,  101,  101,  125,  142,  145,  145,
			  142,  141,  142,  144,  145,  141,  144,  140,   43,  100,

			  101,   43,  101,  100,  101,  101,   48,  100,  101,  100,
			  101,   48,  101,  101,  100,  101,  101,  100,  101,  101,
			   55,  100,  101,   55,  101,   57,  100,  101,   57,  101,
			  100,  101,  101,   59,  100,  101,   59,  101,  100,  101,
			  101,  100,  101,  101,   64,  100,  101,   64,  101,  100,
			  101,  101,  100,  101,  101,  100,  101,  101,  100,  101,
			  101,  100,  101,  101,  100,  101,  101,  100,  101,  101,
			  100,  101,  101,  100,  101,  101,   83,  100,  101,   83,
			  101,  100,  101,  101,   85,  100,  101,   85,  101,   86,
			  100,  101,   86,  101,   88,  100,  101,   88,  101,  100,

			  101,  101,  100,  101,  101,   94,  100,  101,   94,  101,
			  100,  101,  101,  142,  141,  142,  144,  145,  145,  141,
			  143,  145,  143,   47,  100,  101,   47,  101,  100,  101,
			  101,   50,  100,  101,   50,  101,  100,  101,  101,  100,
			  101,  101,  100,  101,  101,   62,  100,  101,   62,  101,
			   66,  100,  101,   66,  101,  100,  101,  101,   68,  100,
			  101,   68,  101,   69,  100,  101,   69,  101,  100,  101,
			  101,  100,  101,  101,  100,  101,  101,  100,  101,  101,
			  100,  101,  101,   84,  100,  101,   84,  101,  100,  101,
			  101,  100,  101,  101,   96,  100,  101,   96,  101,  145,

			  145,  141,  142,  144,  145,  144,   49,  100,  101,   49,
			  101,   52,  100,  101,   52,  101,   58,  100,  101,   58,
			  101,   60,  100,  101,   60,  101,   67,  100,  101,   67,
			  101,  100,  101,  101,   76,  100,  101,   76,  101,  100,
			  101,  101,   82,  100,  101,   82,  101,  100,  101,  101,
			   89,  100,  101,   89,  101,   93,  100,  101,   93,  101,
			  145,  144,  145,  144,  145,  144,   70,  100,  101,   70,
			  101,   80,  100,  101,   80,  101,   81,  100,  101,   81,
			  101,  144,  145, yy_Dummy>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER is 2518
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER is 754
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER is 755
			-- Mark between normal states and templates

	yyNull_equiv_class: INTEGER is 1
			-- Equivalence code for NULL character

	yyReject_used: BOOLEAN is false
			-- Is `reject' called?

	yyVariable_trail_context: BOOLEAN is true
			-- Is there a regular expression with
			-- both leading and trailing parts having
			-- variable length?

	yyReject_or_variable_trail_context: BOOLEAN is true
			-- Is `reject' called or is there a
			-- regular expression with both leading
			-- and trailing parts having variable length?

	yyNb_rules: INTEGER is 148
			-- Number of rules

	yyEnd_of_buffer: INTEGER is 149
			-- End of buffer rule code

	yyLine_used: BOOLEAN is false
			-- Are line and column numbers used?

	yyPosition_used: BOOLEAN is false
			-- Is `position' used?

	INITIAL: INTEGER is 0
			-- Start condition codes

feature -- User-defined features


end -- EDITOR_EIFFEL_SCANNER
