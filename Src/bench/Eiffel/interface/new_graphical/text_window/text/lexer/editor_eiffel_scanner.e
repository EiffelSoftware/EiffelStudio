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
					
when 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96 then
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
										
when 97 then
--|#line 196 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 196")
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
										
when 98 then
--|#line 215 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 215")
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
										
when 99 then
--|#line 232 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 232")
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
										
when 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121 then
--|#line 251 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 251")
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
					
when 122 then
--|#line 286 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 286")
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
					
when 123, 124 then
--|#line 306 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 306")
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
					
when 125 then
--|#line 333 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 333")
end

					-- Verbatim string opener.				
				create {EDITOR_TOKEN_STRING} curr_token.make(text)
				update_token_list
				in_verbatim_string := True
			
when 126 then
--|#line 340 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 340")
end

					-- Verbatim string closer, possibly.				
				create {EDITOR_TOKEN_STRING} curr_token.make(text)
				update_token_list
				--if is_verbatim_string_closer then
					in_verbatim_string := False
				--end
			
when 127, 128 then
--|#line 349 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 349")
end

					-- Eiffel String
					if not in_comments then						
						create {EDITOR_TOKEN_STRING} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
when 129 then
--|#line 362 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 362")
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
					
when 130, 131, 132, 133 then
--|#line 379 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 379")
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
						
when 134 then
--|#line 396 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 396")
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
						
when 135 then
	yy_end := yy_end - 1
--|#line 413 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 413")
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
						
when 136, 137 then
--|#line 414 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 414")
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
						
when 138 then
	yy_end := yy_end - 1
--|#line 416 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 416")
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
						
when 139, 140 then
--|#line 417 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 417")
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
						
when 141 then
--|#line 438 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 438")
end

					create {EDITOR_TOKEN_TEXT} curr_token.make(text)
					update_token_list
					
when 142 then
--|#line 446 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 446")
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
				
when 143 then
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
			  584,   79,   79,   79,  494,   82,   79,   79,   86,   79,

			   83,   87,   86,   93,   94,   91,   95,   97,   99,   98,
			   98,   98,  108,  109,  487,  100,   96,  101,  113,  102,
			  102,  103,  101,  135,  102,  102,  103,  113,  101,  104,
			  103,  103,  103,  136,  104,  110,  111,  577,  191,  113,
			  124,  164,  113,  159,   80,  139,   88,  140,   80,  160,
			  118,  105,   80,  243,  243,  137,  175,  141,  106,  118,
			  113,  104,  386,  106,   86,  138,  104,   91,  386,  106,
			  192,  118,  124,  164,  118,  161,  386,  142,   88,  143,
			  373,  162,  372,  105,  113,  113,  113,  371,  176,  144,
			  174,  370,  118,  113,  113,  113,  113,  113,  113,  114,

			  113,  113,  113,  113,  115,  113,  116,  113,  113,  113,
			  113,  117,  113,  113,  113,  113,  113,  113,  113,  197,
			  197,  197,  174,  113,  176,  118,  118,  118,  118,  118,
			  118,  119,  118,  118,  118,  118,  120,  118,  121,  118,
			  118,  118,  118,  122,  118,  118,  118,  118,  118,  118,
			  118,  113,  113,  113,  113,  186,  176,  192,  197,  185,
			  113,  113,  113,  113,  113,  113,  113,  113,  123,  113,
			  113,  113,  113,  113,  113,  113,  113,  113,  113,  113,
			  113,  113,  113,  113,  113,  113,  118,  186,  194,  192,
			  113,  186,  118,  118,  118,  118,  118,  118,  118,  118,

			  124,  118,  118,  118,  118,  118,  118,  118,  118,  118,
			  118,  118,  118,  118,  118,  118,  118,  118,  125,  113,
			  194,  113,  126,  369,  113,  127,  145,  163,  128,  151,
			  146,  129,  113,  173,  113,  113,  152,  153,  368,  113,
			  177,  193,  154,  147,  113,   78,   86,   79,   79,   91,
			  130,  118,  113,  118,  131,  178,  118,  132,  148,  164,
			  133,  155,  149,  134,  118,  174,  118,  118,  156,  157,
			  165,  118,  179,  194,  158,  150,  118,  113,  181,  113,
			  166,  187,  167,  137,  118,  119,  168,  180,  182,  113,
			  120,  248,  121,  138,  130,  188,  113,  122,  131,  148,

			   80,  132,  169,  149,  133,   86,  367,  134,   87,  118,
			  183,  118,  170,  189,  171,  137,  150,  119,  172,  366,
			  184,  118,  120,  250,  121,  138,  130,  190,  118,  122,
			  131,  148,  142,  132,  143,  149,  133,  161,  155,  134,
			  169,  189,  179,  162,  144,  156,  157,  246,  150,  183,
			  170,  158,  171,   88,  250,  190,  172,  180,   79,  184,
			   79,   79,  122,  365,  142,   79,  143,   82,   79,  161,
			  155,  364,  169,  189,  179,  162,  144,  156,  157,  246,
			  363,  183,  170,  158,  171,   88,  250,  190,  172,  180,
			   79,  184,   79,   83,  122,  205,  206,  205,  205,  362,

			   86,  361,  101,   87,  242,  242,  242,  252,  235,  235,
			  235,  360,  113,   80,  239,  239,  239,  244,  244,  244,
			   80,  236,  254,  117,  359,  245,  358,  240,  247,  113,
			  101,  248,  241,  241,  242,  256,  356,   86,  345,  252,
			  349,   91,  104,  106,  118,   80,  200,  237,   88,  201,
			   85,   85,   85,  236,  254,  122,  197,  246,  202,  240,
			  249,  118,   86,  250,   85,  351,   85,  256,   85,   85,
			  203,  106,  251,   85,  104,   85,  113,  113,  258,   85,
			   88,   85,  255,  253,   85,   85,   85,   85,   85,   85,
			  249,  113,  257,  250,  204,  355,  113,  113,  357,  357,

			  357,  354,  260,  113,  252,  266,  259,  353,  118,  118,
			  258,  113,  276,   86,  256,  254,  349,  352,  197,  197,
			  197,  265,  249,  118,  258,  250,  204,  200,  118,  118,
			  208,   90,   90,   90,  260,  118,  343,  266,  260,  209,
			  113,  212,   81,  118,  276,   90,  279,   90,  261,   90,
			   90,  210,  262,  266,   90,  113,   90,  197,  345,  196,
			   90,  349,   90,  196,  195,   90,   90,   90,   90,   90,
			   90,  213,  118,  269,  214,  215,  216,  217,  280,  112,
			  263,  385,  385,  218,  264,  385,  263,  118,  270,  219,
			  264,  220,  267,  221,  222,  223,  224,  113,  225,  273,

			  226,  278,  280,  274,  227,  269,  228,  268,  113,  229,
			  230,  231,  232,  233,  234,  271,  113,  277,  263,  272,
			  270,  113,  264,  113,  269,  113,  275,  107,  281,  118,
			  113,  273,  282,  278,  280,  274,   84,   81,  292,  270,
			  118,  283,  113,  751,  291,  284,  113,  273,  118,  278,
			  287,  274,  298,  118,  288,  118,  285,  118,  276,  286,
			  282,  113,  118,  293,  282,  289,  113,  295,  290,  113,
			  292,  113,  297,  287,  118,  294,  292,  288,  118,  296,
			  301,  299,  287,  303,  298,  113,  288,  300,  289,  113,
			  302,  290,  304,  118,  306,  295,  751,  289,  118,  295,

			  290,  118,  305,  118,  298,  751,  113,  296,  377,  377,
			  377,  296,  302,  300,  321,  304,  324,  118,  322,  300,
			  751,  118,  302,  751,  304,  113,  306,  313,  319,  314,
			  326,  325,  320,  751,  306,  113,  113,  315,  118,  307,
			  316,  308,  317,  318,  113,  323,  321,  328,  324,  309,
			  322,  751,  310,  113,  311,  312,  751,  118,  337,  313,
			  321,  314,  326,  326,  322,  327,  336,  118,  118,  315,
			  338,  313,  316,  314,  317,  318,  118,  324,  329,  328,
			  113,  315,  340,  330,  316,  118,  317,  318,  332,  335,
			  338,  339,  113,  333,  331,  113,  342,  328,  336,  751,

			   86,  341,  338,  344,  334,  345,   86,  751,   87,  347,
			  332,  389,  118,  751,  340,  333,   86,  751,  751,  344,
			  332,  336,  751,  340,  118,  333,  334,  118,  342,  346,
			  346,  346,  751,  342,  751,  751,  334,  348,  206,  348,
			  348,  751,   86,  389,  375,  344,  375,  751,  204,  376,
			  376,  376,  751,   88,  204,  205,  206,  205,  205,   86,
			   86,  751,  349,   87,  204,  374,  374,  374,  378,  378,
			  378,  113,  350,  350,  350,  751,  751,  381,  236,  381,
			  204,  379,  382,  382,  382,   88,  204,  391,  393,  101,
			  204,  383,  383,  384,  390,  101,  204,  384,  384,  384,

			  113,  104,  113,  118,  237,  388,  392,  380,   88,  395,
			  236,  113,  113,  379,  387,  387,  387,  113,  397,  391,
			  393,  751,  204,  398,  396,  399,  391,  394,  401,  403,
			  106,  113,  118,  104,  118,  113,  106,  389,  393,  113,
			   88,  395,  404,  118,  118,  405,  113,  402,  400,  118,
			  397,  407,  113,  197,  406,  399,  397,  399,  113,  395,
			  401,  403,  409,  118,  113,  414,  415,  118,  412,  113,
			  417,  118,  419,  410,  405,  113,  408,  405,  118,  403,
			  401,  113,  413,  407,  118,  416,  407,  411,  113,  113,
			  118,  425,  113,  420,  409,  424,  118,  415,  415,  418,

			  412,  118,  417,  422,  419,  412,  421,  118,  409,  427,
			  429,  426,  431,  118,  413,  113,  423,  417,  428,  413,
			  118,  118,  113,  425,  118,  422,  113,  425,  432,  433,
			  434,  419,  435,  430,  113,  422,  113,  436,  423,  113,
			  437,  427,  429,  427,  431,  113,  438,  118,  423,  439,
			  429,  113,  441,  113,  118,  113,  443,  445,  118,  440,
			  433,  433,  435,  442,  435,  431,  118,  113,  118,  437,
			  444,  118,  437,  751,  447,  446,  113,  118,  439,  113,
			  113,  439,  448,  118,  441,  118,  113,  118,  443,  445,
			  450,  441,  452,  449,  451,  443,  113,  454,  113,  118,

			  453,  456,  445,  113,  459,  458,  447,  447,  118,  460,
			  461,  118,  118,  113,  449,  455,  463,  464,  118,  457,
			  465,  467,  451,  462,  453,  449,  451,  469,  118,  456,
			  118,  113,  453,  456,  113,  118,  459,  459,  474,  466,
			  468,  461,  461,  471,  113,  118,  470,  457,  463,  465,
			  113,  457,  465,  467,  113,  463,  473,  475,  476,  469,
			  477,  479,  472,  118,  478,  481,  118,  113,  113,  113,
			  475,  467,  469,  480,  345,  471,  118,  344,  471,  751,
			  751,  345,  118,  751,  344,  751,  118,  751,  473,  475,
			  477,  751,  477,  479,  473,   86,  479,  481,  344,  118,

			  118,  118,  485,  485,  485,  481,   85,   85,  482,  482,
			  482,  348,  206,  348,  348,  236,   86,  345,   86,  344,
			  349,  349,  204,  484,  357,  357,  357,  751,  751,  204,
			   90,  483,  483,  483,  376,  376,  376,  486,  486,  486,
			  751,  237,   90,  204,  488,  488,  488,  236,  751,  489,
			  489,  489,  751,  490,  204,  490,  751,  751,  491,  491,
			  491,  204,  379,  113,  204,  492,  492,  492,  382,  382,
			  382,  493,  493,  493,  497,  204,  487,  495,  751,  383,
			  383,  384,  495,  498,  384,  384,  384,  500,  380,  104,
			  496,  496,  496,  113,  379,  118,  204,  751,  113,  502,

			  501,  113,  504,  499,  505,  506,  498,  508,  113,  113,
			  494,  503,  509,  510,  512,  498,  113,  113,  197,  500,
			  507,  104,  511,  197,  113,  118,  513,  514,  515,  197,
			  118,  502,  502,  118,  504,  500,  506,  506,  516,  508,
			  118,  118,  113,  504,  510,  510,  512,  518,  118,  118,
			  113,  517,  508,  113,  512,  519,  118,  520,  514,  514,
			  516,  522,  521,  113,  524,  525,  526,  528,  113,  113,
			  516,  113,  523,  529,  118,  530,  531,  113,  532,  518,
			  527,  534,  118,  518,  536,  118,  537,  520,  538,  520,
			  113,  113,  751,  522,  522,  118,  524,  526,  526,  528,

			  118,  118,  113,  118,  524,  530,  533,  530,  532,  118,
			  532,  535,  528,  534,  540,  113,  536,  113,  538,  542,
			  538,  113,  118,  118,  539,  113,  113,  544,  541,  543,
			  113,  546,  113,  547,  118,  548,  113,  550,  534,  113,
			  552,  113,  553,  536,  545,  551,  540,  118,  549,  118,
			  554,  542,  113,  118,  113,  557,  540,  118,  118,  544,
			  542,  544,  118,  546,  118,  548,  555,  548,  118,  550,
			  556,  118,  552,  118,  554,  558,  546,  552,  113,  560,
			  550,  562,  554,  561,  118,  564,  118,  558,  113,  113,
			  566,  113,  113,  113,  559,  568,  113,  563,  556,  565,

			  567,  570,  556,  113,  572,  574,  113,  558,  569,  571,
			  118,  560,  113,  562,  113,  562,  751,  564,  113,  113,
			  118,  118,  566,  118,  118,  118,  560,  568,  118,  564,
			  751,  566,  568,  570,  573,  118,  572,  574,  118,  751,
			  570,  572,  113,  751,  118,   86,  118,  751,  344,   86,
			  118,  118,  349,  751,  485,  485,  485,   85,  575,  575,
			  575,   90,  576,  576,  576,  113,  574,  578,  579,  579,
			  579,  580,  580,  580,  118,  581,  581,  581,  582,  582,
			  582,  491,  491,  491,  751,  583,  583,  583,  585,  585,
			  585,  379,  751,  204,  586,  586,  586,  118,  113,  578,

			  587,  587,  587,  582,  582,  582,  589,  487,  197,  197,
			  197,  113,  591,  597,  592,  751,  588,  380,  593,  113,
			  590,  599,  594,  379,  584,  204,  595,  113,  113,  601,
			  118,  600,  596,  494,  113,  602,  603,  598,  605,  113,
			  607,  751,  609,  118,  591,  597,  594,  106,  588,  113,
			  595,  118,  591,  599,  594,  611,  613,  604,  595,  118,
			  118,  601,  113,  601,  597,  113,  118,  603,  603,  599,
			  605,  118,  607,  113,  609,  113,  606,  113,  608,  614,
			  615,  118,  612,  113,  610,  616,  617,  611,  613,  605,
			  618,  619,  620,  621,  118,  622,  623,  118,  113,  113,

			  624,  625,  627,  628,  113,  118,  629,  118,  607,  118,
			  609,  615,  615,  631,  613,  118,  611,  617,  617,  633,
			  113,  635,  619,  619,  621,  621,  637,  623,  623,  626,
			  118,  118,  625,  625,  627,  629,  118,  630,  629,  632,
			  113,  113,  636,  113,  113,  631,  113,  639,  113,  634,
			  641,  633,  118,  635,  113,  638,  642,  643,  637,  113,
			  644,  627,  645,  646,  113,  640,  647,  113,  113,  631,
			  649,  633,  118,  118,  637,  118,  118,  665,  118,  639,
			  118,  635,  641,  751,  113,  113,  118,  639,  643,  643,
			  648,  118,  645,  751,  645,  647,  118,  641,  647,  118,

			  118,   86,  649,   86,  344,  650,  349,  650,  653,  665,
			  651,  651,  651,   85,  751,   90,  118,  118,  651,  651,
			  651,  751,  649,  652,  652,  652,  582,  582,  582,  655,
			  655,  655,  113,  751,  237,  656,  656,  656,  666,  654,
			  653,  657,  657,  657,  658,  658,  658,  667,  669,  204,
			  659,  659,  659,  660,  113,  660,  113,  487,  658,  658,
			  658,  662,  662,  662,  118,  664,  671,  668,  584,  670,
			  667,  654,  113,  113,  663,  113,  673,  113,  672,  667,
			  669,  204,  113,  494,  674,  675,  118,  676,  118,  677,
			  113,  113,  113,  113,  679,  113,  681,  665,  671,  669,

			  680,  671,  113,  678,  118,  118,  663,  118,  673,  118,
			  673,  683,  685,  682,  118,  687,  675,  675,  113,  677,
			  113,  677,  118,  118,  118,  118,  679,  118,  681,  684,
			  686,  688,  681,  689,  118,  679,  113,  691,  113,  693,
			  695,  113,  697,  683,  685,  683,  690,  687,  113,  113,
			  118,  696,  118,  692,  694,  113,  113,  113,  113,  699,
			  701,  685,  687,  689,  113,  689,  113,  703,  118,  691,
			  118,  693,  695,  118,  697,  698,  113,  113,  691,  751,
			  118,  118,  700,  697,  113,  693,  695,  118,  118,  118,
			  118,  699,  701,  751,  716,  702,  118,  751,  118,  703,

			  651,  651,  651,  651,  651,  651,  751,  699,  118,  118,
			  704,  704,  704,  705,  701,  705,  118,  710,  706,  706,
			  706,  751,  113,  707,  751,  707,  716,  703,  708,  708,
			  708,  708,  708,  708,  709,  709,  709,  658,  658,  658,
			  711,  711,  711,  380,  658,  658,  658,  718,  720,  710,
			  712,  712,  712,  713,  118,  713,  113,  751,  714,  714,
			  714,  715,  717,  710,  719,  113,  722,  113,  721,  113,
			  584,  113,  113,  723,  724,  113,  113,  113,  113,  718,
			  720,  726,  727,  725,  728,  113,  113,  730,  118,  380,
			  732,  729,  751,  716,  718,  710,  720,  118,  722,  118,

			  722,  118,  734,  118,  118,  724,  724,  118,  118,  118,
			  118,  113,  736,  726,  728,  726,  728,  118,  118,  730,
			  731,  733,  732,  730,  113,  735,  737,  113,  738,  113,
			  113,  113,  751,  751,  734,  706,  706,  706,  739,  739,
			  739,  751,  751,  118,  736,  708,  708,  708,  708,  708,
			  708,  751,  732,  734,  751,  751,  118,  736,  738,  118,
			  738,  118,  118,  118,  740,  740,  740,  741,  113,  741,
			  113,  113,  742,  742,  742,  113,  113,  487,  657,  657,
			  657,  714,  714,  714,  113,  743,  743,  743,  745,  113,
			  113,  710,  751,  747,  113,  744,  749,  748,  113,  746,

			  118,  113,  118,  118,  113,  751,  751,  118,  118,  704,
			  704,  704,  742,  742,  742,  113,  118,  380,  113,  113,
			  745,  118,  118,  710,  494,  747,  118,  745,  749,  749,
			  118,  747,  751,  118,  751,  751,  118,  750,  750,  750,
			  711,  711,  711,  740,  740,  740,  751,  118,  487,  751,
			  118,  118,   85,   85,  751,   85,   85,   85,   85,   85,
			   85,   85,   85,   85,   85,   85,  118,  118,  118,  118,
			  118,  118,  751,  751,  751,  751,  584,   89,  751,  494,
			  751,  751,  584,   89,   89,   89,   89,   89,   89,   89,
			   89,   90,   90,  751,   90,   90,   90,   90,   90,   90,

			   90,   90,   90,   90,   90,   92,   92,  751,   92,   92,
			   92,   92,   92,   92,   92,   92,   92,   92,   92,   80,
			   80,  751,   80,   80,  751,   80,   80,   80,   80,   80,
			   80,   80,   80,  198,  198,  751,  198,  198,  751,  751,
			  198,  198,  198,  198,  198,  198,  198,  199,  199,  751,
			  199,  199,  199,  199,  199,  199,  199,  199,  199,  199,
			  199,  207,  207,  751,  207,  207,  207,  207,  207,  207,
			  207,  207,  207,  207,  207,  211,  211,  751,  211,  211,
			  211,  211,  211,  211,  211,  211,  211,  211,  211,  238,
			  238,  238,  238,  238,  238,  238,  751,  238,  238,  238,

			  238,  238,  238,  661,  661,  661,  661,  661,  661,  661,
			  751,  661,  661,  661,  661,  661,  661,    3,  751,  751,
			  751,  751,  751,  751,  751,  751,  751,  751,  751,  751,
			  751,  751,  751,  751,  751,  751,  751,  751,  751,  751,
			  751,  751,  751,  751,  751,  751,  751,  751,  751,  751,
			  751,  751,  751,  751,  751,  751,  751,  751,  751,  751,
			  751,  751,  751,  751,  751,  751,  751,  751,  751,  751,
			  751,  751,  751,  751,  751,  751,  751,  751,  751,  751,
			  751,  751,  751,  751,  751,  751,  751,  751,  751,  751,
			  751,  751,  751,  751,  751,  751,  751,  751,  751,  751,

			  751,  751,  751,  751,  751,  751, yy_Dummy>>)
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
			  740,    5,    5,    7,  711,    7,    7,    8,   10,    8,

			    8,   10,   13,   14,   14,   13,   20,   21,   22,   21,
			   21,   21,   28,   28,  704,   22,   20,   23,   38,   23,
			   23,   23,   24,   35,   24,   24,   24,   35,   25,   23,
			   25,   25,   25,   35,   24,   30,   30,  484,   49,   49,
			   58,   66,   36,   40,    5,   36,   10,   36,    7,   40,
			   38,   23,    8,  763,  763,   35,   44,   36,   23,   35,
			   44,   23,  386,   24,   90,   35,   24,   90,  385,   25,
			   49,   49,   58,   66,   36,   40,  243,   36,   10,   36,
			  234,   40,  233,   23,   32,   32,   32,  232,   44,   36,
			   68,  231,   44,   32,   32,   32,   32,   32,   32,   32,

			   32,   32,   32,   32,   32,   32,   32,   32,   32,   32,
			   32,   32,   32,   32,   32,   32,   32,   32,   32,   55,
			   55,   55,   68,   32,   69,   32,   32,   32,   32,   32,
			   32,   32,   32,   32,   32,   32,   32,   32,   32,   32,
			   32,   32,   32,   32,   32,   32,   32,   32,   32,   32,
			   32,   33,   33,   33,   47,   72,   69,   74,   55,   47,
			   33,   33,   33,   33,   33,   33,   33,   33,   33,   33,
			   33,   33,   33,   33,   33,   33,   33,   33,   33,   33,
			   33,   33,   33,   33,   33,   33,   47,   72,   75,   74,
			   33,   47,   33,   33,   33,   33,   33,   33,   33,   33,

			   33,   33,   33,   33,   33,   33,   33,   33,   33,   33,
			   33,   33,   33,   33,   33,   33,   33,   33,   34,   34,
			   75,   41,   34,  230,   43,   34,   37,   41,   34,   39,
			   37,   34,   39,   43,   37,   50,   39,   39,  229,  113,
			   45,   50,   39,   37,   45,   78,  200,   78,   78,  200,
			   34,   34,  117,   41,   34,   45,   43,   34,   37,   41,
			   34,   39,   37,   34,   39,   43,   37,   50,   39,   39,
			   42,  113,   45,   50,   39,   37,   45,   42,   46,   46,
			   42,   48,   42,   60,  117,   57,   42,   45,   46,   48,
			   57,  116,   57,   60,   59,   48,  116,   57,   59,   62,

			   78,   59,   42,   62,   59,   85,  228,   59,   85,   42,
			   46,   46,   42,   48,   42,   60,   62,   57,   42,  227,
			   46,   48,   57,  116,   57,   60,   59,   48,  116,   57,
			   59,   62,   61,   59,   61,   62,   59,   65,   64,   59,
			   67,   73,   70,   65,   61,   64,   64,  119,   62,   71,
			   67,   64,   67,   85,  121,   73,   67,   70,   79,   71,
			   79,   79,  124,  226,   61,   82,   61,   82,   82,   65,
			   64,  225,   67,   73,   70,   65,   61,   64,   64,  119,
			  224,   71,   67,   64,   67,   85,  121,   73,   67,   70,
			   83,   71,   83,   83,  124,   88,   88,   88,   88,  223,

			   88,  222,  103,   88,  103,  103,  103,  130,   98,   98,
			   98,  221,  123,   79,  101,  101,  101,  106,  106,  106,
			   82,   98,  131,  123,  220,  114,  219,  101,  115,  114,
			  102,  115,  102,  102,  102,  132,  217,  207,  208,  130,
			  207,  208,  102,  103,  123,   83,   87,   98,   88,   87,
			   87,   87,   87,   98,  131,  123,  106,  114,   87,  101,
			  115,  114,  210,  115,   87,  210,   87,  132,   87,   87,
			   87,  102,  125,   87,  102,   87,  125,  127,  133,   87,
			   88,   87,  127,  126,   87,   87,   87,   87,   87,   87,
			  120,  126,  128,  120,   87,  216,  128,  129,  218,  218,

			  218,  215,  134,  136,  125,  142,  129,  214,  125,  127,
			  133,  139,  148,  345,  127,  126,  345,  213,  197,  197,
			  197,  139,  120,  126,  128,  120,   87,   91,  128,  129,
			   91,   91,   91,   91,  134,  136,  198,  142,  129,   91,
			  147,   92,   81,  139,  148,   91,  147,   91,  135,   91,
			   91,   91,  135,  139,   91,  135,   91,  197,  349,   80,
			   91,  349,   91,   53,   52,   91,   91,   91,   91,   91,
			   91,   93,  147,  143,   93,   93,   93,   93,  147,   31,
			  135,  764,  764,   93,  135,  764,  137,  135,  143,   93,
			  137,   93,  140,   93,   93,   93,   93,  140,   93,  144,

			   93,  149,  150,  144,   93,  143,   93,  140,  141,   93,
			   93,   93,   93,   93,   93,  141,  151,  146,  137,  141,
			  143,  152,  137,  145,  140,  146,  145,   26,  152,  140,
			  154,  144,  156,  149,  150,  144,    9,    6,  161,  140,
			  141,  153,  159,    3,  159,  153,  153,  141,  151,  146,
			  157,  141,  164,  152,  157,  145,  153,  146,  145,  153,
			  152,  163,  154,  160,  156,  157,  168,  162,  157,  160,
			  161,  165,  163,  153,  159,  160,  159,  153,  153,  162,
			  166,  165,  157,  167,  164,  166,  157,  169,  153,  167,
			  170,  153,  171,  163,  174,  160,    0,  157,  168,  162,

			  157,  160,  173,  165,  163,    0,  173,  160,  237,  237,
			  237,  162,  166,  165,  179,  167,  180,  166,  179,  169,
			    0,  167,  170,    0,  171,  177,  174,  176,  177,  176,
			  183,  181,  177,    0,  173,  181,  178,  176,  173,  175,
			  176,  175,  176,  176,  175,  178,  179,  184,  180,  175,
			  179,    0,  175,  182,  175,  175,    0,  177,  188,  176,
			  177,  176,  183,  181,  177,  182,  189,  181,  178,  176,
			  190,  175,  176,  175,  176,  176,  175,  178,  185,  184,
			  187,  175,  192,  185,  175,  182,  175,  175,  186,  187,
			  188,  191,  193,  186,  185,  191,  194,  182,  189,    0,

			  199,  193,  190,  199,  186,  201,  203,    0,  201,  203,
			  185,  246,  187,    0,  192,  185,  202,    0,    0,  202,
			  186,  187,    0,  191,  193,  186,  185,  191,  194,  202,
			  202,  202,    0,  193,    0,    0,  186,  204,  204,  204,
			  204,    0,  204,  246,  236,  204,  236,    0,  199,  236,
			  236,  236,    0,  201,  203,  205,  205,  205,  205,  209,
			  205,    0,  209,  205,  202,  235,  235,  235,  239,  239,
			  239,  248,  209,  209,  209,    0,    0,  240,  235,  240,
			  199,  239,  240,  240,  240,  201,  203,  249,  252,  241,
			  204,  241,  241,  241,  247,  242,  202,  242,  242,  242,

			  245,  241,  247,  248,  235,  245,  251,  239,  205,  254,
			  235,  255,  251,  239,  244,  244,  244,  253,  256,  249,
			  252,    0,  204,  257,  255,  258,  247,  253,  260,  263,
			  241,  257,  245,  241,  247,  261,  242,  245,  251,  259,
			  205,  254,  262,  255,  251,  264,  262,  261,  259,  253,
			  256,  266,  267,  244,  265,  257,  255,  258,  265,  253,
			  260,  263,  270,  257,  268,  272,  274,  261,  273,  272,
			  276,  259,  278,  271,  262,  275,  268,  264,  262,  261,
			  259,  271,  273,  266,  267,  275,  265,  271,  277,  279,
			  265,  282,  281,  279,  270,  281,  268,  272,  274,  277,

			  273,  272,  276,  280,  278,  271,  279,  275,  268,  287,
			  288,  283,  289,  271,  273,  283,  280,  275,  284,  271,
			  277,  279,  284,  282,  281,  279,  285,  281,  286,  290,
			  291,  277,  292,  285,  291,  280,  286,  293,  279,  294,
			  295,  287,  288,  283,  289,  293,  294,  283,  280,  296,
			  284,  297,  300,  299,  284,  301,  304,  306,  285,  299,
			  286,  290,  291,  303,  292,  285,  291,  303,  286,  293,
			  305,  294,  295,    0,  313,  307,  305,  293,  294,  307,
			  310,  296,  308,  297,  300,  299,  308,  301,  304,  306,
			  309,  299,  310,  314,  315,  303,  312,  311,  309,  303,

			  316,  317,  305,  311,  318,  312,  313,  307,  305,  319,
			  321,  307,  310,  319,  308,  311,  322,  323,  308,  317,
			  324,  326,  309,  320,  310,  314,  315,  328,  312,  311,
			  309,  320,  316,  317,  325,  311,  318,  312,  331,  325,
			  327,  319,  321,  332,  327,  319,  329,  311,  322,  323,
			  329,  317,  324,  326,  330,  320,  333,  334,  335,  328,
			  336,  338,  330,  320,  337,  340,  325,  341,  339,  337,
			  331,  325,  327,  339,  344,  332,  327,  344,  329,    0,
			    0,  347,  329,    0,  347,    0,  330,    0,  333,  334,
			  335,    0,  336,  338,  330,  346,  337,  340,  346,  341,

			  339,  337,  374,  374,  374,  339,  347,  346,  346,  346,
			  346,  348,  348,  348,  348,  374,  348,  351,  350,  348,
			  351,  350,  344,  357,  357,  357,  357,    0,    0,  347,
			  350,  350,  350,  350,  375,  375,  375,  376,  376,  376,
			    0,  374,  351,  346,  377,  377,  377,  374,    0,  378,
			  378,  378,    0,  379,  344,  379,    0,    0,  379,  379,
			  379,  347,  378,  388,  348,  380,  380,  380,  381,  381,
			  381,  382,  382,  382,  388,  346,  376,  383,    0,  383,
			  383,  383,  384,  389,  384,  384,  384,  391,  378,  383,
			  387,  387,  387,  390,  378,  388,  348,    0,  392,  393,

			  392,  394,  395,  390,  396,  397,  388,  399,  396,  398,
			  382,  394,  400,  401,  403,  389,  400,  404,  383,  391,
			  398,  383,  402,  384,  402,  390,  404,  405,  406,  387,
			  392,  393,  392,  394,  395,  390,  396,  397,  407,  399,
			  396,  398,  408,  394,  400,  401,  403,  409,  400,  404,
			  410,  408,  398,  411,  402,  410,  402,  412,  404,  405,
			  406,  413,  411,  414,  415,  416,  417,  419,  418,  416,
			  407,  420,  414,  421,  408,  423,  424,  421,  425,  409,
			  418,  427,  410,  408,  429,  411,  430,  410,  431,  412,
			  430,  426,    0,  413,  411,  414,  415,  416,  417,  419,

			  418,  416,  428,  420,  414,  421,  426,  423,  424,  421,
			  425,  428,  418,  427,  433,  432,  429,  434,  430,  437,
			  431,  438,  430,  426,  432,  436,  440,  441,  436,  440,
			  442,  445,  444,  446,  428,  447,  446,  449,  426,  448,
			  451,  450,  452,  428,  444,  450,  433,  432,  448,  434,
			  453,  437,  455,  438,  454,  455,  432,  436,  440,  441,
			  436,  440,  442,  445,  444,  446,  454,  447,  446,  449,
			  456,  448,  451,  450,  452,  457,  444,  450,  458,  459,
			  448,  461,  453,  460,  455,  463,  454,  455,  462,  460,
			  465,  466,  464,  468,  458,  471,  472,  462,  454,  464,

			  470,  473,  456,  470,  475,  477,  474,  457,  472,  474,
			  458,  459,  478,  461,  480,  460,    0,  463,  497,  499,
			  462,  460,  465,  466,  464,  468,  458,  471,  472,  462,
			    0,  464,  470,  473,  476,  470,  475,  477,  474,    0,
			  472,  474,  476,    0,  478,  482,  480,    0,  482,  483,
			  497,  499,  483,    0,  485,  485,  485,  482,  482,  482,
			  482,  483,  483,  483,  483,  501,  476,  485,  486,  486,
			  486,  487,  487,  487,  476,  488,  488,  488,  489,  489,
			  489,  490,  490,  490,    0,  491,  491,  491,  492,  492,
			  492,  489,    0,  482,  493,  493,  493,  501,  503,  485,

			  494,  494,  494,  495,  495,  495,  496,  486,  496,  496,
			  496,  505,  506,  510,  507,    0,  495,  489,  507,  511,
			  505,  514,  508,  489,  491,  482,  508,  509,  513,  516,
			  503,  515,  509,  493,  515,  517,  518,  513,  520,  517,
			  522,    0,  524,  505,  506,  510,  507,  496,  495,  525,
			  507,  511,  505,  514,  508,  528,  530,  519,  508,  509,
			  513,  516,  519,  515,  509,  521,  515,  517,  518,  513,
			  520,  517,  522,  523,  524,  527,  521,  529,  523,  531,
			  532,  525,  529,  531,  527,  533,  534,  528,  530,  519,
			  535,  536,  537,  538,  519,  539,  540,  521,  537,  541,

			  543,  544,  546,  547,  543,  523,  548,  527,  521,  529,
			  523,  531,  532,  550,  529,  531,  527,  533,  534,  552,
			  545,  554,  535,  536,  537,  538,  556,  539,  540,  545,
			  537,  541,  543,  544,  546,  547,  543,  549,  548,  551,
			  553,  549,  555,  551,  557,  550,  555,  558,  559,  553,
			  562,  552,  545,  554,  561,  557,  563,  564,  556,  565,
			  567,  545,  568,  569,  563,  561,  570,  569,  571,  549,
			  574,  551,  553,  549,  555,  551,  557,  591,  555,  558,
			  559,  553,  562,    0,  592,  573,  561,  557,  563,  564,
			  573,  565,  567,    0,  568,  569,  563,  561,  570,  569,

			  571,  575,  574,  576,  575,  578,  576,  578,  581,  591,
			  578,  578,  578,  575,    0,  576,  592,  573,  579,  579,
			  579,    0,  573,  580,  580,  580,  582,  582,  582,  583,
			  583,  583,  593,    0,  581,  584,  584,  584,  593,  582,
			  581,  585,  585,  585,  586,  586,  586,  595,  597,  575,
			  587,  587,  587,  588,  590,  588,  596,  579,  588,  588,
			  588,  589,  589,  589,  593,  590,  599,  596,  583,  598,
			  593,  582,  600,  598,  589,  602,  605,  606,  604,  595,
			  597,  575,  604,  586,  608,  609,  590,  610,  596,  611,
			  612,  610,  608,  614,  615,  616,  617,  590,  599,  596,

			  616,  598,  618,  614,  600,  598,  589,  602,  605,  606,
			  604,  619,  621,  618,  604,  623,  608,  609,  620,  610,
			  624,  611,  612,  610,  608,  614,  615,  616,  617,  620,
			  622,  624,  616,  625,  618,  614,  626,  627,  622,  629,
			  631,  632,  635,  619,  621,  618,  626,  623,  628,  630,
			  620,  634,  624,  628,  630,  634,  636,  638,  640,  643,
			  645,  620,  622,  624,  642,  625,  646,  649,  626,  627,
			  622,  629,  631,  632,  635,  642,  664,  644,  626,    0,
			  628,  630,  644,  634,  648,  628,  630,  634,  636,  638,
			  640,  643,  645,    0,  667,  648,  642,    0,  646,  649,

			  650,  650,  650,  651,  651,  651,    0,  642,  664,  644,
			  652,  652,  652,  653,  644,  653,  648,  657,  653,  653,
			  653,    0,  668,  654,    0,  654,  667,  648,  654,  654,
			  654,  655,  655,  655,  656,  656,  656,  658,  658,  658,
			  659,  659,  659,  657,  660,  660,  660,  671,  673,  657,
			  662,  662,  662,  663,  668,  663,  666,    0,  663,  663,
			  663,  666,  670,  662,  672,  674,  675,  670,  674,  672,
			  655,  676,  678,  680,  681,  680,  682,  684,  686,  671,
			  673,  687,  688,  686,  689,  690,  688,  691,  666,  662,
			  693,  690,    0,  666,  670,  662,  672,  674,  675,  670,

			  674,  672,  695,  676,  678,  680,  681,  680,  682,  684,
			  686,  696,  699,  687,  688,  686,  689,  690,  688,  691,
			  692,  694,  693,  690,  692,  698,  700,  694,  701,  698,
			  700,  702,    0,    0,  695,  705,  705,  705,  706,  706,
			  706,    0,    0,  696,  699,  707,  707,  707,  708,  708,
			  708,    0,  692,  694,    0,    0,  692,  698,  700,  694,
			  701,  698,  700,  702,  709,  709,  709,  710,  715,  710,
			  717,  719,  710,  710,  710,  721,  723,  706,  712,  712,
			  712,  713,  713,  713,  725,  714,  714,  714,  726,  727,
			  729,  712,    0,  730,  731,  725,  734,  733,  735,  729,

			  715,  733,  717,  719,  737,    0,    0,  721,  723,  739,
			  739,  739,  741,  741,  741,  744,  725,  712,  746,  748,
			  726,  727,  729,  712,  714,  730,  731,  725,  734,  733,
			  735,  729,    0,  733,    0,    0,  737,  742,  742,  742,
			  743,  743,  743,  750,  750,  750,    0,  744,  739,    0,
			  746,  748,  752,  752,    0,  752,  752,  752,  752,  752,
			  752,  752,  752,  752,  752,  752,  758,  758,  758,  758,
			  758,  758,    0,    0,    0,    0,  742,  753,    0,  743,
			    0,    0,  750,  753,  753,  753,  753,  753,  753,  753,
			  753,  754,  754,    0,  754,  754,  754,  754,  754,  754,

			  754,  754,  754,  754,  754,  755,  755,    0,  755,  755,
			  755,  755,  755,  755,  755,  755,  755,  755,  755,  756,
			  756,    0,  756,  756,    0,  756,  756,  756,  756,  756,
			  756,  756,  756,  757,  757,    0,  757,  757,    0,    0,
			  757,  757,  757,  757,  757,  757,  757,  759,  759,    0,
			  759,  759,  759,  759,  759,  759,  759,  759,  759,  759,
			  759,  760,  760,    0,  760,  760,  760,  760,  760,  760,
			  760,  760,  760,  760,  760,  761,  761,    0,  761,  761,
			  761,  761,  761,  761,  761,  761,  761,  761,  761,  762,
			  762,  762,  762,  762,  762,  762,    0,  762,  762,  762,

			  762,  762,  762,  765,  765,  765,  765,  765,  765,  765,
			    0,  765,  765,  765,  765,  765,  765,  751,  751,  751,
			  751,  751,  751,  751,  751,  751,  751,  751,  751,  751,
			  751,  751,  751,  751,  751,  751,  751,  751,  751,  751,
			  751,  751,  751,  751,  751,  751,  751,  751,  751,  751,
			  751,  751,  751,  751,  751,  751,  751,  751,  751,  751,
			  751,  751,  751,  751,  751,  751,  751,  751,  751,  751,
			  751,  751,  751,  751,  751,  751,  751,  751,  751,  751,
			  751,  751,  751,  751,  751,  751,  751,  751,  751,  751,
			  751,  751,  751,  751,  751,  751,  751,  751,  751,  751,

			  751,  751,  751,  751,  751,  751, yy_Dummy>>)
		end

	yy_base_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,  743, 2517,   87,  734,   91,   95,  730,
			   91,    0, 2517,   95,   93, 2517, 2517, 2517, 2517, 2517,
			   89,   89,   89,   99,  104,  110,  701, 2517,   87, 2517,
			  109,  653,  164,  231,  282,   90,  105,  297,   81,  295,
			  106,  284,  340,  287,  123,  307,  342,  217,  352,  102,
			  298, 2517,  608,  656, 2517,  199,    0,  350,  103,  358,
			  350,  392,  370,    0,  404,  400,   98,  410,  144,  191,
			  409,  413,  213,  412,  221,  245, 2517, 2517,  343,  456,
			  652,  639,  463,  488, 2517,  398, 2517,  539,  493,    0,
			  157,  620,  630,  664,    0, 2517, 2517, 2517,  488, 2517,

			 2517,  494,  512,  484, 2517,    0,  497, 2517, 2517, 2517,
			 2517, 2517, 2517,  302,  492,  491,  359,  315,    0,  414,
			  553,  422,    0,  475,  414,  539,  554,  540,  559,  560,
			  474,  493,  493,  545,  556,  618,  566,  656,    0,  574,
			  660,  671,  558,  641,  655,  686,  688,  603,  572,  672,
			  659,  679,  684,  709,  693,    0,  688,  718,    0,  705,
			  732,  699,  736,  724,  704,  734,  748,  752,  729,  740,
			  758,  761,    0,  769,  761,  807,  795,  788,  799,  774,
			  770,  798,  816,  797,  798,  846,  856,  843,  821,  820,
			  833,  858,  849,  855,  850, 2517, 2517,  598,  625,  893,

			  339,  898,  909,  899,  935,  953, 2517,  530,  531,  952,
			  555, 2517, 2517,  606,  596,  590,  584,  525,  578,  515,
			  513,  500,  490,  488,  469,  460,  452,  408,  395,  327,
			  312,  180,  176,  171,  169,  945,  929,  788, 2517,  948,
			  962,  971,  977,  117,  994,  963,  869,  965,  934,  958,
			    0,  975,  957,  980,  962,  974,  968,  994,  996, 1002,
			  982,  998, 1009,  980, 1012, 1021, 1018, 1015, 1027,    0,
			 1013, 1044, 1032, 1039, 1033, 1038, 1023, 1051, 1024, 1052,
			 1062, 1055, 1051, 1078, 1085, 1089, 1099, 1076, 1077, 1068,
			 1100, 1097, 1099, 1108, 1102, 1111, 1105, 1114,    0, 1116,

			 1109, 1118,    0, 1130, 1123, 1139, 1126, 1142, 1149, 1161,
			 1143, 1166, 1159, 1141, 1160, 1165, 1151, 1170, 1158, 1176,
			 1194, 1177, 1187, 1180, 1183, 1197, 1179, 1207, 1194, 1213,
			 1217, 1201, 1210, 1211, 1220, 1221, 1223, 1232, 1229, 1231,
			 1223, 1230,    0, 2517, 1267,  606, 1288, 1274, 1309,  651,
			 1311, 1310, 2517, 2517, 2517, 2517, 2517, 1304, 2517, 2517,
			 2517, 2517, 2517, 2517, 2517, 2517, 2517, 2517, 2517, 2517,
			 2517, 2517, 2517, 2517, 1282, 1314, 1317, 1324, 1329, 1338,
			 1345, 1348, 1351, 1359, 1364,  109,  103, 1370, 1326, 1335,
			 1356, 1340, 1361, 1360, 1364, 1355, 1371, 1372, 1372, 1359,

			 1379, 1380, 1387, 1379, 1380, 1381, 1391, 1401, 1405, 1401,
			 1413, 1416, 1415, 1415, 1426, 1418, 1432, 1433, 1431, 1418,
			 1434, 1440,    0, 1442, 1439, 1441, 1454, 1429, 1465, 1438,
			 1453, 1455, 1478, 1468, 1480,    0, 1488, 1479, 1484,    0,
			 1489, 1487, 1493,    0, 1495, 1482, 1499, 1501, 1502, 1491,
			 1504, 1499, 1505, 1513, 1517, 1515, 1521, 1535, 1541, 1526,
			 1552, 1550, 1551, 1539, 1555, 1546, 1554,    0, 1556,    0,
			 1566, 1561, 1559, 1552, 1569, 1564, 1605, 1576, 1575,    0,
			 1577,    0, 1638, 1642,  126, 1634, 1648, 1651, 1655, 1658,
			 1661, 1665, 1668, 1674, 1680, 1683, 1688, 1581,    0, 1582,

			    0, 1628,    0, 1661,    0, 1674, 1666, 1681, 1689, 1690,
			 1671, 1682,    0, 1691, 1675, 1697, 1695, 1702, 1703, 1725,
			 1706, 1728, 1692, 1736, 1700, 1712,    0, 1738, 1709, 1740,
			 1714, 1746, 1747, 1748, 1749, 1753, 1754, 1761, 1762, 1758,
			 1759, 1762,    0, 1767, 1768, 1783, 1756, 1766, 1769, 1804,
			 1780, 1806, 1786, 1803, 1775, 1809, 1793, 1807, 1799, 1811,
			    0, 1817, 1802, 1827, 1828, 1822,    0, 1823, 1825, 1830,
			 1833, 1831,    0, 1848, 1828, 1894, 1896, 2517, 1890, 1898,
			 1903, 1875, 1906, 1909, 1915, 1921, 1924, 1930, 1938, 1941,
			 1917, 1829, 1847, 1895,    0, 1904, 1919, 1900, 1936, 1933,

			 1935,    0, 1938,    0, 1945, 1943, 1940,    0, 1955, 1956,
			 1954, 1956, 1953,    0, 1956, 1947, 1958, 1954, 1965, 1963,
			 1981, 1964, 2001, 1986, 1983, 1985, 1999, 1990, 2011, 1997,
			 2012, 1998, 2004,    0, 2018, 2009, 2019,    0, 2020,    0,
			 2021,    0, 2027, 2011, 2040, 2018, 2029,    0, 2047, 2019,
			 2080, 2083, 2090, 2098, 2108, 2111, 2114, 2084, 2117, 2120,
			 2124, 2517, 2130, 2138, 2039,    0, 2119, 2052, 2085,    0,
			 2130, 2115, 2132, 2116, 2128, 2126, 2134,    0, 2135,    0,
			 2138, 2139, 2139,    0, 2140,    0, 2141, 2139, 2149, 2151,
			 2148, 2144, 2187, 2157, 2190, 2171, 2174,    0, 2192, 2179,

			 2193, 2195, 2194,    0,   55, 2215, 2218, 2225, 2228, 2244,
			 2252,   35, 2258, 2261, 2265, 2231,    0, 2233,    0, 2234,
			    0, 2238,    0, 2239,    0, 2247, 2240, 2252,    0, 2253,
			 2247, 2257,    0, 2264, 2263, 2261,    0, 2267,    0, 2289,
			   31, 2292, 2317, 2320, 2278,    0, 2281,    0, 2282,    0,
			 2323, 2517, 2351, 2376, 2390, 2404, 2418, 2432, 2357, 2446,
			 2460, 2474, 2488,  144,  672, 2502, yy_Dummy>>)
		end

	yy_def_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,  751,    1,  751,  751,  751,  751,  751,  751,  751,
			  752,  753,  751,  754,  755,  751,  751,  751,  751,  751,
			  751,  751,  751,  751,  751,  751,  751,  751,  751,  751,
			  751,  751,  751,  751,   33,   33,   33,   33,   33,   33,
			   33,   33,   33,   33,   33,   33,   33,   33,   33,   33,
			   33,  751,  751,  756,  751,  751,  757,  758,  758,  758,
			  758,  758,  758,  758,  758,  758,  758,  758,  758,  758,
			  758,  758,  758,  758,  758,  758,  751,  751,  751,  751,
			  756,  751,  751,  751,  751,  752,  751,  759,  752,  753,
			  754,  760,  761,  761,  761,  751,  751,  751,  751,  751,

			  751,  762,  751,  751,  751,  763,  751,  751,  751,  751,
			  751,  751,  751,   33,   33,   33,   33,   33,  758,  758,
			  758,  758,  758,   33,  758,   33,   33,   33,   33,   33,
			  758,  758,  758,  758,  758,   33,   33,  758,  758,   33,
			   33,   33,  758,  758,  758,   33,   33,   33,  758,  758,
			  758,   33,   33,   33,   33,  758,  758,  758,  758,   33,
			   33,  758,  758,   33,  758,   33,   33,   33,   33,  758,
			  758,  758,  758,   33,  758,   33,  758,   33,   33,  758,
			  758,   33,   33,  758,  758,   33,  758,   33,   33,  758,
			  758,   33,  758,   33,  758,  751,  751,  751,  757,  759,

			  754,  752,  759,  759,  759,  752,  751,  760,  754,  760,
			  760,  751,  751,  751,  751,  751,  751,  751,  751,  751,
			  751,  751,  751,  751,  751,  751,  751,  751,  751,  751,
			  751,  751,  751,  751,  751,  751,  751,  751,  751,  751,
			  751,  751,  751,  764,  751,   33,  758,   33,   33,  758,
			  758,   33,  758,   33,  758,   33,  758,   33,  758,   33,
			  758,   33,   33,  758,  758,   33,  758,   33,   33,  758,
			  758,   33,   33,  758,  758,   33,  758,   33,  758,   33,
			  758,   33,  758,   33,   33,   33,   33,  758,  758,  758,
			  758,   33,  758,   33,   33,  758,  758,   33,  758,   33,

			  758,   33,  758,   33,  758,   33,  758,   33,   33,   33,
			   33,   33,   33,  758,  758,  758,  758,  758,  758,   33,
			   33,  758,  758,   33,  758,   33,  758,   33,  758,   33,
			   33,   33,  758,  758,  758,   33,  758,   33,  758,   33,
			  758,   33,  758,  751,  759,  760,  759,  759,  759,  760,
			  760,  760,  751,  751,  751,  751,  751,  751,  751,  751,
			  751,  751,  751,  751,  751,  751,  751,  751,  751,  751,
			  751,  751,  751,  751,  751,  751,  751,  751,  751,  751,
			  751,  751,  751,  751,  751,  764,  764,  751,   33,  758,
			   33,  758,   33,  758,   33,  758,   33,  758,   33,  758,

			   33,  758,   33,  758,   33,  758,   33,  758,   33,  758,
			   33,   33,  758,  758,   33,  758,   33,  758,   33,  758,
			   33,   33,  758,  758,   33,  758,   33,  758,   33,  758,
			   33,  758,   33,  758,   33,  758,   33,  758,   33,  758,
			   33,  758,   33,  758,   33,  758,   33,  758,   33,  758,
			   33,  758,   33,  758,   33,   33,  758,  758,   33,  758,
			   33,  758,   33,  758,   33,  758,   33,  758,   33,  758,
			   33,  758,   33,  758,   33,  758,   33,  758,   33,  758,
			   33,  758,  759,  760,  751,  751,  751,  751,  751,  751,
			  751,  751,  751,  751,  751,  762,  751,   33,  758,   33,

			  758,   33,  758,   33,  758,   33,  758,   33,  758,   33,
			  758,   33,  758,   33,  758,   33,  758,   33,  758,   33,
			  758,   33,  758,   33,  758,   33,  758,   33,  758,   33,
			  758,   33,  758,   33,  758,   33,  758,   33,  758,   33,
			  758,   33,  758,   33,  758,   33,  758,   33,  758,   33,
			  758,   33,  758,   33,  758,   33,  758,   33,  758,   33,
			  758,   33,  758,   33,  758,   33,  758,   33,  758,   33,
			  758,   33,  758,   33,  758,  759,  760,  751,  751,  751,
			  751,  751,  751,  751,  751,  751,  751,  751,  751,  765,
			   33,  758,   33,   33,  758,  758,   33,  758,   33,  758,

			   33,  758,   33,  758,   33,  758,   33,  758,   33,  758,
			   33,  758,   33,  758,   33,  758,   33,  758,   33,  758,
			   33,  758,   33,  758,   33,  758,   33,  758,   33,  758,
			   33,  758,   33,  758,   33,  758,   33,  758,   33,  758,
			   33,  758,   33,  758,   33,  758,   33,  758,   33,  758,
			  751,  751,  751,  751,  751,  751,  751,  751,  751,  751,
			  751,  751,  751,  751,   33,  758,   33,  758,   33,  758,
			   33,  758,   33,  758,   33,  758,   33,  758,   33,  758,
			   33,  758,   33,  758,   33,  758,   33,  758,   33,  758,
			   33,  758,   33,  758,   33,  758,   33,  758,   33,  758,

			   33,  758,   33,  758,  751,  751,  751,  751,  751,  751,
			  751,  751,  751,  751,  751,   33,  758,   33,  758,   33,
			  758,   33,  758,   33,  758,   33,  758,   33,  758,   33,
			  758,   33,  758,   33,  758,   33,  758,   33,  758,  751,
			  751,  751,  751,  751,   33,  758,   33,  758,   33,  758,
			  751,    0,  751,  751,  751,  751,  751,  751,  751,  751,
			  751,  751,  751,  751,  751,  751, yy_Dummy>>)
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
			    9,    9,   10,    1,    1,    1,    1,    1,    1,    9,
			    9,    9,    9,    9,    9,   11,   11,   11,   11,   11,
			   11,   11,   11,   11,   11,   11,   11,   11,   11,   11,
			   11,   11,   11,   11,   12,    1,    1,    1,    1,   13,
			    1,    9,    9,    9,    9,    9,    9,   11,   11,   11,
			   11,   11,   11,   11,   11,   11,   11,   11,   11,   11,
			   11,   11,   11,   11,   11,   11,   14,    1,    1, yy_Dummy>>)
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
			  241,  241,  242,  243,  244,  245,  246,  247,  248,  250,
			  251,  252,  253,  254,  255,  256,  257,  258,  259,  261,

			  262,  263,  263,  265,  267,  268,  268,  269,  270,  271,
			  272,  273,  274,  275,  277,  279,  281,  283,  286,  287,
			  288,  289,  290,  292,  294,  295,  297,  299,  301,  303,
			  305,  306,  307,  308,  309,  310,  312,  315,  316,  318,
			  320,  322,  324,  325,  326,  327,  329,  331,  333,  334,
			  335,  336,  339,  341,  343,  346,  348,  349,  350,  352,
			  354,  356,  357,  358,  360,  361,  363,  365,  367,  370,
			  371,  372,  373,  375,  377,  378,  380,  381,  383,  385,
			  386,  387,  389,  391,  392,  393,  395,  396,  398,  400,
			  401,  402,  404,  405,  407,  408,  409,  410,  411,  411,

			  411,  413,  415,  415,  415,  416,  417,  418,  418,  420,
			  420,  420,  421,  423,  424,  425,  426,  427,  428,  429,
			  430,  431,  432,  433,  434,  435,  436,  437,  438,  439,
			  440,  441,  442,  443,  444,  445,  447,  447,  447,  448,
			  450,  451,  453,  455,  456,  457,  459,  460,  462,  465,
			  466,  468,  470,  471,  473,  474,  476,  477,  479,  480,
			  482,  483,  485,  487,  488,  489,  491,  492,  495,  497,
			  499,  500,  502,  504,  505,  506,  508,  509,  511,  512,
			  514,  515,  517,  518,  520,  522,  524,  526,  527,  528,
			  529,  530,  532,  533,  535,  537,  538,  539,  542,  544,

			  546,  547,  550,  552,  554,  555,  557,  558,  560,  562,
			  564,  566,  568,  570,  571,  572,  573,  574,  575,  576,
			  578,  580,  581,  582,  584,  585,  587,  588,  590,  591,
			  593,  595,  597,  598,  599,  600,  602,  603,  605,  606,
			  608,  609,  612,  614,  615,  616,  617,  617,  618,  618,
			  619,  619,  620,  621,  622,  623,  624,  625,  626,  627,
			  628,  629,  630,  631,  632,  633,  634,  635,  636,  637,
			  638,  639,  640,  641,  642,  644,  644,  646,  646,  648,
			  648,  648,  648,  650,  652,  654,  655,  655,  656,  658,
			  659,  661,  662,  664,  665,  667,  668,  670,  671,  673,

			  674,  676,  677,  679,  680,  682,  683,  686,  688,  690,
			  691,  693,  695,  696,  697,  699,  700,  702,  703,  705,
			  706,  709,  711,  713,  714,  716,  717,  719,  720,  722,
			  723,  725,  726,  728,  729,  732,  734,  736,  737,  740,
			  742,  744,  745,  748,  750,  752,  753,  755,  756,  758,
			  759,  761,  762,  764,  765,  767,  769,  770,  771,  773,
			  774,  776,  777,  779,  780,  782,  783,  786,  788,  791,
			  793,  795,  796,  798,  799,  801,  802,  804,  805,  808,
			  810,  813,  815,  815,  815,  816,  817,  819,  819,  819,
			  821,  821,  825,  825,  827,  827,  827,  829,  832,  834,

			  837,  839,  842,  844,  847,  849,  851,  852,  854,  855,
			  857,  858,  861,  863,  865,  866,  868,  869,  871,  872,
			  874,  875,  877,  878,  880,  881,  884,  886,  888,  889,
			  891,  892,  894,  895,  897,  898,  900,  901,  903,  904,
			  906,  907,  910,  912,  914,  915,  917,  918,  920,  921,
			  923,  924,  926,  927,  929,  930,  932,  933,  935,  936,
			  939,  941,  943,  944,  946,  947,  950,  952,  954,  955,
			  957,  958,  961,  963,  965,  966,  966,  966,  967,  967,
			  969,  969,  970,  971,  975,  975,  975,  977,  977,  978,
			  978,  980,  981,  984,  986,  988,  989,  991,  992,  994,

			  995,  998, 1000, 1003, 1005, 1007, 1008, 1011, 1013, 1015,
			 1016, 1018, 1019, 1022, 1024, 1026, 1027, 1029, 1030, 1032,
			 1033, 1035, 1036, 1038, 1039, 1041, 1042, 1044, 1045, 1047,
			 1048, 1050, 1051, 1054, 1056, 1058, 1059, 1062, 1064, 1067,
			 1069, 1072, 1074, 1076, 1077, 1079, 1080, 1083, 1085, 1087,
			 1088, 1088, 1089, 1089, 1089, 1089, 1093, 1093, 1094, 1095,
			 1095, 1095, 1096, 1097, 1098, 1101, 1103, 1105, 1106, 1109,
			 1111, 1113, 1114, 1116, 1117, 1119, 1120, 1123, 1125, 1128,
			 1130, 1132, 1133, 1136, 1138, 1141, 1143, 1145, 1146, 1148,
			 1149, 1151, 1152, 1154, 1155, 1157, 1158, 1161, 1163, 1165,

			 1166, 1168, 1169, 1172, 1174, 1175, 1175, 1176, 1176, 1178,
			 1178, 1178, 1179, 1180, 1180, 1181, 1184, 1186, 1189, 1191,
			 1194, 1196, 1199, 1201, 1204, 1206, 1208, 1209, 1212, 1214,
			 1216, 1217, 1220, 1222, 1224, 1225, 1228, 1230, 1233, 1235,
			 1236, 1238, 1238, 1240, 1241, 1244, 1246, 1249, 1251, 1254,
			 1256, 1258, 1258, yy_Dummy>>)
		end

	yy_acclist_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,  144,  142,  143,    3,  142,  143,    4,  143,    1,
			  142,  143,    2,  142,  143,   10,  142,  143,  128,  142,
			  143,   99,  142,  143,   17,  142,  143,  128,  142,  143,
			  142,  143,   11,  142,  143,   12,  142,  143,   31,  142,
			  143,   30,  142,  143,    8,  142,  143,   29,  142,  143,
			    6,  142,  143,   32,  142,  143,  130,  134,  142,  143,
			  130,  134,  142,  143,  130,  134,  142,  143,    9,  142,
			  143,    7,  142,  143,   36,  142,  143,   34,  142,  143,
			   35,  142,  143,  142,  143,   97,   98,  142,  143,   97,
			   98,  142,  143,   97,   98,  142,  143,   97,   98,  142,

			  143,   97,   98,  142,  143,   97,   98,  142,  143,   97,
			   98,  142,  143,   97,   98,  142,  143,   97,   98,  142,
			  143,   97,   98,  142,  143,   97,   98,  142,  143,   97,
			   98,  142,  143,   97,   98,  142,  143,   97,   98,  142,
			  143,   97,   98,  142,  143,   97,   98,  142,  143,   97,
			   98,  142,  143,   97,   98,  142,  143,   97,   98,  142,
			  143,   15,  142,  143,  142,  143,   16,  142,  143,   33,
			  142,  143,  134,  142,  143,  142,  143,   98,  142,  143,
			   98,  142,  143,   98,  142,  143,   98,  142,  143,   98,
			  142,  143,   98,  142,  143,   98,  142,  143,   98,  142,

			  143,   98,  142,  143,   98,  142,  143,   98,  142,  143,
			   98,  142,  143,   98,  142,  143,   98,  142,  143,   98,
			  142,  143,   98,  142,  143,   98,  142,  143,   98,  142,
			  143,   98,  142,  143,   13,  142,  143,   14,  142,  143,
			    3,    4,    1,    2,   37,  128,  127,  127,  128, -268,
			   99,  128,  127,  123,  123,  123,    5,   23,   24,  137,
			  140,   18,   20,  130,  134,  130,  134,  129,  134,   28,
			   25,   22,   21,   26,   27,   97,   98,   97,   98,   97,
			   98,   97,   98,   41,   97,   98,   98,   98,   98,   98,
			   41,   98,   97,   98,   98,   97,   98,   97,   98,   97,

			   98,   97,   98,   97,   98,   98,   98,   98,   98,   98,
			   97,   98,   50,   97,   98,   98,   50,   98,   97,   98,
			   97,   98,   97,   98,   98,   98,   98,   97,   98,   97,
			   98,   97,   98,   98,   98,   98,   62,   97,   98,   97,
			   98,   97,   98,   68,   97,   98,   62,   98,   98,   98,
			   68,   98,   97,   98,   97,   98,   98,   98,   97,   98,
			   98,   97,   98,   97,   98,   97,   98,   76,   97,   98,
			   98,   98,   98,   76,   98,   97,   98,   98,   97,   98,
			   98,   97,   98,   97,   98,   98,   98,   97,   98,   97,
			   98,   98,   98,   97,   98,   98,   97,   98,   97,   98,

			   98,   98,   97,   98,   98,   97,   98,   98,   19,  126,
			  134,  127,  128,  127,  128, -268,  128, -125,  127,  128,
			  123,  100,  123,  123,  123,  123,  123,  123,  123,  123,
			  123,  123,  123,  123,  123,  123,  123,  123,  123,  123,
			  123,  123,  123,  123,  123,  137,  140,  135,  137,  140,
			  135,  130,  134,  130,  134,  132,  134,   97,   98,   98,
			   97,   98,   40,   97,   98,   98,   40,   98,   97,   98,
			   98,   97,   98,   98,   97,   98,   98,   97,   98,   98,
			   97,   98,   98,   97,   98,   97,   98,   98,   98,   97,
			   98,   98,   53,   97,   98,   97,   98,   53,   98,   98,

			   97,   98,   97,   98,   98,   98,   97,   98,   98,   97,
			   98,   98,   97,   98,   98,   97,   98,   98,   97,   98,
			   97,   98,   97,   98,   97,   98,   98,   98,   98,   98,
			   97,   98,   98,   97,   98,   97,   98,   98,   98,   72,
			   97,   98,   72,   98,   97,   98,   98,   74,   97,   98,
			   74,   98,   97,   98,   98,   97,   98,   98,   97,   98,
			   97,   98,   97,   98,   97,   98,   97,   98,   97,   98,
			   98,   98,   98,   98,   98,   98,   97,   98,   97,   98,
			   98,   98,   97,   98,   98,   97,   98,   98,   97,   98,
			   98,   97,   98,   97,   98,   97,   98,   98,   98,   98,

			   97,   98,   98,   97,   98,   98,   97,   98,   98,   96,
			   97,   98,   96,   98,  141,  127,  127,  127,  127,  127,
			  117,  115,  116,  118,  119,  124,  120,  121,  101,  102,
			  103,  104,  105,  106,  107,  108,  109,  110,  111,  112,
			  113,  114,  137,  140,  137,  140,  137,  140,  136,  139,
			  130,  134,  130,  134,  133,  134,   97,   98,   98,   97,
			   98,   98,   97,   98,   98,   97,   98,   98,   97,   98,
			   98,   97,   98,   98,   97,   98,   98,   97,   98,   98,
			   97,   98,   98,   51,   97,   98,   51,   98,   97,   98,
			   98,   97,   98,   97,   98,   98,   98,   97,   98,   98,

			   97,   98,   98,   97,   98,   98,   60,   97,   98,   97,
			   98,   60,   98,   98,   97,   98,   98,   97,   98,   98,
			   97,   98,   98,   97,   98,   98,   97,   98,   98,   69,
			   97,   98,   69,   98,   97,   98,   98,   71,   97,   98,
			   71,   98,   97,   98,   98,   75,   97,   98,   75,   98,
			   97,   98,   98,   97,   98,   98,   97,   98,   98,   97,
			   98,   98,   97,   98,   98,   97,   98,   97,   98,   98,
			   98,   97,   98,   98,   97,   98,   98,   97,   98,   98,
			   97,   98,   98,   88,   97,   98,   88,   98,   89,   97,
			   98,   89,   98,   97,   98,   98,   97,   98,   98,   97,

			   98,   98,   97,   98,   98,   94,   97,   98,   94,   98,
			   95,   97,   98,   95,   98,  124,  137,  137,  140,  137,
			  140,  136,  137,  139,  140,  136,  139,  131,  134,   38,
			   97,   98,   38,   98,   39,   97,   98,   39,   98,   42,
			   97,   98,   42,   98,   43,   97,   98,   43,   98,   97,
			   98,   98,   97,   98,   98,   97,   98,   98,   48,   97,
			   98,   48,   98,   97,   98,   98,   97,   98,   98,   97,
			   98,   98,   97,   98,   98,   97,   98,   98,   97,   98,
			   98,   58,   97,   98,   58,   98,   97,   98,   98,   97,
			   98,   98,   97,   98,   98,   97,   98,   98,   97,   98,

			   98,   97,   98,   98,   97,   98,   98,   70,   97,   98,
			   70,   98,   97,   98,   98,   97,   98,   98,   97,   98,
			   98,   97,   98,   98,   97,   98,   98,   97,   98,   98,
			   97,   98,   98,   97,   98,   98,   84,   97,   98,   84,
			   98,   97,   98,   98,   97,   98,   98,   87,   97,   98,
			   87,   98,   97,   98,   98,   97,   98,   98,   92,   97,
			   98,   92,   98,   97,   98,   98,  122,  137,  140,  140,
			  137,  136,  137,  139,  140,  136,  139,  135,   97,   98,
			   98,   45,   97,   98,   97,   98,   45,   98,   98,   97,
			   98,   98,   97,   98,   98,   52,   97,   98,   52,   98,

			   54,   97,   98,   54,   98,   97,   98,   98,   56,   97,
			   98,   56,   98,   97,   98,   98,   97,   98,   98,   61,
			   97,   98,   61,   98,   97,   98,   98,   97,   98,   98,
			   97,   98,   98,   97,   98,   98,   97,   98,   98,   97,
			   98,   98,   97,   98,   98,   97,   98,   98,   97,   98,
			   98,   80,   97,   98,   80,   98,   97,   98,   98,   82,
			   97,   98,   82,   98,   83,   97,   98,   83,   98,   85,
			   97,   98,   85,   98,   97,   98,   98,   97,   98,   98,
			   91,   97,   98,   91,   98,   97,   98,   98,  137,  136,
			  137,  139,  140,  140,  136,  138,  140,  138,   44,   97,

			   98,   44,   98,   97,   98,   98,   47,   97,   98,   47,
			   98,   97,   98,   98,   97,   98,   98,   97,   98,   98,
			   59,   97,   98,   59,   98,   63,   97,   98,   63,   98,
			   97,   98,   98,   65,   97,   98,   65,   98,   66,   97,
			   98,   66,   98,   97,   98,   98,   97,   98,   98,   97,
			   98,   98,   97,   98,   98,   97,   98,   98,   81,   97,
			   98,   81,   98,   97,   98,   98,   97,   98,   98,   93,
			   97,   98,   93,   98,  140,  140,  136,  137,  139,  140,
			  139,   46,   97,   98,   46,   98,   49,   97,   98,   49,
			   98,   55,   97,   98,   55,   98,   57,   97,   98,   57,

			   98,   64,   97,   98,   64,   98,   97,   98,   98,   73,
			   97,   98,   73,   98,   97,   98,   98,   79,   97,   98,
			   79,   98,   97,   98,   98,   86,   97,   98,   86,   98,
			   90,   97,   98,   90,   98,  140,  139,  140,  139,  140,
			  139,   67,   97,   98,   67,   98,   77,   97,   98,   77,
			   98,   78,   97,   98,   78,   98,  139,  140, yy_Dummy>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER is 2517
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER is 751
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER is 752
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

	yyNb_rules: INTEGER is 143
			-- Number of rules

	yyEnd_of_buffer: INTEGER is 144
			-- End of buffer rule code

	yyLine_used: BOOLEAN is false
			-- Are line and column numbers used?

	yyPosition_used: BOOLEAN is false
			-- Is `position' used?

	INITIAL: INTEGER is 0
			-- Start condition codes

feature -- User-defined features


end -- EDITOR_EIFFEL_SCANNER
