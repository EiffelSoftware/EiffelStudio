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
		
when 147, 148 then
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
	
when 163, 164 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

		curr_token := new_text_in_comment (text)
		update_token_list
	
when 165 then
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
	
when 166 then
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
			create an_array.make_filled (0, 0, 8084)
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
			   25,   26,   26,   26,   27,   28,   29,   30,   31,   32,
			   33,   34,   35,   36,   37,   38,   39,   39,   40,   39,
			   39,   41,   39,   42,   43,   44,   39,   45,   46,   47,
			   48,   49,   50,   51,   39,   39,   52,   53,   54,   55,
			    6,   56,   57,   58,   59,   60,   61,   62,   63,   63,
			   64,   63,   63,   65,   63,   66,   67,   68,   63,   69,
			   70,   71,   72,   73,   74,   75,   63,   63,   76,   77,
			   78,    6,    6,    6,   79,   80,   81,   82,   83,   84,

			   85,   86,   88,   89,   90,   91,  159,   92,  139,  141,
			  874,  142,  142,  142,  142,   88,   89,   90,   91,  140,
			   92,  143,  146, 1071,  147,  147,  147,  147,  768,  144,
			  154,  155,  156,  157,  107,  251,  159,  108,  166,  761,
			  183,  159,  107,  159,  184,  108,  129,  185,  129,  129,
			  186,  617,  231,  187,  130,  217,  275,  275,   93,  277,
			  277,  218,  411,  411,  152,  386,  615,  252,  166,  413,
			  413,   93,  188,  166,  159,  166,  189,  527,  527,  190,
			  387,  387,  191,  109,  232,  192,  613,  219,  617,   93,
			  529,  529,  145,  220,   94,   95,   96,   97,   98,   99, yy_Dummy>>,
			1, 200, 0)
		end

	yy_nxt_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  100,  101,   93,  159,  159,  159,  166,   94,   95,   96,
			   97,   98,   99,  100,  101,  109,  274,  274,  274,  615,
			  386,  110,  111,  112,  113,  114,  115,  116,  117,  120,
			  121,  122,  123,  124,  125,  126,  127,  613,  131,  132,
			  133,  134,  135,  136,  137,  138,  146,  159,  147,  147,
			  147,  147,  579,  221,  193,  159,  531,  159,  159,  149,
			  150,  159,  159,  181,  194,  197,  159,  198,  159,  399,
			  159,  233,  400,  159,  159,  159,  253,  199,  525,  166,
			 1071,  151,  276,  276,  276,  222,  195,  166,  152,  166,
			  166,  149,  150,  166,  166,  182,  196,  200,  166,  201,

			  166,  401,  166,  234,  402,  166,  166,  166,  254,  202,
			  278,  278,  278,  151,  159,  159,  159,  159,  159,  159,
			  159,  159,  386,  245,  159,  159,  160,  159,  159,  159,
			  161,  159,  159,  159,  159,  162,  159,  163,  159,  159,
			  159,  159,  164,  165,  159,  159,  159,  159,  159,  159,
			  166,  410,  410,  410,  159,  246,  166,  166,  167,  166,
			  166,  166,  168,  166,  166,  166,  166,  169,  166,  170,
			  166,  166,  166,  166,  171,  172,  166,  166,  166,  166,
			  166,  166,  146,  415,  385,  385,  385,  385,  173,  174,
			  175,  176,  177,  178,  179,  180,  203,  409,  209,  341, yy_Dummy>>,
			1, 200, 200)
		end

	yy_nxt_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  204,  159,  223,  159,  159,  210,  211,  241,  159,  159,
			  159,  212,  224,  205,  225,  247,  235,  242,  226,  395,
			  159,  397,  403,  159,  152,  159,  236,  159,  206,  248,
			  213,  237,  207,  166,  227,  166,  166,  214,  215,  243,
			  166,  166,  166,  216,  228,  208,  229,  249,  238,  244,
			  230,  396,  166,  398,  404,  166,  104,  166,  239,  166,
			  102,  250,  279,  240,  257,  258,  259,  260,  261,  262,
			  263,  264,  167,  166,  418,  166,  168,  195,  159,  159,
			  166,  169,  159,  170,  166,  166,  182,  196,  171,  172,
			  166,  159,  405,  166,  281,  282,  283,  284,  285,  286,

			  287,  288,  273,  255,  167,  166,  419,  166,  168,  195,
			  166,  166,  166,  169,  166,  170,  166,  166,  182,  196,
			  171,  172,  166,  166,  406,  166,  281,  282,  283,  284,
			  285,  286,  287,  288,  265,  266,  267,  268,  269,  270,
			  271,  272,  265,  266,  267,  268,  269,  270,  271,  272,
			  188,  159,  166,  159,  189,  159,  200,  190,  201,  166,
			  191,  434,  166,  192,  407,  166,  416,  510,  202,  305,
			  281,  282,  283,  284,  285,  286,  287,  288,  389,  389,
			  389,  158,  188,  166,  166,  166,  189,  166,  200,  190,
			  201,  166,  191,  435,  166,  192,  408,  166,  417,  511, yy_Dummy>>,
			1, 200, 400)
		end

	yy_nxt_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  202,  289,  153,  290,  290,  105,  104,  265,  266,  267,
			  268,  269,  270,  271,  272,  206,  213,  103,  386,  207,
			  159,  159,  166,  214,  215,  102,  166,  448,  166,  216,
			  219, 1071,  208,  166,  166,  166,  220,  166,  166,  166,
			  222,  412,  412,  412, 1071,  166, 1071,  206,  213,  166,
			 1071,  207,  166,  166,  166,  214,  215,  291,  166,  449,
			  166,  216,  219,  227,  208,  166,  166,  166,  220,  166,
			  166,  166,  222,  228,  166,  229,  166,  166,  159,  230,
			  232,  166,  234,  238,  159,  166,  166,  426,  291,  166,
			  166,  166,  166,  239, 1071,  227, 1071, 1071,  240, 1071,

			 1071,  166,  166, 1071, 1071,  228,  166,  229,  166, 1071,
			  166,  230,  232, 1071,  234,  238,  166,  166,  166,  427,
			 1071,  166,  166,  166,  166,  239,  166,  159,  246,  249,
			  240,  243,  422,  166,  166,  166,  159,  166,  166,  444,
			  166,  244,  166,  250,  414,  414,  414,  166,  290,  252,
			  290,  295,  166,  166,  166,  166,  166,  254,  166,  166,
			  246,  249, 1071,  243,  423,  166,  166,  166,  166,  166,
			  166,  445,  166,  244,  166,  250,  166,  166,  166,  166,
			 1071,  252,  387,  387,  166,  166,  166,  166,  166,  254,
			  290,  292,  293,  290,  526,  526,  526,  166,  166, 1071, yy_Dummy>>,
			1, 200, 600)
		end

	yy_nxt_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  291,  626, 1071,  291,  291,  296, 1071, 1071,  280,  306,
			  306,  306,  281,  282,  283,  284,  285,  286,  287,  288,
			  307,  307,  612,  281,  282,  283,  284,  285,  286,  287,
			  288,  107, 1071,  627,  108,  291,  309,  309,  281,  282,
			  283,  284,  285,  286,  287,  288,  294,  308,  308,  308,
			  281,  282,  283,  284,  285,  286,  287,  288,  310,  310,
			  310,  281,  282,  283,  284,  285,  286,  287,  288, 1071,
			  159,  393,  393,  393,  393,  387,  387,  294, 1071, 1071,
			  109,  468,  281,  282,  283,  284,  285,  286,  287,  288,
			 1071, 1071,  297,  298,  299,  300,  301,  302,  303,  304,

			  311,  159,  166,  281,  282,  283,  284,  285,  286,  287,
			  288,  394,  109,  469,  107,  612, 1071,  108,  110,  111,
			  112,  113,  114,  115,  116,  117,  313, 1071, 1071,  314,
			  119,  119,  119,  166,  383,  383,  383,  383,  315, 1071,
			  107, 1071, 1071,  108, 1071,  119,  159,  119,  384,  119,
			  119,  316,  159,  450,  119,  424,  119, 1071, 1071,  159,
			  119,  107,  119,  109,  108,  119,  119,  119,  119,  119,
			  119,  325, 1071,  325,  325, 1071,  107, 1071,  166,  108,
			  384,  528,  528,  528,  166,  451, 1071,  425, 1071,  109,
			  107,  166, 1071,  108, 1071,  109,  530,  530,  530, 1071, yy_Dummy>>,
			1, 200, 800)
		end

	yy_nxt_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			 1071,  110,  111,  112,  113,  114,  115,  116,  117,  107,
			  109,  673,  108,  317,  318,  319,  320,  321,  322,  323,
			  324,  109,  159,  159,  159,  109,  326,  110,  111,  112,
			  113,  114,  115,  116,  117, 1071, 1071,  107, 1071,  109,
			  108,  159,  109,  674,  669,  327,  327,  327,  110,  111,
			  112,  113,  114,  115,  116,  117,  107,  109,  109,  108,
			  159,  159,  159,  110,  111,  112,  113,  114,  115,  116,
			  117,  109, 1071,  166,  328,  328,  670,  110,  111,  112,
			  113,  114,  115,  116,  117,  107,  109,  159,  108,  462,
			  109, 1071, 1071,  329,  329,  329,  110,  111,  112,  113,

			  114,  115,  116,  117,  107,  109,  159,  108,  159,  159,
			  159, 1071,  107, 1071, 1071,  108, 1071, 1071,  109,  166,
			 1071,  463,  330,  330,  110,  111,  112,  113,  114,  115,
			  116,  117,  107, 1071,  109,  108,  717,  109,  166,  727,
			  331,  331,  331,  110,  111,  112,  113,  114,  115,  116,
			  117,  107,  472, 1071,  108, 1071, 1071,  159,  159,  159,
			  159, 1071,  107, 1071, 1071,  108,  109, 1071,  718,  332,
			 1071,  728,  110,  111,  112,  113,  114,  115,  116,  117,
			  107,  476, 1071,  108,  473,  159,  532,  532,  532,  166,
			 1071,  120,  121,  122,  123,  124,  125,  126,  127,  120, yy_Dummy>>,
			1, 200, 1000)
		end

	yy_nxt_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  121,  122,  123,  124,  125,  126,  127,  107, 1071, 1071,
			  108, 1071, 1071,  477,  533,  533,  533,  166,  333,  120,
			  121,  122,  123,  124,  125,  126,  127,  107, 1071, 1071,
			  108,  534,  534,  534, 1071,  334,  334,  334,  120,  121,
			  122,  123,  124,  125,  126,  127,  335,  335,  341,  120,
			  121,  122,  123,  124,  125,  126,  127,  107, 1071,  729,
			  108,  159,  159,  159,  336,  336,  336,  120,  121,  122,
			  123,  124,  125,  126,  127,  281,  282,  283,  284,  285,
			  286,  287,  288,  281,  282,  283,  284,  285,  286,  287,
			  288,  730,  337,  337,  120,  121,  122,  123,  124,  125,

			  126,  127,  305,  281,  282,  283,  284,  285,  286,  287,
			  288,  338,  338,  338,  120,  121,  122,  123,  124,  125,
			  126,  127,  341,  389,  389,  389,  379,  379,  379,  379,
			  159,  342,  343,  344,  345,  346,  347,  348,  349,  341,
			  380,  339,  500, 1071,  120,  121,  122,  123,  124,  125,
			  126,  127,  350,  159, 1071,  351,  352,  353,  354,  159,
			  159,  159,  166,  614,  355,  159,  381,  341, 1071,  494,
			 1071,  356,  380,  357,  501,  358,  359,  360,  361,  341,
			  362, 1071,  363,  498, 1071,  166,  364,  159,  365, 1071,
			  341,  366,  367,  368,  369,  370,  371,  166, 1071, 1071, yy_Dummy>>,
			1, 200, 1200)
		end

	yy_nxt_template_8 (an_array: ARRAY [INTEGER])
			-- Fill chunk #8 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  341,  495,  128,  128,  128,  342,  343,  344,  345,  346,
			  347,  348,  349,  341, 1071,  499,  159,  159,  159,  166,
			 1071,  372,  342,  343,  344,  345,  346,  347,  348,  349,
			  341,  281,  282,  283,  284,  285,  286,  287,  288,  342,
			  343,  344,  345,  346,  347,  348,  349,  373,  373,  373,
			  342,  343,  344,  345,  346,  347,  348,  349, 1071,  374,
			  374, 1071,  342,  343,  344,  345,  346,  347,  348,  349,
			  375,  375,  375,  342,  343,  344,  345,  346,  347,  348,
			  349,  376,  376,  342,  343,  344,  345,  346,  347,  348,
			  349, 1071, 1071,  377,  377,  377,  342,  343,  344,  345,

			  346,  347,  348,  349,  605,  605,  605,  605, 1071,  781,
			  378, 1071, 1071,  342,  343,  344,  345,  346,  347,  348,
			  349,  391,  391,  391,  391,  166, 1071,  166,  159,  159,
			  159,  391,  391,  391,  391,  391,  391,  166,  166,  398,
			  166,  782, 1071,  159,  396, 1071,  166, 1071,  166, 1071,
			  166, 1071, 1071,  470,  632,  632,  632,  166,  166,  166,
			 1071,  386, 1071,  391,  391,  391,  391,  391,  391,  166,
			  166,  398,  166,  404,  401,  166,  396,  402,  166,  166,
			  166,  166,  166,  166,  166,  471,  166,  799,  159,  166,
			  166,  406,  166,  166,  166,  166,  166,  166, 1071, 1071, yy_Dummy>>,
			1, 200, 1400)
		end

	yy_nxt_template_9 (an_array: ARRAY [INTEGER])
			-- Fill chunk #9 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  408, 1071,  420,  417,  166,  404,  401,  166, 1071,  402,
			  159,  166, 1071,  166, 1071,  166,  166, 1071,  166,  800,
			  166,  166, 1071,  406,  166,  166,  166,  166,  166,  166,
			  421,  419,  408,  512,  421,  417,  166,  159,  166,  166,
			  166,  166,  166,  166,  166,  425,  423, 1071,  159,  166,
			  166,  166,  166,  166,  166,  427,  166,  633,  633,  633,
			  645,  166,  421,  419,  166,  513,  634,  634,  634,  166,
			  166, 1071,  166,  166,  436,  166,  166,  425,  423,  159,
			  166,  166,  166,  166,  166,  166,  166,  427,  166,  437,
			  428,  431,  646,  166,  429,  432,  166,  159,  166,  446,

			  166,  166,  445,  166,  166,  159,  438,  159,  430,  433,
			  166,  166,  440,  166,  166, 1071,  441, 1071,  474, 1071,
			 1071,  439,  431,  431,  159, 1071,  432,  432, 1071,  166,
			  166,  447,  166,  166,  445,  166,  166,  166, 1071,  166,
			  433,  433,  166,  438,  442,  166,  166,  166,  443,  166,
			  475,  166,  159,  166,  435,  815,  166,  159,  439,  166,
			  166,  496,  166,  166,  442,  447,  508, 1071,  443,  166,
			  166,  166,  166, 1071, 1071,  438,  166, 1071,  166,  166,
			 1071,  166, 1071,  166,  166,  166,  435,  816,  166,  166,
			  439,  166,  166,  497,  166,  166,  442,  447,  509,  166, yy_Dummy>>,
			1, 200, 1600)
		end

	yy_nxt_template_10 (an_array: ARRAY [INTEGER])
			-- Fill chunk #10 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  443,  166,  449,  166,  166,  166,  159,  166,  166,  166,
			  166,  166,  452,  677,  453,  166,  454,  159,  159,  166,
			  166,  490, 1071,  159,  166,  491,  166,  455,  451,  620,
			  456,  166, 1071,  166,  449,  166,  166,  166,  166,  166,
			  159,  166, 1071,  166,  457,  678,  458,  166,  459,  166,
			  166,  166, 1071,  492,  466,  166,  166,  493,  166,  460,
			  451,  621,  461,  166,  464,  166,  467,  159,  166,  457,
			  159,  458,  166,  459,  159,  166,  465,  166, 1071,  166,
			  463,  166,  159,  166,  460,  663,  466,  461, 1071,  166,
			 1071,  514,  166,  166,  166,  166,  466,  166,  467,  166,

			  469,  457,  166,  458,  166,  459,  166,  166,  467,  166,
			  473,  166,  463,  166,  166,  166,  460,  664,  166,  461,
			  166,  166,  475,  515,  166,  166,  166,  166,  159,  166,
			  166,  166,  469,  166,  471,  166,  166,  166,  289,  166,
			  290,  290,  473,  166,  166,  166,  166,  166,  502,  477,
			  166,  635,  166,  503,  475, 1071,  166,  159,  166,  166,
			  166,  166,  166,  166,  504,  166,  471,  166,  166,  166,
			 1071,  166,  159,  159,  492,  166,  166,  622,  493,  166,
			  505,  477,  478,  636,  479,  506,  166,  159,  166,  166,
			  166, 1071,  480, 1071,  291,  481,  507,  482,  483, 1071, yy_Dummy>>,
			1, 200, 1800)
		end

	yy_nxt_template_11 (an_array: ARRAY [INTEGER])
			-- Fill chunk #11 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  166,  166,  166,  166,  166,  166,  492, 1071,  166,  623,
			  493,  166, 1071,  166,  484, 1071,  485,  497,  166,  166,
			  166,  495,  166,  166,  486,  291,  166,  487,  166,  488,
			  489,  484,  166,  485, 1071,  501,  647, 1071,  166,  166,
			  159,  486, 1071,  166,  487,  166,  488,  489, 1071,  497,
			  499,  166,  166,  495,  166,  166, 1071,  166,  166,  166,
			  166, 1071,  833,  484,  166,  485,  516,  501,  648,  166,
			  166,  166,  166,  486,  516,  166,  487,  166,  488,  489,
			  505,  509,  499,  166, 1071,  506,  513,  166,  166,  166,
			  166,  166, 1071,  166,  834,  166,  507,  516,  159,  511,

			  166,  166,  166,  296,  166,  166, 1071,  166,  637,  166,
			 1071, 1071,  505,  509,  166, 1071,  517,  506,  513,  166,
			  166, 1071,  166,  516,  517,  166, 1071,  166,  507, 1071,
			  166,  511,  166,  166,  166,  166,  166,  166,  516,  515,
			  638,  166,  166,  166, 1071,  166,  166,  517,  516,  257,
			  258,  259,  260,  261,  262,  263,  264,  257,  258,  259,
			  260,  261,  262,  263,  264,  166,  516,  166,  738,  738,
			  738,  515, 1071,  517,  739,  739,  739,  166, 1071,  518,
			  257,  258,  259,  260,  261,  262,  263,  264,  517,  516,
			  535,  536,  537,  538,  539,  540,  541,  542,  517,  740, yy_Dummy>>,
			1, 200, 2000)
		end

	yy_nxt_template_12 (an_array: ARRAY [INTEGER])
			-- Fill chunk #12 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  740,  740, 1071,  519,  519,  519,  257,  258,  259,  260,
			  261,  262,  263,  264,  516, 1071,  517, 1071,  520,  520,
			 1071,  257,  258,  259,  260,  261,  262,  263,  264,  522,
			  522,  257,  258,  259,  260,  261,  262,  263,  264,  517,
			  159,  159,  159,  159,  159,  159,  521,  521,  521,  257,
			  258,  259,  260,  261,  262,  263,  264,  159,  159,  159,
			  603, 1071,  603, 1071,  517,  604,  604,  604,  604,  523,
			  523,  523,  257,  258,  259,  260,  261,  262,  263,  264,
			  306,  306,  306,  281,  282,  283,  284,  285,  286,  287,
			  288, 1071, 1071,  290,  524,  290,  290,  257,  258,  259,

			  260,  261,  262,  263,  264,  307,  307, 1071,  281,  282,
			  283,  284,  285,  286,  287,  288,  308,  308,  308,  281,
			  282,  283,  284,  285,  286,  287,  288,  309,  309,  281,
			  282,  283,  284,  285,  286,  287,  288,  310,  310,  310,
			  281,  282,  283,  284,  285,  286,  287,  288,  311,  291,
			 1071,  281,  282,  283,  284,  285,  286,  287,  288,  290,
			  624,  293,  290,  290, 1071,  290,  295,  291,  159, 1071,
			  291,  841,  296,  651,  641,  280,  291,  159,  628,  291,
			  291,  296,  159, 1071,  280,  291,  159, 1071,  291,  649,
			  296, 1071,  625,  280,  159,  629,  291,  159, 1071,  291, yy_Dummy>>,
			1, 200, 2200)
		end

	yy_nxt_template_13 (an_array: ARRAY [INTEGER])
			-- Fill chunk #13 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  166,  296, 1071,  842,  280,  652,  642, 1071,  291,  166,
			  630,  291,  159,  296,  166,  294,  280,  719,  166,  291,
			  291,  650, 1071,  291, 1071,  296,  166,  631,  280,  166,
			  291, 1071, 1071,  291,  609,  296,  609, 1071,  280,  610,
			  610,  610,  610, 1071,  166, 1071,  294, 1071, 1071,  720,
			  291,  281,  282,  283,  284,  285,  286,  287,  288,  297,
			  298,  299,  300,  301,  302,  303,  304, 1071,  297,  298,
			  299,  300,  301,  302,  303,  304,  543,  297,  298,  299,
			  300,  301,  302,  303,  304,  544,  544,  544,  297,  298,
			  299,  300,  301,  302,  303,  304, 1071,  545,  545,  159,

			  297,  298,  299,  300,  301,  302,  303,  304,  643,  546,
			  546,  546,  297,  298,  299,  300,  301,  302,  303,  304,
			  547,  547,  297,  298,  299,  300,  301,  302,  303,  304,
			  291,  166, 1071,  291, 1071,  296, 1071, 1071,  280, 1071,
			  644,  291, 1071, 1071,  291, 1071,  296, 1071, 1071,  280,
			  281,  282,  283,  284,  285,  286,  287,  288,  281,  282,
			  283,  284,  285,  286,  287,  288,  281,  282,  283,  284,
			  285,  286,  287,  288,  550,  550,  550,  281,  282,  283,
			  284,  285,  286,  287,  288,  551,  551,  551,  281,  282,
			  283,  284,  285,  286,  287,  288,  552,  552,  552,  281, yy_Dummy>>,
			1, 200, 2400)
		end

	yy_nxt_template_14 (an_array: ARRAY [INTEGER])
			-- Fill chunk #14 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  282,  283,  284,  285,  286,  287,  288,  107, 1071,  146,
			  553,  611,  611,  611,  611,  107, 1071, 1071,  108,  548,
			  548,  548,  297,  298,  299,  300,  301,  302,  303,  304,
			  549, 1071, 1071,  297,  298,  299,  300,  301,  302,  303,
			  304,  554,  159, 1071,  108,  602,  602,  602,  602,  107,
			 1071,  152,  553, 1071, 1071,  639, 1071,  107, 1071,  380,
			  556, 1071,  555,  555,  555,  555,  107, 1071, 1071,  553,
			  604,  604,  604,  604,  166,  107, 1071, 1071,  553,  606,
			  606,  606,  606,  159,  659,  381,  107,  640,  159,  553,
			  685,  380, 1071,  607,  317,  318,  319,  320,  321,  322,

			  323,  324,  120,  121,  122,  123,  124,  125,  126,  127,
			  107, 1071, 1071,  553, 1071,  166,  660, 1071, 1071,  608,
			  166,  107,  686, 1071,  553,  607, 1071, 1071,  120,  121,
			  122,  123,  124,  125,  126,  127,  317,  318,  319,  320,
			  321,  322,  323,  324,  317,  318,  319,  320,  321,  322,
			  323,  324, 1071,  317,  318,  319,  320,  321,  322,  323,
			  324,  557,  317,  318,  319,  320,  321,  322,  323,  324,
			  558,  558,  558,  317,  318,  319,  320,  321,  322,  323,
			  324,  107, 1071, 1071,  553,  618,  618,  618,  618,  760,
			  760,  760,  760,  107,  559,  559,  553,  317,  318,  319, yy_Dummy>>,
			1, 200, 2600)
		end

	yy_nxt_template_15 (an_array: ARRAY [INTEGER])
			-- Fill chunk #15 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  320,  321,  322,  323,  324,  560,  560,  560,  317,  318,
			  319,  320,  321,  322,  323,  324,  107,  159, 1071,  553,
			  619,  619,  619,  619, 1071,  394,  671,  661, 1071,  761,
			  159,  777, 1071,  159,  325, 1071,  325,  325, 1071,  107,
			 1071, 1071,  108,  762,  762,  762,  762, 1071, 1071,  166,
			  389,  389,  389,  107, 1071, 1071,  108, 1071,  672,  662,
			  394,  107,  166,  778,  108,  166,  561,  561,  317,  318,
			  319,  320,  321,  322,  323,  324, 1071,  562,  562,  562,
			  317,  318,  319,  320,  321,  322,  323,  324,  109,  107,
			  614,  764,  108,  764, 1071, 1071,  765,  765,  765,  765,

			  563, 1071,  109,  317,  318,  319,  320,  321,  322,  323,
			  324,  107, 1071, 1071,  108,  766,  766,  766,  766, 1071,
			  109,  107, 1071, 1071,  108,  159,  110,  111,  112,  113,
			  114,  115,  116,  117,  109, 1071,  107,  653,  109,  108,
			  110,  111,  112,  113,  114,  115,  116,  117,  120,  121,
			  122,  123,  124,  125,  126,  127,  679,  166,  107,  675,
			  109,  108, 1071,  159,  159,  610,  610,  610,  610,  654,
			  109, 1071,  107, 1071,  159,  108,  110,  111,  112,  113,
			  114,  115,  116,  117, 1071,  109,  107, 1071,  680,  108,
			  847,  676,  109, 1071,  107,  166,  166,  108,  110,  111, yy_Dummy>>,
			1, 200, 2800)
		end

	yy_nxt_template_16 (an_array: ARRAY [INTEGER])
			-- Fill chunk #16 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  112,  113,  114,  115,  116,  117,  166,  109,  120,  121,
			  122,  123,  124,  125,  126,  127,  107,  109, 1071,  108,
			 1071,  109,  848,  110,  111,  112,  113,  114,  115,  116,
			  117,  107, 1071, 1071,  108,  109,  159,  159,  159,  109,
			 1071, 1071,  564,  564,  564,  110,  111,  112,  113,  114,
			  115,  116,  117,  109, 1071, 1071,  565,  565,  565,  110,
			  111,  112,  113,  114,  115,  116,  117,  109, 1071, 1071,
			  566,  566,  566,  110,  111,  112,  113,  114,  115,  116,
			  117,  120,  121,  122,  123,  124,  125,  126,  127,  107,
			 1071, 1071,  108, 1071, 1071,  681, 1071,  687, 1071,  159,

			  159,  159, 1071,  120,  121,  122,  123,  124,  125,  126,
			  127,  107, 1071, 1071,  108,  567,  567,  567,  120,  121,
			  122,  123,  124,  125,  126,  127, 1071,  682,  683,  688,
			  691,  166,  166,  166,  159,  159,  159,  342,  343,  344,
			  345,  346,  347,  348,  349, 1071,  159,  159,  159, 1071,
			 1071,  342,  343,  344,  345,  346,  347,  348,  349, 1071,
			  684, 1071,  692,  159,  159,  159,  166,  166,  166, 1071,
			  166,  166,  166,  568,  568,  568,  120,  121,  122,  123,
			  124,  125,  126,  127,  570,  342,  343,  344,  345,  346,
			  347,  348,  349, 1071, 1071,  569,  569,  569,  120,  121, yy_Dummy>>,
			1, 200, 3000)
		end

	yy_nxt_template_17 (an_array: ARRAY [INTEGER])
			-- Fill chunk #17 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  122,  123,  124,  125,  126,  127,  571,  571,  571,  342,
			  343,  344,  345,  346,  347,  348,  349, 1071,  166,  166,
			  166,  767,  767,  767,  767,  572,  572,  577,  342,  343,
			  344,  345,  346,  347,  348,  349,  578, 1071, 1071,  573,
			  573,  573,  342,  343,  344,  345,  346,  347,  348,  349,
			  574,  574,  342,  343,  344,  345,  346,  347,  348,  349,
			  580,  768,  166,  166,  166, 1071,  159,  769,  581,  611,
			  611,  611,  611,  575,  575,  575,  342,  343,  344,  345,
			  346,  347,  348,  349, 1071,  870,  870,  870,  870, 1071,
			 1071, 1071,  583,  582,  582,  582,  582,  576,  166,  159,

			  342,  343,  344,  345,  346,  347,  348,  349,  584,  394,
			  342,  343,  344,  345,  346,  347,  348,  349,  585,  342,
			  343,  344,  345,  346,  347,  348,  349,  586,  159,  697,
			  159,  166,  783,  159,  689,  587,  871,  871,  871,  871,
			 1071, 1071, 1071,  342,  343,  344,  345,  346,  347,  348,
			  349,  342,  343,  344,  345,  346,  347,  348,  349,  588,
			  166,  698,  166, 1071,  784,  166,  690,  342,  343,  344,
			  345,  346,  347,  348,  349,  342,  343,  344,  345,  346,
			  347,  348,  349,  589,  765,  765,  765,  765, 1071, 1071,
			 1071,  342,  343,  344,  345,  346,  347,  348,  349,  590, yy_Dummy>>,
			1, 200, 3200)
		end

	yy_nxt_template_18 (an_array: ARRAY [INTEGER])
			-- Fill chunk #18 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			 1071,  342,  343,  344,  345,  346,  347,  348,  349,  591,
			  342,  343,  344,  345,  346,  347,  348,  349,  342,  343,
			  344,  345,  346,  347,  348,  349,  592,  693,  699,  793,
			  694,  159,  159,  159,  593, 1071, 1071,  770,  770,  770,
			  770, 1071,  342,  343,  344,  345,  346,  347,  348,  349,
			  594,  869,  869,  869,  869, 1071, 1071, 1071,  595,  695,
			  700,  794,  696,  166,  166,  166,  342,  343,  344,  345,
			  346,  347,  348,  349,  596, 1071, 1071,  394,  875,  875,
			  875,  875,  342,  343,  344,  345,  346,  347,  348,  349,
			  597,  761,  342,  343,  344,  345,  346,  347,  348,  349,

			  598,  281,  282,  283,  284,  285,  286,  287,  288,  342,
			  343,  344,  345,  346,  347,  348,  349,  342,  343,  344,
			  345,  346,  347,  348,  349, 1071, 1071, 1071, 1071,  619,
			  619,  619,  619,  342,  343,  344,  345,  346,  347,  348,
			  349,  342,  343,  344,  345,  346,  347,  348,  349, 1071,
			  159, 1071, 1071,  759,  759,  759,  759,  342,  343,  344,
			  345,  346,  347,  348,  349, 1071,  711,  380,  715,  394,
			  159, 1071,  159,  342,  343,  344,  345,  346,  347,  348,
			  349, 1071,  166,  342,  343,  344,  345,  346,  347,  348,
			  349,  721, 1071,  381,  159,  159, 1071, 1071,  712,  380, yy_Dummy>>,
			1, 200, 3400)
		end

	yy_nxt_template_19 (an_array: ARRAY [INTEGER])
			-- Fill chunk #19 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  716, 1071,  166, 1071,  166,  128,  128,  128,  342,  343,
			  344,  345,  346,  347,  348,  349, 1071,  873,  873,  873,
			  873, 1071, 1071,  722,  723, 1071,  166,  166,  159,  128,
			  128,  128,  342,  343,  344,  345,  346,  347,  348,  349,
			  877,  877,  877,  877, 1071,  128,  128,  128,  342,  343,
			  344,  345,  346,  347,  348,  349,  724,  874, 1071, 1071,
			  166,  128,  128,  128,  342,  343,  344,  345,  346,  347,
			  348,  349,  599,  599,  599,  342,  343,  344,  345,  346,
			  347,  348,  349,  600,  600,  600,  342,  343,  344,  345,
			  346,  347,  348,  349, 1071, 1071,  601,  601,  601,  342,

			  343,  344,  345,  346,  347,  348,  349,  391,  391,  391,
			  391,  166, 1071,  166,  621, 1071,  625,  391,  391,  391,
			  391,  391,  391,  166,  166,  701,  623,  166,  166,  166,
			  166,  159,  166,  159,  166, 1071,  166,  731, 1071,  166,
			  166, 1071,  159,  166,  166,  166,  621,  616,  625,  391,
			  391,  391,  391,  391,  391,  166,  166,  702,  623,  166,
			  166,  166,  166,  166,  166,  166,  166,  630,  166,  732,
			  627,  166,  166,  166,  166,  166,  166,  166,  166,  166,
			  166,  159,  636,  159,  631,  166,  733, 1071, 1071,  166,
			  166,  166,  709,  166,  166, 1071,  166, 1071, 1071,  630, yy_Dummy>>,
			1, 200, 3600)
		end

	yy_nxt_template_20 (an_array: ARRAY [INTEGER])
			-- Fill chunk #20 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			 1071,  638,  627,  166, 1071,  166,  166,  166, 1071,  166,
			  166,  166,  166,  166,  636,  166,  631,  166,  734,  642,
			  159,  166,  166,  166,  710,  166,  166,  166,  166,  166,
			  166,  773,  166,  638,  166,  166,  166,  640,  166,  166,
			  644,  166,  166,  166,  159, 1071,  166,  650,  648, 1071,
			  646,  642,  166,  166, 1071,  166,  703,  166,  166,  166,
			  166,  166,  166,  774,  166, 1071,  166,  166,  166,  640,
			  166,  166,  644,  166,  166,  166,  166,  652,  166,  650,
			  648,  166,  646,  166,  166,  166,  166,  166,  704,  166,
			  166,  159,  166,  166, 1071,  166,  166,  166,  655,  166,

			  159, 1071,  166, 1071,  654, 1071,  159,  166,  657,  652,
			  771, 1071,  656,  166,  159,  166,  166, 1071,  166,  166,
			  159,  166,  658,  166,  665,  166,  660,  166,  166,  166,
			  657,  166,  166,  166,  159,  166,  654,  666,  166,  166,
			  657, 1071,  772,  795,  658,  166,  166,  670,  166,  166,
			  166,  166,  166,  166,  658,  662,  667, 1071,  660,  166,
			  166, 1071,  166,  166,  166,  166,  166,  166,  159,  668,
			  664,  166,  667,  166,  166,  796, 1071,  166, 1071,  670,
			  166,  166,  166,  166, 1071,  668, 1071,  662,  672,  159,
			 1071,  166,  166,  713,  166,  166,  166,  166,  916,  775, yy_Dummy>>,
			1, 200, 3800)
		end

	yy_nxt_template_21 (an_array: ARRAY [INTEGER])
			-- Fill chunk #21 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  166,  159,  664,  166,  667,  166,  166,  166,  674,  676,
			  166,  166,  166,  166,  678,  166,  166,  668,  166, 1071,
			  672,  166,  166,  166,  680,  714, 1071,  166,  166,  166,
			  917,  776, 1071,  166, 1071,  166, 1071,  166, 1071,  166,
			  674,  676,  166,  166,  166,  166,  678,  166,  166,  159,
			  166,  684,  682, 1071,  166,  166,  680,  725,  159,  166,
			  166,  166,  166,  803,  166, 1071,  166,  166,  166,  166,
			  686,  166, 1071,  688,  166, 1071,  159, 1071,  166,  166,
			  166,  166,  166,  684,  682,  166, 1071,  166,  690,  726,
			  166,  166,  166,  166,  166,  804,  166,  166,  166,  166,

			  166,  166,  686,  166,  695,  688,  166,  696,  166,  692,
			  166,  166,  166,  166,  166,  166,  166,  166,  166,  166,
			  690, 1071, 1071, 1071,  166,  166,  705,  159,  166,  166,
			  827,  166,  159,  166,  779, 1071,  695, 1071, 1071,  696,
			  159,  692,  698,  166,  706,  166,  700,  166,  166,  166,
			  166,  166, 1071,  166,  159,  166,  702,  166,  707,  166,
			  166,  166,  828,  801,  166,  166,  780,  166,  166,  166,
			  166,  787,  166,  707,  698,  159,  708,  704,  700,  166,
			  166,  166,  166,  166,  166,  166,  166,  166,  702,  712,
			 1071,  708,  918,  166,  166,  802,  166,  166,  166,  166, yy_Dummy>>,
			1, 200, 4000)
		end

	yy_nxt_template_22 (an_array: ARRAY [INTEGER])
			-- Fill chunk #22 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  166,  166,  166,  788, 1071,  707,  791,  166,  166,  704,
			  159,  166,  166,  166,  166,  166,  166,  718,  714,  710,
			  166,  712,  166,  708,  919,  166,  166,  716,  166,  166,
			  166,  166,  166, 1071,  166, 1071,  166, 1071,  792, 1071,
			  166,  166,  166, 1071,  922,  166,  166,  166,  159,  718,
			  714,  710,  166,  166,  166,  720, 1071,  166,  785,  716,
			  722,  166,  159,  166,  166,  166,  166,  166,  166,  166,
			  166,  805,  166,  166,  724,  726,  923,  159,  166,  166,
			  166,  166,  166,  166, 1071,  166, 1071,  720,  789, 1071,
			  786, 1071,  722,  166,  166,  728,  516,  166,  166,  166,

			  166,  166,  166,  806,  166,  516,  724,  726,  809,  166,
			  166,  166,  159,  166,  166,  166,  730, 1071,  732,  166,
			  790,  166,  166,  516,  734,  166,  166,  728,  166,  159,
			  166,  166,  166,  166,  166,  166, 1071,  516,  166,  813,
			  810, 1071,  166,  159,  166,  166,  517, 1071,  730,  516,
			  732,  166, 1071,  166,  166,  517,  734, 1071,  166, 1071,
			  166,  166, 1071,  166,  516,  166,  166,  166,  823,  930,
			  166,  814,  159,  517, 1071,  166, 1071,  166,  516,  257,
			  258,  259,  260,  261,  262,  263,  264,  517,  257,  258,
			  259,  260,  261,  262,  263,  264,  296, 1071, 1071,  517, yy_Dummy>>,
			1, 200, 4200)
		end

	yy_nxt_template_23 (an_array: ARRAY [INTEGER])
			-- Fill chunk #23 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  824,  931, 1071, 1071,  166,  296,  257,  258,  259,  260,
			  261,  262,  263,  264,  517, 1071,  296, 1071, 1071, 1071,
			  257,  258,  259,  260,  261,  262,  263,  264,  517,  735,
			  735,  735,  257,  258,  259,  260,  261,  262,  263,  264,
			  296, 1071, 1071, 1071,  736,  736,  736,  257,  258,  259,
			  260,  261,  262,  263,  264,  296, 1071, 1071,  737,  737,
			  737,  257,  258,  259,  260,  261,  262,  263,  264,  296,
			  281,  282,  283,  284,  285,  286,  287,  288, 1071, 1071,
			  296,  159, 1071,  535,  536,  537,  538,  539,  540,  541,
			  542,  741,  535,  536,  537,  538,  539,  540,  541,  542,

			  742,  742,  742,  535,  536,  537,  538,  539,  540,  541,
			  542,  296, 1071,  166,  291, 1071, 1071,  291,  159,  296,
			  159,  829,  280, 1071,  743,  743, 1071,  535,  536,  537,
			  538,  539,  540,  541,  542,  954,  954,  954,  954,  744,
			  744,  744,  535,  536,  537,  538,  539,  540,  541,  542,
			  166, 1071,  166,  830,  745,  745,  535,  536,  537,  538,
			  539,  540,  541,  542,  746,  746,  746,  535,  536,  537,
			  538,  539,  540,  541,  542,  291, 1071, 1071,  291, 1071,
			  296, 1071, 1071,  280,  291, 1071,  946,  291,  797,  296,
			 1071,  849,  280, 1071,  159,  747, 1071,  159,  535,  536, yy_Dummy>>,
			1, 200, 4400)
		end

	yy_nxt_template_24 (an_array: ARRAY [INTEGER])
			-- Fill chunk #24 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  537,  538,  539,  540,  541,  542,  297,  298,  299,  300,
			  301,  302,  303,  304,  291, 1071,  159,  291,  947,  296,
			  798, 1071,  280,  850, 1071,  291,  166, 1071,  291,  166,
			  296, 1071, 1071,  280,  159, 1071,  291, 1071, 1071,  291,
			 1071,  296, 1071,  807,  280, 1071, 1071,  291,  166, 1071,
			  291, 1071,  296,  159,  159,  280,  281,  282,  283,  284,
			  285,  286,  287,  288,  880,  811,  166,  297,  298,  299,
			  300,  301,  302,  303,  304,  808,  297,  298,  299,  300,
			  301,  302,  303,  304,  554,  166,  166,  553,  958,  958,
			  958,  958,  107, 1071, 1071,  553,  881,  812,  342,  343,

			  344,  345,  346,  347,  348,  349,  297,  298,  299,  300,
			  301,  302,  303,  304,  748,  748,  748,  297,  298,  299,
			  300,  301,  302,  303,  304,  749,  749,  749,  297,  298,
			  299,  300,  301,  302,  303,  304,  750,  750,  750,  297,
			  298,  299,  300,  301,  302,  303,  304,  107, 1071, 1071,
			  553,  959,  959,  959,  959,  107, 1071,  159,  553,  119,
			  751,  751,  751,  751,  554,  835,  821,  553,  159, 1071,
			  159,  317,  318,  319,  320,  321,  322,  323,  324,  317,
			  318,  319,  320,  321,  322,  323,  324,  861,  107,  166,
			  119,  553,  159,  159, 1071,  159,  107,  836,  822,  553, yy_Dummy>>,
			1, 200, 4600)
		end

	yy_nxt_template_25 (an_array: ARRAY [INTEGER])
			-- Fill chunk #25 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  166,  825,  166, 1071,  107, 1071, 1071,  553, 1071, 1071,
			  876,  876,  876,  876, 1071,  107, 1071, 1071,  553,  862,
			  961,  961,  961,  961,  166,  166,  107,  166,  159,  553,
			 1071, 1071,  839,  826,  317,  318,  319,  320,  321,  322,
			  323,  324,  317,  318,  319,  320,  321,  322,  323,  324,
			  768,  317,  318,  319,  320,  321,  322,  323,  324,  107,
			  166,  952,  553,  952,  840, 1071,  953,  953,  953,  953,
			 1071,  107, 1071, 1071,  108,  317,  318,  319,  320,  321,
			  322,  323,  324,  317,  318,  319,  320,  321,  322,  323,
			  324,  317,  318,  319,  320,  321,  322,  323,  324,  752,

			  752,  752,  317,  318,  319,  320,  321,  322,  323,  324,
			  753,  753,  753,  317,  318,  319,  320,  321,  322,  323,
			  324,  107, 1071,  159,  108, 1071, 1071,  763,  763,  763,
			  763,  953,  953,  953,  953,  107, 1071, 1071,  108,  884,
			  159,  607, 1071,  754,  754,  754,  317,  318,  319,  320,
			  321,  322,  323,  324,  107,  166,  159,  108,  120,  121,
			  122,  123,  124,  125,  126,  127,  107,  608,  831,  108,
			  109,  885,  166,  607,  107, 1071, 1071,  108,  953,  953,
			  953,  953, 1071, 1071,  109, 1071, 1071,  166,  166,  804,
			  962, 1071,  962, 1071, 1071,  960,  960,  960,  960,  166, yy_Dummy>>,
			1, 200, 4800)
		end

	yy_nxt_template_26 (an_array: ARRAY [INTEGER])
			-- Fill chunk #26 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  832,  920,  109,  109, 1071,  159,  159,  159,  110,  111,
			  112,  113,  114,  115,  116,  117,  109, 1071,  843,  166,
			  817,  804,  110,  111,  112,  113,  114,  115,  116,  117,
			 1071,  166, 1071,  921, 1071,  109, 1071,  166,  166,  166,
			 1071,  110,  111,  112,  113,  114,  115,  116,  117, 1071,
			  844, 1071,  818,  120,  121,  122,  123,  124,  125,  126,
			  127,  120,  121,  122,  123,  124,  125,  126,  127,  342,
			  343,  344,  345,  346,  347,  348,  349,  342,  343,  344,
			  345,  346,  347,  348,  349, 1071, 1071,  342,  343,  344,
			  345,  346,  347,  348,  349,  159, 1071,  755,  755,  755,

			  342,  343,  344,  345,  346,  347,  348,  349, 1071,  159,
			  756,  756,  756,  342,  343,  344,  345,  346,  347,  348,
			  349,  159,  159,  855,  819,  845,  159,  166,  853,  757,
			  757,  757,  342,  343,  344,  345,  346,  347,  348,  349,
			 1071,  166, 1012, 1012, 1012, 1012, 1071, 1071,  758,  582,
			  582,  582,  582,  166,  166,  856,  820,  846,  166, 1071,
			  854, 1017, 1017, 1017, 1017,  128,  128,  128,  342,  343,
			  344,  345,  346,  347,  348,  349,  128,  128,  128,  342,
			  343,  344,  345,  346,  347,  348,  349, 1071,  128,  128,
			  128,  342,  343,  344,  345,  346,  347,  348,  349,  166, yy_Dummy>>,
			1, 200, 5000)
		end

	yy_nxt_template_27 (an_array: ARRAY [INTEGER])
			-- Fill chunk #27 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  166,  166,  166,  166,  159,  166,  772,  159,  774, 1071,
			  776,  166,  166, 1071, 1071,  166, 1071,  159, 1071,  857,
			  859, 1071, 1071,  342,  343,  344,  345,  346,  347,  348,
			  349,  166,  166,  166,  166,  166,  166,  166,  772,  166,
			  774,  778,  776,  166,  166,  780,  166,  166,  166,  166,
			  782,  858,  860,  166,  166,  166,  166,  886,  166,  784,
			  166, 1071,  166,  159,  159,  166,  166,  166, 1071,  166,
			 1071, 1071,  166,  778,  786, 1071, 1071,  780,  166,  166,
			  166, 1071,  782, 1071, 1071,  166,  166,  166,  166,  887,
			  166,  784,  166,  788,  166,  166,  166,  166,  166,  166,

			  166,  166,  166,  794,  166,  166,  786,  166,  166,  792,
			  166,  166,  166,  790,  159,  798,  166,  166,  166,  882,
			  166,  166,  159,  166,  166,  788,  166,  796,  166, 1071,
			 1071,  837,  166,  166,  166,  794,  166,  166,  159,  166,
			  166,  792,  166, 1071,  166,  790,  166,  798,  166,  166,
			  166,  883,  166,  166,  166,  166,  166,  159,  166,  796,
			  166,  800,  159,  838,  166,  166,  166,  166,  166,  166,
			  166,  851,  166,  802,  166,  166,  166,  166,  806,  166,
			  159,  808, 1071,  810,  166,  894, 1071,  166, 1071,  166,
			  166, 1071,  166,  800,  166, 1071,  166, 1071,  166,  166, yy_Dummy>>,
			1, 200, 5200)
		end

	yy_nxt_template_28 (an_array: ARRAY [INTEGER])
			-- Fill chunk #28 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  159,  166,  166,  852,  166,  802,  166,  166,  166,  166,
			  806,  166,  166,  808,  159,  810,  166,  895,  166,  166,
			  166,  166,  166,  166,  166,  906,  816,  812,  814,  166,
			  166,  166,  166,  166,  166,  166,  166,  166,  166,  898,
			  159,  166,  166, 1071,  166, 1071,  166,  166,  818, 1071,
			  166, 1071,  166,  166,  820,  166, 1071,  907,  816,  812,
			  814,  166,  166,  166, 1071,  166, 1071,  166,  166,  166,
			  166,  899,  166,  166,  166,  166,  166,  166,  159,  166,
			  818,  822,  824,  166, 1071,  166,  820,  166,  166,  166,
			  166,  166,  955,  159,  826,  166,  828, 1071,  166, 1071,

			  166,  166,  888, 1071,  166, 1071,  166,  166,  166,  166,
			  166, 1071, 1071,  822,  824,  166,  166,  166,  381,  166,
			  166,  166,  166,  166,  955,  166,  826,  166,  828,  166,
			  166,  166,  166,  166,  889,  830,  166,  166,  166, 1071,
			  166,  166,  166,  166,  166,  166, 1071,  166,  166, 1071,
			 1071, 1071,  832,  834,  166,  166,  166, 1071,  166, 1071,
			 1071,  166,  159,  166,  836, 1071, 1071,  830,  166,  166,
			  166,  896,  166,  166,  166,  166,  166,  166,  842,  166,
			  159,  166,  166,  166,  832,  834,  166,  166,  166,  166,
			  166,  166,  968,  166,  166,  838,  836,  166,  840,  166, yy_Dummy>>,
			1, 200, 5400)
		end

	yy_nxt_template_29 (an_array: ARRAY [INTEGER])
			-- Fill chunk #29 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  166,  166,  166,  897,  166,  846, 1071,  166, 1071,  166,
			  842, 1071,  166,  166,  166,  166,  159,  166, 1071, 1071,
			 1071,  166,  972,  166,  969,  166,  166,  838,  166,  166,
			  840,  166,  166,  166,  166,  844,  890,  846,  166,  166,
			  891,  166,  850,  902,  166,  848, 1071,  159,  166,  166,
			  166,  166,  166,  166,  973,  159,  852,  166,  166,  166,
			  166,  159,  166,  166,  166, 1071,  166,  844,  892,  166,
			  166,  159,  893, 1071,  850,  903,  166,  848,  166,  166,
			  166, 1071,  166,  166,  166,  166,  928,  166,  852,  166,
			  166,  166, 1071,  166,  166,  166,  166,  166,  166,  166,

			  854,  166,  860,  166,  166,  856, 1071, 1071,  166,  166,
			  166,  166,  166,  166,  166,  166,  516,  166,  929, 1071,
			 1071, 1071,  166,  166,  858,  516, 1071,  166,  166,  166,
			  166,  166,  854, 1071,  860, 1071,  166,  856,  516,  862,
			  166,  166,  166,  166,  166,  166,  166,  166,  296,  166,
			  166,  166,  166,  166,  166,  166,  858,  296,  900,  166,
			  914,  159,  166,  166,  159,  296,  517,  953,  953,  953,
			  953,  862, 1071,  296,  166,  517,  166,  957,  957,  957,
			  957, 1071,  166,  166,  166,  166,  166,  296,  517, 1071,
			  901, 1071,  915,  166,  166,  166,  166, 1071,  296,  257, yy_Dummy>>,
			1, 200, 5600)
		end

	yy_nxt_template_30 (an_array: ARRAY [INTEGER])
			-- Fill chunk #30 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  258,  259,  260,  261,  262,  263,  264,  761,  257,  258,
			  259,  260,  261,  262,  263,  264,  296,  874, 1071, 1071,
			 1071,  257,  258,  259,  260,  261,  262,  263,  264,  960,
			  960,  960,  960, 1071, 1071,  535,  536,  537,  538,  539,
			  540,  541,  542, 1071,  535,  536,  537,  538,  539,  540,
			  541,  542,  535,  536,  537,  538,  539,  540,  541,  542,
			  535,  536,  537,  538,  539,  540,  541,  542, 1071,  768,
			 1071,  863,  863,  863,  535,  536,  537,  538,  539,  540,
			  541,  542,  864,  864,  864,  535,  536,  537,  538,  539,
			  540,  541,  542,  107,  924,  159,  553, 1071,  159, 1071,

			  865,  865,  865,  535,  536,  537,  538,  539,  540,  541,
			  542,  291, 1071, 1071,  291, 1071,  296, 1071, 1071,  280,
			  291, 1071, 1071,  291, 1071,  296,  925,  166,  280,  291,
			  166,  166,  291,  166,  296,  159,  879,  280,  619,  619,
			  619,  619,  107,  166,  910,  553,  759,  759,  759,  759,
			  107, 1071, 1071,  553,  119,  866,  866,  866,  866,  107,
			  868,  159,  553,  166, 1071,  166, 1071,  166, 1071, 1071,
			 1071, 1071, 1071, 1071, 1071,  166,  911, 1071,  152, 1071,
			  317,  318,  319,  320,  321,  322,  323,  324,  867, 1071,
			 1071, 1071,  868,  166, 1071,  342,  343,  344,  345,  346, yy_Dummy>>,
			1, 200, 5800)
		end

	yy_nxt_template_31 (an_array: ARRAY [INTEGER])
			-- Fill chunk #31 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  347,  348,  349,  297,  298,  299,  300,  301,  302,  303,
			  304, 1071,  297,  298,  299,  300,  301,  302,  303,  304,
			 1071,  297,  298,  299,  300,  301,  302,  303,  304,  317,
			  318,  319,  320,  321,  322,  323,  324,  317,  318,  319,
			  320,  321,  322,  323,  324, 1071,  317,  318,  319,  320,
			  321,  322,  323,  324,  342,  343,  344,  345,  346,  347,
			  348,  349,  342,  343,  344,  345,  346,  347,  348,  349,
			 1071,  342,  343,  344,  345,  346,  347,  348,  349,  872,
			  872,  872,  872,  872,  872,  872,  872, 1071,  166,  166,
			  166,  166,  166,  607,  883,  881,  887,  878,  932,  885,

			  166,  166,  159,  166,  166,  166,  166, 1071,  166,  960,
			  960,  960,  960, 1071, 1071,  166, 1071, 1071,  166,  608,
			  166,  166,  166,  166,  166,  607,  883,  881,  887,  878,
			  933,  885,  166,  166,  166,  166,  166,  166,  166,  166,
			  166,  166,  166,  166,  166,  166,  166,  166,  895,  889,
			  166,  166,  934,  892,  166,  166,  159,  893,  166, 1071,
			  166, 1071,  166, 1019, 1019, 1019, 1019,  166, 1071,  166,
			 1071,  166,  166,  166,  166,  166,  166,  166,  166,  166,
			  895,  889, 1071,  166,  935,  892,  166,  166,  166,  893,
			  166,  166,  166,  166,  166,  159,  899,  897,  903,  166, yy_Dummy>>,
			1, 200, 6000)
		end

	yy_nxt_template_32 (an_array: ARRAY [INTEGER])
			-- Fill chunk #32 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  166,  166,  166,  166,  166,  166,  940,  166,  901, 1071,
			  904,  166,  166,  159,  166,  159,  166,  166,  908,  159,
			 1071, 1071, 1071,  166,  912,  166,  166,  166,  899,  897,
			  903,  159,  166,  905,  166,  166, 1071,  166,  941,  166,
			  901,  166,  905,  166,  166,  166,  166,  166,  166,  166,
			  909,  166,  166,  166,  166,  166,  913,  909,  166,  166,
			  907,  166, 1018,  166,  166,  905,  166,  166,  166, 1031,
			 1071,  166,  911,  166,  159,  166,  159, 1071,  166,  960,
			  960,  960,  960,  926,  166,  166,  166,  166,  608,  909,
			 1071,  166,  907,  166, 1018,  166,  166,  913,  166,  166,

			  166, 1032,  915,  166,  911, 1071,  166,  166,  166,  166,
			  166,  166,  166,  917,  166,  927,  166,  919,  166,  938,
			  166,  166,  166,  159,  166,  159,  921,  166,  166,  913,
			 1071, 1071,  166, 1071,  915,  166, 1071,  166,  159,  166,
			 1071,  166, 1071,  166,  166,  917,  166,  166,  166,  919,
			  166,  939,  166,  166,  166,  166,  166,  166,  921,  166,
			  166,  166,  159,  923,  166,  925,  166,  166,  166,  166,
			  166,  166,  166,  942,  166,  166, 1071,  166,  166,  166,
			  166,  927,  166, 1071,  166, 1071,  948,  166, 1071, 1071,
			  159,  166,  929,  166,  166,  923,  931,  925,  166,  166, yy_Dummy>>,
			1, 200, 6200)
		end

	yy_nxt_template_33 (an_array: ARRAY [INTEGER])
			-- Fill chunk #33 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  166,  166,  159,  166,  166,  943,  166,  166,  933,  166,
			  166,  166,  166,  927,  166,  166,  166,  166,  949,  166,
			  159,  966,  166,  935,  929,  159, 1071,  166,  931,  936,
			  166,  166,  166,  166,  166,  159,  159,  939, 1071,  166,
			  933,  166,  166,  166,  166,  937,  166,  166, 1071,  166,
			  976,  166,  166,  967,  159,  935,  166,  166,  166,  166,
			  166,  937,  166,  166,  166,  166,  941,  166,  166,  939,
			  166,  166,  944,  166,  166,  166,  166,  937,  166,  166,
			  159,  166,  977,  166, 1071, 1071,  166,  943,  166, 1071,
			  166,  166,  166, 1071, 1071,  166, 1071,  166,  941,  296,

			 1071, 1071,  166,  945,  945, 1071,  166,  166,  166,  296,
			  159,  166,  166,  166,  166,  950,  166,  947,  166,  943,
			  166,  296,  166,  166,  949,  166,  166,  166,  978,  159,
			  159,  166,  166,  166,  159,  945,  159,  166,  166,  166,
			  166,  951,  166,  166,  159,  970,  166,  951,  166,  947,
			  166,  166,  166,  159,  166, 1071,  949,  166,  166,  166,
			  979,  166,  166,  166,  166,  166,  166,  107,  166,  166,
			  553,  166, 1071,  951, 1071,  166,  166,  971, 1071,  119,
			 1071, 1071, 1071,  166,  159,  166,  535,  536,  537,  538,
			  539,  540,  541,  542, 1071,  974,  535,  536,  537,  538, yy_Dummy>>,
			1, 200, 6400)
		end

	yy_nxt_template_34 (an_array: ARRAY [INTEGER])
			-- Fill chunk #34 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  539,  540,  541,  542,  872,  872,  872,  872,  535,  536,
			  537,  538,  539,  540,  541,  542,  166, 1071,  956,  964,
			  964,  964,  964, 1014, 1014, 1014, 1014,  975, 1071, 1071,
			  166, 1071,  166,  965,  166,  982,  166,  166, 1071,  166,
			 1071,  159,  166,  159,  967,  971,  166, 1071,  159,  166,
			  956,  166, 1071,  166,  317,  318,  319,  320,  321,  322,
			  323,  324,  166,  166,  166,  965,  166,  983,  166,  166,
			  166,  166,  166,  166,  166,  166,  967,  971,  166,  969,
			  166,  166,  166,  166,  166,  166,  166,  166,  980,  166,
			  973, 1071,  159,  984,  977,  166,  166,  159,  166,  166,

			  166,  166,  166,  166,  166,  166,  975,  166, 1004, 1071,
			  166,  969,  159,  166,  166, 1071,  166,  166,  166,  166,
			  981,  166,  973,  979,  166,  985,  977, 1071,  166,  166,
			  166,  166,  166,  166,  166,  166,  166,  166,  975,  166,
			 1005,  166,  166,  166,  166,  166,  166,  983,  994,  166,
			  981, 1071,  166,  166,  166,  979,  159,  166,  166,  166,
			  166, 1071,  159,  159,  166,  166,  166,  166,  166,  166,
			  166,  159,  986,  166,  985,  166,  988,  166,  166,  983,
			  995,  166,  981,  166,  166,  166,  166, 1071,  166,  166,
			  166,  166,  166,  166,  166,  166,  166,  166,  166,  166, yy_Dummy>>,
			1, 200, 6600)
		end

	yy_nxt_template_35 (an_array: ARRAY [INTEGER])
			-- Fill chunk #35 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  166,  166,  166,  166,  987,  987,  985,  159,  989,  166,
			  166,  159,  166,  166,  989,  166,  159,  159,  990,  166,
			 1035,  166,  992,  159,  166,  166,  166,  991,  166, 1071,
			  166,  166,  166,  166,  993,  166,  159,  987,  166,  166,
			 1071,  997,  166,  166,  166,  166,  989,  996,  166,  166,
			  991,  166, 1036,  166,  993,  166,  166,  159,  166,  991,
			  166,  995, 1000,  166,  159,  166,  993,  166,  166, 1002,
			  166,  159,  166,  997,  166,  159,  166,  166,  166,  997,
			  166,  998,  166,  999,  166,  166, 1006, 1001,  166,  166,
			 1071, 1071,  166,  995, 1001, 1071,  166,  166, 1071,  159,

			 1071, 1003, 1071,  166,  166, 1071,  166,  166,  166,  166,
			  166, 1003,  166,  999,  166,  999,  166,  166, 1007, 1001,
			  166,  166,  159,  166,  166,  166,  166, 1005,  166,  166,
			  166,  166,  166, 1010,  166,  166,  166,  166,  166,  166,
			 1041,  166,  166, 1003,  159, 1071,  166,  159, 1071,  166,
			 1071, 1071, 1008,  166,  166,  166, 1071,  166,  166, 1005,
			  166,  166,  166, 1009,  166, 1011,  166,  166,  166,  166,
			  166,  166, 1042,  166,  166,  166,  166,  166,  166,  166,
			  166,  166,  166, 1007, 1009, 1023,  166,  166,  166,  159,
			  159,  159,  166,  166, 1011, 1009, 1027, 1071,  166, 1016, yy_Dummy>>,
			1, 200, 6800)
		end

	yy_nxt_template_36 (an_array: ARRAY [INTEGER])
			-- Fill chunk #36 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			 1016, 1016, 1016, 1071, 1071,  166, 1071,  166,  159,  166,
			 1071, 1071,  166, 1071,  166, 1007, 1071, 1024,  166,  166,
			  166,  166,  166,  166,  166, 1071, 1011, 1013, 1028, 1013,
			  166, 1071, 1014, 1014, 1014, 1014, 1015, 1071, 1015,  874,
			  166, 1016, 1016, 1016, 1016, 1020, 1020, 1020, 1020, 1021,
			 1024, 1021,  159, 1071, 1022, 1022, 1022, 1022,  166, 1018,
			  166,  159, 1071, 1025,  166,  166,  166,  166,  159,  166,
			  166, 1028, 1026, 1071, 1029, 1071,  166,  166, 1071,  159,
			 1071,  166, 1024, 1071,  166,  608, 1071, 1071, 1071, 1033,
			  166, 1018,  166,  166,  159, 1026,  166,  166,  166,  166,

			  166,  166,  166, 1028, 1026,  166, 1030,  166,  166,  166,
			 1030,  166, 1032,  166,  159, 1034, 1071,  166,  166, 1039,
			  166, 1034,  166,  166,  166,  166,  166,  159, 1045, 1036,
			  166,  166,  159, 1043,  166,  166,  166,  166,  166,  166,
			 1071,  166, 1030, 1037, 1032,  159,  166, 1034,  166,  166,
			  166, 1040,  166, 1071,  166,  166,  166,  166, 1071,  166,
			 1046, 1036,  166,  166,  166, 1044,  166,  166,  166,  166,
			  166,  166,  166,  166,  166, 1038, 1047,  166, 1038,  159,
			  166,  166,  159,  166,  166,  166,  166,  166,  166, 1040,
			 1062,  159,  159, 1042, 1071,  166, 1071, 1071,  166,  166, yy_Dummy>>,
			1, 200, 7000)
		end

	yy_nxt_template_37 (an_array: ARRAY [INTEGER])
			-- Fill chunk #37 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  166,  166,  166,  166,  166, 1071,  166, 1071, 1048, 1071,
			 1038,  166,  166,  166,  166,  166,  166,  166,  166,  166,
			  166, 1040, 1063,  166,  166, 1042,  166,  166,  166, 1044,
			  166,  166,  166, 1046,  166, 1071, 1048,  166,  166,  166,
			  166, 1071,  166, 1071,  166,  166, 1049,  166, 1071,  166,
			  159, 1051,  166, 1071,  159,  159, 1071,  166,  166, 1071,
			  166, 1044, 1071, 1064, 1071, 1046, 1050, 1071, 1048,  166,
			  166,  166,  166,  166,  166,  166, 1071,  166, 1050,  166,
			 1071,  166,  166, 1052,  166,  166,  166,  166, 1071,  166,
			 1052,  166, 1058,  166, 1071, 1065,  159,  166, 1050,  166,

			 1071, 1071, 1071,  166, 1071,  166, 1071,  166, 1071,  166,
			 1053, 1053, 1053, 1053, 1071, 1071, 1071,  166, 1016, 1016,
			 1016, 1016, 1052,  166, 1059,  166, 1071, 1071,  166,  166,
			 1071,  166, 1071, 1071, 1071,  166, 1016, 1016, 1016, 1016,
			 1071,  166, 1054, 1054, 1054, 1054, 1055, 1071, 1055, 1071,
			  761, 1056, 1056, 1056, 1056,  959,  959,  959,  959, 1022,
			 1022, 1022, 1022, 1057, 1057, 1057, 1057, 1059,  166, 1018,
			  166, 1071, 1071,  166,  166,  166,  166,  166,  159,  166,
			  166, 1060, 1061, 1066,  166,  166,  166,  159, 1071,  166,
			 1056, 1056, 1056, 1056,  166,  608, 1071, 1071, 1071, 1059, yy_Dummy>>,
			1, 200, 7200)
		end

	yy_nxt_template_38 (an_array: ARRAY [INTEGER])
			-- Fill chunk #38 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  166, 1018,  166,  768, 1071,  166,  166,  166,  166,  166,
			  166,  166,  166, 1061, 1061, 1067,  166,  166,  166,  166,
			  166,  166,  166,  166, 1071,  166,  166,  166,  166,  166,
			  166,  166,  166,  166, 1069,  166, 1063, 1071,  159,  166,
			  166, 1071, 1071,  166,  166, 1071,  166, 1071, 1071, 1071,
			 1065, 1071,  166, 1071,  166,  166,  166,  166, 1071,  166,
			  166,  166,  166,  166,  166,  166, 1070,  166, 1063, 1071,
			  166,  166,  166, 1071, 1067,  166,  166,  166,  166,  166,
			 1071,  166, 1065,  166,  166,  166,  166,  166,  166,  166,
			 1071, 1071, 1071,  166, 1071, 1071,  166,  166, 1012, 1012,

			 1012, 1012, 1068, 1068, 1068, 1068, 1067, 1071, 1071,  166,
			 1071,  166,  166,  166,  166,  166,  166,  166,  166,  166,
			 1071,  166, 1071, 1071,  166,  166, 1071, 1071,  166,  166,
			 1019, 1019, 1019, 1019, 1070,  166, 1071,  166,  761, 1071,
			 1071,  166,  874,  166,  166, 1071,  166,  166,  166,  166,
			  166,  166, 1071,  166, 1071, 1071,  166, 1071, 1071, 1071,
			  166,  166, 1054, 1054, 1054, 1054, 1070,  166, 1071,  166,
			  768, 1071,  166,  166,  166,  166, 1071, 1071, 1071,  166,
			  166,  166,  166,  166,  166,  166, 1071, 1071, 1071, 1071,
			 1071, 1071,  166,  166, 1071, 1071, 1071, 1071, 1071, 1071, yy_Dummy>>,
			1, 200, 7400)
		end

	yy_nxt_template_39 (an_array: ARRAY [INTEGER])
			-- Fill chunk #39 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			 1071, 1071,  874, 1071,  166, 1071,  166, 1071, 1071, 1071,
			 1071, 1071, 1071, 1071, 1071, 1071,  166,   87,   87,   87,
			   87,   87,   87,   87,   87,   87,   87,   87,   87,   87,
			   87,   87,   87,   87,   87,   87,   87,   87,   87,   87,
			  106,  106, 1071,  106,  106,  106,  106,  106,  106,  106,
			  106,  106,  106,  106,  106,  106,  106,  106,  106,  106,
			  106,  106,  106,  118, 1071, 1071, 1071, 1071, 1071, 1071,
			  118,  118,  118,  118,  118,  118,  118,  118,  118,  118,
			  118,  118,  118,  118,  118,  118,  119,  119, 1071,  119,
			  119,  119,  119,  119,  119,  119,  119,  119,  119,  119,

			  119,  119,  119,  119,  119,  119,  119,  119,  119,  128,
			  128, 1071,  128,  128,  128,  128, 1071,  128,  128,  128,
			  128,  128,  128,  128,  128,  128,  128,  128,  128,  128,
			  128,  128,  148,  148,  148,  148,  148,  148,  148,  148,
			  148, 1071,  148,  148,  148,  148,  256,  256, 1071,  256,
			  256,  256, 1071, 1071,  256,  256,  256,  256,  256,  256,
			  256,  256,  256, 1071,  256,  256,  256,  256,  256,  166,
			  166,  166,  166,  166,  166,  166,  166, 1071,  166,  166,
			  166,  166,  166,  280, 1071, 1071,  280, 1071, 1071,  280,
			  280,  280,  280,  280,  280,  280,  280,  280,  280,  280, yy_Dummy>>,
			1, 200, 7600)
		end

	yy_nxt_template_40 (an_array: ARRAY [INTEGER])
			-- Fill chunk #40 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  280,  280,  280,  280,  280,  280,  294,  294, 1071,  294,
			  294,  294,  294,  294,  294,  294,  294,  294,  294,  294,
			  294,  294,  294,  294,  294,  294,  294,  294,  294,  312,
			  312, 1071,  312,  312,  312,  312,  312,  312,  312,  312,
			  312,  312,  312,  312,  312,  312,  312,  312,  312,  312,
			  312,  312,  340, 1071, 1071, 1071, 1071,  340,  340,  340,
			  340,  340,  340,  340,  340,  340,  340,  340,  340,  340,
			  340,  340,  340,  340,  340,  382,  382,  382,  382,  382,
			  382,  382,  382, 1071,  382,  382,  382,  382,  382,  382,
			  382,  382,  382,  382,  382,  382,  382,  382,  388,  388,

			  388,  388,  388,  388,  388,  388, 1071,  388,  388,  388,
			  388,  390,  390,  390,  390,  390,  390,  390,  390, 1071,
			  390,  390,  390,  390,  392,  392,  392,  392,  392,  392,
			  392,  392, 1071,  392,  392,  392,  392,  291,  291, 1071,
			  291,  291,  291, 1071,  291,  291,  291,  291,  291,  291,
			  291,  291,  291,  291,  291,  291,  291,  291,  291,  291,
			  963,  963,  963,  963,  963,  963,  963,  963, 1071,  963,
			  963,  963,  963,  963,  963,  963,  963,  963,  963,  963,
			  963,  963,  963,    5, 1071, 1071, 1071, 1071, 1071, 1071,
			 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071, yy_Dummy>>,
			1, 200, 7800)
		end

	yy_nxt_template_41 (an_array: ARRAY [INTEGER])
			-- Fill chunk #41 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071,
			 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071,
			 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071,
			 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071,
			 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071,
			 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071,
			 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071,
			 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071,
			 1071, 1071, 1071, 1071, 1071, yy_Dummy>>,
			1, 85, 8000)
		end

	yy_chk_template: SPECIAL [INTEGER]
			-- Template for `yy_chk'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 8084)
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

			    1,    1,    3,    3,    3,    3,   39,    3,   22,   23,
			 1054,   23,   23,   23,   23,    4,    4,    4,    4,   22,
			    4,   24,   26,  148,   26,   26,   26,   26, 1019,   24,
			   29,   29,   31,   31,   12,   50,   50,   12,   39, 1012,
			   35,   35,   15,   44,   35,   15,   16,   35,   16,   16,
			   35,  617,   44,   35,   16,   41,   82,   82,    3,   84,
			   84,   41,  176,  176,   26,  148,  615,   50,   50,  178,
			  178,    4,   35,   35,  159,   44,   35,  268,  268,   35,
			  149,  149,   35,   12,   44,   35,  613,   41,  392,    3,
			  270,  270,   24,   41,    3,    3,    3,    3,    3,    3, yy_Dummy>>,
			1, 200, 0)
		end

	yy_chk_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			    3,    3,    4,   79,   79,   79,  159,    4,    4,    4,
			    4,    4,    4,    4,    4,   12,   81,   81,   81,  390,
			  149,   12,   12,   12,   12,   12,   12,   12,   12,   15,
			   15,   15,   15,   15,   15,   15,   15,  388,   16,   16,
			   16,   16,   16,   16,   16,   16,   25,   42,   25,   25,
			   25,   25,  352,   42,   36,  194,  272,   34,   36,   25,
			   25,   34,   37,   34,   36,   37,   34,   37,   34,  162,
			   51,   45,  162,   34,   34,   45,   51,   37,  266,   42,
			  386,   25,   83,   83,   83,   42,   36,  194,   25,   34,
			   36,   25,   25,   34,   37,   34,   36,   37,   34,   37,

			   34,  162,   51,   45,  162,   34,   34,   45,   51,   37,
			   85,   85,   85,   25,   33,   33,   33,   33,   48,  173,
			  173,  173,  386,   48,   33,   33,   33,   33,   33,   33,
			   33,   33,   33,   33,   33,   33,   33,   33,   33,   33,
			   33,   33,   33,   33,   33,   33,   33,   33,   33,   33,
			   48,  175,  175,  175,   33,   48,   33,   33,   33,   33,
			   33,   33,   33,   33,   33,   33,   33,   33,   33,   33,
			   33,   33,   33,   33,   33,   33,   33,   33,   33,   33,
			   33,   33,  147,  180,  147,  147,  147,  147,   33,   33,
			   33,   33,   33,   33,   33,   33,   38,  174,   40,  129, yy_Dummy>>,
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
			   43,  160,   46,  161,  163,   49,  104,  161,   46,  163,
			  102,   49,   86,   46,   56,   56,   56,   56,   56,   56,
			   56,   56,   57,   63,  183,   63,   57,   60,  183,  212,
			   60,   57,  164,   57,   60,   63,   58,   60,   57,   57,
			   60,  226,  164,   60,   87,   87,   87,   87,   87,   87,

			   87,   87,   80,   53,   57,   63,  183,   63,   57,   60,
			  183,  212,   60,   57,  164,   57,   60,   63,   58,   60,
			   57,   57,   60,  226,  164,   60,   94,   94,   94,   94,
			   94,   94,   94,   94,   57,   57,   57,   57,   57,   57,
			   57,   57,   58,   58,   58,   58,   58,   58,   58,   58,
			   59,  197,   61,  165,   59,  181,   61,   59,   61,   61,
			   59,  197,   61,   59,  165,   61,  181,  248,   61,   95,
			   95,   95,   95,   95,   95,   95,   95,   95,  150,  150,
			  150,   32,   59,  197,   61,  165,   59,  181,   61,   59,
			   61,   61,   59,  197,   61,   59,  165,   61,  181,  248, yy_Dummy>>,
			1, 200, 400)
		end

	yy_chk_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			   61,   88,   27,   88,   88,   11,   10,   59,   59,   59,
			   59,   59,   59,   59,   59,   62,   64,    9,  150,   62,
			  400,  205,   64,   64,   64,    7,   62,  205,   62,   64,
			   65,    5,   62,   65,   64,   65,   65,   66,   62,   66,
			   66,  177,  177,  177,    0,   65,    0,   62,   64,   66,
			    0,   62,  400,  205,   64,   64,   64,   88,   62,  205,
			   62,   64,   65,   67,   62,   65,   64,   65,   65,   66,
			   62,   66,   66,   67,   68,   67,   68,   65,  187,   67,
			   68,   66,   69,   70,  403,   67,   68,  187,   88,   69,
			   70,   69,   70,   70,    0,   67,    0,    0,   70,    0,

			    0,   69,   70,    0,    0,   67,   68,   67,   68,    0,
			  187,   67,   68,    0,   69,   70,  403,   67,   68,  187,
			    0,   69,   70,   69,   70,   70,   72,  185,   72,   73,
			   70,   71,  185,   69,   70,   71,  203,   71,   72,  203,
			   73,   71,   73,   73,  179,  179,  179,   71,   91,   74,
			   91,   91,   73,   74,   75,   74,   75,   75,   72,  185,
			   72,   73,    0,   71,  185,   74,   75,   71,  203,   71,
			   72,  203,   73,   71,   73,   73,  265,  265,  265,   71,
			    0,   74,  387,  387,   73,   74,   75,   74,   75,   75,
			   90,   90,   90,   90,  267,  267,  267,   74,   75,    0, yy_Dummy>>,
			1, 200, 600)
		end

	yy_chk_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			   93,  405,    0,   93,   91,   93,    0,    0,   93,   96,
			   96,   96,   96,   96,   96,   96,   96,   96,   96,   96,
			   97,   97,  387,   97,   97,   97,   97,   97,   97,   97,
			   97,  106,    0,  405,  106,   91,   99,   99,   99,   99,
			   99,   99,   99,   99,   99,   99,   90,   98,   98,   98,
			   98,   98,   98,   98,   98,   98,   98,   98,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  152,
			  221,  152,  152,  152,  152,  612,  612,   90,    0,    0,
			  106,  221,   90,   90,   90,   90,   90,   90,   90,   90,
			    0,    0,   93,   93,   93,   93,   93,   93,   93,   93,

			  101,  416,  221,  101,  101,  101,  101,  101,  101,  101,
			  101,  152,  106,  221,  110,  612,    0,  110,  106,  106,
			  106,  106,  106,  106,  106,  106,  108,    0,    0,  108,
			  108,  108,  108,  416,  146,  146,  146,  146,  108,    0,
			  111,    0,    0,  111,    0,  108,  210,  108,  146,  108,
			  108,  108,  436,  210,  108,  186,  108,    0,    0,  186,
			  108,  112,  108,  110,  112,  108,  108,  108,  108,  108,
			  108,  109,    0,  109,  109,    0,  109,    0,  210,  109,
			  146,  269,  269,  269,  436,  210,    0,  186,    0,  111,
			  113,  186,    0,  113,    0,  110,  271,  271,  271,    0, yy_Dummy>>,
			1, 200, 800)
		end

	yy_chk_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			    0,  110,  110,  110,  110,  110,  110,  110,  110,  114,
			  112,  453,  114,  108,  108,  108,  108,  108,  108,  108,
			  108,  111,  273,  273,  273,  109,  111,  111,  111,  111,
			  111,  111,  111,  111,  111,    0,    0,  115,    0,  113,
			  115,  450,  112,  453,  450,  112,  112,  112,  112,  112,
			  112,  112,  112,  112,  112,  112,  116,  109,  114,  116,
			  274,  274,  274,  109,  109,  109,  109,  109,  109,  109,
			  109,  113,    0,  450,  113,  113,  450,  113,  113,  113,
			  113,  113,  113,  113,  113,  117,  115,  217,  117,  217,
			  114,    0,    0,  114,  114,  114,  114,  114,  114,  114,

			  114,  114,  114,  114,  119,  116,  472,  119,  275,  275,
			  275,    0,  120,    0,    0,  120,    0,    0,  115,  217,
			    0,  217,  115,  115,  115,  115,  115,  115,  115,  115,
			  115,  115,  121,    0,  117,  121,  496,  116,  472,  504,
			  116,  116,  116,  116,  116,  116,  116,  116,  116,  116,
			  116,  122,  224,    0,  122,    0,    0,  224,  276,  276,
			  276,    0,  123,    0,    0,  123,  117,    0,  496,  117,
			    0,  504,  117,  117,  117,  117,  117,  117,  117,  117,
			  124,  231,    0,  124,  224,  231,  277,  277,  277,  224,
			    0,  119,  119,  119,  119,  119,  119,  119,  119,  120, yy_Dummy>>,
			1, 200, 1000)
		end

	yy_chk_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  120,  120,  120,  120,  120,  120,  120,  125,    0,    0,
			  125,    0,    0,  231,  278,  278,  278,  231,  121,  121,
			  121,  121,  121,  121,  121,  121,  121,  126,    0,    0,
			  126,  279,  279,  279,    0,  122,  122,  122,  122,  122,
			  122,  122,  122,  122,  122,  122,  123,  123,  128,  123,
			  123,  123,  123,  123,  123,  123,  123,  127,    0,  508,
			  127,  409,  409,  409,  124,  124,  124,  124,  124,  124,
			  124,  124,  124,  124,  124,  280,  280,  280,  280,  280,
			  280,  280,  280,  281,  281,  281,  281,  281,  281,  281,
			  281,  508,  125,  125,  125,  125,  125,  125,  125,  125,

			  125,  125,  282,  282,  282,  282,  282,  282,  282,  282,
			  282,  126,  126,  126,  126,  126,  126,  126,  126,  126,
			  126,  126,  131,  389,  389,  389,  142,  142,  142,  142,
			  242,  128,  128,  128,  128,  128,  128,  128,  128,  132,
			  142,  127,  242,    0,  127,  127,  127,  127,  127,  127,
			  127,  127,  130,  514,    0,  130,  130,  130,  130,  410,
			  410,  410,  242,  389,  130,  236,  142,  133,    0,  236,
			    0,  130,  142,  130,  242,  130,  130,  130,  130,  134,
			  130,    0,  130,  241,    0,  514,  130,  241,  130,    0,
			  135,  130,  130,  130,  130,  130,  130,  236,    0,    0, yy_Dummy>>,
			1, 200, 1200)
		end

	yy_chk_template_8 (an_array: ARRAY [INTEGER])
			-- Fill chunk #8 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  136,  236,  131,  131,  131,  131,  131,  131,  131,  131,
			  131,  131,  131,  137,    0,  241,  411,  411,  411,  241,
			    0,  132,  132,  132,  132,  132,  132,  132,  132,  132,
			  138,  305,  305,  305,  305,  305,  305,  305,  305,  130,
			  130,  130,  130,  130,  130,  130,  130,  133,  133,  133,
			  133,  133,  133,  133,  133,  133,  133,  133,    0,  134,
			  134,    0,  134,  134,  134,  134,  134,  134,  134,  134,
			  135,  135,  135,  135,  135,  135,  135,  135,  135,  135,
			  135,  136,  136,  136,  136,  136,  136,  136,  136,  136,
			  136,    0,    0,  137,  137,  137,  137,  137,  137,  137,

			  137,  137,  137,  137,  381,  381,  381,  381,    0,  629,
			  138,    0,    0,  138,  138,  138,  138,  138,  138,  138,
			  138,  151,  151,  151,  151,  166,    0,  166,  412,  412,
			  412,  151,  151,  151,  151,  151,  151,  166,  167,  168,
			  167,  629,    0,  223,  167,    0,  168,    0,  168,    0,
			  167,    0,    0,  223,  413,  413,  413,  166,  168,  166,
			    0,  151,    0,  151,  151,  151,  151,  151,  151,  166,
			  167,  168,  167,  170,  169,  223,  167,  169,  168,  169,
			  168,  170,  167,  170,  171,  223,  171,  651,  665,  169,
			  168,  171,  172,  170,  172,  182,  171,  182,    0,    0, yy_Dummy>>,
			1, 200, 1400)
		end

	yy_chk_template_9 (an_array: ARRAY [INTEGER])
			-- Fill chunk #9 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  172,    0,  184,  182,  172,  170,  169,  182,    0,  169,
			  184,  169,    0,  170,    0,  170,  171,    0,  171,  651,
			  665,  169,    0,  171,  172,  170,  172,  182,  171,  182,
			  189,  188,  172,  251,  184,  182,  172,  251,  188,  182,
			  188,  189,  184,  189,  190,  191,  190,    0,  428,  192,
			  188,  192,  191,  189,  191,  192,  190,  414,  414,  414,
			  428,  192,  189,  188,  191,  251,  415,  415,  415,  251,
			  188,    0,  188,  189,  198,  189,  190,  191,  190,  198,
			  428,  192,  188,  192,  191,  189,  191,  192,  190,  198,
			  193,  195,  428,  192,  193,  195,  191,  193,  196,  204,

			  196,  195,  206,  195,  206,  199,  198,  204,  193,  195,
			  196,  198,  199,  195,  206,    0,  199,    0,  225,    0,
			    0,  198,  193,  195,  225,    0,  193,  195,    0,  193,
			  196,  204,  196,  195,  206,  195,  206,  199,    0,  204,
			  193,  195,  196,  201,  199,  195,  206,  200,  199,  200,
			  225,  201,  237,  201,  200,  669,  225,  247,  201,  200,
			  202,  237,  202,  201,  202,  207,  247,    0,  202,  525,
			  525,  525,  202,    0,    0,  201,  207,    0,  207,  200,
			    0,  200,    0,  201,  237,  201,  200,  669,  207,  247,
			  201,  200,  202,  237,  202,  201,  202,  207,  247,  208, yy_Dummy>>,
			1, 200, 1600)
		end

	yy_chk_template_10 (an_array: ARRAY [INTEGER])
			-- Fill chunk #10 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  202,  208,  208,  213,  202,  213,  455,  216,  207,  216,
			  207,  208,  211,  455,  211,  213,  211,  211,  235,  216,
			  207,  235,    0,  395,  214,  235,  214,  211,  214,  395,
			  211,  208,    0,  208,  208,  213,  214,  213,  455,  216,
			  681,  216,    0,  208,  211,  455,  211,  213,  211,  211,
			  235,  216,    0,  235,  220,  395,  214,  235,  214,  211,
			  214,  395,  211,  220,  218,  220,  220,  685,  214,  215,
			  218,  215,  681,  215,  446,  220,  218,  215,    0,  215,
			  219,  219,  253,  219,  215,  446,  220,  215,    0,  215,
			    0,  253,  222,  219,  222,  220,  218,  220,  220,  685,

			  222,  215,  218,  215,  222,  215,  446,  220,  218,  215,
			  228,  215,  219,  219,  253,  219,  215,  446,  228,  215,
			  228,  215,  229,  253,  222,  219,  222,  227,  687,  227,
			  228,  229,  222,  229,  227,  230,  222,  230,  289,  227,
			  289,  289,  228,  229,  526,  526,  526,  230,  245,  232,
			  228,  418,  228,  245,  229,    0,  232,  418,  232,  227,
			  687,  227,  228,  229,  245,  229,  227,  230,  232,  230,
			    0,  227,  397,  691,  238,  229,  238,  397,  238,  230,
			  245,  232,  233,  418,  233,  245,  238,  233,  232,  418,
			  232,    0,  233,    0,  289,  233,  245,  233,  233,    0, yy_Dummy>>,
			1, 200, 1800)
		end

	yy_chk_template_11 (an_array: ARRAY [INTEGER])
			-- Fill chunk #11 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  232,  527,  527,  527,  397,  691,  238,    0,  238,  397,
			  238,  240,    0,  240,  233,    0,  233,  240,  238,  233,
			  239,  239,  239,  240,  233,  289,  244,  233,  244,  233,
			  233,  234,  239,  234,    0,  244,  429,    0,  244,  234,
			  429,  234,    0,  240,  234,  240,  234,  234,    0,  240,
			  243,  234,  239,  239,  239,  240,    0,  243,  244,  243,
			  244,    0,  694,  234,  239,  234,  256,  244,  429,  243,
			  244,  234,  429,  234,  257,  249,  234,  249,  234,  234,
			  246,  249,  243,  234,    0,  246,  252,  249,  246,  243,
			  246,  243,    0,  252,  694,  252,  246,  258,  420,  250,

			  246,  243,  250,  291,  250,  252,    0,  249,  420,  249,
			    0,    0,  246,  249,  250,    0,  256,  246,  252,  249,
			  246,    0,  246,  259,  257,  252,    0,  252,  246,    0,
			  420,  250,  246,  254,  250,  254,  250,  252,  260,  254,
			  420,  528,  528,  528,    0,  254,  250,  258,  262,  256,
			  256,  256,  256,  256,  256,  256,  256,  257,  257,  257,
			  257,  257,  257,  257,  257,  254,  261,  254,  529,  529,
			  529,  254,    0,  259,  530,  530,  530,  254,    0,  258,
			  258,  258,  258,  258,  258,  258,  258,  258,  260,  263,
			  291,  291,  291,  291,  291,  291,  291,  291,  262,  531, yy_Dummy>>,
			1, 200, 2000)
		end

	yy_chk_template_12 (an_array: ARRAY [INTEGER])
			-- Fill chunk #12 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  531,  531,    0,  259,  259,  259,  259,  259,  259,  259,
			  259,  259,  259,  259,  264,    0,  261,    0,  260,  260,
			    0,  260,  260,  260,  260,  260,  260,  260,  260,  262,
			  262,  262,  262,  262,  262,  262,  262,  262,  262,  263,
			  532,  532,  532,  533,  533,  533,  261,  261,  261,  261,
			  261,  261,  261,  261,  261,  261,  261,  534,  534,  534,
			  380,    0,  380,    0,  264,  380,  380,  380,  380,  263,
			  263,  263,  263,  263,  263,  263,  263,  263,  263,  263,
			  283,  283,  283,  283,  283,  283,  283,  283,  283,  283,
			  283,    0,    0,  290,  264,  290,  290,  264,  264,  264,

			  264,  264,  264,  264,  264,  284,  284,    0,  284,  284,
			  284,  284,  284,  284,  284,  284,  285,  285,  285,  285,
			  285,  285,  285,  285,  285,  285,  285,  286,  286,  286,
			  286,  286,  286,  286,  286,  286,  286,  287,  287,  287,
			  287,  287,  287,  287,  287,  287,  287,  287,  288,  290,
			    0,  288,  288,  288,  288,  288,  288,  288,  288,  293,
			  399,  293,  293,  295,    0,  295,  295,  294,  399,    0,
			  294,  703,  294,  434,  424,  294,  297,  434,  407,  297,
			  290,  297,  424,    0,  297,  298,  407,    0,  298,  430,
			  298,    0,  399,  298,  715,  407,  299,  430,    0,  299, yy_Dummy>>,
			1, 200, 2200)
		end

	yy_chk_template_13 (an_array: ARRAY [INTEGER])
			-- Fill chunk #13 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  399,  299,    0,  703,  299,  434,  424,    0,  300,  434,
			  407,  300,  498,  300,  424,  293,  300,  498,  407,  295,
			  301,  430,    0,  301,    0,  301,  715,  407,  301,  430,
			  302,    0,    0,  302,  384,  302,  384,    0,  302,  384,
			  384,  384,  384,    0,  498,    0,  293,    0,    0,  498,
			  295,  293,  293,  293,  293,  293,  293,  293,  293,  294,
			  294,  294,  294,  294,  294,  294,  294,    0,  297,  297,
			  297,  297,  297,  297,  297,  297,  298,  298,  298,  298,
			  298,  298,  298,  298,  298,  299,  299,  299,  299,  299,
			  299,  299,  299,  299,  299,  299,    0,  300,  300,  426,

			  300,  300,  300,  300,  300,  300,  300,  300,  426,  301,
			  301,  301,  301,  301,  301,  301,  301,  301,  301,  301,
			  302,  302,  302,  302,  302,  302,  302,  302,  302,  302,
			  303,  426,    0,  303,    0,  303,    0,    0,  303,    0,
			  426,  304,    0,    0,  304,    0,  304,    0,    0,  304,
			  306,  306,  306,  306,  306,  306,  306,  306,  307,  307,
			  307,  307,  307,  307,  307,  307,  308,  308,  308,  308,
			  308,  308,  308,  308,  309,  309,  309,  309,  309,  309,
			  309,  309,  309,  309,  309,  310,  310,  310,  310,  310,
			  310,  310,  310,  310,  310,  310,  311,  311,  311,  311, yy_Dummy>>,
			1, 200, 2400)
		end

	yy_chk_template_14 (an_array: ARRAY [INTEGER])
			-- Fill chunk #14 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  311,  311,  311,  311,  311,  311,  311,  312,    0,  385,
			  312,  385,  385,  385,  385,  313,    0,    0,  313,  303,
			  303,  303,  303,  303,  303,  303,  303,  303,  303,  303,
			  304,    0,    0,  304,  304,  304,  304,  304,  304,  304,
			  304,  314,  422,    0,  314,  379,  379,  379,  379,  315,
			    0,  385,  315,    0,    0,  422,    0,  316,    0,  379,
			  316,    0,  315,  315,  315,  315,  317,    0,    0,  317,
			  603,  603,  603,  603,  422,  318,    0,    0,  318,  383,
			  383,  383,  383,  465,  441,  379,  319,  422,  441,  319,
			  465,  379,    0,  383,  312,  312,  312,  312,  312,  312,

			  312,  312,  313,  313,  313,  313,  313,  313,  313,  313,
			  320,    0,    0,  320,    0,  465,  441,    0,    0,  383,
			  441,  321,  465,    0,  321,  383,    0,    0,  314,  314,
			  314,  314,  314,  314,  314,  314,  315,  315,  315,  315,
			  315,  315,  315,  315,  316,  316,  316,  316,  316,  316,
			  316,  316,    0,  317,  317,  317,  317,  317,  317,  317,
			  317,  318,  318,  318,  318,  318,  318,  318,  318,  318,
			  319,  319,  319,  319,  319,  319,  319,  319,  319,  319,
			  319,  322,    0,  393,  322,  393,  393,  393,  393,  604,
			  604,  604,  604,  323,  320,  320,  323,  320,  320,  320, yy_Dummy>>,
			1, 200, 2600)
		end

	yy_chk_template_15 (an_array: ARRAY [INTEGER])
			-- Fill chunk #15 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  320,  320,  320,  320,  320,  321,  321,  321,  321,  321,
			  321,  321,  321,  321,  321,  321,  324,  444,  394,  324,
			  394,  394,  394,  394,    0,  393,  452,  444,    0,  604,
			  452,  626,    0,  626,  325,    0,  325,  325,    0,  325,
			    0,    0,  325,  605,  605,  605,  605,    0,    0,  444,
			  614,  614,  614,  326,    0,    0,  326,    0,  452,  444,
			  394,  333,  452,  626,  333,  626,  322,  322,  322,  322,
			  322,  322,  322,  322,  322,  322,    0,  323,  323,  323,
			  323,  323,  323,  323,  323,  323,  323,  323,  325,  327,
			  614,  607,  327,  607,    0,    0,  607,  607,  607,  607,

			  324,    0,  326,  324,  324,  324,  324,  324,  324,  324,
			  324,  328,    0,    0,  328,  608,  608,  608,  608,    0,
			  325,  334,    0,    0,  334,  437,  325,  325,  325,  325,
			  325,  325,  325,  325,  326,    0,  329,  437,  327,  329,
			  326,  326,  326,  326,  326,  326,  326,  326,  333,  333,
			  333,  333,  333,  333,  333,  333,  456,  437,  330,  454,
			  328,  330,    0,  454,  456,  609,  609,  609,  609,  437,
			  327,    0,  331,    0,  709,  331,  327,  327,  327,  327,
			  327,  327,  327,  327,    0,  329,  332,    0,  456,  332,
			  709,  454,  328,    0,  335,  454,  456,  335,  328,  328, yy_Dummy>>,
			1, 200, 2800)
		end

	yy_chk_template_16 (an_array: ARRAY [INTEGER])
			-- Fill chunk #16 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  328,  328,  328,  328,  328,  328,  709,  330,  334,  334,
			  334,  334,  334,  334,  334,  334,  336,  329,    0,  336,
			    0,  331,  709,  329,  329,  329,  329,  329,  329,  329,
			  329,  337,    0,    0,  337,  332,  632,  632,  632,  330,
			    0,    0,  330,  330,  330,  330,  330,  330,  330,  330,
			  330,  330,  330,  331,  340,    0,  331,  331,  331,  331,
			  331,  331,  331,  331,  331,  331,  331,  332,  342,    0,
			  332,  332,  332,  332,  332,  332,  332,  332,  332,  332,
			  332,  335,  335,  335,  335,  335,  335,  335,  335,  338,
			    0,    0,  338,    0,    0,  462,    0,  468,    0,  462,

			  719,  468,  343,  336,  336,  336,  336,  336,  336,  336,
			  336,  339,    0,    0,  339,  337,  337,  337,  337,  337,
			  337,  337,  337,  337,  337,  337,  344,  462,  464,  468,
			  474,  462,  719,  468,  474,  721,  464,  340,  340,  340,
			  340,  340,  340,  340,  340,  345,  633,  633,  633,    0,
			    0,  342,  342,  342,  342,  342,  342,  342,  342,  346,
			  464,    0,  474,  634,  634,  634,  474,  721,  464,  347,
			  738,  738,  738,  338,  338,  338,  338,  338,  338,  338,
			  338,  338,  338,  338,  343,  343,  343,  343,  343,  343,
			  343,  343,  343,  348,    0,  339,  339,  339,  339,  339, yy_Dummy>>,
			1, 200, 3000)
		end

	yy_chk_template_17 (an_array: ARRAY [INTEGER])
			-- Fill chunk #17 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  339,  339,  339,  339,  339,  339,  344,  344,  344,  344,
			  344,  344,  344,  344,  344,  344,  344,  349,  739,  739,
			  739,  610,  610,  610,  610,  345,  345,  350,  345,  345,
			  345,  345,  345,  345,  345,  345,  351,    0,    0,  346,
			  346,  346,  346,  346,  346,  346,  346,  346,  346,  346,
			  347,  347,  347,  347,  347,  347,  347,  347,  347,  347,
			  353,  610,  740,  740,  740,    0,  731,  611,  354,  611,
			  611,  611,  611,  348,  348,  348,  348,  348,  348,  348,
			  348,  348,  348,  348,  355,  761,  761,  761,  761,    0,
			    0,    0,  356,  355,  355,  355,  355,  349,  731,  733,

			  349,  349,  349,  349,  349,  349,  349,  349,  357,  611,
			  350,  350,  350,  350,  350,  350,  350,  350,  358,  351,
			  351,  351,  351,  351,  351,  351,  351,  359,  470,  478,
			  635,  733,  635,  478,  470,  360,  762,  762,  762,  762,
			    0,    0,    0,  353,  353,  353,  353,  353,  353,  353,
			  353,  354,  354,  354,  354,  354,  354,  354,  354,  361,
			  470,  478,  635,    0,  635,  478,  470,  355,  355,  355,
			  355,  355,  355,  355,  355,  356,  356,  356,  356,  356,
			  356,  356,  356,  362,  764,  764,  764,  764,    0,    0,
			    0,  357,  357,  357,  357,  357,  357,  357,  357,  363, yy_Dummy>>,
			1, 200, 3200)
		end

	yy_chk_template_18 (an_array: ARRAY [INTEGER])
			-- Fill chunk #18 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			    0,  358,  358,  358,  358,  358,  358,  358,  358,  364,
			  359,  359,  359,  359,  359,  359,  359,  359,  360,  360,
			  360,  360,  360,  360,  360,  360,  365,  476,  479,  645,
			  476,  645,  479,  476,  366,  618,    0,  618,  618,  618,
			  618,    0,  361,  361,  361,  361,  361,  361,  361,  361,
			  367,  760,  760,  760,  760,    0,    0,    0,  368,  476,
			  479,  645,  476,  645,  479,  476,  362,  362,  362,  362,
			  362,  362,  362,  362,  369,    0,    0,  618,  766,  766,
			  766,  766,  363,  363,  363,  363,  363,  363,  363,  363,
			  370,  760,  364,  364,  364,  364,  364,  364,  364,  364,

			  371,  550,  550,  550,  550,  550,  550,  550,  550,  365,
			  365,  365,  365,  365,  365,  365,  365,  366,  366,  366,
			  366,  366,  366,  366,  366,  372,    0,  619,    0,  619,
			  619,  619,  619,  367,  367,  367,  367,  367,  367,  367,
			  367,  368,  368,  368,  368,  368,  368,  368,  368,  373,
			  773,    0,    0,  602,  602,  602,  602,  369,  369,  369,
			  369,  369,  369,  369,  369,  374,  490,  602,  494,  619,
			  490,    0,  494,  370,  370,  370,  370,  370,  370,  370,
			  370,  375,  773,  371,  371,  371,  371,  371,  371,  371,
			  371,  500,  376,  602,  775,  500,    0,    0,  490,  602, yy_Dummy>>,
			1, 200, 3400)
		end

	yy_chk_template_19 (an_array: ARRAY [INTEGER])
			-- Fill chunk #19 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  494,    0,  490,  377,  494,  372,  372,  372,  372,  372,
			  372,  372,  372,  372,  372,  372,  378,  765,  765,  765,
			  765,    0,    0,  500,  502,    0,  775,  500,  502,  373,
			  373,  373,  373,  373,  373,  373,  373,  373,  373,  373,
			  768,  768,  768,  768,    0,  374,  374,  374,  374,  374,
			  374,  374,  374,  374,  374,  374,  502,  765,    0,    0,
			  502,  375,  375,  375,  375,  375,  375,  375,  375,  375,
			  375,  375,  376,  376,  376,  376,  376,  376,  376,  376,
			  376,  376,  376,  377,  377,  377,  377,  377,  377,  377,
			  377,  377,  377,  377,    0,    0,  378,  378,  378,  378,

			  378,  378,  378,  378,  378,  378,  378,  391,  391,  391,
			  391,  396,    0,  396,  396,    0,  401,  391,  391,  391,
			  391,  391,  391,  396,  398,  480,  398,  401,  402,  401,
			  402,  783,  404,  480,  404,    0,  398,  510,    0,  401,
			  402,    0,  510,  396,  404,  396,  396,  391,  401,  391,
			  391,  391,  391,  391,  391,  396,  398,  480,  398,  401,
			  402,  401,  402,  783,  404,  480,  404,  408,  398,  510,
			  406,  401,  402,  406,  510,  406,  404,  417,  408,  417,
			  408,  512,  419,  483,  408,  406,  512,    0,    0,  417,
			  408,  419,  483,  419,  421,    0,  421,    0,    0,  408, yy_Dummy>>,
			1, 200, 3600)
		end

	yy_chk_template_20 (an_array: ARRAY [INTEGER])
			-- Fill chunk #20 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			    0,  421,  406,  419,    0,  406,  421,  406,    0,  417,
			  408,  417,  408,  512,  419,  483,  408,  406,  512,  425,
			  622,  417,  408,  419,  483,  419,  421,  423,  421,  423,
			  425,  622,  425,  421,  427,  419,  427,  423,  421,  423,
			  427,  431,  425,  431,  481,    0,  427,  433,  432,    0,
			  431,  425,  622,  431,    0,  432,  481,  432,  433,  423,
			  433,  423,  425,  622,  425,    0,  427,  432,  427,  423,
			  433,  423,  427,  431,  425,  431,  481,  435,  427,  433,
			  432,  438,  431,  438,  435,  431,  435,  432,  481,  432,
			  433,  785,  433,  438,    0,  439,  435,  439,  440,  432,

			  620,    0,  433,    0,  439,    0,  440,  439,  442,  435,
			  620,    0,  440,  438,  793,  438,  435,    0,  435,  442,
			  448,  442,  442,  785,  448,  438,  443,  439,  435,  439,
			  440,  442,  620,  443,  647,  443,  439,  448,  440,  439,
			  442,    0,  620,  647,  440,  443,  793,  451,  445,  451,
			  445,  442,  448,  442,  442,  445,  448,    0,  443,  451,
			  445,    0,  447,  442,  447,  443,  647,  443,  809,  448,
			  447,  449,  449,  449,  447,  647,    0,  443,    0,  451,
			  445,  451,  445,  449,    0,  449,    0,  445,  457,  624,
			    0,  451,  445,  491,  447,  457,  447,  457,  817,  624, yy_Dummy>>,
			1, 200, 3800)
		end

	yy_chk_template_21 (an_array: ARRAY [INTEGER])
			-- Fill chunk #21 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  809,  491,  447,  449,  449,  449,  447,  457,  458,  459,
			  460,  458,  460,  458,  460,  449,  459,  449,  459,    0,
			  457,  624,  460,  458,  461,  491,    0,  457,  459,  457,
			  817,  624,    0,  491,    0,  461,    0,  461,    0,  457,
			  458,  459,  460,  458,  460,  458,  460,  461,  459,  503,
			  459,  466,  463,    0,  460,  458,  461,  503,  655,  463,
			  459,  463,  466,  655,  466,    0,  467,  461,  467,  461,
			  467,  463,    0,  469,  466,    0,  819,    0,  467,  461,
			  469,  503,  469,  466,  463,  471,    0,  471,  471,  503,
			  655,  463,  469,  463,  466,  655,  466,  471,  467,  473,

			  467,  473,  467,  463,  477,  469,  466,  477,  819,  475,
			  467,  473,  469,  477,  469,  477,  475,  471,  475,  471,
			  471,    0,    0,    0,  469,  477,  482,  683,  475,  471,
			  683,  473,  482,  473,  628,    0,  477,    0,    0,  477,
			  628,  475,  484,  473,  482,  477,  485,  477,  475,  484,
			  475,  484,    0,  485,  653,  485,  486,  477,  482,  683,
			  475,  484,  683,  653,  482,  485,  628,  486,  487,  486,
			  487,  639,  628,  488,  484,  639,  482,  487,  485,  486,
			  487,  484,  488,  484,  488,  485,  653,  485,  486,  492,
			    0,  488,  821,  484,  488,  653,  492,  485,  492,  486, yy_Dummy>>,
			1, 200, 4000)
		end

	yy_chk_template_22 (an_array: ARRAY [INTEGER])
			-- Fill chunk #22 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  487,  486,  487,  639,    0,  488,  643,  639,  492,  487,
			  643,  486,  487,  489,  488,  489,  488,  497,  493,  489,
			  497,  492,  497,  488,  821,  489,  488,  495,  492,  493,
			  492,  493,  497,    0,  495,    0,  495,    0,  643,    0,
			  492,  493,  643,    0,  825,  489,  495,  489,  637,  497,
			  493,  489,  497,  499,  497,  499,    0,  489,  637,  495,
			  501,  493,  656,  493,  497,  499,  495,  501,  495,  501,
			  506,  656,  506,  493,  505,  506,  825,  641,  495,  501,
			  637,  505,  506,  505,    0,  499,    0,  499,  641,    0,
			  637,    0,  501,  505,  656,  507,  518,  499,  507,  501,

			  507,  501,  506,  656,  506,  519,  505,  506,  661,  641,
			  507,  501,  661,  505,  506,  505,  509,    0,  511,  509,
			  641,  509,  513,  520,  513,  505,  511,  507,  511,  827,
			  507,  509,  507,  515,  513,  515,    0,  521,  511,  666,
			  661,    0,  507,  666,  661,  515,  518,    0,  509,  522,
			  511,  509,    0,  509,  513,  519,  513,    0,  511,    0,
			  511,  827,    0,  509,  523,  515,  513,  515,  677,  835,
			  511,  666,  677,  520,    0,  666,    0,  515,  524,  518,
			  518,  518,  518,  518,  518,  518,  518,  521,  519,  519,
			  519,  519,  519,  519,  519,  519,  535,    0,    0,  522, yy_Dummy>>,
			1, 200, 4200)
		end

	yy_chk_template_23 (an_array: ARRAY [INTEGER])
			-- Fill chunk #23 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  677,  835,    0,    0,  677,  536,  520,  520,  520,  520,
			  520,  520,  520,  520,  523,    0,  537,    0,    0,    0,
			  521,  521,  521,  521,  521,  521,  521,  521,  524,  522,
			  522,  522,  522,  522,  522,  522,  522,  522,  522,  522,
			  538,    0,    0,    0,  523,  523,  523,  523,  523,  523,
			  523,  523,  523,  523,  523,  539,    0,    0,  524,  524,
			  524,  524,  524,  524,  524,  524,  524,  524,  524,  540,
			  551,  551,  551,  551,  551,  551,  551,  551,    0,    0,
			  541,  847,    0,  535,  535,  535,  535,  535,  535,  535,
			  535,  536,  536,  536,  536,  536,  536,  536,  536,  536,

			  537,  537,  537,  537,  537,  537,  537,  537,  537,  537,
			  537,  542,    0,  847,  543,    0,    0,  543,  689,  543,
			  853,  689,  543,    0,  538,  538,    0,  538,  538,  538,
			  538,  538,  538,  538,  538,  870,  870,  870,  870,  539,
			  539,  539,  539,  539,  539,  539,  539,  539,  539,  539,
			  689,    0,  853,  689,  540,  540,  540,  540,  540,  540,
			  540,  540,  540,  540,  541,  541,  541,  541,  541,  541,
			  541,  541,  541,  541,  541,  544,    0,    0,  544,    0,
			  544,    0,    0,  544,  545,    0,  855,  545,  649,  545,
			    0,  711,  545,    0,  649,  542,    0,  711,  542,  542, yy_Dummy>>,
			1, 200, 4400)
		end

	yy_chk_template_24 (an_array: ARRAY [INTEGER])
			-- Fill chunk #24 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  542,  542,  542,  542,  542,  542,  543,  543,  543,  543,
			  543,  543,  543,  543,  546,  570,  859,  546,  855,  546,
			  649,    0,  546,  711,    0,  547,  649,    0,  547,  711,
			  547,    0,    0,  547,  659,    0,  548,    0,    0,  548,
			    0,  548,    0,  659,  548,    0,    0,  549,  859,    0,
			  549,    0,  549,  663,  771,  549,  552,  552,  552,  552,
			  552,  552,  552,  552,  771,  663,  659,  544,  544,  544,
			  544,  544,  544,  544,  544,  659,  545,  545,  545,  545,
			  545,  545,  545,  545,  553,  663,  771,  553,  874,  874,
			  874,  874,  554,    0,    0,  554,  771,  663,  570,  570,

			  570,  570,  570,  570,  570,  570,  546,  546,  546,  546,
			  546,  546,  546,  546,  547,  547,  547,  547,  547,  547,
			  547,  547,  547,  547,  547,  548,  548,  548,  548,  548,
			  548,  548,  548,  548,  548,  548,  549,  549,  549,  549,
			  549,  549,  549,  549,  549,  549,  549,  555,    0,    0,
			  555,  875,  875,  875,  875,  557,    0,  675,  557,  555,
			  555,  555,  555,  555,  556,  697,  675,  556,  697,    0,
			  880,  553,  553,  553,  553,  553,  553,  553,  553,  554,
			  554,  554,  554,  554,  554,  554,  554,  729,  558,  675,
			  556,  558,  679,  882,    0,  729,  559,  697,  675,  559, yy_Dummy>>,
			1, 200, 4600)
		end

	yy_chk_template_25 (an_array: ARRAY [INTEGER])
			-- Fill chunk #25 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  697,  679,  880,    0,  560,    0,    0,  560,    0,    0,
			  767,  767,  767,  767,    0,  561,    0,    0,  561,  729,
			  877,  877,  877,  877,  679,  882,  562,  729,  701,  562,
			    0,    0,  701,  679,  555,  555,  555,  555,  555,  555,
			  555,  555,  557,  557,  557,  557,  557,  557,  557,  557,
			  767,  556,  556,  556,  556,  556,  556,  556,  556,  563,
			  701,  868,  563,  868,  701,    0,  868,  868,  868,  868,
			    0,  567,    0,    0,  567,  558,  558,  558,  558,  558,
			  558,  558,  558,  559,  559,  559,  559,  559,  559,  559,
			  559,  560,  560,  560,  560,  560,  560,  560,  560,  561,

			  561,  561,  561,  561,  561,  561,  561,  561,  561,  561,
			  562,  562,  562,  562,  562,  562,  562,  562,  562,  562,
			  562,  564,    0,  890,  564,    0,    0,  606,  606,  606,
			  606,  952,  952,  952,  952,  565,    0,    0,  565,  779,
			  779,  606,    0,  563,  563,  563,  563,  563,  563,  563,
			  563,  563,  563,  563,  566,  890,  693,  566,  567,  567,
			  567,  567,  567,  567,  567,  567,  568,  606,  693,  568,
			  564,  779,  779,  606,  569,    0,    0,  569,  953,  953,
			  953,  953,    0,    0,  565,    0,  571,  657,  693,  657,
			  878,    0,  878,    0,  572,  878,  878,  878,  878,  657, yy_Dummy>>,
			1, 200, 4800)
		end

	yy_chk_template_26 (an_array: ARRAY [INTEGER])
			-- Fill chunk #26 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  693,  823,  564,  566,  573,  671,  705,  823,  564,  564,
			  564,  564,  564,  564,  564,  564,  565,  574,  705,  657,
			  671,  657,  565,  565,  565,  565,  565,  565,  565,  565,
			  575,  657,    0,  823,    0,  566,    0,  671,  705,  823,
			    0,  566,  566,  566,  566,  566,  566,  566,  566,  576,
			  705,    0,  671,  568,  568,  568,  568,  568,  568,  568,
			  568,  569,  569,  569,  569,  569,  569,  569,  569,  571,
			  571,  571,  571,  571,  571,  571,  571,  572,  572,  572,
			  572,  572,  572,  572,  572,  599,    0,  573,  573,  573,
			  573,  573,  573,  573,  573,  900,  600,  574,  574,  574,

			  574,  574,  574,  574,  574,  574,  574,  574,  601,  673,
			  575,  575,  575,  575,  575,  575,  575,  575,  575,  575,
			  575,  717,  706,  723,  673,  706,  723,  900,  717,  576,
			  576,  576,  576,  576,  576,  576,  576,  576,  576,  576,
			  582,  673,  954,  954,  954,  954,    0,    0,  582,  582,
			  582,  582,  582,  717,  706,  723,  673,  706,  723,    0,
			  717,  958,  958,  958,  958,  599,  599,  599,  599,  599,
			  599,  599,  599,  599,  599,  599,  600,  600,  600,  600,
			  600,  600,  600,  600,  600,  600,  600,    0,  601,  601,
			  601,  601,  601,  601,  601,  601,  601,  601,  601,  621, yy_Dummy>>,
			1, 200, 5000)
		end

	yy_chk_template_27 (an_array: ARRAY [INTEGER])
			-- Fill chunk #27 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  623,  621,  623,  625,  902,  625,  621,  725,  623,    0,
			  625,  621,  623,    0,    0,  625,    0,  727,    0,  725,
			  727,    0,    0,  582,  582,  582,  582,  582,  582,  582,
			  582,  621,  623,  621,  623,  625,  902,  625,  621,  725,
			  623,  627,  625,  621,  623,  630,  627,  625,  627,  727,
			  631,  725,  727,  631,  630,  631,  630,  781,  627,  636,
			  636,    0,  636,  906,  781,  631,  630,  638,    0,  638,
			    0,    0,  636,  627,  638,    0,    0,  630,  627,  638,
			  627,    0,  631,    0,    0,  631,  630,  631,  630,  781,
			  627,  636,  636,  640,  636,  906,  781,  631,  630,  638,

			  640,  638,  640,  646,  636,  642,  638,  642,  646,  644,
			  646,  638,  640,  642,  777,  650,  644,  642,  644,  777,
			  646,  648,  699,  648,  650,  640,  650,  648,  644,    0,
			    0,  699,  640,  648,  640,  646,  650,  642,  912,  642,
			  646,  644,  646,    0,  640,  642,  777,  650,  644,  642,
			  644,  777,  646,  648,  699,  648,  650,  928,  650,  648,
			  644,  652,  713,  699,  652,  648,  652,  654,  650,  654,
			  912,  713,  658,  654,  658,  660,  652,  660,  658,  654,
			  791,  660,    0,  662,  658,  791,    0,  660,    0,  928,
			  662,    0,  662,  652,  713,    0,  652,    0,  652,  654, yy_Dummy>>,
			1, 200, 5200)
		end

	yy_chk_template_28 (an_array: ARRAY [INTEGER])
			-- Fill chunk #28 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  934,  654,  662,  713,  658,  654,  658,  660,  652,  660,
			  658,  654,  791,  660,  805,  662,  658,  791,  664,  660,
			  664,  667,  662,  667,  662,  805,  670,  664,  668,  670,
			  664,  670,  934,  667,  662,  668,  672,  668,  672,  797,
			  797,  670,  674,    0,  674,    0,  805,  668,  672,    0,
			  664,    0,  664,  667,  674,  667,    0,  805,  670,  664,
			  668,  670,  664,  670,    0,  667,    0,  668,  672,  668,
			  672,  797,  797,  670,  674,  676,  674,  676,  938,  668,
			  672,  676,  678,  682,    0,  682,  674,  676,  680,  678,
			  680,  678,  871,  787,  680,  682,  684,    0,  684,    0,

			  680,  678,  787,    0,  686,    0,  686,  676,  684,  676,
			  938,    0,    0,  676,  678,  682,  686,  682,  871,  676,
			  680,  678,  680,  678,  871,  787,  680,  682,  684,  688,
			  684,  688,  680,  678,  787,  690,  686,  690,  686,    0,
			  684,  688,  692,  695,  692,  695,    0,  690,  686,    0,
			    0,    0,  695,  696,  692,  695,  696,    0,  696,    0,
			    0,  688,  795,  688,  698,    0,    0,  690,  696,  690,
			  698,  795,  698,  688,  692,  695,  692,  695,  704,  690,
			  886,  704,  698,  704,  695,  696,  692,  695,  696,  700,
			  696,  700,  886,  704,  795,  700,  698,  702,  702,  702, yy_Dummy>>,
			1, 200, 5400)
		end

	yy_chk_template_29 (an_array: ARRAY [INTEGER])
			-- Fill chunk #29 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  696,  700,  698,  795,  698,  708,    0,  708,    0,  702,
			  704,    0,  886,  704,  698,  704,  891,  708,    0,    0,
			    0,  700,  891,  700,  886,  704,  707,  700,  707,  702,
			  702,  702,  710,  700,  710,  707,  789,  708,  707,  708,
			  789,  702,  712,  801,  710,  710,    0,  801,  891,  708,
			  714,  712,  714,  712,  891,  940,  714,  716,  707,  716,
			  707,  942,  714,  712,  710,    0,  710,  707,  789,  716,
			  707,  833,  789,    0,  712,  801,  710,  710,  720,  801,
			  720,    0,  714,  712,  714,  712,  833,  940,  714,  716,
			  720,  716,    0,  942,  714,  712,  718,  722,  718,  722,

			  718,  716,  728,  833,  728,  724,    0,    0,  718,  722,
			  720,  724,  720,  724,  728,  726,  735,  726,  833,    0,
			    0,    0,  720,  724,  726,  736,    0,  726,  718,  722,
			  718,  722,  718,    0,  728,    0,  728,  724,  737,  730,
			  718,  722,  732,  724,  732,  724,  728,  726,  741,  726,
			  730,  734,  730,  734,  732,  724,  726,  742,  799,  726,
			  815,  799,  730,  734,  815,  743,  735,  869,  869,  869,
			  869,  730,    0,  744,  732,  736,  732,  873,  873,  873,
			  873,    0,  730,  734,  730,  734,  732,  745,  737,    0,
			  799,    0,  815,  799,  730,  734,  815,    0,  746,  735, yy_Dummy>>,
			1, 200, 5600)
		end

	yy_chk_template_30 (an_array: ARRAY [INTEGER])
			-- Fill chunk #30 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  735,  735,  735,  735,  735,  735,  735,  869,  736,  736,
			  736,  736,  736,  736,  736,  736,  747,  873,    0,    0,
			    0,  737,  737,  737,  737,  737,  737,  737,  737,  876,
			  876,  876,  876,    0,    0,  741,  741,  741,  741,  741,
			  741,  741,  741,    0,  742,  742,  742,  742,  742,  742,
			  742,  742,  743,  743,  743,  743,  743,  743,  743,  743,
			  744,  744,  744,  744,  744,  744,  744,  744,    0,  876,
			    0,  745,  745,  745,  745,  745,  745,  745,  745,  745,
			  745,  745,  746,  746,  746,  746,  746,  746,  746,  746,
			  746,  746,  746,  752,  829,  948,  752,    0,  829,    0,

			  747,  747,  747,  747,  747,  747,  747,  747,  747,  747,
			  747,  748,  755,    0,  748,    0,  748,    0,    0,  748,
			  749,    0,    0,  749,    0,  749,  829,  948,  749,  750,
			  829,  774,  750,  774,  750,  811,  770,  750,  770,  770,
			  770,  770,  751,  774,  811,  751,  759,  759,  759,  759,
			  753,    0,    0,  753,  751,  751,  751,  751,  751,  754,
			  759,  970,  754,  774,    0,  774,    0,  811,    0,    0,
			    0,  756,    0,    0,    0,  774,  811,    0,  770,  757,
			  752,  752,  752,  752,  752,  752,  752,  752,  758,    0,
			    0,    0,  759,  970,    0,  755,  755,  755,  755,  755, yy_Dummy>>,
			1, 200, 5800)
		end

	yy_chk_template_31 (an_array: ARRAY [INTEGER])
			-- Fill chunk #31 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  755,  755,  755,  748,  748,  748,  748,  748,  748,  748,
			  748,    0,  749,  749,  749,  749,  749,  749,  749,  749,
			    0,  750,  750,  750,  750,  750,  750,  750,  750,  751,
			  751,  751,  751,  751,  751,  751,  751,  753,  753,  753,
			  753,  753,  753,  753,  753,    0,  754,  754,  754,  754,
			  754,  754,  754,  754,  756,  756,  756,  756,  756,  756,
			  756,  756,  757,  757,  757,  757,  757,  757,  757,  757,
			    0,  758,  758,  758,  758,  758,  758,  758,  758,  763,
			  763,  763,  763,  769,  769,  769,  769,    0,  772,  776,
			  772,  776,  778,  763,  778,  772,  782,  769,  837,  780,

			  772,  776,  837,  780,  778,  780,  782,    0,  782,  960,
			  960,  960,  960,    0,    0,  780,    0,    0,  782,  763,
			  772,  776,  772,  776,  778,  763,  778,  772,  782,  769,
			  837,  780,  772,  776,  837,  780,  778,  780,  782,  784,
			  782,  784,  786,  788,  786,  788,  792,  780,  792,  788,
			  782,  784,  839,  790,  786,  788,  839,  790,  792,    0,
			  790,    0,  790,  961,  961,  961,  961,  794,    0,  794,
			    0,  784,  790,  784,  786,  788,  786,  788,  792,  794,
			  792,  788,    0,  784,  839,  790,  786,  788,  839,  790,
			  792,  796,  790,  796,  790,  845,  798,  796,  802,  794, yy_Dummy>>,
			1, 200, 6000)
		end

	yy_chk_template_32 (an_array: ARRAY [INTEGER])
			-- Fill chunk #32 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  798,  794,  798,  796,  790,  802,  845,  802,  800,    0,
			  803,  794,  798,  807,  800,  803,  800,  802,  807,  813,
			    0,    0,    0,  796,  813,  796,  800,  845,  798,  796,
			  802,  974,  798,  804,  798,  796,    0,  802,  845,  802,
			  800,  804,  803,  804,  798,  807,  800,  803,  800,  802,
			  807,  813,  806,  804,  806,  808,  813,  808,  800,  810,
			  806,  810,  959,  974,  806,  804,  812,  808,  812,  978,
			    0,  810,  812,  804,  831,  804,  978,    0,  812,  962,
			  962,  962,  962,  831,  806,  804,  806,  808,  959,  808,
			    0,  810,  806,  810,  959,  814,  806,  814,  812,  808,

			  812,  978,  816,  810,  812,    0,  831,  814,  978,  816,
			  812,  816,  820,  818,  820,  831,  818,  822,  818,  843,
			  822,  816,  822,  843,  820,  984,  824,  814,  818,  814,
			    0,    0,  822,    0,  816,  824,    0,  824,  986,  814,
			    0,  816,    0,  816,  820,  818,  820,  824,  818,  822,
			  818,  843,  822,  816,  822,  843,  820,  984,  824,  828,
			  818,  828,  849,  826,  822,  830,  826,  824,  826,  824,
			  986,  828,  830,  849,  830,  832,    0,  832,  826,  824,
			  834,  832,  834,    0,  830,    0,  857,  832,    0,    0,
			  857,  828,  834,  828,  849,  826,  836,  830,  826,  836, yy_Dummy>>,
			1, 200, 6200)
		end

	yy_chk_template_33 (an_array: ARRAY [INTEGER])
			-- Fill chunk #33 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  826,  836,  990,  828,  830,  849,  830,  832,  838,  832,
			  826,  836,  834,  832,  834,  838,  830,  838,  857,  832,
			  841,  884,  857,  840,  834,  884,    0,  838,  836,  841,
			  840,  836,  840,  836,  990,  992, 1004,  844,    0,  842,
			  838,  842,  840,  836,  844,  842,  844,  838,    0,  838,
			  896,  842,  841,  884,  896,  840,  844,  884,  846,  838,
			  846,  841,  840,  848,  840,  848,  846,  992, 1004,  844,
			  846,  842,  851,  842,  840,  848,  844,  842,  844,  850,
			  851,  850,  896,  842,    0,    0,  896,  850,  844,    0,
			  846,  850,  846,    0,    0,  848,    0,  848,  846,  863,

			    0,    0,  846,  852,  851,    0,  854,  848,  854,  864,
			  861,  850,  851,  850,  852,  861,  852,  856,  854,  850,
			  856,  865,  856,  850,  858,  860,  852,  860,  898, 1010,
			 1023,  858,  856,  858,  888,  852,  898,  860,  854,  862,
			  854,  862,  861,  858, 1027,  888,  852,  861,  852,  856,
			  854,  862,  856, 1029,  856,    0,  858,  860,  852,  860,
			  898, 1010, 1023,  858,  856,  858,  888,  866,  898,  860,
			  866,  862,    0,  862,    0,  858, 1027,  888,    0,  866,
			    0,    0,    0,  862,  894, 1029,  863,  863,  863,  863,
			  863,  863,  863,  863,    0,  894,  864,  864,  864,  864, yy_Dummy>>,
			1, 200, 6400)
		end

	yy_chk_template_34 (an_array: ARRAY [INTEGER])
			-- Fill chunk #34 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  864,  864,  864,  864,  872,  872,  872,  872,  865,  865,
			  865,  865,  865,  865,  865,  865,  894,    0,  872,  879,
			  879,  879,  879, 1013, 1013, 1013, 1013,  894,    0,    0,
			  881,    0,  881,  879,  883,  908,  883,  889,    0,  889,
			    0, 1033,  881,  908,  885,  889,  883,    0, 1035,  889,
			  872,  885,    0,  885,  866,  866,  866,  866,  866,  866,
			  866,  866,  881,  885,  881,  879,  883,  908,  883,  889,
			  887,  889,  887, 1033,  881,  908,  885,  889,  883,  887,
			 1035,  889,  887,  885,  892,  885,  892,  893,  904,  893,
			  893,    0,  904,  910,  897,  885,  892,  910,  895,  893,

			  895,  897,  887,  897,  887,  901,  895,  901,  936,    0,
			  895,  887,  936,  897,  887,    0,  892,  901,  892,  893,
			  904,  893,  893,  899,  904,  910,  897,    0,  892,  910,
			  895,  893,  895,  897,  899,  897,  899,  901,  895,  901,
			  936,  903,  895,  903,  936,  897,  899,  909,  922,  901,
			  905,    0,  907,  903,  907,  899,  922,  905,  909,  905,
			  909,    0,  914, 1037,  907,  913,  899,  913,  899,  905,
			  909,  916,  914,  903,  911,  903,  916,  913,  899,  909,
			  922,  911,  905,  911,  907,  903,  907,    0,  922,  905,
			  909,  905,  909,  911,  914, 1037,  907,  913,  915,  913, yy_Dummy>>,
			1, 200, 6600)
		end

	yy_chk_template_35 (an_array: ARRAY [INTEGER])
			-- Fill chunk #35 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  915,  905,  909,  916,  914,  915,  911,  918,  916,  913,
			  915,  920,  917,  911,  917,  911, 1041,  982,  918,  919,
			  982,  919,  920, 1045,  917,  911,  921,  919,  921,    0,
			  915,  919,  915,  925,  921,  925,  924,  915,  921,  918,
			    0,  925,  915,  920,  917,  925,  917,  924, 1041,  982,
			  918,  919,  982,  919,  920, 1045,  917,  930,  921,  919,
			  921,  923,  930,  919,  932,  925,  921,  925,  924,  932,
			  921,  926,  923,  925,  923,  944,  927,  925,  927,  924,
			  929,  926,  929,  927,  923,  931,  944,  931,  927,  930,
			    0,    0,  929,  923,  930,    0,  932,  931,    0, 1049,

			    0,  932,    0,  926,  923,    0,  923,  944,  927,  933,
			  927,  933,  929,  926,  929,  927,  923,  931,  944,  931,
			  927,  933,  950,  935,  929,  935,  939,  937,  939,  931,
			  941, 1049,  941,  950,  937,  935,  937,  943,  939,  943,
			  996,  933,  941,  933,  996,    0,  937,  946,    0,  943,
			    0,    0,  946,  933,  950,  935,    0,  935,  939,  937,
			  939,  947,  941,  947,  941,  950,  937,  935,  937,  943,
			  939,  943,  996,  947,  941,  945,  996,  945,  937,  946,
			  949,  943,  949,  945,  946,  966,  951,  945,  951, 1051,
			  966,  972,  949,  947,  951,  947,  972,    0,  951,  957, yy_Dummy>>,
			1, 200, 6800)
		end

	yy_chk_template_36 (an_array: ARRAY [INTEGER])
			-- Fill chunk #36 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  957,  957,  957,    0,    0,  947,    0,  945, 1058,  945,
			    0,    0,  949,    0,  949,  945,    0,  966,  951,  945,
			  951, 1051,  966,  972,  949,    0,  951,  955,  972,  955,
			  951,    0,  955,  955,  955,  955,  956,    0,  956,  957,
			 1058,  956,  956,  956,  956,  964,  964,  964,  964,  965,
			  967,  965,  968,    0,  965,  965,  965,  965,  967,  964,
			  967, 1062,    0,  968,  969,  971,  969,  971, 1064,  973,
			  967,  973,  969,    0,  976,    0,  969,  971,    0,  976,
			    0,  973,  967,    0,  968,  964,    0,    0,    0,  980,
			  967,  964,  967, 1062,  980,  968,  969,  971,  969,  971,

			 1064,  973,  967,  973,  969,  975,  976,  975,  969,  971,
			  977,  976,  979,  973,  994,  981,    0,  975,  977,  994,
			  977,  980,  979,  981,  979,  981,  980,  998, 1000,  983,
			  977,  983, 1000,  998,  979,  981,  985,  975,  985,  975,
			    0,  983,  977,  988,  979,  988,  994,  981,  985,  975,
			  977,  994,  977,    0,  979,  981,  979,  981,    0,  998,
			 1000,  983,  977,  983, 1000,  998,  979,  981,  985,  987,
			  985,  987,  991,  983,  991,  988, 1002,  988,  989, 1039,
			  985,  987, 1002,  989,  991,  989,  993,  995,  993,  995,
			 1039, 1066, 1069,  997,    0,  989,    0,    0,  993,  995, yy_Dummy>>,
			1, 200, 7000)
		end

	yy_chk_template_37 (an_array: ARRAY [INTEGER])
			-- Fill chunk #37 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  997,  987,  997,  987,  991,    0,  991,    0, 1002,    0,
			  989, 1039,  997,  987, 1002,  989,  991,  989,  993,  995,
			  993,  995, 1039, 1066, 1069,  997,  999,  989,  999,  999,
			  993,  995,  997, 1001,  997,    0, 1003, 1005,  999, 1005,
			 1001,    0, 1001,    0,  997, 1003, 1006, 1003,    0, 1005,
			 1006, 1008, 1001,    0, 1043, 1008,    0, 1003,  999,    0,
			  999,  999,    0, 1043,    0, 1001, 1007,    0, 1003, 1005,
			  999, 1005, 1001, 1007, 1001, 1007,    0, 1003, 1006, 1003,
			    0, 1005, 1006, 1008, 1001, 1007, 1043, 1008,    0, 1003,
			 1009, 1011, 1025, 1011,    0, 1043, 1025, 1009, 1007, 1009,

			    0,    0,    0, 1011,    0, 1007,    0, 1007,    0, 1009,
			 1014, 1014, 1014, 1014,    0,    0,    0, 1007, 1015, 1015,
			 1015, 1015, 1009, 1011, 1025, 1011,    0,    0, 1025, 1009,
			    0, 1009,    0,    0,    0, 1011, 1016, 1016, 1016, 1016,
			    0, 1009, 1017, 1017, 1017, 1017, 1018,    0, 1018,    0,
			 1014, 1018, 1018, 1018, 1018, 1020, 1020, 1020, 1020, 1021,
			 1021, 1021, 1021, 1022, 1022, 1022, 1022, 1026, 1024, 1020,
			 1024,    0,    0, 1028, 1026, 1028, 1026, 1030, 1031, 1030,
			 1024, 1031, 1032, 1047, 1032, 1028, 1026, 1047,    0, 1030,
			 1055, 1055, 1055, 1055, 1032, 1020,    0,    0,    0, 1026, yy_Dummy>>,
			1, 200, 7200)
		end

	yy_chk_template_38 (an_array: ARRAY [INTEGER])
			-- Fill chunk #38 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			 1024, 1020, 1024, 1022,    0, 1028, 1026, 1028, 1026, 1030,
			 1031, 1030, 1024, 1031, 1032, 1047, 1032, 1028, 1026, 1047,
			 1034, 1030, 1034, 1036,    0, 1036, 1032, 1038, 1040, 1038,
			 1040, 1042, 1034, 1042, 1060, 1036, 1040,    0, 1060, 1038,
			 1040,    0,    0, 1042, 1044,    0, 1044,    0,    0,    0,
			 1044,    0, 1034,    0, 1034, 1036, 1044, 1036,    0, 1038,
			 1040, 1038, 1040, 1042, 1034, 1042, 1060, 1036, 1040,    0,
			 1060, 1038, 1040,    0, 1048, 1042, 1044, 1046, 1044, 1046,
			    0, 1048, 1044, 1048, 1050, 1052, 1050, 1052, 1044, 1046,
			    0,    0,    0, 1048,    0,    0, 1050, 1052, 1053, 1053,

			 1053, 1053, 1056, 1056, 1056, 1056, 1048,    0,    0, 1046,
			    0, 1046, 1059, 1048, 1059, 1048, 1050, 1052, 1050, 1052,
			    0, 1046,    0,    0, 1059, 1048,    0,    0, 1050, 1052,
			 1057, 1057, 1057, 1057, 1061, 1063,    0, 1063, 1053,    0,
			    0, 1061, 1056, 1061, 1059,    0, 1059, 1063, 1065, 1067,
			 1065, 1067,    0, 1061,    0,    0, 1059,    0,    0,    0,
			 1065, 1067, 1068, 1068, 1068, 1068, 1061, 1063,    0, 1063,
			 1057,    0, 1070, 1061, 1070, 1061,    0,    0,    0, 1063,
			 1065, 1067, 1065, 1067, 1070, 1061,    0,    0,    0,    0,
			    0,    0, 1065, 1067,    0,    0,    0,    0,    0,    0, yy_Dummy>>,
			1, 200, 7400)
		end

	yy_chk_template_39 (an_array: ARRAY [INTEGER])
			-- Fill chunk #39 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			    0,    0, 1068,    0, 1070,    0, 1070,    0,    0,    0,
			    0,    0,    0,    0,    0,    0, 1070, 1072, 1072, 1072,
			 1072, 1072, 1072, 1072, 1072, 1072, 1072, 1072, 1072, 1072,
			 1072, 1072, 1072, 1072, 1072, 1072, 1072, 1072, 1072, 1072,
			 1073, 1073,    0, 1073, 1073, 1073, 1073, 1073, 1073, 1073,
			 1073, 1073, 1073, 1073, 1073, 1073, 1073, 1073, 1073, 1073,
			 1073, 1073, 1073, 1074,    0,    0,    0,    0,    0,    0,
			 1074, 1074, 1074, 1074, 1074, 1074, 1074, 1074, 1074, 1074,
			 1074, 1074, 1074, 1074, 1074, 1074, 1075, 1075,    0, 1075,
			 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075,

			 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1076,
			 1076,    0, 1076, 1076, 1076, 1076,    0, 1076, 1076, 1076,
			 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076, 1076,
			 1076, 1076, 1077, 1077, 1077, 1077, 1077, 1077, 1077, 1077,
			 1077,    0, 1077, 1077, 1077, 1077, 1078, 1078,    0, 1078,
			 1078, 1078,    0,    0, 1078, 1078, 1078, 1078, 1078, 1078,
			 1078, 1078, 1078,    0, 1078, 1078, 1078, 1078, 1078, 1079,
			 1079, 1079, 1079, 1079, 1079, 1079, 1079,    0, 1079, 1079,
			 1079, 1079, 1079, 1080,    0,    0, 1080,    0,    0, 1080,
			 1080, 1080, 1080, 1080, 1080, 1080, 1080, 1080, 1080, 1080, yy_Dummy>>,
			1, 200, 7600)
		end

	yy_chk_template_40 (an_array: ARRAY [INTEGER])
			-- Fill chunk #40 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			 1080, 1080, 1080, 1080, 1080, 1080, 1081, 1081,    0, 1081,
			 1081, 1081, 1081, 1081, 1081, 1081, 1081, 1081, 1081, 1081,
			 1081, 1081, 1081, 1081, 1081, 1081, 1081, 1081, 1081, 1082,
			 1082,    0, 1082, 1082, 1082, 1082, 1082, 1082, 1082, 1082,
			 1082, 1082, 1082, 1082, 1082, 1082, 1082, 1082, 1082, 1082,
			 1082, 1082, 1083,    0,    0,    0,    0, 1083, 1083, 1083,
			 1083, 1083, 1083, 1083, 1083, 1083, 1083, 1083, 1083, 1083,
			 1083, 1083, 1083, 1083, 1083, 1084, 1084, 1084, 1084, 1084,
			 1084, 1084, 1084,    0, 1084, 1084, 1084, 1084, 1084, 1084,
			 1084, 1084, 1084, 1084, 1084, 1084, 1084, 1084, 1085, 1085,

			 1085, 1085, 1085, 1085, 1085, 1085,    0, 1085, 1085, 1085,
			 1085, 1086, 1086, 1086, 1086, 1086, 1086, 1086, 1086,    0,
			 1086, 1086, 1086, 1086, 1087, 1087, 1087, 1087, 1087, 1087,
			 1087, 1087,    0, 1087, 1087, 1087, 1087, 1088, 1088,    0,
			 1088, 1088, 1088,    0, 1088, 1088, 1088, 1088, 1088, 1088,
			 1088, 1088, 1088, 1088, 1088, 1088, 1088, 1088, 1088, 1088,
			 1089, 1089, 1089, 1089, 1089, 1089, 1089, 1089,    0, 1089,
			 1089, 1089, 1089, 1089, 1089, 1089, 1089, 1089, 1089, 1089,
			 1089, 1089, 1089, 1071, 1071, 1071, 1071, 1071, 1071, 1071,
			 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071, yy_Dummy>>,
			1, 200, 7800)
		end

	yy_chk_template_41 (an_array: ARRAY [INTEGER])
			-- Fill chunk #41 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071,
			 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071,
			 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071,
			 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071,
			 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071,
			 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071,
			 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071,
			 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071,
			 1071, 1071, 1071, 1071, 1071, yy_Dummy>>,
			1, 85, 8000)
		end

	yy_base_template: SPECIAL [INTEGER]
			-- Template for `yy_base'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 1089)
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
			    0,    0,    0,  100,  113,  631, 7983,  623, 7983,  614,
			  601,  599,  127,    0, 7983,  135,  144, 7983, 7983, 7983,
			 7983, 7983,   91,   91,  102,  228,  104,  575, 7983,  104,
			 7983,  105,  554,  294,  225,  103,  220,  224,  366,   68,
			  363,  117,  209,  371,  105,  237,  382,  370,  280,  385,
			   98,  232, 7983,  446, 7983, 7983,  370,  440,  448,  513,
			  443,  515,  585,  432,  581,  592,  596,  632,  633,  648,
			  649,  694,  685,  699,  712,  713, 7983, 7983, 7983,  112,
			  409,  125,   65,  191,   67,  219,  371,  400,  599, 7983,
			  788,  746, 7983,  798,  432,  476,  718,  729,  756,  744,

			  767,  809,  458, 7983,  451, 7983,  824, 7983,  919,  969,
			  907,  933,  954,  983, 1002, 1030, 1049, 1078,    0, 1097,
			 1105, 1125, 1144, 1155, 1173, 1200, 1220, 1250, 1237,  388,
			 1345, 1311, 1328, 1356, 1368, 1379, 1389, 1402, 1419, 7983,
			 7983, 7983, 1306, 7983, 7983, 7983,  914,  364,  105,  160,
			  558, 1501,  851, 7983, 7983, 7983, 7983, 7983, 7983,  136,
			  372,  387,  231,  389,  444,  515, 1484, 1497, 1505, 1536,
			 1540, 1543, 1551,  228,  304,  260,   71,  550,   77,  653,
			  292,  517, 1554,  440, 1572,  689,  921,  640, 1597, 1600,
			 1603, 1611, 1608, 1659,  217, 1660, 1657,  513, 1641, 1667, yy_Dummy>>,
			1, 200, 0)
		end

	yy_base_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			 1706, 1710, 1719,  698, 1669,  583, 1661, 1735, 1758,  365,
			  908, 1779,  441, 1762, 1783, 1836, 1766, 1049, 1832, 1840,
			 1822,  832, 1851, 1505, 1119, 1686,  453, 1886, 1877, 1890,
			 1894, 1147, 1915, 1949, 1998, 1780, 1327, 1714, 1933, 1979,
			 1970, 1349, 1292, 2016, 1985, 1915, 2047, 1719,  529, 2034,
			 2061, 1599, 2052, 1844, 2092, 7983, 2055, 2063, 2086, 2112,
			 2127, 2155, 2137, 2178, 2203,  685,  185,  703,   86,  890,
			   98,  905,  165,  931,  969, 1017, 1067, 1095, 1123, 1140,
			 1181, 1189, 1209, 2189, 2214, 2225, 2235, 2246, 2257, 1936,
			 2291, 2096, 7983, 2357, 2365, 2361, 7983, 2374, 2383, 2394,

			 2406, 2418, 2428, 2528, 2539, 1337, 2456, 2464, 2472, 2483,
			 2494, 2505, 2600, 2608, 2634, 2642, 2650, 2659, 2668, 2679,
			 2703, 2714, 2774, 2786, 2809, 2832, 2846, 2882, 2904, 2929,
			 2951, 2965, 2979, 2854, 2914, 2987, 3009, 3024, 3082, 3104,
			 3043, 7983, 3057, 3091, 3115, 3134, 3148, 3158, 3182, 3206,
			 3216, 3225,  241, 3249, 3257, 3273, 3281, 3297, 3307, 3316,
			 3324, 3348, 3372, 3388, 3398, 3415, 3423, 3439, 3447, 3463,
			 3479, 3489, 3514, 3538, 3554, 3570, 3581, 3592, 3605, 2625,
			 2245, 1484, 7983, 2659, 2419, 2591,  262,  762,  177, 1303,
			  159, 3687,  128, 2765, 2800, 1785, 3670, 1934, 3683, 2330, yy_Dummy>>,
			1, 200, 200)
		end

	yy_base_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			  582, 3686, 3687,  646, 3691,  763, 3732, 2348, 3737, 1170,
			 1268, 1325, 1437, 1463, 1566, 1575,  863, 3736, 1919, 3750,
			 2060, 3753, 2604, 3786, 2344, 3789, 2461, 3793, 1610, 2002,
			 2359, 3800, 3814, 3817, 2339, 3843,  914, 2887, 3840, 3854,
			 3868, 2650, 3878, 3892, 2779, 3907, 1836, 3921, 3882, 3930,
			 1003, 3906, 2792,  973, 2925, 1768, 2926, 3954, 3970, 3975,
			 3969, 3994, 3061, 4018, 3098, 2645, 4021, 4025, 3063, 4039,
			 3290, 4044, 1068, 4058, 3096, 4075, 3395, 4072, 3295, 3394,
			 3695, 3806, 4094, 3745, 4108, 4112, 4126, 4127, 4141, 4172,
			 3532, 3963, 4155, 4188, 3534, 4193, 1098, 4179, 2374, 4212,

			 3557, 4226, 3590, 4011, 1101, 4240, 4229, 4257, 1221, 4278,
			 3704, 4285, 3743, 4281, 1315, 4292, 7983, 7983, 4285, 4294,
			 4312, 4326, 4338, 4353, 4367, 1678, 1853, 1910, 2050, 2077,
			 2083, 2108, 2149, 2152, 2166, 4389, 4398, 4409, 4433, 4448,
			 4462, 4473, 4504, 4512, 4573, 4582, 4612, 4623, 4634, 4645,
			 3407, 4376, 4562, 4677, 4685, 4740, 4757, 4748, 4781, 4789,
			 4797, 4808, 4819, 4852, 4914, 4928, 4947, 4864, 4959, 4967,
			 4604, 4975, 4983, 4993, 5006, 5019, 5038, 7983, 7983, 7983,
			 7983, 7983, 5129, 7983, 7983, 7983, 7983, 7983, 7983, 7983,
			 7983, 7983, 7983, 7983, 7983, 7983, 7983, 7983, 7983, 5074, yy_Dummy>>,
			1, 200, 400)
		end

	yy_base_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			 5085, 5097, 3533, 2650, 2769, 2823, 4907, 2876, 2895, 2945,
			 3201, 3249,  855,  126, 2830,  106,    0,   91, 3417, 3509,
			 3862, 5158, 3782, 5159, 3951, 5162, 2795, 5205, 4102, 1471,
			 5213, 5212, 2945, 3055, 3072, 3292, 5219, 4210, 5226, 4137,
			 5259, 4239, 5264, 4172, 5275, 3393, 5267, 3896, 5280, 4556,
			 5283, 1549, 5323, 4116, 5326, 4020, 4224, 4946, 5331, 4596,
			 5334, 4274, 5349, 4615, 5377, 1550, 4305, 5380, 5394, 1717,
			 5388, 4967, 5395, 5071, 5401, 4719, 5434, 4334, 5448, 4754,
			 5447, 1802, 5442, 4089, 5455, 1829, 5463, 1890, 5488, 4480,
			 5494, 1935, 5501, 4918, 2024, 5502, 5515, 4730, 5529, 5284,

			 5548, 4790, 5556, 2333, 5540, 4968, 5084, 5585, 5564, 2936,
			 5591, 4559, 5610, 5324, 5609, 2356, 5616, 5083, 5655, 3062,
			 5637, 3097, 5656, 5088, 5670, 5169, 5674, 5179, 5661, 4757,
			 5709, 3228, 5701, 3261, 5710, 5705, 5714, 5727, 3079, 3127,
			 3171, 5741, 5750, 5758, 5766, 5780, 5791, 5809, 5909, 5918,
			 5927, 5935, 5886, 5943, 5952, 5901, 5960, 5968, 5977, 5926,
			 3431, 3265, 3316, 6059, 3364, 3597, 3458, 4790, 3620, 6063,
			 5918, 4616, 6047, 3512, 5890, 3556, 6048, 5276, 6051, 4902,
			 6062, 5226, 6065, 3693, 6098, 3853, 6101, 5455, 6102, 5602,
			 6119, 5342, 6105, 3876, 6126, 5524, 6150, 5402, 6159, 5723, yy_Dummy>>,
			1, 200, 600)
		end

	yy_base_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			 6173, 5609, 6164, 6177, 6200, 5376, 6211, 6175, 6214, 3930,
			 6218, 5897, 6225, 6181, 6254, 5726, 6268, 3960, 6275, 4038,
			 6271, 4154, 6279, 4969, 6294, 4206, 6325, 4291, 6318, 5860,
			 6331, 6236, 6334, 5633, 6339, 4331, 6358, 6064, 6374, 6118,
			 6389, 6382, 6398, 6285, 6403, 6157, 6417, 4443, 6422, 6324,
			 6438, 6442, 6473, 4482, 6465, 4548, 6479, 6352, 6490, 4578,
			 6484, 6472, 6498, 6492, 6502, 6514, 6560, 7983, 4846, 5747,
			 4515, 5458, 6584, 5757, 4668, 4731, 5809, 4800, 4975, 6599,
			 4732, 6589, 4755, 6593, 6387, 6610, 5542, 6629, 6496, 6596,
			 4885, 5578, 6643, 6646, 6546, 6657, 6416, 6660, 6498, 6693,

			 5057, 6664, 5166, 6700, 6654, 6716, 5225, 6711, 6605, 6717,
			 6659, 6740, 5300, 6724, 6724, 6757, 6733, 6771, 6769, 6778,
			 6773, 6785, 6718, 6831, 6798, 6792, 6833, 6835, 5319, 6839,
			 6819, 6844, 6826, 6868, 5362, 6882, 6674, 6893, 5440, 6885,
			 5617, 6889, 5623, 6896, 6837, 6934, 6909, 6920, 5857, 6939,
			 6884, 6945, 4911, 4958, 5122, 7012, 7021, 6979, 5141, 6228,
			 6089, 6143, 6259, 7983, 7025, 7034, 6952, 7017, 7014, 7023,
			 5923, 7024, 6953, 7028, 6193, 7064, 7041, 7077, 6238, 7081,
			 7056, 7082, 6779, 7088, 6287, 7095, 6300, 7128, 7107, 7142,
			 6364, 7131, 6397, 7145, 7076, 7146, 6906, 7159, 7089, 7185, yy_Dummy>>,
			1, 200, 800)
		end

	yy_base_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			 7094, 7199, 7144, 7204, 6398, 7196, 7212, 7232, 7217, 7256,
			 6491, 7250,   79, 6603, 7290, 7298, 7316, 7322, 7331,   68,
			 7335, 7339, 7343, 6492, 7327, 7258, 7333, 6506, 7332, 6515,
			 7336, 7340, 7341, 6603, 7379, 6610, 7382, 6725, 7386, 7141,
			 7387, 6778, 7390, 7216, 7403, 6785, 7436, 7349, 7440, 6861,
			 7443, 6951, 7444, 7478,   50, 7370, 7482, 7510, 6970, 7471,
			 7400, 7500, 7023, 7494, 7030, 7507, 7153, 7508, 7542, 7154,
			 7531, 7983, 7616, 7639, 7662, 7685, 7708, 7723, 7745, 7759,
			 7782, 7805, 7828, 7851, 7874, 7888, 7901, 7914, 7936, 7959, yy_Dummy>>,
			1, 90, 1000)
		end

	yy_def_template: SPECIAL [INTEGER]
			-- Template for `yy_def'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 1089)
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
			    0, 1071,    1, 1072, 1072, 1071, 1071, 1071, 1071, 1071,
			 1071, 1071, 1073, 1074, 1071, 1075, 1076, 1071, 1071, 1071,
			 1071, 1071, 1071, 1071, 1071, 1077, 1077, 1071, 1071, 1071,
			 1071, 1071, 1071, 1071,   33,   34,   34,   34,   34,   34,
			   34,   34,   34,   34,   34,   34,   34,   34,   34,   34,
			   34,   34, 1071, 1071, 1071, 1071, 1078, 1079, 1079, 1079,
			   59,   59,   61,   61,   61,   61,   61,   61,   61,   61,
			   61,   61,   61,   61,   61,   61, 1071, 1071, 1071, 1071,
			 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1080, 1071, 1071,
			 1080, 1071, 1071, 1081, 1080, 1080, 1080, 1080, 1080, 1080,

			 1080, 1080, 1071, 1071, 1071, 1071, 1073, 1071, 1082, 1073,
			 1073, 1073, 1073, 1073, 1073, 1073, 1073, 1073, 1074, 1075,
			 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1075, 1083, 1071,
			 1083, 1083, 1083, 1083, 1083, 1083, 1083, 1083, 1083, 1071,
			 1071, 1071, 1071, 1071, 1071, 1071, 1084, 1077, 1077, 1085,
			 1086, 1087, 1077, 1071, 1071, 1071, 1071, 1071, 1071,   34,
			   34,   34,   34,   34,   34,   34,   61,   61,   61,   61,
			   61,   61,   61, 1071, 1071, 1071, 1071, 1071, 1071, 1071,
			 1071,   34,   61,   34,   34,   34,   34,   34,   61,   61,
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
			   61,   34,   61,   34,   61, 1071, 1078, 1078, 1078, 1078,
			 1078, 1078, 1078, 1078, 1078, 1071, 1071, 1071, 1071, 1071,
			 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071,
			 1080, 1080, 1080, 1080, 1080, 1080, 1080, 1080, 1080, 1071,
			 1071, 1088, 1071, 1080, 1081, 1071, 1071, 1081, 1081, 1081,

			 1081, 1081, 1081, 1081, 1081, 1080, 1080, 1080, 1080, 1080,
			 1080, 1080, 1082, 1075, 1075, 1082, 1082, 1082, 1082, 1082,
			 1082, 1082, 1082, 1082, 1082, 1073, 1073, 1073, 1073, 1073,
			 1073, 1073, 1073, 1075, 1075, 1075, 1075, 1075, 1075, 1075,
			 1083, 1071, 1083, 1083, 1083, 1083, 1083, 1083, 1083, 1083,
			 1083, 1083, 1071, 1083, 1083, 1083, 1083, 1083, 1083, 1083,
			 1083, 1083, 1083, 1083, 1083, 1083, 1083, 1083, 1083, 1083,
			 1083, 1083, 1083, 1083, 1083, 1083, 1083, 1083, 1083, 1071,
			 1071, 1071, 1071, 1071, 1071, 1077, 1077, 1085, 1085, 1086,
			 1086, 1087, 1087, 1077, 1077,   34,   61,   34,   61,   34, yy_Dummy>>,
			1, 200, 200)
		end

	yy_def_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			   34,   61,   61,   34,   61,   34,   61,   34,   61, 1071,
			 1071, 1071, 1071, 1071, 1071, 1071,   34,   61,   34,   61,
			   34,   61,   34,   61,   34,   61,   34,   61,   34,   34,
			   34,   61,   61,   61,   34,   61,   34,   34,   61,   61,
			   34,   34,   61,   61,   34,   61,   34,   61,   34,   61,
			   34,   61,   34,   34,   34,   34,   34,   61,   61,   61,
			   61,   61,   34,   61,   34,   34,   61,   61,   34,   61,
			   34,   61,   34,   61,   34,   61,   34,   61,   34,   34,
			   34,   34,   34,   34,   61,   61,   61,   61,   61,   61,
			   34,   34,   61,   61,   34,   61,   34,   61,   34,   61,

			   34,   61,   34,   34,   34,   61,   61,   61,   34,   61,
			   34,   61,   34,   61,   34,   61, 1071, 1071, 1078, 1078,
			 1078, 1078, 1078, 1078, 1078, 1071, 1071, 1071, 1071, 1071,
			 1071, 1071, 1071, 1071, 1071, 1088, 1088, 1088, 1088, 1088,
			 1088, 1088, 1088, 1081, 1081, 1081, 1081, 1081, 1081, 1081,
			 1080, 1080, 1080, 1082, 1082, 1082, 1082, 1082, 1082, 1082,
			 1082, 1082, 1082, 1082, 1073, 1073, 1073, 1075, 1075, 1075,
			 1083, 1083, 1083, 1083, 1083, 1083, 1083, 1071, 1071, 1071,
			 1071, 1071, 1083, 1071, 1071, 1071, 1071, 1071, 1071, 1071,
			 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1083, yy_Dummy>>,
			1, 200, 400)
		end

	yy_def_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			 1083, 1083, 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071,
			 1071, 1077, 1085, 1085, 1086, 1086,  391, 1087, 1077, 1077,
			   34,   61,   34,   61,   34,   61,   34,   61,   34,   34,
			   61,   61, 1071, 1071, 1071,   34,   61,   34,   61,   34,
			   61,   34,   61,   34,   61,   34,   61,   34,   61,   34,
			   61,   34,   61,   34,   61,   34,   34,   61,   61,   34,
			   61,   34,   61,   34,   61,   34,   34,   61,   61,   34,
			   61,   34,   61,   34,   61,   34,   61,   34,   61,   34,
			   61,   34,   61,   34,   61,   34,   61,   34,   61,   34,
			   61,   34,   61,   34,   34,   61,   61,   34,   61,   34,

			   61,   34,   61,   34,   61,   34,   34,   61,   61,   34,
			   61,   34,   61,   34,   61,   34,   61,   34,   61,   34,
			   61,   34,   61,   34,   61,   34,   61,   34,   61,   34,
			   61,   34,   61,   34,   61, 1078, 1078, 1078, 1071, 1071,
			 1071, 1088, 1088, 1088, 1088, 1088, 1088, 1088, 1081, 1081,
			 1081, 1082, 1082, 1082, 1082, 1083, 1083, 1083, 1083, 1071,
			 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1084,
			 1077,   34,   61,   34,   61,   34,   61,   34,   61,   34,
			   61,   34,   61,   34,   61,   34,   61,   34,   61,   34,
			   61,   34,   61,   34,   61,   34,   61,   34,   61,   34, yy_Dummy>>,
			1, 200, 600)
		end

	yy_def_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			   61,   34,   61,   34,   61,   34,   61,   34,   61,   34,
			   61,   34,   61,   34,   61,   34,   61,   34,   61,   34,
			   61,   34,   61,   34,   61,   34,   61,   34,   61,   34,
			   61,   34,   61,   34,   61,   34,   61,   34,   61,   34,
			   61,   34,   61,   34,   61,   34,   61,   34,   61,   34,
			   61,   34,   61,   34,   61,   34,   61,   34,   61,   34,
			   61,   34,   61, 1088, 1088, 1088, 1082, 1071, 1071, 1071,
			 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1089,
			   34,   61,   34,   61,   34,   61,   34,   61,   34,   61,
			   34,   34,   61,   61,   34,   61,   34,   61,   34,   61,

			   34,   61,   34,   61,   34,   61,   34,   61,   34,   61,
			   34,   61,   34,   61,   34,   61,   34,   61,   34,   61,
			   34,   61,   34,   61,   34,   61,   34,   61,   34,   61,
			   34,   61,   34,   61,   34,   61,   34,   61,   34,   61,
			   34,   61,   34,   61,   34,   61,   34,   61,   34,   61,
			   34,   61, 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071,
			 1071, 1071, 1071, 1071, 1071, 1071,   34,   61,   34,   61,
			   34,   61,   34,   61,   34,   61,   34,   61,   34,   61,
			   34,   61,   34,   61,   34,   61,   34,   61,   34,   61,
			   34,   61,   34,   61,   34,   61,   34,   61,   34,   61, yy_Dummy>>,
			1, 200, 800)
		end

	yy_def_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			   34,   61,   34,   61,   34,   61,   34,   61,   34,   61,
			   34,   61, 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071,
			 1071, 1071, 1071,   34,   61,   34,   61,   34,   61,   34,
			   61,   34,   61,   34,   61,   34,   61,   34,   61,   34,
			   61,   34,   61,   34,   61,   34,   61,   34,   61,   34,
			   61,   34,   61, 1071, 1071, 1071, 1071, 1071,   34,   61,
			   34,   61,   34,   61,   34,   61,   34,   61, 1071,   34,
			   61,    0, 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071,
			 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071, 1071, yy_Dummy>>,
			1, 90, 1000)
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
			    7,    8,    1,    1,    1,    1,    1,    1,    9,    1,
			   10,   11,   12,   13,    1,    1,    1,    1,    1,    1,
			   10,   10,   10,   10,   10,   10,   10,   10,   10,   10,
			   10,   10,   10,   10,   10,   10,   10,   10,   10,   10,
			   10,   10,   14,   15,   16,   17,    1,    1,    1,    1,
			   10,   18,   10,   10,   10,   10,   10,   10,   10,   10,
			   10,   10,   10,   10,   10,   10,   10,   10,   10,   10,
			   10,   10,   10,   10,   19,   20,   21,   22,    1,    1,
			    1,    1,    1,    1,   23,   23,   23,   23,   23,   23,

			   23,   23, yy_Dummy>>)
		end

	yy_accept_template: SPECIAL [INTEGER]
			-- Template for `yy_accept'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 1072)
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
			   43,   46,   49,   52,   55,   58,   62,   66,   69,   72,
			   75,   78,   81,   83,   87,   91,   95,   99,  103,  107,
			  111,  115,  119,  123,  127,  131,  135,  139,  143,  147,
			  151,  155,  159,  162,  164,  167,  170,  172,  175,  178,
			  181,  184,  187,  190,  193,  196,  199,  202,  205,  208,
			  211,  214,  217,  220,  223,  226,  229,  232,  235,  238,
			  240,  242,  244,  246,  248,  250,  252,  254,  256,  258,
			  260,  263,  265,  267,  269,  271,  273,  275,  277,  279,

			  281,  283,  285,  286,  287,  288,  289,  290,  291,  292,
			  295,  296,  297,  298,  299,  300,  301,  302,  303,  304,
			  305,  306,  307,  308,  309,  310,  311,  312,  313,  314,
			  314,  315,  316,  317,  318,  319,  320,  321,  322,  323,
			  324,  325,  326,  328,  329,  330,  331,  331,  333,  334,
			  335,  336,  337,  337,  338,  339,  340,  341,  342,  343,
			  345,  347,  349,  351,  353,  356,  358,  359,  360,  361,
			  362,  363,  365,  366,  366,  366,  366,  366,  366,  366,
			  366,  366,  368,  369,  371,  373,  375,  377,  379,  380,
			  381,  382,  383,  384,  386,  389,  390,  392,  394,  396, yy_Dummy>>,
			1, 200, 0)
		end

	yy_accept_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			  398,  399,  400,  401,  403,  405,  407,  408,  409,  410,
			  413,  415,  417,  420,  422,  423,  424,  426,  428,  430,
			  431,  432,  434,  435,  437,  439,  441,  444,  445,  446,
			  447,  449,  451,  452,  454,  455,  457,  459,  461,  462,
			  463,  464,  466,  468,  469,  470,  472,  473,  475,  477,
			  478,  479,  481,  482,  484,  485,  486,  486,  486,  486,
			  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,
			  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,
			  486,  487,  488,  489,  490,  491,  492,  493,  494,  495,
			  496,  496,  496,  497,  498,  499,  500,  501,  502,  503,

			  504,  505,  506,  507,  508,  509,  510,  511,  512,  513,
			  514,  515,  516,  516,  518,  520,  520,  520,  520,  520,
			  520,  520,  520,  520,  520,  520,  522,  523,  524,  525,
			  526,  527,  528,  529,  530,  531,  532,  533,  534,  535,
			  536,  537,  538,  539,  540,  541,  542,  543,  544,  545,
			  546,  547,  548,  548,  549,  550,  551,  552,  553,  554,
			  555,  556,  557,  558,  559,  560,  561,  562,  563,  564,
			  565,  566,  567,  568,  569,  570,  571,  572,  573,  574,
			  576,  576,  576,  577,  579,  580,  582,  582,  585,  587,
			  590,  592,  595,  597,  599,  599,  601,  602,  604,  605, yy_Dummy>>,
			1, 200, 200)
		end

	yy_accept_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			  607,  610,  611,  613,  616,  618,  620,  621,  623,  624,
			  624,  624,  624,  624,  624,  624,  624,  627,  629,  631,
			  632,  634,  635,  637,  638,  640,  641,  643,  644,  646,
			  648,  650,  651,  652,  653,  655,  656,  659,  661,  663,
			  664,  666,  668,  669,  670,  672,  673,  675,  676,  678,
			  679,  681,  682,  684,  686,  688,  690,  692,  693,  694,
			  695,  696,  697,  699,  700,  702,  704,  705,  706,  709,
			  711,  713,  714,  717,  719,  721,  722,  724,  725,  727,
			  729,  731,  733,  735,  737,  738,  739,  740,  741,  742,
			  743,  745,  747,  748,  749,  751,  752,  754,  755,  757,

			  758,  760,  761,  763,  765,  767,  768,  769,  770,  772,
			  773,  775,  776,  778,  779,  782,  784,  785,  786,  786,
			  786,  786,  786,  786,  786,  786,  786,  786,  786,  786,
			  786,  786,  786,  786,  786,  786,  786,  786,  786,  786,
			  786,  786,  786,  786,  787,  788,  789,  790,  791,  792,
			  793,  794,  795,  796,  797,  798,  798,  799,  799,  799,
			  799,  799,  799,  799,  799,  800,  801,  802,  803,  804,
			  805,  806,  807,  808,  809,  810,  811,  812,  813,  814,
			  815,  816,  817,  818,  819,  820,  821,  822,  823,  824,
			  825,  826,  827,  828,  829,  830,  831,  832,  833,  834, yy_Dummy>>,
			1, 200, 400)
		end

	yy_accept_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			  835,  836,  837,  839,  839,  841,  841,  843,  843,  843,
			  843,  845,  847,  847,  847,  847,  847,  847,  847,  849,
			  851,  853,  854,  856,  857,  859,  860,  862,  863,  865,
			  867,  868,  869,  869,  869,  869,  871,  872,  874,  875,
			  877,  878,  880,  881,  883,  884,  886,  887,  889,  890,
			  892,  893,  896,  898,  900,  901,  903,  905,  906,  907,
			  909,  910,  912,  913,  915,  916,  919,  921,  923,  924,
			  926,  927,  929,  930,  932,  933,  935,  936,  938,  939,
			  941,  942,  945,  947,  949,  950,  953,  955,  958,  960,
			  962,  963,  966,  968,  970,  972,  973,  974,  976,  977,

			  979,  980,  982,  983,  985,  986,  988,  990,  991,  992,
			  994,  995,  997,  998, 1000, 1001, 1004, 1006, 1008, 1009,
			 1012, 1014, 1017, 1019, 1021, 1022, 1024, 1025, 1027, 1028,
			 1030, 1031, 1034, 1036, 1039, 1041, 1041, 1041, 1041, 1041,
			 1041, 1041, 1041, 1041, 1041, 1041, 1041, 1041, 1041, 1042,
			 1043, 1044, 1044, 1044, 1044, 1044, 1045, 1046, 1047, 1048,
			 1049, 1051, 1051, 1051, 1053, 1053, 1057, 1057, 1059, 1059,
			 1059, 1061, 1063, 1064, 1067, 1069, 1072, 1074, 1076, 1077,
			 1079, 1080, 1082, 1083, 1086, 1088, 1091, 1093, 1095, 1096,
			 1098, 1099, 1101, 1102, 1105, 1107, 1109, 1110, 1112, 1113, yy_Dummy>>,
			1, 200, 600)
		end

	yy_accept_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			 1115, 1116, 1118, 1119, 1121, 1122, 1124, 1125, 1127, 1128,
			 1131, 1133, 1135, 1136, 1138, 1139, 1141, 1142, 1144, 1145,
			 1148, 1150, 1152, 1153, 1155, 1156, 1158, 1159, 1162, 1164,
			 1166, 1167, 1169, 1170, 1172, 1173, 1175, 1176, 1178, 1179,
			 1181, 1182, 1184, 1185, 1187, 1188, 1190, 1191, 1194, 1196,
			 1198, 1199, 1201, 1202, 1205, 1207, 1209, 1210, 1212, 1213,
			 1216, 1218, 1220, 1221, 1221, 1221, 1221, 1221, 1222, 1222,
			 1224, 1224, 1225, 1226, 1230, 1230, 1230, 1232, 1232, 1233,
			 1233, 1236, 1238, 1241, 1243, 1245, 1246, 1248, 1249, 1251,
			 1252, 1255, 1257, 1259, 1260, 1262, 1263, 1265, 1266, 1268,

			 1269, 1272, 1274, 1277, 1279, 1281, 1282, 1285, 1287, 1289,
			 1290, 1292, 1293, 1296, 1298, 1300, 1301, 1303, 1304, 1306,
			 1307, 1309, 1310, 1312, 1313, 1315, 1316, 1318, 1319, 1322,
			 1324, 1326, 1327, 1329, 1330, 1333, 1335, 1337, 1338, 1341,
			 1343, 1346, 1348, 1351, 1353, 1355, 1356, 1358, 1359, 1362,
			 1364, 1366, 1367, 1367, 1368, 1368, 1368, 1368, 1372, 1372,
			 1373, 1374, 1374, 1374, 1375, 1376, 1377, 1379, 1380, 1382,
			 1383, 1386, 1388, 1390, 1391, 1394, 1396, 1398, 1399, 1401,
			 1402, 1404, 1405, 1407, 1408, 1411, 1413, 1416, 1418, 1420,
			 1421, 1424, 1426, 1429, 1431, 1433, 1434, 1436, 1437, 1439, yy_Dummy>>,
			1, 200, 800)
		end

	yy_accept_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			 1440, 1442, 1443, 1445, 1446, 1449, 1451, 1453, 1454, 1456,
			 1457, 1460, 1462, 1463, 1463, 1464, 1464, 1466, 1466, 1466,
			 1467, 1468, 1468, 1469, 1472, 1474, 1476, 1477, 1480, 1482,
			 1485, 1487, 1489, 1490, 1493, 1495, 1498, 1500, 1503, 1505,
			 1507, 1508, 1511, 1513, 1515, 1516, 1519, 1521, 1523, 1524,
			 1527, 1529, 1532, 1534, 1535, 1537, 1537, 1539, 1540, 1543,
			 1545, 1547, 1548, 1551, 1553, 1556, 1558, 1561, 1563, 1565,
			 1568, 1570, 1570, yy_Dummy>>,
			1, 73, 1000)
		end

	yy_acclist_template: SPECIAL [INTEGER]
			-- Template for `yy_acclist'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 1569)
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
			    0,  146,  146,  167,  165,  166,    2,  165,  166,    4,
			  166,    5,  165,  166,    1,  165,  166,   11,  165,  166,
			  148,  165,  166,  113,  165,  166,   18,  165,  166,  148,
			  165,  166,  165,  166,   12,  165,  166,   13,  165,  166,
			   33,  165,  166,   32,  165,  166,    9,  165,  166,   31,
			  165,  166,    7,  165,  166,   34,  165,  166,  149,  156,
			  165,  166,  149,  156,  165,  166,   10,  165,  166,    8,
			  165,  166,   38,  165,  166,   36,  165,  166,   37,  165,
			  166,  165,  166,  111,  112,  165,  166,  111,  112,  165,
			  166,  111,  112,  165,  166,  111,  112,  165,  166,  111,

			  112,  165,  166,  111,  112,  165,  166,  111,  112,  165,
			  166,  111,  112,  165,  166,  111,  112,  165,  166,  111,
			  112,  165,  166,  111,  112,  165,  166,  111,  112,  165,
			  166,  111,  112,  165,  166,  111,  112,  165,  166,  111,
			  112,  165,  166,  111,  112,  165,  166,  111,  112,  165,
			  166,  111,  112,  165,  166,  111,  112,  165,  166,   16,
			  165,  166,  165,  166,   17,  165,  166,   35,  165,  166,
			  165,  166,  112,  165,  166,  112,  165,  166,  112,  165,
			  166,  112,  165,  166,  112,  165,  166,  112,  165,  166,
			  112,  165,  166,  112,  165,  166,  112,  165,  166,  112, yy_Dummy>>,
			1, 200, 0)
		end

	yy_acclist_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  165,  166,  112,  165,  166,  112,  165,  166,  112,  165,
			  166,  112,  165,  166,  112,  165,  166,  112,  165,  166,
			  112,  165,  166,  112,  165,  166,  112,  165,  166,   14,
			  165,  166,   15,  165,  166,   39,  165,  166,  165,  166,
			  165,  166,  165,  166,  165,  166,  165,  166,  165,  166,
			  165,  166,  165,  166,  146,  166,  141,  166,  143,  166,
			  144,  146,  166,  140,  166,  145,  166,  146,  166,  146,
			  166,  146,  166,  146,  166,  146,  166,  146,  166,  146,
			  166,  146,  166,  146,  166,    2,    3,    1,   40,  148,
			  147,  147, -138,  148, -304,  148,  148,  148,  148,  148,

			  148,  148,  148,  113,  148,  148,  148,  148,  148,  148,
			  148,  148,  148,  137,  137,  137,  137,  137,  137,  137,
			  137,  137,  137,    6,   24,   25,  159,  162,   19,   21,
			   30,  149,  156,  156,  156,  156,  156,   29,   26,   23,
			   22,   27,   28,  111,  112,  111,  112,  111,  112,  111,
			  112,  111,  112,   45,  111,  112,  111,  112,  112,  112,
			  112,  112,  112,   45,  112,  112,  111,  112,  112,  111,
			  112,  111,  112,  111,  112,  111,  112,  111,  112,  112,
			  112,  112,  112,  112,  111,  112,   56,  111,  112,  112,
			   56,  112,  111,  112,  111,  112,  111,  112,  112,  112, yy_Dummy>>,
			1, 200, 200)
		end

	yy_acclist_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  112,  111,  112,  111,  112,  111,  112,  112,  112,  112,
			   68,  111,  112,  111,  112,  111,  112,   74,  111,  112,
			   68,  112,  112,  112,   74,  112,  111,  112,  111,  112,
			  112,  112,  111,  112,  112,  111,  112,  111,  112,  111,
			  112,   82,  111,  112,  112,  112,  112,   82,  112,  111,
			  112,  112,  111,  112,  112,  111,  112,  111,  112,  111,
			  112,  112,  112,  112,  111,  112,  111,  112,  112,  112,
			  111,  112,  112,  111,  112,  111,  112,  112,  112,  111,
			  112,  112,  111,  112,  112,   20,  146,  146,  146,  146,
			  146,  146,  146,  146,  146,  141,  142,  146,  146,  140,

			  139,  146,  146,  146,  146,  146,  146,  146,  146,  146,
			  146,  146,  146,  146,  146,  146,  147,  148,  147,  148,
			 -138,  148,  148,  148,  148,  148,  148,  148,  148,  148,
			  148,  148,  148,  148,  148,  148,  137,  114,  137,  137,
			  137,  137,  137,  137,  137,  137,  137,  137,  137,  137,
			  137,  137,  137,  137,  137,  137,  137,  137,  137,  137,
			  137,  137,  137,  137,  137,  137,  137,  137,  137,  137,
			  137,  137,  137,  137,  159,  162,  157,  159,  162,  157,
			  149,  156,  152,  155,  156,  155,  156,  151,  154,  156,
			  154,  156,  150,  153,  156,  153,  156,  149,  156,  111, yy_Dummy>>,
			1, 200, 400)
		end

	yy_acclist_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  112,  112,  111,  112,  112,  111,  112,   43,  111,  112,
			  112,   43,  112,   44,  111,  112,   44,  112,  111,  112,
			  112,  111,  112,  112,   47,  111,  112,   47,  112,  111,
			  112,  112,  111,  112,  112,  111,  112,  112,  111,  112,
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
			  111,  112,  103,  112,  164,  163,  146,  146,  146,  146,
			  146,  146,  146,  146,  146,  146,  147,  147,  147,  148, yy_Dummy>>,
			1, 200, 600)
		end

	yy_acclist_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  148,  148,  148,  148,  148,  137,  137,  137,  137,  137,
			  137,  137,  131,  129,  130,  132,  133,  137,  134,  135,
			  115,  116,  117,  118,  119,  120,  121,  122,  123,  124,
			  125,  126,  127,  128,  137,  137,  137,  159,  162,  159,
			  162,  159,  162,  158,  161,  149,  156,  149,  156,  149,
			  156,  111,  112,  112,  111,  112,  112,  111,  112,  112,
			  111,  112,  112,  111,  112,  111,  112,  112,  112,  111,
			  112,  112,  111,  112,  112,  111,  112,  112,  111,  112,
			  112,  111,  112,  112,  111,  112,  112,  111,  112,  112,
			  111,  112,  112,   57,  111,  112,   57,  112,  111,  112,

			  112,  111,  112,  111,  112,  112,  112,  111,  112,  112,
			  111,  112,  112,  111,  112,  112,   66,  111,  112,  111,
			  112,   66,  112,  112,  111,  112,  112,  111,  112,  112,
			  111,  112,  112,  111,  112,  112,  111,  112,  112,  111,
			  112,  112,   75,  111,  112,   75,  112,  111,  112,  112,
			   77,  111,  112,   77,  112,  108,  111,  112,  108,  112,
			  111,  112,  112,   81,  111,  112,   81,  112,  111,  112,
			  111,  112,  112,  112,  111,  112,  112,  111,  112,  112,
			  111,  112,  112,  111,  112,  112,  111,  112,  111,  112,
			  112,  112,  111,  112,  112,  111,  112,  112,  111,  112, yy_Dummy>>,
			1, 200, 800)
		end

	yy_acclist_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  112,  109,  111,  112,  109,  112,  111,  112,  112,   95,
			  111,  112,   95,  112,   96,  111,  112,   96,  112,  111,
			  112,  112,  111,  112,  112,  111,  112,  112,  111,  112,
			  112,  101,  111,  112,  101,  112,  102,  111,  112,  102,
			  112,  146,  146,  146,  137,  137,  137,  137,  159,  159,
			  162,  159,  162,  158,  159,  161,  162,  158,  161,  149,
			  156,  111,  112,  112,   41,  111,  112,   41,  112,   42,
			  111,  112,   42,  112,  111,  112,  112,  111,  112,  112,
			  111,  112,  112,   48,  111,  112,   48,  112,   49,  111,
			  112,   49,  112,  111,  112,  112,  111,  112,  112,  111,

			  112,  112,   54,  111,  112,   54,  112,  111,  112,  112,
			  111,  112,  112,  111,  112,  112,  111,  112,  112,  111,
			  112,  112,  111,  112,  112,  111,  112,  112,   64,  111,
			  112,   64,  112,  111,  112,  112,  111,  112,  112,  111,
			  112,  112,  111,  112,  112,   70,  111,  112,   70,  112,
			  111,  112,  112,  111,  112,  112,  111,  112,  112,   76,
			  111,  112,   76,  112,  111,  112,  112,  111,  112,  112,
			  111,  112,  112,  111,  112,  112,  111,  112,  112,  111,
			  112,  112,  111,  112,  112,  111,  112,  112,  111,  112,
			  112,   91,  111,  112,   91,  112,  111,  112,  112,  111, yy_Dummy>>,
			1, 200, 1000)
		end

	yy_acclist_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  112,  112,   94,  111,  112,   94,  112,  111,  112,  112,
			  111,  112,  112,   99,  111,  112,   99,  112,  111,  112,
			  112,  136,  159,  162,  162,  159,  158,  159,  161,  162,
			  158,  161,  157,  104,  111,  112,  104,  112,   46,  111,
			  112,   46,  112,  111,  112,  112,  111,  112,  112,  111,
			  112,  112,   51,  111,  112,  111,  112,   51,  112,  112,
			  111,  112,  112,  111,  112,  112,  111,  112,  112,   58,
			  111,  112,   58,  112,   60,  111,  112,   60,  112,  111,
			  112,  112,   62,  111,  112,   62,  112,  111,  112,  112,
			  111,  112,  112,   67,  111,  112,   67,  112,  111,  112,

			  112,  111,  112,  112,  111,  112,  112,  111,  112,  112,
			  111,  112,  112,  111,  112,  112,  111,  112,  112,   84,
			  111,  112,   84,  112,  111,  112,  112,  111,  112,  112,
			   87,  111,  112,   87,  112,  111,  112,  112,   89,  111,
			  112,   89,  112,   90,  111,  112,   90,  112,   92,  111,
			  112,   92,  112,  111,  112,  112,  111,  112,  112,   98,
			  111,  112,   98,  112,  111,  112,  112,  159,  158,  159,
			  161,  162,  162,  158,  160,  162,  160,  111,  112,  112,
			  111,  112,  112,   50,  111,  112,   50,  112,  111,  112,
			  112,   53,  111,  112,   53,  112,  111,  112,  112,  111, yy_Dummy>>,
			1, 200, 1200)
		end

	yy_acclist_template_8 (an_array: ARRAY [INTEGER])
			-- Fill chunk #8 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  112,  112,  111,  112,  112,  111,  112,  112,   65,  111,
			  112,   65,  112,   69,  111,  112,   69,  112,  111,  112,
			  112,   71,  111,  112,   71,  112,   72,  111,  112,   72,
			  112,  111,  112,  112,  111,  112,  112,  111,  112,  112,
			  111,  112,  112,  111,  112,  112,   88,  111,  112,   88,
			  112,  111,  112,  112,  111,  112,  112,  100,  111,  112,
			  100,  112,  162,  162,  158,  159,  161,  162,  161,  105,
			  111,  112,  105,  112,  111,  112,  112,   52,  111,  112,
			   52,  112,   55,  111,  112,   55,  112,  111,  112,  112,
			   61,  111,  112,   61,  112,   63,  111,  112,   63,  112,

			  110,  111,  112,  110,  112,  111,  112,  112,   79,  111,
			  112,   79,  112,  111,  112,  112,   86,  111,  112,   86,
			  112,  111,  112,  112,   93,  111,  112,   93,  112,   97,
			  111,  112,   97,  112,  162,  161,  162,  161,  162,  161,
			  106,  111,  112,  106,  112,  111,  112,  112,   73,  111,
			  112,   73,  112,   83,  111,  112,   83,  112,   85,  111,
			  112,   85,  112,  161,  162,  107,  111,  112,  107,  112, yy_Dummy>>,
			1, 170, 1400)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER = 7983
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER = 1071
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER = 1072
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

	yyNb_rules: INTEGER = 166
			-- Number of rules

	yyEnd_of_buffer: INTEGER = 167
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
