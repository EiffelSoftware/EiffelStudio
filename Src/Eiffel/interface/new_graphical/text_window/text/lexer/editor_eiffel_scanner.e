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
					
when 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103 then
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
										
when 104 then
--|#line 209 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 209")
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
										
when 105 then
--|#line 229 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 229")
end

										if not in_comments then
											curr_token := new_text (text)											
										else
											curr_token := new_comment (text)
										end
										update_token_list
										
when 106 then
--|#line 241 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 241")
end

										if not in_comments then
											curr_token := new_text (text)										
										else
											curr_token := new_comment (text)
										end
										update_token_list
										
when 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128 then
--|#line 255 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 255")
end

					if not in_comments then
						curr_token := new_character (text)
					else
						curr_token := new_comment (text)
					end
					update_token_list
					
when 129 then
--|#line 285 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 285")
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
					
when 130 then
--|#line 300 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 300")
end

					-- Character error. Catch-all rules (no backing up)
					if not in_comments then
						curr_token := new_text (text)
					else
						curr_token := new_comment (text)
					end
					update_token_list
					
when 131 then
--|#line 322 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 322")
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
--|#line 336 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 336")
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
			
when 133 then
--|#line 351 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 351")
end
-- Ignore carriage return
when 134 then
--|#line 352 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 352")
end

							-- Verbatim string closer, possibly.
						curr_token := new_string (text)						
						end_of_verbatim_string := True
						in_verbatim_string := False
						set_start_condition (INITIAL)
						update_token_list
					
when 135 then
--|#line 361 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 361")
end

							-- Verbatim string closer, possibly.
						curr_token := new_string (text)						
						end_of_verbatim_string := True
						in_verbatim_string := False
						set_start_condition (INITIAL)
						update_token_list
					
when 136 then
--|#line 370 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 370")
end

						curr_token := new_space (text_count)
						update_token_list						
					
when 137 then
--|#line 375 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 375")
end
						
						curr_token := new_tabulation (text_count)
						update_token_list						
					
when 138 then
--|#line 380 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 380")
end

						from i_ := 1 until i_ > text_count loop
							curr_token := new_eol
							update_token_list
							i_ := i_ + 1
						end						
					
when 139 then
--|#line 388 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 388")
end

						curr_token := new_string (text)
						update_token_list
					
when 140, 141 then
--|#line 394 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 394")
end

					-- Eiffel String
					if not in_comments then						
						curr_token := new_string (text)
					else
						curr_token := new_comment (text)
					end
					update_token_list
					
when 142 then
--|#line 407 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 407")
end

					-- Eiffel Bit
					if not in_comments then
						curr_token := new_number (text)						
					else
						curr_token := new_comment (text)
					end
					update_token_list
					
when 143, 144, 145, 146 then
--|#line 419 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 419")
end

						-- Eiffel Integer
						if not in_comments then
							curr_token := new_number (text)
						else
							curr_token := new_comment (text)
						end
						update_token_list
						
when 147, 148, 149, 150 then
--|#line 433 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 433")
end

						-- Bad Eiffel Integer
						if not in_comments then
							curr_token := new_text (text)
						else
							curr_token := new_comment (text)
						end
						update_token_list
						
when 151 then
	yy_end := yy_end - 1
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
						
when 152, 153 then
--|#line 449 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 449")
end

							-- Eiffel reals & doubles
						if not in_comments then		
							curr_token := new_number (text)
						else
							curr_token := new_comment (text)
						end
						update_token_list
						
when 154 then
	yy_end := yy_end - 1
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
						
when 155, 156 then
--|#line 452 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 452")
end

							-- Eiffel reals & doubles
						if not in_comments then		
							curr_token := new_number (text)
						else
							curr_token := new_comment (text)
						end
						update_token_list
						
when 157 then
--|#line 469 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 469")
end

					curr_token := new_text (text)
					update_token_list
					
when 158 then
--|#line 477 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 477")
end

					-- Error (considered as text)
				if not in_comments then
					curr_token := new_text (text)
				else
					curr_token := new_comment (text)
				end
				update_token_list
				
when 159 then
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
			create an_array.make (0, 9782)
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

			   87,   88,   89,   90,  136,  138,  853,  139,  139,  139,
			  139,   87,   88,   89,   90,  137,  140,  142, 1032,  143,
			  143,  144,  144,  752,  141,  152,  153, 1032,  106,  928,
			  150,  107,  154,  155,  745,  106, 1032,  127,  107,  127,
			  127,  157,  157,  157,  142,  128,  143,  143,  144,  144,
			  265,  265,  265,  266,  266,  374,   91,  146,  147,  149,
			  380,  928,  150,  267,  267,  267,  608,   91,  142,  380,
			  144,  144,  144,  144,  268,  268,  268,  108,  380,  148,
			  157,  157,  157,  402,  402,  402,  149,   92,  606,  146,
			  147,   93,   94,   95,   96,   97,   98,   99,   92,  381,

			  381,  604,   93,   94,   95,   96,   97,   98,   99,  109,
			  149,  148,  403,  403,  110,  111,  112,  113,  114,  115,
			  116,  119,  120,  121,  122,  123,  124,  125,  129,  130,
			  131,  132,  133,  134,  135,  157,  157,  157,  157,  380,
			  404,  404,  404,  512,  512,  157,  157,  157,  157,  157,
			  157,  158,  157,  157,  157,  157,  159,  157,  160,  157,
			  157,  157,  157,  161,  162,  157,  157,  157,  157,  157,
			  157,  405,  405,  405,  608,  157,  606,  163,  163,  163,
			  163,  163,  163,  164,  163,  163,  163,  163,  165,  163,
			  166,  163,  163,  163,  163,  167,  168,  163,  163,  163,

			  163,  163,  163,  604,  372,  372,  372,  372,  169,  170,
			  171,  172,  173,  174,  175,  157,  570,  176,  373,  282,
			  157,  157,  157,  515,  510,  157,  406,  157,  157,  401,
			  336,  157,  163,  163,  163,  157,  103,  102,  157,  212,
			  101,  383,  383,  383,  374,  213,  100,  163,  157,  177,
			  373,  282,  163,  163,  163,  381,  381,  163,  269,  163,
			  163,  157,  178,  163,  264,  248,  179,  163,  157,  180,
			  163,  214,  181,  157,  157,  182,  188,  215,  156,  157,
			  163,  380,  151,  157,  104,  163,  189,  163,  278,  157,
			  279,  279,  157,  163,  183,  603,  103,  163,  184,  102,

			  163,  185,  987,  101,  186,  163,  163,  187,  190,  100,
			  279,  163,  279,  286, 1032,  163, 1032,  163,  191,  163,
			  157,  163,  157, 1032,  163,  192,  157,  193,  598,  163,
			 1032,  198,  157,  157,  987,  199,  216,  194,  157,  157,
			 1032, 1032,  157, 1032,  280,  157, 1032, 1032,  200, 1032,
			 1032,  157,  163, 1032,  163, 1032,  157,  195,  163,  196,
			  157,  381,  381,  201,  163,  163,  280,  202,  217,  197,
			  163,  163, 1032,  226,  163,  281, 1032,  163,  157,  218,
			  203,  157,  157,  163, 1032,  157,  204, 1032,  163,  219,
			 1032,  220,  163,  205,  206,  221, 1032,  281,  157,  207,

			 1032,  603,  157,  157, 1032,  227,  228,  230, 1032, 1032,
			  163,  222, 1032,  163,  163, 1032, 1032,  163,  208,  157,
			  157,  223,  231,  224,  157,  209,  210,  225,  157,  157,
			  163,  211, 1032,  157,  163,  163,  234,  238,  229,  232,
			  157,  157, 1032, 1032,  157,  240,  235,  244, 1032,  157,
			 1032,  163,  163, 1032,  233, 1032,  163,  157, 1032,  241,
			  163,  163,  157, 1032, 1032,  163,  157, 1032,  236,  239,
			  157, 1032,  163,  163, 1032, 1032,  163,  242,  237,  245,
			  246,  163,  177,  157,  511,  511,  511, 1032,  163,  163,
			  239,  243, 1032, 1032,  163,  513,  513,  513,  163, 1032,

			  163, 1032,  163,  250,  251,  252,  253,  254,  255,  256,
			 1032, 1032,  247,  201,  177,  163,  164,  202, 1032, 1032,
			  163,  165,  239,  166,  163, 1032,  163, 1032,  167,  168,
			  203, 1032,  163,  514,  514,  514,  163,  257,  258,  259,
			  260,  261,  262,  263, 1032,  201, 1032, 1032,  164,  202,
			  157,  157,  157,  165, 1032,  166,  163, 1032,  163, 1032,
			  167,  168,  203,  157,  157,  157, 1032,  142,  163,  379,
			  379,  379,  379,  257,  258,  259,  260,  261,  262,  263,
			  183, 1032, 1032,  214,  184,  190,  163,  185,  163,  215,
			  186, 1032, 1032,  187, 1032,  191, 1032, 1032,  163,  195,

			 1032,  196,  271,  272,  273,  274,  275,  276,  277,  149,
			 1032,  197,  183, 1032, 1032,  214,  184,  190,  163,  185,
			  163,  215,  186, 1032, 1032,  187,  278,  191,  279,  279,
			  163,  195, 1032,  196, 1032, 1032,  257,  258,  259,  260,
			  261,  262,  263,  197,  257,  258,  259,  260,  261,  262,
			  263,  257,  258,  259,  260,  261,  262,  263,  208, 1032,
			  163, 1032,  163,  217,  163,  209,  210,  222,  163, 1032,
			  163,  211,  163, 1032,  227, 1032,  163,  223, 1032,  224,
			  163, 1032,  280,  225,  157,  157,  157, 1032, 1032,  163,
			  208, 1032,  163, 1032,  163,  217,  163,  209,  210,  222,

			  163, 1032,  163,  211,  163, 1032,  227,  229,  163,  223,
			  232,  224,  163,  281,  163,  225,  163,  163,  236,  163,
			 1032,  163,  163,  157,  163,  233,  163,  157,  237,  163,
			  242,  245, 1032, 1032,  163,  163, 1032,  163, 1032,  229,
			  157,  163,  232,  163,  243, 1032,  163,  163,  163,  163,
			  236,  163, 1032,  163,  163,  163,  163,  233,  163,  163,
			  237,  163,  242,  245, 1032, 1032,  163,  163,  163,  163,
			  163,  247,  163,  163, 1032,  163,  243, 1032, 1032,  163,
			  163,  279, 1032,  283,  279,  163, 1032, 1032,  280, 1032,
			 1032,  280, 1032,  287, 1032, 1032,  270,  157,  157,  157,

			  163,  281,  163,  247,  281, 1032,  295, 1032, 1032,  270,
			 1032, 1032,  163,  271,  272,  273,  274,  275,  276,  277,
			  303,  271,  272,  273,  274,  275,  276,  277,  516,  516,
			  516, 1032, 1032,  106, 1032, 1032,  107,  284,  304,  304,
			  304,  271,  272,  273,  274,  275,  276,  277,  305,  305,
			 1032,  271,  272,  273,  274,  275,  276,  277,  306,  306,
			  306,  271,  272,  273,  274,  275,  276,  277,  285,  517,
			  517,  517,  271,  272,  273,  274,  275,  276,  277,  288,
			  289,  290,  291,  292,  293,  294,  106, 1032, 1032,  107,
			 1032, 1032,  296,  297,  298,  299,  300,  301,  302,  307, yy_Dummy>>,
			1, 1000, 0)
		end

	yy_nxt_template_2 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			  307,  307,  271,  272,  273,  274,  275,  276,  277,  308,
			 1032, 1032,  271,  272,  273,  274,  275,  276,  277,  119,
			  120,  121,  122,  123,  124,  125, 1032, 1032, 1032,  387,
			  387,  387,  387, 1032, 1032,  108, 1032, 1032,  321, 1032,
			  321,  321,  593,  106,  593, 1032,  107,  594,  594,  594,
			  594,  322, 1032,  322,  322, 1032,  106, 1032, 1032,  107,
			  271,  272,  273,  274,  275,  276,  277,  109,  106,  388,
			 1032,  107,  110,  111,  112,  113,  114,  115,  116,  310,
			 1032, 1032,  311,  118,  118,  118,  595,  595,  595,  595,
			  106,  312,  108,  107,  376,  376,  376,  376,  118, 1032,

			  118, 1032,  118,  118,  313,  108,  336,  118,  377,  118,
			  157,  157,  157,  118, 1032,  118, 1032,  108,  118,  118,
			  118,  118,  118,  118,  109,  106, 1032, 1032,  107,  110,
			  111,  112,  113,  114,  115,  116, 1032,  109,  106, 1032,
			  377,  107,  110,  111,  112,  113,  114,  115,  116,  109,
			  106, 1032, 1032,  107,  110,  111,  112,  113,  114,  115,
			  116,  592,  592,  592,  592,  314,  315,  316,  317,  318,
			  319,  320, 1032,  336,  108,  373,  119,  120,  121,  122,
			  123,  124,  125,  106, 1032, 1032,  107,  108,  337,  338,
			  339,  340,  341,  342,  343,  106, 1032, 1032,  107,  108,

			 1032,  374,  157,  157,  157, 1032,  109,  373, 1032, 1032,
			  323,  110,  111,  112,  113,  114,  115,  116, 1032,  109,
			 1032,  324,  324,  324,  110,  111,  112,  113,  114,  115,
			  116,  109,  108,  325,  325, 1032,  110,  111,  112,  113,
			  114,  115,  116,  106,  108, 1032,  107,  157,  157,  157,
			 1032,  106,  368,  368,  107,  337,  338,  339,  340,  341,
			  342,  343,  106, 1032,  109,  107,  326,  326,  326,  110,
			  111,  112,  113,  114,  115,  116,  109,  336,  327,  327,
			  327,  110,  111,  112,  113,  114,  115,  116,  106, 1032,
			 1032,  107,  108,  157,  157,  157, 1032,  599,  106,  599,

			 1032,  107,  600,  600,  600,  600, 1032, 1032,  106, 1032,
			 1032,  107,  619,  619,  619,  383,  383,  383,  106, 1032,
			 1032,  107, 1032, 1032,  109, 1032,  328, 1032, 1032,  110,
			  111,  112,  113,  114,  115,  116,  329,  119,  120,  121,
			  122,  123,  124,  125, 1032,  330,  330,  330,  119,  120,
			  121,  122,  123,  124,  125,  605,  126,  126,  126,  337,
			  338,  339,  340,  341,  342,  343,  620,  620,  620, 1032,
			 1032,  331,  331, 1032,  119,  120,  121,  122,  123,  124,
			  125,  332,  332,  332,  119,  120,  121,  122,  123,  124,
			  125,  333,  333,  333,  119,  120,  121,  122,  123,  124,

			  125,  334,  336, 1032,  119,  120,  121,  122,  123,  124,
			  125,  344, 1032, 1032,  345,  346,  347,  348,  163,  163,
			  163, 1032, 1032,  349, 1032,  336, 1032,  157, 1032,  157,
			  350,  389,  351,  409,  352,  353,  354,  355,  336,  356,
			 1032,  357, 1032, 1032,  157,  358,  157,  359,  336, 1032,
			  360,  361,  362,  363,  364,  365, 1032, 1032,  336,  163,
			 1032,  163, 1032,  390, 1032,  410,  163,  163,  163, 1032,
			 1032,  503,  163,  163,  163, 1032,  163, 1032,  163,  163,
			  163,  163, 1032,  366,  337,  338,  339,  340,  341,  342,
			  343,  503,  719,  719,  719, 1032, 1032,  337,  338,  339,

			  340,  341,  342,  343,  367,  367,  367,  337,  338,  339,
			  340,  341,  342,  343,  720,  720,  720,  369,  369,  369,
			  337,  338,  339,  340,  341,  342,  343,  370,  370,  370,
			  337,  338,  339,  340,  341,  342,  343,  371, 1032, 1032,
			  337,  338,  339,  340,  341,  342,  343,  142, 1032,  378,
			  378,  379,  379,  250,  251,  252,  253,  254,  255,  256,
			  150,  279, 1032,  279,  279, 1032,  157, 1032, 1032,  395,
			  157, 1032, 1032,  250,  251,  252,  253,  254,  255,  256,
			  157, 1032,  157,  157,  157, 1032,  157, 1032,  391,  149,
			 1032,  392,  150,  385,  385,  385,  385,  157,  163,  157,

			  397,  396,  163,  385,  385,  385,  385,  385,  385,  157,
			 1032, 1032,  163,  157,  163,  163,  163,  280,  163, 1032,
			  393, 1032,  163,  394,  163, 1032,  157, 1032,  399,  163,
			 1032,  163,  398,  380,  163,  385,  385,  385,  385,  385,
			  385,  163,  390, 1032, 1032,  163, 1032,  393,  281,  163,
			  394,  163,  163, 1032,  163,  396,  163,  163,  163,  163,
			  400,  163,  163,  163,  398,  163,  163, 1032,  163,  163,
			  163, 1032, 1032,  157,  390,  163,  400,  157, 1032,  393,
			  163,  163,  394,  163,  163, 1032, 1032,  396, 1032,  163,
			  157,  163,  407,  163,  163,  163,  398,  163, 1032,  411,

			  163,  163,  163,  157, 1032,  163, 1032,  163,  400,  163,
			  157,  163,  163,  163,  415,  412,  157,  157, 1032,  408,
			 1032,  157,  163,  163,  408, 1032,  163,  157,  163, 1032,
			  413,  412, 1032,  157,  157,  163, 1032,  157,  163,  157,
			  157,  157,  163,  163, 1032,  163,  416,  412,  163,  163,
			  417,  408, 1032,  163,  410,  163, 1032, 1032,  163,  163,
			  163,  163,  414,  163, 1032,  163,  163, 1032,  416,  163,
			  163, 1032,  163,  163,  414,  163, 1032,  163, 1032,  163,
			 1032,  163,  418, 1032,  163,  418,  410,  163,  157,  157,
			  157,  163, 1032,  163, 1032,  163, 1032,  157,  419, 1032,

			  416,  157,  420, 1032,  163,  163,  414,  163,  157,  163,
			 1032,  163,  157,  163,  157, 1032,  163,  418, 1032,  163,
			  163, 1032,  163,  163,  157,  157, 1032,  421,  157,  163,
			  421,  422,  163,  163,  422, 1032, 1032,  163, 1032,  163,
			  163,  157,  423, 1032,  163,  279,  163,  279,  286,  163,
			 1032,  157,  163, 1032,  163,  157,  163,  163,  157,  421,
			  163,  425,  157,  422,  163,  163,  429,  163,  157,  163,
			  430,  163,  424,  163,  424,  157,  426,  163, 1032, 1032,
			  163,  163,  163,  163,  431, 1032, 1032,  163,  432, 1032,
			  163, 1032,  163,  427,  163,  427, 1032,  163,  431,  163,

			  163,  280,  432,  163,  424,  163, 1032,  163,  428,  163,
			  428, 1032,  163, 1032,  163,  163,  431,  157, 1032,  435,
			  432,  157, 1032,  157,  163, 1032,  157,  427,  433,  434,
			  157,  163,  281,  436,  157,  163,  157,  163, 1032, 1032,
			  437,  163,  428,  157,  163, 1032,  163,  163, 1032,  163,
			 1032,  436, 1032,  163, 1032,  163,  163, 1032,  163, 1032,
			  434,  434,  163,  163, 1032,  436,  163,  163,  163,  163,
			  438, 1032,  438,  163, 1032,  163,  163,  157,  163,  163,
			  157,  157, 1032, 1032,  157, 1032,  157, 1032,  163, 1032,
			  157,  383,  383,  383,  157,  439, 1032,  157, 1032,  163, yy_Dummy>>,
			1, 1000, 1000)
		end

	yy_nxt_template_3 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			 1032,  163,  438,  157,  594,  594,  594,  594,  163,  163,
			  163,  163,  163,  163, 1032,  441,  163,  442,  163,  443,
			  163, 1032,  163, 1032,  157,  157,  163,  440, 1032,  163,
			  444,  605,  163,  445,  163,  163,  440,  157, 1032,  463,
			  163,  157,  163, 1032,  163, 1032,  163,  446,  163,  447,
			 1032,  448,  163, 1032,  157, 1032,  163,  163,  163,  157,
			  157,  157,  449, 1032,  163,  450,  163, 1032,  440,  163,
			 1032,  464, 1032,  163, 1032, 1032,  163,  446,  163,  447,
			  163,  448, 1032, 1032,  157,  163,  163,  163,  157,  157,
			  163,  453,  449,  157,  451,  450, 1032,  163, 1032,  452,

			  163,  157,  163,  454, 1032, 1032,  157, 1032, 1032,  446,
			 1032,  447,  163,  448, 1032, 1032,  163,  163, 1032,  163,
			  163,  163, 1032,  455,  449,  163,  452,  450,  455,  163,
			 1032,  452,  163,  163,  163,  456, 1032,  163,  163,  163,
			  456, 1032,  157,  163,  163,  163,  157, 1032,  157,  163,
			  157,  458,  157,  461,  157,  163,  157,  157,  157,  157,
			  455,  457,  163,  163,  163,  157,  459,  157, 1032,  163,
			 1032,  163,  456, 1032,  163,  163, 1032,  163,  163, 1032,
			  163,  163,  163,  458,  163,  462,  163,  163,  157, 1032,
			 1032,  163,  157,  458,  163, 1032,  163,  163,  460,  163,

			  464,  460,  462, 1032, 1032,  157,  163, 1032, 1032,  163,
			  163,  163,  163,  163,  157,  163, 1032, 1032,  465, 1032,
			  163,  163,  163,  157,  163,  163,  163,  157,  163, 1032,
			 1032,  157,  464,  460,  462, 1032, 1032,  163,  163, 1032,
			  483,  163,  163,  163,  163,  163,  163,  163, 1032,  466,
			  466, 1032, 1032,  163,  163,  163,  163,  163,  163,  163,
			  467, 1032,  468,  163,  163,  163,  163,  157,  163,  157,
			  469,  157,  484,  470, 1032,  471,  472, 1032,  479, 1032,
			 1032,  466,  480, 1032,  157, 1032, 1032, 1032,  163, 1032,
			  163, 1032,  473, 1032,  474,  746,  746,  746,  746,  163,

			  163,  163,  475,  163, 1032,  476,  503,  477,  478,  473,
			  481,  474, 1032, 1032,  482, 1032,  163,  163, 1032,  475,
			 1032,  163,  476,  163,  477,  478,  481,  484,  163,  163,
			  482,  157, 1032,  163, 1032,  485, 1032, 1032,  163, 1032,
			 1032,  473, 1032,  474,  750,  750,  750,  750,  157,  163,
			 1032,  475, 1032,  163,  476,  163,  477,  478,  481,  484,
			  163,  163,  482,  163,  157,  163,  486,  486,  157, 1032,
			  163, 1032, 1032,  163,  163,  163,  163, 1032, 1032, 1032,
			  163,  157, 1032,  488,  487,  163,  163,  504,  250,  251,
			  252,  253,  254,  255,  256, 1032,  163, 1032,  486, 1032,

			  163,  600,  600,  600,  600,  163,  163,  163,  163,  744,
			  744,  744,  744,  163, 1032,  488,  488,  163,  163,  157,
			 1032,  492,  489,  157, 1032, 1032,  493,  490,  157,  163,
			  157,  163,  157, 1032,  499,  157,  157,  494,  491,  157,
			 1032,  163, 1032,  497,  163,  495,  163,  157, 1032,  745,
			  496,  163,  157,  492,  492,  163,  163, 1032,  493,  493,
			  163,  163,  163,  163,  163,  503,  500,  163,  163,  494,
			  494,  163, 1032,  163, 1032,  498,  163,  496,  163,  163,
			  498,  503,  496,  163,  163,  163,  157,  500,  163, 1032,
			  157,  503, 1032, 1032,  163,  163,  163,  163,  163,  612,

			  163,  503, 1032,  501,  502, 1032,  163, 1032, 1032,  163,
			  163,  503,  498, 1032, 1032,  163, 1032,  163,  163,  500,
			 1032, 1032,  163, 1032, 1032, 1032,  163,  163,  163,  163,
			  163,  612,  163, 1032, 1032,  502,  502, 1032,  163, 1032,
			 1032,  163,  163, 1032,  505,  505,  505,  250,  251,  252,
			  253,  254,  255,  256,  849,  849,  849,  849, 1032, 1032,
			  506,  506, 1032,  250,  251,  252,  253,  254,  255,  256,
			  507,  507,  507,  250,  251,  252,  253,  254,  255,  256,
			  508,  508,  508,  250,  251,  252,  253,  254,  255,  256,
			  509,  518, 1032,  250,  251,  252,  253,  254,  255,  256,

			  271,  272,  273,  274,  275,  276,  277,  303,  271,  272,
			  273,  274,  275,  276,  277,  304,  304,  304,  271,  272,
			  273,  274,  275,  276,  277,  305,  305,  526,  271,  272,
			  273,  274,  275,  276,  277,  306,  306,  306,  271,  272,
			  273,  274,  275,  276,  277,  307,  307,  307,  271,  272,
			  273,  274,  275,  276,  277,  308, 1032, 1032,  271,  272,
			  273,  274,  275,  276,  277,  279, 1032,  283,  279,  271,
			  272,  273,  274,  275,  276,  277, 1032,  519,  520,  521,
			  522,  523,  524,  525,  280, 1032, 1032,  280, 1032,  287,
			 1032,  281,  270, 1032,  281, 1032,  295, 1032,  280,  270,

			  163,  280,  163,  287, 1032,  142,  270,  602,  602,  602,
			  602, 1032,  163,  527,  528,  529,  530,  531,  532,  533,
			  280,  284, 1032,  280, 1032,  287, 1032, 1032,  270, 1032,
			  280, 1032,  163,  280,  163,  287, 1032, 1032,  270, 1032,
			  280, 1032, 1032,  280,  163,  287, 1032,  149,  270, 1032,
			 1032, 1032,  285, 1032, 1032, 1032,  271,  272,  273,  274,
			  275,  276,  277,  280, 1032, 1032,  280, 1032,  287, 1032,
			 1032,  270, 1032, 1032, 1032,  288,  289,  290,  291,  292,
			  293,  294,  296,  297,  298,  299,  300,  301,  302,  288,
			  289,  290,  291,  292,  293,  294,  280, 1032, 1032,  280,

			 1032,  287, 1032, 1032,  270,  609,  609,  609,  609, 1032,
			  534,  288,  289,  290,  291,  292,  293,  294,  535,  535,
			  535,  288,  289,  290,  291,  292,  293,  294,  536,  536,
			 1032,  288,  289,  290,  291,  292,  293,  294,  280, 1032,
			 1032,  280,  748,  287,  748,  388,  270,  749,  749,  749,
			  749,  537,  537,  537,  288,  289,  290,  291,  292,  293,
			  294,  271,  272,  273,  274,  275,  276,  277,  281, 1032,
			 1032,  281, 1032,  295, 1032, 1032,  270,  271,  272,  273,
			  274,  275,  276,  277,  538,  538,  538,  288,  289,  290,
			  291,  292,  293,  294,  281, 1032, 1032,  281, 1032,  295,

			 1032, 1032,  270, 1032,  281, 1032,  613,  281, 1032,  295,
			  157, 1032,  270,  163,  281,  163, 1032,  281, 1032,  295,
			 1032, 1032,  270,  157, 1032,  163,  539, 1032, 1032,  288,
			  289,  290,  291,  292,  293,  294,  281, 1032,  614,  281,
			 1032,  295,  163, 1032,  270,  163,  281,  163, 1032,  281,
			 1032,  295, 1032, 1032,  270,  163, 1032,  163, 1032,  296,
			  297,  298,  299,  300,  301,  302,  281, 1032, 1032,  281,
			 1032,  295, 1032, 1032,  270,  271,  272,  273,  274,  275,
			  276,  277, 1032, 1032,  540,  296,  297,  298,  299,  300,
			  301,  302,  541,  541,  541,  296,  297,  298,  299,  300, yy_Dummy>>,
			1, 1000, 2000)
		end

	yy_nxt_template_4 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			  301,  302,  542,  542, 1032,  296,  297,  298,  299,  300,
			  301,  302,  271,  272,  273,  274,  275,  276,  277,  106,
			 1032, 1032,  548, 1032,  543,  543,  543,  296,  297,  298,
			  299,  300,  301,  302,  544,  544,  544,  296,  297,  298,
			  299,  300,  301,  302,  271,  272,  273,  274,  275,  276,
			  277, 1032,  106, 1032,  545,  107, 1032,  296,  297,  298,
			  299,  300,  301,  302,  546,  546,  546,  271,  272,  273,
			  274,  275,  276,  277,  547,  547,  547,  271,  272,  273,
			  274,  275,  276,  277,  549, 1032, 1032,  107, 1032, 1032,
			 1032,  106, 1032, 1032,  551,  610,  610,  610,  610,  106,

			  157, 1032,  548, 1032,  157,  314,  315,  316,  317,  318,
			  319,  320,  550,  550,  550,  550,  106,  157,  142,  548,
			  601,  601,  602,  602,  106, 1032, 1032,  548, 1032, 1032,
			 1032,  150,  163, 1032,  106,  388,  163,  548,  119,  120,
			  121,  122,  123,  124,  125,  106, 1032, 1032,  548,  163,
			  743,  743,  743,  743, 1032,  106, 1032, 1032,  548, 1032,
			  149, 1032, 1032,  150,  847,  106, 1032, 1032,  548, 1032,
			  119,  120,  121,  122,  123,  124,  125,  314,  315,  316,
			  317,  318,  319,  320, 1032,  314,  315,  316,  317,  318,
			  319,  320,  106, 1032, 1032,  548,  847,  850,  850,  850,

			  850, 1032,  314,  315,  316,  317,  318,  319,  320,  552,
			  314,  315,  316,  317,  318,  319,  320,  553,  553,  553,
			  314,  315,  316,  317,  318,  319,  320,  106,  554,  554,
			  107,  314,  315,  316,  317,  318,  319,  320,  555,  555,
			  555,  314,  315,  316,  317,  318,  319,  320,  556,  556,
			  556,  314,  315,  316,  317,  318,  319,  320,  321, 1032,
			  321,  321, 1032,  106, 1032, 1032,  107,  749,  749,  749,
			  749,  106, 1032, 1032,  107,  557,  108, 1032,  314,  315,
			  316,  317,  318,  319,  320,  322, 1032,  322,  322,  616,
			  106, 1032,  163,  107,  163,  596,  596,  596,  596,  163,

			 1032,  163, 1032, 1032,  163, 1032, 1032,  106,  109,  597,
			  107,  163,  108,  110,  111,  112,  113,  114,  115,  116,
			  106,  616, 1032,  107,  163, 1032,  163,  854,  854,  854,
			  854,  163, 1032,  163,  106,  598,  163,  107, 1032,  108,
			 1032,  597, 1032,  163,  109,  751,  751,  751,  751,  110,
			  111,  112,  113,  114,  115,  116,  108,  119,  120,  121,
			  122,  123,  124,  125,  106, 1032, 1032,  107, 1032,  108,
			 1032,  109,  106, 1032, 1032,  107,  110,  111,  112,  113,
			  114,  115,  116,  108,  106,  752, 1032,  107,  109, 1032,
			 1032, 1032,  518,  110,  111,  112,  113,  114,  115,  116,

			  106,  109, 1032,  107, 1032, 1032,  110,  111,  112,  113,
			  114,  115,  116,  108,  106,  109, 1032,  107, 1032, 1032,
			  110,  111,  112,  113,  114,  115,  116,  106, 1032, 1032,
			  107, 1032, 1032,  108, 1032, 1032, 1032,  106, 1032, 1032,
			  107,  856,  856,  856,  856,  109,  518,  558,  558,  558,
			  110,  111,  112,  113,  114,  115,  116, 1032,  119,  120,
			  121,  122,  123,  124,  125,  109, 1032,  559,  559,  559,
			  110,  111,  112,  113,  114,  115,  116, 1032,  519,  520,
			  521,  522,  523,  524,  525, 1032,  119,  120,  121,  122,
			  123,  124,  125, 1032,  927,  927,  927,  927, 1032, 1032,

			  119,  120,  121,  122,  123,  124,  125, 1032, 1032, 1032,
			  560,  560,  560,  119,  120,  121,  122,  123,  124,  125,
			  561,  561,  561,  119,  120,  121,  122,  123,  124,  125,
			 1032,  721,  519,  520,  521,  522,  523,  524,  525,  337,
			  338,  339,  340,  341,  342,  343, 1032, 1032,  337,  338,
			  339,  340,  341,  342,  343, 1032, 1032, 1032,  562,  337,
			  338,  339,  340,  341,  342,  343,  568,  848,  848,  848,
			  848, 1032,  563,  563,  563,  337,  338,  339,  340,  341,
			  342,  343,  569, 1032, 1032, 1032,  564,  564, 1032,  337,
			  338,  339,  340,  341,  342,  343,  571,  852,  852,  852,

			  852, 1032, 1032,  572, 1032, 1032, 1032,  745, 1032,  565,
			  565,  565,  337,  338,  339,  340,  341,  342,  343,  574,
			  855,  855,  855,  855, 1032,  566,  566,  566,  337,  338,
			  339,  340,  341,  342,  343,  567,  575,  853,  337,  338,
			  339,  340,  341,  342,  343, 1032, 1032, 1032,  337,  338,
			  339,  340,  341,  342,  343,  573,  573,  573,  573,  576,
			  752, 1032, 1032, 1032,  337,  338,  339,  340,  341,  342,
			  343,  577,  753, 1032,  602,  602,  602,  602,  337,  338,
			  339,  340,  341,  342,  343,  337,  338,  339,  340,  341,
			  342,  343,  578,  931,  931,  931,  931, 1032, 1032,  579,

			 1032,  337,  338,  339,  340,  341,  342,  343,  580,  926,
			  926,  926,  926, 1032,  388,  581, 1032, 1032,  337,  338,
			  339,  340,  341,  342,  343,  582, 1032, 1032,  337,  338,
			  339,  340,  341,  342,  343,  583,  932,  932,  932,  932,
			 1032,  337,  338,  339,  340,  341,  342,  343,  584,  745,
			 1032, 1032, 1032,  337,  338,  339,  340,  341,  342,  343,
			  585,  934,  934,  934,  934, 1032, 1032,  586, 1032, 1032,
			 1032,  526, 1032, 1032,  337,  338,  339,  340,  341,  342,
			  343,  337,  338,  339,  340,  341,  342,  343,  587, 1032,
			  337,  338,  339,  340,  341,  342,  343,  337,  338,  339,

			  340,  341,  342,  343,  588, 1032, 1032,  337,  338,  339,
			  340,  341,  342,  343,  589, 1032, 1032,  337,  338,  339,
			  340,  341,  342,  343, 1032,  930,  930,  930,  930, 1032,
			  337,  338,  339,  340,  341,  342,  343, 1032, 1032, 1032,
			 1032,  526,  337,  338,  339,  340,  341,  342,  343,  337,
			  338,  339,  340,  341,  342,  343, 1032,  527,  528,  529,
			  530,  531,  532,  533, 1032,  853, 1032, 1032, 1032, 1032,
			  337,  338,  339,  340,  341,  342,  343, 1032,  271,  272,
			  273,  274,  275,  276,  277, 1032,  337,  338,  339,  340,
			  341,  342,  343, 1032, 1032, 1032,  337,  338,  339,  340,

			  341,  342,  343,  126,  126,  126,  337,  338,  339,  340,
			  341,  342,  343, 1032, 1032, 1032,  126,  126,  126,  337,
			  338,  339,  340,  341,  342,  343,  727,  527,  528,  529,
			  530,  531,  532,  533, 1032,  126,  126,  126,  337,  338,
			  339,  340,  341,  342,  343,  126,  126,  126,  337,  338,
			  339,  340,  341,  342,  343, 1032,  590,  590,  590,  337,
			  338,  339,  340,  341,  342,  343, 1032,  933,  933,  933,
			  933, 1032,  591,  591,  591,  337,  338,  339,  340,  341,
			  342,  343,  385,  385,  385,  385, 1032,  157,  614, 1032,
			 1032,  157,  385,  385,  385,  385,  385,  385,  157,  163, yy_Dummy>>,
			1, 1000, 3000)
		end

	yy_nxt_template_5 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			  611,  163,  157, 1032,  157, 1032,  163,  752,  163, 1032,
			 1032,  163,  618, 1032, 1032,  157, 1032, 1032,  163,  163,
			  614, 1032,  607,  163,  385,  385,  385,  385,  385,  385,
			  163,  163,  612,  163,  163,  157,  163,  157,  163,  157,
			  163,  157,  157,  163,  618,  615,  157,  163, 1032,  157,
			  163,  621,  617,  157,  157, 1032, 1032, 1032,  157,  157,
			 1032,  622,  157, 1032, 1032, 1032,  157,  163, 1032,  163,
			  163,  163,  163,  163,  163,  157,  623,  616,  163, 1032,
			 1032,  163,  163,  622,  618,  163,  163, 1032,  157, 1032,
			  163,  163,  157,  622,  163, 1032, 1032, 1032,  163,  163,

			 1032,  163,  163, 1032,  163,  157,  624,  163,  624,  625,
			 1032,  163,  627,  163,  163,  163,  157,  628,  157, 1032,
			  163, 1032,  157,  626,  163,  163, 1032, 1032,  163,  157,
			  163,  163, 1032,  163, 1032,  629, 1032,  163,  624, 1032,
			  163,  626,  157,  163,  628,  163,  633,  163,  163,  628,
			  163, 1032, 1032, 1032,  163,  626, 1032,  163, 1032,  157,
			  163,  163,  163,  163,  157,  163, 1032,  630,  157,  630,
			  634,  163,  163,  163,  163,  163, 1032,  163,  634,  163,
			  632,  157,  157,  163,  631,  636,  635, 1032, 1032,  163,
			 1032,  163,  163, 1032,  163,  163,  163,  163, 1032,  157,

			  163,  630,  634,  163,  163,  163,  157,  163, 1032,  163,
			  157,  163,  632,  163,  163,  163,  632,  636,  636, 1032,
			 1032,  163, 1032,  157,  163,  163,  163,  163,  157,  157,
			  639,  163,  157,  643,  157, 1032,  163,  163,  163, 1032,
			 1032,  163,  163,  163,  640,  157,  157,  157,  637, 1032,
			  638, 1032, 1032,  163,  157,  163, 1032,  163,  157,  163,
			  163,  163,  641, 1032,  163,  644,  163, 1032, 1032,  163,
			  641,  157,  645,  163, 1032,  163,  642,  163,  163,  163,
			  638,  163,  638,  163,  642,  163,  163,  644, 1032,  163,
			  163,  163, 1032,  163,  163,  157,  163,  648,  163,  157,

			  163,  163,  641,  163,  646,  646,  163, 1032, 1032, 1032,
			  163, 1032,  157,  163,  647,  163,  642, 1032, 1032,  644,
			 1032,  163,  654,  163,  163,  163,  163,  163,  163,  648,
			  163,  163,  163,  163,  163,  157, 1032,  646,  163,  157,
			 1032,  157,  163, 1032,  163,  655,  648,  649, 1032,  163,
			  651,  163,  157,  157,  654,  157,  163,  157,  157,  659,
			  650,  163, 1032,  652,  653, 1032,  163,  163, 1032, 1032,
			  157,  163,  157,  163, 1032, 1032, 1032,  656, 1032,  651,
			 1032,  163,  651,  163,  163,  163, 1032,  163, 1032,  163,
			  163,  660,  652,  163,  157,  652,  654,  157,  157,  663,

			 1032,  157,  163,  157,  163,  657,  656,  658, 1032,  661,
			  163,  157,  163,  163,  157,  163,  157,  926,  926,  926,
			  926, 1032,  163, 1032, 1032,  163,  163, 1032, 1032,  163,
			  163,  664, 1032,  163, 1032,  163, 1032,  658,  656,  658,
			 1032,  662,  163,  163,  163,  163,  163,  163,  163,  660,
			 1032,  163, 1032,  163,  163,  662,  163,  163,  163,  664,
			  157,  667, 1032,  163,  665,  157, 1032,  666,  163, 1032,
			  163, 1032,  163, 1032,  163, 1032,  163,  157,  157, 1032,
			 1032,  660,  163,  163, 1032,  163,  163,  662,  163, 1032,
			  163,  664,  163,  668, 1032,  163,  666,  163, 1032,  666,

			  163, 1032,  163, 1032,  163, 1032,  163,  157,  163,  163,
			  163,  157,  668, 1032,  163,  163,  157,  163,  163,  670,
			  671,  672,  669,  163,  157,  163, 1032,  163,  163, 1032,
			  163, 1032, 1032,  157, 1032,  163, 1032, 1032, 1032,  163,
			  163, 1032, 1032,  163,  668, 1032, 1032,  163,  163,  163,
			 1032,  670,  672,  672,  670,  163,  163,  163, 1032,  163,
			  163, 1032,  163, 1032,  157,  163, 1032,  163,  157, 1032,
			 1032,  163,  163,  163,  674,  157,  157, 1032,  673,  157,
			  675,  157,  163,  163,  163,  157, 1032,  157, 1032,  681,
			  676,  683,  157,  157,  163, 1032,  163,  163, 1032,  163,

			  163, 1032,  157,  163,  157,  163,  674,  163,  163,  163,
			  674,  163,  676,  163,  163,  163,  163,  163, 1032,  163,
			 1032,  682,  676,  684,  163,  163,  163, 1032,  157,  163,
			  677,  163,  157,  678,  163,  679,  163, 1032,  680, 1032,
			 1032,  163, 1032, 1032,  163,  157,  163, 1032, 1032,  685,
			 1032,  157, 1032,  157, 1032,  157,  163,  157, 1032, 1032,
			  163,  157,  679, 1032,  163,  680,  157,  679,  157, 1032,
			  680,  687, 1032, 1032,  693, 1032,  163,  163,  163, 1032,
			 1032,  686,  157,  163,  689,  163,  157,  163,  163,  163,
			 1032, 1032,  157,  163,  686, 1032,  695, 1032,  163,  157,

			  163,  682,  690,  688,  684,  163,  694,  163,  163,  157,
			  163,  163, 1032,  163,  163, 1032,  691,  163,  163, 1032,
			  163, 1032, 1032,  163,  163, 1032,  686, 1032,  696, 1032,
			 1032,  163, 1032,  682,  692, 1032,  684,  163, 1032,  163,
			  163,  163,  163,  163,  163,  163,  163, 1032,  691,  163,
			  697, 1032,  163,  688,  157,  163,  163,  163,  163,  163,
			  163, 1032, 1032, 1032,  694,  696,  692,  157, 1032,  163,
			  163, 1032,  163, 1032,  163, 1032,  163, 1032,  163, 1032,
			  691, 1032,  698, 1032,  163,  688,  163, 1032,  163,  163,
			  163,  163,  163, 1032,  698, 1032,  694,  696,  692,  163,

			 1032,  163,  163, 1032,  163,  163,  163,  163,  700, 1032,
			  157,  163, 1032,  163,  157,  157,  163,  163,  699,  157,
			 1032,  157,  163,  163,  702,  703,  698,  157,  701, 1032,
			 1032, 1032,  157, 1032,  163, 1032, 1032,  163,  157,  163,
			  700, 1032,  163,  163,  157,  163,  163,  163,  705,  163,
			  700,  163, 1032,  163,  163,  163,  702,  704,  704,  163,
			  702,  157, 1032, 1032,  163,  163,  163,  163,  157, 1032,
			  163,  157,  157, 1032, 1032,  157,  163,  163, 1032,  709,
			  706, 1032,  706, 1032,  707,  157, 1032, 1032,  157,  163,
			  704,  163, 1032,  163, 1032, 1032, 1032,  163, 1032,  163,

			  163,  163, 1032,  163,  163, 1032, 1032,  163, 1032,  163,
			  163,  710,  163, 1032,  706,  708,  708,  163, 1032, 1032,
			  163,  163,  163,  163,  710, 1032,  157,  163,  157,  163,
			  157,  713,  157,  163,  711,  712, 1032, 1032,  163,  163,
			  163, 1032,  163,  157,  163,  157, 1032,  708, 1032, 1032,
			  163, 1032, 1032,  163,  163,  716,  710,  503,  163,  163,
			  163,  163,  163,  714,  163,  163,  712,  712,  714,  157,
			  163,  163,  163,  157,  503,  163,  163,  163,  163,  157,
			 1032,  503,  163,  157, 1032,  163,  157,  716,  163,  503,
			 1032,  163,  715,  163, 1032, 1032,  157,  163, 1032,  503, yy_Dummy>>,
			1, 1000, 4000)
		end

	yy_nxt_template_6 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			  714,  163, 1032,  163, 1032,  163, 1032, 1032,  163,  503,
			  163,  163, 1032, 1032, 1032,  163,  518, 1032,  163, 1032,
			  163, 1032, 1032,  163,  716,  163,  518, 1032,  163,  926,
			  926,  926,  926, 1032, 1032,  163,  518, 1032, 1032,  250,
			  251,  252,  253,  254,  255,  256,  518,  271,  272,  273,
			  274,  275,  276,  277,  518, 1032,  250,  251,  252,  253,
			  254,  255,  256,  250,  251,  252,  253,  254,  255,  256,
			  518,  250,  251,  252,  253,  254,  255,  256,  717,  717,
			  717,  250,  251,  252,  253,  254,  255,  256,  718,  718,
			  718,  250,  251,  252,  253,  254,  255,  256,  526,  722,

			  722,  722,  519,  520,  521,  522,  523,  524,  525,  723,
			  723,  526,  519,  520,  521,  522,  523,  524,  525,  724,
			  724,  724,  519,  520,  521,  522,  523,  524,  525,  725,
			  725,  725,  519,  520,  521,  522,  523,  524,  525,  526,
			  519,  520,  521,  522,  523,  524,  525, 1032, 1032,  526,
			 1032, 1032, 1032,  726, 1032, 1032,  519,  520,  521,  522,
			  523,  524,  525,  526, 1032,  280, 1032, 1032,  280, 1032,
			  287, 1032,  280,  270, 1032,  280, 1032,  287, 1032, 1032,
			  270,  728,  728,  728,  527,  528,  529,  530,  531,  532,
			  533, 1032, 1032, 1032,  729,  729, 1032,  527,  528,  529,

			  530,  531,  532,  533,  280, 1032, 1032,  280, 1032,  287,
			 1032,  280,  270, 1032,  280, 1032,  287, 1032, 1032,  270,
			 1032, 1032,  730,  730,  730,  527,  528,  529,  530,  531,
			  532,  533,  731,  731,  731,  527,  528,  529,  530,  531,
			  532,  533,  981,  981,  981,  981,  732, 1032, 1032,  527,
			  528,  529,  530,  531,  532,  533,  288,  289,  290,  291,
			  292,  293,  294,  288,  289,  290,  291,  292,  293,  294,
			  280, 1032, 1032,  280, 1032,  287, 1032, 1032,  270, 1032,
			  280, 1032, 1032,  280, 1032,  287, 1032, 1032,  270,  754,
			  754,  754,  754, 1032, 1032,  288,  289,  290,  291,  292,

			  293,  294,  288,  289,  290,  291,  292,  293,  294,  281,
			 1032, 1032,  281, 1032,  295, 1032,  281,  270, 1032,  281,
			 1032,  295, 1032,  281,  270, 1032,  281, 1032,  295,  388,
			  281,  270, 1032,  281, 1032,  295, 1032, 1032,  270, 1032,
			  281, 1032, 1032,  281, 1032,  295, 1032, 1032,  270, 1032,
			 1032, 1032,  549, 1032, 1032,  548, 1032, 1032,  733,  733,
			  733,  288,  289,  290,  291,  292,  293,  294,  734,  734,
			  734,  288,  289,  290,  291,  292,  293,  294,  281, 1032,
			 1032,  281, 1032,  295, 1032, 1032,  270, 1032, 1032,  925,
			  106,  925, 1032,  548,  926,  926,  926,  926, 1032, 1032,

			  296,  297,  298,  299,  300,  301,  302,  296,  297,  298,
			  299,  300,  301,  302,  296,  297,  298,  299,  300,  301,
			  302,  296,  297,  298,  299,  300,  301,  302,  735,  735,
			  735,  296,  297,  298,  299,  300,  301,  302,  314,  315,
			  316,  317,  318,  319,  320,  106, 1032, 1032,  548, 1032,
			 1032, 1032,  106, 1032, 1032,  548, 1032,  118,  737,  737,
			  737,  737,  549, 1032, 1032,  548,  736,  736,  736,  296,
			  297,  298,  299,  300,  301,  302,  314,  315,  316,  317,
			  318,  319,  320,  106, 1032, 1032,  548, 1032,  118, 1032,
			  106, 1032, 1032,  548, 1032, 1032,  935,  106,  935, 1032,

			  548,  933,  933,  933,  933, 1032, 1032,  106, 1032, 1032,
			  548, 1032, 1032,  851,  851,  851,  851,  106, 1032, 1032,
			  548, 1032, 1032,  610,  610,  610,  610,  857, 1032, 1032,
			 1032,  314,  315,  316,  317,  318,  319,  320,  314,  315,
			  316,  317,  318,  319,  320, 1032, 1032, 1032,  314,  315,
			  316,  317,  318,  319,  320,  986,  986,  986,  986,  857,
			  982,  106,  982,  388,  107,  983,  983,  983,  983,  314,
			  315,  316,  317,  318,  319,  320,  314,  315,  316,  317,
			  318,  319,  320,  314,  315,  316,  317,  318,  319,  320,
			  738,  738,  738,  314,  315,  316,  317,  318,  319,  320,

			  739,  739,  739,  314,  315,  316,  317,  318,  319,  320,
			  108,  106, 1032, 1032,  107, 1032, 1032, 1032,  106, 1032,
			 1032,  107, 1032, 1032, 1032,  106, 1032, 1032,  107,  337,
			  338,  339,  340,  341,  342,  343, 1032, 1032, 1032, 1032,
			  157,  157,  109, 1032,  157,  767, 1032,  110,  111,  112,
			  113,  114,  115,  116, 1032, 1032, 1032,  157,  157,  755,
			  108,  984, 1032,  984, 1032, 1032,  985,  985,  985,  985,
			 1032, 1032,  163,  163, 1032, 1032,  163,  768,  933,  933,
			  933,  933,  988,  988,  988,  988, 1032, 1032, 1032,  163,
			  163,  756,  109,  985,  985,  985,  985,  110,  111,  112,

			  113,  114,  115,  116,  119,  120,  121,  122,  123,  124,
			  125,  119,  120,  121,  122,  123,  124,  125,  337,  338,
			  339,  340,  341,  342,  343,  337,  338,  339,  340,  341,
			  342,  343, 1032,  853, 1032, 1032,  337,  338,  339,  340,
			  341,  342,  343,  740,  740,  740,  337,  338,  339,  340,
			  341,  342,  343,  741,  741,  741,  337,  338,  339,  340,
			  341,  342,  343, 1032,  743,  743,  743,  743, 1032, 1032,
			 1032,  742,  573,  573,  573,  573, 1032, 1032,  373, 1032,
			 1032,  747,  747,  747,  747, 1032,  753, 1032,  601,  601,
			  602,  602, 1032, 1032, 1032,  597, 1032, 1032, 1032,  150,

			  933,  933,  933,  933,  374,  983,  983,  983,  983, 1032,
			  373,  126,  126,  126,  337,  338,  339,  340,  341,  342,
			  343,  598,  985,  985,  985,  985, 1032,  597,  388, 1032,
			 1032,  150,  985,  985,  985,  985,  157, 1032, 1032, 1032,
			  157, 1019, 1019, 1019, 1019,  337,  338,  339,  340,  341,
			  342,  343, 1032,  157,  757,  126,  126,  126,  337,  338,
			  339,  340,  341,  342,  343,  163, 1032,  163,  163,  163,
			 1032,  163,  163,  756,  157, 1032,  758,  163,  157, 1032,
			  759,  163, 1032,  760, 1032,  163,  758, 1032,  163, 1032,
			  163,  157, 1032, 1032,  157, 1032, 1032,  163,  157,  163,

			  163,  163,  761,  163, 1032,  756,  163, 1032,  758,  163,
			  163,  157,  760,  163,  762,  760,  163,  163,  163,  163,
			  163,  157,  163,  163,  770,  157,  163, 1032,  163,  163,
			  163,  763,  163, 1032,  762, 1032, 1032,  157,  157,  764,
			  163,  157,  163,  163, 1032, 1032,  762, 1032,  163,  163,
			  163,  163,  163,  163,  157,  765,  770,  163,  768, 1032,
			  163,  163,  157,  764, 1032,  163,  157,  163, 1032,  163,
			  163,  764,  163,  163,  163, 1032,  163,  163,  163,  157,
			 1032,  769, 1032,  766,  163,  157,  163,  766,  163,  771,
			  768, 1032, 1032, 1032,  163, 1032, 1032,  163,  163,  163, yy_Dummy>>,
			1, 1000, 5000)
		end

	yy_nxt_template_7 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			 1032, 1032,  157, 1032, 1032,  772, 1032, 1032,  163,  163,
			  163,  163,  163,  770,  163,  766, 1032,  163, 1032,  157,
			  163,  772,  774,  157,  163,  773,  157,  163, 1032,  163,
			  157,  157, 1032, 1032,  163,  157,  157,  772, 1032,  163,
			 1032, 1032, 1032,  775,  163, 1032,  163, 1032,  779, 1032,
			 1032,  163, 1032, 1032,  774,  163,  163,  774,  163,  163,
			 1032,  163,  163,  163,  163,  157,  163,  163,  163,  157,
			  776,  163, 1032,  777,  778,  776,  163,  163, 1032,  163,
			  780,  163,  157,  163, 1032, 1032,  157,  780, 1032,  163,
			  157, 1032, 1032,  163, 1032, 1032,  163,  163,  163,  781,

			  157,  163,  776,  157,  157,  778,  778, 1032,  163,  163,
			 1032,  163, 1032,  163,  163,  163, 1032,  783,  163,  780,
			  157,  163,  163, 1032,  157,  163,  163,  163,  782,  163,
			 1032,  782,  163,  784, 1032,  163,  163,  785,  163,  163,
			  157,  163, 1032,  163,  787, 1032,  157,  786, 1032,  784,
			  157, 1032,  163,  163, 1032,  788,  163,  157,  163,  163,
			  782,  163,  163,  157,  163,  784,  789, 1032, 1032,  786,
			  163,  163,  163,  163,  163,  163,  788, 1032,  163,  786,
			  157,  163,  163,  163,  157,  163, 1032,  788,  157,  163,
			  790, 1032,  791,  163,  163,  163,  163,  157,  790,  163,

			  792,  163, 1032, 1032, 1032,  157,  163,  163, 1032,  163,
			  157,  163,  163,  163,  157,  163,  163,  157,  793,  163,
			  163,  157,  790,  794,  792,  163,  163,  157,  163,  163,
			 1032,  163,  792,  163,  157, 1032, 1032,  163,  163,  163,
			  795,  163,  163,  163,  157,  163,  163,  163,  157,  163,
			  794,  163,  163,  163,  163,  794, 1032,  796,  163,  163,
			  163,  157, 1032, 1032,  798,  157,  163,  797, 1032,  157,
			  163, 1032,  796, 1032,  157, 1032,  163,  163,  801,  163,
			  163, 1032,  799, 1032,  163, 1032,  163, 1032,  163,  796,
			  163,  157, 1032,  163,  800, 1032,  798,  163,  802,  798,

			  163,  163, 1032, 1032,  157,  163,  163,  163,  157, 1032,
			  802, 1032,  157,  163,  800,  163,  157,  163, 1032,  804,
			  163,  803,  163,  163,  157,  163,  800, 1032,  157,  157,
			  802,  163,  163,  163, 1032,  805,  163,  163,  157,  163,
			  163,  157,  157,  163,  163,  163, 1032,  163,  163,  163,
			  806,  804,  163,  804,  157,  157,  163,  163,  157, 1032,
			  163,  163,  163,  163,  163,  163,  163,  806,  157, 1032,
			  163,  157,  157,  163,  163,  163,  163,  163, 1032,  163,
			 1032,  808,  806,  163,  163,  157,  163,  163,  157,  163,
			  163, 1032,  157,  163,  163,  163,  163,  163,  163,  807,

			  163, 1032,  157,  163,  163,  157,  157,  163,  163,  163,
			 1032,  163, 1032,  808,  163,  163,  163,  163, 1032,  157,
			  163,  163,  809,  810,  163,  163,  163,  163,  157,  163,
			 1032,  808,  157, 1032,  163,  814,  811,  163,  163,  163,
			 1032,  163, 1032,  163,  812,  157,  163,  163,  163,  163,
			 1032,  163,  157,  163,  810,  810,  157,  813,  163,  163,
			  163,  157, 1032, 1032,  163,  157, 1032,  814,  812,  157,
			 1032, 1032, 1032,  163, 1032,  163,  812,  163,  815,  163,
			  163,  163,  163,  157,  163,  163,  816,  157,  163,  814,
			  157,  163,  163,  163,  157,  817, 1032,  163,  819, 1032,

			  157,  163, 1032, 1032,  163,  818,  163,  157,  820, 1032,
			  816,  163,  163,  163,  163,  163,  163, 1032,  816,  163,
			 1032, 1032,  163,  163,  163, 1032,  163,  818, 1032,  157,
			  820, 1032,  163,  157, 1032, 1032,  163,  818,  163,  163,
			  820, 1032,  824,  163,  163,  163,  157,  157,  163,  821,
			  163,  157,  163,  157,  163,  163, 1032,  157,  823,  822,
			 1032,  163,  163, 1032,  157,  163,  851,  851,  851,  851,
			  157, 1032, 1032, 1032,  824, 1032,  163,  825,  163,  163,
			  929,  822,  163,  163,  163,  163,  163, 1032, 1032,  163,
			  824,  822, 1032,  163,  163,  163,  163,  157, 1032,  827,

			  157,  157,  163, 1032,  157,  163,  826,  828, 1032,  826,
			 1032, 1032,  929, 1032,  157, 1032,  163,  829,  163, 1032,
			 1032, 1032,  163, 1032,  163,  163,  832,  163,  163,  163,
			 1032,  828,  163,  163,  163, 1032,  163,  163,  826,  828,
			  157,  163, 1032,  163,  157, 1032,  163,  830,  163,  830,
			  163, 1032, 1032,  163,  163,  831,  163,  157,  832, 1032,
			  163,  157,  163,  157,  163,  157,  163,  157, 1032,  163,
			 1032,  163,  163,  163,  163,  163,  163, 1032,  157,  830,
			  157,  163, 1032, 1032,  834,  163, 1032,  832, 1032,  163,
			  163, 1032,  163,  163,  163,  163,  163,  163, 1032,  163,

			  157,  163,  163,  163,  157,  833,  163,  838, 1032,  163,
			  163,  157,  163,  163, 1032,  157,  834,  157,  163,  163,
			  163,  839,  163, 1032,  163,  157, 1032,  836,  157,  157,
			  163,  835,  163,  157,  163,  503,  163,  834,  157,  838,
			  837,  163,  163,  163,  163,  840,  157,  163,  503,  163,
			  163,  163,  163,  840,  163,  518,  163,  163,  163,  836,
			  163,  163,  163,  836,  518,  163, 1032,  157,  163, 1032,
			  163,  157,  838,  518,  163,  157,  163,  840,  163,  157,
			 1032,  163, 1032,  163,  157,  518,  163, 1032,  163, 1032,
			  163, 1032,  157,  163, 1032,  518, 1032, 1032, 1032,  163,

			  163, 1032,  526,  163, 1032, 1032, 1032,  163, 1032,  526,
			 1032,  163, 1032,  163, 1032,  163,  163,  250,  251,  252,
			  253,  254,  255,  256,  163,  163,  526, 1032, 1032, 1032,
			  250,  251,  252,  253,  254,  255,  256,  526, 1032, 1032,
			 1032,  519,  520,  521,  522,  523,  524,  525,  526, 1032,
			  519,  520,  521,  522,  523,  524,  525, 1032,  526,  519,
			  520,  521,  522,  523,  524,  525, 1032, 1032,  841,  841,
			  841,  519,  520,  521,  522,  523,  524,  525,  842,  842,
			  842,  519,  520,  521,  522,  523,  524,  525,  527,  528,
			  529,  530,  531,  532,  533,  527,  528,  529,  530,  531,

			  532,  533,  280, 1032, 1032,  280, 1032,  287, 1032, 1032,
			  270, 1032,  527,  528,  529,  530,  531,  532,  533,  106,
			 1032, 1032,  548,  527,  528,  529,  530,  531,  532,  533,
			 1032,  843,  843,  843,  527,  528,  529,  530,  531,  532,
			  533,  844,  844,  844,  527,  528,  529,  530,  531,  532,
			  533,  280, 1032, 1032,  280, 1032,  287, 1032,  281,  270,
			 1032,  281, 1032,  295, 1032,  281,  270, 1032,  281, 1032,
			  295, 1032, 1032,  270, 1032, 1032, 1032,  106, 1032,  858,
			  548,  610,  610,  610,  610, 1032, 1032, 1032,  106, 1032,
			 1032,  548, 1032,  288,  289,  290,  291,  292,  293,  294, yy_Dummy>>,
			1, 1000, 6000)
		end

	yy_nxt_template_8 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			  118,  845,  845,  845,  845,  314,  315,  316,  317,  318,
			  319,  320,  337,  338,  339,  340,  341,  342,  343,  846,
			  990,  149,  990, 1032, 1032,  991,  991,  991,  991,  991,
			  991,  991,  991, 1032,  337,  338,  339,  340,  341,  342,
			  343, 1032,  288,  289,  290,  291,  292,  293,  294,  296,
			  297,  298,  299,  300,  301,  302,  296,  297,  298,  299,
			  300,  301,  302,  314,  315,  316,  317,  318,  319,  320,
			  851,  851,  851,  851,  314,  315,  316,  317,  318,  319,
			  320,  157, 1032, 1032,  597,  157, 1032,  163,  163,  163,
			  163,  157, 1032, 1032, 1032,  157, 1032, 1032,  157,  163,

			  163,  337,  338,  339,  340,  341,  342,  343,  157, 1032,
			  598,  157, 1032,  163, 1032,  157,  597,  163, 1032,  163,
			  163,  163,  163,  163,  859,  157,  861,  163,  157,  157,
			  163,  163,  163,  163,  163,  860,  163, 1032, 1032, 1032,
			  163,  862,  157,  163, 1032,  163,  163,  163, 1032, 1032,
			  163,  163,  163,  163, 1032,  157,  860,  163,  862,  157,
			  163,  163,  163,  163, 1032,  163,  163,  860,  163, 1032,
			 1032,  157,  157,  862,  163,  157,  157,  163,  163, 1032,
			  157, 1032,  163,  163,  163,  163, 1032,  163,  157, 1032,
			  163,  163,  163,  863,  163,  163,  864,  157, 1032, 1032,

			 1032,  865,  163,  163,  163,  866, 1032,  163,  163,  163,
			 1032,  870,  163, 1032,  157, 1021, 1021, 1021, 1021, 1032,
			  163,  163,  163,  867,  163,  864, 1032,  868,  864,  163,
			  163,  157,  163,  867,  163,  157, 1032,  868,  163, 1032,
			  163,  163,  163,  870,  869,  163,  163,  163,  157, 1032,
			  163,  872,  157,  163,  157,  867,  157,  163,  157,  868,
			 1032,  157,  163,  163,  163,  157,  873,  163, 1032,  157,
			  163,  871,  163, 1032,  163, 1032,  870,  163,  157,  163,
			  163, 1032,  163,  872,  163, 1032,  163,  157,  163,  163,
			  163,  875,  157,  163,  874,  877,  157,  163,  874,  876,

			  163,  163,  163,  872,  157,  878,  163, 1032,  163,  157,
			  163, 1032,  163,  163, 1032,  163,  157, 1032,  163,  163,
			  157, 1032, 1032,  876,  163,  163,  874,  878,  163, 1032,
			 1032,  876,  163,  157,  163,  879,  163,  878,  163, 1032,
			  163,  163, 1032, 1032,  163,  163, 1032,  163,  163, 1032,
			  163,  163,  163,  163,  157, 1032,  157,  163,  157,  880,
			  157, 1032,  163,  163,  882,  163,  163,  880,  163,  881,
			 1032,  157,  157,  157,  163,  163,  157,  163,  163, 1032,
			  157,  884, 1032,  163,  157,  163,  163,  163,  163,  883,
			  163,  880,  163,  885,  163,  163,  882,  157,  163, 1032,

			  163,  882, 1032,  163,  163,  163,  163,  163,  163,  163,
			  163, 1032,  163,  884,  157,  163,  163,  886,  887,  163,
			  157,  884,  157,  888,  157,  886,  157,  163,  889,  163,
			  163,  157,  163,  890, 1032, 1032,  163,  157,  163,  157,
			 1032,  163,  163,  163, 1032, 1032,  163,  163,  163,  886,
			  888, 1032,  163,  163,  163,  888,  163, 1032,  163,  163,
			  890, 1032,  163,  163,  163,  890, 1032, 1032,  163,  163,
			  163,  163, 1032,  163,  163,  163,  892, 1032,  157,  163,
			  163,  163,  157, 1032, 1032,  163,  891, 1032,  157,  157,
			  893,  163,  157,  157, 1032,  157, 1032,  895,  894, 1032,

			  157, 1032, 1032, 1032,  157,  157,  157,  163,  892,  163,
			  163,  163, 1032,  163,  163, 1032, 1032,  157,  892,  163,
			  163,  163,  894,  163,  163,  163, 1032,  163,  896,  896,
			  894,  163,  163,  163, 1032, 1032,  163,  163,  163,  163,
			  163,  163,  163,  163,  157, 1032, 1032,  898,  897,  163,
			 1032,  163,  163,  157,  163, 1032,  163,  157, 1032, 1032,
			  896,  157, 1032,  163,  157,  163,  163, 1032,  157, 1032,
			  899,  163,  163,  163,  163,  163,  163,  900, 1032,  898,
			  898,  157, 1032,  163,  163,  163,  163,  901,  163,  163,
			 1032,  157,  163,  163,  163,  157,  163,  157,  163,  903,

			  163,  905,  900,  163,  902,  163, 1032,  904,  157,  900,
			  163,  906,  163,  163,  157,  163, 1032,  157,  163,  902,
			  163,  907,  163,  163,  163, 1032,  163,  163,  908,  163,
			  163,  904, 1032,  906,  157,  163,  902,  163, 1032,  904,
			  163,  157,  163,  906,  163,  157,  163,  163, 1032,  163,
			  163,  157,  163,  908,  163,  911, 1032, 1032,  909,  163,
			  908,  163,  163,  912, 1032,  910,  163,  163,  157,  163,
			  163,  163,  163,  163, 1032, 1032, 1032,  163, 1032,  163,
			 1032, 1032,  163,  163,  163, 1032,  163,  912,  157, 1032,
			  910,  163,  157,  163, 1032,  912,  163,  910, 1032, 1032,

			  163, 1032,  163,  163,  163,  157,  157,  913,  157,  163,
			  157,  163,  157, 1032,  163,  917,  163,  914,  163,  157,
			  163,  163, 1032,  157,  163,  157, 1032,  915,  163, 1032,
			 1032, 1032,  157,  163, 1032,  163, 1032,  163,  163,  914,
			  163,  163,  163,  163,  163,  163,  163,  918,  163,  914,
			  918,  163,  157,  163,  916,  163,  157,  163,  163,  916,
			 1032,  163,  157,  163,  163,  163,  157,  163,  157,  157,
			  919, 1032,  921,  163, 1032, 1032, 1032,  163,  163,  157,
			  163,  518,  918, 1032,  163,  157,  916,  163,  163,  163,
			  163, 1032,  157,  163,  163,  163,  157,  518,  163,  163,

			  163,  163,  920,  920,  922,  163,  163,  922,  163,  157,
			  163,  163,  924,  526,  163, 1032,  163,  163,  163,  163,
			  526,  163,  163, 1032,  163, 1032,  163, 1032,  163, 1032,
			  157,  163, 1032,  106,  157,  920,  548, 1032,  163,  922,
			  163,  163,  163,  923,  924,  118,  163,  157,  163, 1032,
			  163, 1032, 1032, 1032,  163, 1032, 1032, 1032,  163, 1032,
			 1032, 1032,  163, 1032, 1032, 1032,  163,  519,  520,  521,
			  522,  523,  524,  525, 1032,  924, 1032, 1032, 1032,  163,
			 1032, 1032, 1032,  519,  520,  521,  522,  523,  524,  525,
			 1032, 1032, 1032, 1018, 1018, 1018, 1018, 1032, 1032,  527,

			  528,  529,  530,  531,  532,  533,  527,  528,  529,  530,
			  531,  532,  533,  937,  937,  937,  937, 1032, 1032,  314,
			  315,  316,  317,  318,  319,  320,  157,  938,  157,  163,
			  157,  163,  157,  745,  157,  163, 1032,  163,  157, 1032,
			 1032,  163, 1032,  157,  940,  157, 1032,  163,  939, 1032,
			 1032,  157, 1032,  941, 1032, 1032, 1032, 1032,  163,  938,
			  163,  163,  163,  163,  163, 1032,  163,  163, 1032,  163,
			  163, 1032, 1032,  163,  157,  163,  940,  163,  157,  163,
			  940, 1032,  163,  163,  163,  942, 1032,  163,  157,  163,
			  942,  157,  157, 1032,  163,  163,  157,  163,  944,  163, yy_Dummy>>,
			1, 1000, 7000)
		end

	yy_nxt_template_9 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			  157, 1032,  943, 1032, 1032,  157,  163,  163, 1032, 1032,
			  163, 1032, 1032,  157,  163,  945,  163, 1032, 1032,  163,
			  163,  163,  942,  163,  163, 1032,  163,  163,  163,  163,
			  944,  163,  163, 1032,  944, 1032,  163,  163,  163,  163,
			 1032, 1032,  157,  948,  946,  163,  947,  946,  163,  157,
			  163, 1032,  163,  157,  157,  163, 1032,  163,  157,  157,
			  157,  163,  163,  163,  949, 1032,  157,  163,  163, 1032,
			  163,  157, 1032,  163,  163,  948,  946,  157,  948, 1032,
			  163,  163,  163, 1032,  163,  163,  163,  163, 1032,  163,
			  163,  163,  163,  163,  163,  163,  950,  950,  163,  163,

			  163, 1032,  163,  163,  163,  163,  163,  157,  952,  163,
			  951,  157,  163,  157,  157, 1032,  163,  953, 1032,  163,
			 1032,  163, 1032, 1032,  157, 1032, 1032,  157,  954,  950,
			  157,  163,  163, 1032,  163,  163,  163,  163,  163,  163,
			  952, 1032,  952,  163,  163,  163,  163,  163,  163,  954,
			 1032,  163, 1032,  163,  157, 1032,  163,  157,  157,  163,
			  954,  157,  163,  163,  163, 1032,  163,  163, 1032,  163,
			  163,  157,  163, 1032,  157,  955,  163,  956, 1032,  163,
			 1032, 1032,  163,  163,  157,  958,  163, 1032,  157,  163,
			  163, 1032, 1032,  163, 1032,  163,  163,  957,  163, 1032,

			 1032,  157,  163,  163,  163, 1032,  163,  956,  163,  956,
			 1032,  163, 1032,  163,  163,  163,  163,  958,  157,  960,
			  163,  157,  157,  163,  163,  157,  163,  163, 1032,  958,
			  963, 1032,  962,  163,  157,  157,  163,  959,  157, 1032,
			  961, 1032, 1032,  163, 1032,  163, 1032,  157,  964, 1032,
			  163,  960, 1032,  163,  163,  163,  163,  163,  163,  163,
			 1032,  163,  964, 1032,  962, 1032,  163,  163,  163,  960,
			  163,  163,  962,  157,  163, 1032,  163,  157, 1032,  163,
			  964,  157,  966,  157, 1032,  157,  163,  157, 1032, 1032,
			  157,  163,  965,  163, 1032,  163, 1032,  163,  157,  967,

			  157, 1032,  968,  163, 1032,  163,  163,  163,  163,  163,
			 1032, 1032, 1032,  163,  966,  163, 1032,  163,  163,  163,
			 1032,  163,  163,  163,  966, 1032,  163,  163,  970,  163,
			  163,  968,  163,  163,  968, 1032, 1032,  157,  163,  163,
			  163,  157,  972, 1032,  157,  157, 1032,  157,  157,  157,
			  969,  973,  163,  163,  157,  163, 1032,  971,  163, 1032,
			  970,  157,  157, 1032,  157,  163,  163, 1032,  163,  163,
			  163, 1032,  163,  163,  972, 1032,  163,  163,  163,  163,
			  163,  163,  970,  974,  163, 1032,  163,  157,  974,  972,
			  163,  157,  163,  163,  163,  163,  163,  163,  163,  157,

			  163, 1032,  163,  157,  157, 1032,  163,  163,  163,  157,
			  163,  157, 1032,  157, 1032,  157,  157, 1032,  163,  163,
			  974, 1032,  163,  163,  163, 1032,  157,  163,  157,  163,
			  163,  163,  163, 1032,  163,  163,  163, 1032,  163,  163,
			  163,  163,  163,  163,  163,  163,  163,  163,  163,  157,
			  163, 1032,  976,  157, 1032,  163,  163,  978,  163,  163,
			  163,  163,  163, 1032,  163, 1032,  157,  163,  975,  157,
			 1032,  163, 1032,  157,  163,  157,  163, 1032,  163,  157,
			 1032,  163,  977, 1032,  976,  163,  157,  163,  163,  978,
			 1032,  163,  157,  163,  979, 1032, 1032, 1032,  163,  163,

			  976,  163, 1032,  163,  163,  163,  163,  163, 1032, 1032,
			 1032,  163,  980,  157,  978, 1032,  163,  157,  163,  989,
			  989,  989,  989,  163,  163,  163,  980, 1032, 1032, 1032,
			  157,  993,  992,  987, 1032,  163,  163,  157,  163, 1032,
			  163,  157,  163,  157,  980,  163, 1032,  157,  163,  163,
			 1032, 1032,  163, 1032,  157,  163,  994,  163, 1032,  598,
			  157, 1032,  163,  993,  993,  987,  163,  163,  995,  163,
			 1032, 1032,  163,  163,  163,  163,  157, 1032,  163,  163,
			  157, 1032, 1032,  163,  163,  163,  163,  157,  995,  997,
			  996,  157,  163,  157, 1032,  163, 1032,  163,  163,  163,

			  995, 1032, 1032,  157,  157, 1032,  998,  157,  163,  163,
			  163, 1032,  163, 1032, 1032,  163, 1001,  163,  163,  163,
			  157,  997,  997,  163,  999,  163,  157,  163,  163,  163,
			  157,  163,  163, 1032,  163,  163,  163, 1000,  999,  163,
			 1032,  163,  157,  157,  163,  163,  157,  163, 1001, 1032,
			  163,  157,  163, 1032, 1032,  157,  999,  163,  163,  157,
			  163,  163,  163,  163,  163, 1032,  163, 1032,  157, 1001,
			 1032, 1032, 1032,  163,  163,  163,  163,  163,  163,  163,
			  157, 1032, 1032,  163,  157, 1003, 1002,  163, 1032,  163,
			  163,  163,  163,  163,  157,  163, 1032,  157,  157, 1032,

			  163,  163,  163,  163,  157,  163, 1032,  163,  157,  163,
			  157,  157,  163,  163,  157, 1032,  163, 1003, 1003,  163,
			 1032,  157,  163, 1004,  163, 1032,  163,  157, 1032,  163,
			  163, 1032, 1032,  163,  163,  163,  163, 1032, 1032,  163,
			  163,  163,  163,  163, 1032,  163,  163, 1032,  163, 1032,
			 1005,  163,  157,  163, 1007, 1005, 1006, 1032,  157,  163,
			  163,  163,  157,  163,  163, 1032,  163, 1009, 1032,  157,
			  157, 1032, 1008,  163, 1010,  157,  163, 1032, 1032, 1032,
			  163, 1032, 1005, 1032,  163, 1032, 1007,  157, 1007, 1032,
			  163, 1032,  163,  163,  163,  163,  163, 1032,  163, 1009,

			 1032,  163,  163, 1011, 1009,  163, 1011,  163,  163,  157,
			  163, 1012,  163,  157,  157, 1032, 1013, 1032,  157,  163,
			 1032,  163,  163,  163, 1032,  163,  157,  163, 1032, 1032,
			  157,  157, 1032,  163, 1014, 1011, 1032,  163, 1032, 1032,
			 1032,  163,  163, 1013,  163,  163,  163,  157, 1013, 1032,
			  163, 1032, 1032,  163,  163,  163,  157,  163,  163,  163,
			 1016, 1015,  163,  163, 1032,  163, 1015, 1017,  163,  163,
			  163, 1032, 1032,  157,  163, 1032,  163,  157, 1032,  163,
			  163,  157, 1032,  163, 1032,  163,  163, 1032,  163, 1032,
			 1032, 1032, 1017, 1015,  157,  163, 1032, 1032, 1032, 1017,

			  163, 1032,  163, 1032, 1032,  163,  163,  157,  163,  163,
			 1032, 1023,  163,  163, 1020,  163, 1020,  163,  163, 1021,
			 1021, 1021, 1021, 1032,  157, 1032,  163,  163,  932,  932,
			  932,  932, 1022, 1022, 1022, 1022, 1032,  157, 1024,  163,
			 1032,  157,  987, 1024, 1032,  163,  163,  163,  163,  157,
			  163, 1032,  163,  157,  157, 1032,  163,  163,  163,  157,
			 1032, 1032,  163,  157, 1032, 1032,  157, 1032,  598,  163,
			 1024,  157,  752,  163,  987,  157,  157,  163,  163,  163,
			  163,  163,  163, 1032,  163,  163,  163, 1032,  157,  163,
			  163,  163, 1032, 1032,  163,  163, 1032,  163,  163,  163, yy_Dummy>>,
			1, 1000, 8000)
		end

	yy_nxt_template_10 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			  163,  157,  163,  163,  163,  157,  163,  163,  163,  163,
			  157,  157,  163, 1032,  157,  157,  163, 1032,  157, 1032,
			  163, 1032, 1032, 1032, 1032, 1032, 1032,  157,  157,  163,
			 1025,  163,  163,  163,  163, 1032,  163,  163,  163, 1032,
			 1032,  163,  163,  163,  163, 1032,  163,  163,  163,  163,
			  163,  163,  163, 1032,  163, 1032, 1032, 1026, 1032,  163,
			  163,  163, 1026,  157,  163,  157,  163,  157,  163,  157,
			  157, 1032, 1028,  163, 1029,  163, 1032, 1032,  163, 1032,
			 1027,  163,  157,  163,  163,  163,  163,  157, 1032, 1026,
			 1032, 1032, 1032,  163, 1032,  163,  163,  163,  163,  163,

			  163,  163,  163, 1032, 1028,  163, 1030,  163, 1032, 1030,
			  163,  163, 1028,  163,  163, 1032,  163,  163,  163,  163,
			  157,  157, 1032,  163,  157,  157, 1032,  163,  163,  163,
			 1032, 1032,  981,  981,  981,  981, 1032,  157,  157,  163,
			 1032, 1030, 1032,  163, 1032,  163, 1032, 1032,  163, 1032,
			  163, 1032,  163,  163, 1032,  163,  163,  163, 1032,  163,
			  163,  163, 1031, 1031, 1031, 1031, 1032, 1032, 1032,  163,
			  163,  163,  745,  988,  988,  988,  988,  163,  157,  163,
			  157, 1032,  157,  157,  157, 1032,  163,  157,  163,  163,
			  157,  163, 1032,  163,  157,  157, 1032,  157,  163, 1032,

			  157, 1032,  853,  163, 1032, 1032, 1032,  157, 1032,  163,
			  163,  163,  163,  752,  163,  163,  163, 1032,  163,  163,
			  163,  163,  163,  163, 1032,  163,  163,  163, 1032,  163,
			  163,  163,  163,  163, 1032,  163, 1032, 1032, 1032,  163,
			 1032, 1032, 1032,  163, 1019, 1019, 1019, 1019,  145,  145,
			  145,  145,  145,  145,  145,  145,  145,  145,  145,  145,
			  145,  145, 1032,  163, 1032,  163, 1032, 1032, 1032, 1032,
			 1032, 1032, 1032, 1032, 1032,  163, 1032, 1032, 1032, 1032,
			 1032, 1032, 1032, 1032,  853,   86,   86,   86,   86,   86,
			   86,   86,   86,   86,   86,   86,   86,   86,   86,   86,

			   86,   86,   86,   86,   86,   86,   86,   86,  105,  105,
			 1032,  105,  105,  105,  105,  105,  105,  105,  105,  105,
			  105,  105,  105,  105,  105,  105,  105,  105,  105,  105,
			  105,  117, 1032, 1032, 1032, 1032, 1032, 1032,  117,  117,
			  117,  117,  117,  117,  117,  117,  117,  117,  117,  117,
			  117,  117,  117,  117,  118,  118, 1032,  118,  118,  118,
			  118,  118,  118,  118,  118,  118,  118,  118,  118,  118,
			  118,  118,  118,  118,  118,  118,  118,  126,  126, 1032,
			  126,  126,  126,  126, 1032,  126,  126,  126,  126,  126,
			  126,  126,  126,  126,  126,  126,  126,  126,  126,  126,

			  249,  249, 1032,  249,  249,  249, 1032, 1032,  249,  249,
			  249,  249,  249,  249,  249,  249,  249,  249,  249,  249,
			  249,  249,  249,  163,  163,  163,  163,  163,  163,  163,
			  163,  163,  163,  163,  163,  163,  163,  270, 1032, 1032,
			  270, 1032,  270,  270,  270,  270,  270,  270,  270,  270,
			  270,  270,  270,  270,  270,  270,  270,  270,  270,  270,
			  284,  284, 1032,  284,  284,  284,  284,  284,  284,  284,
			  284,  284,  284,  284,  284,  284,  284,  284,  284,  284,
			  284,  284,  284,  285,  285, 1032,  285,  285,  285,  285,
			  285,  285,  285,  285,  285,  285,  285,  285,  285,  285,

			  285,  285,  285,  285,  285,  285,  309,  309, 1032,  309,
			  309,  309,  309,  309,  309,  309,  309,  309,  309,  309,
			  309,  309,  309,  309,  309,  309,  309,  309,  309,  335,
			 1032, 1032, 1032, 1032,  335,  335,  335,  335,  335,  335,
			  335,  335,  335,  335,  335,  335,  335,  335,  335,  335,
			  335,  335,  375,  375,  375,  375,  375,  375,  375,  375,
			 1032,  375,  375,  375,  375,  375,  375,  375,  375,  375,
			  375,  375,  375,  375,  375,  382,  382,  382,  382,  382,
			  382,  382,  382,  382,  382,  382,  382,  382,  384,  384,
			  384,  384,  384,  384,  384,  384,  384,  384,  384,  384,

			  384,  386,  386,  386,  386,  386,  386,  386,  386,  386,
			  386,  386,  386,  386,  280,  280, 1032,  280,  280,  280,
			 1032,  280,  280,  280,  280,  280,  280,  280,  280,  280,
			  280,  280,  280,  280,  280,  280,  280,  281,  281, 1032,
			  281,  281,  281, 1032,  281,  281,  281,  281,  281,  281,
			  281,  281,  281,  281,  281,  281,  281,  281,  281,  281,
			  936,  936,  936,  936,  936,  936,  936,  936, 1032,  936,
			  936,  936,  936,  936,  936,  936,  936,  936,  936,  936,
			  936,  936,  936,    5, 1032, 1032, 1032, 1032, 1032, 1032,
			 1032, 1032, 1032, 1032, 1032, 1032, 1032, 1032, 1032, 1032,

			 1032, 1032, 1032, 1032, 1032, 1032, 1032, 1032, 1032, 1032,
			 1032, 1032, 1032, 1032, 1032, 1032, 1032, 1032, 1032, 1032,
			 1032, 1032, 1032, 1032, 1032, 1032, 1032, 1032, 1032, 1032,
			 1032, 1032, 1032, 1032, 1032, 1032, 1032, 1032, 1032, 1032,
			 1032, 1032, 1032, 1032, 1032, 1032, 1032, 1032, 1032, 1032,
			 1032, 1032, 1032, 1032, 1032, 1032, 1032, 1032, 1032, 1032,
			 1032, 1032, 1032, 1032, 1032, 1032, 1032, 1032, 1032, 1032,
			 1032, 1032, 1032, 1032, 1032, 1032, 1032, 1032, 1032, 1032,
			 1032, 1032, 1032, yy_Dummy>>,
			1, 783, 9000)
		end

	yy_chk_template: SPECIAL [INTEGER] is
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make (0, 9782)
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

			    3,    3,    3,    3,   22,   23, 1019,   23,   23,   23,
			   23,    4,    4,    4,    4,   22,   24,   26,  145,   26,
			   26,   26,   26,  988,   24,   30,   30,  150,   12,  850,
			   26,   12,   32,   32,  981,   15,  380,   16,   15,   16,
			   16,   79,   79,   79,   25,   16,   25,   25,   25,   25,
			   81,   81,   81,   82,   82,  850,    3,   25,   25,   26,
			  145,  850,   26,   83,   83,   83,  608,    4,   27,  150,
			   27,   27,   27,   27,   84,   84,   84,   12,  380,   25,
			  169,  169,  169,  171,  171,  171,   25,    3,  606,   25,
			   25,    3,    3,    3,    3,    3,    3,    3,    4,  146,

			  146,  604,    4,    4,    4,    4,    4,    4,    4,   12,
			   27,   25,  172,  172,   12,   12,   12,   12,   12,   12,
			   12,   15,   15,   15,   15,   15,   15,   15,   16,   16,
			   16,   16,   16,   16,   16,   34,   34,   34,   34,  146,
			  173,  173,  173,  260,  260,   34,   34,   34,   34,   34,
			   34,   34,   34,   34,   34,   34,   34,   34,   34,   34,
			   34,   34,   34,   34,   34,   34,   34,   34,   34,   34,
			   34,  174,  174,  174,  386,   34,  384,   34,   34,   34,
			   34,   34,   34,   34,   34,   34,   34,   34,   34,   34,
			   34,   34,   34,   34,   34,   34,   34,   34,   34,   34,

			   34,   34,   34,  382,  139,  139,  139,  139,   34,   34,
			   34,   34,   34,   34,   34,   35,  346,   35,  139,  282,
			   35,   40,   35,  263,  258,   40,  175,   35,   35,  170,
			  127,   42,  257,  257,  257,   42,  103,  102,   40,   42,
			  101,  147,  147,  147,  139,   42,  100,   35,   42,   35,
			  139,   88,   35,   40,   35,  381,  381,   40,   85,   35,
			   35,   36,   36,   42,   80,   54,   36,   42,   36,   36,
			   40,   42,   36,   36,   36,   36,   37,   42,   33,   37,
			   42,  147,   28,   37,   11,   64,   37,   64,   87,   37,
			   87,   87,   37,   36,   36,  381,   10,   64,   36,    9,

			   36,   36,  932,    8,   36,   36,   36,   36,   37,    7,
			   90,   37,   90,   90,    5,   37,    0,   64,   37,   64,
			   38,   37,   43,    0,   37,   38,   43,   38,  932,   64,
			    0,   39,   38,   38,  932,   39,   43,   38,   39,   43,
			    0,    0,   39,    0,   87,   39,    0,    0,   39,    0,
			    0,   39,   38,    0,   43,    0,   45,   38,   43,   38,
			   45,  603,  603,   39,   38,   38,   90,   39,   43,   38,
			   39,   43,    0,   45,   39,   87,    0,   39,   44,   44,
			   39,   41,   44,   39,    0,   41,   41,    0,   45,   44,
			    0,   44,   45,   41,   41,   44,    0,   90,   41,   41,

			    0,  603,   46,   47,    0,   45,   46,   47,    0,    0,
			   44,   44,    0,   41,   44,    0,    0,   41,   41,   46,
			   47,   44,   47,   44,   49,   41,   41,   44,   49,   48,
			   41,   41,    0,   48,   46,   47,   48,   49,   46,   47,
			   51,   49,    0,    0,   51,   50,   48,   51,    0,   50,
			    0,   46,   47,    0,   47,    0,   49,   51,    0,   50,
			   49,   48,   50,    0,    0,   48,   52,    0,   48,   49,
			   52,    0,   51,   49,    0,    0,   51,   50,   48,   51,
			   52,   50,   59,   52,  259,  259,  259,    0,   73,   51,
			   73,   50,    0,    0,   50,  261,  261,  261,   52,    0,

			   73,    0,   52,   57,   57,   57,   57,   57,   57,   57,
			    0,    0,   52,   63,   59,   52,   58,   63,    0,    0,
			   73,   58,   73,   58,   63,    0,   63,    0,   58,   58,
			   63,    0,   73,  262,  262,  262,   63,   59,   59,   59,
			   59,   59,   59,   59,    0,   63,    0,    0,   58,   63,
			  264,  264,  264,   58,    0,   58,   63,    0,   63,    0,
			   58,   58,   63,  265,  265,  265,    0,  144,   63,  144,
			  144,  144,  144,   58,   58,   58,   58,   58,   58,   58,
			   60,    0,    0,   66,   60,   61,   66,   60,   66,   66,
			   60,    0,    0,   60,    0,   61,    0,    0,   66,   62,

			    0,   62,   86,   86,   86,   86,   86,   86,   86,  144,
			    0,   62,   60,    0,    0,   66,   60,   61,   66,   60,
			   66,   66,   60,    0,    0,   60,  278,   61,  278,  278,
			   66,   62,    0,   62,    0,    0,   60,   60,   60,   60,
			   60,   60,   60,   62,   61,   61,   61,   61,   61,   61,
			   61,   62,   62,   62,   62,   62,   62,   62,   65,    0,
			   67,    0,   67,   67,   65,   65,   65,   68,   69,    0,
			   69,   65,   67,    0,   69,    0,   65,   68,    0,   68,
			   69,    0,  278,   68,  266,  266,  266,    0,    0,   68,
			   65,    0,   67,    0,   67,   67,   65,   65,   65,   68,

			   69,    0,   69,   65,   67,    0,   69,   70,   65,   68,
			   71,   68,   69,  278,   70,   68,   70,   71,   72,   71,
			    0,   68,   72,  157,   72,   71,   70,  157,   72,   71,
			   74,   75,    0,    0,   72,   75,    0,   75,    0,   70,
			  157,   74,   71,   74,   74,    0,   70,   75,   70,   71,
			   72,   71,    0,   74,   72,  157,   72,   71,   70,  157,
			   72,   71,   74,   75,    0,    0,   72,   75,   76,   75,
			   76,   76,  157,   74,    0,   74,   74,    0,    0,   75,
			   76,   89,    0,   89,   89,   74,    0,    0,   91,    0,
			    0,   91,    0,   91,    0,    0,   91,  267,  267,  267,

			   76,   92,   76,   76,   92,    0,   92,    0,    0,   92,
			    0,    0,   76,   93,   93,   93,   93,   93,   93,   93,
			   94,   94,   94,   94,   94,   94,   94,   94,  268,  268,
			  268,    0,    0,  118,    0,    0,  118,   89,   95,   95,
			   95,   95,   95,   95,   95,   95,   95,   95,   96,   96,
			    0,   96,   96,   96,   96,   96,   96,   96,   97,   97,
			   97,   97,   97,   97,   97,   97,   97,   97,   89,  269,
			  269,  269,   89,   89,   89,   89,   89,   89,   89,   91,
			   91,   91,   91,   91,   91,   91,  105,    0,    0,  105,
			    0,    0,   92,   92,   92,   92,   92,   92,   92,   98, yy_Dummy>>,
			1, 1000, 0)
		end

	yy_chk_template_2 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			   98,   98,   98,   98,   98,   98,   98,   98,   98,   99,
			    0,    0,   99,   99,   99,   99,   99,   99,   99,  118,
			  118,  118,  118,  118,  118,  118,    0,  149,    0,  149,
			  149,  149,  149,    0,    0,  105,    0,    0,  108,    0,
			  108,  108,  373,  108,  373,    0,  108,  373,  373,  373,
			  373,  109,    0,  109,  109,    0,  109,    0,    0,  109,
			  270,  270,  270,  270,  270,  270,  270,  105,  110,  149,
			    0,  110,  105,  105,  105,  105,  105,  105,  105,  107,
			    0,    0,  107,  107,  107,  107,  374,  374,  374,  374,
			  119,  107,  108,  119,  142,  142,  142,  142,  107,    0,

			  107,    0,  107,  107,  107,  109,  126,  107,  142,  107,
			  401,  401,  401,  107,    0,  107,    0,  110,  107,  107,
			  107,  107,  107,  107,  108,  111,    0,    0,  111,  108,
			  108,  108,  108,  108,  108,  108,    0,  109,  112,    0,
			  142,  112,  109,  109,  109,  109,  109,  109,  109,  110,
			  113,    0,    0,  113,  110,  110,  110,  110,  110,  110,
			  110,  372,  372,  372,  372,  107,  107,  107,  107,  107,
			  107,  107,    0,  132,  111,  372,  119,  119,  119,  119,
			  119,  119,  119,  114,    0,    0,  114,  112,  126,  126,
			  126,  126,  126,  126,  126,  115,    0,    0,  115,  113,

			    0,  372,  402,  402,  402,    0,  111,  372,    0,    0,
			  111,  111,  111,  111,  111,  111,  111,  111,    0,  112,
			    0,  112,  112,  112,  112,  112,  112,  112,  112,  112,
			  112,  113,  114,  113,  113,    0,  113,  113,  113,  113,
			  113,  113,  113,  116,  115,    0,  116,  403,  403,  403,
			    0,  120,  132,  132,  120,  132,  132,  132,  132,  132,
			  132,  132,  121,    0,  114,  121,  114,  114,  114,  114,
			  114,  114,  114,  114,  114,  114,  115,  129,  115,  115,
			  115,  115,  115,  115,  115,  115,  115,  115,  122,    0,
			    0,  122,  116,  404,  404,  404,    0,  377,  123,  377,

			    0,  123,  377,  377,  377,  377,    0,    0,  124,    0,
			    0,  124,  405,  405,  405,  383,  383,  383,  125,    0,
			    0,  125,    0,    0,  116,    0,  116,    0,    0,  116,
			  116,  116,  116,  116,  116,  116,  120,  120,  120,  120,
			  120,  120,  120,  120,    0,  121,  121,  121,  121,  121,
			  121,  121,  121,  121,  121,  383,  129,  129,  129,  129,
			  129,  129,  129,  129,  129,  129,  406,  406,  406,    0,
			    0,  122,  122,    0,  122,  122,  122,  122,  122,  122,
			  122,  123,  123,  123,  123,  123,  123,  123,  123,  123,
			  123,  124,  124,  124,  124,  124,  124,  124,  124,  124,

			  124,  125,  130,    0,  125,  125,  125,  125,  125,  125,
			  125,  128,    0,    0,  128,  128,  128,  128,  510,  510,
			  510,    0,    0,  128,    0,  131,    0,  158,    0,  178,
			  128,  158,  128,  178,  128,  128,  128,  128,  133,  128,
			    0,  128,    0,    0,  158,  128,  178,  128,  134,    0,
			  128,  128,  128,  128,  128,  128,    0,    0,  135,  158,
			    0,  178,    0,  158,    0,  178,  511,  511,  511,    0,
			    0,  249,  512,  512,  512,    0,  158,    0,  178,  513,
			  513,  513,    0,  130,  130,  130,  130,  130,  130,  130,
			  130,  250,  514,  514,  514,    0,    0,  128,  128,  128,

			  128,  128,  128,  128,  131,  131,  131,  131,  131,  131,
			  131,  131,  131,  131,  515,  515,  515,  133,  133,  133,
			  133,  133,  133,  133,  133,  133,  133,  134,  134,  134,
			  134,  134,  134,  134,  134,  134,  134,  135,    0,    0,
			  135,  135,  135,  135,  135,  135,  135,  143,    0,  143,
			  143,  143,  143,  249,  249,  249,  249,  249,  249,  249,
			  143,  279,    0,  279,  279,    0,  160,    0,    0,  160,
			  160,    0,    0,  250,  250,  250,  250,  250,  250,  250,
			  159,    0,  161,  160,  159,    0,  161,    0,  159,  143,
			    0,  159,  143,  148,  148,  148,  148,  159,  160,  161,

			  161,  160,  160,  148,  148,  148,  148,  148,  148,  162,
			    0,    0,  159,  162,  161,  160,  159,  279,  161,    0,
			  159,    0,  163,  159,  163,    0,  162,    0,  162,  159,
			    0,  161,  161,  148,  163,  148,  148,  148,  148,  148,
			  148,  162,  164,    0,    0,  162,    0,  165,  279,  164,
			  165,  164,  165,    0,  163,  166,  163,  167,  162,  167,
			  162,  164,  165,  166,  167,  166,  163,    0,  168,  167,
			  168,    0,    0,  176,  164,  166,  168,  176,    0,  165,
			  168,  164,  165,  164,  165,    0,    0,  166,    0,  167,
			  176,  167,  176,  164,  165,  166,  167,  166,    0,  179,

			  168,  167,  168,  179,    0,  176,    0,  166,  168,  176,
			  181,  177,  168,  177,  181,  184,  179,  180,    0,  177,
			    0,  180,  176,  177,  176,    0,  184,  181,  184,    0,
			  180,  179,    0,  182,  180,  179,    0,  182,  184,  516,
			  516,  516,  181,  177,    0,  177,  181,  184,  179,  180,
			  182,  177,    0,  180,  183,  177,    0,    0,  184,  181,
			  184,  183,  180,  183,    0,  182,  180,    0,  186,  182,
			  184,    0,  185,  183,  185,  186,    0,  186,    0,  187,
			    0,  187,  182,    0,  185,  187,  183,  186,  517,  517,
			  517,  187,    0,  183,    0,  183,    0,  188,  188,    0,

			  186,  188,  188,    0,  185,  183,  185,  186,  189,  186,
			    0,  187,  189,  187,  188,    0,  185,  187,    0,  186,
			  191,    0,  191,  187,  192,  189,    0,  190,  192,  188,
			  188,  190,  191,  188,  188,    0,    0,  190,    0,  190,
			  189,  192,  192,    0,  189,  286,  188,  286,  286,  190,
			    0,  194,  191,    0,  191,  194,  192,  189,  193,  190,
			  192,  193,  193,  190,  191,  195,  194,  195,  194,  190,
			  194,  190,  195,  192,  192,  193,  193,  195,    0,    0,
			  197,  190,  197,  194,  197,    0,    0,  194,  197,    0,
			  193,    0,  197,  193,  193,  196,    0,  195,  194,  195,

			  194,  286,  194,  196,  195,  196,    0,  193,  193,  195,
			  196,    0,  197,    0,  197,  196,  197,  198,    0,  199,
			  197,  198,    0,  199,  197,    0,  200,  196,  198,  201,
			  200,  201,  286,  202,  198,  196,  199,  196,    0,    0,
			  200,  201,  196,  200,  202,    0,  202,  196,    0,  198,
			    0,  199,    0,  198,    0,  199,  202,    0,  200,    0,
			  198,  201,  200,  201,    0,  202,  198,  203,  199,  203,
			  203,    0,  200,  201,    0,  200,  202,  204,  202,  203,
			  205,  204,    0,    0,  205,    0,  207,    0,  202,    0,
			  207,  605,  605,  605,  204,  205,    0,  205,    0,  203, yy_Dummy>>,
			1, 1000, 1000)
		end

	yy_chk_template_3 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			    0,  203,  203,  207,  593,  593,  593,  593,  208,  204,
			  208,  203,  205,  204,    0,  206,  205,  206,  207,  206,
			  208,    0,  207,    0,  206,  206,  204,  205,    0,  205,
			  206,  605,  209,  206,  209,  207,  209,  220,    0,  220,
			  208,  220,  208,    0,  209,    0,  211,  206,  211,  206,
			    0,  206,  208,    0,  220,    0,  206,  206,  211,  619,
			  619,  619,  206,    0,  209,  206,  209,    0,  209,  220,
			    0,  220,    0,  220,    0,    0,  209,  210,  211,  210,
			  211,  210,    0,    0,  212,  210,  220,  210,  212,  213,
			  211,  213,  210,  213,  212,  210,    0,  210,    0,  214,

			  214,  212,  214,  213,    0,    0,  213,    0,    0,  210,
			    0,  210,  214,  210,    0,    0,  212,  210,    0,  210,
			  212,  213,    0,  213,  210,  213,  212,  210,  215,  210,
			    0,  214,  214,  212,  214,  213,    0,  215,  213,  215,
			  215,    0,  216,  217,  214,  217,  216,    0,  218,  215,
			  219,  217,  218,  219,  219,  217,  620,  620,  620,  216,
			  215,  216,  719,  719,  719,  218,  218,  219,    0,  215,
			    0,  215,  215,    0,  216,  217,    0,  217,  216,    0,
			  218,  215,  219,  217,  218,  219,  219,  217,  221,    0,
			    0,  216,  221,  216,  222,    0,  222,  218,  218,  219,

			  224,  222,  223,    0,    0,  221,  222,    0,    0,  224,
			  223,  224,  223,  225,  226,  225,    0,    0,  226,    0,
			  221,  224,  223,  231,  221,  225,  222,  231,  222,    0,
			    0,  226,  224,  222,  223,    0,    0,  221,  222,    0,
			  231,  224,  223,  224,  223,  225,  226,  225,    0,  227,
			  226,    0,    0,  224,  223,  231,  227,  225,  227,  231,
			  228,    0,  228,  226,  720,  720,  720,  230,  227,  228,
			  228,  230,  231,  228,    0,  228,  228,    0,  230,    0,
			    0,  227,  230,    0,  230,    0,    0,    0,  227,    0,
			  227,    0,  228,    0,  228,  595,  595,  595,  595,  230,

			  227,  228,  228,  230,    0,  228,  251,  228,  228,  229,
			  230,  229,    0,    0,  230,    0,  230,  229,    0,  229,
			    0,  233,  229,  233,  229,  229,  232,  233,  232,  229,
			  232,  234,    0,  233,    0,  234,    0,    0,  232,    0,
			    0,  229,    0,  229,  598,  598,  598,  598,  234,  229,
			    0,  229,    0,  233,  229,  233,  229,  229,  232,  233,
			  232,  229,  232,  234,  235,  233,  236,  234,  235,    0,
			  232,    0,    0,  236,  237,  236,  237,    0,    0,    0,
			  234,  235,    0,  237,  235,  236,  237,  251,  251,  251,
			  251,  251,  251,  251,  251,    0,  235,    0,  236,    0,

			  235,  599,  599,  599,  599,  236,  237,  236,  237,  594,
			  594,  594,  594,  235,    0,  237,  235,  236,  237,  238,
			    0,  239,  238,  238,    0,    0,  239,  238,  240,  239,
			  244,  239,  240,    0,  244,  241,  238,  239,  238,  241,
			    0,  239,    0,  241,  242,  240,  242,  244,    0,  594,
			  242,  238,  241,  239,  238,  238,  242,    0,  239,  238,
			  240,  239,  244,  239,  240,  252,  244,  241,  238,  239,
			  238,  241,    0,  239,    0,  241,  242,  240,  242,  244,
			  243,  253,  242,  243,  241,  243,  246,  245,  242,    0,
			  246,  254,    0,    0,  245,  243,  245,  390,  247,  390,

			  247,  255,    0,  246,  247,    0,  245,    0,    0,  390,
			  247,  256,  243,    0,    0,  243,    0,  243,  246,  245,
			    0,    0,  246,    0,    0,    0,  245,  243,  245,  390,
			  247,  390,  247,    0,    0,  246,  247,    0,  245,    0,
			    0,  390,  247,    0,  252,  252,  252,  252,  252,  252,
			  252,  252,  252,  252,  745,  745,  745,  745,    0,    0,
			  253,  253,    0,  253,  253,  253,  253,  253,  253,  253,
			  254,  254,  254,  254,  254,  254,  254,  254,  254,  254,
			  255,  255,  255,  255,  255,  255,  255,  255,  255,  255,
			  256,  280,    0,  256,  256,  256,  256,  256,  256,  256,

			  271,  271,  271,  271,  271,  271,  271,  272,  272,  272,
			  272,  272,  272,  272,  272,  273,  273,  273,  273,  273,
			  273,  273,  273,  273,  273,  274,  274,  281,  274,  274,
			  274,  274,  274,  274,  274,  275,  275,  275,  275,  275,
			  275,  275,  275,  275,  275,  276,  276,  276,  276,  276,
			  276,  276,  276,  276,  276,  277,    0,    0,  277,  277,
			  277,  277,  277,  277,  277,  283,    0,  283,  283,  287,
			  287,  287,  287,  287,  287,  287,    0,  280,  280,  280,
			  280,  280,  280,  280,  284,    0,    0,  284,    0,  284,
			    0,  285,  284,    0,  285,    0,  285,    0,  288,  285,

			  394,  288,  394,  288,    0,  379,  288,  379,  379,  379,
			  379,    0,  394,  281,  281,  281,  281,  281,  281,  281,
			  289,  283,    0,  289,    0,  289,    0,    0,  289,    0,
			  290,    0,  394,  290,  394,  290,    0,    0,  290,    0,
			  291,    0,    0,  291,  394,  291,    0,  379,  291,    0,
			    0,    0,  283,    0,    0,    0,  283,  283,  283,  283,
			  283,  283,  283,  292,    0,    0,  292,    0,  292,    0,
			    0,  292,    0,    0,    0,  284,  284,  284,  284,  284,
			  284,  284,  285,  285,  285,  285,  285,  285,  285,  288,
			  288,  288,  288,  288,  288,  288,  293,    0,    0,  293,

			    0,  293,    0,  387,  293,  387,  387,  387,  387,    0,
			  289,  289,  289,  289,  289,  289,  289,  289,  290,  290,
			  290,  290,  290,  290,  290,  290,  290,  290,  291,  291,
			    0,  291,  291,  291,  291,  291,  291,  291,  294,    0,
			    0,  294,  597,  294,  597,  387,  294,  597,  597,  597,
			  597,  292,  292,  292,  292,  292,  292,  292,  292,  292,
			  292,  295,  295,  295,  295,  295,  295,  295,  296,    0,
			    0,  296,    0,  296,    0,    0,  296,  303,  303,  303,
			  303,  303,  303,  303,  293,  293,  293,  293,  293,  293,
			  293,  293,  293,  293,  297,    0,    0,  297,    0,  297,

			    0,    0,  297,    0,  298,    0,  391,  298,    0,  298,
			  391,    0,  298,  396,  299,  396,    0,  299,    0,  299,
			    0,    0,  299,  391,    0,  396,  294,    0,    0,  294,
			  294,  294,  294,  294,  294,  294,  300,    0,  391,  300,
			    0,  300,  391,    0,  300,  396,  301,  396,    0,  301,
			    0,  301,    0,    0,  301,  391,    0,  396,    0,  296,
			  296,  296,  296,  296,  296,  296,  302,    0,    0,  302,
			    0,  302,    0,    0,  302,  304,  304,  304,  304,  304,
			  304,  304,    0,    0,  297,  297,  297,  297,  297,  297,
			  297,  297,  298,  298,  298,  298,  298,  298,  298,  298, yy_Dummy>>,
			1, 1000, 2000)
		end

	yy_chk_template_4 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			  298,  298,  299,  299,    0,  299,  299,  299,  299,  299,
			  299,  299,  305,  305,  305,  305,  305,  305,  305,  309,
			    0,    0,  309,    0,  300,  300,  300,  300,  300,  300,
			  300,  300,  300,  300,  301,  301,  301,  301,  301,  301,
			  301,  301,  301,  301,  306,  306,  306,  306,  306,  306,
			  306,    0,  310,    0,  302,  310,    0,  302,  302,  302,
			  302,  302,  302,  302,  307,  307,  307,  307,  307,  307,
			  307,  307,  307,  307,  308,  308,  308,  308,  308,  308,
			  308,  308,  308,  308,  311,    0,    0,  311,    0,    0,
			    0,  313,    0,  388,  313,  388,  388,  388,  388,  312,

			  392,    0,  312,    0,  392,  309,  309,  309,  309,  309,
			  309,  309,  312,  312,  312,  312,  314,  392,  378,  314,
			  378,  378,  378,  378,  315,    0,    0,  315,    0,    0,
			    0,  378,  392,    0,  316,  388,  392,  316,  310,  310,
			  310,  310,  310,  310,  310,  317,    0,    0,  317,  392,
			  743,  743,  743,  743,    0,  318,    0,    0,  318,    0,
			  378,    0,    0,  378,  743,  319,    0,    0,  319,    0,
			  311,  311,  311,  311,  311,  311,  311,  313,  313,  313,
			  313,  313,  313,  313,    0,  312,  312,  312,  312,  312,
			  312,  312,  320,    0,    0,  320,  743,  746,  746,  746,

			  746,    0,  314,  314,  314,  314,  314,  314,  314,  315,
			  315,  315,  315,  315,  315,  315,  315,  316,  316,  316,
			  316,  316,  316,  316,  316,  316,  316,  323,  317,  317,
			  323,  317,  317,  317,  317,  317,  317,  317,  318,  318,
			  318,  318,  318,  318,  318,  318,  318,  318,  319,  319,
			  319,  319,  319,  319,  319,  319,  319,  319,  321,    0,
			  321,  321,    0,  321,    0,    0,  321,  748,  748,  748,
			  748,  329,    0,    0,  329,  320,  323,    0,  320,  320,
			  320,  320,  320,  320,  320,  322,    0,  322,  322,  398,
			  322,    0,  398,  322,  398,  376,  376,  376,  376,  408,

			    0,  408,    0,    0,  398,    0,    0,  324,  323,  376,
			  324,  408,  321,  323,  323,  323,  323,  323,  323,  323,
			  325,  398,    0,  325,  398,    0,  398,  750,  750,  750,
			  750,  408,    0,  408,  326,  376,  398,  326,    0,  322,
			    0,  376,    0,  408,  321,  600,  600,  600,  600,  321,
			  321,  321,  321,  321,  321,  321,  324,  329,  329,  329,
			  329,  329,  329,  329,  327,    0,    0,  327,    0,  325,
			    0,  322,  330,    0,    0,  330,  322,  322,  322,  322,
			  322,  322,  322,  326,  328,  600,    0,  328,  324,    0,
			    0,    0,  519,  324,  324,  324,  324,  324,  324,  324,

			  331,  325,    0,  331,    0,    0,  325,  325,  325,  325,
			  325,  325,  325,  327,  332,  326,    0,  332,    0,    0,
			  326,  326,  326,  326,  326,  326,  326,  333,    0,    0,
			  333,    0,    0,  328,    0,    0,    0,  334,    0,    0,
			  334,  752,  752,  752,  752,  327,  520,  327,  327,  327,
			  327,  327,  327,  327,  327,  327,  327,  335,  330,  330,
			  330,  330,  330,  330,  330,  328,  337,  328,  328,  328,
			  328,  328,  328,  328,  328,  328,  328,  338,  519,  519,
			  519,  519,  519,  519,  519,    0,  331,  331,  331,  331,
			  331,  331,  331,  339,  849,  849,  849,  849,    0,    0,

			  332,  332,  332,  332,  332,  332,  332,  340,    0,    0,
			  333,  333,  333,  333,  333,  333,  333,  333,  333,  333,
			  334,  334,  334,  334,  334,  334,  334,  334,  334,  334,
			  341,  520,  520,  520,  520,  520,  520,  520,  520,  335,
			  335,  335,  335,  335,  335,  335,  342,    0,  337,  337,
			  337,  337,  337,  337,  337,    0,  343,    0,  338,  338,
			  338,  338,  338,  338,  338,  338,  344,  744,  744,  744,
			  744,    0,  339,  339,  339,  339,  339,  339,  339,  339,
			  339,  339,  345,    0,    0,    0,  340,  340,    0,  340,
			  340,  340,  340,  340,  340,  340,  347,  749,  749,  749,

			  749,    0,    0,  348,    0,    0,    0,  744,    0,  341,
			  341,  341,  341,  341,  341,  341,  341,  341,  341,  350,
			  751,  751,  751,  751,    0,  342,  342,  342,  342,  342,
			  342,  342,  342,  342,  342,  343,  351,  749,  343,  343,
			  343,  343,  343,  343,  343,    0,  349,    0,  344,  344,
			  344,  344,  344,  344,  344,  349,  349,  349,  349,  352,
			  751,    0,    0,    0,  345,  345,  345,  345,  345,  345,
			  345,  353,  602,    0,  602,  602,  602,  602,  347,  347,
			  347,  347,  347,  347,  347,  348,  348,  348,  348,  348,
			  348,  348,  354,  853,  853,  853,  853,    0,    0,  355,

			    0,  350,  350,  350,  350,  350,  350,  350,  356,  848,
			  848,  848,  848,    0,  602,  357,    0,    0,  351,  351,
			  351,  351,  351,  351,  351,  358,    0,    0,  349,  349,
			  349,  349,  349,  349,  349,  359,  854,  854,  854,  854,
			    0,  352,  352,  352,  352,  352,  352,  352,  360,  848,
			    0,    0,    0,  353,  353,  353,  353,  353,  353,  353,
			  361,  856,  856,  856,  856,    0,    0,  362,    0,    0,
			    0,  527,    0,    0,  354,  354,  354,  354,  354,  354,
			  354,  355,  355,  355,  355,  355,  355,  355,  363,    0,
			  356,  356,  356,  356,  356,  356,  356,  357,  357,  357,

			  357,  357,  357,  357,  364,    0,    0,  358,  358,  358,
			  358,  358,  358,  358,  365,    0,    0,  359,  359,  359,
			  359,  359,  359,  359,  366,  852,  852,  852,  852,    0,
			  360,  360,  360,  360,  360,  360,  360,  367,    0,    0,
			    0,  528,  361,  361,  361,  361,  361,  361,  361,  362,
			  362,  362,  362,  362,  362,  362,  368,  527,  527,  527,
			  527,  527,  527,  527,    0,  852,  369,    0,    0,    0,
			  363,  363,  363,  363,  363,  363,  363,  370,  546,  546,
			  546,  546,  546,  546,  546,    0,  364,  364,  364,  364,
			  364,  364,  364,  371,    0,    0,  365,  365,  365,  365,

			  365,  365,  365,  366,  366,  366,  366,  366,  366,  366,
			  366,  366,  366,    0,    0,    0,  367,  367,  367,  367,
			  367,  367,  367,  367,  367,  367,  528,  528,  528,  528,
			  528,  528,  528,  528,    0,  368,  368,  368,  368,  368,
			  368,  368,  368,  368,  368,  369,  369,  369,  369,  369,
			  369,  369,  369,  369,  369,    0,  370,  370,  370,  370,
			  370,  370,  370,  370,  370,  370,    0,  855,  855,  855,
			  855,    0,  371,  371,  371,  371,  371,  371,  371,  371,
			  371,  371,  385,  385,  385,  385,    0,  389,  393,    0,
			    0,  389,  385,  385,  385,  385,  385,  385,  395,  393, yy_Dummy>>,
			1, 1000, 3000)
		end

	yy_chk_template_5 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			  389,  393,  395,    0,  389,    0,  400,  855,  400,    0,
			    0,  393,  400,    0,    0,  395,    0,    0,  400,  389,
			  393,    0,  385,  389,  385,  385,  385,  385,  385,  385,
			  395,  393,  389,  393,  395,  399,  389,  397,  400,  399,
			  400,  397,  407,  393,  400,  397,  407,  395,    0,  409,
			  400,  409,  399,  409,  397,    0,    0,    0,  411,  407,
			    0,  410,  411,    0,    0,    0,  409,  399,    0,  397,
			  410,  399,  410,  397,  407,  411,  411,  397,  407,    0,
			    0,  409,  410,  409,  399,  409,  397,    0,  413,    0,
			  411,  407,  413,  410,  411,    0,    0,    0,  409,  412,

			    0,  412,  410,    0,  410,  413,  412,  411,  411,  413,
			    0,  412,  415,  414,  410,  414,  415,  416,  417,    0,
			  413,    0,  417,  414,  413,  414,    0,    0,  416,  415,
			  416,  412,    0,  412,    0,  417,    0,  413,  412,    0,
			  416,  413,  420,  412,  415,  414,  420,  414,  415,  416,
			  417,    0,    0,    0,  417,  414,    0,  414,    0,  420,
			  416,  415,  416,  418,  419,  418,    0,  417,  419,  418,
			  422,  421,  416,  421,  420,  418,    0,  422,  420,  422,
			  421,  419,  423,  421,  419,  424,  423,    0,    0,  422,
			    0,  420,  424,    0,  424,  418,  419,  418,    0,  423,

			  419,  418,  422,  421,  424,  421,  425,  418,    0,  422,
			  425,  422,  421,  419,  423,  421,  419,  424,  423,    0,
			    0,  422,    0,  425,  424,  427,  424,  427,  426,  430,
			  429,  423,  426,  430,  429,    0,  424,  427,  425,    0,
			    0,  428,  425,  428,  429,  426,  430,  429,  426,    0,
			  428,    0,    0,  428,  433,  425,    0,  427,  433,  427,
			  426,  430,  429,    0,  426,  430,  429,    0,    0,  427,
			  431,  433,  433,  428,    0,  428,  429,  426,  430,  429,
			  426,  431,  428,  431,  431,  428,  433,  432,    0,  436,
			  433,  436,    0,  431,  432,  435,  432,  436,  434,  435,

			  434,  436,  431,  433,  433,  434,  432,    0,    0,    0,
			  434,    0,  435,  431,  435,  431,  431,    0,    0,  432,
			    0,  436,  440,  436,  440,  431,  432,  435,  432,  436,
			  434,  435,  434,  436,  440,  437,    0,  434,  432,  437,
			    0,  441,  434,    0,  435,  441,  435,  437,    0,  438,
			  438,  438,  437,  439,  440,  443,  440,  439,  441,  443,
			  437,  438,    0,  438,  439,    0,  440,  437,    0,    0,
			  439,  437,  443,  441,    0,    0,    0,  441,    0,  437,
			    0,  438,  438,  438,  437,  439,    0,  443,    0,  439,
			  441,  443,  437,  438,  444,  438,  439,  442,  444,  445,

			    0,  442,  439,  445,  443,  442,  446,  447,    0,  444,
			  447,  444,  447,  446,  442,  446,  445,  925,  925,  925,
			  925,    0,  447,    0,    0,  446,  444,    0,    0,  442,
			  444,  445,    0,  442,    0,  445,    0,  442,  446,  447,
			    0,  444,  447,  444,  447,  446,  442,  446,  445,  448,
			    0,  449,    0,  449,  447,  449,  448,  446,  448,  450,
			  451,  453,    0,  449,  451,  453,    0,  452,  448,    0,
			  450,    0,  450,    0,  452,    0,  452,  451,  453,    0,
			    0,  448,  450,  449,    0,  449,  452,  449,  448,    0,
			  448,  450,  451,  453,    0,  449,  451,  453,    0,  452,

			  448,    0,  450,    0,  450,    0,  452,  454,  452,  451,
			  453,  454,  455,    0,  450,  456,  457,  456,  452,  456,
			  457,  458,  454,  455,  454,  455,    0,  456,  458,    0,
			  458,    0,    0,  457,    0,  455,    0,    0,    0,  454,
			  458,    0,    0,  454,  455,    0,    0,  456,  457,  456,
			    0,  456,  457,  458,  454,  455,  454,  455,    0,  456,
			  458,    0,  458,    0,  459,  457,    0,  455,  459,    0,
			    0,  460,  458,  460,  460,  461,  463,    0,  459,  461,
			  463,  459,  462,  460,  462,  467,    0,  468,    0,  467,
			  464,  468,  461,  463,  462,    0,  459,  464,    0,  464,

			  459,    0,  467,  460,  468,  460,  460,  461,  463,  464,
			  459,  461,  463,  459,  462,  460,  462,  467,    0,  468,
			    0,  467,  464,  468,  461,  463,  462,    0,  465,  464,
			  465,  464,  465,  465,  467,  466,  468,    0,  466,    0,
			    0,  464,    0,    0,  466,  465,  466,    0,    0,  469,
			    0,  470,    0,  469,    0,  470,  466,  472,    0,    0,
			  465,  472,  465,    0,  465,  465,  469,  466,  470,    0,
			  466,  470,    0,    0,  472,    0,  466,  465,  466,    0,
			    0,  469,  471,  470,  471,  469,  471,  470,  466,  472,
			    0,    0,  479,  472,  475,    0,  479,    0,  469,  471,

			  470,  473,  471,  470,  474,  475,  472,  475,  473,  479,
			  473,  474,    0,  474,  471,    0,  471,  475,  471,    0,
			  473,    0,    0,  474,  479,    0,  475,    0,  479,    0,
			    0,  471,    0,  473,  471,    0,  474,  475,    0,  475,
			  473,  479,  473,  474,  476,  474,  476,    0,  477,  475,
			  480,    0,  473,  476,  480,  474,  476,  477,  478,  477,
			  478,    0,    0,    0,  478,  481,  477,  480,    0,  477,
			  478,    0,  481,    0,  481,    0,  476,    0,  476,    0,
			  477,    0,  480,    0,  481,  476,  480,    0,  476,  477,
			  478,  477,  478,    0,  482,    0,  478,  481,  477,  480,

			    0,  477,  478,    0,  481,  482,  481,  482,  484,    0,
			  483,  484,    0,  484,  483,  485,  481,  482,  483,  485,
			    0,  487,  486,  484,  486,  487,  482,  483,  485,    0,
			    0,    0,  485,    0,  486,    0,    0,  482,  487,  482,
			  484,    0,  483,  484,  489,  484,  483,  485,  489,  482,
			  483,  485,    0,  487,  486,  484,  486,  487,  488,  483,
			  485,  489,    0,    0,  485,  488,  486,  488,  490,    0,
			  487,  491,  490,    0,    0,  491,  489,  488,    0,  491,
			  489,    0,  492,    0,  490,  490,    0,    0,  491,  492,
			  488,  492,    0,  489,    0,    0,    0,  488,    0,  488,

			  490,  492,    0,  491,  490,    0,    0,  491,    0,  488,
			  493,  491,  493,    0,  492,  493,  490,  490,    0,    0,
			  491,  492,  493,  492,  494,    0,  495,  494,  497,  494,
			  495,  497,  497,  492,  495,  496,    0,    0,  496,  494,
			  496,    0,  493,  495,  493,  497,    0,  493,    0,    0,
			  496,    0,    0,  500,  493,  500,  494,  504,  495,  494,
			  497,  494,  495,  497,  497,  500,  495,  496,  498,  501,
			  496,  494,  496,  501,  505,  495,  498,  497,  498,  499,
			    0,  506,  496,  499,    0,  500,  501,  500,  498,  507,
			    0,  502,  499,  502,    0,    0,  499,  500,    0,  508, yy_Dummy>>,
			1, 1000, 4000)
		end

	yy_chk_template_6 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			  498,  501,    0,  502,    0,  501,    0,    0,  498,  509,
			  498,  499,    0,    0,    0,  499,  521,    0,  501,    0,
			  498,    0,    0,  502,  499,  502,  522,    0,  499,  926,
			  926,  926,  926,    0,    0,  502,  523,    0,    0,  504,
			  504,  504,  504,  504,  504,  504,  524,  547,  547,  547,
			  547,  547,  547,  547,  721,    0,  505,  505,  505,  505,
			  505,  505,  505,  506,  506,  506,  506,  506,  506,  506,
			  525,  507,  507,  507,  507,  507,  507,  507,  508,  508,
			  508,  508,  508,  508,  508,  508,  508,  508,  509,  509,
			  509,  509,  509,  509,  509,  509,  509,  509,  529,  521,

			  521,  521,  521,  521,  521,  521,  521,  521,  521,  522,
			  522,  530,  522,  522,  522,  522,  522,  522,  522,  523,
			  523,  523,  523,  523,  523,  523,  523,  523,  523,  524,
			  524,  524,  524,  524,  524,  524,  524,  524,  524,  531,
			  721,  721,  721,  721,  721,  721,  721,    0,    0,  532,
			    0,    0,    0,  525,    0,    0,  525,  525,  525,  525,
			  525,  525,  525,  533,    0,  534,    0,    0,  534,    0,
			  534,    0,  535,  534,    0,  535,    0,  535,    0,    0,
			  535,  529,  529,  529,  529,  529,  529,  529,  529,  529,
			  529,    0,    0,    0,  530,  530,    0,  530,  530,  530,

			  530,  530,  530,  530,  536,    0,    0,  536,    0,  536,
			    0,  537,  536,    0,  537,    0,  537,    0,    0,  537,
			    0,    0,  531,  531,  531,  531,  531,  531,  531,  531,
			  531,  531,  532,  532,  532,  532,  532,  532,  532,  532,
			  532,  532,  927,  927,  927,  927,  533,    0,    0,  533,
			  533,  533,  533,  533,  533,  533,  534,  534,  534,  534,
			  534,  534,  534,  535,  535,  535,  535,  535,  535,  535,
			  538,    0,    0,  538,    0,  538,    0,    0,  538,    0,
			  539,    0,    0,  539,    0,  539,    0,  609,  539,  609,
			  609,  609,  609,    0,    0,  536,  536,  536,  536,  536,

			  536,  536,  537,  537,  537,  537,  537,  537,  537,  540,
			    0,    0,  540,    0,  540,    0,  541,  540,    0,  541,
			    0,  541,    0,  542,  541,    0,  542,    0,  542,  609,
			  543,  542,    0,  543,    0,  543,    0,    0,  543,    0,
			  544,    0,    0,  544,    0,  544,    0,    0,  544,    0,
			    0,    0,  548,    0,    0,  548,    0,    0,  538,  538,
			  538,  538,  538,  538,  538,  538,  538,  538,  539,  539,
			  539,  539,  539,  539,  539,  539,  539,  539,  545,    0,
			    0,  545,    0,  545,    0,    0,  545,    0,    0,  847,
			  549,  847,    0,  549,  847,  847,  847,  847,    0,    0,

			  540,  540,  540,  540,  540,  540,  540,  541,  541,  541,
			  541,  541,  541,  541,  542,  542,  542,  542,  542,  542,
			  542,  543,  543,  543,  543,  543,  543,  543,  544,  544,
			  544,  544,  544,  544,  544,  544,  544,  544,  548,  548,
			  548,  548,  548,  548,  548,  550,    0,    0,  550,    0,
			    0,    0,  552,    0,    0,  552,    0,  550,  550,  550,
			  550,  550,  551,    0,    0,  551,  545,  545,  545,  545,
			  545,  545,  545,  545,  545,  545,  549,  549,  549,  549,
			  549,  549,  549,  553,    0,    0,  553,    0,  551,    0,
			  554,    0,    0,  554,    0,    0,  857,  555,  857,    0,

			  555,  857,  857,  857,  857,    0,    0,  556,    0,    0,
			  556,    0,    0,  753,  753,  753,  753,  557,    0,    0,
			  557,  610,    0,  610,  610,  610,  610,  753,    0,    0,
			    0,  550,  550,  550,  550,  550,  550,  550,  552,  552,
			  552,  552,  552,  552,  552,    0,    0,  562,  551,  551,
			  551,  551,  551,  551,  551,  931,  931,  931,  931,  753,
			  928,  558,  928,  610,  558,  928,  928,  928,  928,  553,
			  553,  553,  553,  553,  553,  553,  554,  554,  554,  554,
			  554,  554,  554,  555,  555,  555,  555,  555,  555,  555,
			  556,  556,  556,  556,  556,  556,  556,  556,  556,  556,

			  557,  557,  557,  557,  557,  557,  557,  557,  557,  557,
			  558,  559,    0,    0,  559,    0,    0,    0,  560,    0,
			    0,  560,    0,    0,    0,  561,    0,    0,  561,  562,
			  562,  562,  562,  562,  562,  562,  563,    0,    0,    0,
			  611,  625,  558,  564,  611,  625,    0,  558,  558,  558,
			  558,  558,  558,  558,  565,    0,    0,  611,  625,  611,
			  559,  929,    0,  929,  566,    0,  929,  929,  929,  929,
			    0,    0,  611,  625,  567,    0,  611,  625,  933,  933,
			  933,  933,  934,  934,  934,  934,    0,    0,    0,  611,
			  625,  611,  559,  930,  930,  930,  930,  559,  559,  559,

			  559,  559,  559,  559,  560,  560,  560,  560,  560,  560,
			  560,  561,  561,  561,  561,  561,  561,  561,  563,  563,
			  563,  563,  563,  563,  563,  564,  564,  564,  564,  564,
			  564,  564,  590,  930,    0,    0,  565,  565,  565,  565,
			  565,  565,  565,  566,  566,  566,  566,  566,  566,  566,
			  566,  566,  566,  567,  567,  567,  567,  567,  567,  567,
			  567,  567,  567,  573,  592,  592,  592,  592,    0,    0,
			    0,  573,  573,  573,  573,  573,  591,    0,  592,    0,
			    0,  596,  596,  596,  596,    0,  601,    0,  601,  601,
			  601,  601,    0,    0,    0,  596,    0,    0,    0,  601,

			  935,  935,  935,  935,  592,  982,  982,  982,  982,    0,
			  592,  590,  590,  590,  590,  590,  590,  590,  590,  590,
			  590,  596,  984,  984,  984,  984,    0,  596,  601,    0,
			    0,  601,  985,  985,  985,  985,  613,    0,    0,    0,
			  613,  986,  986,  986,  986,  573,  573,  573,  573,  573,
			  573,  573,    0,  613,  613,  591,  591,  591,  591,  591,
			  591,  591,  591,  591,  591,  612,    0,  612,  613,  614,
			    0,  614,  613,  612,  615,    0,  614,  612,  615,    0,
			  615,  614,    0,  616,    0,  613,  613,    0,  616,    0,
			  616,  615,    0,    0,  617,    0,    0,  612,  617,  612,

			  616,  614,  617,  614,    0,  612,  615,    0,  614,  612,
			  615,  617,  615,  614,  618,  616,  628,  618,  628,  618,
			  616,  621,  616,  615,  628,  621,  617,    0,  628,  618,
			  617,  621,  616,    0,  617,    0,    0,  623,  621,  622,
			  622,  623,  622,  617,    0,    0,  618,    0,  628,  618,
			  628,  618,  622,  621,  623,  623,  628,  621,  626,    0,
			  628,  618,  627,  621,    0,  626,  627,  626,    0,  623,
			  621,  622,  622,  623,  622,    0,  624,  626,  624,  627,
			    0,  627,    0,  624,  622,  629,  623,  623,  624,  629,
			  626,    0,    0,    0,  627,    0,    0,  626,  627,  626, yy_Dummy>>,
			1, 1000, 5000)
		end

	yy_chk_template_7 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			    0,    0,  629,    0,    0,  630,    0,    0,  624,  626,
			  624,  627,  630,  627,  630,  624,    0,  629,    0,  631,
			  624,  629,  632,  631,  630,  631,  633,  632,    0,  632,
			  633,  637,    0,    0,  629,  637,  631,  630,    0,  632,
			    0,    0,    0,  633,  630,    0,  630,    0,  637,    0,
			    0,  631,    0,    0,  632,  631,  630,  631,  633,  632,
			    0,  632,  633,  637,  634,  635,  634,  637,  631,  635,
			  634,  632,    0,  635,  636,  633,  634,  636,    0,  636,
			  637,  638,  635,  638,    0,    0,  639,  638,    0,  636,
			  639,    0,    0,  638,    0,    0,  634,  635,  634,  639,

			  640,  635,  634,  639,  640,  635,  636,    0,  634,  636,
			    0,  636,    0,  638,  635,  638,    0,  640,  639,  638,
			  643,  636,  639,    0,  643,  638,  641,  642,  641,  642,
			    0,  639,  640,  642,    0,  639,  640,  643,  641,  642,
			  645,  644,    0,  644,  645,    0,  647,  644,    0,  640,
			  647,    0,  643,  644,    0,  646,  643,  645,  641,  642,
			  641,  642,  646,  647,  646,  642,  647,    0,    0,  643,
			  641,  642,  645,  644,  646,  644,  645,    0,  647,  644,
			  649,  648,  647,  648,  649,  644,    0,  646,  650,  645,
			  648,    0,  650,  648,  646,  647,  646,  649,  647,  651,

			  652,  651,    0,    0,    0,  650,  646,  652,    0,  652,
			  653,  651,  649,  648,  653,  648,  649,  655,  653,  652,
			  650,  655,  648,  654,  650,  648,  654,  653,  654,  649,
			    0,  651,  652,  651,  655,    0,    0,  650,  654,  652,
			  655,  652,  653,  651,  657,  656,  653,  656,  657,  655,
			  653,  652,  658,  655,  658,  654,    0,  656,  654,  653,
			  654,  657,    0,    0,  658,  659,  655,  657,    0,  659,
			  654,    0,  655,    0,  661,    0,  657,  656,  661,  656,
			  657,    0,  659,    0,  658,    0,  658,    0,  660,  656,
			  660,  661,    0,  657,  660,    0,  658,  659,  662,  657,

			  660,  659,    0,    0,  663,  662,  661,  662,  663,    0,
			  661,    0,  665,  664,  659,  664,  665,  662,    0,  664,
			  660,  663,  660,  661,  667,  664,  660,    0,  667,  665,
			  662,  666,  660,  666,    0,  667,  663,  662,  669,  662,
			  663,  667,  669,  666,  665,  664,    0,  664,  665,  662,
			  668,  664,  668,  663,  671,  669,  667,  664,  671,    0,
			  667,  665,  668,  666,  670,  666,  670,  667,  675,    0,
			  669,  671,  675,  667,  669,  666,  670,  672,    0,  672,
			    0,  674,  668,  674,  668,  675,  671,  669,  673,  672,
			  671,    0,  673,  674,  668,  676,  670,  676,  670,  673,

			  675,    0,  677,  671,  675,  673,  677,  676,  670,  672,
			    0,  672,    0,  674,  679,  674,  679,  675,    0,  677,
			  673,  672,  677,  679,  673,  674,  679,  676,  678,  676,
			    0,  673,  678,    0,  677,  682,  678,  673,  677,  676,
			    0,  682,    0,  682,  680,  678,  679,  680,  679,  680,
			    0,  677,  681,  682,  677,  679,  681,  681,  679,  680,
			  678,  683,    0,    0,  678,  683,    0,  682,  678,  681,
			    0,    0,    0,  682,    0,  682,  680,  678,  683,  680,
			  684,  680,  684,  685,  681,  682,  684,  685,  681,  681,
			  687,  680,  684,  683,  687,  685,    0,  683,  687,    0,

			  685,  681,    0,    0,  686,  686,  686,  687,  688,    0,
			  683,  688,  684,  688,  684,  685,  686,    0,  684,  685,
			    0,    0,  687,  688,  684,    0,  687,  685,    0,  689,
			  687,    0,  685,  689,    0,    0,  686,  686,  686,  687,
			  688,    0,  692,  688,  692,  688,  689,  690,  686,  689,
			  691,  690,  691,  693,  692,  688,    0,  693,  690,  691,
			    0,  689,  691,    0,  690,  689,  851,  851,  851,  851,
			  693,    0,    0,    0,  692,    0,  692,  693,  689,  690,
			  851,  689,  691,  690,  691,  693,  692,    0,    0,  693,
			  690,  691,    0,  694,  691,  694,  690,  695,    0,  695,

			  697,  695,  693,    0,  697,  694,  694,  696,    0,  693,
			    0,    0,  851,    0,  695,    0,  696,  697,  696,    0,
			    0,    0,  700,    0,  700,  694,  700,  694,  696,  695,
			    0,  695,  697,  695,  700,    0,  697,  694,  694,  696,
			  699,  698,    0,  698,  699,    0,  695,  698,  696,  697,
			  696,    0,    0,  698,  700,  699,  700,  699,  700,    0,
			  696,  701,  702,  703,  702,  701,  700,  703,    0,  704,
			    0,  704,  699,  698,  702,  698,  699,    0,  701,  698,
			  703,  704,    0,    0,  706,  698,    0,  699,    0,  699,
			  706,    0,  706,  701,  702,  703,  702,  701,    0,  703,

			  705,  704,  706,  704,  705,  705,  702,  710,    0,  710,
			  701,  707,  703,  704,    0,  707,  706,  705,  708,  710,
			  708,  711,  706,    0,  706,  711,    0,  708,  707,  709,
			  708,  707,  705,  709,  706,  717,  705,  705,  711,  710,
			  709,  710,  714,  707,  714,  712,  709,  707,  718,  705,
			  708,  710,  708,  711,  714,  722,  712,  711,  712,  708,
			  707,  709,  708,  707,  723,  709,    0,  713,  712,    0,
			  711,  713,  709,  724,  714,  715,  714,  712,  709,  715,
			    0,  716,    0,  716,  713,  725,  714,    0,  712,    0,
			  712,    0,  715,  716,    0,  726,    0,    0,    0,  713,

			  712,    0,  727,  713,    0,    0,    0,  715,    0,  728,
			    0,  715,    0,  716,    0,  716,  713,  717,  717,  717,
			  717,  717,  717,  717,  715,  716,  729,    0,    0,    0,
			  718,  718,  718,  718,  718,  718,  718,  730,    0,    0,
			    0,  722,  722,  722,  722,  722,  722,  722,  731,    0,
			  723,  723,  723,  723,  723,  723,  723,    0,  732,  724,
			  724,  724,  724,  724,  724,  724,    0,    0,  725,  725,
			  725,  725,  725,  725,  725,  725,  725,  725,  726,  726,
			  726,  726,  726,  726,  726,  726,  726,  726,  727,  727,
			  727,  727,  727,  727,  727,  728,  728,  728,  728,  728,

			  728,  728,  733,    0,    0,  733,    0,  733,    0,    0,
			  733,    0,  729,  729,  729,  729,  729,  729,  729,  738,
			    0,    0,  738,  730,  730,  730,  730,  730,  730,  730,
			  740,  731,  731,  731,  731,  731,  731,  731,  731,  731,
			  731,  732,  732,  732,  732,  732,  732,  732,  732,  732,
			  732,  734,  741,    0,  734,    0,  734,    0,  735,  734,
			    0,  735,    0,  735,    0,  736,  735,    0,  736,    0,
			  736,    0,    0,  736,    0,    0,    0,  739,    0,  754,
			  739,  754,  754,  754,  754,    0,    0,    0,  737,    0,
			    0,  737,    0,  733,  733,  733,  733,  733,  733,  733, yy_Dummy>>,
			1, 1000, 6000)
		end

	yy_chk_template_8 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			  737,  737,  737,  737,  737,  738,  738,  738,  738,  738,
			  738,  738,  740,  740,  740,  740,  740,  740,  740,  742,
			  938,  754,  938,    0,    0,  938,  938,  938,  938,  990,
			  990,  990,  990,    0,  741,  741,  741,  741,  741,  741,
			  741,    0,  734,  734,  734,  734,  734,  734,  734,  735,
			  735,  735,  735,  735,  735,  735,  736,  736,  736,  736,
			  736,  736,  736,  739,  739,  739,  739,  739,  739,  739,
			  747,  747,  747,  747,  737,  737,  737,  737,  737,  737,
			  737,  755,    0,    0,  747,  755,    0,  756,  758,  756,
			  758,  757,    0,    0,    0,  757,    0,    0,  755,  756,

			  758,  742,  742,  742,  742,  742,  742,  742,  757,    0,
			  747,  759,    0,  755,    0,  759,  747,  755,    0,  756,
			  758,  756,  758,  757,  759,  761,  761,  757,  759,  761,
			  755,  756,  758,  760,  764,  760,  764,    0,    0,    0,
			  757,  762,  761,  759,    0,  760,  764,  759,    0,    0,
			  766,  762,  766,  762,    0,  763,  759,  761,  761,  763,
			  759,  761,  766,  762,    0,  760,  764,  760,  764,    0,
			    0,  765,  763,  762,  761,  765,  767,  760,  764,    0,
			  767,    0,  766,  762,  766,  762,    0,  763,  765,    0,
			  768,  763,  768,  767,  766,  762,  768,  769,    0,    0,

			    0,  769,  768,  765,  763,  769,    0,  765,  767,  772,
			    0,  772,  767,    0,  769, 1020, 1020, 1020, 1020,    0,
			  765,  772,  768,  770,  768,  767,    0,  770,  768,  769,
			  770,  771,  770,  769,  768,  771,    0,  769,  774,    0,
			  774,  772,  770,  772,  771,  776,  769,  776,  771,    0,
			  774,  776,  773,  772,  775,  770,  773,  776,  775,  770,
			    0,  777,  770,  771,  770,  777,  777,  771,    0,  773,
			  774,  775,  774,    0,  770,    0,  771,  776,  777,  776,
			  771,    0,  774,  776,  773,    0,  775,  779,  773,  776,
			  775,  779,  781,  777,  778,  781,  781,  777,  777,  780,

			  778,  773,  778,  775,  779,  782,  780,    0,  780,  781,
			  777,    0,  778,  782,    0,  782,  783,    0,  780,  779,
			  783,    0,    0,  779,  781,  782,  778,  781,  781,    0,
			    0,  780,  778,  783,  778,  783,  779,  782,  780,    0,
			  780,  781,    0,    0,  778,  782,    0,  782,  783,    0,
			  780,  784,  783,  784,  787,    0,  785,  782,  787,  784,
			  785,    0,  786,  784,  786,  783,  788,  783,  788,  785,
			    0,  787,  789,  785,  786,  790,  789,  790,  788,    0,
			  791,  790,    0,  784,  791,  784,  787,  790,  785,  789,
			  787,  784,  785,  791,  786,  784,  786,  791,  788,    0,

			  788,  785,    0,  787,  789,  785,  786,  790,  789,  790,
			  788,    0,  791,  790,  793,  792,  791,  792,  793,  790,
			  795,  789,  797,  794,  795,  791,  797,  792,  795,  791,
			  794,  793,  794,  796,    0,    0,  796,  795,  796,  797,
			    0,  798,  794,  798,    0,    0,  793,  792,  796,  792,
			  793,    0,  795,  798,  797,  794,  795,    0,  797,  792,
			  795,    0,  794,  793,  794,  796,    0,    0,  796,  795,
			  796,  797,    0,  798,  794,  798,  800,    0,  799,  800,
			  796,  800,  799,    0,    0,  798,  799,    0,  801,  803,
			  801,  800,  801,  803,    0,  799,    0,  803,  802,    0,

			  805,    0,    0,    0,  805,  801,  803,  802,  800,  802,
			  799,  800,    0,  800,  799,    0,    0,  805,  799,  802,
			  801,  803,  801,  800,  801,  803,    0,  799,  804,  803,
			  802,  804,  805,  804,    0,    0,  805,  801,  803,  802,
			  806,  802,  806,  804,  807,    0,    0,  808,  807,  805,
			    0,  802,  806,  809,  808,    0,  808,  809,    0,    0,
			  804,  807,    0,  804,  811,  804,  808,    0,  811,    0,
			  809,  810,  806,  810,  806,  804,  807,  810,    0,  808,
			  807,  811,    0,  810,  806,  809,  808,  811,  808,  809,
			    0,  813,  812,  807,  812,  813,  811,  815,  808,  813,

			  811,  815,  809,  810,  812,  810,    0,  814,  813,  810,
			  814,  816,  814,  811,  815,  810,    0,  817,  816,  811,
			  816,  817,  814,  813,  812,    0,  812,  813,  818,  815,
			  816,  813,    0,  815,  817,  818,  812,  818,    0,  814,
			  813,  819,  814,  816,  814,  819,  815,  818,    0,  817,
			  816,  821,  816,  817,  814,  821,    0,    0,  819,  820,
			  818,  820,  816,  822,    0,  820,  817,  818,  821,  818,
			  822,  820,  822,  819,    0,    0,    0,  819,    0,  818,
			    0,    0,  822,  821,  826,    0,  826,  821,  823,    0,
			  819,  820,  823,  820,    0,  822,  826,  820,    0,    0,

			  821,    0,  822,  820,  822,  823,  825,  823,  827,  824,
			  825,  824,  827,    0,  822,  829,  826,  824,  826,  829,
			  823,  824,    0,  825,  823,  827,    0,  827,  826,    0,
			    0,    0,  829,  832,    0,  832,    0,  823,  825,  823,
			  827,  824,  825,  824,  827,  832,  828,  829,  828,  824,
			  830,  829,  831,  824,  828,  825,  831,  827,  828,  827,
			    0,  830,  833,  830,  829,  832,  833,  832,  835,  831,
			  833,    0,  835,  830,    0,    0,    0,  832,  828,  833,
			  828,  841,  830,    0,  831,  835,  828,  838,  831,  838,
			  828,    0,  837,  830,  833,  830,  837,  842,  833,  838,

			  835,  831,  833,  834,  835,  830,  834,  836,  834,  837,
			  840,  833,  840,  843,  836,    0,  836,  835,  834,  838,
			  844,  838,  840,    0,  837,    0,  836,    0,  837,    0,
			  839,  838,    0,  845,  839,  834,  845,    0,  834,  836,
			  834,  837,  840,  839,  840,  845,  836,  839,  836,    0,
			  834,    0,    0,    0,  840,    0,    0,    0,  836,    0,
			    0,    0,  839,    0,    0,    0,  839,  841,  841,  841,
			  841,  841,  841,  841,    0,  839,    0,    0,    0,  839,
			    0,    0,    0,  842,  842,  842,  842,  842,  842,  842,
			    0,    0,    0,  983,  983,  983,  983,    0,    0,  843,

			  843,  843,  843,  843,  843,  843,  844,  844,  844,  844,
			  844,  844,  844,  858,  858,  858,  858,    0,    0,  845,
			  845,  845,  845,  845,  845,  845,  859,  858,  861,  860,
			  859,  860,  861,  983,  863,  862,    0,  862,  863,    0,
			    0,  860,    0,  859,  862,  861,    0,  862,  861,    0,
			    0,  863,    0,  863,    0,    0,    0,    0,  859,  858,
			  861,  860,  859,  860,  861,    0,  863,  862,    0,  862,
			  863,    0,    0,  860,  865,  859,  862,  861,  865,  862,
			  861,    0,  864,  863,  864,  863,    0,  867,  866,  867,
			  864,  865,  866,    0,  864,  868,  869,  868,  868,  867, yy_Dummy>>,
			1, 1000, 7000)
		end

	yy_chk_template_9 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			  869,    0,  866,    0,    0,  866,  865,  868,    0,    0,
			  865,    0,    0,  869,  864,  869,  864,    0,    0,  867,
			  866,  867,  864,  865,  866,    0,  864,  868,  869,  868,
			  868,  867,  869,    0,  866,    0,  870,  866,  870,  868,
			    0,    0,  871,  872,  870,  869,  871,  869,  870,  873,
			  872,    0,  872,  873,  875,  874,    0,  874,  875,  871,
			  877,  876,  872,  876,  877,    0,  873,  874,  870,    0,
			  870,  875,    0,  876,  871,  872,  870,  877,  871,    0,
			  870,  873,  872,    0,  872,  873,  875,  874,    0,  874,
			  875,  871,  877,  876,  872,  876,  877,  878,  873,  874,

			  880,    0,  880,  875,  878,  876,  878,  879,  882,  877,
			  881,  879,  880,  883,  881,    0,  878,  883,    0,  882,
			    0,  882,    0,    0,  879,    0,    0,  881,  884,  878,
			  883,  882,  880,    0,  880,  884,  878,  884,  878,  879,
			  882,    0,  881,  879,  880,  883,  881,  884,  878,  883,
			    0,  882,    0,  882,  885,    0,  879,  887,  885,  881,
			  884,  887,  883,  882,  886,    0,  886,  884,    0,  884,
			  888,  885,  888,    0,  887,  887,  886,  888,    0,  884,
			    0,    0,  888,  890,  889,  890,  885,    0,  889,  887,
			  885,    0,    0,  887,    0,  890,  886,  889,  886,    0,

			    0,  889,  888,  885,  888,    0,  887,  887,  886,  888,
			    0,  892,    0,  892,  888,  890,  889,  890,  891,  892,
			  889,  893,  891,  892,  894,  893,  894,  890,    0,  889,
			  895,    0,  894,  889,  895,  891,  894,  891,  893,    0,
			  893,    0,    0,  892,    0,  892,    0,  895,  896,    0,
			  891,  892,    0,  893,  891,  892,  894,  893,  894,  896,
			    0,  896,  895,    0,  894,    0,  895,  891,  894,  891,
			  893,  896,  893,  897,  898,    0,  898,  897,    0,  895,
			  896,  899,  898,  901,    0,  899,  898,  901,    0,    0,
			  897,  896,  897,  896,    0,  900,    0,  900,  899,  899,

			  901,    0,  900,  896,    0,  897,  898,  900,  898,  897,
			    0,    0,    0,  899,  898,  901,    0,  899,  898,  901,
			    0,  902,  897,  902,  897,    0,  904,  900,  904,  900,
			  899,  899,  901,  902,  900,    0,    0,  903,  904,  900,
			  906,  903,  906,    0,  905,  907,    0,  909,  905,  907,
			  903,  909,  906,  902,  903,  902,    0,  905,  904,    0,
			  904,  905,  907,    0,  909,  902,  908,    0,  908,  903,
			  904,    0,  906,  903,  906,    0,  905,  907,  908,  909,
			  905,  907,  903,  909,  906,    0,  903,  911,  910,  905,
			  912,  911,  912,  905,  907,  910,  909,  910,  908,  913,

			  908,    0,  912,  913,  911,    0,  914,  910,  914,  915,
			  908,  921,    0,  915,    0,  921,  913,    0,  914,  911,
			  910,    0,  912,  911,  912,    0,  915,  910,  921,  910,
			  916,  913,  916,    0,  912,  913,  911,    0,  914,  910,
			  914,  915,  916,  921,  918,  915,  918,  921,  913,  917,
			  914,    0,  918,  917,    0,  920,  918,  920,  915,  922,
			  921,  922,  916,    0,  916,    0,  917,  920,  917,  919,
			    0,  922,    0,  919,  916,  923,  918,    0,  918,  923,
			    0,  917,  919,    0,  918,  917,  919,  920,  918,  920,
			    0,  922,  923,  922,  923,    0,    0,    0,  917,  920,

			  917,  919,    0,  922,  924,  919,  924,  923,    0,    0,
			    0,  923,  924,  939,  919,    0,  924,  939,  919,  937,
			  937,  937,  937,  940,  923,  940,  923,    0,    0,    0,
			  939,  940,  939,  937,    0,  940,  924,  941,  924,    0,
			  942,  941,  942,  943,  924,  939,    0,  943,  924,  939,
			    0,    0,  942,    0,  941,  940,  943,  940,    0,  937,
			  943,    0,  939,  940,  939,  937,  944,  940,  944,  941,
			    0,    0,  942,  941,  942,  943,  945,    0,  944,  943,
			  945,    0,    0,  946,  942,  946,  941,  947,  943,  948,
			  947,  947,  943,  945,    0,  946,    0,  948,  944,  948,

			  944,    0,    0,  949,  947,    0,  949,  949,  945,  948,
			  944,    0,  945,    0,    0,  946,  952,  946,  952,  947,
			  949,  948,  947,  947,  950,  945,  951,  946,  952,  948,
			  951,  948,  950,    0,  950,  949,  947,  951,  949,  949,
			    0,  948,  953,  951,  950,  954,  953,  954,  952,    0,
			  952,  955,  949,    0,    0,  955,  950,  954,  951,  953,
			  952,  956,  951,  956,  950,    0,  950,    0,  955,  951,
			    0,    0,    0,  956,  953,  951,  950,  954,  953,  954,
			  957,    0,    0,  955,  957,  958,  957,  955,    0,  954,
			  958,  953,  958,  956,  959,  956,    0,  957,  959,    0,

			  955,  960,  958,  960,  961,  956,    0,  962,  961,  962,
			  963,  959,  957,  960,  963,    0,  957,  958,  957,  962,
			    0,  961,  958,  963,  958,    0,  959,  963,    0,  957,
			  959,    0,    0,  960,  958,  960,  961,    0,    0,  962,
			  961,  962,  963,  959,    0,  960,  963,    0,  964,    0,
			  964,  962,  965,  961,  966,  963,  965,    0,  967,  963,
			  964,  966,  967,  966,  968,    0,  968,  968,    0,  965,
			  969,    0,  967,  966,  969,  967,  968,    0,    0,    0,
			  964,    0,  964,    0,  965,    0,  966,  969,  965,    0,
			  967,    0,  964,  966,  967,  966,  968,    0,  968,  968,

			    0,  965,  969,  970,  967,  966,  969,  967,  968,  971,
			  970,  971,  970,  971,  973,    0,  972,    0,  973,  969,
			    0,  974,  970,  974,    0,  972,  971,  972,    0,    0,
			  975,  973,    0,  974,  975,  970,    0,  972,    0,    0,
			    0,  971,  970,  971,  970,  971,  973,  975,  972,    0,
			  973,    0,    0,  974,  970,  974,  977,  972,  971,  972,
			  977,  976,  975,  973,    0,  974,  975,  978,  976,  972,
			  976,    0,    0,  977,  978,    0,  978,  979,    0,  975,
			  976,  979,    0,  980,    0,  980,  978,    0,  977,    0,
			    0,    0,  977,  976,  979,  980,    0,    0,    0,  978,

			  976,    0,  976,    0,    0,  977,  978,  992,  978,  979,
			    0,  992,  976,  979,  987,  980,  987,  980,  978,  987,
			  987,  987,  987,    0,  992,    0,  979,  980,  989,  989,
			  989,  989,  991,  991,  991,  991,    0,  994,  993,  992,
			    0,  994,  989,  992,    0,  993,  995,  993,  995,  996,
			  997,    0,  997,  996,  994,    0,  992,  993,  995,  998,
			    0,    0,  997,  998,    0,    0,  996,    0,  989,  994,
			  993, 1000,  991,  994,  989, 1000,  998,  993,  995,  993,
			  995,  996,  997,    0,  997,  996,  994,    0, 1000,  993,
			  995,  998,    0,    0,  997,  998,    0,  999,  996,  999, yy_Dummy>>,
			1, 1000, 8000)
		end

	yy_chk_template_10 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			 1001, 1002, 1001, 1000, 1003, 1002, 1003, 1000,  998,  999,
			 1006, 1004, 1001,    0, 1006, 1004, 1003,    0, 1002,    0,
			 1000,    0,    0,    0,    0,    0,    0, 1006, 1004,  999,
			 1004,  999, 1001, 1002, 1001,    0, 1003, 1002, 1003,    0,
			    0,  999, 1006, 1004, 1001,    0, 1006, 1004, 1003, 1005,
			 1002, 1005, 1007,    0, 1007,    0,    0, 1005,    0, 1006,
			 1004, 1005, 1004, 1008, 1007, 1010, 1009, 1008, 1009, 1010,
			 1012,    0, 1009, 1011, 1012, 1011,    0,    0, 1009,    0,
			 1008, 1005, 1010, 1005, 1007, 1011, 1007, 1012,    0, 1005,
			    0,    0,    0, 1005,    0, 1008, 1007, 1010, 1009, 1008,

			 1009, 1010, 1012,    0, 1009, 1011, 1012, 1011,    0, 1013,
			 1009, 1015, 1008, 1015, 1010,    0, 1013, 1011, 1013, 1012,
			 1014, 1016,    0, 1015, 1014, 1016,    0, 1017, 1013, 1017,
			    0,    0, 1018, 1018, 1018, 1018,    0, 1014, 1016, 1017,
			    0, 1013,    0, 1015,    0, 1015,    0,    0, 1013,    0,
			 1013,    0, 1014, 1016,    0, 1015, 1014, 1016,    0, 1017,
			 1013, 1017, 1021, 1021, 1021, 1021,    0,    0,    0, 1014,
			 1016, 1017, 1018, 1022, 1022, 1022, 1022, 1024, 1023, 1024,
			 1025,    0, 1023, 1027, 1025,    0, 1026, 1027, 1026, 1024,
			 1029, 1028,    0, 1028, 1029, 1023,    0, 1025, 1026,    0,

			 1027,    0, 1021, 1028,    0,    0,    0, 1029,    0, 1024,
			 1023, 1024, 1025, 1022, 1023, 1027, 1025,    0, 1026, 1027,
			 1026, 1024, 1029, 1028,    0, 1028, 1029, 1023,    0, 1025,
			 1026, 1030, 1027, 1030,    0, 1028,    0,    0,    0, 1029,
			    0,    0,    0, 1030, 1031, 1031, 1031, 1031, 1038, 1038,
			 1038, 1038, 1038, 1038, 1038, 1038, 1038, 1038, 1038, 1038,
			 1038, 1038,    0, 1030,    0, 1030,    0,    0,    0,    0,
			    0,    0,    0,    0,    0, 1030,    0,    0,    0,    0,
			    0,    0,    0,    0, 1031, 1033, 1033, 1033, 1033, 1033,
			 1033, 1033, 1033, 1033, 1033, 1033, 1033, 1033, 1033, 1033,

			 1033, 1033, 1033, 1033, 1033, 1033, 1033, 1033, 1034, 1034,
			    0, 1034, 1034, 1034, 1034, 1034, 1034, 1034, 1034, 1034,
			 1034, 1034, 1034, 1034, 1034, 1034, 1034, 1034, 1034, 1034,
			 1034, 1035,    0,    0,    0,    0,    0,    0, 1035, 1035,
			 1035, 1035, 1035, 1035, 1035, 1035, 1035, 1035, 1035, 1035,
			 1035, 1035, 1035, 1035, 1036, 1036,    0, 1036, 1036, 1036,
			 1036, 1036, 1036, 1036, 1036, 1036, 1036, 1036, 1036, 1036,
			 1036, 1036, 1036, 1036, 1036, 1036, 1036, 1037, 1037,    0,
			 1037, 1037, 1037, 1037,    0, 1037, 1037, 1037, 1037, 1037,
			 1037, 1037, 1037, 1037, 1037, 1037, 1037, 1037, 1037, 1037,

			 1039, 1039,    0, 1039, 1039, 1039,    0,    0, 1039, 1039,
			 1039, 1039, 1039, 1039, 1039, 1039, 1039, 1039, 1039, 1039,
			 1039, 1039, 1039, 1040, 1040, 1040, 1040, 1040, 1040, 1040,
			 1040, 1040, 1040, 1040, 1040, 1040, 1040, 1041,    0,    0,
			 1041,    0, 1041, 1041, 1041, 1041, 1041, 1041, 1041, 1041,
			 1041, 1041, 1041, 1041, 1041, 1041, 1041, 1041, 1041, 1041,
			 1042, 1042,    0, 1042, 1042, 1042, 1042, 1042, 1042, 1042,
			 1042, 1042, 1042, 1042, 1042, 1042, 1042, 1042, 1042, 1042,
			 1042, 1042, 1042, 1043, 1043,    0, 1043, 1043, 1043, 1043,
			 1043, 1043, 1043, 1043, 1043, 1043, 1043, 1043, 1043, 1043,

			 1043, 1043, 1043, 1043, 1043, 1043, 1044, 1044,    0, 1044,
			 1044, 1044, 1044, 1044, 1044, 1044, 1044, 1044, 1044, 1044,
			 1044, 1044, 1044, 1044, 1044, 1044, 1044, 1044, 1044, 1045,
			    0,    0,    0,    0, 1045, 1045, 1045, 1045, 1045, 1045,
			 1045, 1045, 1045, 1045, 1045, 1045, 1045, 1045, 1045, 1045,
			 1045, 1045, 1046, 1046, 1046, 1046, 1046, 1046, 1046, 1046,
			    0, 1046, 1046, 1046, 1046, 1046, 1046, 1046, 1046, 1046,
			 1046, 1046, 1046, 1046, 1046, 1047, 1047, 1047, 1047, 1047,
			 1047, 1047, 1047, 1047, 1047, 1047, 1047, 1047, 1048, 1048,
			 1048, 1048, 1048, 1048, 1048, 1048, 1048, 1048, 1048, 1048,

			 1048, 1049, 1049, 1049, 1049, 1049, 1049, 1049, 1049, 1049,
			 1049, 1049, 1049, 1049, 1050, 1050,    0, 1050, 1050, 1050,
			    0, 1050, 1050, 1050, 1050, 1050, 1050, 1050, 1050, 1050,
			 1050, 1050, 1050, 1050, 1050, 1050, 1050, 1051, 1051,    0,
			 1051, 1051, 1051,    0, 1051, 1051, 1051, 1051, 1051, 1051,
			 1051, 1051, 1051, 1051, 1051, 1051, 1051, 1051, 1051, 1051,
			 1052, 1052, 1052, 1052, 1052, 1052, 1052, 1052,    0, 1052,
			 1052, 1052, 1052, 1052, 1052, 1052, 1052, 1052, 1052, 1052,
			 1052, 1052, 1052, 1032, 1032, 1032, 1032, 1032, 1032, 1032,
			 1032, 1032, 1032, 1032, 1032, 1032, 1032, 1032, 1032, 1032,

			 1032, 1032, 1032, 1032, 1032, 1032, 1032, 1032, 1032, 1032,
			 1032, 1032, 1032, 1032, 1032, 1032, 1032, 1032, 1032, 1032,
			 1032, 1032, 1032, 1032, 1032, 1032, 1032, 1032, 1032, 1032,
			 1032, 1032, 1032, 1032, 1032, 1032, 1032, 1032, 1032, 1032,
			 1032, 1032, 1032, 1032, 1032, 1032, 1032, 1032, 1032, 1032,
			 1032, 1032, 1032, 1032, 1032, 1032, 1032, 1032, 1032, 1032,
			 1032, 1032, 1032, 1032, 1032, 1032, 1032, 1032, 1032, 1032,
			 1032, 1032, 1032, 1032, 1032, 1032, 1032, 1032, 1032, 1032,
			 1032, 1032, 1032, yy_Dummy>>,
			1, 783, 9000)
		end

	yy_base_template: SPECIAL [INTEGER] is
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make (0, 1052)
			yy_base_template_1 (an_array)
			yy_base_template_2 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_base_template_1 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			    0,    0,    0,   98,  109,  414, 9683,  407,  400,  395,
			  391,  378,  121,    0, 9683,  128,  135, 9683, 9683, 9683,
			 9683, 9683,   87,   87,   97,  126,   99,  150,  355, 9683,
			   99, 9683,  105,  351,  215,  279,  325,  342,  384,  401,
			  291,  451,  301,  392,  448,  426,  472,  473,  499,  494,
			  515,  510,  536, 9683,  308, 9683, 9683,  510,  580,  544,
			  643,  651,  658,  583,  344,  723,  645,  719,  736,  727,
			  773,  776,  781,  547,  800,  794,  827, 9683, 9683,   51,
			  272,   60,   63,   73,   84,  268,  609,  386,  348,  879,
			  408,  886,  899,  820,  828,  848,  858,  868,  909,  919,

			  344,  337,  333,  331, 9683,  979, 9683, 1072, 1036, 1049,
			 1061, 1118, 1131, 1143, 1176, 1188, 1236,    0,  926, 1083,
			 1244, 1255, 1281, 1291, 1301, 1311, 1095,  319, 1404, 1266,
			 1391, 1414, 1162, 1427, 1437, 1447, 9683, 9683, 9683,  284,
			 9683, 9683, 1074, 1529,  649,  100,  179,  321, 1573, 1009,
			  109, 9683, 9683, 9683, 9683, 9683, 9683,  793, 1397, 1550,
			 1536, 1552, 1579, 1581, 1608, 1609, 1622, 1616, 1627,   90,
			  237,   93,  122,  150,  181,  236, 1643, 1670, 1399, 1669,
			 1687, 1680, 1703, 1720, 1685, 1731, 1734, 1738, 1767, 1778,
			 1796, 1779, 1794, 1828, 1821, 1824, 1862, 1839, 1887, 1889,

			 1896, 1888, 1903, 1926, 1947, 1950, 1982, 1956, 1967, 1991,
			 2044, 2005, 2054, 2059, 2059, 2096, 2112, 2102, 2118, 2120,
			 2007, 2158, 2153, 2169, 2168, 2172, 2184, 2215, 2227, 2276,
			 2237, 2193, 2285, 2280, 2301, 2334, 2332, 2333, 2389, 2388,
			 2398, 2405, 2403, 2442, 2400, 2453, 2456, 2457, 9683, 1460,
			 1480, 2295, 2454, 2470, 2480, 2490, 2500,  242,  232,  494,
			  153,  505,  543,  233,  560,  573,  694,  807,  838,  879,
			  967, 2507, 2515, 2525, 2535, 2545, 2555, 2565,  724, 1559,
			 2584, 2620,  316, 2663, 2682, 2689, 1843, 2576, 2696, 2718,
			 2728, 2738, 2761, 2794, 2836, 2768, 2866, 2892, 2902, 2912,

			 2934, 2944, 2964, 2784, 2882, 2919, 2951, 2974, 2984, 3012,
			 3045, 3077, 3092, 3084, 3109, 3117, 3127, 3138, 3148, 3158,
			 3185, 3256, 3283, 3220, 3300, 3313, 3327, 3357, 3377, 3264,
			 3365, 3393, 3407, 3420, 3430, 3446, 9683, 3455, 3466, 3482,
			 3496, 3519, 3535, 3545, 3555, 3571,  305, 3585, 3592, 3635,
			 3608, 3625, 3648, 3660, 3681, 3688, 3697, 3704, 3714, 3724,
			 3737, 3749, 3756, 3777, 3793, 3803, 3813, 3826, 3845, 3855,
			 3866, 3882, 1141, 1027, 1066, 9683, 3275, 1282, 3100, 2687,
			  118,  335,  243, 1295,  216, 3962,  214, 2785, 3075, 3957,
			 2456, 2876, 3070, 3958, 2659, 3968, 2872, 4007, 3251, 4005,

			 3965, 1020, 1112, 1157, 1203, 1222, 1276, 4012, 3258, 4019,
			 4029, 4028, 4058, 4058, 4072, 4082, 4087, 4088, 4122, 4134,
			 4112, 4130, 4136, 4152, 4151, 4176, 4198, 4184, 4200, 4200,
			 4199, 4240, 4253, 4224, 4257, 4265, 4248, 4305, 4308, 4323,
			 4281, 4311, 4367, 4325, 4364, 4369, 4372, 4369, 4415, 4410,
			 4429, 4430, 4433, 4431, 4477, 4482, 4474, 4486, 4487, 4534,
			 4530, 4545, 4541, 4546, 4556, 4598, 4603, 4555, 4557, 4619,
			 4621, 4652, 4627, 4667, 4670, 4664, 4703, 4716, 4717, 4662,
			 4720, 4731, 4764, 4780, 4770, 4785, 4781, 4791, 4824, 4814,
			 4838, 4841, 4848, 4869, 4886, 4896, 4897, 4898, 4935, 4949,

			 4912, 4939, 4950, 9683, 4946, 4963, 4970, 4978, 4988, 4998,
			 1328, 1376, 1382, 1389, 1402, 1424, 1649, 1698, 9683, 3385,
			 3439, 5009, 5019, 5029, 5039, 5063, 9683, 3764, 3834, 5091,
			 5104, 5132, 5142, 5156, 5163, 5170, 5202, 5209, 5268, 5278,
			 5307, 5314, 5321, 5328, 5338, 5376, 3785, 4954, 5345, 5383,
			 5438, 5455, 5445, 5476, 5483, 5490, 5500, 5510, 5554, 5604,
			 5611, 5618, 5536, 5625, 5632, 5643, 5653, 5663, 9683, 9683,
			 9683, 9683, 9683, 5752, 9683, 9683, 9683, 9683, 9683, 9683,
			 9683, 9683, 9683, 9683, 9683, 9683, 9683, 9683, 9683, 9683,
			 5721, 5765, 5744, 1984, 2389, 2275, 5761, 2827, 2324, 2381,

			 3325, 5768, 3654,  441,  141, 1971,  128,    0,  106, 5269,
			 5503, 5610, 5824, 5806, 5828, 5844, 5847, 5864, 5876, 1969,
			 2066, 5891, 5899, 5907, 5935, 5611, 5924, 5932, 5875, 5955,
			 5971, 5989, 5986, 5996, 6023, 6035, 6036, 6001, 6040, 6056,
			 6070, 6085, 6086, 6090, 6100, 6110, 6121, 6116, 6140, 6150,
			 6158, 6158, 6166, 6180, 6185, 6187, 6204, 6214, 6211, 6235,
			 6247, 6244, 6264, 6274, 6272, 6282, 6290, 6294, 6309, 6308,
			 6323, 6324, 6336, 6358, 6340, 6338, 6354, 6372, 6398, 6373,
			 6406, 6422, 6400, 6431, 6439, 6453, 6463, 6460, 6470, 6499,
			 6517, 6509, 6501, 6523, 6552, 6567, 6575, 6570, 6600, 6610,

			 6581, 6631, 6621, 6633, 6628, 6670, 6649, 6681, 6677, 6699,
			 6666, 6691, 6715, 6737, 6701, 6745, 6740, 6724, 6737, 2072,
			 2174, 5047, 6748, 6757, 6766, 6778, 6788, 6795, 6802, 6819,
			 6830, 6841, 6851, 6900, 6949, 6956, 6963, 6981, 6912, 6970,
			 6919, 6941, 7008, 3130, 3547, 2534, 3177, 7050, 3247, 3577,
			 3307, 3600, 3421, 5493, 6961, 7051, 7046, 7061, 7047, 7081,
			 7092, 7095, 7110, 7125, 7093, 7141, 7109, 7146, 7149, 7167,
			 7189, 7201, 7168, 7222, 7197, 7224, 7204, 7231, 7259, 7257,
			 7265, 7262, 7272, 7286, 7310, 7326, 7321, 7324, 7325, 7342,
			 7334, 7350, 7374, 7384, 7389, 7390, 7395, 7392, 7400, 7448,

			 7438, 7458, 7466, 7459, 7490, 7470, 7499, 7514, 7513, 7523,
			 7530, 7534, 7551, 7561, 7569, 7567, 7577, 7587, 7594, 7611,
			 7618, 7621, 7629, 7658, 7668, 7676, 7643, 7678, 7705, 7685,
			 7720, 7722, 7692, 7732, 7765, 7738, 7773, 7762, 7746, 7800,
			 7769, 7774, 7790, 7806, 7813, 7826, 9683, 5374, 3689, 3474,
			   95, 6546, 3805, 3673, 3716, 3947, 3741, 5481, 7893, 7896,
			 7888, 7898, 7894, 7904, 7941, 7944, 7958, 7946, 7954, 7966,
			 7995, 8012, 8009, 8019, 8014, 8024, 8020, 8030, 8063, 8077,
			 8059, 8080, 8078, 8083, 8094, 8124, 8123, 8127, 8129, 8154,
			 8142, 8188, 8170, 8191, 8183, 8200, 8218, 8243, 8233, 8251,

			 8254, 8253, 8280, 8307, 8285, 8314, 8299, 8315, 8325, 8317,
			 8354, 8357, 8349, 8369, 8365, 8379, 8389, 8419, 8403, 8439,
			 8414, 8381, 8418, 8445, 8463, 4397, 5009, 5222, 5545, 5646,
			 5673, 5535,  368, 5658, 5662, 5780, 9683, 8499, 7005, 8483,
			 8482, 8507, 8499, 8513, 8525, 8546, 8542, 8557, 8556, 8573,
			 8591, 8596, 8575, 8612, 8604, 8621, 8620, 8650, 8649, 8664,
			 8660, 8674, 8666, 8680, 8707, 8722, 8720, 8728, 8723, 8740,
			 8769, 8779, 8784, 8784, 8780, 8800, 8827, 8826, 8833, 8847,
			 8842,   74, 5785, 7873, 5802, 5812, 5821, 8899,   63, 8908,
			 7009, 8912, 8877, 8904, 8907, 8905, 8919, 8909, 8929, 8956, yy_Dummy>>,
			1, 1000, 0)
		end

	yy_base_template_2 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			 8941, 8959, 8971, 8963, 8981, 9008, 8980, 9011, 9033, 9025,
			 9035, 9032, 9040, 9075, 9090, 9070, 9091, 9086, 9112,   46,
			 7195, 9142, 9153, 9148, 9136, 9150, 9145, 9153, 9150, 9160,
			 9190, 9224, 9683, 9284, 9307, 9330, 9353, 9376, 9239, 9399,
			 9413, 9436, 9459, 9482, 9505, 9528, 9551, 9565, 9578, 9591,
			 9613, 9636, 9659, yy_Dummy>>,
			1, 53, 1000)
		end

	yy_def_template: SPECIAL [INTEGER] is
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make (0, 1052)
			yy_def_template_1 (an_array)
			yy_def_template_2 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_def_template_1 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			    0, 1032,    1, 1033, 1033, 1032, 1032, 1032, 1032, 1032,
			 1032, 1032, 1034, 1035, 1032, 1036, 1037, 1032, 1032, 1032,
			 1032, 1032, 1032, 1032, 1032, 1038, 1038, 1038, 1032, 1032,
			 1032, 1032, 1032, 1032, 1032,   34,   34,   36,   34,   36,
			   39,   39,   39,   39,   39,   39,   39,   39,   39,   39,
			   39,   39,   39, 1032, 1032, 1032, 1032, 1039, 1040, 1040,
			 1040, 1040, 1040,   62,   62,   62,   62,   62,   62,   62,
			   62,   62,   62,   62,   62,   62,   62, 1032, 1032, 1032,
			 1032, 1032, 1032, 1032, 1032, 1032, 1041, 1032, 1032, 1041,
			 1032, 1042, 1043, 1041, 1041, 1041, 1041, 1041, 1041, 1041,

			 1032, 1032, 1032, 1032, 1032, 1034, 1032, 1044, 1034, 1034,
			 1034, 1034, 1034, 1034, 1034, 1034, 1034, 1035, 1036, 1036,
			 1036, 1036, 1036, 1036, 1036, 1036, 1045, 1032, 1045, 1045,
			 1045, 1045, 1045, 1045, 1045, 1045, 1032, 1032, 1032, 1032,
			 1032, 1032, 1046, 1038, 1038, 1038, 1047, 1048, 1049, 1038,
			 1038, 1032, 1032, 1032, 1032, 1032, 1032,   39,   39,   39,
			   39,   39,   39,   62,   62,   62,   62,   62,   62, 1032,
			 1032, 1032, 1032, 1032, 1032, 1032,   39,   62,   39,   39,
			   39,   39,   39,   62,   62,   62,   62,   62,   39,   39,
			   62,   62,   39,   39,   39,   62,   62,   62,   39,   39,

			   39,   62,   62,   62,   39,   39,   41,   39,   62,   62,
			   62,   62,   39,   39,   62,   62,   39,   62,   39,   39,
			   39,   39,   62,   62,   62,   62,   39,   62,   41,   62,
			   39,   39,   62,   62,   39,   39,   62,   62,   39,   62,
			   39,   39,   62,   62,   39,   62,   39,   62, 1032, 1039,
			 1039, 1039, 1039, 1039, 1039, 1039, 1039, 1032, 1032, 1032,
			 1032, 1032, 1032, 1032, 1032, 1032, 1032, 1032, 1032, 1032,
			 1041, 1041, 1041, 1041, 1041, 1041, 1041, 1041, 1032, 1032,
			 1050, 1051, 1032, 1041, 1042, 1043, 1032, 1041, 1042, 1042,
			 1042, 1042, 1042, 1042, 1042, 1041, 1043, 1043, 1043, 1043,

			 1043, 1043, 1043, 1041, 1041, 1041, 1041, 1041, 1041, 1044,
			 1036, 1036, 1044, 1044, 1044, 1044, 1044, 1044, 1044, 1044,
			 1044, 1034, 1034, 1034, 1034, 1034, 1034, 1034, 1034, 1036,
			 1036, 1036, 1036, 1036, 1036, 1045, 1032, 1045, 1045, 1045,
			 1045, 1045, 1045, 1045, 1045, 1045, 1032, 1045, 1045, 1045,
			 1045, 1045, 1045, 1045, 1045, 1045, 1045, 1045, 1045, 1045,
			 1045, 1045, 1045, 1045, 1045, 1045, 1045, 1045, 1045, 1045,
			 1045, 1045, 1032, 1032, 1032, 1032, 1032, 1032, 1038, 1038,
			 1038, 1047, 1047, 1048, 1048, 1049, 1049, 1038, 1038,   39,
			   62,   39,   39,   62,   62,   39,   62,   39,   62,   39,

			   62, 1032, 1032, 1032, 1032, 1032, 1032,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   39,   62,   62,   39,   62,   39,   39,   62,   62,   39,
			   39,   62,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   39,   39,   39,   39,   62,   62,   62,   62,
			   62,   39,   62,   39,   39,   62,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   39,   39,
			   39,   39,   39,   62,   62,   62,   62,   62,   62,   39,
			   39,   62,   62,   39,   62,   39,   62,   39,   62,   39,
			   39,   39,   62,   62,   62,   39,   62,   39,   62,   39,

			   62,   39,   62, 1032, 1039, 1039, 1039, 1039, 1039, 1039,
			 1032, 1032, 1032, 1032, 1032, 1032, 1032, 1032, 1032, 1050,
			 1050, 1050, 1050, 1050, 1050, 1050, 1032, 1051, 1051, 1051,
			 1051, 1051, 1051, 1051, 1042, 1042, 1042, 1042, 1042, 1042,
			 1043, 1043, 1043, 1043, 1043, 1043, 1041, 1041, 1044, 1044,
			 1044, 1044, 1044, 1044, 1044, 1044, 1044, 1044, 1034, 1034,
			 1036, 1036, 1045, 1045, 1045, 1045, 1045, 1045, 1032, 1032,
			 1032, 1032, 1032, 1045, 1032, 1032, 1032, 1032, 1032, 1032,
			 1032, 1032, 1032, 1032, 1032, 1032, 1032, 1032, 1032, 1032,
			 1045, 1045, 1032, 1032, 1032, 1032, 1032, 1032, 1032, 1032,

			 1032, 1038, 1038, 1047, 1047, 1048, 1048,  385, 1049, 1038,
			 1038,   39,   62,   39,   62,   39,   62,   39,   62, 1032,
			 1032,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   39,   62,   62,   39,   62,   39,   62,   39,   62,   39,
			   39,   62,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   39,   62,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   39,   62,   62,   39,   62,   39,   62,   39,   62,   39,

			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62, 1039, 1039, 1032,
			 1032, 1050, 1050, 1050, 1050, 1050, 1050, 1051, 1051, 1051,
			 1051, 1051, 1051, 1042, 1042, 1043, 1043, 1044, 1044, 1044,
			 1045, 1045, 1045, 1032, 1032, 1032, 1032, 1032, 1032, 1032,
			 1032, 1032, 1032, 1046, 1038,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,

			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62, 1050, 1050, 1051, 1051, 1044, 1032, 1032, 1032, 1032,
			 1032, 1032, 1032, 1032, 1032, 1032, 1032, 1032, 1052,   39,
			   62,   39,   62,   39,   62,   39,   39,   62,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,

			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62, 1032, 1032, 1032, 1032, 1032,
			 1032, 1032, 1032, 1032, 1032, 1032, 1032, 1032, 1032,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62, 1032, 1032, 1032, 1032, 1032, 1032, 1032, 1032, 1032,
			 1032, 1032,   39,   62,   39,   62,   39,   62,   39,   62, yy_Dummy>>,
			1, 1000, 0)
		end

	yy_def_template_2 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			   39,   62,   39,   62,   39,   62,   39,   62,   39,   62,
			   39,   62,   39,   62,   39,   62,   39,   62, 1032, 1032,
			 1032, 1032, 1032,   39,   62,   39,   62,   39,   62,   39,
			   62, 1032,    0, 1032, 1032, 1032, 1032, 1032, 1032, 1032,
			 1032, 1032, 1032, 1032, 1032, 1032, 1032, 1032, 1032, 1032,
			 1032, 1032, 1032, yy_Dummy>>,
			1, 53, 1000)
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
			create an_array.make (0, 1033)
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
			  351,  353,  356,  358,  359,  360,  361,  362,  364,  365,
			  365,  365,  365,  365,  365,  365,  365,  367,  368,  370,
			  372,  374,  376,  378,  379,  380,  381,  382,  383,  385,
			  388,  389,  391,  393,  395,  397,  398,  399,  400,  402,

			  404,  406,  407,  408,  409,  412,  414,  416,  419,  421,
			  422,  423,  425,  427,  429,  430,  431,  433,  434,  436,
			  438,  440,  443,  444,  445,  446,  448,  450,  451,  453,
			  454,  456,  458,  459,  460,  462,  464,  465,  466,  468,
			  469,  471,  473,  474,  475,  477,  478,  480,  481,  482,
			  482,  482,  482,  482,  482,  482,  482,  482,  482,  482,
			  482,  482,  482,  482,  482,  482,  482,  482,  482,  482,
			  482,  483,  484,  485,  486,  487,  488,  489,  490,  491,
			  491,  491,  491,  492,  494,  495,  496,  497,  499,  500,
			  501,  502,  503,  504,  505,  506,  508,  509,  510,  511,

			  512,  513,  514,  515,  516,  517,  518,  519,  520,  521,
			  521,  523,  525,  525,  525,  525,  525,  525,  525,  525,
			  525,  525,  527,  529,  530,  531,  532,  533,  534,  535,
			  536,  537,  538,  539,  540,  541,  542,  543,  544,  545,
			  546,  547,  548,  549,  550,  551,  552,  552,  553,  554,
			  555,  556,  557,  558,  559,  560,  561,  562,  563,  564,
			  565,  566,  567,  568,  569,  570,  571,  572,  573,  574,
			  575,  576,  577,  579,  579,  579,  580,  582,  583,  585,
			  587,  587,  590,  592,  595,  597,  600,  602,  604,  604,
			  606,  607,  609,  612,  613,  615,  618,  620,  622,  623,

			  625,  626,  626,  626,  626,  626,  626,  626,  629,  631,
			  633,  634,  636,  637,  639,  640,  642,  643,  645,  646,
			  648,  650,  651,  652,  654,  655,  658,  660,  662,  663,
			  665,  667,  668,  669,  671,  672,  674,  675,  677,  678,
			  680,  681,  683,  685,  687,  689,  691,  692,  693,  694,
			  695,  696,  698,  699,  701,  703,  704,  705,  708,  710,
			  712,  713,  716,  718,  720,  721,  723,  724,  726,  728,
			  730,  732,  734,  736,  737,  738,  739,  740,  741,  742,
			  744,  746,  747,  748,  750,  751,  753,  754,  756,  757,
			  759,  761,  763,  764,  765,  766,  768,  769,  771,  772,

			  774,  775,  778,  780,  781,  781,  781,  781,  781,  781,
			  781,  781,  781,  781,  781,  781,  781,  781,  781,  782,
			  782,  782,  782,  782,  782,  782,  782,  783,  783,  783,
			  783,  783,  783,  783,  783,  784,  785,  786,  787,  788,
			  789,  790,  791,  792,  793,  794,  795,  796,  797,  798,
			  799,  799,  800,  800,  800,  800,  800,  800,  800,  801,
			  802,  803,  804,  805,  806,  807,  808,  809,  810,  811,
			  812,  813,  814,  815,  816,  817,  818,  819,  820,  821,
			  822,  823,  824,  825,  826,  827,  828,  829,  830,  831,
			  832,  833,  834,  836,  836,  838,  838,  840,  840,  840,

			  840,  842,  844,  846,  846,  846,  846,  846,  846,  846,
			  848,  850,  852,  853,  855,  856,  858,  859,  861,  862,
			  862,  862,  864,  865,  867,  868,  870,  871,  873,  874,
			  876,  877,  879,  880,  882,  883,  886,  888,  890,  891,
			  893,  895,  896,  897,  899,  900,  902,  903,  905,  906,
			  909,  911,  913,  914,  916,  917,  919,  920,  922,  923,
			  925,  926,  928,  929,  931,  932,  935,  937,  939,  940,
			  943,  945,  948,  950,  952,  953,  956,  958,  960,  962,
			  963,  964,  966,  967,  969,  970,  972,  973,  975,  976,
			  978,  980,  981,  982,  984,  985,  987,  988,  990,  991,

			  993,  994,  997,  999, 1002, 1004, 1006, 1007, 1009, 1010,
			 1012, 1013, 1015, 1016, 1019, 1021, 1024, 1026, 1026, 1026,
			 1026, 1026, 1026, 1026, 1026, 1026, 1026, 1026, 1026, 1026,
			 1026, 1026, 1026, 1026, 1027, 1028, 1029, 1030, 1030, 1030,
			 1030, 1031, 1032, 1033, 1034, 1036, 1036, 1036, 1038, 1038,
			 1042, 1042, 1044, 1044, 1044, 1046, 1049, 1051, 1054, 1056,
			 1058, 1059, 1061, 1062, 1065, 1067, 1070, 1072, 1074, 1075,
			 1077, 1078, 1080, 1081, 1084, 1086, 1088, 1089, 1091, 1092,
			 1094, 1095, 1097, 1098, 1100, 1101, 1103, 1104, 1107, 1109,
			 1111, 1112, 1114, 1115, 1117, 1118, 1120, 1121, 1124, 1126,

			 1128, 1129, 1131, 1132, 1134, 1135, 1138, 1140, 1142, 1143,
			 1145, 1146, 1148, 1149, 1151, 1152, 1154, 1155, 1157, 1158,
			 1160, 1161, 1163, 1164, 1166, 1167, 1170, 1172, 1174, 1175,
			 1177, 1178, 1181, 1183, 1185, 1186, 1188, 1189, 1192, 1194,
			 1196, 1197, 1197, 1197, 1197, 1197, 1197, 1198, 1198, 1200,
			 1200, 1201, 1202, 1206, 1206, 1206, 1208, 1208, 1209, 1209,
			 1212, 1214, 1216, 1217, 1219, 1220, 1223, 1225, 1227, 1228,
			 1230, 1231, 1233, 1234, 1237, 1239, 1242, 1244, 1246, 1247,
			 1250, 1252, 1254, 1255, 1257, 1258, 1261, 1263, 1265, 1266,
			 1268, 1269, 1271, 1272, 1274, 1275, 1277, 1278, 1280, 1281,

			 1283, 1284, 1287, 1289, 1291, 1292, 1294, 1295, 1298, 1300,
			 1302, 1303, 1306, 1308, 1311, 1313, 1316, 1318, 1320, 1321,
			 1323, 1324, 1327, 1329, 1331, 1332, 1332, 1333, 1333, 1333,
			 1333, 1337, 1337, 1338, 1339, 1339, 1339, 1340, 1341, 1342,
			 1344, 1345, 1348, 1350, 1352, 1353, 1356, 1358, 1360, 1361,
			 1363, 1364, 1366, 1367, 1370, 1372, 1375, 1377, 1379, 1380,
			 1383, 1385, 1388, 1390, 1392, 1393, 1395, 1396, 1398, 1399,
			 1401, 1402, 1404, 1405, 1408, 1410, 1412, 1413, 1415, 1416,
			 1419, 1421, 1422, 1422, 1423, 1423, 1425, 1425, 1425, 1426,
			 1427, 1427, 1428, 1430, 1431, 1434, 1436, 1439, 1441, 1444, yy_Dummy>>,
			1, 1000, 0)
		end

	yy_accept_template_2 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			 1446, 1449, 1451, 1454, 1456, 1458, 1459, 1462, 1464, 1466,
			 1467, 1470, 1472, 1474, 1475, 1478, 1480, 1483, 1485, 1486,
			 1488, 1488, 1490, 1491, 1494, 1496, 1499, 1501, 1504, 1506,
			 1509, 1511, 1513, 1513, yy_Dummy>>,
			1, 34, 1000)
		end

	yy_acclist_template: SPECIAL [INTEGER] is
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make (0, 1512)
			yy_acclist_template_1 (an_array)
			yy_acclist_template_2 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_acclist_template_1 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			    0,  139,  139,  160,  158,  159,    3,  158,  159,    4,
			  159,    1,  158,  159,    2,  158,  159,   10,  158,  159,
			  141,  158,  159,  106,  158,  159,   17,  158,  159,  141,
			  158,  159,  158,  159,   11,  158,  159,   12,  158,  159,
			   31,  158,  159,   30,  158,  159,    8,  158,  159,   29,
			  158,  159,    6,  158,  159,   32,  158,  159,  143,  150,
			  158,  159,  143,  150,  158,  159,  143,  150,  158,  159,
			    9,  158,  159,    7,  158,  159,   36,  158,  159,   34,
			  158,  159,   35,  158,  159,  158,  159,  104,  105,  158,
			  159,  104,  105,  158,  159,  104,  105,  158,  159,  104,

			  105,  158,  159,  104,  105,  158,  159,  104,  105,  158,
			  159,  104,  105,  158,  159,  104,  105,  158,  159,  104,
			  105,  158,  159,  104,  105,  158,  159,  104,  105,  158,
			  159,  104,  105,  158,  159,  104,  105,  158,  159,  104,
			  105,  158,  159,  104,  105,  158,  159,  104,  105,  158,
			  159,  104,  105,  158,  159,  104,  105,  158,  159,  104,
			  105,  158,  159,   15,  158,  159,  158,  159,   16,  158,
			  159,   33,  158,  159,  158,  159,  105,  158,  159,  105,
			  158,  159,  105,  158,  159,  105,  158,  159,  105,  158,
			  159,  105,  158,  159,  105,  158,  159,  105,  158,  159,

			  105,  158,  159,  105,  158,  159,  105,  158,  159,  105,
			  158,  159,  105,  158,  159,  105,  158,  159,  105,  158,
			  159,  105,  158,  159,  105,  158,  159,  105,  158,  159,
			  105,  158,  159,   13,  158,  159,   14,  158,  159,  158,
			  159,  158,  159,  158,  159,  158,  159,  158,  159,  158,
			  159,  158,  159,  139,  159,  137,  159,  138,  159,  133,
			  139,  159,  136,  159,  139,  159,  139,  159,  139,  159,
			  139,  159,  139,  159,  139,  159,  139,  159,  139,  159,
			  139,  159,    3,    4,    1,    2,   37,  141,  140,  140,
			 -131,  141, -290, -132,  141, -291,  141,  141,  141,  141,

			  141,  141,  141,  106,  141,  141,  141,  141,  141,  141,
			  141,  141,  130,  130,  130,  130,  130,  130,  130,  130,
			  130,    5,   23,   24,  153,  156,   18,   20,  143,  150,
			  143,  150,  150,  142,  150,  150,  150,  142,  150,   28,
			   25,   22,   21,   26,   27,  104,  105,  104,  105,  104,
			  105,  104,  105,   42,  104,  105,  104,  105,  105,  105,
			  105,  105,   42,  105,  105,  104,  105,  105,  104,  105,
			  104,  105,  104,  105,  104,  105,  104,  105,  105,  105,
			  105,  105,  105,  104,  105,   54,  104,  105,  105,   54,
			  105,  104,  105,  104,  105,  104,  105,  105,  105,  105,

			  104,  105,  104,  105,  104,  105,  105,  105,  105,   66,
			  104,  105,  104,  105,  104,  105,   73,  104,  105,   66,
			  105,  105,  105,   73,  105,  104,  105,  104,  105,  105,
			  105,  104,  105,  105,  104,  105,  104,  105,  104,  105,
			   82,  104,  105,  105,  105,  105,   82,  105,  104,  105,
			  105,  104,  105,  105,  104,  105,  104,  105,  105,  105,
			  104,  105,  104,  105,  105,  105,  104,  105,  105,  104,
			  105,  104,  105,  105,  105,  104,  105,  105,  104,  105,
			  105,   19,  139,  139,  139,  139,  139,  139,  139,  139,
			  137,  138,  133,  139,  139,  139,  136,  134,  139,  139,

			  139,  139,  139,  139,  139,  139,  135,  139,  139,  139,
			  139,  139,  139,  139,  139,  139,  139,  139,  139,  139,
			  139,  140,  141,  140,  141, -131,  141, -132,  141,  141,
			  141,  141,  141,  141,  141,  141,  141,  141,  141,  141,
			  141,  130,  107,  130,  130,  130,  130,  130,  130,  130,
			  130,  130,  130,  130,  130,  130,  130,  130,  130,  130,
			  130,  130,  130,  130,  130,  130,  130,  130,  130,  130,
			  130,  130,  130,  130,  130,  130,  130,  153,  156,  151,
			  153,  156,  151,  143,  150,  143,  150,  146,  149,  150,
			  149,  150,  145,  148,  150,  148,  150,  144,  147,  150,

			  147,  150,  143,  150,  104,  105,  105,  104,  105,   40,
			  104,  105,  105,   40,  105,   41,  104,  105,   41,  105,
			  104,  105,  105,  104,  105,  105,   45,  104,  105,   45,
			  105,  104,  105,  105,  104,  105,  105,  104,  105,  105,
			  104,  105,  105,  104,  105,  105,  104,  105,  104,  105,
			  105,  105,  104,  105,  105,   57,  104,  105,  104,  105,
			   57,  105,  105,  104,  105,  104,  105,  105,  105,  104,
			  105,  105,  104,  105,  105,  104,  105,  105,  104,  105,
			  105,  104,  105,  104,  105,  104,  105,  104,  105,  104,
			  105,  105,  105,  105,  105,  105,  104,  105,  105,  104,

			  105,  104,  105,  105,  105,   77,  104,  105,   77,  105,
			  104,  105,  105,   80,  104,  105,   80,  105,  104,  105,
			  105,  104,  105,  105,  104,  105,  104,  105,  104,  105,
			  104,  105,  104,  105,  104,  105,  105,  105,  105,  105,
			  105,  105,  104,  105,  104,  105,  105,  105,  104,  105,
			  105,  104,  105,  105,  104,  105,  105,  104,  105,  104,
			  105,  104,  105,  105,  105,  105,  104,  105,  105,  104,
			  105,  105,  104,  105,  105,  103,  104,  105,  103,  105,
			  157,  134,  135,  139,  139,  139,  139,  139,  139,  139,
			  139,  139,  139,  139,  139,  139,  139,  140,  140,  140,

			  141,  141,  141,  141,  130,  130,  130,  130,  130,  130,
			  124,  122,  123,  125,  126,  130,  127,  128,  108,  109,
			  110,  111,  112,  113,  114,  115,  116,  117,  118,  119,
			  120,  121,  130,  130,  153,  156,  153,  156,  153,  156,
			  152,  155,  143,  150,  143,  150,  143,  150,  143,  150,
			  104,  105,  105,  104,  105,  105,  104,  105,  105,  104,
			  105,  105,  104,  105,  105,  104,  105,  105,  104,  105,
			  105,  104,  105,  105,  104,  105,  105,  104,  105,  105,
			  104,  105,  105,   55,  104,  105,   55,  105,  104,  105,
			  105,  104,  105,  104,  105,  105,  105,  104,  105,  105,

			  104,  105,  105,  104,  105,  105,   64,  104,  105,  104,
			  105,   64,  105,  105,  104,  105,  105,  104,  105,  105,
			  104,  105,  105,  104,  105,  105,  104,  105,  105,  104,
			  105,  105,   74,  104,  105,   74,  105,  104,  105,  105,
			   76,  104,  105,   76,  105,   78,  104,  105,   78,  105,
			  104,  105,  105,   81,  104,  105,   81,  105,  104,  105,
			  104,  105,  105,  105,  104,  105,  105,  104,  105,  105,
			  104,  105,  105,  104,  105,  105,  104,  105,  104,  105,
			  105,  105,  104,  105,  105,  104,  105,  105,  104,  105,
			  105,  104,  105,  105,   95,  104,  105,   95,  105,   96, yy_Dummy>>,
			1, 1000, 0)
		end

	yy_acclist_template_2 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			  104,  105,   96,  105,  104,  105,  105,  104,  105,  105,
			  104,  105,  105,  104,  105,  105,  101,  104,  105,  101,
			  105,  102,  104,  105,  102,  105,  139,  139,  139,  139,
			  130,  130,  130,  153,  153,  156,  153,  156,  152,  153,
			  155,  156,  152,  155,  143,  150,   38,  104,  105,   38,
			  105,   39,  104,  105,   39,  105,  104,  105,  105,  104,
			  105,  105,   46,  104,  105,   46,  105,   47,  104,  105,
			   47,  105,  104,  105,  105,  104,  105,  105,  104,  105,
			  105,   52,  104,  105,   52,  105,  104,  105,  105,  104,
			  105,  105,  104,  105,  105,  104,  105,  105,  104,  105,

			  105,  104,  105,  105,   62,  104,  105,   62,  105,  104,
			  105,  105,  104,  105,  105,  104,  105,  105,  104,  105,
			  105,   69,  104,  105,   69,  105,  104,  105,  105,  104,
			  105,  105,  104,  105,  105,   75,  104,  105,   75,  105,
			  104,  105,  105,  104,  105,  105,  104,  105,  105,  104,
			  105,  105,  104,  105,  105,  104,  105,  105,  104,  105,
			  105,  104,  105,  105,  104,  105,  105,   91,  104,  105,
			   91,  105,  104,  105,  105,  104,  105,  105,   94,  104,
			  105,   94,  105,  104,  105,  105,  104,  105,  105,   99,
			  104,  105,   99,  105,  104,  105,  105,  129,  153,  156,

			  156,  153,  152,  153,  155,  156,  152,  155,  151,   43,
			  104,  105,   43,  105,  104,  105,  105,  104,  105,  105,
			   49,  104,  105,  104,  105,   49,  105,  105,  104,  105,
			  105,  104,  105,  105,   56,  104,  105,   56,  105,   58,
			  104,  105,   58,  105,  104,  105,  105,   60,  104,  105,
			   60,  105,  104,  105,  105,  104,  105,  105,   65,  104,
			  105,   65,  105,  104,  105,  105,  104,  105,  105,  104,
			  105,  105,  104,  105,  105,  104,  105,  105,  104,  105,
			  105,  104,  105,  105,   84,  104,  105,   84,  105,  104,
			  105,  105,  104,  105,  105,   87,  104,  105,   87,  105,

			  104,  105,  105,   89,  104,  105,   89,  105,   90,  104,
			  105,   90,  105,   92,  104,  105,   92,  105,  104,  105,
			  105,  104,  105,  105,   98,  104,  105,   98,  105,  104,
			  105,  105,  153,  152,  153,  155,  156,  156,  152,  154,
			  156,  154,  104,  105,  105,   48,  104,  105,   48,  105,
			  104,  105,  105,   51,  104,  105,   51,  105,  104,  105,
			  105,  104,  105,  105,  104,  105,  105,   63,  104,  105,
			   63,  105,   67,  104,  105,   67,  105,  104,  105,  105,
			   70,  104,  105,   70,  105,   71,  104,  105,   71,  105,
			  104,  105,  105,  104,  105,  105,  104,  105,  105,  104,

			  105,  105,  104,  105,  105,   88,  104,  105,   88,  105,
			  104,  105,  105,  104,  105,  105,  100,  104,  105,  100,
			  105,  156,  156,  152,  153,  155,  156,  155,  104,  105,
			  105,   50,  104,  105,   50,  105,   53,  104,  105,   53,
			  105,   59,  104,  105,   59,  105,   61,  104,  105,   61,
			  105,   68,  104,  105,   68,  105,  104,  105,  105,   79,
			  104,  105,   79,  105,  104,  105,  105,   86,  104,  105,
			   86,  105,  104,  105,  105,   93,  104,  105,   93,  105,
			   97,  104,  105,   97,  105,  156,  155,  156,  155,  156,
			  155,   44,  104,  105,   44,  105,   72,  104,  105,   72,

			  105,   83,  104,  105,   83,  105,   85,  104,  105,   85,
			  105,  155,  156, yy_Dummy>>,
			1, 513, 1000)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER is 9683
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER is 1032
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER is 1033
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

	yyNb_rules: INTEGER is 159
			-- Number of rules

	yyEnd_of_buffer: INTEGER is 160
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
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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
