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
			yy_nxt ?= yy_nxt_template
			yy_chk ?= yy_chk_template
			yy_base ?= yy_base_template
			yy_def ?= yy_def_template
			yy_ec ?= yy_ec_template
			yy_meta ?= yy_meta_template
			yy_accept ?= yy_accept_template
			yy_acclist ?= yy_acclist_template
		end

	yy_execute_action (yy_act: INTEGER) is
			-- Execute semantic action.
		do
			inspect yy_act
when 1 then
--|#line 26 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 26")
end
-- Ignore carriage return
when 2 then
--|#line 27 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 27")
end

					create {EDITOR_TOKEN_SPACE} curr_token.make(text_count)
					update_token_list
					
when 3 then
--|#line 31 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 31")
end

					create {EDITOR_TOKEN_TABULATION} curr_token.make(text_count)
					update_token_list
					
when 4 then
--|#line 35 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 35")
end

					from i_ := 1 until i_ > text_count loop
						create {EDITOR_TOKEN_EOL} curr_token.make
						update_token_list
						i_ := i_ + 1
					end
					in_comments := False
					
when 5 then
--|#line 47 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 47")
end
 
						-- comments
					create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					update_token_list
					in_comments := True
					
when 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17 then
--|#line 56 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 56")
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
--|#line 82 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 82")
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
--|#line 117 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 117")
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
--|#line 194 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 194")
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
--|#line 213 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 213")
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
--|#line 230 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 230")
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
--|#line 249 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 249")
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
--|#line 284 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 284")
end

					if not in_comments then
						if not in_verbatim_string then
							code_ := text_substring (4, text_count - 2).to_integer
							if code_ > feature {CHARACTER}.Max_value then
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
--|#line 304 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 304")
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
--|#line 331 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 331")
end

					-- Verbatim string opener.				
				create {EDITOR_TOKEN_STRING} curr_token.make(text)
				update_token_list
				in_verbatim_string := True
			
when 126 then
--|#line 338 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 338")
end

					-- Verbatim string closer, possibly.				
				create {EDITOR_TOKEN_STRING} curr_token.make(text)
				update_token_list
				--if is_verbatim_string_closer then
					in_verbatim_string := False
				--end
			
when 127, 128 then
--|#line 347 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 347")
end

					-- Eiffel String
					if not in_comments then						
						create {EDITOR_TOKEN_STRING} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
when 129 then
--|#line 360 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 360")
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
					
when 130, 131 then
--|#line 377 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 377")
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
						
when 132 then
--|#line 392 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 392")
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
						
when 133 then
	yy_end := yy_end - 1
--|#line 409 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 409")
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
						
when 134, 135 then
--|#line 410 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 410")
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
						
when 136 then
	yy_end := yy_end - 1
--|#line 412 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 412")
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
						
when 137, 138 then
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
						
when 139 then
--|#line 434 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 434")
end

					create {EDITOR_TOKEN_TEXT} curr_token.make(text)
					update_token_list
					
when 140 then
--|#line 442 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 442")
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
				
when 141 then
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

	yy_nxt_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,    4,    5,    6,    7,    8,    9,   10,   11,   12,
			   13,   14,   15,   16,   17,   18,   19,   20,   21,   22,
			   23,   24,   25,   26,   27,   28,   29,   30,   31,   32,
			   33,   34,   35,   36,   37,   37,   38,   37,   37,   39,
			   37,   40,   41,   42,   37,   43,   44,   45,   46,   47,
			   48,   49,   37,   37,   50,   51,   52,   53,   54,   55,
			   56,   57,   58,   59,   60,   61,   62,   62,   63,   62,
			   62,   64,   62,   65,   66,   67,   62,   68,   69,   70,
			   71,   72,   73,   74,   62,   62,   75,   76,   77,  566,
			   78,   78,   78,  110,   81,   78,   78,   85,   78,   82,

			   86,   85,   91,   92,   86,   93,   95,   97,   96,   96,
			  105,  106,  477,   98,   94,   99,  172,  100,  101,   99,
			  110,  101,  101,  107,  108,  115,  102,  194,  194,  470,
			  110,  188,  110,   85,  121,  182,   86,   85,   85,  559,
			  334,   86,   79,  359,   87,  358,   79,  357,  173,  356,
			   79,  355,  115,  354,   99,  103,  233,  233,  102,  103,
			  110,  110,  115,  189,  115,  194,  121,  183,  110,  110,
			  110,  110,  110,  110,  111,  110,  110,  110,  110,  112,
			  110,  113,  110,  110,  110,  110,  114,  110,  110,  110,
			  110,  110,  110,  110,  103,  353,  161,  171,  110,  173,

			  115,  115,  115,  115,  115,  115,  116,  115,  115,  115,
			  115,  117,  115,  118,  115,  115,  115,  115,  119,  115,
			  115,  115,  115,  115,  115,  115,  110,  110,  161,  171,
			  183,  173,  352,  189,  110,  110,  110,  110,  110,  110,
			  110,  110,  120,  110,  110,  110,  110,  110,  110,  110,
			  110,  110,  110,  110,  110,  110,  110,  110,  110,  110,
			  343,  343,  183,  191,  110,  189,  115,  115,  115,  115,
			  115,  115,  115,  115,  121,  115,  115,  115,  115,  115,
			  115,  115,  115,  115,  115,  115,  115,  115,  115,  115,
			  115,  115,  122,  110,  132,  191,  123,  351,  110,  124,

			  110,  156,  125,  110,  133,  126,  136,  157,  137,  110,
			  110,  110,  142,  236,  148,  160,  143,  110,  138,  170,
			  110,  149,  150,  350,  127,  115,  134,  151,  128,  144,
			  115,  129,  115,  158,  130,  115,  135,  131,  139,  159,
			  140,  115,  115,  115,  145,  236,  152,  161,  146,  115,
			  141,  171,  115,  153,  154,  162,  178,  110,  176,  155,
			  174,  147,  110,  110,  110,  163,  179,  164,  184,  190,
			  134,  165,  116,  177,  235,  175,  110,  117,  110,  118,
			  135,  349,  185,  335,  119,  348,   86,  166,  180,  115,
			  176,  347,  176,  346,  115,  115,  115,  167,  181,  168,

			  186,  191,  134,  169,  116,  177,  236,  177,  115,  117,
			  115,  118,  135,  127,  187,  186,  119,  128,  145,  139,
			  129,  140,  146,  130,  158,  152,  131,  166,  240,  187,
			  159,  141,  153,  154,  180,  147,  345,  167,  155,  168,
			  234,  234,  119,  169,  181,  127,  344,  186,  342,  128,
			  145,  139,  129,  140,  146,  130,  158,  152,  131,  166,
			  240,  187,  159,  141,  153,  154,  180,  147,  238,  167,
			  155,  168,  341,  110,  119,  169,  181,   77,  194,   78,
			   78,   78,  340,   78,   78,   78,  242,   81,   78,   78,
			   85,   78,   82,   86,  201,  237,  201,  201,  238,   85,

			  240,  239,   86,  339,  240,  115,  244,  226,  226,  230,
			  230,  338,   99,   85,  232,  233,  337,  335,  242,  227,
			  334,  231,  241,  102,  363,  363,  110,  239,  246,   85,
			  240,   79,  334,  239,  333,   79,  240,   87,  244,   79,
			  203,  248,  250,   79,  197,  228,   87,  198,   89,   89,
			   89,  227,  103,  231,  242,  102,  199,  110,  115,   80,
			  246,   89,  110,   89,  110,   89,   89,  200,  114,  245,
			   89,  247,   89,  248,  250,  110,   89,  193,   89,  193,
			  243,   89,   89,   89,   89,   89,   89,  204,  110,  115,
			  205,  206,  207,  208,  115,  192,  115,  109,  253,  209,

			  119,  246,  254,  248,  210,  110,  211,  115,  212,  213,
			  214,  215,  244,  216,  249,  217,  256,  266,  257,  218,
			  115,  219,  110,  110,  220,  221,  222,  223,  224,  225,
			  253,  251,  255,  258,  254,  252,  110,  115,  110,  110,
			  263,  259,  265,  261,  264,  267,  250,  262,  256,  266,
			  259,  110,  268,  110,  115,  115,  260,  269,  270,  110,
			  110,  272,  110,  253,  256,  260,  104,  254,  115,  271,
			  115,  115,  263,  259,  266,  263,  264,  268,   83,  264,
			  282,   80,  273,  115,  268,  115,  274,  110,  260,  270,
			  270,  115,  115,  272,  115,  277,  110,  275,  281,  278,

			  276,  272,  288,  283,  285,  110,  110,  733,  290,  110,
			  279,  110,  282,  280,  277,  284,  286,  287,  278,  115,
			  291,  289,  292,  294,  296,  110,  314,  277,  115,  279,
			  282,  278,  280,  293,  288,  285,  285,  115,  115,  110,
			  290,  115,  279,  115,  733,  280,  295,  286,  286,  288,
			  110,  733,  292,  290,  292,  294,  296,  115,  314,  110,
			  303,  733,  304,  316,  733,  294,  362,  362,  313,  733,
			  305,  115,  318,  306,  110,  307,  308,  309,  296,  327,
			  311,  310,  115,  297,  312,  298,  315,  733,  110,  110,
			  110,  115,  303,  299,  304,  316,  300,  326,  301,  302,

			  314,  317,  305,  733,  318,  306,  115,  307,  308,  311,
			  328,  328,  311,  312,  110,  303,  312,  304,  316,  319,
			  115,  115,  115,  325,  320,  305,  330,  322,  306,  326,
			  307,  308,  323,  318,  329,  321,  110,  332,  110,  733,
			  194,  194,  328,  324,  733,  331,  115,   85,  733,  373,
			  334,  322,  733,  360,  360,  326,  323,  733,  330,  322,
			  336,  336,  110,  733,  323,  227,  330,  324,  115,  332,
			  115,  201,  733,  201,  201,  324,   85,  332,  194,   86,
			  361,  373,  361,  364,  364,  362,  362,  367,  375,  367,
			  377,  228,  368,  368,  115,  365,   99,  227,  369,  370,

			   99,  110,  370,  370,  371,  371,  372,  102,  733,  374,
			  733,  379,  376,  110,  110,  381,  383,  110,  110,  110,
			  375,  366,  377,   87,  378,  385,  380,  365,  384,  382,
			  388,  387,  733,  115,  110,  389,  103,  110,  373,  102,
			  103,  375,  194,  379,  377,  115,  115,  381,  383,  115,
			  115,  115,  110,  391,  110,  390,  379,  385,  381,  110,
			  385,  383,  389,  387,  386,  110,  115,  389,  393,  115,
			  399,  398,  401,  110,  394,  110,  396,  392,  110,  403,
			  733,  406,  110,  400,  115,  391,  115,  391,  395,  402,
			  397,  115,  409,  733,  407,  110,  387,  115,  110,  404,

			  393,  408,  399,  399,  401,  115,  396,  115,  396,  393,
			  115,  403,  405,  406,  115,  401,  411,  413,  415,  410,
			  397,  403,  397,  110,  409,  412,  407,  115,  110,  110,
			  115,  406,  416,  409,  417,  414,  419,  418,  420,  421,
			  110,  110,  423,  110,  407,  110,  110,  110,  411,  413,
			  415,  411,  422,  424,  425,  115,  110,  413,  426,  427,
			  115,  115,  110,  429,  417,  733,  417,  415,  419,  419,
			  421,  421,  115,  115,  423,  115,  428,  115,  115,  115,
			  431,  433,  110,  430,  423,  425,  425,  110,  115,  432,
			  427,  427,  434,  110,  115,  429,  110,  110,  438,  435,

			  110,  437,  440,  443,  110,  442,  444,  445,  429,  436,
			  110,  447,  431,  433,  115,  431,  439,  448,  446,  115,
			  441,  433,  449,  451,  435,  115,  110,  453,  115,  115,
			  440,  435,  115,  437,  440,  443,  115,  443,  445,  445,
			  110,  437,  115,  447,  458,  450,  455,  452,  441,  449,
			  447,  110,  441,  454,  449,  451,  110,  110,  115,  453,
			  457,  459,  460,  461,  456,  462,  463,  465,  110,  110,
			  110,  733,  115,  464,  468,  468,  459,  451,  455,  453,
			  467,  343,  343,  115,  335,  455,  227,  334,  115,  115,
			  469,  469,  457,  459,  461,  461,  457,  463,  463,  465,

			  115,  115,  115,   85,  733,  465,  334,  733,   89,  471,
			  471,  110,  228,  472,  472,   89,  466,  466,  227,  475,
			  475,  473,  480,  473,  481,  365,  474,  474,  470,  368,
			  368,  476,  476,  478,  483,  369,  370,  478,  110,  370,
			  370,  479,  479,  115,  102,  733,  485,  733,  482,  110,
			  110,  366,  484,  487,  481,  489,  481,  365,  488,  486,
			  110,  491,  110,  492,  493,  495,  483,  110,  497,  477,
			  115,  490,  494,  194,  110,  498,  102,  194,  485,  194,
			  483,  115,  115,  499,  485,  487,  501,  489,  503,  110,
			  489,  487,  115,  491,  115,  493,  493,  495,  496,  115,

			  497,  110,  110,  491,  495,  505,  115,  499,  110,  507,
			  500,  504,  508,  502,  110,  499,  110,  509,  501,  110,
			  503,  115,  511,  506,  110,  512,  513,  514,  515,  110,
			  497,  510,  110,  115,  115,  517,  519,  505,  521,  523,
			  115,  507,  501,  505,  509,  503,  115,  516,  115,  509,
			  110,  115,  525,  110,  511,  507,  115,  513,  513,  515,
			  515,  115,  518,  511,  115,  520,  110,  517,  519,  110,
			  521,  523,  110,  110,  110,  522,  524,  526,  527,  517,
			  110,  110,  115,  529,  525,  115,  530,  531,  533,  110,
			  110,  110,  535,  528,  519,  534,  536,  521,  115,  532,

			  537,  115,  110,  539,  115,  115,  115,  523,  525,  527,
			  527,  541,  115,  115,  538,  529,  543,  110,  531,  531,
			  533,  115,  115,  115,  535,  529,  110,  535,  537,  540,
			  544,  533,  537,  542,  115,  539,  110,  545,  110,  547,
			  549,  110,  110,  541,  110,  551,  539,  546,  543,  115,
			  550,  548,  110,  110,  553,  555,  110,  557,  115,  554,
			  110,  541,  545,  110,  552,  543,  733,  556,  115,  545,
			  115,  547,  549,  115,  115,  110,  115,  551,  733,  547,
			  561,  561,  551,  549,  115,  115,  553,  555,  115,  557,
			   85,  555,  115,  334,  733,  115,  553,  468,  468,  557,

			  562,  562,   89,  558,  558,  563,  563,  115,  110,  560,
			  564,  564,  474,  474,  565,  565,  567,  567,  470,  568,
			  568,  110,  365,  569,  569,  564,  564,  571,  110,  194,
			  194,  110,  573,  110,  574,  733,  579,  570,  575,  576,
			  115,  560,  572,  577,  110,  110,  110,  581,  366,  578,
			  583,  585,  566,  115,  365,  580,  582,  477,  584,  110,
			  115,  587,  110,  115,  573,  115,  576,  103,  579,  570,
			  577,  576,  589,  110,  573,  577,  115,  115,  115,  581,
			  586,  579,  583,  585,  588,  110,  591,  581,  583,  110,
			  585,  115,  110,  587,  115,  593,  110,  590,  110,  595,

			  597,  594,  596,  598,  589,  115,  110,  592,  599,  600,
			  601,  603,  587,  602,  604,  605,  589,  115,  591,  110,
			  110,  115,  606,  607,  115,  609,  110,  593,  115,  591,
			  115,  595,  597,  595,  597,  599,  610,  611,  115,  593,
			  599,  601,  601,  603,  110,  603,  605,  605,  613,  615,
			  617,  115,  115,  608,  607,  607,  612,  609,  115,  614,
			  110,  110,  618,  110,  619,  621,  110,  110,  611,  611,
			  616,  110,  110,  623,  625,  110,  115,  626,  620,  624,
			  613,  615,  617,  622,  627,  609,  628,  110,  613,  629,
			  110,  615,  115,  115,  619,  115,  619,  621,  115,  115,

			  110,  631,  617,  115,  115,  623,  625,  115,  110,  627,
			  621,  625,  635,  630,   85,  623,  627,  334,  629,  115,
			  733,  629,  115,  632,  733,  632,   89,  733,  633,  633,
			  633,  633,  115,  631,  634,  634,  564,  564,  228,  647,
			  115,  637,  637,  110,  635,  631,  638,  638,  636,  639,
			  639,  640,  640,  641,  641,  642,  110,  642,  644,  644,
			  640,  640,  649,  110,  651,  110,  653,  646,  470,  648,
			  645,  647,  110,  652,  110,  115,  650,  110,  654,  566,
			  636,  655,  110,  110,  656,  657,  658,  659,  115,  477,
			  110,  110,  110,  110,  649,  115,  651,  115,  653,  647,

			  661,  649,  645,  660,  115,  653,  115,  110,  651,  115,
			  655,  663,  662,  655,  115,  115,  657,  657,  659,  659,
			  110,  665,  115,  115,  115,  115,  110,  667,  668,  669,
			  110,  664,  661,  671,  673,  661,  110,  666,  110,  115,
			  110,  670,  675,  663,  663,  674,  110,  677,  672,  110,
			  678,  676,  115,  665,  110,  679,  110,  110,  115,  667,
			  669,  669,  115,  665,  110,  671,  673,  681,  115,  667,
			  115,  110,  115,  671,  675,  683,  682,  675,  115,  677,
			  673,  115,  679,  677,  110,  110,  115,  679,  115,  115,
			  110,  685,  633,  633,  692,  680,  115,  633,  633,  681,

			  110,  684,  733,  115,  686,  686,  698,  683,  683,  687,
			  110,  687,  690,  690,  688,  688,  115,  115,  733,  689,
			  366,  689,  115,  685,  690,  690,  692,  681,  691,  691,
			  640,  640,  115,  685,  693,  693,  640,  640,  698,  694,
			  694,  695,  115,  695,  110,  733,  696,  696,  699,  697,
			  566,  692,  700,  110,  701,  702,  704,  110,  110,  110,
			  703,  110,  705,  706,  110,  110,  110,  110,  708,  709,
			  710,  733,  707,  110,  712,  713,  115,  366,  714,  110,
			  700,  698,  733,  692,  700,  115,  702,  702,  704,  115,
			  115,  115,  704,  115,  706,  706,  115,  115,  115,  115,

			  708,  710,  710,  110,  708,  115,  712,  714,  715,  711,
			  714,  115,  716,  110,  110,  717,  718,  719,  720,  110,
			  110,  110,  688,  688,  721,  721,  690,  690,  690,  690,
			  722,  722,  723,  110,  723,  115,  110,  724,  724,  110,
			  716,  712,  639,  639,  716,  115,  115,  718,  718,  720,
			  720,  115,  115,  115,  692,  696,  696,  725,  725,  110,
			  110,  110,  470,  733,  727,  115,  110,  110,  115,  729,
			  110,  115,  726,  730,  731,  110,  728,  110,  110,  110,
			  366,  686,  686,  724,  724,  110,  692,  732,  732,  693,
			  693,  115,  115,  115,  110,  477,  727,  733,  115,  115,

			  733,  729,  115,  733,  727,  731,  731,  115,  729,  115,
			  115,  115,  722,  722,  733,  733,  733,  115,  733,  470,
			  115,  115,  115,  115,  115,  566,  115,  477,   84,   84,
			  733,   84,   84,   84,   84,   84,   84,   84,   84,   84,
			   84,  733,  733,  733,  733,   88,  733,  733,  733,  733,
			  566,   88,   88,   88,   88,   88,   88,   88,   89,   89,
			  733,   89,   89,   89,   89,   89,   89,   89,   89,   89,
			   89,   90,   90,  733,   90,   90,   90,   90,   90,   90,
			   90,   90,   90,   90,   79,   79,  733,   79,   79,  733,
			   79,   79,   79,   79,   79,   79,   79,  195,  195,  733,

			  195,  195,  733,  733,  195,  195,  195,  195,  195,  195,
			  196,  196,  733,  196,  196,  196,  196,  196,  196,  196,
			  196,  196,  196,  202,  202,  733,  202,  202,  202,  202,
			  202,  202,  202,  202,  202,  202,  229,  229,  229,  229,
			  229,  229,  229,  733,  229,  229,  229,  229,  229,  643,
			  643,  643,  643,  643,  643,  643,  733,  643,  643,  643,
			  643,  643,    3,  733,  733,  733,  733,  733,  733,  733,
			  733,  733,  733,  733,  733,  733,  733,  733,  733,  733,
			  733,  733,  733,  733,  733,  733,  733,  733,  733,  733,
			  733,  733,  733,  733,  733,  733,  733,  733,  733,  733,

			  733,  733,  733,  733,  733,  733,  733,  733,  733,  733,
			  733,  733,  733,  733,  733,  733,  733,  733,  733,  733,
			  733,  733,  733,  733,  733,  733,  733,  733,  733,  733,
			  733,  733,  733,  733,  733,  733,  733,  733,  733,  733,
			  733,  733,  733,  733,  733,  733,  733,  733,  733,  733>>)
		end

	yy_chk_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
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
			    1,    1,    1,    1,    1,    1,    1,    1,    5,  722,
			    5,    5,    7,   37,    7,    7,    8,   10,    8,    8,

			   10,   13,   14,   14,   13,   20,   21,   22,   21,   21,
			   27,   27,  693,   22,   20,   23,   43,   23,   23,   24,
			   43,   24,   24,   29,   29,   37,   23,   54,   54,  686,
			   46,   48,   48,   89,   57,   46,   89,  196,  197,  467,
			  196,  197,    5,  225,   10,  224,    7,  223,   43,  222,
			    8,  221,   43,  220,  101,   23,  101,  101,   23,   24,
			   31,   31,   46,   48,   48,   54,   57,   46,   31,   31,
			   31,   31,   31,   31,   31,   31,   31,   31,   31,   31,
			   31,   31,   31,   31,   31,   31,   31,   31,   31,   31,
			   31,   31,   31,   31,  101,  219,   65,   67,   31,   68,

			   31,   31,   31,   31,   31,   31,   31,   31,   31,   31,
			   31,   31,   31,   31,   31,   31,   31,   31,   31,   31,
			   31,   31,   31,   31,   31,   31,   32,   32,   65,   67,
			   71,   68,  218,   73,   32,   32,   32,   32,   32,   32,
			   32,   32,   32,   32,   32,   32,   32,   32,   32,   32,
			   32,   32,   32,   32,   32,   32,   32,   32,   32,   32,
			  209,  209,   71,   74,   32,   73,   32,   32,   32,   32,
			   32,   32,   32,   32,   32,   32,   32,   32,   32,   32,
			   32,   32,   32,   32,   32,   32,   32,   32,   32,   32,
			   32,   32,   33,   33,   34,   74,   33,  217,   34,   33,

			  110,   39,   33,   35,   34,   33,   35,   39,   35,   40,
			   42,  114,   36,  116,   38,   40,   36,   38,   35,   42,
			   36,   38,   38,  216,   33,   33,   34,   38,   33,   36,
			   34,   33,  110,   39,   33,   35,   34,   33,   35,   39,
			   35,   40,   42,  114,   36,  116,   38,   40,   36,   38,
			   35,   42,   36,   38,   38,   41,   45,   45,   69,   38,
			   44,   36,   41,   49,   44,   41,   45,   41,   47,   49,
			   59,   41,   56,   69,  111,   44,   47,   56,  111,   56,
			   59,  215,   47,  198,   56,  214,  198,   41,   45,   45,
			   69,  213,   44,  212,   41,   49,   44,   41,   45,   41,

			   47,   49,   59,   41,   56,   69,  111,   44,   47,   56,
			  111,   56,   59,   58,   47,   72,   56,   58,   61,   60,
			   58,   60,   61,   58,   64,   63,   58,   66,  118,   72,
			   64,   60,   63,   63,   70,   61,  211,   66,   63,   66,
			  103,  103,  121,   66,   70,   58,  210,   72,  208,   58,
			   61,   60,   58,   60,   61,   58,   64,   63,   58,   66,
			  118,   72,   64,   60,   63,   63,   70,   61,  113,   66,
			   63,   66,  207,  113,  121,   66,   70,   77,  103,   77,
			   77,   78,  206,   78,   78,   81,  127,   81,   81,   82,
			   84,   82,   82,   84,   87,  112,   87,   87,  112,   87,

			  113,  117,   87,  205,  117,  113,  128,   96,   96,   99,
			   99,  204,  100,  200,  100,  100,  200,  334,  127,   96,
			  334,   99,  122,  100,  228,  228,  122,  112,  129,  335,
			  112,   77,  335,  117,  195,   78,  117,   84,  128,   81,
			   90,  130,  131,   82,   86,   96,   87,   86,   86,   86,
			   86,   96,  100,   99,  122,  100,   86,  120,  122,   80,
			  129,   86,  133,   86,  124,   86,   86,   86,  120,  124,
			   86,  125,   86,  130,  131,  125,   86,   79,   86,   52,
			  123,   86,   86,   86,   86,   86,   86,   91,  123,  120,
			   91,   91,   91,   91,  133,   51,  124,   30,  134,   91,

			  120,  124,  134,  125,   91,  126,   91,  125,   91,   91,
			   91,   91,  123,   91,  126,   91,  139,  145,  137,   91,
			  123,   91,  136,  137,   91,   91,   91,   91,   91,   91,
			  134,  132,  136,  137,  134,  132,  138,  126,  132,  142,
			  141,  140,  142,  138,  141,  143,  126,  138,  139,  145,
			  137,  144,  146,  143,  136,  137,  140,  144,  147,  148,
			  151,  153,  149,  132,  136,  137,   25,  132,  138,  149,
			  132,  142,  141,  140,  142,  138,  141,  143,    9,  138,
			  158,    6,  150,  144,  146,  143,  150,  150,  140,  144,
			  147,  148,  151,  153,  149,  154,  156,  150,  156,  154,

			  150,  149,  161,  157,  159,  165,  160,    3,  166,  157,
			  154,  162,  158,  154,  150,  157,  159,  160,  150,  150,
			  163,  162,  167,  168,  171,  163,  177,  154,  156,  150,
			  156,  154,  150,  164,  161,  157,  159,  165,  160,  164,
			  166,  157,  154,  162,    0,  154,  170,  157,  159,  160,
			  170,    0,  163,  162,  167,  168,  171,  163,  177,  175,
			  173,    0,  173,  180,    0,  164,  361,  361,  175,    0,
			  173,  164,  181,  173,  174,  173,  173,  174,  170,  185,
			  176,  174,  170,  172,  176,  172,  178,    0,  172,  179,
			  178,  175,  173,  172,  173,  180,  172,  186,  172,  172,

			  175,  179,  173,    0,  181,  173,  174,  173,  173,  174,
			  187,  185,  176,  174,  184,  172,  176,  172,  178,  182,
			  172,  179,  178,  184,  182,  172,  189,  183,  172,  186,
			  172,  172,  183,  179,  188,  182,  190,  191,  188,    0,
			  194,  194,  187,  183,    0,  190,  184,  199,    0,  236,
			  199,  182,    0,  226,  226,  184,  182,    0,  189,  183,
			  199,  199,  238,    0,  183,  226,  188,  182,  190,  191,
			  188,  201,    0,  201,  201,  183,  201,  190,  194,  201,
			  227,  236,  227,  230,  230,  227,  227,  231,  239,  231,
			  242,  226,  231,  231,  238,  230,  232,  226,  232,  232,

			  233,  235,  233,  233,  234,  234,  235,  232,    0,  237,
			    0,  244,  241,  245,  243,  246,  248,  237,  241,  249,
			  239,  230,  242,  201,  243,  250,  245,  230,  249,  247,
			  252,  253,    0,  235,  252,  254,  232,  247,  235,  232,
			  233,  237,  234,  244,  241,  245,  243,  246,  248,  237,
			  241,  249,  251,  256,  257,  255,  243,  250,  245,  255,
			  249,  247,  252,  253,  251,  258,  252,  254,  260,  247,
			  264,  262,  266,  265,  261,  262,  263,  258,  267,  268,
			    0,  270,  261,  265,  251,  256,  257,  255,  261,  267,
			  263,  255,  272,    0,  270,  269,  251,  258,  271,  269,

			  260,  271,  264,  262,  266,  265,  261,  262,  263,  258,
			  267,  268,  269,  270,  261,  265,  277,  278,  279,  273,
			  261,  267,  263,  273,  272,  274,  270,  269,  275,  274,
			  271,  269,  276,  271,  280,  275,  282,  281,  283,  285,
			  276,  281,  286,  287,  269,  284,  283,  289,  277,  278,
			  279,  273,  284,  289,  290,  273,  291,  274,  293,  294,
			  275,  274,  293,  296,  276,    0,  280,  275,  282,  281,
			  283,  285,  276,  281,  286,  287,  295,  284,  283,  289,
			  303,  304,  295,  297,  284,  289,  290,  297,  291,  298,
			  293,  294,  299,  298,  293,  296,  302,  300,  301,  305,

			  299,  306,  307,  308,  301,  302,  309,  311,  295,  300,
			  309,  312,  303,  304,  295,  297,  301,  313,  310,  297,
			  307,  298,  314,  316,  299,  298,  310,  318,  302,  300,
			  301,  305,  299,  306,  307,  308,  301,  302,  309,  311,
			  315,  300,  309,  312,  321,  315,  322,  317,  301,  313,
			  310,  317,  307,  319,  314,  316,  320,  319,  310,  318,
			  323,  324,  325,  326,  320,  327,  328,  330,  329,  331,
			  327,    0,  315,  329,  360,  360,  321,  315,  322,  317,
			  343,  343,  343,  317,  337,  319,  360,  337,  320,  319,
			  362,  362,  323,  324,  325,  326,  320,  327,  328,  330,

			  329,  331,  327,  336,    0,  329,  336,    0,  337,  363,
			  363,  372,  360,  364,  364,  336,  336,  336,  360,  366,
			  366,  365,  372,  365,  373,  364,  365,  365,  362,  367,
			  367,  368,  368,  369,  375,  369,  369,  370,  374,  370,
			  370,  371,  371,  372,  369,    0,  377,    0,  374,  378,
			  376,  364,  376,  379,  372,  381,  373,  364,  380,  378,
			  382,  383,  380,  384,  385,  387,  375,  384,  389,  368,
			  374,  382,  386,  369,  386,  390,  369,  370,  377,  371,
			  374,  378,  376,  391,  376,  379,  393,  381,  396,  388,
			  380,  378,  382,  383,  380,  384,  385,  387,  388,  384,

			  389,  392,  395,  382,  386,  397,  386,  390,  394,  399,
			  392,  395,  400,  394,  398,  391,  400,  401,  393,  402,
			  396,  388,  403,  398,  404,  405,  407,  408,  409,  405,
			  388,  402,  410,  392,  395,  411,  413,  397,  415,  417,
			  394,  399,  392,  395,  400,  394,  398,  410,  400,  401,
			  418,  402,  421,  412,  403,  398,  404,  405,  407,  408,
			  409,  405,  412,  402,  410,  414,  416,  411,  413,  414,
			  415,  417,  422,  420,  424,  416,  420,  424,  425,  410,
			  426,  428,  418,  429,  421,  412,  430,  431,  433,  430,
			  432,  434,  435,  428,  412,  434,  436,  414,  416,  432,

			  437,  414,  438,  440,  422,  420,  424,  416,  420,  424,
			  425,  441,  426,  428,  438,  429,  443,  442,  430,  431,
			  433,  430,  432,  434,  435,  428,  439,  434,  436,  439,
			  444,  432,  437,  442,  438,  440,  444,  445,  446,  447,
			  449,  450,  452,  441,  448,  455,  438,  446,  443,  442,
			  454,  448,  456,  454,  457,  459,  458,  461,  439,  458,
			  462,  439,  444,  464,  456,  442,    0,  460,  444,  445,
			  446,  447,  449,  450,  452,  460,  448,  455,    0,  446,
			  469,  469,  454,  448,  456,  454,  457,  459,  458,  461,
			  466,  458,  462,  466,    0,  464,  456,  468,  468,  460,

			  470,  470,  466,  466,  466,  471,  471,  460,  480,  468,
			  472,  472,  473,  473,  474,  474,  475,  475,  469,  476,
			  476,  482,  472,  477,  477,  478,  478,  479,  484,  479,
			  479,  486,  489,  488,  490,    0,  493,  478,  490,  491,
			  480,  468,  488,  491,  492,  494,  496,  497,  472,  492,
			  499,  501,  474,  482,  472,  496,  498,  476,  500,  498,
			  484,  503,  500,  486,  489,  488,  490,  479,  493,  478,
			  490,  491,  505,  504,  488,  491,  492,  494,  496,  497,
			  502,  492,  499,  501,  504,  502,  507,  496,  498,  508,
			  500,  498,  506,  503,  500,  511,  512,  506,  510,  513,

			  515,  512,  514,  516,  505,  504,  514,  510,  517,  518,
			  519,  521,  502,  520,  522,  523,  504,  502,  507,  520,
			  524,  508,  526,  527,  506,  529,  526,  511,  512,  506,
			  510,  513,  515,  512,  514,  516,  530,  531,  514,  510,
			  517,  518,  519,  521,  528,  520,  522,  523,  533,  535,
			  537,  520,  524,  528,  526,  527,  532,  529,  526,  534,
			  532,  536,  538,  534,  539,  541,  538,  540,  530,  531,
			  536,  542,  544,  545,  547,  548,  528,  550,  540,  546,
			  533,  535,  537,  544,  551,  528,  552,  546,  532,  553,
			  552,  534,  532,  536,  538,  534,  539,  541,  538,  540,

			  554,  557,  536,  542,  544,  545,  547,  548,  556,  550,
			  540,  546,  563,  556,  558,  544,  551,  558,  552,  546,
			    0,  553,  552,  560,    0,  560,  558,    0,  560,  560,
			  561,  561,  554,  557,  562,  562,  564,  564,  563,  573,
			  556,  565,  565,  574,  563,  556,  566,  566,  564,  567,
			  567,  568,  568,  569,  569,  570,  572,  570,  571,  571,
			  570,  570,  577,  575,  579,  578,  581,  572,  561,  575,
			  571,  573,  582,  580,  584,  574,  578,  580,  586,  565,
			  564,  587,  586,  588,  590,  591,  592,  593,  572,  568,
			  592,  594,  590,  596,  577,  575,  579,  578,  581,  572,

			  597,  575,  571,  596,  582,  580,  584,  598,  578,  580,
			  586,  599,  598,  587,  586,  588,  590,  591,  592,  593,
			  600,  601,  592,  594,  590,  596,  602,  603,  604,  605,
			  606,  600,  597,  607,  609,  596,  604,  602,  608,  598,
			  610,  606,  611,  599,  598,  610,  612,  613,  608,  614,
			  616,  612,  600,  601,  616,  617,  618,  620,  602,  603,
			  604,  605,  606,  600,  622,  607,  609,  625,  604,  602,
			  608,  626,  610,  606,  611,  627,  626,  610,  612,  613,
			  608,  614,  616,  612,  624,  628,  616,  617,  618,  620,
			  630,  631,  632,  632,  639,  624,  622,  633,  633,  625,

			  646,  630,    0,  626,  634,  634,  649,  627,  626,  635,
			  650,  635,  637,  637,  635,  635,  624,  628,    0,  636,
			  639,  636,  630,  631,  636,  636,  639,  624,  638,  638,
			  640,  640,  646,  630,  641,  641,  642,  642,  649,  644,
			  644,  645,  650,  645,  648,    0,  645,  645,  652,  648,
			  637,  644,  653,  652,  654,  655,  657,  656,  658,  654,
			  656,  660,  662,  663,  662,  664,  666,  668,  669,  670,
			  671,    0,  668,  670,  673,  674,  648,  644,  675,  674,
			  652,  648,    0,  644,  653,  652,  654,  655,  657,  656,
			  658,  654,  656,  660,  662,  663,  662,  664,  666,  668,

			  669,  670,  671,  672,  668,  670,  673,  674,  676,  672,
			  675,  674,  677,  678,  676,  680,  681,  682,  683,  680,
			  684,  682,  687,  687,  688,  688,  689,  689,  690,  690,
			  691,  691,  692,  697,  692,  672,  699,  692,  692,  701,
			  676,  672,  694,  694,  677,  678,  676,  680,  681,  682,
			  683,  680,  684,  682,  694,  695,  695,  696,  696,  703,
			  705,  707,  688,    0,  708,  697,  709,  711,  699,  712,
			  713,  701,  707,  715,  716,  717,  711,  715,  719,  726,
			  694,  721,  721,  723,  723,  728,  694,  724,  724,  725,
			  725,  703,  705,  707,  730,  696,  708,    0,  709,  711,

			    0,  712,  713,    0,  707,  715,  716,  717,  711,  715,
			  719,  726,  732,  732,    0,    0,    0,  728,    0,  721,
			  740,  740,  740,  740,  740,  724,  730,  725,  734,  734,
			    0,  734,  734,  734,  734,  734,  734,  734,  734,  734,
			  734,    0,    0,    0,    0,  735,    0,    0,    0,    0,
			  732,  735,  735,  735,  735,  735,  735,  735,  736,  736,
			    0,  736,  736,  736,  736,  736,  736,  736,  736,  736,
			  736,  737,  737,    0,  737,  737,  737,  737,  737,  737,
			  737,  737,  737,  737,  738,  738,    0,  738,  738,    0,
			  738,  738,  738,  738,  738,  738,  738,  739,  739,    0,

			  739,  739,    0,    0,  739,  739,  739,  739,  739,  739,
			  741,  741,    0,  741,  741,  741,  741,  741,  741,  741,
			  741,  741,  741,  742,  742,    0,  742,  742,  742,  742,
			  742,  742,  742,  742,  742,  742,  743,  743,  743,  743,
			  743,  743,  743,    0,  743,  743,  743,  743,  743,  744,
			  744,  744,  744,  744,  744,  744,    0,  744,  744,  744,
			  744,  744,  733,  733,  733,  733,  733,  733,  733,  733,
			  733,  733,  733,  733,  733,  733,  733,  733,  733,  733,
			  733,  733,  733,  733,  733,  733,  733,  733,  733,  733,
			  733,  733,  733,  733,  733,  733,  733,  733,  733,  733,

			  733,  733,  733,  733,  733,  733,  733,  733,  733,  733,
			  733,  733,  733,  733,  733,  733,  733,  733,  733,  733,
			  733,  733,  733,  733,  733,  733,  733,  733,  733,  733,
			  733,  733,  733,  733,  733,  733,  733,  733,  733,  733,
			  733,  733,  733,  733,  733,  733,  733,  733,  733,  733>>)
		end

	yy_base_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,  707, 2262,   86,  678,   90,   94,  672,
			   90,    0, 2262,   94,   92, 2262, 2262, 2262, 2262, 2262,
			   88,   88,   88,   97,  101,  641, 2262,   86, 2262,   98,
			  572,  140,  206,  257,  262,  267,  284,   57,  281,  265,
			  273,  326,  274,   84,  328,  321,   94,  340,   96,  327,
			 2262,  540,  572, 2262,  107,    0,  338,   98,  378,  338,
			  380,  390,    0,  392,  388,  154,  398,  152,  167,  326,
			  399,  189,  387,  198,  221, 2262, 2262,  475,  479,  570,
			  556,  483,  487, 2262,  483, 2262,  537,  492,    0,  126,
			  529,  580,    0, 2262, 2262, 2262,  487, 2262, 2262,  489,

			  494,  136, 2262,  420, 2262, 2262, 2262, 2262, 2262, 2262,
			  264,  342,  459,  437,  275,    0,  281,  465,  397,    0,
			  521,  395,  490,  552,  528,  539,  569,  454,  478,  487,
			  509,  497,  602,  526,  569,    0,  586,  587,  600,  570,
			  610,  597,  603,  617,  615,  578,  624,  616,  623,  626,
			  651,  624,    0,  618,  664,    0,  660,  673,  642,  674,
			  670,  655,  675,  689,  703,  669,  662,  691,  693,    0,
			  714,  692,  752,  729,  738,  723,  741,  681,  754,  753,
			  731,  724,  788,  796,  778,  743,  752,  774,  802,  794,
			  800,  792, 2262, 2262,  820,  523,  130,  131,  376,  840,

			  506,  869, 2262, 2262,  500,  492,  471,  461,  437,  240,
			  435,  425,  382,  380,  374,  370,  312,  286,  221,  184,
			  142,  140,  138,  136,  134,  132,  833,  865,  504, 2262,
			  863,  872,  878,  882,  884,  865,  808,  881,  826,  860,
			    0,  882,  860,  878,  865,  877,  866,  901,  888,  883,
			  880,  916,  898,  883,  903,  923,  921,  918,  929,    0,
			  920,  946,  939,  948,  938,  937,  926,  942,  932,  959,
			  941,  962,  953,  987,  993,  992, 1004,  984,  985,  975,
			 1006, 1005, 1004, 1010, 1009, 1011,  999, 1007,    0, 1011,
			 1012, 1020,    0, 1026, 1027, 1046, 1033, 1051, 1057, 1064,

			 1061, 1068, 1060, 1048, 1049, 1071, 1053, 1072, 1058, 1074,
			 1090, 1075, 1083, 1081, 1086, 1104, 1082, 1115, 1095, 1121,
			 1120, 1108, 1114, 1116, 1125, 1126, 1127, 1134, 1135, 1132,
			 1126, 1133,    0, 2262,  510,  522, 1196, 1177, 2262, 2262,
			 2262, 2262, 2262, 1161, 2262, 2262, 2262, 2262, 2262, 2262,
			 2262, 2262, 2262, 2262, 2262, 2262, 2262, 2262, 2262, 2262,
			 1154,  746, 1170, 1189, 1193, 1206, 1199, 1209, 1211, 1215,
			 1219, 1221, 1175, 1177, 1202, 1188, 1214, 1208, 1213, 1207,
			 1226, 1223, 1224, 1214, 1231, 1232, 1238, 1231, 1253, 1223,
			 1239, 1247, 1265, 1241, 1272, 1266, 1247, 1260, 1278, 1264,

			 1280, 1285, 1283, 1274, 1288, 1293,    0, 1294, 1291, 1292,
			 1296, 1284, 1317, 1291, 1333, 1306, 1330, 1294, 1314,    0,
			 1337, 1313, 1336,    0, 1338, 1339, 1344,    0, 1345, 1335,
			 1353, 1354, 1354, 1343, 1355, 1352, 1360, 1364, 1366, 1390,
			 1355, 1372, 1381, 1364, 1400, 1407, 1402, 1394, 1408, 1397,
			 1405,    0, 1406,    0, 1417, 1412, 1416, 1406, 1420, 1416,
			 1439, 1429, 1424,    0, 1427,    0, 1483,  128, 1477, 1460,
			 1480, 1485, 1490, 1492, 1494, 1496, 1499, 1503, 1505, 1509,
			 1472,    0, 1485,    0, 1492,    0, 1495,    0, 1497, 1487,
			 1502, 1507, 1508, 1495, 1509,    0, 1510, 1502, 1523, 1517,

			 1526, 1519, 1549, 1530, 1537, 1525, 1556, 1545, 1553,    0,
			 1562, 1550, 1560, 1558, 1570, 1568, 1567, 1572, 1573, 1574,
			 1583, 1581, 1578, 1579, 1584,    0, 1590, 1591, 1608, 1580,
			 1600, 1601, 1624, 1616, 1627, 1617, 1625, 1605, 1630, 1632,
			 1631, 1618, 1635,    0, 1636, 1626, 1651, 1646, 1639,    0,
			 1641, 1648, 1654, 1657, 1664,    0, 1672, 1660, 1707, 2262,
			 1708, 1710, 1714, 1680, 1716, 1721, 1726, 1729, 1731, 1733,
			 1740, 1738, 1720, 1692, 1707, 1727,    0, 1720, 1729, 1717,
			 1741, 1734, 1736,    0, 1738,    0, 1746, 1749, 1747,    0,
			 1756, 1757, 1754, 1755, 1755,    0, 1757, 1754, 1771, 1770,

			 1784, 1774, 1790, 1780, 1800, 1801, 1794, 1786, 1802, 1788,
			 1804, 1801, 1810, 1806, 1813,    0, 1818, 1823, 1820,    0,
			 1821,    0, 1828,    0, 1848, 1820, 1835, 1834, 1849,    0,
			 1854, 1844, 1872, 1877, 1884, 1894, 1904, 1892, 1908, 1862,
			 1910, 1914, 1916, 2262, 1919, 1926, 1864,    0, 1908, 1865,
			 1874,    0, 1917, 1921, 1923, 1924, 1921, 1917, 1922,    0,
			 1925,    0, 1928, 1929, 1929,    0, 1930,    0, 1931, 1927,
			 1937, 1938, 1967, 1932, 1943, 1946, 1978, 1982, 1977,    0,
			 1983, 1984, 1985, 1986, 1984,    0,   71, 2002, 2004, 2006,
			 2008, 2010, 2017,   54, 2022, 2035, 2037, 1997,    0, 2000,

			    0, 2003,    0, 2023,    0, 2024,    0, 2025, 2017, 2030,
			    0, 2031, 2024, 2034,    0, 2041, 2042, 2039,    0, 2042,
			    0, 2061,   31, 2063, 2067, 2069, 2043,    0, 2049,    0,
			 2058,    0, 2092, 2262, 2127, 2144, 2157, 2170, 2183, 2196,
			 2111, 2209, 2222, 2235, 2248>>)
		end

	yy_def_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,  733,    1,  733,  733,  733,  733,  733,  733,  733,
			  734,  735,  733,  736,  737,  733,  733,  733,  733,  733,
			  733,  733,  733,  733,  733,  733,  733,  733,  733,  733,
			  733,  733,  733,   32,   32,   32,   32,   32,   32,   32,
			   32,   32,   32,   32,   32,   32,   32,   32,   32,   32,
			  733,  733,  738,  733,  733,  739,  740,  740,  740,  740,
			  740,  740,  740,  740,  740,  740,  740,  740,  740,  740,
			  740,  740,  740,  740,  740,  733,  733,  733,  733,  738,
			  733,  733,  733,  733,  734,  733,  741,  734,  735,  736,
			  742,  742,  742,  733,  733,  733,  733,  733,  733,  743,

			  733,  733,  733,  733,  733,  733,  733,  733,  733,  733,
			   32,   32,   32,   32,   32,  740,  740,  740,  740,  740,
			   32,  740,   32,   32,   32,   32,   32,  740,  740,  740,
			  740,  740,   32,   32,  740,  740,   32,   32,   32,  740,
			  740,  740,   32,   32,   32,  740,  740,  740,   32,   32,
			   32,   32,  740,  740,  740,  740,   32,   32,  740,  740,
			   32,  740,   32,   32,   32,   32,  740,  740,  740,  740,
			   32,  740,   32,  740,   32,   32,  740,  740,   32,   32,
			  740,  740,   32,  740,   32,   32,  740,  740,   32,  740,
			   32,  740,  733,  733,  733,  739,  741,  736,  736,  741,

			  741,  734,  733,  733,  733,  733,  733,  733,  733,  733,
			  733,  733,  733,  733,  733,  733,  733,  733,  733,  733,
			  733,  733,  733,  733,  733,  733,  733,  733,  733,  733,
			  733,  733,  733,  733,  733,   32,  740,   32,   32,  740,
			  740,   32,  740,   32,  740,   32,  740,   32,  740,   32,
			  740,   32,   32,  740,  740,   32,  740,   32,   32,  740,
			  740,   32,   32,  740,  740,   32,  740,   32,  740,   32,
			  740,   32,  740,   32,   32,   32,   32,  740,  740,  740,
			  740,   32,  740,   32,   32,  740,  740,   32,  740,   32,
			  740,   32,  740,   32,  740,   32,  740,   32,   32,   32,

			   32,   32,   32,  740,  740,  740,  740,  740,  740,   32,
			   32,  740,  740,   32,  740,   32,  740,   32,  740,   32,
			   32,   32,  740,  740,  740,   32,  740,   32,  740,   32,
			  740,   32,  740,  733,  741,  741,  741,  741,  733,  733,
			  733,  733,  733,  733,  733,  733,  733,  733,  733,  733,
			  733,  733,  733,  733,  733,  733,  733,  733,  733,  733,
			  733,  733,  733,  733,  733,  733,  733,  733,  733,  733,
			  733,  733,   32,  740,   32,  740,   32,  740,   32,  740,
			   32,  740,   32,  740,   32,  740,   32,  740,   32,  740,
			   32,  740,   32,  740,   32,   32,  740,  740,   32,  740,

			   32,  740,   32,  740,   32,   32,  740,  740,   32,  740,
			   32,  740,   32,  740,   32,  740,   32,  740,   32,  740,
			   32,  740,   32,  740,   32,  740,   32,  740,   32,  740,
			   32,  740,   32,  740,   32,  740,   32,  740,   32,   32,
			  740,  740,   32,  740,   32,  740,   32,  740,   32,  740,
			   32,  740,   32,  740,   32,  740,   32,  740,   32,  740,
			   32,  740,   32,  740,   32,  740,  741,  733,  733,  733,
			  733,  733,  733,  733,  733,  733,  733,  733,  743,  733,
			   32,  740,   32,  740,   32,  740,   32,  740,   32,  740,
			   32,  740,   32,  740,   32,  740,   32,  740,   32,  740,

			   32,  740,   32,  740,   32,  740,   32,  740,   32,  740,
			   32,  740,   32,  740,   32,  740,   32,  740,   32,  740,
			   32,  740,   32,  740,   32,  740,   32,  740,   32,  740,
			   32,  740,   32,  740,   32,  740,   32,  740,   32,  740,
			   32,  740,   32,  740,   32,  740,   32,  740,   32,  740,
			   32,  740,   32,  740,   32,  740,   32,  740,  741,  733,
			  733,  733,  733,  733,  733,  733,  733,  733,  733,  733,
			  733,  744,   32,  740,   32,   32,  740,  740,   32,  740,
			   32,  740,   32,  740,   32,  740,   32,  740,   32,  740,
			   32,  740,   32,  740,   32,  740,   32,  740,   32,  740,

			   32,  740,   32,  740,   32,  740,   32,  740,   32,  740,
			   32,  740,   32,  740,   32,  740,   32,  740,   32,  740,
			   32,  740,   32,  740,   32,  740,   32,  740,   32,  740,
			   32,  740,  733,  733,  733,  733,  733,  733,  733,  733,
			  733,  733,  733,  733,  733,  733,   32,  740,   32,  740,
			   32,  740,   32,  740,   32,  740,   32,  740,   32,  740,
			   32,  740,   32,  740,   32,  740,   32,  740,   32,  740,
			   32,  740,   32,  740,   32,  740,   32,  740,   32,  740,
			   32,  740,   32,  740,   32,  740,  733,  733,  733,  733,
			  733,  733,  733,  733,  733,  733,  733,   32,  740,   32,

			  740,   32,  740,   32,  740,   32,  740,   32,  740,   32,
			  740,   32,  740,   32,  740,   32,  740,   32,  740,   32,
			  740,  733,  733,  733,  733,  733,   32,  740,   32,  740,
			   32,  740,  733,    0,  733,  733,  733,  733,  733,  733,
			  733,  733,  733,  733,  733>>)
		end

	yy_ec_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,    1,    1,    1,    1,    1,    1,    1,    1,    2,
			    3,    1,    1,    4,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    5,    6,    7,    8,    9,   10,    8,   11,
			   12,   13,   14,   15,   16,   17,   18,   19,   20,   20,
			   21,   21,   21,   21,   21,   21,   21,   21,   22,   23,
			   24,   25,   26,   27,    8,   28,   29,   30,   31,   32,
			   33,   34,   35,   36,   37,   38,   39,   40,   41,   42,
			   43,   44,   45,   46,   47,   48,   49,   50,   51,   52,
			   53,   54,   55,   56,   57,   58,   59,   60,   61,   62,

			   63,   64,   65,   66,   67,   68,   69,   70,   71,   72,
			   73,   74,   75,   76,   77,   78,   79,   80,   81,   82,
			   83,   84,   85,   86,    8,   87,    1,    1,    1,    1,
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
			    1,    1,    1,    1,    1,    1,    1>>)
		end

	yy_meta_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,    1,    2,    3,    2,    4,    1,    5,    1,    1,
			    6,    7,    1,    1,    1,    1,    1,    1,    8,    1,
			    9,   10,    1,    1,    1,    1,    1,    1,    9,    9,
			    9,    9,    9,    9,    9,    9,    9,    9,    9,    9,
			    9,    9,    9,    9,    9,    9,    9,    9,    9,    9,
			    9,    9,    9,   11,    1,    1,    1,    1,   12,    1,
			    9,    9,    9,    9,    9,    9,    9,    9,    9,    9,
			    9,    9,    9,    9,    9,    9,    9,    9,    9,    9,
			    9,    9,    9,    9,    9,   13,    1,    1>>)
		end

	yy_accept_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,    1,    1,    1,    2,    4,    7,    9,   12,   15,
			   18,   21,   24,   27,   30,   32,   35,   38,   41,   44,
			   47,   50,   53,   56,   60,   64,   67,   70,   73,   76,
			   79,   81,   85,   89,   93,   97,  101,  105,  109,  113,
			  117,  121,  125,  129,  133,  137,  141,  145,  149,  153,
			  157,  160,  162,  165,  168,  171,  173,  176,  179,  182,
			  185,  188,  191,  194,  197,  200,  203,  206,  209,  212,
			  215,  218,  221,  224,  227,  230,  233,  236,  237,  237,
			  237,  238,  239,  240,  241,  242,  243,  244,  247,  248,
			  249,  250,  251,  252,  253,  254,  255,  257,  258,  259,

			  259,  261,  263,  264,  265,  266,  267,  268,  269,  270,
			  271,  273,  275,  277,  279,  282,  283,  284,  285,  286,
			  288,  290,  291,  293,  295,  297,  299,  301,  302,  303,
			  304,  305,  306,  308,  311,  312,  314,  316,  318,  320,
			  321,  322,  323,  325,  327,  329,  330,  331,  332,  335,
			  337,  339,  342,  344,  345,  346,  348,  350,  352,  353,
			  354,  356,  357,  359,  361,  363,  366,  367,  368,  369,
			  371,  373,  374,  376,  377,  379,  381,  382,  383,  385,
			  387,  388,  389,  391,  392,  394,  396,  397,  398,  400,
			  401,  403,  404,  405,  406,  407,  407,  407,  409,  411,

			  411,  411,  413,  414,  416,  417,  418,  419,  420,  421,
			  422,  423,  424,  425,  426,  427,  428,  429,  430,  431,
			  432,  433,  434,  435,  436,  437,  438,  440,  440,  440,
			  441,  443,  444,  446,  448,  449,  451,  452,  454,  457,
			  458,  460,  462,  463,  465,  466,  468,  469,  471,  472,
			  474,  475,  477,  479,  480,  481,  483,  484,  487,  489,
			  491,  492,  494,  496,  497,  498,  500,  501,  503,  504,
			  506,  507,  509,  510,  512,  514,  516,  518,  519,  520,
			  521,  522,  524,  525,  527,  529,  530,  531,  534,  536,
			  538,  539,  542,  544,  546,  547,  549,  550,  552,  554,

			  556,  558,  560,  562,  563,  564,  565,  566,  567,  568,
			  570,  572,  573,  574,  576,  577,  579,  580,  582,  583,
			  585,  587,  589,  590,  591,  592,  594,  595,  597,  598,
			  600,  601,  604,  606,  607,  608,  609,  609,  610,  611,
			  612,  613,  614,  615,  616,  617,  618,  619,  620,  621,
			  622,  623,  624,  625,  626,  627,  628,  629,  630,  631,
			  632,  634,  634,  636,  636,  638,  638,  638,  638,  640,
			  642,  644,  645,  647,  648,  650,  651,  653,  654,  656,
			  657,  659,  660,  662,  663,  665,  666,  668,  669,  671,
			  672,  675,  677,  679,  680,  682,  684,  685,  686,  688,

			  689,  691,  692,  694,  695,  698,  700,  702,  703,  705,
			  706,  708,  709,  711,  712,  714,  715,  717,  718,  721,
			  723,  725,  726,  729,  731,  733,  734,  737,  739,  741,
			  742,  744,  745,  747,  748,  750,  751,  753,  754,  756,
			  758,  759,  760,  762,  763,  765,  766,  768,  769,  771,
			  772,  775,  777,  780,  782,  784,  785,  787,  788,  790,
			  791,  793,  794,  797,  799,  802,  804,  804,  805,  806,
			  808,  808,  808,  810,  810,  814,  814,  816,  816,  816,
			  818,  821,  823,  826,  828,  831,  833,  836,  838,  840,
			  841,  843,  844,  846,  847,  850,  852,  854,  855,  857,

			  858,  860,  861,  863,  864,  866,  867,  869,  870,  873,
			  875,  877,  878,  880,  881,  883,  884,  886,  887,  889,
			  890,  892,  893,  895,  896,  899,  901,  903,  904,  906,
			  907,  909,  910,  912,  913,  915,  916,  918,  919,  921,
			  922,  924,  925,  928,  930,  932,  933,  935,  936,  939,
			  941,  943,  944,  946,  947,  950,  952,  954,  955,  955,
			  956,  956,  958,  958,  959,  960,  964,  964,  964,  966,
			  966,  967,  967,  969,  970,  973,  975,  977,  978,  980,
			  981,  983,  984,  987,  989,  992,  994,  996,  997, 1000,
			 1002, 1004, 1005, 1007, 1008, 1011, 1013, 1015, 1016, 1018,

			 1019, 1021, 1022, 1024, 1025, 1027, 1028, 1030, 1031, 1033,
			 1034, 1036, 1037, 1039, 1040, 1043, 1045, 1047, 1048, 1051,
			 1053, 1056, 1058, 1061, 1063, 1065, 1066, 1068, 1069, 1072,
			 1074, 1076, 1077, 1077, 1078, 1078, 1078, 1078, 1082, 1082,
			 1083, 1084, 1084, 1084, 1085, 1086, 1087, 1090, 1092, 1094,
			 1095, 1098, 1100, 1102, 1103, 1105, 1106, 1108, 1109, 1112,
			 1114, 1117, 1119, 1121, 1122, 1125, 1127, 1130, 1132, 1134,
			 1135, 1137, 1138, 1140, 1141, 1143, 1144, 1146, 1147, 1150,
			 1152, 1154, 1155, 1157, 1158, 1161, 1163, 1164, 1164, 1165,
			 1165, 1167, 1167, 1167, 1168, 1169, 1169, 1170, 1173, 1175,

			 1178, 1180, 1183, 1185, 1188, 1190, 1193, 1195, 1197, 1198,
			 1201, 1203, 1205, 1206, 1209, 1211, 1213, 1214, 1217, 1219,
			 1222, 1224, 1225, 1227, 1227, 1229, 1230, 1233, 1235, 1238,
			 1240, 1243, 1245, 1247, 1247>>)
		end

	yy_acclist_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yy_fixed_array (<<
			    0,  142,  140,  141,    3,  140,  141,    4,  141,    1,
			  140,  141,    2,  140,  141,   10,  140,  141,  128,  140,
			  141,   99,  140,  141,   17,  140,  141,  128,  140,  141,
			  140,  141,   11,  140,  141,   12,  140,  141,   31,  140,
			  141,   30,  140,  141,    8,  140,  141,   29,  140,  141,
			    6,  140,  141,   32,  140,  141,  130,  132,  140,  141,
			  130,  132,  140,  141,    9,  140,  141,    7,  140,  141,
			   36,  140,  141,   34,  140,  141,   35,  140,  141,  140,
			  141,   97,   98,  140,  141,   97,   98,  140,  141,   97,
			   98,  140,  141,   97,   98,  140,  141,   97,   98,  140,

			  141,   97,   98,  140,  141,   97,   98,  140,  141,   97,
			   98,  140,  141,   97,   98,  140,  141,   97,   98,  140,
			  141,   97,   98,  140,  141,   97,   98,  140,  141,   97,
			   98,  140,  141,   97,   98,  140,  141,   97,   98,  140,
			  141,   97,   98,  140,  141,   97,   98,  140,  141,   97,
			   98,  140,  141,   97,   98,  140,  141,   15,  140,  141,
			  140,  141,   16,  140,  141,   33,  140,  141,  132,  140,
			  141,  140,  141,   98,  140,  141,   98,  140,  141,   98,
			  140,  141,   98,  140,  141,   98,  140,  141,   98,  140,
			  141,   98,  140,  141,   98,  140,  141,   98,  140,  141,

			   98,  140,  141,   98,  140,  141,   98,  140,  141,   98,
			  140,  141,   98,  140,  141,   98,  140,  141,   98,  140,
			  141,   98,  140,  141,   98,  140,  141,   98,  140,  141,
			   13,  140,  141,   14,  140,  141,    3,    4,    1,    2,
			   37,  128,  127,  127, -125,  128, -266,   99,  128,  123,
			  123,  123,    5,   23,   24,  135,  138,   18,   20,  130,
			  132,  130,  132,  129,  132,   28,   25,   22,   21,   26,
			   27,   97,   98,   97,   98,   97,   98,   97,   98,   41,
			   97,   98,   98,   98,   98,   98,   41,   98,   97,   98,
			   98,   97,   98,   97,   98,   97,   98,   97,   98,   97,

			   98,   98,   98,   98,   98,   98,   97,   98,   50,   97,
			   98,   98,   50,   98,   97,   98,   97,   98,   97,   98,
			   98,   98,   98,   97,   98,   97,   98,   97,   98,   98,
			   98,   98,   62,   97,   98,   97,   98,   97,   98,   68,
			   97,   98,   62,   98,   98,   98,   68,   98,   97,   98,
			   97,   98,   98,   98,   97,   98,   98,   97,   98,   97,
			   98,   97,   98,   76,   97,   98,   98,   98,   98,   76,
			   98,   97,   98,   98,   97,   98,   98,   97,   98,   97,
			   98,   98,   98,   97,   98,   97,   98,   98,   98,   97,
			   98,   98,   97,   98,   97,   98,   98,   98,   97,   98,

			   98,   97,   98,   98,   19,  126,  132,  127,  128,  127,
			  128, -125,  128,  123,  100,  123,  123,  123,  123,  123,
			  123,  123,  123,  123,  123,  123,  123,  123,  123,  123,
			  123,  123,  123,  123,  123,  123,  123,  123,  135,  138,
			  133,  135,  138,  133,  130,  132,  130,  132,  132,   97,
			   98,   98,   97,   98,   40,   97,   98,   98,   40,   98,
			   97,   98,   98,   97,   98,   98,   97,   98,   98,   97,
			   98,   98,   97,   98,   98,   97,   98,   97,   98,   98,
			   98,   97,   98,   98,   53,   97,   98,   97,   98,   53,
			   98,   98,   97,   98,   97,   98,   98,   98,   97,   98,

			   98,   97,   98,   98,   97,   98,   98,   97,   98,   98,
			   97,   98,   97,   98,   97,   98,   97,   98,   98,   98,
			   98,   98,   97,   98,   98,   97,   98,   97,   98,   98,
			   98,   72,   97,   98,   72,   98,   97,   98,   98,   74,
			   97,   98,   74,   98,   97,   98,   98,   97,   98,   98,
			   97,   98,   97,   98,   97,   98,   97,   98,   97,   98,
			   97,   98,   98,   98,   98,   98,   98,   98,   97,   98,
			   97,   98,   98,   98,   97,   98,   98,   97,   98,   98,
			   97,   98,   98,   97,   98,   97,   98,   97,   98,   98,
			   98,   98,   97,   98,   98,   97,   98,   98,   97,   98,

			   98,   96,   97,   98,   96,   98,  139,  127,  127,  127,
			  117,  115,  116,  118,  119,  124,  120,  121,  101,  102,
			  103,  104,  105,  106,  107,  108,  109,  110,  111,  112,
			  113,  114,  135,  138,  135,  138,  135,  138,  134,  137,
			  130,  132,  130,  132,  132,   97,   98,   98,   97,   98,
			   98,   97,   98,   98,   97,   98,   98,   97,   98,   98,
			   97,   98,   98,   97,   98,   98,   97,   98,   98,   97,
			   98,   98,   51,   97,   98,   51,   98,   97,   98,   98,
			   97,   98,   97,   98,   98,   98,   97,   98,   98,   97,
			   98,   98,   97,   98,   98,   60,   97,   98,   97,   98,

			   60,   98,   98,   97,   98,   98,   97,   98,   98,   97,
			   98,   98,   97,   98,   98,   97,   98,   98,   69,   97,
			   98,   69,   98,   97,   98,   98,   71,   97,   98,   71,
			   98,   97,   98,   98,   75,   97,   98,   75,   98,   97,
			   98,   98,   97,   98,   98,   97,   98,   98,   97,   98,
			   98,   97,   98,   98,   97,   98,   97,   98,   98,   98,
			   97,   98,   98,   97,   98,   98,   97,   98,   98,   97,
			   98,   98,   88,   97,   98,   88,   98,   89,   97,   98,
			   89,   98,   97,   98,   98,   97,   98,   98,   97,   98,
			   98,   97,   98,   98,   94,   97,   98,   94,   98,   95,

			   97,   98,   95,   98,  124,  135,  135,  138,  135,  138,
			  134,  135,  137,  138,  134,  137,  131,  132,   38,   97,
			   98,   38,   98,   39,   97,   98,   39,   98,   42,   97,
			   98,   42,   98,   43,   97,   98,   43,   98,   97,   98,
			   98,   97,   98,   98,   97,   98,   98,   48,   97,   98,
			   48,   98,   97,   98,   98,   97,   98,   98,   97,   98,
			   98,   97,   98,   98,   97,   98,   98,   97,   98,   98,
			   58,   97,   98,   58,   98,   97,   98,   98,   97,   98,
			   98,   97,   98,   98,   97,   98,   98,   97,   98,   98,
			   97,   98,   98,   97,   98,   98,   70,   97,   98,   70,

			   98,   97,   98,   98,   97,   98,   98,   97,   98,   98,
			   97,   98,   98,   97,   98,   98,   97,   98,   98,   97,
			   98,   98,   97,   98,   98,   84,   97,   98,   84,   98,
			   97,   98,   98,   97,   98,   98,   87,   97,   98,   87,
			   98,   97,   98,   98,   97,   98,   98,   92,   97,   98,
			   92,   98,   97,   98,   98,  122,  135,  138,  138,  135,
			  134,  135,  137,  138,  134,  137,  133,   97,   98,   98,
			   45,   97,   98,   97,   98,   45,   98,   98,   97,   98,
			   98,   97,   98,   98,   52,   97,   98,   52,   98,   54,
			   97,   98,   54,   98,   97,   98,   98,   56,   97,   98,

			   56,   98,   97,   98,   98,   97,   98,   98,   61,   97,
			   98,   61,   98,   97,   98,   98,   97,   98,   98,   97,
			   98,   98,   97,   98,   98,   97,   98,   98,   97,   98,
			   98,   97,   98,   98,   97,   98,   98,   97,   98,   98,
			   80,   97,   98,   80,   98,   97,   98,   98,   82,   97,
			   98,   82,   98,   83,   97,   98,   83,   98,   85,   97,
			   98,   85,   98,   97,   98,   98,   97,   98,   98,   91,
			   97,   98,   91,   98,   97,   98,   98,  135,  134,  135,
			  137,  138,  138,  134,  136,  138,  136,   44,   97,   98,
			   44,   98,   97,   98,   98,   47,   97,   98,   47,   98,

			   97,   98,   98,   97,   98,   98,   97,   98,   98,   59,
			   97,   98,   59,   98,   63,   97,   98,   63,   98,   97,
			   98,   98,   65,   97,   98,   65,   98,   66,   97,   98,
			   66,   98,   97,   98,   98,   97,   98,   98,   97,   98,
			   98,   97,   98,   98,   97,   98,   98,   81,   97,   98,
			   81,   98,   97,   98,   98,   97,   98,   98,   93,   97,
			   98,   93,   98,  138,  138,  134,  135,  137,  138,  137,
			   46,   97,   98,   46,   98,   49,   97,   98,   49,   98,
			   55,   97,   98,   55,   98,   57,   97,   98,   57,   98,
			   64,   97,   98,   64,   98,   97,   98,   98,   73,   97,

			   98,   73,   98,   97,   98,   98,   79,   97,   98,   79,
			   98,   97,   98,   98,   86,   97,   98,   86,   98,   90,
			   97,   98,   90,   98,  138,  137,  138,  137,  138,  137,
			   67,   97,   98,   67,   98,   77,   97,   98,   77,   98,
			   78,   97,   98,   78,   98,  137,  138>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER is 2262
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER is 733
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER is 734
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

	yyNb_rules: INTEGER is 141
			-- Number of rules

	yyEnd_of_buffer: INTEGER is 142
			-- End of buffer rule code

	yyLine_used: BOOLEAN is false
			-- Are line and column numbers used?

	yyPosition_used: BOOLEAN is false
			-- Is `position' used?

	INITIAL: INTEGER is 0
			-- Start condition codes

feature -- User-defined features


end -- EDITOR_EIFFEL_SCANNER
