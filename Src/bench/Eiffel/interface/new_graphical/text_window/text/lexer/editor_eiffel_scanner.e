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
--|#line 30 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 30")
end
-- Ignore carriage return
when 2 then
--|#line 31 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 31")
end

					create {EDITOR_TOKEN_SPACE} curr_token.make(text_count)
					update_token_list
					
when 3 then
--|#line 35 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 35")
end

					create {EDITOR_TOKEN_TABULATION} curr_token.make(text_count)
					update_token_list
					
when 4 then
--|#line 39 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 39")
end

					from i_ := 1 until i_ > text_count loop
						create {EDITOR_TOKEN_EOL} curr_token.make
						update_token_list
						i_ := i_ + 1
					end
					in_comments := False
					
when 5 then
--|#line 51 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 51")
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
--|#line 64 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 64")
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
--|#line 90 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 90")
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
--|#line 125 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 125")
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
--|#line 205 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 205")
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
--|#line 224 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 224")
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
--|#line 241 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 241")
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
--|#line 260 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 260")
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
--|#line 295 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 295")
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
--|#line 315 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 315")
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
--|#line 342 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 342")
end

					-- Verbatim string opener.
				create {EDITOR_TOKEN_STRING} curr_token.make(text)
				update_token_list
				in_verbatim_string := True
				set_start_condition (VERBATIM_STR1)
			
when 129 then
--|#line 350 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 350")
end

					-- Verbatim string opener.
				create {EDITOR_TOKEN_STRING} curr_token.make(text)
				update_token_list
				in_verbatim_string := True
				set_start_condition (VERBATIM_STR1)
			
when 130 then
--|#line 359 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 359")
end
-- Ignore carriage return
when 131 then
--|#line 360 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 360")
end

							-- Verbatim string closer, possibly.
						create {EDITOR_TOKEN_STRING} curr_token.make(text)
						update_token_list	
						leave_verbatim_string := True
						set_start_condition (INITIAL)
					
when 132 then
--|#line 368 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 368")
end

							-- Verbatim string closer, possibly.
						create {EDITOR_TOKEN_STRING} curr_token.make(text)
						update_token_list
						leave_verbatim_string := True
						set_start_condition (INITIAL)
					
when 133 then
--|#line 376 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 376")
end

						create {EDITOR_TOKEN_SPACE} curr_token.make(text_count)
						update_token_list						
					
when 134 then
--|#line 381 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 381")
end

						create {EDITOR_TOKEN_TABULATION} curr_token.make(text_count)
						update_token_list						
					
when 135 then
--|#line 386 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 386")
end

						from i_ := 1 until i_ > text_count loop
							create {EDITOR_TOKEN_EOL} curr_token.make
							update_token_list
							i_ := i_ + 1
						end						
					
when 136 then
--|#line 394 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 394")
end

						create {EDITOR_TOKEN_STRING} curr_token.make(text)
						update_token_list
					
when 137, 138 then
--|#line 400 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 400")
end

					-- Eiffel String
					if not in_comments then						
						create {EDITOR_TOKEN_STRING} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
when 139 then
--|#line 413 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 413")
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
					
when 140, 141 then
--|#line 430 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 430")
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
						
when 142 then
--|#line 445 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 445")
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
						
when 143 then
	yy_end := yy_end - 1
--|#line 462 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 462")
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
						
when 146 then
	yy_end := yy_end - 1
--|#line 465 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 465")
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
						
when 147, 148 then
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
						
when 149 then
--|#line 487 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 487")
end

					create {EDITOR_TOKEN_TEXT} curr_token.make(text)
					update_token_list
					
when 150 then
--|#line 495 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 495")
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
				
when 151 then
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
			  115,  116,  107,  117,  118,  108,  604,  109,  109,  110,
			  108,  142,  109,  109,  110,  120,  108,  111,  110,  110,
			  110,  143,  111,  120,  166,  513,  131,  182,  152,  171,
			  167,  120,  153,  506,   85,   95,  120,  597,   85,  112,
			  203,  203,  203,  144,  181,  154,  113,  125,  403,  111,
			  403,  113,  391,  145,  111,  125,  168,  113,  131,  183,
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

			  377,  140,  260,  186,  141,  196,  376,  125,  149,  125,
			  150,  190,  125,  125,  374,  201,  144,  126,  187,  197,
			  151,  191,  127,  137,  128,  266,  145,  138,  155,  129,
			  139,  162,  156,  140,  260,  168,  141,  176,  163,  164,
			  149,  169,  150,  186,  165,  157,  190,  177,  206,  178,
			  207,  207,  151,  179,  268,  373,  191,  266,  187,  207,
			  155,  211,  207,  162,  156,  261,  372,  168,  262,  176,
			  163,  164,  371,  169,  270,  186,  165,  157,  190,  177,
			  207,  178,  207,  214,  208,  179,  268,  208,  191,  215,
			  187,  209,  205,  370,  209,   93,  216,  263,   94,  205,

			  264,  272,  222,  208,  222,  222,  270,   93,  259,  210,
			   94,  365,  120,  364,  212,  274,  223,  276,  223,  223,
			   93,   93,  363,  366,   94,  248,  248,  248,  252,  252,
			  252,  265,  225,  272,  209,  208,  120,   90,  249,  263,
			  260,  253,  264,   95,  125,  213,  278,  274,  108,  276,
			  254,  254,  255,   89,  108,   95,  255,  255,  255,  280,
			  111,  120,   93,  266,  250,   94,  209,   88,  125,   95,
			  249,  263,  269,  253,  264,   96,  218,   87,  278,  219,
			   98,   98,   98,  257,  257,  257,  210,   96,  220,  113,
			  202,  280,  111,  125,   98,  113,   98,  120,   98,   98,

			  221,   96,  120,   98,  270,   98,  119,  267,  114,   98,
			  367,   98,   91,   94,   98,   98,   98,   98,   98,   98,
			  226,   90,  258,  227,  228,  229,  230,   93,  367,  125,
			  369,  366,  231,  271,  125,   89,  120,  120,  232,  268,
			  233,  275,  234,  235,  236,  237,  273,  238,  277,  239,
			   88,   87,  120,  240,  120,  241,  286,  120,  242,  243,
			  244,  245,  246,  247,  289,  272,  279,  281,  125,  125,
			  296,  282,  283,  276,  120,  120,  284,  287,  274,  290,
			  278,  298,  120,  120,  125,  285,  125,  293,  286,  125,
			  291,  294,  288,  297,  292,  300,  289,  120,  280,  283,

			  295,  120,  296,  284,  283,  120,  125,  125,  284,  289,
			  120,  290,  120,  298,  125,  125,  299,  286,  302,  293,
			  773,  120,  293,  294,  290,  298,  294,  300,  301,  125,
			  312,  303,  296,  125,  120,  304,  120,  125,  120,  307,
			  311,  318,  125,  308,  125,  317,  305,  315,  300,  306,
			  302,  120,  313,  125,  309,  120,  320,  310,  120,  316,
			  302,  319,  312,  307,  314,  322,  125,  308,  125,  321,
			  125,  307,  312,  318,  120,  308,  323,  318,  309,  315,
			  324,  310,  120,  125,  315,  326,  309,  125,  320,  310,
			  125,  316,  344,  320,  325,  773,  316,  322,  120,  773,

			  773,  322,  120,  333,  773,  334,  125,  346,  324,  773,
			  120,  343,  324,  335,  125,  773,  336,  326,  337,  338,
			  120,  341,  347,  339,  344,  342,  326,  340,  345,  348,
			  125,  327,  120,  328,  125,  333,  120,  334,  357,  346,
			  773,  329,  125,  344,  330,  335,  331,  332,  336,  120,
			  337,  338,  125,  341,  348,  341,  356,  342,  355,  342,
			  346,  348,  358,  333,  125,  334,  349,  352,  125,  360,
			  358,  350,  353,  335,  362,  773,  336,  120,  337,  338,
			  359,  125,  351,  354,  120,  773,  361,  773,  356,  773,
			  356,  203,  203,  203,  358,  375,  375,  375,  352,  352,

			  773,  360,  773,  353,  353,  206,  362,  207,  207,  125,
			  773,  773,  360,  407,  354,  354,  125,  207,  362,  207,
			  207,  207,  773,  211,  207,  207,  208,  207,  214,  208,
			  203,  215,  209,   93,  205,  209,  366,  216,  773,  120,
			  205,  395,  395,  395,  773,  407,  368,  368,  368,  222,
			  773,  222,  222,  223,   93,  223,  223,   94,   93,  773,
			  208,   94,  404,  404,  404,  392,  392,  392,  393,  773,
			  393,  125,  208,  394,  394,  394,  212,  408,  249,  773,
			  208,  396,  396,  396,  108,  120,  402,  402,  402,  409,
			  399,  209,  399,  773,  397,  400,  400,  400,  405,  405,

			  405,  258,   95,  209,  250,  773,   95,  213,  120,  409,
			  249,  209,  108,  406,  401,  401,  402,  125,  120,  410,
			  398,  409,  411,  120,  111,  113,  397,  412,  413,  120,
			  415,  120,  417,  120,   96,  418,  419,  258,   96,  414,
			  125,  421,  423,  120,  416,  407,  120,  425,  120,  773,
			  125,  411,  427,  113,  411,  125,  111,  420,  422,  413,
			  413,  125,  415,  125,  417,  125,  424,  419,  419,  120,
			  120,  415,  429,  421,  423,  125,  417,  426,  125,  425,
			  125,  120,  120,  430,  427,  432,  435,  437,  434,  421,
			  423,  120,  120,  120,  428,  120,  439,  431,  425,  433,

			  445,  125,  125,  436,  429,  773,  438,  120,  442,  427,
			  444,  773,  446,  125,  125,  432,  120,  432,  435,  437,
			  435,  443,  447,  125,  125,  125,  429,  125,  439,  433,
			  120,  433,  445,  448,  440,  437,  120,  120,  439,  125,
			  442,  452,  445,  450,  447,  449,  451,  441,  125,  120,
			  453,  454,  455,  443,  447,  120,  456,  457,  459,  120,
			  120,  461,  125,  120,  120,  449,  442,  458,  125,  125,
			  120,  463,  465,  453,  464,  451,  460,  449,  451,  443,
			  120,  125,  453,  455,  455,  467,  469,  125,  457,  457,
			  459,  125,  125,  461,  462,  125,  125,  466,  120,  459,

			  471,  120,  125,  463,  465,  468,  465,  470,  461,  120,
			  120,  120,  125,  474,  473,  120,  476,  467,  469,  120,
			  478,  479,  472,  480,  481,  483,  463,  120,  482,  467,
			  125,  475,  471,  125,  477,  484,  120,  469,  485,  471,
			  487,  125,  125,  125,  120,  476,  473,  125,  476,  486,
			  489,  125,  479,  479,  473,  481,  481,  483,  488,  125,
			  483,  490,  120,  477,  494,  120,  477,  485,  125,  120,
			  485,  491,  487,  493,  495,  496,  125,  492,  497,  498,
			  499,  487,  489,  120,  120,  501,  120,  773,  500,   93,
			  489,  517,  366,  491,  125,  773,  495,  125,  519,  367,

			  773,  125,  366,  491,  773,  493,  495,  497,  773,  493,
			  497,  499,  499,  773,  773,  125,  125,  501,  125,   93,
			  501,  521,  366,  517,   98,  503,  375,  375,  375,  773,
			  519,   98,  502,  502,  502,  504,  504,  504,  394,  394,
			  394,  773,  505,  505,  505,  507,  507,  507,  249,  508,
			  508,  508,  509,  521,  509,  773,  773,  510,  510,  510,
			  523,  120,  397,  511,  511,  511,  400,  400,  400,  512,
			  512,  512,  516,  514,  250,  401,  401,  402,  525,  773,
			  249,  506,  515,  515,  515,  111,  527,  514,  398,  402,
			  402,  402,  523,  125,  397,  405,  405,  405,  520,  120,

			  120,  120,  773,  522,  517,  120,  529,  526,  513,  518,
			  525,  120,  120,  531,  258,  524,  530,  111,  527,  533,
			  120,  258,  532,  528,  120,  535,  536,  120,  258,  537,
			  521,  125,  125,  125,  258,  523,  534,  125,  529,  527,
			  120,  519,  539,  125,  125,  531,  541,  525,  531,  538,
			  543,  533,  125,  120,  533,  529,  125,  535,  537,  125,
			  120,  537,  542,  545,  120,  540,  546,  547,  535,  549,
			  120,  120,  125,  544,  539,  120,  550,  551,  541,  552,
			  120,  539,  543,  548,  553,  125,  555,  557,  559,  120,
			  773,  120,  125,  561,  543,  545,  125,  541,  547,  547,

			  556,  549,  125,  125,  554,  545,  558,  125,  551,  551,
			  120,  553,  125,  120,  120,  549,  553,  563,  555,  557,
			  559,  125,  560,  125,  120,  561,  120,  562,  120,  565,
			  120,  564,  557,  567,  568,  120,  555,  120,  559,  569,
			  571,  120,  125,  573,  120,  125,  125,  566,  572,  563,
			  570,  574,  575,  577,  561,  579,  125,  581,  125,  563,
			  125,  565,  125,  565,  582,  567,  569,  125,  583,  125,
			  120,  569,  571,  125,  120,  573,  125,  120,  120,  567,
			  573,  578,  571,  575,  575,  577,  576,  579,  120,  581,
			  585,  120,  587,  580,  120,  120,  583,  584,  586,  589,

			  583,  588,  125,  120,  120,  591,  125,  593,  120,  125,
			  125,  592,  595,  579,  120,  590,  120,  120,  577,  773,
			  125,  773,  585,  125,  587,  581,  125,  125,  773,  585,
			  587,  589,  773,  589,  594,  125,  125,  591,   93,  593,
			  125,  366,  120,  593,  595,  773,  125,  591,  125,  125,
			   98,  596,  596,  596,  504,  504,  504,  599,  599,  599,
			  600,  600,  600,  601,  601,  601,  595,  598,  602,  602,
			  602,  510,  510,  510,  125,  603,  603,  603,  605,  605,
			  605,  397,  606,  606,  606,  607,  607,  607,  602,  602,
			  602,  609,  120,  405,  405,  405,  506,  120,  611,  598,

			  773,  608,  610,  120,  120,  613,  120,  398,  614,  619,
			  120,  621,  615,  397,  604,  612,  616,  120,  120,  623,
			  617,  513,  618,  622,  125,  773,  120,  620,  625,  125,
			  611,  627,  113,  608,  611,  125,  125,  613,  125,  629,
			  616,  619,  125,  621,  617,  631,  120,  613,  616,  125,
			  125,  623,  617,  624,  619,  623,  626,  120,  125,  621,
			  625,  120,  120,  627,  120,  120,  633,  120,  635,  630,
			  637,  629,  634,  628,  632,  636,  638,  631,  125,  120,
			  639,  640,  641,  643,  642,  625,  644,  645,  627,  125,
			  120,  120,  647,  125,  125,  649,  125,  125,  633,  125,

			  635,  631,  637,  650,  635,  629,  633,  637,  639,  651,
			  653,  125,  639,  641,  641,  643,  643,  646,  645,  645,
			  120,  120,  125,  125,  647,  655,  652,  649,  654,  648,
			  120,  120,  120,  657,  658,  651,  659,  120,  120,  661,
			  656,  651,  653,  120,  120,  663,  664,  665,  660,  647,
			  120,  666,  125,  125,  120,  662,  667,  655,  653,  669,
			  655,  649,  125,  125,  125,  657,  659,  120,  659,  125,
			  125,  661,  657,  671,  773,  125,  125,  663,  665,  665,
			  661,  668,  125,  667,  120,  120,  125,  663,  667,  670,
			   93,  669,  675,  366,  673,  673,  673,  773,  773,  125,

			  120,  672,   98,  672,  773,  671,  673,  673,  673,  674,
			  674,  674,  773,  669,  773,  773,  125,  125,  250,  687,
			  120,  671,  773,  773,  675,  602,  602,  602,  677,  677,
			  677,  686,  125,  506,  678,  678,  678,  773,  676,  679,
			  679,  679,  680,  680,  680,  681,  681,  681,  682,  773,
			  682,  687,  125,  680,  680,  680,  684,  684,  684,  120,
			  120,  689,  120,  687,  691,  693,  688,  604,  692,  685,
			  676,  120,  120,  690,  120,  694,  695,  120,  696,  120,
			  697,  513,  699,  698,  120,  120,  120,  120,  701,  773,
			  703,  125,  125,  689,  125,  700,  691,  693,  689,  705,

			  693,  685,  120,  125,  125,  691,  125,  695,  695,  125,
			  697,  125,  697,  704,  699,  699,  125,  125,  125,  125,
			  701,  120,  703,  707,  120,  708,  702,  701,  709,  120,
			  711,  705,  120,  120,  125,  706,  713,  715,  120,  120,
			  710,  717,  712,  714,  716,  705,  120,  718,  719,  120,
			  120,  120,  120,  125,  721,  707,  125,  709,  703,  723,
			  709,  125,  711,  120,  125,  125,  120,  707,  713,  715,
			  125,  125,  711,  717,  713,  715,  717,  720,  125,  719,
			  719,  125,  125,  125,  125,  120,  721,  725,  120,  773,
			  722,  723,  673,  673,  673,  125,  773,  120,  125,  724,

			  673,  673,  673,  726,  726,  726,  727,  773,  727,  721,
			  732,  728,  728,  728,  730,  730,  730,  125,  773,  725,
			  125,  729,  723,  729,  738,  773,  730,  730,  730,  125,
			  773,  725,  731,  731,  731,  120,  398,  680,  680,  680,
			  737,  120,  732,  733,  733,  733,  680,  680,  680,  734,
			  734,  734,  735,  604,  735,  739,  738,  736,  736,  736,
			  120,  740,  732,  741,  742,  744,  120,  125,  120,  743,
			  120,  120,  738,  125,  745,  746,  120,  120,  120,  120,
			  748,  749,  750,  120,  747,  120,  752,  740,  398,  751,
			  754,  773,  125,  740,  732,  742,  742,  744,  125,  755,

			  125,  744,  125,  125,  756,  120,  746,  746,  125,  125,
			  125,  125,  748,  750,  750,  125,  748,  125,  752,  753,
			  120,  752,  754,  120,  757,  758,  759,  760,  120,  120,
			  120,  756,  728,  728,  728,  120,  756,  125,  761,  761,
			  761,  730,  730,  730,  730,  730,  730,  762,  762,  762,
			  120,  754,  125,  120,  120,  125,  758,  758,  760,  760,
			  125,  125,  125,  763,  120,  763,  767,  125,  764,  764,
			  764,  679,  679,  679,  736,  736,  736,  506,  765,  765,
			  765,  120,  125,  120,  732,  125,  125,  769,  120,  120,
			  770,  771,  766,  120,  120,  120,  125,  768,  767,  726,

			  726,  726,  764,  764,  764,  772,  772,  772,  120,  120,
			  398,  120,  773,  125,  773,  125,  732,  513,  773,  769,
			  125,  125,  771,  771,  767,  125,  125,  125,  773,  769,
			  733,  733,  733,  762,  762,  762,  773,  773,  506,  773,
			  125,  125,  773,  125,  604,  125,  125,  125,  125,  125,
			  125,  125,  125,  125,  125,  125,  256,  256,  256,  773,
			  773,  773,  773,  773,  773,  773,  773,  773,  773,  513,
			  773,  773,  604,   80,   80,   80,   80,   80,   80,   80,
			   80,   80,   80,   80,   80,   80,   80,   80,   80,   80,
			   80,   80,   80,   92,   92,  773,   92,   92,   92,   92,

			   92,   92,   92,   92,   92,   92,   92,   92,   92,   92,
			   92,   92,   92,   97,  773,  773,  773,  773,  773,  773,
			   97,   97,   97,   97,   97,   97,   97,   97,   97,   97,
			   97,   97,   97,   98,   98,  773,   98,   98,   98,   98,
			   98,   98,   98,   98,   98,   98,   98,   98,   98,   98,
			   98,   98,   98,   99,   99,  773,   99,   99,   99,   99,
			   99,   99,   99,   99,   99,   99,   99,   99,   99,   99,
			   99,   99,   99,  204,  204,  773,  204,  204,  204,  773,
			  773,  204,  204,  204,  204,  204,  204,  204,  204,  204,
			  204,  204,  204,  205,  773,  773,  205,  773,  205,  205,

			  205,  205,  205,  205,  205,  205,  205,  205,  205,  205,
			  205,  205,  205,  212,  212,  773,  212,  212,  212,  212,
			  212,  212,  212,  212,  212,  212,  212,  212,  212,  212,
			  212,  212,  212,  213,  213,  773,  213,  213,  213,  213,
			  213,  213,  213,  213,  213,  213,  213,  213,  213,  213,
			  213,  213,  213,  217,  217,  773,  217,  217,  217,  217,
			  217,  217,  217,  217,  217,  217,  217,  217,  217,  217,
			  217,  217,  217,  224,  224,  773,  224,  224,  224,  224,
			  224,  224,  224,  224,  224,  224,  224,  224,  224,  224,
			  224,  224,  224,  251,  251,  251,  251,  251,  251,  251,

			  251,  773,  251,  251,  251,  251,  251,  251,  251,  251,
			  251,  251,  251,  208,  208,  773,  208,  208,  208,  773,
			  208,  208,  208,  208,  208,  208,  208,  208,  208,  208,
			  208,  208,  208,  209,  209,  773,  209,  209,  209,  773,
			  209,  209,  209,  209,  209,  209,  209,  209,  209,  209,
			  209,  209,  209,  683,  683,  683,  683,  683,  683,  683,
			  683,  773,  683,  683,  683,  683,  683,  683,  683,  683,
			  683,  683,  683,    5,  773,  773,  773,  773,  773,  773,
			  773,  773,  773,  773,  773,  773,  773,  773,  773,  773,
			  773,  773,  773,  773,  773,  773,  773,  773,  773,  773,

			  773,  773,  773,  773,  773,  773,  773,  773,  773,  773,
			  773,  773,  773,  773,  773,  773,  773,  773,  773,  773,
			  773,  773,  773,  773,  773,  773,  773,  773,  773,  773,
			  773,  773,  773,  773,  773,  773,  773,  773,  773,  773,
			  773,  773,  773,  773,  773,  773,  773,  773,  773,  773,
			  773,  773,  773,  773,  773,  773,  773,  773,  773,  773,
			  773,  773, yy_Dummy>>)
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
			   30,   30,   24,   32,   32,   25,  762,   25,   25,   25,
			   26,   37,   26,   26,   26,   37,   27,   25,   27,   27,
			   27,   37,   26,   40,   42,  733,   60,   46,   39,   68,
			   42,   46,   39,  726,    3,   12,   39,  503,    4,   25,
			   57,   57,   57,   37,   70,   39,   25,   37,  403,   25,
			  256,   26,  247,   37,   26,   40,   42,   27,   60,   46,
			   39,   68,   42,   46,   39,    3,  246,   12,   39,    4,
			  245,   25,   34,   34,   34,   49,   70,   39,   71,   57,
			   49,   34,   34,   34,   34,   34,   34,   34,   34,   34,

			   34,   34,   34,   34,   34,   34,   34,   34,   34,   34,
			   34,   34,   34,   34,   34,   34,   34,   49,  244,  243,
			   71,   34,   49,   34,   34,   34,   34,   34,   34,   34,
			   34,   34,   34,   34,   34,   34,   34,   34,   34,   34,
			   34,   34,   34,   34,   34,   34,   34,   34,   34,   35,
			   35,   35,   51,   51,   74,   76,  242,   77,   35,   35,
			   35,   35,   35,   35,   35,   35,   35,   35,   35,   35,
			   35,   35,   35,   35,   35,   35,   35,   35,   35,   35,
			   35,   35,   35,   35,   51,   51,   74,   76,   35,   77,
			   35,   35,   35,   35,   35,   35,   35,   35,   35,   35,

			   35,   35,   35,   35,   35,   35,   35,   35,   35,   35,
			   35,   35,   35,   35,   35,   35,   36,   36,  241,   38,
			   36,   43,   38,   36,   38,   41,   36,   43,   41,   36,
			   44,  120,   41,   41,   38,   45,   75,   44,   41,  240,
			   44,  239,   44,  238,   45,  237,   44,  236,   36,   36,
			   75,   38,   36,   43,   38,   36,   38,   41,   36,   43,
			   41,   36,   44,  120,   41,   41,   38,   45,   75,   44,
			   41,   47,   44,   50,   44,   47,   45,   52,   44,   48,
			   48,   50,   75,   52,   62,   59,   47,   50,  235,   48,
			   59,   61,   59,   98,   62,   61,   98,   59,   61,  234,

			  233,   61,  126,   47,   61,   50,  232,   47,   63,   52,
			   63,   48,   48,   50,  230,   52,   62,   59,   47,   50,
			   63,   48,   59,   61,   59,  128,   62,   61,   64,   59,
			   61,   66,   64,   61,  126,   67,   61,   69,   66,   66,
			   63,   67,   63,   72,   66,   64,   73,   69,   81,   69,
			   81,   81,   63,   69,  129,  229,   73,  128,   72,   83,
			   64,   83,   83,   66,   64,  122,  228,   67,  122,   69,
			   66,   66,  227,   67,  131,   72,   66,   64,   73,   69,
			   84,   69,   84,   84,   85,   69,  129,   85,   73,   85,
			   72,   86,   85,  226,   86,   92,   86,  122,   92,   86,

			  122,  137,   95,   81,   95,   95,  131,   95,  121,  210,
			   95,  209,  121,  208,   83,  138,   96,  139,   96,   96,
			  217,   96,  204,  217,   96,  105,  105,  105,  108,  108,
			  108,  123,   99,  137,   81,   84,  123,   90,  105,  127,
			  121,  108,  127,   92,  121,   83,  140,  138,  109,  139,
			  109,  109,  109,   89,  110,   95,  110,  110,  110,  141,
			  109,  130,  218,  123,  105,  218,   84,   88,  123,   96,
			  105,  127,  130,  108,  127,   92,   94,   87,  140,   94,
			   94,   94,   94,  113,  113,  113,   82,   95,   94,  109,
			   54,  141,  109,  130,   94,  110,   94,  124,   94,   94,

			   94,   96,  143,   94,  130,   94,   33,  124,   28,   94,
			  219,   94,   11,  219,   94,   94,   94,   94,   94,   94,
			  100,   10,  113,  100,  100,  100,  100,  221,  366,  124,
			  221,  366,  100,  132,  143,    9,  134,  132,  100,  124,
			  100,  134,  100,  100,  100,  100,  133,  100,  135,  100,
			    8,    7,  135,  100,  133,  100,  149,  136,  100,  100,
			  100,  100,  100,  100,  150,  132,  136,  142,  134,  132,
			  155,  142,  144,  134,  142,  146,  144,  147,  133,  150,
			  135,  156,  147,  148,  135,  146,  133,  151,  149,  136,
			  148,  151,  147,  153,  148,  157,  150,  152,  136,  142,

			  152,  153,  155,  142,  144,  158,  142,  146,  144,  147,
			  154,  150,  161,  156,  147,  148,  154,  146,  163,  151,
			    5,  159,  148,  151,  147,  153,  148,  157,  159,  152,
			  168,  160,  152,  153,  170,  160,  160,  158,  166,  164,
			  166,  171,  154,  164,  161,  170,  160,  169,  154,  160,
			  163,  172,  167,  159,  164,  175,  176,  164,  167,  169,
			  159,  172,  168,  160,  167,  177,  170,  160,  160,  173,
			  166,  164,  166,  171,  173,  164,  174,  170,  160,  169,
			  178,  160,  174,  172,  167,  181,  164,  175,  176,  164,
			  167,  169,  187,  172,  180,    0,  167,  177,  180,    0,

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
			    0,    0,  198,  260,  192,  193,  198,  207,  200,  207,
			  207,  211,    0,  211,  211,  214,  212,  214,  214,  212,
			  203,  212,  213,  220,  212,  213,  220,  213,    0,  262,
			  213,  250,  250,  250,    0,  260,  220,  220,  220,  222,
			    0,  222,  222,  223,  222,  223,  223,  222,  223,    0,
			  206,  223,  257,  257,  257,  248,  248,  248,  249,    0,
			  249,  262,  207,  249,  249,  249,  211,  261,  248,    0,
			  214,  252,  252,  252,  255,  261,  255,  255,  255,  263,
			  253,  206,  253,    0,  252,  253,  253,  253,  258,  258,

			  258,  257,  222,  207,  248,    0,  223,  211,  259,  261,
			  248,  214,  254,  259,  254,  254,  254,  261,  265,  267,
			  252,  263,  268,  269,  254,  255,  252,  271,  272,  273,
			  274,  275,  276,  271,  222,  277,  278,  258,  223,  273,
			  259,  280,  283,  277,  275,  259,  281,  284,  279,    0,
			  265,  267,  286,  254,  268,  269,  254,  279,  281,  271,
			  272,  273,  274,  275,  276,  271,  282,  277,  278,  287,
			  282,  273,  290,  280,  283,  277,  275,  285,  281,  284,
			  279,  285,  288,  291,  286,  293,  294,  296,  292,  279,
			  281,  291,  292,  295,  288,  297,  298,  291,  282,  293,

			  302,  287,  282,  295,  290,    0,  297,  301,  300,  285,
			  301,    0,  303,  285,  288,  291,  303,  293,  294,  296,
			  292,  300,  307,  291,  292,  295,  288,  297,  298,  291,
			  299,  293,  302,  304,  299,  295,  305,  304,  297,  301,
			  300,  306,  301,  305,  303,  308,  309,  299,  303,  306,
			  310,  311,  312,  300,  307,  311,  313,  315,  316,  317,
			  314,  320,  299,  321,  313,  304,  299,  314,  305,  304,
			  319,  324,  326,  306,  325,  305,  319,  308,  309,  299,
			  325,  306,  310,  311,  312,  333,  334,  311,  313,  315,
			  316,  317,  314,  320,  323,  321,  313,  327,  323,  314,

			  335,  327,  319,  324,  326,  328,  325,  329,  319,  328,
			  330,  332,  325,  331,  336,  329,  337,  333,  334,  331,
			  332,  338,  330,  339,  341,  342,  323,  339,  340,  327,
			  323,  331,  335,  327,  337,  343,  340,  328,  344,  329,
			  346,  328,  330,  332,  345,  331,  336,  329,  337,  345,
			  348,  331,  332,  338,  330,  339,  341,  342,  347,  339,
			  340,  349,  347,  331,  351,  349,  337,  343,  340,  350,
			  344,  352,  346,  353,  354,  355,  345,  350,  356,  357,
			  358,  345,  348,  359,  357,  360,  361,    0,  359,  367,
			  347,  407,  367,  349,  347,    0,  351,  349,  409,  369,

			    0,  350,  369,  352,    0,  353,  354,  355,    0,  350,
			  356,  357,  358,    0,    0,  359,  357,  360,  361,  368,
			  359,  411,  368,  407,  369,  375,  375,  375,  375,    0,
			  409,  368,  368,  368,  368,  392,  392,  392,  393,  393,
			  393,    0,  394,  394,  394,  395,  395,  395,  392,  396,
			  396,  396,  397,  411,  397,    0,    0,  397,  397,  397,
			  413,  406,  396,  398,  398,  398,  399,  399,  399,  400,
			  400,  400,  406,  401,  392,  401,  401,  401,  415,    0,
			  392,  394,  404,  404,  404,  401,  417,  402,  396,  402,
			  402,  402,  413,  406,  396,  405,  405,  405,  410,  408,

			  410,  412,    0,  412,  406,  414,  419,  416,  400,  408,
			  415,  416,  418,  421,  401,  414,  420,  401,  417,  423,
			  420,  404,  422,  418,  422,  425,  426,  424,  402,  427,
			  410,  408,  410,  412,  405,  412,  424,  414,  419,  416,
			  428,  408,  429,  416,  418,  421,  432,  414,  420,  428,
			  433,  423,  420,  431,  422,  418,  422,  425,  426,  424,
			  430,  427,  431,  435,  434,  430,  436,  437,  424,  439,
			  436,  438,  428,  434,  429,  440,  441,  443,  432,  444,
			  441,  428,  433,  438,  445,  431,  447,  449,  451,  446,
			    0,  448,  430,  453,  431,  435,  434,  430,  436,  437,

			  448,  439,  436,  438,  446,  434,  450,  440,  441,  443,
			  450,  444,  441,  452,  454,  438,  445,  457,  447,  449,
			  451,  446,  452,  448,  456,  453,  458,  456,  460,  461,
			  462,  460,  448,  465,  466,  464,  446,  466,  450,  467,
			  469,  468,  450,  471,  470,  452,  454,  464,  470,  457,
			  468,  472,  473,  476,  452,  477,  456,  479,  458,  456,
			  460,  461,  462,  460,  480,  465,  466,  464,  481,  466,
			  480,  467,  469,  468,  474,  471,  470,  478,  475,  464,
			  470,  475,  468,  472,  473,  476,  474,  477,  482,  479,
			  483,  484,  485,  478,  486,  488,  480,  482,  484,  491,

			  481,  490,  480,  492,  490,  493,  474,  495,  494,  478,
			  475,  494,  497,  475,  498,  492,  500,  516,  474,    0,
			  482,    0,  483,  484,  485,  478,  486,  488,    0,  482,
			  484,  491,    0,  490,  496,  492,  490,  493,  502,  495,
			  494,  502,  496,  494,  497,    0,  498,  492,  500,  516,
			  502,  502,  502,  502,  504,  504,  504,  505,  505,  505,
			  506,  506,  506,  507,  507,  507,  496,  504,  508,  508,
			  508,  509,  509,  509,  496,  510,  510,  510,  511,  511,
			  511,  508,  512,  512,  512,  513,  513,  513,  514,  514,
			  514,  515,  518,  515,  515,  515,  505,  520,  521,  504,

			    0,  514,  520,  522,  524,  527,  526,  508,  528,  531,
			  532,  535,  528,  508,  510,  526,  529,  530,  534,  537,
			  529,  512,  530,  536,  518,    0,  536,  534,  539,  520,
			  521,  541,  515,  514,  520,  522,  524,  527,  526,  543,
			  528,  531,  532,  535,  528,  545,  546,  526,  529,  530,
			  534,  537,  529,  538,  530,  536,  540,  538,  536,  534,
			  539,  540,  542,  541,  544,  548,  549,  550,  551,  544,
			  553,  543,  550,  542,  548,  552,  554,  545,  546,  552,
			  555,  556,  557,  559,  558,  538,  560,  561,  540,  538,
			  558,  562,  565,  540,  542,  567,  544,  548,  549,  550,

			  551,  544,  553,  568,  550,  542,  548,  552,  554,  569,
			  571,  552,  555,  556,  557,  559,  558,  564,  560,  561,
			  566,  564,  558,  562,  565,  573,  570,  567,  572,  566,
			  570,  574,  572,  575,  576,  568,  577,  578,  576,  579,
			  574,  569,  571,  580,  582,  583,  584,  585,  578,  564,
			  586,  588,  566,  564,  584,  582,  589,  573,  570,  591,
			  572,  566,  570,  574,  572,  575,  576,  592,  577,  578,
			  576,  579,  574,  595,    0,  580,  582,  583,  584,  585,
			  578,  590,  586,  588,  594,  590,  584,  582,  589,  594,
			  596,  591,  601,  596,  599,  599,  599,    0,    0,  592,

			  610,  598,  596,  598,    0,  595,  598,  598,  598,  600,
			  600,  600,    0,  590,    0,    0,  594,  590,  601,  613,
			  612,  594,    0,    0,  601,  602,  602,  602,  603,  603,
			  603,  612,  610,  599,  604,  604,  604,    0,  602,  605,
			  605,  605,  606,  606,  606,  607,  607,  607,  608,    0,
			  608,  613,  612,  608,  608,  608,  609,  609,  609,  614,
			  615,  617,  618,  612,  619,  621,  615,  603,  620,  609,
			  602,  622,  620,  618,  624,  626,  627,  628,  630,  626,
			  631,  606,  633,  632,  634,  636,  630,  632,  637,    0,
			  639,  614,  615,  617,  618,  636,  619,  621,  615,  641,

			  620,  609,  640,  622,  620,  618,  624,  626,  627,  628,
			  630,  626,  631,  640,  633,  632,  634,  636,  630,  632,
			  637,  638,  639,  643,  642,  644,  638,  636,  645,  646,
			  647,  641,  648,  644,  640,  642,  649,  651,  650,  652,
			  646,  653,  648,  650,  652,  640,  654,  656,  657,  658,
			  660,  656,  662,  638,  665,  643,  642,  644,  638,  667,
			  645,  646,  647,  668,  648,  644,  664,  642,  649,  651,
			  650,  652,  646,  653,  648,  650,  652,  664,  654,  656,
			  657,  658,  660,  656,  662,  666,  665,  671,  670,    0,
			  666,  667,  672,  672,  672,  668,    0,  686,  664,  670,

			  673,  673,  673,  674,  674,  674,  675,    0,  675,  664,
			  679,  675,  675,  675,  677,  677,  677,  666,    0,  671,
			  670,  676,  666,  676,  689,    0,  676,  676,  676,  686,
			    0,  670,  678,  678,  678,  688,  679,  680,  680,  680,
			  688,  690,  679,  681,  681,  681,  682,  682,  682,  684,
			  684,  684,  685,  677,  685,  692,  689,  685,  685,  685,
			  692,  693,  684,  694,  695,  697,  696,  688,  694,  696,
			  698,  700,  688,  690,  702,  703,  702,  704,  706,  708,
			  709,  710,  711,  712,  708,  710,  713,  692,  684,  712,
			  715,    0,  692,  693,  684,  694,  695,  697,  696,  716,

			  694,  696,  698,  700,  717,  716,  702,  703,  702,  704,
			  706,  708,  709,  710,  711,  712,  708,  710,  713,  714,
			  718,  712,  715,  714,  720,  721,  722,  723,  720,  724,
			  722,  716,  727,  727,  727,  737,  717,  716,  728,  728,
			  728,  729,  729,  729,  730,  730,  730,  731,  731,  731,
			  739,  714,  718,  741,  743,  714,  720,  721,  722,  723,
			  720,  724,  722,  732,  745,  732,  748,  737,  732,  732,
			  732,  734,  734,  734,  735,  735,  735,  728,  736,  736,
			  736,  747,  739,  749,  734,  741,  743,  752,  751,  753,
			  755,  756,  747,  757,  755,  759,  745,  751,  748,  761,

			  761,  761,  763,  763,  763,  764,  764,  764,  766,  768,
			  734,  770,    0,  747,    0,  749,  734,  736,    0,  752,
			  751,  753,  755,  756,  747,  757,  755,  759,    0,  751,
			  765,  765,  765,  772,  772,  772,    0,    0,  761,    0,
			  766,  768,    0,  770,  764,  780,  780,  780,  780,  780,
			  780,  780,  780,  780,  780,  780,  787,  787,  787,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,  765,
			    0,    0,  772,  774,  774,  774,  774,  774,  774,  774,
			  774,  774,  774,  774,  774,  774,  774,  774,  774,  774,
			  774,  774,  774,  775,  775,    0,  775,  775,  775,  775,

			  775,  775,  775,  775,  775,  775,  775,  775,  775,  775,
			  775,  775,  775,  776,    0,    0,    0,    0,    0,    0,
			  776,  776,  776,  776,  776,  776,  776,  776,  776,  776,
			  776,  776,  776,  777,  777,    0,  777,  777,  777,  777,
			  777,  777,  777,  777,  777,  777,  777,  777,  777,  777,
			  777,  777,  777,  778,  778,    0,  778,  778,  778,  778,
			  778,  778,  778,  778,  778,  778,  778,  778,  778,  778,
			  778,  778,  778,  779,  779,    0,  779,  779,  779,    0,
			    0,  779,  779,  779,  779,  779,  779,  779,  779,  779,
			  779,  779,  779,  781,    0,    0,  781,    0,  781,  781,

			  781,  781,  781,  781,  781,  781,  781,  781,  781,  781,
			  781,  781,  781,  782,  782,    0,  782,  782,  782,  782,
			  782,  782,  782,  782,  782,  782,  782,  782,  782,  782,
			  782,  782,  782,  783,  783,    0,  783,  783,  783,  783,
			  783,  783,  783,  783,  783,  783,  783,  783,  783,  783,
			  783,  783,  783,  784,  784,    0,  784,  784,  784,  784,
			  784,  784,  784,  784,  784,  784,  784,  784,  784,  784,
			  784,  784,  784,  785,  785,    0,  785,  785,  785,  785,
			  785,  785,  785,  785,  785,  785,  785,  785,  785,  785,
			  785,  785,  785,  786,  786,  786,  786,  786,  786,  786,

			  786,    0,  786,  786,  786,  786,  786,  786,  786,  786,
			  786,  786,  786,  788,  788,    0,  788,  788,  788,    0,
			  788,  788,  788,  788,  788,  788,  788,  788,  788,  788,
			  788,  788,  788,  789,  789,    0,  789,  789,  789,    0,
			  789,  789,  789,  789,  789,  789,  789,  789,  789,  789,
			  789,  789,  789,  790,  790,  790,  790,  790,  790,  790,
			  790,    0,  790,  790,  790,  790,  790,  790,  790,  790,
			  790,  790,  790,  773,  773,  773,  773,  773,  773,  773,
			  773,  773,  773,  773,  773,  773,  773,  773,  773,  773,
			  773,  773,  773,  773,  773,  773,  773,  773,  773,  773,

			  773,  773,  773,  773,  773,  773,  773,  773,  773,  773,
			  773,  773,  773,  773,  773,  773,  773,  773,  773,  773,
			  773,  773,  773,  773,  773,  773,  773,  773,  773,  773,
			  773,  773,  773,  773,  773,  773,  773,  773,  773,  773,
			  773,  773,  773,  773,  773,  773,  773,  773,  773,  773,
			  773,  773,  773,  773,  773,  773,  773,  773,  773,  773,
			  773,  773, yy_Dummy>>)
		end

	yy_base_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,   87,   91,  720, 2673,  649,  647,  631,
			  616,  606,   90,    0, 2673,   91,   92, 2673, 2673, 2673,
			 2673, 2673,   82,   86,   86,   97,  102,  108,  582, 2673,
			   85, 2673,   87,  580,  162,  229,  280,   88,  282,  109,
			   96,  291,   97,  284,  300,  298,  104,  338,  343,  148,
			  344,  216,  340, 2673,  534, 2673, 2673,  130,    0,  350,
			   99,  355,  351,  368,  399,    0,  397,  398,   96,  407,
			  108,  155,  410,  410,  212,  307,  219,  214, 2673, 2673,
			    0,  446,  583,  457,  478,  482,  489,  575,  564,  549,
			  532, 2673,  488, 2673,  569,  500,  514,    0,  386,  521,

			  613,    0, 2673, 2673, 2673,  505, 2673, 2673,  508,  530,
			  536, 2673,    0,  563, 2673, 2673, 2673, 2673, 2673, 2673,
			  294,  475,  428,  499,  560,    0,  369,  502,  393,  407,
			  524,  426,  600,  617,  599,  615,  620,  468,  486,  475,
			  513,  513,  637,  565,  642,    0,  638,  645,  646,  609,
			  632,  643,  660,  664,  673,  630,  652,  652,  668,  684,
			  699,  675,    0,  674,  707,    0,  701,  721,  691,  716,
			  697,  693,  714,  737,  745,  718,  709,  733,  749,    0,
			  761,  752,  799,  771,  783,  765,  781,  746,  795,  773,
			  774,  780,  834,  835,  812,  801,  810,  825,  847,  836,

			  840,  828, 2673,  871,  511,    0,  903,  915,  506,  504,
			  506,  919,  924,  930,  923,    0,    0,  513,  555,  603,
			  926,  620,  947,  951, 2673, 2673,  482,  461,  455,  444,
			  403,  875,  395,  389,  388,  377,  336,  334,  332,  330,
			  328,  307,  245,  208,  207,  169,  165,  151,  945,  953,
			  921, 2673,  961,  975,  994,  966,  101,  942,  978,  971,
			  871,  948,  902,  960,    0,  981,    0,  982,  985,  986,
			    0,  996,  997,  992,  983,  994,  982, 1006, 1007, 1011,
			  995, 1009, 1033,  993, 1014, 1044, 1019, 1032, 1045,    0,
			 1023, 1054, 1055, 1056, 1053, 1056, 1040, 1058, 1048, 1093,

			 1067, 1070, 1060, 1079, 1100, 1099, 1112, 1089, 1112, 1102,
			 1121, 1118, 1119, 1127, 1123, 1128, 1114, 1122,    0, 1133,
			 1118, 1126,    0, 1161, 1138, 1143, 1141, 1164, 1172, 1178,
			 1173, 1182, 1174, 1152, 1153, 1171, 1165, 1185, 1175, 1190,
			 1199, 1191, 1196, 1198, 1201, 1207, 1198, 1225, 1217, 1228,
			 1232, 1227, 1238, 1228, 1237, 1238, 1241, 1247, 1248, 1246,
			 1243, 1249,    0, 2673, 2673, 2673,  621, 1282, 1312, 1292,
			 2673, 2673, 2673, 2673, 2673, 1306, 2673, 2673, 2673, 2673,
			 2673, 2673, 2673, 2673, 2673, 2673, 2673, 2673, 2673, 2673,
			 2673, 2673, 1315, 1318, 1322, 1325, 1329, 1337, 1343, 1346,

			 1349, 1355, 1369,   99, 1362, 1375, 1324, 1243, 1362, 1251,
			 1363, 1286, 1364, 1321, 1368, 1331, 1374, 1353, 1375, 1358,
			 1383, 1380, 1387, 1384, 1390, 1379, 1389, 1392, 1403, 1396,
			 1423, 1416, 1404, 1404, 1427, 1417, 1433, 1434, 1434, 1420,
			 1438, 1443,    0, 1444, 1442, 1447, 1452, 1434, 1454, 1441,
			 1473, 1455, 1476, 1447, 1477,    0, 1487, 1477, 1489,    0,
			 1491, 1489, 1493,    0, 1498, 1484, 1500, 1505, 1504, 1494,
			 1507, 1502, 1514, 1515, 1537, 1541, 1504, 1515, 1540, 1504,
			 1533, 1537, 1551, 1544, 1554, 1548, 1557,    0, 1558,    0,
			 1567, 1565, 1566, 1556, 1571, 1567, 1605, 1583, 1577,    0,

			 1579,    0, 1631,  136, 1634, 1637, 1640, 1643, 1648, 1651,
			 1655, 1658, 1662, 1665, 1668, 1673, 1580,    0, 1655,    0,
			 1660, 1656, 1666,    0, 1667,    0, 1669, 1659, 1675, 1683,
			 1680, 1667, 1673,    0, 1681, 1665, 1689, 1685, 1720, 1695,
			 1724, 1699, 1725, 1691, 1727, 1703, 1709,    0, 1728, 1720,
			 1730, 1726, 1742, 1737, 1739, 1743, 1744, 1745, 1753, 1752,
			 1749, 1750, 1754,    0, 1784, 1759, 1783, 1749, 1766, 1772,
			 1793, 1777, 1795, 1792, 1794, 1787, 1801, 1803, 1800, 1791,
			 1806,    0, 1807, 1797, 1817, 1818, 1813,    0, 1814, 1819,
			 1848, 1826, 1830,    0, 1847, 1831, 1883, 2673, 1886, 1874,

			 1889, 1859, 1905, 1908, 1914, 1919, 1922, 1925, 1933, 1936,
			 1863,    0, 1883, 1871, 1922, 1923,    0, 1918, 1925, 1916,
			 1935, 1932, 1934,    0, 1937,    0, 1942, 1943, 1940,    0,
			 1949, 1951, 1950, 1949, 1947,    0, 1948, 1941, 1984, 1948,
			 1965, 1951, 1987, 1975, 1996, 1999, 1992, 1982, 1995, 1989,
			 2001, 1995, 2002, 1999, 2009,    0, 2014, 2015, 2012,    0,
			 2013,    0, 2015,    0, 2029, 2006, 2048, 2017, 2026,    0,
			 2051, 2039, 2072, 2080, 2083, 2091, 2106, 2094, 2112, 2077,
			 2117, 2123, 2126, 2673, 2129, 2137, 2060,    0, 2098, 2082,
			 2104,    0, 2123, 2129, 2131, 2132, 2129, 2125, 2133,    0,

			 2134,    0, 2139, 2140, 2140,    0, 2141,    0, 2142, 2138,
			 2148, 2149, 2146, 2143, 2186, 2157, 2168, 2173, 2183,    0,
			 2191, 2192, 2193, 2194, 2192,    0,   84, 2212, 2218, 2221,
			 2224, 2227, 2248,   76, 2251, 2254, 2258, 2198,    0, 2213,
			    0, 2216,    0, 2217,    0, 2227,    0, 2244, 2218, 2246,
			    0, 2251, 2241, 2252,    0, 2257, 2258, 2256,    0, 2258,
			    0, 2279,   57, 2282, 2285, 2310, 2271,    0, 2272,    0,
			 2274,    0, 2313, 2673, 2372, 2392, 2412, 2432, 2452, 2472,
			 2335, 2492, 2512, 2532, 2552, 2572, 2592, 2346, 2612, 2632,
			 2652, yy_Dummy>>)
		end

	yy_def_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,  773,    1,  774,  774,  773,  773,  773,  773,  773,
			  773,  773,  775,  776,  773,  777,  778,  773,  773,  773,
			  773,  773,  773,  773,  773,  773,  773,  773,  773,  773,
			  773,  773,  773,  773,  773,  773,   35,   35,   35,   35,
			   35,   35,   35,   35,   35,   35,   35,   35,   35,   35,
			   35,   35,   35,  773,  773,  773,  773,  773,  779,  780,
			  780,  780,  780,  780,  780,  780,  780,  780,  780,  780,
			  780,  780,  780,  780,  780,  780,  780,  780,  773,  773,
			  781,  773,  773,  781,  773,  782,  783,  773,  773,  773,
			  773,  773,  775,  773,  784,  775,  775,  776,  777,  785,

			  785,  785,  773,  773,  773,  773,  773,  773,  786,  773,
			  773,  773,  787,  773,  773,  773,  773,  773,  773,  773,
			   35,   35,   35,   35,   35,  780,  780,  780,  780,  780,
			   35,  780,   35,   35,   35,   35,   35,  780,  780,  780,
			  780,  780,   35,   35,  780,  780,   35,   35,   35,  780,
			  780,  780,   35,   35,   35,  780,  780,  780,   35,   35,
			   35,   35,  780,  780,  780,  780,   35,   35,  780,  780,
			   35,  780,   35,   35,   35,   35,  780,  780,  780,  780,
			   35,  780,   35,  780,   35,   35,  780,  780,   35,   35,
			  780,  780,   35,  780,   35,   35,  780,  780,   35,  780,

			   35,  780,  773,  773,  779,  781,  773,  773,  788,  789,
			  773,  781,  782,  783,  773,  781,  781,  784,  777,  777,
			  784,  784,  775,  775,  773,  773,  773,  773,  773,  773,
			  773,  773,  773,  773,  773,  773,  773,  773,  773,  773,
			  773,  773,  773,  773,  773,  773,  773,  773,  773,  773,
			  773,  773,  773,  773,  773,  773,  787,  773,  773,   35,
			  780,   35,   35,  780,  780,   35,  780,   35,  780,   35,
			  780,   35,  780,   35,  780,   35,  780,   35,  780,   35,
			  780,   35,   35,  780,  780,   35,  780,   35,   35,  780,
			  780,   35,   35,  780,  780,   35,  780,   35,  780,   35,

			  780,   35,  780,   35,   35,   35,   35,  780,  780,  780,
			  780,   35,  780,   35,   35,  780,  780,   35,  780,   35,
			  780,   35,  780,   35,  780,   35,  780,   35,   35,   35,
			   35,   35,   35,  780,  780,  780,  780,  780,  780,   35,
			   35,  780,  780,   35,  780,   35,  780,   35,  780,   35,
			   35,   35,  780,  780,  780,   35,  780,   35,  780,   35,
			  780,   35,  780,  773,  773,  773,  784,  784,  784,  784,
			  773,  773,  773,  773,  773,  773,  773,  773,  773,  773,
			  773,  773,  773,  773,  773,  773,  773,  773,  773,  773,
			  773,  773,  773,  773,  773,  773,  773,  773,  773,  773,

			  773,  773,  773,  787,  773,  773,   35,  780,   35,  780,
			   35,  780,   35,  780,   35,  780,   35,  780,   35,  780,
			   35,  780,   35,  780,   35,  780,   35,  780,   35,  780,
			   35,   35,  780,  780,   35,  780,   35,  780,   35,  780,
			   35,   35,  780,  780,   35,  780,   35,  780,   35,  780,
			   35,  780,   35,  780,   35,  780,   35,  780,   35,  780,
			   35,  780,   35,  780,   35,  780,   35,  780,   35,  780,
			   35,  780,   35,  780,   35,   35,  780,  780,   35,  780,
			   35,  780,   35,  780,   35,  780,   35,  780,   35,  780,
			   35,  780,   35,  780,   35,  780,   35,  780,   35,  780,

			   35,  780,  784,  773,  773,  773,  773,  773,  773,  773,
			  773,  773,  773,  773,  786,  773,   35,  780,   35,  780,
			   35,  780,   35,  780,   35,  780,   35,  780,   35,  780,
			   35,  780,   35,  780,   35,  780,   35,  780,   35,  780,
			   35,  780,   35,  780,   35,  780,   35,  780,   35,  780,
			   35,  780,   35,  780,   35,  780,   35,  780,   35,  780,
			   35,  780,   35,  780,   35,  780,   35,  780,   35,  780,
			   35,  780,   35,  780,   35,  780,   35,  780,   35,  780,
			   35,  780,   35,  780,   35,  780,   35,  780,   35,  780,
			   35,  780,   35,  780,   35,  780,  784,  773,  773,  773,

			  773,  773,  773,  773,  773,  773,  773,  773,  773,  790,
			   35,  780,   35,  780,   35,   35,  780,  780,   35,  780,
			   35,  780,   35,  780,   35,  780,   35,  780,   35,  780,
			   35,  780,   35,  780,   35,  780,   35,  780,   35,  780,
			   35,  780,   35,  780,   35,  780,   35,  780,   35,  780,
			   35,  780,   35,  780,   35,  780,   35,  780,   35,  780,
			   35,  780,   35,  780,   35,  780,   35,  780,   35,  780,
			   35,  780,  773,  773,  773,  773,  773,  773,  773,  773,
			  773,  773,  773,  773,  773,  773,   35,  780,   35,  780,
			   35,  780,   35,  780,   35,  780,   35,  780,   35,  780,

			   35,  780,   35,  780,   35,  780,   35,  780,   35,  780,
			   35,  780,   35,  780,   35,  780,   35,  780,   35,  780,
			   35,  780,   35,  780,   35,  780,  773,  773,  773,  773,
			  773,  773,  773,  773,  773,  773,  773,   35,  780,   35,
			  780,   35,  780,   35,  780,   35,  780,   35,  780,   35,
			  780,   35,  780,   35,  780,   35,  780,   35,  780,   35,
			  780,  773,  773,  773,  773,  773,   35,  780,   35,  780,
			   35,  780,  773,    0,  773,  773,  773,  773,  773,  773,
			  773,  773,  773,  773,  773,  773,  773,  773,  773,  773,
			  773, yy_Dummy>>)
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
			  477,  477,  478,  480,  481,  483,  485,  486,  488,  489,
			  491,  492,  494,  497,  498,  500,  503,  505,  507,  508,
			  511,  513,  515,  516,  518,  519,  521,  522,  524,  525,
			  527,  528,  530,  532,  533,  534,  536,  537,  540,  542,
			  544,  545,  547,  549,  550,  551,  553,  554,  556,  557,

			  559,  560,  562,  563,  565,  567,  569,  571,  572,  573,
			  574,  575,  577,  578,  580,  582,  583,  584,  587,  589,
			  591,  592,  595,  597,  599,  600,  602,  603,  605,  607,
			  609,  611,  613,  615,  616,  617,  618,  619,  620,  621,
			  623,  625,  626,  627,  629,  630,  632,  633,  635,  636,
			  638,  640,  642,  643,  644,  645,  647,  648,  650,  651,
			  653,  654,  657,  659,  660,  661,  662,  663,  664,  664,
			  665,  666,  667,  668,  669,  670,  671,  672,  673,  674,
			  675,  676,  677,  678,  679,  680,  681,  682,  683,  684,
			  685,  686,  687,  689,  689,  691,  691,  693,  693,  693,

			  693,  695,  697,  699,  699,  701,  703,  705,  706,  708,
			  709,  711,  712,  714,  715,  717,  718,  720,  721,  723,
			  724,  726,  727,  729,  730,  732,  733,  736,  738,  740,
			  741,  743,  745,  746,  747,  749,  750,  752,  753,  755,
			  756,  759,  761,  763,  764,  766,  767,  769,  770,  772,
			  773,  775,  776,  778,  779,  782,  784,  786,  787,  790,
			  792,  794,  795,  798,  800,  802,  803,  805,  806,  808,
			  809,  811,  812,  814,  815,  817,  819,  820,  821,  823,
			  824,  826,  827,  829,  830,  832,  833,  836,  838,  841,
			  843,  845,  846,  848,  849,  851,  852,  854,  855,  858,

			  860,  863,  865,  865,  866,  867,  869,  869,  869,  871,
			  871,  875,  875,  877,  877,  877,  879,  882,  884,  887,
			  889,  891,  892,  895,  897,  900,  902,  904,  905,  907,
			  908,  910,  911,  914,  916,  918,  919,  921,  922,  924,
			  925,  927,  928,  930,  931,  933,  934,  937,  939,  941,
			  942,  944,  945,  947,  948,  950,  951,  953,  954,  956,
			  957,  959,  960,  963,  965,  967,  968,  970,  971,  973,
			  974,  976,  977,  979,  980,  982,  983,  985,  986,  988,
			  989,  992,  994,  996,  997,  999, 1000, 1003, 1005, 1007,
			 1008, 1010, 1011, 1014, 1016, 1018, 1019, 1019, 1020, 1020,

			 1022, 1022, 1023, 1024, 1028, 1028, 1028, 1030, 1030, 1031,
			 1031, 1034, 1036, 1038, 1039, 1042, 1044, 1046, 1047, 1049,
			 1050, 1052, 1053, 1056, 1058, 1061, 1063, 1065, 1066, 1069,
			 1071, 1073, 1074, 1076, 1077, 1080, 1082, 1084, 1085, 1087,
			 1088, 1090, 1091, 1093, 1094, 1096, 1097, 1099, 1100, 1102,
			 1103, 1105, 1106, 1108, 1109, 1112, 1114, 1116, 1117, 1120,
			 1122, 1125, 1127, 1130, 1132, 1134, 1135, 1137, 1138, 1141,
			 1143, 1145, 1146, 1146, 1147, 1147, 1147, 1147, 1151, 1151,
			 1152, 1153, 1153, 1153, 1154, 1155, 1156, 1159, 1161, 1163,
			 1164, 1167, 1169, 1171, 1172, 1174, 1175, 1177, 1178, 1181,

			 1183, 1186, 1188, 1190, 1191, 1194, 1196, 1199, 1201, 1203,
			 1204, 1206, 1207, 1209, 1210, 1212, 1213, 1215, 1216, 1219,
			 1221, 1223, 1224, 1226, 1227, 1230, 1232, 1233, 1233, 1234,
			 1234, 1236, 1236, 1236, 1237, 1238, 1238, 1239, 1242, 1244,
			 1247, 1249, 1252, 1254, 1257, 1259, 1262, 1264, 1266, 1267,
			 1270, 1272, 1274, 1275, 1278, 1280, 1282, 1283, 1286, 1288,
			 1291, 1293, 1294, 1296, 1296, 1298, 1299, 1302, 1304, 1307,
			 1309, 1312, 1314, 1316, 1316, yy_Dummy>>)
		end

	yy_acclist_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,  136,  136,  152,  150,  151,    3,  150,  151,    4,
			  151,    1,  150,  151,    2,  150,  151,   10,  150,  151,
			  138,  150,  151,  102,  150,  151,   17,  150,  151,  138,
			  150,  151,  150,  151,   11,  150,  151,   12,  150,  151,
			   31,  150,  151,   30,  150,  151,    8,  150,  151,   29,
			  150,  151,    6,  150,  151,   32,  150,  151,  140,  142,
			  150,  151,  140,  142,  150,  151,  140,  142,  150,  151,
			    9,  150,  151,    7,  150,  151,   36,  150,  151,   34,
			  150,  151,   35,  150,  151,  150,  151,  100,  101,  150,
			  151,  100,  101,  150,  151,  100,  101,  150,  151,  100,

			  101,  150,  151,  100,  101,  150,  151,  100,  101,  150,
			  151,  100,  101,  150,  151,  100,  101,  150,  151,  100,
			  101,  150,  151,  100,  101,  150,  151,  100,  101,  150,
			  151,  100,  101,  150,  151,  100,  101,  150,  151,  100,
			  101,  150,  151,  100,  101,  150,  151,  100,  101,  150,
			  151,  100,  101,  150,  151,  100,  101,  150,  151,  100,
			  101,  150,  151,   15,  150,  151,  150,  151,   16,  150,
			  151,   33,  150,  151,  142,  150,  151,  150,  151,  101,
			  150,  151,  101,  150,  151,  101,  150,  151,  101,  150,
			  151,  101,  150,  151,  101,  150,  151,  101,  150,  151,

			  101,  150,  151,  101,  150,  151,  101,  150,  151,  101,
			  150,  151,  101,  150,  151,  101,  150,  151,  101,  150,
			  151,  101,  150,  151,  101,  150,  151,  101,  150,  151,
			  101,  150,  151,  101,  150,  151,   13,  150,  151,   14,
			  150,  151,  136,  151,  134,  151,  135,  151,  130,  136,
			  151,  133,  151,  136,  151,  136,  151,    3,    4,    1,
			    2,   37,  138,  137,  137, -128,  138, -279, -129,  138,
			 -280,  102,  138,  126,  126,  126,    5,   23,   24,  145,
			  148,   18,   20,  140,  142,  140,  142,  139,  142,   28,
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
			  101,  101,  100,  101,  101,  100,  101,  101,   19,  142,
			  136,  134,  135,  130,  136,  136,  136,  133,  131,  136,
			  132,  136,  137,  138,  137,  138, -128,  138, -129,  138,
			  126,  103,  126,  126,  126,  126,  126,  126,  126,  126,
			  126,  126,  126,  126,  126,  126,  126,  126,  126,  126,
			  126,  126,  126,  126,  126,  145,  148,  143,  145,  148,
			  143,  140,  142,  140,  142,  141,  140,  142,  142,  100,
			  101,  101,  100,  101,   40,  100,  101,  101,   40,  101,

			   41,  100,  101,   41,  101,  100,  101,  101,   44,  100,
			  101,   44,  101,  100,  101,  101,  100,  101,  101,  100,
			  101,  101,  100,  101,  101,  100,  101,  101,  100,  101,
			  100,  101,  101,  101,  100,  101,  101,   56,  100,  101,
			  100,  101,   56,  101,  101,  100,  101,  100,  101,  101,
			  101,  100,  101,  101,  100,  101,  101,  100,  101,  101,
			  100,  101,  101,  100,  101,  100,  101,  100,  101,  100,
			  101,  101,  101,  101,  101,  100,  101,  101,  100,  101,
			  100,  101,  101,  101,   75,  100,  101,   75,  101,  100,
			  101,  101,   77,  100,  101,   77,  101,  100,  101,  101,

			  100,  101,  101,  100,  101,  100,  101,  100,  101,  100,
			  101,  100,  101,  100,  101,  101,  101,  101,  101,  101,
			  101,  100,  101,  100,  101,  101,  101,  100,  101,  101,
			  100,  101,  101,  100,  101,  101,  100,  101,  100,  101,
			  100,  101,  101,  101,  101,  100,  101,  101,  100,  101,
			  101,  100,  101,  101,   99,  100,  101,   99,  101,  149,
			  131,  132,  137,  137,  137,  120,  118,  119,  121,  122,
			  127,  123,  124,  104,  105,  106,  107,  108,  109,  110,
			  111,  112,  113,  114,  115,  116,  117,  145,  148,  145,
			  148,  145,  148,  144,  147,  140,  142,  140,  142,  140,

			  142,  140,  142,  100,  101,  101,  100,  101,  101,  100,
			  101,  101,  100,  101,  101,  100,  101,  101,  100,  101,
			  101,  100,  101,  101,  100,  101,  101,  100,  101,  101,
			  100,  101,  101,   54,  100,  101,   54,  101,  100,  101,
			  101,  100,  101,  100,  101,  101,  101,  100,  101,  101,
			  100,  101,  101,  100,  101,  101,   63,  100,  101,  100,
			  101,   63,  101,  101,  100,  101,  101,  100,  101,  101,
			  100,  101,  101,  100,  101,  101,  100,  101,  101,   72,
			  100,  101,   72,  101,  100,  101,  101,   74,  100,  101,
			   74,  101,  100,  101,  101,   78,  100,  101,   78,  101,

			  100,  101,  101,  100,  101,  101,  100,  101,  101,  100,
			  101,  101,  100,  101,  101,  100,  101,  100,  101,  101,
			  101,  100,  101,  101,  100,  101,  101,  100,  101,  101,
			  100,  101,  101,   91,  100,  101,   91,  101,   92,  100,
			  101,   92,  101,  100,  101,  101,  100,  101,  101,  100,
			  101,  101,  100,  101,  101,   97,  100,  101,   97,  101,
			   98,  100,  101,   98,  101,  127,  145,  145,  148,  145,
			  148,  144,  145,  147,  148,  144,  147,  140,  142,   38,
			  100,  101,   38,  101,   39,  100,  101,   39,  101,  100,
			  101,  101,   45,  100,  101,   45,  101,   46,  100,  101,

			   46,  101,  100,  101,  101,  100,  101,  101,  100,  101,
			  101,   51,  100,  101,   51,  101,  100,  101,  101,  100,
			  101,  101,  100,  101,  101,  100,  101,  101,  100,  101,
			  101,  100,  101,  101,   61,  100,  101,   61,  101,  100,
			  101,  101,  100,  101,  101,  100,  101,  101,  100,  101,
			  101,  100,  101,  101,  100,  101,  101,  100,  101,  101,
			   73,  100,  101,   73,  101,  100,  101,  101,  100,  101,
			  101,  100,  101,  101,  100,  101,  101,  100,  101,  101,
			  100,  101,  101,  100,  101,  101,  100,  101,  101,   87,
			  100,  101,   87,  101,  100,  101,  101,  100,  101,  101,

			   90,  100,  101,   90,  101,  100,  101,  101,  100,  101,
			  101,   95,  100,  101,   95,  101,  100,  101,  101,  125,
			  145,  148,  148,  145,  144,  145,  147,  148,  144,  147,
			  143,   43,  100,  101,   43,  101,  100,  101,  101,   48,
			  100,  101,  100,  101,   48,  101,  101,  100,  101,  101,
			  100,  101,  101,   55,  100,  101,   55,  101,   57,  100,
			  101,   57,  101,  100,  101,  101,   59,  100,  101,   59,
			  101,  100,  101,  101,  100,  101,  101,   64,  100,  101,
			   64,  101,  100,  101,  101,  100,  101,  101,  100,  101,
			  101,  100,  101,  101,  100,  101,  101,  100,  101,  101,

			  100,  101,  101,  100,  101,  101,  100,  101,  101,   83,
			  100,  101,   83,  101,  100,  101,  101,   85,  100,  101,
			   85,  101,   86,  100,  101,   86,  101,   88,  100,  101,
			   88,  101,  100,  101,  101,  100,  101,  101,   94,  100,
			  101,   94,  101,  100,  101,  101,  145,  144,  145,  147,
			  148,  148,  144,  146,  148,  146,   47,  100,  101,   47,
			  101,  100,  101,  101,   50,  100,  101,   50,  101,  100,
			  101,  101,  100,  101,  101,  100,  101,  101,   62,  100,
			  101,   62,  101,   66,  100,  101,   66,  101,  100,  101,
			  101,   68,  100,  101,   68,  101,   69,  100,  101,   69,

			  101,  100,  101,  101,  100,  101,  101,  100,  101,  101,
			  100,  101,  101,  100,  101,  101,   84,  100,  101,   84,
			  101,  100,  101,  101,  100,  101,  101,   96,  100,  101,
			   96,  101,  148,  148,  144,  145,  147,  148,  147,   49,
			  100,  101,   49,  101,   52,  100,  101,   52,  101,   58,
			  100,  101,   58,  101,   60,  100,  101,   60,  101,   67,
			  100,  101,   67,  101,  100,  101,  101,   76,  100,  101,
			   76,  101,  100,  101,  101,   82,  100,  101,   82,  101,
			  100,  101,  101,   89,  100,  101,   89,  101,   93,  100,
			  101,   93,  101,  148,  147,  148,  147,  148,  147,   70,

			  100,  101,   70,  101,   80,  100,  101,   80,  101,   81,
			  100,  101,   81,  101,  147,  148, yy_Dummy>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER is 2673
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER is 773
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER is 774
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

	yyNb_rules: INTEGER is 151
			-- Number of rules

	yyEnd_of_buffer: INTEGER is 152
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
