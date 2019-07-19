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
					
when 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103 then
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
								
when 104, 105, 106, 107, 108, 109 then
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
						
when 110 then
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

				-- Verbatim string closer, possibly.
			curr_token := new_string (text)						
			end_of_verbatim_string := True
			in_verbatim_string := False
			set_start_condition (INITIAL)
			update_token_list
		
when 140 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

			curr_token := new_space (text_count)
			update_token_list						
		
when 141 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

			curr_token := new_tabulation (text_count)
			update_token_list						
		
when 142 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

			curr_token := new_eol (True)
			update_token_list
			in_comments := False
		
when 143 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

			curr_token := new_eol (False)
			update_token_list
			in_comments := False
		
when 144 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

			curr_token := new_text (text)
			update_token_list
		
when 145 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

			curr_token := new_string (text)
			update_token_list
		
when 146 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

			curr_token := new_string (text)
			update_token_list
		
when 147 then
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
	
when 148, 149, 150, 151 then
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
	
when 152, 153, 154, 155 then
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
	
when 156 then
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
	
when 157, 158 then
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
	
when 162, 163 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

		curr_token := new_text_in_comment (text)
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
			-- Template for `yy_nxt'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 7984)
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
			   78,    6,    6,    6,   79,   80,   81,   82,   83,   84,

			   85,   86,   88,   89,   90,   91,  159,   92,  139,  141,
			  849,  142,  142,  142,  142,   88,   89,   90,   91,  140,
			   92,  143,  146, 1046,  147,  147,  147,  147,  743,  144,
			  154,  155,  156,  157,  107,  251,  159,  108,  166,  736,
			  183,  159,  107,  159,  184,  108,  129,  185,  129,  129,
			  186,  119,  231,  187,  130,  217,  275,  275,   93,  277,
			  277,  218,  399,  399,  152,  374,  595,  252,  166,  401,
			  401,   93,  188,  166,  159,  166,  189,  515,  515,  190,
			  375,  375,  191,  109,  232,  192,  593,  219,  591,   93,
			  517,  517,  145,  220,   94,   95,   96,   97,   98,   99, yy_Dummy>>,
			1, 200, 0)
		end

	yy_nxt_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  100,  101,   93,  159,  159,  159,  166,   94,   95,   96,
			   97,   98,   99,  100,  101,  109,  274,  274,  274,  595,
			  374,  110,  111,  112,  113,  114,  115,  116,  117,  120,
			  121,  122,  123,  124,  125,  126,  127,  593,  131,  132,
			  133,  134,  135,  136,  137,  138,  146,  159,  147,  147,
			  147,  147,  591,  221,  193,  159,  557,  159,  159,  149,
			  150,  159,  159,  181,  194,  197,  159,  198,  159,  387,
			  159,  233,  388,  159,  159,  159,  253,  199,  519,  166,
			 1046,  151,  276,  276,  276,  222,  195,  166,  152,  166,
			  166,  149,  150,  166,  166,  182,  196,  200,  166,  201,

			  166,  389,  166,  234,  390,  166,  166,  166,  254,  202,
			  278,  278,  278,  151,  159,  159,  159,  159,  159,  159,
			  159,  159,  374,  245,  159,  159,  160,  159,  159,  159,
			  161,  159,  159,  159,  159,  162,  159,  163,  159,  159,
			  159,  159,  164,  165,  159,  159,  159,  159,  159,  159,
			  166,  398,  398,  398,  159,  246,  166,  166,  167,  166,
			  166,  166,  168,  166,  166,  166,  166,  169,  166,  170,
			  166,  166,  166,  166,  171,  172,  166,  166,  166,  166,
			  166,  166,  146,  513,  373,  373,  373,  373,  173,  174,
			  175,  176,  177,  178,  179,  180,  203,  403,  209,  397, yy_Dummy>>,
			1, 200, 200)
		end

	yy_nxt_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  204,  159,  223,  159,  159,  210,  211,  241,  159,  159,
			  159,  212,  224,  205,  225,  247,  235,  242,  226,  383,
			  159,  385,  391,  159,  152,  159,  236,  159,  206,  248,
			  213,  237,  207,  166,  227,  166,  166,  214,  215,  243,
			  166,  166,  166,  216,  228,  208,  229,  249,  238,  244,
			  230,  384,  166,  386,  392,  166,  329,  166,  239,  166,
			  312,  250,  104,  240,  257,  258,  259,  260,  261,  262,
			  263,  264,  167,  166,  406,  166,  168,  195,  159,  159,
			  166,  169,  159,  170,  166,  166,  182,  196,  171,  172,
			  166,  159,  393,  166,  281,  282,  283,  284,  285,  286,

			  287,  288,  102,  279,  167,  166,  407,  166,  168,  195,
			  166,  166,  166,  169,  166,  170,  166,  166,  182,  196,
			  171,  172,  166,  166,  394,  166,  281,  282,  283,  284,
			  285,  286,  287,  288,  265,  266,  267,  268,  269,  270,
			  271,  272,  265,  266,  267,  268,  269,  270,  271,  272,
			  188,  159,  166,  159,  189,  159,  200,  190,  201,  166,
			  191,  422,  166,  192,  395,  166,  404,  498,  202,  305,
			  281,  282,  283,  284,  285,  286,  287,  288,  377,  377,
			  377,  273,  188,  166,  166,  166,  189,  166,  200,  190,
			  201,  166,  191,  423,  166,  192,  396,  166,  405,  499, yy_Dummy>>,
			1, 200, 400)
		end

	yy_nxt_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  202,  289,  255,  290,  290,  158,  153,  265,  266,  267,
			  268,  269,  270,  271,  272,  206,  213,  105,  374,  207,
			  159,  159,  166,  214,  215,  104,  166,  436,  166,  216,
			  219,  103,  208,  166,  166,  166,  220,  166,  166,  166,
			  222,  400,  400,  400,  102,  166, 1046,  206,  213,  166,
			 1046,  207,  166,  166,  166,  214,  215,  291,  166,  437,
			  166,  216,  219,  227,  208,  166,  166,  166,  220,  166,
			  166,  166,  222,  228,  166,  229,  166,  166,  159,  230,
			  232,  166,  234,  238,  159,  166,  166,  414,  291,  166,
			  166,  166,  166,  239, 1046,  227, 1046, 1046,  240, 1046,

			 1046,  166,  166, 1046, 1046,  228,  166,  229,  166, 1046,
			  166,  230,  232, 1046,  234,  238,  166,  166,  166,  415,
			 1046,  166,  166,  166,  166,  239,  166,  159,  246,  249,
			  240,  243,  410,  166,  166,  166,  159,  166,  166,  432,
			  166,  244,  166,  250,  402,  402,  402,  166,  290,  252,
			  290,  295,  166,  166,  166,  166,  166,  254,  166,  166,
			  246,  249, 1046,  243,  411,  166,  166,  166,  166,  166,
			  166,  433,  166,  244,  166,  250,  166,  166,  166,  166,
			 1046,  252,  375,  375,  166,  166,  166,  166,  166,  254,
			  290,  292,  293,  290,  514,  514,  514,  166,  166, 1046, yy_Dummy>>,
			1, 200, 600)
		end

	yy_nxt_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  291,  604, 1046,  291,  291,  296, 1046, 1046,  280,  306,
			  306,  306,  281,  282,  283,  284,  285,  286,  287,  288,
			  307,  307,  590,  281,  282,  283,  284,  285,  286,  287,
			  288,  107, 1046,  605,  108,  291,  309,  309,  281,  282,
			  283,  284,  285,  286,  287,  288,  294,  308,  308,  308,
			  281,  282,  283,  284,  285,  286,  287,  288,  310,  310,
			  310,  281,  282,  283,  284,  285,  286,  287,  288,  516,
			  516,  516, 1046,  313, 1046,  313,  313,  294,  107, 1046,
			  109,  108,  281,  282,  283,  284,  285,  286,  287,  288,
			 1046, 1046,  297,  298,  299,  300,  301,  302,  303,  304,

			  311,  159, 1046,  281,  282,  283,  284,  285,  286,  287,
			  288,  107,  109, 1046,  108,  518,  518,  518,  110,  111,
			  112,  113,  114,  115,  116,  117,  107,  109, 1046,  108,
			  159,  159,  159,  166,  367,  367,  367,  367, 1046, 1046,
			  107, 1046, 1046,  108,  381,  381,  381,  381,  368,  371,
			  371,  371,  371,  159,  408,  159,  159,  159, 1046,  109,
			  109,  107,  159,  372,  108,  110,  111,  112,  113,  114,
			  115,  116,  117,  107,  369,  109,  108,  159,  159,  159,
			  368,  159,  159,  159,  382,  166,  409,  107, 1046,  109,
			  108,  651,  109, 1046,  166,  372, 1046, 1046,  110,  111, yy_Dummy>>,
			1, 200, 800)
		end

	yy_nxt_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  112,  113,  114,  115,  116,  117, 1046,  109,  107, 1046,
			  109,  108,  314,  110,  111,  112,  113,  114,  115,  116,
			  117,  109, 1046,  652,  315,  315,  315,  110,  111,  112,
			  113,  114,  115,  116,  117,  107,  109,  159,  108,  520,
			  520,  520,  109, 1046, 1046,  316,  316, 1046,  110,  111,
			  112,  113,  114,  115,  116,  117,  107,  109, 1046,  108,
			  120,  121,  122,  123,  124,  125,  126,  127,  109,  166,
			 1046,  317,  317,  317,  110,  111,  112,  113,  114,  115,
			  116,  117,  107,  695,  109,  108,  521,  521,  521,  109,
			  522,  522,  522,  318,  318,  110,  111,  112,  113,  114,

			  115,  116,  117,  107,  705,  109,  108,  159, 1046,  450,
			  541,  541,  541,  541,  107,  696,  109,  108, 1046,  319,
			  319,  319,  110,  111,  112,  113,  114,  115,  116,  117,
			  107,  412, 1046,  108,  707,  159,  706,  109, 1046,  166,
			  320,  451,  329,  110,  111,  112,  113,  114,  115,  116,
			  117,  107, 1046, 1046,  108,  583,  583,  583,  583, 1046,
			 1046,  107, 1046,  413,  108, 1046,  708,  166, 1046,  120,
			  121,  122,  123,  124,  125,  126,  127,  107,  159,  460,
			  108,  159,  159,  159,  159,  159,  159,  159, 1046,  321,
			  120,  121,  122,  123,  124,  125,  126,  127,  322,  322, yy_Dummy>>,
			1, 200, 1000)
		end

	yy_nxt_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  322,  120,  121,  122,  123,  124,  125,  126,  127,  107,
			  166,  461,  108, 1046,  323,  323,  166,  120,  121,  122,
			  123,  124,  125,  126,  127,  330,  331,  332,  333,  334,
			  335,  336,  337, 1046, 1046,  324,  324,  324,  120,  121,
			  122,  123,  124,  125,  126,  127,  325,  325,  120,  121,
			  122,  123,  124,  125,  126,  127,  159,  159,  159,  756,
			 1046,  326,  326,  326,  120,  121,  122,  123,  124,  125,
			  126,  127,  329,  159,  424,  159,  159,  159, 1046,  159,
			  434,  329,  464,  159, 1046,  488,  159, 1046,  159,  425,
			  428,  757,  329,  327,  429, 1046,  120,  121,  122,  123,

			  124,  125,  126,  127,  338,  166,  426,  339,  340,  341,
			  342,  166,  435, 1046,  465,  166,  343,  489,  166,  329,
			  166,  427,  430,  344, 1046,  345,  431,  346,  347,  348,
			  349,  329,  350, 1046,  351,  610,  610,  610,  352, 1046,
			  353,  329, 1046,  354,  355,  356,  357,  358,  359,  377,
			  377,  377,  128,  128,  128,  330,  331,  332,  333,  334,
			  335,  336,  337,  360,  330,  331,  332,  333,  334,  335,
			  336,  337,  361,  361,  361,  330,  331,  332,  333,  334,
			  335,  336,  337,  329,  611,  611,  611, 1046, 1046,  592,
			 1046,  330,  331,  332,  333,  334,  335,  336,  337,  362, yy_Dummy>>,
			1, 200, 1200)
		end

	yy_nxt_template_8 (an_array: ARRAY [INTEGER])
			-- Fill chunk #8 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  362,  329,  330,  331,  332,  333,  334,  335,  336,  337,
			 1046,  363,  363,  363,  330,  331,  332,  333,  334,  335,
			  336,  337,  364,  364,  330,  331,  332,  333,  334,  335,
			  336,  337,  281,  282,  283,  284,  285,  286,  287,  288,
			 1046, 1046,  462,  159,  159,  774,  159,  478,  159, 1046,
			  438,  479,  281,  282,  283,  284,  285,  286,  287,  288,
			  612,  612,  612,  365,  365,  365,  330,  331,  332,  333,
			  334,  335,  336,  337,  463,  166,  166,  775,  166,  480,
			  166,  366,  439,  481,  330,  331,  332,  333,  334,  335,
			  336,  337,  379,  379,  379,  379,  166, 1046,  166,  166,

			  166,  166,  379,  379,  379,  379,  379,  379,  166,  166,
			  386,  166, 1046, 1046,  159,  384, 1046,  166, 1046,  166,
			 1046,  166, 1046, 1046,  458,  166,  166,  166,  166,  166,
			  166, 1046,  374, 1046,  379,  379,  379,  379,  379,  379,
			  166,  166,  386,  166,  392,  389,  166,  384,  390,  166,
			  166,  166,  166,  166,  166,  166,  459,  166,  159, 1046,
			  166,  166,  394,  166,  166,  166,  166,  166,  166, 1046,
			  623,  396,  407,  790,  405,  166,  392,  389,  166,  166,
			  390,  166,  166, 1046,  166, 1046,  166,  166,  159,  166,
			  166,  166,  166, 1046,  394,  166,  166,  166,  166,  166, yy_Dummy>>,
			1, 200, 1400)
		end

	yy_nxt_template_9 (an_array: ARRAY [INTEGER])
			-- Fill chunk #9 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  166,  409,  624,  396,  407,  791,  405,  166, 1046,  413,
			  166,  166,  166,  166,  166,  166,  166,  411,  166,  166,
			  166,  166,  416,  166,  166,  415,  417,  166,  166,  159,
			  159,  166, 1046,  409,  482,  166,  166,  166, 1046, 1046,
			  418,  413, 1046,  166,  166,  166,  166,  166,  166,  411,
			  166,  166, 1046,  166,  419,  166,  166,  415,  420,  166,
			  166,  166,  166,  166,  419, 1046,  483, 1046,  420, 1046,
			  159,  166,  421,  166,  166,  166,  166,  166,  423,  159,
			  159,  456,  421,  166,  426, 1046,  166,  166,  484,  166,
			  159,  166,  166,  430,  166,  600,  419,  431, 1046,  427,

			  420,  166,  166,  166,  166,  166,  166,  433,  166,  166,
			  423,  166,  166,  457,  421,  166,  426,  435,  166,  166,
			  485,  166,  166,  166,  166,  430,  166,  601,  166,  431,
			  166,  427,  166,  166,  166,  437,  166, 1046,  486,  433,
			  166,  166,  159,  440,  166,  441,  602,  442,  159,  435,
			  159,  166,  500,  166,  159,  166,  159, 1046,  443,  496,
			  166,  444,  166, 1046,  166,  166,  166,  437,  159,  166,
			  487,  166,  166,  439,  166,  445,  166,  446,  603,  447,
			  166,  166,  166,  452,  501,  166,  166,  166,  166,  159,
			  448,  497, 1046,  449,  166,  453,  166,  166,  159,  159, yy_Dummy>>,
			1, 200, 1600)
		end

	yy_nxt_template_10 (an_array: ARRAY [INTEGER])
			-- Fill chunk #10 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  166,  166, 1046,  166,  598,  439,  166,  451,  166, 1046,
			  166,  159,  617,  166,  445,  454,  446, 1046,  447, 1046,
			  166,  166,  166,  631,  166, 1046,  166,  455,  166,  448,
			  166,  166,  449,  166,  166,  166,  599, 1046,  166,  451,
			  166,  457,  166,  166,  618,  166,  445,  159,  446,  461,
			  447,  454,  166, 1046,  166,  632,  166,  166,  641,  166,
			  166,  448,  166,  455,  449,  166,  166,  166,  166,  166,
			  166, 1046,  166,  457, 1046,  459,  463,  166, 1046,  166,
			  166,  461, 1046,  454,  166,  166,  166,  166, 1046,  166,
			  642,  166,  166, 1046,  166,  455,  166,  166,  490, 1046,

			  166,  166,  166,  491,  166, 1046,  465,  459,  463,  166,
			  166,  166,  166,  166,  492,  166,  166,  166,  166,  166,
			  480,  466,  166,  467,  481,  166,  159, 1046,  166,  166,
			  493,  468,  166,  159,  469,  494,  470,  471,  465,  716,
			  716,  716,  502, 1046,  159,  166,  495,  166,  580,  580,
			  580,  580,  480,  472,  166,  473,  481,  166,  166,  166,
			  483,  166,  368,  474,  166,  166,  475, 1046,  476,  477,
			  472,  166,  473,  613,  503,  166,  166,  166,  166,  159,
			  474,  485, 1046,  475, 1046,  476,  477,  166,  369,  487,
			  166,  166,  483,  166,  368, 1046,  166,  289,  166,  290, yy_Dummy>>,
			1, 200, 1800)
		end

	yy_nxt_template_11 (an_array: ARRAY [INTEGER])
			-- Fill chunk #11 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  290, 1046,  472,  166,  473,  614,  808,  166,  166,  166,
			  166,  166,  474,  485,  166,  475,  166,  476,  477,  166,
			  625,  487,  166,  489,  159, 1046,  166,  493,  166, 1046,
			  166,  290,  494,  290,  290,  166, 1046,  166,  809,  166,
			  166,  166, 1046,  495, 1046,  497,  166,  166,  166,  504,
			 1046,  166,  626,  291,  159,  489,  166,  499,  166,  493,
			  166,  501,  166,  504,  494, 1046,  681,  166,  166,  166,
			  166,  166,  166,  166,  504,  495,  166,  497,  166,  166,
			  166, 1046,  503,  166,  291,  816,  166,  291,  166,  499,
			  504, 1046,  166,  501,  166,  717,  717,  717,  682,  505,

			  166, 1046,  166, 1046,  166,  504, 1046, 1046,  166, 1046,
			  166, 1046,  166,  505,  503, 1046,  504,  817,  291, 1046,
			  166,  581,  159,  581,  505, 1046,  582,  582,  582,  582,
			 1046,  504,  257,  258,  259,  260,  261,  262,  263,  264,
			  505,  718,  718,  718,  375,  375,  257,  258,  259,  260,
			  261,  262,  263,  264,  166,  505,  506,  257,  258,  259,
			  260,  261,  262,  263,  264, 1046,  505,  159,  159,  159,
			  507,  507,  507,  257,  258,  259,  260,  261,  262,  263,
			  264,  505,  504, 1046,  590,  508,  508, 1046,  257,  258,
			  259,  260,  261,  262,  263,  264,  509,  509,  509,  257, yy_Dummy>>,
			1, 200, 2000)
		end

	yy_nxt_template_12 (an_array: ARRAY [INTEGER])
			-- Fill chunk #12 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  258,  259,  260,  261,  262,  263,  264,  504,  159,  159,
			  159, 1046,  510,  510,  257,  258,  259,  260,  261,  262,
			  263,  264,  305,  281,  282,  283,  284,  285,  286,  287,
			  288, 1046,  505,  306,  306,  306,  281,  282,  283,  284,
			  285,  286,  287,  288,  307,  307,  296,  281,  282,  283,
			  284,  285,  286,  287,  288, 1046, 1046,  505,  159,  159,
			  159, 1046,  511,  511,  511,  257,  258,  259,  260,  261,
			  262,  263,  264,  308,  308,  308,  281,  282,  283,  284,
			  285,  286,  287,  288, 1046, 1046,  290,  512,  293,  290,
			  257,  258,  259,  260,  261,  262,  263,  264,  309,  309,

			  281,  282,  283,  284,  285,  286,  287,  288,  310,  310,
			  310,  281,  282,  283,  284,  285,  286,  287,  288,  311,
			  159, 1046,  281,  282,  283,  284,  285,  286,  287,  288,
			  377,  377,  377,  523,  524,  525,  526,  527,  528,  529,
			  530,  291,  294, 1046,  291,  290,  296,  290,  295,  280,
			  291, 1046,  166,  291, 1046,  296,  159, 1046,  280,  291,
			  159,  159,  291,  619,  296, 1046,  615,  280, 1046,  291,
			  592,  159,  291,  294,  296,  792, 1046,  280,  281,  282,
			  283,  284,  285,  286,  287,  288,  291, 1046,  166,  291,
			 1046,  296,  166,  166,  280,  620, 1046,  291,  616, 1046, yy_Dummy>>,
			1, 200, 2200)
		end

	yy_nxt_template_13 (an_array: ARRAY [INTEGER])
			-- Fill chunk #13 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  291,  291,  296,  166, 1046,  280, 1046,  793,  291,  159,
			 1046,  291, 1046,  296, 1046, 1046,  280, 1046, 1046,  291,
			 1046, 1046,  291,  587,  296,  587, 1046,  280,  588,  588,
			  588,  588,  291,  297,  298,  299,  300,  301,  302,  303,
			  304,  166,  297,  298,  299,  300,  301,  302,  303,  304,
			  531,  297,  298,  299,  300,  301,  302,  303,  304,  535,
			  535,  297,  298,  299,  300,  301,  302,  303,  304,  119,
			  729,  729,  729,  729, 1046,  532,  532,  532,  297,  298,
			  299,  300,  301,  302,  303,  304,  533,  533,  159,  297,
			  298,  299,  300,  301,  302,  303,  304,  534,  534,  534,

			  297,  298,  299,  300,  301,  302,  303,  304,  536,  536,
			  536,  297,  298,  299,  300,  301,  302,  303,  304,  291,
			  166, 1046,  291, 1046,  296, 1046, 1046,  280,  281,  282,
			  283,  284,  285,  286,  287,  288,  281,  282,  283,  284,
			  285,  286,  287,  288,  281,  282,  283,  284,  285,  286,
			  287,  288,  281,  282,  283,  284,  285,  286,  287,  288,
			  538,  538,  538,  281,  282,  283,  284,  285,  286,  287,
			  288,  539,  539,  539,  281,  282,  283,  284,  285,  286,
			  287,  288,  540,  540,  540,  281,  282,  283,  284,  285,
			  286,  287,  288,  313, 1046,  313,  313, 1046,  107, 1046, yy_Dummy>>,
			1, 200, 2400)
		end

	yy_nxt_template_14 (an_array: ARRAY [INTEGER])
			-- Fill chunk #14 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  146,  108,  589,  589,  589,  589, 1046, 1046,  537, 1046,
			 1046,  297,  298,  299,  300,  301,  302,  303,  304,  107,
			 1046,  627,  108, 1046,  584,  584,  584,  584,  166,  159,
			  166,  599, 1046,  107, 1046,  629,  108, 1046,  585,  159,
			  166, 1046,  152,  596,  596,  596,  596,  109,  107, 1046,
			 1046,  108, 1046,  628,  597,  597,  597,  597, 1046, 1046,
			  166,  166,  166,  599,  586, 1046,  107,  630,  109,  108,
			  585,  166,  166,  582,  582,  582,  582, 1046, 1046,  109,
			 1046,  107,  109,  382,  108,  110,  111,  112,  113,  114,
			  115,  116,  117, 1046,  382,  107, 1046,  109,  108, 1046,

			  109,  737,  737,  737,  737, 1046,  110,  111,  112,  113,
			  114,  115,  116,  117,  109,  109,  159,  159,  159,  647,
			  110,  111,  112,  113,  114,  115,  116,  117,  107,  109,
			  109,  108,  159,  159,  159,  110,  111,  112,  113,  114,
			  115,  116,  117,  107,  109, 1046,  108,  109,  166,  166,
			  166,  648, 1046,  110,  111,  112,  113,  114,  115,  116,
			  117,  107,  109, 1046,  108,  542,  542,  542,  110,  111,
			  112,  113,  114,  115,  116,  117,  109,  109, 1046,  543,
			  543,  543,  110,  111,  112,  113,  114,  115,  116,  117,
			  107, 1046,  637,  108, 1046,  166,  159,  601,  107, 1046, yy_Dummy>>,
			1, 200, 2600)
		end

	yy_nxt_template_15 (an_array: ARRAY [INTEGER])
			-- Fill chunk #15 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			 1046,  108,  735,  735,  735,  735, 1046,  166, 1046,  109,
			 1046,  159,  544,  544,  544,  110,  111,  112,  113,  114,
			  115,  116,  117,  107,  638,  159,  108,  166,  166,  601,
			  120,  121,  122,  123,  124,  125,  126,  127,  107,  166,
			  649,  108,  736,  166,  159,  159,  159,  159,  120,  121,
			  122,  123,  124,  125,  126,  127,  107,  166, 1046,  108,
			 1046,  330,  331,  332,  333,  334,  335,  336,  337, 1046,
			  653,  752,  650,  159,  159, 1046,  166,  120,  121,  122,
			  123,  124,  125,  126,  127,  120,  121,  122,  123,  124,
			  125,  126,  127,  330,  331,  332,  333,  334,  335,  336,

			  337, 1046,  654,  753, 1046,  166,  166,  545,  545,  545,
			  120,  121,  122,  123,  124,  125,  126,  127, 1046,  159,
			  159,  159,  546,  546,  546,  120,  121,  122,  123,  124,
			  125,  126,  127, 1046,  659,  166,  166,  166,  159, 1046,
			  547,  547,  547,  120,  121,  122,  123,  124,  125,  126,
			  127,  548,  330,  331,  332,  333,  334,  335,  336,  337,
			 1046,  159,  159,  159,  758,  643,  660,  739, 1046,  739,
			  166, 1046,  740,  740,  740,  740, 1046, 1046,  644,  555,
			  159,  549,  549,  549,  330,  331,  332,  333,  334,  335,
			  336,  337, 1046,  166,  166,  166,  759,  645,  550,  550, yy_Dummy>>,
			1, 200, 2800)
		end

	yy_nxt_template_16 (an_array: ARRAY [INTEGER])
			-- Fill chunk #16 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  556,  330,  331,  332,  333,  334,  335,  336,  337,  558,
			  646, 1046,  166,  551,  551,  551,  330,  331,  332,  333,
			  334,  335,  336,  337,  559,  741,  741,  741,  741,  166,
			  166,  166,  561,  588,  588,  588,  588,  166,  166,  166,
			  562,  552,  552,  330,  331,  332,  333,  334,  335,  336,
			  337,  553,  553,  553,  330,  331,  332,  333,  334,  335,
			  336,  337,  330,  331,  332,  333,  334,  335,  336,  337,
			  563, 1046,  554,  859,  159,  330,  331,  332,  333,  334,
			  335,  336,  337,  330,  331,  332,  333,  334,  335,  336,
			  337, 1046,  330,  331,  332,  333,  334,  335,  336,  337,

			  560,  560,  560,  560,  564,  860,  166,  330,  331,  332,
			  333,  334,  335,  336,  337,  330,  331,  332,  333,  334,
			  335,  336,  337,  330,  331,  332,  333,  334,  335,  336,
			  337,  565,  159,  159,  665,  891,  159, 1046,  159,  566,
			  655,  621, 1046,  742,  742,  742,  742,  567,  845,  845,
			  845,  845,  822,  330,  331,  332,  333,  334,  335,  336,
			  337,  568, 1046, 1046,  166,  166,  666,  892,  166,  569,
			  166, 1046,  656,  622,  330,  331,  332,  333,  334,  335,
			  336,  337,  570,  743,  823, 1046, 1046,  330,  331,  332,
			  333,  334,  335,  336,  337,  571, 1046,  744, 1046,  589, yy_Dummy>>,
			1, 200, 3000)
		end

	yy_nxt_template_17 (an_array: ARRAY [INTEGER])
			-- Fill chunk #17 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  589,  589,  589,  572,  846,  846,  846,  846,  768,  159,
			  159,  573, 1046, 1046,  330,  331,  332,  333,  334,  335,
			  336,  337,  330,  331,  332,  333,  334,  335,  336,  337,
			  330,  331,  332,  333,  334,  335,  336,  337,  574,  382,
			  769,  166,  166,  893,  330,  331,  332,  333,  334,  335,
			  336,  337,  330,  331,  332,  333,  334,  335,  336,  337,
			  575,  740,  740,  740,  740,  330,  331,  332,  333,  334,
			  335,  336,  337,  576,  159,  894,  897,  802,  330,  331,
			  332,  333,  334,  335,  336,  337,  330,  331,  332,  333,
			  334,  335,  336,  337,  330,  331,  332,  333,  334,  335,

			  336,  337, 1046,  669,  873,  159,  166,  159,  898,  803,
			  159, 1046, 1046, 1046,  745,  745,  745,  745, 1046, 1046,
			  639,  330,  331,  332,  333,  334,  335,  336,  337, 1046,
			 1046, 1046, 1046,  657,  675,  670,  874,  166,  159,  166,
			 1046,  159,  166,  330,  331,  332,  333,  334,  335,  336,
			  337, 1046,  640, 1046,  382, 1046,  330,  331,  332,  333,
			  334,  335,  336,  337, 1046,  658,  676, 1046, 1046, 1046,
			  166, 1046,  677,  166,  159, 1046,  159,  119,  841,  841,
			  841,  841,  128,  128,  128,  330,  331,  332,  333,  334,
			  335,  336,  337,  128,  128,  128,  330,  331,  332,  333, yy_Dummy>>,
			1, 200, 3200)
		end

	yy_nxt_template_18 (an_array: ARRAY [INTEGER])
			-- Fill chunk #18 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  334,  335,  336,  337,  678, 1046,  166, 1046,  166,  128,
			  128,  128,  330,  331,  332,  333,  334,  335,  336,  337,
			  128,  128,  128,  330,  331,  332,  333,  334,  335,  336,
			  337,  577,  577,  577,  330,  331,  332,  333,  334,  335,
			  336,  337,  905, 1046,  578,  578,  578,  330,  331,  332,
			  333,  334,  335,  336,  337,  579,  579,  579,  330,  331,
			  332,  333,  334,  335,  336,  337,  379,  379,  379,  379,
			 1046,  603,  159,  166,  906,  166,  379,  379,  379,  379,
			  379,  379,  166,  606,  166,  166,  166,  605,  166,  159,
			  166,  159,  166, 1046,  166, 1046,  663, 1046,  166,  159,

			  607, 1046,  166,  603,  166,  166,  594,  166,  379,  379,
			  379,  379,  379,  379,  166,  608,  166,  166,  166,  605,
			  166,  166,  166,  166,  166,  608,  166,  166,  664,  166,
			  166,  166,  609,  633,  166,  614,  166,  159,  166,  166,
			  620,  159,  609,  166,  166,  166,  166,  634,  166,  786,
			  616,  166,  166,  166,  166,  166,  166,  608, 1046,  166,
			 1046,  166,  618,  166,  166,  635, 1046,  614,  166,  166,
			  166,  166,  620,  166,  609,  166,  166,  166,  166,  636,
			  166,  787,  616,  166,  166,  166,  166,  166,  166, 1046,
			  166,  166,  166,  166,  618,  166,  166,  622,  626,  624, yy_Dummy>>,
			1, 200, 3400)
		end

	yy_nxt_template_19 (an_array: ARRAY [INTEGER])
			-- Fill chunk #19 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  921,  630,  166,  166,  661,  166, 1046,  166,  166,  166,
			  166,  166,  159,  159,  689,  628, 1046,  166,  159,  667,
			  166,  166,  166,  166,  166,  166,  166, 1046,  166,  622,
			  626,  624,  922,  630,  166,  166,  662,  166,  166,  166,
			  166,  166,  166,  166,  166,  166,  690,  628,  635,  166,
			  166,  668,  166,  166,  166, 1046,  166,  159,  166,  166,
			  166,  166,  636,  632,  159,  638,  166,  648, 1046,  166,
			  166,  166,  166,  687,  166,  166, 1046,  166, 1046,  166,
			  635, 1046,  640, 1046,  166, 1046,  166,  166,  166,  166,
			 1046,  166, 1046,  166,  636,  632,  166,  638,  166,  648,

			  166,  166,  166,  166,  166,  688,  166,  166,  642,  166,
			  652,  166,  166,  166,  640,  166,  166,  650,  159,  166,
			  654,  166,  645,  166,  166,  166,  166,  166, 1046,  166,
			 1046, 1046,  166,  166,  166,  646,  166,  159, 1046,  166,
			  642, 1046,  652, 1046,  166,  166, 1046,  166, 1046,  650,
			  166, 1046,  654,  166,  645,  166,  166,  166,  166,  166,
			  166,  166,  166,  658,  656,  166,  660,  646,  166,  166,
			  662,  166,  166,  166,  166,  166,  166, 1046,  166,  159,
			  166,  166,  664,  166, 1046,  166,  166, 1046,  770,  166,
			  166,  166,  166,  166,  166,  658,  656,  166,  660,  166, yy_Dummy>>,
			1, 200, 3600)
		end

	yy_nxt_template_20 (an_array: ARRAY [INTEGER])
			-- Fill chunk #20 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  668,  166,  662, 1046,  166,  166,  166,  166,  166,  166,
			  166,  166,  166,  166,  664,  166,  679,  166,  166,  666,
			  771,  166,  166,  166,  159,  166,  166,  670,  166,  166,
			  159,  166,  668,  166,  166,  697,  166,  671,  166,  683,
			  672,  166,  691,  159,  673,  159,  166,  674,  680, 1046,
			  159,  666,  159,  166,  676,  166,  166,  684,  166,  670,
			  166,  166,  166,  166, 1046,  166,  166,  698,  166,  673,
			  166,  685,  674,  166,  692,  166,  673,  166,  166,  674,
			 1046,  678,  166,  680,  166,  166,  676,  166,  166,  686,
			  166,  159, 1046,  166,  166,  166,  166,  166,  685,  166,

			  166,  166,  159,  806, 1046,  166,  166,  166,  682,  166,
			  703,  166,  166,  678,  166,  680,  686, 1046,  688,  166,
			  166,  693,  166,  166,  166,  159,  166, 1046,  166, 1046,
			  685,  166,  166,  166,  166,  807,  692,  159,  166,  166,
			  682,  166,  704,  166,  166,  690,  166,  166,  686,  166,
			  688,  166,  166,  694,  166, 1046,  166,  166,  699,  166,
			 1046,  709,  159,  694,  166, 1046,  159, 1046,  692,  166,
			  166,  701,  166,  696, 1046,  159,  166,  690,  166,  166,
			  159,  166,  166, 1046,  166,  166,  166,  698,  166, 1046,
			  700,  166,  700,  710,  166,  694,  166,  166,  166,  166, yy_Dummy>>,
			1, 200, 3800)
		end

	yy_nxt_template_21 (an_array: ARRAY [INTEGER])
			-- Fill chunk #21 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			 1046,  166,  166,  702,  166,  696,  702,  166,  166, 1046,
			  166,  166,  166,  166,  166,  166,  166,  166,  166,  698,
			  166,  704,  762,  159,  700,  166,  159,  706,  166,  166,
			  166,  166,  166,  166,  708,  159,  710,  166,  702,  166,
			  711,  504,  166,  166,  166,  166,  166,  166,  166,  166,
			  166,  504, 1046,  704,  763,  166,  166,  166,  166,  706,
			  166,  166,  166,  712,  166,  504,  708,  166,  710,  166,
			  296,  166,  712,  166,  166,  166,  166,  166,  166,  159,
			  159,  166,  504,  850,  850,  850,  850,  166,  166,  746,
			  750,  505, 1046,  166,  504,  712,  852,  852,  852,  852,

			 1046,  505, 1046, 1046, 1046,  166,  504,  166, 1046,  166,
			  766,  166,  166, 1046,  159,  505, 1046, 1046, 1046,  166,
			 1046,  747,  751,  504,  257,  258,  259,  260,  261,  262,
			  263,  264,  505,  296,  257,  258,  259,  260,  261,  262,
			  263,  264,  767, 1046,  505,  296,  166, 1046,  257,  258,
			  259,  260,  261,  262,  263,  264,  505,  523,  524,  525,
			  526,  527,  528,  529,  530,  257,  258,  259,  260,  261,
			  262,  263,  264,  505,  713,  713,  713,  257,  258,  259,
			  260,  261,  262,  263,  264,  296,  714,  714,  714,  257,
			  258,  259,  260,  261,  262,  263,  264,  296,  929,  929, yy_Dummy>>,
			1, 200, 4000)
		end

	yy_nxt_template_22 (an_array: ARRAY [INTEGER])
			-- Fill chunk #22 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  929,  929, 1046,  715,  715,  715,  257,  258,  259,  260,
			  261,  262,  263,  264,  296,  159, 1046,  159,  804,  719,
			  523,  524,  525,  526,  527,  528,  529,  530,  296,  720,
			  720,  720,  523,  524,  525,  526,  527,  528,  529,  530,
			  296, 1046, 1046,  291, 1046, 1046,  291,  166,  296,  166,
			  805,  280,  291, 1046, 1046,  291, 1046,  296, 1046, 1046,
			  280,  784,  159,  291,  159,  159,  291, 1046,  296,  721,
			  721,  280,  523,  524,  525,  526,  527,  528,  529,  530,
			 1046,  722,  722,  722,  523,  524,  525,  526,  527,  528,
			  529,  530, 1046,  785,  166, 1046,  166,  166, 1046,  723,

			  723,  523,  524,  525,  526,  527,  528,  529,  530, 1046,
			 1046, 1046,  724,  724,  724,  523,  524,  525,  526,  527,
			  528,  529,  530, 1046,  725, 1046, 1046,  523,  524,  525,
			  526,  527,  528,  529,  530,  297,  298,  299,  300,  301,
			  302,  303,  304,  159,  297,  298,  299,  300,  301,  302,
			  303,  304, 1046, 1046,  748,  297,  298,  299,  300,  301,
			  302,  303,  304,  291, 1046,  159,  291, 1046,  296, 1046,
			  778,  280, 1046, 1046,  291,  166, 1046,  291, 1046,  296,
			 1046, 1046,  280, 1046, 1046,  291,  749, 1046,  291, 1046,
			  296, 1046, 1046,  280, 1046, 1046,  291,  166,  159,  291, yy_Dummy>>,
			1, 200, 4200)
		end

	yy_nxt_template_23 (an_array: ARRAY [INTEGER])
			-- Fill chunk #23 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			 1046,  296,  779, 1046,  280,  281,  282,  283,  284,  285,
			  286,  287,  288,  281,  282,  283,  284,  285,  286,  287,
			  288,  281,  282,  283,  284,  285,  286,  287,  288,  107,
			  166, 1046,  108, 1046, 1046,  330,  331,  332,  333,  334,
			  335,  336,  337, 1046, 1046, 1046,  927,  107,  927, 1046,
			  108,  928,  928,  928,  928,  297,  298,  299,  300,  301,
			  302,  303,  304,  726,  726,  726,  297,  298,  299,  300,
			  301,  302,  303,  304,  727,  727,  727,  297,  298,  299,
			  300,  301,  302,  303,  304,  728,  728,  728,  297,  298,
			  299,  300,  301,  302,  303,  304,  109,  107, 1046, 1046,

			  108, 1046, 1046, 1046,  597,  597,  597,  597, 1046, 1046,
			 1046,  107, 1046, 1046,  108,  159,  120,  121,  122,  123,
			  124,  125,  126,  127,  107,  760,  159,  108,  109,  734,
			  734,  734,  734,  296,  110,  111,  112,  113,  114,  115,
			  116,  117,  107,  368,  382,  108,  109,  166,  159, 1046,
			  734,  734,  734,  734, 1046, 1046, 1046,  761,  166, 1046,
			  109, 1046, 1046,  794,  843,  159, 1046, 1046, 1046,  369,
			 1046,  933,  933,  933,  933,  368,  764,  159,  109, 1046,
			  166, 1046, 1046, 1046,  110,  111,  112,  113,  114,  115,
			  116,  117,  109, 1046, 1046,  795,  843,  166,  110,  111, yy_Dummy>>,
			1, 200, 4400)
		end

	yy_nxt_template_24 (an_array: ARRAY [INTEGER])
			-- Fill chunk #24 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  112,  113,  114,  115,  116,  117, 1046, 1046,  765,  166,
			 1046,  120,  121,  122,  123,  124,  125,  126,  127, 1046,
			  523,  524,  525,  526,  527,  528,  529,  530, 1046,  120,
			  121,  122,  123,  124,  125,  126,  127,  330,  331,  332,
			  333,  334,  335,  336,  337,  330,  331,  332,  333,  334,
			  335,  336,  337,  330,  331,  332,  333,  334,  335,  336,
			  337,  730,  730,  730,  330,  331,  332,  333,  334,  335,
			  336,  337, 1046,  731,  731,  731,  330,  331,  332,  333,
			  334,  335,  336,  337, 1046, 1046,  732,  732,  732,  330,
			  331,  332,  333,  334,  335,  336,  337, 1046,  738,  738,

			  738,  738,  166,  930,  779,  733,  560,  560,  560,  560,
			 1046,  754,  585,  772,  166,  810,  159,  159,  159,  159,
			 1046, 1046, 1046,  844,  844,  844,  844, 1046, 1046,  369,
			  934,  934,  934,  934,  166,  930,  779, 1046,  586,  848,
			  848,  848,  848,  755,  585,  773,  166,  811,  166,  166,
			  166,  166,  128,  128,  128,  330,  331,  332,  333,  334,
			  335,  336,  337,  736,  128,  128,  128,  330,  331,  332,
			  333,  334,  335,  336,  337,  936,  936,  936,  936,  849,
			  330,  331,  332,  333,  334,  335,  336,  337, 1046, 1046,
			  128,  128,  128,  330,  331,  332,  333,  334,  335,  336, yy_Dummy>>,
			1, 200, 4600)
		end

	yy_nxt_template_25 (an_array: ARRAY [INTEGER])
			-- Fill chunk #25 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  337,  166,  166,  166,  166,  166,  159,  166,  747, 1046,
			  749,  753,  751,  166,  166,  776,  166,  166,  166, 1046,
			  755,  788, 1046,  798, 1046,  159,  159,  159,  166,  166,
			 1046,  166, 1046,  166,  166,  166,  166,  166,  166,  166,
			  747,  166,  749,  753,  751,  166,  166,  777,  166,  166,
			  166,  757,  755,  789,  166,  799,  166,  166,  166,  166,
			  166,  166,  763,  166,  759,  166,  166,  166,  166,  166,
			  166,  166,  159,  166, 1046,  761, 1046,  166, 1046, 1046,
			  166,  166, 1046,  757,  159, 1046,  166, 1046,  166,  928,
			  928,  928,  928,  780,  763, 1046,  759,  166,  166,  166,

			  166,  166,  166,  166,  166,  824,  166,  761,  166,  166,
			  767,  159,  166,  166,  765,  769,  166,  166,  166,  166,
			  166,  166,  166,  166,  159,  781,  865,  771,  814,  166,
			  866,  159,  166,  166, 1046, 1046, 1046,  825,  166, 1046,
			  166,  855,  767,  166, 1046, 1046,  765,  769, 1046,  166,
			  166,  166,  166,  166,  166,  166,  166,  773,  867,  771,
			  815,  166,  868,  166,  166,  166,  166,  775,  166,  166,
			  166,  166,  166,  856,  166,  777,  166,  159,  166,  159,
			  781,  166,  166, 1046,  828,  166,  166,  166,  782,  773,
			 1046,  783, 1046,  166, 1046,  166, 1046,  166,  166,  775, yy_Dummy>>,
			1, 200, 4800)
		end

	yy_nxt_template_26 (an_array: ARRAY [INTEGER])
			-- Fill chunk #26 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  166,  166,  166,  166,  166,  166,  166,  777,  166,  166,
			  166,  166,  781,  166,  166,  785,  829,  166,  166,  166,
			  783, 1046,  166,  783,  166,  166,  166,  166,  166,  166,
			 1046,  159,  789,  159,  166,  787,  159,  166,  166,  166,
			  791,  166,  796,  166,  159,  166,  159,  785,  818,  820,
			  166,  166,  166,  800,  166,  166,  166,  166,  166,  166,
			  166, 1046,  793,  166,  789,  166,  166,  787,  166,  795,
			  166,  166,  791,  166,  797,  166,  166,  166,  166, 1046,
			  819,  821,  166,  166,  166,  801,  166,  166,  166,  166,
			  799,  166,  797,  166,  793,  166,  861,  166,  166,  166,

			  166,  795,  166,  159,  830,  166,  801,  159, 1046,  166,
			 1046,  803,  166,  166,  166, 1046,  166, 1046,  166, 1046,
			  166, 1046,  799,  166,  797,  166,  166,  166,  862,  166,
			  166,  166,  166, 1046,  166,  166,  831,  166,  801,  166,
			  166,  166,  166,  803,  166,  166,  166,  805,  166,  166,
			 1046,  166,  166,  166,  159,  166, 1046,  834,  166,  166,
			  159,  159,  809,  166,  166,  166,  166,  166, 1046,  812,
			  826,  877,  166,  807,  166,  159,  166,  166, 1046,  805,
			 1046,  166,  811,  166,  166,  166,  166, 1046,  166,  835,
			  166,  166,  166,  166,  809,  166,  166,  166,  166,  166, yy_Dummy>>,
			1, 200, 5000)
		end

	yy_nxt_template_27 (an_array: ARRAY [INTEGER])
			-- Fill chunk #27 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  166,  813,  827,  878,  166,  807,  166,  166,  166,  166,
			  813,  166,  815,  166,  811, 1046,  166,  159,  159,  166,
			  166,  166,  166,  166,  817, 1046,  863,  166,  819,  166,
			  832,  166,  166, 1046, 1046,  821,  166,  166,  166,  166,
			 1046, 1046,  813,  166,  815,  166, 1046,  166,  166,  166,
			  166,  166,  166,  166,  166,  166,  817,  825,  864,  166,
			  819,  166,  833,  166,  166,  823,  166,  821,  166,  166,
			  166,  166,  166,  166,  159,  166,  827,  889,  166,  166,
			  836,  159,  166,  871,  166,  166,  166,  875,  159,  825,
			  159,  166, 1046,  166,  159,  829,  166,  823,  166,  166,

			  166,  166,  166,  166,  166,  166,  166,  166,  827,  890,
			  166,  166,  837,  166,  166,  872,  166,  166,  166,  876,
			  166, 1046,  166,  166,  831,  166,  166,  829,  166,  159,
			  166,  166,  166,  166,  857,  166, 1046,  166, 1046,  166,
			  837,  296,  166,  166,  159,  835,  833,  166,  166,  166,
			  166,  166, 1046,  166,  504, 1046,  831,  166,  159,  903,
			  166,  166,  166,  166,  166,  504,  858,  885,  166,  166,
			  166,  166,  837,  504,  166, 1046,  166,  835,  833,  166,
			  166,  166,  166,  166,  166,  166,  296,  159,  879,  166,
			  166,  904,  869,  159,  166,  166,  296, 1046, 1046,  886, yy_Dummy>>,
			1, 200, 5200)
		end

	yy_nxt_template_28 (an_array: ARRAY [INTEGER])
			-- Fill chunk #28 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  166, 1046,  166,  937,  505,  937, 1046,  296,  935,  935,
			  935,  935,  166,  159,  166,  505,  166, 1046,  296,  166,
			  880, 1046, 1046,  505,  870,  166,  166, 1046,  523,  524,
			  525,  526,  527,  528,  529,  530,  296,  257,  258,  259,
			  260,  261,  262,  263,  264,  166, 1046, 1046,  257,  258,
			  259,  260,  261,  262,  263,  264,  257,  258,  259,  260,
			  261,  262,  263,  264,  291, 1046, 1046,  291, 1046,  296,
			 1046, 1046,  280,  523,  524,  525,  526,  527,  528,  529,
			  530, 1046, 1046,  523,  524,  525,  526,  527,  528,  529,
			  530,  838,  838,  838,  523,  524,  525,  526,  527,  528,

			  529,  530,  839,  839,  839,  523,  524,  525,  526,  527,
			  528,  529,  530, 1046,  851,  851,  851,  851, 1046, 1046,
			  840,  840,  840,  523,  524,  525,  526,  527,  528,  529,
			  530,  291, 1046, 1046,  291, 1046,  296, 1046, 1046,  280,
			  291,  159,  159,  291, 1046,  296,  883,  854,  280,  597,
			  597,  597,  597,  881,  743,  159,  297,  298,  299,  300,
			  301,  302,  303,  304,  330,  331,  332,  333,  334,  335,
			  336,  337,  842,  166,  166,  159,  895,  899,  884,  993,
			  887,  159,  159, 1046, 1046,  882, 1046,  166, 1046,  152,
			 1046,  928,  928,  928,  928, 1046,  330,  331,  332,  333, yy_Dummy>>,
			1, 200, 5400)
		end

	yy_nxt_template_29 (an_array: ARRAY [INTEGER])
			-- Fill chunk #29 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  334,  335,  336,  337, 1046,  586, 1046,  166,  896,  900,
			 1046,  993,  888,  166,  166,  330,  331,  332,  333,  334,
			  335,  336,  337,  297,  298,  299,  300,  301,  302,  303,
			  304,  736,  297,  298,  299,  300,  301,  302,  303,  304,
			  847,  847,  847,  847,  928,  928,  928,  928, 1046,  847,
			  847,  847,  847, 1046,  585,  330,  331,  332,  333,  334,
			  335,  336,  337,  853,  166,  166,  166,  166, 1046,  862,
			  166,  856,  166,  166,  159,  858,  166,  166,  159,  166,
			  586,  166,  166,  901,  860,  166,  585, 1046,  166, 1046,
			  166,  166, 1046,  159, 1046,  853,  166,  166,  166,  166,

			  166,  862,  166,  856,  166,  166,  166,  858,  166,  166,
			  166,  166,  159,  166,  166,  902,  860,  166,  947,  166,
			  166,  166,  166,  166,  166,  166,  166,  166,  166,  166,
			  870,  166,  166,  864, 1046,  159,  166, 1046,  867,  166,
			  166, 1046,  868, 1046,  166,  166, 1046,  166,  159,  159,
			  948,  166,  166,  166,  166,  159,  166,  166,  166,  166,
			  166,  166,  870,  166,  166,  864,  915,  166,  166,  874,
			  867,  166,  166,  166,  868,  166,  166,  166,  166,  166,
			  166,  166,  872,  878,  166,  166,  166,  166,  166,  166,
			  166,  876,  166, 1046, 1046, 1046,  166,  166,  916,  166, yy_Dummy>>,
			1, 200, 5600)
		end

	yy_nxt_template_30 (an_array: ARRAY [INTEGER])
			-- Fill chunk #30 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			 1046,  874,  166,  159,  159,  166, 1046,  166,  166,  166,
			  166, 1046, 1046, 1046,  872,  878, 1046,  166,  880, 1046,
			  166, 1046,  166,  876,  166,  166,  166,  166,  166,  166,
			  166,  166,  884,  882,  166,  166,  166,  166,  166,  159,
			 1046,  166,  166,  166,  166,  166,  888, 1046,  911, 1046,
			  880,  987,  987,  987,  987,  166,  166,  166,  166,  166,
			  166,  166,  166,  166,  884,  882, 1046,  886, 1046,  166,
			  166,  166,  890,  166,  166,  166,  166,  166,  888,  166,
			  912,  166,  166, 1046,  166,  907, 1046,  166,  166,  159,
			 1046,  166,  909,  166,  166,  166,  159,  892,  896,  886,

			  166, 1046,  166,  894,  890,  166,  166,  166,  166,  166,
			  159,  166,  166,  166,  166,  925,  166,  908,  166,  166,
			 1046,  166,  898,  166,  910,  166,  166,  166,  166,  892,
			  896,  166,  166,  166,  166,  894, 1046,  166,  166,  166,
			  166,  166,  166,  166,  166, 1046, 1046,  926,  913,  900,
			  166,  166,  159, 1046,  898, 1046,  166,  166,  166,  166,
			  166,  159,  166,  166,  159,  166,  902,  159,  166,  166,
			 1010,  166,  166,  166,  906,  166,  943,  166,  908,  166,
			  914,  900, 1046,  904,  166,  166, 1046,  166,  166,  166,
			  166,  923,  166,  166,  166,  159,  166,  166,  902,  166, yy_Dummy>>,
			1, 200, 5800)
		end

	yy_nxt_template_31 (an_array: ARRAY [INTEGER])
			-- Fill chunk #31 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  166, 1046, 1011,  166,  166,  166,  906,  910,  944,  166,
			  908,  166, 1046, 1046,  166,  904,  166,  166,  166,  166,
			  166,  166,  159,  924,  912,  914,  166,  166,  919,  166,
			  166,  159,  166,  166,  166,  166,  159,  159, 1046,  910,
			 1046,  916,  917, 1046,  166,  166,  166,  166,  166,  166,
			  166, 1046,  166, 1046,  166, 1046,  912,  914,  166,  166,
			  920, 1046,  166,  166,  166,  166,  166,  166,  166,  166,
			  166,  296,  166,  916,  918,  920,  166,  166,  918,  166,
			 1046,  166,  166,  166,  922,  166,  166,  166,  166,  166,
			 1046,  166, 1046,  941,  924,  166,  296,  159,  166,  166,

			  159,  166,  166,  166,  166,  296, 1046,  920, 1046, 1046,
			  918,  945,  159,  166,  166,  166,  922,  166,  166,  166,
			  166,  166,  166,  949,  166,  942,  924,  166, 1046,  166,
			  166,  166,  166,  166,  166,  166,  166,  159,  926,  932,
			  932,  932,  932,  946,  166,  166,  951, 1046,  166,  159,
			  159, 1046, 1046, 1046,  166,  950,  166, 1046,  523,  524,
			  525,  526,  527,  528,  529,  530,  166, 1046,  166,  166,
			  926,  935,  935,  935,  935, 1046, 1046, 1046,  952,  849,
			  166,  166,  166,  523,  524,  525,  526,  527,  528,  529,
			  530, 1046,  523,  524,  525,  526,  527,  528,  529,  530, yy_Dummy>>,
			1, 200, 6000)
		end

	yy_nxt_template_32 (an_array: ARRAY [INTEGER])
			-- Fill chunk #32 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  847,  847,  847,  847,  939,  939,  939,  939,  166,  953,
			  166,  743,  942,  166,  931,  166, 1006,  159,  940,  166,
			  166,  166,  159,  159,  166,  166,  166,  166, 1046,  166,
			 1046,  166,  961,  944, 1046,  946,  166,  159, 1046,  166,
			  166,  954,  166, 1046,  942,  166,  931,  166, 1007,  166,
			  940,  166,  166,  166,  166,  166,  166,  166,  166,  166,
			  166,  166,  166,  166,  962,  944,  957,  946,  166,  166,
			  952,  166,  166,  166,  159,  166,  948,  166,  166,  166,
			  166,  166, 1046,  166, 1046,  166,  950,  955,  159,  166,
			  166,  159,  166,  166,  166, 1046, 1046, 1046,  958, 1046,

			 1046, 1046,  952,  954,  166,  166,  166,  166,  948,  166,
			  166,  166,  166,  166,  166,  166,  166,  166,  950,  956,
			  166,  166,  166,  166,  956,  166,  166,  166,  166,  166,
			  166,  166,  959,  166,  958,  954,  159,  159,  159,  166,
			  166,  159, 1046,  166, 1046,  166,  166,  166,  166, 1046,
			  159, 1046,  965, 1046, 1046,  963,  956,  166,  166,  166,
			  166,  166,  166,  166,  960,  166,  958,  960,  166,  166,
			  166,  166,  166,  166,  166,  166,  166,  166,  166,  166,
			  166,  166,  166,  166,  966,  159,  166,  964,  962,  166,
			  166,  159,  166,  166,  964,  166,  967,  166, 1046,  960, yy_Dummy>>,
			1, 200, 6200)
		end

	yy_nxt_template_33 (an_array: ARRAY [INTEGER])
			-- Fill chunk #33 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			 1046,  969, 1046,  966,  166,  159,  166,  166,  166,  159,
			  166,  159,  166,  166, 1046,  166,  971,  166,  166, 1046,
			  962,  973,  166,  166,  166,  166,  964,  166,  968,  166,
			  166, 1046,  166,  970,  970,  966,  166,  166,  968,  166,
			  159,  166,  166,  166,  166,  166,  166,  166,  972, 1046,
			  159,  981,  972,  974,  159,  975,  166,  166, 1046,  977,
			 1046,  166,  166,  166,  166, 1046,  970, 1046,  974,  166,
			  968,  166,  166,  166,  166,  159,  166,  166,  166,  166,
			  983,  166,  166,  982,  972, 1046,  166,  976,  166,  166,
			  166,  978,  976,  166,  166,  166,  978,  166, 1046,  166,

			  974,  166,  166,  166,  979,  166,  166,  166,  159,  166,
			 1046,  980,  984,  166,  159,  166, 1046,  166,  166, 1046,
			  166,  166,  166,  166,  976,  985,  166,  166,  978,  166,
			  166,  166, 1046,  166,  166, 1046,  980, 1046,  166, 1046,
			  166,  166,  166,  980,  166,  159,  166,  166, 1046,  166,
			  166, 1018,  166,  166,  166,  166,  166,  986,  166,  166,
			 1046,  166,  166,  984,  982,  166,  998,  166,  166,  166,
			  166,  159,  166,  166,  166, 1046,  166,  166,  986,  166,
			  159, 1046,  166, 1019, 1046,  159,  166, 1046,  166, 1046,
			  166, 1000, 1046,  166, 1039,  984,  982, 1046,  999,  166, yy_Dummy>>,
			1, 200, 6400)
		end

	yy_nxt_template_34 (an_array: ARRAY [INTEGER])
			-- Fill chunk #34 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  166,  166,  166,  166,  166,  166,  991,  991,  991,  991,
			  986,  166,  166,  988,  166,  988, 1046,  166,  989,  989,
			  989,  989,  990, 1001,  990, 1046, 1040,  991,  991,  991,
			  991,  992,  992,  992,  992,  935,  935,  935,  935,  994,
			  994,  994,  994, 1046, 1046, 1046,  849,  935,  935,  935,
			  935,  995,  995,  995,  995,  996,  999,  996, 1046, 1046,
			  997,  997,  997,  997,  166,  993,  166,  166,  166,  166,
			  166,  166,  159, 1003, 1046, 1001,  166, 1002, 1046,  166,
			  166, 1004,  166,  166,  166, 1046,  159, 1008,  999, 1046,
			 1046,  586,  159, 1046,  166, 1046,  166,  993,  166,  166,

			  166,  166,  166,  166,  166, 1003, 1046, 1001,  166, 1003,
			 1007,  166,  166, 1005,  166,  166,  166, 1005,  166, 1009,
			  166, 1009,  166, 1046,  166,  166,  166,  166, 1011,  166,
			  166,  166,  166,  166,  166,  166,  166,  166,  159, 1046,
			  166,  166, 1007, 1014, 1046,  166,  166, 1046, 1012, 1005,
			  159, 1046,  166, 1009,  166, 1046, 1046,  166, 1046,  166,
			 1011,  166,  166,  166,  166,  166,  166,  166,  166,  166,
			  166, 1046,  166,  166, 1013, 1015, 1046,  166,  166,  166,
			 1013,  166,  166,  166,  166,  166,  166,  166, 1016, 1015,
			 1020,  166,  159, 1017,  159,  166,  166, 1046, 1046,  166, yy_Dummy>>,
			1, 200, 6600)
		end

	yy_nxt_template_35 (an_array: ARRAY [INTEGER])
			-- Fill chunk #35 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  166, 1046,  166, 1046, 1046, 1046, 1013, 1046, 1022, 1046,
			 1046,  166,  166,  166,  159,  166,  166,  166,  166,  166,
			 1017, 1015, 1021,  166,  166, 1017,  166,  166,  166, 1046,
			 1021,  166,  166,  166,  166,  166, 1019,  166,  159,  166,
			 1023, 1035, 1023, 1024,  166,  166,  166,  159,  166,  166,
			  166,  166, 1026,  166, 1046, 1046,  159, 1025, 1046, 1046,
			  166, 1046, 1021,  166,  166,  166,  166,  166, 1019,  166,
			  166,  166, 1046, 1036, 1023, 1025,  166,  166, 1046,  166,
			  166,  166,  166,  166, 1027,  166, 1046, 1046,  166, 1025,
			 1027,  166,  166,  166, 1046,  166,  166,  166,  166,  166,

			 1046, 1046, 1046,  166,  989,  989,  989,  989,  166,  166,
			 1028, 1028, 1028, 1028,  991,  991,  991,  991,  991,  991,
			  991,  991, 1027,  166, 1046,  166, 1046, 1046, 1046,  166,
			 1046,  166,  166, 1046,  166,  166, 1029, 1029, 1029, 1029,
			 1030,  166, 1030, 1046,  166, 1031, 1031, 1031, 1031, 1046,
			  736,  934,  934,  934,  934,  997,  997,  997,  997, 1032,
			 1032, 1032, 1032,  159,  166,  993,  166, 1046, 1033,  166,
			 1034,  166,  159,  166, 1037,  166,  166,  166, 1036,  166,
			  166,  166,  166, 1041,  166,  166,  166,  159,  166,  166,
			  166,  586, 1044, 1046,  166,  166,  159,  993,  166,  743, yy_Dummy>>,
			1, 200, 6800)
		end

	yy_nxt_template_36 (an_array: ARRAY [INTEGER])
			-- Fill chunk #36 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			 1034,  166, 1034,  166,  166,  166, 1038,  166, 1046,  166,
			 1036,  166,  166,  166,  166, 1042,  166,  166,  166,  166,
			  166,  166,  166,  166, 1045,  166,  166, 1046,  166,  166,
			  166,  166,  166, 1046,  166,  166,  166, 1038,  166, 1046,
			 1046,  166, 1040, 1042,  166, 1046, 1046,  166,  166,  166,
			  166, 1046,  166, 1046, 1046,  166, 1046,  166, 1046,  166,
			 1046,  166,  166,  166,  166, 1046,  166,  166,  166, 1038,
			  166, 1046, 1046,  166, 1040, 1042,  166, 1046, 1046,  166,
			  166,  166,  166,  166,  166,  166,  166, 1046,  166, 1046,
			 1046,  166, 1046, 1046,  166,  166, 1046, 1046,  166,  987,

			  987,  987,  987, 1031, 1031, 1031, 1031, 1043, 1043, 1043,
			 1043,  994,  994,  994,  994,  166, 1046,  166,  166, 1046,
			  166,  166, 1045,  166,  166, 1046,  166,  166, 1046,  166,
			  166,  166,  166,  166,  166, 1046,  166, 1046,  166,  736,
			  166,  166, 1046, 1046,  166, 1046, 1046,  849, 1046, 1046,
			  166,  743, 1046,  166, 1045,  166,  166,  166,  166,  166,
			 1046,  166, 1046,  166,  166,  166,  166, 1046,  166,  166,
			  166, 1046,  166,  166, 1046, 1046,  166, 1029, 1029, 1029,
			 1029, 1046,  166, 1046, 1046, 1046, 1046, 1046, 1046,  166,
			 1046,  166, 1046, 1046, 1046, 1046, 1046, 1046, 1046, 1046, yy_Dummy>>,
			1, 200, 7000)
		end

	yy_nxt_template_37 (an_array: ARRAY [INTEGER])
			-- Fill chunk #37 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			 1046,  166, 1046, 1046, 1046, 1046, 1046, 1046, 1046, 1046,
			 1046, 1046, 1046, 1046, 1046, 1046, 1046,  849,   87,   87,
			   87,   87,   87,   87,   87,   87,   87,   87,   87,   87,
			   87,   87,   87,   87,   87,   87,   87,   87,   87,   87,
			   87,   87,   87,   87,   87,   87,   87,   87,   87,   87,
			   87,   87,   87,   87,   87,   87,   87,   87,   87,  106,
			  106, 1046,  106,  106,  106,  106,  106,  106,  106,  106,
			  106,  106,  106,  106,  106,  106,  106,  106,  106,  106,
			  106,  106,  106,  106,  106,  106,  106,  106,  106,  106,
			  106,  106,  106,  106,  106,  106,  106,  106,  106,  106,

			  118, 1046, 1046, 1046, 1046, 1046, 1046,  118,  118,  118,
			  118,  118,  118,  118,  118,  118,  118,  118,  118,  118,
			  118,  118,  118,  118,  118,  118,  118,  118,  118,  118,
			  118,  118,  118,  118,  118,  118,  118,  118,  118,  118,
			  118,  119,  119, 1046,  119,  119,  119,  119,  119,  119,
			  119,  119,  119,  119,  119,  119,  119,  119,  119,  119,
			  119,  119,  119,  119,  119,  119,  119,  119,  119,  119,
			  119,  119,  119,  119,  119,  119,  119,  119,  119,  119,
			  119,  119,  128,  128, 1046,  128,  128,  128,  128, 1046,
			  128,  128,  128,  128,  128,  128,  128,  128,  128,  128, yy_Dummy>>,
			1, 200, 7200)
		end

	yy_nxt_template_38 (an_array: ARRAY [INTEGER])
			-- Fill chunk #38 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  128,  128,  128,  128,  128,  128,  128,  128,  128,  128,
			  128,  128,  128,  128,  128,  128,  128,  128,  128,  128,
			  128,  128,  128,  148,  148,  148,  148,  148, 1046, 1046,
			  148,  148,  148,  148,  148,  148,  148,  148,  148,  148,
			  148,  148,  148,  148,  148,  148,  148,  148, 1046,  148,
			  148,  148,  148,  256,  256, 1046,  256,  256,  256, 1046,
			 1046,  256,  256,  256,  256,  256,  256,  256,  256,  256,
			  256,  256,  256,  256,  256,  256,  256,  256,  256,  256,
			  256,  256,  256,  256,  256,  256,  256,  256, 1046,  256,
			  256,  256,  256,  256,  166,  166,  166,  166, 1046, 1046,

			  166,  166,  166,  166,  166,  166,  166,  166,  166,  166,
			  166,  166,  166,  166,  166,  166,  166,  166, 1046,  166,
			  166,  166,  166,  166,  280, 1046, 1046,  280, 1046, 1046,
			  280,  280,  280,  280,  280,  280,  280,  280,  280,  280,
			  280,  280,  280,  280,  280,  280,  280,  280,  280,  280,
			  280,  280,  280,  280,  280,  280,  280,  280,  280,  280,
			  280,  280,  280,  280,  280,  294,  294, 1046,  294,  294,
			  294,  294,  294,  294,  294,  294,  294,  294,  294,  294,
			  294,  294,  294,  294,  294,  294,  294,  294,  294,  294,
			  294,  294,  294,  294,  294,  294,  294,  294,  294,  294, yy_Dummy>>,
			1, 200, 7400)
		end

	yy_nxt_template_39 (an_array: ARRAY [INTEGER])
			-- Fill chunk #39 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  294,  294,  294,  294,  294,  294,  119,  119,  119,  119,
			  119, 1046, 1046, 1046, 1046, 1046,  119,  119,  119,  119,
			  119,  119,  119,  119,  119,  119,  119,  119,  119,  119,
			  119,  119,  328, 1046, 1046, 1046, 1046,  328,  328,  328,
			  328,  328,  328,  328,  328,  328,  328,  328,  328,  328,
			  328,  328,  328,  328,  328,  328,  328,  328,  328,  328,
			  328,  328,  328,  328,  328,  328,  328,  328,  328,  328,
			  328,  328,  328,  370,  370,  370,  370,  370,  370,  370,
			  370,  370,  370, 1046,  370,  370,  370,  370,  370,  370,
			  370,  370,  370,  370,  370,  370,  370,  370,  370,  370,

			  370,  370,  370,  370,  370,  370,  370,  370,  370,  370,
			  370,  370,  370,  370,  376,  376,  376,  376, 1046, 1046,
			  376,  376,  376,  376,  376,  376,  376,  376,  376,  376,
			  376,  376,  376,  376,  376,  376,  376,  376, 1046,  376,
			  376,  376,  376,  378,  378,  378,  378, 1046, 1046,  378,
			  378,  378,  378,  378,  378,  378,  378,  378,  378,  378,
			  378,  378,  378,  378,  378,  378,  378, 1046,  378,  378,
			  378,  378,  380,  380,  380,  380, 1046, 1046,  380,  380,
			  380,  380,  380,  380,  380,  380,  380,  380,  380,  380,
			  380,  380,  380,  380,  380,  380, 1046,  380,  380,  380, yy_Dummy>>,
			1, 200, 7600)
		end

	yy_nxt_template_40 (an_array: ARRAY [INTEGER])
			-- Fill chunk #40 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  380,  291,  291, 1046,  291,  291,  291, 1046,  291,  291,
			  291,  291,  291,  291,  291,  291,  291,  291,  291,  291,
			  291,  291,  291,  291,  291,  291,  291,  291,  291,  291,
			  291,  291,  291,  291,  291,  291,  291,  291,  291,  291,
			  291,  291,  938,  938,  938,  938,  938,  938,  938,  938,
			  938,  938, 1046,  938,  938,  938,  938,  938,  938,  938,
			  938,  938,  938,  938,  938,  938,  938,  938,  938,  938,
			  938,  938,  938,  938,  938,  938,  938,  938,  938,  938,
			  938,  938,  938,    5, 1046, 1046, 1046, 1046, 1046, 1046,
			 1046, 1046, 1046, 1046, 1046, 1046, 1046, 1046, 1046, 1046,

			 1046, 1046, 1046, 1046, 1046, 1046, 1046, 1046, 1046, 1046,
			 1046, 1046, 1046, 1046, 1046, 1046, 1046, 1046, 1046, 1046,
			 1046, 1046, 1046, 1046, 1046, 1046, 1046, 1046, 1046, 1046,
			 1046, 1046, 1046, 1046, 1046, 1046, 1046, 1046, 1046, 1046,
			 1046, 1046, 1046, 1046, 1046, 1046, 1046, 1046, 1046, 1046,
			 1046, 1046, 1046, 1046, 1046, 1046, 1046, 1046, 1046, 1046,
			 1046, 1046, 1046, 1046, 1046, 1046, 1046, 1046, 1046, 1046,
			 1046, 1046, 1046, 1046, 1046, 1046, 1046, 1046, 1046, 1046,
			 1046, 1046, 1046, 1046, 1046, yy_Dummy>>,
			1, 185, 7800)
		end

	yy_chk_template: SPECIAL [INTEGER]
			-- Template for `yy_chk'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 7984)
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

			    1,    1,    3,    3,    3,    3,   39,    3,   22,   23,
			 1029,   23,   23,   23,   23,    4,    4,    4,    4,   22,
			    4,   24,   26,  148,   26,   26,   26,   26,  994,   24,
			   29,   29,   31,   31,   12,   50,   50,   12,   39,  987,
			   35,   35,   15,   44,   35,   15,   16,   35,   16,   16,
			   35,  841,   44,   35,   16,   41,   82,   82,    3,   84,
			   84,   41,  176,  176,   26,  148,  595,   50,   50,  178,
			  178,    4,   35,   35,  159,   44,   35,  268,  268,   35,
			  149,  149,   35,   12,   44,   35,  593,   41,  591,    3,
			  270,  270,   24,   41,    3,    3,    3,    3,    3,    3, yy_Dummy>>,
			1, 200, 0)
		end

	yy_chk_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			    3,    3,    4,   79,   79,   79,  159,    4,    4,    4,
			    4,    4,    4,    4,    4,   12,   81,   81,   81,  380,
			  149,   12,   12,   12,   12,   12,   12,   12,   12,   15,
			   15,   15,   15,   15,   15,   15,   15,  378,   16,   16,
			   16,   16,   16,   16,   16,   16,   25,   42,   25,   25,
			   25,   25,  376,   42,   36,  194,  340,   34,   36,   25,
			   25,   34,   37,   34,   36,   37,   34,   37,   34,  162,
			   51,   45,  162,   34,   34,   45,   51,   37,  272,   42,
			  374,   25,   83,   83,   83,   42,   36,  194,   25,   34,
			   36,   25,   25,   34,   37,   34,   36,   37,   34,   37,

			   34,  162,   51,   45,  162,   34,   34,   45,   51,   37,
			   85,   85,   85,   25,   33,   33,   33,   33,   48,  173,
			  173,  173,  374,   48,   33,   33,   33,   33,   33,   33,
			   33,   33,   33,   33,   33,   33,   33,   33,   33,   33,
			   33,   33,   33,   33,   33,   33,   33,   33,   33,   33,
			   48,  175,  175,  175,   33,   48,   33,   33,   33,   33,
			   33,   33,   33,   33,   33,   33,   33,   33,   33,   33,
			   33,   33,   33,   33,   33,   33,   33,   33,   33,   33,
			   33,   33,  147,  266,  147,  147,  147,  147,   33,   33,
			   33,   33,   33,   33,   33,   33,   38,  180,   40,  174, yy_Dummy>>,
			1, 200, 200)
		end

	yy_chk_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			   38,   40,   43,  209,   38,   40,   40,   47,   47,   43,
			  160,   40,   43,   38,   43,   49,   46,   47,   43,  160,
			   46,  161,  163,   49,  147,  161,   46,  163,   38,   49,
			   40,   46,   38,   40,   43,  209,   38,   40,   40,   47,
			   47,   43,  160,   40,   43,   38,   43,   49,   46,   47,
			   43,  160,   46,  161,  163,   49,  129,  161,   46,  163,
			  108,   49,  104,   46,   56,   56,   56,   56,   56,   56,
			   56,   56,   57,   63,  183,   63,   57,   60,  183,  212,
			   60,   57,  164,   57,   60,   63,   58,   60,   57,   57,
			   60,  226,  164,   60,   87,   87,   87,   87,   87,   87,

			   87,   87,  102,   86,   57,   63,  183,   63,   57,   60,
			  183,  212,   60,   57,  164,   57,   60,   63,   58,   60,
			   57,   57,   60,  226,  164,   60,   94,   94,   94,   94,
			   94,   94,   94,   94,   57,   57,   57,   57,   57,   57,
			   57,   57,   58,   58,   58,   58,   58,   58,   58,   58,
			   59,  197,   61,  165,   59,  181,   61,   59,   61,   61,
			   59,  197,   61,   59,  165,   61,  181,  248,   61,   95,
			   95,   95,   95,   95,   95,   95,   95,   95,  150,  150,
			  150,   80,   59,  197,   61,  165,   59,  181,   61,   59,
			   61,   61,   59,  197,   61,   59,  165,   61,  181,  248, yy_Dummy>>,
			1, 200, 400)
		end

	yy_chk_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			   61,   88,   53,   88,   88,   32,   27,   59,   59,   59,
			   59,   59,   59,   59,   59,   62,   64,   11,  150,   62,
			  388,  205,   64,   64,   64,   10,   62,  205,   62,   64,
			   65,    9,   62,   65,   64,   65,   65,   66,   62,   66,
			   66,  177,  177,  177,    7,   65,    5,   62,   64,   66,
			    0,   62,  388,  205,   64,   64,   64,   88,   62,  205,
			   62,   64,   65,   67,   62,   65,   64,   65,   65,   66,
			   62,   66,   66,   67,   68,   67,   68,   65,  187,   67,
			   68,   66,   69,   70,  391,   67,   68,  187,   88,   69,
			   70,   69,   70,   70,    0,   67,    0,    0,   70,    0,

			    0,   69,   70,    0,    0,   67,   68,   67,   68,    0,
			  187,   67,   68,    0,   69,   70,  391,   67,   68,  187,
			    0,   69,   70,   69,   70,   70,   72,  185,   72,   73,
			   70,   71,  185,   69,   70,   71,  203,   71,   72,  203,
			   73,   71,   73,   73,  179,  179,  179,   71,   91,   74,
			   91,   91,   73,   74,   75,   74,   75,   75,   72,  185,
			   72,   73,    0,   71,  185,   74,   75,   71,  203,   71,
			   72,  203,   73,   71,   73,   73,  265,  265,  265,   71,
			    0,   74,  375,  375,   73,   74,   75,   74,   75,   75,
			   90,   90,   90,   90,  267,  267,  267,   74,   75,    0, yy_Dummy>>,
			1, 200, 600)
		end

	yy_chk_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			   93,  393,    0,   93,   91,   93,    0,    0,   93,   96,
			   96,   96,   96,   96,   96,   96,   96,   96,   96,   96,
			   97,   97,  375,   97,   97,   97,   97,   97,   97,   97,
			   97,  106,    0,  393,  106,   91,   99,   99,   99,   99,
			   99,   99,   99,   99,   99,   99,   90,   98,   98,   98,
			   98,   98,   98,   98,   98,   98,   98,   98,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  269,
			  269,  269,    0,  109,    0,  109,  109,   90,  109,    0,
			  106,  109,   90,   90,   90,   90,   90,   90,   90,   90,
			    0,    0,   93,   93,   93,   93,   93,   93,   93,   93,

			  101,  404,    0,  101,  101,  101,  101,  101,  101,  101,
			  101,  110,  106,    0,  110,  271,  271,  271,  106,  106,
			  106,  106,  106,  106,  106,  106,  111,  109,    0,  111,
			  273,  273,  273,  404,  142,  142,  142,  142,    0,    0,
			  112,    0,  152,  112,  152,  152,  152,  152,  142,  146,
			  146,  146,  146,  424,  184,  274,  274,  274,    0,  109,
			  110,  113,  184,  146,  113,  109,  109,  109,  109,  109,
			  109,  109,  109,  119,  142,  111,  119,  275,  275,  275,
			  142,  276,  276,  276,  152,  424,  184,  114,    0,  112,
			  114,  441,  110,    0,  184,  146,    0,    0,  110,  110, yy_Dummy>>,
			1, 200, 800)
		end

	yy_chk_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  110,  110,  110,  110,  110,  110,    0,  111,  115,    0,
			  113,  115,  111,  111,  111,  111,  111,  111,  111,  111,
			  111,  112,    0,  441,  112,  112,  112,  112,  112,  112,
			  112,  112,  112,  112,  112,  116,  114,  460,  116,  277,
			  277,  277,  113,    0,    0,  113,  113,    0,  113,  113,
			  113,  113,  113,  113,  113,  113,  117,  115,    0,  117,
			  119,  119,  119,  119,  119,  119,  119,  119,  114,  460,
			    0,  114,  114,  114,  114,  114,  114,  114,  114,  114,
			  114,  114,  120,  484,  116,  120,  278,  278,  278,  115,
			  279,  279,  279,  115,  115,  115,  115,  115,  115,  115,

			  115,  115,  115,  121,  492,  117,  121,  217,    0,  217,
			  312,  312,  312,  312,  122,  484,  116,  122,    0,  116,
			  116,  116,  116,  116,  116,  116,  116,  116,  116,  116,
			  123,  186,    0,  123,  496,  186,  492,  117,    0,  217,
			  117,  217,  128,  117,  117,  117,  117,  117,  117,  117,
			  117,  124,    0,    0,  124,  369,  369,  369,  369,    0,
			    0,  125,    0,  186,  125,    0,  496,  186,    0,  120,
			  120,  120,  120,  120,  120,  120,  120,  126,  502,  224,
			  126,  397,  397,  397,  224,  398,  398,  398,    0,  121,
			  121,  121,  121,  121,  121,  121,  121,  121,  122,  122, yy_Dummy>>,
			1, 200, 1000)
		end

	yy_chk_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  122,  122,  122,  122,  122,  122,  122,  122,  122,  127,
			  502,  224,  127,    0,  123,  123,  224,  123,  123,  123,
			  123,  123,  123,  123,  123,  128,  128,  128,  128,  128,
			  128,  128,  128,    0,    0,  124,  124,  124,  124,  124,
			  124,  124,  124,  124,  124,  124,  125,  125,  125,  125,
			  125,  125,  125,  125,  125,  125,  399,  399,  399,  607,
			    0,  126,  126,  126,  126,  126,  126,  126,  126,  126,
			  126,  126,  131,  242,  198,  400,  400,  400,    0,  198,
			  204,  132,  231,  199,    0,  242,  231,    0,  204,  198,
			  199,  607,  133,  127,  199,    0,  127,  127,  127,  127,

			  127,  127,  127,  127,  130,  242,  198,  130,  130,  130,
			  130,  198,  204,    0,  231,  199,  130,  242,  231,  134,
			  204,  198,  199,  130,    0,  130,  199,  130,  130,  130,
			  130,  135,  130,    0,  130,  401,  401,  401,  130,    0,
			  130,  136,    0,  130,  130,  130,  130,  130,  130,  377,
			  377,  377,  131,  131,  131,  131,  131,  131,  131,  131,
			  131,  131,  131,  132,  132,  132,  132,  132,  132,  132,
			  132,  132,  133,  133,  133,  133,  133,  133,  133,  133,
			  133,  133,  133,  137,  402,  402,  402,    0,    0,  377,
			    0,  130,  130,  130,  130,  130,  130,  130,  130,  134, yy_Dummy>>,
			1, 200, 1200)
		end

	yy_chk_template_8 (an_array: ARRAY [INTEGER])
			-- Fill chunk #8 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  134,  138,  134,  134,  134,  134,  134,  134,  134,  134,
			    0,  135,  135,  135,  135,  135,  135,  135,  135,  135,
			  135,  135,  136,  136,  136,  136,  136,  136,  136,  136,
			  136,  136,  280,  280,  280,  280,  280,  280,  280,  280,
			    0,    0,  225,  210,  235,  629,  643,  235,  225,    0,
			  210,  235,  281,  281,  281,  281,  281,  281,  281,  281,
			  403,  403,  403,  137,  137,  137,  137,  137,  137,  137,
			  137,  137,  137,  137,  225,  210,  235,  629,  643,  235,
			  225,  138,  210,  235,  138,  138,  138,  138,  138,  138,
			  138,  138,  151,  151,  151,  151,  166,    0,  166,  513,

			  513,  513,  151,  151,  151,  151,  151,  151,  166,  167,
			  168,  167,    0,    0,  223,  167,    0,  168,    0,  168,
			    0,  167,    0,    0,  223,  514,  514,  514,  166,  168,
			  166,    0,  151,    0,  151,  151,  151,  151,  151,  151,
			  166,  167,  168,  167,  170,  169,  223,  167,  169,  168,
			  169,  168,  170,  167,  170,  171,  223,  171,  416,    0,
			  169,  168,  171,  172,  170,  172,  182,  171,  182,    0,
			  416,  172,  188,  647,  182,  172,  170,  169,  182,  188,
			  169,  188,  169,    0,  170,    0,  170,  171,  659,  171,
			  416,  188,  169,    0,  171,  172,  170,  172,  182,  171, yy_Dummy>>,
			1, 200, 1400)
		end

	yy_chk_template_9 (an_array: ARRAY [INTEGER])
			-- Fill chunk #9 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  182,  189,  416,  172,  188,  647,  182,  172,    0,  191,
			  182,  188,  189,  188,  189,  190,  191,  190,  191,  192,
			  659,  192,  193,  188,  189,  192,  193,  190,  191,  193,
			  236,  192,    0,  189,  236,  515,  515,  515,    0,    0,
			  193,  191,    0,  196,  189,  196,  189,  190,  191,  190,
			  191,  192,    0,  192,  193,  196,  189,  192,  193,  190,
			  191,  193,  236,  192,  195,    0,  236,    0,  195,    0,
			  221,  200,  193,  200,  195,  196,  195,  196,  200,  237,
			  663,  221,  195,  200,  201,    0,  195,  196,  237,  202,
			  385,  202,  201,  202,  201,  385,  195,  202,    0,  201,

			  195,  202,  221,  200,  201,  200,  195,  206,  195,  206,
			  200,  237,  663,  221,  195,  200,  201,  207,  195,  206,
			  237,  202,  385,  202,  201,  202,  201,  385,  207,  202,
			  207,  201,  208,  202,  208,  208,  201,    0,  241,  206,
			  207,  206,  241,  211,  208,  211,  387,  211,  211,  207,
			  247,  206,  251,  213,  387,  213,  251,    0,  211,  247,
			  207,  211,  207,    0,  208,  213,  208,  208,  665,  214,
			  241,  214,  207,  214,  241,  211,  208,  211,  387,  211,
			  211,  214,  247,  218,  251,  213,  387,  213,  251,  218,
			  211,  247,    0,  211,  216,  218,  216,  213,  383,  410, yy_Dummy>>,
			1, 200, 1600)
		end

	yy_chk_template_10 (an_array: ARRAY [INTEGER])
			-- Fill chunk #10 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  665,  214,    0,  214,  383,  214,  216,  219,  219,    0,
			  219,  425,  410,  214,  215,  218,  215,    0,  215,    0,
			  219,  218,  215,  425,  215,    0,  216,  218,  216,  215,
			  383,  410,  215,  222,  215,  222,  383,    0,  216,  219,
			  219,  222,  219,  425,  410,  222,  215,  434,  215,  228,
			  215,  220,  219,    0,  215,  425,  215,  228,  434,  228,
			  220,  215,  220,  220,  215,  222,  215,  222,  227,  228,
			  227,    0,  220,  222,    0,  227,  229,  222,    0,  434,
			  227,  228,    0,  220,  230,  229,  230,  229,    0,  228,
			  434,  228,  220,    0,  220,  220,  230,  229,  245,    0,

			  227,  228,  227,  245,  220,    0,  232,  227,  229,  516,
			  516,  516,  227,  232,  245,  232,  230,  229,  230,  229,
			  238,  233,  238,  233,  238,  232,  233,    0,  230,  229,
			  245,  233,  238,  253,  233,  245,  233,  233,  232,  517,
			  517,  517,  253,    0,  669,  232,  245,  232,  367,  367,
			  367,  367,  238,  233,  238,  233,  238,  232,  233,  239,
			  239,  239,  367,  233,  238,  253,  233,    0,  233,  233,
			  234,  239,  234,  406,  253,  240,  669,  240,  234,  406,
			  234,  240,    0,  234,    0,  234,  234,  240,  367,  243,
			  234,  239,  239,  239,  367,    0,  243,  289,  243,  289, yy_Dummy>>,
			1, 200, 1800)
		end

	yy_chk_template_11 (an_array: ARRAY [INTEGER])
			-- Fill chunk #11 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  289,    0,  234,  239,  234,  406,  672,  240,  243,  240,
			  234,  406,  234,  240,  244,  234,  244,  234,  234,  240,
			  417,  243,  234,  244,  417,    0,  244,  246,  243,    0,
			  243,  290,  246,  290,  290,  246,    0,  246,  672,  249,
			  243,  249,    0,  246,    0,  249,  244,  246,  244,  256,
			    0,  249,  417,  289,  469,  244,  417,  250,  244,  246,
			  250,  252,  250,  257,  246,    0,  469,  246,  252,  246,
			  252,  249,  250,  249,  258,  246,  254,  249,  254,  246,
			  252,    0,  254,  249,  289,  681,  469,  290,  254,  250,
			  259,    0,  250,  252,  250,  518,  518,  518,  469,  256,

			  252,    0,  252,    0,  250,  260,    0,    0,  254,    0,
			  254,    0,  252,  257,  254,    0,  261,  681,  290,    0,
			  254,  368,  693,  368,  258,    0,  368,  368,  368,  368,
			    0,  262,  256,  256,  256,  256,  256,  256,  256,  256,
			  259,  519,  519,  519,  590,  590,  257,  257,  257,  257,
			  257,  257,  257,  257,  693,  260,  258,  258,  258,  258,
			  258,  258,  258,  258,  258,    0,  261,  520,  520,  520,
			  259,  259,  259,  259,  259,  259,  259,  259,  259,  259,
			  259,  262,  263,    0,  590,  260,  260,    0,  260,  260,
			  260,  260,  260,  260,  260,  260,  261,  261,  261,  261, yy_Dummy>>,
			1, 200, 2000)
		end

	yy_chk_template_12 (an_array: ARRAY [INTEGER])
			-- Fill chunk #12 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  261,  261,  261,  261,  261,  261,  261,  264,  521,  521,
			  521,    0,  262,  262,  262,  262,  262,  262,  262,  262,
			  262,  262,  282,  282,  282,  282,  282,  282,  282,  282,
			  282,    0,  263,  283,  283,  283,  283,  283,  283,  283,
			  283,  283,  283,  283,  284,  284,  291,  284,  284,  284,
			  284,  284,  284,  284,  284,    0,    0,  264,  522,  522,
			  522,    0,  263,  263,  263,  263,  263,  263,  263,  263,
			  263,  263,  263,  285,  285,  285,  285,  285,  285,  285,
			  285,  285,  285,  285,    0,    0,  293,  264,  293,  293,
			  264,  264,  264,  264,  264,  264,  264,  264,  286,  286,

			  286,  286,  286,  286,  286,  286,  286,  286,  287,  287,
			  287,  287,  287,  287,  287,  287,  287,  287,  287,  288,
			  697,    0,  288,  288,  288,  288,  288,  288,  288,  288,
			  592,  592,  592,  291,  291,  291,  291,  291,  291,  291,
			  291,  294,  293,    0,  294,  295,  294,  295,  295,  294,
			  297,    0,  697,  297,    0,  297,  408,    0,  297,  298,
			  649,  699,  298,  412,  298,    0,  408,  298,    0,  302,
			  592,  412,  302,  293,  302,  649,    0,  302,  293,  293,
			  293,  293,  293,  293,  293,  293,  299,    0,  408,  299,
			    0,  299,  649,  699,  299,  412,    0,  300,  408,    0, yy_Dummy>>,
			1, 200, 2200)
		end

	yy_chk_template_13 (an_array: ARRAY [INTEGER])
			-- Fill chunk #13 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  300,  295,  300,  412,    0,  300,    0,  649,  301,  709,
			    0,  301,    0,  301,    0,    0,  301,    0,    0,  303,
			    0,    0,  303,  372,  303,  372,    0,  303,  372,  372,
			  372,  372,  295,  294,  294,  294,  294,  294,  294,  294,
			  294,  709,  297,  297,  297,  297,  297,  297,  297,  297,
			  298,  298,  298,  298,  298,  298,  298,  298,  298,  302,
			  302,  302,  302,  302,  302,  302,  302,  302,  302,  541,
			  541,  541,  541,  541,    0,  299,  299,  299,  299,  299,
			  299,  299,  299,  299,  299,  299,  300,  300,  711,  300,
			  300,  300,  300,  300,  300,  300,  300,  301,  301,  301,

			  301,  301,  301,  301,  301,  301,  301,  301,  303,  303,
			  303,  303,  303,  303,  303,  303,  303,  303,  303,  304,
			  711,    0,  304,    0,  304,    0,    0,  304,  305,  305,
			  305,  305,  305,  305,  305,  305,  306,  306,  306,  306,
			  306,  306,  306,  306,  307,  307,  307,  307,  307,  307,
			  307,  307,  308,  308,  308,  308,  308,  308,  308,  308,
			  309,  309,  309,  309,  309,  309,  309,  309,  309,  309,
			  309,  310,  310,  310,  310,  310,  310,  310,  310,  310,
			  310,  310,  311,  311,  311,  311,  311,  311,  311,  311,
			  311,  311,  311,  313,    0,  313,  313,    0,  313,    0, yy_Dummy>>,
			1, 200, 2400)
		end

	yy_chk_template_14 (an_array: ARRAY [INTEGER])
			-- Fill chunk #14 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  373,  313,  373,  373,  373,  373,    0,    0,  304,    0,
			    0,  304,  304,  304,  304,  304,  304,  304,  304,  314,
			    0,  418,  314,    0,  371,  371,  371,  371,  384,  418,
			  384,  384,    0,  315,    0,  422,  315,    0,  371,  422,
			  384,  381,  373,  381,  381,  381,  381,  313,  316,    0,
			    0,  316,  382,  418,  382,  382,  382,  382,    0,    0,
			  384,  418,  384,  384,  371,    0,  317,  422,  314,  317,
			  371,  422,  384,  581,  581,  581,  581,    0,    0,  313,
			    0,  318,  315,  381,  318,  313,  313,  313,  313,  313,
			  313,  313,  313,    0,  382,  319,    0,  316,  319,    0,

			  314,  583,  583,  583,  583,    0,  314,  314,  314,  314,
			  314,  314,  314,  314,  315,  317,  438,  748,  750,  438,
			  315,  315,  315,  315,  315,  315,  315,  315,  320,  316,
			  318,  320,  610,  610,  610,  316,  316,  316,  316,  316,
			  316,  316,  316,  321,  319,    0,  321,  317,  438,  748,
			  750,  438,    0,  317,  317,  317,  317,  317,  317,  317,
			  317,  322,  318,    0,  322,  318,  318,  318,  318,  318,
			  318,  318,  318,  318,  318,  318,  319,  320,  328,  319,
			  319,  319,  319,  319,  319,  319,  319,  319,  319,  319,
			  323,    0,  429,  323,    0,  386,  429,  386,  324,    0, yy_Dummy>>,
			1, 200, 2600)
		end

	yy_chk_template_15 (an_array: ARRAY [INTEGER])
			-- Fill chunk #15 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			    0,  324,  582,  582,  582,  582,    0,  386,    0,  320,
			  330,  758,  320,  320,  320,  320,  320,  320,  320,  320,
			  320,  320,  320,  325,  429,  760,  325,  386,  429,  386,
			  321,  321,  321,  321,  321,  321,  321,  321,  326,  386,
			  440,  326,  582,  758,  440,  611,  611,  611,  322,  322,
			  322,  322,  322,  322,  322,  322,  327,  760,    0,  327,
			    0,  328,  328,  328,  328,  328,  328,  328,  328,  331,
			  442,  604,  440,  604,  442,    0,  440,  323,  323,  323,
			  323,  323,  323,  323,  323,  324,  324,  324,  324,  324,
			  324,  324,  324,  330,  330,  330,  330,  330,  330,  330,

			  330,  332,  442,  604,    0,  604,  442,  325,  325,  325,
			  325,  325,  325,  325,  325,  325,  325,  325,  333,  612,
			  612,  612,  326,  326,  326,  326,  326,  326,  326,  326,
			  326,  326,  326,  334,  450,  716,  716,  716,  450,    0,
			  327,  327,  327,  327,  327,  327,  327,  327,  327,  327,
			  327,  331,  331,  331,  331,  331,  331,  331,  331,  331,
			  335,  436,  613,  768,  613,  436,  450,  585,    0,  585,
			  450,  336,  585,  585,  585,  585,    0,    0,  436,  338,
			  784,  332,  332,  332,  332,  332,  332,  332,  332,  332,
			  332,  332,  337,  436,  613,  768,  613,  436,  333,  333, yy_Dummy>>,
			1, 200, 2800)
		end

	yy_chk_template_16 (an_array: ARRAY [INTEGER])
			-- Fill chunk #16 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  339,  333,  333,  333,  333,  333,  333,  333,  333,  341,
			  436,    0,  784,  334,  334,  334,  334,  334,  334,  334,
			  334,  334,  334,  334,  342,  586,  586,  586,  586,  717,
			  717,  717,  344,  587,  587,  587,  587,  718,  718,  718,
			  345,  335,  335,  335,  335,  335,  335,  335,  335,  335,
			  335,  336,  336,  336,  336,  336,  336,  336,  336,  336,
			  336,  336,  338,  338,  338,  338,  338,  338,  338,  338,
			  346,    0,  337,  754,  754,  337,  337,  337,  337,  337,
			  337,  337,  337,  339,  339,  339,  339,  339,  339,  339,
			  339,  343,  341,  341,  341,  341,  341,  341,  341,  341,

			  343,  343,  343,  343,  347,  754,  754,  342,  342,  342,
			  342,  342,  342,  342,  342,  344,  344,  344,  344,  344,
			  344,  344,  344,  345,  345,  345,  345,  345,  345,  345,
			  345,  348,  414,  443,  456,  792,  687,    0,  456,  349,
			  443,  414,    0,  588,  588,  588,  588,  350,  736,  736,
			  736,  736,  687,  346,  346,  346,  346,  346,  346,  346,
			  346,  351,    0,    0,  414,  443,  456,  792,  687,  352,
			  456,    0,  443,  414,  343,  343,  343,  343,  343,  343,
			  343,  343,  353,  588,  687,    0,    0,  347,  347,  347,
			  347,  347,  347,  347,  347,  354,    0,  589,    0,  589, yy_Dummy>>,
			1, 200, 3000)
		end

	yy_chk_template_17 (an_array: ARRAY [INTEGER])
			-- Fill chunk #17 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  589,  589,  589,  355,  737,  737,  737,  737,  623,  794,
			  623,  356,    0,    0,  348,  348,  348,  348,  348,  348,
			  348,  348,  349,  349,  349,  349,  349,  349,  349,  349,
			  350,  350,  350,  350,  350,  350,  350,  350,  357,  589,
			  623,  794,  623,  796,  351,  351,  351,  351,  351,  351,
			  351,  351,  352,  352,  352,  352,  352,  352,  352,  352,
			  358,  739,  739,  739,  739,  353,  353,  353,  353,  353,
			  353,  353,  353,  359,  661,  796,  800,  661,  354,  354,
			  354,  354,  354,  354,  354,  354,  355,  355,  355,  355,
			  355,  355,  355,  355,  356,  356,  356,  356,  356,  356,

			  356,  356,  360,  462,  772,  772,  661,  462,  800,  661,
			  432,    0,  596,  361,  596,  596,  596,  596,    0,    0,
			  432,  357,  357,  357,  357,  357,  357,  357,  357,  362,
			    0,    0,    0,  444,  466,  462,  772,  772,  466,  462,
			  363,  444,  432,  358,  358,  358,  358,  358,  358,  358,
			  358,  364,  432,    0,  596,    0,  359,  359,  359,  359,
			  359,  359,  359,  359,  365,  444,  466,    0,    0,    0,
			  466,    0,  467,  444,  802,  366,  467,  729,  729,  729,
			  729,  729,  360,  360,  360,  360,  360,  360,  360,  360,
			  360,  360,  360,  361,  361,  361,  361,  361,  361,  361, yy_Dummy>>,
			1, 200, 3200)
		end

	yy_chk_template_18 (an_array: ARRAY [INTEGER])
			-- Fill chunk #18 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  361,  361,  361,  361,  467,    0,  802,    0,  467,  362,
			  362,  362,  362,  362,  362,  362,  362,  362,  362,  362,
			  363,  363,  363,  363,  363,  363,  363,  363,  363,  363,
			  363,  364,  364,  364,  364,  364,  364,  364,  364,  364,
			  364,  364,  810,    0,  365,  365,  365,  365,  365,  365,
			  365,  365,  365,  365,  365,  366,  366,  366,  366,  366,
			  366,  366,  366,  366,  366,  366,  379,  379,  379,  379,
			    0,  389,  822,  390,  810,  390,  379,  379,  379,  379,
			  379,  379,  389,  395,  389,  390,  392,  394,  392,  453,
			  394,  395,  394,    0,  389,    0,  453,    0,  392,  828,

			  395,    0,  394,  389,  822,  390,  379,  390,  379,  379,
			  379,  379,  379,  379,  389,  395,  389,  390,  392,  394,
			  392,  453,  394,  395,  394,  396,  389,  405,  453,  405,
			  392,  828,  395,  428,  394,  407,  396,  641,  396,  405,
			  413,  428,  396,  409,  407,  409,  407,  428,  396,  641,
			  409,  413,  411,  413,  411,  409,  407,  396,    0,  405,
			    0,  405,  411,  413,  411,  428,    0,  407,  396,  641,
			  396,  405,  413,  428,  396,  409,  407,  409,  407,  428,
			  396,  641,  409,  413,  411,  413,  411,  409,  407,    0,
			  419,  415,  419,  415,  411,  413,  411,  415,  420,  419, yy_Dummy>>,
			1, 200, 3400)
		end

	yy_chk_template_19 (an_array: ARRAY [INTEGER])
			-- Fill chunk #19 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  830,  423,  419,  415,  452,  420,    0,  420,  423,  426,
			  423,  426,  452,  458,  478,  421,    0,  420,  478,  458,
			  423,  426,  419,  415,  419,  415,  421,    0,  421,  415,
			  420,  419,  830,  423,  419,  415,  452,  420,  421,  420,
			  423,  426,  423,  426,  452,  458,  478,  421,  430,  420,
			  478,  458,  423,  426,  427,    0,  427,  834,  421,  430,
			  421,  430,  430,  427,  471,  431,  427,  439,    0,  439,
			  421,  430,  431,  471,  431,  433,    0,  433,    0,  439,
			  430,    0,  433,    0,  431,    0,  427,  433,  427,  834,
			    0,  430,    0,  430,  430,  427,  471,  431,  427,  439,

			  435,  439,  435,  430,  431,  471,  431,  433,  435,  433,
			  446,  439,  435,  446,  433,  446,  431,  445,  855,  433,
			  447,  437,  437,  437,  445,  446,  445,  447,    0,  447,
			    0,    0,  435,  437,  435,  437,  445,  857,    0,  447,
			  435,    0,  446,    0,  435,  446,    0,  446,    0,  445,
			  855,    0,  447,  437,  437,  437,  445,  446,  445,  447,
			  448,  447,  448,  449,  448,  437,  451,  437,  445,  857,
			  454,  447,  448,  451,  449,  451,  449,    0,  455,  625,
			  455,  454,  455,  454,    0,  451,  449,    0,  625,  461,
			  455,  461,  448,  454,  448,  449,  448,  459,  451,  459, yy_Dummy>>,
			1, 200, 3600)
		end

	yy_chk_template_20 (an_array: ARRAY [INTEGER])
			-- Fill chunk #20 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  459,  461,  454,    0,  448,  451,  449,  451,  449,  459,
			  455,  625,  455,  454,  455,  454,  468,  451,  449,  457,
			  625,  461,  455,  461,  468,  454,  457,  463,  457,  459,
			  486,  459,  459,  461,  463,  486,  463,  464,  457,  470,
			  464,  459,  479,  464,  465,  470,  463,  465,  468,    0,
			  479,  457,  865,  465,  472,  465,  468,  470,  457,  463,
			  457,  472,  486,  472,    0,  465,  463,  486,  463,  464,
			  457,  470,  464,  472,  479,  464,  465,  470,  463,  465,
			    0,  473,  479,  474,  865,  465,  472,  465,  473,  470,
			  473,  671,    0,  472,  474,  472,  474,  465,  476,  475,

			  473,  475,  491,  671,    0,  472,  474,  476,  475,  476,
			  491,  475,  477,  473,  477,  474,  476,    0,  477,  476,
			  473,  482,  473,  671,  477,  482,  474,    0,  474,    0,
			  476,  475,  473,  475,  491,  671,  481,  875,  474,  476,
			  475,  476,  491,  475,  477,  480,  477,  481,  476,  481,
			  477,  476,  480,  482,  480,    0,  477,  482,  488,  481,
			    0,  498,  488,  483,  480,    0,  498,    0,  481,  875,
			  483,  490,  483,  485,    0,  490,  485,  480,  485,  481,
			  877,  481,  483,    0,  480,  487,  480,  487,  485,    0,
			  488,  481,  489,  498,  488,  483,  480,  487,  498,  489, yy_Dummy>>,
			1, 200, 3800)
		end

	yy_chk_template_21 (an_array: ARRAY [INTEGER])
			-- Fill chunk #21 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			    0,  489,  483,  490,  483,  485,  493,  490,  485,    0,
			  485,  489,  877,  493,  483,  493,  494,  487,  494,  487,
			  485,  494,  617,  881,  489,  493,  617,  495,  494,  487,
			  495,  489,  495,  489,  497,  500,  499,  497,  493,  497,
			  500,  506,  495,  489,  499,  493,  499,  493,  494,  497,
			  494,  507,    0,  494,  617,  881,  499,  493,  617,  495,
			  494,  501,  495,  501,  495,  508,  497,  500,  499,  497,
			  523,  497,  500,  501,  495,  503,  499,  503,  499,  598,
			  602,  497,  509,  741,  741,  741,  741,  503,  499,  598,
			  602,  506,    0,  501,  510,  501,  743,  743,  743,  743,

			    0,  507,    0,    0,    0,  501,  511,  503,    0,  503,
			  621,  598,  602,    0,  621,  508,    0,    0,    0,  503,
			    0,  598,  602,  512,  506,  506,  506,  506,  506,  506,
			  506,  506,  509,  524,  507,  507,  507,  507,  507,  507,
			  507,  507,  621,    0,  510,  525,  621,    0,  508,  508,
			  508,  508,  508,  508,  508,  508,  511,  523,  523,  523,
			  523,  523,  523,  523,  523,  509,  509,  509,  509,  509,
			  509,  509,  509,  512,  510,  510,  510,  510,  510,  510,
			  510,  510,  510,  510,  510,  526,  511,  511,  511,  511,
			  511,  511,  511,  511,  511,  511,  511,  527,  845,  845, yy_Dummy>>,
			1, 200, 4000)
		end

	yy_chk_template_22 (an_array: ARRAY [INTEGER])
			-- Fill chunk #22 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  845,  845,    0,  512,  512,  512,  512,  512,  512,  512,
			  512,  512,  512,  512,  528,  667,    0,  887,  667,  524,
			  524,  524,  524,  524,  524,  524,  524,  524,  529,  525,
			  525,  525,  525,  525,  525,  525,  525,  525,  525,  525,
			  530,    0,    0,  531,    0,    0,  531,  667,  531,  887,
			  667,  531,  532,    0,    0,  532,    0,  532,    0,    0,
			  532,  639,  903,  533,  909,  639,  533,    0,  533,  526,
			  526,  533,  526,  526,  526,  526,  526,  526,  526,  526,
			    0,  527,  527,  527,  527,  527,  527,  527,  527,  527,
			  527,  527,    0,  639,  903,    0,  909,  639,    0,  528,

			  528,  528,  528,  528,  528,  528,  528,  528,  528,    0,
			    0,    0,  529,  529,  529,  529,  529,  529,  529,  529,
			  529,  529,  529,    0,  530,    0,    0,  530,  530,  530,
			  530,  530,  530,  530,  530,  531,  531,  531,  531,  531,
			  531,  531,  531,  600,  532,  532,  532,  532,  532,  532,
			  532,  532,  548,    0,  600,  533,  533,  533,  533,  533,
			  533,  533,  533,  534,    0,  633,  534,    0,  534,    0,
			  633,  534,    0,    0,  535,  600,    0,  535,    0,  535,
			    0,    0,  535,    0,    0,  536,  600,    0,  536,    0,
			  536,    0,    0,  536,    0,    0,  537,  633,  913,  537, yy_Dummy>>,
			1, 200, 4200)
		end

	yy_chk_template_23 (an_array: ARRAY [INTEGER])
			-- Fill chunk #23 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			    0,  537,  633,    0,  537,  538,  538,  538,  538,  538,
			  538,  538,  538,  539,  539,  539,  539,  539,  539,  539,
			  539,  540,  540,  540,  540,  540,  540,  540,  540,  545,
			  913,    0,  545,    0,    0,  548,  548,  548,  548,  548,
			  548,  548,  548,    0,    0,    0,  843,  542,  843,    0,
			  542,  843,  843,  843,  843,  534,  534,  534,  534,  534,
			  534,  534,  534,  535,  535,  535,  535,  535,  535,  535,
			  535,  535,  535,  535,  536,  536,  536,  536,  536,  536,
			  536,  536,  536,  536,  536,  537,  537,  537,  537,  537,
			  537,  537,  537,  537,  537,  537,  542,  543,    0,    0,

			  543,    0,  597,    0,  597,  597,  597,  597,    0,    0,
			    0,  544,    0,    0,  544,  615,  545,  545,  545,  545,
			  545,  545,  545,  545,  546,  615,  915,  546,  542,  580,
			  580,  580,  580,  719,  542,  542,  542,  542,  542,  542,
			  542,  542,  547,  580,  597,  547,  543,  615,  651,    0,
			  734,  734,  734,  734,  549,    0,    0,  615,  915,    0,
			  544,    0,  550,  651,  734,  619,    0,    0,    0,  580,
			  551,  849,  849,  849,  849,  580,  619,  917,  543,    0,
			  651,  552,    0,    0,  543,  543,  543,  543,  543,  543,
			  543,  543,  544,  553,    0,  651,  734,  619,  544,  544, yy_Dummy>>,
			1, 200, 4400)
		end

	yy_chk_template_24 (an_array: ARRAY [INTEGER])
			-- Fill chunk #24 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  544,  544,  544,  544,  544,  544,  554,    0,  619,  917,
			    0,  546,  546,  546,  546,  546,  546,  546,  546,    0,
			  719,  719,  719,  719,  719,  719,  719,  719,    0,  547,
			  547,  547,  547,  547,  547,  547,  547,  549,  549,  549,
			  549,  549,  549,  549,  549,  550,  550,  550,  550,  550,
			  550,  550,  550,  551,  551,  551,  551,  551,  551,  551,
			  551,  552,  552,  552,  552,  552,  552,  552,  552,  552,
			  552,  552,  577,  553,  553,  553,  553,  553,  553,  553,
			  553,  553,  553,  553,  578,    0,  554,  554,  554,  554,
			  554,  554,  554,  554,  554,  554,  554,  560,  584,  584,

			  584,  584,  635,  846,  635,  560,  560,  560,  560,  560,
			  579,  606,  584,  627,  635,  675,  923,  606,  675,  627,
			    0,    0,    0,  735,  735,  735,  735,    0,    0,  846,
			  850,  850,  850,  850,  635,  846,  635,    0,  584,  740,
			  740,  740,  740,  606,  584,  627,  635,  675,  923,  606,
			  675,  627,  577,  577,  577,  577,  577,  577,  577,  577,
			  577,  577,  577,  735,  578,  578,  578,  578,  578,  578,
			  578,  578,  578,  578,  578,  852,  852,  852,  852,  740,
			  560,  560,  560,  560,  560,  560,  560,  560,    0,    0,
			  579,  579,  579,  579,  579,  579,  579,  579,  579,  579, yy_Dummy>>,
			1, 200, 4600)
		end

	yy_chk_template_25 (an_array: ARRAY [INTEGER])
			-- Fill chunk #25 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  579,  599,  601,  599,  601,  603,  631,  603,  599,    0,
			  601,  605,  603,  599,  601,  631,  605,  603,  605,    0,
			  608,  644,    0,  655,    0,  644,  945,  655,  605,  608,
			    0,  608,    0,  599,  601,  599,  601,  603,  631,  603,
			  599,  608,  601,  605,  603,  599,  601,  631,  605,  603,
			  605,  609,  608,  644,  609,  655,  609,  644,  945,  655,
			  605,  608,  618,  608,  614,  614,  609,  614,  616,  618,
			  616,  618,  949,  608,    0,  616,    0,  614,    0,    0,
			  616,  618,    0,  609,  634,    0,  609,    0,  609,  927,
			  927,  927,  927,  634,  618,    0,  614,  614,  609,  614,

			  616,  618,  616,  618,  949,  689,  620,  616,  620,  614,
			  622,  689,  616,  618,  620,  624,  634,  622,  620,  622,
			  624,  626,  624,  626,  679,  634,  764,  626,  679,  622,
			  764,  746,  624,  626,    0,    0,    0,  689,  620,    0,
			  620,  746,  622,  689,    0,    0,  620,  624,    0,  622,
			  620,  622,  624,  626,  624,  626,  679,  628,  764,  626,
			  679,  622,  764,  746,  624,  626,  628,  630,  628,  632,
			  630,  632,  630,  746,  636,  632,  636,  695,  628,  637,
			  636,  632,  630,    0,  695,  638,  636,  638,  637,  628,
			    0,  638,    0,  645,    0,  645,    0,  638,  628,  630, yy_Dummy>>,
			1, 200, 4800)
		end

	yy_chk_template_26 (an_array: ARRAY [INTEGER])
			-- Fill chunk #26 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  628,  632,  630,  632,  630,  645,  636,  632,  636,  695,
			  628,  637,  636,  632,  630,  640,  695,  638,  636,  638,
			  637,    0,  640,  638,  640,  645,  642,  645,  642,  638,
			    0,  959,  646,  653,  640,  642,  683,  645,  642,  646,
			  648,  646,  653,  648,  657,  648,  684,  640,  683,  684,
			  650,  646,  650,  657,  640,  648,  640,  652,  642,  652,
			  642,    0,  650,  959,  646,  653,  640,  642,  683,  652,
			  642,  646,  648,  646,  653,  648,  657,  648,  684,    0,
			  683,  684,  650,  646,  650,  657,  654,  648,  654,  652,
			  656,  652,  654,  660,  650,  660,  756,  656,  654,  656,

			  658,  652,  658,  756,  701,  660,  658,  701,    0,  656,
			    0,  662,  658,  662,  664,    0,  664,    0,  654,    0,
			  654,    0,  656,  662,  654,  660,  664,  660,  756,  656,
			  654,  656,  658,    0,  658,  756,  701,  660,  658,  701,
			  666,  656,  666,  662,  658,  662,  664,  668,  664,  668,
			    0,  670,  666,  670,  705,  662,    0,  705,  664,  668,
			  677,  691,  674,  670,  673,  674,  673,  674,    0,  677,
			  691,  776,  666,  673,  666,  776,  673,  674,    0,  668,
			    0,  668,  676,  670,  666,  670,  705,    0,  676,  705,
			  676,  668,  677,  691,  674,  670,  673,  674,  673,  674, yy_Dummy>>,
			1, 200, 5000)
		end

	yy_chk_template_27 (an_array: ARRAY [INTEGER])
			-- Fill chunk #27 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  676,  677,  691,  776,  678,  673,  678,  776,  673,  674,
			  678,  680,  680,  680,  676,    0,  678,  762,  703,  685,
			  676,  685,  676,  680,  682,    0,  762,  682,  685,  682,
			  703,  685,  676,    0,    0,  686,  678,  686,  678,  682,
			    0,    0,  678,  680,  680,  680,    0,  686,  678,  762,
			  703,  685,  688,  685,  688,  680,  682,  690,  762,  682,
			  685,  682,  703,  685,  688,  688,  690,  686,  690,  686,
			  692,  682,  692,  694,  770,  694,  692,  790,  690,  686,
			  707,  790,  692,  770,  688,  694,  688,  774,  707,  690,
			  774,  696,    0,  696,  961,  696,  688,  688,  690,  698,

			  690,  698,  692,  696,  692,  694,  770,  694,  692,  790,
			  690,  698,  707,  790,  692,  770,  700,  694,  700,  774,
			  707,    0,  774,  696,  702,  696,  961,  696,  700,  752,
			  702,  698,  702,  698,  752,  696,    0,  704,    0,  704,
			  708,  720,  702,  698,  808,  706,  704,  706,  700,  704,
			  700,  708,    0,  708,  713,    0,  702,  706,  786,  808,
			  700,  752,  702,  708,  702,  714,  752,  786,  710,  704,
			  710,  704,  708,  715,  702,    0,  808,  706,  704,  706,
			  710,  704,  712,  708,  712,  708,  721,  766,  778,  706,
			  786,  808,  766,  778,  712,  708,  722,    0,    0,  786, yy_Dummy>>,
			1, 200, 5200)
		end

	yy_chk_template_28 (an_array: ARRAY [INTEGER])
			-- Fill chunk #28 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  710,    0,  710,  853,  713,  853,    0,  723,  853,  853,
			  853,  853,  710,  965,  712,  714,  712,    0,  724,  766,
			  778,    0,    0,  715,  766,  778,  712,    0,  720,  720,
			  720,  720,  720,  720,  720,  720,  725,  713,  713,  713,
			  713,  713,  713,  713,  713,  965,    0,    0,  714,  714,
			  714,  714,  714,  714,  714,  714,  715,  715,  715,  715,
			  715,  715,  715,  715,  726,    0,    0,  726,    0,  726,
			    0,    0,  726,  721,  721,  721,  721,  721,  721,  721,
			  721,  730,    0,  722,  722,  722,  722,  722,  722,  722,
			  722,  723,  723,  723,  723,  723,  723,  723,  723,  723,

			  723,  723,  724,  724,  724,  724,  724,  724,  724,  724,
			  724,  724,  724,  731,  742,  742,  742,  742,    0,    0,
			  725,  725,  725,  725,  725,  725,  725,  725,  725,  725,
			  725,  727,  732,    0,  727,    0,  727,    0,    0,  727,
			  728,  782,  780,  728,    0,  728,  782,  745,  728,  745,
			  745,  745,  745,  780,  742,  967,  726,  726,  726,  726,
			  726,  726,  726,  726,  730,  730,  730,  730,  730,  730,
			  730,  730,  733,  782,  780,  788,  798,  804,  782,  934,
			  788,  804,  798,    0,    0,  780,    0,  967,    0,  745,
			    0,  844,  844,  844,  844,    0,  731,  731,  731,  731, yy_Dummy>>,
			1, 200, 5400)
		end

	yy_chk_template_29 (an_array: ARRAY [INTEGER])
			-- Fill chunk #29 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  731,  731,  731,  731,    0,  934,    0,  788,  798,  804,
			    0,  934,  788,  804,  798,  732,  732,  732,  732,  732,
			  732,  732,  732,  727,  727,  727,  727,  727,  727,  727,
			  727,  844,  728,  728,  728,  728,  728,  728,  728,  728,
			  738,  738,  738,  738,  928,  928,  928,  928,    0,  744,
			  744,  744,  744,    0,  738,  733,  733,  733,  733,  733,
			  733,  733,  733,  744,  747,  749,  747,  749,    0,  757,
			  751,  747,  751,  753,  806,  753,  747,  749,  979,  757,
			  738,  757,  751,  806,  755,  753,  738,    0,  755,    0,
			  755,  757,    0,  985,    0,  744,  747,  749,  747,  749,

			  755,  757,  751,  747,  751,  753,  806,  753,  747,  749,
			  979,  757,  866,  757,  751,  806,  755,  753,  866,  759,
			  755,  759,  755,  757,  761,  985,  761,  763,  767,  763,
			  767,  759,  755,  763,    0,  998,  761,    0,  765,  763,
			  767,    0,  765,    0,  866,  765,    0,  765, 1002, 1004,
			  866,  759,  769,  759,  769,  820,  761,  765,  761,  763,
			  767,  763,  767,  759,  769,  763,  820,  998,  761,  773,
			  765,  763,  767,  773,  765,  773,  771,  765,  771,  765,
			 1002, 1004,  771,  777,  769,  773,  769,  820,  771,  765,
			  777,  775,  777,    0,    0,    0,  769,  775,  820,  775, yy_Dummy>>,
			1, 200, 5600)
		end

	yy_chk_template_30 (an_array: ARRAY [INTEGER])
			-- Fill chunk #30 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			    0,  773,  777, 1008, 1010,  773,    0,  773,  771,  775,
			  771,    0,    0,    0,  771,  777,    0,  773,  779,    0,
			  771,    0,  777,  775,  777,  781,  779,  781,  779,  775,
			  783,  775,  783,  781,  777, 1008, 1010,  781,  779,  816,
			    0,  775,  783,  785,  789,  785,  789,    0,  816,    0,
			  779,  929,  929,  929,  929,  785,  789,  781,  779,  781,
			  779,  787,  783,  787,  783,  781,    0,  787,    0,  781,
			  779,  816,  791,  787,  783,  785,  789,  785,  789,  791,
			  816,  791,  795,    0,  795,  812,    0,  785,  789,  812,
			    0,  791,  814,  787,  795,  787,  814,  793,  799,  787,

			  793,    0,  793,  797,  791,  787,  797,  799,  797,  799,
			  836,  791,  793,  791,  795,  836,  795,  812,  797,  799,
			    0,  812,  801,  791,  814,  801,  795,  801,  814,  793,
			  799,  803,  793,  803,  793,  797,    0,  801,  797,  799,
			  797,  799,  836,  803,  793,    0,    0,  836,  818,  805,
			  797,  799,  818,    0,  801,    0,  805,  801,  805,  801,
			  807, 1012,  807,  803,  861,  803,  807,  957,  805,  801,
			  957,  809,  807,  809,  811,  803,  861,  811,  813,  811,
			  818,  805,    0,  809,  818,  813,    0,  813,  805,  811,
			  805,  832,  807, 1012,  807,  832,  861,  813,  807,  957, yy_Dummy>>,
			1, 200, 5800)
		end

	yy_chk_template_31 (an_array: ARRAY [INTEGER])
			-- Fill chunk #31 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  805,    0,  957,  809,  807,  809,  811,  815,  861,  811,
			  813,  811,    0,    0,  815,  809,  815,  813,  817,  813,
			  817,  811, 1016,  832,  817,  819,  815,  832,  826,  813,
			  817,  824,  819,  821,  819,  821,  826, 1020,    0,  815,
			    0,  821,  824,    0,  819,  821,  815,  823,  815,  823,
			  817,    0,  817,    0, 1016,    0,  817,  819,  815,  823,
			  826,    0,  817,  824,  819,  821,  819,  821,  826, 1020,
			  825,  838,  825,  821,  824,  827,  819,  821,  825,  823,
			    0,  823,  825,  829,  831,  829,  827,  831,  827,  831,
			    0,  823,    0,  859,  833,  829,  839,  859,  827,  831,

			  863,  833,  825,  833,  825,  840,    0,  827,    0,    0,
			  825,  863,  869,  833,  825,  829,  831,  829,  827,  831,
			  827,  831,  835,  869,  835,  859,  833,  829,    0,  859,
			  827,  831,  863,  833,  835,  833,  837, 1024,  837,  848,
			  848,  848,  848,  863,  869,  833,  871,    0,  837, 1026,
			  871,    0,    0,    0,  835,  869,  835,    0,  838,  838,
			  838,  838,  838,  838,  838,  838,  835,    0,  837, 1024,
			  837,  851,  851,  851,  851,    0,    0,    0,  871,  848,
			  837, 1026,  871,  839,  839,  839,  839,  839,  839,  839,
			  839,    0,  840,  840,  840,  840,  840,  840,  840,  840, yy_Dummy>>,
			1, 200, 6000)
		end

	yy_chk_template_32 (an_array: ARRAY [INTEGER])
			-- Fill chunk #32 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  847,  847,  847,  847,  854,  854,  854,  854,  856,  873,
			  856,  851,  860,  858,  847,  858,  953,  873,  854,  860,
			  856,  860,  889,  953,  862,  858,  862,  864,    0,  864,
			    0,  860,  889,  862,    0,  864,  862, 1033,    0,  864,
			  856,  873,  856,    0,  860,  858,  847,  858,  953,  873,
			  854,  860,  856,  860,  889,  953,  862,  858,  862,  864,
			  867,  864,  867,  860,  889,  862,  883,  864,  862, 1033,
			  872,  864,  867,  868,  883,  868,  868,  872,  870,  872,
			  870,  876,    0,  876,    0,  868,  870,  879, 1037,  872,
			  870,  879,  867,  876,  867,    0,    0,    0,  883,    0,

			    0,    0,  872,  874,  867,  868,  883,  868,  868,  872,
			  870,  872,  870,  876,  874,  876,  874,  868,  870,  879,
			 1037,  872,  870,  879,  880,  876,  874,  878,  882,  878,
			  882,  880,  885,  880,  884,  874,  885, 1039, 1041,  878,
			  882,  893,    0,  880,    0,  884,  874,  884,  874,    0,
			  891,    0,  893,    0,    0,  891,  880,  884,  874,  878,
			  882,  878,  882,  880,  885,  880,  884,  886,  885, 1039,
			 1041,  878,  882,  893,  886,  880,  886,  884,  888,  884,
			  888,  890,  891,  890,  893,  895,  886,  891,  890,  884,
			  888, 1044,  892,  890,  892,  894,  895,  894,    0,  886, yy_Dummy>>,
			1, 200, 6200)
		end

	yy_chk_template_33 (an_array: ARRAY [INTEGER])
			-- Fill chunk #33 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			    0,  897,    0,  894,  892,  899,  886,  894,  886,  897,
			  888,  901,  888,  890,    0,  890,  899,  895,  886,    0,
			  890,  901,  888, 1044,  892,  890,  892,  894,  895,  894,
			  896,    0,  896,  897,  898,  894,  892,  899,  896,  894,
			  919,  897,  896,  901,  900,  898,  900,  898,  899,    0,
			  905,  919,  900,  901,  907,  905,  900,  898,    0,  907,
			    0,  902,  896,  902,  896,    0,  898,    0,  902,  904,
			  896,  904,  919,  902,  896,  921,  900,  898,  900,  898,
			  921,  904,  905,  919,  900,    0,  907,  905,  900,  898,
			  906,  907,  906,  902,  908,  902,  908,  910,    0,  910,

			  902,  904,  906,  904,  911,  902,  908,  921,  911,  910,
			    0,  912,  921,  904,  925,  914,    0,  914,  912,    0,
			  912,  916,  906,  916,  906,  925,  908,  914,  908,  910,
			  912,  910,    0,  916,  906,    0,  911,    0,  908,    0,
			  911,  910,  918,  912,  918,  973,  925,  914,    0,  914,
			  912,  973,  912,  916,  918,  916,  920,  925,  920,  914,
			    0,  922,  912,  922,  920,  916,  941,  924,  920,  924,
			  926,  941,  926,  922,  918,    0,  918,  973,  926,  924,
			  943,    0,  926,  973,    0, 1018,  918,    0,  920,    0,
			  920,  943,    0,  922, 1018,  922,  920,    0,  941,  924, yy_Dummy>>,
			1, 200, 6400)
		end

	yy_chk_template_34 (an_array: ARRAY [INTEGER])
			-- Fill chunk #34 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  920,  924,  926,  941,  926,  922,  932,  932,  932,  932,
			  926,  924,  943,  930,  926,  930,    0, 1018,  930,  930,
			  930,  930,  931,  943,  931,    0, 1018,  931,  931,  931,
			  931,  933,  933,  933,  933,  935,  935,  935,  935,  936,
			  936,  936,  936,    0,    0,    0,  932,  937,  937,  937,
			  937,  939,  939,  939,  939,  940,  942,  940,    0,    0,
			  940,  940,  940,  940,  942,  939,  942,  944,  946,  944,
			  946,  948,  947,  948,    0,  944,  942,  947,    0,  944,
			  946,  951,  950,  948,  950,    0,  951,  955,  942,    0,
			    0,  939,  955,    0,  950,    0,  942,  939,  942,  944,

			  946,  944,  946,  948,  947,  948,    0,  944,  942,  947,
			  954,  944,  946,  951,  950,  948,  950,  952,  951,  955,
			  954,  956,  954,    0,  955,  952,  950,  952,  958,  956,
			  958,  956,  954,  960,  962,  960,  962,  952,  969,    0,
			  958,  956,  954,  969,    0,  960,  962,    0,  963,  952,
			  963,    0,  954,  956,  954,    0,    0,  952,    0,  952,
			  958,  956,  958,  956,  954,  960,  962,  960,  962,  952,
			  969,    0,  958,  956,  964,  969,    0,  960,  962,  964,
			  963,  964,  963,  966,  968,  966,  968,  970,  971,  970,
			  975,  964,  971,  972,  975,  966,  968,    0,    0,  970, yy_Dummy>>,
			1, 200, 6600)
		end

	yy_chk_template_35 (an_array: ARRAY [INTEGER])
			-- Fill chunk #35 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  972,    0,  972,    0,    0,    0,  964,    0,  977,    0,
			    0,  964,  972,  964,  977,  966,  968,  966,  968,  970,
			  971,  970,  975,  964,  971,  972,  975,  966,  968,    0,
			  976,  970,  972,  974,  972,  974,  974,  976, 1006,  976,
			  977, 1006,  978,  981,  972,  974,  977,  981,  980,  976,
			  980,  978,  983,  978,    0,    0,  983,  982,    0,    0,
			  980,    0,  976,  978,  982,  974,  982,  974,  974,  976,
			 1006,  976,    0, 1006,  978,  981,  982,  974,    0,  981,
			  980,  976,  980,  978,  983,  978,    0,    0,  983,  982,
			  984,  986,  980,  986,    0,  978,  982,  984,  982,  984,

			    0,    0,    0,  986,  988,  988,  988,  988,  982,  984,
			  989,  989,  989,  989,  990,  990,  990,  990,  991,  991,
			  991,  991,  984,  986,    0,  986,    0,    0,    0,  984,
			    0,  984,  999,    0,  999,  986,  992,  992,  992,  992,
			  993,  984,  993,    0,  999,  993,  993,  993,  993,    0,
			  989,  995,  995,  995,  995,  996,  996,  996,  996,  997,
			  997,  997,  997, 1014,  999,  995,  999,    0, 1000, 1003,
			 1001, 1003, 1000, 1005, 1014, 1005,  999, 1001, 1007, 1001,
			 1007, 1003, 1009, 1022, 1009, 1005, 1011, 1022, 1011, 1001,
			 1007,  995, 1035,    0, 1009, 1014, 1035,  995, 1011,  997, yy_Dummy>>,
			1, 200, 6800)
		end

	yy_chk_template_36 (an_array: ARRAY [INTEGER])
			-- Fill chunk #36 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			 1000, 1003, 1001, 1003, 1000, 1005, 1014, 1005,    0, 1001,
			 1007, 1001, 1007, 1003, 1009, 1022, 1009, 1005, 1011, 1022,
			 1011, 1001, 1007, 1013, 1035, 1013, 1009,    0, 1035, 1015,
			 1011, 1015, 1017,    0, 1017, 1013, 1019, 1015, 1019,    0,
			    0, 1015, 1019, 1023, 1017,    0,    0, 1021, 1019, 1021,
			 1023,    0, 1023,    0,    0, 1013,    0, 1013,    0, 1021,
			    0, 1015, 1023, 1015, 1017,    0, 1017, 1013, 1019, 1015,
			 1019,    0,    0, 1015, 1019, 1023, 1017,    0,    0, 1021,
			 1019, 1021, 1023, 1025, 1023, 1025, 1027,    0, 1027,    0,
			    0, 1021,    0,    0, 1023, 1025,    0,    0, 1027, 1028,

			 1028, 1028, 1028, 1030, 1030, 1030, 1030, 1031, 1031, 1031,
			 1031, 1032, 1032, 1032, 1032, 1025,    0, 1025, 1027,    0,
			 1027, 1034, 1036, 1034, 1038,    0, 1038, 1025,    0, 1036,
			 1027, 1036, 1040, 1034, 1040,    0, 1038,    0, 1042, 1028,
			 1042, 1036,    0,    0, 1040,    0,    0, 1031,    0,    0,
			 1042, 1032,    0, 1034, 1036, 1034, 1038, 1045, 1038, 1045,
			    0, 1036,    0, 1036, 1040, 1034, 1040,    0, 1038, 1045,
			 1042,    0, 1042, 1036,    0,    0, 1040, 1043, 1043, 1043,
			 1043,    0, 1042,    0,    0,    0,    0,    0,    0, 1045,
			    0, 1045,    0,    0,    0,    0,    0,    0,    0,    0, yy_Dummy>>,
			1, 200, 7000)
		end

	yy_chk_template_37 (an_array: ARRAY [INTEGER])
			-- Fill chunk #37 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			    0, 1045,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0, 1043, 1047, 1047,
			 1047, 1047, 1047, 1047, 1047, 1047, 1047, 1047, 1047, 1047,
			 1047, 1047, 1047, 1047, 1047, 1047, 1047, 1047, 1047, 1047,
			 1047, 1047, 1047, 1047, 1047, 1047, 1047, 1047, 1047, 1047,
			 1047, 1047, 1047, 1047, 1047, 1047, 1047, 1047, 1047, 1048,
			 1048,    0, 1048, 1048, 1048, 1048, 1048, 1048, 1048, 1048,
			 1048, 1048, 1048, 1048, 1048, 1048, 1048, 1048, 1048, 1048,
			 1048, 1048, 1048, 1048, 1048, 1048, 1048, 1048, 1048, 1048,
			 1048, 1048, 1048, 1048, 1048, 1048, 1048, 1048, 1048, 1048,

			 1049,    0,    0,    0,    0,    0,    0, 1049, 1049, 1049,
			 1049, 1049, 1049, 1049, 1049, 1049, 1049, 1049, 1049, 1049,
			 1049, 1049, 1049, 1049, 1049, 1049, 1049, 1049, 1049, 1049,
			 1049, 1049, 1049, 1049, 1049, 1049, 1049, 1049, 1049, 1049,
			 1049, 1050, 1050,    0, 1050, 1050, 1050, 1050, 1050, 1050,
			 1050, 1050, 1050, 1050, 1050, 1050, 1050, 1050, 1050, 1050,
			 1050, 1050, 1050, 1050, 1050, 1050, 1050, 1050, 1050, 1050,
			 1050, 1050, 1050, 1050, 1050, 1050, 1050, 1050, 1050, 1050,
			 1050, 1050, 1051, 1051,    0, 1051, 1051, 1051, 1051,    0,
			 1051, 1051, 1051, 1051, 1051, 1051, 1051, 1051, 1051, 1051, yy_Dummy>>,
			1, 200, 7200)
		end

	yy_chk_template_38 (an_array: ARRAY [INTEGER])
			-- Fill chunk #38 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			 1051, 1051, 1051, 1051, 1051, 1051, 1051, 1051, 1051, 1051,
			 1051, 1051, 1051, 1051, 1051, 1051, 1051, 1051, 1051, 1051,
			 1051, 1051, 1051, 1052, 1052, 1052, 1052, 1052,    0,    0,
			 1052, 1052, 1052, 1052, 1052, 1052, 1052, 1052, 1052, 1052,
			 1052, 1052, 1052, 1052, 1052, 1052, 1052, 1052,    0, 1052,
			 1052, 1052, 1052, 1053, 1053,    0, 1053, 1053, 1053,    0,
			    0, 1053, 1053, 1053, 1053, 1053, 1053, 1053, 1053, 1053,
			 1053, 1053, 1053, 1053, 1053, 1053, 1053, 1053, 1053, 1053,
			 1053, 1053, 1053, 1053, 1053, 1053, 1053, 1053,    0, 1053,
			 1053, 1053, 1053, 1053, 1054, 1054, 1054, 1054,    0,    0,

			 1054, 1054, 1054, 1054, 1054, 1054, 1054, 1054, 1054, 1054,
			 1054, 1054, 1054, 1054, 1054, 1054, 1054, 1054,    0, 1054,
			 1054, 1054, 1054, 1054, 1055,    0,    0, 1055,    0,    0,
			 1055, 1055, 1055, 1055, 1055, 1055, 1055, 1055, 1055, 1055,
			 1055, 1055, 1055, 1055, 1055, 1055, 1055, 1055, 1055, 1055,
			 1055, 1055, 1055, 1055, 1055, 1055, 1055, 1055, 1055, 1055,
			 1055, 1055, 1055, 1055, 1055, 1056, 1056,    0, 1056, 1056,
			 1056, 1056, 1056, 1056, 1056, 1056, 1056, 1056, 1056, 1056,
			 1056, 1056, 1056, 1056, 1056, 1056, 1056, 1056, 1056, 1056,
			 1056, 1056, 1056, 1056, 1056, 1056, 1056, 1056, 1056, 1056, yy_Dummy>>,
			1, 200, 7400)
		end

	yy_chk_template_39 (an_array: ARRAY [INTEGER])
			-- Fill chunk #39 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			 1056, 1056, 1056, 1056, 1056, 1056, 1057, 1057, 1057, 1057,
			 1057,    0,    0,    0,    0,    0, 1057, 1057, 1057, 1057,
			 1057, 1057, 1057, 1057, 1057, 1057, 1057, 1057, 1057, 1057,
			 1057, 1057, 1058,    0,    0,    0,    0, 1058, 1058, 1058,
			 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058,
			 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058,
			 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058,
			 1058, 1058, 1058, 1059, 1059, 1059, 1059, 1059, 1059, 1059,
			 1059, 1059, 1059,    0, 1059, 1059, 1059, 1059, 1059, 1059,
			 1059, 1059, 1059, 1059, 1059, 1059, 1059, 1059, 1059, 1059,

			 1059, 1059, 1059, 1059, 1059, 1059, 1059, 1059, 1059, 1059,
			 1059, 1059, 1059, 1059, 1060, 1060, 1060, 1060,    0,    0,
			 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060,
			 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060,    0, 1060,
			 1060, 1060, 1060, 1061, 1061, 1061, 1061,    0,    0, 1061,
			 1061, 1061, 1061, 1061, 1061, 1061, 1061, 1061, 1061, 1061,
			 1061, 1061, 1061, 1061, 1061, 1061, 1061,    0, 1061, 1061,
			 1061, 1061, 1062, 1062, 1062, 1062,    0,    0, 1062, 1062,
			 1062, 1062, 1062, 1062, 1062, 1062, 1062, 1062, 1062, 1062,
			 1062, 1062, 1062, 1062, 1062, 1062,    0, 1062, 1062, 1062, yy_Dummy>>,
			1, 200, 7600)
		end

	yy_chk_template_40 (an_array: ARRAY [INTEGER])
			-- Fill chunk #40 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			 1062, 1063, 1063,    0, 1063, 1063, 1063,    0, 1063, 1063,
			 1063, 1063, 1063, 1063, 1063, 1063, 1063, 1063, 1063, 1063,
			 1063, 1063, 1063, 1063, 1063, 1063, 1063, 1063, 1063, 1063,
			 1063, 1063, 1063, 1063, 1063, 1063, 1063, 1063, 1063, 1063,
			 1063, 1063, 1064, 1064, 1064, 1064, 1064, 1064, 1064, 1064,
			 1064, 1064,    0, 1064, 1064, 1064, 1064, 1064, 1064, 1064,
			 1064, 1064, 1064, 1064, 1064, 1064, 1064, 1064, 1064, 1064,
			 1064, 1064, 1064, 1064, 1064, 1064, 1064, 1064, 1064, 1064,
			 1064, 1064, 1064, 1046, 1046, 1046, 1046, 1046, 1046, 1046,
			 1046, 1046, 1046, 1046, 1046, 1046, 1046, 1046, 1046, 1046,

			 1046, 1046, 1046, 1046, 1046, 1046, 1046, 1046, 1046, 1046,
			 1046, 1046, 1046, 1046, 1046, 1046, 1046, 1046, 1046, 1046,
			 1046, 1046, 1046, 1046, 1046, 1046, 1046, 1046, 1046, 1046,
			 1046, 1046, 1046, 1046, 1046, 1046, 1046, 1046, 1046, 1046,
			 1046, 1046, 1046, 1046, 1046, 1046, 1046, 1046, 1046, 1046,
			 1046, 1046, 1046, 1046, 1046, 1046, 1046, 1046, 1046, 1046,
			 1046, 1046, 1046, 1046, 1046, 1046, 1046, 1046, 1046, 1046,
			 1046, 1046, 1046, 1046, 1046, 1046, 1046, 1046, 1046, 1046,
			 1046, 1046, 1046, 1046, 1046, yy_Dummy>>,
			1, 185, 7800)
		end

	yy_base_template: SPECIAL [INTEGER]
			-- Template for `yy_base'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 1064)
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
			    0,    0,    0,  100,  113,  646, 7883,  642, 7883,  628,
			  620,  611,  127,    0, 7883,  135,  144, 7883, 7883, 7883,
			 7883, 7883,   91,   91,  102,  228,  104,  579, 7883,  104,
			 7883,  105,  578,  294,  225,  103,  220,  224,  366,   68,
			  363,  117,  209,  371,  105,  237,  382,  370,  280,  385,
			   98,  232, 7883,  545, 7883, 7883,  370,  440,  448,  513,
			  443,  515,  585,  432,  581,  592,  596,  632,  633,  648,
			  649,  694,  685,  699,  712,  713, 7883, 7883, 7883,  112,
			  488,  125,   65,  191,   67,  219,  412,  400,  599, 7883,
			  788,  746, 7883,  798,  432,  476,  718,  729,  756,  744,

			  767,  809,  500, 7883,  457, 7883,  824, 7883,  441,  871,
			  904,  919,  933,  954,  980, 1001, 1028, 1049,    0,  966,
			 1075, 1096, 1107, 1123, 1144, 1154, 1170, 1202, 1131,  445,
			 1297, 1261, 1270, 1281, 1308, 1320, 1330, 1372, 1390, 7883,
			 7883, 7883,  914, 7883, 7883, 7883,  929,  364,  105,  160,
			  558, 1472,  924, 7883, 7883, 7883, 7883, 7883, 7883,  136,
			  372,  387,  231,  389,  444,  515, 1455, 1468, 1476, 1507,
			 1511, 1514, 1522,  228,  306,  260,   71,  550,   77,  653,
			  306,  517, 1525,  440,  924,  689, 1097,  640, 1538, 1571,
			 1574, 1575, 1578, 1591,  217, 1633, 1602,  513, 1241, 1245, yy_Dummy>>,
			1, 200, 0)
		end

	yy_base_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			 1630, 1651, 1648,  698, 1250,  583, 1666, 1687, 1691,  365,
			 1405, 1710,  441, 1712, 1728, 1781, 1753, 1069, 1751, 1767,
			 1819, 1632, 1792, 1476, 1146, 1410,  453, 1827, 1816, 1844,
			 1843, 1248, 1872, 1888, 1937, 1406, 1592, 1641, 1879, 1918,
			 1934, 1704, 1235, 1955, 1973, 1865, 1994, 1712,  529, 1998,
			 2019, 1718, 2027, 1895, 2035, 7883, 2038, 2052, 2063, 2079,
			 2094, 2105, 2120, 2171, 2196,  685,  290,  703,   86,  778,
			   98,  824,  187,  839,  864,  886,  890,  948,  995,  999,
			 1338, 1358, 2129, 2142, 2153, 2182, 2206, 2217, 2228, 1995,
			 2029, 2239, 7883, 2284, 2339, 2343, 7883, 2348, 2357, 2384,

			 2395, 2406, 2367, 2417, 2517, 2434, 2442, 2450, 2458, 2469,
			 2480, 2491, 1090, 2591, 2612, 2626, 2641, 2659, 2674, 2688,
			 2721, 2736, 2754, 2783, 2791, 2816, 2831, 2849, 2767, 7883,
			 2799, 2858, 2890, 2907, 2922, 2949, 2960, 2981, 2968, 2989,
			  245, 2998, 3013, 3080, 3021, 3029, 3059, 3093, 3120, 3128,
			 3136, 3150, 3158, 3171, 3184, 3192, 3200, 3227, 3249, 3262,
			 3291, 3302, 3318, 3329, 3340, 3353, 3364, 1928, 2106, 1135,
			 7883, 2604, 2408, 2582,  262,  762,  192, 1329,  177, 3446,
			  159, 2623, 2634, 1760, 2587, 1652, 2754, 1716,  582, 3441,
			 3432,  646, 3445,  763, 3449, 3453, 3495, 1090, 1094, 1165, yy_Dummy>>,
			1, 200, 200)
		end

	yy_base_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			 1184, 1244, 1293, 1369,  863, 3486, 1941, 3503, 2318, 3502,
			 1761, 3511, 2333, 3510, 3094, 3550, 1520, 1986, 2591, 3549,
			 3564, 3585, 2601, 3567,  915, 1773, 3568, 3613, 3503, 2758,
			 3618, 3631, 3272, 3634, 1809, 3659, 2923, 3680, 2678, 3626,
			 2806,  953, 2836, 3095, 3303, 3683, 3672, 3686, 3719, 3733,
			 2900, 3732, 3574, 3451, 3740, 3737, 3100, 3785, 3575, 3756,
			  999, 3748, 3269, 3793, 3805, 3812, 3300, 3338, 3786, 2016,
			 3807, 3626, 3820, 3847, 3853, 3858, 3866, 3871, 3580, 3812,
			 3911, 3906, 3887, 3929, 1045, 3935, 3792, 3944, 3924, 3958,
			 3937, 3864, 1066, 3972, 3975, 3989, 1096, 3996, 3928, 4003,

			 3997, 4020, 1140, 4034, 7883, 7883, 4030, 4040, 4054, 4071,
			 4083, 4095, 4112, 1408, 1434, 1544, 1818, 1848, 2004, 2050,
			 2076, 2117, 2167, 4063, 4126, 4138, 4178, 4190, 4207, 4221,
			 4233, 4241, 4250, 4261, 4361, 4372, 4383, 4394, 4311, 4319,
			 4327, 2450, 4440, 4490, 4504, 4422, 4517, 4535, 4341, 4543,
			 4551, 4559, 4570, 4582, 4595, 7883, 7883, 7883, 7883, 7883,
			 4686, 7883, 7883, 7883, 7883, 7883, 7883, 7883, 7883, 7883,
			 7883, 7883, 7883, 7883, 7883, 7883, 7883, 4661, 4673, 4699,
			 4509, 2653, 2782, 2681, 4678, 2952, 3005, 3013, 3123, 3179,
			 2124,  128, 2310,  126,    0,  106, 3294, 4484, 4041, 4760, yy_Dummy>>,
			1, 200, 400)
		end

	yy_base_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			 4305, 4761, 4042, 4764, 2835, 4775, 4679, 1221, 4788, 4813,
			 2641, 2754, 2828, 2924, 4824, 4477, 4827, 3988, 4828, 4527,
			 4865, 4076, 4876, 3172, 4879, 3741, 4880, 4681, 4925, 1407,
			 4929, 4768, 4928, 4327, 4846, 4661, 4933, 4941, 4944, 4227,
			 4981, 3499, 4985, 1408, 4787, 4952, 4998, 1535, 5002, 2322,
			 5009, 4510, 5016, 4995, 5045, 4789, 5056, 5006, 5059, 1550,
			 5052, 3236, 5070, 1642, 5073, 1730, 5099, 4177, 5106, 1906,
			 5110, 3853, 1968, 5123, 5124, 4680, 5147, 5122, 5163, 4886,
			 5170, 2047, 5186, 4998, 5008, 5178, 5194, 3098, 5211, 4873,
			 5225, 5123, 5229, 2084, 5232, 4939, 5250, 2282, 5258, 2323,

			 5275, 5069, 5289, 5180, 5296, 5116, 5304, 5250, 5310, 2371,
			 5327, 2450, 5341, 5343, 5354, 5362, 2844, 2938, 2946, 4526,
			 5334, 5379, 5389, 5400, 5411, 5429, 5462, 5529, 5538, 3358,
			 5470, 5502, 5521, 5561, 4530, 4703, 3128, 3184, 5620, 3241,
			 4719, 4063, 5494, 4076, 5629, 5529, 4893, 5623, 2679, 5624,
			 2680, 5629, 5291, 5632, 3036, 5647, 5065, 5638, 2773, 5678,
			 2787, 5683, 5179, 5686, 4892, 5704, 5349, 5687, 2925, 5711,
			 5236, 5735, 3267, 5732, 5252, 5756, 5137, 5749, 5355, 5785,
			 5504, 5784, 5503, 5789, 2942, 5802, 5320, 5820, 5537, 5803,
			 5243, 5838, 3097, 5859, 3171, 5841, 3205, 5865, 5544, 5866, yy_Dummy>>,
			1, 200, 600)
		end

	yy_base_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			 3238, 5884, 3336, 5890, 5543, 5915, 5636, 5919, 5306, 5930,
			 3404, 5936, 5851, 5944, 5858, 5973, 5801, 5977, 5914, 5991,
			 5717, 5992, 3434, 6006, 5993, 6029, 5998, 6045, 3461, 6042,
			 3562, 6046, 5957, 6060, 3619, 6081, 5872, 6095, 6064, 6089,
			 6098,  132, 7883, 4431, 5571, 4178, 4669, 6180, 6119, 4551,
			 4710, 6151, 4755, 5388, 6184, 3680, 6167, 3699, 6172, 6059,
			 6178, 5926, 6183, 6062, 6186, 3814, 5674, 6219, 6232, 6074,
			 6237, 6112, 6236, 6179, 6273, 3899, 6240, 3942, 6286, 6253,
			 6290, 3985, 6287, 6236, 6304, 6298, 6333, 4179, 6337, 6184,
			 6340, 6312, 6351, 6303, 6354, 6347, 6389, 6371, 6404, 6367,

			 6403, 6373, 6420, 4224, 6428, 6412, 6449, 6416, 6453, 4226,
			 6456, 6470, 6477, 4360, 6474, 4488, 6480, 4539, 6501, 6402,
			 6515, 6437, 6520, 4678, 6526, 6476, 6529, 4869, 5624, 5831,
			 6598, 6607, 6586, 6611, 5545, 6615, 6619, 6627, 7883, 6631,
			 6640, 6533, 6623, 6542, 6626, 4788, 6627, 6634, 6630, 4834,
			 6641, 6648, 6684, 6185, 6679, 6654, 6688, 5929, 6687, 4993,
			 6692, 5256, 6693, 6712, 6738, 5375, 6742, 5517, 6743, 6700,
			 6746, 6754, 6759, 6507, 6792, 6756, 6796, 6776, 6810, 5640,
			 6807, 6809, 6823, 6818, 6856, 5655, 6850,   79, 6884, 6890,
			 6894, 6898, 6916, 6925,   68, 6931, 6935, 6939, 5697, 6891, yy_Dummy>>,
			1, 200, 800)
		end

	yy_base_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			 6934, 6936, 5710, 6928, 5711, 6932, 6800, 6937, 5765, 6941,
			 5766, 6945, 5923, 6982, 6925, 6988, 5984, 6991, 6547, 6995,
			 5999, 7006, 6949, 7009, 6099, 7042, 6111, 7045, 7079,   50,
			 7083, 7087, 7091, 6199, 7080, 6958, 7088, 6250, 7083, 6299,
			 7091, 6300, 7097, 7157, 6353, 7116, 7883, 7217, 7258, 7299,
			 7340, 7381, 7412, 7452, 7482, 7523, 7564, 7600, 7631, 7672,
			 7702, 7731, 7760, 7800, 7841, yy_Dummy>>,
			1, 65, 1000)
		end

	yy_def_template: SPECIAL [INTEGER]
			-- Template for `yy_def'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 1064)
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
			    0, 1046,    1, 1047, 1047, 1046, 1046, 1046, 1046, 1046,
			 1046, 1046, 1048, 1049, 1046, 1050, 1051, 1046, 1046, 1046,
			 1046, 1046, 1046, 1046, 1046, 1052, 1052, 1046, 1046, 1046,
			 1046, 1046, 1046, 1046,   33,   34,   34,   34,   34,   34,
			   34,   34,   34,   34,   34,   34,   34,   34,   34,   34,
			   34,   34, 1046, 1046, 1046, 1046, 1053, 1054, 1054, 1054,
			   59,   59,   61,   61,   61,   61,   61,   61,   61,   61,
			   61,   61,   61,   61,   61,   61, 1046, 1046, 1046, 1046,
			 1046, 1046, 1046, 1046, 1046, 1046, 1046, 1055, 1046, 1046,
			 1055, 1046, 1046, 1056, 1055, 1055, 1055, 1055, 1055, 1055,

			 1055, 1055, 1046, 1046, 1046, 1046, 1048, 1046, 1057, 1048,
			 1048, 1048, 1048, 1048, 1048, 1048, 1048, 1048, 1049, 1050,
			 1050, 1050, 1050, 1050, 1050, 1050, 1050, 1050, 1058, 1046,
			 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1046,
			 1046, 1046, 1046, 1046, 1046, 1046, 1059, 1052, 1052, 1060,
			 1061, 1062, 1052, 1046, 1046, 1046, 1046, 1046, 1046,   34,
			   34,   34,   34,   34,   34,   34,   61,   61,   61,   61,
			   61,   61,   61, 1046, 1046, 1046, 1046, 1046, 1046, 1046,
			 1046,   34,   61,   34,   34,   34,   34,   34,   61,   61,
			   61,   61,   61,   34,   34,   61,   61,   34,   34,   34, yy_Dummy>>,
			1, 200, 0)
		end

	yy_def_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			   61,   61,   61,   34,   34,   34,   61,   61,   61,   34,
			   34,   34,   34,   61,   61,   61,   61,   34,   34,   61,
			   61,   34,   61,   34,   34,   34,   34,   61,   61,   61,
			   61,   34,   61,   34,   61,   34,   34,   34,   61,   61,
			   61,   34,   34,   61,   61,   34,   61,   34,   34,   61,
			   61,   34,   61,   34,   61, 1046, 1053, 1053, 1053, 1053,
			 1053, 1053, 1053, 1053, 1053, 1046, 1046, 1046, 1046, 1046,
			 1046, 1046, 1046, 1046, 1046, 1046, 1046, 1046, 1046, 1046,
			 1055, 1055, 1055, 1055, 1055, 1055, 1055, 1055, 1055, 1046,
			 1046, 1063, 1046, 1055, 1056, 1046, 1046, 1056, 1056, 1056,

			 1056, 1056, 1056, 1056, 1056, 1055, 1055, 1055, 1055, 1055,
			 1055, 1055, 1046, 1048, 1048, 1048, 1048, 1048, 1048, 1048,
			 1048, 1050, 1050, 1050, 1050, 1050, 1050, 1050, 1058, 1046,
			 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058,
			 1046, 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058,
			 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1058,
			 1058, 1058, 1058, 1058, 1058, 1058, 1058, 1046, 1046, 1046,
			 1046, 1046, 1046, 1052, 1052, 1060, 1060, 1061, 1061, 1062,
			 1062, 1052, 1052,   34,   61,   34,   61,   34,   34,   61,
			   61,   34,   61,   34,   61,   34,   61, 1046, 1046, 1046, yy_Dummy>>,
			1, 200, 200)
		end

	yy_def_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			 1046, 1046, 1046, 1046,   34,   61,   34,   61,   34,   61,
			   34,   61,   34,   61,   34,   61,   34,   34,   34,   61,
			   61,   61,   34,   61,   34,   34,   61,   61,   34,   34,
			   61,   61,   34,   61,   34,   61,   34,   61,   34,   61,
			   34,   34,   34,   34,   34,   61,   61,   61,   61,   61,
			   34,   61,   34,   34,   61,   61,   34,   61,   34,   61,
			   34,   61,   34,   61,   34,   61,   34,   34,   34,   34,
			   34,   34,   61,   61,   61,   61,   61,   61,   34,   34,
			   61,   61,   34,   61,   34,   61,   34,   61,   34,   61,
			   34,   34,   34,   61,   61,   61,   34,   61,   34,   61,

			   34,   61,   34,   61, 1046, 1046, 1053, 1053, 1053, 1053,
			 1053, 1053, 1053, 1046, 1046, 1046, 1046, 1046, 1046, 1046,
			 1046, 1046, 1046, 1063, 1063, 1063, 1063, 1063, 1063, 1063,
			 1063, 1056, 1056, 1056, 1056, 1056, 1056, 1056, 1055, 1055,
			 1055, 1046, 1048, 1048, 1048, 1050, 1050, 1050, 1058, 1058,
			 1058, 1058, 1058, 1058, 1058, 1046, 1046, 1046, 1046, 1046,
			 1058, 1046, 1046, 1046, 1046, 1046, 1046, 1046, 1046, 1046,
			 1046, 1046, 1046, 1046, 1046, 1046, 1046, 1058, 1058, 1058,
			 1046, 1046, 1046, 1046, 1046, 1046, 1046, 1046, 1046, 1052,
			 1060, 1060, 1061, 1061,  379, 1062, 1052, 1052,   34,   61, yy_Dummy>>,
			1, 200, 400)
		end

	yy_def_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			   34,   61,   34,   61,   34,   61,   34,   34,   61,   61,
			 1046, 1046, 1046,   34,   61,   34,   61,   34,   61,   34,
			   61,   34,   61,   34,   61,   34,   61,   34,   61,   34,
			   61,   34,   61,   34,   34,   61,   61,   34,   61,   34,
			   61,   34,   61,   34,   34,   61,   61,   34,   61,   34,
			   61,   34,   61,   34,   61,   34,   61,   34,   61,   34,
			   61,   34,   61,   34,   61,   34,   61,   34,   61,   34,
			   61,   34,   34,   61,   61,   34,   61,   34,   61,   34,
			   61,   34,   61,   34,   34,   61,   61,   34,   61,   34,
			   61,   34,   61,   34,   61,   34,   61,   34,   61,   34,

			   61,   34,   61,   34,   61,   34,   61,   34,   61,   34,
			   61,   34,   61, 1053, 1053, 1053, 1046, 1046, 1046, 1063,
			 1063, 1063, 1063, 1063, 1063, 1063, 1056, 1056, 1056, 1046,
			 1058, 1058, 1058, 1058, 1046, 1046, 1046, 1046, 1046, 1046,
			 1046, 1046, 1046, 1046, 1059, 1052,   34,   61,   34,   61,
			   34,   61,   34,   61,   34,   61,   34,   61,   34,   61,
			   34,   61,   34,   61,   34,   61,   34,   61,   34,   61,
			   34,   61,   34,   61,   34,   61,   34,   61,   34,   61,
			   34,   61,   34,   61,   34,   61,   34,   61,   34,   61,
			   34,   61,   34,   61,   34,   61,   34,   61,   34,   61, yy_Dummy>>,
			1, 200, 600)
		end

	yy_def_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			   34,   61,   34,   61,   34,   61,   34,   61,   34,   61,
			   34,   61,   34,   61,   34,   61,   34,   61,   34,   61,
			   34,   61,   34,   61,   34,   61,   34,   61,   34,   61,
			   34,   61,   34,   61,   34,   61,   34,   61, 1063, 1063,
			 1063, 1046, 1046, 1046, 1046, 1046, 1046, 1046, 1046, 1046,
			 1046, 1046, 1046, 1046, 1064,   34,   61,   34,   61,   34,
			   61,   34,   61,   34,   61,   34,   34,   61,   61,   34,
			   61,   34,   61,   34,   61,   34,   61,   34,   61,   34,
			   61,   34,   61,   34,   61,   34,   61,   34,   61,   34,
			   61,   34,   61,   34,   61,   34,   61,   34,   61,   34,

			   61,   34,   61,   34,   61,   34,   61,   34,   61,   34,
			   61,   34,   61,   34,   61,   34,   61,   34,   61,   34,
			   61,   34,   61,   34,   61,   34,   61, 1046, 1046, 1046,
			 1046, 1046, 1046, 1046, 1046, 1046, 1046, 1046, 1046, 1046,
			 1046,   34,   61,   34,   61,   34,   61,   34,   61,   34,
			   61,   34,   61,   34,   61,   34,   61,   34,   61,   34,
			   61,   34,   61,   34,   61,   34,   61,   34,   61,   34,
			   61,   34,   61,   34,   61,   34,   61,   34,   61,   34,
			   61,   34,   61,   34,   61,   34,   61, 1046, 1046, 1046,
			 1046, 1046, 1046, 1046, 1046, 1046, 1046, 1046,   34,   61, yy_Dummy>>,
			1, 200, 800)
		end

	yy_def_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			   34,   61,   34,   61,   34,   61,   34,   61,   34,   61,
			   34,   61,   34,   61,   34,   61,   34,   61,   34,   61,
			   34,   61,   34,   61,   34,   61,   34,   61, 1046, 1046,
			 1046, 1046, 1046,   34,   61,   34,   61,   34,   61,   34,
			   61,   34,   61, 1046,   34,   61,    0, 1046, 1046, 1046,
			 1046, 1046, 1046, 1046, 1046, 1046, 1046, 1046, 1046, 1046,
			 1046, 1046, 1046, 1046, 1046, yy_Dummy>>,
			1, 65, 1000)
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
			   99,  100,  100,  100,  101,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1, yy_Dummy>>,
			1, 57, 200)
		end

	yy_meta_template: SPECIAL [INTEGER]
			-- Template for `yy_meta'
		once
			Result := yy_fixed_array (<<
			    0,    1,    2,    3,    4,    5,    1,    6,    1,    1,
			    7,    8,    9,   10,    1,    1,    1,    1,   11,    9,
			   12,   13,   14,   15,    1,    1,   16,    1,   17,    1,
			   18,   19,   20,   21,   12,   22,   12,   23,   12,   12,
			   12,   24,   12,   25,   12,   12,   26,   27,   28,   29,
			   30,   31,   32,   33,   34,   35,    1,    1,    1,    1,
			   12,   36,   12,   12,   12,   12,   12,   12,   12,   12,
			   12,   12,   12,   12,   12,   12,   12,   12,   12,   12,
			   12,   12,   12,   12,   37,   38,   39,   40,    1,    1,
			    1,    1,    1,    1,   41,   41,   41,   41,   41,   41,

			   41,   41, yy_Dummy>>)
		end

	yy_accept_template: SPECIAL [INTEGER]
			-- Template for `yy_accept'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 1047)
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
			  258,  261,  263,  265,  267,  269,  271,  273,  275,  277,

			  279,  281,  283,  284,  285,  286,  287,  287,  288,  289,
			  291,  291,  291,  291,  291,  291,  291,  291,  291,  292,
			  292,  292,  292,  292,  292,  292,  292,  292,  292,  293,
			  293,  294,  295,  296,  297,  298,  299,  300,  301,  302,
			  303,  304,  305,  307,  308,  309,  310,  310,  312,  313,
			  314,  315,  316,  316,  317,  318,  319,  320,  321,  322,
			  324,  326,  328,  330,  332,  335,  337,  338,  339,  340,
			  341,  342,  344,  345,  345,  345,  345,  345,  345,  345,
			  345,  345,  347,  348,  350,  352,  354,  356,  358,  359,
			  360,  361,  362,  363,  365,  368,  369,  371,  373,  375, yy_Dummy>>,
			1, 200, 0)
		end

	yy_accept_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			  377,  378,  379,  380,  382,  384,  386,  387,  388,  389,
			  392,  394,  396,  399,  401,  402,  403,  405,  407,  409,
			  410,  411,  413,  414,  416,  418,  420,  423,  424,  425,
			  426,  428,  430,  431,  433,  434,  436,  438,  440,  441,
			  442,  443,  445,  447,  448,  449,  451,  452,  454,  456,
			  457,  458,  460,  461,  463,  464,  465,  465,  465,  465,
			  465,  465,  465,  465,  465,  465,  465,  465,  465,  465,
			  465,  465,  465,  465,  465,  465,  465,  465,  465,  465,
			  465,  466,  467,  468,  469,  470,  471,  472,  473,  474,
			  475,  475,  475,  476,  477,  478,  479,  480,  481,  482,

			  483,  484,  485,  486,  487,  488,  489,  490,  491,  492,
			  493,  494,  495,  495,  496,  496,  496,  496,  496,  496,
			  496,  496,  496,  496,  496,  496,  496,  496,  496,  497,
			  498,  499,  500,  501,  502,  503,  504,  505,  506,  507,
			  508,  508,  509,  510,  511,  512,  513,  514,  515,  516,
			  517,  518,  519,  520,  521,  522,  523,  524,  525,  526,
			  527,  528,  529,  530,  531,  532,  533,  534,  536,  536,
			  536,  537,  539,  540,  542,  542,  545,  547,  550,  552,
			  555,  557,  559,  559,  561,  562,  564,  565,  567,  570,
			  571,  573,  576,  578,  580,  581,  583,  584,  584,  584, yy_Dummy>>,
			1, 200, 200)
		end

	yy_accept_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			  584,  584,  584,  584,  584,  587,  589,  591,  592,  594,
			  595,  597,  598,  600,  601,  603,  604,  606,  608,  610,
			  611,  612,  613,  615,  616,  619,  621,  623,  624,  626,
			  628,  629,  630,  632,  633,  635,  636,  638,  639,  641,
			  642,  644,  646,  648,  650,  652,  653,  654,  655,  656,
			  657,  659,  660,  662,  664,  665,  666,  669,  671,  673,
			  674,  677,  679,  681,  682,  684,  685,  687,  689,  691,
			  693,  695,  697,  698,  699,  700,  701,  702,  703,  705,
			  707,  708,  709,  711,  712,  714,  715,  717,  718,  720,
			  721,  723,  725,  727,  728,  729,  730,  732,  733,  735,

			  736,  738,  739,  742,  744,  745,  746,  746,  746,  746,
			  746,  746,  746,  746,  746,  746,  746,  746,  746,  746,
			  746,  746,  746,  746,  746,  746,  746,  746,  746,  746,
			  746,  746,  747,  748,  749,  750,  751,  752,  753,  754,
			  755,  756,  756,  756,  756,  756,  756,  756,  756,  757,
			  758,  759,  760,  761,  762,  763,  764,  765,  766,  767,
			  768,  769,  770,  771,  772,  773,  774,  775,  776,  777,
			  778,  779,  780,  781,  782,  783,  784,  785,  786,  787,
			  788,  790,  790,  792,  792,  794,  794,  794,  794,  796,
			  798,  798,  798,  798,  798,  798,  798,  800,  802,  804, yy_Dummy>>,
			1, 200, 400)
		end

	yy_accept_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			  805,  807,  808,  810,  811,  813,  814,  816,  818,  819,
			  820,  820,  820,  820,  822,  823,  825,  826,  828,  829,
			  831,  832,  834,  835,  837,  838,  840,  841,  843,  844,
			  847,  849,  851,  852,  854,  856,  857,  858,  860,  861,
			  863,  864,  866,  867,  870,  872,  874,  875,  877,  878,
			  880,  881,  883,  884,  886,  887,  889,  890,  892,  893,
			  896,  898,  900,  901,  904,  906,  909,  911,  913,  914,
			  917,  919,  921,  923,  924,  925,  927,  928,  930,  931,
			  933,  934,  936,  937,  939,  941,  942,  943,  945,  946,
			  948,  949,  951,  952,  955,  957,  959,  960,  963,  965,

			  968,  970,  972,  973,  975,  976,  978,  979,  981,  982,
			  985,  987,  990,  992,  992,  992,  992,  992,  992,  992,
			  992,  992,  992,  992,  992,  992,  992,  993,  994,  995,
			  995,  996,  997,  998,  999, 1000, 1002, 1002, 1002, 1004,
			 1004, 1008, 1008, 1010, 1010, 1010, 1012, 1014, 1015, 1018,
			 1020, 1023, 1025, 1027, 1028, 1030, 1031, 1033, 1034, 1037,
			 1039, 1042, 1044, 1046, 1047, 1049, 1050, 1052, 1053, 1056,
			 1058, 1060, 1061, 1063, 1064, 1066, 1067, 1069, 1070, 1072,
			 1073, 1075, 1076, 1078, 1079, 1082, 1084, 1086, 1087, 1089,
			 1090, 1092, 1093, 1095, 1096, 1099, 1101, 1103, 1104, 1106, yy_Dummy>>,
			1, 200, 600)
		end

	yy_accept_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			 1107, 1109, 1110, 1113, 1115, 1117, 1118, 1120, 1121, 1123,
			 1124, 1126, 1127, 1129, 1130, 1132, 1133, 1135, 1136, 1138,
			 1139, 1141, 1142, 1145, 1147, 1149, 1150, 1152, 1153, 1156,
			 1158, 1160, 1161, 1163, 1164, 1167, 1169, 1171, 1172, 1172,
			 1172, 1172, 1172, 1173, 1173, 1175, 1175, 1176, 1177, 1181,
			 1181, 1181, 1183, 1183, 1184, 1184, 1187, 1189, 1192, 1194,
			 1196, 1197, 1199, 1200, 1202, 1203, 1206, 1208, 1210, 1211,
			 1213, 1214, 1216, 1217, 1219, 1220, 1223, 1225, 1228, 1230,
			 1232, 1233, 1236, 1238, 1240, 1241, 1243, 1244, 1247, 1249,
			 1251, 1252, 1254, 1255, 1257, 1258, 1260, 1261, 1263, 1264,

			 1266, 1267, 1269, 1270, 1273, 1275, 1277, 1278, 1280, 1281,
			 1284, 1286, 1288, 1289, 1292, 1294, 1297, 1299, 1302, 1304,
			 1306, 1307, 1309, 1310, 1313, 1315, 1317, 1318, 1318, 1319,
			 1319, 1319, 1319, 1323, 1323, 1324, 1325, 1325, 1325, 1326,
			 1327, 1328, 1330, 1331, 1333, 1334, 1337, 1339, 1341, 1342,
			 1345, 1347, 1349, 1350, 1352, 1353, 1355, 1356, 1358, 1359,
			 1362, 1364, 1367, 1369, 1371, 1372, 1375, 1377, 1380, 1382,
			 1384, 1385, 1387, 1388, 1390, 1391, 1393, 1394, 1396, 1397,
			 1400, 1402, 1404, 1405, 1407, 1408, 1411, 1413, 1414, 1414,
			 1415, 1415, 1417, 1417, 1417, 1418, 1419, 1419, 1420, 1423, yy_Dummy>>,
			1, 200, 800)
		end

	yy_accept_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			 1425, 1427, 1428, 1431, 1433, 1436, 1438, 1440, 1441, 1444,
			 1446, 1449, 1451, 1454, 1456, 1458, 1459, 1462, 1464, 1466,
			 1467, 1470, 1472, 1474, 1475, 1478, 1480, 1483, 1485, 1486,
			 1488, 1488, 1490, 1491, 1494, 1496, 1498, 1499, 1502, 1504,
			 1507, 1509, 1512, 1514, 1516, 1519, 1521, 1521, yy_Dummy>>,
			1, 48, 1000)
		end

	yy_acclist_template: SPECIAL [INTEGER]
			-- Template for `yy_acclist'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 1520)
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
			    0,  146,  146,  166,  164,  165,    2,  164,  165,    4,
			  165,    5,  164,  165,    1,  164,  165,   11,  164,  165,
			  164,  165,  113,  164,  165,   18,  164,  165,  164,  165,
			  164,  165,   12,  164,  165,   13,  164,  165,   33,  164,
			  165,   32,  164,  165,    9,  164,  165,   31,  164,  165,
			    7,  164,  165,   34,  164,  165,  148,  155,  164,  165,
			  148,  155,  164,  165,   10,  164,  165,    8,  164,  165,
			   38,  164,  165,   36,  164,  165,   37,  164,  165,  164,
			  165,  111,  112,  164,  165,  111,  112,  164,  165,  111,
			  112,  164,  165,  111,  112,  164,  165,  111,  112,  164,

			  165,  111,  112,  164,  165,  111,  112,  164,  165,  111,
			  112,  164,  165,  111,  112,  164,  165,  111,  112,  164,
			  165,  111,  112,  164,  165,  111,  112,  164,  165,  111,
			  112,  164,  165,  111,  112,  164,  165,  111,  112,  164,
			  165,  111,  112,  164,  165,  111,  112,  164,  165,  111,
			  112,  164,  165,  111,  112,  164,  165,   16,  164,  165,
			  164,  165,   17,  164,  165,   35,  164,  165,  164,  165,
			  112,  164,  165,  112,  164,  165,  112,  164,  165,  112,
			  164,  165,  112,  164,  165,  112,  164,  165,  112,  164,
			  165,  112,  164,  165,  112,  164,  165,  112,  164,  165, yy_Dummy>>,
			1, 200, 0)
		end

	yy_acclist_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  112,  164,  165,  112,  164,  165,  112,  164,  165,  112,
			  164,  165,  112,  164,  165,  112,  164,  165,  112,  164,
			  165,  112,  164,  165,  112,  164,  165,   14,  164,  165,
			   15,  164,  165,   39,  164,  165,  164,  165,  164,  165,
			  164,  165,  164,  165,  164,  165,  164,  165,  164,  165,
			  164,  165,  146,  165,  141,  165,  143,  165,  144,  146,
			  165,  140,  165,  145,  165,  146,  165,  146,  165,  146,
			  165,  146,  165,  146,  165,  146,  165,  146,  165,  146,
			  165,  146,  165,    2,    3,    1,   40,  147,  147, -138,
			 -303,  113,  137,  137,  137,  137,  137,  137,  137,  137,

			  137,  137,    6,   24,   25,  158,  161,   19,   21,   30,
			  148,  155,  155,  155,  155,  155,   29,   26,   23,   22,
			   27,   28,  111,  112,  111,  112,  111,  112,  111,  112,
			  111,  112,   45,  111,  112,  111,  112,  112,  112,  112,
			  112,  112,   45,  112,  112,  111,  112,  112,  111,  112,
			  111,  112,  111,  112,  111,  112,  111,  112,  112,  112,
			  112,  112,  112,  111,  112,   56,  111,  112,  112,   56,
			  112,  111,  112,  111,  112,  111,  112,  112,  112,  112,
			  111,  112,  111,  112,  111,  112,  112,  112,  112,   68,
			  111,  112,  111,  112,  111,  112,   74,  111,  112,   68, yy_Dummy>>,
			1, 200, 200)
		end

	yy_acclist_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  112,  112,  112,   74,  112,  111,  112,  111,  112,  112,
			  112,  111,  112,  112,  111,  112,  111,  112,  111,  112,
			   82,  111,  112,  112,  112,  112,   82,  112,  111,  112,
			  112,  111,  112,  112,  111,  112,  111,  112,  111,  112,
			  112,  112,  112,  111,  112,  111,  112,  112,  112,  111,
			  112,  112,  111,  112,  111,  112,  112,  112,  111,  112,
			  112,  111,  112,  112,   20,  146,  146,  146,  146,  146,
			  146,  146,  146,  146,  141,  142,  146,  146,  140,  139,
			  146,  146,  146,  146,  146,  146,  146,  146,  146,  146,
			  146,  146,  146,  146,  146, -138,  137,  114,  137,  137,

			  137,  137,  137,  137,  137,  137,  137,  137,  137,  137,
			  137,  137,  137,  137,  137,  137,  137,  137,  137,  137,
			  137,  137,  137,  137,  137,  137,  137,  137,  137,  137,
			  137,  137,  137,  137,  158,  161,  156,  158,  161,  156,
			  148,  155,  151,  154,  155,  154,  155,  150,  153,  155,
			  153,  155,  149,  152,  155,  152,  155,  148,  155,  111,
			  112,  112,  111,  112,  112,  111,  112,   43,  111,  112,
			  112,   43,  112,   44,  111,  112,   44,  112,  111,  112,
			  112,  111,  112,  112,   47,  111,  112,   47,  112,  111,
			  112,  112,  111,  112,  112,  111,  112,  112,  111,  112, yy_Dummy>>,
			1, 200, 400)
		end

	yy_acclist_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  112,  111,  112,  112,  111,  112,  111,  112,  111,  112,
			  112,  112,  112,  111,  112,  112,   59,  111,  112,  111,
			  112,   59,  112,  112,  111,  112,  111,  112,  112,  112,
			  111,  112,  112,  111,  112,  112,  111,  112,  112,  111,
			  112,  112,  111,  112,  111,  112,  111,  112,  111,  112,
			  111,  112,  112,  112,  112,  112,  112,  111,  112,  112,
			  111,  112,  111,  112,  112,  112,   78,  111,  112,   78,
			  112,  111,  112,  112,   80,  111,  112,   80,  112,  111,
			  112,  112,  111,  112,  112,  111,  112,  111,  112,  111,
			  112,  111,  112,  111,  112,  111,  112,  112,  112,  112,

			  112,  112,  112,  111,  112,  111,  112,  112,  112,  111,
			  112,  112,  111,  112,  112,  111,  112,  112,  111,  112,
			  112,  111,  112,  111,  112,  111,  112,  112,  112,  112,
			  111,  112,  112,  111,  112,  112,  111,  112,  112,  103,
			  111,  112,  103,  112,  163,  162,  146,  146,  146,  146,
			  146,  146,  146,  146,  146,  146,  137,  137,  137,  137,
			  137,  137,  137,  131,  129,  130,  132,  133,  137,  134,
			  135,  115,  116,  117,  118,  119,  120,  121,  122,  123,
			  124,  125,  126,  127,  128,  137,  137,  137,  158,  161,
			  158,  161,  158,  161,  157,  160,  148,  155,  148,  155, yy_Dummy>>,
			1, 200, 600)
		end

	yy_acclist_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  148,  155,  111,  112,  112,  111,  112,  112,  111,  112,
			  112,  111,  112,  112,  111,  112,  111,  112,  112,  112,
			  111,  112,  112,  111,  112,  112,  111,  112,  112,  111,
			  112,  112,  111,  112,  112,  111,  112,  112,  111,  112,
			  112,  111,  112,  112,   57,  111,  112,   57,  112,  111,
			  112,  112,  111,  112,  111,  112,  112,  112,  111,  112,
			  112,  111,  112,  112,  111,  112,  112,   66,  111,  112,
			  111,  112,   66,  112,  112,  111,  112,  112,  111,  112,
			  112,  111,  112,  112,  111,  112,  112,  111,  112,  112,
			  111,  112,  112,   75,  111,  112,   75,  112,  111,  112,

			  112,   77,  111,  112,   77,  112,  108,  111,  112,  108,
			  112,  111,  112,  112,   81,  111,  112,   81,  112,  111,
			  112,  111,  112,  112,  112,  111,  112,  112,  111,  112,
			  112,  111,  112,  112,  111,  112,  112,  111,  112,  111,
			  112,  112,  112,  111,  112,  112,  111,  112,  112,  111,
			  112,  112,  109,  111,  112,  109,  112,  111,  112,  112,
			   95,  111,  112,   95,  112,   96,  111,  112,   96,  112,
			  111,  112,  112,  111,  112,  112,  111,  112,  112,  111,
			  112,  112,  101,  111,  112,  101,  112,  102,  111,  112,
			  102,  112,  146,  146,  146,  137,  137,  137,  137,  158, yy_Dummy>>,
			1, 200, 800)
		end

	yy_acclist_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  158,  161,  158,  161,  157,  158,  160,  161,  157,  160,
			  148,  155,  111,  112,  112,   41,  111,  112,   41,  112,
			   42,  111,  112,   42,  112,  111,  112,  112,  111,  112,
			  112,  111,  112,  112,   48,  111,  112,   48,  112,   49,
			  111,  112,   49,  112,  111,  112,  112,  111,  112,  112,
			  111,  112,  112,   54,  111,  112,   54,  112,  111,  112,
			  112,  111,  112,  112,  111,  112,  112,  111,  112,  112,
			  111,  112,  112,  111,  112,  112,  111,  112,  112,   64,
			  111,  112,   64,  112,  111,  112,  112,  111,  112,  112,
			  111,  112,  112,  111,  112,  112,   70,  111,  112,   70,

			  112,  111,  112,  112,  111,  112,  112,  111,  112,  112,
			   76,  111,  112,   76,  112,  111,  112,  112,  111,  112,
			  112,  111,  112,  112,  111,  112,  112,  111,  112,  112,
			  111,  112,  112,  111,  112,  112,  111,  112,  112,  111,
			  112,  112,   91,  111,  112,   91,  112,  111,  112,  112,
			  111,  112,  112,   94,  111,  112,   94,  112,  111,  112,
			  112,  111,  112,  112,   99,  111,  112,   99,  112,  111,
			  112,  112,  136,  158,  161,  161,  158,  157,  158,  160,
			  161,  157,  160,  156,  104,  111,  112,  104,  112,   46,
			  111,  112,   46,  112,  111,  112,  112,  111,  112,  112, yy_Dummy>>,
			1, 200, 1000)
		end

	yy_acclist_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  111,  112,  112,   51,  111,  112,  111,  112,   51,  112,
			  112,  111,  112,  112,  111,  112,  112,  111,  112,  112,
			   58,  111,  112,   58,  112,   60,  111,  112,   60,  112,
			  111,  112,  112,   62,  111,  112,   62,  112,  111,  112,
			  112,  111,  112,  112,   67,  111,  112,   67,  112,  111,
			  112,  112,  111,  112,  112,  111,  112,  112,  111,  112,
			  112,  111,  112,  112,  111,  112,  112,  111,  112,  112,
			   84,  111,  112,   84,  112,  111,  112,  112,  111,  112,
			  112,   87,  111,  112,   87,  112,  111,  112,  112,   89,
			  111,  112,   89,  112,   90,  111,  112,   90,  112,   92,

			  111,  112,   92,  112,  111,  112,  112,  111,  112,  112,
			   98,  111,  112,   98,  112,  111,  112,  112,  158,  157,
			  158,  160,  161,  161,  157,  159,  161,  159,  111,  112,
			  112,  111,  112,  112,   50,  111,  112,   50,  112,  111,
			  112,  112,   53,  111,  112,   53,  112,  111,  112,  112,
			  111,  112,  112,  111,  112,  112,  111,  112,  112,   65,
			  111,  112,   65,  112,   69,  111,  112,   69,  112,  111,
			  112,  112,   71,  111,  112,   71,  112,   72,  111,  112,
			   72,  112,  111,  112,  112,  111,  112,  112,  111,  112,
			  112,  111,  112,  112,  111,  112,  112,   88,  111,  112, yy_Dummy>>,
			1, 200, 1200)
		end

	yy_acclist_template_8 (an_array: ARRAY [INTEGER])
			-- Fill chunk #8 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			   88,  112,  111,  112,  112,  111,  112,  112,  100,  111,
			  112,  100,  112,  161,  161,  157,  158,  160,  161,  160,
			  105,  111,  112,  105,  112,  111,  112,  112,   52,  111,
			  112,   52,  112,   55,  111,  112,   55,  112,  111,  112,
			  112,   61,  111,  112,   61,  112,   63,  111,  112,   63,
			  112,  110,  111,  112,  110,  112,  111,  112,  112,   79,
			  111,  112,   79,  112,  111,  112,  112,   86,  111,  112,
			   86,  112,  111,  112,  112,   93,  111,  112,   93,  112,
			   97,  111,  112,   97,  112,  161,  160,  161,  160,  161,
			  160,  106,  111,  112,  106,  112,  111,  112,  112,   73,

			  111,  112,   73,  112,   83,  111,  112,   83,  112,   85,
			  111,  112,   85,  112,  160,  161,  107,  111,  112,  107,
			  112, yy_Dummy>>,
			1, 121, 1400)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER = 7883
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER = 1046
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER = 1047
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
	copyright:	"Copyright (c) 1984-2018, Eiffel Software"
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
