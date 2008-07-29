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
					
when 128 then
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
					
when 129 then
--|#line 320 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 320")
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
			
when 130 then
--|#line 334 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 334")
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
--|#line 349 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 349")
end
-- Ignore carriage return
when 132 then
--|#line 350 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 350")
end

							-- Verbatim string closer, possibly.
						curr_token := new_string (text)						
						end_of_verbatim_string := True
						in_verbatim_string := False
						set_start_condition (INITIAL)
						update_token_list
					
when 133 then
--|#line 359 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 359")
end

							-- Verbatim string closer, possibly.
						curr_token := new_string (text)						
						end_of_verbatim_string := True
						in_verbatim_string := False
						set_start_condition (INITIAL)
						update_token_list
					
when 134 then
--|#line 368 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 368")
end

						curr_token := new_space (text_count)
						update_token_list						
					
when 135 then
--|#line 373 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 373")
end
						
						curr_token := new_tabulation (text_count)
						update_token_list						
					
when 136 then
--|#line 378 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 378")
end

						from i_ := 1 until i_ > text_count loop
							curr_token := new_eol
							update_token_list
							i_ := i_ + 1
						end						
					
when 137 then
--|#line 386 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 386")
end

						curr_token := new_string (text)
						update_token_list
					
when 138, 139 then
--|#line 392 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 392")
end

					-- Eiffel String
					if not in_comments then						
						curr_token := new_string (text)
					else
						curr_token := new_comment (text)
					end
					update_token_list
					
when 140 then
--|#line 405 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 405")
end

					-- Eiffel Bit
					if not in_comments then
						curr_token := new_number (text)						
					else
						curr_token := new_comment (text)
					end
					update_token_list
					
when 141, 142, 143, 144 then
--|#line 417 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 417")
end

						-- Eiffel Integer
						if not in_comments then
							curr_token := new_number (text)
						else
							curr_token := new_comment (text)
						end
						update_token_list
						
when 145, 146, 147, 148 then
--|#line 431 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 431")
end

						-- Bad Eiffel Integer
						if not in_comments then
							curr_token := new_text (text)
						else
							curr_token := new_comment (text)
						end
						update_token_list
						
when 149 then
	yy_end := yy_end - 1
--|#line 446 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 446")
end

							-- Eiffel reals & doubles
						if not in_comments then		
							curr_token := new_number (text)
						else
							curr_token := new_comment (text)
						end
						update_token_list
						
when 150, 151 then
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
						
when 152 then
	yy_end := yy_end - 1
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
						
when 153, 154 then
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
						
when 155 then
--|#line 467 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 467")
end

					curr_token := new_text (text)
					update_token_list
					
when 156 then
--|#line 475 "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line 475")
end

					-- Error (considered as text)
				if not in_comments then
					curr_token := new_text (text)
				else
					curr_token := new_comment (text)
				end
				update_token_list
				
when 157 then
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
			create an_array.make (0, 9562)
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
			    6,    6,    6,   79,   80,   81,   82,   83,   84,   85,

			   87,   88,   89,   90,  136,  138,  843,  139,  139,  139,
			  139,   87,   88,   89,   90,  137,  140,  142, 1014,  143,
			  143,  144,  144,  744,  141,  152,  153, 1014,  106,  916,
			  150,  107,  154,  155,  737,  106, 1014,  127,  107,  127,
			  127,  157,  157,  157,  142,  128,  143,  143,  144,  144,
			  263,  263,  263,  264,  264,  372,   91,  146,  147,  149,
			  378,  916,  150,  265,  265,  265,  604,   91,  142,  378,
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
			  169,  170,  171,  172,  173,  157,  566,  174,  371,  973,
			  157,  280,  157,  162,  162,  162,  157,  157,  511,  506,
			  157,  248,  249,  250,  251,  252,  253,  254,  402,  374,
			  374,  374,  374,  157,  372,  594,  397,  162,  334,  175,
			  371,  973,  162,  375,  162,  507,  507,  507,  162,  162,
			  157,  176,  162,  186,  103,  177,  157,  157,  178,  102,
			  157,  179,  157,  187,  180,  162,  157,  157,  101,  157,
			  100,  280,  190,  267,  191,  375,  509,  509,  509,  157,
			  379,  379,  162,  181,  192,  188,  262,  182,  162,  162,

			  183,  246,  162,  184,  162,  189,  185,  156,  162,  162,
			  151,  162,  379,  379,  193,  104,  194,  276,  196,  277,
			  277,  162,  197,  103,  157,  102,  195,  101,  100,  157,
			  599,  157,  202,  157, 1014,  198,  157, 1014,  157,  203,
			  204, 1014, 1014,  157, 1014,  205, 1014,  157, 1014,  157,
			  199,  210,  599,  157,  200, 1014,  162,  211, 1014, 1014,
			  157,  162, 1014,  162,  206,  162,  224,  201,  162, 1014,
			  162,  207,  208,  278,  157,  162,  157,  209,  157,  162,
			  226,  162, 1014,  212, 1014,  162,  157,  216,  214,  213,
			  157,  157,  162,  157, 1014, 1014,  157,  217,  225,  218,

			  228, 1014, 1014,  219,  279, 1014,  162,  157,  162, 1014,
			  162,  157,  227,  157,  232,  229, 1014,  157,  162,  220,
			  215,  157,  162,  162,  233,  162, 1014, 1014,  162,  221,
			  236,  222,  230, 1014,  157,  223, 1014,  238,  162,  162,
			  162,  157, 1014,  162, 1014,  162,  234,  231,  157,  162,
			  162,  239,  157,  162,  157,  242,  235,  157,  510,  510,
			  510,  157,  237, 1014,  157,  157,  162,  175,  157,  240,
			  162,  244,  162,  162,  157, 1014,  381,  381,  381, 1014,
			  162,  157,  162,  241,  162, 1014,  162,  243, 1014,  162,
			  157,  157,  157,  162, 1014, 1014,  162,  162,  188,  175,

			  162, 1014, 1014,  245, 1014, 1014,  162,  163,  189,  162,
			 1014,  162,  164,  162,  165,  225,  378, 1014, 1014,  166,
			 1014,  162,  255,  256,  257,  258,  259,  260,  261, 1014,
			  188,  269,  270,  271,  272,  273,  274,  275, 1014,  163,
			  189,  162, 1014,  162,  164, 1014,  165,  225,  157,  157,
			  157,  166,  277,  162,  277,  284, 1014,  255,  256,  257,
			  258,  259,  260,  261,  255,  256,  257,  258,  259,  260,
			  261,  181, 1014, 1014,  212,  182, 1014,  162,  183,  162,
			  213,  184, 1014,  142,  185,  377,  377,  377,  377,  162,
			  193, 1014,  194,  269,  270,  271,  272,  273,  274,  275,

			 1014, 1014,  195,  181, 1014, 1014,  212,  182,  278,  162,
			  183,  162,  213,  184, 1014, 1014,  185,  157,  157,  157,
			 1014,  162,  193, 1014,  194,  149, 1014,  255,  256,  257,
			  258,  259,  260,  261,  195,  157,  157,  157, 1014,  279,
			 1014, 1014,  255,  256,  257,  258,  259,  260,  261,  199,
			  206, 1014,  162,  200,  162,  215,  162,  207,  208, 1014,
			  162,  220,  162,  209,  162, 1014,  201, 1014,  162, 1014,
			 1014,  221,  162,  222,  512,  512,  512,  223,  513,  513,
			  513,  199,  206,  162,  162,  200,  162,  215,  162,  207,
			  208, 1014,  162,  220,  162,  209,  162, 1014,  201,  227,

			  162, 1014, 1014,  221,  162,  222,  162,  230,  162,  223,
			  157,  157,  157,  234,  162,  162,  162,  162,  162,  162,
			 1014,  240,  231,  235, 1014,  162,  162,  237, 1014,  162,
			 1014,  227,  162, 1014,  162,  241, 1014,  162,  162,  230,
			  162,  381,  381,  381,  162,  234,  162, 1014,  162,  162,
			  162,  162, 1014,  240,  231,  235,  243,  162,  162,  237,
			  162,  162,  162, 1014,  162, 1014,  162,  241,  162,  162,
			  162,  245,  162, 1014, 1014,  277,  162,  281,  277, 1014,
			  162,  601,  278, 1014, 1014,  278, 1014,  285,  243, 1014,
			  268, 1014,  162,  279,  162, 1014,  279, 1014,  293, 1014,

			  162,  268,  162,  245,  162,  269,  270,  271,  272,  273,
			  274,  275,  162,  301,  269,  270,  271,  272,  273,  274,
			  275,  302,  302,  302,  269,  270,  271,  272,  273,  274,
			  275,  282,  303,  303,  334,  269,  270,  271,  272,  273,
			  274,  275,  304,  304,  304,  269,  270,  271,  272,  273,
			  274,  275,  305,  305,  305,  269,  270,  271,  272,  273,
			  274,  275,  283,  157,  157,  157,  269,  270,  271,  272,
			  273,  274,  275,  286,  287,  288,  289,  290,  291,  292,
			  106, 1014, 1014,  107,  294,  295,  296,  297,  298,  299,
			  300,  306, 1014, 1014,  269,  270,  271,  272,  273,  274,

			  275,  142, 1014,  376,  376,  377,  377, 1014, 1014,  385,
			  385,  385,  385, 1014,  150, 1014,  335,  336,  337,  338,
			  339,  340,  341,  591,  591,  591,  591, 1014, 1014,  108,
			 1014, 1014,  319, 1014,  319,  319, 1014,  106, 1014, 1014,
			  107, 1014, 1014,  149, 1014,  320,  150,  320,  320,  386,
			  106, 1014, 1014,  107,  269,  270,  271,  272,  273,  274,
			  275,  109,  106, 1014, 1014,  107,  110,  111,  112,  113,
			  114,  115,  116,  308, 1014, 1014,  309,  118,  118,  118,
			  157,  157,  157, 1014,  106,  310,  108,  107,  157,  157,
			  157, 1014,  118, 1014,  118, 1014,  118,  118,  311,  108,

			  334,  118, 1014,  118,  613,  613,  613,  118, 1014,  118,
			 1014,  108,  118,  118,  118,  118,  118,  118,  109,  106,
			 1014, 1014,  107,  110,  111,  112,  113,  114,  115,  116,
			 1014,  109,  106, 1014, 1014,  107,  110,  111,  112,  113,
			  114,  115,  116,  109,  106, 1014, 1014,  107,  110,  111,
			  112,  113,  114,  115,  116,  106, 1014, 1014,  107,  312,
			  313,  314,  315,  316,  317,  318, 1014, 1014,  108, 1014,
			  119,  120,  121,  122,  123,  124,  125,  106, 1014,  369,
			  107,  108,  335,  336,  337,  338,  339,  340,  341,  106,
			 1014, 1014,  107,  108, 1014, 1014,  276, 1014,  277,  277,

			  109,  614,  614,  614,  321,  110,  111,  112,  113,  114,
			  115,  116, 1014,  109, 1014,  322,  322,  322,  110,  111,
			  112,  113,  114,  115,  116,  109,  108,  323,  323, 1014,
			  110,  111,  112,  113,  114,  115,  116,  106,  108, 1014,
			  107,  119,  120,  121,  122,  123,  124,  125,  106, 1014,
			 1014,  107,  278,  162,  162,  162, 1014, 1014,  109, 1014,
			  324,  324,  324,  110,  111,  112,  113,  114,  115,  116,
			  109,  334,  325,  325,  325,  110,  111,  112,  113,  114,
			  115,  116,  106,  279, 1014,  107,  108,  162, 1014,  162,
			 1014, 1014,  106, 1014, 1014,  107,  162,  162,  162,  162,

			 1014,  589,  106,  589, 1014,  107,  590,  590,  590,  590,
			 1014, 1014,  106, 1014, 1014,  107, 1014, 1014,  109,  162,
			  326,  162, 1014,  110,  111,  112,  113,  114,  115,  116,
			  334,  162, 1014,  327,  119,  120,  121,  122,  123,  124,
			  125,  106, 1014, 1014,  107,  162,  162,  162, 1014, 1014,
			  126,  126,  126,  335,  336,  337,  338,  339,  340,  341,
			  162,  162,  162, 1014, 1014,  328,  328,  328,  119,  120,
			  121,  122,  123,  124,  125,  329,  329, 1014,  119,  120,
			  121,  122,  123,  124,  125,  330,  330,  330,  119,  120,
			  121,  122,  123,  124,  125,  331,  331,  331,  119,  120,

			  121,  122,  123,  124,  125,  334, 1014,  277, 1014,  277,
			  277,  364,  335,  336,  337,  338,  339,  340,  341,  334,
			  711,  711,  711, 1014,  332, 1014,  499,  119,  120,  121,
			  122,  123,  124,  125,  342, 1014, 1014,  343,  344,  345,
			  346,  712,  712,  712, 1014, 1014,  347, 1014,  334,  157,
			  157,  157, 1014,  348, 1014,  349, 1014,  350,  351,  352,
			  353,  334,  354,  278,  355,  157,  157,  157,  356, 1014,
			  357, 1014, 1014,  358,  359,  360,  361,  362,  363,  590,
			  590,  590,  590, 1014,  365,  365,  365,  335,  336,  337,
			  338,  339,  340,  341,  279,  157,  157,  157,  366,  366,

			 1014,  335,  336,  337,  338,  339,  340,  341,  248,  249,
			  250,  251,  252,  253,  254, 1014,  736,  736,  736,  736,
			  335,  336,  337,  338,  339,  340,  341,  367,  367,  367,
			  335,  336,  337,  338,  339,  340,  341,  157,  157,  157,
			  368,  368,  368,  335,  336,  337,  338,  339,  340,  341,
			  383,  383,  383,  383, 1014,  157,  737, 1014,  499,  387,
			  383,  383,  383,  383,  383,  383,  157,  162,  162,  162,
			  157,  157,  157, 1014,  389,  157, 1014,  390,  738,  738,
			  738,  738,  157,  157, 1014,  393,  157,  162,  157,  395,
			  378,  388,  383,  383,  383,  383,  383,  383,  162,  157,

			 1014, 1014,  162,  162,  162, 1014,  391,  162,  142,  392,
			  598,  598,  598,  598,  162,  162,  388,  394,  162,  391,
			  162,  396,  392,  162,  162,  162,  162, 1014,  162,  394,
			 1014,  162, 1014,  396,  162,  162, 1014,  162,  162,  162,
			  248,  249,  250,  251,  252,  253,  254, 1014,  388,  162,
			  149,  391, 1014, 1014,  392,  162,  162,  162,  162,  157,
			  162,  394, 1014,  157, 1014,  396,  162,  162, 1014,  162,
			  162,  162,  162,  157,  162,  407,  157,  405,  403,  157,
			  404,  162,  157,  157,  162,  157,  411,  157, 1014,  157,
			  157,  162,  157, 1014,  406,  162,  409, 1014, 1014,  157,

			  157,  162,  413,  162,  162,  162,  162,  408,  162,  406,
			  404,  162,  404,  162,  162,  162,  162,  162,  412,  162,
			 1014,  162,  162, 1014,  162,  408,  406,  162,  410,  410,
			 1014,  162,  162,  162,  414,  162,  162,  412,  162,  162,
			 1014,  162, 1014,  162,  162,  162,  162,  414,  162, 1014,
			  157,  415, 1014,  162,  157,  416,  162,  408, 1014,  162,
			  157,  410,  417, 1014,  157, 1014,  418,  157,  162,  412,
			  162,  162,  162,  162,  162,  162,  162,  157,  162,  414,
			  162, 1014,  162,  417,  162,  162,  162,  418,  162,  162,
			 1014,  162,  162,  157,  417, 1014,  162,  157,  418,  162,

			 1014,  162, 1014, 1014,  162, 1014,  162, 1014, 1014,  162,
			  157,  419, 1014, 1014,  157, 1014,  162,  421,  157, 1014,
			  157,  162, 1014,  162,  157,  162,  162,  162,  162,  162,
			 1014,  157,  422,  162, 1014,  425, 1014,  157, 1014,  426,
			 1014, 1014,  162,  420, 1014, 1014,  162, 1014, 1014,  423,
			  162, 1014,  162,  162, 1014,  162,  162, 1014,  423, 1014,
			  420, 1014, 1014,  162,  424,  162,  162,  427,  162,  162,
			 1014,  428,  162,  424,  162, 1014,  427,  157,  162,  431,
			  428,  157, 1014,  157,  162,  162, 1014,  162,  429, 1014,
			  423,  430,  420,  162,  157, 1014,  157,  162,  162, 1014,

			  162, 1014, 1014,  162,  162,  424,  162, 1014,  427,  162,
			  162,  432,  428,  162, 1014,  162,  162,  157, 1014,  432,
			  430,  157, 1014,  430, 1014,  162,  162, 1014,  162,  157,
			  162,  433,  162,  157,  157,  162,  162,  157,  162,  434,
			  157,  157,  162, 1014,  157, 1014,  157, 1014,  162,  162,
			 1014,  432,  435,  162,  157, 1014, 1014,  157, 1014, 1014,
			 1014,  162,  162,  434,  162,  162,  162, 1014,  162,  162,
			  162,  434,  162,  162,  162, 1014,  162, 1014,  162, 1014,
			  162,  162, 1014,  162,  436, 1014,  162,  157, 1014,  162,
			  437,  157,  438,  162,  439,  162, 1014,  162,  162,  436,

			  162, 1014, 1014, 1014,  157,  440, 1014,  162,  441, 1014,
			  162, 1014, 1014,  162, 1014,  162, 1014, 1014,  277,  162,
			  277,  284,  442,  162,  443,  162,  444,  162, 1014,  162,
			  162,  436,  162, 1014, 1014, 1014,  162,  445, 1014,  162,
			  446,  442,  162,  443, 1014,  444, 1014, 1014,  157,  162,
			 1014,  162,  157,  157, 1014,  449,  445,  157,  447,  446,
			 1014,  162, 1014,  448,  162,  157,  162,  450, 1014, 1014,
			  157, 1014, 1014,  442,  278,  443,  162,  444, 1014, 1014,
			  162,  162, 1014,  162,  162,  162, 1014,  451,  445,  162,
			  448,  446,  451,  162, 1014,  448,  162,  162,  162,  452,

			 1014,  162,  162,  162,  452,  279,  157,  162,  162,  162,
			  157, 1014,  157,  162,  157,  454,  157,  457,  157,  162,
			 1014, 1014, 1014,  157,  451,  453, 1014, 1014, 1014,  157,
			  455,  157, 1014,  162, 1014,  162,  452, 1014,  162,  162,
			 1014,  162,  162, 1014,  162,  162,  162,  454,  162,  458,
			  162,  162,  157, 1014,  459,  162,  157,  454, 1014, 1014,
			  157,  162,  456,  162,  157, 1014,  162, 1014,  162,  157,
			  162,  458,  162,  456,  460, 1014,  157,  157,  162,  162,
			  461,  162,  162,  162,  162,  162,  460, 1014,  162, 1014,
			 1014,  162,  162,  157, 1014,  162,  162, 1014,  162, 1014,

			  162,  162,  162,  458,  162,  456,  460, 1014,  162,  162,
			  162,  162,  462,  162,  162,  162, 1014,  162,  157,  462,
			  157, 1014,  157,  162,  157,  162,  162,  162,  162,  475,
			  477, 1014,  162,  476,  478,  157,  157,  479,  162, 1014,
			  481, 1014,  162,  269,  270,  271,  272,  273,  274,  275,
			  162,  462,  162,  157,  162, 1014,  162, 1014,  162, 1014,
			  162,  477,  477, 1014,  162,  478,  478,  162,  162,  480,
			  162,  463,  482,  464,  162,  157,  162, 1014,  162,  157,
			 1014,  465,  480,  157,  466,  162,  467,  468,  162,  157,
			  742,  742,  742,  742, 1014, 1014,  157, 1014, 1014,  483,

			  381,  381,  381,  469, 1014,  470, 1014,  162,  162, 1014,
			  162,  162, 1014,  471,  480,  162,  472, 1014,  473,  474,
			  162,  162,  469, 1014,  470, 1014, 1014,  482,  162, 1014,
			  162,  484,  471, 1014,  162,  472,  162,  473,  474,  162,
			  601,  162,  162,  157, 1014, 1014,  162,  157,  484, 1014,
			 1014,  162, 1014, 1014,  469, 1014,  470, 1014, 1014,  482,
			  491, 1014,  162, 1014,  471, 1014,  162,  472,  162,  473,
			  474,  162, 1014,  162,  162,  162, 1014, 1014,  162,  162,
			  484,  157, 1014,  162,  485,  157,  488, 1014, 1014,  486,
			 1014,  489,  492,  157,  162,  157,  162,  157,  157,  495,

			  487,  493,  490,  162, 1014,  162,  162, 1014, 1014,  492,
			  157, 1014,  157,  162, 1014,  162,  488,  162,  488,  499,
			 1014,  489,  514,  489, 1014,  162,  162,  162,  162,  162,
			  162,  496,  490,  494,  490,  162,  499,  162,  162,  496,
			  494,  492,  162,  162,  162,  162,  162,  162,  162,  157,
			  162,  499,  162,  157, 1014,  162,  498, 1014,  162, 1014,
			 1014,  499,  162, 1014, 1014, 1014,  497,  596,  596,  596,
			  596,  496,  494,  499, 1014,  162, 1014,  162,  162, 1014,
			  162,  162,  162,  499,  162,  162, 1014,  162,  498, 1014,
			  162, 1014, 1014, 1014,  162, 1014, 1014, 1014,  498, 1014,

			  500,  248,  249,  250,  251,  252,  253,  254,  515,  516,
			  517,  518,  519,  520,  521,  501,  501,  501,  248,  249,
			  250,  251,  252,  253,  254,  839,  839,  839,  839, 1014,
			  502,  502, 1014,  248,  249,  250,  251,  252,  253,  254,
			  503,  503,  503,  248,  249,  250,  251,  252,  253,  254,
			  522, 1014,  504,  504,  504,  248,  249,  250,  251,  252,
			  253,  254,  505, 1014, 1014,  248,  249,  250,  251,  252,
			  253,  254,  301,  269,  270,  271,  272,  273,  274,  275,
			  302,  302,  302,  269,  270,  271,  272,  273,  274,  275,
			  303,  303, 1014,  269,  270,  271,  272,  273,  274,  275,

			  304,  304,  304,  269,  270,  271,  272,  273,  274,  275,
			  305,  305,  305,  269,  270,  271,  272,  273,  274,  275,
			  306, 1014, 1014,  269,  270,  271,  272,  273,  274,  275,
			  277, 1014,  281,  277, 1014, 1014,  523,  524,  525,  526,
			  527,  528,  529,  278, 1014, 1014,  278, 1014,  285, 1014,
			  279,  268, 1014,  279, 1014,  293, 1014,  278,  268, 1014,
			  278, 1014,  285, 1014, 1014,  268,  278, 1014, 1014,  278,
			 1014,  285, 1014, 1014,  268, 1014,  278, 1014, 1014,  278,
			 1014,  285, 1014, 1014,  268, 1014,  282,  278, 1014, 1014,
			  278, 1014,  285, 1014, 1014,  268, 1014,  278, 1014, 1014,

			  278, 1014,  285, 1014, 1014,  268, 1014,  278, 1014, 1014,
			  278, 1014,  285, 1014, 1014,  268, 1014,  283, 1014, 1014,
			 1014,  269,  270,  271,  272,  273,  274,  275,  840,  840,
			  840,  840, 1014, 1014,  286,  287,  288,  289,  290,  291,
			  292,  294,  295,  296,  297,  298,  299,  300,  286,  287,
			  288,  289,  290,  291,  292, 1014,  530,  286,  287,  288,
			  289,  290,  291,  292,  531,  531,  531,  286,  287,  288,
			  289,  290,  291,  292, 1014,  532,  532, 1014,  286,  287,
			  288,  289,  290,  291,  292,  533,  533,  533,  286,  287,
			  288,  289,  290,  291,  292,  534,  534,  534,  286,  287,

			  288,  289,  290,  291,  292,  278, 1014, 1014,  278, 1014,
			  285, 1014, 1014,  268,  269,  270,  271,  272,  273,  274,
			  275,  279, 1014, 1014,  279,  162,  293,  608, 1014,  268,
			  279, 1014,  162,  279,  162,  293, 1014,  162,  268, 1014,
			  279, 1014, 1014,  279,  162,  293, 1014, 1014,  268, 1014,
			  279, 1014, 1014,  279, 1014,  293, 1014,  162,  268,  608,
			  279, 1014, 1014,  279,  162,  293,  162, 1014,  268,  162,
			  279, 1014, 1014,  279, 1014,  293,  162, 1014,  268, 1014,
			  279, 1014, 1014,  279,  595,  293,  595, 1014,  268,  596,
			  596,  596,  596,  535, 1014, 1014,  286,  287,  288,  289,

			  290,  291,  292,  269,  270,  271,  272,  273,  274,  275,
			 1014, 1014,  294,  295,  296,  297,  298,  299,  300, 1014,
			  536,  294,  295,  296,  297,  298,  299,  300,  537,  537,
			  537,  294,  295,  296,  297,  298,  299,  300,  538,  538,
			 1014,  294,  295,  296,  297,  298,  299,  300,  539,  539,
			  539,  294,  295,  296,  297,  298,  299,  300,  540,  540,
			  540,  294,  295,  296,  297,  298,  299,  300,  541, 1014,
			 1014,  294,  295,  296,  297,  298,  299,  300,  269,  270,
			  271,  272,  273,  274,  275,  269,  270,  271,  272,  273,
			  274,  275,  269,  270,  271,  272,  273,  274,  275,  542, yy_Dummy>>,
			1, 3000, 0)
		end

	yy_nxt_template_2 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			  542,  542,  269,  270,  271,  272,  273,  274,  275,  543,
			  543,  543,  269,  270,  271,  272,  273,  274,  275,  106,
			 1014, 1014,  544, 1014, 1014, 1014,  106, 1014, 1014,  107,
			 1014, 1014, 1014,  545,  609,  157,  107, 1014,  157,  157,
			  106,  157, 1014,  544, 1014,  157, 1014,  106,  607, 1014,
			  547,  157,  157,  546,  546,  546,  546,  106,  157,  142,
			  544,  597,  597,  598,  598,  106,  610,  162,  544, 1014,
			  162,  162,  150,  162, 1014,  106, 1014,  162,  544, 1014,
			  608, 1014, 1014,  162,  162,  106, 1014, 1014,  544, 1014,
			  162,  741,  741,  741,  741,  106, 1014, 1014,  544, 1014,

			 1014,  149, 1014, 1014,  150,  312,  313,  314,  315,  316,
			  317,  318,  119,  120,  121,  122,  123,  124,  125,  119,
			  120,  121,  122,  123,  124,  125,  312,  313,  314,  315,
			  316,  317,  318,  312,  313,  314,  315,  316,  317,  318,
			 1014, 1014, 1014,  312,  313,  314,  315,  316,  317,  318,
			  548,  312,  313,  314,  315,  316,  317,  318,  549,  549,
			  549,  312,  313,  314,  315,  316,  317,  318,  550,  550,
			 1014,  312,  313,  314,  315,  316,  317,  318,  551,  551,
			  551,  312,  313,  314,  315,  316,  317,  318,  106, 1014,
			 1014,  544,  588,  588,  588,  588, 1014, 1014,  106, 1014,

			 1014,  544, 1014, 1014, 1014,  319,  371,  319,  319,  162,
			  106,  162, 1014,  107, 1014,  592,  592,  592,  592, 1014,
			 1014,  162,  605,  605,  605,  605, 1014, 1014,  320,  593,
			  320,  320,  372,  106, 1014, 1014,  107, 1014,  371, 1014,
			 1014,  162, 1014,  162,  740,  106,  740, 1014,  107,  741,
			  741,  741,  741,  162, 1014,  594, 1014,  106, 1014,  108,
			  107,  593,  386, 1014, 1014,  606,  606,  606,  606, 1014,
			 1014,  552,  552,  552,  312,  313,  314,  315,  316,  317,
			  318,  553,  108, 1014,  312,  313,  314,  315,  316,  317,
			  318,  109,  106, 1014,  108,  107,  110,  111,  112,  113,

			  114,  115,  116, 1014,  106,  386,  108,  107,  844,  844,
			  844,  844,  106, 1014,  109,  107, 1014, 1014, 1014,  110,
			  111,  112,  113,  114,  115,  116,  109,  106, 1014, 1014,
			  107,  110,  111,  112,  113,  114,  115,  116,  109,  106,
			 1014,  108,  107,  110,  111,  112,  113,  114,  115,  116,
			 1014,  106, 1014,  108,  107, 1014, 1014, 1014,  106, 1014,
			 1014,  107, 1014, 1014, 1014,  106, 1014, 1014,  107,  846,
			  846,  846,  846,  109, 1014, 1014,  108, 1014,  110,  111,
			  112,  113,  114,  115,  116,  109,  106, 1014,  108,  107,
			  110,  111,  112,  113,  114,  115,  116, 1014,  119,  120,

			  121,  122,  123,  124,  125, 1014,  106, 1014,  109,  107,
			  554,  554,  554,  110,  111,  112,  113,  114,  115,  116,
			  109, 1014,  555,  555,  555,  110,  111,  112,  113,  114,
			  115,  116, 1014,  915,  915,  915,  915,  119,  120,  121,
			  122,  123,  124,  125,  119,  120,  121,  122,  123,  124,
			  125,  119,  120,  121,  122,  123,  124,  125, 1014,  335,
			  336,  337,  338,  339,  340,  341, 1014, 1014, 1014,  556,
			  556,  556,  119,  120,  121,  122,  123,  124,  125,  335,
			  336,  337,  338,  339,  340,  341, 1014, 1014, 1014,  557,
			  557,  557,  119,  120,  121,  122,  123,  124,  125, 1014,

			 1014, 1014,  558,  335,  336,  337,  338,  339,  340,  341,
			  564,  559,  559,  559,  335,  336,  337,  338,  339,  340,
			  341,  565,  743,  743,  743,  743, 1014, 1014,  567,  919,
			  919,  919,  919, 1014, 1014,  568, 1014,  560,  560, 1014,
			  335,  336,  337,  338,  339,  340,  341,  561,  561,  561,
			  335,  336,  337,  338,  339,  340,  341,  570,  920,  920,
			  920,  920,  744, 1014,  571,  562,  562,  562,  335,  336,
			  337,  338,  339,  340,  341, 1014, 1014, 1014,  563, 1014,
			 1014,  335,  336,  337,  338,  339,  340,  341,  569,  569,
			  569,  569,  335,  336,  337,  338,  339,  340,  341,  572,

			 1014, 1014, 1014,  335,  336,  337,  338,  339,  340,  341,
			  335,  336,  337,  338,  339,  340,  341,  335,  336,  337,
			  338,  339,  340,  341,  573,  162, 1014,  162, 1014, 1014,
			  745,  574,  598,  598,  598,  598, 1014,  162,  575,  335,
			  336,  337,  338,  339,  340,  341,  335,  336,  337,  338,
			  339,  340,  341,  576, 1014, 1014, 1014,  162, 1014,  162,
			  577,  335,  336,  337,  338,  339,  340,  341,  578,  162,
			 1014,  913,  386,  913, 1014,  579,  914,  914,  914,  914,
			 1014,  335,  336,  337,  338,  339,  340,  341,  580, 1014,
			 1014,  746,  746,  746,  746,  581,  922,  922,  922,  922,

			 1014, 1014,  582, 1014, 1014, 1014,  335,  336,  337,  338,
			  339,  340,  341,  335,  336,  337,  338,  339,  340,  341,
			  335,  336,  337,  338,  339,  340,  341,  583, 1014, 1014,
			 1014,  386, 1014, 1014,  584,  335,  336,  337,  338,  339,
			  340,  341,  335,  336,  337,  338,  339,  340,  341,  585,
			  335,  336,  337,  338,  339,  340,  341,  335,  336,  337,
			  338,  339,  340,  341, 1014, 1014, 1014, 1014,  514, 1014,
			  335,  336,  337,  338,  339,  340,  341,  335,  336,  337,
			  338,  339,  340,  341,  335,  336,  337,  338,  339,  340,
			  341, 1014,  612, 1014, 1014,  162,  162,  162,  162, 1014,

			 1014, 1014, 1014, 1014, 1014,  514, 1014,  162,  162,  335,
			  336,  337,  338,  339,  340,  341,  335,  336,  337,  338,
			  339,  340,  341, 1014,  612, 1014, 1014,  162,  162,  162,
			  162,  335,  336,  337,  338,  339,  340,  341, 1014,  162,
			  162, 1014, 1014,  126,  126,  126,  335,  336,  337,  338,
			  339,  340,  341, 1014,  515,  516,  517,  518,  519,  520,
			  521,  269,  270,  271,  272,  273,  274,  275, 1014, 1014,
			  126,  126,  126,  335,  336,  337,  338,  339,  340,  341,
			  126,  126,  126,  335,  336,  337,  338,  339,  340,  341,
			  713,  515,  516,  517,  518,  519,  520,  521,  914,  914,

			  914,  914,  126,  126,  126,  335,  336,  337,  338,  339,
			  340,  341,  914,  914,  914,  914, 1014,  586,  586,  586,
			  335,  336,  337,  338,  339,  340,  341,  838,  838,  838,
			  838, 1014,  587,  587,  587,  335,  336,  337,  338,  339,
			  340,  341,  383,  383,  383,  383, 1014,  610,  967,  967,
			  967,  967,  383,  383,  383,  383,  383,  383,  162,  157,
			  162,  157, 1014,  157,  157,  157, 1014,  737,  157,  611,
			  162,  972,  972,  972,  972, 1014,  157, 1014,  157,  610,
			 1014,  157,  603, 1014,  383,  383,  383,  383,  383,  383,
			  162,  162,  162,  162,  157,  162,  162,  162,  157, 1014,

			  162,  612,  162,  157, 1014,  615,  616,  157,  162, 1014,
			  162,  157,  617,  162, 1014,  162,  162,  162,  162, 1014,
			  157, 1014,  162,  618,  162,  157,  162,  162,  162,  157,
			  162, 1014,  620, 1014,  162,  162,  621,  616,  616,  162,
			  157, 1014,  157,  162,  618, 1014,  619,  162,  162,  162,
			  162, 1014,  162,  157,  162,  618,  162,  162,  622,  162,
			  162,  162, 1014,  157,  620, 1014,  162,  157,  622,  162,
			 1014,  162,  162, 1014,  162, 1014, 1014,  162,  620,  162,
			  623,  162, 1014,  624,  162,  162,  162,  157,  157,  162,
			  622,  157,  627,  626, 1014,  162,  162, 1014, 1014,  162,

			 1014,  162, 1014,  162,  157,  157, 1014,  625, 1014,  162,
			  157,  162,  624,  162,  629,  624,  162, 1014,  162,  162,
			  162,  162,  628,  162,  628,  626,  630,  157,  162,  162,
			  157,  162, 1014,  162,  157,  162,  162,  162, 1014,  626,
			  157,  162,  162, 1014,  157,  162,  630,  157, 1014, 1014,
			  735,  735,  735,  735,  628, 1014, 1014,  157,  630,  162,
			  631,  162,  162,  162,  371,  162,  162,  162, 1014,  162,
			  633,  162,  162,  162,  157, 1014,  162,  162,  632,  162,
			 1014,  162,  157, 1014,  634, 1014,  637,  157, 1014,  162,
			  372, 1014,  632, 1014,  635, 1014,  371, 1014, 1014,  157,

			 1014,  162,  635,  162, 1014,  162,  162,  162,  636, 1014,
			  632, 1014, 1014,  162,  162,  638,  636,  162,  638,  162,
			 1014,  162,  162,  162,  162,  157,  635, 1014,  640,  157,
			 1014,  162, 1014,  162,  162, 1014, 1014,  162, 1014,  162,
			  636, 1014,  157,  639, 1014, 1014, 1014,  638, 1014,  162,
			  162, 1014,  162,  162,  162,  162,  162,  162,  642,  157,
			  640,  162,  162,  157, 1014,  162,  162, 1014,  157,  162,
			  645,  162,  157, 1014,  162,  640,  157,  648,  641,  162,
			  643,  162,  162,  646,  162,  157, 1014, 1014,  157,  162,
			  642,  162,  157,  644,  162,  162, 1014, 1014, 1014,  647,

			  162,  162,  645,  162,  162,  157, 1014, 1014,  162,  648,
			  642,  162,  645,  162, 1014,  646, 1014,  162,  157,  157,
			  162,  162,  649,  157,  162,  646,  157,  651,  657,  157,
			  653,  648,  157,  157, 1014,  157,  157,  162, 1014,  739,
			  739,  739,  739,  157,  655,  157,  157, 1014, 1014, 1014,
			  162,  162, 1014,  593,  650,  162, 1014, 1014,  162,  652,
			  658,  162,  654,  650,  162,  162,  652,  162,  162,  162,
			  162,  162,  162, 1014, 1014,  162,  656,  162,  162,  594,
			  654,  162,  162, 1014,  162,  593,  162,  162,  656,  162,
			 1014, 1014, 1014,  157,  658,  650,  162,  659,  652,  162,

			 1014,  162,  162,  162,  162,  162, 1014,  162, 1014, 1014,
			  157, 1014,  654,  162,  162,  660,  162,  162,  162,  162,
			  656,  162,  162,  661,  162,  162,  658,  157,  162,  660,
			  662,  162, 1014, 1014,  162, 1014, 1014,  162, 1014,  162,
			  157,  162,  162,  162, 1014, 1014,  157,  660, 1014,  162,
			  157, 1014, 1014,  162,  162,  662,  162, 1014,  162,  162,
			  162,  663,  662,  157,  157,  162,  162,  162,  157,  664,
			  162, 1014,  162,  162, 1014,  162, 1014,  162,  162, 1014,
			 1014,  157,  162, 1014, 1014,  162, 1014,  157, 1014, 1014,
			  162,  157,  162,  664,  157,  162,  162,  162,  157,  162,

			  162,  664,  162,  162,  157,  162,  666, 1014,  665,  162,
			  162,  157,  162,  162,  157,  162, 1014, 1014,  667,  162,
			  668, 1014,  162,  162, 1014, 1014,  162,  162,  157,  162,
			  162,  157,  673, 1014, 1014,  162,  162,  162,  666,  162,
			  666, 1014,  162,  162,  162,  157,  162,  162, 1014, 1014,
			  668,  157,  668,  669,  162,  157,  670, 1014, 1014,  162,
			  162,  162,  157,  162,  674, 1014,  675, 1014,  157,  671,
			 1014,  162,  672,  921,  921,  921,  921,  162,  162,  157,
			  162, 1014,  677,  162, 1014,  671,  157,  162,  672,  157,
			  162, 1014, 1014,  157,  162, 1014, 1014, 1014,  676,  157,

			  162,  671, 1014,  157,  672,  681,  157,  157, 1014,  679,
			  162,  162,  162,  157,  678, 1014, 1014,  157,  162, 1014,
			  157,  162,  162,  682, 1014,  162, 1014,  674, 1014, 1014,
			  685,  162, 1014, 1014,  162,  162,  162,  683,  162,  162,
			 1014,  680, 1014, 1014,  676,  162,  162,  678, 1014,  162,
			 1014,  162,  162,  162, 1014,  684, 1014, 1014,  162,  674,
			  162, 1014,  686,  162, 1014,  162,  162,  162,  162,  162,
			  162,  162, 1014,  683,  680,  686,  676,  162,  162,  678,
			 1014,  162,  162,  162,  162,  162,  974,  974,  974,  974,
			  162,  684,  162, 1014,  162,  162, 1014,  162, 1014,  162,

			  157,  162,  162,  162,  687,  683,  680,  686,  689,  162,
			 1014,  688,  157,  162,  162, 1014,  162,  157,  162, 1014,
			  162, 1014,  690,  684,  692,  157,  162,  162, 1014,  162,
			  162, 1014,  162,  162,  157,  162,  688, 1014,  157,  162,
			  690, 1014,  691,  688,  162,  162,  162, 1014,  694,  162,
			  162,  157,  162, 1014,  690, 1014,  692,  162,  162,  162,
			 1014,  162,  162, 1014, 1014,  162,  162,  162,  157,  157,
			  162,  162,  157,  695,  692,  696, 1014,  162,  162, 1014,
			  694,  693,  162,  162,  162,  157,  157, 1014, 1014,  157,
			  162, 1014,  157,  697,  162,  157,  157, 1014, 1014,  157,

			  162,  162, 1014,  701,  162,  696,  157,  696,  699,  157,
			 1014, 1014,  157,  694,  162, 1014,  162,  162,  162, 1014,
			 1014,  162, 1014,  698,  162,  698,  162,  162,  162, 1014,
			  162,  162,  162, 1014,  162,  702,  162, 1014,  162,  700,
			  700,  162,  162, 1014,  162,  702,  162, 1014,  162, 1014,
			  162, 1014, 1014,  157, 1014,  698, 1014,  157, 1014, 1014,
			  162,  703,  162, 1014,  162, 1014,  162, 1014,  162,  157,
			  157,  700,  705,  157,  162,  499,  704,  702,  162,  162,
			  162,  162,  162, 1014,  514,  162,  157,  706,  162,  162,
			  708,  162,  162,  704,  162,  162,  162,  162,  499,  157,

			  162,  162,  162,  157,  706,  162,  162,  162,  704,  499,
			 1014,  162,  707,  162, 1014, 1014,  157,  157,  162,  706,
			  162,  157,  708,  162,  499, 1014,  162,  162,  162,  162,
			 1014,  162,  162, 1014,  157,  162,  499, 1014,  162,  162,
			  921,  921,  921,  921,  708, 1014,  499, 1014,  162,  162,
			 1014, 1014,  514,  162, 1014, 1014, 1014,  248,  249,  250,
			  251,  252,  253,  254,  514, 1014,  162,  714,  714,  714,
			  515,  516,  517,  518,  519,  520,  521,  514, 1014, 1014,
			  248,  249,  250,  251,  252,  253,  254,  514, 1014, 1014,
			 1014,  248,  249,  250,  251,  252,  253,  254,  522,  269,

			  270,  271,  272,  273,  274,  275,  248,  249,  250,  251,
			  252,  253,  254,  522, 1014,  709,  709,  709,  248,  249,
			  250,  251,  252,  253,  254,  710,  710,  710,  248,  249,
			  250,  251,  252,  253,  254,  715,  715,  522,  515,  516,
			  517,  518,  519,  520,  521, 1014, 1014,  716,  716,  716,
			  515,  516,  517,  518,  519,  520,  521,  522, 1014, 1014,
			  717,  717,  717,  515,  516,  517,  518,  519,  520,  521,
			  718,  522, 1014,  515,  516,  517,  518,  519,  520,  521,
			 1014,  522, 1014, 1014,  523,  524,  525,  526,  527,  528,
			  529,  522, 1014, 1014,  606,  606,  606,  606,  719,  523,

			  524,  525,  526,  527,  528,  529,  278, 1014, 1014,  278,
			  923,  285,  923, 1014,  268,  921,  921,  921,  921, 1014,
			  720,  720,  720,  523,  524,  525,  526,  527,  528,  529,
			  278, 1014, 1014,  278,  386,  285, 1014, 1014,  268, 1014,
			  721,  721, 1014,  523,  524,  525,  526,  527,  528,  529,
			  842,  842,  842,  842,  722,  722,  722,  523,  524,  525,
			  526,  527,  528,  529,  723,  723,  723,  523,  524,  525,
			  526,  527,  528,  529,  724, 1014, 1014,  523,  524,  525,
			  526,  527,  528,  529,  278, 1014, 1014,  278, 1014,  285,
			  843, 1014,  268,  969,  969,  969,  969,  286,  287,  288,

			  289,  290,  291,  292,  278, 1014, 1014,  278, 1014,  285,
			 1014,  279,  268, 1014,  279, 1014,  293, 1014, 1014,  268,
			 1014,  286,  287,  288,  289,  290,  291,  292,  278, 1014,
			 1014,  278, 1014,  285, 1014, 1014,  268, 1014,  278, 1014,
			 1014,  278, 1014,  285, 1014,  279,  268, 1014,  279, 1014,
			  293, 1014,  279,  268, 1014,  279, 1014,  293, 1014,  279,
			  268, 1014,  279, 1014,  293, 1014, 1014,  268,  335,  336,
			  337,  338,  339,  340,  341,  286,  287,  288,  289,  290,
			  291,  292,  279, 1014, 1014,  279,  968,  293,  968, 1014,
			  268,  969,  969,  969,  969,  286,  287,  288,  289,  290,

			  291,  292,  294,  295,  296,  297,  298,  299,  300,  545,
			 1014, 1014,  544, 1014, 1014, 1014,  725,  725,  725,  286,
			  287,  288,  289,  290,  291,  292,  726,  726,  726,  286,
			  287,  288,  289,  290,  291,  292,  294,  295,  296,  297,
			  298,  299,  300,  294,  295,  296,  297,  298,  299,  300,
			  294,  295,  296,  297,  298,  299,  300,  279, 1014, 1014,
			  279,  970,  293,  970, 1014,  268,  971,  971,  971,  971,
			  727,  727,  727,  294,  295,  296,  297,  298,  299,  300,
			  106, 1014, 1014,  544, 1014, 1014,  845,  845,  845,  845,
			  106, 1014, 1014,  544, 1014,  312,  313,  314,  315,  316,

			  317,  318,  118,  729,  729,  729,  729,  545,  157, 1014,
			  544, 1014,  157, 1014,  106, 1014, 1014,  544, 1014, 1014,
			 1014,  106, 1014, 1014,  544,  157,  744,  747,  106,  754,
			  162,  544,  162,  118, 1014,  106, 1014, 1014,  544, 1014,
			  162, 1014,  162, 1014,  162,  728,  728,  728,  294,  295,
			  296,  297,  298,  299,  300,  106, 1014,  162,  544,  748,
			 1014,  754,  162, 1014,  162, 1014,  312,  313,  314,  315,
			  316,  317,  318, 1014,  162, 1014,  312,  313,  314,  315,
			  316,  317,  318,  106, 1014, 1014,  544,  848, 1014,  606,
			  606,  606,  606,  312,  313,  314,  315,  316,  317,  318,

			  312,  313,  314,  315,  316,  317,  318,  312,  313,  314,
			  315,  316,  317,  318,  312,  313,  314,  315,  316,  317,
			  318,  312,  313,  314,  315,  316,  317,  318,  106,  149,
			 1014,  107,  971,  971,  971,  971, 1014, 1014,  730,  730,
			  730,  312,  313,  314,  315,  316,  317,  318,  106, 1014,
			 1014,  107, 1014, 1014, 1014,  106, 1014, 1014,  107, 1014,
			 1014, 1014,  106, 1014, 1014,  107,  731,  731,  731,  312,
			  313,  314,  315,  316,  317,  318, 1014,  108, 1014,  162,
			 1014,  772,  745, 1014,  597,  597,  598,  598, 1014, 1014,
			 1014,  162, 1014, 1014, 1014,  150,  976,  108,  976, 1014,

			 1014,  977,  977,  977,  977,  971,  971,  971,  971,  109,
			 1014,  162, 1014,  772,  110,  111,  112,  113,  114,  115,
			  116, 1014, 1014,  162,  386, 1014, 1014,  150, 1014,  109,
			 1014, 1014, 1014, 1014,  110,  111,  112,  113,  114,  115,
			  116,  119,  120,  121,  122,  123,  124,  125,  119,  120,
			  121,  122,  123,  124,  125, 1014, 1014, 1014,  335,  336,
			  337,  338,  339,  340,  341,  335,  336,  337,  338,  339,
			  340,  341,  335,  336,  337,  338,  339,  340,  341,  732,
			  732,  732,  335,  336,  337,  338,  339,  340,  341,  733,
			  733,  733,  335,  336,  337,  338,  339,  340,  341, 1014,

			 1003, 1003, 1003, 1003, 1014, 1014, 1014,  734,  569,  569,
			  569,  569,  126,  126,  126,  335,  336,  337,  338,  339,
			  340,  341,  977,  977,  977,  977, 1014,  157, 1014, 1014,
			 1014,  157, 1014, 1014,  126,  126,  126,  335,  336,  337,
			  338,  339,  340,  341,  157,  749, 1014,  735,  735,  735,
			  735, 1005, 1005, 1005, 1005, 1014,  162, 1014,  162,  162,
			  162,  837,  162,  162,  748, 1014, 1014,  750,  162, 1014,
			 1014, 1014,  162, 1014,  157, 1014,  162,  750,  157, 1014,
			  751,  335,  336,  337,  338,  339,  340,  341,  162, 1014,
			  162,  157,  162,  837,  162, 1014,  748,  157,  752,  750,

			  162,  157, 1014,  162,  162,  162,  162,  753, 1014,  157,
			  162, 1014,  752,  157,  157,  162, 1014,  157, 1014, 1014,
			 1014,  757, 1014,  162, 1014, 1014,  157,  755, 1014,  162,
			  752, 1014, 1014,  162,  157,  162,  162,  162,  162,  754,
			 1014,  162, 1014,  756, 1014,  162,  162,  162,  162,  162,
			 1014, 1014,  157,  758,  758, 1014,  157, 1014,  162,  756,
			 1014,  162, 1014,  162, 1014, 1014,  162, 1014,  162,  157,
			  162,  759, 1014,  162,  157,  756, 1014,  162,  761,  162,
			  162, 1014, 1014,  762,  162,  760,  758, 1014,  162,  162,
			  162,  157,  162,  162, 1014,  162,  914,  914,  914,  914,

			 1014,  162,  162,  760, 1014,  162,  162, 1014,  157,  162,
			  762,  162,  157,  764,  763,  762, 1014,  760,  162, 1014,
			  162,  162,  162,  162,  162,  157,  162, 1014,  162, 1014,
			  162,  157,  766, 1014,  162,  157,  737, 1014,  162,  157,
			  162, 1014, 1014,  157,  162,  764,  764,  767,  765,  157,
			  162, 1014,  162,  157, 1014, 1014,  157,  162,  162, 1014,
			  162, 1014,  162,  162,  766, 1014,  769,  162, 1014,  768,
			  162,  162,  162,  157,  162,  162, 1014,  157,  157,  768,
			  766,  162,  157, 1014,  162,  162,  771,  162,  162,  162,
			  157, 1014, 1014,  770, 1014,  773, 1014, 1014,  770,  162, yy_Dummy>>,
			1, 3000, 3000)
		end

	yy_nxt_template_3 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			 1014,  768, 1014,  157,  162,  162,  162,  157, 1014,  162,
			  162,  162, 1014,  162,  162, 1014,  162,  774,  772,  162,
			  775,  162,  162,  162,  162,  770,  162,  774, 1014,  157,
			  776,  162, 1014,  777,  157,  162,  162, 1014,  157,  162,
			 1014,  778, 1014,  162, 1014,  162,  157, 1014,  162,  774,
			  162,  157,  776, 1014,  779,  162,  162, 1014,  162, 1014,
			  162,  162,  776, 1014, 1014,  778,  162,  162,  162,  162,
			  162,  157,  162,  778,  162,  157,  780,  157,  162,  162,
			  162,  781,  162,  162,  162,  157,  780, 1014,  157,  157,
			 1014,  782,  162,  783,  157, 1014, 1014, 1014,  162,  162,

			  162,  162,  157,  162,  162, 1014,  162,  162,  780,  162,
			  162,  162, 1014,  782,  157, 1014,  162,  162,  157, 1014,
			  162,  162, 1014,  782,  784,  784,  162,  162, 1014,  162,
			  162,  157,  162,  162,  162,  162,  162,  785,  162,  162,
			  157, 1014,  162,  157,  157,  786,  162,  157,  788, 1014,
			  162, 1014,  162, 1014,  162, 1014,  784,  789,  790,  162,
			  157,  162, 1014,  162,  162,  162,  787,  162,  162,  786,
			  162,  162,  162, 1014,  157,  162,  162,  786,  791,  162,
			  788, 1014, 1014,  157,  162, 1014,  162,  157,  792,  790,
			  790,  157,  162, 1014, 1014,  162,  162,  162,  788,  162,

			  793,  162, 1014, 1014,  157,  794,  162,  162,  157, 1014,
			  792,  162,  162, 1014,  162,  162,  796, 1014,  162,  162,
			  792,  157, 1014,  162,  162, 1014, 1014,  162,  162,  162,
			  157,  162,  794,  162,  157, 1014,  162,  794,  157,  162,
			  162,  795,  157,  162,  162, 1014,  162,  157,  796,  162,
			  162,  162, 1014,  162,  157,  157,  162,  798,  157,  162,
			  162,  162,  162,  157, 1014,  797,  162,  157, 1014,  162,
			  162,  157, 1014,  796,  162, 1014,  162, 1014,  162,  162,
			  157,  162, 1014,  162, 1014, 1014,  162,  162,  162,  798,
			  162,  162,  157,  162,  157,  162,  157,  798,  157,  162,

			  801,  162,  802,  162,  162,  162,  162,  162,  162,  157,
			  162,  157,  162,  800,  799, 1014,  162,  162,  157, 1014,
			  162, 1014,  157,  803,  162, 1014,  162, 1014,  162, 1014,
			  162, 1014,  802, 1014,  802,  157,  162,  162,  162,  162,
			 1014,  162, 1014,  162, 1014,  800,  800, 1014,  162,  162,
			  162,  804, 1014, 1014,  162,  804,  157,  162, 1014,  162,
			  157, 1014,  162, 1014,  162, 1014, 1014,  162,  806,  162,
			 1014, 1014, 1014,  805,  162,  162,  808,  162,  157, 1014,
			 1014, 1014,  157,  804, 1014, 1014, 1014,  162,  162,  162,
			  807,  162,  162, 1014,  162,  157,  162, 1014, 1014, 1014,

			  806,  162, 1014, 1014, 1014,  806,  162,  162,  808,  162,
			  162,  157,  157,  157,  162,  157,  157,  157,  810,  162,
			  809,  162,  808,  162,  813, 1014, 1014,  162,  157,  157,
			  157,  811, 1014,  162, 1014, 1014, 1014, 1014, 1014,  814,
			 1014,  162, 1014,  162,  162,  162, 1014,  162,  162,  162,
			  810,  162,  810,  162, 1014,  162,  814,  162, 1014,  162,
			  162,  162,  162,  812,  157,  162,  812, 1014,  157,  162,
			 1014,  814,  162,  162,  162,  157,  157,  817, 1014,  157,
			  157,  157,  157,  162,  162,  816,  157, 1014,  815,  162,
			 1014,  162,  157,  819,  818, 1014,  162,  821,  812,  157,

			  162,  162, 1014,  162,  162,  162,  162,  162,  162,  818,
			 1014,  162,  162,  162,  162,  162,  162,  816,  162, 1014,
			  816,  162, 1014,  162,  162,  820,  818,  820,  162,  822,
			  162,  162,  822,  162,  157,  162, 1014,  162,  157,  157,
			  162, 1014,  162,  157,  162, 1014,  162,  162,  162, 1014,
			 1014,  157, 1014,  162,  162,  162,  157, 1014,  162,  820,
			  162,  824,  162, 1014,  822,  162,  162,  162, 1014,  162,
			  162,  162,  162, 1014,  162,  162,  162,  157,  162,  162,
			  162,  157,  823,  162, 1014,  157,  162, 1014,  162,  157,
			  162, 1014, 1014,  824,  157,  162, 1014,  162,  828,  162,

			  162,  162,  157, 1014,  826,  825, 1014,  162,  157,  162,
			  162,  162,  157,  162,  824, 1014,  829,  162, 1014,  827,
			  157,  162, 1014,  499, 1014,  157,  162,  162, 1014,  162,
			  828,  499,  162,  157,  162,  514,  826,  826, 1014,  162,
			  162,  157,  162,  830,  162,  157,  157,  162,  830,  162,
			  157,  828,  162,  514,  162, 1014,  162,  162,  157,  162,
			  162,  514,  162,  157, 1014,  162,  162, 1014,  514, 1014,
			 1014, 1014,  162,  162, 1014,  830, 1014,  162,  162,  162,
			  514,  162,  162, 1014, 1014, 1014,  162, 1014,  162, 1014,
			  162,  162,  162,  514,  162,  162, 1014, 1014,  162, 1014,

			  522, 1014, 1014, 1014,  162,  248,  249,  250,  251,  252,
			  253,  254,  522,  248,  249,  250,  251,  252,  253,  254,
			  522,  515,  516,  517,  518,  519,  520,  521,  522, 1014,
			 1014, 1014, 1014,  918,  918,  918,  918, 1014,  522,  515,
			  516,  517,  518,  519,  520,  521, 1014,  515,  516,  517,
			  518,  519,  520,  521,  515,  516,  517,  518,  519,  520,
			  521,  522, 1014,  831,  831,  831,  515,  516,  517,  518,
			  519,  520,  521,  843, 1014, 1014,  832,  832,  832,  515,
			  516,  517,  518,  519,  520,  521,  523,  524,  525,  526,
			  527,  528,  529,  921,  921,  921,  921, 1014,  523,  524,

			  525,  526,  527,  528,  529, 1014,  523,  524,  525,  526,
			  527,  528,  529, 1014,  523,  524,  525,  526,  527,  528,
			  529,  833,  833,  833,  523,  524,  525,  526,  527,  528,
			  529,  278, 1014,  744,  278, 1014,  285, 1014, 1014,  268,
			 1014, 1014, 1014,  514,  834,  834,  834,  523,  524,  525,
			  526,  527,  528,  529,  278, 1014, 1014,  278, 1014,  285,
			 1014,  279,  268, 1014,  279, 1014,  293, 1014,  279,  268,
			 1014,  279, 1014,  293, 1014, 1014,  268,  162, 1014,  162,
			  106, 1014, 1014,  544, 1014, 1014, 1014,  106, 1014,  162,
			  544, 1014,  118,  835,  835,  835,  835,  106, 1014, 1014,

			  544, 1014, 1014, 1014,  971,  971,  971,  971,  836,  162,
			 1014,  162, 1014, 1014,  335,  336,  337,  338,  339,  340,
			  341,  162,  286,  287,  288,  289,  290,  291,  292,  515,
			  516,  517,  518,  519,  520,  521, 1014,  335,  336,  337,
			  338,  339,  340,  341,  843,  286,  287,  288,  289,  290,
			  291,  292,  294,  295,  296,  297,  298,  299,  300,  294,
			  295,  296,  297,  298,  299,  300,  312,  313,  314,  315,
			  316,  317,  318,  312,  313,  314,  315,  316,  317,  318,
			 1014, 1014, 1014,  312,  313,  314,  315,  316,  317,  318,
			  335,  336,  337,  338,  339,  340,  341,  841,  841,  841,

			  841,  841,  841,  841,  841, 1014,  157,  162,  157,  162,
			  157,  593,  157,  157, 1014,  847,  162,  157,  850,  162,
			  162, 1014,  162,  157, 1014,  157,  849, 1014,  162,  157,
			  157, 1014,  162,  157, 1014, 1014, 1014,  594,  162,  162,
			  162,  162,  162,  593,  162,  162,  157,  847,  162,  162,
			  850,  162,  162, 1014,  162,  162, 1014,  162,  850,  157,
			  162,  162,  162,  157,  162,  162,  157,  162, 1014,  162,
			  157, 1014, 1014, 1014, 1014,  162,  157,  162,  162,  162,
			  157,  852, 1014,  851,  853,  855,  157,  162,  854,  856,
			  157,  162,  162, 1014,  162,  162, 1014,  157,  162,  162,

			 1014,  162,  162,  157,  162, 1014, 1014,  162,  162,  162,
			  157,  162,  162,  852,  157,  852,  855,  855,  162,  162,
			  856,  856,  162,  857,  162, 1014,  162,  157,  162,  162,
			  858,  162, 1014,  162,  157,  162,  162, 1014,  157,  862,
			  162, 1014,  162,  162,  157,  162,  162,  162,  157,  861,
			 1014,  859,  162, 1014,  162,  858, 1014,  162,  860,  162,
			  162,  157,  858,  162,  162,  162,  162, 1014, 1014, 1014,
			  162,  862,  162, 1014,  157,  162,  162,  162,  863,  162,
			  162,  862, 1014,  860,  162,  864,  162, 1014, 1014,  162,
			  860,  157,  162,  162,  162,  157,  162, 1014,  865,  157,

			 1014,  866, 1014,  157,  162, 1014,  162,  157, 1014,  162,
			  864,  162,  157, 1014, 1014,  157, 1014,  864, 1014,  157,
			  157,  162,  867,  162,  162, 1014,  162,  162,  869, 1014,
			  866,  162,  157,  866, 1014,  162,  162, 1014,  162,  162,
			  162,  162, 1014,  162,  162,  157,  868,  162, 1014,  157,
			  162,  162,  162,  162,  868,  162,  162,  870,  162,  157,
			  870, 1014,  157,  157,  162, 1014, 1014,  162,  162, 1014,
			  162, 1014,  162,  162, 1014,  162,  871,  162,  868,  872,
			  157,  162,  162, 1014,  157,  162, 1014,  162,  162,  870,
			  162,  162,  157,  873,  162,  162,  875,  157, 1014,  162,

			  162,  162, 1014,  874, 1014,  162, 1014,  162,  872,  157,
			 1014,  872,  162,  162,  157, 1014,  162,  162,  157, 1014,
			 1014, 1014,  877,  876,  162,  874, 1014, 1014,  876,  162,
			  162,  157,  162,  162,  878,  874,  157,  162, 1014,  162,
			  157,  162,  162, 1014,  157,  162,  162, 1014,  157,  162,
			  162, 1014,  879,  157,  878,  876, 1014, 1014,  162, 1014,
			  162,  157,  162,  162,  162, 1014,  878, 1014,  162,  162,
			  162,  162,  162, 1014,  162, 1014,  162, 1014, 1014, 1014,
			  162,  162, 1014,  880,  880,  162,  162,  157,  162,  881,
			  162,  157,  162,  162, 1014,  157,  882, 1014,  162,  157,

			 1014, 1014,  162,  883,  157,  162, 1014,  162, 1014, 1014,
			 1014,  884,  157, 1014,  162,  880,  162,  162,  162,  162,
			  162,  882,  162,  162,  162,  157,  162,  162,  882,  157,
			  162,  162, 1014, 1014,  162,  884,  162,  162, 1014,  162,
			 1014, 1014,  157,  884,  162, 1014,  162,  157,  162,  162,
			 1014,  885, 1014,  886,  162, 1014,  162,  162,  162,  157,
			  162,  162,  162,  157,  157,  162,  162,  162,  162, 1014,
			  162,  888,  162, 1014,  162, 1014,  887,  162, 1014,  162,
			  890, 1014, 1014,  886,  157,  886, 1014, 1014,  157, 1014,
			 1014,  162,  162, 1014,  162,  162,  162,  162, 1014,  162,

			  162,  157,  162,  888,  162, 1014,  157,  889,  888,  162,
			  157,  157,  890,  157,  891,  893,  162,  895,  894,  892,
			  162, 1014,  162,  157,  162,  162, 1014,  162,  157,  162,
			  157,  162, 1014,  162,  162, 1014,  157,  162,  162,  890,
			  157,  162,  162,  162, 1014,  162,  892,  894, 1014,  896,
			  894,  892, 1014,  897,  162,  162,  162,  162,  896,  162,
			  162,  162,  162,  162, 1014,  162,  162,  162,  162,  162,
			 1014,  157,  162,  162,  162,  899,  162,  162, 1014,  157,
			  898, 1014,  900,  157, 1014,  898,  162, 1014,  157,  162,
			  896,  162,  162, 1014,  162, 1014,  157,  162,  901,  162,

			  902,  162, 1014,  162,  162, 1014,  162,  900,  162,  162,
			 1014,  162,  898, 1014,  900,  162, 1014, 1014,  162, 1014,
			  162,  162, 1014,  162,  162,  157,  162,  157,  162,  157,
			  902,  157,  902,  162,  905,  162,  162,  162,  157,  906,
			 1014,  157,  157,  904,  157,  157,  903,  162, 1014, 1014,
			  162,  157,  162,  162, 1014,  162, 1014,  162,  157,  162,
			 1014,  162,  162,  162,  157,  162,  906,  162,  157,  162,
			  162,  906,  907,  162,  162,  904,  162,  162,  904,  162,
			 1014,  157,  162,  162,  162,  162,  908,  162,  157,  162,
			  162,  162,  909, 1014,  162, 1014,  162,  162,  157,  514,

			  162,  162,  157,  910,  908,  157,  522,  162, 1014,  162,
			  162, 1014,  162,  162,  162,  157,  912,  522,  908,  162,
			  162,  162,  162,  162,  910, 1014,  162, 1014,  106, 1014,
			  162,  544,  157,  162,  162,  910,  157,  162, 1014,  162,
			  118,  162,  162, 1014,  162,  911,  162,  162,  912,  157,
			 1014,  162, 1014, 1014,  162, 1004, 1014, 1004,  162, 1014,
			 1005, 1005, 1005, 1005,  162, 1014, 1014, 1014,  162, 1014,
			 1002, 1002, 1002, 1002, 1014, 1014, 1014,  912, 1014, 1014,
			 1014,  162, 1014, 1014, 1014,  515,  516,  517,  518,  519,
			  520,  521,  523,  524,  525,  526,  527,  528,  529,  841,

			  841,  841,  841,  523,  524,  525,  526,  527,  528,  529,
			  737, 1014, 1014,  917,  312,  313,  314,  315,  316,  317,
			  318,  925,  925,  925,  925,  157,  162,  157,  162,  157,
			 1014,  157,  157, 1014, 1014,  926,  157, 1014,  162,  162,
			 1014,  162,  157, 1014,  157,  917,  927,  928,  157,  157,
			 1014,  162,  157, 1014,  162, 1014,  162,  162,  162,  162,
			  162,  162,  929,  162,  162,  157,  162,  926,  162, 1014,
			  162,  162, 1014,  162,  162, 1014,  162, 1014,  928,  928,
			  162,  162, 1014,  162,  162, 1014,  162,  162,  162,  162,
			  930,  157, 1014, 1014,  930,  157, 1014,  162,  162,  162,

			  157,  162, 1014,  162,  933,  934, 1014, 1014,  157,  932,
			  931,  157,  162,  162,  162,  157, 1014,  157,  162,  162,
			  162,  162,  930,  162,  162, 1014, 1014,  162,  157, 1014,
			  162,  162,  162,  162,  157,  162,  934,  934,  157, 1014,
			  162,  932,  932,  162,  162,  162,  162,  162, 1014,  162,
			  162,  157,  162,  162,  157,  162,  162,  157,  935, 1014,
			  162,  157,  162,  937, 1014,  162,  162,  157, 1014,  936,
			  162,  157, 1014, 1014,  157, 1014,  162, 1014,  162,  162,
			  157,  162, 1014,  162, 1014,  162,  162,  162,  162,  162,
			  936,  162,  157,  162,  938,  938,  939,  162, 1014,  162,

			 1014,  936, 1014,  162, 1014,  162,  162,  162,  162,  157,
			  162,  162,  162,  162,  157, 1014, 1014,  162,  157, 1014,
			  162, 1014, 1014,  162,  162,  940,  938, 1014,  940, 1014,
			 1014,  157,  162,  162,  162,  162,  157,  162, 1014,  162,
			  157,  162, 1014,  157,  162,  162,  162,  157, 1014,  162,
			  162, 1014, 1014,  157,  941, 1014,  943,  940, 1014, 1014,
			  157, 1014, 1014,  162,  162,  162,  162,  162,  162, 1014,
			  157,  162,  162,  162,  157,  162,  162,  162,  942,  162,
			 1014, 1014,  162,  162,  944,  162,  942,  157,  944,  945,
			 1014, 1014,  162, 1014,  162, 1014,  162, 1014,  162,  162,

			 1014,  162,  162,  162,  946,  162,  162,  948,  162, 1014,
			  942,  162, 1014, 1014,  162,  162,  944, 1014,  157,  162,
			 1014,  946,  157, 1014, 1014,  949,  162, 1014,  162,  157,
			  162,  162, 1014,  162,  157,  157,  946,  947,  157,  948,
			  162, 1014,  157,  162, 1014,  950, 1014,  162, 1014,  162,
			  162,  157, 1014,  951,  162,  952,  162,  950,  162,  162,
			 1014,  162, 1014, 1014, 1014, 1014,  162,  162,  162,  948,
			  162, 1014, 1014, 1014,  162, 1014,  157,  950, 1014,  162,
			  157,  162,  157,  162, 1014,  952,  157,  952,  162, 1014,
			  162,  162,  157,  157,  953,  162,  157,  162, 1014,  157,

			  162,  162,  954,  162,  162,  955,  956,  162,  162,  157,
			 1014, 1014,  162,  162,  162, 1014,  162, 1014,  162, 1014,
			  162, 1014,  958, 1014,  162,  162,  954,  162,  162,  162,
			 1014,  162,  162,  162,  954,  162,  162,  956,  956,  162,
			  157,  162,  157,  157,  157,  162,  157,  959,  162,  162,
			 1014,  162,  162,  957,  958, 1014, 1014,  157,  960,  157,
			  157,  162, 1014, 1014,  162,  162, 1014,  162,  162,  157,
			  162, 1014,  162,  157,  162,  162,  162,  162,  162,  960,
			  162,  162, 1014,  162, 1014,  958,  157, 1014, 1014,  162,
			  960,  162,  162,  162,  157, 1014, 1014,  162,  157,  162,

			  162,  162,  162,  157,  162,  162,  162,  157, 1014,  162,
			  157,  157,  162,  162,  157,  162,  162, 1014,  162,  162,
			  157,  964, 1014, 1014,  157,  162,  162,  157,  157,  961,
			  162,  162,  162, 1014,  162,  162,  162,  963,  162,  162,
			  962,  157,  162,  162,  162,  162,  162,  162,  162, 1014,
			  157,  162,  162,  964,  157, 1014,  162,  162,  157,  162,
			  162,  962,  157,  162,  162, 1014,  162,  157,  162,  964,
			  162, 1014,  962,  162, 1014,  157,  162,  965, 1014,  162,
			  162,  162,  162, 1014,  157, 1014,  162,  966,  157, 1014,
			  162,  162, 1014,  157,  162, 1014,  162,  157,  162,  162,

			  162,  157,  162,  975,  975,  975,  975,  162,  162,  966,
			  157,  162,  162,  162,  157, 1014,  162,  973,  157,  966,
			  162, 1014,  162,  162,  979,  162, 1014,  978,  162,  162,
			  162,  157, 1014,  162,  162,  162, 1014,  162, 1014, 1014,
			  162,  157,  162,  594,  980,  157,  162,  162, 1014,  973,
			  162, 1014,  981, 1014,  162, 1014,  979, 1014,  157,  979,
			  162,  157,  162,  162,  982,  157,  162,  162, 1014,  162,
			  157, 1014,  162,  162,  157,  983,  981,  162,  157,  162,
			 1014,  984, 1014,  162,  981,  162,  985,  157,  162,  162,
			  162,  162,  162,  162,  162,  162,  983,  162,  162,  157,

			 1014,  162,  162,  157,  162,  157,  162,  983, 1014,  157,
			  162, 1014,  162,  985,  162,  162,  157,  162,  985,  162,
			  162,  162,  157,  162,  162, 1014, 1014,  162,  157, 1014,
			  162,  162,  157,  162,  986,  162,  157,  162, 1014, 1014,
			  157,  162,  987, 1014,  162,  157,  162,  162,  162,  162,
			  162, 1014,  162,  157,  162,  162,  162,  162, 1014,  162,
			  162,  157,  162, 1014,  162,  157,  987,  162,  162, 1014,
			 1014, 1014,  162, 1014,  987, 1014, 1014,  162,  157,  162,
			 1014,  162,  162, 1014,  162,  162,  157,  162,  157,  162,
			  990,  162,  157,  162,  162,  991,  162,  162,  989,  162,

			 1014,  988,  162,  157,  162,  157, 1014, 1014,  162,  157,
			  162, 1014,  157,  157,  162, 1014,  994, 1014,  162, 1014,
			  162, 1014,  991,  992,  162, 1014,  157,  991,  162,  157,
			  989, 1014, 1014,  989,  162,  162,  162,  162, 1014, 1014,
			  162,  162, 1014, 1014,  162,  162,  162,  162,  995,  162,
			  993, 1014,  157,  995,  996,  993,  157,  997,  162,  162,
			  162,  162,  162,  157, 1014, 1014,  162,  157,  162,  157,
			  157,  162,  162,  162,  998, 1014, 1014, 1014,  162,  162,
			  157,  162,  993,  162,  162,  995,  997,  157,  162,  997,
			 1014,  162,  162, 1014,  162,  162, 1014, 1014,  162,  162,

			  162,  162,  162,  162,  162,  162,  999,  999, 1014, 1014,
			  162, 1014,  162,  157,  162,  162,  162, 1000, 1001,  162,
			  162, 1014,  162, 1014,  157,  162,  162,  162,  157, 1014,
			  157, 1014,  162, 1014, 1014, 1014, 1014,  162, 1014,  999,
			 1014,  157, 1014, 1014, 1014,  162,  162, 1014,  162, 1001,
			 1001,  162,  162,  162,  162, 1014,  162,  162,  162,  162,
			  162, 1014,  162,  162,  162,  920,  920,  920,  920,  162,
			 1014, 1014, 1014,  162, 1006, 1006, 1006, 1006, 1014,  973,
			  157, 1014, 1014,  162,  157,  162,  157,  162, 1014,  162,
			  157, 1014,  157, 1014, 1014,  162,  157,  157,  162,  162,

			  162, 1014, 1014,  157, 1014,  594, 1014, 1014, 1014,  157,
			  162,  973,  162,  162,  744,  162,  162, 1014,  162,  162,
			 1014,  162,  162,  157,  162,  162, 1014,  157,  162,  162,
			  162,  162,  162,  157,  162,  162,  162,  157, 1014,  157,
			  157,  162,  162,  157,  157,  162,  162,  162,  157, 1014,
			  157,  162,  162,  162,  162,  162,  157,  162, 1007,  162,
			 1008,  157, 1014,  162,  162,  162,  162, 1014,  162,  162,
			  157,  162,  162, 1014,  157,  162,  162, 1014,  162, 1014,
			  162, 1014,  162,  162,  162,  162,  162, 1009,  162,  162,
			 1008,  162, 1008,  162,  157,  162,  162,  162,  157,  162,

			  157,  162,  162, 1010, 1011, 1012,  162, 1014,  162,  162,
			  162,  157,  162,  162,  162,  162, 1014,  157, 1014, 1010,
			  162,  162, 1014,  162,  162,  162,  162, 1014, 1014,  162,
			  162,  162,  162,  162,  157, 1010, 1012, 1012,  157, 1014,
			  162,  162,  162,  162,  162,  162,  162,  162, 1014,  162,
			  157,  157,  162, 1014,  157, 1014,  162,  162,  967,  967,
			  967,  967, 1013, 1013, 1013, 1013,  162,  157, 1014, 1014,
			  162,  974,  974,  974,  974,  162,  157,  162, 1014, 1014,
			  157, 1014,  162,  162,  157, 1014,  162,  162,  157, 1014,
			 1014, 1014,  162,  157,  162, 1014,  157, 1014,  737,  162, yy_Dummy>>,
			1, 3000, 6000)
		end

	yy_nxt_template_4 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			  157,  157,  843,  162,  162,  162, 1014,  162,  162,  162,
			 1014,  744,  162,  157, 1014,  162,  162, 1014, 1014,  162,
			  162, 1014, 1014, 1014,  162,  162,  162, 1014,  162, 1014,
			 1014, 1014,  162,  162, 1014,  162,  162,  162, 1003, 1003,
			 1003, 1003, 1014, 1014, 1014,  162, 1014,  162,  145,  145,
			  145,  145,  145,  145,  145,  145,  145,  145,  145,  145,
			  145,  145,  162,  162,  162,  162,  162,  162,  162,  162,
			  162,  162,  162,  162,  162,  162, 1014, 1014,  843,   86,
			   86,   86,   86,   86,   86,   86,   86,   86,   86,   86,
			   86,   86,   86,   86,   86,   86,   86,   86,   86,   86,

			   86,   86,  105,  105, 1014,  105,  105,  105,  105,  105,
			  105,  105,  105,  105,  105,  105,  105,  105,  105,  105,
			  105,  105,  105,  105,  105,  117, 1014, 1014, 1014, 1014,
			 1014, 1014,  117,  117,  117,  117,  117,  117,  117,  117,
			  117,  117,  117,  117,  117,  117,  117,  117,  118,  118,
			 1014,  118,  118,  118,  118,  118,  118,  118,  118,  118,
			  118,  118,  118,  118,  118,  118,  118,  118,  118,  118,
			  118,  126,  126, 1014,  126,  126,  126,  126, 1014,  126,
			  126,  126,  126,  126,  126,  126,  126,  126,  126,  126,
			  126,  126,  126,  126,  247,  247, 1014,  247,  247,  247,

			 1014, 1014,  247,  247,  247,  247,  247,  247,  247,  247,
			  247,  247,  247,  247,  247,  247,  247,  268, 1014, 1014,
			  268, 1014,  268,  268,  268,  268,  268,  268,  268,  268,
			  268,  268,  268,  268,  268,  268,  268,  268,  268,  268,
			  282,  282, 1014,  282,  282,  282,  282,  282,  282,  282,
			  282,  282,  282,  282,  282,  282,  282,  282,  282,  282,
			  282,  282,  282,  283,  283, 1014,  283,  283,  283,  283,
			  283,  283,  283,  283,  283,  283,  283,  283,  283,  283,
			  283,  283,  283,  283,  283,  283,  307,  307, 1014,  307,
			  307,  307,  307,  307,  307,  307,  307,  307,  307,  307,

			  307,  307,  307,  307,  307,  307,  307,  307,  307,  333,
			 1014, 1014, 1014, 1014,  333,  333,  333,  333,  333,  333,
			  333,  333,  333,  333,  333,  333,  333,  333,  333,  333,
			  333,  333,  373,  373,  373,  373,  373,  373,  373,  373,
			 1014,  373,  373,  373,  373,  373,  373,  373,  373,  373,
			  373,  373,  373,  373,  373,  380,  380,  380,  380,  380,
			  380,  380,  380,  380,  380,  380,  380,  380,  382,  382,
			  382,  382,  382,  382,  382,  382,  382,  382,  382,  382,
			  382,  384,  384,  384,  384,  384,  384,  384,  384,  384,
			  384,  384,  384,  384,  278,  278, 1014,  278,  278,  278,

			 1014,  278,  278,  278,  278,  278,  278,  278,  278,  278,
			  278,  278,  278,  278,  278,  278,  278,  279,  279, 1014,
			  279,  279,  279, 1014,  279,  279,  279,  279,  279,  279,
			  279,  279,  279,  279,  279,  279,  279,  279,  279,  279,
			  924,  924,  924,  924,  924,  924,  924,  924, 1014,  924,
			  924,  924,  924,  924,  924,  924,  924,  924,  924,  924,
			  924,  924,  924,    5, 1014, 1014, 1014, 1014, 1014, 1014,
			 1014, 1014, 1014, 1014, 1014, 1014, 1014, 1014, 1014, 1014,
			 1014, 1014, 1014, 1014, 1014, 1014, 1014, 1014, 1014, 1014,
			 1014, 1014, 1014, 1014, 1014, 1014, 1014, 1014, 1014, 1014,

			 1014, 1014, 1014, 1014, 1014, 1014, 1014, 1014, 1014, 1014,
			 1014, 1014, 1014, 1014, 1014, 1014, 1014, 1014, 1014, 1014,
			 1014, 1014, 1014, 1014, 1014, 1014, 1014, 1014, 1014, 1014,
			 1014, 1014, 1014, 1014, 1014, 1014, 1014, 1014, 1014, 1014,
			 1014, 1014, 1014, 1014, 1014, 1014, 1014, 1014, 1014, 1014,
			 1014, 1014, 1014, 1014, 1014, 1014, 1014, 1014, 1014, 1014,
			 1014, 1014, 1014, yy_Dummy>>,
			1, 563, 9000)
		end

	yy_chk_template: SPECIAL [INTEGER] is
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make (0, 9562)
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

			    3,    3,    3,    3,   22,   23, 1003,   23,   23,   23,
			   23,    4,    4,    4,    4,   22,   24,   26,  145,   26,
			   26,   26,   26,  974,   24,   30,   30,  150,   12,  840,
			   26,   12,   32,   32,  967,   15,  378,   16,   15,   16,
			   16,   79,   79,   79,   25,   16,   25,   25,   25,   25,
			   81,   81,   81,   82,   82,  840,    3,   25,   25,   26,
			  145,  840,   26,   83,   83,   83,  604,    4,   27,  150,
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
			   34,   34,   34,   34,   34,   35,  344,   35,  139,  920,
			   35,  280,   35,  255,  255,  255,   40,   35,  261,  256,
			   40,   57,   57,   57,   57,   57,   57,   57,  173,  142,
			  142,  142,  142,   40,  139,  920,  168,   35,  127,   35,
			  139,  920,   35,  142,   35,  257,  257,  257,   40,   35,
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
			   92,   99,    0,    0,   99,   99,   99,   99,   99,   99,

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
			  148,  148,  148,  148,  148,  148,  159,  711,  711,  711,
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
			  192,  189,    0,  189,  192,  190,  712,  712,  712,  190,
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
			  204,  204,  204,  206,  204,  207,    0,  207,  209,  207,

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
			  250,  250,  250,  250,  250,  737,  737,  737,  737,    0,
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
			    0,  281,  281,  281,  281,  281,  281,  281,  738,  738,
			  738,  738,    0,    0,  282,  282,  282,  282,  282,  282,
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
			1, 3000, 0)
		end

	yy_chk_template_2 (an_array: ARRAY [INTEGER]) is
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
			  390,  740,  740,  740,  740,  316,    0,    0,  316,    0,

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

			  319,  319,  319,    0,  324,  386,  322,  324,  742,  742,
			  742,  742,  327,    0,  320,  327,    0,    0,    0,  320,
			  320,  320,  320,  320,  320,  320,  321,  325,    0,    0,
			  325,  321,  321,  321,  321,  321,  321,  321,  322,  326,
			    0,  323,  326,  322,  322,  322,  322,  322,  322,  322,
			    0,  328,    0,  324,  328,    0,    0,    0,  329,    0,
			    0,  329,    0,    0,    0,  330,    0,    0,  330,  744,
			  744,  744,  744,  323,    0,    0,  325,  333,  323,  323,
			  323,  323,  323,  323,  323,  324,  331,    0,  326,  331,
			  324,  324,  324,  324,  324,  324,  324,  335,  327,  327,

			  327,  327,  327,  327,  327,    0,  332,    0,  325,  332,
			  325,  325,  325,  325,  325,  325,  325,  325,  325,  325,
			  326,  336,  326,  326,  326,  326,  326,  326,  326,  326,
			  326,  326,  337,  839,  839,  839,  839,  328,  328,  328,
			  328,  328,  328,  328,  329,  329,  329,  329,  329,  329,
			  329,  330,  330,  330,  330,  330,  330,  330,  338,  333,
			  333,  333,  333,  333,  333,  333,    0,    0,  339,  331,
			  331,  331,  331,  331,  331,  331,  331,  331,  331,  335,
			  335,  335,  335,  335,  335,  335,  340,    0,    0,  332,
			  332,  332,  332,  332,  332,  332,  332,  332,  332,  341,

			    0,    0,  336,  336,  336,  336,  336,  336,  336,  336,
			  342,  337,  337,  337,  337,  337,  337,  337,  337,  337,
			  337,  343,  596,  596,  596,  596,    0,    0,  345,  843,
			  843,  843,  843,    0,    0,  346,    0,  338,  338,    0,
			  338,  338,  338,  338,  338,  338,  338,  339,  339,  339,
			  339,  339,  339,  339,  339,  339,  339,  348,  844,  844,
			  844,  844,  596,    0,  349,  340,  340,  340,  340,  340,
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
			    0,  837,  598,  837,    0,  357,  837,  837,  837,  837,
			    0,  350,  350,  350,  350,  350,  350,  350,  358,  605,
			    0,  605,  605,  605,  605,  359,  846,  846,  846,  846,

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
			  516,  516,  516,  516,  516,  516,  516,  516,  913,  913,

			  913,  913,  367,  367,  367,  367,  367,  367,  367,  367,
			  367,  367,  914,  914,  914,  914,    0,  368,  368,  368,
			  368,  368,  368,  368,  368,  368,  368,  736,  736,  736,
			  736,    0,  369,  369,  369,  369,  369,  369,  369,  369,
			  369,  369,  383,  383,  383,  383,    0,  391,  915,  915,
			  915,  915,  383,  383,  383,  383,  383,  383,  391,  393,
			  391,  395,    0,  393,  403,  395,    0,  736,  403,  395,
			  391,  919,  919,  919,  919,    0,  393,    0,  395,  391,
			    0,  403,  383,    0,  383,  383,  383,  383,  383,  383,
			  391,  393,  391,  395,  407,  393,  403,  395,  407,    0,

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
			  450,    0,    0,  451,  448,  449,  448,    0,  454,  449,
			  454,  450,  451,  450,  453,  452,  448,  452,  453,  452,
			  454,    0,  449,  451,    0,  451,    0,  452,  450,    0,
			    0,  453,  450,    0,    0,  451,    0,  457,    0,    0,
			  454,  457,  454,  450,  455,  450,  453,  452,  455,  452,

			  453,  452,  454,  456,  457,  456,  456,    0,  455,  452,
			  458,  455,  458,  453,  459,  456,    0,    0,  459,  457,
			  460,    0,  458,  457,    0,    0,  455,  460,  463,  460,
			  455,  459,  463,    0,    0,  456,  457,  456,  456,  460,
			  455,    0,  458,  455,  458,  463,  459,  456,    0,    0,
			  459,  461,  460,  461,  458,  461,  461,    0,    0,  460,
			  463,  460,  464,  459,  463,    0,  464,    0,  461,  462,
			    0,  460,  462,  921,  921,  921,  921,  463,  462,  464,
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
			    0,  474,  473,  470,  473,  470,  922,  922,  922,  922,
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
			  923,  923,  923,  923,  495,    0,  505,    0,  495,  497,
			    0,    0,  518,  497,    0,    0,    0,  500,  500,  500,
			  500,  500,  500,  500,  519,    0,  497,  517,  517,  517,
			  517,  517,  517,  517,  517,  517,  517,  520,    0,    0,
			  501,  501,  501,  501,  501,  501,  501,  521,    0,    0,
			    0,  502,  502,  502,  502,  502,  502,  502,  523,  543,

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
			  847,  530,  847,    0,  530,  847,  847,  847,  847,    0,
			  525,  525,  525,  525,  525,  525,  525,  525,  525,  525,
			  531,    0,    0,  531,  606,  531,    0,    0,  531,    0,
			  526,  526,    0,  526,  526,  526,  526,  526,  526,  526,
			  741,  741,  741,  741,  527,  527,  527,  527,  527,  527,
			  527,  527,  527,  527,  528,  528,  528,  528,  528,  528,
			  528,  528,  528,  528,  529,    0,    0,  529,  529,  529,
			  529,  529,  529,  529,  532,    0,  558,  532,    0,  532,
			  741,    0,  532,  968,  968,  968,  968,  530,  530,  530,

			  530,  530,  530,  530,  533,    0,    0,  533,    0,  533,
			    0,  536,  533,    0,  536,    0,  536,    0,    0,  536,
			    0,  531,  531,  531,  531,  531,  531,  531,  534,    0,
			    0,  534,    0,  534,    0,    0,  534,    0,  535,    0,
			    0,  535,    0,  535,    0,  537,  535,    0,  537,    0,
			  537,    0,  538,  537,    0,  538,    0,  538,    0,  539,
			  538,    0,  539,    0,  539,    0,    0,  539,  558,  558,
			  558,  558,  558,  558,  558,  532,  532,  532,  532,  532,
			  532,  532,  540,    0,    0,  540,  916,  540,  916,    0,
			  540,  916,  916,  916,  916,  533,  533,  533,  533,  533,

			  533,  533,  536,  536,  536,  536,  536,  536,  536,  544,
			    0,    0,  544,    0,    0,    0,  534,  534,  534,  534,
			  534,  534,  534,  534,  534,  534,  535,  535,  535,  535,
			  535,  535,  535,  535,  535,  535,  537,  537,  537,  537,
			  537,  537,  537,  538,  538,  538,  538,  538,  538,  538,
			  539,  539,  539,  539,  539,  539,  539,  541,    0,    0,
			  541,  917,  541,  917,    0,  541,  917,  917,  917,  917,
			  540,  540,  540,  540,  540,  540,  540,  540,  540,  540,
			  545,    0,    0,  545,    0,    0,  743,  743,  743,  743,
			  546,    0,    0,  546,    0,  544,  544,  544,  544,  544,

			  544,  544,  546,  546,  546,  546,  546,  547,  607,    0,
			  547,    0,  607,    0,  548,    0,    0,  548,    0,    0,
			    0,  549,    0,    0,  549,  607,  743,  607,  550,  616,
			  616,  550,  616,  547,    0,  551,    0,    0,  551,    0,
			  607,    0,  616,    0,  607,  541,  541,  541,  541,  541,
			  541,  541,  541,  541,  541,  552,    0,  607,  552,  607,
			    0,  616,  616,    0,  616,    0,  545,  545,  545,  545,
			  545,  545,  545,    0,  616,    0,  546,  546,  546,  546,
			  546,  546,  546,  553,    0,    0,  553,  746,    0,  746,
			  746,  746,  746,  547,  547,  547,  547,  547,  547,  547,

			  548,  548,  548,  548,  548,  548,  548,  549,  549,  549,
			  549,  549,  549,  549,  550,  550,  550,  550,  550,  550,
			  550,  551,  551,  551,  551,  551,  551,  551,  554,  746,
			    0,  554,  970,  970,  970,  970,    0,    0,  552,  552,
			  552,  552,  552,  552,  552,  552,  552,  552,  555,    0,
			    0,  555,    0,    0,    0,  556,    0,    0,  556,    0,
			    0,    0,  557,    0,    0,  557,  553,  553,  553,  553,
			  553,  553,  553,  553,  553,  553,  559,  554,    0,  635,
			    0,  635,  597,  560,  597,  597,  597,  597,    0,    0,
			  561,  635,    0,    0,    0,  597,  926,  555,  926,    0,

			  562,  926,  926,  926,  926,  971,  971,  971,  971,  554,
			  563,  635,    0,  635,  554,  554,  554,  554,  554,  554,
			  554,    0,    0,  635,  597,    0,    0,  597,    0,  555,
			    0,    0,    0,  586,  555,  555,  555,  555,  555,  555,
			  555,  556,  556,  556,  556,  556,  556,  556,  557,  557,
			  557,  557,  557,  557,  557,  587,    0,    0,  559,  559,
			  559,  559,  559,  559,  559,  560,  560,  560,  560,  560,
			  560,  560,  561,  561,  561,  561,  561,  561,  561,  562,
			  562,  562,  562,  562,  562,  562,  562,  562,  562,  563,
			  563,  563,  563,  563,  563,  563,  563,  563,  563,  569,

			  972,  972,  972,  972,    0,    0,    0,  569,  569,  569,
			  569,  569,  586,  586,  586,  586,  586,  586,  586,  586,
			  586,  586,  976,  976,  976,  976,    0,  609,    0,    0,
			    0,  609,    0,    0,  587,  587,  587,  587,  587,  587,
			  587,  587,  587,  587,  609,  609,    0,  735,  735,  735,
			  735, 1004, 1004, 1004, 1004,    0,  608,    0,  608,  609,
			  610,  735,  610,  609,  608,    0,    0,  610,  608,    0,
			    0,    0,  610,    0,  611,    0,  609,  609,  611,    0,
			  611,  569,  569,  569,  569,  569,  569,  569,  608,    0,
			  608,  611,  610,  735,  610,    0,  608,  615,  612,  610,

			  608,  615,    0,  612,  610,  612,  611,  615,    0,  617,
			  611,    0,  611,  617,  615,  612,    0,  619,    0,    0,
			    0,  619,    0,  611,    0,    0,  617,  617,    0,  615,
			  612,    0,    0,  615,  619,  612,  618,  612,  618,  615,
			    0,  617,    0,  618,    0,  617,  615,  612,  618,  619,
			    0,    0,  621,  619,  620,    0,  621,    0,  617,  617,
			    0,  620,    0,  620,    0,    0,  619,    0,  618,  621,
			  618,  621,    0,  620,  623,  618,    0,  622,  623,  622,
			  618,    0,    0,  624,  621,  622,  620,    0,  621,  622,
			  624,  623,  624,  620,    0,  620,  838,  838,  838,  838,

			    0,  621,  624,  621,    0,  620,  623,    0,  625,  622,
			  623,  622,  625,  626,  625,  624,    0,  622,  626,    0,
			  626,  622,  624,  623,  624,  625,  628,    0,  628,    0,
			  626,  627,  628,    0,  624,  627,  838,    0,  628,  629,
			  625,    0,    0,  629,  625,  626,  625,  629,  627,  631,
			  626,    0,  626,  631,    0,    0,  629,  625,  628,    0,
			  628,    0,  626,  627,  628,    0,  631,  627,    0,  630,
			  628,  629,  630,  633,  630,  629,    0,  633,  634,  629,
			  627,  631,  634,    0,  630,  631,  633,  632,  629,  632,
			  633,    0,    0,  632,    0,  634,    0,    0,  631,  632, yy_Dummy>>,
			1, 3000, 3000)
		end

	yy_chk_template_3 (an_array: ARRAY [INTEGER]) is
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
			  662,  664,  661,  667,    0,  665,  661,  667,    0,  666,
			  663,  665,    0,  661,  663,    0,  668,    0,  668,  661,
			  667,  664,    0,  664,    0,    0,  665,  663,  668,  666,
			  665,  666,  670,  664,  669,  667,  670,  665,  669,  667,

			  670,  666,  672,  665,  671,  672,  671,  672,  668,  670,
			  668,  669,  667,  671,  669,    0,  671,  672,  673,    0,
			  668,    0,  673,  673,  670,    0,  669,    0,  670,    0,
			  669,    0,  670,    0,  672,  673,  671,  672,  671,  672,
			    0,  670,    0,  669,    0,  671,  669,    0,  671,  672,
			  673,  674,    0,    0,  673,  673,  675,  674,    0,  674,
			  675,    0,  676,    0,  676,    0,    0,  673,  676,  674,
			    0,    0,    0,  675,  676,  678,  678,  678,  677,    0,
			    0,    0,  677,  674,    0,    0,    0,  678,  675,  674,
			  677,  674,  675,    0,  676,  677,  676,    0,    0,    0,

			  676,  674,    0,    0,    0,  675,  676,  678,  678,  678,
			  677,  681,  679,  682,  677,  681,  679,  682,  680,  678,
			  679,  680,  677,  680,  682,    0,    0,  677,  681,  679,
			  682,  681,    0,  680,    0,    0,    0,    0,    0,  684,
			    0,  684,    0,  681,  679,  682,    0,  681,  679,  682,
			  680,  684,  679,  680,    0,  680,  682,  683,    0,  683,
			  681,  679,  682,  681,  685,  680,  683,    0,  685,  683,
			    0,  684,  686,  684,  686,  687,  689,  687,    0,  687,
			  689,  685,  691,  684,  686,  686,  691,    0,  685,  683,
			    0,  683,  687,  689,  688,    0,  685,  691,  683,  691,

			  685,  683,    0,  688,  686,  688,  686,  687,  689,  687,
			    0,  687,  689,  685,  691,  688,  686,  686,  691,    0,
			  685,  690,    0,  690,  687,  689,  688,  690,  692,  691,
			  692,  691,  692,  690,  693,  688,    0,  688,  693,  695,
			  692,    0,  694,  695,  694,    0,  696,  688,  696,    0,
			    0,  693,    0,  690,  694,  690,  695,    0,  696,  690,
			  692,  698,  692,    0,  692,  690,  693,  698,    0,  698,
			  693,  695,  692,    0,  694,  695,  694,  697,  696,  698,
			  696,  697,  697,  693,    0,  699,  694,    0,  695,  699,
			  696,    0,    0,  698,  697,  700,    0,  700,  702,  698,

			  702,  698,  699,    0,  700,  699,    0,  700,  701,  697,
			  702,  698,  701,  697,  697,    0,  703,  699,    0,  701,
			  703,  699,    0,  709,    0,  701,  697,  700,    0,  700,
			  702,  710,  702,  703,  699,  713,  700,  699,    0,  700,
			  701,  705,  702,  704,  701,  705,  707,  706,  703,  706,
			  707,  701,  703,  714,  704,    0,  704,  701,  705,  706,
			  708,  715,  708,  707,    0,  703,  704,    0,  716,    0,
			    0,    0,  708,  705,    0,  704,    0,  705,  707,  706,
			  717,  706,  707,    0,    0,    0,  704,    0,  704,    0,
			  705,  706,  708,  718,  708,  707,    0,    0,  704,    0,

			  719,    0,    0,    0,  708,  709,  709,  709,  709,  709,
			  709,  709,  720,  710,  710,  710,  710,  710,  710,  710,
			  721,  713,  713,  713,  713,  713,  713,  713,  722,    0,
			    0,    0,    0,  842,  842,  842,  842,    0,  723,  714,
			  714,  714,  714,  714,  714,  714,    0,  715,  715,  715,
			  715,  715,  715,  715,  716,  716,  716,  716,  716,  716,
			  716,  724,    0,  717,  717,  717,  717,  717,  717,  717,
			  717,  717,  717,  842,    0,    0,  718,  718,  718,  718,
			  718,  718,  718,  718,  718,  718,  719,  719,  719,  719,
			  719,  719,  719,  845,  845,  845,  845,    0,  720,  720,

			  720,  720,  720,  720,  720,    0,  721,  721,  721,  721,
			  721,  721,  721,    0,  722,  722,  722,  722,  722,  722,
			  722,  723,  723,  723,  723,  723,  723,  723,  723,  723,
			  723,  725,  732,  845,  725,    0,  725,    0,    0,  725,
			    0,    0,    0,  831,  724,  724,  724,  724,  724,  724,
			  724,  724,  724,  724,  726,  733,    0,  726,    0,  726,
			    0,  727,  726,    0,  727,    0,  727,    0,  728,  727,
			    0,  728,    0,  728,    0,    0,  728,  748,    0,  748,
			  729,    0,    0,  729,    0,    0,    0,  730,    0,  748,
			  730,    0,  729,  729,  729,  729,  729,  731,    0,    0,

			  731,    0,    0,    0,  918,  918,  918,  918,  734,  748,
			    0,  748,    0,    0,  732,  732,  732,  732,  732,  732,
			  732,  748,  725,  725,  725,  725,  725,  725,  725,  831,
			  831,  831,  831,  831,  831,  831,    0,  733,  733,  733,
			  733,  733,  733,  733,  918,  726,  726,  726,  726,  726,
			  726,  726,  727,  727,  727,  727,  727,  727,  727,  728,
			  728,  728,  728,  728,  728,  728,  729,  729,  729,  729,
			  729,  729,  729,  730,  730,  730,  730,  730,  730,  730,
			    0,    0,    0,  731,  731,  731,  731,  731,  731,  731,
			  734,  734,  734,  734,  734,  734,  734,  739,  739,  739,

			  739,  745,  745,  745,  745,    0,  747,  750,  749,  750,
			  747,  739,  749,  751,    0,  745,  752,  751,  752,  750,
			  754,    0,  754,  747,    0,  749,  751,    0,  752,  753,
			  751,    0,  754,  753,    0,    0,    0,  739,  747,  750,
			  749,  750,  747,  739,  749,  751,  753,  745,  752,  751,
			  752,  750,  754,    0,  754,  747,    0,  749,  751,  755,
			  752,  753,  751,  755,  754,  753,  757,  756,    0,  756,
			  757,    0,    0,    0,    0,  758,  755,  758,  753,  756,
			  759,  758,    0,  757,  759,  760,  763,  758,  759,  760,
			  763,  755,  760,    0,  760,  755,    0,  759,  757,  756,

			    0,  756,  757,  763,  760,    0,    0,  758,  755,  758,
			  761,  756,  759,  758,  761,  757,  759,  760,  763,  758,
			  759,  760,  763,  761,  760,    0,  760,  761,  762,  759,
			  762,  764,    0,  764,  765,  763,  760,    0,  765,  768,
			  762,    0,  761,  764,  767,  768,  761,  768,  767,  767,
			    0,  765,  766,    0,  766,  761,    0,  768,  766,  761,
			  762,  767,  762,  764,  766,  764,  765,    0,    0,    0,
			  765,  768,  762,    0,  769,  764,  767,  768,  769,  768,
			  767,  767,    0,  765,  766,  770,  766,    0,    0,  768,
			  766,  769,  770,  767,  770,  771,  766,    0,  771,  771,

			    0,  772,    0,  773,  770,    0,  769,  773,    0,  772,
			  769,  772,  771,    0,    0,  775,    0,  770,    0,  775,
			  773,  772,  773,  769,  770,    0,  770,  771,  775,    0,
			  771,  771,  775,  772,    0,  773,  770,    0,  774,  773,
			  774,  772,    0,  772,  771,  777,  774,  775,    0,  777,
			  774,  775,  773,  772,  773,  776,  778,  776,  778,  779,
			  775,    0,  777,  779,  775,    0,    0,  776,  778,    0,
			  774,    0,  774,  780,    0,  780,  779,  777,  774,  780,
			  781,  777,  774,    0,  781,  780,    0,  776,  778,  776,
			  778,  779,  783,  781,  777,  779,  783,  781,    0,  776,

			  778,  782,    0,  782,    0,  780,    0,  780,  779,  783,
			    0,  780,  781,  782,  785,    0,  781,  780,  785,    0,
			    0,    0,  785,  784,  783,  781,    0,    0,  783,  781,
			  784,  785,  784,  782,  786,  782,  787,  786,    0,  786,
			  787,  783,  784,    0,  789,  782,  785,    0,  789,  786,
			  785,    0,  789,  787,  785,  784,    0,    0,  788,    0,
			  788,  789,  784,  785,  784,    0,  786,    0,  787,  786,
			  788,  786,  787,    0,  784,    0,  789,    0,    0,    0,
			  789,  786,    0,  790,  789,  787,  790,  791,  790,  791,
			  788,  791,  788,  789,    0,  793,  792,    0,  790,  793,

			    0,    0,  788,  793,  791,  792,    0,  792,    0,    0,
			    0,  794,  793,    0,  794,  790,  794,  792,  790,  791,
			  790,  791,  796,  791,  796,  795,  794,  793,  792,  795,
			  790,  793,    0,    0,  796,  793,  791,  792,    0,  792,
			    0,    0,  795,  794,  793,    0,  794,  797,  794,  792,
			    0,  797,    0,  798,  796,    0,  796,  795,  794,  799,
			  798,  795,  798,  799,  797,  800,  796,  800,  802,    0,
			  802,  800,  798,    0,  795,    0,  799,  800,    0,  797,
			  802,    0,    0,  797,  801,  798,    0,    0,  801,    0,
			    0,  799,  798,    0,  798,  799,  797,  800,    0,  800,

			  802,  801,  802,  800,  798,    0,  803,  801,  799,  800,
			  803,  805,  802,  807,  803,  805,  801,  807,  806,  804,
			  801,    0,  804,  803,  804,  806,    0,  806,  805,  816,
			  807,  816,    0,  801,  804,    0,  809,  806,  803,  801,
			  809,  816,  803,  805,    0,  807,  803,  805,    0,  807,
			  806,  804,    0,  809,  804,  803,  804,  806,  808,  806,
			  805,  816,  807,  816,    0,  808,  804,  808,  809,  806,
			    0,  811,  809,  816,  810,  811,  810,  808,    0,  813,
			  810,    0,  812,  813,    0,  809,  810,    0,  811,  812,
			  808,  812,  814,    0,  814,    0,  813,  808,  813,  808,

			  814,  812,    0,  811,  814,    0,  810,  811,  810,  808,
			    0,  813,  810,    0,  812,  813,    0,    0,  810,    0,
			  811,  812,    0,  812,  814,  815,  814,  817,  813,  815,
			  813,  817,  814,  812,  819,  818,  814,  818,  819,  820,
			    0,  821,  815,  818,  817,  821,  817,  818,    0,    0,
			  820,  819,  820,  822,    0,  822,    0,  815,  821,  817,
			    0,  815,  820,  817,  823,  822,  819,  818,  823,  818,
			  819,  820,  823,  821,  815,  818,  817,  821,  817,  818,
			    0,  823,  820,  819,  820,  822,  824,  822,  825,  824,
			  821,  824,  825,    0,  820,    0,  823,  822,  827,  832,

			  823,  824,  827,  826,  823,  825,  833,  828,    0,  828,
			  826,    0,  826,  823,  830,  827,  830,  834,  824,  828,
			  825,  824,  826,  824,  825,    0,  830,    0,  835,    0,
			  827,  835,  829,  824,  827,  826,  829,  825,    0,  828,
			  835,  828,  826,    0,  826,  829,  830,  827,  830,  829,
			    0,  828,    0,    0,  826,  973,    0,  973,  830,    0,
			  973,  973,  973,  973,  829,    0,    0,    0,  829,    0,
			  969,  969,  969,  969,    0,    0,    0,  829,    0,    0,
			    0,  829,    0,    0,    0,  832,  832,  832,  832,  832,
			  832,  832,  833,  833,  833,  833,  833,  833,  833,  841,

			  841,  841,  841,  834,  834,  834,  834,  834,  834,  834,
			  969,    0,    0,  841,  835,  835,  835,  835,  835,  835,
			  835,  848,  848,  848,  848,  849,  850,  851,  850,  849,
			    0,  851,  853,    0,    0,  848,  853,    0,  850,  852,
			    0,  852,  849,    0,  851,  841,  851,  852,  854,  853,
			    0,  852,  854,    0,  855,    0,  855,  849,  850,  851,
			  850,  849,  854,  851,  853,  854,  855,  848,  853,    0,
			  850,  852,    0,  852,  849,    0,  851,    0,  851,  852,
			  854,  853,    0,  852,  854,    0,  855,  856,  855,  856,
			  856,  857,    0,    0,  854,  857,    0,  854,  855,  856,

			  859,  858,    0,  858,  859,  860,    0,    0,  857,  858,
			  857,  861,  860,  858,  860,  861,    0,  859,  862,  856,
			  862,  856,  856,  857,  860,    0,    0,  857,  861,    0,
			  862,  856,  859,  858,  863,  858,  859,  860,  863,    0,
			  857,  858,  857,  861,  860,  858,  860,  861,    0,  859,
			  862,  863,  862,  864,  865,  864,  860,  867,  865,    0,
			  861,  867,  862,  869,    0,  864,  863,  869,    0,  866,
			  863,  865,    0,    0,  867,    0,  866,    0,  866,  868,
			  869,  868,    0,  863,    0,  864,  865,  864,  866,  867,
			  865,  868,  871,  867,  870,  869,  871,  864,    0,  869,

			    0,  866,    0,  865,    0,  870,  867,  870,  866,  871,
			  866,  868,  869,  868,  873,    0,    0,  870,  873,    0,
			  866,    0,    0,  868,  871,  872,  870,    0,  871,    0,
			    0,  873,  872,  874,  872,  874,  875,  870,    0,  870,
			  875,  871,    0,  877,  872,  874,  873,  877,    0,  870,
			  873,    0,    0,  875,  875,    0,  877,  872,    0,    0,
			  877,    0,    0,  873,  872,  874,  872,  874,  875,    0,
			  879,  876,  875,  876,  879,  877,  872,  874,  876,  877,
			    0,    0,  878,  876,  878,  875,  875,  879,  877,  879,
			    0,    0,  877,    0,  878,    0,  880,    0,  880,  882,

			    0,  882,  879,  876,  880,  876,  879,  882,  880,    0,
			  876,  882,    0,    0,  878,  876,  878,    0,  881,  879,
			    0,  879,  881,    0,    0,  883,  878,    0,  880,  883,
			  880,  882,    0,  882,  885,  881,  880,  881,  885,  882,
			  880,    0,  883,  882,    0,  884,    0,  886,    0,  886,
			  881,  885,    0,  885,  881,  886,  884,  883,  884,  886,
			    0,  883,    0,    0,    0,    0,  885,  881,  884,  881,
			  885,    0,    0,    0,  883,    0,  887,  884,    0,  886,
			  887,  886,  889,  885,    0,  885,  889,  886,  884,    0,
			  884,  886,  891,  887,  887,  888,  891,  888,    0,  889,

			  884,  890,  888,  890,  892,  891,  892,  888,  887,  891,
			    0,    0,  887,  890,  889,    0,  892,    0,  889,    0,
			  894,    0,  894,    0,  891,  887,  887,  888,  891,  888,
			    0,  889,  894,  890,  888,  890,  892,  891,  892,  888,
			  893,  891,  895,  897,  893,  890,  895,  897,  892,  896,
			    0,  896,  894,  893,  894,    0,    0,  893,  898,  895,
			  897,  896,    0,    0,  894,  898,    0,  898,  900,  899,
			  900,    0,  893,  899,  895,  897,  893,  898,  895,  897,
			  900,  896,    0,  896,    0,  893,  899,    0,    0,  893,
			  898,  895,  897,  896,  901,    0,    0,  898,  901,  898,

			  900,  899,  900,  903,  902,  899,  902,  903,    0,  898,
			  905,  901,  900,  904,  905,  904,  902,    0,  899,  908,
			  903,  908,    0,    0,  907,  904,  901,  905,  907,  905,
			  901,  908,  906,    0,  906,  903,  902,  907,  902,  903,
			  906,  907,  905,  901,  906,  904,  905,  904,  902,    0,
			  909,  908,  903,  908,  909,    0,  907,  904,  911,  905,
			  907,  905,  911,  908,  906,    0,  906,  909,  910,  907,
			  910,    0,  906,  907,    0,  911,  906,  911,    0,  912,
			  910,  912,  909,    0,  927,    0,  909,  912,  927,    0,
			  911,  912,    0,  931,  911,    0,  928,  931,  928,  909,

			  910,  927,  910,  925,  925,  925,  925,  911,  928,  911,
			  931,  912,  910,  912,  929,    0,  927,  925,  929,  912,
			  927,    0,  930,  912,  930,  931,    0,  929,  928,  931,
			  928,  929,    0,  927,  930,  932,    0,  932,    0,    0,
			  928,  933,  931,  925,  933,  933,  929,  932,    0,  925,
			  929,    0,  934,    0,  930,    0,  930,    0,  933,  929,
			  934,  935,  934,  929,  935,  935,  930,  932,    0,  932,
			  937,    0,  934,  933,  937,  936,  933,  933,  935,  932,
			    0,  937,    0,  936,  934,  936,  938,  937,  938,  940,
			  933,  940,  934,  935,  934,  936,  935,  935,  938,  939,

			    0,  940,  937,  939,  934,  941,  937,  936,    0,  941,
			  935,    0,  942,  937,  942,  936,  939,  936,  938,  937,
			  938,  940,  941,  940,  942,    0,    0,  936,  943,    0,
			  938,  939,  943,  940,  943,  939,  945,  941,    0,    0,
			  945,  941,  944,    0,  942,  943,  942,  944,  939,  944,
			  946,    0,  946,  945,  941,  948,  942,  948,    0,  944,
			  943,  947,  946,    0,  943,  947,  943,  948,  945,    0,
			    0,    0,  945,    0,  944,    0,    0,  943,  947,  944,
			    0,  944,  946,    0,  946,  945,  951,  948,  949,  948,
			  951,  944,  949,  947,  946,  952,  950,  947,  950,  948,

			    0,  949,  952,  951,  952,  949,    0,    0,  950,  953,
			  947,    0,  955,  953,  952,    0,  955,    0,  951,    0,
			  949,    0,  951,  953,  949,    0,  953,  952,  950,  955,
			  950,    0,    0,  949,  952,  951,  952,  949,    0,    0,
			  950,  953,    0,    0,  955,  953,  952,  954,  955,  954,
			  954,    0,  957,  956,  957,  953,  957,  958,  953,  954,
			  956,  955,  956,  959,    0,    0,  958,  959,  958,  957,
			  961,  960,  956,  960,  961,    0,    0,    0,  958,  954,
			  959,  954,  954,  960,  957,  956,  957,  961,  957,  958,
			    0,  954,  956,    0,  956,  959,    0,    0,  958,  959,

			  958,  957,  961,  960,  956,  960,  961,  962,    0,    0,
			  958,    0,  959,  963,  962,  960,  962,  963,  964,  961,
			  966,    0,  966,    0,  965,  964,  962,  964,  965,    0,
			  963,    0,  966,    0,    0,    0,    0,  964,    0,  962,
			    0,  965,    0,    0,    0,  963,  962,    0,  962,  963,
			  964,  979,  966,  979,  966,    0,  965,  964,  962,  964,
			  965,    0,  963,  979,  966,  975,  975,  975,  975,  964,
			    0,    0,    0,  965,  977,  977,  977,  977,    0,  975,
			  978,    0,    0,  979,  978,  979,  980,  981,    0,  981,
			  980,    0,  982,    0,    0,  979,  982,  978,  983,  981,

			  983,    0,    0,  980,    0,  975,    0,    0,    0,  982,
			  983,  975,  978,  985,  977,  985,  978,    0,  980,  981,
			    0,  981,  980,  984,  982,  985,    0,  984,  982,  978,
			  983,  981,  983,  986,  987,  980,  987,  986,    0,  988,
			  984,  982,  983,  988,  990,  985,  987,  985,  990,    0,
			  986,  991,  989,  991,  989,  984,  988,  985,  988,  984,
			  989,  990,    0,  991,  989,  986,  987,    0,  987,  986,
			  992,  988,  984,    0,  992,  988,  990,    0,  987,    0,
			  990,    0,  986,  991,  989,  991,  989,  992,  988,  995,
			  988,  995,  989,  990,  994,  991,  989,  993,  994,  993,

			  996,  995,  992,  993,  996,  997,  992,    0,  999,  993,
			  999,  994,  997, 1001,  997, 1001,    0,  996,    0,  992,
			  999,  995,    0,  995,  997, 1001,  994,    0,    0,  993,
			  994,  993,  996,  995,  998,  993,  996,  997,  998,    0,
			  999,  993,  999,  994,  997, 1001,  997, 1001,    0,  996,
			 1000,  998,  999,    0, 1000,    0,  997, 1001, 1002, 1002,
			 1002, 1002, 1005, 1005, 1005, 1005,  998, 1000,    0,    0,
			  998, 1006, 1006, 1006, 1006, 1008, 1007, 1008,    0,    0,
			 1007,    0, 1000,  998, 1009,    0, 1000, 1008, 1009,    0,
			    0,    0, 1010, 1007, 1010,    0, 1011,    0, 1002, 1000, yy_Dummy>>,
			1, 3000, 6000)
		end

	yy_chk_template_4 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			 1011, 1009, 1005, 1012, 1010, 1012,    0, 1008, 1007, 1008,
			    0, 1006, 1007, 1011,    0, 1012, 1009,    0,    0, 1008,
			 1009,    0,    0,    0, 1010, 1007, 1010,    0, 1011,    0,
			    0,    0, 1011, 1009,    0, 1012, 1010, 1012, 1013, 1013,
			 1013, 1013,    0,    0,    0, 1011,    0, 1012, 1020, 1020,
			 1020, 1020, 1020, 1020, 1020, 1020, 1020, 1020, 1020, 1020,
			 1020, 1020, 1022, 1022, 1022, 1022, 1022, 1022, 1022, 1022,
			 1022, 1022, 1022, 1022, 1022, 1022,    0,    0, 1013, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,

			 1015, 1015, 1016, 1016,    0, 1016, 1016, 1016, 1016, 1016,
			 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016,
			 1016, 1016, 1016, 1016, 1016, 1017,    0,    0,    0,    0,
			    0,    0, 1017, 1017, 1017, 1017, 1017, 1017, 1017, 1017,
			 1017, 1017, 1017, 1017, 1017, 1017, 1017, 1017, 1018, 1018,
			    0, 1018, 1018, 1018, 1018, 1018, 1018, 1018, 1018, 1018,
			 1018, 1018, 1018, 1018, 1018, 1018, 1018, 1018, 1018, 1018,
			 1018, 1019, 1019,    0, 1019, 1019, 1019, 1019,    0, 1019,
			 1019, 1019, 1019, 1019, 1019, 1019, 1019, 1019, 1019, 1019,
			 1019, 1019, 1019, 1019, 1021, 1021,    0, 1021, 1021, 1021,

			    0,    0, 1021, 1021, 1021, 1021, 1021, 1021, 1021, 1021,
			 1021, 1021, 1021, 1021, 1021, 1021, 1021, 1023,    0,    0,
			 1023,    0, 1023, 1023, 1023, 1023, 1023, 1023, 1023, 1023,
			 1023, 1023, 1023, 1023, 1023, 1023, 1023, 1023, 1023, 1023,
			 1024, 1024,    0, 1024, 1024, 1024, 1024, 1024, 1024, 1024,
			 1024, 1024, 1024, 1024, 1024, 1024, 1024, 1024, 1024, 1024,
			 1024, 1024, 1024, 1025, 1025,    0, 1025, 1025, 1025, 1025,
			 1025, 1025, 1025, 1025, 1025, 1025, 1025, 1025, 1025, 1025,
			 1025, 1025, 1025, 1025, 1025, 1025, 1026, 1026,    0, 1026,
			 1026, 1026, 1026, 1026, 1026, 1026, 1026, 1026, 1026, 1026,

			 1026, 1026, 1026, 1026, 1026, 1026, 1026, 1026, 1026, 1027,
			    0,    0,    0,    0, 1027, 1027, 1027, 1027, 1027, 1027,
			 1027, 1027, 1027, 1027, 1027, 1027, 1027, 1027, 1027, 1027,
			 1027, 1027, 1028, 1028, 1028, 1028, 1028, 1028, 1028, 1028,
			    0, 1028, 1028, 1028, 1028, 1028, 1028, 1028, 1028, 1028,
			 1028, 1028, 1028, 1028, 1028, 1029, 1029, 1029, 1029, 1029,
			 1029, 1029, 1029, 1029, 1029, 1029, 1029, 1029, 1030, 1030,
			 1030, 1030, 1030, 1030, 1030, 1030, 1030, 1030, 1030, 1030,
			 1030, 1031, 1031, 1031, 1031, 1031, 1031, 1031, 1031, 1031,
			 1031, 1031, 1031, 1031, 1032, 1032,    0, 1032, 1032, 1032,

			    0, 1032, 1032, 1032, 1032, 1032, 1032, 1032, 1032, 1032,
			 1032, 1032, 1032, 1032, 1032, 1032, 1032, 1033, 1033,    0,
			 1033, 1033, 1033,    0, 1033, 1033, 1033, 1033, 1033, 1033,
			 1033, 1033, 1033, 1033, 1033, 1033, 1033, 1033, 1033, 1033,
			 1034, 1034, 1034, 1034, 1034, 1034, 1034, 1034,    0, 1034,
			 1034, 1034, 1034, 1034, 1034, 1034, 1034, 1034, 1034, 1034,
			 1034, 1034, 1034, 1014, 1014, 1014, 1014, 1014, 1014, 1014,
			 1014, 1014, 1014, 1014, 1014, 1014, 1014, 1014, 1014, 1014,
			 1014, 1014, 1014, 1014, 1014, 1014, 1014, 1014, 1014, 1014,
			 1014, 1014, 1014, 1014, 1014, 1014, 1014, 1014, 1014, 1014,

			 1014, 1014, 1014, 1014, 1014, 1014, 1014, 1014, 1014, 1014,
			 1014, 1014, 1014, 1014, 1014, 1014, 1014, 1014, 1014, 1014,
			 1014, 1014, 1014, 1014, 1014, 1014, 1014, 1014, 1014, 1014,
			 1014, 1014, 1014, 1014, 1014, 1014, 1014, 1014, 1014, 1014,
			 1014, 1014, 1014, 1014, 1014, 1014, 1014, 1014, 1014, 1014,
			 1014, 1014, 1014, 1014, 1014, 1014, 1014, 1014, 1014, 1014,
			 1014, 1014, 1014, yy_Dummy>>,
			1, 563, 9000)
		end

	yy_base_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,   98,  109,  434, 9463,  426,  424,  421,
			  418,  409,  121,    0, 9463,  128,  135, 9463, 9463, 9463,
			 9463, 9463,   87,   87,   97,  126,   99,  150,  383, 9463,
			   99, 9463,  105,  380,  215,  279,  324,  329,  341,  388,
			  296,  397,  413,  444,  456,  419,  446,  466,  477,  487,
			  507,  518,  527, 9463,  344, 9463, 9463,  238,  571,  529,
			  634,  564,  649,  719,  497,  715,  636,  711,  730,  568,
			  765,  773,  776,  784,  791,  819,  827, 9463, 9463,   51,
			  304,   60,   63,   73,   84,  293,  538,  415,  378,  873,
			  650,  880,  891,  600,  821,  831,  842,  852,  862,  901,

			  378,  375,  365,  359, 9463,  973, 9463, 1066, 1030, 1043,
			 1055, 1112, 1125, 1137, 1170, 1182, 1230,    0, 1077, 1148,
			 1241, 1275, 1285, 1295, 1305, 1334,  923,  337, 1427, 1260,
			 1319, 1394, 1408, 1437, 1450, 1089, 9463, 9463, 9463,  284,
			 9463, 9463,  319,  983,  665,  100,  179,  556, 1530,  989,
			  109, 9463, 9463, 9463, 9463, 9463, 9463,  534, 1525, 1536,
			 1552, 1541, 1246, 1582, 1581, 1596, 1585,   90,  254,   93,
			  122,  150,  181,  248, 1629, 1631, 1643, 1645, 1653, 1652,
			 1655, 1660, 1695, 1686, 1703, 1700, 1720, 1730, 1731, 1748,
			 1763, 1784, 1790, 1812, 1825, 1831, 1847, 1849, 1887, 1850,

			 1889, 1895, 1899, 1907, 1957, 1910, 1940, 1954, 2008, 1957,
			 2018, 2023, 2023, 2060, 2076, 2066, 2082, 2084, 2122, 2130,
			 2125, 2138, 2142, 2129, 2146, 2185, 2238, 2289, 2188, 2190,
			 2189, 2235, 2206, 2249, 2293, 2298, 2351, 2353, 2313, 2363,
			 2362, 2402, 2365, 2405, 2419, 2409, 9463, 1415, 1547, 2408,
			 2425, 2440, 2450, 2462, 2472,  233,  237,  265,  153,  296,
			  468,  238,  500,  558,  627,  645,  684,  688,  812,  961,
			 2480, 2490, 2500, 2510, 2520, 2530, 1194, 1405, 2415, 2543,
			  318, 2628, 2641, 2648, 2016, 2150, 2655, 2664, 2674, 2685,
			 2695, 2705, 2803, 2721, 2819, 2828, 2838, 2848, 2858, 2868,

			 2878, 2810, 2885, 2892, 2899, 2909, 2919, 3012, 3019, 3026,
			 3033, 3040, 3050, 3058, 3068, 3078, 3088, 3181, 3191, 3203,
			 3226, 3238, 3250, 3285, 3297, 3320, 3332, 3305, 3344, 3351,
			 3358, 3379, 3399, 3366, 9463, 3386, 3410, 3421, 3447, 3457,
			 3475, 3488, 3499, 3510,  305, 3517, 3524, 3568, 3546, 3553,
			 3588, 3613, 3620, 3627, 3642, 3649, 3657, 3664, 3677, 3684,
			 3691, 3716, 3723, 3738, 3753, 3780, 3790, 3812, 3827, 3842,
			 3172, 1286, 1003, 9463, 3195, 2869, 3041, 1590,  118,  370,
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
			 4807, 4823, 4838, 4839, 4854, 4869, 4847, 4887, 4853, 9463,

			 4864, 4887, 4898, 4913, 4925, 4935, 1163, 1206, 1255, 1270,
			 1330, 1351, 1359, 1375, 9463, 3761, 3798, 4877, 4945, 4957,
			 4970, 4980, 9463, 4991, 5006, 5030, 5050, 5064, 5074, 5084,
			 5104, 5128, 5182, 5202, 5226, 5236, 5209, 5243, 5250, 5257,
			 5280, 5355, 3768, 4906, 5302, 5373, 5383, 5400, 5407, 5414,
			 5421, 5428, 5448, 5476, 5521, 5541, 5548, 5555, 5175, 5565,
			 5572, 5579, 5589, 5599, 9463, 9463, 9463, 9463, 9463, 5688,
			 9463, 9463, 9463, 9463, 9463, 9463, 9463, 9463, 9463, 9463,
			 9463, 9463, 9463, 9463, 9463, 9463, 5622, 5644, 4130, 1459,
			 1496, 1558, 4319, 3229, 2270, 2447, 3502, 5564, 3612,  392,

			  141, 2280,  128,    0,  106, 3671, 5074, 5378, 5715, 5697,
			 5719, 5744, 5762, 1405, 1447, 5767, 5389, 5779, 5795, 5787,
			 5820, 5822, 5836, 5844, 5849, 5878, 5877, 5901, 5885, 5909,
			 5931, 5919, 5946, 5943, 5948, 5538, 5970, 5973, 5983, 5999,
			 6007, 6004, 6026, 6041, 6047, 6031, 6057, 6055, 6086, 6084,
			 6092, 6113, 6095, 6110, 6111, 6144, 6154, 6153, 6158, 6174,
			 6171, 6200, 6175, 6208, 6208, 6224, 6216, 6233, 6235, 6264,
			 6262, 6263, 6264, 6288, 6316, 6326, 6321, 6348, 6334, 6382,
			 6380, 6381, 6383, 6416, 6398, 6434, 6431, 6445, 6462, 6446,
			 6480, 6452, 6487, 6504, 6501, 6509, 6505, 6547, 6526, 6555,

			 6554, 6578, 6557, 6586, 6613, 6611, 6606, 6616, 6619, 6612,
			 6620, 1477, 1736, 6628, 6646, 6654, 6661, 6673, 6686, 6693,
			 6705, 6713, 6721, 6731, 6754, 6829, 6852, 6859, 6866, 6873,
			 6880, 6890, 6821, 6844, 6897, 5727, 3907, 2505, 2708, 6977,
			 3071, 5130, 3288, 5366, 3349, 6981, 5469, 6976, 6836, 6978,
			 6966, 6983, 6975, 6999, 6979, 7029, 7026, 7036, 7034, 7050,
			 7051, 7080, 7087, 7056, 7090, 7104, 7111, 7114, 7104, 7144,
			 7151, 7165, 7168, 7173, 7197, 7185, 7214, 7215, 7215, 7229,
			 7232, 7250, 7260, 7262, 7289, 7284, 7296, 7306, 7317, 7314,
			 7345, 7357, 7364, 7365, 7373, 7395, 7381, 7417, 7419, 7429,

			 7424, 7454, 7427, 7476, 7481, 7481, 7484, 7483, 7524, 7506,
			 7533, 7541, 7548, 7549, 7551, 7595, 7488, 7597, 7594, 7604,
			 7609, 7611, 7612, 7634, 7648, 7658, 7669, 7668, 7666, 7702,
			 7673, 6836, 7692, 7699, 7710, 7721, 9463, 3656, 5876, 3413,
			   95, 7779, 6713, 3509, 3538, 6773, 3676, 5095, 7801, 7795,
			 7785, 7797, 7798, 7802, 7818, 7813, 7846, 7861, 7860, 7870,
			 7871, 7881, 7877, 7904, 7912, 7924, 7935, 7927, 7938, 7933,
			 7964, 7962, 7991, 7984, 7992, 8006, 8030, 8013, 8041, 8040,
			 8055, 8088, 8058, 8095, 8115, 8104, 8106, 8146, 8154, 8152,
			 8160, 8162, 8163, 8210, 8179, 8212, 8208, 8213, 8224, 8239,

			 8227, 8264, 8263, 8273, 8272, 8280, 8291, 8294, 8278, 8320,
			 8327, 8328, 8338, 3878, 3892, 3928, 5271, 5346, 6884, 3951,
			  285, 4553, 4666, 4920, 9463, 8383, 5581, 8354, 8355, 8384,
			 8381, 8363, 8394, 8411, 8419, 8431, 8442, 8440, 8445, 8469,
			 8448, 8475, 8471, 8498, 8506, 8506, 8509, 8531, 8514, 8558,
			 8555, 8556, 8561, 8579, 8606, 8582, 8619, 8622, 8625, 8633,
			 8630, 8640, 8673, 8683, 8684, 8694, 8679,   74, 5173, 7750,
			 5512, 5585, 5680, 7740,   63, 8745, 5702, 8754, 8750, 8710,
			 8756, 8746, 8762, 8757, 8793, 8772, 8803, 8793, 8809, 8811,
			 8814, 8810, 8840, 8856, 8864, 8848, 8870, 8871, 8904, 8867,

			 8920, 8872, 8938,   46, 5731, 8942, 8951, 8946, 8934, 8954,
			 8951, 8966, 8962, 9018, 9463, 9078, 9101, 9124, 9147, 9170,
			 9039, 9193, 9052, 9216, 9239, 9262, 9285, 9308, 9331, 9345,
			 9358, 9371, 9393, 9416, 9439, yy_Dummy>>)
		end

	yy_def_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0, 1014,    1, 1015, 1015, 1014, 1014, 1014, 1014, 1014,
			 1014, 1014, 1016, 1017, 1014, 1018, 1019, 1014, 1014, 1014,
			 1014, 1014, 1014, 1014, 1014, 1020, 1020, 1020, 1014, 1014,
			 1014, 1014, 1014, 1014, 1014,   34,   34,   36,   34,   34,
			   39,   34,   39,   39,   39,   39,   39,   39,   39,   39,
			   39,   39,   39, 1014, 1014, 1014, 1014, 1021, 1022, 1022,
			 1022, 1022, 1022,   62,   62,   62,   62,   62,   62,   62,
			   62,   62,   62,   62,   62,   62,   62, 1014, 1014, 1014,
			 1014, 1014, 1014, 1014, 1014, 1014, 1023, 1014, 1014, 1023,
			 1014, 1024, 1025, 1023, 1023, 1023, 1023, 1023, 1023, 1023,

			 1014, 1014, 1014, 1014, 1014, 1016, 1014, 1026, 1016, 1016,
			 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1017, 1018, 1018,
			 1018, 1018, 1018, 1018, 1018, 1018, 1027, 1014, 1027, 1027,
			 1027, 1027, 1027, 1027, 1027, 1027, 1014, 1014, 1014, 1014,
			 1014, 1014, 1028, 1020, 1020, 1020, 1029, 1030, 1031, 1020,
			 1020, 1014, 1014, 1014, 1014, 1014, 1014,   39,   39,   39,
			   39,   39,   62,   62,   62,   62,   62, 1014, 1014, 1014,
			 1014, 1014, 1014, 1014,   39,   62,   39,   39,   39,   39,
			   39,   62,   62,   62,   62,   62,   39,   39,   62,   62,
			   39,   39,   39,   62,   62,   62,   39,   39,   39,   62,

			   62,   62,   39,   39,   39,   39,   62,   62,   62,   62,
			   39,   39,   62,   62,   39,   62,   39,   39,   39,   39,
			   62,   62,   62,   62,   39,   62,  204,   62,   39,   39,
			   62,   62,   39,   39,   62,   62,   39,   62,   39,   39,
			   62,   62,   39,   62,   39,   62, 1014, 1021, 1021, 1021,
			 1021, 1021, 1021, 1021, 1021, 1014, 1014, 1014, 1014, 1014,
			 1014, 1014, 1014, 1014, 1014, 1014, 1014, 1014, 1023, 1023,
			 1023, 1023, 1023, 1023, 1023, 1023, 1014, 1014, 1032, 1033,
			 1014, 1023, 1024, 1025, 1014, 1023, 1024, 1024, 1024, 1024,
			 1024, 1024, 1024, 1023, 1025, 1025, 1025, 1025, 1025, 1025,

			 1025, 1023, 1023, 1023, 1023, 1023, 1023, 1026, 1018, 1018,
			 1026, 1026, 1026, 1026, 1026, 1026, 1026, 1026, 1026, 1016,
			 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1018, 1018, 1018,
			 1018, 1018, 1018, 1027, 1014, 1027, 1027, 1027, 1027, 1027,
			 1027, 1027, 1027, 1027, 1014, 1027, 1027, 1027, 1027, 1027,
			 1027, 1027, 1027, 1027, 1027, 1027, 1027, 1027, 1027, 1027,
			 1027, 1027, 1027, 1027, 1027, 1027, 1027, 1027, 1027, 1027,
			 1014, 1014, 1014, 1014, 1014, 1014, 1020, 1020, 1020, 1029,
			 1029, 1030, 1030, 1031, 1031, 1020, 1020,   39,   62,   39,
			   39,   62,   62,   39,   62,   39,   62, 1014, 1014, 1014,

			 1014, 1014, 1014,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   39,   62,   62,   39,
			   62,   39,   39,   62,   62,   39,   39,   62,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   39,   39,
			   39,   39,   62,   62,   62,   62,   62,   39,   62,   39,
			   39,   62,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   39,   39,   39,   39,   39,   62,
			   62,   62,   62,   62,   62,   39,   39,   62,   62,   39,
			   62,   39,   62,   39,   62,   39,   39,   39,   62,   62,
			   62,   39,   62,   39,   62,   39,   62,   39,   62, 1014,

			 1021, 1021, 1021, 1021, 1021, 1021, 1014, 1014, 1014, 1014,
			 1014, 1014, 1014, 1014, 1014, 1032, 1032, 1032, 1032, 1032,
			 1032, 1032, 1014, 1033, 1033, 1033, 1033, 1033, 1033, 1033,
			 1024, 1024, 1024, 1024, 1024, 1024, 1025, 1025, 1025, 1025,
			 1025, 1025, 1023, 1023, 1026, 1026, 1026, 1026, 1026, 1026,
			 1026, 1026, 1026, 1026, 1016, 1016, 1018, 1018, 1027, 1027,
			 1027, 1027, 1027, 1027, 1014, 1014, 1014, 1014, 1014, 1027,
			 1014, 1014, 1014, 1014, 1014, 1014, 1014, 1014, 1014, 1014,
			 1014, 1014, 1014, 1014, 1014, 1014, 1027, 1027, 1014, 1014,
			 1014, 1014, 1014, 1014, 1014, 1014, 1014, 1020, 1020, 1029,

			 1029, 1030, 1030,  383, 1031, 1020, 1020,   39,   62,   39,
			   62,   39,   62, 1014, 1014,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   39,   62,   62,   39,   62,   39,
			   62,   39,   62,   39,   39,   62,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   39,   62,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   39,   62,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,

			   62,   39,   62,   39,   62,   39,   62,   39,   62, 1021,
			 1021, 1014, 1014, 1032, 1032, 1032, 1032, 1032, 1032, 1033,
			 1033, 1033, 1033, 1033, 1033, 1024, 1024, 1025, 1025, 1026,
			 1026, 1026, 1027, 1027, 1027, 1014, 1014, 1014, 1014, 1014,
			 1014, 1014, 1014, 1014, 1014, 1028, 1020,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,

			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62, 1032, 1032, 1033, 1033, 1026, 1014, 1014, 1014, 1014,
			 1014, 1014, 1014, 1014, 1014, 1014, 1014, 1014, 1034,   39,
			   62,   39,   62,   39,   39,   62,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,

			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62, 1014, 1014, 1014, 1014, 1014, 1014, 1014,
			 1014, 1014, 1014, 1014, 1014, 1014, 1014,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62,   39,   62,   39,
			   62,   39,   62,   39,   62,   39,   62, 1014, 1014, 1014,
			 1014, 1014, 1014, 1014, 1014, 1014, 1014, 1014,   39,   62,
			   39,   62,   39,   62,   39,   62,   39,   62,   39,   62,
			   39,   62,   39,   62,   39,   62,   39,   62,   39,   62,

			   39,   62, 1014, 1014, 1014, 1014, 1014,   39,   62,   39,
			   62,   39,   62, 1014,    0, 1014, 1014, 1014, 1014, 1014,
			 1014, 1014, 1014, 1014, 1014, 1014, 1014, 1014, 1014, 1014,
			 1014, 1014, 1014, 1014, 1014, yy_Dummy>>)
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
			  926,  928,  930,  931,  934,  936,  938,  939,  942,  944,
			  946,  948,  949,  950,  952,  953,  955,  956,  958,  959,
			  961,  962,  964,  966,  967,  968,  970,  971,  973,  974,
			  976,  977,  979,  980,  983,  985,  988,  990,  992,  993,

			  995,  996,  998,  999, 1001, 1002, 1005, 1007, 1010, 1012,
			 1012, 1012, 1012, 1012, 1012, 1012, 1012, 1012, 1012, 1012,
			 1012, 1012, 1012, 1012, 1012, 1012, 1013, 1014, 1015, 1016,
			 1016, 1016, 1016, 1017, 1018, 1019, 1020, 1022, 1022, 1022,
			 1024, 1024, 1028, 1028, 1030, 1030, 1030, 1032, 1035, 1037,
			 1040, 1042, 1044, 1045, 1048, 1050, 1053, 1055, 1057, 1058,
			 1060, 1061, 1063, 1064, 1067, 1069, 1071, 1072, 1074, 1075,
			 1077, 1078, 1080, 1081, 1083, 1084, 1086, 1087, 1090, 1092,
			 1094, 1095, 1097, 1098, 1100, 1101, 1103, 1104, 1107, 1109,
			 1111, 1112, 1114, 1115, 1117, 1118, 1121, 1123, 1125, 1126,

			 1128, 1129, 1131, 1132, 1134, 1135, 1137, 1138, 1140, 1141,
			 1143, 1144, 1146, 1147, 1149, 1150, 1153, 1155, 1157, 1158,
			 1160, 1161, 1164, 1166, 1168, 1169, 1171, 1172, 1175, 1177,
			 1179, 1180, 1180, 1180, 1180, 1180, 1180, 1181, 1181, 1183,
			 1183, 1184, 1185, 1189, 1189, 1189, 1191, 1191, 1192, 1192,
			 1195, 1197, 1199, 1200, 1203, 1205, 1207, 1208, 1210, 1211,
			 1213, 1214, 1217, 1219, 1222, 1224, 1226, 1227, 1230, 1232,
			 1234, 1235, 1237, 1238, 1241, 1243, 1245, 1246, 1248, 1249,
			 1251, 1252, 1254, 1255, 1257, 1258, 1260, 1261, 1263, 1264,
			 1267, 1269, 1271, 1272, 1274, 1275, 1278, 1280, 1282, 1283,

			 1286, 1288, 1291, 1293, 1296, 1298, 1300, 1301, 1303, 1304,
			 1307, 1309, 1311, 1312, 1312, 1313, 1313, 1313, 1313, 1317,
			 1317, 1318, 1319, 1319, 1319, 1320, 1321, 1322, 1325, 1327,
			 1329, 1330, 1333, 1335, 1337, 1338, 1340, 1341, 1343, 1344,
			 1347, 1349, 1352, 1354, 1356, 1357, 1360, 1362, 1365, 1367,
			 1369, 1370, 1372, 1373, 1375, 1376, 1378, 1379, 1381, 1382,
			 1385, 1387, 1389, 1390, 1392, 1393, 1396, 1398, 1399, 1399,
			 1400, 1400, 1402, 1402, 1402, 1403, 1404, 1404, 1405, 1408,
			 1410, 1413, 1415, 1418, 1420, 1423, 1425, 1428, 1430, 1432,
			 1433, 1436, 1438, 1440, 1441, 1444, 1446, 1448, 1449, 1452,

			 1454, 1457, 1459, 1460, 1462, 1462, 1464, 1465, 1468, 1470,
			 1473, 1475, 1478, 1480, 1482, 1482, yy_Dummy>>)
		end

	yy_acclist_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,  137,  137,  158,  156,  157,    3,  156,  157,    4,
			  157,    1,  156,  157,    2,  156,  157,   10,  156,  157,
			  139,  156,  157,  104,  156,  157,   17,  156,  157,  139,
			  156,  157,  156,  157,   11,  156,  157,   12,  156,  157,
			   31,  156,  157,   30,  156,  157,    8,  156,  157,   29,
			  156,  157,    6,  156,  157,   32,  156,  157,  141,  148,
			  156,  157,  141,  148,  156,  157,  141,  148,  156,  157,
			    9,  156,  157,    7,  156,  157,   36,  156,  157,   34,
			  156,  157,   35,  156,  157,  156,  157,  102,  103,  156,
			  157,  102,  103,  156,  157,  102,  103,  156,  157,  102,

			  103,  156,  157,  102,  103,  156,  157,  102,  103,  156,
			  157,  102,  103,  156,  157,  102,  103,  156,  157,  102,
			  103,  156,  157,  102,  103,  156,  157,  102,  103,  156,
			  157,  102,  103,  156,  157,  102,  103,  156,  157,  102,
			  103,  156,  157,  102,  103,  156,  157,  102,  103,  156,
			  157,  102,  103,  156,  157,  102,  103,  156,  157,  102,
			  103,  156,  157,   15,  156,  157,  156,  157,   16,  156,
			  157,   33,  156,  157,  156,  157,  103,  156,  157,  103,
			  156,  157,  103,  156,  157,  103,  156,  157,  103,  156,
			  157,  103,  156,  157,  103,  156,  157,  103,  156,  157,

			  103,  156,  157,  103,  156,  157,  103,  156,  157,  103,
			  156,  157,  103,  156,  157,  103,  156,  157,  103,  156,
			  157,  103,  156,  157,  103,  156,  157,  103,  156,  157,
			  103,  156,  157,   13,  156,  157,   14,  156,  157,  156,
			  157,  156,  157,  156,  157,  156,  157,  156,  157,  156,
			  157,  156,  157,  137,  157,  135,  157,  136,  157,  131,
			  137,  157,  134,  157,  137,  157,  137,  157,  137,  157,
			  137,  157,  137,  157,  137,  157,  137,  157,  137,  157,
			  137,  157,    3,    4,    1,    2,   37,  139,  138,  138,
			 -129,  139, -286, -130,  139, -287,  139,  139,  139,  139,

			  139,  139,  139,  104,  139,  139,  139,  139,  139,  139,
			  139,  139,  128,  128,  128,  128,  128,  128,  128,  128,
			  128,    5,   23,   24,  151,  154,   18,   20,  141,  148,
			  141,  148,  148,  140,  148,  148,  148,  140,  148,   28,
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
			  103,  103,  102,  103,  103,  102,  103,  103,   19,  137,
			  137,  137,  137,  137,  137,  137,  137,  135,  136,  131,
			  137,  137,  137,  134,  132,  137,  137,  137,  137,  137,

			  137,  137,  137,  133,  137,  137,  137,  137,  137,  137,
			  137,  137,  137,  137,  137,  137,  137,  137,  138,  139,
			  138,  139, -129,  139, -130,  139,  139,  139,  139,  139,
			  139,  139,  139,  139,  139,  139,  139,  139,  128,  105,
			  128,  128,  128,  128,  128,  128,  128,  128,  128,  128,
			  128,  128,  128,  128,  128,  128,  128,  128,  128,  128,
			  128,  128,  128,  128,  128,  128,  128,  128,  128,  128,
			  128,  128,  128,  128,  151,  154,  149,  151,  154,  149,
			  141,  148,  141,  148,  144,  147,  148,  147,  148,  143,
			  146,  148,  146,  148,  142,  145,  148,  145,  148,  141,

			  148,  102,  103,  103,  102,  103,   40,  102,  103,  103,
			   40,  103,   41,  102,  103,   41,  103,  102,  103,  103,
			   44,  102,  103,   44,  103,  102,  103,  103,  102,  103,
			  103,  102,  103,  103,  102,  103,  103,  102,  103,  103,
			  102,  103,  102,  103,  103,  103,  102,  103,  103,   56,
			  102,  103,  102,  103,   56,  103,  103,  102,  103,  102,
			  103,  103,  103,  102,  103,  103,  102,  103,  103,  102,
			  103,  103,  102,  103,  103,  102,  103,  102,  103,  102,
			  103,  102,  103,  102,  103,  103,  103,  103,  103,  103,
			  102,  103,  103,  102,  103,  102,  103,  103,  103,   76,

			  102,  103,   76,  103,  102,  103,  103,   78,  102,  103,
			   78,  103,  102,  103,  103,  102,  103,  103,  102,  103,
			  102,  103,  102,  103,  102,  103,  102,  103,  102,  103,
			  103,  103,  103,  103,  103,  103,  102,  103,  102,  103,
			  103,  103,  102,  103,  103,  102,  103,  103,  102,  103,
			  103,  102,  103,  102,  103,  102,  103,  103,  103,  103,
			  102,  103,  103,  102,  103,  103,  102,  103,  103,  101,
			  102,  103,  101,  103,  155,  132,  133,  137,  137,  137,
			  137,  137,  137,  137,  137,  137,  137,  137,  137,  137,
			  137,  138,  138,  138,  139,  139,  139,  139,  128,  128,

			  128,  128,  128,  128,  122,  120,  121,  123,  124,  128,
			  125,  126,  106,  107,  108,  109,  110,  111,  112,  113,
			  114,  115,  116,  117,  118,  119,  128,  128,  151,  154,
			  151,  154,  151,  154,  150,  153,  141,  148,  141,  148,
			  141,  148,  141,  148,  102,  103,  103,  102,  103,  103,
			  102,  103,  103,  102,  103,  103,  102,  103,  103,  102,
			  103,  103,  102,  103,  103,  102,  103,  103,  102,  103,
			  103,  102,  103,  103,   54,  102,  103,   54,  103,  102,
			  103,  103,  102,  103,  102,  103,  103,  103,  102,  103,
			  103,  102,  103,  103,  102,  103,  103,   63,  102,  103,

			  102,  103,   63,  103,  103,  102,  103,  103,  102,  103,
			  103,  102,  103,  103,  102,  103,  103,  102,  103,  103,
			  102,  103,  103,   73,  102,  103,   73,  103,  102,  103,
			  103,   75,  102,  103,   75,  103,  102,  103,  103,   79,
			  102,  103,   79,  103,  102,  103,  102,  103,  103,  103,
			  102,  103,  103,  102,  103,  103,  102,  103,  103,  102,
			  103,  103,  102,  103,  102,  103,  103,  103,  102,  103,
			  103,  102,  103,  103,  102,  103,  103,  102,  103,  103,
			   93,  102,  103,   93,  103,   94,  102,  103,   94,  103,
			  102,  103,  103,  102,  103,  103,  102,  103,  103,  102,

			  103,  103,   99,  102,  103,   99,  103,  100,  102,  103,
			  100,  103,  137,  137,  137,  137,  128,  128,  128,  151,
			  151,  154,  151,  154,  150,  151,  153,  154,  150,  153,
			  141,  148,   38,  102,  103,   38,  103,   39,  102,  103,
			   39,  103,  102,  103,  103,   45,  102,  103,   45,  103,
			   46,  102,  103,   46,  103,  102,  103,  103,  102,  103,
			  103,  102,  103,  103,   51,  102,  103,   51,  103,  102,
			  103,  103,  102,  103,  103,  102,  103,  103,  102,  103,
			  103,  102,  103,  103,  102,  103,  103,   61,  102,  103,
			   61,  103,  102,  103,  103,  102,  103,  103,  102,  103,

			  103,  102,  103,  103,   68,  102,  103,   68,  103,  102,
			  103,  103,  102,  103,  103,  102,  103,  103,   74,  102,
			  103,   74,  103,  102,  103,  103,  102,  103,  103,  102,
			  103,  103,  102,  103,  103,  102,  103,  103,  102,  103,
			  103,  102,  103,  103,  102,  103,  103,  102,  103,  103,
			   89,  102,  103,   89,  103,  102,  103,  103,  102,  103,
			  103,   92,  102,  103,   92,  103,  102,  103,  103,  102,
			  103,  103,   97,  102,  103,   97,  103,  102,  103,  103,
			  127,  151,  154,  154,  151,  150,  151,  153,  154,  150,
			  153,  149,   43,  102,  103,   43,  103,  102,  103,  103,

			   48,  102,  103,  102,  103,   48,  103,  103,  102,  103,
			  103,  102,  103,  103,   55,  102,  103,   55,  103,   57,
			  102,  103,   57,  103,  102,  103,  103,   59,  102,  103,
			   59,  103,  102,  103,  103,  102,  103,  103,   64,  102,
			  103,   64,  103,  102,  103,  103,  102,  103,  103,  102,
			  103,  103,  102,  103,  103,  102,  103,  103,  102,  103,
			  103,  102,  103,  103,   82,  102,  103,   82,  103,  102,
			  103,  103,  102,  103,  103,   85,  102,  103,   85,  103,
			  102,  103,  103,   87,  102,  103,   87,  103,   88,  102,
			  103,   88,  103,   90,  102,  103,   90,  103,  102,  103,

			  103,  102,  103,  103,   96,  102,  103,   96,  103,  102,
			  103,  103,  151,  150,  151,  153,  154,  154,  150,  152,
			  154,  152,   47,  102,  103,   47,  103,  102,  103,  103,
			   50,  102,  103,   50,  103,  102,  103,  103,  102,  103,
			  103,  102,  103,  103,   62,  102,  103,   62,  103,   66,
			  102,  103,   66,  103,  102,  103,  103,   69,  102,  103,
			   69,  103,   70,  102,  103,   70,  103,  102,  103,  103,
			  102,  103,  103,  102,  103,  103,  102,  103,  103,  102,
			  103,  103,   86,  102,  103,   86,  103,  102,  103,  103,
			  102,  103,  103,   98,  102,  103,   98,  103,  154,  154,

			  150,  151,  153,  154,  153,   49,  102,  103,   49,  103,
			   52,  102,  103,   52,  103,   58,  102,  103,   58,  103,
			   60,  102,  103,   60,  103,   67,  102,  103,   67,  103,
			  102,  103,  103,   77,  102,  103,   77,  103,  102,  103,
			  103,   84,  102,  103,   84,  103,  102,  103,  103,   91,
			  102,  103,   91,  103,   95,  102,  103,   95,  103,  154,
			  153,  154,  153,  154,  153,   71,  102,  103,   71,  103,
			   81,  102,  103,   81,  103,   83,  102,  103,   83,  103,
			  153,  154, yy_Dummy>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER is 9463
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER is 1014
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER is 1015
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

	yyNb_rules: INTEGER is 157
			-- Number of rules

	yyEnd_of_buffer: INTEGER is 158
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
