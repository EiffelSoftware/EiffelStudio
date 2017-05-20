note
	description:"Scanners for Eiffel parsers"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author:     "Arnaud PICHERY from an Eric Bezault model"
	date:       "$Date$"
	revision:   "$Revision$"

class EDITOR_EIFFEL_SCANNER

inherit

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

					curr_token := new_space (text_count)
					update_token_list
					
when 2 then
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
					
when 3 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

					curr_token := new_eol (True)
					update_token_list
					in_comments := False
					
when 4 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

					curr_token := new_eol (False)
					update_token_list
					in_comments := False
					
when 5 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

					curr_token := new_text (text)
					update_token_list
					
when 6 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end
 
						-- comments
					curr_token := new_comment (text)
					in_comments := True	
					update_token_list					
				
when 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18 then
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
					
when 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39 then
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
					
when 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102 then
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
										
when 103, 104, 105, 106, 107, 108 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

							if in_comments then
									-- Comment
								curr_token := new_comment (text)
							elseif syntax_version /= {EIFFEL_SCANNER}.obsolete_syntax then
									-- Keyword
								curr_token := new_keyword (text)
							else
									-- Identifier
								curr_token := new_text (text)
							end
							update_token_list
						
when 109, 110 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

							if in_comments then
									-- Comment
								curr_token := new_comment (text)
							elseif
								syntax_version = {EIFFEL_SCANNER}.obsolete_syntax or else
								syntax_version = {EIFFEL_SCANNER}.transitional_syntax
							then
									-- Keyword
								curr_token := new_keyword (text)
							else
								curr_token := new_text (text)
							end
							update_token_list
						
when 111 then
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
										
when 113 then
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
										
when 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 131, 132, 133, 134, 135 then
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
					
when 136 then
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
					
when 137 then
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

						curr_token := new_eol (True)
						update_token_list
						in_comments := False
						
when 145 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

						curr_token := new_eol (False)
						update_token_list
						in_comments := False
						
when 146 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

						curr_token := new_text (text)
						update_token_list
						
when 147 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

						curr_token := new_string (text)
						update_token_list
					
when 148, 149 then
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
					
when 150 then
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
					
when 151, 152, 153, 154 then
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
						
when 155, 156, 157, 158 then
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
						
when 159 then
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
						
when 160, 161 then
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
						
when 162 then
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
						
when 163, 164 then
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
						
when 165, 166 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

					curr_token := new_text_in_comment (text)
					update_token_list
					
when 167 then
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
				
when 168 then
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
			-- Template for `yy_nxt'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 8029)
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
			yy_nxt_template_12 (an_array)
			yy_nxt_template_13 (an_array)
			yy_nxt_template_14 (an_array)
			yy_nxt_template_15 (an_array)
			yy_nxt_template_16 (an_array)
			yy_nxt_template_17 (an_array)
			yy_nxt_template_18 (an_array)
			yy_nxt_template_19 (an_array)
			yy_nxt_template_20 (an_array)
			yy_nxt_template_21 (an_array)
			yy_nxt_template_22 (an_array)
			yy_nxt_template_23 (an_array)
			yy_nxt_template_24 (an_array)
			yy_nxt_template_25 (an_array)
			yy_nxt_template_26 (an_array)
			yy_nxt_template_27 (an_array)
			yy_nxt_template_28 (an_array)
			yy_nxt_template_29 (an_array)
			yy_nxt_template_30 (an_array)
			yy_nxt_template_31 (an_array)
			yy_nxt_template_32 (an_array)
			yy_nxt_template_33 (an_array)
			yy_nxt_template_34 (an_array)
			yy_nxt_template_35 (an_array)
			yy_nxt_template_36 (an_array)
			yy_nxt_template_37 (an_array)
			yy_nxt_template_38 (an_array)
			yy_nxt_template_39 (an_array)
			yy_nxt_template_40 (an_array)
			yy_nxt_template_41 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_nxt_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_nxt'.
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

			   86,   88,   89,   90,   91,  138,  136,  139,  139,  139,
			  139,  140,  158,   88,   89,   90,   91,  137,  879,  141,
			  143, 1076,  144,  144,  145,  145,  153,  154,  155,  156,
			  772,  106,  231,  151,  107,  191,  158,  765,  106,  158,
			  127,  107,  127,  127,  165,  192,  620,  143,  128,  145,
			  145,  145,  145,  215,  158,  158,  618,   92,  195,  216,
			  196, 1076,  150,  385,  232,  151,  616,  193,  165,   92,
			  197,  165,  158,  158,  158,  158,  620,  194,  271,  271,
			  108,  229,  142,  249,  158,  217,  165,  165,   93,  150,
			  198,  218,  199,   94,   95,   96,   97,   98,   99,  100, yy_Dummy>>,
			1, 200, 0)
		end

	yy_nxt_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			   93,  618,  200,  385,  165,   94,   95,   96,   97,   98,
			   99,  100,  109,  230,  616,  250,  165,  582,  110,  111,
			  112,  113,  114,  115,  116,  119,  120,  121,  122,  123,
			  124,  125,  129,  130,  131,  132,  133,  134,  135,  143,
			  158,  144,  144,  145,  145,  527,  219,  201,  410,  410,
			  158,  202,  147,  148,  158,  158,  179,  158,  233,  158,
			  158,  158,  158,  251,  203,  243,  158,  158,  234,  158,
			  239,  158,  165,  235,  149,  270,  270,  270,  220,  204,
			  240,  150,  165,  205,  147,  148,  165,  165,  180,  165,
			  236,  165,  165,  165,  165,  252,  206,  244,  165,  165,

			  237,  165,  241,  165, 1076,  238,  149,  158,  158,  158,
			  158,  522,  242,  272,  272,  272,  158,  158,  158,  159,
			  158,  158,  158,  160,  158,  158,  158,  158,  161,  158,
			  162,  158,  158,  158,  158,  163,  164,  158,  158,  158,
			  158,  158,  158,  273,  273,  273,  385,  158,  165,  165,
			  165,  166,  165,  165,  165,  167,  165,  165,  165,  165,
			  168,  165,  169,  165,  165,  165,  165,  170,  171,  165,
			  165,  165,  165,  165,  165,  143,  158,  384,  384,  384,
			  384,  172,  173,  174,  175,  176,  177,  178,  181,  158,
			  221,  283,  182,  284,  284,  183,  207,  158,  184,  158, yy_Dummy>>,
			1, 200, 200)
		end

	yy_nxt_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  222,  185,  223,  208,  209,  245,  224,  413,  165,  210,
			  396,  402,  158,  158,  158,  408,  158,  150,  341,  246,
			  186,  165,  225,  103,  187,  524,  524,  188,  211,  165,
			  189,  165,  226,  190,  227,  212,  213,  247,  228,  386,
			  386,  214,  397,  403,  165,  165,  165,  285,  165,  158,
			  193,  248,  255,  256,  257,  258,  259,  260,  261,  166,
			  194,  498,  165,  167,  165,  165,  398,  165,  168,  399,
			  169,  230,  180,  508,  165,  170,  171,  165,  286,  385,
			  101,  165,  193,  276,  277,  278,  279,  280,  281,  282,
			  274,  166,  194,  499,  165,  167,  165,  165,  400,  165,

			  168,  401,  169,  230,  180,  509,  165,  170,  171,  165,
			  262,  263,  264,  265,  266,  267,  268,  388,  388,  388,
			  269,  262,  263,  264,  265,  266,  267,  268,  262,  263,
			  264,  265,  266,  267,  268,  186,  158,  158,  217,  187,
			  158,  165,  188,  165,  218,  189,  394,  198,  190,  199,
			  404,  158,  158,  165,  158,  158,  158,  385,  446,  200,
			  276,  277,  278,  279,  280,  281,  282,  186,  165,  165,
			  217,  187,  165,  165,  188,  165,  218,  189,  395,  198,
			  190,  199,  405,  165,  165,  165,  409,  409,  409,  253,
			  447,  200,  262,  263,  264,  265,  266,  267,  268,  157, yy_Dummy>>,
			1, 200, 400)
		end

	yy_nxt_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  262,  263,  264,  265,  266,  267,  268,  204,  211,  152,
			  165,  205,  165,  220,  165,  212,  213,  158,  165,  225,
			  165,  214,  165,  416,  206,  104,  165,  158,  406,  226,
			  165,  227,  411,  411,  411,  228,  412,  412,  412,  204,
			  211,  165,  165,  205,  165,  220,  165,  212,  213,  165,
			  165,  225,  165,  214,  165,  417,  206,  232,  165,  165,
			  407,  226,  165,  227,  165,  236,  165,  228,  381,  381,
			  381,  381,  165,  165,  165,  237,  165,  241,  103,  158,
			  238,  165,  382,  165,  165,  629,  448,  242,  165,  232,
			  244,  386,  386,  165,  102,  418,  165,  236,  165,  101,

			  165, 1076, 1076,  158,  165, 1076,  165,  237,  165,  241,
			  247,  165,  238,  165,  382,  165,  165,  630,  449,  242,
			  165,  165,  244,  165,  248,  165,  165,  419,  165,  252,
			  250,  615,  165,  165,  165,  165,  165,  284,  165,  284,
			  291,  422,  247,  158, 1076,  158,  165,  284,  287,  288,
			  284, 1076, 1076,  165, 1076,  165,  248, 1076,  165, 1076,
			  165,  252,  250, 1076,  285,  165,  165,  285,  165,  292,
			  165,  286,  275,  423,  286,  165,  300,  165,  165,  275,
			  308,  276,  277,  278,  279,  280,  281,  282,  165,  165,
			  165,  310,  310,  285,  276,  277,  278,  279,  280,  281, yy_Dummy>>,
			1, 200, 600)
		end

	yy_nxt_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  282,  158, 1076,  289,  309,  309,  309,  276,  277,  278,
			  279,  280,  281,  282,  311,  311,  311,  276,  277,  278,
			  279,  280,  281,  282,  286,  523,  523,  523,  525,  525,
			  525, 1076,  106,  165,  290,  107,  526,  526,  526,  276,
			  277,  278,  279,  280,  281,  282,  312,  312,  312,  276,
			  277,  278,  279,  280,  281,  282,  293,  294,  295,  296,
			  297,  298,  299,  301,  302,  303,  304,  305,  306,  307,
			  313, 1076,  158,  276,  277,  278,  279,  280,  281,  282,
			 1076,  108, 1076,  414,  158,  326,  460,  326,  326, 1076,
			  106, 1076,  143,  107,  383,  383,  384,  384,  327, 1076,

			  327,  327, 1076,  106,  165,  151,  107, 1076, 1076,  158,
			  158,  158,  158,  109,  420,  415,  165, 1076,  461,  110,
			  111,  112,  113,  114,  115,  116,  315,  675, 1076,  316,
			  118,  118,  118, 1076,  150,  386,  386,  151,  317,  108,
			  106,  165,  158,  107, 1076,  118,  421,  118, 1076,  118,
			  118,  318,  108, 1076,  118,  106,  118, 1076,  107,  676,
			  118, 1076,  118, 1076, 1076,  118,  118,  118,  118,  118,
			  118,  109, 1076,  106,  165,  615,  107,  110,  111,  112,
			  113,  114,  115,  116,  109,  106, 1076, 1076,  107,  108,
			  110,  111,  112,  113,  114,  115,  116,  158,  158,  158, yy_Dummy>>,
			1, 200, 800)
		end

	yy_nxt_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  106, 1076, 1076,  107,  108,  158,  158,  158,  158,  158,
			  158, 1076, 1076,  319,  320,  321,  322,  323,  324,  325,
			  106,  109,  108,  107,  528,  528,  528,  110,  111,  112,
			  113,  114,  115,  116,  106, 1076,  109,  107,  529,  529,
			  529,  328,  110,  111,  112,  113,  114,  115,  116,  108,
			  106, 1076, 1076,  107,  109, 1076, 1076,  329,  329,  329,
			  110,  111,  112,  113,  114,  115,  116,  106,  158,  108,
			  107,  442,  119,  120,  121,  122,  123,  124,  125,  106,
			 1076,  109,  107,  108,  330,  330, 1076,  110,  111,  112,
			  113,  114,  115,  116,  106, 1076,  719,  107,  729,  108,

			  165,  109, 1076,  443,  331,  331,  331,  110,  111,  112,
			  113,  114,  115,  116,  106,  109, 1076,  107,  332,  332,
			  332,  110,  111,  112,  113,  114,  115,  116,  720,  106,
			  730,  109,  107, 1076,  333, 1076, 1076,  110,  111,  112,
			  113,  114,  115,  116,  106, 1076, 1076,  107,  377,  377,
			  377,  377, 1076, 1076,  119,  120,  121,  122,  123,  124,
			  125,  106,  378, 1076,  107,  334,  119,  120,  121,  122,
			  123,  124,  125,  341,  607,  607,  607,  607,  335,  335,
			  335,  119,  120,  121,  122,  123,  124,  125,  379, 1076,
			 1076,  474,  731,  158,  378,  158, 1076, 1076,  336,  336, yy_Dummy>>,
			1, 200, 1000)
		end

	yy_nxt_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			 1076,  119,  120,  121,  122,  123,  124,  125,  283, 1076,
			  284,  284, 1076,  337,  337,  337,  119,  120,  121,  122,
			  123,  124,  125,  475,  732,  165,  341,  165,  338,  338,
			  338,  119,  120,  121,  122,  123,  124,  125,  341, 1076,
			  472,  392,  392,  392,  392,  339,  158,  785,  119,  120,
			  121,  122,  123,  124,  125,  341,  342,  343,  344,  345,
			  346,  347,  348,  349,  285, 1076,  350,  351,  352,  353,
			 1076, 1076,  473, 1076, 1076,  354, 1076,  341,  165,  786,
			 1076,  393,  355, 1076,  356,  158,  357,  358,  359,  360,
			  341,  361, 1076,  362, 1076,  286,  466,  363, 1076,  364,

			  341, 1076,  365,  366,  367,  368,  369,  370,  371,  342,
			  343,  344,  345,  346,  347,  348,  341,  165,  126,  126,
			  126,  342,  343,  344,  345,  346,  347,  348,  467,  388,
			  388,  388,  158,  158,  158,  372,  372,  372,  342,  343,
			  344,  345,  346,  347,  348,  158,  158,  158, 1076, 1076,
			  342,  343,  344,  345,  346,  347,  348,  373,  373, 1076,
			  342,  343,  344,  345,  346,  347,  348, 1076, 1076,  617,
			  374,  374,  374,  342,  343,  344,  345,  346,  347,  348,
			  375,  375,  375,  342,  343,  344,  345,  346,  347,  348,
			  158,  158,  158, 1076,  158,  803,  376, 1076,  492,  342, yy_Dummy>>,
			1, 200, 1200)
		end

	yy_nxt_template_8 (an_array: ARRAY [INTEGER])
			-- Fill chunk #8 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  343,  344,  345,  346,  347,  348,  390,  390,  390,  390,
			  165, 1076,  165,  158,  158,  158,  390,  390,  390,  390,
			  390,  390,  165,  165,  397,  165,  165,  804,  158,  395,
			  493,  165, 1076,  165, 1076,  165, 1076, 1076,  432,  635,
			  635,  635,  165,  165,  165, 1076,  385, 1076,  390,  390,
			  390,  390,  390,  390,  165,  165,  397,  165,  403,  400,
			  165,  395,  401,  165,  165,  165,  165,  165,  165,  165,
			  433,  165,  158,  819,  165,  165,  405,  165,  165,  165,
			  165,  165,  165, 1076,  158,  407, 1076, 1076,  415,  165,
			  403,  400,  165,  424,  401, 1076,  165, 1076,  165, 1076,

			  165,  165, 1076,  165,  165,  820,  165, 1076,  405,  165,
			  165,  165,  165,  165,  165,  444,  165,  407,  419,  417,
			  415,  165, 1076,  158,  165,  425,  165,  423,  165,  165,
			  165,  165,  421,  165,  165,  165,  165,  158,  165,  425,
			 1076,  165,  165,  623, 1076,  165,  165,  445, 1076, 1076,
			  419,  417,  636,  636,  636,  165, 1076, 1076,  165,  423,
			  165,  165,  165,  165,  421,  165,  165,  165,  165,  165,
			  165,  425,  426,  165,  165,  624,  427,  165,  165,  158,
			  165,  429,  165,  434,  158,  430,  158,  158,  158,  158,
			  428,  165,  165,  165,  468,  165,  438,  165,  435,  431, yy_Dummy>>,
			1, 200, 1400)
		end

	yy_nxt_template_9 (an_array: ARRAY [INTEGER])
			-- Fill chunk #9 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  439, 1076,  433,  165,  429,  158, 1076,  165,  430, 1076,
			 1076,  165,  165,  429,  165,  436,  165,  430,  165,  165,
			  165,  165,  431,  165,  165,  165,  469,  165,  440,  165,
			  437,  431,  441,  436,  433,  165,  627,  165,  165,  165,
			  165,  165,  440,  165,  158,  443,  441,  165,  437, 1076,
			  165,  470,  165,  165,  165,  447,  158,  165,  445,  643,
			  165,  165,  165, 1076,  165,  436, 1076,  158,  628,  165,
			  165,  165,  165,  165,  440,  165,  165,  443,  441,  165,
			  437,  165,  165,  471,  165,  165,  165,  447,  165,  165,
			  445,  644,  165,  450,  165,  451,  165,  452,  158,  165,

			  165,  165,  165,  165,  165,  165,  158,  165,  453,  449,
			  496,  454,  165,  165,  158,  494,  158,  165,  165,  165,
			  165,  625, 1076, 1076,  165,  455,  165,  456, 1076,  457,
			  165, 1076,  165, 1076,  165, 1076,  165,  165,  165,  165,
			  458,  449,  497,  459,  165,  462,  165,  495,  165,  165,
			  455,  158,  456,  626,  457,  510, 1076,  463,  165,  158,
			  165,  461,  165,  158,  165,  458,  158,  464,  459,  671,
			  165,  158,  506,  165,  165,  165,  165,  464,  165,  465,
			 1076,  467,  455,  165,  456,  165,  457,  511,  165,  465,
			  165,  165,  165,  461,  165,  165,  165,  458,  165,  464, yy_Dummy>>,
			1, 200, 1600)
		end

	yy_nxt_template_10 (an_array: ARRAY [INTEGER])
			-- Fill chunk #10 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  459,  672,  165,  165,  507,  165,  165,  165,  165,  837,
			  165,  465,  165,  467,  165,  471,  637,  165,  473,  469,
			  165,  158,  158,  165,  165,  165,  165,  165,  165,  165,
			  512,  158, 1076,  475, 1076,  165, 1076,  691,  165,  165,
			  165,  838,  165, 1076,  165, 1076,  165,  471,  638, 1076,
			  473,  469,  165,  165,  165,  165,  165,  165,  165,  165,
			  165,  165,  513,  165,  490,  475,  165,  165,  491,  692,
			  165,  165,  165,  476,  165,  477,  165,  500,  158,  165,
			  493,  165,  501,  478,  165,  158,  479,  158,  480,  481,
			 1076,  165, 1076,  502,  158,  639,  490,  488,  165,  647,

			  491,  489,  165,  165,  165,  482, 1076,  483,  165,  503,
			  165,  165,  493,  165,  504,  484, 1076,  165,  485,  165,
			  486,  487,  482,  165,  483,  505,  165,  640, 1076,  490,
			  165,  648,  484,  491,  165,  485,  165,  486,  487,  651,
			  495,  497,  165,  165,  511,  165,  165,  158,  165, 1076,
			  165,  165,  499,  165,  482,  165,  483,  165,  165,  165,
			  165, 1076,  165,  165,  484, 1076,  165,  485,  165,  486,
			  487,  652,  495,  497,  165,  165,  511,  165,  165,  165,
			  165,  503,  165,  165,  499,  165,  504,  165,  165,  165,
			  165,  165,  165,  509,  507,  165,  165,  505,  165,  514, yy_Dummy>>,
			1, 200, 1800)
		end

	yy_nxt_template_11 (an_array: ARRAY [INTEGER])
			-- Fill chunk #11 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  165,  165,  158,  165,  681,  165,  514,  158,  165,  513,
			  831,  645,  158,  503,  514,  165, 1076, 1076,  504, 1076,
			  165,  165,  165,  165,  514,  509,  507, 1076,  165,  505,
			  165, 1076,  165,  165,  165,  165,  682,  165, 1076,  165,
			  165,  513,  832,  646,  165, 1076,  605,  165,  605,  515,
			  530,  606,  606,  606,  606, 1076,  515,  276,  277,  278,
			  279,  280,  281,  282,  515,  514,  276,  277,  278,  279,
			  280,  281,  282, 1076,  515,  514,  739,  739,  739, 1076,
			  538, 1076,  255,  256,  257,  258,  259,  260,  261,  255,
			  256,  257,  258,  259,  260,  261,  516,  255,  256,  257,

			  258,  259,  260,  261,  517,  517,  517,  255,  256,  257,
			  258,  259,  260,  261, 1076,  515,  514,  308,  276,  277,
			  278,  279,  280,  281,  282,  515,  514,  309,  309,  309,
			  276,  277,  278,  279,  280,  281,  282,  531,  532,  533,
			  534,  535,  536,  537, 1076,  518,  518, 1076,  255,  256,
			  257,  258,  259,  260,  261,  519,  519,  519,  255,  256,
			  257,  258,  259,  260,  261, 1076,  515,  539,  540,  541,
			  542,  543,  544,  545,  310,  310,  515,  276,  277,  278,
			  279,  280,  281,  282,  311,  311,  311,  276,  277,  278,
			  279,  280,  281,  282, 1076,  845,  520,  520,  520,  255, yy_Dummy>>,
			1, 200, 2000)
		end

	yy_nxt_template_12 (an_array: ARRAY [INTEGER])
			-- Fill chunk #12 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  256,  257,  258,  259,  260,  261,  521, 1076, 1076,  255,
			  256,  257,  258,  259,  260,  261,  312,  312,  312,  276,
			  277,  278,  279,  280,  281,  282,  313,  846,  158,  276,
			  277,  278,  279,  280,  281,  282,  284, 1076,  284,  284,
			  284, 1076,  288,  284, 1076, 1076,  158,  285, 1076,  165,
			  285,  626,  292, 1076,  286,  275, 1076,  286,  655,  300,
			  165,  165,  275,  649, 1076, 1076,  284,  158,  284,  291,
			  276,  277,  278,  279,  280,  281,  282,  285,  165, 1076,
			  285,  165,  292,  626, 1076,  275,  285, 1076,  158,  285,
			  656,  292,  285,  165,  275,  650,  289,  285,  663,  165,

			  285, 1076,  292, 1076, 1076,  275, 1076,  285, 1076, 1076,
			  285,  611,  292,  611, 1076,  275,  612,  612,  612,  612,
			  165,  285,  285,  286,  285, 1076,  292,  290,  158,  275,
			  664, 1076,  276,  277,  278,  279,  280,  281,  282,  293,
			  294,  295,  296,  297,  298,  299,  301,  302,  303,  304,
			  305,  306,  307,  286,  285, 1076, 1076,  285, 1076,  292,
			  165, 1076,  275,  740,  740,  740,  158,  158,  158,  293,
			  294,  295,  296,  297,  298,  299, 1076,  546,  293,  294,
			  295,  296,  297,  298,  299, 1076,  547,  547,  547,  293,
			  294,  295,  296,  297,  298,  299,  548,  548, 1076,  293, yy_Dummy>>,
			1, 200, 2200)
		end

	yy_nxt_template_13 (an_array: ARRAY [INTEGER])
			-- Fill chunk #13 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  294,  295,  296,  297,  298,  299,  158,  158,  158, 1076,
			  549,  549,  549,  293,  294,  295,  296,  297,  298,  299,
			  285, 1076,  158,  285, 1076,  292, 1076, 1076,  275,  276,
			  277,  278,  279,  280,  281,  282,  276,  277,  278,  279,
			  280,  281,  282,  550,  550,  550,  293,  294,  295,  296,
			  297,  298,  299,  286,  165, 1076,  286,  165,  300,  165,
			 1076,  275,  286, 1076,  165,  286,  165,  300, 1076,  165,
			  275,  631,  286, 1076,  158,  286,  165,  300, 1076,  158,
			  275, 1076,  286, 1076, 1076,  286, 1076,  300,  632,  165,
			  275,  165,  286,  158,  158,  286,  165,  300,  165, 1076,

			  275,  165,  286,  633, 1076,  286,  165,  300,  165,  551,
			  275,  165,  293,  294,  295,  296,  297,  298,  299,  286,
			  634, 1076,  286, 1076,  300,  165,  165,  275,  276,  277,
			  278,  279,  280,  281,  282,  276,  277,  278,  279,  280,
			  281,  282,  158,  158,  158,  301,  302,  303,  304,  305,
			  306,  307, 1076,  552,  301,  302,  303,  304,  305,  306,
			  307,  553,  553,  553,  301,  302,  303,  304,  305,  306,
			  307,  554,  554, 1076,  301,  302,  303,  304,  305,  306,
			  307,  555,  555,  555,  301,  302,  303,  304,  305,  306,
			  307,  556,  556,  556,  301,  302,  303,  304,  305,  306, yy_Dummy>>,
			1, 200, 2400)
		end

	yy_nxt_template_14 (an_array: ARRAY [INTEGER])
			-- Fill chunk #14 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  307,  276,  277,  278,  279,  280,  281,  282,  557, 1076,
			 1076,  301,  302,  303,  304,  305,  306,  307,  558,  558,
			  558,  276,  277,  278,  279,  280,  281,  282,  559,  559,
			  559,  276,  277,  278,  279,  280,  281,  282,  106, 1076,
			 1076,  560,  158,  158,  158,  106, 1076, 1076,  107,  165,
			  165,  165,  561,  653,  158,  107,  158,  158,  165,  106,
			  165,  624,  560,  657,  661, 1076,  106,  641,  158,  563,
			  165,  158,  562,  562,  562,  562,  106,  658,  143,  560,
			  613,  613,  614,  614,  106,  654,  165,  560,  165,  165,
			  165,  151,  165,  624,  106,  659,  662,  560, 1076,  642,

			  165, 1076,  165,  165,  106, 1076, 1076,  560, 1076,  660,
			  606,  606,  606,  606,  106, 1076, 1076,  560, 1076, 1076,
			  150, 1076, 1076,  151, 1076,  319,  320,  321,  322,  323,
			  324,  325,  119,  120,  121,  122,  123,  124,  125,  119,
			  120,  121,  122,  123,  124,  125,  319,  320,  321,  322,
			  323,  324,  325,  319,  320,  321,  322,  323,  324,  325,
			  165,  165,  165,  319,  320,  321,  322,  323,  324,  325,
			  564,  319,  320,  321,  322,  323,  324,  325,  565,  565,
			  565,  319,  320,  321,  322,  323,  324,  325,  566,  566,
			 1076,  319,  320,  321,  322,  323,  324,  325,  567,  567, yy_Dummy>>,
			1, 200, 2600)
		end

	yy_nxt_template_15 (an_array: ARRAY [INTEGER])
			-- Fill chunk #15 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  567,  319,  320,  321,  322,  323,  324,  325,  106,  158,
			 1076,  560, 1076,  604,  604,  604,  604, 1076,  106, 1076,
			 1076,  560,  608,  608,  608,  608,  326,  378,  326,  326,
			 1076,  106,  158,  673,  107, 1076,  609,  158, 1076,  679,
			  143,  165,  614,  614,  614,  614, 1076, 1076, 1076,  327,
			 1076,  327,  327,  379,  106, 1076, 1076,  107,  158,  378,
			 1076, 1076,  610, 1076,  165,  674, 1076,  106,  609,  165,
			  107,  680,  158,  342,  343,  344,  345,  346,  347,  348,
			  108,  106,  150, 1076,  107,  621,  621,  621,  621, 1076,
			  165, 1076,  568,  568,  568,  319,  320,  321,  322,  323,

			  324,  325,  569,  108,  165,  319,  320,  321,  322,  323,
			  324,  325,  109, 1076,  106, 1076,  108,  107,  110,  111,
			  112,  113,  114,  115,  116,  393, 1076, 1076,  106,  677,
			  108,  107, 1076,  158,  158,  109,  106, 1076, 1076,  107,
			 1076,  110,  111,  112,  113,  114,  115,  116,  109,  106,
			 1076,  921,  107, 1076,  110,  111,  112,  113,  114,  115,
			  116,  678,  109,  108,  106,  165,  165,  107,  110,  111,
			  112,  113,  114,  115,  116,  106, 1076,  108,  107, 1076,
			  158, 1076,  106,  922, 1076,  107, 1076, 1076, 1076,  106,
			 1076, 1076,  107, 1076, 1076,  109, 1076, 1076,  108,  923, yy_Dummy>>,
			1, 200, 2800)
		end

	yy_nxt_template_16 (an_array: ARRAY [INTEGER])
			-- Fill chunk #16 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			 1076,  110,  111,  112,  113,  114,  115,  116,  106,  109,
			 1076,  107,  165,  108, 1076,  110,  111,  112,  113,  114,
			  115,  116, 1076,  119,  120,  121,  122,  123,  124,  125,
			  109,  924, 1076,  570,  570,  570,  110,  111,  112,  113,
			  114,  115,  116,  106, 1076,  109,  107, 1076,  571,  571,
			  571,  110,  111,  112,  113,  114,  115,  116, 1076,  927,
			 1076, 1076,  119,  120,  121,  122,  123,  124,  125,  119,
			  120,  121,  122,  123,  124,  125,  119,  120,  121,  122,
			  123,  124,  125,  342,  343,  344,  345,  346,  347,  348,
			 1076,  928,  572,  572,  572,  119,  120,  121,  122,  123,

			  124,  125, 1076, 1076,  574,  342,  343,  344,  345,  346,
			  347,  348,  575,  575,  575,  342,  343,  344,  345,  346,
			  347,  348, 1076,  766,  766,  766,  766,  573,  573,  573,
			  119,  120,  121,  122,  123,  124,  125,  580,  576,  576,
			 1076,  342,  343,  344,  345,  346,  347,  348,  581,  770,
			  770,  770,  770, 1076, 1076,  583,  622,  622,  622,  622,
			 1076,  683,  584,  689, 1076,  158,  781,  158,  158,  586,
			  577,  577,  577,  342,  343,  344,  345,  346,  347,  348,
			  587, 1076,  578,  578,  578,  342,  343,  344,  345,  346,
			  347,  348,  588,  684, 1076,  690,  393,  165,  782,  165, yy_Dummy>>,
			1, 200, 3000)
		end

	yy_nxt_template_17 (an_array: ARRAY [INTEGER])
			-- Fill chunk #17 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  165, 1076,  579, 1076, 1076,  342,  343,  344,  345,  346,
			  347,  348,  585,  585,  585,  585,  589, 1076, 1076, 1076,
			  342,  343,  344,  345,  346,  347,  348,  590,  158,  158,
			  787,  342,  343,  344,  345,  346,  347,  348,  342,  343,
			  344,  345,  346,  347,  348,  342,  343,  344,  345,  346,
			  347,  348,  342,  343,  344,  345,  346,  347,  348,  591,
			  165,  165,  788,  342,  343,  344,  345,  346,  347,  348,
			  592,  612,  612,  612,  612,  342,  343,  344,  345,  346,
			  347,  348,  593,  388,  388,  388,  342,  343,  344,  345,
			  346,  347,  348,  594,  889,  158,  628,  158, 1076,  342,

			  343,  344,  345,  346,  347,  348,  595,  165,  665,  165,
			  342,  343,  344,  345,  346,  347,  348,  596,  165,  165,
			  165, 1076, 1076,  617,  597, 1076,  890,  165,  628,  165,
			  165,  598,  935,  764,  764,  764,  764, 1076,  599,  165,
			  666,  165,  342,  343,  344,  345,  346,  347,  348,  600,
			  165,  165,  165,  342,  343,  344,  345,  346,  347,  348,
			  601, 1076,  165, 1076,  936,  342,  343,  344,  345,  346,
			  347,  348, 1076,  765, 1076, 1076,  342,  343,  344,  345,
			  346,  347,  348, 1076,  875,  875,  875,  875, 1076,  342,
			  343,  344,  345,  346,  347,  348, 1076,  158, 1076,  530, yy_Dummy>>,
			1, 200, 3200)
		end

	yy_nxt_template_18 (an_array: ARRAY [INTEGER])
			-- Fill chunk #18 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  342,  343,  344,  345,  346,  347,  348,  342,  343,  344,
			  345,  346,  347,  348,  342,  343,  344,  345,  346,  347,
			  348,  342,  343,  344,  345,  346,  347,  348, 1076,  165,
			  158, 1076,  342,  343,  344,  345,  346,  347,  348, 1076,
			 1076,  158,  705,  342,  343,  344,  345,  346,  347,  348,
			 1076, 1076,  126,  126,  126,  342,  343,  344,  345,  346,
			  347,  348,  165,  126,  126,  126,  342,  343,  344,  345,
			  346,  347,  348,  165,  706,  951,  126,  126,  126,  342,
			  343,  344,  345,  346,  347,  348,  531,  532,  533,  534,
			  535,  536,  537,  276,  277,  278,  279,  280,  281,  282,

			  276,  277,  278,  279,  280,  281,  282,  952,  126,  126,
			  126,  342,  343,  344,  345,  346,  347,  348, 1076,  602,
			  602,  602,  342,  343,  344,  345,  346,  347,  348, 1076,
			  603,  603,  603,  342,  343,  344,  345,  346,  347,  348,
			  390,  390,  390,  390,  630,  633,  158,  165, 1076,  165,
			  390,  390,  390,  390,  390,  390,  165,  693,  165,  165,
			 1076,  158,  634,  165, 1076,  165, 1076, 1076,  165, 1076,
			  640,  876,  876,  876,  876,  165,  630,  633,  165,  165,
			  619,  165,  390,  390,  390,  390,  390,  390,  165,  694,
			  165,  165,  638,  165,  634,  165,  165,  165,  165,  644, yy_Dummy>>,
			1, 200, 3400)
		end

	yy_nxt_template_19 (an_array: ARRAY [INTEGER])
			-- Fill chunk #19 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  165,  165,  640,  165,  158, 1076,  642,  165,  165,  165,
			  165,  165,  165,  165,  165,  646,  165, 1076,  650, 1076,
			  158,  165,  165,  648,  638,  165,  165,  165,  165,  711,
			  165,  644, 1076,  165, 1076,  165,  165,  165,  642,  158,
			  165,  165,  165,  165,  165,  165,  165,  646,  165,  652,
			  650,  815,  165,  165,  165,  648,  654,  165,  165,  165,
			  165,  712,  165,  165,  165,  165,  165,  783,  165,  165,
			  165,  165,  165,  158, 1076,  165,  165,  656,  685,  703,
			  165,  652, 1076,  816, 1076, 1076,  158,  158,  654, 1076,
			 1076, 1076,  165, 1076,  165,  165,  165,  165,  165,  784,

			  165, 1076,  165,  659,  165,  165,  662,  165,  165,  656,
			  686,  704,  165,  165,  165,  165,  165,  660,  165,  165,
			  165,  165,  165,  165,  158,  165,  165,  664,  667,  666,
			  158, 1076,  165,  165, 1076,  659, 1076, 1076,  662, 1076,
			 1076,  668, 1076,  158,  158,  165,  165,  165,  165,  660,
			 1076,  687,  165,  165,  165,  165,  165,  165,  165,  664,
			  669,  666,  165,  674,  165,  165,  165,  669,  165,  672,
			  165,  165,  165,  670,  676,  165,  165,  165,  165,  165,
			  670,  165,  165,  688,  165,  768,  165,  768,  680,  165,
			  769,  769,  769,  769, 1076,  674,  165, 1076,  165,  669, yy_Dummy>>,
			1, 200, 3600)
		end

	yy_nxt_template_20 (an_array: ARRAY [INTEGER])
			-- Fill chunk #20 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  165,  672,  165,  165,  165, 1076,  676, 1076,  678,  165,
			  165,  165,  670,  165,  165,  165,  165,  165,  165,  682,
			  680,  165,  684,  686,  797, 1076,  158,  165,  165,  165,
			  165,  165,  165,  165,  165,  165,  165,  688,  801,  699,
			  678,  165,  165,  158,  158,  165,  165,  165, 1076,  165,
			 1076,  682, 1076,  701,  684,  686,  798,  158,  165,  165,
			 1076,  165,  165,  165,  165,  165,  165,  165,  165,  688,
			  802,  700,  690,  165,  165,  165,  165,  165,  165,  165,
			  165,  165,  165,  692,  165,  702,  165,  695,  694,  165,
			  696,  165,  165,  158,  713,  165,  165,  165,  158,  769,

			  769,  769,  769,  707,  690, 1076, 1076,  165, 1076,  158,
			 1076,  165,  165,  165,  165,  692,  165, 1076,  165,  697,
			  694,  708,  698,  165,  165,  165,  714,  165,  165,  165,
			  165,  697,  158,  158,  698,  709,  700,  702,  704,  165,
			  165,  165,  165,  165,  165,  165,  165,  821,  165,  165,
			  165,  165,  165,  710,  717,  165,  165,  706,  158,  715,
			  165,  165, 1076,  697,  165,  165,  698,  158,  700,  702,
			  704, 1076,  165, 1076,  165,  165,  165,  165,  165,  822,
			  165,  165,  165,  165,  165,  709,  718,  165,  165,  706,
			  165,  716,  165,  165,  165,  165,  165,  165, 1076,  165, yy_Dummy>>,
			1, 200, 3800)
		end

	yy_nxt_template_21 (an_array: ARRAY [INTEGER])
			-- Fill chunk #21 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			 1076,  712,  714,  710,  723,  718,  165,  165,  158,  165,
			 1076,  165,  165, 1076,  165,  158, 1076,  709, 1076,  716,
			  721,  165, 1076, 1076,  165, 1076,  165,  165,  165,  165,
			  165, 1076,  165,  712,  714,  710,  724,  718,  165,  165,
			  165,  165,  165,  165,  165,  720,  165,  165,  165, 1076,
			  165,  716,  722,  165,  724,  165,  165,  722,  158, 1076,
			  165,  165,  165,  165,  165,  725,  727,  165,  960,  158,
			  158, 1076,  726,  165,  165, 1076, 1076,  720,  733,  165,
			  165,  165,  165,  158, 1076, 1076,  724,  165, 1076,  722,
			  165,  165,  165,  165,  379,  165,  514,  726,  728,  165,

			  960,  165,  165,  730,  726,  165,  165,  165,  165,  165,
			  734,  165,  728,  165, 1076,  165,  734,  732,  165,  165,
			  165,  158,  165,  165,  165,  158,  165,  514, 1076, 1076,
			  735,  165,  165,  736, 1076,  730,  165,  514,  165,  165,
			  165,  165,  158,  165,  728,  514,  515, 1076,  734,  732,
			  165,  165,  165,  165,  165,  514,  165,  165,  165,  165,
			  158,  165,  736,  165,  165,  736,  158,  514,  165,  158,
			  775,  165,  530, 1076,  165,  165,  779,  515, 1076,  255,
			  256,  257,  258,  259,  260,  261,  530,  515, 1076, 1076,
			 1076,  165,  165,  165, 1076,  515,  530, 1076,  165, 1076, yy_Dummy>>,
			1, 200, 4000)
		end

	yy_nxt_template_22 (an_array: ARRAY [INTEGER])
			-- Fill chunk #22 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			 1076,  165,  776,  165, 1076,  515,  530, 1076,  780, 1076,
			  255,  256,  257,  258,  259,  260,  261,  515,  530, 1076,
			  255,  256,  257,  258,  259,  260,  261,  538,  255,  256,
			  257,  258,  259,  260,  261,  737,  737,  737,  255,  256,
			  257,  258,  259,  260,  261,  530, 1076,  738,  738,  738,
			  255,  256,  257,  258,  259,  260,  261,  538,  741,  531,
			  532,  533,  534,  535,  536,  537, 1076,  538, 1076,  158,
			  742,  742,  742,  531,  532,  533,  534,  535,  536,  537,
			  743,  743,  538,  531,  532,  533,  534,  535,  536,  537,
			  744,  744,  744,  531,  532,  533,  534,  535,  536,  537,

			  538,  165,  745,  745,  745,  531,  532,  533,  534,  535,
			  536,  537,  538, 1076,  539,  540,  541,  542,  543,  544,
			  545, 1076,  538,  771,  771,  771,  771, 1076, 1076,  746,
			  158, 1076,  531,  532,  533,  534,  535,  536,  537,  880,
			  880,  880,  880,  747,  539,  540,  541,  542,  543,  544,
			  545,  748,  748,  748,  539,  540,  541,  542,  543,  544,
			  545, 1076,  165,  772, 1076, 1076,  749,  749, 1076,  539,
			  540,  541,  542,  543,  544,  545,  773, 1076,  614,  614,
			  614,  614, 1076, 1076,  750,  750,  750,  539,  540,  541,
			  542,  543,  544,  545, 1076,  158,  751,  751,  751,  539, yy_Dummy>>,
			1, 200, 4200)
		end

	yy_nxt_template_23 (an_array: ARRAY [INTEGER])
			-- Fill chunk #23 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  540,  541,  542,  543,  544,  545,  752,  158, 1076,  539,
			  540,  541,  542,  543,  544,  545,  285,  789,  393,  285,
			 1076,  292,  158,  285,  275, 1076,  285,  165,  292,  857,
			  285,  275, 1076,  285,  158,  292,  158,  285,  275,  165,
			  285,  807,  292,  799, 1076,  275, 1076,  285,  158,  790,
			  285, 1076,  292, 1076,  165,  275, 1076,  285, 1076,  777,
			  285,  858,  292, 1076,  286,  275,  165,  286,  165,  300,
			  158,  286,  275,  808,  286,  800,  300, 1076,  286,  275,
			  165,  286, 1076,  300, 1076,  286,  275, 1076,  286, 1076,
			  300,  778, 1076,  275, 1076,  286, 1076, 1076,  286, 1076,

			  300, 1076,  165,  275,  882,  882,  882,  882,  293,  294,
			  295,  296,  297,  298,  299,  293,  294,  295,  296,  297,
			  298,  299,  293,  294,  295,  296,  297,  298,  299,  293,
			  294,  295,  296,  297,  298,  299,  753,  753,  753,  293,
			  294,  295,  296,  297,  298,  299,  754,  754,  754,  293,
			  294,  295,  296,  297,  298,  299,  301,  302,  303,  304,
			  305,  306,  307,  301,  302,  303,  304,  305,  306,  307,
			  301,  302,  303,  304,  305,  306,  307,  301,  302,  303,
			  304,  305,  306,  307,  755,  755,  755,  301,  302,  303,
			  304,  305,  306,  307,  286, 1076, 1076,  286, 1076,  300, yy_Dummy>>,
			1, 200, 4400)
		end

	yy_nxt_template_24 (an_array: ARRAY [INTEGER])
			-- Fill chunk #24 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			 1076, 1076,  275, 1076, 1076, 1076,  561,  791, 1076,  560,
			 1076,  158, 1076,  106,  158, 1076,  560,  158, 1076, 1076,
			  106, 1076, 1076,  560,  795,  793, 1076,  561,  158, 1076,
			  560, 1076,  118,  757,  757,  757,  757,  106,  813,  792,
			  560,  158,  158,  165,  106,  158,  165,  560,  833,  165,
			  805,  106, 1076,  118,  560, 1076,  796,  794,  106, 1076,
			  165,  560,  959,  959,  959,  959, 1076, 1076,  106, 1076,
			  814,  560, 1076,  165,  165, 1076, 1076,  165,  106, 1076,
			  834,  560,  806,  756,  756,  756,  301,  302,  303,  304,
			  305,  306,  307,  319,  320,  321,  322,  323,  324,  325,

			  319,  320,  321,  322,  323,  324,  325,  319,  320,  321,
			  322,  323,  324,  325,  319,  320,  321,  322,  323,  324,
			  325, 1076, 1076, 1076,  319,  320,  321,  322,  323,  324,
			  325,  319,  320,  321,  322,  323,  324,  325,  319,  320,
			  321,  322,  323,  324,  325,  319,  320,  321,  322,  323,
			  324,  325,  758,  758,  758,  319,  320,  321,  322,  323,
			  324,  325,  759,  759,  759,  319,  320,  321,  322,  323,
			  324,  325,  106, 1076, 1076,  107,  763,  763,  763,  763,
			  767,  767,  767,  767, 1076,  106, 1076, 1076,  107, 1076,
			  378, 1076,  106, 1076,  609,  107,  158, 1076, 1076,  106, yy_Dummy>>,
			1, 200, 4600)
		end

	yy_nxt_template_25 (an_array: ARRAY [INTEGER])
			-- Fill chunk #25 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			 1076,  158,  107, 1076,  342,  343,  344,  345,  346,  347,
			  348, 1076,  165, 1076,  165,  158,  379,  851, 1076,  776,
			  610,  108,  378,  158,  165, 1076,  609, 1076,  165,  774,
			  774,  774,  774,  165,  108, 1076, 1076, 1076,  823,  963,
			  963,  963,  963, 1076,  165, 1076,  165,  165, 1076,  852,
			 1076,  776, 1076,  109, 1076,  165,  165, 1076, 1076,  110,
			  111,  112,  113,  114,  115,  116,  109, 1076, 1076,  393,
			  824, 1076,  110,  111,  112,  113,  114,  115,  116,  119,
			  120,  121,  122,  123,  124,  125,  119,  120,  121,  122,
			  123,  124,  125, 1076,  342,  343,  344,  345,  346,  347,

			  348,  342,  343,  344,  345,  346,  347,  348,  342,  343,
			  344,  345,  346,  347,  348,  760,  760,  760,  342,  343,
			  344,  345,  346,  347,  348,  761,  761,  761,  342,  343,
			  344,  345,  346,  347,  348, 1076,  964,  964,  964,  964,
			  158, 1076, 1076,  762,  585,  585,  585,  585,  126,  126,
			  126,  342,  343,  344,  345,  346,  347,  348,  773, 1076,
			  613,  613,  614,  614, 1076, 1076,  622,  622,  622,  622,
			 1076,  151,  165,  126,  126,  126,  342,  343,  344,  345,
			  346,  347,  348,  903,  158, 1076, 1076, 1076,  763,  763,
			  763,  763, 1076,  165, 1076,  165, 1076,  165,  158,  165, yy_Dummy>>,
			1, 200, 4800)
		end

	yy_nxt_template_26 (an_array: ARRAY [INTEGER])
			-- Fill chunk #26 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  393,  778,  873,  151,  780,  165,  393,  809, 1076,  165,
			  966,  966,  966,  966, 1076,  904,  165,  784,  342,  343,
			  344,  345,  346,  347,  348,  165,  165,  165,  165,  165,
			  165,  165, 1076,  778,  873,  782,  780,  165,  165,  810,
			  165,  165,  165,  788,  165,  158,  165,  839,  786,  784,
			  158,  165,  165,  165,  811,  853,  165,  165,  165,  165,
			  165,  158, 1076,  165,  790, 1076, 1076,  782, 1076,  165,
			  165, 1076,  165, 1076,  165,  788,  165,  165,  165,  840,
			  786, 1076,  165,  165,  165,  165,  812,  854,  165,  165,
			  792,  165,  165,  165,  165,  165,  790,  165,  796,  165,

			  794,  165,  817,  798,  165,  165,  158,  165,  165,  165,
			  165, 1076,  802,  165, 1076,  165, 1076,  165,  158,  800,
			  165,  165,  792,  165,  165,  165,  165, 1076, 1076,  165,
			  796,  165,  794,  165,  818,  798,  165,  165,  165,  165,
			  165,  165,  165,  804,  802,  165,  165,  165,  165,  165,
			  165,  800,  165,  165,  165,  165,  165,  165,  165,  165,
			  806,  808,  165,  814,  165,  165,  165,  165,  810,  165,
			  165,  165,  165,  812,  165,  804, 1076, 1076,  165,  165,
			  165,  827,  165, 1076, 1076,  158,  165, 1076,  165, 1076,
			  165,  165,  806,  808,  165,  814,  165, 1076,  165,  165, yy_Dummy>>,
			1, 200, 5000)
		end

	yy_nxt_template_27 (an_array: ARRAY [INTEGER])
			-- Fill chunk #27 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  810,  165,  165,  165,  165,  812,  165,  165,  165,  165,
			  165,  165, 1076,  828,  165,  818,  816,  165,  820,  165,
			  165,  165,  165,  165,  165,  165,  165,  165,  165,  958,
			  958,  958,  958,  165,  165,  158, 1076,  822,  824,  165,
			  165,  165,  165, 1076,  825,  158, 1076,  818,  816, 1076,
			  820,  165,  165,  165,  165,  165,  165,  165,  165,  165,
			  165, 1076,  165,  158,  165,  165,  165,  165,  826,  822,
			  824,  828,  829,  165,  165,  165,  826,  165,  165,  830,
			  165,  165, 1076,  165, 1076,  165,  832,  165,  165,  165,
			  165, 1076,  158,  165,  165,  165,  165, 1076,  165,  165,

			  826,  841, 1076,  828,  830,  165,  165,  165, 1076, 1076,
			  165,  830,  165,  165,  165,  165,  165,  165,  832,  165,
			  165,  165,  165,  158,  165,  165,  165,  834, 1076,  165,
			  165,  165,  165,  842,  165,  835,  158,  158,  165,  165,
			  165,  843, 1076, 1076,  165, 1076,  165,  836,  165, 1076,
			  165,  874,  874,  874,  874,  165, 1076, 1076,  165,  834,
			  838,  165,  158,  165,  165,  165,  165,  836,  165,  165,
			  165,  165,  165,  844,  847,  165,  165,  158,  840,  836,
			  849,  165,  165,  165,  165, 1076,  165,  842,  165,  844,
			  165,  765,  838,  165,  165,  165,  165,  165,  891,  846, yy_Dummy>>,
			1, 200, 5200)
		end

	yy_nxt_template_28 (an_array: ARRAY [INTEGER])
			-- Fill chunk #28 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  165, 1076,  165, 1076,  165,  158,  848,  165, 1076,  165,
			  840, 1076,  850,  165,  165,  165,  165,  158,  165,  842,
			  165,  844,  165,  158, 1076,  165,  855,  850,  165,  165,
			  892,  846,  165,  165,  165,  165,  165,  165,  165,  165,
			  165,  859,  848,  854,  158,  165,  165, 1076,  865,  165,
			  165,  852,  165, 1076,  165,  165,  158, 1076,  856,  850,
			 1076,  165, 1076, 1076,  165,  165,  165,  165,  165,  158,
			  165,  165,  165,  860,  848,  854,  165,  165,  165,  165,
			  866,  165,  165,  852,  165,  856,  165,  165,  165,  165,
			  165,  165,  165,  165,  858,  165,  165,  158,  165,  165,

			  165,  165,  165, 1076,  158,  165, 1076,  863, 1076,  861,
			  165,  165,  860,  165, 1076,  530, 1076,  856,  165,  165,
			  165,  165,  165,  165,  165,  165,  858,  165, 1076,  165,
			  165,  165,  514,  165,  165,  165,  165,  165,  866,  864,
			  905,  862,  862,  158,  860,  165,  864,  514,  165,  165,
			  165,  165,  165,  530,  165,  158,  165,  165,  165,  165,
			  530,  165,  165,  158,  893,  165,  165,  165,  530,  165,
			  866, 1076,  906, 1076,  862,  165, 1076,  165,  864,  530,
			  165,  165,  515,  165, 1076, 1076,  165,  165,  165,  165,
			  165,  165,  530,  165, 1076,  165,  894,  515,  165,  538, yy_Dummy>>,
			1, 200, 5400)
		end

	yy_nxt_template_29 (an_array: ARRAY [INTEGER])
			-- Fill chunk #29 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			 1076,  165,  531,  532,  533,  534,  535,  536,  537,  538,
			  958,  958,  958,  958, 1076,  255,  256,  257,  258,  259,
			  260,  261,  538, 1017, 1017, 1017, 1017, 1076, 1076,  538,
			  255,  256,  257,  258,  259,  260,  261, 1076, 1076,  538,
			  531,  532,  533,  534,  535,  536,  537,  531,  532,  533,
			  534,  535,  536,  537,  538,  531,  532,  533,  534,  535,
			  536,  537,  158,  867,  867,  867,  531,  532,  533,  534,
			  535,  536,  537,  911,  158,  158,  868,  868,  868,  531,
			  532,  533,  534,  535,  536,  537,  539,  540,  541,  542,
			  543,  544,  545, 1076,  165, 1076,  539,  540,  541,  542,

			  543,  544,  545,  158, 1076,  912,  165,  165, 1076,  539,
			  540,  541,  542,  543,  544,  545,  539,  540,  541,  542,
			  543,  544,  545,  869,  869,  869,  539,  540,  541,  542,
			  543,  544,  545,  106, 1076,  165,  560, 1076,  870,  870,
			  870,  539,  540,  541,  542,  543,  544,  545,  285, 1076,
			  895,  285, 1076,  292,  896,  285,  275,  158,  285, 1076,
			  292, 1076,  286,  275, 1076,  286,  158,  300,  945,  286,
			  275,  165,  286,  165,  300,  158,  885,  275,  886,  925,
			  887,  106,  897,  165,  560,  158,  898, 1023,  106,  165,
			 1076,  560, 1076,  118,  871,  871,  871,  871,  165, 1076, yy_Dummy>>,
			1, 200, 5600)
		end

	yy_nxt_template_30 (an_array: ARRAY [INTEGER])
			-- Fill chunk #30 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  946, 1076, 1076,  165, 1076,  165,  872,  165,  886, 1076,
			  886,  926,  888,  610, 1076,  165, 1076,  165, 1076, 1023,
			  319,  320,  321,  322,  323,  324,  325, 1022, 1022, 1022,
			 1022, 1076,  342,  343,  344,  345,  346,  347,  348, 1076,
			  293,  294,  295,  296,  297,  298,  299,  293,  294,  295,
			  296,  297,  298,  299,  301,  302,  303,  304,  305,  306,
			  307,  301,  302,  303,  304,  305,  306,  307,  319,  320,
			  321,  322,  323,  324,  325,  319,  320,  321,  322,  323,
			  324,  325,  342,  343,  344,  345,  346,  347,  348,  342,
			  343,  344,  345,  346,  347,  348,  877,  877,  877,  877,

			  878,  878,  878,  878,  881,  881,  881,  881, 1076, 1076,
			  609,  877,  877,  877,  877,  165,  884,  165,  622,  622,
			  622,  622,  165, 1076,  165,  883, 1076,  165, 1076,  165,
			 1076,  888, 1076,  158,  165, 1076,  610, 1076,  892,  890,
			  879,  165,  609,  165,  772,  165,  158,  165,  165,  165,
			  165, 1076, 1076, 1076,  165,  165,  165,  883,  150,  165,
			  165,  165,  165,  888,  165,  165,  165,  165, 1076,  165,
			  892,  890, 1076,  165,  165,  165,  158,  165,  165,  165,
			  165,  899,  165,  165,  897,  165, 1076,  165,  898,  894,
			 1076,  165,  165,  165,  165,  165,  165,  158,  165,  165, yy_Dummy>>,
			1, 200, 5800)
		end

	yy_nxt_template_31 (an_array: ARRAY [INTEGER])
			-- Fill chunk #31 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  900,  165,  165,  165,  165, 1076,  165, 1076,  165,  158,
			  165,  165, 1076,  900,  165,  165,  897,  165,  901,  909,
			  898,  894,  904,  165,  158,  165,  165,  165,  165,  165,
			  165,  165,  900,  165,  165,  165,  165,  902,  165,  906,
			  907,  165,  165,  165,  158,  165,  165,  165, 1076, 1076,
			  902,  910, 1076, 1076,  904,  908,  165,  165,  165,  158,
			  165, 1076,  165,  165,  165,  165, 1076, 1076,  915,  902,
			  165,  906,  908,  910,  165,  165,  165,  165,  165,  165,
			  165,  165, 1076,  165,  919,  158,  912,  908,  158,  165,
			  165,  165,  158,  165,  165,  991,  165,  913,  158,  165,

			  916,  914,  165,  917,  165,  910,  165,  165, 1076,  918,
			  165,  165,  165,  165,  165,  165,  920,  165,  912,  165,
			  165, 1076,  165, 1076,  165,  165,  165,  992,  165,  914,
			  165,  165,  916,  914,  165,  918,  165,  158,  165,  165,
			  920,  918,  165,  165,  165,  158,  165,  165,  929,  165,
			  922,  165,  158,  165,  165,  165,  947,  937,  165,  165,
			  165,  158,  926,  924,  916,  165,  165, 1076,  165,  165,
			  165,  165,  920,  165,  165, 1076,  165,  165,  165,  165,
			  930,  165,  922,  165,  165,  165,  165,  165,  948,  938,
			  165,  165,  165,  165,  926,  924,  928,  165,  165,  165, yy_Dummy>>,
			1, 200, 6000)
		end

	yy_nxt_template_32 (an_array: ARRAY [INTEGER])
			-- Fill chunk #32 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  165,  165,  165,  165,  158,  165,  165,  930,  165, 1076,
			  165,  165,  932,  931,  165,  165,  165,  158,  165, 1076,
			 1076, 1076,  165,  165,  165,  165,  165, 1076,  928, 1076,
			 1076,  165,  933,  165,  165,  934,  165,  939,  165,  930,
			  165,  158, 1076,  165,  932,  932,  165,  158,  165,  165,
			  165,  936,  938,  940,  165,  165,  165,  165,  165,  165,
			  165,  165,  165,  158,  934,  158,  165,  934,  955,  940,
			  949,  165,  165,  165,  941,  165,  943,  165,  158,  165,
			  158,  942, 1076,  936,  938,  940,  165,  165,  165, 1076,
			 1076,  165,  165,  165,  165,  165, 1076,  165,  165,  158,

			  956, 1076,  950,  165,  165, 1076,  942,  165,  944,  165,
			  165,  944,  165,  942,  165,  165,  165,  165,  165,  165,
			  165,  165,  946,  165, 1076,  158,  165,  165,  950,  948,
			  165,  165,  165,  165,  165, 1076, 1076,  973, 1076,  165,
			 1076,  165,  530,  944,  165, 1076,  165,  165,  165,  165,
			  165,  165,  165,  165,  946,  165,  530,  165,  165,  165,
			  950,  948,  165,  538,  165,  165,  165,  952,  954,  974,
			  165,  165,  165,  165,  953,  165,  165,  165,  158,  165,
			  538,  165,  165,  165,  165,  158,  956,  165, 1040,  106,
			  971,  165,  560,  165,  158,  165,  165, 1076, 1076,  952, yy_Dummy>>,
			1, 200, 6200)
		end

	yy_nxt_template_33 (an_array: ARRAY [INTEGER])
			-- Fill chunk #33 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  954,  118,  165, 1076,  165,  165,  954,  165, 1076,  165,
			  165,  165, 1076,  165,  165, 1076,  165,  165,  956,  165,
			 1041, 1076,  972,  165, 1076,  165,  165,  165,  165,  531,
			  532,  533,  534,  535,  536,  537, 1076,  165,  965,  965,
			  965,  965,  158,  531,  532,  533,  534,  535,  536,  537,
			  539,  540,  541,  542,  543,  544,  545,  957, 1076,  957,
			 1076, 1076,  958,  958,  958,  958, 1076,  539,  540,  541,
			  542,  543,  544,  545,  165, 1076,  319,  320,  321,  322,
			  323,  324,  325,  958,  958,  958,  958,  877,  877,  877,
			  877,  962,  962,  962,  962,  965,  965,  965,  965, 1076,

			  967,  961,  967, 1076,  158,  965,  965,  965,  965, 1076,
			  969,  969,  969,  969,  165,  975,  165, 1076,  972,  158,
			  165, 1076,  165,  765,  970,  165,  165,  165,  158,  974,
			  979,  879,  165,  961,  977,  772,  165,  165, 1076, 1076,
			  158,  165, 1076,  165, 1076, 1076,  165,  976,  165,  976,
			  972,  165,  165,  165,  165,  983,  970,  165,  165,  165,
			  165,  974,  980,  158,  165,  165,  978,  165,  165,  165,
			  165,  978,  165,  165,  165,  165,  165,  165,  984,  981,
			  165,  976,  980,  158,  158,  165,  165,  984, 1076,  165,
			 1076,  165,  165, 1076,  165,  165,  158,  165,  982,  165, yy_Dummy>>,
			1, 200, 6400)
		end

	yy_nxt_template_34 (an_array: ARRAY [INTEGER])
			-- Fill chunk #34 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  165,  165,  165,  978,  165,  165,  165,  165,  165,  165,
			  984,  982,  165,  158,  980,  165,  165,  165,  165,  987,
			  165,  165,  165,  165,  165,  985,  165,  158,  165,  158,
			  982,  986,  165,  165, 1076,  988,  165,  165,  165,  165,
			  165,  165, 1076,  165, 1076,  165,  165, 1076,  165,  165,
			  165,  988,  165,  165,  165,  158,  989,  986,  165,  165,
			  158,  165,  990,  986,  165,  158,  995,  988, 1065,  165,
			  165,  165,  165,  165,  165,  165,  165,  165,  165,  165,
			  165,  165,  165, 1076,  992,  165,  165,  165,  990,  165,
			  165,  158,  165,  165,  990,  994,  993,  165,  996, 1076,

			 1066,  165,  165,  165,  165,  165,  165, 1076,  165,  165,
			  996,  165,  999,  165,  165,  158,  992, 1076,  165, 1076,
			  158,  165,  158,  165,  158,  165,  997,  994,  994, 1076,
			 1076,  165, 1003,  165,  165, 1001,  165,  165, 1000,  998,
			 1076, 1076,  996,  165, 1000, 1076,  165,  165,  158,  165,
			  158,  165,  165, 1005,  165, 1007,  165, 1076,  998, 1076,
			  165,  165,  165,  165, 1004,  165, 1076, 1002, 1002, 1076,
			 1000,  998,  165, 1076,  165,  165,  165,  165, 1076,  165,
			  165,  165,  165,  165, 1004, 1006,  165, 1008,  158,  165,
			 1076,  158,  165,  165,  165,  165, 1013, 1006, 1009, 1011, yy_Dummy>>,
			1, 200, 6600)
		end

	yy_nxt_template_35 (an_array: ARRAY [INTEGER])
			-- Fill chunk #35 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			 1002,  165,  158, 1008,  165, 1076,  165,  165,  165,  165,
			  165,  165,  165,  165, 1028, 1076, 1004, 1010,  165,  158,
			  165,  165,  165,  165,  165, 1076,  165,  165, 1014, 1006,
			 1010, 1012, 1076,  165,  165, 1008,  165, 1076,  165,  165,
			  165,  165,  165,  165,  165,  165, 1029, 1076,  158, 1010,
			  165,  165,  158,  165,  165,  165,  165,  165,  165, 1015,
			 1076, 1046,  165, 1030, 1014,  158, 1076,  165,  165,  165,
			  165,  165,  165,  165,  165,  165,  165, 1012,  165, 1036,
			  165,  165,  165, 1076,  165,  165,  158,  165,  165,  165,
			  165, 1016,  165, 1047,  165, 1031, 1014,  165, 1016,  165,

			 1076,  165,  165,  165, 1076, 1076,  165, 1076,  165, 1012,
			  165, 1037, 1076,  165, 1021, 1021, 1021, 1021,  165, 1076,
			  165, 1018,  165, 1018,  165, 1076, 1019, 1019, 1019, 1019,
			 1016, 1020, 1076, 1020,  165, 1076, 1021, 1021, 1021, 1021,
			 1024, 1024, 1024, 1024,  965,  965,  965,  965, 1025, 1025,
			 1025, 1025,  158, 1026,  879, 1026, 1076, 1029, 1027, 1027,
			 1027, 1027, 1023, 1067,  165,  165,  165,  165,  165,  158,
			  165,  165, 1031, 1033, 1032, 1076,  165,  165, 1076,  165,
			  165,  165, 1034,  165,  165, 1038, 1076,  158,  610, 1029,
			  158,  165, 1076, 1076, 1023, 1068,  165,  165,  165,  165, yy_Dummy>>,
			1, 200, 6800)
		end

	yy_nxt_template_36 (an_array: ARRAY [INTEGER])
			-- Fill chunk #36 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  165,  165,  165,  165, 1031, 1033, 1033, 1076,  165,  165,
			 1035,  165,  165,  165, 1035,  165, 1037, 1039,  165,  165,
			  165, 1039,  165,  165, 1076, 1041,  165,  165,  165,  165,
			  165,  165,  165,  165,  165,  165, 1076,  165,  165, 1076,
			 1076,  165, 1035, 1076,  165,  165, 1076, 1042, 1037,  158,
			  165, 1076,  165, 1039, 1076, 1076, 1076, 1041,  165,  165,
			  165,  165,  165,  165,  165,  165,  165,  165, 1076,  165,
			  165, 1076,  165,  165,  165, 1043,  165,  165, 1076, 1043,
			  165,  165,  165,  165,  165,  165,  158,  165, 1076, 1045,
			  158, 1044,  165, 1050, 1047,  165, 1048,  158, 1076,  165,

			 1076,  165, 1076,  165,  165, 1076,  165, 1043,  165, 1076,
			  165, 1049,  165,  165,  165,  165,  165,  165,  165,  165,
			  165, 1045,  165, 1045,  165, 1051, 1047,  165, 1049,  165,
			 1051,  165, 1052,  165,  165,  165,  165,  165,  158,  165,
			  165, 1055,  165, 1049, 1053,  165,  165, 1054,  165,  165,
			  165,  158,  165,  165, 1056,  165, 1076, 1076,  158, 1076,
			  165, 1076, 1051,  158, 1053,  165,  165, 1076,  165,  165,
			  165,  165, 1069, 1055, 1076, 1076, 1053, 1076,  165, 1055,
			  165,  165,  165,  165, 1057,  165, 1057,  165, 1076, 1076,
			  165,  165,  165,  165,  165,  165,  165,  165, 1019, 1019, yy_Dummy>>,
			1, 200, 7000)
		end

	yy_nxt_template_37 (an_array: ARRAY [INTEGER])
			-- Fill chunk #37 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			 1019, 1019, 1076,  165, 1070, 1076,  165, 1058, 1058, 1058,
			 1058, 1021, 1021, 1021, 1021, 1076, 1057, 1021, 1021, 1021,
			 1021, 1076, 1076,  165, 1076,  165,  165, 1076,  165, 1059,
			 1059, 1059, 1059, 1063, 1060,  165, 1060,  158,  165, 1061,
			 1061, 1061, 1061,  964,  964,  964,  964,  765, 1027, 1027,
			 1027, 1027, 1062, 1062, 1062, 1062,  165, 1023,  165,  165,
			 1076,  165,  165, 1064,  165, 1064, 1076, 1076,  165,  165,
			  165,  165,  165, 1066,  165,  165, 1061, 1061, 1061, 1061,
			 1076, 1076,  165,  610, 1076,  165, 1076, 1076,  165, 1023,
			  165,  165,  772,  165,  165, 1064,  165,  165, 1076,  165,

			  165, 1076,  165,  165,  165, 1066,  165,  165,  165,  165,
			  165,  165, 1076,  165,  165, 1076,  165,  165,  165, 1076,
			  165, 1076, 1071,  165, 1068,  165,  158,  165,  165,  165,
			 1076,  165,  165, 1076,  165, 1074, 1076,  165, 1070,  158,
			  165,  165,  165,  165,  165,  165, 1076, 1076,  165,  165,
			  165,  165,  165, 1076, 1072,  165, 1068,  165,  165,  165,
			  165,  165, 1076, 1076,  165, 1072,  165, 1075, 1076,  165,
			 1070,  165,  165,  165,  165,  165,  165,  165, 1076,  165,
			 1076,  165, 1076,  165,  165,  165, 1076, 1076, 1076,  165,
			 1076, 1076, 1076,  165, 1076, 1076, 1076, 1072, 1017, 1017, yy_Dummy>>,
			1, 200, 7200)
		end

	yy_nxt_template_38 (an_array: ARRAY [INTEGER])
			-- Fill chunk #38 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			 1017, 1017, 1076, 1076,  165,  165,  165,  165, 1076,  165,
			 1076,  165, 1073, 1073, 1073, 1073,  165,  165, 1076, 1076,
			 1076,  165, 1024, 1024, 1024, 1024, 1075,  165, 1076,  165,
			 1076, 1076,  165,  165,  165,  165, 1076, 1076,  765,  165,
			 1076,  165, 1076,  165,  165,  165, 1076, 1076,  165, 1076,
			  165, 1076,  879,  165, 1059, 1059, 1059, 1059, 1075,  165,
			  165,  165,  772, 1076,  165,  165,  165,  165, 1076, 1076,
			 1076,  165,  165,  165,  165,  165,  165,  165, 1076, 1076,
			  165, 1076,  165, 1076,  165,  165, 1076, 1076, 1076, 1076,
			 1076, 1076,  165, 1076,  879, 1076, 1076, 1076, 1076, 1076,

			 1076, 1076, 1076, 1076,  165, 1076,  165, 1076, 1076, 1076,
			 1076, 1076, 1076, 1076, 1076, 1076,  165,   87,   87,   87,
			   87,   87,   87,   87,   87,   87,   87,   87,   87,   87,
			   87,   87,   87,   87,   87,   87,   87,   87,   87,   87,
			  105,  105, 1076,  105,  105,  105,  105,  105,  105,  105,
			  105,  105,  105,  105,  105,  105,  105,  105,  105,  105,
			  105,  105,  105,  117, 1076, 1076, 1076, 1076, 1076, 1076,
			  117,  117,  117,  117,  117,  117,  117,  117,  117,  117,
			  117,  117,  117,  117,  117,  117,  118,  118, 1076,  118,
			  118,  118,  118,  118,  118,  118,  118,  118,  118,  118, yy_Dummy>>,
			1, 200, 7400)
		end

	yy_nxt_template_39 (an_array: ARRAY [INTEGER])
			-- Fill chunk #39 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  118,  118,  118,  118,  118,  118,  118,  118,  118,  126,
			  126, 1076,  126,  126,  126,  126, 1076,  126,  126,  126,
			  126,  126,  126,  126,  126,  126,  126,  126,  126,  126,
			  126,  126,  146,  146,  146,  146,  146,  146,  146,  146,
			  146, 1076,  146,  146,  146,  146,  254,  254, 1076,  254,
			  254,  254, 1076, 1076,  254,  254,  254,  254,  254,  254,
			  254,  254,  254, 1076,  254,  254,  254,  254,  254,  165,
			  165,  165,  165,  165,  165,  165,  165, 1076,  165,  165,
			  165,  165,  165,  275, 1076, 1076,  275, 1076,  275,  275,
			  275,  275,  275,  275,  275,  275,  275,  275,  275,  275,

			  275,  275,  275,  275,  275,  275,  289,  289, 1076,  289,
			  289,  289,  289,  289,  289,  289,  289,  289,  289,  289,
			  289,  289,  289,  289,  289,  289,  289,  289,  289,  290,
			  290, 1076,  290,  290,  290,  290,  290,  290,  290,  290,
			  290,  290,  290,  290,  290,  290,  290,  290,  290,  290,
			  290,  290,  314,  314, 1076,  314,  314,  314,  314,  314,
			  314,  314,  314,  314,  314,  314,  314,  314,  314,  314,
			  314,  314,  314,  314,  314,  340, 1076, 1076, 1076, 1076,
			  340,  340,  340,  340,  340,  340,  340,  340,  340,  340,
			  340,  340,  340,  340,  340,  340,  340,  340,  380,  380, yy_Dummy>>,
			1, 200, 7600)
		end

	yy_nxt_template_40 (an_array: ARRAY [INTEGER])
			-- Fill chunk #40 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  380,  380,  380,  380,  380,  380, 1076,  380,  380,  380,
			  380,  380,  380,  380,  380,  380,  380,  380,  380,  380,
			  380,  387,  387,  387,  387,  387,  387,  387,  387, 1076,
			  387,  387,  387,  387,  389,  389,  389,  389,  389,  389,
			  389,  389, 1076,  389,  389,  389,  389,  391,  391,  391,
			  391,  391,  391,  391,  391, 1076,  391,  391,  391,  391,
			  285,  285, 1076,  285,  285,  285, 1076,  285,  285,  285,
			  285,  285,  285,  285,  285,  285,  285,  285,  285,  285,
			  285,  285,  285,  286,  286, 1076,  286,  286,  286, 1076,
			  286,  286,  286,  286,  286,  286,  286,  286,  286,  286,

			  286,  286,  286,  286,  286,  286,  968,  968,  968,  968,
			  968,  968,  968,  968, 1076,  968,  968,  968,  968,  968,
			  968,  968,  968,  968,  968,  968,  968,  968,  968,    5,
			 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076,
			 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076,
			 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076,
			 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076,
			 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076,
			 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076,
			 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, yy_Dummy>>,
			1, 200, 7800)
		end

	yy_nxt_template_41 (an_array: ARRAY [INTEGER])
			-- Fill chunk #41 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076,
			 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076,
			 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, yy_Dummy>>,
			1, 30, 8000)
		end

	yy_chk_template: SPECIAL [INTEGER]
			-- Template for `yy_chk'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 8029)
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
			yy_chk_template_12 (an_array)
			yy_chk_template_13 (an_array)
			yy_chk_template_14 (an_array)
			yy_chk_template_15 (an_array)
			yy_chk_template_16 (an_array)
			yy_chk_template_17 (an_array)
			yy_chk_template_18 (an_array)
			yy_chk_template_19 (an_array)
			yy_chk_template_20 (an_array)
			yy_chk_template_21 (an_array)
			yy_chk_template_22 (an_array)
			yy_chk_template_23 (an_array)
			yy_chk_template_24 (an_array)
			yy_chk_template_25 (an_array)
			yy_chk_template_26 (an_array)
			yy_chk_template_27 (an_array)
			yy_chk_template_28 (an_array)
			yy_chk_template_29 (an_array)
			yy_chk_template_30 (an_array)
			yy_chk_template_31 (an_array)
			yy_chk_template_32 (an_array)
			yy_chk_template_33 (an_array)
			yy_chk_template_34 (an_array)
			yy_chk_template_35 (an_array)
			yy_chk_template_36 (an_array)
			yy_chk_template_37 (an_array)
			yy_chk_template_38 (an_array)
			yy_chk_template_39 (an_array)
			yy_chk_template_40 (an_array)
			yy_chk_template_41 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_chk_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_chk'.
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
			   26,  146,   26,   26,   26,   26,   30,   30,   32,   32,
			 1024,   12,   46,   26,   12,   37,   46, 1017,   15,   37,
			   16,   15,   16,   16,   40,   37,  620,   27,   16,   27,
			   27,   27,   27,   42,  158,   38,  618,    3,   38,   42,
			   38,  151,   26,  146,   46,   26,  616,   37,   46,    4,
			   38,   37,   45,   80,   80,   80,  391,   37,   83,   83,
			   12,   45,   24,   51,   51,   42,  158,   38,    3,   27,
			   38,   42,   38,    3,    3,    3,    3,    3,    3,    3, yy_Dummy>>,
			1, 200, 0)
		end

	yy_chk_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			    4,  389,   38,  151,   45,    4,    4,    4,    4,    4,
			    4,    4,   12,   45,  387,   51,   51,  351,   12,   12,
			   12,   12,   12,   12,   12,   15,   15,   15,   15,   15,
			   15,   15,   16,   16,   16,   16,   16,   16,   16,   25,
			   43,   25,   25,   25,   25,  268,   43,   39,  175,  175,
			   35,   39,   25,   25,   35,   39,   35,   52,   47,   35,
			   49,   35,   47,   52,   39,   49,   35,   35,   47,  192,
			   48,   48,   43,   47,   25,   82,   82,   82,   43,   39,
			   48,   25,   35,   39,   25,   25,   35,   39,   35,   52,
			   47,   35,   49,   35,   47,   52,   39,   49,   35,   35,

			   47,  192,   48,   48,  385,   47,   25,   34,   34,   34,
			   34,  263,   48,   84,   84,   84,  207,   34,   34,   34,
			   34,   34,   34,   34,   34,   34,   34,   34,   34,   34,
			   34,   34,   34,   34,   34,   34,   34,   34,   34,   34,
			   34,   34,   34,   85,   85,   85,  385,   34,  207,   34,
			   34,   34,   34,   34,   34,   34,   34,   34,   34,   34,
			   34,   34,   34,   34,   34,   34,   34,   34,   34,   34,
			   34,   34,   34,   34,   34,  145,  210,  145,  145,  145,
			  145,   34,   34,   34,   34,   34,   34,   34,   36,   36,
			   44,   88,   36,   88,   88,   36,   41,   44,   36,   41, yy_Dummy>>,
			1, 200, 200)
		end

	yy_chk_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			   44,   36,   44,   41,   41,   50,   44,  178,  210,   41,
			  160,  162,  224,   50,  160,  173,  162,  145,  127,   50,
			   36,   36,   44,  103,   36,  265,  265,   36,   41,   44,
			   36,   41,   44,   36,   44,   41,   41,   50,   44,  147,
			  147,   41,  160,  162,  224,   50,  160,   88,  162,  240,
			   61,   50,   57,   57,   57,   57,   57,   57,   57,   58,
			   61,  240,   64,   58,   64,   69,  161,   69,   58,  161,
			   58,   69,   59,  246,   64,   58,   58,   69,   88,  147,
			  101,  240,   61,   87,   87,   87,   87,   87,   87,   87,
			   86,   58,   61,  240,   64,   58,   64,   69,  161,   69,

			   58,  161,   58,   69,   59,  246,   64,   58,   58,   69,
			   61,   61,   61,   61,   61,   61,   61,  148,  148,  148,
			   81,   58,   58,   58,   58,   58,   58,   58,   59,   59,
			   59,   59,   59,   59,   59,   60,  399,  159,   66,   60,
			  163,   66,   60,   66,   66,   60,  159,   62,   60,   62,
			  163,  402,  203,   66,  172,  172,  172,  148,  203,   62,
			   94,   94,   94,   94,   94,   94,   94,   60,  399,  159,
			   66,   60,  163,   66,   60,   66,   66,   60,  159,   62,
			   60,   62,  163,  402,  203,   66,  174,  174,  174,   54,
			  203,   62,   60,   60,   60,   60,   60,   60,   60,   33, yy_Dummy>>,
			1, 200, 400)
		end

	yy_chk_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			   62,   62,   62,   62,   62,   62,   62,   63,   65,   28,
			   67,   63,   67,   67,   65,   65,   65,  164,   63,   68,
			   63,   65,   67,  181,   63,   11,   65,  181,  164,   68,
			   63,   68,  176,  176,  176,   68,  177,  177,  177,   63,
			   65,   68,   67,   63,   67,   67,   65,   65,   65,  164,
			   63,   68,   63,   65,   67,  181,   63,   70,   65,  181,
			  164,   68,   63,   68,   70,   71,   70,   68,  143,  143,
			  143,  143,   71,   68,   71,   71,   70,   72,   10,  208,
			   71,   72,  143,   72,   71,  404,  208,   72,   73,   70,
			   73,  386,  386,   72,    9,  182,   70,   71,   70,    7,

			   73,    5,    0,  182,   71,    0,   71,   71,   70,   72,
			   74,  208,   71,   72,  143,   72,   71,  404,  208,   72,
			   73,   74,   73,   74,   74,   72,   76,  182,   76,   76,
			   75,  386,   73,   74,   75,  182,   75,   91,   76,   91,
			   91,  184,   74,  414,    0,  184,   75,   90,   90,   90,
			   90,    0,    0,   74,    0,   74,   74,    0,   76,    0,
			   76,   76,   75,    0,   92,   74,   75,   92,   75,   92,
			   76,   93,   92,  184,   93,  414,   93,  184,   75,   93,
			   95,   95,   95,   95,   95,   95,   95,   95,  262,  262,
			  262,   97,   97,   91,   97,   97,   97,   97,   97,   97, yy_Dummy>>,
			1, 200, 600)
		end

	yy_chk_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			   97,  434,    0,   90,   96,   96,   96,   96,   96,   96,
			   96,   96,   96,   96,   98,   98,   98,   98,   98,   98,
			   98,   98,   98,   98,   91,  264,  264,  264,  266,  266,
			  266,    0,  105,  434,   90,  105,  267,  267,  267,   90,
			   90,   90,   90,   90,   90,   90,   99,   99,   99,   99,
			   99,   99,   99,   99,   99,   99,   92,   92,   92,   92,
			   92,   92,   92,   93,   93,   93,   93,   93,   93,   93,
			  100,    0,  179,  100,  100,  100,  100,  100,  100,  100,
			    0,  105,    0,  179,  215,  108,  215,  108,  108,    0,
			  108,    0,  144,  108,  144,  144,  144,  144,  109,    0,

			  109,  109,    0,  109,  179,  144,  109,    0,    0,  183,
			  269,  269,  269,  105,  183,  179,  215,    0,  215,  105,
			  105,  105,  105,  105,  105,  105,  107,  451,    0,  107,
			  107,  107,  107,    0,  144,  615,  615,  144,  107,  108,
			  110,  183,  470,  110,    0,  107,  183,  107,    0,  107,
			  107,  107,  109,    0,  107,  111,  107,    0,  111,  451,
			  107,    0,  107,    0,    0,  107,  107,  107,  107,  107,
			  107,  108,    0,  112,  470,  615,  112,  108,  108,  108,
			  108,  108,  108,  108,  109,  118,    0,    0,  118,  110,
			  109,  109,  109,  109,  109,  109,  109,  270,  270,  270, yy_Dummy>>,
			1, 200, 800)
		end

	yy_chk_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  113,    0,    0,  113,  111,  271,  271,  271,  272,  272,
			  272,    0,    0,  107,  107,  107,  107,  107,  107,  107,
			  114,  110,  112,  114,  273,  273,  273,  110,  110,  110,
			  110,  110,  110,  110,  115,    0,  111,  115,  274,  274,
			  274,  111,  111,  111,  111,  111,  111,  111,  111,  113,
			  116,    0,    0,  116,  112,    0,    0,  112,  112,  112,
			  112,  112,  112,  112,  112,  112,  112,  119,  201,  114,
			  119,  201,  118,  118,  118,  118,  118,  118,  118,  120,
			    0,  113,  120,  115,  113,  113,    0,  113,  113,  113,
			  113,  113,  113,  113,  121,    0,  494,  121,  502,  116,

			  201,  114,    0,  201,  114,  114,  114,  114,  114,  114,
			  114,  114,  114,  114,  122,  115,    0,  122,  115,  115,
			  115,  115,  115,  115,  115,  115,  115,  115,  494,  123,
			  502,  116,  123,    0,  116,    0,    0,  116,  116,  116,
			  116,  116,  116,  116,  124,    0,    0,  124,  139,  139,
			  139,  139,    0,    0,  119,  119,  119,  119,  119,  119,
			  119,  125,  139,    0,  125,  120,  120,  120,  120,  120,
			  120,  120,  120,  126,  379,  379,  379,  379,  121,  121,
			  121,  121,  121,  121,  121,  121,  121,  121,  139,    0,
			    0,  229,  506,  512,  139,  229,    0,    0,  122,  122, yy_Dummy>>,
			1, 200, 1000)
		end

	yy_chk_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			    0,  122,  122,  122,  122,  122,  122,  122,  283,    0,
			  283,  283,    0,  123,  123,  123,  123,  123,  123,  123,
			  123,  123,  123,  229,  506,  512,  130,  229,  124,  124,
			  124,  124,  124,  124,  124,  124,  124,  124,  129,  150,
			  223,  150,  150,  150,  150,  125,  223,  632,  125,  125,
			  125,  125,  125,  125,  125,  131,  126,  126,  126,  126,
			  126,  126,  126,  128,  283,    0,  128,  128,  128,  128,
			    0,    0,  223,    0,    0,  128,    0,  132,  223,  632,
			    0,  150,  128,    0,  128,  219,  128,  128,  128,  128,
			  133,  128,    0,  128,    0,  283,  219,  128,    0,  128,

			  134,    0,  128,  128,  128,  128,  128,  128,  130,  130,
			  130,  130,  130,  130,  130,  130,  135,  219,  129,  129,
			  129,  129,  129,  129,  129,  129,  129,  129,  219,  388,
			  388,  388,  408,  408,  408,  131,  131,  131,  131,  131,
			  131,  131,  131,  131,  131,  409,  409,  409,    0,    0,
			  128,  128,  128,  128,  128,  128,  128,  132,  132,    0,
			  132,  132,  132,  132,  132,  132,  132,    0,    0,  388,
			  133,  133,  133,  133,  133,  133,  133,  133,  133,  133,
			  134,  134,  134,  134,  134,  134,  134,  134,  134,  134,
			  410,  410,  410,    0,  234,  653,  135,    0,  234,  135, yy_Dummy>>,
			1, 200, 1200)
		end

	yy_chk_template_8 (an_array: ARRAY [INTEGER])
			-- Fill chunk #8 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  135,  135,  135,  135,  135,  135,  149,  149,  149,  149,
			  165,    0,  165,  411,  411,  411,  149,  149,  149,  149,
			  149,  149,  165,  166,  167,  166,  234,  653,  195,  166,
			  234,  167,    0,  167,    0,  166,    0,    0,  195,  412,
			  412,  412,  165,  167,  165,    0,  149,    0,  149,  149,
			  149,  149,  149,  149,  165,  166,  167,  166,  169,  168,
			  195,  166,  168,  167,  168,  167,  169,  166,  169,  170,
			  195,  170,  667,  671,  168,  167,  170,  171,  169,  171,
			  180,  170,  180,    0,  185,  171,    0,    0,  180,  171,
			  169,  168,  180,  185,  168,    0,  168,    0,  169,    0,

			  169,  170,    0,  170,  667,  671,  168,    0,  170,  171,
			  169,  171,  180,  170,  180,  202,  185,  171,  187,  186,
			  180,  171,    0,  202,  180,  185,  186,  189,  186,  187,
			  188,  187,  188,  190,  189,  190,  189,  394,  186,  190,
			    0,  187,  188,  394,    0,  190,  189,  202,    0,    0,
			  187,  186,  413,  413,  413,  202,    0,    0,  186,  189,
			  186,  187,  188,  187,  188,  190,  189,  190,  189,  394,
			  186,  190,  191,  187,  188,  394,  191,  190,  189,  191,
			  194,  193,  194,  196,  221,  193,  683,  687,  196,  197,
			  191,  193,  194,  193,  221,  198,  197,  198,  196,  193, yy_Dummy>>,
			1, 200, 1400)
		end

	yy_chk_template_9 (an_array: ARRAY [INTEGER])
			-- Fill chunk #9 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  197,    0,  198,  193,  191,  689,    0,  198,  191,    0,
			    0,  191,  194,  193,  194,  196,  221,  193,  683,  687,
			  196,  197,  191,  193,  194,  193,  221,  198,  197,  198,
			  196,  193,  197,  199,  198,  193,  398,  689,  200,  198,
			  200,  199,  200,  199,  398,  204,  200,  204,  199,    0,
			  200,  222,  206,  199,  206,  206,  222,  204,  205,  422,
			  522,  522,  522,    0,  206,  199,    0,  422,  398,  205,
			  200,  205,  200,  199,  200,  199,  398,  204,  200,  204,
			  199,  205,  200,  222,  206,  199,  206,  206,  222,  204,
			  205,  422,  211,  209,  211,  209,  206,  209,  209,  422,

			  214,  205,  214,  205,  211,  212,  235,  212,  209,  212,
			  239,  209,  214,  205,  239,  235,  396,  212,  523,  523,
			  523,  396,    0,    0,  211,  209,  211,  209,    0,  209,
			  209,    0,  214,    0,  214,    0,  211,  212,  235,  212,
			  209,  212,  239,  209,  214,  216,  239,  235,  396,  212,
			  213,  216,  213,  396,  213,  249,    0,  216,  213,  249,
			  213,  217,  217,  245,  217,  213,  448,  218,  213,  448,
			  213,  693,  245,  220,  217,  220,  218,  216,  218,  218,
			    0,  220,  213,  216,  213,  220,  213,  249,  218,  216,
			  213,  249,  213,  217,  217,  245,  217,  213,  448,  218, yy_Dummy>>,
			1, 200, 1600)
		end

	yy_chk_template_10 (an_array: ARRAY [INTEGER])
			-- Fill chunk #10 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  213,  448,  213,  693,  245,  220,  217,  220,  218,  696,
			  218,  218,  225,  220,  225,  226,  416,  220,  227,  225,
			  218,  251,  416,  226,  225,  226,  228,  227,  228,  227,
			  251,  468,    0,  230,    0,  226,    0,  468,  228,  227,
			  230,  696,  230,    0,  225,    0,  225,  226,  416,    0,
			  227,  225,  230,  251,  416,  226,  225,  226,  228,  227,
			  228,  227,  251,  468,  236,  230,  236,  226,  236,  468,
			  228,  227,  230,  231,  230,  231,  236,  243,  231,  237,
			  237,  237,  243,  231,  230,  418,  231,  426,  231,  231,
			    0,  237,    0,  243,  233,  418,  236,  233,  236,  426,

			  236,  233,  524,  524,  524,  231,    0,  231,  236,  243,
			  231,  237,  237,  237,  243,  231,    0,  418,  231,  426,
			  231,  231,  232,  237,  232,  243,  233,  418,    0,  233,
			  232,  426,  232,  233,  238,  232,  238,  232,  232,  428,
			  238,  241,  232,  242,  250,  242,  238,  428,  241,    0,
			  241,  250,  242,  250,  232,  242,  232,  525,  525,  525,
			  241,    0,  232,  250,  232,    0,  238,  232,  238,  232,
			  232,  428,  238,  241,  232,  242,  250,  242,  238,  428,
			  241,  244,  241,  250,  242,  250,  244,  242,  247,  244,
			  247,  244,  241,  248,  247,  250,  248,  244,  248,  254, yy_Dummy>>,
			1, 200, 1800)
		end

	yy_chk_template_11 (an_array: ARRAY [INTEGER])
			-- Fill chunk #11 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  247,  244,  424,  252,  454,  252,  255,  685,  248,  252,
			  685,  424,  454,  244,  256,  252,    0,    0,  244,    0,
			  247,  244,  247,  244,  257,  248,  247,    0,  248,  244,
			  248,    0,  247,  244,  424,  252,  454,  252,    0,  685,
			  248,  252,  685,  424,  454,    0,  378,  252,  378,  254,
			  285,  378,  378,  378,  378,    0,  255,  275,  275,  275,
			  275,  275,  275,  275,  256,  258,  276,  276,  276,  276,
			  276,  276,  276,    0,  257,  259,  526,  526,  526,    0,
			  286,    0,  254,  254,  254,  254,  254,  254,  254,  255,
			  255,  255,  255,  255,  255,  255,  256,  256,  256,  256,

			  256,  256,  256,  256,  257,  257,  257,  257,  257,  257,
			  257,  257,  257,  257,    0,  258,  260,  277,  277,  277,
			  277,  277,  277,  277,  277,  259,  261,  278,  278,  278,
			  278,  278,  278,  278,  278,  278,  278,  285,  285,  285,
			  285,  285,  285,  285,    0,  258,  258,    0,  258,  258,
			  258,  258,  258,  258,  258,  259,  259,  259,  259,  259,
			  259,  259,  259,  259,  259,    0,  260,  286,  286,  286,
			  286,  286,  286,  286,  279,  279,  261,  279,  279,  279,
			  279,  279,  279,  279,  280,  280,  280,  280,  280,  280,
			  280,  280,  280,  280,    0,  705,  260,  260,  260,  260, yy_Dummy>>,
			1, 200, 2000)
		end

	yy_chk_template_12 (an_array: ARRAY [INTEGER])
			-- Fill chunk #12 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  260,  260,  260,  260,  260,  260,  261,    0,    0,  261,
			  261,  261,  261,  261,  261,  261,  281,  281,  281,  281,
			  281,  281,  281,  281,  281,  281,  282,  705,  717,  282,
			  282,  282,  282,  282,  282,  282,  284,    0,  284,  284,
			  288,    0,  288,  288,    0,    0,  435,  289,    0,  397,
			  289,  397,  289,    0,  290,  289,    0,  290,  435,  290,
			  717,  397,  290,  427,    0,    0,  291,  427,  291,  291,
			  292,  292,  292,  292,  292,  292,  292,  293,  435,    0,
			  293,  397,  293,  397,    0,  293,  294,    0,  442,  294,
			  435,  294,  284,  397,  294,  427,  288,  295,  442,  427,

			  295,    0,  295,    0,    0,  295,    0,  296,    0,    0,
			  296,  382,  296,  382,    0,  296,  382,  382,  382,  382,
			  442,  297,  291,  284,  297,    0,  297,  288,  721,  297,
			  442,    0,  288,  288,  288,  288,  288,  288,  288,  289,
			  289,  289,  289,  289,  289,  289,  290,  290,  290,  290,
			  290,  290,  290,  291,  298,    0,    0,  298,    0,  298,
			  721,    0,  298,  527,  527,  527,  528,  528,  528,  293,
			  293,  293,  293,  293,  293,  293,    0,  294,  294,  294,
			  294,  294,  294,  294,  294,    0,  295,  295,  295,  295,
			  295,  295,  295,  295,  295,  295,  296,  296,    0,  296, yy_Dummy>>,
			1, 200, 2200)
		end

	yy_chk_template_13 (an_array: ARRAY [INTEGER])
			-- Fill chunk #13 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  296,  296,  296,  296,  296,  296,  529,  529,  529,    0,
			  297,  297,  297,  297,  297,  297,  297,  297,  297,  297,
			  299,    0,  723,  299,    0,  299,    0,    0,  299,  300,
			  300,  300,  300,  300,  300,  300,  308,  308,  308,  308,
			  308,  308,  308,  298,  298,  298,  298,  298,  298,  298,
			  298,  298,  298,  301,  723,    0,  301,  401,  301,  401,
			    0,  301,  302,    0,  403,  302,  403,  302,    0,  401,
			  302,  406,  303,    0,  733,  303,  403,  303,    0,  406,
			  303,    0,  304,    0,    0,  304,    0,  304,  406,  401,
			  304,  401,  305,  735,  777,  305,  403,  305,  403,    0,

			  305,  401,  306,  406,    0,  306,  733,  306,  403,  299,
			  306,  406,  299,  299,  299,  299,  299,  299,  299,  307,
			  406,    0,  307,    0,  307,  735,  777,  307,  309,  309,
			  309,  309,  309,  309,  309,  310,  310,  310,  310,  310,
			  310,  310,  635,  635,  635,  301,  301,  301,  301,  301,
			  301,  301,    0,  302,  302,  302,  302,  302,  302,  302,
			  302,  303,  303,  303,  303,  303,  303,  303,  303,  303,
			  303,  304,  304,    0,  304,  304,  304,  304,  304,  304,
			  304,  305,  305,  305,  305,  305,  305,  305,  305,  305,
			  305,  306,  306,  306,  306,  306,  306,  306,  306,  306, yy_Dummy>>,
			1, 200, 2400)
		end

	yy_chk_template_14 (an_array: ARRAY [INTEGER])
			-- Fill chunk #14 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  306,  311,  311,  311,  311,  311,  311,  311,  307,    0,
			    0,  307,  307,  307,  307,  307,  307,  307,  312,  312,
			  312,  312,  312,  312,  312,  312,  312,  312,  313,  313,
			  313,  313,  313,  313,  313,  313,  313,  313,  314,    0,
			    0,  314,  636,  636,  636,  315,    0,    0,  315,  739,
			  739,  739,  316,  432,  420,  316,  779,  432,  395,  317,
			  395,  395,  317,  438,  439,    0,  318,  420,  439,  318,
			  395,  438,  317,  317,  317,  317,  319,  438,  383,  319,
			  383,  383,  383,  383,  320,  432,  420,  320,  779,  432,
			  395,  383,  395,  395,  321,  438,  439,  321,    0,  420,

			  439,    0,  395,  438,  322,    0,    0,  322,    0,  438,
			  605,  605,  605,  605,  323,    0,    0,  323,    0,    0,
			  383,    0,    0,  383,    0,  314,  314,  314,  314,  314,
			  314,  314,  315,  315,  315,  315,  315,  315,  315,  316,
			  316,  316,  316,  316,  316,  316,  317,  317,  317,  317,
			  317,  317,  317,  318,  318,  318,  318,  318,  318,  318,
			  740,  740,  740,  319,  319,  319,  319,  319,  319,  319,
			  320,  320,  320,  320,  320,  320,  320,  320,  321,  321,
			  321,  321,  321,  321,  321,  321,  321,  321,  322,  322,
			  340,  322,  322,  322,  322,  322,  322,  322,  323,  323, yy_Dummy>>,
			1, 200, 2600)
		end

	yy_chk_template_15 (an_array: ARRAY [INTEGER])
			-- Fill chunk #15 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  323,  323,  323,  323,  323,  323,  323,  323,  324,  787,
			    0,  324,    0,  377,  377,  377,  377,    0,  325,    0,
			    0,  325,  381,  381,  381,  381,  326,  377,  326,  326,
			    0,  326,  453,  450,  326,    0,  381,  450,    0,  453,
			  384,  787,  384,  384,  384,  384,    0,    0,    0,  327,
			    0,  327,  327,  377,  327,    0,    0,  327,  789,  377,
			    0,    0,  381,    0,  453,  450,    0,  328,  381,  450,
			  328,  453,  797,  340,  340,  340,  340,  340,  340,  340,
			  326,  329,  384,  392,  329,  392,  392,  392,  392,    0,
			  789,    0,  324,  324,  324,  324,  324,  324,  324,  324,

			  324,  324,  325,  327,  797,  325,  325,  325,  325,  325,
			  325,  325,  326,    0,  330,    0,  328,  330,  326,  326,
			  326,  326,  326,  326,  326,  392,    0,    0,  331,  452,
			  329,  331,    0,  452,  813,  327,  334,    0,    0,  334,
			    0,  327,  327,  327,  327,  327,  327,  327,  328,  332,
			    0,  821,  332,    0,  328,  328,  328,  328,  328,  328,
			  328,  452,  329,  330,  333,  452,  813,  333,  329,  329,
			  329,  329,  329,  329,  329,  335,    0,  331,  335,    0,
			  823,    0,  336,  821,    0,  336,    0,    0,    0,  337,
			    0,    0,  337,    0,    0,  330,    0,    0,  332,  825, yy_Dummy>>,
			1, 200, 2800)
		end

	yy_chk_template_16 (an_array: ARRAY [INTEGER])
			-- Fill chunk #16 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  342,  330,  330,  330,  330,  330,  330,  330,  338,  331,
			    0,  338,  823,  333,    0,  331,  331,  331,  331,  331,
			  331,  331,  343,  334,  334,  334,  334,  334,  334,  334,
			  332,  825,  344,  332,  332,  332,  332,  332,  332,  332,
			  332,  332,  332,  339,    0,  333,  339,    0,  333,  333,
			  333,  333,  333,  333,  333,  333,  333,  333,  345,  829,
			    0,    0,  335,  335,  335,  335,  335,  335,  335,  336,
			  336,  336,  336,  336,  336,  336,  337,  337,  337,  337,
			  337,  337,  337,  342,  342,  342,  342,  342,  342,  342,
			  346,  829,  338,  338,  338,  338,  338,  338,  338,  338,

			  338,  338,  347,    0,  343,  343,  343,  343,  343,  343,
			  343,  343,  344,  344,  344,  344,  344,  344,  344,  344,
			  344,  344,  348,  607,  607,  607,  607,  339,  339,  339,
			  339,  339,  339,  339,  339,  339,  339,  349,  345,  345,
			    0,  345,  345,  345,  345,  345,  345,  345,  350,  610,
			  610,  610,  610,    0,  393,  352,  393,  393,  393,  393,
			    0,  460,  353,  466,    0,  460,  629,  466,  629,  355,
			  346,  346,  346,  346,  346,  346,  346,  346,  346,  346,
			  356,    0,  347,  347,  347,  347,  347,  347,  347,  347,
			  347,  347,  357,  460,    0,  466,  393,  460,  629,  466, yy_Dummy>>,
			1, 200, 3000)
		end

	yy_chk_template_17 (an_array: ARRAY [INTEGER])
			-- Fill chunk #17 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  629,    0,  348,  354,    0,  348,  348,  348,  348,  348,
			  348,  348,  354,  354,  354,  354,  358,    0,    0,    0,
			  349,  349,  349,  349,  349,  349,  349,  359,  637,  831,
			  637,  350,  350,  350,  350,  350,  350,  350,  352,  352,
			  352,  352,  352,  352,  352,  353,  353,  353,  353,  353,
			  353,  353,  355,  355,  355,  355,  355,  355,  355,  360,
			  637,  831,  637,  356,  356,  356,  356,  356,  356,  356,
			  361,  611,  611,  611,  611,  357,  357,  357,  357,  357,
			  357,  357,  362,  617,  617,  617,  354,  354,  354,  354,
			  354,  354,  354,  363,  783,  783,  400,  444,    0,  358,

			  358,  358,  358,  358,  358,  358,  364,  400,  444,  400,
			  359,  359,  359,  359,  359,  359,  359,  365,  415,  400,
			  415,    0,    0,  617,  366,    0,  783,  783,  400,  444,
			  415,  367,  839,  606,  606,  606,  606,    0,  368,  400,
			  444,  400,  360,  360,  360,  360,  360,  360,  360,  369,
			  415,  400,  415,  361,  361,  361,  361,  361,  361,  361,
			  370,    0,  415,    0,  839,  362,  362,  362,  362,  362,
			  362,  362,  371,  606,    0,    0,  363,  363,  363,  363,
			  363,  363,  363,  372,  765,  765,  765,  765,    0,  364,
			  364,  364,  364,  364,  364,  364,  373,  851,    0,  531, yy_Dummy>>,
			1, 200, 3200)
		end

	yy_chk_template_18 (an_array: ARRAY [INTEGER])
			-- Fill chunk #18 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  365,  365,  365,  365,  365,  365,  365,  366,  366,  366,
			  366,  366,  366,  366,  367,  367,  367,  367,  367,  367,
			  367,  368,  368,  368,  368,  368,  368,  368,  374,  851,
			  479,    0,  369,  369,  369,  369,  369,  369,  369,  375,
			    0,  857,  479,  370,  370,  370,  370,  370,  370,  370,
			  376,    0,  371,  371,  371,  371,  371,  371,  371,  371,
			  371,  371,  479,  372,  372,  372,  372,  372,  372,  372,
			  372,  372,  372,  857,  479,  859,  373,  373,  373,  373,
			  373,  373,  373,  373,  373,  373,  531,  531,  531,  531,
			  531,  531,  531,  558,  558,  558,  558,  558,  558,  558,

			  559,  559,  559,  559,  559,  559,  559,  859,  374,  374,
			  374,  374,  374,  374,  374,  374,  374,  374,    0,  375,
			  375,  375,  375,  375,  375,  375,  375,  375,  375,    0,
			  376,  376,  376,  376,  376,  376,  376,  376,  376,  376,
			  390,  390,  390,  390,  405,  407,  863,  405,    0,  405,
			  390,  390,  390,  390,  390,  390,  407,  472,  407,  405,
			    0,  472,  407,  419,    0,  419,    0,    0,  407,    0,
			  419,  766,  766,  766,  766,  419,  405,  407,  863,  405,
			  390,  405,  390,  390,  390,  390,  390,  390,  407,  472,
			  407,  405,  417,  472,  407,  419,  421,  419,  421,  423, yy_Dummy>>,
			1, 200, 3400)
		end

	yy_chk_template_19 (an_array: ARRAY [INTEGER])
			-- Fill chunk #19 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  407,  417,  419,  417,  885,    0,  421,  419,  421,  425,
			  423,  425,  423,  417,  429,  425,  429,    0,  430,    0,
			  481,  425,  423,  429,  417,  430,  429,  430,  421,  481,
			  421,  423,    0,  417,    0,  417,  885,  430,  421,  665,
			  421,  425,  423,  425,  423,  417,  429,  425,  429,  431,
			  430,  665,  481,  425,  423,  429,  433,  430,  429,  430,
			  431,  481,  431,  433,  436,  433,  436,  631,  437,  430,
			  437,  665,  431,  631,    0,  433,  436,  437,  462,  478,
			  437,  431,    0,  665,    0,    0,  462,  478,  433,    0,
			    0,    0,  431,    0,  431,  433,  436,  433,  436,  631,

			  437,    0,  437,  440,  431,  631,  441,  433,  436,  437,
			  462,  478,  437,  441,  440,  441,  440,  440,  462,  478,
			  443,  445,  443,  445,  446,  441,  440,  443,  446,  445,
			  887,    0,  443,  445,    0,  440,    0,    0,  441,    0,
			    0,  446,    0,  895,  463,  441,  440,  441,  440,  440,
			    0,  463,  443,  445,  443,  445,  446,  441,  440,  443,
			  446,  445,  887,  455,  443,  445,  447,  447,  447,  449,
			  455,  449,  455,  446,  456,  895,  463,  456,  447,  456,
			  447,  449,  455,  463,  458,  609,  458,  609,  458,  456,
			  609,  609,  609,  609,    0,  455,  458,    0,  447,  447, yy_Dummy>>,
			1, 200, 3600)
		end

	yy_chk_template_20 (an_array: ARRAY [INTEGER])
			-- Fill chunk #20 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  447,  449,  455,  449,  455,    0,  456,    0,  457,  456,
			  447,  456,  447,  449,  455,  457,  458,  457,  458,  459,
			  458,  456,  461,  464,  647,    0,  647,  457,  458,  461,
			  459,  461,  459,  465,  464,  465,  464,  465,  651,  476,
			  457,  461,  459,  476,  651,  465,  464,  457,    0,  457,
			    0,  459,    0,  477,  461,  464,  647,  477,  647,  457,
			    0,  461,  459,  461,  459,  465,  464,  465,  464,  465,
			  651,  476,  467,  461,  459,  476,  651,  465,  464,  467,
			  469,  467,  469,  469,  471,  477,  471,  474,  473,  477,
			  474,  467,  469,  474,  488,  473,  471,  473,  488,  768,

			  768,  768,  768,  480,  467,    0,    0,  473,    0,  480,
			    0,  467,  469,  467,  469,  469,  471,    0,  471,  474,
			  473,  480,  474,  467,  469,  474,  488,  473,  471,  473,
			  488,  475,  673,  905,  475,  480,  482,  483,  484,  473,
			  475,  480,  475,  482,  483,  482,  483,  673,  485,  484,
			  485,  484,  475,  480,  492,  482,  483,  485,  492,  489,
			  485,  484,    0,  475,  673,  905,  475,  489,  482,  483,
			  484,    0,  475,    0,  475,  482,  483,  482,  483,  673,
			  485,  484,  485,  484,  475,  486,  492,  482,  483,  485,
			  492,  489,  485,  484,  486,  487,  486,  487,    0,  489, yy_Dummy>>,
			1, 200, 3800)
		end

	yy_chk_template_21 (an_array: ARRAY [INTEGER])
			-- Fill chunk #21 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			    0,  487,  490,  486,  498,  493,  486,  487,  498,  490,
			    0,  490,  493,    0,  493,  496,    0,  486,    0,  491,
			  496,  490,    0,    0,  493,    0,  486,  487,  486,  487,
			  491,    0,  491,  487,  490,  486,  498,  493,  486,  487,
			  498,  490,  491,  490,  493,  495,  493,  496,  495,    0,
			  495,  491,  496,  490,  499,  497,  493,  497,  501,    0,
			  495,  499,  491,  499,  491,  500,  501,  497,  876,  500,
			  907,    0,  503,  499,  491,    0,    0,  495,  508,  503,
			  495,  503,  495,  508,    0,    0,  499,  497,    0,  497,
			  501,  503,  495,  499,  876,  499,  516,  500,  501,  497,

			  876,  500,  907,  505,  503,  499,  505,  504,  505,  504,
			  508,  503,  504,  503,    0,  508,  509,  507,  505,  504,
			  507,  911,  507,  503,  509,  510,  509,  517,    0,    0,
			  510,  511,  507,  511,    0,  505,  509,  518,  505,  504,
			  505,  504,  917,  511,  504,  519,  516,    0,  509,  507,
			  505,  504,  507,  911,  507,  520,  509,  510,  509,  513,
			  623,  513,  510,  511,  507,  511,  627,  521,  509,  933,
			  623,  513,  532,    0,  917,  511,  627,  517,    0,  516,
			  516,  516,  516,  516,  516,  516,  533,  518,    0,    0,
			    0,  513,  623,  513,    0,  519,  534,    0,  627,    0, yy_Dummy>>,
			1, 200, 4000)
		end

	yy_chk_template_22 (an_array: ARRAY [INTEGER])
			-- Fill chunk #22 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			    0,  933,  623,  513,    0,  520,  535,    0,  627,    0,
			  517,  517,  517,  517,  517,  517,  517,  521,  536,    0,
			  518,  518,  518,  518,  518,  518,  518,  539,  519,  519,
			  519,  519,  519,  519,  519,  520,  520,  520,  520,  520,
			  520,  520,  520,  520,  520,  537,    0,  521,  521,  521,
			  521,  521,  521,  521,  521,  521,  521,  540,  532,  532,
			  532,  532,  532,  532,  532,  532,    0,  541,    0,  939,
			  533,  533,  533,  533,  533,  533,  533,  533,  533,  533,
			  534,  534,  542,  534,  534,  534,  534,  534,  534,  534,
			  535,  535,  535,  535,  535,  535,  535,  535,  535,  535,

			  543,  939,  536,  536,  536,  536,  536,  536,  536,  536,
			  536,  536,  544,    0,  539,  539,  539,  539,  539,  539,
			  539,    0,  545,  612,  612,  612,  612,    0,    0,  537,
			  943,    0,  537,  537,  537,  537,  537,  537,  537,  770,
			  770,  770,  770,  540,  540,  540,  540,  540,  540,  540,
			  540,  541,  541,  541,  541,  541,  541,  541,  541,  541,
			  541,    0,  943,  612,    0,    0,  542,  542,    0,  542,
			  542,  542,  542,  542,  542,  542,  614,    0,  614,  614,
			  614,  614,    0,    0,  543,  543,  543,  543,  543,  543,
			  543,  543,  543,  543,    0,  945,  544,  544,  544,  544, yy_Dummy>>,
			1, 200, 4200)
		end

	yy_chk_template_23 (an_array: ARRAY [INTEGER])
			-- Fill chunk #23 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  544,  544,  544,  544,  544,  544,  545,  639,    0,  545,
			  545,  545,  545,  545,  545,  545,  546,  639,  614,  546,
			    0,  546,  719,  547,  546,    0,  547,  945,  547,  719,
			  548,  547,    0,  548,  649,  548,  657,  549,  548,  639,
			  549,  657,  549,  649,    0,  549,    0,  550,  625,  639,
			  550,    0,  550,    0,  719,  550,    0,  551,    0,  625,
			  551,  719,  551,    0,  552,  551,  649,  552,  657,  552,
			  947,  553,  552,  657,  553,  649,  553,    0,  554,  553,
			  625,  554,    0,  554,    0,  555,  554,    0,  555,    0,
			  555,  625,    0,  555,    0,  556,    0,    0,  556,    0,

			  556,    0,  947,  556,  772,  772,  772,  772,  546,  546,
			  546,  546,  546,  546,  546,  547,  547,  547,  547,  547,
			  547,  547,  548,  548,  548,  548,  548,  548,  548,  549,
			  549,  549,  549,  549,  549,  549,  550,  550,  550,  550,
			  550,  550,  550,  550,  550,  550,  551,  551,  551,  551,
			  551,  551,  551,  551,  551,  551,  552,  552,  552,  552,
			  552,  552,  552,  553,  553,  553,  553,  553,  553,  553,
			  554,  554,  554,  554,  554,  554,  554,  555,  555,  555,
			  555,  555,  555,  555,  556,  556,  556,  556,  556,  556,
			  556,  556,  556,  556,  557,    0,    0,  557,    0,  557, yy_Dummy>>,
			1, 200, 4400)
		end

	yy_chk_template_24 (an_array: ARRAY [INTEGER])
			-- Fill chunk #24 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			    0,    0,  557,    0,    0,    0,  560,  641,    0,  560,
			    0,  641,    0,  561,  643,    0,  561,  953,    0,    0,
			  562,    0,    0,  562,  645,  643,    0,  563,  645,    0,
			  563,    0,  562,  562,  562,  562,  562,  564,  663,  641,
			  564,  655,  663,  641,  565,  691,  643,  565,  691,  953,
			  655,  566,    0,  563,  566,    0,  645,  643,  567,    0,
			  645,  567,  875,  875,  875,  875,    0,    0,  568,    0,
			  663,  568,    0,  655,  663,    0,    0,  691,  569,    0,
			  691,  569,  655,  557,  557,  557,  557,  557,  557,  557,
			  557,  557,  557,  560,  560,  560,  560,  560,  560,  560,

			  561,  561,  561,  561,  561,  561,  561,  562,  562,  562,
			  562,  562,  562,  562,  563,  563,  563,  563,  563,  563,
			  563,  574,    0,    0,  564,  564,  564,  564,  564,  564,
			  564,  565,  565,  565,  565,  565,  565,  565,  566,  566,
			  566,  566,  566,  566,  566,  567,  567,  567,  567,  567,
			  567,  567,  568,  568,  568,  568,  568,  568,  568,  568,
			  568,  568,  569,  569,  569,  569,  569,  569,  569,  569,
			  569,  569,  570,    0,    0,  570,  604,  604,  604,  604,
			  608,  608,  608,  608,    0,  571,    0,    0,  571,    0,
			  604,    0,  572,    0,  608,  572,  975,    0,    0,  573, yy_Dummy>>,
			1, 200, 4600)
		end

	yy_chk_template_25 (an_array: ARRAY [INTEGER])
			-- Fill chunk #25 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			    0,  711,  573,    0,  574,  574,  574,  574,  574,  574,
			  574,  575,  624,    0,  624,  979,  604,  711,  576,  624,
			  608,  570,  604,  675,  624,  577,  608,  621,  975,  621,
			  621,  621,  621,  711,  571,  578,    0,    0,  675,  879,
			  879,  879,  879,    0,  624,  579,  624,  979,    0,  711,
			    0,  624,    0,  570,    0,  675,  624,    0,    0,  570,
			  570,  570,  570,  570,  570,  570,  571,    0,  602,  621,
			  675,    0,  571,  571,  571,  571,  571,  571,  571,  572,
			  572,  572,  572,  572,  572,  572,  573,  573,  573,  573,
			  573,  573,  573,  603,  575,  575,  575,  575,  575,  575,

			  575,  576,  576,  576,  576,  576,  576,  576,  577,  577,
			  577,  577,  577,  577,  577,  578,  578,  578,  578,  578,
			  578,  578,  578,  578,  578,  579,  579,  579,  579,  579,
			  579,  579,  579,  579,  579,  585,  880,  880,  880,  880,
			  989,    0,    0,  585,  585,  585,  585,  585,  602,  602,
			  602,  602,  602,  602,  602,  602,  602,  602,  613,    0,
			  613,  613,  613,  613,  622,    0,  622,  622,  622,  622,
			    0,  613,  989,  603,  603,  603,  603,  603,  603,  603,
			  603,  603,  603,  801,  801,    0,    0,    0,  763,  763,
			  763,  763,    0,  626,    0,  626,    0,  628,  658,  628, yy_Dummy>>,
			1, 200, 4800)
		end

	yy_chk_template_26 (an_array: ARRAY [INTEGER])
			-- Fill chunk #26 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  613,  626,  763,  613,  628,  626,  622,  658,    0,  628,
			  882,  882,  882,  882,    0,  801,  801,  633,  585,  585,
			  585,  585,  585,  585,  585,  626,  633,  626,  633,  628,
			  658,  628,    0,  626,  763,  630,  628,  626,  633,  658,
			  630,  628,  630,  638,  638,  661,  638,  699,  634,  633,
			  699,  634,  630,  634,  661,  713,  638,  640,  633,  640,
			  633,  713,    0,  634,  640,    0,    0,  630,    0,  640,
			  633,    0,  630,    0,  630,  638,  638,  661,  638,  699,
			  634,    0,  699,  634,  630,  634,  661,  713,  638,  640,
			  642,  640,  644,  713,  644,  634,  640,  642,  646,  642,

			  644,  640,  668,  648,  644,  646,  668,  646,  648,  642,
			  648,    0,  652,  650,    0,  650,    0,  646,  991,  650,
			  648,  652,  642,  652,  644,  650,  644,    0,    0,  642,
			  646,  642,  644,  652,  668,  648,  644,  646,  668,  646,
			  648,  642,  648,  654,  652,  650,  654,  650,  654,  646,
			  991,  650,  648,  652,  656,  652,  656,  650,  654,  659,
			  656,  659,  660,  664,  660,  652,  656,  662,  660,  662,
			  664,  659,  664,  662,  660,  654,    0,    0,  654,  662,
			  654,  679,  664,    0,    0,  679,  656,    0,  656,    0,
			  654,  659,  656,  659,  660,  664,  660,    0,  656,  662, yy_Dummy>>,
			1, 200, 5000)
		end

	yy_chk_template_27 (an_array: ARRAY [INTEGER])
			-- Fill chunk #27 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  660,  662,  664,  659,  664,  662,  660,  666,  669,  666,
			  669,  662,    0,  679,  664,  670,  666,  679,  672,  666,
			  669,  672,  670,  672,  670,  674,  676,  674,  676,  957,
			  957,  957,  957,  672,  670,  677,    0,  674,  676,  666,
			  669,  666,  669,    0,  677,  995,    0,  670,  666,    0,
			  672,  666,  669,  672,  670,  672,  670,  674,  676,  674,
			  676,    0,  678,  681,  678,  672,  670,  677,  678,  674,
			  676,  680,  681,  682,  678,  682,  677,  995,  680,  682,
			  680,  684,    0,  684,    0,  682,  686,  688,  686,  688,
			  680,    0,  701,  684,  678,  681,  678,    0,  686,  688,

			  678,  701,    0,  680,  681,  682,  678,  682,    0,    0,
			  680,  682,  680,  684,  690,  684,  690,  682,  686,  688,
			  686,  688,  680,  695,  701,  684,  690,  692,    0,  692,
			  686,  688,  694,  701,  694,  695,  997,  703,  697,  692,
			  697,  703,    0,    0,  694,    0,  690,  697,  690,    0,
			  697,  764,  764,  764,  764,  695,    0,    0,  690,  692,
			  698,  692,  707,  698,  694,  698,  694,  695,  997,  703,
			  697,  692,  697,  703,  707,  698,  694,  708,  700,  697,
			  708,  702,  697,  702,  700,    0,  700,  702,  704,  704,
			  704,  764,  698,  702,  707,  698,  700,  698,  785,  706, yy_Dummy>>,
			1, 200, 5200)
		end

	yy_chk_template_28 (an_array: ARRAY [INTEGER])
			-- Fill chunk #28 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  704,    0,  706,    0,  706,  785,  707,  698,    0,  708,
			  700,    0,  708,  702,  706,  702,  700,  715,  700,  702,
			  704,  704,  704, 1009,    0,  702,  715,  710,  700,  710,
			  785,  706,  704,  709,  706,  709,  706,  785,  712,  710,
			  712,  725,  709,  714,  725,  709,  706,    0,  731,  715,
			  712,  712,  714,    0,  714, 1009,  731,    0,  715,  710,
			    0,  710,    0,    0,  714,  709,  718,  709,  718, 1015,
			  712,  710,  712,  725,  709,  714,  725,  709,  718,  716,
			  731,  716,  712,  712,  714,  716,  714,  722,  731,  722,
			  720,  716,  720,  724,  720,  724,  714,  727,  718,  722,

			  718, 1015,  720,    0,  729,  724,    0,  729,    0,  727,
			  718,  716,  726,  716,    0,  741,    0,  716,  726,  722,
			  726,  722,  720,  716,  720,  724,  720,  724,    0,  727,
			  726,  722,  737,  728,  720,  728,  729,  724,  732,  729,
			  803,  727,  728,  803,  726,  728,  730,  738,  730,  732,
			  726,  732,  726,  742,  734,  791,  734,  736,  730,  736,
			  743,  732,  726, 1028,  791,  728,  734,  728,  744,  736,
			  732,    0,  803,    0,  728,  803,    0,  728,  730,  745,
			  730,  732,  737,  732,    0,    0,  734,  791,  734,  736,
			  730,  736,  746,  732,    0, 1028,  791,  738,  734,  747, yy_Dummy>>,
			1, 200, 5400)
		end

	yy_chk_template_29 (an_array: ARRAY [INTEGER])
			-- Fill chunk #29 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			    0,  736,  741,  741,  741,  741,  741,  741,  741,  748,
			  958,  958,  958,  958,    0,  737,  737,  737,  737,  737,
			  737,  737,  749,  959,  959,  959,  959,    0,    0,  750,
			  738,  738,  738,  738,  738,  738,  738,    0,    0,  751,
			  742,  742,  742,  742,  742,  742,  742,  743,  743,  743,
			  743,  743,  743,  743,  752,  744,  744,  744,  744,  744,
			  744,  744,  809,  745,  745,  745,  745,  745,  745,  745,
			  745,  745,  745,  809, 1032, 1034,  746,  746,  746,  746,
			  746,  746,  746,  746,  746,  746,  747,  747,  747,  747,
			  747,  747,  747,    0,  809,    0,  748,  748,  748,  748,

			  748,  748,  748, 1038,    0,  809, 1032, 1034,    0,  749,
			  749,  749,  749,  749,  749,  749,  750,  750,  750,  750,
			  750,  750,  750,  751,  751,  751,  751,  751,  751,  751,
			  751,  751,  751,  758,    0, 1038,  758,    0,  752,  752,
			  752,  752,  752,  752,  752,  752,  752,  752,  753,  760,
			  793,  753,    0,  753,  793,  754,  753,  849,  754,    0,
			  754,    0,  755,  754,    0,  755,  775,  755,  849,  756,
			  755,  776,  756,  776,  756,  781,  775,  756,  776,  827,
			  781,  757,  793,  776,  757,  827,  793,  964,  759,  849,
			    0,  759,    0,  757,  757,  757,  757,  757,  775,  761, yy_Dummy>>,
			1, 200, 5600)
		end

	yy_chk_template_30 (an_array: ARRAY [INTEGER])
			-- Fill chunk #30 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  849,    0,    0,  776,    0,  776,  762,  781,  775,    0,
			  776,  827,  781,  964,    0,  776,    0,  827,    0,  964,
			  758,  758,  758,  758,  758,  758,  758,  963,  963,  963,
			  963,    0,  760,  760,  760,  760,  760,  760,  760,    0,
			  753,  753,  753,  753,  753,  753,  753,  754,  754,  754,
			  754,  754,  754,  754,  755,  755,  755,  755,  755,  755,
			  755,  756,  756,  756,  756,  756,  756,  756,  757,  757,
			  757,  757,  757,  757,  757,  759,  759,  759,  759,  759,
			  759,  759,  761,  761,  761,  761,  761,  761,  761,  762,
			  762,  762,  762,  762,  762,  762,  767,  767,  767,  767,

			  769,  769,  769,  769,  771,  771,  771,  771,    0,    0,
			  767,  773,  773,  773,  773,  778,  774,  778,  774,  774,
			  774,  774,  780,    0,  780,  773,    0,  778,    0,  782,
			    0,  782,    0, 1040,  780,    0,  767,    0,  786,  784,
			  769,  782,  767,  784,  771,  784, 1042,  778,  786,  778,
			  786,    0,    0,    0,  780,  784,  780,  773,  774,  778,
			  786,  782,  788,  782,  788, 1040,  780,  790,    0,  790,
			  786,  784,    0,  782,  788,  784,  795,  784, 1042,  790,
			  786,  795,  786,  792,  794,  792,    0,  784,  794,  792,
			    0,  794,  786,  794,  788,  792,  788, 1046,  796,  790, yy_Dummy>>,
			1, 200, 5800)
		end

	yy_chk_template_31 (an_array: ARRAY [INTEGER])
			-- Fill chunk #31 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  796,  790,  798,  794,  798,    0,  788,    0,  795,  799,
			  796,  790,    0,  795,  798,  792,  794,  792,  799,  807,
			  794,  792,  802,  794,  807,  794,  802,  792,  802, 1046,
			  796,  800,  796,  800,  798,  794,  798,  800,  802,  804,
			  805,  799,  796,  800,  805,  804,  798,  804,    0,    0,
			  799,  807,    0,    0,  802,  806,  807,  804,  802,  815,
			  802,    0,  806,  800,  806,  800,    0,    0,  815,  800,
			  802,  804,  805,  808,  806,  800,  805,  804,  810,  804,
			  810,  808,    0,  808,  819,  919,  810,  806,  819,  804,
			  810,  815,  811,  808,  806,  919,  806,  811,  817,  812,

			  815,  812,  814,  817,  814,  808,  806,  818,    0,  818,
			  810,  812,  810,  808,  814,  808,  819,  919,  810,  818,
			  819,    0,  810,    0,  811,  808,  816,  919,  816,  811,
			  817,  812,  816,  812,  814,  817,  814, 1050,  816,  818,
			  820,  818,  824,  812,  824,  853,  814,  820,  833,  820,
			  822,  818,  833,  822,  824,  822,  853,  841,  816,  820,
			  816,  841,  828,  826,  816,  822,  826,    0,  826, 1050,
			  816,  828,  820,  828,  824,    0,  824,  853,  826,  820,
			  833,  820,  822,  828,  833,  822,  824,  822,  853,  841,
			  832,  820,  832,  841,  828,  826,  830,  822,  826,  830, yy_Dummy>>,
			1, 200, 6000)
		end

	yy_chk_template_32 (an_array: ARRAY [INTEGER])
			-- Fill chunk #32 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  826,  830,  832,  828,  835,  828,  836,  834,  836,    0,
			  826,  830,  836,  835,  834,  828,  834,  837,  836,    0,
			    0,    0,  832,  838,  832,  838,  834,    0,  830,    0,
			    0,  830,  837,  830,  832,  838,  835,  843,  836,  834,
			  836,  843,    0,  830,  836,  835,  834, 1054,  834,  837,
			  836,  840,  842,  844,  840,  838,  840,  838,  834,  842,
			  844,  842,  844,  865,  837,  845,  840,  838,  865,  843,
			  855,  842,  844,  843,  845,  846,  847,  846,  855, 1054,
			  847,  846,    0,  840,  842,  844,  840,  846,  840,    0,
			    0,  842,  844,  842,  844,  865,    0,  845,  840, 1056,

			  865,    0,  855,  842,  844,    0,  845,  846,  847,  846,
			  855,  848,  847,  846,  850,  852,  850,  852,  848,  846,
			  848,  854,  850,  854,    0,  891,  850,  852,  856,  854,
			  848, 1056,  858,  854,  858,    0,    0,  891,    0,  856,
			    0,  856,  867,  848,  858,    0,  850,  852,  850,  852,
			  848,  856,  848,  854,  850,  854,  868,  891,  850,  852,
			  856,  854,  848,  869,  858,  854,  858,  860,  862,  891,
			  860,  856,  860,  856,  861,  862,  858,  862,  861,  864,
			  870,  864,  860,  856,  866,  987,  866,  862,  987,  871,
			  889,  864,  871,  886,  889,  886,  866,    0,    0,  860, yy_Dummy>>,
			1, 200, 6200)
		end

	yy_chk_template_33 (an_array: ARRAY [INTEGER])
			-- Fill chunk #33 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  862,  871,  860,    0,  860,  886,  861,  862,    0,  862,
			  861,  864,    0,  864,  860,    0,  866,  987,  866,  862,
			  987,    0,  889,  864,    0,  886,  889,  886,  866,  867,
			  867,  867,  867,  867,  867,  867,    0,  886,  965,  965,
			  965,  965, 1063,  868,  868,  868,  868,  868,  868,  868,
			  869,  869,  869,  869,  869,  869,  869,  873,    0,  873,
			    0,    0,  873,  873,  873,  873,    0,  870,  870,  870,
			  870,  870,  870,  870, 1063,    0,  871,  871,  871,  871,
			  871,  871,  871,  874,  874,  874,  874,  877,  877,  877,
			  877,  878,  878,  878,  878,  881,  881,  881,  881,    0,

			  883,  877,  883,    0,  893,  883,  883,  883,  883,    0,
			  884,  884,  884,  884,  888,  893,  888,    0,  890,  899,
			  892,    0,  892,  874,  884,  890,  888,  890,  896,  892,
			  899,  878,  892,  877,  896,  881,  893,  890,    0,    0,
			 1067,  894,    0,  894,    0,    0,  888,  893,  888,  894,
			  890,  899,  892,  894,  892,  903,  884,  890,  888,  890,
			  896,  892,  899,  903,  892,  897,  896,  897,  898,  890,
			  898,  898, 1067,  894,  900,  894,  900,  897,  904,  901,
			  898,  894,  900,  901, 1069,  894,  900,  903,    0,  904,
			    0,  904,  906,    0,  906,  903, 1071,  897,  902,  897, yy_Dummy>>,
			1, 200, 6400)
		end

	yy_chk_template_34 (an_array: ARRAY [INTEGER])
			-- Fill chunk #34 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  898,  904,  898,  898,  906,  902,  900,  902,  900,  897,
			  904,  901,  898, 1074,  900,  901, 1069,  902,  900,  913,
			  908,  904,  908,  904,  906,  909,  906,  913, 1071,  909,
			  902,  910,  908,  904,    0,  914,  906,  902,  910,  902,
			  910,  912,    0,  912,    0, 1074,  914,    0,  914,  902,
			  910,  913,  908,  912,  908,  923,  915,  909,  914,  913,
			  915,  909,  916,  910,  908, 1036,  923,  914, 1036,  916,
			  910,  916,  910,  912,  918,  912,  918,  920,  914,  920,
			  914,  916,  910,    0,  920,  912,  918,  923,  915,  920,
			  914,  921,  915,  922,  916,  922,  921, 1036,  923,    0,

			 1036,  916,  924,  916,  924,  922,  918,    0,  918,  920,
			  924,  920,  927,  916,  924,  925,  920,    0,  918,    0,
			  927,  920,  931,  921,  929,  922,  925,  922,  921,    0,
			    0,  926,  931,  926,  924,  929,  924,  922,  928,  926,
			    0,    0,  924,  926,  927,    0,  924,  925,  935,  928,
			  937,  928,  927,  935,  931,  937,  929,    0,  925,    0,
			  930,  928,  930,  926,  931,  926,    0,  929,  930,    0,
			  928,  926,  930,    0,  934,  926,  934,  932,    0,  932,
			  935,  928,  937,  928,  932,  935,  934,  937,  949,  932,
			    0,  951,  930,  928,  930,  936,  951,  936,  941,  949, yy_Dummy>>,
			1, 200, 6600)
		end

	yy_chk_template_35 (an_array: ARRAY [INTEGER])
			-- Fill chunk #35 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  930,  938,  941,  938,  930,    0,  934,  936,  934,  932,
			  940,  932,  940,  938,  971,    0,  932,  942,  934,  971,
			  949,  932,  940,  951,  942,    0,  942,  936,  951,  936,
			  941,  949,    0,  938,  941,  938,  942,    0,  944,  936,
			  944,  946,  940,  946,  940,  938,  971,    0,  955,  942,
			  944,  971,  973,  946,  940,  948,  942,  948,  942,  955,
			    0, 1001,  952,  973,  952, 1001,    0,  948,  942,  950,
			  944,  950,  944,  946,  952,  946,  954,  950,  954,  983,
			  955,  950,  944,    0,  973,  946,  983,  948,  954,  948,
			  956,  955,  956, 1001,  952,  973,  952, 1001,  956,  948,

			    0,  950,  956,  950,    0,    0,  952,    0,  954,  950,
			  954,  983,    0,  950,  962,  962,  962,  962,  983,    0,
			  954,  960,  956,  960,  956,    0,  960,  960,  960,  960,
			  956,  961,    0,  961,  956,    0,  961,  961,  961,  961,
			  966,  966,  966,  966,  967,  967,  967,  967,  969,  969,
			  969,  969, 1044,  970,  962,  970,    0,  972,  970,  970,
			  970,  970,  969, 1044,  974,  972,  974,  972,  976,  977,
			  976,  978,  974,  978,  977,    0,  974,  972,    0,  980,
			  976,  980,  981,  978, 1044,  985,    0,  981,  969,  972,
			  985,  980,    0,    0,  969, 1044,  974,  972,  974,  972, yy_Dummy>>,
			1, 200, 6800)
		end

	yy_chk_template_36 (an_array: ARRAY [INTEGER])
			-- Fill chunk #36 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  976,  977,  976,  978,  974,  978,  977,    0,  974,  972,
			  982,  980,  976,  980,  981,  978,  984,  985,  982,  981,
			  982,  986,  985,  980,    0,  988,  984,  988,  984,  986,
			  982,  986,  990,  992,  990,  992,    0,  988,  984,    0,
			    0,  986,  982,    0,  990,  992,    0,  993,  984,  993,
			  982,    0,  982,  986,    0,    0,    0,  988,  984,  988,
			  984,  986,  982,  986,  990,  992,  990,  992,    0,  988,
			  984,    0,  996,  986,  996,  994,  990,  992,    0,  993,
			  994,  993,  994,  998,  996,  998,  999, 1000,    0, 1000,
			 1003,  999,  994, 1005, 1002,  998, 1003, 1005,    0, 1000,

			    0, 1002,    0, 1002,  996,    0,  996,  994, 1004,    0,
			 1004, 1004,  994, 1002,  994,  998,  996,  998,  999, 1000,
			 1004, 1000, 1003,  999,  994, 1005, 1002,  998, 1003, 1005,
			 1006, 1000, 1007, 1002, 1010, 1002, 1010, 1006, 1007, 1006,
			 1004, 1012, 1004, 1004, 1008, 1002, 1010, 1011, 1012, 1006,
			 1012, 1011, 1004, 1008, 1013, 1008,    0,    0, 1013,    0,
			 1012,    0, 1006, 1048, 1007, 1008, 1010,    0, 1010, 1006,
			 1007, 1006, 1048, 1012,    0,    0, 1008,    0, 1010, 1011,
			 1012, 1006, 1012, 1011, 1014, 1008, 1013, 1008,    0,    0,
			 1013, 1014, 1012, 1014, 1016, 1048, 1016, 1008, 1018, 1018, yy_Dummy>>,
			1, 200, 7000)
		end

	yy_chk_template_37 (an_array: ARRAY [INTEGER])
			-- Fill chunk #37 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			 1018, 1018,    0, 1014, 1048,    0, 1016, 1019, 1019, 1019,
			 1019, 1020, 1020, 1020, 1020,    0, 1014, 1021, 1021, 1021,
			 1021,    0,    0, 1014,    0, 1014, 1016,    0, 1016, 1022,
			 1022, 1022, 1022, 1030, 1023, 1014, 1023, 1030, 1016, 1023,
			 1023, 1023, 1023, 1025, 1025, 1025, 1025, 1019, 1026, 1026,
			 1026, 1026, 1027, 1027, 1027, 1027, 1029, 1025, 1029, 1033,
			    0, 1033, 1035, 1031, 1035, 1030,    0,    0, 1029, 1030,
			 1031, 1033, 1031, 1037, 1035, 1037, 1060, 1060, 1060, 1060,
			    0,    0, 1031, 1025,    0, 1037,    0,    0, 1029, 1025,
			 1029, 1033, 1027, 1033, 1035, 1031, 1035, 1039,    0, 1039,

			 1029,    0, 1031, 1033, 1031, 1037, 1035, 1037, 1041, 1039,
			 1041, 1043,    0, 1043, 1031,    0, 1045, 1037, 1045,    0,
			 1041,    0, 1052, 1043, 1045, 1047, 1052, 1047, 1045, 1039,
			    0, 1039, 1049,    0, 1049, 1065,    0, 1047, 1049, 1065,
			 1041, 1039, 1041, 1043, 1049, 1043,    0,    0, 1045, 1051,
			 1045, 1051, 1041,    0, 1052, 1043, 1045, 1047, 1052, 1047,
			 1045, 1051,    0,    0, 1049, 1053, 1049, 1065,    0, 1047,
			 1049, 1065, 1053, 1055, 1053, 1055, 1049, 1057,    0, 1057,
			    0, 1051,    0, 1051, 1053, 1055,    0,    0,    0, 1057,
			    0,    0,    0, 1051,    0,    0,    0, 1053, 1058, 1058, yy_Dummy>>,
			1, 200, 7200)
		end

	yy_chk_template_38 (an_array: ARRAY [INTEGER])
			-- Fill chunk #38 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			 1058, 1058,    0,    0, 1053, 1055, 1053, 1055,    0, 1057,
			    0, 1057, 1061, 1061, 1061, 1061, 1053, 1055,    0,    0,
			    0, 1057, 1062, 1062, 1062, 1062, 1066, 1064,    0, 1064,
			    0,    0, 1068, 1066, 1068, 1066,    0,    0, 1058, 1064,
			    0, 1070,    0, 1070, 1068, 1066,    0,    0, 1072,    0,
			 1072,    0, 1061, 1070, 1073, 1073, 1073, 1073, 1066, 1064,
			 1072, 1064, 1062,    0, 1068, 1066, 1068, 1066,    0,    0,
			    0, 1064, 1075, 1070, 1075, 1070, 1068, 1066,    0,    0,
			 1072,    0, 1072,    0, 1075, 1070,    0,    0,    0,    0,
			    0,    0, 1072,    0, 1073,    0,    0,    0,    0,    0,

			    0,    0,    0,    0, 1075,    0, 1075,    0,    0,    0,
			    0,    0,    0,    0,    0,    0, 1075, 1077, 1077, 1077,
			 1077, 1077, 1077, 1077, 1077, 1077, 1077, 1077, 1077, 1077,
			 1077, 1077, 1077, 1077, 1077, 1077, 1077, 1077, 1077, 1077,
			 1078, 1078,    0, 1078, 1078, 1078, 1078, 1078, 1078, 1078,
			 1078, 1078, 1078, 1078, 1078, 1078, 1078, 1078, 1078, 1078,
			 1078, 1078, 1078, 1079,    0,    0,    0,    0,    0,    0,
			 1079, 1079, 1079, 1079, 1079, 1079, 1079, 1079, 1079, 1079,
			 1079, 1079, 1079, 1079, 1079, 1079, 1080, 1080,    0, 1080,
			 1080, 1080, 1080, 1080, 1080, 1080, 1080, 1080, 1080, 1080, yy_Dummy>>,
			1, 200, 7400)
		end

	yy_chk_template_39 (an_array: ARRAY [INTEGER])
			-- Fill chunk #39 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			 1080, 1080, 1080, 1080, 1080, 1080, 1080, 1080, 1080, 1081,
			 1081,    0, 1081, 1081, 1081, 1081,    0, 1081, 1081, 1081,
			 1081, 1081, 1081, 1081, 1081, 1081, 1081, 1081, 1081, 1081,
			 1081, 1081, 1082, 1082, 1082, 1082, 1082, 1082, 1082, 1082,
			 1082,    0, 1082, 1082, 1082, 1082, 1083, 1083,    0, 1083,
			 1083, 1083,    0,    0, 1083, 1083, 1083, 1083, 1083, 1083,
			 1083, 1083, 1083,    0, 1083, 1083, 1083, 1083, 1083, 1084,
			 1084, 1084, 1084, 1084, 1084, 1084, 1084,    0, 1084, 1084,
			 1084, 1084, 1084, 1085,    0,    0, 1085,    0, 1085, 1085,
			 1085, 1085, 1085, 1085, 1085, 1085, 1085, 1085, 1085, 1085,

			 1085, 1085, 1085, 1085, 1085, 1085, 1086, 1086,    0, 1086,
			 1086, 1086, 1086, 1086, 1086, 1086, 1086, 1086, 1086, 1086,
			 1086, 1086, 1086, 1086, 1086, 1086, 1086, 1086, 1086, 1087,
			 1087,    0, 1087, 1087, 1087, 1087, 1087, 1087, 1087, 1087,
			 1087, 1087, 1087, 1087, 1087, 1087, 1087, 1087, 1087, 1087,
			 1087, 1087, 1088, 1088,    0, 1088, 1088, 1088, 1088, 1088,
			 1088, 1088, 1088, 1088, 1088, 1088, 1088, 1088, 1088, 1088,
			 1088, 1088, 1088, 1088, 1088, 1089,    0,    0,    0,    0,
			 1089, 1089, 1089, 1089, 1089, 1089, 1089, 1089, 1089, 1089,
			 1089, 1089, 1089, 1089, 1089, 1089, 1089, 1089, 1090, 1090, yy_Dummy>>,
			1, 200, 7600)
		end

	yy_chk_template_40 (an_array: ARRAY [INTEGER])
			-- Fill chunk #40 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			 1090, 1090, 1090, 1090, 1090, 1090,    0, 1090, 1090, 1090,
			 1090, 1090, 1090, 1090, 1090, 1090, 1090, 1090, 1090, 1090,
			 1090, 1091, 1091, 1091, 1091, 1091, 1091, 1091, 1091,    0,
			 1091, 1091, 1091, 1091, 1092, 1092, 1092, 1092, 1092, 1092,
			 1092, 1092,    0, 1092, 1092, 1092, 1092, 1093, 1093, 1093,
			 1093, 1093, 1093, 1093, 1093,    0, 1093, 1093, 1093, 1093,
			 1094, 1094,    0, 1094, 1094, 1094,    0, 1094, 1094, 1094,
			 1094, 1094, 1094, 1094, 1094, 1094, 1094, 1094, 1094, 1094,
			 1094, 1094, 1094, 1095, 1095,    0, 1095, 1095, 1095,    0,
			 1095, 1095, 1095, 1095, 1095, 1095, 1095, 1095, 1095, 1095,

			 1095, 1095, 1095, 1095, 1095, 1095, 1096, 1096, 1096, 1096,
			 1096, 1096, 1096, 1096,    0, 1096, 1096, 1096, 1096, 1096,
			 1096, 1096, 1096, 1096, 1096, 1096, 1096, 1096, 1096, 1076,
			 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076,
			 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076,
			 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076,
			 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076,
			 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076,
			 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076,
			 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, yy_Dummy>>,
			1, 200, 7800)
		end

	yy_chk_template_41 (an_array: ARRAY [INTEGER])
			-- Fill chunk #41 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076,
			 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076,
			 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, yy_Dummy>>,
			1, 30, 8000)
		end

	yy_base_template: SPECIAL [INTEGER]
			-- Template for `yy_base'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 1096)
			yy_base_template_1 (an_array)
			yy_base_template_2 (an_array)
			yy_base_template_3 (an_array)
			yy_base_template_4 (an_array)
			yy_base_template_5 (an_array)
			yy_base_template_6 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_base_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			    0,    0,    0,   99,  111,  701, 7929,  697, 7929,  691,
			  673,  619,  124,    0, 7929,  131,  138, 7929, 7929, 7929,
			 7929, 7929,   89,   87,   92,  221,  102,  129,  582, 7929,
			  100, 7929,  101,  572,  287,  218,  351,  101,  117,  217,
			   74,  361,  115,  202,  359,  134,   98,  224,  233,  222,
			  375,  146,  219, 7929,  532, 7929, 7929,  358,  427,  434,
			  498,  416,  506,  577,  421,  573,  500,  569,  588,  424,
			  623,  631,  640,  647,  680,  693,  685, 7929, 7929, 7929,
			   82,  427,  184,   87,  222,  252,  399,  389,  389, 7929,
			  745,  735,  762,  769,  466,  687,  713,  700,  723,  755,

			  779,  478, 7929,  418, 7929,  825, 7929,  919,  883,  896,
			  933,  948,  966,  993, 1013, 1027, 1043,    0,  978, 1060,
			 1072, 1087, 1107, 1122, 1137, 1154, 1162,  407, 1256, 1227,
			 1215, 1244, 1266, 1279, 1289, 1305, 7929, 7929, 7929, 1128,
			 7929, 7929, 7929,  648,  874,  357,  103,  419,  497, 1386,
			 1221,  143, 7929, 7929, 7929, 7929, 7929, 7929,  116,  499,
			  376,  428,  378,  502,  579, 1369, 1382, 1390, 1421, 1425,
			 1428, 1436,  463,  322,  495,  157,  541,  545,  316,  834,
			 1439,  589,  665,  871,  707, 1446, 1485, 1488, 1489, 1493,
			 1492, 1541,  231, 1550, 1539, 1390, 1550, 1551, 1554, 1600, yy_Dummy>>,
			1, 200, 0)
		end

	yy_base_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			 1597, 1030, 1485,  514, 1604, 1628, 1611,  278,  641, 1660,
			  338, 1651, 1664, 1717, 1659,  846, 1713, 1721, 1735, 1247,
			 1732, 1546, 1618, 1208,  374, 1771, 1782, 1786, 1785, 1157,
			 1799, 1840, 1889, 1856, 1356, 1668, 1823, 1838, 1893, 1676,
			  411, 1907, 1902, 1844, 1948, 1725,  435, 1947, 1955, 1721,
			 1910, 1783, 1962, 7929, 1988, 1995, 2003, 2013, 2054, 2064,
			 2105, 2115,  697,  218,  734,  334,  737,  745,  154,  819,
			  906,  914,  917,  933,  947, 1963, 1972, 2024, 2036, 2083,
			 2093, 2125, 2135, 1206, 2234, 2043, 2073, 7929, 2238, 2245,
			 2252, 2264, 2176, 2275, 2284, 2295, 2305, 2319, 2352, 2418,

			 2335, 2451, 2460, 2470, 2480, 2490, 2500, 2517, 2342, 2434,
			 2441, 2507, 2527, 2537, 2631, 2638, 2645, 2652, 2659, 2669,
			 2677, 2687, 2697, 2707, 2801, 2811, 2824, 2847, 2860, 2874,
			 2907, 2921, 2942, 2957, 2929, 2968, 2975, 2982, 3001, 3036,
			 2779, 7929, 2989, 3011, 3021, 3047, 3079, 3091, 3111, 3126,
			 3137,  206, 3144, 3151, 3192, 3158, 3169, 3181, 3205, 3216,
			 3248, 3259, 3271, 3282, 3295, 3306, 3313, 3320, 3327, 3338,
			 3349, 3361, 3372, 3385, 3417, 3428, 3439, 2793, 2031, 1154,
			 7929, 2802, 2296, 2660, 2822,  286,  671,  154, 1309,  141,
			 3520,  116, 2865, 3136, 1499, 2617, 1678, 2208, 1606,  498, yy_Dummy>>,
			1, 200, 200)
		end

	yy_base_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			 3266, 2416,  513, 2423,  647, 3506, 2441, 3515, 1241, 1254,
			 1299, 1322, 1348, 1461,  705, 3277, 1784, 3560, 1847, 3522,
			 2616, 3555, 1629, 3569, 1964, 3568, 1849, 2229, 1909, 3573,
			 3584, 3619, 2619, 3622,  763, 2208, 3623, 3627, 2633, 2630,
			 3673, 3672, 2250, 3679, 3259, 3680, 3686, 3725, 1728, 3728,
			 2799,  889, 2895, 2794, 1974, 3729, 3736, 3774, 3743, 3789,
			 3127, 3788, 3648, 3706, 3793, 3792, 3129, 3838, 1793, 3839,
			  904, 3843, 3523, 3854, 3855, 3899, 3805, 3819, 3649, 3392,
			 3871, 3582, 3902, 3903, 3908, 3907, 3953, 3954, 3860, 3929,
			 3968, 3989, 3920, 3971, 1058, 4007, 3977, 4014, 3970, 4020,

			 4031, 4020, 1060, 4038, 4066, 4065, 1154, 4079, 4045, 4083,
			 4087, 4090, 1155, 4118, 7929, 7929, 4085, 4116, 4126, 4134,
			 4144, 4156, 1569, 1627, 1811, 1866, 1985, 2272, 2275, 2315,
			 7929, 3392, 4165, 4179, 4189, 4199, 4211, 4238, 7929, 4220,
			 4250, 4260, 4275, 4293, 4305, 4315, 4414, 4421, 4428, 4435,
			 4445, 4455, 4462, 4469, 4476, 4483, 4493, 4592, 3399, 3406,
			 4599, 4606, 4613, 4620, 4630, 4637, 4644, 4651, 4661, 4671,
			 4765, 4778, 4785, 4792, 4710, 4800, 4807, 4814, 4824, 4834,
			 7929, 7929, 7929, 7929, 7929, 4924, 7929, 7929, 7929, 7929,
			 7929, 7929, 7929, 7929, 7929, 7929, 7929, 7929, 7929, 7929, yy_Dummy>>,
			1, 200, 400)
		end

	yy_base_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			 7929, 7929, 4857, 4882, 4756, 2690, 3313, 3103, 4760, 3770,
			 3129, 3251, 4303, 4940, 4358,  915,  106, 3263,   96,    0,
			   86, 4809, 4946, 4122, 4771, 4410, 4952, 4128, 4956, 3130,
			 4999, 3635, 1209, 4985, 5010, 2451, 2551, 3190, 5003, 4369,
			 5016, 4573, 5056, 4576, 5051, 4590, 5064, 3788, 5067, 4396,
			 5072, 3806, 5080, 1357, 5105, 4603, 5113, 4398, 4960, 5118,
			 5121, 5007, 5126, 4604, 5129, 3601, 5166, 1434, 5068, 5167,
			 5181, 1435, 5180, 3894, 5184, 4785, 5185, 5197, 5221, 5147,
			 5237, 5225, 5232, 1548, 5240, 1969, 5245, 1549, 5246, 1567,
			 5273, 4607, 5286, 1733, 5291, 5285, 1771, 5297, 5322, 5012,

			 5343, 5254, 5340, 5299, 5347, 2157, 5361, 5324, 5339, 5392,
			 5386, 4763, 5397, 5023, 5411, 5379, 5438, 2190, 5425, 4384,
			 5449, 2290, 5446, 2384, 5452, 5406, 5477, 5459, 5492, 5466,
			 5505, 5418, 5508, 2436, 5513, 2455, 5516, 5521, 5536, 2558,
			 2669, 5508, 5546, 5553, 5561, 5572, 5585, 5592, 5602, 5615,
			 5622, 5632, 5647, 5746, 5753, 5760, 5767, 5774, 5726, 5781,
			 5738, 5788, 5795, 4968, 5331, 3364, 3551, 5876, 3879, 5880,
			 4319, 5884, 4484, 5891, 5898, 5728, 5730, 2456, 5874, 2618,
			 5881, 5737, 5888, 3257, 5902, 5367, 5907, 2771, 5921, 2820,
			 5926, 5517, 5942, 5716, 5950, 5938, 5957, 2834, 5961, 5971, yy_Dummy>>,
			1, 200, 600)
		end

	yy_base_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			 5990, 4946, 5985, 5505, 6004, 6006, 6021, 5986, 6040, 5624,
			 6037, 6054, 6058, 2896, 6061, 6021, 6085, 6060, 6066, 6050,
			 6106, 2913, 6112, 2942, 6101, 2961, 6125, 5747, 6130, 3021,
			 6158, 3191, 6149, 6114, 6173, 6166, 6165, 6179, 6182, 3294,
			 6213, 6123, 6218, 6203, 6219, 6227, 6234, 6242, 6277, 5719,
			 6273, 3359, 6274, 6107, 6280, 6240, 6298, 3403, 6291, 3437,
			 6329, 6340, 6334, 3508, 6338, 6225, 6343, 6335, 6349, 6356,
			 6373, 6382, 7929, 6442, 6463, 4642, 4034, 6467, 6471, 4819,
			 4916, 6475, 4990, 6485, 6490, 3566, 6352, 3692, 6473, 6356,
			 6484, 6287, 6479, 6466, 6500, 3705, 6490, 6524, 6527, 6481,

			 6533, 6545, 6564, 6525, 6548, 3895, 6551, 4032, 6579, 6591,
			 6597, 4083, 6600, 6589, 6605, 6622, 6628, 4104, 6633, 6047,
			 6636, 6653, 6652, 6617, 6661, 6677, 6690, 6682, 6708, 6686,
			 6719, 6684, 6736, 4131, 6733, 6710, 6754, 6712, 6760, 4231,
			 6769, 6764, 6783, 4292, 6797, 4357, 6800, 4432, 6814, 6750,
			 6828, 6753, 6821, 4579, 6835, 6810, 6849, 5209, 5590, 5603,
			 6906, 6916, 6894, 5807, 5753, 6418, 6920, 6924, 7929, 6928,
			 6938, 6781, 6924, 6814, 6923, 4758, 6927, 6931, 6930, 4777,
			 6938, 6949, 6977, 6848, 6985, 6952, 6988, 6347, 6984, 4902,
			 6991, 5080, 6992, 7011, 7039, 5207, 7031, 5298, 7042, 7048, yy_Dummy>>,
			1, 200, 800)
		end

	yy_base_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			 7046, 6827, 7060, 7052, 7067, 7059, 7096, 7100, 7112, 5385,
			 7093, 7113, 7107, 7120, 7150, 5431, 7153,   77, 7178, 7187,
			 7191, 7197, 7209, 7219,   70, 7223, 7228, 7232, 5525, 7215,
			 7199, 7229, 5636, 7218, 5637, 7221, 6627, 7232, 5665, 7256,
			 5895, 7267, 5908, 7270, 6914, 7275, 5959, 7284, 7125, 7291,
			 6099, 7308, 7288, 7331, 6209, 7332, 6261, 7336, 7378,   58,
			 7256, 7392, 7402, 6404, 7386, 7301, 7392, 6502, 7391, 6546,
			 7400, 6558, 7407, 7434, 6575, 7431, 7929, 7516, 7539, 7562,
			 7585, 7608, 7623, 7645, 7659, 7682, 7705, 7728, 7751, 7774,
			 7797, 7811, 7824, 7837, 7859, 7882, 7905, yy_Dummy>>,
			1, 97, 1000)
		end

	yy_def_template: SPECIAL [INTEGER]
			-- Template for `yy_def'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 1096)
			yy_def_template_1 (an_array)
			yy_def_template_2 (an_array)
			yy_def_template_3 (an_array)
			yy_def_template_4 (an_array)
			yy_def_template_5 (an_array)
			yy_def_template_6 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_def_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_def'.
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

			 1085, 1076, 1076, 1076, 1076, 1078, 1076, 1088, 1078, 1078,
			 1078, 1078, 1078, 1078, 1078, 1078, 1078, 1079, 1080, 1080,
			 1080, 1080, 1080, 1080, 1080, 1080, 1089, 1076, 1089, 1089,
			 1089, 1089, 1089, 1089, 1089, 1089, 1076, 1076, 1076, 1076,
			 1076, 1076, 1076, 1090, 1082, 1082, 1082, 1091, 1092, 1093,
			 1082, 1082, 1076, 1076, 1076, 1076, 1076, 1076,   35,   35,
			   35,   35,   35,   35,   35,   62,   62,   62,   62,   62,
			   62,   62, 1076, 1076, 1076, 1076, 1076, 1076, 1076,   35,
			   62,   35,   35,   35,   35,   35,   62,   62,   62,   62,
			   62,   35,   35,   62,   62,   35,   35,   35,   62,   62, yy_Dummy>>,
			1, 200, 0)
		end

	yy_def_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			   62,   35,   35,   35,   62,   62,   62,   35,   35,   35,
			   35,   62,   62,   62,   62,   35,   35,   62,   62,   35,
			   62,   35,   35,   35,   35,   62,   62,   62,   62,   35,
			   62,   35,   62,   35,   35,   35,   62,   62,   62,   35,
			   35,   62,   62,   35,   62,   35,   35,   62,   62,   35,
			   62,   35,   62, 1076, 1083, 1083, 1083, 1083, 1083, 1083,
			 1083, 1083, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076,
			 1076, 1076, 1076, 1076, 1076, 1085, 1085, 1085, 1085, 1085,
			 1085, 1085, 1085, 1076, 1076, 1094, 1095, 1076, 1085, 1086,
			 1087, 1076, 1085, 1086, 1086, 1086, 1086, 1086, 1086, 1086,

			 1085, 1087, 1087, 1087, 1087, 1087, 1087, 1087, 1085, 1085,
			 1085, 1085, 1085, 1085, 1088, 1080, 1080, 1088, 1088, 1088,
			 1088, 1088, 1088, 1088, 1088, 1088, 1078, 1078, 1078, 1078,
			 1078, 1078, 1078, 1078, 1080, 1080, 1080, 1080, 1080, 1080,
			 1089, 1076, 1089, 1089, 1089, 1089, 1089, 1089, 1089, 1089,
			 1089, 1076, 1089, 1089, 1089, 1089, 1089, 1089, 1089, 1089,
			 1089, 1089, 1089, 1089, 1089, 1089, 1089, 1089, 1089, 1089,
			 1089, 1089, 1089, 1089, 1089, 1089, 1089, 1076, 1076, 1076,
			 1076, 1076, 1076, 1082, 1082, 1082, 1091, 1091, 1092, 1092,
			 1093, 1093, 1082, 1082,   35,   62,   35,   62,   35,   35, yy_Dummy>>,
			1, 200, 200)
		end

	yy_def_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			   62,   62,   35,   62,   35,   62,   35,   62, 1076, 1076,
			 1076, 1076, 1076, 1076,   35,   62,   35,   62,   35,   62,
			   35,   62,   35,   62,   35,   62,   35,   35,   35,   62,
			   62,   62,   35,   62,   35,   35,   62,   62,   35,   35,
			   62,   62,   35,   62,   35,   62,   35,   62,   35,   62,
			   35,   35,   35,   35,   35,   62,   62,   62,   62,   62,
			   35,   62,   35,   35,   62,   62,   35,   62,   35,   62,
			   35,   62,   35,   62,   35,   62,   35,   35,   35,   35,
			   35,   35,   62,   62,   62,   62,   62,   62,   35,   35,
			   62,   62,   35,   62,   35,   62,   35,   62,   35,   62,

			   35,   35,   35,   62,   62,   62,   35,   62,   35,   62,
			   35,   62,   35,   62, 1076, 1076, 1083, 1083, 1083, 1083,
			 1083, 1083, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076,
			 1076, 1094, 1094, 1094, 1094, 1094, 1094, 1094, 1076, 1095,
			 1095, 1095, 1095, 1095, 1095, 1095, 1086, 1086, 1086, 1086,
			 1086, 1086, 1087, 1087, 1087, 1087, 1087, 1087, 1085, 1085,
			 1088, 1088, 1088, 1088, 1088, 1088, 1088, 1088, 1088, 1088,
			 1078, 1078, 1080, 1080, 1089, 1089, 1089, 1089, 1089, 1089,
			 1076, 1076, 1076, 1076, 1076, 1089, 1076, 1076, 1076, 1076,
			 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, yy_Dummy>>,
			1, 200, 400)
		end

	yy_def_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			 1076, 1076, 1089, 1089, 1076, 1076, 1076, 1076, 1076, 1076,
			 1076, 1076, 1076, 1082, 1082, 1091, 1091, 1092, 1092,  390,
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
			   62,   35,   62,   35,   62,   35,   62,   35,   62,   35, yy_Dummy>>,
			1, 200, 600)
		end

	yy_def_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
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
			1, 200, 800)
		end

	yy_def_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_def'.
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
			-- Template for `yy_ec'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 256)
			yy_ec_template_1 (an_array)
			yy_ec_template_2 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_ec_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
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
			   93,   93,    1,    1,   94,   94,   94,   94,   94,   94, yy_Dummy>>,
			1, 200, 0)
		end

	yy_ec_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   94,   94,   94,   94,   94,   94,   94,   94,   94,   94,
			   94,   94,   94,   94,   94,   94,   94,   94,   94,   94,
			   94,   94,   94,   94,   95,   96,   96,   96,   96,   96,
			   96,   96,   96,   96,   96,   96,   96,   97,   98,   98,
			    1,   99,   99,   99,  100,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1, yy_Dummy>>,
			1, 57, 200)
		end

	yy_meta_template: SPECIAL [INTEGER]
			-- Template for `yy_meta'
		once
			Result := yy_fixed_array (<<
			    0,    1,    2,    3,    4,    5,    1,    6,    1,    1,
			    7,    8,    1,    1,    1,    1,    1,    1,    9,    1,
			   10,   11,   12,   13,    1,    1,    1,    1,    1,    1,
			   10,   10,   10,   10,   10,   10,   10,   10,   10,   10,
			   10,   10,   10,   10,   10,   10,   10,   10,   10,   10,
			   10,   10,   14,   15,   16,   17,    1,    1,    1,    1,
			   10,   18,   10,   10,   10,   10,   10,   10,   10,   10,
			   10,   10,   10,   10,   10,   10,   10,   10,   10,   10,
			   10,   10,   10,   10,   19,   20,   21,   22,    1,    1,
			    1,    1,    1,    1,   23,   23,   23,   23,   23,   23,

			   23, yy_Dummy>>)
		end

	yy_accept_template: SPECIAL [INTEGER]
			-- Template for `yy_accept'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 1077)
			yy_accept_template_1 (an_array)
			yy_accept_template_2 (an_array)
			yy_accept_template_3 (an_array)
			yy_accept_template_4 (an_array)
			yy_accept_template_5 (an_array)
			yy_accept_template_6 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_accept_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_accept'.
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

			  283,  285,  286,  287,  288,  289,  290,  291,  292,  295,
			  298,  299,  300,  301,  302,  303,  304,  305,  306,  307,
			  308,  309,  310,  311,  312,  313,  314,  315,  315,  316,
			  317,  318,  319,  320,  321,  322,  323,  324,  325,  326,
			  328,  329,  330,  331,  331,  333,  335,  336,  338,  339,
			  340,  340,  342,  343,  344,  345,  346,  347,  348,  350,
			  352,  354,  356,  358,  361,  363,  364,  365,  366,  367,
			  368,  370,  371,  371,  371,  371,  371,  371,  371,  371,
			  373,  374,  376,  378,  380,  382,  384,  385,  386,  387,
			  388,  389,  391,  394,  395,  397,  399,  401,  403,  404, yy_Dummy>>,
			1, 200, 0)
		end

	yy_accept_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			  405,  406,  408,  410,  412,  413,  414,  415,  418,  420,
			  422,  425,  427,  428,  429,  431,  433,  435,  436,  437,
			  439,  440,  442,  444,  446,  449,  450,  451,  452,  454,
			  456,  457,  459,  460,  462,  464,  466,  467,  468,  469,
			  471,  473,  474,  475,  477,  478,  480,  482,  483,  484,
			  486,  487,  489,  490,  491,  491,  491,  491,  491,  491,
			  491,  491,  491,  491,  491,  491,  491,  491,  491,  491,
			  491,  491,  491,  491,  491,  491,  492,  493,  494,  495,
			  496,  497,  498,  499,  500,  500,  500,  500,  501,  502,
			  503,  504,  505,  507,  508,  509,  510,  511,  512,  513,

			  514,  516,  517,  518,  519,  520,  521,  522,  523,  524,
			  525,  526,  527,  528,  529,  529,  531,  533,  533,  533,
			  533,  533,  533,  533,  533,  533,  533,  535,  537,  538,
			  539,  540,  541,  542,  543,  544,  545,  546,  547,  548,
			  549,  550,  551,  552,  553,  554,  555,  556,  557,  558,
			  559,  560,  560,  561,  562,  563,  564,  565,  566,  567,
			  568,  569,  570,  571,  572,  573,  574,  575,  576,  577,
			  578,  579,  580,  581,  582,  583,  584,  585,  587,  587,
			  587,  588,  590,  591,  593,  595,  595,  598,  600,  603,
			  605,  608,  610,  612,  612,  614,  615,  617,  618,  620, yy_Dummy>>,
			1, 200, 200)
		end

	yy_accept_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			  623,  624,  626,  629,  631,  633,  634,  636,  637,  637,
			  637,  637,  637,  637,  637,  640,  642,  644,  645,  647,
			  648,  650,  651,  653,  654,  656,  657,  659,  661,  663,
			  664,  665,  666,  668,  669,  672,  674,  676,  677,  679,
			  681,  682,  683,  685,  686,  688,  689,  691,  692,  694,
			  695,  697,  699,  701,  703,  705,  706,  707,  708,  709,
			  710,  712,  713,  715,  717,  718,  719,  722,  724,  726,
			  727,  730,  732,  734,  735,  737,  738,  740,  742,  744,
			  746,  748,  750,  751,  752,  753,  754,  755,  756,  758,
			  760,  761,  762,  764,  765,  767,  768,  770,  771,  773,

			  774,  776,  778,  780,  781,  782,  783,  785,  786,  788,
			  789,  791,  792,  795,  797,  798,  799,  799,  799,  799,
			  799,  799,  799,  799,  799,  799,  799,  799,  799,  799,
			  799,  800,  800,  800,  800,  800,  800,  800,  800,  801,
			  801,  801,  801,  801,  801,  801,  801,  802,  803,  804,
			  805,  806,  807,  808,  809,  810,  811,  812,  813,  814,
			  815,  816,  817,  817,  818,  818,  818,  818,  818,  818,
			  818,  819,  820,  821,  822,  823,  824,  825,  826,  827,
			  828,  829,  830,  831,  832,  833,  834,  835,  836,  837,
			  838,  839,  840,  841,  842,  843,  844,  845,  846,  847, yy_Dummy>>,
			1, 200, 400)
		end

	yy_accept_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			  848,  849,  850,  851,  852,  854,  854,  856,  856,  858,
			  858,  858,  858,  860,  862,  864,  864,  864,  864,  864,
			  864,  864,  866,  868,  870,  871,  873,  874,  876,  877,
			  879,  880,  882,  884,  885,  886,  886,  886,  888,  889,
			  891,  892,  894,  895,  897,  898,  900,  901,  903,  904,
			  906,  907,  909,  910,  913,  915,  917,  918,  920,  922,
			  923,  924,  926,  927,  929,  930,  932,  933,  936,  938,
			  940,  941,  943,  944,  946,  947,  949,  950,  952,  953,
			  955,  956,  958,  959,  962,  964,  966,  967,  970,  972,
			  975,  977,  979,  980,  983,  985,  987,  989,  990,  991,

			  993,  994,  996,  997,  999, 1000, 1002, 1003, 1005, 1007,
			 1008, 1009, 1011, 1012, 1014, 1015, 1017, 1018, 1021, 1023,
			 1025, 1026, 1029, 1031, 1034, 1036, 1038, 1039, 1041, 1042,
			 1044, 1045, 1047, 1048, 1051, 1053, 1056, 1058, 1058, 1058,
			 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058,
			 1058, 1058, 1058, 1058, 1059, 1060, 1061, 1062, 1062, 1062,
			 1062, 1063, 1064, 1065, 1066, 1068, 1068, 1068, 1070, 1070,
			 1074, 1074, 1076, 1076, 1076, 1078, 1080, 1081, 1084, 1086,
			 1089, 1091, 1093, 1094, 1096, 1097, 1099, 1100, 1103, 1105,
			 1108, 1110, 1112, 1113, 1115, 1116, 1118, 1119, 1122, 1124, yy_Dummy>>,
			1, 200, 600)
		end

	yy_accept_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			 1126, 1127, 1129, 1130, 1132, 1133, 1135, 1136, 1138, 1139,
			 1141, 1142, 1144, 1145, 1148, 1150, 1152, 1153, 1155, 1156,
			 1158, 1159, 1161, 1162, 1165, 1167, 1169, 1170, 1172, 1173,
			 1175, 1176, 1179, 1181, 1183, 1184, 1186, 1187, 1189, 1190,
			 1192, 1193, 1195, 1196, 1198, 1199, 1201, 1202, 1204, 1205,
			 1207, 1208, 1211, 1213, 1215, 1216, 1218, 1219, 1222, 1224,
			 1226, 1227, 1229, 1230, 1233, 1235, 1237, 1238, 1238, 1238,
			 1238, 1238, 1238, 1239, 1239, 1241, 1241, 1242, 1243, 1247,
			 1247, 1247, 1249, 1249, 1250, 1250, 1253, 1255, 1258, 1260,
			 1262, 1263, 1265, 1266, 1268, 1269, 1272, 1274, 1276, 1277,

			 1279, 1280, 1282, 1283, 1285, 1286, 1289, 1291, 1294, 1296,
			 1298, 1299, 1302, 1304, 1306, 1307, 1309, 1310, 1313, 1315,
			 1317, 1318, 1320, 1321, 1323, 1324, 1326, 1327, 1329, 1330,
			 1332, 1333, 1335, 1336, 1339, 1341, 1343, 1344, 1346, 1347,
			 1350, 1352, 1354, 1355, 1358, 1360, 1363, 1365, 1368, 1370,
			 1372, 1373, 1375, 1376, 1379, 1381, 1383, 1384, 1384, 1385,
			 1385, 1385, 1385, 1389, 1389, 1390, 1391, 1391, 1391, 1392,
			 1393, 1394, 1396, 1397, 1399, 1400, 1403, 1405, 1407, 1408,
			 1411, 1413, 1415, 1416, 1418, 1419, 1421, 1422, 1424, 1425,
			 1428, 1430, 1433, 1435, 1437, 1438, 1441, 1443, 1446, 1448, yy_Dummy>>,
			1, 200, 800)
		end

	yy_accept_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			 1450, 1451, 1453, 1454, 1456, 1457, 1459, 1460, 1462, 1463,
			 1466, 1468, 1470, 1471, 1473, 1474, 1477, 1479, 1480, 1480,
			 1481, 1481, 1483, 1483, 1483, 1484, 1485, 1485, 1486, 1489,
			 1491, 1493, 1494, 1497, 1499, 1502, 1504, 1506, 1507, 1510,
			 1512, 1515, 1517, 1520, 1522, 1524, 1525, 1528, 1530, 1532,
			 1533, 1536, 1538, 1540, 1541, 1544, 1546, 1549, 1551, 1552,
			 1554, 1554, 1556, 1557, 1560, 1562, 1564, 1565, 1568, 1570,
			 1573, 1575, 1578, 1580, 1582, 1585, 1587, 1587, yy_Dummy>>,
			1, 78, 1000)
		end

	yy_acclist_template: SPECIAL [INTEGER]
			-- Template for `yy_acclist'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 1586)
			yy_acclist_template_1 (an_array)
			yy_acclist_template_2 (an_array)
			yy_acclist_template_3 (an_array)
			yy_acclist_template_4 (an_array)
			yy_acclist_template_5 (an_array)
			yy_acclist_template_6 (an_array)
			yy_acclist_template_7 (an_array)
			yy_acclist_template_8 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_acclist_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			    0,  147,  147,  169,  167,  168,    2,  167,  168,    4,
			  168,    5,  167,  168,    1,  167,  168,   11,  167,  168,
			  149,  167,  168,  113,  167,  168,   18,  167,  168,  149,
			  167,  168,  167,  168,   12,  167,  168,   13,  167,  168,
			   33,  167,  168,   32,  167,  168,    9,  167,  168,   31,
			  167,  168,    7,  167,  168,   34,  167,  168,  151,  158,
			  167,  168,  151,  158,  167,  168,  151,  158,  167,  168,
			   10,  167,  168,    8,  167,  168,   38,  167,  168,   36,
			  167,  168,   37,  167,  168,  167,  168,  111,  112,  167,
			  168,  111,  112,  167,  168,  111,  112,  167,  168,  111,

			  112,  167,  168,  111,  112,  167,  168,  111,  112,  167,
			  168,  111,  112,  167,  168,  111,  112,  167,  168,  111,
			  112,  167,  168,  111,  112,  167,  168,  111,  112,  167,
			  168,  111,  112,  167,  168,  111,  112,  167,  168,  111,
			  112,  167,  168,  111,  112,  167,  168,  111,  112,  167,
			  168,  111,  112,  167,  168,  111,  112,  167,  168,  111,
			  112,  167,  168,   16,  167,  168,  167,  168,   17,  167,
			  168,   35,  167,  168,  167,  168,  112,  167,  168,  112,
			  167,  168,  112,  167,  168,  112,  167,  168,  112,  167,
			  168,  112,  167,  168,  112,  167,  168,  112,  167,  168, yy_Dummy>>,
			1, 200, 0)
		end

	yy_acclist_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  112,  167,  168,  112,  167,  168,  112,  167,  168,  112,
			  167,  168,  112,  167,  168,  112,  167,  168,  112,  167,
			  168,  112,  167,  168,  112,  167,  168,  112,  167,  168,
			  112,  167,  168,   14,  167,  168,   15,  167,  168,   39,
			  167,  168,  167,  168,  167,  168,  167,  168,  167,  168,
			  167,  168,  167,  168,  167,  168,  147,  168,  143,  168,
			  145,  168,  146,  147,  168,  142,  168,  147,  168,  147,
			  168,  147,  168,  147,  168,  147,  168,  147,  168,  147,
			  168,  147,  168,  147,  168,    2,    3,    1,   40,  149,
			  148,  148, -138,  149, -306, -139,  149, -307,  149,  149,

			  149,  149,  149,  149,  149,  113,  149,  149,  149,  149,
			  149,  149,  149,  149,  137,  137,  137,  137,  137,  137,
			  137,  137,  137,    6,   24,   25,  161,  164,   19,   21,
			   30,  151,  158,  151,  158,  158,  150,  158,  158,  158,
			  150,  158,   29,   26,   23,   22,   27,   28,  111,  112,
			  111,  112,  111,  112,  111,  112,  111,  112,   45,  111,
			  112,  111,  112,  112,  112,  112,  112,  112,   45,  112,
			  112,  111,  112,  112,  111,  112,  111,  112,  111,  112,
			  111,  112,  111,  112,  112,  112,  112,  112,  112,  111,
			  112,   56,  111,  112,  112,   56,  112,  111,  112,  111, yy_Dummy>>,
			1, 200, 200)
		end

	yy_acclist_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  112,  111,  112,  112,  112,  112,  111,  112,  111,  112,
			  111,  112,  112,  112,  112,   68,  111,  112,  111,  112,
			  111,  112,  110,  111,  112,   68,  112,  112,  112,  110,
			  112,  111,  112,  111,  112,  112,  112,  111,  112,  112,
			  111,  112,  111,  112,  111,  112,   81,  111,  112,  112,
			  112,  112,   81,  112,  111,  112,  112,  111,  112,  112,
			  111,  112,  111,  112,  111,  112,  112,  112,  112,  111,
			  112,  111,  112,  112,  112,  111,  112,  112,  111,  112,
			  111,  112,  112,  112,  111,  112,  112,  111,  112,  112,
			   20,  147,  147,  147,  147,  147,  147,  147,  147,  143,

			  144,  147,  147,  147,  142,  140,  147,  147,  147,  147,
			  147,  147,  147,  147,  141,  147,  147,  147,  147,  147,
			  147,  147,  147,  147,  147,  147,  147,  147,  147,  148,
			  149,  148,  149, -138,  149, -139,  149,  149,  149,  149,
			  149,  149,  149,  149,  149,  149,  149,  149,  149,  137,
			  114,  137,  137,  137,  137,  137,  137,  137,  137,  137,
			  137,  137,  137,  137,  137,  137,  137,  137,  137,  137,
			  137,  137,  137,  137,  137,  137,  137,  137,  137,  137,
			  137,  137,  137,  137,  137,  161,  164,  159,  161,  164,
			  159,  151,  158,  151,  158,  154,  157,  158,  157,  158, yy_Dummy>>,
			1, 200, 400)
		end

	yy_acclist_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  153,  156,  158,  156,  158,  152,  155,  158,  155,  158,
			  151,  158,  111,  112,  112,  111,  112,  112,  111,  112,
			   43,  111,  112,  112,   43,  112,   44,  111,  112,   44,
			  112,  111,  112,  112,  111,  112,  112,   47,  111,  112,
			   47,  112,  111,  112,  112,  111,  112,  112,  111,  112,
			  112,  111,  112,  112,  111,  112,  112,  111,  112,  111,
			  112,  111,  112,  112,  112,  112,  111,  112,  112,   59,
			  111,  112,  111,  112,   59,  112,  112,  111,  112,  111,
			  112,  112,  112,  111,  112,  112,  111,  112,  112,  111,
			  112,  112,  111,  112,  112,  111,  112,  111,  112,  111,

			  112,  111,  112,  111,  112,  112,  112,  112,  112,  112,
			  111,  112,  112,  111,  112,  111,  112,  112,  112,   77,
			  111,  112,   77,  112,  111,  112,  112,   79,  111,  112,
			   79,  112,  111,  112,  112,  111,  112,  112,  111,  112,
			  111,  112,  111,  112,  111,  112,  111,  112,  111,  112,
			  112,  112,  112,  112,  112,  112,  111,  112,  111,  112,
			  112,  112,  111,  112,  112,  111,  112,  112,  111,  112,
			  112,  111,  112,  112,  111,  112,  111,  112,  111,  112,
			  112,  112,  112,  111,  112,  112,  111,  112,  112,  111,
			  112,  112,  102,  111,  112,  102,  112,  166,  165,  140, yy_Dummy>>,
			1, 200, 600)
		end

	yy_acclist_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  141,  147,  147,  147,  147,  147,  147,  147,  147,  147,
			  147,  147,  147,  147,  147,  148,  148,  148,  149,  149,
			  149,  149,  137,  137,  137,  137,  137,  137,  131,  129,
			  130,  132,  133,  137,  134,  135,  115,  116,  117,  118,
			  119,  120,  121,  122,  123,  124,  125,  126,  127,  128,
			  137,  137,  161,  164,  161,  164,  161,  164,  160,  163,
			  151,  158,  151,  158,  151,  158,  151,  158,  111,  112,
			  112,  111,  112,  112,  111,  112,  112,  111,  112,  112,
			  111,  112,  111,  112,  112,  112,  111,  112,  112,  111,
			  112,  112,  111,  112,  112,  111,  112,  112,  111,  112,

			  112,  111,  112,  112,  111,  112,  112,  111,  112,  112,
			   57,  111,  112,   57,  112,  111,  112,  112,  111,  112,
			  111,  112,  112,  112,  111,  112,  112,  111,  112,  112,
			  111,  112,  112,   66,  111,  112,  111,  112,   66,  112,
			  112,  111,  112,  112,  111,  112,  112,  111,  112,  112,
			  111,  112,  112,  111,  112,  112,  111,  112,  112,   74,
			  111,  112,   74,  112,  111,  112,  112,   76,  111,  112,
			   76,  112,  107,  111,  112,  107,  112,  111,  112,  112,
			   80,  111,  112,   80,  112,  111,  112,  111,  112,  112,
			  112,  111,  112,  112,  111,  112,  112,  111,  112,  112, yy_Dummy>>,
			1, 200, 800)
		end

	yy_acclist_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  111,  112,  112,  111,  112,  111,  112,  112,  112,  111,
			  112,  112,  111,  112,  112,  111,  112,  112,  108,  111,
			  112,  108,  112,  111,  112,  112,   94,  111,  112,   94,
			  112,   95,  111,  112,   95,  112,  111,  112,  112,  111,
			  112,  112,  111,  112,  112,  111,  112,  112,  100,  111,
			  112,  100,  112,  101,  111,  112,  101,  112,  147,  147,
			  147,  147,  137,  137,  137,  161,  161,  164,  161,  164,
			  160,  161,  163,  164,  160,  163,  151,  158,  111,  112,
			  112,   41,  111,  112,   41,  112,   42,  111,  112,   42,
			  112,  111,  112,  112,  111,  112,  112,  111,  112,  112,

			   48,  111,  112,   48,  112,   49,  111,  112,   49,  112,
			  111,  112,  112,  111,  112,  112,  111,  112,  112,   54,
			  111,  112,   54,  112,  111,  112,  112,  111,  112,  112,
			  111,  112,  112,  111,  112,  112,  111,  112,  112,  111,
			  112,  112,  111,  112,  112,   64,  111,  112,   64,  112,
			  111,  112,  112,  111,  112,  112,  111,  112,  112,  111,
			  112,  112,   70,  111,  112,   70,  112,  111,  112,  112,
			  111,  112,  112,  111,  112,  112,   75,  111,  112,   75,
			  112,  111,  112,  112,  111,  112,  112,  111,  112,  112,
			  111,  112,  112,  111,  112,  112,  111,  112,  112,  111, yy_Dummy>>,
			1, 200, 1000)
		end

	yy_acclist_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  112,  112,  111,  112,  112,  111,  112,  112,   90,  111,
			  112,   90,  112,  111,  112,  112,  111,  112,  112,   93,
			  111,  112,   93,  112,  111,  112,  112,  111,  112,  112,
			   98,  111,  112,   98,  112,  111,  112,  112,  136,  161,
			  164,  164,  161,  160,  161,  163,  164,  160,  163,  159,
			  103,  111,  112,  103,  112,   46,  111,  112,   46,  112,
			  111,  112,  112,  111,  112,  112,  111,  112,  112,   51,
			  111,  112,  111,  112,   51,  112,  112,  111,  112,  112,
			  111,  112,  112,  111,  112,  112,   58,  111,  112,   58,
			  112,   60,  111,  112,   60,  112,  111,  112,  112,   62,

			  111,  112,   62,  112,  111,  112,  112,  111,  112,  112,
			   67,  111,  112,   67,  112,  111,  112,  112,  111,  112,
			  112,  111,  112,  112,  111,  112,  112,  111,  112,  112,
			  111,  112,  112,  111,  112,  112,   83,  111,  112,   83,
			  112,  111,  112,  112,  111,  112,  112,   86,  111,  112,
			   86,  112,  111,  112,  112,   88,  111,  112,   88,  112,
			   89,  111,  112,   89,  112,   91,  111,  112,   91,  112,
			  111,  112,  112,  111,  112,  112,   97,  111,  112,   97,
			  112,  111,  112,  112,  161,  160,  161,  163,  164,  164,
			  160,  162,  164,  162,  111,  112,  112,  111,  112,  112, yy_Dummy>>,
			1, 200, 1200)
		end

	yy_acclist_template_8 (an_array: ARRAY [INTEGER])
			-- Fill chunk #8 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			   50,  111,  112,   50,  112,  111,  112,  112,   53,  111,
			  112,   53,  112,  111,  112,  112,  111,  112,  112,  111,
			  112,  112,  111,  112,  112,   65,  111,  112,   65,  112,
			   69,  111,  112,   69,  112,  111,  112,  112,   71,  111,
			  112,   71,  112,   72,  111,  112,   72,  112,  111,  112,
			  112,  111,  112,  112,  111,  112,  112,  111,  112,  112,
			  111,  112,  112,   87,  111,  112,   87,  112,  111,  112,
			  112,  111,  112,  112,   99,  111,  112,   99,  112,  164,
			  164,  160,  161,  163,  164,  163,  104,  111,  112,  104,
			  112,  111,  112,  112,   52,  111,  112,   52,  112,   55,

			  111,  112,   55,  112,  111,  112,  112,   61,  111,  112,
			   61,  112,   63,  111,  112,   63,  112,  109,  111,  112,
			  109,  112,  111,  112,  112,   78,  111,  112,   78,  112,
			  111,  112,  112,   85,  111,  112,   85,  112,  111,  112,
			  112,   92,  111,  112,   92,  112,   96,  111,  112,   96,
			  112,  164,  163,  164,  163,  164,  163,  105,  111,  112,
			  105,  112,  111,  112,  112,   73,  111,  112,   73,  112,
			   82,  111,  112,   82,  112,   84,  111,  112,   84,  112,
			  163,  164,  106,  111,  112,  106,  112, yy_Dummy>>,
			1, 187, 1400)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER = 7929
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

	yyNb_rules: INTEGER = 168
			-- Number of rules

	yyEnd_of_buffer: INTEGER = 169
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
	copyright:	"Copyright (c) 1984-2011, Eiffel Software"
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
