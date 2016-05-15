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
						
when 165 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

					curr_token := new_text (text)
					update_token_list
					
when 166 then
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
				
when 167 then
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
			create an_array.make_filled (0, 0, 8020)
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
			  139,  140,  158,   88,   89,   90,   91,  137,  878,  141,
			  143, 1075,  144,  144,  145,  145,  153,  154,  155,  156,
			  771,  106,  231,  151,  107,  191,  158,  764,  106,  158,
			  127,  107,  127,  127,  165,  192,  619,  143,  128,  145,
			  145,  145,  145,  215,  158,  158,  617,   92,  195,  216,
			  196, 1075,  150,  385,  232,  151,  615,  193,  165,   92,
			  197,  165,  158,  158,  158,  158,  619,  194,  271,  271,
			  108,  229,  142,  249,  158,  217,  165,  165,   93,  150,
			  198,  218,  199,   94,   95,   96,   97,   98,   99,  100, yy_Dummy>>,
			1, 200, 0)
		end

	yy_nxt_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			   93,  617,  200,  385,  165,   94,   95,   96,   97,   98,
			   99,  100,  109,  230,  615,  250,  165,  581,  110,  111,
			  112,  113,  114,  115,  116,  119,  120,  121,  122,  123,
			  124,  125,  129,  130,  131,  132,  133,  134,  135,  143,
			  158,  144,  144,  145,  145,  526,  219,  201,  410,  410,
			  158,  202,  147,  148,  158,  158,  179,  158,  233,  158,
			  158,  158,  158,  251,  203,  243,  158,  158,  234,  158,
			  239,  158,  165,  235,  149,  270,  270,  270,  220,  204,
			  240,  150,  165,  205,  147,  148,  165,  165,  180,  165,
			  236,  165,  165,  165,  165,  252,  206,  244,  165,  165,

			  237,  165,  241,  165, 1075,  238,  149,  158,  158,  158,
			  158,  521,  242,  272,  272,  272,  158,  158,  158,  159,
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
			  186,  165,  225,  103,  187,  523,  523,  188,  211,  165,
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
			  238,  165,  382,  165,  165,  628,  448,  242,  165,  232,
			  244,  386,  386,  165,  102,  418,  165,  236,  165,  101,

			  165, 1075, 1075,  158,  165, 1075,  165,  237,  165,  241,
			  247,  165,  238,  165,  382,  165,  165,  629,  449,  242,
			  165,  165,  244,  165,  248,  165,  165,  419,  165,  252,
			  250,  614,  165,  165,  165,  165,  165,  284,  165,  284,
			  291,  422,  247,  158, 1075,  158,  165,  284,  287,  288,
			  284, 1075, 1075,  165, 1075,  165,  248, 1075,  165, 1075,
			  165,  252,  250, 1075,  285,  165,  165,  285,  165,  292,
			  165,  286,  275,  423,  286,  165,  300,  165,  165,  275,
			  308,  276,  277,  278,  279,  280,  281,  282,  165,  165,
			  165,  310,  310,  285,  276,  277,  278,  279,  280,  281, yy_Dummy>>,
			1, 200, 600)
		end

	yy_nxt_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  282,  158, 1075,  289,  309,  309,  309,  276,  277,  278,
			  279,  280,  281,  282,  311,  311,  311,  276,  277,  278,
			  279,  280,  281,  282,  286,  522,  522,  522,  524,  524,
			  524, 1075,  106,  165,  290,  107,  525,  525,  525,  276,
			  277,  278,  279,  280,  281,  282,  312,  312,  312,  276,
			  277,  278,  279,  280,  281,  282,  293,  294,  295,  296,
			  297,  298,  299,  301,  302,  303,  304,  305,  306,  307,
			  313, 1075,  158,  276,  277,  278,  279,  280,  281,  282,
			 1075,  108, 1075,  414,  158,  326,  460,  326,  326, 1075,
			  106, 1075,  143,  107,  383,  383,  384,  384,  327, 1075,

			  327,  327, 1075,  106,  165,  151,  107, 1075, 1075,  158,
			  158,  158,  158,  109,  420,  415,  165, 1075,  461,  110,
			  111,  112,  113,  114,  115,  116,  315,  674, 1075,  316,
			  118,  118,  118, 1075,  150,  386,  386,  151,  317,  108,
			  106,  165,  158,  107, 1075,  118,  421,  118, 1075,  118,
			  118,  318,  108, 1075,  118,  106,  118, 1075,  107,  675,
			  118, 1075,  118, 1075, 1075,  118,  118,  118,  118,  118,
			  118,  109, 1075,  106,  165,  614,  107,  110,  111,  112,
			  113,  114,  115,  116,  109,  106, 1075, 1075,  107,  108,
			  110,  111,  112,  113,  114,  115,  116,  158,  158,  158, yy_Dummy>>,
			1, 200, 800)
		end

	yy_nxt_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  106, 1075, 1075,  107,  108,  158,  158,  158,  158,  158,
			  158, 1075, 1075,  319,  320,  321,  322,  323,  324,  325,
			  106,  109,  108,  107,  527,  527,  527,  110,  111,  112,
			  113,  114,  115,  116,  106, 1075,  109,  107,  528,  528,
			  528,  328,  110,  111,  112,  113,  114,  115,  116,  108,
			  106, 1075, 1075,  107,  109, 1075, 1075,  329,  329,  329,
			  110,  111,  112,  113,  114,  115,  116,  106,  158,  108,
			  107,  442,  119,  120,  121,  122,  123,  124,  125,  106,
			 1075,  109,  107,  108,  330,  330, 1075,  110,  111,  112,
			  113,  114,  115,  116,  106, 1075,  718,  107,  728,  108,

			  165,  109, 1075,  443,  331,  331,  331,  110,  111,  112,
			  113,  114,  115,  116,  106,  109, 1075,  107,  332,  332,
			  332,  110,  111,  112,  113,  114,  115,  116,  719,  106,
			  729,  109,  107, 1075,  333, 1075, 1075,  110,  111,  112,
			  113,  114,  115,  116,  106, 1075, 1075,  107,  377,  377,
			  377,  377, 1075, 1075,  119,  120,  121,  122,  123,  124,
			  125,  106,  378, 1075,  107,  334,  119,  120,  121,  122,
			  123,  124,  125,  341,  606,  606,  606,  606,  335,  335,
			  335,  119,  120,  121,  122,  123,  124,  125,  379, 1075,
			 1075,  474,  730,  158,  378,  158, 1075, 1075,  336,  336, yy_Dummy>>,
			1, 200, 1000)
		end

	yy_nxt_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			 1075,  119,  120,  121,  122,  123,  124,  125,  283, 1075,
			  284,  284, 1075,  337,  337,  337,  119,  120,  121,  122,
			  123,  124,  125,  475,  731,  165,  341,  165,  338,  338,
			  338,  119,  120,  121,  122,  123,  124,  125,  341, 1075,
			  472,  392,  392,  392,  392,  339,  158,  784,  119,  120,
			  121,  122,  123,  124,  125,  341,  342,  343,  344,  345,
			  346,  347,  348,  349,  285, 1075,  350,  351,  352,  353,
			 1075, 1075,  473, 1075, 1075,  354, 1075,  341,  165,  785,
			 1075,  393,  355, 1075,  356,  158,  357,  358,  359,  360,
			  341,  361, 1075,  362, 1075,  286,  466,  363, 1075,  364,

			  341, 1075,  365,  366,  367,  368,  369,  370,  371,  342,
			  343,  344,  345,  346,  347,  348,  341,  165,  126,  126,
			  126,  342,  343,  344,  345,  346,  347,  348,  467,  388,
			  388,  388,  158,  158,  158,  372,  372,  372,  342,  343,
			  344,  345,  346,  347,  348,  158,  158,  158, 1075, 1075,
			  342,  343,  344,  345,  346,  347,  348,  373,  373, 1075,
			  342,  343,  344,  345,  346,  347,  348, 1075, 1075,  616,
			  374,  374,  374,  342,  343,  344,  345,  346,  347,  348,
			  375,  375,  375,  342,  343,  344,  345,  346,  347,  348,
			  158,  158,  158, 1075,  158,  802,  376, 1075,  492,  342, yy_Dummy>>,
			1, 200, 1200)
		end

	yy_nxt_template_8 (an_array: ARRAY [INTEGER])
			-- Fill chunk #8 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  343,  344,  345,  346,  347,  348,  390,  390,  390,  390,
			  165, 1075,  165,  158,  158,  158,  390,  390,  390,  390,
			  390,  390,  165,  165,  397,  165,  165,  803,  158,  395,
			  493,  165, 1075,  165, 1075,  165, 1075, 1075,  432,  634,
			  634,  634,  165,  165,  165, 1075,  385, 1075,  390,  390,
			  390,  390,  390,  390,  165,  165,  397,  165,  403,  400,
			  165,  395,  401,  165,  165,  165,  165,  165,  165,  165,
			  433,  165,  158,  818,  165,  165,  405,  165,  165,  165,
			  165,  165,  165, 1075,  158,  407, 1075, 1075,  415,  165,
			  403,  400,  165,  424,  401, 1075,  165, 1075,  165, 1075,

			  165,  165, 1075,  165,  165,  819,  165, 1075,  405,  165,
			  165,  165,  165,  165,  165,  444,  165,  407,  419,  417,
			  415,  165, 1075,  158,  165,  425,  165,  423,  165,  165,
			  165,  165,  421,  165,  165,  165,  165,  158,  165,  425,
			 1075,  165,  165,  622, 1075,  165,  165,  445, 1075, 1075,
			  419,  417,  635,  635,  635,  165, 1075, 1075,  165,  423,
			  165,  165,  165,  165,  421,  165,  165,  165,  165,  165,
			  165,  425,  426,  165,  165,  623,  427,  165,  165,  158,
			  165,  429,  165,  434,  158,  430,  158,  158,  158,  158,
			  428,  165,  165,  165,  468,  165,  438,  165,  435,  431, yy_Dummy>>,
			1, 200, 1400)
		end

	yy_nxt_template_9 (an_array: ARRAY [INTEGER])
			-- Fill chunk #9 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  439, 1075,  433,  165,  429,  158, 1075,  165,  430, 1075,
			 1075,  165,  165,  429,  165,  436,  165,  430,  165,  165,
			  165,  165,  431,  165,  165,  165,  469,  165,  440,  165,
			  437,  431,  441,  436,  433,  165,  626,  165,  165,  165,
			  165,  165,  440,  165,  158,  443,  441,  165,  437, 1075,
			  165,  470,  165,  165,  165,  447,  158,  165,  445,  642,
			  165,  165,  165, 1075,  165,  436, 1075,  158,  627,  165,
			  165,  165,  165,  165,  440,  165,  165,  443,  441,  165,
			  437,  165,  165,  471,  165,  165,  165,  447,  165,  165,
			  445,  643,  165,  450,  165,  451,  165,  452,  158,  165,

			  165,  165,  165,  165,  165,  165,  158,  165,  453,  449,
			  496,  454,  165,  165,  158,  494,  158,  165,  165,  165,
			  165,  624, 1075, 1075,  165,  455,  165,  456, 1075,  457,
			  165, 1075,  165, 1075,  165, 1075,  165,  165,  165,  165,
			  458,  449,  497,  459,  165,  462,  165,  495,  165,  165,
			  455,  158,  456,  625,  457,  510, 1075,  463,  165,  158,
			  165,  461,  165,  158,  165,  458,  158,  464,  459,  670,
			  165,  158,  506,  165,  165,  165,  165,  464,  165,  465,
			 1075,  467,  455,  165,  456,  165,  457,  511,  165,  465,
			  165,  165,  165,  461,  165,  165,  165,  458,  165,  464, yy_Dummy>>,
			1, 200, 1600)
		end

	yy_nxt_template_10 (an_array: ARRAY [INTEGER])
			-- Fill chunk #10 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  459,  671,  165,  165,  507,  165,  165,  165,  165,  836,
			  165,  465,  165,  467,  165,  471,  636,  165,  473,  469,
			  165,  158,  158,  165,  165,  165,  165,  165,  165,  165,
			  512,  158, 1075,  475, 1075,  165, 1075,  690,  165,  165,
			  165,  837,  165, 1075,  165, 1075,  165,  471,  637, 1075,
			  473,  469,  165,  165,  165,  165,  165,  165,  165,  165,
			  165,  165,  513,  165,  490,  475,  165,  165,  491,  691,
			  165,  165,  165,  476,  165,  477,  165,  500,  158,  165,
			  493,  165,  501,  478,  165,  158,  479,  158,  480,  481,
			 1075,  165, 1075,  502,  158,  638,  490,  488,  165,  646,

			  491,  489,  165,  165,  165,  482, 1075,  483,  165,  503,
			  165,  165,  493,  165,  504,  484, 1075,  165,  485,  165,
			  486,  487,  482,  165,  483,  505,  165,  639, 1075,  490,
			  165,  647,  484,  491,  165,  485,  165,  486,  487,  844,
			  495,  497,  165,  165,  511,  165,  165, 1075,  165, 1075,
			  165,  165,  499,  165,  482,  165,  483,  165,  165,  165,
			  165, 1075,  165,  165,  484,  514,  165,  485,  165,  486,
			  487,  845,  495,  497,  165,  165,  511,  165,  165,  514,
			  165,  503,  165,  165,  499,  165,  504,  165,  165,  165,
			  165,  165,  165,  509,  507,  165,  165,  505,  165,  514, yy_Dummy>>,
			1, 200, 1800)
		end

	yy_nxt_template_11 (an_array: ARRAY [INTEGER])
			-- Fill chunk #11 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  165,  165, 1075,  165,  780,  165,  158,  648,  165,  513,
			  514,  158, 1075,  503,  158,  165, 1075, 1075,  504, 1075,
			  165,  165,  165,  165,  514,  509,  507,  640,  165,  505,
			  165, 1075,  165,  165,  514,  165,  781,  165,  165,  649,
			  165,  513, 1075,  165,  514,  158,  165,  165,  255,  256,
			  257,  258,  259,  260,  261,  514, 1075,  654, 1075,  641,
			 1075, 1075,  255,  256,  257,  258,  259,  260,  261,  276,
			  277,  278,  279,  280,  281,  282, 1075,  165,  738,  738,
			  738,  515,  255,  256,  257,  258,  259,  260,  261,  655,
			  516,  516,  516,  255,  256,  257,  258,  259,  260,  261,

			  739,  739,  739, 1075,  517,  517, 1075,  255,  256,  257,
			  258,  259,  260,  261,  518,  518,  518,  255,  256,  257,
			  258,  259,  260,  261,  519,  519,  519,  255,  256,  257,
			  258,  259,  260,  261,  529,  520, 1075, 1075,  255,  256,
			  257,  258,  259,  260,  261,  276,  277,  278,  279,  280,
			  281,  282,  308,  276,  277,  278,  279,  280,  281,  282,
			  309,  309,  309,  276,  277,  278,  279,  280,  281,  282,
			  310,  310,  537,  276,  277,  278,  279,  280,  281,  282,
			  311,  311,  311,  276,  277,  278,  279,  280,  281,  282,
			  312,  312,  312,  276,  277,  278,  279,  280,  281,  282, yy_Dummy>>,
			1, 200, 2000)
		end

	yy_nxt_template_12 (an_array: ARRAY [INTEGER])
			-- Fill chunk #12 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  313, 1075,  158,  276,  277,  278,  279,  280,  281,  282,
			  284, 1075,  284,  284,  284, 1075,  288,  284,  158,  158,
			  158,  530,  531,  532,  533,  534,  535,  536,  285, 1075,
			 1075,  285, 1075,  292,  165,  286,  275,  158,  286, 1075,
			  300, 1075,  158,  275, 1075, 1075,  644,  284, 1075,  284,
			  291,  276,  277,  278,  279,  280,  281,  282, 1075,  538,
			  539,  540,  541,  542,  543,  544,  285,  158,  285,  165,
			  289,  285,  720,  292,  165, 1075,  275,  285,  645, 1075,
			  285, 1075,  292, 1075, 1075,  275, 1075,  285, 1075, 1075,
			  285, 1075,  292, 1075, 1075,  275, 1075,  286, 1075,  165,

			 1075,  290, 1075,  285,  721,  158,  276,  277,  278,  279,
			  280,  281,  282,  276,  277,  278,  279,  280,  281,  282,
			  293,  294,  295,  296,  297,  298,  299,  301,  302,  303,
			  304,  305,  306,  307,  286,  285, 1075,  165,  285, 1075,
			  292, 1075, 1075,  275, 1075,  285, 1075, 1075,  285,  604,
			  292,  604, 1075,  275,  605,  605,  605,  605,  158, 1075,
			  293,  294,  295,  296,  297,  298,  299, 1075,  545,  293,
			  294,  295,  296,  297,  298,  299,  546,  546,  546,  293,
			  294,  295,  296,  297,  298,  299,  285, 1075, 1075,  285,
			  165,  292, 1075, 1075,  275, 1075,  285, 1075, 1075,  285, yy_Dummy>>,
			1, 200, 2200)
		end

	yy_nxt_template_13 (an_array: ARRAY [INTEGER])
			-- Fill chunk #13 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			 1075,  292, 1075,  286,  275, 1075,  286, 1075,  300, 1075,
			 1075,  275,  286,  650,  165,  286,  625,  300,  158,  652,
			  275,  158, 1075,  158,  547,  547,  165,  293,  294,  295,
			  296,  297,  298,  299,  548,  548,  548,  293,  294,  295,
			  296,  297,  298,  299,  286,  651,  165,  286,  625,  300,
			  165,  653,  275,  165,  286,  165, 1075,  286,  165,  300,
			 1075, 1075,  275, 1075,  286, 1075, 1075,  286, 1075,  300,
			  158, 1075,  275, 1075, 1075,  549,  549,  549,  293,  294,
			  295,  296,  297,  298,  299,  550,  850, 1075,  293,  294,
			  295,  296,  297,  298,  299,  301,  302,  303,  304,  305,

			  306,  307,  165,  551,  301,  302,  303,  304,  305,  306,
			  307,  286, 1075,  158,  286, 1075,  300, 1075,  851,  275,
			 1075,  286, 1075, 1075,  286, 1075,  300, 1075, 1075,  275,
			  158,  158,  158,  552,  552,  552,  301,  302,  303,  304,
			  305,  306,  307,  553,  553,  165,  301,  302,  303,  304,
			  305,  306,  307,  554,  554,  554,  301,  302,  303,  304,
			  305,  306,  307,  276,  277,  278,  279,  280,  281,  282,
			  276,  277,  278,  279,  280,  281,  282,  276,  277,  278,
			  279,  280,  281,  282,  276,  277,  278,  279,  280,  281,
			  282,  106, 1075, 1075,  559,  605,  605,  605,  605, 1075, yy_Dummy>>,
			1, 200, 2400)
		end

	yy_nxt_template_14 (an_array: ARRAY [INTEGER])
			-- Fill chunk #14 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  555,  555,  555,  301,  302,  303,  304,  305,  306,  307,
			  556, 1075, 1075,  301,  302,  303,  304,  305,  306,  307,
			  557,  557,  557,  276,  277,  278,  279,  280,  281,  282,
			  558,  558,  558,  276,  277,  278,  279,  280,  281,  282,
			  106,  158, 1075,  107,  158,  158,  158,  560, 1075, 1075,
			  107,  388,  388,  388,  106, 1075, 1075,  559,  158, 1075,
			  158,  106, 1075, 1075,  562,  678, 1075,  561,  561,  561,
			  561,  106,  704,  165,  559,  165, 1075,  165,  319,  320,
			  321,  322,  323,  324,  325,  106, 1075,  165,  559,  660,
			  165,  616,  165,  158,  610,  106,  610,  679,  559,  611,

			  611,  611,  611, 1075,  705,  106, 1075,  165,  559,  165,
			  765,  765,  765,  765, 1075,  106, 1075, 1075,  559,  165,
			 1075,  661,  158,  158,  158,  165, 1075,  119,  120,  121,
			  122,  123,  124,  125,  119,  120,  121,  122,  123,  124,
			  125,  319,  320,  321,  322,  323,  324,  325,  319,  320,
			  321,  322,  323,  324,  325, 1075, 1075, 1075,  319,  320,
			  321,  322,  323,  324,  325,  106, 1075, 1075,  559, 1075,
			 1075,  563,  319,  320,  321,  322,  323,  324,  325,  564,
			  564,  564,  319,  320,  321,  322,  323,  324,  325,  565,
			  565,  158,  319,  320,  321,  322,  323,  324,  325,  566, yy_Dummy>>,
			1, 200, 2600)
		end

	yy_nxt_template_15 (an_array: ARRAY [INTEGER])
			-- Fill chunk #15 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  566,  566,  319,  320,  321,  322,  323,  324,  325,  106,
			 1075, 1075,  559,  769,  769,  769,  769,  326, 1075,  326,
			  326, 1075,  106,  165,  143,  107,  612,  612,  613,  613,
			  327, 1075,  327,  327, 1075,  106,  158,  151,  107,  342,
			  343,  344,  345,  346,  347,  348,  165,  165,  165,  567,
			  567,  567,  319,  320,  321,  322,  323,  324,  325,  106,
			 1075, 1075,  107,  158, 1075, 1075,  150, 1075,  165,  151,
			 1075,  108,  106,  662,  158,  107,  143, 1075,  613,  613,
			  613,  613, 1075, 1075,  108,  106, 1075, 1075,  107,  620,
			  620,  620,  620,  568, 1075,  165,  319,  320,  321,  322,

			  323,  324,  325,  109,  106,  663,  165,  107,  108,  110,
			  111,  112,  113,  114,  115,  116,  109,  106,  150, 1075,
			  107,  108,  110,  111,  112,  113,  114,  115,  116,  393,
			  106, 1075, 1075,  107,  108, 1075, 1075,  158,  106,  786,
			  109,  107,  603,  603,  603,  603,  110,  111,  112,  113,
			  114,  115,  116,  109,  106, 1075,  378,  107,  158,  110,
			  111,  112,  113,  114,  115,  116,  109,  106,  774,  165,
			  107,  787,  110,  111,  112,  113,  114,  115,  116,  108,
			  106,  158,  379,  107,  611,  611,  611,  611,  378, 1075,
			  165,  119,  120,  121,  122,  123,  124,  125,  106, 1075, yy_Dummy>>,
			1, 200, 2800)
		end

	yy_nxt_template_16 (an_array: ARRAY [INTEGER])
			-- Fill chunk #16 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  775,  107, 1075,  108,  119,  120,  121,  122,  123,  124,
			  125,  109,  106,  165, 1075,  107,  108,  110,  111,  112,
			  113,  114,  115,  116, 1075,  119,  120,  121,  122,  123,
			  124,  125, 1075,  888,  158,  109, 1075, 1075,  569,  569,
			  569,  110,  111,  112,  113,  114,  115,  116,  109, 1075,
			 1075,  570,  570,  570,  110,  111,  112,  113,  114,  115,
			  116, 1075,  165,  165,  165,  889,  165,  119,  120,  121,
			  122,  123,  124,  125, 1075,  874,  874,  874,  874, 1075,
			 1075,  579,  571,  571,  571,  119,  120,  121,  122,  123,
			  124,  125, 1075,  796,  920,  158,  572,  572,  572,  119,

			  120,  121,  122,  123,  124,  125, 1075,  342,  343,  344,
			  345,  346,  347,  348,  573,  342,  343,  344,  345,  346,
			  347,  348,  580, 1075, 1075,  797,  921,  165, 1075,  574,
			  574,  574,  342,  343,  344,  345,  346,  347,  348,  582,
			 1075,  575,  575, 1075,  342,  343,  344,  345,  346,  347,
			  348,  583, 1075, 1075,  576,  576,  576,  342,  343,  344,
			  345,  346,  347,  348,  342,  343,  344,  345,  346,  347,
			  348,  585,  577,  577,  577,  342,  343,  344,  345,  346,
			  347,  348,  875,  875,  875,  875,  578, 1075, 1075,  342,
			  343,  344,  345,  346,  347,  348,  584,  584,  584,  584, yy_Dummy>>,
			1, 200, 3000)
		end

	yy_nxt_template_17 (an_array: ARRAY [INTEGER])
			-- Fill chunk #17 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  586,  762,  762,  762,  762,  342,  343,  344,  345,  346,
			  347,  348,  587,  672, 1075,  872, 1075,  158,  165,  588,
			  165,  623,  342,  343,  344,  345,  346,  347,  348,  589,
			  165,  158, 1075, 1075,  342,  343,  344,  345,  346,  347,
			  348,  590, 1075, 1075, 1075,  673,  820,  872,  591,  165,
			  165, 1075,  165,  623,  342,  343,  344,  345,  346,  347,
			  348,  592,  165,  165,  768,  768,  768,  768,  593, 1075,
			  342,  343,  344,  345,  346,  347,  348,  594,  821,  158,
			 1075, 1075, 1075,  342,  343,  344,  345,  346,  347,  348,
			  595,  814, 1075, 1075, 1075,  342,  343,  344,  345,  346,

			  347,  348,  342,  343,  344,  345,  346,  347,  348,  596,
			 1075,  165,  342,  343,  344,  345,  346,  347,  348,  597,
			 1075, 1075, 1075,  815,  342,  343,  344,  345,  346,  347,
			  348,  342,  343,  344,  345,  346,  347,  348,  598,  879,
			  879,  879,  879, 1075,  342,  343,  344,  345,  346,  347,
			  348,  342,  343,  344,  345,  346,  347,  348,  599,  158,
			  342,  343,  344,  345,  346,  347,  348,  600, 1075,  607,
			  607,  607,  607,  342,  343,  344,  345,  346,  347,  348,
			 1075,  676,  158,  608,  158,  158,  666,  830, 1075, 1075,
			 1075,  165,  342,  343,  344,  345,  346,  347,  348,  667, yy_Dummy>>,
			1, 200, 3200)
		end

	yy_nxt_template_18 (an_array: ARRAY [INTEGER])
			-- Fill chunk #18 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			 1075, 1075,  342,  343,  344,  345,  346,  347,  348,  609,
			 1075, 1075, 1075,  677,  165,  608,  165,  165,  668,  831,
			 1075,  342,  343,  344,  345,  346,  347,  348, 1075, 1075,
			 1075,  669,  276,  277,  278,  279,  280,  281,  282, 1075,
			 1075,  342,  343,  344,  345,  346,  347,  348, 1075, 1075,
			  342,  343,  344,  345,  346,  347,  348, 1075, 1075, 1075,
			  126,  126,  126,  342,  343,  344,  345,  346,  347,  348,
			  126,  126,  126,  342,  343,  344,  345,  346,  347,  348,
			  126,  126,  126,  342,  343,  344,  345,  346,  347,  348,
			  126,  126,  126,  342,  343,  344,  345,  346,  347,  348,

			  601,  601,  601,  342,  343,  344,  345,  346,  347,  348,
			  602,  602,  602,  342,  343,  344,  345,  346,  347,  348,
			  390,  390,  390,  390, 1075,  165, 1075,  165, 1075, 1075,
			  390,  390,  390,  390,  390,  390, 1075,  165,  621,  621,
			  621,  621,  782, 1075,  630,  627, 1075,  682,  158, 1075,
			 1075,  158,  158, 1075,  922, 1075,  165,  165,  165,  165,
			  618,  631,  390,  390,  390,  390,  390,  390,  165,  165,
			  629,  158, 1075,  165,  783,  165,  632,  627,  393,  683,
			  165,  632,  664,  165,  165,  165,  923,  165,  165,  165,
			  165, 1075,  165,  633,  165, 1075, 1075,  637,  633,  165, yy_Dummy>>,
			1, 200, 3400)
		end

	yy_nxt_template_19 (an_array: ARRAY [INTEGER])
			-- Fill chunk #19 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  165, 1075,  629,  165,  165,  165,  165,  165,  165, 1075,
			  800,  688, 1075,  632,  665,  158,  158,  165,  165,  165,
			  165,  165,  165,  165,  165,  165,  165,  639,  643,  637,
			  633,  165,  165,  641, 1075,  165,  165,  158,  165,  165,
			  165,  165,  801,  689,  686, 1075,  926,  165,  165, 1075,
			  165,  165,  165, 1075,  165,  165,  165,  165,  165,  639,
			  643, 1075,  645, 1075,  165,  641,  158,  165,  165,  165,
			  165,  165,  165,  165,  651,  710,  687,  649,  927,  647,
			  158,  656,  165,  165,  165,  165,  165,  165,  165,  158,
			  165,  165, 1075,  165,  645,  657,  165,  165,  165, 1075,

			  165,  653,  165,  165,  165, 1075,  651,  711,  165,  649,
			  165,  647,  165,  658,  165, 1075,  165,  165,  165,  165,
			  165,  165,  165,  165,  165,  165,  158,  659,  165,  165,
			  658,  655,  692,  653,  165,  165,  158,  776,  661, 1075,
			  165,  165,  165,  165,  659,  165,  732,  165,  165,  934,
			  165,  158,  165,  165,  165,  663,  165,  165,  165,  165,
			  165,  165,  658,  655,  693, 1075,  165,  665,  165,  777,
			  661,  165, 1075,  165, 1075,  165,  659,  165,  733,  165,
			  165,  935,  165,  165,  158,  165,  671,  663,  165,  165,
			 1075,  165,  165,  165,  165,  668,  165,  680,  165,  665, yy_Dummy>>,
			1, 200, 3600)
		end

	yy_nxt_template_20 (an_array: ARRAY [INTEGER])
			-- Fill chunk #20 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  673, 1075, 1075,  165,  684,  158,  165,  165,  669,  165,
			  675,  681,  158,  165,  677,  165,  165,  158,  671,  165,
			  165,  165,  165,  165,  165,  165,  165,  668,  165,  681,
			  165, 1075,  673,  165,  165,  950,  685,  165,  165,  165,
			  669,  165,  675,  681,  165,  165,  677,  165,  165,  165,
			  165,  165,  679,  165,  165,  165,  165,  165, 1075, 1075,
			  165,  158,  683,  685,  832,  165,  165,  951, 1075,  165,
			 1075,  165, 1075,  165,  165,  165,  165,  687, 1075,  698,
			  165,  165,  165,  158,  679,  165,  165,  165, 1075,  165,
			  691,  689,  165,  165,  683,  685,  833, 1075,  165,  165,

			  165,  165,  165,  165,  165,  165,  165,  165,  165,  687,
			  165,  699, 1075,  165,  165,  165, 1075,  165,  165,  165,
			  693,  165,  691,  689,  700,  902,  158,  165,  158,  165,
			  165,  165,  165, 1075,  165,  694,  165,  702,  695,  165,
			 1075,  158,  165, 1075,  696,  158,  165,  697,  706, 1075,
			 1075, 1075,  693,  165,  158,  165,  701,  903,  165,  165,
			  165,  165, 1075,  158,  712,  165,  707,  696,  158,  703,
			  697,  165,  798,  165,  699,  701,  696,  165,  703,  697,
			  708,  165,  165,  165,  165,  165,  165,  165, 1075,  165,
			  165,  165,  165,  165,  165,  165,  713,  165,  709,  705, yy_Dummy>>,
			1, 200, 3800)
		end

	yy_nxt_template_21 (an_array: ARRAY [INTEGER])
			-- Fill chunk #21 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  165,  165,  165,  714,  799, 1075,  699,  701, 1075,  708,
			  703,  158, 1075,  165,  165,  165,  165,  158,  165, 1075,
			  165,  165,  165,  165,  165,  165,  165,  709,  716,  834,
			  165,  705,  158,  165,  165,  715,  165,  713,  165, 1075,
			  715,  708,  711,  165,  165, 1075,  165, 1075,  165,  165,
			  165,  165,  165,  165,  158,  158,  165, 1075,  717,  709,
			  717,  835,  165,  165,  165,  165,  792,  165,  165,  713,
			  165,  722,  715,  158,  711,  158,  165,  165,  165,  719,
			  165,  726,  165,  165,  165,  165,  165,  165,  165,  165,
			  717,  721,  724,  723,  165,  165,  158,  165,  793,  165,

			  165,  165,  165,  723, 1075,  165, 1075,  165,  725,  165,
			 1075,  719,  165,  727,  165,  165,  165,  165, 1075, 1075,
			 1075,  165, 1075,  721,  725,  723,  165,  165,  165,  514,
			 1075,  790,  165,  165,  165,  158,  165,  158,  165,  158,
			  725,  727,  734,  514,  165, 1075,  856,  165,  165,  165,
			  729,  731,  733,  165,  165,  165,  165,  514, 1075,  165,
			  165, 1075,  165,  791,  514,  165,  165,  165,  165,  165,
			  165,  165,  165,  727,  735,  514,  158,  165,  857,  735,
			  165, 1075,  729,  731,  733,  165,  165,  165,  165,  165,
			  514,  165,  165,  165,  165,  529, 1075,  165,  165,  763, yy_Dummy>>,
			1, 200, 4000)
		end

	yy_nxt_template_22 (an_array: ARRAY [INTEGER])
			-- Fill chunk #22 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  763,  763,  763,  165,  165,  529,  158, 1075,  165,  165,
			 1075,  735,  255,  256,  257,  258,  259,  260,  261,  529,
			 1075,  165, 1075,  165, 1075,  165,  255,  256,  257,  258,
			  259,  260,  261,  529,  838,  165,  158,  158,  165,  764,
			  255,  256,  257,  258,  259,  260,  261,  255,  256,  257,
			  258,  259,  260,  261,  529,  736,  736,  736,  255,  256,
			  257,  258,  259,  260,  261,  529,  839, 1075,  165,  165,
			  737,  737,  737,  255,  256,  257,  258,  259,  260,  261,
			  529, 1075,  530,  531,  532,  533,  534,  535,  536,  537,
			 1075,  740,  530,  531,  532,  533,  534,  535,  536,  537,

			 1075, 1075, 1075,  741,  741,  741,  530,  531,  532,  533,
			  534,  535,  536,  537, 1075, 1075, 1075,  742,  742, 1075,
			  530,  531,  532,  533,  534,  535,  536,  537,  276,  277,
			  278,  279,  280,  281,  282, 1075, 1075,  537,  743,  743,
			  743,  530,  531,  532,  533,  534,  535,  536,  537,  744,
			  744,  744,  530,  531,  532,  533,  534,  535,  536,  537,
			 1075,  158,  158,  158,  745, 1075, 1075,  530,  531,  532,
			  533,  534,  535,  536, 1075,  846,  538,  539,  540,  541,
			  542,  543,  544, 1075, 1075,  746,  538,  539,  540,  541,
			  542,  543,  544,  165,  165,  165, 1075,  747,  747,  747, yy_Dummy>>,
			1, 200, 4200)
		end

	yy_nxt_template_23 (an_array: ARRAY [INTEGER])
			-- Fill chunk #23 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  538,  539,  540,  541,  542,  543,  544,  847, 1075, 1075,
			  158,  748,  748,  848,  538,  539,  540,  541,  542,  543,
			  544,  749,  749,  749,  538,  539,  540,  541,  542,  543,
			  544, 1075,  750,  750,  750,  538,  539,  540,  541,  542,
			  543,  544,  165,  751,  158,  849,  538,  539,  540,  541,
			  542,  543,  544,  285,  778, 1075,  285, 1075,  292,  158,
			  285,  275, 1075,  285,  158,  292,  158,  285,  275, 1075,
			  285,  806,  292,  804,  285,  275,  165,  285,  158,  292,
			  158, 1075,  275, 1075,  285,  886,  779,  285, 1075,  292,
			 1075,  165,  275, 1075,  285, 1075,  165,  285,  165,  292,

			 1075,  286,  275,  807,  286,  805,  300,  959,  286,  275,
			  165,  286,  165,  300, 1075,  286,  275,  887,  286, 1075,
			  300, 1075,  286,  275, 1075,  286, 1075,  300, 1075, 1075,
			  275, 1075,  286,  379, 1075,  286,  767,  300,  767,  959,
			  275,  768,  768,  768,  768,  293,  294,  295,  296,  297,
			  298,  299,  293,  294,  295,  296,  297,  298,  299,  293,
			  294,  295,  296,  297,  298,  299,  293,  294,  295,  296,
			  297,  298,  299,  752,  752,  752,  293,  294,  295,  296,
			  297,  298,  299,  753,  753,  753,  293,  294,  295,  296,
			  297,  298,  299,  301,  302,  303,  304,  305,  306,  307, yy_Dummy>>,
			1, 200, 4400)
		end

	yy_nxt_template_24 (an_array: ARRAY [INTEGER])
			-- Fill chunk #24 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  301,  302,  303,  304,  305,  306,  307,  301,  302,  303,
			  304,  305,  306,  307,  301,  302,  303,  304,  305,  306,
			  307,  754,  754,  754,  301,  302,  303,  304,  305,  306,
			  307,  286, 1075, 1075,  286, 1075,  300, 1075, 1075,  275,
			 1075, 1075, 1075,  560,  158, 1075,  559,  794, 1075, 1075,
			  106,  158, 1075,  559,  788, 1075, 1075,  106, 1075, 1075,
			  559,  812,  852, 1075,  560,  158, 1075,  559,  158,  118,
			  756,  756,  756,  756,  106,  158,  165,  559,  158,  795,
			  898,  106,  858,  165,  559,  158,  789,  808,  106, 1075,
			  118,  559, 1075,  813,  853,  106, 1075,  165,  559, 1075,

			  165,  881,  881,  881,  881,  106, 1075,  165,  559, 1075,
			  165, 1075,  899, 1075,  859,  106, 1075,  165,  559,  809,
			  755,  755,  755,  301,  302,  303,  304,  305,  306,  307,
			  319,  320,  321,  322,  323,  324,  325,  319,  320,  321,
			  322,  323,  324,  325,  319,  320,  321,  322,  323,  324,
			  325,  319,  320,  321,  322,  323,  324,  325, 1075, 1075,
			 1075,  319,  320,  321,  322,  323,  324,  325,  319,  320,
			  321,  322,  323,  324,  325,  319,  320,  321,  322,  323,
			  324,  325,  319,  320,  321,  322,  323,  324,  325,  757,
			  757,  757,  319,  320,  321,  322,  323,  324,  325,  758, yy_Dummy>>,
			1, 200, 4600)
		end

	yy_nxt_template_25 (an_array: ARRAY [INTEGER])
			-- Fill chunk #25 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  758,  758,  319,  320,  321,  322,  323,  324,  325,  106,
			 1075, 1075,  107,  762,  762,  762,  762,  766,  766,  766,
			  766, 1075,  106, 1075,  158,  107, 1075,  378, 1075,  106,
			 1075,  608,  107,  810, 1075, 1075,  106, 1075,  158,  107,
			 1075,  342,  343,  344,  345,  346,  347,  348, 1075,  770,
			  770,  770,  770,  379, 1075, 1075,  165,  609,  108,  378,
			  158,  158, 1075,  608,  772,  811,  613,  613,  613,  613,
			  165,  108, 1075, 1075, 1075,  822,  932,  958,  958,  958,
			  958, 1075, 1075, 1075, 1075, 1075,  529, 1075, 1075,  771,
			  109, 1075,  165,  165, 1075, 1075,  110,  111,  112,  113,

			  114,  115,  116,  109, 1075, 1075,  393,  823,  933,  110,
			  111,  112,  113,  114,  115,  116,  119,  120,  121,  122,
			  123,  124,  125,  119,  120,  121,  122,  123,  124,  125,
			 1075,  342,  343,  344,  345,  346,  347,  348,  342,  343,
			  344,  345,  346,  347,  348,  342,  343,  344,  345,  346,
			  347,  348,  759,  759,  759,  342,  343,  344,  345,  346,
			  347,  348,  760,  760,  760,  342,  343,  344,  345,  346,
			  347,  348, 1075,  530,  531,  532,  533,  534,  535,  536,
			  761,  584,  584,  584,  584,  126,  126,  126,  342,  343,
			  344,  345,  346,  347,  348,  772, 1075,  612,  612,  613, yy_Dummy>>,
			1, 200, 4800)
		end

	yy_nxt_template_26 (an_array: ARRAY [INTEGER])
			-- Fill chunk #26 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  613, 1075, 1075,  773,  773,  773,  773, 1075,  151, 1075,
			  126,  126,  126,  342,  343,  344,  345,  346,  347,  348,
			 1075, 1075,  621,  621,  621,  621,  962,  962,  962,  962,
			 1075, 1075,  165,  165,  165,  165, 1075,  393, 1075,  775,
			  151,  777, 1075,  393,  165,  165,  781,  963,  963,  963,
			  963,  165, 1075,  165, 1075,  342,  343,  344,  345,  346,
			  347,  348,  393,  165,  165,  165,  165,  165,  165,  785,
			  165,  775,  165,  777,  165,  779,  165,  165,  781,  158,
			  165,  158,  783,  165,  165,  165,  787,  165, 1075,  165,
			 1075,  165, 1075,  165, 1075,  165,  158, 1075, 1075,  165,

			  165,  785,  165,  165,  165,  824,  165,  779,  165, 1075,
			  165,  165,  165,  165,  783,  789,  165,  791,  787,  165,
			  165,  165,  797,  165,  165,  165,  165,  165,  165,  165,
			  158,  165,  165,  862,  165,  165,  165,  825,  799,  165,
			  165,  795,  165,  165,  165,  165, 1075,  789,  165,  791,
			  165,  793,  165, 1075,  797,  165,  165, 1075,  165,  165,
			  165,  165,  165,  801,  165,  863,  165,  165,  165,  807,
			  799,  165,  165,  795,  165,  165,  165,  165,  864,  165,
			  165, 1075,  165,  793,  165,  803,  158,  165,  165,  908,
			  165,  165,  165,  165,  158,  801,  165,  805,  165,  165, yy_Dummy>>,
			1, 200, 5000)
		end

	yy_nxt_template_27 (an_array: ARRAY [INTEGER])
			-- Fill chunk #27 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  165,  807,  809,  165,  165,  813,  165,  165,  165,  165,
			  865,  165,  165,  811,  165,  158,  165,  803,  165,  165,
			  165,  909,  165,  165,  165,  165,  165,  816,  165,  805,
			  165,  158,  165, 1075,  809,  165,  158,  813,  826,  165,
			  165,  165,  158, 1075,  165,  811,  165,  165,  165, 1075,
			  165,  165,  165, 1075,  165,  890,  165,  815,  817,  817,
			  165,  158,  158,  165,  165,  165,  819,  165,  165,  165,
			  827,  165, 1075,  165,  165,  165,  165,  165,  165,  158,
			  165,  165,  165,  842,  165,  821,  165,  891,  823,  815,
			  817, 1075,  165,  165,  165,  158,  165,  165,  819,  165,

			  165,  165,  165,  165,  828,  165,  825,  165,  165,  165,
			  165,  165,  165,  165,  827,  843,  165,  821,  165,  924,
			  823,  165,  829,  165, 1075,  158, 1075,  165,  165,  165,
			  158,  165,  165,  165,  165,  831,  829,  165,  825,  840,
			  165,  165,  165, 1075,  165, 1075,  827,  165,  165, 1075,
			  165,  925,  165,  165,  829,  165,  165,  165,  165,  158,
			  165,  165,  165,  165,  833,  165,  165,  831,  165,  165,
			  910,  841,  165,  165,  165,  165,  165,  165,  837,  165,
			  165,  165,  165,  165,  165,  158, 1075,  165,  165,  835,
			  165,  165,  165,  165, 1075, 1075,  833,  860,  165,  165, yy_Dummy>>,
			1, 200, 5200)
		end

	yy_nxt_template_28 (an_array: ARRAY [INTEGER])
			-- Fill chunk #28 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  165,  165,  911, 1075, 1075,  841, 1075,  165,  165,  165,
			  837,  165,  165,  165,  165,  165, 1075,  165, 1022,  165,
			  839,  835, 1075, 1075,  165,  165,  165,  845,  165,  861,
			  165,  165,  165,  165,  165,  843,  165,  841,  165,  165,
			  158,  165,  165,  165,  609,  849,  165,  165,  847, 1075,
			 1022,  165,  839,  873,  873,  873,  873,  165,  165,  845,
			  165, 1075,  165,  165,  165,  165,  165,  843,  165, 1075,
			  165,  165,  165,  165,  165,  165,  851,  849,  165,  165,
			  847,  853,  158,  165,  904, 1075,  165,  158,  165,  165,
			  165,  854,  165,  764,  165,  165,  165,  165,  165,  165,

			  855,  165,  165,  857, 1075,  158,  165,  165,  851, 1075,
			 1075,  165, 1075,  853,  165,  165,  905,  165,  165,  165,
			  165, 1075,  165,  855,  165, 1075,  165,  165,  165,  514,
			  165,  165,  855,  165,  165,  857,  859,  165,  165,  165,
			 1075,  165,  165,  165,  165,  514,  165,  165,  165,  165,
			  863,  165,  165,  529,  165,  861,  865,  158,  165,  165,
			  529, 1075,  165,  165,  158,  165,  892,  165,  859,  165,
			  529,  165,  158,  165,  165,  165,  165,  912,  165,  165,
			  165,  529,  863,  165,  165, 1075,  165,  861,  865,  165,
			  165,  165,  529,  165,  165,  165,  165,  165,  893,  165, yy_Dummy>>,
			1, 200, 5400)
		end

	yy_nxt_template_29 (an_array: ARRAY [INTEGER])
			-- Fill chunk #29 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  537,  165, 1075,  165,  165,  158,  158,  165,  537,  913,
			 1075,  165,  255,  256,  257,  258,  259,  260,  261,  537,
			 1075, 1075, 1075,  165,  158,  165,  537, 1075,  255,  256,
			  257,  258,  259,  260,  261,  165,  537,  165,  165, 1075,
			  530,  531,  532,  533,  534,  535,  536,  530,  531,  532,
			  533,  534,  535,  536,  537, 1075,  165,  530,  531,  532,
			  533,  534,  535,  536, 1075,  866,  866,  866,  530,  531,
			  532,  533,  534,  535,  536, 1075,  867,  867,  867,  530,
			  531,  532,  533,  534,  535,  536, 1075,  538,  539,  540,
			  541,  542,  543,  544, 1075,  538,  539,  540,  541,  542,

			  543,  544,  965,  965,  965,  965,  538,  539,  540,  541,
			  542,  543,  544,  538,  539,  540,  541,  542,  543,  544,
			  868,  868,  868,  538,  539,  540,  541,  542,  543,  544,
			  106, 1075,  894,  559, 1075, 1075,  895, 1075,  869,  869,
			  869,  538,  539,  540,  541,  542,  543,  544,  285, 1075,
			 1075,  285, 1075,  292,  158,  285,  275, 1039,  285, 1075,
			  292, 1075,  286,  275,  896,  286,  158,  300,  897,  286,
			  275,  165,  286,  165,  300,  906,  884,  275,  885,  158,
			  165,  106,  165,  165,  559, 1075,  165, 1075,  106, 1040,
			 1075,  559,  165,  118,  870,  870,  870,  870,  165, 1075, yy_Dummy>>,
			1, 200, 5600)
		end

	yy_nxt_template_30 (an_array: ARRAY [INTEGER])
			-- Fill chunk #30 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			 1075, 1075, 1075,  165, 1075,  165,  871,  907,  885, 1075,
			  885,  165,  165, 1075,  165,  165, 1075,  319,  320,  321,
			  322,  323,  324,  325,  165,  957,  957,  957,  957, 1075,
			 1075, 1075,  342,  343,  344,  345,  346,  347,  348, 1075,
			  293,  294,  295,  296,  297,  298,  299,  293,  294,  295,
			  296,  297,  298,  299,  301,  302,  303,  304,  305,  306,
			  307,  301,  302,  303,  304,  305,  306,  307,  319,  320,
			  321,  322,  323,  324,  325,  319,  320,  321,  322,  323,
			  324,  325,  342,  343,  344,  345,  346,  347,  348,  342,
			  343,  344,  345,  346,  347,  348,  876,  876,  876,  876,

			  877,  877,  877,  877,  880,  880,  880,  880, 1075, 1075,
			  608,  876,  876,  876,  876,  165,  883,  165,  621,  621,
			  621,  621,  165,  158,  887,  882, 1075,  165, 1075,  889,
			 1075,  891, 1075,  165,  165,  165,  609,  158,  158, 1075,
			  878,  165,  608,  165,  771,  165,  900,  165,  165,  165,
			  165, 1075,  158,  165,  165,  165,  887,  882,  150,  165,
			  165,  889,  165,  891,  165,  165,  165,  165, 1075,  165,
			  165,  158, 1075,  165,  165,  165,  916,  165,  901, 1075,
			  165,  165,  165,  165,  165,  165, 1075,  893, 1075,  158,
			  158,  896,  165,  165,  165,  897,  165,  165,  165,  899, yy_Dummy>>,
			1, 200, 5800)
		end

	yy_nxt_template_31 (an_array: ARRAY [INTEGER])
			-- Fill chunk #31 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  165,  944,  165,  165,  165,  165,  165,  165,  917,  165,
			  165,  901,  903,  165,  165,  165,  165,  165,  165,  893,
			  158,  165,  165,  896, 1075,  165,  976,  897,  165,  165,
			  165,  899,  165,  945,  165, 1075,  165,  165, 1075,  165,
			 1075,  165,  165,  901,  903,  905,  165,  907,  165,  165,
			  165,  165,  165,  165,  165,  165,  165,  913,  977,  158,
			  165,  909,  165,  165,  165,  158,  165,  165,  914,  165,
			  911,  165,  918, 1075,  165, 1075,  158,  905,  165,  907,
			  165,  165, 1075,  165, 1075,  165,  165,  165,  165,  913,
			  165,  165,  158,  909,  165,  165,  165,  165,  165,  165,

			  915,  165,  911,  165,  919,  165,  165,  165,  165, 1075,
			  165,  915,  165,  165,  165,  158,  917,  165, 1064, 1075,
			  921,  919,  165,  165,  165,  165,  165, 1075,  165,  165,
			  165,  165,  158,  158, 1075,  165, 1075,  165, 1075,  165,
			  165,  165, 1075,  915,  946, 1075,  165,  165,  917,  165,
			 1065,  923,  921,  919,  165,  165,  165,  165,  165,  925,
			  165,  165,  165,  165,  165,  165,  165,  165,  165,  165,
			  165,  165,  165,  165,  927,  158,  947,  165,  928,  165,
			  165,  165,  158,  923,  930,  929,  165, 1075,  165,  165,
			  158,  925,  165,  165,  165,  165, 1075, 1075,  165,  931, yy_Dummy>>,
			1, 200, 6000)
		end

	yy_nxt_template_32 (an_array: ARRAY [INTEGER])
			-- Fill chunk #32 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  165,  165,  165,  165,  165,  165,  927,  165, 1075,  165,
			  929,  165,  165,  165,  165,  936,  931,  929,  165,  158,
			  165,  165,  165,  158,  165,  165,  165,  165,  954,  935,
			  933,  931,  165, 1075,  165, 1075,  165,  165,  938,  937,
			  158, 1075,  158, 1075,  165, 1075,  165,  937,  165,  940,
			  165,  165,  165,  942, 1075,  165,  939,  158,  165, 1075,
			  955,  935,  933,  165,  165,  165,  165,  165, 1075,  165,
			  939,  937,  165,  941,  165,  165,  165,  943,  165,  165,
			  165,  941, 1075, 1075,  165,  943,  165, 1075,  939,  165,
			  165,  165,  165,  165,  165,  165,  165,  165,  948,  165,

			  945,  165,  158,  165,  165,  941,  158,  165, 1075,  943,
			 1075,  165,  957,  957,  957,  957,  165,  529,  165,  165,
			 1075,  165, 1075,  165,  165,  165,  165,  947,  165,  949,
			  949,  165,  945,  529,  165,  165,  165,  165,  165,  165,
			  165,  951,  165,  952,  165,  537,  165,  158,  953,  165,
			  158,  165,  165,  165,  537,  165,  165,  165,  165,  947,
			  165,  949,  970,  165,  158,  106,  158,  165,  559,  165,
			  165,  165,  165,  951,  165,  953,  165,  118,  165,  165,
			  953,  165,  165,  165,  165,  955, 1075,  165,  165,  165,
			  165, 1075,  165, 1075,  971,  165,  165,  158,  165,  165, yy_Dummy>>,
			1, 200, 6200)
		end

	yy_nxt_template_33 (an_array: ARRAY [INTEGER])
			-- Fill chunk #33 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			 1075, 1075,  165, 1075,  530,  531,  532,  533,  534,  535,
			  536,  957,  957,  957,  957,  165,  165,  955,  165, 1075,
			  530,  531,  532,  533,  534,  535,  536,  165,  165,  165,
			  158,  158,  538,  539,  540,  541,  542,  543,  544, 1075,
			 1075,  538,  539,  540,  541,  542,  543,  544,  165, 1075,
			  165,  764,  319,  320,  321,  322,  323,  324,  325,  956,
			  165,  956,  165,  165,  957,  957,  957,  957,  876,  876,
			  876,  876,  961,  961,  961,  961,  964,  964,  964,  964,
			 1075,  966,  960,  966, 1075, 1075,  964,  964,  964,  964,
			  968,  968,  968,  968,  165,  158,  165,  158,  971,  165,

			 1075,  165,  158, 1075,  969,  165,  165,  165,  973,  972,
			 1075,  165,  878,  974,  960,  980,  771,  165, 1075,  158,
			 1075,  158, 1075,  165, 1075,  165,  165,  165,  165,  165,
			  971,  165,  978,  165,  165,  165,  969,  165,  165,  165,
			  973,  973,  165,  165,  165,  975, 1041,  981,  158,  165,
			  975,  165,  982,  165,  165,  165,  165,  165,  165,  977,
			  158,  165, 1075,  165,  979, 1075,  158,  165,  165,  979,
			  981,  984, 1047,  165,  165,  158,  165,  165, 1042,  165,
			  165, 1075,  975,  983,  983,  165,  165,  165,  165,  165,
			  165,  977,  165,  165,  165,  165,  165,  165,  165,  158, yy_Dummy>>,
			1, 200, 6400)
		end

	yy_nxt_template_34 (an_array: ARRAY [INTEGER])
			-- Fill chunk #34 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  165,  979,  981,  985, 1048,  165,  165,  165,  165,  165,
			  165,  165,  165,  158,  165,  983,  985,  165,  992,  165,
			  165,  165,  986,  165,  165,  165,  165, 1075,  165,  165,
			  158,  165,  989,  988, 1075,  165,  987,  158,  165,  165,
			  165,  165,  165,  158,  165,  165,  165,  165,  985,  165,
			  993,  165,  165,  990,  987,  165,  165,  165,  165,  165,
			  165,  158,  165, 1075,  989,  989,  158,  165,  987,  165,
			  165,  165,  994,  165,  165,  165,  993,  996, 1075,  165,
			  998,  165,  165,  165,  165,  991,  165, 1075,  158,  991,
			  165,  165,  165,  165,  165,  165, 1075,  165,  165,  158,

			  158, 1075,  165,  995,  995,  158,  165,  165,  993,  997,
			 1000,  165,  999,  165,  165, 1002,  165,  999,  165,  997,
			  165,  991, 1075,  165, 1075, 1075,  165,  165,  165,  165,
			  165,  165,  165, 1075, 1075,  995,  165,  165,  165,  165,
			  165, 1075, 1001,  165, 1001,  165, 1008, 1003,  165,  999,
			  158,  997,  165,  158,  165,  165, 1075, 1075, 1004, 1003,
			  165,  165,  165,  165,  165,  165,  158, 1005,  165, 1075,
			  165, 1006,  165,  165, 1075, 1075, 1001,  165, 1009, 1075,
			  165, 1075,  165, 1075,  165,  165,  165, 1075, 1075, 1075,
			 1005, 1003,  165,  165, 1007,  165,  165,  165,  165, 1005, yy_Dummy>>,
			1, 200, 6600)
		end

	yy_nxt_template_35 (an_array: ARRAY [INTEGER])
			-- Fill chunk #35 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  165, 1009,  165, 1007,  165,  165, 1075, 1075,  165,  165,
			  165,  165,  165,  165,  158,  165,  165,  165,  165, 1075,
			  165, 1075, 1075,  165,  165, 1010, 1007,  165,  165,  165,
			  158,  165,  165, 1009,  165, 1012,  165, 1011, 1075, 1075,
			  165,  165,  165,  165,  165,  165,  165,  165,  165,  165,
			  165, 1075,  165,  158,  165,  165, 1013, 1011, 1075,  165,
			  165,  165,  165,  165, 1014, 1075,  165, 1013,  165, 1011,
			  165, 1075, 1075,  165, 1075,  165, 1027,  165, 1045, 1075,
			  165,  158,  158, 1015, 1075,  165,  165,  165, 1013, 1016,
			 1016, 1016, 1016, 1075, 1075, 1075, 1015, 1075,  165, 1075,

			  165, 1075,  165, 1020, 1020, 1020, 1020,  165, 1028,  165,
			 1046, 1075,  165,  165,  165, 1015, 1017, 1075, 1017,  165,
			 1075, 1018, 1018, 1018, 1018, 1019, 1075, 1019, 1075, 1075,
			 1020, 1020, 1020, 1020, 1021, 1021, 1021, 1021,  964,  964,
			  964,  964, 1075,  878, 1023, 1023, 1023, 1023,  964,  964,
			  964,  964, 1024, 1024, 1024, 1024, 1025, 1028, 1025,  158,
			 1075, 1026, 1026, 1026, 1026,  165, 1022,  165, 1075, 1075,
			 1029,  165,  165,  165,  165,  158,  165,  165, 1032, 1030,
			 1031, 1033, 1075,  165,  165, 1075,  158, 1075,  165, 1028,
			 1075,  165,  609, 1035, 1075, 1075, 1075,  165, 1022,  165, yy_Dummy>>,
			1, 200, 6800)
		end

	yy_nxt_template_36 (an_array: ARRAY [INTEGER])
			-- Fill chunk #36 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  158, 1075, 1030,  165,  165,  165,  165,  165,  165,  165,
			 1032, 1030, 1032, 1034, 1034,  165,  165,  165,  165,  165,
			  165, 1036,  165, 1037,  165, 1036, 1049, 1038,  158,  165,
			  158,  165,  165,  165,  165,  165, 1040,  165,  165, 1075,
			  165, 1075,  165,  165, 1075,  158, 1034,  165,  165,  165,
			 1043,  165,  165, 1036,  165, 1038,  165, 1075, 1050, 1038,
			  165,  165,  165,  165, 1075,  165,  165,  165, 1040,  165,
			  165,  165,  165,  165,  165,  165, 1075,  165, 1075,  165,
			  165, 1042, 1044,  165,  165,  165,  165,  165,  165,  165,
			  165,  165, 1044, 1018, 1018, 1018, 1018,  165,  165, 1075,

			 1075,  165,  165,  165, 1051,  165, 1075, 1046, 1075, 1075,
			  158, 1075, 1075, 1042,  165,  165,  165,  165,  165,  165,
			  165,  165,  165,  165, 1044,  165,  165,  165, 1048,  165,
			  165, 1050, 1052,  165,  165, 1075, 1052,  165,  165, 1046,
			  165,  165,  165,  165, 1075, 1075,  165, 1075,  165,  165,
			  165,  165, 1053,  165, 1075, 1075,  158,  165,  165,  165,
			 1048,  165, 1055, 1050, 1052, 1075,  158, 1054, 1075,  165,
			  165, 1056,  165,  165,  165,  165,  165,  165,  165,  165,
			  165,  165,  165,  165, 1054,  165,  165, 1075,  165,  165,
			  165, 1075, 1075,  165, 1056, 1075, 1075, 1075,  165, 1054, yy_Dummy>>,
			1, 200, 7000)
		end

	yy_nxt_template_37 (an_array: ARRAY [INTEGER])
			-- Fill chunk #37 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			 1075, 1075, 1075, 1056, 1075, 1075,  165, 1075,  165,  165,
			  165,  165,  165, 1057, 1057, 1057, 1057, 1075,  165, 1075,
			 1075,  165,  165, 1020, 1020, 1020, 1020, 1020, 1020, 1020,
			 1020, 1058, 1058, 1058, 1058, 1059, 1075, 1059, 1075, 1075,
			 1060, 1060, 1060, 1060,  963,  963,  963,  963, 1026, 1026,
			 1026, 1026, 1075,  764, 1061, 1061, 1061, 1061, 1022,  165,
			 1062,  165, 1075, 1063,  158,  165,  165,  165,  165,  158,
			  165,  165,  165, 1065,  165,  165,  165,  165,  165, 1075,
			 1066, 1075,  165, 1075,  609,  165,  165, 1075, 1075, 1075,
			 1022,  165, 1063,  165,  771, 1063,  165,  165,  165,  165,

			  165,  165,  165,  165,  165, 1065,  165,  165,  165,  165,
			  165,  165, 1067,  165,  165, 1075,  158,  165,  165,  165,
			  165,  165,  165,  165,  165, 1068,  165,  165, 1067,  165,
			 1070,  165,  165, 1069,  158,  165,  165,  165, 1075,  165,
			 1075, 1075, 1075,  165, 1075,  165, 1075,  165,  165, 1075,
			 1075,  165,  165,  165,  165,  165,  165, 1069,  165,  165,
			 1067,  165, 1071,  165,  165, 1069,  165,  165,  165,  165,
			 1075,  165,  165, 1071,  165,  165, 1075,  165, 1075,  165,
			  165, 1075,  165, 1075,  165, 1075, 1075,  165, 1016, 1016,
			 1016, 1016,  165, 1060, 1060, 1060, 1060, 1072, 1072, 1072, yy_Dummy>>,
			1, 200, 7200)
		end

	yy_nxt_template_38 (an_array: ARRAY [INTEGER])
			-- Fill chunk #38 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			 1072,  165, 1075,  165,  165, 1071,  165,  165, 1075,  165,
			 1075, 1073,  165,  165,  165,  158,  165, 1075, 1075,  165,
			 1023, 1023, 1023, 1023,  165, 1074, 1075,  165,  764,  165,
			 1075, 1075,  165,  165,  165,  165,  165,  878,  165,  165,
			  165, 1075,  165, 1074,  165,  165, 1075,  165,  165, 1075,
			 1075, 1075,  165, 1058, 1058, 1058, 1058, 1074, 1075,  165,
			  771,  165, 1075,  165,  165,  165,  165, 1075,  165, 1075,
			  165,  165,  165, 1075,  165,  165,  165, 1075, 1075, 1075,
			  165, 1075, 1075, 1075,  165, 1075, 1075, 1075, 1075, 1075,
			 1075, 1075, 1075,  878, 1075,  165, 1075,  165, 1075, 1075,

			 1075, 1075, 1075, 1075, 1075, 1075, 1075,  165,   87,   87,
			   87,   87,   87,   87,   87,   87,   87,   87,   87,   87,
			   87,   87,   87,   87,   87,   87,   87,   87,   87,   87,
			   87,  105,  105, 1075,  105,  105,  105,  105,  105,  105,
			  105,  105,  105,  105,  105,  105,  105,  105,  105,  105,
			  105,  105,  105,  105,  117, 1075, 1075, 1075, 1075, 1075,
			 1075,  117,  117,  117,  117,  117,  117,  117,  117,  117,
			  117,  117,  117,  117,  117,  117,  117,  118,  118, 1075,
			  118,  118,  118,  118,  118,  118,  118,  118,  118,  118,
			  118,  118,  118,  118,  118,  118,  118,  118,  118,  118, yy_Dummy>>,
			1, 200, 7400)
		end

	yy_nxt_template_39 (an_array: ARRAY [INTEGER])
			-- Fill chunk #39 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  126,  126, 1075,  126,  126,  126,  126, 1075,  126,  126,
			  126,  126,  126,  126,  126,  126,  126,  126,  126,  126,
			  126,  126,  126,  146,  146,  146,  146,  146,  146,  146,
			  146,  146,  146,  146,  146,  146,  146,  254,  254, 1075,
			  254,  254,  254, 1075, 1075,  254,  254,  254,  254,  254,
			  254,  254,  254,  254,  254,  254,  254,  254,  254,  254,
			  165,  165,  165,  165,  165,  165,  165,  165,  165,  165,
			  165,  165,  165,  165,  275, 1075, 1075,  275, 1075,  275,
			  275,  275,  275,  275,  275,  275,  275,  275,  275,  275,
			  275,  275,  275,  275,  275,  275,  275,  289,  289, 1075,

			  289,  289,  289,  289,  289,  289,  289,  289,  289,  289,
			  289,  289,  289,  289,  289,  289,  289,  289,  289,  289,
			  290,  290, 1075,  290,  290,  290,  290,  290,  290,  290,
			  290,  290,  290,  290,  290,  290,  290,  290,  290,  290,
			  290,  290,  290,  314,  314, 1075,  314,  314,  314,  314,
			  314,  314,  314,  314,  314,  314,  314,  314,  314,  314,
			  314,  314,  314,  314,  314,  314,  340, 1075, 1075, 1075,
			 1075,  340,  340,  340,  340,  340,  340,  340,  340,  340,
			  340,  340,  340,  340,  340,  340,  340,  340,  340,  380,
			  380,  380,  380,  380,  380,  380,  380, 1075,  380,  380, yy_Dummy>>,
			1, 200, 7600)
		end

	yy_nxt_template_40 (an_array: ARRAY [INTEGER])
			-- Fill chunk #40 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  380,  380,  380,  380,  380,  380,  380,  380,  380,  380,
			  380,  380,  387,  387,  387,  387,  387,  387,  387,  387,
			  387,  387,  387,  387,  387,  389,  389,  389,  389,  389,
			  389,  389,  389,  389,  389,  389,  389,  389,  391,  391,
			  391,  391,  391,  391,  391,  391,  391,  391,  391,  391,
			  391,  285,  285, 1075,  285,  285,  285, 1075,  285,  285,
			  285,  285,  285,  285,  285,  285,  285,  285,  285,  285,
			  285,  285,  285,  285,  286,  286, 1075,  286,  286,  286,
			 1075,  286,  286,  286,  286,  286,  286,  286,  286,  286,
			  286,  286,  286,  286,  286,  286,  286,  967,  967,  967,

			  967,  967,  967,  967,  967, 1075,  967,  967,  967,  967,
			  967,  967,  967,  967,  967,  967,  967,  967,  967,  967,
			    5, 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075,
			 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075,
			 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075,
			 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075,
			 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075,
			 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075,
			 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075,
			 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075, yy_Dummy>>,
			1, 200, 7800)
		end

	yy_nxt_template_41 (an_array: ARRAY [INTEGER])
			-- Fill chunk #41 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075,
			 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075,
			 1075, yy_Dummy>>,
			1, 21, 8000)
		end

	yy_chk_template: SPECIAL [INTEGER]
			-- Template for `yy_chk'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 8020)
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
			   23,   24,   40,    4,    4,    4,    4,   22, 1058,   24,
			   26,  146,   26,   26,   26,   26,   30,   30,   32,   32,
			 1023,   12,   46,   26,   12,   37,   46, 1016,   15,   37,
			   16,   15,   16,   16,   40,   37,  619,   27,   16,   27,
			   27,   27,   27,   42,  158,   38,  617,    3,   38,   42,
			   38,  151,   26,  146,   46,   26,  615,   37,   46,    4,
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
			  107,  107,  107,    0,  144,  614,  614,  144,  107,  108,
			  110,  183,  470,  110,    0,  107,  183,  107,    0,  107,
			  107,  107,  109,    0,  107,  111,  107,    0,  111,  451,
			  107,    0,  107,    0,    0,  107,  107,  107,  107,  107,
			  107,  108,    0,  112,  470,  614,  112,  108,  108,  108,
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
			  223,  150,  150,  150,  150,  125,  223,  631,  125,  125,
			  125,  125,  125,  125,  125,  131,  126,  126,  126,  126,
			  126,  126,  126,  128,  283,    0,  128,  128,  128,  128,
			    0,    0,  223,    0,    0,  128,    0,  132,  223,  631,
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
			  410,  410,  410,    0,  234,  652,  135,    0,  234,  135, yy_Dummy>>,
			1, 200, 1200)
		end

	yy_chk_template_8 (an_array: ARRAY [INTEGER])
			-- Fill chunk #8 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  135,  135,  135,  135,  135,  135,  149,  149,  149,  149,
			  165,    0,  165,  411,  411,  411,  149,  149,  149,  149,
			  149,  149,  165,  166,  167,  166,  234,  652,  195,  166,
			  234,  167,    0,  167,    0,  166,    0,    0,  195,  412,
			  412,  412,  165,  167,  165,    0,  149,    0,  149,  149,
			  149,  149,  149,  149,  165,  166,  167,  166,  169,  168,
			  195,  166,  168,  167,  168,  167,  169,  166,  169,  170,
			  195,  170,  666,  670,  168,  167,  170,  171,  169,  171,
			  180,  170,  180,    0,  185,  171,    0,    0,  180,  171,
			  169,  168,  180,  185,  168,    0,  168,    0,  169,    0,

			  169,  170,    0,  170,  666,  670,  168,    0,  170,  171,
			  169,  171,  180,  170,  180,  202,  185,  171,  187,  186,
			  180,  171,    0,  202,  180,  185,  186,  189,  186,  187,
			  188,  187,  188,  190,  189,  190,  189,  394,  186,  190,
			    0,  187,  188,  394,    0,  190,  189,  202,    0,    0,
			  187,  186,  413,  413,  413,  202,    0,    0,  186,  189,
			  186,  187,  188,  187,  188,  190,  189,  190,  189,  394,
			  186,  190,  191,  187,  188,  394,  191,  190,  189,  191,
			  194,  193,  194,  196,  221,  193,  682,  686,  196,  197,
			  191,  193,  194,  193,  221,  198,  197,  198,  196,  193, yy_Dummy>>,
			1, 200, 1400)
		end

	yy_chk_template_9 (an_array: ARRAY [INTEGER])
			-- Fill chunk #9 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  197,    0,  198,  193,  191,  688,    0,  198,  191,    0,
			    0,  191,  194,  193,  194,  196,  221,  193,  682,  686,
			  196,  197,  191,  193,  194,  193,  221,  198,  197,  198,
			  196,  193,  197,  199,  198,  193,  398,  688,  200,  198,
			  200,  199,  200,  199,  398,  204,  200,  204,  199,    0,
			  200,  222,  206,  199,  206,  206,  222,  204,  205,  422,
			  521,  521,  521,    0,  206,  199,    0,  422,  398,  205,
			  200,  205,  200,  199,  200,  199,  398,  204,  200,  204,
			  199,  205,  200,  222,  206,  199,  206,  206,  222,  204,
			  205,  422,  211,  209,  211,  209,  206,  209,  209,  422,

			  214,  205,  214,  205,  211,  212,  235,  212,  209,  212,
			  239,  209,  214,  205,  239,  235,  396,  212,  522,  522,
			  522,  396,    0,    0,  211,  209,  211,  209,    0,  209,
			  209,    0,  214,    0,  214,    0,  211,  212,  235,  212,
			  209,  212,  239,  209,  214,  216,  239,  235,  396,  212,
			  213,  216,  213,  396,  213,  249,    0,  216,  213,  249,
			  213,  217,  217,  245,  217,  213,  448,  218,  213,  448,
			  213,  692,  245,  220,  217,  220,  218,  216,  218,  218,
			    0,  220,  213,  216,  213,  220,  213,  249,  218,  216,
			  213,  249,  213,  217,  217,  245,  217,  213,  448,  218, yy_Dummy>>,
			1, 200, 1600)
		end

	yy_chk_template_10 (an_array: ARRAY [INTEGER])
			-- Fill chunk #10 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  213,  448,  213,  692,  245,  220,  217,  220,  218,  695,
			  218,  218,  225,  220,  225,  226,  416,  220,  227,  225,
			  218,  251,  416,  226,  225,  226,  228,  227,  228,  227,
			  251,  468,    0,  230,    0,  226,    0,  468,  228,  227,
			  230,  695,  230,    0,  225,    0,  225,  226,  416,    0,
			  227,  225,  230,  251,  416,  226,  225,  226,  228,  227,
			  228,  227,  251,  468,  236,  230,  236,  226,  236,  468,
			  228,  227,  230,  231,  230,  231,  236,  243,  231,  237,
			  237,  237,  243,  231,  230,  418,  231,  426,  231,  231,
			    0,  237,    0,  243,  233,  418,  236,  233,  236,  426,

			  236,  233,  523,  523,  523,  231,    0,  231,  236,  243,
			  231,  237,  237,  237,  243,  231,    0,  418,  231,  426,
			  231,  231,  232,  237,  232,  243,  233,  418,    0,  233,
			  232,  426,  232,  233,  238,  232,  238,  232,  232,  704,
			  238,  241,  232,  242,  250,  242,  238,    0,  241,    0,
			  241,  250,  242,  250,  232,  242,  232,  524,  524,  524,
			  241,    0,  232,  250,  232,  254,  238,  232,  238,  232,
			  232,  704,  238,  241,  232,  242,  250,  242,  238,  255,
			  241,  244,  241,  250,  242,  250,  244,  242,  247,  244,
			  247,  244,  241,  248,  247,  250,  248,  244,  248,  256, yy_Dummy>>,
			1, 200, 1800)
		end

	yy_chk_template_11 (an_array: ARRAY [INTEGER])
			-- Fill chunk #11 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  247,  244,    0,  252,  628,  252,  628,  427,  248,  252,
			  257,  427,    0,  244,  420,  252,    0,    0,  244,    0,
			  247,  244,  247,  244,  258,  248,  247,  420,  248,  244,
			  248,    0,  247,  244,  259,  252,  628,  252,  628,  427,
			  248,  252,    0,  427,  260,  435,  420,  252,  254,  254,
			  254,  254,  254,  254,  254,  261,    0,  435,    0,  420,
			    0,    0,  255,  255,  255,  255,  255,  255,  255,  275,
			  275,  275,  275,  275,  275,  275,    0,  435,  525,  525,
			  525,  256,  256,  256,  256,  256,  256,  256,  256,  435,
			  257,  257,  257,  257,  257,  257,  257,  257,  257,  257,

			  526,  526,  526,    0,  258,  258,    0,  258,  258,  258,
			  258,  258,  258,  258,  259,  259,  259,  259,  259,  259,
			  259,  259,  259,  259,  260,  260,  260,  260,  260,  260,
			  260,  260,  260,  260,  285,  261,    0,    0,  261,  261,
			  261,  261,  261,  261,  261,  276,  276,  276,  276,  276,
			  276,  276,  277,  277,  277,  277,  277,  277,  277,  277,
			  278,  278,  278,  278,  278,  278,  278,  278,  278,  278,
			  279,  279,  286,  279,  279,  279,  279,  279,  279,  279,
			  280,  280,  280,  280,  280,  280,  280,  280,  280,  280,
			  281,  281,  281,  281,  281,  281,  281,  281,  281,  281, yy_Dummy>>,
			1, 200, 2000)
		end

	yy_chk_template_12 (an_array: ARRAY [INTEGER])
			-- Fill chunk #12 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  282,    0,  716,  282,  282,  282,  282,  282,  282,  282,
			  284,    0,  284,  284,  288,    0,  288,  288,  527,  527,
			  527,  285,  285,  285,  285,  285,  285,  285,  289,    0,
			    0,  289,    0,  289,  716,  290,  289,  424,  290,    0,
			  290,    0,  720,  290,    0,    0,  424,  291,    0,  291,
			  291,  292,  292,  292,  292,  292,  292,  292,    0,  286,
			  286,  286,  286,  286,  286,  286,  284,  496,  293,  424,
			  288,  293,  496,  293,  720,    0,  293,  294,  424,    0,
			  294,    0,  294,    0,    0,  294,    0,  295,    0,    0,
			  295,    0,  295,    0,    0,  295,    0,  284,    0,  496,

			    0,  288,    0,  291,  496,  722,  288,  288,  288,  288,
			  288,  288,  288,  300,  300,  300,  300,  300,  300,  300,
			  289,  289,  289,  289,  289,  289,  289,  290,  290,  290,
			  290,  290,  290,  290,  291,  296,    0,  722,  296,    0,
			  296,    0,    0,  296,    0,  297,    0,    0,  297,  378,
			  297,  378,    0,  297,  378,  378,  378,  378,  732,    0,
			  293,  293,  293,  293,  293,  293,  293,    0,  294,  294,
			  294,  294,  294,  294,  294,  294,  295,  295,  295,  295,
			  295,  295,  295,  295,  295,  295,  298,    0,    0,  298,
			  732,  298,    0,    0,  298,    0,  299,    0,    0,  299, yy_Dummy>>,
			1, 200, 2200)
		end

	yy_chk_template_13 (an_array: ARRAY [INTEGER])
			-- Fill chunk #13 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			    0,  299,    0,  301,  299,    0,  301,    0,  301,    0,
			    0,  301,  302,  428,  397,  302,  397,  302,  734,  432,
			  302,  428,    0,  432,  296,  296,  397,  296,  296,  296,
			  296,  296,  296,  296,  297,  297,  297,  297,  297,  297,
			  297,  297,  297,  297,  303,  428,  397,  303,  397,  303,
			  734,  432,  303,  428,  304,  432,    0,  304,  397,  304,
			    0,    0,  304,    0,  305,    0,    0,  305,    0,  305,
			  710,    0,  305,    0,    0,  298,  298,  298,  298,  298,
			  298,  298,  298,  298,  298,  299,  710,    0,  299,  299,
			  299,  299,  299,  299,  299,  301,  301,  301,  301,  301,

			  301,  301,  710,  302,  302,  302,  302,  302,  302,  302,
			  302,  306,    0,  776,  306,    0,  306,    0,  710,  306,
			    0,  307,    0,    0,  307,    0,  307,    0,    0,  307,
			  528,  528,  528,  303,  303,  303,  303,  303,  303,  303,
			  303,  303,  303,  304,  304,  776,  304,  304,  304,  304,
			  304,  304,  304,  305,  305,  305,  305,  305,  305,  305,
			  305,  305,  305,  308,  308,  308,  308,  308,  308,  308,
			  309,  309,  309,  309,  309,  309,  309,  310,  310,  310,
			  310,  310,  310,  310,  311,  311,  311,  311,  311,  311,
			  311,  314,    0,    0,  314,  604,  604,  604,  604,    0, yy_Dummy>>,
			1, 200, 2400)
		end

	yy_chk_template_14 (an_array: ARRAY [INTEGER])
			-- Fill chunk #14 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  306,  306,  306,  306,  306,  306,  306,  306,  306,  306,
			  307,    0,    0,  307,  307,  307,  307,  307,  307,  307,
			  312,  312,  312,  312,  312,  312,  312,  312,  312,  312,
			  313,  313,  313,  313,  313,  313,  313,  313,  313,  313,
			  315,  778,    0,  315,  634,  634,  634,  316,    0,    0,
			  316,  616,  616,  616,  317,    0,    0,  317,  453,    0,
			  479,  318,    0,    0,  318,  453,    0,  317,  317,  317,
			  317,  319,  479,  778,  319,  401,    0,  401,  314,  314,
			  314,  314,  314,  314,  314,  320,    0,  401,  320,  439,
			  453,  616,  479,  439,  382,  321,  382,  453,  321,  382,

			  382,  382,  382,    0,  479,  322,    0,  401,  322,  401,
			  606,  606,  606,  606,    0,  323,    0,    0,  323,  401,
			    0,  439,  635,  635,  635,  439,    0,  315,  315,  315,
			  315,  315,  315,  315,  316,  316,  316,  316,  316,  316,
			  316,  317,  317,  317,  317,  317,  317,  317,  318,  318,
			  318,  318,  318,  318,  318,    0,  340,    0,  319,  319,
			  319,  319,  319,  319,  319,  324,    0,    0,  324,    0,
			    0,  320,  320,  320,  320,  320,  320,  320,  320,  321,
			  321,  321,  321,  321,  321,  321,  321,  321,  321,  322,
			  322,  786,  322,  322,  322,  322,  322,  322,  322,  323, yy_Dummy>>,
			1, 200, 2600)
		end

	yy_chk_template_15 (an_array: ARRAY [INTEGER])
			-- Fill chunk #15 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  323,  323,  323,  323,  323,  323,  323,  323,  323,  325,
			    0,    0,  325,  609,  609,  609,  609,  326,    0,  326,
			  326,    0,  326,  786,  383,  326,  383,  383,  383,  383,
			  327,    0,  327,  327,    0,  327,  788,  383,  327,  340,
			  340,  340,  340,  340,  340,  340,  738,  738,  738,  324,
			  324,  324,  324,  324,  324,  324,  324,  324,  324,  328,
			    0,    0,  328,  442,    0,    0,  383,    0,  788,  383,
			    0,  326,  329,  442,  796,  329,  384,    0,  384,  384,
			  384,  384,    0,    0,  327,  330,    0,  392,  330,  392,
			  392,  392,  392,  325,    0,  442,  325,  325,  325,  325,

			  325,  325,  325,  326,  334,  442,  796,  334,  328,  326,
			  326,  326,  326,  326,  326,  326,  327,  335,  384,    0,
			  335,  329,  327,  327,  327,  327,  327,  327,  327,  392,
			  331,    0,    0,  331,  330,    0,    0,  636,  336,  636,
			  328,  336,  377,  377,  377,  377,  328,  328,  328,  328,
			  328,  328,  328,  329,  332,    0,  377,  332,  622,  329,
			  329,  329,  329,  329,  329,  329,  330,  333,  622,  636,
			  333,  636,  330,  330,  330,  330,  330,  330,  330,  331,
			  337,  812,  377,  337,  610,  610,  610,  610,  377,    0,
			  622,  334,  334,  334,  334,  334,  334,  334,  338,    0, yy_Dummy>>,
			1, 200, 2800)
		end

	yy_chk_template_16 (an_array: ARRAY [INTEGER])
			-- Fill chunk #16 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  622,  338,    0,  332,  335,  335,  335,  335,  335,  335,
			  335,  331,  339,  812,    0,  339,  333,  331,  331,  331,
			  331,  331,  331,  331,  342,  336,  336,  336,  336,  336,
			  336,  336,  343,  782,  782,  332,    0,    0,  332,  332,
			  332,  332,  332,  332,  332,  332,  332,  332,  333,  344,
			    0,  333,  333,  333,  333,  333,  333,  333,  333,  333,
			  333,  345,  739,  739,  739,  782,  782,  337,  337,  337,
			  337,  337,  337,  337,  346,  764,  764,  764,  764,    0,
			    0,  349,  338,  338,  338,  338,  338,  338,  338,  338,
			  338,  338,  347,  646,  820,  646,  339,  339,  339,  339,

			  339,  339,  339,  339,  339,  339,  348,  342,  342,  342,
			  342,  342,  342,  342,  343,  343,  343,  343,  343,  343,
			  343,  343,  350,    0,    0,  646,  820,  646,    0,  344,
			  344,  344,  344,  344,  344,  344,  344,  344,  344,  352,
			    0,  345,  345,    0,  345,  345,  345,  345,  345,  345,
			  345,  353,    0,    0,  346,  346,  346,  346,  346,  346,
			  346,  346,  346,  346,  349,  349,  349,  349,  349,  349,
			  349,  355,  347,  347,  347,  347,  347,  347,  347,  347,
			  347,  347,  765,  765,  765,  765,  348,  354,    0,  348,
			  348,  348,  348,  348,  348,  348,  354,  354,  354,  354, yy_Dummy>>,
			1, 200, 3000)
		end

	yy_chk_template_17 (an_array: ARRAY [INTEGER])
			-- Fill chunk #17 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  356,  762,  762,  762,  762,  350,  350,  350,  350,  350,
			  350,  350,  357,  450,    0,  762,    0,  450,  395,  358,
			  395,  395,  352,  352,  352,  352,  352,  352,  352,  359,
			  395,  672,    0,    0,  353,  353,  353,  353,  353,  353,
			  353,  360,    0,    0,    0,  450,  672,  762,  361,  450,
			  395,    0,  395,  395,  355,  355,  355,  355,  355,  355,
			  355,  362,  395,  672,  767,  767,  767,  767,  363,    0,
			  354,  354,  354,  354,  354,  354,  354,  364,  672,  664,
			    0,    0,    0,  356,  356,  356,  356,  356,  356,  356,
			  365,  664,    0,    0,    0,  357,  357,  357,  357,  357,

			  357,  357,  358,  358,  358,  358,  358,  358,  358,  366,
			    0,  664,  359,  359,  359,  359,  359,  359,  359,  367,
			    0,    0,    0,  664,  360,  360,  360,  360,  360,  360,
			  360,  361,  361,  361,  361,  361,  361,  361,  368,  769,
			  769,  769,  769,    0,  362,  362,  362,  362,  362,  362,
			  362,  363,  363,  363,  363,  363,  363,  363,  369,  822,
			  364,  364,  364,  364,  364,  364,  364,  370,    0,  381,
			  381,  381,  381,  365,  365,  365,  365,  365,  365,  365,
			  371,  452,  446,  381,  684,  452,  446,  684,    0,    0,
			  372,  822,  366,  366,  366,  366,  366,  366,  366,  446, yy_Dummy>>,
			1, 200, 3200)
		end

	yy_chk_template_18 (an_array: ARRAY [INTEGER])
			-- Fill chunk #18 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  373,    0,  367,  367,  367,  367,  367,  367,  367,  381,
			  374,    0,    0,  452,  446,  381,  684,  452,  446,  684,
			  375,  368,  368,  368,  368,  368,  368,  368,    0,    0,
			  376,  446,  557,  557,  557,  557,  557,  557,  557,    0,
			    0,  369,  369,  369,  369,  369,  369,  369,    0,    0,
			  370,  370,  370,  370,  370,  370,  370,    0,    0,    0,
			  371,  371,  371,  371,  371,  371,  371,  371,  371,  371,
			  372,  372,  372,  372,  372,  372,  372,  372,  372,  372,
			  373,  373,  373,  373,  373,  373,  373,  373,  373,  373,
			  374,  374,  374,  374,  374,  374,  374,  374,  374,  374,

			  375,  375,  375,  375,  375,  375,  375,  375,  375,  375,
			  376,  376,  376,  376,  376,  376,  376,  376,  376,  376,
			  390,  390,  390,  390,    0,  403,    0,  403,    0,    0,
			  390,  390,  390,  390,  390,  390,  393,  403,  393,  393,
			  393,  393,  630,    0,  406,  400,    0,  460,  630,    0,
			    0,  460,  406,    0,  824,    0,  400,  403,  400,  403,
			  390,  406,  390,  390,  390,  390,  390,  390,  400,  403,
			  405,  444,    0,  405,  630,  405,  406,  400,  393,  460,
			  630,  407,  444,  460,  406,  405,  824,  415,  400,  415,
			  400,    0,  407,  406,  407,    0,    0,  417,  407,  415, yy_Dummy>>,
			1, 200, 3400)
		end

	yy_chk_template_19 (an_array: ARRAY [INTEGER])
			-- Fill chunk #19 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  400,    0,  405,  444,  407,  405,  417,  405,  417,    0,
			  650,  466,    0,  407,  444,  466,  650,  405,  417,  415,
			  419,  415,  419,  421,  407,  421,  407,  419,  423,  417,
			  407,  415,  419,  421,    0,  421,  407,  463,  417,  423,
			  417,  423,  650,  466,  463,    0,  828,  466,  650,    0,
			  417,  423,  419,    0,  419,  421,  425,  421,  425,  419,
			  423,    0,  425,    0,  419,  421,  481,  421,  425,  463,
			  429,  423,  429,  423,  431,  481,  463,  430,  828,  429,
			  830,  438,  429,  423,  430,  431,  430,  431,  425,  438,
			  425,  436,    0,  436,  425,  438,  430,  431,  481,    0,

			  425,  433,  429,  436,  429,    0,  431,  481,  433,  430,
			  433,  429,  830,  438,  429,    0,  430,  431,  430,  431,
			  433,  438,  437,  436,  437,  436,  624,  438,  430,  431,
			  440,  437,  472,  433,  437,  436,  472,  624,  441,    0,
			  433,  440,  433,  440,  440,  441,  508,  441,  443,  838,
			  443,  508,  433,  440,  437,  443,  437,  441,  624,  445,
			  443,  445,  440,  437,  472,    0,  437,  445,  472,  624,
			  441,  445,    0,  440,    0,  440,  440,  441,  508,  441,
			  443,  838,  443,  508,  850,  440,  449,  443,  449,  441,
			    0,  445,  443,  445,  447,  447,  447,  454,  449,  445, yy_Dummy>>,
			1, 200, 3600)
		end

	yy_chk_template_20 (an_array: ARRAY [INTEGER])
			-- Fill chunk #20 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  455,    0,    0,  445,  462,  454,  447,  455,  447,  455,
			  456,  459,  462,  456,  457,  456,  850,  856,  449,  455,
			  449,  457,  459,  457,  459,  456,  447,  447,  447,  454,
			  449,    0,  455,  457,  459,  858,  462,  454,  447,  455,
			  447,  455,  456,  459,  462,  456,  457,  456,  458,  856,
			  458,  455,  458,  457,  459,  457,  459,  456,    0,    0,
			  458,  690,  461,  464,  690,  457,  459,  858,    0,  461,
			    0,  461,    0,  465,  464,  465,  464,  465,    0,  476,
			  458,  461,  458,  476,  458,  465,  464,  469,    0,  469,
			  469,  467,  458,  690,  461,  464,  690,    0,  467,  469,

			  467,  461,  471,  461,  471,  465,  464,  465,  464,  465,
			  467,  476,    0,  461,  471,  476,    0,  465,  464,  469,
			  473,  469,  469,  467,  477,  800,  800,  473,  477,  473,
			  467,  469,  467,    0,  471,  474,  471,  478,  474,  473,
			    0,  474,  467,    0,  475,  478,  471,  475,  480,    0,
			    0,    0,  473,  475,  480,  475,  477,  800,  800,  473,
			  477,  473,    0,  648,  488,  475,  480,  474,  488,  478,
			  474,  473,  648,  474,  482,  483,  475,  478,  484,  475,
			  480,  482,  483,  482,  483,  475,  480,  475,    0,  484,
			  485,  484,  485,  482,  483,  648,  488,  475,  480,  485, yy_Dummy>>,
			1, 200, 3800)
		end

	yy_chk_template_21 (an_array: ARRAY [INTEGER])
			-- Fill chunk #21 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  488,  484,  485,  489,  648,    0,  482,  483,    0,  486,
			  484,  489,    0,  482,  483,  482,  483,  694,  486,    0,
			  486,  484,  485,  484,  485,  482,  483,  486,  492,  694,
			  486,  485,  492,  484,  485,  489,  487,  490,  487,    0,
			  491,  486,  487,  489,  490,    0,  490,    0,  487,  694,
			  486,  491,  486,  491,  862,  642,  490,    0,  493,  486,
			  492,  694,  486,  491,  492,  493,  642,  493,  487,  490,
			  487,  498,  491,  501,  487,  498,  490,  493,  490,  495,
			  487,  501,  495,  491,  495,  491,  862,  642,  490,  497,
			  493,  497,  500,  499,  495,  491,  500,  493,  642,  493,

			  499,  497,  499,  498,    0,  501,    0,  498,  503,  493,
			    0,  495,  499,  501,  495,  503,  495,  503,    0,    0,
			    0,  497,    0,  497,  500,  499,  495,  503,  500,  515,
			    0,  640,  499,  497,  499,  640,  504,  510,  504,  718,
			  503,  504,  510,  516,  499,    0,  718,  503,  504,  503,
			  505,  507,  509,  505,  507,  505,  507,  517,    0,  503,
			  509,    0,  509,  640,  518,  505,  507,  640,  504,  510,
			  504,  718,  509,  504,  510,  519,  884,  511,  718,  511,
			  504,    0,  505,  507,  509,  505,  507,  505,  507,  511,
			  520,  513,  509,  513,  509,  530,    0,  505,  507,  605, yy_Dummy>>,
			1, 200, 4000)
		end

	yy_chk_template_22 (an_array: ARRAY [INTEGER])
			-- Fill chunk #22 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  605,  605,  605,  513,  509,  531,  886,    0,  884,  511,
			    0,  511,  515,  515,  515,  515,  515,  515,  515,  532,
			    0,  511,    0,  513,    0,  513,  516,  516,  516,  516,
			  516,  516,  516,  533,  698,  513,  894,  698,  886,  605,
			  517,  517,  517,  517,  517,  517,  517,  518,  518,  518,
			  518,  518,  518,  518,  534,  519,  519,  519,  519,  519,
			  519,  519,  519,  519,  519,  535,  698,    0,  894,  698,
			  520,  520,  520,  520,  520,  520,  520,  520,  520,  520,
			  536,    0,  530,  530,  530,  530,  530,  530,  530,  538,
			    0,  531,  531,  531,  531,  531,  531,  531,  531,  539,

			    0,    0,    0,  532,  532,  532,  532,  532,  532,  532,
			  532,  532,  532,  540,    0,    0,    0,  533,  533,    0,
			  533,  533,  533,  533,  533,  533,  533,  541,  558,  558,
			  558,  558,  558,  558,  558,    0,    0,  542,  534,  534,
			  534,  534,  534,  534,  534,  534,  534,  534,  543,  535,
			  535,  535,  535,  535,  535,  535,  535,  535,  535,  544,
			    0,  904,  906,  706,  536,    0,    0,  536,  536,  536,
			  536,  536,  536,  536,    0,  706,  538,  538,  538,  538,
			  538,  538,  538,    0,    0,  539,  539,  539,  539,  539,
			  539,  539,  539,  904,  906,  706,    0,  540,  540,  540, yy_Dummy>>,
			1, 200, 4200)
		end

	yy_chk_template_23 (an_array: ARRAY [INTEGER])
			-- Fill chunk #23 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  540,  540,  540,  540,  540,  540,  540,  706,    0,    0,
			  707,  541,  541,  707,  541,  541,  541,  541,  541,  541,
			  541,  542,  542,  542,  542,  542,  542,  542,  542,  542,
			  542,    0,  543,  543,  543,  543,  543,  543,  543,  543,
			  543,  543,  707,  544,  626,  707,  544,  544,  544,  544,
			  544,  544,  544,  545,  626,    0,  545,    0,  545,  910,
			  546,  545,    0,  546,  654,  546,  656,  547,  546,    0,
			  547,  656,  547,  654,  548,  547,  626,  548,  916,  548,
			  780,    0,  548,    0,  549,  780,  626,  549,    0,  549,
			    0,  910,  549,    0,  550,    0,  654,  550,  656,  550,

			    0,  551,  550,  656,  551,  654,  551,  875,  552,  551,
			  916,  552,  780,  552,    0,  553,  552,  780,  553,    0,
			  553,    0,  554,  553,    0,  554,    0,  554,    0,    0,
			  554,    0,  555,  875,    0,  555,  608,  555,  608,  875,
			  555,  608,  608,  608,  608,  545,  545,  545,  545,  545,
			  545,  545,  546,  546,  546,  546,  546,  546,  546,  547,
			  547,  547,  547,  547,  547,  547,  548,  548,  548,  548,
			  548,  548,  548,  549,  549,  549,  549,  549,  549,  549,
			  549,  549,  549,  550,  550,  550,  550,  550,  550,  550,
			  550,  550,  550,  551,  551,  551,  551,  551,  551,  551, yy_Dummy>>,
			1, 200, 4400)
		end

	yy_chk_template_24 (an_array: ARRAY [INTEGER])
			-- Fill chunk #24 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  552,  552,  552,  552,  552,  552,  552,  553,  553,  553,
			  553,  553,  553,  553,  554,  554,  554,  554,  554,  554,
			  554,  555,  555,  555,  555,  555,  555,  555,  555,  555,
			  555,  556,    0,    0,  556,    0,  556,    0,    0,  556,
			    0,    0,    0,  559,  638,    0,  559,  644,    0,    0,
			  560,  644,    0,  560,  638,    0,    0,  561,    0,    0,
			  561,  662,  712,    0,  562,  662,    0,  562,  712,  561,
			  561,  561,  561,  561,  563,  794,  638,  563,  657,  644,
			  794,  564,  724,  644,  564,  724,  638,  657,  565,    0,
			  562,  565,    0,  662,  712,  566,    0,  662,  566,    0,

			  712,  771,  771,  771,  771,  567,    0,  794,  567,    0,
			  657,    0,  794,    0,  724,  568,    0,  724,  568,  657,
			  556,  556,  556,  556,  556,  556,  556,  556,  556,  556,
			  559,  559,  559,  559,  559,  559,  559,  560,  560,  560,
			  560,  560,  560,  560,  561,  561,  561,  561,  561,  561,
			  561,  562,  562,  562,  562,  562,  562,  562,  573,    0,
			    0,  563,  563,  563,  563,  563,  563,  563,  564,  564,
			  564,  564,  564,  564,  564,  565,  565,  565,  565,  565,
			  565,  565,  566,  566,  566,  566,  566,  566,  566,  567,
			  567,  567,  567,  567,  567,  567,  567,  567,  567,  568, yy_Dummy>>,
			1, 200, 4600)
		end

	yy_chk_template_25 (an_array: ARRAY [INTEGER])
			-- Fill chunk #25 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  568,  568,  568,  568,  568,  568,  568,  568,  568,  569,
			    0,    0,  569,  603,  603,  603,  603,  607,  607,  607,
			  607,    0,  570,    0,  660,  570,    0,  603,    0,  571,
			    0,  607,  571,  660,    0,    0,  572,    0,  932,  572,
			    0,  573,  573,  573,  573,  573,  573,  573,  574,  611,
			  611,  611,  611,  603,    0,  575,  660,  607,  569,  603,
			  674,  836,  576,  607,  613,  660,  613,  613,  613,  613,
			  932,  570,  577,    0,    0,  674,  836,  874,  874,  874,
			  874,    0,  578,    0,    0,    0,  740,    0,    0,  611,
			  569,    0,  674,  836,    0,    0,  569,  569,  569,  569,

			  569,  569,  569,  570,    0,  601,  613,  674,  836,  570,
			  570,  570,  570,  570,  570,  570,  571,  571,  571,  571,
			  571,  571,  571,  572,  572,  572,  572,  572,  572,  572,
			  602,  574,  574,  574,  574,  574,  574,  574,  575,  575,
			  575,  575,  575,  575,  575,  576,  576,  576,  576,  576,
			  576,  576,  577,  577,  577,  577,  577,  577,  577,  577,
			  577,  577,  578,  578,  578,  578,  578,  578,  578,  578,
			  578,  578,  584,  740,  740,  740,  740,  740,  740,  740,
			  584,  584,  584,  584,  584,  601,  601,  601,  601,  601,
			  601,  601,  601,  601,  601,  612,    0,  612,  612,  612, yy_Dummy>>,
			1, 200, 4800)
		end

	yy_chk_template_26 (an_array: ARRAY [INTEGER])
			-- Fill chunk #26 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  612,  620,    0,  620,  620,  620,  620,    0,  612,    0,
			  602,  602,  602,  602,  602,  602,  602,  602,  602,  602,
			  621,    0,  621,  621,  621,  621,  878,  878,  878,  878,
			    0,    0,  623,  625,  623,  625,    0,  612,    0,  623,
			  612,  625,    0,  620,  623,  625,  629,  879,  879,  879,
			  879,  629,    0,  629,    0,  584,  584,  584,  584,  584,
			  584,  584,  621,  629,  623,  625,  623,  625,  627,  633,
			  627,  623,  633,  625,  633,  627,  623,  625,  629,  938,
			  627,  942,  632,  629,  633,  629,  637,  637,    0,  637,
			    0,  632,    0,  632,    0,  629,  676,    0,    0,  637,

			  627,  633,  627,  632,  633,  676,  633,  627,  639,    0,
			  639,  938,  627,  942,  632,  639,  633,  641,  637,  637,
			  639,  637,  647,  632,  641,  632,  641,  647,  676,  647,
			  728,  637,  649,  728,  649,  632,  641,  676,  649,  647,
			  639,  645,  639,  643,  649,  643,    0,  639,  645,  641,
			  645,  643,  639,    0,  647,  643,  641,    0,  641,  647,
			  645,  647,  728,  651,  649,  728,  649,  658,  641,  658,
			  649,  647,  651,  645,  651,  643,  649,  643,  730,  658,
			  645,    0,  645,  643,  651,  653,  730,  643,  653,  806,
			  653,  655,  645,  655,  806,  651,  659,  655,  659,  658, yy_Dummy>>,
			1, 200, 5000)
		end

	yy_chk_template_27 (an_array: ARRAY [INTEGER])
			-- Fill chunk #27 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  653,  658,  659,  655,  651,  663,  651,  661,  659,  661,
			  730,  658,  663,  661,  663,  944,  651,  653,  730,  661,
			  653,  806,  653,  655,  663,  655,  806,  667,  659,  655,
			  659,  667,  653,    0,  659,  655,  946,  663,  678,  661,
			  659,  661,  678,    0,  663,  661,  663,  944,  665,    0,
			  665,  661,  668,    0,  668,  784,  663,  665,  669,  667,
			  665,  952,  784,  667,  668,  669,  671,  669,  946,  671,
			  678,  671,    0,  673,  678,  673,  675,  669,  675,  702,
			  665,  671,  665,  702,  668,  673,  668,  784,  675,  665,
			  669,    0,  665,  952,  784,  680,  668,  669,  671,  669,

			  677,  671,  677,  671,  680,  673,  677,  673,  675,  669,
			  675,  702,  677,  671,  679,  702,  681,  673,  681,  826,
			  675,  679,  681,  679,    0,  826,    0,  680,  681,  683,
			  700,  683,  677,  679,  677,  685,  680,  685,  677,  700,
			  687,  683,  687,    0,  677,    0,  679,  685,  681,    0,
			  681,  826,  687,  679,  681,  679,  689,  826,  689,  808,
			  681,  683,  700,  683,  691,  679,  691,  685,  689,  685,
			  808,  700,  687,  683,  687,  693,  691,  693,  697,  685,
			  696,  697,  696,  697,  687,  726,    0,  693,  689,  696,
			  689,  808,  696,  697,    0,    0,  691,  726,  691,  701, yy_Dummy>>,
			1, 200, 5200)
		end

	yy_chk_template_28 (an_array: ARRAY [INTEGER])
			-- Fill chunk #28 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  689,  701,  808,    0,    0,  701,    0,  693,  691,  693,
			  697,  701,  696,  697,  696,  697,    0,  726,  963,  693,
			  699,  696,    0,    0,  696,  697,  699,  705,  699,  726,
			  705,  701,  705,  701,  703,  703,  703,  701,  699,  708,
			  974,  708,  705,  701,  963,  709,  703,  709,  708,    0,
			  963,  708,  699,  763,  763,  763,  763,  709,  699,  705,
			  699,    0,  705,  711,  705,  711,  703,  703,  703,    0,
			  699,  708,  974,  708,  705,  711,  711,  709,  703,  709,
			  708,  713,  714,  708,  802,    0,  717,  802,  717,  709,
			  713,  714,  713,  763,  715,  711,  715,  711,  717,  719,

			  715,  719,  713,  719,    0,  978,  715,  711,  711,    0,
			    0,  719,    0,  713,  714,  721,  802,  721,  717,  802,
			  717,    0,  713,  714,  713,    0,  715,  721,  715,  736,
			  717,  719,  715,  719,  713,  719,  725,  978,  715,  723,
			    0,  723,  725,  719,  725,  737,  727,  721,  727,  721,
			  729,  723,  729,  741,  725,  727,  731,  790,  727,  721,
			  742,    0,  729,  733,  988,  733,  790,  731,  725,  731,
			  743,  723,  810,  723,  725,  733,  725,  810,  727,  731,
			  727,  744,  729,  723,  729,    0,  725,  727,  731,  790,
			  727,  735,  745,  735,  729,  733,  988,  733,  790,  731, yy_Dummy>>,
			1, 200, 5400)
		end

	yy_chk_template_29 (an_array: ARRAY [INTEGER])
			-- Fill chunk #29 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  746,  731,    0,  735,  810,  990,  994,  733,  747,  810,
			    0,  731,  736,  736,  736,  736,  736,  736,  736,  748,
			    0,    0,    0,  735,  996,  735,  749,    0,  737,  737,
			  737,  737,  737,  737,  737,  735,  750,  990,  994,    0,
			  741,  741,  741,  741,  741,  741,  741,  742,  742,  742,
			  742,  742,  742,  742,  751,    0,  996,  743,  743,  743,
			  743,  743,  743,  743,    0,  744,  744,  744,  744,  744,
			  744,  744,  744,  744,  744,    0,  745,  745,  745,  745,
			  745,  745,  745,  745,  745,  745,    0,  746,  746,  746,
			  746,  746,  746,  746,    0,  747,  747,  747,  747,  747,

			  747,  747,  881,  881,  881,  881,  748,  748,  748,  748,
			  748,  748,  748,  749,  749,  749,  749,  749,  749,  749,
			  750,  750,  750,  750,  750,  750,  750,  750,  750,  750,
			  757,    0,  792,  757,    0,    0,  792,    0,  751,  751,
			  751,  751,  751,  751,  751,  751,  751,  751,  752,  759,
			    0,  752,    0,  752,  986,  753,  752,  986,  753,    0,
			  753,    0,  754,  753,  792,  754,  774,  754,  792,  755,
			  754,  775,  755,  775,  755,  804,  774,  755,  775,  804,
			  777,  756,  777,  775,  756,    0,  986,    0,  758,  986,
			    0,  758,  777,  756,  756,  756,  756,  756,  774,  760, yy_Dummy>>,
			1, 200, 5600)
		end

	yy_chk_template_30 (an_array: ARRAY [INTEGER])
			-- Fill chunk #30 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			    0,    0,    0,  775,    0,  775,  761,  804,  774,    0,
			  775,  804,  777,    0,  777,  775,    0,  757,  757,  757,
			  757,  757,  757,  757,  777,  956,  956,  956,  956,    0,
			    0,    0,  759,  759,  759,  759,  759,  759,  759,    0,
			  752,  752,  752,  752,  752,  752,  752,  753,  753,  753,
			  753,  753,  753,  753,  754,  754,  754,  754,  754,  754,
			  754,  755,  755,  755,  755,  755,  755,  755,  756,  756,
			  756,  756,  756,  756,  756,  758,  758,  758,  758,  758,
			  758,  758,  760,  760,  760,  760,  760,  760,  760,  761,
			  761,  761,  761,  761,  761,  761,  766,  766,  766,  766,

			  768,  768,  768,  768,  770,  770,  770,  770,    0,    0,
			  766,  772,  772,  772,  772,  779,  773,  779,  773,  773,
			  773,  773,  781, 1008,  781,  772,    0,  779,    0,  783,
			    0,  785,    0,  783,  781,  783,  766,  798, 1014,    0,
			  768,  785,  766,  785,  770,  783,  798,  779,  787,  779,
			  787,    0, 1027,  785,  781, 1008,  781,  772,  773,  779,
			  787,  783,  789,  785,  789,  783,  781,  783,    0,  798,
			 1014,  816,    0,  785,  789,  785,  816,  783,  798,    0,
			  787,  791,  787,  791, 1027,  785,    0,  791,    0, 1031,
			  848,  793,  787,  791,  789,  793,  789,  795,  793,  795, yy_Dummy>>,
			1, 200, 5800)
		end

	yy_chk_template_31 (an_array: ARRAY [INTEGER])
			-- Fill chunk #31 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  793,  848,  797,  816,  797,  799,  789,  799,  816,  795,
			  793,  799,  801,  791,  797,  791,  801,  799,  801,  791,
			  895, 1031,  848,  793,    0,  791,  895,  793,  801,  795,
			  793,  795,  793,  848,  797,    0,  797,  799,    0,  799,
			    0,  795,  793,  799,  801,  803,  797,  805,  801,  799,
			  801,  803,  895,  803,  805,  811,  805,  811,  895,  814,
			  801,  807,  809,  803,  809, 1033,  805,  811,  814,  807,
			  809,  807,  818,    0,  809,    0,  818,  803,  813,  805,
			  813,  807,    0,  803,    0,  803,  805,  811,  805,  811,
			  813,  814, 1037,  807,  809,  803,  809, 1033,  805,  811,

			  814,  807,  809,  807,  818,  815,  809,  815,  818,    0,
			  813,  815,  813,  807,  817, 1035,  817,  815, 1035,    0,
			  821,  819,  813,  821, 1037,  821,  817,    0,  819,  823,
			  819,  823, 1039,  852,    0,  821,    0,  815,    0,  815,
			  819,  823,    0,  815,  852,    0,  817, 1035,  817,  815,
			 1035,  825,  821,  819,  825,  821,  825,  821,  817,  827,
			  819,  823,  819,  823, 1039,  852,  825,  821,  827,  831,
			  827,  831,  819,  823,  829,  834,  852,  829,  832,  829,
			  827,  831,  832,  825,  834,  833,  825,    0,  825,  829,
			 1041,  827,  833,  835,  833,  835,    0,    0,  825,  835, yy_Dummy>>,
			1, 200, 6000)
		end

	yy_chk_template_32 (an_array: ARRAY [INTEGER])
			-- Fill chunk #32 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  827,  831,  827,  831,  833,  835,  829,  834,    0,  829,
			  832,  829,  827,  831,  832,  840,  834,  833,  837,  840,
			  837,  829, 1041,  864,  833,  835,  833,  835,  864,  839,
			  837,  835,  839,    0,  839,    0,  833,  835,  842,  841,
			  844,    0,  842,    0,  839,    0,  841,  840,  841,  844,
			  837,  840,  837,  846,    0,  864,  843,  846,  841,    0,
			  864,  839,  837,  843,  839,  843,  839,  845,    0,  845,
			  842,  841,  844,  845,  842,  843,  839,  847,  841,  845,
			  841,  844,    0,    0,  847,  846,  847,    0,  843,  846,
			  841,  851,  849,  851,  849,  843,  847,  843,  854,  845,

			  849,  845, 1045,  851,  849,  845,  854,  843,    0,  847,
			    0,  845,  957,  957,  957,  957,  847,  866,  847,  853,
			    0,  853,    0,  851,  849,  851,  849,  853,  847,  855,
			  854,  853,  849,  867, 1045,  851,  849,  857,  854,  857,
			  855,  859,  855,  860,  859,  868,  859,  860,  861,  857,
			 1049,  853,  855,  853,  869,  861,  859,  861,  863,  853,
			  863,  855,  888,  853, 1053,  870,  888,  861,  870,  857,
			  863,  857,  855,  859,  855,  860,  859,  870,  859,  860,
			  861,  857, 1049,  865,  855,  865,    0,  861,  859,  861,
			  863,    0,  863,    0,  888,  865, 1053, 1055,  888,  861, yy_Dummy>>,
			1, 200, 6200)
		end

	yy_chk_template_33 (an_array: ARRAY [INTEGER])
			-- Fill chunk #33 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			    0,    0,  863,    0,  866,  866,  866,  866,  866,  866,
			  866,  873,  873,  873,  873,  865,  885,  865,  885,    0,
			  867,  867,  867,  867,  867,  867,  867,  865,  885, 1055,
			 1062, 1066,  868,  868,  868,  868,  868,  868,  868,    0,
			    0,  869,  869,  869,  869,  869,  869,  869,  885,    0,
			  885,  873,  870,  870,  870,  870,  870,  870,  870,  872,
			  885,  872, 1062, 1066,  872,  872,  872,  872,  876,  876,
			  876,  876,  877,  877,  877,  877,  880,  880,  880,  880,
			    0,  882,  876,  882,    0,    0,  882,  882,  882,  882,
			  883,  883,  883,  883,  887, 1068,  887,  890,  889,  891,

			    0,  891,  892,    0,  883,  889,  887,  889,  891,  890,
			    0,  891,  877,  892,  876,  900,  880,  889,    0,  900,
			    0,  898,    0,  896,    0,  896,  887, 1068,  887,  890,
			  889,  891,  898,  891,  892,  896,  883,  889,  887,  889,
			  891,  890,  893,  891,  893,  892,  992,  900,  992,  889,
			  893,  900,  902,  898,  893,  896,  897,  896,  897,  897,
			  902,  899,    0,  899,  898,    0, 1002,  896,  897,  899,
			  901,  908, 1002,  899,  893,  908,  893,  901,  992,  901,
			  992,    0,  893,  903,  902,  905,  893,  905,  897,  901,
			  897,  897,  902,  899,  903,  899,  903,  905, 1002, 1070, yy_Dummy>>,
			1, 200, 6400)
		end

	yy_chk_template_34 (an_array: ARRAY [INTEGER])
			-- Fill chunk #34 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  897,  899,  901,  908, 1002,  899,  903,  908,  907,  901,
			  907,  901,  911,  920,  911,  903,  909,  905,  920,  905,
			  907,  901,  912,  909,  911,  909,  903,    0,  903,  905,
			  912, 1070,  915,  914,    0,  909,  913,  914,  903,  915,
			  907,  915,  907,  918,  911,  920,  911,  913,  909,  913,
			  920,  915,  907,  918,  912,  909,  911,  909,  917,  913,
			  917,  922,  912,    0,  915,  914,  924,  909,  913,  914,
			  917,  915,  922,  915,  921,  918,  921,  924,    0,  913,
			  926,  913,  919,  915,  919,  918,  921,    0,  926,  919,
			  917,  913,  917,  922,  919,  923,    0,  923,  924,  928,

			 1073,    0,  917,  923,  922,  930,  921,  923,  921,  924,
			  928,  925,  926,  925,  919,  930,  919,  927,  921,  925,
			  926,  919,    0,  925,    0,    0,  919,  923,  927,  923,
			  927,  928, 1073,    0,    0,  923,  929,  930,  929,  923,
			  927,    0,  928,  925,  929,  925,  940,  930,  929,  927,
			  940,  925,  931,  934,  931,  925,    0,    0,  934,  931,
			  927,  933,  927,  933,  931,  935,  936,  935,  929,    0,
			  929,  936,  927,  933,    0,    0,  929,  935,  940,    0,
			  929,    0,  940,    0,  931,  934,  931,    0,    0,    0,
			  934,  931,  937,  933,  937,  933,  931,  935,  936,  935, yy_Dummy>>,
			1, 200, 6600)
		end

	yy_chk_template_35 (an_array: ARRAY [INTEGER])
			-- Fill chunk #35 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  939,  941,  939,  936,  937,  933,    0,    0,  941,  935,
			  941,  943,  939,  943,  948,  945,  947,  945,  947,    0,
			  941,    0,    0,  943,  937,  948,  937,  945,  947,  949,
			  950,  949,  939,  941,  939,  950,  937,  949,    0,    0,
			  941,  949,  941,  943,  939,  943,  948,  945,  947,  945,
			  947,    0,  941,  954,  951,  943,  951,  948,    0,  945,
			  947,  949,  950,  949,  954,    0,  951,  950,  953,  949,
			  953,    0,    0,  949,    0,  955,  970,  955, 1000,    0,
			  953,  970, 1000,  955,    0,  954,  951,  955,  951,  958,
			  958,  958,  958,    0,    0,    0,  954,    0,  951,    0,

			  953,    0,  953,  961,  961,  961,  961,  955,  970,  955,
			 1000,    0,  953,  970, 1000,  955,  959,    0,  959,  955,
			    0,  959,  959,  959,  959,  960,    0,  960,    0,    0,
			  960,  960,  960,  960,  962,  962,  962,  962,  964,  964,
			  964,  964,    0,  961,  965,  965,  965,  965,  966,  966,
			  966,  966,  968,  968,  968,  968,  969,  971,  969,  972,
			    0,  969,  969,  969,  969,  971,  968,  971,    0,    0,
			  972,  973,  975,  973,  975,  976,  977,  971,  977,  973,
			  976,  980,    0,  973,  975,    0,  980,    0,  977,  971,
			    0,  972,  968,  982,    0,    0,    0,  971,  968,  971, yy_Dummy>>,
			1, 200, 6800)
		end

	yy_chk_template_36 (an_array: ARRAY [INTEGER])
			-- Fill chunk #36 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  982,    0,  972,  973,  975,  973,  975,  976,  977,  971,
			  977,  973,  976,  980,  981,  973,  975,  979,  980,  979,
			  977,  983,  981,  984,  981,  982, 1004,  985,  984,  979,
			 1004,  983,  982,  983,  981,  985,  987,  985,  987,    0,
			  989,    0,  989,  983,    0,  998,  981,  985,  987,  979,
			  998,  979,  989,  983,  981,  984,  981,    0, 1004,  985,
			  984,  979, 1004,  983,    0,  983,  981,  985,  987,  985,
			  987,  991,  989,  991,  989,  983,    0,  998,    0,  985,
			  987,  993,  998,  991,  989,  995,  993,  995,  993,  997,
			  999,  997,  999, 1017, 1017, 1017, 1017,  995,  993,    0,

			    0,  997,  999,  991, 1006,  991,    0, 1001,    0,    0,
			 1006,    0,    0,  993, 1001,  991, 1001,  995,  993,  995,
			  993,  997,  999,  997,  999, 1003, 1001, 1003, 1003,  995,
			  993, 1005, 1007,  997,  999,    0, 1006, 1003, 1005, 1001,
			 1005, 1007, 1006, 1007,    0,    0, 1001,    0, 1001, 1009,
			 1005, 1009, 1010, 1007,    0,    0, 1010, 1003, 1001, 1003,
			 1003, 1009, 1012, 1005, 1007,    0, 1012, 1011,    0, 1003,
			 1005, 1013, 1005, 1007, 1011, 1007, 1011, 1015, 1013, 1015,
			 1013, 1009, 1005, 1009, 1010, 1007, 1011,    0, 1010, 1015,
			 1013,    0,    0, 1009, 1012,    0,    0,    0, 1012, 1011, yy_Dummy>>,
			1, 200, 7000)
		end

	yy_chk_template_37 (an_array: ARRAY [INTEGER])
			-- Fill chunk #37 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			    0,    0,    0, 1013,    0,    0, 1011,    0, 1011, 1015,
			 1013, 1015, 1013, 1018, 1018, 1018, 1018,    0, 1011,    0,
			    0, 1015, 1013, 1019, 1019, 1019, 1019, 1020, 1020, 1020,
			 1020, 1021, 1021, 1021, 1021, 1022,    0, 1022,    0,    0,
			 1022, 1022, 1022, 1022, 1024, 1024, 1024, 1024, 1025, 1025,
			 1025, 1025,    0, 1018, 1026, 1026, 1026, 1026, 1024, 1028,
			 1029, 1028,    0, 1030, 1029, 1032, 1034, 1032, 1034, 1043,
			 1030, 1028, 1030, 1036, 1038, 1036, 1038, 1032, 1034,    0,
			 1043,    0, 1030,    0, 1024, 1036, 1038,    0,    0,    0,
			 1024, 1028, 1029, 1028, 1026, 1030, 1029, 1032, 1034, 1032,

			 1034, 1043, 1030, 1028, 1030, 1036, 1038, 1036, 1038, 1032,
			 1034, 1040, 1043, 1040, 1030,    0, 1047, 1036, 1038, 1042,
			 1044, 1042, 1044, 1040, 1046, 1047, 1046, 1048, 1044, 1048,
			 1051, 1042, 1044, 1048, 1051, 1050, 1046, 1050,    0, 1048,
			    0,    0,    0, 1040,    0, 1040,    0, 1050, 1047,    0,
			    0, 1042, 1044, 1042, 1044, 1040, 1046, 1047, 1046, 1048,
			 1044, 1048, 1051, 1042, 1044, 1048, 1051, 1050, 1046, 1050,
			    0, 1048, 1054, 1052, 1054, 1056,    0, 1056,    0, 1050,
			 1052,    0, 1052,    0, 1054,    0,    0, 1056, 1057, 1057,
			 1057, 1057, 1052, 1059, 1059, 1059, 1059, 1060, 1060, 1060, yy_Dummy>>,
			1, 200, 7200)
		end

	yy_chk_template_38 (an_array: ARRAY [INTEGER])
			-- Fill chunk #38 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			 1060, 1063,    0, 1063, 1054, 1052, 1054, 1056,    0, 1056,
			    0, 1064, 1052, 1063, 1052, 1064, 1054,    0,    0, 1056,
			 1061, 1061, 1061, 1061, 1052, 1065,    0, 1067, 1057, 1067,
			    0,    0, 1065, 1063, 1065, 1063, 1069, 1060, 1069, 1067,
			 1071,    0, 1071, 1064, 1065, 1063,    0, 1064, 1069,    0,
			    0,    0, 1071, 1072, 1072, 1072, 1072, 1065,    0, 1067,
			 1061, 1067,    0, 1074, 1065, 1074, 1065,    0, 1069,    0,
			 1069, 1067, 1071,    0, 1071, 1074, 1065,    0,    0,    0,
			 1069,    0,    0,    0, 1071,    0,    0,    0,    0,    0,
			    0,    0,    0, 1072,    0, 1074,    0, 1074,    0,    0,

			    0,    0,    0,    0,    0,    0,    0, 1074, 1076, 1076,
			 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076,
			 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076,
			 1076, 1077, 1077,    0, 1077, 1077, 1077, 1077, 1077, 1077,
			 1077, 1077, 1077, 1077, 1077, 1077, 1077, 1077, 1077, 1077,
			 1077, 1077, 1077, 1077, 1078,    0,    0,    0,    0,    0,
			    0, 1078, 1078, 1078, 1078, 1078, 1078, 1078, 1078, 1078,
			 1078, 1078, 1078, 1078, 1078, 1078, 1078, 1079, 1079,    0,
			 1079, 1079, 1079, 1079, 1079, 1079, 1079, 1079, 1079, 1079,
			 1079, 1079, 1079, 1079, 1079, 1079, 1079, 1079, 1079, 1079, yy_Dummy>>,
			1, 200, 7400)
		end

	yy_chk_template_39 (an_array: ARRAY [INTEGER])
			-- Fill chunk #39 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			 1080, 1080,    0, 1080, 1080, 1080, 1080,    0, 1080, 1080,
			 1080, 1080, 1080, 1080, 1080, 1080, 1080, 1080, 1080, 1080,
			 1080, 1080, 1080, 1081, 1081, 1081, 1081, 1081, 1081, 1081,
			 1081, 1081, 1081, 1081, 1081, 1081, 1081, 1082, 1082,    0,
			 1082, 1082, 1082,    0,    0, 1082, 1082, 1082, 1082, 1082,
			 1082, 1082, 1082, 1082, 1082, 1082, 1082, 1082, 1082, 1082,
			 1083, 1083, 1083, 1083, 1083, 1083, 1083, 1083, 1083, 1083,
			 1083, 1083, 1083, 1083, 1084,    0,    0, 1084,    0, 1084,
			 1084, 1084, 1084, 1084, 1084, 1084, 1084, 1084, 1084, 1084,
			 1084, 1084, 1084, 1084, 1084, 1084, 1084, 1085, 1085,    0,

			 1085, 1085, 1085, 1085, 1085, 1085, 1085, 1085, 1085, 1085,
			 1085, 1085, 1085, 1085, 1085, 1085, 1085, 1085, 1085, 1085,
			 1086, 1086,    0, 1086, 1086, 1086, 1086, 1086, 1086, 1086,
			 1086, 1086, 1086, 1086, 1086, 1086, 1086, 1086, 1086, 1086,
			 1086, 1086, 1086, 1087, 1087,    0, 1087, 1087, 1087, 1087,
			 1087, 1087, 1087, 1087, 1087, 1087, 1087, 1087, 1087, 1087,
			 1087, 1087, 1087, 1087, 1087, 1087, 1088,    0,    0,    0,
			    0, 1088, 1088, 1088, 1088, 1088, 1088, 1088, 1088, 1088,
			 1088, 1088, 1088, 1088, 1088, 1088, 1088, 1088, 1088, 1089,
			 1089, 1089, 1089, 1089, 1089, 1089, 1089,    0, 1089, 1089, yy_Dummy>>,
			1, 200, 7600)
		end

	yy_chk_template_40 (an_array: ARRAY [INTEGER])
			-- Fill chunk #40 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			 1089, 1089, 1089, 1089, 1089, 1089, 1089, 1089, 1089, 1089,
			 1089, 1089, 1090, 1090, 1090, 1090, 1090, 1090, 1090, 1090,
			 1090, 1090, 1090, 1090, 1090, 1091, 1091, 1091, 1091, 1091,
			 1091, 1091, 1091, 1091, 1091, 1091, 1091, 1091, 1092, 1092,
			 1092, 1092, 1092, 1092, 1092, 1092, 1092, 1092, 1092, 1092,
			 1092, 1093, 1093,    0, 1093, 1093, 1093,    0, 1093, 1093,
			 1093, 1093, 1093, 1093, 1093, 1093, 1093, 1093, 1093, 1093,
			 1093, 1093, 1093, 1093, 1094, 1094,    0, 1094, 1094, 1094,
			    0, 1094, 1094, 1094, 1094, 1094, 1094, 1094, 1094, 1094,
			 1094, 1094, 1094, 1094, 1094, 1094, 1094, 1095, 1095, 1095,

			 1095, 1095, 1095, 1095, 1095,    0, 1095, 1095, 1095, 1095,
			 1095, 1095, 1095, 1095, 1095, 1095, 1095, 1095, 1095, 1095,
			 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075,
			 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075,
			 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075,
			 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075,
			 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075,
			 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075,
			 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075,
			 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075, yy_Dummy>>,
			1, 200, 7800)
		end

	yy_chk_template_41 (an_array: ARRAY [INTEGER])
			-- Fill chunk #41 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075,
			 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075,
			 1075, yy_Dummy>>,
			1, 21, 8000)
		end

	yy_base_template: SPECIAL [INTEGER]
			-- Template for `yy_base'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 1095)
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
			    0,    0,    0,   99,  111,  701, 7920,  697, 7920,  691,
			  673,  619,  124,    0, 7920,  131,  138, 7920, 7920, 7920,
			 7920, 7920,   89,   87,   92,  221,  102,  129,  582, 7920,
			  100, 7920,  101,  572,  287,  218,  351,  101,  117,  217,
			   74,  361,  115,  202,  359,  134,   98,  224,  233,  222,
			  375,  146,  219, 7920,  532, 7920, 7920,  358,  427,  434,
			  498,  416,  506,  577,  421,  573,  500,  569,  588,  424,
			  623,  631,  640,  647,  680,  693,  685, 7920, 7920, 7920,
			   82,  427,  184,   87,  222,  252,  399,  389,  389, 7920,
			  745,  735,  762,  769,  466,  687,  713,  700,  723,  755,

			  779,  478, 7920,  418, 7920,  825, 7920,  919,  883,  896,
			  933,  948,  966,  993, 1013, 1027, 1043,    0,  978, 1060,
			 1072, 1087, 1107, 1122, 1137, 1154, 1162,  407, 1256, 1227,
			 1215, 1244, 1266, 1279, 1289, 1305, 7920, 7920, 7920, 1128,
			 7920, 7920, 7920,  648,  874,  357,  103,  419,  497, 1386,
			 1221,  143, 7920, 7920, 7920, 7920, 7920, 7920,  116,  499,
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
			 1910, 1783, 1962, 7920, 1954, 1968, 1988, 1999, 2013, 2023,
			 2033, 2044,  697,  218,  734,  334,  737,  745,  154,  819,
			  906,  914,  917,  933,  947, 1975, 2051, 2059, 2069, 2079,
			 2089, 2099, 2109, 1206, 2208, 2127, 2165, 7920, 2212, 2226,
			 2233, 2245, 2157, 2266, 2275, 2285, 2333, 2343, 2384, 2394,

			 2219, 2401, 2410, 2442, 2452, 2462, 2509, 2519, 2469, 2476,
			 2483, 2490, 2529, 2539, 2584, 2633, 2640, 2647, 2654, 2664,
			 2678, 2688, 2698, 2708, 2758, 2802, 2815, 2828, 2852, 2865,
			 2878, 2923, 2947, 2960, 2897, 2910, 2931, 2973, 2991, 3005,
			 2745, 7920, 3013, 3021, 3038, 3050, 3063, 3081, 3095, 3070,
			 3111,  206, 3128, 3140, 3176, 3160, 3189, 3201, 3208, 3218,
			 3230, 3237, 3250, 3257, 3266, 3279, 3298, 3308, 3327, 3347,
			 3356, 3369, 3379, 3389, 3399, 3409, 3419, 2922, 2334, 1154,
			 7920, 3349, 2679, 2806, 2858,  286,  671,  154, 1309,  141,
			 3500,  116, 2869, 3518, 1499, 3177, 1678, 2373, 1606,  498, yy_Dummy>>,
			1, 200, 200)
		end

	yy_base_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			 3515, 2634,  513, 3484,  647, 3532, 3514, 3551, 1241, 1254,
			 1299, 1322, 1348, 1461,  705, 3546, 1784, 3565, 1847, 3579,
			 1976, 3582, 1629, 3598, 2199, 3615, 1849, 1973, 2383, 3629,
			 3643, 3644, 2385, 3667,  763, 2007, 3650, 3681, 3651, 2655,
			 3700, 3704, 2825, 3707, 3533, 3718, 3344, 3753, 1728, 3745,
			 3179,  889, 3347, 2620, 3767, 3766, 3772, 3780, 3807, 3781,
			 3513, 3828, 3774, 3599, 3833, 3832, 3577, 3857, 1793, 3846,
			  904, 3861, 3698, 3886, 3903, 3912, 3845, 3890, 3907, 2622,
			 3916, 3628, 3940, 3941, 3948, 3949, 3977, 3995, 3930, 3973,
			 4003, 4010, 3994, 4024, 1058, 4041, 2229, 4048, 4037, 4059,

			 4058, 4035, 1060, 4074, 4095, 4112, 1154, 4113, 3713, 4119,
			 4099, 4136, 1155, 4150, 7920, 4118, 4132, 4146, 4153, 4164,
			 4179, 1569, 1627, 1811, 1866, 1987, 2009, 2127, 2439, 7920,
			 4188, 4198, 4212, 4226, 4247, 4258, 4273, 7920, 4282, 4292,
			 4306, 4320, 4330, 4341, 4352, 4451, 4458, 4465, 4472, 4482,
			 4492, 4499, 4506, 4513, 4520, 4530, 4629, 3338, 4234, 4636,
			 4643, 4650, 4657, 4667, 4674, 4681, 4688, 4698, 4708, 4802,
			 4815, 4822, 4829, 4747, 4837, 4844, 4851, 4861, 4871, 7920,
			 7920, 7920, 7920, 7920, 4961, 7920, 7920, 7920, 7920, 7920,
			 7920, 7920, 7920, 7920, 7920, 7920, 7920, 7920, 7920, 7920, yy_Dummy>>,
			1, 200, 400)
		end

	yy_base_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			 7920, 4894, 4919, 4793, 2575, 4179, 2690, 4797, 4521, 2793,
			 2964, 4829, 4977, 4846,  915,  106, 2631,   96,    0,   86,
			 4983, 5002, 2920, 4991, 3688, 4992, 4406, 5027, 1968, 5010,
			 3510, 1209, 5050, 5031, 2553, 2631, 2899, 5046, 4606, 5067,
			 4097, 5083, 4017, 5102, 4613, 5107, 3057, 5086, 3925, 5091,
			 3578, 5131, 1357, 5147, 4426, 5150, 4428, 4640, 5126, 5155,
			 4786, 5166, 4627, 5171, 3241, 5207, 1434, 5193, 5211, 5224,
			 1435, 5228, 3193, 5232, 4822, 5235, 5058, 5259, 5204, 5280,
			 5257, 5275, 1548, 5288, 3346, 5294, 1549, 5299, 1567, 5315,
			 3823, 5323, 1733, 5334, 3979, 1771, 5339, 5340, 4199, 5385,

			 5292, 5358, 5241, 5393, 1901, 5389, 4325, 4372, 5398, 5404,
			 2432, 5422, 4630, 5449, 5444, 5453, 2164, 5445, 4101, 5458,
			 2204, 5474, 2267, 5498, 4647, 5501, 5347, 5505, 5092, 5509,
			 5148, 5526, 2320, 5522, 2380, 5550, 5518, 5534, 2755, 2971,
			 4879, 5546, 5553, 5563, 5574, 5585, 5593, 5601, 5612, 5619,
			 5629, 5647, 5746, 5753, 5760, 5767, 5774, 5723, 5781, 5738,
			 5788, 5795, 3181, 5433, 3055, 3162, 5876, 3244, 5880, 3319,
			 5884, 4681, 5891, 5898, 5728, 5730, 2475, 5739, 2603, 5874,
			 4442, 5881, 2996, 5892, 5224, 5900, 2753, 5907, 2798, 5921,
			 5519, 5940, 5698, 5957, 4637, 5956, 2836, 5961, 5899, 5964, yy_Dummy>>,
			1, 200, 600)
		end

	yy_base_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			 3888, 5975, 5449, 6010, 5741, 6013, 5156, 6028, 5321, 6021,
			 5534, 6014, 2943, 6037, 6021, 6064, 5933, 6073, 6038, 6087,
			 3056, 6082, 3321, 6088, 3516, 6113, 5287, 6127, 3608, 6136,
			 3642, 6128, 6144, 6151, 6137, 6152, 4823, 6177, 3711, 6191,
			 6181, 6205, 6204, 6222, 6202, 6226, 6219, 6243, 5952, 6251,
			 3746, 6250, 6095, 6278, 6268, 6299, 3779, 6296, 3797, 6303,
			 6309, 6314, 4016, 6317, 6185, 6342, 6310, 6326, 6338, 6347,
			 6358, 7920, 6444, 6391, 4857, 4473, 6448, 6452, 5006, 5027,
			 6456, 5682, 6466, 6470, 4138, 6375, 4168, 6453, 6328, 6464,
			 6459, 6458, 6464, 6501, 4198, 5982, 6482, 6515, 6483, 6520,

			 6481, 6536, 6522, 6553, 4323, 6544, 4324, 6567, 6537, 6582,
			 4421, 6571, 6592, 6606, 6599, 6598, 4440, 6617, 6605, 6641,
			 6575, 6633, 6623, 6654, 6628, 6670, 6650, 6687, 6661, 6695,
			 6667, 6711, 4800, 6720, 6715, 6724, 6728, 6751, 5041, 6759,
			 6712, 6767, 5043, 6770, 5177, 6774, 5198, 6775, 6776, 6788,
			 6792, 6813, 5223, 6827, 6815, 6834, 5805, 6292, 6869, 6901,
			 6910, 6883, 6914, 5384, 6918, 6924, 6928, 7920, 6932, 6941,
			 6843, 6924, 6921, 6930, 5402, 6931, 6937, 6935, 5467, 6976,
			 6948, 6981, 6962, 6990, 6990, 6994, 5716, 6995, 5526, 6999,
			 5567, 7030, 6510, 7045, 5568, 7044, 5586, 7048, 7007, 7049, yy_Dummy>>,
			1, 200, 800)
		end

	yy_base_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			 6844, 7073, 6528, 7084, 6992, 7097, 7072, 7100, 5885, 7108,
			 7118, 7133, 7128, 7137, 5900, 7136,   77, 7073, 7193, 7203,
			 7207, 7211, 7220,   70, 7224, 7228, 7234, 5914, 7218, 7226,
			 7229, 5951, 7224, 6027, 7225, 6077, 7232, 6054, 7233, 6094,
			 7270, 6152, 7278, 7231, 7279, 6264, 7283, 7278, 7286, 6312,
			 7294, 7296, 7339, 6326, 7331, 6359, 7334, 7368,   58, 7373,
			 7377, 7400, 6392, 7360, 7377, 7391, 6393, 7386, 6457, 7395,
			 6561, 7399, 7433, 6662, 7422, 7920, 7507, 7530, 7553, 7576,
			 7599, 7614, 7636, 7650, 7673, 7696, 7719, 7742, 7765, 7788,
			 7802, 7815, 7828, 7850, 7873, 7896, yy_Dummy>>,
			1, 96, 1000)
		end

	yy_def_template: SPECIAL [INTEGER]
			-- Template for `yy_def'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 1095)
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
			    0, 1075,    1, 1076, 1076, 1075, 1075, 1075, 1075, 1075,
			 1075, 1075, 1077, 1078, 1075, 1079, 1080, 1075, 1075, 1075,
			 1075, 1075, 1075, 1075, 1075, 1081, 1081, 1081, 1075, 1075,
			 1075, 1075, 1075, 1075, 1075,   34,   35,   35,   35,   35,
			   35,   35,   35,   35,   35,   35,   35,   35,   35,   35,
			   35,   35,   35, 1075, 1075, 1075, 1075, 1082, 1083, 1083,
			 1083, 1083, 1083,   62,   62,   62,   62,   62,   62,   62,
			   62,   62,   62,   62,   62,   62,   62, 1075, 1075, 1075,
			 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1084, 1075, 1075,
			 1084, 1075, 1085, 1086, 1084, 1084, 1084, 1084, 1084, 1084,

			 1084, 1075, 1075, 1075, 1075, 1077, 1075, 1087, 1077, 1077,
			 1077, 1077, 1077, 1077, 1077, 1077, 1077, 1078, 1079, 1079,
			 1079, 1079, 1079, 1079, 1079, 1079, 1088, 1075, 1088, 1088,
			 1088, 1088, 1088, 1088, 1088, 1088, 1075, 1075, 1075, 1075,
			 1075, 1075, 1075, 1089, 1081, 1081, 1081, 1090, 1091, 1092,
			 1081, 1081, 1075, 1075, 1075, 1075, 1075, 1075,   35,   35,
			   35,   35,   35,   35,   35,   62,   62,   62,   62,   62,
			   62,   62, 1075, 1075, 1075, 1075, 1075, 1075, 1075,   35,
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
			   62,   35,   62, 1075, 1082, 1082, 1082, 1082, 1082, 1082,
			 1082, 1082, 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075,
			 1075, 1075, 1075, 1075, 1075, 1084, 1084, 1084, 1084, 1084,
			 1084, 1084, 1084, 1075, 1075, 1093, 1094, 1075, 1084, 1085,
			 1086, 1075, 1084, 1085, 1085, 1085, 1085, 1085, 1085, 1085,

			 1084, 1086, 1086, 1086, 1086, 1086, 1086, 1086, 1084, 1084,
			 1084, 1084, 1084, 1084, 1087, 1079, 1079, 1087, 1087, 1087,
			 1087, 1087, 1087, 1087, 1087, 1087, 1077, 1077, 1077, 1077,
			 1077, 1077, 1077, 1077, 1079, 1079, 1079, 1079, 1079, 1079,
			 1088, 1075, 1088, 1088, 1088, 1088, 1088, 1088, 1088, 1088,
			 1088, 1075, 1088, 1088, 1088, 1088, 1088, 1088, 1088, 1088,
			 1088, 1088, 1088, 1088, 1088, 1088, 1088, 1088, 1088, 1088,
			 1088, 1088, 1088, 1088, 1088, 1088, 1088, 1075, 1075, 1075,
			 1075, 1075, 1075, 1081, 1081, 1081, 1090, 1090, 1091, 1091,
			 1092, 1092, 1081, 1081,   35,   62,   35,   62,   35,   35, yy_Dummy>>,
			1, 200, 200)
		end

	yy_def_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			   62,   62,   35,   62,   35,   62,   35,   62, 1075, 1075,
			 1075, 1075, 1075, 1075,   35,   62,   35,   62,   35,   62,
			   35,   62,   35,   62,   35,   62,   35,   35,   35,   62,
			   62,   62,   35,   62,   35,   35,   62,   62,   35,   35,
			   62,   62,   35,   62,   35,   62,   35,   62,   35,   62,
			   35,   35,   35,   35,   35,   62,   62,   62,   62,   62,
			   35,   62,   35,   35,   62,   62,   35,   62,   35,   62,
			   35,   62,   35,   62,   35,   62,   35,   35,   35,   35,
			   35,   35,   62,   62,   62,   62,   62,   62,   35,   35,
			   62,   62,   35,   62,   35,   62,   35,   62,   35,   62,

			   35,   35,   35,   62,   62,   62,   35,   62,   35,   62,
			   35,   62,   35,   62, 1075, 1082, 1082, 1082, 1082, 1082,
			 1082, 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075,
			 1093, 1093, 1093, 1093, 1093, 1093, 1093, 1075, 1094, 1094,
			 1094, 1094, 1094, 1094, 1094, 1085, 1085, 1085, 1085, 1085,
			 1085, 1086, 1086, 1086, 1086, 1086, 1086, 1084, 1084, 1087,
			 1087, 1087, 1087, 1087, 1087, 1087, 1087, 1087, 1087, 1077,
			 1077, 1079, 1079, 1088, 1088, 1088, 1088, 1088, 1088, 1075,
			 1075, 1075, 1075, 1075, 1088, 1075, 1075, 1075, 1075, 1075,
			 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075, yy_Dummy>>,
			1, 200, 400)
		end

	yy_def_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			 1075, 1088, 1088, 1075, 1075, 1075, 1075, 1075, 1075, 1075,
			 1075, 1075, 1081, 1081, 1090, 1090, 1091, 1091,  390, 1092,
			 1081, 1081,   35,   62,   35,   62,   35,   62,   35,   62,
			   35,   35,   62,   62, 1075, 1075,   35,   62,   35,   62,
			   35,   62,   35,   62,   35,   62,   35,   62,   35,   62,
			   35,   62,   35,   62,   35,   62,   35,   35,   62,   62,
			   35,   62,   35,   62,   35,   62,   35,   35,   62,   62,
			   35,   62,   35,   62,   35,   62,   35,   62,   35,   62,
			   35,   62,   35,   62,   35,   62,   35,   62,   35,   62,
			   35,   62,   35,   62,   35,   35,   62,   62,   35,   62,

			   35,   62,   35,   62,   35,   62,   35,   35,   62,   62,
			   35,   62,   35,   62,   35,   62,   35,   62,   35,   62,
			   35,   62,   35,   62,   35,   62,   35,   62,   35,   62,
			   35,   62,   35,   62,   35,   62, 1082, 1082, 1075, 1075,
			 1093, 1093, 1093, 1093, 1093, 1093, 1094, 1094, 1094, 1094,
			 1094, 1094, 1085, 1085, 1086, 1086, 1087, 1087, 1087, 1088,
			 1088, 1088, 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075,
			 1075, 1075, 1089, 1081,   35,   62,   35,   62,   35,   62,
			   35,   62,   35,   62,   35,   62,   35,   62,   35,   62,
			   35,   62,   35,   62,   35,   62,   35,   62,   35,   62, yy_Dummy>>,
			1, 200, 600)
		end

	yy_def_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			   35,   62,   35,   62,   35,   62,   35,   62,   35,   62,
			   35,   62,   35,   62,   35,   62,   35,   62,   35,   62,
			   35,   62,   35,   62,   35,   62,   35,   62,   35,   62,
			   35,   62,   35,   62,   35,   62,   35,   62,   35,   62,
			   35,   62,   35,   62,   35,   62,   35,   62,   35,   62,
			   35,   62,   35,   62,   35,   62,   35,   62,   35,   62,
			   35,   62,   35,   62,   35,   62, 1093, 1093, 1094, 1094,
			 1087, 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075,
			 1075, 1075, 1075, 1095,   35,   62,   35,   62,   35,   62,
			   35,   62,   35,   62,   35,   35,   62,   62,   35,   62,

			   35,   62,   35,   62,   35,   62,   35,   62,   35,   62,
			   35,   62,   35,   62,   35,   62,   35,   62,   35,   62,
			   35,   62,   35,   62,   35,   62,   35,   62,   35,   62,
			   35,   62,   35,   62,   35,   62,   35,   62,   35,   62,
			   35,   62,   35,   62,   35,   62,   35,   62,   35,   62,
			   35,   62,   35,   62,   35,   62, 1075, 1075, 1075, 1075,
			 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075,
			   35,   62,   35,   62,   35,   62,   35,   62,   35,   62,
			   35,   62,   35,   62,   35,   62,   35,   62,   35,   62,
			   35,   62,   35,   62,   35,   62,   35,   62,   35,   62, yy_Dummy>>,
			1, 200, 800)
		end

	yy_def_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			   35,   62,   35,   62,   35,   62,   35,   62,   35,   62,
			   35,   62,   35,   62,   35,   62, 1075, 1075, 1075, 1075,
			 1075, 1075, 1075, 1075, 1075, 1075, 1075,   35,   62,   35,
			   62,   35,   62,   35,   62,   35,   62,   35,   62,   35,
			   62,   35,   62,   35,   62,   35,   62,   35,   62,   35,
			   62,   35,   62,   35,   62,   35,   62, 1075, 1075, 1075,
			 1075, 1075,   35,   62,   35,   62,   35,   62,   35,   62,
			   35,   62, 1075,   35,   62,    0, 1075, 1075, 1075, 1075,
			 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075,
			 1075, 1075, 1075, 1075, 1075, 1075, yy_Dummy>>,
			1, 96, 1000)
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
			   18,    1,   10,   10,   10,   10,   10,   10,   10,   10,
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
			create an_array.make_filled (0, 0, 1076)
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
			  789,  791,  792,  795,  797,  798,  798,  798,  798,  798,
			  798,  798,  798,  798,  798,  798,  798,  798,  798,  798,
			  799,  799,  799,  799,  799,  799,  799,  799,  800,  800,
			  800,  800,  800,  800,  800,  800,  801,  802,  803,  804,
			  805,  806,  807,  808,  809,  810,  811,  812,  813,  814,
			  815,  816,  816,  817,  817,  817,  817,  817,  817,  817,
			  818,  819,  820,  821,  822,  823,  824,  825,  826,  827,
			  828,  829,  830,  831,  832,  833,  834,  835,  836,  837,
			  838,  839,  840,  841,  842,  843,  844,  845,  846,  847, yy_Dummy>>,
			1, 200, 400)
		end

	yy_accept_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			  848,  849,  850,  851,  853,  853,  855,  855,  857,  857,
			  857,  857,  859,  861,  863,  863,  863,  863,  863,  863,
			  863,  865,  867,  869,  870,  872,  873,  875,  876,  878,
			  879,  881,  883,  884,  885,  885,  885,  887,  888,  890,
			  891,  893,  894,  896,  897,  899,  900,  902,  903,  905,
			  906,  908,  909,  912,  914,  916,  917,  919,  921,  922,
			  923,  925,  926,  928,  929,  931,  932,  935,  937,  939,
			  940,  942,  943,  945,  946,  948,  949,  951,  952,  954,
			  955,  957,  958,  961,  963,  965,  966,  969,  971,  974,
			  976,  978,  979,  982,  984,  986,  988,  989,  990,  992,

			  993,  995,  996,  998,  999, 1001, 1002, 1004, 1006, 1007,
			 1008, 1010, 1011, 1013, 1014, 1016, 1017, 1020, 1022, 1024,
			 1025, 1028, 1030, 1033, 1035, 1037, 1038, 1040, 1041, 1043,
			 1044, 1046, 1047, 1050, 1052, 1055, 1057, 1057, 1057, 1057,
			 1057, 1057, 1057, 1057, 1057, 1057, 1057, 1057, 1057, 1057,
			 1057, 1057, 1057, 1058, 1059, 1060, 1061, 1061, 1061, 1061,
			 1062, 1063, 1064, 1065, 1067, 1067, 1067, 1069, 1069, 1073,
			 1073, 1075, 1075, 1075, 1077, 1079, 1080, 1083, 1085, 1088,
			 1090, 1092, 1093, 1095, 1096, 1098, 1099, 1102, 1104, 1107,
			 1109, 1111, 1112, 1114, 1115, 1117, 1118, 1121, 1123, 1125, yy_Dummy>>,
			1, 200, 600)
		end

	yy_accept_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			 1126, 1128, 1129, 1131, 1132, 1134, 1135, 1137, 1138, 1140,
			 1141, 1143, 1144, 1147, 1149, 1151, 1152, 1154, 1155, 1157,
			 1158, 1160, 1161, 1164, 1166, 1168, 1169, 1171, 1172, 1174,
			 1175, 1178, 1180, 1182, 1183, 1185, 1186, 1188, 1189, 1191,
			 1192, 1194, 1195, 1197, 1198, 1200, 1201, 1203, 1204, 1206,
			 1207, 1210, 1212, 1214, 1215, 1217, 1218, 1221, 1223, 1225,
			 1226, 1228, 1229, 1232, 1234, 1236, 1237, 1237, 1237, 1237,
			 1237, 1237, 1238, 1238, 1240, 1240, 1241, 1242, 1246, 1246,
			 1246, 1248, 1248, 1249, 1249, 1252, 1254, 1257, 1259, 1261,
			 1262, 1264, 1265, 1267, 1268, 1271, 1273, 1275, 1276, 1278,

			 1279, 1281, 1282, 1284, 1285, 1288, 1290, 1293, 1295, 1297,
			 1298, 1301, 1303, 1305, 1306, 1308, 1309, 1312, 1314, 1316,
			 1317, 1319, 1320, 1322, 1323, 1325, 1326, 1328, 1329, 1331,
			 1332, 1334, 1335, 1338, 1340, 1342, 1343, 1345, 1346, 1349,
			 1351, 1353, 1354, 1357, 1359, 1362, 1364, 1367, 1369, 1371,
			 1372, 1374, 1375, 1378, 1380, 1382, 1383, 1383, 1384, 1384,
			 1384, 1384, 1388, 1388, 1389, 1390, 1390, 1390, 1391, 1392,
			 1393, 1395, 1396, 1398, 1399, 1402, 1404, 1406, 1407, 1410,
			 1412, 1414, 1415, 1417, 1418, 1420, 1421, 1423, 1424, 1427,
			 1429, 1432, 1434, 1436, 1437, 1440, 1442, 1445, 1447, 1449, yy_Dummy>>,
			1, 200, 800)
		end

	yy_accept_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			 1450, 1452, 1453, 1455, 1456, 1458, 1459, 1461, 1462, 1465,
			 1467, 1469, 1470, 1472, 1473, 1476, 1478, 1479, 1479, 1480,
			 1480, 1482, 1482, 1482, 1483, 1484, 1484, 1485, 1488, 1490,
			 1492, 1493, 1496, 1498, 1501, 1503, 1505, 1506, 1509, 1511,
			 1514, 1516, 1519, 1521, 1523, 1524, 1527, 1529, 1531, 1532,
			 1535, 1537, 1539, 1540, 1543, 1545, 1548, 1550, 1551, 1553,
			 1553, 1555, 1556, 1559, 1561, 1563, 1564, 1567, 1569, 1572,
			 1574, 1577, 1579, 1581, 1584, 1586, 1586, yy_Dummy>>,
			1, 77, 1000)
		end

	yy_acclist_template: SPECIAL [INTEGER]
			-- Template for `yy_acclist'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 1585)
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
			    0,  147,  147,  168,  166,  167,    2,  166,  167,    4,
			  167,    5,  166,  167,    1,  166,  167,   11,  166,  167,
			  149,  166,  167,  113,  166,  167,   18,  166,  167,  149,
			  166,  167,  166,  167,   12,  166,  167,   13,  166,  167,
			   33,  166,  167,   32,  166,  167,    9,  166,  167,   31,
			  166,  167,    7,  166,  167,   34,  166,  167,  151,  158,
			  166,  167,  151,  158,  166,  167,  151,  158,  166,  167,
			   10,  166,  167,    8,  166,  167,   38,  166,  167,   36,
			  166,  167,   37,  166,  167,  166,  167,  111,  112,  166,
			  167,  111,  112,  166,  167,  111,  112,  166,  167,  111,

			  112,  166,  167,  111,  112,  166,  167,  111,  112,  166,
			  167,  111,  112,  166,  167,  111,  112,  166,  167,  111,
			  112,  166,  167,  111,  112,  166,  167,  111,  112,  166,
			  167,  111,  112,  166,  167,  111,  112,  166,  167,  111,
			  112,  166,  167,  111,  112,  166,  167,  111,  112,  166,
			  167,  111,  112,  166,  167,  111,  112,  166,  167,  111,
			  112,  166,  167,   16,  166,  167,  166,  167,   17,  166,
			  167,   35,  166,  167,  166,  167,  112,  166,  167,  112,
			  166,  167,  112,  166,  167,  112,  166,  167,  112,  166,
			  167,  112,  166,  167,  112,  166,  167,  112,  166,  167, yy_Dummy>>,
			1, 200, 0)
		end

	yy_acclist_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  112,  166,  167,  112,  166,  167,  112,  166,  167,  112,
			  166,  167,  112,  166,  167,  112,  166,  167,  112,  166,
			  167,  112,  166,  167,  112,  166,  167,  112,  166,  167,
			  112,  166,  167,   14,  166,  167,   15,  166,  167,   39,
			  166,  167,  166,  167,  166,  167,  166,  167,  166,  167,
			  166,  167,  166,  167,  166,  167,  147,  167,  143,  167,
			  145,  167,  146,  147,  167,  142,  167,  147,  167,  147,
			  167,  147,  167,  147,  167,  147,  167,  147,  167,  147,
			  167,  147,  167,  147,  167,    2,    3,    1,   40,  149,
			  148,  148, -138,  149, -305, -139,  149, -306,  149,  149,

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
			  112,  112,  102,  111,  112,  102,  112,  165,  140,  141, yy_Dummy>>,
			1, 200, 600)
		end

	yy_acclist_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  147,  147,  147,  147,  147,  147,  147,  147,  147,  147,
			  147,  147,  147,  147,  148,  148,  148,  149,  149,  149,
			  149,  137,  137,  137,  137,  137,  137,  131,  129,  130,
			  132,  133,  137,  134,  135,  115,  116,  117,  118,  119,
			  120,  121,  122,  123,  124,  125,  126,  127,  128,  137,
			  137,  161,  164,  161,  164,  161,  164,  160,  163,  151,
			  158,  151,  158,  151,  158,  151,  158,  111,  112,  112,
			  111,  112,  112,  111,  112,  112,  111,  112,  112,  111,
			  112,  111,  112,  112,  112,  111,  112,  112,  111,  112,
			  112,  111,  112,  112,  111,  112,  112,  111,  112,  112,

			  111,  112,  112,  111,  112,  112,  111,  112,  112,   57,
			  111,  112,   57,  112,  111,  112,  112,  111,  112,  111,
			  112,  112,  112,  111,  112,  112,  111,  112,  112,  111,
			  112,  112,   66,  111,  112,  111,  112,   66,  112,  112,
			  111,  112,  112,  111,  112,  112,  111,  112,  112,  111,
			  112,  112,  111,  112,  112,  111,  112,  112,   74,  111,
			  112,   74,  112,  111,  112,  112,   76,  111,  112,   76,
			  112,  107,  111,  112,  107,  112,  111,  112,  112,   80,
			  111,  112,   80,  112,  111,  112,  111,  112,  112,  112,
			  111,  112,  112,  111,  112,  112,  111,  112,  112,  111, yy_Dummy>>,
			1, 200, 800)
		end

	yy_acclist_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  112,  112,  111,  112,  111,  112,  112,  112,  111,  112,
			  112,  111,  112,  112,  111,  112,  112,  108,  111,  112,
			  108,  112,  111,  112,  112,   94,  111,  112,   94,  112,
			   95,  111,  112,   95,  112,  111,  112,  112,  111,  112,
			  112,  111,  112,  112,  111,  112,  112,  100,  111,  112,
			  100,  112,  101,  111,  112,  101,  112,  147,  147,  147,
			  147,  137,  137,  137,  161,  161,  164,  161,  164,  160,
			  161,  163,  164,  160,  163,  151,  158,  111,  112,  112,
			   41,  111,  112,   41,  112,   42,  111,  112,   42,  112,
			  111,  112,  112,  111,  112,  112,  111,  112,  112,   48,

			  111,  112,   48,  112,   49,  111,  112,   49,  112,  111,
			  112,  112,  111,  112,  112,  111,  112,  112,   54,  111,
			  112,   54,  112,  111,  112,  112,  111,  112,  112,  111,
			  112,  112,  111,  112,  112,  111,  112,  112,  111,  112,
			  112,  111,  112,  112,   64,  111,  112,   64,  112,  111,
			  112,  112,  111,  112,  112,  111,  112,  112,  111,  112,
			  112,   70,  111,  112,   70,  112,  111,  112,  112,  111,
			  112,  112,  111,  112,  112,   75,  111,  112,   75,  112,
			  111,  112,  112,  111,  112,  112,  111,  112,  112,  111,
			  112,  112,  111,  112,  112,  111,  112,  112,  111,  112, yy_Dummy>>,
			1, 200, 1000)
		end

	yy_acclist_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  112,  111,  112,  112,  111,  112,  112,   90,  111,  112,
			   90,  112,  111,  112,  112,  111,  112,  112,   93,  111,
			  112,   93,  112,  111,  112,  112,  111,  112,  112,   98,
			  111,  112,   98,  112,  111,  112,  112,  136,  161,  164,
			  164,  161,  160,  161,  163,  164,  160,  163,  159,  103,
			  111,  112,  103,  112,   46,  111,  112,   46,  112,  111,
			  112,  112,  111,  112,  112,  111,  112,  112,   51,  111,
			  112,  111,  112,   51,  112,  112,  111,  112,  112,  111,
			  112,  112,  111,  112,  112,   58,  111,  112,   58,  112,
			   60,  111,  112,   60,  112,  111,  112,  112,   62,  111,

			  112,   62,  112,  111,  112,  112,  111,  112,  112,   67,
			  111,  112,   67,  112,  111,  112,  112,  111,  112,  112,
			  111,  112,  112,  111,  112,  112,  111,  112,  112,  111,
			  112,  112,  111,  112,  112,   83,  111,  112,   83,  112,
			  111,  112,  112,  111,  112,  112,   86,  111,  112,   86,
			  112,  111,  112,  112,   88,  111,  112,   88,  112,   89,
			  111,  112,   89,  112,   91,  111,  112,   91,  112,  111,
			  112,  112,  111,  112,  112,   97,  111,  112,   97,  112,
			  111,  112,  112,  161,  160,  161,  163,  164,  164,  160,
			  162,  164,  162,  111,  112,  112,  111,  112,  112,   50, yy_Dummy>>,
			1, 200, 1200)
		end

	yy_acclist_template_8 (an_array: ARRAY [INTEGER])
			-- Fill chunk #8 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  111,  112,   50,  112,  111,  112,  112,   53,  111,  112,
			   53,  112,  111,  112,  112,  111,  112,  112,  111,  112,
			  112,  111,  112,  112,   65,  111,  112,   65,  112,   69,
			  111,  112,   69,  112,  111,  112,  112,   71,  111,  112,
			   71,  112,   72,  111,  112,   72,  112,  111,  112,  112,
			  111,  112,  112,  111,  112,  112,  111,  112,  112,  111,
			  112,  112,   87,  111,  112,   87,  112,  111,  112,  112,
			  111,  112,  112,   99,  111,  112,   99,  112,  164,  164,
			  160,  161,  163,  164,  163,  104,  111,  112,  104,  112,
			  111,  112,  112,   52,  111,  112,   52,  112,   55,  111,

			  112,   55,  112,  111,  112,  112,   61,  111,  112,   61,
			  112,   63,  111,  112,   63,  112,  109,  111,  112,  109,
			  112,  111,  112,  112,   78,  111,  112,   78,  112,  111,
			  112,  112,   85,  111,  112,   85,  112,  111,  112,  112,
			   92,  111,  112,   92,  112,   96,  111,  112,   96,  112,
			  164,  163,  164,  163,  164,  163,  105,  111,  112,  105,
			  112,  111,  112,  112,   73,  111,  112,   73,  112,   82,
			  111,  112,   82,  112,   84,  111,  112,   84,  112,  163,
			  164,  106,  111,  112,  106,  112, yy_Dummy>>,
			1, 186, 1400)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER = 7920
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER = 1075
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER = 1076
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

	yyNb_rules: INTEGER = 167
			-- Number of rules

	yyEnd_of_buffer: INTEGER = 168
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
