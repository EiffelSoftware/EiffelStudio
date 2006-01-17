indexing
	description:"Scanners for Eiffel parsers"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

					if not in_comments then
						create {EDITOR_TOKEN_TABULATION} curr_token.make(text_count)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
when 4 then
--|#line 43 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 43")
end

					from i_ := 1 until i_ > text_count loop
						create {EDITOR_TOKEN_EOL} curr_token.make
						update_token_list
						i_ := i_ + 1
					end
					in_comments := False
					
when 5 then
--|#line 55 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 55")
end
 
						-- comments
					create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					in_comments := True	
					update_token_list					
				
when 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17 then
--|#line 64 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 64")
end

						-- Symbols
					if not in_comments then
						create {EDITOR_TOKEN_TEXT} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
when 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36 then
--|#line 85 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 85")
end
 
						-- Operator Symbol
					if not in_comments then
						create {EDITOR_TOKEN_OPERATOR} curr_token.make(text)					
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
when 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101 then
--|#line 115 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 115")
end

										-- Keyword
										if not in_comments then
											create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
										
when 102 then
--|#line 192 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 192")
end

										if not in_comments then
											if not Eiffel_universe.classes_with_name (text).is_empty then
												create {EDITOR_TOKEN_CLASS} curr_token.make(text)
											else
												create {EDITOR_TOKEN_TEXT} curr_token.make(text)
											end									
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
										
when 103 then
--|#line 206 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 206")
end

										if not in_comments then
												create {EDITOR_TOKEN_TEXT} curr_token.make(text)											
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
										
when 104 then
--|#line 218 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 218")
end

										if not in_comments then
											create {EDITOR_TOKEN_TEXT} curr_token.make(text)										
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
										
when 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126 then
--|#line 232 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 232")
end

					if not in_comments then
						create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
when 127 then
--|#line 262 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 262")
end

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
					
when 128, 129 then
--|#line 277 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 277")
end

					-- Character error. Catch-all rules (no backing up)
					if not in_comments then
						create {EDITOR_TOKEN_TEXT} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
when 130 then
--|#line 300 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 300")
end

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
			
when 131 then
--|#line 314 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 314")
end

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
			
when 132 then
--|#line 329 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 329")
end
-- Ignore carriage return
when 133 then
--|#line 330 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 330")
end

							-- Verbatim string closer, possibly.
						create {EDITOR_TOKEN_STRING} curr_token.make(text)						
						end_of_verbatim_string := True
						in_verbatim_string := False
						set_start_condition (INITIAL)
						update_token_list
					
when 134 then
--|#line 339 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 339")
end

							-- Verbatim string closer, possibly.
						create {EDITOR_TOKEN_STRING} curr_token.make(text)						
						end_of_verbatim_string := True
						in_verbatim_string := False
						set_start_condition (INITIAL)
						update_token_list
					
when 135 then
--|#line 348 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 348")
end

						create {EDITOR_TOKEN_SPACE} curr_token.make(text_count)
						update_token_list						
					
when 136 then
--|#line 353 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 353")
end
						
						create {EDITOR_TOKEN_TABULATION} curr_token.make(text_count)
						update_token_list						
					
when 137 then
--|#line 358 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 358")
end

						from i_ := 1 until i_ > text_count loop
							create {EDITOR_TOKEN_EOL} curr_token.make
							update_token_list
							i_ := i_ + 1
						end						
					
when 138 then
--|#line 366 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 366")
end

						create {EDITOR_TOKEN_STRING} curr_token.make(text)
						update_token_list
					
when 139, 140 then
--|#line 372 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 372")
end

					-- Eiffel String
					if not in_comments then						
						create {EDITOR_TOKEN_STRING} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
when 141 then
--|#line 385 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 385")
end

					-- Eiffel Bit
					if not in_comments then
						create {EDITOR_TOKEN_NUMBER} curr_token.make(text)						
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
when 142, 143 then
--|#line 397 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 397")
end

						-- Eiffel Integer
						if not in_comments then
							create {EDITOR_TOKEN_NUMBER} curr_token.make(text)
						else
							create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
						end
						update_token_list
						
when 144 then
--|#line 407 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 407")
end

							-- Eiffel Integer Error (considered as text)
						if not in_comments then
							create {EDITOR_TOKEN_TEXT} curr_token.make(text)
						else
							create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
						end
						update_token_list
						
when 145 then
	yy_end := yy_end - 1
--|#line 419 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 419")
end

							-- Eiffel reals & doubles
						if not in_comments then		
							create {EDITOR_TOKEN_NUMBER} curr_token.make(text)
						else
							create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
						end
						update_token_list
						
when 146, 147 then
--|#line 420 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 420")
end

							-- Eiffel reals & doubles
						if not in_comments then		
							create {EDITOR_TOKEN_NUMBER} curr_token.make(text)
						else
							create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
						end
						update_token_list
						
when 148 then
	yy_end := yy_end - 1
--|#line 422 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 422")
end

							-- Eiffel reals & doubles
						if not in_comments then		
							create {EDITOR_TOKEN_NUMBER} curr_token.make(text)
						else
							create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
						end
						update_token_list
						
when 149, 150 then
--|#line 423 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 423")
end

							-- Eiffel reals & doubles
						if not in_comments then		
							create {EDITOR_TOKEN_NUMBER} curr_token.make(text)
						else
							create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
						end
						update_token_list
						
when 151 then
--|#line 440 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 440")
end

					create {EDITOR_TOKEN_TEXT} curr_token.make(text)
					update_token_list
					
when 152 then
--|#line 448 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 448")
end

					-- Error (considered as text)
				if not in_comments then
					create {EDITOR_TOKEN_TEXT} curr_token.make(text)
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
			  115,  116,  107,  117,  118,  108,  614,  109,  109,  110,
			  108,  142,  109,  109,  110,  120,  108,  111,  110,  110,
			  110,  143,  111,  120,  166,  519,  131,  182,  152,  171,
			  167,  120,  153,  512,   85,   95,  120,  607,   85,  112,
			  203,  203,  203,  144,  181,  154,  113,  125,  405,  111,
			  405,  113,  393,  145,  111,  125,  168,  113,  131,  183,
			  155,  171,  169,  125,  156,   86,  392,   96,  125,   86,
			  391,  112,  120,  120,  120,  120,  181,  157,  183,  203,
			  192,  120,  120,  120,  120,  120,  120,  121,  120,  120,

			  120,  120,  122,  120,  123,  120,  120,  120,  120,  124,
			  120,  120,  120,  120,  120,  120,  120,  125,  390,  389,
			  183,  120,  193,  125,  125,  125,  125,  125,  125,  126,
			  125,  125,  125,  125,  127,  125,  128,  125,  125,  125,
			  125,  129,  125,  125,  125,  125,  125,  125,  125,  120,
			  120,  120,  198,  120,  193,  199,  388,  201,  120,  120,
			  120,  120,  120,  120,  120,  120,  130,  120,  120,  120,
			  120,  120,  120,  120,  120,  120,  120,  120,  120,  120,
			  120,  120,  120,  120,  199,  125,  193,  199,  120,  201,
			  125,  125,  125,  125,  125,  125,  125,  125,  131,  125,

			  125,  125,  125,  125,  125,  125,  125,  125,  125,  125,
			  125,  125,  125,  125,  125,  125,  132,  120,  387,  120,
			  133,  120,  146,  134,  147,  158,  135,  170,  120,  136,
			  172,  120,  159,  160,  148,  120,  196,  120,  161,  386,
			  173,  385,  174,  384,  180,  383,  175,  382,  137,  125,
			  197,  125,  138,  125,  149,  139,  150,  162,  140,  171,
			  125,  141,  176,  125,  163,  164,  151,  125,  196,  125,
			  165,  184,  177,  194,  178,  120,  181,  120,  179,  188,
			  120,  120,  197,  200,  144,  126,  185,  195,  381,  189,
			  127,  137,  128,   93,  145,  138,   94,  129,  139,  380,

			  379,  140,  260,  186,  141,  196,  378,  125,  149,  125,
			  150,  190,  125,  125,  376,  201,  144,  126,  187,  197,
			  151,  191,  127,  137,  128,  266,  145,  138,  155,  129,
			  139,  162,  156,  140,  260,  168,  141,  176,  163,  164,
			  149,  169,  150,  186,  165,  157,  190,  177,  206,  178,
			  207,  207,  151,  179,  268,  375,  191,  266,  187,  207,
			  155,  211,  207,  162,  156,  261,  374,  168,  262,  176,
			  163,  164,  373,  169,  270,  186,  165,  157,  190,  177,
			  207,  178,  207,  214,  208,  179,  268,  208,  191,  215,
			  187,  209,  205,  372,  209,   93,  216,  263,   94,  205,

			  264,  272,  222,  208,  222,  222,  270,   93,  259,  210,
			   94,  367,  120,  366,  212,  274,  223,  276,  223,  223,
			   93,   93,  365,  368,   94,  248,  248,  248,  252,  252,
			  252,  265,  225,  272,  209,  208,  120,   90,  249,  263,
			  260,  253,  264,   95,  125,  213,  278,  274,  108,  276,
			  254,  254,  255,   89,  108,   95,  255,  255,  255,  280,
			  111,  120,   93,  266,  250,   94,  209,   88,  125,   95,
			  249,  263,  269,  253,  264,   96,  218,   87,  278,  219,
			   98,   98,   98,  257,  257,  257,  210,   96,  220,  113,
			  202,  280,  111,  125,   98,  113,   98,  120,   98,   98,

			  221,   96,  120,   98,  270,   98,  119,  267,  114,   98,
			  369,   98,   91,   94,   98,   98,   98,   98,   98,   98,
			  226,   90,  258,  227,  228,  229,  230,   93,  369,  125,
			  371,  368,  231,  271,  125,   89,  120,  120,  232,  268,
			  233,  275,  234,  235,  236,  237,  273,  238,  277,  239,
			   88,   87,  120,  240,  120,  241,  286,  120,  242,  243,
			  244,  245,  246,  247,  289,  272,  279,  281,  125,  125,
			  296,  282,  283,  276,  120,  120,  284,  287,  274,  290,
			  278,  298,  120,  120,  125,  285,  125,  293,  286,  125,
			  291,  294,  288,  297,  292,  300,  289,  120,  280,  283,

			  295,  120,  296,  284,  283,  120,  125,  125,  284,  289,
			  120,  290,  120,  298,  125,  125,  299,  286,  302,  293,
			  785,  120,  293,  294,  290,  298,  294,  300,  301,  125,
			  314,  320,  296,  125,  303,  317,  304,  125,  305,  120,
			  120,  308,  125,  309,  125,  310,  120,  318,  300,  306,
			  302,  319,  307,  125,  785,  120,  311,  313,  322,  312,
			  302,  785,  314,  320,  323,  324,  308,  317,  309,  120,
			  310,  125,  125,  308,  315,  309,  326,  310,  125,  318,
			  120,  311,  120,  320,  312,  328,  316,  125,  311,  314,
			  322,  312,  321,  325,  327,  346,  324,  324,  120,  120,

			  785,  125,  377,  377,  377,  785,  317,  343,  326,  348,
			   93,  344,  125,  368,  125,  785,  785,  328,  318,  397,
			  397,  397,  350,  359,  322,  326,  328,  346,  120,  347,
			  125,  125,  329,  120,  330,  120,  335,  120,  336,  343,
			  349,  348,  331,  344,  345,  332,  337,  333,  334,  338,
			  120,  339,  340,  341,  350,  360,  785,  342,  358,  785,
			  125,  348,  360,  785,  335,  125,  336,  125,  335,  125,
			  336,  785,  350,  362,  337,  785,  346,  338,  337,  339,
			  340,  338,  125,  339,  340,  343,  351,  354,  120,  344,
			  358,  352,  355,  364,  360,  361,  120,  357,  120,  120,

			  409,  408,  353,  356,  410,  362,  785,  363,  203,  203,
			  203,  206,  120,  207,  207,  396,  396,  396,  354,  354,
			  125,  785,  785,  355,  355,  364,  785,  362,  125,  358,
			  125,  125,  409,  409,  356,  356,  411,  785,  207,  364,
			  207,  207,  785,  207,  125,  211,  207,  203,  208,  209,
			  785,  208,  209,  215,  216,  785,  205,  205,  207,   93,
			  207,  214,  368,  394,  394,  394,  208,  406,  406,  406,
			  785,  785,  370,  370,  370,  222,  249,  222,  222,  223,
			   93,  223,  223,   94,   93,  369,  785,   94,  368,  395,
			  785,  395,  785,  208,  396,  396,  396,  209,  212,  513,

			  513,  513,  250,  398,  398,  398,  258,  785,  249,  120,
			   98,  785,  401,  208,  401,  411,  399,  402,  402,  402,
			  407,  407,  407,  120,  209,  412,  413,  785,   95,  213,
			  120,  108,   95,  403,  403,  404,  108,  415,  404,  404,
			  404,  125,  400,  111,  209,  785,  414,  411,  399,  417,
			  120,  120,  120,  419,  421,  125,  423,  413,  413,  258,
			   96,  416,  125,  418,   96,  420,  426,  120,  120,  415,
			  120,  425,  113,  120,  427,  111,  422,  113,  415,  429,
			  424,  417,  125,  125,  125,  419,  421,  428,  423,  120,
			  431,  120,  120,  417,  437,  419,  439,  421,  427,  125,

			  125,  432,  125,  425,  430,  125,  427,  120,  423,  120,
			  436,  429,  425,  434,  120,  433,  441,  438,  120,  429,
			  447,  125,  431,  125,  125,  450,  437,  435,  439,  440,
			  444,  785,  120,  434,  120,  446,  431,  449,  442,  125,
			  448,  125,  437,  445,  120,  434,  125,  435,  441,  439,
			  125,  443,  447,  120,  452,  456,  451,  451,  120,  435,
			  454,  441,  444,  120,  125,  453,  125,  447,  455,  449,
			  444,  457,  449,  458,  459,  445,  125,  120,  461,  463,
			  120,  460,  465,  445,  120,  125,  453,  457,  451,  120,
			  125,  462,  455,  120,  120,  125,  467,  453,  466,  464,

			  455,  468,  120,  457,  469,  459,  459,  120,  785,  125,
			  461,  463,  125,  461,  465,  470,  125,  120,  471,  476,
			  472,  125,  473,  463,  120,  125,  125,  120,  467,  478,
			  467,  465,  475,  470,  125,  120,  471,  474,  477,  125,
			  480,  120,  479,  485,  484,  482,  120,  470,  487,  125,
			  471,  477,  473,  486,  473,  489,  125,  120,  481,  125,
			  488,  479,  490,  483,  475,  491,  120,  125,  120,  475,
			  477,  492,  482,  125,  479,  485,  485,  482,  125,  493,
			  487,  495,  494,  120,  496,  487,  120,  489,  120,  125,
			  483,  498,  489,  500,  491,  483,  497,  491,  125,  499,

			  125,  501,  502,  493,  503,  504,  505,  120,  507,  120,
			  120,  493,  506,  495,  495,  125,  497,  785,  125,  785,
			  125,  785,  523,  499,  785,  501,  785,  785,  497,  785,
			  525,  499,  785,  501,  503,  785,  503,  505,  505,  125,
			  507,  125,  125,   93,  507,  785,  368,  509,  377,  377,
			  377,  510,  510,  510,  523,   98,  508,  508,  508,  511,
			  511,  511,  525,  527,  249,  514,  514,  514,  515,  785,
			  515,  785,  785,  516,  516,  516,  529,  120,  399,  517,
			  517,  517,  402,  402,  402,  518,  518,  518,  522,  520,
			  250,  403,  403,  404,  531,  527,  249,  526,  512,  120,

			  120,  111,  528,  520,  400,  404,  404,  404,  529,  125,
			  399,  521,  521,  521,  407,  407,  407,  120,  785,  532,
			  523,  785,  533,  120,  519,  120,  531,  524,  120,  527,
			  258,  125,  125,  111,  529,  530,  535,  536,  537,  534,
			  538,  120,  120,  539,  258,  541,  542,  120,  543,  125,
			  258,  533,  120,  258,  533,  125,  540,  125,  545,  525,
			  125,  544,  547,  549,  551,  553,  785,  531,  535,  537,
			  537,  535,  539,  125,  125,  539,  120,  541,  543,  125,
			  543,  546,  120,  120,  125,  552,  120,  555,  541,  120,
			  545,  548,  550,  545,  547,  549,  551,  553,  554,  120,

			  556,  557,  558,  559,  120,  120,  561,  120,  125,  563,
			  565,  567,  785,  547,  125,  125,  120,  553,  125,  555,
			  560,  125,  562,  549,  551,  564,  569,  120,  571,  120,
			  555,  125,  557,  557,  559,  559,  125,  125,  561,  125,
			  566,  563,  565,  567,  120,  573,  120,  120,  125,  120,
			  570,  120,  561,  120,  563,  568,  572,  565,  569,  125,
			  571,  125,  576,  574,  575,  577,  578,  579,  581,  120,
			  120,  120,  567,  583,  582,  584,  125,  573,  125,  125,
			  580,  125,  571,  125,  585,  125,  120,  569,  573,  588,
			  587,  589,  120,  120,  577,  575,  575,  577,  579,  579,

			  581,  125,  125,  125,  586,  583,  583,  585,  591,  590,
			  593,  592,  581,  595,  597,  120,  585,  120,  125,  120,
			  120,  589,  587,  589,  125,  125,  120,  596,  594,  598,
			  599,  601,  120,  603,  120,  605,  587,  602,  120,  120,
			  591,  591,  593,  593,  120,  595,  597,  125,  604,  125,
			  600,  125,  125,  609,  609,  609,  120,  120,  125,  597,
			  595,  599,  599,  601,  125,  603,  125,  605,  785,  603,
			  125,  125,   93,  120,  785,  368,  125,  510,  510,  510,
			  605,  785,  601,  785,   98,  606,  606,  606,  125,  125,
			  608,  621,  512,  610,  610,  610,  611,  611,  611,  612,

			  612,  612,  516,  516,  516,  125,  613,  613,  613,  615,
			  615,  615,  399,  616,  616,  616,  617,  617,  617,  612,
			  612,  612,  608,  621,  619,  120,  407,  407,  407,  120,
			  620,  120,  618,  785,  120,  623,  624,  626,  400,  629,
			  625,  627,  120,  622,  399,  614,  120,  628,  631,  120,
			  632,  633,  519,  120,  635,  634,  637,  125,  630,  120,
			  785,  125,  621,  125,  618,  113,  125,  623,  626,  626,
			  639,  629,  627,  627,  125,  623,  641,  120,  125,  629,
			  631,  125,  633,  633,  636,  125,  635,  635,  637,  120,
			  631,  125,  120,  120,  643,  120,  120,  645,  640,  647,

			  648,  644,  639,  638,  642,  649,  646,  120,  641,  125,
			  120,  650,  651,  652,  653,  654,  637,  655,  120,  120,
			  785,  125,  657,  659,  125,  125,  643,  125,  125,  645,
			  641,  647,  649,  645,  661,  639,  643,  649,  647,  125,
			  662,  120,  125,  651,  651,  653,  653,  655,  656,  655,
			  125,  125,  120,  120,  657,  659,  660,  663,  665,  664,
			  666,  667,  658,  120,  120,  120,  661,  669,  671,  673,
			  120,  670,  663,  125,  668,  120,  120,  675,  676,  677,
			  657,  672,  120,  678,  125,  125,  120,  120,  661,  663,
			  665,  665,  667,  667,  659,  125,  125,  125,  674,  669,

			  671,  673,  125,  671,  679,  681,  669,  125,  125,  675,
			  677,  677,  680,  673,  125,  679,  120,  120,  125,  125,
			  120,  683,  684,   93,  684,  682,  368,  685,  685,  685,
			  675,  685,  685,  685,  687,   98,  679,  681,  686,  686,
			  686,  612,  612,  612,  681,  689,  689,  689,  125,  125,
			  120,  785,  125,  683,  688,  699,  785,  683,  785,  785,
			  250,  690,  690,  690,  120,  701,  687,  691,  691,  691,
			  512,  692,  692,  692,  693,  693,  693,  703,  696,  696,
			  696,  120,  125,  694,  614,  694,  688,  699,  692,  692,
			  692,  697,  698,  120,  120,  705,  125,  701,  704,  700,

			  120,  120,  120,  706,  707,  702,  120,  120,  708,  703,
			  519,  709,  711,  125,  710,  120,  120,  713,  120,  120,
			  785,  715,  717,  697,  699,  125,  125,  705,  719,  712,
			  705,  701,  125,  125,  125,  707,  707,  703,  125,  125,
			  709,  721,  723,  709,  711,  120,  711,  125,  125,  713,
			  125,  125,  120,  715,  717,  120,  716,  714,  120,  720,
			  719,  713,  120,  725,  120,  120,  718,  120,  727,  722,
			  726,  120,  724,  721,  723,  729,  728,  125,  120,  730,
			  731,  120,  120,  120,  125,  120,  733,  125,  717,  715,
			  125,  721,  785,  735,  125,  725,  125,  125,  719,  125,

			  727,  723,  727,  125,  725,  120,  120,  729,  729,  120,
			  125,  731,  731,  125,  125,  125,  732,  125,  733,  120,
			  736,  737,  120,  785,  734,  735,  685,  685,  685,  685,
			  685,  685,  738,  738,  738,  785,  785,  125,  125,  785,
			  739,  125,  739,  744,  785,  740,  740,  740,  733,  785,
			  785,  125,  737,  737,  125,  741,  735,  741,  785,  785,
			  742,  742,  742,  742,  742,  742,  743,  743,  743,  400,
			  692,  692,  692,  750,  120,  744,  745,  745,  745,  692,
			  692,  692,  746,  746,  746,  747,  752,  747,  120,  785,
			  748,  748,  748,  749,  751,  744,  753,  754,  756,  120,

			  120,  120,  614,  755,  120,  750,  125,  120,  757,  758,
			  120,  120,  120,  760,  120,  762,  120,  764,  752,  759,
			  125,  400,  763,  766,  785,  750,  752,  744,  754,  754,
			  756,  125,  125,  125,  761,  756,  125,  768,  120,  125,
			  758,  758,  125,  125,  125,  760,  125,  762,  125,  764,
			  120,  760,  765,  767,  764,  766,  120,  769,  770,  120,
			  771,  120,  772,  120,  120,  785,  762,  785,  785,  768,
			  125,  740,  740,  740,  773,  773,  773,  742,  742,  742,
			  120,  785,  125,  785,  766,  768,  785,  785,  125,  770,
			  770,  125,  772,  125,  772,  125,  125,  742,  742,  742,

			  774,  774,  774,  775,  120,  775,  120,  120,  776,  776,
			  776,  120,  125,  512,  691,  691,  691,  748,  748,  748,
			  120,  777,  777,  777,  779,  120,  120,  744,  785,  781,
			  120,  778,  783,  782,  120,  780,  125,  120,  125,  125,
			  120,  785,  785,  125,  738,  738,  738,  776,  776,  776,
			  120,  785,  125,  400,  120,  120,  779,  125,  125,  744,
			  519,  781,  125,  779,  783,  783,  125,  781,  785,  125,
			  785,  785,  125,  784,  784,  784,  745,  745,  745,  774,
			  774,  774,  125,  512,  785,  785,  125,  125,  125,  125,
			  125,  125,  125,  125,  125,  125,  125,  125,  125,  256,

			  256,  256,  785,  785,  785,  785,  785,  785,  785,  785,
			  785,  785,  614,  785,  785,  519,  785,  785,  614,   80,
			   80,   80,   80,   80,   80,   80,   80,   80,   80,   80,
			   80,   80,   80,   80,   80,   80,   80,   80,   80,   92,
			   92,  785,   92,   92,   92,   92,   92,   92,   92,   92,
			   92,   92,   92,   92,   92,   92,   92,   92,   92,   97,
			  785,  785,  785,  785,  785,  785,   97,   97,   97,   97,
			   97,   97,   97,   97,   97,   97,   97,   97,   97,   98,
			   98,  785,   98,   98,   98,   98,   98,   98,   98,   98,
			   98,   98,   98,   98,   98,   98,   98,   98,   98,   99,

			   99,  785,   99,   99,   99,   99,   99,   99,   99,   99,
			   99,   99,   99,   99,   99,   99,   99,   99,   99,  204,
			  204,  785,  204,  204,  204,  785,  785,  204,  204,  204,
			  204,  204,  204,  204,  204,  204,  204,  204,  204,  205,
			  785,  785,  205,  785,  205,  205,  205,  205,  205,  205,
			  205,  205,  205,  205,  205,  205,  205,  205,  205,  212,
			  212,  785,  212,  212,  212,  212,  212,  212,  212,  212,
			  212,  212,  212,  212,  212,  212,  212,  212,  212,  213,
			  213,  785,  213,  213,  213,  213,  213,  213,  213,  213,
			  213,  213,  213,  213,  213,  213,  213,  213,  213,  217,

			  217,  785,  217,  217,  217,  217,  217,  217,  217,  217,
			  217,  217,  217,  217,  217,  217,  217,  217,  217,  224,
			  224,  785,  224,  224,  224,  224,  224,  224,  224,  224,
			  224,  224,  224,  224,  224,  224,  224,  224,  224,  251,
			  251,  251,  251,  251,  251,  251,  251,  785,  251,  251,
			  251,  251,  251,  251,  251,  251,  251,  251,  251,  208,
			  208,  785,  208,  208,  208,  785,  208,  208,  208,  208,
			  208,  208,  208,  208,  208,  208,  208,  208,  208,  209,
			  209,  785,  209,  209,  209,  785,  209,  209,  209,  209,
			  209,  209,  209,  209,  209,  209,  209,  209,  209,  695,

			  695,  695,  695,  695,  695,  695,  695,  785,  695,  695,
			  695,  695,  695,  695,  695,  695,  695,  695,  695,    5,
			  785,  785,  785,  785,  785,  785,  785,  785,  785,  785,
			  785,  785,  785,  785,  785,  785,  785,  785,  785,  785,
			  785,  785,  785,  785,  785,  785,  785,  785,  785,  785,
			  785,  785,  785,  785,  785,  785,  785,  785,  785,  785,
			  785,  785,  785,  785,  785,  785,  785,  785,  785,  785,
			  785,  785,  785,  785,  785,  785,  785,  785,  785,  785,
			  785,  785,  785,  785,  785,  785,  785,  785,  785,  785,
			  785,  785,  785,  785,  785,  785,  785,  785,  785,  785,

			  785,  785,  785,  785,  785,  785,  785,  785, yy_Dummy>>)
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
			   30,   30,   24,   32,   32,   25,  774,   25,   25,   25,
			   26,   37,   26,   26,   26,   37,   27,   25,   27,   27,
			   27,   37,   26,   40,   42,  745,   60,   46,   39,   68,
			   42,   46,   39,  738,    3,   12,   39,  509,    4,   25,
			   57,   57,   57,   37,   70,   39,   25,   37,  405,   25,
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
			  100,   10,  113,  100,  100,  100,  100,  221,  368,  124,
			  221,  368,  100,  132,  143,    9,  134,  132,  100,  124,
			  100,  134,  100,  100,  100,  100,  133,  100,  135,  100,
			    8,    7,  135,  100,  133,  100,  149,  136,  100,  100,
			  100,  100,  100,  100,  150,  132,  136,  142,  134,  132,
			  155,  142,  144,  134,  142,  146,  144,  147,  133,  150,
			  135,  156,  147,  148,  135,  146,  133,  151,  149,  136,
			  148,  151,  147,  153,  148,  157,  150,  152,  136,  142,

			  152,  153,  155,  142,  144,  158,  142,  146,  144,  147,
			  154,  150,  161,  156,  147,  148,  154,  146,  163,  151,
			    5,  159,  148,  151,  147,  153,  148,  157,  159,  152,
			  168,  171,  152,  153,  160,  169,  160,  158,  160,  160,
			  170,  164,  154,  164,  161,  164,  175,  169,  154,  160,
			  163,  170,  160,  159,    0,  166,  164,  166,  176,  164,
			  159,    0,  168,  171,  173,  177,  160,  169,  160,  173,
			  160,  160,  170,  164,  167,  164,  178,  164,  175,  169,
			  167,  160,  172,  170,  160,  181,  167,  166,  164,  166,
			  176,  164,  172,  174,  180,  187,  173,  177,  180,  174,

			    0,  173,  231,  231,  231,    0,  167,  186,  178,  190,
			  369,  186,  167,  369,  172,    0,    0,  181,  167,  250,
			  250,  250,  191,  195,  172,  174,  180,  187,  189,  188,
			  180,  174,  182,  188,  182,  185,  183,  182,  183,  186,
			  189,  190,  182,  186,  185,  182,  183,  182,  182,  183,
			  184,  183,  183,  184,  191,  195,    0,  184,  196,    0,
			  189,  188,  197,    0,  182,  188,  182,  185,  183,  182,
			  183,    0,  189,  199,  182,    0,  185,  182,  183,  182,
			  182,  183,  184,  183,  183,  184,  192,  193,  194,  184,
			  196,  192,  193,  201,  197,  198,  259,  194,  200,  198,

			  260,  259,  192,  193,  261,  199,    0,  200,  203,  203,
			  203,  206,  261,  206,  206,  395,  395,  395,  192,  193,
			  194,    0,    0,  192,  193,  201,    0,  198,  259,  194,
			  200,  198,  260,  259,  192,  193,  261,    0,  207,  200,
			  207,  207,    0,  211,  261,  211,  211,  203,  212,  213,
			    0,  212,  213,  212,  213,    0,  212,  213,  214,  220,
			  214,  214,  220,  248,  248,  248,  206,  257,  257,  257,
			    0,    0,  220,  220,  220,  222,  248,  222,  222,  223,
			  222,  223,  223,  222,  223,  371,    0,  223,  371,  249,
			    0,  249,    0,  207,  249,  249,  249,  206,  211,  397,

			  397,  397,  248,  252,  252,  252,  257,    0,  248,  262,
			  371,    0,  253,  214,  253,  263,  252,  253,  253,  253,
			  258,  258,  258,  265,  207,  267,  268,    0,  222,  211,
			  269,  254,  223,  254,  254,  254,  255,  272,  255,  255,
			  255,  262,  252,  254,  214,    0,  271,  263,  252,  274,
			  275,  273,  271,  276,  278,  265,  280,  267,  268,  258,
			  222,  273,  269,  275,  223,  277,  282,  279,  281,  272,
			  282,  283,  254,  277,  284,  254,  279,  255,  271,  286,
			  281,  274,  275,  273,  271,  276,  278,  285,  280,  287,
			  290,  285,  288,  273,  294,  275,  296,  277,  282,  279,

			  281,  291,  282,  283,  288,  277,  284,  295,  279,  291,
			  292,  286,  281,  293,  292,  291,  298,  295,  297,  285,
			  302,  287,  290,  285,  288,  304,  294,  293,  296,  297,
			  300,    0,  301,  291,  299,  301,  288,  308,  299,  295,
			  303,  291,  292,  300,  303,  293,  292,  291,  298,  295,
			  297,  299,  302,  306,  305,  307,  309,  304,  305,  293,
			  306,  297,  300,  307,  301,  310,  299,  301,  311,  308,
			  299,  312,  303,  313,  314,  300,  303,  313,  317,  318,
			  319,  315,  322,  299,  316,  306,  305,  307,  309,  315,
			  305,  316,  306,  321,  323,  307,  326,  310,  325,  321,

			  311,  327,  325,  312,  327,  313,  314,  327,    0,  313,
			  317,  318,  319,  315,  322,  328,  316,  332,  328,  331,
			  329,  315,  335,  316,  329,  321,  323,  331,  326,  332,
			  325,  321,  336,  327,  325,  334,  327,  330,  337,  327,
			  333,  330,  338,  340,  334,  339,  333,  328,  343,  332,
			  328,  331,  329,  341,  335,  344,  329,  341,  333,  331,
			  342,  332,  345,  339,  336,  346,  347,  334,  342,  330,
			  337,  347,  333,  330,  338,  340,  334,  339,  333,  348,
			  343,  350,  349,  352,  351,  341,  349,  344,  351,  341,
			  333,  352,  342,  353,  345,  339,  354,  346,  347,  355,

			  342,  356,  357,  347,  358,  359,  360,  361,  362,  363,
			  359,  348,  361,  350,  349,  352,  351,    0,  349,    0,
			  351,    0,  409,  352,    0,  353,    0,    0,  354,    0,
			  411,  355,    0,  356,  357,    0,  358,  359,  360,  361,
			  362,  363,  359,  370,  361,    0,  370,  377,  377,  377,
			  377,  394,  394,  394,  409,  370,  370,  370,  370,  396,
			  396,  396,  411,  413,  394,  398,  398,  398,  399,    0,
			  399,    0,    0,  399,  399,  399,  415,  408,  398,  400,
			  400,  400,  401,  401,  401,  402,  402,  402,  408,  403,
			  394,  403,  403,  403,  417,  413,  394,  412,  396,  412,

			  414,  403,  414,  404,  398,  404,  404,  404,  415,  408,
			  398,  406,  406,  406,  407,  407,  407,  410,    0,  418,
			  408,    0,  419,  418,  402,  416,  417,  410,  420,  412,
			  403,  412,  414,  403,  414,  416,  421,  422,  423,  420,
			  424,  422,  424,  425,  404,  427,  428,  426,  429,  410,
			  406,  418,  430,  407,  419,  418,  426,  416,  431,  410,
			  420,  430,  434,  435,  437,  439,    0,  416,  421,  422,
			  423,  420,  424,  422,  424,  425,  432,  427,  428,  426,
			  429,  432,  433,  436,  430,  438,  440,  441,  426,  438,
			  431,  433,  436,  430,  434,  435,  437,  439,  440,  442,

			  443,  445,  446,  447,  443,  448,  449,  450,  432,  451,
			  453,  455,    0,  432,  433,  436,  452,  438,  440,  441,
			  448,  438,  450,  433,  436,  452,  457,  458,  461,  462,
			  440,  442,  443,  445,  446,  447,  443,  448,  449,  450,
			  454,  451,  453,  455,  454,  465,  456,  460,  452,  466,
			  460,  468,  448,  464,  450,  456,  464,  452,  457,  458,
			  461,  462,  469,  468,  470,  471,  472,  473,  475,  472,
			  476,  474,  454,  477,  476,  478,  454,  465,  456,  460,
			  474,  466,  460,  468,  479,  464,  481,  456,  464,  481,
			  482,  483,  480,  484,  469,  468,  470,  471,  472,  473,

			  475,  472,  476,  474,  480,  477,  476,  478,  485,  484,
			  487,  486,  474,  489,  491,  492,  479,  486,  481,  488,
			  490,  481,  482,  483,  480,  484,  494,  490,  488,  496,
			  497,  499,  496,  501,  500,  503,  480,  500,  498,  504,
			  485,  484,  487,  486,  506,  489,  491,  492,  502,  486,
			  498,  488,  490,  511,  511,  511,  502,  522,  494,  490,
			  488,  496,  497,  499,  496,  501,  500,  503,    0,  500,
			  498,  504,  508,  524,    0,  508,  506,  510,  510,  510,
			  502,    0,  498,    0,  508,  508,  508,  508,  502,  522,
			  510,  527,  511,  512,  512,  512,  513,  513,  513,  514,

			  514,  514,  515,  515,  515,  524,  516,  516,  516,  517,
			  517,  517,  514,  518,  518,  518,  519,  519,  519,  520,
			  520,  520,  510,  527,  521,  526,  521,  521,  521,  528,
			  526,  530,  520,    0,  532,  533,  534,  535,  514,  537,
			  534,  535,  536,  532,  514,  516,  538,  536,  541,  540,
			  542,  543,  518,  542,  545,  544,  547,  526,  540,  544,
			    0,  528,  526,  530,  520,  521,  532,  533,  534,  535,
			  549,  537,  534,  535,  536,  532,  551,  552,  538,  536,
			  541,  540,  542,  543,  546,  542,  545,  544,  547,  546,
			  540,  544,  548,  550,  555,  554,  556,  557,  550,  559,

			  560,  556,  549,  548,  554,  561,  558,  562,  551,  552,
			  558,  564,  565,  566,  567,  568,  546,  569,  570,  566,
			    0,  546,  573,  575,  548,  550,  555,  554,  556,  557,
			  550,  559,  560,  556,  577,  548,  554,  561,  558,  562,
			  578,  576,  558,  564,  565,  566,  567,  568,  572,  569,
			  570,  566,  572,  574,  573,  575,  576,  579,  581,  580,
			  582,  583,  574,  580,  582,  584,  577,  585,  587,  589,
			  588,  586,  578,  576,  584,  586,  590,  593,  594,  595,
			  572,  588,  596,  598,  572,  574,  594,  592,  576,  579,
			  581,  580,  582,  583,  574,  580,  582,  584,  592,  585,

			  587,  589,  588,  586,  599,  601,  584,  586,  590,  593,
			  594,  595,  600,  588,  596,  598,  600,  602,  594,  592,
			  604,  605,  608,  606,  608,  604,  606,  608,  608,  608,
			  592,  609,  609,  609,  611,  606,  599,  601,  610,  610,
			  610,  612,  612,  612,  600,  613,  613,  613,  600,  602,
			  620,    0,  604,  605,  612,  623,    0,  604,    0,    0,
			  611,  614,  614,  614,  624,  627,  611,  615,  615,  615,
			  609,  616,  616,  616,  617,  617,  617,  629,  619,  619,
			  619,  622,  620,  618,  613,  618,  612,  623,  618,  618,
			  618,  619,  622,  625,  628,  631,  624,  627,  630,  625,

			  632,  634,  630,  636,  637,  628,  638,  636,  640,  629,
			  616,  641,  643,  622,  642,  644,  640,  647,  642,  646,
			    0,  649,  651,  619,  622,  625,  628,  631,  653,  646,
			  630,  625,  632,  634,  630,  636,  637,  628,  638,  636,
			  640,  655,  657,  641,  643,  650,  642,  644,  640,  647,
			  642,  646,  648,  649,  651,  652,  650,  648,  656,  654,
			  653,  646,  658,  659,  660,  662,  652,  654,  663,  656,
			  662,  664,  658,  655,  657,  665,  664,  650,  666,  668,
			  669,  670,  672,  668,  648,  674,  677,  652,  650,  648,
			  656,  654,    0,  679,  658,  659,  660,  662,  652,  654,

			  663,  656,  662,  664,  658,  676,  680,  665,  664,  682,
			  666,  668,  669,  670,  672,  668,  676,  674,  677,  678,
			  682,  683,  698,    0,  678,  679,  684,  684,  684,  685,
			  685,  685,  686,  686,  686,    0,    0,  676,  680,    0,
			  687,  682,  687,  691,    0,  687,  687,  687,  676,    0,
			    0,  678,  682,  683,  698,  688,  678,  688,    0,    0,
			  688,  688,  688,  689,  689,  689,  690,  690,  690,  691,
			  692,  692,  692,  701,  702,  691,  693,  693,  693,  694,
			  694,  694,  696,  696,  696,  697,  705,  697,  700,    0,
			  697,  697,  697,  700,  704,  696,  706,  707,  709,  704,

			  708,  706,  689,  708,  710,  701,  702,  712,  714,  715,
			  714,  716,  718,  721,  720,  723,  724,  725,  705,  720,
			  700,  696,  724,  727,    0,  700,  704,  696,  706,  707,
			  709,  704,  708,  706,  722,  708,  710,  729,  722,  712,
			  714,  715,  714,  716,  718,  721,  720,  723,  724,  725,
			  730,  720,  726,  728,  724,  727,  726,  732,  733,  728,
			  734,  732,  735,  736,  734,    0,  722,    0,    0,  729,
			  722,  739,  739,  739,  740,  740,  740,  741,  741,  741,
			  749,    0,  730,    0,  726,  728,    0,    0,  726,  732,
			  733,  728,  734,  732,  735,  736,  734,  742,  742,  742,

			  743,  743,  743,  744,  751,  744,  753,  755,  744,  744,
			  744,  757,  749,  740,  746,  746,  746,  747,  747,  747,
			  759,  748,  748,  748,  760,  761,  763,  746,    0,  764,
			  765,  759,  768,  767,  769,  763,  751,  767,  753,  755,
			  771,    0,    0,  757,  773,  773,  773,  775,  775,  775,
			  778,    0,  759,  746,  780,  782,  760,  761,  763,  746,
			  748,  764,  765,  759,  768,  767,  769,  763,    0,  767,
			    0,    0,  771,  776,  776,  776,  777,  777,  777,  784,
			  784,  784,  778,  773,    0,    0,  780,  782,  792,  792,
			  792,  792,  792,  792,  792,  792,  792,  792,  792,  799,

			  799,  799,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,  776,    0,    0,  777,    0,    0,  784,  786,
			  786,  786,  786,  786,  786,  786,  786,  786,  786,  786,
			  786,  786,  786,  786,  786,  786,  786,  786,  786,  787,
			  787,    0,  787,  787,  787,  787,  787,  787,  787,  787,
			  787,  787,  787,  787,  787,  787,  787,  787,  787,  788,
			    0,    0,    0,    0,    0,    0,  788,  788,  788,  788,
			  788,  788,  788,  788,  788,  788,  788,  788,  788,  789,
			  789,    0,  789,  789,  789,  789,  789,  789,  789,  789,
			  789,  789,  789,  789,  789,  789,  789,  789,  789,  790,

			  790,    0,  790,  790,  790,  790,  790,  790,  790,  790,
			  790,  790,  790,  790,  790,  790,  790,  790,  790,  791,
			  791,    0,  791,  791,  791,    0,    0,  791,  791,  791,
			  791,  791,  791,  791,  791,  791,  791,  791,  791,  793,
			    0,    0,  793,    0,  793,  793,  793,  793,  793,  793,
			  793,  793,  793,  793,  793,  793,  793,  793,  793,  794,
			  794,    0,  794,  794,  794,  794,  794,  794,  794,  794,
			  794,  794,  794,  794,  794,  794,  794,  794,  794,  795,
			  795,    0,  795,  795,  795,  795,  795,  795,  795,  795,
			  795,  795,  795,  795,  795,  795,  795,  795,  795,  796,

			  796,    0,  796,  796,  796,  796,  796,  796,  796,  796,
			  796,  796,  796,  796,  796,  796,  796,  796,  796,  797,
			  797,    0,  797,  797,  797,  797,  797,  797,  797,  797,
			  797,  797,  797,  797,  797,  797,  797,  797,  797,  798,
			  798,  798,  798,  798,  798,  798,  798,    0,  798,  798,
			  798,  798,  798,  798,  798,  798,  798,  798,  798,  800,
			  800,    0,  800,  800,  800,    0,  800,  800,  800,  800,
			  800,  800,  800,  800,  800,  800,  800,  800,  800,  801,
			  801,    0,  801,  801,  801,    0,  801,  801,  801,  801,
			  801,  801,  801,  801,  801,  801,  801,  801,  801,  802,

			  802,  802,  802,  802,  802,  802,  802,    0,  802,  802,
			  802,  802,  802,  802,  802,  802,  802,  802,  802,  785,
			  785,  785,  785,  785,  785,  785,  785,  785,  785,  785,
			  785,  785,  785,  785,  785,  785,  785,  785,  785,  785,
			  785,  785,  785,  785,  785,  785,  785,  785,  785,  785,
			  785,  785,  785,  785,  785,  785,  785,  785,  785,  785,
			  785,  785,  785,  785,  785,  785,  785,  785,  785,  785,
			  785,  785,  785,  785,  785,  785,  785,  785,  785,  785,
			  785,  785,  785,  785,  785,  785,  785,  785,  785,  785,
			  785,  785,  785,  785,  785,  785,  785,  785,  785,  785,

			  785,  785,  785,  785,  785,  785,  785,  785, yy_Dummy>>)
		end

	yy_base_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,   87,   91,  720, 2719,  649,  647,  631,
			  616,  606,   90,    0, 2719,   91,   92, 2719, 2719, 2719,
			 2719, 2719,   82,   86,   86,   97,  102,  108,  582, 2719,
			   85, 2719,   87,  580,  162,  229,  280,   88,  282,  109,
			   96,  291,   97,  284,  300,  298,  104,  338,  343,  148,
			  344,  216,  340, 2719,  534, 2719, 2719,  130,    0,  350,
			   99,  355,  351,  368,  399,    0,  397,  398,   96,  407,
			  108,  155,  410,  410,  212,  307,  219,  214, 2719, 2719,
			    0,  446,  583,  457,  478,  482,  489,  575,  564,  549,
			  532, 2719,  488, 2719,  569,  500,  514,    0,  386,  521,

			  613,    0, 2719, 2719, 2719,  505, 2719, 2719,  508,  530,
			  536, 2719,    0,  563, 2719, 2719, 2719, 2719, 2719, 2719,
			  294,  475,  428,  499,  560,    0,  369,  502,  393,  407,
			  524,  426,  600,  617,  599,  615,  620,  468,  486,  475,
			  513,  513,  637,  565,  642,    0,  638,  645,  646,  609,
			  632,  643,  660,  664,  673,  630,  652,  652,  668,  684,
			  702,  675,    0,  674,  709,    0,  718,  743,  691,  704,
			  703,  683,  745,  732,  762,  709,  711,  733,  745,    0,
			  761,  752,  800,  804,  813,  798,  767,  749,  796,  791,
			  776,  773,  854,  855,  851,  786,  812,  825,  862,  840,

			  861,  847, 2719,  888,  511,    0,  909,  936,  506,  504,
			  506,  941,  946,  947,  956,    0,    0,  513,  555,  603,
			  952,  620,  973,  977, 2719, 2719,  482,  461,  455,  444,
			  403,  782,  395,  389,  388,  377,  336,  334,  332,  330,
			  328,  307,  245,  208,  207,  169,  165,  151,  943,  974,
			  799, 2719,  983,  997, 1013, 1018,  101,  947, 1000,  859,
			  858,  875,  972,  986,    0,  986,    0,  988,  989,  993,
			    0, 1015, 1006, 1014, 1002, 1013, 1003, 1036, 1025, 1030,
			 1010, 1031, 1033, 1022, 1041, 1054, 1046, 1052, 1055,    0,
			 1041, 1072, 1077, 1084, 1061, 1070, 1049, 1081, 1068, 1097,

			 1089, 1095, 1080, 1107, 1088, 1121, 1116, 1126, 1104, 1119,
			 1132, 1124, 1142, 1140, 1141, 1152, 1147, 1149, 1135, 1143,
			    0, 1156, 1139, 1157,    0, 1165, 1163, 1170, 1184, 1187,
			 1204, 1190, 1180, 1209, 1198, 1189, 1199, 1209, 1193, 1214,
			 1197, 1220, 1231, 1215, 1226, 1225, 1228, 1229, 1237, 1249,
			 1248, 1251, 1246, 1256, 1263, 1254, 1264, 1265, 1267, 1273,
			 1274, 1270, 1266, 1272,    0, 2719, 2719, 2719,  621,  803,
			 1336,  978, 2719, 2719, 2719, 2719, 2719, 1328, 2719, 2719,
			 2719, 2719, 2719, 2719, 2719, 2719, 2719, 2719, 2719, 2719,
			 2719, 2719, 2719, 2719, 1331,  895, 1339,  979, 1345, 1353,

			 1359, 1362, 1365, 1371, 1385,   99, 1391, 1394, 1340, 1274,
			 1380, 1283, 1362, 1328, 1363, 1337, 1388, 1347, 1386, 1389,
			 1391, 1388, 1404, 1405, 1405, 1408, 1410, 1399, 1409, 1411,
			 1415, 1412, 1439, 1445, 1420, 1417, 1446, 1418, 1452, 1432,
			 1449, 1438, 1462, 1467,    0, 1468, 1465, 1466, 1468, 1454,
			 1470, 1457, 1479, 1464, 1507, 1478, 1509, 1480, 1490,    0,
			 1510, 1488, 1492,    0, 1516, 1505, 1512,    0, 1514, 1525,
			 1515, 1528, 1532, 1533, 1534, 1522, 1533, 1532, 1538, 1547,
			 1555, 1549, 1541, 1551, 1556, 1555, 1580, 1579, 1582, 1567,
			 1583, 1570, 1578,    0, 1589,    0, 1595, 1596, 1601, 1582,

			 1597, 1593, 1619, 1606, 1602,    0, 1607,    0, 1665,  136,
			 1657, 1633, 1673, 1676, 1679, 1682, 1686, 1689, 1693, 1696,
			 1699, 1706, 1620,    0, 1636,    0, 1688, 1649, 1692,    0,
			 1694,    0, 1697, 1689, 1703, 1704, 1705, 1697, 1709,    0,
			 1712, 1702, 1716, 1717, 1722, 1721, 1752, 1724, 1755, 1722,
			 1756, 1734, 1740,    0, 1758, 1748, 1759, 1755, 1773, 1766,
			 1763, 1768, 1770,    0, 1774, 1775, 1782, 1783, 1778, 1780,
			 1781,    0, 1815, 1789, 1816, 1777, 1804, 1782, 1803, 1820,
			 1826, 1825, 1827, 1828, 1828, 1821, 1838, 1835, 1833, 1821,
			 1839,    0, 1850, 1829, 1849, 1850, 1845,    0, 1846, 1867,

			 1879, 1872, 1880,    0, 1883, 1879, 1916, 2719, 1907, 1911,
			 1918, 1901, 1921, 1925, 1941, 1947, 1951, 1954, 1968, 1958,
			 1913,    0, 1944, 1907, 1927, 1956,    0, 1922, 1957, 1929,
			 1965, 1962, 1963,    0, 1964,    0, 1970, 1971, 1969,    0,
			 1979, 1982, 1981, 1979, 1978,    0, 1982, 1970, 2015, 1979,
			 2008, 1974, 2018, 1980, 2030, 2012, 2021, 1994, 2025, 2016,
			 2027,    0, 2028, 2026, 2034, 2033, 2041,    0, 2046, 2047,
			 2044,    0, 2045,    0, 2048,    0, 2068, 2038, 2082, 2051,
			 2069,    0, 2072, 2073, 2106, 2109, 2112, 2125, 2140, 2143,
			 2146, 2110, 2150, 2156, 2159, 2719, 2162, 2170, 2085,    0,

			 2151, 2131, 2137,    0, 2162, 2154, 2164, 2165, 2163, 2158,
			 2167,    0, 2170,    0, 2173, 2174, 2174,    0, 2175,    0,
			 2177, 2171, 2201, 2182, 2179, 2174, 2219, 2190, 2222, 2206,
			 2213,    0, 2224, 2225, 2227, 2229, 2226,    0,   84, 2251,
			 2254, 2257, 2277, 2280, 2288,   76, 2294, 2297, 2301, 2243,
			    0, 2267,    0, 2269,    0, 2270,    0, 2274,    0, 2283,
			 2276, 2288,    0, 2289, 2283, 2293,    0, 2300, 2299, 2297,
			    0, 2303,    0, 2324,   57, 2327, 2353, 2356, 2313,    0,
			 2317,    0, 2318,    0, 2359, 2719, 2418, 2438, 2458, 2478,
			 2498, 2518, 2378, 2538, 2558, 2578, 2598, 2618, 2638, 2389,

			 2658, 2678, 2698, yy_Dummy>>)
		end

	yy_def_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,  785,    1,  786,  786,  785,  785,  785,  785,  785,
			  785,  785,  787,  788,  785,  789,  790,  785,  785,  785,
			  785,  785,  785,  785,  785,  785,  785,  785,  785,  785,
			  785,  785,  785,  785,  785,  785,   35,   35,   35,   35,
			   35,   35,   35,   35,   35,   35,   35,   35,   35,   35,
			   35,   35,   35,  785,  785,  785,  785,  785,  791,  792,
			  792,  792,  792,  792,  792,  792,  792,  792,  792,  792,
			  792,  792,  792,  792,  792,  792,  792,  792,  785,  785,
			  793,  785,  785,  793,  785,  794,  795,  785,  785,  785,
			  785,  785,  787,  785,  796,  787,  787,  788,  789,  797,

			  797,  797,  785,  785,  785,  785,  785,  785,  798,  785,
			  785,  785,  799,  785,  785,  785,  785,  785,  785,  785,
			   35,   35,   35,   35,   35,  792,  792,  792,  792,  792,
			   35,  792,   35,   35,   35,   35,   35,  792,  792,  792,
			  792,  792,   35,   35,  792,  792,   35,   35,   35,  792,
			  792,  792,   35,   35,   35,  792,  792,  792,   35,   35,
			   35,   35,  792,  792,  792,  792,   35,   35,  792,  792,
			   35,  792,   35,   35,   35,   35,  792,  792,  792,  792,
			   35,  792,   35,  792,   35,   35,  792,  792,   35,   35,
			  792,  792,   35,  792,   35,   35,  792,  792,   35,  792,

			   35,  792,  785,  785,  791,  793,  785,  785,  800,  801,
			  785,  793,  794,  795,  785,  793,  793,  796,  789,  789,
			  796,  796,  787,  787,  785,  785,  785,  785,  785,  785,
			  785,  785,  785,  785,  785,  785,  785,  785,  785,  785,
			  785,  785,  785,  785,  785,  785,  785,  785,  785,  785,
			  785,  785,  785,  785,  785,  785,  799,  785,  785,   35,
			  792,   35,   35,  792,  792,   35,  792,   35,  792,   35,
			  792,   35,  792,   35,  792,   35,  792,   35,  792,   35,
			  792,   35,   35,  792,  792,   35,  792,   35,   35,  792,
			  792,   35,   35,  792,  792,   35,  792,   35,  792,   35,

			  792,   35,  792,   35,   35,   35,   35,   35,  792,  792,
			  792,  792,  792,   35,  792,   35,   35,  792,  792,   35,
			  792,   35,  792,   35,  792,   35,  792,   35,  792,   35,
			   35,   35,   35,   35,   35,  792,  792,  792,  792,  792,
			  792,   35,   35,  792,  792,   35,  792,   35,  792,   35,
			  792,   35,   35,   35,  792,  792,  792,   35,  792,   35,
			  792,   35,  792,   35,  792,  785,  785,  785,  796,  796,
			  796,  796,  785,  785,  785,  785,  785,  785,  785,  785,
			  785,  785,  785,  785,  785,  785,  785,  785,  785,  785,
			  785,  785,  785,  785,  785,  785,  785,  785,  785,  785,

			  785,  785,  785,  785,  785,  799,  785,  785,   35,  792,
			   35,  792,   35,  792,   35,  792,   35,  792,   35,  792,
			   35,  792,   35,  792,   35,  792,   35,  792,   35,  792,
			   35,  792,   35,   35,  792,  792,   35,  792,   35,  792,
			   35,  792,   35,   35,  792,  792,   35,  792,   35,  792,
			   35,  792,   35,  792,   35,  792,   35,  792,   35,  792,
			   35,  792,   35,  792,   35,  792,   35,  792,   35,   35,
			  792,  792,   35,  792,   35,  792,   35,  792,   35,  792,
			   35,   35,  792,  792,   35,  792,   35,  792,   35,  792,
			   35,  792,   35,  792,   35,  792,   35,  792,   35,  792,

			   35,  792,   35,  792,   35,  792,   35,  792,  796,  785,
			  785,  785,  785,  785,  785,  785,  785,  785,  785,  785,
			  798,  785,   35,  792,   35,  792,   35,  792,   35,  792,
			   35,  792,   35,  792,   35,  792,   35,  792,   35,  792,
			   35,  792,   35,  792,   35,  792,   35,  792,   35,  792,
			   35,  792,   35,  792,   35,  792,   35,  792,   35,  792,
			   35,  792,   35,  792,   35,  792,   35,  792,   35,  792,
			   35,  792,   35,  792,   35,  792,   35,  792,   35,  792,
			   35,  792,   35,  792,   35,  792,   35,  792,   35,  792,
			   35,  792,   35,  792,   35,  792,   35,  792,   35,  792,

			   35,  792,   35,  792,   35,  792,  796,  785,  785,  785,
			  785,  785,  785,  785,  785,  785,  785,  785,  785,  802,
			   35,  792,   35,  792,   35,   35,  792,  792,   35,  792,
			   35,  792,   35,  792,   35,  792,   35,  792,   35,  792,
			   35,  792,   35,  792,   35,  792,   35,  792,   35,  792,
			   35,  792,   35,  792,   35,  792,   35,  792,   35,  792,
			   35,  792,   35,  792,   35,  792,   35,  792,   35,  792,
			   35,  792,   35,  792,   35,  792,   35,  792,   35,  792,
			   35,  792,   35,  792,  785,  785,  785,  785,  785,  785,
			  785,  785,  785,  785,  785,  785,  785,  785,   35,  792,

			   35,  792,   35,  792,   35,  792,   35,  792,   35,  792,
			   35,  792,   35,  792,   35,  792,   35,  792,   35,  792,
			   35,  792,   35,  792,   35,  792,   35,  792,   35,  792,
			   35,  792,   35,  792,   35,  792,   35,  792,  785,  785,
			  785,  785,  785,  785,  785,  785,  785,  785,  785,   35,
			  792,   35,  792,   35,  792,   35,  792,   35,  792,   35,
			  792,   35,  792,   35,  792,   35,  792,   35,  792,   35,
			  792,   35,  792,  785,  785,  785,  785,  785,   35,  792,
			   35,  792,   35,  792,  785,    0,  785,  785,  785,  785,
			  785,  785,  785,  785,  785,  785,  785,  785,  785,  785,

			  785,  785,  785, yy_Dummy>>)
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

			  559,  560,  562,  563,  565,  567,  569,  571,  573,  574,
			  575,  576,  577,  578,  580,  581,  583,  585,  586,  587,
			  590,  592,  594,  595,  598,  600,  602,  603,  605,  606,
			  608,  610,  612,  614,  616,  618,  619,  620,  621,  622,
			  623,  624,  626,  628,  629,  630,  632,  633,  635,  636,
			  638,  639,  641,  643,  645,  646,  647,  648,  650,  651,
			  653,  654,  656,  657,  660,  662,  663,  664,  665,  666,
			  667,  667,  668,  669,  670,  671,  672,  673,  674,  675,
			  676,  677,  678,  679,  680,  681,  682,  683,  684,  685,
			  686,  687,  688,  689,  690,  692,  692,  694,  694,  696,

			  696,  696,  696,  698,  700,  702,  702,  704,  706,  708,
			  709,  711,  712,  714,  715,  717,  718,  720,  721,  723,
			  724,  726,  727,  729,  730,  732,  733,  735,  736,  739,
			  741,  743,  744,  746,  748,  749,  750,  752,  753,  755,
			  756,  758,  759,  762,  764,  766,  767,  769,  770,  772,
			  773,  775,  776,  778,  779,  781,  782,  784,  785,  788,
			  790,  792,  793,  796,  798,  800,  801,  804,  806,  808,
			  810,  811,  812,  814,  815,  817,  818,  820,  821,  823,
			  824,  826,  828,  829,  830,  832,  833,  835,  836,  838,
			  839,  841,  842,  845,  847,  850,  852,  854,  855,  857,

			  858,  860,  861,  863,  864,  867,  869,  872,  874,  874,
			  875,  876,  878,  878,  878,  880,  880,  884,  884,  886,
			  886,  886,  888,  891,  893,  896,  898,  900,  901,  904,
			  906,  909,  911,  913,  914,  916,  917,  919,  920,  923,
			  925,  927,  928,  930,  931,  933,  934,  936,  937,  939,
			  940,  942,  943,  946,  948,  950,  951,  953,  954,  956,
			  957,  959,  960,  963,  965,  967,  968,  970,  971,  973,
			  974,  977,  979,  981,  982,  984,  985,  987,  988,  990,
			  991,  993,  994,  996,  997,  999, 1000, 1002, 1003, 1005,
			 1006, 1009, 1011, 1013, 1014, 1016, 1017, 1020, 1022, 1024,

			 1025, 1027, 1028, 1031, 1033, 1035, 1036, 1036, 1037, 1037,
			 1039, 1039, 1040, 1041, 1045, 1045, 1045, 1047, 1047, 1048,
			 1048, 1051, 1053, 1055, 1056, 1059, 1061, 1063, 1064, 1066,
			 1067, 1069, 1070, 1073, 1075, 1078, 1080, 1082, 1083, 1086,
			 1088, 1090, 1091, 1093, 1094, 1097, 1099, 1101, 1102, 1104,
			 1105, 1107, 1108, 1110, 1111, 1113, 1114, 1116, 1117, 1119,
			 1120, 1123, 1125, 1127, 1128, 1130, 1131, 1134, 1136, 1138,
			 1139, 1142, 1144, 1147, 1149, 1152, 1154, 1156, 1157, 1159,
			 1160, 1163, 1165, 1167, 1168, 1168, 1169, 1169, 1169, 1169,
			 1173, 1173, 1174, 1175, 1175, 1175, 1176, 1177, 1178, 1181,

			 1183, 1185, 1186, 1189, 1191, 1193, 1194, 1196, 1197, 1199,
			 1200, 1203, 1205, 1208, 1210, 1212, 1213, 1216, 1218, 1221,
			 1223, 1225, 1226, 1228, 1229, 1231, 1232, 1234, 1235, 1237,
			 1238, 1241, 1243, 1245, 1246, 1248, 1249, 1252, 1254, 1255,
			 1255, 1256, 1256, 1258, 1258, 1258, 1259, 1260, 1260, 1261,
			 1264, 1266, 1269, 1271, 1274, 1276, 1279, 1281, 1284, 1286,
			 1288, 1289, 1292, 1294, 1296, 1297, 1300, 1302, 1304, 1305,
			 1308, 1310, 1313, 1315, 1316, 1318, 1318, 1320, 1321, 1324,
			 1326, 1329, 1331, 1334, 1336, 1338, 1338, yy_Dummy>>)
		end

	yy_acclist_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,  138,  138,  154,  152,  153,    3,  152,  153,    4,
			  153,    1,  152,  153,    2,  152,  153,   10,  152,  153,
			  140,  152,  153,  104,  152,  153,   17,  152,  153,  140,
			  152,  153,  152,  153,   11,  152,  153,   12,  152,  153,
			   31,  152,  153,   30,  152,  153,    8,  152,  153,   29,
			  152,  153,    6,  152,  153,   32,  152,  153,  142,  144,
			  152,  153,  142,  144,  152,  153,  142,  144,  152,  153,
			    9,  152,  153,    7,  152,  153,   36,  152,  153,   34,
			  152,  153,   35,  152,  153,  152,  153,  102,  103,  152,
			  153,  102,  103,  152,  153,  102,  103,  152,  153,  102,

			  103,  152,  153,  102,  103,  152,  153,  102,  103,  152,
			  153,  102,  103,  152,  153,  102,  103,  152,  153,  102,
			  103,  152,  153,  102,  103,  152,  153,  102,  103,  152,
			  153,  102,  103,  152,  153,  102,  103,  152,  153,  102,
			  103,  152,  153,  102,  103,  152,  153,  102,  103,  152,
			  153,  102,  103,  152,  153,  102,  103,  152,  153,  102,
			  103,  152,  153,   15,  152,  153,  152,  153,   16,  152,
			  153,   33,  152,  153,  144,  152,  153,  152,  153,  103,
			  152,  153,  103,  152,  153,  103,  152,  153,  103,  152,
			  153,  103,  152,  153,  103,  152,  153,  103,  152,  153,

			  103,  152,  153,  103,  152,  153,  103,  152,  153,  103,
			  152,  153,  103,  152,  153,  103,  152,  153,  103,  152,
			  153,  103,  152,  153,  103,  152,  153,  103,  152,  153,
			  103,  152,  153,  103,  152,  153,   13,  152,  153,   14,
			  152,  153,  138,  153,  136,  153,  137,  153,  132,  138,
			  153,  135,  153,  138,  153,  138,  153,    3,    4,    1,
			    2,   37,  140,  139,  139, -130,  140, -283, -131,  140,
			 -284,  104,  140,  128,  128,  128,    5,   23,   24,  147,
			  150,   18,   20,  142,  144,  142,  144,  141,  144,   28,
			   25,   22,   21,   26,   27,  102,  103,  102,  103,  102,

			  103,  102,  103,   42,  102,  103,  103,  103,  103,  103,
			   42,  103,  102,  103,  103,  102,  103,  102,  103,  102,
			  103,  102,  103,  102,  103,  103,  103,  103,  103,  103,
			  102,  103,   53,  102,  103,  103,   53,  103,  102,  103,
			  102,  103,  102,  103,  103,  103,  103,  102,  103,  102,
			  103,  102,  103,  103,  103,  103,   65,  102,  103,  102,
			  103,  102,  103,   72,  102,  103,   65,  103,  103,  103,
			   72,  103,  102,  103,  102,  103,  103,  103,  102,  103,
			  103,  102,  103,  102,  103,  102,  103,   80,  102,  103,
			  103,  103,  103,   80,  103,  102,  103,  103,  102,  103,

			  103,  102,  103,  102,  103,  103,  103,  102,  103,  102,
			  103,  103,  103,  102,  103,  103,  102,  103,  102,  103,
			  103,  103,  102,  103,  103,  102,  103,  103,   19,  144,
			  138,  136,  137,  132,  138,  138,  138,  135,  133,  138,
			  134,  138,  139,  140,  139,  140, -130,  140, -131,  140,
			  128,  105,  128,  128,  128,  128,  128,  128,  128,  128,
			  128,  128,  128,  128,  128,  128,  128,  128,  128,  128,
			  128,  128,  128,  128,  128,  147,  150,  145,  147,  150,
			  145,  142,  144,  142,  144,  143,  142,  144,  144,  102,
			  103,  103,  102,  103,   40,  102,  103,  103,   40,  103,

			   41,  102,  103,   41,  103,  102,  103,  103,   44,  102,
			  103,   44,  103,  102,  103,  103,  102,  103,  103,  102,
			  103,  103,  102,  103,  103,  102,  103,  103,  102,  103,
			  102,  103,  103,  103,  102,  103,  103,   56,  102,  103,
			  102,  103,   56,  103,  103,  102,  103,  102,  103,  103,
			  103,  102,  103,  103,  102,  103,  103,  102,  103,  103,
			  102,  103,  103,  102,  103,  102,  103,  102,  103,  102,
			  103,  102,  103,  103,  103,  103,  103,  103,  102,  103,
			  103,  102,  103,  102,  103,  103,  103,   76,  102,  103,
			   76,  103,  102,  103,  103,   78,  102,  103,   78,  103,

			  102,  103,  103,  102,  103,  103,  102,  103,  102,  103,
			  102,  103,  102,  103,  102,  103,  102,  103,  103,  103,
			  103,  103,  103,  103,  102,  103,  102,  103,  103,  103,
			  102,  103,  103,  102,  103,  103,  102,  103,  103,  102,
			  103,  102,  103,  102,  103,  103,  103,  103,  102,  103,
			  103,  102,  103,  103,  102,  103,  103,  101,  102,  103,
			  101,  103,  151,  133,  134,  139,  139,  139,  122,  120,
			  121,  123,  124,  129,  125,  126,  106,  107,  108,  109,
			  110,  111,  112,  113,  114,  115,  116,  117,  118,  119,
			  147,  150,  147,  150,  147,  150,  146,  149,  142,  144,

			  142,  144,  142,  144,  142,  144,  102,  103,  103,  102,
			  103,  103,  102,  103,  103,  102,  103,  103,  102,  103,
			  103,  102,  103,  103,  102,  103,  103,  102,  103,  103,
			  102,  103,  103,  102,  103,  103,   54,  102,  103,   54,
			  103,  102,  103,  103,  102,  103,  102,  103,  103,  103,
			  102,  103,  103,  102,  103,  103,  102,  103,  103,   63,
			  102,  103,  102,  103,   63,  103,  103,  102,  103,  103,
			  102,  103,  103,  102,  103,  103,  102,  103,  103,  102,
			  103,  103,  102,  103,  103,   73,  102,  103,   73,  103,
			  102,  103,  103,   75,  102,  103,   75,  103,  102,  103,

			  103,   79,  102,  103,   79,  103,  102,  103,  102,  103,
			  103,  103,  102,  103,  103,  102,  103,  103,  102,  103,
			  103,  102,  103,  103,  102,  103,  102,  103,  103,  103,
			  102,  103,  103,  102,  103,  103,  102,  103,  103,  102,
			  103,  103,   93,  102,  103,   93,  103,   94,  102,  103,
			   94,  103,  102,  103,  103,  102,  103,  103,  102,  103,
			  103,  102,  103,  103,   99,  102,  103,   99,  103,  100,
			  102,  103,  100,  103,  129,  147,  147,  150,  147,  150,
			  146,  147,  149,  150,  146,  149,  142,  144,   38,  102,
			  103,   38,  103,   39,  102,  103,   39,  103,  102,  103,

			  103,   45,  102,  103,   45,  103,   46,  102,  103,   46,
			  103,  102,  103,  103,  102,  103,  103,  102,  103,  103,
			   51,  102,  103,   51,  103,  102,  103,  103,  102,  103,
			  103,  102,  103,  103,  102,  103,  103,  102,  103,  103,
			  102,  103,  103,   61,  102,  103,   61,  103,  102,  103,
			  103,  102,  103,  103,  102,  103,  103,  102,  103,  103,
			   68,  102,  103,   68,  103,  102,  103,  103,  102,  103,
			  103,  102,  103,  103,   74,  102,  103,   74,  103,  102,
			  103,  103,  102,  103,  103,  102,  103,  103,  102,  103,
			  103,  102,  103,  103,  102,  103,  103,  102,  103,  103,

			  102,  103,  103,  102,  103,  103,   89,  102,  103,   89,
			  103,  102,  103,  103,  102,  103,  103,   92,  102,  103,
			   92,  103,  102,  103,  103,  102,  103,  103,   97,  102,
			  103,   97,  103,  102,  103,  103,  127,  147,  150,  150,
			  147,  146,  147,  149,  150,  146,  149,  145,   43,  102,
			  103,   43,  103,  102,  103,  103,   48,  102,  103,  102,
			  103,   48,  103,  103,  102,  103,  103,  102,  103,  103,
			   55,  102,  103,   55,  103,   57,  102,  103,   57,  103,
			  102,  103,  103,   59,  102,  103,   59,  103,  102,  103,
			  103,  102,  103,  103,   64,  102,  103,   64,  103,  102,

			  103,  103,  102,  103,  103,  102,  103,  103,  102,  103,
			  103,  102,  103,  103,  102,  103,  103,  102,  103,  103,
			   82,  102,  103,   82,  103,  102,  103,  103,  102,  103,
			  103,   85,  102,  103,   85,  103,  102,  103,  103,   87,
			  102,  103,   87,  103,   88,  102,  103,   88,  103,   90,
			  102,  103,   90,  103,  102,  103,  103,  102,  103,  103,
			   96,  102,  103,   96,  103,  102,  103,  103,  147,  146,
			  147,  149,  150,  150,  146,  148,  150,  148,   47,  102,
			  103,   47,  103,  102,  103,  103,   50,  102,  103,   50,
			  103,  102,  103,  103,  102,  103,  103,  102,  103,  103,

			   62,  102,  103,   62,  103,   66,  102,  103,   66,  103,
			  102,  103,  103,   69,  102,  103,   69,  103,   70,  102,
			  103,   70,  103,  102,  103,  103,  102,  103,  103,  102,
			  103,  103,  102,  103,  103,  102,  103,  103,   86,  102,
			  103,   86,  103,  102,  103,  103,  102,  103,  103,   98,
			  102,  103,   98,  103,  150,  150,  146,  147,  149,  150,
			  149,   49,  102,  103,   49,  103,   52,  102,  103,   52,
			  103,   58,  102,  103,   58,  103,   60,  102,  103,   60,
			  103,   67,  102,  103,   67,  103,  102,  103,  103,   77,
			  102,  103,   77,  103,  102,  103,  103,   84,  102,  103,

			   84,  103,  102,  103,  103,   91,  102,  103,   91,  103,
			   95,  102,  103,   95,  103,  150,  149,  150,  149,  150,
			  149,   71,  102,  103,   71,  103,   81,  102,  103,   81,
			  103,   83,  102,  103,   83,  103,  149,  150, yy_Dummy>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER is 2719
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER is 785
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER is 786
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


indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- EDITOR_EIFFEL_SCANNER
