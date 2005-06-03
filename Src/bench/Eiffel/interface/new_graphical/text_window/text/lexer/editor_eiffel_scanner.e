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

					-- Verbatim string opener.				
				create {EDITOR_TOKEN_STRING} curr_token.make(text)
				update_token_list
				in_verbatim_string := True
			
when 127 then
--|#line 348 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 348")
end

					-- Verbatim string closer, possibly.				
				create {EDITOR_TOKEN_STRING} curr_token.make(text)
				update_token_list	
				in_verbatim_string := False				
			
when 128 then
--|#line 355 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 355")
end

					-- Verbatim string closer, possibly.				
				create {EDITOR_TOKEN_STRING} curr_token.make(text)
				update_token_list
				in_verbatim_string := False

when 129, 130 then
--|#line 363 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 363")
end

					-- Eiffel String
					if not in_comments then						
						create {EDITOR_TOKEN_STRING} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
when 131 then
--|#line 376 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 376")
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
					
when 132, 133, 134, 135 then
--|#line 393 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 393")
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
						
when 136 then
--|#line 410 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 410")
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
						
when 137 then
	yy_end := yy_end - 1
--|#line 427 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 427")
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
						
when 138, 139 then
--|#line 428 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 428")
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
--|#line 452 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 452")
end

					create {EDITOR_TOKEN_TEXT} curr_token.make(text)
					update_token_list
					
when 144 then
--|#line 460 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 460")
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
				
when 145 then
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
			  575,   79,   79,   79,  486,   83,   79,   79,   87,   79,

			   84,   88,   87,   94,   95,   88,   96,   98,  100,   99,
			   99,   99,  109,  110,  479,  101,   97,  111,  112,  102,
			  568,  103,  103,  104,  102,  136,  103,  103,  104,  114,
			  102,  105,  104,  104,  104,  137,  105,  114,  176,  379,
			  125,  146,  114,  379,   80,  147,   89,  379,   80,  114,
			  114,  366,   80,  106,  198,  198,  198,  138,  148,  174,
			  107,  119,  365,  105,  364,  107,  363,  139,  105,  119,
			  177,  107,  125,  149,  119,   81,  362,  150,   90,   81,
			  361,  119,  119,   81,  360,  106,  114,  114,  114,  114,
			  151,  175,  165,  198,  186,  114,  114,  114,  114,  114,

			  114,  115,  114,  114,  114,  114,  116,  114,  117,  114,
			  114,  114,  114,  118,  114,  114,  114,  114,  114,  114,
			  114,  119,  359,  358,  165,  114,  187,  119,  119,  119,
			  119,  119,  119,  120,  119,  119,  119,  119,  121,  119,
			  122,  119,  119,  119,  119,  123,  119,  119,  119,  119,
			  119,  119,  119,  114,  114,  114,  192,  114,  175,  177,
			  357,  187,  114,  114,  114,  114,  114,  114,  114,  114,
			  124,  114,  114,  114,  114,  114,  114,  114,  114,  114,
			  114,  114,  114,  114,  114,  114,  114,  114,  193,  119,
			  175,  177,  114,  187,  119,  119,  119,  119,  119,  119,

			  119,  119,  125,  119,  119,  119,  119,  119,  119,  119,
			  119,  119,  119,  119,  119,  119,  119,  119,  119,  119,
			  126,  114,  356,  114,  127,  160,  140,  128,  141,  152,
			  129,  161,  114,  130,  114,  193,  153,  154,  142,  355,
			  164,   87,  155,   87,   88,  354,  341,   78,  114,   79,
			   79,  353,  131,  119,  194,  119,  132,  162,  143,  133,
			  144,  156,  134,  163,  119,  135,  119,  193,  157,  158,
			  145,  166,  165,  178,  159,  182,  114,  114,  114,  138,
			  119,  167,  188,  168,  195,  183,  195,  169,  179,  139,
			  114,  352,  120,  351,  162,   87,  189,  121,   88,  122,

			  163,  349,   80,  170,  123,  180,  348,  184,  119,  119,
			  119,  138,  180,  171,  190,  172,  195,  185,  347,  173,
			  181,  139,  119,  143,  120,  144,  162,  181,  191,  121,
			  131,  122,  163,   81,  132,  145,  123,  133,  170,  156,
			  134,  149,  190,  135,  180,  150,  157,  158,  171,  114,
			  172,  184,  159,  114,  173,  143,  191,  144,  151,  181,
			   87,  185,  131,   88,  346,  342,  132,  145,   88,  133,
			  170,  156,  134,  149,  190,  135,  345,  150,  157,  158,
			  171,  119,  172,  184,  159,  119,  173,  340,  191,   79,
			  151,   79,   79,  185,   79,  209,   83,   79,   79,   82,

			   79,   84,  206,   87,  206,  206,  344,   87,   89,  207,
			   88,  207,  207,  200,   87,  197,  243,   88,  232,  232,
			  232,  236,  236,  236,  102,  200,  238,  238,  239,  342,
			   87,  233,  341,  341,  237,  102,  105,  239,  239,  239,
			   90,  242,  247,  197,   80,  114,  245,  244,  243,   80,
			  245,  114,  196,   80,  123,   89,  113,  234,  108,  241,
			  241,  241,   89,  233,  246,  107,  237,  247,  105,  249,
			  114,   85,  251,  243,  247,   81,  107,  119,  247,  246,
			   81,  118,  247,  119,   81,  202,  123,   90,  203,   92,
			   92,   92,  342,   82,   90,  341,  246,  204,  198,  247,

			  742,  249,  119,   92,  251,   92,  248,   92,   92,  205,
			  114,  114,   92,  123,   92,  742,  252,   92,   92,   87,
			   92,  742,  341,   92,   92,   92,   92,   92,   92,  210,
			  742,   92,  211,  212,  213,  214,  742,  742,  249,  742,
			  742,  215,  119,  119,  253,  255,  254,  216,  253,  217,
			  114,  218,  219,  220,  221,  250,  222,  114,  223,  257,
			  114,  260,  224,  114,  225,  261,  256,  226,  227,  228,
			  229,  230,  231,  742,  114,  264,  253,  255,  255,  258,
			  114,  263,  119,  259,  262,  266,  114,  251,  742,  119,
			  265,  257,  119,  260,  114,  119,  274,  261,  257,  270,

			  267,  268,  114,  271,  114,  269,  119,  266,  276,  273,
			  275,  260,  119,  263,  277,  261,  263,  266,  119,  114,
			  114,  114,  267,  272,  279,  742,  119,  114,  275,  288,
			  289,  270,  267,  270,  119,  271,  119,  271,  114,  280,
			  277,  273,  275,  281,  114,  278,  277,  114,  742,  742,
			  295,  119,  119,  119,  282,  273,  279,  283,  294,  119,
			  290,  289,  289,  284,  114,  114,  114,  285,  292,  297,
			  119,  284,  291,  299,  296,  285,  119,  279,  286,  119,
			  293,  287,  295,  298,  301,  300,  286,  303,  114,  287,
			  295,  114,  292,  742,  321,  284,  119,  119,  119,  285,

			  292,  297,  114,  302,  293,  299,  297,  114,  742,  742,
			  286,  742,  293,  287,  324,  299,  301,  301,  742,  303,
			  119,  742,  114,  119,  742,  316,  321,  114,  310,  317,
			  311,  323,  325,  318,  119,  303,  320,  319,  312,  119,
			  304,  313,  305,  314,  315,  114,  325,  322,  334,  742,
			  306,  114,  742,  307,  119,  308,  309,  318,  114,  119,
			  310,  319,  311,  323,  325,  318,  333,  332,  321,  319,
			  312,  335,  310,  313,  311,  314,  315,  119,  337,  323,
			  335,  326,  312,  119,  329,  313,  327,  314,  315,  330,
			  119,  336,  114,  339,  382,  114,  114,  328,  333,  333,

			  331,  338,  742,  335,  198,  198,  198,  742,  742,  206,
			  337,  206,  206,  329,   87,  742,  329,   88,  330,  742,
			  742,  330,  742,  337,  119,  339,  382,  119,  119,  331,
			  742,   87,  331,  339,  341,  350,  350,  350,  367,  367,
			  367,  384,  742,  198,  343,  343,  343,  207,  742,  207,
			  207,  233,   87,  386,  368,   88,  368,  742,  742,  369,
			  369,  369,   89,  370,  370,  370,  371,  371,  371,  374,
			  742,  374,  388,  384,  375,  375,  375,  234,  102,  372,
			  376,  376,  377,  233,  102,  386,  377,  377,  377,  383,
			  105,  380,  380,  380,   90,  390,  114,  114,  742,  114,

			   89,  381,  385,  114,  388,  373,  391,  392,  114,  387,
			  394,  372,  396,  398,  114,  114,  389,  742,  742,  107,
			  400,  384,  105,  742,  393,  107,  114,  390,  119,  119,
			  198,  119,   90,  382,  386,  119,  402,  114,  392,  392,
			  119,  388,  394,  408,  396,  398,  119,  119,  390,  395,
			  397,  399,  400,  114,  114,  114,  394,  407,  119,  403,
			  405,  114,  114,  410,  412,  401,  114,  114,  402,  119,
			  418,  742,  409,  404,  406,  408,  114,  411,  742,  417,
			  420,  396,  398,  400,  114,  119,  119,  119,  413,  408,
			  415,  405,  405,  119,  119,  410,  412,  402,  119,  119,

			  114,  414,  418,  416,  410,  406,  406,  423,  119,  412,
			  419,  418,  420,  421,  114,  425,  119,  114,  422,  424,
			  415,  426,  415,  114,  427,  428,  429,  430,  114,  114,
			  432,  114,  119,  416,  114,  416,  431,  114,  434,  424,
			  114,  436,  420,  433,  435,  422,  119,  426,  114,  119,
			  422,  424,  438,  426,  742,  119,  428,  428,  430,  430,
			  119,  119,  432,  119,  440,  437,  119,  442,  432,  119,
			  434,  114,  119,  436,  439,  434,  436,  441,  114,  443,
			  119,  114,  114,  447,  438,  444,  114,  114,  446,  114,
			  449,  452,  455,  454,  445,  451,  440,  438,  453,  442,

			  114,  448,  114,  119,  456,  457,  440,  458,  450,  442,
			  119,  444,  460,  119,  119,  449,  462,  444,  119,  119,
			  446,  119,  449,  452,  456,  454,  446,  452,  467,  464,
			  454,  461,  119,  450,  119,  114,  456,  458,  114,  458,
			  450,  463,  114,  459,  460,  114,  466,  468,  462,  469,
			  465,  470,  471,  472,  114,  474,  114,  114,  742,  473,
			  468,  464,  742,  462,  369,  369,  369,  119,  742,  490,
			  119,  742,  742,  464,  119,  460,  742,  119,  466,  468,
			  742,  470,  466,  470,  472,  472,  119,  474,  119,  119,
			   87,  474,  742,  341,  476,  350,  350,  350,  477,  477,

			  477,  490,   92,  475,  475,  475,  478,  478,  478,  492,
			  494,  233,  480,  480,  480,  481,  481,  481,  482,  742,
			  482,  742,  742,  483,  483,  483,  742,  742,  372,  484,
			  484,  484,  375,  375,  375,  496,  742,  234,  485,  485,
			  485,  492,  494,  233,  487,  479,  376,  376,  377,  487,
			  114,  377,  377,  377,  373,  114,  105,  488,  488,  488,
			  372,  489,  114,  498,  742,  491,  114,  496,  493,  497,
			  114,  500,  495,  114,  501,  502,  504,  486,  114,  506,
			  114,  499,  119,  507,  503,  198,  114,  119,  105,  505,
			  198,  508,  510,  490,  119,  498,  198,  492,  119,  512,

			  494,  498,  119,  500,  496,  119,  502,  502,  504,  114,
			  119,  506,  119,  500,  511,  508,  504,  114,  119,  114,
			  514,  506,  516,  508,  510,  114,  509,  518,  513,  517,
			  114,  512,  520,  114,  515,  114,  521,  522,  523,  524,
			  114,  119,  519,  526,  114,  528,  512,  530,  114,  119,
			  742,  119,  514,  527,  516,  532,  114,  119,  510,  518,
			  514,  518,  119,  525,  520,  119,  516,  119,  522,  522,
			  524,  524,  119,  534,  520,  526,  119,  528,  529,  530,
			  119,  114,  114,  114,  114,  528,  533,  532,  119,  114,
			  531,  536,  535,  114,  114,  526,  538,  539,  540,  114,

			  114,  542,  544,  114,  545,  534,  537,  543,  541,  546,
			  530,  548,  550,  119,  119,  119,  119,  742,  534,  552,
			  554,  119,  532,  536,  536,  119,  119,  556,  538,  540,
			  540,  119,  119,  542,  544,  119,  546,  114,  538,  544,
			  542,  546,  114,  548,  550,  549,  114,  553,  114,  547,
			  558,  552,  554,  114,  114,  114,  114,  555,  560,  556,
			  559,  557,  551,  114,  114,  562,  564,  114,  566,  119,
			  563,  114,  114,  114,  119,  565,  561,  550,  119,  554,
			  119,  548,  558,  114,  114,  119,  119,  119,  119,  556,
			  560,  742,  560,  558,  552,  119,  119,  562,  564,  119,

			  566,  742,  564,  119,  119,  119,   87,  566,  562,  341,
			  477,  477,  477,  742,  742,  119,  119,  742,   92,  567,
			  567,  567,  114,  569,  570,  570,  570,  571,  571,  571,
			  572,  572,  572,  573,  573,  573,  483,  483,  483,  114,
			  574,  574,  574,  576,  576,  576,  372,  577,  577,  577,
			  578,  578,  578,  582,  119,  569,  573,  573,  573,  114,
			  588,  114,  580,  479,  198,  198,  198,  114,  581,  579,
			  583,  119,  373,  585,  584,  114,  589,  586,  372,  575,
			  587,  590,  592,  594,  591,  582,  486,  114,  596,  742,
			  593,  119,  588,  119,  114,  598,  600,  742,  114,  119,

			  582,  579,  585,  107,  602,  585,  586,  119,  590,  586,
			  114,  604,  588,  590,  592,  594,  592,  606,  595,  119,
			  596,  597,  594,  114,  114,  114,  119,  598,  600,  599,
			  119,  605,  114,  607,  601,  114,  602,  603,  608,  609,
			  610,  611,  119,  604,  612,  613,  614,  114,  114,  606,
			  596,  616,  618,  598,  615,  119,  119,  119,  114,  114,
			  619,  600,  620,  606,  119,  608,  602,  119,  617,  604,
			  608,  610,  610,  612,  622,  624,  612,  614,  614,  119,
			  119,  621,  626,  616,  618,  114,  616,  114,  628,  623,
			  119,  119,  620,  114,  620,  627,  625,  114,  630,  114,

			  618,  114,  632,  633,  114,  634,  622,  624,  629,  114,
			  635,  114,  636,  622,  626,  631,  638,  119,  637,  119,
			  628,  624,  114,  114,  640,  119,  644,  628,  626,  119,
			  630,  119,  742,  119,  632,  634,  119,  634,  742,  742,
			  630,  119,  636,  119,  636,  656,  114,  632,  638,  742,
			  638,  639,  234,  742,  119,  119,  640,  641,  644,  641,
			  742,  742,  642,  642,  642,  642,  642,  642,  643,  643,
			  643,  573,  573,  573,  646,  646,  646,  656,  119,  647,
			  647,  647,  114,  640,  645,  648,  648,  648,  649,  649,
			  649,  650,  650,  650,  651,  742,  651,  114,  658,  649,

			  649,  649,  660,  114,  479,  653,  653,  653,  655,  657,
			  114,  661,  662,  575,  119,  114,  645,  114,  654,  114,
			  663,  659,  664,  114,  114,  665,  666,  486,  667,  119,
			  658,  668,  114,  114,  660,  119,  114,  670,  114,  672,
			  656,  658,  119,  662,  662,  674,  742,  119,  669,  119,
			  654,  119,  664,  660,  664,  119,  119,  666,  666,  676,
			  668,  114,  114,  668,  119,  119,  671,  114,  119,  670,
			  119,  672,  678,  673,  677,  114,  680,  674,  675,  114,
			  670,  682,  114,  114,  684,  114,  679,  686,  683,  681,
			  685,  676,  114,  119,  119,  688,  687,  114,  672,  119,

			  114,  114,  114,  690,  678,  674,  678,  119,  680,  692,
			  676,  119,  114,  682,  119,  119,  684,  119,  680,  686,
			  684,  682,  686,  689,  119,  114,  114,  688,  688,  119,
			  691,  114,  119,  119,  119,  690,  694,  642,  642,  642,
			  114,  692,  693,  742,  119,  642,  642,  642,  695,  695,
			  695,  699,  699,  699,  696,  690,  696,  119,  119,  697,
			  697,  697,  692,  119,  698,  701,  698,  742,  694,  699,
			  699,  699,  119,  707,  694,  700,  700,  700,  649,  649,
			  649,  702,  702,  702,  649,  649,  649,  703,  703,  703,
			  575,  373,  114,  709,  742,  711,  704,  701,  704,  114,

			  701,  705,  705,  705,  706,  707,  708,  710,  713,  114,
			  114,  114,  114,  712,  114,  714,  715,  114,  114,  114,
			  717,  719,  721,  114,  119,  709,  373,  711,  716,  718,
			  742,  119,  701,  114,  723,  725,  707,  114,  709,  711,
			  713,  119,  119,  119,  119,  713,  119,  715,  715,  119,
			  119,  119,  717,  719,  721,  119,  114,  727,  724,  722,
			  717,  719,  720,  114,  114,  119,  723,  725,  726,  119,
			  728,  729,  114,  114,  114,  697,  697,  697,  730,  730,
			  730,  699,  699,  699,  699,  699,  699,  742,  119,  727,
			  725,  723,  114,  742,  721,  119,  119,  731,  731,  731,

			  727,  114,  729,  729,  119,  119,  119,  732,  114,  732,
			  114,  114,  733,  733,  733,  736,  114,  479,  648,  648,
			  648,  705,  705,  705,  119,  734,  734,  734,  114,  114,
			  738,  701,  742,  119,  114,  740,  114,  739,  737,  735,
			  119,  114,  119,  119,  114,  742,  742,  736,  119,  695,
			  695,  695,  733,  733,  733,  114,  742,  373,  114,  114,
			  119,  119,  738,  701,  486,  742,  119,  740,  119,  740,
			  738,  736,  742,  119,  742,  742,  119,  741,  741,  741,
			  702,  702,  702,  731,  731,  731,   91,  119,  479,  742,
			  119,  119,   91,   91,   91,   91,   91,   91,   91,   91,

			   91,   91,   91,  119,  119,  119,  119,  119,  119,  119,
			  119,  119,  240,  240,  240,  742,  575,  742,  742,  486,
			  742,  742,  575,   86,   86,  742,   86,   86,   86,   86,
			   86,   86,   86,   86,   86,   86,   86,   86,   86,   86,
			   92,   92,  742,   92,   92,   92,   92,   92,   92,   92,
			   92,   92,   92,   92,   92,   92,   92,   93,   93,  742,
			   93,   93,   93,   93,   93,   93,   93,   93,   93,   93,
			   93,   93,   93,   93,   80,   80,  742,   80,   80,  742,
			   80,   80,   80,   80,   80,   80,   80,   80,   80,   80,
			   80,  199,  199,  742,  199,  199,  742,  742,  199,  199,

			  199,  199,  199,  199,  199,  199,  199,  199,   81,   81,
			  742,   81,   81,  742,   81,   81,   81,   81,   81,   81,
			   81,   81,   81,   81,   81,  201,  201,  742,  201,  201,
			  201,  201,  201,  201,  201,  201,  201,  201,  201,  201,
			  201,  201,  208,  208,  742,  208,  208,  208,  208,  208,
			  208,  208,  208,  208,  208,  208,  208,  208,  208,  235,
			  235,  235,  235,  235,  235,  235,  742,  235,  235,  235,
			  235,  235,  235,  235,  235,  235,  378,  378,  378,  742,
			  742,  742,  378,  652,  652,  652,  652,  652,  652,  652,
			  742,  652,  652,  652,  652,  652,  652,  652,  652,  652,

			    3,  742,  742,  742,  742,  742,  742,  742,  742,  742,
			  742,  742,  742,  742,  742,  742,  742,  742,  742,  742,
			  742,  742,  742,  742,  742,  742,  742,  742,  742,  742,
			  742,  742,  742,  742,  742,  742,  742,  742,  742,  742,
			  742,  742,  742,  742,  742,  742,  742,  742,  742,  742,
			  742,  742,  742,  742,  742,  742,  742,  742,  742,  742,
			  742,  742,  742,  742,  742,  742,  742,  742,  742,  742,
			  742,  742,  742,  742,  742,  742,  742,  742,  742,  742,
			  742,  742,  742,  742,  742,  742,  742,  742,  742, yy_Dummy>>)
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
			  731,    5,    5,    7,  702,    7,    7,    8,   10,    8,

			    8,   10,   13,   14,   14,   13,   20,   21,   22,   21,
			   21,   21,   28,   28,  695,   22,   20,   30,   30,   23,
			  476,   23,   23,   23,   24,   35,   24,   24,   24,   35,
			   25,   23,   25,   25,   25,   35,   24,   38,   44,  379,
			   58,   37,   44,  378,    5,   37,   10,  240,    7,   37,
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
			   67,   71,   64,  118,   67,   61,   73,   61,   62,   70,
			   86,   71,   59,   86,  211,  203,   59,   61,  203,   59,
			   67,   64,   59,   62,   73,   59,  210,   62,   64,   64,
			   67,  114,   67,   71,   64,  118,   67,  199,   73,   79,
			   62,   79,   79,   71,   83,   93,   83,   83,   84,   82,

			   84,   84,   89,  205,   89,   89,  205,   89,   86,   90,
			   89,   90,   90,   81,   90,   80,  120,   90,   99,   99,
			   99,  102,  102,  102,  103,   77,  103,  103,  103,  341,
			  342,   99,  341,  342,  102,  104,  103,  104,  104,  104,
			   86,  115,  122,   53,   79,  115,  117,  116,  120,   83,
			  116,  117,   52,   84,  125,   89,   31,   99,   26,  107,
			  107,  107,   90,   99,  121,  103,  102,  121,  103,  131,
			  124,    9,  132,  115,  122,   79,  104,  115,  117,  116,
			   83,  124,  116,  117,   84,   88,  125,   89,   88,   88,
			   88,   88,  344,    6,   90,  344,  121,   88,  107,  121,

			    3,  131,  124,   88,  132,   88,  126,   88,   88,   88,
			  126,  128,   88,  124,   88,    0,  128,  344,   88,  567,
			   88,    0,  567,   88,   88,   88,   88,   88,   88,   94,
			    0,  567,   94,   94,   94,   94,    0,    0,  126,    0,
			    0,   94,  126,  128,  133,  134,  129,   94,  128,   94,
			  129,   94,   94,   94,   94,  127,   94,  130,   94,  135,
			  137,  138,   94,  127,   94,  138,  130,   94,   94,   94,
			   94,   94,   94,    0,  140,  141,  133,  134,  129,  136,
			  141,  143,  129,  136,  140,  144,  136,  127,    0,  130,
			  141,  135,  137,  138,  142,  127,  147,  138,  130,  145,

			  144,  142,  148,  145,  147,  142,  140,  141,  148,  149,
			  150,  136,  141,  143,  151,  136,  140,  144,  136,  152,
			  146,  155,  141,  146,  157,    0,  142,  160,  147,  160,
			  162,  145,  144,  142,  148,  145,  147,  142,  153,  154,
			  148,  149,  150,  154,  154,  153,  151,  164,    0,    0,
			  165,  152,  146,  155,  154,  146,  157,  154,  164,  160,
			  161,  160,  162,  158,  166,  169,  161,  158,  163,  170,
			  153,  154,  161,  171,  166,  154,  154,  153,  158,  164,
			  163,  158,  165,  167,  172,  168,  154,  175,  167,  154,
			  164,  168,  161,    0,  181,  158,  166,  169,  161,  158,

			  163,  170,  183,  174,  161,  171,  166,  174,    0,    0,
			  158,    0,  163,  158,  183,  167,  172,  168,    0,  175,
			  167,    0,  178,  168,    0,  178,  181,  179,  177,  178,
			  177,  184,  185,  180,  183,  174,  179,  180,  177,  174,
			  176,  177,  176,  177,  177,  176,  183,  182,  189,    0,
			  176,  182,    0,  176,  178,  176,  176,  178,  188,  179,
			  177,  178,  177,  184,  185,  180,  190,  188,  179,  180,
			  177,  191,  176,  177,  176,  177,  177,  176,  193,  182,
			  189,  186,  176,  182,  187,  176,  186,  176,  176,  187,
			  188,  192,  194,  195,  243,  192,  245,  186,  190,  188,

			  187,  194,    0,  191,  198,  198,  198,    0,    0,  206,
			  193,  206,  206,  186,  206,    0,  187,  206,  186,    0,
			    0,  187,    0,  192,  194,  195,  243,  192,  245,  186,
			    0,  204,  187,  194,  204,  215,  215,  215,  232,  232,
			  232,  246,    0,  198,  204,  204,  204,  207,    0,  207,
			  207,  232,  207,  249,  233,  207,  233,    0,    0,  233,
			  233,  233,  206,  234,  234,  234,  236,  236,  236,  237,
			    0,  237,  251,  246,  237,  237,  237,  232,  238,  236,
			  238,  238,  238,  232,  239,  249,  239,  239,  239,  244,
			  238,  241,  241,  241,  206,  253,  242,  244,    0,  250,

			  207,  242,  248,  252,  251,  236,  254,  255,  248,  250,
			  257,  236,  260,  261,  254,  256,  252,    0,    0,  238,
			  263,  244,  238,    0,  256,  239,  264,  253,  242,  244,
			  241,  250,  207,  242,  248,  252,  267,  258,  254,  255,
			  248,  250,  257,  271,  260,  261,  254,  256,  252,  258,
			  259,  262,  263,  265,  259,  262,  256,  269,  264,  268,
			  270,  269,  272,  273,  275,  265,  274,  268,  267,  258,
			  279,    0,  272,  268,  270,  271,  278,  274,    0,  278,
			  284,  258,  259,  262,  276,  265,  259,  262,  276,  269,
			  277,  268,  270,  269,  272,  273,  275,  265,  274,  268,

			  282,  276,  279,  277,  272,  268,  270,  282,  278,  274,
			  280,  278,  284,  281,  280,  283,  276,  281,  285,  286,
			  276,  287,  277,  283,  288,  289,  290,  292,  288,  291,
			  293,  294,  282,  276,  290,  277,  291,  296,  297,  282,
			  298,  301,  280,  296,  300,  281,  280,  283,  300,  281,
			  285,  286,  303,  287,    0,  283,  288,  289,  290,  292,
			  288,  291,  293,  294,  310,  302,  290,  311,  291,  296,
			  297,  302,  298,  301,  304,  296,  300,  305,  304,  306,
			  300,  305,  307,  308,  303,  312,  309,  306,  313,  308,
			  314,  315,  317,  318,  307,  309,  310,  302,  316,  311,

			  317,  308,  316,  302,  319,  320,  304,  321,  314,  305,
			  304,  306,  323,  305,  307,  308,  325,  312,  309,  306,
			  313,  308,  314,  315,  317,  318,  307,  309,  328,  329,
			  316,  324,  317,  308,  316,  324,  319,  320,  322,  321,
			  314,  326,  327,  322,  323,  326,  330,  331,  325,  332,
			  327,  333,  334,  335,  336,  337,  338,  334,    0,  336,
			  328,  329,    0,  324,  368,  368,  368,  324,    0,  382,
			  322,    0,    0,  326,  327,  322,    0,  326,  330,  331,
			    0,  332,  327,  333,  334,  335,  336,  337,  338,  334,
			  343,  336,    0,  343,  350,  350,  350,  350,  367,  367,

			  367,  382,  343,  343,  343,  343,  369,  369,  369,  384,
			  386,  367,  370,  370,  370,  371,  371,  371,  372,    0,
			  372,    0,    0,  372,  372,  372,    0,    0,  371,  373,
			  373,  373,  374,  374,  374,  388,    0,  367,  375,  375,
			  375,  384,  386,  367,  376,  369,  376,  376,  376,  377,
			  381,  377,  377,  377,  371,  383,  376,  380,  380,  380,
			  371,  381,  387,  390,    0,  383,  385,  388,  385,  389,
			  391,  392,  387,  389,  393,  394,  396,  375,  393,  398,
			  397,  391,  381,  399,  395,  376,  395,  383,  376,  397,
			  377,  400,  402,  381,  387,  390,  380,  383,  385,  405,

			  385,  389,  391,  392,  387,  389,  393,  394,  396,  403,
			  393,  398,  397,  391,  403,  399,  395,  401,  395,  404,
			  406,  397,  408,  400,  402,  407,  401,  410,  404,  409,
			  411,  405,  412,  409,  407,  413,  414,  416,  417,  418,
			  414,  403,  411,  420,  421,  422,  403,  424,  419,  401,
			    0,  404,  406,  421,  408,  426,  427,  407,  401,  410,
			  404,  409,  411,  419,  412,  409,  407,  413,  414,  416,
			  417,  418,  414,  430,  411,  420,  421,  422,  423,  424,
			  419,  425,  423,  429,  431,  421,  429,  426,  427,  433,
			  425,  434,  433,  435,  437,  419,  438,  439,  440,  441,

			  439,  442,  444,  443,  445,  430,  437,  443,  441,  446,
			  423,  449,  450,  425,  423,  429,  431,    0,  429,  452,
			  454,  433,  425,  434,  433,  435,  437,  456,  438,  439,
			  440,  441,  439,  442,  444,  443,  445,  447,  437,  443,
			  441,  446,  448,  449,  450,  448,  451,  453,  455,  447,
			  458,  452,  454,  453,  457,  459,  461,  455,  464,  456,
			  463,  457,  451,  463,  465,  466,  468,  467,  470,  447,
			  467,  471,  473,  489,  448,  469,  465,  448,  451,  453,
			  455,  447,  458,  469,  491,  453,  457,  459,  461,  455,
			  464,    0,  463,  457,  451,  463,  465,  466,  468,  467,

			  470,    0,  467,  471,  473,  489,  475,  469,  465,  475,
			  477,  477,  477,    0,    0,  469,  491,    0,  475,  475,
			  475,  475,  493,  477,  478,  478,  478,  479,  479,  479,
			  480,  480,  480,  481,  481,  481,  482,  482,  482,  495,
			  483,  483,  483,  484,  484,  484,  481,  485,  485,  485,
			  486,  486,  486,  498,  493,  477,  487,  487,  487,  497,
			  502,  503,  488,  478,  488,  488,  488,  505,  497,  487,
			  499,  495,  481,  500,  499,  501,  505,  500,  481,  483,
			  501,  506,  508,  510,  507,  498,  485,  507,  512,    0,
			  509,  497,  502,  503,  509,  514,  516,    0,  517,  505,

			  497,  487,  499,  488,  520,  500,  499,  501,  505,  500,
			  513,  522,  501,  506,  508,  510,  507,  524,  511,  507,
			  512,  513,  509,  511,  515,  519,  509,  514,  516,  515,
			  517,  523,  521,  525,  519,  523,  520,  521,  526,  527,
			  528,  529,  513,  522,  530,  531,  532,  529,  533,  524,
			  511,  536,  538,  513,  535,  511,  515,  519,  535,  537,
			  539,  515,  540,  523,  521,  525,  519,  523,  537,  521,
			  526,  527,  528,  529,  542,  544,  530,  531,  532,  529,
			  533,  541,  546,  536,  538,  541,  535,  545,  548,  543,
			  535,  537,  539,  543,  540,  547,  545,  549,  550,  547,

			  537,  551,  554,  555,  553,  556,  542,  544,  549,  557,
			  559,  555,  560,  541,  546,  553,  562,  541,  561,  545,
			  548,  543,  561,  563,  566,  543,  572,  547,  545,  549,
			  550,  547,    0,  551,  554,  555,  553,  556,    0,    0,
			  549,  557,  559,  555,  560,  582,  565,  553,  562,    0,
			  561,  565,  572,    0,  561,  563,  566,  569,  572,  569,
			    0,    0,  569,  569,  569,  570,  570,  570,  571,  571,
			  571,  573,  573,  573,  574,  574,  574,  582,  565,  575,
			  575,  575,  583,  565,  573,  576,  576,  576,  577,  577,
			  577,  578,  578,  578,  579,    0,  579,  581,  586,  579,

			  579,  579,  588,  584,  570,  580,  580,  580,  581,  584,
			  587,  589,  590,  574,  583,  589,  573,  591,  580,  593,
			  595,  587,  596,  597,  595,  599,  600,  577,  601,  581,
			  586,  602,  601,  599,  588,  584,  603,  606,  605,  608,
			  581,  584,  587,  589,  590,  610,    0,  589,  605,  591,
			  580,  593,  595,  587,  596,  597,  595,  599,  600,  612,
			  601,  607,  609,  602,  601,  599,  607,  611,  603,  606,
			  605,  608,  614,  609,  613,  615,  616,  610,  611,  617,
			  605,  618,  613,  619,  620,  621,  615,  622,  619,  617,
			  621,  612,  623,  607,  609,  626,  625,  627,  607,  611,

			  625,  629,  631,  634,  614,  609,  613,  615,  616,  636,
			  611,  617,  633,  618,  613,  619,  620,  621,  615,  622,
			  619,  617,  621,  633,  623,  635,  637,  626,  625,  627,
			  635,  639,  625,  629,  631,  634,  640,  641,  641,  641,
			  655,  636,  639,    0,  633,  642,  642,  642,  643,  643,
			  643,  646,  646,  646,  644,  633,  644,  635,  637,  644,
			  644,  644,  635,  639,  645,  648,  645,    0,  640,  645,
			  645,  645,  655,  658,  639,  647,  647,  647,  649,  649,
			  649,  650,  650,  650,  651,  651,  651,  653,  653,  653,
			  646,  648,  659,  662,    0,  664,  654,  648,  654,  657,

			  653,  654,  654,  654,  657,  658,  661,  663,  666,  667,
			  665,  661,  663,  665,  669,  671,  672,  671,  673,  675,
			  678,  680,  682,  677,  659,  662,  653,  664,  677,  679,
			    0,  657,  653,  679,  684,  686,  657,  687,  661,  663,
			  666,  667,  665,  661,  663,  665,  669,  671,  672,  671,
			  673,  675,  678,  680,  682,  677,  681,  690,  685,  683,
			  677,  679,  681,  683,  685,  679,  684,  686,  689,  687,
			  691,  692,  689,  693,  691,  696,  696,  696,  697,  697,
			  697,  698,  698,  698,  699,  699,  699,    0,  681,  690,
			  685,  683,  706,    0,  681,  683,  685,  700,  700,  700,

			  689,  708,  691,  692,  689,  693,  691,  701,  710,  701,
			  712,  714,  701,  701,  701,  717,  718,  697,  703,  703,
			  703,  704,  704,  704,  706,  705,  705,  705,  716,  720,
			  721,  703,    0,  708,  722,  725,  726,  724,  720,  716,
			  710,  724,  712,  714,  728,    0,    0,  717,  718,  730,
			  730,  730,  732,  732,  732,  735,    0,  703,  737,  739,
			  716,  720,  721,  703,  705,    0,  722,  725,  726,  724,
			  720,  716,    0,  724,    0,    0,  728,  733,  733,  733,
			  734,  734,  734,  741,  741,  741,  744,  735,  730,    0,
			  737,  739,  744,  744,  744,  744,  744,  744,  744,  744,

			  744,  744,  744,  749,  749,  749,  749,  749,  749,  749,
			  749,  749,  754,  754,  754,    0,  733,    0,    0,  734,
			    0,    0,  741,  743,  743,    0,  743,  743,  743,  743,
			  743,  743,  743,  743,  743,  743,  743,  743,  743,  743,
			  745,  745,    0,  745,  745,  745,  745,  745,  745,  745,
			  745,  745,  745,  745,  745,  745,  745,  746,  746,    0,
			  746,  746,  746,  746,  746,  746,  746,  746,  746,  746,
			  746,  746,  746,  746,  747,  747,    0,  747,  747,    0,
			  747,  747,  747,  747,  747,  747,  747,  747,  747,  747,
			  747,  748,  748,    0,  748,  748,    0,    0,  748,  748,

			  748,  748,  748,  748,  748,  748,  748,  748,  750,  750,
			    0,  750,  750,    0,  750,  750,  750,  750,  750,  750,
			  750,  750,  750,  750,  750,  751,  751,    0,  751,  751,
			  751,  751,  751,  751,  751,  751,  751,  751,  751,  751,
			  751,  751,  752,  752,    0,  752,  752,  752,  752,  752,
			  752,  752,  752,  752,  752,  752,  752,  752,  752,  753,
			  753,  753,  753,  753,  753,  753,    0,  753,  753,  753,
			  753,  753,  753,  753,  753,  753,  755,  755,  755,    0,
			    0,    0,  755,  756,  756,  756,  756,  756,  756,  756,
			    0,  756,  756,  756,  756,  756,  756,  756,  756,  756,

			  742,  742,  742,  742,  742,  742,  742,  742,  742,  742,
			  742,  742,  742,  742,  742,  742,  742,  742,  742,  742,
			  742,  742,  742,  742,  742,  742,  742,  742,  742,  742,
			  742,  742,  742,  742,  742,  742,  742,  742,  742,  742,
			  742,  742,  742,  742,  742,  742,  742,  742,  742,  742,
			  742,  742,  742,  742,  742,  742,  742,  742,  742,  742,
			  742,  742,  742,  742,  742,  742,  742,  742,  742,  742,
			  742,  742,  742,  742,  742,  742,  742,  742,  742,  742,
			  742,  742,  742,  742,  742,  742,  742,  742,  742, yy_Dummy>>)
		end

	yy_base_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,  600, 2500,   87,  590,   91,   95,  565,
			   91,    0, 2500,   95,   93, 2500, 2500, 2500, 2500, 2500,
			   89,   89,   89,  101,  106,  112,  532, 2500,   87, 2500,
			   91,  530,  166,  233,  284,   92,  286,  112,  100,  295,
			  288,  297,  341,  113,  105,  340,  339,  152,  353,  220,
			  311, 2500,  496,  536, 2500,  134,    0,  357,  103,  394,
			  346,  383,  412,    0,  405,  357,  149,  408,  212,  226,
			  379,  415,  219,  413,  299,  341, 2500,  518,  345,  487,
			  508,  506,  496,  492,  496, 2500,  453, 2500,  578,  500,
			  507,    0,  334,  484,  622,    0, 2500, 2500, 2500,  498,

			 2500, 2500,  501,  506,  517, 2500,    0,  539, 2500, 2500,
			 2500, 2500, 2500, 2500,  412,  508,  510,  514,  416,    0,
			  483,  527,  510,    0,  533,  506,  573,  626,  574,  613,
			  620,  536,  543,  602,  612,  613,  649,  623,  631,    0,
			  637,  643,  657,  634,  653,  655,  683,  667,  665,  669,
			  681,  671,  682,  701,  707,  684,    0,  680,  731,    0,
			  690,  729,  691,  737,  710,  702,  727,  751,  754,  728,
			  722,  741,  753,    0,  770,  754,  808,  796,  785,  790,
			  793,  748,  814,  765,  798,  783,  849,  852,  821,  811,
			  820,  834,  858,  845,  855,  847, 2500, 2500,  884,  476,

			 2500,  336,  388,  458,  924,  496,  907,  945, 2500, 2500,
			  465,  453,  407,  395,  390,  915,  382,  380,  340,  334,
			  328,  311,  249,  212,  211,  173,  169,  165,  155,  153,
			  151,  140,  918,  939,  943, 2500,  946,  954,  960,  966,
			   88,  971,  959,  852,  960,  859,  912,    0,  971,  922,
			  962,  925,  966,  945,  977,  978,  978,  964, 1000, 1017,
			  963,  980, 1018,  987,  989, 1016,    0,  987, 1030, 1024,
			 1031, 1010, 1025, 1016, 1029, 1016, 1047, 1049, 1039, 1030,
			 1077, 1080, 1063, 1086, 1047, 1085, 1075, 1092, 1091, 1092,
			 1097, 1092, 1098, 1086, 1094,    0, 1100, 1095, 1103,    0,

			 1111, 1108, 1134, 1121, 1141, 1144, 1150, 1145, 1152, 1149,
			 1131, 1134, 1156, 1139, 1159, 1145, 1165, 1163, 1160, 1175,
			 1168, 1170, 1201, 1170, 1198, 1183, 1208, 1205, 1191, 1196,
			 1201, 1210, 1212, 1214, 1220, 1221, 1217, 1213, 1219,    0,
			 2500,  522,  523, 1283,  585, 2500, 2500, 2500, 2500, 2500,
			 1275, 2500, 2500, 2500, 2500, 2500, 2500, 2500, 2500, 2500,
			 2500, 2500, 2500, 2500, 2500, 2500, 2500, 1278, 1244, 1286,
			 1292, 1295, 1303, 1309, 1312, 1318, 1326, 1331,   84,   80,
			 1337, 1313, 1221, 1318, 1262, 1329, 1271, 1325, 1288, 1336,
			 1330, 1333, 1323, 1341, 1342, 1349, 1341, 1343, 1333, 1346,

			 1354, 1380, 1346, 1372, 1382, 1357, 1374, 1388, 1376, 1396,
			 1394, 1393, 1383, 1398, 1403,    0, 1404, 1401, 1402, 1411,
			 1391, 1407, 1399, 1445, 1414, 1444, 1409, 1419,    0, 1446,
			 1433, 1447,    0, 1452, 1451, 1456,    0, 1457, 1447, 1463,
			 1464, 1462, 1455, 1466, 1461, 1467, 1472, 1500, 1505, 1462,
			 1472, 1509, 1466, 1516, 1489, 1511, 1481, 1517, 1506, 1518,
			    0, 1519,    0, 1526, 1524, 1527, 1516, 1530, 1526, 1546,
			 1539, 1534,    0, 1535,    0, 1599,  109, 1590, 1604, 1607,
			 1610, 1613, 1616, 1620, 1623, 1627, 1630, 1636, 1644, 1536,
			    0, 1547,    0, 1585,    0, 1602,    0, 1622, 1607, 1637,

			 1640, 1638, 1618, 1624,    0, 1630, 1635, 1650, 1648, 1657,
			 1650, 1686, 1656, 1673, 1647, 1687, 1654, 1661,    0, 1688,
			 1658, 1695, 1669, 1698, 1684, 1696, 1701, 1702, 1703, 1710,
			 1713, 1708, 1709, 1711,    0, 1721, 1718, 1722, 1706, 1723,
			 1725, 1748, 1741, 1756, 1742, 1750, 1736, 1762, 1755, 1760,
			 1750, 1764,    0, 1767, 1754, 1774, 1776, 1772,    0, 1773,
			 1775, 1785, 1783, 1786,    0, 1809, 1782,  612, 2500, 1842,
			 1845, 1848, 1793, 1851, 1854, 1859, 1865, 1868, 1871, 1879,
			 1885, 1860, 1797, 1845, 1866,    0, 1855, 1873, 1854, 1878,
			 1879, 1880,    0, 1882,    0, 1887, 1889, 1886,    0, 1896,

			 1897, 1895, 1898, 1899,    0, 1901, 1890, 1924, 1897, 1925,
			 1897, 1930, 1911, 1945, 1943, 1938, 1928, 1942, 1934, 1946,
			 1942, 1948, 1945, 1955,    0, 1963, 1962, 1960,    0, 1964,
			    0, 1965,    0, 1975, 1955, 1988, 1967, 1989,    0, 1994,
			 1988, 2017, 2025, 2028, 2039, 2049, 2031, 2055, 2032, 2058,
			 2061, 2064, 2500, 2067, 2081, 2003,    0, 2062, 2031, 2055,
			    0, 2074, 2061, 2075, 2063, 2073, 2068, 2072,    0, 2077,
			    0, 2080, 2081, 2081,    0, 2082,    0, 2086, 2078, 2096,
			 2088, 2119, 2079, 2126, 2101, 2127, 2104, 2100,    0, 2135,
			 2124, 2137, 2138, 2136,    0,   55, 2155, 2158, 2161, 2164,

			 2177, 2192,   35, 2198, 2201, 2205, 2155,    0, 2164,    0,
			 2171,    0, 2173,    0, 2174,    0, 2191, 2167, 2179,    0,
			 2192, 2184, 2197,    0, 2204, 2202, 2199,    0, 2207,    0,
			 2229,   31, 2232, 2257, 2260, 2218,    0, 2221,    0, 2222,
			    0, 2263, 2500, 2322, 2285, 2339, 2356, 2373, 2390, 2294,
			 2407, 2424, 2441, 2458, 2303, 2467, 2482, yy_Dummy>>)
		end

	yy_def_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,  742,    1,  742,  742,  742,  742,  742,  742,  742,
			  743,  744,  742,  745,  746,  742,  742,  742,  742,  742,
			  742,  742,  742,  742,  742,  742,  742,  742,  742,  742,
			  742,  742,  742,  742,   33,   33,   33,   33,   33,   33,
			   33,   33,   33,   33,   33,   33,   33,   33,   33,   33,
			   33,  742,  742,  747,  742,  742,  748,  749,  749,  749,
			  749,  749,  749,  749,  749,  749,  749,  749,  749,  749,
			  749,  749,  749,  749,  749,  749,  742,  750,  742,  742,
			  747,  750,  742,  742,  742,  742,  743,  742,  751,  743,
			  743,  744,  745,  752,  752,  752,  742,  742,  742,  742,

			  742,  742,  753,  742,  742,  742,  754,  742,  742,  742,
			  742,  742,  742,  742,   33,   33,   33,   33,   33,  749,
			  749,  749,  749,  749,   33,  749,   33,   33,   33,   33,
			   33,  749,  749,  749,  749,  749,   33,   33,  749,  749,
			   33,   33,   33,  749,  749,  749,   33,   33,   33,  749,
			  749,  749,   33,   33,   33,   33,  749,  749,  749,  749,
			   33,   33,  749,  749,   33,  749,   33,   33,   33,   33,
			  749,  749,  749,  749,   33,  749,   33,  749,   33,   33,
			  749,  749,   33,   33,  749,  749,   33,  749,   33,   33,
			  749,  749,   33,  749,   33,  749,  742,  742,  742,  748,

			  742,  751,  745,  745,  751,  751,  743,  743,  742,  742,
			  742,  742,  742,  742,  742,  742,  742,  742,  742,  742,
			  742,  742,  742,  742,  742,  742,  742,  742,  742,  742,
			  742,  742,  742,  742,  742,  742,  742,  742,  742,  742,
			  755,  742,   33,  749,   33,   33,  749,  749,   33,  749,
			   33,  749,   33,  749,   33,  749,   33,  749,   33,   33,
			  749,  749,   33,  749,   33,   33,  749,  749,   33,   33,
			  749,  749,   33,  749,   33,  749,   33,  749,   33,  749,
			   33,   33,   33,   33,  749,  749,  749,  749,   33,  749,
			   33,   33,  749,  749,   33,  749,   33,  749,   33,  749,

			   33,  749,   33,  749,   33,   33,   33,   33,   33,   33,
			  749,  749,  749,  749,  749,  749,   33,   33,  749,  749,
			   33,  749,   33,  749,   33,  749,   33,   33,   33,  749,
			  749,  749,   33,  749,   33,  749,   33,  749,   33,  749,
			  742,  751,  751,  751,  751,  742,  742,  742,  742,  742,
			  742,  742,  742,  742,  742,  742,  742,  742,  742,  742,
			  742,  742,  742,  742,  742,  742,  742,  742,  742,  742,
			  742,  742,  742,  742,  742,  742,  742,  742,  755,  755,
			  742,   33,  749,   33,  749,   33,  749,   33,  749,   33,
			  749,   33,  749,   33,  749,   33,  749,   33,  749,   33,

			  749,   33,  749,   33,   33,  749,  749,   33,  749,   33,
			  749,   33,  749,   33,   33,  749,  749,   33,  749,   33,
			  749,   33,  749,   33,  749,   33,  749,   33,  749,   33,
			  749,   33,  749,   33,  749,   33,  749,   33,  749,   33,
			  749,   33,  749,   33,  749,   33,  749,   33,   33,  749,
			  749,   33,  749,   33,  749,   33,  749,   33,  749,   33,
			  749,   33,  749,   33,  749,   33,  749,   33,  749,   33,
			  749,   33,  749,   33,  749,  751,  742,  742,  742,  742,
			  742,  742,  742,  742,  742,  742,  742,  753,  742,   33,
			  749,   33,  749,   33,  749,   33,  749,   33,  749,   33,

			  749,   33,  749,   33,  749,   33,  749,   33,  749,   33,
			  749,   33,  749,   33,  749,   33,  749,   33,  749,   33,
			  749,   33,  749,   33,  749,   33,  749,   33,  749,   33,
			  749,   33,  749,   33,  749,   33,  749,   33,  749,   33,
			  749,   33,  749,   33,  749,   33,  749,   33,  749,   33,
			  749,   33,  749,   33,  749,   33,  749,   33,  749,   33,
			  749,   33,  749,   33,  749,   33,  749,  751,  742,  742,
			  742,  742,  742,  742,  742,  742,  742,  742,  742,  742,
			  756,   33,  749,   33,   33,  749,  749,   33,  749,   33,
			  749,   33,  749,   33,  749,   33,  749,   33,  749,   33,

			  749,   33,  749,   33,  749,   33,  749,   33,  749,   33,
			  749,   33,  749,   33,  749,   33,  749,   33,  749,   33,
			  749,   33,  749,   33,  749,   33,  749,   33,  749,   33,
			  749,   33,  749,   33,  749,   33,  749,   33,  749,   33,
			  749,  742,  742,  742,  742,  742,  742,  742,  742,  742,
			  742,  742,  742,  742,  742,   33,  749,   33,  749,   33,
			  749,   33,  749,   33,  749,   33,  749,   33,  749,   33,
			  749,   33,  749,   33,  749,   33,  749,   33,  749,   33,
			  749,   33,  749,   33,  749,   33,  749,   33,  749,   33,
			  749,   33,  749,   33,  749,  742,  742,  742,  742,  742,

			  742,  742,  742,  742,  742,  742,   33,  749,   33,  749,
			   33,  749,   33,  749,   33,  749,   33,  749,   33,  749,
			   33,  749,   33,  749,   33,  749,   33,  749,   33,  749,
			  742,  742,  742,  742,  742,   33,  749,   33,  749,   33,
			  749,  742,    0,  742,  742,  742,  742,  742,  742,  742,
			  742,  742,  742,  742,  742,  742,  742, yy_Dummy>>)
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
			  458,  459,  460,  462,  463,  465,  468,  469,  471,  473,
			  474,  476,  477,  479,  480,  482,  483,  485,  486,  488,
			  490,  491,  492,  494,  495,  498,  500,  502,  503,  505,
			  507,  508,  509,  511,  512,  514,  515,  517,  518,  520,
			  521,  523,  525,  527,  529,  530,  531,  532,  533,  535,
			  536,  538,  540,  541,  542,  545,  547,  549,  550,  553,

			  555,  557,  558,  560,  561,  563,  565,  567,  569,  571,
			  573,  574,  575,  576,  577,  578,  579,  581,  583,  584,
			  585,  587,  588,  590,  591,  593,  594,  596,  598,  600,
			  601,  602,  603,  605,  606,  608,  609,  611,  612,  615,
			  617,  618,  619,  620,  620,  621,  622,  623,  624,  625,
			  626,  627,  628,  629,  630,  631,  632,  633,  634,  635,
			  636,  637,  638,  639,  640,  641,  642,  643,  645,  645,
			  647,  647,  649,  649,  649,  649,  651,  653,  655,  656,
			  656,  657,  659,  660,  662,  663,  665,  666,  668,  669,
			  671,  672,  674,  675,  677,  678,  680,  681,  683,  684,

			  687,  689,  691,  692,  694,  696,  697,  698,  700,  701,
			  703,  704,  706,  707,  710,  712,  714,  715,  717,  718,
			  720,  721,  723,  724,  726,  727,  729,  730,  733,  735,
			  737,  738,  741,  743,  745,  746,  749,  751,  753,  754,
			  756,  757,  759,  760,  762,  763,  765,  766,  768,  770,
			  771,  772,  774,  775,  777,  778,  780,  781,  783,  784,
			  787,  789,  792,  794,  796,  797,  799,  800,  802,  803,
			  805,  806,  809,  811,  814,  816,  816,  817,  818,  820,
			  820,  820,  822,  822,  826,  826,  828,  828,  828,  830,
			  833,  835,  838,  840,  843,  845,  848,  850,  852,  853,

			  855,  856,  858,  859,  862,  864,  866,  867,  869,  870,
			  872,  873,  875,  876,  878,  879,  881,  882,  885,  887,
			  889,  890,  892,  893,  895,  896,  898,  899,  901,  902,
			  904,  905,  907,  908,  911,  913,  915,  916,  918,  919,
			  921,  922,  924,  925,  927,  928,  930,  931,  933,  934,
			  936,  937,  940,  942,  944,  945,  947,  948,  951,  953,
			  955,  956,  958,  959,  962,  964,  966,  967,  967,  968,
			  968,  970,  970,  971,  972,  976,  976,  976,  978,  978,
			  979,  979,  981,  982,  985,  987,  989,  990,  992,  993,
			  995,  996,  999, 1001, 1004, 1006, 1008, 1009, 1012, 1014,

			 1016, 1017, 1019, 1020, 1023, 1025, 1027, 1028, 1030, 1031,
			 1033, 1034, 1036, 1037, 1039, 1040, 1042, 1043, 1045, 1046,
			 1048, 1049, 1051, 1052, 1055, 1057, 1059, 1060, 1063, 1065,
			 1068, 1070, 1073, 1075, 1077, 1078, 1080, 1081, 1084, 1086,
			 1088, 1089, 1089, 1090, 1090, 1090, 1090, 1094, 1094, 1095,
			 1096, 1096, 1096, 1097, 1098, 1099, 1102, 1104, 1106, 1107,
			 1110, 1112, 1114, 1115, 1117, 1118, 1120, 1121, 1124, 1126,
			 1129, 1131, 1133, 1134, 1137, 1139, 1142, 1144, 1146, 1147,
			 1149, 1150, 1152, 1153, 1155, 1156, 1158, 1159, 1162, 1164,
			 1166, 1167, 1169, 1170, 1173, 1175, 1176, 1176, 1177, 1177,

			 1179, 1179, 1179, 1180, 1181, 1181, 1182, 1185, 1187, 1190,
			 1192, 1195, 1197, 1200, 1202, 1205, 1207, 1209, 1210, 1213,
			 1215, 1217, 1218, 1221, 1223, 1225, 1226, 1229, 1231, 1234,
			 1236, 1237, 1239, 1239, 1241, 1242, 1245, 1247, 1250, 1252,
			 1255, 1257, 1259, 1259, yy_Dummy>>)
		end

	yy_acclist_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,  146,  144,  145,    3,  144,  145,    4,  145,    1,
			  144,  145,    2,  144,  145,   10,  144,  145,  130,  144,
			  145,   99,  144,  145,   17,  144,  145,  130,  144,  145,
			  144,  145,   11,  144,  145,   12,  144,  145,   31,  144,
			  145,   30,  144,  145,    8,  144,  145,   29,  144,  145,
			    6,  144,  145,   32,  144,  145,  132,  136,  144,  145,
			  132,  136,  144,  145,  132,  136,  144,  145,    9,  144,
			  145,    7,  144,  145,   36,  144,  145,   34,  144,  145,
			   35,  144,  145,  144,  145,   97,   98,  144,  145,   97,
			   98,  144,  145,   97,   98,  144,  145,   97,   98,  144,

			  145,   97,   98,  144,  145,   97,   98,  144,  145,   97,
			   98,  144,  145,   97,   98,  144,  145,   97,   98,  144,
			  145,   97,   98,  144,  145,   97,   98,  144,  145,   97,
			   98,  144,  145,   97,   98,  144,  145,   97,   98,  144,
			  145,   97,   98,  144,  145,   97,   98,  144,  145,   97,
			   98,  144,  145,   97,   98,  144,  145,   97,   98,  144,
			  145,   15,  144,  145,  144,  145,   16,  144,  145,   33,
			  144,  145,  136,  144,  145,  144,  145,   98,  144,  145,
			   98,  144,  145,   98,  144,  145,   98,  144,  145,   98,
			  144,  145,   98,  144,  145,   98,  144,  145,   98,  144,

			  145,   98,  144,  145,   98,  144,  145,   98,  144,  145,
			   98,  144,  145,   98,  144,  145,   98,  144,  145,   98,
			  144,  145,   98,  144,  145,   98,  144,  145,   98,  144,
			  145,   98,  144,  145,   13,  144,  145,   14,  144,  145,
			    3,    4,    1,    2,   37,  130,  129,  129, -125,  130,
			 -270, -126,  130, -271,   99,  130,  123,  123,  123,    5,
			   23,   24,  139,  142,   18,   20,  132,  136,  132,  136,
			  131,  136,   28,   25,   22,   21,   26,   27,   97,   98,
			   97,   98,   97,   98,   97,   98,   41,   97,   98,   98,
			   98,   98,   98,   41,   98,   97,   98,   98,   97,   98,

			   97,   98,   97,   98,   97,   98,   97,   98,   98,   98,
			   98,   98,   98,   97,   98,   50,   97,   98,   98,   50,
			   98,   97,   98,   97,   98,   97,   98,   98,   98,   98,
			   97,   98,   97,   98,   97,   98,   98,   98,   98,   62,
			   97,   98,   97,   98,   97,   98,   68,   97,   98,   62,
			   98,   98,   98,   68,   98,   97,   98,   97,   98,   98,
			   98,   97,   98,   98,   97,   98,   97,   98,   97,   98,
			   76,   97,   98,   98,   98,   98,   76,   98,   97,   98,
			   98,   97,   98,   98,   97,   98,   97,   98,   98,   98,
			   97,   98,   97,   98,   98,   98,   97,   98,   98,   97,

			   98,   97,   98,   98,   98,   97,   98,   98,   97,   98,
			   98,   19,  127,  136,  128,  129,  130,  129,  130, -125,
			  130, -126,  130,  123,  100,  123,  123,  123,  123,  123,
			  123,  123,  123,  123,  123,  123,  123,  123,  123,  123,
			  123,  123,  123,  123,  123,  123,  123,  123,  139,  142,
			  137,  139,  142,  137,  132,  136,  132,  136,  134,  136,
			   97,   98,   98,   97,   98,   40,   97,   98,   98,   40,
			   98,   97,   98,   98,   97,   98,   98,   97,   98,   98,
			   97,   98,   98,   97,   98,   98,   97,   98,   97,   98,
			   98,   98,   97,   98,   98,   53,   97,   98,   97,   98,

			   53,   98,   98,   97,   98,   97,   98,   98,   98,   97,
			   98,   98,   97,   98,   98,   97,   98,   98,   97,   98,
			   98,   97,   98,   97,   98,   97,   98,   97,   98,   98,
			   98,   98,   98,   97,   98,   98,   97,   98,   97,   98,
			   98,   98,   72,   97,   98,   72,   98,   97,   98,   98,
			   74,   97,   98,   74,   98,   97,   98,   98,   97,   98,
			   98,   97,   98,   97,   98,   97,   98,   97,   98,   97,
			   98,   97,   98,   98,   98,   98,   98,   98,   98,   97,
			   98,   97,   98,   98,   98,   97,   98,   98,   97,   98,
			   98,   97,   98,   98,   97,   98,   97,   98,   97,   98,

			   98,   98,   98,   97,   98,   98,   97,   98,   98,   97,
			   98,   98,   96,   97,   98,   96,   98,  143,  129,  129,
			  129,  117,  115,  116,  118,  119,  124,  120,  121,  101,
			  102,  103,  104,  105,  106,  107,  108,  109,  110,  111,
			  112,  113,  114,  139,  142,  139,  142,  139,  142,  138,
			  141,  132,  136,  132,  136,  135,  136,   97,   98,   98,
			   97,   98,   98,   97,   98,   98,   97,   98,   98,   97,
			   98,   98,   97,   98,   98,   97,   98,   98,   97,   98,
			   98,   97,   98,   98,   51,   97,   98,   51,   98,   97,
			   98,   98,   97,   98,   97,   98,   98,   98,   97,   98,

			   98,   97,   98,   98,   97,   98,   98,   60,   97,   98,
			   97,   98,   60,   98,   98,   97,   98,   98,   97,   98,
			   98,   97,   98,   98,   97,   98,   98,   97,   98,   98,
			   69,   97,   98,   69,   98,   97,   98,   98,   71,   97,
			   98,   71,   98,   97,   98,   98,   75,   97,   98,   75,
			   98,   97,   98,   98,   97,   98,   98,   97,   98,   98,
			   97,   98,   98,   97,   98,   98,   97,   98,   97,   98,
			   98,   98,   97,   98,   98,   97,   98,   98,   97,   98,
			   98,   97,   98,   98,   88,   97,   98,   88,   98,   89,
			   97,   98,   89,   98,   97,   98,   98,   97,   98,   98,

			   97,   98,   98,   97,   98,   98,   94,   97,   98,   94,
			   98,   95,   97,   98,   95,   98,  124,  139,  139,  142,
			  139,  142,  138,  139,  141,  142,  138,  141,  133,  136,
			   38,   97,   98,   38,   98,   39,   97,   98,   39,   98,
			   42,   97,   98,   42,   98,   43,   97,   98,   43,   98,
			   97,   98,   98,   97,   98,   98,   97,   98,   98,   48,
			   97,   98,   48,   98,   97,   98,   98,   97,   98,   98,
			   97,   98,   98,   97,   98,   98,   97,   98,   98,   97,
			   98,   98,   58,   97,   98,   58,   98,   97,   98,   98,
			   97,   98,   98,   97,   98,   98,   97,   98,   98,   97,

			   98,   98,   97,   98,   98,   97,   98,   98,   70,   97,
			   98,   70,   98,   97,   98,   98,   97,   98,   98,   97,
			   98,   98,   97,   98,   98,   97,   98,   98,   97,   98,
			   98,   97,   98,   98,   97,   98,   98,   84,   97,   98,
			   84,   98,   97,   98,   98,   97,   98,   98,   87,   97,
			   98,   87,   98,   97,   98,   98,   97,   98,   98,   92,
			   97,   98,   92,   98,   97,   98,   98,  122,  139,  142,
			  142,  139,  138,  139,  141,  142,  138,  141,  137,   97,
			   98,   98,   45,   97,   98,   97,   98,   45,   98,   98,
			   97,   98,   98,   97,   98,   98,   52,   97,   98,   52,

			   98,   54,   97,   98,   54,   98,   97,   98,   98,   56,
			   97,   98,   56,   98,   97,   98,   98,   97,   98,   98,
			   61,   97,   98,   61,   98,   97,   98,   98,   97,   98,
			   98,   97,   98,   98,   97,   98,   98,   97,   98,   98,
			   97,   98,   98,   97,   98,   98,   97,   98,   98,   97,
			   98,   98,   80,   97,   98,   80,   98,   97,   98,   98,
			   82,   97,   98,   82,   98,   83,   97,   98,   83,   98,
			   85,   97,   98,   85,   98,   97,   98,   98,   97,   98,
			   98,   91,   97,   98,   91,   98,   97,   98,   98,  139,
			  138,  139,  141,  142,  142,  138,  140,  142,  140,   44,

			   97,   98,   44,   98,   97,   98,   98,   47,   97,   98,
			   47,   98,   97,   98,   98,   97,   98,   98,   97,   98,
			   98,   59,   97,   98,   59,   98,   63,   97,   98,   63,
			   98,   97,   98,   98,   65,   97,   98,   65,   98,   66,
			   97,   98,   66,   98,   97,   98,   98,   97,   98,   98,
			   97,   98,   98,   97,   98,   98,   97,   98,   98,   81,
			   97,   98,   81,   98,   97,   98,   98,   97,   98,   98,
			   93,   97,   98,   93,   98,  142,  142,  138,  139,  141,
			  142,  141,   46,   97,   98,   46,   98,   49,   97,   98,
			   49,   98,   55,   97,   98,   55,   98,   57,   97,   98,

			   57,   98,   64,   97,   98,   64,   98,   97,   98,   98,
			   73,   97,   98,   73,   98,   97,   98,   98,   79,   97,
			   98,   79,   98,   97,   98,   98,   86,   97,   98,   86,
			   98,   90,   97,   98,   90,   98,  142,  141,  142,  141,
			  142,  141,   67,   97,   98,   67,   98,   77,   97,   98,
			   77,   98,   78,   97,   98,   78,   98,  141,  142, yy_Dummy>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER is 2500
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER is 742
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER is 743
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

	yyNb_rules: INTEGER is 145
			-- Number of rules

	yyEnd_of_buffer: INTEGER is 146
			-- End of buffer rule code

	yyLine_used: BOOLEAN is false
			-- Are line and column numbers used?

	yyPosition_used: BOOLEAN is false
			-- Is `position' used?

	INITIAL: INTEGER is 0
			-- Start condition codes

feature -- User-defined features


end -- EDITOR_EIFFEL_SCANNER
