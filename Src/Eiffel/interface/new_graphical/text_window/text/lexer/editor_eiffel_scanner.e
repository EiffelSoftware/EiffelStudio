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
					
when 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105 then
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
										
when 106 then
--|#line 211 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 211")
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
										
when 107 then
--|#line 231 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 231")
end

										if not in_comments then
											curr_token := new_text (text)											
										else
											curr_token := new_comment (text)
										end
										update_token_list
										
when 108 then
--|#line 243 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 243")
end

										if not in_comments then
											curr_token := new_text (text)										
										else
											curr_token := new_comment (text)
										end
										update_token_list
										
when 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130 then
--|#line 257 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 257")
end

					if not in_comments then
						curr_token := new_character (text)
					else
						curr_token := new_comment (text)
					end
					update_token_list
					
when 131 then
--|#line 287 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 287")
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
					
when 132 then
--|#line 302 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 302")
end

					-- Character error. Catch-all rules (no backing up)
					if not in_comments then
						curr_token := new_text (text)
					else
						curr_token := new_comment (text)
					end
					update_token_list
					
when 133 then
--|#line 324 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 324")
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
			
when 134 then
--|#line 338 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 338")
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
			
when 135 then
--|#line 353 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 353")
end
-- Ignore carriage return
when 136 then
--|#line 354 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 354")
end

							-- Verbatim string closer, possibly.
						curr_token := new_string (text)						
						end_of_verbatim_string := True
						in_verbatim_string := False
						set_start_condition (INITIAL)
						update_token_list
					
when 137 then
--|#line 363 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 363")
end

							-- Verbatim string closer, possibly.
						curr_token := new_string (text)						
						end_of_verbatim_string := True
						in_verbatim_string := False
						set_start_condition (INITIAL)
						update_token_list
					
when 138 then
--|#line 372 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 372")
end

						curr_token := new_space (text_count)
						update_token_list						
					
when 139 then
--|#line 377 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 377")
end
						
						curr_token := new_tabulation (text_count)
						update_token_list						
					
when 140 then
--|#line 382 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 382")
end

						from i_ := 1 until i_ > text_count loop
							curr_token := new_eol
							update_token_list
							i_ := i_ + 1
						end						
					
when 141 then
--|#line 390 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 390")
end

						curr_token := new_string (text)
						update_token_list
					
when 142, 143 then
--|#line 396 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 396")
end

					-- Eiffel String
					if not in_comments then						
						curr_token := new_string (text)
					else
						curr_token := new_comment (text)
					end
					update_token_list
					
when 144 then
--|#line 409 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 409")
end

					-- Eiffel Bit
					if not in_comments then
						curr_token := new_number (text)						
					else
						curr_token := new_comment (text)
					end
					update_token_list
					
when 145, 146, 147, 148 then
--|#line 421 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 421")
end

						-- Eiffel Integer
						if not in_comments then
							curr_token := new_number (text)
						else
							curr_token := new_comment (text)
						end
						update_token_list
						
when 149, 150, 151, 152 then
--|#line 435 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 435")
end

						-- Bad Eiffel Integer
						if not in_comments then
							curr_token := new_text (text)
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
	yy_end := yy_end - 1
--|#line 453 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 453")
end

							-- Eiffel reals & doubles
						if not in_comments then		
							curr_token := new_number (text)
						else
							curr_token := new_comment (text)
						end
						update_token_list
						
when 157, 158 then
--|#line 454 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 454")
end

							-- Eiffel reals & doubles
						if not in_comments then		
							curr_token := new_number (text)
						else
							curr_token := new_comment (text)
						end
						update_token_list
						
when 159 then
--|#line 471 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 471")
end

					curr_token := new_text (text)
					update_token_list
					
when 160 then
--|#line 479 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 479")
end

					-- Error (considered as text)
				if not in_comments then
					curr_token := new_text (text)
				else
					curr_token := new_comment (text)
				end
				update_token_list
				
when 161 then
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

	yy_execute_eof_action (yy_sc: INTEGER)
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

	yy_nxt_template: SPECIAL [INTEGER]
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make (0, 10073)
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
			yy_nxt_template_11 (an_array)
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
			    6,    6,    6,   79,   80,   81,   82,   83,   84,   85,

			   87,   88,   89,   90,  136,  138,  863,  139,  139,  139,
			  139,   87,   88,   89,   90,  137,  140,  142, 1058,  143,
			  143,  144,  144,  758,  141,  152,  153, 1058,  106,  942,
			  150,  107,  154,  155,  751,  106, 1058,  127,  107,  127,
			  127,  157,  157,  157,  142,  128,  143,  143,  144,  144,
			  265,  265,  265,  266,  266,  374,   91,  146,  147,  149,
			  380,  942,  150,  267,  267,  267,  610,   91,  142,  380,
			  144,  144,  144,  144,  268,  268,  268,  108,  380,  148,
			  157,  157,  157,  402,  402,  402,  149,   92,  608,  146,
			  147,   93,   94,   95,   96,   97,   98,   99,   92,  381,

			  381,  606,   93,   94,   95,   96,   97,   98,   99,  109,
			  149,  148,  403,  403,  110,  111,  112,  113,  114,  115,
			  116,  119,  120,  121,  122,  123,  124,  125,  129,  130,
			  131,  132,  133,  134,  135,  157,  157,  157,  157,  380,
			  404,  404,  404,  514,  514,  157,  157,  157,  157,  157,
			  157,  158,  157,  157,  157,  157,  159,  157,  160,  157,
			  157,  157,  157,  161,  162,  157,  157,  157,  157,  157,
			  157,  405,  405,  405,  610,  157,  608,  163,  163,  163,
			  163,  163,  163,  164,  163,  163,  163,  163,  165,  163,
			  166,  163,  163,  163,  163,  167,  168,  163,  163,  163,

			  163,  163,  163,  606,  372,  372,  372,  372,  169,  170,
			  171,  172,  173,  174,  175,  157,  572,  176,  373,  282,
			  157,  157,  157,  517,  512,  157,  406,  157,  157,  401,
			  336,  157,  163,  163,  163,  157,  103,  102,  157,  212,
			  101,  383,  383,  383,  374,  213,  100,  163,  157,  177,
			  373,  282,  163,  163,  163,  381,  381,  163,  269,  163,
			  163,  157,  178,  163,  264,  248,  179,  163,  157,  180,
			  163,  214,  181,  157,  157,  182,  188,  215,  156,  157,
			  163,  380,  151,  157,  104,  163,  189,  163,  278,  157,
			  279,  279,  157,  163,  183,  605,  103,  163,  184,  102,

			  163,  185, 1005,  101,  186,  163,  163,  187,  190,  100,
			  279,  163,  279,  286, 1058,  163, 1058,  163,  191,  163,
			  157,  163,  157, 1058,  163,  192,  157,  193,  600,  163,
			 1058,  198,  157,  157, 1005,  199,  216,  194,  157,  157,
			 1058, 1058,  157, 1058,  280,  157, 1058, 1058,  200, 1058,
			 1058,  157,  163, 1058,  163, 1058,  157,  195,  163,  196,
			  157,  381,  381,  201,  163,  163,  280,  202,  217,  197,
			  163,  163, 1058,  226,  163,  281, 1058,  163,  157,  218,
			  203,  157,  157,  163, 1058,  157,  204, 1058,  163,  219,
			 1058,  220,  163,  205,  206,  221, 1058,  281,  157,  207,

			 1058,  605,  157,  157, 1058,  227,  228,  230, 1058, 1058,
			  163,  222, 1058,  163,  163, 1058, 1058,  163,  208,  157,
			  157,  223,  231,  224,  157,  209,  210,  225,  157,  157,
			  163,  211, 1058,  157,  163,  163,  234,  238,  229,  232,
			  157,  157, 1058, 1058,  157,  240,  235,  244, 1058,  157,
			 1058,  163,  163, 1058,  233, 1058,  163,  157, 1058,  241,
			  163,  163,  157, 1058, 1058,  163,  157, 1058,  236,  239,
			  157, 1058,  163,  163, 1058, 1058,  163,  242,  237,  245,
			  246,  163,  177,  157,  513,  513,  513, 1058,  163,  163,
			  239,  243, 1058, 1058,  163,  515,  515,  515,  163, 1058,

			  163, 1058,  163,  250,  251,  252,  253,  254,  255,  256,
			 1058, 1058,  247,  201,  177,  163,  164,  202, 1058, 1058,
			  163,  165,  239,  166,  163, 1058,  163, 1058,  167,  168,
			  203, 1058,  163,  516,  516,  516,  163,  257,  258,  259,
			  260,  261,  262,  263, 1058,  201, 1058, 1058,  164,  202,
			  157,  157,  157,  165, 1058,  166,  163, 1058,  163, 1058,
			  167,  168,  203,  157,  157,  157, 1058,  142,  163,  379,
			  379,  379,  379,  257,  258,  259,  260,  261,  262,  263,
			  183, 1058, 1058,  214,  184,  190,  163,  185,  163,  215,
			  186, 1058, 1058,  187, 1058,  191, 1058, 1058,  163,  195,

			 1058,  196,  271,  272,  273,  274,  275,  276,  277,  149,
			 1058,  197,  183, 1058, 1058,  214,  184,  190,  163,  185,
			  163,  215,  186, 1058, 1058,  187,  278,  191,  279,  279,
			  163,  195, 1058,  196, 1058, 1058,  257,  258,  259,  260,
			  261,  262,  263,  197,  257,  258,  259,  260,  261,  262,
			  263,  257,  258,  259,  260,  261,  262,  263,  208, 1058,
			  163, 1058,  163,  217,  163,  209,  210,  222,  163, 1058,
			  163,  211,  163, 1058,  227, 1058,  163,  223, 1058,  224,
			  163, 1058,  280,  225,  157,  157,  157, 1058, 1058,  163,
			  208, 1058,  163, 1058,  163,  217,  163,  209,  210,  222,

			  163, 1058,  163,  211,  163, 1058,  227,  229,  163,  223,
			  232,  224,  163,  281,  163,  225,  163,  163,  236,  163,
			 1058,  163,  163,  157,  163,  233,  163,  157,  237,  163,
			  242,  245, 1058, 1058,  163,  163, 1058,  163, 1058,  229,
			  157,  163,  232,  163,  243, 1058,  163,  163,  163,  163,
			  236,  163, 1058,  163,  163,  163,  163,  233,  163,  163,
			  237,  163,  242,  245, 1058, 1058,  163,  163,  163,  163,
			  163,  247,  163,  163, 1058,  163,  243, 1058, 1058,  163,
			  163,  279, 1058,  283,  279,  163, 1058, 1058,  280, 1058,
			 1058,  280, 1058,  287, 1058, 1058,  270,  157,  157,  157,

			  163,  281,  163,  247,  281, 1058,  295, 1058, 1058,  270,
			 1058, 1058,  163,  271,  272,  273,  274,  275,  276,  277,
			  303,  271,  272,  273,  274,  275,  276,  277,  518,  518,
			  518, 1058, 1058,  106, 1058, 1058,  107,  284,  304,  304,
			  304,  271,  272,  273,  274,  275,  276,  277,  305,  305,
			 1058,  271,  272,  273,  274,  275,  276,  277,  306,  306,
			  306,  271,  272,  273,  274,  275,  276,  277,  285,  519,
			  519,  519,  271,  272,  273,  274,  275,  276,  277,  288,
			  289,  290,  291,  292,  293,  294,  106, 1058, 1058,  107,
			 1058, 1058,  296,  297,  298,  299,  300,  301,  302,  307, yy_Dummy>>,
			1, 1000, 0)
		end

	yy_nxt_template_2 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  307,  307,  271,  272,  273,  274,  275,  276,  277,  308,
			 1058, 1058,  271,  272,  273,  274,  275,  276,  277,  119,
			  120,  121,  122,  123,  124,  125, 1058, 1058, 1058,  387,
			  387,  387,  387, 1058, 1058,  108, 1058, 1058,  321, 1058,
			  321,  321,  595,  106,  595, 1058,  107,  596,  596,  596,
			  596,  322, 1058,  322,  322, 1058,  106, 1058, 1058,  107,
			  271,  272,  273,  274,  275,  276,  277,  109,  106,  388,
			 1058,  107,  110,  111,  112,  113,  114,  115,  116,  310,
			 1058, 1058,  311,  118,  118,  118,  597,  597,  597,  597,
			  106,  312,  108,  107,  376,  376,  376,  376,  118, 1058,

			  118, 1058,  118,  118,  313,  108,  336,  118,  377,  118,
			  157,  157,  157,  118, 1058,  118, 1058,  108,  118,  118,
			  118,  118,  118,  118,  109,  106, 1058, 1058,  107,  110,
			  111,  112,  113,  114,  115,  116, 1058,  109,  106, 1058,
			  377,  107,  110,  111,  112,  113,  114,  115,  116,  109,
			  106, 1058, 1058,  107,  110,  111,  112,  113,  114,  115,
			  116,  594,  594,  594,  594,  314,  315,  316,  317,  318,
			  319,  320, 1058,  336,  108,  373,  119,  120,  121,  122,
			  123,  124,  125,  106, 1058, 1058,  107,  108,  337,  338,
			  339,  340,  341,  342,  343,  106, 1058, 1058,  107,  108,

			 1058,  374,  157,  157,  157, 1058,  109,  373, 1058, 1058,
			  323,  110,  111,  112,  113,  114,  115,  116, 1058,  109,
			 1058,  324,  324,  324,  110,  111,  112,  113,  114,  115,
			  116,  109,  108,  325,  325, 1058,  110,  111,  112,  113,
			  114,  115,  116,  106,  108, 1058,  107,  157,  157,  157,
			 1058,  106,  368,  368,  107,  337,  338,  339,  340,  341,
			  342,  343,  106, 1058,  109,  107,  326,  326,  326,  110,
			  111,  112,  113,  114,  115,  116,  109,  336,  327,  327,
			  327,  110,  111,  112,  113,  114,  115,  116,  106, 1058,
			 1058,  107,  108,  157,  157,  157, 1058,  601,  106,  601,

			 1058,  107,  602,  602,  602,  602, 1058, 1058,  106, 1058,
			 1058,  107,  623,  623,  623,  383,  383,  383,  106, 1058,
			 1058,  107, 1058, 1058,  109, 1058,  328, 1058, 1058,  110,
			  111,  112,  113,  114,  115,  116,  329,  119,  120,  121,
			  122,  123,  124,  125, 1058,  330,  330,  330,  119,  120,
			  121,  122,  123,  124,  125,  607,  126,  126,  126,  337,
			  338,  339,  340,  341,  342,  343,  624,  624,  624, 1058,
			 1058,  331,  331, 1058,  119,  120,  121,  122,  123,  124,
			  125,  332,  332,  332,  119,  120,  121,  122,  123,  124,
			  125,  333,  333,  333,  119,  120,  121,  122,  123,  124,

			  125,  334,  336, 1058,  119,  120,  121,  122,  123,  124,
			  125,  344, 1058, 1058,  345,  346,  347,  348,  163,  163,
			  163, 1058, 1058,  349, 1058,  336, 1058,  157, 1058,  157,
			  350,  389,  351,  409,  352,  353,  354,  355,  336,  356,
			 1058,  357, 1058, 1058,  157,  358,  157,  359,  336, 1058,
			  360,  361,  362,  363,  364,  365, 1058, 1058,  336,  163,
			 1058,  163, 1058,  390, 1058,  410,  163,  163,  163, 1058,
			 1058,  505,  163,  163,  163, 1058,  163, 1058,  163,  163,
			  163,  163, 1058,  366,  337,  338,  339,  340,  341,  342,
			  343,  505,  725,  725,  725, 1058, 1058,  337,  338,  339,

			  340,  341,  342,  343,  367,  367,  367,  337,  338,  339,
			  340,  341,  342,  343,  726,  726,  726,  369,  369,  369,
			  337,  338,  339,  340,  341,  342,  343,  370,  370,  370,
			  337,  338,  339,  340,  341,  342,  343,  371, 1058, 1058,
			  337,  338,  339,  340,  341,  342,  343,  142, 1058,  378,
			  378,  379,  379,  250,  251,  252,  253,  254,  255,  256,
			  150,  279, 1058,  279,  279, 1058,  157, 1058, 1058,  395,
			  157, 1058, 1058,  250,  251,  252,  253,  254,  255,  256,
			  157, 1058,  157,  157,  157, 1058,  157, 1058,  391,  149,
			 1058,  392,  150,  385,  385,  385,  385,  157,  163,  157,

			  397,  396,  163,  385,  385,  385,  385,  385,  385,  157,
			 1058, 1058,  163,  157,  163,  163,  163,  280,  163, 1058,
			  393, 1058,  163,  394,  163, 1058,  157, 1058,  399,  163,
			 1058,  163,  398,  380,  163,  385,  385,  385,  385,  385,
			  385,  163,  390, 1058, 1058,  163, 1058,  393,  281,  163,
			  394,  163,  163, 1058,  163,  396,  163,  163,  163,  163,
			  400,  163,  163,  163,  398,  163,  163, 1058,  163,  163,
			  163, 1058, 1058,  157,  390,  163,  400,  157, 1058,  393,
			  163,  163,  394,  163,  163, 1058, 1058,  396, 1058,  163,
			  157,  163,  407,  163,  163,  163,  398,  163, 1058,  411,

			  163,  163,  163,  157, 1058,  163, 1058,  163,  400,  163,
			  157,  163,  163,  163,  415,  412,  157,  157, 1058,  408,
			 1058,  157,  163,  163,  408, 1058,  163,  157,  163, 1058,
			  413,  412, 1058,  157,  157,  163, 1058,  157,  163,  157,
			  157,  157,  163,  163, 1058,  163,  416,  412,  163,  163,
			  417,  408, 1058,  163,  410,  163, 1058, 1058,  163,  163,
			  163,  163,  414,  163, 1058,  163,  163, 1058,  416,  163,
			  163, 1058,  163,  163,  414,  163, 1058,  163, 1058,  163,
			 1058,  163,  418, 1058,  163,  418,  410,  163,  157,  157,
			  157,  163, 1058,  163, 1058,  163, 1058,  157, 1058, 1058,

			  416,  157, 1058, 1058,  163,  163,  414,  163, 1058,  163,
			 1058,  163, 1058,  163,  157, 1058,  163,  418,  422,  163,
			  157,  419,  423,  163,  157,  420, 1058, 1058,  163,  163,
			  163,  157,  163,  163,  163,  157,  424,  157, 1058,  421,
			  163,  157,  157,  157,  163, 1058,  163, 1058,  157,  425,
			  422, 1058,  163,  422,  423, 1058,  163,  423, 1058, 1058,
			  163, 1058,  163,  163,  163, 1058,  163,  163,  424,  163,
			  157,  424,  163,  427,  157,  157,  163, 1058,  437,  157,
			  163,  426,  157, 1058,  163, 1058,  163,  157,  428,  429,
			  431,  426,  157, 1058,  432,  157,  163,  163, 1058,  163,

			 1058, 1058,  163, 1058,  430,  429,  163,  163, 1058,  163,
			  438,  163, 1058,  436,  163,  163,  163, 1058,  163,  163,
			  430,  429,  433,  426,  163,  163,  434,  163,  163,  163,
			  163,  163,  163,  157,  433,  157,  430,  157,  434,  157,
			  438,  163,  163, 1058,  435,  436, 1058,  163, 1058,  439,
			  157,  163,  157,  163, 1058, 1058,  163,  163,  163,  440,
			 1058, 1058,  163,  163,  163,  163,  433,  163,  163,  163,
			  434,  163,  438, 1058,  163,  157,  436, 1058, 1058,  157,
			 1058,  440,  163,  163,  163,  163, 1058, 1058,  163,  157,
			  163,  440,  157,  157, 1058,  163, 1058, 1058,  157,  443, yy_Dummy>>,
			1, 1000, 1000)
		end

	yy_nxt_template_3 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  163,  444,  157,  445,  441, 1058,  157,  163,  157,  157,
			  163,  163,  163, 1058,  446,  157,  163,  447,  163, 1058,
			  442,  163,  163, 1058,  163,  163, 1058, 1058,  163, 1058,
			  163,  448, 1058,  449,  163,  450,  442, 1058,  163, 1058,
			  163,  163,  163,  163,  163,  163,  451,  163,  163,  452,
			  163, 1058,  442, 1058,  163,  163,  596,  596,  596,  596,
			  163,  448, 1058,  449,  279,  450,  279,  286,  157,  163,
			 1058,  163,  157, 1058, 1058,  163,  451,  163,  453,  452,
			 1058,  163,  157, 1058,  455,  157,  157,  163, 1058,  454,
			  163, 1058,  163,  448, 1058,  449,  456,  450, 1058,  157,

			  163,  163,  163,  163,  163,  383,  383,  383,  451, 1058,
			  454,  452, 1058,  163,  163, 1058,  457,  163,  163, 1058,
			  280,  454,  163,  157,  163, 1058,  457,  157,  458, 1058,
			 1058,  163, 1058, 1058,  163,  163, 1058,  163,  458, 1058,
			  157,  163,  459,  163,  157,  607, 1058,  163,  157,  460,
			 1058,  281, 1058,  163, 1058,  163, 1058, 1058,  457,  163,
			  157,  157,  461,  463,  157, 1058, 1058,  163, 1058,  163,
			  458, 1058,  163,  163,  460,  163,  163,  157, 1058,  163,
			  163,  460,  157,  157,  465,  163,  157,  157,  752,  752,
			  752,  752,  163,  163,  462,  464,  163,  464, 1058,  157,

			  157,  163, 1058,  163, 1058,  163, 1058,  163,  462,  163,
			  163, 1058,  163,  163,  163,  163,  466,  163,  163,  163,
			 1058, 1058,  163, 1058,  157,  466, 1058, 1058,  467,  464,
			 1058,  163,  163,  163,  163,  163,  163,  163, 1058,  163,
			  462,  157,  163,  468,  163,  163,  163, 1058, 1058,  163,
			  163, 1058,  163, 1058,  163,  157,  163,  466, 1058,  157,
			  468,  469,  163,  470, 1058, 1058,  163, 1058,  163, 1058,
			  157,  471,  485,  163,  472,  468,  473,  474,  163,  157,
			  157,  157,  163, 1058,  163, 1058, 1058,  163,  163,  163,
			  163,  163, 1058,  475,  163,  476,  157,  163,  163,  163,

			  157, 1058,  163,  477,  486, 1058,  478,  481,  479,  480,
			  475,  482,  476,  157, 1058,  483, 1058,  163,  163,  484,
			  477, 1058,  163,  478,  614,  479,  480,  163,  163,  163,
			  163,  163,  163, 1058,  163,  486,  157, 1058, 1058,  483,
			  487,  163,  475,  484,  476,  163, 1058,  483, 1058,  163,
			  163,  484,  477,  157,  163,  478,  614,  479,  480,  163,
			  157,  163,  163,  163,  157, 1058,  163,  486,  163,  488,
			 1058, 1058,  488,  163, 1058, 1058,  163,  157,  163, 1058,
			  489,  163, 1058,  163, 1058,  163, 1058,  157,  163, 1058,
			  490,  157,  163,  163, 1058, 1058,  163, 1058, 1058,  157,

			 1058,  488,  491,  157,  497, 1058, 1058,  492,  163,  163,
			  163, 1058,  490,  163, 1058,  163,  157, 1058,  493,  163,
			  163, 1058,  490,  163,  142,  163,  604,  604,  604,  604,
			 1058,  163, 1058,  494,  494,  163,  498, 1058,  495,  495,
			  163,  163,  163,  163, 1058, 1058,  498,  157,  163,  496,
			  496,  157,  163,  163,  500,  499, 1058,  163, 1058,  163,
			 1058, 1058, 1058,  157,  157,  494,  149,  501, 1058,  163,
			  495,  505,  163,  163,  163,  163, 1058, 1058,  498,  163,
			  157,  496,  505,  163,  163,  163,  500,  500,  157,  163,
			 1058,  163,  157,  505, 1058,  163,  163,  502,  157,  502,

			 1058,  163,  157,  505,  163,  503,  163,  163, 1058,  163,
			 1058,  613,  163,  504,  505,  157,  163, 1058, 1058,  163,
			  163, 1058, 1058, 1058,  163,  505, 1058, 1058, 1058,  502,
			  163, 1058, 1058, 1058,  163, 1058,  163,  504,  163,  163,
			 1058,  163, 1058,  614, 1058,  504, 1058,  163,  163, 1058,
			 1058,  163,  506,  250,  251,  252,  253,  254,  255,  256,
			 1058,  507,  507,  507,  250,  251,  252,  253,  254,  255,
			  256, 1058,  508,  508, 1058,  250,  251,  252,  253,  254,
			  255,  256,  509,  509,  509,  250,  251,  252,  253,  254,
			  255,  256, 1058,  510,  510,  510,  250,  251,  252,  253,

			  254,  255,  256,  520,  511, 1058, 1058,  250,  251,  252,
			  253,  254,  255,  256,  271,  272,  273,  274,  275,  276,
			  277,  303,  271,  272,  273,  274,  275,  276,  277,  304,
			  304,  304,  271,  272,  273,  274,  275,  276,  277,  305,
			  305,  528,  271,  272,  273,  274,  275,  276,  277,  306,
			  306,  306,  271,  272,  273,  274,  275,  276,  277,  307,
			  307,  307,  271,  272,  273,  274,  275,  276,  277,  308,
			 1058, 1058,  271,  272,  273,  274,  275,  276,  277,  279,
			 1058,  283,  279,  756,  756,  756,  756, 1058, 1058,  521,
			  522,  523,  524,  525,  526,  527,  280, 1058, 1058,  280,

			 1058,  287, 1058,  281,  270, 1058,  281, 1058,  295, 1058,
			 1058,  270,  271,  272,  273,  274,  275,  276,  277,  271,
			  272,  273,  274,  275,  276,  277, 1058,  529,  530,  531,
			  532,  533,  534,  535,  280,  284, 1058,  280, 1058,  287,
			 1058, 1058,  270,  280, 1058, 1058,  280, 1058,  287, 1058,
			 1058,  270, 1058,  280, 1058, 1058,  280, 1058,  287, 1058,
			 1058,  270,  611,  611,  611,  611,  285, 1058, 1058, 1058,
			  271,  272,  273,  274,  275,  276,  277,  280, 1058, 1058,
			  280, 1058,  287, 1058, 1058,  270, 1058,  288,  289,  290,
			  291,  292,  293,  294,  296,  297,  298,  299,  300,  301,

			  302,  280,  388, 1058,  280, 1058,  287, 1058, 1058,  270,
			 1058,  280, 1058, 1058,  280, 1058,  287, 1058, 1058,  270,
			  612,  612,  612,  612, 1058,  288,  289,  290,  291,  292,
			  293,  294, 1058,  536,  288,  289,  290,  291,  292,  293,
			  294,  537,  537,  537,  288,  289,  290,  291,  292,  293,
			  294,  280, 1058, 1058,  280, 1058,  287, 1058, 1058,  270,
			  388,  602,  602,  602,  602,  538,  538, 1058,  288,  289,
			  290,  291,  292,  293,  294,  281, 1058, 1058,  281, 1058,
			  295, 1058, 1058,  270, 1058,  750,  750,  750,  750,  539,
			  539,  539,  288,  289,  290,  291,  292,  293,  294,  540,

			  540,  540,  288,  289,  290,  291,  292,  293,  294,  281,
			 1058, 1058,  281, 1058,  295, 1058, 1058,  270, 1058,  281,
			 1058,  163,  281,  163,  295,  751, 1058,  270, 1058,  281,
			 1058, 1058,  281,  163,  295, 1058, 1058,  270, 1058,  541,
			 1058, 1058,  288,  289,  290,  291,  292,  293,  294,  281,
			 1058, 1058,  281,  163,  295,  163, 1058,  270,  271,  272,
			  273,  274,  275,  276,  277,  163,  296,  297,  298,  299,
			  300,  301,  302,  281, 1058, 1058,  281, 1058,  295, 1058,
			 1058,  270, 1058,  281, 1058, 1058,  281, 1058,  295, 1058,
			 1058,  270,  271,  272,  273,  274,  275,  276,  277,  542, yy_Dummy>>,
			1, 1000, 2000)
		end

	yy_nxt_template_4 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  296,  297,  298,  299,  300,  301,  302,  543,  543,  543,
			  296,  297,  298,  299,  300,  301,  302,  544,  544, 1058,
			  296,  297,  298,  299,  300,  301,  302,  271,  272,  273,
			  274,  275,  276,  277, 1058, 1058, 1058,  545,  545,  545,
			  296,  297,  298,  299,  300,  301,  302,  271,  272,  273,
			  274,  275,  276,  277,  106, 1058, 1058,  550, 1058, 1058,
			 1058,  546,  546,  546,  296,  297,  298,  299,  300,  301,
			  302,  547, 1058, 1058,  296,  297,  298,  299,  300,  301,
			  302,  548,  548,  548,  271,  272,  273,  274,  275,  276,
			  277,  549,  549,  549,  271,  272,  273,  274,  275,  276,

			  277,  106,  615, 1058,  107, 1058,  157, 1058,  551, 1058,
			 1058,  107, 1058, 1058, 1058,  106,  157, 1058,  550,  157,
			  157, 1058,  106, 1058, 1058,  553,  616, 1058,  552,  552,
			  552,  552,  106,  157,  616,  550, 1058,  163,  163,  163,
			  314,  315,  316,  317,  318,  319,  320,  106,  163,  163,
			  550,  163,  163,  859,  859,  859,  859,  106,  616, 1058,
			  550,  860,  860,  860,  860,  163, 1058,  106, 1058,  163,
			  550,  163,  755,  755,  755,  755, 1058,  106, 1058, 1058,
			  550,  163,  864,  864,  864,  864, 1058,  119,  120,  121,
			  122,  123,  124,  125,  119,  120,  121,  122,  123,  124,

			  125,  314,  315,  316,  317,  318,  319,  320,  314,  315,
			  316,  317,  318,  319,  320, 1058, 1058, 1058,  314,  315,
			  316,  317,  318,  319,  320,  106, 1058, 1058,  550, 1058,
			 1058, 1058,  554,  314,  315,  316,  317,  318,  319,  320,
			  555,  555,  555,  314,  315,  316,  317,  318,  319,  320,
			  556,  556, 1058,  314,  315,  316,  317,  318,  319,  320,
			  557,  557,  557,  314,  315,  316,  317,  318,  319,  320,
			  106, 1058, 1058,  550, 1058, 1058, 1058,  321, 1058,  321,
			  321, 1058,  106, 1058, 1058,  107, 1058, 1058, 1058,  322,
			 1058,  322,  322, 1058,  106, 1058, 1058,  107,  337,  338,

			  339,  340,  341,  342,  343, 1058,  520, 1058,  558,  558,
			  558,  314,  315,  316,  317,  318,  319,  320,  106, 1058,
			 1058,  107,  271,  272,  273,  274,  275,  276,  277, 1058,
			  106,  108, 1058,  107,  337,  338,  339,  340,  341,  342,
			  343, 1058,  106,  108, 1058,  107,  866,  866,  866,  866,
			 1058,  106, 1058,  559,  107, 1058,  314,  315,  316,  317,
			  318,  319,  320,  109, 1058, 1058, 1058,  108,  110,  111,
			  112,  113,  114,  115,  116,  109, 1058, 1058, 1058,  108,
			  110,  111,  112,  113,  114,  115,  116,  106, 1058, 1058,
			  107,  108,  521,  522,  523,  524,  525,  526,  527,  109,

			  106, 1058, 1058,  107,  110,  111,  112,  113,  114,  115,
			  116,  109,  106, 1058, 1058,  107,  110,  111,  112,  113,
			  114,  115,  116,  109,  106, 1058, 1058,  107,  110,  111,
			  112,  113,  114,  115,  116,  520,  108,  119,  120,  121,
			  122,  123,  124,  125,  106, 1058, 1058,  107, 1058,  108,
			  754,  106,  754, 1058,  107,  755,  755,  755,  755, 1058,
			 1058,  108,  106, 1058, 1058,  107, 1058, 1058,  109,  757,
			  757,  757,  757,  110,  111,  112,  113,  114,  115,  116,
			 1058,  109, 1058,  560,  560,  560,  110,  111,  112,  113,
			  114,  115,  116,  109, 1058,  561,  561,  561,  110,  111,

			  112,  113,  114,  115,  116,  106, 1058, 1058,  107,  758,
			  119,  120,  121,  122,  123,  124,  125, 1058, 1058, 1058,
			  727,  521,  522,  523,  524,  525,  526,  527, 1058, 1058,
			  119,  120,  121,  122,  123,  124,  125,  119,  120,  121,
			  122,  123,  124,  125, 1058,  562,  562,  562,  119,  120,
			  121,  122,  123,  124,  125, 1058,  941,  941,  941,  941,
			 1058,  564,  337,  338,  339,  340,  341,  342,  343,  570,
			 1058, 1058, 1058,  565,  565,  565,  337,  338,  339,  340,
			  341,  342,  343,  571,  945,  945,  945,  945,  563,  563,
			  563,  119,  120,  121,  122,  123,  124,  125,  566,  566,

			  573,  337,  338,  339,  340,  341,  342,  343,  567,  567,
			  567,  337,  338,  339,  340,  341,  342,  343,  574,  946,
			  946,  946,  946,  568,  568,  568,  337,  338,  339,  340,
			  341,  342,  343, 1058,  569, 1058, 1058,  337,  338,  339,
			  340,  341,  342,  343,  575,  575,  575,  575,  576, 1058,
			 1058,  337,  338,  339,  340,  341,  342,  343,  577,  157,
			 1058, 1058, 1058,  157, 1058,  337,  338,  339,  340,  341,
			  342,  343,  578, 1058, 1058, 1058,  157,  619, 1058,  579,
			 1058,  157,  337,  338,  339,  340,  341,  342,  343,  580,
			 1058,  163, 1058, 1058,  620,  163,  581, 1058, 1058, 1058,

			  337,  338,  339,  340,  341,  342,  343,  582,  163,  621,
			 1058, 1058, 1058,  163,  583, 1058, 1058,  337,  338,  339,
			  340,  341,  342,  343,  584, 1058,  622, 1058, 1058, 1058,
			  337,  338,  339,  340,  341,  342,  343,  585, 1058, 1058,
			  337,  338,  339,  340,  341,  342,  343,  586, 1058, 1058,
			 1058,  528, 1058, 1058,  337,  338,  339,  340,  341,  342,
			  343,  337,  338,  339,  340,  341,  342,  343,  587, 1058,
			 1058,  337,  338,  339,  340,  341,  342,  343,  337,  338,
			  339,  340,  341,  342,  343,  588, 1058, 1058, 1058,  337,
			  338,  339,  340,  341,  342,  343,  337,  338,  339,  340,

			  341,  342,  343,  589, 1058, 1058,  337,  338,  339,  340,
			  341,  342,  343,  590, 1058,  163, 1058,  163, 1058,  337,
			  338,  339,  340,  341,  342,  343,  591,  163, 1058,  337,
			  338,  339,  340,  341,  342,  343, 1058,  529,  530,  531,
			  532,  533,  534,  535,  157, 1058, 1058,  163,  157,  163,
			  337,  338,  339,  340,  341,  342,  343, 1058, 1058,  163,
			 1058,  157, 1058, 1058,  505, 1058, 1058,  337,  338,  339,
			  340,  341,  342,  343, 1058, 1058,  163, 1058, 1058, 1058,
			  163, 1058, 1058, 1058, 1058,  337,  338,  339,  340,  341,
			  342,  343, 1058,  163, 1058,  337,  338,  339,  340,  341,

			  342,  343,  948,  948,  948,  948, 1058, 1058,  337,  338,
			  339,  340,  341,  342,  343,  126,  126,  126,  337,  338,
			  339,  340,  341,  342,  343,  126,  126,  126,  337,  338,
			  339,  340,  341,  342,  343, 1058,  126,  126,  126,  337,
			  338,  339,  340,  341,  342,  343,  250,  251,  252,  253,
			  254,  255,  256,  126,  126,  126,  337,  338,  339,  340,
			  341,  342,  343,  592,  592,  592,  337,  338,  339,  340,
			  341,  342,  343,  593,  593,  593,  337,  338,  339,  340,
			  341,  342,  343,  598,  598,  598,  598,  163,  142,  163,
			  603,  603,  604,  604, 1058, 1058, 1058,  599, 1058,  163, yy_Dummy>>,
			1, 1000, 3000)
		end

	yy_nxt_template_5 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 1058,  150, 1058,  858,  858,  858,  858, 1058,  163, 1058,
			  163,  271,  272,  273,  274,  275,  276,  277, 1058,  163,
			  163,  163, 1058,  600,  157, 1058, 1058, 1058,  157,  599,
			  149,  163,  617,  150,  385,  385,  385,  385, 1058, 1058,
			  163,  157,  163,  751,  385,  385,  385,  385,  385,  385,
			  618, 1058,  163,  163, 1058,  163,  163, 1058, 1058, 1058,
			  163, 1058, 1058, 1058,  618,  163, 1058,  157, 1058,  625,
			 1058,  157, 1058,  163,  609,  621,  385,  385,  385,  385,
			  385,  385,  618, 1058,  157,  163,  163,  163,  163, 1058,
			 1058,  626,  622,  940,  940,  940,  940,  163,  163,  163,

			  163,  626,  163,  163,  157, 1058, 1058,  621,  157, 1058,
			  157, 1058,  163, 1058,  157, 1058,  163, 1058,  163, 1058,
			  163,  157,  627,  626,  622, 1058,  163,  157,  163, 1058,
			  163,  629,  163,  628,  163,  163,  163,  163,  163,  631,
			  163, 1058,  163,  157,  163,  630,  163,  163, 1058, 1058,
			 1058,  632, 1058,  163,  628, 1058,  157, 1058,  163,  163,
			  163, 1058,  163,  630,  163,  628, 1058,  163,  157,  163,
			  163,  632,  157, 1058,  163,  163, 1058,  630,  163,  163,
			  163, 1058,  157,  632,  634,  633,  157, 1058,  163, 1058,
			  163,  157, 1058, 1058,  163,  637,  163, 1058,  640,  157,

			  163, 1058,  635,  639,  163, 1058,  163,  157,  157,  163,
			  163,  163,  163, 1058,  163, 1058,  634,  634,  163, 1058,
			  157,  163,  163,  163,  163, 1058,  163,  638, 1058, 1058,
			  640,  163, 1058,  636,  636,  640,  163, 1058,  638,  163,
			  163,  163,  157,  163, 1058,  163,  641,  163,  749,  749,
			  749,  749,  163,  163,  642, 1058,  163,  163,  163,  157,
			 1058,  163,  857,  163, 1058,  636, 1058,  157,  163, 1058,
			  638,  157, 1058,  163,  163, 1058, 1058,  163,  642,  163,
			 1058,  157, 1058, 1058,  157,  157,  642, 1058,  163,  163,
			  163,  163,  645,  163,  857,  163,  157,  644,  157,  163,

			  163,  643, 1058,  163,  157,  163,  646, 1058,  649,  157,
			 1058, 1058,  647,  163, 1058, 1058,  163,  163, 1058, 1058,
			  163,  157,  163,  163,  647,  163,  648, 1058,  163,  644,
			  163, 1058,  163,  644, 1058,  163,  163, 1058,  648, 1058,
			  650,  163,  650, 1058,  647, 1058,  157, 1058, 1058,  163,
			  157,  163,  157,  163, 1058,  163,  157,  163,  648, 1058,
			  660,  163,  163,  157,  651, 1058, 1058,  163,  163,  157,
			  163,  653,  163, 1058,  650,  652, 1058,  163,  163,  163,
			  163,  163,  163,  163,  163,  654, 1058, 1058,  163,  163,
			 1058, 1058,  660,  163,  163,  163,  652, 1058, 1058, 1058,

			  163,  163,  163,  654,  163, 1058,  157,  652, 1058,  163,
			  157,  163,  163,  163,  657,  163, 1058,  654,  655, 1058,
			  157,  163,  157,  157,  661,  163,  157,  658, 1058, 1058,
			 1058,  656,  157,  659, 1058, 1058,  157,  157,  163,  157,
			  663, 1058,  163, 1058,  157,  163,  657,  163,  665,  157,
			  657, 1058,  163, 1058,  163,  163,  662,  163,  163,  658,
			 1058,  157,  157,  658,  163,  660,  157, 1058,  163,  163,
			  669,  163,  664, 1058,  157, 1058,  163,  667, 1058,  157,
			  666,  163,  662, 1058, 1058,  664, 1058,  157,  163,  163,
			  163,  163, 1058,  163,  163,  163,  666,  163,  163,  668,

			  163,  163,  670,  163, 1058,  163,  163,  163,  157,  668,
			 1058,  163,  671,  670,  662,  163, 1058,  664, 1058,  163,
			  163,  163,  163,  163,  163,  157,  163,  163,  666,  163,
			 1058,  668,  163,  163,  672,  163,  163,  163,  673,  163,
			  163,  163,  157,  163,  672,  670,  157,  163, 1058,  674,
			  157, 1058, 1058,  163, 1058,  157,  163,  163,  163, 1058,
			  163,  675,  163,  157, 1058,  163,  672,  163,  163,  676,
			  674, 1058,  163,  163,  163,  163, 1058,  163,  163,  157,
			 1058,  674,  163,  677, 1058,  163,  157,  163, 1058, 1058,
			  157,  678,  163,  676,  163,  163,  157,  163,  163,  163,

			  163,  676,  157,  157,  163,  163,  157,  163,  680,  163,
			  163,  163,  163, 1058,  163,  678,  679,  163,  163,  157,
			 1058, 1058,  163,  678,  163, 1058, 1058, 1058,  163, 1058,
			  163, 1058,  163, 1058,  163,  163, 1058,  163,  163,  163,
			  680,  157,  163,  682,  163,  681,  163, 1058,  680,  163,
			  163,  163,  163, 1058, 1058,  157,  163,  683,  157,  157,
			  684, 1058,  163,  157, 1058,  685,  157,  687,  686, 1058,
			  689, 1058,  157,  163,  163,  682,  163,  682, 1058, 1058,
			  157, 1058,  163,  157,  163, 1058,  163,  163, 1058,  685,
			  163,  163,  686, 1058,  163,  163, 1058,  685,  163,  688,

			  686, 1058,  690,  691,  163,  157,  163,  157,  163,  157,
			 1058, 1058,  163, 1058, 1058,  163, 1058,  157,  163, 1058,
			  157,  157,  157, 1058, 1058,  693,  157, 1058,  695,  688,
			  157, 1058, 1058, 1058,  699,  692,  163,  163,  163,  163,
			 1058,  163, 1058,  157, 1058, 1058,  696, 1058,  163,  163,
			 1058, 1058,  163,  163,  163, 1058,  692,  694,  163, 1058,
			  697,  688,  163, 1058,  690, 1058,  700,  163,  163,  163,
			  163,  163,  163,  163,  163,  163,  697, 1058,  698,  163,
			  163,  694, 1058,  163,  163,  163, 1058,  163,  692, 1058,
			  862,  862,  862,  862,  698, 1058,  690,  163, 1058,  163,

			 1058,  163, 1058,  163,  163,  163,  163, 1058,  697,  704,
			 1058,  163,  163,  694,  163,  163,  163,  163,  700,  163,
			  163,  157,  163,  703,  163,  701,  698,  157,  702,  163,
			  863, 1058,  163, 1058, 1058,  163, 1058,  163,  157, 1058,
			  157,  704, 1058, 1058,  163, 1058,  163,  163, 1058, 1058,
			  700, 1058,  163,  163,  163,  704,  163,  702,  157,  163,
			  702,  157,  157, 1058,  163,  157,  705,  163,  706,  163,
			  163,  163,  163,  163,  707,  157, 1058, 1058,  157,  163,
			  163, 1058,  708,  163,  157, 1058, 1058,  157,  709, 1058,
			  163,  711,  163,  163,  163, 1058, 1058,  163,  706, 1058,

			  706,  157,  710,  163,  157,  163,  708,  163, 1058,  163,
			  163,  163,  163,  157,  708,  163,  163,  157,  157,  163,
			  710,  163,  157,  712,  163, 1058,  715, 1058, 1058,  713,
			  157, 1058, 1058,  163,  710,  157,  163,  712, 1058, 1058,
			 1058,  163, 1058,  163,  163,  163,  163, 1058, 1058,  163,
			  163, 1058, 1058,  163,  163,  157,  163, 1058,  716,  157,
			 1058,  714,  163,  163, 1058,  163, 1058,  163,  714,  712,
			 1058, 1058,  157, 1058,  716,  163,  163,  163,  163,  163,
			 1058, 1058,  157, 1058, 1058, 1058,  157,  163,  163,  163,
			  717,  163, 1058,  718, 1058,  163,  163,  163,  163,  157, yy_Dummy>>,
			1, 1000, 4000)
		end

	yy_nxt_template_6 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  714, 1058, 1058, 1058,  163, 1058,  716,  163,  163,  163,
			  505,  163,  157, 1058,  163,  719,  157,  505,  163, 1058,
			  157,  163,  718, 1058,  157,  718,  720,  505,  163,  157,
			  163,  163, 1058,  721,  163, 1058,  163,  157,  505,  163,
			  163,  722, 1058,  163,  163,  163,  163,  720,  163,  505,
			 1058,  163,  163, 1058, 1058,  163,  163,  520,  720, 1058,
			 1058,  163, 1058, 1058, 1058,  722,  163,  520,  163,  163,
			 1058,  163, 1058,  722, 1058,  163, 1058,  163,  163,  520,
			 1058, 1058, 1058,  163, 1058, 1058, 1058,  163, 1058,  520,
			 1058, 1058,  250,  251,  252,  253,  254,  255,  256,  250,

			  251,  252,  253,  254,  255,  256,  520, 1058, 1058,  250,
			  251,  252,  253,  254,  255,  256,  528,  723,  723,  723,
			  250,  251,  252,  253,  254,  255,  256,  528,  724,  724,
			  724,  250,  251,  252,  253,  254,  255,  256,  528, 1058,
			  728,  728,  728,  521,  522,  523,  524,  525,  526,  527,
			  729,  729,  528,  521,  522,  523,  524,  525,  526,  527,
			 1058, 1058,  730,  730,  730,  521,  522,  523,  524,  525,
			  526,  527,  731,  731,  731,  521,  522,  523,  524,  525,
			  526,  527,  528,  865,  865,  865,  865, 1058, 1058,  732,
			 1058, 1058,  521,  522,  523,  524,  525,  526,  527,  528,

			 1058,  733,  529,  530,  531,  532,  533,  534,  535, 1058,
			  734,  734,  734,  529,  530,  531,  532,  533,  534,  535,
			 1058,  735,  735,  758,  529,  530,  531,  532,  533,  534,
			  535,  940,  940,  940,  940,  736,  736,  736,  529,  530,
			  531,  532,  533,  534,  535,  280, 1058, 1058,  280, 1058,
			  287, 1058,  280,  270, 1058,  280, 1058,  287, 1058,  759,
			  270,  604,  604,  604,  604,  737,  737,  737,  529,  530,
			  531,  532,  533,  534,  535,  280, 1058, 1058,  280, 1058,
			  287, 1058,  738,  270, 1058,  529,  530,  531,  532,  533,
			  534,  535,  280, 1058, 1058,  280, 1058,  287, 1058, 1058,

			  270,  388,  280, 1058, 1058,  280, 1058,  287, 1058, 1058,
			  270, 1058,  280, 1058, 1058,  280, 1058,  287, 1058,  281,
			  270, 1058,  281, 1058,  295, 1058,  281,  270, 1058,  281,
			 1058,  295, 1058, 1058,  270, 1058,  288,  289,  290,  291,
			  292,  293,  294,  288,  289,  290,  291,  292,  293,  294,
			  281, 1058, 1058,  281, 1058,  295, 1058,  281,  270, 1058,
			  281, 1058,  295, 1058, 1058,  270,  288,  289,  290,  291,
			  292,  293,  294,  281, 1058, 1058,  281, 1058,  295, 1058,
			 1058,  270, 1058,  288,  289,  290,  291,  292,  293,  294,
			  739,  739,  739,  288,  289,  290,  291,  292,  293,  294,

			  740,  740,  740,  288,  289,  290,  291,  292,  293,  294,
			  296,  297,  298,  299,  300,  301,  302,  296,  297,  298,
			  299,  300,  301,  302,  281, 1058, 1058,  281, 1058,  295,
			 1058, 1058,  270, 1058, 1058, 1058,  551, 1058, 1058,  550,
			 1058,  296,  297,  298,  299,  300,  301,  302,  296,  297,
			  298,  299,  300,  301,  302,  106, 1058, 1058,  550, 1058,
			 1058,  741,  741,  741,  296,  297,  298,  299,  300,  301,
			  302,  106, 1058, 1058,  550, 1058, 1058, 1058,  551, 1058,
			 1058,  550, 1058,  118,  743,  743,  743,  743,  106, 1058,
			 1058,  550, 1058, 1058, 1058,  106, 1058, 1058,  550, 1058,

			 1058,  939,  106,  939,  118,  550,  940,  940,  940,  940,
			 1058, 1058,  742,  742,  742,  296,  297,  298,  299,  300,
			  301,  302,  314,  315,  316,  317,  318,  319,  320,  106,
			 1058, 1058,  550,  760,  760,  760,  760,  999,  999,  999,
			  999,  314,  315,  316,  317,  318,  319,  320,  106, 1058,
			 1058,  550, 1004, 1004, 1004, 1004, 1058,  314,  315,  316,
			  317,  318,  319,  320,  314,  315,  316,  317,  318,  319,
			  320, 1058, 1058,  388,  314,  315,  316,  317,  318,  319,
			  320,  314,  315,  316,  317,  318,  319,  320,  314,  315,
			  316,  317,  318,  319,  320,  106, 1058, 1058,  550, 1058,

			  759, 1058,  603,  603,  604,  604, 1058,  106, 1058, 1058,
			  107, 1058, 1058,  150, 1058,  314,  315,  316,  317,  318,
			  319,  320,  106, 1058, 1058,  107,  947,  947,  947,  947,
			  520,  744,  744,  744,  314,  315,  316,  317,  318,  319,
			  320,  106,  388, 1058,  107,  150, 1058, 1058,  106, 1058,
			 1058,  107,  612,  612,  612,  612,  108, 1058, 1058, 1058,
			 1058,  749,  749,  749,  749, 1058, 1058, 1006, 1006, 1006,
			 1006,  108, 1058, 1058, 1058,  373, 1058,  520,  745,  745,
			  745,  314,  315,  316,  317,  318,  319,  320,  109, 1058,
			 1058, 1058,  388,  110,  111,  112,  113,  114,  115,  116,

			 1058,  374, 1058,  109, 1058, 1058, 1058,  373,  110,  111,
			  112,  113,  114,  115,  116, 1058,  521,  522,  523,  524,
			  525,  526,  527,  505, 1058, 1058, 1058,  119,  120,  121,
			  122,  123,  124,  125,  119,  120,  121,  122,  123,  124,
			  125,  337,  338,  339,  340,  341,  342,  343,  337,  338,
			  339,  340,  341,  342,  343,  337,  338,  339,  340,  341,
			  342,  343, 1058,  521,  522,  523,  524,  525,  526,  527,
			 1058,  337,  338,  339,  340,  341,  342,  343, 1058,  746,
			  746,  746,  337,  338,  339,  340,  341,  342,  343,  940,
			  940,  940,  940, 1058,  747,  747,  747,  337,  338,  339,

			  340,  341,  342,  343, 1058,  250,  251,  252,  253,  254,
			  255,  256,  748,  575,  575,  575,  575,  947,  947,  947,
			  947, 1058,  861,  861,  861,  861, 1058, 1058,  868,  751,
			  612,  612,  612,  612, 1058, 1058,  867,  753,  753,  753,
			  753,  126,  126,  126,  337,  338,  339,  340,  341,  342,
			  343,  599, 1001, 1001, 1001, 1001, 1058,  126,  126,  126,
			  337,  338,  339,  340,  341,  342,  343,  163,  867,  163,
			  149,  861,  861,  861,  861,  762,  157,  600, 1058,  163,
			  157, 1058, 1058,  599, 1058,  943,  337,  338,  339,  340,
			  341,  342,  343,  157, 1058,  761,  157, 1058, 1058,  163,

			  157,  163, 1058,  163, 1058,  163, 1058,  762,  163, 1058,
			  764,  163,  163,  157,  763,  163,  157,  943, 1058,  766,
			  157, 1058,  765, 1058,  163,  163,  163,  762,  163, 1058,
			 1058, 1058,  163,  157, 1058,  163,  163,  163, 1003, 1003,
			 1003, 1003,  764, 1058, 1058,  163,  764,  163,  163, 1058,
			 1058,  766,  163,  157,  766,  767,  163,  157,  163,  157,
			  768, 1058,  157,  157, 1058,  163,  157,  769,  163,  163,
			  157,  163,  771, 1058, 1058,  770,  157, 1058,  163,  157,
			  163,  163, 1058,  772,  163,  163,  163,  768, 1058,  163,
			  163,  163,  768, 1058,  163,  163,  163, 1058,  163,  770, yy_Dummy>>,
			1, 1000, 5000)
		end

	yy_nxt_template_7 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 1058,  163,  163,  163,  772, 1058, 1058,  770,  163, 1058,
			  163,  163,  163,  163, 1058,  772,  163,  157,  163, 1058,
			 1058,  157,  163,  157,  163,  157,  163,  775,  163,  157,
			 1058,  774,  776,  157,  157,  773,  163,  779, 1058,  163,
			  157,  163,  157, 1058,  777, 1003, 1003, 1003, 1003,  163,
			  157,  163, 1058,  163, 1058,  163,  163,  163,  163,  776,
			 1058,  163, 1058,  774,  776,  163,  163,  774,  163,  780,
			 1058,  163,  163,  163,  163, 1058,  778,  163, 1058,  163,
			  157,  780,  163,  163,  157,  778,  781,  782,  163,  163,
			  163,  157,  163, 1058,  163,  157, 1058,  157, 1058, 1058,

			  163, 1058, 1058, 1058,  163, 1058, 1058, 1058,  783,  163,
			 1058,  163,  163,  780, 1058, 1058,  163,  778,  782,  782,
			  163,  163,  163,  163,  163, 1058,  163,  163, 1058,  163,
			  786,  163,  163,  163, 1058, 1058,  163,  784, 1058,  163,
			  784,  163,  157,  163,  785,  788,  157, 1058,  163,  157,
			  163,  163, 1058,  157, 1058, 1058, 1058,  787, 1058,  157,
			  163, 1058,  786,  163, 1058,  163,  157, 1058, 1058,  784,
			 1058,  163, 1058,  163,  163,  163,  786,  788,  163, 1058,
			  163,  163,  163,  163,  157,  163, 1058, 1058,  157,  788,
			  157,  163,  163,  163,  157,  163,  157, 1058,  163,  790,

			  157,  789,  163,  791,  792,  163,  163,  157,  163, 1058,
			 1058, 1058,  794,  793,  163, 1058,  163,  163,  163,  163,
			  163, 1058,  163,  796, 1058,  163,  163,  163,  163,  163,
			 1058,  790,  163,  790,  163,  792,  792,  163,  163,  163,
			  163, 1058, 1058,  157,  794,  794,  163,  157,  157,  163,
			  163,  163,  797, 1058,  157,  796, 1058,  798,  157, 1058,
			  795,  163, 1058, 1058,  163,  157,  163, 1058,  157, 1058,
			 1058,  157,  157, 1058,  799,  163,  163,  157, 1058,  163,
			  163,  801, 1058, 1058,  798,  157,  163, 1058, 1058,  798,
			  163, 1058,  796,  163,  157,  163,  163,  163,  163,  163,

			  163,  163,  800,  163,  163,  163,  800, 1058,  163,  163,
			 1058,  163,  157,  802, 1058, 1058,  157,  163, 1058, 1058,
			  803,  802, 1058, 1058, 1058,  163,  163,  163,  163,  157,
			  163,  163, 1058,  163,  800, 1058,  804,  163, 1058,  163,
			  163,  163,  157,  163,  163,  163,  157,  163,  163, 1058,
			 1058,  163,  804,  802, 1058, 1058, 1058,  806, 1058,  157,
			  163,  163,  163,  157,  163,  805,  163,  157,  804, 1058,
			 1058,  163,  163,  163,  163, 1058,  808,  163,  163,  163,
			  157, 1058, 1058,  163,  157, 1058,  807, 1058,  157,  806,
			  157,  163, 1058, 1058,  811,  163,  163,  806,  163,  163,

			 1058,  809,  157,  163,  812,  163,  157,  157,  808,  810,
			 1058,  163,  163,  163, 1058,  163,  163, 1058,  808,  813,
			  163, 1058,  163,  163, 1058, 1058,  812,  157, 1058, 1058,
			 1058,  157, 1058,  810,  163,  163,  812,  163,  163,  163,
			  163,  810,  163,  163,  157,  163,  814,  163,  163, 1058,
			  163,  814,  163,  157,  816,  163,  163,  157,  157,  163,
			  163, 1058,  157,  163,  815,  163,  163,  163, 1058,  163,
			  157,  163,  163, 1058,  163,  157,  163,  163,  814, 1058,
			  163,  163,  163,  157,  163,  163,  816,  157,  163,  163,
			  163, 1058,  163,  818,  163,  163,  816,  163,  163,  163,

			  157,  163,  163,  163,  157,  163,  157,  163,  157,  163,
			  157, 1058,  163,  163,  163,  163, 1058,  817, 1058,  163,
			 1058,  157, 1058,  157,  163,  818, 1058,  163, 1058, 1058,
			  157,  157,  163, 1058,  157,  157,  163,  163,  163,  821,
			  163, 1058,  163, 1058,  163, 1058,  163,  157,  157,  818,
			  819, 1058,  163,  163,  163,  163,  163,  944,  944,  944,
			  944,  820,  163,  163,  163, 1058,  163,  163, 1058, 1058,
			  822,  822,  157,  163, 1058,  163,  157,  823, 1058,  163,
			  163, 1058,  820, 1058,  163,  163,  163, 1058, 1058,  157,
			 1058, 1058,  824,  820, 1058,  157,  163,  863,  163,  157,

			  163, 1058,  822, 1058,  163,  163, 1058,  163,  163,  824,
			  163, 1058,  825,  163, 1058,  163,  157,  163, 1058,  826,
			  157,  163, 1058, 1058,  824,  163, 1058,  163,  827, 1058,
			  163,  163,  163,  157,  163,  828,  163, 1058,  830, 1058,
			 1058,  163,  163,  163,  826,  163,  163,  163,  163, 1058,
			 1058,  826,  163,  163,  157, 1058, 1058,  163,  157,  157,
			  828, 1058,  829,  157, 1058,  163,  163,  828,  163, 1058,
			  830,  157,  163,  163,  163,  163,  157, 1058,  163,  831,
			 1058,  832, 1058, 1058,  163,  163,  163, 1058,  157, 1058,
			  163,  163,  157, 1058,  830,  163, 1058,  157,  834,  833,

			  163,  157, 1058,  163,  163,  157,  163, 1058,  163, 1058,
			  163,  832, 1058,  832,  157,  163,  163,  163, 1058, 1058,
			  163,  835,  157, 1058,  163, 1058,  157,  163,  836,  163,
			  834,  834,  163,  163,  157, 1058,  837,  163,  157,  839,
			 1058,  838,  163, 1058, 1058, 1058,  163,  163, 1058,  163,
			  163,  157,  163,  836,  163,  163, 1058,  163,  163,  163,
			  836,  840,  163, 1058, 1058, 1058,  163,  163,  838, 1058,
			  163,  840, 1058,  838,  163,  157,  163, 1058,  842,  157,
			 1058,  157,  163,  163,  163,  157,  163,  163, 1058,  163,
			  841, 1058,  157,  840,  163, 1058, 1058,  157,  157,  163,

			  163,  157,  163,  163, 1058,  163,  163,  163,  163, 1058,
			  842,  163,  163,  163,  157,  163, 1058,  163,  163,  157,
			 1058,  157,  842,  157,  163,  157,  843, 1058, 1058,  163,
			  163, 1058,  163,  163,  163,  163,  157,  163,  157,  845,
			 1058, 1058,  844, 1058,  163,  157,  163,  163,  163,  157,
			  163,  163,  163,  163,  163,  163,  847,  163,  844, 1058,
			  163,  846,  157,  848,  163,  163, 1058, 1058,  163, 1058,
			  163,  846,  849, 1058,  844,  163,  157,  163,  505, 1058,
			  163,  163,  163,  520,  163, 1058,  163,  850,  848,  157,
			  520, 1058,  163,  846,  163,  848,  163,  163,  163,  157,

			  163,  157,  520,  157,  850,  157, 1058,  163,  163, 1058,
			  163,  163,  163,  163,  163,  520,  157, 1058,  157,  850,
			 1058,  163,  528,  163,  163, 1041, 1041, 1041, 1041,  528,
			  163,  163,  163,  163, 1058,  163,  528,  163,  951,  951,
			  951,  951,  163,  163,  163,  163,  163,  528,  163, 1058,
			  163, 1058,  952, 1058, 1058,  163,  163,  528, 1058, 1058,
			  250,  251,  252,  253,  254,  255,  256,  528, 1058,  521,
			  522,  523,  524,  525,  526,  527,  521,  522,  523,  524,
			  525,  526,  527, 1058,  952,  851,  851,  851,  521,  522,
			  523,  524,  525,  526,  527, 1058, 1058, 1058,  852,  852, yy_Dummy>>,
			1, 1000, 6000)
		end

	yy_nxt_template_8 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  852,  521,  522,  523,  524,  525,  526,  527,  529,  530,
			  531,  532,  533,  534,  535,  529,  530,  531,  532,  533,
			  534,  535,  529,  530,  531,  532,  533,  534,  535,  106,
			 1058, 1058,  550,  529,  530,  531,  532,  533,  534,  535,
			  853,  853,  853,  529,  530,  531,  532,  533,  534,  535,
			  854,  854,  854,  529,  530,  531,  532,  533,  534,  535,
			  280, 1058, 1058,  280, 1058,  287, 1058,  280,  270, 1058,
			  280, 1058,  287, 1058,  281,  270, 1058,  281, 1058,  295,
			 1058,  281,  270, 1058,  281, 1058,  295, 1058, 1058,  270,
			 1058, 1058,  163,  106,  163, 1058,  550, 1058, 1058, 1058,

			  106, 1058, 1058,  550,  163,  118,  855,  855,  855,  855,
			 1058, 1058, 1058, 1058, 1058,  314,  315,  316,  317,  318,
			  319,  320,  856,  949,  163,  949,  163, 1058,  947,  947,
			  947,  947, 1000, 1058, 1000, 1058,  163, 1001, 1001, 1001,
			 1001, 1058, 1058,  337,  338,  339,  340,  341,  342,  343,
			 1058,  288,  289,  290,  291,  292,  293,  294,  288,  289,
			  290,  291,  292,  293,  294,  296,  297,  298,  299,  300,
			  301,  302,  296,  297,  298,  299,  300,  301,  302,  314,
			  315,  316,  317,  318,  319,  320,  314,  315,  316,  317,
			  318,  319,  320,  337,  338,  339,  340,  341,  342,  343,

			  861,  861,  861,  861,  337,  338,  339,  340,  341,  342,
			  343,  157,  157, 1058,  599,  157,  157, 1058,  163,  157,
			  163,  872,  163,  157,  870,  163, 1058,  163,  157,  157,
			  163, 1058,  869, 1058,  163, 1058,  157,  163, 1058, 1058,
			  600,  157,  873,  163,  163,  157,  599,  163,  163, 1058,
			  163,  163,  163,  872,  163,  163,  870,  163,  157,  163,
			  163,  163,  163,  157,  870, 1058,  163,  157,  163,  163,
			  871,  874,  157,  163,  874,  157,  157,  163, 1058,  157,
			  157,  163,  163,  163,  163,  163, 1058,  163, 1058,  157,
			  163, 1058,  157,  163,  163,  163, 1058,  163, 1058,  163,

			 1058,  157,  872,  874,  163,  157, 1058,  163,  163, 1058,
			 1058,  163,  163,  163,  163,  163,  163,  163,  875,  163,
			 1058,  163, 1058, 1058,  163,  163,  163,  157,  163,  163,
			  163,  877,  879,  163,  876,  878,  880,  163, 1058,  163,
			  163,  163, 1058,  163,  157,  882, 1058, 1058,  157, 1058,
			  876,  163,  157,  157, 1058,  163, 1058,  157, 1058,  163,
			  163,  881,  163,  879,  879,  157,  876,  880,  880, 1058,
			  157,  163,  163,  163, 1058,  163,  163,  882,  157,  163,
			  163,  163,  157,  163,  163,  163,  163,  163,  163,  163,
			 1058,  163,  884,  882, 1058,  883, 1058,  163,  163,  157,

			 1058,  886,  163,  157,  157,  163,  885,  163,  157,  887,
			  163,  163, 1058,  163,  163, 1058,  157,  163,  163, 1058,
			  163,  157, 1058,  163,  884,  157,  888,  884, 1058,  889,
			  163,  163,  163,  886,  163,  163,  163,  163,  886,  163,
			  163,  888,  157,  890,  163, 1058, 1058, 1058,  163,  163,
			  163,  157,  163,  163,  891,  157, 1058,  163,  888,  892,
			 1058,  890,  163, 1058,  163, 1058,  163,  163,  157,  163,
			 1058, 1058, 1058,  157,  163,  890,  163,  157, 1058,  163,
			 1058, 1058,  163,  163,  163,  157,  892,  163, 1058,  157,
			  157,  892,  893, 1058,  163,  163, 1058,  163,  895,  163,

			  163,  163,  157,  894,  163,  163,  896,  163,  157,  163,
			 1058,  163,  157, 1058, 1058,  157,  163,  163, 1058,  157,
			 1058,  163,  163, 1058,  894,  157, 1058,  163, 1058,  163,
			  896,  163,  897,  163,  163,  894,  163, 1058,  896,  163,
			  163,  157, 1058,  163,  163,  157, 1058,  163,  163,  157,
			  163,  163,  163,  901,  899, 1058,  898,  163,  157,  163,
			  902,  900,  163,  163,  898,  163,  157,  163, 1058,  163,
			  157,  163,  157,  163,  157,  163,  157,  163,  903,  163,
			 1058,  163,  163, 1058,  163,  902,  900,  157,  898,  157,
			  163,  163,  902,  900,  163,  163, 1058,  163,  163,  163,

			 1058,  163,  163,  163,  163, 1058,  163,  163,  163,  904,
			  904,  163,  163, 1058,  163, 1058, 1058, 1058,  157,  163,
			 1058,  163,  157, 1058,  163,  906,  905,  163,  163,  163,
			  163, 1058,  157, 1058,  907,  157,  157, 1058, 1058,  163,
			  163,  904,  908, 1058,  163, 1058,  163, 1058, 1058,  157,
			  163,  163, 1058,  163,  163, 1058,  163,  906,  906, 1058,
			  163,  157,  163,  163,  163,  157,  908,  163,  163,  909,
			 1058,  157,  163, 1058,  908,  157, 1058,  910,  157, 1058,
			  163,  163,  163,  163,  163,  163,  163,  157,  157, 1058,
			 1058,  911,  163,  163,  157,  163,  163,  163,  157, 1058,

			 1058,  910, 1058,  163,  157, 1058,  912,  163, 1058,  910,
			  163,  913,  163,  163,  163,  163,  163,  157,  163,  163,
			  163,  157, 1058,  912,  163,  163,  163,  163,  163,  163,
			  163,  157, 1058,  914,  157,  919,  163, 1058,  912,  163,
			  915, 1058,  163,  914,  163,  163, 1058,  163,  157,  163,
			 1058, 1058,  157,  163,  916, 1058,  157,  163, 1058,  163,
			  917,  163, 1058,  163, 1058,  914,  163,  920, 1058,  157,
			  918,  163,  916,  163,  163,  163,  163, 1058,  157, 1058,
			  163, 1058,  921, 1058,  163,  163,  916,  920,  163, 1058,
			  922, 1058,  918, 1058,  163,  157,  163,  163, 1058,  163,

			 1058,  163,  918, 1058,  157,  163,  163,  163,  157,  163,
			  163, 1058, 1058, 1058,  922, 1058,  926,  163,  163,  920,
			  163,  923,  922,  163,  924,  163,  163,  163,  163,  163,
			  163,  163, 1058, 1058, 1058,  163,  163,  163,  163,  163,
			  163,  163,  157, 1058, 1058,  928,  925,  157,  926,  163,
			  163,  157,  163,  924, 1058,  163,  924,  163,  163,  157,
			  163, 1058,  163, 1058,  157, 1058,  927,  163,  157,  163,
			  163,  163,  157, 1058,  163, 1058,  157,  928,  926,  163,
			  157,  163, 1058,  163,  931,  157, 1058, 1058,  157, 1058,
			  163,  163,  163,  157, 1058,  929,  163,  163,  928,  163,

			  163,  157,  163, 1058,  163,  930,  157, 1058,  163,  163,
			  157,  932,  163, 1058, 1058, 1058,  932,  163, 1058, 1058,
			  163, 1058,  163,  157,  163,  163, 1058,  930,  163,  163,
			  163,  163, 1058,  163,  163, 1058,  520,  930,  163, 1058,
			  163,  163,  163,  932,  157, 1058,  157, 1058,  157, 1058,
			  935, 1058,  933,  157,  163,  163,  163,  157, 1058, 1058,
			  163,  157,  163,  157,  934, 1058,  163,  163,  936,  163,
			  157,  163,  163,  163,  520,  163,  163,  163,  163,  163,
			  163,  528,  936,  163,  934,  163,  163,  163,  938,  163,
			  528, 1058, 1058,  163, 1058,  163,  934, 1058,  163,  163, yy_Dummy>>,
			1, 1000, 7000)
		end

	yy_nxt_template_9 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  936,  163,  163,  163,  157,  163, 1058,  163,  157,  163,
			 1058,  163, 1058, 1058, 1058,  163, 1058,  937,  163,  163,
			  938,  157,  521,  522,  523,  524,  525,  526,  527,  106,
			  163, 1058,  550, 1058, 1058, 1058,  163, 1058, 1058, 1058,
			  163,  118, 1058,  947,  947,  947,  947, 1058, 1058,  938,
			 1002, 1058, 1002,  163, 1058, 1003, 1003, 1003, 1003, 1058,
			  521,  522,  523,  524,  525,  526,  527,  529,  530,  531,
			  532,  533,  534,  535, 1058, 1058,  529,  530,  531,  532,
			  533,  534,  535,  758, 1009, 1009, 1009, 1009, 1058, 1058,
			  157,  163,  157,  163,  157,  954,  953, 1058, 1003, 1003,

			 1003, 1003,  163,  163,  163, 1058, 1058,  157, 1058,  157,
			 1043, 1043, 1043, 1043,  163,  314,  315,  316,  317,  318,
			  319,  320,  163,  163,  163,  163,  163,  954,  954, 1058,
			 1058, 1058, 1058,  157,  163,  163,  163,  157,  863,  163,
			  163,  163,  163,  157,  157, 1058,  163,  157,  157,  956,
			  157, 1058,  163,  955,  157,  163, 1058,  163,  157, 1058,
			  157,  157,  957,  958, 1058,  163, 1058,  163,  959,  163,
			 1058,  157,  163, 1058,  163,  163,  163, 1058, 1058,  163,
			  163,  956,  163, 1058,  163,  956,  163,  163, 1058,  163,
			  163, 1058,  163,  163,  958,  958,  163, 1058,  163,  163,

			  960, 1058,  163,  163,  163,  960,  157,  163,  163,  163,
			  157, 1058,  157,  964,  163,  962,  963, 1058, 1058,  163,
			  163, 1058,  163,  157, 1058,  961, 1058, 1058,  163,  157,
			  163, 1058,  163, 1058,  163, 1058,  163,  960,  163,  163,
			  163,  163,  163, 1058,  163,  964,  163,  962,  964,  965,
			 1058,  163,  163,  157,  163,  163,  966,  962,  157,  157,
			 1058,  163,  157,  157,  163, 1058,  157,  163,  163,  163,
			  163,  163, 1058,  163, 1058,  157,  157,  968, 1058,  163,
			  163,  966, 1058,  163,  163,  163,  163, 1058,  966,  157,
			  163,  163, 1058,  967,  163,  163,  163, 1058,  163,  163,

			  163,  163,  163,  163, 1058,  163,  157,  163,  163,  968,
			  157,  163,  163, 1058,  157,  163,  163,  163,  163,  163,
			  969,  163,  970, 1058,  157,  968,  157,  157,  163,  163,
			  971, 1058,  163,  163,  163,  163,  157,  157,  163, 1058,
			  157,  972,  163,  157,  163,  163,  163, 1058,  163,  163,
			  163,  163,  970,  157,  970, 1058,  163, 1058,  163,  163,
			  163,  163,  972, 1058,  163,  163,  163,  163,  163,  163,
			  157, 1058,  163,  972,  157,  163,  163,  163, 1058,  163,
			  163,  163,  163, 1058, 1058,  163,  974,  157,  973, 1058,
			  157,  163,  163,  163,  157,  976,  163,  157,  163, 1058,

			 1058,  157,  163,  975,  978,  163,  163,  157,  163, 1058,
			 1058,  163, 1058,  163,  157, 1058,  977, 1058,  974,  163,
			  974, 1058,  163,  163, 1058,  163,  163,  976,  163,  163,
			  163, 1058, 1058,  163,  157,  976,  978,  163,  157,  163,
			  163,  981,  163, 1058,  163,  157,  163, 1058,  978,  982,
			  980,  157,  157,  979,  163,  163,  157,  163,  157, 1058,
			  163,  157,  163,  984, 1058,  157,  163,  163, 1058,  157,
			  163,  983,  163,  982,  163, 1058,  163,  163,  157,  985,
			 1058,  982,  980,  163,  163,  980,  163,  163,  163,  163,
			  163, 1058,  163,  163,  163,  984,  163,  163,  163,  163,

			  163,  163,  163,  984,  163,  157, 1058,  986,  163,  157,
			  163,  986,  163,  163,  157,  988,  157, 1058,  157, 1058,
			  157, 1058,  157, 1058,  163,  163,  990,  987,  163,  989,
			  163,  157,  163,  157,  163, 1058,  163,  163,  157,  986,
			  163,  163,  157, 1058,  163,  163,  163,  988,  163,  157,
			  163, 1058,  163,  991,  163,  157,  163,  163,  990,  988,
			  163,  990,  163,  163,  992,  163,  157,  163,  163,  163,
			  163,  163,  163,  163,  163, 1058,  157, 1058,  157,  163,
			  157,  163,  157,  163, 1058,  992, 1058,  163,  163, 1058,
			  163, 1058,  163,  157,  163,  157,  992, 1058,  163,  163,

			  163,  163,  157,  163,  163,  163,  157, 1058,  163, 1058,
			  163,  163,  163, 1058,  163,  163,  163, 1058,  163,  157,
			  163,  163,  163,  163, 1058,  163,  157,  163,  163,  994,
			  157, 1058,  163,  163,  163,  163, 1058,  996,  163, 1058,
			 1058, 1058, 1058,  157, 1058,  993, 1058,  163,  163, 1058,
			  163,  163, 1058,  163,  163,  163,  163, 1058,  163,  157,
			  163,  994,  163,  157,  157,  163,  163,  163,  157,  996,
			  157,  163,  995,  163,  157,  163,  157,  994, 1058,  163,
			 1058,  157,  163,  163,  163, 1058,  163,  157,  163,  997,
			  998,  163, 1058, 1058,  163,  163,  163, 1058,  163, 1058,

			  163, 1058,  163,  163,  996,  163,  163, 1058,  163, 1007,
			 1007, 1007, 1007,  163,  163,  163,  163, 1058, 1058,  163,
			 1058,  998,  998, 1005, 1058, 1008,  163, 1008, 1058, 1058,
			 1009, 1009, 1009, 1009,  157,  157, 1011, 1010,  157,  157,
			 1058, 1058, 1058, 1058,  163,  163,  163,  163,  163,  600,
			 1015,  157,  157, 1013, 1012, 1005,  163,  163,  157, 1058,
			  163, 1058,  157, 1058, 1058, 1058,  163,  163, 1011, 1011,
			  163,  163, 1058, 1058, 1058,  157,  163,  163,  163,  163,
			  163, 1058, 1015,  163,  163, 1013, 1013,  157,  163,  163,
			  163,  157,  163,  157,  163, 1058,  163,  157,  163,  157,

			 1014, 1017, 1016,  157,  157, 1058, 1058,  163,  163,  163,
			  157,  163, 1040, 1040, 1040, 1040,  157, 1058, 1058,  163,
			 1058,  163, 1058,  163, 1058,  163, 1058, 1058,  163,  163,
			  163,  163, 1015, 1017, 1017,  163,  163, 1058, 1058, 1058,
			  163,  163,  163,  163, 1019,  157, 1018,  157,  163,  157,
			 1020,  157,  751,  163,  163, 1021,  163,  157, 1023, 1058,
			  163,  157,  157,  163,  157,  163,  163,  157, 1022, 1058,
			  163,  157, 1058, 1058,  157,  163, 1019,  163, 1019,  163,
			 1058,  163, 1021,  163,  157, 1058,  163, 1021,  163,  163,
			 1023, 1058,  163,  163,  163,  163,  163,  163,  163,  163,

			 1023,  157,  163,  163, 1058,  157,  163,  163,  163,  163,
			  163,  163,  163,  157,  163, 1058,  163,  157,  157, 1024,
			  163,  163, 1025, 1058,  163, 1058, 1058,  163, 1058,  163,
			  157,  157, 1058,  163, 1058,  157, 1058,  163, 1058,  163,
			  163,  163,  163,  163,  163,  163,  163, 1058,  157,  163,
			  163, 1025,  163,  163, 1025, 1058,  163, 1058, 1058,  163,
			  157,  163,  163,  163,  157, 1058,  163,  163,  163,  157,
			 1058,  163,  163,  157, 1027, 1058, 1058,  157,  163, 1058,
			  163, 1058, 1026, 1058,  163,  157,  157, 1058, 1029, 1028,
			 1058, 1058,  163, 1058, 1058,  163,  163,  163,  163, 1058, yy_Dummy>>,
			1, 1000, 8000)
		end

	yy_nxt_template_10 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  163,  163,  157, 1058,  163,  163, 1027,  163,  157,  163,
			  163,  157,  157, 1058, 1027, 1032,  163,  163,  163, 1058,
			 1029, 1029, 1030, 1058, 1058,  157, 1058,  163,  157,  163,
			  163, 1058,  163, 1031,  163, 1058, 1058, 1058, 1058,  163,
			  163, 1058,  163,  163,  163, 1058,  157, 1033, 1034, 1033,
			  157, 1058, 1058, 1058, 1031, 1058,  163,  163,  163, 1058,
			  163, 1058,  163,  157,  163, 1031, 1035,  157,  163, 1058,
			 1058,  157, 1058, 1058,  163,  163, 1058,  163,  163,  157,
			 1035, 1033,  163, 1036,  157, 1037, 1058,  163,  163,  163,
			  163,  163,  163,  157,  163,  163,  157, 1038, 1035,  163,

			  163,  163, 1058,  163,  163, 1058, 1058,  163, 1058,  163,
			  157,  163, 1058, 1039,  157, 1037,  163, 1037,  157,  163,
			  163,  163,  163,  163,  163,  163,  163, 1058,  163, 1039,
			 1058,  157,  163,  163, 1058,  163,  163,  163, 1044, 1044,
			 1044, 1044,  163, 1058,  157, 1039,  163,  163,  157, 1058,
			  163, 1042,  163, 1042,  163, 1058, 1043, 1043, 1043, 1043,
			 1058,  157, 1058,  163,  163, 1058, 1058,  163, 1058,  163,
			  946,  946,  946,  946, 1058,  163,  163,  163,  758,  163,
			  163,  157, 1046, 1058, 1005, 1045,  157,  163, 1058,  163,
			  157,  163,  163,  163,  163,  157, 1058, 1058,  157,  157,

			 1058,  163, 1058,  157,  163, 1058, 1058,  163, 1058,  163,
			  600,  157,  157,  163, 1046,  157, 1005, 1046,  163,  163,
			 1058,  163,  163,  163,  163, 1058,  163,  163,  157, 1058,
			  163,  163, 1058,  163,  157,  163,  163,  163,  157,  163,
			 1048, 1058,  163,  163,  163, 1047,  163,  163,  163,  163,
			  157,  157,  163,  163,  157,  163, 1058, 1058,  163,  157,
			  163, 1058, 1058,  157, 1058,  163,  163,  157, 1058,  163,
			  163,  163, 1048, 1058,  163, 1058,  157, 1048,  163, 1058,
			  163,  163,  163,  163,  163,  163,  163,  163, 1058, 1058,
			  163,  163,  163, 1058,  163,  163,  157,  163, 1058,  163,

			  157,  157,  157, 1058,  163,  157,  157, 1058,  163,  163,
			  163,  163,  163,  157, 1058, 1049, 1058, 1050,  157, 1051,
			 1058,  163,  163,  163,  163,  163,  163, 1058,  163, 1052,
			 1058, 1058,  163,  163,  163,  163,  163,  163,  163, 1058,
			 1058,  163,  163,  163,  163,  163, 1058, 1050,  157, 1050,
			  163, 1052,  157,  163,  163,  163,  163,  163,  163,  157,
			  157, 1052, 1054, 1053,  157,  157, 1058,  163,  163,  163,
			  163,  163,  163,  163, 1058,  163,  157,  157, 1058, 1058,
			  163,  163,  163, 1058,  163,  163, 1058, 1058,  163,  157,
			  163,  163,  163,  157, 1054, 1054,  163,  163, 1058, 1058,

			  163,  163,  163,  163,  163,  163,  157,  163,  163,  163,
			  163, 1058,  163,  163,  163, 1058, 1058,  163, 1058, 1058,
			 1058,  163,  163, 1058, 1058,  163,  999,  999,  999,  999,
			 1055, 1055, 1055, 1055, 1006, 1006, 1006, 1006,  163,  157,
			 1057,  157,  163,  157,  163, 1056,  157,  163, 1058,  163,
			  157, 1058, 1058,  163,  163,  163,  157, 1058,  157,  163,
			 1058, 1058, 1058,  157, 1058,  163,  751, 1058, 1058, 1058,
			  863,  163, 1057,  163,  758,  163,  157, 1057,  163,  163,
			  157,  163,  163, 1058,  163,  163,  163,  163,  163, 1058,
			  163,  163, 1058,  157,  157,  163,  163,  163,  157, 1058,

			 1058,  163, 1058,  163, 1041, 1041, 1041, 1041,  163, 1058,
			  157,  157,  163,  163,  157, 1058,  163,  163,  163,  163,
			 1058, 1058, 1058, 1058, 1058,  163,  163,  157,  163,  163,
			  163, 1058, 1058,  163, 1058,  163, 1058, 1058, 1058, 1058,
			 1058, 1058,  163,  163,  863,  163,  163, 1058, 1058,  163,
			 1058,  163, 1058, 1058, 1058, 1058, 1058, 1058, 1058,  163,
			 1058,  163,   86,   86,   86,   86,   86,   86,   86,   86,
			   86,   86,   86,   86,   86,   86,   86,   86,   86,   86,
			   86,   86,   86,   86,   86,  105,  105, 1058,  105,  105,
			  105,  105,  105,  105,  105,  105,  105,  105,  105,  105,

			  105,  105,  105,  105,  105,  105,  105,  105,  117, 1058,
			 1058, 1058, 1058, 1058, 1058,  117,  117,  117,  117,  117,
			  117,  117,  117,  117,  117,  117,  117,  117,  117,  117,
			  117,  118,  118, 1058,  118,  118,  118,  118,  118,  118,
			  118,  118,  118,  118,  118,  118,  118,  118,  118,  118,
			  118,  118,  118,  118,  126,  126, 1058,  126,  126,  126,
			  126, 1058,  126,  126,  126,  126,  126,  126,  126,  126,
			  126,  126,  126,  126,  126,  126,  126,  145,  145,  145,
			  145,  145,  145,  145,  145,  145,  145,  145,  145,  145,
			  145,  249,  249, 1058,  249,  249,  249, 1058, 1058,  249,

			  249,  249,  249,  249,  249,  249,  249,  249,  249,  249,
			  249,  249,  249,  249,  163,  163,  163,  163,  163,  163,
			  163,  163,  163,  163,  163,  163,  163,  163,  270, 1058,
			 1058,  270, 1058,  270,  270,  270,  270,  270,  270,  270,
			  270,  270,  270,  270,  270,  270,  270,  270,  270,  270,
			  270,  284,  284, 1058,  284,  284,  284,  284,  284,  284,
			  284,  284,  284,  284,  284,  284,  284,  284,  284,  284,
			  284,  284,  284,  284,  285,  285, 1058,  285,  285,  285,
			  285,  285,  285,  285,  285,  285,  285,  285,  285,  285,
			  285,  285,  285,  285,  285,  285,  285,  309,  309, 1058,

			  309,  309,  309,  309,  309,  309,  309,  309,  309,  309,
			  309,  309,  309,  309,  309,  309,  309,  309,  309,  309,
			  335, 1058, 1058, 1058, 1058,  335,  335,  335,  335,  335,
			  335,  335,  335,  335,  335,  335,  335,  335,  335,  335,
			  335,  335,  335,  375,  375,  375,  375,  375,  375,  375,
			  375, 1058,  375,  375,  375,  375,  375,  375,  375,  375,
			  375,  375,  375,  375,  375,  375,  382,  382,  382,  382,
			  382,  382,  382,  382,  382,  382,  382,  382,  382,  384,
			  384,  384,  384,  384,  384,  384,  384,  384,  384,  384,
			  384,  384,  386,  386,  386,  386,  386,  386,  386,  386,

			  386,  386,  386,  386,  386,  280,  280, 1058,  280,  280,
			  280, 1058,  280,  280,  280,  280,  280,  280,  280,  280,
			  280,  280,  280,  280,  280,  280,  280,  280,  281,  281,
			 1058,  281,  281,  281, 1058,  281,  281,  281,  281,  281,
			  281,  281,  281,  281,  281,  281,  281,  281,  281,  281,
			  281,  950,  950,  950,  950,  950,  950,  950,  950, 1058,
			  950,  950,  950,  950,  950,  950,  950,  950,  950,  950,
			  950,  950,  950,  950,    5, 1058, 1058, 1058, 1058, 1058,
			 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058,
			 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058, yy_Dummy>>,
			1, 1000, 9000)
		end

	yy_nxt_template_11 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058,
			 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058,
			 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058,
			 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058,
			 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058,
			 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058,
			 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058,
			 1058, 1058, 1058, 1058, yy_Dummy>>,
			1, 74, 10000)
		end

	yy_chk_template: SPECIAL [INTEGER]
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make (0, 10073)
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
			yy_chk_template_11 (an_array)
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

			    3,    3,    3,    3,   22,   23, 1041,   23,   23,   23,
			   23,    4,    4,    4,    4,   22,   24,   26,  145,   26,
			   26,   26,   26, 1006,   24,   30,   30,  150,   12,  860,
			   26,   12,   32,   32,  999,   15,  380,   16,   15,   16,
			   16,   79,   79,   79,   25,   16,   25,   25,   25,   25,
			   81,   81,   81,   82,   82,  860,    3,   25,   25,   26,
			  145,  860,   26,   83,   83,   83,  610,    4,   27,  150,
			   27,   27,   27,   27,   84,   84,   84,   12,  380,   25,
			  169,  169,  169,  171,  171,  171,   25,    3,  608,   25,
			   25,    3,    3,    3,    3,    3,    3,    3,    4,  146,

			  146,  606,    4,    4,    4,    4,    4,    4,    4,   12,
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

			   36,   36,  946,    8,   36,   36,   36,   36,   37,    7,
			   90,   37,   90,   90,    5,   37,    0,   64,   37,   64,
			   38,   37,   43,    0,   37,   38,   43,   38,  946,   64,
			    0,   39,   38,   38,  946,   39,   43,   38,   39,   43,
			    0,    0,   39,    0,   87,   39,    0,    0,   39,    0,
			    0,   39,   38,    0,   43,    0,   45,   38,   43,   38,
			   45,  605,  605,   39,   38,   38,   90,   39,   43,   38,
			   39,   43,    0,   45,   39,   87,    0,   39,   44,   44,
			   39,   41,   44,   39,    0,   41,   41,    0,   45,   44,
			    0,   44,   45,   41,   41,   44,    0,   90,   41,   41,

			    0,  605,   46,   47,    0,   45,   46,   47,    0,    0,
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

	yy_chk_template_2 (an_array: ARRAY [INTEGER])
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
			  125,  128,    0,    0,  128,  128,  128,  128,  512,  512,
			  512,    0,    0,  128,    0,  131,    0,  158,    0,  178,
			  128,  158,  128,  178,  128,  128,  128,  128,  133,  128,
			    0,  128,    0,    0,  158,  128,  178,  128,  134,    0,
			  128,  128,  128,  128,  128,  128,    0,    0,  135,  158,
			    0,  178,    0,  158,    0,  178,  513,  513,  513,    0,
			    0,  249,  514,  514,  514,    0,  158,    0,  178,  515,
			  515,  515,    0,  130,  130,  130,  130,  130,  130,  130,
			  130,  250,  516,  516,  516,    0,    0,  128,  128,  128,

			  128,  128,  128,  128,  131,  131,  131,  131,  131,  131,
			  131,  131,  131,  131,  517,  517,  517,  133,  133,  133,
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
			  180,  179,    0,  182,  180,  179,    0,  182,  184,  518,
			  518,  518,  181,  177,    0,  177,  181,  184,  179,  180,
			  182,  177,    0,  180,  183,  177,    0,    0,  184,  181,
			  184,  183,  180,  183,    0,  182,  180,    0,  186,  182,
			  184,    0,  185,  183,  185,  186,    0,  186,    0,  187,
			    0,  187,  182,    0,  185,  187,  183,  186,  519,  519,
			  519,  187,    0,  183,    0,  183,    0,  189,    0,    0,

			  186,  189,    0,    0,  185,  183,  185,  186,    0,  186,
			    0,  187,    0,  187,  189,    0,  185,  187,  190,  186,
			  188,  188,  190,  187,  188,  188,    0,    0,  190,  189,
			  190,  192,  191,  189,  191,  192,  190,  188,    0,  188,
			  190,  623,  623,  623,  191,    0,  189,    0,  192,  192,
			  190,    0,  188,  188,  190,    0,  188,  188,    0,    0,
			  190,    0,  190,  192,  191,    0,  191,  192,  190,  188,
			  193,  188,  190,  193,  193,  194,  191,    0,  199,  194,
			  192,  192,  199,    0,  195,    0,  195,  193,  193,  196,
			  194,  195,  194,    0,  194,  199,  195,  196,    0,  196,

			    0,    0,  193,    0,  196,  193,  193,  194,    0,  196,
			  199,  194,    0,  201,  199,  201,  195,    0,  195,  193,
			  193,  196,  194,  195,  194,  201,  194,  199,  195,  196,
			  197,  196,  197,  198,  197,  200,  196,  198,  197,  200,
			  202,  196,  197,    0,  198,  201,    0,  201,    0,  200,
			  198,  202,  200,  202,    0,    0,  203,  201,  203,  203,
			    0,    0,  197,  202,  197,  198,  197,  200,  203,  198,
			  197,  200,  202,    0,  197,  204,  198,    0,    0,  204,
			    0,  200,  198,  202,  200,  202,    0,    0,  203,  205,
			  203,  203,  204,  205,    0,  202,    0,    0,  207,  206, yy_Dummy>>,
			1, 1000, 1000)
		end

	yy_chk_template_3 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  203,  206,  207,  206,  205,    0,  205,  204,  206,  206,
			  208,  204,  208,    0,  206,  207,  209,  206,  209,    0,
			  209,  205,  208,    0,  204,  205,    0,    0,  209,    0,
			  207,  206,    0,  206,  207,  206,  205,    0,  205,    0,
			  206,  206,  208,  211,  208,  211,  206,  207,  209,  206,
			  209,    0,  209,    0,  208,  211,  595,  595,  595,  595,
			  209,  210,    0,  210,  286,  210,  286,  286,  212,  210,
			    0,  210,  212,    0,    0,  211,  210,  211,  212,  210,
			    0,  210,  213,    0,  213,  212,  213,  211,    0,  214,
			  214,    0,  214,  210,    0,  210,  213,  210,    0,  213,

			  212,  210,  214,  210,  212,  607,  607,  607,  210,    0,
			  212,  210,    0,  210,  213,    0,  213,  212,  213,    0,
			  286,  214,  214,  216,  214,    0,  215,  216,  213,    0,
			    0,  213,    0,    0,  214,  215,    0,  215,  215,    0,
			  216,  217,  216,  217,  218,  607,    0,  215,  218,  217,
			    0,  286,    0,  217,    0,  216,    0,    0,  215,  216,
			  219,  218,  218,  219,  219,    0,    0,  215,    0,  215,
			  215,    0,  216,  217,  216,  217,  218,  219,    0,  215,
			  218,  217,  220,  221,  220,  217,  220,  221,  597,  597,
			  597,  597,  219,  218,  218,  219,  219,  223,    0,  220,

			  221,  222,    0,  222,    0,  223,    0,  223,  222,  219,
			  225,    0,  225,  222,  220,  221,  220,  223,  220,  221,
			    0,    0,  225,    0,  226,  224,    0,    0,  226,  223,
			    0,  220,  221,  222,  224,  222,  224,  223,    0,  223,
			  222,  226,  225,  227,  225,  222,  224,    0,    0,  223,
			  227,    0,  227,    0,  225,  231,  226,  224,    0,  231,
			  226,  228,  227,  228,    0,    0,  224,    0,  224,    0,
			  228,  228,  231,  226,  228,  227,  228,  228,  224,  624,
			  624,  624,  227,    0,  227,    0,    0,  231,  725,  725,
			  725,  231,    0,  228,  227,  228,  230,  726,  726,  726,

			  230,    0,  228,  228,  231,    0,  228,  230,  228,  228,
			  229,  230,  229,  230,    0,  232,    0,  232,  229,  232,
			  229,    0,  390,  229,  390,  229,  229,  232,  230,  233,
			  229,  233,  230,    0,  390,  233,  234,    0,    0,  230,
			  234,  233,  229,  230,  229,  230,    0,  232,    0,  232,
			  229,  232,  229,  234,  390,  229,  390,  229,  229,  232,
			  235,  233,  229,  233,  235,    0,  390,  233,  234,  236,
			    0,    0,  234,  233,    0,    0,  236,  235,  236,    0,
			  235,  237,    0,  237,    0,  234,    0,  240,  236,    0,
			  237,  240,  235,  237,    0,    0,  235,    0,    0,  238,

			    0,  236,  238,  238,  240,    0,    0,  238,  236,  235,
			  236,    0,  235,  237,    0,  237,  238,    0,  238,  240,
			  236,    0,  237,  240,  379,  237,  379,  379,  379,  379,
			    0,  238,    0,  239,  238,  238,  240,    0,  239,  238,
			  242,  239,  242,  239,    0,    0,  242,  241,  238,  239,
			  238,  241,  242,  239,  243,  241,    0,  243,    0,  243,
			    0,    0,    0,  244,  241,  239,  379,  244,    0,  243,
			  239,  251,  242,  239,  242,  239,    0,    0,  242,  241,
			  244,  239,  252,  241,  242,  239,  243,  241,  246,  243,
			    0,  243,  246,  253,    0,  244,  241,  245,  389,  244,

			    0,  243,  389,  254,  245,  246,  245,  247,    0,  247,
			    0,  389,  244,  247,  255,  389,  245,    0,    0,  247,
			  246,    0,    0,    0,  246,  256,    0,    0,    0,  245,
			  389,    0,    0,    0,  389,    0,  245,  246,  245,  247,
			    0,  247,    0,  389,    0,  247,    0,  389,  245,    0,
			    0,  247,  251,  251,  251,  251,  251,  251,  251,  251,
			    0,  252,  252,  252,  252,  252,  252,  252,  252,  252,
			  252,    0,  253,  253,    0,  253,  253,  253,  253,  253,
			  253,  253,  254,  254,  254,  254,  254,  254,  254,  254,
			  254,  254,    0,  255,  255,  255,  255,  255,  255,  255,

			  255,  255,  255,  280,  256,    0,    0,  256,  256,  256,
			  256,  256,  256,  256,  271,  271,  271,  271,  271,  271,
			  271,  272,  272,  272,  272,  272,  272,  272,  272,  273,
			  273,  273,  273,  273,  273,  273,  273,  273,  273,  274,
			  274,  281,  274,  274,  274,  274,  274,  274,  274,  275,
			  275,  275,  275,  275,  275,  275,  275,  275,  275,  276,
			  276,  276,  276,  276,  276,  276,  276,  276,  276,  277,
			    0,    0,  277,  277,  277,  277,  277,  277,  277,  283,
			    0,  283,  283,  600,  600,  600,  600,    0,    0,  280,
			  280,  280,  280,  280,  280,  280,  284,    0,    0,  284,

			    0,  284,    0,  285,  284,    0,  285,    0,  285,    0,
			    0,  285,  287,  287,  287,  287,  287,  287,  287,  295,
			  295,  295,  295,  295,  295,  295,    0,  281,  281,  281,
			  281,  281,  281,  281,  288,  283,    0,  288,    0,  288,
			    0,    0,  288,  289,    0,    0,  289,    0,  289,    0,
			    0,  289,    0,  290,    0,    0,  290,    0,  290,    0,
			  387,  290,  387,  387,  387,  387,  283,    0,    0,    0,
			  283,  283,  283,  283,  283,  283,  283,  291,    0,    0,
			  291,    0,  291,    0,    0,  291,    0,  284,  284,  284,
			  284,  284,  284,  284,  285,  285,  285,  285,  285,  285,

			  285,  292,  387,    0,  292,    0,  292,    0,    0,  292,
			    0,  293,    0,    0,  293,    0,  293,    0,  388,  293,
			  388,  388,  388,  388,    0,  288,  288,  288,  288,  288,
			  288,  288,    0,  289,  289,  289,  289,  289,  289,  289,
			  289,  290,  290,  290,  290,  290,  290,  290,  290,  290,
			  290,  294,    0,    0,  294,    0,  294,    0,    0,  294,
			  388,  601,  601,  601,  601,  291,  291,    0,  291,  291,
			  291,  291,  291,  291,  291,  296,    0,    0,  296,    0,
			  296,    0,    0,  296,    0,  596,  596,  596,  596,  292,
			  292,  292,  292,  292,  292,  292,  292,  292,  292,  293,

			  293,  293,  293,  293,  293,  293,  293,  293,  293,  297,
			    0,    0,  297,    0,  297,    0,    0,  297,    0,  298,
			    0,  394,  298,  394,  298,  596,    0,  298,    0,  299,
			    0,    0,  299,  394,  299,    0,    0,  299,    0,  294,
			    0,    0,  294,  294,  294,  294,  294,  294,  294,  300,
			    0,    0,  300,  394,  300,  394,    0,  300,  303,  303,
			  303,  303,  303,  303,  303,  394,  296,  296,  296,  296,
			  296,  296,  296,  301,    0,    0,  301,    0,  301,    0,
			    0,  301,    0,  302,    0,    0,  302,    0,  302,    0,
			    0,  302,  304,  304,  304,  304,  304,  304,  304,  297, yy_Dummy>>,
			1, 1000, 2000)
		end

	yy_chk_template_4 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  297,  297,  297,  297,  297,  297,  297,  298,  298,  298,
			  298,  298,  298,  298,  298,  298,  298,  299,  299,    0,
			  299,  299,  299,  299,  299,  299,  299,  305,  305,  305,
			  305,  305,  305,  305,    0,    0,    0,  300,  300,  300,
			  300,  300,  300,  300,  300,  300,  300,  306,  306,  306,
			  306,  306,  306,  306,  309,    0,    0,  309,    0,    0,
			    0,  301,  301,  301,  301,  301,  301,  301,  301,  301,
			  301,  302,    0,    0,  302,  302,  302,  302,  302,  302,
			  302,  307,  307,  307,  307,  307,  307,  307,  307,  307,
			  307,  308,  308,  308,  308,  308,  308,  308,  308,  308,

			  308,  310,  391,    0,  310,    0,  391,    0,  311,    0,
			    0,  311,    0,    0,    0,  312,  392,    0,  312,  391,
			  392,    0,  313,    0,    0,  313,  393,    0,  312,  312,
			  312,  312,  314,  392,  391,  314,    0,  393,  391,  393,
			  309,  309,  309,  309,  309,  309,  309,  315,  392,  393,
			  315,  391,  392,  751,  751,  751,  751,  316,  393,    0,
			  316,  752,  752,  752,  752,  392,    0,  317,    0,  393,
			  317,  393,  754,  754,  754,  754,    0,  318,    0,    0,
			  318,  393,  756,  756,  756,  756,    0,  310,  310,  310,
			  310,  310,  310,  310,  311,  311,  311,  311,  311,  311,

			  311,  312,  312,  312,  312,  312,  312,  312,  313,  313,
			  313,  313,  313,  313,  313,    0,  335,    0,  314,  314,
			  314,  314,  314,  314,  314,  319,    0,    0,  319,    0,
			    0,    0,  315,  315,  315,  315,  315,  315,  315,  315,
			  316,  316,  316,  316,  316,  316,  316,  316,  316,  316,
			  317,  317,  337,  317,  317,  317,  317,  317,  317,  317,
			  318,  318,  318,  318,  318,  318,  318,  318,  318,  318,
			  320,    0,    0,  320,    0,    0,    0,  321,    0,  321,
			  321,    0,  321,    0,    0,  321,    0,    0,    0,  322,
			    0,  322,  322,    0,  322,    0,    0,  322,  335,  335,

			  335,  335,  335,  335,  335,    0,  521,    0,  319,  319,
			  319,  319,  319,  319,  319,  319,  319,  319,  323,    0,
			    0,  323,  548,  548,  548,  548,  548,  548,  548,    0,
			  324,  321,    0,  324,  337,  337,  337,  337,  337,  337,
			  337,    0,  325,  322,    0,  325,  758,  758,  758,  758,
			    0,  329,    0,  320,  329,    0,  320,  320,  320,  320,
			  320,  320,  320,  321,    0,    0,    0,  323,  321,  321,
			  321,  321,  321,  321,  321,  322,    0,    0,    0,  324,
			  322,  322,  322,  322,  322,  322,  322,  326,    0,    0,
			  326,  325,  521,  521,  521,  521,  521,  521,  521,  323,

			  327,    0,    0,  327,  323,  323,  323,  323,  323,  323,
			  323,  324,  328,    0,    0,  328,  324,  324,  324,  324,
			  324,  324,  324,  325,  330,    0,    0,  330,  325,  325,
			  325,  325,  325,  325,  325,  522,  326,  329,  329,  329,
			  329,  329,  329,  329,  331,    0,    0,  331,    0,  327,
			  599,  332,  599,    0,  332,  599,  599,  599,  599,    0,
			    0,  328,  333,    0,    0,  333,    0,    0,  326,  602,
			  602,  602,  602,  326,  326,  326,  326,  326,  326,  326,
			  338,  327,    0,  327,  327,  327,  327,  327,  327,  327,
			  327,  327,  327,  328,  339,  328,  328,  328,  328,  328,

			  328,  328,  328,  328,  328,  334,    0,    0,  334,  602,
			  330,  330,  330,  330,  330,  330,  330,    0,    0,  340,
			  522,  522,  522,  522,  522,  522,  522,  522,    0,  341,
			  331,  331,  331,  331,  331,  331,  331,  332,  332,  332,
			  332,  332,  332,  332,  342,  333,  333,  333,  333,  333,
			  333,  333,  333,  333,  333,  343,  859,  859,  859,  859,
			    0,  338,  338,  338,  338,  338,  338,  338,  338,  344,
			    0,    0,    0,  339,  339,  339,  339,  339,  339,  339,
			  339,  339,  339,  345,  863,  863,  863,  863,  334,  334,
			  334,  334,  334,  334,  334,  334,  334,  334,  340,  340,

			  347,  340,  340,  340,  340,  340,  340,  340,  341,  341,
			  341,  341,  341,  341,  341,  341,  341,  341,  348,  864,
			  864,  864,  864,  342,  342,  342,  342,  342,  342,  342,
			  342,  342,  342,    0,  343,  349,    0,  343,  343,  343,
			  343,  343,  343,  343,  349,  349,  349,  349,  350,    0,
			    0,  344,  344,  344,  344,  344,  344,  344,  351,  395,
			    0,    0,    0,  395,    0,  345,  345,  345,  345,  345,
			  345,  345,  352,    0,    0,    0,  395,  399,    0,  353,
			    0,  399,  347,  347,  347,  347,  347,  347,  347,  354,
			    0,  395,    0,    0,  399,  395,  355,    0,    0,    0,

			  348,  348,  348,  348,  348,  348,  348,  356,  395,  399,
			    0,    0,    0,  399,  357,    0,    0,  349,  349,  349,
			  349,  349,  349,  349,  358,    0,  399,    0,    0,    0,
			  350,  350,  350,  350,  350,  350,  350,  359,    0,    0,
			  351,  351,  351,  351,  351,  351,  351,  360,    0,    0,
			    0,  529,    0,    0,  352,  352,  352,  352,  352,  352,
			  352,  353,  353,  353,  353,  353,  353,  353,  361,    0,
			    0,  354,  354,  354,  354,  354,  354,  354,  355,  355,
			  355,  355,  355,  355,  355,  362,    0,    0,    0,  356,
			  356,  356,  356,  356,  356,  356,  357,  357,  357,  357,

			  357,  357,  357,  363,    0,    0,  358,  358,  358,  358,
			  358,  358,  358,  364,    0,  396,    0,  396,    0,  359,
			  359,  359,  359,  359,  359,  359,  365,  396,    0,  360,
			  360,  360,  360,  360,  360,  360,  366,  529,  529,  529,
			  529,  529,  529,  529,  407,    0,  367,  396,  407,  396,
			  361,  361,  361,  361,  361,  361,  361,  368,    0,  396,
			    0,  407,    0,    0,  506,    0,    0,  362,  362,  362,
			  362,  362,  362,  362,  369,    0,  407,    0,    0,    0,
			  407,    0,    0,    0,  370,  363,  363,  363,  363,  363,
			  363,  363,    0,  407,  371,  364,  364,  364,  364,  364,

			  364,  364,  866,  866,  866,  866,    0,    0,  365,  365,
			  365,  365,  365,  365,  365,  366,  366,  366,  366,  366,
			  366,  366,  366,  366,  366,  367,  367,  367,  367,  367,
			  367,  367,  367,  367,  367,    0,  368,  368,  368,  368,
			  368,  368,  368,  368,  368,  368,  506,  506,  506,  506,
			  506,  506,  506,  369,  369,  369,  369,  369,  369,  369,
			  369,  369,  369,  370,  370,  370,  370,  370,  370,  370,
			  370,  370,  370,  371,  371,  371,  371,  371,  371,  371,
			  371,  371,  371,  376,  376,  376,  376,  408,  378,  408,
			  378,  378,  378,  378,    0,    0,    0,  376,    0,  408, yy_Dummy>>,
			1, 1000, 3000)
		end

	yy_chk_template_5 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			    0,  378,    0,  750,  750,  750,  750,    0,  429,    0,
			  429,  549,  549,  549,  549,  549,  549,  549,    0,  408,
			  429,  408,    0,  376,  397,    0,    0,    0,  397,  376,
			  378,  408,  397,  378,  385,  385,  385,  385,    0,    0,
			  429,  397,  429,  750,  385,  385,  385,  385,  385,  385,
			  398,    0,  429,  398,    0,  398,  397,    0,    0,    0,
			  397,    0,    0,    0,  397,  398,    0,  409,    0,  409,
			    0,  409,    0,  397,  385,  400,  385,  385,  385,  385,
			  385,  385,  398,    0,  409,  398,  400,  398,  400,    0,
			    0,  410,  400,  939,  939,  939,  939,  398,  400,  409,

			  410,  409,  410,  409,  411,    0,    0,  400,  411,    0,
			  413,    0,  410,    0,  413,    0,  409,    0,  400,    0,
			  400,  411,  411,  410,  400,    0,  412,  413,  412,    0,
			  400,  413,  410,  412,  410,  414,  411,  414,  412,  415,
			  411,    0,  413,  415,  410,  414,  413,  414,    0,    0,
			    0,  416,    0,  411,  411,    0,  415,    0,  412,  413,
			  412,    0,  416,  413,  416,  412,    0,  414,  417,  414,
			  412,  415,  417,    0,  416,  415,    0,  414,  418,  414,
			  418,    0,  419,  416,  418,  417,  419,    0,  415,    0,
			  418,  420,    0,    0,  416,  420,  416,    0,  424,  419,

			  417,    0,  419,  421,  417,    0,  416,  421,  420,  424,
			  418,  424,  418,    0,  419,    0,  418,  417,  419,    0,
			  421,  424,  418,  420,  422,    0,  422,  420,    0,    0,
			  424,  419,    0,  422,  419,  421,  422,    0,  423,  421,
			  420,  424,  425,  424,    0,  423,  425,  423,  749,  749,
			  749,  749,  421,  424,  426,    0,  422,  423,  422,  425,
			    0,  426,  749,  426,    0,  422,    0,  427,  422,    0,
			  423,  427,    0,  426,  425,    0,    0,  423,  425,  423,
			    0,  428,    0,    0,  427,  428,  426,    0,  430,  423,
			  430,  425,  431,  426,  749,  426,  431,  430,  428,  427,

			  430,  428,    0,  427,  432,  426,  431,    0,  432,  431,
			    0,    0,  433,  428,    0,    0,  427,  428,    0,    0,
			  430,  432,  430,  433,  431,  433,  433,    0,  431,  430,
			  428,    0,  430,  428,    0,  433,  432,    0,  431,    0,
			  432,  431,  434,    0,  433,    0,  435,    0,    0,  434,
			  435,  434,  437,  432,    0,  433,  437,  433,  433,    0,
			  442,  434,  442,  435,  435,    0,    0,  433,  436,  437,
			  436,  437,  442,    0,  434,  436,    0,  438,  435,  438,
			  436,  434,  435,  434,  437,  438,    0,    0,  437,  438,
			    0,    0,  442,  434,  442,  435,  435,    0,    0,    0,

			  436,  437,  436,  437,  442,    0,  439,  436,    0,  438,
			  439,  438,  436,  440,  440,  440,    0,  438,  439,    0,
			  443,  438,  441,  439,  443,  440,  441,  440,    0,    0,
			    0,  439,  444,  441,    0,    0,  444,  443,  439,  441,
			  444,    0,  439,    0,  445,  440,  440,  440,  445,  444,
			  439,    0,  443,    0,  441,  439,  443,  440,  441,  440,
			    0,  445,  446,  439,  444,  441,  446,    0,  444,  443,
			  447,  441,  444,    0,  447,    0,  445,  446,    0,  446,
			  445,  444,  448,    0,    0,  449,    0,  447,  449,  448,
			  449,  448,    0,  445,  446,  451,  450,  451,  446,  451,

			  449,  448,  447,  450,    0,  450,  447,  451,  453,  446,
			    0,  446,  453,  452,  448,  450,    0,  449,    0,  447,
			  449,  448,  449,  448,  452,  453,  452,  451,  450,  451,
			    0,  451,  449,  448,  454,  450,  452,  450,  455,  451,
			  453,  454,  455,  454,  453,  452,  456,  450,    0,  457,
			  456,    0,    0,  454,    0,  455,  452,  453,  452,    0,
			  457,  456,  457,  456,    0,  458,  454,  458,  452,  458,
			  455,    0,  457,  454,  455,  454,    0,  458,  456,  459,
			    0,  457,  456,  459,    0,  454,  463,  455,    0,    0,
			  463,  460,  457,  456,  457,  456,  459,  458,  460,  458,

			  460,  458,  461,  463,  457,  462,  461,  462,  462,  458,
			  460,  459,  464,    0,  464,  459,  461,  462,  463,  461,
			    0,    0,  463,  460,  464,    0,    0,    0,  459,    0,
			  460,    0,  460,    0,  461,  463,    0,  462,  461,  462,
			  462,  465,  460,  466,  464,  465,  464,    0,  461,  462,
			  466,  461,  466,    0,    0,  467,  464,  467,  465,  467,
			  467,    0,  466,  469,    0,  468,  470,  469,  468,    0,
			  470,    0,  467,  465,  468,  466,  468,  465,    0,    0,
			  469,    0,  466,  470,  466,    0,  468,  467,    0,  467,
			  465,  467,  467,    0,  466,  469,    0,  468,  470,  469,

			  468,    0,  470,  471,  467,  472,  468,  471,  468,  472,
			    0,    0,  469,    0,    0,  470,    0,  474,  468,    0,
			  471,  474,  472,    0,    0,  472,  473,    0,  473,  475,
			  473,    0,    0,    0,  474,  471,  475,  472,  475,  471,
			    0,  472,    0,  473,    0,    0,  473,    0,  475,  474,
			    0,    0,  471,  474,  472,    0,  477,  472,  473,    0,
			  473,  475,  473,    0,  476,    0,  474,  477,  475,  477,
			  475,  476,  478,  476,  478,  473,  479,    0,  473,  477,
			  475,  478,    0,  476,  478,  479,    0,  479,  477,    0,
			  755,  755,  755,  755,  479,    0,  476,  479,    0,  477,

			    0,  477,    0,  476,  478,  476,  478,    0,  479,  484,
			    0,  477,  480,  478,  480,  476,  478,  479,  480,  479,
			  484,  481,  484,  482,  480,  481,  479,  482,  483,  479,
			  755,    0,  484,    0,    0,  483,    0,  483,  481,    0,
			  482,  484,    0,    0,  480,    0,  480,  483,    0,    0,
			  480,    0,  484,  481,  484,  482,  480,  481,  485,  482,
			  483,  487,  485,    0,  484,  487,  485,  483,  486,  483,
			  481,  486,  482,  486,  487,  485,    0,    0,  487,  483,
			  488,    0,  488,  486,  489,    0,    0,  491,  489,    0,
			  485,  491,  488,  487,  485,    0,    0,  487,  485,    0,

			  486,  489,  490,  486,  491,  486,  487,  485,    0,  490,
			  487,  490,  488,  492,  488,  486,  489,  492,  493,  491,
			  489,  490,  493,  491,  488,    0,  493,    0,    0,  492,
			  492,    0,    0,  489,  490,  493,  491,  494,    0,    0,
			    0,  490,    0,  490,  494,  492,  494,    0,    0,  492,
			  493,    0,    0,  490,  493,  503,  494,    0,  493,  503,
			    0,  492,  492,  495,    0,  495,    0,  493,  495,  494,
			    0,    0,  503,    0,  496,  495,  494,  496,  494,  496,
			    0,    0,  497,    0,    0,    0,  497,  503,  494,  496,
			  497,  503,    0,  498,    0,  495,  498,  495,  498,  497, yy_Dummy>>,
			1, 1000, 4000)
		end

	yy_chk_template_6 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  495,    0,    0,    0,  503,    0,  496,  495,  498,  496,
			  507,  496,  499,    0,  497,  499,  499,  508,  497,    0,
			  501,  496,  497,    0,  501,  498,  500,  509,  498,  499,
			  498,  497,    0,  501,  500,    0,  500,  501,  510,  502,
			  498,  502,    0,  504,  499,  504,  500,  499,  499,  511,
			    0,  502,  501,    0,    0,  504,  501,  523,  500,    0,
			    0,  499,    0,    0,    0,  501,  500,  524,  500,  501,
			    0,  502,    0,  502,    0,  504,    0,  504,  500,  525,
			    0,    0,    0,  502,    0,    0,    0,  504,    0,  526,
			    0,    0,  507,  507,  507,  507,  507,  507,  507,  508,

			  508,  508,  508,  508,  508,  508,  527,    0,    0,  509,
			  509,  509,  509,  509,  509,  509,  530,  510,  510,  510,
			  510,  510,  510,  510,  510,  510,  510,  531,  511,  511,
			  511,  511,  511,  511,  511,  511,  511,  511,  532,    0,
			  523,  523,  523,  523,  523,  523,  523,  523,  523,  523,
			  524,  524,  533,  524,  524,  524,  524,  524,  524,  524,
			    0,    0,  525,  525,  525,  525,  525,  525,  525,  525,
			  525,  525,  526,  526,  526,  526,  526,  526,  526,  526,
			  526,  526,  534,  757,  757,  757,  757,    0,    0,  527,
			    0,    0,  527,  527,  527,  527,  527,  527,  527,  535,

			    0,  530,  530,  530,  530,  530,  530,  530,  530,    0,
			  531,  531,  531,  531,  531,  531,  531,  531,  531,  531,
			    0,  532,  532,  757,  532,  532,  532,  532,  532,  532,
			  532,  940,  940,  940,  940,  533,  533,  533,  533,  533,
			  533,  533,  533,  533,  533,  536,    0,    0,  536,    0,
			  536,    0,  537,  536,    0,  537,    0,  537,    0,  604,
			  537,  604,  604,  604,  604,  534,  534,  534,  534,  534,
			  534,  534,  534,  534,  534,  538,    0,    0,  538,    0,
			  538,    0,  535,  538,    0,  535,  535,  535,  535,  535,
			  535,  535,  539,    0,    0,  539,    0,  539,    0,    0,

			  539,  604,  540,    0,    0,  540,    0,  540,    0,    0,
			  540,    0,  541,    0,    0,  541,    0,  541,    0,  542,
			  541,    0,  542,    0,  542,    0,  543,  542,    0,  543,
			    0,  543,    0,    0,  543,    0,  536,  536,  536,  536,
			  536,  536,  536,  537,  537,  537,  537,  537,  537,  537,
			  544,    0,    0,  544,    0,  544,    0,  545,  544,    0,
			  545,    0,  545,    0,    0,  545,  538,  538,  538,  538,
			  538,  538,  538,  546,    0,    0,  546,    0,  546,    0,
			    0,  546,    0,  539,  539,  539,  539,  539,  539,  539,
			  540,  540,  540,  540,  540,  540,  540,  540,  540,  540,

			  541,  541,  541,  541,  541,  541,  541,  541,  541,  541,
			  542,  542,  542,  542,  542,  542,  542,  543,  543,  543,
			  543,  543,  543,  543,  547,    0,    0,  547,    0,  547,
			    0,    0,  547,    0,    0,    0,  550,    0,    0,  550,
			    0,  544,  544,  544,  544,  544,  544,  544,  545,  545,
			  545,  545,  545,  545,  545,  551,    0,    0,  551,    0,
			    0,  546,  546,  546,  546,  546,  546,  546,  546,  546,
			  546,  552,    0,    0,  552,    0,    0,    0,  553,    0,
			    0,  553,    0,  552,  552,  552,  552,  552,  554,    0,
			    0,  554,    0,    0,    0,  555,    0,    0,  555,    0,

			    0,  857,  556,  857,  553,  556,  857,  857,  857,  857,
			    0,    0,  547,  547,  547,  547,  547,  547,  547,  547,
			  547,  547,  550,  550,  550,  550,  550,  550,  550,  557,
			    0,  611,  557,  611,  611,  611,  611,  941,  941,  941,
			  941,  551,  551,  551,  551,  551,  551,  551,  558,    0,
			    0,  558,  945,  945,  945,  945,    0,  552,  552,  552,
			  552,  552,  552,  552,  553,  553,  553,  553,  553,  553,
			  553,    0,    0,  611,  554,  554,  554,  554,  554,  554,
			  554,  555,  555,  555,  555,  555,  555,  555,  556,  556,
			  556,  556,  556,  556,  556,  559,    0,    0,  559,    0,

			  603,    0,  603,  603,  603,  603,    0,  560,    0,    0,
			  560,    0,    0,  603,    0,  557,  557,  557,  557,  557,
			  557,  557,  561,    0,    0,  561,  947,  947,  947,  947,
			  727,  558,  558,  558,  558,  558,  558,  558,  558,  558,
			  558,  562,  603,    0,  562,  603,    0,    0,  563,    0,
			  612,  563,  612,  612,  612,  612,  560,    0,    0,  564,
			    0,  594,  594,  594,  594,    0,  565,  948,  948,  948,
			  948,  561,    0,  566,    0,  594,    0,  728,  559,  559,
			  559,  559,  559,  559,  559,  559,  559,  559,  560,  567,
			    0,    0,  612,  560,  560,  560,  560,  560,  560,  560,

			  568,  594,    0,  561,    0,    0,    0,  594,  561,  561,
			  561,  561,  561,  561,  561,  569,  727,  727,  727,  727,
			  727,  727,  727,  723,    0,    0,    0,  562,  562,  562,
			  562,  562,  562,  562,  563,  563,  563,  563,  563,  563,
			  563,  564,  564,  564,  564,  564,  564,  564,  565,  565,
			  565,  565,  565,  565,  565,  566,  566,  566,  566,  566,
			  566,  566,  592,  728,  728,  728,  728,  728,  728,  728,
			    0,  567,  567,  567,  567,  567,  567,  567,  593,  568,
			  568,  568,  568,  568,  568,  568,  568,  568,  568,  858,
			  858,  858,  858,    0,  569,  569,  569,  569,  569,  569,

			  569,  569,  569,  569,  575,  723,  723,  723,  723,  723,
			  723,  723,  575,  575,  575,  575,  575,  949,  949,  949,
			  949,    0,  759,  759,  759,  759,    0,    0,  760,  858,
			  760,  760,  760,  760,    0,    0,  759,  598,  598,  598,
			  598,  592,  592,  592,  592,  592,  592,  592,  592,  592,
			  592,  598, 1000, 1000, 1000, 1000,    0,  593,  593,  593,
			  593,  593,  593,  593,  593,  593,  593,  614,  759,  614,
			  760,  861,  861,  861,  861,  614,  613,  598,    0,  614,
			  613,    0,    0,  598,    0,  861,  575,  575,  575,  575,
			  575,  575,  575,  613,    0,  613,  615,    0,    0,  614,

			  615,  614,    0,  616,    0,  616,    0,  614,  613,    0,
			  616,  614,  613,  615,  615,  616,  617,  861,    0,  618,
			  617,    0,  617,    0,  618,  613,  618,  613,  615,    0,
			    0,    0,  615,  617,    0,  616,  618,  616, 1002, 1002,
			 1002, 1002,  616,    0,    0,  615,  615,  616,  617,    0,
			    0,  618,  617,  619,  617,  619,  618,  619,  618,  620,
			  621,    0,  625,  620,    0,  617,  625,  620,  618,  621,
			  619,  621,  625,    0,    0,  622,  620,    0,  622,  625,
			  622,  621,    0,  626,  626,  619,  626,  619,    0,  619,
			  622,  620,  621,    0,  625,  620,  626,    0,  625,  620, yy_Dummy>>,
			1, 1000, 5000)
		end

	yy_chk_template_7 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			    0,  621,  619,  621,  625,    0,    0,  622,  620,    0,
			  622,  625,  622,  621,    0,  626,  626,  627,  626,    0,
			    0,  627,  622,  629,  628,  631,  628,  629,  626,  631,
			    0,  628,  630,  633,  627,  627,  628,  633,    0,  630,
			  629,  630,  631,    0,  631, 1003, 1003, 1003, 1003,  627,
			  633,  630,    0,  627,    0,  629,  628,  631,  628,  629,
			    0,  631,    0,  628,  630,  633,  627,  627,  628,  633,
			    0,  630,  629,  630,  631,    0,  631,  632,    0,  632,
			  635,  634,  633,  630,  635,  632,  635,  636,  634,  632,
			  634,  637,  636,    0,  636,  637,    0,  635,    0,    0,

			  634,    0,    0,    0,  636,    0,    0,    0,  637,  632,
			    0,  632,  635,  634,    0,    0,  635,  632,  635,  636,
			  634,  632,  634,  637,  636,    0,  636,  637,    0,  635,
			  640,  638,  634,  638,    0,    0,  636,  638,    0,  640,
			  637,  640,  639,  638,  639,  642,  639,    0,  642,  641,
			  642,  640,    0,  641,    0,    0,    0,  641,    0,  639,
			  642,    0,  640,  638,    0,  638,  641,    0,    0,  638,
			    0,  640,    0,  640,  639,  638,  639,  642,  639,    0,
			  642,  641,  642,  640,  643,  641,    0,    0,  643,  641,
			  645,  639,  642,  644,  645,  644,  646,    0,  641,  644,

			  646,  643,  647,  645,  647,  644,  648,  645,  648,    0,
			    0,    0,  648,  646,  647,    0,  643,  650,  648,  650,
			  643,    0,  645,  650,    0,  644,  645,  644,  646,  650,
			    0,  644,  646,  643,  647,  645,  647,  644,  648,  645,
			  648,    0,    0,  649,  648,  646,  647,  649,  651,  650,
			  648,  650,  651,    0,  653,  650,    0,  652,  653,    0,
			  649,  650,    0,    0,  652,  651,  652,    0,  655,    0,
			    0,  653,  655,    0,  653,  649,  652,  656,    0,  649,
			  651,  656,    0,    0,  651,  655,  653,    0,    0,  652,
			  653,    0,  649,  654,  656,  654,  652,  651,  652,  657,

			  655,  657,  654,  653,  655,  654,  653,    0,  652,  656,
			    0,  657,  659,  656,    0,    0,  659,  655,    0,    0,
			  659,  658,    0,    0,    0,  654,  656,  654,  658,  659,
			  658,  657,    0,  657,  654,    0,  660,  654,    0,  660,
			  658,  660,  661,  657,  659,  662,  661,  662,  659,    0,
			    0,  660,  659,  658,    0,    0,    0,  662,    0,  661,
			  658,  659,  658,  663,  664,  661,  664,  663,  660,    0,
			    0,  660,  658,  660,  661,    0,  664,  662,  661,  662,
			  663,    0,    0,  660,  665,    0,  663,    0,  665,  662,
			  667,  661,    0,    0,  667,  663,  664,  661,  664,  663,

			    0,  665,  669,  666,  668,  666,  669,  667,  664,  666,
			    0,  668,  663,  668,    0,  666,  665,    0,  663,  669,
			  665,    0,  667,  668,    0,    0,  667,  671,    0,    0,
			    0,  671,    0,  665,  669,  666,  668,  666,  669,  667,
			  670,  666,  670,  668,  671,  668,  670,  666,  672,    0,
			  672,  669,  670,  673,  674,  668,  674,  673,  675,  671,
			  672,    0,  675,  671,  673,  676,  674,  676,    0,  678,
			  673,  678,  670,    0,  670,  675,  671,  676,  670,    0,
			  672,  678,  672,  677,  670,  673,  674,  677,  674,  673,
			  675,    0,  672,  680,  675,  680,  673,  676,  674,  676,

			  677,  678,  673,  678,  681,  680,  679,  675,  681,  676,
			  679,    0,  682,  678,  682,  677,    0,  679,    0,  677,
			    0,  681,    0,  679,  682,  680,    0,  680,    0,    0,
			  683,  684,  677,    0,  683,  684,  681,  680,  679,  684,
			  681,    0,  679,    0,  682,    0,  682,  683,  684,  679,
			  683,    0,  685,  681,  685,  679,  682,  862,  862,  862,
			  862,  685,  683,  684,  685,    0,  683,  684,    0,    0,
			  686,  684,  687,  686,    0,  686,  687,  687,    0,  683,
			  684,    0,  683,    0,  685,  686,  685,    0,    0,  687,
			    0,    0,  688,  685,    0,  689,  685,  862,  688,  689,

			  688,    0,  686,    0,  687,  686,    0,  686,  687,  687,
			  688,    0,  689,  690,    0,  690,  691,  686,    0,  690,
			  691,  687,    0,    0,  688,  690,    0,  689,  691,    0,
			  688,  689,  688,  691,  692,  692,  692,    0,  694,    0,
			    0,  694,  688,  694,  689,  690,  692,  690,  691,    0,
			    0,  690,  691,  694,  693,    0,    0,  690,  693,  695,
			  691,    0,  693,  695,    0,  691,  692,  692,  692,    0,
			  694,  693,  697,  694,  697,  694,  695,    0,  692,  695,
			    0,  697,    0,    0,  697,  694,  693,    0,  696,    0,
			  693,  695,  696,    0,  693,  695,    0,  699,  698,  696,

			  698,  699,    0,  693,  697,  696,  697,    0,  695,    0,
			  698,  695,    0,  697,  699,  700,  697,  700,    0,    0,
			  696,  699,  703,    0,  696,    0,  703,  700,  700,  699,
			  698,  696,  698,  699,  701,    0,  701,  696,  701,  703,
			    0,  702,  698,    0,    0,    0,  699,  700,    0,  700,
			  702,  701,  702,  699,  703,  704,    0,  704,  703,  700,
			  700,  704,  702,    0,    0,    0,  701,  704,  701,    0,
			  701,  703,    0,  702,  706,  705,  706,    0,  706,  705,
			    0,  707,  702,  701,  702,  707,  706,  704,    0,  704,
			  705,    0,  705,  704,  702,    0,    0,  709,  707,  704,

			  708,  709,  708,  710,    0,  710,  706,  705,  706,    0,
			  706,  705,  708,  707,  709,  710,    0,  707,  706,  713,
			    0,  711,  705,  713,  705,  711,  711,    0,    0,  709,
			  707,    0,  708,  709,  708,  710,  713,  710,  711,  713,
			    0,    0,  712,    0,  708,  715,  709,  710,  712,  715,
			  712,  713,  714,  711,  714,  713,  715,  711,  711,    0,
			  712,  714,  715,  716,  714,  716,    0,    0,  713,    0,
			  711,  713,  717,    0,  712,  716,  717,  715,  724,    0,
			  712,  715,  712,  729,  714,    0,  714,  718,  715,  717,
			  730,    0,  712,  714,  715,  716,  714,  716,  718,  719,

			  718,  721,  731,  719,  717,  721,    0,  716,  717,    0,
			  718,  720,  722,  720,  722,  732,  719,    0,  721,  718,
			    0,  717,  733,  720,  722, 1004, 1004, 1004, 1004,  734,
			  718,  719,  718,  721,    0,  719,  735,  721,  868,  868,
			  868,  868,  718,  720,  722,  720,  722,  736,  719,    0,
			  721,    0,  868,    0,    0,  720,  722,  737,    0,    0,
			  724,  724,  724,  724,  724,  724,  724,  738,    0,  729,
			  729,  729,  729,  729,  729,  729,  730,  730,  730,  730,
			  730,  730,  730,    0,  868,  731,  731,  731,  731,  731,
			  731,  731,  731,  731,  731,    0,    0,    0,  732,  732, yy_Dummy>>,
			1, 1000, 6000)
		end

	yy_chk_template_8 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  732,  732,  732,  732,  732,  732,  732,  732,  733,  733,
			  733,  733,  733,  733,  733,  734,  734,  734,  734,  734,
			  734,  734,  735,  735,  735,  735,  735,  735,  735,  744,
			    0,    0,  744,  736,  736,  736,  736,  736,  736,  736,
			  737,  737,  737,  737,  737,  737,  737,  737,  737,  737,
			  738,  738,  738,  738,  738,  738,  738,  738,  738,  738,
			  739,  746,    0,  739,    0,  739,    0,  740,  739,    0,
			  740,    0,  740,    0,  741,  740,    0,  741,    0,  741,
			    0,  742,  741,    0,  742,    0,  742,    0,    0,  742,
			    0,    0,  762,  743,  762,    0,  743,    0,    0,    0,

			  745,    0,    0,  745,  762,  743,  743,  743,  743,  743,
			    0,  747,    0,    0,    0,  744,  744,  744,  744,  744,
			  744,  744,  748,  867,  762,  867,  762,    0,  867,  867,
			  867,  867,  942,    0,  942,    0,  762,  942,  942,  942,
			  942,    0,    0,  746,  746,  746,  746,  746,  746,  746,
			    0,  739,  739,  739,  739,  739,  739,  739,  740,  740,
			  740,  740,  740,  740,  740,  741,  741,  741,  741,  741,
			  741,  741,  742,  742,  742,  742,  742,  742,  742,  743,
			  743,  743,  743,  743,  743,  743,  745,  745,  745,  745,
			  745,  745,  745,  747,  747,  747,  747,  747,  747,  747,

			  753,  753,  753,  753,  748,  748,  748,  748,  748,  748,
			  748,  761,  763,    0,  753,  761,  763,    0,  764,  765,
			  764,  768,  766,  765,  766,  768,    0,  768,  761,  763,
			  764,    0,  765,    0,  766,    0,  765,  768,    0,    0,
			  753,  769,  769,  761,  763,  769,  753,  761,  763,    0,
			  764,  765,  764,  768,  766,  765,  766,  768,  769,  768,
			  761,  763,  764,  767,  765,    0,  766,  767,  765,  768,
			  767,  770,  771,  769,  769,  773,  771,  769,    0,  773,
			  767,  770,  772,  770,  772,  774,    0,  774,    0,  771,
			  769,    0,  773,  770,  772,  767,    0,  774,    0,  767,

			    0,  775,  767,  770,  771,  775,    0,  773,  771,    0,
			    0,  773,  767,  770,  772,  770,  772,  774,  775,  774,
			    0,  771,    0,    0,  773,  770,  772,  777,  776,  774,
			  776,  777,  778,  775,  776,  777,  778,  775,    0,  778,
			  776,  778,    0,  780,  777,  780,    0,    0,  779,    0,
			  775,  778,  779,  781,    0,  780,    0,  781,    0,  777,
			  776,  779,  776,  777,  778,  779,  776,  777,  778,    0,
			  781,  778,  776,  778,    0,  780,  777,  780,  783,  782,
			  779,  782,  783,  778,  779,  781,  784,  780,  784,  781,
			    0,  782,  784,  779,    0,  783,    0,  779,  784,  785,

			    0,  786,  781,  785,  787,  786,  785,  786,  787,  787,
			  783,  782,    0,  782,  783,    0,  785,  786,  784,    0,
			  784,  787,    0,  782,  784,  789,  788,  783,    0,  789,
			  784,  785,  788,  786,  788,  785,  787,  786,  785,  786,
			  787,  787,  789,  790,  788,    0,    0,    0,  785,  786,
			  790,  791,  790,  787,  791,  791,    0,  789,  788,  792,
			    0,  789,  790,    0,  788,    0,  788,  792,  791,  792,
			    0,    0,    0,  793,  789,  790,  788,  793,    0,  792,
			    0,    0,  790,  791,  790,  795,  791,  791,    0,  795,
			  793,  792,  793,    0,  790,  794,    0,  794,  795,  792,

			  791,  792,  795,  794,  796,  793,  796,  794,  797,  793,
			    0,  792,  797,    0,    0,  799,  796,  795,    0,  799,
			    0,  795,  793,    0,  793,  797,    0,  794,    0,  794,
			  795,  798,  799,  798,  795,  794,  796,    0,  796,  794,
			  797,  801,    0,  798,  797,  801,    0,  799,  796,  803,
			  800,  799,  800,  803,  801,    0,  800,  797,  801,  802,
			  804,  802,  800,  798,  799,  798,  803,  804,    0,  804,
			  805,  802,  807,  801,  805,  798,  807,  801,  805,  804,
			    0,  803,  800,    0,  800,  803,  801,  805,  800,  807,
			  801,  802,  804,  802,  800,  808,    0,  808,  803,  804,

			    0,  804,  805,  802,  807,    0,  805,  808,  807,  806,
			  805,  804,  806,    0,  806,    0,    0,    0,  809,  805,
			    0,  807,  809,    0,  806,  810,  809,  808,  810,  808,
			  810,    0,  811,    0,  811,  809,  811,    0,    0,  808,
			  810,  806,  812,    0,  806,    0,  806,    0,    0,  811,
			  809,  812,    0,  812,  809,    0,  806,  810,  809,    0,
			  810,  813,  810,  812,  811,  813,  811,  809,  811,  813,
			    0,  815,  810,    0,  812,  815,    0,  814,  813,    0,
			  814,  811,  814,  812,  816,  812,  816,  817,  815,    0,
			    0,  817,  814,  813,  819,  812,  816,  813,  819,    0,

			    0,  813,    0,  815,  817,    0,  818,  815,    0,  814,
			  813,  819,  814,  818,  814,  818,  816,  821,  816,  817,
			  815,  821,    0,  817,  814,  818,  819,  820,  816,  820,
			  819,  825,    0,  820,  821,  825,  817,    0,  818,  820,
			  821,    0,  822,  819,  822,  818,    0,  818,  825,  821,
			    0,    0,  823,  821,  822,    0,  823,  818,    0,  820,
			  823,  820,    0,  825,    0,  820,  821,  825,    0,  823,
			  824,  820,  821,  824,  822,  824,  822,    0,  827,    0,
			  825,    0,  827,    0,  823,  824,  822,  826,  823,    0,
			  828,    0,  823,    0,  826,  827,  826,  828,    0,  828,

			    0,  823,  824,    0,  829,  824,  826,  824,  829,  828,
			  827,    0,    0,    0,  827,    0,  832,  824,  830,  826,
			  830,  829,  828,  832,  830,  832,  826,  827,  826,  828,
			  830,  828,    0,    0,    0,  832,  829,  834,  826,  834,
			  829,  828,  831,    0,    0,  834,  831,  833,  832,  834,
			  830,  833,  830,  829,    0,  832,  830,  832,  836,  831,
			  836,    0,  830,    0,  833,    0,  833,  832,  835,  834,
			  836,  834,  835,    0,  831,    0,  837,  834,  831,  833,
			  837,  834,    0,  833,  839,  835,    0,    0,  839,    0,
			  836,  831,  836,  837,    0,  837,  833,  838,  833,  838,

			  835,  839,  836,    0,  835,  838,  841,    0,  837,  838,
			  841,  840,  837,    0,    0,    0,  839,  835,    0,    0,
			  839,    0,  840,  841,  840,  837,    0,  837,  842,  838,
			  842,  838,    0,  839,  840,    0,  851,  838,  841,    0,
			  842,  838,  841,  840,  843,    0,  845,    0,  843,    0,
			  845,    0,  843,  847,  840,  841,  840,  847,    0,    0,
			  842,  843,  842,  845,  844,    0,  840,  844,  846,  844,
			  847,  848,  842,  848,  852,  846,  843,  846,  845,  844,
			  843,  853,  845,  848,  843,  847,  850,  846,  850,  847,
			  854,    0,    0,  843,    0,  845,  844,    0,  850,  844, yy_Dummy>>,
			1, 1000, 7000)
		end

	yy_chk_template_9 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  846,  844,  847,  848,  849,  848,    0,  846,  849,  846,
			    0,  844,    0,    0,    0,  848,    0,  849,  850,  846,
			  850,  849,  851,  851,  851,  851,  851,  851,  851,  855,
			  850,    0,  855,    0,    0,    0,  849,    0,    0,    0,
			  849,  855,    0,  865,  865,  865,  865,    0,    0,  849,
			  943,    0,  943,  849,    0,  943,  943,  943,  943,    0,
			  852,  852,  852,  852,  852,  852,  852,  853,  853,  853,
			  853,  853,  853,  853,    0,    0,  854,  854,  854,  854,
			  854,  854,  854,  865, 1008, 1008, 1008, 1008,    0,    0,
			  869,  870,  871,  870,  869,  872,  871,    0,  944,  944,

			  944,  944,  872,  870,  872,    0,    0,  869,    0,  871,
			 1042, 1042, 1042, 1042,  872,  855,  855,  855,  855,  855,
			  855,  855,  869,  870,  871,  870,  869,  872,  871,    0,
			    0,    0,    0,  873,  872,  870,  872,  873,  944,  869,
			  874,  871,  874,  875,  877,    0,  872,  875,  877,  874,
			  873,    0,  874,  873,  878,  876,    0,  876,  878,    0,
			  875,  877,  875,  876,    0,  873,    0,  876,  878,  873,
			    0,  878,  874,    0,  874,  875,  877,    0,    0,  875,
			  877,  874,  873,    0,  874,  873,  878,  876,    0,  876,
			  878,    0,  875,  877,  875,  876,  879,    0,  879,  876,

			  878,    0,  880,  878,  880,  880,  881,  882,  879,  882,
			  881,    0,  883,  884,  880,  882,  883,    0,    0,  882,
			  884,    0,  884,  881,    0,  881,    0,    0,  879,  883,
			  879,    0,  884,    0,  880,    0,  880,  880,  881,  882,
			  879,  882,  881,    0,  883,  884,  880,  882,  883,  885,
			    0,  882,  884,  885,  884,  881,  886,  881,  887,  889,
			    0,  883,  887,  889,  884,    0,  885,  886,  888,  886,
			  888,  890,    0,  890,    0,  887,  889,  892,    0,  886,
			  888,  885,    0,  890,  892,  885,  892,    0,  886,  891,
			  887,  889,    0,  891,  887,  889,  892,    0,  885,  886,

			  888,  886,  888,  890,    0,  890,  891,  887,  889,  892,
			  893,  886,  888,    0,  893,  890,  892,  894,  892,  894,
			  895,  891,  896,    0,  895,  891,  897,  893,  892,  894,
			  897,    0,  900,  896,  900,  896,  899,  895,  891,    0,
			  899,  898,  893,  897,  900,  896,  893,    0,  898,  894,
			  898,  894,  895,  899,  896,    0,  895,    0,  897,  893,
			  898,  894,  897,    0,  900,  896,  900,  896,  899,  895,
			  901,    0,  899,  898,  901,  897,  900,  896,    0,  902,
			  898,  902,  898,    0,    0,  899,  902,  901,  901,    0,
			  903,  902,  898,  904,  903,  904,  906,  905,  906,    0,

			    0,  905,  901,  903,  906,  904,  901,  903,  906,    0,
			    0,  902,    0,  902,  905,    0,  905,    0,  902,  901,
			  901,    0,  903,  902,    0,  904,  903,  904,  906,  905,
			  906,    0,    0,  905,  907,  903,  906,  904,  907,  903,
			  906,  909,  908,    0,  908,  909,  905,    0,  905,  910,
			  908,  907,  911,  907,  908,  912,  911,  912,  909,    0,
			  910,  913,  910,  912,    0,  913,  907,  912,    0,  911,
			  907,  911,  910,  909,  908,    0,  908,  909,  913,  913,
			    0,  910,  908,  907,  911,  907,  908,  912,  911,  912,
			  909,    0,  910,  913,  910,  912,  916,  913,  916,  912,

			  914,  911,  914,  911,  910,  915,    0,  914,  916,  915,
			  913,  913,  914,  918,  917,  918,  919,    0,  917,    0,
			  919,    0,  915,    0,  920,  918,  920,  917,  916,  919,
			  916,  917,  914,  919,  914,    0,  920,  915,  921,  914,
			  916,  915,  921,    0,  914,  918,  917,  918,  919,  923,
			  917,    0,  919,  923,  915,  921,  920,  918,  920,  917,
			  922,  919,  922,  917,  924,  919,  923,  926,  920,  926,
			  921,  924,  922,  924,  921,    0,  925,    0,  927,  926,
			  925,  923,  927,  924,    0,  923,    0,  921,  928,    0,
			  928,    0,  922,  925,  922,  927,  924,    0,  923,  926,

			  928,  926,  929,  924,  922,  924,  929,    0,  925,    0,
			  927,  926,  925,    0,  927,  924,  930,    0,  930,  929,
			  928,  932,  928,  932,    0,  925,  931,  927,  930,  932,
			  931,    0,  928,  932,  929,  934,    0,  934,  929,    0,
			    0,    0,    0,  931,    0,  931,    0,  934,  930,    0,
			  930,  929,    0,  932,  936,  932,  936,    0,  931,  933,
			  930,  932,  931,  933,  935,  932,  936,  934,  935,  934,
			  937,  958,  933,  958,  937,  931,  933,  931,    0,  934,
			    0,  935,  938,  958,  938,    0,  936,  937,  936,  937,
			  938,  933,    0,    0,  938,  933,  935,    0,  936,    0,

			  935,    0,  937,  958,  933,  958,  937,    0,  933,  951,
			  951,  951,  951,  935,  938,  958,  938,    0,    0,  937,
			    0,  937,  938,  951,    0,  952,  938,  952,    0,    0,
			  952,  952,  952,  952,  953,  955,  954,  953,  953,  955,
			    0,    0,    0,    0,  954,  956,  954,  956,  960,  951,
			  960,  953,  955,  956,  955,  951,  954,  956,  957,    0,
			  960,    0,  957,    0,    0,    0,  953,  955,  954,  953,
			  953,  955,    0,    0,    0,  957,  954,  956,  954,  956,
			  960,    0,  960,  953,  955,  956,  955,  959,  954,  956,
			  957,  959,  960,  961,  957,    0,  962,  961,  962,  963,

			  959,  964,  963,  963,  959,    0,    0,  957,  962,  964,
			  961,  964, 1001, 1001, 1001, 1001,  963,    0,    0,  959,
			    0,  964,    0,  959,    0,  961,    0,    0,  962,  961,
			  962,  963,  959,  964,  963,  963,  959,    0,    0,    0,
			  962,  964,  961,  964,  966,  965,  965,  967,  963,  965,
			  967,  967, 1001,  964,  966,  968,  966,  969,  970,    0,
			  970,  969,  965,  968,  967,  968,  966,  971,  969,    0,
			  970,  971,    0,    0,  969,  968,  966,  965,  965,  967,
			    0,  965,  967,  967,  971,    0,  966,  968,  966,  969,
			  970,    0,  970,  969,  965,  968,  967,  968,  966,  971,

			  969,  973,  970,  971,    0,  973,  969,  968,  972,  974,
			  972,  974,  978,  975,  978,    0,  971,  975,  973,  975,
			  972,  974,  976,    0,  978,    0,    0,  976,    0,  976,
			  975,  977,    0,  973,    0,  977,    0,  973,    0,  976,
			  972,  974,  972,  974,  978,  975,  978,    0,  977,  975,
			  973,  975,  972,  974,  976,    0,  978,    0,    0,  976,
			  979,  976,  975,  977,  979,    0,  980,  977,  980,  981,
			    0,  976,  982,  981,  982,    0,    0,  979,  980,    0,
			  977,    0,  981,    0,  982,  983,  981,    0,  984,  983,
			    0,    0,  979,    0,    0,  984,  979,  984,  980,    0, yy_Dummy>>,
			1, 1000, 8000)
		end

	yy_chk_template_10 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  980,  981,  983,    0,  982,  981,  982,  984,  985,  979,
			  980,  987,  985,    0,  981,  987,  982,  983,  981,    0,
			  984,  983,  985,    0,    0,  985,    0,  984,  987,  984,
			  986,    0,  986,  986,  983,    0,    0,    0,    0,  984,
			  985,    0,  986,  987,  985,    0,  989,  987,  989,  988,
			  989,    0,    0,    0,  985,    0,  988,  985,  988,    0,
			  987,    0,  986,  989,  986,  986,  990,  991,  988,    0,
			    0,  991,    0,    0,  986,  990,    0,  990,  989,  993,
			  989,  988,  989,  993,  991,  994,    0,  990,  988,  992,
			  988,  992,  994,  995,  994,  989,  993,  995,  990,  991,

			  988,  992,    0,  991,  994,    0,    0,  990,    0,  990,
			  995,  993,    0,  996,  997,  993,  991,  994,  997,  990,
			  996,  992,  996,  992,  994,  995,  994,    0,  993,  995,
			    0,  997,  996,  992,    0,  998,  994,  998, 1009, 1009,
			 1009, 1009,  995,    0, 1010,  996,  997,  998, 1010,    0,
			  997, 1005,  996, 1005,  996,    0, 1005, 1005, 1005, 1005,
			    0, 1010,    0,  997,  996,    0,    0,  998,    0,  998,
			 1007, 1007, 1007, 1007,    0, 1011, 1010, 1011, 1009,  998,
			 1010, 1012, 1013,    0, 1007, 1012, 1014, 1011,    0, 1013,
			 1014, 1013, 1015, 1010, 1015, 1016,    0,    0, 1012, 1016,

			    0, 1013,    0, 1014, 1015,    0,    0, 1011,    0, 1011,
			 1007, 1020, 1016, 1012, 1013, 1020, 1007, 1012, 1014, 1011,
			    0, 1013, 1014, 1013, 1015,    0, 1015, 1016, 1020,    0,
			 1012, 1016,    0, 1013, 1018, 1014, 1015, 1017, 1018, 1017,
			 1019,    0, 1019, 1020, 1016, 1018, 1021, 1020, 1021, 1017,
			 1022, 1018, 1019, 1023, 1022, 1023,    0,    0, 1021, 1024,
			 1020,    0,    0, 1024,    0, 1023, 1018, 1022,    0, 1017,
			 1018, 1017, 1019,    0, 1019,    0, 1024, 1018, 1021,    0,
			 1021, 1017, 1022, 1018, 1019, 1023, 1022, 1023,    0,    0,
			 1021, 1024, 1025,    0, 1025, 1024, 1026, 1023,    0, 1022,

			 1026, 1028, 1030,    0, 1025, 1028, 1030,    0, 1024, 1027,
			 1029, 1027, 1029, 1026,    0, 1026,    0, 1027, 1028, 1030,
			    0, 1027, 1029, 1031, 1025, 1031, 1025,    0, 1026, 1031,
			    0,    0, 1026, 1028, 1030, 1031, 1025, 1028, 1030,    0,
			    0, 1027, 1029, 1027, 1029, 1026,    0, 1026, 1032, 1027,
			 1028, 1030, 1032, 1027, 1029, 1031, 1033, 1031, 1033, 1034,
			 1036, 1031, 1035, 1034, 1036, 1032,    0, 1031, 1033, 1035,
			 1037, 1035, 1037, 1039,    0, 1039, 1034, 1036,    0,    0,
			 1032, 1035, 1037,    0, 1032, 1039,    0,    0, 1033, 1038,
			 1033, 1034, 1036, 1038, 1035, 1034, 1036, 1032,    0,    0,

			 1033, 1035, 1037, 1035, 1037, 1039, 1038, 1039, 1034, 1036,
			 1046,    0, 1046, 1035, 1037,    0,    0, 1039,    0,    0,
			    0, 1038, 1046,    0,    0, 1038, 1040, 1040, 1040, 1040,
			 1043, 1043, 1043, 1043, 1044, 1044, 1044, 1044, 1038, 1045,
			 1048, 1047, 1046, 1045, 1046, 1047, 1049, 1048,    0, 1048,
			 1049,    0,    0, 1050, 1046, 1050, 1045,    0, 1047, 1048,
			    0,    0,    0, 1049,    0, 1050, 1040,    0,    0,    0,
			 1043, 1045, 1048, 1047, 1044, 1045, 1051, 1047, 1049, 1048,
			 1051, 1048, 1049,    0, 1052, 1050, 1052, 1050, 1045,    0,
			 1047, 1048,    0, 1051, 1053, 1049, 1052, 1050, 1053,    0,

			    0, 1054,    0, 1054, 1055, 1055, 1055, 1055, 1051,    0,
			 1056, 1053, 1051, 1054, 1056,    0, 1052, 1057, 1052, 1057,
			    0,    0,    0,    0,    0, 1051, 1053, 1056, 1052, 1057,
			 1053,    0,    0, 1054,    0, 1054,    0,    0,    0,    0,
			    0,    0, 1056, 1053, 1055, 1054, 1056,    0,    0, 1057,
			    0, 1057,    0,    0,    0,    0,    0,    0,    0, 1056,
			    0, 1057, 1059, 1059, 1059, 1059, 1059, 1059, 1059, 1059,
			 1059, 1059, 1059, 1059, 1059, 1059, 1059, 1059, 1059, 1059,
			 1059, 1059, 1059, 1059, 1059, 1060, 1060,    0, 1060, 1060,
			 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060,

			 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1061,    0,
			    0,    0,    0,    0,    0, 1061, 1061, 1061, 1061, 1061,
			 1061, 1061, 1061, 1061, 1061, 1061, 1061, 1061, 1061, 1061,
			 1061, 1062, 1062,    0, 1062, 1062, 1062, 1062, 1062, 1062,
			 1062, 1062, 1062, 1062, 1062, 1062, 1062, 1062, 1062, 1062,
			 1062, 1062, 1062, 1062, 1063, 1063,    0, 1063, 1063, 1063,
			 1063,    0, 1063, 1063, 1063, 1063, 1063, 1063, 1063, 1063,
			 1063, 1063, 1063, 1063, 1063, 1063, 1063, 1064, 1064, 1064,
			 1064, 1064, 1064, 1064, 1064, 1064, 1064, 1064, 1064, 1064,
			 1064, 1065, 1065,    0, 1065, 1065, 1065,    0,    0, 1065,

			 1065, 1065, 1065, 1065, 1065, 1065, 1065, 1065, 1065, 1065,
			 1065, 1065, 1065, 1065, 1066, 1066, 1066, 1066, 1066, 1066,
			 1066, 1066, 1066, 1066, 1066, 1066, 1066, 1066, 1067,    0,
			    0, 1067,    0, 1067, 1067, 1067, 1067, 1067, 1067, 1067,
			 1067, 1067, 1067, 1067, 1067, 1067, 1067, 1067, 1067, 1067,
			 1067, 1068, 1068,    0, 1068, 1068, 1068, 1068, 1068, 1068,
			 1068, 1068, 1068, 1068, 1068, 1068, 1068, 1068, 1068, 1068,
			 1068, 1068, 1068, 1068, 1069, 1069,    0, 1069, 1069, 1069,
			 1069, 1069, 1069, 1069, 1069, 1069, 1069, 1069, 1069, 1069,
			 1069, 1069, 1069, 1069, 1069, 1069, 1069, 1070, 1070,    0,

			 1070, 1070, 1070, 1070, 1070, 1070, 1070, 1070, 1070, 1070,
			 1070, 1070, 1070, 1070, 1070, 1070, 1070, 1070, 1070, 1070,
			 1071,    0,    0,    0,    0, 1071, 1071, 1071, 1071, 1071,
			 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071,
			 1071, 1071, 1071, 1072, 1072, 1072, 1072, 1072, 1072, 1072,
			 1072,    0, 1072, 1072, 1072, 1072, 1072, 1072, 1072, 1072,
			 1072, 1072, 1072, 1072, 1072, 1072, 1073, 1073, 1073, 1073,
			 1073, 1073, 1073, 1073, 1073, 1073, 1073, 1073, 1073, 1074,
			 1074, 1074, 1074, 1074, 1074, 1074, 1074, 1074, 1074, 1074,
			 1074, 1074, 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075,

			 1075, 1075, 1075, 1075, 1075, 1076, 1076,    0, 1076, 1076,
			 1076,    0, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076,
			 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1077, 1077,
			    0, 1077, 1077, 1077,    0, 1077, 1077, 1077, 1077, 1077,
			 1077, 1077, 1077, 1077, 1077, 1077, 1077, 1077, 1077, 1077,
			 1077, 1078, 1078, 1078, 1078, 1078, 1078, 1078, 1078,    0,
			 1078, 1078, 1078, 1078, 1078, 1078, 1078, 1078, 1078, 1078,
			 1078, 1078, 1078, 1078, 1058, 1058, 1058, 1058, 1058, 1058,
			 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058,
			 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058, yy_Dummy>>,
			1, 1000, 9000)
		end

	yy_chk_template_11 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058,
			 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058,
			 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058,
			 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058,
			 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058,
			 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058,
			 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058,
			 1058, 1058, 1058, 1058, yy_Dummy>>,
			1, 74, 10000)
		end

	yy_base_template: SPECIAL [INTEGER]
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make (0, 1078)
			yy_base_template_1 (an_array)
			yy_base_template_2 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_base_template_1 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			    0,    0,    0,   98,  109,  414, 9974,  407,  400,  395,
			  391,  378,  121,    0, 9974,  128,  135, 9974, 9974, 9974,
			 9974, 9974,   87,   87,   97,  126,   99,  150,  355, 9974,
			   99, 9974,  105,  351,  215,  279,  325,  342,  384,  401,
			  291,  451,  301,  392,  448,  426,  472,  473,  499,  494,
			  515,  510,  536, 9974,  308, 9974, 9974,  510,  580,  544,
			  643,  651,  658,  583,  344,  723,  645,  719,  736,  727,
			  773,  776,  781,  547,  800,  794,  827, 9974, 9974,   51,
			  272,   60,   63,   73,   84,  268,  609,  386,  348,  879,
			  408,  886,  899,  820,  828,  848,  858,  868,  909,  919,

			  344,  337,  333,  331, 9974,  979, 9974, 1072, 1036, 1049,
			 1061, 1118, 1131, 1143, 1176, 1188, 1236,    0,  926, 1083,
			 1244, 1255, 1281, 1291, 1301, 1311, 1095,  319, 1404, 1266,
			 1391, 1414, 1162, 1427, 1437, 1447, 9974, 9974, 9974,  284,
			 9974, 9974, 1074, 1529,  649,  100,  179,  321, 1573, 1009,
			  109, 9974, 9974, 9974, 9974, 9974, 9974,  793, 1397, 1550,
			 1536, 1552, 1579, 1581, 1608, 1609, 1622, 1616, 1627,   90,
			  237,   93,  122,  150,  181,  236, 1643, 1670, 1399, 1669,
			 1687, 1680, 1703, 1720, 1685, 1731, 1734, 1738, 1790, 1767,
			 1787, 1791, 1801, 1840, 1845, 1843, 1856, 1889, 1903, 1848,

			 1905, 1872, 1910, 1915, 1945, 1959, 1966, 1968, 1969, 1975,
			 2028, 2002, 2038, 2052, 2049, 2094, 2093, 2100, 2114, 2130,
			 2152, 2153, 2160, 2164, 2193, 2169, 2194, 2209, 2228, 2277,
			 2266, 2225, 2274, 2288, 2306, 2330, 2335, 2340, 2369, 2400,
			 2357, 2417, 2399, 2416, 2433, 2463, 2458, 2466, 9974, 1460,
			 1480, 2460, 2471, 2482, 2492, 2503, 2514,  242,  232,  494,
			  153,  505,  543,  233,  560,  573,  694,  807,  838,  879,
			  967, 2521, 2529, 2539, 2549, 2559, 2569, 2579,  724, 1559,
			 2596, 2634,  316, 2677, 2694, 2701, 2062, 2619, 2732, 2741,
			 2751, 2775, 2799, 2809, 2849, 2626, 2873, 2907, 2917, 2927,

			 2947, 2971, 2981, 2865, 2899, 2934, 2954, 2991, 3001, 3047,
			 3094, 3101, 3108, 3115, 3125, 3140, 3150, 3160, 3170, 3218,
			 3263, 3275, 3287, 3311, 3323, 3335, 3380, 3393, 3405, 3344,
			 3417, 3437, 3444, 3455, 3498, 3205, 9974, 3241, 3469, 3483,
			 3508, 3518, 3533, 3544, 3558, 3572,  305, 3589, 3607, 3624,
			 3637, 3647, 3661, 3668, 3678, 3685, 3696, 3703, 3713, 3726,
			 3736, 3757, 3774, 3792, 3802, 3815, 3825, 3835, 3846, 3863,
			 3873, 3883, 1141, 1027, 1066, 9974, 3963, 1282, 3970, 2406,
			  118,  335,  243, 1295,  216, 4014,  214, 2742, 2800, 2468,
			 2281, 3072, 3086, 3096, 2880, 3629, 3774, 3994, 4012, 3647,

			 4045, 1020, 1112, 1157, 1203, 1222, 1276, 3814, 3946, 4037,
			 4059, 4074, 4085, 4080, 4094, 4109, 4121, 4138, 4137, 4152,
			 4161, 4173, 4183, 4204, 4168, 4212, 4220, 4237, 4251, 3967,
			 4247, 4262, 4274, 4282, 4308, 4316, 4327, 4322, 4336, 4376,
			 4372, 4392, 4319, 4390, 4402, 4414, 4432, 4440, 4448, 4447,
			 4462, 4454, 4483, 4478, 4500, 4508, 4516, 4519, 4524, 4549,
			 4557, 4572, 4564, 4556, 4571, 4611, 4609, 4625, 4633, 4633,
			 4636, 4673, 4675, 4696, 4687, 4695, 4730, 4726, 4731, 4744,
			 4771, 4791, 4793, 4794, 4779, 4828, 4830, 4831, 4839, 4854,
			 4868, 4857, 4883, 4888, 4903, 4922, 4936, 4952, 4955, 4982,

			 4993, 4990, 4998, 4925, 5002, 9974, 3853, 4999, 5006, 5016,
			 5027, 5038, 1328, 1376, 1382, 1389, 1402, 1424, 1649, 1698,
			 9974, 3299, 3428, 5050, 5060, 5072, 5082, 5099, 9974, 3744,
			 5109, 5120, 5131, 5145, 5175, 5192, 5243, 5250, 5273, 5290,
			 5300, 5310, 5317, 5324, 5348, 5355, 5371, 5422, 3229, 3918,
			 5429, 5448, 5464, 5471, 5481, 5488, 5495, 5522, 5541, 5588,
			 5600, 5615, 5634, 5641, 5648, 5655, 5662, 5678, 5689, 5704,
			 9974, 9974, 9974, 9974, 9974, 5793, 9974, 9974, 9974, 9974,
			 9974, 9974, 9974, 9974, 9974, 9974, 9974, 9974, 9974, 9974,
			 9974, 9974, 5751, 5767, 5641, 2036, 2865, 2168, 5817, 3435,

			 2663, 2841, 3449, 5582, 5241,  441,  141, 2085,  128,    0,
			  106, 5513, 5632, 5846, 5826, 5866, 5862, 5886, 5883, 5923,
			 5929, 5928, 5937, 1751, 2189, 5932, 5943, 5987, 5983, 5993,
			 5998, 5995, 6036, 6003, 6047, 6050, 6051, 6061, 6090, 6112,
			 6098, 6119, 6107, 6154, 6152, 6160, 6166, 6161, 6165, 6213,
			 6176, 6218, 6223, 6224, 6252, 6238, 6247, 6258, 6287, 6282,
			 6298, 6312, 6304, 6333, 6323, 6354, 6362, 6360, 6370, 6372,
			 6399, 6397, 6407, 6423, 6413, 6428, 6424, 6453, 6428, 6476,
			 6452, 6474, 6471, 6500, 6501, 6511, 6532, 6542, 6557, 6565,
			 6572, 6586, 6593, 6624, 6600, 6629, 6658, 6631, 6657, 6667,

			 6674, 6704, 6709, 6692, 6714, 6745, 6733, 6751, 6759, 6767,
			 6762, 6791, 6807, 6789, 6811, 6815, 6822, 6842, 6857, 6869,
			 6870, 6871, 6871, 5712, 6867, 2198, 2207, 5623, 5670, 6876,
			 6883, 6895, 6908, 6915, 6922, 6929, 6940, 6950, 6960, 7058,
			 7065, 7072, 7079, 7086, 7022, 7093, 7050, 7100, 7111, 4228,
			 3983, 3133, 3141, 7180, 3152, 4770, 3162, 5163, 3326, 5802,
			 5810, 7181, 7051, 7182, 7177, 7189, 7181, 7233, 7184, 7211,
			 7240, 7242, 7241, 7245, 7244, 7271, 7287, 7297, 7298, 7318,
			 7302, 7323, 7338, 7348, 7345, 7369, 7364, 7374, 7391, 7395,
			 7409, 7421, 7426, 7443, 7454, 7455, 7463, 7478, 7490, 7485,

			 7509, 7511, 7518, 7519, 7526, 7540, 7571, 7542, 7554, 7588,
			 7587, 7602, 7610, 7631, 7639, 7641, 7643, 7657, 7672, 7664,
			 7686, 7687, 7701, 7722, 7732, 7701, 7753, 7748, 7756, 7774,
			 7777, 7812, 7782, 7817, 7796, 7838, 7817, 7846, 7856, 7854,
			 7881, 7876, 7887, 7914, 7926, 7916, 7934, 7923, 7930, 7974,
			 7945, 7929, 7967, 7974, 7983, 8022, 9974, 5486, 5769, 3536,
			   95, 5851, 6537, 3564, 3599, 8023, 3882, 7108, 6918, 8060,
			 8050, 8062, 8061, 8103, 8099, 8113, 8114, 8114, 8124, 8155,
			 8161, 8176, 8166, 8182, 8179, 8219, 8226, 8228, 8227, 8229,
			 8230, 8259, 8243, 8280, 8276, 8290, 8292, 8296, 8307, 8306,

			 8291, 8340, 8338, 8360, 8352, 8367, 8355, 8404, 8401, 8411,
			 8419, 8422, 8414, 8431, 8459, 8475, 8455, 8484, 8472, 8486,
			 8483, 8508, 8519, 8519, 8530, 8546, 8526, 8548, 8547, 8572,
			 8575, 8596, 8580, 8629, 8594, 8634, 8613, 8640, 8641, 4073,
			 5211, 5517, 7117, 8035, 8078, 5532,  368, 5606, 5647, 5797,
			 9974, 8689, 8710, 8704, 8703, 8705, 8704, 8728, 8630, 8757,
			 8707, 8763, 8755, 8769, 8768, 8815, 8813, 8817, 8822, 8827,
			 8817, 8837, 8867, 8871, 8868, 8883, 8886, 8901, 8871, 8930,
			 8925, 8939, 8931, 8955, 8954, 8978, 8989, 8981, 9015, 9016,
			 9034, 9037, 9048, 9049, 9051, 9063, 9079, 9084, 9094,   74, yy_Dummy>>,
			1, 1000, 0)
		end

	yy_base_template_2 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 5832, 8792, 5918, 6025, 6905, 9136,   63, 9150, 8064, 9118,
			 9114, 9134, 9151, 9148, 9156, 9151, 9165, 9196, 9204, 9199,
			 9181, 9205, 9220, 9212, 9229, 9251, 9266, 9268, 9271, 9269,
			 9272, 9282, 9318, 9315, 9329, 9328, 9330, 9329, 9359, 9332,
			 9406,   46, 8090, 9410, 9414, 9409, 9369, 9411, 9406, 9416,
			 9412, 9446, 9443, 9464, 9460, 9484, 9480, 9476, 9974, 9561,
			 9584, 9607, 9630, 9653, 9668, 9690, 9704, 9727, 9750, 9773,
			 9796, 9819, 9842, 9856, 9869, 9882, 9904, 9927, 9950, yy_Dummy>>,
			1, 79, 1000)
		end

	yy_def_template: SPECIAL [INTEGER]
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make (0, 1078)
			yy_def_template_1 (an_array)
			yy_def_template_2 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_def_template_1 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			    0, 1058,    1, 1059, 1059, 1058, 1058, 1058, 1058, 1058,
			 1058, 1058, 1060, 1061, 1058, 1062, 1063, 1058, 1058, 1058,
			 1058, 1058, 1058, 1058, 1058, 1064, 1064, 1064, 1058, 1058,
			 1058, 1058, 1058, 1058, 1058,   34,   34,   36,   34,   36,
			   39,   39,   39,   39,   39,   39,   39,   39,   39,   39,
			   39,   39,   39, 1058, 1058, 1058, 1058, 1065, 1066, 1066,
			 1066, 1066, 1066,   62,   62,   62,   62,   62,   62,   62,
			   62,   62,   62,   62,   62,   62,   62, 1058, 1058, 1058,
			 1058, 1058, 1058, 1058, 1058, 1058, 1067, 1058, 1058, 1067,
			 1058, 1068, 1069, 1067, 1067, 1067, 1067, 1067, 1067, 1067,

			 1058, 1058, 1058, 1058, 1058, 1060, 1058, 1070, 1060, 1060,
			 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1061, 1062, 1062,
			 1062, 1062, 1062, 1062, 1062, 1062, 1071, 1058, 1071, 1071,
			 1071, 1071, 1071, 1071, 1071, 1071, 1058, 1058, 1058, 1058,
			 1058, 1058, 1072, 1064, 1064, 1064, 1073, 1074, 1075, 1064,
			 1064, 1058, 1058, 1058, 1058, 1058, 1058,   39,   39,   39,
			   39,   39,   39,   62,   62,   62,   62,   62,   62, 1058,
			 1058, 1058, 1058, 1058, 1058, 1058,   39,   62,   39,   39,
			   39,   39,   39,   62,   62,   62,   62,   62,   39,   39,
			   62,   62,   39,   39,   39,   62,   62,   62,   39,   39,

			   39,   62,   62,   62,   39,   39,   41,   39,   62,   62,
			   62,   62,   39,   39,   62,   62,   39,   62,   39,   39,
			   39,   39,   62,   62,   62,   62,   39,   62,   41,   62,
			   39,   39,   62,   62,   39,   39,   62,   62,   39,   62,
			   39,   39,   62,   62,   39,   62,   39,   62, 1058, 1065,
			 1065, 1065, 1065, 1065, 1065, 1065, 1065, 1058, 1058, 1058,
			 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058,
			 1067, 1067, 1067, 1067, 1067, 1067, 1067, 1067, 1058, 1058,
			 1076, 1077, 1058, 1067, 1068, 1069, 1058, 1067, 1068, 1068,
			 1068, 1068, 1068, 1068, 1068, 1067, 1069, 1069, 1069, 1069,

			 1069, 1069, 1069, 1067, 1067, 1067, 1067, 1067, 1067, 1070,
			 1062, 1062, 1070, 1070, 1070, 1070, 1070, 1070, 1070, 1070,
			 1070, 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1062,
			 1062, 1062, 1062, 1062, 1062, 1071, 1058, 1071, 1071, 1071,
			 1071, 1071, 1071, 1071, 1071, 1071, 1058, 1071, 1071, 1071,
			 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071,
			 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071,
			 1071, 1071, 1058, 1058, 1058, 1058, 1058, 1058, 1064, 1064,
			 1064, 1073, 1073, 1074, 1074, 1075, 1075, 1064, 1064,   39,
			   62,   39,   39,   62,   62,   39,   62,   39,   62,   39,

			   62, 1058, 1058, 1058, 1058, 1058, 1058,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   39,   39,   62,   62,   62,   39,   62,   39,   39,   62,
			   62,   39,   39,   62,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   39,   39,   39,   39,   62,   62,
			   62,   62,   62,   39,   62,   39,   39,   62,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   39,   39,   39,   39,   39,   62,   62,   62,   62,   62,
			   62,   39,   39,   62,   62,   39,   62,   39,   62,   39,
			   62,   39,   39,   39,   62,   62,   62,   39,   62,   39,

			   62,   39,   62,   39,   62, 1058, 1065, 1065, 1065, 1065,
			 1065, 1065, 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058,
			 1058, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1058, 1077,
			 1077, 1077, 1077, 1077, 1077, 1077, 1068, 1068, 1068, 1068,
			 1068, 1068, 1069, 1069, 1069, 1069, 1069, 1069, 1067, 1067,
			 1070, 1070, 1070, 1070, 1070, 1070, 1070, 1070, 1070, 1070,
			 1060, 1060, 1062, 1062, 1071, 1071, 1071, 1071, 1071, 1071,
			 1058, 1058, 1058, 1058, 1058, 1071, 1058, 1058, 1058, 1058,
			 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058,
			 1058, 1058, 1071, 1071, 1058, 1058, 1058, 1058, 1058, 1058,

			 1058, 1058, 1058, 1064, 1064, 1073, 1073, 1074, 1074,  385,
			 1075, 1064, 1064,   39,   62,   39,   62,   39,   62,   39,
			   39,   62,   62, 1058, 1058,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   39,   62,   62,   39,
			   62,   39,   62,   39,   62,   39,   39,   62,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   39,   62,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   39,   62,   62,   39,

			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62, 1065, 1065, 1058, 1058, 1076, 1076, 1076,
			 1076, 1076, 1076, 1077, 1077, 1077, 1077, 1077, 1077, 1068,
			 1068, 1069, 1069, 1070, 1070, 1070, 1071, 1071, 1071, 1058,
			 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1072,
			 1064,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,

			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62, 1076, 1076, 1077, 1077, 1070, 1058, 1058, 1058, 1058,
			 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1078,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   39,   62,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,

			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62, 1058,
			 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058,
			 1058, 1058, 1058,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62, 1058, yy_Dummy>>,
			1, 1000, 0)
		end

	yy_def_template_2 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058,
			   39,   62,   39,   62,   39,   62,   39,   62,   39,   62,
			   39,   62,   39,   62,   39,   62,   39,   62,   39,   62,
			   39,   62,   39,   62,   39,   62,   39,   62,   39,   62,
			 1058, 1058, 1058, 1058, 1058,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62, 1058,   39,   62,    0, 1058,
			 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058,
			 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058, yy_Dummy>>,
			1, 79, 1000)
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
			    1,    1,    1,   23,   23,   23,   23,   23,   23,   23, yy_Dummy>>)
		end

	yy_accept_template: SPECIAL [INTEGER]
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make (0, 1059)
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
			  648,  650,  652,  653,  654,  655,  657,  658,  661,  663,
			  665,  666,  668,  670,  671,  672,  674,  675,  677,  678,
			  680,  681,  683,  684,  686,  688,  690,  692,  694,  695,
			  696,  697,  698,  699,  701,  702,  704,  706,  707,  708,
			  711,  713,  715,  716,  719,  721,  723,  724,  726,  727,
			  729,  731,  733,  735,  737,  739,  740,  741,  742,  743,
			  744,  745,  747,  749,  750,  751,  753,  754,  756,  757,
			  759,  760,  762,  764,  766,  767,  768,  769,  771,  772,

			  774,  775,  777,  778,  781,  783,  784,  784,  784,  784,
			  784,  784,  784,  784,  784,  784,  784,  784,  784,  784,
			  784,  785,  785,  785,  785,  785,  785,  785,  785,  786,
			  786,  786,  786,  786,  786,  786,  786,  787,  788,  789,
			  790,  791,  792,  793,  794,  795,  796,  797,  798,  799,
			  800,  801,  802,  802,  803,  803,  803,  803,  803,  803,
			  803,  804,  805,  806,  807,  808,  809,  810,  811,  812,
			  813,  814,  815,  816,  817,  818,  819,  820,  821,  822,
			  823,  824,  825,  826,  827,  828,  829,  830,  831,  832,
			  833,  834,  835,  836,  837,  839,  839,  841,  841,  843,

			  843,  843,  843,  845,  847,  849,  849,  849,  849,  849,
			  849,  849,  851,  853,  855,  856,  858,  859,  861,  862,
			  864,  866,  867,  868,  868,  868,  870,  871,  873,  874,
			  876,  877,  879,  880,  882,  883,  885,  886,  888,  889,
			  891,  892,  895,  897,  899,  900,  902,  904,  905,  906,
			  908,  909,  911,  912,  914,  915,  918,  920,  922,  923,
			  925,  926,  928,  929,  931,  932,  934,  935,  937,  938,
			  940,  941,  944,  946,  948,  949,  952,  954,  957,  959,
			  961,  962,  965,  967,  969,  971,  972,  973,  975,  976,
			  978,  979,  981,  982,  984,  985,  987,  989,  990,  991,

			  993,  994,  996,  997,  999, 1000, 1002, 1003, 1006, 1008,
			 1011, 1013, 1015, 1016, 1018, 1019, 1021, 1022, 1024, 1025,
			 1028, 1030, 1033, 1035, 1035, 1035, 1035, 1035, 1035, 1035,
			 1035, 1035, 1035, 1035, 1035, 1035, 1035, 1035, 1035, 1035,
			 1036, 1037, 1038, 1039, 1039, 1039, 1039, 1040, 1041, 1042,
			 1043, 1045, 1045, 1045, 1047, 1047, 1051, 1051, 1053, 1053,
			 1053, 1055, 1058, 1060, 1063, 1065, 1067, 1068, 1070, 1071,
			 1073, 1074, 1077, 1079, 1082, 1084, 1086, 1087, 1089, 1090,
			 1092, 1093, 1096, 1098, 1100, 1101, 1103, 1104, 1106, 1107,
			 1109, 1110, 1112, 1113, 1115, 1116, 1118, 1119, 1122, 1124,

			 1126, 1127, 1129, 1130, 1132, 1133, 1135, 1136, 1139, 1141,
			 1143, 1144, 1146, 1147, 1149, 1150, 1153, 1155, 1157, 1158,
			 1160, 1161, 1163, 1164, 1166, 1167, 1169, 1170, 1172, 1173,
			 1175, 1176, 1178, 1179, 1181, 1182, 1185, 1187, 1189, 1190,
			 1192, 1193, 1196, 1198, 1200, 1201, 1203, 1204, 1207, 1209,
			 1211, 1212, 1212, 1212, 1212, 1212, 1212, 1213, 1213, 1215,
			 1215, 1216, 1217, 1221, 1221, 1221, 1223, 1223, 1224, 1224,
			 1227, 1229, 1231, 1232, 1234, 1235, 1237, 1238, 1241, 1243,
			 1245, 1246, 1248, 1249, 1251, 1252, 1254, 1255, 1258, 1260,
			 1263, 1265, 1267, 1268, 1271, 1273, 1275, 1276, 1278, 1279,

			 1282, 1284, 1286, 1287, 1289, 1290, 1292, 1293, 1295, 1296,
			 1298, 1299, 1301, 1302, 1304, 1305, 1308, 1310, 1312, 1313,
			 1315, 1316, 1319, 1321, 1323, 1324, 1327, 1329, 1332, 1334,
			 1337, 1339, 1341, 1342, 1344, 1345, 1348, 1350, 1352, 1353,
			 1353, 1354, 1354, 1354, 1354, 1358, 1358, 1359, 1360, 1360,
			 1360, 1361, 1362, 1363, 1365, 1366, 1368, 1369, 1372, 1374,
			 1376, 1377, 1380, 1382, 1384, 1385, 1387, 1388, 1390, 1391,
			 1393, 1394, 1397, 1399, 1402, 1404, 1406, 1407, 1410, 1412,
			 1415, 1417, 1419, 1420, 1422, 1423, 1425, 1426, 1428, 1429,
			 1431, 1432, 1435, 1437, 1439, 1440, 1442, 1443, 1446, 1448, yy_Dummy>>,
			1, 1000, 0)
		end

	yy_accept_template_2 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			 1449, 1449, 1450, 1450, 1452, 1452, 1452, 1453, 1454, 1454,
			 1455, 1458, 1460, 1462, 1463, 1466, 1468, 1471, 1473, 1475,
			 1476, 1479, 1481, 1484, 1486, 1489, 1491, 1493, 1494, 1497,
			 1499, 1501, 1502, 1505, 1507, 1509, 1510, 1513, 1515, 1518,
			 1520, 1521, 1523, 1523, 1525, 1526, 1529, 1531, 1533, 1534,
			 1537, 1539, 1542, 1544, 1547, 1549, 1551, 1554, 1556, 1556, yy_Dummy>>,
			1, 60, 1000)
		end

	yy_acclist_template: SPECIAL [INTEGER]
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make (0, 1555)
			yy_acclist_template_1 (an_array)
			yy_acclist_template_2 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_acclist_template_1 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			    0,  141,  141,  162,  160,  161,    3,  160,  161,    4,
			  161,    1,  160,  161,    2,  160,  161,   10,  160,  161,
			  143,  160,  161,  108,  160,  161,   17,  160,  161,  143,
			  160,  161,  160,  161,   11,  160,  161,   12,  160,  161,
			   31,  160,  161,   30,  160,  161,    8,  160,  161,   29,
			  160,  161,    6,  160,  161,   32,  160,  161,  145,  152,
			  160,  161,  145,  152,  160,  161,  145,  152,  160,  161,
			    9,  160,  161,    7,  160,  161,   36,  160,  161,   34,
			  160,  161,   35,  160,  161,  160,  161,  106,  107,  160,
			  161,  106,  107,  160,  161,  106,  107,  160,  161,  106,

			  107,  160,  161,  106,  107,  160,  161,  106,  107,  160,
			  161,  106,  107,  160,  161,  106,  107,  160,  161,  106,
			  107,  160,  161,  106,  107,  160,  161,  106,  107,  160,
			  161,  106,  107,  160,  161,  106,  107,  160,  161,  106,
			  107,  160,  161,  106,  107,  160,  161,  106,  107,  160,
			  161,  106,  107,  160,  161,  106,  107,  160,  161,  106,
			  107,  160,  161,   15,  160,  161,  160,  161,   16,  160,
			  161,   33,  160,  161,  160,  161,  107,  160,  161,  107,
			  160,  161,  107,  160,  161,  107,  160,  161,  107,  160,
			  161,  107,  160,  161,  107,  160,  161,  107,  160,  161,

			  107,  160,  161,  107,  160,  161,  107,  160,  161,  107,
			  160,  161,  107,  160,  161,  107,  160,  161,  107,  160,
			  161,  107,  160,  161,  107,  160,  161,  107,  160,  161,
			  107,  160,  161,   13,  160,  161,   14,  160,  161,  160,
			  161,  160,  161,  160,  161,  160,  161,  160,  161,  160,
			  161,  160,  161,  141,  161,  139,  161,  140,  161,  135,
			  141,  161,  138,  161,  141,  161,  141,  161,  141,  161,
			  141,  161,  141,  161,  141,  161,  141,  161,  141,  161,
			  141,  161,    3,    4,    1,    2,   37,  143,  142,  142,
			 -133,  143, -294, -134,  143, -295,  143,  143,  143,  143,

			  143,  143,  143,  108,  143,  143,  143,  143,  143,  143,
			  143,  143,  132,  132,  132,  132,  132,  132,  132,  132,
			  132,    5,   23,   24,  155,  158,   18,   20,  145,  152,
			  145,  152,  152,  144,  152,  152,  152,  144,  152,   28,
			   25,   22,   21,   26,   27,  106,  107,  106,  107,  106,
			  107,  106,  107,   42,  106,  107,  106,  107,  107,  107,
			  107,  107,   42,  107,  107,  106,  107,  107,  106,  107,
			  106,  107,  106,  107,  106,  107,  106,  107,  107,  107,
			  107,  107,  107,  106,  107,   56,  106,  107,  107,   56,
			  107,  106,  107,  106,  107,  106,  107,  107,  107,  107,

			  106,  107,  106,  107,  106,  107,  107,  107,  107,   68,
			  106,  107,  106,  107,  106,  107,   75,  106,  107,   68,
			  107,  107,  107,   75,  107,  106,  107,  106,  107,  107,
			  107,  106,  107,  107,  106,  107,  106,  107,  106,  107,
			   84,  106,  107,  107,  107,  107,   84,  107,  106,  107,
			  107,  106,  107,  107,  106,  107,  106,  107,  107,  107,
			  106,  107,  106,  107,  107,  107,  106,  107,  107,  106,
			  107,  106,  107,  107,  107,  106,  107,  107,  106,  107,
			  107,   19,  141,  141,  141,  141,  141,  141,  141,  141,
			  139,  140,  135,  141,  141,  141,  138,  136,  141,  141,

			  141,  141,  141,  141,  141,  141,  137,  141,  141,  141,
			  141,  141,  141,  141,  141,  141,  141,  141,  141,  141,
			  141,  142,  143,  142,  143, -133,  143, -134,  143,  143,
			  143,  143,  143,  143,  143,  143,  143,  143,  143,  143,
			  143,  132,  109,  132,  132,  132,  132,  132,  132,  132,
			  132,  132,  132,  132,  132,  132,  132,  132,  132,  132,
			  132,  132,  132,  132,  132,  132,  132,  132,  132,  132,
			  132,  132,  132,  132,  132,  132,  132,  155,  158,  153,
			  155,  158,  153,  145,  152,  145,  152,  148,  151,  152,
			  151,  152,  147,  150,  152,  150,  152,  146,  149,  152,

			  149,  152,  145,  152,  106,  107,  107,  106,  107,   40,
			  106,  107,  107,   40,  107,   41,  106,  107,   41,  107,
			  106,  107,  107,  106,  107,  107,   46,  106,  107,   46,
			  107,  106,  107,  107,  106,  107,  107,  106,  107,  107,
			  106,  107,  107,  106,  107,  107,  106,  107,  106,  107,
			  106,  107,  107,  107,  107,  106,  107,  107,   59,  106,
			  107,  106,  107,   59,  107,  107,  106,  107,  106,  107,
			  107,  107,  106,  107,  107,  106,  107,  107,  106,  107,
			  107,  106,  107,  107,  106,  107,  106,  107,  106,  107,
			  106,  107,  106,  107,  107,  107,  107,  107,  107,  106,

			  107,  107,  106,  107,  106,  107,  107,  107,   79,  106,
			  107,   79,  107,  106,  107,  107,   82,  106,  107,   82,
			  107,  106,  107,  107,  106,  107,  107,  106,  107,  106,
			  107,  106,  107,  106,  107,  106,  107,  106,  107,  107,
			  107,  107,  107,  107,  107,  106,  107,  106,  107,  107,
			  107,  106,  107,  107,  106,  107,  107,  106,  107,  107,
			  106,  107,  106,  107,  106,  107,  107,  107,  107,  106,
			  107,  107,  106,  107,  107,  106,  107,  107,  105,  106,
			  107,  105,  107,  159,  136,  137,  141,  141,  141,  141,
			  141,  141,  141,  141,  141,  141,  141,  141,  141,  141,

			  142,  142,  142,  143,  143,  143,  143,  132,  132,  132,
			  132,  132,  132,  126,  124,  125,  127,  128,  132,  129,
			  130,  110,  111,  112,  113,  114,  115,  116,  117,  118,
			  119,  120,  121,  122,  123,  132,  132,  155,  158,  155,
			  158,  155,  158,  154,  157,  145,  152,  145,  152,  145,
			  152,  145,  152,  106,  107,  107,  106,  107,  107,  106,
			  107,  107,  106,  107,  106,  107,  107,  107,  106,  107,
			  107,  106,  107,  107,  106,  107,  107,  106,  107,  107,
			  106,  107,  107,  106,  107,  107,  106,  107,  107,  106,
			  107,  107,   57,  106,  107,   57,  107,  106,  107,  107,

			  106,  107,  106,  107,  107,  107,  106,  107,  107,  106,
			  107,  107,  106,  107,  107,   66,  106,  107,  106,  107,
			   66,  107,  107,  106,  107,  107,  106,  107,  107,  106,
			  107,  107,  106,  107,  107,  106,  107,  107,  106,  107,
			  107,   76,  106,  107,   76,  107,  106,  107,  107,   78,
			  106,  107,   78,  107,   80,  106,  107,   80,  107,  106,
			  107,  107,   83,  106,  107,   83,  107,  106,  107,  106,
			  107,  107,  107,  106,  107,  107,  106,  107,  107,  106,
			  107,  107,  106,  107,  107,  106,  107,  106,  107,  107,
			  107,  106,  107,  107,  106,  107,  107,  106,  107,  107, yy_Dummy>>,
			1, 1000, 0)
		end

	yy_acclist_template_2 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  106,  107,  107,   97,  106,  107,   97,  107,   98,  106,
			  107,   98,  107,  106,  107,  107,  106,  107,  107,  106,
			  107,  107,  106,  107,  107,  103,  106,  107,  103,  107,
			  104,  106,  107,  104,  107,  141,  141,  141,  141,  132,
			  132,  132,  155,  155,  158,  155,  158,  154,  155,  157,
			  158,  154,  157,  145,  152,   38,  106,  107,   38,  107,
			   39,  106,  107,   39,  107,  106,  107,  107,  106,  107,
			  107,  106,  107,  107,   47,  106,  107,   47,  107,   48,
			  106,  107,   48,  107,  106,  107,  107,  106,  107,  107,
			  106,  107,  107,   53,  106,  107,   53,  107,  106,  107,

			  107,  106,  107,  107,  106,  107,  107,  106,  107,  107,
			  106,  107,  107,  106,  107,  107,  106,  107,  107,   64,
			  106,  107,   64,  107,  106,  107,  107,  106,  107,  107,
			  106,  107,  107,  106,  107,  107,   71,  106,  107,   71,
			  107,  106,  107,  107,  106,  107,  107,  106,  107,  107,
			   77,  106,  107,   77,  107,  106,  107,  107,  106,  107,
			  107,  106,  107,  107,  106,  107,  107,  106,  107,  107,
			  106,  107,  107,  106,  107,  107,  106,  107,  107,  106,
			  107,  107,   93,  106,  107,   93,  107,  106,  107,  107,
			  106,  107,  107,   96,  106,  107,   96,  107,  106,  107,

			  107,  106,  107,  107,  101,  106,  107,  101,  107,  106,
			  107,  107,  131,  155,  158,  158,  155,  154,  155,  157,
			  158,  154,  157,  153,   43,  106,  107,   43,  107,  106,
			  107,  107,  106,  107,  107,  106,  107,  107,   50,  106,
			  107,  106,  107,   50,  107,  107,  106,  107,  107,  106,
			  107,  107,  106,  107,  107,   58,  106,  107,   58,  107,
			   60,  106,  107,   60,  107,  106,  107,  107,   62,  106,
			  107,   62,  107,  106,  107,  107,  106,  107,  107,   67,
			  106,  107,   67,  107,  106,  107,  107,  106,  107,  107,
			  106,  107,  107,  106,  107,  107,  106,  107,  107,  106,

			  107,  107,  106,  107,  107,   86,  106,  107,   86,  107,
			  106,  107,  107,  106,  107,  107,   89,  106,  107,   89,
			  107,  106,  107,  107,   91,  106,  107,   91,  107,   92,
			  106,  107,   92,  107,   94,  106,  107,   94,  107,  106,
			  107,  107,  106,  107,  107,  100,  106,  107,  100,  107,
			  106,  107,  107,  155,  154,  155,  157,  158,  158,  154,
			  156,  158,  156,  106,  107,  107,  106,  107,  107,   49,
			  106,  107,   49,  107,  106,  107,  107,   52,  106,  107,
			   52,  107,  106,  107,  107,  106,  107,  107,  106,  107,
			  107,  106,  107,  107,   65,  106,  107,   65,  107,   69,

			  106,  107,   69,  107,  106,  107,  107,   72,  106,  107,
			   72,  107,   73,  106,  107,   73,  107,  106,  107,  107,
			  106,  107,  107,  106,  107,  107,  106,  107,  107,  106,
			  107,  107,   90,  106,  107,   90,  107,  106,  107,  107,
			  106,  107,  107,  102,  106,  107,  102,  107,  158,  158,
			  154,  155,  157,  158,  157,   44,  106,  107,   44,  107,
			  106,  107,  107,   51,  106,  107,   51,  107,   54,  106,
			  107,   54,  107,  106,  107,  107,   61,  106,  107,   61,
			  107,   63,  106,  107,   63,  107,   70,  106,  107,   70,
			  107,  106,  107,  107,   81,  106,  107,   81,  107,  106,

			  107,  107,   88,  106,  107,   88,  107,  106,  107,  107,
			   95,  106,  107,   95,  107,   99,  106,  107,   99,  107,
			  158,  157,  158,  157,  158,  157,   45,  106,  107,   45,
			  107,  106,  107,  107,   74,  106,  107,   74,  107,   85,
			  106,  107,   85,  107,   87,  106,  107,   87,  107,  157,
			  158,   55,  106,  107,   55,  107, yy_Dummy>>,
			1, 556, 1000)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER = 9974
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER = 1058
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER = 1059
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

	yyNb_rules: INTEGER = 161
			-- Number of rules

	yyEnd_of_buffer: INTEGER = 162
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
