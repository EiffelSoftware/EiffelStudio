note

	description: "Scanners for Eiffel parsers"
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
						curr_token := new_comment
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

					curr_token := new_text
					update_token_list
					
when 6 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end
 
						-- comments
					curr_token := new_comment
					in_comments := True	
					update_token_list					
				
when 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

						-- Symbols
					if not in_comments then
						curr_token := new_text
					else
						curr_token := new_comment
					end
					update_token_list
					
when 20 then
	yy_end := yy_start + yy_more_len + 1
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

						-- Symbols
					if not in_comments then
						curr_token := new_text
					else
						curr_token := new_comment
					end
					update_token_list
					
when 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end
 
						-- Operator Symbol
					if not in_comments then
						curr_token := new_operator
					else
						curr_token := new_comment
					end
					update_token_list
					
when 42 then
	yy_end := yy_start + yy_more_len + 1
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

									if in_comments then
											-- Comment.
										curr_token := new_comment
									else
											-- Keyword.
										curr_token := new_keyword
									end
									update_token_list
								
when 43 then
	yy_end := yy_start + yy_more_len + 1
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

									if in_comments then
											-- Comment.
										curr_token := new_comment
									else
											-- Keyword.
										curr_token := new_keyword
									end
									update_token_list
								
when 44 then
	yy_end := yy_start + yy_more_len + 1
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

									if in_comments then
											-- Comment.
										curr_token := new_comment
									else
											-- Keyword.
										curr_token := new_keyword
									end
									update_token_list
								
when 45 then
	yy_end := yy_start + yy_more_len + 1
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

									if in_comments then
											-- Comment.
										curr_token := new_comment
									else
											-- Keyword.
										curr_token := new_keyword
									end
									update_token_list
								
when 46 then
	yy_end := yy_start + yy_more_len + 1
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

									if in_comments then
											-- Comment.
										curr_token := new_comment
									else
											-- Keyword.
										curr_token := new_keyword
									end
									update_token_list
								
when 47 then
	yy_end := yy_start + yy_more_len + 1
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

									if in_comments then
											-- Comment.
										curr_token := new_comment
									else
											-- Keyword.
										curr_token := new_keyword
									end
									update_token_list
								
when 48 then
	yy_end := yy_start + yy_more_len + 1
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

									if in_comments then
											-- Comment.
										curr_token := new_comment
									else
											-- Keyword.
										curr_token := new_keyword
									end
									update_token_list
								
when 49 then
	yy_end := yy_start + yy_more_len + 1
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

									if in_comments then
											-- Comment.
										curr_token := new_comment
									else
											-- Keyword.
										curr_token := new_keyword
									end
									update_token_list
								
when 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

									if in_comments then
											-- Comment.
										curr_token := new_comment
									else
											-- Keyword.
										curr_token := new_keyword
									end
									update_token_list
								
when 110, 111, 112, 113, 114, 115 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

							if in_comments then
									-- Comment
								curr_token := new_comment
							elseif syntax_version /= {EIFFEL_SCANNER}.obsolete_syntax then
									-- Keyword
								curr_token := new_keyword
							else
									-- Identifier
								curr_token := new_text
							end
							update_token_list
						
when 116 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

							if in_comments then
									-- Comment
								curr_token := new_comment
							elseif
								syntax_version = {EIFFEL_SCANNER}.obsolete_syntax or else
								syntax_version = {EIFFEL_SCANNER}.transitional_syntax
							then
									-- Keyword
								curr_token := new_keyword
							else
								curr_token := new_text
							end
							update_token_list
						
when 117 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

							if not in_comments then
								if is_current_group_valid then
									tmp_classes := current_group.class_by_name (unicode_text, True)
									if not tmp_classes.is_empty then
										curr_token := new_class
										curr_token.set_pebble (stone_of_class (tmp_classes.first))
									else
										curr_token := new_text
									end
								else
									curr_token := new_text
								end							
							else
								curr_token := new_comment
							end
							update_token_list
						
when 118 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

							if not in_comments then
								curr_token := new_text											
							else
								curr_token := new_comment
							end
							update_token_list
						
when 119 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

										if not in_comments then
											curr_token := new_operator
										else
											curr_token := new_comment
										end
										update_token_list
										
when 120 then
	yy_end := yy_end - 1
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

										if not in_comments then
											curr_token := new_operator
										else
											curr_token := new_comment
										end
										update_token_list
										
when 121 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

										if not in_comments then
											curr_token := new_operator
										else
											curr_token := new_comment
										end
										update_token_list
										
when 122 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

										if not in_comments then
											curr_token := new_operator
										else
											curr_token := new_comment
										end
										update_token_list
										
when 123 then
	yy_end := yy_end - 1
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

										if not in_comments then
											curr_token := new_operator
										else
											curr_token := new_comment
										end
										update_token_list
										
when 124 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

										if not in_comments then
											curr_token := new_operator
										else
											curr_token := new_comment
										end
										update_token_list
										
when 125, 126, 127, 128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 145, 146, 147, 148, 149, 150 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

		if not in_comments then
			curr_token := new_character
		else
			curr_token := new_comment
		end
		update_token_list
	
when 151, 152 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

			-- Character error. Catch-all rules (no backing up)
		if not in_comments then
			curr_token := new_text
		else
			curr_token := new_comment
		end
		update_token_list
	
when 153 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

 		if not in_comments then
				-- Verbatim string opener.
			curr_token := new_string
			update_token_list
			in_verbatim_string := True
			start_of_verbatim_string := True
			set_start_condition (VERBATIM_STR1)
		else
			curr_token := new_comment
			update_token_list
		end
	
when 154 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

				-- Verbatim string closer, possibly.
			curr_token := new_string
			end_of_verbatim_string := True
			in_verbatim_string := False
			set_start_condition (INITIAL)
			update_token_list
		
when 155 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

			curr_token := new_space (text_count)
			update_token_list						
		
when 156 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

			curr_token := new_tabulation (text_count)
			update_token_list						
		
when 157 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

			curr_token := new_eol (True)
			update_token_list
			in_comments := False
		
when 158 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

			curr_token := new_eol (False)
			update_token_list
			in_comments := False
		
when 159 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

			curr_token := new_text
			update_token_list
		
when 160 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

			curr_token := new_string
			update_token_list
		
when 161 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

			curr_token := new_string
			update_token_list
		
when 162 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

			-- Eiffel String
		if not in_comments then						
			curr_token := new_string
		else
			curr_token := new_comment
		end
		update_token_list
	
when 163 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

			-- Eiffel Integer
		if not in_comments then
			curr_token := new_number
		else
			curr_token := new_comment
		end
		update_token_list
	
when 164 then
	yy_end := yy_end - 2
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

			-- Eiffel Integer
		if not in_comments then
			curr_token := new_number
		else
			curr_token := new_comment
		end
		update_token_list
	
when 165, 166, 167 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

			-- Eiffel Integer
		if not in_comments then
			curr_token := new_number
		else
			curr_token := new_comment
		end
		update_token_list
	
when 168, 169 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

			-- Bad Eiffel Integer
		if not in_comments then
			curr_token := new_text
		else
			curr_token := new_comment
		end
		update_token_list
	
when 170 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

			-- Eiffel reals & doubles
		if not in_comments then		
			curr_token := new_number
		else
			curr_token := new_comment
		end
		update_token_list
	
when 171, 172 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

		curr_token := new_text_in_comment
		update_token_list
	
when 173 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

			-- Error (considered as text)
		if not in_comments then
			curr_token := new_text
		else
			curr_token := new_comment
		end
		update_token_list
	
when 174 then
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
			create an_array.make_filled (0, 0, 2584)
			yy_nxt_template_1 (an_array)
			yy_nxt_template_2 (an_array)
			yy_nxt_template_3 (an_array)
			an_array.area.fill_with (136, 488, 513)
			yy_nxt_template_4 (an_array)
			an_array.area.fill_with (143, 520, 545)
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
			an_array.area.fill_with (864, 2481, 2584)
			Result := yy_fixed_array (an_array)
		end

	yy_nxt_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			    0,    7,    8,    6,    9,   10,   11,   12,   13,   14,
			   15,   16,   17,   18,   19,   20,   21,   22,   23,   24,
			   25,   26,   26,   26,   27,   28,   29,   30,   31,   32,
			   33,   34,   35,   36,   37,   38,   39,   35,   35,   40,
			   35,   35,   41,   35,   42,   43,   44,   35,   45,   46,
			   47,   48,   49,   50,   51,   35,   35,   52,   53,   54,
			   55,   56,   57,   58,   59,   60,   61,   62,   63,   59,
			   59,   64,   59,   59,   65,   59,   66,   67,   68,   59,
			   69,   70,   71,   72,   73,   74,   75,   59,   59,   76,
			   77,   78,   56,   79,    6,    6,    6,   56,   80,   81,

			   82,   83,   84,   85,    6,   87,   88,  100,   89,   90,
			  101,   91,   87,   88,  100,   89,   90,  101,   91,   96,
			   96,   96,   96,   96,  109,  110,   96,   96,   96,   96,
			   96,  661,  112,  107,  114,   98,  115,  115,  115,  115,
			  116,  188,   98,  113,  127,  128,  750,  119,  117,  120,
			  120,  120,  120,  129,  130,  160,  198,  102,  131,  131,
			  131,  131,  131,   92,  164,  161,  165,  200,  212,  100,
			   92,  749,  101,  189,  132,  744,  166,  809,  119,  184,
			  120,  120,  120,  120,  133,  185,  808,  162,  199,  102,
			  125,  218,  122,  123,   92,  807,  167,  163,  168,  201, yy_Dummy>>,
			1, 200, 0)
		end

	yy_nxt_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  213,   92,  103,  103,  103,  103,  103,  104,  169,  104,
			  744,  186,  118,  750,  124,  104,  104,  187,  106,  104,
			  104,  125,  220,  219,  122,  123,  189,  104,  104,  104,
			  661,  104,  150,  170,  202,  199,  151,  171,  214,  152,
			  176,  208,  153,  201,  203,  154,  124,  177,  178,  204,
			  172,  209,  215,  179,  221,  213,  219,  221,  189,  104,
			  281,  104,  104,  104,  155,  173,  205,  199,  156,  174,
			  216,  157,  180,  210,  158,  201,  206,  159,  442,  181,
			  182,  207,  175,  211,  217,  183,  442,  213,  219,  221,
			  285,  285,  104,  104,  104,  104,  431,   97,   97,   97,

			   97,  190,  430,   97,   97,  134,  134,  134,  134,  134,
			  104,  191,  104,  192,  429,  162,  428,  193,  104,  104,
			  427,  135,  104,  104,  167,  163,  168,  291,  210,  293,
			  104,  104,  104,  194,  104,  144,  169,  173,  211,  145,
			  205,  174,  186,  195,  146,  196,  147,  162,  187,  197,
			  206,  148,  149,  299,  175,  207,  167,  163,  168,  292,
			  210,  294,  104,  426,  104,  104,  104,  144,  169,  173,
			  211,  145,  205,  174,  186,  425,  146,  424,  147,  423,
			  187,  422,  206,  148,  149,  300,  175,  207,  224,  224,
			  224,  224,  224,  421,  401,  104,  104,  104,  104,  420, yy_Dummy>>,
			1, 200, 200)
		end

	yy_nxt_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			   97,   97,   97,   97,  225,  419,   97,   97,  136,  136,
			  136,  136,  287,  287,  287,  295,  301,  418,  296,  136,
			  136,  137,  136,  136,  136,  138,  136,  136,  136,  136,
			  139,  136,  140,  136,  136,  136,  136,  141,  142,  136,
			  136,  136,  136,  136,  136,  402,  417,  297,  302,  136,
			  298,  143,  143,  144,  143,  143,  143,  145,  143,  143,
			  143,  143,  146,  143,  147,  143,  143,  143,  143,  148,
			  149,  143,  143,  143,  143,  143,  143,  136,  136,  136,
			  136,  658,  658,  303,  292,  662,  662,  294, yy_Dummy>>,
			1, 88, 400)
		end

	yy_nxt_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  100,  304,  292,  101,  136,  294, yy_Dummy>>,
			1, 6, 514)
		end

	yy_nxt_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  155,  180,  216,  300,  156,  194,  416,  157,  181,  182,
			  158,  413,  302,  159,  183,  195,  217,  196,  102,  304,
			  305,  197,  226,  226,  226,  226,  226,  228,  228,  228,
			  228,  228,  155,  180,  216,  300,  156,  194,  227,  157,
			  181,  182,  158,  229,  302,  159,  183,  195,  217,  196,
			  102,  304,  306,  197,  230,  230,  230,  230,  230,  232,
			  232,  232,  232,  232,  234,  234,  234,  234,  234,  239,
			  231,  412,  240,  240,  240,  233,  411,  240,  245,  410,
			  235,  236,  236,  236,  236,  236,  240,  242,  409,  243,
			  240,  297,  241,  246,  298,  236,  241,  237,  246,  249,

			  234,  238,  249,  249,  232,  100,  230,  307,  101,  103,
			  103,  103,  103,  103,  251,  251,  251,  251,  251,  279,
			  279,  279,  279,  297,  309,  250,  298,  241,  311,  313,
			  252,  228,  241,  281,  280,  282,  282,  282,  282,  308,
			  306,  308,  310,  119,  244,  284,  284,  284,  284,  864,
			  283,  289,  289,  289,  289,  102,  310,  312,  241,  314,
			  312,  314,  321,  241,  322,  327,  280,  660,  660,  328,
			  331,  226,  306,  308,  310,  244,  224,  403,  403,  403,
			  403,  403,  283,  659,  659,  659,  125,  102,  323,  312,
			  333,  314,  290,   96,  322,  315,  322,  329,  247,  316, yy_Dummy>>,
			1, 200, 546)
		end

	yy_nxt_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  318,  330,  332,  324,  319,  663,  663,  663,  325,  864,
			  864,  864,  864,  317,  131,  864,  864,  253,  320,  253,
			  325,  335,  334,  326,  332,  253,  253,  318,  103,  253,
			  253,  319,  318,  334,  336,  326,  319,  253,  253,  253,
			  325,  253,  329,  337,  339,  320,  330,  338,  340,  347,
			  320,  349,  348,  336,  353,  326,  332,  354,  355,  341,
			  357,  359,  342,  350,  356,  334,  336,  358,  360,  253,
			  247,  253,  253,  253,  329,  338,  343,  247,  330,  338,
			  344,  348,  247,  351,  348,  351,  354,  285,  285,  354,
			  356,  345,  358,  360,  346,  352,  356,  352,  361,  358,

			  360,  247,  253,  253,  253,  253,  362,  111,  111,  111,
			  111,  379,  864,  111,  111,  257,  247,  351,  258,  259,
			  260,  261,  381,  404,  405,  405,  405,  262,  440,  352,
			  362,  664,  664,  343,  263,  380,  264,  344,  362,  265,
			  266,  267,  268,  380,  269,  247,  270,  382,  345,  375,
			  271,  346,  272,  376,  382,  273,  274,  275,  276,  277,
			  278,  288,  288,  288,  288,  343,  377,  380,  383,  344,
			  378,  247,  288,  288,  288,  288,  288,  288,  241,  382,
			  345,  377,  241,  346,  246,  378,  239,  238,  385,  240,
			  240,  256,  384,  386,  248,  393,   96,  395,  377,  247, yy_Dummy>>,
			1, 200, 746)
		end

	yy_nxt_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  384,  363,  378,  364,  288,  288,  288,  288,  288,  288,
			  253,  365,  253,   95,  366,  394,  367,  368,  253,  253,
			  386,  134,  253,  253,  384,  386,  369,  394,  370,  396,
			  253,  253,  253,  369,  253,  370,  371,  396,  397,  372,
			  387,  373,  374,  371,  241,  388,  372,  394,  373,  374,
			  398,  399,  400,  287,  287,  287,  389,   93,  369,  446,
			  370,  447,  253,  222,  253,  253,  253,  448,  371,  396,
			  398,  372,  390,  373,  374,  241,  390,  391,  449,  126,
			  450,  391,  398,  400,  400,  451,  240,   95,  392,  240,
			  240,  447,  392,  447,  441,  253,  253,  253,  253,  449,

			  111,  111,  111,  111,  285,  285,  111,  111,  390,   94,
			  449,  240,  451,  391,  243,  240,  240,  451,   93,  240,
			  245,  864,  249,  864,  392,  249,  249,  452,  100,  864,
			  864,  101,  406,  406,  406,  406,  406,  407,  407,  407,
			  407,  407,  864,  864,  241,  440,  658,  658,  103,  414,
			  415,  415,  415,  251,  103,  103,  103,  103,  103,  453,
			  251,  251,  251,  251,  251,  432,  432,  432,  432,  244,
			  106,  864,  864,  864,  241,  241,  408,  433,  102,  433,
			  280,  864,  434,  434,  434,  434,  453,  742,  864,  435,
			  435,  435,  435,  458,  119,  864,  439,  439,  439,  439, yy_Dummy>>,
			1, 200, 946)
		end

	yy_nxt_template_8 (an_array: ARRAY [INTEGER])
			-- Fill chunk #8 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  244,  437,  864,  437,  436,  241,  438,  438,  438,  438,
			  102,  443,  280,  444,  444,  444,  444,  864,  453,  445,
			  445,  445,  445,  864,  864,  459,  864,  454,  864,  864,
			  864,  456,  864,  864,  864,  864,  436,  125,  864,  864,
			  459,  460,  461,  462,  455,  463,  464,  465,  457,  466,
			  467,  468,  470,  472,  290,  864,  864,  864,  864,  456,
			  290,  864,  864,  456,  469,  471,  473,  474,  475,  476,
			  477,  864,  459,  461,  461,  463,  457,  463,  465,  465,
			  457,  467,  467,  469,  471,  473,  482,  483,  484,  478,
			  480,  485,  486,  487,  488,  490,  469,  471,  473,  475,

			  475,  477,  477,  479,  481,  492,  493,  489,  491,  494,
			  496,  498,  500,  495,  497,  499,  501,  502,  483,  483,
			  485,  480,  480,  485,  487,  487,  490,  490,  503,  504,
			  506,  505,  507,  508,  509,  481,  481,  493,  493,  491,
			  491,  495,  497,  499,  501,  495,  497,  499,  501,  503,
			  510,  511,  512,  513,  514,  515,  516,  518,  520,  522,
			  503,  505,  507,  505,  507,  509,  509,  528,  517,  519,
			  521,  523,  529,  530,  524,  526,  532,  531,  533,  534,
			  535,  536,  511,  511,  513,  513,  515,  515,  517,  519,
			  521,  523,  525,  527,  537,  538,  539,  540,  541,  529, yy_Dummy>>,
			1, 200, 1146)
		end

	yy_nxt_template_9 (an_array: ARRAY [INTEGER])
			-- Fill chunk #9 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  517,  519,  521,  523,  529,  531,  526,  526,  533,  531,
			  533,  535,  535,  537,  542,  544,  546,  543,  545,  547,
			  548,  549,  550,  551,  527,  527,  537,  539,  539,  541,
			  541,  552,  553,  107,  405,  405,  405,  405,  864,  251,
			  558,  415,  415,  415,  415,  864,  543,  545,  547,  543,
			  545,  547,  549,  549,  551,  551,  107,  405,  405,  405,
			  405,  864,  864,  553,  553,  434,  434,  434,  434,  554,
			  555,  434,  434,  434,  434,  557,  438,  438,  438,  438,
			  864,  864,  562,  864,  864,  563,  563,  563,  563,  662,
			  662,  556,  558,  415,  415,  415,  415,  570,  557,  571,

			  280,  554,  555,  572,  573,  559,  560,  565,  565,  565,
			  565,  438,  438,  438,  438,  287,  287,  287,  864,  864,
			  864,  864,  436,  556,  864,  864,  564,  561,  864,  571,
			  746,  571,  280,  574,  562,  573,  573,  559,  560,  566,
			  575,  566,  576,  577,  567,  567,  567,  567,  568,  578,
			  439,  439,  439,  439,  436,  580,  441,  579,  443,  561,
			  569,  569,  569,  569,  443,  575,  445,  445,  445,  445,
			  581,  582,  575,  583,  577,  577,  584,  585,  586,  587,
			  588,  579,  589,  590,  591,  592,  593,  581,  594,  579,
			  595,  290,  596,  597,  598,  599,  600,  601,  602,  604, yy_Dummy>>,
			1, 200, 1346)
		end

	yy_nxt_template_10 (an_array: ARRAY [INTEGER])
			-- Fill chunk #10 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  603,  290,  581,  583,  605,  583,  606,  290,  585,  585,
			  587,  587,  589,  607,  589,  591,  591,  593,  593,  608,
			  595,  609,  595,  610,  597,  597,  599,  599,  601,  601,
			  603,  605,  603,  611,  612,  613,  605,  614,  607,  615,
			  616,  617,  618,  619,  620,  607,  621,  622,  623,  624,
			  625,  609,  626,  609,  627,  611,  628,  629,  630,  631,
			  632,  633,  634,  635,  636,  611,  613,  613,  637,  615,
			  638,  615,  617,  617,  619,  619,  621,  640,  621,  623,
			  623,  625,  625,  639,  627,  641,  627,  642,  629,  629,
			  631,  631,  633,  633,  635,  635,  637,  643,  644,  645,

			  637,  646,  639,  647,  648,  649,  650,  651,  652,  641,
			  653,  654,  655,  656,  657,  639,  864,  641,  864,  643,
			  405,  405,  405,  405,  665,  665,  665,  665,  672,  643,
			  645,  645,  673,  647,  864,  647,  649,  649,  651,  651,
			  653,  864,  653,  655,  655,  657,  657,  563,  563,  563,
			  563,  667,  667,  667,  667,  668,  668,  668,  668,  674,
			  673,  557,  666,  675,  673,  562,  567,  567,  567,  567,
			  436,  567,  567,  567,  567,  281,  676,  668,  668,  668,
			  668,  677,  671,  678,  445,  445,  445,  445,  679,  680,
			  681,  675,  670,  864,  666,  675,  669,  682,  686,  684, yy_Dummy>>,
			1, 200, 1546)
		end

	yy_nxt_template_11 (an_array: ARRAY [INTEGER])
			-- Fill chunk #11 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  687,  683,  436,  685,  688,  689,  690,  691,  677,  692,
			  693,  694,  695,  677,  696,  679,  697,  698,  699,  700,
			  679,  681,  681,  701,  670,  125,  702,  703,  704,  684,
			  687,  684,  687,  685,  705,  685,  689,  689,  691,  691,
			  706,  693,  693,  695,  695,  707,  697,  708,  697,  699,
			  699,  701,  709,  710,  711,  701,  712,  713,  703,  703,
			  705,  714,  715,  716,  717,  718,  705,  719,  720,  721,
			  722,  723,  707,  724,  725,  726,  727,  707,  728,  709,
			  729,  730,  731,  732,  709,  711,  711,  733,  713,  713,
			  734,  735,  736,  715,  715,  717,  717,  719,  737,  719,

			  721,  721,  723,  723,  738,  725,  725,  727,  727,  739,
			  729,  740,  729,  731,  731,  733,  741,  864,  864,  733,
			  864,  864,  735,  735,  737,  107,  658,  658,  864,  864,
			  737,  107,  659,  659,  659,  864,  739,  745,  662,  662,
			  761,  739,  864,  741,  747,  663,  663,  663,  741,  751,
			  665,  665,  665,  665,  752,  864,  752,  864,  864,  753,
			  753,  753,  753,  754,  754,  754,  754,  742,  668,  668,
			  668,  668,  762,  743,  757,  757,  757,  757,  755,  746,
			  762,  763,  758,  756,  758,  764,  748,  759,  759,  759,
			  759,  562,  281,  765,  757,  757,  757,  757,  766,  767, yy_Dummy>>,
			1, 200, 1746)
		end

	yy_nxt_template_12 (an_array: ARRAY [INTEGER])
			-- Fill chunk #12 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  768,  769,  770,  771,  772,  773,  774,  775,  776,  760,
			  755,  777,  762,  764,  778,  756,  779,  764,  780,  781,
			  782,  783,  784,  785,  786,  766,  787,  788,  789,  790,
			  766,  768,  768,  770,  770,  772,  772,  774,  774,  776,
			  776,  760,  791,  778,  792,  793,  778,  794,  780,  795,
			  780,  782,  782,  784,  784,  786,  786,  796,  788,  788,
			  790,  790,  797,  798,  799,  800,  801,  802,  803,  804,
			  805,  806,  864,  864,  792,  864,  792,  794,  864,  794,
			  864,  796,  659,  659,  659,  663,  663,  663,  864,  796,
			  753,  753,  753,  753,  798,  798,  800,  800,  802,  802,

			  804,  804,  806,  806,  753,  753,  753,  753,  864,  810,
			  810,  810,  810,  811,  864,  811,  864,  864,  812,  812,
			  812,  812,  864,  743,  755,  813,  748,  813,  819,  820,
			  814,  814,  814,  814,  815,  815,  815,  815,  759,  759,
			  759,  759,  759,  759,  759,  759,  817,  821,  817,  816,
			  822,  818,  818,  818,  818,  823,  755,  824,  825,  826,
			  820,  820,  827,  828,  829,  830,  831,  832,  833,  834,
			  835,  836,  837,  838,  839,  840,  841,  842,  843,  822,
			  844,  816,  822,  845,  846,  847,  848,  824,  755,  824,
			  826,  826,  864,  864,  828,  828,  830,  830,  832,  832, yy_Dummy>>,
			1, 200, 1946)
		end

	yy_nxt_template_13 (an_array: ARRAY [INTEGER])
			-- Fill chunk #13 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  834,  834,  836,  836,  838,  838,  840,  840,  842,  842,
			  844,  864,  844,  852,  564,  846,  846,  848,  848,  853,
			  755,  812,  812,  812,  812,  812,  812,  812,  812,  814,
			  814,  814,  814,  814,  814,  814,  814,  849,  849,  849,
			  849,  850,  854,  850,  855,  853,  851,  851,  851,  851,
			  856,  853,  816,  818,  818,  818,  818,  818,  818,  818,
			  818,  857,  858,  859,  860,  861,  816,  851,  851,  851,
			  851,  862,  863,  864,  855,  864,  855,  851,  851,  851,
			  851,  864,  857,  121,  816,  121,  121,  121,  121,  121,
			  864,  864,  669,  857,  859,  859,  861,  861,  816,  864,

			  864,  864,  864,  863,  863,   86,   86,   86,   86,   86,
			   86,   86,   86,   86,   86,   86,   86,   86,   86,   86,
			   86,   86,   86,   97,   97,   97,   97,  143,  143,  143,
			  143,  143,   97,   97,  864,  864,  864,  864,   97,   97,
			   99,  864,   99,   99,   99,   99,   99,   99,   99,   99,
			   99,   99,   99,   99,   99,   99,   99,   99,  105,  105,
			  105,  105,  864,  105,  864,  105,  105,  105,  105,  105,
			  105,  105,  105,  105,  105,  107,  864,  107,  107,  107,
			  107,  107,  107,  107,  107,  107,  107,  107,  107,  107,
			  107,  107,  107,  108,  864,  108,  108,  108,  108,  108, yy_Dummy>>,
			1, 200, 2146)
		end

	yy_nxt_template_14 (an_array: ARRAY [INTEGER])
			-- Fill chunk #14 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  108,  108,  108,  108,  108,  108,  108,  108,  108,  108,
			  108,  111,  286,  286,  286,  286,  286,  111,  111,  864,
			  864,  864,  864,  111,  111,  223,  864,  223,  223,  223,
			  223,  864,  864,  223,  223,  223,  223,  223,  223,  223,
			  223,  864,  223,  238,  238,  864,  238,  238,  238,  238,
			  238,  238,  238,  238,  238,  238,  238,  238,  238,  244,
			  864,  244,  244,  244,  244,  244,  244,  244,  244,  244,
			  244,  244,  244,  244,  244,  244,  244,  107,  864,  107,
			  107,  107,  864,  107,  254,  107,  254,  107,  254,  254,
			  254,  254,  254,  254,  254,  254,  254,  254,  255,  864,

			  255,  255,  255,  255,  255,  255,  255,  255,  255,  255,
			  255,  255,  255,  255,  255,  255,  241,  864,  241,  241,
			  241,  241,  864,  241,  241,  241,  241,  241,  241,  241,
			  241,  241,  241,  241,    5, yy_Dummy>>,
			1, 135, 2346)
		end

	yy_chk_template: SPECIAL [INTEGER]
			-- Template for `yy_chk'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 2584)
			an_array.put (0, 0)
			an_array.area.fill_with (1, 1, 104)
			yy_chk_template_1 (an_array)
			yy_chk_template_2 (an_array)
			an_array.area.fill_with (34, 419, 444)
			yy_chk_template_3 (an_array)
			an_array.area.fill_with (34, 451, 476)
			yy_chk_template_4 (an_array)
			an_array.area.fill_with (35, 488, 513)
			yy_chk_template_5 (an_array)
			an_array.area.fill_with (35, 520, 545)
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
			an_array.area.fill_with (864, 2480, 2584)
			Result := yy_fixed_array (an_array)
		end

	yy_chk_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			    3,    3,   12,    3,    3,   12,    3,    4,    4,   15,
			    4,    4,   15,    4,   11,   11,   11,   11,   11,   16,
			   16,   19,   19,   19,   19,   19,  751,   22,  660,   23,
			   11,   23,   23,   23,   23,   24,   42,   19,   22,   29,
			   29,  750,   26,   24,   26,   26,   26,   26,   31,   31,
			   37,   44,   12,   32,   32,   32,   32,   32,    3,   38,
			   37,   38,   45,   48,  107,    4,  664,  107,   42,   32,
			  660,   38,  749,   25,   41,   25,   25,   25,   25,   32,
			   41,  747,   37,   44,   12,   26,   50,   25,   25,    3,
			  745,   38,   37,   38,   45,   48,    4,   13,   13,   13,

			   13,   13,   13,   38,   13,  744,   41,   24,  664,   25,
			   13,   13,   41,   13,   13,   13,   25,   51,   50,   25,
			   25,   66,   13,   13,   13,  558,   13,   36,   39,   46,
			   68,   36,   39,   49,   36,   40,   47,   36,   69,   46,
			   36,   25,   40,   40,   46,   39,   47,   49,   40,   51,
			   72,   74,   75,   66,   13,  443,   13,   13,   13,   36,
			   39,   46,   68,   36,   39,   49,   36,   40,   47,   36,
			   69,   46,   36,  442,   40,   40,   46,   39,   47,   49,
			   40,  288,   72,   74,   75,  122,  122,   13,   13,   13,
			   13,  278,   13,   13,   13,   13,   43,  277,   13,   13, yy_Dummy>>,
			1, 200, 105)
		end

	yy_chk_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			   33,   33,   33,   33,   33,   33,   43,   33,   43,  276,
			   61,  275,   43,   33,   33,  274,   33,   33,   33,   62,
			   61,   62,  137,   71,  138,   33,   33,   33,   43,   33,
			   58,   62,   63,   71,   58,   70,   63,   65,   43,   58,
			   43,   58,   61,   65,   43,   70,   58,   58,  140,   63,
			   70,   62,   61,   62,  137,   71,  138,   33,  273,   33,
			   33,   33,   58,   62,   63,   71,   58,   70,   63,   65,
			  272,   58,  271,   58,  270,   65,  269,   70,   58,   58,
			  140,   63,   70,   79,   79,   79,   79,   79,  268,  223,
			   33,   33,   33,   33,  267,   33,   33,   33,   33,   79,

			  266,   33,   33,   34,   34,   34,   34,  123,  123,  123,
			  139,  141,  265,  139, yy_Dummy>>,
			1, 114, 305)
		end

	yy_chk_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  223,  264,  139,  141,   34,  139, yy_Dummy>>,
			1, 6, 445)
		end

	yy_chk_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			   35,   35,   35,   35,  554,  554,  142,  144,  559,  559,
			  145, yy_Dummy>>,
			1, 11, 477)
		end

	yy_chk_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			   99,  142,  144,   99,   35,  145, yy_Dummy>>,
			1, 6, 514)
		end

	yy_chk_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			   60,   64,   73,  147,   60,   67,  263,   60,   64,   64,
			   60,  261,  148,   60,   64,   67,   73,   67,   99,  149,
			  150,   67,   80,   80,   80,   80,   80,   81,   81,   81,
			   81,   81,   60,   64,   73,  147,   60,   67,   80,   60,
			   64,   64,   60,   81,  148,   60,   64,   67,   73,   67,
			   99,  149,  150,   67,   82,   82,   82,   82,   82,   83,
			   83,   83,   83,   83,   84,   84,   84,   84,   84,   87,
			   82,  260,   87,   87,   90,   83,  259,   90,   90,  258,
			   84,   85,   85,   85,   85,   85,   89,   89,  257,   89,
			   89,  146,   92,  241,  146,  237,   92,   85,   92,  102,

			  235,   92,  102,  102,  233,  102,  231,  151,  102,  104,
			  104,  104,  104,  104,  105,  105,  105,  105,  105,  115,
			  115,  115,  115,  146,  152,  104,  146,   87,  153,  154,
			  105,  229,   90,  119,  115,  119,  119,  119,  119,  151,
			  155,  156,  157,  120,   89,  120,  120,  120,  120,  125,
			  119,  125,  125,  125,  125,  102,  152,  158,   87,  159,
			  153,  154,  164,   90,  167,  166,  115,  882,  882,  166,
			  170,  227,  155,  156,  157,   89,  225,  247,  247,  247,
			  247,  247,  119,  555,  555,  555,  120,  102,  165,  158,
			  171,  159,  125,  247,  164,  160,  167,  166,  222,  160, yy_Dummy>>,
			1, 200, 546)
		end

	yy_chk_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  162,  166,  170,  165,  162,  560,  560,  560,  168,  105,
			  105,  105,  105,  160,  132,  105,  105,  106,  162,  106,
			  165,  172,  171,  168,  173,  106,  106,  160,  106,  106,
			  106,  160,  162,  174,  175,  165,  162,  106,  106,  106,
			  168,  106,  169,  177,  178,  160,  169,  181,  178,  184,
			  162,  185,  186,  172,  188,  168,  173,  189,  190,  178,
			  191,  192,  178,  185,  194,  174,  175,  195,  196,  106,
			  130,  106,  106,  106,  169,  177,  178,  129,  169,  181,
			  178,  184,  128,  185,  186,  187,  188,  285,  285,  189,
			  190,  178,  191,  192,  178,  185,  194,  187,  198,  195,

			  196,  127,  106,  106,  106,  106,  199,  106,  106,  106,
			  106,  203,  121,  106,  106,  109,  118,  187,  109,  109,
			  109,  109,  204,  248,  248,  248,  248,  109,  285,  187,
			  198,  883,  883,  182,  109,  206,  109,  182,  199,  109,
			  109,  109,  109,  203,  109,  117,  109,  207,  182,  202,
			  109,  182,  109,  202,  204,  109,  109,  109,  109,  109,
			  109,  124,  124,  124,  124,  182,  205,  206,  208,  182,
			  205,  116,  124,  124,  124,  124,  124,  124,  244,  207,
			  182,  202,  244,  182,  244,  202,  239,  244,  209,  239,
			  239,  108,  210,  211,  101,  214,   98,  215,  205,   97, yy_Dummy>>,
			1, 200, 746)
		end

	yy_chk_template_8 (an_array: ARRAY [INTEGER])
			-- Fill chunk #8 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  208,  200,  205,  200,  124,  124,  124,  124,  124,  124,
			  135,  200,  135,   95,  200,  216,  200,  200,  135,  135,
			  209,  135,  135,  135,  210,  211,  201,  214,  201,  215,
			  135,  135,  135,  200,  135,  200,  201,  217,  218,  201,
			  212,  201,  201,  200,  239,  212,  200,  216,  200,  200,
			  219,  220,  221,  287,  287,  287,  212,   93,  201,  291,
			  201,  292,  135,   53,  135,  135,  135,  293,  201,  217,
			  218,  201,  212,  201,  201,  239,  213,  212,  294,   27,
			  295,  213,  219,  220,  221,  297,  240,   10,  212,  240,
			  240,  291,  213,  292,  287,  135,  135,  135,  135,  293,

			  135,  135,  135,  135,  440,  440,  135,  135,  213,    9,
			  294,  243,  295,  213,  243,  243,  245,  297,    7,  245,
			  245,    5,  249,    0,  213,  249,  249,  301,  249,    0,
			    0,  249,  250,  250,  250,  250,  250,  252,  252,  252,
			  252,  252,    0,    0,  240,  440,  742,  742,  250,  262,
			  262,  262,  262,  252,  253,  253,  253,  253,  253,  301,
			  254,  254,  254,  254,  254,  279,  279,  279,  279,  243,
			  253,    0,    0,    0,  245,  240,  254,  280,  249,  280,
			  279,    0,  280,  280,  280,  280,  302,  742,    0,  282,
			  282,  282,  282,  305,  284,    0,  284,  284,  284,  284, yy_Dummy>>,
			1, 200, 946)
		end

	yy_chk_template_9 (an_array: ARRAY [INTEGER])
			-- Fill chunk #9 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  243,  283,    0,  283,  282,  245,  283,  283,  283,  283,
			  249,  289,  279,  289,  289,  289,  289,  290,  302,  290,
			  290,  290,  290,    0,    0,  305,    0,  303,    0,    0,
			    0,  304,  252,  252,  252,  252,  282,  284,  252,  252,
			  306,  307,  308,  309,  303,  310,  311,  312,  304,  313,
			  314,  315,  316,  317,  289,  254,  254,  254,  254,  303,
			  290,  254,  254,  304,  318,  319,  320,  321,  322,  324,
			  326,    0,  306,  307,  308,  309,  303,  310,  311,  312,
			  304,  313,  314,  315,  316,  317,  328,  330,  331,  327,
			  329,  332,  333,  334,  335,  336,  318,  319,  320,  321,

			  322,  324,  326,  327,  329,  337,  338,  335,  336,  339,
			  340,  341,  342,  343,  344,  345,  346,  347,  328,  330,
			  331,  327,  329,  332,  333,  334,  335,  336,  348,  349,
			  350,  351,  352,  353,  354,  327,  329,  337,  338,  335,
			  336,  339,  340,  341,  342,  343,  344,  345,  346,  347,
			  355,  356,  359,  360,  361,  362,  363,  364,  365,  366,
			  348,  349,  350,  351,  352,  353,  354,  368,  369,  370,
			  371,  372,  374,  375,  367,  373,  376,  377,  378,  379,
			  380,  381,  355,  356,  359,  360,  361,  362,  363,  364,
			  365,  366,  367,  373,  382,  383,  384,  385,  386,  368, yy_Dummy>>,
			1, 200, 1146)
		end

	yy_chk_template_10 (an_array: ARRAY [INTEGER])
			-- Fill chunk #10 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  369,  370,  371,  372,  374,  375,  367,  373,  376,  377,
			  378,  379,  380,  381,  387,  388,  389,  390,  391,  392,
			  393,  394,  395,  396,  367,  373,  382,  383,  384,  385,
			  386,  397,  398,  405,  405,  405,  405,  405,    0,  408,
			  415,  415,  415,  415,  415,    0,  387,  388,  389,  390,
			  391,  392,  393,  394,  395,  396,  404,  404,  404,  404,
			  404,    0,    0,  397,  398,  433,  433,  433,  433,  404,
			  404,  434,  434,  434,  434,  405,  437,  437,  437,  437,
			    0,    0,  415,    0,    0,  432,  432,  432,  432,  746,
			  746,  404,  414,  414,  414,  414,  414,  446,  404,  447,

			  432,  404,  404,  448,  449,  414,  414,  435,  435,  435,
			  435,  438,  438,  438,  438,  441,  441,  441,  408,  408,
			  408,  408,  435,  404,  408,  408,  432,  414,    0,  446,
			  746,  447,  432,  450,  414,  448,  449,  414,  414,  436,
			  451,  436,  452,  453,  436,  436,  436,  436,  439,  454,
			  439,  439,  439,  439,  435,  455,  441,  456,  444,  414,
			  444,  444,  444,  444,  445,  450,  445,  445,  445,  445,
			  457,  458,  451,  459,  452,  453,  460,  461,  462,  463,
			  464,  454,  465,  466,  467,  468,  469,  455,  470,  456,
			  471,  439,  472,  473,  474,  475,  476,  477,  478,  479, yy_Dummy>>,
			1, 200, 1346)
		end

	yy_chk_template_11 (an_array: ARRAY [INTEGER])
			-- Fill chunk #11 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  480,  444,  457,  458,  481,  459,  482,  445,  460,  461,
			  462,  463,  464,  483,  465,  466,  467,  468,  469,  484,
			  470,  485,  471,  486,  472,  473,  474,  475,  476,  477,
			  478,  479,  480,  487,  489,  491,  481,  492,  482,  493,
			  494,  495,  496,  497,  498,  483,  499,  500,  501,  504,
			  505,  484,  510,  485,  511,  486,  514,  515,  516,  517,
			  518,  519,  520,  521,  522,  487,  489,  491,  523,  492,
			  524,  493,  494,  495,  496,  497,  498,  525,  499,  500,
			  501,  504,  505,  526,  510,  527,  511,  528,  514,  515,
			  516,  517,  518,  519,  520,  521,  522,  529,  530,  531,

			  523,  532,  524,  533,  536,  537,  542,  543,  544,  525,
			  545,  546,  547,  548,  549,  526,    0,  527,    0,  528,
			  557,  557,  557,  557,  562,  562,  562,  562,  570,  529,
			  530,  531,  571,  532,    0,  533,  536,  537,  542,  543,
			  544,    0,  545,  546,  547,  548,  549,  563,  563,  563,
			  563,  564,  564,  564,  564,  565,  565,  565,  565,  576,
			  570,  557,  563,  577,  571,  562,  566,  566,  566,  566,
			  565,  567,  567,  567,  567,  568,  578,  568,  568,  568,
			  568,  579,  569,  580,  569,  569,  569,  569,  581,  586,
			  587,  576,  568,    0,  563,  577,  565,  588,  590,  589, yy_Dummy>>,
			1, 200, 1546)
		end

	yy_chk_template_12 (an_array: ARRAY [INTEGER])
			-- Fill chunk #12 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  591,  588,  565,  589,  594,  595,  596,  597,  578,  598,
			  599,  600,  601,  579,  602,  580,  603,  604,  605,  606,
			  581,  586,  587,  607,  568,  569,  610,  611,  612,  588,
			  590,  589,  591,  588,  613,  589,  594,  595,  596,  597,
			  614,  598,  599,  600,  601,  615,  602,  616,  603,  604,
			  605,  606,  617,  618,  619,  607,  620,  621,  610,  611,
			  612,  622,  623,  626,  627,  628,  613,  629,  630,  631,
			  632,  633,  614,  634,  635,  636,  637,  615,  638,  616,
			  639,  640,  641,  644,  617,  618,  619,  645,  620,  621,
			  646,  647,  650,  622,  623,  626,  627,  628,  651,  629,

			  630,  631,  632,  633,  652,  634,  635,  636,  637,  653,
			  638,  656,  639,  640,  641,  644,  657,    0,    0,  645,
			    0,    0,  646,  647,  650,  658,  658,  658,    0,    0,
			  651,  659,  659,  659,  659,    0,  652,  662,  662,  662,
			  676,  653,    0,  656,  663,  663,  663,  663,  657,  665,
			  665,  665,  665,  665,  666,    0,  666,    0,    0,  666,
			  666,  666,  666,  667,  667,  667,  667,  658,  668,  668,
			  668,  668,  676,  659,  669,  669,  669,  669,  667,  662,
			  677,  678,  670,  668,  670,  679,  663,  670,  670,  670,
			  670,  665,  671,  680,  671,  671,  671,  671,  681,  683, yy_Dummy>>,
			1, 200, 1746)
		end

	yy_chk_template_13 (an_array: ARRAY [INTEGER])
			-- Fill chunk #13 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  685,  686,  687,  688,  689,  690,  691,  696,  697,  671,
			  667,  700,  677,  678,  701,  668,  702,  679,  703,  706,
			  707,  708,  709,  710,  711,  680,  712,  713,  714,  715,
			  681,  683,  685,  686,  687,  688,  689,  690,  691,  696,
			  697,  671,  716,  700,  717,  718,  701,  719,  702,  720,
			  703,  706,  707,  708,  709,  710,  711,  721,  712,  713,
			  714,  715,  722,  723,  726,  727,  734,  735,  736,  737,
			  740,  741,    0,    0,  716,    0,  717,  718,    0,  719,
			    0,  720,  743,  743,  743,  748,  748,  748,    0,  721,
			  752,  752,  752,  752,  722,  723,  726,  727,  734,  735,

			  736,  737,  740,  741,  753,  753,  753,  753,    0,  754,
			  754,  754,  754,  755,    0,  755,    0,    0,  755,  755,
			  755,  755,    0,  743,  754,  756,  748,  756,  761,  762,
			  756,  756,  756,  756,  757,  757,  757,  757,  758,  758,
			  758,  758,  759,  759,  759,  759,  760,  763,  760,  757,
			  764,  760,  760,  760,  760,  767,  754,  768,  771,  772,
			  761,  762,  773,  774,  775,  776,  777,  778,  783,  784,
			  789,  790,  791,  792,  793,  794,  795,  796,  797,  763,
			  798,  757,  764,  801,  802,  803,  804,  767,  810,  768,
			  771,  772,    0,    0,  773,  774,  775,  776,  777,  778, yy_Dummy>>,
			1, 200, 1946)
		end

	yy_chk_template_14 (an_array: ARRAY [INTEGER])
			-- Fill chunk #14 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  783,  784,  789,  790,  791,  792,  793,  794,  795,  796,
			  797,    0,  798,  821,  810,  801,  802,  803,  804,  822,
			  810,  811,  811,  811,  811,  812,  812,  812,  812,  813,
			  813,  813,  813,  814,  814,  814,  814,  815,  815,  815,
			  815,  816,  827,  816,  828,  821,  816,  816,  816,  816,
			  835,  822,  815,  817,  817,  817,  817,  818,  818,  818,
			  818,  836,  839,  840,  843,  844,  849,  850,  850,  850,
			  850,  854,  855,    0,  827,    0,  828,  851,  851,  851,
			  851,    0,  835,  872,  815,  872,  872,  872,  872,  872,
			    0,    0,  849,  836,  839,  840,  843,  844,  849,    0,

			    0,    0,    0,  854,  855,  865,  865,  865,  865,  865,
			  865,  865,  865,  865,  865,  865,  865,  865,  865,  865,
			  865,  865,  865,  866,  866,  866,  866,  874,  874,  874,
			  874,  874,  866,  866,    0,    0,    0,    0,  866,  866,
			  867,    0,  867,  867,  867,  867,  867,  867,  867,  867,
			  867,  867,  867,  867,  867,  867,  867,  867,  868,  868,
			  868,  868,    0,  868,    0,  868,  868,  868,  868,  868,
			  868,  868,  868,  868,  868,  869,    0,  869,  869,  869,
			  869,  869,  869,  869,  869,  869,  869,  869,  869,  869,
			  869,  869,  869,  870,    0,  870,  870,  870,  870,  870, yy_Dummy>>,
			1, 200, 2146)
		end

	yy_chk_template_15 (an_array: ARRAY [INTEGER])
			-- Fill chunk #15 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  870,  870,  870,  870,  870,  870,  870,  870,  870,  870,
			  870,  871,  880,  880,  880,  880,  880,  871,  871,    0,
			    0,    0,    0,  871,  871,  873,    0,  873,  873,  873,
			  873,    0,    0,  873,  873,  873,  873,  873,  873,  873,
			  873,    0,  873,  875,  875,    0,  875,  875,  875,  875,
			  875,  875,  875,  875,  875,  875,  875,  875,  875,  876,
			    0,  876,  876,  876,  876,  876,  876,  876,  876,  876,
			  876,  876,  876,  876,  876,  876,  876,  877,    0,  877,
			  877,  877,    0,  877,  878,  877,  878,  877,  878,  878,
			  878,  878,  878,  878,  878,  878,  878,  878,  879,    0,

			  879,  879,  879,  879,  879,  879,  879,  879,  879,  879,
			  879,  879,  879,  879,  879,  879,  881,    0,  881,  881,
			  881,  881,    0,  881,  881,  881,  881,  881,  881,  881,
			  881,  881,  881,  881, yy_Dummy>>,
			1, 134, 2346)
		end

	yy_base_template: SPECIAL [INTEGER]
			-- Template for `yy_base'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 883)
			yy_base_template_1 (an_array)
			yy_base_template_2 (an_array)
			yy_base_template_3 (an_array)
			yy_base_template_4 (an_array)
			yy_base_template_5 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_base_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			    0,    0,    0,  104,  111, 1067, 2480, 1063, 2480, 1053,
			 1028,  118,  100,  201, 2480,  107,  114, 2480, 2480,  125,
			    0, 2480,  115,  116,  121,  160,  129,  998, 2480,  118,
			    0,  126,  157,  304,  388,  457,  194,  120,  122,  202,
			  204,  140,   96,  269,  108,  132,  199,  203,  124,  207,
			  153,  177, 2480,  951, 2480,    0,    0,    0,  302,    0,
			  508,  280,  282,  306,  511,  303,  181,  519,  187,  208,
			  305,  290,  211,  517,  218,  212, 2480, 2480,    0,  387,
			  567,  572,  599,  604,  609,  626,    0,  614, 2480,  631,
			  619, 2480,  637, 1002, 2480,  954, 2480,  928,  925,  507,

			 2480,  921,  644, 2480,  654,  659,  757,  162,  926,  854,
			    0,    0, 2480,    0, 2480,  645,  900,  874,  845,  661,
			  671,  840,  270,  392,  887,  677, 2480,  830,  811,  806,
			  799, 2480,  743, 2480, 2480,  950,    0,  279,  294,  376,
			  319,  367,  433,    0,  436,  452,  598,  515,  509,  515,
			  531,  622,  626,  639,  627,  651,  656,  644,  668,  657,
			  709,    0,  714,    0,  659,  700,  665,  661,  720,  742,
			  674,  705,  722,  728,  748,  735,    0,  743,  756,    0,
			    0,  747,  845,    0,  754,  764,  757,  798,  750,  753,
			  755,  772,  774,    0,  761,  779,  781,    0,  809,  817, yy_Dummy>>,
			1, 200, 0)
		end

	yy_base_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			  913,  938,  853,  814,  820,  870,  838,  845,  879,  883,
			  903,  888,  952,  988,  893,  904,  913,  944,  949,  961,
			  949,  950,  727,  383, 2480,  705, 2480,  700, 2480,  660,
			 2480,  635, 2480,  633, 2480,  629, 2480,  624,    0,  931,
			 1031,  632, 2480, 1056,  923, 1061, 2480,  722,  849, 1067,
			 1077, 2480, 1082, 1099, 1105, 2480, 2480,  623,  614,  611,
			  606,  546, 1075,  541,  435,  406,  394,  388,  382,  370,
			  368,  366,  364,  352,  309,  305,  303,  291,  285, 1091,
			 1108, 2480, 1115, 1132, 1122,  813,    0,  979,  225, 1139,
			 1145,  960,  962,  969,  980,  995,    0, 1000,    0,    0,

			    0, 1034, 1093, 1142, 1146, 1106, 1153, 1138, 1139, 1137,
			 1139, 1161, 1162, 1147, 1148, 1146, 1163, 1168, 1159, 1176,
			 1181, 1178, 1179,    0, 1164,    0, 1165, 1204, 1197, 1205,
			 1198, 1185, 1188, 1188, 1189, 1197, 1198, 1209, 1210, 1220,
			 1221, 1211, 1227, 1224, 1225, 1215, 1231, 1228, 1239, 1244,
			 1230, 1246, 1232, 1244, 1245, 1251, 1252,    0,    0, 1263,
			 1264, 1267, 1268, 1267, 1268, 1273, 1254, 1287, 1265, 1279,
			 1280, 1285, 1266, 1288, 1270, 1284, 1291, 1288, 1293, 1290,
			 1291, 1288, 1301, 1297, 1298, 1308, 1309, 1325, 1314, 1323,
			 1328, 1317, 1326, 1327, 1328, 1334, 1335, 1333, 1334,    0, yy_Dummy>>,
			1, 200, 200)
		end

	yy_base_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			    0, 2480, 2480, 2480, 1383, 1360, 2480, 2480, 1368, 2480,
			 2480, 2480, 2480, 2480, 1419, 1367, 2480, 2480, 2480, 2480,
			 2480, 2480, 2480, 2480, 2480, 2480, 2480, 2480, 2480, 2480,
			 2480, 2480, 1411, 1391, 1397, 1433, 1470, 1402, 1437, 1476,
			 1030, 1441,  217,  242, 1486, 1492, 1394, 1396, 1399, 1400,
			 1430, 1437, 1451, 1452, 1462, 1462, 1470, 1477, 1476, 1478,
			 1473, 1474, 1489, 1490, 1476, 1478, 1494, 1495, 1494, 1495,
			 1486, 1488, 1505, 1506, 1501, 1502, 1494, 1495, 1500, 1497,
			 1502, 1502, 1504, 1511, 1530, 1532, 1518, 1528,    0, 1545,
			    0, 1546, 1544, 1546, 1532, 1533, 1540, 1541, 1555, 1557,

			 1545, 1546,    0,    0, 1553, 1554,    0,    0,    0,    0,
			 1556, 1558,    0,    0, 1551, 1552, 1568, 1569, 1558, 1559,
			 1565, 1566, 1571, 1575, 1565, 1581, 1578, 1589, 1578, 1588,
			 1611, 1612, 1599, 1601,    0,    0, 1604, 1605,    0,    0,
			    0,    0, 1616, 1617, 1603, 1605, 1615, 1616, 1628, 1629,
			    0,    0,    0,    0,  461,  709,    0, 1646,  219,  465,
			  731,    0, 1650, 1673, 1677, 1681, 1692, 1697, 1703, 1710,
			 1625, 1629,    0,    0,    0,    0, 1661, 1665, 1684, 1689,
			 1697, 1702,    0,    0,    0,    0, 1687, 1688, 1708, 1710,
			 1700, 1702,    0,    0, 1702, 1703, 1714, 1715, 1719, 1720, yy_Dummy>>,
			1, 200, 400)
		end

	yy_base_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			 1722, 1723, 1726, 1728, 1713, 1714, 1721, 1725,    0,    0,
			 1724, 1725, 1730, 1736, 1751, 1756, 1754, 1759, 1760, 1761,
			 1769, 1770, 1768, 1769,    0,    0, 1774, 1775, 1763, 1765,
			 1775, 1776, 1781, 1782, 1784, 1785, 1773, 1774, 1789, 1791,
			 1777, 1778,    0,    0, 1779, 1783, 1805, 1806,    0,    0,
			 1799, 1805, 1815, 1820,    0,    0, 1813, 1818, 1852, 1858,
			  114, 2480, 1864, 1871,  152, 1876, 1885, 1889, 1894, 1900,
			 1913, 1920,    0,    0,    0,    0, 1851, 1891, 1876, 1880,
			 1889, 1894,    0, 1900,    0, 1901, 1897, 1898, 1914, 1915,
			 1920, 1921,    0,    0,    0,    0, 1918, 1919,    0,    0,

			 1926, 1929, 1927, 1929,    0,    0, 1916, 1917, 1923, 1924,
			 1919, 1920, 1922, 1923, 1943, 1944, 1938, 1940, 1942, 1944,
			 1951, 1959, 1964, 1965,    0,    0, 1975, 1976,    0,    0,
			    0,    0,    0,    0, 1962, 1963, 1970, 1971,    0,    0,
			 1966, 1967, 1072, 2008,  149,  184, 1415,  175, 2011,  166,
			   85,  120, 2016, 2030, 2035, 2044, 2056, 2060, 2064, 2068,
			 2077, 2040, 2041, 2043, 2046,    0,    0, 2057, 2059,    0,
			    0, 2070, 2071, 2076, 2077, 2076, 2077, 2070, 2071,    0,
			    0,    0,    0, 2077, 2078,    0,    0,    0,    0, 2072,
			 2073, 2083, 2084, 2075, 2076, 2087, 2088, 2091, 2093,    0, yy_Dummy>>,
			1, 200, 600)
		end

	yy_base_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			    0, 2094, 2095, 2096, 2097,    0,    0, 2480, 2480, 2480,
			 2099, 2147, 2151, 2155, 2159, 2163, 2172, 2179, 2183,    0,
			    0, 2124, 2130,    0,    0,    0,    0, 2146, 2148,    0,
			    0,    0,    0,    0,    0, 2146, 2157,    0,    0, 2160,
			 2161,    0,    0, 2175, 2176,    0,    0,    0,    0, 2177,
			 2193, 2203,    0,    0, 2182, 2183,    0,    0,    0,    0,
			    0,    0,    0,    0, 2480, 2250, 2268, 2285, 2303, 2320,
			 2338, 2353, 2219, 2370, 2261, 2386, 2404, 2418, 2426, 2443,
			 2346, 2461,  701,  865, yy_Dummy>>,
			1, 84, 800)
		end

	yy_def_template: SPECIAL [INTEGER]
			-- Template for `yy_def'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 883)
			yy_def_template_1 (an_array)
			yy_def_template_2 (an_array)
			an_array.area.fill_with (864, 255, 283)
			yy_def_template_3 (an_array)
			an_array.area.fill_with (864, 409, 438)
			yy_def_template_4 (an_array)
			yy_def_template_5 (an_array)
			yy_def_template_6 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_def_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			    0,  864,    1,  865,  865,  864,  864,  864,  864,  864,
			  864,  866,  867,  868,  864,  869,  870,  864,  864,  866,
			   19,  864,  871,  864,   19,  872,  872,  864,  864,   19,
			   19,   19,  864,  868,  864,  864,   35,   35,   35,   35,
			   35,   35,   35,   35,   35,   35,   35,   35,   35,   35,
			   35,   35,  864,   19,  864,   19,   19,  873,  874,  874,
			  874,  874,  874,  874,  874,  874,  874,  874,  874,  874,
			  874,  874,  874,  874,  874,  874,  864,  864,   19,   19,
			   79,   80,  864,  864,   81,   84,  875,  864,  864,  875,
			  864,  864,  876,  864,  864,  864,  864,   19,  871,  867,

			  864,  877,  867,  864,   33,  868,  878,  869,  879,  879,
			  879,   19,  864,   19,  864,  864,   19,   19,   19,  864,
			  872,  872,  880,  880,  880,  872,  864,   19,   19,   19,
			   19,  864,  864,  864,  864,  878,   35,   35,   35,   35,
			   35,   35,   35,  874,  874,  874,  874,  874,  874,  874,
			   35,   35,   35,   35,   35,  874,  874,  874,  874,  874,
			   35,   35,  874,  874,   35,   35,   35,  874,  874,  874,
			   35,   35,   35,  874,  874,  874,   35,   35,   35,   35,
			  874,  874,  874,  874,   35,   35,  874,  874,   35,  874,
			   35,   35,   35,   35,  874,  874,  874,  874,   35,  874, yy_Dummy>>,
			1, 200, 0)
		end

	yy_def_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			   35,  874,   35,   35,   35,  874,  874,  874,   35,   35,
			  874,  874,   35,  874,   35,   35,  874,  874,   35,  874,
			   35,  874,   19,  873,  864,  871,  864,  871,  864,  871,
			  864,  864,  864,  864,  864,  871,  864,  871,  875,  864,
			  864,  881,  864,  875,  876,  864,  864,  871,  864,  867,
			  135,  864,  878,   33,  868, yy_Dummy>>,
			1, 55, 200)
		end

	yy_def_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  872,  880,  880,  880,  124,  872,  872,   35,  874,   35,
			  874,   35,   35,  874,  874,   35,  874,   35,  874,   35,
			  874,   35,  874,   35,  874,   35,  874,   35,  874,   35,
			  874,   35,   35,   35,  874,  874,  874,   35,  874,   35,
			   35,  874,  874,   35,   35,  874,  874,   35,  874,   35,
			  874,   35,  874,   35,  874,   35,   35,   35,   35,  874,
			  874,  874,  874,   35,  874,   35,   35,  874,  874,   35,
			  874,   35,  874,   35,  874,   35,  874,   35,  874,   35,
			   35,   35,   35,   35,   35,  874,  874,  874,  874,  874,
			  874,   35,   35,  874,  874,   35,  874,   35,  874,   35,

			  874,   35,  874,   35,   35,   35,  874,  874,  874,   35,
			  874,   35,  874,   35,  874,   35,  874,  864,  864,  864,
			  864,  864,  864,  864,  878, yy_Dummy>>,
			1, 125, 284)
		end

	yy_def_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  872,  880,  880,  124,  864,  872,  872,   35,  874,   35,
			  874,   35,  874,   35,  874,   35,   35,  874,  874,   35,
			  874,   35,  874,   35,  874,   35,  874,   35,  874,   35,
			  874,   35,  874,   35,  874,   35,  874,   35,  874,   35,
			   35,  874,  874,   35,  874,   35,  874,   35,  874,   35,
			   35,  874,  874,   35,  874,   35,  874,   35,  874,   35,
			  874,   35,  874,   35,  874,   35,  874,   35,  874,   35,
			  874,   35,  874,   35,  874,   35,  874,   35,  874,   35,
			  874,   35,  874,   35,  874,   35,   35,  874,  874,   35,
			  874,   35,  874,   35,  874,   35,  874,   35,  874,   35,

			  874,   35,  874,   35,  874,   35,  874,   35,  874,   35,
			  874,   35,  874,   35,  874,  864,  864,  882,  864,  864,
			  864,  864,  883,  864,  864,  864,  864,  864,  864,  864,
			  872,   35,  874,   35,  874,   35,  874,   35,  874,   35,
			  874,   35,  874,   35,  874,   35,  874,   35,  874,   35,
			  874,   35,  874,   35,  874,   35,  874,   35,  874,   35,
			  874,   35,  874,   35,  874,   35,  874,   35,  874,   35,
			  874,   35,  874,   35,  874,   35,  874,   35,  874,   35,
			  874,   35,  874,   35,  874,   35,  874,   35,  874,   35,
			  874,   35,  874,   35,  874,   35,  874,   35,  874,   35, yy_Dummy>>,
			1, 200, 439)
		end

	yy_def_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  874,   35,  874,   35,  874,   35,  874,   35,  874,   35,
			  874,   35,  874,   35,  874,   35,  874,   35,  874,  864,
			  864,  882,  864,  864,  864,  883,  864,  864,  864,  864,
			  864,  864,  864,   35,  874,   35,  874,   35,  874,   35,
			  874,   35,  874,   35,   35,  874,  874,   35,  874,   35,
			  874,   35,  874,   35,  874,   35,  874,   35,  874,   35,
			  874,   35,  874,   35,  874,   35,  874,   35,  874,   35,
			  874,   35,  874,   35,  874,   35,  874,   35,  874,   35,
			  874,   35,  874,   35,  874,   35,  874,   35,  874,   35,
			  874,   35,  874,   35,  874,   35,  874,   35,  874,   35,

			  874,   35,  874,  864,  864,  882,  864,  864,  864,  864,
			  864,  883,  864,  864,  864,  864,  864,  864,  864,  864,
			  864,  864,   35,  874,   35,  874,   35,  874,   35,  874,
			   35,  874,   35,  874,   35,  874,   35,  874,   35,  874,
			   35,  874,   35,  874,   35,  874,   35,  874,   35,  874,
			   35,  874,   35,  874,   35,  874,   35,  874,   35,  874,
			   35,  874,   35,  874,   35,  874,   35,  874,  864,  864,
			  864,  864,  864,  864,  864,  864,  864,  864,  864,  864,
			   35,  874,   35,  874,   35,  874,   35,  874,   35,  874,
			   35,  874,   35,  874,   35,  874,   35,  874,   35,  874, yy_Dummy>>,
			1, 200, 639)
		end

	yy_def_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			   35,  874,   35,  874,   35,  874,   35,  874,   35,  874,
			  864,  864,  864,   35,  874,   35,  874,   35,  874,   35,
			  874,   35,  874,   35,  874,    0,  864,  864,  864,  864,
			  864,  864,  864,  864,  864,  864,  864,  864,  864,  864,
			  864,  864,  864,  864,  864, yy_Dummy>>,
			1, 45, 839)
		end

	yy_ec_template: SPECIAL [INTEGER]
			-- Template for `yy_ec'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 127948)
			yy_ec_template_1 (an_array)
			an_array.area.fill_with (104, 127, 159)
			yy_ec_template_2 (an_array)
			an_array.area.fill_with (95, 216, 246)
			yy_ec_template_3 (an_array)
			an_array.area.fill_with (104, 256, 705)
			yy_ec_template_4 (an_array)
			an_array.area.fill_with (104, 768, 884)
			yy_ec_template_5 (an_array)
			an_array.area.fill_with (104, 904, 1013)
			an_array.put (97, 1014)
			an_array.area.fill_with (104, 1015, 1153)
			an_array.put (97, 1154)
			an_array.area.fill_with (104, 1155, 1369)
			an_array.area.fill_with (97, 1370, 1375)
			an_array.area.fill_with (104, 1376, 1416)
			yy_ec_template_6 (an_array)
			an_array.area.fill_with (104, 1424, 1469)
			yy_ec_template_7 (an_array)
			an_array.area.fill_with (104, 1479, 1522)
			yy_ec_template_8 (an_array)
			an_array.area.fill_with (104, 1568, 1641)
			an_array.area.fill_with (97, 1642, 1645)
			an_array.area.fill_with (104, 1646, 1747)
			yy_ec_template_9 (an_array)
			an_array.area.fill_with (104, 1806, 2037)
			yy_ec_template_10 (an_array)
			an_array.area.fill_with (104, 2048, 2095)
			an_array.area.fill_with (97, 2096, 2110)
			an_array.area.fill_with (104, 2111, 2141)
			an_array.put (97, 2142)
			an_array.area.fill_with (104, 2143, 2403)
			yy_ec_template_11 (an_array)
			an_array.area.fill_with (104, 2417, 2545)
			yy_ec_template_12 (an_array)
			an_array.area.fill_with (104, 2558, 2677)
			an_array.put (97, 2678)
			an_array.area.fill_with (104, 2679, 2799)
			an_array.area.fill_with (97, 2800, 2801)
			an_array.area.fill_with (104, 2802, 2927)
			an_array.put (97, 2928)
			an_array.area.fill_with (104, 2929, 3058)
			an_array.area.fill_with (97, 3059, 3066)
			an_array.area.fill_with (104, 3067, 3190)
			yy_ec_template_13 (an_array)
			an_array.area.fill_with (104, 3205, 3406)
			an_array.put (97, 3407)
			an_array.area.fill_with (104, 3408, 3448)
			an_array.put (97, 3449)
			an_array.area.fill_with (104, 3450, 3571)
			an_array.put (97, 3572)
			an_array.area.fill_with (104, 3573, 3646)
			yy_ec_template_14 (an_array)
			an_array.area.fill_with (104, 3676, 3840)
			yy_ec_template_15 (an_array)
			an_array.area.fill_with (104, 3897, 3972)
			an_array.put (97, 3973)
			an_array.area.fill_with (104, 3974, 4029)
			yy_ec_template_16 (an_array)
			an_array.area.fill_with (104, 4059, 4169)
			an_array.area.fill_with (97, 4170, 4175)
			an_array.area.fill_with (104, 4176, 4253)
			an_array.area.fill_with (97, 4254, 4255)
			an_array.area.fill_with (104, 4256, 4346)
			an_array.put (97, 4347)
			an_array.area.fill_with (104, 4348, 4959)
			an_array.area.fill_with (97, 4960, 4968)
			an_array.area.fill_with (104, 4969, 5007)
			an_array.area.fill_with (97, 5008, 5017)
			an_array.area.fill_with (104, 5018, 5119)
			an_array.put (97, 5120)
			an_array.area.fill_with (104, 5121, 5740)
			yy_ec_template_17 (an_array)
			an_array.area.fill_with (104, 5761, 5866)
			an_array.area.fill_with (97, 5867, 5869)
			an_array.area.fill_with (104, 5870, 5940)
			an_array.area.fill_with (97, 5941, 5942)
			an_array.area.fill_with (104, 5943, 6099)
			yy_ec_template_18 (an_array)
			an_array.area.fill_with (104, 6108, 6143)
			an_array.area.fill_with (97, 6144, 6154)
			an_array.area.fill_with (104, 6155, 6463)
			yy_ec_template_19 (an_array)
			an_array.area.fill_with (104, 6470, 6621)
			an_array.area.fill_with (97, 6622, 6655)
			an_array.area.fill_with (104, 6656, 6685)
			an_array.area.fill_with (97, 6686, 6687)
			an_array.area.fill_with (104, 6688, 6815)
			yy_ec_template_20 (an_array)
			an_array.area.fill_with (104, 6830, 7001)
			yy_ec_template_21 (an_array)
			an_array.area.fill_with (104, 7037, 7163)
			an_array.area.fill_with (97, 7164, 7167)
			an_array.area.fill_with (104, 7168, 7226)
			an_array.area.fill_with (97, 7227, 7231)
			an_array.area.fill_with (104, 7232, 7293)
			an_array.area.fill_with (97, 7294, 7295)
			an_array.area.fill_with (104, 7296, 7359)
			yy_ec_template_22 (an_array)
			an_array.area.fill_with (104, 7380, 8124)
			yy_ec_template_23 (an_array)
			an_array.area.fill_with (104, 8288, 8313)
			yy_ec_template_24 (an_array)
			an_array.area.fill_with (97, 8352, 8383)
			an_array.area.fill_with (104, 8384, 8447)
			yy_ec_template_25 (an_array)
			an_array.area.fill_with (104, 8528, 8585)
			yy_ec_template_26 (an_array)
			an_array.area.fill_with (97, 8592, 8703)
			yy_ec_template_27 (an_array)
			an_array.area.fill_with (97, 8708, 8967)
			an_array.area.fill_with (104, 8968, 8971)
			an_array.area.fill_with (97, 8972, 9000)
			an_array.area.fill_with (104, 9001, 9002)
			an_array.area.fill_with (97, 9003, 9254)
			an_array.area.fill_with (104, 9255, 9279)
			an_array.area.fill_with (97, 9280, 9290)
			an_array.area.fill_with (104, 9291, 9371)
			an_array.area.fill_with (97, 9372, 9449)
			an_array.area.fill_with (104, 9450, 9471)
			an_array.area.fill_with (97, 9472, 10087)
			an_array.area.fill_with (104, 10088, 10131)
			an_array.area.fill_with (97, 10132, 10180)
			an_array.area.fill_with (104, 10181, 10182)
			an_array.area.fill_with (97, 10183, 10213)
			yy_ec_template_28 (an_array)
			an_array.area.fill_with (97, 10228, 10626)
			an_array.area.fill_with (104, 10627, 10648)
			an_array.area.fill_with (97, 10649, 10711)
			an_array.area.fill_with (104, 10712, 10715)
			an_array.area.fill_with (97, 10716, 10747)
			an_array.area.fill_with (104, 10748, 10749)
			an_array.area.fill_with (97, 10750, 11123)
			an_array.area.fill_with (104, 11124, 11125)
			an_array.area.fill_with (97, 11126, 11157)
			an_array.put (104, 11158)
			an_array.area.fill_with (97, 11159, 11263)
			an_array.area.fill_with (104, 11264, 11492)
			yy_ec_template_29 (an_array)
			an_array.area.fill_with (104, 11520, 11631)
			an_array.put (97, 11632)
			an_array.area.fill_with (104, 11633, 11775)
			yy_ec_template_30 (an_array)
			an_array.area.fill_with (104, 11859, 11903)
			an_array.area.fill_with (97, 11904, 11929)
			an_array.put (104, 11930)
			an_array.area.fill_with (97, 11931, 12019)
			an_array.area.fill_with (104, 12020, 12031)
			an_array.area.fill_with (97, 12032, 12245)
			an_array.area.fill_with (104, 12246, 12271)
			yy_ec_template_31 (an_array)
			an_array.area.fill_with (104, 12352, 12442)
			yy_ec_template_32 (an_array)
			an_array.area.fill_with (104, 12449, 12538)
			an_array.put (97, 12539)
			an_array.area.fill_with (104, 12540, 12687)
			yy_ec_template_33 (an_array)
			an_array.area.fill_with (104, 12704, 12735)
			an_array.area.fill_with (97, 12736, 12771)
			an_array.area.fill_with (104, 12772, 12799)
			an_array.area.fill_with (97, 12800, 12830)
			an_array.area.fill_with (104, 12831, 12841)
			an_array.area.fill_with (97, 12842, 12871)
			yy_ec_template_34 (an_array)
			an_array.area.fill_with (97, 12896, 12927)
			an_array.area.fill_with (104, 12928, 12937)
			an_array.area.fill_with (97, 12938, 12976)
			an_array.area.fill_with (104, 12977, 12991)
			an_array.area.fill_with (97, 12992, 13311)
			an_array.area.fill_with (104, 13312, 19903)
			an_array.area.fill_with (97, 19904, 19967)
			an_array.area.fill_with (104, 19968, 42127)
			an_array.area.fill_with (97, 42128, 42182)
			an_array.area.fill_with (104, 42183, 42237)
			an_array.area.fill_with (97, 42238, 42239)
			an_array.area.fill_with (104, 42240, 42508)
			an_array.area.fill_with (97, 42509, 42511)
			an_array.area.fill_with (104, 42512, 42610)
			yy_ec_template_35 (an_array)
			an_array.area.fill_with (104, 42623, 42737)
			yy_ec_template_36 (an_array)
			an_array.area.fill_with (104, 42786, 42888)
			an_array.area.fill_with (96, 42889, 42890)
			an_array.area.fill_with (104, 42891, 43047)
			yy_ec_template_37 (an_array)
			an_array.area.fill_with (104, 43066, 43123)
			an_array.area.fill_with (97, 43124, 43127)
			an_array.area.fill_with (104, 43128, 43213)
			an_array.area.fill_with (97, 43214, 43215)
			an_array.area.fill_with (104, 43216, 43255)
			yy_ec_template_38 (an_array)
			an_array.area.fill_with (104, 43261, 43309)
			an_array.area.fill_with (97, 43310, 43311)
			an_array.area.fill_with (104, 43312, 43358)
			an_array.put (97, 43359)
			an_array.area.fill_with (104, 43360, 43456)
			yy_ec_template_39 (an_array)
			an_array.area.fill_with (104, 43488, 43611)
			yy_ec_template_40 (an_array)
			an_array.area.fill_with (104, 43642, 43741)
			yy_ec_template_41 (an_array)
			an_array.area.fill_with (104, 43762, 43866)
			yy_ec_template_42 (an_array)
			an_array.area.fill_with (104, 43884, 44010)
			an_array.put (97, 44011)
			an_array.area.fill_with (104, 44012, 62248)
			an_array.put (97, 62249)
			an_array.area.fill_with (104, 62250, 62385)
			an_array.area.fill_with (96, 62386, 62401)
			an_array.area.fill_with (104, 62402, 62971)
			yy_ec_template_43 (an_array)
			an_array.area.fill_with (104, 63084, 63232)
			yy_ec_template_44 (an_array)
			an_array.area.fill_with (104, 63265, 63291)
			yy_ec_template_45 (an_array)
			an_array.area.fill_with (104, 63297, 63323)
			yy_ec_template_46 (an_array)
			an_array.area.fill_with (104, 63334, 63455)
			yy_ec_template_47 (an_array)
			an_array.area.fill_with (104, 63486, 63743)
			an_array.area.fill_with (97, 63744, 63746)
			an_array.area.fill_with (104, 63747, 63798)
			an_array.area.fill_with (97, 63799, 63807)
			an_array.area.fill_with (104, 63808, 63864)
			yy_ec_template_48 (an_array)
			an_array.area.fill_with (104, 63905, 63951)
			an_array.area.fill_with (97, 63952, 63996)
			an_array.area.fill_with (104, 63997, 64414)
			an_array.put (97, 64415)
			an_array.area.fill_with (104, 64416, 64463)
			an_array.put (97, 64464)
			an_array.area.fill_with (104, 64465, 64878)
			an_array.put (97, 64879)
			an_array.area.fill_with (104, 64880, 65622)
			an_array.put (97, 65623)
			an_array.area.fill_with (104, 65624, 65654)
			an_array.area.fill_with (97, 65655, 65656)
			an_array.area.fill_with (104, 65657, 65822)
			an_array.put (97, 65823)
			an_array.area.fill_with (104, 65824, 65854)
			an_array.put (97, 65855)
			an_array.area.fill_with (104, 65856, 66127)
			an_array.area.fill_with (97, 66128, 66136)
			an_array.area.fill_with (104, 66137, 66174)
			an_array.put (97, 66175)
			an_array.area.fill_with (104, 66176, 66247)
			an_array.put (97, 66248)
			an_array.area.fill_with (104, 66249, 66287)
			an_array.area.fill_with (97, 66288, 66294)
			an_array.area.fill_with (104, 66295, 66360)
			an_array.area.fill_with (97, 66361, 66367)
			an_array.area.fill_with (104, 66368, 66456)
			an_array.area.fill_with (97, 66457, 66460)
			an_array.area.fill_with (104, 66461, 67244)
			an_array.put (97, 67245)
			an_array.area.fill_with (104, 67246, 67412)
			an_array.area.fill_with (97, 67413, 67417)
			an_array.area.fill_with (104, 67418, 67654)
			an_array.area.fill_with (97, 67655, 67661)
			an_array.area.fill_with (104, 67662, 67770)
			yy_ec_template_49 (an_array)
			an_array.area.fill_with (104, 67778, 67903)
			an_array.area.fill_with (97, 67904, 67907)
			an_array.area.fill_with (104, 67908, 67955)
			an_array.area.fill_with (97, 67956, 67957)
			an_array.area.fill_with (104, 67958, 68036)
			yy_ec_template_50 (an_array)
			an_array.area.fill_with (104, 68064, 68151)
			an_array.area.fill_with (97, 68152, 68157)
			an_array.area.fill_with (104, 68158, 68264)
			an_array.put (97, 68265)
			an_array.area.fill_with (104, 68266, 68682)
			yy_ec_template_51 (an_array)
			an_array.area.fill_with (104, 68702, 68805)
			an_array.put (97, 68806)
			an_array.area.fill_with (104, 68807, 69056)
			an_array.area.fill_with (97, 69057, 69079)
			an_array.area.fill_with (104, 69080, 69184)
			an_array.area.fill_with (97, 69185, 69187)
			an_array.area.fill_with (104, 69188, 69215)
			an_array.area.fill_with (97, 69216, 69228)
			an_array.area.fill_with (104, 69229, 69435)
			an_array.area.fill_with (97, 69436, 69439)
			an_array.area.fill_with (104, 69440, 69690)
			an_array.put (97, 69691)
			an_array.area.fill_with (104, 69692, 69955)
			an_array.area.fill_with (97, 69956, 69958)
			an_array.area.fill_with (104, 69959, 70113)
			an_array.put (97, 70114)
			an_array.area.fill_with (104, 70115, 70206)
			an_array.area.fill_with (97, 70207, 70214)
			an_array.area.fill_with (104, 70215, 70297)
			yy_ec_template_52 (an_array)
			an_array.area.fill_with (104, 70307, 70720)
			an_array.area.fill_with (97, 70721, 70725)
			an_array.area.fill_with (104, 70726, 70767)
			an_array.area.fill_with (97, 70768, 70769)
			an_array.area.fill_with (104, 70770, 71414)
			an_array.area.fill_with (97, 71415, 71416)
			an_array.area.fill_with (104, 71417, 71636)
			an_array.area.fill_with (97, 71637, 71665)
			yy_ec_template_53 (an_array)
			an_array.area.fill_with (104, 71680, 72815)
			an_array.area.fill_with (97, 72816, 72820)
			an_array.area.fill_with (104, 72821, 90733)
			an_array.area.fill_with (97, 90734, 90735)
			an_array.area.fill_with (104, 90736, 90868)
			an_array.put (97, 90869)
			an_array.area.fill_with (104, 90870, 90934)
			yy_ec_template_54 (an_array)
			an_array.area.fill_with (104, 90950, 91798)
			an_array.area.fill_with (97, 91799, 91802)
			an_array.area.fill_with (104, 91803, 92129)
			an_array.put (97, 92130)
			an_array.area.fill_with (104, 92131, 111771)
			yy_ec_template_55 (an_array)
			an_array.area.fill_with (104, 111776, 116735)
			an_array.area.fill_with (97, 116736, 116981)
			an_array.area.fill_with (104, 116982, 116991)
			an_array.area.fill_with (97, 116992, 117030)
			an_array.area.fill_with (104, 117031, 117032)
			an_array.area.fill_with (97, 117033, 117092)
			yy_ec_template_56 (an_array)
			an_array.area.fill_with (97, 117132, 117161)
			an_array.area.fill_with (104, 117162, 117165)
			an_array.area.fill_with (97, 117166, 117224)
			an_array.area.fill_with (104, 117225, 117247)
			an_array.area.fill_with (97, 117248, 117313)
			yy_ec_template_57 (an_array)
			an_array.area.fill_with (104, 117318, 117503)
			an_array.area.fill_with (97, 117504, 117590)
			an_array.area.fill_with (104, 117591, 118464)
			an_array.put (97, 118465)
			an_array.area.fill_with (104, 118466, 118490)
			an_array.put (97, 118491)
			an_array.area.fill_with (104, 118492, 118522)
			an_array.put (97, 118523)
			an_array.area.fill_with (104, 118524, 118548)
			an_array.put (97, 118549)
			an_array.area.fill_with (104, 118550, 118580)
			an_array.put (97, 118581)
			an_array.area.fill_with (104, 118582, 118606)
			an_array.put (97, 118607)
			an_array.area.fill_with (104, 118608, 118638)
			an_array.put (97, 118639)
			an_array.area.fill_with (104, 118640, 118664)
			an_array.put (97, 118665)
			an_array.area.fill_with (104, 118666, 118696)
			an_array.put (97, 118697)
			an_array.area.fill_with (104, 118698, 118722)
			an_array.put (97, 118723)
			an_array.area.fill_with (104, 118724, 118783)
			an_array.area.fill_with (97, 118784, 119295)
			an_array.area.fill_with (104, 119296, 119350)
			an_array.area.fill_with (97, 119351, 119354)
			an_array.area.fill_with (104, 119355, 119404)
			yy_ec_template_58 (an_array)
			an_array.area.fill_with (104, 119436, 121166)
			an_array.put (97, 121167)
			an_array.area.fill_with (104, 121168, 121598)
			an_array.put (97, 121599)
			an_array.area.fill_with (104, 121600, 123229)
			an_array.area.fill_with (97, 123230, 123231)
			an_array.area.fill_with (104, 123232, 124075)
			yy_ec_template_59 (an_array)
			an_array.area.fill_with (104, 124081, 124205)
			an_array.put (97, 124206)
			an_array.area.fill_with (104, 124207, 124655)
			an_array.area.fill_with (97, 124656, 124657)
			an_array.area.fill_with (104, 124658, 124927)
			an_array.area.fill_with (97, 124928, 124971)
			an_array.area.fill_with (104, 124972, 124975)
			an_array.area.fill_with (97, 124976, 125075)
			yy_ec_template_60 (an_array)
			an_array.area.fill_with (97, 125137, 125173)
			an_array.area.fill_with (104, 125174, 125196)
			an_array.area.fill_with (97, 125197, 125357)
			an_array.area.fill_with (104, 125358, 125413)
			an_array.area.fill_with (97, 125414, 125442)
			an_array.area.fill_with (104, 125443, 125455)
			an_array.area.fill_with (97, 125456, 125499)
			yy_ec_template_61 (an_array)
			an_array.area.fill_with (104, 125542, 125695)
			an_array.area.fill_with (97, 125696, 125946)
			an_array.area.fill_with (96, 125947, 125951)
			an_array.area.fill_with (97, 125952, 126679)
			yy_ec_template_62 (an_array)
			an_array.area.fill_with (97, 126720, 126835)
			an_array.area.fill_with (104, 126836, 126847)
			an_array.area.fill_with (97, 126848, 126936)
			yy_ec_template_63 (an_array)
			an_array.area.fill_with (97, 126992, 127047)
			yy_ec_template_64 (an_array)
			an_array.area.fill_with (97, 127072, 127111)
			an_array.area.fill_with (104, 127112, 127119)
			an_array.area.fill_with (97, 127120, 127149)
			yy_ec_template_65 (an_array)
			an_array.area.fill_with (104, 127154, 127231)
			an_array.area.fill_with (97, 127232, 127352)
			an_array.put (104, 127353)
			an_array.area.fill_with (97, 127354, 127435)
			an_array.put (104, 127436)
			an_array.area.fill_with (97, 127437, 127571)
			yy_ec_template_66 (an_array)
			an_array.area.fill_with (97, 127632, 127656)
			yy_ec_template_67 (an_array)
			an_array.area.fill_with (104, 127703, 127743)
			an_array.area.fill_with (97, 127744, 127890)
			an_array.put (104, 127891)
			an_array.area.fill_with (97, 127892, 127946)
			an_array.area.fill_with (104, 127947, 127948)
			Result := yy_fixed_array (an_array)
		end

	yy_ec_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			    0,  104,  104,  104,  104,  104,  104,  104,  104,    1,
			    2,    3,    3,    4,  104,  104,  104,  104,  104,  104,
			  104,  104,  104,  104,  104,  104,  104,  104,  104,  104,
			  104,  104,    5,    6,    7,    8,    9,   10,    8,   11,
			   12,   13,   14,   15,   16,   17,   18,   19,   20,   21,
			   22,   22,   22,   22,   22,   22,   23,   23,   24,   25,
			   26,   27,   28,   29,   30,   31,   32,   33,   34,   35,
			   36,   37,   38,   39,   40,   41,   42,   43,   44,   45,
			   46,   47,   48,   49,   50,   51,   52,   53,   54,   55,
			   56,   57,   58,   59,   60,   61,   62,   63,   64,   65,

			   66,   67,   68,   69,   70,   71,   72,   73,   74,   75,
			   76,   77,   78,   79,   80,   81,   82,   83,   84,   85,
			   86,   87,   88,   89,    8,   90,   91, yy_Dummy>>,
			1, 127, 0)
		end

	yy_ec_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			    3,   92,   92,   92,   92,   92,   93,   92,   94,   92,
			   95,   95,   92,   95,   92,   94,   92,   92,   95,   95,
			   94,   95,   92,   92,   94,   95,   95,   95,   95,   95,
			   95,   92,   95,   95,   95,   95,   95,   95,   95,   95,
			   95,   95,   95,   95,   95,   95,   95,   95,   95,   95,
			   95,   95,   95,   95,   95,   92, yy_Dummy>>,
			1, 56, 160)
		end

	yy_ec_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   92,   95,   95,   95,   95,   95,   95,   95,   95, yy_Dummy>>,
			1, 9, 247)
		end

	yy_ec_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   96,   96,   96,   96,  104,  104,  104,  104,  104,  104,
			  104,  104,  104,  104,  104,  104,   96,   96,   96,   96,
			   96,   96,   96,   96,   96,   96,   96,   96,   96,   96,
			  104,  104,  104,  104,  104,   96,   96,   96,   96,   96,
			   96,   96,  104,   96,  104,   96,   96,   96,   96,   96,
			   96,   96,   96,   96,   96,   96,   96,   96,   96,   96,
			   96,   96, yy_Dummy>>,
			1, 62, 706)
		end

	yy_ec_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   96,  104,  104,  104,  104,  104,  104,  104,  104,   97,
			  104,  104,  104,  104,  104,   96,   96,  104,   97, yy_Dummy>>,
			1, 19, 885)
		end

	yy_ec_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   97,   97,  104,  104,   97,   97,   97, yy_Dummy>>,
			1, 7, 1417)
		end

	yy_ec_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   97,  104,   97,  104,  104,   97,  104,  104,   97, yy_Dummy>>,
			1, 9, 1470)
		end

	yy_ec_template_8 (an_array: ARRAY [INTEGER])
			-- Fill chunk #8 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   97,   97,  104,  104,  104,  104,  104,  104,  104,  104,
			  104,  104,  104,  104,  104,  104,  104,  104,  104,   97,
			   97,   97,   97,   97,   97,   97,   97,   97,   97,  104,
			  104,  104,  104,  104,  104,  104,  104,  104,  104,  104,
			   97,  104,  104,   97,   97, yy_Dummy>>,
			1, 45, 1523)
		end

	yy_ec_template_9 (an_array: ARRAY [INTEGER])
			-- Fill chunk #9 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   97,  104,  104,  104,  104,  104,  104,  104,  104,  104,
			   97,  104,  104,  104,  104,  104,  104,  104,  104,  104,
			  104,   97,  104,  104,  104,  104,  104,  104,  104,  104,
			  104,  104,  104,  104,  104,  104,  104,  104,  104,  104,
			  104,   97,   97,  104,   97,   97,   97,   97,   97,   97,
			   97,   97,   97,   97,   97,   97,   97,   97, yy_Dummy>>,
			1, 58, 1748)
		end

	yy_ec_template_10 (an_array: ARRAY [INTEGER])
			-- Fill chunk #10 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   97,   97,   97,   97,  104,  104,  104,  104,   97,   97, yy_Dummy>>,
			1, 10, 2038)
		end

	yy_ec_template_11 (an_array: ARRAY [INTEGER])
			-- Fill chunk #11 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   97,   97,  104,  104,  104,  104,  104,  104,  104,  104,
			  104,  104,   97, yy_Dummy>>,
			1, 13, 2404)
		end

	yy_ec_template_12 (an_array: ARRAY [INTEGER])
			-- Fill chunk #12 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   97,   97,  104,  104,  104,  104,  104,  104,   97,   97,
			  104,   97, yy_Dummy>>,
			1, 12, 2546)
		end

	yy_ec_template_13 (an_array: ARRAY [INTEGER])
			-- Fill chunk #13 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   97,  104,  104,  104,  104,  104,  104,  104,   97,  104,
			  104,  104,  104,   97, yy_Dummy>>,
			1, 14, 3191)
		end

	yy_ec_template_14 (an_array: ARRAY [INTEGER])
			-- Fill chunk #14 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   97,  104,  104,  104,  104,  104,  104,  104,  104,  104,
			  104,  104,  104,  104,  104,  104,   97,  104,  104,  104,
			  104,  104,  104,  104,  104,  104,  104,   97,   97, yy_Dummy>>,
			1, 29, 3647)
		end

	yy_ec_template_15 (an_array: ARRAY [INTEGER])
			-- Fill chunk #15 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   97,   97,   97,   97,   97,   97,   97,   97,   97,   97,
			   97,   97,   97,   97,   97,   97,   97,   97,   97,   97,
			   97,   97,   97,  104,  104,   97,   97,   97,   97,   97,
			   97,  104,  104,  104,  104,  104,  104,  104,  104,  104,
			  104,  104,  104,  104,  104,  104,  104,  104,  104,  104,
			  104,   97,  104,   97,  104,   97, yy_Dummy>>,
			1, 56, 3841)
		end

	yy_ec_template_16 (an_array: ARRAY [INTEGER])
			-- Fill chunk #16 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   97,   97,   97,   97,   97,   97,   97,   97,  104,   97,
			   97,   97,   97,   97,   97,  104,   97,   97,   97,   97,
			   97,   97,   97,   97,   97,   97,   97,   97,   97, yy_Dummy>>,
			1, 29, 4030)
		end

	yy_ec_template_17 (an_array: ARRAY [INTEGER])
			-- Fill chunk #17 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   97,   97,  104,  104,  104,  104,  104,  104,  104,  104,
			  104,  104,  104,  104,  104,  104,  104,  104,  104,    3, yy_Dummy>>,
			1, 20, 5741)
		end

	yy_ec_template_18 (an_array: ARRAY [INTEGER])
			-- Fill chunk #18 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   97,   97,   97,  104,   97,   97,   97,   97, yy_Dummy>>,
			1, 8, 6100)
		end

	yy_ec_template_19 (an_array: ARRAY [INTEGER])
			-- Fill chunk #19 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   97,  104,  104,  104,   97,   97, yy_Dummy>>,
			1, 6, 6464)
		end

	yy_ec_template_20 (an_array: ARRAY [INTEGER])
			-- Fill chunk #20 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   97,   97,   97,   97,   97,   97,   97,  104,   97,   97,
			   97,   97,   97,   97, yy_Dummy>>,
			1, 14, 6816)
		end

	yy_ec_template_21 (an_array: ARRAY [INTEGER])
			-- Fill chunk #21 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   97,   97,   97,   97,   97,   97,   97,   97,   97,   97,
			   97,   97,   97,   97,   97,   97,   97,  104,  104,  104,
			  104,  104,  104,  104,  104,  104,   97,   97,   97,   97,
			   97,   97,   97,   97,   97, yy_Dummy>>,
			1, 35, 7002)
		end

	yy_ec_template_22 (an_array: ARRAY [INTEGER])
			-- Fill chunk #22 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   97,   97,   97,   97,   97,   97,   97,   97,  104,  104,
			  104,  104,  104,  104,  104,  104,  104,  104,  104,   97, yy_Dummy>>,
			1, 20, 7360)
		end

	yy_ec_template_23 (an_array: ARRAY [INTEGER])
			-- Fill chunk #23 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   96,  104,   96,   96,   96,  104,  104,  104,  104,  104,
			  104,  104,  104,  104,  104,  104,   96,   96,   96,  104,
			  104,  104,  104,  104,  104,  104,  104,  104,  104,  104,
			  104,  104,   96,   96,   96,  104,  104,  104,  104,  104,
			  104,  104,  104,  104,  104,  104,  104,  104,   96,   96,
			   96,  104,  104,  104,  104,  104,  104,  104,  104,  104,
			  104,  104,  104,  104,   96,   96,  104,    3,    3,    3,
			    3,    3,    3,    3,    3,    3,    3,    3,  104,  104,
			  104,  104,  104,   97,   97,   97,   97,   97,   97,   97,
			   97,  104,  104,  104,  104,  104,  104,  104,  104,   97,

			   97,   97,   97,   97,   97,   97,   97,  104,  104,  104,
			  104,  104,  104,  104,    3,   97,   97,   97,   97,   97,
			   97,   97,   97,   97,  104,  104,   97,   97,   97,   97,
			   97,   97,   97,   97,   97,   97,  104,  104,   97,   97,
			   97,   97,   97,   97,   97,   97,   97,   97,   97,   97,
			   97,   97,   97,   97,   97,   97,   97,   97,   97,   97,
			   97,   97,    3, yy_Dummy>>,
			1, 163, 8125)
		end

	yy_ec_template_24 (an_array: ARRAY [INTEGER])
			-- Fill chunk #24 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   97,   97,   97,  104,  104,  104,  104,  104,  104,  104,
			  104,  104,  104,  104,  104,  104,   97,   97,   97,  104,
			  104,  104,  104,  104,  104,  104,  104,  104,  104,  104,
			  104,  104,  104,  104,  104,  104,  104,  104, yy_Dummy>>,
			1, 38, 8314)
		end

	yy_ec_template_25 (an_array: ARRAY [INTEGER])
			-- Fill chunk #25 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   97,   97,  104,   97,   97,   97,   97,  104,   97,   97,
			  104,  104,  104,  104,  104,  104,  104,  104,  104,  104,
			   97,  104,   97,   97,   97,  104,  104,  104,  104,  104,
			   97,   97,   97,   97,   97,   97,  104,   97,  104,   97,
			  104,   97,  104,  104,  104,  104,   97,  104,  104,  104,
			  104,  104,  104,  104,  104,  104,  104,  104,   97,   97,
			  104,  104,  104,  104,   97,   97,   97,   97,   97,  104,
			  104,  104,  104,  104,   97,   97,   97,   97,  104,   97, yy_Dummy>>,
			1, 80, 8448)
		end

	yy_ec_template_26 (an_array: ARRAY [INTEGER])
			-- Fill chunk #26 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   97,   97,  104,  104,  104,  104, yy_Dummy>>,
			1, 6, 8586)
		end

	yy_ec_template_27 (an_array: ARRAY [INTEGER])
			-- Fill chunk #27 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   98,   97,   97,   99, yy_Dummy>>,
			1, 4, 8704)
		end

	yy_ec_template_28 (an_array: ARRAY [INTEGER])
			-- Fill chunk #28 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			  100,  101,  104,  104,  104,  104,  104,  104,  104,  104,
			   97,   97,  102,  103, yy_Dummy>>,
			1, 14, 10214)
		end

	yy_ec_template_29 (an_array: ARRAY [INTEGER])
			-- Fill chunk #29 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   97,   97,   97,   97,   97,   97,  104,  104,  104,  104,
			  104,  104,  104,  104,  104,  104,  104,  104,  104,  104,
			   97,   97,   97,   97,  104,   97,   97, yy_Dummy>>,
			1, 27, 11493)
		end

	yy_ec_template_30 (an_array: ARRAY [INTEGER])
			-- Fill chunk #30 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   97,   97,  104,  104,  104,  104,   97,   97,   97,  104,
			  104,   97,  104,  104,   97,   97,   97,   97,   97,   97,
			   97,   97,   97,   97,   97,   97,   97,   97,  104,  104,
			   97,   97,  104,  104,  104,  104,  104,  104,  104,  104,
			  104,  104,   97,   97,   97,   97,   97,  104,   97,   97,
			   97,   97,   97,   97,   97,   97,   97,   97,   97,   97,
			   97,   97,   97,   97,   97,   97,  104,   97,   97,   97,
			   97,   97,   97,   97,   97,   97,   97,   97,   97,   97,
			   97,   97,   97, yy_Dummy>>,
			1, 83, 11776)
		end

	yy_ec_template_31 (an_array: ARRAY [INTEGER])
			-- Fill chunk #31 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   97,   97,   97,   97,   97,   97,   97,   97,   97,   97,
			   97,   97,  104,  104,  104,  104,    3,   97,   97,   97,
			   97,  104,  104,  104,  104,  104,  104,  104,  104,  104,
			  104,  104,  104,  104,   97,   97,  104,  104,  104,  104,
			  104,  104,  104,  104,   97,  104,  104,  104,   97,  104,
			  104,  104,  104,  104,  104,  104,  104,  104,  104,  104,
			  104,  104,  104,  104,   97,  104,  104,  104,  104,  104,
			   97,   97,  104,  104,  104,  104,  104,   97,   97,   97, yy_Dummy>>,
			1, 80, 12272)
		end

	yy_ec_template_32 (an_array: ARRAY [INTEGER])
			-- Fill chunk #32 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   96,   96,  104,  104,  104,   97, yy_Dummy>>,
			1, 6, 12443)
		end

	yy_ec_template_33 (an_array: ARRAY [INTEGER])
			-- Fill chunk #33 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   97,   97,  104,  104,  104,  104,   97,   97,   97,   97,
			   97,   97,   97,   97,   97,   97, yy_Dummy>>,
			1, 16, 12688)
		end

	yy_ec_template_34 (an_array: ARRAY [INTEGER])
			-- Fill chunk #34 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			  104,  104,  104,  104,  104,  104,  104,  104,   97,  104,
			  104,  104,  104,  104,  104,  104,  104,  104,  104,  104,
			  104,  104,  104,  104, yy_Dummy>>,
			1, 24, 12872)
		end

	yy_ec_template_35 (an_array: ARRAY [INTEGER])
			-- Fill chunk #35 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   97,  104,  104,  104,  104,  104,  104,  104,  104,  104,
			  104,   97, yy_Dummy>>,
			1, 12, 42611)
		end

	yy_ec_template_36 (an_array: ARRAY [INTEGER])
			-- Fill chunk #36 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   97,   97,   97,   97,   97,   97,  104,  104,  104,  104,
			  104,  104,  104,  104,   96,   96,   96,   96,   96,   96,
			   96,   96,   96,   96,   96,   96,   96,   96,   96,   96,
			   96,   96,   96,   96,   96,   96,   96,  104,  104,  104,
			  104,  104,  104,  104,  104,  104,   96,   96, yy_Dummy>>,
			1, 48, 42738)
		end

	yy_ec_template_37 (an_array: ARRAY [INTEGER])
			-- Fill chunk #37 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   97,   97,   97,   97,  104,  104,  104,  104,  104,  104,
			  104,  104,  104,  104,   97,   97,   97,   97, yy_Dummy>>,
			1, 18, 43048)
		end

	yy_ec_template_38 (an_array: ARRAY [INTEGER])
			-- Fill chunk #38 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   97,   97,   97,  104,   97, yy_Dummy>>,
			1, 5, 43256)
		end

	yy_ec_template_39 (an_array: ARRAY [INTEGER])
			-- Fill chunk #39 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   97,   97,   97,   97,   97,   97,   97,   97,   97,   97,
			   97,   97,   97,  104,  104,  104,  104,  104,  104,  104,
			  104,  104,  104,  104,  104,  104,  104,  104,  104,   97,
			   97, yy_Dummy>>,
			1, 31, 43457)
		end

	yy_ec_template_40 (an_array: ARRAY [INTEGER])
			-- Fill chunk #40 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   97,   97,   97,   97,  104,  104,  104,  104,  104,  104,
			  104,  104,  104,  104,  104,  104,  104,  104,  104,  104,
			  104,  104,  104,  104,  104,  104,  104,   97,   97,   97, yy_Dummy>>,
			1, 30, 43612)
		end

	yy_ec_template_41 (an_array: ARRAY [INTEGER])
			-- Fill chunk #41 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   97,   97,  104,  104,  104,  104,  104,  104,  104,  104,
			  104,  104,  104,  104,  104,  104,  104,  104,   97,   97, yy_Dummy>>,
			1, 20, 43742)
		end

	yy_ec_template_42 (an_array: ARRAY [INTEGER])
			-- Fill chunk #42 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   96,  104,  104,  104,  104,  104,  104,  104,  104,  104,
			  104,  104,  104,  104,  104,   96,   96, yy_Dummy>>,
			1, 17, 43867)
		end

	yy_ec_template_43 (an_array: ARRAY [INTEGER])
			-- Fill chunk #43 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   97,   97,  104,  104,  104,  104,  104,  104,  104,  104,
			  104,  104,  104,  104,  104,  104,  104,  104,  104,  104,
			   97,   97,   97,   97,   97,   97,   97,  104,  104,   97,
			  104,  104,  104,  104,  104,  104,  104,  104,  104,  104,
			  104,  104,  104,  104,  104,  104,  104,  104,  104,  104,
			  104,  104,   97,   97,   97,   97,   97,  104,  104,  104,
			  104,  104,  104,  104,  104,  104,  104,  104,  104,  104,
			  104,  104,  104,   97,   97,  104,  104,   97,   97,   97,
			   97,   97,   97,   97,   97,   97,   97,  104,   97,   97,
			   97,   97,   97,  104,  104,  104,  104,  104,  104,   97,

			   97,   97,   97,   97,   97,   97,   97,  104,   97,   97,
			   97,   97, yy_Dummy>>,
			1, 112, 62972)
		end

	yy_ec_template_44 (an_array: ARRAY [INTEGER])
			-- Fill chunk #44 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   97,   97,   97,   97,   97,   97,   97,  104,  104,   97,
			   97,   97,   97,   97,   97,  104,  104,  104,  104,  104,
			  104,  104,  104,  104,  104,   97,   97,   97,   97,   97,
			   97,   97, yy_Dummy>>,
			1, 32, 63233)
		end

	yy_ec_template_45 (an_array: ARRAY [INTEGER])
			-- Fill chunk #45 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   97,  104,   96,   97,   96, yy_Dummy>>,
			1, 5, 63292)
		end

	yy_ec_template_46 (an_array: ARRAY [INTEGER])
			-- Fill chunk #46 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   97,  104,   97,  104,  104,   97,  104,  104,   97,   97, yy_Dummy>>,
			1, 10, 63324)
		end

	yy_ec_template_47 (an_array: ARRAY [INTEGER])
			-- Fill chunk #47 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   97,   97,   97,   96,   97,   97,   97,  104,   97,   97,
			   97,   97,   97,   97,   97,  104,  104,  104,  104,  104,
			  104,  104,  104,  104,  104,  104,  104,  104,   97,   97, yy_Dummy>>,
			1, 30, 63456)
		end

	yy_ec_template_48 (an_array: ARRAY [INTEGER])
			-- Fill chunk #48 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   97,   97,   97,   97,   97,   97,   97,   97,   97,   97,
			   97,   97,   97,   97,   97,   97,   97,  104,  104,   97,
			   97,   97,  104,   97,   97,   97,   97,   97,   97,   97,
			   97,   97,   97,   97,   97,   97,  104,  104,  104,   97, yy_Dummy>>,
			1, 40, 63865)
		end

	yy_ec_template_49 (an_array: ARRAY [INTEGER])
			-- Fill chunk #49 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   97,   97,  104,   97,   97,   97,   97, yy_Dummy>>,
			1, 7, 67771)
		end

	yy_ec_template_50 (an_array: ARRAY [INTEGER])
			-- Fill chunk #50 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   97,   97,   97,   97,  104,  104,  104,  104,   97,  104,
			  104,  104,  104,  104,  104,  104,  104,  104,  104,  104,
			  104,  104,   97,  104,   97,   97,   97, yy_Dummy>>,
			1, 27, 68037)
		end

	yy_ec_template_51 (an_array: ARRAY [INTEGER])
			-- Fill chunk #51 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   97,   97,   97,   97,   97,  104,  104,  104,  104,  104,
			  104,  104,  104,  104,  104,   97,   97,  104,   97, yy_Dummy>>,
			1, 19, 68683)
		end

	yy_ec_template_52 (an_array: ARRAY [INTEGER])
			-- Fill chunk #52 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   97,   97,   97,  104,   97,   97,   97,   97,   97, yy_Dummy>>,
			1, 9, 70298)
		end

	yy_ec_template_53 (an_array: ARRAY [INTEGER])
			-- Fill chunk #53 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			  104,  104,  104,  104,  104,  104,  104,  104,  104,  104,
			  104,  104,  104,   97, yy_Dummy>>,
			1, 14, 71666)
		end

	yy_ec_template_54 (an_array: ARRAY [INTEGER])
			-- Fill chunk #54 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   97,   97,   97,   97,   97,   97,   97,   97,   97,  104,
			  104,  104,  104,   97,   97, yy_Dummy>>,
			1, 15, 90935)
		end

	yy_ec_template_55 (an_array: ARRAY [INTEGER])
			-- Fill chunk #55 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   97,  104,  104,   97, yy_Dummy>>,
			1, 4, 111772)
		end

	yy_ec_template_56 (an_array: ARRAY [INTEGER])
			-- Fill chunk #56 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			  104,  104,  104,  104,  104,   97,   97,   97,  104,  104,
			  104,  104,  104,  104,  104,  104,  104,  104,  104,  104,
			  104,  104,  104,  104,  104,  104,  104,  104,  104,  104,
			   97,   97,  104,  104,  104,  104,  104,  104,  104, yy_Dummy>>,
			1, 39, 117093)
		end

	yy_ec_template_57 (an_array: ARRAY [INTEGER])
			-- Fill chunk #57 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			  104,  104,  104,   97, yy_Dummy>>,
			1, 4, 117314)
		end

	yy_ec_template_58 (an_array: ARRAY [INTEGER])
			-- Fill chunk #58 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   97,   97,   97,   97,   97,   97,   97,   97,  104,   97,
			   97,   97,   97,   97,   97,   97,   97,   97,   97,   97,
			   97,   97,   97,  104,   97,   97,   97,   97,   97,   97,
			   97, yy_Dummy>>,
			1, 31, 119405)
		end

	yy_ec_template_59 (an_array: ARRAY [INTEGER])
			-- Fill chunk #59 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   97,  104,  104,  104,   97, yy_Dummy>>,
			1, 5, 124076)
		end

	yy_ec_template_60 (an_array: ARRAY [INTEGER])
			-- Fill chunk #60 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			  104,  104,  104,  104,  104,  104,  104,  104,  104,  104,
			  104,  104,   97,   97,   97,   97,   97,   97,   97,   97,
			   97,   97,   97,   97,   97,   97,   97,  104,  104,   97,
			   97,   97,   97,   97,   97,   97,   97,   97,   97,   97,
			   97,   97,   97,   97,  104,   97,   97,   97,   97,   97,
			   97,   97,   97,   97,   97,   97,   97,   97,   97,   97,
			  104, yy_Dummy>>,
			1, 61, 125076)
		end

	yy_ec_template_61 (an_array: ARRAY [INTEGER])
			-- Fill chunk #61 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			  104,  104,  104,  104,   97,   97,   97,   97,   97,   97,
			   97,   97,   97,  104,  104,  104,  104,  104,  104,  104,
			   97,   97,  104,  104,  104,  104,  104,  104,  104,  104,
			  104,  104,  104,  104,  104,  104,   97,   97,   97,   97,
			   97,   97, yy_Dummy>>,
			1, 42, 125500)
		end

	yy_ec_template_62 (an_array: ARRAY [INTEGER])
			-- Fill chunk #62 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			  104,  104,  104,  104,  104,  104,  104,  104,   97,   97,
			   97,   97,   97,   97,   97,   97,   97,   97,   97,   97,
			   97,  104,  104,  104,   97,   97,   97,   97,   97,   97,
			   97,   97,   97,   97,   97,   97,   97,  104,  104,  104, yy_Dummy>>,
			1, 40, 126680)
		end

	yy_ec_template_63 (an_array: ARRAY [INTEGER])
			-- Fill chunk #63 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			  104,  104,  104,  104,  104,  104,  104,   97,   97,   97,
			   97,   97,   97,   97,   97,   97,   97,   97,   97,  104,
			  104,  104,  104,  104,  104,  104,  104,  104,  104,  104,
			  104,  104,  104,  104,  104,  104,  104,  104,  104,   97,
			   97,   97,   97,   97,   97,   97,   97,   97,   97,   97,
			   97,  104,  104,  104,  104, yy_Dummy>>,
			1, 55, 126937)
		end

	yy_ec_template_64 (an_array: ARRAY [INTEGER])
			-- Fill chunk #64 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			  104,  104,  104,  104,  104,  104,  104,  104,   97,   97,
			   97,   97,   97,   97,   97,   97,   97,   97,  104,  104,
			  104,  104,  104,  104, yy_Dummy>>,
			1, 24, 127048)
		end

	yy_ec_template_65 (an_array: ARRAY [INTEGER])
			-- Fill chunk #65 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			  104,  104,   97,   97, yy_Dummy>>,
			1, 4, 127150)
		end

	yy_ec_template_66 (an_array: ARRAY [INTEGER])
			-- Fill chunk #66 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			  104,  104,  104,  104,  104,  104,  104,  104,  104,  104,
			  104,  104,   97,   97,   97,   97,   97,   97,   97,   97,
			   97,   97,   97,   97,   97,   97,  104,  104,   97,   97,
			   97,   97,   97,  104,  104,  104,   97,   97,   97,  104,
			  104,  104,  104,  104,   97,   97,   97,   97,   97,   97,
			   97,  104,  104,  104,  104,  104,  104,  104,  104,  104, yy_Dummy>>,
			1, 60, 127572)
		end

	yy_ec_template_67 (an_array: ARRAY [INTEGER])
			-- Fill chunk #67 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			  104,  104,  104,  104,  104,  104,  104,   97,   97,   97,
			   97,   97,   97,   97,  104,  104,  104,  104,  104,  104,
			  104,  104,  104,   97,   97,   97,  104,  104,  104,  104,
			  104,  104,  104,  104,  104,  104,  104,  104,  104,   97,
			   97,   97,   97,   97,   97,   97, yy_Dummy>>,
			1, 46, 127657)
		end

	yy_meta_template: SPECIAL [INTEGER]
			-- Template for `yy_meta'
		once
			Result := yy_fixed_array (<<
			    0,    1,    2,    3,    3,    1,    4,    5,    4,    6,
			    7,    8,    9,    9,    4,    4,    6,    4,   10,   11,
			   12,   12,   12,   12,    6,    6,   11,    4,   11,    6,
			    4,   13,   13,   13,   13,   12,   13,   14,   15,   14,
			   14,   14,   15,   14,   15,   14,   14,   15,   15,   15,
			   15,   15,   15,   14,   14,   14,   14,    6,    4,    6,
			    4,   16,   17,   12,   12,   12,   12,   12,   12,   14,
			   14,   14,   14,   14,   14,   14,   14,   14,   14,   14,
			   14,   14,   14,   14,   14,   14,   14,   14,   14,    6,
			    6,    4,    4,    4,    4,    6,    4,    4,    4,    4,

			   18,   18,    4,    4,   18, yy_Dummy>>)
		end

	yy_accept_template: SPECIAL [INTEGER]
			-- Template for `yy_accept'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 865)
			yy_accept_template_1 (an_array)
			yy_accept_template_2 (an_array)
			yy_accept_template_3 (an_array)
			yy_accept_template_4 (an_array)
			yy_accept_template_5 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_accept_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			    0,    1,    1,    1,    2,    3,    4,    6,    9,   11,
			   14,   17,   22,   24,   30,   33,   35,   38,   41,   44,
			   49,   54,   57,   60,   63,   68,   71,   74,   77,   80,
			   85,   90,   95,   98,  105,  109,  113,  117,  121,  125,
			  129,  133,  137,  141,  145,  149,  153,  157,  161,  165,
			  169,  173,  177,  180,  184,  187,  192,  196,  198,  201,
			  204,  207,  210,  213,  216,  219,  222,  225,  228,  231,
			  234,  237,  240,  243,  246,  249,  252,  255,  258,  263,
			  268,  273,  278,  281,  284,  289,  294,  296,  298,  300,
			  303,  305,  307,  309,  310,  311,  312,  313,  315,  315,

			  315,  316,  317,  319,  321,  325,  327,  327,  327,  328,
			  329,  330,  332,  333,  336,  337,  338,  341,  344,  347,
			  348,  350,  351,  352,  353,  354,  355,  356,  359,  362,
			  365,  368,  369,  369,  370,  373,  373,  375,  377,  379,
			  381,  383,  386,  388,  389,  390,  391,  392,  393,  395,
			  396,  398,  400,  402,  404,  406,  407,  408,  409,  410,
			  411,  413,  416,  417,  419,  421,  423,  425,  426,  427,
			  428,  430,  432,  434,  435,  436,  437,  440,  442,  444,
			  447,  449,  450,  451,  453,  455,  457,  458,  459,  461,
			  462,  464,  466,  468,  471,  472,  473,  474,  476,  478, yy_Dummy>>,
			1, 200, 0)
		end

	yy_accept_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			  479,  481,  482,  484,  486,  488,  489,  490,  491,  493,
			  495,  496,  497,  499,  500,  502,  504,  505,  506,  508,
			  509,  511,  512,  515,  515,  517,  517,  519,  519,  521,
			  521,  522,  522,  523,  523,  525,  525,  527,  527,  528,
			  529,  529,  529,  530,  531,  532,  533,  534,  535,  535,
			  536,  538,  539,  540,  544,  546,  547,  549,  550,  551,
			  552,  553,  554,  555,  556,  557,  558,  559,  560,  561,
			  562,  563,  564,  565,  566,  567,  568,  569,  570,  571,
			  572,  572,  573,  574,  574,  576,  579,  581,  584,  587,
			  589,  590,  592,  593,  595,  596,  598,  601,  602,  604,

			  607,  609,  611,  612,  614,  615,  617,  618,  620,  621,
			  623,  624,  626,  627,  629,  630,  632,  634,  636,  637,
			  638,  639,  641,  642,  645,  647,  649,  650,  652,  654,
			  655,  656,  658,  659,  661,  662,  664,  665,  667,  668,
			  670,  672,  674,  676,  677,  678,  679,  680,  682,  683,
			  685,  687,  688,  689,  692,  694,  696,  697,  700,  702,
			  704,  705,  707,  708,  710,  712,  714,  716,  718,  720,
			  721,  722,  723,  724,  725,  726,  728,  730,  731,  732,
			  734,  735,  737,  738,  740,  741,  743,  744,  746,  748,
			  750,  751,  752,  753,  755,  756,  758,  759,  761,  762, yy_Dummy>>,
			1, 200, 200)
		end

	yy_accept_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			  765,  767,  768,  769,  770,  770,  770,  772,  773,  773,
			  774,  775,  776,  777,  778,  779,  780,  781,  782,  783,
			  784,  785,  786,  787,  788,  789,  790,  791,  792,  793,
			  794,  795,  796,  797,  797,  798,  799,  799,  799,  800,
			  802,  804,  806,  808,  808,  810,  812,  814,  815,  817,
			  818,  820,  821,  823,  824,  826,  828,  829,  830,  832,
			  833,  835,  836,  838,  839,  841,  842,  844,  845,  847,
			  848,  850,  851,  853,  854,  857,  859,  861,  862,  864,
			  866,  867,  868,  870,  871,  873,  874,  876,  877,  880,
			  882,  884,  885,  887,  888,  890,  891,  893,  894,  896,

			  897,  899,  900,  903,  905,  907,  908,  911,  913,  916,
			  918,  920,  921,  924,  926,  928,  929,  931,  932,  934,
			  935,  937,  938,  940,  941,  943,  945,  946,  947,  949,
			  950,  952,  953,  955,  956,  959,  961,  963,  964,  967,
			  969,  972,  974,  976,  977,  979,  980,  982,  983,  985,
			  986,  989,  991,  994,  996,  996,  996,  996,  996,  997,
			  997,  997,  997,  997,  998,  998,  999,  999, 1000, 1001,
			 1003, 1005, 1006, 1009, 1011, 1014, 1016, 1018, 1019, 1021,
			 1022, 1024, 1025, 1028, 1030, 1033, 1035, 1037, 1038, 1040,
			 1041, 1043, 1044, 1047, 1049, 1051, 1052, 1054, 1055, 1057, yy_Dummy>>,
			1, 200, 400)
		end

	yy_accept_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			 1058, 1060, 1061, 1063, 1064, 1066, 1067, 1069, 1070, 1073,
			 1075, 1077, 1078, 1080, 1081, 1083, 1084, 1086, 1087, 1089,
			 1090, 1092, 1093, 1095, 1096, 1099, 1101, 1103, 1104, 1106,
			 1107, 1109, 1110, 1112, 1113, 1115, 1116, 1118, 1119, 1121,
			 1122, 1124, 1125, 1128, 1130, 1132, 1133, 1135, 1136, 1139,
			 1141, 1143, 1144, 1146, 1147, 1150, 1152, 1154, 1155, 1155,
			 1155, 1155, 1156, 1156, 1156, 1156, 1156, 1156, 1157, 1158,
			 1158, 1158, 1159, 1162, 1164, 1167, 1169, 1171, 1172, 1174,
			 1175, 1177, 1178, 1181, 1183, 1185, 1186, 1188, 1189, 1191,
			 1192, 1194, 1195, 1198, 1200, 1203, 1205, 1207, 1208, 1211,

			 1213, 1215, 1216, 1218, 1219, 1222, 1224, 1226, 1227, 1229,
			 1230, 1232, 1233, 1235, 1236, 1238, 1239, 1241, 1242, 1244,
			 1245, 1247, 1248, 1250, 1251, 1254, 1256, 1258, 1259, 1262,
			 1264, 1267, 1269, 1272, 1274, 1276, 1277, 1279, 1280, 1283,
			 1285, 1287, 1288, 1288, 1288, 1288, 1288, 1288, 1288, 1288,
			 1288, 1288, 1288, 1288, 1289, 1290, 1290, 1290, 1291, 1291,
			 1292, 1292, 1294, 1295, 1297, 1298, 1301, 1303, 1305, 1306,
			 1309, 1311, 1313, 1314, 1316, 1317, 1319, 1320, 1322, 1323,
			 1326, 1328, 1331, 1333, 1335, 1336, 1339, 1341, 1344, 1346,
			 1348, 1349, 1351, 1352, 1354, 1355, 1357, 1358, 1360, 1361, yy_Dummy>>,
			1, 200, 600)
		end

	yy_accept_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			 1364, 1366, 1368, 1369, 1371, 1372, 1375, 1377, 1378, 1379,
			 1380, 1381, 1381, 1382, 1382, 1383, 1384, 1384, 1384, 1385,
			 1388, 1390, 1392, 1393, 1396, 1398, 1401, 1403, 1405, 1406,
			 1409, 1411, 1414, 1416, 1419, 1421, 1423, 1424, 1427, 1429,
			 1431, 1432, 1435, 1437, 1439, 1440, 1443, 1445, 1448, 1450,
			 1451, 1451, 1452, 1455, 1457, 1459, 1460, 1463, 1465, 1468,
			 1470, 1473, 1475, 1478, 1480, 1480, yy_Dummy>>,
			1, 66, 800)
		end

	yy_acclist_template: SPECIAL [INTEGER]
			-- Template for `yy_acclist'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 1479)
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
			    0,  161,  161,  175,  173,  174,    2,  173,  174,    4,
			  174,    5,  173,  174,    1,  173,  174,   11,  119,  173,
			  174, -295,  173,  174,  119,  122,  173,  174, -295, -298,
			   18,  173,  174,  173,  174,  151,  173,  174,   12,  173,
			  174,   13,  173,  174,   35,  119,  173,  174, -295,   34,
			  119,  173,  174, -295,    9,  173,  174,   33,  173,  174,
			    7,  173,  174,   36,  119,  173,  174, -295,  163,  173,
			  174,  163,  173,  174,   10,  173,  174,    8,  173,  174,
			   40,  119,  173,  174, -295,   38,  119,  173,  174, -295,
			   39,  119,  173,  174, -295,   19,  173,  174,   42,  119,

			  122,  173,  174, -295, -298,  117,  118,  173,  174,  117,
			  118,  173,  174,  117,  118,  173,  174,  117,  118,  173,
			  174,  117,  118,  173,  174,  117,  118,  173,  174,  117,
			  118,  173,  174,  117,  118,  173,  174,  117,  118,  173,
			  174,  117,  118,  173,  174,  117,  118,  173,  174,  117,
			  118,  173,  174,  117,  118,  173,  174,  117,  118,  173,
			  174,  117,  118,  173,  174,  117,  118,  173,  174,  117,
			  118,  173,  174,  117,  118,  173,  174,   16,  173,  174,
			  119,  173,  174, -295,   17,  173,  174,   37,  119,  173,
			  174, -295,  119,  173,  174, -295,  173,  174,  118,  173, yy_Dummy>>,
			1, 200, 0)
		end

	yy_acclist_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  174,  118,  173,  174,  118,  173,  174,  118,  173,  174,
			  118,  173,  174,  118,  173,  174,  118,  173,  174,  118,
			  173,  174,  118,  173,  174,  118,  173,  174,  118,  173,
			  174,  118,  173,  174,  118,  173,  174,  118,  173,  174,
			  118,  173,  174,  118,  173,  174,  118,  173,  174,  118,
			  173,  174,   14,  173,  174,   15,  173,  174,   41,  119,
			  173,  174, -295,   45,  119,  173,  174, -295,   43,  119,
			  173,  174, -295,   44,  119,  173,  174, -295,   48,  173,
			  174,   49,  173,  174,   47,  119,  173,  174, -295,   46,
			  119,  173,  174, -295,  161,  174,  156,  174,  158,  174,

			  159,  161,  174,  155,  174,  160,  174,  161,  174,    2,
			    3,    1, -121,  119, -295,  162,  162, -153, -327, -121,
			 -124,  119,  122, -295, -298,  122, -298,  151,  151,  151,
			  119, -295,    6,   26,  119, -295,   27,  170,   21,  119,
			 -295,   23,  119, -295,   32,  119, -295,  170,  163,  169,
			  169,  169,  169,  169,  169,   31,   28,  119, -295,   25,
			  119, -295,   24,  119, -295,   29,  119, -295,   20,   30,
			   42, -121, -124,  117,  118,  117,  118,  117,  118,  117,
			  118,  117,  118,   54,  117,  118,  117,  118,  118,  118,
			  118,  118,  118,   54,  118,  118,  117,  118,  117,  118, yy_Dummy>>,
			1, 200, 200)
		end

	yy_acclist_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  117,  118,  117,  118,  117,  118,  118,  118,  118,  118,
			  118,  117,  118,   64,  117,  118,  118,   64,  118,  117,
			  118,  117,  118,  117,  118,  118,  118,  118,  117,  118,
			  117,  118,  117,  118,  118,  118,  118,   76,  117,  118,
			  117,  118,  117,  118,   81,  117,  118,   76,  118,  118,
			  118,   81,  118,  117,  118,  117,  118,  118,  118,  117,
			  118,  118,  117,  118,  117,  118,  117,  118,   89,  117,
			  118,  118,  118,  118,   89,  118,  117,  118,  118,  117,
			  118,  118,  117,  118,  117,  118,  117,  118,  118,  118,
			  118,  117,  118,  117,  118,  118,  118,  117,  118,  118,

			  117,  118,  117,  118,  118,  118,  117,  118,  118,  117,
			  118,  118,   22,  119, -295,   45, -121,   43, -121,   44,
			 -121,   48,   49,   47, -121,   46, -121,  161,  156,  157,
			  161,  161,  155,  154,  119, -153,  119,  122, -124,  122,
			  119,  122, -295, -298,  122, -298,  151,  125,  151,  151,
			  151,  151,  151,  151,  151,  151,  151,  151,  151,  151,
			  151,  151,  151,  151,  151,  151,  151,  151,  151,  151,
			  151,  170,  164,  170,  163,  169,  167,  168,  169,  168,
			  169,  166,  168,  169,  165,  168,  169,  163,  169,  169,
			  117,  118,  118,  117,  118,  118,  117,  118,   52,  117, yy_Dummy>>,
			1, 200, 400)
		end

	yy_acclist_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  118,  118,   52,  118,   53,  117,  118,   53,  118,  117,
			  118,  118,  117,  118,  118,  117,  118,  118,  117,  118,
			  118,  117,  118,  118,  117,  118,  118,  117,  118,  118,
			  117,  118,  117,  118,  117,  118,  118,  118,  118,  117,
			  118,  118,   67,  117,  118,  117,  118,   67,  118,  118,
			  117,  118,  117,  118,  118,  118,  117,  118,  118,  117,
			  118,  118,  117,  118,  118,  117,  118,  118,  117,  118,
			  117,  118,  117,  118,  117,  118,  118,  118,  118,  118,
			  117,  118,  118,  117,  118,  117,  118,  118,  118,   85,
			  117,  118,   85,  118,  117,  118,  118,   87,  117,  118,

			   87,  118,  117,  118,  118,  117,  118,  118,  117,  118,
			  117,  118,  117,  118,  117,  118,  117,  118,  117,  118,
			  118,  118,  118,  118,  118,  118,  117,  118,  117,  118,
			  118,  118,  117,  118,  118,  117,  118,  118,  117,  118,
			  118,  117,  118,  118,  117,  118,  117,  118,  117,  118,
			  118,  118,  118,  117,  118,  118,  117,  118,  118,  117,
			  118,  118,  109,  117,  118,  109,  118,  172,  171,  120,
			  120,  123,  123,  142,  140,  141,  143,  144,  152,  152,
			  145,  146,  126,  127,  128,  129,  130,  131,  132,  133,
			  134,  135,  136,  137,  138,  139,  170,  170,  170,  170, yy_Dummy>>,
			1, 200, 600)
		end

	yy_acclist_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  163,  169,  168,  169,  168,  169,  168,  169,  163,  169,
			  163,  169,  117,  118,  118,  117,  118,  118,  117,  118,
			  118,  117,  118,  118,  117,  118,  117,  118,  118,  118,
			  117,  118,  118,  117,  118,  118,  117,  118,  118,  117,
			  118,  118,  117,  118,  118,  117,  118,  118,  117,  118,
			  118,  117,  118,  118,   65,  117,  118,   65,  118,  117,
			  118,  118,  117,  118,  117,  118,  118,  118,  117,  118,
			  118,  117,  118,  118,  117,  118,  118,   74,  117,  118,
			  117,  118,   74,  118,  118,  117,  118,  118,  117,  118,
			  118,  117,  118,  118,  117,  118,  118,  117,  118,  118,

			   82,  117,  118,   82,  118,  117,  118,  118,   84,  117,
			  118,   84,  118,  114,  117,  118,  114,  118,  117,  118,
			  118,   88,  117,  118,   88,  118,  117,  118,  118,  117,
			  118,  118,  117,  118,  118,  117,  118,  118,  117,  118,
			  118,  117,  118,  117,  118,  118,  118,  117,  118,  118,
			  117,  118,  118,  117,  118,  118,  115,  117,  118,  115,
			  118,  117,  118,  118,  101,  117,  118,  101,  118,  102,
			  117,  118,  102,  118,  117,  118,  118,  117,  118,  118,
			  117,  118,  118,  117,  118,  118,  107,  117,  118,  107,
			  118,  108,  117,  118,  108,  118,  152,  170,  170,  170, yy_Dummy>>,
			1, 200, 800)
		end

	yy_acclist_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  170,  163,  169,  117,  118,  118,   50,  117,  118,   50,
			  118,   51,  117,  118,   51,  118,  117,  118,  118,  117,
			  118,  118,  117,  118,  118,   56,  117,  118,   56,  118,
			   57,  117,  118,   57,  118,  117,  118,  118,  117,  118,
			  118,  117,  118,  118,   62,  117,  118,   62,  118,  117,
			  118,  118,  117,  118,  118,  117,  118,  118,  117,  118,
			  118,  117,  118,  118,  117,  118,  118,  117,  118,  118,
			   72,  117,  118,   72,  118,  117,  118,  118,  117,  118,
			  118,  117,  118,  118,  117,  118,  118,  117,  118,  118,
			  117,  118,  118,  117,  118,  118,   83,  117,  118,   83,

			  118,  117,  118,  118,  117,  118,  118,  117,  118,  118,
			  117,  118,  118,  117,  118,  118,  117,  118,  118,  117,
			  118,  118,  117,  118,  118,   97,  117,  118,   97,  118,
			  117,  118,  118,  117,  118,  118,  100,  117,  118,  100,
			  118,  117,  118,  118,  117,  118,  118,  105,  117,  118,
			  105,  118,  117,  118,  118,  147,  170,  170,  170,  110,
			  117,  118,  110,  118,   55,  117,  118,   55,  118,  117,
			  118,  118,  117,  118,  118,  117,  118,  118,   59,  117,
			  118,  117,  118,   59,  118,  118,  117,  118,  118,  117,
			  118,  118,  117,  118,  118,   66,  117,  118,   66,  118, yy_Dummy>>,
			1, 200, 1000)
		end

	yy_acclist_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			   68,  117,  118,   68,  118,  117,  118,  118,   70,  117,
			  118,   70,  118,  117,  118,  118,  117,  118,  118,   75,
			  117,  118,   75,  118,  117,  118,  118,  117,  118,  118,
			  117,  118,  118,  117,  118,  118,  117,  118,  118,  117,
			  118,  118,  117,  118,  118,  117,  118,  118,  117,  118,
			  118,   93,  117,  118,   93,  118,  117,  118,  118,   95,
			  117,  118,   95,  118,   96,  117,  118,   96,  118,   98,
			  117,  118,   98,  118,  117,  118,  118,  117,  118,  118,
			  104,  117,  118,  104,  118,  117,  118,  118,  170,  170,
			  170,  170,  117,  118,  118,  117,  118,  118,   58,  117,

			  118,   58,  118,  117,  118,  118,   61,  117,  118,   61,
			  118,  117,  118,  118,  117,  118,  118,  117,  118,  118,
			  117,  118,  118,   73,  117,  118,   73,  118,   77,  117,
			  118,   77,  118,  117,  118,  118,   78,  117,  118,   78,
			  118,   79,  117,  118,   79,  118,  117,  118,  118,  117,
			  118,  118,  117,  118,  118,  117,  118,  118,  117,  118,
			  118,   94,  117,  118,   94,  118,  117,  118,  118,  117,
			  118,  118,  106,  117,  118,  106,  118,  150,  149,  148,
			  170,  170,  170,  170,  170,  111,  117,  118,  111,  118,
			  117,  118,  118,   60,  117,  118,   60,  118,   63,  117, yy_Dummy>>,
			1, 200, 1200)
		end

	yy_acclist_template_8 (an_array: ARRAY [INTEGER])
			-- Fill chunk #8 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  118,   63,  118,  117,  118,  118,   69,  117,  118,   69,
			  118,   71,  117,  118,   71,  118,  116,  117,  118,  116,
			  118,  117,  118,  118,   86,  117,  118,   86,  118,  117,
			  118,  118,   92,  117,  118,   92,  118,  117,  118,  118,
			   99,  117,  118,   99,  118,  103,  117,  118,  103,  118,
			  170,  170,  112,  117,  118,  112,  118,  117,  118,  118,
			   80,  117,  118,   80,  118,   90,  117,  118,   90,  118,
			   91,  117,  118,   91,  118,  113,  117,  118,  113,  118, yy_Dummy>>,
			1, 80, 1400)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER = 2480
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER = 864
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER = 865
			-- Mark between normal states and templates

	yyNull_equiv_class: INTEGER = 104
			-- Equivalence code for NULL character

	yyMax_symbol_equiv_class: INTEGER = 127947
			-- All symbols greater than this symbol will have
			-- the same equivalence class as this symbol

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

	yyNb_rules: INTEGER = 174
			-- Number of rules

	yyEnd_of_buffer: INTEGER = 175
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
	copyright:	"Copyright (c) 1984-2021, Eiffel Software"
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
