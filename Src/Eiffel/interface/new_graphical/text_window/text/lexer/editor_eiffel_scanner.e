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
--|#line 45 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 45")
end
-- Ignore carriage return
when 2 then
--|#line 46 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 46")
end

					curr_token := new_space (text_count)
					update_token_list
					
when 3 then
--|#line 50 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 50")
end

					if not in_comments then
						curr_token := new_tabulation (text_count)
					else
						curr_token := new_comment (text)
					end
					update_token_list
					
when 4 then
--|#line 58 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 58")
end

					from i_ := 1 until i_ > text_count loop
						curr_token := new_eol
						update_token_list
						i_ := i_ + 1
					end
					in_comments := False
					
when 5 then
--|#line 70 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 70")
end
 
						-- comments
					curr_token := new_comment (text)
					in_comments := True	
					update_token_list					
				
when 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17 then
--|#line 79 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 79")
end

						-- Symbols
					if not in_comments then
						curr_token := new_text (text)
					else
						curr_token := new_comment (text)
					end
					update_token_list
					
when 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36 then
--|#line 100 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 100")
end
 
						-- Operator Symbol
					if not in_comments then
						curr_token := new_operator (text)					
					else
						curr_token := new_comment (text)
					end
					update_token_list
					
when 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101 then
--|#line 130 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 130")
end

										-- Keyword
										if not in_comments then
											curr_token := new_keyword (text)
										else
											curr_token := new_comment (text)
										end
										update_token_list
										
when 102 then
--|#line 207 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 207")
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
										
when 103 then
--|#line 227 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 227")
end

										if not in_comments then
											curr_token := new_text (text)											
										else
											curr_token := new_comment (text)
										end
										update_token_list
										
when 104 then
--|#line 239 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 239")
end

										if not in_comments then
											curr_token := new_text (text)										
										else
											curr_token := new_comment (text)
										end
										update_token_list
										
when 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126 then
--|#line 253 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 253")
end

					if not in_comments then
						curr_token := new_character (text)
					else
						curr_token := new_comment (text)
					end
					update_token_list
					
when 127 then
--|#line 283 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 283")
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
					
when 128, 129 then
--|#line 298 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 298")
end

					-- Character error. Catch-all rules (no backing up)
					if not in_comments then
						curr_token := new_text (text)
					else
						curr_token := new_comment (text)
					end
					update_token_list
					
when 130 then
--|#line 321 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 321")
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
			
when 131 then
--|#line 335 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 335")
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
			
when 132 then
--|#line 350 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 350")
end
-- Ignore carriage return
when 133 then
--|#line 351 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 351")
end

							-- Verbatim string closer, possibly.
						curr_token := new_string (text)						
						end_of_verbatim_string := True
						in_verbatim_string := False
						set_start_condition (INITIAL)
						update_token_list
					
when 134 then
--|#line 360 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 360")
end

							-- Verbatim string closer, possibly.
						curr_token := new_string (text)						
						end_of_verbatim_string := True
						in_verbatim_string := False
						set_start_condition (INITIAL)
						update_token_list
					
when 135 then
--|#line 369 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 369")
end

						curr_token := new_space (text_count)
						update_token_list						
					
when 136 then
--|#line 374 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 374")
end
						
						curr_token := new_tabulation (text_count)
						update_token_list						
					
when 137 then
--|#line 379 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 379")
end

						from i_ := 1 until i_ > text_count loop
							curr_token := new_eol
							update_token_list
							i_ := i_ + 1
						end						
					
when 138 then
--|#line 387 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 387")
end

						curr_token := new_string (text)
						update_token_list
					
when 139, 140 then
--|#line 393 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 393")
end

					-- Eiffel String
					if not in_comments then						
						curr_token := new_string (text)
					else
						curr_token := new_comment (text)
					end
					update_token_list
					
when 141 then
--|#line 406 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 406")
end

					-- Eiffel Bit
					if not in_comments then
						curr_token := new_number (text)						
					else
						curr_token := new_comment (text)
					end
					update_token_list
					
when 142, 143, 144, 145 then
--|#line 418 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 418")
end

						-- Eiffel Integer
						if not in_comments then
							curr_token := new_number (text)
						else
							curr_token := new_comment (text)
						end
						update_token_list
						
when 146, 147, 148, 149 then
--|#line 432 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 432")
end

						-- Bad Eiffel Integer
						if not in_comments then
							curr_token := new_text (text)
						else
							curr_token := new_comment (text)
						end
						update_token_list
						
when 150 then
	yy_end := yy_end - 1
--|#line 447 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 447")
end

							-- Eiffel reals & doubles
						if not in_comments then		
							curr_token := new_number (text)
						else
							curr_token := new_comment (text)
						end
						update_token_list
						
when 151, 152 then
--|#line 448 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 448")
end

							-- Eiffel reals & doubles
						if not in_comments then		
							curr_token := new_number (text)
						else
							curr_token := new_comment (text)
						end
						update_token_list
						
when 153 then
	yy_end := yy_end - 1
--|#line 450 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 450")
end

							-- Eiffel reals & doubles
						if not in_comments then		
							curr_token := new_number (text)
						else
							curr_token := new_comment (text)
						end
						update_token_list
						
when 154, 155 then
--|#line 451 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 451")
end

							-- Eiffel reals & doubles
						if not in_comments then		
							curr_token := new_number (text)
						else
							curr_token := new_comment (text)
						end
						update_token_list
						
when 156 then
--|#line 468 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 468")
end

					curr_token := new_text (text)
					update_token_list
					
when 157 then
--|#line 476 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 476")
end

					-- Error (considered as text)
				if not in_comments then
					curr_token := new_text (text)
				else
					curr_token := new_comment (text)
				end
				update_token_list
				
when 158 then
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
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make (0, 9201)
			yy_nxt_template_1 (an_array)
			yy_nxt_template_2 (an_array)
			yy_nxt_template_3 (an_array)
			yy_nxt_template_4 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_nxt_template_1 (an_array: ARRAY [INTEGER]) is
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
			    6,    6,    6,    6,   79,   80,   81,   82,   83,   84,

			   85,   87,   88,   89,   90,  139,  137,  140,  140,  140,
			  140,  141, 1016,   87,   88,   89,   90,  138,  845,  142,
			  143,  746,  144,  144,  145,  145,  153,  154,  155,  156,
			  739,  106,  838,  151,  107,  158,  158,  158,  106,  265,
			  265,  107, 1016, 1016,  143,  127,  145,  145,  145,  145,
			  401,  401,  128,  127,  380,  158,  606,   91,  163,  158,
			  163,  604,  150,  365,  602,  151,  264,  264,  264,   91,
			  163,  606,  158,  249,  250,  251,  252,  253,  254,  255,
			  108,  266,  266,  266,  380,  380,  150,  163,   92,  604,
			  163,  163,  163,   93,   94,   95,   96,   97,   98,   99,

			   92,  365,  163,  602,  163,   93,   94,   95,   96,   97,
			   98,   99,  109,  267,  267,  267,  510,  510,  110,  111,
			  112,  113,  114,  115,  116,  119,  120,  121,  122,  123,
			  124,  125,  129,  129,  129,  129,  130,  131,  132,  133,
			  134,  135,  136,  143,  366,  144,  144,  145,  145,  587,
			  158,  158,  562,  562,  158,  158,  147,  148,  158,  187,
			  175,  586,  158,  158,  215,  158,  158,  158,  225,  188,
			  158,  365,  158,  585,  584,  158,  381,  381,  149,  583,
			  368,  368,  163,  163,  582,  150,  163,  163,  147,  148,
			  163,  189,  176,  581,  163,  163,  216,  163,  163,  163,

			  226,  190,  163,  580,  163,  579,  578,  163,  577,  576,
			  149,  158,  158,  158,  158,  575,  380,  158,  158,  158,
			  574,  158,  158,  158,  158,  158,  158,  159,  158,  158,
			  158,  158,  160,  158,  161,  158,  158,  158,  158,  162,
			  158,  158,  158,  158,  158,  158,  158,  400,  400,  400,
			  371,  158,  573,  163,  163,  163,  163,  163,  163,  164,
			  163,  163,  163,  163,  165,  163,  166,  163,  163,  163,
			  163,  167,  163,  163,  163,  163,  163,  163,  163,  158,
			  402,  402,  402,  227,  918,  168,  169,  170,  171,  172,
			  173,  174,  158,  177,  572,  570,  158,  178,  569,  158,

			  179,  158,  158,  180,  158,  229,  181,  191,  568,  192,
			  374,  163,  567,  566,  158,  228,  918,  565,  158,  193,
			  230,  403,  403,  403,  163,  182,  381,  381,  163,  183,
			  560,  163,  184,  163,  163,  185,  163,  231,  186,  194,
			  281,  195,  513,  197,  381,  381,  163,  198,  975,  158,
			  163,  196,  232,  508,  158,  404,  158,  203,  158,  399,
			  199,  158,  365,  158,  204,  205,  601,  103,  158,  102,
			  206,  101,  158,  100,  596,  200,  211,  281,  268,  201,
			  975,  163,  212,  263,  601,  158,  163,  247,  163,  207,
			  163,  157,  202,  163,  158,  163,  208,  209,  158,  152,

			  163,  233,  210,  104,  163,  158,  217,  103,  213,  158,
			  102,  234,  365,  101,  214,  158,  218,  163,  219,  158,
			  100, 1016,  220, 1016, 1016,  239,  163,  158,  237,  158,
			  163,  158,  158,  235,  243, 1016, 1016,  163,  221,  240,
			 1016,  163,  158,  236,  158, 1016, 1016,  163,  222, 1016,
			  223,  163, 1016, 1016,  224, 1016, 1016,  241,  158,  163,
			  238,  163,  158,  163,  163,  176,  244,  163, 1016,  163,
			  216,  242,  245,  164,  163,  158,  163, 1016,  165,  163,
			  166,  213, 1016, 1016,  163,  167,  163,  214,  365, 1016,
			  163,  126,  126,  126,  163, 1016,  163,  176,  189,  163,

			 1016,  163,  216, 1016,  246,  164, 1016,  163,  190, 1016,
			  165,  163,  166,  213, 1016, 1016,  163,  167,  163,  214,
			 1016,  256,  257,  258,  259,  260,  261,  262,  163, 1016,
			  189,  256,  257,  258,  259,  260,  261,  262,  182, 1016,
			  190, 1016,  183,  365,  163,  184,  163, 1016,  185, 1016,
			  226,  186,  277, 1016,  278,  278,  163, 1016,  256,  257,
			  258,  259,  260,  261,  262, 1016, 1016,  367,  367,  367,
			  182, 1016, 1016,  194,  183,  195,  163,  184,  163, 1016,
			  185, 1016,  226,  186, 1016,  196, 1016, 1016,  163, 1016,
			  278, 1016,  278,  285, 1016,  256,  257,  258,  259,  260,

			  261,  262,  200,  207, 1016,  194,  201,  195,  279,  163,
			  208,  209, 1016,  163, 1016,  163,  210,  196, 1016,  202,
			 1016,  163,  369,  369,  369,  163,  256,  257,  258,  259,
			  260,  261,  262, 1016,  200,  207, 1016, 1016,  201,  280,
			  221,  163,  208,  209, 1016,  163,  279,  163,  210, 1016,
			  222,  202,  223,  163,  228, 1016,  224,  163,  163,  231,
			  238,  163,  163,  163, 1016,  235,  163, 1016,  163,  163,
			  163,  163,  221,  163,  232,  236, 1016,  280,  163, 1016,
			 1016,  163,  222, 1016,  223, 1016,  228, 1016,  224, 1016,
			  163,  231,  238,  163,  163,  163, 1016,  235,  163, 1016,

			  163,  163,  163,  163,  241,  163,  232,  236,  244, 1016,
			  163, 1016,  163,  163,  163,  163, 1016,  163,  242,  163,
			 1016,  163,  246,  278,  163,  282,  278,  163, 1016, 1016,
			  279,  163,  365,  279, 1016,  286,  241, 1016,  269, 1016,
			  244,  163,  163,  163,  163, 1016,  163,  163, 1016,  163,
			  242,  163,  280,  163,  246,  280,  163,  294, 1016,  163,
			  269, 1016, 1016,  163,  270,  271,  272,  273,  274,  275,
			  276,  270,  271,  272,  273,  274,  275,  276,  302,  283,
			  270,  271,  272,  273,  274,  275,  276,  303,  303,  303,
			  335,  270,  271,  272,  273,  274,  275,  276,  304,  304,

			 1016, 1016,  270,  271,  272,  273,  274,  275,  276, 1016,
			  284,  370,  370,  370, 1016,  270,  271,  272,  273,  274,
			  275,  276,  287,  288,  289,  290,  291,  292,  293,  305,
			  305,  305, 1016,  270,  271,  272,  273,  274,  275,  276,
			  106, 1016, 1016,  107,  295,  296,  297,  298,  299,  300,
			  301,  306,  306,  306, 1016,  270,  271,  272,  273,  274,
			  275,  276,  307,  509,  509,  509,  270,  271,  272,  273,
			  274,  275,  276,  336,  337,  338,  339,  340,  341,  342,
			  336,  337,  338,  339,  340,  341,  342, 1016, 1016,  108,
			  511,  511,  511,  320, 1016,  320,  320, 1016,  106, 1016,

			  143,  107,  378,  378,  379,  379,  321, 1016,  321,  321,
			 1016,  106, 1016,  151,  107, 1016,  383,  383,  383, 1016,
			 1016,  109,  512,  512,  512, 1016, 1016,  110,  111,  112,
			  113,  114,  115,  116,  309, 1016, 1016,  310,  118,  118,
			  118, 1016,  150, 1016, 1016,  151,  311,  108,  106, 1016,
			 1016,  107, 1016,  118, 1016,  118,  380,  118,  118,  312,
			  108, 1016,  118,  106,  118, 1016,  107, 1016,  118, 1016,
			  118, 1016, 1016,  118,  118,  118,  118,  118,  118,  109,
			 1016,  106, 1016, 1016,  107,  110,  111,  112,  113,  114,
			  115,  116,  109,  106, 1016, 1016,  107,  108,  110,  111,

			  112,  113,  114,  115,  116,  158,  158,  158,  106, 1016,
			 1016,  107,  108,  158,  158,  158,  158,  158,  158, 1016,
			 1016,  313,  314,  315,  316,  317,  318,  319,  106,  109,
			  108,  107,  158,  158,  158,  110,  111,  112,  113,  114,
			  115,  116,  106, 1016,  109,  107, 1016, 1016,  322, 1016,
			  110,  111,  112,  113,  114,  115,  116,  108,  106, 1016,
			 1016,  107,  109, 1016,  323,  323,  323, 1016,  110,  111,
			  112,  113,  114,  115,  116,  106, 1016,  108,  107, 1016,
			  119,  120,  121,  122,  123,  124,  125,  106, 1016,  109,
			  107,  324,  324, 1016, 1016,  110,  111,  112,  113,  114,

			  115,  116,  106, 1016, 1016,  107, 1016,  108, 1016,  109,
			 1016,  325,  325,  325, 1016,  110,  111,  112,  113,  114,
			  115,  116,  106, 1016,  108,  107,  514,  514,  514,  119,
			  120,  121,  122,  123,  124,  125, 1016,  106, 1016,  109,
			  107,  326,  326,  326, 1016,  110,  111,  112,  113,  114,
			  115,  116,  106, 1016, 1016,  107,  109, 1016,  327,  515,
			  515,  515,  110,  111,  112,  113,  114,  115,  116, 1016,
			  106, 1016,  328,  107,  119,  120,  121,  122,  123,  124,
			  125,  334,  334,  334, 1016,  329,  329,  329, 1016,  119,
			  120,  121,  122,  123,  124,  125,  143, 1016,  379,  379,

			  379,  379,  561,  561,  561,  330,  330, 1016, 1016,  119,
			  120,  121,  122,  123,  124,  125,  563,  563,  563, 1016,
			  331,  331,  331, 1016,  119,  120,  121,  122,  123,  124,
			  125,  564,  564,  564, 1016,  332,  332,  332,  150,  119,
			  120,  121,  122,  123,  124,  125,  270,  271,  272,  273,
			  274,  275,  276,  333,  501, 1016, 1016,  119,  120,  121,
			  122,  123,  124,  125,  343, 1016, 1016,  344,  345,  346,
			  347, 1016,  372,  372,  372,  372,  348,  376,  376,  376,
			  376, 1016, 1016,  349, 1016,  350,  373,  351,  352,  353,
			  354,  377,  355, 1016,  356, 1016, 1016,  158,  357, 1016,

			  358,  158, 1016,  359,  360,  361,  362,  363,  364,  126,
			  126,  126,  374,  158,  158, 1016, 1016,  389,  373,  126,
			  126,  126, 1016,  377,  387,  387,  387,  387, 1016,  163,
			  158,  158, 1016,  163,  395,  158, 1016,  249,  250,  251,
			  252,  253,  254,  255, 1016,  163,  163, 1016,  158,  390,
			 1016,  336,  337,  338,  339,  340,  341,  342,  385,  385,
			  385,  385,  163,  163,  388, 1016,  396,  163,  385,  385,
			  385,  385,  385,  385,  158,  158, 1016, 1016,  158,  158,
			  163, 1016,  391, 1016,  163,  392,  163,  126,  126,  126,
			  390,  158,  158,  397, 1016, 1016,  163,  163,  380,  163,

			  385,  385,  385,  385,  385,  385,  163,  163, 1016,  163,
			  163,  163, 1016, 1016,  393, 1016,  163,  394,  163,  126,
			  126,  126,  390,  163,  163,  398,  396,  393,  163,  163,
			  394,  163,  163,  163,  163,  163,  163,  588,  588,  588,
			  398,  163,  163, 1016,  158,  163,  163, 1016,  158,  589,
			  589,  589,  158,  409, 1016, 1016,  407,  158,  396,  393,
			 1016,  158,  394,  405,  163,  163,  163,  163,  163,  158,
			  158,  163,  398,  163,  163, 1016,  163,  163,  163,  406,
			  163, 1016,  158,  163,  163,  410,  413,  158,  408,  163,
			  158,  158, 1016,  163,  158,  406,  158,  158,  158,  158,

			  411,  163,  163,  163,  158,  163, 1016,  415,  383,  383,
			  383,  406, 1016, 1016,  163,  163, 1016, 1016,  414,  163,
			 1016,  408,  163,  163,  410, 1016,  163, 1016,  163, 1016,
			  163,  163,  412, 1016,  158,  163,  163,  163,  158,  416,
			  163, 1016,  163,  163,  412,  163, 1016,  163,  603,  416,
			 1016,  158,  414,  408,  163,  163,  410, 1016, 1016,  163,
			  163,  163,  163,  158,  158,  158,  163,  163, 1016,  163,
			  163,  163,  163, 1016,  163,  163,  412,  163,  419,  163,
			 1016,  416,  420,  163,  414,  158,  163,  163,  163,  158,
			  163,  163, 1016,  163,  158,  417,  431, 1016,  158,  418,

			  163,  158,  158,  163,  163,  158,  163,  158,  158,  158,
			  419,  158, 1016, 1016,  420, 1016,  163,  163,  158,  421,
			  163,  163,  163,  158,  158,  158,  163,  419,  432, 1016,
			  163,  420,  163,  163,  163, 1016,  163,  163,  163, 1016,
			  163,  158,  163,  163,  423,  158, 1016,  422,  163,  158,
			  163,  422,  163,  158, 1016,  425, 1016, 1016,  158,  424,
			  615,  615,  615,  163,  427,  163,  158, 1016,  428, 1016,
			  426, 1016,  163,  163,  163,  163,  425,  163, 1016,  422,
			 1016,  163,  433, 1016,  163,  163,  158,  425, 1016, 1016,
			  163,  426,  432, 1016,  163,  163,  429,  163,  163,  158,

			  430,  163,  426,  163,  163,  429,  158,  163, 1016,  430,
			  158, 1016, 1016,  163,  434, 1016,  434,  158,  163, 1016,
			  435,  158, 1016,  158,  432, 1016,  163,  163, 1016,  163,
			 1016,  163, 1016,  163,  158,  163,  163,  429,  163,  163,
			 1016,  430,  163, 1016,  163,  163,  163,  436,  434,  163,
			  158, 1016,  436,  163,  158,  163,  163, 1016, 1016,  163,
			  158,  163, 1016, 1016,  158,  437,  163,  158, 1016, 1016,
			  158,  163, 1016, 1016,  158, 1016,  163,  158,  163,  436,
			 1016,  163,  163,  163, 1016, 1016,  163,  158,  163,  616,
			  616,  616,  163,  163, 1016, 1016,  163,  438, 1016,  163,

			  158, 1016,  163,  439,  158,  440,  163,  441,  163,  163,
			  163, 1016,  438,  163, 1016,  163, 1016,  158,  442,  163,
			  163,  443,  163,  163,  163,  163,  163,  163,  163,  163,
			 1016,  163,  163, 1016, 1016,  444,  163,  445, 1016,  446,
			  163,  163,  163,  158,  438,  451, 1016,  158, 1016,  163,
			  447, 1016,  163,  448,  444, 1016,  445,  452,  446, 1016,
			  158,  163,  163,  163,  163, 1016,  158, 1016, 1016,  447,
			  158, 1016,  448,  163,  163,  163,  449,  453, 1016,  163,
			  163,  163,  163,  158,  450,  163,  444,  163,  445,  454,
			  446, 1016,  163, 1016,  163, 1016,  163,  163,  163, 1016,

			  453,  447,  163,  158,  448, 1016,  163,  158,  450,  163,
			 1016,  163,  454, 1016, 1016,  163,  450,  163, 1016,  163,
			  158,  163,  455, 1016,  163,  163,  163,  163, 1016,  163,
			  158, 1016,  453,  456,  158,  163,  163,  163,  158,  163,
			  461,  163,  158,  163,  454, 1016,  158,  158,  457,  459,
			  158, 1016,  163,  163,  456,  158,  163,  163,  163,  163,
			 1016, 1016,  163,  158, 1016,  456,  163, 1016,  163,  163,
			  163,  158,  462, 1016,  163,  463, 1016, 1016,  163,  163,
			  458,  460,  163,  462,  163, 1016,  163,  163,  158,  460,
			 1016,  458,  163,  464,  163,  163,  163,  163, 1016,  163,

			  163, 1016,  163,  163,  163, 1016, 1016,  464, 1016,  163,
			 1016, 1016,  163, 1016, 1016,  462,  163, 1016,  163, 1016,
			  163,  460, 1016,  458,  163,  464,  163, 1016,  163,  163,
			 1016,  163,  163, 1016,  163,  158,  163, 1016,  501,  158,
			 1016,  163, 1016, 1016,  163,  465,  477,  466, 1016,  158,
			  478, 1016,  158,  158, 1016,  467, 1016,  158,  468, 1016,
			  469,  470, 1016,  158,  163,  163,  163,  163, 1016, 1016,
			  481,  163, 1016,  277, 1016,  278,  278,  471,  479,  472,
			 1016,  163,  480, 1016,  163,  163, 1016,  473, 1016,  163,
			  474, 1016,  475,  476, 1016,  163,  471, 1016,  472, 1016,

			 1016,  479,  482,  163,  163,  480,  473, 1016,  163,  474,
			  163,  475,  476,  163,  482,  158,  163, 1016, 1016,  483,
			  163,  249,  250,  251,  252,  253,  254,  255,  471,  279,
			  472, 1016,  158,  479, 1016,  163,  163,  480,  473, 1016,
			  163,  474,  163,  475,  476,  163,  482,  163,  163,  158,
			 1016,  484,  163,  158,  484, 1016,  163, 1016,  163, 1016,
			  280,  163, 1016,  163,  163,  486,  158, 1016,  163,  485,
			 1016, 1016,  158,  163, 1016,  487,  158,  713,  713,  713,
			  488,  163,  714,  714,  714,  163,  484, 1016,  163,  158,
			  163,  489,  158,  163, 1016,  163,  158,  486,  163, 1016,

			  163,  486, 1016, 1016,  163,  163,  490,  490,  163,  493,
			 1016,  491,  491, 1016,  163, 1016,  163,  571,  571,  571,
			  571,  163,  492,  492,  163,  158,  163, 1016,  163,  158,
			  158,  158,  158,  495, 1016,  158, 1016, 1016,  490,  497,
			 1016,  494,  158,  491, 1016, 1016,  163,  163,  163,  163,
			 1016, 1016,  158,  494,  492, 1016, 1016,  163,  163,  163,
			 1016,  163,  501,  496, 1016,  496,  163,  163,  163, 1016,
			 1016,  498,  158,  498,  163,  501,  158, 1016,  163,  163,
			  163,  163,  163, 1016,  163,  494,  501, 1016, 1016,  499,
			 1016,  163,  163, 1016, 1016,  496, 1016,  163,  163,  163,

			  163,  501, 1016,  500,  163,  498, 1016, 1016,  163,  163,
			  163, 1016,  163,  501,  163,  593,  593,  593,  593, 1016,
			  278,  500,  278,  278,  163,  501,  158,  158,  158,  163,
			 1016,  163,  591, 1016,  591,  500, 1016,  592,  592,  592,
			  592,  163, 1016,  502, 1016,  249,  250,  251,  252,  253,
			  254,  255, 1016, 1016,  503,  503,  503, 1016,  249,  250,
			  251,  252,  253,  254,  255,  504,  504, 1016, 1016,  249,
			  250,  251,  252,  253,  254,  255,  279,  334,  334,  334,
			  505,  505,  505, 1016,  249,  250,  251,  252,  253,  254,
			  255, 1016,  506,  506,  506, 1016,  249,  250,  251,  252,

			  253,  254,  255,  516,  507, 1016, 1016,  280,  249,  250,
			  251,  252,  253,  254,  255,  270,  271,  272,  273,  274,
			  275,  276,  302,  524,  270,  271,  272,  273,  274,  275,
			  276,  303,  303,  303, 1016,  270,  271,  272,  273,  274,
			  275,  276,  304,  304, 1016, 1016,  270,  271,  272,  273,
			  274,  275,  276,  305,  305,  305, 1016,  270,  271,  272,
			  273,  274,  275,  276,  306,  306,  306, 1016,  270,  271,
			  272,  273,  274,  275,  276,  307,  334,  334,  334,  270,
			  271,  272,  273,  274,  275,  276,  278, 1016,  282,  278,
			  517,  518,  519,  520,  521,  522,  523,  279, 1016, 1016,

			  279,  278,  286,  278,  285,  269,  334,  334,  334, 1016,
			  525,  526,  527,  528,  529,  530,  531,  280, 1016, 1016,
			  280, 1016,  294, 1016, 1016,  269,  270,  271,  272,  273,
			  274,  275,  276,  279, 1016, 1016,  279, 1016,  286, 1016,
			 1016,  269,  283,  279, 1016, 1016,  279, 1016,  286, 1016,
			 1016,  269,  334,  334,  334,  279, 1016,  279,  279, 1016,
			  286, 1016, 1016,  269, 1016, 1016,  279, 1016, 1016,  279,
			 1016,  286, 1016,  284,  269,  734,  734,  734,  270,  271,
			  272,  273,  274,  275,  276,  735,  735,  735,  280,  287,
			  288,  289,  290,  291,  292,  293,  279, 1016, 1016,  279,

			  597,  286,  597, 1016,  269,  598,  598,  598,  598,  295,
			  296,  297,  298,  299,  300,  301,  279, 1016, 1016,  279,
			 1016,  286, 1016, 1016,  269,  287,  288,  289,  290,  291,
			  292,  293, 1016,  532, 1016,  287,  288,  289,  290,  291,
			  292,  293, 1016,  533,  533,  533, 1016,  287,  288,  289,
			  290,  291,  292,  293,  534,  534, 1016, 1016,  287,  288,
			  289,  290,  291,  292,  293,  279, 1016, 1016,  279, 1016,
			  286, 1016, 1016,  269,  270,  271,  272,  273,  274,  275,
			  276,  126,  126,  126,  535,  535,  535, 1016,  287,  288,
			  289,  290,  291,  292,  293,  280, 1016, 1016,  280, 1016,

			  294, 1016, 1016,  269,  536,  536,  536, 1016,  287,  288,
			  289,  290,  291,  292,  293,  280, 1016, 1016,  280, 1016,
			  294, 1016, 1016,  269, 1016, 1016,  280, 1016, 1016,  280,
			 1016,  294, 1016, 1016,  269, 1016, 1016,  280, 1016, 1016,
			  280, 1016,  294, 1016, 1016,  269,  270,  271,  272,  273,
			  274,  275,  276,  537,  126,  126,  126,  287,  288,  289,
			  290,  291,  292,  293,  280, 1016, 1016,  280, 1016,  294,
			 1016, 1016,  269, 1016, 1016,  280, 1016, 1016,  280, 1016,
			  294, 1016, 1016,  269,  158,  158,  158,  295,  296,  297,
			  298,  299,  300,  301,  280, 1016, 1016,  280, 1016,  294,

			 1016, 1016,  269, 1016, 1016,  538, 1016,  295,  296,  297,
			  298,  299,  300,  301,  539,  539,  539, 1016,  295,  296,
			  297,  298,  299,  300,  301,  540,  540, 1016, 1016,  295,
			  296,  297,  298,  299,  300,  301,  270,  271,  272,  273,
			  274,  275,  276,  270,  271,  272,  273,  274,  275,  276,
			 1016, 1016,  541,  541,  541, 1016,  295,  296,  297,  298,
			  299,  300,  301,  542,  542,  542, 1016,  295,  296,  297,
			  298,  299,  300,  301,  270,  271,  272,  273,  274,  275,
			  276,  106,  543, 1016,  546, 1016,  295,  296,  297,  298,
			  299,  300,  301,  544,  544,  544, 1016,  270,  271,  272, yy_Dummy>>,
			1, 3000, 0)
		end

	yy_nxt_template_2 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			  273,  274,  275,  276,  545,  545,  545, 1016,  270,  271,
			  272,  273,  274,  275,  276,  106, 1016, 1016,  107,  158,
			  158,  158,  547, 1016, 1016,  107,  383,  383,  383,  106,
			 1016,  611,  546, 1016, 1016,  158,  106, 1016, 1016,  549,
			 1016, 1016,  548,  548,  548,  548,  106, 1016,  158,  546,
			  590,  590,  590,  590, 1016,  106, 1016,  143,  546,  600,
			  600,  600,  600,  612,  373, 1016,  603,  163,  313,  314,
			  315,  316,  317,  318,  319,  106, 1016, 1016,  546, 1016,
			  163,  736,  571,  571,  571,  571,  106, 1016, 1016,  546,
			  374,  592,  592,  592,  592, 1016,  373,  106, 1016,  150,

			  546, 1016,  119,  120,  121,  122,  123,  124,  125,  119,
			  120,  121,  122,  123,  124,  125,  313,  314,  315,  316,
			  317,  318,  319,  313,  314,  315,  316,  317,  318,  319,
			  163,  163,  163,  313,  314,  315,  316,  317,  318,  319,
			  550, 1016,  313,  314,  315,  316,  317,  318,  319,  106,
			 1016, 1016,  546,  607,  607,  607,  607, 1016,  551,  551,
			  551, 1016,  313,  314,  315,  316,  317,  318,  319,  552,
			  552, 1016, 1016,  313,  314,  315,  316,  317,  318,  319,
			  553,  553,  553, 1016,  313,  314,  315,  316,  317,  318,
			  319,  106, 1016,  388,  546,  738,  738,  738,  738,  320,

			 1016,  320,  320, 1016,  106, 1016, 1016,  107,  740,  740,
			  740,  740,  321, 1016,  321,  321, 1016,  106, 1016, 1016,
			  107,  608,  608,  608,  608, 1016, 1016,  158,  163,  163,
			  163,  158,  554,  554,  554,  739,  313,  314,  315,  316,
			  317,  318,  319, 1016,  158,  143, 1016,  599,  599,  600,
			  600,  106, 1016,  108,  107,  334,  334,  334,  151,  163,
			 1016,  388, 1016,  163,  106, 1016,  108,  107,  744,  744,
			  744,  744, 1016, 1016,  555, 1016,  163, 1016,  313,  314,
			  315,  316,  317,  318,  319,  109,  106,  150, 1016,  107,
			  151,  110,  111,  112,  113,  114,  115,  116,  109,  106,

			  108, 1016,  107, 1016,  110,  111,  112,  113,  114,  115,
			  116, 1016,  106,  108, 1016,  107,  334,  334,  334,  106,
			 1016, 1016,  107,  270,  271,  272,  273,  274,  275,  276,
			 1016, 1016,  109,  106, 1016,  108,  107, 1016,  110,  111,
			  112,  113,  114,  115,  116,  109,  106, 1016,  108,  107,
			 1016,  110,  111,  112,  113,  114,  115,  116, 1016,  106,
			 1016,  108,  107, 1016, 1016, 1016,  106,  109, 1016,  107,
			 1016, 1016, 1016,  110,  111,  112,  113,  114,  115,  116,
			  109,  106,  108, 1016,  107, 1016,  110,  111,  112,  113,
			  114,  115,  116,  109, 1016,  556,  556,  556, 1016,  110,

			  111,  112,  113,  114,  115,  116,  119,  120,  121,  122,
			  123,  124,  125, 1016,  109, 1016,  557,  557,  557, 1016,
			  110,  111,  112,  113,  114,  115,  116,  106, 1016, 1016,
			  107, 1016, 1016,  119,  120,  121,  122,  123,  124,  125,
			  598,  598,  598,  598, 1016, 1016,  119,  120,  121,  122,
			  123,  124,  125,  119,  120,  121,  122,  123,  124,  125,
			  841,  841,  841,  841,  558,  558,  558, 1016,  119,  120,
			  121,  122,  123,  124,  125,  842,  842,  842,  842, 1016,
			 1016,  594,  594,  594,  594, 1016,  737,  737,  737,  737,
			  163,  163,  610,  163, 1016,  595, 1016, 1016, 1016,  742,

			  373,  742,  163,  163,  743,  743,  743,  743, 1016, 1016,
			  559,  559,  559, 1016,  119,  120,  121,  122,  123,  124,
			  125,  596,  163,  163,  610,  163,  374,  595,  385,  385,
			  385,  385,  373,  158,  163,  163, 1016,  158,  385,  385,
			  385,  385,  385,  385,  612,  158,  609, 1016, 1016,  158,
			  158,  163, 1016,  163, 1016,  163, 1016,  163,  743,  743,
			  743,  743,  158,  163, 1016,  163, 1016,  163,  605,  163,
			  385,  385,  385,  385,  385,  385,  612,  163,  610, 1016,
			  158,  163,  163,  163,  158,  163,  158,  163,  613,  163,
			  158, 1016, 1016,  614,  163,  163,  163,  158,  163,  163,

			 1016, 1016,  163,  158,  163, 1016,  618,  158,  163,  617,
			 1016,  158,  163, 1016,  163,  163,  163,  163,  163, 1016,
			  614, 1016,  163, 1016,  158,  614, 1016,  163,  163,  163,
			  163, 1016, 1016,  158,  163,  163,  163,  158,  618,  163,
			  163,  618, 1016,  163, 1016, 1016,  163,  163, 1016,  163,
			  158,  619, 1016, 1016,  158,  163,  163,  163,  158,  163,
			 1016, 1016,  620, 1016,  163,  163,  163,  163,  623,  163,
			 1016,  158,  158, 1016,  622,  621,  163,  846,  846,  846,
			  846, 1016,  163,  620, 1016,  158,  163,  163, 1016,  163,
			  163, 1016, 1016,  158,  620, 1016,  163,  158,  163,  163,

			  624,  624, 1016,  163,  163, 1016,  622,  622,  163,  163,
			  625,  163,  163, 1016,  163,  626, 1016,  163,  158,  158,
			 1016,  163,  158,  629,  163,  163, 1016, 1016,  163,  163,
			  163, 1016, 1016,  624, 1016,  158,  158,  628,  627, 1016,
			  163,  163,  626,  163,  163, 1016,  163,  626, 1016, 1016,
			  163,  163,  630,  163,  163,  630,  163,  632, 1016,  163,
			  163,  163,  163, 1016,  163, 1016,  163,  163,  163,  628,
			  628,  163,  163,  158, 1016,  158,  163,  631, 1016,  158,
			 1016, 1016,  158,  163,  630,  163,  158, 1016, 1016,  632,
			  158,  163,  158,  163, 1016,  163,  163, 1016,  163,  158,

			 1016, 1016,  633,  163,  163,  163,  163,  163,  163,  632,
			 1016,  163, 1016,  634,  163,  163,  163,  163,  163, 1016,
			 1016, 1016,  163, 1016,  163,  635,  158,  163, 1016,  158,
			  639,  163, 1016,  637,  634, 1016,  163,  158,  163,  636,
			 1016,  158,  158,  158,  163,  634,  163,  638,  163,  158,
			 1016, 1016, 1016,  158,  158,  641,  163,  637,  163, 1016,
			 1016,  163,  640,  640, 1016,  637,  158, 1016,  643,  163,
			  163,  638,  163,  163,  163,  163,  163, 1016,  163,  638,
			 1016,  163,  163, 1016, 1016,  163,  163,  642,  163,  163,
			 1016,  163, 1016, 1016, 1016,  640,  642,  163,  163,  163,

			  644,  163,  163, 1016,  163,  644, 1016,  158, 1016,  163,
			 1016,  158, 1016,  650,  163,  163, 1016, 1016,  163,  645,
			  163,  163, 1016,  163,  158,  163, 1016, 1016,  642,  163,
			  163,  163,  646,  163,  163,  647,  163,  644,  158,  163,
			 1016,  163,  158,  163, 1016,  650,  163,  163,  648,  649,
			  163,  647,  163, 1016,  158,  158,  163,  163,  651,  158,
			 1016, 1016,  163,  655,  648,  158,  163,  647,  163,  158,
			  163,  158, 1016,  653,  163, 1016,  158, 1016,  163,  158,
			  648,  650,  158,  158, 1016,  659,  163,  163, 1016,  158,
			  652,  163, 1016, 1016,  657,  656,  158,  163, 1016, 1016,

			  652,  163,  158,  163, 1016,  654, 1016,  163,  163,  163,
			 1016,  163, 1016, 1016,  163,  163, 1016,  660, 1016,  163,
			  654,  163, 1016,  163,  656,  163,  658, 1016,  163, 1016,
			 1016,  163,  652,  163,  163,  163,  163, 1016,  163,  163,
			  658,  163,  158,  163, 1016, 1016,  661, 1016,  163, 1016,
			 1016,  163,  654,  660, 1016,  163,  656,  163, 1016,  158,
			 1016, 1016,  662,  163,  163,  163,  163,  163,  163,  163,
			  163,  163,  658,  663,  163,  163,  163,  158,  662, 1016,
			  163,  163,  158, 1016, 1016,  660,  158, 1016, 1016,  664,
			  158,  163, 1016, 1016,  662, 1016,  163,  665,  163,  158,

			  163,  163,  163,  163, 1016,  664,  158, 1016,  163,  163,
			  158, 1016,  163,  163,  163,  163,  158,  163,  163,  666,
			  158,  664,  163,  158, 1016, 1016, 1016,  163, 1016,  666,
			  667,  163,  163,  158,  163, 1016,  158, 1016,  163, 1016,
			  158, 1016,  163, 1016,  163, 1016,  158,  163,  163,  163,
			  669,  666,  163,  158,  163,  163,  163,  668,  163,  163,
			  163, 1016,  668,  158,  670,  163,  163, 1016,  163, 1016,
			  163,  163,  163,  163,  848,  848,  848,  848,  163, 1016,
			 1016, 1016,  670,  163, 1016,  163,  163, 1016,  163,  668,
			  163, 1016,  163, 1016, 1016,  163,  670,  158,  163, 1016,

			 1016,  675,  163,  163,  158,  163,  671,  673,  158,  672,
			  674, 1016, 1016,  158,  158,  163,  163,  677,  163, 1016,
			  679,  158, 1016,  163,  158,  696, 1016,  158,  163,  163,
			  158,  158, 1016,  676, 1016,  163,  163,  158,  673,  673,
			  163,  674,  674, 1016,  158,  163,  163,  681,  163,  678,
			  163, 1016,  680,  163,  158,  163,  163,  696,  158,  163,
			  163, 1016,  163,  163,  158, 1016,  683,  163,  158,  163,
			 1016,  687, 1016,  676, 1016, 1016,  163, 1016,  678,  682,
			  163,  158,  163, 1016,  684,  163,  163,  163,  680, 1016,
			  163, 1016,  163, 1016, 1016, 1016,  163,  163,  685,  163,

			  163,  163, 1016,  688, 1016,  676,  163, 1016,  163, 1016,
			  678,  163,  163,  163,  163,  682,  686,  163,  163,  163,
			  680,  685, 1016, 1016,  163,  917,  917,  917,  917,  163,
			  163,  163,  163,  163, 1016, 1016, 1016,  158,  163,  686,
			  163,  689,  163,  163, 1016, 1016,  163,  682,  163, 1016,
			  163,  691,  688,  685,  158,  158,  690, 1016,  163,  692,
			 1016, 1016,  163,  163,  163,  163, 1016, 1016,  158,  163,
			  163,  686,  163,  690,  163,  163, 1016,  158,  163, 1016,
			  163,  158,  163,  692,  688,  693,  163,  163,  690, 1016,
			  163,  692, 1016,  694,  158,  163,  163,  163,  163,  158,

			  163,  158,  163,  158,  163,  697,  158,  163,  163,  163,
			  699, 1016,  695,  163,  163,  698,  158,  694,  158, 1016,
			 1016, 1016,  163,  158,  163,  694,  163, 1016,  163, 1016,
			  163,  163, 1016,  163,  163,  163, 1016,  698,  163, 1016,
			  163,  158,  700, 1016,  696,  158, 1016,  698,  163, 1016,
			  163, 1016, 1016,  700,  163,  163,  163,  701,  158,  158,
			  163, 1016,  163,  158, 1016,  704,  163,  703,  163,  163,
			  163,  163,  163,  163,  702, 1016,  158,  163, 1016,  158,
			  163,  163, 1016,  158, 1016,  700, 1016,  705, 1016,  702,
			  163,  163,  163, 1016,  163,  163,  158,  704, 1016,  704,

			  163,  163,  163,  163,  163,  501,  702, 1016,  163, 1016,
			 1016,  163,  163,  163,  163,  163,  710,  706, 1016,  706,
			  163,  158,  163,  708,  707,  158,  163, 1016,  163, 1016,
			  158,  163,  163,  163,  158, 1016,  501, 1016,  158,  921,
			  921,  921,  921,  163,  501, 1016,  163,  158,  710,  706,
			 1016,  501,  163,  163,  163,  708,  708,  163,  163, 1016,
			 1016, 1016,  163,  163,  163,  163,  163,  158,  501, 1016,
			  163,  158, 1016, 1016,  163,  163,  163, 1016, 1016,  163,
			  709,  501, 1016, 1016,  158,  516,  163, 1016,  249,  250,
			  251,  252,  253,  254,  255,  516, 1016, 1016, 1016,  163,

			 1016, 1016, 1016,  163, 1016, 1016,  163,  516,  163, 1016,
			 1016, 1016,  710, 1016,  524, 1016,  163, 1016,  163,  249,
			  250,  251,  252,  253,  254,  255,  516,  249,  250,  251,
			  252,  253,  254,  255,  249,  250,  251,  252,  253,  254,
			  255,  516,  922,  922,  922,  922, 1016,  711,  711,  711,
			 1016,  249,  250,  251,  252,  253,  254,  255,  516, 1016,
			  712,  712,  712, 1016,  249,  250,  251,  252,  253,  254,
			  255,  516,  517,  518,  519,  520,  521,  522,  523, 1016,
			  715,  524,  517,  518,  519,  520,  521,  522,  523, 1016,
			  716,  716,  716,  524,  517,  518,  519,  520,  521,  522,

			  523,  525,  526,  527,  528,  529,  530,  531,  524,  717,
			  717, 1016, 1016,  517,  518,  519,  520,  521,  522,  523,
			  524, 1016, 1016, 1016,  718,  718,  718, 1016,  517,  518,
			  519,  520,  521,  522,  523,  524,  924,  924,  924,  924,
			 1016,  719,  719,  719, 1016,  517,  518,  519,  520,  521,
			  522,  523,  524, 1016,  720, 1016, 1016, 1016,  517,  518,
			  519,  520,  521,  522,  523, 1016,  721, 1016,  525,  526,
			  527,  528,  529,  530,  531, 1016,  722,  722,  722, 1016,
			  525,  526,  527,  528,  529,  530,  531,  916,  916,  916,
			  916,  723,  723, 1016, 1016,  525,  526,  527,  528,  529,

			  530,  531, 1016,  724,  724,  724, 1016,  525,  526,  527,
			  528,  529,  530,  531,  916,  916,  916,  916,  725,  725,
			  725, 1016,  525,  526,  527,  528,  529,  530,  531,  279,
			 1016, 1016,  279, 1016,  286,  726, 1016,  269, 1016,  525,
			  526,  527,  528,  529,  530,  531,  279, 1016, 1016,  279,
			 1016,  286, 1016,  279,  269, 1016,  279, 1016,  286, 1016,
			  279,  269, 1016,  279, 1016,  286, 1016, 1016,  269, 1016,
			 1016,  279, 1016, 1016,  279, 1016,  286, 1016, 1016,  269,
			 1016, 1016,  279, 1016, 1016,  279, 1016,  286, 1016,  280,
			  269, 1016,  280, 1016,  294, 1016,  280,  269, 1016,  280,

			 1016,  294, 1016,  280,  269, 1016,  280, 1016,  294, 1016,
			  280,  269, 1016,  280, 1016,  294, 1016, 1016,  269, 1016,
			 1016,  287,  288,  289,  290,  291,  292,  293,  280, 1016,
			 1016,  280, 1016,  294, 1016, 1016,  269, 1016,  287,  288,
			  289,  290,  291,  292,  293,  287,  288,  289,  290,  291,
			  292,  293,  287,  288,  289,  290,  291,  292,  293,  727,
			  727,  727, 1016,  287,  288,  289,  290,  291,  292,  293,
			  728,  728,  728, 1016,  287,  288,  289,  290,  291,  292,
			  293,  295,  296,  297,  298,  299,  300,  301,  295,  296,
			  297,  298,  299,  300,  301,  295,  296,  297,  298,  299,

			  300,  301,  295,  296,  297,  298,  299,  300,  301,  270,
			  271,  272,  273,  274,  275,  276,  729,  729,  729, 1016,
			  295,  296,  297,  298,  299,  300,  301,  280, 1016, 1016,
			  280, 1016,  294, 1016, 1016,  269, 1016, 1016, 1016,  547,
			 1016, 1016,  546, 1016, 1016, 1016,  106,  158, 1016,  546,
			 1016,  759, 1016,  106, 1016, 1016,  546,  158, 1016, 1016,
			  547,  158, 1016,  546,  158,  118,  731,  731,  731,  731,
			  106, 1016, 1016,  546,  158, 1016,  749,  106, 1016,  163,
			  546, 1016, 1016,  760,  106, 1016,  118,  546, 1016,  163,
			 1016,  106, 1016,  163,  546, 1016,  163,  969,  969,  969,

			  969, 1016,  106, 1016, 1016,  546,  163, 1016,  750,  974,
			  974,  974,  974, 1016, 1016,  730,  730,  730, 1016,  295,
			  296,  297,  298,  299,  300,  301,  313,  314,  315,  316,
			  317,  318,  319,  313,  314,  315,  316,  317,  318,  319,
			  313,  314,  315,  316,  317,  318,  319,  313,  314,  315,
			  316,  317,  318,  319, 1016, 1016, 1016,  313,  314,  315,
			  316,  317,  318,  319,  313,  314,  315,  316,  317,  318,
			  319,  313,  314,  315,  316,  317,  318,  319,  313,  314,
			  315,  316,  317,  318,  319,  732,  732,  732, 1016,  313,
			  314,  315,  316,  317,  318,  319,  106, 1016, 1016,  546,

			  741,  741,  741,  741,  745,  745,  745,  745, 1016,  106,
			  756,  163,  107,  163,  595,  747, 1016,  599,  599,  600,
			  600, 1016,  106,  163, 1016,  107, 1016, 1016,  151,  106,
			 1016, 1016,  107, 1016, 1016, 1016,  106, 1016, 1016,  107,
			  596, 1016,  756,  163,  746,  163,  595, 1016, 1016,  747,
			 1016,  600,  600,  600,  600,  163, 1016,  388,  108, 1016,
			  151,  163, 1016,  774,  748,  748,  748,  748, 1016, 1016,
			  915,  108,  915,  163, 1016,  916,  916,  916,  916,  733,
			  733,  733, 1016,  313,  314,  315,  316,  317,  318,  319,
			  109,  388, 1016,  163, 1016,  774,  110,  111,  112,  113,

			  114,  115,  116,  109,  388,  163, 1016, 1016, 1016,  110,
			  111,  112,  113,  114,  115,  116,  119,  120,  121,  122,
			  123,  124,  125,  119,  120,  121,  122,  123,  124,  125,
			 1016, 1016,  608,  608,  608,  608,  163,  158,  163, 1016,
			 1016,  158, 1016, 1016,  750,  163,  754,  163,  163, 1016,
			 1016,  163,  752,  163,  158,  751, 1016,  163,  158, 1016,
			 1016, 1016,  158,  163,  753, 1016, 1016, 1016,  163,  163,
			  163, 1016,  388,  163, 1016,  158,  750,  163,  754,  163,
			  163, 1016, 1016,  163,  752,  163,  163,  752,  158,  163,
			  163, 1016,  158,  158,  163,  163,  754,  158,  755, 1016,

			  158,  163, 1016,  163,  158,  158, 1016,  163,  758,  760,
			  158,  757, 1016,  163, 1016, 1016,  163,  158,  163,  761,
			  163, 1016,  158, 1016,  163,  163,  763, 1016,  163,  163,
			  756, 1016,  163,  163, 1016,  163,  163,  163, 1016,  158,
			  758,  760,  163,  758,  163,  163,  163, 1016,  163,  163,
			  163,  762,  762,  158,  163,  764,  163,  158,  764,  765,
			  163, 1016,  163, 1016,  163,  737,  737,  737,  737,  158,
			  158,  163, 1016,  158,  163,  766,  163, 1016,  163,  839,
			  163, 1016,  163, 1016,  762,  163,  767,  764,  163,  163,
			 1016,  766,  163, 1016,  163, 1016,  163,  163, 1016,  163,

			  158,  163,  163,  768,  158,  163,  163,  766,  769,  163,
			  770,  839,  163,  163,  163,  163,  158,  158,  768, 1016,
			  158, 1016, 1016, 1016,  163,  163,  158, 1016, 1016,  163,
			  158,  163,  163,  771,  158,  768,  163, 1016,  158,  773,
			  770,  163,  770,  158,  163,  163,  163,  163,  163,  163,
			  772,  775,  163, 1016, 1016,  158,  163,  163,  163,  158,
			 1016,  163,  163,  163, 1016,  772,  163,  776, 1016, 1016,
			  163,  774,  777,  163, 1016,  163,  163,  158,  163, 1016,
			 1016,  779,  772,  776,  163,  158,  163,  163,  163,  158,
			  778,  163, 1016,  163,  158,  163,  163, 1016, 1016,  776,

			 1016,  780,  158, 1016,  778,  163, 1016,  158,  163,  163,
			  163,  158, 1016,  780, 1016, 1016,  163,  163,  163, 1016,
			  163,  163,  778,  163,  158,  163,  163,  781,  163, 1016,
			 1016, 1016,  782,  780,  163,  163,  163,  158,  163,  163,
			  163,  783,  163,  163,  784, 1016, 1016, 1016,  163, 1016,
			 1016,  163,  163,  163,  158,  163,  163,  163,  158,  782,
			 1016,  158,  158,  163,  782,  158,  785,  163,  163,  163,
			  163, 1016, 1016,  784,  786,  158,  784,  163,  158,  163,
			  163, 1016, 1016,  163,  787,  163,  163,  158, 1016,  163,
			  163,  158, 1016,  163,  163,  163, 1016,  163,  786, 1016,

			  163,  158,  163, 1016,  791,  158,  786,  163, 1016,  163,
			  163,  163,  788,  163, 1016,  163,  788, 1016,  158,  163,
			 1016,  163,  158,  163,  789,  790,  793, 1016, 1016,  163,
			 1016,  163,  163,  163,  163,  792,  792,  163, 1016,  158,
			 1016,  163, 1016, 1016,  788,  163,  794,  163, 1016, 1016,
			  163, 1016, 1016,  163,  163,  163,  790,  790,  794, 1016,
			  158,  163,  158,  163,  158,  163,  158,  792,  163, 1016,
			  163,  163,  158,  163,  796, 1016,  158,  795,  794,  158,
			  163,  163,  158,  163,  158,  163,  158,  163,  158,  158,
			 1016, 1016,  163,  163,  163,  797,  163,  163,  163,  158,

			  163,  158,  163, 1016,  163,  798,  796,  163,  163,  796,
			 1016,  163,  163,  163,  163,  163,  163,  163,  163,  158,
			  163,  163,  163,  158,  163,  163,  800,  798,  163, 1016,
			  799,  163, 1016,  163,  163, 1016,  158,  798,  163,  163,
			  163, 1016,  163, 1016,  158, 1016, 1016, 1016,  158,  163,
			 1016,  163,  163, 1016,  163,  163,  163, 1016,  800, 1016,
			  163,  158,  800, 1016,  801,  158,  163, 1016,  163,  158,
			  163, 1016,  163,  803,  163, 1016,  163,  163, 1016,  163,
			  163, 1016,  158, 1016,  163,  804,  802,  158,  163,  163,
			  163,  158,  805,  163, 1016,  158,  802,  163, 1016,  158,

			  163,  163, 1016, 1016,  158,  804, 1016,  806, 1016,  163,
			 1016,  163,  807,  163,  163,  163, 1016,  804,  802,  163,
			  163,  163,  163,  163,  806,  163, 1016,  163,  163,  158,
			  163,  163,  163,  158,  808, 1016,  163, 1016, 1016,  806,
			  163,  809, 1016, 1016,  808,  163,  158,  163, 1016, 1016,
			  158,  163,  810,  163,  158, 1016, 1016,  163,  811, 1016,
			  163,  163,  163,  163, 1016,  163,  808,  158, 1016, 1016,
			 1016,  158,  163,  810,  812,  158,  158,  163,  163,  163,
			  158, 1016,  163,  163,  810,  163,  163,  815,  158,  163,
			  812,  813,  163,  158,  163,  163, 1016, 1016,  816,  163, yy_Dummy>>,
			1, 3000, 3000)
		end

	yy_nxt_template_3 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			  163,  814, 1016,  163,  163, 1016,  812,  163,  163,  163,
			  163,  163,  163, 1016,  158,  163, 1016,  163,  158,  816,
			  163,  163, 1016,  814,  163,  163,  163,  163,  818, 1016,
			  816,  158,  163,  814,  820,  158,  163,  819,  817,  158,
			  158, 1016,  163,  163,  158,  163,  163,  163, 1016,  163,
			  163, 1016,  158, 1016, 1016,  163,  163,  821,  163,  163,
			  818, 1016,  822,  163, 1016, 1016,  820,  163,  163,  820,
			  818,  163,  163, 1016, 1016,  163,  163,  163,  158,  163,
			 1016,  163,  158,  824,  163, 1016, 1016,  163,  163,  822,
			  163,  163,  158,  823,  822,  158,  158, 1016, 1016, 1016,

			  163,  158, 1016,  158,  163,  158,  163,  158,  825,  158,
			  163,  163, 1016,  163,  163,  824,  163,  163,  158,  163,
			  158, 1016, 1016,  163,  163,  824,  826,  163,  163,  163,
			 1016, 1016,  163,  163,  163,  163,  163,  163,  163,  163,
			  826,  163,  158, 1016,  163,  163,  158,  163,  163,  163,
			  163,  163,  163,  830,  828,  163,  158,  163,  826,  158,
			  158,  163,  827, 1016,  163,  163,  163,  829,  840,  840,
			  840,  840, 1016,  158,  163, 1016,  163,  163,  163,  163,
			 1016, 1016, 1016,  501, 1016,  830,  828,  163,  163,  163,
			  501,  163,  163,  832,  828,  516,  831,  163,  158,  830,

			  158, 1016,  158,  516,  163,  163,  163,  163,  739,  163,
			  158,  516, 1016,  158,  158,  158,  163, 1016,  516,  163,
			 1016,  163, 1016,  163, 1016,  832, 1016,  158,  832,  516,
			  163, 1016,  163,  163,  163, 1016,  163, 1016,  163,  163,
			  516,  163,  163, 1016, 1016,  163,  163,  163,  163,  524,
			 1016,  163, 1016,  163, 1016,  163,  524, 1016, 1016,  163,
			 1016, 1016, 1016,  524, 1016,  163,  249,  250,  251,  252,
			  253,  254,  255,  249,  250,  251,  252,  253,  254,  255,
			  524, 1016,  517,  518,  519,  520,  521,  522,  523, 1016,
			  517,  518,  519,  520,  521,  522,  523,  524,  517,  518,

			  519,  520,  521,  522,  523,  517,  518,  519,  520,  521,
			  522,  523,  833,  833,  833,  524,  517,  518,  519,  520,
			  521,  522,  523,  834,  834,  834, 1016,  517,  518,  519,
			  520,  521,  522,  523, 1016, 1016,  525,  526,  527,  528,
			  529,  530,  531,  525,  526,  527,  528,  529,  530,  531,
			  525,  526,  527,  528,  529,  530,  531,  279, 1016, 1016,
			  279, 1016,  286, 1016, 1016,  269, 1016,  525,  526,  527,
			  528,  529,  530,  531,  106, 1016, 1016,  546, 1016, 1016,
			  835,  835,  835, 1016,  525,  526,  527,  528,  529,  530,
			  531,  106, 1016,  158,  546, 1016, 1016,  158,  836,  836,

			  836, 1016,  525,  526,  527,  528,  529,  530,  531,  279,
			  158, 1016,  279, 1016,  286, 1016,  280,  269, 1016,  280,
			 1016,  294, 1016,  280,  269,  163,  280, 1016,  294,  163,
			 1016,  269,  844,  844,  844,  844,  847,  847,  847,  847,
			 1016, 1016,  163, 1016,  106, 1016, 1016,  546, 1016,  287,
			  288,  289,  290,  291,  292,  293,  118,  837,  837,  837,
			  837,  313,  314,  315,  316,  317,  318,  319,  923,  923,
			  923,  923,  845, 1016, 1016, 1016,  746, 1016,  313,  314,
			  315,  316,  317,  318,  319, 1016,  850, 1016,  608,  608,
			  608,  608,  925, 1016,  925, 1016, 1016,  923,  923,  923,

			  923,  287,  288,  289,  290,  291,  292,  293,  295,  296,
			  297,  298,  299,  300,  301,  295,  296,  297,  298,  299,
			  300,  301, 1016, 1016,  843,  843,  843,  843,  150, 1016,
			 1016,  313,  314,  315,  316,  317,  318,  319,  595,  843,
			  843,  843,  843,  163,  158,  163, 1016,  163,  158,  163,
			  158, 1016, 1016,  849,  158,  163,  163, 1016,  852,  163,
			 1016,  158, 1016,  851,  596, 1016, 1016,  158,  163, 1016,
			  595,  163,  163,  163,  163,  163,  163,  163, 1016,  163,
			  163,  163,  163,  163,  163,  849,  163,  163,  163, 1016,
			  852,  163,  158,  163,  158,  852,  158,  158,  158,  163,

			  163,  158, 1016,  163,  163,  163,  163, 1016, 1016,  158,
			 1016,  158, 1016, 1016,  853,  163,  163, 1016, 1016,  163,
			 1016,  163, 1016, 1016,  163,  854,  163, 1016,  163,  163,
			  163,  163,  158,  163, 1016,  857,  855, 1016, 1016,  858,
			  856,  163,  163,  163,  163, 1016,  854, 1016,  158,  158,
			 1016,  163,  158,  163,  163, 1016, 1016,  854,  163, 1016,
			  860,  859,  158,  163,  163,  158,  158,  857,  857, 1016,
			  163,  858,  858,  163,  163,  163,  163, 1016,  158,  158,
			  163,  163,  158,  158,  163,  163,  163,  158,  863,  163,
			  163,  872,  860,  860,  163,  861, 1016,  163,  163, 1016,

			  158,  163,  163, 1016, 1016,  163,  163,  163,  163,  158,
			  163,  163,  862,  865,  163,  163,  864,  163,  163,  163,
			  864,  163,  163,  872,  163, 1016,  158,  862,  866, 1016,
			 1016, 1016,  163,  163,  163,  163, 1016,  163,  163, 1016,
			  163,  163, 1016, 1016,  862,  866, 1016,  163,  864, 1016,
			  163,  158, 1016, 1016,  163,  158,  163, 1016,  163,  158,
			  866,  158,  867,  158,  868,  158,  163,  163,  158,  163,
			  869, 1016,  163,  163,  163,  163,  158, 1016,  158,  163,
			  163,  870,  163,  163,  163,  163,  158,  163, 1016, 1016,
			  158,  163,  163,  163,  868,  163,  868,  163, 1016,  871,

			  163, 1016,  870,  158,  163,  163,  163,  163,  163, 1016,
			  163,  158,  163,  870,  163,  158,  163,  163,  163, 1016,
			 1016,  163,  163,  163,  163,  158, 1016,  874,  873,  158,
			 1016,  872,  163,  163,  876,  163, 1016,  158,  875,  878,
			 1016,  877,  158,  163,  163,  158,  163,  163,  163,  158,
			 1016, 1016, 1016,  163,  158,  163, 1016,  163,  163,  874,
			  874,  163,  158, 1016,  163,  163,  876, 1016, 1016,  163,
			  876,  878, 1016,  878,  163,  158,  163,  163,  163,  158,
			  163,  163,  880,  879, 1016,  163,  163,  163, 1016,  163,
			  163,  163,  158,  882,  163,  158,  163,  163,  163,  158,

			 1016,  163, 1016,  881, 1016, 1016, 1016,  163,  163, 1016,
			 1016,  163,  158, 1016,  880,  880, 1016,  163, 1016,  163,
			 1016,  163, 1016,  163,  163,  882, 1016,  163,  163,  163,
			  163,  163,  158,  163,  883,  882,  158,  884, 1016,  158,
			  163, 1016, 1016,  158,  163, 1016,  163,  885,  163,  158,
			  886, 1016, 1016,  163, 1016,  163,  158,  158,  163,  158,
			  163,  158,  163,  887,  163,  163,  884, 1016,  163,  884,
			 1016,  163,  163, 1016,  158,  163,  158,  888,  163,  886,
			  163,  163,  886, 1016,  163,  163,  163,  163,  163,  163,
			  163,  163,  163,  163,  163,  888,  163,  163,  158,  163,

			 1016,  163,  158,  158,  163,  890,  163,  158,  163,  888,
			  163,  163,  163, 1016, 1016,  889,  163, 1016,  163,  158,
			  158,  158,  892,  158, 1016,  895,  891,  893,  163, 1016,
			  163,  163, 1016,  163,  163,  163,  158,  890,  158,  163,
			 1016, 1016,  163,  163,  163,  894, 1016,  890,  163, 1016,
			  163,  163,  163,  163,  892,  163,  896,  896,  892,  894,
			  163, 1016,  158,  163,  898,  163,  897, 1016,  163, 1016,
			  163,  163,  158,  163, 1016,  163,  158,  894, 1016,  158,
			  163, 1016,  163,  163,  976,  976,  976,  976,  896,  899,
			 1016, 1016,  163, 1016,  163,  163,  898,  163,  898, 1016,

			  163, 1016,  163,  163,  163,  163,  900,  163,  163,  158,
			  902,  163,  163,  901,  158,  163, 1016,  163,  158,  163,
			  158,  900, 1016,  163,  158,  163,  158, 1016,  163,  163,
			  163,  158,  163,  903,  163,  163,  904,  158,  900, 1016,
			  163,  163,  902, 1016,  163,  902,  163, 1016, 1016,  163,
			  163,  163,  163, 1016, 1016,  163,  163,  163,  163, 1016,
			  163,  163,  163,  163, 1016,  904,  158,  163,  904,  163,
			  158,  907,  163,  158,  163,  158,  163,  158,  908, 1016,
			  158, 1016,  906,  158,  911,  905,  163, 1016,  158,  163,
			  158,  163,  163, 1016,  163, 1016, 1016,  158,  163, 1016,

			 1016,  163,  163,  908,  163,  163,  163,  163,  163,  163,
			  908, 1016,  163, 1016,  906,  163,  912,  906,  163, 1016,
			  163,  163,  163,  163,  163,  910,  163,  158,  163,  163,
			  163,  158,  912,  163, 1016,  909,  163,  516,  158,  163,
			  163,  163,  158, 1016,  158,  516,  163, 1016,  163, 1016,
			 1016,  163,  158,  524, 1016,  158,  158,  910,  163,  163,
			  163,  524,  163,  163,  912,  913, 1016,  910, 1016,  158,
			  163,  163,  163,  163,  163, 1016,  163,  163,  163,  914,
			  163, 1016,  106,  163,  163,  546, 1016,  163,  163,  163,
			  163, 1016, 1016, 1016,  118, 1016, 1016,  914,  970, 1016,

			  970,  163, 1016,  971,  971,  971,  971, 1016, 1016,  163,
			 1016,  914, 1016, 1016, 1016,  916,  916,  916,  916, 1016,
			 1016,  163, 1016, 1016,  517,  518,  519,  520,  521,  522,
			  523, 1016,  517,  518,  519,  520,  521,  522,  523, 1016,
			  525,  526,  527,  528,  529,  530,  531, 1016,  525,  526,
			  527,  528,  529,  530,  531,  739,  920,  920,  920,  920,
			 1016, 1016,  843,  843,  843,  843, 1016, 1016, 1016,  313,
			  314,  315,  316,  317,  318,  319,  919,  923,  923,  923,
			  923,  927,  927,  927,  927, 1016,  158,  163,  158,  163,
			  158, 1016,  158, 1016, 1016,  928,  845,  158,  163,  163,

			  163,  158, 1016,  158, 1016,  158,  930,  929,  919,  158,
			  163, 1016, 1016,  158,  158, 1016, 1016,  746,  163,  163,
			  163,  163,  163,  931,  163, 1016,  158,  928, 1016,  163,
			  163,  163,  163,  163, 1016,  163,  158,  163,  930,  930,
			  935,  163,  163, 1016, 1016,  163,  163,  163,  163,  163,
			  163,  932,  158,  158,  936,  932,  158, 1016,  163,  163,
			  163,  163,  163,  163,  163,  163, 1016,  163,  163,  158,
			  934,  933,  936,  163,  163, 1016, 1016,  163, 1016,  163,
			  163,  163,  163,  932,  163,  163,  936, 1016,  163, 1016,
			 1016,  163,  163,  163,  163,  163,  163,  163, 1016,  163,

			  158,  163,  934,  934,  158,  163,  163,  158,  163,  163,
			  163,  158,  158,  163,  938,  163,  937,  158,  158, 1016,
			  163,  163,  158,  163,  158,  163, 1016, 1016, 1016,  158,
			 1016, 1016,  163,  163,  939,  158,  163, 1016,  158,  163,
			  163, 1016,  163,  163,  163,  163,  938,  163,  938,  163,
			  163,  158,  163,  163,  163,  163,  163,  163,  940,  158,
			  163,  163,  163,  941, 1016,  163,  940,  163,  942,  163,
			  163,  163,  163, 1016, 1016,  163,  158,  163, 1016, 1016,
			  158,  163, 1016,  163,  158, 1016,  163,  163,  163, 1016,
			  940,  163,  163,  944,  163,  942, 1016,  158,  163, 1016,

			  942,  163, 1016,  163,  163, 1016,  158,  163,  163,  163,
			  158, 1016,  163,  163, 1016,  163,  163,  946,  163,  163,
			  163, 1016,  158,  158,  943,  944,  158,  163, 1016,  163,
			  163, 1016,  163,  158,  163,  945, 1016,  158,  163,  158,
			  948, 1016,  163, 1016,  163, 1016, 1016,  163, 1016,  946,
			  158, 1016,  947, 1016,  163,  163,  944, 1016,  163,  163,
			  923,  923,  923,  923,  163,  163,  163,  946, 1016,  163,
			  158,  163,  948,  163,  158,  163,  163,  952, 1016,  951,
			 1016,  950,  163,  158,  948,  163, 1016,  158,  163,  949,
			  163,  158, 1016, 1016, 1016,  158,  158, 1016, 1016, 1016,

			  163, 1016,  163, 1016, 1016,  163,  163,  163,  158,  952,
			  953,  952, 1016,  950, 1016,  163, 1016,  163, 1016,  163,
			  163,  950,  163,  163, 1016, 1016,  158,  163,  163,  163,
			  158,  163,  163, 1016,  158, 1016, 1016,  954,  158, 1016,
			  163,  163,  954,  158,  955,  163, 1016,  163,  163, 1016,
			  163,  158,  956, 1016, 1016,  158, 1016,  163,  163,  158,
			  163,  163,  163,  163, 1016, 1016,  163, 1016,  957,  954,
			  163, 1016,  158,  163, 1016,  163,  956,  163, 1016,  163,
			  163, 1016,  163,  163,  956, 1016,  163,  163,  958,  163,
			  158,  163,  163,  163,  158,  960, 1016,  158,  163, 1016,

			  958,  158,  158,  959,  163,  163,  961,  158, 1016,  163,
			 1016,  163, 1016, 1016,  158, 1016, 1016, 1016,  163,  158,
			  958,  163,  163, 1016, 1016,  163,  163,  960,  158,  163,
			  163, 1016,  158,  163,  163,  960, 1016,  163,  962,  163,
			  962,  163,  163,  163,  163,  158,  163,  163,  158,  163,
			 1016,  163,  158,  163,  163,  163, 1016,  163,  158,  163,
			  163,  163,  158,  163,  163,  158,  158,  163, 1016, 1016,
			  158, 1016,  962,  163,  163,  158,  163,  163, 1016,  163,
			  163,  163, 1016,  158,  163,  963,  163,  163, 1016,  163,
			  163,  163, 1016,  163,  163,  163, 1016,  163,  163,  163,

			 1016,  163,  163,  163,  158,  163,  158,  163,  158,  964,
			  158, 1016,  163,  163,  966,  163,  163,  964,  163,  965,
			 1016,  158,  158,  158,  163, 1016,  158, 1016,  163, 1016,
			  158, 1016, 1016,  163,  158,  163,  163, 1016,  163,  158,
			  163,  964,  163, 1016,  163,  163,  966,  158,  163,  967,
			  163,  966, 1016,  163,  163,  163,  163,  163,  163,  163,
			  163, 1016,  163, 1016, 1016,  968,  163, 1016,  972,  163,
			  972,  163, 1016,  973,  973,  973,  973, 1016, 1016,  163,
			 1016,  968,  973,  973,  973,  973,  163, 1016,  163,  163,
			 1016,  163,  977,  977,  977,  977, 1016,  968,  163,  158,

			 1016,  163,  978,  158,  978, 1016,  975,  979,  979,  979,
			  979,  163,  980,  981, 1016, 1016,  158,  158,  163, 1016,
			  163,  158,  845,  163,  163,  158,  163, 1016,  982,  158,
			  163,  163,  596, 1016,  158,  163,  163, 1016,  975, 1016,
			 1016, 1016,  158,  163,  981,  981, 1016, 1016,  163,  163,
			 1016, 1016,  987,  163,  163,  163,  163,  163,  163,  983,
			  983,  163, 1016,  985,  163, 1016,  163,  163,  163,  163,
			 1016,  163,  158,  163,  163,  984,  158,  158, 1016,  163,
			  163,  158,  163,  163,  987, 1016,  163, 1016,  986,  158,
			 1016,  983,  163,  158,  158,  985,  163,  158, 1016,  163,

			 1016,  163,  158,  163,  163,  163,  158,  985,  163,  163,
			  158,  163,  163,  163,  163,  163,  163, 1016,  163,  158,
			  987,  163, 1016, 1016,  163,  163,  163,  158,  163,  163,
			  989,  158,  158,  988,  163,  163,  158,  163,  163, 1016,
			 1016,  163,  163,  163,  158, 1016, 1016,  163,  163,  158,
			  163,  163, 1016,  163,  158, 1016, 1016, 1016,  158,  163,
			  163, 1016,  989,  163,  163,  989, 1016,  163,  163,  163,
			  163,  158,  163,  163,  158,  163,  163, 1016,  158,  163,
			  158,  163,  163, 1016,  992,  163,  163,  990, 1016,  993,
			  163,  158, 1016,  163, 1016,  991,  163,  158,  163, 1016,

			 1016, 1016,  163,  163,  163,  163,  163, 1016,  163,  158,
			  163, 1016,  163,  996,  163, 1016,  993, 1016,  158,  991,
			 1016,  993,  158,  163, 1016,  163,  158,  991,  163,  163,
			  163,  163,  994,  163,  995,  158, 1016,  163, 1016, 1016,
			  163,  163,  997,  163, 1016,  997, 1016, 1016, 1016,  163,
			  163,  163, 1016,  158,  163,  998,  158,  158,  163, 1016,
			  158,  163, 1016,  163,  995,  163,  995,  163, 1016,  999,
			  158, 1016, 1016,  158,  997,  163, 1016, 1016,  163, 1016,
			  163,  163,  163,  163,  163,  163, 1016,  999,  163,  163,
			  163,  158,  163,  163,  163, 1000,  971,  971,  971,  971,

			 1001,  999,  163, 1016, 1016,  163, 1016,  163,  158,  163,
			  163,  158,  163,  158,  163, 1002,  163,  158, 1016,  163,
			 1016, 1016,  163,  163, 1016, 1016,  163, 1001,  158, 1003,
			  158, 1016, 1001, 1016, 1016, 1016,  163, 1016,  163,  163,
			  163,  163,  163,  163,  163,  163, 1016, 1003,  163,  163,
			 1016,  163, 1016, 1016,  163, 1004, 1004, 1004, 1004, 1016,
			  163, 1003,  163,  973,  973,  973,  973, 1016,  163, 1016,
			  163, 1016, 1016, 1016,  163, 1016,  163, 1016, 1016, 1016,
			  163,  973,  973,  973,  973, 1016,  163, 1005, 1005, 1005,
			 1005, 1006, 1016, 1006, 1016,  739, 1007, 1007, 1007, 1007,

			  922,  922,  922,  922,  979,  979,  979,  979, 1008, 1008,
			 1008, 1008, 1016,  158,  975, 1016, 1016,  158,  158,  163,
			 1016,  163,  158, 1016,  163,  158,  163, 1016, 1016,  158,
			  158,  163,  163, 1016,  163,  158,  163, 1016, 1016, 1016,
			  596, 1016,  158,  158,  163,  163,  975,  158,  746,  163,
			  163,  163, 1016,  163,  163,  158,  163,  163,  163,  158,
			  158,  163,  163,  163,  163, 1016,  163,  163,  163,  163,
			 1016,  163,  158, 1016,  163,  163,  163, 1016,  163,  163,
			  163,  163, 1016,  163, 1016,  163,  163,  163,  163,  158,
			  163,  163,  163,  158, 1010,  163, 1016, 1016,  163, 1016,

			 1016,  163, 1016,  163,  163, 1016,  158,  158, 1009, 1016,
			  163,  158,  163,  163, 1016,  163, 1016,  163,  163,  158,
			  163,  163,  163,  158,  158,  163, 1010,  163,  158,  163,
			  163,  163,  158,  158, 1016, 1012, 1011, 1013,  163,  163,
			 1010,  163,  163,  163,  163,  158, 1016, 1016, 1016,  158,
			  158,  163, 1016,  158,  163,  163,  163, 1016, 1016, 1016,
			  163,  163, 1016,  163,  163,  163,  158, 1012, 1012, 1014,
			 1016, 1014, 1016,  163,  163,  158,  163,  163,  163,  158,
			  163,  163,  163, 1016, 1016,  163,  163,  163, 1016,  163,
			  163, 1016,  158,  163, 1016,  163, 1016, 1016,  163,  163,

			 1016, 1016, 1016, 1014, 1016,  163, 1016,  163, 1016, 1016,
			  163,  163,  163,  969,  969,  969,  969, 1016,  163,  163,
			  163,  163,  163, 1016,  163,  163, 1016,  163, 1016, 1016,
			  163,  163, 1007, 1007, 1007, 1007, 1016,  163, 1015, 1015,
			 1015, 1015,  976,  976,  976,  976, 1016,  158, 1016, 1016,
			  163,  158,  163,  739,  158,  163,  158,  163,  158, 1016,
			  158, 1016,  163,  163,  158,  163, 1016,  163, 1016, 1016,
			 1016,  158, 1016,  158, 1016,  163, 1016, 1016,  845,  163,
			 1016, 1016,  746,  163, 1016, 1016,  163,  163,  163,  163,
			  163, 1016,  163, 1016, 1016,  163,  163,  163, 1016,  163,

			 1016, 1016, 1016,  163, 1016,  163, 1016,  163, 1005, 1005,
			 1005, 1005,  146,  146,  146,  146,  146,  146,  146,  146,
			  146,  146,  146,  146,  163,  163,  163,  163,  163,  163,
			  163,  163,  163,  163,  163, 1016,  163,  382,  382,  382,
			  382,  382,  382,  382,  382,  382,  382,  382,  845,   86,
			   86,   86,   86,   86,   86,   86,   86,   86,   86,   86,
			   86,   86,   86,   86,   86,   86,   86,   86,   86,   86,
			   86,  105,  105, 1016,  105,  105,  105,  105,  105,  105,
			  105,  105,  105,  105,  105,  105,  105,  105,  105,  105,
			  105,  105,  105,  117, 1016, 1016, 1016, 1016, 1016, 1016,

			  117,  117,  117,  117,  117,  117,  117,  117,  117,  117,
			  117,  117,  117,  117,  117,  118,  118, 1016,  118,  118,
			  118,  118,  118,  118,  118,  118,  118,  118,  118,  118,
			  118,  118,  118,  118,  118,  118,  118,  126,  126,  126,
			  126,  126,  126,  126,  126,  126,  126,  126,  126,  126,
			  126,  126,  126,  126,  126,  126,  126,  126,  126,  248,
			  248, 1016,  248,  248,  248, 1016, 1016,  248,  248,  248,
			  248,  248,  248,  248,  248,  248,  248,  248,  248,  248,
			  248,  269, 1016, 1016,  269, 1016,  269,  269,  269,  269,
			  269,  269,  269,  269,  269,  269,  269,  269,  269,  269,

			  269,  269,  269,  283,  283, 1016,  283,  283,  283,  283,
			  283,  283,  283,  283,  283,  283,  283,  283,  283,  283,
			  283,  283,  283,  283,  283,  284,  284, 1016,  284,  284,
			  284,  284,  284,  284,  284,  284,  284,  284,  284,  284,
			  284,  284,  284,  284,  284,  284,  284,  308,  308, 1016,
			  308,  308,  308,  308,  308,  308,  308,  308,  308,  308,
			  308,  308,  308,  308,  308,  308,  308,  308,  308,  334,
			  334,  334,  334,  334,  334,  334,  334,  334,  334,  334,
			  334,  334,  334,  334,  334,  334,  334,  334,  334, 1016,
			  334,  375,  375,  375,  375,  375,  375,  375,  375, 1016, yy_Dummy>>,
			1, 3000, 6000)
		end

	yy_nxt_template_4 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			  375,  375,  375,  375,  375,  375,  375,  375,  375,  375,
			  375,  375,  375,  384,  384,  384,  384,  384,  384,  384,
			  384,  384,  384,  384,  386,  386,  386,  386,  386,  386,
			  386,  386,  386,  386,  386,  279,  279, 1016,  279,  279,
			  279, 1016,  279,  279,  279,  279,  279,  279,  279,  279,
			  279,  279,  279,  279,  279,  279,  279,  280,  280, 1016,
			  280,  280,  280, 1016,  280,  280,  280,  280,  280,  280,
			  280,  280,  280,  280,  280,  280,  280,  280,  280,  926,
			  926,  926,  926,  926,  926,  926,  926, 1016,  926,  926,
			  926,  926,  926,  926,  926,  926,  926,  926,  926,  926,

			  926,    5, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016,
			 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016,
			 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016,
			 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016,
			 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016,
			 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016,
			 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016,
			 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016,
			 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016,
			 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016,

			 1016, 1016, yy_Dummy>>,
			1, 202, 9000)
		end

	yy_chk_template: SPECIAL [INTEGER] is
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make (0, 9201)
			yy_chk_template_1 (an_array)
			yy_chk_template_2 (an_array)
			yy_chk_template_3 (an_array)
			yy_chk_template_4 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_chk_template_1 (an_array: ARRAY [INTEGER]) is
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
			   23,   24,  146,    4,    4,    4,    4,   22, 1005,   24,
			   26,  976,   26,   26,   26,   26,   30,   30,   32,   32,
			  969,   12,  736,   26,   12,   79,   79,   79,   15,   82,
			   82,   15,  151,  380,   27,   16,   27,   27,   27,   27,
			  171,  171,   16,   16,  146,   40,  606,    3,   64,   40,
			   64,  604,   26,  131,  602,   26,   81,   81,   81,    4,
			   64,  386,   40,   57,   57,   57,   57,   57,   57,   57,
			   12,   83,   83,   83,  151,  380,   27,   40,    3,  384,
			   64,   40,   64,    3,    3,    3,    3,    3,    3,    3,

			    4,  133,   64,  382,   40,    4,    4,    4,    4,    4,
			    4,    4,   12,   84,   84,   84,  259,  259,   12,   12,
			   12,   12,   12,   12,   12,   15,   15,   15,   15,   15,
			   15,   15,   16,   16,   16,   16,   16,   16,   16,   16,
			   16,   16,   16,   25,  131,   25,   25,   25,   25,  364,
			   43,   45,  339,  339,   43,   45,   25,   25,   35,   37,
			   35,  363,   37,   35,   43,   35,   37,   43,   45,   37,
			   35,  136,   37,  362,  361,   37,  147,  147,   25,  360,
			  133,  133,   43,   45,  359,   25,   43,   45,   25,   25,
			   35,   37,   35,  358,   37,   35,   43,   35,   37,   43,

			   45,   37,   35,  357,   37,  356,  355,   37,  354,  353,
			   25,   34,   34,   34,   34,  352,  147,  168,  168,  168,
			  351,   34,   34,   34,   34,   34,   34,   34,   34,   34,
			   34,   34,   34,   34,   34,   34,   34,   34,   34,   34,
			   34,   34,   34,   34,   34,   34,   34,  170,  170,  170,
			  136,   34,  350,   34,   34,   34,   34,   34,   34,   34,
			   34,   34,   34,   34,   34,   34,   34,   34,   34,   34,
			   34,   34,   34,   34,   34,   34,   34,   34,   34,   46,
			  172,  172,  172,   46,  842,   34,   34,   34,   34,   34,
			   34,   34,   36,   36,  349,  347,   46,   36,  346,   36,

			   36,   47,   38,   36,   36,   47,   36,   38,  345,   38,
			  842,   46,  344,  343,   38,   46,  842,  342,   47,   38,
			   47,  173,  173,  173,   36,   36,  381,  381,   46,   36,
			  337,   36,   36,   47,   38,   36,   36,   47,   36,   38,
			  281,   38,  262,   39,  601,  601,   38,   39,  922,   39,
			   47,   38,   47,  257,   39,  174,   39,   41,   41,  169,
			   39,   39,  129,   41,   41,   41,  381,  103,   42,  102,
			   41,  101,   42,  100,  922,   39,   42,   88,   85,   39,
			  922,   39,   42,   80,  601,   42,   39,   54,   39,   41,
			   41,   33,   39,   39,   48,   41,   41,   41,   48,   28,

			   42,   48,   41,   11,   42,   44,   44,   10,   42,   44,
			    9,   48,  130,    8,   42,   49,   44,   42,   44,   49,
			    7,    5,   44,    0,    0,   50,   48,   51,   49,   50,
			   48,   51,   49,   48,   51,    0,    0,   44,   44,   50,
			    0,   44,   50,   48,   51,    0,    0,   49,   44,    0,
			   44,   49,    0,    0,   44,    0,    0,   50,   52,   51,
			   49,   50,   52,   51,   49,   59,   51,   67,    0,   67,
			   67,   50,   52,   58,   50,   52,   51,    0,   58,   67,
			   58,   66,    0,    0,   66,   58,   66,   66,  132,    0,
			   52,  130,  130,  130,   52,    0,   66,   59,   61,   67,

			    0,   67,   67,    0,   52,   58,    0,   52,   61,    0,
			   58,   67,   58,   66,    0,    0,   66,   58,   66,   66,
			    0,   59,   59,   59,   59,   59,   59,   59,   66,    0,
			   61,   58,   58,   58,   58,   58,   58,   58,   60,    0,
			   61,    0,   60,  134,   69,   60,   69,    0,   60,    0,
			   69,   60,   87,    0,   87,   87,   69,    0,   61,   61,
			   61,   61,   61,   61,   61,    0,    0,  132,  132,  132,
			   60,    0,    0,   62,   60,   62,   69,   60,   69,    0,
			   60,    0,   69,   60,    0,   62,    0,    0,   69,    0,
			   90,    0,   90,   90,    0,   60,   60,   60,   60,   60,

			   60,   60,   63,   65,    0,   62,   63,   62,   87,   65,
			   65,   65,    0,   63,    0,   63,   65,   62,    0,   63,
			    0,   65,  134,  134,  134,   63,   62,   62,   62,   62,
			   62,   62,   62,    0,   63,   65,    0,    0,   63,   87,
			   68,   65,   65,   65,    0,   63,   90,   63,   65,    0,
			   68,   63,   68,   65,   70,    0,   68,   63,   73,   71,
			   73,   70,   68,   70,    0,   72,   71,    0,   71,   72,
			   73,   72,   68,   70,   71,   72,    0,   90,   71,    0,
			    0,   72,   68,    0,   68,    0,   70,    0,   68,    0,
			   73,   71,   73,   70,   68,   70,    0,   72,   71,    0,

			   71,   72,   73,   72,   74,   70,   71,   72,   75,    0,
			   71,    0,   75,   72,   75,   74,    0,   74,   74,   76,
			    0,   76,   76,   89,   75,   89,   89,   74,    0,    0,
			   91,   76,  135,   91,    0,   91,   74,    0,   91,    0,
			   75,  256,  256,  256,   75,    0,   75,   74,    0,   74,
			   74,   76,   92,   76,   76,   92,   75,   92,    0,   74,
			   92,    0,    0,   76,   86,   86,   86,   86,   86,   86,
			   86,   93,   93,   93,   93,   93,   93,   93,   94,   89,
			   94,   94,   94,   94,   94,   94,   94,   95,   95,   95,
			  126,   95,   95,   95,   95,   95,   95,   95,   96,   96,

			    0,    0,   96,   96,   96,   96,   96,   96,   96,    0,
			   89,  135,  135,  135,    0,   89,   89,   89,   89,   89,
			   89,   89,   91,   91,   91,   91,   91,   91,   91,   97,
			   97,   97,    0,   97,   97,   97,   97,   97,   97,   97,
			  105,    0,    0,  105,   92,   92,   92,   92,   92,   92,
			   92,   98,   98,   98,    0,   98,   98,   98,   98,   98,
			   98,   98,   99,  258,  258,  258,   99,   99,   99,   99,
			   99,   99,   99,  126,  126,  126,  126,  126,  126,  126,
			  127,  127,  127,  127,  127,  127,  127,    0,    0,  105,
			  260,  260,  260,  108,    0,  108,  108,    0,  108,    0,

			  144,  108,  144,  144,  144,  144,  109,    0,  109,  109,
			    0,  109,    0,  144,  109,    0,  148,  148,  148,    0,
			    0,  105,  261,  261,  261,    0,    0,  105,  105,  105,
			  105,  105,  105,  105,  107,    0,    0,  107,  107,  107,
			  107,    0,  144,    0,    0,  144,  107,  108,  110,    0,
			    0,  110,    0,  107,    0,  107,  148,  107,  107,  107,
			  109,    0,  107,  111,  107,    0,  111,    0,  107,    0,
			  107,    0,    0,  107,  107,  107,  107,  107,  107,  108,
			    0,  112,    0,    0,  112,  108,  108,  108,  108,  108,
			  108,  108,  109,  118,    0,    0,  118,  110,  109,  109,

			  109,  109,  109,  109,  109,  263,  263,  263,  113,    0,
			    0,  113,  111,  264,  264,  264,  265,  265,  265,    0,
			    0,  107,  107,  107,  107,  107,  107,  107,  114,  110,
			  112,  114,  266,  266,  266,  110,  110,  110,  110,  110,
			  110,  110,  119,    0,  111,  119,    0,    0,  111,    0,
			  111,  111,  111,  111,  111,  111,  111,  113,  115,    0,
			    0,  115,  112,    0,  112,  112,  112,    0,  112,  112,
			  112,  112,  112,  112,  112,  116,    0,  114,  116,    0,
			  118,  118,  118,  118,  118,  118,  118,  120,    0,  113,
			  120,  113,  113,    0,    0,  113,  113,  113,  113,  113,

			  113,  113,  121,    0,    0,  121,    0,  115,    0,  114,
			    0,  114,  114,  114,    0,  114,  114,  114,  114,  114,
			  114,  114,  122,    0,  116,  122,  267,  267,  267,  119,
			  119,  119,  119,  119,  119,  119,    0,  123,    0,  115,
			  123,  115,  115,  115,    0,  115,  115,  115,  115,  115,
			  115,  115,  124,    0,    0,  124,  116,    0,  116,  268,
			  268,  268,  116,  116,  116,  116,  116,  116,  116,    0,
			  125,    0,  120,  125,  120,  120,  120,  120,  120,  120,
			  120,  336,  336,  336,    0,  121,  121,  121,    0,  121,
			  121,  121,  121,  121,  121,  121,  145,    0,  145,  145,

			  145,  145,  338,  338,  338,  122,  122,    0,    0,  122,
			  122,  122,  122,  122,  122,  122,  340,  340,  340,    0,
			  123,  123,  123,    0,  123,  123,  123,  123,  123,  123,
			  123,  341,  341,  341,    0,  124,  124,  124,  145,  124,
			  124,  124,  124,  124,  124,  124,  269,  269,  269,  269,
			  269,  269,  269,  125,  248,    0,    0,  125,  125,  125,
			  125,  125,  125,  125,  128,    0,    0,  128,  128,  128,
			  128,    0,  140,  140,  140,  140,  128,  143,  143,  143,
			  143,    0,    0,  128,    0,  128,  140,  128,  128,  128,
			  128,  143,  128,    0,  128,    0,    0,  158,  128,    0,

			  128,  158,    0,  128,  128,  128,  128,  128,  128,  366,
			  366,  366,  140,  159,  158,    0,    0,  159,  140,  367,
			  367,  367,  150,  143,  150,  150,  150,  150,    0,  158,
			  159,  161,    0,  158,  161,  161,    0,  248,  248,  248,
			  248,  248,  248,  248,    0,  159,  158,    0,  161,  159,
			    0,  128,  128,  128,  128,  128,  128,  128,  149,  149,
			  149,  149,  159,  161,  150,    0,  161,  161,  149,  149,
			  149,  149,  149,  149,  160,  162,    0,    0,  160,  162,
			  161,    0,  160,    0,  163,  160,  163,  368,  368,  368,
			  164,  160,  162,  162,    0,    0,  163,  164,  149,  164,

			  149,  149,  149,  149,  149,  149,  160,  162,    0,  164,
			  160,  162,    0,    0,  160,    0,  163,  160,  163,  369,
			  369,  369,  164,  160,  162,  162,  166,  165,  163,  164,
			  165,  164,  165,  167,  166,  167,  166,  370,  370,  370,
			  167,  164,  165,    0,  175,  167,  166,    0,  175,  371,
			  371,  371,  177,  178,    0,    0,  177,  178,  166,  165,
			    0,  175,  165,  175,  165,  167,  166,  167,  166,  177,
			  178,  176,  167,  176,  165,    0,  175,  167,  166,  176,
			  175,    0,  180,  176,  177,  178,  180,  179,  177,  178,
			  181,  179,    0,  175,  181,  175,  399,  399,  399,  180,

			  179,  177,  178,  176,  179,  176,    0,  181,  383,  383,
			  383,  176,    0,    0,  180,  176,    0,    0,  180,  179,
			    0,  182,  181,  179,  183,    0,  181,    0,  182,    0,
			  182,  180,  179,    0,  188,  183,  179,  183,  188,  181,
			  182,    0,  184,  186,  184,  186,    0,  183,  383,  186,
			    0,  188,  185,  182,  184,  186,  183,    0,    0,  185,
			  182,  185,  182,  400,  400,  400,  188,  183,    0,  183,
			  188,  185,  182,    0,  184,  186,  184,  186,  189,  183,
			    0,  186,  189,  188,  185,  197,  184,  186,  189,  197,
			  189,  185,    0,  185,  187,  187,  197,    0,  187,  187,

			  189,  191,  197,  185,  190,  191,  190,  401,  401,  401,
			  189,  187,    0,    0,  189,    0,  190,  197,  191,  191,
			  189,  197,  189,  402,  402,  402,  187,  187,  197,    0,
			  187,  187,  189,  191,  197,    0,  190,  191,  190,    0,
			  194,  192,  194,  187,  192,  192,    0,  194,  190,  193,
			  191,  191,  194,  193,    0,  195,    0,    0,  192,  192,
			  403,  403,  403,  195,  193,  195,  193,    0,  193,    0,
			  195,    0,  194,  192,  194,  195,  192,  192,    0,  194,
			    0,  193,  198,    0,  194,  193,  198,  195,    0,    0,
			  192,  192,  200,    0,  200,  195,  193,  195,  193,  198,

			  193,  196,  195,  196,  200,  196,  199,  195,    0,  196,
			  199,    0,    0,  196,  198,    0,  201,  203,  198,    0,
			  199,  203,    0,  199,  200,    0,  200,  201,    0,  201,
			    0,  198,    0,  196,  203,  196,  200,  196,  199,  201,
			    0,  196,  199,    0,  202,  196,  202,  202,  201,  203,
			  204,    0,  199,  203,  204,  199,  202,    0,    0,  201,
			  206,  201,    0,    0,  206,  204,  203,  204,    0,    0,
			  220,  201,    0,    0,  220,    0,  202,  206,  202,  202,
			    0,  207,  204,  207,    0,    0,  204,  220,  202,  404,
			  404,  404,  206,  207,    0,    0,  206,  204,    0,  204,

			  205,    0,  220,  205,  205,  205,  220,  205,  208,  206,
			  208,    0,  208,  207,    0,  207,    0,  205,  205,  220,
			  208,  205,  508,  508,  508,  207,  509,  509,  509,  210,
			    0,  210,  205,    0,    0,  205,  205,  205,    0,  205,
			  208,  210,  208,  212,  208,  212,    0,  212,    0,  205,
			  205,    0,  208,  205,  209,    0,  209,  212,  209,    0,
			  212,  210,  209,  210,  209,    0,  211,    0,    0,  209,
			  211,    0,  209,  210,  209,  212,  211,  212,    0,  212,
			  510,  510,  510,  211,  213,  213,  209,  213,  209,  212,
			  209,    0,  212,    0,  209,    0,  209,  213,  211,    0,

			  214,  209,  211,  215,  209,    0,  209,  215,  211,  214,
			    0,  214,  214,    0,    0,  211,  213,  213,    0,  213,
			  215,  214,  215,    0,  224,  216,  224,  216,    0,  213,
			  217,    0,  214,  216,  217,  215,  224,  216,  219,  215,
			  219,  214,  219,  214,  214,    0,  218,  217,  217,  218,
			  218,    0,  215,  214,  215,  219,  224,  216,  224,  216,
			    0,    0,  217,  218,    0,  216,  217,    0,  224,  216,
			  219,  225,  219,    0,  219,  225,    0,    0,  218,  217,
			  217,  218,  218,  223,  221,    0,  221,  219,  225,  222,
			    0,  221,  223,  226,  223,  218,  221,  222,    0,  222,

			  226,    0,  226,  225,  223,    0,    0,  225,    0,  222,
			    0,    0,  226,    0,    0,  223,  221,    0,  221,    0,
			  225,  222,    0,  221,  223,  226,  223,    0,  221,  222,
			    0,  222,  226,    0,  226,  229,  223,    0,  249,  229,
			    0,  222,    0,    0,  226,  227,  229,  227,    0,  227,
			  229,    0,  229,  230,    0,  227,    0,  230,  227,    0,
			  227,  227,    0,  227,  511,  511,  511,  229,    0,    0,
			  230,  229,    0,  277,    0,  277,  277,  227,  229,  227,
			    0,  227,  229,    0,  229,  230,    0,  227,    0,  230,
			  227,    0,  227,  227,    0,  227,  228,    0,  228,    0,

			    0,  231,  230,  231,  228,  231,  228,    0,  232,  228,
			  232,  228,  228,  231,  232,  233,  228,    0,    0,  233,
			  232,  249,  249,  249,  249,  249,  249,  249,  228,  277,
			  228,    0,  233,  231,    0,  231,  228,  231,  228,    0,
			  232,  228,  232,  228,  228,  231,  232,  233,  228,  234,
			    0,  233,  232,  234,  235,    0,  236,    0,  236,    0,
			  277,  235,    0,  235,  233,  236,  234,    0,  236,  234,
			    0,    0,  237,  235,    0,  237,  237,  512,  512,  512,
			  237,  234,  513,  513,  513,  234,  235,    0,  236,  237,
			  236,  237,  239,  235,    0,  235,  239,  236,  234,    0,

			  236,  234,    0,    0,  237,  235,  238,  237,  237,  239,
			    0,  238,  237,    0,  238,    0,  238,  348,  348,  348,
			  348,  237,  238,  237,  239,  240,  238,    0,  239,  240,
			  514,  514,  514,  240,    0,  243,    0,    0,  238,  243,
			    0,  239,  240,  238,    0,    0,  238,  241,  238,  241,
			    0,    0,  243,  241,  238,    0,    0,  240,  238,  241,
			    0,  240,  250,  242,    0,  240,  242,  243,  242,    0,
			    0,  243,  245,  244,  240,  251,  245,    0,  242,  241,
			  244,  241,  244,    0,  243,  241,  252,    0,    0,  245,
			    0,  241,  244,    0,    0,  242,    0,  246,  242,  246,

			  242,  253,    0,  246,  245,  244,    0,    0,  245,  246,
			  242,    0,  244,  254,  244,  374,  374,  374,  374,    0,
			  278,  245,  278,  278,  244,  255,  515,  515,  515,  246,
			    0,  246,  373,    0,  373,  246,    0,  373,  373,  373,
			  373,  246,    0,  250,    0,  250,  250,  250,  250,  250,
			  250,  250,    0,    0,  251,  251,  251,    0,  251,  251,
			  251,  251,  251,  251,  251,  252,  252,    0,    0,  252,
			  252,  252,  252,  252,  252,  252,  278,  560,  560,  560,
			  253,  253,  253,    0,  253,  253,  253,  253,  253,  253,
			  253,    0,  254,  254,  254,    0,  254,  254,  254,  254,

			  254,  254,  254,  279,  255,    0,    0,  278,  255,  255,
			  255,  255,  255,  255,  255,  270,  270,  270,  270,  270,
			  270,  270,  271,  280,  271,  271,  271,  271,  271,  271,
			  271,  272,  272,  272,    0,  272,  272,  272,  272,  272,
			  272,  272,  273,  273,    0,    0,  273,  273,  273,  273,
			  273,  273,  273,  274,  274,  274,    0,  274,  274,  274,
			  274,  274,  274,  274,  275,  275,  275,    0,  275,  275,
			  275,  275,  275,  275,  275,  276,  561,  561,  561,  276,
			  276,  276,  276,  276,  276,  276,  282,    0,  282,  282,
			  279,  279,  279,  279,  279,  279,  279,  283,    0,    0,

			  283,  285,  283,  285,  285,  283,  562,  562,  562,    0,
			  280,  280,  280,  280,  280,  280,  280,  284,    0,    0,
			  284,    0,  284,    0,    0,  284,  286,  286,  286,  286,
			  286,  286,  286,  287,    0,    0,  287,    0,  287,    0,
			    0,  287,  282,  288,    0,    0,  288,    0,  288,    0,
			    0,  288,  563,  563,  563,  289,    0,  285,  289,    0,
			  289,    0,    0,  289,    0,    0,  290,    0,    0,  290,
			    0,  290,    0,  282,  290,  564,  564,  564,  282,  282,
			  282,  282,  282,  282,  282,  565,  565,  565,  285,  283,
			  283,  283,  283,  283,  283,  283,  291,    0,    0,  291,

			  377,  291,  377,    0,  291,  377,  377,  377,  377,  284,
			  284,  284,  284,  284,  284,  284,  292,    0,    0,  292,
			    0,  292,    0,    0,  292,  287,  287,  287,  287,  287,
			  287,  287,    0,  288,    0,  288,  288,  288,  288,  288,
			  288,  288,    0,  289,  289,  289,    0,  289,  289,  289,
			  289,  289,  289,  289,  290,  290,    0,    0,  290,  290,
			  290,  290,  290,  290,  290,  293,    0,    0,  293,    0,
			  293,    0,    0,  293,  294,  294,  294,  294,  294,  294,
			  294,  588,  588,  588,  291,  291,  291,    0,  291,  291,
			  291,  291,  291,  291,  291,  295,    0,    0,  295,    0,

			  295,    0,    0,  295,  292,  292,  292,    0,  292,  292,
			  292,  292,  292,  292,  292,  296,    0,    0,  296,    0,
			  296,    0,    0,  296,    0,    0,  297,    0,    0,  297,
			    0,  297,    0,    0,  297,    0,    0,  298,    0,    0,
			  298,    0,  298,    0,    0,  298,  302,  302,  302,  302,
			  302,  302,  302,  293,  589,  589,  589,  293,  293,  293,
			  293,  293,  293,  293,  299,    0,    0,  299,    0,  299,
			    0,    0,  299,    0,    0,  300,    0,    0,  300,    0,
			  300,    0,    0,  300,  615,  615,  615,  295,  295,  295,
			  295,  295,  295,  295,  301,    0,    0,  301,    0,  301,

			    0,    0,  301,    0,    0,  296,    0,  296,  296,  296,
			  296,  296,  296,  296,  297,  297,  297,    0,  297,  297,
			  297,  297,  297,  297,  297,  298,  298,    0,    0,  298,
			  298,  298,  298,  298,  298,  298,  303,  303,  303,  303,
			  303,  303,  303,  304,  304,  304,  304,  304,  304,  304,
			    0,    0,  299,  299,  299,    0,  299,  299,  299,  299,
			  299,  299,  299,  300,  300,  300,    0,  300,  300,  300,
			  300,  300,  300,  300,  305,  305,  305,  305,  305,  305,
			  305,  308,  301,    0,  308,    0,  301,  301,  301,  301,
			  301,  301,  301,  306,  306,  306,    0,  306,  306,  306, yy_Dummy>>,
			1, 3000, 0)
		end

	yy_chk_template_2 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			  306,  306,  306,  306,  307,  307,  307,    0,  307,  307,
			  307,  307,  307,  307,  307,  309,    0,    0,  309,  616,
			  616,  616,  310,    0,    0,  310,  603,  603,  603,  311,
			    0,  391,  311,    0,    0,  391,  312,    0,    0,  312,
			    0,    0,  311,  311,  311,  311,  313,    0,  391,  313,
			  372,  372,  372,  372,    0,  314,    0,  379,  314,  379,
			  379,  379,  379,  391,  372,    0,  603,  391,  308,  308,
			  308,  308,  308,  308,  308,  315,    0,    0,  315,    0,
			  391,  571,  571,  571,  571,  571,  316,    0,    0,  316,
			  372,  591,  591,  591,  591,    0,  372,  317,    0,  379,

			  317,    0,  309,  309,  309,  309,  309,  309,  309,  310,
			  310,  310,  310,  310,  310,  310,  311,  311,  311,  311,
			  311,  311,  311,  312,  312,  312,  312,  312,  312,  312,
			  713,  713,  713,  313,  313,  313,  313,  313,  313,  313,
			  314,    0,  314,  314,  314,  314,  314,  314,  314,  318,
			    0,  387,  318,  387,  387,  387,  387,    0,  315,  315,
			  315,    0,  315,  315,  315,  315,  315,  315,  315,  316,
			  316,    0,    0,  316,  316,  316,  316,  316,  316,  316,
			  317,  317,  317,    0,  317,  317,  317,  317,  317,  317,
			  317,  319,    0,  387,  319,  592,  592,  592,  592,  320,

			    0,  320,  320,    0,  320,    0,    0,  320,  593,  593,
			  593,  593,  321,    0,  321,  321,    0,  321,    0,  388,
			  321,  388,  388,  388,  388,    0,    0,  392,  714,  714,
			  714,  392,  318,  318,  318,  592,  318,  318,  318,  318,
			  318,  318,  318,    0,  392,  378,    0,  378,  378,  378,
			  378,  322,    0,  320,  322,  734,  734,  734,  378,  392,
			    0,  388,    0,  392,  323,    0,  321,  323,  596,  596,
			  596,  596,    0,    0,  319,    0,  392,    0,  319,  319,
			  319,  319,  319,  319,  319,  320,  324,  378,    0,  324,
			  378,  320,  320,  320,  320,  320,  320,  320,  321,  325,

			  322,    0,  325,    0,  321,  321,  321,  321,  321,  321,
			  321,    0,  326,  323,    0,  326,  735,  735,  735,  328,
			    0,    0,  328,  544,  544,  544,  544,  544,  544,  544,
			    0,    0,  322,  327,    0,  324,  327,    0,  322,  322,
			  322,  322,  322,  322,  322,  323,  329,    0,  325,  329,
			    0,  323,  323,  323,  323,  323,  323,  323,    0,  330,
			    0,  326,  330,    0,    0,    0,  331,  324,    0,  331,
			    0,    0,    0,  324,  324,  324,  324,  324,  324,  324,
			  325,  332,  327,    0,  332,    0,  325,  325,  325,  325,
			  325,  325,  325,  326,    0,  326,  326,  326,    0,  326,

			  326,  326,  326,  326,  326,  326,  328,  328,  328,  328,
			  328,  328,  328,    0,  327,    0,  327,  327,  327,    0,
			  327,  327,  327,  327,  327,  327,  327,  333,    0,    0,
			  333,    0,    0,  329,  329,  329,  329,  329,  329,  329,
			  597,  597,  597,  597,    0,    0,  330,  330,  330,  330,
			  330,  330,  330,  331,  331,  331,  331,  331,  331,  331,
			  739,  739,  739,  739,  332,  332,  332,    0,  332,  332,
			  332,  332,  332,  332,  332,  740,  740,  740,  740,    0,
			    0,  376,  376,  376,  376,    0,  590,  590,  590,  590,
			  390,  394,  390,  394,    0,  376,    0,    0,    0,  595,

			  590,  595,  390,  394,  595,  595,  595,  595,    0,    0,
			  333,  333,  333,    0,  333,  333,  333,  333,  333,  333,
			  333,  376,  390,  394,  390,  394,  590,  376,  385,  385,
			  385,  385,  590,  389,  390,  394,    0,  389,  385,  385,
			  385,  385,  385,  385,  393,  395,  389,    0,    0,  395,
			  389,  396,    0,  396,    0,  393,    0,  393,  742,  742,
			  742,  742,  395,  396,    0,  389,    0,  393,  385,  389,
			  385,  385,  385,  385,  385,  385,  393,  395,  389,    0,
			  397,  395,  389,  396,  397,  396,  405,  393,  397,  393,
			  405,    0,    0,  398,  395,  396,  398,  397,  398,  393,

			    0,    0,  406,  405,  406,    0,  408,  407,  398,  407,
			    0,  407,  397,    0,  406,  408,  397,  408,  405,    0,
			  397,    0,  405,    0,  407,  398,    0,  408,  398,  397,
			  398,    0,    0,  409,  406,  405,  406,  409,  408,  407,
			  398,  407,    0,  407,    0,    0,  406,  408,    0,  408,
			  409,  409,    0,    0,  411,  410,  407,  410,  411,  408,
			    0,    0,  410,    0,  412,  409,  412,  410,  413,  409,
			    0,  411,  413,    0,  412,  411,  412,  744,  744,  744,
			  744,    0,  409,  409,    0,  413,  411,  410,    0,  410,
			  411,    0,    0,  415,  410,    0,  412,  415,  412,  410,

			  413,  414,    0,  411,  413,    0,  412,  411,  412,  416,
			  415,  416,  414,    0,  414,  416,    0,  413,  417,  418,
			    0,  416,  417,  418,  414,  415,    0,    0,  419,  415,
			  419,    0,    0,  414,    0,  417,  418,  419,  417,    0,
			  419,  416,  415,  416,  414,    0,  414,  416,    0,    0,
			  417,  418,  420,  416,  417,  418,  414,  422,    0,  420,
			  419,  420,  419,    0,  422,    0,  422,  417,  418,  419,
			  417,  420,  419,  421,    0,  423,  422,  421,    0,  423,
			    0,    0,  424,  425,  420,  425,  424,    0,    0,  422,
			  421,  420,  423,  420,    0,  425,  422,    0,  422,  424,

			    0,    0,  424,  420,  426,  421,  426,  423,  422,  421,
			    0,  423,    0,  426,  424,  425,  426,  425,  424,    0,
			    0,    0,  421,    0,  423,  427,  428,  425,    0,  427,
			  428,  424,    0,  429,  424,    0,  426,  431,  426,  427,
			    0,  431,  427,  428,  429,  426,  429,  429,  426,  433,
			    0,    0,    0,  433,  431,  431,  429,  427,  428,    0,
			    0,  427,  428,  430,    0,  429,  433,    0,  433,  431,
			  430,  427,  430,  431,  427,  428,  429,    0,  429,  429,
			    0,  433,  430,    0,    0,  433,  431,  431,  429,  432,
			    0,  432,    0,    0,    0,  430,  432,  434,  433,  434,

			  433,  432,  430,    0,  430,  434,    0,  435,    0,  434,
			    0,  435,    0,  438,  430,  438,    0,    0,  456,  435,
			  456,  432,    0,  432,  435,  438,    0,    0,  432,  434,
			  456,  434,  435,  432,  436,  436,  436,  434,  437,  435,
			    0,  434,  437,  435,    0,  438,  436,  438,  436,  437,
			  456,  435,  456,    0,  439,  437,  435,  438,  439,  441,
			    0,    0,  456,  441,  435,  440,  436,  436,  436,  440,
			  437,  439,    0,  440,  437,    0,  441,    0,  436,  442,
			  436,  437,  440,  442,    0,  443,  439,  437,    0,  443,
			  439,  441,    0,    0,  442,  441,  442,  440,    0,    0,

			  444,  440,  443,  439,    0,  440,    0,  444,  441,  444,
			    0,  442,    0,    0,  440,  442,    0,  443,    0,  444,
			  445,  443,    0,  445,  446,  445,  442,    0,  442,    0,
			    0,  446,  444,  446,  443,  445,  447,    0,  447,  444,
			  447,  444,  449,  446,    0,    0,  449,    0,  447,    0,
			    0,  444,  445,  448,    0,  445,  446,  445,    0,  449,
			    0,    0,  450,  446,  448,  446,  448,  445,  447,  450,
			  447,  450,  447,  451,  449,  446,  448,  451,  449,    0,
			  447,  450,  452,    0,    0,  448,  452,    0,    0,  453,
			  451,  449,    0,    0,  450,    0,  448,  452,  448,  452,

			  453,  450,  453,  450,    0,  451,  455,    0,  448,  451,
			  455,    0,  453,  450,  452,  454,  457,  454,  452,  454,
			  457,  453,  451,  455,    0,    0,    0,  454,    0,  452,
			  457,  452,  453,  457,  453,    0,  459,    0,  455,    0,
			  459,    0,  455,    0,  453,    0,  461,  454,  457,  454,
			  461,  454,  457,  459,  458,  455,  458,  458,  460,  454,
			  460,    0,  457,  461,  462,  457,  458,    0,  459,    0,
			  460,  462,  459,  462,  746,  746,  746,  746,  461,    0,
			    0,    0,  461,  462,    0,  459,  458,    0,  458,  458,
			  460,    0,  460,    0,    0,  461,  462,  465,  458,    0,

			    0,  465,  460,  462,  463,  462,  463,  464,  463,  463,
			  464,    0,    0,  466,  465,  462,  464,  466,  464,    0,
			  467,  463,    0,  484,  467,  484,    0,  468,  464,  465,
			  466,  468,    0,  465,    0,  484,  463,  467,  463,  464,
			  463,  463,  464,    0,  468,  466,  465,  468,  464,  466,
			  464,    0,  467,  463,  470,  484,  467,  484,  470,  468,
			  464,    0,  466,  468,  469,    0,  469,  484,  469,  467,
			    0,  470,    0,  471,    0,    0,  468,    0,  472,  468,
			  471,  469,  471,    0,  469,  472,  470,  472,  473,    0,
			  470,    0,  471,    0,    0,    0,  469,  472,  469,  473,

			  469,  473,    0,  470,    0,  471,  474,    0,  474,    0,
			  472,  473,  471,  469,  471,  474,  469,  472,  474,  472,
			  473,  475,    0,    0,  471,  841,  841,  841,  841,  472,
			  475,  473,  475,  473,    0,    0,    0,  477,  474,  475,
			  474,  477,  475,  473,    0,    0,  476,  474,  476,    0,
			  474,  478,  476,  475,  477,  478,  479,    0,  476,  480,
			    0,    0,  475,  479,  475,  479,    0,    0,  478,  477,
			  480,  475,  480,  477,  475,  479,    0,  481,  476,    0,
			  476,  481,  480,  478,  476,  481,  477,  478,  479,    0,
			  476,  480,    0,  482,  481,  479,  482,  479,  482,  483,

			  478,  485,  480,  483,  480,  485,  487,  479,  482,  481,
			  487,    0,  483,  481,  480,  486,  483,  481,  485,    0,
			    0,    0,  486,  487,  486,  482,  481,    0,  482,    0,
			  482,  483,    0,  485,  486,  483,    0,  485,  487,    0,
			  482,  488,  487,    0,  483,  488,    0,  486,  483,    0,
			  485,    0,    0,  490,  486,  487,  486,  488,  488,  489,
			  490,    0,  490,  489,    0,  492,  486,  489,  492,  491,
			  492,  491,  490,  488,  491,    0,  489,  488,    0,  493,
			  492,  491,    0,  493,    0,  490,    0,  493,    0,  488,
			  488,  489,  490,    0,  490,  489,  493,  492,    0,  489,

			  492,  491,  492,  491,  490,  502,  491,    0,  489,    0,
			    0,  493,  492,  491,  498,  493,  498,  494,    0,  493,
			  494,  495,  494,  496,  495,  495,  498,    0,  493,    0,
			  499,  496,  494,  496,  499,    0,  503,    0,  495,  845,
			  845,  845,  845,  496,  504,    0,  498,  499,  498,  494,
			    0,  505,  494,  495,  494,  496,  495,  495,  498,    0,
			    0,    0,  499,  496,  494,  496,  499,  497,  506,    0,
			  495,  497,    0,    0,  500,  496,  500,    0,    0,  499,
			  497,  507,    0,    0,  497,  517,  500,    0,  502,  502,
			  502,  502,  502,  502,  502,  518,    0,    0,    0,  497,

			    0,    0,    0,  497,    0,    0,  500,  519,  500,    0,
			    0,    0,  497,    0,  525,    0,  497,    0,  500,  503,
			  503,  503,  503,  503,  503,  503,  520,  504,  504,  504,
			  504,  504,  504,  504,  505,  505,  505,  505,  505,  505,
			  505,  521,  846,  846,  846,  846,    0,  506,  506,  506,
			    0,  506,  506,  506,  506,  506,  506,  506,  522,    0,
			  507,  507,  507,    0,  507,  507,  507,  507,  507,  507,
			  507,  523,  517,  517,  517,  517,  517,  517,  517,    0,
			  518,  526,  518,  518,  518,  518,  518,  518,  518,    0,
			  519,  519,  519,  527,  519,  519,  519,  519,  519,  519,

			  519,  525,  525,  525,  525,  525,  525,  525,  528,  520,
			  520,    0,    0,  520,  520,  520,  520,  520,  520,  520,
			  529,    0,    0,    0,  521,  521,  521,    0,  521,  521,
			  521,  521,  521,  521,  521,  530,  848,  848,  848,  848,
			    0,  522,  522,  522,    0,  522,  522,  522,  522,  522,
			  522,  522,  531,    0,  523,    0,    0,    0,  523,  523,
			  523,  523,  523,  523,  523,    0,  526,    0,  526,  526,
			  526,  526,  526,  526,  526,    0,  527,  527,  527,    0,
			  527,  527,  527,  527,  527,  527,  527,  915,  915,  915,
			  915,  528,  528,    0,    0,  528,  528,  528,  528,  528,

			  528,  528,    0,  529,  529,  529,    0,  529,  529,  529,
			  529,  529,  529,  529,  916,  916,  916,  916,  530,  530,
			  530,    0,  530,  530,  530,  530,  530,  530,  530,  532,
			    0,    0,  532,    0,  532,  531,    0,  532,    0,  531,
			  531,  531,  531,  531,  531,  531,  533,    0,    0,  533,
			    0,  533,    0,  534,  533,    0,  534,    0,  534,    0,
			  535,  534,    0,  535,    0,  535,    0,    0,  535,    0,
			    0,  536,    0,    0,  536,    0,  536,    0,    0,  536,
			    0,    0,  537,    0,    0,  537,    0,  537,    0,  538,
			  537,    0,  538,    0,  538,    0,  539,  538,    0,  539,

			    0,  539,    0,  540,  539,    0,  540,    0,  540,    0,
			  541,  540,    0,  541,    0,  541,    0,    0,  541,    0,
			    0,  532,  532,  532,  532,  532,  532,  532,  542,    0,
			    0,  542,    0,  542,    0,    0,  542,    0,  533,  533,
			  533,  533,  533,  533,  533,  534,  534,  534,  534,  534,
			  534,  534,  535,  535,  535,  535,  535,  535,  535,  536,
			  536,  536,    0,  536,  536,  536,  536,  536,  536,  536,
			  537,  537,  537,    0,  537,  537,  537,  537,  537,  537,
			  537,  538,  538,  538,  538,  538,  538,  538,  539,  539,
			  539,  539,  539,  539,  539,  540,  540,  540,  540,  540,

			  540,  540,  541,  541,  541,  541,  541,  541,  541,  545,
			  545,  545,  545,  545,  545,  545,  542,  542,  542,    0,
			  542,  542,  542,  542,  542,  542,  542,  543,    0,    0,
			  543,    0,  543,    0,    0,  543,    0,    0,    0,  546,
			    0,    0,  546,    0,    0,    0,  547,  621,    0,  547,
			    0,  621,    0,  548,    0,    0,  548,  609,    0,    0,
			  549,  609,    0,  549,  621,  548,  548,  548,  548,  548,
			  550,    0,    0,  550,  609,    0,  609,  551,    0,  621,
			  551,    0,    0,  621,  552,    0,  549,  552,    0,  609,
			    0,  553,    0,  609,  553,    0,  621,  917,  917,  917,

			  917,    0,  554,    0,    0,  554,  609,    0,  609,  921,
			  921,  921,  921,    0,    0,  543,  543,  543,    0,  543,
			  543,  543,  543,  543,  543,  543,  546,  546,  546,  546,
			  546,  546,  546,  547,  547,  547,  547,  547,  547,  547,
			  548,  548,  548,  548,  548,  548,  548,  549,  549,  549,
			  549,  549,  549,  549,    0,    0,    0,  550,  550,  550,
			  550,  550,  550,  550,  551,  551,  551,  551,  551,  551,
			  551,  552,  552,  552,  552,  552,  552,  552,  553,  553,
			  553,  553,  553,  553,  553,  554,  554,  554,    0,  554,
			  554,  554,  554,  554,  554,  554,  555,    0,    0,  555,

			  594,  594,  594,  594,  598,  598,  598,  598,    0,  556,
			  618,  618,  556,  618,  594,  599,    0,  599,  599,  599,
			  599,    0,  557,  618,    0,  557,    0,    0,  599,  558,
			    0,    0,  558,    0,    0,    0,  559,    0,    0,  559,
			  594,    0,  618,  618,  598,  618,  594,    0,    0,  600,
			    0,  600,  600,  600,  600,  618,    0,  599,  556,    0,
			  599,  637,  607,  637,  607,  607,  607,  607,    0,    0,
			  839,  557,  839,  637,    0,  839,  839,  839,  839,  555,
			  555,  555,    0,  555,  555,  555,  555,  555,  555,  555,
			  556,  600,    0,  637,    0,  637,  556,  556,  556,  556,

			  556,  556,  556,  557,  607,  637,    0,    0,    0,  557,
			  557,  557,  557,  557,  557,  557,  558,  558,  558,  558,
			  558,  558,  558,  559,  559,  559,  559,  559,  559,  559,
			  608,    0,  608,  608,  608,  608,  610,  611,  610,    0,
			    0,  611,    0,    0,  610,  612,  614,  612,  610,    0,
			    0,  614,  612,  614,  611,  611,    0,  612,  613,    0,
			    0,    0,  613,  614,  613,    0,    0,    0,  610,  611,
			  610,    0,  608,  611,    0,  613,  610,  612,  614,  612,
			  610,    0,    0,  614,  612,  614,  611,  611,  617,  612,
			  613,    0,  617,  619,  613,  614,  613,  619,  617,    0,

			  623,  620,    0,  620,  623,  617,    0,  613,  620,  622,
			  619,  619,    0,  620,    0,    0,  622,  623,  622,  623,
			  617,    0,  625,    0,  617,  619,  625,    0,  622,  619,
			  617,    0,  623,  620,    0,  620,  623,  617,    0,  625,
			  620,  622,  619,  619,  624,  620,  624,    0,  622,  623,
			  622,  623,  624,  627,  625,  626,  624,  627,  625,  627,
			  622,    0,  626,    0,  626,  737,  737,  737,  737,  629,
			  627,  625,    0,  629,  626,  628,  624,    0,  624,  737,
			  628,    0,  628,    0,  624,  627,  629,  626,  624,  627,
			    0,  627,  628,    0,  626,    0,  626,  630,    0,  630,

			  631,  629,  627,  630,  631,  629,  626,  628,  631,  630,
			  632,  737,  628,  632,  628,  632,  633,  631,  629,    0,
			  633,    0,    0,    0,  628,  632,  635,    0,    0,  630,
			  635,  630,  631,  633,  636,  630,  631,    0,  636,  635,
			  631,  630,  632,  635,  634,  632,  634,  632,  633,  631,
			  634,  636,  633,    0,    0,  639,  634,  632,  635,  639,
			    0,  638,  635,  638,    0,  633,  636,  638,    0,    0,
			  636,  635,  639,  638,    0,  635,  634,  641,  634,    0,
			    0,  641,  634,  636,  640,  645,  640,  639,  634,  645,
			  640,  639,    0,  638,  641,  638,  640,    0,    0,  638,

			    0,  642,  645,    0,  639,  638,    0,  643,  642,  641,
			  642,  643,    0,  641,    0,    0,  640,  645,  640,    0,
			  642,  645,  640,  644,  643,  644,  641,  643,  640,    0,
			    0,    0,  644,  642,  645,  644,  647,  646,  647,  643,
			  642,  646,  642,  643,  648,    0,    0,    0,  647,    0,
			    0,  648,  642,  648,  646,  644,  643,  644,  649,  643,
			    0,  651,  649,  648,  644,  651,  649,  644,  647,  646,
			  647,    0,    0,  646,  650,  649,  648,  650,  651,  650,
			  647,    0,    0,  648,  651,  648,  646,  655,    0,  650,
			  649,  655,    0,  651,  649,  648,    0,  651,  649,    0,

			  652,  653,  652,    0,  655,  653,  650,  649,    0,  650,
			  651,  650,  652,  654,    0,  654,  651,    0,  653,  655,
			    0,  650,  657,  655,  653,  654,  657,    0,    0,  656,
			    0,  656,  652,  653,  652,  656,  655,  653,    0,  657,
			    0,  656,    0,    0,  652,  654,  658,  654,    0,    0,
			  653,    0,    0,  658,  657,  658,  653,  654,  657,    0,
			  659,  656,  661,  656,  659,  658,  661,  656,  660,    0,
			  660,  657,  665,  656,  660,    0,  665,  659,  658,  661,
			  660,  662,  669,  662,  663,  658,  669,  658,  663,  665,
			    0,    0,  659,  662,  661,  663,  659,  658,  661,  669,

			  660,  663,  660,    0,  665,  664,  660,  664,  665,  659,
			    0,  661,  660,  662,  669,  662,  663,  664,  669,  667,
			  663,  665,  666,  667,  666,  662,  668,  663,  668,    0,
			  667,  669,    0,  663,  666,    0,  667,  664,  668,  664,
			  670,    0,  670,    0,  671,    0,    0,    0,  671,  664,
			    0,  667,  670,    0,  666,  667,  666,    0,  668,    0,
			  668,  671,  667,    0,  671,  672,  666,    0,  667,  672,
			  668,    0,  670,  672,  670,    0,  671,  673,    0,  673,
			  671,    0,  672,    0,  670,  674,  673,  675,  674,  673,
			  674,  675,  675,  671,    0,  677,  671,  672,    0,  677,

			  674,  672,    0,    0,  675,  672,    0,  676,    0,  673,
			    0,  673,  677,  676,  672,  676,    0,  674,  673,  675,
			  674,  673,  674,  675,  675,  676,    0,  677,  678,  679,
			  678,  677,  674,  679,  678,    0,  675,    0,    0,  676,
			  678,  679,    0,    0,  677,  676,  679,  676,    0,    0,
			  681,  680,  680,  680,  681,    0,    0,  676,  681,    0,
			  678,  679,  678,  680,    0,  679,  678,  681,    0,    0,
			    0,  683,  678,  679,  682,  683,  684,  682,  679,  682,
			  684,    0,  681,  680,  680,  680,  681,  684,  683,  682,
			  681,  683,  685,  684,  685,  680,    0,    0,  686,  681, yy_Dummy>>,
			1, 3000, 3000)
		end

	yy_chk_template_3 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			  686,  685,    0,  683,  685,    0,  682,  683,  684,  682,
			  686,  682,  684,    0,  687,  688,    0,  688,  687,  684,
			  683,  682,    0,  683,  685,  684,  685,  688,  688,    0,
			  686,  687,  686,  685,  690,  689,  685,  689,  687,  689,
			  691,    0,  686,  690,  691,  690,  687,  688,    0,  688,
			  687,    0,  689,    0,    0,  690,  692,  691,  692,  688,
			  688,    0,  692,  687,    0,    0,  690,  689,  692,  689,
			  687,  689,  691,    0,    0,  690,  691,  690,  693,  694,
			    0,  694,  693,  694,  689,    0,    0,  690,  692,  691,
			  692,  694,  695,  693,  692,  693,  695,    0,    0,    0,

			  692,  697,    0,  699,  696,  697,  696,  699,  699,  695,
			  693,  694,    0,  694,  693,  694,  696,  698,  697,  698,
			  699,    0,    0,  694,  695,  693,  700,  693,  695,  698,
			    0,    0,  700,  697,  700,  699,  696,  697,  696,  699,
			  699,  695,  701,    0,  700,  702,  701,  702,  696,  698,
			  697,  698,  699,  704,  702,  704,  703,  702,  700,  701,
			  703,  698,  701,    0,  700,  704,  700,  703,  738,  738,
			  738,  738,    0,  703,  701,    0,  700,  702,  701,  702,
			    0,    0,    0,  711,    0,  704,  702,  704,  703,  702,
			  712,  701,  703,  706,  701,  715,  705,  704,  707,  703,

			  705,    0,  707,  716,  706,  703,  706,  708,  738,  708,
			  709,  717,    0,  705,  709,  707,  706,    0,  718,  708,
			    0,  710,    0,  710,    0,  706,    0,  709,  705,  719,
			  707,    0,  705,  710,  707,    0,  706,    0,  706,  708,
			  720,  708,  709,    0,    0,  705,  709,  707,  706,  721,
			    0,  708,    0,  710,    0,  710,  722,    0,    0,  709,
			    0,    0,    0,  723,    0,  710,  711,  711,  711,  711,
			  711,  711,  711,  712,  712,  712,  712,  712,  712,  712,
			  724,    0,  715,  715,  715,  715,  715,  715,  715,    0,
			  716,  716,  716,  716,  716,  716,  716,  725,  717,  717,

			  717,  717,  717,  717,  717,  718,  718,  718,  718,  718,
			  718,  718,  719,  719,  719,  726,  719,  719,  719,  719,
			  719,  719,  719,  720,  720,  720,    0,  720,  720,  720,
			  720,  720,  720,  720,    0,    0,  721,  721,  721,  721,
			  721,  721,  721,  722,  722,  722,  722,  722,  722,  722,
			  723,  723,  723,  723,  723,  723,  723,  727,    0,    0,
			  727,    0,  727,    0,    0,  727,    0,  724,  724,  724,
			  724,  724,  724,  724,  732,    0,    0,  732,    0,    0,
			  725,  725,  725,    0,  725,  725,  725,  725,  725,  725,
			  725,  733,    0,  749,  733,    0,    0,  749,  726,  726,

			  726,    0,  726,  726,  726,  726,  726,  726,  726,  728,
			  749,    0,  728,    0,  728,    0,  729,  728,    0,  729,
			    0,  729,    0,  730,  729,  749,  730,    0,  730,  749,
			    0,  730,  743,  743,  743,  743,  745,  745,  745,  745,
			    0,    0,  749,    0,  731,    0,    0,  731,    0,  727,
			  727,  727,  727,  727,  727,  727,  731,  731,  731,  731,
			  731,  732,  732,  732,  732,  732,  732,  732,  923,  923,
			  923,  923,  743,    0,    0,    0,  745,    0,  733,  733,
			  733,  733,  733,  733,  733,    0,  748,    0,  748,  748,
			  748,  748,  849,    0,  849,    0,    0,  849,  849,  849,

			  849,  728,  728,  728,  728,  728,  728,  728,  729,  729,
			  729,  729,  729,  729,  729,  730,  730,  730,  730,  730,
			  730,  730,    0,    0,  741,  741,  741,  741,  748,    0,
			    0,  731,  731,  731,  731,  731,  731,  731,  741,  747,
			  747,  747,  747,  750,  751,  750,    0,  752,  751,  752,
			  753,    0,    0,  747,  753,  750,  754,    0,  754,  752,
			    0,  751,    0,  753,  741,    0,    0,  753,  754,    0,
			  741,  756,  758,  756,  758,  750,  751,  750,    0,  752,
			  751,  752,  753,  756,  758,  747,  753,  750,  754,    0,
			  754,  752,  755,  751,  757,  753,  755,  759,  757,  753,

			  754,  759,    0,  756,  758,  756,  758,    0,    0,  755,
			    0,  757,    0,    0,  759,  756,  758,    0,    0,  760,
			    0,  760,    0,    0,  755,  760,  757,    0,  755,  759,
			  757,  760,  761,  759,    0,  762,  761,    0,    0,  762,
			  761,  755,  762,  757,  762,    0,  759,    0,  763,  761,
			    0,  760,  763,  760,  762,    0,    0,  760,  764,    0,
			  764,  763,  765,  760,  761,  763,  765,  762,  761,    0,
			  764,  762,  761,  766,  762,  766,  762,    0,  767,  765,
			  763,  761,  767,  769,  763,  766,  762,  769,  769,  778,
			  764,  778,  764,  763,  765,  767,    0,  763,  765,    0,

			  769,  778,  764,    0,    0,  766,  768,  766,  768,  771,
			  767,  765,  768,  771,  767,  769,  770,  766,  768,  769,
			  769,  778,  770,  778,  770,    0,  771,  767,  772,    0,
			    0,    0,  769,  778,  770,  772,    0,  772,  768,    0,
			  768,  771,    0,    0,  768,  771,    0,  772,  770,    0,
			  768,  775,    0,    0,  770,  775,  770,    0,  771,  773,
			  772,  779,  773,  773,  774,  779,  770,  772,  775,  772,
			  775,    0,  774,  776,  774,  776,  773,    0,  779,  772,
			  780,  776,  780,  775,  774,  776,  777,  775,    0,    0,
			  777,  773,  780,  779,  773,  773,  774,  779,    0,  777,

			  775,    0,  775,  777,  774,  776,  774,  776,  773,    0,
			  779,  781,  780,  776,  780,  781,  774,  776,  777,    0,
			    0,  782,  777,  782,  780,  783,    0,  782,  781,  783,
			    0,  777,  784,  782,  784,  777,    0,  785,  783,  786,
			    0,  785,  783,  781,  784,  789,  786,  781,  786,  789,
			    0,    0,    0,  782,  785,  782,    0,  783,  786,  782,
			  781,  783,  789,    0,  784,  782,  784,    0,    0,  785,
			  783,  786,    0,  785,  783,  787,  784,  789,  786,  787,
			  786,  789,  788,  787,    0,  788,  785,  788,    0,  790,
			  786,  790,  787,  792,  789,  791,  792,  788,  792,  791,

			    0,  790,    0,  791,    0,    0,    0,  787,  792,    0,
			    0,  787,  791,    0,  788,  787,    0,  788,    0,  788,
			    0,  790,    0,  790,  787,  792,    0,  791,  792,  788,
			  792,  791,  793,  790,  793,  791,  793,  794,    0,  795,
			  792,    0,    0,  795,  791,    0,  794,  795,  794,  793,
			  796,    0,    0,  796,    0,  796,  795,  797,  794,  799,
			  798,  797,  798,  799,  793,  796,  793,    0,  793,  794,
			    0,  795,  798,    0,  797,  795,  799,  800,  794,  795,
			  794,  793,  796,    0,  800,  796,  800,  796,  795,  797,
			  794,  799,  798,  797,  798,  799,  800,  796,  801,  802,

			    0,  802,  801,  803,  798,  802,  797,  803,  799,  800,
			  804,  802,  804,    0,    0,  801,  800,    0,  800,  805,
			  803,  807,  804,  805,    0,  807,  803,  805,  800,    0,
			  801,  802,    0,  802,  801,  803,  805,  802,  807,  803,
			    0,    0,  804,  802,  804,  806,    0,  801,  806,    0,
			  806,  805,  803,  807,  804,  805,  808,  807,  803,  805,
			  806,    0,  809,  808,  810,  808,  809,    0,  805,    0,
			  807,  810,  811,  810,    0,  808,  811,  806,    0,  809,
			  806,    0,  806,  810,  924,  924,  924,  924,  808,  811,
			    0,    0,  806,    0,  809,  808,  810,  808,  809,    0,

			  812,    0,  812,  810,  811,  810,  812,  808,  811,  813,
			  814,  809,  812,  813,  815,  810,    0,  814,  815,  814,
			  817,  811,    0,  818,  817,  818,  813,    0,  816,  814,
			  816,  815,  812,  815,  812,  818,  816,  817,  812,    0,
			  816,  813,  814,    0,  812,  813,  815,    0,    0,  814,
			  815,  814,  817,    0,    0,  818,  817,  818,  813,    0,
			  816,  814,  816,  815,    0,  815,  819,  818,  816,  817,
			  819,  821,  816,  823,  820,  821,  820,  823,  822,    0,
			  827,    0,  820,  819,  827,  819,  820,    0,  821,  822,
			  823,  822,  824,    0,  824,    0,    0,  827,  819,    0,

			    0,  822,  819,  821,  824,  823,  820,  821,  820,  823,
			  822,    0,  827,    0,  820,  819,  827,  819,  820,    0,
			  821,  822,  823,  822,  824,  826,  824,  825,  826,  827,
			  826,  825,  828,  822,    0,  825,  824,  833,  829,  828,
			  826,  828,  829,    0,  825,  834,  830,    0,  830,    0,
			    0,  828,  831,  835,    0,  829,  831,  826,  830,  825,
			  826,  836,  826,  825,  828,  831,    0,  825,    0,  831,
			  829,  828,  826,  828,  829,    0,  825,  832,  830,  832,
			  830,    0,  837,  828,  831,  837,    0,  829,  831,  832,
			  830,    0,    0,    0,  837,    0,    0,  831,  918,    0,

			  918,  831,    0,  918,  918,  918,  918,    0,    0,  832,
			    0,  832,    0,    0,    0,  840,  840,  840,  840,    0,
			    0,  832,    0,    0,  833,  833,  833,  833,  833,  833,
			  833,    0,  834,  834,  834,  834,  834,  834,  834,    0,
			  835,  835,  835,  835,  835,  835,  835,    0,  836,  836,
			  836,  836,  836,  836,  836,  840,  844,  844,  844,  844,
			    0,    0,  843,  843,  843,  843,    0,    0,    0,  837,
			  837,  837,  837,  837,  837,  837,  843,  847,  847,  847,
			  847,  850,  850,  850,  850,    0,  851,  852,  853,  852,
			  851,    0,  853,    0,    0,  850,  844,  855,  854,  852,

			  854,  855,    0,  851,    0,  853,  854,  853,  843,  856,
			  854,    0,    0,  856,  855,    0,    0,  847,  851,  852,
			  853,  852,  851,  856,  853,    0,  856,  850,    0,  855,
			  854,  852,  854,  855,    0,  851,  861,  853,  854,  853,
			  861,  856,  854,    0,    0,  856,  855,  857,  858,  857,
			  858,  858,  859,  861,  862,  856,  859,    0,  856,  857,
			  858,  862,  860,  862,  860,  864,    0,  864,  861,  859,
			  860,  859,  861,  862,  860,    0,    0,  864,    0,  857,
			  858,  857,  858,  858,  859,  861,  862,    0,  859,    0,
			    0,  857,  858,  862,  860,  862,  860,  864,    0,  864,

			  863,  859,  860,  859,  863,  862,  860,  865,  866,  864,
			  866,  865,  867,  870,  868,  870,  867,  863,  869,    0,
			  866,  868,  869,  868,  865,  870,    0,    0,    0,  867,
			    0,    0,  863,  868,  871,  869,  863,    0,  871,  865,
			  866,    0,  866,  865,  867,  870,  868,  870,  867,  863,
			  869,  871,  866,  868,  869,  868,  865,  870,  872,  873,
			  876,  867,  876,  873,    0,  868,  871,  869,  874,  872,
			  871,  872,  876,    0,    0,  874,  873,  874,    0,    0,
			  875,  872,    0,  871,  875,    0,  878,  874,  878,    0,
			  872,  873,  876,  878,  876,  873,    0,  875,  878,    0,

			  874,  872,    0,  872,  876,    0,  877,  874,  873,  874,
			  877,    0,  875,  872,    0,  880,  875,  880,  878,  874,
			  878,    0,  879,  877,  877,  878,  879,  880,    0,  875,
			  878,    0,  882,  881,  882,  879,    0,  881,  877,  879,
			  882,    0,  877,    0,  882,    0,    0,  880,    0,  880,
			  881,    0,  881,    0,  879,  877,  877,    0,  879,  880,
			  925,  925,  925,  925,  882,  881,  882,  879,    0,  881,
			  883,  879,  882,  884,  883,  884,  882,  886,    0,  885,
			    0,  884,  881,  885,  881,  884,    0,  883,  886,  883,
			  886,  887,    0,    0,    0,  887,  885,    0,    0,    0,

			  886,    0,  883,    0,    0,  884,  883,  884,  887,  886,
			  887,  885,    0,  884,    0,  885,    0,  884,    0,  883,
			  886,  883,  886,  887,    0,    0,  889,  887,  885,  888,
			  889,  888,  886,    0,  891,    0,    0,  888,  891,    0,
			  887,  888,  887,  889,  889,  890,    0,  890,  892,    0,
			  892,  891,  890,    0,    0,  893,    0,  890,  889,  893,
			  892,  888,  889,  888,    0,    0,  891,    0,  893,  888,
			  891,    0,  893,  888,    0,  889,  889,  890,    0,  890,
			  892,    0,  892,  891,  890,    0,  894,  893,  894,  890,
			  895,  893,  892,  896,  895,  896,    0,  897,  894,    0,

			  893,  897,  899,  895,  893,  896,  899,  895,    0,  898,
			    0,  898,    0,    0,  897,    0,    0,    0,  894,  899,
			  894,  898,  895,    0,    0,  896,  895,  896,  901,  897,
			  894,    0,  901,  897,  899,  895,    0,  896,  899,  895,
			  900,  898,  902,  898,  902,  901,  897,  900,  903,  900,
			    0,  899,  903,  898,  902,  904,    0,  904,  905,  900,
			  901,  906,  905,  906,  901,  903,  907,  904,    0,    0,
			  907,    0,  900,  906,  902,  905,  902,  901,    0,  900,
			  903,  900,    0,  907,  903,  907,  902,  904,    0,  904,
			  905,  900,    0,  906,  905,  906,    0,  903,  907,  904,

			    0,  908,  907,  908,  911,  906,  909,  905,  911,  908,
			  909,    0,  910,  908,  910,  907,  912,  907,  912,  909,
			    0,  911,  929,  909,  910,    0,  929,    0,  912,    0,
			  913,    0,    0,  908,  913,  908,  911,    0,  909,  929,
			  911,  908,  909,    0,  910,  908,  910,  913,  912,  913,
			  912,  909,    0,  911,  929,  909,  910,  914,  929,  914,
			  912,    0,  913,    0,    0,  914,  913,    0,  919,  914,
			  919,  929,    0,  919,  919,  919,  919,    0,    0,  913,
			    0,  913,  920,  920,  920,  920,  930,    0,  930,  914,
			    0,  914,  927,  927,  927,  927,    0,  914,  930,  931,

			    0,  914,  928,  931,  928,    0,  927,  928,  928,  928,
			  928,  932,  931,  932,    0,    0,  931,  933,  930,    0,
			  930,  933,  920,  932,  934,  935,  934,    0,  935,  935,
			  930,  931,  927,    0,  933,  931,  934,    0,  927,    0,
			    0,    0,  935,  932,  931,  932,    0,    0,  931,  933,
			    0,    0,  940,  933,  940,  932,  934,  935,  934,  936,
			  935,  935,    0,  938,  940,    0,  933,  936,  934,  936,
			    0,  938,  937,  938,  935,  937,  937,  939,    0,  936,
			  942,  939,  942,  938,  940,    0,  940,    0,  939,  937,
			    0,  936,  942,  941,  939,  938,  940,  941,    0,  936,

			    0,  936,  943,  938,  937,  938,  943,  937,  937,  939,
			  941,  936,  942,  939,  942,  938,  944,    0,  944,  943,
			  939,  937,    0,    0,  942,  941,  939,  945,  944,  941,
			  946,  945,  947,  945,  943,  946,  947,  946,  943,    0,
			    0,  948,  941,  948,  945,    0,    0,  946,  944,  947,
			  944,  943,    0,  948,  949,    0,    0,    0,  949,  945,
			  944,    0,  946,  945,  947,  945,    0,  946,  947,  946,
			  950,  949,  950,  948,  951,  948,  945,    0,  951,  946,
			  953,  947,  950,    0,  953,  948,  949,  951,    0,  954,
			  949,  951,    0,  952,    0,  952,  954,  953,  954,    0,

			    0,    0,  950,  949,  950,  952,  951,    0,  954,  957,
			  951,    0,  953,  957,  950,    0,  953,    0,  955,  951,
			    0,  954,  955,  951,    0,  952,  957,  952,  954,  953,
			  954,  956,  955,  956,  956,  955,    0,  952,    0,    0,
			  954,  957,  958,  956,    0,  957,    0,    0,    0,  958,
			  955,  958,    0,  959,  955,  959,  961,  959,  957,    0,
			  961,  958,    0,  956,  955,  956,  956,  955,    0,  960,
			  959,    0,    0,  961,  958,  956,    0,    0,  960,    0,
			  960,  958,  962,  958,  962,  959,    0,  959,  961,  959,
			  960,  963,  961,  958,  962,  963,  970,  970,  970,  970,

			  964,  960,  959,    0,    0,  961,    0,  964,  963,  964,
			  960,  965,  960,  967,  962,  965,  962,  967,    0,  964,
			    0,    0,  960,  963,    0,    0,  962,  963,  965,  966,
			  967,    0,  964,    0,    0,    0,  966,    0,  966,  964,
			  963,  964,  968,  965,  968,  967,    0,  965,  966,  967,
			    0,  964,    0,    0,  968,  971,  971,  971,  971,    0,
			  965,  966,  967,  972,  972,  972,  972,    0,  966,    0,
			  966,    0,    0,    0,  968,    0,  968,    0,    0,    0,
			  966,  973,  973,  973,  973,    0,  968,  974,  974,  974,
			  974,  975,    0,  975,    0,  971,  975,  975,  975,  975,

			  977,  977,  977,  977,  978,  978,  978,  978,  979,  979,
			  979,  979,    0,  980,  977,    0,    0,  980,  982,  981,
			    0,  981,  982,    0,  983,  984,  983,    0,    0,  984,
			  980,  981,  985,    0,  985,  982,  983,    0,    0,    0,
			  977,    0,  984,  986,  985,  980,  977,  986,  979,  980,
			  982,  981,    0,  981,  982,  988,  983,  984,  983,  988,
			  986,  984,  980,  981,  985,    0,  985,  982,  983,  987,
			    0,  987,  988,    0,  984,  986,  985,    0,  989,  986,
			  989,  987,    0,  993,    0,  993,  991,  988,  991,  990,
			  989,  988,  986,  990,  991,  993,    0,    0,  991,    0,

			    0,  987,    0,  987,  988,    0,  990,  992,  990,    0,
			  989,  992,  989,  987,    0,  993,    0,  993,  991,  994,
			  991,  990,  989,  994,  992,  990,  991,  993,  996,  995,
			  991,  995,  996,  998,    0,  995,  994,  998,  990,  992,
			  990,  995,  997,  992,  997,  996,    0,    0,    0, 1000,
			  998,  994,    0, 1000,  997,  994,  992,    0,    0,    0,
			  996,  995,    0,  995,  996,  998, 1000,  995,  994,  998,
			    0,  999,    0,  995,  997, 1002,  997,  996,  999, 1002,
			  999, 1000,  998,    0,    0, 1000,  997, 1001,    0, 1001,
			  999,    0, 1002, 1003,    0, 1003,    0,    0, 1000, 1001,

			    0,    0,    0,  999,    0, 1003,    0, 1002,    0,    0,
			  999, 1002,  999, 1004, 1004, 1004, 1004,    0, 1010, 1001,
			 1010, 1001,  999,    0, 1002, 1003,    0, 1003,    0,    0,
			 1010, 1001, 1006, 1006, 1006, 1006,    0, 1003, 1007, 1007,
			 1007, 1007, 1008, 1008, 1008, 1008,    0, 1009,    0,    0,
			 1010, 1009, 1010, 1004, 1011, 1012, 1013, 1012, 1011,    0,
			 1013,    0, 1010, 1014, 1009, 1014,    0, 1012,    0,    0,
			    0, 1011,    0, 1013,    0, 1014,    0,    0, 1007, 1009,
			    0,    0, 1008, 1009,    0,    0, 1011, 1012, 1013, 1012,
			 1011,    0, 1013,    0,    0, 1014, 1009, 1014,    0, 1012,

			    0,    0,    0, 1011,    0, 1013,    0, 1014, 1015, 1015,
			 1015, 1015, 1022, 1022, 1022, 1022, 1022, 1022, 1022, 1022,
			 1022, 1022, 1022, 1022, 1024, 1024, 1024, 1024, 1024, 1024,
			 1024, 1024, 1024, 1024, 1024,    0, 1024, 1031, 1031, 1031,
			 1031, 1031, 1031, 1031, 1031, 1031, 1031, 1031, 1015, 1017,
			 1017, 1017, 1017, 1017, 1017, 1017, 1017, 1017, 1017, 1017,
			 1017, 1017, 1017, 1017, 1017, 1017, 1017, 1017, 1017, 1017,
			 1017, 1018, 1018,    0, 1018, 1018, 1018, 1018, 1018, 1018,
			 1018, 1018, 1018, 1018, 1018, 1018, 1018, 1018, 1018, 1018,
			 1018, 1018, 1018, 1019,    0,    0,    0,    0,    0,    0,

			 1019, 1019, 1019, 1019, 1019, 1019, 1019, 1019, 1019, 1019,
			 1019, 1019, 1019, 1019, 1019, 1020, 1020,    0, 1020, 1020,
			 1020, 1020, 1020, 1020, 1020, 1020, 1020, 1020, 1020, 1020,
			 1020, 1020, 1020, 1020, 1020, 1020, 1020, 1021, 1021, 1021,
			 1021, 1021, 1021, 1021, 1021, 1021, 1021, 1021, 1021, 1021,
			 1021, 1021, 1021, 1021, 1021, 1021, 1021, 1021, 1021, 1023,
			 1023,    0, 1023, 1023, 1023,    0,    0, 1023, 1023, 1023,
			 1023, 1023, 1023, 1023, 1023, 1023, 1023, 1023, 1023, 1023,
			 1023, 1025,    0,    0, 1025,    0, 1025, 1025, 1025, 1025,
			 1025, 1025, 1025, 1025, 1025, 1025, 1025, 1025, 1025, 1025,

			 1025, 1025, 1025, 1026, 1026,    0, 1026, 1026, 1026, 1026,
			 1026, 1026, 1026, 1026, 1026, 1026, 1026, 1026, 1026, 1026,
			 1026, 1026, 1026, 1026, 1026, 1027, 1027,    0, 1027, 1027,
			 1027, 1027, 1027, 1027, 1027, 1027, 1027, 1027, 1027, 1027,
			 1027, 1027, 1027, 1027, 1027, 1027, 1027, 1028, 1028,    0,
			 1028, 1028, 1028, 1028, 1028, 1028, 1028, 1028, 1028, 1028,
			 1028, 1028, 1028, 1028, 1028, 1028, 1028, 1028, 1028, 1029,
			 1029, 1029, 1029, 1029, 1029, 1029, 1029, 1029, 1029, 1029,
			 1029, 1029, 1029, 1029, 1029, 1029, 1029, 1029, 1029,    0,
			 1029, 1030, 1030, 1030, 1030, 1030, 1030, 1030, 1030,    0, yy_Dummy>>,
			1, 3000, 6000)
		end

	yy_chk_template_4 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			 1030, 1030, 1030, 1030, 1030, 1030, 1030, 1030, 1030, 1030,
			 1030, 1030, 1030, 1032, 1032, 1032, 1032, 1032, 1032, 1032,
			 1032, 1032, 1032, 1032, 1033, 1033, 1033, 1033, 1033, 1033,
			 1033, 1033, 1033, 1033, 1033, 1034, 1034,    0, 1034, 1034,
			 1034,    0, 1034, 1034, 1034, 1034, 1034, 1034, 1034, 1034,
			 1034, 1034, 1034, 1034, 1034, 1034, 1034, 1035, 1035,    0,
			 1035, 1035, 1035,    0, 1035, 1035, 1035, 1035, 1035, 1035,
			 1035, 1035, 1035, 1035, 1035, 1035, 1035, 1035, 1035, 1036,
			 1036, 1036, 1036, 1036, 1036, 1036, 1036,    0, 1036, 1036,
			 1036, 1036, 1036, 1036, 1036, 1036, 1036, 1036, 1036, 1036,

			 1036, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016,
			 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016,
			 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016,
			 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016,
			 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016,
			 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016,
			 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016,
			 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016,
			 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016,
			 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016,

			 1016, 1016, yy_Dummy>>,
			1, 202, 9000)
		end

	yy_base_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,   99,  111,  521, 9101,  518,  510,  506,
			  502,  497,  124,    0, 9101,  131,  142, 9101, 9101, 9101,
			 9101, 9101,   89,   87,   92,  225,  102,  126,  472, 9101,
			  100, 9101,  101,  464,  291,  222,  356,  225,  366,  413,
			  125,  422,  438,  220,  475,  221,  349,  371,  464,  485,
			  495,  497,  528, 9101,  430, 9101, 9101,   79,  537,  527,
			  601,  564,  632,  672,  117,  668,  543,  526,  709,  603,
			  720,  725,  728,  717,  774,  771,  778, 9101, 9101,   45,
			  391,   76,   49,   91,  123,  388,  770,  650,  474,  821,
			  688,  828,  850,  777,  786,  797,  808,  839,  861,  872,

			  471,  468,  465,  462, 9101,  933, 9101, 1027,  991, 1004,
			 1041, 1056, 1074, 1101, 1121, 1151, 1168,    0, 1086, 1135,
			 1180, 1195, 1215, 1230, 1245, 1263,  879,  886, 1357,  451,
			  501,  152,  577,  190,  632,  821,  260, 9101, 9101, 9101,
			 1352, 9101, 9101, 1357,  982, 1278,   94,  256,  996, 1438,
			 1404,  124, 9101, 9101, 9101, 9101, 9101, 9101, 1367, 1383,
			 1444, 1401, 1445, 1443, 1456, 1489, 1493, 1492,  227,  367,
			  257,   60,  290,  331,  365, 1514, 1530, 1522, 1523, 1557,
			 1552, 1560, 1587, 1594, 1601, 1618, 1602, 1664, 1604, 1647,
			 1663, 1671, 1711, 1719, 1699, 1722, 1760, 1655, 1752, 1776,

			 1751, 1786, 1803, 1787, 1820, 1870, 1830, 1840, 1867, 1921,
			 1888, 1936, 1913, 1944, 1968, 1973, 1984, 2000, 2016, 2008,
			 1840, 2043, 2056, 2051, 1983, 2041, 2059, 2112, 2163, 2105,
			 2123, 2160, 2167, 2185, 2219, 2220, 2215, 2242, 2273, 2262,
			 2295, 2306, 2325, 2305, 2339, 2342, 2356, 9101, 1343, 2127,
			 2351, 2364, 2375, 2390, 2402, 2414,  751,  361,  873,  126,
			  900,  932,  352, 1015, 1023, 1026, 1042, 1136, 1169, 1252,
			 2421, 2430, 2441, 2452, 2463, 2474, 2485, 2171, 2418, 2496,
			 2516,  437, 2584, 2595, 2615, 2599, 2532, 2631, 2641, 2653,
			 2664, 2694, 2714, 2763, 2680, 2793, 2813, 2824, 2835, 2862,

			 2873, 2892, 2752, 2842, 2849, 2880, 2903, 2914, 2974, 3008,
			 3015, 3022, 3029, 3039, 3048, 3068, 3079, 3090, 3142, 3184,
			 3197, 3210, 3244, 3257, 3279, 3292, 3305, 3326, 3312, 3339,
			 3352, 3359, 3374, 3420, 9101, 9101, 1191,  338, 1212,  162,
			 1226, 1241,  327,  402,  401,  397,  387,  384, 2297,  383,
			  341,  309,  304,  298,  297,  295,  294,  292,  282,  273,
			  268,  263,  262,  250,  238, 9101, 1319, 1329, 1397, 1429,
			 1447, 1459, 3030, 2417, 2395, 9101, 3461, 2685, 3227, 3039,
			  125,  406,  143, 1588,  129, 3508,  111, 3133, 3201, 3503,
			 3449, 3001, 3197, 3514, 3450, 3515, 3510, 3550, 3555, 1506,

			 1573, 1617, 1633, 1670, 1799, 3556, 3561, 3577, 3574, 3603,
			 3614, 3624, 3623, 3638, 3671, 3663, 3668, 3688, 3689, 3687,
			 3718, 3743, 3723, 3745, 3752, 3742, 3763, 3795, 3796, 3803,
			 3829, 3807, 3848, 3819, 3856, 3877, 3893, 3908, 3872, 3924,
			 3935, 3929, 3949, 3955, 3966, 3982, 3990, 3995, 4023, 4012,
			 4028, 4043, 4052, 4059, 4074, 4076, 3877, 4086, 4113, 4106,
			 4117, 4116, 4130, 4174, 4175, 4167, 4183, 4190, 4197, 4234,
			 4224, 4239, 4244, 4258, 4265, 4289, 4305, 4307, 4321, 4322,
			 4329, 4347, 4355, 4369, 4182, 4371, 4381, 4376, 4411, 4429,
			 4419, 4428, 4427, 4449, 4479, 4491, 4490, 4537, 4473, 4500,

			 4533, 9101, 4494, 4525, 4533, 4540, 4557, 4570, 1832, 1836,
			 1890, 2074, 2187, 2192, 2240, 2336, 9101, 4578, 4588, 4600,
			 4619, 4634, 4651, 4664, 9101, 4607, 4674, 4686, 4701, 4713,
			 4728, 4745, 4827, 4844, 4851, 4858, 4869, 4880, 4887, 4894,
			 4901, 4908, 4926, 5025, 3229, 4915, 5032, 5039, 5046, 5053,
			 5063, 5070, 5077, 5084, 5095, 5189, 5202, 5215, 5222, 5229,
			 2387, 2486, 2516, 2562, 2585, 2595, 9101, 9101, 9101, 9101,
			 9101, 3062, 9101, 9101, 9101, 9101, 9101, 9101, 9101, 9101,
			 9101, 9101, 9101, 9101, 9101, 9101, 9101, 9101, 2691, 2764,
			 3466, 3071, 3175, 3188, 5180, 3484, 3248, 3420, 5184, 5197,

			 5231,  424,  104, 3006,  101,    0,   96, 5244, 5312, 5027,
			 5295, 5307, 5304, 5328, 5310, 2794, 2929, 5358, 5170, 5363,
			 5360, 5017, 5375, 5370, 5403, 5392, 5421, 5423, 5439, 5439,
			 5456, 5470, 5472, 5486, 5503, 5496, 5504, 5220, 5520, 5525,
			 5543, 5547, 5567, 5577, 5582, 5555, 5607, 5595, 5610, 5628,
			 5636, 5631, 5659, 5671, 5672, 5657, 5688, 5692, 5712, 5730,
			 5727, 5732, 5740, 5754, 5764, 5742, 5781, 5789, 5785, 5752,
			 5799, 5814, 5835, 5836, 5847, 5857, 5872, 5865, 5887, 5899,
			 5910, 5920, 5936, 5941, 5946, 5951, 5957, 5984, 5974, 6005,
			 6002, 6010, 6015, 6048, 6038, 6062, 6063, 6071, 6076, 6073,

			 6091, 6112, 6104, 6126, 6112, 6166, 6163, 6168, 6166, 6180,
			 6180, 6172, 6179, 3040, 3138, 6188, 6196, 6204, 6211, 6222,
			 6233, 6242, 6249, 6256, 6273, 6290, 6308, 6355, 6407, 6414,
			 6421, 6437, 6367, 6384, 3165, 3226,  121, 5445, 6148, 3440,
			 3455, 6504, 3538, 6412, 3657, 6416, 4154, 6519, 6468, 6363,
			 6502, 6514, 6506, 6520, 6515, 6562, 6530, 6564, 6531, 6567,
			 6578, 6602, 6601, 6618, 6617, 6632, 6632, 6648, 6665, 6653,
			 6681, 6679, 6694, 6729, 6731, 6721, 6732, 6756, 6648, 6731,
			 6739, 6781, 6780, 6795, 6791, 6807, 6805, 6845, 6844, 6815,
			 6848, 6865, 6855, 6902, 6905, 6909, 6912, 6927, 6919, 6929,

			 6943, 6968, 6958, 6973, 6969, 6989, 7007, 6991, 7022, 7032,
			 7030, 7042, 7059, 7079, 7076, 7084, 7087, 7090, 7082, 7136,
			 7133, 7141, 7148, 7143, 7151, 7197, 7187, 7150, 7198, 7208,
			 7205, 7222, 7236, 7230, 7238, 7246, 7254, 7275, 9101, 5255,
			 7295, 4305,  350, 7342, 7336, 4519, 4622, 7357, 4716, 6477,
			 7361, 7356, 7346, 7358, 7357, 7367, 7379, 7406, 7407, 7422,
			 7421, 7406, 7420, 7470, 7424, 7477, 7467, 7482, 7480, 7488,
			 7472, 7504, 7528, 7529, 7534, 7550, 7519, 7576, 7545, 7592,
			 7574, 7603, 7591, 7640, 7632, 7649, 7647, 7661, 7688, 7696,
			 7704, 7704, 7707, 7725, 7745, 7760, 7752, 7767, 7768, 7772,

			 7806, 7798, 7801, 7818, 7814, 7828, 7820, 7836, 7860, 7876,
			 7871, 7874, 7875, 7900, 7916, 4767, 4794, 5077, 7283, 7953,
			 7962, 5089,  414, 6448, 7064, 7640, 9101, 7972, 7987, 7892,
			 7945, 7969, 7970, 7987, 7983, 7995, 8026, 8042, 8030, 8047,
			 8011, 8063, 8039, 8072, 8075, 8097, 8094, 8102, 8100, 8124,
			 8129, 8144, 8152, 8150, 8155, 8188, 8190, 8179, 8208, 8223,
			 8237, 8226, 8241, 8261, 8266, 8281, 8295, 8283, 8301,   70,
			 8276, 8335, 8343, 8361, 8367, 8376,   61, 8380, 8384, 8388,
			 8383, 8378, 8388, 8383, 8395, 8391, 8413, 8428, 8425, 8437,
			 8459, 8445, 8477, 8442, 8489, 8488, 8498, 8501, 8503, 8537,

			 8519, 8546, 8545, 8552, 8593,   58, 8612, 8618, 8622, 8617,
			 8577, 8624, 8614, 8626, 8622, 8688, 9101, 8748, 8770, 8792,
			 8814, 8836, 8703, 8858, 8714, 8880, 8902, 8924, 8946, 8968,
			 8990, 8727, 9003, 9014, 9034, 9056, 9078, yy_Dummy>>)
		end

	yy_def_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0, 1016,    1, 1017, 1017, 1016, 1016, 1016, 1016, 1016,
			 1016, 1016, 1018, 1019, 1016, 1020, 1021, 1016, 1016, 1016,
			 1016, 1016, 1016, 1016, 1016, 1022, 1022, 1022, 1016, 1016,
			 1016, 1016, 1016, 1016, 1016,   34,   34,   36,   34,   34,
			   39,   34,   39,   39,   39,   39,   39,   39,   39,   39,
			   39,   39,   39, 1016, 1016, 1016, 1016, 1023, 1024, 1024,
			 1024, 1024, 1024,   62,   62,   62,   62,   62,   62,   62,
			   62,   62,   62,   62,   62,   62,   62, 1016, 1016, 1016,
			 1016, 1016, 1016, 1016, 1016, 1016, 1025, 1016, 1016, 1025,
			 1016, 1026, 1027, 1025, 1025, 1025, 1025, 1025, 1025, 1025,

			 1016, 1016, 1016, 1016, 1016, 1018, 1016, 1028, 1018, 1018,
			 1018, 1018, 1018, 1018, 1018, 1018, 1018, 1019, 1020, 1020,
			 1020, 1020, 1020, 1020, 1020, 1020, 1029, 1029, 1029, 1016,
			 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016,
			 1016, 1016, 1016, 1030, 1022, 1022, 1022, 1031, 1032, 1033,
			 1022, 1022, 1016, 1016, 1016, 1016, 1016, 1016,   39,   39,
			   39,   39,   39,   62,   62,   62,   62,   62, 1016, 1016,
			 1016, 1016, 1016, 1016, 1016,   39,   62,   39,   39,   39,
			   39,   39,   62,   62,   62,   62,   62,   39,   39,   62,
			   62,   39,   39,   39,   62,   62,   62,   39,   39,   39,

			   62,   62,   62,   39,   39,   39,   39,   62,   62,   62,
			   62,   39,   39,   62,   62,   39,   62,   39,   39,   39,
			   39,   62,   62,   62,   62,   39,   62,  205,   62,   39,
			   39,   62,   62,   39,   39,   62,   62,   39,   62,   39,
			   39,   62,   62,   39,   62,   39,   62, 1016, 1023, 1023,
			 1023, 1023, 1023, 1023, 1023, 1023, 1016, 1016, 1016, 1016,
			 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1025,
			 1025, 1025, 1025, 1025, 1025, 1025, 1025, 1016, 1016, 1034,
			 1035, 1016, 1025, 1026, 1027, 1016, 1025, 1026, 1026, 1026,
			 1026, 1026, 1026, 1026, 1025, 1027, 1027, 1027, 1027, 1027,

			 1027, 1027, 1025, 1025, 1025, 1025, 1025, 1025, 1028, 1020,
			 1020, 1028, 1028, 1028, 1028, 1028, 1028, 1028, 1028, 1028,
			 1018, 1018, 1018, 1018, 1018, 1018, 1018, 1018, 1020, 1020,
			 1020, 1020, 1020, 1020, 1016, 1016, 1016, 1016, 1016, 1016,
			 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016,
			 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016,
			 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016,
			 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1022, 1022,
			 1022, 1031, 1031, 1032, 1032, 1033, 1033, 1022, 1022,   39,
			   62,   39,   39,   62,   62,   39,   62,   39,   62, 1016,

			 1016, 1016, 1016, 1016, 1016,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   39,   62,
			   62,   39,   62,   39,   39,   62,   62,   39,   39,   62,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   39,   39,   39,   39,   62,   62,   62,   62,   62,   39,
			   62,   39,   39,   62,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   39,   39,   39,   39,
			   39,   62,   62,   62,   62,   62,   62,   39,   39,   62,
			   62,   39,   62,   39,   62,   39,   62,   39,   39,   39,
			   62,   62,   62,   39,   62,   39,   62,   39,   62,   39,

			   62, 1016, 1023, 1023, 1023, 1023, 1023, 1023, 1016, 1016,
			 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1034, 1034, 1034,
			 1034, 1034, 1034, 1034, 1016, 1035, 1035, 1035, 1035, 1035,
			 1035, 1035, 1026, 1026, 1026, 1026, 1026, 1026, 1027, 1027,
			 1027, 1027, 1027, 1027, 1025, 1025, 1028, 1028, 1028, 1028,
			 1028, 1028, 1028, 1028, 1028, 1028, 1018, 1018, 1020, 1020,
			 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016,
			 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016,
			 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016,
			 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1022,

			 1022, 1031, 1031, 1032, 1032,  385, 1033, 1022, 1022,   39,
			   62,   39,   62,   39,   62, 1016, 1016,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   39,   62,   62,   39,
			   62,   39,   62,   39,   62,   39,   39,   62,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   39,   62,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   39,   62,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,

			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62, 1023, 1023, 1016, 1016, 1034, 1034, 1034, 1034, 1034,
			 1034, 1035, 1035, 1035, 1035, 1035, 1035, 1026, 1026, 1027,
			 1027, 1028, 1028, 1028, 1016, 1016, 1016, 1016, 1016, 1016,
			 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1030, 1022,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,

			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62, 1034, 1034, 1035, 1035, 1028, 1016, 1016,
			 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016,
			 1036,   39,   62,   39,   62,   39,   39,   62,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,

			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62, 1016, 1016, 1016, 1016, 1016,
			 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62, 1016,
			 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016,
			   39,   62,   39,   62,   39,   62,   39,   62,   39,   62,
			   39,   62,   39,   62,   39,   62,   39,   62,   39,   62,

			   39,   62,   39,   62, 1016, 1016, 1016, 1016, 1016,   39,
			   62,   39,   62,   39,   62, 1016,    0, 1016, 1016, 1016,
			 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016,
			 1016, 1016, 1016, 1016, 1016, 1016, 1016, yy_Dummy>>)
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
			   85,   86,   87,   88,    8,   89,    1,    1,   90,   90,
			   90,   90,   90,   90,   90,   90,   90,   90,   90,   90,
			   90,   90,   90,   90,   91,   91,   91,   91,   91,   91,
			   91,   91,   91,   91,   91,   91,   91,   91,   91,   91,
			   92,   92,   92,   92,   92,   92,   92,   92,   92,   92,
			   92,   92,   92,   92,   92,   92,   92,   92,   92,   92,
			   92,   92,   92,   92,   92,   92,   92,   92,   92,   92,
			   92,   92,   93,   93,   94,   94,   94,   94,   94,   94,

			   94,   94,   94,   94,   94,   94,   94,   94,   94,   94,
			   94,   94,   94,   94,   94,   94,   94,   94,   94,   94,
			   94,   94,   94,   94,   95,   96,   96,   96,   96,   96,
			   96,   96,   96,   96,   96,   96,   96,   97,   98,   98,
			   93,   99,   99,   99,  100,   93,   93,   93,   93,   93,
			   93,   93,   93,   93,   93,   93,    1, yy_Dummy>>)
		end

	yy_meta_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    1,    2,    3,    4,    5,    1,    6,    1,    1,
			    7,    8,    1,    1,    1,    1,    1,    1,    9,    1,
			   10,   11,   12,   13,    1,    1,    1,    1,    1,    1,
			   10,   10,   10,   10,   10,   10,   10,   10,   10,   10,
			   10,   10,   10,   10,   10,   10,   10,   10,   10,   10,
			   10,   10,   10,   14,   15,   16,    1,    1,    1,    1,
			   17,    1,   10,   10,   10,   10,   10,   10,   10,   10,
			   10,   10,   10,   10,   10,   10,   10,   10,   10,   10,
			   10,   10,   10,   10,   10,   18,   19,   20,    1,    1,
			   21,   21,   21,   21,   22,   22,   22,   22,   22,   22,

			   22, yy_Dummy>>)
		end

	yy_accept_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    1,    1,    1,    2,    3,    4,    6,    9,   11,
			   14,   17,   20,   23,   26,   29,   32,   34,   37,   40,
			   43,   46,   49,   52,   55,   58,   62,   66,   70,   73,
			   76,   79,   82,   85,   87,   91,   95,   99,  103,  107,
			  111,  115,  119,  123,  127,  131,  135,  139,  143,  147,
			  151,  155,  159,  163,  166,  168,  171,  174,  176,  179,
			  182,  185,  188,  191,  194,  197,  200,  203,  206,  209,
			  212,  215,  218,  221,  224,  227,  230,  233,  236,  239,
			  241,  243,  245,  247,  249,  251,  253,  255,  257,  259,
			  262,  264,  266,  268,  270,  272,  274,  276,  278,  280,

			  282,  283,  284,  285,  286,  287,  288,  289,  290,  293,
			  296,  297,  298,  299,  300,  301,  302,  303,  304,  305,
			  306,  307,  308,  309,  310,  311,  312,  313,  314,  315,
			  315,  315,  315,  315,  315,  315,  315,  315,  316,  317,
			  318,  320,  321,  322,  322,  324,  326,  327,  329,  330,
			  331,  331,  333,  334,  335,  336,  337,  338,  339,  341,
			  343,  345,  347,  350,  351,  352,  353,  354,  356,  356,
			  356,  356,  356,  356,  356,  356,  358,  359,  361,  363,
			  365,  367,  369,  370,  371,  372,  373,  374,  376,  379,
			  380,  382,  384,  386,  388,  389,  390,  391,  393,  395,

			  397,  398,  399,  400,  403,  405,  407,  410,  412,  413,
			  414,  416,  418,  420,  421,  422,  424,  425,  427,  429,
			  431,  434,  435,  436,  437,  439,  441,  442,  444,  445,
			  447,  449,  450,  451,  453,  455,  456,  457,  459,  460,
			  462,  464,  465,  466,  468,  469,  471,  472,  473,  473,
			  473,  473,  473,  473,  473,  473,  473,  473,  473,  473,
			  473,  473,  473,  473,  473,  473,  473,  473,  473,  473,
			  474,  475,  476,  477,  478,  479,  480,  481,  482,  482,
			  482,  482,  483,  485,  486,  487,  488,  490,  491,  492,
			  493,  494,  495,  496,  497,  499,  500,  501,  502,  503,

			  504,  505,  506,  507,  508,  509,  510,  511,  512,  512,
			  514,  516,  516,  516,  516,  516,  516,  516,  516,  516,
			  516,  518,  520,  521,  522,  523,  524,  525,  526,  527,
			  528,  529,  530,  531,  532,  533,  535,  535,  535,  535,
			  535,  535,  535,  535,  536,  537,  538,  539,  540,  541,
			  542,  543,  544,  545,  546,  547,  548,  549,  550,  551,
			  552,  553,  554,  555,  556,  557,  558,  558,  558,  558,
			  558,  558,  558,  560,  560,  560,  561,  563,  564,  566,
			  568,  568,  571,  573,  576,  578,  581,  583,  585,  585,
			  587,  588,  590,  593,  594,  596,  599,  601,  603,  604,

			  604,  604,  604,  604,  604,  604,  607,  609,  611,  612,
			  614,  615,  617,  618,  620,  621,  623,  624,  626,  628,
			  629,  630,  632,  633,  636,  638,  640,  641,  643,  645,
			  646,  647,  649,  650,  652,  653,  655,  656,  658,  659,
			  661,  663,  665,  667,  669,  670,  671,  672,  673,  674,
			  676,  677,  679,  681,  682,  683,  686,  688,  690,  691,
			  694,  696,  698,  699,  701,  702,  704,  706,  708,  710,
			  712,  714,  715,  716,  717,  718,  719,  720,  722,  724,
			  725,  726,  728,  729,  731,  732,  734,  735,  737,  739,
			  741,  742,  743,  744,  746,  747,  749,  750,  752,  753,

			  756,  758,  759,  759,  759,  759,  759,  759,  759,  759,
			  759,  759,  759,  759,  759,  759,  759,  760,  760,  760,
			  760,  760,  760,  760,  760,  761,  761,  761,  761,  761,
			  761,  761,  761,  762,  763,  764,  765,  766,  767,  768,
			  769,  770,  771,  772,  773,  774,  775,  776,  777,  777,
			  778,  778,  778,  778,  778,  778,  778,  779,  780,  781,
			  782,  782,  782,  782,  782,  782,  782,  783,  784,  785,
			  786,  787,  788,  789,  790,  791,  792,  793,  794,  795,
			  796,  797,  798,  799,  800,  801,  802,  803,  804,  804,
			  804,  806,  806,  808,  808,  810,  810,  810,  810,  812,

			  814,  816,  816,  816,  816,  816,  816,  816,  818,  820,
			  822,  823,  825,  826,  828,  829,  829,  829,  831,  832,
			  834,  835,  837,  838,  840,  841,  843,  844,  846,  847,
			  849,  850,  853,  855,  857,  858,  860,  862,  863,  864,
			  866,  867,  869,  870,  872,  873,  876,  878,  880,  881,
			  883,  884,  886,  887,  889,  890,  892,  893,  895,  896,
			  898,  899,  902,  904,  906,  907,  910,  912,  914,  915,
			  918,  920,  922,  924,  925,  926,  928,  929,  931,  932,
			  934,  935,  937,  938,  940,  942,  943,  944,  946,  947,
			  949,  950,  952,  953,  955,  956,  959,  961,  964,  966,

			  968,  969,  971,  972,  974,  975,  977,  978,  981,  983,
			  986,  988,  988,  988,  988,  988,  988,  988,  988,  988,
			  988,  988,  988,  988,  988,  988,  988,  988,  989,  990,
			  991,  992,  992,  992,  992,  992,  992,  993,  994,  996,
			  996,  996,  998,  998, 1002, 1002, 1004, 1004, 1004, 1006,
			 1009, 1011, 1014, 1016, 1018, 1019, 1022, 1024, 1027, 1029,
			 1031, 1032, 1034, 1035, 1037, 1038, 1041, 1043, 1045, 1046,
			 1048, 1049, 1051, 1052, 1054, 1055, 1057, 1058, 1060, 1061,
			 1064, 1066, 1068, 1069, 1071, 1072, 1074, 1075, 1077, 1078,
			 1081, 1083, 1085, 1086, 1088, 1089, 1091, 1092, 1095, 1097,

			 1099, 1100, 1102, 1103, 1105, 1106, 1108, 1109, 1111, 1112,
			 1114, 1115, 1117, 1118, 1120, 1121, 1123, 1124, 1127, 1129,
			 1131, 1132, 1134, 1135, 1138, 1140, 1142, 1143, 1145, 1146,
			 1149, 1151, 1153, 1154, 1154, 1154, 1154, 1154, 1154, 1155,
			 1155, 1157, 1157, 1158, 1159, 1163, 1163, 1163, 1165, 1165,
			 1166, 1166, 1169, 1171, 1173, 1174, 1177, 1179, 1181, 1182,
			 1184, 1185, 1187, 1188, 1191, 1193, 1196, 1198, 1200, 1201,
			 1204, 1206, 1208, 1209, 1211, 1212, 1215, 1217, 1219, 1220,
			 1222, 1223, 1225, 1226, 1228, 1229, 1231, 1232, 1234, 1235,
			 1237, 1238, 1241, 1243, 1245, 1246, 1248, 1249, 1252, 1254,

			 1256, 1257, 1260, 1262, 1265, 1267, 1270, 1272, 1274, 1275,
			 1277, 1278, 1281, 1283, 1285, 1286, 1286, 1287, 1287, 1287,
			 1287, 1291, 1291, 1292, 1293, 1293, 1293, 1294, 1295, 1296,
			 1299, 1301, 1303, 1304, 1307, 1309, 1311, 1312, 1314, 1315,
			 1317, 1318, 1321, 1323, 1326, 1328, 1330, 1331, 1334, 1336,
			 1339, 1341, 1343, 1344, 1346, 1347, 1349, 1350, 1352, 1353,
			 1355, 1356, 1359, 1361, 1363, 1364, 1366, 1367, 1370, 1372,
			 1373, 1373, 1374, 1374, 1376, 1376, 1376, 1377, 1378, 1378,
			 1379, 1382, 1384, 1387, 1389, 1392, 1394, 1397, 1399, 1402,
			 1404, 1406, 1407, 1410, 1412, 1414, 1415, 1418, 1420, 1422,

			 1423, 1426, 1428, 1431, 1433, 1434, 1436, 1436, 1438, 1439,
			 1442, 1444, 1447, 1449, 1452, 1454, 1456, 1456, yy_Dummy>>)
		end

	yy_acclist_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,  138,  138,  159,  157,  158,    3,  157,  158,    4,
			  158,    1,  157,  158,    2,  157,  158,   10,  157,  158,
			  140,  157,  158,  104,  157,  158,   17,  157,  158,  140,
			  157,  158,  157,  158,   11,  157,  158,   12,  157,  158,
			   31,  157,  158,   30,  157,  158,    8,  157,  158,   29,
			  157,  158,    6,  157,  158,   32,  157,  158,  142,  149,
			  157,  158,  142,  149,  157,  158,  142,  149,  157,  158,
			    9,  157,  158,    7,  157,  158,   36,  157,  158,   34,
			  157,  158,   35,  157,  158,  157,  158,  102,  103,  157,
			  158,  102,  103,  157,  158,  102,  103,  157,  158,  102,

			  103,  157,  158,  102,  103,  157,  158,  102,  103,  157,
			  158,  102,  103,  157,  158,  102,  103,  157,  158,  102,
			  103,  157,  158,  102,  103,  157,  158,  102,  103,  157,
			  158,  102,  103,  157,  158,  102,  103,  157,  158,  102,
			  103,  157,  158,  102,  103,  157,  158,  102,  103,  157,
			  158,  102,  103,  157,  158,  102,  103,  157,  158,  102,
			  103,  157,  158,   15,  157,  158,  157,  158,   16,  157,
			  158,   33,  157,  158,  157,  158,  103,  157,  158,  103,
			  157,  158,  103,  157,  158,  103,  157,  158,  103,  157,
			  158,  103,  157,  158,  103,  157,  158,  103,  157,  158,

			  103,  157,  158,  103,  157,  158,  103,  157,  158,  103,
			  157,  158,  103,  157,  158,  103,  157,  158,  103,  157,
			  158,  103,  157,  158,  103,  157,  158,  103,  157,  158,
			  103,  157,  158,   13,  157,  158,   14,  157,  158,  157,
			  158,  157,  158,  157,  158,  157,  158,  157,  158,  157,
			  158,  157,  158,  138,  158,  136,  158,  137,  158,  132,
			  138,  158,  135,  158,  138,  158,  138,  158,  138,  158,
			  138,  158,  138,  158,  138,  158,  138,  158,  138,  158,
			  138,  158,    3,    4,    1,    2,   37,  140,  139,  139,
			 -130,  140, -288, -131,  140, -289,  140,  140,  140,  140,

			  140,  140,  140,  104,  140,  140,  140,  140,  140,  140,
			  140,  140,  128,  128,  128,    5,   23,   24,  152,  155,
			   18,   20,  142,  149,  142,  149,  149,  141,  149,  149,
			  149,  141,  149,   28,   25,   22,   21,   26,   27,  102,
			  103,  102,  103,  102,  103,  102,  103,   42,  102,  103,
			  103,  103,  103,  103,   42,  103,  102,  103,  103,  102,
			  103,  102,  103,  102,  103,  102,  103,  102,  103,  103,
			  103,  103,  103,  103,  102,  103,   53,  102,  103,  103,
			   53,  103,  102,  103,  102,  103,  102,  103,  103,  103,
			  103,  102,  103,  102,  103,  102,  103,  103,  103,  103,

			   65,  102,  103,  102,  103,  102,  103,   72,  102,  103,
			   65,  103,  103,  103,   72,  103,  102,  103,  102,  103,
			  103,  103,  102,  103,  103,  102,  103,  102,  103,  102,
			  103,   80,  102,  103,  103,  103,  103,   80,  103,  102,
			  103,  103,  102,  103,  103,  102,  103,  102,  103,  103,
			  103,  102,  103,  102,  103,  103,  103,  102,  103,  103,
			  102,  103,  102,  103,  103,  103,  102,  103,  103,  102,
			  103,  103,   19,  138,  138,  138,  138,  138,  138,  138,
			  138,  136,  137,  132,  138,  138,  138,  135,  133,  138,
			  138,  138,  138,  138,  138,  138,  138,  134,  138,  138,

			  138,  138,  138,  138,  138,  138,  138,  138,  138,  138,
			  138,  138,  139,  140,  139,  140, -130,  140, -131,  140,
			  140,  140,  140,  140,  140,  140,  140,  140,  140,  140,
			  140,  140,  128,  105,  128,  128,  128,  128,  128,  128,
			  128,  128,  128,  128,  128,  128,  128,  128,  128,  128,
			  128,  128,  128,  128,  128,  128,  128,  105,  152,  155,
			  150,  152,  155,  150,  142,  149,  142,  149,  145,  148,
			  149,  148,  149,  144,  147,  149,  147,  149,  143,  146,
			  149,  146,  149,  142,  149,  102,  103,  103,  102,  103,
			   40,  102,  103,  103,   40,  103,   41,  102,  103,   41,

			  103,  102,  103,  103,   44,  102,  103,   44,  103,  102,
			  103,  103,  102,  103,  103,  102,  103,  103,  102,  103,
			  103,  102,  103,  103,  102,  103,  102,  103,  103,  103,
			  102,  103,  103,   56,  102,  103,  102,  103,   56,  103,
			  103,  102,  103,  102,  103,  103,  103,  102,  103,  103,
			  102,  103,  103,  102,  103,  103,  102,  103,  103,  102,
			  103,  102,  103,  102,  103,  102,  103,  102,  103,  103,
			  103,  103,  103,  103,  102,  103,  103,  102,  103,  102,
			  103,  103,  103,   76,  102,  103,   76,  103,  102,  103,
			  103,   78,  102,  103,   78,  103,  102,  103,  103,  102,

			  103,  103,  102,  103,  102,  103,  102,  103,  102,  103,
			  102,  103,  102,  103,  103,  103,  103,  103,  103,  103,
			  102,  103,  102,  103,  103,  103,  102,  103,  103,  102,
			  103,  103,  102,  103,  103,  102,  103,  102,  103,  102,
			  103,  103,  103,  103,  102,  103,  103,  102,  103,  103,
			  102,  103,  103,  101,  102,  103,  101,  103,  156,  133,
			  134,  138,  138,  138,  138,  138,  138,  138,  138,  138,
			  138,  138,  138,  138,  138,  139,  139,  139,  140,  140,
			  140,  140,  122,  120,  121,  123,  124,  129,  125,  126,
			  106,  107,  108,  109,  110,  111,  112,  113,  114,  115,

			  116,  117,  118,  119,  152,  155,  152,  155,  152,  155,
			  151,  154,  142,  149,  142,  149,  142,  149,  142,  149,
			  102,  103,  103,  102,  103,  103,  102,  103,  103,  102,
			  103,  103,  102,  103,  103,  102,  103,  103,  102,  103,
			  103,  102,  103,  103,  102,  103,  103,  102,  103,  103,
			   54,  102,  103,   54,  103,  102,  103,  103,  102,  103,
			  102,  103,  103,  103,  102,  103,  103,  102,  103,  103,
			  102,  103,  103,   63,  102,  103,  102,  103,   63,  103,
			  103,  102,  103,  103,  102,  103,  103,  102,  103,  103,
			  102,  103,  103,  102,  103,  103,  102,  103,  103,   73,

			  102,  103,   73,  103,  102,  103,  103,   75,  102,  103,
			   75,  103,  102,  103,  103,   79,  102,  103,   79,  103,
			  102,  103,  102,  103,  103,  103,  102,  103,  103,  102,
			  103,  103,  102,  103,  103,  102,  103,  103,  102,  103,
			  102,  103,  103,  103,  102,  103,  103,  102,  103,  103,
			  102,  103,  103,  102,  103,  103,   93,  102,  103,   93,
			  103,   94,  102,  103,   94,  103,  102,  103,  103,  102,
			  103,  103,  102,  103,  103,  102,  103,  103,   99,  102,
			  103,   99,  103,  100,  102,  103,  100,  103,  138,  138,
			  138,  138,  129,  152,  152,  155,  152,  155,  151,  152,

			  154,  155,  151,  154,  142,  149,   38,  102,  103,   38,
			  103,   39,  102,  103,   39,  103,  102,  103,  103,   45,
			  102,  103,   45,  103,   46,  102,  103,   46,  103,  102,
			  103,  103,  102,  103,  103,  102,  103,  103,   51,  102,
			  103,   51,  103,  102,  103,  103,  102,  103,  103,  102,
			  103,  103,  102,  103,  103,  102,  103,  103,  102,  103,
			  103,   61,  102,  103,   61,  103,  102,  103,  103,  102,
			  103,  103,  102,  103,  103,  102,  103,  103,   68,  102,
			  103,   68,  103,  102,  103,  103,  102,  103,  103,  102,
			  103,  103,   74,  102,  103,   74,  103,  102,  103,  103,

			  102,  103,  103,  102,  103,  103,  102,  103,  103,  102,
			  103,  103,  102,  103,  103,  102,  103,  103,  102,  103,
			  103,  102,  103,  103,   89,  102,  103,   89,  103,  102,
			  103,  103,  102,  103,  103,   92,  102,  103,   92,  103,
			  102,  103,  103,  102,  103,  103,   97,  102,  103,   97,
			  103,  102,  103,  103,  127,  152,  155,  155,  152,  151,
			  152,  154,  155,  151,  154,  150,   43,  102,  103,   43,
			  103,  102,  103,  103,   48,  102,  103,  102,  103,   48,
			  103,  103,  102,  103,  103,  102,  103,  103,   55,  102,
			  103,   55,  103,   57,  102,  103,   57,  103,  102,  103,

			  103,   59,  102,  103,   59,  103,  102,  103,  103,  102,
			  103,  103,   64,  102,  103,   64,  103,  102,  103,  103,
			  102,  103,  103,  102,  103,  103,  102,  103,  103,  102,
			  103,  103,  102,  103,  103,  102,  103,  103,   82,  102,
			  103,   82,  103,  102,  103,  103,  102,  103,  103,   85,
			  102,  103,   85,  103,  102,  103,  103,   87,  102,  103,
			   87,  103,   88,  102,  103,   88,  103,   90,  102,  103,
			   90,  103,  102,  103,  103,  102,  103,  103,   96,  102,
			  103,   96,  103,  102,  103,  103,  152,  151,  152,  154,
			  155,  155,  151,  153,  155,  153,   47,  102,  103,   47,

			  103,  102,  103,  103,   50,  102,  103,   50,  103,  102,
			  103,  103,  102,  103,  103,  102,  103,  103,   62,  102,
			  103,   62,  103,   66,  102,  103,   66,  103,  102,  103,
			  103,   69,  102,  103,   69,  103,   70,  102,  103,   70,
			  103,  102,  103,  103,  102,  103,  103,  102,  103,  103,
			  102,  103,  103,  102,  103,  103,   86,  102,  103,   86,
			  103,  102,  103,  103,  102,  103,  103,   98,  102,  103,
			   98,  103,  155,  155,  151,  152,  154,  155,  154,   49,
			  102,  103,   49,  103,   52,  102,  103,   52,  103,   58,
			  102,  103,   58,  103,   60,  102,  103,   60,  103,   67,

			  102,  103,   67,  103,  102,  103,  103,   77,  102,  103,
			   77,  103,  102,  103,  103,   84,  102,  103,   84,  103,
			  102,  103,  103,   91,  102,  103,   91,  103,   95,  102,
			  103,   95,  103,  155,  154,  155,  154,  155,  154,   71,
			  102,  103,   71,  103,   81,  102,  103,   81,  103,   83,
			  102,  103,   83,  103,  154,  155, yy_Dummy>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER is 9101
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER is 1016
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER is 1017
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

	yyNb_rules: INTEGER is 158
			-- Number of rules

	yyEnd_of_buffer: INTEGER is 159
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
