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

	EDITOR_EIFFEL_SCANNER_SKELETON	

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
--|#line 34 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 34")
end
-- Ignore carriage return
when 2 then
--|#line 35 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 35")
end

					create {EDITOR_TOKEN_SPACE} curr_token.make(text_count)
					update_token_list
					
when 3 then
--|#line 39 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 39")
end

					if not in_comments then
						create {EDITOR_TOKEN_TABULATION} curr_token.make(text_count)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
when 4 then
--|#line 47 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 47")
end

					from i_ := 1 until i_ > text_count loop
						create {EDITOR_TOKEN_EOL} curr_token.make
						update_token_list
						i_ := i_ + 1
					end
					in_comments := False
					
when 5 then
--|#line 59 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 59")
end
 
						-- comments
					create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					in_comments := True	
					update_token_list					
				
when 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17 then
--|#line 68 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 68")
end

						-- Symbols
					if not in_comments then
						create {EDITOR_TOKEN_TEXT} curr_token.make(text)
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
						create {EDITOR_TOKEN_OPERATOR} curr_token.make(text)					
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
when 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101 then
--|#line 119 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 119")
end

										-- Keyword
										if not in_comments then
											create {EDITOR_TOKEN_KEYWORD} curr_token.make(text)
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
										
when 102 then
--|#line 196 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 196")
end

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
										
when 103 then
--|#line 216 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 216")
end

										if not in_comments then
												create {EDITOR_TOKEN_TEXT} curr_token.make(text)											
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
										
when 104 then
--|#line 228 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 228")
end

										if not in_comments then
											create {EDITOR_TOKEN_TEXT} curr_token.make(text)										
										else
											create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
										end
										update_token_list
										
when 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126 then
--|#line 242 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 242")
end

					if not in_comments then
						create {EDITOR_TOKEN_CHARACTER} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
when 127 then
--|#line 272 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 272")
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
--|#line 287 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 287")
end

					-- Character error. Catch-all rules (no backing up)
					if not in_comments then
						create {EDITOR_TOKEN_TEXT} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
when 130 then
--|#line 310 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 310")
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
--|#line 324 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 324")
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
--|#line 339 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 339")
end
-- Ignore carriage return
when 133 then
--|#line 340 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 340")
end

							-- Verbatim string closer, possibly.
						create {EDITOR_TOKEN_STRING} curr_token.make(text)						
						end_of_verbatim_string := True
						in_verbatim_string := False
						set_start_condition (INITIAL)
						update_token_list
					
when 134 then
--|#line 349 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 349")
end

							-- Verbatim string closer, possibly.
						create {EDITOR_TOKEN_STRING} curr_token.make(text)						
						end_of_verbatim_string := True
						in_verbatim_string := False
						set_start_condition (INITIAL)
						update_token_list
					
when 135 then
--|#line 358 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 358")
end

						create {EDITOR_TOKEN_SPACE} curr_token.make(text_count)
						update_token_list						
					
when 136 then
--|#line 363 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 363")
end
						
						create {EDITOR_TOKEN_TABULATION} curr_token.make(text_count)
						update_token_list						
					
when 137 then
--|#line 368 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 368")
end

						from i_ := 1 until i_ > text_count loop
							create {EDITOR_TOKEN_EOL} curr_token.make
							update_token_list
							i_ := i_ + 1
						end						
					
when 138 then
--|#line 376 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 376")
end

						create {EDITOR_TOKEN_STRING} curr_token.make(text)
						update_token_list
					
when 139, 140 then
--|#line 382 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 382")
end

					-- Eiffel String
					if not in_comments then						
						create {EDITOR_TOKEN_STRING} curr_token.make(text)
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
when 141 then
--|#line 395 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 395")
end

					-- Eiffel Bit
					if not in_comments then
						create {EDITOR_TOKEN_NUMBER} curr_token.make(text)						
					else
						create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
					end
					update_token_list
					
when 142, 143, 144, 145 then
--|#line 407 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 407")
end

						-- Eiffel Integer
						if not in_comments then
							create {EDITOR_TOKEN_NUMBER} curr_token.make(text)
						else
							create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
						end
						update_token_list
						
when 146 then
--|#line 419 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 419")
end

							-- Eiffel Integer Error (considered as text)
						if not in_comments then
							create {EDITOR_TOKEN_TEXT} curr_token.make(text)
						else
							create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
						end
						update_token_list
						
when 147 then
	yy_end := yy_end - 1
--|#line 431 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 431")
end

							-- Eiffel reals & doubles
						if not in_comments then		
							create {EDITOR_TOKEN_NUMBER} curr_token.make(text)
						else
							create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
						end
						update_token_list
						
when 148, 149 then
--|#line 432 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 432")
end

							-- Eiffel reals & doubles
						if not in_comments then		
							create {EDITOR_TOKEN_NUMBER} curr_token.make(text)
						else
							create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
						end
						update_token_list
						
when 150 then
	yy_end := yy_end - 1
--|#line 434 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 434")
end

							-- Eiffel reals & doubles
						if not in_comments then		
							create {EDITOR_TOKEN_NUMBER} curr_token.make(text)
						else
							create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
						end
						update_token_list
						
when 151, 152 then
--|#line 435 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 435")
end

							-- Eiffel reals & doubles
						if not in_comments then		
							create {EDITOR_TOKEN_NUMBER} curr_token.make(text)
						else
							create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
						end
						update_token_list
						
when 153 then
--|#line 452 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 452")
end

					create {EDITOR_TOKEN_TEXT} curr_token.make(text)
					update_token_list
					
when 154 then
--|#line 460 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 460")
end

					-- Error (considered as text)
				if not in_comments then
					create {EDITOR_TOKEN_TEXT} curr_token.make(text)
				else
					create {EDITOR_TOKEN_COMMENT} curr_token.make(text)
				end
				update_token_list
				
when 155 then
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
			   25,   26,   27,   27,   28,   29,   30,   31,   32,   33,
			   34,   35,   36,   37,   38,   39,   40,   40,   41,   40,
			   40,   42,   40,   43,   44,   45,   40,   46,   47,   48,
			   49,   50,   51,   52,   40,   40,   53,   54,   55,   56,
			   57,   58,   59,   60,   61,   62,   63,   64,   65,   65,
			   66,   65,   65,   67,   65,   68,   69,   70,   65,   71,
			   72,   73,   74,   75,   76,   77,   65,   65,   78,   79,
			   81,   82,   83,   84,   81,   82,   83,   84,   93,   93,

			  102,   94,   94,  100,  101,  104,  106,  105,  105,  105,
			  105,  103,  620,  108,  107,  109,  109,  110,  110,  108,
			  122,  109,  109,  110,  110,  122,  111,  112,  117,  118,
			  194,  108,  115,  110,  110,  110,  110,  119,  120,  122,
			  133,  525,  148,  173,  149,  518,   85,   95,  113,  613,
			   85,  411,  127,   93,  150,  114,   94,  127,  111,  112,
			  210,  114,  195,  210,  115,  217,  258,  258,  207,  411,
			  397,  127,  133,  114,  151,  173,  152,   86,  396,   96,
			  113,   86,  122,  122,  122,  122,  153,  184,  200,  122,
			  395,  122,  122,  122,  122,  122,  122,  122,  123,  122,

			  122,  122,  122,  124,  122,  125,  122,  122,  122,  122,
			  126,  122,  122,  122,  122,  122,  122,  122,  394,  185,
			  201,  127,  122,  127,  127,  127,  127,  127,  127,  127,
			  128,  127,  127,  127,  127,  129,  127,  130,  127,  127,
			  127,  127,  131,  127,  127,  127,  127,  127,  127,  127,
			  122,  122,  122,  122,  259,  259,  259,  393,  392,  183,
			  122,  122,  122,  122,  122,  122,  122,  122,  132,  122,
			  122,  122,  122,  122,  122,  122,  122,  122,  122,  122,
			  122,  122,  122,  122,  122,  122,  205,  205,  205,  205,
			  122,  183,  127,  127,  127,  127,  127,  127,  127,  127,

			  133,  127,  127,  127,  127,  127,  127,  127,  127,  127,
			  127,  127,  127,  127,  127,  127,  127,  127,  134,  122,
			  144,  168,  135,  185,  122,  136,  205,  169,  137,  154,
			  145,  138,  160,  155,  122,  122,  122,  122,  122,  161,
			  162,  391,  172,  182,  202,  163,  156,  390,  389,  195,
			  139,  127,  146,  170,  140,  185,  127,  141,  388,  171,
			  142,  157,  147,  143,  164,  158,  127,  127,  127,  127,
			  127,  165,  166,  174,  173,  183,  203,  167,  159,  196,
			  122,  195,  186,  175,  387,  176,  122,  122,  146,  177,
			  190,  122,  157,  197,  128,  201,  158,  187,  147,  129,

			  191,  130,  386,  139,  385,  178,  131,  140,  203,  159,
			  141,  198,  127,  142,  188,  179,  143,  180,  127,  127,
			  146,  181,  192,  127,  157,  199,  128,  201,  158,  189,
			  147,  129,  193,  130,  151,  139,  152,  188,  131,  140,
			  203,  159,  141,  164,  192,  142,  153,  170,  143,  178,
			  165,  166,  189,  171,  193,  122,  167,  198,  264,  179,
			  208,  180,  209,  209,   93,  181,  151,   94,  152,  188,
			  209,  199,  213,  209,  270,  164,  192,   93,  153,  170,
			  372,  178,  165,  166,  189,  171,  193,  127,  167,  198,
			  264,  179,  209,  180,  209,  216,  211,  181,  384,  211,

			  383,  218,   93,  199,  207,   94,  270,  224,  373,  224,
			  224,   94,   93,   95,  272,   94,  210,  382,   93,  380,
			  225,  375,  225,  225,  265,   93,  214,  266,   94,  250,
			  250,  250,  250,  379,  269,  254,  254,  254,  254,  122,
			  263,  274,  378,  251,  122,   96,  272,  211,  210,  255,
			  261,  261,  261,  261,  377,  276,  267,  215,  376,  268,
			  108,   95,  257,  257,  257,  257,  270,  373,  212,  252,
			  372,  127,  264,  274,   95,  251,  127,  258,  258,  211,
			  220,  255,  371,  221,   98,   98,   98,  276,   93,  370,
			  262,  372,  222,   96,  278,  280,  369,  227,   90,   98,

			  122,   98,  114,   98,   98,  223,   96,  282,   98,  275,
			   98,  273,  373,  122,   98,  372,   98,  409,   89,   98,
			   98,   98,   98,   98,   98,  228,  278,  280,  229,  230,
			  231,  232,  127,  381,  381,  381,  381,  233,   98,  282,
			   88,  276,   87,  274,  234,  127,  235,  122,  236,  237,
			  238,  239,  281,  240,  277,  241,  122,  271,  284,  242,
			  267,  243,  122,  268,  244,  245,  246,  247,  248,  249,
			  108,  122,  256,  256,  257,  257,  279,  122,  122,  127,
			  212,  287,  204,  115,  282,  288,  278,  283,  127,  272,
			  284,  122,  267,  285,  127,  268,  290,  286,  297,  291,

			  122,  289,  298,  127,  122,  293,  121,  300,  280,  127,
			  127,  122,  114,  287,  292,  115,  302,  288,  295,  284,
			  294,  122,  296,  127,  299,  287,  304,  301,  290,  288,
			  297,  293,  127,  290,  298,  122,  127,  293,  122,  300,
			  122,  122,  122,  127,  303,  306,  294,  116,  302,  305,
			  297,  318,  294,  127,  298,  122,  300,  317,  304,  302,
			  307,  324,  308,  210,  309,  122,  210,  127,  217,   91,
			  127,  207,  127,  127,  127,  310,  304,  306,  311,  319,
			  312,  306,  313,  318,  314,  122,  122,  127,  321,  318,
			  122,  320,  312,  324,  313,  315,  314,  127,  316,  122,

			  322,  323,  326,  327,  328,  330,  332,  315,  122,  325,
			  316,  321,  312,  329,  313,   90,  314,  127,  127,  122,
			  321,  331,  127,  322,   89,  122,   88,  315,   87,  791,
			  316,  127,  322,  324,  326,  328,  328,  330,  332,  791,
			  127,  326,  791,  122,  350,  330,  339,  122,  340,  352,
			  345,  127,  349,  332,  346,  122,  341,  127,  333,  342,
			  334,  343,  344,  122,  354,  347,  351,  353,  335,  348,
			  122,  336,  791,  337,  338,  127,  350,  791,  339,  127,
			  340,  352,  347,  363,  350,  791,  348,  127,  341,  362,
			  339,  342,  340,  343,  344,  127,  354,  347,  352,  354,

			  341,  348,  127,  342,  355,  343,  344,  358,  122,  356,
			  364,  366,  359,  122,  365,  364,  368,  361,  122,  415,
			  357,  362,  367,  360,  205,  205,  205,  205,  208,  791,
			  209,  209,  209,  791,  209,  209,  358,  791,  791,  358,
			  127,  359,  364,  366,  359,  127,  366,  791,  368,  362,
			  127,  415,  360,  416,  368,  360,  209,  211,  213,  209,
			  211,  122,  218,  791,  205,  207,  209,   93,  209,  216,
			  372,  224,  122,  224,  224,  791,   93,  414,  791,   94,
			  374,  374,  374,  374,  210,  417,  122,  225,  210,  225,
			  225,  417,   93,  127,  791,   94,  398,  398,  398,  398,

			  399,  791,  399,  791,  127,  400,  400,  400,  400,  415,
			  251,  791,  214,  122,  418,  211,  791,  791,  127,  211,
			  791,  791,  210,  417,  791,   95,  401,  401,  401,  401,
			  402,  402,  402,  402,  791,  108,  252,  407,  407,  408,
			  408,   95,  251,  215,  403,  127,  419,  108,  115,  408,
			  408,  408,  408,  211,  405,  419,  405,   96,  122,  406,
			  406,  406,  406,  259,  259,  259,  412,  412,  412,  412,
			  404,  791,  420,   96,  791,  421,  403,  114,  122,  423,
			  115,  413,  413,  413,  413,  122,  122,  419,  425,  114,
			  127,  427,  426,  122,  429,  422,  122,  432,  431,  424,

			  122,  122,  428,  410,  421,  433,  262,  421,  430,  434,
			  127,  423,  435,  122,  122,  791,  437,  127,  127,  443,
			  425,  262,  440,  427,  427,  127,  429,  423,  127,  433,
			  431,  425,  127,  127,  429,  122,  441,  433,  445,  442,
			  431,  435,  438,  122,  435,  127,  127,  436,  437,  122,
			  122,  443,  122,  447,  440,  122,  439,  453,  452,  444,
			  122,  456,  454,  446,  448,  450,  122,  127,  441,  458,
			  445,  443,  462,  122,  440,  127,  122,  449,  451,  437,
			  122,  127,  127,  460,  127,  447,  455,  127,  441,  453,
			  453,  445,  127,  457,  455,  447,  450,  450,  127,  457,

			  459,  459,  461,  463,  463,  127,  465,  464,  127,  451,
			  451,  122,  127,  466,  467,  461,  122,  469,  455,  122,
			  122,  122,  471,  468,  122,  472,  470,  473,  791,  122,
			  474,  457,  459,  475,  461,  463,  122,  476,  465,  465,
			  477,  479,  482,  127,  791,  467,  467,  481,  127,  469,
			  122,  127,  127,  127,  471,  469,  127,  473,  471,  473,
			  478,  127,  476,  480,  122,  477,  122,  122,  127,  476,
			  486,  122,  477,  479,  483,  483,  122,  485,  484,  481,
			  490,  491,  127,  488,  493,  492,  494,  495,  487,  122,
			  496,  497,  479,  499,  122,  481,  127,  501,  127,  127,

			  122,  489,  488,  127,  506,  498,  122,  483,  127,  485,
			  485,  503,  491,  491,  504,  488,  493,  493,  495,  495,
			  489,  127,  497,  497,  500,  499,  127,  502,  122,  501,
			  505,  122,  127,  489,  507,  508,  507,  499,  127,  509,
			  510,  511,  122,  503,  513,  122,  505,  512,  122,  515,
			  381,  381,  381,  381,  258,  258,  501,  791,  791,  503,
			  127,  529,  505,  127,  791,  791,  507,  509,  791,  791,
			  791,  509,  511,  511,  127,   93,  513,  127,  372,  513,
			  127,  516,  516,  516,  516,  791,  791,   98,  514,  514,
			  514,  514,  791,  529,  409,  251,  400,  400,  400,  400,

			  517,  517,  517,  517,  519,  519,  519,  519,  520,  520,
			  520,  520,  521,  531,  521,  533,  791,  522,  522,  522,
			  522,  252,  403,  523,  523,  523,  523,  251,  406,  406,
			  406,  406,  524,  524,  524,  524,  259,  259,  259,  526,
			  518,  407,  407,  408,  408,  531,  535,  533,  404,  791,
			  537,  791,  115,  526,  403,  408,  408,  408,  408,  527,
			  527,  527,  527,  413,  413,  413,  413,  791,  122,  539,
			  122,  791,  525,  532,  541,  122,  410,  122,  535,  528,
			  530,  262,  537,  122,  115,  534,  538,  536,  542,  543,
			  122,  545,  122,  122,  544,  262,  122,  791,  547,  262,

			  127,  539,  127,  262,  540,  533,  541,  127,  548,  127,
			  549,  529,  531,  551,  553,  127,  555,  535,  539,  537,
			  543,  543,  127,  545,  127,  127,  545,  557,  127,  122,
			  547,  559,  122,  558,  122,  122,  541,  122,  546,  552,
			  549,  550,  549,  122,  554,  551,  553,  561,  555,  122,
			  122,  562,  556,  563,  564,  122,  565,  122,  567,  557,
			  791,  127,  560,  559,  127,  559,  127,  127,  569,  127,
			  547,  553,  566,  551,  571,  127,  555,  122,  573,  561,
			  575,  127,  127,  563,  557,  563,  565,  127,  565,  127,
			  567,  572,  568,  122,  561,  122,  122,  122,  122,  577,

			  569,  576,  570,  122,  567,  574,  571,  579,  122,  127,
			  573,  578,  575,  122,  122,  582,  581,  583,  584,  585,
			  587,  122,  589,  573,  569,  127,  580,  127,  127,  127,
			  127,  577,  122,  577,  571,  127,  590,  575,  122,  579,
			  127,  586,  588,  579,  591,  127,  127,  583,  581,  583,
			  585,  585,  587,  127,  589,  122,  122,  593,  581,  594,
			  595,  122,  597,  598,  127,  599,  122,  592,  591,  122,
			  127,  601,  122,  587,  589,  600,  591,  596,  603,  602,
			  122,  122,  604,  605,  122,  122,  607,  127,  127,  593,
			  609,  595,  595,  127,  597,  599,  606,  599,  127,  593,

			  610,  127,  122,  601,  127,  608,  611,  601,  122,  597,
			  603,  603,  127,  127,  605,  605,  127,  127,  607,  122,
			  122,  791,  609,  615,  615,  615,  615,  791,  607,  791,
			   93,  791,  611,  372,  127,  791,  791,  609,  611,  791,
			  127,  791,   98,  612,  612,  612,  612,  516,  516,  516,
			  516,  127,  127,  616,  616,  616,  616,  617,  617,  617,
			  617,  614,  791,  518,  618,  618,  618,  618,  522,  522,
			  522,  522,  619,  619,  619,  619,  791,  122,  403,  621,
			  621,  621,  621,  622,  622,  622,  622,  623,  623,  623,
			  623,  791,  122,  614,  618,  618,  618,  618,  122,  627,

			  122,  122,  629,  626,  404,  635,  122,  637,  624,  127,
			  403,  625,  620,  413,  413,  413,  413,  122,  630,  122,
			  639,  791,  631,  525,  127,  632,  628,  641,  636,  633,
			  127,  627,  127,  127,  629,  627,  122,  635,  127,  637,
			  624,  634,  638,  640,  643,  122,  645,  122,  647,  127,
			  632,  127,  639,  114,  633,  122,  122,  632,  629,  641,
			  637,  633,  642,  122,  122,  649,  644,  122,  127,  646,
			  651,  653,  648,  635,  639,  641,  643,  127,  645,  127,
			  647,  122,  654,  655,  122,  652,  650,  127,  127,  122,
			  656,  657,  659,  660,  643,  127,  127,  649,  645,  127,

			  658,  647,  651,  653,  649,  661,  122,  122,  662,  663,
			  122,  665,  122,  127,  655,  655,  127,  653,  651,  664,
			  122,  127,  657,  657,  659,  661,  667,  668,  669,  670,
			  671,  673,  659,  122,  675,  666,  677,  661,  127,  127,
			  663,  663,  127,  665,  127,  672,  122,  679,  122,  122,
			  676,  665,  127,  122,  122,  674,  681,  683,  667,  669,
			  669,  671,  671,  673,  678,  127,  675,  667,  677,  122,
			  684,  685,  122,  687,  122,  689,  682,  673,  127,  679,
			  127,  127,  677,  680,  122,  127,  127,  675,  681,  683,
			  686,  122,  122,  791,  122,  791,  679,  688,  791,  791,

			  791,  127,  685,  685,  127,  687,  127,  689,  683,   93,
			  791,  791,  372,  693,  705,  681,  127,  691,  691,  691,
			  691,   98,  687,  127,  127,  690,  127,  690,  791,  689,
			  691,  691,  691,  691,  692,  692,  692,  692,  791,  252,
			  618,  618,  618,  618,  791,  693,  705,  695,  695,  695,
			  695,  791,  122,  707,  694,  791,  791,  518,  696,  696,
			  696,  696,  697,  697,  697,  697,  698,  698,  698,  698,
			  699,  699,  699,  699,  700,  709,  700,  711,  122,  698,
			  698,  698,  698,  122,  127,  707,  694,  620,  702,  702,
			  702,  702,  122,  122,  704,  710,  122,  712,  706,  122,

			  713,  122,  703,  122,  708,  714,  525,  709,  715,  711,
			  127,  717,  716,  122,  122,  127,  122,  791,  719,  721,
			  791,  723,  791,  725,  127,  127,  705,  711,  127,  713,
			  707,  127,  713,  127,  703,  127,  709,  715,  727,  122,
			  715,  122,  122,  717,  717,  127,  127,  720,  127,  718,
			  719,  721,  722,  723,  122,  725,  726,  122,  729,  122,
			  731,  122,  122,  733,  122,  724,  735,  732,  728,  730,
			  727,  127,  122,  127,  127,  122,  736,  734,  737,  721,
			  122,  719,  122,  122,  723,  122,  127,  739,  727,  127,
			  729,  127,  731,  127,  127,  733,  127,  725,  735,  733,

			  729,  731,  122,  741,  127,  122,  122,  127,  737,  735,
			  737,  740,  127,  738,  127,  127,  122,  127,  743,  739,
			  691,  691,  691,  691,  791,  750,  791,  742,  691,  691,
			  691,  691,  791,  791,  127,  741,  791,  127,  127,  744,
			  744,  744,  744,  741,  791,  739,  791,  745,  127,  745,
			  743,  404,  746,  746,  746,  746,  747,  750,  747,  743,
			  122,  748,  748,  748,  748,  748,  748,  748,  748,  749,
			  749,  749,  749,  698,  698,  698,  698,  751,  751,  751,
			  751,  698,  698,  698,  698,  752,  752,  752,  752,  753,
			  756,  753,  127,  791,  754,  754,  754,  754,  122,  750,

			  122,  757,  758,  755,  759,  620,  122,  760,  122,  122,
			  762,  761,  122,  122,  763,  764,  122,  122,  122,  122,
			  766,  768,  756,  767,  765,  404,  770,  122,  791,  791,
			  127,  750,  127,  758,  758,  756,  760,  772,  127,  760,
			  127,  127,  762,  762,  127,  127,  764,  764,  127,  127,
			  127,  127,  766,  768,  122,  768,  766,  771,  770,  127,
			  769,  122,  773,  774,  122,  776,  775,  777,  122,  772,
			  122,  122,  778,  122,  746,  746,  746,  746,  779,  779,
			  779,  779,  748,  748,  748,  748,  127,  791,  791,  772,
			  791,  791,  770,  127,  774,  774,  127,  776,  776,  778,

			  127,  791,  127,  127,  778,  127,  748,  748,  748,  748,
			  780,  780,  780,  780,  781,  122,  781,  122,  518,  782,
			  782,  782,  782,  697,  697,  697,  697,  754,  754,  754,
			  754,  783,  783,  783,  783,  122,  122,  750,  122,  791,
			  122,  785,  122,  122,  787,  122,  788,  127,  789,  127,
			  122,  784,  786,  122,  122,  744,  744,  744,  744,  782,
			  782,  782,  782,  404,  122,  122,  122,  127,  127,  750,
			  127,  525,  127,  785,  127,  127,  787,  127,  789,  791,
			  789,  791,  127,  785,  787,  127,  127,  790,  790,  790,
			  790,  751,  751,  751,  751,  518,  127,  127,  127,  780,

			  780,  780,  780,  127,  127,  127,  127,  127,  127,  127,
			  127,  127,  127,  127,  127,  260,  260,  260,  260,  791,
			  791,  791,  791,  791,  791,  791,  791,  620,  791,  791,
			  791,  525,  791,  791,  791,  791,  791,  791,  791,  620,
			   80,   80,   80,   80,   80,   80,   80,   80,   80,   80,
			   80,   80,   80,   80,   80,   80,   80,   80,   80,   80,
			   80,   92,   92,  791,   92,   92,   92,   92,   92,   92,
			   92,   92,   92,   92,   92,   92,   92,   92,   92,   92,
			   92,   92,   97,  791,  791,  791,  791,  791,  791,   97,
			   97,   97,   97,   97,   97,   97,   97,   97,   97,   97,

			   97,   97,   97,   98,   98,  791,   98,   98,   98,   98,
			   98,   98,   98,   98,   98,   98,   98,   98,   98,   98,
			   98,   98,   98,   98,   99,   99,  791,   99,   99,   99,
			   99,   99,   99,   99,   99,   99,   99,   99,   99,   99,
			   99,   99,   99,   99,   99,  206,  206,  791,  206,  206,
			  206,  791,  791,  206,  206,  206,  206,  206,  206,  206,
			  206,  206,  206,  206,  206,  206,  207,  791,  791,  207,
			  791,  207,  207,  207,  207,  207,  207,  207,  207,  207,
			  207,  207,  207,  207,  207,  207,  207,  214,  214,  791,
			  214,  214,  214,  214,  214,  214,  214,  214,  214,  214,

			  214,  214,  214,  214,  214,  214,  214,  214,  215,  215,
			  791,  215,  215,  215,  215,  215,  215,  215,  215,  215,
			  215,  215,  215,  215,  215,  215,  215,  215,  215,  219,
			  219,  791,  219,  219,  219,  219,  219,  219,  219,  219,
			  219,  219,  219,  219,  219,  219,  219,  219,  219,  219,
			  226,  226,  791,  226,  226,  226,  226,  226,  226,  226,
			  226,  226,  226,  226,  226,  226,  226,  226,  226,  226,
			  226,  253,  253,  253,  253,  253,  253,  253,  253,  791,
			  253,  253,  253,  253,  253,  253,  253,  253,  253,  253,
			  253,  253,  210,  210,  791,  210,  210,  210,  791,  210,

			  210,  210,  210,  210,  210,  210,  210,  210,  210,  210,
			  210,  210,  210,  211,  211,  791,  211,  211,  211,  791,
			  211,  211,  211,  211,  211,  211,  211,  211,  211,  211,
			  211,  211,  211,  211,  701,  701,  701,  701,  701,  701,
			  701,  701,  791,  701,  701,  701,  701,  701,  701,  701,
			  701,  701,  701,  701,  701,    5,  791,  791,  791,  791,
			  791,  791,  791,  791,  791,  791,  791,  791,  791,  791,
			  791,  791,  791,  791,  791,  791,  791,  791,  791,  791,
			  791,  791,  791,  791,  791,  791,  791,  791,  791,  791,
			  791,  791,  791,  791,  791,  791,  791,  791,  791,  791,

			  791,  791,  791,  791,  791,  791,  791,  791,  791,  791,
			  791,  791,  791,  791,  791,  791,  791,  791,  791,  791,
			  791,  791,  791,  791,  791,  791,  791,  791,  791,  791,
			  791,  791,  791,  791,  791,  791,  791,  791,  791,  791,
			  791,  791,  791,  791,  791, yy_Dummy>>)
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
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    3,    3,    3,    3,    4,    4,    4,    4,   12,   15,

			   22,   12,   15,   16,   16,   23,   24,   23,   23,   23,
			   23,   22,  780,   25,   24,   25,   25,   25,   25,   26,
			   40,   26,   26,   26,   26,   49,   25,   25,   30,   30,
			   49,   27,   26,   27,   27,   27,   27,   32,   32,   38,
			   60,  751,   38,   68,   38,  744,    3,   12,   25,  515,
			    4,  411,   40,   98,   38,   25,   98,   49,   25,   25,
			   85,   26,   49,   85,   26,   85,  111,  111,   85,  260,
			  249,   38,   60,   27,   38,   68,   38,    3,  248,   12,
			   25,    4,   34,   34,   34,   34,   38,   46,   51,   51,
			  247,   46,   34,   34,   34,   34,   34,   34,   34,   34,

			   34,   34,   34,   34,   34,   34,   34,   34,   34,   34,
			   34,   34,   34,   34,   34,   34,   34,   34,  246,   46,
			   51,   51,   34,   46,   34,   34,   34,   34,   34,   34,
			   34,   34,   34,   34,   34,   34,   34,   34,   34,   34,
			   34,   34,   34,   34,   34,   34,   34,   34,   34,   34,
			   35,   35,   35,   35,  112,  112,  112,  245,  244,   70,
			   35,   35,   35,   35,   35,   35,   35,   35,   35,   35,
			   35,   35,   35,   35,   35,   35,   35,   35,   35,   35,
			   35,   35,   35,   35,   35,   35,   57,   57,   57,   57,
			   35,   70,   35,   35,   35,   35,   35,   35,   35,   35,

			   35,   35,   35,   35,   35,   35,   35,   35,   35,   35,
			   35,   35,   35,   35,   35,   35,   35,   35,   36,   36,
			   37,   42,   36,   71,   37,   36,   57,   42,   36,   39,
			   37,   36,   41,   39,   45,   41,   43,   39,   52,   41,
			   41,  243,   43,   45,   52,   41,   39,  242,  241,   74,
			   36,   36,   37,   42,   36,   71,   37,   36,  240,   42,
			   36,   39,   37,   36,   41,   39,   45,   41,   43,   39,
			   52,   41,   41,   44,   43,   45,   52,   41,   39,   50,
			   44,   74,   47,   44,  239,   44,   47,   50,   62,   44,
			   48,   48,   64,   50,   59,   76,   64,   47,   62,   59,

			   48,   59,  238,   61,  237,   44,   59,   61,   77,   64,
			   61,   50,   44,   61,   47,   44,   61,   44,   47,   50,
			   62,   44,   48,   48,   64,   50,   59,   76,   64,   47,
			   62,   59,   48,   59,   63,   61,   63,   72,   59,   61,
			   77,   64,   61,   66,   73,   61,   63,   67,   61,   69,
			   66,   66,   72,   67,   73,  122,   66,   75,  128,   69,
			   81,   69,   81,   81,   92,   69,   63,   92,   63,   72,
			   83,   75,   83,   83,  130,   66,   73,  219,   63,   67,
			  219,   69,   66,   66,   72,   67,   73,  122,   66,   75,
			  128,   69,   84,   69,   84,   84,   86,   69,  236,   86,

			  235,   86,  220,   75,   86,  220,  130,   95,  221,   95,
			   95,  221,   95,   92,  131,   95,   81,  234,  223,  232,
			   96,  223,   96,   96,  124,   96,   83,  124,   96,  105,
			  105,  105,  105,  231,  125,  108,  108,  108,  108,  125,
			  123,  133,  230,  105,  123,   92,  131,   81,   84,  108,
			  114,  114,  114,  114,  229,  139,  124,   83,  228,  124,
			  110,   95,  110,  110,  110,  110,  125,  372,  212,  105,
			  372,  125,  123,  133,   96,  105,  123,  258,  258,   84,
			   94,  108,  211,   94,   94,   94,   94,  139,  373,  210,
			  114,  373,   94,   95,  140,  141,  206,   99,   90,   94,

			  132,   94,  110,   94,   94,   94,   96,  142,   94,  134,
			   94,  132,  375,  134,   94,  375,   94,  258,   89,   94,
			   94,   94,   94,   94,   94,  100,  140,  141,  100,  100,
			  100,  100,  132,  233,  233,  233,  233,  100,  375,  142,
			   88,  134,   87,  132,  100,  134,  100,  126,  100,  100,
			  100,  100,  137,  100,  135,  100,  137,  126,  143,  100,
			  129,  100,  135,  129,  100,  100,  100,  100,  100,  100,
			  109,  136,  109,  109,  109,  109,  136,  145,  138,  126,
			   82,  146,   54,  109,  137,  146,  135,  138,  137,  126,
			  143,  148,  129,  144,  135,  129,  151,  144,  153,  149,

			  144,  148,  153,  136,  149,  152,   33,  157,  136,  145,
			  138,  150,  109,  146,  149,  109,  158,  146,  150,  138,
			  152,  154,  150,  148,  154,  144,  159,  155,  151,  144,
			  153,  149,  144,  148,  153,  155,  149,  152,  156,  157,
			  160,  163,  161,  150,  156,  165,  149,   28,  158,  161,
			  150,  170,  152,  154,  150,  168,  154,  168,  159,  155,
			  162,  173,  162,  214,  162,  162,  214,  155,  214,   11,
			  156,  214,  160,  163,  161,  162,  156,  165,  162,  169,
			  166,  161,  166,  170,  166,  169,  177,  168,  171,  168,
			  172,  169,  162,  173,  162,  166,  162,  162,  166,  174,

			  171,  172,  178,  175,  179,  180,  183,  162,  175,  174,
			  162,  169,  166,  176,  166,   10,  166,  169,  177,  176,
			  171,  182,  172,  169,    9,  182,    8,  166,    7,    5,
			  166,  174,  171,  172,  178,  175,  179,  180,  183,    0,
			  175,  174,    0,  187,  189,  176,  185,  186,  185,  192,
			  186,  176,  187,  182,  186,  191,  185,  182,  184,  185,
			  184,  185,  185,  184,  193,  188,  190,  191,  184,  188,
			  190,  184,    0,  184,  184,  187,  189,    0,  185,  186,
			  185,  192,  186,  197,  187,    0,  186,  191,  185,  198,
			  184,  185,  184,  185,  185,  184,  193,  188,  190,  191,

			  184,  188,  190,  184,  194,  184,  184,  195,  196,  194,
			  199,  201,  195,  202,  200,  197,  203,  196,  200,  264,
			  194,  198,  202,  195,  205,  205,  205,  205,  208,    0,
			  208,  208,  209,    0,  209,  209,  194,    0,    0,  195,
			  196,  194,  199,  201,  195,  202,  200,    0,  203,  196,
			  200,  264,  194,  265,  202,  195,  213,  215,  213,  213,
			  215,  265,  215,    0,  205,  215,  216,  222,  216,  216,
			  222,  224,  263,  224,  224,    0,  224,  263,    0,  224,
			  222,  222,  222,  222,  208,  265,  266,  225,  209,  225,
			  225,  267,  225,  265,    0,  225,  250,  250,  250,  250,

			  251,    0,  251,    0,  263,  251,  251,  251,  251,  263,
			  250,    0,  213,  269,  271,  208,    0,    0,  266,  209,
			    0,    0,  216,  267,    0,  224,  252,  252,  252,  252,
			  254,  254,  254,  254,    0,  256,  250,  256,  256,  256,
			  256,  225,  250,  213,  254,  269,  271,  257,  256,  257,
			  257,  257,  257,  216,  255,  272,  255,  224,  273,  255,
			  255,  255,  255,  259,  259,  259,  261,  261,  261,  261,
			  254,    0,  275,  225,    0,  276,  254,  256,  275,  278,
			  256,  262,  262,  262,  262,  277,  279,  272,  280,  257,
			  273,  282,  281,  283,  284,  277,  285,  286,  287,  279,

			  281,  286,  283,  259,  275,  288,  261,  276,  285,  289,
			  275,  278,  290,  289,  291,    0,  294,  277,  279,  298,
			  280,  262,  297,  282,  281,  283,  284,  277,  285,  286,
			  287,  279,  281,  286,  283,  292,  297,  288,  300,  296,
			  285,  289,  295,  296,  290,  289,  291,  292,  294,  299,
			  295,  298,  301,  302,  297,  305,  295,  306,  305,  299,
			  303,  308,  307,  301,  303,  304,  307,  292,  297,  309,
			  300,  296,  311,  309,  295,  296,  310,  303,  304,  292,
			  311,  299,  295,  310,  301,  302,  312,  305,  295,  306,
			  305,  299,  303,  308,  307,  301,  303,  304,  307,  313,

			  314,  309,  315,  316,  311,  309,  318,  317,  310,  303,
			  304,  317,  311,  319,  321,  310,  320,  322,  312,  323,
			  325,  319,  326,  320,  327,  329,  325,  330,    0,  329,
			  331,  313,  314,  331,  315,  316,  331,  332,  318,  317,
			  332,  339,  335,  317,    0,  319,  321,  340,  320,  322,
			  335,  323,  325,  319,  326,  320,  327,  329,  325,  330,
			  333,  329,  331,  334,  333,  331,  336,  334,  331,  332,
			  337,  338,  332,  339,  335,  341,  337,  342,  336,  340,
			  338,  344,  335,  343,  347,  345,  346,  348,  337,  345,
			  349,  350,  333,  352,  346,  334,  333,  354,  336,  334,

			  351,  343,  337,  338,  357,  351,  356,  341,  337,  342,
			  336,  358,  338,  344,  356,  343,  347,  345,  346,  348,
			  337,  345,  349,  350,  353,  352,  346,  355,  353,  354,
			  359,  355,  351,  343,  360,  361,  357,  351,  356,  362,
			  363,  364,  365,  358,  366,  363,  356,  365,  367,  381,
			  381,  381,  381,  381,  409,  409,  353,    0,    0,  355,
			  353,  415,  359,  355,    0,    0,  360,  361,    0,    0,
			    0,  362,  363,  364,  365,  374,  366,  363,  374,  365,
			  367,  398,  398,  398,  398,    0,    0,  374,  374,  374,
			  374,  374,    0,  415,  409,  398,  399,  399,  399,  399,

			  400,  400,  400,  400,  401,  401,  401,  401,  402,  402,
			  402,  402,  403,  417,  403,  419,    0,  403,  403,  403,
			  403,  398,  402,  404,  404,  404,  404,  398,  405,  405,
			  405,  405,  406,  406,  406,  406,  410,  410,  410,  407,
			  400,  407,  407,  407,  407,  417,  421,  419,  402,    0,
			  423,    0,  407,  408,  402,  408,  408,  408,  408,  412,
			  412,  412,  412,  413,  413,  413,  413,    0,  414,  425,
			  416,    0,  406,  418,  427,  418,  410,  422,  421,  414,
			  416,  407,  423,  420,  407,  420,  424,  422,  428,  429,
			  424,  431,  428,  426,  430,  408,  430,    0,  433,  412,

			  414,  425,  416,  413,  426,  418,  427,  418,  434,  422,
			  435,  414,  416,  437,  440,  420,  441,  420,  424,  422,
			  428,  429,  424,  431,  428,  426,  430,  443,  430,  432,
			  433,  445,  436,  444,  438,  439,  426,  444,  432,  438,
			  434,  436,  435,  442,  439,  437,  440,  447,  441,  448,
			  446,  449,  442,  451,  452,  449,  453,  454,  455,  443,
			    0,  432,  446,  445,  436,  444,  438,  439,  457,  444,
			  432,  438,  454,  436,  459,  442,  439,  456,  461,  447,
			  463,  448,  446,  449,  442,  451,  452,  449,  453,  454,
			  455,  460,  456,  458,  446,  460,  462,  464,  466,  467,

			  457,  466,  458,  468,  454,  462,  459,  471,  470,  456,
			  461,  470,  463,  472,  474,  475,  476,  477,  478,  479,
			  481,  478,  483,  460,  456,  458,  474,  460,  462,  464,
			  466,  467,  480,  466,  458,  468,  484,  462,  482,  471,
			  470,  480,  482,  470,  485,  472,  474,  475,  476,  477,
			  478,  479,  481,  478,  483,  486,  487,  488,  474,  487,
			  489,  490,  491,  492,  480,  493,  494,  486,  484,  492,
			  482,  495,  496,  480,  482,  494,  485,  490,  497,  496,
			  498,  500,  502,  503,  504,  502,  505,  486,  487,  488,
			  507,  487,  489,  490,  491,  492,  504,  493,  494,  486,

			  508,  492,  506,  495,  496,  506,  509,  494,  508,  490,
			  497,  496,  498,  500,  502,  503,  504,  502,  505,  510,
			  512,    0,  507,  517,  517,  517,  517,    0,  504,    0,
			  514,    0,  508,  514,  506,    0,    0,  506,  509,    0,
			  508,    0,  514,  514,  514,  514,  514,  516,  516,  516,
			  516,  510,  512,  518,  518,  518,  518,  519,  519,  519,
			  519,  516,    0,  517,  520,  520,  520,  520,  521,  521,
			  521,  521,  522,  522,  522,  522,    0,  528,  520,  523,
			  523,  523,  523,  524,  524,  524,  524,  525,  525,  525,
			  525,    0,  530,  516,  526,  526,  526,  526,  532,  533,

			  534,  536,  539,  532,  520,  543,  544,  547,  526,  528,
			  520,  527,  522,  527,  527,  527,  527,  538,  540,  546,
			  549,    0,  540,  524,  530,  541,  538,  551,  546,  541,
			  532,  533,  534,  536,  539,  532,  542,  543,  544,  547,
			  526,  542,  548,  550,  553,  548,  555,  550,  557,  538,
			  540,  546,  549,  527,  540,  554,  558,  541,  538,  551,
			  546,  541,  552,  560,  556,  561,  554,  552,  542,  556,
			  563,  565,  560,  542,  548,  550,  553,  548,  555,  550,
			  557,  562,  566,  567,  568,  564,  562,  554,  558,  564,
			  570,  571,  573,  574,  552,  560,  556,  561,  554,  552,

			  572,  556,  563,  565,  560,  575,  572,  576,  578,  579,
			  580,  581,  578,  562,  566,  567,  568,  564,  562,  580,
			  582,  564,  570,  571,  573,  574,  583,  584,  585,  586,
			  587,  589,  572,  586,  591,  582,  593,  575,  572,  576,
			  578,  579,  580,  581,  578,  588,  590,  595,  596,  588,
			  592,  580,  582,  594,  592,  590,  599,  601,  583,  584,
			  585,  586,  587,  589,  594,  586,  591,  582,  593,  602,
			  604,  605,  598,  607,  608,  611,  600,  588,  590,  595,
			  596,  588,  592,  598,  600,  594,  592,  590,  599,  601,
			  606,  626,  610,    0,  606,    0,  594,  610,    0,    0,

			    0,  602,  604,  605,  598,  607,  608,  611,  600,  612,
			    0,    0,  612,  617,  629,  598,  600,  615,  615,  615,
			  615,  612,  606,  626,  610,  614,  606,  614,    0,  610,
			  614,  614,  614,  614,  616,  616,  616,  616,    0,  617,
			  618,  618,  618,  618,    0,  617,  629,  619,  619,  619,
			  619,    0,  630,  633,  618,    0,    0,  615,  620,  620,
			  620,  620,  621,  621,  621,  621,  622,  622,  622,  622,
			  623,  623,  623,  623,  624,  635,  624,  637,  638,  624,
			  624,  624,  624,  628,  630,  633,  618,  619,  625,  625,
			  625,  625,  631,  634,  628,  636,  640,  642,  631,  636,

			  643,  642,  625,  644,  634,  646,  622,  635,  647,  637,
			  638,  649,  648,  646,  650,  628,  648,    0,  653,  655,
			    0,  657,    0,  659,  631,  634,  628,  636,  640,  642,
			  631,  636,  643,  642,  625,  644,  634,  646,  661,  652,
			  647,  656,  654,  649,  648,  646,  650,  654,  648,  652,
			  653,  655,  656,  657,  658,  659,  660,  662,  663,  664,
			  665,  666,  668,  669,  660,  658,  671,  668,  662,  664,
			  661,  652,  670,  656,  654,  672,  674,  670,  675,  654,
			  674,  652,  676,  678,  656,  680,  658,  683,  660,  662,
			  663,  664,  665,  666,  668,  669,  660,  658,  671,  668,

			  662,  664,  682,  685,  670,  686,  684,  672,  674,  670,
			  675,  684,  674,  682,  676,  678,  688,  680,  689,  683,
			  690,  690,  690,  690,    0,  697,    0,  688,  691,  691,
			  691,  691,    0,    0,  682,  685,    0,  686,  684,  692,
			  692,  692,  692,  684,    0,  682,    0,  693,  688,  693,
			  689,  697,  693,  693,  693,  693,  694,  697,  694,  688,
			  704,  694,  694,  694,  694,  695,  695,  695,  695,  696,
			  696,  696,  696,  698,  698,  698,  698,  699,  699,  699,
			  699,  700,  700,  700,  700,  702,  702,  702,  702,  703,
			  707,  703,  704,    0,  703,  703,  703,  703,  706,  702,

			  708,  710,  711,  706,  712,  695,  710,  713,  714,  712,
			  715,  714,  716,  718,  720,  721,  720,  722,  724,  726,
			  727,  729,  707,  728,  726,  702,  731,  728,    0,    0,
			  706,  702,  708,  710,  711,  706,  712,  733,  710,  713,
			  714,  712,  715,  714,  716,  718,  720,  721,  720,  722,
			  724,  726,  727,  729,  730,  728,  726,  732,  731,  728,
			  730,  732,  734,  735,  736,  739,  738,  740,  734,  733,
			  738,  740,  741,  742,  745,  745,  745,  745,  746,  746,
			  746,  746,  747,  747,  747,  747,  730,    0,    0,  732,
			    0,    0,  730,  732,  734,  735,  736,  739,  738,  740,

			  734,    0,  738,  740,  741,  742,  748,  748,  748,  748,
			  749,  749,  749,  749,  750,  755,  750,  757,  746,  750,
			  750,  750,  750,  752,  752,  752,  752,  753,  753,  753,
			  753,  754,  754,  754,  754,  759,  761,  752,  763,    0,
			  765,  766,  767,  769,  770,  771,  773,  755,  774,  757,
			  773,  765,  769,  775,  777,  779,  779,  779,  779,  781,
			  781,  781,  781,  752,  784,  786,  788,  759,  761,  752,
			  763,  754,  765,  766,  767,  769,  770,  771,  773,    0,
			  774,    0,  773,  765,  769,  775,  777,  782,  782,  782,
			  782,  783,  783,  783,  783,  779,  784,  786,  788,  790,

			  790,  790,  790,  798,  798,  798,  798,  798,  798,  798,
			  798,  798,  798,  798,  798,  805,  805,  805,  805,    0,
			    0,    0,    0,    0,    0,    0,    0,  782,    0,    0,
			    0,  783,    0,    0,    0,    0,    0,    0,    0,  790,
			  792,  792,  792,  792,  792,  792,  792,  792,  792,  792,
			  792,  792,  792,  792,  792,  792,  792,  792,  792,  792,
			  792,  793,  793,    0,  793,  793,  793,  793,  793,  793,
			  793,  793,  793,  793,  793,  793,  793,  793,  793,  793,
			  793,  793,  794,    0,    0,    0,    0,    0,    0,  794,
			  794,  794,  794,  794,  794,  794,  794,  794,  794,  794,

			  794,  794,  794,  795,  795,    0,  795,  795,  795,  795,
			  795,  795,  795,  795,  795,  795,  795,  795,  795,  795,
			  795,  795,  795,  795,  796,  796,    0,  796,  796,  796,
			  796,  796,  796,  796,  796,  796,  796,  796,  796,  796,
			  796,  796,  796,  796,  796,  797,  797,    0,  797,  797,
			  797,    0,    0,  797,  797,  797,  797,  797,  797,  797,
			  797,  797,  797,  797,  797,  797,  799,    0,    0,  799,
			    0,  799,  799,  799,  799,  799,  799,  799,  799,  799,
			  799,  799,  799,  799,  799,  799,  799,  800,  800,    0,
			  800,  800,  800,  800,  800,  800,  800,  800,  800,  800,

			  800,  800,  800,  800,  800,  800,  800,  800,  801,  801,
			    0,  801,  801,  801,  801,  801,  801,  801,  801,  801,
			  801,  801,  801,  801,  801,  801,  801,  801,  801,  802,
			  802,    0,  802,  802,  802,  802,  802,  802,  802,  802,
			  802,  802,  802,  802,  802,  802,  802,  802,  802,  802,
			  803,  803,    0,  803,  803,  803,  803,  803,  803,  803,
			  803,  803,  803,  803,  803,  803,  803,  803,  803,  803,
			  803,  804,  804,  804,  804,  804,  804,  804,  804,    0,
			  804,  804,  804,  804,  804,  804,  804,  804,  804,  804,
			  804,  804,  806,  806,    0,  806,  806,  806,    0,  806,

			  806,  806,  806,  806,  806,  806,  806,  806,  806,  806,
			  806,  806,  806,  807,  807,    0,  807,  807,  807,    0,
			  807,  807,  807,  807,  807,  807,  807,  807,  807,  807,
			  807,  807,  807,  807,  808,  808,  808,  808,  808,  808,
			  808,  808,    0,  808,  808,  808,  808,  808,  808,  808,
			  808,  808,  808,  808,  808,  791,  791,  791,  791,  791,
			  791,  791,  791,  791,  791,  791,  791,  791,  791,  791,
			  791,  791,  791,  791,  791,  791,  791,  791,  791,  791,
			  791,  791,  791,  791,  791,  791,  791,  791,  791,  791,
			  791,  791,  791,  791,  791,  791,  791,  791,  791,  791,

			  791,  791,  791,  791,  791,  791,  791,  791,  791,  791,
			  791,  791,  791,  791,  791,  791,  791,  791,  791,  791,
			  791,  791,  791,  791,  791,  791,  791,  791,  791,  791,
			  791,  791,  791,  791,  791,  791,  791,  791,  791,  791,
			  791,  791,  791,  791,  791, yy_Dummy>>)
		end

	yy_base_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,   88,   92,  829, 2855,  826,  823,  820,
			  810,  763,   91,    0, 2855,   92,   93, 2855, 2855, 2855,
			 2855, 2855,   83,   87,   87,   95,  101,  113,  720, 2855,
			  102, 2855,  110,  679,  162,  230,  281,  286,  101,  299,
			   82,  297,  283,  298,  342,  296,  153,  348,  353,   87,
			  349,  151,  300, 2855,  625, 2855, 2855,  266,    0,  358,
			  102,  366,  354,  393,  362,    0,  408,  409,   99,  418,
			  212,  289,  403,  407,  306,  427,  358,  364, 2855, 2855,
			    0,  458,  677,  468,  490,  158,  494,  640,  637,  614,
			  593, 2855,  457, 2855,  573,  505,  518,    0,  146,  586,

			  618,    0, 2855, 2855, 2855,  509, 2855, 2855,  515,  652,
			  542,  146,  234,    0,  530, 2855, 2855, 2855, 2855, 2855,
			 2855, 2855,  417,  506,  486,  501,  609,    0,  424,  622,
			  441,  466,  562,  492,  575,  624,  633,  618,  640,  521,
			  564,  552,  573,  611,  662,  639,  650,    0,  653,  666,
			  673,  648,  672,  653,  683,  697,  700,  666,  686,  682,
			  702,  704,  727,  703,    0,  700,  747,    0,  717,  747,
			  711,  756,  752,  712,  761,  770,  781,  748,  754,  771,
			  773,    0,  787,  772,  825,  813,  809,  805,  824,  797,
			  832,  817,  815,  814,  871,  874,  870,  845,  842,  872,

			  880,  877,  875,  869, 2855,  904,  585,    0,  926,  930,
			  582,  575,  565,  954,  761,  955,  964,    0,    0,  470,
			  495,  501,  960,  511,  969,  985, 2855, 2855,  547,  543,
			  531,  522,  508,  613,  506,  489,  487,  393,  391,  373,
			  347,  337,  336,  330,  247,  246,  207,  179,  167,  159,
			  976,  985, 1006, 2855, 1010, 1039, 1017, 1029,  557, 1043,
			  109, 1046, 1061,  934,  876,  923,  948,  961,    0,  975,
			    0,  976, 1017, 1020,    0, 1040, 1043, 1047, 1031, 1048,
			 1037, 1062, 1061, 1055, 1047, 1058, 1063, 1048, 1071, 1075,
			 1078, 1076, 1097,    0, 1066, 1112, 1105, 1092, 1085, 1111,

			 1090, 1114, 1104, 1122, 1123, 1117, 1116, 1128, 1123, 1135,
			 1138, 1142, 1152, 1161, 1166, 1157, 1173, 1173, 1172, 1183,
			 1178, 1184, 1172, 1181,    0, 1182, 1178, 1186,    0, 1191,
			 1193, 1198, 1205, 1226, 1229, 1212, 1228, 1238, 1233, 1207,
			 1213, 1245, 1227, 1251, 1234, 1251, 1256, 1250, 1257, 1252,
			 1253, 1262, 1250, 1290, 1263, 1293, 1268, 1266, 1277, 1284,
			 1296, 1297, 1301, 1307, 1308, 1304, 1301, 1310,    0, 2855,
			 2855, 2855,  560,  581, 1368,  605, 2855, 2855, 2855, 2855,
			 2855, 1330, 2855, 2855, 2855, 2855, 2855, 2855, 2855, 2855,
			 2855, 2855, 2855, 2855, 2855, 2855, 2855, 2855, 1361, 1376,

			 1380, 1384, 1388, 1397, 1403, 1408, 1412, 1421, 1435, 1334,
			 1416,   91, 1439, 1443, 1430, 1312, 1432, 1365, 1437, 1379,
			 1445, 1406, 1439, 1402, 1452, 1435, 1455, 1425, 1454, 1455,
			 1458, 1455, 1491, 1451, 1470, 1472, 1494, 1466, 1496, 1497,
			 1471, 1469, 1505, 1480, 1499, 1497, 1512, 1497, 1511, 1517,
			    0, 1519, 1516, 1518, 1519, 1505, 1539, 1515, 1555, 1527,
			 1557, 1544, 1558, 1533, 1559,    0, 1560, 1558, 1565,    0,
			 1570, 1566, 1575,    0, 1576, 1577, 1566, 1579, 1583, 1584,
			 1594, 1573, 1600, 1580, 1598, 1606, 1617, 1618, 1607, 1619,
			 1623, 1608, 1631, 1633, 1628, 1624, 1634, 1633, 1642,    0,

			 1643,    0, 1647, 1648, 1646, 1636, 1664, 1649, 1670, 1676,
			 1681,    0, 1682,    0, 1723,  138, 1727, 1703, 1733, 1737,
			 1744, 1748, 1752, 1759, 1763, 1767, 1774, 1793, 1739,    0,
			 1754,    0, 1760, 1756, 1762,    0, 1763,    0, 1779, 1755,
			 1784, 1791, 1798, 1762, 1768,    0, 1781, 1760, 1807, 1785,
			 1809, 1793, 1829, 1811, 1817, 1797, 1826, 1805, 1818,    0,
			 1825, 1818, 1843, 1827, 1851, 1837, 1844, 1845, 1846,    0,
			 1852, 1853, 1868, 1860, 1855, 1867, 1869,    0, 1874, 1875,
			 1872, 1864, 1882, 1873, 1889, 1890, 1895, 1896, 1911, 1897,
			 1908, 1887, 1916, 1902, 1915, 1898, 1910,    0, 1934, 1907,

			 1946, 1927, 1931,    0, 1932, 1933, 1956, 1939, 1936,    0,
			 1954, 1932, 2002, 2855, 2010, 1997, 2014, 1979, 2020, 2027,
			 2038, 2042, 2046, 2050, 2059, 2068, 1953,    0, 2045, 1965,
			 2014, 2054,    0, 2009, 2055, 2026, 2061, 2043, 2040,    0,
			 2058,    0, 2063, 2066, 2065,    0, 2075, 2078, 2078, 2077,
			 2076,    0, 2101, 2070, 2104, 2076, 2103, 2072, 2116, 2074,
			 2126, 2108, 2119, 2109, 2121, 2112, 2123,    0, 2124, 2120,
			 2134, 2123, 2137,    0, 2142, 2144, 2144,    0, 2145,    0,
			 2147,    0, 2164, 2138, 2168, 2160, 2167,    0, 2178, 2169,
			 2200, 2208, 2219, 2232, 2241, 2245, 2249, 2191, 2253, 2257,

			 2261, 2855, 2265, 2274, 2222,    0, 2260, 2247, 2262,    0,
			 2268, 2269, 2271, 2274, 2270, 2269, 2274,    0, 2275,    0,
			 2278, 2279, 2279,    0, 2280,    0, 2281, 2277, 2289, 2287,
			 2316, 2282, 2323, 2303, 2330, 2331, 2326,    0, 2332, 2331,
			 2333, 2338, 2335,    0,   85, 2354, 2358, 2362, 2386, 2390,
			 2399,   81, 2403, 2407, 2411, 2377,    0, 2379,    0, 2397,
			    0, 2398,    0, 2400,    0, 2402, 2392, 2404,    0, 2405,
			 2397, 2407,    0, 2412, 2414, 2415,    0, 2416,    0, 2435,
			   52, 2439, 2467, 2471, 2426,    0, 2427,    0, 2428,    0,
			 2479, 2855, 2539, 2560, 2581, 2602, 2623, 2644, 2493, 2665,

			 2686, 2707, 2728, 2749, 2770, 2505, 2791, 2812, 2833, yy_Dummy>>)
		end

	yy_def_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,  791,    1,  792,  792,  791,  791,  791,  791,  791,
			  791,  791,  793,  794,  791,  795,  796,  791,  791,  791,
			  791,  791,  791,  791,  791,  791,  791,  791,  791,  791,
			  791,  791,  791,  791,  791,  791,   35,   35,   35,   35,
			   35,   35,   35,   35,   35,   35,   35,   35,   35,   35,
			   35,   35,   35,  791,  791,  791,  791,  791,  797,  798,
			  798,  798,  798,  798,  798,  798,  798,  798,  798,  798,
			  798,  798,  798,  798,  798,  798,  798,  798,  791,  791,
			  799,  791,  791,  799,  791,  800,  801,  791,  791,  791,
			  791,  791,  793,  791,  802,  793,  793,  794,  795,  803,

			  803,  803,  791,  791,  791,  791,  791,  791,  804,  791,
			  791,  791,  791,  805,  791,  791,  791,  791,  791,  791,
			  791,  791,   35,   35,   35,   35,   35,  798,  798,  798,
			  798,  798,   35,  798,   35,   35,   35,   35,   35,  798,
			  798,  798,  798,  798,   35,   35,  798,  798,   35,   35,
			   35,  798,  798,  798,   35,   35,   35,  798,  798,  798,
			   35,   35,   35,   35,  798,  798,  798,  798,   35,   35,
			  798,  798,   35,  798,   35,   35,   35,   35,  798,  798,
			  798,  798,   35,  798,   35,  798,   35,   35,  798,  798,
			   35,   35,  798,  798,   35,  798,   35,   35,  798,  798,

			   35,  798,   35,  798,  791,  791,  797,  799,  791,  791,
			  806,  807,  791,  799,  800,  801,  791,  799,  799,  802,
			  795,  795,  802,  802,  793,  793,  791,  791,  791,  791,
			  791,  791,  791,  791,  791,  791,  791,  791,  791,  791,
			  791,  791,  791,  791,  791,  791,  791,  791,  791,  791,
			  791,  791,  791,  791,  791,  791,  791,  791,  791,  791,
			  805,  791,  791,   35,  798,   35,   35,  798,  798,   35,
			  798,   35,  798,   35,  798,   35,  798,   35,  798,   35,
			  798,   35,  798,   35,  798,   35,   35,  798,  798,   35,
			  798,   35,   35,  798,  798,   35,   35,  798,  798,   35,

			  798,   35,  798,   35,  798,   35,  798,   35,   35,   35,
			   35,   35,  798,  798,  798,  798,  798,   35,  798,   35,
			   35,  798,  798,   35,  798,   35,  798,   35,  798,   35,
			  798,   35,  798,   35,   35,   35,   35,   35,   35,  798,
			  798,  798,  798,  798,  798,   35,   35,  798,  798,   35,
			  798,   35,  798,   35,  798,   35,   35,   35,  798,  798,
			  798,   35,  798,   35,  798,   35,  798,   35,  798,  791,
			  791,  791,  802,  802,  802,  802,  791,  791,  791,  791,
			  791,  791,  791,  791,  791,  791,  791,  791,  791,  791,
			  791,  791,  791,  791,  791,  791,  791,  791,  791,  791,

			  791,  791,  791,  791,  791,  791,  791,  791,  791,  791,
			  791,  805,  791,  791,   35,  798,   35,  798,   35,  798,
			   35,  798,   35,  798,   35,  798,   35,  798,   35,  798,
			   35,  798,   35,  798,   35,  798,   35,  798,   35,   35,
			  798,  798,   35,  798,   35,  798,   35,  798,   35,   35,
			  798,  798,   35,  798,   35,  798,   35,  798,   35,  798,
			   35,  798,   35,  798,   35,  798,   35,  798,   35,  798,
			   35,  798,   35,  798,   35,   35,  798,  798,   35,  798,
			   35,  798,   35,  798,   35,  798,   35,   35,  798,  798,
			   35,  798,   35,  798,   35,  798,   35,  798,   35,  798,

			   35,  798,   35,  798,   35,  798,   35,  798,   35,  798,
			   35,  798,   35,  798,  802,  791,  791,  791,  791,  791,
			  791,  791,  791,  791,  791,  791,  804,  791,   35,  798,
			   35,  798,   35,  798,   35,  798,   35,  798,   35,  798,
			   35,  798,   35,  798,   35,  798,   35,  798,   35,  798,
			   35,  798,   35,  798,   35,  798,   35,  798,   35,  798,
			   35,  798,   35,  798,   35,  798,   35,  798,   35,  798,
			   35,  798,   35,  798,   35,  798,   35,  798,   35,  798,
			   35,  798,   35,  798,   35,  798,   35,  798,   35,  798,
			   35,  798,   35,  798,   35,  798,   35,  798,   35,  798,

			   35,  798,   35,  798,   35,  798,   35,  798,   35,  798,
			   35,  798,  802,  791,  791,  791,  791,  791,  791,  791,
			  791,  791,  791,  791,  791,  808,   35,  798,   35,  798,
			   35,   35,  798,  798,   35,  798,   35,  798,   35,  798,
			   35,  798,   35,  798,   35,  798,   35,  798,   35,  798,
			   35,  798,   35,  798,   35,  798,   35,  798,   35,  798,
			   35,  798,   35,  798,   35,  798,   35,  798,   35,  798,
			   35,  798,   35,  798,   35,  798,   35,  798,   35,  798,
			   35,  798,   35,  798,   35,  798,   35,  798,   35,  798,
			  791,  791,  791,  791,  791,  791,  791,  791,  791,  791,

			  791,  791,  791,  791,   35,  798,   35,  798,   35,  798,
			   35,  798,   35,  798,   35,  798,   35,  798,   35,  798,
			   35,  798,   35,  798,   35,  798,   35,  798,   35,  798,
			   35,  798,   35,  798,   35,  798,   35,  798,   35,  798,
			   35,  798,   35,  798,  791,  791,  791,  791,  791,  791,
			  791,  791,  791,  791,  791,   35,  798,   35,  798,   35,
			  798,   35,  798,   35,  798,   35,  798,   35,  798,   35,
			  798,   35,  798,   35,  798,   35,  798,   35,  798,  791,
			  791,  791,  791,  791,   35,  798,   35,  798,   35,  798,
			  791,    0,  791,  791,  791,  791,  791,  791,  791,  791,

			  791,  791,  791,  791,  791,  791,  791,  791,  791, yy_Dummy>>)
		end

	yy_ec_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    1,    1,    1,    1,    1,    1,    1,    1,    2,
			    3,    1,    1,    4,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    5,    6,    7,    8,    9,   10,    8,   11,
			   12,   13,   14,   15,   16,   17,   18,   19,   20,   21,
			   22,   22,   22,   22,   22,   22,   23,   23,   24,   25,
			   26,   27,   28,   29,    8,   30,   31,   32,   33,   34,
			   35,   36,   37,   38,   39,   40,   41,   42,   43,   44,
			   45,   46,   47,   48,   49,   50,   51,   52,   53,   54,
			   55,   56,   57,   58,   59,   60,   61,   62,   63,   64,

			   65,   66,   67,   68,   69,   70,   71,   72,   73,   74,
			   75,   76,   77,   78,   79,   80,   81,   82,   83,   84,
			   85,   86,   87,   88,    8,   89,    1,    1,    1,    1,
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
			   10,   11,   12,   13,    1,    1,    1,    1,    1,    1,
			   10,   10,   10,   10,   10,   10,   14,   14,   14,   14,
			   14,   14,   14,   14,   14,   14,   14,   14,   14,   14,
			   14,   14,   14,   15,   16,   17,    1,    1,    1,    1,
			   18,    1,   10,   10,   10,   10,   10,   10,   14,   14,
			   14,   14,   14,   14,   14,   14,   14,   14,   14,   14,
			   14,   14,   14,   14,   14,   19,   20,   21,    1,    1, yy_Dummy>>)
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
			  285,  287,  288,  288,  288,  289,  290,  291,  292,  293,
			  294,  295,  296,  298,  300,  302,  304,  307,  308,  309,
			  310,  311,  313,  315,  316,  318,  320,  322,  324,  326,
			  327,  328,  329,  330,  331,  333,  336,  337,  339,  341,
			  343,  345,  346,  347,  348,  350,  352,  354,  355,  356,
			  357,  360,  362,  364,  367,  369,  370,  371,  373,  375,
			  377,  378,  379,  381,  382,  384,  386,  388,  391,  392,
			  393,  394,  396,  398,  399,  401,  402,  404,  406,  407,
			  408,  410,  412,  413,  414,  416,  417,  419,  421,  422,

			  423,  425,  426,  428,  429,  430,  431,  431,  432,  433,
			  433,  433,  433,  434,  436,  437,  438,  439,  441,  443,
			  443,  445,  447,  447,  447,  449,  451,  452,  454,  455,
			  456,  457,  458,  459,  460,  461,  462,  463,  464,  465,
			  466,  467,  468,  469,  470,  471,  472,  473,  474,  475,
			  476,  478,  478,  478,  479,  481,  482,  484,  486,  487,
			  488,  489,  491,  492,  494,  495,  497,  500,  501,  503,
			  506,  508,  510,  511,  514,  516,  518,  519,  521,  522,
			  524,  525,  527,  528,  530,  531,  533,  535,  536,  537,
			  539,  540,  543,  545,  547,  548,  550,  552,  553,  554,

			  556,  557,  559,  560,  562,  563,  565,  566,  568,  570,
			  572,  574,  576,  577,  578,  579,  580,  581,  583,  584,
			  586,  588,  589,  590,  593,  595,  597,  598,  601,  603,
			  605,  606,  608,  609,  611,  613,  615,  617,  619,  621,
			  622,  623,  624,  625,  626,  627,  629,  631,  632,  633,
			  635,  636,  638,  639,  641,  642,  644,  646,  648,  649,
			  650,  651,  653,  654,  656,  657,  659,  660,  663,  665,
			  666,  667,  668,  669,  670,  670,  671,  672,  673,  674,
			  675,  676,  677,  678,  679,  680,  681,  682,  683,  684,
			  685,  686,  687,  688,  689,  690,  691,  692,  693,  695,

			  695,  697,  697,  699,  699,  699,  699,  701,  703,  705,
			  705,  705,  705,  707,  709,  711,  712,  714,  715,  717,
			  718,  720,  721,  723,  724,  726,  727,  729,  730,  732,
			  733,  735,  736,  738,  739,  742,  744,  746,  747,  749,
			  751,  752,  753,  755,  756,  758,  759,  761,  762,  765,
			  767,  769,  770,  772,  773,  775,  776,  778,  779,  781,
			  782,  784,  785,  787,  788,  791,  793,  795,  796,  799,
			  801,  803,  804,  807,  809,  811,  813,  814,  815,  817,
			  818,  820,  821,  823,  824,  826,  827,  829,  831,  832,
			  833,  835,  836,  838,  839,  841,  842,  844,  845,  848,

			  850,  853,  855,  857,  858,  860,  861,  863,  864,  866,
			  867,  870,  872,  875,  877,  877,  878,  879,  881,  881,
			  881,  883,  883,  887,  887,  889,  889,  889,  891,  894,
			  896,  899,  901,  903,  904,  907,  909,  912,  914,  916,
			  917,  919,  920,  922,  923,  926,  928,  930,  931,  933,
			  934,  936,  937,  939,  940,  942,  943,  945,  946,  949,
			  951,  953,  954,  956,  957,  959,  960,  962,  963,  966,
			  968,  970,  971,  973,  974,  976,  977,  980,  982,  984,
			  985,  987,  988,  990,  991,  993,  994,  996,  997,  999,
			 1000, 1002, 1003, 1005, 1006, 1008, 1009, 1012, 1014, 1016,

			 1017, 1019, 1020, 1023, 1025, 1027, 1028, 1030, 1031, 1034,
			 1036, 1038, 1039, 1039, 1040, 1040, 1042, 1042, 1043, 1044,
			 1048, 1048, 1048, 1050, 1050, 1051, 1051, 1054, 1056, 1058,
			 1059, 1062, 1064, 1066, 1067, 1069, 1070, 1072, 1073, 1076,
			 1078, 1081, 1083, 1085, 1086, 1089, 1091, 1093, 1094, 1096,
			 1097, 1100, 1102, 1104, 1105, 1107, 1108, 1110, 1111, 1113,
			 1114, 1116, 1117, 1119, 1120, 1122, 1123, 1126, 1128, 1130,
			 1131, 1133, 1134, 1137, 1139, 1141, 1142, 1145, 1147, 1150,
			 1152, 1155, 1157, 1159, 1160, 1162, 1163, 1166, 1168, 1170,
			 1171, 1171, 1172, 1172, 1172, 1172, 1176, 1176, 1177, 1178,

			 1178, 1178, 1179, 1180, 1181, 1184, 1186, 1188, 1189, 1192,
			 1194, 1196, 1197, 1199, 1200, 1202, 1203, 1206, 1208, 1211,
			 1213, 1215, 1216, 1219, 1221, 1224, 1226, 1228, 1229, 1231,
			 1232, 1234, 1235, 1237, 1238, 1240, 1241, 1244, 1246, 1248,
			 1249, 1251, 1252, 1255, 1257, 1258, 1258, 1259, 1259, 1261,
			 1261, 1261, 1262, 1263, 1263, 1264, 1267, 1269, 1272, 1274,
			 1277, 1279, 1282, 1284, 1287, 1289, 1291, 1292, 1295, 1297,
			 1299, 1300, 1303, 1305, 1307, 1308, 1311, 1313, 1316, 1318,
			 1319, 1321, 1321, 1323, 1324, 1327, 1329, 1332, 1334, 1337,
			 1339, 1341, 1341, yy_Dummy>>)
		end

	yy_acclist_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,  138,  138,  156,  154,  155,    3,  154,  155,    4,
			  155,    1,  154,  155,    2,  154,  155,   10,  154,  155,
			  140,  154,  155,  104,  154,  155,   17,  154,  155,  140,
			  154,  155,  154,  155,   11,  154,  155,   12,  154,  155,
			   31,  154,  155,   30,  154,  155,    8,  154,  155,   29,
			  154,  155,    6,  154,  155,   32,  154,  155,  142,  146,
			  154,  155,  142,  146,  154,  155,  142,  146,  154,  155,
			    9,  154,  155,    7,  154,  155,   36,  154,  155,   34,
			  154,  155,   35,  154,  155,  154,  155,  102,  103,  154,
			  155,  102,  103,  154,  155,  102,  103,  154,  155,  102,

			  103,  154,  155,  102,  103,  154,  155,  102,  103,  154,
			  155,  102,  103,  154,  155,  102,  103,  154,  155,  102,
			  103,  154,  155,  102,  103,  154,  155,  102,  103,  154,
			  155,  102,  103,  154,  155,  102,  103,  154,  155,  102,
			  103,  154,  155,  102,  103,  154,  155,  102,  103,  154,
			  155,  102,  103,  154,  155,  102,  103,  154,  155,  102,
			  103,  154,  155,   15,  154,  155,  154,  155,   16,  154,
			  155,   33,  154,  155,  146,  154,  155,  154,  155,  103,
			  154,  155,  103,  154,  155,  103,  154,  155,  103,  154,
			  155,  103,  154,  155,  103,  154,  155,  103,  154,  155,

			  103,  154,  155,  103,  154,  155,  103,  154,  155,  103,
			  154,  155,  103,  154,  155,  103,  154,  155,  103,  154,
			  155,  103,  154,  155,  103,  154,  155,  103,  154,  155,
			  103,  154,  155,  103,  154,  155,   13,  154,  155,   14,
			  154,  155,  138,  155,  136,  155,  137,  155,  132,  138,
			  155,  135,  155,  138,  155,  138,  155,    3,    4,    1,
			    2,   37,  140,  139,  139, -130,  140, -285, -131,  140,
			 -286,  104,  140,  128,  128,  128,    5,   23,   24,  149,
			  152,   18,   20,  142,  146,  142,  146,  141,  146,  141,
			   28,   25,   22,   21,   26,   27,  102,  103,  102,  103,

			  102,  103,  102,  103,   42,  102,  103,  103,  103,  103,
			  103,   42,  103,  102,  103,  103,  102,  103,  102,  103,
			  102,  103,  102,  103,  102,  103,  103,  103,  103,  103,
			  103,  102,  103,   53,  102,  103,  103,   53,  103,  102,
			  103,  102,  103,  102,  103,  103,  103,  103,  102,  103,
			  102,  103,  102,  103,  103,  103,  103,   65,  102,  103,
			  102,  103,  102,  103,   72,  102,  103,   65,  103,  103,
			  103,   72,  103,  102,  103,  102,  103,  103,  103,  102,
			  103,  103,  102,  103,  102,  103,  102,  103,   80,  102,
			  103,  103,  103,  103,   80,  103,  102,  103,  103,  102,

			  103,  103,  102,  103,  102,  103,  103,  103,  102,  103,
			  102,  103,  103,  103,  102,  103,  103,  102,  103,  102,
			  103,  103,  103,  102,  103,  103,  102,  103,  103,   19,
			  146,  138,  136,  137,  132,  138,  138,  138,  135,  133,
			  138,  134,  138,  139,  140,  139,  140, -130,  140, -131,
			  140,  128,  105,  128,  128,  128,  128,  128,  128,  128,
			  128,  128,  128,  128,  128,  128,  128,  128,  128,  128,
			  128,  128,  128,  128,  128,  128,  149,  152,  147,  149,
			  152,  147,  142,  146,  142,  146,  145,  144,  143,  142,
			  146,  146,  102,  103,  103,  102,  103,   40,  102,  103,

			  103,   40,  103,   41,  102,  103,   41,  103,  102,  103,
			  103,   44,  102,  103,   44,  103,  102,  103,  103,  102,
			  103,  103,  102,  103,  103,  102,  103,  103,  102,  103,
			  103,  102,  103,  102,  103,  103,  103,  102,  103,  103,
			   56,  102,  103,  102,  103,   56,  103,  103,  102,  103,
			  102,  103,  103,  103,  102,  103,  103,  102,  103,  103,
			  102,  103,  103,  102,  103,  103,  102,  103,  102,  103,
			  102,  103,  102,  103,  102,  103,  103,  103,  103,  103,
			  103,  102,  103,  103,  102,  103,  102,  103,  103,  103,
			   76,  102,  103,   76,  103,  102,  103,  103,   78,  102,

			  103,   78,  103,  102,  103,  103,  102,  103,  103,  102,
			  103,  102,  103,  102,  103,  102,  103,  102,  103,  102,
			  103,  103,  103,  103,  103,  103,  103,  102,  103,  102,
			  103,  103,  103,  102,  103,  103,  102,  103,  103,  102,
			  103,  103,  102,  103,  102,  103,  102,  103,  103,  103,
			  103,  102,  103,  103,  102,  103,  103,  102,  103,  103,
			  101,  102,  103,  101,  103,  153,  133,  134,  139,  139,
			  139,  122,  120,  121,  123,  124,  129,  125,  126,  106,
			  107,  108,  109,  110,  111,  112,  113,  114,  115,  116,
			  117,  118,  119,  149,  152,  149,  152,  149,  152,  148,

			  151,  142,  146,  142,  146,  142,  146,  142,  146,  102,
			  103,  103,  102,  103,  103,  102,  103,  103,  102,  103,
			  103,  102,  103,  103,  102,  103,  103,  102,  103,  103,
			  102,  103,  103,  102,  103,  103,  102,  103,  103,   54,
			  102,  103,   54,  103,  102,  103,  103,  102,  103,  102,
			  103,  103,  103,  102,  103,  103,  102,  103,  103,  102,
			  103,  103,   63,  102,  103,  102,  103,   63,  103,  103,
			  102,  103,  103,  102,  103,  103,  102,  103,  103,  102,
			  103,  103,  102,  103,  103,  102,  103,  103,   73,  102,
			  103,   73,  103,  102,  103,  103,   75,  102,  103,   75,

			  103,  102,  103,  103,   79,  102,  103,   79,  103,  102,
			  103,  102,  103,  103,  103,  102,  103,  103,  102,  103,
			  103,  102,  103,  103,  102,  103,  103,  102,  103,  102,
			  103,  103,  103,  102,  103,  103,  102,  103,  103,  102,
			  103,  103,  102,  103,  103,   93,  102,  103,   93,  103,
			   94,  102,  103,   94,  103,  102,  103,  103,  102,  103,
			  103,  102,  103,  103,  102,  103,  103,   99,  102,  103,
			   99,  103,  100,  102,  103,  100,  103,  129,  149,  149,
			  152,  149,  152,  148,  149,  151,  152,  148,  151,  142,
			  146,   38,  102,  103,   38,  103,   39,  102,  103,   39,

			  103,  102,  103,  103,   45,  102,  103,   45,  103,   46,
			  102,  103,   46,  103,  102,  103,  103,  102,  103,  103,
			  102,  103,  103,   51,  102,  103,   51,  103,  102,  103,
			  103,  102,  103,  103,  102,  103,  103,  102,  103,  103,
			  102,  103,  103,  102,  103,  103,   61,  102,  103,   61,
			  103,  102,  103,  103,  102,  103,  103,  102,  103,  103,
			  102,  103,  103,   68,  102,  103,   68,  103,  102,  103,
			  103,  102,  103,  103,  102,  103,  103,   74,  102,  103,
			   74,  103,  102,  103,  103,  102,  103,  103,  102,  103,
			  103,  102,  103,  103,  102,  103,  103,  102,  103,  103,

			  102,  103,  103,  102,  103,  103,  102,  103,  103,   89,
			  102,  103,   89,  103,  102,  103,  103,  102,  103,  103,
			   92,  102,  103,   92,  103,  102,  103,  103,  102,  103,
			  103,   97,  102,  103,   97,  103,  102,  103,  103,  127,
			  149,  152,  152,  149,  148,  149,  151,  152,  148,  151,
			  147,   43,  102,  103,   43,  103,  102,  103,  103,   48,
			  102,  103,  102,  103,   48,  103,  103,  102,  103,  103,
			  102,  103,  103,   55,  102,  103,   55,  103,   57,  102,
			  103,   57,  103,  102,  103,  103,   59,  102,  103,   59,
			  103,  102,  103,  103,  102,  103,  103,   64,  102,  103,

			   64,  103,  102,  103,  103,  102,  103,  103,  102,  103,
			  103,  102,  103,  103,  102,  103,  103,  102,  103,  103,
			  102,  103,  103,   82,  102,  103,   82,  103,  102,  103,
			  103,  102,  103,  103,   85,  102,  103,   85,  103,  102,
			  103,  103,   87,  102,  103,   87,  103,   88,  102,  103,
			   88,  103,   90,  102,  103,   90,  103,  102,  103,  103,
			  102,  103,  103,   96,  102,  103,   96,  103,  102,  103,
			  103,  149,  148,  149,  151,  152,  152,  148,  150,  152,
			  150,   47,  102,  103,   47,  103,  102,  103,  103,   50,
			  102,  103,   50,  103,  102,  103,  103,  102,  103,  103,

			  102,  103,  103,   62,  102,  103,   62,  103,   66,  102,
			  103,   66,  103,  102,  103,  103,   69,  102,  103,   69,
			  103,   70,  102,  103,   70,  103,  102,  103,  103,  102,
			  103,  103,  102,  103,  103,  102,  103,  103,  102,  103,
			  103,   86,  102,  103,   86,  103,  102,  103,  103,  102,
			  103,  103,   98,  102,  103,   98,  103,  152,  152,  148,
			  149,  151,  152,  151,   49,  102,  103,   49,  103,   52,
			  102,  103,   52,  103,   58,  102,  103,   58,  103,   60,
			  102,  103,   60,  103,   67,  102,  103,   67,  103,  102,
			  103,  103,   77,  102,  103,   77,  103,  102,  103,  103,

			   84,  102,  103,   84,  103,  102,  103,  103,   91,  102,
			  103,   91,  103,   95,  102,  103,   95,  103,  152,  151,
			  152,  151,  152,  151,   71,  102,  103,   71,  103,   81,
			  102,  103,   81,  103,   83,  102,  103,   83,  103,  151,
			  152, yy_Dummy>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER is 2855
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER is 791
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER is 792
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

	yyNb_rules: INTEGER is 155
			-- Number of rules

	yyEnd_of_buffer: INTEGER is 156
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
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- EDITOR_EIFFEL_SCANNER
