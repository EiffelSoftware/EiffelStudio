note
	description:"Scanners for Eiffel parsers"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Arnaud PICHERY from an Eric Bezault model"
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

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
				
when 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20 then
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
					
when 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41 then
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
					
when 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

									if in_comments then
											-- Comment.
										curr_token := new_comment (text)
									else
											-- Keyword.
										curr_token := new_keyword (text)
									end
									update_token_list
								
when 106, 107, 108, 109, 110, 111 then
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
						
when 112 then
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
						
when 113 then
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
										
when 114 then
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
										
when 115 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

										if not in_comments then
											curr_token := new_operator (text)
										else
											curr_token := new_comment (text)
										end
										update_token_list
										
when 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 131, 132, 133, 134, 135, 136, 137 then
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
	
when 138 then
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
	
when 139 then
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
	
when 140 then
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
		
when 148 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

			curr_token := new_string (text)
			update_token_list
		
when 149 then
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
	
when 150, 151, 152, 153 then
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
	
when 154, 155, 156, 157 then
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
	
when 158 then
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
	
when 159, 160 then
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
	
when 161 then
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
	
when 162, 163 then
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
	
when 164, 165 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

		curr_token := new_text_in_comment (text)
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
			create an_array.make_filled (0, 0, 7069)
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
			Result := yy_fixed_array (an_array)
		end

	yy_nxt_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			    0,    6,    7,    8,    9,   10,   11,   12,   13,   14,
			   15,   16,   17,   18,   19,   20,   21,   22,   23,   24,
			   25,   26,   26,   26,   27,   28,   29,   30,   31,   32,
			   33,   34,   35,   36,   37,   38,   39,   39,   40,   39,
			   39,   41,   39,   42,   43,   44,   39,   45,   46,   47,
			   48,   49,   50,   51,   39,   39,   52,   53,   54,   55,
			    6,   56,   57,   58,   59,   60,   61,   62,   63,   63,
			   64,   63,   63,   65,   63,   66,   67,   68,   63,   69,
			   70,   71,   72,   73,   74,   75,   63,   63,   76,   77,
			   78,    6,    6,    6,    6,    6,    6,   79,   80,   81,

			   82,   83,   84,   85,   86,   87,   89,   90,   91,   92,
			  140,   93,  142,  818,  143,  143,  143,  143,  144,  155,
			  156,  141,  157,  158,  712,  147,  145,  148,  148,  148,
			  148,  160, 1015,  108,  210, 1015,  109,  186,  150,  151,
			  211,  160,  108,  160,  175,  109,  130,  187,  130,  130,
			  705,  215,  224,  147,  131,  148,  148,  148,  148,  160,
			  152,  120,   94,  167,  226,  214,  212,  153,  160,  188,
			  150,  151,  213,  167,  361,  167,  175,  361,  570,  189,
			  167,  167,  110,  215,  225,  160,  244,  160,  225,  146,
			  238,  167,  152,   94,  568,  153,  227,  215,  363,  363, yy_Dummy>>,
			1, 200, 0)
		end

	yy_nxt_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  167,   95,   96,   97,   97,   98,   99,  100,  101,  102,
			   89,   90,   91,   92,  110,   93,  566,  167,  245,  167,
			  225,  570,  239,  111,  112,  113,  113,  114,  115,  116,
			  117,  118,  121,  122,  123,  123,  124,  125,  126,  127,
			  128,  132,  133,  134,  134,  135,  136,  137,  138,  139,
			  176,  160,  227,  160,  177,  239,  190,  178,  191,  188,
			  179,  234,  160,  180,  160,  568,   94,  245,  192,  189,
			  246,  235,  250,  251,  252,  252,  253,  254,  255,  256,
			  257,  566,  181,  167,  227,  167,  182,  239,  193,  183,
			  194,  188,  184,  236,  167,  185,  167,   94,  532,  245,

			  195,  189,  247,  237,  316,   95,   96,   97,   97,   98,
			   99,  100,  101,  102,  160,  160,  160,  160,  247,  259,
			  259,  259,  299,  160,  160,  160,  161,  160,  160,  160,
			  162,  160,  160,  160,  160,  163,  160,  164,  160,  160,
			  160,  160,  165,  166,  160,  160,  160,  160,  160,  160,
			  247,  262,  262,  262,  160,  167,  167,  167,  168,  167,
			  167,  167,  169,  167,  167,  167,  167,  170,  167,  171,
			  167,  167,  167,  167,  172,  173,  167,  167,  167,  167,
			  167,  167,  160,  160,  160,  160,  258,  258,  258,  258,
			  258,  258,  160,  160,  160,  160,  160,  160,  160,  160, yy_Dummy>>,
			1, 200, 200)
		end

	yy_nxt_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  174,  160,  160,  160,  160,  160,  160,  160,  160,  160,
			  160,  160,  160,  160,  160,  160,  160,  160,  105,  371,
			  103,  373,  160,  266,  167,  167,  167,  167,  167,  167,
			  167,  167,  175,  167,  167,  167,  167,  167,  167,  167,
			  167,  167,  167,  167,  167,  167,  167,  167,  167,  167,
			  196,  371,  202,  373,  197,  160,  216,  378,  160,  203,
			  204,  240,  160,  160,  248,  205,  217,  198,  218,  160,
			  228,  236,  219,  159,  160,  241,  149,  149,  149,  199,
			  229,  237,  199,  200,  206,  230,  200,  167,  220,  379,
			  167,  207,  208,  242,  167,  167,  201,  209,  221,  201,

			  222,  167,  231,  236,  223,  168,  167,  243,  193,  169,
			  194,  199,  232,  237,  170,  200,  171,  233,  212,  181,
			  195,  172,  173,  182,  213,  154,  183,  106,  201,  184,
			  105,  206,  185,  220,  362,  362,  379,  168,  207,  208,
			  193,  169,  194,  221,  209,  222,  170,  231,  171,  223,
			  212,  181,  195,  172,  173,  182,  213,  232,  183,  242,
			  104,  184,  233,  206,  185,  220,  365,  365,  379,  103,
			  207,  208, 1015,  243,  361,  221,  209,  222, 1015,  231,
			 1015,  223,  260,  260,  260,  260,  260,  260, 1015,  232,
			  276,  242,  277,  277,  233,  260,  260,  261,  260,  260, yy_Dummy>>,
			1, 200, 400)
		end

	yy_nxt_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  260,  277,  279,  280,  277,  243,  263,  263,  263,  263,
			  263,  263,  264,  264,  264,  264,  264,  265,  265,  265,
			  265,  265,  265,  268,  269,  270,  270,  271,  272,  273,
			  274,  275, 1015,  277,  278,  277,  282,  278,  381,  283,
			  367,  367,  267,  383,  385, 1015,  278,  268,  269,  270,
			  270,  271,  272,  273,  274,  275, 1015,  281,  292,  292,
			  292,  268,  269,  270,  270,  271,  272,  273,  274,  275,
			  381, 1015,  294,  294,  294,  383,  385,  278,  268,  269,
			  270,  270,  271,  272,  273,  274,  275, 1015,  281,  278,
			  372,  386, 1015,  387,  160,  160,  268,  269,  270,  270,

			  271,  272,  273,  274,  275,  293,  293,  293,  293,  293,
			  293,  268,  269,  270,  270,  271,  272,  273,  274,  275,
			  278,  108,  373,  387,  109,  387,  167,  167, 1015,  284,
			  285,  286,  286,  287,  288,  289,  290,  291,  295,  295,
			  295,  295,  295,  295,  268,  269,  270,  270,  271,  272,
			  273,  274,  275,  296,  296,  296,  296,  296,  268,  269,
			  270,  270,  271,  272,  273,  274,  275,  297,  297,  297,
			  297,  297,  297,  268,  269,  270,  270,  271,  272,  273,
			  274,  275,  298,  108,  362,  362,  109, 1015,  268,  269,
			  270,  270,  271,  272,  273,  274,  275,  364,  364,  364, yy_Dummy>>,
			1, 200, 600)
		end

	yy_nxt_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			 1015, 1015,  108, 1015,  147,  109,  360,  360,  360,  360,
			 1015,  121,  122,  123,  123,  124,  125,  126,  127,  128,
			  108, 1015,  160,  109,  565,  389,  354,  354,  354,  354,
			  108,  370,  110,  109, 1015,  374, 1015,  361,  375,  391,
			  355, 1015,  358,  358,  358,  358,  153, 1015, 1015, 1015,
			  108,  110, 1015,  109,  167, 1015,  359,  389, 1015,  393,
			 1015, 1015, 1015,  371,  110,  108,  356,  376,  109,  110,
			  377,  391,  355,  111,  112,  113,  113,  114,  115,  116,
			  117,  118,  300,  110,  300,  300, 1015,  108,  359, 1015,
			  109,  393,  111,  112,  113,  113,  114,  115,  116,  117,

			  118,  110, 1015,  108,  307, 1015,  109, 1015, 1015, 1015,
			  111,  112,  113,  113,  114,  115,  116,  117,  118,  316,
			  121,  122,  123,  123,  124,  125,  126,  127,  128, 1015,
			 1015,  316,  368,  368,  368,  368,  110,  308,  308,  308,
			  121,  122,  123,  123,  124,  125,  126,  127,  128,  310,
			  310,  310,  316, 1015, 1015,  121,  122,  123,  123,  124,
			  125,  126,  127,  128,  362,  362,  316, 1015,  110, 1015,
			  395,  160,  369,  516,  516,  516,  516,  111,  112,  113,
			  113,  114,  115,  116,  117,  118,  108,  314, 1015,  109,
			 1015, 1015, 1015,  121,  122,  123,  123,  124,  125,  126, yy_Dummy>>,
			1, 200, 800)
		end

	yy_nxt_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  127,  128,  395,  167,  565,  317,  318,  319,  319,  320,
			  321,  322,  323,  324,  347,  347,  347,  317,  318,  319,
			  319,  320,  321,  322,  323,  324,  316,  558,  558,  558,
			  558,  160,  349,  349,  349,  110,  390,  403,  317,  318,
			  319,  319,  320,  321,  322,  323,  324,  351,  351,  351,
			  351,  351,  317,  318,  319,  319,  320,  321,  322,  323,
			  324,  160,  376,  167,  388,  377,  392,  110,  391,  403,
			  160,  380,  160,  301,  301,  301,  111,  112,  113,  113,
			  114,  115,  116,  117,  118,  108, 1015, 1015,  109,  160,
			  160,  399,  406,  167,  376,  400,  389,  377,  393,  160,

			  382,  384,  167,  381,  167,  160,  353,  407,  394,  401,
			  413,  416,  317,  318,  319,  319,  320,  321,  322,  323,
			  324,  167,  167,  399,  406,  160,  410,  400,  414, 1015,
			  411,  167,  383,  385,  110,  402,  160,  167, 1015,  407,
			  395,  401,  413,  417,  258,  258,  258,  258,  258,  258,
			  557,  557,  557,  557,  160, 1015,  160,  167,  410,  412,
			  415,  408,  411, 1015,  415,  409,  110,  403,  167,  302,
			  302,  302,  302,  302,  302,  111,  112,  113,  113,  114,
			  115,  116,  117,  118,  108,  396,  167,  109,  167,  397,
			  404,  413,  160,  410,  417,  160,  415,  411,  160,  160, yy_Dummy>>,
			1, 200, 1000)
		end

	yy_nxt_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  160, 1015,  419,  398,  431,  405,  418,  160,  160,  430,
			  420,  434,  421,  437,  422,  160,  160,  399,  439,  436,
			 1015,  400,  406,  435,  167,  423,  417,  167,  424, 1015,
			  167,  167,  167,  110,  419,  401,  431,  407,  419,  167,
			  167,  431,  425,  434,  426,  437,  427,  167,  167, 1015,
			  439,  437,  432,  160, 1015,  435,  440,  428,  160, 1015,
			  429,  160,  441,  438,  433,  110,  442,  443,  303,  303,
			  303,  445,  160, 1015,  111,  112,  113,  113,  114,  115,
			  116,  117,  118,  108,  434,  167,  109,  425,  441,  426,
			  167,  427, 1015,  167,  441,  439,  435,  444,  443,  443,

			 1015,  160,  428,  445,  167,  429,  160,  160,  463,  458,
			  465,  462,  446,  459,  447,  160,  460,  160,  467,  425,
			  461,  426,  448,  427,  464,  449,  466,  450,  451,  445,
			  160, 1015,  110,  167,  428, 1015, 1015,  429,  167,  167,
			  463,  460,  465,  463,  452,  461,  453,  167,  460,  167,
			  467,  160,  461, 1015,  454, 1015,  465,  455,  467,  456,
			  457,  469,  167,  468,  110,  484,  478,  304,  304,  304,
			  304,  304,  304,  111,  112,  113,  113,  114,  115,  116,
			  117,  118,  108,  167,  477,  109,  479,  452,  480,  453,
			  481,  470,  160,  469,  483,  469,  471,  454,  479, 1015, yy_Dummy>>,
			1, 200, 1200)
		end

	yy_nxt_template_8 (an_array: ARRAY [INTEGER])
			-- Fill chunk #8 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  455,  473,  456,  457,  160,  160,  474,  472,  574,  576,
			  484, 1015, 1015,  476,  482,  485,  477,  475,  479,  452,
			  481,  453,  481,  473,  167, 1015,  483, 1015,  474,  454,
			  160,  110,  455,  473,  456,  457,  167,  167,  474,  475,
			  574,  576,  364,  364,  364,  477,  483, 1015, 1015,  475,
			 1015,  250,  251,  252,  252,  253,  254,  255,  256,  257,
			  485,  484,  167,  110, 1015, 1015, 1015,  305,  305,  305,
			  305,  305,  111,  112,  113,  113,  114,  115,  116,  117,
			  118,  108,  567, 1015,  109,  258,  258,  258,  258,  258,
			  258,  120,  698,  698,  698,  698,  250,  251,  252,  252,

			  253,  254,  255,  256,  257, 1015,  484,  706,  706,  706,
			  706,  485,  258,  258,  258,  258,  493,  494,  258,  258,
			  258,  258,  258,  258,  258,  258,  258,  258,  258,  258,
			  110,  484,  495,  495,  495,  495,  495,  495,  496,  496,
			  496,  496,  496,  496,  486,  486,  486,  250,  251,  252,
			  252,  253,  254,  255,  256,  257,  485,  578,  160,  579,
			 1015, 1015,  110, 1015, 1015,  306,  306,  306,  306,  306,
			  306,  111,  112,  113,  113,  114,  115,  116,  117,  118,
			  108,  485, 1015,  109,  580, 1015,  488,  488,  488,  578,
			  167,  580,  250,  251,  252,  252,  253,  254,  255,  256, yy_Dummy>>,
			1, 200, 1400)
		end

	yy_nxt_template_9 (an_array: ARRAY [INTEGER])
			-- Fill chunk #9 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  257,  497,  497,  497,  497,  497,  497,  556, 1015,  556,
			 1015,  492,  557,  557,  557,  557,  580,  250,  251,  252,
			  252,  253,  254,  255,  256,  257,  268,  269,  270,  270,
			  271,  272,  273,  274,  275,  268,  269,  270,  270,  271,
			  272,  273,  274,  275,  292,  292,  292,  268,  269,  270,
			  270,  271,  272,  273,  274,  275,  258,  258,  258,  258,
			  258,  258, 1015, 1015,  309,  309,  309,  309,  309,  309,
			  121,  122,  123,  123,  124,  125,  126,  127,  128,  108,
			 1015, 1015,  109,  293,  293,  293,  293,  293,  293,  268,
			  269,  270,  270,  271,  272,  273,  274,  275,  294,  294,

			  294, 1015, 1015, 1015,  268,  269,  270,  270,  271,  272,
			  273,  274,  275,  295,  295,  295,  295,  295,  295,  268,
			  269,  270,  270,  271,  272,  273,  274,  275,  296,  296,
			  296,  296,  296,  268,  269,  270,  270,  271,  272,  273,
			  274,  275,  297,  297,  297,  297,  297,  297,  268,  269,
			  270,  270,  271,  272,  273,  274,  275,  276, 1015,  277,
			  277,  283, 1015,  311,  311,  311,  311,  311,  311,  121,
			  122,  123,  123,  124,  125,  126,  127,  128,  108,  298,
			  160,  109, 1015, 1015,  586,  268,  269,  270,  270,  271,
			  272,  273,  274,  275,  277, 1015,  277,  277,  583,  704, yy_Dummy>>,
			1, 200, 1600)
		end

	yy_nxt_template_10 (an_array: ARRAY [INTEGER])
			-- Fill chunk #10 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  704,  704,  704,  562,  277,  562,  280,  277,  563,  563,
			  563,  563,  167,  278,  278,  584,  586,  278, 1015,  283,
			 1015, 1015,  267, 1015,  278, 1015, 1015,  278, 1015,  283,
			  583,  277,  267,  277,  282,  710,  710,  710,  710,  705,
			  278, 1015, 1015,  278,  278,  283,  588,  584,  267, 1015,
			  278,  498,  499,  500,  500,  501,  502,  503,  504,  505,
			  281, 1015, 1015,  312,  312,  312,  312,  312,  121,  122,
			  123,  123,  124,  125,  126,  127,  128,  108,  588, 1015,
			  109,  278,  563,  563,  563,  563, 1015,  278, 1015, 1015,
			  147,  281,  564,  564,  564,  564,  590, 1015,  592,  268,

			  269,  270,  270,  271,  272,  273,  274,  275, 1015,  284,
			  285,  286,  286,  287,  288,  289,  290,  291,  278,  284,
			  285,  286,  286,  287,  288,  289,  290,  291,  590,  512,
			  592, 1015,  153, 1015, 1015,  284,  285,  286,  286,  287,
			  288,  289,  290,  291,  268,  269,  270,  270,  271,  272,
			  273,  274,  275,  594, 1015,  160,  571,  571,  571,  571,
			  575,  313,  313,  313,  313,  313,  313,  121,  122,  123,
			  123,  124,  125,  126,  127,  128,  325,  596, 1015,  326,
			  327,  328,  329, 1015, 1015,  594, 1015,  167,  330, 1015,
			 1015, 1015,  576, 1015, 1015,  331,  369,  332, 1015,  333, yy_Dummy>>,
			1, 200, 1800)
		end

	yy_nxt_template_11 (an_array: ARRAY [INTEGER])
			-- Fill chunk #11 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  334,  335,  336, 1015,  337, 1015,  338, 1015, 1015,  596,
			  339, 1015,  340, 1015, 1015,  341,  342,  343,  344,  345,
			  346,  268,  269,  270,  270,  271,  272,  273,  274,  275,
			  268,  269,  270,  270,  271,  272,  273,  274,  275,  268,
			  269,  270,  270,  271,  272,  273,  274,  275,  513,  513,
			  513,  513,  513,  513,  268,  269,  270,  270,  271,  272,
			  273,  274,  275, 1015, 1015, 1015,  317,  318,  319,  319,
			  320,  321,  322,  323,  324,  316,  514,  514,  514,  514,
			  514,  514,  268,  269,  270,  270,  271,  272,  273,  274,
			  275,  515,  515,  515,  515,  515,  515,  268,  269,  270,

			  270,  271,  272,  273,  274,  275,  555,  555,  555,  555,
			 1015, 1015, 1015,  160,  572,  572,  572,  572, 1015,  573,
			  355, 1015,  108, 1015, 1015,  109,  258,  258,  258,  258,
			  258,  258, 1015,  559,  559,  559,  559, 1015, 1015, 1015,
			  108, 1015,  585,  109, 1015,  167,  356,  560,  160,  598,
			  108,  574,  355,  109,  369,  129,  129,  129,  129,  129,
			  129,  317,  318,  319,  319,  320,  321,  322,  323,  324,
			  316,  110,  597,  561,  586,  600,  160,  602,  160,  560,
			  167,  598,  258,  258,  258,  258,  258,  258, 1015,  110,
			  108, 1015,  601,  109, 1015,  604,  160,  610, 1015,  108, yy_Dummy>>,
			1, 200, 2000)
		end

	yy_nxt_template_12 (an_array: ARRAY [INTEGER])
			-- Fill chunk #12 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			 1015, 1015,  109,  110,  598, 1015, 1015,  600,  167,  602,
			  167, 1015,  111,  112,  113,  113,  114,  115,  116,  117,
			  118,  110, 1015,  108,  602, 1015,  109,  604,  167,  610,
			  111,  112,  113,  113,  114,  115,  116,  117,  118,  110,
			  121,  122,  123,  123,  124,  125,  126,  127,  128, 1015,
			  348,  348,  348,  348,  348,  348,  317,  318,  319,  319,
			  320,  321,  322,  323,  324,  316, 1015,  577,  160, 1015,
			  609,  110,  110,  108,  160,  160,  109,  612,  587, 1015,
			  111,  112,  113,  113,  114,  115,  116,  117,  118,  121,
			  122,  123,  123,  124,  125,  126,  127,  128,  108,  578,

			  167,  109,  610, 1015,  110, 1015,  167,  167, 1015,  612,
			  588, 1015, 1015,  111,  112,  113,  113,  114,  115,  116,
			  117,  118, 1015, 1015, 1015, 1015,  708, 1015,  708,  614,
			  620,  709,  709,  709,  709,  317,  318,  319,  319,  320,
			  321,  322,  323,  324, 1015,  350,  350,  350,  350,  350,
			  350,  317,  318,  319,  319,  320,  321,  322,  323,  324,
			  316,  614,  620,  121,  122,  123,  123,  124,  125,  126,
			  127,  128,  268,  269,  270,  270,  271,  272,  273,  274,
			  275,  711,  711,  711,  711,  530,  623,  622,  121,  122,
			  123,  123,  124,  125,  126,  127,  128,  317,  318,  319, yy_Dummy>>,
			1, 200, 2200)
		end

	yy_nxt_template_13 (an_array: ARRAY [INTEGER])
			-- Fill chunk #13 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  319,  320,  321,  322,  323,  324,  523,  523,  523,  317,
			  318,  319,  319,  320,  321,  322,  323,  324,  624,  622,
			 1015,  712, 1015, 1015,  525,  525,  525, 1015, 1015,  624,
			  317,  318,  319,  319,  320,  321,  322,  323,  324, 1015,
			  352,  352,  352,  352,  352,  352,  317,  318,  319,  319,
			  320,  321,  322,  323,  324,  366,  366,  366,  366,  160,
			  621,  624,  619, 1015,  160,  366,  366,  366,  366,  366,
			  366,  317,  318,  319,  319,  320,  321,  322,  323,  324,
			  531,  713, 1015,  564,  564,  564,  564, 1015,  626,  628,
			  630,  167,  622, 1015,  620,  361,  167,  366,  366,  366,

			  366,  366,  366,  484,  527,  527,  527,  527,  527,  317,
			  318,  319,  319,  320,  321,  322,  323,  324,  533,  529,
			  626,  628,  630,  369, 1015,  317,  318,  319,  319,  320,
			  321,  322,  323,  324,  534,  268,  269,  270,  270,  271,
			  272,  273,  274,  275,  625, 1015,  631,  632,  160,  634,
			  160, 1015, 1015,  485,  535,  535,  535,  535, 1015,  364,
			  364,  364, 1015,  536, 1015, 1015,  317,  318,  319,  319,
			  320,  321,  322,  323,  324,  537,  626, 1015,  632,  632,
			  167,  634,  167,  487,  487,  487,  487,  487,  487,  250,
			  251,  252,  252,  253,  254,  255,  256,  257,  484,  567, yy_Dummy>>,
			1, 200, 2400)
		end

	yy_nxt_template_14 (an_array: ARRAY [INTEGER])
			-- Fill chunk #14 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  814,  814,  814,  814,  317,  318,  319,  319,  320,  321,
			  322,  323,  324,  538,  636,  638,  815,  815,  815,  815,
			  317,  318,  319,  319,  320,  321,  322,  323,  324,  539,
			 1015,  317,  318,  319,  319,  320,  321,  322,  323,  324,
			  540,  637,  640,  160,  642,  160,  636,  638,  485,  317,
			  318,  319,  319,  320,  321,  322,  323,  324,  541, 1015,
			 1015,  317,  318,  319,  319,  320,  321,  322,  323,  324,
			  542, 1015, 1015,  638,  640,  167,  642,  167,  489,  489,
			  489,  489,  489,  489,  250,  251,  252,  252,  253,  254,
			  255,  256,  257,  484,  120,  810,  810,  810,  810,  317,

			  318,  319,  319,  320,  321,  322,  323,  324,  543, 1015,
			  648,  709,  709,  709,  709,  317,  318,  319,  319,  320,
			  321,  322,  323,  324,  544, 1015,  317,  318,  319,  319,
			  320,  321,  322,  323,  324,  545,  641,  650,  645,  652,
			  160,  646,  648,  485,  317,  318,  319,  319,  320,  321,
			  322,  323,  324,  546, 1015, 1015,  317,  318,  319,  319,
			  320,  321,  322,  323,  324,  547, 1015, 1015,  642,  650,
			  645,  652,  167,  646,  490,  490,  490,  490,  490,  250,
			  251,  252,  252,  253,  254,  255,  256,  257,  484,  819,
			  819,  819,  819, 1015,  317,  318,  319,  319,  320,  321, yy_Dummy>>,
			1, 200, 2600)
		end

	yy_nxt_template_15 (an_array: ARRAY [INTEGER])
			-- Fill chunk #15 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  322,  323,  324, 1015,  654,  660,  548, 1015, 1015, 1015,
			  317,  318,  319,  319,  320,  321,  322,  323,  324,  549,
			 1015,  317,  318,  319,  319,  320,  321,  322,  323,  324,
			  550,  647,  662,  664,  666,  160,  654,  660,  485,  317,
			  318,  319,  319,  320,  321,  322,  323,  324,  551, 1015,
			 1015,  317,  318,  319,  319,  320,  321,  322,  323,  324,
			 1015, 1015, 1015,  648,  662,  664,  666,  167,  491,  491,
			  491,  491,  491,  491,  250,  251,  252,  252,  253,  254,
			  255,  256,  257,  278, 1015, 1015,  278, 1015,  283, 1015,
			 1015,  267,  317,  318,  319,  319,  320,  321,  322,  323,

			  324,  160, 1015, 1015, 1015,  317,  318,  319,  319,  320,
			  321,  322,  323,  324,  589,  160,  317,  318,  319,  319,
			  320,  321,  322,  323,  324, 1015,  613, 1015,  667, 1015,
			 1015,  668, 1015,  167,  317,  318,  319,  319,  320,  321,
			  322,  323,  324, 1015, 1015, 1015,  590,  167,  821,  821,
			  821,  821,  898,  898,  898,  898,  581,  591,  614,  160,
			  668,  599,  160,  668,  160,  160, 1015, 1015,  593,  160,
			 1015,  670, 1015,  582,  595,  506,  506,  506,  284,  285,
			  286,  286,  287,  288,  289,  290,  291,  278,  583,  592,
			  278,  167,  283,  600,  167,  267,  167,  167,  160,  605, yy_Dummy>>,
			1, 200, 2800)
		end

	yy_nxt_template_16 (an_array: ARRAY [INTEGER])
			-- Fill chunk #16 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  594,  167,  607,  670,  160,  584,  596,  160,  160,  617,
			  603,  160,  615,  606,  611,  629,  608,  160,  627,  633,
			  160,  672,  618,  160,  635,  616,  639,  160, 1015,  643,
			  167,  607,  644,  649,  607,  160,  167,  160,  677,  167,
			  167,  617,  604,  167,  617,  608,  612,  630,  608,  167,
			  628,  634,  167,  672,  618,  167,  636,  618,  640,  167,
			  651,  645, 1015,  160,  646,  650, 1015,  167,  160,  167,
			  678,  902,  902,  902,  902,  653,  507,  507,  507,  507,
			  507,  507,  284,  285,  286,  286,  287,  288,  289,  290,
			  291,  278,  652,  160,  278,  167,  283,  655,  657,  267,

			  167,  661,  659,  160,  663,  160,  665,  654,  160,  674,
			  160,  160,  160,  669,  671,  656,  658,  673,  160,  675,
			  676,  160,  678,  679,  680,  167,  681,  682,  684,  657,
			  657,  160, 1015,  662,  660,  167,  664,  167,  666,  160,
			  167,  674,  167,  167,  167,  670,  672,  658,  658,  674,
			  167,  676,  676,  167,  678,  680,  680,  484,  682,  682,
			  684, 1015, 1015,  167,  160,  716,  484,  160, 1015,  683,
			  718,  167,  160,  720,  721,  484,  160,  715,  722,  723,
			  508,  508,  508,  717,  484,  160,  284,  285,  286,  286,
			  287,  288,  289,  290,  291,  278,  167,  716,  278,  167, yy_Dummy>>,
			1, 200, 3000)
		end

	yy_nxt_template_17 (an_array: ARRAY [INTEGER])
			-- Fill chunk #17 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  283,  684,  718,  267,  167,  720,  722,  485,  167,  716,
			  722,  724, 1015, 1015, 1015,  718,  485,  167,  283, 1015,
			 1015,  896, 1015,  896, 1015,  485,  897,  897,  897,  897,
			  283, 1015, 1015, 1015,  485,  903,  903,  903,  903,  905,
			  905,  905,  905,  250,  251,  252,  252,  253,  254,  255,
			  256,  257,  250,  251,  252,  252,  253,  254,  255,  256,
			  257,  250,  251,  252,  252,  253,  254,  255,  256,  257,
			  250,  251,  252,  252,  253,  254,  255,  256,  257,  283,
			  897,  897,  897,  897,  509,  509,  509,  509,  509,  509,
			  284,  285,  286,  286,  287,  288,  289,  290,  291,  278,

			 1015, 1015,  278, 1015,  283, 1015, 1015,  267,  498,  499,
			  500,  500,  501,  502,  503,  504,  505,  688,  688,  688,
			  498,  499,  500,  500,  501,  502,  503,  504,  505,  283,
			  268,  269,  270,  270,  271,  272,  273,  274,  275,  897,
			  897,  897,  897, 1015,  283, 1015, 1015,  725,  278, 1015,
			  724,  278,  726,  283, 1015,  728,  267,  956,  956,  956,
			  956, 1015, 1015,  690,  690,  690, 1015, 1015, 1015,  498,
			  499,  500,  500,  501,  502,  503,  504,  505,  278,  726,
			  730,  278,  724,  283,  726, 1015,  267,  728, 1015,  510,
			  510,  510,  510,  510,  284,  285,  286,  286,  287,  288, yy_Dummy>>,
			1, 200, 3200)
		end

	yy_nxt_template_18 (an_array: ARRAY [INTEGER])
			-- Fill chunk #18 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  289,  290,  291,  278, 1015, 1015,  278, 1015,  283, 1015,
			 1015,  267,  730, 1015,  692,  692,  692,  692,  692,  498,
			  499,  500,  500,  501,  502,  503,  504,  505,  694,  108,
			  732,  160,  109,  727,  498,  499,  500,  500,  501,  502,
			  503,  504,  505,  284,  285,  286,  286,  287,  288,  289,
			  290,  291,  278, 1015,  734,  278,  736,  283, 1015,  738,
			  267, 1015,  732,  167, 1015,  728, 1015, 1015,  714,  714,
			  714,  714, 1015,  284,  285,  286,  286,  287,  288,  289,
			  290,  291,  278, 1015,  740,  278,  734,  283,  736, 1015,
			  267,  738,  511,  511,  511,  511,  511,  511,  284,  285,

			  286,  286,  287,  288,  289,  290,  291,  300,  369,  300,
			  300, 1015,  108,  742,  743,  109,  740, 1015, 1015,  121,
			  122,  123,  123,  124,  125,  126,  127,  128,  160,  703,
			  703,  703,  703,  737,  160,  160,  744,  108,  719, 1015,
			  109,  746, 1015,  355,  729,  742,  744,  284,  285,  286,
			  286,  287,  288,  289,  290,  291,  748, 1015,  731,  160,
			  167,  110,  160, 1015,  747,  738,  167,  167,  744,  356,
			  720,  108, 1015,  746,  109,  355,  730,  284,  285,  286,
			  286,  287,  288,  289,  290,  291,  110, 1015,  748,  108,
			  732,  167,  109,  110,  167, 1015,  748,  572,  572,  572, yy_Dummy>>,
			1, 200, 3400)
		end

	yy_nxt_template_19 (an_array: ARRAY [INTEGER])
			-- Fill chunk #19 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  572, 1015,  111,  112,  113,  113,  114,  115,  116,  117,
			  118,  108,  160, 1015,  109,  735, 1015,  750,  110,  160,
			  110,  752,  754,  733,  756,  160, 1015,  111,  112,  113,
			  113,  114,  115,  116,  117,  118,  108,  369,  110,  109,
			  758,  759, 1015, 1015,  167,  108, 1015,  736,  109,  750,
			 1015,  167,  110,  752,  754,  734,  756,  167, 1015,  760,
			  110,  111,  112,  113,  113,  114,  115,  116,  117,  118,
			  110, 1015,  758,  760, 1015,  707,  707,  707,  707,  111,
			  112,  113,  113,  114,  115,  116,  117,  118, 1015,  560,
			  762,  760,  110,  764, 1015,  517,  517,  517,  517,  517,

			  517,  111,  112,  113,  113,  114,  115,  116,  117,  118,
			  108, 1015, 1015,  109, 1015,  561, 1015,  813,  813,  813,
			  813,  560,  762,  766,  768,  764,  121,  122,  123,  123,
			  124,  125,  126,  127,  128,  121,  122,  123,  123,  124,
			  125,  126,  127,  128,  317,  318,  319,  319,  320,  321,
			  322,  323,  324, 1015,  770,  766,  768,  705, 1015,  110,
			  317,  318,  319,  319,  320,  321,  322,  323,  324, 1015,
			  817,  817,  817,  817,  317,  318,  319,  319,  320,  321,
			  322,  323,  324,  160,  741,  753,  770, 1015, 1015,  160,
			  160,  110,  739,  160,  518,  518,  518,  518,  518,  518, yy_Dummy>>,
			1, 200, 3600)
		end

	yy_nxt_template_20 (an_array: ARRAY [INTEGER])
			-- Fill chunk #20 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  111,  112,  113,  113,  114,  115,  116,  117,  118,  108,
			  818, 1015,  109, 1015, 1015,  167,  742,  754,  160,  160,
			  160,  167,  167,  160,  740,  167, 1015,  745,  749,  751,
			  772,  160,  765,  160,  702,  535,  535,  535,  535,  317,
			  318,  319,  319,  320,  321,  322,  323,  324,  761,  757,
			  167,  167,  167,  160,  160,  167,  774, 1015,  110,  746,
			  750,  752,  772,  167,  766,  167,  906, 1015,  906, 1015,
			 1015,  904,  904,  904,  904, 1015, 1015,  160, 1015, 1015,
			  762,  758, 1015, 1015, 1015,  167,  167, 1015,  774,  755,
			  110, 1015, 1015,  519,  519,  519,  519,  519,  519,  111,

			  112,  113,  113,  114,  115,  116,  117,  118,  108,  167,
			  160,  109,  317,  318,  319,  319,  320,  321,  322,  323,
			  324,  756,  767,  160,  160,  763,  160,  771,  160,  160,
			  777,  773,  769,  160,  776,  778,  779,  780,  160,  160,
			  782,  784,  167,  785,  160,  775,  786,  781,  783,  160,
			  788,  790,  789,  792,  768,  167,  167,  764,  167,  772,
			  167,  167,  778,  774,  770,  167,  776,  778,  780,  780,
			  167,  167,  782,  784, 1015,  786,  167,  776,  786,  782,
			  784,  167,  788,  790,  790,  792,  794,  796, 1015, 1015,
			  160, 1015,  520,  520,  520,  520,  520,  520,  121,  122, yy_Dummy>>,
			1, 200, 3800)
		end

	yy_nxt_template_21 (an_array: ARRAY [INTEGER])
			-- Fill chunk #21 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  123,  123,  124,  125,  126,  127,  128,  108,  160,  160,
			  109,  793,  160,  798,  160,  160,  160,  160,  794,  796,
			  787,  795,  167,  797,  799,  791,  800,  160,  802,  160,
			  160,  804,  803,  806,  160,  160,  484,  825, 1015, 1015,
			  167,  167,  801,  794,  167,  798,  167,  167,  167,  167,
			  283, 1015,  788,  796, 1015,  798,  800,  792,  800,  167,
			  802,  167,  167,  804,  804,  806,  167,  167,  484,  825,
			  820,  820,  820,  820,  802,  805,  160, 1015, 1015,  160,
			  160,  484,  827,  160, 1015,  829,  485,  283, 1015,  824,
			 1015,  521,  521,  521,  521,  521,  521,  121,  122,  123,

			  123,  124,  125,  126,  127,  128,  108,  806,  167,  109,
			  712,  167,  167, 1015,  827,  167,  283,  829,  485,  828,
			  160,  825,  250,  251,  252,  252,  253,  254,  255,  256,
			  257,  485,  283,  831,  160,  961,  961,  961,  961, 1015,
			  498,  499,  500,  500,  501,  502,  503,  504,  505, 1015,
			 1015,  829,  167, 1015,  250,  251,  252,  252,  253,  254,
			  255,  256,  257, 1015, 1015,  831,  167,  250,  251,  252,
			  252,  253,  254,  255,  256,  257, 1015,  498,  499,  500,
			  500,  501,  502,  503,  504,  505, 1015, 1015, 1015, 1015,
			  522,  522,  522,  522,  522,  522,  121,  122,  123,  123, yy_Dummy>>,
			1, 200, 4000)
		end

	yy_nxt_template_22 (an_array: ARRAY [INTEGER])
			-- Fill chunk #22 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  124,  125,  126,  127,  128, 1015,  498,  499,  500,  500,
			  501,  502,  503,  504,  505, 1015,  823, 1015,  572,  572,
			  572,  572,  498,  499,  500,  500,  501,  502,  503,  504,
			  505,  278, 1015, 1015,  278, 1015,  283, 1015, 1015,  267,
			  278, 1015, 1015,  278, 1015,  283, 1015, 1015,  267,  278,
			  160,  833,  278, 1015,  283, 1015, 1015,  267,  153, 1015,
			 1015, 1015,  317,  318,  319,  319,  320,  321,  322,  323,
			  324,  811,  317,  318,  319,  319,  320,  321,  322,  323,
			  324, 1015,  167,  833,  839,  524,  524,  524,  524,  524,
			  524,  317,  318,  319,  319,  320,  321,  322,  323,  324,

			 1015,  317,  318,  319,  319,  320,  321,  322,  323,  324,
			  703,  703,  703,  703, 1015, 1015,  839,  904,  904,  904,
			  904,  160,  841,  843,  812, 1015,  284,  285,  286,  286,
			  287,  288,  289,  290,  291,  284,  285,  286,  286,  287,
			  288,  289,  290,  291,  284,  285,  286,  286,  287,  288,
			  289,  290,  291,  167,  841,  843,  812,  317,  318,  319,
			  319,  320,  321,  322,  323,  324,  963,  963,  963,  963,
			 1015, 1015,  160, 1015, 1015,  834,  845,  826, 1015,  835,
			  526,  526,  526,  526,  526,  526,  317,  318,  319,  319,
			  320,  321,  322,  323,  324, 1015,  816,  816,  816,  816, yy_Dummy>>,
			1, 200, 4200)
		end

	yy_nxt_template_23 (an_array: ARRAY [INTEGER])
			-- Fill chunk #23 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  816,  816,  816,  816,  167,  830,  160,  836,  845,  827,
			  560,  837,  160,  836,  822,  832,  160,  837,  160,  842,
			  160,  838,  844,  847,  846,  160,  848,  840,  160,  849,
			  160,  160,  851,  853,  160,  160,  561,  831,  167,  852,
			  855,  850,  560, 1015,  167,  836,  822,  833,  167,  837,
			  167,  843,  167,  839,  845,  847,  847,  167,  849,  841,
			  167,  849,  167,  167,  851,  853,  167,  167, 1015,  160,
			  857,  853,  855,  851,  856,  528,  528,  528,  528,  528,
			  528,  317,  318,  319,  319,  320,  321,  322,  323,  324,
			 1015,  160,  858,  859,  860,  861,  160,  160,  862,  863,

			  854,  167,  857,  864,  865,  866,  857,  867,  160,  160,
			  868,  869,  160,  871,  160,  873,  874,  875,  160,  877,
			  879,  870, 1015,  167,  859,  859,  861,  861,  167,  167,
			  863,  863,  855,  872, 1015,  865,  865,  867, 1015,  867,
			  167,  167,  869,  869,  167,  871,  167,  873,  875,  875,
			  167,  877,  879,  871,  876,  878,  881,  160,  160,  160,
			  882,  883,  283,  885,  160,  873,  880,  160,  887, 1015,
			  129,  129,  129,  129,  129,  129,  317,  318,  319,  319,
			  320,  321,  322,  323,  324, 1015,  877,  879,  881,  167,
			  167,  167,  883,  883,  160,  885,  167,  160,  881,  167, yy_Dummy>>,
			1, 200, 4400)
		end

	yy_nxt_template_24 (an_array: ARRAY [INTEGER])
			-- Fill chunk #24 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  887,  888,  889,  160,  890,  884,  891,  892,  886,  160,
			  893,  160,  160,  160,  895,  283,  160,  160,  894,  911,
			  904,  904,  904,  904,  283, 1015,  167, 1015, 1015,  167,
			 1015, 1015, 1015,  889,  889,  167,  891,  885,  891,  893,
			  887,  167,  893,  167,  167,  167,  895, 1015,  167,  167,
			  895,  911,  498,  499,  500,  500,  501,  502,  503,  504,
			  505,  897,  897,  897,  897,  129,  129,  129,  129,  129,
			  129,  317,  318,  319,  319,  320,  321,  322,  323,  324,
			 1015,  816,  816,  816,  816,  901,  901,  901,  901, 1015,
			  904,  904,  904,  904,  913,  900,  915,  899, 1015, 1015,

			 1015,  705, 1015,  160,  917,  498,  499,  500,  500,  501,
			  502,  503,  504,  505,  498,  499,  500,  500,  501,  502,
			  503,  504,  505,  356,  919,  818,  913,  900,  915,  899,
			  712,  908,  908,  908,  908,  167,  917,  958,  958,  958,
			  958, 1015, 1015, 1015,  910,  909,  160,  160,  160, 1015,
			 1015,  920,  921,  916, 1015,  160,  919,  923,  912,  160,
			  129,  129,  129,  129,  129,  129,  317,  318,  319,  319,
			  320,  321,  322,  323,  324, 1015,  911,  909,  167,  167,
			  167,  160,  160,  921,  921,  917,  922,  167,  160,  923,
			  913,  167,  914,  918,  160,  924,  925,  160,  926,  160, yy_Dummy>>,
			1, 200, 4600)
		end

	yy_nxt_template_25 (an_array: ARRAY [INTEGER])
			-- Fill chunk #25 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  927,  928,  929,  160,  931,  160,  160,  160,  933,  935,
			  160,  160,  937,  167,  167,  932,  939,  930,  923,  941,
			  167, 1015,  934, 1015,  915,  919,  167,  925,  925,  167,
			  927,  167,  927,  929,  929,  167,  931,  167,  167,  167,
			  933,  935,  167,  167,  937,  938,  943,  933,  939,  931,
			 1015,  941, 1015,  160,  935,  129,  129,  129,  129,  129,
			  129,  317,  318,  319,  319,  320,  321,  322,  323,  324,
			 1015,  160,  160,  160,  160,  160,  945,  939,  943,  947,
			  944,  160,  936,  940,  942,  167,  946,  160,  948,  949,
			  160,  160,  160,  160,  951,  160,  953,  160,  160,  160,

			  952,  955,  968,  167,  167,  167,  167,  167,  945,  950,
			  954,  947,  945,  167,  937,  941,  943,  970,  947,  167,
			  949,  949,  167,  167,  167,  167,  951,  167,  953,  167,
			  167,  167,  953,  955,  968, 1015, 1015,  160,  957, 1015,
			  957,  951,  955,  958,  958,  958,  958,  972, 1015,  970,
			  552,  552,  552,  552,  552,  552,  317,  318,  319,  319,
			  320,  321,  322,  323,  324, 1015,  959,  962,  959,  167,
			 1015,  960,  960,  960,  960,  960,  960,  960,  960,  972,
			  964,  964,  964,  964,  965,  160,  965,  160, 1015,  966,
			  966,  966,  966,  561,  962,  967,  969,  160,  973,  962, yy_Dummy>>,
			1, 200, 4800)
		end

	yy_nxt_template_26 (an_array: ARRAY [INTEGER])
			-- Fill chunk #26 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  160,  974,  971,  160,  975,  976,  978,  977,  980,  160,
			  160,  160,  160, 1015, 1015,  818, 1015,  167, 1015,  167,
			  561,  960,  960,  960,  960, 1015,  962,  968,  970,  167,
			  974, 1015,  167,  974,  972,  167,  976,  976,  978,  978,
			  980,  167,  167,  167,  167,  553,  553,  553,  553,  553,
			  553,  317,  318,  319,  319,  320,  321,  322,  323,  324,
			 1015,  160,  982,  981,  979,  160,  160,  160,  160,  984,
			  985,  986,  160,  983,  160,  988,  989,  990,  987,  991,
			  160,  992,  160,  993,  994,  160,  995,  160,  996,  160,
			  160, 1015, 1015,  167,  982,  982,  980,  167,  167,  167,

			  167,  984,  986,  986,  167,  984,  167,  988,  990,  990,
			  988,  992,  167,  992,  167,  994,  994,  167,  996,  167,
			  996,  167,  167,  997,  997,  997,  997,  960,  960,  960,
			  960,  998,  998,  998,  998,  966,  966,  966,  966, 1015,
			  554,  554,  554,  554,  554,  554,  317,  318,  319,  319,
			  320,  321,  322,  323,  324,  366,  366,  366,  366,  160,
			 1002, 1003, 1015,  705,  160,  366,  366,  366,  366,  366,
			  366,  999,  160,  999,  160, 1005, 1000, 1000, 1000, 1000,
			  903,  903,  903,  903, 1001, 1001, 1001, 1001, 1015,  160,
			  160,  167, 1003, 1003,  962,  569,  167,  366,  366,  366, yy_Dummy>>,
			1, 200, 5000)
		end

	yy_nxt_template_27 (an_array: ARRAY [INTEGER])
			-- Fill chunk #27 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  366,  366,  366,  484,  167,  160,  167, 1005, 1004,  160,
			 1007,  160,  160, 1009,  160, 1010,  160, 1011,  160,  160,
			  561,  167,  167, 1006,  712, 1008,  962,  160,  956,  956,
			  956,  956, 1000, 1000, 1000, 1000, 1015,  167,  160, 1014,
			 1005,  167, 1007,  167,  167, 1009,  167, 1011,  167, 1011,
			  167,  167, 1015,  485, 1015, 1007, 1015, 1009, 1015,  167,
			 1012, 1012, 1012, 1012,  963,  963,  963,  963,  705, 1013,
			  167, 1014, 1015,  160,  160,  160,  160,  998,  998,  998,
			  998,  160, 1015,  685,  685,  685,  685,  685,  685,  250,
			  251,  252,  252,  253,  254,  255,  256,  257,  484, 1015,

			  818, 1014, 1015, 1015,  712,  167,  167,  167,  167,  120,
			  120,  120,  120,  167, 1015,  120, 1015,  818,   88,   88,
			   88,   88,   88,   88,   88,   88,   88,   88,   88,   88,
			  107,  107, 1015,  107,  107,  107,  107,  107,  107,  107,
			  107,  107, 1015,  119, 1015, 1015, 1015, 1015,  485,  119,
			  119,  119,  119,  119,  119,  120,  120, 1015,  120,  120,
			  120,  120,  120,  120,  120,  120,  120,  249,  249, 1015,
			  249,  249, 1015, 1015,  249,  249,  249,  249,  686,  686,
			  686,  686,  686,  686,  250,  251,  252,  252,  253,  254,
			  255,  256,  257,  484,  129,  129, 1015,  129,  129,  129, yy_Dummy>>,
			1, 200, 5200)
		end

	yy_nxt_template_28 (an_array: ARRAY [INTEGER])
			-- Fill chunk #28 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			 1015,  129,  129,  129,  129,  129,  267, 1015, 1015,  267,
			 1015,  267,  267,  267,  267,  267,  267,  267,  281,  281,
			 1015,  281,  281,  281,  281,  281,  281,  281,  281,  281,
			  315, 1015, 1015, 1015,  315,  315,  315,  315,  315,  315,
			  315,  315, 1015,  485,  357,  357,  357,  357,  357,  357,
			  357,  357, 1015,  357,  357,  357,  278,  278, 1015,  278,
			  278, 1015,  278,  278,  278,  278,  278,  278, 1015, 1015,
			 1015, 1015, 1015,  687,  687,  687,  687,  687,  687,  250,
			  251,  252,  252,  253,  254,  255,  256,  257,  283,  907,
			  907,  907,  907,  907,  907,  907,  907, 1015,  907,  907,

			  907, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015,  689,  689,  689,  689,  689,  689,  498,  499,
			  500,  500,  501,  502,  503,  504,  505,  283, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, yy_Dummy>>,
			1, 200, 5400)
		end

	yy_nxt_template_29 (an_array: ARRAY [INTEGER])
			-- Fill chunk #29 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015,  691,  691,  691,  691,  691,  691,  498,  499,  500,
			  500,  501,  502,  503,  504,  505,  283, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,

			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			  693,  693,  693,  693,  693,  693,  498,  499,  500,  500,
			  501,  502,  503,  504,  505,  278, 1015, 1015,  278, 1015,
			  283, 1015, 1015,  267, 1015, 1015, 1015, 1015, 1015, 1015, yy_Dummy>>,
			1, 200, 5600)
		end

	yy_nxt_template_30 (an_array: ARRAY [INTEGER])
			-- Fill chunk #30 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015,  695,  695,  695,  695,  695,  695,
			  284,  285,  286,  286,  287,  288,  289,  290,  291,  278,
			 1015, 1015,  278, 1015,  283, 1015, 1015,  267, 1015, 1015,

			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,  696,  696,
			  696,  696,  696,  696,  284,  285,  286,  286,  287,  288,
			  289,  290,  291,  278, 1015, 1015,  278, 1015,  283, 1015, yy_Dummy>>,
			1, 200, 5800)
		end

	yy_nxt_template_31 (an_array: ARRAY [INTEGER])
			-- Fill chunk #31 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			 1015,  267, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015,  697,  697,  697,  697,  697,  697,  284,  285,
			  286,  286,  287,  288,  289,  290,  291, 1015, 1015, 1015,

			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015,  699,  699,  699,
			  699,  699,  699,  317,  318,  319,  319,  320,  321,  322,
			  323,  324, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, yy_Dummy>>,
			1, 200, 6000)
		end

	yy_nxt_template_32 (an_array: ARRAY [INTEGER])
			-- Fill chunk #32 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015,  700,  700,  700,  700,  700,  700,  317,  318,
			  319,  319,  320,  321,  322,  323,  324, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,

			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015,  701,  701,  701,
			  701,  701,  701,  317,  318,  319,  319,  320,  321,  322,
			  323,  324, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, yy_Dummy>>,
			1, 200, 6200)
		end

	yy_nxt_template_33 (an_array: ARRAY [INTEGER])
			-- Fill chunk #33 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015,  129,  129,  129,  129,  129,  129,  317,  318,
			  319,  319,  320,  321,  322,  323,  324, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,

			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015,  129,  129,  129,
			  129,  129,  129,  317,  318,  319,  319,  320,  321,  322,
			  323,  324, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, yy_Dummy>>,
			1, 200, 6400)
		end

	yy_nxt_template_34 (an_array: ARRAY [INTEGER])
			-- Fill chunk #34 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015,  129,  129,  129,  129,  129,  129,  317,  318,
			  319,  319,  320,  321,  322,  323,  324,  283, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,

			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015,  807,  807,  807,  807,  807,  807,  498,  499,  500,
			  500,  501,  502,  503,  504,  505,  283, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, yy_Dummy>>,
			1, 200, 6600)
		end

	yy_nxt_template_35 (an_array: ARRAY [INTEGER])
			-- Fill chunk #35 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			  808,  808,  808,  808,  808,  808,  498,  499,  500,  500,
			  501,  502,  503,  504,  505,  283, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,

			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,  809,
			  809,  809,  809,  809,  809,  498,  499,  500,  500,  501,
			  502,  503,  504,  505,    5, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, yy_Dummy>>,
			1, 200, 6800)
		end

	yy_nxt_template_36 (an_array: ARRAY [INTEGER])
			-- Fill chunk #36 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, yy_Dummy>>,
			1, 70, 7000)
		end

	yy_chk_template: SPECIAL [INTEGER]
			-- Template for `yy_chk'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 7069)
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

			    1,    1,    1,    1,    1,    1,    3,    3,    3,    3,
			   22,    3,   23,  998,   23,   23,   23,   23,   24,   29,
			   29,   22,   31,   31,  963,   25,   24,   25,   25,   25,
			   25,   39,  149,   12,   41,  361,   12,   36,   25,   25,
			   41,   36,   15,   44,   58,   15,   16,   36,   16,   16,
			  956,   66,   44,   26,   16,   26,   26,   26,   26,   42,
			   25,  810,    3,   39,   45,   42,   41,   25,   45,   36,
			   25,   25,   41,   36,  149,   44,   58,  361,  570,   36,
			 1023, 1023,   12,   66,   44,   48,   50,   50,   68,   24,
			   48,   42,   25,    3,  568,   26,   45,   42, 1029, 1029, yy_Dummy>>,
			1, 200, 0)
		end

	yy_chk_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			   45,    3,    3,    3,    3,    3,    3,    3,    3,    3,
			    4,    4,    4,    4,   12,    4,  566,   48,   50,   50,
			   68,  367,   48,   12,   12,   12,   12,   12,   12,   12,
			   12,   12,   15,   15,   15,   15,   15,   15,   15,   15,
			   15,   16,   16,   16,   16,   16,   16,   16,   16,   16,
			   35,   35,   69,   37,   35,   72,   37,   35,   37,   60,
			   35,   47,   47,   35,   51,  365,    4,   74,   37,   60,
			   51,   47,   56,   56,   56,   56,   56,   56,   56,   56,
			   56,  363,   35,   35,   69,   37,   35,   72,   37,   35,
			   37,   60,   35,   47,   47,   35,   51,    4,  327,   74,

			   37,   60,   51,   47,  130,    4,    4,    4,    4,    4,
			    4,    4,    4,    4,   33,   33,   33,   33,   75,   80,
			   80,   80,  109,  160,   33,   33,   33,   33,   33,   33,
			   33,   33,   33,   33,   33,   33,   33,   33,   33,   33,
			   33,   33,   33,   33,   33,   33,   33,   33,   33,   33,
			   75,   83,   83,   83,   33,  160,   33,   33,   33,   33,
			   33,   33,   33,   33,   33,   33,   33,   33,   33,   33,
			   33,   33,   33,   33,   33,   33,   33,   33,   33,   33,
			   33,   33,   34,   34,   34,   34,   79,   79,   79,   79,
			   79,   79,   34,   34,   34,   34,   34,   34,   34,   34, yy_Dummy>>,
			1, 200, 200)
		end

	yy_chk_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			   34,   34,   34,   34,   34,   34,   34,   34,   34,   34,
			   34,   34,   34,   34,   34,   34,   34,   34,  105,  168,
			  103,  169,   34,   87,   34,   34,   34,   34,   34,   34,
			   34,   34,   34,   34,   34,   34,   34,   34,   34,   34,
			   34,   34,   34,   34,   34,   34,   34,   34,   34,   34,
			   38,  168,   40,  169,   38,   40,   43,  164,   38,   40,
			   40,   49,  164,   43,   53,   40,   43,   38,   43,   49,
			   46,   71,   43,   32,   46,   49, 1021, 1021, 1021,   62,
			   46,   71,   38,   62,   40,   46,   38,   40,   43,  164,
			   38,   40,   40,   49,  164,   43,   62,   40,   43,   38,

			   43,   49,   46,   71,   43,   57,   46,   49,   61,   57,
			   61,   62,   46,   71,   57,   62,   57,   46,   65,   59,
			   61,   57,   57,   59,   65,   27,   59,   11,   62,   59,
			   10,   64,   59,   67,  150,  150,  171,   57,   64,   64,
			   61,   57,   61,   67,   64,   67,   57,   70,   57,   67,
			   65,   59,   61,   57,   57,   59,   65,   70,   59,   73,
			    9,   59,   70,   64,   59,   67, 1030, 1030,  171,    7,
			   64,   64,    5,   73,  150,   67,   64,   67,    0,   70,
			    0,   67,   81,   81,   81,   81,   81,   81,    0,   70,
			   89,   73,   89,   89,   70,   82,   82,   82,   82,   82, yy_Dummy>>,
			1, 200, 400)
		end

	yy_chk_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			   82,   91,   91,   91,   91,   73,   84,   84,   84,   84,
			   84,   84,   85,   85,   85,   85,   85,   86,   86,   86,
			   86,   86,   86,   88,   88,   88,   88,   88,   88,   88,
			   88,   88,    0,   92,   94,   92,   92,   94,  172,   94,
			 1031, 1031,   94,  173,  175,    0,   89,   95,   95,   95,
			   95,   95,   95,   95,   95,   95,    0,   91,   96,   96,
			   96,   96,   96,   96,   96,   96,   96,   96,   96,   96,
			  172,    0,   98,   98,   98,  173,  175,   89,   98,   98,
			   98,   98,   98,   98,   98,   98,   98,    0,   91,   92,
			  162,  176,    0,  181,  162,  176,   91,   91,   91,   91,

			   91,   91,   91,   91,   91,   97,   97,   97,   97,   97,
			   97,   97,   97,   97,   97,   97,   97,   97,   97,   97,
			   92,  120,  162,  176,  120,  181,  162,  176,    0,   94,
			   94,   94,   94,   94,   94,   94,   94,   94,   99,   99,
			   99,   99,   99,   99,   99,   99,   99,   99,   99,   99,
			   99,   99,   99,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  101,  101,  101,
			  101,  101,  101,  101,  101,  101,  101,  101,  101,  101,
			  101,  101,  102,  107,  362,  362,  107,    0,  102,  102,
			  102,  102,  102,  102,  102,  102,  102,  151,  151,  151, yy_Dummy>>,
			1, 200, 600)
		end

	yy_chk_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			    0,    0,  111,    0,  148,  111,  148,  148,  148,  148,
			    0,  120,  120,  120,  120,  120,  120,  120,  120,  120,
			  118,    0,  161,  118,  362,  182,  143,  143,  143,  143,
			  121,  161,  107,  121,    0,  163,    0,  151,  163,  183,
			  143,    0,  147,  147,  147,  147,  148,    0,    0,    0,
			  122,  111,    0,  122,  161,    0,  147,  182,    0,  184,
			    0,    0,    0,  161,  107,  124,  143,  163,  124,  118,
			  163,  183,  143,  107,  107,  107,  107,  107,  107,  107,
			  107,  107,  110,  111,  110,  110,    0,  110,  147,    0,
			  110,  184,  111,  111,  111,  111,  111,  111,  111,  111,

			  111,  118,    0,  128,  118,    0,  128,    0,    0,    0,
			  118,  118,  118,  118,  118,  118,  118,  118,  118,  129,
			  121,  121,  121,  121,  121,  121,  121,  121,  121,    0,
			  153,  133,  153,  153,  153,  153,  110,  122,  122,  122,
			  122,  122,  122,  122,  122,  122,  122,  122,  122,  124,
			  124,  124,  135,    0,    0,  124,  124,  124,  124,  124,
			  124,  124,  124,  124,  565,  565,  137,    0,  110,    0,
			  185,  187,  153,  299,  299,  299,  299,  110,  110,  110,
			  110,  110,  110,  110,  110,  110,  112,  128,    0,  112,
			    0,    0,    0,  128,  128,  128,  128,  128,  128,  128, yy_Dummy>>,
			1, 200, 800)
		end

	yy_chk_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  128,  128,  185,  187,  565,  129,  129,  129,  129,  129,
			  129,  129,  129,  129,  133,  133,  133,  133,  133,  133,
			  133,  133,  133,  133,  133,  133,  139,  356,  356,  356,
			  356,  178,  135,  135,  135,  112,  178,  193,  135,  135,
			  135,  135,  135,  135,  135,  135,  135,  137,  137,  137,
			  137,  137,  137,  137,  137,  137,  137,  137,  137,  137,
			  137,  165,  170,  178,  177,  170,  179,  112,  178,  193,
			  179,  165,  177,  112,  112,  112,  112,  112,  112,  112,
			  112,  112,  112,  112,  112,  113,    0,    0,  113,  166,
			  174,  188,  194,  165,  170,  188,  177,  170,  179,  180,

			  166,  174,  179,  165,  177,  198,  139,  194,  180,  188,
			  199,  198,  139,  139,  139,  139,  139,  139,  139,  139,
			  139,  166,  174,  188,  194,  190,  195,  188,  197,    0,
			  195,  180,  166,  174,  113,  190,  197,  198,    0,  194,
			  180,  188,  199,  198,  259,  259,  259,  259,  259,  259,
			  556,  556,  556,  556,  192,    0,  196,  190,  195,  196,
			  197,  192,  195,    0,  200,  192,  113,  190,  197,  113,
			  113,  113,  113,  113,  113,  113,  113,  113,  113,  113,
			  113,  113,  113,  113,  114,  186,  192,  114,  196,  186,
			  191,  196,  186,  192,  201,  191,  200,  192,  202,  203, yy_Dummy>>,
			1, 200, 1000)
		end

	yy_chk_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  205,    0,  207,  186,  212,  191,  203,  210,  214,  210,
			  204,  213,  204,  215,  204,  204,  219,  186,  220,  214,
			    0,  186,  191,  213,  186,  204,  201,  191,  204,    0,
			  202,  203,  205,  114,  207,  186,  212,  191,  203,  210,
			  214,  210,  204,  213,  204,  215,  204,  204,  219,    0,
			  220,  214,  211,  216,    0,  213,  217,  204,  211,    0,
			  204,  217,  221,  216,  211,  114,  218,  222,  114,  114,
			  114,  225,  218,    0,  114,  114,  114,  114,  114,  114,
			  114,  114,  114,  115,  211,  216,  115,  208,  217,  208,
			  211,  208,    0,  217,  221,  216,  211,  224,  218,  222,

			    0,  224,  208,  225,  218,  208,  228,  229,  232,  228,
			  233,  229,  226,  228,  226,  230,  231,  226,  236,  208,
			  231,  208,  226,  208,  230,  226,  234,  226,  226,  224,
			  234,    0,  115,  224,  208,    0,    0,  208,  228,  229,
			  232,  228,  233,  229,  226,  228,  226,  230,  231,  226,
			  236,  235,  231,    0,  226,    0,  230,  226,  234,  226,
			  226,  237,  234,  235,  115,  249,  241,  115,  115,  115,
			  115,  115,  115,  115,  115,  115,  115,  115,  115,  115,
			  115,  115,  116,  235,  242,  116,  243,  227,  244,  227,
			  245,  238,  244,  237,  247,  235,  238,  227,  241,    0, yy_Dummy>>,
			1, 200, 1200)
		end

	yy_chk_template_8 (an_array: ARRAY [INTEGER])
			-- Fill chunk #8 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  227,  239,  227,  227,  240,  246,  239,  238,  371,  373,
			  250,    0,    0,  240,  246,  249,  242,  239,  243,  227,
			  244,  227,  245,  238,  244,    0,  247,    0,  238,  227,
			  375,  116,  227,  239,  227,  227,  240,  246,  239,  238,
			  371,  373,  364,  364,  364,  240,  246,    0,    0,  239,
			    0,  249,  249,  249,  249,  249,  249,  249,  249,  249,
			  250,  251,  375,  116,    0,    0,    0,  116,  116,  116,
			  116,  116,  116,  116,  116,  116,  116,  116,  116,  116,
			  116,  117,  364,    0,  117,  260,  260,  260,  260,  260,
			  260,  516,  516,  516,  516,  516,  250,  250,  250,  250,

			  250,  250,  250,  250,  250,    0,  253,  558,  558,  558,
			  558,  251,  261,  261,  261,  261,  261,  261,  262,  262,
			  262,  262,  262,  262,  263,  263,  263,  263,  263,  263,
			  117,  257,  264,  264,  264,  264,  264,  264,  265,  265,
			  265,  265,  265,  265,  251,  251,  251,  251,  251,  251,
			  251,  251,  251,  251,  251,  251,  253,  376,  378,  380,
			    0,    0,  117,    0,    0,  117,  117,  117,  117,  117,
			  117,  117,  117,  117,  117,  117,  117,  117,  117,  117,
			  123,  257,    0,  123,  381,    0,  253,  253,  253,  376,
			  378,  380,  253,  253,  253,  253,  253,  253,  253,  253, yy_Dummy>>,
			1, 200, 1400)
		end

	yy_chk_template_9 (an_array: ARRAY [INTEGER])
			-- Fill chunk #9 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  253,  266,  266,  266,  266,  266,  266,  355,    0,  355,
			    0,  257,  355,  355,  355,  355,  381,  257,  257,  257,
			  257,  257,  257,  257,  257,  257,  267,  267,  267,  267,
			  267,  267,  267,  267,  267,  268,  268,  268,  268,  268,
			  268,  268,  268,  268,  269,  269,  269,  269,  269,  269,
			  269,  269,  269,  269,  269,  269,  495,  495,  495,  495,
			  495,  495,    0,    0,  123,  123,  123,  123,  123,  123,
			  123,  123,  123,  123,  123,  123,  123,  123,  123,  125,
			    0,    0,  125,  270,  270,  270,  270,  270,  270,  270,
			  270,  270,  270,  270,  270,  270,  270,  270,  271,  271,

			  271,    0,    0,    0,  271,  271,  271,  271,  271,  271,
			  271,  271,  271,  272,  272,  272,  272,  272,  272,  272,
			  272,  272,  272,  272,  272,  272,  272,  272,  273,  273,
			  273,  273,  273,  273,  273,  273,  273,  273,  273,  273,
			  273,  273,  274,  274,  274,  274,  274,  274,  274,  274,
			  274,  274,  274,  274,  274,  274,  274,  276,    0,  276,
			  276,  278,    0,  125,  125,  125,  125,  125,  125,  125,
			  125,  125,  125,  125,  125,  125,  125,  125,  126,  275,
			  384,  126,    0,    0,  387,  275,  275,  275,  275,  275,
			  275,  275,  275,  275,  277,    0,  277,  277,  383,  557, yy_Dummy>>,
			1, 200, 1600)
		end

	yy_chk_template_10 (an_array: ARRAY [INTEGER])
			-- Fill chunk #10 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  557,  557,  557,  359,  280,  359,  280,  280,  359,  359,
			  359,  359,  384,  276,  281,  383,  387,  281,    0,  281,
			    0,    0,  281,    0,  284,    0,    0,  284,    0,  284,
			  383,  282,  284,  282,  282,  561,  561,  561,  561,  557,
			  291,    0,    0,  291,  276,  291,  389,  383,  291,    0,
			  277,  278,  278,  278,  278,  278,  278,  278,  278,  278,
			  280,    0,    0,  126,  126,  126,  126,  126,  126,  126,
			  126,  126,  126,  126,  126,  126,  126,  127,  389,    0,
			  127,  277,  562,  562,  562,  562,    0,  282,    0,    0,
			  360,  280,  360,  360,  360,  360,  391,    0,  393,  280,

			  280,  280,  280,  280,  280,  280,  280,  280,    0,  281,
			  281,  281,  281,  281,  281,  281,  281,  281,  282,  284,
			  284,  284,  284,  284,  284,  284,  284,  284,  391,  291,
			  393,    0,  360,    0,    0,  291,  291,  291,  291,  291,
			  291,  291,  291,  291,  292,  292,  292,  292,  292,  292,
			  292,  292,  292,  395,  368,  372,  368,  368,  368,  368,
			  372,  127,  127,  127,  127,  127,  127,  127,  127,  127,
			  127,  127,  127,  127,  127,  127,  131,  399,    0,  131,
			  131,  131,  131,    0,    0,  395,    0,  372,  131,    0,
			    0,    0,  372,    0,    0,  131,  368,  131,    0,  131, yy_Dummy>>,
			1, 200, 1800)
		end

	yy_chk_template_11 (an_array: ARRAY [INTEGER])
			-- Fill chunk #11 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  131,  131,  131,    0,  131,    0,  131,    0,    0,  399,
			  131,    0,  131,    0,    0,  131,  131,  131,  131,  131,
			  131,  293,  293,  293,  293,  293,  293,  293,  293,  293,
			  294,  294,  294,  294,  294,  294,  294,  294,  294,  295,
			  295,  295,  295,  295,  295,  295,  295,  295,  296,  296,
			  296,  296,  296,  296,  296,  296,  296,  296,  296,  296,
			  296,  296,  296,    0,    0,    0,  131,  131,  131,  131,
			  131,  131,  131,  131,  131,  132,  297,  297,  297,  297,
			  297,  297,  297,  297,  297,  297,  297,  297,  297,  297,
			  297,  298,  298,  298,  298,  298,  298,  298,  298,  298,

			  298,  298,  298,  298,  298,  298,  354,  354,  354,  354,
			    0,    0,  369,  370,  369,  369,  369,  369,    0,  370,
			  354,    0,  301,    0,    0,  301,  496,  496,  496,  496,
			  496,  496,    0,  358,  358,  358,  358,    0,    0,    0,
			  302,    0,  386,  302,    0,  370,  354,  358,  386,  400,
			  308,  370,  354,  308,  369,  132,  132,  132,  132,  132,
			  132,  132,  132,  132,  132,  132,  132,  132,  132,  132,
			  134,  301,  397,  358,  386,  401,  397,  403,  404,  358,
			  386,  400,  497,  497,  497,  497,  497,  497,    0,  302,
			  303,    0,  402,  303,    0,  407,  402,  411,    0,  309, yy_Dummy>>,
			1, 200, 2000)
		end

	yy_chk_template_12 (an_array: ARRAY [INTEGER])
			-- Fill chunk #12 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			    0,    0,  309,  301,  397,    0,    0,  401,  397,  403,
			  404,    0,  301,  301,  301,  301,  301,  301,  301,  301,
			  301,  302,    0,  304,  402,    0,  304,  407,  402,  411,
			  302,  302,  302,  302,  302,  302,  302,  302,  302,  303,
			  308,  308,  308,  308,  308,  308,  308,  308,  308,  315,
			  134,  134,  134,  134,  134,  134,  134,  134,  134,  134,
			  134,  134,  134,  134,  134,  136,    0,  374,  388,    0,
			  409,  303,  304,  310,  409,  374,  310,  413,  388,    0,
			  303,  303,  303,  303,  303,  303,  303,  303,  303,  309,
			  309,  309,  309,  309,  309,  309,  309,  309,  311,  374,

			  388,  311,  409,    0,  304,    0,  409,  374,    0,  413,
			  388,  317,    0,  304,  304,  304,  304,  304,  304,  304,
			  304,  304,    0,  318,    0,    0,  560,    0,  560,  415,
			  419,  560,  560,  560,  560,  315,  315,  315,  315,  315,
			  315,  315,  315,  315,  320,  136,  136,  136,  136,  136,
			  136,  136,  136,  136,  136,  136,  136,  136,  136,  136,
			  138,  415,  419,  310,  310,  310,  310,  310,  310,  310,
			  310,  310,  513,  513,  513,  513,  513,  513,  513,  513,
			  513,  563,  563,  563,  563,  325,  421,  425,  311,  311,
			  311,  311,  311,  311,  311,  311,  311,  317,  317,  317, yy_Dummy>>,
			1, 200, 2200)
		end

	yy_chk_template_13 (an_array: ARRAY [INTEGER])
			-- Fill chunk #13 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  317,  317,  317,  317,  317,  317,  318,  318,  318,  318,
			  318,  318,  318,  318,  318,  318,  318,  318,  421,  425,
			    0,  563,    0,  322,  320,  320,  320,    0,    0,  426,
			  320,  320,  320,  320,  320,  320,  320,  320,  320,  324,
			  138,  138,  138,  138,  138,  138,  138,  138,  138,  138,
			  138,  138,  138,  138,  138,  152,  152,  152,  152,  418,
			  420,  426,  418,    0,  420,  152,  152,  152,  152,  152,
			  152,  325,  325,  325,  325,  325,  325,  325,  325,  325,
			  326,  564,    0,  564,  564,  564,  564,    0,  427,  428,
			  429,  418,  420,    0,  418,  152,  420,  152,  152,  152,

			  152,  152,  152,  252,  322,  322,  322,  322,  322,  322,
			  322,  322,  322,  322,  322,  322,  322,  322,  328,  324,
			  427,  428,  429,  564,    0,  324,  324,  324,  324,  324,
			  324,  324,  324,  324,  329,  514,  514,  514,  514,  514,
			  514,  514,  514,  514,  422,  330,  430,  431,  422,  434,
			  430,    0,    0,  252,  330,  330,  330,  330,    0,  567,
			  567,  567,    0,  331,    0,    0,  326,  326,  326,  326,
			  326,  326,  326,  326,  326,  332,  422,    0,  430,  431,
			  422,  434,  430,  252,  252,  252,  252,  252,  252,  252,
			  252,  252,  252,  252,  252,  252,  252,  252,  254,  567, yy_Dummy>>,
			1, 200, 2400)
		end

	yy_chk_template_14 (an_array: ARRAY [INTEGER])
			-- Fill chunk #14 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  705,  705,  705,  705,  328,  328,  328,  328,  328,  328,
			  328,  328,  328,  333,  435,  437,  706,  706,  706,  706,
			  329,  329,  329,  329,  329,  329,  329,  329,  329,  334,
			    0,  330,  330,  330,  330,  330,  330,  330,  330,  330,
			  335,  436,  439,  440,  443,  436,  435,  437,  254,  331,
			  331,  331,  331,  331,  331,  331,  331,  331,  336,    0,
			    0,  332,  332,  332,  332,  332,  332,  332,  332,  332,
			  337,    0,    0,  436,  439,  440,  443,  436,  254,  254,
			  254,  254,  254,  254,  254,  254,  254,  254,  254,  254,
			  254,  254,  254,  255,  698,  698,  698,  698,  698,  333,

			  333,  333,  333,  333,  333,  333,  333,  333,  338,    0,
			  452,  708,  708,  708,  708,  334,  334,  334,  334,  334,
			  334,  334,  334,  334,  339,    0,  335,  335,  335,  335,
			  335,  335,  335,  335,  335,  340,  442,  453,  445,  454,
			  442,  445,  452,  255,  336,  336,  336,  336,  336,  336,
			  336,  336,  336,  341,    0,    0,  337,  337,  337,  337,
			  337,  337,  337,  337,  337,  342,    0,    0,  442,  453,
			  445,  454,  442,  445,  255,  255,  255,  255,  255,  255,
			  255,  255,  255,  255,  255,  255,  255,  255,  256,  710,
			  710,  710,  710,    0,  338,  338,  338,  338,  338,  338, yy_Dummy>>,
			1, 200, 2600)
		end

	yy_chk_template_15 (an_array: ARRAY [INTEGER])
			-- Fill chunk #15 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  338,  338,  338,    0,  455,  457,  343,    0,    0,    0,
			  339,  339,  339,  339,  339,  339,  339,  339,  339,  344,
			    0,  340,  340,  340,  340,  340,  340,  340,  340,  340,
			  345,  446,  460,  461,  463,  446,  455,  457,  256,  341,
			  341,  341,  341,  341,  341,  341,  341,  341,  346,    0,
			    0,  342,  342,  342,  342,  342,  342,  342,  342,  342,
			    0,    0,    0,  446,  460,  461,  463,  446,  256,  256,
			  256,  256,  256,  256,  256,  256,  256,  256,  256,  256,
			  256,  256,  256,  285,    0,    0,  285,    0,  285,    0,
			    0,  285,  343,  343,  343,  343,  343,  343,  343,  343,

			  343,  390,    0,    0,    0,  344,  344,  344,  344,  344,
			  344,  344,  344,  344,  390,  414,  345,  345,  345,  345,
			  345,  345,  345,  345,  345,    0,  414,    0,  464,    0,
			    0,  465,    0,  390,  346,  346,  346,  346,  346,  346,
			  346,  346,  346,    0,    0,    0,  390,  414,  712,  712,
			  712,  712,  814,  814,  814,  814,  382,  392,  414,  394,
			  464,  398,  396,  465,  382,  392,    0,    0,  394,  398,
			    0,  467,    0,  382,  396,  285,  285,  285,  285,  285,
			  285,  285,  285,  285,  285,  285,  285,  286,  382,  392,
			  286,  394,  286,  398,  396,  286,  382,  392,  405,  408, yy_Dummy>>,
			1, 200, 2800)
		end

	yy_chk_template_16 (an_array: ARRAY [INTEGER])
			-- Fill chunk #16 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  394,  398,  410,  467,  412,  382,  396,  408,  416,  417,
			  405,  423,  416,  408,  412,  424,  410,  433,  423,  432,
			  438,  469,  417,  424,  433,  416,  438,  432,    0,  444,
			  405,  408,  444,  447,  410,  444,  412,  447,  472,  408,
			  416,  417,  405,  423,  416,  408,  412,  424,  410,  433,
			  423,  432,  438,  469,  417,  424,  433,  416,  438,  432,
			  448,  444,    0,  449,  444,  447,    0,  444,  448,  447,
			  472,  818,  818,  818,  818,  449,  286,  286,  286,  286,
			  286,  286,  286,  286,  286,  286,  286,  286,  286,  286,
			  286,  287,  448,  451,  287,  449,  287,  450,  456,  287,

			  448,  458,  451,  450,  459,  458,  462,  449,  466,  473,
			  462,  471,  459,  466,  468,  450,  456,  470,  468,  471,
			  474,  470,  475,  476,  477,  451,  478,  479,  481,  450,
			  456,  478,    0,  458,  451,  450,  459,  458,  462,  482,
			  466,  473,  462,  471,  459,  466,  468,  450,  456,  470,
			  468,  471,  474,  470,  475,  476,  477,  486,  478,  479,
			  481,    0,    0,  478,  480,  574,  487,  573,    0,  480,
			  576,  482,  575,  578,  579,  488,  579,  573,  580,  581,
			  287,  287,  287,  575,  489,  581,  287,  287,  287,  287,
			  287,  287,  287,  287,  287,  288,  480,  574,  288,  573, yy_Dummy>>,
			1, 200, 3000)
		end

	yy_chk_template_17 (an_array: ARRAY [INTEGER])
			-- Fill chunk #17 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  288,  480,  576,  288,  575,  578,  579,  486,  579,  573,
			  580,  581,    0,    0,    0,  575,  487,  581,  498,    0,
			    0,  812,    0,  812,    0,  488,  812,  812,  812,  812,
			  499,    0,    0,    0,  489,  819,  819,  819,  819,  821,
			  821,  821,  821,  486,  486,  486,  486,  486,  486,  486,
			  486,  486,  487,  487,  487,  487,  487,  487,  487,  487,
			  487,  488,  488,  488,  488,  488,  488,  488,  488,  488,
			  489,  489,  489,  489,  489,  489,  489,  489,  489,  501,
			  896,  896,  896,  896,  288,  288,  288,  288,  288,  288,
			  288,  288,  288,  288,  288,  288,  288,  288,  288,  289,

			    0,    0,  289,    0,  289,    0,    0,  289,  498,  498,
			  498,  498,  498,  498,  498,  498,  498,  499,  499,  499,
			  499,  499,  499,  499,  499,  499,  499,  499,  499,  503,
			  515,  515,  515,  515,  515,  515,  515,  515,  515,  897,
			  897,  897,  897,    0,  505,    0,    0,  582,  506,    0,
			  583,  506,  584,  506,    0,  586,  506,  898,  898,  898,
			  898,    0,    0,  501,  501,  501,    0,    0,    0,  501,
			  501,  501,  501,  501,  501,  501,  501,  501,  507,  582,
			  588,  507,  583,  507,  584,    0,  507,  586,    0,  289,
			  289,  289,  289,  289,  289,  289,  289,  289,  289,  289, yy_Dummy>>,
			1, 200, 3200)
		end

	yy_chk_template_18 (an_array: ARRAY [INTEGER])
			-- Fill chunk #18 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  289,  289,  289,  290,    0,    0,  290,    0,  290,    0,
			    0,  290,  588,    0,  503,  503,  503,  503,  503,  503,
			  503,  503,  503,  503,  503,  503,  503,  503,  505,  520,
			  590,  585,  520,  585,  505,  505,  505,  505,  505,  505,
			  505,  505,  505,  506,  506,  506,  506,  506,  506,  506,
			  506,  506,  508,    0,  592,  508,  594,  508,    0,  596,
			  508,    0,  590,  585,    0,  585,  571,    0,  571,  571,
			  571,  571,    0,  507,  507,  507,  507,  507,  507,  507,
			  507,  507,  509,    0,  598,  509,  592,  509,  594,    0,
			  509,  596,  290,  290,  290,  290,  290,  290,  290,  290,

			  290,  290,  290,  290,  290,  290,  290,  300,  571,  300,
			  300,    0,  300,  600,  601,  300,  598,    0,    0,  520,
			  520,  520,  520,  520,  520,  520,  520,  520,  577,  555,
			  555,  555,  555,  595,  587,  595,  602,  517,  577,    0,
			  517,  604,    0,  555,  587,  600,  601,  508,  508,  508,
			  508,  508,  508,  508,  508,  508,  607,    0,  589,  605,
			  577,  300,  589,    0,  605,  595,  587,  595,  602,  555,
			  577,  518,    0,  604,  518,  555,  587,  509,  509,  509,
			  509,  509,  509,  509,  509,  509,  517,    0,  607,  519,
			  589,  605,  519,  300,  589,  572,  605,  572,  572,  572, yy_Dummy>>,
			1, 200, 3400)
		end

	yy_chk_template_19 (an_array: ARRAY [INTEGER])
			-- Fill chunk #19 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  572,    0,  300,  300,  300,  300,  300,  300,  300,  300,
			  300,  305,  591,    0,  305,  593,    0,  608,  517,  593,
			  518,  610,  612,  591,  614,  615,    0,  517,  517,  517,
			  517,  517,  517,  517,  517,  517,  521,  572,  519,  521,
			  618,  619,    0,    0,  591,  522,    0,  593,  522,  608,
			    0,  593,  518,  610,  612,  591,  614,  615,  523,  620,
			  305,  518,  518,  518,  518,  518,  518,  518,  518,  518,
			  519,    0,  618,  619,  524,  559,  559,  559,  559,  519,
			  519,  519,  519,  519,  519,  519,  519,  519,  525,  559,
			  622,  620,  305,  624,    0,  305,  305,  305,  305,  305,

			  305,  305,  305,  305,  305,  305,  305,  305,  305,  305,
			  306,    0,    0,  306,    0,  559,    0,  704,  704,  704,
			  704,  559,  622,  626,  628,  624,  521,  521,  521,  521,
			  521,  521,  521,  521,  521,  522,  522,  522,  522,  522,
			  522,  522,  522,  522,  523,  523,  523,  523,  523,  523,
			  523,  523,  523,  526,  630,  626,  628,  704,    0,  306,
			  524,  524,  524,  524,  524,  524,  524,  524,  524,    0,
			  709,  709,  709,  709,  525,  525,  525,  525,  525,  525,
			  525,  525,  525,  597,  599,  611,  630,    0,    0,  611,
			  599,  306,  597,  631,  306,  306,  306,  306,  306,  306, yy_Dummy>>,
			1, 200, 3600)
		end

	yy_chk_template_20 (an_array: ARRAY [INTEGER])
			-- Fill chunk #20 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  306,  306,  306,  306,  306,  306,  306,  306,  306,  307,
			  709,    0,  307,    0,    0,  597,  599,  611,  603,  606,
			  609,  611,  599,  625,  597,  631,  535,  603,  606,  609,
			  634,  635,  625,  621,  535,  535,  535,  535,  535,  526,
			  526,  526,  526,  526,  526,  526,  526,  526,  621,  616,
			  603,  606,  609,  616,  637,  625,  640,    0,  307,  603,
			  606,  609,  634,  635,  625,  621,  822,    0,  822,    0,
			    0,  822,  822,  822,  822,    0,    0,  613,    0,    0,
			  621,  616,    0,    0,    0,  616,  637,    0,  640,  613,
			  307,    0,    0,  307,  307,  307,  307,  307,  307,  307,

			  307,  307,  307,  307,  307,  307,  307,  307,  312,  613,
			  623,  312,  535,  535,  535,  535,  535,  535,  535,  535,
			  535,  613,  627,  629,  633,  623,  627,  633,  639,  641,
			  644,  639,  629,  643,  645,  646,  647,  648,  649,  647,
			  650,  652,  623,  653,  651,  643,  654,  649,  651,  656,
			  657,  658,  656,  660,  627,  629,  633,  623,  627,  633,
			  639,  641,  644,  639,  629,  643,  645,  646,  647,  648,
			  649,  647,  650,  652,    0,  653,  651,  643,  654,  649,
			  651,  656,  657,  658,  656,  660,  662,  664,    0,    0,
			  665,    0,  312,  312,  312,  312,  312,  312,  312,  312, yy_Dummy>>,
			1, 200, 3800)
		end

	yy_chk_template_21 (an_array: ARRAY [INTEGER])
			-- Fill chunk #21 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  312,  312,  312,  312,  312,  312,  312,  313,  655,  659,
			  313,  661,  663,  668,  669,  671,  667,  661,  662,  664,
			  655,  663,  665,  667,  673,  659,  674,  673,  676,  677,
			  675,  678,  677,  680,  681,  683,  685,  716,    0,    0,
			  655,  659,  675,  661,  663,  668,  669,  671,  667,  661,
			  688,    0,  655,  663,    0,  667,  673,  659,  674,  673,
			  676,  677,  675,  678,  677,  680,  681,  683,  686,  716,
			  711,  711,  711,  711,  675,  679,  717,    0,    0,  715,
			  719,  687,  722,  679,    0,  724,  685,  689,    0,  715,
			    0,  313,  313,  313,  313,  313,  313,  313,  313,  313,

			  313,  313,  313,  313,  313,  313,  314,  679,  717,  314,
			  711,  715,  719,    0,  722,  679,  690,  724,  686,  723,
			  723,  715,  685,  685,  685,  685,  685,  685,  685,  685,
			  685,  687,  691,  726,  727,  902,  902,  902,  902,    0,
			  688,  688,  688,  688,  688,  688,  688,  688,  688,    0,
			    0,  723,  723,    0,  686,  686,  686,  686,  686,  686,
			  686,  686,  686,    0,    0,  726,  727,  687,  687,  687,
			  687,  687,  687,  687,  687,  687,  699,  689,  689,  689,
			  689,  689,  689,  689,  689,  689,  700,    0,    0,    0,
			  314,  314,  314,  314,  314,  314,  314,  314,  314,  314, yy_Dummy>>,
			1, 200, 4000)
		end

	yy_chk_template_22 (an_array: ARRAY [INTEGER])
			-- Fill chunk #22 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  314,  314,  314,  314,  314,  319,  690,  690,  690,  690,
			  690,  690,  690,  690,  690,  701,  714,    0,  714,  714,
			  714,  714,  691,  691,  691,  691,  691,  691,  691,  691,
			  691,  695,    0,    0,  695,    0,  695,    0,    0,  695,
			  696,    0,    0,  696,    0,  696,    0,    0,  696,  697,
			  729,  732,  697,    0,  697,    0,    0,  697,  714,    0,
			    0,    0,  699,  699,  699,  699,  699,  699,  699,  699,
			  699,  702,  700,  700,  700,  700,  700,  700,  700,  700,
			  700,    0,  729,  732,  736,  319,  319,  319,  319,  319,
			  319,  319,  319,  319,  319,  319,  319,  319,  319,  319,

			  321,  701,  701,  701,  701,  701,  701,  701,  701,  701,
			  703,  703,  703,  703,    0,    0,  736,  904,  904,  904,
			  904,  737,  740,  742,  703,    0,  695,  695,  695,  695,
			  695,  695,  695,  695,  695,  696,  696,  696,  696,  696,
			  696,  696,  696,  696,  697,  697,  697,  697,  697,  697,
			  697,  697,  697,  737,  740,  742,  703,  702,  702,  702,
			  702,  702,  702,  702,  702,  702,  905,  905,  905,  905,
			    0,    0,  721,    0,    0,  733,  744,  721,    0,  733,
			  321,  321,  321,  321,  321,  321,  321,  321,  321,  321,
			  321,  321,  321,  321,  321,  323,  707,  707,  707,  707, yy_Dummy>>,
			1, 200, 4200)
		end

	yy_chk_template_23 (an_array: ARRAY [INTEGER])
			-- Fill chunk #23 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  713,  713,  713,  713,  721,  725,  731,  733,  744,  721,
			  707,  733,  725,  734,  713,  731,  735,  734,  739,  741,
			  741,  735,  743,  746,  745,  743,  747,  739,  745,  748,
			  749,  747,  750,  752,  751,  753,  707,  725,  731,  751,
			  756,  749,  707,    0,  725,  734,  713,  731,  735,  734,
			  739,  741,  741,  735,  743,  746,  745,  743,  747,  739,
			  745,  748,  749,  747,  750,  752,  751,  753,    0,  757,
			  758,  751,  756,  749,  757,  323,  323,  323,  323,  323,
			  323,  323,  323,  323,  323,  323,  323,  323,  323,  323,
			  347,  755,  759,  760,  761,  762,  759,  763,  765,  766,

			  755,  757,  758,  767,  768,  769,  757,  770,  771,  767,
			  773,  774,  775,  776,  773,  778,  779,  780,  777,  782,
			  784,  775,    0,  755,  759,  760,  761,  762,  759,  763,
			  765,  766,  755,  777,    0,  767,  768,  769,    0,  770,
			  771,  767,  773,  774,  775,  776,  773,  778,  779,  780,
			  777,  782,  784,  775,  781,  783,  786,  785,  781,  783,
			  787,  788,  807,  790,  787,  777,  785,  791,  794,    0,
			  347,  347,  347,  347,  347,  347,  347,  347,  347,  347,
			  347,  347,  347,  347,  347,  348,  781,  783,  786,  785,
			  781,  783,  787,  788,  789,  790,  787,  793,  785,  791, yy_Dummy>>,
			1, 200, 4400)
		end

	yy_chk_template_24 (an_array: ARRAY [INTEGER])
			-- Fill chunk #24 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  794,  795,  796,  797,  799,  789,  800,  801,  793,  795,
			  802,  801,  803,  805,  806,  808,  824,  826,  805,  829,
			  906,  906,  906,  906,  809,    0,  789,    0,    0,  793,
			    0,    0,    0,  795,  796,  797,  799,  789,  800,  801,
			  793,  795,  802,  801,  803,  805,  806,    0,  824,  826,
			  805,  829,  807,  807,  807,  807,  807,  807,  807,  807,
			  807,  813,  813,  813,  813,  348,  348,  348,  348,  348,
			  348,  348,  348,  348,  348,  348,  348,  348,  348,  348,
			  349,  816,  816,  816,  816,  817,  817,  817,  817,    0,
			  820,  820,  820,  820,  831,  816,  833,  815,    0,    0,

			    0,  813,    0,  834,  837,  808,  808,  808,  808,  808,
			  808,  808,  808,  808,  809,  809,  809,  809,  809,  809,
			  809,  809,  809,  815,  839,  817,  831,  816,  833,  815,
			  820,  823,  823,  823,  823,  834,  837,  957,  957,  957,
			  957,    0,    0,    0,  828,  823,  830,  835,  828,    0,
			    0,  840,  841,  835,    0,  840,  839,  843,  830,  844,
			  349,  349,  349,  349,  349,  349,  349,  349,  349,  349,
			  349,  349,  349,  349,  349,  350,  828,  823,  830,  835,
			  828,  832,  838,  840,  841,  835,  842,  840,  846,  843,
			  830,  844,  832,  838,  842,  848,  849,  850,  852,  848, yy_Dummy>>,
			1, 200, 4600)
		end

	yy_chk_template_25 (an_array: ARRAY [INTEGER])
			-- Fill chunk #25 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  853,  854,  855,  856,  859,  854,  852,  858,  861,  863,
			  860,  862,  865,  832,  838,  860,  867,  858,  842,  869,
			  846,    0,  862,    0,  832,  838,  842,  848,  849,  850,
			  852,  848,  853,  854,  855,  856,  859,  854,  852,  858,
			  861,  863,  860,  862,  865,  866,  871,  860,  867,  858,
			    0,  869,    0,  866,  862,  350,  350,  350,  350,  350,
			  350,  350,  350,  350,  350,  350,  350,  350,  350,  350,
			  351,  864,  868,  872,  870,  874,  875,  866,  871,  877,
			  874,  876,  864,  868,  870,  866,  876,  878,  880,  881,
			  882,  884,  880,  886,  889,  890,  891,  892,  888,  894,

			  890,  895,  911,  864,  868,  872,  870,  874,  875,  888,
			  894,  877,  874,  876,  864,  868,  870,  913,  876,  878,
			  880,  881,  882,  884,  880,  886,  889,  890,  891,  892,
			  888,  894,  890,  895,  911,    0,    0,  914,  899,    0,
			  899,  888,  894,  899,  899,  899,  899,  917,    0,  913,
			  351,  351,  351,  351,  351,  351,  351,  351,  351,  351,
			  351,  351,  351,  351,  351,  352,  900,  903,  900,  914,
			    0,  900,  900,  900,  900,  901,  901,  901,  901,  917,
			  908,  908,  908,  908,  909,  912,  909,  918,    0,  909,
			  909,  909,  909,  903,  908,  910,  912,  916,  920,  903, yy_Dummy>>,
			1, 200, 4800)
		end

	yy_chk_template_26 (an_array: ARRAY [INTEGER])
			-- Fill chunk #26 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  910,  921,  916,  920,  922,  923,  925,  924,  927,  928,
			  930,  922,  924,    0,    0,  901,    0,  912,    0,  918,
			  908,  959,  959,  959,  959,    0,  908,  910,  912,  916,
			  920,    0,  910,  921,  916,  920,  922,  923,  925,  924,
			  927,  928,  930,  922,  924,  352,  352,  352,  352,  352,
			  352,  352,  352,  352,  352,  352,  352,  352,  352,  352,
			  353,  926,  933,  932,  926,  932,  934,  936,  938,  939,
			  940,  941,  942,  938,  940,  943,  944,  945,  942,  946,
			  944,  947,  948,  950,  951,  946,  952,  950,  953,  954,
			  952,    0,    0,  926,  933,  932,  926,  932,  934,  936,

			  938,  939,  940,  941,  942,  938,  940,  943,  944,  945,
			  942,  946,  944,  947,  948,  950,  951,  946,  952,  950,
			  953,  954,  952,  958,  958,  958,  958,  960,  960,  960,
			  960,  961,  961,  961,  961,  965,  965,  965,  965,    0,
			  353,  353,  353,  353,  353,  353,  353,  353,  353,  353,
			  353,  353,  353,  353,  353,  366,  366,  366,  366,  967,
			  969,  970,    0,  958,  969,  366,  366,  366,  366,  366,
			  366,  962,  971,  962,  973,  976,  962,  962,  962,  962,
			  964,  964,  964,  964,  966,  966,  966,  966,    0,  977,
			  979,  967,  969,  970,  964,  366,  969,  366,  366,  366, yy_Dummy>>,
			1, 200, 5000)
		end

	yy_chk_template_27 (an_array: ARRAY [INTEGER])
			-- Fill chunk #27 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  366,  366,  366,  490,  971,  975,  973,  976,  975,  981,
			  984,  985,  983,  988,  989,  991,  987,  992,  993,  991,
			  964,  977,  979,  983,  966,  987,  964,  995,  997,  997,
			  997,  997,  999,  999,  999,  999,    0,  975, 1002, 1005,
			  975,  981,  984,  985,  983,  988,  989,  991,  987,  992,
			  993,  991,    0,  490,    0,  983,    0,  987,    0,  995,
			 1000, 1000, 1000, 1000, 1001, 1001, 1001, 1001,  997, 1004,
			 1002, 1005,    0, 1004, 1006, 1008, 1010, 1012, 1012, 1012,
			 1012, 1013,    0,  490,  490,  490,  490,  490,  490,  490,
			  490,  490,  490,  490,  490,  490,  490,  490,  491,    0,

			 1000, 1004,    0,    0, 1001, 1004, 1006, 1008, 1010, 1026,
			 1026, 1026, 1026, 1013,    0, 1026,    0, 1012, 1016, 1016,
			 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016, 1016,
			 1017, 1017,    0, 1017, 1017, 1017, 1017, 1017, 1017, 1017,
			 1017, 1017,    0, 1018,    0,    0,    0,    0,  491, 1018,
			 1018, 1018, 1018, 1018, 1018, 1019, 1019,    0, 1019, 1019,
			 1019, 1019, 1019, 1019, 1019, 1019, 1019, 1022, 1022,    0,
			 1022, 1022,    0,    0, 1022, 1022, 1022, 1022,  491,  491,
			  491,  491,  491,  491,  491,  491,  491,  491,  491,  491,
			  491,  491,  491,  492, 1020, 1020,    0, 1020, 1020, 1020, yy_Dummy>>,
			1, 200, 5200)
		end

	yy_chk_template_28 (an_array: ARRAY [INTEGER])
			-- Fill chunk #28 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			    0, 1020, 1020, 1020, 1020, 1020, 1024,    0,    0, 1024,
			    0, 1024, 1024, 1024, 1024, 1024, 1024, 1024, 1025, 1025,
			    0, 1025, 1025, 1025, 1025, 1025, 1025, 1025, 1025, 1025,
			 1027,    0,    0,    0, 1027, 1027, 1027, 1027, 1027, 1027,
			 1027, 1027,    0,  492, 1028, 1028, 1028, 1028, 1028, 1028,
			 1028, 1028,    0, 1028, 1028, 1028, 1032, 1032,    0, 1032,
			 1032,    0, 1032, 1032, 1032, 1032, 1032, 1032,    0,    0,
			    0,    0,    0,  492,  492,  492,  492,  492,  492,  492,
			  492,  492,  492,  492,  492,  492,  492,  492,  500, 1033,
			 1033, 1033, 1033, 1033, 1033, 1033, 1033,    0, 1033, 1033,

			 1033,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,  500,  500,  500,  500,  500,  500,  500,  500,
			  500,  500,  500,  500,  500,  500,  500,  502,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, yy_Dummy>>,
			1, 200, 5400)
		end

	yy_chk_template_29 (an_array: ARRAY [INTEGER])
			-- Fill chunk #29 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,  502,  502,  502,  502,  502,  502,  502,  502,  502,
			  502,  502,  502,  502,  502,  502,  504,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,

			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			  504,  504,  504,  504,  504,  504,  504,  504,  504,  504,
			  504,  504,  504,  504,  504,  510,    0,    0,  510,    0,
			  510,    0,    0,  510,    0,    0,    0,    0,    0,    0, yy_Dummy>>,
			1, 200, 5600)
		end

	yy_chk_template_30 (an_array: ARRAY [INTEGER])
			-- Fill chunk #30 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,  510,  510,  510,  510,  510,  510,
			  510,  510,  510,  510,  510,  510,  510,  510,  510,  511,
			    0,    0,  511,    0,  511,    0,    0,  511,    0,    0,

			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,  511,  511,
			  511,  511,  511,  511,  511,  511,  511,  511,  511,  511,
			  511,  511,  511,  512,    0,    0,  512,    0,  512,    0, yy_Dummy>>,
			1, 200, 5800)
		end

	yy_chk_template_31 (an_array: ARRAY [INTEGER])
			-- Fill chunk #31 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			    0,  512,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,  512,  512,  512,  512,  512,  512,  512,  512,
			  512,  512,  512,  512,  512,  512,  512,  527,    0,    0,

			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,  527,  527,  527,
			  527,  527,  527,  527,  527,  527,  527,  527,  527,  527,
			  527,  527,  528,    0,    0,    0,    0,    0,    0,    0, yy_Dummy>>,
			1, 200, 6000)
		end

	yy_chk_template_32 (an_array: ARRAY [INTEGER])
			-- Fill chunk #32 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,  528,  528,  528,  528,  528,  528,  528,  528,
			  528,  528,  528,  528,  528,  528,  528,  529,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,

			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,  529,  529,  529,
			  529,  529,  529,  529,  529,  529,  529,  529,  529,  529,
			  529,  529,  552,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, yy_Dummy>>,
			1, 200, 6200)
		end

	yy_chk_template_33 (an_array: ARRAY [INTEGER])
			-- Fill chunk #33 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,  552,  552,  552,  552,  552,  552,  552,  552,
			  552,  552,  552,  552,  552,  552,  552,  553,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,

			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,  553,  553,  553,
			  553,  553,  553,  553,  553,  553,  553,  553,  553,  553,
			  553,  553,  554,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, yy_Dummy>>,
			1, 200, 6400)
		end

	yy_chk_template_34 (an_array: ARRAY [INTEGER])
			-- Fill chunk #34 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,  554,  554,  554,  554,  554,  554,  554,  554,
			  554,  554,  554,  554,  554,  554,  554,  692,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,

			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,  692,  692,  692,  692,  692,  692,  692,  692,  692,
			  692,  692,  692,  692,  692,  692,  693,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, yy_Dummy>>,
			1, 200, 6600)
		end

	yy_chk_template_35 (an_array: ARRAY [INTEGER])
			-- Fill chunk #35 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			  693,  693,  693,  693,  693,  693,  693,  693,  693,  693,
			  693,  693,  693,  693,  693,  694,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,

			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,  694,
			  694,  694,  694,  694,  694,  694,  694,  694,  694,  694,
			  694,  694,  694,  694, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, yy_Dummy>>,
			1, 200, 6800)
		end

	yy_chk_template_36 (an_array: ARRAY [INTEGER])
			-- Fill chunk #36 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, yy_Dummy>>,
			1, 70, 7000)
		end

	yy_base_template: SPECIAL [INTEGER]
			-- Template for `yy_base'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 1033)
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
			    0,    0,    0,  104,  208,  572, 6964,  567, 6964,  557,
			  525,  521,  126,    0, 6964,  135,  144, 6964, 6964, 6964,
			 6964, 6964,   93,   94,   99,  107,  135,  498, 6964,   93,
			 6964,   95,  446,  294,  362,  213,  103,  215,  420,   93,
			  417,   96,  121,  425,  105,  130,  436,  224,  147,  431,
			  149,  226, 6964,  407, 6964, 6964,  175,  473,  106,  482,
			  225,  467,  449,    0,  496,  480,  107,  502,  141,  218,
			  513,  434,  212,  529,  230,  274, 6964, 6964, 6964,  295,
			  225,  491,  504,  260,  515,  520,  526,  332,  526,  588,
			 6964,  599,  631, 6964,  632,  550,  564,  614,  581,  647,

			  661,  676,  691,  418, 6964,  413, 6964,  776, 6964,  303,
			  880,  795,  979, 1078, 1177, 1276, 1375, 1474,  813,    0,
			  714,  823,  843, 1573,  858, 1672, 1771, 1870,  896,  908,
			  293, 1969, 2064,  920, 2159,  941, 2254,  955, 2349, 1015,
			 6964, 6964, 6964,  806, 6964, 6964, 6964,  822,  786,  114,
			  514,  777, 2435,  912, 6964, 6964, 6964, 6964, 6964, 6964,
			  285,  784,  656,  797,  424, 1023, 1051,    0,  372,  387,
			 1024,  503,  590,  594, 1052,  595,  657, 1034,  993, 1032,
			 1061,  659,  795,  796,  825,  923, 1154,  933, 1060,    0,
			 1087, 1157, 1116,  989, 1059, 1081, 1118, 1098, 1067, 1069, yy_Dummy>>,
			1, 200, 0)
		end

	yy_base_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			 1134, 1150, 1160, 1161, 1177, 1162,    0, 1157, 1254,    0,
			 1169, 1220, 1164, 1179, 1170, 1164, 1215, 1223, 1234, 1178,
			 1170, 1229, 1235,    0, 1263, 1237, 1279, 1354, 1268, 1269,
			 1277, 1275, 1266, 1263, 1292, 1313, 1284, 1311, 1358, 1368,
			 1366, 1328, 1337, 1348, 1354, 1356, 1367, 1347, 6964, 1354,
			 1399, 1450, 2492, 1495, 2587, 2682, 2777, 1520, 6964, 1053,
			 1394, 1421, 1427, 1433, 1441, 1447, 1510, 1529, 1538, 1550,
			 1592, 1607, 1622, 1636, 1651, 1688, 1755, 1792, 1754, 6964,
			 1802, 1812, 1829, 6964, 1822, 2881, 2985, 3089, 3193, 3297,
			 3401, 1838, 1847, 1924, 1933, 1942, 1957, 1985, 2000,  953,

			 3505, 2115, 2133, 2183, 2216, 3604, 3703, 3802, 2143, 2192,
			 2266, 2291, 3901, 4000, 4099, 2238, 6964, 2300, 2312, 4194,
			 2333, 4289, 2412, 4384, 2428, 2374, 2469,  287, 2507, 2523,
			 2534, 2552, 2564, 2602, 2618, 2629, 2647, 2659, 2697, 2713,
			 2724, 2742, 2754, 2795, 2808, 2819, 2837, 4479, 4574, 4669,
			 4764, 4859, 4954, 5049, 2086, 1592, 1007, 6964, 2113, 1788,
			 1872,  117,  764,  221, 1422,  205, 5135,  161, 1936, 2094,
			 2075, 1364, 1917, 1366, 2237, 1392, 1527,    0, 1520,    0,
			 1521, 1546, 2926, 1768, 1742,    0, 2110, 1752, 2230, 1798,
			 2863, 1845, 2927, 1868, 2921, 1906, 2924, 2138, 2931, 1927, yy_Dummy>>,
			1, 200, 200)
		end

	yy_base_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			 2115, 2145, 2158, 2143, 2140, 2960,    0, 2145, 2969, 2236,
			 2972, 2163, 2966, 2229, 2877, 2280, 2970, 2967, 2421, 2289,
			 2426, 2348, 2510, 2973, 2985, 2353, 2391, 2454, 2444, 2460,
			 2512, 2513, 2989, 2979, 2519, 2569, 2607, 2581, 2982, 2598,
			 2605,    0, 2702, 2610, 2997, 2706, 2797, 2999, 3030, 3025,
			 3065, 3055, 2676, 2703, 2709, 2754, 3066, 2758, 3067, 3074,
			 2798, 2803, 3072, 2800, 2890, 2893, 3070, 2928, 3080, 2987,
			 3083, 3073, 3000, 3075, 3074, 3084, 3085, 3086, 3093, 3094,
			 3126, 3085, 3101,    0, 6964, 6964, 3146, 3155, 3164, 3173,
			 5192, 5287, 5382, 6964, 6964, 1565, 2035, 2091, 3211, 3223,

			 5481, 3272, 5580, 3322, 5679, 3337, 3346, 3376, 3450, 3480,
			 5783, 5887, 5991, 2275, 2438, 3233, 1472, 3530, 3564, 3582,
			 3422, 3629, 3638, 3647, 3663, 3677, 3742, 6086, 6181, 6276,
			 6964, 6964, 6964, 6964, 6964, 3815, 6964, 6964, 6964, 6964,
			 6964, 6964, 6964, 6964, 6964, 6964, 6964, 6964, 6964, 6964,
			 6964, 6964, 6371, 6466, 6561, 3509, 1130, 1779, 1487, 3655,
			 2311, 1815, 1862, 2361, 2463,  944,  156, 2539,  134,    0,
			  118, 3448, 3577, 3129, 3117, 3134, 3121, 3490, 3125, 3138,
			 3142, 3147, 3309, 3318, 3314, 3393, 3315, 3496, 3332, 3524,
			 3396, 3574, 3405, 3581, 3422, 3497, 3423, 3745, 3437, 3752, yy_Dummy>>,
			1, 200, 400)
		end

	yy_base_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			 3481, 3476, 3498, 3780, 3494, 3521, 3781, 3513, 3570, 3782,
			 3574, 3751, 3588, 3839, 3574, 3587, 3815,    0, 3606, 3603,
			 3621, 3795, 3637, 3872, 3640, 3785, 3676, 3888, 3690, 3885,
			 3707, 3755,    0, 3886, 3789, 3793,    0, 3816,    0, 3890,
			 3815, 3891,    0, 3895, 3892, 3884, 3897, 3901, 3902, 3900,
			 3893, 3906, 3899, 3905, 3908, 3970, 3911, 3900, 3910, 3971,
			 3899, 3979, 3954, 3974, 3940, 3952,    0, 3978, 3968, 3976,
			    0, 3977,    0, 3989, 3991, 3992, 3978, 3991, 3990, 4045,
			 4003, 3996,    0, 3997,    0, 4025, 4057, 4070, 4043, 4080,
			 4109, 4125, 6660, 6759, 6858, 4229, 4238, 4247, 2675, 4165,

			 4175, 4204, 4260, 4290, 3697, 2580, 2596, 4376, 2691, 3750,
			 2769, 4050, 2928, 4380, 4198, 4041, 3989, 4038,    0, 4042,
			    0, 4334, 4039, 4082, 4048, 4374, 4102, 4096,    0, 4212,
			    0, 4368, 4204, 4341, 4379, 4378, 4241, 4283,    0, 4380,
			 4275, 4382, 4286, 4387, 4341, 4390, 4389, 4393, 4396, 4392,
			 4383, 4396, 4390, 4397,    0, 4453, 4393, 4431, 4427, 4458,
			 4459, 4456, 4457, 4459,    0, 4460, 4461, 4471, 4472, 4467,
			 4469, 4470,    0, 4476, 4477, 4474, 4466, 4480, 4462, 4478,
			 4479, 4520, 4485, 4521, 4486, 4519, 4509, 4526, 4527, 4556,
			 4514, 4529,    0, 4559, 4519, 4571, 4572, 4565,    0, 4566, yy_Dummy>>,
			1, 200, 600)
		end

	yy_base_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			 4568, 4573, 4576, 4574,    0, 4575, 4571, 4555, 4608, 4617,
			  142, 6964, 3206, 4641, 2932, 4663, 4661, 4665, 3051, 3215,
			 4670, 3219, 3851, 4711, 4578,    0, 4579,    0, 4710, 4585,
			 4708, 4644, 4743, 4647, 4665, 4709,    0, 4660, 4744, 4675,
			 4717, 4718, 4756, 4727, 4721,    0, 4750,    0, 4761, 4762,
			 4759,    0, 4768, 4770, 4767, 4768, 4765,    0, 4769, 4756,
			 4772, 4765, 4773, 4760, 4833, 4763, 4815, 4786, 4834, 4770,
			 4836, 4798, 4835,    0, 4837, 4833, 4843, 4836, 4849,    0,
			 4854, 4855, 4852,    0, 4853,    0, 4855,    0, 4860, 4845,
			 4857, 4853, 4859,    0, 4861, 4852, 3260, 3319, 3337, 4923,

			 4951, 4955, 4115, 4933, 4297, 4346, 4600, 6964, 4960, 4969,
			 4962, 4869, 4947, 4868, 4899,    0, 4959, 4904, 4949,    0,
			 4965, 4968, 4973, 4974, 4974, 4973, 5023, 4967, 4971,    0,
			 4972,    0, 5027, 5026, 5028,    0, 5029,    0, 5030, 5026,
			 5036, 5037, 5034, 5031, 5042, 5043, 5047, 5049, 5044,    0,
			 5049, 5050, 5052, 5054, 5051,    0,   90, 4717, 5103, 5001,
			 5107, 5111, 5156,   64, 5160, 5115, 5164, 5121,    0, 5126,
			 5127, 5134,    0, 5136,    0, 5167, 5134, 5151,    0, 5152,
			    0, 5171,    0, 5174, 5161, 5173,    0, 5178, 5166, 5176,
			    0, 5181, 5183, 5180,    0, 5189,    0, 5208,   53, 5212, yy_Dummy>>,
			1, 200, 800)
		end

	yy_base_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			 5240, 5244, 5200,    0, 5235, 5205, 5236,    0, 5237,    0,
			 5238,    0, 5257, 5243,    0, 6964, 5317, 5329, 5342, 5354,
			 5393,  467, 5366,  170, 5405, 5417, 5304, 5429, 5443,  188,
			  556,  630, 5455, 5488, yy_Dummy>>,
			1, 34, 1000)
		end

	yy_def_template: SPECIAL [INTEGER]
			-- Template for `yy_def'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 1033)
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
			    0, 1015,    1, 1016, 1016, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1017, 1018, 1015, 1019, 1020, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1021, 1021, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015,   34,   34,   34,   34,   34,
			   34,   34,   34,   34,   34,   34,   34,   34,   34,   34,
			   34,   34, 1015, 1015, 1015, 1015, 1022, 1023, 1023, 1023,
			 1023, 1023, 1023, 1023, 1023, 1023, 1023, 1023, 1023, 1023,
			 1023, 1023, 1023, 1023, 1023, 1023, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1024, 1015,
			 1015, 1024, 1015, 1015, 1025, 1024, 1024, 1024, 1024, 1024,

			 1024, 1024, 1024, 1015, 1015, 1015, 1015, 1017, 1015, 1026,
			 1017, 1017, 1017, 1017, 1017, 1017, 1017, 1017, 1017, 1018,
			 1019, 1019, 1019, 1019, 1019, 1019, 1019, 1019, 1019, 1027,
			 1015, 1027, 1027, 1027, 1027, 1027, 1027, 1027, 1027, 1027,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1028, 1021, 1021,
			 1029, 1030, 1031, 1021, 1015, 1015, 1015, 1015, 1015, 1015,
			   34,   34,   34,   34,   34,   34,   34, 1023, 1023, 1023,
			 1023, 1023, 1023, 1023,   34, 1023,   34,   34,   34,   34,
			   34, 1023, 1023, 1023, 1023, 1023,   34,   34, 1023, 1023,
			   34,   34,   34, 1023, 1023, 1023,   34,   34,   34, 1023, yy_Dummy>>,
			1, 200, 0)
		end

	yy_def_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			 1023, 1023,   34,   34,   34,   34, 1023, 1023, 1023, 1023,
			   34,   34, 1023, 1023,   34, 1023,   34,   34,   34,   34,
			 1023, 1023, 1023, 1023,   34, 1023,   34, 1023,   34,   34,
			   34, 1023, 1023, 1023,   34,   34, 1023, 1023,   34, 1023,
			   34,   34, 1023, 1023,   34, 1023,   34, 1023, 1015, 1022,
			 1022, 1022, 1022, 1022, 1022, 1022, 1022, 1022, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1024, 1024, 1024,
			 1024, 1024, 1024, 1024, 1024, 1024, 1015, 1015, 1032, 1015,
			 1024, 1025, 1015, 1015, 1025, 1025, 1025, 1025, 1025, 1025,
			 1025, 1025, 1024, 1024, 1024, 1024, 1024, 1024, 1024, 1015,

			 1017, 1017, 1017, 1017, 1017, 1017, 1017, 1017, 1019, 1019,
			 1019, 1019, 1019, 1019, 1019, 1027, 1015, 1027, 1027, 1027,
			 1027, 1027, 1027, 1027, 1027, 1027, 1027, 1015, 1027, 1027,
			 1027, 1027, 1027, 1027, 1027, 1027, 1027, 1027, 1027, 1027,
			 1027, 1027, 1027, 1027, 1027, 1027, 1027, 1027, 1027, 1027,
			 1027, 1027, 1027, 1027, 1015, 1015, 1015, 1015, 1015, 1015,
			 1021, 1021, 1029, 1029, 1030, 1030, 1031, 1031, 1021, 1021,
			   34, 1023,   34, 1023,   34,   34, 1023, 1023,   34, 1023,
			   34, 1023,   34, 1023,   34, 1023,   34, 1023,   34, 1023,
			   34, 1023,   34, 1023,   34, 1023,   34,   34,   34, 1023, yy_Dummy>>,
			1, 200, 200)
		end

	yy_def_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			 1023, 1023,   34, 1023,   34,   34, 1023, 1023,   34,   34,
			 1023, 1023,   34, 1023,   34, 1023,   34, 1023,   34, 1023,
			   34,   34,   34,   34,   34, 1023, 1023, 1023, 1023, 1023,
			   34, 1023,   34,   34, 1023, 1023,   34, 1023,   34, 1023,
			   34, 1023,   34, 1023,   34, 1023,   34,   34,   34,   34,
			   34,   34, 1023, 1023, 1023, 1023, 1023, 1023,   34,   34,
			 1023, 1023,   34, 1023,   34, 1023,   34, 1023,   34, 1023,
			   34,   34,   34, 1023, 1023, 1023,   34, 1023,   34, 1023,
			   34, 1023,   34, 1023, 1015, 1015, 1022, 1022, 1022, 1022,
			 1022, 1022, 1022, 1015, 1015, 1015, 1015, 1015, 1032, 1032,

			 1032, 1032, 1032, 1032, 1032, 1032, 1025, 1025, 1025, 1025,
			 1025, 1025, 1025, 1024, 1024, 1024, 1015, 1017, 1017, 1017,
			 1019, 1019, 1019, 1027, 1027, 1027, 1027, 1027, 1027, 1027,
			 1015, 1015, 1015, 1015, 1015, 1027, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1027, 1027, 1027, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1021, 1029, 1029, 1030, 1030,  366,
			 1031, 1021, 1021,   34, 1023,   34, 1023,   34, 1023,   34,
			 1023,   34,   34, 1023, 1023,   34, 1023,   34, 1023,   34,
			 1023,   34, 1023,   34, 1023,   34, 1023,   34, 1023,   34, yy_Dummy>>,
			1, 200, 400)
		end

	yy_def_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			 1023,   34, 1023,   34, 1023,   34,   34, 1023, 1023,   34,
			 1023,   34, 1023,   34, 1023,   34,   34, 1023, 1023,   34,
			 1023,   34, 1023,   34, 1023,   34, 1023,   34, 1023,   34,
			 1023,   34, 1023,   34, 1023,   34, 1023,   34, 1023,   34,
			 1023,   34, 1023,   34,   34, 1023, 1023,   34, 1023,   34,
			 1023,   34, 1023,   34, 1023,   34,   34, 1023, 1023,   34,
			 1023,   34, 1023,   34, 1023,   34, 1023,   34, 1023,   34,
			 1023,   34, 1023,   34, 1023,   34, 1023,   34, 1023,   34,
			 1023,   34, 1023,   34, 1023, 1022, 1022, 1022, 1032, 1032,
			 1032, 1032, 1032, 1032, 1032, 1025, 1025, 1025, 1015, 1027,

			 1027, 1027, 1027, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1028, 1021,   34, 1023,   34, 1023,   34,
			 1023,   34, 1023,   34, 1023,   34, 1023,   34, 1023,   34,
			 1023,   34, 1023,   34, 1023,   34, 1023,   34, 1023,   34,
			 1023,   34, 1023,   34, 1023,   34, 1023,   34, 1023,   34,
			 1023,   34, 1023,   34, 1023,   34, 1023,   34, 1023,   34,
			 1023,   34, 1023,   34, 1023,   34, 1023,   34, 1023,   34,
			 1023,   34, 1023,   34, 1023,   34, 1023,   34, 1023,   34,
			 1023,   34, 1023,   34, 1023,   34, 1023,   34, 1023,   34,
			 1023,   34, 1023,   34, 1023,   34, 1023,   34, 1023,   34, yy_Dummy>>,
			1, 200, 600)
		end

	yy_def_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			 1023,   34, 1023,   34, 1023,   34, 1023, 1032, 1032, 1032,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1033,   34, 1023,   34, 1023,   34, 1023,
			   34, 1023,   34, 1023,   34,   34, 1023, 1023,   34, 1023,
			   34, 1023,   34, 1023,   34, 1023,   34, 1023,   34, 1023,
			   34, 1023,   34, 1023,   34, 1023,   34, 1023,   34, 1023,
			   34, 1023,   34, 1023,   34, 1023,   34, 1023,   34, 1023,
			   34, 1023,   34, 1023,   34, 1023,   34, 1023,   34, 1023,
			   34, 1023,   34, 1023,   34, 1023,   34, 1023,   34, 1023,
			   34, 1023,   34, 1023,   34, 1023, 1015, 1015, 1015, 1015,

			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			   34, 1023,   34, 1023,   34, 1023,   34, 1023,   34, 1023,
			   34, 1023,   34, 1023,   34, 1023,   34, 1023,   34, 1023,
			   34, 1023,   34, 1023,   34, 1023,   34, 1023,   34, 1023,
			   34, 1023,   34, 1023,   34, 1023,   34, 1023,   34, 1023,
			   34, 1023,   34, 1023,   34, 1023, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015,   34, 1023,   34,
			 1023,   34, 1023,   34, 1023,   34, 1023,   34, 1023,   34,
			 1023,   34, 1023,   34, 1023,   34, 1023,   34, 1023,   34,
			 1023,   34, 1023,   34, 1023,   34, 1023, 1015, 1015, 1015, yy_Dummy>>,
			1, 200, 800)
		end

	yy_def_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			 1015, 1015,   34, 1023,   34, 1023,   34, 1023,   34, 1023,
			   34, 1023, 1015,   34, 1023,    0, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015, 1015,
			 1015, 1015, 1015, 1015, yy_Dummy>>,
			1, 34, 1000)
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
			   92,   92,   92,   92,   92,   92,   92,   92,   92,   93,
			   94,   94,   94,   94,   94,   94,   95,   96,   94,   94,
			   94,   94,   94,   94,   94,   94,   94,   94,   94,   94,
			   94,   94,   94,   94,   94,   94,   94,   94,   94,   94,
			   94,   94,    1,    1,   97,   97,   97,   97,   97,   97, yy_Dummy>>,
			1, 200, 0)
		end

	yy_ec_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   97,   97,   97,   97,   97,   97,   97,   97,   97,   97,
			   97,   97,   97,   97,   97,   97,   97,   97,   97,   97,
			   97,   97,   97,   97,   98,   99,  100,   99,   99,   99,
			   99,   99,   99,   99,   99,   99,   99,  101,  102,  102,
			  103,  104,  104,  104,  105,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1, yy_Dummy>>,
			1, 57, 200)
		end

	yy_meta_template: SPECIAL [INTEGER]
			-- Template for `yy_meta'
		once
			Result := yy_fixed_array (<<
			    0,    1,    2,    3,    4,    2,    1,    5,    1,    1,
			    6,    7,    8,    8,    1,    1,    1,    1,    9,    8,
			   10,   10,   10,   10,    1,    1,    8,    1,    8,    1,
			   11,   11,   11,   11,   10,   11,   10,   11,   10,   10,
			   10,   11,   10,   11,   10,   10,   11,   11,   11,   11,
			   11,   11,   10,   10,   10,   10,    1,    1,    1,    1,
			   10,   12,   10,   10,   10,   10,   10,   10,   10,   10,
			   10,   10,   10,   10,   10,   10,   10,   10,   10,   10,
			   10,   10,   10,   10,   10,   10,   10,   10,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,

			    1,    1,    1,    1,    1,    1, yy_Dummy>>)
		end

	yy_accept_template: SPECIAL [INTEGER]
			-- Template for `yy_accept'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 1016)
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
			   14,   17,   20,   22,   25,   28,   30,   32,   35,   38,
			   41,   44,   47,   50,   53,   56,   60,   64,   67,   70,
			   73,   76,   79,   81,   85,   89,   93,   97,  101,  105,
			  109,  113,  117,  121,  125,  129,  133,  137,  141,  145,
			  149,  153,  157,  160,  162,  165,  168,  170,  173,  176,
			  179,  182,  185,  188,  191,  194,  197,  200,  203,  206,
			  209,  212,  215,  218,  221,  224,  227,  230,  233,  236,
			  238,  240,  242,  244,  246,  248,  250,  252,  254,  256,
			  258,  260,  263,  265,  267,  269,  271,  273,  275,  277,

			  279,  281,  283,  285,  286,  287,  288,  289,  289,  290,
			  291,  293,  293,  293,  293,  293,  293,  293,  293,  293,
			  294,  294,  294,  294,  294,  294,  294,  294,  294,  294,
			  295,  295,  296,  297,  298,  299,  300,  301,  302,  303,
			  304,  305,  306,  307,  309,  310,  311,  312,  312,  314,
			  315,  316,  317,  318,  318,  319,  320,  321,  322,  323,
			  324,  326,  328,  330,  332,  334,  337,  339,  340,  341,
			  342,  343,  344,  346,  347,  349,  350,  352,  354,  356,
			  358,  360,  361,  362,  363,  364,  365,  367,  370,  371,
			  373,  375,  377,  379,  380,  381,  382,  384,  386,  388, yy_Dummy>>,
			1, 200, 0)
		end

	yy_accept_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			  389,  390,  391,  394,  396,  398,  401,  403,  404,  405,
			  407,  409,  411,  412,  413,  415,  416,  418,  420,  422,
			  425,  426,  427,  428,  430,  432,  433,  435,  436,  438,
			  440,  442,  443,  444,  445,  447,  449,  450,  451,  453,
			  454,  456,  458,  459,  460,  462,  463,  465,  466,  467,
			  467,  467,  467,  467,  467,  467,  467,  467,  467,  468,
			  468,  468,  468,  468,  468,  468,  468,  468,  469,  470,
			  471,  472,  473,  474,  475,  476,  477,  478,  478,  478,
			  479,  480,  481,  482,  483,  484,  485,  486,  487,  488,
			  489,  490,  491,  492,  493,  494,  495,  496,  497,  498,

			  498,  499,  499,  499,  499,  499,  499,  499,  499,  499,
			  499,  499,  499,  499,  499,  499,  500,  501,  502,  503,
			  504,  505,  506,  507,  508,  509,  510,  511,  511,  512,
			  513,  514,  515,  516,  517,  518,  519,  520,  521,  522,
			  523,  524,  525,  526,  527,  528,  529,  530,  531,  532,
			  533,  534,  535,  536,  537,  539,  539,  539,  540,  542,
			  543,  545,  545,  548,  550,  553,  555,  558,  560,  562,
			  562,  564,  565,  567,  568,  570,  573,  574,  576,  579,
			  581,  583,  584,  586,  587,  590,  592,  594,  595,  597,
			  598,  600,  601,  603,  604,  606,  607,  609,  611,  613, yy_Dummy>>,
			1, 200, 200)
		end

	yy_accept_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			  614,  615,  616,  618,  619,  622,  624,  626,  627,  629,
			  631,  632,  633,  635,  636,  638,  639,  641,  642,  644,
			  645,  647,  649,  651,  653,  655,  656,  657,  658,  659,
			  660,  662,  663,  665,  667,  668,  669,  672,  674,  676,
			  677,  680,  682,  684,  685,  687,  688,  690,  692,  694,
			  696,  698,  700,  701,  702,  703,  704,  705,  706,  708,
			  710,  711,  712,  714,  715,  717,  718,  720,  721,  723,
			  724,  726,  728,  730,  731,  732,  733,  735,  736,  738,
			  739,  741,  742,  745,  747,  748,  749,  749,  749,  749,
			  749,  749,  749,  749,  751,  753,  753,  753,  753,  753,

			  753,  753,  753,  753,  753,  753,  753,  754,  755,  756,
			  757,  758,  759,  760,  761,  762,  763,  763,  763,  763,
			  763,  763,  763,  763,  764,  765,  766,  767,  768,  769,
			  770,  771,  772,  773,  774,  775,  776,  777,  778,  779,
			  780,  781,  782,  783,  784,  785,  786,  787,  788,  789,
			  790,  791,  792,  793,  794,  795,  797,  797,  799,  799,
			  801,  801,  801,  801,  803,  805,  805,  805,  805,  805,
			  805,  805,  807,  809,  811,  812,  814,  815,  817,  818,
			  820,  821,  823,  825,  826,  827,  829,  830,  832,  833,
			  835,  836,  838,  839,  841,  842,  844,  845,  847,  848, yy_Dummy>>,
			1, 200, 400)
		end

	yy_accept_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			  850,  851,  854,  856,  858,  859,  861,  863,  864,  865,
			  867,  868,  870,  871,  873,  874,  877,  879,  881,  882,
			  884,  885,  887,  888,  890,  891,  893,  894,  896,  897,
			  899,  900,  903,  905,  907,  908,  911,  913,  916,  918,
			  920,  921,  924,  926,  928,  930,  931,  932,  934,  935,
			  937,  938,  940,  941,  943,  944,  946,  948,  949,  950,
			  952,  953,  955,  956,  958,  959,  962,  964,  966,  967,
			  970,  972,  975,  977,  979,  980,  982,  983,  985,  986,
			  988,  989,  992,  994,  997,  999,  999,  999,  999,  999,
			  999,  999,  999,  999,  999,  999, 1000, 1001, 1002, 1002,

			 1003, 1004, 1005, 1006, 1007, 1009, 1009, 1009, 1011, 1011,
			 1015, 1015, 1017, 1017, 1017, 1019, 1021, 1022, 1025, 1027,
			 1030, 1032, 1034, 1035, 1037, 1038, 1040, 1041, 1044, 1046,
			 1049, 1051, 1053, 1054, 1056, 1057, 1059, 1060, 1063, 1065,
			 1067, 1068, 1070, 1071, 1073, 1074, 1076, 1077, 1079, 1080,
			 1082, 1083, 1085, 1086, 1089, 1091, 1093, 1094, 1096, 1097,
			 1099, 1100, 1102, 1103, 1106, 1108, 1110, 1111, 1113, 1114,
			 1116, 1117, 1120, 1122, 1124, 1125, 1127, 1128, 1130, 1131,
			 1133, 1134, 1136, 1137, 1139, 1140, 1142, 1143, 1145, 1146,
			 1148, 1149, 1152, 1154, 1156, 1157, 1159, 1160, 1163, 1165, yy_Dummy>>,
			1, 200, 600)
		end

	yy_accept_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			 1167, 1168, 1170, 1171, 1174, 1176, 1178, 1179, 1179, 1179,
			 1179, 1179, 1180, 1180, 1182, 1182, 1183, 1184, 1188, 1188,
			 1188, 1190, 1190, 1191, 1191, 1194, 1196, 1199, 1201, 1203,
			 1204, 1206, 1207, 1209, 1210, 1213, 1215, 1217, 1218, 1220,
			 1221, 1223, 1224, 1226, 1227, 1230, 1232, 1235, 1237, 1239,
			 1240, 1243, 1245, 1247, 1248, 1250, 1251, 1254, 1256, 1258,
			 1259, 1261, 1262, 1264, 1265, 1267, 1268, 1270, 1271, 1273,
			 1274, 1276, 1277, 1280, 1282, 1284, 1285, 1287, 1288, 1291,
			 1293, 1295, 1296, 1299, 1301, 1304, 1306, 1309, 1311, 1313,
			 1314, 1316, 1317, 1320, 1322, 1324, 1325, 1325, 1326, 1326,

			 1326, 1326, 1330, 1330, 1331, 1332, 1332, 1332, 1333, 1334,
			 1335, 1337, 1338, 1340, 1341, 1344, 1346, 1348, 1349, 1352,
			 1354, 1356, 1357, 1359, 1360, 1362, 1363, 1365, 1366, 1369,
			 1371, 1374, 1376, 1378, 1379, 1382, 1384, 1387, 1389, 1391,
			 1392, 1394, 1395, 1397, 1398, 1400, 1401, 1403, 1404, 1407,
			 1409, 1411, 1412, 1414, 1415, 1418, 1420, 1421, 1421, 1422,
			 1422, 1424, 1424, 1424, 1425, 1426, 1426, 1427, 1430, 1432,
			 1434, 1435, 1438, 1440, 1443, 1445, 1447, 1448, 1451, 1453,
			 1456, 1458, 1461, 1463, 1465, 1466, 1469, 1471, 1473, 1474,
			 1477, 1479, 1481, 1482, 1485, 1487, 1490, 1492, 1493, 1495, yy_Dummy>>,
			1, 200, 800)
		end

	yy_accept_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			 1495, 1497, 1498, 1501, 1503, 1505, 1506, 1509, 1511, 1514,
			 1516, 1519, 1521, 1523, 1526, 1528, 1528, yy_Dummy>>,
			1, 17, 1000)
		end

	yy_acclist_template: SPECIAL [INTEGER]
			-- Template for `yy_acclist'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 1527)
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
			    0,  148,  148,  168,  166,  167,    2,  166,  167,    4,
			  167,    5,  166,  167,    1,  166,  167,   11,  166,  167,
			  166,  167,  115,  166,  167,   18,  166,  167,  166,  167,
			  166,  167,   12,  166,  167,   13,  166,  167,   35,  166,
			  167,   34,  166,  167,    9,  166,  167,   33,  166,  167,
			    7,  166,  167,   36,  166,  167,  150,  157,  166,  167,
			  150,  157,  166,  167,   10,  166,  167,    8,  166,  167,
			   40,  166,  167,   38,  166,  167,   39,  166,  167,  166,
			  167,  113,  114,  166,  167,  113,  114,  166,  167,  113,
			  114,  166,  167,  113,  114,  166,  167,  113,  114,  166,

			  167,  113,  114,  166,  167,  113,  114,  166,  167,  113,
			  114,  166,  167,  113,  114,  166,  167,  113,  114,  166,
			  167,  113,  114,  166,  167,  113,  114,  166,  167,  113,
			  114,  166,  167,  113,  114,  166,  167,  113,  114,  166,
			  167,  113,  114,  166,  167,  113,  114,  166,  167,  113,
			  114,  166,  167,  113,  114,  166,  167,   16,  166,  167,
			  166,  167,   17,  166,  167,   37,  166,  167,  166,  167,
			  114,  166,  167,  114,  166,  167,  114,  166,  167,  114,
			  166,  167,  114,  166,  167,  114,  166,  167,  114,  166,
			  167,  114,  166,  167,  114,  166,  167,  114,  166,  167, yy_Dummy>>,
			1, 200, 0)
		end

	yy_acclist_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  114,  166,  167,  114,  166,  167,  114,  166,  167,  114,
			  166,  167,  114,  166,  167,  114,  166,  167,  114,  166,
			  167,  114,  166,  167,  114,  166,  167,   14,  166,  167,
			   15,  166,  167,   41,  166,  167,  166,  167,  166,  167,
			  166,  167,  166,  167,  166,  167,  166,  167,  166,  167,
			  166,  167,  166,  167,  148,  167,  143,  167,  145,  167,
			  146,  148,  167,  142,  167,  147,  167,  148,  167,  148,
			  167,  148,  167,  148,  167,  148,  167,  148,  167,  148,
			  167,  148,  167,  148,  167,    2,    3,    1,   42,  149,
			  149, -140, -307,  115,  139,  139,  139,  139,  139,  139,

			  139,  139,  139,  139,    6,   26,   27,  160,  163,   21,
			   23,   32,  150,  157,  157,  157,  157,  157,   31,   28,
			   25,   24,   29,   30,  113,  114,  113,  114,  113,  114,
			  113,  114,  113,  114,   47,  113,  114,  113,  114,  114,
			  114,  114,  114,  114,   47,  114,  114,  113,  114,  114,
			  113,  114,  113,  114,  113,  114,  113,  114,  113,  114,
			  114,  114,  114,  114,  114,  113,  114,   58,  113,  114,
			  114,   58,  114,  113,  114,  113,  114,  113,  114,  114,
			  114,  114,  113,  114,  113,  114,  113,  114,  114,  114,
			  114,   70,  113,  114,  113,  114,  113,  114,   76,  113, yy_Dummy>>,
			1, 200, 200)
		end

	yy_acclist_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  114,   70,  114,  114,  114,   76,  114,  113,  114,  113,
			  114,  114,  114,  113,  114,  114,  113,  114,  113,  114,
			  113,  114,   84,  113,  114,  114,  114,  114,   84,  114,
			  113,  114,  114,  113,  114,  114,  113,  114,  113,  114,
			  113,  114,  114,  114,  114,  113,  114,  113,  114,  114,
			  114,  113,  114,  114,  113,  114,  113,  114,  114,  114,
			  113,  114,  114,  113,  114,  114,   22,  115,  148,  148,
			  148,  148,  148,  148,  148,  148,  148,  143,  144,  148,
			  148,  142,  141,  148,  148,  148,  148,  148,  148,  148,
			  148,  148,  148,  148,  148,  148,  148,  148, -140,  139,

			  116,  139,  139,  139,  139,  139,  139,  139,  139,  139,
			  139,  139,  139,  139,  139,  139,  139,  139,  139,  139,
			  139,  139,  139,  139,  139,  139,  139,  139,  139,  139,
			  139,  139,  139,  139,  139,  139,  139,  160,  163,  158,
			  160,  163,  158,  150,  157,  153,  156,  157,  156,  157,
			  152,  155,  157,  155,  157,  151,  154,  157,  154,  157,
			  150,  157,  113,  114,  114,  113,  114,  114,  113,  114,
			   45,  113,  114,  114,   45,  114,   46,  113,  114,   46,
			  114,  113,  114,  114,  113,  114,  114,   49,  113,  114,
			   49,  114,  113,  114,  114,  113,  114,  114,  113,  114, yy_Dummy>>,
			1, 200, 400)
		end

	yy_acclist_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  114,  113,  114,  114,  113,  114,  114,  113,  114,  113,
			  114,  113,  114,  114,  114,  114,  113,  114,  114,   61,
			  113,  114,  113,  114,   61,  114,  114,  113,  114,  113,
			  114,  114,  114,  113,  114,  114,  113,  114,  114,  113,
			  114,  114,  113,  114,  114,  113,  114,  113,  114,  113,
			  114,  113,  114,  113,  114,  114,  114,  114,  114,  114,
			  113,  114,  114,  113,  114,  113,  114,  114,  114,   80,
			  113,  114,   80,  114,  113,  114,  114,   82,  113,  114,
			   82,  114,  113,  114,  114,  113,  114,  114,  113,  114,
			  113,  114,  113,  114,  113,  114,  113,  114,  113,  114,

			  114,  114,  114,  114,  114,  114,  113,  114,  113,  114,
			  114,  114,  113,  114,  114,  113,  114,  114,  113,  114,
			  114,  113,  114,  114,  113,  114,  113,  114,  113,  114,
			  114,  114,  114,  113,  114,  114,  113,  114,  114,  113,
			  114,  114,  105,  113,  114,  105,  114,  165,  164,   19,
			  115,   20,  115,  148,  148,  148,  148,  148,  148,  148,
			  148,  148,  148,  139,  139,  139,  139,  139,  139,  139,
			  133,  131,  132,  134,  135,  139,  136,  137,  117,  118,
			  119,  120,  121,  122,  123,  124,  125,  126,  127,  128,
			  129,  130,  139,  139,  139,  160,  163,  160,  163,  160, yy_Dummy>>,
			1, 200, 600)
		end

	yy_acclist_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  163,  159,  162,  150,  157,  150,  157,  150,  157,  113,
			  114,  114,  113,  114,  114,  113,  114,  114,  113,  114,
			  114,  113,  114,  113,  114,  114,  114,  113,  114,  114,
			  113,  114,  114,  113,  114,  114,  113,  114,  114,  113,
			  114,  114,  113,  114,  114,  113,  114,  114,  113,  114,
			  114,   59,  113,  114,   59,  114,  113,  114,  114,  113,
			  114,  113,  114,  114,  114,  113,  114,  114,  113,  114,
			  114,  113,  114,  114,   68,  113,  114,  113,  114,   68,
			  114,  114,  113,  114,  114,  113,  114,  114,  113,  114,
			  114,  113,  114,  114,  113,  114,  114,  113,  114,  114,

			   77,  113,  114,   77,  114,  113,  114,  114,   79,  113,
			  114,   79,  114,  110,  113,  114,  110,  114,  113,  114,
			  114,   83,  113,  114,   83,  114,  113,  114,  113,  114,
			  114,  114,  113,  114,  114,  113,  114,  114,  113,  114,
			  114,  113,  114,  114,  113,  114,  113,  114,  114,  114,
			  113,  114,  114,  113,  114,  114,  113,  114,  114,  111,
			  113,  114,  111,  114,  113,  114,  114,   97,  113,  114,
			   97,  114,   98,  113,  114,   98,  114,  113,  114,  114,
			  113,  114,  114,  113,  114,  114,  113,  114,  114,  103,
			  113,  114,  103,  114,  104,  113,  114,  104,  114,  148, yy_Dummy>>,
			1, 200, 800)
		end

	yy_acclist_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  148,  148,  139,  139,  139,  139,  160,  160,  163,  160,
			  163,  159,  160,  162,  163,  159,  162,  150,  157,  113,
			  114,  114,   43,  113,  114,   43,  114,   44,  113,  114,
			   44,  114,  113,  114,  114,  113,  114,  114,  113,  114,
			  114,   50,  113,  114,   50,  114,   51,  113,  114,   51,
			  114,  113,  114,  114,  113,  114,  114,  113,  114,  114,
			   56,  113,  114,   56,  114,  113,  114,  114,  113,  114,
			  114,  113,  114,  114,  113,  114,  114,  113,  114,  114,
			  113,  114,  114,  113,  114,  114,   66,  113,  114,   66,
			  114,  113,  114,  114,  113,  114,  114,  113,  114,  114,

			  113,  114,  114,   72,  113,  114,   72,  114,  113,  114,
			  114,  113,  114,  114,  113,  114,  114,   78,  113,  114,
			   78,  114,  113,  114,  114,  113,  114,  114,  113,  114,
			  114,  113,  114,  114,  113,  114,  114,  113,  114,  114,
			  113,  114,  114,  113,  114,  114,  113,  114,  114,   93,
			  113,  114,   93,  114,  113,  114,  114,  113,  114,  114,
			   96,  113,  114,   96,  114,  113,  114,  114,  113,  114,
			  114,  101,  113,  114,  101,  114,  113,  114,  114,  138,
			  160,  163,  163,  160,  159,  160,  162,  163,  159,  162,
			  158,  106,  113,  114,  106,  114,   48,  113,  114,   48, yy_Dummy>>,
			1, 200, 1000)
		end

	yy_acclist_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  114,  113,  114,  114,  113,  114,  114,  113,  114,  114,
			   53,  113,  114,  113,  114,   53,  114,  114,  113,  114,
			  114,  113,  114,  114,  113,  114,  114,   60,  113,  114,
			   60,  114,   62,  113,  114,   62,  114,  113,  114,  114,
			   64,  113,  114,   64,  114,  113,  114,  114,  113,  114,
			  114,   69,  113,  114,   69,  114,  113,  114,  114,  113,
			  114,  114,  113,  114,  114,  113,  114,  114,  113,  114,
			  114,  113,  114,  114,  113,  114,  114,   86,  113,  114,
			   86,  114,  113,  114,  114,  113,  114,  114,   89,  113,
			  114,   89,  114,  113,  114,  114,   91,  113,  114,   91,

			  114,   92,  113,  114,   92,  114,   94,  113,  114,   94,
			  114,  113,  114,  114,  113,  114,  114,  100,  113,  114,
			  100,  114,  113,  114,  114,  160,  159,  160,  162,  163,
			  163,  159,  161,  163,  161,  113,  114,  114,  113,  114,
			  114,   52,  113,  114,   52,  114,  113,  114,  114,   55,
			  113,  114,   55,  114,  113,  114,  114,  113,  114,  114,
			  113,  114,  114,  113,  114,  114,   67,  113,  114,   67,
			  114,   71,  113,  114,   71,  114,  113,  114,  114,   73,
			  113,  114,   73,  114,   74,  113,  114,   74,  114,  113,
			  114,  114,  113,  114,  114,  113,  114,  114,  113,  114, yy_Dummy>>,
			1, 200, 1200)
		end

	yy_acclist_template_8 (an_array: ARRAY [INTEGER])
			-- Fill chunk #8 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  114,  113,  114,  114,   90,  113,  114,   90,  114,  113,
			  114,  114,  113,  114,  114,  102,  113,  114,  102,  114,
			  163,  163,  159,  160,  162,  163,  162,  107,  113,  114,
			  107,  114,  113,  114,  114,   54,  113,  114,   54,  114,
			   57,  113,  114,   57,  114,  113,  114,  114,   63,  113,
			  114,   63,  114,   65,  113,  114,   65,  114,  112,  113,
			  114,  112,  114,  113,  114,  114,   81,  113,  114,   81,
			  114,  113,  114,  114,   88,  113,  114,   88,  114,  113,
			  114,  114,   95,  113,  114,   95,  114,   99,  113,  114,
			   99,  114,  163,  162,  163,  162,  163,  162,  108,  113,

			  114,  108,  114,  113,  114,  114,   75,  113,  114,   75,
			  114,   85,  113,  114,   85,  114,   87,  113,  114,   87,
			  114,  162,  163,  109,  113,  114,  109,  114, yy_Dummy>>,
			1, 128, 1400)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER = 6964
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER = 1015
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER = 1016
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
	copyright:	"Copyright (c) 1984-2019, Eiffel Software"
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

end
