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
								
when 50 then
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
								
when 51 then
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
								
when 52 then
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
								
when 53 then
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
								
when 54 then
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
								
when 55 then
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
								
when 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115 then
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
								
when 116, 117, 118, 119, 120, 121 then
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
						
when 122 then
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
						
when 123 then
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
						
when 124 then
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
						
when 125, 126 then
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
										
when 127 then
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
										
when 128 then
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
										
when 129 then
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
										
when 130 then
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
										
when 131 then
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
										
when 132 then
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
										
when 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158 then
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
	
when 159, 160 then
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
	
when 161 then
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
	
when 162 then
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
		
when 163 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

			curr_token := new_space (text_count)
			update_token_list						
		
when 164 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

			curr_token := new_tabulation (text_count)
			update_token_list						
		
when 165 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

			curr_token := new_eol (True)
			update_token_list
			in_comments := False
		
when 166 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

			curr_token := new_eol (False)
			update_token_list
			in_comments := False
		
when 167 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

			curr_token := new_text
			update_token_list
		
when 168 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

			curr_token := new_string
			update_token_list
		
when 169 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

			curr_token := new_string
			update_token_list
		
when 170 then
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
	
when 171 then
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
	
when 172 then
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
	
when 173, 174, 175 then
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
	
when 176, 177 then
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
	
when 178 then
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
	
when 179, 180 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

		curr_token := new_text_in_comment
		update_token_list
	
when 181 then
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
	
when 182 then
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
			create an_array.make_filled (0, 0, 2717)
			yy_nxt_template_1 (an_array)
			yy_nxt_template_2 (an_array)
			an_array.area.fill_with (136, 380, 405)
			yy_nxt_template_3 (an_array)
			an_array.area.fill_with (143, 412, 437)
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
			an_array.area.fill_with (904, 2615, 2717)
			Result := yy_fixed_array (an_array)
		end

	yy_nxt_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			    0,    7,    8,    6,    9,   10,   11,   12,   13,   14,
			   15,   16,   17,   18,   19,   20,   21,   22,   23,   24,
			   25,   26,   26,   26,   27,   28,   29,   30,   31,   32,
			   33,   34,   35,   36,   37,   38,   34,   34,   39,   34,
			   34,   40,   34,   41,   42,   43,   34,   44,   45,   46,
			   47,   48,   49,   50,   34,   34,   51,   52,   53,   54,
			   55,   56,   57,   58,   59,   60,   61,   62,   58,   58,
			   63,   58,   58,   64,   58,   65,   66,   67,   58,   68,
			   69,   70,   71,   72,   73,   74,   58,   58,   75,   76,
			   77,   55,   78,    6,    6,    6,   55,   79,   80,   81,

			   82,   83,   84,    6,   86,   87,  101,   88,   89,  102,
			   90,   86,   87,  101,   88,   89,  102,   90,   95,   95,
			   95,   95,   95,  111,  112,   95,   95,   95,   95,   95,
			  701,  114,  188,  116,   97,  117,  117,  117,  117,  118,
			  790,   97,  115,   98,  252,   99,  198,  119,  129,  130,
			   98,  200,   99,  253,  121,  103,  122,  122,  122,  122,
			  849,   91,  131,  132,  189,  212,  160,  848,   91,  133,
			  133,  133,  133,  133,  214,  254,  161,  121,  199,  122,
			  122,  122,  122,  201,  904,  134,  255,  103,  215,  847,
			  124,  125,   91,  296,  296,  135,  127,  213,  162,   91, yy_Dummy>>,
			1, 200, 0)
		end

	yy_nxt_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			   95,   95,   95,   95,   95,  104,  216,  104,  163,  164,
			  120,  165,  126,  104,  104,  254,  106,  218,  104,  127,
			  217,  166,  124,  125,  253,  107,  104,  108,  784,  150,
			  170,  184,  220,  151,  171,  189,  152,  185,  176,  153,
			  202,  167,  154,  168,  126,  177,  178,  172,  186,  219,
			  203,  179,  199,  169,  187,  204,  104,  701,  104,  104,
			  104,  155,  173,  186,  221,  156,  174,  189,  157,  187,
			  180,  158,  205,  105,  159,  201,  213,  181,  182,  175,
			  186,  105,  206,  183,  199,  101,  187,  207,  102,  104,
			  104,  104,  104,  292,   96,   96,   96,   96,  698,  698,

			   96,   96,  136,  136,  136,  136,  219,  201,  213,  221,
			  474,  302,  136,  136,  137,  136,  136,  136,  138,  136,
			  136,  136,  136,  139,  136,  140,  136,  136,  136,  136,
			  141,  142,  136,  136,  136,  136,  136,  136,  219,  702,
			  702,  221,  136,  303,  143,  143,  144,  143,  143,  143,
			  145,  143,  143,  143,  143,  146,  143,  147,  143,  143,
			  143,  143,  148,  149,  143,  143,  143,  143,  143,  143,
			  136,  136,  136,  136,  298,  298,  298,  304,  597,  310, yy_Dummy>>,
			1, 180, 200)
		end

	yy_nxt_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  699,  699,  699,  305,  136,  311, yy_Dummy>>,
			1, 6, 406)
		end

	yy_nxt_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  190,  208,  173,  312,  144,  314,  174,  162,  145,  303,
			  191,  209,  192,  146,  305,  147,  193,  163,  155,  175,
			  148,  149,  156,  105,  596,  157,  101,  434,  158,  102,
			  587,  159,  194,  210,  173,  313,  144,  315,  174,  162,
			  145,  303,  195,  211,  196,  146,  305,  147,  197,  163,
			  155,  175,  148,  149,  156,  205,  167,  157,  168,  180,
			  158,  194,  216,  159,  210,  206,  181,  182,  169,  311,
			  207,  195,  183,  196,  211,  103,  217,  197,  586,  224,
			  224,  224,  224,  224,  412,  474,  463,  205,  167,  109,
			  168,  180,  789,  194,  216,  225,  210,  206,  181,  182,

			  169,  311,  207,  195,  183,  196,  211,  103,  217,  197,
			  226,  226,  226,  226,  226,  228,  228,  228,  228,  228,
			  230,  230,  230,  230,  230,  239,  227,  313,  240,  240,
			  784,  229,  462,  790,  413,  315,  231,  232,  232,  232,
			  232,  232,  234,  234,  234,  234,  234,  236,  236,  236,
			  236,  236,  240,  233,  306,  240,  245,  307,  235,  313,
			  264,  240,  242,  237,  243,  240,  241,  315,  316,  105,
			  241,  265,  246,  461,  414,  238,  247,  247,  247,  247,
			  247,  257,  241,  253,  257,  257,  308,  101,  318,  309,
			  102,  460,  248,  320,  322,  459,  290,  290,  290,  290, yy_Dummy>>,
			1, 200, 438)
		end

	yy_nxt_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  317,  249,  324,  250,  904,  904,  904,  904,  904,  241,
			  291,  317,  292,  241,  293,  293,  293,  293,  244,  121,
			  319,  295,  295,  295,  295,  321,  323,  308,  294,  415,
			  309,  319,  321,  323,  325,  325,  103,  700,  253,  700,
			  241,  458,  291,  317,  457,  332,  333,  342,  904,  244,
			  300,  300,  300,  300,  344,  456,  704,  346,  704,  308,
			  294,  127,  309,  319,  321,  323,  416,  325,  103,  247,
			  247,  247,  247,  247,  104,  253,  104,  333,  333,  343,
			  455,  343,  104,  104,  326,  258,  345,  104,  327,  347,
			  301,  334,  296,  296,  259,  104,  260,  454,  904,  904,

			  904,  904,  328,  329,  904,  904,  335,  330,  338,  336,
			  340,  345,  339,  343,  341,  347,  329,  348,  349,  358,
			  330,  331,  359,  336,  337,  104,  453,  104,  104,  104,
			  364,  452,  472,  451,  331,  329,  360,  450,  337,  330,
			  340,  336,  340,  345,  341,  365,  341,  347,  361,  349,
			  349,  359,  449,  331,  359,  448,  337,  445,  104,  104,
			  104,  104,  365,   96,   96,   96,   96,  362,  362,   96,
			   96,  904,  904,  904,  904,  904,  261,  365,  261,  363,
			  363,  366,  368,  370,  261,  261,  350,  262,  354,  261,
			  351,  367,  355,  369,  371,  444,  263,  261,  443,  362, yy_Dummy>>,
			1, 200, 638)
		end

	yy_nxt_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  372,  352,  373,  356,  353,  386,  357,  390,  392,  387,
			  391,  363,  388,  367,  369,  371,  389,  393,  354,  394,
			  354,  396,  355,  367,  355,  369,  371,  261,  442,  261,
			  261,  261,  373,  356,  373,  356,  357,  388,  357,  391,
			  393,  389,  391,  395,  388,  703,  703,  703,  389,  393,
			  397,  395,  404,  397,  398,  406,  405,  407,  408,  399,
			  261,  261,  261,  261,  441,  251,  251,  251,  251,  246,
			  400,  251,  251,  268,  409,  395,  269,  270,  271,  272,
			  232,  230,  397,  133,  405,  273,  401,  407,  405,  407,
			  409,  402,  274,  410,  275,  411,  276,  277,  278,  279,

			  904,  280,  403,  281,  267,  264,  409,  282,  256,  283,
			  478,   94,  284,  285,  286,  287,  288,  289,  299,  299,
			  299,  299,  479,  480,  374,  411,  375,  411,  299,  299,
			  299,  299,  299,  299,  376,  417,  380,  377,  381,  378,
			  379,  418,  479,  401,  253,   92,  382,  481,  402,  383,
			  253,  384,  385,  222,  479,  481,  380,  128,  381,  403,
			  299,  299,  299,  299,  299,  299,  382,   94,  380,  383,
			  381,  384,  385,  239,   93,  401,  240,  240,  382,  481,
			  402,  383,  240,  384,  385,  240,  240,  482,   92,  240,
			  241,  403,  243,  240,  241,  904,  246,  240,  904,  238, yy_Dummy>>,
			1, 200, 838)
		end

	yy_nxt_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  240,  245,  419,  419,  419,  419,  419,  421,  421,  421,
			  421,  421,  423,  423,  423,  423,  423,  420,  420,  483,
			  425,  483,  904,  422,  588,  904,  253,  253,  424,   98,
			  241,   99,  904,  253,  255,  432,  433,  433,  433,  241,
			  426,  426,  426,  426,  426,  904,  244,  428,  428,  428,
			  428,  428,  484,  483,  241,  904,  427,  446,  447,  447,
			  447,  241,  904,  429,  430,  430,  430,  430,  430,  257,
			  241,  253,  257,  257,  485,  101,  904,  244,  102,  904,
			  431,  904,  490,  904,  485,  241,  419,  419,  419,  419,
			  419,  421,  421,  421,  421,  421,  423,  423,  423,  423,

			  423,  904,  434,  465,  437,  465,  485,  435,  466,  466,
			  466,  466,  436,  107,  491,  108,  105,  904,  265,  904,
			  904,  904,  904,  904,  103,  426,  426,  426,  426,  426,
			  428,  428,  428,  428,  428,  430,  430,  430,  430,  430,
			  904,  438,  904,  491,  589,  904,  439,  298,  298,  298,
			  107,  440,  108,  253,  253,  107,  103,  108,  904,  904,
			  107,  904,  108,  464,  464,  464,  464,  492,  296,  296,
			  253,  467,  467,  467,  467,  491,  469,  291,  469,  493,
			  494,  470,  470,  470,  470,  468,  121,  473,  471,  471,
			  471,  471,  475,  486,  476,  476,  476,  476,  904,  493, yy_Dummy>>,
			1, 200, 1038)
		end

	yy_nxt_template_8 (an_array: ARRAY [INTEGER])
			-- Fill chunk #8 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  477,  477,  477,  477,  488,  495,  496,  497,  472,  291,
			  487,  493,  495,  904,  904,  904,  904,  468,  498,  904,
			  904,  489,  499,  500,  502,  488,  504,  501,  127,  503,
			  505,  506,  507,  508,  301,  509,  488,  495,  497,  497,
			  301,  514,  489,  510,  515,  516,  512,  517,  518,  519,
			  499,  904,  524,  489,  499,  501,  503,  511,  505,  501,
			  513,  503,  505,  507,  507,  509,  525,  509,  526,  520,
			  522,  528,  530,  515,  532,  512,  515,  517,  512,  517,
			  519,  519,  521,  523,  525,  527,  529,  531,  533,  513,
			  534,  535,  513,  536,  538,  537,  539,  540,  525,  541,

			  527,  522,  522,  529,  531,  542,  533,  543,  544,  545,
			  546,  547,  548,  550,  523,  523,  552,  527,  529,  531,
			  533,  554,  535,  535,  560,  537,  539,  537,  539,  541,
			  549,  541,  556,  551,  553,  555,  558,  543,  561,  543,
			  545,  545,  547,  547,  549,  551,  562,  564,  553,  563,
			  557,  565,  566,  555,  559,  567,  561,  568,  569,  570,
			  571,  572,  549,  573,  558,  551,  553,  555,  558,  574,
			  561,  576,  578,  575,  577,  579,  580,  581,  563,  565,
			  582,  563,  559,  565,  567,  583,  559,  567,  584,  569,
			  569,  571,  571,  573,  585,  573,  109,  433,  433,  433, yy_Dummy>>,
			1, 200, 1238)
		end

	yy_nxt_template_9 (an_array: ARRAY [INTEGER])
			-- Fill chunk #9 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  433,  575,  904,  577,  579,  575,  577,  579,  581,  581,
			  904,  904,  583,  466,  466,  466,  466,  583,  904,  904,
			  585,  109,  433,  433,  433,  433,  585,  904,  904,  904,
			  904,  904,  610,  590,  591,  904,  611,  593,  466,  466,
			  466,  466,  428,  428,  428,  428,  428,  428,  428,  428,
			  428,  428,  612,  613,  614,  592,  615,  616,  594,  904,
			  904,  904,  593,  595,  611,  590,  591,  107,  611,  108,
			  617,  904,  107,  904,  108,  598,  447,  447,  447,  447,
			  470,  470,  470,  470,  613,  613,  615,  592,  615,  617,
			  904,  598,  447,  447,  447,  447,  904,  603,  603,  603,

			  603,  618,  617,  599,  600,  605,  605,  605,  605,  904,
			  620,  291,  470,  470,  470,  470,  602,  619,  904,  468,
			  904,  904,  904,  904,  904,  601,  904,  904,  904,  298,
			  298,  298,  602,  619,  904,  599,  600,  604,  621,  606,
			  622,  606,  621,  291,  607,  607,  607,  607,  623,  619,
			  608,  468,  471,  471,  471,  471,  475,  601,  609,  609,
			  609,  609,  475,  624,  477,  477,  477,  477,  625,  473,
			  621,  626,  623,  627,  628,  629,  630,  631,  632,  633,
			  623,  634,  635,  636,  637,  638,  639,  640,  641,  642,
			  644,  643,  301,  645,  646,  625,  647,  648,  301,  649, yy_Dummy>>,
			1, 200, 1438)
		end

	yy_nxt_template_10 (an_array: ARRAY [INTEGER])
			-- Fill chunk #10 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  625,  650,  651,  627,  301,  627,  629,  629,  631,  631,
			  633,  633,  652,  635,  635,  637,  637,  639,  639,  641,
			  641,  643,  645,  643,  653,  645,  647,  654,  647,  649,
			  655,  649,  656,  651,  651,  657,  658,  659,  660,  661,
			  662,  663,  664,  665,  653,  666,  667,  668,  669,  670,
			  671,  672,  673,  674,  675,  676,  653,  677,  678,  655,
			  680,  679,  655,  681,  657,  682,  683,  657,  659,  659,
			  661,  661,  663,  663,  665,  665,  684,  667,  667,  669,
			  669,  671,  671,  673,  673,  675,  675,  677,  685,  677,
			  679,  686,  681,  679,  687,  681,  688,  683,  683,  689,

			  690,  691,  692,  693,  694,  695,  696,  697,  685,  433,
			  433,  433,  433,  904,  904,  904,  904,  904,  904,  904,
			  685,  904,  904,  687,  904,  904,  687,  904,  689,  904,
			  712,  689,  691,  691,  693,  693,  695,  695,  697,  697,
			  904,  904,  904,  904,  904,  705,  705,  705,  705,  593,
			  603,  603,  603,  603,  707,  707,  707,  707,  708,  708,
			  708,  708,  713,  713,  706,  607,  607,  607,  607,  714,
			  715,  716,  468,  607,  607,  607,  607,  292,  904,  708,
			  708,  708,  708,  717,  711,  602,  477,  477,  477,  477,
			  718,  719,  720,  710,  904,  713,  706,  721,  709,  726, yy_Dummy>>,
			1, 200, 1638)
		end

	yy_nxt_template_11 (an_array: ARRAY [INTEGER])
			-- Fill chunk #11 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  727,  715,  715,  717,  468,  904,  728,  904,  904,  904,
			  904,  729,  722,  904,  904,  717,  723,  724,  730,  731,
			  732,  725,  719,  719,  721,  710,  127,  733,  734,  721,
			  735,  727,  727,  736,  904,  904,  904,  904,  729,  737,
			  904,  904,  738,  729,  724,  739,  740,  741,  725,  724,
			  731,  731,  733,  725,  742,  743,  744,  745,  746,  733,
			  735,  747,  735,  748,  749,  737,  750,  751,  752,  753,
			  754,  737,  755,  756,  739,  757,  758,  739,  741,  741,
			  759,  760,  761,  762,  763,  764,  743,  743,  745,  745,
			  747,  765,  766,  747,  767,  749,  749,  768,  751,  751,

			  753,  753,  755,  769,  755,  757,  770,  757,  759,  771,
			  772,  773,  759,  761,  761,  763,  763,  765,  774,  775,
			  776,  777,  778,  765,  767,  779,  767,  780,  781,  769,
			  109,  698,  698,  904,  904,  769,  801,  802,  771,  904,
			  904,  771,  773,  773,  109,  699,  699,  699,  904,  904,
			  775,  775,  777,  777,  779,  904,  904,  779,  803,  781,
			  781,  785,  702,  702,  787,  703,  703,  703,  802,  802,
			  904,  782,  791,  705,  705,  705,  705,  794,  794,  794,
			  794,  792,  904,  792,  904,  783,  793,  793,  793,  793,
			  804,  795,  708,  708,  708,  708,  797,  797,  797,  797, yy_Dummy>>,
			1, 200, 1838)
		end

	yy_nxt_template_12 (an_array: ARRAY [INTEGER])
			-- Fill chunk #12 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  804,  805,  786,  806,  807,  788,  796,  808,  904,  798,
			  809,  798,  810,  602,  799,  799,  799,  799,  811,  812,
			  813,  814,  815,  795,  292,  816,  797,  797,  797,  797,
			  817,  818,  804,  806,  819,  806,  808,  820,  796,  808,
			  800,  821,  810,  822,  810,  823,  824,  825,  826,  827,
			  812,  812,  814,  814,  816,  828,  829,  816,  830,  831,
			  832,  833,  818,  818,  834,  835,  820,  836,  837,  820,
			  838,  839,  800,  822,  840,  822,  841,  824,  824,  826,
			  826,  828,  842,  843,  844,  845,  846,  828,  830,  904,
			  830,  832,  832,  834,  698,  698,  834,  836,  904,  836,

			  838,  904,  838,  840,  702,  702,  840,  904,  842,  699,
			  699,  699,  904,  904,  842,  844,  844,  846,  846,  703,
			  703,  703,  793,  793,  793,  793,  793,  793,  793,  793,
			  799,  799,  799,  799,  782,  904,  850,  850,  850,  850,
			  851,  859,  851,  904,  786,  852,  852,  852,  852,  783,
			  795,  855,  855,  855,  855,  853,  860,  853,  861,  788,
			  854,  854,  854,  854,  862,  856,  799,  799,  799,  799,
			  857,  863,  857,  860,  864,  858,  858,  858,  858,  865,
			  866,  867,  795,  868,  869,  870,  871,  872,  860,  873,
			  862,  874,  875,  876,  877,  878,  862,  856,  879,  880, yy_Dummy>>,
			1, 200, 2038)
		end

	yy_nxt_template_13 (an_array: ARRAY [INTEGER])
			-- Fill chunk #13 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  881,  882,  883,  864,  884,  885,  864,  886,  887,  888,
			  904,  866,  866,  868,  904,  868,  870,  870,  872,  872,
			  795,  874,  904,  874,  876,  876,  878,  878,  904,  904,
			  880,  880,  882,  882,  884,  904,  884,  886,  904,  886,
			  888,  888,  852,  852,  852,  852,  604,  852,  852,  852,
			  852,  904,  795,  854,  854,  854,  854,  854,  854,  854,
			  854,  889,  889,  889,  889,  890,  892,  890,  893,  894,
			  891,  891,  891,  891,  895,  856,  858,  858,  858,  858,
			  858,  858,  858,  858,  896,  897,  898,  899,  900,  901,
			  891,  891,  891,  891,  902,  903,  856,  904,  893,  904,

			  893,  895,  891,  891,  891,  891,  895,  856,  123,  904,
			  123,  904,  123,  123,  123,  123,  897,  897,  899,  899,
			  901,  901,  709,  904,  904,  904,  903,  903,  856,   85,
			   85,   85,   85,   85,   85,   85,   85,   85,   85,   85,
			   85,   85,   85,   85,   85,   85,   85,   85,   96,   96,
			   96,   96,  143,  904,  143,  143,  143,  143,   96,  904,
			   96,  904,  904,  904,   96,   96,  100,  904,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  105,  105,  105,  105,  904,
			  105,  904,  105,  105,  105,  105,  105,  105,  105,  105, yy_Dummy>>,
			1, 200, 2238)
		end

	yy_nxt_template_14 (an_array: ARRAY [INTEGER])
			-- Fill chunk #14 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  105,  105,  105,  109,  904,  109,  109,  109,  109,  109,
			  109,  109,  109,  109,  109,  109,  109,  109,  109,  109,
			  109,  109,  110,  904,  110,  110,  110,  110,  110,  110,
			  110,  110,  110,  110,  110,  110,  110,  110,  110,  110,
			  110,  113,  297,  904,  297,  297,  297,  297,  113,  904,
			  113,  904,  904,  904,  113,  113,  223,  904,  223,  223,
			  223,  223,  904,  904,  223,  223,  223,  223,  223,  223,
			  223,  223,  223,  904,  223,  238,  238,  904,  238,  238,
			  238,  238,  238,  238,  238,  238,  238,  238,  238,  238,
			  238,  238,  244,  904,  244,  244,  244,  244,  244,  244,

			  244,  244,  244,  244,  244,  244,  244,  244,  244,  244,
			  244,  251,  904,  904,  904,  904,  904,  904,  251,  904,
			  904,  904,  904,  904,  251,  251,  109,  904,  109,  109,
			  109,  904,  109,  904,  109,  109,  904,  109,  266,  904,
			  266,  266,  266,  266,  266,  266,  266,  266,  266,  266,
			  266,  266,  266,  266,  266,  266,  266,  241,  904,  241,
			  241,  241,  241,  904,  241,  241,  241,  241,  241,  241,
			  241,  241,  241,  241,  241,  241,    5, yy_Dummy>>,
			1, 177, 2438)
		end

	yy_chk_template: SPECIAL [INTEGER]
			-- Template for `yy_chk'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 2717)
			an_array.put (0, 0)
			an_array.area.fill_with (1, 1, 103)
			yy_chk_template_1 (an_array)
			yy_chk_template_2 (an_array)
			an_array.area.fill_with (33, 312, 337)
			yy_chk_template_3 (an_array)
			an_array.area.fill_with (33, 344, 369)
			yy_chk_template_4 (an_array)
			an_array.area.fill_with (34, 380, 405)
			yy_chk_template_5 (an_array)
			an_array.area.fill_with (34, 412, 437)
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
			an_array.area.fill_with (904, 2614, 2717)
			Result := yy_fixed_array (an_array)
		end

	yy_chk_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			    3,    3,   12,    3,    3,   12,    3,    4,    4,   15,
			    4,    4,   15,    4,   11,   11,   11,   11,   11,   16,
			   16,   19,   19,   19,   19,   19,  791,   22,   41,   23,
			   11,   23,   23,   23,   23,   24,  790,   19,   22,   11,
			   97,   11,   43,   24,   29,   29,   19,   44,   19,   97,
			   26,   12,   26,   26,   26,   26,  789,    3,   31,   31,
			   41,   47,   36,  787,    4,   32,   32,   32,   32,   32,
			   48,   98,   36,   25,   43,   25,   25,   25,   25,   44,
			   98,   32,   98,   12,   48,  785,   25,   25,    3,  124,
			  124,   32,   26,   47,   36,    4,   13,   13,   13,   13,

			   13,   13,   48,   13,   36,   37,   24,   37,   25,   13,
			   13,   99,   13,   49,   13,   25,   48,   37,   25,   25,
			   99,   13,   13,   13,  784,   35,   38,   40,   50,   35,
			   38,   65,   35,   40,   39,   35,   45,   37,   35,   37,
			   25,   39,   39,   38,   64,   49,   45,   39,   67,   37,
			   64,   45,   13,  598,   13,   13,   13,   35,   38,   40,
			   50,   35,   38,   65,   35,   40,   39,   35,   45,  595,
			   35,   68,   71,   39,   39,   38,   64,  594,   45,   39,
			   67,  109,   64,   45,  109,   13,   13,   13,   13,  475,
			   13,   13,   13,   13,  590,  590,   13,   13,   33,   33, yy_Dummy>>,
			1, 200, 104)
		end

	yy_chk_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			   33,   33,   73,   68,   71,   74,  474,  137, yy_Dummy>>,
			1, 8, 304)
		end

	yy_chk_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			   73,  599,  599,   74,   33,  137, yy_Dummy>>,
			1, 6, 338)
		end

	yy_chk_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			   34,   34,   34,   34,  125,  125,  125,  138,  440,  140, yy_Dummy>>,
			1, 10, 370)
		end

	yy_chk_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  591,  591,  591,  138,   34,  140, yy_Dummy>>,
			1, 6, 406)
		end

	yy_chk_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			   42,   46,   62,  141,   57,  142,   62,   60,   57,  144,
			   42,   46,   42,   57,  145,   57,   42,   60,   59,   62,
			   57,   57,   59,  439,  438,   59,  100,  437,   59,  100,
			  424,   59,   42,   46,   62,  141,   57,  142,   62,   60,
			   57,  144,   42,   46,   42,   57,  145,   57,   42,   60,
			   59,   62,   57,   57,   59,   69,   61,   59,   61,   63,
			   59,   66,   72,   59,   70,   69,   63,   63,   61,  147,
			   69,   66,   63,   66,   70,  100,   72,   66,  422,   78,
			   78,   78,   78,   78,  223,  299,  289,   69,   61,  700,
			   61,   63,  704,   66,   72,   78,   70,   69,   63,   63,

			   61,  147,   69,   66,   63,   66,   70,  100,   72,   66,
			   79,   79,   79,   79,   79,   80,   80,   80,   80,   80,
			   81,   81,   81,   81,   81,   86,   79,  148,   86,   86,
			  700,   80,  288,  704,  223,  149,   81,   82,   82,   82,
			   82,   82,   83,   83,   83,   83,   83,   84,   84,   84,
			   84,   84,   89,   82,  139,   89,   89,  139,   83,  148,
			  107,   88,   88,   84,   88,   88,   91,  149,  150,  107,
			   91,  107,   91,  287,  225,   91,   96,   96,   96,   96,
			   96,  103,   86,  225,  103,  103,  139,  103,  151,  139,
			  103,  286,   96,  152,  153,  285,  117,  117,  117,  117, yy_Dummy>>,
			1, 200, 438)
		end

	yy_chk_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  150,   96,  154,   96,  105,  105,  105,  105,  105,   89,
			  117,  155,  121,   86,  121,  121,  121,  121,   88,  122,
			  151,  122,  122,  122,  122,  152,  153,  146,  121,  227,
			  146,  156,  157,  158,  154,  159,  103,  922,  227,  922,
			   89,  284,  117,  155,  283,  164,  167,  170,  127,   88,
			  127,  127,  127,  127,  171,  282,  923,  172,  923,  146,
			  121,  122,  146,  156,  157,  158,  229,  159,  103,  104,
			  104,  104,  104,  104,  104,  229,  104,  164,  167,  170,
			  281,  173,  104,  104,  160,  104,  171,  104,  160,  172,
			  127,  165,  296,  296,  104,  104,  104,  280,  105,  105,

			  105,  105,  160,  162,  105,  105,  165,  162,  166,  168,
			  169,  174,  166,  173,  169,  175,  160,  177,  181,  184,
			  160,  162,  186,  165,  168,  104,  279,  104,  104,  104,
			  188,  278,  296,  277,  160,  162,  185,  276,  165,  162,
			  166,  168,  169,  174,  166,  189,  169,  175,  185,  177,
			  181,  184,  275,  162,  186,  274,  168,  272,  104,  104,
			  104,  104,  188,  104,  104,  104,  104,  187,  185,  104,
			  104,  106,  106,  106,  106,  106,  106,  189,  106,  187,
			  185,  190,  191,  192,  106,  106,  178,  106,  182,  106,
			  178,  194,  182,  195,  196,  271,  106,  106,  270,  187, yy_Dummy>>,
			1, 200, 638)
		end

	yy_chk_template_8 (an_array: ARRAY [INTEGER])
			-- Fill chunk #8 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  198,  178,  199,  182,  178,  202,  182,  203,  204,  202,
			  206,  187,  205,  190,  191,  192,  205,  207,  178,  208,
			  182,  209,  178,  194,  182,  195,  196,  106,  269,  106,
			  106,  106,  198,  178,  199,  182,  178,  202,  182,  203,
			  204,  202,  206,  210,  205,  600,  600,  600,  205,  207,
			  211,  208,  214,  209,  212,  215,  216,  217,  218,  212,
			  106,  106,  106,  106,  268,  106,  106,  106,  106,  241,
			  212,  106,  106,  111,  219,  210,  111,  111,  111,  111,
			  233,  231,  211,  134,  214,  111,  212,  215,  216,  217,
			  218,  212,  111,  220,  111,  221,  111,  111,  111,  111,

			  123,  111,  212,  111,  110,  108,  219,  111,  102,  111,
			  302,   94,  111,  111,  111,  111,  111,  111,  126,  126,
			  126,  126,  303,  304,  200,  220,  200,  221,  126,  126,
			  126,  126,  126,  126,  200,  235,  201,  200,  201,  200,
			  200,  237,  302,  213,  235,   92,  201,  305,  213,  201,
			  237,  201,  201,   52,  303,  304,  200,   27,  200,  213,
			  126,  126,  126,  126,  126,  126,  200,   10,  201,  200,
			  201,  200,  200,  239,    9,  213,  239,  239,  201,  305,
			  213,  201,  240,  201,  201,  240,  240,  306,    7,  243,
			  244,  213,  243,  243,  244,    5,  244,  245,    0,  244, yy_Dummy>>,
			1, 200, 838)
		end

	yy_chk_template_9 (an_array: ARRAY [INTEGER])
			-- Fill chunk #9 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  245,  245,  248,  248,  248,  248,  248,  249,  249,  249,
			  249,  249,  250,  250,  250,  250,  250,  425,  248,  306,
			  251,  308,    0,  249,  427,    0,  425,  248,  250,  251,
			  239,  251,  249,  427,  249,  256,  256,  256,  256,  240,
			  253,  253,  253,  253,  253,    0,  243,  254,  254,  254,
			  254,  254,  312,  308,  245,    0,  253,  273,  273,  273,
			  273,  239,  429,  254,  255,  255,  255,  255,  255,  257,
			  240,  429,  257,  257,  313,  257,    0,  243,  257,    0,
			  255,    0,  316,    0,  312,  245,  258,  258,  258,  258,
			  258,  259,  259,  259,  259,  259,  260,  260,  260,  260,

			  260,    0,  258,  291,  261,  291,  313,  259,  291,  291,
			  291,  291,  260,  261,  316,  261,  259,    0,  259,  262,
			  262,  262,  262,  262,  257,  263,  263,  263,  263,  263,
			  264,  264,  264,  264,  264,  265,  265,  265,  265,  265,
			    0,  263,    0,  317,  431,  586,  264,  298,  298,  298,
			  263,  265,  263,  431,  586,  264,  257,  264,    0,    0,
			  265,  587,  265,  290,  290,  290,  290,  318,  472,  472,
			  587,  293,  293,  293,  293,  317,  294,  290,  294,  319,
			  320,  294,  294,  294,  294,  293,  295,  298,  295,  295,
			  295,  295,  300,  314,  300,  300,  300,  300,  301,  318, yy_Dummy>>,
			1, 200, 1038)
		end

	yy_chk_template_10 (an_array: ARRAY [INTEGER])
			-- Fill chunk #10 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  301,  301,  301,  301,  315,  321,  322,  323,  472,  290,
			  314,  319,  320,  262,  262,  262,  262,  293,  324,  262,
			  262,  315,  325,  326,  327,  314,  328,  329,  295,  330,
			  331,  332,  333,  335,  300,  337,  315,  321,  322,  323,
			  301,  339,  314,  338,  341,  342,  340,  343,  344,  345,
			  324,    0,  348,  315,  325,  326,  327,  338,  328,  329,
			  340,  330,  331,  332,  333,  335,  349,  337,  350,  346,
			  347,  351,  352,  339,  353,  338,  341,  342,  340,  343,
			  344,  345,  346,  347,  348,  354,  355,  356,  357,  338,
			  358,  359,  340,  360,  361,  362,  363,  364,  349,  365,

			  350,  346,  347,  351,  352,  366,  353,  367,  370,  371,
			  372,  373,  374,  375,  346,  347,  376,  354,  355,  356,
			  357,  377,  358,  359,  379,  360,  361,  362,  363,  364,
			  380,  365,  378,  381,  382,  383,  384,  366,  385,  367,
			  370,  371,  372,  373,  374,  375,  386,  387,  376,  388,
			  378,  389,  390,  377,  384,  391,  379,  392,  393,  394,
			  395,  396,  380,  397,  378,  381,  382,  383,  384,  398,
			  385,  399,  400,  401,  402,  403,  404,  405,  386,  387,
			  406,  388,  378,  389,  390,  407,  384,  391,  408,  392,
			  393,  394,  395,  396,  409,  397,  433,  433,  433,  433, yy_Dummy>>,
			1, 200, 1238)
		end

	yy_chk_template_11 (an_array: ARRAY [INTEGER])
			-- Fill chunk #11 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  433,  398,    0,  399,  400,  401,  402,  403,  404,  405,
			    0,    0,  406,  465,  465,  465,  465,  407,    0,    0,
			  408,  432,  432,  432,  432,  432,  409,  434,  434,  434,
			  434,  434,  478,  432,  432,    0,  479,  433,  466,  466,
			  466,  466,  435,  435,  435,  435,  435,  436,  436,  436,
			  436,  436,  480,  481,  482,  432,  483,  484,  435,    0,
			    0,    0,  432,  436,  478,  432,  432,  435,  479,  435,
			  485,    0,  436,    0,  436,  447,  447,  447,  447,  447,
			  469,  469,  469,  469,  480,  481,  482,  432,  483,  484,
			    0,  446,  446,  446,  446,  446,    0,  464,  464,  464,

			  464,  486,  485,  446,  446,  467,  467,  467,  467,    0,
			  487,  464,  470,  470,  470,  470,  447,  488,    0,  467,
			    0,  434,  434,  434,  434,  446,    0,  434,  434,  473,
			  473,  473,  446,  486,    0,  446,  446,  464,  489,  468,
			  490,  468,  487,  464,  468,  468,  468,  468,  491,  488,
			  471,  467,  471,  471,  471,  471,  476,  446,  476,  476,
			  476,  476,  477,  492,  477,  477,  477,  477,  493,  473,
			  489,  494,  490,  495,  496,  497,  498,  499,  500,  501,
			  491,  502,  503,  504,  505,  506,  507,  508,  509,  510,
			  511,  512,  471,  513,  514,  492,  515,  516,  476,  517, yy_Dummy>>,
			1, 200, 1438)
		end

	yy_chk_template_12 (an_array: ARRAY [INTEGER])
			-- Fill chunk #12 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  493,  518,  519,  494,  477,  495,  496,  497,  498,  499,
			  500,  501,  521,  502,  503,  504,  505,  506,  507,  508,
			  509,  510,  511,  512,  523,  513,  514,  524,  515,  516,
			  525,  517,  526,  518,  519,  527,  528,  529,  530,  531,
			  532,  533,  536,  537,  521,  542,  543,  546,  547,  548,
			  549,  550,  551,  552,  553,  554,  523,  555,  556,  524,
			  557,  558,  525,  559,  526,  560,  561,  527,  528,  529,
			  530,  531,  532,  533,  536,  537,  562,  542,  543,  546,
			  547,  548,  549,  550,  551,  552,  553,  554,  563,  555,
			  556,  564,  557,  558,  565,  559,  568,  560,  561,  569,

			  574,  575,  576,  577,  578,  579,  580,  581,  562,  593,
			  593,  593,  593,  596,  596,  596,  596,  596,    0,    0,
			  563,    0,    0,  564,    0,    0,  565,    0,  568,    0,
			  610,  569,  574,  575,  576,  577,  578,  579,  580,  581,
			  597,  597,  597,  597,  597,  602,  602,  602,  602,  593,
			  603,  603,  603,  603,  604,  604,  604,  604,  605,  605,
			  605,  605,  610,  611,  603,  606,  606,  606,  606,  616,
			  617,  618,  605,  607,  607,  607,  607,  608,    0,  608,
			  608,  608,  608,  619,  609,  602,  609,  609,  609,  609,
			  620,  621,  626,  608,    0,  611,  603,  627,  605,  630, yy_Dummy>>,
			1, 200, 1638)
		end

	yy_chk_template_13 (an_array: ARRAY [INTEGER])
			-- Fill chunk #13 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  631,  616,  617,  618,  605,    0,  634,  596,  596,  596,
			  596,  635,  628,  596,  596,  619,  628,  629,  636,  637,
			  638,  629,  620,  621,  626,  608,  609,  639,  640,  627,
			  641,  630,  631,  642,  597,  597,  597,  597,  634,  643,
			  597,  597,  644,  635,  628,  645,  646,  647,  628,  629,
			  636,  637,  638,  629,  650,  651,  652,  653,  654,  639,
			  640,  655,  641,  656,  657,  642,  658,  659,  660,  661,
			  662,  643,  663,  666,  644,  667,  668,  645,  646,  647,
			  669,  670,  671,  672,  673,  674,  650,  651,  652,  653,
			  654,  675,  676,  655,  677,  656,  657,  678,  658,  659,

			  660,  661,  662,  679,  663,  666,  680,  667,  668,  681,
			  684,  685,  669,  670,  671,  672,  673,  674,  686,  687,
			  690,  691,  692,  675,  676,  693,  677,  696,  697,  678,
			  698,  698,  698,    0,    0,  679,  716,  717,  680,    0,
			    0,  681,  684,  685,  699,  699,  699,  699,    0,    0,
			  686,  687,  690,  691,  692,    0,    0,  693,  718,  696,
			  697,  702,  702,  702,  703,  703,  703,  703,  716,  717,
			    0,  698,  705,  705,  705,  705,  705,  707,  707,  707,
			  707,  706,    0,  706,    0,  699,  706,  706,  706,  706,
			  718,  707,  708,  708,  708,  708,  709,  709,  709,  709, yy_Dummy>>,
			1, 200, 1838)
		end

	yy_chk_template_14 (an_array: ARRAY [INTEGER])
			-- Fill chunk #14 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  719,  720,  702,  721,  723,  703,  708,  725,    0,  710,
			  726,  710,  727,  705,  710,  710,  710,  710,  728,  729,
			  730,  731,  736,  707,  711,  737,  711,  711,  711,  711,
			  740,  741,  719,  720,  742,  721,  723,  743,  708,  725,
			  711,  746,  726,  747,  727,  748,  749,  750,  751,  752,
			  728,  729,  730,  731,  736,  753,  754,  737,  755,  756,
			  757,  758,  740,  741,  759,  760,  742,  761,  762,  743,
			  763,  766,  711,  746,  767,  747,  774,  748,  749,  750,
			  751,  752,  775,  776,  777,  780,  781,  753,  754,    0,
			  755,  756,  757,  758,  782,  782,  759,  760,    0,  761,

			  762,    0,  763,  766,  786,  786,  767,    0,  774,  783,
			  783,  783,    0,    0,  775,  776,  777,  780,  781,  788,
			  788,  788,  792,  792,  792,  792,  793,  793,  793,  793,
			  798,  798,  798,  798,  782,    0,  794,  794,  794,  794,
			  795,  801,  795,    0,  786,  795,  795,  795,  795,  783,
			  794,  797,  797,  797,  797,  796,  802,  796,  803,  788,
			  796,  796,  796,  796,  804,  797,  799,  799,  799,  799,
			  800,  807,  800,  801,  808,  800,  800,  800,  800,  811,
			  812,  813,  794,  814,  815,  816,  817,  818,  802,  823,
			  803,  824,  829,  830,  831,  832,  804,  797,  833,  834, yy_Dummy>>,
			1, 200, 2038)
		end

	yy_chk_template_15 (an_array: ARRAY [INTEGER])
			-- Fill chunk #15 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  835,  836,  837,  807,  838,  841,  808,  842,  843,  844,
			    0,  811,  812,  813,    0,  814,  815,  816,  817,  818,
			  850,  823,    0,  824,  829,  830,  831,  832,    0,    0,
			  833,  834,  835,  836,  837,    0,  838,  841,    0,  842,
			  843,  844,  851,  851,  851,  851,  850,  852,  852,  852,
			  852,    0,  850,  853,  853,  853,  853,  854,  854,  854,
			  854,  855,  855,  855,  855,  856,  861,  856,  862,  867,
			  856,  856,  856,  856,  868,  855,  857,  857,  857,  857,
			  858,  858,  858,  858,  875,  876,  879,  880,  883,  884,
			  890,  890,  890,  890,  894,  895,  889,    0,  861,    0,

			  862,  867,  891,  891,  891,  891,  868,  855,  912,    0,
			  912,    0,  912,  912,  912,  912,  875,  876,  879,  880,
			  883,  884,  889,    0,    0,    0,  894,  895,  889,  905,
			  905,  905,  905,  905,  905,  905,  905,  905,  905,  905,
			  905,  905,  905,  905,  905,  905,  905,  905,  906,  906,
			  906,  906,  914,    0,  914,  914,  914,  914,  906,    0,
			  906,    0,    0,    0,  906,  906,  907,    0,  907,  907,
			  907,  907,  907,  907,  907,  907,  907,  907,  907,  907,
			  907,  907,  907,  907,  907,  908,  908,  908,  908,    0,
			  908,    0,  908,  908,  908,  908,  908,  908,  908,  908, yy_Dummy>>,
			1, 200, 2238)
		end

	yy_chk_template_16 (an_array: ARRAY [INTEGER])
			-- Fill chunk #16 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  908,  908,  908,  909,    0,  909,  909,  909,  909,  909,
			  909,  909,  909,  909,  909,  909,  909,  909,  909,  909,
			  909,  909,  910,    0,  910,  910,  910,  910,  910,  910,
			  910,  910,  910,  910,  910,  910,  910,  910,  910,  910,
			  910,  911,  920,    0,  920,  920,  920,  920,  911,    0,
			  911,    0,    0,    0,  911,  911,  913,    0,  913,  913,
			  913,  913,    0,    0,  913,  913,  913,  913,  913,  913,
			  913,  913,  913,    0,  913,  915,  915,    0,  915,  915,
			  915,  915,  915,  915,  915,  915,  915,  915,  915,  915,
			  915,  915,  916,    0,  916,  916,  916,  916,  916,  916,

			  916,  916,  916,  916,  916,  916,  916,  916,  916,  916,
			  916,  917,    0,    0,    0,    0,    0,    0,  917,    0,
			    0,    0,    0,    0,  917,  917,  918,    0,  918,  918,
			  918,    0,  918,    0,  918,  918,    0,  918,  919,    0,
			  919,  919,  919,  919,  919,  919,  919,  919,  919,  919,
			  919,  919,  919,  919,  919,  919,  919,  921,    0,  921,
			  921,  921,  921,    0,  921,  921,  921,  921,  921,  921,
			  921,  921,  921,  921,  921,  921, yy_Dummy>>,
			1, 176, 2438)
		end

	yy_base_template: SPECIAL [INTEGER]
			-- Template for `yy_base'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 923)
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
			    0,    0,    0,  103,  110, 1033, 2614, 1025, 2614, 1010,
			 1000,  117,   99,  199, 2614,  106,  113, 2614, 2614,  124,
			    0, 2614,  114,  115,  120,  159,  136,  968, 2614,  122,
			    0,  135,  168,  282,  350,  192,  132,  168,  200,  203,
			  193,   88,  407,   99,  117,  206,  402,  122,  144,  180,
			  188, 2614,  934, 2614,    0,    0,    0,  410,    0,  419,
			  411,  453,  410,  462,  210,  191,  468,  205,  241,  459,
			  465,  233,  470,  269,  265, 2614, 2614,    0,  516,  547,
			  552,  557,  574,  579,  584,    0,  562, 2614,  598,  589,
			 2614,  603,  982, 2614,  944, 2614,  613,  127,  158,  198,

			  457, 2614,  927,  618,  706,  641,  808,  581,  926,  278,
			  931,  904,    0,    0, 2614, 2614, 2614,  614,    0,    0,
			    0,  632,  639,  920,  173,  354,  936,  668, 2614, 2614,
			    0,    0, 2614, 2614,  904, 2614,    0,  264,  343,  554,
			  346,  393,  394,    0,  400,  418,  627,  474,  517,  524,
			  572,  596,  588,  598,  593,  615,  639,  627,  637,  626,
			  691,    0,  710,    0,  635,  696,  701,  636,  714,  703,
			  644,  662,  651,  678,  719,  709,    0,  710,  791,    0,
			    0,  711,  793,    0,  717,  742,  720,  773,  719,  734,
			  771,  787,  789,    0,  781,  798,  800,    0,  804,  806, yy_Dummy>>,
			1, 200, 0)
		end

	yy_base_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			  929,  941,  802,  803,  799,  809,  806,  808,  823,  809,
			  847,  838,  859,  948,  843,  855,  847,  857,  862,  878,
			  884,  886,    0,  511, 2614,  595, 2614,  650, 2614,  687,
			 2614,  902, 2614,  901, 2614,  956, 2614,  962,    0, 1010,
			 1019,  900, 2614, 1026, 1027, 1034, 2614, 2614, 1039, 1044,
			 1049, 1041, 2614, 1077, 1084, 1101, 1053, 1106, 1123, 1128,
			 1133, 1125, 1156, 1162, 1167, 1172, 2614, 2614,  891,  855,
			  825,  822,  784, 1075,  782,  779,  764,  760,  758,  753,
			  724,  707,  682,  671,  668,  622,  618,  600,  559,  513,
			 1181, 1126, 2614, 1189, 1199, 1206,  710,    0, 1165,  463,

			 1212, 1218,  904,  916,  918,  942,  995,    0, 1029,    0,
			    0,    0, 1052, 1074, 1201, 1212, 1088, 1149, 1157, 1169,
			 1167, 1192, 1214, 1215, 1209, 1213, 1211, 1228, 1234, 1215,
			 1233, 1238, 1235, 1236,    0, 1221,    0, 1223, 1251, 1245,
			 1254, 1248, 1235, 1237, 1237, 1238, 1265, 1266, 1249, 1263,
			 1272, 1275, 1265, 1282, 1289, 1290, 1280, 1296, 1294, 1295,
			 1301, 1287, 1303, 1289, 1301, 1303, 1299, 1301,    0,    0,
			 1312, 1313, 1316, 1317, 1316, 1317, 1324, 1309, 1338, 1315,
			 1334, 1337, 1342, 1323, 1342, 1329, 1350, 1355, 1353, 1359,
			 1356, 1359, 1357, 1358, 1354, 1355, 1365, 1367, 1373, 1363, yy_Dummy>>,
			1, 200, 200)
		end

	yy_base_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			 1372, 1377, 1366, 1375, 1376, 1377, 1385, 1390, 1383, 1389,
			    0,    0, 2614, 2614, 2614, 2614, 2614, 2614, 2614, 2614,
			 2614, 2614,  499, 2614,  451, 1038, 2614, 1045, 2614, 1083,
			 2614, 1165, 1440, 1415, 1464, 1479, 1484,  448,  445,  444,
			  361, 2614, 2614, 2614, 2614, 2614, 1510, 1494, 2614, 2614,
			 2614, 2614, 2614, 2614, 2614, 2614, 2614, 2614, 2614, 2614,
			 2614, 2614, 2614, 2614, 1515, 1431, 1456, 1523, 1562, 1498,
			 1530, 1570, 1186, 1547,  250,  275, 1576, 1582, 1422, 1426,
			 1441, 1442, 1444, 1446, 1459, 1472, 1507, 1510, 1523, 1538,
			 1538, 1546, 1553, 1558, 1575, 1577, 1563, 1564, 1580, 1581,

			 1580, 1581, 1572, 1573, 1589, 1590, 1585, 1586, 1578, 1579,
			 1584, 1581, 1586, 1584, 1585, 1587, 1601, 1603, 1589, 1590,
			    0, 1616,    0, 1628, 1627, 1630, 1617, 1620, 1627, 1628,
			 1642, 1643, 1631, 1632,    0,    0, 1639, 1640,    0,    0,
			    0,    0, 1642, 1643,    0,    0, 1635, 1636, 1652, 1653,
			 1642, 1643, 1649, 1650, 1655, 1657, 1646, 1657, 1649, 1660,
			 1649, 1650, 1682, 1694, 1682, 1685,    0,    0, 1689, 1692,
			    0,    0,    0,    0, 1703, 1704, 1690, 1691, 1701, 1702,
			 1714, 1715,    0,    0,    0,    0, 1166, 1182, 2614, 2614,
			  278,  386,    0, 1727,  264,  256, 1750, 1777,  246,  319, yy_Dummy>>,
			1, 200, 400)
		end

	yy_base_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			  863,    0, 1763, 1768, 1772, 1776, 1783, 1791, 1797, 1804,
			 1720, 1753,    0,    0,    0,    0, 1764, 1765, 1772, 1784,
			 1797, 1798,    0,    0,    0,    0, 1783, 1788, 1816, 1821,
			 1794, 1795,    0,    0, 1797, 1802, 1819, 1820, 1823, 1830,
			 1832, 1834, 1838, 1844, 1831, 1834, 1841, 1842,    0,    0,
			 1845, 1846, 1851, 1852, 1862, 1865, 1863, 1864, 1866, 1867,
			 1874, 1875, 1870, 1872,    0,    0, 1877, 1879, 1867, 1871,
			 1881, 1882, 1887, 1888, 1889, 1895, 1883, 1885, 1901, 1907,
			 1895, 1898,    0,    0, 1899, 1900, 1926, 1927,    0,    0,
			 1920, 1921, 1926, 1929,    0,    0, 1922, 1923, 1949, 1963,

			  508, 2614, 1980, 1983,  511, 1991, 2004, 1995, 2010, 2014,
			 2032, 2044,    0,    0,    0,    0, 1940, 1941, 1946, 1988,
			 1990, 1992,    0, 1998,    0, 2001, 1999, 2001, 2022, 2023,
			 2028, 2029,    0,    0,    0,    0, 2026, 2029,    0,    0,
			 2038, 2039, 2038, 2041,    0,    0, 2031, 2033, 2040, 2041,
			 2036, 2037, 2038, 2044, 2064, 2066, 2048, 2049, 2051, 2054,
			 2060, 2062, 2063, 2065,    0,    0, 2075, 2078,    0,    0,
			    0,    0,    0,    0, 2065, 2071, 2078, 2079,    0,    0,
			 2074, 2075, 2112, 2127,  168,  178, 2122,  156, 2137,  149,
			   80,  119, 2140, 2144, 2154, 2163, 2178, 2169, 2148, 2184, yy_Dummy>>,
			1, 200, 600)
		end

	yy_base_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			 2193, 2146, 2161, 2147, 2153,    0,    0, 2166, 2169,    0,
			    0, 2184, 2185, 2188, 2190, 2189, 2190, 2183, 2184,    0,
			    0,    0,    0, 2191, 2193,    0,    0,    0,    0, 2187,
			 2188, 2198, 2199, 2192, 2193, 2204, 2205, 2208, 2210,    0,
			    0, 2209, 2211, 2212, 2213,    0,    0, 2614, 2614, 2614,
			 2224, 2260, 2265, 2271, 2275, 2279, 2288, 2294, 2298,    0,
			    0, 2270, 2272,    0,    0,    0,    0, 2266, 2271,    0,
			    0,    0,    0,    0,    0, 2273, 2274,    0,    0, 2277,
			 2278,    0,    0, 2292, 2293,    0,    0,    0,    0, 2300,
			 2308, 2320,    0,    0, 2298, 2299,    0,    0,    0,    0,

			    0,    0,    0,    0, 2614, 2366, 2385, 2403, 2422, 2440,
			 2459, 2475, 2336, 2493, 2378, 2510, 2529, 2545, 2559, 2575,
			 2468, 2594,  663,  682, yy_Dummy>>,
			1, 124, 800)
		end

	yy_def_template: SPECIAL [INTEGER]
			-- Template for `yy_def'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 923)
			yy_def_template_1 (an_array)
			yy_def_template_2 (an_array)
			an_array.area.fill_with (904, 266, 294)
			yy_def_template_3 (an_array)
			an_array.area.fill_with (904, 441, 470)
			yy_def_template_4 (an_array)
			yy_def_template_5 (an_array)
			yy_def_template_6 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_def_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			    0,  904,    1,  905,  905,  904,  904,  904,  904,  904,
			  904,  906,  907,  908,  904,  909,  910,  904,  904,  906,
			   19,  904,  911,  904,   19,  912,  912,  904,  904,  911,
			   19,  911,  904,  904,  904,   34,   34,   34,   34,   34,
			   34,   34,   34,   34,   34,   34,   34,   34,   34,   34,
			   34,  904,   19,  904,   19,   19,  913,  914,  914,  914,
			  914,  914,  914,  914,  914,  914,  914,  914,  914,  914,
			  914,  914,  914,  914,  914,  904,  904,   19,   19,   78,
			   79,  904,  904,   80,   83,  915,  904,  904,  915,  904,
			  904,  916,  904,  904,  904,  904,   84,  917,  917,  917,

			  907,  904,  918,  907,  908,  908,  908,  106,  106,  909,
			  919,  919,  919,   19,  904,  904,  904,  904,   96,   96,
			   96,  904,  912,  912,  920,  920,  920,  912,  904,  904,
			   19,   19,  904,  904,  904,  904,   34,   34,   34,   34,
			   34,   34,   34,  914,  914,  914,  914,  914,  914,  914,
			   34,   34,   34,   34,   34,  914,  914,  914,  914,  914,
			   34,   34,  914,  914,   34,   34,   34,  914,  914,  914,
			   34,   34,   34,  914,  914,  914,   34,   34,   34,   34,
			  914,  914,  914,  914,   34,   34,  914,  914,   34,  914,
			   34,   34,   34,   34,  914,  914,  914,  914,   34,  914, yy_Dummy>>,
			1, 200, 0)
		end

	yy_def_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			   34,  914,   34,   34,   34,  914,  914,  914,   34,   34,
			  914,  914,   34,  914,   34,   34,  914,  914,   34,  914,
			   34,  914,   96,  913,  904,  917,  904,  917,  904,  917,
			  904,  904,  904,  904,  904,  917,  904,  917,  915,  904,
			  904,  921,  904,  915,  916,  904,  904,  904,  917,  248,
			  248,   96,  904,   19,  253,  254,  904,  907,  106,  106,
			  106,  104,  908,  104,  104,  104, yy_Dummy>>,
			1, 66, 200)
		end

	yy_def_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  912,  920,  920,  920,  126,  912,  912,   34,  914,   34,
			  914,   34,   34,  914,  914,   34,  914,   34,  914,   34,
			  914,   34,  914,   34,  914,   34,  914,   34,  914,   34,
			  914,   34,   34,   34,  914,  914,  914,   34,  914,   34,
			   34,  914,  914,   34,   34,  914,  914,   34,  914,   34,
			  914,   34,  914,   34,  914,   34,   34,   34,   34,  914,
			  914,  914,  914,   34,  914,   34,   34,  914,  914,   34,
			  914,   34,  914,   34,  914,   34,  914,   34,  914,   34,
			   34,   34,   34,   34,   34,  914,  914,  914,  914,  914,
			  914,   34,   34,  914,  914,   34,  914,   34,  914,   34,

			  914,   34,  914,   34,   34,   34,  914,  914,  914,   34,
			  914,   34,  914,   34,  914,   34,  914,  904,  904,  904,
			  904,  904,  904,  904,  904,  904,  904,  254,  904,  254,
			  917,  904,  917,  904,  917,  904,  917,  904,  904,  908,
			  104,  104,  106,  106,  106,  106, yy_Dummy>>,
			1, 146, 295)
		end

	yy_def_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  912,  920,  920,  126,  904,  912,  912,   34,  914,   34,
			  914,   34,  914,   34,  914,   34,   34,  914,  914,   34,
			  914,   34,  914,   34,  914,   34,  914,   34,  914,   34,
			  914,   34,  914,   34,  914,   34,  914,   34,  914,   34,
			   34,  914,  914,   34,  914,   34,  914,   34,  914,   34,
			   34,  914,  914,   34,  914,   34,  914,   34,  914,   34,
			  914,   34,  914,   34,  914,   34,  914,   34,  914,   34,
			  914,   34,  914,   34,  914,   34,  914,   34,  914,   34,
			  914,   34,  914,   34,  914,   34,   34,  914,  914,   34,
			  914,   34,  914,   34,  914,   34,  914,   34,  914,   34,

			  914,   34,  914,   34,  914,   34,  914,   34,  914,   34,
			  914,   34,  914,   34,  914,  917,  917,  904,  904,  904,
			  904,  922,  904,  106,  106,  908,  908,  904,  904,  904,
			  923,  904,  904,  904,  904,  904,  904,  904,  912,   34,
			  914,   34,  914,   34,  914,   34,  914,   34,  914,   34,
			  914,   34,  914,   34,  914,   34,  914,   34,  914,   34,
			  914,   34,  914,   34,  914,   34,  914,   34,  914,   34,
			  914,   34,  914,   34,  914,   34,  914,   34,  914,   34,
			  914,   34,  914,   34,  914,   34,  914,   34,  914,   34,
			  914,   34,  914,   34,  914,   34,  914,   34,  914,   34, yy_Dummy>>,
			1, 200, 471)
		end

	yy_def_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  914,   34,  914,   34,  914,   34,  914,   34,  914,   34,
			  914,   34,  914,   34,  914,   34,  914,   34,  914,   34,
			  914,   34,  914,   34,  914,   34,  914,  904,  904,  922,
			  904,  904,  904,  923,  904,  904,  904,  904,  904,  904,
			  904,   34,  914,   34,  914,   34,  914,   34,  914,   34,
			  914,   34,   34,  914,  914,   34,  914,   34,  914,   34,
			  914,   34,  914,   34,  914,   34,  914,   34,  914,   34,
			  914,   34,  914,   34,  914,   34,  914,   34,  914,   34,
			  914,   34,  914,   34,  914,   34,  914,   34,  914,   34,
			  914,   34,  914,   34,  914,   34,  914,   34,  914,   34,

			  914,   34,  914,   34,  914,   34,  914,   34,  914,   34,
			  914,  904,  904,  922,  904,  904,  904,  904,  904,  923,
			  904,  904,  904,  904,  904,  904,  904,  904,  904,  904,
			   34,  914,   34,  914,   34,  914,   34,  914,   34,  914,
			   34,  914,   34,  914,   34,  914,   34,  914,   34,  914,
			   34,  914,   34,  914,   34,  914,   34,  914,   34,  914,
			   34,  914,   34,  914,   34,  914,   34,  914,   34,  914,
			   34,  914,   34,  914,   34,  914,  904,  904,  904,  904,
			  904,  904,  904,  904,  904,  904,  904,  904,   34,  914,
			   34,  914,   34,  914,   34,  914,   34,  914,   34,  914, yy_Dummy>>,
			1, 200, 671)
		end

	yy_def_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			   34,  914,   34,  914,   34,  914,   34,  914,   34,  914,
			   34,  914,   34,  914,   34,  914,   34,  914,  904,  904,
			  904,   34,  914,   34,  914,   34,  914,   34,  914,   34,
			  914,   34,  914,    0,  904,  904,  904,  904,  904,  904,
			  904,  904,  904,  904,  904,  904,  904,  904,  904,  904,
			  904,  904,  904, yy_Dummy>>,
			1, 53, 871)
		end

	yy_ec_template: SPECIAL [INTEGER]
			-- Template for `yy_ec'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 127948)
			yy_ec_template_1 (an_array)
			an_array.area.fill_with (103, 127, 159)
			yy_ec_template_2 (an_array)
			an_array.area.fill_with (94, 216, 246)
			yy_ec_template_3 (an_array)
			an_array.area.fill_with (103, 256, 705)
			yy_ec_template_4 (an_array)
			an_array.area.fill_with (103, 768, 884)
			yy_ec_template_5 (an_array)
			an_array.area.fill_with (103, 904, 1013)
			an_array.put (96, 1014)
			an_array.area.fill_with (103, 1015, 1153)
			an_array.put (96, 1154)
			an_array.area.fill_with (103, 1155, 1369)
			an_array.area.fill_with (96, 1370, 1375)
			an_array.area.fill_with (103, 1376, 1416)
			yy_ec_template_6 (an_array)
			an_array.area.fill_with (103, 1424, 1469)
			yy_ec_template_7 (an_array)
			an_array.area.fill_with (103, 1479, 1522)
			yy_ec_template_8 (an_array)
			an_array.area.fill_with (103, 1568, 1641)
			an_array.area.fill_with (96, 1642, 1645)
			an_array.area.fill_with (103, 1646, 1747)
			yy_ec_template_9 (an_array)
			an_array.area.fill_with (103, 1806, 2037)
			yy_ec_template_10 (an_array)
			an_array.area.fill_with (103, 2048, 2095)
			an_array.area.fill_with (96, 2096, 2110)
			an_array.area.fill_with (103, 2111, 2141)
			an_array.put (96, 2142)
			an_array.area.fill_with (103, 2143, 2403)
			yy_ec_template_11 (an_array)
			an_array.area.fill_with (103, 2417, 2545)
			yy_ec_template_12 (an_array)
			an_array.area.fill_with (103, 2558, 2677)
			an_array.put (96, 2678)
			an_array.area.fill_with (103, 2679, 2799)
			an_array.area.fill_with (96, 2800, 2801)
			an_array.area.fill_with (103, 2802, 2927)
			an_array.put (96, 2928)
			an_array.area.fill_with (103, 2929, 3058)
			an_array.area.fill_with (96, 3059, 3066)
			an_array.area.fill_with (103, 3067, 3190)
			yy_ec_template_13 (an_array)
			an_array.area.fill_with (103, 3205, 3406)
			an_array.put (96, 3407)
			an_array.area.fill_with (103, 3408, 3448)
			an_array.put (96, 3449)
			an_array.area.fill_with (103, 3450, 3571)
			an_array.put (96, 3572)
			an_array.area.fill_with (103, 3573, 3646)
			yy_ec_template_14 (an_array)
			an_array.area.fill_with (103, 3676, 3840)
			yy_ec_template_15 (an_array)
			an_array.area.fill_with (103, 3897, 3972)
			an_array.put (96, 3973)
			an_array.area.fill_with (103, 3974, 4029)
			yy_ec_template_16 (an_array)
			an_array.area.fill_with (103, 4059, 4169)
			an_array.area.fill_with (96, 4170, 4175)
			an_array.area.fill_with (103, 4176, 4253)
			an_array.area.fill_with (96, 4254, 4255)
			an_array.area.fill_with (103, 4256, 4346)
			an_array.put (96, 4347)
			an_array.area.fill_with (103, 4348, 4959)
			an_array.area.fill_with (96, 4960, 4968)
			an_array.area.fill_with (103, 4969, 5007)
			an_array.area.fill_with (96, 5008, 5017)
			an_array.area.fill_with (103, 5018, 5119)
			an_array.put (96, 5120)
			an_array.area.fill_with (103, 5121, 5740)
			yy_ec_template_17 (an_array)
			an_array.area.fill_with (103, 5761, 5866)
			an_array.area.fill_with (96, 5867, 5869)
			an_array.area.fill_with (103, 5870, 5940)
			an_array.area.fill_with (96, 5941, 5942)
			an_array.area.fill_with (103, 5943, 6099)
			yy_ec_template_18 (an_array)
			an_array.area.fill_with (103, 6108, 6143)
			an_array.area.fill_with (96, 6144, 6154)
			an_array.area.fill_with (103, 6155, 6463)
			yy_ec_template_19 (an_array)
			an_array.area.fill_with (103, 6470, 6621)
			an_array.area.fill_with (96, 6622, 6655)
			an_array.area.fill_with (103, 6656, 6685)
			an_array.area.fill_with (96, 6686, 6687)
			an_array.area.fill_with (103, 6688, 6815)
			yy_ec_template_20 (an_array)
			an_array.area.fill_with (103, 6830, 7001)
			yy_ec_template_21 (an_array)
			an_array.area.fill_with (103, 7037, 7163)
			an_array.area.fill_with (96, 7164, 7167)
			an_array.area.fill_with (103, 7168, 7226)
			an_array.area.fill_with (96, 7227, 7231)
			an_array.area.fill_with (103, 7232, 7293)
			an_array.area.fill_with (96, 7294, 7295)
			an_array.area.fill_with (103, 7296, 7359)
			yy_ec_template_22 (an_array)
			an_array.area.fill_with (103, 7380, 8124)
			yy_ec_template_23 (an_array)
			an_array.area.fill_with (103, 8288, 8313)
			yy_ec_template_24 (an_array)
			an_array.area.fill_with (96, 8352, 8383)
			an_array.area.fill_with (103, 8384, 8447)
			yy_ec_template_25 (an_array)
			an_array.area.fill_with (103, 8528, 8585)
			yy_ec_template_26 (an_array)
			an_array.area.fill_with (96, 8592, 8703)
			yy_ec_template_27 (an_array)
			an_array.area.fill_with (96, 8708, 8967)
			an_array.area.fill_with (103, 8968, 8971)
			an_array.area.fill_with (96, 8972, 9000)
			an_array.area.fill_with (103, 9001, 9002)
			an_array.area.fill_with (96, 9003, 9254)
			an_array.area.fill_with (103, 9255, 9279)
			an_array.area.fill_with (96, 9280, 9290)
			an_array.area.fill_with (103, 9291, 9371)
			an_array.area.fill_with (96, 9372, 9449)
			an_array.area.fill_with (103, 9450, 9471)
			an_array.area.fill_with (96, 9472, 10087)
			an_array.area.fill_with (103, 10088, 10131)
			an_array.area.fill_with (96, 10132, 10180)
			an_array.area.fill_with (103, 10181, 10182)
			an_array.area.fill_with (96, 10183, 10213)
			yy_ec_template_28 (an_array)
			an_array.area.fill_with (96, 10228, 10626)
			an_array.area.fill_with (103, 10627, 10648)
			an_array.area.fill_with (96, 10649, 10711)
			an_array.area.fill_with (103, 10712, 10715)
			an_array.area.fill_with (96, 10716, 10747)
			an_array.area.fill_with (103, 10748, 10749)
			an_array.area.fill_with (96, 10750, 11123)
			an_array.area.fill_with (103, 11124, 11125)
			an_array.area.fill_with (96, 11126, 11157)
			an_array.put (103, 11158)
			an_array.area.fill_with (96, 11159, 11263)
			an_array.area.fill_with (103, 11264, 11492)
			yy_ec_template_29 (an_array)
			an_array.area.fill_with (103, 11520, 11631)
			an_array.put (96, 11632)
			an_array.area.fill_with (103, 11633, 11775)
			yy_ec_template_30 (an_array)
			an_array.area.fill_with (103, 11859, 11903)
			an_array.area.fill_with (96, 11904, 11929)
			an_array.put (103, 11930)
			an_array.area.fill_with (96, 11931, 12019)
			an_array.area.fill_with (103, 12020, 12031)
			an_array.area.fill_with (96, 12032, 12245)
			an_array.area.fill_with (103, 12246, 12271)
			yy_ec_template_31 (an_array)
			an_array.area.fill_with (103, 12352, 12442)
			yy_ec_template_32 (an_array)
			an_array.area.fill_with (103, 12449, 12538)
			an_array.put (96, 12539)
			an_array.area.fill_with (103, 12540, 12687)
			yy_ec_template_33 (an_array)
			an_array.area.fill_with (103, 12704, 12735)
			an_array.area.fill_with (96, 12736, 12771)
			an_array.area.fill_with (103, 12772, 12799)
			an_array.area.fill_with (96, 12800, 12830)
			an_array.area.fill_with (103, 12831, 12841)
			an_array.area.fill_with (96, 12842, 12871)
			yy_ec_template_34 (an_array)
			an_array.area.fill_with (96, 12896, 12927)
			an_array.area.fill_with (103, 12928, 12937)
			an_array.area.fill_with (96, 12938, 12976)
			an_array.area.fill_with (103, 12977, 12991)
			an_array.area.fill_with (96, 12992, 13311)
			an_array.area.fill_with (103, 13312, 19903)
			an_array.area.fill_with (96, 19904, 19967)
			an_array.area.fill_with (103, 19968, 42127)
			an_array.area.fill_with (96, 42128, 42182)
			an_array.area.fill_with (103, 42183, 42237)
			an_array.area.fill_with (96, 42238, 42239)
			an_array.area.fill_with (103, 42240, 42508)
			an_array.area.fill_with (96, 42509, 42511)
			an_array.area.fill_with (103, 42512, 42610)
			yy_ec_template_35 (an_array)
			an_array.area.fill_with (103, 42623, 42737)
			yy_ec_template_36 (an_array)
			an_array.area.fill_with (103, 42786, 42888)
			an_array.area.fill_with (95, 42889, 42890)
			an_array.area.fill_with (103, 42891, 43047)
			yy_ec_template_37 (an_array)
			an_array.area.fill_with (103, 43066, 43123)
			an_array.area.fill_with (96, 43124, 43127)
			an_array.area.fill_with (103, 43128, 43213)
			an_array.area.fill_with (96, 43214, 43215)
			an_array.area.fill_with (103, 43216, 43255)
			yy_ec_template_38 (an_array)
			an_array.area.fill_with (103, 43261, 43309)
			an_array.area.fill_with (96, 43310, 43311)
			an_array.area.fill_with (103, 43312, 43358)
			an_array.put (96, 43359)
			an_array.area.fill_with (103, 43360, 43456)
			yy_ec_template_39 (an_array)
			an_array.area.fill_with (103, 43488, 43611)
			yy_ec_template_40 (an_array)
			an_array.area.fill_with (103, 43642, 43741)
			yy_ec_template_41 (an_array)
			an_array.area.fill_with (103, 43762, 43866)
			yy_ec_template_42 (an_array)
			an_array.area.fill_with (103, 43884, 44010)
			an_array.put (96, 44011)
			an_array.area.fill_with (103, 44012, 62248)
			an_array.put (96, 62249)
			an_array.area.fill_with (103, 62250, 62385)
			an_array.area.fill_with (95, 62386, 62401)
			an_array.area.fill_with (103, 62402, 62971)
			yy_ec_template_43 (an_array)
			an_array.area.fill_with (103, 63084, 63232)
			yy_ec_template_44 (an_array)
			an_array.area.fill_with (103, 63265, 63291)
			yy_ec_template_45 (an_array)
			an_array.area.fill_with (103, 63297, 63323)
			yy_ec_template_46 (an_array)
			an_array.area.fill_with (103, 63334, 63455)
			yy_ec_template_47 (an_array)
			an_array.area.fill_with (103, 63486, 63743)
			an_array.area.fill_with (96, 63744, 63746)
			an_array.area.fill_with (103, 63747, 63798)
			an_array.area.fill_with (96, 63799, 63807)
			an_array.area.fill_with (103, 63808, 63864)
			yy_ec_template_48 (an_array)
			an_array.area.fill_with (103, 63905, 63951)
			an_array.area.fill_with (96, 63952, 63996)
			an_array.area.fill_with (103, 63997, 64414)
			an_array.put (96, 64415)
			an_array.area.fill_with (103, 64416, 64463)
			an_array.put (96, 64464)
			an_array.area.fill_with (103, 64465, 64878)
			an_array.put (96, 64879)
			an_array.area.fill_with (103, 64880, 65622)
			an_array.put (96, 65623)
			an_array.area.fill_with (103, 65624, 65654)
			an_array.area.fill_with (96, 65655, 65656)
			an_array.area.fill_with (103, 65657, 65822)
			an_array.put (96, 65823)
			an_array.area.fill_with (103, 65824, 65854)
			an_array.put (96, 65855)
			an_array.area.fill_with (103, 65856, 66127)
			an_array.area.fill_with (96, 66128, 66136)
			an_array.area.fill_with (103, 66137, 66174)
			an_array.put (96, 66175)
			an_array.area.fill_with (103, 66176, 66247)
			an_array.put (96, 66248)
			an_array.area.fill_with (103, 66249, 66287)
			an_array.area.fill_with (96, 66288, 66294)
			an_array.area.fill_with (103, 66295, 66360)
			an_array.area.fill_with (96, 66361, 66367)
			an_array.area.fill_with (103, 66368, 66456)
			an_array.area.fill_with (96, 66457, 66460)
			an_array.area.fill_with (103, 66461, 67244)
			an_array.put (96, 67245)
			an_array.area.fill_with (103, 67246, 67412)
			an_array.area.fill_with (96, 67413, 67417)
			an_array.area.fill_with (103, 67418, 67654)
			an_array.area.fill_with (96, 67655, 67661)
			an_array.area.fill_with (103, 67662, 67770)
			yy_ec_template_49 (an_array)
			an_array.area.fill_with (103, 67778, 67903)
			an_array.area.fill_with (96, 67904, 67907)
			an_array.area.fill_with (103, 67908, 67955)
			an_array.area.fill_with (96, 67956, 67957)
			an_array.area.fill_with (103, 67958, 68036)
			yy_ec_template_50 (an_array)
			an_array.area.fill_with (103, 68064, 68151)
			an_array.area.fill_with (96, 68152, 68157)
			an_array.area.fill_with (103, 68158, 68264)
			an_array.put (96, 68265)
			an_array.area.fill_with (103, 68266, 68682)
			yy_ec_template_51 (an_array)
			an_array.area.fill_with (103, 68702, 68805)
			an_array.put (96, 68806)
			an_array.area.fill_with (103, 68807, 69056)
			an_array.area.fill_with (96, 69057, 69079)
			an_array.area.fill_with (103, 69080, 69184)
			an_array.area.fill_with (96, 69185, 69187)
			an_array.area.fill_with (103, 69188, 69215)
			an_array.area.fill_with (96, 69216, 69228)
			an_array.area.fill_with (103, 69229, 69435)
			an_array.area.fill_with (96, 69436, 69439)
			an_array.area.fill_with (103, 69440, 69690)
			an_array.put (96, 69691)
			an_array.area.fill_with (103, 69692, 69955)
			an_array.area.fill_with (96, 69956, 69958)
			an_array.area.fill_with (103, 69959, 70113)
			an_array.put (96, 70114)
			an_array.area.fill_with (103, 70115, 70206)
			an_array.area.fill_with (96, 70207, 70214)
			an_array.area.fill_with (103, 70215, 70297)
			yy_ec_template_52 (an_array)
			an_array.area.fill_with (103, 70307, 70720)
			an_array.area.fill_with (96, 70721, 70725)
			an_array.area.fill_with (103, 70726, 70767)
			an_array.area.fill_with (96, 70768, 70769)
			an_array.area.fill_with (103, 70770, 71414)
			an_array.area.fill_with (96, 71415, 71416)
			an_array.area.fill_with (103, 71417, 71636)
			an_array.area.fill_with (96, 71637, 71665)
			yy_ec_template_53 (an_array)
			an_array.area.fill_with (103, 71680, 72815)
			an_array.area.fill_with (96, 72816, 72820)
			an_array.area.fill_with (103, 72821, 90733)
			an_array.area.fill_with (96, 90734, 90735)
			an_array.area.fill_with (103, 90736, 90868)
			an_array.put (96, 90869)
			an_array.area.fill_with (103, 90870, 90934)
			yy_ec_template_54 (an_array)
			an_array.area.fill_with (103, 90950, 91798)
			an_array.area.fill_with (96, 91799, 91802)
			an_array.area.fill_with (103, 91803, 92129)
			an_array.put (96, 92130)
			an_array.area.fill_with (103, 92131, 111771)
			yy_ec_template_55 (an_array)
			an_array.area.fill_with (103, 111776, 116735)
			an_array.area.fill_with (96, 116736, 116981)
			an_array.area.fill_with (103, 116982, 116991)
			an_array.area.fill_with (96, 116992, 117030)
			an_array.area.fill_with (103, 117031, 117032)
			an_array.area.fill_with (96, 117033, 117092)
			yy_ec_template_56 (an_array)
			an_array.area.fill_with (96, 117132, 117161)
			an_array.area.fill_with (103, 117162, 117165)
			an_array.area.fill_with (96, 117166, 117224)
			an_array.area.fill_with (103, 117225, 117247)
			an_array.area.fill_with (96, 117248, 117313)
			yy_ec_template_57 (an_array)
			an_array.area.fill_with (103, 117318, 117503)
			an_array.area.fill_with (96, 117504, 117590)
			an_array.area.fill_with (103, 117591, 118464)
			an_array.put (96, 118465)
			an_array.area.fill_with (103, 118466, 118490)
			an_array.put (96, 118491)
			an_array.area.fill_with (103, 118492, 118522)
			an_array.put (96, 118523)
			an_array.area.fill_with (103, 118524, 118548)
			an_array.put (96, 118549)
			an_array.area.fill_with (103, 118550, 118580)
			an_array.put (96, 118581)
			an_array.area.fill_with (103, 118582, 118606)
			an_array.put (96, 118607)
			an_array.area.fill_with (103, 118608, 118638)
			an_array.put (96, 118639)
			an_array.area.fill_with (103, 118640, 118664)
			an_array.put (96, 118665)
			an_array.area.fill_with (103, 118666, 118696)
			an_array.put (96, 118697)
			an_array.area.fill_with (103, 118698, 118722)
			an_array.put (96, 118723)
			an_array.area.fill_with (103, 118724, 118783)
			an_array.area.fill_with (96, 118784, 119295)
			an_array.area.fill_with (103, 119296, 119350)
			an_array.area.fill_with (96, 119351, 119354)
			an_array.area.fill_with (103, 119355, 119404)
			yy_ec_template_58 (an_array)
			an_array.area.fill_with (103, 119436, 121166)
			an_array.put (96, 121167)
			an_array.area.fill_with (103, 121168, 121598)
			an_array.put (96, 121599)
			an_array.area.fill_with (103, 121600, 123229)
			an_array.area.fill_with (96, 123230, 123231)
			an_array.area.fill_with (103, 123232, 124075)
			yy_ec_template_59 (an_array)
			an_array.area.fill_with (103, 124081, 124205)
			an_array.put (96, 124206)
			an_array.area.fill_with (103, 124207, 124655)
			an_array.area.fill_with (96, 124656, 124657)
			an_array.area.fill_with (103, 124658, 124927)
			an_array.area.fill_with (96, 124928, 124971)
			an_array.area.fill_with (103, 124972, 124975)
			an_array.area.fill_with (96, 124976, 125075)
			yy_ec_template_60 (an_array)
			an_array.area.fill_with (96, 125137, 125173)
			an_array.area.fill_with (103, 125174, 125196)
			an_array.area.fill_with (96, 125197, 125357)
			an_array.area.fill_with (103, 125358, 125413)
			an_array.area.fill_with (96, 125414, 125442)
			an_array.area.fill_with (103, 125443, 125455)
			an_array.area.fill_with (96, 125456, 125499)
			yy_ec_template_61 (an_array)
			an_array.area.fill_with (103, 125542, 125695)
			an_array.area.fill_with (96, 125696, 125946)
			an_array.area.fill_with (95, 125947, 125951)
			an_array.area.fill_with (96, 125952, 126679)
			yy_ec_template_62 (an_array)
			an_array.area.fill_with (96, 126720, 126835)
			an_array.area.fill_with (103, 126836, 126847)
			an_array.area.fill_with (96, 126848, 126936)
			yy_ec_template_63 (an_array)
			an_array.area.fill_with (96, 126992, 127047)
			yy_ec_template_64 (an_array)
			an_array.area.fill_with (96, 127072, 127111)
			an_array.area.fill_with (103, 127112, 127119)
			an_array.area.fill_with (96, 127120, 127149)
			yy_ec_template_65 (an_array)
			an_array.area.fill_with (103, 127154, 127231)
			an_array.area.fill_with (96, 127232, 127352)
			an_array.put (103, 127353)
			an_array.area.fill_with (96, 127354, 127435)
			an_array.put (103, 127436)
			an_array.area.fill_with (96, 127437, 127571)
			yy_ec_template_66 (an_array)
			an_array.area.fill_with (96, 127632, 127656)
			yy_ec_template_67 (an_array)
			an_array.area.fill_with (103, 127703, 127743)
			an_array.area.fill_with (96, 127744, 127890)
			an_array.put (103, 127891)
			an_array.area.fill_with (96, 127892, 127946)
			an_array.area.fill_with (103, 127947, 127948)
			Result := yy_fixed_array (an_array)
		end

	yy_ec_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			    0,  103,  103,  103,  103,  103,  103,  103,  103,    1,
			    2,    3,    3,    4,  103,  103,  103,  103,  103,  103,
			  103,  103,  103,  103,  103,  103,  103,  103,  103,  103,
			  103,  103,    5,    6,    7,    8,    9,   10,    8,   11,
			   12,   13,   14,   15,   16,   17,   18,   19,   20,   21,
			   22,   22,   22,   22,   22,   22,   23,   23,   24,   25,
			   26,   27,   28,   29,    8,   30,   31,   32,   33,   34,
			   35,   36,   37,   38,   39,   40,   41,   42,   43,   44,
			   45,   46,   47,   48,   49,   50,   51,   52,   53,   54,
			   55,   56,   57,   58,   59,   60,   61,   62,   63,   64,

			   65,   66,   67,   68,   69,   70,   71,   72,   73,   74,
			   75,   76,   77,   78,   79,   80,   81,   82,   83,   84,
			   85,   86,   87,   88,    8,   89,   90, yy_Dummy>>,
			1, 127, 0)
		end

	yy_ec_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			    3,   91,   91,   91,   91,   91,   92,   91,   93,   91,
			   94,   94,   91,   94,   91,   93,   91,   91,   94,   94,
			   93,   94,   91,   91,   93,   94,   94,   94,   94,   94,
			   94,   91,   94,   94,   94,   94,   94,   94,   94,   94,
			   94,   94,   94,   94,   94,   94,   94,   94,   94,   94,
			   94,   94,   94,   94,   94,   91, yy_Dummy>>,
			1, 56, 160)
		end

	yy_ec_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   91,   94,   94,   94,   94,   94,   94,   94,   94, yy_Dummy>>,
			1, 9, 247)
		end

	yy_ec_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   95,   95,   95,   95,  103,  103,  103,  103,  103,  103,
			  103,  103,  103,  103,  103,  103,   95,   95,   95,   95,
			   95,   95,   95,   95,   95,   95,   95,   95,   95,   95,
			  103,  103,  103,  103,  103,   95,   95,   95,   95,   95,
			   95,   95,  103,   95,  103,   95,   95,   95,   95,   95,
			   95,   95,   95,   95,   95,   95,   95,   95,   95,   95,
			   95,   95, yy_Dummy>>,
			1, 62, 706)
		end

	yy_ec_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   95,  103,  103,  103,  103,  103,  103,  103,  103,   96,
			  103,  103,  103,  103,  103,   95,   95,  103,   96, yy_Dummy>>,
			1, 19, 885)
		end

	yy_ec_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   96,   96,  103,  103,   96,   96,   96, yy_Dummy>>,
			1, 7, 1417)
		end

	yy_ec_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   96,  103,   96,  103,  103,   96,  103,  103,   96, yy_Dummy>>,
			1, 9, 1470)
		end

	yy_ec_template_8 (an_array: ARRAY [INTEGER])
			-- Fill chunk #8 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   96,   96,  103,  103,  103,  103,  103,  103,  103,  103,
			  103,  103,  103,  103,  103,  103,  103,  103,  103,   96,
			   96,   96,   96,   96,   96,   96,   96,   96,   96,  103,
			  103,  103,  103,  103,  103,  103,  103,  103,  103,  103,
			   96,  103,  103,   96,   96, yy_Dummy>>,
			1, 45, 1523)
		end

	yy_ec_template_9 (an_array: ARRAY [INTEGER])
			-- Fill chunk #9 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   96,  103,  103,  103,  103,  103,  103,  103,  103,  103,
			   96,  103,  103,  103,  103,  103,  103,  103,  103,  103,
			  103,   96,  103,  103,  103,  103,  103,  103,  103,  103,
			  103,  103,  103,  103,  103,  103,  103,  103,  103,  103,
			  103,   96,   96,  103,   96,   96,   96,   96,   96,   96,
			   96,   96,   96,   96,   96,   96,   96,   96, yy_Dummy>>,
			1, 58, 1748)
		end

	yy_ec_template_10 (an_array: ARRAY [INTEGER])
			-- Fill chunk #10 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   96,   96,   96,   96,  103,  103,  103,  103,   96,   96, yy_Dummy>>,
			1, 10, 2038)
		end

	yy_ec_template_11 (an_array: ARRAY [INTEGER])
			-- Fill chunk #11 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   96,   96,  103,  103,  103,  103,  103,  103,  103,  103,
			  103,  103,   96, yy_Dummy>>,
			1, 13, 2404)
		end

	yy_ec_template_12 (an_array: ARRAY [INTEGER])
			-- Fill chunk #12 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   96,   96,  103,  103,  103,  103,  103,  103,   96,   96,
			  103,   96, yy_Dummy>>,
			1, 12, 2546)
		end

	yy_ec_template_13 (an_array: ARRAY [INTEGER])
			-- Fill chunk #13 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   96,  103,  103,  103,  103,  103,  103,  103,   96,  103,
			  103,  103,  103,   96, yy_Dummy>>,
			1, 14, 3191)
		end

	yy_ec_template_14 (an_array: ARRAY [INTEGER])
			-- Fill chunk #14 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   96,  103,  103,  103,  103,  103,  103,  103,  103,  103,
			  103,  103,  103,  103,  103,  103,   96,  103,  103,  103,
			  103,  103,  103,  103,  103,  103,  103,   96,   96, yy_Dummy>>,
			1, 29, 3647)
		end

	yy_ec_template_15 (an_array: ARRAY [INTEGER])
			-- Fill chunk #15 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   96,   96,   96,   96,   96,   96,   96,   96,   96,   96,
			   96,   96,   96,   96,   96,   96,   96,   96,   96,   96,
			   96,   96,   96,  103,  103,   96,   96,   96,   96,   96,
			   96,  103,  103,  103,  103,  103,  103,  103,  103,  103,
			  103,  103,  103,  103,  103,  103,  103,  103,  103,  103,
			  103,   96,  103,   96,  103,   96, yy_Dummy>>,
			1, 56, 3841)
		end

	yy_ec_template_16 (an_array: ARRAY [INTEGER])
			-- Fill chunk #16 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   96,   96,   96,   96,   96,   96,   96,   96,  103,   96,
			   96,   96,   96,   96,   96,  103,   96,   96,   96,   96,
			   96,   96,   96,   96,   96,   96,   96,   96,   96, yy_Dummy>>,
			1, 29, 4030)
		end

	yy_ec_template_17 (an_array: ARRAY [INTEGER])
			-- Fill chunk #17 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   96,   96,  103,  103,  103,  103,  103,  103,  103,  103,
			  103,  103,  103,  103,  103,  103,  103,  103,  103,    3, yy_Dummy>>,
			1, 20, 5741)
		end

	yy_ec_template_18 (an_array: ARRAY [INTEGER])
			-- Fill chunk #18 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   96,   96,   96,  103,   96,   96,   96,   96, yy_Dummy>>,
			1, 8, 6100)
		end

	yy_ec_template_19 (an_array: ARRAY [INTEGER])
			-- Fill chunk #19 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   96,  103,  103,  103,   96,   96, yy_Dummy>>,
			1, 6, 6464)
		end

	yy_ec_template_20 (an_array: ARRAY [INTEGER])
			-- Fill chunk #20 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   96,   96,   96,   96,   96,   96,   96,  103,   96,   96,
			   96,   96,   96,   96, yy_Dummy>>,
			1, 14, 6816)
		end

	yy_ec_template_21 (an_array: ARRAY [INTEGER])
			-- Fill chunk #21 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   96,   96,   96,   96,   96,   96,   96,   96,   96,   96,
			   96,   96,   96,   96,   96,   96,   96,  103,  103,  103,
			  103,  103,  103,  103,  103,  103,   96,   96,   96,   96,
			   96,   96,   96,   96,   96, yy_Dummy>>,
			1, 35, 7002)
		end

	yy_ec_template_22 (an_array: ARRAY [INTEGER])
			-- Fill chunk #22 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   96,   96,   96,   96,   96,   96,   96,   96,  103,  103,
			  103,  103,  103,  103,  103,  103,  103,  103,  103,   96, yy_Dummy>>,
			1, 20, 7360)
		end

	yy_ec_template_23 (an_array: ARRAY [INTEGER])
			-- Fill chunk #23 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   95,  103,   95,   95,   95,  103,  103,  103,  103,  103,
			  103,  103,  103,  103,  103,  103,   95,   95,   95,  103,
			  103,  103,  103,  103,  103,  103,  103,  103,  103,  103,
			  103,  103,   95,   95,   95,  103,  103,  103,  103,  103,
			  103,  103,  103,  103,  103,  103,  103,  103,   95,   95,
			   95,  103,  103,  103,  103,  103,  103,  103,  103,  103,
			  103,  103,  103,  103,   95,   95,  103,    3,    3,    3,
			    3,    3,    3,    3,    3,    3,    3,    3,  103,  103,
			  103,  103,  103,   96,   96,   96,   96,   96,   96,   96,
			   96,  103,  103,  103,  103,  103,  103,  103,  103,   96,

			   96,   96,   96,   96,   96,   96,   96,  103,  103,  103,
			  103,  103,  103,  103,    3,   96,   96,   96,   96,   96,
			   96,   96,   96,   96,  103,  103,   96,   96,   96,   96,
			   96,   96,   96,   96,   96,   96,  103,  103,   96,   96,
			   96,   96,   96,   96,   96,   96,   96,   96,   96,   96,
			   96,   96,   96,   96,   96,   96,   96,   96,   96,   96,
			   96,   96,    3, yy_Dummy>>,
			1, 163, 8125)
		end

	yy_ec_template_24 (an_array: ARRAY [INTEGER])
			-- Fill chunk #24 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   96,   96,   96,  103,  103,  103,  103,  103,  103,  103,
			  103,  103,  103,  103,  103,  103,   96,   96,   96,  103,
			  103,  103,  103,  103,  103,  103,  103,  103,  103,  103,
			  103,  103,  103,  103,  103,  103,  103,  103, yy_Dummy>>,
			1, 38, 8314)
		end

	yy_ec_template_25 (an_array: ARRAY [INTEGER])
			-- Fill chunk #25 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   96,   96,  103,   96,   96,   96,   96,  103,   96,   96,
			  103,  103,  103,  103,  103,  103,  103,  103,  103,  103,
			   96,  103,   96,   96,   96,  103,  103,  103,  103,  103,
			   96,   96,   96,   96,   96,   96,  103,   96,  103,   96,
			  103,   96,  103,  103,  103,  103,   96,  103,  103,  103,
			  103,  103,  103,  103,  103,  103,  103,  103,   96,   96,
			  103,  103,  103,  103,   96,   96,   96,   96,   96,  103,
			  103,  103,  103,  103,   96,   96,   96,   96,  103,   96, yy_Dummy>>,
			1, 80, 8448)
		end

	yy_ec_template_26 (an_array: ARRAY [INTEGER])
			-- Fill chunk #26 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   96,   96,  103,  103,  103,  103, yy_Dummy>>,
			1, 6, 8586)
		end

	yy_ec_template_27 (an_array: ARRAY [INTEGER])
			-- Fill chunk #27 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   97,   96,   96,   98, yy_Dummy>>,
			1, 4, 8704)
		end

	yy_ec_template_28 (an_array: ARRAY [INTEGER])
			-- Fill chunk #28 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   99,  100,  103,  103,  103,  103,  103,  103,  103,  103,
			   96,   96,  101,  102, yy_Dummy>>,
			1, 14, 10214)
		end

	yy_ec_template_29 (an_array: ARRAY [INTEGER])
			-- Fill chunk #29 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   96,   96,   96,   96,   96,   96,  103,  103,  103,  103,
			  103,  103,  103,  103,  103,  103,  103,  103,  103,  103,
			   96,   96,   96,   96,  103,   96,   96, yy_Dummy>>,
			1, 27, 11493)
		end

	yy_ec_template_30 (an_array: ARRAY [INTEGER])
			-- Fill chunk #30 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   96,   96,  103,  103,  103,  103,   96,   96,   96,  103,
			  103,   96,  103,  103,   96,   96,   96,   96,   96,   96,
			   96,   96,   96,   96,   96,   96,   96,   96,  103,  103,
			   96,   96,  103,  103,  103,  103,  103,  103,  103,  103,
			  103,  103,   96,   96,   96,   96,   96,  103,   96,   96,
			   96,   96,   96,   96,   96,   96,   96,   96,   96,   96,
			   96,   96,   96,   96,   96,   96,  103,   96,   96,   96,
			   96,   96,   96,   96,   96,   96,   96,   96,   96,   96,
			   96,   96,   96, yy_Dummy>>,
			1, 83, 11776)
		end

	yy_ec_template_31 (an_array: ARRAY [INTEGER])
			-- Fill chunk #31 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   96,   96,   96,   96,   96,   96,   96,   96,   96,   96,
			   96,   96,  103,  103,  103,  103,    3,   96,   96,   96,
			   96,  103,  103,  103,  103,  103,  103,  103,  103,  103,
			  103,  103,  103,  103,   96,   96,  103,  103,  103,  103,
			  103,  103,  103,  103,   96,  103,  103,  103,   96,  103,
			  103,  103,  103,  103,  103,  103,  103,  103,  103,  103,
			  103,  103,  103,  103,   96,  103,  103,  103,  103,  103,
			   96,   96,  103,  103,  103,  103,  103,   96,   96,   96, yy_Dummy>>,
			1, 80, 12272)
		end

	yy_ec_template_32 (an_array: ARRAY [INTEGER])
			-- Fill chunk #32 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   95,   95,  103,  103,  103,   96, yy_Dummy>>,
			1, 6, 12443)
		end

	yy_ec_template_33 (an_array: ARRAY [INTEGER])
			-- Fill chunk #33 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   96,   96,  103,  103,  103,  103,   96,   96,   96,   96,
			   96,   96,   96,   96,   96,   96, yy_Dummy>>,
			1, 16, 12688)
		end

	yy_ec_template_34 (an_array: ARRAY [INTEGER])
			-- Fill chunk #34 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			  103,  103,  103,  103,  103,  103,  103,  103,   96,  103,
			  103,  103,  103,  103,  103,  103,  103,  103,  103,  103,
			  103,  103,  103,  103, yy_Dummy>>,
			1, 24, 12872)
		end

	yy_ec_template_35 (an_array: ARRAY [INTEGER])
			-- Fill chunk #35 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   96,  103,  103,  103,  103,  103,  103,  103,  103,  103,
			  103,   96, yy_Dummy>>,
			1, 12, 42611)
		end

	yy_ec_template_36 (an_array: ARRAY [INTEGER])
			-- Fill chunk #36 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   96,   96,   96,   96,   96,   96,  103,  103,  103,  103,
			  103,  103,  103,  103,   95,   95,   95,   95,   95,   95,
			   95,   95,   95,   95,   95,   95,   95,   95,   95,   95,
			   95,   95,   95,   95,   95,   95,   95,  103,  103,  103,
			  103,  103,  103,  103,  103,  103,   95,   95, yy_Dummy>>,
			1, 48, 42738)
		end

	yy_ec_template_37 (an_array: ARRAY [INTEGER])
			-- Fill chunk #37 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   96,   96,   96,   96,  103,  103,  103,  103,  103,  103,
			  103,  103,  103,  103,   96,   96,   96,   96, yy_Dummy>>,
			1, 18, 43048)
		end

	yy_ec_template_38 (an_array: ARRAY [INTEGER])
			-- Fill chunk #38 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   96,   96,   96,  103,   96, yy_Dummy>>,
			1, 5, 43256)
		end

	yy_ec_template_39 (an_array: ARRAY [INTEGER])
			-- Fill chunk #39 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   96,   96,   96,   96,   96,   96,   96,   96,   96,   96,
			   96,   96,   96,  103,  103,  103,  103,  103,  103,  103,
			  103,  103,  103,  103,  103,  103,  103,  103,  103,   96,
			   96, yy_Dummy>>,
			1, 31, 43457)
		end

	yy_ec_template_40 (an_array: ARRAY [INTEGER])
			-- Fill chunk #40 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   96,   96,   96,   96,  103,  103,  103,  103,  103,  103,
			  103,  103,  103,  103,  103,  103,  103,  103,  103,  103,
			  103,  103,  103,  103,  103,  103,  103,   96,   96,   96, yy_Dummy>>,
			1, 30, 43612)
		end

	yy_ec_template_41 (an_array: ARRAY [INTEGER])
			-- Fill chunk #41 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   96,   96,  103,  103,  103,  103,  103,  103,  103,  103,
			  103,  103,  103,  103,  103,  103,  103,  103,   96,   96, yy_Dummy>>,
			1, 20, 43742)
		end

	yy_ec_template_42 (an_array: ARRAY [INTEGER])
			-- Fill chunk #42 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   95,  103,  103,  103,  103,  103,  103,  103,  103,  103,
			  103,  103,  103,  103,  103,   95,   95, yy_Dummy>>,
			1, 17, 43867)
		end

	yy_ec_template_43 (an_array: ARRAY [INTEGER])
			-- Fill chunk #43 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   96,   96,  103,  103,  103,  103,  103,  103,  103,  103,
			  103,  103,  103,  103,  103,  103,  103,  103,  103,  103,
			   96,   96,   96,   96,   96,   96,   96,  103,  103,   96,
			  103,  103,  103,  103,  103,  103,  103,  103,  103,  103,
			  103,  103,  103,  103,  103,  103,  103,  103,  103,  103,
			  103,  103,   96,   96,   96,   96,   96,  103,  103,  103,
			  103,  103,  103,  103,  103,  103,  103,  103,  103,  103,
			  103,  103,  103,   96,   96,  103,  103,   96,   96,   96,
			   96,   96,   96,   96,   96,   96,   96,  103,   96,   96,
			   96,   96,   96,  103,  103,  103,  103,  103,  103,   96,

			   96,   96,   96,   96,   96,   96,   96,  103,   96,   96,
			   96,   96, yy_Dummy>>,
			1, 112, 62972)
		end

	yy_ec_template_44 (an_array: ARRAY [INTEGER])
			-- Fill chunk #44 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   96,   96,   96,   96,   96,   96,   96,  103,  103,   96,
			   96,   96,   96,   96,   96,  103,  103,  103,  103,  103,
			  103,  103,  103,  103,  103,   96,   96,   96,   96,   96,
			   96,   96, yy_Dummy>>,
			1, 32, 63233)
		end

	yy_ec_template_45 (an_array: ARRAY [INTEGER])
			-- Fill chunk #45 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   96,  103,   95,   96,   95, yy_Dummy>>,
			1, 5, 63292)
		end

	yy_ec_template_46 (an_array: ARRAY [INTEGER])
			-- Fill chunk #46 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   96,  103,   96,  103,  103,   96,  103,  103,   96,   96, yy_Dummy>>,
			1, 10, 63324)
		end

	yy_ec_template_47 (an_array: ARRAY [INTEGER])
			-- Fill chunk #47 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   96,   96,   96,   95,   96,   96,   96,  103,   96,   96,
			   96,   96,   96,   96,   96,  103,  103,  103,  103,  103,
			  103,  103,  103,  103,  103,  103,  103,  103,   96,   96, yy_Dummy>>,
			1, 30, 63456)
		end

	yy_ec_template_48 (an_array: ARRAY [INTEGER])
			-- Fill chunk #48 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   96,   96,   96,   96,   96,   96,   96,   96,   96,   96,
			   96,   96,   96,   96,   96,   96,   96,  103,  103,   96,
			   96,   96,  103,   96,   96,   96,   96,   96,   96,   96,
			   96,   96,   96,   96,   96,   96,  103,  103,  103,   96, yy_Dummy>>,
			1, 40, 63865)
		end

	yy_ec_template_49 (an_array: ARRAY [INTEGER])
			-- Fill chunk #49 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   96,   96,  103,   96,   96,   96,   96, yy_Dummy>>,
			1, 7, 67771)
		end

	yy_ec_template_50 (an_array: ARRAY [INTEGER])
			-- Fill chunk #50 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   96,   96,   96,   96,  103,  103,  103,  103,   96,  103,
			  103,  103,  103,  103,  103,  103,  103,  103,  103,  103,
			  103,  103,   96,  103,   96,   96,   96, yy_Dummy>>,
			1, 27, 68037)
		end

	yy_ec_template_51 (an_array: ARRAY [INTEGER])
			-- Fill chunk #51 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   96,   96,   96,   96,   96,  103,  103,  103,  103,  103,
			  103,  103,  103,  103,  103,   96,   96,  103,   96, yy_Dummy>>,
			1, 19, 68683)
		end

	yy_ec_template_52 (an_array: ARRAY [INTEGER])
			-- Fill chunk #52 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   96,   96,   96,  103,   96,   96,   96,   96,   96, yy_Dummy>>,
			1, 9, 70298)
		end

	yy_ec_template_53 (an_array: ARRAY [INTEGER])
			-- Fill chunk #53 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			  103,  103,  103,  103,  103,  103,  103,  103,  103,  103,
			  103,  103,  103,   96, yy_Dummy>>,
			1, 14, 71666)
		end

	yy_ec_template_54 (an_array: ARRAY [INTEGER])
			-- Fill chunk #54 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   96,   96,   96,   96,   96,   96,   96,   96,   96,  103,
			  103,  103,  103,   96,   96, yy_Dummy>>,
			1, 15, 90935)
		end

	yy_ec_template_55 (an_array: ARRAY [INTEGER])
			-- Fill chunk #55 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   96,  103,  103,   96, yy_Dummy>>,
			1, 4, 111772)
		end

	yy_ec_template_56 (an_array: ARRAY [INTEGER])
			-- Fill chunk #56 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			  103,  103,  103,  103,  103,   96,   96,   96,  103,  103,
			  103,  103,  103,  103,  103,  103,  103,  103,  103,  103,
			  103,  103,  103,  103,  103,  103,  103,  103,  103,  103,
			   96,   96,  103,  103,  103,  103,  103,  103,  103, yy_Dummy>>,
			1, 39, 117093)
		end

	yy_ec_template_57 (an_array: ARRAY [INTEGER])
			-- Fill chunk #57 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			  103,  103,  103,   96, yy_Dummy>>,
			1, 4, 117314)
		end

	yy_ec_template_58 (an_array: ARRAY [INTEGER])
			-- Fill chunk #58 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   96,   96,   96,   96,   96,   96,   96,   96,  103,   96,
			   96,   96,   96,   96,   96,   96,   96,   96,   96,   96,
			   96,   96,   96,  103,   96,   96,   96,   96,   96,   96,
			   96, yy_Dummy>>,
			1, 31, 119405)
		end

	yy_ec_template_59 (an_array: ARRAY [INTEGER])
			-- Fill chunk #59 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   96,  103,  103,  103,   96, yy_Dummy>>,
			1, 5, 124076)
		end

	yy_ec_template_60 (an_array: ARRAY [INTEGER])
			-- Fill chunk #60 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			  103,  103,  103,  103,  103,  103,  103,  103,  103,  103,
			  103,  103,   96,   96,   96,   96,   96,   96,   96,   96,
			   96,   96,   96,   96,   96,   96,   96,  103,  103,   96,
			   96,   96,   96,   96,   96,   96,   96,   96,   96,   96,
			   96,   96,   96,   96,  103,   96,   96,   96,   96,   96,
			   96,   96,   96,   96,   96,   96,   96,   96,   96,   96,
			  103, yy_Dummy>>,
			1, 61, 125076)
		end

	yy_ec_template_61 (an_array: ARRAY [INTEGER])
			-- Fill chunk #61 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			  103,  103,  103,  103,   96,   96,   96,   96,   96,   96,
			   96,   96,   96,  103,  103,  103,  103,  103,  103,  103,
			   96,   96,  103,  103,  103,  103,  103,  103,  103,  103,
			  103,  103,  103,  103,  103,  103,   96,   96,   96,   96,
			   96,   96, yy_Dummy>>,
			1, 42, 125500)
		end

	yy_ec_template_62 (an_array: ARRAY [INTEGER])
			-- Fill chunk #62 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			  103,  103,  103,  103,  103,  103,  103,  103,   96,   96,
			   96,   96,   96,   96,   96,   96,   96,   96,   96,   96,
			   96,  103,  103,  103,   96,   96,   96,   96,   96,   96,
			   96,   96,   96,   96,   96,   96,   96,  103,  103,  103, yy_Dummy>>,
			1, 40, 126680)
		end

	yy_ec_template_63 (an_array: ARRAY [INTEGER])
			-- Fill chunk #63 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			  103,  103,  103,  103,  103,  103,  103,   96,   96,   96,
			   96,   96,   96,   96,   96,   96,   96,   96,   96,  103,
			  103,  103,  103,  103,  103,  103,  103,  103,  103,  103,
			  103,  103,  103,  103,  103,  103,  103,  103,  103,   96,
			   96,   96,   96,   96,   96,   96,   96,   96,   96,   96,
			   96,  103,  103,  103,  103, yy_Dummy>>,
			1, 55, 126937)
		end

	yy_ec_template_64 (an_array: ARRAY [INTEGER])
			-- Fill chunk #64 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			  103,  103,  103,  103,  103,  103,  103,  103,   96,   96,
			   96,   96,   96,   96,   96,   96,   96,   96,  103,  103,
			  103,  103,  103,  103, yy_Dummy>>,
			1, 24, 127048)
		end

	yy_ec_template_65 (an_array: ARRAY [INTEGER])
			-- Fill chunk #65 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			  103,  103,   96,   96, yy_Dummy>>,
			1, 4, 127150)
		end

	yy_ec_template_66 (an_array: ARRAY [INTEGER])
			-- Fill chunk #66 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			  103,  103,  103,  103,  103,  103,  103,  103,  103,  103,
			  103,  103,   96,   96,   96,   96,   96,   96,   96,   96,
			   96,   96,   96,   96,   96,   96,  103,  103,   96,   96,
			   96,   96,   96,  103,  103,  103,   96,   96,   96,  103,
			  103,  103,  103,  103,   96,   96,   96,   96,   96,   96,
			   96,  103,  103,  103,  103,  103,  103,  103,  103,  103, yy_Dummy>>,
			1, 60, 127572)
		end

	yy_ec_template_67 (an_array: ARRAY [INTEGER])
			-- Fill chunk #67 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			  103,  103,  103,  103,  103,  103,  103,   96,   96,   96,
			   96,   96,   96,   96,  103,  103,  103,  103,  103,  103,
			  103,  103,  103,   96,   96,   96,  103,  103,  103,  103,
			  103,  103,  103,  103,  103,  103,  103,  103,  103,   96,
			   96,   96,   96,   96,   96,   96, yy_Dummy>>,
			1, 46, 127657)
		end

	yy_meta_template: SPECIAL [INTEGER]
			-- Template for `yy_meta'
		once
			Result := yy_fixed_array (<<
			    0,    1,    2,    3,    3,    1,    4,    5,    4,    6,
			    7,    8,    9,    9,    4,    4,    6,    4,   10,   11,
			   12,   12,   12,   12,    6,    6,   11,    4,   13,    6,
			   14,   14,   14,   14,   12,   14,   15,   16,   15,   15,
			   15,   16,   15,   16,   15,   15,   16,   16,   16,   16,
			   16,   16,   15,   15,   15,   15,    6,    4,    6,    4,
			   17,   18,   12,   12,   12,   12,   12,   12,   15,   15,
			   15,   15,   15,   15,   15,   15,   15,   15,   15,   15,
			   15,   15,   15,   15,   15,   15,   15,   15,    6,    6,
			    4,    4,    4,    4,    6,    4,    4,    4,    4,   19,

			   19,    4,    4,   19, yy_Dummy>>)
		end

	yy_accept_template: SPECIAL [INTEGER]
			-- Template for `yy_accept'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 905)
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
			   14,   17,   22,   24,   29,   32,   34,   37,   40,   43,
			   48,   53,   56,   59,   62,   67,   70,   73,   76,   79,
			   82,   87,   90,   93,   97,  101,  105,  109,  113,  117,
			  121,  125,  129,  133,  137,  141,  145,  149,  153,  157,
			  161,  165,  168,  172,  175,  180,  184,  186,  189,  192,
			  195,  198,  201,  204,  207,  210,  213,  216,  219,  222,
			  225,  228,  231,  234,  237,  240,  243,  246,  251,  256,
			  261,  266,  269,  272,  277,  282,  284,  286,  288,  291,
			  293,  295,  297,  298,  299,  300,  302,  304,  304,  304,

			  304,  304,  305,  306,  308,  311,  312,  313,  314,  315,
			  315,  316,  317,  318,  320,  321,  322,  323,  324,  327,
			  330,  333,  334,  336,  337,  338,  339,  340,  341,  342,
			  343,  346,  349,  350,  351,  351,  352,  354,  356,  358,
			  360,  362,  365,  367,  368,  369,  370,  371,  372,  374,
			  375,  377,  379,  381,  383,  385,  386,  387,  388,  389,
			  390,  392,  395,  396,  398,  400,  402,  404,  405,  406,
			  407,  409,  411,  413,  414,  415,  416,  419,  421,  423,
			  426,  428,  429,  430,  432,  434,  436,  437,  438,  440,
			  441,  443,  445,  447,  450,  451,  452,  453,  455,  457, yy_Dummy>>,
			1, 200, 0)
		end

	yy_accept_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			  458,  460,  461,  463,  465,  467,  468,  469,  470,  472,
			  474,  475,  476,  478,  479,  481,  483,  484,  485,  487,
			  488,  490,  491,  494,  494,  497,  497,  500,  500,  503,
			  503,  504,  504,  505,  505,  508,  508,  511,  511,  512,
			  513,  513,  513,  514,  515,  516,  517,  518,  520,  521,
			  523,  525,  527,  528,  531,  532,  535,  535,  536,  538,
			  541,  544,  547,  549,  553,  555,  559,  560,  562,  563,
			  564,  565,  566,  567,  568,  569,  570,  571,  572,  573,
			  574,  575,  576,  577,  578,  579,  580,  581,  582,  583,
			  584,  585,  585,  586,  587,  587,  589,  592,  594,  597,

			  600,  602,  603,  605,  606,  608,  609,  611,  614,  615,
			  617,  620,  622,  624,  625,  627,  628,  630,  631,  633,
			  634,  636,  637,  639,  640,  642,  643,  645,  647,  649,
			  650,  651,  652,  654,  655,  658,  660,  662,  663,  665,
			  667,  668,  669,  671,  672,  674,  675,  677,  678,  680,
			  681,  683,  685,  687,  689,  690,  691,  692,  693,  695,
			  696,  698,  700,  701,  702,  705,  707,  709,  710,  713,
			  715,  717,  718,  720,  721,  723,  725,  727,  729,  731,
			  733,  734,  735,  736,  737,  738,  739,  741,  743,  744,
			  745,  747,  748,  750,  751,  753,  754,  756,  757,  759, yy_Dummy>>,
			1, 200, 200)
		end

	yy_accept_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			  761,  763,  764,  765,  766,  768,  769,  771,  772,  774,
			  775,  778,  780,  781,  782,  784,  786,  788,  790,  792,
			  793,  794,  795,  796,  797,  798,  798,  801,  801,  803,
			  803,  806,  806,  806,  806,  808,  810,  812,  813,  814,
			  815,  816,  817,  818,  819,  820,  821,  822,  823,  824,
			  825,  826,  827,  828,  829,  830,  831,  832,  833,  834,
			  835,  836,  837,  838,  839,  840,  840,  841,  842,  842,
			  842,  843,  845,  847,  849,  851,  851,  853,  855,  857,
			  858,  860,  861,  863,  864,  866,  867,  869,  871,  872,
			  873,  875,  876,  878,  879,  881,  882,  884,  885,  887,

			  888,  890,  891,  893,  894,  896,  897,  900,  902,  904,
			  905,  907,  909,  910,  911,  913,  914,  916,  917,  919,
			  920,  923,  925,  927,  928,  930,  931,  933,  934,  936,
			  937,  939,  940,  942,  943,  946,  948,  950,  951,  954,
			  956,  959,  961,  963,  964,  967,  969,  971,  972,  974,
			  975,  977,  978,  980,  981,  983,  984,  986,  988,  989,
			  990,  992,  993,  995,  996,  998,  999, 1002, 1004, 1006,
			 1007, 1010, 1012, 1015, 1017, 1019, 1020, 1022, 1023, 1025,
			 1026, 1028, 1029, 1032, 1034, 1037, 1039, 1040, 1041, 1043,
			 1045, 1045, 1045, 1045, 1045, 1047, 1049, 1052, 1055, 1056, yy_Dummy>>,
			1, 200, 400)
		end

	yy_accept_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			 1056, 1056, 1056, 1056, 1057, 1057, 1058, 1058, 1059, 1060,
			 1062, 1064, 1065, 1068, 1070, 1073, 1075, 1077, 1078, 1080,
			 1081, 1083, 1084, 1087, 1089, 1092, 1094, 1096, 1097, 1099,
			 1100, 1102, 1103, 1106, 1108, 1110, 1111, 1113, 1114, 1116,
			 1117, 1119, 1120, 1122, 1123, 1125, 1126, 1128, 1129, 1132,
			 1134, 1136, 1137, 1139, 1140, 1142, 1143, 1145, 1146, 1148,
			 1149, 1151, 1152, 1154, 1155, 1158, 1160, 1162, 1163, 1165,
			 1166, 1168, 1169, 1171, 1172, 1174, 1175, 1177, 1178, 1180,
			 1181, 1183, 1184, 1187, 1189, 1191, 1192, 1194, 1195, 1198,
			 1200, 1202, 1203, 1205, 1206, 1209, 1211, 1213, 1214, 1214,

			 1214, 1214, 1215, 1215, 1215, 1215, 1215, 1215, 1216, 1217,
			 1217, 1217, 1218, 1221, 1223, 1226, 1228, 1230, 1231, 1233,
			 1234, 1236, 1237, 1240, 1242, 1244, 1245, 1247, 1248, 1250,
			 1251, 1253, 1254, 1257, 1259, 1262, 1264, 1266, 1267, 1270,
			 1272, 1274, 1275, 1277, 1278, 1281, 1283, 1285, 1286, 1288,
			 1289, 1291, 1292, 1294, 1295, 1297, 1298, 1300, 1301, 1303,
			 1304, 1306, 1307, 1309, 1310, 1313, 1315, 1317, 1318, 1321,
			 1323, 1326, 1328, 1331, 1333, 1335, 1336, 1338, 1339, 1342,
			 1344, 1346, 1347, 1347, 1347, 1347, 1347, 1347, 1347, 1347,
			 1347, 1347, 1347, 1347, 1348, 1349, 1349, 1349, 1350, 1350, yy_Dummy>>,
			1, 200, 600)
		end

	yy_accept_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			 1351, 1351, 1353, 1354, 1356, 1357, 1360, 1362, 1364, 1365,
			 1368, 1370, 1372, 1373, 1375, 1376, 1378, 1379, 1381, 1382,
			 1385, 1387, 1390, 1392, 1394, 1395, 1398, 1400, 1403, 1405,
			 1407, 1408, 1410, 1411, 1413, 1414, 1416, 1417, 1419, 1420,
			 1423, 1425, 1427, 1428, 1430, 1431, 1434, 1436, 1437, 1438,
			 1439, 1440, 1440, 1441, 1441, 1442, 1443, 1443, 1443, 1444,
			 1447, 1449, 1451, 1452, 1455, 1457, 1460, 1462, 1464, 1465,
			 1468, 1470, 1473, 1475, 1478, 1480, 1482, 1483, 1486, 1488,
			 1490, 1491, 1494, 1496, 1498, 1499, 1502, 1504, 1507, 1509,
			 1510, 1510, 1511, 1514, 1516, 1518, 1519, 1522, 1524, 1527,

			 1529, 1532, 1534, 1537, 1539, 1539, yy_Dummy>>,
			1, 106, 800)
		end

	yy_acclist_template: SPECIAL [INTEGER]
			-- Template for `yy_acclist'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 1538)
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
			    0,  169,  169,  183,  181,  182,    2,  181,  182,    4,
			  182,    5,  181,  182,    1,  181,  182,   11,  126,  181,
			  182, -314,  181,  182,  125,  126,  181,  182, -314,   18,
			  181,  182,  181,  182,  159,  181,  182,   12,  181,  182,
			   13,  181,  182,   35,  126,  181,  182, -314,   34,  126,
			  181,  182, -314,    9,  181,  182,   33,  181,  182,    7,
			  181,  182,   36,  126,  181,  182, -314,  171,  181,  182,
			  171,  181,  182,   10,  181,  182,    8,  181,  182,   40,
			  181,  182,   38,  126,  181,  182, -314,   39,  181,  182,
			   19,  181,  182,  123,  124,  181,  182,  123,  124,  181,

			  182,  123,  124,  181,  182,  123,  124,  181,  182,  123,
			  124,  181,  182,  123,  124,  181,  182,  123,  124,  181,
			  182,  123,  124,  181,  182,  123,  124,  181,  182,  123,
			  124,  181,  182,  123,  124,  181,  182,  123,  124,  181,
			  182,  123,  124,  181,  182,  123,  124,  181,  182,  123,
			  124,  181,  182,  123,  124,  181,  182,  123,  124,  181,
			  182,  123,  124,  181,  182,   16,  181,  182,  126,  181,
			  182, -314,   17,  181,  182,   37,  126,  181,  182, -314,
			  126,  181,  182, -314,  181,  182,  124,  181,  182,  124,
			  181,  182,  124,  181,  182,  124,  181,  182,  124,  181, yy_Dummy>>,
			1, 200, 0)
		end

	yy_acclist_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  182,  124,  181,  182,  124,  181,  182,  124,  181,  182,
			  124,  181,  182,  124,  181,  182,  124,  181,  182,  124,
			  181,  182,  124,  181,  182,  124,  181,  182,  124,  181,
			  182,  124,  181,  182,  124,  181,  182,  124,  181,  182,
			   14,  181,  182,   15,  181,  182,   41,  126,  181,  182,
			 -314,   46,  126,  181,  182, -314,   42,  126,  181,  182,
			 -314,   44,  126,  181,  182, -314,   52,  181,  182,   54,
			  181,  182,   50,  126,  181,  182, -314,   48,  126,  181,
			  182, -314,  169,  182,  164,  182,  166,  182,  167,  169,
			  182,  163,  182,  168,  182,  169,  182,    2,    3,    1,

			  130, -132,  126, -313,  170,  170, -161, -343,  125,  126,
			 -313,  125,  125,  125,  125,  159,  159,  159,  126, -314,
			    6,   26,   27,  178,   21,  126, -313,   23,  126, -313,
			   32,  126, -313,  178,  171,  177,  177,  177,  177,  177,
			  177,   31,   28,   25,  126, -314,   24,  126, -314,   29,
			   20,   30,  123,  124,  123,  124,  123,  124,  123,  124,
			  123,  124,   60,  123,  124,  123,  124,  124,  124,  124,
			  124,  124,   60,  124,  124,  123,  124,  123,  124,  123,
			  124,  123,  124,  123,  124,  124,  124,  124,  124,  124,
			  123,  124,   70,  123,  124,  124,   70,  124,  123,  124, yy_Dummy>>,
			1, 200, 200)
		end

	yy_acclist_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  123,  124,  123,  124,  124,  124,  124,  123,  124,  123,
			  124,  123,  124,  124,  124,  124,   82,  123,  124,  123,
			  124,  123,  124,   87,  123,  124,   82,  124,  124,  124,
			   87,  124,  123,  124,  123,  124,  124,  124,  123,  124,
			  124,  123,  124,  123,  124,  123,  124,   95,  123,  124,
			  124,  124,  124,   95,  124,  123,  124,  124,  123,  124,
			  124,  123,  124,  123,  124,  123,  124,  124,  124,  124,
			  123,  124,  123,  124,  124,  124,  123,  124,  124,  123,
			  124,  123,  124,  124,  124,  123,  124,  124,  123,  124,
			  124,   22,  126, -313,   47,  130, -132,   43,  130, -132,

			   45,  130, -132,   53,   55,   51,  130, -132,   49,  130,
			 -132,  169,  164,  165,  169,  169,  163,  162,  130, -131,
			  126,  126, -311,  126, -310,  126, -313, -132,  126, -311,
			 -313,  126,  126, -310, -313, -161,  125,  126,  125,  126,
			 -311,  125,  126, -310,  125,  126, -313,  125, -132,  125,
			  126, -311, -313,  125,  126,  125,  126, -310, -313,  159,
			  133,  159,  159,  159,  159,  159,  159,  159,  159,  159,
			  159,  159,  159,  159,  159,  159,  159,  159,  159,  159,
			  159,  159,  159,  159,  178,  172,  178,  171,  177,  175,
			  176,  177,  176,  177,  174,  176,  177,  173,  176,  177, yy_Dummy>>,
			1, 200, 400)
		end

	yy_acclist_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  171,  177,  177,  123,  124,  124,  123,  124,  124,  123,
			  124,   58,  123,  124,  124,   58,  124,   59,  123,  124,
			   59,  124,  123,  124,  124,  123,  124,  124,  123,  124,
			  124,  123,  124,  124,  123,  124,  124,  123,  124,  124,
			  123,  124,  124,  123,  124,  123,  124,  123,  124,  124,
			  124,  124,  123,  124,  124,   73,  123,  124,  123,  124,
			   73,  124,  124,  123,  124,  123,  124,  124,  124,  123,
			  124,  124,  123,  124,  124,  123,  124,  124,  123,  124,
			  124,  123,  124,  123,  124,  123,  124,  123,  124,  124,
			  124,  124,  124,  123,  124,  124,  123,  124,  123,  124,

			  124,  124,   91,  123,  124,   91,  124,  123,  124,  124,
			   93,  123,  124,   93,  124,  123,  124,  124,  123,  124,
			  124,  123,  124,  123,  124,  123,  124,  123,  124,  123,
			  124,  123,  124,  124,  124,  124,  124,  124,  124,  123,
			  124,  123,  124,  124,  124,  123,  124,  124,  123,  124,
			  124,  123,  124,  124,  123,  124,  124,  123,  124,  123,
			  124,  123,  124,  124,  124,  124,  123,  124,  124,  123,
			  124,  124,  123,  124,  124,  115,  123,  124,  115,  124,
			  180,  179,   47, -132,   43, -132,   45, -132,   51, -132,
			   49, -132,  127, -131, -129,  126, -128,  126, -129,  130, yy_Dummy>>,
			1, 200, 600)
		end

	yy_acclist_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			 -131,  127,  130, -128,  130, -131,  125, -131,  125,  126,
			  125,  126,  125,  125,  125,  125,  150,  148,  149,  151,
			  152,  160,  160,  153,  154,  134,  135,  136,  137,  138,
			  139,  140,  141,  142,  143,  144,  145,  146,  147,  178,
			  178,  178,  178,  171,  177,  176,  177,  176,  177,  176,
			  177,  171,  177,  171,  177,  123,  124,  124,  123,  124,
			  124,  123,  124,  124,  123,  124,  124,  123,  124,  123,
			  124,  124,  124,  123,  124,  124,  123,  124,  124,  123,
			  124,  124,  123,  124,  124,  123,  124,  124,  123,  124,
			  124,  123,  124,  124,  123,  124,  124,   71,  123,  124,

			   71,  124,  123,  124,  124,  123,  124,  123,  124,  124,
			  124,  123,  124,  124,  123,  124,  124,  123,  124,  124,
			   80,  123,  124,  123,  124,   80,  124,  124,  123,  124,
			  124,  123,  124,  124,  123,  124,  124,  123,  124,  124,
			  123,  124,  124,   88,  123,  124,   88,  124,  123,  124,
			  124,   90,  123,  124,   90,  124,  120,  123,  124,  120,
			  124,  123,  124,  124,   94,  123,  124,   94,  124,  123,
			  124,  124,  123,  124,  124,  123,  124,  124,  123,  124,
			  124,  123,  124,  124,  123,  124,  123,  124,  124,  124,
			  123,  124,  124,  123,  124,  124,  123,  124,  124,  121, yy_Dummy>>,
			1, 200, 800)
		end

	yy_acclist_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  123,  124,  121,  124,  123,  124,  124,  107,  123,  124,
			  107,  124,  108,  123,  124,  108,  124,  123,  124,  124,
			  123,  124,  124,  123,  124,  124,  123,  124,  124,  113,
			  123,  124,  113,  124,  114,  123,  124,  114,  124, -129,
			 -128, -129, -131, -128, -131,  125, -129,  125, -128,  125,
			 -129, -131,  125, -128, -131,  160,  178,  178,  178,  178,
			  171,  177,  123,  124,  124,   56,  123,  124,   56,  124,
			   57,  123,  124,   57,  124,  123,  124,  124,  123,  124,
			  124,  123,  124,  124,   62,  123,  124,   62,  124,   63,
			  123,  124,   63,  124,  123,  124,  124,  123,  124,  124,

			  123,  124,  124,   68,  123,  124,   68,  124,  123,  124,
			  124,  123,  124,  124,  123,  124,  124,  123,  124,  124,
			  123,  124,  124,  123,  124,  124,  123,  124,  124,   78,
			  123,  124,   78,  124,  123,  124,  124,  123,  124,  124,
			  123,  124,  124,  123,  124,  124,  123,  124,  124,  123,
			  124,  124,  123,  124,  124,   89,  123,  124,   89,  124,
			  123,  124,  124,  123,  124,  124,  123,  124,  124,  123,
			  124,  124,  123,  124,  124,  123,  124,  124,  123,  124,
			  124,  123,  124,  124,  103,  123,  124,  103,  124,  123,
			  124,  124,  123,  124,  124,  106,  123,  124,  106,  124, yy_Dummy>>,
			1, 200, 1000)
		end

	yy_acclist_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  123,  124,  124,  123,  124,  124,  111,  123,  124,  111,
			  124,  123,  124,  124,  155,  178,  178,  178,  116,  123,
			  124,  116,  124,   61,  123,  124,   61,  124,  123,  124,
			  124,  123,  124,  124,  123,  124,  124,   65,  123,  124,
			  123,  124,   65,  124,  124,  123,  124,  124,  123,  124,
			  124,  123,  124,  124,   72,  123,  124,   72,  124,   74,
			  123,  124,   74,  124,  123,  124,  124,   76,  123,  124,
			   76,  124,  123,  124,  124,  123,  124,  124,   81,  123,
			  124,   81,  124,  123,  124,  124,  123,  124,  124,  123,
			  124,  124,  123,  124,  124,  123,  124,  124,  123,  124,

			  124,  123,  124,  124,  123,  124,  124,  123,  124,  124,
			   99,  123,  124,   99,  124,  123,  124,  124,  101,  123,
			  124,  101,  124,  102,  123,  124,  102,  124,  104,  123,
			  124,  104,  124,  123,  124,  124,  123,  124,  124,  110,
			  123,  124,  110,  124,  123,  124,  124,  178,  178,  178,
			  178,  123,  124,  124,  123,  124,  124,   64,  123,  124,
			   64,  124,  123,  124,  124,   67,  123,  124,   67,  124,
			  123,  124,  124,  123,  124,  124,  123,  124,  124,  123,
			  124,  124,   79,  123,  124,   79,  124,   83,  123,  124,
			   83,  124,  123,  124,  124,   84,  123,  124,   84,  124, yy_Dummy>>,
			1, 200, 1200)
		end

	yy_acclist_template_8 (an_array: ARRAY [INTEGER])
			-- Fill chunk #8 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			   85,  123,  124,   85,  124,  123,  124,  124,  123,  124,
			  124,  123,  124,  124,  123,  124,  124,  123,  124,  124,
			  100,  123,  124,  100,  124,  123,  124,  124,  123,  124,
			  124,  112,  123,  124,  112,  124,  158,  157,  156,  178,
			  178,  178,  178,  178,  117,  123,  124,  117,  124,  123,
			  124,  124,   66,  123,  124,   66,  124,   69,  123,  124,
			   69,  124,  123,  124,  124,   75,  123,  124,   75,  124,
			   77,  123,  124,   77,  124,  122,  123,  124,  122,  124,
			  123,  124,  124,   92,  123,  124,   92,  124,  123,  124,
			  124,   98,  123,  124,   98,  124,  123,  124,  124,  105,

			  123,  124,  105,  124,  109,  123,  124,  109,  124,  178,
			  178,  118,  123,  124,  118,  124,  123,  124,  124,   86,
			  123,  124,   86,  124,   96,  123,  124,   96,  124,   97,
			  123,  124,   97,  124,  119,  123,  124,  119,  124, yy_Dummy>>,
			1, 139, 1400)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER = 2614
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER = 904
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER = 905
			-- Mark between normal states and templates

	yyNull_equiv_class: INTEGER = 103
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

	yyNb_rules: INTEGER = 182
			-- Number of rules

	yyEnd_of_buffer: INTEGER = 183
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
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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
