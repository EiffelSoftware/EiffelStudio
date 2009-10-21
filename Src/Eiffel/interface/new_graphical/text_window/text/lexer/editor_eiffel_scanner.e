note
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

	valid_start_condition (sc: INTEGER): BOOLEAN
			-- Is `sc' a valid start condition?
		do
			Result := (INITIAL <= sc and sc <= VERBATIM_STR1)
		end

feature {NONE} -- Implementation

	yy_build_tables
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

	yy_execute_action (yy_act: INTEGER)
			-- Execute semantic action.
		do
			inspect yy_act
when 1 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end
-- Ignore carriage return
when 2 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

					curr_token := new_space (text_count)
					update_token_list
					
when 3 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

					if not in_comments then
						curr_token := new_tabulation (text_count)
					else
						curr_token := new_comment (text)
					end
					update_token_list
					
when 4 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

					from i_ := 1 until i_ > text_count loop
						curr_token := new_eol
						update_token_list
						i_ := i_ + 1
					end
					in_comments := False
					
when 5 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end
 
						-- comments
					curr_token := new_comment (text)
					in_comments := True	
					update_token_list					
				
when 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

						-- Symbols
					if not in_comments then
						curr_token := new_text (text)
					else
						curr_token := new_comment (text)
					end
					update_token_list
					
when 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end
 
						-- Operator Symbol
					if not in_comments then
						curr_token := new_operator (text)					
					else
						curr_token := new_comment (text)
					end
					update_token_list
					
when 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

										-- Keyword
										if not in_comments then
											curr_token := new_keyword (text)
										else
											curr_token := new_comment (text)
										end
										update_token_list
										
when 105, 106, 107, 108 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

							if syntax_version /= {EIFFEL_SCANNER}.obsolete_64_syntax then
									-- Keyword
								if not in_comments then
									curr_token := new_keyword (text)
								else
									curr_token := new_comment (text)
								end
							else
								curr_token := new_text (text)
							end
							update_token_list
						
when 109 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

							if syntax_version /= {EIFFEL_SCANNER}.ecma_syntax then
									-- Keyword
								if not in_comments then
									curr_token := new_keyword (text)
								else
									curr_token := new_comment (text)
								end
							else
								curr_token := new_text (text)
							end
							update_token_list
						
when 110 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

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
										
when 111 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

										if not in_comments then
											curr_token := new_text (text)											
										else
											curr_token := new_comment (text)
										end
										update_token_list
										
when 112 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

										if not in_comments then
											curr_token := new_text (text)										
										else
											curr_token := new_comment (text)
										end
										update_token_list
										
when 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 131, 132, 133, 134 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

					if not in_comments then
						curr_token := new_character (text)
					else
						curr_token := new_comment (text)
					end
					update_token_list
					
when 135 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

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
					
when 136 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

					-- Character error. Catch-all rules (no backing up)
					if not in_comments then
						curr_token := new_text (text)
					else
						curr_token := new_comment (text)
					end
					update_token_list
					
when 137 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

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
			
when 138 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

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
			
when 139 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end
-- Ignore carriage return
when 140 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

							-- Verbatim string closer, possibly.
						curr_token := new_string (text)						
						end_of_verbatim_string := True
						in_verbatim_string := False
						set_start_condition (INITIAL)
						update_token_list
					
when 141 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

							-- Verbatim string closer, possibly.
						curr_token := new_string (text)						
						end_of_verbatim_string := True
						in_verbatim_string := False
						set_start_condition (INITIAL)
						update_token_list
					
when 142 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

						curr_token := new_space (text_count)
						update_token_list						
					
when 143 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end
						
						curr_token := new_tabulation (text_count)
						update_token_list						
					
when 144 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

						from i_ := 1 until i_ > text_count loop
							curr_token := new_eol
							update_token_list
							i_ := i_ + 1
						end						
					
when 145 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

						curr_token := new_string (text)
						update_token_list
					
when 146, 147 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

					-- Eiffel String
					if not in_comments then						
						curr_token := new_string (text)
					else
						curr_token := new_comment (text)
					end
					update_token_list
					
when 148 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

					-- Eiffel Bit
					if not in_comments then
						curr_token := new_number (text)						
					else
						curr_token := new_comment (text)
					end
					update_token_list
					
when 149, 150, 151, 152 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

						-- Eiffel Integer
						if not in_comments then
							curr_token := new_number (text)
						else
							curr_token := new_comment (text)
						end
						update_token_list
						
when 153, 154, 155, 156 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

						-- Bad Eiffel Integer
						if not in_comments then
							curr_token := new_text (text)
						else
							curr_token := new_comment (text)
						end
						update_token_list
						
when 157 then
	yy_end := yy_end - 1
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

							-- Eiffel reals & doubles
						if not in_comments then		
							curr_token := new_number (text)
						else
							curr_token := new_comment (text)
						end
						update_token_list
						
when 158, 159 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

							-- Eiffel reals & doubles
						if not in_comments then		
							curr_token := new_number (text)
						else
							curr_token := new_comment (text)
						end
						update_token_list
						
when 160 then
	yy_end := yy_end - 1
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

							-- Eiffel reals & doubles
						if not in_comments then		
							curr_token := new_number (text)
						else
							curr_token := new_comment (text)
						end
						update_token_list
						
when 161, 162 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

							-- Eiffel reals & doubles
						if not in_comments then		
							curr_token := new_number (text)
						else
							curr_token := new_comment (text)
						end
						update_token_list
						
when 163 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

					curr_token := new_text (text)
					update_token_list
					
when 164 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

					-- Error (considered as text)
				if not in_comments then
					curr_token := new_text (text)
				else
					curr_token := new_comment (text)
				end
				update_token_list
				
when 165 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end
default_action
			else
				last_token := yyError_token
				fatal_error ("fatal scanner internal error: no action found")
			end
		end

	yy_execute_eof_action (yy_sc: INTEGER)
			-- Execute EOF semantic action.
		do
			inspect yy_sc
when 0, 1 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end
terminate
			else
				terminate
			end
		end

feature {NONE} -- Table templates

	yy_nxt_template: SPECIAL [INTEGER]
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make (0, 8017)
			yy_nxt_template_1 (an_array)
			yy_nxt_template_2 (an_array)
			yy_nxt_template_3 (an_array)
			yy_nxt_template_4 (an_array)
			yy_nxt_template_5 (an_array)
			yy_nxt_template_6 (an_array)
			yy_nxt_template_7 (an_array)
			yy_nxt_template_8 (an_array)
			yy_nxt_template_9 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_nxt_template_1 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			    0,    6,    7,    8,    9,   10,   11,   12,   13,   14,
			   15,   16,   17,   18,   19,   20,   21,   22,   23,   24,
			   25,   26,   27,   27,   28,   29,   30,   31,   32,   33,
			   34,   35,   36,   37,   38,   39,   40,   40,   41,   40,
			   40,   42,   40,   43,   44,   45,   40,   46,   47,   48,
			   49,   50,   51,   52,   40,   40,   53,   54,   55,   56,
			    6,   57,   58,   59,   60,   61,   62,   63,   64,   64,
			   65,   64,   64,   66,   64,   67,   68,   69,   64,   70,
			   71,   72,   73,   74,   75,   76,   64,   64,   77,   78,
			   79,    6,    6,    6,   80,   81,   82,   83,   84,   85,

			   86,   88,   89,   90,   91,  139,  137,  140,  140,  140,
			  140,  141,  159,   88,   89,   90,   91,  138,  879,  142,
			  144, 1076,  145,  145,  146,  146,  154,  155,  156,  157,
			  772,  107,  232,  152,  108,  192,  159,  765,  107,  159,
			  128,  108,  128,  128,  166,  193,  620,  144,  129,  146,
			  146,  146,  146,  216,  159,  159,  618,   92,  196,  217,
			  197, 1076,  151,  386,  233,  152,  616,  194,  166,   92,
			  198,  166,  159,  159,  159,  159,  620,  195,  272,  272,
			  109,  230,  143,  250,  159,  218,  166,  166,   93,  151,
			  199,  219,  200,   94,   95,   96,   97,   98,   99,  100,

			   93,  618,  201,  386,  166,   94,   95,   96,   97,   98,
			   99,  100,  110,  231,  616,  251,  166,  582,  111,  112,
			  113,  114,  115,  116,  117,  120,  121,  122,  123,  124,
			  125,  126,  130,  131,  132,  133,  134,  135,  136,  144,
			  159,  145,  145,  146,  146,  288,  220,  202,  411,  411,
			  159,  203,  148,  149,  159,  159,  180,  159,  234,  159,
			  159,  159,  159,  252,  204,  244,  159,  159,  235,  159,
			  240,  159,  166,  236,  150,  271,  271,  271,  221,  205,
			  241,  151,  166,  206,  148,  149,  166,  166,  181,  166,
			  237,  166,  166,  166,  166,  253,  207,  245,  166,  166,

			  238,  166,  242,  166, 1076,  239,  150,  159,  159,  159,
			  159,  527,  243,  273,  273,  273,  159,  159,  159,  160,
			  159,  159,  159,  161,  159,  159,  159,  159,  162,  159,
			  163,  159,  159,  159,  159,  164,  165,  159,  159,  159,
			  159,  159,  159,  274,  274,  274,  386,  159,  166,  166,
			  166,  167,  166,  166,  166,  168,  166,  166,  166,  166,
			  169,  166,  170,  166,  166,  166,  166,  171,  172,  166,
			  166,  166,  166,  166,  166,  144,  159,  385,  385,  385,
			  385,  173,  174,  175,  176,  177,  178,  179,  182,  159,
			  222,  284,  183,  285,  285,  184,  208,  159,  185,  159,

			  223,  186,  224,  209,  210,  246,  225,  522,  166,  211,
			  397,  403,  159,  159,  159,  414,  159,  151,  409,  247,
			  187,  166,  226,  342,  188,  524,  524,  189,  212,  166,
			  190,  166,  227,  191,  228,  213,  214,  248,  229,  387,
			  387,  215,  398,  404,  166,  166,  166,  286,  166,  159,
			  194,  249,  256,  257,  258,  259,  260,  261,  262,  167,
			  195,  499,  166,  168,  166,  166,  399,  166,  169,  400,
			  170,  231,  181,  509,  166,  171,  172,  166,  287,  386,
			  104,  166,  194,  277,  278,  279,  280,  281,  282,  283,
			  103,  167,  195,  500,  166,  168,  166,  166,  401,  166,

			  169,  402,  170,  231,  181,  510,  166,  171,  172,  166,
			  263,  264,  265,  266,  267,  268,  269,  389,  389,  389,
			  102,  263,  264,  265,  266,  267,  268,  269,  263,  264,
			  265,  266,  267,  268,  269,  187,  159,  159,  218,  188,
			  159,  166,  189,  166,  219,  190,  395,  199,  191,  200,
			  405,  159,  159,  166,  159,  159,  159,  386,  447,  201,
			  277,  278,  279,  280,  281,  282,  283,  187,  166,  166,
			  218,  188,  166,  166,  189,  166,  219,  190,  396,  199,
			  191,  200,  406,  166,  166,  166,  410,  410,  410,  101,
			  448,  201,  263,  264,  265,  266,  267,  268,  269,  288,

			  263,  264,  265,  266,  267,  268,  269,  205,  212,  275,
			  166,  206,  166,  221,  166,  213,  214,  159,  166,  226,
			  166,  215,  166,  417,  207,  270,  166,  159,  407,  227,
			  166,  228,  412,  412,  412,  229,  413,  413,  413,  205,
			  212,  166,  166,  206,  166,  221,  166,  213,  214,  166,
			  166,  226,  166,  215,  166,  418,  207,  233,  166,  166,
			  408,  227,  166,  228,  166,  237,  166,  229,  382,  382,
			  382,  382,  166,  166,  166,  238,  166,  242,  387,  387,
			  239,  166,  383,  166,  166,  629,  254,  243,  166,  233,
			  245,  158,  285,  166,  289,  285,  166,  237,  166,  153,

			  166,  105,  104,  419,  166,  103,  166,  238,  166,  242,
			  248,  159,  239,  166,  383,  166,  166,  630,  615,  243,
			  166,  166,  245,  166,  249,  166,  166,  423,  166,  253,
			  251,  159,  166,  166,  166,  420,  166,  285,  166,  285,
			  292,  159,  248,  166,  286,  159,  166,  286,  290,  293,
			  421,  433,  276,  166,  102,  166,  249,  101,  166,  424,
			  166,  253,  251,  166,  287,  166,  166,  287,  166,  301,
			  166, 1076,  276,  166,  166,  166,  166,  166,  166,  291,
			 1076, 1076,  422,  434,  277,  278,  279,  280,  281,  282,
			  283,  159, 1076,  286,  309,  277,  278,  279,  280,  281,

			  282,  283,  310,  310,  310,  277,  278,  279,  280,  281,
			  282,  283,  311,  311,  342,  277,  278,  279,  280,  281,
			  282,  283,  342,  166,  287,  312,  312,  312,  277,  278,
			  279,  280,  281,  282,  283, 1076,  294,  295,  296,  297,
			  298,  299,  300,  313,  313,  313,  277,  278,  279,  280,
			  281,  282,  283,  523,  523,  523,  302,  303,  304,  305,
			  306,  307,  308,  314,  159, 1076,  277,  278,  279,  280,
			  281,  282,  283,  107,  387,  387,  108,  378,  378,  378,
			  378,  166,  144,  166,  384,  384,  385,  385,  525,  525,
			  525,  379, 1076,  166, 1076,  152,  166,  343,  344,  345,

			  346,  347,  348,  349,  372,  343,  344,  345,  346,  347,
			  348,  349, 1076,  166,  615,  166, 1076,  380,  393,  393,
			  393,  393,  109,  379,  151,  166,  327,  152,  327,  327,
			 1076,  107, 1076, 1076,  108, 1076,  398,  675, 1076,  328,
			 1076,  328,  328,  166,  107,  166,  159,  108, 1076, 1076,
			  159,  159, 1076,  443,  110,  166, 1076,  415,  394, 1076,
			  111,  112,  113,  114,  115,  116,  117,  316,  398,  676,
			  317,  119,  119,  119, 1076,  166, 1076,  166,  166,  318,
			  109,  107,  166,  166,  108,  444,  119,  166,  119,  416,
			  119,  119,  319,  109, 1076,  119,  107,  119, 1076,  108, yy_Dummy>>,
			1, 1000, 0)
		end

	yy_nxt_template_2 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 1076,  119, 1076,  119, 1076, 1076,  119,  119,  119,  119,
			  119,  119,  110, 1076,  107, 1076,  719,  108,  111,  112,
			  113,  114,  115,  116,  117,  110,  107, 1076, 1076,  108,
			  109,  111,  112,  113,  114,  115,  116,  117,  526,  526,
			  526,  107, 1076, 1076,  108,  109, 1076,  159,  720,  461,
			  159,  159,  159, 1076,  320,  321,  322,  323,  324,  325,
			  326,  107,  110,  109,  108,  159,  159,  159,  111,  112,
			  113,  114,  115,  116,  117,  107, 1076,  110,  108,  166,
			  729,  462,  329,  111,  112,  113,  114,  115,  116,  117,
			  109,  107, 1076, 1076,  108,  110, 1076, 1076,  330,  330,

			  330,  111,  112,  113,  114,  115,  116,  117,  107,  731,
			  109,  108,  730,  120,  121,  122,  123,  124,  125,  126,
			  107, 1076,  110,  108,  109,  331,  331, 1076,  111,  112,
			  113,  114,  115,  116,  117,  107, 1076,  159,  108,  159,
			  109,  732,  110, 1076,  449,  332,  332,  332,  111,  112,
			  113,  114,  115,  116,  117,  107,  110, 1076,  108,  333,
			  333,  333,  111,  112,  113,  114,  115,  116,  117,  166,
			  107,  166,  110,  108, 1076,  334,  450, 1076,  111,  112,
			  113,  114,  115,  116,  117,  107,  785, 1076,  108,  159,
			  159,  159,  159,  159,  159,  120,  121,  122,  123,  124,

			  125,  126,  107, 1076, 1076,  108,  335,  120,  121,  122,
			  123,  124,  125,  126,  528,  528,  528, 1076,  786,  336,
			  336,  336,  120,  121,  122,  123,  124,  125,  126,  529,
			  529,  529,  277,  278,  279,  280,  281,  282,  283,  337,
			  337, 1076,  120,  121,  122,  123,  124,  125,  126,  475,
			  159,  159,  159,  159,  338,  338,  338,  120,  121,  122,
			  123,  124,  125,  126,  342,  607,  607,  607,  607,  339,
			  339,  339,  120,  121,  122,  123,  124,  125,  126,  342,
			  159,  476,  803, 1076,  493,  166,  340,  515, 1076,  120,
			  121,  122,  123,  124,  125,  126,  350, 1076, 1076,  351,

			  352,  353,  354,  159,  159,  159, 1076, 1076,  355,  159,
			  342, 1076,  166, 1076,  804,  356,  494,  357, 1076,  358,
			  359,  360,  361,  342,  362,  819,  363,  159,  159,  159,
			  364, 1076,  365,  342, 1076,  366,  367,  368,  369,  370,
			  371,  166, 1076,  342,  127,  127,  127,  343,  344,  345,
			  346,  347,  348,  349,  159,  159,  159,  820, 1076,  373,
			  373,  373,  343,  344,  345,  346,  347,  348,  349, 1076,
			  256,  257,  258,  259,  260,  261,  262,  635,  635,  635,
			  636,  636,  636,  343,  344,  345,  346,  347,  348,  349,
			  374,  374,  159,  343,  344,  345,  346,  347,  348,  349,

			  166,  166,  166,  375,  375,  375,  343,  344,  345,  346,
			  347,  348,  349,  376,  376,  376,  343,  344,  345,  346,
			  347,  348,  349,  377,  166,  159,  343,  344,  345,  346,
			  347,  348,  349,  391,  391,  391,  391,  401, 1076,  159,
			  402, 1076,  166,  391,  391,  391,  391,  391,  391,  166,
			  404,  166,  166,  159,  166,  396,  166,  166,  166, 1076,
			  166,  166,  408,  166,  166,  166,  166, 1076,  821,  401,
			  166,  166,  402,  386,  166,  391,  391,  391,  391,  391,
			  391,  166,  404,  166,  166,  166,  166,  396,  166,  166,
			  166,  166,  166,  166,  408,  166,  406,  166,  166,  159,

			  822,  166,  166,  416,  166,  418,  422,  166,  425,  420,
			 1076,  159,  166,  166,  166,  166,  166, 1076,  445, 1076,
			  166,  166,  166,  166,  166,  166,  159,  166,  406,  166,
			 1076,  166,  166,  166, 1076,  416,  166,  418,  422,  166,
			  426,  420,  424,  166,  166,  166,  166,  166,  166,  166,
			  446,  166,  166,  166,  166,  166,  166,  166,  166,  426,
			  159,  166,  427, 1076,  166,  166,  428,  471, 1076,  159,
			 1076,  435,  159,  641,  424, 1076,  159,  166,  430,  166,
			  429,  166,  431,  166,  434,  166,  436,  166,  166,  166,
			  166,  426,  166,  166,  430,  159,  432,  166,  431,  472,

			  166,  166,  439,  437,  166,  642,  440,  463,  166,  166,
			  430,  166,  432,  159,  431,  437,  434, 1076,  438,  464,
			  166,  166,  166,  166,  444,  166,  166,  166,  432,  166,
			  438,  166,  166,  441,  441,  166,  166,  442,  442,  465,
			  166,  166,  166,  448, 1076,  166,  284,  437,  285,  285,
			 1076,  466,  166,  446, 1076,  166,  444,  166,  166, 1076,
			 1076,  166,  438,  166,  166,  441,  166,  166,  166,  442,
			 1076,  837,  166,  166,  166,  448,  166,  451,  166,  452,
			  166,  453,  159,  159,  166,  446,  159,  166,  625,  166,
			  166,  450,  454, 1076, 1076,  455,  166,  467,  166,  166,

			 1076, 1076,  286,  838, 1076,  166, 1076,  166,  166,  456,
			  166,  457,  166,  458,  166,  166, 1076,  166,  166,  166,
			  626,  166,  166,  450,  459,  462,  166,  460,  166,  468,
			  159,  166,  456,  287,  457, 1076,  458,  166,  166,  166,
			  166,  159,  166,  159,  465,  823,  671,  459,  473,  166,
			  460,  469,  166,  166,  159,  166,  466,  462,  166,  166,
			  166,  166,  166, 1076,  456,  166,  457,  468,  458, 1076,
			  166,  166,  166,  166,  166,  166,  465,  824,  672,  459,
			  474, 1076,  460,  470,  166,  166,  166,  166,  466, 1076,
			  472,  166, 1076,  166,  166,  159,  166,  166,  166,  468,

			  166,  470,  474,  166,  495,  166,  166,  166, 1076,  159,
			  166,  166,  476,  166,  497,  623,  845,  166,  159,  166,
			 1076,  166,  472,  166,  501, 1076,  166,  166,  166,  502,
			  166,  166,  166,  470,  474, 1076,  496,  166,  166,  166,
			  503,  166,  166,  166,  476,  166,  498,  624,  846,  166,
			  166,  166,  477,  166,  478,  166,  504,  159,  166,  494,
			  166,  505,  479,  166,  159,  480,  159,  481,  482, 1076,
			  166, 1076,  506,  159,  511,  507,  489, 1076,  159, 1076,
			  490,  166, 1076,  166,  483, 1076,  484,  496, 1076,  166,
			  166,  494,  166,  166,  485, 1076,  166,  486,  166,  487,

			  488,  483,  166,  484, 1076,  166,  512,  508,  491,  166,
			  166,  485,  492,  166,  486,  166,  487,  488,  491,  496,
			  166,  166,  492,  159,  159,  166, 1076,  166, 1076,  166,
			  166, 1076, 1076,  483,  639,  484,  500, 1076,  498,  166,
			 1076,  166, 1076,  485,  515,  166,  486,  166,  487,  488,
			  491, 1076,  166,  166,  492,  166,  166,  166,  159,  166,
			  510,  166,  166,  166,  504,  166,  640,  513,  500,  505,
			  498,  166,  166,  515,  166,  166,  166,  166,  166,  166,
			  506,  166,  508,  166,  166,  515,  627,  514,  166,  166,
			  166, 1076,  510,  166,  159,  166,  504,  166,  515,  514, yy_Dummy>>,
			1, 1000, 1000)
		end

	yy_nxt_template_3 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 1076,  505,  512, 1076,  166, 1076,  166,  166,  166,  166,
			  166,  166,  506,  166,  508,  166,  166,  515,  628,  514,
			  166,  166,  166,  166,  166,  166,  166,  256,  257,  258,
			  259,  260,  261,  262,  512,  515,  389,  389,  389, 1076,
			 1076,  166, 1076,  166, 1076,  515,  277,  278,  279,  280,
			  281,  282,  283,  166, 1076,  516,  256,  257,  258,  259,
			  260,  261,  262, 1076,  159,  517,  517,  517,  256,  257,
			  258,  259,  260,  261,  262, 1076,  617, 1076,  518,  518,
			 1076,  256,  257,  258,  259,  260,  261,  262,  309,  277,
			  278,  279,  280,  281,  282,  283,  166,  519,  519,  519,

			  256,  257,  258,  259,  260,  261,  262,  530,  166,  166,
			  166,  739,  739,  739,  538,  520,  520,  520,  256,  257,
			  258,  259,  260,  261,  262,  521, 1076, 1076,  256,  257,
			  258,  259,  260,  261,  262,  310,  310,  310,  277,  278,
			  279,  280,  281,  282,  283,  311,  311, 1076,  277,  278,
			  279,  280,  281,  282,  283,  312,  312,  312,  277,  278,
			  279,  280,  281,  282,  283,  313,  313,  313,  277,  278,
			  279,  280,  281,  282,  283,  314, 1076,  159,  277,  278,
			  279,  280,  281,  282,  283,  285, 1076,  285,  285,  285,
			 1076,  289,  285, 1076,  531,  532,  533,  534,  535,  536,

			  537,  539,  540,  541,  542,  543,  544,  545,  286,  166,
			 1076,  286, 1076,  293,  643,  287,  276,  159,  287, 1076,
			  301, 1076,  159,  276,  277,  278,  279,  280,  281,  282,
			  283, 1076,  285,  649,  285,  292,  159,  159, 1076,  286,
			 1076,  286,  286, 1076,  293,  290,  644,  276,  286,  166,
			 1076,  286, 1076,  293,  166, 1076,  276, 1076,  286,  651,
			 1076,  286, 1076,  293,  159,  650,  276,  159,  166,  166,
			  286, 1076,  287,  286, 1076,  293,  291, 1076,  276, 1076,
			 1076,  277,  278,  279,  280,  281,  282,  283,  286,  286,
			  159,  652,  286, 1076,  293, 1076,  166,  276, 1076,  166,

			  294,  295,  296,  297,  298,  299,  300,  302,  303,  304,
			  305,  306,  307,  308, 1076,  286, 1076, 1076,  286,  287,
			  293, 1076,  166,  276,  277,  278,  279,  280,  281,  282,
			  283,  294,  295,  296,  297,  298,  299,  300,  159,  546,
			  294,  295,  296,  297,  298,  299,  300,  547,  547,  547,
			  294,  295,  296,  297,  298,  299,  300, 1076,  159,  548,
			  548, 1076,  294,  295,  296,  297,  298,  299,  300,  286,
			  166, 1076,  286, 1076,  293, 1076, 1076,  276,  549,  549,
			  549,  294,  295,  296,  297,  298,  299,  300,  287,  159,
			  166,  287, 1076,  301,  721, 1076,  276,  277,  278,  279,

			  280,  281,  282,  283,  550,  550,  550,  294,  295,  296,
			  297,  298,  299,  300,  287, 1076, 1076,  287, 1076,  301,
			 1076,  166,  276, 1076,  287, 1076,  722,  287,  159,  301,
			 1076, 1076,  276, 1076,  287, 1076, 1076,  287,  663,  301,
			  637, 1076,  276,  159,  287,  159,  159,  287,  605,  301,
			  605, 1076,  276,  606,  606,  606,  606,  647,  551,  851,
			  166,  294,  295,  296,  297,  298,  299,  300,  287, 1076,
			  664,  287,  638,  301, 1076,  166,  276,  166,  166, 1076,
			  302,  303,  304,  305,  306,  307,  308,  287, 1076,  648,
			  287,  852,  301,  159, 1076,  276,  277,  278,  279,  280,

			  281,  282,  283, 1076, 1076,  552,  302,  303,  304,  305,
			  306,  307,  308,  553,  553,  553,  302,  303,  304,  305,
			  306,  307,  308,  554,  554,  166,  302,  303,  304,  305,
			  306,  307,  308,  555,  555,  555,  302,  303,  304,  305,
			  306,  307,  308,  277,  278,  279,  280,  281,  282,  283,
			  277,  278,  279,  280,  281,  282,  283,  556,  556,  556,
			  302,  303,  304,  305,  306,  307,  308,  107, 1076, 1076,
			  560,  740,  740,  740,  107,  921,  557,  108, 1076,  302,
			  303,  304,  305,  306,  307,  308,  558,  558,  558,  277,
			  278,  279,  280,  281,  282,  283,  559,  559,  559,  277,

			  278,  279,  280,  281,  282,  283,  561,  922,  159,  108,
			  159,  159,  159,  107,  653,  159,  560,  645,  159, 1076,
			  107,  691, 1076,  563, 1076, 1076,  562,  562,  562,  562,
			  107, 1076, 1076,  560,  159,  159,  159,  611,  107,  611,
			  166,  560,  612,  612,  612,  612,  654,  166,  107,  646,
			  166,  560, 1076,  692,  320,  321,  322,  323,  324,  325,
			  326,  120,  121,  122,  123,  124,  125,  126,  107, 1076,
			 1076,  560,  144, 1076,  614,  614,  614,  614,  107, 1076,
			 1076,  560,  606,  606,  606,  606, 1076, 1076,  107, 1076,
			 1076,  560, 1076,  120,  121,  122,  123,  124,  125,  126,

			  320,  321,  322,  323,  324,  325,  326,  320,  321,  322,
			  323,  324,  325,  326,  151, 1076, 1076,  320,  321,  322,
			  323,  324,  325,  326,  564,  320,  321,  322,  323,  324,
			  325,  326,  565,  565,  565,  320,  321,  322,  323,  324,
			  325,  326,  107, 1076, 1076,  560,  621,  621,  621,  621,
			 1076,  159,  566,  566, 1076,  320,  321,  322,  323,  324,
			  325,  326,  567,  567,  567,  320,  321,  322,  323,  324,
			  325,  326,  568,  568,  568,  320,  321,  322,  323,  324,
			  325,  326,  327,  166,  327,  327,  394,  107, 1076, 1076,
			  108,  766,  766,  766,  766,  328,  923,  328,  328, 1076,

			  107, 1076, 1076,  108, 1076,  604,  604,  604,  604,  781,
			  927,  159,  166,  107,  166,  624,  108, 1076, 1076,  379,
			  622,  622,  622,  622,  166, 1076,  569, 1076,  924,  320,
			  321,  322,  323,  324,  325,  326,  109,  107, 1076, 1076,
			  108,  782,  928,  166,  166,  380,  166,  624, 1076,  109,
			  107,  379,  159,  108, 1076, 1076,  166,  389,  389,  389,
			  394, 1076,  109,  107,  655, 1076,  108, 1076,  110,  608,
			  608,  608,  608, 1076,  111,  112,  113,  114,  115,  116,
			  117,  110,  107,  609,  166,  108,  109,  111,  112,  113,
			  114,  115,  116,  117,  110,  107,  656,  617,  108,  109,

			  111,  112,  113,  114,  115,  116,  117, 1076,  107,  610,
			 1076,  108,  109, 1076, 1076,  609,  107,  159,  110,  108,
			  764,  764,  764,  764,  111,  112,  113,  114,  115,  116,
			  117,  110,  107, 1076,  166,  108,  626,  111,  112,  113,
			  114,  115,  116,  117,  110,  107,  166, 1076,  108,  166,
			  111,  112,  113,  114,  115,  116,  117,  109,  107,  935,
			  765,  108,  770,  770,  770,  770,  166, 1076,  626,  120,
			  121,  122,  123,  124,  125,  126,  107, 1076,  166,  108,
			  159,  109,  120,  121,  122,  123,  124,  125,  126,  110,
			 1076,  936,  570,  570,  570,  111,  112,  113,  114,  115, yy_Dummy>>,
			1, 1000, 2000)
		end

	yy_nxt_template_4 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  116,  117, 1076,  120,  121,  122,  123,  124,  125,  126,
			 1076, 1076,  166,  110, 1076, 1076,  571,  571,  571,  111,
			  112,  113,  114,  115,  116,  117, 1076,  612,  612,  612,
			  612, 1076,  120,  121,  122,  123,  124,  125,  126, 1076,
			  159, 1076,  572,  572,  572,  120,  121,  122,  123,  124,
			  125,  126, 1076,  159,  159,  159,  159,  159,  159,  580,
			  573,  573,  573,  120,  121,  122,  123,  124,  125,  126,
			 1076, 1076,  166,  343,  344,  345,  346,  347,  348,  349,
			 1076,  771,  771,  771,  771,  343,  344,  345,  346,  347,
			  348,  349,  574,  343,  344,  345,  346,  347,  348,  349,

			  581,  166,  166,  166, 1076, 1076,  575,  575,  575,  343,
			  344,  345,  346,  347,  348,  349,  583, 1076, 1076,  576,
			  576,  772,  343,  344,  345,  346,  347,  348,  349,  584,
			  951, 1076,  577,  577,  577,  343,  344,  345,  346,  347,
			  348,  349,  343,  344,  345,  346,  347,  348,  349,  586,
			  578,  578,  578,  343,  344,  345,  346,  347,  348,  349,
			  579, 1076,  952,  343,  344,  345,  346,  347,  348,  349,
			  585,  585,  585,  585,  587,  166,  166,  166, 1076, 1076,
			 1076,  588, 1076,  343,  344,  345,  346,  347,  348,  349,
			  589,  661,  673,  159, 1076,  159,  159,  590,  628,  343,

			  344,  345,  346,  347,  348,  349,  591, 1076,  166,  166,
			  166,  166,  343,  344,  345,  346,  347,  348,  349,  592,
			  166,  166,  159,  662,  674,  166,  593,  166,  166, 1076,
			  628, 1076,  343,  344,  345,  346,  347,  348,  349,  594,
			  166,  166,  166,  166,  343,  344,  345,  346,  347,  348,
			  349,  595,  166,  166,  166,  530,  159,  343,  344,  345,
			  346,  347,  348,  349,  343,  344,  345,  346,  347,  348,
			  349,  596, 1076,  343,  344,  345,  346,  347,  348,  349,
			  343,  344,  345,  346,  347,  348,  349,  597,  166,  343,
			  344,  345,  346,  347,  348,  349,  598,  875,  875,  875,

			  875,  538,  343,  344,  345,  346,  347,  348,  349,  343,
			  344,  345,  346,  347,  348,  349,  599,  159,  166, 1076,
			  166,  159,  343,  344,  345,  346,  347,  348,  349,  600,
			  166,  159,  665,  787,  343,  344,  345,  346,  347,  348,
			  349,  601,  531,  532,  533,  534,  535,  536,  537,  166,
			  166, 1076,  166,  166,  343,  344,  345,  346,  347,  348,
			  349, 1076,  166,  166,  666,  788,  159, 1076, 1076, 1076,
			  343,  344,  345,  346,  347,  348,  349, 1076,  705,  343,
			  344,  345,  346,  347,  348,  349, 1076, 1076,  539,  540,
			  541,  542,  543,  544,  545, 1076, 1076, 1076,  166,  343,

			  344,  345,  346,  347,  348,  349, 1076, 1076, 1076, 1076,
			  706, 1076,  343,  344,  345,  346,  347,  348,  349,  677,
			  797,  159,  159,  159,  343,  344,  345,  346,  347,  348,
			  349,  127,  127,  127,  343,  344,  345,  346,  347,  348,
			  349,  127,  127,  127,  343,  344,  345,  346,  347,  348,
			  349,  678,  798,  166,  166,  166, 1076,  127,  127,  127,
			  343,  344,  345,  346,  347,  348,  349,  127,  127,  127,
			  343,  344,  345,  346,  347,  348,  349,  602,  602,  602,
			  343,  344,  345,  346,  347,  348,  349,  603,  603,  603,
			  343,  344,  345,  346,  347,  348,  349,  144,  159,  613,

			  613,  614,  614,  630, 1076,  679,  166,  768,  166,  768,
			  152, 1076,  769,  769,  769,  769,  159, 1076,  166,  631,
			  667,  876,  876,  876,  876, 1076, 1076,  159, 1076,  166,
			  166,  166,  159,  668, 1076,  630,  632,  680,  166,  151,
			  166,  166,  152,  391,  391,  391,  391, 1076,  166,  633,
			  166,  633,  669,  391,  391,  391,  391,  391,  391,  166,
			  166,  166,  166,  166,  166,  670,  634,  166,  634,  166,
			  159, 1076,  166,  166,  640, 1076, 1076,  687, 1076,  166,
			 1076,  633,  638,  619, 1076,  391,  391,  391,  391,  391,
			  391,  166,  166,  166,  166,  166,  683,  166,  634,  166,

			  159,  166,  166,  166,  166,  642,  640,  166,  644,  688,
			  166,  166,  166, 1076,  638, 1076,  646, 1076,  159,  166,
			 1076,  166,  166,  166,  166,  166,  166,  166,  684,  166,
			 1076,  166,  166,  648, 1076,  166,  166,  642,  650,  166,
			  644, 1076,  166, 1076,  166,  166, 1076,  166,  646,  652,
			  166,  166,  654,  166,  166, 1076,  166,  166,  166,  166,
			  166,  166,  166,  166,  166,  648,  166, 1076,  166, 1076,
			  650,  166,  166,  166, 1076,  166,  166,  166,  672,  166,
			  166,  652,  656, 1076,  654,  166,  659,  657,  159,  166,
			  166,  166,  166,  166,  166,  159,  166,  166,  166,  166,

			  660,  658, 1076,  166,  166,  166,  662,  166,  166,  166,
			  672, 1076,  166,  166,  656,  166,  681,  166,  659,  659,
			  166,  733,  166,  159,  159,  166,  159,  166,  166,  166,
			  166,  166,  660,  660,  166,  664,  166,  159,  662,  689,
			  166,  166,  666,  159,  685,  166,  166,  166,  682,  166,
			  669,  166,  159,  734,  159,  166,  166,  166,  166,  735,
			  166,  166,  166,  670, 1076,  159,  166,  664,  166,  166,
			  674,  690,  166, 1076,  666,  166,  686,  166,  166,  166,
			  933,  166,  669,  166,  166,  676,  166,  678,  166,  166,
			  166,  736,  783,  166,  166,  670,  166,  166,  159, 1076,

			  166,  166,  674,  166,  693,  680,  166, 1076,  159,  166,
			 1076,  166,  934,  166,  699,  703,  682,  676,  159,  678,
			  166,  166,  166,  159,  784,  960,  166,  166,  166,  166,
			  166,  686,  166,  166,  684,  166,  694,  680,  166,  166,
			  166,  166,  166,  166,  166,  166,  700,  704,  682, 1076,
			  166,  380, 1076,  166,  166,  166,  166,  960,  166,  166,
			  688,  166, 1076,  686, 1076,  159,  684,  159,  166, 1076,
			  690,  166, 1076,  166,  166,  166,  166,  166, 1076,  166,
			 1076,  166,  159,  166,  692,  166,  166,  701,  166,  166,
			  166,  159,  688,  166,  166, 1076,  166,  166,  694,  166,

			  166,  697,  690, 1076,  698,  166,  166,  166, 1076,  166,
			  166,  166,  166,  166,  166,  166,  692,  166,  159,  702,
			 1076,  166,  166,  166,  159,  166,  166,  711,  166,  695,
			  694, 1076,  696,  697,  707,  159,  698,  166,  166,  166,
			  159,  713,  166,  159,  166,  159,  700, 1076,  807,  166,
			  166,  702,  708,  166,  166,  166,  166, 1076,  166,  712,
			  166,  697,  159,  704,  698,  166,  709,  166, 1076, 1076,
			  166, 1076,  166,  714,  166,  166,  166,  166,  700,  166,
			  808,  166, 1076,  702,  710,  166,  166,  166,  706,  709,
			  166,  166,  166,  715,  166,  704,  159,  166,  166,  831, yy_Dummy>>,
			1, 1000, 3000)
		end

	yy_nxt_template_5 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  166,  159,  166,  166, 1076,  166,  166,  710,  166,  712,
			  166,  166,  717,  166,  159,  166,  159,  714,  166,  887,
			  706,  709, 1076,  166,  166,  716,  166,  716,  166, 1076,
			  166,  832,  166,  166, 1076,  166,  166,  166,  166,  710,
			  166,  712,  166, 1076,  718,  718,  166,  166,  166,  714,
			  166,  888,  166,  159,  166,  166,  166,  722,  166,  716,
			  720,  727,  723,  166,  166,  166,  159,  166,  166,  724,
			  166,  159,  166, 1076, 1076,  166,  166,  718,  166,  725,
			 1076,  775,  166,  159,  166,  166,  166,  166,  166,  722,
			  159, 1076,  720,  728,  724,  166,  166,  166,  166,  166,

			  779,  724,  530,  166,  166,  726,  166,  166,  166,  728,
			  166,  726,  166,  776,  166,  166,  166, 1076,  730,  734,
			  166,  166,  166,  166,  166,  732, 1076,  166,  166,  166,
			  166,  515,  780,  166, 1076,  159,  166,  726,  166,  166,
			  166,  728,  515,  159,  166,  789,  166, 1076,  166,  515,
			  730,  734,  166,  166,  736,  166,  166,  732,  515,  166,
			  166,  166,  166, 1076,  166,  166,  166,  166,  166,  515,
			  159,  166,  166, 1076, 1076,  166,  791,  790,  166,  515,
			  159,  777, 1076, 1076,  166,  530,  736, 1076,  741,  531,
			  532,  533,  534,  535,  536,  537,  166,  530,  166, 1076,

			  166, 1076,  166,  769,  769,  769,  769,  530,  792, 1076,
			  166, 1076,  166,  778,  256,  257,  258,  259,  260,  261,
			  262,  530, 1076, 1076, 1076,  256,  257,  258,  259,  260,
			  261,  262,  256,  257,  258,  259,  260,  261,  262,  530,
			 1076,  256,  257,  258,  259,  260,  261,  262,  538,  737,
			  737,  737,  256,  257,  258,  259,  260,  261,  262,  738,
			  738,  738,  256,  257,  258,  259,  260,  261,  262,  742,
			  742,  742,  531,  532,  533,  534,  535,  536,  537,  538,
			 1076,  743,  743, 1076,  531,  532,  533,  534,  535,  536,
			  537,  744,  744,  744,  531,  532,  533,  534,  535,  536,

			  537,  538, 1076, 1076, 1076,  745,  745,  745,  531,  532,
			  533,  534,  535,  536,  537,  538,  277,  278,  279,  280,
			  281,  282,  283,  746, 1076,  538,  531,  532,  533,  534,
			  535,  536,  537, 1076,  747,  539,  540,  541,  542,  543,
			  544,  545,  538,  166,  286,  166, 1076,  286, 1023,  293,
			  776,  286,  276, 1076,  286,  166,  293, 1076, 1076,  276,
			 1076, 1076, 1076,  748,  748,  748,  539,  540,  541,  542,
			  543,  544,  545,  286,  610,  166,  286,  166,  293, 1076,
			 1023,  276,  776, 1076, 1076,  749,  749,  166,  539,  540,
			  541,  542,  543,  544,  545,  880,  880,  880,  880,  750,

			  750,  750,  539,  540,  541,  542,  543,  544,  545,  751,
			  751,  751,  539,  540,  541,  542,  543,  544,  545,  286,
			  159, 1076,  286, 1076,  293, 1076,  752,  276, 1076,  539,
			  540,  541,  542,  543,  544,  545,  294,  295,  296,  297,
			  298,  299,  300,  294,  295,  296,  297,  298,  299,  300,
			  286,  159,  166,  286, 1076,  293, 1076,  773,  276,  614,
			  614,  614,  614,  159, 1076,  294,  295,  296,  297,  298,
			  299,  300,  286, 1076,  793,  286, 1076,  293,  159,  287,
			  276, 1076,  287,  166,  301, 1076,  287,  276,  885,  287,
			  166,  301,  166,  287,  276,  166,  287,  780,  301,  394,

			  287,  276,  166,  287, 1076,  301,  794, 1076,  276, 1076,
			  166,  294,  295,  296,  297,  298,  299,  300,  287, 1076,
			  886,  287,  166,  301,  166,  159,  276, 1076,  287,  780,
			 1076,  287, 1076,  301,  166, 1076,  276, 1076, 1076,  753,
			  753,  753,  294,  295,  296,  297,  298,  299,  300,  277,
			  278,  279,  280,  281,  282,  283,  561,  166, 1076,  560,
			 1076,  754,  754,  754,  294,  295,  296,  297,  298,  299,
			  300,  302,  303,  304,  305,  306,  307,  308,  302,  303,
			  304,  305,  306,  307,  308,  302,  303,  304,  305,  306,
			  307,  308,  302,  303,  304,  305,  306,  307,  308,  107,

			 1076,  795,  560, 1076, 1076,  159, 1076,  755,  755,  755,
			  302,  303,  304,  305,  306,  307,  308,  756,  756,  756,
			  302,  303,  304,  305,  306,  307,  308, 1076,  166,  561,
			  166, 1076,  560,  796, 1076,  813,  778,  166,  107,  159,
			  166,  560,  159,  320,  321,  322,  323,  324,  325,  326,
			  119,  757,  757,  757,  757,  119,  107, 1076, 1076,  560,
			  166, 1076,  166,  107, 1076, 1076,  560,  814,  778, 1076,
			  107,  166,  166,  560,  166,  801, 1076,  107, 1076,  817,
			  560,  159,  159,  159, 1076, 1076,  320,  321,  322,  323,
			  324,  325,  326,  107, 1076, 1076,  560,  773, 1076,  613,

			  613,  614,  614,  107,  827, 1076,  560,  802,  159,  159,
			  152,  818, 1076,  166,  166,  166,  320,  321,  322,  323,
			  324,  325,  326, 1076, 1076,  320,  321,  322,  323,  324,
			  325,  326, 1076, 1076,  107, 1076,  828,  108, 1076,  394,
			  166,  166,  152,  320,  321,  322,  323,  324,  325,  326,
			  320,  321,  322,  323,  324,  325,  326,  320,  321,  322,
			  323,  324,  325,  326,  320,  321,  322,  323,  324,  325,
			  326,  107, 1076,  159,  108, 1076, 1076,  758,  758,  758,
			  320,  321,  322,  323,  324,  325,  326,  759,  759,  759,
			  320,  321,  322,  323,  324,  325,  326,  107, 1076, 1076,

			  108,  159, 1076, 1076,  107,  166, 1076,  108,  774,  774,
			  774,  774,  159,  815, 1076, 1076,  622,  622,  622,  622,
			  109,  120,  121,  122,  123,  124,  125,  126, 1076,  763,
			  763,  763,  763,  166,  159, 1076,  767,  767,  767,  767,
			  159,  857, 1076,  379,  166,  816,  109,  159,  394,  799,
			  609,  843,  110, 1076, 1076, 1076,  394, 1076,  111,  112,
			  113,  114,  115,  116,  117, 1076,  166, 1076, 1076,  380,
			 1076, 1076,  166,  858,  159,  379,  610,  833,  110,  166,
			 1076,  800,  609,  844,  111,  112,  113,  114,  115,  116,
			  117,  120,  121,  122,  123,  124,  125,  126,  343,  344,

			  345,  346,  347,  348,  349, 1076,  166, 1076, 1076,  834,
			 1076,  343,  344,  345,  346,  347,  348,  349,  343,  344,
			  345,  346,  347,  348,  349,  343,  344,  345,  346,  347,
			  348,  349, 1076,  760,  760,  760,  343,  344,  345,  346,
			  347,  348,  349, 1076, 1076,  761,  761,  761,  343,  344,
			  345,  346,  347,  348,  349, 1076,  874,  874,  874,  874,
			 1076, 1076, 1076,  762,  585,  585,  585,  585,  159,  159,
			  159,  839,  159,  859,  159,  849,  159,  805,  809,  811,
			  882,  882,  882,  882, 1076,  127,  127,  127,  343,  344,
			  345,  346,  347,  348,  349,  159,  765,  159,  863, 1076, yy_Dummy>>,
			1, 1000, 4000)
		end

	yy_nxt_template_6 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  166,  166,  166,  840,  166,  860,  166,  850,  166,  806,
			  810,  812,  127,  127,  127,  343,  344,  345,  346,  347,
			  348,  349,  159,  159,  159,  784,  159,  166,  782,  166,
			  864,  825,  829,  166,  166,  166,  166,  911,  343,  344,
			  345,  346,  347,  348,  349,  166,  166,  786,  788,  166,
			  166,  166,  166, 1076,  166,  166,  166,  784,  166,  159,
			  782,  166,  166,  826,  830,  166,  166,  166,  166,  912,
			 1076,  835, 1076, 1076,  159, 1076, 1076,  166,  166,  786,
			  788,  166,  166,  166,  166,  166,  847,  166,  159,  792,
			 1076,  166,  790,  166,  166,  796,  166,  166,  166,  166,

			  861,  166,  166,  836,  166,  798,  166,  794,  166, 1076,
			  166,  166,  166, 1076,  166, 1076, 1076,  166,  848,  166,
			  166,  792,  166, 1076,  790, 1076, 1076,  796,  166,  166,
			  166,  166,  862,  166,  166,  905,  166,  798,  159,  794,
			  166,  802,  166,  166,  166,  166,  166,  166,  159,  853,
			  166,  800,  166,  804,  166,  159,  166,  166,  166,  166,
			  973,  166,  166, 1076,  166,  806,  808,  906,  166, 1076,
			  166,  166, 1076,  802, 1076, 1076,  166,  166, 1076,  166,
			  166,  854,  166,  800,  166,  804,  159,  166,  166,  166,
			  166,  166,  974,  166,  166,  841,  166,  806,  808,  166,

			  166,  166, 1076,  166,  166,  810,  166,  166,  166,  166,
			  812,  166,  166,  814,  166, 1076,  166, 1076,  166,  166,
			  166,  816,  166, 1076,  166,  159, 1076,  842, 1076, 1076,
			  159,  166,  166,  166,  855, 1076,  166,  810,  166,  166,
			  818,  166,  812,  166,  166,  814,  166,  166,  166,  166,
			 1076,  166,  166,  816,  166,  820,  166,  166,  166,  166,
			  166,  166,  166,  166,  166,  166,  856,  166, 1076, 1076,
			  166, 1076,  818,  822,  166,  828,  166,  824, 1076,  166,
			  826,  166,  166, 1076,  166, 1076,  166,  820,  865, 1076,
			  166,  166,  166,  166,  166,  166,  159,  166,  166,  166,

			  166,  166,  166,  166,  830,  822,  166,  828,  166,  824,
			  166,  159,  826,  166,  166,  832,  166,  166,  166,  166,
			  866,  166,  166, 1076,  166, 1076,  166,  166,  166, 1076,
			  166,  166,  166,  166,  166,  166,  830,  159,  834, 1076,
			  166, 1076,  166,  166, 1076,  166,  166,  832,  166,  166,
			  166,  166,  159,  166,  166,  166,  166,  166,  166,  166,
			 1076,  893, 1076,  166,  836, 1076,  166,  166,  838,  166,
			  834,  166,  166,  166,  763,  763,  763,  763,  166,  166,
			  166,  166,  166,  166,  166,  842,  840,  166,  873,  166,
			  166,  166,  166,  894,  166, 1076,  836,  889,  159,  166,

			  838, 1076, 1076,  166,  166,  166, 1076,  166,  844,  166,
			 1076,  166, 1076,  166,  891,  166, 1076,  842,  840,  166,
			  873,  159,  846,  166,  166,  166,  166,  166, 1076,  890,
			  166, 1036,  850,  166,  166,  166,  166,  166,  159,  166,
			  844,  166,  848, 1076,  166,  166,  892,  854,  166,  925,
			  166,  166, 1076,  166,  846,  159,  166,  166,  166,  166,
			  166,  852,  159, 1037,  850,  166,  166,  166,  166,  166,
			  166,  895, 1076, 1076,  848,  896,  166,  166, 1076,  854,
			  166,  926,  166,  166,  166,  166,  166,  166,  166,  856,
			  166, 1076,  166,  852,  166,  166,  166,  166, 1076,  166,

			  166,  858,  166,  897,  166,  860, 1076,  898,  166,  166,
			  166,  166, 1076,  166,  166,  166,  166,  166,  166, 1076,
			  166,  856,  159,  166, 1076,  903,  159,  166,  166,  166,
			  515,  166, 1076,  858,  166, 1076,  166,  860,  515, 1076,
			  166,  166,  166,  166,  530,  166,  166,  166,  864,  166,
			  166,  866,  166,  530,  166,  166,  862,  904,  166,  166,
			  166,  166,  166,  166,  166,  166,  530,  166,  878,  878,
			  878,  878,  159,  166,  166,  530, 1076,  166,  977,  166,
			  864,  166,  166,  866, 1076,  530, 1076, 1076,  862, 1076,
			 1076,  166,  166,  166,  166,  166,  166,  166,  530,  166,

			  959,  959,  959,  959,  166,  166,  166,  538,  879,  166,
			  978, 1076, 1076,  256,  257,  258,  259,  260,  261,  262,
			  538,  256,  257,  258,  259,  260,  261,  262,  538,  159,
			 1076,  531,  532,  533,  534,  535,  536,  537,  538, 1076,
			  531,  532,  533,  534,  535,  536,  537,  159,  538,  963,
			  963,  963,  963,  531,  532,  533,  534,  535,  536,  537,
			  538,  166,  531,  532,  533,  534,  535,  536,  537,  867,
			  867,  867,  531,  532,  533,  534,  535,  536,  537,  166,
			 1076, 1076,  868,  868,  868,  531,  532,  533,  534,  535,
			  536,  537,  159, 1076,  539,  540,  541,  542,  543,  544,

			  545, 1076, 1076,  881,  881,  881,  881,  539,  540,  541,
			  542,  543,  544,  545, 1076,  539,  540,  541,  542,  543,
			  544,  545, 1076, 1076,  166,  539,  540,  541,  542,  543,
			  544,  545,  869,  869,  869,  539,  540,  541,  542,  543,
			  544,  545, 1076,  772,  870,  870,  870,  539,  540,  541,
			  542,  543,  544,  545,  286, 1076,  907,  286, 1076,  293,
			  159,  286,  276,  159,  286, 1076,  293, 1076,  287,  276,
			 1076,  287, 1076,  301,  945,  287,  276,  166,  287,  166,
			  301,  159,  159,  276,  886,  159,  899,  107,  908,  166,
			  560,  901,  166, 1076,  107,  166, 1076,  560, 1076,  119,

			  871,  871,  871,  871,  107,  159,  946,  560, 1076,  166,
			 1076,  166, 1076,  166,  166,  872,  886,  166,  900, 1076,
			 1076,  166, 1076,  902, 1076,  343,  344,  345,  346,  347,
			  348,  349,  964,  964,  964,  964, 1076,  166,  343,  344,
			  345,  346,  347,  348,  349, 1076,  294,  295,  296,  297,
			  298,  299,  300,  294,  295,  296,  297,  298,  299,  300,
			  302,  303,  304,  305,  306,  307,  308,  302,  303,  304,
			  305,  306,  307,  308,  320,  321,  322,  323,  324,  325,
			  326,  320,  321,  322,  323,  324,  325,  326,  159, 1076,
			 1076,  320,  321,  322,  323,  324,  325,  326,  343,  344,

			  345,  346,  347,  348,  349,  877,  877,  877,  877,  877,
			  877,  877,  877, 1076, 1076, 1076,  166, 1076,  166,  609,
			  166, 1076,  884,  883,  622,  622,  622,  622,  166,  166,
			  892,  166, 1076,  890,  166,  159,  888,  166,  159,  166,
			  166,  166,  166, 1076,  915,  610,  166,  931,  166,  166,
			  166,  609,  166, 1076,  909,  883, 1076, 1076, 1076,  159,
			  166,  166,  892,  166,  151,  890,  166,  166,  888,  166,
			  166,  166,  166,  166,  166,  166,  916,  166,  166,  932,
			  166,  166,  166,  166,  166,  166,  910,  166,  166,  894,
			  900,  166,  166, 1076,  897,  166, 1076, 1076,  898, 1076, yy_Dummy>>,
			1, 1000, 5000)
		end

	yy_nxt_template_7 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  166,  166, 1076,  166,  166, 1076,  166,  166, 1076,  166,
			 1076, 1076,  166,  166,  166,  166,  166,  166, 1076,  166,
			  166,  894,  900, 1076,  166,  904,  897,  166, 1076,  166,
			  898,  166,  166,  166,  906,  166,  166,  166,  166,  166,
			  166,  166,  166,  902, 1076,  166,  908, 1076,  166,  166,
			  910, 1076,  166,  166, 1076,  166, 1076,  904,  166,  159,
			  166,  166, 1076,  166,  913,  166,  906, 1076,  949,  166,
			  166,  166,  166,  166,  166,  902,  159,  166,  908,  914,
			 1076,  166,  910, 1076,  166,  166,  166,  166,  166,  166,
			  166,  166,  166,  166,  912,  166,  914,  166,  166,  159,

			  950,  166,  166,  166,  917,  166, 1076,  916,  166,  166,
			  166,  914,  918,  166, 1076,  919, 1076, 1076,  166,  159,
			  166,  166,  166, 1076, 1076,  166,  912,  166,  929, 1076,
			  166,  166,  159,  166,  920,  166,  918,  166,  166,  916,
			  166,  166,  166,  166,  918,  166,  166,  920,  166, 1076,
			  166,  166,  922,  166,  166,  166,  924,  166,  166,  166,
			  930,  166, 1076, 1076,  166,  926,  920,  166, 1076, 1076,
			  166,  166,  166,  166,  166,  166,  166, 1076,  166, 1076,
			  166, 1076,  166, 1076,  922,  166,  166,  166,  924,  166,
			  166,  166,  166,  166,  166,  928, 1076,  926,  166,  166,

			  166,  937,  930,  166,  934,  159,  166, 1076,  166,  166,
			  166,  166, 1076,  166, 1076,  166, 1076,  159,  166,  932,
			 1076,  166, 1076, 1076,  166,  166,  166,  928,  947, 1076,
			  166, 1076,  166,  938,  930,  936,  934,  166,  166,  938,
			  166,  166,  166,  166, 1076,  166,  166,  166,  166,  166,
			  166,  932,  939,  166,  940,  159,  159,  166,  166, 1076,
			  948,  166,  943,  166,  941, 1076,  159,  936, 1076, 1076,
			  166,  938,  166,  166, 1076,  159, 1076,  166,  166,  166,
			  166, 1076,  166,  942,  940,  991,  940,  166,  166,  166,
			  166, 1076, 1076,  166,  944,  166,  942,  944,  166, 1076,

			  166,  166,  166,  166,  166,  166,  166,  166,  946,  166,
			 1076,  166,  166,  166,  950,  942,  166,  992,  166, 1076,
			  166,  166, 1076, 1076, 1076,  166,  948,  166, 1076,  944,
			  166,  530,  166,  166,  166,  166,  166,  166,  166,  166,
			  946,  166,  530, 1076,  166,  166,  950,  954,  166,  953,
			  166,  166,  166,  159,  166,  538,  166,  166,  948,  166,
			  952, 1076,  166,  166,  538,  166,  166,  159,  166,  166,
			  166,  166,  955,  166, 1076,  166, 1076, 1076, 1076,  954,
			  166,  954,  166,  166,  956,  166,  166, 1076,  166, 1076,
			 1076, 1076,  952,  107,  166,  166,  560,  166,  166,  166,

			  166, 1076,  166, 1076,  956,  119, 1076,  166,  966,  966,
			  966,  966,  166, 1076,  166, 1076,  956,  159,  531,  532,
			  533,  534,  535,  536,  537, 1076,  166, 1003, 1076,  531,
			  532,  533,  534,  535,  536,  537,  958,  958,  958,  958,
			 1076, 1076,  539,  540,  541,  542,  543,  544,  545,  166,
			 1076,  539,  540,  541,  542,  543,  544,  545,  957, 1004,
			  957, 1076, 1076,  958,  958,  958,  958,  962,  962,  962,
			  962,  965,  965,  965,  965, 1076,  765, 1076, 1076, 1076,
			  320,  321,  322,  323,  324,  325,  326,  877,  877,  877,
			  877,  967, 1076,  967, 1076, 1076,  965,  965,  965,  965,

			 1076,  961,  969,  969,  969,  969,  166,  879,  166,  971,
			  166,  772,  166,  159,  159,  159,  970,  972,  166,  166,
			  993,  166,  166,  159,  166,  975,  166,  166,  974,  166,
			 1076,  166, 1076,  961,  979,  976,  166, 1076,  166,  166,
			  166,  972,  166, 1076,  166,  166,  166,  166,  970,  972,
			  166,  166,  994,  166,  166,  166,  166,  976,  166,  166,
			  974,  166,  166,  166,  166,  981,  980,  976,  166,  159,
			  166,  166,  166,  978,  166,  166,  983,  166, 1076,  982,
			  984,  985,  166,  980,  159,  159,  166,  166,  166, 1076,
			 1076,  166, 1076,  166,  166, 1076,  166,  982,  166, 1076,

			 1076,  166,  166,  166,  166,  978,  166,  166,  984,  166,
			 1076,  982,  984,  986,  166,  980,  166,  166,  166,  166,
			  166,  987,  166,  166,  166,  166,  166, 1076,  166,  159,
			  166,  166,  986,  166,  166,  166,  988,  999,  166,  166,
			  989,  166, 1076,  166,  159,  159, 1076,  166,  990,  166,
			  166,  166,  166,  988,  166,  166,  166,  166,  166,  166,
			  166,  166,  166,  166,  986,  166,  166,  166,  988, 1000,
			  166,  166,  990,  166,  159,  166,  166,  166, 1076,  166,
			  990,  166,  166,  166,  166,  995,  166,  166,  166,  166,
			  166,  166,  994,  992,  166,  166,  159,  166,  166,  166,

			  159, 1005,  166,  996, 1076,  159,  166,  166, 1000, 1009,
			 1007,  997, 1076,  159, 1076,  159, 1076,  996,  166,  166,
			  166,  166,  166, 1076,  994,  992, 1001,  166,  166,  166,
			  166,  166,  166, 1006,  166,  996,  166,  166,  166,  166,
			 1000, 1010, 1008,  998,  998,  166,  159,  166,  166, 1040,
			 1076,  166,  166,  166,  166,  166, 1076,  166, 1002,  166,
			 1002,  166, 1004,  166,  166, 1076, 1076,  166,  166, 1076,
			  166,  166, 1076,  166, 1076, 1006,  998, 1076,  166, 1076,
			  166, 1041, 1076, 1076,  166,  166,  166,  166,  166,  166,
			 1008,  166, 1002,  166, 1004, 1076,  166, 1076, 1076,  166,

			  166,  159,  166,  166,  166,  166, 1010, 1006, 1076,  166,
			 1076,  166, 1011,  166,  166,  166,  166,  166,  166, 1076,
			  166,  166, 1008, 1076, 1076,  166,  159,  166,  166,  166,
			 1076, 1013,  166,  166,  166, 1076,  166, 1076, 1010,  166,
			  166,  166, 1014,  166, 1012,  166,  166,  166,  166, 1042,
			  166,  159,  166,  166,  166, 1076,  166,  166,  166,  166,
			  166,  166, 1012, 1014,  159,  166,  166,  166,  166,  159,
			  166,  166,  166, 1076, 1014, 1015, 1016,  166, 1069, 1076,
			  166, 1043, 1076,  166,  166, 1076,  166, 1076,  166,  958,
			  958,  958,  958, 1076, 1012, 1076,  166,  166,  166,  166,

			  166,  166,  166,  958,  958,  958,  958, 1016, 1016,  166,
			 1070, 1076,  166, 1017, 1017, 1017, 1017, 1018, 1076, 1018,
			 1076, 1076, 1019, 1019, 1019, 1019, 1020, 1076, 1020, 1076,
			 1076, 1021, 1021, 1021, 1021, 1021, 1021, 1021, 1021, 1022,
			 1022, 1022, 1022,  965,  965,  965,  965, 1024, 1024, 1024,
			 1024,  965,  965,  965,  965, 1025, 1025, 1025, 1025, 1026,
			  159, 1026, 1029, 1076, 1027, 1027, 1027, 1027, 1028, 1023,
			  166, 1030,  166,  159, 1076,  879,  166,  166,  166,  166,
			  159,  166,  166, 1033, 1031, 1032, 1034, 1076,  166,  166,
			 1076,  159,  166,  166, 1029,  610, 1019, 1019, 1019, 1019, yy_Dummy>>,
			1, 1000, 6000)
		end

	yy_nxt_template_8 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 1029, 1023,  166, 1031,  166,  166, 1076, 1076,  166,  166,
			  166,  166,  166,  166,  166, 1033, 1031, 1033, 1035, 1035,
			  166,  166,  166,  166,  166,  166, 1037,  166, 1038,  166,
			 1076, 1076, 1039,  159,  166, 1041,  166,  166,  166,  166,
			  166,  166,  166,  166, 1076, 1076, 1076,  166,  166, 1076,
			 1076, 1035,  166,  166,  166, 1076,  166, 1076, 1037,  166,
			 1039,  166, 1076, 1076, 1039,  166,  166, 1041,  166,  166,
			  166,  166,  166,  166,  166,  166,  166, 1076,  166,  166,
			  166,  166, 1043,  166,  166,  166,  159,  166,  166,  166,
			  166, 1044,  166,  166,  166, 1076, 1045, 1046, 1047,  166,

			 1050,  159,  166,  159,  159,  166,  166,  166,  166, 1048,
			  166, 1076, 1076,  166, 1043,  166, 1076,  166,  166,  166,
			  166,  166,  166, 1045,  166,  166,  166, 1076, 1045, 1047,
			 1047,  166, 1051,  166,  166,  166,  166,  166,  166,  166,
			  166, 1049,  166, 1049, 1051, 1076, 1053,  159, 1052,  166,
			 1065,  166,  166,  166,  159,  166,  166,  166,  166, 1076,
			 1054, 1056, 1055,  166,  159,  159, 1076,  166,  166,  166,
			 1076,  166,  166, 1076,  166, 1049, 1051, 1076, 1053,  166,
			 1053,  166, 1066,  166,  166,  166,  166,  166,  166,  166,
			  166, 1076, 1055, 1057, 1055,  166,  166,  166, 1057,  166,

			  166,  166,  166,  166,  166,  166, 1076,  166, 1058, 1058,
			 1058, 1058, 1076,  166,  166, 1076, 1076,  166, 1021, 1021,
			 1021, 1021, 1021, 1021, 1021, 1021, 1059, 1059, 1059, 1059,
			 1057, 1076, 1076, 1076,  166, 1076,  166,  166, 1076,  166,
			  964,  964,  964,  964, 1076, 1060,  166, 1060,  765,  166,
			 1061, 1061, 1061, 1061, 1023, 1027, 1027, 1027, 1027, 1062,
			 1062, 1062, 1062,  166, 1063,  166, 1076, 1076,  159, 1064,
			  166,  166,  166,  166, 1076,  166,  166, 1066,  166,  166,
			  610, 1076,  166,  166, 1076, 1076, 1023, 1076,  166,  166,
			 1061, 1061, 1061, 1061, 1076,  166, 1064,  166, 1076,  772,

			  166, 1064,  166,  166,  166,  166, 1076,  166,  166, 1066,
			  166,  166,  159, 1076,  166,  166,  166,  166,  166,  166,
			  166,  166,  166, 1067,  166,  166, 1076,  166,  166,  166,
			  166, 1071,  166, 1068,  166,  159, 1076,  166, 1076, 1076,
			 1076,  166,  166,  166,  166, 1076, 1076, 1070,  166,  166,
			  166,  166, 1076,  166,  166, 1068,  166,  166, 1076,  166,
			  166,  166,  166, 1072,  166, 1068,  166,  166,  166,  166,
			  166, 1076, 1076,  166,  166,  166,  166, 1072,  166, 1070,
			  166,  166, 1076,  166,  166,  166,  166, 1076,  166, 1017,
			 1017, 1017, 1017,  166, 1076, 1074,  166, 1076, 1076,  159,

			  166, 1076,  166, 1073, 1073, 1073, 1073, 1076,  166, 1072,
			  166, 1076,  166,  166, 1076,  166,  166, 1076,  166, 1076,
			  166, 1024, 1024, 1024, 1024,  166, 1075, 1075,  166,  765,
			  166,  166,  166,  166,  166,  166,  166,  166,  166,  166,
			  166, 1076,  166,  879, 1076,  166,  166, 1076, 1076,  166,
			  166, 1059, 1059, 1059, 1059, 1076, 1076, 1076, 1075, 1076,
			 1076,  772,  166, 1076,  166,  166,  166,  166,  166,  166,
			  166,  166,  166,  166,  166,  166, 1076,  166,  166, 1076,
			 1076,  166,  166, 1076, 1076,  166, 1076, 1076, 1076, 1076,
			 1076,  879,  388,  388,  388,  388,  388,  388,  388,  388,

			  388,  388,  388,  388,  388,  166, 1076,  166, 1076, 1076,
			 1076, 1076, 1076, 1076, 1076, 1076, 1076,  166,   87,   87,
			   87,   87,   87,   87,   87,   87,   87,   87,   87,   87,
			   87,   87,   87,   87,   87,   87,   87,   87,   87,   87,
			   87,  106,  106, 1076,  106,  106,  106,  106,  106,  106,
			  106,  106,  106,  106,  106,  106,  106,  106,  106,  106,
			  106,  106,  106,  106,  118, 1076, 1076, 1076, 1076, 1076,
			 1076,  118,  118,  118,  118,  118,  118,  118,  118,  118,
			  118,  118,  118,  118,  118,  118,  118,  119,  119, 1076,
			  119,  119,  119,  119,  119,  119,  119,  119,  119,  119,

			  119,  119,  119,  119,  119,  119,  119,  119,  119,  119,
			  127,  127, 1076,  127,  127,  127,  127, 1076,  127,  127,
			  127,  127,  127,  127,  127,  127,  127,  127,  127,  127,
			  127,  127,  127,  147,  147,  147,  147,  147,  147,  147,
			  147,  147,  147,  147,  147,  147,  147,  255,  255, 1076,
			  255,  255,  255, 1076, 1076,  255,  255,  255,  255,  255,
			  255,  255,  255,  255,  255,  255,  255,  255,  255,  255,
			  166,  166,  166,  166,  166,  166,  166,  166,  166,  166,
			  166,  166,  166,  166,  276, 1076, 1076,  276, 1076,  276,
			  276,  276,  276,  276,  276,  276,  276,  276,  276,  276,

			  276,  276,  276,  276,  276,  276,  276,  290,  290, 1076,
			  290,  290,  290,  290,  290,  290,  290,  290,  290,  290,
			  290,  290,  290,  290,  290,  290,  290,  290,  290,  290,
			  291,  291, 1076,  291,  291,  291,  291,  291,  291,  291,
			  291,  291,  291,  291,  291,  291,  291,  291,  291,  291,
			  291,  291,  291,  315,  315, 1076,  315,  315,  315,  315,
			  315,  315,  315,  315,  315,  315,  315,  315,  315,  315,
			  315,  315,  315,  315,  315,  315,  341, 1076, 1076, 1076,
			 1076,  341,  341,  341,  341,  341,  341,  341,  341,  341,
			  341,  341,  341,  341,  341,  341,  341,  341,  341,  381,

			  381,  381,  381,  381,  381,  381,  381, 1076,  381,  381,
			  381,  381,  381,  381,  381,  381,  381,  381,  381,  381,
			  381,  381,  390,  390,  390,  390,  390,  390,  390,  390,
			  390,  390,  390,  390,  390,  392,  392,  392,  392,  392,
			  392,  392,  392,  392,  392,  392,  392,  392,  286,  286,
			 1076,  286,  286,  286, 1076,  286,  286,  286,  286,  286,
			  286,  286,  286,  286,  286,  286,  286,  286,  286,  286,
			  286,  287,  287, 1076,  287,  287,  287, 1076,  287,  287,
			  287,  287,  287,  287,  287,  287,  287,  287,  287,  287,
			  287,  287,  287,  287,  968,  968,  968,  968,  968,  968,

			  968,  968, 1076,  968,  968,  968,  968,  968,  968,  968,
			  968,  968,  968,  968,  968,  968,  968,    5, 1076, 1076,
			 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076,
			 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076,
			 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076,
			 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076,
			 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076,
			 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076,
			 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076,
			 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, yy_Dummy>>,
			1, 1000, 7000)
		end

	yy_nxt_template_9 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076,
			 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, yy_Dummy>>,
			1, 18, 8000)
		end

	yy_chk_template: SPECIAL [INTEGER]
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make (0, 8017)
			yy_chk_template_1 (an_array)
			yy_chk_template_2 (an_array)
			yy_chk_template_3 (an_array)
			yy_chk_template_4 (an_array)
			yy_chk_template_5 (an_array)
			yy_chk_template_6 (an_array)
			yy_chk_template_7 (an_array)
			yy_chk_template_8 (an_array)
			yy_chk_template_9 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_chk_template_1 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			    0,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,

			    1,    3,    3,    3,    3,   23,   22,   23,   23,   23,
			   23,   24,   40,    4,    4,    4,    4,   22, 1059,   24,
			   26,  147,   26,   26,   26,   26,   30,   30,   32,   32,
			 1024,   12,   46,   26,   12,   37,   46, 1017,   15,   37,
			   16,   15,   16,   16,   40,   37,  620,   27,   16,   27,
			   27,   27,   27,   42,  159,   38,  618,    3,   38,   42,
			   38,  152,   26,  147,   46,   26,  616,   37,   46,    4,
			   38,   37,   45,   80,   80,   80,  392,   37,   83,   83,
			   12,   45,   24,   51,   51,   42,  159,   38,    3,   27,
			   38,   42,   38,    3,    3,    3,    3,    3,    3,    3,

			    4,  390,   38,  152,   45,    4,    4,    4,    4,    4,
			    4,    4,   12,   45,  388,   51,   51,  352,   12,   12,
			   12,   12,   12,   12,   12,   15,   15,   15,   15,   15,
			   15,   15,   16,   16,   16,   16,   16,   16,   16,   25,
			   43,   25,   25,   25,   25,  288,   43,   39,  176,  176,
			   35,   39,   25,   25,   35,   39,   35,   52,   47,   35,
			   49,   35,   47,   52,   39,   49,   35,   35,   47,  193,
			   48,   48,   43,   47,   25,   82,   82,   82,   43,   39,
			   48,   25,   35,   39,   25,   25,   35,   39,   35,   52,
			   47,   35,   49,   35,   47,   52,   39,   49,   35,   35,

			   47,  193,   48,   48,  386,   47,   25,   34,   34,   34,
			   34,  269,   48,   84,   84,   84,  208,   34,   34,   34,
			   34,   34,   34,   34,   34,   34,   34,   34,   34,   34,
			   34,   34,   34,   34,   34,   34,   34,   34,   34,   34,
			   34,   34,   34,   85,   85,   85,  386,   34,  208,   34,
			   34,   34,   34,   34,   34,   34,   34,   34,   34,   34,
			   34,   34,   34,   34,   34,   34,   34,   34,   34,   34,
			   34,   34,   34,   34,   34,  146,  211,  146,  146,  146,
			  146,   34,   34,   34,   34,   34,   34,   34,   36,   36,
			   44,   88,   36,   88,   88,   36,   41,   44,   36,   41,

			   44,   36,   44,   41,   41,   50,   44,  264,  211,   41,
			  161,  163,  225,   50,  161,  179,  163,  146,  174,   50,
			   36,   36,   44,  128,   36,  266,  266,   36,   41,   44,
			   36,   41,   44,   36,   44,   41,   41,   50,   44,  148,
			  148,   41,  161,  163,  225,   50,  161,   88,  163,  241,
			   61,   50,   57,   57,   57,   57,   57,   57,   57,   58,
			   61,  241,   64,   58,   64,   69,  162,   69,   58,  162,
			   58,   69,   59,  247,   64,   58,   58,   69,   88,  148,
			  104,  241,   61,   87,   87,   87,   87,   87,   87,   87,
			  103,   58,   61,  241,   64,   58,   64,   69,  162,   69,

			   58,  162,   58,   69,   59,  247,   64,   58,   58,   69,
			   61,   61,   61,   61,   61,   61,   61,  149,  149,  149,
			  102,   58,   58,   58,   58,   58,   58,   58,   59,   59,
			   59,   59,   59,   59,   59,   60,  400,  160,   66,   60,
			  164,   66,   60,   66,   66,   60,  160,   62,   60,   62,
			  164,  403,  204,   66,  173,  173,  173,  149,  204,   62,
			   94,   94,   94,   94,   94,   94,   94,   60,  400,  160,
			   66,   60,  164,   66,   60,   66,   66,   60,  160,   62,
			   60,   62,  164,  403,  204,   66,  175,  175,  175,  101,
			  204,   62,   60,   60,   60,   60,   60,   60,   60,   89,

			   62,   62,   62,   62,   62,   62,   62,   63,   65,   86,
			   67,   63,   67,   67,   65,   65,   65,  165,   63,   68,
			   63,   65,   67,  182,   63,   81,   65,  182,  165,   68,
			   63,   68,  177,  177,  177,   68,  178,  178,  178,   63,
			   65,   68,   67,   63,   67,   67,   65,   65,   65,  165,
			   63,   68,   63,   65,   67,  182,   63,   70,   65,  182,
			  165,   68,   63,   68,   70,   71,   70,   68,  144,  144,
			  144,  144,   71,   68,   71,   71,   70,   72,  387,  387,
			   71,   72,  144,   72,   71,  405,   54,   72,   73,   70,
			   73,   33,   90,   72,   90,   90,   70,   71,   70,   28,

			   73,   11,   10,  183,   71,    9,   71,   71,   70,   72,
			   74,  183,   71,   72,  144,   72,   71,  405,  387,   72,
			   73,   74,   73,   74,   74,   72,   76,  185,   76,   76,
			   75,  185,   73,   74,   75,  183,   75,   91,   76,   91,
			   91,  196,   74,  183,   92,  184,   75,   92,   90,   92,
			  184,  196,   92,   74,    8,   74,   74,    7,   76,  185,
			   76,   76,   75,  185,   93,   74,   75,   93,   75,   93,
			   76,    5,   93,  196,  263,  263,  263,  184,   75,   90,
			    0,    0,  184,  196,   90,   90,   90,   90,   90,   90,
			   90,  415,    0,   91,   95,   95,   95,   95,   95,   95,

			   95,   95,   96,   96,   96,   96,   96,   96,   96,   96,
			   96,   96,   97,   97,  127,   97,   97,   97,   97,   97,
			   97,   97,  131,  415,   91,   98,   98,   98,   98,   98,
			   98,   98,   98,   98,   98,    0,   92,   92,   92,   92,
			   92,   92,   92,   99,   99,   99,   99,   99,   99,   99,
			   99,   99,   99,  265,  265,  265,   93,   93,   93,   93,
			   93,   93,   93,  100,  435,    0,  100,  100,  100,  100,
			  100,  100,  100,  106,  615,  615,  106,  140,  140,  140,
			  140,  166,  145,  166,  145,  145,  145,  145,  267,  267,
			  267,  140,    0,  166,    0,  145,  435,  127,  127,  127,

			  127,  127,  127,  127,  131,  131,  131,  131,  131,  131,
			  131,  131,    0,  166,  615,  166,  151,  140,  151,  151,
			  151,  151,  106,  140,  145,  166,  109,  145,  109,  109,
			    0,  109,    0,    0,  109,    0,  168,  452,    0,  110,
			    0,  110,  110,  168,  110,  168,  180,  110,    0,    0,
			  202,  471,    0,  202,  106,  168,    0,  180,  151,    0,
			  106,  106,  106,  106,  106,  106,  106,  108,  168,  452,
			  108,  108,  108,  108,    0,  168,    0,  168,  180,  108,
			  109,  111,  202,  471,  111,  202,  108,  168,  108,  180,
			  108,  108,  108,  110,    0,  108,  112,  108,    0,  112, yy_Dummy>>,
			1, 1000, 0)
		end

	yy_chk_template_2 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			    0,  108,    0,  108,    0,    0,  108,  108,  108,  108,
			  108,  108,  109,    0,  113,    0,  495,  113,  109,  109,
			  109,  109,  109,  109,  109,  110,  119,    0,    0,  119,
			  111,  110,  110,  110,  110,  110,  110,  110,  268,  268,
			  268,  114,    0,    0,  114,  112,    0,  216,  495,  216,
			  270,  270,  270,    0,  108,  108,  108,  108,  108,  108,
			  108,  115,  111,  113,  115,  271,  271,  271,  111,  111,
			  111,  111,  111,  111,  111,  116,    0,  112,  116,  216,
			  503,  216,  112,  112,  112,  112,  112,  112,  112,  112,
			  114,  117,    0,    0,  117,  113,    0,    0,  113,  113,

			  113,  113,  113,  113,  113,  113,  113,  113,  120,  507,
			  115,  120,  503,  119,  119,  119,  119,  119,  119,  119,
			  121,    0,  114,  121,  116,  114,  114,    0,  114,  114,
			  114,  114,  114,  114,  114,  122,    0,  209,  122,  513,
			  117,  507,  115,    0,  209,  115,  115,  115,  115,  115,
			  115,  115,  115,  115,  115,  123,  116,    0,  123,  116,
			  116,  116,  116,  116,  116,  116,  116,  116,  116,  209,
			  124,  513,  117,  124,    0,  117,  209,    0,  117,  117,
			  117,  117,  117,  117,  117,  125,  632,    0,  125,  272,
			  272,  272,  273,  273,  273,  120,  120,  120,  120,  120,

			  120,  120,  126,    0,    0,  126,  121,  121,  121,  121,
			  121,  121,  121,  121,  274,  274,  274,    0,  632,  122,
			  122,  122,  122,  122,  122,  122,  122,  122,  122,  275,
			  275,  275,  276,  276,  276,  276,  276,  276,  276,  123,
			  123,    0,  123,  123,  123,  123,  123,  123,  123,  230,
			  409,  409,  409,  230,  124,  124,  124,  124,  124,  124,
			  124,  124,  124,  124,  130,  380,  380,  380,  380,  125,
			  125,  125,  125,  125,  125,  125,  125,  125,  125,  132,
			  235,  230,  653,    0,  235,  230,  126,  255,    0,  126,
			  126,  126,  126,  126,  126,  126,  129,    0,    0,  129,

			  129,  129,  129,  410,  410,  410,    0,    0,  129,  667,
			  133,    0,  235,    0,  653,  129,  235,  129,    0,  129,
			  129,  129,  129,  134,  129,  671,  129,  411,  411,  411,
			  129,    0,  129,  135,    0,  129,  129,  129,  129,  129,
			  129,  667,    0,  136,  130,  130,  130,  130,  130,  130,
			  130,  130,  130,  130,  412,  412,  412,  671,    0,  132,
			  132,  132,  132,  132,  132,  132,  132,  132,  132,    0,
			  255,  255,  255,  255,  255,  255,  255,  413,  413,  413,
			  414,  414,  414,  129,  129,  129,  129,  129,  129,  129,
			  133,  133,  683,  133,  133,  133,  133,  133,  133,  133,

			  522,  522,  522,  134,  134,  134,  134,  134,  134,  134,
			  134,  134,  134,  135,  135,  135,  135,  135,  135,  135,
			  135,  135,  135,  136,  683,  687,  136,  136,  136,  136,
			  136,  136,  136,  150,  150,  150,  150,  169,    0,  689,
			  169,    0,  169,  150,  150,  150,  150,  150,  150,  167,
			  170,  167,  169,  673,  172,  167,  172,  687,  170,    0,
			  170,  167,  172,  523,  523,  523,  172,    0,  673,  169,
			  170,  689,  169,  150,  169,  150,  150,  150,  150,  150,
			  150,  167,  170,  167,  169,  673,  172,  167,  172,  171,
			  170,  171,  170,  167,  172,  181,  171,  181,  172,  186,

			  673,  171,  170,  181,  189,  187,  189,  181,  186,  188,
			    0,  693,  187,  195,  187,  195,  189,    0,  203,    0,
			  188,  171,  188,  171,  187,  195,  203,  181,  171,  181,
			    0,  186,  188,  171,    0,  181,  189,  187,  189,  181,
			  186,  188,  190,  693,  187,  195,  187,  195,  189,  190,
			  203,  190,  188,  191,  188,  191,  187,  195,  203,  191,
			  421,  190,  192,    0,  188,  191,  192,  223,    0,  192,
			    0,  197,  223,  421,  190,    0,  197,  199,  194,  199,
			  192,  190,  194,  190,  199,  191,  197,  191,  194,  199,
			  194,  191,  421,  190,  192,  198,  194,  191,  192,  223,

			  194,  192,  198,  197,  223,  421,  198,  217,  197,  199,
			  194,  199,  192,  217,  194,  200,  199,    0,  197,  217,
			  194,  199,  194,  200,  205,  200,  205,  198,  194,  201,
			  200,  201,  194,  201,  198,  200,  205,  201,  198,  217,
			  207,  201,  207,  207,    0,  217,  284,  200,  284,  284,
			    0,  217,  207,  206,    0,  200,  205,  200,  205,    0,
			    0,  201,  200,  201,  206,  201,  206,  200,  205,  201,
			    0,  696,  207,  201,  207,  207,  206,  210,  212,  210,
			  212,  210,  210,  397,  207,  206,  220,  213,  397,  213,
			  212,  213,  210,    0,    0,  210,  206,  220,  206,  213,

			    0,    0,  284,  696,    0,  215,    0,  215,  206,  210,
			  212,  210,  212,  210,  210,  397,    0,  215,  220,  213,
			  397,  213,  212,  213,  210,  218,  218,  210,  218,  220,
			  675,  213,  214,  284,  214,    0,  214,  215,  218,  215,
			  214,  222,  214,  449,  219,  675,  449,  214,  224,  215,
			  214,  222,  214,  219,  224,  219,  219,  218,  218,  221,
			  218,  221,  675,    0,  214,  219,  214,  221,  214,    0,
			  218,  221,  214,  222,  214,  449,  219,  675,  449,  214,
			  224,    0,  214,  222,  214,  219,  224,  219,  219,    0,
			  227,  221,    0,  221,  226,  236,  226,  219,  227,  221,

			  227,  226,  228,  221,  236,  229,  226,  229,    0,  395,
			  227,  228,  231,  228,  240,  395,  705,  229,  240,  231,
			    0,  231,  227,  228,  244,    0,  226,  236,  226,  244,
			  227,  231,  227,  226,  228,    0,  236,  229,  226,  229,
			  244,  395,  227,  228,  231,  228,  240,  395,  705,  229,
			  240,  231,  232,  231,  232,  228,  244,  232,  238,  238,
			  238,  244,  232,  231,  717,  232,  246,  232,  232,    0,
			  238,    0,  244,  234,  250,  246,  234,    0,  250,    0,
			  234,  239,    0,  239,  232,    0,  232,  239,    0,  232,
			  238,  238,  238,  239,  232,    0,  717,  232,  246,  232,

			  232,  233,  238,  233,    0,  234,  250,  246,  234,  233,
			  250,  233,  234,  239,  233,  239,  233,  233,  237,  239,
			  237,  233,  237,  721,  419,  239,    0,  243,    0,  243,
			  237,    0,    0,  233,  419,  233,  243,    0,  242,  243,
			    0,  233,    0,  233,  256,  242,  233,  242,  233,  233,
			  237,    0,  237,  233,  237,  721,  419,  242,  252,  243,
			  249,  243,  237,  249,  245,  249,  419,  252,  243,  245,
			  242,  243,  245,  257,  245,  249,  248,  242,  248,  242,
			  245,  253,  248,  253,  245,  258,  399,  253,  248,  242,
			  252,    0,  249,  253,  399,  249,  245,  249,  259,  252, yy_Dummy>>,
			1, 1000, 1000)
		end

	yy_chk_template_3 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			    0,  245,  251,    0,  245,    0,  245,  249,  248,  251,
			  248,  251,  245,  253,  248,  253,  245,  260,  399,  253,
			  248,  251,  524,  524,  524,  253,  399,  256,  256,  256,
			  256,  256,  256,  256,  251,  261,  389,  389,  389,    0,
			    0,  251,    0,  251,    0,  262,  277,  277,  277,  277,
			  277,  277,  277,  251,    0,  257,  257,  257,  257,  257,
			  257,  257,  257,    0,  723,  258,  258,  258,  258,  258,
			  258,  258,  258,  258,  258,    0,  389,    0,  259,  259,
			    0,  259,  259,  259,  259,  259,  259,  259,  278,  278,
			  278,  278,  278,  278,  278,  278,  723,  260,  260,  260,

			  260,  260,  260,  260,  260,  260,  260,  286,  525,  525,
			  525,  526,  526,  526,  287,  261,  261,  261,  261,  261,
			  261,  261,  261,  261,  261,  262,    0,    0,  262,  262,
			  262,  262,  262,  262,  262,  279,  279,  279,  279,  279,
			  279,  279,  279,  279,  279,  280,  280,    0,  280,  280,
			  280,  280,  280,  280,  280,  281,  281,  281,  281,  281,
			  281,  281,  281,  281,  281,  282,  282,  282,  282,  282,
			  282,  282,  282,  282,  282,  283,    0,  733,  283,  283,
			  283,  283,  283,  283,  283,  285,    0,  285,  285,  289,
			    0,  289,  289,    0,  286,  286,  286,  286,  286,  286,

			  286,  287,  287,  287,  287,  287,  287,  287,  290,  733,
			    0,  290,    0,  290,  423,  291,  290,  735,  291,    0,
			  291,    0,  423,  291,  293,  293,  293,  293,  293,  293,
			  293,    0,  292,  428,  292,  292,  777,  428,    0,  294,
			    0,  285,  294,    0,  294,  289,  423,  294,  295,  735,
			    0,  295,    0,  295,  423,    0,  295,    0,  296,  429,
			    0,  296,    0,  296,  779,  428,  296,  429,  777,  428,
			  297,    0,  285,  297,    0,  297,  289,    0,  297,    0,
			    0,  289,  289,  289,  289,  289,  289,  289,  292,  298,
			  787,  429,  298,    0,  298,    0,  779,  298,    0,  429,

			  290,  290,  290,  290,  290,  290,  290,  291,  291,  291,
			  291,  291,  291,  291,    0,  299,    0,    0,  299,  292,
			  299,    0,  787,  299,  301,  301,  301,  301,  301,  301,
			  301,  294,  294,  294,  294,  294,  294,  294,  789,  295,
			  295,  295,  295,  295,  295,  295,  295,  296,  296,  296,
			  296,  296,  296,  296,  296,  296,  296,    0,  797,  297,
			  297,    0,  297,  297,  297,  297,  297,  297,  297,  300,
			  789,    0,  300,    0,  300,    0,    0,  300,  298,  298,
			  298,  298,  298,  298,  298,  298,  298,  298,  302,  497,
			  797,  302,    0,  302,  497,    0,  302,  309,  309,  309,

			  309,  309,  309,  309,  299,  299,  299,  299,  299,  299,
			  299,  299,  299,  299,  303,    0,    0,  303,    0,  303,
			    0,  497,  303,    0,  304,    0,  497,  304,  443,  304,
			    0,    0,  304,    0,  305,    0,    0,  305,  443,  305,
			  417,    0,  305,  711,  306,  427,  417,  306,  379,  306,
			  379,    0,  306,  379,  379,  379,  379,  427,  300,  711,
			  443,  300,  300,  300,  300,  300,  300,  300,  307,    0,
			  443,  307,  417,  307,    0,  711,  307,  427,  417,    0,
			  302,  302,  302,  302,  302,  302,  302,  308,    0,  427,
			  308,  711,  308,  813,    0,  308,  310,  310,  310,  310,

			  310,  310,  310,    0,    0,  303,  303,  303,  303,  303,
			  303,  303,  303,  304,  304,  304,  304,  304,  304,  304,
			  304,  304,  304,  305,  305,  813,  305,  305,  305,  305,
			  305,  305,  305,  306,  306,  306,  306,  306,  306,  306,
			  306,  306,  306,  311,  311,  311,  311,  311,  311,  311,
			  312,  312,  312,  312,  312,  312,  312,  307,  307,  307,
			  307,  307,  307,  307,  307,  307,  307,  315,    0,    0,
			  315,  527,  527,  527,  316,  821,  308,  316,    0,  308,
			  308,  308,  308,  308,  308,  308,  313,  313,  313,  313,
			  313,  313,  313,  313,  313,  313,  314,  314,  314,  314,

			  314,  314,  314,  314,  314,  314,  317,  821,  425,  317,
			  528,  528,  528,  318,  433,  469,  318,  425,  433,    0,
			  319,  469,    0,  319,    0,    0,  318,  318,  318,  318,
			  320,    0,    0,  320,  529,  529,  529,  383,  321,  383,
			  425,  321,  383,  383,  383,  383,  433,  469,  322,  425,
			  433,  322,    0,  469,  315,  315,  315,  315,  315,  315,
			  315,  316,  316,  316,  316,  316,  316,  316,  323,    0,
			    0,  323,  385,    0,  385,  385,  385,  385,  324,    0,
			    0,  324,  605,  605,  605,  605,    0,    0,  325,    0,
			    0,  325,    0,  317,  317,  317,  317,  317,  317,  317,

			  318,  318,  318,  318,  318,  318,  318,  319,  319,  319,
			  319,  319,  319,  319,  385,    0,    0,  320,  320,  320,
			  320,  320,  320,  320,  321,  321,  321,  321,  321,  321,
			  321,  321,  322,  322,  322,  322,  322,  322,  322,  322,
			  322,  322,  326,    0,  393,  326,  393,  393,  393,  393,
			    0,  823,  323,  323,    0,  323,  323,  323,  323,  323,
			  323,  323,  324,  324,  324,  324,  324,  324,  324,  324,
			  324,  324,  325,  325,  325,  325,  325,  325,  325,  325,
			  325,  325,  327,  823,  327,  327,  393,  327,    0,    0,
			  327,  607,  607,  607,  607,  328,  825,  328,  328,    0,

			  328,    0,    0,  328,    0,  378,  378,  378,  378,  629,
			  829,  629,  396,  329,  396,  396,  329,    0,  394,  378,
			  394,  394,  394,  394,  396,    0,  326,    0,  825,  326,
			  326,  326,  326,  326,  326,  326,  327,  330,    0,    0,
			  330,  629,  829,  629,  396,  378,  396,  396,    0,  328,
			  331,  378,  436,  331,    0,    0,  396,  617,  617,  617,
			  394,    0,  329,  332,  436,    0,  332,    0,  327,  382,
			  382,  382,  382,    0,  327,  327,  327,  327,  327,  327,
			  327,  328,  335,  382,  436,  335,  330,  328,  328,  328,
			  328,  328,  328,  328,  329,  336,  436,  617,  336,  331,

			  329,  329,  329,  329,  329,  329,  329,    0,  333,  382,
			    0,  333,  332,    0,    0,  382,  337,  831,  330,  337,
			  606,  606,  606,  606,  330,  330,  330,  330,  330,  330,
			  330,  331,  334,    0,  398,  334,  398,  331,  331,  331,
			  331,  331,  331,  331,  332,  338,  398,    0,  338,  831,
			  332,  332,  332,  332,  332,  332,  332,  333,  339,  839,
			  606,  339,  610,  610,  610,  610,  398,    0,  398,  335,
			  335,  335,  335,  335,  335,  335,  340,    0,  398,  340,
			  851,  334,  336,  336,  336,  336,  336,  336,  336,  333,
			  341,  839,  333,  333,  333,  333,  333,  333,  333,  333, yy_Dummy>>,
			1, 1000, 2000)
		end

	yy_chk_template_4 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  333,  333,  343,  337,  337,  337,  337,  337,  337,  337,
			  344,    0,  851,  334,    0,    0,  334,  334,  334,  334,
			  334,  334,  334,  334,  334,  334,  345,  611,  611,  611,
			  611,    0,  338,  338,  338,  338,  338,  338,  338,  346,
			  857,    0,  339,  339,  339,  339,  339,  339,  339,  339,
			  339,  339,  347,  635,  635,  635,  636,  636,  636,  350,
			  340,  340,  340,  340,  340,  340,  340,  340,  340,  340,
			  348,    0,  857,  341,  341,  341,  341,  341,  341,  341,
			  349,  612,  612,  612,  612,  343,  343,  343,  343,  343,
			  343,  343,  344,  344,  344,  344,  344,  344,  344,  344,

			  351,  739,  739,  739,    0,    0,  345,  345,  345,  345,
			  345,  345,  345,  345,  345,  345,  353,    0,    0,  346,
			  346,  612,  346,  346,  346,  346,  346,  346,  346,  354,
			  859,    0,  347,  347,  347,  347,  347,  347,  347,  347,
			  347,  347,  350,  350,  350,  350,  350,  350,  350,  356,
			  348,  348,  348,  348,  348,  348,  348,  348,  348,  348,
			  349,  355,  859,  349,  349,  349,  349,  349,  349,  349,
			  355,  355,  355,  355,  357,  740,  740,  740,    0,    0,
			    0,  358,    0,  351,  351,  351,  351,  351,  351,  351,
			  359,  440,  451,  863,    0,  440,  451,  360,  401,  353,

			  353,  353,  353,  353,  353,  353,  361,    0,  402,  401,
			  402,  401,  354,  354,  354,  354,  354,  354,  354,  362,
			  402,  401,  885,  440,  451,  863,  363,  440,  451,    0,
			  401,    0,  356,  356,  356,  356,  356,  356,  356,  364,
			  402,  401,  402,  401,  355,  355,  355,  355,  355,  355,
			  355,  365,  402,  401,  885,  531,  887,  357,  357,  357,
			  357,  357,  357,  357,  358,  358,  358,  358,  358,  358,
			  358,  366,    0,  359,  359,  359,  359,  359,  359,  359,
			  360,  360,  360,  360,  360,  360,  360,  367,  887,  361,
			  361,  361,  361,  361,  361,  361,  368,  765,  765,  765,

			  765,  539,  362,  362,  362,  362,  362,  362,  362,  363,
			  363,  363,  363,  363,  363,  363,  369,  895,  404,    0,
			  404,  445,  364,  364,  364,  364,  364,  364,  364,  370,
			  404,  637,  445,  637,  365,  365,  365,  365,  365,  365,
			  365,  371,  531,  531,  531,  531,  531,  531,  531,  895,
			  404,  372,  404,  445,  366,  366,  366,  366,  366,  366,
			  366,  373,  404,  637,  445,  637,  480,    0,    0,    0,
			  367,  367,  367,  367,  367,  367,  367,  374,  480,  368,
			  368,  368,  368,  368,  368,  368,    0,  375,  539,  539,
			  539,  539,  539,  539,  539,    0,    0,  376,  480,  369,

			  369,  369,  369,  369,  369,  369,    0,  377,    0,    0,
			  480,    0,  370,  370,  370,  370,  370,  370,  370,  453,
			  647,  905,  647,  453,  371,  371,  371,  371,  371,  371,
			  371,  372,  372,  372,  372,  372,  372,  372,  372,  372,
			  372,  373,  373,  373,  373,  373,  373,  373,  373,  373,
			  373,  453,  647,  905,  647,  453,    0,  374,  374,  374,
			  374,  374,  374,  374,  374,  374,  374,  375,  375,  375,
			  375,  375,  375,  375,  375,  375,  375,  376,  376,  376,
			  376,  376,  376,  376,  376,  376,  376,  377,  377,  377,
			  377,  377,  377,  377,  377,  377,  377,  384,  454,  384,

			  384,  384,  384,  406,    0,  454,  406,  609,  406,  609,
			  384,    0,  609,  609,  609,  609,  447,    0,  406,  407,
			  447,  766,  766,  766,  766,    0,    0,  407,    0,  416,
			  454,  416,  907,  447,    0,  406,  407,  454,  406,  384,
			  406,  416,  384,  391,  391,  391,  391,    0,  447,  408,
			  406,  407,  447,  391,  391,  391,  391,  391,  391,  407,
			  408,  416,  408,  416,  907,  447,  408,  420,  407,  420,
			  464,    0,  408,  416,  420,    0,    0,  464,    0,  420,
			    0,  408,  418,  391,    0,  391,  391,  391,  391,  391,
			  391,  418,  408,  418,  408,  422,  461,  422,  408,  420,

			  461,  420,  464,  418,  408,  422,  420,  422,  424,  464,
			  426,  420,  426,    0,  418,    0,  426,    0,  911,  424,
			    0,  424,  426,  418,  430,  418,  430,  422,  461,  422,
			    0,  424,  461,  430,    0,  418,  430,  422,  431,  422,
			  424,    0,  426,    0,  426,  431,    0,  431,  426,  432,
			  911,  424,  434,  424,  426,    0,  430,  431,  430,  434,
			  432,  434,  432,  424,  437,  430,  437,    0,  430,    0,
			  431,  434,  432,  438,    0,  438,  437,  431,  450,  431,
			  450,  432,  438,    0,  434,  438,  441,  439,  917,  431,
			  450,  434,  432,  434,  432,  439,  437,  441,  437,  441,

			  441,  439,    0,  434,  432,  438,  442,  438,  437,  441,
			  450,    0,  450,  442,  438,  442,  455,  438,  441,  439,
			  917,  509,  450,  933,  455,  442,  509,  439,  444,  441,
			  444,  441,  441,  439,  446,  444,  446,  939,  442,  467,
			  444,  441,  446,  467,  463,  442,  446,  442,  455,  448,
			  448,  448,  463,  509,  511,  933,  455,  442,  509,  511,
			  444,  448,  444,  448,    0,  837,  446,  444,  446,  939,
			  456,  467,  444,    0,  446,  467,  463,  456,  446,  456,
			  837,  448,  448,  448,  463,  457,  511,  458,  457,  456,
			  457,  511,  631,  448,  458,  448,  458,  837,  631,    0,

			  457,  459,  456,  459,  473,  459,  458,    0,  473,  456,
			    0,  456,  837,  459,  477,  479,  460,  457,  477,  458,
			  457,  456,  457,  479,  631,  876,  458,  460,  458,  460,
			  631,  465,  457,  459,  462,  459,  473,  459,  458,  460,
			  473,  462,  465,  462,  465,  459,  477,  479,  460,    0,
			  477,  876,    0,  462,  465,  479,  466,  876,  466,  460,
			  466,  460,    0,  465,    0,  943,  462,  945,  466,    0,
			  468,  460,    0,  462,  465,  462,  465,  468,    0,  468,
			    0,  470,  947,  470,  470,  462,  465,  478,  466,  468,
			  466,  478,  466,  470,  472,    0,  472,  943,  474,  945,

			  466,  476,  468,    0,  476,  474,  472,  474,    0,  468,
			  476,  468,  476,  470,  947,  470,  470,  474,  482,  478,
			    0,  468,  476,  478,  953,  470,  472,  482,  472,  475,
			  474,    0,  475,  476,  481,  475,  476,  474,  472,  474,
			  481,  489,  476,  657,  476,  489,  483,    0,  657,  474,
			  482,  484,  481,  483,  476,  483,  953,    0,  484,  482,
			  484,  475,  975,  485,  475,  483,  481,  475,    0,    0,
			  484,    0,  481,  489,  485,  657,  485,  489,  483,  486,
			  657,  486,    0,  484,  481,  483,  485,  483,  486,  487,
			  484,  486,  484,  490,  975,  485,  685,  483,  487,  685, yy_Dummy>>,
			1, 1000, 3000)
		end

	yy_chk_template_5 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  487,  490,  484,  488,    0,  488,  485,  487,  485,  488,
			  487,  486,  493,  486,  781,  488,  493,  491,  485,  781,
			  486,  487,    0,  486,  491,  490,  491,  492,  685,    0,
			  487,  685,  487,  490,    0,  488,  491,  488,  492,  487,
			  492,  488,  487,    0,  493,  494,  781,  488,  493,  491,
			  492,  781,  494,  502,  494,  498,  491,  498,  491,  492,
			  496,  502,  499,  496,  494,  496,  499,  498,  491,  500,
			  492,  623,  492,    0,    0,  496,  500,  494,  500,  501,
			    0,  623,  492,  501,  494,  502,  494,  498,  500,  498,
			  627,    0,  496,  502,  499,  496,  494,  496,  499,  498,

			  627,  500,  532,  623,  505,  504,  505,  496,  500,  505,
			  500,  501,  504,  623,  504,  501,  505,    0,  506,  510,
			  500,  506,  627,  506,  504,  508,    0,  510,  508,  510,
			  508,  516,  627,  506,    0,  639,  505,  504,  505,  510,
			  508,  505,  517,  979,  504,  639,  504,    0,  505,  518,
			  506,  510,  512,  506,  512,  506,  504,  508,  519,  510,
			  508,  510,  508,    0,  512,  506,  514,  639,  514,  520,
			  625,  510,  508,    0,    0,  979,  641,  639,  514,  521,
			  641,  625,    0,    0,  512,  533,  512,    0,  532,  532,
			  532,  532,  532,  532,  532,  532,  512,  534,  514,    0,

			  514,    0,  625,  768,  768,  768,  768,  535,  641,    0,
			  514,    0,  641,  625,  516,  516,  516,  516,  516,  516,
			  516,  536,    0,    0,    0,  517,  517,  517,  517,  517,
			  517,  517,  518,  518,  518,  518,  518,  518,  518,  537,
			    0,  519,  519,  519,  519,  519,  519,  519,  540,  520,
			  520,  520,  520,  520,  520,  520,  520,  520,  520,  521,
			  521,  521,  521,  521,  521,  521,  521,  521,  521,  533,
			  533,  533,  533,  533,  533,  533,  533,  533,  533,  541,
			    0,  534,  534,    0,  534,  534,  534,  534,  534,  534,
			  534,  535,  535,  535,  535,  535,  535,  535,  535,  535,

			  535,  542,    0,    0,    0,  536,  536,  536,  536,  536,
			  536,  536,  536,  536,  536,  543,  558,  558,  558,  558,
			  558,  558,  558,  537,    0,  544,  537,  537,  537,  537,
			  537,  537,  537,    0,  540,  540,  540,  540,  540,  540,
			  540,  540,  545,  624,  546,  624,    0,  546,  964,  546,
			  624,  547,  546,    0,  547,  624,  547,    0,    0,  547,
			    0,    0,    0,  541,  541,  541,  541,  541,  541,  541,
			  541,  541,  541,  548,  964,  624,  548,  624,  548,    0,
			  964,  548,  624,    0,    0,  542,  542,  624,  542,  542,
			  542,  542,  542,  542,  542,  770,  770,  770,  770,  543,

			  543,  543,  543,  543,  543,  543,  543,  543,  543,  544,
			  544,  544,  544,  544,  544,  544,  544,  544,  544,  549,
			  989,    0,  549,    0,  549,    0,  545,  549,    0,  545,
			  545,  545,  545,  545,  545,  545,  546,  546,  546,  546,
			  546,  546,  546,  547,  547,  547,  547,  547,  547,  547,
			  550,  991,  989,  550,    0,  550,    0,  614,  550,  614,
			  614,  614,  614,  643,    0,  548,  548,  548,  548,  548,
			  548,  548,  551,    0,  643,  551,    0,  551,  775,  552,
			  551,    0,  552,  991,  552,    0,  553,  552,  775,  553,
			  628,  553,  628,  554,  553,  643,  554,  628,  554,  614,

			  555,  554,  628,  555,    0,  555,  643,    0,  555,    0,
			  775,  549,  549,  549,  549,  549,  549,  549,  556,    0,
			  775,  556,  628,  556,  628,  995,  556,    0,  557,  628,
			    0,  557,    0,  557,  628,    0,  557,    0,    0,  550,
			  550,  550,  550,  550,  550,  550,  550,  550,  550,  559,
			  559,  559,  559,  559,  559,  559,  560,  995,    0,  560,
			    0,  551,  551,  551,  551,  551,  551,  551,  551,  551,
			  551,  552,  552,  552,  552,  552,  552,  552,  553,  553,
			  553,  553,  553,  553,  553,  554,  554,  554,  554,  554,
			  554,  554,  555,  555,  555,  555,  555,  555,  555,  561,

			    0,  645,  561,    0,    0,  645,    0,  556,  556,  556,
			  556,  556,  556,  556,  556,  556,  556,  557,  557,  557,
			  557,  557,  557,  557,  557,  557,  557,    0,  626,  563,
			  626,    0,  563,  645,    0,  663,  626,  645,  562,  663,
			  626,  562,  997,  560,  560,  560,  560,  560,  560,  560,
			  562,  562,  562,  562,  562,  563,  564,    0,    0,  564,
			  626,    0,  626,  565,    0,    0,  565,  663,  626,    0,
			  566,  663,  626,  566,  997,  651,    0,  567,    0,  668,
			  567,  651, 1009,  668,    0,    0,  561,  561,  561,  561,
			  561,  561,  561,  568,    0,    0,  568,  613,    0,  613,

			  613,  613,  613,  569,  679,    0,  569,  651,  679, 1015,
			  613,  668,    0,  651, 1009,  668,  563,  563,  563,  563,
			  563,  563,  563,    0,    0,  562,  562,  562,  562,  562,
			  562,  562,    0,    0,  572,    0,  679,  572,    0,  613,
			  679, 1015,  613,  564,  564,  564,  564,  564,  564,  564,
			  565,  565,  565,  565,  565,  565,  565,  566,  566,  566,
			  566,  566,  566,  566,  567,  567,  567,  567,  567,  567,
			  567,  570,    0, 1028,  570,    0,    0,  568,  568,  568,
			  568,  568,  568,  568,  568,  568,  568,  569,  569,  569,
			  569,  569,  569,  569,  569,  569,  569,  571,    0,    0,

			  571,  665,    0,    0,  573, 1028,  621,  573,  621,  621,
			  621,  621, 1032,  665,  622,  574,  622,  622,  622,  622,
			  570,  572,  572,  572,  572,  572,  572,  572,  575,  604,
			  604,  604,  604,  665,  719,  576,  608,  608,  608,  608,
			  649,  719,  577,  604, 1032,  665,  571,  703,  621,  649,
			  608,  703,  570,  578,    0,    0,  622,    0,  570,  570,
			  570,  570,  570,  570,  570,  579,  719,    0,    0,  604,
			    0,    0,  649,  719,  691,  604,  608,  691,  571,  703,
			    0,  649,  608,  703,  571,  571,  571,  571,  571,  571,
			  571,  573,  573,  573,  573,  573,  573,  573,  574,  574,

			  574,  574,  574,  574,  574,  602,  691,    0,    0,  691,
			    0,  575,  575,  575,  575,  575,  575,  575,  576,  576,
			  576,  576,  576,  576,  576,  577,  577,  577,  577,  577,
			  577,  577,  603,  578,  578,  578,  578,  578,  578,  578,
			  578,  578,  578,    0,    0,  579,  579,  579,  579,  579,
			  579,  579,  579,  579,  579,  585,  764,  764,  764,  764,
			    0,    0,    0,  585,  585,  585,  585,  585,  655,  658,
			  661,  699,  708,  725,  699,  708,  725,  655,  658,  661,
			  772,  772,  772,  772,    0,  602,  602,  602,  602,  602,
			  602,  602,  602,  602,  602,  729,  764, 1034,  729,    0, yy_Dummy>>,
			1, 1000, 4000)
		end

	yy_chk_template_6 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  655,  658,  661,  699,  708,  725,  699,  708,  725,  655,
			  658,  661,  603,  603,  603,  603,  603,  603,  603,  603,
			  603,  603,  677,  681, 1038,  633,  809,  729,  630, 1034,
			  729,  677,  681,  630,  633,  630,  633,  809,  585,  585,
			  585,  585,  585,  585,  585,  630,  633,  634,  638,  638,
			  634,  638,  634,    0,  677,  681, 1038,  633,  809,  695,
			  630,  638,  634,  677,  681,  630,  633,  630,  633,  809,
			    0,  695,    0,    0,  707,    0,    0,  630,  633,  634,
			  638,  638,  634,  638,  634,  640,  707,  640,  727,  642,
			    0,  695,  640,  638,  634,  646,  642,  640,  642,  644,

			  727,  644,  646,  695,  646,  648,  707,  644,  642,    0,
			  648,  644,  648,    0,  646,    0,    0,  640,  707,  640,
			  727,  642,  648,    0,  640,    0,    0,  646,  642,  640,
			  642,  644,  727,  644,  646,  803,  646,  648,  803,  644,
			  642,  652,  648,  644,  648,  650,  646,  650,  891,  713,
			  652,  650,  652,  654,  648,  713,  654,  650,  654,  656,
			  891,  656,  652,    0,  659,  656,  659,  803,  654,    0,
			  803,  656,    0,  652,    0,    0,  659,  650,    0,  650,
			  891,  713,  652,  650,  652,  654,  701,  713,  654,  650,
			  654,  656,  891,  656,  652,  701,  659,  656,  659,  660,

			  654,  660,    0,  656,  662,  660,  662,  669,  659,  669,
			  662,  660,  666,  664,  666,    0,  662,    0,  701,  669,
			  664,  666,  664,    0,  666,  715,    0,  701,    0,    0,
			 1040,  660,  664,  660,  715,    0,  662,  660,  662,  669,
			  670,  669,  662,  660,  666,  664,  666,  670,  662,  670,
			    0,  669,  664,  666,  664,  672,  666,  715,  672,  670,
			  672,  674, 1040,  674,  664,  676,  715,  676,    0,    0,
			  672,    0,  670,  674,  678,  680,  678,  676,    0,  670,
			  678,  670,  680,    0,  680,    0,  678,  672,  731,    0,
			  672,  670,  672,  674,  680,  674,  731,  676,  682,  676,

			  682,  684,  672,  684,  682,  674,  678,  680,  678,  676,
			  682, 1042,  678,  684,  680,  686,  680,  686,  678,  688,
			  731,  688,  690,    0,  690,    0,  680,  686,  731,    0,
			  682,  688,  682,  684,  690,  684,  682, 1046,  692,    0,
			  692,    0,  682, 1042,    0,  684,  694,  686,  694,  686,
			  692,  688,  791,  688,  690,  697,  690,  697,  694,  686,
			    0,  791,    0,  688,  697,    0,  690,  697,  698, 1046,
			  692,  698,  692,  698,  763,  763,  763,  763,  694,  702,
			  694,  702,  692,  698,  791,  702,  700,  697,  763,  697,
			  694,  702,  700,  791,  700,    0,  697,  783,  783,  697,

			  698,    0,    0,  698,  700,  698,    0,  704,  704,  704,
			    0,  702,    0,  702,  785,  698,    0,  702,  700,  704,
			  763,  785,  706,  702,  700,  706,  700,  706,    0,  783,
			  783,  983,  710,  709,  710,  709,  700,  706,  983,  704,
			  704,  704,  709,    0,  710,  709,  785,  714,  712,  827,
			  712,  704,    0,  785,  706,  827,  714,  706,  714,  706,
			  712,  712, 1050,  983,  710,  709,  710,  709,  714,  706,
			  983,  793,    0,    0,  709,  793,  710,  709,    0,  714,
			  712,  827,  712,  716,  718,  716,  718,  827,  714,  716,
			  714,    0,  712,  712, 1050,  716,  718,  720,    0,  720,

			  714,  720,  722,  793,  722,  726,    0,  793,  724,  720,
			  724,  726,    0,  726,  722,  716,  718,  716,  718,    0,
			  724,  716, 1054,  726,    0,  801,  801,  716,  718,  720,
			  737,  720,    0,  720,  722,    0,  722,  726,  738,    0,
			  724,  720,  724,  726,  741,  726,  722,  728,  730,  728,
			  730,  732,  724,  742, 1054,  726,  728,  801,  801,  728,
			  730,  734,  732,  734,  732,  736,  743,  736,  769,  769,
			  769,  769,  896,  734,  732,  744,    0,  736,  896,  728,
			  730,  728,  730,  732,    0,  745,    0,    0,  728,    0,
			    0,  728,  730,  734,  732,  734,  732,  736,  746,  736,

			  875,  875,  875,  875,  896,  734,  732,  747,  769,  736,
			  896,    0,    0,  737,  737,  737,  737,  737,  737,  737,
			  748,  738,  738,  738,  738,  738,  738,  738,  749, 1056,
			    0,  741,  741,  741,  741,  741,  741,  741,  750,    0,
			  742,  742,  742,  742,  742,  742,  742, 1063,  751,  879,
			  879,  879,  879,  743,  743,  743,  743,  743,  743,  743,
			  752, 1056,  744,  744,  744,  744,  744,  744,  744,  745,
			  745,  745,  745,  745,  745,  745,  745,  745,  745, 1063,
			    0,    0,  746,  746,  746,  746,  746,  746,  746,  746,
			  746,  746, 1067,    0,  747,  747,  747,  747,  747,  747,

			  747,    0,    0,  771,  771,  771,  771,  748,  748,  748,
			  748,  748,  748,  748,    0,  749,  749,  749,  749,  749,
			  749,  749,    0,    0, 1067,  750,  750,  750,  750,  750,
			  750,  750,  751,  751,  751,  751,  751,  751,  751,  751,
			  751,  751,  760,  771,  752,  752,  752,  752,  752,  752,
			  752,  752,  752,  752,  753,  761,  805,  753,    0,  753,
			  805,  754,  753,  849,  754,    0,  754,    0,  755,  754,
			    0,  755,    0,  755,  849,  756,  755,  776,  756,  776,
			  756,  795,  799,  756,  776, 1069,  795,  757,  805,  776,
			  757,  799,  805,    0,  758,  849,    0,  758,    0,  757,

			  757,  757,  757,  757,  759, 1071,  849,  759,    0,  776,
			    0,  776,    0,  795,  799,  762,  776, 1069,  795,    0,
			    0,  776,    0,  799,    0,  760,  760,  760,  760,  760,
			  760,  760,  880,  880,  880,  880,    0, 1071,  761,  761,
			  761,  761,  761,  761,  761,    0,  753,  753,  753,  753,
			  753,  753,  753,  754,  754,  754,  754,  754,  754,  754,
			  755,  755,  755,  755,  755,  755,  755,  756,  756,  756,
			  756,  756,  756,  756,  757,  757,  757,  757,  757,  757,
			  757,  758,  758,  758,  758,  758,  758,  758, 1074,    0,
			    0,  759,  759,  759,  759,  759,  759,  759,  762,  762,

			  762,  762,  762,  762,  762,  767,  767,  767,  767,  773,
			  773,  773,  773,    0,    0,    0,  778,    0,  778,  767,
			 1074,    0,  774,  773,  774,  774,  774,  774,  778,  780,
			  786,  780,    0,  784,  782,  815,  782,  784,  835,  784,
			  786,  780,  786,    0,  815,  767,  782,  835,  778,  784,
			  778,  767,  786,    0,  807,  773,    0,    0,    0,  807,
			  778,  780,  786,  780,  774,  784,  782,  815,  782,  784,
			  835,  784,  786,  780,  786,  788,  815,  788,  782,  835,
			  790,  784,  790,  792,  786,  792,  807,  788,  796,  792,
			  796,  807,  790,    0,  794,  792,    0,    0,  794,    0, yy_Dummy>>,
			1, 1000, 5000)
		end

	yy_chk_template_7 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  796,  794,    0,  794,  798,    0,  798,  788,    0,  788,
			    0,    0,  790,  794,  790,  792,  798,  792,    0,  788,
			  796,  792,  796,    0,  790,  802,  794,  792,    0,  802,
			  794,  802,  796,  794,  804,  794,  798,  800,  798,  800,
			  804,  802,  804,  800,    0,  794,  806,    0,  798,  800,
			  808,    0,  804,  806,    0,  806,    0,  802,  808,  811,
			  808,  802,    0,  802,  811,  806,  804,    0,  855,  800,
			  808,  800,  804,  802,  804,  800,  855,  812,  806,  812,
			    0,  800,  808,    0,  804,  806,  810,  806,  810,  812,
			  808,  811,  808,  814,  810,  814,  811,  806,  810,  817,

			  855,  816,  808,  816,  817,  814,    0,  816,  855,  812,
			  818,  812,  818,  816,    0,  819,    0,    0,  810,  819,
			  810,  812,  818,    0,    0,  814,  810,  814,  833,    0,
			  810,  817,  833,  816,  820,  816,  817,  814,  824,  816,
			  824,  820,  818,  820,  818,  816,  832,  819,  832,    0,
			  824,  819,  822,  820,  818,  822,  826,  822,  832,  826,
			  833,  826,    0,    0,  833,  828,  820,  822,    0,    0,
			  824,  826,  824,  820,  828,  820,  828,    0,  832,    0,
			  832,    0,  824,    0,  822,  820,  828,  822,  826,  822,
			  832,  826,  838,  826,  838,  830,    0,  828,  830,  822,

			  830,  841,  834,  826,  838,  841,  828,    0,  828,  834,
			  830,  834,    0,  836,    0,  836,    0,  853,  828,  836,
			    0,  834,    0,    0,  838,  836,  838,  830,  853,    0,
			  830,    0,  830,  841,  834,  840,  838,  841,  840,  842,
			  840,  834,  830,  834,    0,  836,  842,  836,  842,  853,
			  840,  836,  843,  834,  844,  845,  843,  836,  842,    0,
			  853,  844,  847,  844,  845,    0,  847,  840,    0,    0,
			  840,  842,  840,  844,    0,  919,    0,  846,  842,  846,
			  842,    0,  840,  846,  843,  919,  844,  845,  843,  846,
			  842,    0,    0,  844,  847,  844,  845,  848,  847,    0,

			  850,  852,  850,  852,  848,  844,  848,  919,  850,  846,
			    0,  846,  850,  852,  856,  846,  848,  919,  854,    0,
			  854,  846,    0,    0,    0,  856,  854,  856,    0,  848,
			  854,  867,  850,  852,  850,  852,  848,  856,  848,  858,
			  850,  858,  868,    0,  850,  852,  856,  862,  848,  861,
			  854,  858,  854,  861,  862,  869,  862,  856,  854,  856,
			  860,    0,  854,  860,  870,  860,  862,  865,  864,  856,
			  864,  858,  865,  858,    0,  860,    0,    0,    0,  862,
			  864,  861,  866,  858,  866,  861,  862,    0,  862,    0,
			    0,    0,  860,  871,  866,  860,  871,  860,  862,  865,

			  864,    0,  864,    0,  865,  871,    0,  860,  882,  882,
			  882,  882,  864,    0,  866,    0,  866,  931,  867,  867,
			  867,  867,  867,  867,  867,    0,  866,  931,    0,  868,
			  868,  868,  868,  868,  868,  868,  874,  874,  874,  874,
			    0,    0,  869,  869,  869,  869,  869,  869,  869,  931,
			    0,  870,  870,  870,  870,  870,  870,  870,  873,  931,
			  873,    0,    0,  873,  873,  873,  873,  878,  878,  878,
			  878,  881,  881,  881,  881,    0,  874,    0,    0,    0,
			  871,  871,  871,  871,  871,  871,  871,  877,  877,  877,
			  877,  883,    0,  883,    0,    0,  883,  883,  883,  883,

			    0,  877,  884,  884,  884,  884,  886,  878,  886,  889,
			  888,  881,  888,  889,  893,  921,  884,  890,  886,  892,
			  921,  892,  888,  899,  890,  893,  890,  894,  892,  894,
			    0,  892,    0,  877,  899,  894,  890,    0,  886,  894,
			  886,  889,  888,    0,  888,  889,  893,  921,  884,  890,
			  886,  892,  921,  892,  888,  899,  890,  893,  890,  894,
			  892,  894,  897,  892,  897,  901,  899,  894,  890,  901,
			  898,  894,  898,  898,  897,  900,  903,  900,    0,  902,
			  904,  909,  898,  900,  903,  909,  902,  900,  902,    0,
			    0,  904,    0,  904,  897,    0,  897,  901,  902,    0,

			    0,  901,  898,  904,  898,  898,  897,  900,  903,  900,
			    0,  902,  904,  909,  898,  900,  903,  909,  902,  900,
			  902,  913,  906,  904,  906,  904,  908,    0,  908,  913,
			  902,  912,  910,  912,  906,  904,  914,  927,  908,  910,
			  915,  910,    0,  912,  915,  927,    0,  914,  916,  914,
			  918,  910,  918,  913,  906,  916,  906,  916,  908,  914,
			  908,  913,  918,  912,  910,  912,  906,  916,  914,  927,
			  908,  910,  915,  910,  923,  912,  915,  927,    0,  914,
			  916,  914,  918,  910,  918,  923,  920,  916,  920,  916,
			  922,  914,  922,  920,  918,  924,  935,  924,  920,  916,

			  925,  935,  922,  924,    0,  937,  923,  924,  928,  941,
			  937,  925,    0,  941,    0,  929,    0,  923,  920,  928,
			  920,  928,  922,    0,  922,  920,  929,  924,  935,  924,
			  920,  928,  925,  935,  922,  924,  926,  937,  926,  924,
			  928,  941,  937,  925,  926,  941,  987,  929,  926,  987,
			    0,  928,  930,  928,  930,  932,    0,  932,  929,  934,
			  930,  934,  932,  928,  930,    0,    0,  932,  926,    0,
			  926,  934,    0,  936,    0,  936,  926,    0,  987,    0,
			  926,  987,    0,    0,  930,  936,  930,  932,  938,  932,
			  938,  934,  930,  934,  932,    0,  930,    0,    0,  932,

			  938,  949,  940,  934,  940,  936,  942,  936,    0,  944,
			    0,  944,  949,  942,  940,  942,  946,  936,  946,    0,
			  938,  944,  938,    0,    0,  942,  951,  948,  946,  948,
			    0,  951,  938,  949,  940,    0,  940,    0,  942,  948,
			  952,  944,  952,  944,  949,  942,  940,  942,  946,  993,
			  946,  993,  952,  944,  950,    0,  950,  942,  951,  948,
			  946,  948,  950,  951,  955,  954,  950,  954,  956, 1048,
			  956,  948,  952,    0,  952,  955,  956,  954, 1048,    0,
			  956,  993,    0,  993,  952,    0,  950,    0,  950,  957,
			  957,  957,  957,    0,  950,    0,  955,  954,  950,  954,

			  956, 1048,  956,  958,  958,  958,  958,  955,  956,  954,
			 1048,    0,  956,  959,  959,  959,  959,  960,    0,  960,
			    0,    0,  960,  960,  960,  960,  961,    0,  961,    0,
			    0,  961,  961,  961,  961,  962,  962,  962,  962,  963,
			  963,  963,  963,  965,  965,  965,  965,  966,  966,  966,
			  966,  967,  967,  967,  967,  969,  969,  969,  969,  970,
			  973,  970,  972,    0,  970,  970,  970,  970,  971,  969,
			  972,  973,  972,  971,    0,  962,  974,  976,  974,  976,
			  977,  978,  972,  978,  974,  977,  981,    0,  974,  976,
			    0,  981,  973,  978,  972,  969, 1018, 1018, 1018, 1018, yy_Dummy>>,
			1, 1000, 6000)
		end

	yy_chk_template_8 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  971,  969,  972,  973,  972,  971,    0,    0,  974,  976,
			  974,  976,  977,  978,  972,  978,  974,  977,  981,  982,
			  974,  976,  980,  981,  980,  978,  984,  982,  985,  982,
			    0,    0,  986,  985,  980,  988,  984,  988,  984,  982,
			  986,  990,  986,  990,    0,    0,    0,  988,  984,    0,
			    0,  982,  986,  990,  980,    0,  980,    0,  984,  982,
			  985,  982,    0,    0,  986,  985,  980,  988,  984,  988,
			  984,  982,  986,  990,  986,  990,  992,    0,  992,  988,
			  984,  996,  994,  996,  986,  990,  999,  994,  992,  994,
			  998,  999,  998,  996, 1000,    0, 1000, 1001, 1002,  994,

			 1005, 1001,  998, 1003, 1005, 1002, 1000, 1002,  992, 1003,
			  992,    0,    0,  996,  994,  996,    0, 1002,  999,  994,
			  992,  994,  998,  999,  998,  996, 1000,    0, 1000, 1001,
			 1002,  994, 1005, 1001,  998, 1003, 1005, 1002, 1000, 1002,
			 1004, 1003, 1004, 1004, 1006,    0, 1008, 1036, 1007, 1002,
			 1036, 1006, 1004, 1006, 1007, 1008, 1010, 1008, 1010,    0,
			 1011, 1013, 1012, 1006, 1011, 1013,    0, 1008, 1010, 1012,
			    0, 1012, 1004,    0, 1004, 1004, 1006,    0, 1008, 1036,
			 1007, 1012, 1036, 1006, 1004, 1006, 1007, 1008, 1010, 1008,
			 1010,    0, 1011, 1013, 1012, 1006, 1011, 1013, 1014, 1008,

			 1010, 1012, 1016, 1012, 1016, 1014,    0, 1014, 1019, 1019,
			 1019, 1019,    0, 1012, 1016,    0,    0, 1014, 1020, 1020,
			 1020, 1020, 1021, 1021, 1021, 1021, 1022, 1022, 1022, 1022,
			 1014,    0,    0,    0, 1016,    0, 1016, 1014,    0, 1014,
			 1025, 1025, 1025, 1025,    0, 1023, 1016, 1023, 1019, 1014,
			 1023, 1023, 1023, 1023, 1025, 1026, 1026, 1026, 1026, 1027,
			 1027, 1027, 1027, 1029, 1030, 1029,    0,    0, 1030, 1031,
			 1033, 1035, 1033, 1035,    0, 1029, 1031, 1037, 1031, 1037,
			 1025,    0, 1033, 1035,    0,    0, 1025,    0, 1031, 1037,
			 1060, 1060, 1060, 1060,    0, 1029, 1030, 1029,    0, 1027,

			 1030, 1031, 1033, 1035, 1033, 1035,    0, 1029, 1031, 1037,
			 1031, 1037, 1044,    0, 1033, 1035, 1039, 1041, 1039, 1041,
			 1031, 1037, 1043, 1044, 1043, 1045,    0, 1045, 1039, 1041,
			 1047, 1052, 1047, 1045, 1043, 1052,    0, 1045,    0,    0,
			    0, 1049, 1047, 1049, 1044,    0,    0, 1049, 1039, 1041,
			 1039, 1041,    0, 1049, 1043, 1044, 1043, 1045,    0, 1045,
			 1039, 1041, 1047, 1052, 1047, 1045, 1043, 1052, 1051, 1045,
			 1051,    0,    0, 1049, 1047, 1049, 1055, 1053, 1055, 1049,
			 1051, 1057,    0, 1057, 1053, 1049, 1053,    0, 1055, 1058,
			 1058, 1058, 1058, 1057,    0, 1065, 1053,    0,    0, 1065,

			 1051,    0, 1051, 1061, 1061, 1061, 1061,    0, 1055, 1053,
			 1055,    0, 1051, 1057,    0, 1057, 1053,    0, 1053,    0,
			 1055, 1062, 1062, 1062, 1062, 1057, 1066, 1065, 1053, 1058,
			 1064, 1065, 1064, 1066, 1068, 1066, 1068, 1070, 1072, 1070,
			 1072,    0, 1064, 1061,    0, 1066, 1068,    0,    0, 1070,
			 1072, 1073, 1073, 1073, 1073,    0,    0,    0, 1066,    0,
			    0, 1062, 1064,    0, 1064, 1066, 1068, 1066, 1068, 1070,
			 1072, 1070, 1072, 1075, 1064, 1075,    0, 1066, 1068,    0,
			    0, 1070, 1072,    0,    0, 1075,    0,    0,    0,    0,
			    0, 1073, 1091, 1091, 1091, 1091, 1091, 1091, 1091, 1091,

			 1091, 1091, 1091, 1091, 1091, 1075,    0, 1075,    0,    0,
			    0,    0,    0,    0,    0,    0,    0, 1075, 1077, 1077,
			 1077, 1077, 1077, 1077, 1077, 1077, 1077, 1077, 1077, 1077,
			 1077, 1077, 1077, 1077, 1077, 1077, 1077, 1077, 1077, 1077,
			 1077, 1078, 1078,    0, 1078, 1078, 1078, 1078, 1078, 1078,
			 1078, 1078, 1078, 1078, 1078, 1078, 1078, 1078, 1078, 1078,
			 1078, 1078, 1078, 1078, 1079,    0,    0,    0,    0,    0,
			    0, 1079, 1079, 1079, 1079, 1079, 1079, 1079, 1079, 1079,
			 1079, 1079, 1079, 1079, 1079, 1079, 1079, 1080, 1080,    0,
			 1080, 1080, 1080, 1080, 1080, 1080, 1080, 1080, 1080, 1080,

			 1080, 1080, 1080, 1080, 1080, 1080, 1080, 1080, 1080, 1080,
			 1081, 1081,    0, 1081, 1081, 1081, 1081,    0, 1081, 1081,
			 1081, 1081, 1081, 1081, 1081, 1081, 1081, 1081, 1081, 1081,
			 1081, 1081, 1081, 1082, 1082, 1082, 1082, 1082, 1082, 1082,
			 1082, 1082, 1082, 1082, 1082, 1082, 1082, 1083, 1083,    0,
			 1083, 1083, 1083,    0,    0, 1083, 1083, 1083, 1083, 1083,
			 1083, 1083, 1083, 1083, 1083, 1083, 1083, 1083, 1083, 1083,
			 1084, 1084, 1084, 1084, 1084, 1084, 1084, 1084, 1084, 1084,
			 1084, 1084, 1084, 1084, 1085,    0,    0, 1085,    0, 1085,
			 1085, 1085, 1085, 1085, 1085, 1085, 1085, 1085, 1085, 1085,

			 1085, 1085, 1085, 1085, 1085, 1085, 1085, 1086, 1086,    0,
			 1086, 1086, 1086, 1086, 1086, 1086, 1086, 1086, 1086, 1086,
			 1086, 1086, 1086, 1086, 1086, 1086, 1086, 1086, 1086, 1086,
			 1087, 1087,    0, 1087, 1087, 1087, 1087, 1087, 1087, 1087,
			 1087, 1087, 1087, 1087, 1087, 1087, 1087, 1087, 1087, 1087,
			 1087, 1087, 1087, 1088, 1088,    0, 1088, 1088, 1088, 1088,
			 1088, 1088, 1088, 1088, 1088, 1088, 1088, 1088, 1088, 1088,
			 1088, 1088, 1088, 1088, 1088, 1088, 1089,    0,    0,    0,
			    0, 1089, 1089, 1089, 1089, 1089, 1089, 1089, 1089, 1089,
			 1089, 1089, 1089, 1089, 1089, 1089, 1089, 1089, 1089, 1090,

			 1090, 1090, 1090, 1090, 1090, 1090, 1090,    0, 1090, 1090,
			 1090, 1090, 1090, 1090, 1090, 1090, 1090, 1090, 1090, 1090,
			 1090, 1090, 1092, 1092, 1092, 1092, 1092, 1092, 1092, 1092,
			 1092, 1092, 1092, 1092, 1092, 1093, 1093, 1093, 1093, 1093,
			 1093, 1093, 1093, 1093, 1093, 1093, 1093, 1093, 1094, 1094,
			    0, 1094, 1094, 1094,    0, 1094, 1094, 1094, 1094, 1094,
			 1094, 1094, 1094, 1094, 1094, 1094, 1094, 1094, 1094, 1094,
			 1094, 1095, 1095,    0, 1095, 1095, 1095,    0, 1095, 1095,
			 1095, 1095, 1095, 1095, 1095, 1095, 1095, 1095, 1095, 1095,
			 1095, 1095, 1095, 1095, 1096, 1096, 1096, 1096, 1096, 1096,

			 1096, 1096,    0, 1096, 1096, 1096, 1096, 1096, 1096, 1096,
			 1096, 1096, 1096, 1096, 1096, 1096, 1096, 1076, 1076, 1076,
			 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076,
			 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076,
			 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076,
			 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076,
			 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076,
			 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076,
			 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076,
			 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, yy_Dummy>>,
			1, 1000, 7000)
		end

	yy_chk_template_9 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076,
			 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, yy_Dummy>>,
			1, 18, 8000)
		end

	yy_base_template: SPECIAL [INTEGER]
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make (0, 1096)
			yy_base_template_1 (an_array)
			yy_base_template_2 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_base_template_1 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			    0,    0,    0,   99,  111,  771, 7917,  755,  751,  701,
			  697,  695,  124,    0, 7917,  131,  138, 7917, 7917, 7917,
			 7917, 7917,   89,   87,   92,  221,  102,  129,  672, 7917,
			  100, 7917,  101,  664,  287,  218,  351,  101,  117,  217,
			   74,  361,  115,  202,  359,  134,   98,  224,  233,  222,
			  375,  146,  219, 7917,  629, 7917, 7917,  358,  427,  434,
			  498,  416,  506,  577,  421,  573,  500,  569,  588,  424,
			  623,  631,  640,  647,  680,  693,  685, 7917, 7917, 7917,
			   82,  532,  184,   87,  222,  252,  518,  389,  389,  596,
			  690,  735,  742,  762,  466,  701,  711,  721,  734,  752,

			  772,  587,  517,  486,  475, 7917,  866, 7917,  960,  924,
			  937,  974,  989, 1007, 1034, 1054, 1068, 1084,    0, 1019,
			 1101, 1113, 1128, 1148, 1163, 1178, 1195,  803,  412, 1289,
			 1253,  811, 1268, 1299, 1312, 1322, 1332, 7917, 7917, 7917,
			  857, 7917, 7917, 7917,  648,  864,  357,  103,  419,  497,
			 1413,  898,  143, 7917, 7917, 7917, 7917, 7917, 7917,  116,
			  499,  376,  428,  378,  502,  579,  840, 1408,  902, 1399,
			 1417, 1448, 1413,  463,  325,  495,  157,  541,  545,  324,
			  908, 1454,  589,  673,  707,  693, 1461, 1471, 1479, 1463,
			 1508, 1512, 1531,  231, 1547, 1472,  703, 1538, 1557, 1536,

			 1582, 1588,  912, 1488,  514, 1583, 1623, 1599,  278, 1099,
			 1644,  338, 1637, 1646, 1699, 1664, 1009, 1575, 1685, 1712,
			 1648, 1718, 1703, 1534, 1716,  374, 1753, 1757, 1770, 1764,
			 1215, 1778, 1819, 1868, 1835, 1242, 1757, 1877, 1817, 1840,
			 1780,  411, 1904, 1886, 1791, 1931, 1828,  435, 1935, 1922,
			 1840, 1968, 1920, 1940, 7917, 1276, 1933, 1962, 1974, 1987,
			 2006, 2024, 2034,  683,  314,  762,  334,  797,  947,  220,
			  959,  974, 1098, 1101, 1123, 1138, 1138, 1952, 1995, 2044,
			 2054, 2064, 2074, 2084, 1644, 2183, 2100, 2107,  242, 2187,
			 2206, 2213, 2230, 2130, 2237, 2246, 2256, 2268, 2287, 2313,

			 2367, 2230, 2386, 2412, 2422, 2432, 2442, 2466, 2485, 2303,
			 2402, 2449, 2456, 2495, 2505, 2560, 2567, 2599, 2606, 2613,
			 2623, 2631, 2641, 2661, 2671, 2681, 2735, 2780, 2793, 2806,
			 2830, 2843, 2856, 2901, 2925, 2875, 2888, 2909, 2938, 2951,
			 2969, 2979, 7917, 2991, 2999, 3015, 3028, 3041, 3059, 3069,
			 3048, 3089,  206, 3105, 3118, 3150, 3138, 3163, 3170, 3179,
			 3186, 3195, 3208, 3215, 3228, 3240, 3260, 3276, 3285, 3305,
			 3318, 3330, 3340, 3350, 3366, 3376, 3386, 3396, 2785, 2433,
			 1245, 7917, 2849, 2622, 3479, 2654,  286,  658,  154, 2016,
			  141, 3523,  116, 2726, 2800, 1771, 2771, 1645, 2893, 1956,

			  498, 3168, 3167,  513, 3277,  647, 3465, 3489, 3519, 1159,
			 1212, 1236, 1263, 1286, 1289,  753, 3488, 2408, 3550, 1886,
			 3526, 1522, 3554, 2184, 3578, 2570, 3569, 2407, 2199, 2229,
			 3583, 3604, 3619, 2580, 3618,  826, 2814, 3623, 3632, 3657,
			 3157, 3656, 3672, 2390, 3687, 3283, 3693, 3478, 3708, 1705,
			 3637, 3158,  899, 3385, 3460, 3686, 3736, 3747, 3753, 3760,
			 3786, 3562, 3800, 3714, 3532, 3801, 3815, 3705, 3836, 2577,
			 3840,  913, 3853, 3770, 3864, 3897, 3869, 3780, 3853, 3785,
			 3328, 3902, 3880, 3912, 3917, 3933, 3938, 3957, 3962, 3907,
			 3963, 3983, 3997, 3978, 4011,  978, 4022, 2351, 4014, 4028,

			 4035, 4045, 4015, 1042, 4071, 4063, 4080, 1071, 4087, 3688,
			 4086, 3716, 4111, 1101, 4125, 7917, 4120, 4131, 4138, 4147,
			 4158, 4168, 1309, 1372, 1931, 2017, 2020, 2480, 2519, 2543,
			 7917, 3248, 4095, 4178, 4190, 4200, 4214, 4232, 7917, 3294,
			 4241, 4272, 4294, 4308, 4318, 4335, 4342, 4349, 4371, 4417,
			 4448, 4470, 4477, 4484, 4491, 4498, 4516, 4526, 4222, 4455,
			 4549, 4592, 4631, 4622, 4649, 4656, 4663, 4670, 4686, 4696,
			 4764, 4790, 4727, 4797, 4804, 4817, 4824, 4831, 4842, 4854,
			 7917, 7917, 7917, 7917, 7917, 4944, 7917, 7917, 7917, 7917,
			 7917, 7917, 7917, 7917, 7917, 7917, 7917, 7917, 7917, 7917,

			 7917, 7917, 4894, 4921, 4809, 2662, 2900, 2771, 4816, 3492,
			 2942, 3007, 3061, 4679, 4439,  854,  106, 2837,   96,    0,
			   86, 4788, 4796, 4033, 4302, 4132, 4587, 4052, 4449, 2773,
			 4992, 3760, 1148, 4993, 5009, 2962, 2965, 3293, 5008, 4097,
			 5044, 4142, 5055, 4425, 5058, 4567, 5061, 3384, 5069, 4802,
			 5104, 4643, 5109, 1244, 5115, 4930, 5118, 3905, 4931, 5123,
			 5158, 4932, 5163, 4601, 5179, 4763, 5171, 1271, 4645, 5166,
			 5206, 1287, 5217, 1415, 5220, 1692, 5224, 4984, 5233, 4670,
			 5241, 4985, 5257, 1354, 5260, 3958, 5274, 1387, 5278, 1401,
			 5281, 4836, 5297, 1473, 5305, 5021, 1633, 5314, 5330, 4936,

			 5351, 5148, 5338, 4809, 5366, 1778, 5384, 5036, 4934, 5392,
			 5391, 2405, 5407, 5117, 5415, 5187, 5442, 1826, 5443, 4796,
			 5456, 1885, 5461, 2026, 5467, 4938, 5470, 5050, 5506, 4957,
			 5507, 5258, 5521, 2139, 5520, 2179, 5524, 5519, 5527, 3010,
			 3084, 5537, 5546, 5559, 5568, 5578, 5591, 5600, 5613, 5621,
			 5631, 5641, 5653, 5752, 5759, 5766, 5773, 5780, 5787, 5797,
			 5731, 5744, 5804, 5354, 4936, 3277, 3501, 5885, 4183, 5548,
			 4375, 5683, 4960, 5889, 5904, 4440, 5736, 2198, 5875, 2226,
			 5888, 3976, 5893, 5360, 5896, 5383, 5899, 2252, 5934, 2300,
			 5939, 5314, 5942, 5437, 5960, 5743, 5947, 2320, 5963, 5744,

			 5996, 5488, 5988, 5100, 5999, 5722, 6012, 5921, 6017, 4988,
			 6045, 6021, 6036, 2455, 6052, 5897, 6060, 6061, 6069, 6081,
			 6100, 2537, 6114, 2713, 6097, 2758, 6118, 5417, 6133, 2772,
			 6157, 2879, 6105, 6094, 6168, 5900, 6172, 3727, 6151, 2921,
			 6197, 6167, 6205, 6218, 6220, 6217, 6236, 6228, 6263, 5725,
			 6259, 2942, 6260, 6179, 6277, 6038, 6284, 3002, 6298, 3092,
			 6322, 6315, 6313, 3155, 6327, 6329, 6341, 6324, 6335, 6348,
			 6357, 6386, 7917, 6443, 6416, 5580, 3791, 6467, 6447, 5629,
			 5812, 6451, 6388, 6476, 6482, 3184, 6465, 3218, 6469, 6475,
			 6483, 5110, 6478, 6476, 6486, 3279, 5534, 6521, 6529, 6485,

			 6534, 6531, 6545, 6546, 6550, 3383, 6581, 3494, 6585, 6547,
			 6598, 3580, 6590, 6591, 6606, 6606, 6614, 3650, 6609, 6237,
			 6645, 6477, 6649, 6636, 6654, 6662, 6695, 6607, 6678, 6677,
			 6711, 6379, 6714, 3685, 6718, 6658, 6732, 6667, 6747, 3699,
			 6761, 6675, 6772, 3827, 6768, 3829, 6775, 3844, 6786, 6763,
			 6813, 6788, 6799, 3886, 6824, 6826, 6827, 6869, 6883, 6893,
			 6902, 6911, 6915, 6919, 4314, 6923, 6927, 6931, 7917, 6935,
			 6944, 6935, 6929, 6922, 6935, 3924, 6936, 6942, 6940, 4105,
			 6981, 6953, 6986, 5400, 6995, 6995, 6999, 6708, 6994, 4382,
			 7000, 4413, 7035, 6813, 7046, 4487, 7040, 4604, 7049, 7048, yy_Dummy>>,
			1, 1000, 0)
		end

	yy_base_template_2 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 7053, 7063, 7064, 7065, 7099, 7066, 7110, 7116, 7114, 4644,
			 7115, 7126, 7128, 7127, 7164, 4671, 7161,   77, 6976, 7188,
			 7198, 7202, 7206, 7230,   70, 7220, 7235, 7239, 4735, 7222,
			 7230, 7235, 4774, 7229, 4959, 7230, 7109, 7236, 4986, 7275,
			 5192, 7276, 5273, 7281, 7274, 7284, 5299, 7289, 6831, 7300,
			 5424, 7327, 7297, 7343, 5484, 7335, 5591, 7340, 7369,   58,
			 7270, 7383, 7401, 5609, 7389, 7361, 7392, 5654, 7393, 5747,
			 7396, 5767, 7397, 7431, 5850, 7432, 7917, 7517, 7540, 7563,
			 7586, 7609, 7624, 7646, 7660, 7683, 7706, 7729, 7752, 7775,
			 7798, 7482, 7812, 7825, 7847, 7870, 7893, yy_Dummy>>,
			1, 97, 1000)
		end

	yy_def_template: SPECIAL [INTEGER]
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make (0, 1096)
			yy_def_template_1 (an_array)
			yy_def_template_2 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_def_template_1 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			    0, 1076,    1, 1077, 1077, 1076, 1076, 1076, 1076, 1076,
			 1076, 1076, 1078, 1079, 1076, 1080, 1081, 1076, 1076, 1076,
			 1076, 1076, 1076, 1076, 1076, 1082, 1082, 1082, 1076, 1076,
			 1076, 1076, 1076, 1076, 1076,   34,   35,   35,   35,   35,
			   35,   35,   35,   35,   35,   35,   35,   35,   35,   35,
			   35,   35,   35, 1076, 1076, 1076, 1076, 1083, 1084, 1084,
			 1084, 1084, 1084,   62,   62,   62,   62,   62,   62,   62,
			   62,   62,   62,   62,   62,   62,   62, 1076, 1076, 1076,
			 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1085, 1076, 1076,
			 1085, 1076, 1086, 1087, 1085, 1085, 1085, 1085, 1085, 1085,

			 1085, 1076, 1076, 1076, 1076, 1076, 1078, 1076, 1088, 1078,
			 1078, 1078, 1078, 1078, 1078, 1078, 1078, 1078, 1079, 1080,
			 1080, 1080, 1080, 1080, 1080, 1080, 1080, 1089, 1076, 1089,
			 1089, 1089, 1089, 1089, 1089, 1089, 1089, 1076, 1076, 1076,
			 1076, 1076, 1076, 1076, 1090, 1082, 1082, 1082, 1091, 1092,
			 1093, 1082, 1082, 1076, 1076, 1076, 1076, 1076, 1076,   35,
			   35,   35,   35,   35,   35,   35,   62,   62,   62,   62,
			   62,   62,   62, 1076, 1076, 1076, 1076, 1076, 1076, 1076,
			   35,   62,   35,   35,   35,   35,   35,   62,   62,   62,
			   62,   62,   35,   35,   62,   62,   35,   35,   35,   62,

			   62,   62,   35,   35,   35,   62,   62,   62,   35,   35,
			   35,   35,   62,   62,   62,   62,   35,   35,   62,   62,
			   35,   62,   35,   35,   35,   35,   62,   62,   62,   62,
			   35,   62,   35,   62,   35,   35,   35,   62,   62,   62,
			   35,   35,   62,   62,   35,   62,   35,   35,   62,   62,
			   35,   62,   35,   62, 1076, 1083, 1083, 1083, 1083, 1083,
			 1083, 1083, 1083, 1076, 1076, 1076, 1076, 1076, 1076, 1076,
			 1076, 1076, 1076, 1076, 1076, 1076, 1085, 1085, 1085, 1085,
			 1085, 1085, 1085, 1085, 1076, 1076, 1094, 1095, 1076, 1085,
			 1086, 1087, 1076, 1085, 1086, 1086, 1086, 1086, 1086, 1086,

			 1086, 1085, 1087, 1087, 1087, 1087, 1087, 1087, 1087, 1085,
			 1085, 1085, 1085, 1085, 1085, 1088, 1080, 1080, 1088, 1088,
			 1088, 1088, 1088, 1088, 1088, 1088, 1088, 1078, 1078, 1078,
			 1078, 1078, 1078, 1078, 1078, 1080, 1080, 1080, 1080, 1080,
			 1080, 1089, 1076, 1089, 1089, 1089, 1089, 1089, 1089, 1089,
			 1089, 1089, 1076, 1089, 1089, 1089, 1089, 1089, 1089, 1089,
			 1089, 1089, 1089, 1089, 1089, 1089, 1089, 1089, 1089, 1089,
			 1089, 1089, 1089, 1089, 1089, 1089, 1089, 1089, 1076, 1076,
			 1076, 1076, 1076, 1076, 1082, 1082, 1082, 1091, 1091, 1092,
			 1092, 1093, 1093, 1082, 1082,   35,   62,   35,   62,   35,

			   35,   62,   62,   35,   62,   35,   62,   35,   62, 1076,
			 1076, 1076, 1076, 1076, 1076,   35,   62,   35,   62,   35,
			   62,   35,   62,   35,   62,   35,   62,   35,   35,   35,
			   62,   62,   62,   35,   62,   35,   35,   62,   62,   35,
			   35,   62,   62,   35,   62,   35,   62,   35,   62,   35,
			   62,   35,   35,   35,   35,   35,   62,   62,   62,   62,
			   62,   35,   62,   35,   35,   62,   62,   35,   62,   35,
			   62,   35,   62,   35,   62,   35,   62,   35,   35,   35,
			   35,   35,   35,   62,   62,   62,   62,   62,   62,   35,
			   35,   62,   62,   35,   62,   35,   62,   35,   62,   35,

			   62,   35,   35,   35,   62,   62,   62,   35,   62,   35,
			   62,   35,   62,   35,   62, 1076, 1083, 1083, 1083, 1083,
			 1083, 1083, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076,
			 1076, 1094, 1094, 1094, 1094, 1094, 1094, 1094, 1076, 1095,
			 1095, 1095, 1095, 1095, 1095, 1095, 1086, 1086, 1086, 1086,
			 1086, 1086, 1087, 1087, 1087, 1087, 1087, 1087, 1085, 1085,
			 1088, 1088, 1088, 1088, 1088, 1088, 1088, 1088, 1088, 1088,
			 1078, 1078, 1080, 1080, 1089, 1089, 1089, 1089, 1089, 1089,
			 1076, 1076, 1076, 1076, 1076, 1089, 1076, 1076, 1076, 1076,
			 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076,

			 1076, 1076, 1089, 1089, 1076, 1076, 1076, 1076, 1076, 1076,
			 1076, 1076, 1076, 1082, 1082, 1091, 1091, 1092, 1092,  391,
			 1093, 1082, 1082,   35,   62,   35,   62,   35,   62,   35,
			   62,   35,   35,   62,   62, 1076, 1076,   35,   62,   35,
			   62,   35,   62,   35,   62,   35,   62,   35,   62,   35,
			   62,   35,   62,   35,   62,   35,   62,   35,   35,   62,
			   62,   35,   62,   35,   62,   35,   62,   35,   35,   62,
			   62,   35,   62,   35,   62,   35,   62,   35,   62,   35,
			   62,   35,   62,   35,   62,   35,   62,   35,   62,   35,
			   62,   35,   62,   35,   62,   35,   35,   62,   62,   35,

			   62,   35,   62,   35,   62,   35,   62,   35,   35,   62,
			   62,   35,   62,   35,   62,   35,   62,   35,   62,   35,
			   62,   35,   62,   35,   62,   35,   62,   35,   62,   35,
			   62,   35,   62,   35,   62,   35,   62, 1083, 1083, 1076,
			 1076, 1094, 1094, 1094, 1094, 1094, 1094, 1095, 1095, 1095,
			 1095, 1095, 1095, 1086, 1086, 1087, 1087, 1088, 1088, 1088,
			 1089, 1089, 1089, 1076, 1076, 1076, 1076, 1076, 1076, 1076,
			 1076, 1076, 1076, 1090, 1082,   35,   62,   35,   62,   35,
			   62,   35,   62,   35,   62,   35,   62,   35,   62,   35,
			   62,   35,   62,   35,   62,   35,   62,   35,   62,   35,

			   62,   35,   62,   35,   62,   35,   62,   35,   62,   35,
			   62,   35,   62,   35,   62,   35,   62,   35,   62,   35,
			   62,   35,   62,   35,   62,   35,   62,   35,   62,   35,
			   62,   35,   62,   35,   62,   35,   62,   35,   62,   35,
			   62,   35,   62,   35,   62,   35,   62,   35,   62,   35,
			   62,   35,   62,   35,   62,   35,   62,   35,   62,   35,
			   62,   35,   62,   35,   62,   35,   62, 1094, 1094, 1095,
			 1095, 1088, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076,
			 1076, 1076, 1076, 1076, 1096,   35,   62,   35,   62,   35,
			   62,   35,   62,   35,   62,   35,   35,   62,   62,   35,

			   62,   35,   62,   35,   62,   35,   62,   35,   62,   35,
			   62,   35,   62,   35,   62,   35,   62,   35,   62,   35,
			   62,   35,   62,   35,   62,   35,   62,   35,   62,   35,
			   62,   35,   62,   35,   62,   35,   62,   35,   62,   35,
			   62,   35,   62,   35,   62,   35,   62,   35,   62,   35,
			   62,   35,   62,   35,   62,   35,   62, 1076, 1076, 1076,
			 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076,
			 1076,   35,   62,   35,   62,   35,   62,   35,   62,   35,
			   62,   35,   62,   35,   62,   35,   62,   35,   62,   35,
			   62,   35,   62,   35,   62,   35,   62,   35,   62,   35, yy_Dummy>>,
			1, 1000, 0)
		end

	yy_def_template_2 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			   62,   35,   62,   35,   62,   35,   62,   35,   62,   35,
			   62,   35,   62,   35,   62,   35,   62, 1076, 1076, 1076,
			 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076,   35,   62,
			   35,   62,   35,   62,   35,   62,   35,   62,   35,   62,
			   35,   62,   35,   62,   35,   62,   35,   62,   35,   62,
			   35,   62,   35,   62,   35,   62,   35,   62, 1076, 1076,
			 1076, 1076, 1076,   35,   62,   35,   62,   35,   62,   35,
			   62,   35,   62, 1076,   35,   62,    0, 1076, 1076, 1076,
			 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076,
			 1076, 1076, 1076, 1076, 1076, 1076, 1076, yy_Dummy>>,
			1, 97, 1000)
		end

	yy_ec_template: SPECIAL [INTEGER]
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
			   85,   86,   87,   88,    8,   89,   90,    1,   91,   91,
			   91,   91,   91,   91,   91,   91,   91,   91,   91,   91,
			   91,   91,   91,   91,   92,   92,   92,   92,   92,   92,
			   92,   92,   92,   92,   92,   92,   92,   92,   92,   92,
			   93,   93,   93,   93,   93,   93,   93,   93,   93,   93,
			   93,   93,   93,   93,   93,   93,   93,   93,   93,   93,
			   93,   93,   93,   93,   93,   93,   93,   93,   93,   93,
			   93,   93,    1,    1,   94,   94,   94,   94,   94,   94,

			   94,   94,   94,   94,   94,   94,   94,   94,   94,   94,
			   94,   94,   94,   94,   94,   94,   94,   94,   94,   94,
			   94,   94,   94,   94,   95,   96,   96,   96,   96,   96,
			   96,   96,   96,   96,   96,   96,   96,   97,   98,   98,
			    1,   99,   99,   99,  100,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1, yy_Dummy>>)
		end

	yy_meta_template: SPECIAL [INTEGER]
		once
			Result := yy_fixed_array (<<
			    0,    1,    2,    3,    4,    5,    1,    6,    1,    1,
			    7,    8,    1,    1,    1,    1,    1,    1,    9,    1,
			   10,   11,   12,   13,    1,    1,    1,    1,    1,    1,
			   10,   10,   10,   10,   10,   10,   10,   10,   10,   10,
			   10,   10,   10,   10,   10,   10,   10,   10,   10,   10,
			   10,   10,   14,   15,   16,   17,    1,    1,    1,    1,
			   18,    1,   10,   10,   10,   10,   10,   10,   10,   10,
			   10,   10,   10,   10,   10,   10,   10,   10,   10,   10,
			   10,   10,   10,   10,   19,   20,   21,   22,    1,    1,
			    1,    1,    1,    1,   23,   23,   23,   23,   23,   23,

			   23, yy_Dummy>>)
		end

	yy_accept_template: SPECIAL [INTEGER]
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make (0, 1077)
			yy_accept_template_1 (an_array)
			yy_accept_template_2 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_accept_template_1 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			    0,    1,    1,    1,    2,    3,    4,    6,    9,   11,
			   14,   17,   20,   23,   26,   29,   32,   34,   37,   40,
			   43,   46,   49,   52,   55,   58,   62,   66,   70,   73,
			   76,   79,   82,   85,   87,   91,   95,   99,  103,  107,
			  111,  115,  119,  123,  127,  131,  135,  139,  143,  147,
			  151,  155,  159,  163,  166,  168,  171,  174,  176,  179,
			  182,  185,  188,  191,  194,  197,  200,  203,  206,  209,
			  212,  215,  218,  221,  224,  227,  230,  233,  236,  239,
			  242,  244,  246,  248,  250,  252,  254,  256,  258,  260,
			  262,  265,  267,  269,  271,  273,  275,  277,  279,  281,

			  283,  285,  286,  287,  288,  289,  290,  291,  292,  293,
			  296,  299,  300,  301,  302,  303,  304,  305,  306,  307,
			  308,  309,  310,  311,  312,  313,  314,  315,  316,  316,
			  317,  318,  319,  320,  321,  322,  323,  324,  325,  326,
			  327,  329,  330,  331,  332,  332,  334,  336,  337,  339,
			  340,  341,  341,  343,  344,  345,  346,  347,  348,  349,
			  351,  353,  355,  357,  359,  362,  364,  365,  366,  367,
			  368,  369,  371,  372,  372,  372,  372,  372,  372,  372,
			  372,  374,  375,  377,  379,  381,  383,  385,  386,  387,
			  388,  389,  390,  392,  395,  396,  398,  400,  402,  404,

			  405,  406,  407,  409,  411,  413,  414,  415,  416,  419,
			  421,  423,  426,  428,  429,  430,  432,  434,  436,  437,
			  438,  440,  441,  443,  445,  447,  450,  451,  452,  453,
			  455,  457,  458,  460,  461,  463,  465,  467,  468,  469,
			  470,  472,  474,  475,  476,  478,  479,  481,  483,  484,
			  485,  487,  488,  490,  491,  492,  492,  492,  492,  492,
			  492,  492,  492,  492,  492,  492,  492,  492,  492,  492,
			  492,  492,  492,  492,  492,  492,  492,  493,  494,  495,
			  496,  497,  498,  499,  500,  501,  501,  501,  501,  502,
			  504,  505,  506,  507,  509,  510,  511,  512,  513,  514,

			  515,  516,  518,  519,  520,  521,  522,  523,  524,  525,
			  526,  527,  528,  529,  530,  531,  531,  533,  535,  535,
			  535,  535,  535,  535,  535,  535,  535,  535,  537,  539,
			  540,  541,  542,  543,  544,  545,  546,  547,  548,  549,
			  550,  551,  552,  553,  554,  555,  556,  557,  558,  559,
			  560,  561,  562,  562,  563,  564,  565,  566,  567,  568,
			  569,  570,  571,  572,  573,  574,  575,  576,  577,  578,
			  579,  580,  581,  582,  583,  584,  585,  586,  587,  589,
			  589,  589,  590,  592,  593,  595,  597,  597,  600,  602,
			  605,  607,  610,  612,  614,  614,  616,  617,  619,  620,

			  622,  625,  626,  628,  631,  633,  635,  636,  638,  639,
			  639,  639,  639,  639,  639,  639,  642,  644,  646,  647,
			  649,  650,  652,  653,  655,  656,  658,  659,  661,  663,
			  665,  666,  667,  668,  670,  671,  674,  676,  678,  679,
			  681,  683,  684,  685,  687,  688,  690,  691,  693,  694,
			  696,  697,  699,  701,  703,  705,  707,  708,  709,  710,
			  711,  712,  714,  715,  717,  719,  720,  721,  724,  726,
			  728,  729,  732,  734,  736,  737,  739,  740,  742,  744,
			  746,  748,  750,  752,  753,  754,  755,  756,  757,  758,
			  760,  762,  763,  764,  766,  767,  769,  770,  772,  773,

			  775,  776,  778,  780,  782,  783,  784,  785,  787,  788,
			  790,  791,  793,  794,  797,  799,  800,  800,  800,  800,
			  800,  800,  800,  800,  800,  800,  800,  800,  800,  800,
			  800,  801,  801,  801,  801,  801,  801,  801,  801,  802,
			  802,  802,  802,  802,  802,  802,  802,  803,  804,  805,
			  806,  807,  808,  809,  810,  811,  812,  813,  814,  815,
			  816,  817,  818,  818,  819,  819,  819,  819,  819,  819,
			  819,  820,  821,  822,  823,  824,  825,  826,  827,  828,
			  829,  830,  831,  832,  833,  834,  835,  836,  837,  838,
			  839,  840,  841,  842,  843,  844,  845,  846,  847,  848,

			  849,  850,  851,  852,  853,  855,  855,  857,  857,  859,
			  859,  859,  859,  861,  863,  865,  865,  865,  865,  865,
			  865,  865,  867,  869,  871,  872,  874,  875,  877,  878,
			  880,  881,  883,  885,  886,  887,  887,  887,  889,  890,
			  892,  893,  895,  896,  898,  899,  901,  902,  904,  905,
			  907,  908,  910,  911,  914,  916,  918,  919,  921,  923,
			  924,  925,  927,  928,  930,  931,  933,  934,  937,  939,
			  941,  942,  944,  945,  947,  948,  950,  951,  953,  954,
			  956,  957,  959,  960,  963,  965,  967,  968,  971,  973,
			  976,  978,  980,  981,  984,  986,  988,  990,  991,  992,

			  994,  995,  997,  998, 1000, 1001, 1003, 1004, 1006, 1008,
			 1009, 1010, 1012, 1013, 1015, 1016, 1018, 1019, 1022, 1024,
			 1026, 1027, 1030, 1032, 1035, 1037, 1039, 1040, 1042, 1043,
			 1045, 1046, 1048, 1049, 1052, 1054, 1057, 1059, 1059, 1059,
			 1059, 1059, 1059, 1059, 1059, 1059, 1059, 1059, 1059, 1059,
			 1059, 1059, 1059, 1059, 1060, 1061, 1062, 1063, 1063, 1063,
			 1063, 1064, 1065, 1066, 1067, 1069, 1069, 1069, 1071, 1071,
			 1075, 1075, 1077, 1077, 1077, 1079, 1081, 1082, 1085, 1087,
			 1090, 1092, 1094, 1095, 1097, 1098, 1100, 1101, 1104, 1106,
			 1109, 1111, 1113, 1114, 1116, 1117, 1119, 1120, 1123, 1125,

			 1127, 1128, 1130, 1131, 1133, 1134, 1136, 1137, 1139, 1140,
			 1142, 1143, 1145, 1146, 1149, 1151, 1153, 1154, 1156, 1157,
			 1159, 1160, 1162, 1163, 1166, 1168, 1170, 1171, 1173, 1174,
			 1176, 1177, 1180, 1182, 1184, 1185, 1187, 1188, 1190, 1191,
			 1193, 1194, 1196, 1197, 1199, 1200, 1202, 1203, 1205, 1206,
			 1208, 1209, 1212, 1214, 1216, 1217, 1219, 1220, 1223, 1225,
			 1227, 1228, 1230, 1231, 1234, 1236, 1238, 1239, 1239, 1239,
			 1239, 1239, 1239, 1240, 1240, 1242, 1242, 1243, 1244, 1248,
			 1248, 1248, 1250, 1250, 1251, 1251, 1254, 1256, 1259, 1261,
			 1263, 1264, 1266, 1267, 1269, 1270, 1273, 1275, 1277, 1278,

			 1280, 1281, 1283, 1284, 1286, 1287, 1290, 1292, 1295, 1297,
			 1299, 1300, 1303, 1305, 1307, 1308, 1310, 1311, 1314, 1316,
			 1318, 1319, 1321, 1322, 1324, 1325, 1327, 1328, 1330, 1331,
			 1333, 1334, 1336, 1337, 1340, 1342, 1344, 1345, 1347, 1348,
			 1351, 1353, 1355, 1356, 1359, 1361, 1364, 1366, 1369, 1371,
			 1373, 1374, 1376, 1377, 1380, 1382, 1384, 1385, 1385, 1386,
			 1386, 1386, 1386, 1390, 1390, 1391, 1392, 1392, 1392, 1393,
			 1394, 1395, 1397, 1398, 1400, 1401, 1404, 1406, 1408, 1409,
			 1412, 1414, 1416, 1417, 1419, 1420, 1422, 1423, 1425, 1426,
			 1429, 1431, 1434, 1436, 1438, 1439, 1442, 1444, 1447, 1449, yy_Dummy>>,
			1, 1000, 0)
		end

	yy_accept_template_2 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 1451, 1452, 1454, 1455, 1457, 1458, 1460, 1461, 1463, 1464,
			 1467, 1469, 1471, 1472, 1474, 1475, 1478, 1480, 1481, 1481,
			 1482, 1482, 1484, 1484, 1484, 1485, 1486, 1486, 1487, 1490,
			 1492, 1494, 1495, 1498, 1500, 1503, 1505, 1507, 1508, 1511,
			 1513, 1516, 1518, 1521, 1523, 1525, 1526, 1529, 1531, 1533,
			 1534, 1537, 1539, 1541, 1542, 1545, 1547, 1550, 1552, 1553,
			 1555, 1555, 1557, 1558, 1561, 1563, 1565, 1566, 1569, 1571,
			 1574, 1576, 1579, 1581, 1583, 1586, 1588, 1588, yy_Dummy>>,
			1, 78, 1000)
		end

	yy_acclist_template: SPECIAL [INTEGER]
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make (0, 1587)
			yy_acclist_template_1 (an_array)
			yy_acclist_template_2 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_acclist_template_1 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			    0,  145,  145,  166,  164,  165,    3,  164,  165,    4,
			  165,    1,  164,  165,    2,  164,  165,   10,  164,  165,
			  147,  164,  165,  112,  164,  165,   17,  164,  165,  147,
			  164,  165,  164,  165,   11,  164,  165,   12,  164,  165,
			   32,  164,  165,   31,  164,  165,    8,  164,  165,   30,
			  164,  165,    6,  164,  165,   33,  164,  165,  149,  156,
			  164,  165,  149,  156,  164,  165,  149,  156,  164,  165,
			    9,  164,  165,    7,  164,  165,   37,  164,  165,   35,
			  164,  165,   36,  164,  165,  164,  165,  110,  111,  164,
			  165,  110,  111,  164,  165,  110,  111,  164,  165,  110,

			  111,  164,  165,  110,  111,  164,  165,  110,  111,  164,
			  165,  110,  111,  164,  165,  110,  111,  164,  165,  110,
			  111,  164,  165,  110,  111,  164,  165,  110,  111,  164,
			  165,  110,  111,  164,  165,  110,  111,  164,  165,  110,
			  111,  164,  165,  110,  111,  164,  165,  110,  111,  164,
			  165,  110,  111,  164,  165,  110,  111,  164,  165,  110,
			  111,  164,  165,   15,  164,  165,  164,  165,   16,  164,
			  165,   34,  164,  165,  164,  165,  111,  164,  165,  111,
			  164,  165,  111,  164,  165,  111,  164,  165,  111,  164,
			  165,  111,  164,  165,  111,  164,  165,  111,  164,  165,

			  111,  164,  165,  111,  164,  165,  111,  164,  165,  111,
			  164,  165,  111,  164,  165,  111,  164,  165,  111,  164,
			  165,  111,  164,  165,  111,  164,  165,  111,  164,  165,
			  111,  164,  165,   13,  164,  165,   14,  164,  165,   38,
			  164,  165,  164,  165,  164,  165,  164,  165,  164,  165,
			  164,  165,  164,  165,  164,  165,  145,  165,  143,  165,
			  144,  165,  139,  145,  165,  142,  165,  145,  165,  145,
			  165,  145,  165,  145,  165,  145,  165,  145,  165,  145,
			  165,  145,  165,  145,  165,    3,    4,    1,    2,   39,
			  147,  146,  146, -137,  147, -302, -138,  147, -303,  147,

			  147,  147,  147,  147,  147,  147,  112,  147,  147,  147,
			  147,  147,  147,  147,  147,  136,  136,  136,  136,  136,
			  136,  136,  136,  136,    5,   23,   24,  159,  162,   18,
			   20,   29,  149,  156,  149,  156,  156,  148,  156,  156,
			  156,  148,  156,   28,   25,   22,   21,   26,   27,  110,
			  111,  110,  111,  110,  111,  110,  111,  110,  111,   45,
			  110,  111,  110,  111,  111,  111,  111,  111,  111,   45,
			  111,  111,  110,  111,  111,  110,  111,  110,  111,  110,
			  111,  110,  111,  110,  111,  111,  111,  111,  111,  111,
			  110,  111,   56,  110,  111,  111,   56,  111,  110,  111,

			  110,  111,  110,  111,  111,  111,  111,  110,  111,  110,
			  111,  110,  111,  111,  111,  111,   68,  110,  111,  110,
			  111,  110,  111,   74,  110,  111,   68,  111,  111,  111,
			   74,  111,  110,  111,  110,  111,  111,  111,  110,  111,
			  111,  110,  111,  110,  111,  110,  111,   82,  110,  111,
			  111,  111,  111,   82,  111,  110,  111,  111,  110,  111,
			  111,  110,  111,  110,  111,  110,  111,  111,  111,  111,
			  110,  111,  110,  111,  111,  111,  110,  111,  111,  110,
			  111,  110,  111,  111,  111,  110,  111,  111,  110,  111,
			  111,   19,  145,  145,  145,  145,  145,  145,  145,  145,

			  143,  144,  139,  145,  145,  145,  142,  140,  145,  145,
			  145,  145,  145,  145,  145,  145,  141,  145,  145,  145,
			  145,  145,  145,  145,  145,  145,  145,  145,  145,  145,
			  145,  146,  147,  146,  147, -137,  147, -138,  147,  147,
			  147,  147,  147,  147,  147,  147,  147,  147,  147,  147,
			  147,  136,  113,  136,  136,  136,  136,  136,  136,  136,
			  136,  136,  136,  136,  136,  136,  136,  136,  136,  136,
			  136,  136,  136,  136,  136,  136,  136,  136,  136,  136,
			  136,  136,  136,  136,  136,  136,  136,  159,  162,  157,
			  159,  162,  157,  149,  156,  149,  156,  152,  155,  156,

			  155,  156,  151,  154,  156,  154,  156,  150,  153,  156,
			  153,  156,  149,  156,  110,  111,  111,  110,  111,  111,
			  110,  111,   43,  110,  111,  111,   43,  111,   44,  110,
			  111,   44,  111,  110,  111,  111,  110,  111,  111,   47,
			  110,  111,   47,  111,  110,  111,  111,  110,  111,  111,
			  110,  111,  111,  110,  111,  111,  110,  111,  111,  110,
			  111,  110,  111,  110,  111,  111,  111,  111,  110,  111,
			  111,   59,  110,  111,  110,  111,   59,  111,  111,  110,
			  111,  110,  111,  111,  111,  110,  111,  111,  110,  111,
			  111,  110,  111,  111,  110,  111,  111,  110,  111,  110,

			  111,  110,  111,  110,  111,  110,  111,  111,  111,  111,
			  111,  111,  110,  111,  111,  110,  111,  110,  111,  111,
			  111,   78,  110,  111,   78,  111,  110,  111,  111,   80,
			  110,  111,   80,  111,  110,  111,  111,  110,  111,  111,
			  110,  111,  110,  111,  110,  111,  110,  111,  110,  111,
			  110,  111,  111,  111,  111,  111,  111,  111,  110,  111,
			  110,  111,  111,  111,  110,  111,  111,  110,  111,  111,
			  110,  111,  111,  110,  111,  111,  110,  111,  110,  111,
			  110,  111,  111,  111,  111,  110,  111,  111,  110,  111,
			  111,  110,  111,  111,  104,  110,  111,  104,  111,  163,

			  140,  141,  145,  145,  145,  145,  145,  145,  145,  145,
			  145,  145,  145,  145,  145,  145,  146,  146,  146,  147,
			  147,  147,  147,  136,  136,  136,  136,  136,  136,  130,
			  128,  129,  131,  132,  136,  133,  134,  114,  115,  116,
			  117,  118,  119,  120,  121,  122,  123,  124,  125,  126,
			  127,  136,  136,  159,  162,  159,  162,  159,  162,  158,
			  161,  149,  156,  149,  156,  149,  156,  149,  156,  110,
			  111,  111,  110,  111,  111,  110,  111,  111,  110,  111,
			  111,  110,  111,  110,  111,  111,  111,  110,  111,  111,
			  110,  111,  111,  110,  111,  111,  110,  111,  111,  110,

			  111,  111,  110,  111,  111,  110,  111,  111,  110,  111,
			  111,   57,  110,  111,   57,  111,  110,  111,  111,  110,
			  111,  110,  111,  111,  111,  110,  111,  111,  110,  111,
			  111,  110,  111,  111,   66,  110,  111,  110,  111,   66,
			  111,  111,  110,  111,  111,  110,  111,  111,  110,  111,
			  111,  110,  111,  111,  110,  111,  111,  110,  111,  111,
			   75,  110,  111,   75,  111,  110,  111,  111,   77,  110,
			  111,   77,  111,  108,  110,  111,  108,  111,  110,  111,
			  111,   81,  110,  111,   81,  111,  110,  111,  110,  111,
			  111,  111,  110,  111,  111,  110,  111,  111,  110,  111, yy_Dummy>>,
			1, 1000, 0)
		end

	yy_acclist_template_2 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  111,  110,  111,  111,  110,  111,  110,  111,  111,  111,
			  110,  111,  111,  110,  111,  111,  110,  111,  111,   94,
			  110,  111,   94,  111,  110,  111,  111,   96,  110,  111,
			   96,  111,   97,  110,  111,   97,  111,  110,  111,  111,
			  110,  111,  111,  110,  111,  111,  110,  111,  111,  102,
			  110,  111,  102,  111,  103,  110,  111,  103,  111,  145,
			  145,  145,  145,  136,  136,  136,  159,  159,  162,  159,
			  162,  158,  159,  161,  162,  158,  161,  149,  156,  110,
			  111,  111,   41,  110,  111,   41,  111,   42,  110,  111,
			   42,  111,  110,  111,  111,  110,  111,  111,  110,  111,

			  111,   48,  110,  111,   48,  111,   49,  110,  111,   49,
			  111,  110,  111,  111,  110,  111,  111,  110,  111,  111,
			   54,  110,  111,   54,  111,  110,  111,  111,  110,  111,
			  111,  110,  111,  111,  110,  111,  111,  110,  111,  111,
			  110,  111,  111,  110,  111,  111,   64,  110,  111,   64,
			  111,  110,  111,  111,  110,  111,  111,  110,  111,  111,
			  110,  111,  111,   70,  110,  111,   70,  111,  110,  111,
			  111,  110,  111,  111,  110,  111,  111,   76,  110,  111,
			   76,  111,  110,  111,  111,  110,  111,  111,  110,  111,
			  111,  110,  111,  111,  110,  111,  111,  110,  111,  111,

			  110,  111,  111,  110,  111,  111,  110,  111,  111,   91,
			  110,  111,   91,  111,  110,  111,  111,  110,  111,  111,
			   95,  110,  111,   95,  111,  110,  111,  111,  110,  111,
			  111,  100,  110,  111,  100,  111,  110,  111,  111,  135,
			  159,  162,  162,  159,  158,  159,  161,  162,  158,  161,
			  157,   40,  110,  111,   40,  111,   46,  110,  111,   46,
			  111,  110,  111,  111,  110,  111,  111,  110,  111,  111,
			   51,  110,  111,  110,  111,   51,  111,  111,  110,  111,
			  111,  110,  111,  111,  110,  111,  111,   58,  110,  111,
			   58,  111,   60,  110,  111,   60,  111,  110,  111,  111,

			   62,  110,  111,   62,  111,  110,  111,  111,  110,  111,
			  111,   67,  110,  111,   67,  111,  110,  111,  111,  110,
			  111,  111,  110,  111,  111,  110,  111,  111,  110,  111,
			  111,  110,  111,  111,  110,  111,  111,   84,  110,  111,
			   84,  111,  110,  111,  111,  110,  111,  111,   87,  110,
			  111,   87,  111,  110,  111,  111,   89,  110,  111,   89,
			  111,   90,  110,  111,   90,  111,   92,  110,  111,   92,
			  111,  110,  111,  111,  110,  111,  111,   99,  110,  111,
			   99,  111,  110,  111,  111,  159,  158,  159,  161,  162,
			  162,  158,  160,  162,  160,  110,  111,  111,  110,  111,

			  111,   50,  110,  111,   50,  111,  110,  111,  111,   53,
			  110,  111,   53,  111,  110,  111,  111,  110,  111,  111,
			  110,  111,  111,  110,  111,  111,   65,  110,  111,   65,
			  111,   69,  110,  111,   69,  111,  110,  111,  111,   71,
			  110,  111,   71,  111,   72,  110,  111,   72,  111,  110,
			  111,  111,  110,  111,  111,  110,  111,  111,  110,  111,
			  111,  110,  111,  111,   88,  110,  111,   88,  111,  110,
			  111,  111,  110,  111,  111,  101,  110,  111,  101,  111,
			  162,  162,  158,  159,  161,  162,  161,  105,  110,  111,
			  105,  111,  110,  111,  111,   52,  110,  111,   52,  111,

			   55,  110,  111,   55,  111,  110,  111,  111,   61,  110,
			  111,   61,  111,   63,  110,  111,   63,  111,  109,  110,
			  111,  109,  111,  110,  111,  111,   79,  110,  111,   79,
			  111,  110,  111,  111,   86,  110,  111,   86,  111,  110,
			  111,  111,   93,  110,  111,   93,  111,   98,  110,  111,
			   98,  111,  162,  161,  162,  161,  162,  161,  106,  110,
			  111,  106,  111,  110,  111,  111,   73,  110,  111,   73,
			  111,   83,  110,  111,   83,  111,   85,  110,  111,   85,
			  111,  161,  162,  107,  110,  111,  107,  111, yy_Dummy>>,
			1, 588, 1000)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER = 7917
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER = 1076
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER = 1077
			-- Mark between normal states and templates

	yyNull_equiv_class: INTEGER = 1
			-- Equivalence code for NULL character

	yyReject_used: BOOLEAN = false
			-- Is `reject' called?

	yyVariable_trail_context: BOOLEAN = true
			-- Is there a regular expression with
			-- both leading and trailing parts having
			-- variable length?

	yyReject_or_variable_trail_context: BOOLEAN = true
			-- Is `reject' called or is there a
			-- regular expression with both leading
			-- and trailing parts having variable length?

	yyNb_rules: INTEGER = 165
			-- Number of rules

	yyEnd_of_buffer: INTEGER = 166
			-- End of buffer rule code

	yyLine_used: BOOLEAN = false
			-- Are line and column numbers used?

	yyPosition_used: BOOLEAN = false
			-- Is `position' used?

	INITIAL: INTEGER = 0
	VERBATIM_STR1: INTEGER = 1
			-- Start condition codes

feature -- User-defined features



note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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

end -- EDITOR_EIFFEL_SCANNER
