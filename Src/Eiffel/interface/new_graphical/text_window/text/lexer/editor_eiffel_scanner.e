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
					
when 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102 then
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
										
when 103 then
--|#line 208 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 208")
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
										
when 104 then
--|#line 228 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 228")
end

										if not in_comments then
											curr_token := new_text (text)											
										else
											curr_token := new_comment (text)
										end
										update_token_list
										
when 105 then
--|#line 240 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 240")
end

										if not in_comments then
											curr_token := new_text (text)										
										else
											curr_token := new_comment (text)
										end
										update_token_list
										
when 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127 then
--|#line 254 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 254")
end

					if not in_comments then
						curr_token := new_character (text)
					else
						curr_token := new_comment (text)
					end
					update_token_list
					
when 128 then
--|#line 284 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 284")
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
					
when 129 then
--|#line 299 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 299")
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
			create an_array.make (0, 9638)
			yy_nxt_template_1 (an_array)
			yy_nxt_template_2 (an_array)
			yy_nxt_template_3 (an_array)
			yy_nxt_template_4 (an_array)
			yy_nxt_template_5 (an_array)
			yy_nxt_template_6 (an_array)
			yy_nxt_template_7 (an_array)
			yy_nxt_template_8 (an_array)
			yy_nxt_template_9 (an_array)
			yy_nxt_template_10 (an_array)
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
			    6,    6,    6,   79,   80,   81,   82,   83,   84,   85,

			   87,   88,   89,   90,  136,  138,  845,  139,  139,  139,
			  139,   87,   88,   89,   90,  137,  140,  142, 1016,  143,
			  143,  144,  144,  746,  141,  152,  153, 1016,  106,  918,
			  150,  107,  154,  155,  739,  106, 1016,  127,  107,  127,
			  127,  157,  157,  157,  142,  128,  143,  143,  144,  144,
			  263,  263,  263,  264,  264,  372,   91,  146,  147,  149,
			  378,  918,  150,  265,  265,  265,  604,   91,  142,  378,
			  144,  144,  144,  144,  266,  266,  266,  108,  378,  148,
			  157,  157,  157,  398,  398,  398,  149,   92,  602,  146,
			  147,   93,   94,   95,   96,   97,   98,   99,   92,  379,

			  379,  600,   93,   94,   95,   96,   97,   98,   99,  109,
			  149,  148,  399,  399,  110,  111,  112,  113,  114,  115,
			  116,  119,  120,  121,  122,  123,  124,  125,  129,  130,
			  131,  132,  133,  134,  135,  157,  157,  157,  157,  378,
			  400,  400,  400,  508,  508,  157,  157,  157,  157,  157,
			  157,  158,  157,  157,  157,  157,  159,  157,  160,  157,
			  157,  157,  157,  161,  157,  157,  157,  157,  157,  157,
			  157,  401,  401,  401,  604,  157,  602,  162,  162,  162,
			  162,  162,  162,  163,  162,  162,  162,  162,  164,  162,
			  165,  162,  162,  162,  162,  166,  162,  162,  162,  162,

			  162,  162,  162,  600,  370,  370,  370,  370,  167,  168,
			  169,  170,  171,  172,  173,  157,  566,  174,  371,  975,
			  157,  280,  157,  162,  162,  162,  157,  157,  511,  506,
			  157,  248,  249,  250,  251,  252,  253,  254,  402,  374,
			  374,  374,  374,  157,  372,  594,  397,  162,  334,  175,
			  371,  975,  162,  375,  162,  507,  507,  507,  162,  162,
			  157,  176,  162,  186,  103,  177,  157,  157,  178,  102,
			  157,  179,  157,  187,  180,  162,  157,  157,  101,  157,
			  100,  280,  190,  267,  191,  375,  509,  509,  509,  157,
			  379,  379,  162,  181,  192,  188,  262,  182,  162,  162,

			  183,  246,  162,  184,  162,  189,  185,  156,  162,  162,
			  151,  162,  379,  379,  193,  104,  194,  276,  196,  277,
			  277,  162,  197,  103,  157,  102,  195,  101,  100,  157,
			  599,  157,  202,  157, 1016,  198,  157, 1016,  157,  203,
			  204, 1016, 1016,  157, 1016,  205, 1016,  157, 1016,  157,
			  199,  210,  599,  157,  200, 1016,  162,  211, 1016, 1016,
			  157,  162, 1016,  162,  206,  162,  224,  201,  162, 1016,
			  162,  207,  208,  278,  157,  162,  157,  209,  157,  162,
			  226,  162, 1016,  212, 1016,  162,  157,  216,  214,  213,
			  157,  157,  162,  157, 1016, 1016,  157,  217,  225,  218,

			  228, 1016, 1016,  219,  279, 1016,  162,  157,  162, 1016,
			  162,  157,  227,  157,  232,  229, 1016,  157,  162,  220,
			  215,  157,  162,  162,  233,  162, 1016, 1016,  162,  221,
			  236,  222,  230, 1016,  157,  223, 1016,  238,  162,  162,
			  162,  157, 1016,  162, 1016,  162,  234,  231,  157,  162,
			  162,  239,  157,  162,  157,  242,  235,  157,  510,  510,
			  510,  157,  237, 1016,  157,  157,  162,  175,  157,  240,
			  162,  244,  162,  162,  157, 1016,  381,  381,  381, 1016,
			  162,  157,  162,  241,  162, 1016,  162,  243, 1016,  162,
			  157,  157,  157,  162, 1016, 1016,  162,  162,  188,  175,

			  162, 1016, 1016,  245, 1016, 1016,  162,  163,  189,  162,
			 1016,  162,  164,  162,  165,  225,  378, 1016, 1016,  166,
			 1016,  162,  255,  256,  257,  258,  259,  260,  261, 1016,
			  188,  269,  270,  271,  272,  273,  274,  275, 1016,  163,
			  189,  162, 1016,  162,  164, 1016,  165,  225,  157,  157,
			  157,  166,  277,  162,  277,  284, 1016,  255,  256,  257,
			  258,  259,  260,  261,  255,  256,  257,  258,  259,  260,
			  261,  181, 1016, 1016,  212,  182, 1016,  162,  183,  162,
			  213,  184, 1016,  142,  185,  377,  377,  377,  377,  162,
			  193, 1016,  194,  269,  270,  271,  272,  273,  274,  275,

			 1016, 1016,  195,  181, 1016, 1016,  212,  182,  278,  162,
			  183,  162,  213,  184, 1016, 1016,  185,  157,  157,  157,
			 1016,  162,  193, 1016,  194,  149, 1016,  255,  256,  257,
			  258,  259,  260,  261,  195,  157,  157,  157, 1016,  279,
			 1016, 1016,  255,  256,  257,  258,  259,  260,  261,  199,
			  206, 1016,  162,  200,  162,  215,  162,  207,  208, 1016,
			  162,  220,  162,  209,  162, 1016,  201, 1016,  162, 1016,
			 1016,  221,  162,  222,  512,  512,  512,  223,  513,  513,
			  513,  199,  206,  162,  162,  200,  162,  215,  162,  207,
			  208, 1016,  162,  220,  162,  209,  162, 1016,  201,  227,

			  162, 1016, 1016,  221,  162,  222,  162,  230,  162,  223,
			  157,  157,  157,  234,  162,  162,  162,  162,  162,  162,
			 1016,  240,  231,  235, 1016,  162,  162,  237, 1016,  162,
			 1016,  227,  162, 1016,  162,  241, 1016,  162,  162,  230,
			  162,  381,  381,  381,  162,  234,  162, 1016,  162,  162,
			  162,  162, 1016,  240,  231,  235,  243,  162,  162,  237,
			  162,  162,  162, 1016,  162, 1016,  162,  241,  162,  162,
			  162,  245,  162, 1016, 1016,  277,  162,  281,  277, 1016,
			  162,  601,  278, 1016, 1016,  278, 1016,  285,  243, 1016,
			  268, 1016,  162,  279,  162, 1016,  279, 1016,  293, 1016,

			  162,  268,  162,  245,  162,  269,  270,  271,  272,  273,
			  274,  275,  162,  301,  269,  270,  271,  272,  273,  274,
			  275,  302,  302,  302,  269,  270,  271,  272,  273,  274,
			  275,  282,  303,  303,  334,  269,  270,  271,  272,  273,
			  274,  275,  304,  304,  304,  269,  270,  271,  272,  273,
			  274,  275,  305,  305,  305,  269,  270,  271,  272,  273,
			  274,  275,  283,  157,  157,  157,  269,  270,  271,  272,
			  273,  274,  275,  286,  287,  288,  289,  290,  291,  292,
			  106, 1016, 1016,  107,  294,  295,  296,  297,  298,  299,
			  300,  306, 1016, 1016,  269,  270,  271,  272,  273,  274, yy_Dummy>>,
			1, 1000, 0)
		end

	yy_nxt_template_2 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			  275,  142, 1016,  376,  376,  377,  377, 1016, 1016,  385,
			  385,  385,  385, 1016,  150, 1016,  335,  336,  337,  338,
			  339,  340,  341,  591,  591,  591,  591, 1016, 1016,  108,
			 1016, 1016,  319, 1016,  319,  319, 1016,  106, 1016, 1016,
			  107, 1016, 1016,  149, 1016,  320,  150,  320,  320,  386,
			  106, 1016, 1016,  107,  269,  270,  271,  272,  273,  274,
			  275,  109,  106, 1016, 1016,  107,  110,  111,  112,  113,
			  114,  115,  116,  308, 1016, 1016,  309,  118,  118,  118,
			  157,  157,  157, 1016,  106,  310,  108,  107,  157,  157,
			  157, 1016,  118, 1016,  118, 1016,  118,  118,  311,  108,

			  334,  118, 1016,  118,  613,  613,  613,  118, 1016,  118,
			 1016,  108,  118,  118,  118,  118,  118,  118,  109,  106,
			 1016, 1016,  107,  110,  111,  112,  113,  114,  115,  116,
			 1016,  109,  106, 1016, 1016,  107,  110,  111,  112,  113,
			  114,  115,  116,  109,  106, 1016, 1016,  107,  110,  111,
			  112,  113,  114,  115,  116,  106, 1016, 1016,  107,  312,
			  313,  314,  315,  316,  317,  318, 1016, 1016,  108, 1016,
			  119,  120,  121,  122,  123,  124,  125,  106, 1016,  369,
			  107,  108,  335,  336,  337,  338,  339,  340,  341,  106,
			 1016, 1016,  107,  108, 1016, 1016,  276, 1016,  277,  277,

			  109,  614,  614,  614,  321,  110,  111,  112,  113,  114,
			  115,  116, 1016,  109, 1016,  322,  322,  322,  110,  111,
			  112,  113,  114,  115,  116,  109,  108,  323,  323, 1016,
			  110,  111,  112,  113,  114,  115,  116,  106,  108, 1016,
			  107,  119,  120,  121,  122,  123,  124,  125,  106, 1016,
			 1016,  107,  278,  162,  162,  162, 1016, 1016,  109, 1016,
			  324,  324,  324,  110,  111,  112,  113,  114,  115,  116,
			  109,  334,  325,  325,  325,  110,  111,  112,  113,  114,
			  115,  116,  106,  279, 1016,  107,  108,  162, 1016,  162,
			 1016, 1016,  106, 1016, 1016,  107,  162,  162,  162,  162,

			 1016,  589,  106,  589, 1016,  107,  590,  590,  590,  590,
			 1016, 1016,  106, 1016, 1016,  107, 1016, 1016,  109,  162,
			  326,  162, 1016,  110,  111,  112,  113,  114,  115,  116,
			  334,  162, 1016,  327,  119,  120,  121,  122,  123,  124,
			  125,  106, 1016, 1016,  107,  162,  162,  162, 1016, 1016,
			  126,  126,  126,  335,  336,  337,  338,  339,  340,  341,
			  162,  162,  162, 1016, 1016,  328,  328,  328,  119,  120,
			  121,  122,  123,  124,  125,  329,  329, 1016,  119,  120,
			  121,  122,  123,  124,  125,  330,  330,  330,  119,  120,
			  121,  122,  123,  124,  125,  331,  331,  331,  119,  120,

			  121,  122,  123,  124,  125,  334, 1016,  277, 1016,  277,
			  277,  364,  335,  336,  337,  338,  339,  340,  341,  334,
			  713,  713,  713, 1016,  332, 1016,  499,  119,  120,  121,
			  122,  123,  124,  125,  342, 1016, 1016,  343,  344,  345,
			  346,  714,  714,  714, 1016, 1016,  347, 1016,  334,  157,
			  157,  157, 1016,  348, 1016,  349, 1016,  350,  351,  352,
			  353,  334,  354,  278,  355,  157,  157,  157,  356, 1016,
			  357, 1016, 1016,  358,  359,  360,  361,  362,  363,  590,
			  590,  590,  590, 1016,  365,  365,  365,  335,  336,  337,
			  338,  339,  340,  341,  279,  157,  157,  157,  366,  366,

			 1016,  335,  336,  337,  338,  339,  340,  341,  248,  249,
			  250,  251,  252,  253,  254, 1016,  738,  738,  738,  738,
			  335,  336,  337,  338,  339,  340,  341,  367,  367,  367,
			  335,  336,  337,  338,  339,  340,  341,  157,  157,  157,
			  368,  368,  368,  335,  336,  337,  338,  339,  340,  341,
			  383,  383,  383,  383, 1016,  157,  739, 1016,  499,  387,
			  383,  383,  383,  383,  383,  383,  157,  162,  162,  162,
			  157,  157,  157, 1016,  389,  157, 1016,  390,  740,  740,
			  740,  740,  157,  157, 1016,  393,  157,  162,  157,  395,
			  378,  388,  383,  383,  383,  383,  383,  383,  162,  157,

			 1016, 1016,  162,  162,  162, 1016,  391,  162,  142,  392,
			  598,  598,  598,  598,  162,  162,  388,  394,  162,  391,
			  162,  396,  392,  162,  162,  162,  162, 1016,  162,  394,
			 1016,  162, 1016,  396,  162,  162, 1016,  162,  162,  162,
			  248,  249,  250,  251,  252,  253,  254, 1016,  388,  162,
			  149,  391, 1016, 1016,  392,  162,  162,  162,  162,  157,
			  162,  394, 1016,  157, 1016,  396,  162,  162, 1016,  162,
			  162,  162,  162,  157,  162,  407,  157,  405,  403,  157,
			  404,  162,  157,  157,  162,  157,  411,  157, 1016,  157,
			  157,  162,  157, 1016,  406,  162,  409, 1016, 1016,  157,

			  157,  162,  413,  162,  162,  162,  162,  408,  162,  406,
			  404,  162,  404,  162,  162,  162,  162,  162,  412,  162,
			 1016,  162,  162, 1016,  162,  408,  406,  162,  410,  410,
			 1016,  162,  162,  162,  414,  162,  162,  412,  162,  162,
			 1016,  162, 1016,  162,  162,  162,  162,  414,  162, 1016,
			  157,  415, 1016,  162,  157,  416,  162,  408, 1016,  162,
			  157,  410,  417, 1016,  157, 1016,  418,  157,  162,  412,
			  162,  162,  162,  162,  162,  162,  162,  157,  162,  414,
			  162, 1016,  162,  417,  162,  162,  162,  418,  162,  162,
			 1016,  162,  162,  157,  417, 1016,  162,  157,  418,  162,

			 1016,  162, 1016, 1016,  162, 1016,  162, 1016, 1016,  162,
			  157,  419, 1016, 1016,  157, 1016,  162,  421,  157, 1016,
			  157,  162, 1016,  162,  157,  162,  162,  162,  162,  162,
			 1016,  157,  422,  162, 1016,  425, 1016,  157, 1016,  426,
			 1016, 1016,  162,  420, 1016, 1016,  162, 1016, 1016,  423,
			  162, 1016,  162,  162, 1016,  162,  162, 1016,  423, 1016,
			  420, 1016, 1016,  162,  424,  162,  162,  427,  162,  162,
			 1016,  428,  162,  424,  162, 1016,  427,  157,  162,  431,
			  428,  157, 1016,  157,  162,  162, 1016,  162,  429, 1016,
			  423,  430,  420,  162,  157, 1016,  157,  162,  162, 1016,

			  162, 1016, 1016,  162,  162,  424,  162, 1016,  427,  162,
			  162,  432,  428,  162, 1016,  162,  162,  157, 1016,  432,
			  430,  157, 1016,  430, 1016,  162,  162, 1016,  162,  157,
			  162,  433,  162,  157,  157,  162,  162,  157,  162,  434,
			  157,  157,  162, 1016,  157, 1016,  157, 1016,  162,  162,
			 1016,  432,  435,  162,  157, 1016, 1016,  157, 1016, 1016,
			 1016,  162,  162,  434,  162,  162,  162, 1016,  162,  162,
			  162,  434,  162,  162,  162, 1016,  162, 1016,  162, 1016,
			  162,  162, 1016,  162,  436, 1016,  162,  157, 1016,  162,
			  437,  157,  438,  162,  439,  162, 1016,  162,  162,  436, yy_Dummy>>,
			1, 1000, 1000)
		end

	yy_nxt_template_3 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			  162, 1016, 1016, 1016,  157,  440, 1016,  162,  441, 1016,
			  162, 1016, 1016,  162, 1016,  162, 1016, 1016,  277,  162,
			  277,  284,  442,  162,  443,  162,  444,  162, 1016,  162,
			  162,  436,  162, 1016, 1016, 1016,  162,  445, 1016,  162,
			  446,  442,  162,  443, 1016,  444, 1016, 1016,  157,  162,
			 1016,  162,  157,  157, 1016,  449,  445,  157,  447,  446,
			 1016,  162, 1016,  448,  162,  157,  162,  450, 1016, 1016,
			  157, 1016, 1016,  442,  278,  443,  162,  444, 1016, 1016,
			  162,  162, 1016,  162,  162,  162, 1016,  451,  445,  162,
			  448,  446,  451,  162, 1016,  448,  162,  162,  162,  452,

			 1016,  162,  162,  162,  452,  279,  157,  162,  162,  162,
			  157, 1016,  157,  162,  157,  454,  157,  457,  157,  162,
			 1016, 1016, 1016,  157,  451,  453, 1016, 1016, 1016,  157,
			  455,  157, 1016,  162, 1016,  162,  452, 1016,  162,  162,
			 1016,  162,  162, 1016,  162,  162,  162,  454,  162,  458,
			  162,  162,  157, 1016,  459,  162,  157,  454, 1016, 1016,
			  157,  162,  456,  162,  157, 1016,  162, 1016,  162,  157,
			  162,  458,  162,  456,  460, 1016,  157,  157,  162,  162,
			  461,  162,  162,  162,  162,  162,  460, 1016,  162, 1016,
			 1016,  162,  162,  157, 1016,  162,  162, 1016,  162, 1016,

			  162,  162,  162,  458,  162,  456,  460, 1016,  162,  162,
			  162,  162,  462,  162,  162,  162, 1016,  162,  157,  462,
			  157, 1016,  157,  162,  157,  162,  162,  162,  162,  475,
			  477, 1016,  162,  476,  478,  157,  157,  479,  162, 1016,
			  481, 1016,  162,  269,  270,  271,  272,  273,  274,  275,
			  162,  462,  162,  157,  162, 1016,  162, 1016,  162, 1016,
			  162,  477,  477, 1016,  162,  478,  478,  162,  162,  480,
			  162,  463,  482,  464,  162,  157,  162, 1016,  162,  157,
			 1016,  465,  480,  157,  466,  162,  467,  468,  162,  157,
			  744,  744,  744,  744, 1016, 1016,  157, 1016, 1016,  483,

			  381,  381,  381,  469, 1016,  470, 1016,  162,  162, 1016,
			  162,  162, 1016,  471,  480,  162,  472, 1016,  473,  474,
			  162,  162,  469, 1016,  470, 1016, 1016,  482,  162, 1016,
			  162,  484,  471, 1016,  162,  472,  162,  473,  474,  162,
			  601,  162,  162,  157, 1016, 1016,  162,  157,  484, 1016,
			 1016,  162, 1016, 1016,  469, 1016,  470, 1016, 1016,  482,
			  491, 1016,  162, 1016,  471, 1016,  162,  472,  162,  473,
			  474,  162, 1016,  162,  162,  162, 1016, 1016,  162,  162,
			  484,  157, 1016,  162,  485,  157,  488, 1016, 1016,  486,
			 1016,  489,  492,  157,  162,  157,  162,  157,  157,  495,

			  487,  493,  490,  162, 1016,  162,  162, 1016, 1016,  492,
			  157, 1016,  157,  162, 1016,  162,  488,  162,  488,  499,
			 1016,  489,  514,  489, 1016,  162,  162,  162,  162,  162,
			  162,  496,  490,  494,  490,  162,  499,  162,  162,  496,
			  494,  492,  162,  162,  162,  162,  162,  162,  162,  157,
			  162,  499,  162,  157, 1016,  162,  498, 1016,  162, 1016,
			 1016,  499,  162, 1016, 1016, 1016,  497,  596,  596,  596,
			  596,  496,  494,  499, 1016,  162, 1016,  162,  162, 1016,
			  162,  162,  162,  499,  162,  162, 1016,  162,  498, 1016,
			  162, 1016, 1016, 1016,  162, 1016, 1016, 1016,  498, 1016,

			  500,  248,  249,  250,  251,  252,  253,  254,  515,  516,
			  517,  518,  519,  520,  521,  501,  501,  501,  248,  249,
			  250,  251,  252,  253,  254,  841,  841,  841,  841, 1016,
			  502,  502, 1016,  248,  249,  250,  251,  252,  253,  254,
			  503,  503,  503,  248,  249,  250,  251,  252,  253,  254,
			  522, 1016,  504,  504,  504,  248,  249,  250,  251,  252,
			  253,  254,  505, 1016, 1016,  248,  249,  250,  251,  252,
			  253,  254,  301,  269,  270,  271,  272,  273,  274,  275,
			  302,  302,  302,  269,  270,  271,  272,  273,  274,  275,
			  303,  303, 1016,  269,  270,  271,  272,  273,  274,  275,

			  304,  304,  304,  269,  270,  271,  272,  273,  274,  275,
			  305,  305,  305,  269,  270,  271,  272,  273,  274,  275,
			  306, 1016, 1016,  269,  270,  271,  272,  273,  274,  275,
			  277, 1016,  281,  277, 1016, 1016,  523,  524,  525,  526,
			  527,  528,  529,  278, 1016, 1016,  278, 1016,  285, 1016,
			  279,  268, 1016,  279, 1016,  293, 1016,  278,  268, 1016,
			  278, 1016,  285, 1016, 1016,  268,  278, 1016, 1016,  278,
			 1016,  285, 1016, 1016,  268, 1016,  278, 1016, 1016,  278,
			 1016,  285, 1016, 1016,  268, 1016,  282,  278, 1016, 1016,
			  278, 1016,  285, 1016, 1016,  268, 1016,  278, 1016, 1016,

			  278, 1016,  285, 1016, 1016,  268, 1016,  278, 1016, 1016,
			  278, 1016,  285, 1016, 1016,  268, 1016,  283, 1016, 1016,
			 1016,  269,  270,  271,  272,  273,  274,  275,  842,  842,
			  842,  842, 1016, 1016,  286,  287,  288,  289,  290,  291,
			  292,  294,  295,  296,  297,  298,  299,  300,  286,  287,
			  288,  289,  290,  291,  292, 1016,  530,  286,  287,  288,
			  289,  290,  291,  292,  531,  531,  531,  286,  287,  288,
			  289,  290,  291,  292, 1016,  532,  532, 1016,  286,  287,
			  288,  289,  290,  291,  292,  533,  533,  533,  286,  287,
			  288,  289,  290,  291,  292,  534,  534,  534,  286,  287,

			  288,  289,  290,  291,  292,  278, 1016, 1016,  278, 1016,
			  285, 1016, 1016,  268,  269,  270,  271,  272,  273,  274,
			  275,  279, 1016, 1016,  279,  162,  293,  608, 1016,  268,
			  279, 1016,  162,  279,  162,  293, 1016,  162,  268, 1016,
			  279, 1016, 1016,  279,  162,  293, 1016, 1016,  268, 1016,
			  279, 1016, 1016,  279, 1016,  293, 1016,  162,  268,  608,
			  279, 1016, 1016,  279,  162,  293,  162, 1016,  268,  162,
			  279, 1016, 1016,  279, 1016,  293,  162, 1016,  268, 1016,
			  279, 1016, 1016,  279,  595,  293,  595, 1016,  268,  596,
			  596,  596,  596,  535, 1016, 1016,  286,  287,  288,  289,

			  290,  291,  292,  269,  270,  271,  272,  273,  274,  275,
			 1016, 1016,  294,  295,  296,  297,  298,  299,  300, 1016,
			  536,  294,  295,  296,  297,  298,  299,  300,  537,  537,
			  537,  294,  295,  296,  297,  298,  299,  300,  538,  538,
			 1016,  294,  295,  296,  297,  298,  299,  300,  539,  539,
			  539,  294,  295,  296,  297,  298,  299,  300,  540,  540,
			  540,  294,  295,  296,  297,  298,  299,  300,  541, 1016,
			 1016,  294,  295,  296,  297,  298,  299,  300,  269,  270,
			  271,  272,  273,  274,  275,  269,  270,  271,  272,  273,
			  274,  275,  269,  270,  271,  272,  273,  274,  275,  542, yy_Dummy>>,
			1, 1000, 2000)
		end

	yy_nxt_template_4 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			  542,  542,  269,  270,  271,  272,  273,  274,  275,  543,
			  543,  543,  269,  270,  271,  272,  273,  274,  275,  106,
			 1016, 1016,  544, 1016, 1016, 1016,  106, 1016, 1016,  107,
			 1016, 1016, 1016,  545,  609,  157,  107, 1016,  157,  157,
			  106,  157, 1016,  544, 1016,  157, 1016,  106,  607, 1016,
			  547,  157,  157,  546,  546,  546,  546,  106,  157,  142,
			  544,  597,  597,  598,  598,  106,  610,  162,  544, 1016,
			  162,  162,  150,  162, 1016,  106, 1016,  162,  544, 1016,
			  608, 1016, 1016,  162,  162,  106, 1016, 1016,  544, 1016,
			  162,  743,  743,  743,  743,  106, 1016, 1016,  544, 1016,

			 1016,  149, 1016, 1016,  150,  312,  313,  314,  315,  316,
			  317,  318,  119,  120,  121,  122,  123,  124,  125,  119,
			  120,  121,  122,  123,  124,  125,  312,  313,  314,  315,
			  316,  317,  318,  312,  313,  314,  315,  316,  317,  318,
			 1016, 1016, 1016,  312,  313,  314,  315,  316,  317,  318,
			  548,  312,  313,  314,  315,  316,  317,  318,  549,  549,
			  549,  312,  313,  314,  315,  316,  317,  318,  550,  550,
			 1016,  312,  313,  314,  315,  316,  317,  318,  551,  551,
			  551,  312,  313,  314,  315,  316,  317,  318,  106, 1016,
			 1016,  544,  588,  588,  588,  588, 1016, 1016,  106, 1016,

			 1016,  544, 1016, 1016, 1016,  319,  371,  319,  319,  162,
			  106,  162, 1016,  107, 1016,  592,  592,  592,  592, 1016,
			 1016,  162,  605,  605,  605,  605, 1016, 1016,  320,  593,
			  320,  320,  372,  106, 1016, 1016,  107, 1016,  371, 1016,
			 1016,  162, 1016,  162,  742,  106,  742, 1016,  107,  743,
			  743,  743,  743,  162, 1016,  594, 1016,  106, 1016,  108,
			  107,  593,  386, 1016, 1016,  606,  606,  606,  606, 1016,
			 1016,  552,  552,  552,  312,  313,  314,  315,  316,  317,
			  318,  553,  108, 1016,  312,  313,  314,  315,  316,  317,
			  318,  109,  106, 1016,  108,  107,  110,  111,  112,  113,

			  114,  115,  116, 1016,  106,  386,  108,  107,  846,  846,
			  846,  846,  106, 1016,  109,  107, 1016, 1016, 1016,  110,
			  111,  112,  113,  114,  115,  116,  109,  106, 1016, 1016,
			  107,  110,  111,  112,  113,  114,  115,  116,  109,  106,
			 1016,  108,  107,  110,  111,  112,  113,  114,  115,  116,
			 1016,  106, 1016,  108,  107, 1016, 1016, 1016,  106, 1016,
			 1016,  107, 1016, 1016, 1016,  106, 1016, 1016,  107,  848,
			  848,  848,  848,  109, 1016, 1016,  108, 1016,  110,  111,
			  112,  113,  114,  115,  116,  109,  106, 1016,  108,  107,
			  110,  111,  112,  113,  114,  115,  116, 1016,  119,  120,

			  121,  122,  123,  124,  125, 1016,  106, 1016,  109,  107,
			  554,  554,  554,  110,  111,  112,  113,  114,  115,  116,
			  109, 1016,  555,  555,  555,  110,  111,  112,  113,  114,
			  115,  116, 1016,  917,  917,  917,  917,  119,  120,  121,
			  122,  123,  124,  125,  119,  120,  121,  122,  123,  124,
			  125,  119,  120,  121,  122,  123,  124,  125, 1016,  335,
			  336,  337,  338,  339,  340,  341, 1016, 1016, 1016,  556,
			  556,  556,  119,  120,  121,  122,  123,  124,  125,  335,
			  336,  337,  338,  339,  340,  341, 1016, 1016, 1016,  557,
			  557,  557,  119,  120,  121,  122,  123,  124,  125, 1016,

			 1016, 1016,  558,  335,  336,  337,  338,  339,  340,  341,
			  564,  559,  559,  559,  335,  336,  337,  338,  339,  340,
			  341,  565,  745,  745,  745,  745, 1016, 1016,  567,  921,
			  921,  921,  921, 1016, 1016,  568, 1016,  560,  560, 1016,
			  335,  336,  337,  338,  339,  340,  341,  561,  561,  561,
			  335,  336,  337,  338,  339,  340,  341,  570,  922,  922,
			  922,  922,  746, 1016,  571,  562,  562,  562,  335,  336,
			  337,  338,  339,  340,  341, 1016, 1016, 1016,  563, 1016,
			 1016,  335,  336,  337,  338,  339,  340,  341,  569,  569,
			  569,  569,  335,  336,  337,  338,  339,  340,  341,  572,

			 1016, 1016, 1016,  335,  336,  337,  338,  339,  340,  341,
			  335,  336,  337,  338,  339,  340,  341,  335,  336,  337,
			  338,  339,  340,  341,  573,  162, 1016,  162, 1016, 1016,
			  747,  574,  598,  598,  598,  598, 1016,  162,  575,  335,
			  336,  337,  338,  339,  340,  341,  335,  336,  337,  338,
			  339,  340,  341,  576, 1016, 1016, 1016,  162, 1016,  162,
			  577,  335,  336,  337,  338,  339,  340,  341,  578,  162,
			 1016,  915,  386,  915, 1016,  579,  916,  916,  916,  916,
			 1016,  335,  336,  337,  338,  339,  340,  341,  580, 1016,
			 1016,  748,  748,  748,  748,  581,  924,  924,  924,  924,

			 1016, 1016,  582, 1016, 1016, 1016,  335,  336,  337,  338,
			  339,  340,  341,  335,  336,  337,  338,  339,  340,  341,
			  335,  336,  337,  338,  339,  340,  341,  583, 1016, 1016,
			 1016,  386, 1016, 1016,  584,  335,  336,  337,  338,  339,
			  340,  341,  335,  336,  337,  338,  339,  340,  341,  585,
			  335,  336,  337,  338,  339,  340,  341,  335,  336,  337,
			  338,  339,  340,  341, 1016, 1016, 1016, 1016,  514, 1016,
			  335,  336,  337,  338,  339,  340,  341,  335,  336,  337,
			  338,  339,  340,  341,  335,  336,  337,  338,  339,  340,
			  341, 1016,  612, 1016, 1016,  162,  162,  162,  162, 1016,

			 1016, 1016, 1016, 1016, 1016,  514, 1016,  162,  162,  335,
			  336,  337,  338,  339,  340,  341,  335,  336,  337,  338,
			  339,  340,  341, 1016,  612, 1016, 1016,  162,  162,  162,
			  162,  335,  336,  337,  338,  339,  340,  341, 1016,  162,
			  162, 1016, 1016,  126,  126,  126,  335,  336,  337,  338,
			  339,  340,  341, 1016,  515,  516,  517,  518,  519,  520,
			  521,  269,  270,  271,  272,  273,  274,  275, 1016, 1016,
			  126,  126,  126,  335,  336,  337,  338,  339,  340,  341,
			  126,  126,  126,  335,  336,  337,  338,  339,  340,  341,
			  715,  515,  516,  517,  518,  519,  520,  521,  916,  916,

			  916,  916,  126,  126,  126,  335,  336,  337,  338,  339,
			  340,  341,  916,  916,  916,  916, 1016,  586,  586,  586,
			  335,  336,  337,  338,  339,  340,  341,  840,  840,  840,
			  840, 1016,  587,  587,  587,  335,  336,  337,  338,  339,
			  340,  341,  383,  383,  383,  383, 1016,  610,  969,  969,
			  969,  969,  383,  383,  383,  383,  383,  383,  162,  157,
			  162,  157, 1016,  157,  157,  157, 1016,  739,  157,  611,
			  162,  974,  974,  974,  974, 1016,  157, 1016,  157,  610,
			 1016,  157,  603, 1016,  383,  383,  383,  383,  383,  383,
			  162,  162,  162,  162,  157,  162,  162,  162,  157, 1016, yy_Dummy>>,
			1, 1000, 3000)
		end

	yy_nxt_template_5 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			  162,  612,  162,  157, 1016,  615,  616,  157,  162, 1016,
			  162,  157,  617,  162, 1016,  162,  162,  162,  162, 1016,
			  157, 1016,  162,  618,  162,  157,  162,  162,  162,  157,
			  162, 1016,  620, 1016,  162,  162,  621,  616,  616,  162,
			  157, 1016,  157,  162,  618, 1016,  619,  162,  162,  162,
			  162, 1016,  162,  157,  162,  618,  162,  162,  622,  162,
			  162,  162, 1016,  157,  620, 1016,  162,  157,  622,  162,
			 1016,  162,  162, 1016,  162, 1016, 1016,  162,  620,  162,
			  623,  162, 1016,  624,  162,  162,  162,  157,  157,  162,
			  622,  157,  627,  626, 1016,  162,  162, 1016, 1016,  162,

			 1016,  162, 1016,  162,  157,  157, 1016,  625, 1016,  162,
			  157,  162,  624,  162,  629,  624,  162, 1016,  162,  162,
			  162,  162,  628,  162,  628,  626,  630,  157,  162,  162,
			  157,  162, 1016,  162,  157,  162,  162,  162, 1016,  626,
			  157,  162,  162, 1016,  157,  162,  630,  157, 1016, 1016,
			  737,  737,  737,  737,  628, 1016, 1016,  157,  630,  162,
			  631,  162,  162,  162,  371,  162,  162,  162, 1016,  162,
			  633,  162,  162,  162,  157, 1016,  162,  162,  632,  162,
			 1016,  162,  157, 1016,  634, 1016,  637,  157, 1016,  162,
			  372, 1016,  632, 1016,  635, 1016,  371, 1016, 1016,  157,

			 1016,  162,  635,  162, 1016,  162,  162,  162,  636, 1016,
			  632, 1016, 1016,  162,  162,  638,  636,  162,  638,  162,
			 1016,  162,  162,  162,  162,  157,  635, 1016,  640,  157,
			 1016,  162, 1016,  162,  162, 1016, 1016,  162, 1016,  162,
			  636, 1016,  157,  639, 1016, 1016, 1016,  638, 1016,  162,
			  162, 1016,  162,  162,  162,  162,  162,  162,  642,  157,
			  640,  162,  162,  157, 1016,  162,  162, 1016,  157,  162,
			  645,  162,  157, 1016,  162,  640,  157,  648,  641,  162,
			  643,  162,  162,  646,  162,  157, 1016, 1016,  157,  162,
			  642,  162,  157,  644,  162,  162, 1016, 1016, 1016,  647,

			  162,  162,  645,  162,  162,  157, 1016, 1016,  162,  648,
			  642,  162,  645,  162, 1016,  646, 1016,  162,  157,  157,
			  162,  162,  649,  157,  162,  646,  157,  651,  657,  157,
			  653,  648,  157,  157, 1016,  157,  157,  162, 1016,  741,
			  741,  741,  741,  157,  655,  157,  157, 1016, 1016, 1016,
			  162,  162, 1016,  593,  650,  162, 1016, 1016,  162,  652,
			  658,  162,  654,  650,  162,  162,  652,  162,  162,  162,
			  162,  162,  162, 1016, 1016,  162,  656,  162,  162,  594,
			  654,  162,  162, 1016,  162,  593,  162,  162,  656,  162,
			 1016, 1016, 1016,  157,  658,  650,  162,  659,  652,  162,

			 1016,  162,  162,  162,  162,  162, 1016,  162, 1016, 1016,
			  157, 1016,  654,  162,  162,  660,  162,  162,  162,  162,
			  656,  162,  162,  661,  162,  162,  658,  157,  162,  660,
			  662,  162, 1016, 1016,  162, 1016, 1016,  162, 1016,  162,
			  157,  162,  162,  162, 1016, 1016,  157,  660, 1016,  162,
			  157,  666, 1016,  162,  162,  662,  162, 1016,  162,  162,
			  162,  663,  662,  157,  157,  162,  162,  162,  665,  664,
			  162, 1016,  162,  162, 1016,  162, 1016,  162,  162, 1016,
			 1016,  157,  162,  666, 1016,  162, 1016,  157, 1016, 1016,
			  162,  157,  162,  664,  157,  162,  162,  162,  157,  162,

			  666,  664,  162,  162,  157,  162,  668, 1016,  667,  162,
			  162,  157,  162,  162,  157,  162, 1016, 1016,  669,  162,
			  670, 1016,  162,  162, 1016, 1016,  162,  162,  157,  162,
			  162,  157,  675, 1016, 1016,  162,  162,  162,  668,  162,
			  668, 1016,  162,  162,  162,  157,  162,  162, 1016, 1016,
			  670,  157,  670,  671,  162,  157,  672, 1016, 1016,  162,
			  162,  162,  157,  162,  676, 1016,  677, 1016,  157,  673,
			 1016,  162,  674,  923,  923,  923,  923,  162,  162,  157,
			  162, 1016,  679,  162, 1016,  673,  157,  162,  674,  157,
			  162, 1016, 1016,  157,  162, 1016, 1016, 1016,  678,  157,

			  162,  673, 1016,  157,  674,  683,  157,  157, 1016,  681,
			  162,  162,  162,  157,  680, 1016, 1016,  157,  162, 1016,
			  157,  162,  162,  684, 1016,  162, 1016,  676, 1016, 1016,
			  687,  162, 1016, 1016,  162,  162,  162,  685,  162,  162,
			 1016,  682, 1016, 1016,  678,  162,  162,  680, 1016,  162,
			 1016,  162,  162,  162, 1016,  686, 1016, 1016,  162,  676,
			  162, 1016,  688,  162, 1016,  162,  162,  162,  162,  162,
			  162,  162, 1016,  685,  682,  688,  678,  162,  162,  680,
			 1016,  162,  162,  162,  162,  162,  976,  976,  976,  976,
			  162,  686,  162, 1016,  162,  162, 1016,  162, 1016,  162,

			  157,  162,  162,  162,  689,  685,  682,  688,  691,  162,
			 1016,  690,  157,  162,  162, 1016,  162,  157,  162, 1016,
			  162, 1016,  692,  686,  694,  157,  162,  162, 1016,  162,
			  162, 1016,  162,  162,  157,  162,  690, 1016,  157,  162,
			  692, 1016,  693,  690,  162,  162,  162, 1016,  696,  162,
			  162,  157,  162, 1016,  692, 1016,  694,  162,  162,  162,
			 1016,  162,  162, 1016, 1016,  162,  162,  162,  157,  157,
			  162,  162,  157,  697,  694,  698, 1016,  162,  162, 1016,
			  696,  695,  162,  162,  162,  157,  157, 1016, 1016,  157,
			  162, 1016,  157,  699,  162,  157,  157, 1016, 1016,  157,

			  162,  162, 1016,  703,  162,  698,  157,  698,  701,  157,
			 1016, 1016,  157,  696,  162, 1016,  162,  162,  162, 1016,
			 1016,  162, 1016,  700,  162,  700,  162,  162,  162, 1016,
			  162,  162,  162, 1016,  162,  704,  162, 1016,  162,  702,
			  702,  162,  162, 1016,  162,  704,  162, 1016,  162, 1016,
			  162, 1016, 1016,  157, 1016,  700, 1016,  157, 1016, 1016,
			  162,  705,  162, 1016,  162, 1016,  162, 1016,  162,  157,
			  157,  702,  707,  157,  162,  499,  706,  704,  162,  162,
			  162,  162,  162, 1016,  514,  162,  157,  708,  162,  162,
			  710,  162,  162,  706,  162,  162,  162,  162,  499,  157,

			  162,  162,  162,  157,  708,  162,  162,  162,  706,  499,
			 1016,  162,  709,  162, 1016, 1016,  157,  157,  162,  708,
			  162,  157,  710,  162,  499, 1016,  162,  162,  162,  162,
			 1016,  162,  162, 1016,  157,  162,  499, 1016,  162,  162,
			  923,  923,  923,  923,  710, 1016,  499, 1016,  162,  162,
			 1016, 1016,  514,  162, 1016, 1016, 1016,  248,  249,  250,
			  251,  252,  253,  254,  514, 1016,  162,  716,  716,  716,
			  515,  516,  517,  518,  519,  520,  521,  514, 1016, 1016,
			  248,  249,  250,  251,  252,  253,  254,  514, 1016, 1016,
			 1016,  248,  249,  250,  251,  252,  253,  254,  522,  269, yy_Dummy>>,
			1, 1000, 4000)
		end

	yy_nxt_template_6 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			  270,  271,  272,  273,  274,  275,  248,  249,  250,  251,
			  252,  253,  254,  522, 1016,  711,  711,  711,  248,  249,
			  250,  251,  252,  253,  254,  712,  712,  712,  248,  249,
			  250,  251,  252,  253,  254,  717,  717,  522,  515,  516,
			  517,  518,  519,  520,  521, 1016, 1016,  718,  718,  718,
			  515,  516,  517,  518,  519,  520,  521,  522, 1016, 1016,
			  719,  719,  719,  515,  516,  517,  518,  519,  520,  521,
			  720,  522, 1016,  515,  516,  517,  518,  519,  520,  521,
			 1016,  522, 1016, 1016,  523,  524,  525,  526,  527,  528,
			  529,  522, 1016, 1016,  606,  606,  606,  606,  721,  523,

			  524,  525,  526,  527,  528,  529,  278, 1016, 1016,  278,
			  925,  285,  925, 1016,  268,  923,  923,  923,  923, 1016,
			  722,  722,  722,  523,  524,  525,  526,  527,  528,  529,
			  278, 1016, 1016,  278,  386,  285, 1016, 1016,  268, 1016,
			  723,  723, 1016,  523,  524,  525,  526,  527,  528,  529,
			  844,  844,  844,  844,  724,  724,  724,  523,  524,  525,
			  526,  527,  528,  529,  725,  725,  725,  523,  524,  525,
			  526,  527,  528,  529,  726, 1016, 1016,  523,  524,  525,
			  526,  527,  528,  529,  278, 1016, 1016,  278, 1016,  285,
			  845, 1016,  268,  971,  971,  971,  971,  286,  287,  288,

			  289,  290,  291,  292,  278, 1016, 1016,  278, 1016,  285,
			 1016,  279,  268, 1016,  279, 1016,  293, 1016, 1016,  268,
			 1016,  286,  287,  288,  289,  290,  291,  292,  278, 1016,
			 1016,  278, 1016,  285, 1016, 1016,  268, 1016,  278, 1016,
			 1016,  278, 1016,  285, 1016,  279,  268, 1016,  279, 1016,
			  293, 1016,  279,  268, 1016,  279, 1016,  293, 1016,  279,
			  268, 1016,  279, 1016,  293, 1016, 1016,  268,  335,  336,
			  337,  338,  339,  340,  341,  286,  287,  288,  289,  290,
			  291,  292,  279, 1016, 1016,  279,  970,  293,  970, 1016,
			  268,  971,  971,  971,  971,  286,  287,  288,  289,  290,

			  291,  292,  294,  295,  296,  297,  298,  299,  300,  545,
			 1016, 1016,  544, 1016, 1016, 1016,  727,  727,  727,  286,
			  287,  288,  289,  290,  291,  292,  728,  728,  728,  286,
			  287,  288,  289,  290,  291,  292,  294,  295,  296,  297,
			  298,  299,  300,  294,  295,  296,  297,  298,  299,  300,
			  294,  295,  296,  297,  298,  299,  300,  279, 1016, 1016,
			  279,  972,  293,  972, 1016,  268,  973,  973,  973,  973,
			  729,  729,  729,  294,  295,  296,  297,  298,  299,  300,
			  106, 1016, 1016,  544, 1016, 1016,  847,  847,  847,  847,
			  106, 1016, 1016,  544, 1016,  312,  313,  314,  315,  316,

			  317,  318,  118,  731,  731,  731,  731,  545,  157, 1016,
			  544, 1016,  157, 1016,  106, 1016, 1016,  544, 1016, 1016,
			 1016,  106, 1016, 1016,  544,  157,  746,  749,  106,  756,
			  162,  544,  162,  118, 1016,  106, 1016, 1016,  544, 1016,
			  162, 1016,  162, 1016,  162,  730,  730,  730,  294,  295,
			  296,  297,  298,  299,  300,  106, 1016,  162,  544,  750,
			 1016,  756,  162, 1016,  162, 1016,  312,  313,  314,  315,
			  316,  317,  318, 1016,  162, 1016,  312,  313,  314,  315,
			  316,  317,  318,  106, 1016, 1016,  544,  850, 1016,  606,
			  606,  606,  606,  312,  313,  314,  315,  316,  317,  318,

			  312,  313,  314,  315,  316,  317,  318,  312,  313,  314,
			  315,  316,  317,  318,  312,  313,  314,  315,  316,  317,
			  318,  312,  313,  314,  315,  316,  317,  318,  106,  149,
			 1016,  107,  973,  973,  973,  973, 1016, 1016,  732,  732,
			  732,  312,  313,  314,  315,  316,  317,  318,  106, 1016,
			 1016,  107, 1016, 1016, 1016,  106, 1016, 1016,  107, 1016,
			 1016, 1016,  106, 1016, 1016,  107,  733,  733,  733,  312,
			  313,  314,  315,  316,  317,  318, 1016,  108, 1016,  162,
			 1016,  774,  747, 1016,  597,  597,  598,  598, 1016, 1016,
			 1016,  162, 1016, 1016, 1016,  150,  978,  108,  978, 1016,

			 1016,  979,  979,  979,  979,  973,  973,  973,  973,  109,
			 1016,  162, 1016,  774,  110,  111,  112,  113,  114,  115,
			  116, 1016, 1016,  162,  386, 1016, 1016,  150, 1016,  109,
			 1016, 1016, 1016, 1016,  110,  111,  112,  113,  114,  115,
			  116,  119,  120,  121,  122,  123,  124,  125,  119,  120,
			  121,  122,  123,  124,  125, 1016, 1016, 1016,  335,  336,
			  337,  338,  339,  340,  341,  335,  336,  337,  338,  339,
			  340,  341,  335,  336,  337,  338,  339,  340,  341,  734,
			  734,  734,  335,  336,  337,  338,  339,  340,  341,  735,
			  735,  735,  335,  336,  337,  338,  339,  340,  341, 1016,

			 1005, 1005, 1005, 1005, 1016, 1016, 1016,  736,  569,  569,
			  569,  569,  126,  126,  126,  335,  336,  337,  338,  339,
			  340,  341,  979,  979,  979,  979, 1016,  157, 1016, 1016,
			 1016,  157, 1016, 1016,  126,  126,  126,  335,  336,  337,
			  338,  339,  340,  341,  157,  751, 1016,  737,  737,  737,
			  737, 1007, 1007, 1007, 1007, 1016,  162, 1016,  162,  162,
			  162,  839,  162,  162,  750, 1016, 1016,  752,  162, 1016,
			 1016, 1016,  162, 1016,  157, 1016,  162,  752,  157, 1016,
			  753,  335,  336,  337,  338,  339,  340,  341,  162, 1016,
			  162,  157,  162,  839,  162, 1016,  750,  157,  754,  752,

			  162,  157, 1016,  162,  162,  162,  162,  755, 1016,  157,
			  162, 1016,  754,  157,  157,  162, 1016,  157, 1016, 1016,
			 1016,  759, 1016,  162, 1016, 1016,  157,  757, 1016,  162,
			  754, 1016, 1016,  162,  157,  162,  162,  162,  162,  756,
			 1016,  162, 1016,  758, 1016,  162,  162,  162,  162,  162,
			 1016, 1016,  157,  760,  760, 1016,  157, 1016,  162,  758,
			 1016,  162, 1016,  162, 1016, 1016,  162, 1016,  162,  157,
			  162,  761, 1016,  162,  157,  758, 1016,  162,  763,  162,
			  162, 1016, 1016,  764,  162,  762,  760, 1016,  162,  162,
			  162,  157,  162,  162, 1016,  162,  916,  916,  916,  916,

			 1016,  162,  162,  762, 1016,  162,  162, 1016,  157,  162,
			  764,  162,  157,  766,  765,  764, 1016,  762,  162, 1016,
			  162,  162,  162,  162,  162,  157,  162, 1016,  162, 1016,
			  162,  157,  768, 1016,  162,  157,  739, 1016,  162,  157,
			  162, 1016, 1016,  157,  162,  766,  766,  769,  767,  157,
			  162, 1016,  162,  157, 1016, 1016,  157,  162,  162, 1016,
			  162, 1016,  162,  162,  768, 1016,  771,  162, 1016,  770,
			  162,  162,  162,  157,  162,  162, 1016,  157,  157,  770,
			  768,  162,  157, 1016,  162,  162,  773,  162,  162,  162,
			  157, 1016, 1016,  772, 1016,  775, 1016, 1016,  772,  162, yy_Dummy>>,
			1, 1000, 5000)
		end

	yy_nxt_template_7 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			 1016,  770, 1016,  157,  162,  162,  162,  157, 1016,  162,
			  162,  162, 1016,  162,  162, 1016,  162,  776,  774,  162,
			  777,  162,  162,  162,  162,  772,  162,  776, 1016,  157,
			  778,  162, 1016,  779,  157,  162,  162, 1016,  157,  162,
			 1016,  780, 1016,  162, 1016,  162,  157, 1016,  162,  776,
			  162,  157,  778, 1016,  781,  162,  162, 1016,  162, 1016,
			  162,  162,  778, 1016, 1016,  780,  162,  162,  162,  162,
			  162,  157,  162,  780,  162,  157,  782,  157,  162,  162,
			  162,  783,  162,  162,  162,  157,  782, 1016,  157,  157,
			 1016,  784,  162,  785,  157, 1016, 1016, 1016,  162,  162,

			  162,  162,  157,  162,  162, 1016,  162,  162,  782,  162,
			  162,  162, 1016,  784,  157, 1016,  162,  162,  157, 1016,
			  162,  162, 1016,  784,  786,  786,  162,  162, 1016,  162,
			  162,  157,  162,  162,  162,  162,  162,  787,  162,  162,
			  157, 1016,  162,  157,  157,  788,  162,  157,  790, 1016,
			  162, 1016,  162, 1016,  162, 1016,  786,  791,  792,  162,
			  157,  162, 1016,  162,  162,  162,  789,  162,  162,  788,
			  162,  162,  162, 1016,  157,  162,  162,  788,  793,  162,
			  790, 1016, 1016,  157,  162, 1016,  162,  157,  794,  792,
			  792,  157,  162, 1016, 1016,  162,  162,  162,  790,  162,

			  795,  162, 1016, 1016,  157,  796,  162,  162,  157, 1016,
			  794,  162,  162, 1016,  162,  162,  798, 1016,  162,  162,
			  794,  157, 1016,  162,  162, 1016, 1016,  162,  162,  162,
			  157,  162,  796,  162,  157, 1016,  162,  796,  157,  162,
			  162,  797,  157,  162,  162, 1016,  162,  157,  798,  162,
			  162,  162, 1016,  162,  157,  157,  162,  162,  157,  162,
			  162,  162,  162,  800, 1016,  162,  162, 1016,  157,  162,
			  162,  157,  157,  798,  162,  162, 1016, 1016, 1016,  162,
			 1016,  162,  162,  162,  162,  157,  162,  162,  157,  162,
			  162,  162,  157,  162,  162,  800, 1016,  162,  157,  799,

			  162,  162,  157,  162,  162,  157,  804,  162, 1016,  162,
			 1016,  162, 1016, 1016,  162,  157,  162,  162,  801,  157,
			  162,  162, 1016,  157,  162, 1016,  162,  803, 1016, 1016,
			  162,  800, 1016,  162,  162,  162,  157,  162,  804, 1016,
			 1016,  162,  802,  162,  157,  162,  806,  162,  157,  805,
			  802,  162,  162,  162,  162,  162,  157, 1016,  157,  804,
			  157,  157,  157, 1016,  162,  162, 1016,  162,  162, 1016,
			  809, 1016, 1016,  807,  802,  157,  162,  162,  806, 1016,
			  162,  806, 1016,  162,  162,  162,  162, 1016,  162,  808,
			  162, 1016,  162,  162,  162,  162,  162,  162,  810,  162,

			 1016, 1016,  810, 1016, 1016,  808,  157,  162, 1016,  162,
			  157, 1016, 1016,  812,  811,  162,  162,  162,  162, 1016,
			  157,  808,  157,  157,  157, 1016,  157,  162,  162,  162,
			  810,  162,  816,  815,  162, 1016, 1016,  157,  162,  157,
			  813,  162,  162, 1016,  162,  812,  812, 1016,  162, 1016,
			  162, 1016,  162, 1016,  162,  162,  162, 1016,  162, 1016,
			  162,  162, 1016,  162,  816,  816,  162, 1016, 1016,  162,
			  814,  162,  814,  162,  157,  162,  162,  162,  157,  157,
			 1016,  819, 1016,  157, 1016, 1016, 1016,  162,  818, 1016,
			 1016,  157, 1016,  162, 1016,  162,  157, 1016,  817, 1016,

			  157, 1016,  814,  820,  157,  162,  162,  162, 1016,  162,
			  162,  162,  162,  820,  162,  162, 1016,  821, 1016,  162,
			  818, 1016, 1016,  162,  162,  162, 1016,  162,  162, 1016,
			  818,  822,  162, 1016, 1016,  820,  162,  162,  157,  162,
			 1016,  162,  157,  824,  162, 1016,  162, 1016,  157,  822,
			  157,  162,  157,  823,  157,  157,  162,  162, 1016,  162,
			  162, 1016,  162,  822,  162,  157,  162,  157, 1016,  162,
			  162,  162,  162,  162,  162,  824,  162, 1016, 1016, 1016,
			  162, 1016,  162,  162,  162,  824,  162,  162,  843,  843,
			  843,  843,  162, 1016,  162, 1016,  162,  162,  162,  162,

			 1016,  157,  593,  826,  162,  157,  825, 1016,  162,  162,
			  157,  162,  157,  162,  157,  162,  157, 1016,  157, 1016,
			 1016,  162,  828,  829,  830,  162,  162,  157,  594,  157,
			  827, 1016, 1016,  162,  593,  826,  162,  162,  826, 1016,
			 1016,  162,  162,  162,  162,  162,  162,  162,  162,  499,
			  162, 1016,  832,  162,  828,  830,  830,  162,  162,  162,
			  831,  162,  828,  162,  157,  162,  157,  162,  162,  162,
			  157,  499,  157, 1016,  514,  162,  157,  157,  162,  162,
			  162,  514, 1016,  157,  832, 1016, 1016, 1016,  514,  157,
			  162, 1016,  832, 1016, 1016,  162,  162,  162,  162,  162,

			  514,  162,  162, 1016,  162, 1016, 1016,  162,  162,  162,
			  162,  162,  162,  514, 1016,  162, 1016, 1016, 1016, 1016,
			 1016,  162,  162,  514, 1016, 1016, 1016, 1016, 1016, 1016,
			  522,  248,  249,  250,  251,  252,  253,  254,  522, 1016,
			 1016, 1006, 1016, 1006, 1016,  522, 1007, 1007, 1007, 1007,
			 1016, 1016,  522,  248,  249,  250,  251,  252,  253,  254,
			  515,  516,  517,  518,  519,  520,  521,  515,  516,  517,
			  518,  519,  520,  521,  515,  516,  517,  518,  519,  520,
			  521,  522, 1016, 1016, 1016, 1016,  515,  516,  517,  518,
			  519,  520,  521,  522, 1016, 1016,  833,  833,  833,  515,

			  516,  517,  518,  519,  520,  521,  834,  834,  834,  515,
			  516,  517,  518,  519,  520,  521,  523,  524,  525,  526,
			  527,  528,  529, 1016,  523,  524,  525,  526,  527,  528,
			  529,  523,  524,  525,  526,  527,  528,  529,  523,  524,
			  525,  526,  527,  528,  529,  278, 1016, 1016,  278, 1016,
			  285, 1016,  278,  268, 1016,  278, 1016,  285, 1016, 1016,
			  268, 1016, 1016, 1016,  835,  835,  835,  523,  524,  525,
			  526,  527,  528,  529, 1016, 1016,  836,  836,  836,  523,
			  524,  525,  526,  527,  528,  529,  279,  838, 1016,  279,
			 1016,  293, 1016,  279,  268, 1016,  279, 1016,  293, 1016,

			 1016,  268, 1016, 1016, 1016,  106, 1016, 1016,  544, 1016,
			 1016, 1016,  106, 1016, 1016,  544, 1016,  118,  837,  837,
			  837,  837,  106, 1016, 1016,  544, 1016, 1016,  335,  336,
			  337,  338,  339,  340,  341, 1016,  286,  287,  288,  289,
			  290,  291,  292,  286,  287,  288,  289,  290,  291,  292,
			 1016, 1016, 1016, 1016, 1016, 1016,  335,  336,  337,  338,
			  339,  340,  341, 1016, 1016,  920,  920,  920,  920,  335,
			  336,  337,  338,  339,  340,  341, 1016,  294,  295,  296,
			  297,  298,  299,  300,  294,  295,  296,  297,  298,  299,
			  300,  312,  313,  314,  315,  316,  317,  318,  312,  313, yy_Dummy>>,
			1, 1000, 6000)
		end

	yy_nxt_template_8 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			  314,  315,  316,  317,  318,  845, 1016, 1016,  312,  313,
			  314,  315,  316,  317,  318,  843,  843,  843,  843,  157,
			  162,  157,  162,  157, 1016,  157, 1016, 1016,  162,  849,
			  162,  157,  162, 1016, 1016,  157,  157,  162,  157,  852,
			  162,  157,  157, 1016,  851,  157,  157, 1016,  157,  162,
			 1016,  162,  162,  162,  162,  162, 1016,  162,  157,  157,
			  162,  849,  162,  162,  162, 1016, 1016,  162,  162,  162,
			  162,  852,  162,  162,  162,  157,  852,  162,  162,  157,
			  162,  162,  162,  162,  162,  162, 1016,  162, 1016,  162,
			  162,  162,  853,  854,  162,  162,  157, 1016, 1016,  162,

			  855,  857, 1016, 1016,  856,  858, 1016,  162,  162, 1016,
			  162,  162, 1016,  157,  162,  162,  162,  162,  157,  162,
			  162,  162,  157, 1016,  854,  854,  162,  162,  162, 1016,
			  157,  162,  857,  857,  157,  157,  858,  858, 1016,  162,
			  162,  860,  162,  859,  162,  162,  162,  157, 1016, 1016,
			  162,  162,  162,  157,  162, 1016,  162,  157,  923,  923,
			  923,  923,  162, 1016,  157,  866,  162,  162,  157,  863,
			  861,  162,  162,  860,  162,  860,  162, 1016,  162,  162,
			  162,  157,  162,  162,  162,  162,  862,  864,  162,  162,
			  157, 1016,  162,  162,  865,  162,  162,  866,  746, 1016,

			  162,  864,  862, 1016,  162,  162,  162,  157, 1016, 1016,
			 1016, 1016,  162,  162,  162, 1016,  162,  157,  862,  864,
			  867,  157,  162,  868,  162,  162,  866,  162,  157, 1016,
			 1016,  162,  157,  162,  157, 1016,  162,  162,  162,  162,
			 1016, 1016, 1016,  162,  870,  157, 1016,  869,  162,  162,
			 1016, 1016,  868,  162,  157,  868, 1016,  162,  157,  872,
			  162, 1016, 1016,  162,  162,  162,  162,  871,  162,  162,
			  162,  157,  162, 1016,  162,  162,  870,  162,  157,  870,
			  162,  157,  157, 1016,  162,  157,  162, 1016,  157,  162,
			  162,  872,  877, 1016, 1016,  157, 1016, 1016,  873,  872,

			  162,  162,  876,  162,  162,  157,  162, 1016, 1016,  162,
			  162,  162,  162,  162,  162,  874,  162,  162,  157,  878,
			  162,  162,  157, 1016,  878,  157,  162,  162,  162,  157,
			  874,  875,  162,  879,  876,  157, 1016,  162,  162, 1016,
			 1016,  162,  157,  162,  162, 1016, 1016,  874, 1016, 1016,
			  162,  878, 1016,  162,  162,  157, 1016,  162,  162,  157,
			  162,  162, 1016,  876, 1016,  880,  880,  162, 1016,  162,
			  162,  162,  157,  162,  162,  162,  157, 1016, 1016, 1016,
			  157,  162, 1016, 1016,  881,  162, 1016,  162, 1016, 1016,
			 1016,  162, 1016,  157,  882, 1016, 1016,  162,  880,  162,

			 1016,  162, 1016,  162,  162,  162,  157,  162,  162,  162,
			  157, 1016,  162,  162,  885, 1016,  882,  162,  157,  884,
			  883, 1016,  157,  157, 1016,  162,  882, 1016,  162,  162,
			  162,  162, 1016, 1016,  886,  157, 1016,  162,  162,  162,
			  162,  162,  162, 1016,  157,  162,  886,  162,  157,  162,
			  162,  884,  884, 1016,  162,  162,  888,  162, 1016, 1016,
			  162,  157,  162,  162, 1016,  162,  886,  162, 1016,  162,
			  157,  162,  162, 1016,  887,  162,  162,  162, 1016,  162,
			  162,  162,  157, 1016, 1016, 1016,  157,  157,  888,  162,
			 1016, 1016,  162,  162,  162,  162, 1016,  162,  890,  889,

			 1016,  162,  162,  162,  162,  157,  888,  162,  157,  157,
			 1016, 1016,  157,  892,  162, 1016,  893, 1016,  162,  162,
			 1016, 1016,  157, 1016,  162,  157,  162, 1016,  891, 1016,
			  890,  890, 1016,  162, 1016,  162,  162,  162,  157, 1016,
			  162,  162,  895,  896,  162,  892,  894, 1016,  894,  162,
			  162,  162,  162, 1016,  162,  157, 1016,  162,  898,  157,
			  892,  162,  162,  897, 1016,  162, 1016,  162,  157, 1016,
			  162, 1016,  157, 1016,  896,  896,  157,  162,  894, 1016,
			 1016,  162,  162,  162,  162,  899,  162,  162,  162, 1016,
			  898,  162,  900,  162,  162,  898,  902,  162,  162,  162,

			  162, 1016,  157,  162,  162,  162,  901, 1016,  162,  162,
			  157, 1016, 1016, 1016,  157,  162, 1016,  900,  162,  157,
			  162, 1016, 1016, 1016,  900, 1016, 1016,  157,  902,  903,
			  162,  162,  157,  162,  162,  162,  157,  162,  902,  904,
			 1016,  907,  162,  162, 1016,  157,  162,  162,  162,  157,
			  162,  162, 1016,  157,  162, 1016,  162,  157,  157,  162,
			  162,  904,  906,  162,  162,  162,  162,  162,  162,  162,
			  157,  904,  905,  908,  157,  162, 1016,  162,  157,  162,
			  162,  162,  162, 1016,  908,  162,  162, 1016,  162,  162,
			  162,  157,  162, 1016,  906,  162, 1016,  162,  162,  162,

			 1016,  162,  162, 1016,  906,  157,  162,  162,  157,  157,
			  162,  162,  911,  909, 1016,  910,  908,  912,  162, 1016,
			  162, 1016,  157,  162,  162,  157,  162,  162,  514,  162,
			  162,  157, 1016, 1016, 1016,  157,  162,  162,  514,  162,
			  162,  162, 1016, 1016,  912,  910,  522,  910,  157,  912,
			  162, 1016,  162,  162,  162,  162,  162,  162,  162,  162,
			  157,  914,  162,  162,  157,  162,  522,  162,  162, 1016,
			 1016,  162, 1016,  913, 1016, 1016,  106,  157, 1016,  544,
			  162,  973,  973,  973,  973,  162, 1016,  162,  118, 1016,
			 1016,  162,  162,  914, 1016, 1016,  162,  162,  843,  843,

			  843,  843, 1016,  162, 1016,  914, 1016, 1016, 1016,  162,
			 1016, 1016,  919, 1016,  515,  516,  517,  518,  519,  520,
			  521,  845, 1016, 1016,  515,  516,  517,  518,  519,  520,
			  521, 1016,  523,  524,  525,  526,  527,  528,  529, 1016,
			 1004, 1004, 1004, 1004,  919,  927,  927,  927,  927,  162,
			 1016,  162,  523,  524,  525,  526,  527,  528,  529,  928,
			 1016,  162,  312,  313,  314,  315,  316,  317,  318,  157,
			  157, 1016, 1016,  157,  157,  157,  162, 1016,  162,  157,
			  739,  162, 1016,  162,  930, 1016,  157,  157,  162,  929,
			 1016,  928,  157,  162, 1016,  157, 1016, 1016, 1016,  157,

			 1016,  162,  162, 1016, 1016,  162,  162,  162,  162,  931,
			  162,  162,  157,  162, 1016,  162,  930, 1016,  162,  162,
			  162,  930, 1016, 1016,  162,  162,  162,  162,  162,  932,
			 1016,  162,  157,  157, 1016, 1016,  157,  935,  162, 1016,
			  162,  932,  162, 1016,  162,  162, 1016,  162,  934,  157,
			  157,  933,  162, 1016, 1016, 1016, 1016,  162,  162,  157,
			  162,  932, 1016,  157,  162,  162,  936, 1016,  162,  936,
			  162, 1016,  162,  162,  162,  162,  157,  162, 1016,  162,
			  934,  162,  162,  934,  162,  162,  157, 1016, 1016,  162,
			  157,  162,  162,  157,  162,  162,  157,  937,  936, 1016, yy_Dummy>>,
			1, 1000, 7000)
		end

	yy_nxt_template_9 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			  157, 1016,  939,  157,  162,  162,  157,  162,  162,  162,
			  157,  162, 1016,  157, 1016, 1016, 1016,  162,  162,  157,
			 1016,  162,  162,  157,  162,  162,  162,  941,  162,  938,
			  938,  162,  162,  162,  940,  162,  162,  162,  162,  162,
			  157,  940,  162,  162, 1016,  162, 1016, 1016, 1016,  162,
			 1016,  162,  162, 1016,  162,  162, 1016, 1016, 1016,  942,
			 1016,  942,  938,  162,  162,  162, 1016, 1016,  162,  162,
			  162,  162,  162,  940,  157,  162, 1016,  162,  157,  162,
			  162,  162, 1016, 1016,  162,  162,  162,  162, 1016,  162,
			  157,  157,  944,  942,  157, 1016,  162,  162, 1016,  951,

			  162,  157,  162,  157, 1016,  157,  162,  157,  943,  162,
			  162,  162,  162,  162,  945,  946,  157,  162,  157,  162,
			 1016,  162,  162,  162,  944,  162,  162, 1016, 1016,  162,
			 1016,  952,  157,  162, 1016,  162,  157,  162, 1016,  162,
			  944, 1016, 1016, 1016, 1016,  162,  946,  946,  162,  157,
			  162,  947,  157,  162, 1016,  162,  157,  162,  162, 1016,
			  162,  948, 1016,  952,  162,  162,  950, 1016,  162,  157,
			  162,  949, 1016, 1016,  162, 1016,  162, 1016, 1016, 1016,
			 1016,  162, 1016,  948,  162,  162,  162,  162,  162, 1016,
			  162, 1016,  162,  948, 1016,  952,  157,  162,  950, 1016,

			  157,  162,  162,  950, 1016, 1016,  162, 1016,  162,  162,
			  157,  162,  157,  157,  157,  953,  157,  954,  162, 1016,
			 1016,  162, 1016,  162,  162,  162,  162,  157,  162,  157,
			  955,  956,  162, 1016, 1016,  162,  162, 1016,  162, 1016,
			  958,  162,  162,  162,  162,  162,  162,  954,  162,  954,
			  162, 1016, 1016,  162, 1016,  162,  162,  162,  162,  162,
			  157,  162,  956,  956,  157, 1016, 1016,  162,  162, 1016,
			  162,  157,  958,  957,  162,  157,  960,  157,  162, 1016,
			  162,  157,  162,  157,  959,  157,  162,  961,  157, 1016,
			  162, 1016,  162, 1016, 1016,  962,  162, 1016,  157,  162,

			  157,  162,  162,  162,  162,  958,  162,  162,  960,  162,
			  162,  162,  162,  162,  162,  162,  960,  162,  162,  962,
			  162,  157,  162, 1016,  157,  157, 1016,  962,  157, 1016,
			  162,  162,  162,  162,  162,  162,  162,  162,  157, 1016,
			  162,  157,  162,  162,  157,  157,  162,  162,  157,  157,
			 1016, 1016,  162,  162, 1016, 1016,  162,  162, 1016, 1016,
			  162,  157,  157,  162,  963,  162, 1016,  162, 1016,  162,
			  162,  964,  162,  162,  162,  162,  162,  162, 1016,  162,
			  162,  162,  157, 1016,  162,  157,  157, 1016,  162,  157,
			  966, 1016, 1016,  162,  162,  162,  964,  162,  965,  157,

			  162, 1016,  157,  964,  162, 1016,  162,  162,  157, 1016,
			 1016,  162,  157,  162,  162, 1016,  162,  162,  162,  968,
			  162,  162,  966,  162, 1016,  157, 1016,  967, 1016, 1016,
			  966,  162,  162,  157,  162, 1016,  162,  157,  162, 1016,
			  162, 1016, 1016,  162,  162,  162, 1016, 1016,  162, 1016,
			  157,  968,  162, 1016,  162,  162, 1016,  162, 1016,  968,
			  977,  977,  977,  977,  162,  162,  157, 1016, 1016,  162,
			  157, 1016,  157,  162,  975,  981,  157, 1016,  162,  980,
			  162, 1016,  162,  157,  162,  162,  162, 1016, 1016,  157,
			  162,  987, 1016,  162, 1016, 1016,  162, 1016,  162, 1016,

			  594, 1016,  162,  162,  162,  162,  975,  981,  162, 1016,
			  162,  981,  162, 1016, 1016,  162,  157,  162,  983,  982,
			  157,  162,  162,  987, 1016,  162,  162,  157,  162,  985,
			  984,  157, 1016,  157, 1016,  162,  157,  162,  162,  162,
			  157, 1016, 1016, 1016,  157, 1016, 1016,  986,  162,  162,
			  983,  983,  162,  157,  162,  162,  162,  162,  162,  162,
			  162,  985,  985,  162, 1016,  162,  162,  162,  162,  162,
			  162,  162,  162,  157,  157,  989,  162,  157,  157,  987,
			  162,  162,  162, 1016, 1016,  162,  162,  162,  162,  162,
			  157,  157,  162, 1016, 1016, 1016,  157, 1016,  162,  162,

			  157, 1016,  988, 1016,  157,  162,  162,  989,  157,  162,
			  162, 1016,  162,  157,  162,  162,  157,  162, 1016, 1016,
			  157,  157,  162,  162,  162, 1016,  157,  162,  162,  162,
			  157,  162,  162,  157,  989, 1016,  162, 1016, 1016,  990,
			  162,  162,  162,  157,  991,  162, 1016,  162,  162,  162,
			 1016,  157,  162,  162,  162,  992, 1016, 1016,  162,  162,
			  993,  162,  162,  162, 1016,  162, 1016,  162,  157,  162,
			 1016,  991, 1016,  162,  162,  162,  991,  157, 1016,  162,
			  157,  157, 1016,  162,  996, 1016,  162,  993, 1016, 1016,
			 1016,  994,  993,  162,  157,  162,  995,  157, 1016,  162,

			  162,  162, 1016, 1016,  157,  162,  998, 1016,  157,  162,
			 1016,  162,  162,  162,  157,  997,  997, 1016,  157, 1016,
			 1016,  157,  162,  995,  162,  162,  162,  162,  995,  162,
			  999,  157, 1016,  162,  162,  162,  162,  162,  999,  162,
			  162,  162, 1016, 1016,  157,  162,  162,  997, 1000, 1016,
			  162,  162, 1016,  162,  162, 1016,  162, 1008, 1008, 1008,
			 1008,  157,  999,  162, 1016,  162,  162,  162, 1016, 1016,
			  157,  162, 1001,  162, 1002, 1003,  162,  162, 1016,  162,
			 1001,  162,  162,  162,  162, 1016,  157,  157,  157, 1016,
			  157,  162,  157,  162,  162, 1016,  162,  746,  162, 1016,

			 1016, 1016,  162,  157, 1001,  157, 1003, 1003,  162, 1016,
			 1016,  162, 1016,  162,  162,  162,  162,  162,  162,  162,
			  162,  157,  162,  162,  162,  157,  162,  162,  162, 1016,
			  162,  922,  922,  922,  922,  162, 1016,  162,  157, 1016,
			  162, 1016,  162, 1016,  162,  975,  157,  162,  157,  162,
			  157, 1016,  157,  162,  162, 1016,  162,  162,  162,  162,
			  162, 1016,  162,  157, 1016,  157, 1016, 1016,  162, 1016,
			  162,  594,  162,  162,  162,  162,  162,  975,  162,  157,
			  162, 1016,  162,  157,  162,  162,  162, 1016,  162,  157,
			  162, 1016,  162,  157,  162,  162,  157,  162, 1016, 1016,

			  162,  162, 1016,  162,  162,  162,  157,  162, 1009, 1010,
			  157,  162,  157,  162,  157,  162,  157,  162,  162,  157,
			  162,  162,  162,  157,  162,  162, 1016,  157,  162, 1011,
			  162, 1016, 1016,  162,  162,  162,  157,  162,  162,  162,
			 1010, 1010,  162, 1012,  162,  162,  162, 1016,  162,  162,
			  162,  162,  162,  157,  162,  162,  162, 1013, 1014,  162,
			 1016, 1012,  162, 1016, 1016,  162,  162,  162,  162,  162,
			  157,  162, 1016, 1016,  157, 1012, 1016,  162,  157,  157,
			  162,  162,  162,  157, 1016,  162,  162, 1016,  162, 1014,
			 1014,  157,  162, 1016, 1016, 1016,  157,  162,  162,  162, yy_Dummy>>,
			1, 1000, 8000)
		end

	yy_nxt_template_10 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			 1016, 1016,  162, 1016, 1016, 1016,  162, 1016, 1016,  162,
			  162,  162,  162, 1016,  162,  162, 1016, 1016,  162, 1016,
			  162, 1016, 1016,  162,  162, 1016, 1016, 1016,  162, 1016,
			  162,  969,  969,  969,  969, 1015, 1015, 1015, 1015,  976,
			  976,  976,  976, 1016,  157, 1016, 1016, 1016,  157,  157,
			  162, 1016,  162,  157, 1016,  162,  157,  162, 1016, 1016,
			  157,  157,  162, 1016, 1016, 1016,  157,  162, 1016, 1016,
			 1016,  739, 1016,  157, 1016,  845,  162, 1016, 1016,  746,
			  162,  162,  162, 1016,  162,  162, 1016,  162,  162,  162,
			 1016, 1016,  162,  162,  162,  162, 1016,  162,  162,  162,

			 1005, 1005, 1005, 1005, 1016,  162, 1016,  162,  145,  145,
			  145,  145,  145,  145,  145,  145,  145,  145,  145,  145,
			  145,  145, 1016, 1016, 1016, 1016, 1016,  162, 1016,  162,
			 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016,  162,
			  845,   86,   86,   86,   86,   86,   86,   86,   86,   86,
			   86,   86,   86,   86,   86,   86,   86,   86,   86,   86,
			   86,   86,   86,   86,  105,  105, 1016,  105,  105,  105,
			  105,  105,  105,  105,  105,  105,  105,  105,  105,  105,
			  105,  105,  105,  105,  105,  105,  105,  117, 1016, 1016,
			 1016, 1016, 1016, 1016,  117,  117,  117,  117,  117,  117,

			  117,  117,  117,  117,  117,  117,  117,  117,  117,  117,
			  118,  118, 1016,  118,  118,  118,  118,  118,  118,  118,
			  118,  118,  118,  118,  118,  118,  118,  118,  118,  118,
			  118,  118,  118,  126,  126, 1016,  126,  126,  126,  126,
			 1016,  126,  126,  126,  126,  126,  126,  126,  126,  126,
			  126,  126,  126,  126,  126,  126,  247,  247, 1016,  247,
			  247,  247, 1016, 1016,  247,  247,  247,  247,  247,  247,
			  247,  247,  247,  247,  247,  247,  247,  247,  247,  162,
			  162,  162,  162,  162,  162,  162,  162,  162,  162,  162,
			  162,  162,  162,  268, 1016, 1016,  268, 1016,  268,  268,

			  268,  268,  268,  268,  268,  268,  268,  268,  268,  268,
			  268,  268,  268,  268,  268,  268,  282,  282, 1016,  282,
			  282,  282,  282,  282,  282,  282,  282,  282,  282,  282,
			  282,  282,  282,  282,  282,  282,  282,  282,  282,  283,
			  283, 1016,  283,  283,  283,  283,  283,  283,  283,  283,
			  283,  283,  283,  283,  283,  283,  283,  283,  283,  283,
			  283,  283,  307,  307, 1016,  307,  307,  307,  307,  307,
			  307,  307,  307,  307,  307,  307,  307,  307,  307,  307,
			  307,  307,  307,  307,  307,  333, 1016, 1016, 1016, 1016,
			  333,  333,  333,  333,  333,  333,  333,  333,  333,  333,

			  333,  333,  333,  333,  333,  333,  333,  333,  373,  373,
			  373,  373,  373,  373,  373,  373, 1016,  373,  373,  373,
			  373,  373,  373,  373,  373,  373,  373,  373,  373,  373,
			  373,  380,  380,  380,  380,  380,  380,  380,  380,  380,
			  380,  380,  380,  380,  382,  382,  382,  382,  382,  382,
			  382,  382,  382,  382,  382,  382,  382,  384,  384,  384,
			  384,  384,  384,  384,  384,  384,  384,  384,  384,  384,
			  278,  278, 1016,  278,  278,  278, 1016,  278,  278,  278,
			  278,  278,  278,  278,  278,  278,  278,  278,  278,  278,
			  278,  278,  278,  279,  279, 1016,  279,  279,  279, 1016,

			  279,  279,  279,  279,  279,  279,  279,  279,  279,  279,
			  279,  279,  279,  279,  279,  279,  926,  926,  926,  926,
			  926,  926,  926,  926, 1016,  926,  926,  926,  926,  926,
			  926,  926,  926,  926,  926,  926,  926,  926,  926,    5,
			 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016,
			 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016,
			 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016,
			 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016,
			 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016,
			 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016,

			 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016,
			 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016,
			 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016,
			 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, yy_Dummy>>,
			1, 639, 9000)
		end

	yy_chk_template: SPECIAL [INTEGER] is
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make (0, 9638)
			yy_chk_template_1 (an_array)
			yy_chk_template_2 (an_array)
			yy_chk_template_3 (an_array)
			yy_chk_template_4 (an_array)
			yy_chk_template_5 (an_array)
			yy_chk_template_6 (an_array)
			yy_chk_template_7 (an_array)
			yy_chk_template_8 (an_array)
			yy_chk_template_9 (an_array)
			yy_chk_template_10 (an_array)
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

			    3,    3,    3,    3,   22,   23, 1005,   23,   23,   23,
			   23,    4,    4,    4,    4,   22,   24,   26,  145,   26,
			   26,   26,   26,  976,   24,   30,   30,  150,   12,  842,
			   26,   12,   32,   32,  969,   15,  378,   16,   15,   16,
			   16,   79,   79,   79,   25,   16,   25,   25,   25,   25,
			   81,   81,   81,   82,   82,  842,    3,   25,   25,   26,
			  145,  842,   26,   83,   83,   83,  604,    4,   27,  150,
			   27,   27,   27,   27,   84,   84,   84,   12,  378,   25,
			  167,  167,  167,  169,  169,  169,   25,    3,  602,   25,
			   25,    3,    3,    3,    3,    3,    3,    3,    4,  146,

			  146,  600,    4,    4,    4,    4,    4,    4,    4,   12,
			   27,   25,  170,  170,   12,   12,   12,   12,   12,   12,
			   12,   15,   15,   15,   15,   15,   15,   15,   16,   16,
			   16,   16,   16,   16,   16,   34,   34,   34,   34,  146,
			  171,  171,  171,  258,  258,   34,   34,   34,   34,   34,
			   34,   34,   34,   34,   34,   34,   34,   34,   34,   34,
			   34,   34,   34,   34,   34,   34,   34,   34,   34,   34,
			   34,  172,  172,  172,  384,   34,  382,   34,   34,   34,
			   34,   34,   34,   34,   34,   34,   34,   34,   34,   34,
			   34,   34,   34,   34,   34,   34,   34,   34,   34,   34,

			   34,   34,   34,  380,  139,  139,  139,  139,   34,   34,
			   34,   34,   34,   34,   34,   35,  344,   35,  139,  922,
			   35,  280,   35,  255,  255,  255,   40,   35,  261,  256,
			   40,   57,   57,   57,   57,   57,   57,   57,  173,  142,
			  142,  142,  142,   40,  139,  922,  168,   35,  127,   35,
			  139,  922,   35,  142,   35,  257,  257,  257,   40,   35,
			   36,   36,   40,   37,  103,   36,   37,   36,   36,  102,
			   37,   36,   36,   37,   36,   40,   37,   38,  101,   37,
			  100,   88,   38,   85,   38,  142,  259,  259,  259,   38,
			  379,  379,   36,   36,   38,   37,   80,   36,   37,   36,

			   36,   54,   37,   36,   36,   37,   36,   33,   37,   38,
			   28,   37,  599,  599,   38,   11,   38,   87,   39,   87,
			   87,   38,   39,   10,   39,    9,   38,    8,    7,   39,
			  379,   39,   41,   41,    5,   39,   39,    0,   41,   41,
			   41,    0,    0,   42,    0,   41,    0,   42,    0,   45,
			   39,   42,  599,   45,   39,    0,   39,   42,    0,    0,
			   42,   39,    0,   39,   41,   41,   45,   39,   39,    0,
			   41,   41,   41,   87,   43,   42,   46,   41,   43,   42,
			   46,   45,    0,   42,    0,   45,   44,   44,   43,   42,
			   44,   43,   42,   46,    0,    0,   47,   44,   45,   44,

			   47,    0,    0,   44,   87,    0,   43,   48,   46,    0,
			   43,   48,   46,   47,   48,   47,    0,   49,   44,   44,
			   43,   49,   44,   43,   48,   46,    0,    0,   47,   44,
			   49,   44,   47,    0,   49,   44,    0,   50,   64,   48,
			   64,   50,    0,   48,    0,   47,   48,   47,   51,   49,
			   64,   50,   51,   49,   50,   51,   48,   52,  260,  260,
			  260,   52,   49,    0,  157,   51,   49,   59,  157,   50,
			   64,   52,   64,   50,   52,    0,  147,  147,  147,    0,
			   51,  157,   64,   50,   51,    0,   50,   51,    0,   52,
			  262,  262,  262,   52,    0,    0,  157,   51,   61,   59,

			  157,    0,    0,   52,    0,    0,   52,   58,   61,   69,
			    0,   69,   58,  157,   58,   69,  147,    0,    0,   58,
			    0,   69,   59,   59,   59,   59,   59,   59,   59,    0,
			   61,   86,   86,   86,   86,   86,   86,   86,    0,   58,
			   61,   69,    0,   69,   58,    0,   58,   69,  263,  263,
			  263,   58,   90,   69,   90,   90,    0,   61,   61,   61,
			   61,   61,   61,   61,   58,   58,   58,   58,   58,   58,
			   58,   60,    0,    0,   66,   60,    0,   66,   60,   66,
			   66,   60,    0,  144,   60,  144,  144,  144,  144,   66,
			   62,    0,   62,   93,   93,   93,   93,   93,   93,   93,

			    0,    0,   62,   60,    0,    0,   66,   60,   90,   66,
			   60,   66,   66,   60,    0,    0,   60,  264,  264,  264,
			    0,   66,   62,    0,   62,  144,    0,   60,   60,   60,
			   60,   60,   60,   60,   62,  265,  265,  265,    0,   90,
			    0,    0,   62,   62,   62,   62,   62,   62,   62,   63,
			   65,    0,   67,   63,   67,   67,   65,   65,   65,    0,
			   63,   68,   63,   65,   67,    0,   63,    0,   65,    0,
			    0,   68,   63,   68,  266,  266,  266,   68,  267,  267,
			  267,   63,   65,   68,   67,   63,   67,   67,   65,   65,
			   65,    0,   63,   68,   63,   65,   67,    0,   63,   70,

			   65,    0,    0,   68,   63,   68,   70,   71,   70,   68,
			  397,  397,  397,   72,   71,   68,   71,   72,   70,   72,
			    0,   74,   71,   72,    0,   73,   71,   73,    0,   72,
			    0,   70,   74,    0,   74,   74,    0,   73,   70,   71,
			   70,  381,  381,  381,   74,   72,   71,    0,   71,   72,
			   70,   72,    0,   74,   71,   72,   75,   73,   71,   73,
			   75,   72,   75,    0,   74,    0,   74,   74,   76,   73,
			   76,   76,   75,    0,    0,   89,   74,   89,   89,    0,
			   76,  381,   91,    0,    0,   91,    0,   91,   75,    0,
			   91,    0,   75,   92,   75,    0,   92,    0,   92,    0,

			   76,   92,   76,   76,   75,  268,  268,  268,  268,  268,
			  268,  268,   76,   94,   94,   94,   94,   94,   94,   94,
			   94,   95,   95,   95,   95,   95,   95,   95,   95,   95,
			   95,   89,   96,   96,  126,   96,   96,   96,   96,   96,
			   96,   96,   97,   97,   97,   97,   97,   97,   97,   97,
			   97,   97,   98,   98,   98,   98,   98,   98,   98,   98,
			   98,   98,   89,  398,  398,  398,   89,   89,   89,   89,
			   89,   89,   89,   91,   91,   91,   91,   91,   91,   91,
			  105,    0,    0,  105,   92,   92,   92,   92,   92,   92,
			   92,   99,    0,    0,   99,   99,   99,   99,   99,   99, yy_Dummy>>,
			1, 1000, 0)
		end

	yy_chk_template_2 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			   99,  143,    0,  143,  143,  143,  143,  149,    0,  149,
			  149,  149,  149,    0,  143,    0,  126,  126,  126,  126,
			  126,  126,  126,  372,  372,  372,  372,    0,    0,  105,
			    0,    0,  108,    0,  108,  108,    0,  108,    0,    0,
			  108,    0,    0,  143,    0,  109,  143,  109,  109,  149,
			  109,    0,    0,  109,  269,  269,  269,  269,  269,  269,
			  269,  105,  110,    0,    0,  110,  105,  105,  105,  105,
			  105,  105,  105,  107,    0,    0,  107,  107,  107,  107,
			  399,  399,  399,    0,  118,  107,  108,  118,  400,  400,
			  400,    0,  107,    0,  107,    0,  107,  107,  107,  109,

			  135,  107,    0,  107,  401,  401,  401,  107,    0,  107,
			    0,  110,  107,  107,  107,  107,  107,  107,  108,  111,
			    0,    0,  111,  108,  108,  108,  108,  108,  108,  108,
			    0,  109,  112,    0,    0,  112,  109,  109,  109,  109,
			  109,  109,  109,  110,  113,    0,    0,  113,  110,  110,
			  110,  110,  110,  110,  110,  119,    0,    0,  119,  107,
			  107,  107,  107,  107,  107,  107,    0,    0,  111,    0,
			  118,  118,  118,  118,  118,  118,  118,  114,    0,  135,
			  114,  112,  135,  135,  135,  135,  135,  135,  135,  115,
			    0,    0,  115,  113,    0,    0,  276,    0,  276,  276,

			  111,  402,  402,  402,  111,  111,  111,  111,  111,  111,
			  111,  111,    0,  112,    0,  112,  112,  112,  112,  112,
			  112,  112,  112,  112,  112,  113,  114,  113,  113,    0,
			  113,  113,  113,  113,  113,  113,  113,  116,  115,    0,
			  116,  119,  119,  119,  119,  119,  119,  119,  120,    0,
			    0,  120,  276,  506,  506,  506,    0,    0,  114,    0,
			  114,  114,  114,  114,  114,  114,  114,  114,  114,  114,
			  115,  129,  115,  115,  115,  115,  115,  115,  115,  115,
			  115,  115,  121,  276,    0,  121,  116,  162,    0,  162,
			    0,    0,  122,    0,    0,  122,  507,  507,  507,  162,

			    0,  371,  123,  371,    0,  123,  371,  371,  371,  371,
			    0,    0,  124,    0,    0,  124,    0,    0,  116,  162,
			  116,  162,    0,  116,  116,  116,  116,  116,  116,  116,
			  130,  162,    0,  120,  120,  120,  120,  120,  120,  120,
			  120,  125,    0,    0,  125,  508,  508,  508,    0,    0,
			  129,  129,  129,  129,  129,  129,  129,  129,  129,  129,
			  509,  509,  509,    0,    0,  121,  121,  121,  121,  121,
			  121,  121,  121,  121,  121,  122,  122,    0,  122,  122,
			  122,  122,  122,  122,  122,  123,  123,  123,  123,  123,
			  123,  123,  123,  123,  123,  124,  124,  124,  124,  124,

			  124,  124,  124,  124,  124,  131,    0,  277,    0,  277,
			  277,  130,  130,  130,  130,  130,  130,  130,  130,  132,
			  510,  510,  510,    0,  125,    0,  247,  125,  125,  125,
			  125,  125,  125,  125,  128,    0,    0,  128,  128,  128,
			  128,  511,  511,  511,    0,    0,  128,    0,  133,  512,
			  512,  512,    0,  128,    0,  128,    0,  128,  128,  128,
			  128,  134,  128,  277,  128,  513,  513,  513,  128,    0,
			  128,    0,    0,  128,  128,  128,  128,  128,  128,  589,
			  589,  589,  589,    0,  131,  131,  131,  131,  131,  131,
			  131,  131,  131,  131,  277,  613,  613,  613,  132,  132,

			    0,  132,  132,  132,  132,  132,  132,  132,  247,  247,
			  247,  247,  247,  247,  247,    0,  590,  590,  590,  590,
			  128,  128,  128,  128,  128,  128,  128,  133,  133,  133,
			  133,  133,  133,  133,  133,  133,  133,  614,  614,  614,
			  134,  134,  134,  134,  134,  134,  134,  134,  134,  134,
			  148,  148,  148,  148,    0,  158,  590,    0,  248,  158,
			  148,  148,  148,  148,  148,  148,  159,  713,  713,  713,
			  159,  161,  158,    0,  159,  161,    0,  159,  591,  591,
			  591,  591,  160,  159,    0,  160,  160,  158,  161,  161,
			  148,  158,  148,  148,  148,  148,  148,  148,  159,  160,

			    0,    0,  159,  161,  158,    0,  159,  161,  377,  159,
			  377,  377,  377,  377,  160,  159,  163,  160,  160,  164,
			  161,  161,  164,  163,  164,  163,  166,    0,  166,  165,
			    0,  160,    0,  166,  164,  163,    0,  165,  166,  165,
			  248,  248,  248,  248,  248,  248,  248,    0,  163,  165,
			  377,  164,    0,    0,  164,  163,  164,  163,  166,  174,
			  166,  165,    0,  174,    0,  166,  164,  163,    0,  165,
			  166,  165,  175,  176,  175,  177,  174,  176,  174,  177,
			  175,  165,  179,  178,  175,  180,  179,  178,    0,  180,
			  176,  174,  177,    0,  181,  174,  178,    0,    0,  179,

			  178,  181,  180,  181,  175,  176,  175,  177,  174,  176,
			  174,  177,  175,  181,  179,  178,  175,  180,  179,  178,
			    0,  180,  176,    0,  177,  182,  181,  183,  178,  183,
			    0,  179,  178,  181,  180,  181,  182,  184,  182,  183,
			    0,  185,    0,  185,  184,  181,  184,  185,  182,    0,
			  186,  186,    0,  185,  186,  186,  184,  182,    0,  183,
			  187,  183,  188,    0,  187,    0,  188,  186,  182,  184,
			  182,  183,  188,  185,  188,  185,  184,  187,  184,  185,
			  182,    0,  186,  186,  188,  185,  186,  186,  184,  189,
			    0,  189,  187,  190,  188,    0,  187,  190,  188,  186,

			    0,  189,    0,    0,  188,    0,  188,    0,    0,  187,
			  190,  190,    0,    0,  191,    0,  188,  191,  191,    0,
			  192,  189,    0,  189,  192,  190,  714,  714,  714,  190,
			    0,  191,  191,  189,    0,  192,    0,  192,    0,  192,
			    0,    0,  190,  190,    0,    0,  191,    0,    0,  191,
			  191,    0,  192,  193,    0,  193,  192,    0,  194,    0,
			  193,    0,    0,  191,  191,  193,  194,  192,  194,  192,
			    0,  192,  195,  194,  195,    0,  195,  196,  194,  197,
			  195,  196,    0,  197,  195,  193,    0,  193,  196,    0,
			  194,  199,  193,  199,  196,    0,  197,  193,  194,    0,

			  194,    0,    0,  199,  195,  194,  195,    0,  195,  196,
			  194,  197,  195,  196,    0,  197,  195,  198,    0,  200,
			  196,  198,    0,  199,    0,  199,  196,    0,  197,  202,
			  200,  198,  200,  202,  198,  199,  201,  203,  201,  201,
			  205,  203,  200,    0,  205,    0,  202,    0,  201,  198,
			    0,  200,  203,  198,  203,    0,    0,  205,    0,    0,
			    0,  202,  200,  198,  200,  202,  198,    0,  201,  203,
			  201,  201,  205,  203,  200,    0,  205,    0,  202,    0,
			  201,  206,    0,  206,  203,    0,  203,  204,    0,  205,
			  204,  204,  204,  206,  204,  207,    0,  207,  209,  207, yy_Dummy>>,
			1, 1000, 1000)
		end

	yy_chk_template_3 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			  209,    0,    0,    0,  204,  204,    0,  207,  204,    0,
			  209,    0,    0,  206,    0,  206,    0,    0,  284,  204,
			  284,  284,  204,  204,  204,  206,  204,  207,    0,  207,
			  209,  207,  209,    0,    0,    0,  204,  204,    0,  207,
			  204,  208,  209,  208,    0,  208,    0,    0,  210,  208,
			    0,  208,  210,  211,    0,  211,  208,  211,  210,  208,
			    0,  208,    0,  212,  212,  210,  212,  211,    0,    0,
			  211,    0,    0,  208,  284,  208,  212,  208,    0,    0,
			  210,  208,    0,  208,  210,  211,    0,  211,  208,  211,
			  210,  208,  213,  208,    0,  212,  212,  210,  212,  211,

			    0,  213,  211,  213,  213,  284,  214,  215,  212,  215,
			  214,    0,  216,  213,  217,  215,  216,  217,  217,  215,
			    0,    0,    0,  214,  213,  214,    0,    0,    0,  216,
			  216,  217,    0,  213,    0,  213,  213,    0,  214,  215,
			    0,  215,  214,    0,  216,  213,  217,  215,  216,  217,
			  217,  215,  218,    0,  218,  214,  218,  214,    0,    0,
			  219,  216,  216,  217,  219,    0,  220,    0,  220,  218,
			  223,  221,  223,  220,  222,    0,  224,  219,  220,  221,
			  224,  221,  223,  222,  218,  222,  218,    0,  218,    0,
			    0,  221,  219,  224,    0,  222,  219,    0,  220,    0,

			  220,  218,  223,  221,  223,  220,  222,    0,  224,  219,
			  220,  221,  224,  221,  223,  222,    0,  222,  228,  225,
			  229,    0,  228,  221,  229,  224,  225,  222,  225,  228,
			  230,    0,  230,  228,  230,  228,  232,  229,  225,    0,
			  232,    0,  230,  285,  285,  285,  285,  285,  285,  285,
			  228,  225,  229,  232,  228,    0,  229,    0,  225,    0,
			  225,  228,  230,    0,  230,  228,  230,  228,  232,  229,
			  225,  226,  232,  226,  230,  226,  231,    0,  231,  233,
			    0,  226,  231,  233,  226,  232,  226,  226,  231,  226,
			  594,  594,  594,  594,    0,    0,  233,    0,    0,  233,

			  601,  601,  601,  226,    0,  226,    0,  226,  231,    0,
			  231,  233,    0,  226,  231,  233,  226,    0,  226,  226,
			  231,  226,  227,    0,  227,    0,    0,  234,  233,    0,
			  227,  233,  227,    0,  234,  227,  234,  227,  227,  235,
			  601,  235,  227,  238,    0,    0,  234,  238,  235,    0,
			    0,  235,    0,    0,  227,    0,  227,    0,    0,  234,
			  238,    0,  227,    0,  227,    0,  234,  227,  234,  227,
			  227,  235,    0,  235,  227,  238,    0,    0,  234,  238,
			  235,  236,    0,  235,  236,  236,  237,    0,    0,  236,
			    0,  237,  238,  239,  237,  242,  237,  239,  236,  242,

			  236,  239,  237,  240,    0,  240,  237,    0,    0,  240,
			  239,    0,  242,  236,    0,  240,  236,  236,  237,  249,
			    0,  236,  278,  237,    0,  239,  237,  242,  237,  239,
			  236,  242,  236,  239,  237,  240,  250,  240,  237,  243,
			  241,  240,  239,  241,  242,  241,  243,  240,  243,  244,
			  245,  251,  245,  244,    0,  241,  245,    0,  243,    0,
			    0,  252,  245,    0,    0,    0,  244,  595,  595,  595,
			  595,  243,  241,  253,    0,  241,    0,  241,  243,    0,
			  243,  244,  245,  254,  245,  244,    0,  241,  245,    0,
			  243,    0,    0,    0,  245,    0,    0,    0,  244,    0,

			  249,  249,  249,  249,  249,  249,  249,  249,  278,  278,
			  278,  278,  278,  278,  278,  250,  250,  250,  250,  250,
			  250,  250,  250,  250,  250,  739,  739,  739,  739,    0,
			  251,  251,    0,  251,  251,  251,  251,  251,  251,  251,
			  252,  252,  252,  252,  252,  252,  252,  252,  252,  252,
			  279,    0,  253,  253,  253,  253,  253,  253,  253,  253,
			  253,  253,  254,    0,    0,  254,  254,  254,  254,  254,
			  254,  254,  270,  270,  270,  270,  270,  270,  270,  270,
			  271,  271,  271,  271,  271,  271,  271,  271,  271,  271,
			  272,  272,    0,  272,  272,  272,  272,  272,  272,  272,

			  273,  273,  273,  273,  273,  273,  273,  273,  273,  273,
			  274,  274,  274,  274,  274,  274,  274,  274,  274,  274,
			  275,    0,    0,  275,  275,  275,  275,  275,  275,  275,
			  281,    0,  281,  281,    0,    0,  279,  279,  279,  279,
			  279,  279,  279,  282,    0,    0,  282,    0,  282,    0,
			  283,  282,    0,  283,    0,  283,    0,  286,  283,    0,
			  286,    0,  286,    0,    0,  286,  287,    0,    0,  287,
			    0,  287,    0,    0,  287,    0,  288,    0,    0,  288,
			    0,  288,    0,    0,  288,    0,  281,  289,    0,    0,
			  289,    0,  289,    0,    0,  289,    0,  290,    0,    0,

			  290,    0,  290,    0,    0,  290,    0,  291,    0,    0,
			  291,    0,  291,    0,    0,  291,    0,  281,    0,    0,
			    0,  281,  281,  281,  281,  281,  281,  281,  740,  740,
			  740,  740,    0,    0,  282,  282,  282,  282,  282,  282,
			  282,  283,  283,  283,  283,  283,  283,  283,  286,  286,
			  286,  286,  286,  286,  286,    0,  287,  287,  287,  287,
			  287,  287,  287,  287,  288,  288,  288,  288,  288,  288,
			  288,  288,  288,  288,    0,  289,  289,    0,  289,  289,
			  289,  289,  289,  289,  289,  290,  290,  290,  290,  290,
			  290,  290,  290,  290,  290,  291,  291,  291,  291,  291,

			  291,  291,  291,  291,  291,  292,    0,    0,  292,    0,
			  292,    0,    0,  292,  293,  293,  293,  293,  293,  293,
			  293,  294,    0,    0,  294,  388,  294,  388,    0,  294,
			  295,    0,  392,  295,  392,  295,    0,  388,  295,    0,
			  296,    0,    0,  296,  392,  296,    0,    0,  296,    0,
			  297,    0,    0,  297,    0,  297,    0,  388,  297,  388,
			  298,    0,    0,  298,  392,  298,  392,    0,  298,  388,
			  299,    0,    0,  299,    0,  299,  392,    0,  299,    0,
			  300,    0,    0,  300,  375,  300,  375,    0,  300,  375,
			  375,  375,  375,  292,    0,    0,  292,  292,  292,  292,

			  292,  292,  292,  301,  301,  301,  301,  301,  301,  301,
			    0,    0,  294,  294,  294,  294,  294,  294,  294,    0,
			  295,  295,  295,  295,  295,  295,  295,  295,  296,  296,
			  296,  296,  296,  296,  296,  296,  296,  296,  297,  297,
			    0,  297,  297,  297,  297,  297,  297,  297,  298,  298,
			  298,  298,  298,  298,  298,  298,  298,  298,  299,  299,
			  299,  299,  299,  299,  299,  299,  299,  299,  300,    0,
			    0,  300,  300,  300,  300,  300,  300,  300,  302,  302,
			  302,  302,  302,  302,  302,  303,  303,  303,  303,  303,
			  303,  303,  304,  304,  304,  304,  304,  304,  304,  305, yy_Dummy>>,
			1, 1000, 2000)
		end

	yy_chk_template_4 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			  305,  305,  305,  305,  305,  305,  305,  305,  305,  306,
			  306,  306,  306,  306,  306,  306,  306,  306,  306,  307,
			    0,    0,  307,    0,    0,    0,  308,    0,    0,  308,
			    0,    0,    0,  309,  389,  387,  309,    0,  389,  387,
			  310,  390,    0,  310,    0,  390,    0,  311,  387,    0,
			  311,  389,  387,  310,  310,  310,  310,  312,  390,  376,
			  312,  376,  376,  376,  376,  313,  389,  387,  313,    0,
			  389,  387,  376,  390,    0,  314,    0,  390,  314,    0,
			  387,    0,    0,  389,  387,  315,    0,    0,  315,    0,
			  390,  742,  742,  742,  742,  316,    0,    0,  316,    0,

			    0,  376,    0,    0,  376,  307,  307,  307,  307,  307,
			  307,  307,  308,  308,  308,  308,  308,  308,  308,  309,
			  309,  309,  309,  309,  309,  309,  310,  310,  310,  310,
			  310,  310,  310,  311,  311,  311,  311,  311,  311,  311,
			    0,    0,    0,  312,  312,  312,  312,  312,  312,  312,
			  313,  313,  313,  313,  313,  313,  313,  313,  314,  314,
			  314,  314,  314,  314,  314,  314,  314,  314,  315,  315,
			    0,  315,  315,  315,  315,  315,  315,  315,  316,  316,
			  316,  316,  316,  316,  316,  316,  316,  316,  317,    0,
			    0,  317,  370,  370,  370,  370,    0,    0,  318,    0,

			    0,  318,    0,    0,    0,  319,  370,  319,  319,  394,
			  319,  394,    0,  319,    0,  374,  374,  374,  374,    0,
			  385,  394,  385,  385,  385,  385,    0,    0,  320,  374,
			  320,  320,  370,  320,    0,    0,  320,    0,  370,    0,
			    0,  394,    0,  394,  593,  321,  593,    0,  321,  593,
			  593,  593,  593,  394,    0,  374,    0,  322,    0,  319,
			  322,  374,  385,  386,    0,  386,  386,  386,  386,    0,
			    0,  317,  317,  317,  317,  317,  317,  317,  317,  317,
			  317,  318,  320,    0,  318,  318,  318,  318,  318,  318,
			  318,  319,  323,    0,  321,  323,  319,  319,  319,  319,

			  319,  319,  319,    0,  324,  386,  322,  324,  744,  744,
			  744,  744,  327,    0,  320,  327,    0,    0,    0,  320,
			  320,  320,  320,  320,  320,  320,  321,  325,    0,    0,
			  325,  321,  321,  321,  321,  321,  321,  321,  322,  326,
			    0,  323,  326,  322,  322,  322,  322,  322,  322,  322,
			    0,  328,    0,  324,  328,    0,    0,    0,  329,    0,
			    0,  329,    0,    0,    0,  330,    0,    0,  330,  746,
			  746,  746,  746,  323,    0,    0,  325,  333,  323,  323,
			  323,  323,  323,  323,  323,  324,  331,    0,  326,  331,
			  324,  324,  324,  324,  324,  324,  324,  335,  327,  327,

			  327,  327,  327,  327,  327,    0,  332,    0,  325,  332,
			  325,  325,  325,  325,  325,  325,  325,  325,  325,  325,
			  326,  336,  326,  326,  326,  326,  326,  326,  326,  326,
			  326,  326,  337,  841,  841,  841,  841,  328,  328,  328,
			  328,  328,  328,  328,  329,  329,  329,  329,  329,  329,
			  329,  330,  330,  330,  330,  330,  330,  330,  338,  333,
			  333,  333,  333,  333,  333,  333,    0,    0,  339,  331,
			  331,  331,  331,  331,  331,  331,  331,  331,  331,  335,
			  335,  335,  335,  335,  335,  335,  340,    0,    0,  332,
			  332,  332,  332,  332,  332,  332,  332,  332,  332,  341,

			    0,    0,  336,  336,  336,  336,  336,  336,  336,  336,
			  342,  337,  337,  337,  337,  337,  337,  337,  337,  337,
			  337,  343,  596,  596,  596,  596,    0,    0,  345,  845,
			  845,  845,  845,    0,    0,  346,    0,  338,  338,    0,
			  338,  338,  338,  338,  338,  338,  338,  339,  339,  339,
			  339,  339,  339,  339,  339,  339,  339,  348,  846,  846,
			  846,  846,  596,    0,  349,  340,  340,  340,  340,  340,
			  340,  340,  340,  340,  340,    0,    0,    0,  341,  347,
			    0,  341,  341,  341,  341,  341,  341,  341,  347,  347,
			  347,  347,  342,  342,  342,  342,  342,  342,  342,  350,

			    0,    0,    0,  343,  343,  343,  343,  343,  343,  343,
			  345,  345,  345,  345,  345,  345,  345,  346,  346,  346,
			  346,  346,  346,  346,  351,  404,    0,  404,    0,    0,
			  598,  352,  598,  598,  598,  598,    0,  404,  353,  348,
			  348,  348,  348,  348,  348,  348,  349,  349,  349,  349,
			  349,  349,  349,  354,    0,    0,    0,  404,    0,  404,
			  355,  347,  347,  347,  347,  347,  347,  347,  356,  404,
			    0,  839,  598,  839,    0,  357,  839,  839,  839,  839,
			    0,  350,  350,  350,  350,  350,  350,  350,  358,  605,
			    0,  605,  605,  605,  605,  359,  848,  848,  848,  848,

			    0,    0,  360,    0,    0,    0,  351,  351,  351,  351,
			  351,  351,  351,  352,  352,  352,  352,  352,  352,  352,
			  353,  353,  353,  353,  353,  353,  353,  361,    0,    0,
			    0,  605,    0,    0,  362,  354,  354,  354,  354,  354,
			  354,  354,  355,  355,  355,  355,  355,  355,  355,  363,
			  356,  356,  356,  356,  356,  356,  356,  357,  357,  357,
			  357,  357,  357,  357,  364,    0,    0,    0,  515,    0,
			  358,  358,  358,  358,  358,  358,  358,  359,  359,  359,
			  359,  359,  359,  359,  360,  360,  360,  360,  360,  360,
			  360,  365,  396,    0,    0,  396,  423,  396,  423,    0,

			    0,  366,    0,    0,    0,  516,    0,  396,  423,  361,
			  361,  361,  361,  361,  361,  361,  362,  362,  362,  362,
			  362,  362,  362,  367,  396,    0,    0,  396,  423,  396,
			  423,  363,  363,  363,  363,  363,  363,  363,  368,  396,
			  423,    0,    0,  364,  364,  364,  364,  364,  364,  364,
			  364,  364,  364,  369,  515,  515,  515,  515,  515,  515,
			  515,  542,  542,  542,  542,  542,  542,  542,    0,    0,
			  365,  365,  365,  365,  365,  365,  365,  365,  365,  365,
			  366,  366,  366,  366,  366,  366,  366,  366,  366,  366,
			  516,  516,  516,  516,  516,  516,  516,  516,  915,  915,

			  915,  915,  367,  367,  367,  367,  367,  367,  367,  367,
			  367,  367,  916,  916,  916,  916,    0,  368,  368,  368,
			  368,  368,  368,  368,  368,  368,  368,  738,  738,  738,
			  738,    0,  369,  369,  369,  369,  369,  369,  369,  369,
			  369,  369,  383,  383,  383,  383,    0,  391,  917,  917,
			  917,  917,  383,  383,  383,  383,  383,  383,  391,  393,
			  391,  395,    0,  393,  403,  395,    0,  738,  403,  395,
			  391,  921,  921,  921,  921,    0,  393,    0,  395,  391,
			    0,  403,  383,    0,  383,  383,  383,  383,  383,  383,
			  391,  393,  391,  395,  407,  393,  403,  395,  407,    0, yy_Dummy>>,
			1, 1000, 3000)
		end

	yy_chk_template_5 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			  403,  395,  391,  405,    0,  405,  406,  405,  393,    0,
			  395,  407,  407,  403,    0,  406,  408,  406,  408,    0,
			  405,    0,  410,  408,  410,  409,  407,  406,  408,  409,
			  407,    0,  410,    0,  410,  405,  411,  405,  406,  405,
			  411,    0,  409,  407,  407,    0,  409,  406,  408,  406,
			  408,    0,  405,  411,  410,  408,  410,  409,  412,  406,
			  408,  409,    0,  413,  410,    0,  410,  413,  411,  412,
			    0,  412,  411,    0,  409,    0,    0,  414,  409,  414,
			  413,  412,    0,  414,  417,  411,  417,  415,  416,  414,
			  412,  415,  416,  417,    0,  413,  417,    0,    0,  413,

			    0,  412,    0,  412,  415,  416,    0,  415,    0,  414,
			  419,  414,  413,  412,  419,  414,  417,    0,  417,  415,
			  416,  414,  418,  415,  416,  417,  420,  419,  417,  418,
			  421,  418,    0,  420,  421,  420,  415,  416,    0,  415,
			  422,  418,  419,    0,  422,  420,  419,  421,    0,    0,
			  588,  588,  588,  588,  418,    0,    0,  422,  420,  419,
			  422,  418,  421,  418,  588,  420,  421,  420,    0,  424,
			  425,  424,  422,  418,  425,    0,  422,  420,  424,  421,
			    0,  424,  426,    0,  425,    0,  426,  425,    0,  422,
			  588,    0,  422,    0,  427,    0,  588,    0,    0,  426,

			    0,  424,  425,  424,    0,  427,  425,  427,  427,    0,
			  424,    0,    0,  424,  426,  428,  425,  427,  426,  425,
			    0,  430,  428,  430,  428,  429,  427,    0,  430,  429,
			    0,  426,    0,  430,  428,    0,    0,  427,    0,  427,
			  427,    0,  429,  429,    0,    0,    0,  428,    0,  427,
			  432,    0,  432,  430,  428,  430,  428,  429,  432,  431,
			  430,  429,  432,  431,    0,  430,  428,    0,  433,  434,
			  434,  434,  433,    0,  429,  429,  431,  436,  431,  436,
			  433,  434,  432,  434,  432,  433,    0,    0,  435,  436,
			  432,  431,  435,  433,  432,  431,    0,    0,    0,  435,

			  433,  434,  434,  434,  433,  435,    0,    0,  431,  436,
			  431,  436,  433,  434,    0,  434,    0,  433,  437,  438,
			  435,  436,  437,  438,  435,  433,  439,  438,  441,  440,
			  439,  435,  441,  440,    0,  437,  438,  435,    0,  592,
			  592,  592,  592,  439,  440,  441,  440,    0,    0,    0,
			  437,  438,    0,  592,  437,  438,    0,    0,  439,  438,
			  441,  440,  439,  442,  441,  440,  443,  437,  438,  443,
			  442,  443,  442,    0,    0,  439,  440,  441,  440,  592,
			  444,  443,  442,    0,  445,  592,  445,  444,  445,  444,
			    0,    0,    0,  447,  446,  442,  445,  447,  443,  444,

			    0,  443,  442,  443,  442,  446,    0,  446,    0,    0,
			  447,    0,  444,  443,  442,  448,  445,  446,  445,  444,
			  445,  444,  448,  449,  448,  447,  446,  449,  445,  447,
			  451,  444,    0,    0,  448,    0,    0,  446,    0,  446,
			  449,  451,  447,  451,    0,    0,  450,  448,    0,  446,
			  450,  454,    0,  451,  448,  449,  448,    0,  454,  449,
			  454,  450,  451,  450,  453,  452,  448,  452,  453,  452,
			  454,    0,  449,  451,    0,  451,    0,  452,  450,    0,
			    0,  453,  450,  454,    0,  451,    0,  457,    0,    0,
			  454,  457,  454,  450,  455,  450,  453,  452,  455,  452,

			  453,  452,  454,  456,  457,  456,  456,    0,  455,  452,
			  458,  455,  458,  453,  459,  456,    0,    0,  459,  457,
			  460,    0,  458,  457,    0,    0,  455,  460,  463,  460,
			  455,  459,  463,    0,    0,  456,  457,  456,  456,  460,
			  455,    0,  458,  455,  458,  463,  459,  456,    0,    0,
			  459,  461,  460,  461,  458,  461,  461,    0,    0,  460,
			  463,  460,  464,  459,  463,    0,  464,    0,  461,  462,
			    0,  460,  462,  923,  923,  923,  923,  463,  462,  464,
			  462,    0,  465,  461,    0,  461,  465,  461,  461,  466,
			  462,    0,    0,  466,  464,    0,    0,    0,  464,  465,

			  461,  462,    0,  467,  462,  467,  466,  467,    0,  466,
			  462,  464,  462,  468,  465,    0,    0,  468,  465,    0,
			  467,  466,  462,  467,    0,  466,    0,  469,    0,    0,
			  468,  465,    0,    0,  469,  467,  469,  467,  466,  467,
			    0,  466,    0,    0,  470,  468,  469,  471,    0,  468,
			    0,  470,  467,  470,    0,  467,    0,    0,  471,  469,
			  471,    0,  468,  470,    0,  472,  469,  472,  469,  474,
			  471,  474,    0,  473,  472,  474,  470,  472,  469,  471,
			    0,  474,  473,  470,  473,  470,  924,  924,  924,  924,
			  471,  473,  471,    0,  473,  470,    0,  472,    0,  472,

			  475,  474,  471,  474,  475,  473,  472,  474,  476,  472,
			    0,  477,  476,  474,  473,    0,  473,  475,  477,    0,
			  477,    0,  478,  473,  480,  476,  473,  480,    0,  480,
			  477,    0,  475,  478,  479,  478,  475,    0,  479,  480,
			  476,    0,  479,  477,  476,  478,  482,    0,  482,  475,
			  477,  479,  477,    0,  478,    0,  480,  476,  482,  480,
			    0,  480,  477,    0,    0,  478,  479,  478,  481,  483,
			  479,  480,  481,  483,  479,  484,    0,  478,  482,    0,
			  482,  481,  484,  479,  484,  481,  483,    0,    0,  485,
			  482,    0,  486,  485,  484,  487,  486,    0,    0,  487,

			  481,  483,    0,  487,  481,  483,  485,  484,  486,  486,
			    0,    0,  487,  481,  484,    0,  484,  481,  483,    0,
			    0,  485,    0,  488,  486,  485,  484,  487,  486,    0,
			  488,  487,  488,    0,  489,  487,  489,    0,  485,  489,
			  486,  486,  488,    0,  487,  490,  489,    0,  490,    0,
			  490,    0,    0,  491,    0,  488,    0,  491,    0,    0,
			  490,  491,  488,    0,  488,    0,  489,    0,  489,  493,
			  491,  489,  493,  493,  488,  500,  492,  490,  489,  492,
			  490,  492,  490,    0,  517,  491,  493,  494,  496,  491,
			  496,  492,  490,  491,  498,  494,  498,  494,  501,  495,

			  496,  493,  491,  495,  493,  493,  498,  494,  492,  502,
			    0,  492,  495,  492,    0,    0,  495,  497,  493,  494,
			  496,  497,  496,  492,  503,    0,  498,  494,  498,  494,
			    0,  495,  496,    0,  497,  495,  504,    0,  498,  494,
			  925,  925,  925,  925,  495,    0,  505,    0,  495,  497,
			    0,    0,  518,  497,    0,    0,    0,  500,  500,  500,
			  500,  500,  500,  500,  519,    0,  497,  517,  517,  517,
			  517,  517,  517,  517,  517,  517,  517,  520,    0,    0,
			  501,  501,  501,  501,  501,  501,  501,  521,    0,    0,
			    0,  502,  502,  502,  502,  502,  502,  502,  523,  543, yy_Dummy>>,
			1, 1000, 4000)
		end

	yy_chk_template_6 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			  543,  543,  543,  543,  543,  543,  503,  503,  503,  503,
			  503,  503,  503,  524,    0,  504,  504,  504,  504,  504,
			  504,  504,  504,  504,  504,  505,  505,  505,  505,  505,
			  505,  505,  505,  505,  505,  518,  518,  525,  518,  518,
			  518,  518,  518,  518,  518,    0,    0,  519,  519,  519,
			  519,  519,  519,  519,  519,  519,  519,  526,    0,    0,
			  520,  520,  520,  520,  520,  520,  520,  520,  520,  520,
			  521,  527,    0,  521,  521,  521,  521,  521,  521,  521,
			    0,  528,    0,    0,  523,  523,  523,  523,  523,  523,
			  523,  529,  606,    0,  606,  606,  606,  606,  524,  524,

			  524,  524,  524,  524,  524,  524,  530,    0,    0,  530,
			  849,  530,  849,    0,  530,  849,  849,  849,  849,    0,
			  525,  525,  525,  525,  525,  525,  525,  525,  525,  525,
			  531,    0,    0,  531,  606,  531,    0,    0,  531,    0,
			  526,  526,    0,  526,  526,  526,  526,  526,  526,  526,
			  743,  743,  743,  743,  527,  527,  527,  527,  527,  527,
			  527,  527,  527,  527,  528,  528,  528,  528,  528,  528,
			  528,  528,  528,  528,  529,    0,    0,  529,  529,  529,
			  529,  529,  529,  529,  532,    0,  558,  532,    0,  532,
			  743,    0,  532,  970,  970,  970,  970,  530,  530,  530,

			  530,  530,  530,  530,  533,    0,    0,  533,    0,  533,
			    0,  536,  533,    0,  536,    0,  536,    0,    0,  536,
			    0,  531,  531,  531,  531,  531,  531,  531,  534,    0,
			    0,  534,    0,  534,    0,    0,  534,    0,  535,    0,
			    0,  535,    0,  535,    0,  537,  535,    0,  537,    0,
			  537,    0,  538,  537,    0,  538,    0,  538,    0,  539,
			  538,    0,  539,    0,  539,    0,    0,  539,  558,  558,
			  558,  558,  558,  558,  558,  532,  532,  532,  532,  532,
			  532,  532,  540,    0,    0,  540,  918,  540,  918,    0,
			  540,  918,  918,  918,  918,  533,  533,  533,  533,  533,

			  533,  533,  536,  536,  536,  536,  536,  536,  536,  544,
			    0,    0,  544,    0,    0,    0,  534,  534,  534,  534,
			  534,  534,  534,  534,  534,  534,  535,  535,  535,  535,
			  535,  535,  535,  535,  535,  535,  537,  537,  537,  537,
			  537,  537,  537,  538,  538,  538,  538,  538,  538,  538,
			  539,  539,  539,  539,  539,  539,  539,  541,    0,    0,
			  541,  919,  541,  919,    0,  541,  919,  919,  919,  919,
			  540,  540,  540,  540,  540,  540,  540,  540,  540,  540,
			  545,    0,    0,  545,    0,    0,  745,  745,  745,  745,
			  546,    0,    0,  546,    0,  544,  544,  544,  544,  544,

			  544,  544,  546,  546,  546,  546,  546,  547,  607,    0,
			  547,    0,  607,    0,  548,    0,    0,  548,    0,    0,
			    0,  549,    0,    0,  549,  607,  745,  607,  550,  616,
			  616,  550,  616,  547,    0,  551,    0,    0,  551,    0,
			  607,    0,  616,    0,  607,  541,  541,  541,  541,  541,
			  541,  541,  541,  541,  541,  552,    0,  607,  552,  607,
			    0,  616,  616,    0,  616,    0,  545,  545,  545,  545,
			  545,  545,  545,    0,  616,    0,  546,  546,  546,  546,
			  546,  546,  546,  553,    0,    0,  553,  748,    0,  748,
			  748,  748,  748,  547,  547,  547,  547,  547,  547,  547,

			  548,  548,  548,  548,  548,  548,  548,  549,  549,  549,
			  549,  549,  549,  549,  550,  550,  550,  550,  550,  550,
			  550,  551,  551,  551,  551,  551,  551,  551,  554,  748,
			    0,  554,  972,  972,  972,  972,    0,    0,  552,  552,
			  552,  552,  552,  552,  552,  552,  552,  552,  555,    0,
			    0,  555,    0,    0,    0,  556,    0,    0,  556,    0,
			    0,    0,  557,    0,    0,  557,  553,  553,  553,  553,
			  553,  553,  553,  553,  553,  553,  559,  554,    0,  635,
			    0,  635,  597,  560,  597,  597,  597,  597,    0,    0,
			  561,  635,    0,    0,    0,  597,  928,  555,  928,    0,

			  562,  928,  928,  928,  928,  973,  973,  973,  973,  554,
			  563,  635,    0,  635,  554,  554,  554,  554,  554,  554,
			  554,    0,    0,  635,  597,    0,    0,  597,    0,  555,
			    0,    0,    0,  586,  555,  555,  555,  555,  555,  555,
			  555,  556,  556,  556,  556,  556,  556,  556,  557,  557,
			  557,  557,  557,  557,  557,  587,    0,    0,  559,  559,
			  559,  559,  559,  559,  559,  560,  560,  560,  560,  560,
			  560,  560,  561,  561,  561,  561,  561,  561,  561,  562,
			  562,  562,  562,  562,  562,  562,  562,  562,  562,  563,
			  563,  563,  563,  563,  563,  563,  563,  563,  563,  569,

			  974,  974,  974,  974,    0,    0,    0,  569,  569,  569,
			  569,  569,  586,  586,  586,  586,  586,  586,  586,  586,
			  586,  586,  978,  978,  978,  978,    0,  609,    0,    0,
			    0,  609,    0,    0,  587,  587,  587,  587,  587,  587,
			  587,  587,  587,  587,  609,  609,    0,  737,  737,  737,
			  737, 1006, 1006, 1006, 1006,    0,  608,    0,  608,  609,
			  610,  737,  610,  609,  608,    0,    0,  610,  608,    0,
			    0,    0,  610,    0,  611,    0,  609,  609,  611,    0,
			  611,  569,  569,  569,  569,  569,  569,  569,  608,    0,
			  608,  611,  610,  737,  610,    0,  608,  615,  612,  610,

			  608,  615,    0,  612,  610,  612,  611,  615,    0,  617,
			  611,    0,  611,  617,  615,  612,    0,  619,    0,    0,
			    0,  619,    0,  611,    0,    0,  617,  617,    0,  615,
			  612,    0,    0,  615,  619,  612,  618,  612,  618,  615,
			    0,  617,    0,  618,    0,  617,  615,  612,  618,  619,
			    0,    0,  621,  619,  620,    0,  621,    0,  617,  617,
			    0,  620,    0,  620,    0,    0,  619,    0,  618,  621,
			  618,  621,    0,  620,  623,  618,    0,  622,  623,  622,
			  618,    0,    0,  624,  621,  622,  620,    0,  621,  622,
			  624,  623,  624,  620,    0,  620,  840,  840,  840,  840,

			    0,  621,  624,  621,    0,  620,  623,    0,  625,  622,
			  623,  622,  625,  626,  625,  624,    0,  622,  626,    0,
			  626,  622,  624,  623,  624,  625,  628,    0,  628,    0,
			  626,  627,  628,    0,  624,  627,  840,    0,  628,  629,
			  625,    0,    0,  629,  625,  626,  625,  629,  627,  631,
			  626,    0,  626,  631,    0,    0,  629,  625,  628,    0,
			  628,    0,  626,  627,  628,    0,  631,  627,    0,  630,
			  628,  629,  630,  633,  630,  629,    0,  633,  634,  629,
			  627,  631,  634,    0,  630,  631,  633,  632,  629,  632,
			  633,    0,    0,  632,    0,  634,    0,    0,  631,  632, yy_Dummy>>,
			1, 1000, 5000)
		end

	yy_chk_template_7 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			    0,  630,    0,  637,  630,  633,  630,  637,    0,  633,
			  634,  636,    0,  636,  634,    0,  630,  636,  633,  632,
			  637,  632,  633,  636,  638,  632,  638,  634,    0,  639,
			  638,  632,    0,  639,  641,  637,  638,    0,  641,  637,
			    0,  640,    0,  636,    0,  636,  639,    0,  640,  636,
			  640,  641,  637,    0,  641,  636,  638,    0,  638,    0,
			  640,  639,  638,    0,    0,  639,  641,  642,  638,  642,
			  641,  643,  645,  640,  645,  643,  642,  644,  639,  642,
			  640,  644,  640,  641,  645,  647,  641,    0,  643,  647,
			    0,  646,  640,  647,  644,    0,    0,    0,  646,  642,

			  646,  642,  647,  643,  645,    0,  645,  643,  642,  644,
			  646,  642,    0,  644,  649,    0,  645,  647,  649,    0,
			  643,  647,    0,  646,  648,  647,  644,  648,    0,  648,
			  646,  649,  646,  650,  647,  650,  652,  649,  652,  648,
			  653,    0,  646,  651,  653,  650,  649,  651,  652,    0,
			  649,    0,  654,    0,  654,    0,  648,  653,  654,  648,
			  651,  648,    0,  649,  654,  650,  651,  650,  652,  649,
			  652,  648,  653,    0,  655,  651,  653,  650,  655,  651,
			  652,    0,    0,  657,  654,    0,  654,  657,  656,  653,
			  654,  655,  651,    0,    0,  656,  654,  656,  651,  658,

			  657,  658,    0,    0,  659,  658,  655,  656,  659,    0,
			  655,  658,  660,    0,  660,  657,  662,    0,  662,  657,
			  656,  659,    0,  655,  660,    0,    0,  656,  662,  656,
			  661,  658,  657,  658,  661,    0,  659,  658,  663,  656,
			  659,  661,  663,  658,  660,    0,  660,  661,  662,  664,
			  662,  664,    0,  659,  665,  663,  660,  666,  665,  666,
			  662,  664,  661,  668,    0,  668,  661,    0,  669,  666,
			  663,  665,  669,  661,  663,  668,    0,    0,    0,  661,
			    0,  664,  670,  664,  670,  669,  665,  663,  667,  666,
			  665,  666,  667,  664,  670,  668,    0,  668,  671,  667,

			  669,  666,  671,  665,  669,  667,  674,  668,    0,  674,
			    0,  674,    0,    0,  670,  671,  670,  669,  671,  672,
			  667,  674,    0,  672,  667,    0,  670,  672,    0,    0,
			  671,  667,    0,  673,  671,  673,  672,  667,  674,    0,
			    0,  674,  673,  674,  675,  673,  676,  671,  675,  675,
			  671,  672,  676,  674,  676,  672,  677,    0,  679,  672,
			  677,  675,  679,    0,  676,  673,    0,  673,  672,    0,
			  679,    0,    0,  677,  673,  679,  675,  673,  676,    0,
			  675,  675,    0,  678,  676,  678,  676,    0,  677,  678,
			  679,    0,  677,  675,  679,  678,  676,  680,  680,  680,

			    0,    0,  679,    0,    0,  677,  681,  679,    0,  680,
			  681,    0,    0,  682,  681,  678,  682,  678,  682,    0,
			  683,  678,  684,  681,  683,    0,  684,  678,  682,  680,
			  680,  680,  686,  684,  686,    0,    0,  683,  681,  684,
			  683,  680,  681,    0,  686,  682,  681,    0,  682,    0,
			  682,    0,  683,    0,  684,  681,  683,    0,  684,    0,
			  682,  685,    0,  685,  686,  684,  686,    0,    0,  683,
			  685,  684,  683,  685,  687,  688,  686,  688,  687,  689,
			    0,  689,    0,  689,    0,    0,    0,  688,  688,    0,
			    0,  687,    0,  685,    0,  685,  689,    0,  687,    0,

			  691,    0,  685,  690,  691,  685,  687,  688,    0,  688,
			  687,  689,  690,  689,  690,  689,    0,  691,    0,  688,
			  688,    0,    0,  687,  690,  692,    0,  692,  689,    0,
			  687,  692,  691,    0,    0,  690,  691,  692,  693,  694,
			    0,  694,  693,  694,  690,    0,  690,    0,  695,  691,
			  697,  694,  695,  693,  697,  693,  690,  692,    0,  692,
			  696,    0,  696,  692,  698,  695,  698,  697,    0,  692,
			  693,  694,  696,  694,  693,  694,  698,    0,    0,    0,
			  695,    0,  697,  694,  695,  693,  697,  693,  741,  741,
			  741,  741,  696,    0,  696,    0,  698,  695,  698,  697,

			    0,  699,  741,  700,  696,  699,  699,    0,  698,  700,
			  701,  700,  703,  702,  701,  702,  703,    0,  699,    0,
			    0,  700,  702,  703,  704,  702,  704,  701,  741,  703,
			  701,    0,    0,  699,  741,  700,  704,  699,  699,    0,
			    0,  700,  701,  700,  703,  702,  701,  702,  703,  711,
			  699,    0,  706,  700,  702,  703,  704,  702,  704,  701,
			  705,  703,  701,  706,  705,  706,  707,  708,  704,  708,
			  707,  712,  709,    0,  715,  706,  709,  705,  710,  708,
			  710,  716,    0,  707,  706,    0,    0,    0,  717,  709,
			  710,    0,  705,    0,    0,  706,  705,  706,  707,  708,

			  718,  708,  707,    0,  709,    0,    0,  706,  709,  705,
			  710,  708,  710,  719,    0,  707,    0,    0,    0,    0,
			    0,  709,  710,  720,    0,    0,    0,    0,    0,    0,
			  721,  711,  711,  711,  711,  711,  711,  711,  722,    0,
			    0,  975,    0,  975,    0,  723,  975,  975,  975,  975,
			    0,    0,  724,  712,  712,  712,  712,  712,  712,  712,
			  715,  715,  715,  715,  715,  715,  715,  716,  716,  716,
			  716,  716,  716,  716,  717,  717,  717,  717,  717,  717,
			  717,  725,    0,    0,    0,    0,  718,  718,  718,  718,
			  718,  718,  718,  726,    0,    0,  719,  719,  719,  719,

			  719,  719,  719,  719,  719,  719,  720,  720,  720,  720,
			  720,  720,  720,  720,  720,  720,  721,  721,  721,  721,
			  721,  721,  721,    0,  722,  722,  722,  722,  722,  722,
			  722,  723,  723,  723,  723,  723,  723,  723,  724,  724,
			  724,  724,  724,  724,  724,  727,  734,    0,  727,    0,
			  727,    0,  728,  727,    0,  728,    0,  728,    0,    0,
			  728,    0,    0,    0,  725,  725,  725,  725,  725,  725,
			  725,  725,  725,  725,  735,    0,  726,  726,  726,  726,
			  726,  726,  726,  726,  726,  726,  729,  736,    0,  729,
			    0,  729,    0,  730,  729,    0,  730,    0,  730,    0,

			    0,  730,    0,    0,    0,  731,    0,    0,  731,    0,
			    0,    0,  732,    0,    0,  732,    0,  731,  731,  731,
			  731,  731,  733,    0,    0,  733,    0,    0,  734,  734,
			  734,  734,  734,  734,  734,    0,  727,  727,  727,  727,
			  727,  727,  727,  728,  728,  728,  728,  728,  728,  728,
			    0,    0,    0,    0,    0,    0,  735,  735,  735,  735,
			  735,  735,  735,    0,    0,  844,  844,  844,  844,  736,
			  736,  736,  736,  736,  736,  736,    0,  729,  729,  729,
			  729,  729,  729,  729,  730,  730,  730,  730,  730,  730,
			  730,  731,  731,  731,  731,  731,  731,  731,  732,  732, yy_Dummy>>,
			1, 1000, 6000)
		end

	yy_chk_template_8 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			  732,  732,  732,  732,  732,  844,    0,    0,  733,  733,
			  733,  733,  733,  733,  733,  747,  747,  747,  747,  749,
			  750,  751,  750,  749,    0,  751,    0,    0,  752,  747,
			  752,  753,  750,    0,    0,  753,  749,  754,  751,  754,
			  752,  755,  757,    0,  753,  755,  757,    0,  753,  754,
			    0,  749,  750,  751,  750,  749,    0,  751,  755,  757,
			  752,  747,  752,  753,  750,    0,    0,  753,  749,  754,
			  751,  754,  752,  755,  757,  759,  753,  755,  757,  759,
			  753,  754,  756,  758,  756,  758,    0,  760,    0,  760,
			  755,  757,  759,  760,  756,  758,  761,    0,    0,  760,

			  761,  762,    0,    0,  761,  762,    0,  759,  762,    0,
			  762,  759,    0,  761,  756,  758,  756,  758,  765,  760,
			  762,  760,  765,    0,  759,  760,  756,  758,  761,    0,
			  763,  760,  761,  762,  763,  765,  761,  762,    0,  764,
			  762,  764,  762,  763,  766,  761,  766,  763,    0,    0,
			  765,  764,  762,  767,  765,    0,  766,  767,  847,  847,
			  847,  847,  763,    0,  769,  772,  763,  765,  769,  769,
			  767,  764,  772,  764,  772,  763,  766,    0,  766,  763,
			  768,  769,  768,  764,  772,  767,  768,  770,  766,  767,
			  771,    0,  768,  770,  771,  770,  769,  772,  847,    0,

			  769,  769,  767,    0,  772,  770,  772,  771,    0,    0,
			    0,    0,  768,  769,  768,    0,  772,  773,  768,  770,
			  773,  773,  771,  774,  768,  770,  771,  770,  775,    0,
			    0,  774,  775,  774,  773,    0,  776,  770,  776,  771,
			    0,    0,    0,  774,  776,  775,    0,  775,  776,  773,
			    0,    0,  773,  773,  777,  774,    0,  778,  777,  778,
			  775,    0,    0,  774,  775,  774,  773,  777,  776,  778,
			  776,  777,  780,    0,  780,  774,  776,  775,  779,  775,
			  776,  781,  779,    0,  780,  781,  777,    0,  785,  778,
			  777,  778,  785,    0,    0,  779,    0,    0,  781,  777,

			  784,  778,  784,  777,  780,  785,  780,    0,    0,  782,
			  779,  782,  784,  781,  779,  782,  780,  781,  783,  786,
			  785,  782,  783,    0,  785,  787,  786,  779,  786,  787,
			  781,  783,  784,  787,  784,  783,    0,  785,  786,    0,
			    0,  782,  787,  782,  784,    0,    0,  782,    0,    0,
			  783,  786,    0,  782,  783,  789,    0,  787,  786,  789,
			  786,  787,    0,  783,    0,  787,  788,  783,    0,  788,
			  786,  788,  789,  790,  787,  790,  791,    0,    0,    0,
			  791,  788,    0,    0,  791,  790,    0,  789,    0,    0,
			    0,  789,    0,  791,  792,    0,    0,  792,  788,  792,

			    0,  788,    0,  788,  789,  790,  795,  790,  791,  792,
			  795,    0,  791,  788,  795,    0,  791,  790,  793,  794,
			  793,    0,  793,  795,    0,  791,  792,    0,  794,  792,
			  794,  792,    0,    0,  796,  793,    0,  796,  795,  796,
			  794,  792,  795,    0,  797,  798,  795,  798,  797,  796,
			  793,  794,  793,    0,  793,  795,  800,  798,    0,    0,
			  794,  797,  794,  800,    0,  800,  796,  793,    0,  796,
			  799,  796,  794,    0,  799,  800,  797,  798,    0,  798,
			  797,  796,  801,    0,    0,    0,  801,  799,  800,  798,
			    0,    0,  802,  797,  802,  800,    0,  800,  802,  801,

			    0,  804,  799,  804,  802,  803,  799,  800,  805,  803,
			    0,    0,  805,  804,  801,    0,  805,    0,  801,  799,
			    0,    0,  803,    0,  802,  805,  802,    0,  803,    0,
			  802,  801,    0,  804,    0,  804,  802,  803,  807,    0,
			  805,  803,  807,  808,  805,  804,  806,    0,  805,  806,
			  808,  806,  808,    0,  803,  807,    0,  805,  810,  809,
			  803,  806,  808,  809,    0,  810,    0,  810,  811,    0,
			  807,    0,  811,    0,  807,  808,  809,  810,  806,    0,
			    0,  806,  808,  806,  808,  811,  812,  807,  812,    0,
			  810,  809,  812,  806,  808,  809,  814,  810,  812,  810,

			  811,    0,  813,  814,  811,  814,  813,    0,  809,  810,
			  815,    0,    0,    0,  815,  814,    0,  811,  812,  813,
			  812,    0,    0,    0,  812,    0,    0,  815,  814,  815,
			  812,  816,  817,  816,  813,  814,  817,  814,  813,  816,
			    0,  821,  815,  816,    0,  821,  815,  814,  818,  817,
			  818,  813,    0,  819,  820,    0,  820,  819,  821,  815,
			  818,  815,  820,  816,  817,  816,  820,  824,  817,  824,
			  819,  816,  819,  821,  823,  816,    0,  821,  823,  824,
			  818,  817,  818,    0,  822,  819,  820,    0,  820,  819,
			  821,  823,  818,    0,  820,  822,    0,  822,  820,  824,

			    0,  824,  819,    0,  819,  825,  823,  822,  827,  825,
			  823,  824,  827,  825,    0,  826,  822,  828,  826,    0,
			  826,    0,  825,  823,  828,  827,  828,  822,  833,  822,
			  826,  829,    0,    0,    0,  829,  828,  825,  834,  822,
			  827,  825,    0,    0,  827,  825,  835,  826,  829,  828,
			  826,    0,  826,  830,  825,  830,  828,  827,  828,  832,
			  831,  832,  826,  829,  831,  830,  836,  829,  828,    0,
			    0,  832,    0,  831,    0,    0,  837,  831,    0,  837,
			  829,  920,  920,  920,  920,  830,    0,  830,  837,    0,
			    0,  832,  831,  832,    0,    0,  831,  830,  843,  843,

			  843,  843,    0,  832,    0,  831,    0,    0,    0,  831,
			    0,    0,  843,    0,  833,  833,  833,  833,  833,  833,
			  833,  920,    0,    0,  834,  834,  834,  834,  834,  834,
			  834,    0,  835,  835,  835,  835,  835,  835,  835,    0,
			  971,  971,  971,  971,  843,  850,  850,  850,  850,  852,
			    0,  852,  836,  836,  836,  836,  836,  836,  836,  850,
			    0,  852,  837,  837,  837,  837,  837,  837,  837,  851,
			  853,    0,    0,  851,  853,  855,  854,    0,  854,  855,
			  971,  852,    0,  852,  854,    0,  851,  853,  854,  853,
			    0,  850,  855,  852,    0,  856,    0,    0,    0,  856,

			    0,  851,  853,    0,    0,  851,  853,  855,  854,  856,
			  854,  855,  856,  857,    0,  857,  854,    0,  851,  853,
			  854,  853,    0,    0,  855,  857,  858,  856,  858,  858,
			    0,  856,  859,  861,    0,    0,  859,  861,  858,    0,
			  860,  856,  860,    0,  856,  857,    0,  857,  860,  859,
			  861,  859,  860,    0,    0,    0,    0,  857,  858,  863,
			  858,  858,    0,  863,  859,  861,  862,    0,  859,  861,
			  858,    0,  860,  862,  860,  862,  863,  864,    0,  864,
			  860,  859,  861,  859,  860,  862,  865,    0,    0,  864,
			  865,  863,  866,  867,  866,  863,  869,  867,  862,    0, yy_Dummy>>,
			1, 1000, 7000)
		end

	yy_chk_template_9 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			  869,    0,  871,  865,  866,  862,  871,  862,  863,  864,
			  867,  864,    0,  869,    0,    0,    0,  862,  865,  871,
			    0,  864,  865,  873,  866,  867,  866,  873,  869,  867,
			  868,  870,  869,  870,  871,  865,  866,  868,  871,  868,
			  873,  872,  867,  870,    0,  869,    0,    0,    0,  868,
			    0,  871,  872,    0,  872,  873,    0,    0,    0,  873,
			    0,  874,  868,  870,  872,  870,    0,    0,  874,  868,
			  874,  868,  873,  872,  875,  870,    0,  876,  875,  876,
			  874,  868,    0,    0,  872,  878,  872,  878,    0,  876,
			  877,  875,  878,  874,  877,    0,  872,  878,    0,  885,

			  874,  879,  874,  885,    0,  879,  875,  877,  877,  876,
			  875,  876,  874,  880,  879,  880,  885,  878,  879,  878,
			    0,  876,  877,  875,  878,  880,  877,    0,    0,  878,
			    0,  885,  881,  879,    0,  885,  881,  879,    0,  877,
			  877,    0,    0,    0,    0,  880,  879,  880,  885,  881,
			  879,  881,  883,  882,    0,  882,  883,  880,  884,    0,
			  884,  882,    0,  886,  881,  882,  884,    0,  881,  883,
			  884,  883,    0,    0,  886,    0,  886,    0,    0,    0,
			    0,  881,    0,  881,  883,  882,  886,  882,  883,    0,
			  884,    0,  884,  882,    0,  886,  887,  882,  884,    0,

			  887,  883,  884,  883,    0,    0,  886,    0,  886,  888,
			  891,  888,  889,  887,  891,  887,  889,  888,  886,    0,
			    0,  888,    0,  892,  890,  892,  890,  891,  887,  889,
			  889,  890,  887,    0,    0,  892,  890,    0,  894,    0,
			  894,  888,  891,  888,  889,  887,  891,  887,  889,  888,
			  894,    0,    0,  888,    0,  892,  890,  892,  890,  891,
			  893,  889,  889,  890,  893,    0,    0,  892,  890,    0,
			  894,  895,  894,  893,  896,  895,  896,  893,  898,    0,
			  898,  897,  894,  899,  895,  897,  896,  899,  895,    0,
			  898,    0,  893,    0,    0,  900,  893,    0,  897,  902,

			  899,  902,  900,  895,  900,  893,  896,  895,  896,  893,
			  898,  902,  898,  897,  900,  899,  895,  897,  896,  899,
			  895,  901,  898,    0,  903,  901,    0,  900,  903,    0,
			  897,  902,  899,  902,  900,  904,  900,  904,  901,    0,
			  906,  903,  906,  902,  905,  907,  900,  904,  905,  907,
			    0,    0,  906,  901,    0,    0,  903,  901,    0,    0,
			  903,  905,  907,  908,  907,  908,    0,  904,    0,  904,
			  901,  908,  906,  903,  906,  908,  905,  907,    0,  904,
			  905,  907,  911,    0,  906,  909,  911,    0,  910,  909,
			  910,    0,    0,  905,  907,  908,  907,  908,  909,  911,

			  910,    0,  909,  908,  912,    0,  912,  908,  913,    0,
			    0,  914,  913,  914,  911,    0,  912,  909,  911,  914,
			  910,  909,  910,  914,    0,  913,    0,  913,    0,    0,
			  909,  911,  910,  929,  909,    0,  912,  929,  912,    0,
			  913,    0,    0,  914,  913,  914,    0,    0,  912,    0,
			  929,  914,  930,    0,  930,  914,    0,  913,    0,  913,
			  927,  927,  927,  927,  930,  929,  931,    0,    0,  929,
			  931,    0,  933,  932,  927,  932,  933,    0,  934,  931,
			  934,    0,  929,  931,  930,  932,  930,    0,    0,  933,
			  934,  940,    0,  940,    0,    0,  930,    0,  931,    0,

			  927,    0,  931,  940,  933,  932,  927,  932,  933,    0,
			  934,  931,  934,    0,    0,  931,  935,  932,  936,  935,
			  935,  933,  934,  940,    0,  940,  936,  937,  936,  938,
			  937,  937,    0,  935,    0,  940,  939,  938,  936,  938,
			  939,    0,    0,    0,  937,    0,    0,  939,  935,  938,
			  936,  935,  935,  939,  942,  944,  942,  944,  936,  937,
			  936,  938,  937,  937,    0,  935,  942,  944,  939,  938,
			  936,  938,  939,  941,  943,  946,  937,  941,  943,  939,
			  946,  938,  946,    0,    0,  939,  942,  944,  942,  944,
			  941,  943,  946,    0,    0,    0,  945,    0,  942,  944,

			  945,    0,  945,    0,  947,  941,  943,  946,  947,  941,
			  943,    0,  946,  945,  946,  948,  949,  948,    0,    0,
			  949,  947,  941,  943,  946,    0,  951,  948,  945,  950,
			  951,  950,  945,  949,  945,    0,  947,    0,    0,  951,
			  947,  950,  952,  951,  952,  945,    0,  948,  949,  948,
			    0,  953,  949,  947,  952,  953,    0,    0,  951,  948,
			  954,  950,  951,  950,    0,  949,    0,  954,  953,  954,
			    0,  951,    0,  950,  952,  951,  952,  955,    0,  954,
			  957,  955,    0,  953,  957,    0,  952,  953,    0,    0,
			    0,  955,  954,  956,  955,  956,  956,  957,    0,  954,

			  953,  954,    0,    0,  959,  956,  959,    0,  959,  955,
			    0,  954,  957,  955,  961,  958,  957,    0,  961,    0,
			    0,  959,  958,  955,  958,  956,  955,  956,  956,  957,
			  960,  961,    0,  962,  958,  962,  959,  956,  959,  960,
			  959,  960,    0,    0,  963,  962,  961,  958,  963,    0,
			  961,  960,    0,  959,  958,    0,  958,  979,  979,  979,
			  979,  963,  960,  961,    0,  962,  958,  962,    0,    0,
			  965,  960,  964,  960,  965,  966,  963,  962,    0,  964,
			  963,  964,  966,  960,  966,    0,  967,  965,  980,    0,
			  967,  964,  980,  963,  966,    0,  968,  979,  968,    0,

			    0,    0,  965,  967,  964,  980,  965,  966,  968,    0,
			    0,  964,    0,  964,  966,  981,  966,  981,  967,  965,
			  980,  982,  967,  964,  980,  982,  966,  981,  968,    0,
			  968,  977,  977,  977,  977,  967,    0,  980,  982,    0,
			  968,    0,  983,    0,  983,  977,  984,  981,  986,  981,
			  984,    0,  986,  982,  983,    0,  985,  982,  985,  981,
			  987,    0,  987,  984,    0,  986,    0,    0,  985,    0,
			  982,  977,  987,  989,  983,  989,  983,  977,  984,  988,
			  986,    0,  984,  988,  986,  989,  983,    0,  985,  990,
			  985,    0,  987,  990,  987,  984,  988,  986,    0,    0,

			  985,  991,    0,  991,  987,  989,  990,  989,  990,  991,
			  992,  988,  994,  991,  992,  988,  994,  989,  993,  996,
			  993,  990,  997,  996,  997,  990,    0,  992,  988,  994,
			  993,    0,    0,  991,  997,  991,  996,  995,  990,  995,
			  990,  991,  992,  995,  994,  991,  992,    0,  994,  995,
			  993,  996,  993,  998,  997,  996,  997,  998,  999,  992,
			    0,  994,  993,    0,    0,  999,  997,  999,  996,  995,
			  998,  995,    0,    0, 1000,  995,    0,  999, 1000, 1002,
			 1001,  995, 1001, 1002,    0,  998, 1003,    0, 1003,  998,
			  999, 1000, 1001,    0,    0,    0, 1002,  999, 1003,  999, yy_Dummy>>,
			1, 1000, 8000)
		end

	yy_chk_template_10 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			    0,    0,  998,    0,    0,    0, 1000,    0,    0,  999,
			 1000, 1002, 1001,    0, 1001, 1002,    0,    0, 1003,    0,
			 1003,    0,    0, 1000, 1001,    0,    0,    0, 1002,    0,
			 1003, 1004, 1004, 1004, 1004, 1007, 1007, 1007, 1007, 1008,
			 1008, 1008, 1008,    0, 1009,    0,    0,    0, 1009, 1011,
			 1010,    0, 1010, 1011,    0, 1012, 1013, 1012,    0,    0,
			 1013, 1009, 1010,    0,    0,    0, 1011, 1012,    0,    0,
			    0, 1004,    0, 1013,    0, 1007, 1009,    0,    0, 1008,
			 1009, 1011, 1010,    0, 1010, 1011,    0, 1012, 1013, 1012,
			    0,    0, 1013, 1009, 1010, 1014,    0, 1014, 1011, 1012,

			 1015, 1015, 1015, 1015,    0, 1013,    0, 1014, 1022, 1022,
			 1022, 1022, 1022, 1022, 1022, 1022, 1022, 1022, 1022, 1022,
			 1022, 1022,    0,    0,    0,    0,    0, 1014,    0, 1014,
			    0,    0,    0,    0,    0,    0,    0,    0,    0, 1014,
			 1015, 1017, 1017, 1017, 1017, 1017, 1017, 1017, 1017, 1017,
			 1017, 1017, 1017, 1017, 1017, 1017, 1017, 1017, 1017, 1017,
			 1017, 1017, 1017, 1017, 1018, 1018,    0, 1018, 1018, 1018,
			 1018, 1018, 1018, 1018, 1018, 1018, 1018, 1018, 1018, 1018,
			 1018, 1018, 1018, 1018, 1018, 1018, 1018, 1019,    0,    0,
			    0,    0,    0,    0, 1019, 1019, 1019, 1019, 1019, 1019,

			 1019, 1019, 1019, 1019, 1019, 1019, 1019, 1019, 1019, 1019,
			 1020, 1020,    0, 1020, 1020, 1020, 1020, 1020, 1020, 1020,
			 1020, 1020, 1020, 1020, 1020, 1020, 1020, 1020, 1020, 1020,
			 1020, 1020, 1020, 1021, 1021,    0, 1021, 1021, 1021, 1021,
			    0, 1021, 1021, 1021, 1021, 1021, 1021, 1021, 1021, 1021,
			 1021, 1021, 1021, 1021, 1021, 1021, 1023, 1023,    0, 1023,
			 1023, 1023,    0,    0, 1023, 1023, 1023, 1023, 1023, 1023,
			 1023, 1023, 1023, 1023, 1023, 1023, 1023, 1023, 1023, 1024,
			 1024, 1024, 1024, 1024, 1024, 1024, 1024, 1024, 1024, 1024,
			 1024, 1024, 1024, 1025,    0,    0, 1025,    0, 1025, 1025,

			 1025, 1025, 1025, 1025, 1025, 1025, 1025, 1025, 1025, 1025,
			 1025, 1025, 1025, 1025, 1025, 1025, 1026, 1026,    0, 1026,
			 1026, 1026, 1026, 1026, 1026, 1026, 1026, 1026, 1026, 1026,
			 1026, 1026, 1026, 1026, 1026, 1026, 1026, 1026, 1026, 1027,
			 1027,    0, 1027, 1027, 1027, 1027, 1027, 1027, 1027, 1027,
			 1027, 1027, 1027, 1027, 1027, 1027, 1027, 1027, 1027, 1027,
			 1027, 1027, 1028, 1028,    0, 1028, 1028, 1028, 1028, 1028,
			 1028, 1028, 1028, 1028, 1028, 1028, 1028, 1028, 1028, 1028,
			 1028, 1028, 1028, 1028, 1028, 1029,    0,    0,    0,    0,
			 1029, 1029, 1029, 1029, 1029, 1029, 1029, 1029, 1029, 1029,

			 1029, 1029, 1029, 1029, 1029, 1029, 1029, 1029, 1030, 1030,
			 1030, 1030, 1030, 1030, 1030, 1030,    0, 1030, 1030, 1030,
			 1030, 1030, 1030, 1030, 1030, 1030, 1030, 1030, 1030, 1030,
			 1030, 1031, 1031, 1031, 1031, 1031, 1031, 1031, 1031, 1031,
			 1031, 1031, 1031, 1031, 1032, 1032, 1032, 1032, 1032, 1032,
			 1032, 1032, 1032, 1032, 1032, 1032, 1032, 1033, 1033, 1033,
			 1033, 1033, 1033, 1033, 1033, 1033, 1033, 1033, 1033, 1033,
			 1034, 1034,    0, 1034, 1034, 1034,    0, 1034, 1034, 1034,
			 1034, 1034, 1034, 1034, 1034, 1034, 1034, 1034, 1034, 1034,
			 1034, 1034, 1034, 1035, 1035,    0, 1035, 1035, 1035,    0,

			 1035, 1035, 1035, 1035, 1035, 1035, 1035, 1035, 1035, 1035,
			 1035, 1035, 1035, 1035, 1035, 1035, 1036, 1036, 1036, 1036,
			 1036, 1036, 1036, 1036,    0, 1036, 1036, 1036, 1036, 1036,
			 1036, 1036, 1036, 1036, 1036, 1036, 1036, 1036, 1036, 1016,
			 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016,
			 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016,
			 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016,
			 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016,
			 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016,
			 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016,

			 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016,
			 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016,
			 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016,
			 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, yy_Dummy>>,
			1, 639, 9000)
		end

	yy_base_template: SPECIAL [INTEGER] is
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make (0, 1036)
			yy_base_template_1 (an_array)
			yy_base_template_2 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_base_template_1 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			    0,    0,    0,   98,  109,  434, 9539,  426,  424,  421,
			  418,  409,  121,    0, 9539,  128,  135, 9539, 9539, 9539,
			 9539, 9539,   87,   87,   97,  126,   99,  150,  383, 9539,
			   99, 9539,  105,  380,  215,  279,  324,  329,  341,  388,
			  296,  397,  413,  444,  456,  419,  446,  466,  477,  487,
			  507,  518,  527, 9539,  344, 9539, 9539,  238,  571,  529,
			  634,  564,  649,  719,  497,  715,  636,  711,  730,  568,
			  765,  773,  776,  784,  791,  819,  827, 9539, 9539,   51,
			  304,   60,   63,   73,   84,  293,  538,  415,  378,  873,
			  650,  880,  891,  600,  821,  831,  842,  852,  862,  901,

			  378,  375,  365,  359, 9539,  973, 9539, 1066, 1030, 1043,
			 1055, 1112, 1125, 1137, 1170, 1182, 1230,    0, 1077, 1148,
			 1241, 1275, 1285, 1295, 1305, 1334,  923,  337, 1427, 1260,
			 1319, 1394, 1408, 1437, 1450, 1089, 9539, 9539, 9539,  284,
			 9539, 9539,  319,  983,  665,  100,  179,  556, 1530,  989,
			  109, 9539, 9539, 9539, 9539, 9539, 9539,  534, 1525, 1536,
			 1552, 1541, 1246, 1582, 1581, 1596, 1585,   90,  254,   93,
			  122,  150,  181,  248, 1629, 1631, 1643, 1645, 1653, 1652,
			 1655, 1660, 1695, 1686, 1703, 1700, 1720, 1730, 1731, 1748,
			 1763, 1784, 1790, 1812, 1825, 1831, 1847, 1849, 1887, 1850,

			 1889, 1895, 1899, 1907, 1957, 1910, 1940, 1954, 2008, 1957,
			 2018, 2023, 2023, 2060, 2076, 2066, 2082, 2084, 2122, 2130,
			 2125, 2138, 2142, 2129, 2146, 2185, 2238, 2289, 2188, 2190,
			 2189, 2235, 2206, 2249, 2293, 2298, 2351, 2353, 2313, 2363,
			 2362, 2402, 2365, 2405, 2419, 2409, 9539, 1415, 1547, 2408,
			 2425, 2440, 2450, 2462, 2472,  233,  237,  265,  153,  296,
			  468,  238,  500,  558,  627,  645,  684,  688,  812,  961,
			 2480, 2490, 2500, 2510, 2520, 2530, 1194, 1405, 2415, 2543,
			  318, 2628, 2641, 2648, 2016, 2150, 2655, 2664, 2674, 2685,
			 2695, 2705, 2803, 2721, 2819, 2828, 2838, 2848, 2858, 2868,

			 2878, 2810, 2885, 2892, 2899, 2909, 2919, 3012, 3019, 3026,
			 3033, 3040, 3050, 3058, 3068, 3078, 3088, 3181, 3191, 3203,
			 3226, 3238, 3250, 3285, 3297, 3320, 3332, 3305, 3344, 3351,
			 3358, 3379, 3399, 3366, 9539, 3386, 3410, 3421, 3447, 3457,
			 3475, 3488, 3499, 3510,  305, 3517, 3524, 3568, 3546, 3553,
			 3588, 3613, 3620, 3627, 3642, 3649, 3657, 3664, 3677, 3684,
			 3691, 3716, 3723, 3738, 3753, 3780, 3790, 3812, 3827, 3842,
			 3172, 1286, 1003, 9539, 3195, 2869, 3041, 1590,  118,  370,
			  243,  821,  216, 3922,  214, 3202, 3245, 3005, 2784, 3004,
			 3011, 3917, 2791, 3929, 3168, 3931, 3754,  720,  873,  990,

			  998, 1014, 1111, 3934, 3584, 3973, 3974, 3964, 3975, 3995,
			 3981, 4006, 4028, 4033, 4036, 4057, 4058, 4043, 4088, 4080,
			 4092, 4100, 4110, 3755, 4128, 4140, 4152, 4164, 4181, 4195,
			 4180, 4229, 4209, 4238, 4228, 4258, 4236, 4288, 4289, 4296,
			 4299, 4298, 4329, 4328, 4346, 4343, 4364, 4363, 4381, 4393,
			 4416, 4400, 4424, 4434, 4417, 4464, 4462, 4457, 4469, 4484,
			 4486, 4521, 4537, 4498, 4532, 4552, 4559, 4573, 4583, 4593,
			 4610, 4617, 4624, 4641, 4628, 4670, 4678, 4677, 4692, 4704,
			 4686, 4738, 4705, 4739, 4741, 4759, 4762, 4765, 4789, 4793,
			 4807, 4823, 4838, 4839, 4854, 4869, 4847, 4887, 4853, 9539,

			 4864, 4887, 4898, 4913, 4925, 4935, 1163, 1206, 1255, 1270,
			 1330, 1351, 1359, 1375, 9539, 3761, 3798, 4877, 4945, 4957,
			 4970, 4980, 9539, 4991, 5006, 5030, 5050, 5064, 5074, 5084,
			 5104, 5128, 5182, 5202, 5226, 5236, 5209, 5243, 5250, 5257,
			 5280, 5355, 3768, 4906, 5302, 5373, 5383, 5400, 5407, 5414,
			 5421, 5428, 5448, 5476, 5521, 5541, 5548, 5555, 5175, 5565,
			 5572, 5579, 5589, 5599, 9539, 9539, 9539, 9539, 9539, 5688,
			 9539, 9539, 9539, 9539, 9539, 9539, 9539, 9539, 9539, 9539,
			 9539, 9539, 9539, 9539, 9539, 9539, 5622, 5644, 4130, 1459,
			 1496, 1558, 4319, 3229, 2270, 2447, 3502, 5564, 3612,  392,

			  141, 2280,  128,    0,  106, 3671, 5074, 5378, 5715, 5697,
			 5719, 5744, 5762, 1405, 1447, 5767, 5389, 5779, 5795, 5787,
			 5820, 5822, 5836, 5844, 5849, 5878, 5877, 5901, 5885, 5909,
			 5931, 5919, 5946, 5943, 5948, 5538, 5970, 5973, 5983, 5999,
			 6007, 6004, 6026, 6041, 6047, 6031, 6057, 6055, 6086, 6084,
			 6092, 6113, 6095, 6110, 6111, 6144, 6154, 6153, 6158, 6174,
			 6171, 6200, 6175, 6208, 6208, 6224, 6216, 6258, 6222, 6238,
			 6241, 6268, 6289, 6292, 6268, 6314, 6311, 6326, 6342, 6328,
			 6356, 6376, 6375, 6390, 6392, 6420, 6391, 6444, 6434, 6449,
			 6471, 6470, 6484, 6508, 6498, 6518, 6519, 6520, 6523, 6571,

			 6568, 6580, 6572, 6582, 6583, 6630, 6622, 6636, 6626, 6642,
			 6637, 6638, 6660, 1477, 1736, 6667, 6674, 6681, 6693, 6706,
			 6716, 6723, 6731, 6738, 6745, 6774, 6786, 6843, 6850, 6884,
			 6891, 6898, 6905, 6915, 6835, 6863, 6876, 5727, 3907, 2505,
			 2708, 6568, 3071, 5130, 3288, 5366, 3349, 6995, 5469, 6989,
			 6979, 6991, 6987, 7001, 6996, 7011, 7041, 7012, 7042, 7045,
			 7046, 7066, 7067, 7100, 7098, 7088, 7103, 7123, 7139, 7134,
			 7152, 7160, 7131, 7187, 7190, 7198, 7195, 7224, 7216, 7248,
			 7231, 7251, 7268, 7288, 7259, 7258, 7285, 7295, 7328, 7325,
			 7332, 7346, 7356, 7388, 7387, 7376, 7396, 7414, 7404, 7440,

			 7422, 7452, 7451, 7475, 7460, 7478, 7508, 7508, 7509, 7529,
			 7524, 7538, 7545, 7572, 7562, 7580, 7590, 7602, 7607, 7623,
			 7613, 7611, 7654, 7644, 7626, 7675, 7677, 7678, 7683, 7701,
			 7712, 7730, 7718, 7721, 7731, 7739, 7759, 7769, 9539, 3656,
			 5876, 3413,   95, 7778, 6945, 3509, 3538, 7138, 3676, 5095,
			 7825, 7839, 7808, 7840, 7835, 7845, 7865, 7872, 7885, 7902,
			 7899, 7903, 7932, 7929, 7936, 7956, 7951, 7963, 7996, 7966,
			 7990, 7972, 8011, 7993, 8027, 8044, 8036, 8060, 8044, 8071,
			 8072, 8102, 8112, 8122, 8117, 8069, 8133, 8166, 8168, 8182,
			 8183, 8180, 8182, 8230, 8197, 8241, 8233, 8251, 8237, 8253,

			 8261, 8291, 8258, 8294, 8294, 8314, 8299, 8315, 8322, 8355,
			 8347, 8352, 8363, 8378, 8370, 3878, 3892, 3928, 5271, 5346,
			 7761, 3951,  285, 4553, 4666, 4920, 9539, 8440, 5581, 8403,
			 8411, 8436, 8432, 8442, 8437, 8486, 8485, 8497, 8496, 8506,
			 8450, 8543, 8513, 8544, 8514, 8566, 8539, 8574, 8574, 8586,
			 8588, 8596, 8601, 8621, 8626, 8647, 8652, 8650, 8681, 8674,
			 8698, 8684, 8692, 8714, 8738, 8740, 8741, 8756, 8755,   74,
			 5173, 7820, 5512, 5585, 5680, 6726,   63, 8811, 5702, 8737,
			 8758, 8774, 8791, 8801, 8816, 8815, 8818, 8819, 8849, 8832,
			 8859, 8860, 8880, 8877, 8882, 8896, 8889, 8881, 8923, 8924, yy_Dummy>>,
			1, 1000, 0)
		end

	yy_base_template_2 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			 8944, 8939, 8949, 8945, 9011,   46, 5731, 9015, 9019, 9014,
			 9009, 9019, 9014, 9026, 9054, 9080, 9539, 9140, 9163, 9186,
			 9209, 9232, 9099, 9255, 9269, 9292, 9315, 9338, 9361, 9384,
			 9407, 9421, 9434, 9447, 9469, 9492, 9515, yy_Dummy>>,
			1, 37, 1000)
		end

	yy_def_template: SPECIAL [INTEGER] is
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make (0, 1036)
			yy_def_template_1 (an_array)
			yy_def_template_2 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_def_template_1 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
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
			 1020, 1020, 1020, 1020, 1020, 1020, 1029, 1016, 1029, 1029,
			 1029, 1029, 1029, 1029, 1029, 1029, 1016, 1016, 1016, 1016,
			 1016, 1016, 1030, 1022, 1022, 1022, 1031, 1032, 1033, 1022,
			 1022, 1016, 1016, 1016, 1016, 1016, 1016,   39,   39,   39,
			   39,   39,   62,   62,   62,   62,   62, 1016, 1016, 1016,
			 1016, 1016, 1016, 1016,   39,   62,   39,   39,   39,   39,
			   39,   62,   62,   62,   62,   62,   39,   39,   62,   62,
			   39,   39,   39,   62,   62,   62,   39,   39,   39,   62,

			   62,   62,   39,   39,   39,   39,   62,   62,   62,   62,
			   39,   39,   62,   62,   39,   62,   39,   39,   39,   39,
			   62,   62,   62,   62,   39,   62,  204,   62,   39,   39,
			   62,   62,   39,   39,   62,   62,   39,   62,   39,   39,
			   62,   62,   39,   62,   39,   62, 1016, 1023, 1023, 1023,
			 1023, 1023, 1023, 1023, 1023, 1016, 1016, 1016, 1016, 1016,
			 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1025, 1025,
			 1025, 1025, 1025, 1025, 1025, 1025, 1016, 1016, 1034, 1035,
			 1016, 1025, 1026, 1027, 1016, 1025, 1026, 1026, 1026, 1026,
			 1026, 1026, 1026, 1025, 1027, 1027, 1027, 1027, 1027, 1027,

			 1027, 1025, 1025, 1025, 1025, 1025, 1025, 1028, 1020, 1020,
			 1028, 1028, 1028, 1028, 1028, 1028, 1028, 1028, 1028, 1018,
			 1018, 1018, 1018, 1018, 1018, 1018, 1018, 1020, 1020, 1020,
			 1020, 1020, 1020, 1029, 1016, 1029, 1029, 1029, 1029, 1029,
			 1029, 1029, 1029, 1029, 1016, 1029, 1029, 1029, 1029, 1029,
			 1029, 1029, 1029, 1029, 1029, 1029, 1029, 1029, 1029, 1029,
			 1029, 1029, 1029, 1029, 1029, 1029, 1029, 1029, 1029, 1029,
			 1016, 1016, 1016, 1016, 1016, 1016, 1022, 1022, 1022, 1031,
			 1031, 1032, 1032, 1033, 1033, 1022, 1022,   39,   62,   39,
			   39,   62,   62,   39,   62,   39,   62, 1016, 1016, 1016,

			 1016, 1016, 1016,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   39,   62,   62,   39,
			   62,   39,   39,   62,   62,   39,   39,   62,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   39,   39,
			   39,   39,   62,   62,   62,   62,   62,   39,   62,   39,
			   39,   62,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   39,   39,   39,   39,   39,   62,
			   62,   62,   62,   62,   62,   39,   39,   62,   62,   39,
			   62,   39,   62,   39,   62,   39,   39,   39,   62,   62,
			   62,   39,   62,   39,   62,   39,   62,   39,   62, 1016,

			 1023, 1023, 1023, 1023, 1023, 1023, 1016, 1016, 1016, 1016,
			 1016, 1016, 1016, 1016, 1016, 1034, 1034, 1034, 1034, 1034,
			 1034, 1034, 1016, 1035, 1035, 1035, 1035, 1035, 1035, 1035,
			 1026, 1026, 1026, 1026, 1026, 1026, 1027, 1027, 1027, 1027,
			 1027, 1027, 1025, 1025, 1028, 1028, 1028, 1028, 1028, 1028,
			 1028, 1028, 1028, 1028, 1018, 1018, 1020, 1020, 1029, 1029,
			 1029, 1029, 1029, 1029, 1016, 1016, 1016, 1016, 1016, 1029,
			 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016,
			 1016, 1016, 1016, 1016, 1016, 1016, 1029, 1029, 1016, 1016,
			 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1022, 1022, 1031,

			 1031, 1032, 1032,  383, 1033, 1022, 1022,   39,   62,   39,
			   62,   39,   62, 1016, 1016,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   39,   62,   62,   39,   62,   39,
			   62,   39,   62,   39,   39,   62,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   39,   62,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   39,   62,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,

			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62, 1023, 1023, 1016, 1016, 1034, 1034, 1034, 1034, 1034,
			 1034, 1035, 1035, 1035, 1035, 1035, 1035, 1026, 1026, 1027,
			 1027, 1028, 1028, 1028, 1029, 1029, 1029, 1016, 1016, 1016,
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
			   39,   62,   39,   62,   39,   62,   39,   62,   39,   62, yy_Dummy>>,
			1, 1000, 0)
		end

	yy_def_template_2 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			   39,   62,   39,   62, 1016, 1016, 1016, 1016, 1016,   39,
			   62,   39,   62,   39,   62, 1016,    0, 1016, 1016, 1016,
			 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016,
			 1016, 1016, 1016, 1016, 1016, 1016, 1016, yy_Dummy>>,
			1, 37, 1000)
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
			   92,   92,    1,    1,   93,   93,   93,   93,   93,   93,

			   93,   93,   93,   93,   93,   93,   93,   93,   93,   93,
			   93,   93,   93,   93,   93,   93,   93,   93,   93,   93,
			   93,   93,   93,   93,   94,   95,   95,   95,   95,   95,
			   95,   95,   95,   95,   95,   95,   95,   96,   97,   97,
			    1,   98,   98,   98,   99,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1, yy_Dummy>>)
		end

	yy_meta_template: SPECIAL [INTEGER] is
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
			    1,    1,    1,   23,   23,   23,   23,   23,   23,   23, yy_Dummy>>)
		end

	yy_accept_template: SPECIAL [INTEGER] is
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make (0, 1017)
			yy_accept_template_1 (an_array)
			yy_accept_template_2 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_accept_template_1 (an_array: ARRAY [INTEGER]) is
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
			  241,  243,  245,  247,  249,  251,  253,  255,  257,  259,
			  262,  264,  266,  268,  270,  272,  274,  276,  278,  280,

			  282,  283,  284,  285,  286,  287,  288,  289,  290,  293,
			  296,  297,  298,  299,  300,  301,  302,  303,  304,  305,
			  306,  307,  308,  309,  310,  311,  312,  313,  313,  314,
			  315,  316,  317,  318,  319,  320,  321,  322,  323,  324,
			  326,  327,  328,  328,  330,  332,  333,  335,  336,  337,
			  337,  339,  340,  341,  342,  343,  344,  345,  347,  349,
			  351,  353,  356,  357,  358,  359,  360,  362,  362,  362,
			  362,  362,  362,  362,  362,  364,  365,  367,  369,  371,
			  373,  375,  376,  377,  378,  379,  380,  382,  385,  386,
			  388,  390,  392,  394,  395,  396,  397,  399,  401,  403,

			  404,  405,  406,  409,  411,  413,  416,  418,  419,  420,
			  422,  424,  426,  427,  428,  430,  431,  433,  435,  437,
			  440,  441,  442,  443,  445,  447,  448,  450,  451,  453,
			  455,  456,  457,  459,  461,  462,  463,  465,  466,  468,
			  470,  471,  472,  474,  475,  477,  478,  479,  479,  479,
			  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,
			  479,  479,  479,  479,  479,  479,  479,  479,  479,  480,
			  481,  482,  483,  484,  485,  486,  487,  488,  488,  488,
			  488,  489,  491,  492,  493,  494,  496,  497,  498,  499,
			  500,  501,  502,  503,  505,  506,  507,  508,  509,  510,

			  511,  512,  513,  514,  515,  516,  517,  518,  518,  520,
			  522,  522,  522,  522,  522,  522,  522,  522,  522,  522,
			  524,  526,  527,  528,  529,  530,  531,  532,  533,  534,
			  535,  536,  537,  538,  539,  540,  541,  542,  543,  544,
			  545,  546,  547,  548,  549,  549,  550,  551,  552,  553,
			  554,  555,  556,  557,  558,  559,  560,  561,  562,  563,
			  564,  565,  566,  567,  568,  569,  570,  571,  572,  573,
			  574,  576,  576,  576,  577,  579,  580,  582,  584,  584,
			  587,  589,  592,  594,  597,  599,  601,  601,  603,  604,
			  606,  609,  610,  612,  615,  617,  619,  620,  620,  620,

			  620,  620,  620,  620,  623,  625,  627,  628,  630,  631,
			  633,  634,  636,  637,  639,  640,  642,  644,  645,  646,
			  648,  649,  652,  654,  656,  657,  659,  661,  662,  663,
			  665,  666,  668,  669,  671,  672,  674,  675,  677,  679,
			  681,  683,  685,  686,  687,  688,  689,  690,  692,  693,
			  695,  697,  698,  699,  702,  704,  706,  707,  710,  712,
			  714,  715,  717,  718,  720,  722,  724,  726,  728,  730,
			  731,  732,  733,  734,  735,  736,  738,  740,  741,  742,
			  744,  745,  747,  748,  750,  751,  753,  755,  757,  758,
			  759,  760,  762,  763,  765,  766,  768,  769,  772,  774,

			  775,  775,  775,  775,  775,  775,  775,  775,  775,  775,
			  775,  775,  775,  775,  775,  776,  776,  776,  776,  776,
			  776,  776,  776,  777,  777,  777,  777,  777,  777,  777,
			  777,  778,  779,  780,  781,  782,  783,  784,  785,  786,
			  787,  788,  789,  790,  791,  792,  793,  793,  794,  794,
			  794,  794,  794,  794,  794,  795,  796,  797,  798,  799,
			  800,  801,  802,  803,  804,  805,  806,  807,  808,  809,
			  810,  811,  812,  813,  814,  815,  816,  817,  818,  819,
			  820,  821,  822,  823,  824,  825,  826,  827,  828,  830,
			  830,  832,  832,  834,  834,  834,  834,  836,  838,  840,

			  840,  840,  840,  840,  840,  840,  842,  844,  846,  847,
			  849,  850,  852,  853,  853,  853,  855,  856,  858,  859,
			  861,  862,  864,  865,  867,  868,  870,  871,  873,  874,
			  877,  879,  881,  882,  884,  886,  887,  888,  890,  891,
			  893,  894,  896,  897,  900,  902,  904,  905,  907,  908,
			  910,  911,  913,  914,  916,  917,  919,  920,  922,  923,
			  926,  928,  930,  931,  934,  936,  939,  941,  943,  944,
			  947,  949,  951,  953,  954,  955,  957,  958,  960,  961,
			  963,  964,  966,  967,  969,  971,  972,  973,  975,  976,
			  978,  979,  981,  982,  984,  985,  988,  990,  993,  995,

			  997,  998, 1000, 1001, 1003, 1004, 1006, 1007, 1010, 1012,
			 1015, 1017, 1017, 1017, 1017, 1017, 1017, 1017, 1017, 1017,
			 1017, 1017, 1017, 1017, 1017, 1017, 1017, 1017, 1018, 1019,
			 1020, 1021, 1021, 1021, 1021, 1022, 1023, 1024, 1025, 1027,
			 1027, 1027, 1029, 1029, 1033, 1033, 1035, 1035, 1035, 1037,
			 1040, 1042, 1045, 1047, 1049, 1050, 1053, 1055, 1058, 1060,
			 1062, 1063, 1065, 1066, 1068, 1069, 1072, 1074, 1076, 1077,
			 1079, 1080, 1082, 1083, 1085, 1086, 1088, 1089, 1091, 1092,
			 1095, 1097, 1099, 1100, 1102, 1103, 1105, 1106, 1108, 1109,
			 1112, 1114, 1116, 1117, 1119, 1120, 1122, 1123, 1126, 1128,

			 1130, 1131, 1133, 1134, 1136, 1137, 1139, 1140, 1142, 1143,
			 1145, 1146, 1148, 1149, 1151, 1152, 1154, 1155, 1158, 1160,
			 1162, 1163, 1165, 1166, 1169, 1171, 1173, 1174, 1176, 1177,
			 1180, 1182, 1184, 1185, 1185, 1185, 1185, 1185, 1185, 1186,
			 1186, 1188, 1188, 1189, 1190, 1194, 1194, 1194, 1196, 1196,
			 1197, 1197, 1200, 1202, 1204, 1205, 1208, 1210, 1212, 1213,
			 1215, 1216, 1218, 1219, 1222, 1224, 1227, 1229, 1231, 1232,
			 1235, 1237, 1239, 1240, 1242, 1243, 1246, 1248, 1250, 1251,
			 1253, 1254, 1256, 1257, 1259, 1260, 1262, 1263, 1265, 1266,
			 1268, 1269, 1272, 1274, 1276, 1277, 1279, 1280, 1283, 1285,

			 1287, 1288, 1291, 1293, 1296, 1298, 1301, 1303, 1305, 1306,
			 1308, 1309, 1312, 1314, 1316, 1317, 1317, 1318, 1318, 1318,
			 1318, 1322, 1322, 1323, 1324, 1324, 1324, 1325, 1326, 1327,
			 1330, 1332, 1334, 1335, 1338, 1340, 1342, 1343, 1345, 1346,
			 1348, 1349, 1352, 1354, 1357, 1359, 1361, 1362, 1365, 1367,
			 1370, 1372, 1374, 1375, 1377, 1378, 1380, 1381, 1383, 1384,
			 1386, 1387, 1390, 1392, 1394, 1395, 1397, 1398, 1401, 1403,
			 1404, 1404, 1405, 1405, 1407, 1407, 1407, 1408, 1409, 1409,
			 1410, 1413, 1415, 1418, 1420, 1423, 1425, 1428, 1430, 1433,
			 1435, 1437, 1438, 1441, 1443, 1445, 1446, 1449, 1451, 1453, yy_Dummy>>,
			1, 1000, 0)
		end

	yy_accept_template_2 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			 1454, 1457, 1459, 1462, 1464, 1465, 1467, 1467, 1469, 1470,
			 1473, 1475, 1478, 1480, 1483, 1485, 1487, 1487, yy_Dummy>>,
			1, 18, 1000)
		end

	yy_acclist_template: SPECIAL [INTEGER] is
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make (0, 1486)
			yy_acclist_template_1 (an_array)
			yy_acclist_template_2 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_acclist_template_1 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			    0,  138,  138,  159,  157,  158,    3,  157,  158,    4,
			  158,    1,  157,  158,    2,  157,  158,   10,  157,  158,
			  140,  157,  158,  105,  157,  158,   17,  157,  158,  140,
			  157,  158,  157,  158,   11,  157,  158,   12,  157,  158,
			   31,  157,  158,   30,  157,  158,    8,  157,  158,   29,
			  157,  158,    6,  157,  158,   32,  157,  158,  142,  149,
			  157,  158,  142,  149,  157,  158,  142,  149,  157,  158,
			    9,  157,  158,    7,  157,  158,   36,  157,  158,   34,
			  157,  158,   35,  157,  158,  157,  158,  103,  104,  157,
			  158,  103,  104,  157,  158,  103,  104,  157,  158,  103,

			  104,  157,  158,  103,  104,  157,  158,  103,  104,  157,
			  158,  103,  104,  157,  158,  103,  104,  157,  158,  103,
			  104,  157,  158,  103,  104,  157,  158,  103,  104,  157,
			  158,  103,  104,  157,  158,  103,  104,  157,  158,  103,
			  104,  157,  158,  103,  104,  157,  158,  103,  104,  157,
			  158,  103,  104,  157,  158,  103,  104,  157,  158,  103,
			  104,  157,  158,   15,  157,  158,  157,  158,   16,  157,
			  158,   33,  157,  158,  157,  158,  104,  157,  158,  104,
			  157,  158,  104,  157,  158,  104,  157,  158,  104,  157,
			  158,  104,  157,  158,  104,  157,  158,  104,  157,  158,

			  104,  157,  158,  104,  157,  158,  104,  157,  158,  104,
			  157,  158,  104,  157,  158,  104,  157,  158,  104,  157,
			  158,  104,  157,  158,  104,  157,  158,  104,  157,  158,
			  104,  157,  158,   13,  157,  158,   14,  157,  158,  157,
			  158,  157,  158,  157,  158,  157,  158,  157,  158,  157,
			  158,  157,  158,  138,  158,  136,  158,  137,  158,  132,
			  138,  158,  135,  158,  138,  158,  138,  158,  138,  158,
			  138,  158,  138,  158,  138,  158,  138,  158,  138,  158,
			  138,  158,    3,    4,    1,    2,   37,  140,  139,  139,
			 -130,  140, -288, -131,  140, -289,  140,  140,  140,  140,

			  140,  140,  140,  105,  140,  140,  140,  140,  140,  140,
			  140,  140,  129,  129,  129,  129,  129,  129,  129,  129,
			  129,    5,   23,   24,  152,  155,   18,   20,  142,  149,
			  142,  149,  149,  141,  149,  149,  149,  141,  149,   28,
			   25,   22,   21,   26,   27,  103,  104,  103,  104,  103,
			  104,  103,  104,   42,  103,  104,  104,  104,  104,  104,
			   42,  104,  103,  104,  104,  103,  104,  103,  104,  103,
			  104,  103,  104,  103,  104,  104,  104,  104,  104,  104,
			  103,  104,   53,  103,  104,  104,   53,  104,  103,  104,
			  103,  104,  103,  104,  104,  104,  104,  103,  104,  103,

			  104,  103,  104,  104,  104,  104,   65,  103,  104,  103,
			  104,  103,  104,   72,  103,  104,   65,  104,  104,  104,
			   72,  104,  103,  104,  103,  104,  104,  104,  103,  104,
			  104,  103,  104,  103,  104,  103,  104,   81,  103,  104,
			  104,  104,  104,   81,  104,  103,  104,  104,  103,  104,
			  104,  103,  104,  103,  104,  104,  104,  103,  104,  103,
			  104,  104,  104,  103,  104,  104,  103,  104,  103,  104,
			  104,  104,  103,  104,  104,  103,  104,  104,   19,  138,
			  138,  138,  138,  138,  138,  138,  138,  136,  137,  132,
			  138,  138,  138,  135,  133,  138,  138,  138,  138,  138,

			  138,  138,  138,  134,  138,  138,  138,  138,  138,  138,
			  138,  138,  138,  138,  138,  138,  138,  138,  139,  140,
			  139,  140, -130,  140, -131,  140,  140,  140,  140,  140,
			  140,  140,  140,  140,  140,  140,  140,  140,  129,  106,
			  129,  129,  129,  129,  129,  129,  129,  129,  129,  129,
			  129,  129,  129,  129,  129,  129,  129,  129,  129,  129,
			  129,  129,  129,  129,  129,  129,  129,  129,  129,  129,
			  129,  129,  129,  129,  152,  155,  150,  152,  155,  150,
			  142,  149,  142,  149,  145,  148,  149,  148,  149,  144,
			  147,  149,  147,  149,  143,  146,  149,  146,  149,  142,

			  149,  103,  104,  104,  103,  104,   40,  103,  104,  104,
			   40,  104,   41,  103,  104,   41,  104,  103,  104,  104,
			   44,  103,  104,   44,  104,  103,  104,  104,  103,  104,
			  104,  103,  104,  104,  103,  104,  104,  103,  104,  104,
			  103,  104,  103,  104,  104,  104,  103,  104,  104,   56,
			  103,  104,  103,  104,   56,  104,  104,  103,  104,  103,
			  104,  104,  104,  103,  104,  104,  103,  104,  104,  103,
			  104,  104,  103,  104,  104,  103,  104,  103,  104,  103,
			  104,  103,  104,  103,  104,  104,  104,  104,  104,  104,
			  103,  104,  104,  103,  104,  103,  104,  104,  104,   76,

			  103,  104,   76,  104,  103,  104,  104,   79,  103,  104,
			   79,  104,  103,  104,  104,  103,  104,  104,  103,  104,
			  103,  104,  103,  104,  103,  104,  103,  104,  103,  104,
			  104,  104,  104,  104,  104,  104,  103,  104,  103,  104,
			  104,  104,  103,  104,  104,  103,  104,  104,  103,  104,
			  104,  103,  104,  103,  104,  103,  104,  104,  104,  104,
			  103,  104,  104,  103,  104,  104,  103,  104,  104,  102,
			  103,  104,  102,  104,  156,  133,  134,  138,  138,  138,
			  138,  138,  138,  138,  138,  138,  138,  138,  138,  138,
			  138,  139,  139,  139,  140,  140,  140,  140,  129,  129,

			  129,  129,  129,  129,  123,  121,  122,  124,  125,  129,
			  126,  127,  107,  108,  109,  110,  111,  112,  113,  114,
			  115,  116,  117,  118,  119,  120,  129,  129,  152,  155,
			  152,  155,  152,  155,  151,  154,  142,  149,  142,  149,
			  142,  149,  142,  149,  103,  104,  104,  103,  104,  104,
			  103,  104,  104,  103,  104,  104,  103,  104,  104,  103,
			  104,  104,  103,  104,  104,  103,  104,  104,  103,  104,
			  104,  103,  104,  104,   54,  103,  104,   54,  104,  103,
			  104,  104,  103,  104,  103,  104,  104,  104,  103,  104,
			  104,  103,  104,  104,  103,  104,  104,   63,  103,  104,

			  103,  104,   63,  104,  104,  103,  104,  104,  103,  104,
			  104,  103,  104,  104,  103,  104,  104,  103,  104,  104,
			  103,  104,  104,   73,  103,  104,   73,  104,  103,  104,
			  104,   75,  103,  104,   75,  104,   77,  103,  104,   77,
			  104,  103,  104,  104,   80,  103,  104,   80,  104,  103,
			  104,  103,  104,  104,  104,  103,  104,  104,  103,  104,
			  104,  103,  104,  104,  103,  104,  104,  103,  104,  103,
			  104,  104,  104,  103,  104,  104,  103,  104,  104,  103,
			  104,  104,  103,  104,  104,   94,  103,  104,   94,  104,
			   95,  103,  104,   95,  104,  103,  104,  104,  103,  104, yy_Dummy>>,
			1, 1000, 0)
		end

	yy_acclist_template_2 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			  104,  103,  104,  104,  103,  104,  104,  100,  103,  104,
			  100,  104,  101,  103,  104,  101,  104,  138,  138,  138,
			  138,  129,  129,  129,  152,  152,  155,  152,  155,  151,
			  152,  154,  155,  151,  154,  142,  149,   38,  103,  104,
			   38,  104,   39,  103,  104,   39,  104,  103,  104,  104,
			   45,  103,  104,   45,  104,   46,  103,  104,   46,  104,
			  103,  104,  104,  103,  104,  104,  103,  104,  104,   51,
			  103,  104,   51,  104,  103,  104,  104,  103,  104,  104,
			  103,  104,  104,  103,  104,  104,  103,  104,  104,  103,
			  104,  104,   61,  103,  104,   61,  104,  103,  104,  104,

			  103,  104,  104,  103,  104,  104,  103,  104,  104,   68,
			  103,  104,   68,  104,  103,  104,  104,  103,  104,  104,
			  103,  104,  104,   74,  103,  104,   74,  104,  103,  104,
			  104,  103,  104,  104,  103,  104,  104,  103,  104,  104,
			  103,  104,  104,  103,  104,  104,  103,  104,  104,  103,
			  104,  104,  103,  104,  104,   90,  103,  104,   90,  104,
			  103,  104,  104,  103,  104,  104,   93,  103,  104,   93,
			  104,  103,  104,  104,  103,  104,  104,   98,  103,  104,
			   98,  104,  103,  104,  104,  128,  152,  155,  155,  152,
			  151,  152,  154,  155,  151,  154,  150,   43,  103,  104,

			   43,  104,  103,  104,  104,   48,  103,  104,  103,  104,
			   48,  104,  104,  103,  104,  104,  103,  104,  104,   55,
			  103,  104,   55,  104,   57,  103,  104,   57,  104,  103,
			  104,  104,   59,  103,  104,   59,  104,  103,  104,  104,
			  103,  104,  104,   64,  103,  104,   64,  104,  103,  104,
			  104,  103,  104,  104,  103,  104,  104,  103,  104,  104,
			  103,  104,  104,  103,  104,  104,  103,  104,  104,   83,
			  103,  104,   83,  104,  103,  104,  104,  103,  104,  104,
			   86,  103,  104,   86,  104,  103,  104,  104,   88,  103,
			  104,   88,  104,   89,  103,  104,   89,  104,   91,  103,

			  104,   91,  104,  103,  104,  104,  103,  104,  104,   97,
			  103,  104,   97,  104,  103,  104,  104,  152,  151,  152,
			  154,  155,  155,  151,  153,  155,  153,   47,  103,  104,
			   47,  104,  103,  104,  104,   50,  103,  104,   50,  104,
			  103,  104,  104,  103,  104,  104,  103,  104,  104,   62,
			  103,  104,   62,  104,   66,  103,  104,   66,  104,  103,
			  104,  104,   69,  103,  104,   69,  104,   70,  103,  104,
			   70,  104,  103,  104,  104,  103,  104,  104,  103,  104,
			  104,  103,  104,  104,  103,  104,  104,   87,  103,  104,
			   87,  104,  103,  104,  104,  103,  104,  104,   99,  103,

			  104,   99,  104,  155,  155,  151,  152,  154,  155,  154,
			   49,  103,  104,   49,  104,   52,  103,  104,   52,  104,
			   58,  103,  104,   58,  104,   60,  103,  104,   60,  104,
			   67,  103,  104,   67,  104,  103,  104,  104,   78,  103,
			  104,   78,  104,  103,  104,  104,   85,  103,  104,   85,
			  104,  103,  104,  104,   92,  103,  104,   92,  104,   96,
			  103,  104,   96,  104,  155,  154,  155,  154,  155,  154,
			   71,  103,  104,   71,  104,   82,  103,  104,   82,  104,
			   84,  103,  104,   84,  104,  154,  155, yy_Dummy>>,
			1, 487, 1000)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER is 9539
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
