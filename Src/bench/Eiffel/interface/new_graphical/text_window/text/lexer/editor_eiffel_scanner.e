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
			  571,   79,   79,   79,  482,   82,   79,   79,   86,   79,

			   83,   87,   86,   92,   93,   87,   94,   96,   98,   97,
			   97,   97,  107,  108,  475,   99,   95,  100,  112,  101,
			  101,  102,  100,  134,  101,  101,  102,  112,  100,  103,
			  102,  102,  102,  135,  103,  109,  110,  564,  190,  112,
			  123,  163,  112,  158,   80,  138,   88,  139,   80,  159,
			  117,  104,   80,  236,  236,  136,  174,  140,  105,  117,
			  112,  103,  375,  105,   86,  137,  103,   87,  375,  105,
			  191,  117,  123,  163,  117,  160,  375,  141,  362,  142,
			  361,  161,  360,  104,  112,  112,  112,  359,  175,  143,
			  173,  358,  117,  112,  112,  112,  112,  112,  112,  113,

			  112,  112,  112,  112,  114,  112,  115,  112,  112,  112,
			  112,  116,  112,  112,  112,  112,  112,  112,  112,  196,
			  196,  196,  173,  112,  175,  117,  117,  117,  117,  117,
			  117,  118,  117,  117,  117,  117,  119,  117,  120,  117,
			  117,  117,  117,  121,  117,  117,  117,  117,  117,  117,
			  117,  112,  112,  112,  112,  185,  175,  191,  196,  184,
			  112,  112,  112,  112,  112,  112,  112,  112,  122,  112,
			  112,  112,  112,  112,  112,  112,  112,  112,  112,  112,
			  112,  112,  112,  112,  112,  112,  117,  185,  193,  191,
			  112,  185,  117,  117,  117,  117,  117,  117,  117,  117,

			  123,  117,  117,  117,  117,  117,  117,  117,  117,  117,
			  117,  117,  117,  117,  117,  117,  117,  117,  124,  112,
			  193,  112,  125,  357,  112,  126,  144,  162,  127,  150,
			  145,  128,  112,  172,  112,  112,  151,  152,  356,  112,
			  176,  192,  153,  146,  112,   78,   86,   79,   79,  337,
			  129,  117,  112,  117,  130,  177,  117,  131,  147,  163,
			  132,  154,  148,  133,  117,  173,  117,  117,  155,  156,
			  164,  117,  178,  193,  157,  149,  117,  112,  180,  112,
			  165,  186,  166,  136,  117,  118,  167,  179,  181,  112,
			  119,  241,  120,  137,  129,  187,  112,  121,  130,  147,

			   80,  131,  168,  148,  132,   86,  355,  133,   87,  117,
			  182,  117,  169,  188,  170,  136,  149,  118,  171,  354,
			  183,  117,  119,  243,  120,  137,  129,  189,  117,  121,
			  130,  147,  141,  131,  142,  148,  132,  160,  154,  133,
			  168,  188,  178,  161,  143,  155,  156,  239,  149,  182,
			  169,  157,  170,   88,  243,  189,  171,  179,   79,  183,
			   79,   79,  353,  121,  141,   79,  142,   82,   79,  160,
			  154,  352,  168,  188,  178,  161,  143,  155,  156,  239,
			  351,  182,  169,  157,  170,  350,  243,  189,  171,  179,
			   79,  183,   79,   83,  203,  121,  203,  203,  349,   86,

			  245,  112,   87,  228,  228,  228,  247,  238,  232,  232,
			  232,  112,  116,   80,  348,  100,  229,  234,  234,  235,
			   80,  233,  100,  249,  235,  235,  235,  103,  237,  237,
			  237,   86,  245,  117,   87,  346,  346,  346,  247,  239,
			  251,  347,  230,  117,  121,   80,  199,   88,  229,  200,
			   90,   90,   90,  233,  338,  249,  105,   87,  201,  103,
			  112,  345,  344,  105,   90,  248,   90,  196,   90,   90,
			  202,  240,  251,   90,  241,   90,  343,   86,  342,   90,
			  340,   90,  341,  336,   90,   90,   90,   90,   90,   90,
			  206,  205,  117,  207,  208,  209,  210,  249,  366,  366,

			  366,   81,  211,  242,  242,  244,  243,  243,  212,  112,
			  213,  112,  214,  215,  216,  217,  246,  218,  250,  219,
			  252,  253,  112,  220,  112,  221,  112,  259,  222,  223,
			  224,  225,  226,  227,  195,  195,  242,  245,  254,  243,
			  256,  117,  255,  117,  257,  112,  260,  112,  247,  262,
			  251,  112,  253,  253,  117,  112,  117,  258,  117,  259,
			  269,  261,  264,  266,  263,  112,  265,  267,  268,  112,
			  256,  271,  256,  273,  257,  272,  257,  117,  262,  117,
			  270,  262,  112,  117,  112,  112,  275,  117,  112,  259,
			  194,  274,  269,  263,  266,  266,  263,  117,  267,  267,

			  269,  117,  285,  271,  276,  273,  280,  273,  277,  112,
			  281,  112,  271,  284,  117,  288,  117,  117,  275,  278,
			  117,  282,  279,  275,  283,  286,  291,  289,  112,  296,
			  111,  112,  112,  293,  285,  112,  280,  287,  280,  290,
			  281,  117,  281,  117,  294,  285,  295,  288,  297,  112,
			  299,  282,  112,  282,  283,  317,  283,  288,  291,  289,
			  117,  297,  292,  117,  117,  293,  298,  117,  314,  289,
			  112,  291,  315,  106,  112,  306,  295,  307,  295,   84,
			  297,  117,  299,  316,  117,  308,   81,  317,  309,  112,
			  310,  311,  312,  318,  293,  319,  313,  112,  299,  112,

			  314,  321,  117,  300,  315,  301,  117,  306,  112,  307,
			  330,  320,  738,  302,  329,  317,  303,  308,  304,  305,
			  309,  117,  310,  311,  314,  319,  331,  319,  315,  117,
			  332,  117,  333,  321,  112,  306,  322,  307,  112,  325,
			  117,  323,  331,  321,  326,  308,  329,  328,  309,  335,
			  310,  311,  324,  378,  112,  327,  738,  738,  331,  196,
			  196,  196,  333,  334,  333,  112,  117,  738,  325,  738,
			  117,  325,  379,  326,  380,   86,  326,  738,  337,  329,
			  112,  335,  738,  738,  327,  378,  117,  327,  339,  339,
			  339,  203,  738,  203,  203,  335,   86,  117,  196,   87,

			  363,  363,  363,  364,  380,  364,  380,  738,  365,  365,
			  365,  738,  117,  229,  367,  367,  367,  370,  382,  370,
			  112,  738,  371,  371,  371,  377,  100,  368,  372,  372,
			  373,  100,  384,  373,  373,  373,  112,  381,  103,  230,
			  376,  376,  376,  112,   88,  229,  383,  738,  112,  386,
			  382,  388,  117,  369,  387,  390,  112,  378,  392,  368,
			  394,  385,  112,  738,  384,  389,  396,  105,  117,  382,
			  103,  112,  105,  112,  398,  117,  738,  112,  384,  196,
			  117,  386,  404,  388,  406,  391,  388,  390,  117,  397,
			  392,  393,  394,  386,  117,  112,  395,  390,  396,  399,

			  112,  401,  112,  117,  403,  117,  398,  112,  112,  117,
			  408,  112,  405,  400,  404,  402,  406,  392,  414,  738,
			  112,  398,  407,  394,  409,  411,  112,  117,  396,  413,
			  416,  401,  117,  401,  117,  738,  404,  410,  412,  117,
			  117,  112,  408,  117,  406,  402,  418,  402,  419,  415,
			  414,  417,  117,  112,  408,  112,  411,  411,  117,  421,
			  420,  414,  416,  422,  423,  424,  425,  112,  112,  412,
			  412,  426,  112,  117,  112,  428,  112,  430,  418,  427,
			  420,  416,  112,  418,  112,  117,  431,  117,  429,  432,
			  112,  422,  420,  434,  439,  422,  424,  424,  426,  117,

			  117,  435,  112,  426,  117,  112,  117,  428,  117,  430,
			  436,  428,  112,  433,  117,  738,  117,  438,  432,  112,
			  430,  432,  117,  437,  441,  434,  440,  112,  440,  443,
			  112,  442,  445,  436,  117,  112,  448,  117,  451,  447,
			  450,  452,  436,  453,  117,  434,  112,  444,  449,  438,
			  446,  117,  112,  454,  456,  438,  442,  458,  112,  117,
			  440,  445,  117,  442,  445,  463,  461,  117,  448,  112,
			  452,  448,  450,  452,  455,  454,  460,  457,  117,  446,
			  450,  112,  446,  459,  117,  454,  456,  112,  462,  458,
			  117,  464,  465,  466,  467,  468,  470,  464,  462,  112,

			  112,  117,  112,  738,  338,  469,  456,  337,  460,  458,
			  738,   86,  738,  117,  337,  460,  473,  473,  473,  117,
			  462,  486,  488,  464,  466,  466,  468,  468,  470,  229,
			   86,  117,  117,  337,  117,  338,  490,  470,  337,  365,
			  365,  365,   90,  471,  471,  471,  472,  346,  346,  346,
			  474,  474,  474,  486,  488,  230,  476,  476,  476,  738,
			   90,  229,  477,  477,  477,  478,  738,  478,  490,  738,
			  479,  479,  479,  738,  738,  368,  480,  480,  480,  371,
			  371,  371,  481,  481,  481,  484,  484,  484,  483,  475,
			  372,  372,  373,  483,  112,  373,  373,  373,  112,  112,

			  103,  369,  738,  492,  112,  485,  489,  368,  487,  491,
			  493,  494,  112,  496,  112,  497,  498,  500,  499,  112,
			  112,  482,  502,  495,  196,  503,  117,  504,  506,  196,
			  117,  117,  103,  738,  196,  492,  117,  486,  490,  508,
			  488,  492,  494,  494,  117,  496,  117,  498,  498,  500,
			  500,  117,  117,  112,  502,  496,  112,  504,  112,  504,
			  506,  112,  501,  507,  510,  505,  112,  512,  513,  514,
			  509,  508,  112,  516,  112,  511,  112,  517,  518,  519,
			  520,  112,  738,  522,  738,  117,  515,  524,  117,  738,
			  117,  526,  528,  117,  502,  508,  510,  506,  117,  512,

			  514,  514,  510,  112,  117,  516,  117,  512,  117,  518,
			  518,  520,  520,  117,  112,  522,  112,  525,  516,  524,
			  530,  112,  112,  526,  528,  523,  112,  112,  532,  521,
			  529,  527,  112,  112,  534,  117,  531,  535,  112,  536,
			  112,  538,  112,  112,  540,  541,  117,  539,  117,  526,
			  533,  537,  530,  117,  117,  542,  544,  524,  117,  117,
			  532,  522,  530,  528,  117,  117,  534,  546,  532,  536,
			  117,  536,  117,  538,  117,  117,  540,  542,  112,  540,
			  112,  112,  534,  538,  545,  548,  549,  542,  544,  550,
			  543,  112,  112,  552,  112,  554,  547,  112,  112,  546,

			  551,  553,  555,  556,  558,  112,  112,  112,  560,  559,
			  117,  562,  117,  117,  112,  112,  546,  548,  550,  557,
			  738,  550,  544,  117,  117,  552,  117,  554,  548,  117,
			  117,  738,  552,  554,  556,  556,  558,  117,  117,  117,
			  560,  560,  561,  562,  738,   86,  117,  117,  337,  112,
			  112,  558,  473,  473,  473,  112,  738,   90,  563,  563,
			  563,  566,  566,  566,  112,  565,  567,  567,  567,  568,
			  568,  568,  738,  738,  562,  569,  569,  569,  479,  479,
			  479,  117,  117,  570,  570,  570,  112,  117,  368,  572,
			  572,  572,  573,  573,  573,  578,  117,  565,  584,  738,

			  475,  574,  574,  574,  569,  569,  569,  576,  112,  196,
			  196,  196,  112,  583,  369,  579,  738,  575,  117,  580,
			  368,  577,  571,  112,  581,  112,  586,  578,  582,  587,
			  584,  482,  112,  588,  585,  589,  590,  591,  592,  112,
			  117,  112,  112,  594,  117,  584,  596,  581,  105,  575,
			  112,  582,  593,  578,  112,  117,  581,  117,  586,  595,
			  582,  588,  598,  112,  117,  588,  586,  590,  590,  592,
			  592,  117,  597,  117,  117,  594,  112,  600,  596,  601,
			  602,  599,  117,  112,  594,  603,  117,  604,  605,  606,
			  607,  596,  608,  609,  598,  117,  112,  610,  112,  611,

			  612,  112,  614,  112,  598,  615,  616,  618,  117,  600,
			  613,  602,  602,  600,  617,  117,  620,  604,  112,  604,
			  606,  606,  608,  619,  608,  610,  622,  112,  117,  610,
			  117,  612,  612,  117,  614,  117,  112,  616,  616,  618,
			  623,  624,  614,  112,  112,  621,  618,  626,  620,  112,
			  117,  112,  628,  629,  625,  620,  630,  112,  622,  117,
			  631,  112,  627,  632,  634,  633,  112,  636,  117,  112,
			  738,  738,  624,  624,  652,  117,  117,  622,  112,  626,
			  738,  117,  112,  117,  628,  630,  626,  635,  630,  117,
			  738,  738,  632,  117,  628,  632,  634,  634,  117,  636,

			   86,  117,  637,  337,  637,  640,  652,  638,  638,  638,
			  117,  738,   90,  738,  117,  638,  638,  638,  738,  636,
			  639,  639,  639,  569,  569,  569,  642,  642,  642,  112,
			  738,  230,  643,  643,  643,  653,  641,  640,  644,  644,
			  644,  645,  645,  645,  646,  646,  646,  649,  649,  649,
			  647,  112,  647,  654,  475,  645,  645,  645,  112,  656,
			  650,  117,  651,  658,  112,  571,  657,  654,  641,  655,
			  112,  112,  659,  660,  112,  662,  112,  663,  661,  664,
			  482,  112,  112,  117,  666,  654,  112,  112,  112,  668,
			  117,  656,  650,  667,  652,  658,  117,  665,  658,  670,

			  672,  656,  117,  117,  660,  660,  117,  662,  117,  664,
			  662,  664,  112,  117,  117,  112,  666,  674,  117,  117,
			  117,  668,  673,  669,  112,  668,  671,  676,  112,  666,
			  112,  670,  672,  678,  112,  675,  680,  112,  677,  679,
			  682,  112,  681,  684,  117,  112,  683,  117,  112,  674,
			  112,  112,  112,  686,  674,  670,  117,  688,  672,  676,
			  117,  112,  117,  685,  690,  678,  117,  676,  680,  117,
			  678,  680,  682,  117,  682,  684,  112,  117,  684,  112,
			  117,  687,  117,  117,  117,  686,  638,  638,  638,  688,
			  689,  738,  738,  117,  738,  686,  690,  638,  638,  638,

			  691,  691,  691,  695,  695,  695,  697,  738,  117,  738,
			  692,  117,  692,  688,  738,  693,  693,  693,  694,  738,
			  694,  738,  690,  695,  695,  695,  696,  696,  696,  645,
			  645,  645,  369,  698,  698,  698,  112,  703,  697,  645,
			  645,  645,  571,  699,  699,  699,  700,  112,  700,  112,
			  738,  701,  701,  701,  702,  704,  697,  705,  706,  707,
			  112,  112,  709,  112,  708,  112,  112,  711,  117,  703,
			  710,  112,  112,  112,  713,  112,  715,  738,  112,  117,
			  712,  117,  369,  717,  716,  719,  703,  705,  697,  705,
			  707,  707,  117,  117,  709,  117,  709,  117,  117,  711,

			  721,  112,  711,  117,  117,  117,  713,  117,  715,  714,
			  117,  723,  713,  112,  718,  717,  717,  719,  112,  720,
			  722,  725,  724,  112,  112,  112,  112,  693,  693,  693,
			  738,  112,  721,  117,  726,  726,  726,  695,  695,  695,
			  738,  715,  738,  723,  738,  117,  719,  695,  695,  695,
			  117,  721,  723,  725,  725,  117,  117,  117,  117,  727,
			  727,  727,  728,  117,  728,  112,  112,  729,  729,  729,
			  644,  644,  644,  475,  701,  701,  701,  730,  730,  730,
			  112,  112,  112,  697,  738,  732,  112,  112,  734,  112,
			  735,  736,  112,  731,  112,  112,  733,  117,  117,  691,

			  691,  691,  729,  729,  729,  737,  737,  737,  112,  369,
			  112,  112,  117,  117,  117,  697,  482,  732,  117,  117,
			  734,  117,  736,  736,  117,  732,  117,  117,  734,  698,
			  698,  698,  727,  727,  727,  374,  374,  738,  475,  374,
			  117,  738,  117,  117,  571,   85,   85,  738,   85,   85,
			   85,   85,   85,   85,   85,   85,   85,   85,   85,  117,
			  117,  117,  117,  117,  117,  738,   89,  738,  482,  738,
			  738,  571,   89,   89,   89,   89,   89,   89,   89,   89,
			   90,   90,  738,   90,   90,   90,   90,   90,   90,   90,
			   90,   90,   90,   90,   91,   91,  738,   91,   91,   91,

			   91,   91,   91,   91,   91,   91,   91,   91,   80,   80,
			  738,   80,   80,  738,   80,   80,   80,   80,   80,   80,
			   80,   80,  197,  197,  738,  197,  197,  738,  738,  197,
			  197,  197,  197,  197,  197,  197,  198,  198,  738,  198,
			  198,  198,  198,  198,  198,  198,  198,  198,  198,  198,
			  204,  204,  738,  204,  204,  204,  204,  204,  204,  204,
			  204,  204,  204,  204,  231,  231,  231,  231,  231,  231,
			  231,  738,  231,  231,  231,  231,  231,  231,  648,  648,
			  648,  648,  648,  648,  648,  738,  648,  648,  648,  648,
			  648,  648,    3,  738,  738,  738,  738,  738,  738,  738,

			  738,  738,  738,  738,  738,  738,  738,  738,  738,  738,
			  738,  738,  738,  738,  738,  738,  738,  738,  738,  738,
			  738,  738,  738,  738,  738,  738,  738,  738,  738,  738,
			  738,  738,  738,  738,  738,  738,  738,  738,  738,  738,
			  738,  738,  738,  738,  738,  738,  738,  738,  738,  738,
			  738,  738,  738,  738,  738,  738,  738,  738,  738,  738,
			  738,  738,  738,  738,  738,  738,  738,  738,  738,  738,
			  738,  738,  738,  738,  738,  738,  738,  738,  738,  738,
			  738, yy_Dummy>>)
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
			  727,    5,    5,    7,  698,    7,    7,    8,   10,    8,

			    8,   10,   13,   14,   14,   13,   20,   21,   22,   21,
			   21,   21,   28,   28,  691,   22,   20,   23,   38,   23,
			   23,   23,   24,   35,   24,   24,   24,   35,   25,   23,
			   25,   25,   25,   35,   24,   30,   30,  472,   49,   49,
			   58,   66,   36,   40,    5,   36,   10,   36,    7,   40,
			   38,   23,    8,  749,  749,   35,   44,   36,   23,   35,
			   44,   23,  375,   24,   90,   35,   24,   90,  374,   25,
			   49,   49,   58,   66,   36,   40,  236,   36,  227,   36,
			  226,   40,  225,   23,   32,   32,   32,  224,   44,   36,
			   68,  223,   44,   32,   32,   32,   32,   32,   32,   32,

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
			   75,   41,   34,  222,   43,   34,   37,   41,   34,   39,
			   37,   34,   39,   43,   37,   50,   39,   39,  221,  112,
			   45,   50,   39,   37,   45,   78,  198,   78,   78,  198,
			   34,   34,  116,   41,   34,   45,   43,   34,   37,   41,
			   34,   39,   37,   34,   39,   43,   37,   50,   39,   39,
			   42,  112,   45,   50,   39,   37,   45,   42,   46,   46,
			   42,   48,   42,   60,  116,   57,   42,   45,   46,   48,
			   57,  115,   57,   60,   59,   48,  115,   57,   59,   62,

			   78,   59,   42,   62,   59,   85,  220,   59,   85,   42,
			   46,   46,   42,   48,   42,   60,   62,   57,   42,  219,
			   46,   48,   57,  115,   57,   60,   59,   48,  115,   57,
			   59,   62,   61,   59,   61,   62,   59,   65,   64,   59,
			   67,   73,   70,   65,   61,   64,   64,  118,   62,   71,
			   67,   64,   67,   85,  120,   73,   67,   70,   79,   71,
			   79,   79,  218,  123,   61,   82,   61,   82,   82,   65,
			   64,  217,   67,   73,   70,   65,   61,   64,   64,  118,
			  216,   71,   67,   64,   67,  215,  120,   73,   67,   70,
			   83,   71,   83,   83,   88,  123,   88,   88,  214,   88,

			  129,  122,   88,   97,   97,   97,  130,  113,  100,  100,
			  100,  113,  122,   79,  213,  101,   97,  101,  101,  101,
			   82,  100,  102,  131,  102,  102,  102,  101,  105,  105,
			  105,  199,  129,  122,  199,  211,  211,  211,  130,  113,
			  132,  212,   97,  113,  122,   83,   87,   88,   97,   87,
			   87,   87,   87,  100,  200,  131,  101,  200,   87,  101,
			  126,  210,  209,  102,   87,  126,   87,  105,   87,   87,
			   87,  114,  132,   87,  114,   87,  208,  202,  207,   87,
			  202,   87,  206,  197,   87,   87,   87,   87,   87,   87,
			   92,   91,  126,   92,   92,   92,   92,  126,  230,  230,

			  230,   81,   92,  114,  119,  124,  114,  119,   92,  124,
			   92,  128,   92,   92,   92,   92,  125,   92,  127,   92,
			  128,  133,  127,   92,  125,   92,  135,  141,   92,   92,
			   92,   92,   92,   92,   80,   53,  119,  124,  134,  119,
			  136,  124,  134,  128,  136,  134,  139,  138,  125,  142,
			  127,  139,  128,  133,  127,  140,  125,  138,  135,  141,
			  147,  139,  140,  143,  142,  144,  140,  143,  144,  146,
			  134,  148,  136,  149,  134,  146,  136,  134,  139,  138,
			  145,  142,  150,  139,  151,  153,  155,  140,  145,  138,
			   52,  151,  147,  139,  140,  143,  142,  144,  140,  143,

			  144,  146,  160,  148,  152,  149,  156,  146,  152,  152,
			  156,  158,  145,  158,  150,  161,  151,  153,  155,  152,
			  145,  156,  152,  151,  156,  159,  163,  161,  162,  166,
			   31,  159,  167,  168,  160,  166,  152,  159,  156,  162,
			  152,  152,  156,  158,  165,  158,  169,  161,  170,  165,
			  173,  152,  164,  156,  152,  179,  156,  159,  163,  161,
			  162,  166,  164,  159,  167,  168,  172,  166,  178,  159,
			  172,  162,  178,   26,  177,  175,  165,  175,  169,    9,
			  170,  165,  173,  177,  164,  175,    6,  179,  175,  176,
			  175,  175,  176,  180,  164,  182,  176,  180,  172,  181,

			  178,  183,  172,  174,  178,  174,  177,  175,  174,  175,
			  187,  181,    3,  174,  188,  177,  174,  175,  174,  174,
			  175,  176,  175,  175,  176,  180,  189,  182,  176,  180,
			  190,  181,  191,  183,  190,  174,  184,  174,  186,  185,
			  174,  184,  187,  181,  185,  174,  188,  186,  174,  193,
			  174,  174,  184,  239,  192,  185,    0,    0,  189,  196,
			  196,  196,  190,  192,  191,  241,  190,    0,  184,    0,
			  186,  185,  240,  184,  242,  201,  185,    0,  201,  186,
			  240,  193,    0,    0,  184,  239,  192,  185,  201,  201,
			  201,  203,    0,  203,  203,  192,  203,  241,  196,  203,

			  228,  228,  228,  229,  240,  229,  242,    0,  229,  229,
			  229,    0,  240,  228,  232,  232,  232,  233,  245,  233,
			  238,    0,  233,  233,  233,  238,  234,  232,  234,  234,
			  234,  235,  247,  235,  235,  235,  246,  244,  234,  228,
			  237,  237,  237,  244,  203,  228,  246,    0,  248,  249,
			  245,  251,  238,  232,  250,  253,  252,  238,  256,  232,
			  257,  248,  250,    0,  247,  252,  259,  234,  246,  244,
			  234,  260,  235,  254,  263,  244,    0,  261,  246,  237,
			  248,  249,  267,  251,  269,  254,  250,  253,  252,  261,
			  256,  255,  257,  248,  250,  255,  258,  252,  259,  264,

			  258,  266,  268,  260,  265,  254,  263,  264,  265,  261,
			  271,  270,  268,  264,  267,  266,  269,  254,  275,    0,
			  272,  261,  270,  255,  272,  273,  274,  255,  258,  274,
			  280,  264,  258,  266,  268,    0,  265,  272,  273,  264,
			  265,  278,  271,  270,  268,  264,  281,  266,  278,  276,
			  275,  277,  272,  276,  270,  277,  272,  273,  274,  279,
			  282,  274,  280,  283,  284,  285,  286,  279,  284,  272,
			  273,  288,  287,  278,  286,  289,  290,  293,  281,  287,
			  278,  276,  292,  277,  294,  276,  296,  277,  292,  297,
			  296,  279,  282,  299,  302,  283,  284,  285,  286,  279,

			  284,  300,  302,  288,  287,  300,  286,  289,  290,  293,
			  306,  287,  303,  298,  292,    0,  294,  307,  296,  298,
			  292,  297,  296,  301,  303,  299,  302,  301,  308,  304,
			  305,  309,  310,  300,  302,  304,  311,  300,  313,  305,
			  314,  315,  306,  316,  303,  298,  313,  304,  312,  307,
			  310,  298,  312,  317,  319,  301,  303,  321,  323,  301,
			  308,  304,  305,  309,  310,  324,  323,  304,  311,  318,
			  313,  305,  314,  315,  318,  316,  325,  320,  313,  304,
			  312,  320,  310,  322,  312,  317,  319,  322,  326,  321,
			  323,  327,  328,  329,  330,  331,  333,  324,  323,  330,

			  332,  318,  334,    0,  337,  332,  318,  337,  325,  320,
			    0,  338,    0,  320,  338,  322,  363,  363,  363,  322,
			  326,  378,  380,  327,  328,  329,  330,  331,  333,  363,
			  339,  330,  332,  339,  334,  340,  382,  332,  340,  364,
			  364,  364,  339,  339,  339,  339,  346,  346,  346,  346,
			  365,  365,  365,  378,  380,  363,  366,  366,  366,    0,
			  340,  363,  367,  367,  367,  368,    0,  368,  382,    0,
			  368,  368,  368,    0,    0,  367,  369,  369,  369,  370,
			  370,  370,  371,  371,  371,  376,  376,  376,  372,  365,
			  372,  372,  372,  373,  377,  373,  373,  373,  379,  383,

			  372,  367,    0,  384,  381,  377,  381,  367,  379,  383,
			  385,  386,  387,  388,  385,  389,  390,  392,  391,  389,
			  391,  371,  394,  387,  376,  395,  377,  396,  398,  372,
			  379,  383,  372,    0,  373,  384,  381,  377,  381,  401,
			  379,  383,  385,  386,  387,  388,  385,  389,  390,  392,
			  391,  389,  391,  393,  394,  387,  397,  395,  399,  396,
			  398,  400,  393,  399,  402,  397,  403,  404,  405,  406,
			  400,  401,  405,  408,  407,  403,  409,  410,  412,  413,
			  414,  410,    0,  416,    0,  393,  407,  418,  397,    0,
			  399,  420,  422,  400,  393,  399,  402,  397,  403,  404,

			  405,  406,  400,  423,  405,  408,  407,  403,  409,  410,
			  412,  413,  414,  410,  415,  416,  417,  419,  407,  418,
			  426,  419,  421,  420,  422,  417,  427,  425,  430,  415,
			  425,  421,  431,  429,  434,  423,  429,  435,  433,  436,
			  435,  438,  437,  439,  440,  441,  415,  439,  417,  419,
			  433,  437,  426,  419,  421,  442,  445,  417,  427,  425,
			  430,  415,  425,  421,  431,  429,  434,  446,  429,  435,
			  433,  436,  435,  438,  437,  439,  440,  441,  443,  439,
			  447,  444,  433,  437,  444,  448,  449,  442,  445,  450,
			  443,  451,  449,  452,  453,  454,  447,  455,  457,  446,

			  451,  453,  459,  460,  462,  459,  463,  461,  464,  463,
			  443,  466,  447,  444,  467,  469,  444,  448,  449,  461,
			    0,  450,  443,  451,  449,  452,  453,  454,  447,  455,
			  457,    0,  451,  453,  459,  460,  462,  459,  463,  461,
			  464,  463,  465,  466,    0,  471,  467,  469,  471,  485,
			  465,  461,  473,  473,  473,  487,    0,  471,  471,  471,
			  471,  474,  474,  474,  489,  473,  475,  475,  475,  476,
			  476,  476,    0,    0,  465,  477,  477,  477,  478,  478,
			  478,  485,  465,  479,  479,  479,  491,  487,  477,  480,
			  480,  480,  481,  481,  481,  494,  489,  473,  498,    0,

			  474,  482,  482,  482,  483,  483,  483,  484,  497,  484,
			  484,  484,  493,  497,  477,  495,    0,  483,  491,  495,
			  477,  493,  479,  499,  496,  501,  502,  494,  496,  503,
			  498,  481,  503,  504,  501,  505,  506,  507,  508,  505,
			  497,  509,  507,  510,  493,  497,  512,  495,  484,  483,
			  513,  495,  509,  493,  511,  499,  496,  501,  502,  511,
			  496,  503,  516,  515,  503,  504,  501,  505,  506,  507,
			  508,  505,  515,  509,  507,  510,  517,  518,  512,  519,
			  520,  517,  513,  519,  509,  521,  511,  522,  523,  524,
			  525,  511,  526,  527,  516,  515,  525,  528,  529,  531,

			  532,  533,  534,  531,  515,  535,  536,  538,  517,  518,
			  533,  519,  520,  517,  537,  519,  540,  521,  537,  522,
			  523,  524,  525,  539,  526,  527,  542,  539,  525,  528,
			  529,  531,  532,  533,  534,  531,  541,  535,  536,  538,
			  543,  544,  533,  545,  543,  541,  537,  546,  540,  547,
			  537,  549,  550,  551,  545,  539,  552,  553,  542,  539,
			  555,  551,  549,  556,  558,  557,  559,  562,  541,  557,
			    0,    0,  543,  544,  578,  545,  543,  541,  579,  546,
			    0,  547,  561,  549,  550,  551,  545,  561,  552,  553,
			    0,    0,  555,  551,  549,  556,  558,  557,  559,  562,

			  563,  557,  565,  563,  565,  568,  578,  565,  565,  565,
			  579,    0,  563,    0,  561,  566,  566,  566,    0,  561,
			  567,  567,  567,  569,  569,  569,  570,  570,  570,  580,
			    0,  568,  571,  571,  571,  580,  569,  568,  572,  572,
			  572,  573,  573,  573,  574,  574,  574,  576,  576,  576,
			  575,  577,  575,  582,  566,  575,  575,  575,  583,  584,
			  576,  580,  577,  586,  587,  570,  585,  580,  569,  583,
			  585,  589,  591,  592,  593,  596,  591,  597,  595,  598,
			  573,  597,  599,  577,  602,  582,  595,  601,  603,  604,
			  583,  584,  576,  603,  577,  586,  587,  601,  585,  606,

			  608,  583,  585,  589,  591,  592,  593,  596,  591,  597,
			  595,  598,  605,  597,  599,  607,  602,  610,  595,  601,
			  603,  604,  609,  605,  611,  603,  607,  612,  613,  601,
			  609,  606,  608,  614,  615,  611,  616,  617,  613,  615,
			  618,  619,  617,  622,  605,  623,  621,  607,  625,  610,
			  621,  627,  629,  630,  609,  605,  611,  632,  607,  612,
			  613,  633,  609,  629,  636,  614,  615,  611,  616,  617,
			  613,  615,  618,  619,  617,  622,  631,  623,  621,  635,
			  625,  631,  621,  627,  629,  630,  637,  637,  637,  632,
			  635,    0,    0,  633,    0,  629,  636,  638,  638,  638,

			  639,  639,  639,  642,  642,  642,  644,    0,  631,    0,
			  640,  635,  640,  631,    0,  640,  640,  640,  641,    0,
			  641,    0,  635,  641,  641,  641,  643,  643,  643,  645,
			  645,  645,  644,  646,  646,  646,  651,  654,  644,  647,
			  647,  647,  642,  649,  649,  649,  650,  655,  650,  653,
			    0,  650,  650,  650,  653,  657,  649,  658,  659,  660,
			  657,  661,  662,  659,  661,  663,  665,  668,  651,  654,
			  667,  669,  667,  671,  674,  673,  676,    0,  677,  655,
			  673,  653,  649,  678,  677,  680,  653,  657,  649,  658,
			  659,  660,  657,  661,  662,  659,  661,  663,  665,  668,

			  682,  683,  667,  669,  667,  671,  674,  673,  676,  675,
			  677,  686,  673,  675,  679,  678,  677,  680,  679,  681,
			  685,  688,  687,  689,  685,  681,  687,  692,  692,  692,
			    0,  702,  682,  683,  693,  693,  693,  694,  694,  694,
			    0,  675,    0,  686,    0,  675,  679,  695,  695,  695,
			  679,  681,  685,  688,  687,  689,  685,  681,  687,  696,
			  696,  696,  697,  702,  697,  704,  706,  697,  697,  697,
			  699,  699,  699,  693,  700,  700,  700,  701,  701,  701,
			  708,  710,  712,  699,    0,  713,  714,  716,  717,  718,
			  720,  721,  722,  712,  720,  724,  716,  704,  706,  726,

			  726,  726,  728,  728,  728,  729,  729,  729,  731,  699,
			  733,  735,  708,  710,  712,  699,  701,  713,  714,  716,
			  717,  718,  720,  721,  722,  712,  720,  724,  716,  730,
			  730,  730,  737,  737,  737,  750,  750,    0,  726,  750,
			  731,    0,  733,  735,  729,  739,  739,    0,  739,  739,
			  739,  739,  739,  739,  739,  739,  739,  739,  739,  745,
			  745,  745,  745,  745,  745,    0,  740,    0,  730,    0,
			    0,  737,  740,  740,  740,  740,  740,  740,  740,  740,
			  741,  741,    0,  741,  741,  741,  741,  741,  741,  741,
			  741,  741,  741,  741,  742,  742,    0,  742,  742,  742,

			  742,  742,  742,  742,  742,  742,  742,  742,  743,  743,
			    0,  743,  743,    0,  743,  743,  743,  743,  743,  743,
			  743,  743,  744,  744,    0,  744,  744,    0,    0,  744,
			  744,  744,  744,  744,  744,  744,  746,  746,    0,  746,
			  746,  746,  746,  746,  746,  746,  746,  746,  746,  746,
			  747,  747,    0,  747,  747,  747,  747,  747,  747,  747,
			  747,  747,  747,  747,  748,  748,  748,  748,  748,  748,
			  748,    0,  748,  748,  748,  748,  748,  748,  751,  751,
			  751,  751,  751,  751,  751,    0,  751,  751,  751,  751,
			  751,  751,  738,  738,  738,  738,  738,  738,  738,  738,

			  738,  738,  738,  738,  738,  738,  738,  738,  738,  738,
			  738,  738,  738,  738,  738,  738,  738,  738,  738,  738,
			  738,  738,  738,  738,  738,  738,  738,  738,  738,  738,
			  738,  738,  738,  738,  738,  738,  738,  738,  738,  738,
			  738,  738,  738,  738,  738,  738,  738,  738,  738,  738,
			  738,  738,  738,  738,  738,  738,  738,  738,  738,  738,
			  738,  738,  738,  738,  738,  738,  738,  738,  738,  738,
			  738,  738,  738,  738,  738,  738,  738,  738,  738,  738,
			  738, yy_Dummy>>)
		end

	yy_base_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,  812, 2392,   87,  783,   91,   95,  773,
			   91,    0, 2392,   95,   93, 2392, 2392, 2392, 2392, 2392,
			   89,   89,   89,   99,  104,  110,  747, 2392,   87, 2392,
			  109,  704,  164,  231,  282,   90,  105,  297,   81,  295,
			  106,  284,  340,  287,  123,  307,  342,  217,  352,  102,
			  298, 2392,  634,  628, 2392,  199,    0,  350,  103,  358,
			  350,  392,  370,    0,  404,  400,   98,  410,  144,  191,
			  409,  413,  213,  412,  221,  245, 2392, 2392,  343,  456,
			  627,  598,  463,  488, 2392,  398, 2392,  539,  492,    0,
			  157,  580,  583,    0, 2392, 2392, 2392,  483, 2392, 2392,

			  488,  497,  504, 2392,    0,  508, 2392, 2392, 2392, 2392,
			 2392, 2392,  302,  474,  534,  359,  315,    0,  414,  567,
			  422,    0,  464,  415,  572,  587,  523,  585,  574,  467,
			  477,  481,  507,  575,  608,  589,  610,    0,  610,  614,
			  618,  580,  617,  619,  628,  651,  632,  620,  642,  630,
			  645,  647,  672,  648,    0,  642,  674,    0,  674,  694,
			  663,  684,  691,  678,  715,  712,  698,  695,  686,  714,
			  717,    0,  733,  717,  771,  743,  752,  737,  728,  709,
			  760,  762,  762,  752,  804,  807,  801,  773,  768,  789,
			  797,  799,  817,  803, 2392, 2392,  839,  572,  339,  524,

			  547,  868,  570,  889, 2392, 2392,  571,  567,  565,  551,
			  550,  515,  530,  503,  487,  474,  469,  460,  451,  408,
			  395,  327,  312,  180,  176,  171,  169,  167,  880,  888,
			  578, 2392,  894,  902,  908,  913,  117,  920,  883,  811,
			  843,  828,  845,    0,  906,  887,  899,  885,  911,  899,
			  925,  922,  919,  909,  936,  958,  909,  927,  963,  933,
			  934,  940,    0,  925,  970,  971,  972,  949,  965,  937,
			  974,  962,  983,  984,  989,  978, 1016, 1018, 1004, 1030,
			  997, 1013, 1016, 1034, 1031, 1032, 1037, 1035, 1042, 1031,
			 1039,    0, 1045, 1034, 1047,    0, 1053, 1056, 1082, 1062,

			 1068, 1090, 1065, 1075, 1098, 1093, 1077, 1084, 1099, 1082,
			 1101, 1090, 1115, 1109, 1107, 1112, 1106, 1116, 1132, 1112,
			 1144, 1124, 1150, 1121, 1128, 1143, 1143, 1154, 1155, 1156,
			 1162, 1163, 1163, 1154, 1165,    0, 2392, 1197, 1204, 1223,
			 1228, 2392, 2392, 2392, 2392, 2392, 1227, 2392, 2392, 2392,
			 2392, 2392, 2392, 2392, 2392, 2392, 2392, 2392, 2392, 2392,
			 2392, 2392, 2392, 1196, 1219, 1230, 1236, 1242, 1250, 1256,
			 1259, 1262, 1270, 1275,  109,  103, 1265, 1257, 1173, 1261,
			 1175, 1267, 1197, 1262, 1256, 1277, 1278, 1275, 1265, 1282,
			 1283, 1283, 1282, 1316, 1276, 1288, 1290, 1319, 1282, 1321,

			 1324, 1297, 1318, 1329, 1321, 1335, 1336, 1337, 1324, 1339,
			 1344,    0, 1345, 1342, 1343, 1377, 1331, 1379, 1341, 1384,
			 1358, 1385, 1346, 1366,    0, 1390, 1380, 1389,    0, 1396,
			 1388, 1395,    0, 1401, 1385, 1403, 1405, 1405, 1395, 1406,
			 1403, 1408, 1418, 1441, 1444, 1407, 1427, 1443, 1432, 1455,
			 1458, 1454, 1447, 1457, 1451, 1460,    0, 1461,    0, 1468,
			 1469, 1470, 1455, 1469, 1468, 1513, 1482, 1477,    0, 1478,
			    0, 1538,  126, 1532, 1541, 1546, 1549, 1555, 1558, 1563,
			 1569, 1572, 1581, 1584, 1589, 1512,    0, 1518,    0, 1527,
			    0, 1549,    0, 1575, 1549, 1582, 1591, 1571, 1556, 1586,

			    0, 1588, 1580, 1595, 1599, 1602, 1603, 1605, 1606, 1604,
			 1595, 1617, 1604, 1613,    0, 1626, 1616, 1639, 1635, 1646,
			 1647, 1648, 1650, 1651, 1652, 1659, 1661, 1656, 1660, 1661,
			    0, 1666, 1667, 1664, 1656, 1668, 1669, 1681, 1674, 1690,
			 1683, 1699, 1680, 1707, 1708, 1706, 1699, 1712,    0, 1714,
			 1704, 1724, 1727, 1720,    0, 1723, 1726, 1732, 1731, 1729,
			    0, 1745, 1725, 1793, 2392, 1787, 1795, 1800, 1772, 1803,
			 1806, 1812, 1818, 1821, 1824, 1835, 1827, 1814, 1726, 1741,
			 1792,    0, 1810, 1821, 1811, 1833, 1830, 1827,    0, 1834,
			    0, 1839, 1840, 1837,    0, 1849, 1846, 1844, 1846, 1845,

			    0, 1850, 1837, 1851, 1847, 1875, 1851, 1878, 1852, 1893,
			 1888, 1887, 1879, 1891, 1886, 1897, 1894, 1900, 1898, 1904,
			    0, 1913, 1910, 1908,    0, 1911,    0, 1914,    0, 1915,
			 1905, 1939, 1915, 1924,    0, 1942, 1916, 1966, 1977, 1980,
			 1995, 2003, 1983, 2006, 1973, 2009, 2013, 2019, 2392, 2023,
			 2031, 1999,    0, 2012, 1995, 2010,    0, 2023, 2025, 2026,
			 2027, 2024, 2022, 2028,    0, 2029,    0, 2035, 2032, 2034,
			    0, 2036,    0, 2038, 2032, 2076, 2043, 2041, 2040, 2081,
			 2052, 2088, 2069, 2064,    0, 2087, 2078, 2089, 2088, 2086,
			    0,   55, 2107, 2114, 2117, 2127, 2139, 2147,   35, 2150,

			 2154, 2157, 2094,    0, 2128,    0, 2129,    0, 2143,    0,
			 2144,    0, 2145, 2137, 2149,    0, 2150, 2142, 2152,    0,
			 2157, 2158, 2155,    0, 2158,    0, 2179,   31, 2182, 2185,
			 2209, 2171,    0, 2173,    0, 2174,    0, 2212, 2392, 2244,
			 2265, 2279, 2293, 2307, 2321, 2250, 2335, 2349, 2363,  144,
			 2226, 2377, yy_Dummy>>)
		end

	yy_def_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,  738,    1,  738,  738,  738,  738,  738,  738,  738,
			  739,  740,  738,  741,  742,  738,  738,  738,  738,  738,
			  738,  738,  738,  738,  738,  738,  738,  738,  738,  738,
			  738,  738,  738,  738,   33,   33,   33,   33,   33,   33,
			   33,   33,   33,   33,   33,   33,   33,   33,   33,   33,
			   33,  738,  738,  743,  738,  738,  744,  745,  745,  745,
			  745,  745,  745,  745,  745,  745,  745,  745,  745,  745,
			  745,  745,  745,  745,  745,  745,  738,  738,  738,  738,
			  743,  738,  738,  738,  738,  739,  738,  746,  739,  740,
			  741,  747,  747,  747,  738,  738,  738,  738,  738,  738,

			  748,  738,  738,  738,  749,  738,  738,  738,  738,  738,
			  738,  738,   33,   33,   33,   33,   33,  745,  745,  745,
			  745,  745,   33,  745,   33,   33,   33,   33,   33,  745,
			  745,  745,  745,  745,   33,   33,  745,  745,   33,   33,
			   33,  745,  745,  745,   33,   33,   33,  745,  745,  745,
			   33,   33,   33,   33,  745,  745,  745,  745,   33,   33,
			  745,  745,   33,  745,   33,   33,   33,   33,  745,  745,
			  745,  745,   33,  745,   33,  745,   33,   33,  745,  745,
			   33,   33,  745,  745,   33,  745,   33,   33,  745,  745,
			   33,  745,   33,  745,  738,  738,  738,  744,  746,  741,

			  741,  746,  746,  739,  738,  738,  738,  738,  738,  738,
			  738,  738,  738,  738,  738,  738,  738,  738,  738,  738,
			  738,  738,  738,  738,  738,  738,  738,  738,  738,  738,
			  738,  738,  738,  738,  738,  738,  750,  738,   33,  745,
			   33,   33,  745,  745,   33,  745,   33,  745,   33,  745,
			   33,  745,   33,  745,   33,   33,  745,  745,   33,  745,
			   33,   33,  745,  745,   33,   33,  745,  745,   33,  745,
			   33,  745,   33,  745,   33,  745,   33,   33,   33,   33,
			  745,  745,  745,  745,   33,  745,   33,   33,  745,  745,
			   33,  745,   33,  745,   33,  745,   33,  745,   33,  745,

			   33,   33,   33,   33,   33,   33,  745,  745,  745,  745,
			  745,  745,   33,   33,  745,  745,   33,  745,   33,  745,
			   33,  745,   33,   33,   33,  745,  745,  745,   33,  745,
			   33,  745,   33,  745,   33,  745,  738,  746,  746,  746,
			  746,  738,  738,  738,  738,  738,  738,  738,  738,  738,
			  738,  738,  738,  738,  738,  738,  738,  738,  738,  738,
			  738,  738,  738,  738,  738,  738,  738,  738,  738,  738,
			  738,  738,  738,  738,  750,  750,  738,   33,  745,   33,
			  745,   33,  745,   33,  745,   33,  745,   33,  745,   33,
			  745,   33,  745,   33,  745,   33,  745,   33,  745,   33,

			   33,  745,  745,   33,  745,   33,  745,   33,  745,   33,
			   33,  745,  745,   33,  745,   33,  745,   33,  745,   33,
			  745,   33,  745,   33,  745,   33,  745,   33,  745,   33,
			  745,   33,  745,   33,  745,   33,  745,   33,  745,   33,
			  745,   33,  745,   33,   33,  745,  745,   33,  745,   33,
			  745,   33,  745,   33,  745,   33,  745,   33,  745,   33,
			  745,   33,  745,   33,  745,   33,  745,   33,  745,   33,
			  745,  746,  738,  738,  738,  738,  738,  738,  738,  738,
			  738,  738,  738,  748,  738,   33,  745,   33,  745,   33,
			  745,   33,  745,   33,  745,   33,  745,   33,  745,   33,

			  745,   33,  745,   33,  745,   33,  745,   33,  745,   33,
			  745,   33,  745,   33,  745,   33,  745,   33,  745,   33,
			  745,   33,  745,   33,  745,   33,  745,   33,  745,   33,
			  745,   33,  745,   33,  745,   33,  745,   33,  745,   33,
			  745,   33,  745,   33,  745,   33,  745,   33,  745,   33,
			  745,   33,  745,   33,  745,   33,  745,   33,  745,   33,
			  745,   33,  745,  746,  738,  738,  738,  738,  738,  738,
			  738,  738,  738,  738,  738,  738,  751,   33,  745,   33,
			   33,  745,  745,   33,  745,   33,  745,   33,  745,   33,
			  745,   33,  745,   33,  745,   33,  745,   33,  745,   33,

			  745,   33,  745,   33,  745,   33,  745,   33,  745,   33,
			  745,   33,  745,   33,  745,   33,  745,   33,  745,   33,
			  745,   33,  745,   33,  745,   33,  745,   33,  745,   33,
			  745,   33,  745,   33,  745,   33,  745,  738,  738,  738,
			  738,  738,  738,  738,  738,  738,  738,  738,  738,  738,
			  738,   33,  745,   33,  745,   33,  745,   33,  745,   33,
			  745,   33,  745,   33,  745,   33,  745,   33,  745,   33,
			  745,   33,  745,   33,  745,   33,  745,   33,  745,   33,
			  745,   33,  745,   33,  745,   33,  745,   33,  745,   33,
			  745,  738,  738,  738,  738,  738,  738,  738,  738,  738,

			  738,  738,   33,  745,   33,  745,   33,  745,   33,  745,
			   33,  745,   33,  745,   33,  745,   33,  745,   33,  745,
			   33,  745,   33,  745,   33,  745,  738,  738,  738,  738,
			  738,   33,  745,   33,  745,   33,  745,  738,    0,  738,
			  738,  738,  738,  738,  738,  738,  738,  738,  738,  738,
			  738,  738, yy_Dummy>>)
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
			  241,  241,  242,  243,  244,  245,  246,  247,  248,  251,
			  252,  253,  254,  255,  256,  257,  258,  259,  261,  262,

			  263,  263,  265,  267,  268,  268,  269,  270,  271,  272,
			  273,  274,  275,  277,  279,  281,  283,  286,  287,  288,
			  289,  290,  292,  294,  295,  297,  299,  301,  303,  305,
			  306,  307,  308,  309,  310,  312,  315,  316,  318,  320,
			  322,  324,  325,  326,  327,  329,  331,  333,  334,  335,
			  336,  339,  341,  343,  346,  348,  349,  350,  352,  354,
			  356,  357,  358,  360,  361,  363,  365,  367,  370,  371,
			  372,  373,  375,  377,  378,  380,  381,  383,  385,  386,
			  387,  389,  391,  392,  393,  395,  396,  398,  400,  401,
			  402,  404,  405,  407,  408,  409,  410,  411,  411,  411,

			  413,  415,  415,  415,  417,  418,  420,  421,  422,  423,
			  424,  425,  426,  427,  428,  429,  430,  431,  432,  433,
			  434,  435,  436,  437,  438,  439,  440,  441,  442,  444,
			  444,  444,  445,  447,  448,  450,  452,  453,  454,  456,
			  457,  459,  462,  463,  465,  467,  468,  470,  471,  473,
			  474,  476,  477,  479,  480,  482,  484,  485,  486,  488,
			  489,  492,  494,  496,  497,  499,  501,  502,  503,  505,
			  506,  508,  509,  511,  512,  514,  515,  517,  519,  521,
			  523,  524,  525,  526,  527,  529,  530,  532,  534,  535,
			  536,  539,  541,  543,  544,  547,  549,  551,  552,  554,

			  555,  557,  559,  561,  563,  565,  567,  568,  569,  570,
			  571,  572,  573,  575,  577,  578,  579,  581,  582,  584,
			  585,  587,  588,  590,  592,  594,  595,  596,  597,  599,
			  600,  602,  603,  605,  606,  609,  611,  612,  613,  614,
			  614,  615,  616,  617,  618,  619,  620,  621,  622,  623,
			  624,  625,  626,  627,  628,  629,  630,  631,  632,  633,
			  634,  635,  636,  637,  639,  639,  641,  641,  643,  643,
			  643,  643,  645,  647,  649,  650,  650,  651,  653,  654,
			  656,  657,  659,  660,  662,  663,  665,  666,  668,  669,
			  671,  672,  674,  675,  677,  678,  681,  683,  685,  686,

			  688,  690,  691,  692,  694,  695,  697,  698,  700,  701,
			  704,  706,  708,  709,  711,  712,  714,  715,  717,  718,
			  720,  721,  723,  724,  727,  729,  731,  732,  735,  737,
			  739,  740,  743,  745,  747,  748,  750,  751,  753,  754,
			  756,  757,  759,  760,  762,  764,  765,  766,  768,  769,
			  771,  772,  774,  775,  777,  778,  781,  783,  786,  788,
			  790,  791,  793,  794,  796,  797,  799,  800,  803,  805,
			  808,  810,  810,  811,  812,  814,  814,  814,  816,  816,
			  820,  820,  822,  822,  822,  824,  827,  829,  832,  834,
			  837,  839,  842,  844,  846,  847,  849,  850,  852,  853,

			  856,  858,  860,  861,  863,  864,  866,  867,  869,  870,
			  872,  873,  875,  876,  879,  881,  883,  884,  886,  887,
			  889,  890,  892,  893,  895,  896,  898,  899,  901,  902,
			  905,  907,  909,  910,  912,  913,  915,  916,  918,  919,
			  921,  922,  924,  925,  927,  928,  930,  931,  934,  936,
			  938,  939,  941,  942,  945,  947,  949,  950,  952,  953,
			  956,  958,  960,  961,  961,  962,  962,  964,  964,  965,
			  966,  970,  970,  970,  972,  972,  973,  973,  975,  976,
			  979,  981,  983,  984,  986,  987,  989,  990,  993,  995,
			  998, 1000, 1002, 1003, 1006, 1008, 1010, 1011, 1013, 1014,

			 1017, 1019, 1021, 1022, 1024, 1025, 1027, 1028, 1030, 1031,
			 1033, 1034, 1036, 1037, 1039, 1040, 1042, 1043, 1045, 1046,
			 1049, 1051, 1053, 1054, 1057, 1059, 1062, 1064, 1067, 1069,
			 1071, 1072, 1074, 1075, 1078, 1080, 1082, 1083, 1083, 1084,
			 1084, 1084, 1084, 1088, 1088, 1089, 1090, 1090, 1090, 1091,
			 1092, 1093, 1096, 1098, 1100, 1101, 1104, 1106, 1108, 1109,
			 1111, 1112, 1114, 1115, 1118, 1120, 1123, 1125, 1127, 1128,
			 1131, 1133, 1136, 1138, 1140, 1141, 1143, 1144, 1146, 1147,
			 1149, 1150, 1152, 1153, 1156, 1158, 1160, 1161, 1163, 1164,
			 1167, 1169, 1170, 1170, 1171, 1171, 1173, 1173, 1173, 1174,

			 1175, 1175, 1176, 1179, 1181, 1184, 1186, 1189, 1191, 1194,
			 1196, 1199, 1201, 1203, 1204, 1207, 1209, 1211, 1212, 1215,
			 1217, 1219, 1220, 1223, 1225, 1228, 1230, 1231, 1233, 1233,
			 1235, 1236, 1239, 1241, 1244, 1246, 1249, 1251, 1253, 1253, yy_Dummy>>)
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
			    3,    4,    1,    2,   37,  128,  127,  127, -125,  128,
			 -268,   99,  128,  123,  123,  123,    5,   23,   24,  137,
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
			  134,  127,  128,  127,  128, -125,  128,  123,  100,  123,
			  123,  123,  123,  123,  123,  123,  123,  123,  123,  123,
			  123,  123,  123,  123,  123,  123,  123,  123,  123,  123,
			  123,  123,  137,  140,  135,  137,  140,  135,  130,  134,
			  130,  134,  132,  134,   97,   98,   98,   97,   98,   40,
			   97,   98,   98,   40,   98,   97,   98,   98,   97,   98,
			   98,   97,   98,   98,   97,   98,   98,   97,   98,   98,
			   97,   98,   97,   98,   98,   98,   97,   98,   98,   53,
			   97,   98,   97,   98,   53,   98,   98,   97,   98,   97,

			   98,   98,   98,   97,   98,   98,   97,   98,   98,   97,
			   98,   98,   97,   98,   98,   97,   98,   97,   98,   97,
			   98,   97,   98,   98,   98,   98,   98,   97,   98,   98,
			   97,   98,   97,   98,   98,   98,   72,   97,   98,   72,
			   98,   97,   98,   98,   74,   97,   98,   74,   98,   97,
			   98,   98,   97,   98,   98,   97,   98,   97,   98,   97,
			   98,   97,   98,   97,   98,   97,   98,   98,   98,   98,
			   98,   98,   98,   97,   98,   97,   98,   98,   98,   97,
			   98,   98,   97,   98,   98,   97,   98,   98,   97,   98,
			   97,   98,   97,   98,   98,   98,   98,   97,   98,   98,

			   97,   98,   98,   97,   98,   98,   96,   97,   98,   96,
			   98,  141,  127,  127,  127,  117,  115,  116,  118,  119,
			  124,  120,  121,  101,  102,  103,  104,  105,  106,  107,
			  108,  109,  110,  111,  112,  113,  114,  137,  140,  137,
			  140,  137,  140,  136,  139,  130,  134,  130,  134,  133,
			  134,   97,   98,   98,   97,   98,   98,   97,   98,   98,
			   97,   98,   98,   97,   98,   98,   97,   98,   98,   97,
			   98,   98,   97,   98,   98,   97,   98,   98,   51,   97,
			   98,   51,   98,   97,   98,   98,   97,   98,   97,   98,
			   98,   98,   97,   98,   98,   97,   98,   98,   97,   98,

			   98,   60,   97,   98,   97,   98,   60,   98,   98,   97,
			   98,   98,   97,   98,   98,   97,   98,   98,   97,   98,
			   98,   97,   98,   98,   69,   97,   98,   69,   98,   97,
			   98,   98,   71,   97,   98,   71,   98,   97,   98,   98,
			   75,   97,   98,   75,   98,   97,   98,   98,   97,   98,
			   98,   97,   98,   98,   97,   98,   98,   97,   98,   98,
			   97,   98,   97,   98,   98,   98,   97,   98,   98,   97,
			   98,   98,   97,   98,   98,   97,   98,   98,   88,   97,
			   98,   88,   98,   89,   97,   98,   89,   98,   97,   98,
			   98,   97,   98,   98,   97,   98,   98,   97,   98,   98,

			   94,   97,   98,   94,   98,   95,   97,   98,   95,   98,
			  124,  137,  137,  140,  137,  140,  136,  137,  139,  140,
			  136,  139,  131,  134,   38,   97,   98,   38,   98,   39,
			   97,   98,   39,   98,   42,   97,   98,   42,   98,   43,
			   97,   98,   43,   98,   97,   98,   98,   97,   98,   98,
			   97,   98,   98,   48,   97,   98,   48,   98,   97,   98,
			   98,   97,   98,   98,   97,   98,   98,   97,   98,   98,
			   97,   98,   98,   97,   98,   98,   58,   97,   98,   58,
			   98,   97,   98,   98,   97,   98,   98,   97,   98,   98,
			   97,   98,   98,   97,   98,   98,   97,   98,   98,   97,

			   98,   98,   70,   97,   98,   70,   98,   97,   98,   98,
			   97,   98,   98,   97,   98,   98,   97,   98,   98,   97,
			   98,   98,   97,   98,   98,   97,   98,   98,   97,   98,
			   98,   84,   97,   98,   84,   98,   97,   98,   98,   97,
			   98,   98,   87,   97,   98,   87,   98,   97,   98,   98,
			   97,   98,   98,   92,   97,   98,   92,   98,   97,   98,
			   98,  122,  137,  140,  140,  137,  136,  137,  139,  140,
			  136,  139,  135,   97,   98,   98,   45,   97,   98,   97,
			   98,   45,   98,   98,   97,   98,   98,   97,   98,   98,
			   52,   97,   98,   52,   98,   54,   97,   98,   54,   98,

			   97,   98,   98,   56,   97,   98,   56,   98,   97,   98,
			   98,   97,   98,   98,   61,   97,   98,   61,   98,   97,
			   98,   98,   97,   98,   98,   97,   98,   98,   97,   98,
			   98,   97,   98,   98,   97,   98,   98,   97,   98,   98,
			   97,   98,   98,   97,   98,   98,   80,   97,   98,   80,
			   98,   97,   98,   98,   82,   97,   98,   82,   98,   83,
			   97,   98,   83,   98,   85,   97,   98,   85,   98,   97,
			   98,   98,   97,   98,   98,   91,   97,   98,   91,   98,
			   97,   98,   98,  137,  136,  137,  139,  140,  140,  136,
			  138,  140,  138,   44,   97,   98,   44,   98,   97,   98,

			   98,   47,   97,   98,   47,   98,   97,   98,   98,   97,
			   98,   98,   97,   98,   98,   59,   97,   98,   59,   98,
			   63,   97,   98,   63,   98,   97,   98,   98,   65,   97,
			   98,   65,   98,   66,   97,   98,   66,   98,   97,   98,
			   98,   97,   98,   98,   97,   98,   98,   97,   98,   98,
			   97,   98,   98,   81,   97,   98,   81,   98,   97,   98,
			   98,   97,   98,   98,   93,   97,   98,   93,   98,  140,
			  140,  136,  137,  139,  140,  139,   46,   97,   98,   46,
			   98,   49,   97,   98,   49,   98,   55,   97,   98,   55,
			   98,   57,   97,   98,   57,   98,   64,   97,   98,   64,

			   98,   97,   98,   98,   73,   97,   98,   73,   98,   97,
			   98,   98,   79,   97,   98,   79,   98,   97,   98,   98,
			   86,   97,   98,   86,   98,   90,   97,   98,   90,   98,
			  140,  139,  140,  139,  140,  139,   67,   97,   98,   67,
			   98,   77,   97,   98,   77,   98,   78,   97,   98,   78,
			   98,  139,  140, yy_Dummy>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER is 2392
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER is 738
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER is 739
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
