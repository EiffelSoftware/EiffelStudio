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
			Result := (INITIAL <= sc and sc <= VERBATIM_STR1)
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
--|#line 29 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 29")
end
-- Ignore carriage return
when 2 then
--|#line 30 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 30")
end

					create {EDITOR_TOKEN_SPACE} curr_token.make(text_count)
					update_token_list
					
when 3 then
--|#line 34 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 34")
end

					create {EDITOR_TOKEN_TABULATION} curr_token.make(text_count)
					update_token_list
					
when 4 then
--|#line 38 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 38")
end

					from i_ := 1 until i_ > text_count loop
						create {EDITOR_TOKEN_EOL} curr_token.make
						update_token_list
						i_ := i_ + 1
					end
					in_comments := False
					
when 5 then
--|#line 50 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 50")
end
 
						-- comments
					if not in_verbatim_string then
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
						in_comments := True
					else
						create {EDITOR_TOKEN_STRING} curr_token.make(text)
					end					
					update_token_list					
				
when 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17 then
--|#line 63 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 63")
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
--|#line 89 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 89")
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
--|#line 124 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 124")
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
--|#line 204 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 204")
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
--|#line 223 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 223")
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
--|#line 240 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 240")
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
--|#line 259 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 259")
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
--|#line 294 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 294")
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
--|#line 314 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 314")
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
--|#line 341 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 341")
end

					-- Verbatim string opener.
				create {EDITOR_TOKEN_STRING} curr_token.make(text)
				update_token_list
				in_verbatim_string := True
				set_start_condition (VERBATIM_STR1)
			
when 129 then
--|#line 349 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 349")
end

					-- Verbatim string opener.
				create {EDITOR_TOKEN_STRING} curr_token.make(text)
				update_token_list
				in_verbatim_string := True
				set_start_condition (VERBATIM_STR1)
			
when 130 then
--|#line 358 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 358")
end
-- Ignore carriage return
when 131 then
--|#line 359 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 359")
end

							-- Verbatim string closer, possibly.
						create {EDITOR_TOKEN_STRING} curr_token.make(text)
						update_token_list	
						leave_verbatim_string := True
						set_start_condition (INITIAL)
					
when 132 then
--|#line 367 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 367")
end

							-- Verbatim string closer, possibly.
						create {EDITOR_TOKEN_STRING} curr_token.make(text)
						update_token_list
						leave_verbatim_string := True
						set_start_condition (INITIAL)
					
when 133 then
--|#line 375 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 375")
end

						create {EDITOR_TOKEN_SPACE} curr_token.make(text_count)
						update_token_list						
					
when 134 then
--|#line 380 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 380")
end

						create {EDITOR_TOKEN_TABULATION} curr_token.make(text_count)
						update_token_list						
					
when 135 then
--|#line 385 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 385")
end

						from i_ := 1 until i_ > text_count loop
							create {EDITOR_TOKEN_EOL} curr_token.make
							update_token_list
							i_ := i_ + 1
						end						
					
when 136 then
--|#line 393 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 393")
end

						create {EDITOR_TOKEN_STRING} curr_token.make(text)
						update_token_list
					
when 137, 138 then
--|#line 399 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 399")
end

					-- Eiffel String
					if not in_comments then						
						create {EDITOR_TOKEN_STRING} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
when 139 then
--|#line 412 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 412")
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
					
when 140, 141, 142, 143 then
--|#line 429 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 429")
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
						
when 144 then
--|#line 446 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 446")
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
						
when 145 then
	yy_end := yy_end - 1
--|#line 463 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 463")
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
						
when 146, 147 then
--|#line 464 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 464")
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
						
when 148 then
	yy_end := yy_end - 1
--|#line 466 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 466")
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
						
when 149, 150 then
--|#line 467 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 467")
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
						
when 151 then
--|#line 488 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 488")
end

					create {EDITOR_TOKEN_TEXT} curr_token.make(text)
					update_token_list
					
when 152 then
--|#line 496 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 496")
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
				
when 153 then
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
when 0, 1 then
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
			    0,    6,    7,    8,    9,   10,   11,   12,   13,   14,
			   15,   16,   17,   18,   19,   20,   21,   22,   23,   24,
			   25,   26,   27,   28,   29,   30,   31,   32,   33,   34,
			   35,   36,   37,   38,   39,   40,   40,   41,   40,   40,
			   42,   40,   43,   44,   45,   40,   46,   47,   48,   49,
			   50,   51,   52,   40,   40,   53,   54,   55,   56,   57,
			   58,   59,   60,   61,   62,   63,   64,   65,   65,   66,
			   65,   65,   67,   65,   68,   69,   70,   65,   71,   72,
			   73,   74,   75,   76,   77,   65,   65,   78,   79,   81,
			   82,   83,   84,   81,   82,   83,   84,   93,   93,  102,

			   94,   94,  100,  101,  104,  106,  105,  105,  105,  103,
			  115,  116,  107,  117,  118,  108,  603,  109,  109,  110,
			  108,  142,  109,  109,  110,  120,  108,  111,  110,  110,
			  110,  143,  111,  120,  166,  512,  131,  182,  152,  171,
			  167,  120,  153,  505,   85,   95,  120,  596,   85,  112,
			  203,  203,  203,  144,  181,  154,  113,  125,  403,  111,
			  403,  113,  403,  145,  111,  125,  168,  113,  131,  183,
			  155,  171,  169,  125,  156,   86,  390,   96,  125,   86,
			  389,  112,  120,  120,  120,  120,  181,  157,  183,  203,
			  192,  120,  120,  120,  120,  120,  120,  121,  120,  120,

			  120,  120,  122,  120,  123,  120,  120,  120,  120,  124,
			  120,  120,  120,  120,  120,  120,  120,  125,  388,  387,
			  183,  120,  193,  125,  125,  125,  125,  125,  125,  126,
			  125,  125,  125,  125,  127,  125,  128,  125,  125,  125,
			  125,  129,  125,  125,  125,  125,  125,  125,  125,  120,
			  120,  120,  198,  120,  193,  199,  386,  201,  120,  120,
			  120,  120,  120,  120,  120,  120,  130,  120,  120,  120,
			  120,  120,  120,  120,  120,  120,  120,  120,  120,  120,
			  120,  120,  120,  120,  199,  125,  193,  199,  120,  201,
			  125,  125,  125,  125,  125,  125,  125,  125,  131,  125,

			  125,  125,  125,  125,  125,  125,  125,  125,  125,  125,
			  125,  125,  125,  125,  125,  125,  132,  120,  385,  120,
			  133,  120,  146,  134,  147,  158,  135,  170,  120,  136,
			  172,  120,  159,  160,  148,  120,  196,  120,  161,  384,
			  173,  383,  174,  382,  180,  381,  175,  380,  137,  125,
			  197,  125,  138,  125,  149,  139,  150,  162,  140,  171,
			  125,  141,  176,  125,  163,  164,  151,  125,  196,  125,
			  165,  184,  177,  194,  178,  120,  181,  120,  179,  188,
			  120,  120,  197,  200,  144,  126,  185,  195,  379,  189,
			  127,  137,  128,   93,  145,  138,   94,  129,  139,  378,

			  377,  140,  259,  186,  141,  196,  376,  125,  149,  125,
			  150,  190,  125,  125,  375,  201,  144,  126,  187,  197,
			  151,  191,  127,  137,  128,  265,  145,  138,  155,  129,
			  139,  162,  156,  140,  259,  168,  141,  176,  163,  164,
			  149,  169,  150,  186,  165,  157,  190,  177,  206,  178,
			  207,  207,  151,  179,  267,  373,  191,  265,  187,  207,
			  155,  211,  207,  162,  156,  260,  372,  168,  261,  176,
			  163,  164,  371,  169,  269,  186,  165,  157,  190,  177,
			  207,  178,  207,  214,  208,  179,  267,  208,  191,  215,
			  187,  209,  205,  370,  209,   93,  216,  262,   94,  205,

			  263,  271,  222,  208,  222,  222,  269,   93,  258,  369,
			   94,  210,  120,  364,  212,  273,  223,  275,  223,  223,
			   93,   93,  363,  365,   94,  248,  248,  248,  252,  252,
			  252,  264,  362,  271,  209,  208,  120,  225,  249,  262,
			  259,  253,  263,   95,  125,  213,  277,  273,  108,  275,
			  254,  254,  255,   90,  108,   95,  255,  255,  255,  279,
			  111,  120,   93,  265,  250,   94,  209,   89,  125,   95,
			  249,  262,  268,  253,  263,   96,  218,   88,  277,  219,
			   98,   98,   98,  257,  257,  257,   87,   96,  220,  113,
			  210,  279,  111,  125,   98,  113,   98,  120,   98,   98,

			  221,   96,  120,   98,  269,   98,  202,  266,  119,   98,
			  366,   98,  114,   94,   98,   98,   98,   98,   98,   98,
			  226,   91,  203,  227,  228,  229,  230,   93,  366,  125,
			  368,  365,  231,  270,  125,   90,  120,  120,  232,  267,
			  233,  274,  234,  235,  236,  237,  272,  238,  276,  239,
			   89,   88,  120,  240,  120,  241,  285,  120,  242,  243,
			  244,  245,  246,  247,  288,  271,  278,  280,  125,  125,
			  295,  281,  282,  275,  120,  120,  283,  286,  273,  289,
			  277,  297,  120,  120,  125,  284,  125,  292,  285,  125,
			  290,  293,  287,  296,  291,  299,  288,  120,  279,  282,

			  294,  120,  295,  283,  282,  120,  125,  125,  283,  288,
			  120,  289,  120,  297,  125,  125,  298,  285,  301,  292,
			   87,  120,  292,  293,  289,  297,  293,  299,  300,  125,
			  311,  302,  295,  125,  120,  303,  120,  125,  120,  306,
			  310,  317,  125,  307,  125,  316,  304,  314,  299,  305,
			  301,  120,  312,  125,  308,  120,  319,  309,  120,  315,
			  301,  318,  311,  306,  313,  321,  125,  307,  125,  320,
			  125,  306,  311,  317,  120,  307,  322,  317,  308,  314,
			  323,  309,  120,  125,  314,  325,  308,  125,  319,  309,
			  125,  315,  343,  319,  324,  772,  315,  321,  120,  772,

			  772,  321,  120,  332,  772,  333,  125,  345,  323,  772,
			  120,  342,  323,  334,  125,  772,  335,  325,  336,  337,
			  120,  340,  346,  338,  343,  341,  325,  339,  344,  347,
			  125,  326,  120,  327,  125,  332,  120,  333,  356,  345,
			  772,  328,  125,  343,  329,  334,  330,  331,  335,  120,
			  336,  337,  125,  340,  347,  340,  355,  341,  354,  341,
			  345,  347,  357,  332,  125,  333,  348,  351,  125,  359,
			  357,  349,  352,  334,  361,  772,  335,  120,  336,  337,
			  358,  125,  350,  353,  120,  772,  360,  772,  355,  772,
			  355,  203,  203,  203,  357,  374,  374,  374,  351,  351,

			  772,  359,  772,  352,  352,  206,  361,  207,  207,  125,
			  772,  772,  359,  406,  353,  353,  125,  207,  361,  207,
			  207,  207,  772,  211,  207,  207,  208,  207,  214,  208,
			  203,  215,  209,   93,  205,  209,  365,  216,  772,  120,
			  205,  394,  394,  394,  772,  406,  367,  367,  367,  222,
			  772,  222,  222,  223,   93,  223,  223,   94,   93,  772,
			  208,   94,  404,  404,  404,  391,  391,  391,  392,  772,
			  392,  125,  208,  393,  393,  393,  212,  407,  249,  772,
			  208,  395,  395,  395,  108,  120,  401,  401,  401,  408,
			  398,  209,  398,  772,  396,  399,  399,  399,  120,  409,

			  120,  203,   95,  209,  250,  405,   95,  213,  410,  408,
			  249,  209,  108,  120,  400,  400,  401,  125,  412,  120,
			  397,  408,  411,  414,  111,  113,  396,  416,  120,  413,
			  125,  410,  125,  120,   96,  417,  418,  406,   96,  120,
			  410,  420,  422,  120,  424,  125,  415,  426,  419,  120,
			  412,  125,  120,  113,  412,  414,  111,  120,  423,  416,
			  125,  414,  120,  428,  421,  125,  425,  418,  418,  427,
			  120,  125,  434,  420,  422,  125,  424,  429,  416,  426,
			  420,  125,  433,  431,  125,  120,  120,  436,  120,  125,
			  424,  430,  438,  120,  125,  428,  422,  432,  426,  437,

			  441,  428,  125,  435,  434,  120,  444,  772,  443,  431,
			  446,  448,  445,  442,  434,  431,  120,  125,  125,  436,
			  125,  120,  120,  432,  438,  125,  439,  450,  449,  432,
			  447,  438,  441,  451,  120,  436,  452,  125,  444,  440,
			  444,  120,  446,  448,  446,  442,  453,  454,  125,  455,
			  120,  456,  458,  125,  125,  120,  120,  120,  441,  450,
			  450,  120,  448,  457,  460,  452,  125,  459,  452,  120,
			  461,  442,  462,  125,  120,  464,  466,  772,  454,  454,
			  463,  456,  125,  456,  458,  120,  120,  125,  125,  125,
			  465,  468,  469,  125,  120,  458,  460,  471,  470,  460,

			  120,  125,  462,  472,  462,  467,  125,  464,  466,  120,
			  473,  120,  464,  475,  478,  479,  120,  125,  125,  120,
			  477,  480,  466,  468,  470,  481,  125,  482,  474,  472,
			  470,  476,  125,  120,  483,  472,  484,  468,  486,  120,
			  488,  125,  475,  125,  485,  475,  478,  480,  125,  493,
			  487,  125,  478,  480,  120,  490,  120,  482,  489,  482,
			  476,  492,  120,  476,  491,  125,  484,  494,  484,  495,
			  486,  125,  488,  496,  497,  498,  486,  500,  120,  120,
			  120,  494,  488,  499,  772,  772,  125,  490,  125,   93,
			  490,  772,  365,  492,  125,  366,  492,  516,  365,  494,

			  772,  496,  393,  393,  393,  496,  498,  498,  772,  500,
			  125,  125,  125,   93,  772,  500,  365,  503,  503,  503,
			   98,  502,  374,  374,  374,   98,  501,  501,  501,  516,
			  249,  504,  504,  504,  506,  506,  506,  507,  507,  507,
			  508,  772,  508,  772,  772,  509,  509,  509,  772,  772,
			  396,  510,  510,  510,  518,  772,  250,  399,  399,  399,
			  520,  772,  249,  511,  511,  511,  514,  514,  514,  513,
			  505,  400,  400,  401,  120,  513,  397,  401,  401,  401,
			  120,  111,  396,  522,  772,  515,  518,  519,  120,  120,
			  517,  120,  520,  521,  524,  525,  526,  120,  523,  120,

			  528,  530,  512,  529,  532,  203,  125,  120,  527,  531,
			  203,  120,  125,  111,  772,  522,  203,  516,  534,  520,
			  125,  125,  518,  125,  535,  522,  524,  526,  526,  125,
			  524,  125,  528,  530,  536,  530,  532,  120,  120,  125,
			  528,  532,  538,  125,  120,  120,  533,  537,  540,  539,
			  534,  542,  120,  544,  541,  545,  536,  546,  548,  120,
			  120,  543,  120,  549,  550,  551,  536,  120,  552,  125,
			  125,  554,  547,  120,  538,  772,  125,  125,  534,  538,
			  540,  540,  556,  542,  125,  544,  542,  546,  553,  546,
			  548,  125,  125,  544,  125,  550,  550,  552,  120,  125,

			  552,  558,  557,  554,  548,  125,  120,  555,  120,  560,
			  120,  562,  120,  120,  556,  561,  120,  559,  564,  563,
			  554,  120,  566,  120,  567,  568,  570,  120,  120,  572,
			  125,  573,  120,  558,  558,  565,  571,  569,  125,  556,
			  125,  560,  125,  562,  125,  125,  574,  562,  125,  560,
			  564,  564,  576,  125,  566,  125,  568,  568,  570,  125,
			  125,  572,  120,  574,  125,  578,  120,  566,  572,  570,
			  120,  580,  582,  577,  575,  581,  120,  584,  574,  120,
			  586,  120,  579,  120,  576,  583,  585,  120,  587,  588,
			  772,  120,  590,  120,  125,  592,  591,  578,  125,  594,

			  120,  120,  125,  580,  582,  578,  576,  582,  125,  584,
			  120,  125,  586,  125,  580,  125,  772,  584,  586,  125,
			  588,  588,  589,  125,  590,  125,  593,  592,  592,  772,
			  772,  594,  125,  125,  120,   93,  772,  772,  365,  503,
			  503,  503,  125,  598,  598,  598,  772,   98,  595,  595,
			  595,  120,  597,  772,  590,  599,  599,  599,  594,  600,
			  600,  600,  601,  601,  601,  120,  125,  509,  509,  509,
			  602,  602,  602,  610,  120,  396,  604,  604,  604,  605,
			  605,  605,  505,  125,  597,  606,  606,  606,  120,  601,
			  601,  601,  608,  609,  203,  203,  203,  125,  120,  120,

			  612,  397,  607,  618,  120,  610,  125,  396,  611,  603,
			  613,  615,  120,  120,  614,  616,  620,  617,  512,  622,
			  125,  621,  619,  623,  120,  610,  624,  120,  626,  628,
			  125,  125,  612,  113,  607,  618,  125,  630,  120,  120,
			  612,  632,  615,  615,  125,  125,  616,  616,  620,  618,
			  627,  622,  625,  622,  620,  624,  125,  120,  624,  125,
			  626,  628,  120,  120,  634,  636,  637,  629,  638,  630,
			  125,  125,  631,  632,  120,  639,  635,  640,  642,  633,
			  120,  641,  628,  643,  626,  644,  120,  120,  645,  125,
			  646,  648,  120,  120,  125,  125,  634,  636,  638,  630,

			  638,  649,  647,  650,  632,  652,  125,  640,  636,  640,
			  642,  634,  125,  642,  654,  644,  656,  644,  125,  125,
			  646,  658,  646,  648,  125,  125,  651,  653,  657,  120,
			  120,  120,  120,  650,  648,  650,  120,  652,  655,  660,
			  120,  120,  662,  663,  664,  120,  654,  659,  656,  665,
			  666,  120,  661,  658,  668,  120,  670,  772,  652,  654,
			  658,  125,  125,  125,  125,  667,  772,  772,  125,  120,
			  656,  660,  125,  125,  662,  664,  664,  125,  772,  660,
			  120,  666,  666,  125,  662,  669,  668,  125,  670,  671,
			   93,  671,  674,  365,  672,  672,  672,  668,  672,  672,

			  672,  125,   98,  673,  673,  673,  601,  601,  601,  676,
			  676,  676,  125,  677,  677,  677,  772,  670,  250,  675,
			  678,  678,  678,  120,  674,  679,  679,  679,  680,  680,
			  680,  686,  772,  681,  120,  681,  120,  505,  679,  679,
			  679,  683,  683,  683,  120,  685,  688,  120,  603,  690,
			  687,  675,  691,  692,  684,  125,  120,  120,  689,  120,
			  694,  693,  120,  686,  512,  120,  125,  695,  125,  696,
			  697,  698,  120,  120,  120,  120,  125,  686,  688,  125,
			  700,  690,  688,  699,  692,  692,  684,  702,  125,  125,
			  690,  125,  694,  694,  125,  120,  704,  125,  120,  696,

			  701,  696,  698,  698,  125,  125,  125,  125,  706,  703,
			  120,  708,  700,  120,  707,  700,  710,  712,  714,  702,
			  120,  705,  120,  120,  709,  713,  120,  125,  704,  716,
			  125,  715,  702,  711,  120,  717,  718,  120,  120,  120,
			  706,  704,  125,  708,  120,  125,  708,  720,  710,  712,
			  714,  120,  125,  706,  125,  125,  710,  714,  125,  120,
			  722,  716,  719,  716,  721,  712,  125,  718,  718,  125,
			  125,  125,  120,  120,  724,  772,  125,  772,  120,  720,
			  672,  672,  672,  125,  723,  672,  672,  672,  725,  725,
			  725,  125,  722,  726,  720,  726,  722,  731,  727,  727,

			  727,  729,  729,  729,  125,  125,  724,  728,  772,  728,
			  125,  772,  729,  729,  729,  737,  724,  730,  730,  730,
			  679,  679,  679,  397,  732,  732,  732,  120,  739,  731,
			  679,  679,  679,  733,  733,  733,  734,  741,  734,  120,
			  603,  735,  735,  735,  736,  738,  731,  737,  740,  120,
			  120,  743,  742,  120,  120,  120,  744,  745,  120,  125,
			  739,  120,  120,  120,  747,  749,  748,  120,  746,  741,
			  120,  125,  397,  750,  751,  752,  737,  739,  731,  120,
			  741,  125,  125,  743,  743,  125,  125,  125,  745,  745,
			  125,  753,  755,  125,  125,  125,  747,  749,  749,  125,

			  747,  120,  125,  754,  756,  751,  751,  753,  120,  120,
			  757,  125,  758,  759,  120,  772,  120,  727,  727,  727,
			  760,  760,  760,  753,  755,  729,  729,  729,  729,  729,
			  729,  772,  772,  125,  120,  755,  757,  761,  761,  761,
			  125,  125,  757,  120,  759,  759,  125,  762,  125,  762,
			  120,  120,  763,  763,  763,  678,  678,  678,  120,  505,
			  735,  735,  735,  764,  764,  764,  125,  120,  731,  766,
			  772,  120,  120,  768,  120,  125,  769,  770,  765,  120,
			  120,  767,  125,  125,  120,  725,  725,  725,  120,  120,
			  125,  763,  763,  763,  397,  771,  771,  771,  120,  125,

			  731,  766,  512,  125,  125,  768,  125,  772,  770,  770,
			  766,  125,  125,  768,  772,  772,  125,  732,  732,  732,
			  125,  125,  772,  772,  505,  761,  761,  761,  772,  772,
			  125,  256,  256,  256,  603,  125,  125,  125,  125,  125,
			  125,  125,  125,  125,  125,  125,  402,  402,  402,  772,
			  772,  772,  772,  402,  772,  772,  512,  772,  772,  772,
			  772,  772,  772,  772,  603,   80,   80,   80,   80,   80,
			   80,   80,   80,   80,   80,   80,   80,   80,   80,   80,
			   80,   80,   80,   80,   80,   92,   92,  772,   92,   92,
			   92,   92,   92,   92,   92,   92,   92,   92,   92,   92,

			   92,   92,   92,   92,   92,   97,  772,  772,  772,  772,
			  772,  772,   97,   97,   97,   97,   97,   97,   97,   97,
			   97,   97,   97,   97,   97,   98,   98,  772,   98,   98,
			   98,   98,   98,   98,   98,   98,   98,   98,   98,   98,
			   98,   98,   98,   98,   98,   99,   99,  772,   99,   99,
			   99,   99,   99,   99,   99,   99,   99,   99,   99,   99,
			   99,   99,   99,   99,   99,  204,  204,  772,  204,  204,
			  204,  772,  772,  204,  204,  204,  204,  204,  204,  204,
			  204,  204,  204,  204,  204,  205,  772,  772,  205,  772,
			  205,  205,  205,  205,  205,  205,  205,  205,  205,  205,

			  205,  205,  205,  205,  205,  212,  212,  772,  212,  212,
			  212,  212,  212,  212,  212,  212,  212,  212,  212,  212,
			  212,  212,  212,  212,  212,  213,  213,  772,  213,  213,
			  213,  213,  213,  213,  213,  213,  213,  213,  213,  213,
			  213,  213,  213,  213,  213,  217,  217,  772,  217,  217,
			  217,  217,  217,  217,  217,  217,  217,  217,  217,  217,
			  217,  217,  217,  217,  217,  224,  224,  772,  224,  224,
			  224,  224,  224,  224,  224,  224,  224,  224,  224,  224,
			  224,  224,  224,  224,  224,  251,  251,  251,  251,  251,
			  251,  251,  251,  772,  251,  251,  251,  251,  251,  251,

			  251,  251,  251,  251,  251,  208,  208,  772,  208,  208,
			  208,  772,  208,  208,  208,  208,  208,  208,  208,  208,
			  208,  208,  208,  208,  208,  209,  209,  772,  209,  209,
			  209,  772,  209,  209,  209,  209,  209,  209,  209,  209,
			  209,  209,  209,  209,  209,  682,  682,  682,  682,  682,
			  682,  682,  682,  772,  682,  682,  682,  682,  682,  682,
			  682,  682,  682,  682,  682,    5,  772,  772,  772,  772,
			  772,  772,  772,  772,  772,  772,  772,  772,  772,  772,
			  772,  772,  772,  772,  772,  772,  772,  772,  772,  772,
			  772,  772,  772,  772,  772,  772,  772,  772,  772,  772,

			  772,  772,  772,  772,  772,  772,  772,  772,  772,  772,
			  772,  772,  772,  772,  772,  772,  772,  772,  772,  772,
			  772,  772,  772,  772,  772,  772,  772,  772,  772,  772,
			  772,  772,  772,  772,  772,  772,  772,  772,  772,  772,
			  772,  772,  772,  772,  772,  772,  772,  772,  772,  772,
			  772,  772,  772,  772, yy_Dummy>>)
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
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    3,
			    3,    3,    3,    4,    4,    4,    4,   12,   15,   22,

			   12,   15,   16,   16,   23,   24,   23,   23,   23,   22,
			   30,   30,   24,   32,   32,   25,  761,   25,   25,   25,
			   26,   37,   26,   26,   26,   37,   27,   25,   27,   27,
			   27,   37,   26,   40,   42,  732,   60,   46,   39,   68,
			   42,   46,   39,  725,    3,   12,   39,  502,    4,   25,
			   57,   57,   57,   37,   70,   39,   25,   37,  403,   25,
			  402,   26,  256,   37,   26,   40,   42,   27,   60,   46,
			   39,   68,   42,   46,   39,    3,  247,   12,   39,    4,
			  246,   25,   34,   34,   34,   49,   70,   39,   71,   57,
			   49,   34,   34,   34,   34,   34,   34,   34,   34,   34,

			   34,   34,   34,   34,   34,   34,   34,   34,   34,   34,
			   34,   34,   34,   34,   34,   34,   34,   49,  245,  244,
			   71,   34,   49,   34,   34,   34,   34,   34,   34,   34,
			   34,   34,   34,   34,   34,   34,   34,   34,   34,   34,
			   34,   34,   34,   34,   34,   34,   34,   34,   34,   35,
			   35,   35,   51,   51,   74,   76,  243,   77,   35,   35,
			   35,   35,   35,   35,   35,   35,   35,   35,   35,   35,
			   35,   35,   35,   35,   35,   35,   35,   35,   35,   35,
			   35,   35,   35,   35,   51,   51,   74,   76,   35,   77,
			   35,   35,   35,   35,   35,   35,   35,   35,   35,   35,

			   35,   35,   35,   35,   35,   35,   35,   35,   35,   35,
			   35,   35,   35,   35,   35,   35,   36,   36,  242,   38,
			   36,   43,   38,   36,   38,   41,   36,   43,   41,   36,
			   44,  120,   41,   41,   38,   45,   75,   44,   41,  241,
			   44,  240,   44,  239,   45,  238,   44,  237,   36,   36,
			   75,   38,   36,   43,   38,   36,   38,   41,   36,   43,
			   41,   36,   44,  120,   41,   41,   38,   45,   75,   44,
			   41,   47,   44,   50,   44,   47,   45,   52,   44,   48,
			   48,   50,   75,   52,   62,   59,   47,   50,  236,   48,
			   59,   61,   59,   98,   62,   61,   98,   59,   61,  235,

			  234,   61,  126,   47,   61,   50,  233,   47,   63,   52,
			   63,   48,   48,   50,  232,   52,   62,   59,   47,   50,
			   63,   48,   59,   61,   59,  128,   62,   61,   64,   59,
			   61,   66,   64,   61,  126,   67,   61,   69,   66,   66,
			   63,   67,   63,   72,   66,   64,   73,   69,   81,   69,
			   81,   81,   63,   69,  129,  230,   73,  128,   72,   83,
			   64,   83,   83,   66,   64,  122,  229,   67,  122,   69,
			   66,   66,  228,   67,  131,   72,   66,   64,   73,   69,
			   84,   69,   84,   84,   85,   69,  129,   85,   73,   85,
			   72,   86,   85,  227,   86,   92,   86,  122,   92,   86,

			  122,  137,   95,   81,   95,   95,  131,   95,  121,  226,
			   95,  210,  121,  209,   83,  138,   96,  139,   96,   96,
			  217,   96,  208,  217,   96,  105,  105,  105,  108,  108,
			  108,  123,  204,  137,   81,   84,  123,   99,  105,  127,
			  121,  108,  127,   92,  121,   83,  140,  138,  109,  139,
			  109,  109,  109,   90,  110,   95,  110,  110,  110,  141,
			  109,  130,  218,  123,  105,  218,   84,   89,  123,   96,
			  105,  127,  130,  108,  127,   92,   94,   88,  140,   94,
			   94,   94,   94,  113,  113,  113,   87,   95,   94,  109,
			   82,  141,  109,  130,   94,  110,   94,  124,   94,   94,

			   94,   96,  143,   94,  130,   94,   54,  124,   33,   94,
			  219,   94,   28,  219,   94,   94,   94,   94,   94,   94,
			  100,   11,  113,  100,  100,  100,  100,  221,  365,  124,
			  221,  365,  100,  132,  143,   10,  134,  132,  100,  124,
			  100,  134,  100,  100,  100,  100,  133,  100,  135,  100,
			    9,    8,  135,  100,  133,  100,  149,  136,  100,  100,
			  100,  100,  100,  100,  150,  132,  136,  142,  134,  132,
			  155,  142,  144,  134,  142,  146,  144,  147,  133,  150,
			  135,  156,  147,  148,  135,  146,  133,  151,  149,  136,
			  148,  151,  147,  153,  148,  157,  150,  152,  136,  142,

			  152,  153,  155,  142,  144,  158,  142,  146,  144,  147,
			  154,  150,  161,  156,  147,  148,  154,  146,  163,  151,
			    7,  159,  148,  151,  147,  153,  148,  157,  159,  152,
			  168,  160,  152,  153,  170,  160,  160,  158,  166,  164,
			  166,  171,  154,  164,  161,  170,  160,  169,  154,  160,
			  163,  172,  167,  159,  164,  175,  176,  164,  167,  169,
			  159,  172,  168,  160,  167,  177,  170,  160,  160,  173,
			  166,  164,  166,  171,  173,  164,  174,  170,  160,  169,
			  178,  160,  174,  172,  167,  181,  164,  175,  176,  164,
			  167,  169,  187,  172,  180,    5,  167,  177,  180,    0,

			    0,  173,  185,  183,    0,  183,  173,  190,  174,    0,
			  189,  185,  178,  183,  174,    0,  183,  181,  183,  183,
			  184,  186,  189,  184,  187,  186,  180,  184,  188,  191,
			  180,  182,  188,  182,  185,  183,  182,  183,  195,  190,
			    0,  182,  189,  185,  182,  183,  182,  182,  183,  194,
			  183,  183,  184,  186,  189,  184,  196,  186,  194,  184,
			  188,  191,  197,  182,  188,  182,  192,  193,  182,  199,
			  195,  192,  193,  182,  201,    0,  182,  200,  182,  182,
			  198,  194,  192,  193,  198,    0,  200,    0,  196,    0,
			  194,  203,  203,  203,  197,  231,  231,  231,  192,  193,

			    0,  199,    0,  192,  193,  206,  201,  206,  206,  200,
			    0,    0,  198,  259,  192,  193,  198,  207,  200,  207,
			  207,  211,    0,  211,  211,  214,  212,  214,  214,  212,
			  203,  212,  213,  220,  212,  213,  220,  213,    0,  261,
			  213,  250,  250,  250,    0,  259,  220,  220,  220,  222,
			    0,  222,  222,  223,  222,  223,  223,  222,  223,    0,
			  206,  223,  257,  257,  257,  248,  248,  248,  249,    0,
			  249,  261,  207,  249,  249,  249,  211,  260,  248,    0,
			  214,  252,  252,  252,  255,  260,  255,  255,  255,  262,
			  253,  206,  253,    0,  252,  253,  253,  253,  264,  266,

			  258,  257,  222,  207,  248,  258,  223,  211,  267,  260,
			  248,  214,  254,  268,  254,  254,  254,  260,  271,  272,
			  252,  262,  270,  273,  254,  255,  252,  275,  270,  272,
			  264,  266,  258,  274,  222,  276,  277,  258,  223,  278,
			  267,  279,  282,  276,  283,  268,  274,  285,  278,  286,
			  271,  272,  280,  254,  270,  273,  254,  287,  281,  275,
			  270,  272,  281,  289,  280,  274,  284,  276,  277,  287,
			  284,  278,  293,  279,  282,  276,  283,  290,  274,  285,
			  278,  286,  291,  292,  280,  290,  291,  295,  296,  287,
			  281,  290,  297,  294,  281,  289,  280,  292,  284,  296,

			  299,  287,  284,  294,  293,  300,  301,    0,  300,  290,
			  306,  307,  302,  299,  291,  292,  302,  290,  291,  295,
			  296,  304,  298,  290,  297,  294,  298,  308,  304,  292,
			  303,  296,  299,  305,  303,  294,  309,  300,  301,  298,
			  300,  305,  306,  307,  302,  299,  310,  311,  302,  312,
			  310,  314,  315,  304,  298,  316,  313,  312,  298,  308,
			  304,  318,  303,  313,  319,  305,  303,  318,  309,  320,
			  322,  298,  323,  305,  322,  325,  332,    0,  310,  311,
			  324,  312,  310,  314,  315,  329,  324,  316,  313,  312,
			  326,  333,  328,  318,  326,  313,  319,  329,  334,  318,

			  328,  320,  322,  335,  323,  327,  322,  325,  332,  327,
			  330,  331,  324,  336,  337,  338,  330,  329,  324,  338,
			  331,  340,  326,  333,  328,  339,  326,  341,  330,  329,
			  334,  336,  328,  339,  342,  335,  343,  327,  345,  344,
			  347,  327,  330,  331,  344,  336,  337,  338,  330,  350,
			  346,  338,  331,  340,  346,  351,  349,  339,  348,  341,
			  330,  352,  348,  336,  349,  339,  342,  353,  343,  354,
			  345,  344,  347,  355,  356,  357,  344,  359,  358,  356,
			  360,  350,  346,  358,    0,    0,  346,  351,  349,  366,
			  348,    0,  366,  352,  348,  368,  349,  406,  368,  353,

			    0,  354,  392,  392,  392,  355,  356,  357,    0,  359,
			  358,  356,  360,  367,    0,  358,  367,  391,  391,  391,
			  368,  374,  374,  374,  374,  367,  367,  367,  367,  406,
			  391,  393,  393,  393,  394,  394,  394,  395,  395,  395,
			  396,    0,  396,    0,    0,  396,  396,  396,    0,    0,
			  395,  397,  397,  397,  408,    0,  391,  398,  398,  398,
			  410,    0,  391,  399,  399,  399,  404,  404,  404,  400,
			  393,  400,  400,  400,  405,  401,  395,  401,  401,  401,
			  407,  400,  395,  412,    0,  405,  408,  409,  413,  409,
			  407,  411,  410,  411,  414,  415,  416,  417,  413,  415,

			  418,  420,  399,  419,  422,  404,  405,  419,  417,  421,
			  400,  421,  407,  400,    0,  412,  401,  405,  424,  409,
			  413,  409,  407,  411,  425,  411,  414,  415,  416,  417,
			  413,  415,  418,  420,  426,  419,  422,  423,  427,  419,
			  417,  421,  428,  421,  429,  430,  423,  427,  431,  429,
			  424,  432,  433,  434,  430,  435,  425,  436,  438,  435,
			  437,  433,  439,  440,  442,  443,  426,  440,  444,  423,
			  427,  446,  437,  445,  428,    0,  429,  430,  423,  427,
			  431,  429,  448,  432,  433,  434,  430,  435,  445,  436,
			  438,  435,  437,  433,  439,  440,  442,  443,  447,  440,

			  444,  450,  449,  446,  437,  445,  449,  447,  451,  452,
			  453,  456,  455,  457,  448,  455,  459,  451,  460,  459,
			  445,  461,  464,  463,  465,  466,  468,  465,  467,  470,
			  447,  471,  469,  450,  449,  463,  469,  467,  449,  447,
			  451,  452,  453,  456,  455,  457,  472,  455,  459,  451,
			  460,  459,  475,  461,  464,  463,  465,  466,  468,  465,
			  467,  470,  473,  471,  469,  476,  477,  463,  469,  467,
			  474,  478,  480,  474,  473,  479,  481,  482,  472,  483,
			  484,  479,  477,  485,  475,  481,  483,  487,  489,  490,
			    0,  489,  492,  493,  473,  494,  493,  476,  477,  496,

			  497,  499,  474,  478,  480,  474,  473,  479,  481,  482,
			  491,  483,  484,  479,  477,  485,    0,  481,  483,  487,
			  489,  490,  491,  489,  492,  493,  495,  494,  493,    0,
			    0,  496,  497,  499,  495,  501,    0,    0,  501,  503,
			  503,  503,  491,  504,  504,  504,    0,  501,  501,  501,
			  501,  515,  503,    0,  491,  505,  505,  505,  495,  506,
			  506,  506,  507,  507,  507,  517,  495,  508,  508,  508,
			  509,  509,  509,  520,  521,  507,  510,  510,  510,  511,
			  511,  511,  504,  515,  503,  512,  512,  512,  519,  513,
			  513,  513,  514,  519,  514,  514,  514,  517,  523,  525,

			  526,  507,  513,  530,  531,  520,  521,  507,  525,  509,
			  527,  528,  529,  533,  527,  528,  534,  529,  511,  536,
			  519,  535,  533,  537,  535,  519,  538,  537,  540,  542,
			  523,  525,  526,  514,  513,  530,  531,  544,  545,  541,
			  525,  548,  527,  528,  529,  533,  527,  528,  534,  529,
			  541,  536,  539,  535,  533,  537,  535,  539,  538,  537,
			  540,  542,  543,  547,  550,  552,  553,  543,  554,  544,
			  545,  541,  547,  548,  549,  555,  551,  556,  558,  549,
			  551,  557,  541,  559,  539,  560,  561,  557,  563,  539,
			  564,  566,  563,  565,  543,  547,  550,  552,  553,  543,

			  554,  567,  565,  568,  547,  570,  549,  555,  551,  556,
			  558,  549,  551,  557,  572,  559,  574,  560,  561,  557,
			  563,  576,  564,  566,  563,  565,  569,  571,  575,  573,
			  569,  571,  575,  567,  565,  568,  577,  570,  573,  578,
			  579,  581,  582,  583,  584,  585,  572,  577,  574,  587,
			  588,  583,  581,  576,  590,  591,  594,    0,  569,  571,
			  575,  573,  569,  571,  575,  589,    0,    0,  577,  589,
			  573,  578,  579,  581,  582,  583,  584,  585,    0,  577,
			  593,  587,  588,  583,  581,  593,  590,  591,  594,  597,
			  595,  597,  600,  595,  597,  597,  597,  589,  598,  598,

			  598,  589,  595,  599,  599,  599,  601,  601,  601,  602,
			  602,  602,  593,  603,  603,  603,    0,  593,  600,  601,
			  604,  604,  604,  609,  600,  605,  605,  605,  606,  606,
			  606,  612,    0,  607,  611,  607,  613,  598,  607,  607,
			  607,  608,  608,  608,  614,  611,  616,  617,  602,  618,
			  614,  601,  619,  620,  608,  609,  619,  621,  617,  623,
			  626,  625,  627,  612,  605,  625,  611,  629,  613,  630,
			  631,  632,  633,  635,  631,  629,  614,  611,  616,  617,
			  636,  618,  614,  635,  619,  620,  608,  638,  619,  621,
			  617,  623,  626,  625,  627,  637,  640,  625,  639,  629,

			  637,  630,  631,  632,  633,  635,  631,  629,  642,  639,
			  641,  644,  636,  645,  643,  635,  646,  648,  650,  638,
			  649,  641,  643,  647,  645,  649,  651,  637,  640,  652,
			  639,  651,  637,  647,  653,  655,  656,  657,  659,  655,
			  642,  639,  641,  644,  661,  645,  643,  664,  646,  648,
			  650,  663,  649,  641,  643,  647,  645,  649,  651,  665,
			  666,  652,  663,  651,  665,  647,  653,  655,  656,  657,
			  659,  655,  667,  669,  670,    0,  661,    0,  685,  664,
			  671,  671,  671,  663,  669,  672,  672,  672,  673,  673,
			  673,  665,  666,  674,  663,  674,  665,  678,  674,  674,

			  674,  676,  676,  676,  667,  669,  670,  675,    0,  675,
			  685,    0,  675,  675,  675,  688,  669,  677,  677,  677,
			  679,  679,  679,  678,  680,  680,  680,  689,  692,  678,
			  681,  681,  681,  683,  683,  683,  684,  694,  684,  687,
			  676,  684,  684,  684,  687,  691,  683,  688,  693,  695,
			  691,  696,  695,  693,  697,  699,  701,  702,  701,  689,
			  692,  703,  705,  707,  708,  710,  709,  711,  707,  694,
			  709,  687,  683,  711,  712,  713,  687,  691,  683,  713,
			  693,  695,  691,  696,  695,  693,  697,  699,  701,  702,
			  701,  714,  716,  703,  705,  707,  708,  710,  709,  711,

			  707,  717,  709,  715,  719,  711,  712,  713,  719,  715,
			  720,  713,  721,  722,  723,    0,  721,  726,  726,  726,
			  727,  727,  727,  714,  716,  728,  728,  728,  729,  729,
			  729,    0,    0,  717,  736,  715,  719,  730,  730,  730,
			  719,  715,  720,  738,  721,  722,  723,  731,  721,  731,
			  740,  742,  731,  731,  731,  733,  733,  733,  744,  727,
			  734,  734,  734,  735,  735,  735,  736,  746,  733,  747,
			    0,  748,  750,  751,  752,  738,  754,  755,  746,  756,
			  754,  750,  740,  742,  758,  760,  760,  760,  765,  767,
			  744,  762,  762,  762,  733,  763,  763,  763,  769,  746,

			  733,  747,  735,  748,  750,  751,  752,    0,  754,  755,
			  746,  756,  754,  750,    0,    0,  758,  764,  764,  764,
			  765,  767,    0,    0,  760,  771,  771,  771,    0,    0,
			  769,  786,  786,  786,  763,  779,  779,  779,  779,  779,
			  779,  779,  779,  779,  779,  779,  789,  789,  789,    0,
			    0,    0,    0,  789,    0,    0,  764,    0,    0,    0,
			    0,    0,    0,    0,  771,  773,  773,  773,  773,  773,
			  773,  773,  773,  773,  773,  773,  773,  773,  773,  773,
			  773,  773,  773,  773,  773,  774,  774,    0,  774,  774,
			  774,  774,  774,  774,  774,  774,  774,  774,  774,  774,

			  774,  774,  774,  774,  774,  775,    0,    0,    0,    0,
			    0,    0,  775,  775,  775,  775,  775,  775,  775,  775,
			  775,  775,  775,  775,  775,  776,  776,    0,  776,  776,
			  776,  776,  776,  776,  776,  776,  776,  776,  776,  776,
			  776,  776,  776,  776,  776,  777,  777,    0,  777,  777,
			  777,  777,  777,  777,  777,  777,  777,  777,  777,  777,
			  777,  777,  777,  777,  777,  778,  778,    0,  778,  778,
			  778,    0,    0,  778,  778,  778,  778,  778,  778,  778,
			  778,  778,  778,  778,  778,  780,    0,    0,  780,    0,
			  780,  780,  780,  780,  780,  780,  780,  780,  780,  780,

			  780,  780,  780,  780,  780,  781,  781,    0,  781,  781,
			  781,  781,  781,  781,  781,  781,  781,  781,  781,  781,
			  781,  781,  781,  781,  781,  782,  782,    0,  782,  782,
			  782,  782,  782,  782,  782,  782,  782,  782,  782,  782,
			  782,  782,  782,  782,  782,  783,  783,    0,  783,  783,
			  783,  783,  783,  783,  783,  783,  783,  783,  783,  783,
			  783,  783,  783,  783,  783,  784,  784,    0,  784,  784,
			  784,  784,  784,  784,  784,  784,  784,  784,  784,  784,
			  784,  784,  784,  784,  784,  785,  785,  785,  785,  785,
			  785,  785,  785,    0,  785,  785,  785,  785,  785,  785,

			  785,  785,  785,  785,  785,  787,  787,    0,  787,  787,
			  787,    0,  787,  787,  787,  787,  787,  787,  787,  787,
			  787,  787,  787,  787,  787,  788,  788,    0,  788,  788,
			  788,    0,  788,  788,  788,  788,  788,  788,  788,  788,
			  788,  788,  788,  788,  788,  790,  790,  790,  790,  790,
			  790,  790,  790,    0,  790,  790,  790,  790,  790,  790,
			  790,  790,  790,  790,  790,  772,  772,  772,  772,  772,
			  772,  772,  772,  772,  772,  772,  772,  772,  772,  772,
			  772,  772,  772,  772,  772,  772,  772,  772,  772,  772,
			  772,  772,  772,  772,  772,  772,  772,  772,  772,  772,

			  772,  772,  772,  772,  772,  772,  772,  772,  772,  772,
			  772,  772,  772,  772,  772,  772,  772,  772,  772,  772,
			  772,  772,  772,  772,  772,  772,  772,  772,  772,  772,
			  772,  772,  772,  772,  772,  772,  772,  772,  772,  772,
			  772,  772,  772,  772,  772,  772,  772,  772,  772,  772,
			  772,  772,  772,  772, yy_Dummy>>)
		end

	yy_base_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,   87,   91,  795, 2665,  718,  648,  646,
			  630,  615,   90,    0, 2665,   91,   92, 2665, 2665, 2665,
			 2665, 2665,   82,   86,   86,   97,  102,  108,  586, 2665,
			   85, 2665,   87,  582,  162,  229,  280,   88,  282,  109,
			   96,  291,   97,  284,  300,  298,  104,  338,  343,  148,
			  344,  216,  340, 2665,  550, 2665, 2665,  130,    0,  350,
			   99,  355,  351,  368,  399,    0,  397,  398,   96,  407,
			  108,  155,  410,  410,  212,  307,  219,  214, 2665, 2665,
			    0,  446,  587,  457,  478,  482,  489,  584,  574,  563,
			  548, 2665,  488, 2665,  569,  500,  514,    0,  386,  526,

			  613,    0, 2665, 2665, 2665,  505, 2665, 2665,  508,  530,
			  536, 2665,    0,  563, 2665, 2665, 2665, 2665, 2665, 2665,
			  294,  475,  428,  499,  560,    0,  369,  502,  393,  407,
			  524,  426,  600,  617,  599,  615,  620,  468,  486,  475,
			  513,  513,  637,  565,  642,    0,  638,  645,  646,  609,
			  632,  643,  660,  664,  673,  630,  652,  652,  668,  684,
			  699,  675,    0,  674,  707,    0,  701,  721,  691,  716,
			  697,  693,  714,  737,  745,  718,  709,  733,  749,    0,
			  761,  752,  799,  771,  783,  765,  781,  746,  795,  773,
			  774,  780,  834,  835,  812,  801,  810,  825,  847,  836,

			  840,  828, 2665,  871,  521,    0,  903,  915,  515,  506,
			  508,  919,  924,  930,  923,    0,    0,  513,  555,  603,
			  926,  620,  947,  951, 2665, 2665,  498,  482,  461,  455,
			  444,  875,  403,  395,  389,  388,  377,  336,  334,  332,
			  330,  328,  307,  245,  208,  207,  169,  165,  945,  953,
			  921, 2665,  961,  975,  994,  966,  103,  942,  963,  871,
			  948,  902,  960,    0,  961,    0,  962,  971,  976,    0,
			  991,  987,  982,  976,  996,  977, 1006, 1007, 1002,  995,
			 1015, 1025,  993, 1011, 1033, 1014, 1012, 1020,    0, 1014,
			 1048, 1049, 1054, 1039, 1056, 1040, 1051, 1044, 1085, 1059,

			 1068, 1066, 1079, 1097, 1084, 1104, 1077, 1078, 1083, 1107,
			 1113, 1114, 1120, 1119, 1122, 1108, 1118,    0, 1124, 1121,
			 1132,    0, 1137, 1139, 1149, 1144, 1157, 1172, 1163, 1148,
			 1179, 1174, 1143, 1158, 1169, 1154, 1182, 1168, 1182, 1196,
			 1188, 1198, 1197, 1199, 1202, 1196, 1217, 1207, 1225, 1219,
			 1212, 1222, 1216, 1230, 1232, 1236, 1242, 1243, 1241, 1235,
			 1243,    0, 2665, 2665, 2665,  621, 1282, 1306, 1288, 2665,
			 2665, 2665, 2665, 2665, 1302, 2665, 2665, 2665, 2665, 2665,
			 2665, 2665, 2665, 2665, 2665, 2665, 2665, 2665, 2665, 2665,
			 2665, 1297, 1282, 1311, 1314, 1317, 1325, 1331, 1337, 1343,

			 1351, 1357,  101,   99, 1346, 1337, 1249, 1343, 1307, 1352,
			 1325, 1354, 1344, 1351, 1347, 1362, 1363, 1360, 1352, 1370,
			 1368, 1374, 1369, 1400, 1372, 1387, 1397, 1401, 1396, 1407,
			 1408, 1406, 1405, 1415, 1407, 1422, 1424, 1423, 1409, 1425,
			 1430,    0, 1431, 1428, 1431, 1436, 1419, 1461, 1436, 1469,
			 1468, 1471, 1463, 1473,    0, 1475, 1471, 1476,    0, 1479,
			 1478, 1484,    0, 1486, 1473, 1490, 1491, 1491, 1480, 1495,
			 1488, 1494, 1509, 1525, 1533, 1503, 1525, 1529, 1518, 1544,
			 1541, 1539, 1531, 1542, 1536, 1546,    0, 1550,    0, 1554,
			 1555, 1573, 1543, 1556, 1555, 1597, 1570, 1563,    0, 1564,

			    0, 1628,  136, 1619, 1623, 1635, 1639, 1642, 1647, 1650,
			 1656, 1659, 1665, 1669, 1674, 1614,    0, 1628,    0, 1651,
			 1631, 1637,    0, 1661,    0, 1662, 1654, 1677, 1678, 1675,
			 1661, 1667,    0, 1676, 1670, 1687, 1685, 1690, 1693, 1720,
			 1696, 1702, 1681, 1725, 1695, 1701,    0, 1726, 1695, 1737,
			 1722, 1743, 1732, 1729, 1731, 1738, 1740, 1750, 1747, 1746,
			 1748, 1749,    0, 1755, 1757, 1756, 1745, 1764, 1766, 1793,
			 1772, 1794, 1781, 1792, 1770, 1795, 1788, 1799, 1791, 1803,
			    0, 1804, 1794, 1814, 1815, 1808,    0, 1812, 1813, 1832,
			 1821, 1818,    0, 1843, 1814, 1883, 2665, 1874, 1878, 1883,

			 1859, 1886, 1889, 1893, 1900, 1905, 1908, 1918, 1921, 1886,
			    0, 1897, 1883, 1899, 1907,    0, 1903, 1910, 1901, 1919,
			 1920, 1920,    0, 1922,    0, 1928, 1927, 1925,    0, 1938,
			 1940, 1937, 1938, 1935,    0, 1936, 1933, 1958, 1945, 1961,
			 1948, 1973, 1960, 1985, 1982, 1976, 1968, 1986, 1970, 1983,
			 1976, 1989, 1987, 1997,    0, 2002, 2003, 2000,    0, 2001,
			    0, 2007,    0, 2014, 1999, 2022, 2018, 2035,    0, 2036,
			 2026, 2060, 2065, 2068, 2078, 2092, 2081, 2097, 2064, 2100,
			 2104, 2110, 2665, 2113, 2121, 2041,    0, 2102, 2073, 2090,
			    0, 2113, 2096, 2116, 2105, 2112, 2111, 2117,    0, 2118,

			    0, 2121, 2122, 2124,    0, 2125,    0, 2126, 2122, 2133,
			 2132, 2130, 2131, 2142, 2158, 2172, 2161, 2164,    0, 2171,
			 2177, 2179, 2180, 2177,    0,   84, 2197, 2200, 2205, 2208,
			 2217, 2232,   76, 2235, 2240, 2243, 2197,    0, 2206,    0,
			 2213,    0, 2214,    0, 2221,    0, 2230, 2221, 2234,    0,
			 2235, 2227, 2237,    0, 2243, 2244, 2242,    0, 2247,    0,
			 2265,   57, 2271, 2275, 2297, 2251,    0, 2252,    0, 2261,
			    0, 2305, 2665, 2364, 2384, 2404, 2424, 2444, 2464, 2325,
			 2484, 2504, 2524, 2544, 2564, 2584, 2321, 2604, 2624, 2336,
			 2644, yy_Dummy>>)
		end

	yy_def_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,  772,    1,  773,  773,  772,  772,  772,  772,  772,
			  772,  772,  774,  775,  772,  776,  777,  772,  772,  772,
			  772,  772,  772,  772,  772,  772,  772,  772,  772,  772,
			  772,  772,  772,  772,  772,  772,   35,   35,   35,   35,
			   35,   35,   35,   35,   35,   35,   35,   35,   35,   35,
			   35,   35,   35,  772,  772,  772,  772,  772,  778,  779,
			  779,  779,  779,  779,  779,  779,  779,  779,  779,  779,
			  779,  779,  779,  779,  779,  779,  779,  779,  772,  772,
			  780,  772,  772,  780,  772,  781,  782,  772,  772,  772,
			  772,  772,  774,  772,  783,  774,  774,  775,  776,  784,

			  784,  784,  772,  772,  772,  772,  772,  772,  785,  772,
			  772,  772,  786,  772,  772,  772,  772,  772,  772,  772,
			   35,   35,   35,   35,   35,  779,  779,  779,  779,  779,
			   35,  779,   35,   35,   35,   35,   35,  779,  779,  779,
			  779,  779,   35,   35,  779,  779,   35,   35,   35,  779,
			  779,  779,   35,   35,   35,  779,  779,  779,   35,   35,
			   35,   35,  779,  779,  779,  779,   35,   35,  779,  779,
			   35,  779,   35,   35,   35,   35,  779,  779,  779,  779,
			   35,  779,   35,  779,   35,   35,  779,  779,   35,   35,
			  779,  779,   35,  779,   35,   35,  779,  779,   35,  779,

			   35,  779,  772,  772,  778,  780,  772,  772,  787,  788,
			  772,  780,  781,  782,  772,  780,  780,  783,  776,  776,
			  783,  783,  774,  774,  772,  772,  772,  772,  772,  772,
			  772,  772,  772,  772,  772,  772,  772,  772,  772,  772,
			  772,  772,  772,  772,  772,  772,  772,  772,  772,  772,
			  772,  772,  772,  772,  772,  772,  789,  772,   35,  779,
			   35,   35,  779,  779,   35,  779,   35,  779,   35,  779,
			   35,  779,   35,  779,   35,  779,   35,  779,   35,  779,
			   35,   35,  779,  779,   35,  779,   35,   35,  779,  779,
			   35,   35,  779,  779,   35,  779,   35,  779,   35,  779,

			   35,  779,   35,   35,   35,   35,  779,  779,  779,  779,
			   35,  779,   35,   35,  779,  779,   35,  779,   35,  779,
			   35,  779,   35,  779,   35,  779,   35,   35,   35,   35,
			   35,   35,  779,  779,  779,  779,  779,  779,   35,   35,
			  779,  779,   35,  779,   35,  779,   35,  779,   35,   35,
			   35,  779,  779,  779,   35,  779,   35,  779,   35,  779,
			   35,  779,  772,  772,  772,  783,  783,  783,  783,  772,
			  772,  772,  772,  772,  772,  772,  772,  772,  772,  772,
			  772,  772,  772,  772,  772,  772,  772,  772,  772,  772,
			  772,  772,  772,  772,  772,  772,  772,  772,  772,  772,

			  772,  772,  789,  789,  772,   35,  779,   35,  779,   35,
			  779,   35,  779,   35,  779,   35,  779,   35,  779,   35,
			  779,   35,  779,   35,  779,   35,  779,   35,  779,   35,
			   35,  779,  779,   35,  779,   35,  779,   35,  779,   35,
			   35,  779,  779,   35,  779,   35,  779,   35,  779,   35,
			  779,   35,  779,   35,  779,   35,  779,   35,  779,   35,
			  779,   35,  779,   35,  779,   35,  779,   35,  779,   35,
			  779,   35,  779,   35,   35,  779,  779,   35,  779,   35,
			  779,   35,  779,   35,  779,   35,  779,   35,  779,   35,
			  779,   35,  779,   35,  779,   35,  779,   35,  779,   35,

			  779,  783,  772,  772,  772,  772,  772,  772,  772,  772,
			  772,  772,  772,  785,  772,   35,  779,   35,  779,   35,
			  779,   35,  779,   35,  779,   35,  779,   35,  779,   35,
			  779,   35,  779,   35,  779,   35,  779,   35,  779,   35,
			  779,   35,  779,   35,  779,   35,  779,   35,  779,   35,
			  779,   35,  779,   35,  779,   35,  779,   35,  779,   35,
			  779,   35,  779,   35,  779,   35,  779,   35,  779,   35,
			  779,   35,  779,   35,  779,   35,  779,   35,  779,   35,
			  779,   35,  779,   35,  779,   35,  779,   35,  779,   35,
			  779,   35,  779,   35,  779,  783,  772,  772,  772,  772,

			  772,  772,  772,  772,  772,  772,  772,  772,  790,   35,
			  779,   35,  779,   35,   35,  779,  779,   35,  779,   35,
			  779,   35,  779,   35,  779,   35,  779,   35,  779,   35,
			  779,   35,  779,   35,  779,   35,  779,   35,  779,   35,
			  779,   35,  779,   35,  779,   35,  779,   35,  779,   35,
			  779,   35,  779,   35,  779,   35,  779,   35,  779,   35,
			  779,   35,  779,   35,  779,   35,  779,   35,  779,   35,
			  779,  772,  772,  772,  772,  772,  772,  772,  772,  772,
			  772,  772,  772,  772,  772,   35,  779,   35,  779,   35,
			  779,   35,  779,   35,  779,   35,  779,   35,  779,   35,

			  779,   35,  779,   35,  779,   35,  779,   35,  779,   35,
			  779,   35,  779,   35,  779,   35,  779,   35,  779,   35,
			  779,   35,  779,   35,  779,  772,  772,  772,  772,  772,
			  772,  772,  772,  772,  772,  772,   35,  779,   35,  779,
			   35,  779,   35,  779,   35,  779,   35,  779,   35,  779,
			   35,  779,   35,  779,   35,  779,   35,  779,   35,  779,
			  772,  772,  772,  772,  772,   35,  779,   35,  779,   35,
			  779,  772,    0,  772,  772,  772,  772,  772,  772,  772,
			  772,  772,  772,  772,  772,  772,  772,  772,  772,  772,
			  772, yy_Dummy>>)
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
			    0,    1,    2,    3,    4,    5,    1,    6,    1,    1,
			    7,    8,    1,    1,    1,    1,    1,    1,    9,    1,
			   10,   11,   12,    1,    1,    1,    1,    1,    1,   10,
			   10,   10,   10,   10,   10,   13,   13,   13,   13,   13,
			   13,   13,   13,   13,   13,   13,   13,   13,   13,   13,
			   13,   13,   14,   15,   16,    1,    1,    1,    1,   17,
			    1,   10,   10,   10,   10,   10,   10,   13,   13,   13,
			   13,   13,   13,   13,   13,   13,   13,   13,   13,   13,
			   13,   13,   13,   13,   18,   19,   20,    1,    1, yy_Dummy>>)
		end

	yy_accept_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    1,    1,    1,    2,    3,    4,    6,    9,   11,
			   14,   17,   20,   23,   26,   29,   32,   34,   37,   40,
			   43,   46,   49,   52,   55,   58,   62,   66,   70,   73,
			   76,   79,   82,   85,   87,   91,   95,   99,  103,  107,
			  111,  115,  119,  123,  127,  131,  135,  139,  143,  147,
			  151,  155,  159,  163,  166,  168,  171,  174,  177,  179,
			  182,  185,  188,  191,  194,  197,  200,  203,  206,  209,
			  212,  215,  218,  221,  224,  227,  230,  233,  236,  239,
			  242,  244,  246,  248,  251,  253,  255,  257,  258,  259,
			  260,  261,  262,  263,  264,  265,  268,  271,  272,  273,

			  274,  275,  276,  277,  278,  279,  281,  282,  283,  283,
			  285,  287,  288,  288,  289,  290,  291,  292,  293,  294,
			  295,  297,  299,  301,  303,  306,  307,  308,  309,  310,
			  312,  314,  315,  317,  319,  321,  323,  325,  326,  327,
			  328,  329,  330,  332,  335,  336,  338,  340,  342,  344,
			  345,  346,  347,  349,  351,  353,  354,  355,  356,  359,
			  361,  363,  366,  368,  369,  370,  372,  374,  376,  377,
			  378,  380,  381,  383,  385,  387,  390,  391,  392,  393,
			  395,  397,  398,  400,  401,  403,  405,  406,  407,  409,
			  411,  412,  413,  415,  416,  418,  420,  421,  422,  424,

			  425,  427,  428,  429,  430,  430,  431,  432,  432,  432,
			  432,  433,  435,  436,  437,  438,  440,  442,  442,  444,
			  446,  446,  446,  448,  450,  451,  453,  454,  455,  456,
			  457,  458,  459,  460,  461,  462,  463,  464,  465,  466,
			  467,  468,  469,  470,  471,  472,  473,  474,  475,  477,
			  477,  477,  478,  480,  481,  483,  485,  486,  487,  489,
			  490,  492,  495,  496,  498,  501,  503,  505,  506,  509,
			  511,  513,  514,  516,  517,  519,  520,  522,  523,  525,
			  526,  528,  530,  531,  532,  534,  535,  538,  540,  542,
			  543,  545,  547,  548,  549,  551,  552,  554,  555,  557,

			  558,  560,  561,  563,  565,  567,  569,  570,  571,  572,
			  573,  575,  576,  578,  580,  581,  582,  585,  587,  589,
			  590,  593,  595,  597,  598,  600,  601,  603,  605,  607,
			  609,  611,  613,  614,  615,  616,  617,  618,  619,  621,
			  623,  624,  625,  627,  628,  630,  631,  633,  634,  636,
			  638,  640,  641,  642,  643,  645,  646,  648,  649,  651,
			  652,  655,  657,  658,  659,  660,  661,  662,  662,  663,
			  664,  665,  666,  667,  668,  669,  670,  671,  672,  673,
			  674,  675,  676,  677,  678,  679,  680,  681,  682,  683,
			  684,  685,  687,  687,  689,  689,  691,  691,  691,  691,

			  693,  695,  697,  698,  698,  699,  701,  702,  704,  705,
			  707,  708,  710,  711,  713,  714,  716,  717,  719,  720,
			  722,  723,  725,  726,  728,  729,  732,  734,  736,  737,
			  739,  741,  742,  743,  745,  746,  748,  749,  751,  752,
			  755,  757,  759,  760,  762,  763,  765,  766,  768,  769,
			  771,  772,  774,  775,  778,  780,  782,  783,  786,  788,
			  790,  791,  794,  796,  798,  799,  801,  802,  804,  805,
			  807,  808,  810,  811,  813,  815,  816,  817,  819,  820,
			  822,  823,  825,  826,  828,  829,  832,  834,  837,  839,
			  841,  842,  844,  845,  847,  848,  850,  851,  854,  856,

			  859,  861,  861,  862,  863,  865,  865,  865,  867,  867,
			  871,  871,  873,  873,  873,  875,  878,  880,  883,  885,
			  887,  888,  891,  893,  896,  898,  900,  901,  903,  904,
			  906,  907,  910,  912,  914,  915,  917,  918,  920,  921,
			  923,  924,  926,  927,  929,  930,  933,  935,  937,  938,
			  940,  941,  943,  944,  946,  947,  949,  950,  952,  953,
			  955,  956,  959,  961,  963,  964,  966,  967,  969,  970,
			  972,  973,  975,  976,  978,  979,  981,  982,  984,  985,
			  988,  990,  992,  993,  995,  996,  999, 1001, 1003, 1004,
			 1006, 1007, 1010, 1012, 1014, 1015, 1015, 1016, 1016, 1018,

			 1018, 1019, 1020, 1024, 1024, 1024, 1026, 1026, 1027, 1027,
			 1030, 1032, 1034, 1035, 1038, 1040, 1042, 1043, 1045, 1046,
			 1048, 1049, 1052, 1054, 1057, 1059, 1061, 1062, 1065, 1067,
			 1069, 1070, 1072, 1073, 1076, 1078, 1080, 1081, 1083, 1084,
			 1086, 1087, 1089, 1090, 1092, 1093, 1095, 1096, 1098, 1099,
			 1101, 1102, 1104, 1105, 1108, 1110, 1112, 1113, 1116, 1118,
			 1121, 1123, 1126, 1128, 1130, 1131, 1133, 1134, 1137, 1139,
			 1141, 1142, 1142, 1143, 1143, 1143, 1143, 1147, 1147, 1148,
			 1149, 1149, 1149, 1150, 1151, 1152, 1155, 1157, 1159, 1160,
			 1163, 1165, 1167, 1168, 1170, 1171, 1173, 1174, 1177, 1179,

			 1182, 1184, 1186, 1187, 1190, 1192, 1195, 1197, 1199, 1200,
			 1202, 1203, 1205, 1206, 1208, 1209, 1211, 1212, 1215, 1217,
			 1219, 1220, 1222, 1223, 1226, 1228, 1229, 1229, 1230, 1230,
			 1232, 1232, 1232, 1233, 1234, 1234, 1235, 1238, 1240, 1243,
			 1245, 1248, 1250, 1253, 1255, 1258, 1260, 1262, 1263, 1266,
			 1268, 1270, 1271, 1274, 1276, 1278, 1279, 1282, 1284, 1287,
			 1289, 1290, 1292, 1292, 1294, 1295, 1298, 1300, 1303, 1305,
			 1308, 1310, 1312, 1312, yy_Dummy>>)
		end

	yy_acclist_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,  136,  136,  154,  152,  153,    3,  152,  153,    4,
			  153,    1,  152,  153,    2,  152,  153,   10,  152,  153,
			  138,  152,  153,  102,  152,  153,   17,  152,  153,  138,
			  152,  153,  152,  153,   11,  152,  153,   12,  152,  153,
			   31,  152,  153,   30,  152,  153,    8,  152,  153,   29,
			  152,  153,    6,  152,  153,   32,  152,  153,  140,  144,
			  152,  153,  140,  144,  152,  153,  140,  144,  152,  153,
			    9,  152,  153,    7,  152,  153,   36,  152,  153,   34,
			  152,  153,   35,  152,  153,  152,  153,  100,  101,  152,
			  153,  100,  101,  152,  153,  100,  101,  152,  153,  100,

			  101,  152,  153,  100,  101,  152,  153,  100,  101,  152,
			  153,  100,  101,  152,  153,  100,  101,  152,  153,  100,
			  101,  152,  153,  100,  101,  152,  153,  100,  101,  152,
			  153,  100,  101,  152,  153,  100,  101,  152,  153,  100,
			  101,  152,  153,  100,  101,  152,  153,  100,  101,  152,
			  153,  100,  101,  152,  153,  100,  101,  152,  153,  100,
			  101,  152,  153,   15,  152,  153,  152,  153,   16,  152,
			  153,   33,  152,  153,  144,  152,  153,  152,  153,  101,
			  152,  153,  101,  152,  153,  101,  152,  153,  101,  152,
			  153,  101,  152,  153,  101,  152,  153,  101,  152,  153,

			  101,  152,  153,  101,  152,  153,  101,  152,  153,  101,
			  152,  153,  101,  152,  153,  101,  152,  153,  101,  152,
			  153,  101,  152,  153,  101,  152,  153,  101,  152,  153,
			  101,  152,  153,  101,  152,  153,   13,  152,  153,   14,
			  152,  153,  136,  153,  134,  153,  135,  153,  130,  136,
			  153,  133,  153,  136,  153,  136,  153,    3,    4,    1,
			    2,   37,  138,  137,  137, -128,  138, -281, -129,  138,
			 -282,  102,  138,  126,  126,  126,    5,   23,   24,  147,
			  150,   18,   20,  140,  144,  140,  144,  139,  144,   28,
			   25,   22,   21,   26,   27,  100,  101,  100,  101,  100,

			  101,  100,  101,   42,  100,  101,  101,  101,  101,  101,
			   42,  101,  100,  101,  101,  100,  101,  100,  101,  100,
			  101,  100,  101,  100,  101,  101,  101,  101,  101,  101,
			  100,  101,   53,  100,  101,  101,   53,  101,  100,  101,
			  100,  101,  100,  101,  101,  101,  101,  100,  101,  100,
			  101,  100,  101,  101,  101,  101,   65,  100,  101,  100,
			  101,  100,  101,   71,  100,  101,   65,  101,  101,  101,
			   71,  101,  100,  101,  100,  101,  101,  101,  100,  101,
			  101,  100,  101,  100,  101,  100,  101,   79,  100,  101,
			  101,  101,  101,   79,  101,  100,  101,  101,  100,  101,

			  101,  100,  101,  100,  101,  101,  101,  100,  101,  100,
			  101,  101,  101,  100,  101,  101,  100,  101,  100,  101,
			  101,  101,  100,  101,  101,  100,  101,  101,   19,  144,
			  136,  134,  135,  130,  136,  136,  136,  133,  131,  136,
			  132,  136,  137,  138,  137,  138, -128,  138, -129,  138,
			  126,  103,  126,  126,  126,  126,  126,  126,  126,  126,
			  126,  126,  126,  126,  126,  126,  126,  126,  126,  126,
			  126,  126,  126,  126,  126,  147,  150,  145,  147,  150,
			  145,  140,  144,  140,  144,  142,  144,  100,  101,  101,
			  100,  101,   40,  100,  101,  101,   40,  101,   41,  100,

			  101,   41,  101,  100,  101,  101,   44,  100,  101,   44,
			  101,  100,  101,  101,  100,  101,  101,  100,  101,  101,
			  100,  101,  101,  100,  101,  101,  100,  101,  100,  101,
			  101,  101,  100,  101,  101,   56,  100,  101,  100,  101,
			   56,  101,  101,  100,  101,  100,  101,  101,  101,  100,
			  101,  101,  100,  101,  101,  100,  101,  101,  100,  101,
			  101,  100,  101,  100,  101,  100,  101,  100,  101,  101,
			  101,  101,  101,  100,  101,  101,  100,  101,  100,  101,
			  101,  101,   75,  100,  101,   75,  101,  100,  101,  101,
			   77,  100,  101,   77,  101,  100,  101,  101,  100,  101,

			  101,  100,  101,  100,  101,  100,  101,  100,  101,  100,
			  101,  100,  101,  101,  101,  101,  101,  101,  101,  100,
			  101,  100,  101,  101,  101,  100,  101,  101,  100,  101,
			  101,  100,  101,  101,  100,  101,  100,  101,  100,  101,
			  101,  101,  101,  100,  101,  101,  100,  101,  101,  100,
			  101,  101,   99,  100,  101,   99,  101,  151,  131,  132,
			  137,  137,  137,  120,  118,  119,  121,  122,  127,  123,
			  124,  104,  105,  106,  107,  108,  109,  110,  111,  112,
			  113,  114,  115,  116,  117,  147,  150,  147,  150,  147,
			  150,  146,  149,  140,  144,  140,  144,  143,  144,  100,

			  101,  101,  100,  101,  101,  100,  101,  101,  100,  101,
			  101,  100,  101,  101,  100,  101,  101,  100,  101,  101,
			  100,  101,  101,  100,  101,  101,  100,  101,  101,   54,
			  100,  101,   54,  101,  100,  101,  101,  100,  101,  100,
			  101,  101,  101,  100,  101,  101,  100,  101,  101,  100,
			  101,  101,   63,  100,  101,  100,  101,   63,  101,  101,
			  100,  101,  101,  100,  101,  101,  100,  101,  101,  100,
			  101,  101,  100,  101,  101,   72,  100,  101,   72,  101,
			  100,  101,  101,   74,  100,  101,   74,  101,  100,  101,
			  101,   78,  100,  101,   78,  101,  100,  101,  101,  100,

			  101,  101,  100,  101,  101,  100,  101,  101,  100,  101,
			  101,  100,  101,  100,  101,  101,  101,  100,  101,  101,
			  100,  101,  101,  100,  101,  101,  100,  101,  101,   91,
			  100,  101,   91,  101,   92,  100,  101,   92,  101,  100,
			  101,  101,  100,  101,  101,  100,  101,  101,  100,  101,
			  101,   97,  100,  101,   97,  101,   98,  100,  101,   98,
			  101,  127,  147,  147,  150,  147,  150,  146,  147,  149,
			  150,  146,  149,  141,  144,   38,  100,  101,   38,  101,
			   39,  100,  101,   39,  101,  100,  101,  101,   45,  100,
			  101,   45,  101,   46,  100,  101,   46,  101,  100,  101,

			  101,  100,  101,  101,  100,  101,  101,   51,  100,  101,
			   51,  101,  100,  101,  101,  100,  101,  101,  100,  101,
			  101,  100,  101,  101,  100,  101,  101,  100,  101,  101,
			   61,  100,  101,   61,  101,  100,  101,  101,  100,  101,
			  101,  100,  101,  101,  100,  101,  101,  100,  101,  101,
			  100,  101,  101,  100,  101,  101,   73,  100,  101,   73,
			  101,  100,  101,  101,  100,  101,  101,  100,  101,  101,
			  100,  101,  101,  100,  101,  101,  100,  101,  101,  100,
			  101,  101,  100,  101,  101,   87,  100,  101,   87,  101,
			  100,  101,  101,  100,  101,  101,   90,  100,  101,   90,

			  101,  100,  101,  101,  100,  101,  101,   95,  100,  101,
			   95,  101,  100,  101,  101,  125,  147,  150,  150,  147,
			  146,  147,  149,  150,  146,  149,  145,   43,  100,  101,
			   43,  101,  100,  101,  101,   48,  100,  101,  100,  101,
			   48,  101,  101,  100,  101,  101,  100,  101,  101,   55,
			  100,  101,   55,  101,   57,  100,  101,   57,  101,  100,
			  101,  101,   59,  100,  101,   59,  101,  100,  101,  101,
			  100,  101,  101,   64,  100,  101,   64,  101,  100,  101,
			  101,  100,  101,  101,  100,  101,  101,  100,  101,  101,
			  100,  101,  101,  100,  101,  101,  100,  101,  101,  100,

			  101,  101,  100,  101,  101,   83,  100,  101,   83,  101,
			  100,  101,  101,   85,  100,  101,   85,  101,   86,  100,
			  101,   86,  101,   88,  100,  101,   88,  101,  100,  101,
			  101,  100,  101,  101,   94,  100,  101,   94,  101,  100,
			  101,  101,  147,  146,  147,  149,  150,  150,  146,  148,
			  150,  148,   47,  100,  101,   47,  101,  100,  101,  101,
			   50,  100,  101,   50,  101,  100,  101,  101,  100,  101,
			  101,  100,  101,  101,   62,  100,  101,   62,  101,   66,
			  100,  101,   66,  101,  100,  101,  101,   68,  100,  101,
			   68,  101,   69,  100,  101,   69,  101,  100,  101,  101,

			  100,  101,  101,  100,  101,  101,  100,  101,  101,  100,
			  101,  101,   84,  100,  101,   84,  101,  100,  101,  101,
			  100,  101,  101,   96,  100,  101,   96,  101,  150,  150,
			  146,  147,  149,  150,  149,   49,  100,  101,   49,  101,
			   52,  100,  101,   52,  101,   58,  100,  101,   58,  101,
			   60,  100,  101,   60,  101,   67,  100,  101,   67,  101,
			  100,  101,  101,   76,  100,  101,   76,  101,  100,  101,
			  101,   82,  100,  101,   82,  101,  100,  101,  101,   89,
			  100,  101,   89,  101,   93,  100,  101,   93,  101,  150,
			  149,  150,  149,  150,  149,   70,  100,  101,   70,  101,

			   80,  100,  101,   80,  101,   81,  100,  101,   81,  101,
			  149,  150, yy_Dummy>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER is 2665
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER is 772
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER is 773
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

	yyNb_rules: INTEGER is 153
			-- Number of rules

	yyEnd_of_buffer: INTEGER is 154
			-- End of buffer rule code

	yyLine_used: BOOLEAN is false
			-- Are line and column numbers used?

	yyPosition_used: BOOLEAN is false
			-- Is `position' used?

	INITIAL: INTEGER is 0
	VERBATIM_STR1: INTEGER is 1
			-- Start condition codes

feature -- User-defined features


end -- EDITOR_EIFFEL_SCANNER
