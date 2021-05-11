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
				
when 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18 then
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
					
when 19 then
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
					
when 20 then
	yy_end := yy_start + yy_more_len + 2
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
					
when 21 then
	yy_end := yy_start + yy_more_len + 2
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
					
when 22 then
	yy_end := yy_start + yy_more_len + 2
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
					
when 23 then
	yy_end := yy_start + yy_more_len + 2
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
					
when 24 then
	yy_end := yy_start + yy_more_len + 2
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
					
when 25 then
	yy_end := yy_start + yy_more_len + 2
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
					
when 26 then
	yy_end := yy_start + yy_more_len + 2
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
					
when 27 then
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
					
when 28 then
	yy_end := yy_start + yy_more_len + 2
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
					
when 29 then
	yy_end := yy_start + yy_more_len + 2
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
					
when 30, 31 then
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
					
when 32 then
	yy_end := yy_start + yy_more_len + 1
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
					
when 33 then
	yy_end := yy_start + yy_more_len + 1
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
					
when 34 then
	yy_end := yy_start + yy_more_len + 1
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
					
when 35 then
	yy_end := yy_start + yy_more_len + 1
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
					
when 36 then
	yy_end := yy_start + yy_more_len + 1
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
					
when 37 then
	yy_end := yy_start + yy_more_len + 1
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
					
when 38 then
	yy_end := yy_start + yy_more_len + 1
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
					
when 39 then
	yy_end := yy_start + yy_more_len + 1
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
					
when 40 then
	yy_end := yy_start + yy_more_len + 1
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
					
when 41 then
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
								
when 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108 then
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
								
when 109, 110, 111, 112, 113, 114 then
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
						
when 115 then
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
						
when 116 then
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
						
when 117 then
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
						
when 118 then
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
										
when 119 then
	yy_end := yy_end - 2
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
	yy_end := yy_end - 2
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
	yy_end := yy_end - 2
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
										
when 125 then
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
										
when 126 then
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
										
when 127 then
	yy_end := yy_end - 2
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
										
when 128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 151, 152, 153 then
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
	
when 154, 155 then
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
	
when 156 then
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
	
when 157 then
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
		
when 158 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

			curr_token := new_space (text_count)
			update_token_list						
		
when 159 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

			curr_token := new_tabulation (text_count)
			update_token_list						
		
when 160 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

			curr_token := new_eol (True)
			update_token_list
			in_comments := False
		
when 161 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

			curr_token := new_eol (False)
			update_token_list
			in_comments := False
		
when 162 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

			curr_token := new_text
			update_token_list
		
when 163 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

			curr_token := new_string
			update_token_list
		
when 164 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

			curr_token := new_string
			update_token_list
		
when 165 then
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
	
when 166 then
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
	
when 167 then
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
	
when 168, 169, 170 then
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
	
when 171, 172 then
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
	
when 173 then
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
	
when 174, 175 then
--|#line <not available> "editor_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'editor_eiffel_scanner.l' at line <not available>")
end

		curr_token := new_text_in_comment
		update_token_list
	
when 176 then
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
	
when 177 then
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
			create an_array.make_filled (0, 0, 2733)
			yy_nxt_template_1 (an_array)
			yy_nxt_template_2 (an_array)
			yy_nxt_template_3 (an_array)
			an_array.area.fill_with (150, 478, 503)
			yy_nxt_template_4 (an_array)
			an_array.area.fill_with (157, 510, 535)
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
			an_array.area.fill_with (956, 2630, 2733)
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
			  101,   91,   87,   88,  100,   89,   90,  101,   91,   97,
			   98,  109,  110,  111,  112,  113,  114,  116,  117,  119,
			  144,  120,  120,  120,  120,  121,  122,  123,  118,  126,
			  145,  127,  127,  127,  127,  124,  202,  126,  212,  127,
			  127,  127,  127,  129,  130,  134,  135,  102,  138,  139,
			  214,  140,  141,   92,  136,  137,  174,  237,  238,  753,
			   92,  142,  143,  226,  100,  131,  175,  101,  203,  107,
			  213,  842,  132,   97,   98,  129,  130,  232,  234,  102,
			  132,  901,  215,  164,   92,  184,  900,  165,  176,  185, yy_Dummy>>,
			1, 200, 0)
		end

	yy_nxt_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  166,   92,  103,  167,  103,  227,  168,  131,  177,  125,
			  103,  103,  186,  105,  106,  103,  178,  899,  179,  233,
			  235,  836,  103,  103,  103,  169,  103,  187,  180,  170,
			  198,  188,  171,  190,  203,  172,  199,  204,  173,  213,
			  191,  192,  222,  215,  189,  228,  193,  205,  181,  206,
			  182,  227,  223,  207,  103,  836,  103,  103,  103,  229,
			  183,  753,  200,   97,   98,  194,  203,  530,  201,  208,
			   96,  213,  195,  196,  224,  215,  661,  230,  197,  209,
			  660,  210,  310,  227,  225,  211,  516,  103,  103,  103,
			  103,  231,   96,   96,   96,   96,  240,  241,   96,   96,

			  146,   97,  146,  147,  236,  147,  147,  147,  146,  146,
			  147,  148,  149,  146,  147,  147,  147,  147,  147,  147,
			  146,  146,  146,  147,  146,  216,  233,  158,  200,  176,
			  181,  159,  182,  187,  201,  217,  160,  188,  161,  177,
			  218,  235,  183,  162,  163,  242,   98,  243,   98,  343,
			  189,  147,  146,  147,  146,  146,  146,  219,  233,  158,
			  200,  176,  181,  159,  182,  187,  201,  220,  160,  188,
			  161,  177,  221,  235,  183,  162,  163,  244,   98,  247,
			   98,  344,  189,  147,  147,  146,  146,  146,  146,  147,
			   96,   96,   96,   96,  248,   98,   96,   96,  150,  150, yy_Dummy>>,
			1, 200, 200)
		end

	yy_nxt_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  150,  150,  258,   98,  268,  268,  268,  268,  345,  150,
			  150,  151,  150,  150,  150,  152,  150,  150,  150,  150,
			  153,  150,  154,  150,  150,  150,  150,  155,  156,  150,
			  150,  150,  150,  150,  150,  294,  294,  294,  294,  150,
			  346,  157,  157,  158,  157,  157,  157,  159,  157,  157,
			  157,  157,  160,  157,  161,  157,  157,  157,  157,  162,
			  163,  157,  157,  157,  157,  157,  157,  150,  150,  150,
			  150,  258,   98,  642,  260,  260,  260,  260, yy_Dummy>>,
			1, 78, 400)
		end

	yy_nxt_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  100,   97,   98,  101,  150,  338, yy_Dummy>>,
			1, 6, 504)
		end

	yy_nxt_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  169,  194,  298,  299,  170,  208,  224,  171,  195,  196,
			  172,  230,  219,  173,  197,  209,  225,  210,  102,  264,
			  250,  211,  220,  251,  251,  231,  251,  221,  533,  251,
			  256,  528,  169,  194,  304,  305,  170,  208,  224,  171,
			  195,  196,  172,  230,  219,  173,  197,  209,  225,  210,
			  102,  306,  307,  211,  220,  308,  309,  231,  526,  221,
			  251,  253,  252,  254,  251,  524,  252,  521,  257,  516,
			  262,  249,  841,  262,  262,  507,  100,  505,  252,  101,
			  296,  296,  296,  296,  252,   97,  314,  314,  297,  297,
			  297,  297,  300,  300,  300,  300,  326,  327,  956,  956,

			  956,  956,  332,  333,  956,  956,  457,  301,  351,  252,
			  303,  303,  303,  303,  842,  252,  353,  310,  255,  311,
			  311,  311,  311,  316,  316,  316,  102,  321,  321,  321,
			  321,  334,   98,  126,  312,  313,  313,  313,  313,  301,
			  352,  956,  335,  318,  318,  318,  318,  503,  354,  255,
			  355,  322,  498,  323,   98,  453,  454,  458,  102,  103,
			  497,  103,  324,  344,  325,  496,  312,  103,  103,  346,
			  263,  106,  103,  352,  347,  349,  132,  348,  350,  103,
			  103,  103,  356,  103,  319,  329,  329,  329,  329,  331,
			  331,  331,  331,  337,  354,  344,  342,  342,  342,  342, yy_Dummy>>,
			1, 200, 536)
		end

	yy_nxt_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  356,  346,  357,  359,  361,  352,  349,  349,  363,  350,
			  350,  103,  495,  103,  103,  103,  365,  456,  456,  456,
			  456,  358,  360,  520,   98,  494,  354,  460,  460,  460,
			  460,  362,  356,  364,  358,  360,  362,  366,  750,  750,
			  364,  751,  751,  751,  103,  103,  103,  103,  366,   96,
			   96,   96,   96,  358,  360,   96,   96,  265,  265,  265,
			  265,  265,  266,  362,  266,  364,  373,  374,  383,  366,
			  266,  266,  367,  267,  266,  266,  368,  370,  375,  377,
			  385,  371,  266,  266,  266,  493,  266,  379,  381,  387,
			  369,  380,  382,  376,  378,  372,  384,  386,  374,  374,

			  384,  388,  389,  390,  370,  399,  400,  492,  371,  370,
			  377,  377,  386,  371,  266,  491,  266,  266,  266,  381,
			  381,  388,  372,  382,  382,  378,  378,  372,  384,  386,
			  401,  258,   98,  388,  390,  390,  405,  400,  400,  403,
			  522,  406,  402,  407,  409,  411,  490,  266,  266,  266,
			  266,  404,  115,  115,  115,  115,  408,  489,  115,  115,
			  271,  488,  403,  272,  273,  274,  275,  410,  406,  754,
			  754,  403,  276,  406,  404,  408,  410,  412,  391,  277,
			  412,  278,  392,  404,  279,  280,  281,  282,  408,  283,
			  487,  284,  413,  393,  414,  285,  394,  286,  431,  410, yy_Dummy>>,
			1, 200, 736)
		end

	yy_nxt_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  287,  288,  289,  290,  291,  292,  317,  317,  317,  317,
			  395,  427,  412,  433,  396,  428,  432,  317,  317,  317,
			  317,  317,  317,  486,  414,  397,  414,  252,  398,  434,
			  432,  252,  435,  257,  485,  484,  249,  470,  471,  471,
			  471,  483,  482,  429,  479,  434,  478,  430,  432,  317,
			  317,  317,  317,  317,  317,  339,  339,  339,  339,  339,
			  340,  434,  340,  147,  436,  147,  147,  147,  340,  340,
			  147,  341,  340,  340,  147,  147,  147,  147,  147,  147,
			  340,  340,  340,  147,  340,  395,  415,  429,  416,  396,
			  437,  430,  436,  438,  445,  447,  417,  446,  448,  418,

			  397,  419,  420,  398,  449,  450,  451,  452,  534,  535,
			  536,  147,  340,  147,  340,  340,  340,  395,  421,  429,
			  422,  396,  438,  430,  436,  438,  446,  448,  423,  446,
			  448,  424,  397,  425,  426,  398,  450,  450,  452,  452,
			  535,  535,  537,  147,  147,  340,  340,  340,  340,  147,
			  115,  115,  115,  115,  439,  537,  115,  115,  421,  440,
			  422,  442,  480,  481,  481,  481,  443,  538,  423,  539,
			  441,  424,  250,  425,  426,  251,  251,  444,  251,  477,
			  251,  251,  251,  254,  251,  251,  442,  537,  251,  256,
			  421,  443,  422,  442,  476,  475,  264,  540,  443,  539, yy_Dummy>>,
			1, 200, 936)
		end

	yy_nxt_template_8 (an_array: ARRAY [INTEGER])
			-- Fill chunk #8 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  423,  539,  444,  424,  105,  425,  426,  257,  467,  444,
			  468,  468,  468,  468,  468,  262,  466,  465,  262,  262,
			  464,  100,  314,  314,  101,  463,  259,  469,  541,  541,
			  252,  472,  472,  472,  472,  472,  252,  462,  255,  499,
			  499,  499,  499,  252,  500,  500,  500,  500,  473,  265,
			  265,  265,  265,  265,  504,  504,  504,  504,  461,  301,
			  541,  252,   96,  514,  520,  474,  459,  252,  455,  255,
			  338,  102,  546,   96,  252,  956,  956,  956,  956,  258,
			   98,  956,  956,  506,  506,  506,  506,  501,  337,  501,
			  523,  301,  502,  502,  502,  502,  508,  508,  508,  508,

			  316,  316,  316,  102,  547,  509,  509,  509,  509,  511,
			  547,  511,  336,  330,  512,  512,  512,  512,  328,  126,
			  510,  513,  513,  513,  513,  517,  542,  518,  518,  518,
			  518,  956,  320,  519,  519,  519,  519,  525,  525,  525,
			  525,  515,  547,  543,  956,  956,  956,  956,  258,   98,
			  956,  956,  510,  527,  527,  527,  527,  548,  544,  143,
			  544,  549,  132,  529,  529,  529,  529,  529,  319,  339,
			  339,  339,  339,  339,  319,  545,  550,  545,  551,  530,
			  531,  552,  553,  554,  555,  532,  556,  558,  560,  549,
			  557,  559,  544,  549,  561,  562,  563,  564,  565,  570, yy_Dummy>>,
			1, 200, 1136)
		end

	yy_nxt_template_9 (an_array: ARRAY [INTEGER])
			-- Fill chunk #9 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  571,  572,  573,  566,  574,  575,  580,  568,  551,  545,
			  551,  576,  578,  553,  553,  555,  555,  567,  557,  559,
			  561,  569,  557,  559,  577,  579,  561,  563,  563,  565,
			  565,  571,  571,  573,  573,  568,  575,  575,  581,  568,
			  581,  582,  584,  578,  578,  586,  588,  583,  585,  569,
			  587,  589,  590,  569,  591,  592,  579,  579,  594,  593,
			  595,  596,  597,  598,  599,  600,  601,  602,  603,  604,
			  606,  608,  581,  583,  585,  610,  616,  587,  589,  583,
			  585,  605,  587,  589,  591,  607,  591,  593,  612,  609,
			  595,  593,  595,  597,  597,  599,  599,  601,  601,  603,

			  603,  605,  607,  609,  611,  614,  613,  611,  617,  617,
			  618,  620,  619,  605,  621,  622,  623,  607,  624,  625,
			  614,  609,  626,  615,  627,  628,  629,  630,  632,  634,
			  631,  633,  635,  636,  637,  638,  611,  614,  615,  639,
			  640,  617,  619,  621,  619,  641,  621,  623,  623,  956,
			  625,  625,  302,  297,  627,  615,  627,  629,  629,  631,
			  633,  635,  631,  633,  635,  637,  637,  639,  314,  314,
			  295,  639,  641,  643,  643,  643,  643,  641,  107,  471,
			  471,  471,  471,  107,  471,  471,  471,  471,  293,  662,
			  105,  644,  645,  268,  268,  268,  268,  648,  481,  481, yy_Dummy>>,
			1, 200, 1336)
		end

	yy_nxt_template_10 (an_array: ARRAY [INTEGER])
			-- Fill chunk #10 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  481,  481,  648,  481,  481,  481,  481,  270,  663,  514,
			  649,  650,  261,  646,  653,  653,  653,  653,  259,   95,
			  647,  663,  664,  644,  645,  647,  316,  316,  316,  301,
			  665,  666,  651,  502,  502,  502,  502,  667,  668,  652,
			  663,   93,  649,  650,  652,  646,  502,  502,  502,  502,
			  655,  655,  655,  655,  665,  654,  512,  512,  512,  512,
			  669,  301,  665,  667,  651,  510,  656,  515,  656,  667,
			  669,  657,  657,  657,  657,  512,  512,  512,  512,  658,
			  670,  513,  513,  513,  513,  517,  672,  659,  659,  659,
			  659,  517,  669,  519,  519,  519,  519,  510,  533,  671,

			  673,  342,  342,  342,  342,  674,  675,  676,  677,  678,
			  679,  680,  671,  681,  682,  683,  684,  685,  673,  686,
			  687,  688,  319,  689,  690,  691,  692,  693,  319,  694,
			  696,  671,  673,  695,  319,  697,  698,  675,  675,  677,
			  677,  679,  679,  681,  699,  681,  683,  683,  685,  685,
			  700,  687,  687,  689,  701,  689,  691,  691,  693,  693,
			  702,  695,  697,  703,  704,  695,  705,  697,  699,  706,
			  707,  708,  709,  710,  711,  712,  699,  713,  714,  715,
			  716,  717,  701,  718,  719,  720,  701,  721,  722,  723,
			  724,  725,  703,  726,  727,  703,  705,  728,  705,  729, yy_Dummy>>,
			1, 200, 1536)
		end

	yy_nxt_template_11 (an_array: ARRAY [INTEGER])
			-- Fill chunk #11 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  730,  707,  707,  709,  709,  711,  711,  713,  732,  713,
			  715,  715,  717,  717,  731,  719,  719,  721,  733,  721,
			  723,  723,  725,  725,  734,  727,  727,  735,  736,  729,
			  737,  729,  731,  738,  739,  740,  741,  742,  743,  744,
			  733,  745,  746,  747,  748,  749,  731,  755,  755,  755,
			  733,  471,  471,  471,  471,  246,  735,  245,  764,  735,
			  737,  133,  737,   95,   94,  739,  739,  741,  741,  743,
			  743,  745,   93,  745,  747,  747,  749,  749,  757,  757,
			  757,  757,  653,  653,  653,  653,  759,  759,  759,  759,
			  765,  956,  647,  760,  760,  760,  760,  758,  657,  657,

			  657,  657,  657,  657,  657,  657,  765,  310,  510,  760,
			  760,  760,  760,  766,  767,  768,  769,  770,  763,  652,
			  519,  519,  519,  519,  762,  771,  772,  773,  774,  758,
			  778,  776,  775,  779,  761,  777,  780,  781,  765,  782,
			  510,  783,  784,  785,  786,  767,  767,  769,  769,  771,
			  787,  788,  789,  790,  791,  792,  762,  771,  773,  773,
			  776,  132,  779,  776,  777,  779,  793,  777,  781,  781,
			  794,  783,  795,  783,  785,  785,  787,  796,  797,  798,
			  799,  800,  787,  789,  789,  791,  791,  793,  801,  802,
			  803,  804,  805,  806,  807,  808,  809,  810,  793,  811, yy_Dummy>>,
			1, 200, 1736)
		end

	yy_nxt_template_12 (an_array: ARRAY [INTEGER])
			-- Fill chunk #12 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  812,  813,  795,  814,  795,  815,  816,  817,  818,  797,
			  797,  799,  799,  801,  819,  820,  821,  822,  823,  824,
			  801,  803,  803,  805,  805,  807,  807,  809,  809,  811,
			  825,  811,  813,  813,  826,  815,  827,  815,  817,  817,
			  819,  828,  829,  830,  831,  832,  819,  821,  821,  823,
			  823,  825,  833,  107,  750,  750,  107,  751,  751,  751,
			  853,  854,  825,  837,  754,  754,  827,  956,  827,  839,
			  755,  755,  755,  829,  829,  831,  831,  833,  843,  757,
			  757,  757,  757,  844,  833,  844,  956,  855,  845,  845,
			  845,  845,  854,  854,  856,  834,  956,  956,  835,  846,

			  846,  846,  846,  956,  956,  838,  760,  760,  760,  760,
			  857,  840,  858,  859,  847,  849,  849,  849,  849,  856,
			  652,  848,  850,  860,  850,  861,  856,  851,  851,  851,
			  851,  310,  862,  849,  849,  849,  849,  863,  864,  865,
			  866,  867,  858,  868,  858,  860,  847,  869,  852,  870,
			  871,  872,  873,  848,  874,  860,  875,  862,  876,  877,
			  878,  879,  880,  881,  862,  882,  883,  884,  885,  864,
			  864,  866,  866,  868,  886,  868,  887,  888,  889,  870,
			  852,  870,  872,  872,  874,  890,  874,  891,  876,  892,
			  876,  878,  878,  880,  880,  882,  893,  882,  884,  884, yy_Dummy>>,
			1, 200, 1936)
		end

	yy_nxt_template_13 (an_array: ARRAY [INTEGER])
			-- Fill chunk #13 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  886,  894,  895,  896,  897,  898,  886,  956,  888,  888,
			  890,  750,  750,  751,  751,  751,  956,  890,  911,  892,
			  956,  892,  754,  754,  755,  755,  755,  956,  894,  845,
			  845,  845,  845,  894,  896,  896,  898,  898,  845,  845,
			  845,  845,  902,  902,  902,  902,  851,  851,  851,  851,
			  912,  912,  834,  903,  835,  903,  913,  847,  904,  904,
			  904,  904,  905,  838,  905,  840,  914,  906,  906,  906,
			  906,  907,  907,  907,  907,  851,  851,  851,  851,  915,
			  916,  917,  918,  912,  919,  909,  908,  909,  914,  847,
			  910,  910,  910,  910,  920,  921,  922,  923,  914,  924,

			  925,  926,  927,  928,  929,  930,  931,  932,  933,  934,
			  935,  916,  916,  918,  918,  936,  920,  937,  908,  938,
			  939,  940,  847,  752,  752,  752,  920,  922,  922,  924,
			  956,  924,  926,  926,  928,  928,  930,  930,  932,  932,
			  934,  934,  936,  904,  904,  904,  904,  936,  654,  938,
			  956,  938,  940,  940,  847,  904,  904,  904,  904,  906,
			  906,  906,  906,  906,  906,  906,  906,  941,  941,  941,
			  941,  942,  944,  942,  945,  946,  943,  943,  943,  943,
			  947,  948,  908,  910,  910,  910,  910,  910,  910,  910,
			  910,  949,  950,  951,  952,  953,  908,  943,  943,  943, yy_Dummy>>,
			1, 200, 2136)
		end

	yy_nxt_template_14 (an_array: ARRAY [INTEGER])
			-- Fill chunk #14 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  943,  954,  955,  956,  945,  956,  945,  947,  943,  943,
			  943,  943,  947,  949,  908,  157,  157,  157,  157,  157,
			  157,  956,  761,  949,  951,  951,  953,  953,  908,  756,
			  756,  756,  956,  955,  955,   86,   86,   86,   86,   86,
			   86,   86,   86,   86,   86,   86,   86,   86,   86,   86,
			   86,   86,   86,   86,   96,  956,  956,  956,  956,  956,
			   96,   96,  956,  956,  956,  956,  956,   96,   96,   96,
			   99,  956,   99,   99,   99,   99,   99,   99,   99,   99,
			   99,   99,   99,   99,   99,   99,   99,   99,   99,  104,
			  956,  104,  956,  104,  104,  104,  104,  104,  104,  104,

			  104,  104,  104,  104,  104,  107,  956,  107,  107,  107,
			  107,  107,  107,  107,  107,  107,  107,  107,  107,  107,
			  107,  107,  107,  107,  108,  956,  108,  108,  108,  108,
			  108,  108,  108,  108,  108,  108,  108,  108,  108,  108,
			  108,  108,  108,  115,  956,  956,  956,  956,  956,  115,
			  115,  956,  956,  956,  956,  956,  115,  115,  115,  128,
			  956,  128,  128,  128,  128,  128,  128,  239,  956,  239,
			  239,  239,  956,  956,  239,  239,  239,  239,  239,  239,
			  239,  239,  239,  956,  239,  239,  249,  956,  249,  249,
			  249,  249,  249,  249,  249,  249,  249,  249,  249,  249, yy_Dummy>>,
			1, 200, 2336)
		end

	yy_nxt_template_15 (an_array: ARRAY [INTEGER])
			-- Fill chunk #15 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  249,  249,  249,  255,  956,  255,  255,  255,  255,  255,
			  255,  255,  255,  255,  255,  255,  255,  255,  255,  255,
			  255,  255,  107,  956,  107,  107,  107,  956,  107,  956,
			  107,  956,  956,  107,  269,  956,  269,  269,  269,  269,
			  269,  269,  269,  269,  269,  269,  269,  269,  269,  269,
			  269,  269,  269,  315,  315,  315,  315,  315,  315,  147,
			  956,  147,  956,  147,  147,  147,  147,  147,  956,  956,
			  956,  956,  147,  147,  252,  956,  252,  252,  252,  956,
			  252,  252,  252,  252,  252,  252,  252,  252,  252,  252,
			  252,  252,  252,    5, yy_Dummy>>,
			1, 94, 2536)
		end

	yy_chk_template: SPECIAL [INTEGER]
			-- Template for `yy_chk'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 2733)
			an_array.put (0, 0)
			an_array.area.fill_with (1, 1, 104)
			yy_chk_template_1 (an_array)
			yy_chk_template_2 (an_array)
			an_array.area.fill_with (34, 409, 434)
			yy_chk_template_3 (an_array)
			an_array.area.fill_with (34, 441, 466)
			yy_chk_template_4 (an_array)
			an_array.area.fill_with (35, 478, 503)
			yy_chk_template_5 (an_array)
			an_array.area.fill_with (35, 510, 535)
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
			an_array.area.fill_with (956, 2629, 2733)
			Result := yy_fixed_array (an_array)
		end

	yy_chk_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			    3,    3,   12,    3,    3,   12,    3,    4,    4,   15,
			    4,    4,   15,    4,   11,   11,   16,   16,   19,   19,
			   20,   20,   22,   22,   23,   32,   23,   23,   23,   23,
			   24,   24,   24,   22,   25,   32,   25,   25,   25,   25,
			   24,   42,   26,   44,   26,   26,   26,   26,   25,   25,
			   29,   29,   12,   30,   30,   45,   31,   31,    3,   29,
			   29,   37,   55,   55,  843,    4,   31,   31,   48,  107,
			   25,   37,  107,   42,  752,   44,  842,   25,   56,   56,
			   25,   25,   50,   51,   12,   26,  841,   45,   36,    3,
			   39,  839,   36,   37,   39,   36,    4,   13,   36,   13,

			   48,   36,   25,   37,   24,   13,   13,   39,   13,   13,
			   13,   38,  837,   38,   50,   51,  752,   13,   13,   13,
			   36,   13,   39,   38,   36,   41,   39,   36,   40,   66,
			   36,   41,   43,   36,   68,   40,   40,   47,   69,   39,
			   49,   40,   43,   38,   43,   38,   72,   47,   43,   13,
			  836,   13,   13,   13,   49,   38,  648,   41,   53,   53,
			   40,   66,  533,   41,   43,  522,   68,   40,   40,   47,
			   69,  521,   49,   40,   43,  520,   43,  517,   72,   47,
			   43,  516,   13,   13,   13,   13,   49,   13,   13,   13,
			   13,   78,   78,   13,   13,   33,  469,   33,   33,   53, yy_Dummy>>,
			1, 200, 105)
		end

	yy_chk_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			   33,   33,   33,   33,   33,   33,   33,   33,   33,   33,
			   33,   33,   33,   33,   33,   33,   33,   33,   33,   33,
			   46,   74,   58,   65,   61,   62,   58,   62,   63,   65,
			   46,   58,   63,   58,   61,   46,   75,   62,   58,   58,
			   79,   79,   80,   80,  151,   63,   33,   33,   33,   33,
			   33,   33,   46,   74,   58,   65,   61,   62,   58,   62,
			   63,   65,   46,   58,   63,   58,   61,   46,   75,   62,
			   58,   58,   81,   81,   84,   84,  151,   63,   33,   33,
			   33,   33,   33,   33,   33,   33,   33,   33,   33,   85,
			   85,   33,   33,   34,   34,   34,   34,   96,   96,  106,

			  106,  106,  106,  152, yy_Dummy>>,
			1, 104, 305)
		end

	yy_chk_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  112,  112,  112,  112,   34,  152, yy_Dummy>>,
			1, 6, 435)
		end

	yy_chk_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			   35,   35,   35,   35,   98,   98,  453,   98,   98,   98,
			   98, yy_Dummy>>,
			1, 11, 467)
		end

	yy_chk_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			   99,  115,  115,   99,   35,  342, yy_Dummy>>,
			1, 6, 504)
		end

	yy_chk_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			   60,   64,  118,  118,   60,   67,   71,   60,   64,   64,
			   60,   73,   70,   60,   64,   67,   71,   67,   99,  104,
			   87,   67,   70,   87,   87,   73,   90,   70,  340,   90,
			   90,  334,   60,   64,  123,  123,   60,   67,   71,   60,
			   64,   64,   60,   73,   70,   60,   64,   67,   71,   67,
			   99,  124,  124,   67,   70,  125,  125,   73,  332,   70,
			   89,   89,   92,   89,   89,  326,   92,  323,   92,  317,
			  102,   92,  756,  102,  102,  308,  102,  306,   87,  102,
			  114,  114,  114,  114,   90,  117,  129,  129,  117,  117,
			  117,  117,  120,  120,  120,  120,  137,  137,  104,  104,

			  104,  104,  142,  142,  104,  104,  239,  120,  154,   87,
			  122,  122,  122,  122,  756,   90,  155,  126,   89,  126,
			  126,  126,  126,  130,  130,  130,  102,  135,  135,  135,
			  135,  143,  143,  127,  126,  127,  127,  127,  127,  120,
			  154,  132,  143,  132,  132,  132,  132,  304,  155,   89,
			  156,  136,  298,  136,  136,  236,  236,  239,  102,  103,
			  292,  103,  136,  158,  136,  291,  126,  103,  103,  159,
			  103,  103,  103,  161,  153,  160,  127,  153,  160,  103,
			  103,  103,  156,  103,  132,  139,  139,  139,  139,  141,
			  141,  141,  141,  149,  162,  158,  149,  149,  149,  149, yy_Dummy>>,
			1, 200, 536)
		end

	yy_chk_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  163,  159,  164,  165,  166,  161,  153,  160,  167,  153,
			  160,  103,  290,  103,  103,  103,  168,  238,  238,  238,
			  238,  169,  170,  322,  322,  289,  162,  241,  241,  241,
			  241,  171,  163,  172,  164,  165,  166,  173,  644,  644,
			  167,  645,  645,  645,  103,  103,  103,  103,  168,  103,
			  103,  103,  103,  169,  170,  103,  103,  105,  105,  105,
			  105,  105,  105,  171,  105,  172,  178,  181,  184,  173,
			  105,  105,  174,  105,  105,  105,  174,  176,  179,  182,
			  185,  176,  105,  105,  105,  288,  105,  180,  183,  186,
			  174,  180,  183,  179,  182,  176,  187,  188,  178,  181,

			  184,  189,  191,  195,  174,  198,  200,  287,  174,  176,
			  179,  182,  185,  176,  105,  286,  105,  105,  105,  180,
			  183,  186,  174,  180,  183,  179,  182,  176,  187,  188,
			  199,  324,  324,  189,  191,  195,  202,  198,  200,  201,
			  324,  203,  199,  204,  205,  206,  285,  105,  105,  105,
			  105,  201,  105,  105,  105,  105,  208,  284,  105,  105,
			  109,  283,  199,  109,  109,  109,  109,  209,  202,  649,
			  649,  201,  109,  203,  199,  204,  205,  206,  192,  109,
			  210,  109,  192,  201,  109,  109,  109,  109,  208,  109,
			  282,  109,  212,  192,  213,  109,  192,  109,  217,  209, yy_Dummy>>,
			1, 200, 736)
		end

	yy_chk_template_8 (an_array: ARRAY [INTEGER])
			-- Fill chunk #8 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  109,  109,  109,  109,  109,  109,  131,  131,  131,  131,
			  192,  216,  210,  218,  192,  216,  220,  131,  131,  131,
			  131,  131,  131,  281,  212,  192,  213,  255,  192,  221,
			  217,  255,  222,  255,  280,  279,  255,  261,  261,  261,
			  261,  278,  277,  216,  275,  218,  274,  216,  220,  131,
			  131,  131,  131,  131,  131,  148,  148,  148,  148,  148,
			  148,  221,  148,  148,  222,  148,  148,  148,  148,  148,
			  148,  148,  148,  148,  148,  148,  148,  148,  148,  148,
			  148,  148,  148,  148,  148,  196,  214,  219,  214,  196,
			  223,  219,  224,  225,  228,  229,  214,  230,  231,  214,

			  196,  214,  214,  196,  232,  233,  234,  235,  343,  344,
			  345,  148,  148,  148,  148,  148,  148,  196,  214,  219,
			  214,  196,  223,  219,  224,  225,  228,  229,  214,  230,
			  231,  214,  196,  214,  214,  196,  232,  233,  234,  235,
			  343,  344,  345,  148,  148,  148,  148,  148,  148,  148,
			  148,  148,  148,  148,  226,  346,  148,  148,  215,  226,
			  215,  227,  276,  276,  276,  276,  227,  347,  215,  349,
			  226,  215,  250,  215,  215,  250,  250,  227,  251,  273,
			  254,  251,  251,  254,  254,  256,  226,  346,  256,  256,
			  215,  226,  215,  227,  272,  271,  268,  353,  227,  347, yy_Dummy>>,
			1, 200, 936)
		end

	yy_chk_template_9 (an_array: ARRAY [INTEGER])
			-- Fill chunk #9 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  215,  349,  226,  215,  266,  215,  215,  252,  248,  227,
			  258,  258,  258,  258,  258,  262,  247,  246,  262,  262,
			  245,  262,  314,  314,  262,  244,  258,  258,  354,  353,
			  250,  263,  263,  263,  263,  263,  251,  243,  254,  299,
			  299,  299,  299,  256,  300,  300,  300,  300,  263,  264,
			  264,  264,  264,  264,  305,  305,  305,  305,  242,  300,
			  354,  250,  523,  314,  523,  264,  240,  251,  237,  254,
			  147,  262,  357,  523,  256,  268,  268,  268,  268,  325,
			  325,  268,  268,  307,  307,  307,  307,  301,  146,  301,
			  325,  300,  301,  301,  301,  301,  309,  309,  309,  309,

			  316,  316,  316,  262,  357,  311,  311,  311,  311,  312,
			  358,  312,  144,  140,  312,  312,  312,  312,  138,  313,
			  311,  313,  313,  313,  313,  318,  355,  318,  318,  318,
			  318,  319,  134,  319,  319,  319,  319,  327,  327,  327,
			  327,  316,  358,  355,  264,  264,  264,  264,  335,  335,
			  264,  264,  311,  333,  333,  333,  333,  359,  355,  335,
			  356,  360,  313,  337,  337,  337,  337,  337,  318,  338,
			  338,  338,  338,  338,  319,  355,  361,  356,  362,  337,
			  337,  363,  364,  365,  366,  338,  367,  368,  369,  359,
			  370,  371,  356,  360,  372,  373,  374,  376,  378,  380, yy_Dummy>>,
			1, 200, 1136)
		end

	yy_chk_template_10 (an_array: ARRAY [INTEGER])
			-- Fill chunk #10 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  382,  383,  384,  379,  385,  386,  389,  381,  361,  356,
			  362,  387,  388,  363,  364,  365,  366,  379,  367,  368,
			  369,  381,  370,  371,  387,  388,  372,  373,  374,  376,
			  378,  380,  382,  383,  384,  379,  385,  386,  389,  381,
			  390,  391,  392,  387,  388,  393,  394,  395,  396,  379,
			  397,  398,  399,  381,  400,  401,  387,  388,  402,  403,
			  404,  405,  406,  407,  408,  411,  412,  413,  414,  415,
			  416,  417,  390,  391,  392,  418,  420,  393,  394,  395,
			  396,  421,  397,  398,  399,  422,  400,  401,  419,  423,
			  402,  403,  404,  405,  406,  407,  408,  411,  412,  413,

			  414,  415,  416,  417,  424,  425,  419,  418,  420,  426,
			  427,  428,  429,  421,  430,  431,  432,  422,  433,  434,
			  419,  423,  435,  425,  436,  437,  438,  439,  440,  441,
			  442,  443,  444,  445,  446,  447,  424,  425,  419,  448,
			  449,  426,  427,  428,  429,  450,  430,  431,  432,  128,
			  433,  434,  121,  116,  435,  425,  436,  437,  438,  439,
			  440,  441,  442,  443,  444,  445,  446,  447,  514,  514,
			  113,  448,  449,  454,  454,  454,  454,  450,  470,  470,
			  470,  470,  470,  471,  471,  471,  471,  471,  111,  534,
			  473,  470,  470,  473,  473,  473,  473,  480,  480,  480, yy_Dummy>>,
			1, 200, 1336)
		end

	yy_chk_template_11 (an_array: ARRAY [INTEGER])
			-- Fill chunk #11 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  480,  480,  481,  481,  481,  481,  481,  108,  535,  514,
			  480,  480,  101,  470,  500,  500,  500,  500,   97,   95,
			  470,  534,  536,  470,  470,  471,  515,  515,  515,  500,
			  537,  538,  480,  501,  501,  501,  501,  539,  540,  480,
			  535,   93,  480,  480,  481,  470,  502,  502,  502,  502,
			  509,  509,  509,  509,  536,  500,  511,  511,  511,  511,
			  541,  500,  537,  538,  480,  509,  510,  515,  510,  539,
			  540,  510,  510,  510,  510,  512,  512,  512,  512,  513,
			  542,  513,  513,  513,  513,  518,  543,  518,  518,  518,
			  518,  519,  541,  519,  519,  519,  519,  509,  531,  544,

			  545,  531,  531,  531,  531,  546,  547,  548,  549,  550,
			  551,  552,  542,  553,  554,  555,  556,  557,  543,  558,
			  559,  560,  513,  561,  562,  563,  564,  565,  518,  566,
			  567,  544,  545,  568,  519,  569,  570,  546,  547,  548,
			  549,  550,  551,  552,  571,  553,  554,  555,  556,  557,
			  572,  558,  559,  560,  573,  561,  562,  563,  564,  565,
			  574,  566,  567,  575,  577,  568,  579,  569,  570,  580,
			  581,  582,  583,  584,  585,  586,  571,  587,  588,  589,
			  592,  593,  572,  598,  599,  602,  573,  603,  604,  605,
			  606,  607,  574,  608,  609,  575,  577,  610,  579,  611, yy_Dummy>>,
			1, 200, 1536)
		end

	yy_chk_template_12 (an_array: ARRAY [INTEGER])
			-- Fill chunk #12 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  612,  580,  581,  582,  583,  584,  585,  586,  613,  587,
			  588,  589,  592,  593,  614,  598,  599,  602,  615,  603,
			  604,  605,  606,  607,  616,  608,  609,  617,  618,  610,
			  619,  611,  612,  620,  621,  624,  625,  630,  631,  632,
			  613,  633,  634,  635,  636,  637,  614,  650,  650,  650,
			  615,  647,  647,  647,  647,   83,  616,   82,  662,  617,
			  618,   27,  619,   10,    9,  620,  621,  624,  625,  630,
			  631,  632,    7,  633,  634,  635,  636,  637,  652,  652,
			  652,  652,  653,  653,  653,  653,  654,  654,  654,  654,
			  662,    5,  647,  655,  655,  655,  655,  653,  656,  656,

			  656,  656,  657,  657,  657,  657,  663,  658,  655,  658,
			  658,  658,  658,  668,  669,  670,  671,  672,  659,  652,
			  659,  659,  659,  659,  658,  673,  678,  679,  680,  653,
			  682,  681,  680,  683,  655,  681,  686,  687,  663,  688,
			  655,  689,  690,  691,  692,  668,  669,  670,  671,  672,
			  693,  694,  695,  696,  697,  698,  658,  673,  678,  679,
			  680,  659,  682,  681,  680,  683,  699,  681,  686,  687,
			  702,  688,  703,  689,  690,  691,  692,  704,  705,  706,
			  707,  708,  693,  694,  695,  696,  697,  698,  709,  710,
			  711,  712,  713,  714,  715,  718,  719,  720,  699,  721, yy_Dummy>>,
			1, 200, 1736)
		end

	yy_chk_template_13 (an_array: ARRAY [INTEGER])
			-- Fill chunk #13 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  722,  723,  702,  724,  703,  725,  726,  727,  728,  704,
			  705,  706,  707,  708,  729,  730,  731,  732,  733,  736,
			  709,  710,  711,  712,  713,  714,  715,  718,  719,  720,
			  737,  721,  722,  723,  738,  724,  739,  725,  726,  727,
			  728,  742,  743,  744,  745,  748,  729,  730,  731,  732,
			  733,  736,  749,  750,  750,  750,  751,  751,  751,  751,
			  768,  769,  737,  754,  754,  754,  738,    0,  739,  755,
			  755,  755,  755,  742,  743,  744,  745,  748,  757,  757,
			  757,  757,  757,  758,  749,  758,    0,  770,  758,  758,
			  758,  758,  768,  769,  771,  750,    0,    0,  751,  759,

			  759,  759,  759,    0,    0,  754,  760,  760,  760,  760,
			  772,  755,  773,  775,  759,  761,  761,  761,  761,  770,
			  757,  760,  762,  777,  762,  778,  771,  762,  762,  762,
			  762,  763,  779,  763,  763,  763,  763,  780,  781,  782,
			  783,  788,  772,  789,  773,  775,  759,  792,  763,  793,
			  794,  795,  798,  760,  799,  777,  800,  778,  801,  802,
			  803,  804,  805,  806,  779,  807,  808,  809,  810,  780,
			  781,  782,  783,  788,  811,  789,  812,  813,  814,  792,
			  763,  793,  794,  795,  798,  815,  799,  818,  800,  819,
			  801,  802,  803,  804,  805,  806,  826,  807,  808,  809, yy_Dummy>>,
			1, 200, 1936)
		end

	yy_chk_template_14 (an_array: ARRAY [INTEGER])
			-- Fill chunk #14 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  810,  827,  828,  829,  832,  833,  811,    0,  812,  813,
			  814,  834,  834,  835,  835,  835,    0,  815,  853,  818,
			    0,  819,  838,  838,  840,  840,  840,    0,  826,  844,
			  844,  844,  844,  827,  828,  829,  832,  833,  845,  845,
			  845,  845,  846,  846,  846,  846,  850,  850,  850,  850,
			  853,  854,  834,  847,  835,  847,  855,  846,  847,  847,
			  847,  847,  848,  838,  848,  840,  856,  848,  848,  848,
			  848,  849,  849,  849,  849,  851,  851,  851,  851,  859,
			  860,  863,  864,  854,  865,  852,  849,  852,  855,  846,
			  852,  852,  852,  852,  866,  867,  868,  869,  856,  870,

			  875,  876,  881,  882,  883,  884,  885,  886,  887,  888,
			  889,  859,  860,  863,  864,  890,  865,  893,  849,  894,
			  895,  896,  902,  974,  974,  974,  866,  867,  868,  869,
			    0,  870,  875,  876,  881,  882,  883,  884,  885,  886,
			  887,  888,  889,  903,  903,  903,  903,  890,  902,  893,
			    0,  894,  895,  896,  902,  904,  904,  904,  904,  905,
			  905,  905,  905,  906,  906,  906,  906,  907,  907,  907,
			  907,  908,  913,  908,  914,  919,  908,  908,  908,  908,
			  920,  927,  907,  909,  909,  909,  909,  910,  910,  910,
			  910,  928,  931,  932,  935,  936,  941,  942,  942,  942, yy_Dummy>>,
			1, 200, 2136)
		end

	yy_chk_template_15 (an_array: ARRAY [INTEGER])
			-- Fill chunk #15 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  942,  946,  947,    0,  913,    0,  914,  919,  943,  943,
			  943,  943,  920,  927,  907,  966,  966,  966,  966,  966,
			  966,    0,  941,  928,  931,  932,  935,  936,  941,  975,
			  975,  975,    0,  946,  947,  957,  957,  957,  957,  957,
			  957,  957,  957,  957,  957,  957,  957,  957,  957,  957,
			  957,  957,  957,  957,  958,    0,    0,    0,    0,    0,
			  958,  958,    0,    0,    0,    0,    0,  958,  958,  958,
			  959,    0,  959,  959,  959,  959,  959,  959,  959,  959,
			  959,  959,  959,  959,  959,  959,  959,  959,  959,  960,
			    0,  960,    0,  960,  960,  960,  960,  960,  960,  960,

			  960,  960,  960,  960,  960,  961,    0,  961,  961,  961,
			  961,  961,  961,  961,  961,  961,  961,  961,  961,  961,
			  961,  961,  961,  961,  962,    0,  962,  962,  962,  962,
			  962,  962,  962,  962,  962,  962,  962,  962,  962,  962,
			  962,  962,  962,  963,    0,    0,    0,    0,    0,  963,
			  963,    0,    0,    0,    0,    0,  963,  963,  963,  964,
			    0,  964,  964,  964,  964,  964,  964,  965,    0,  965,
			  965,  965,    0,    0,  965,  965,  965,  965,  965,  965,
			  965,  965,  965,    0,  965,  965,  967,    0,  967,  967,
			  967,  967,  967,  967,  967,  967,  967,  967,  967,  967, yy_Dummy>>,
			1, 200, 2336)
		end

	yy_chk_template_16 (an_array: ARRAY [INTEGER])
			-- Fill chunk #16 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  967,  967,  967,  968,    0,  968,  968,  968,  968,  968,
			  968,  968,  968,  968,  968,  968,  968,  968,  968,  968,
			  968,  968,  969,    0,  969,  969,  969,    0,  969,    0,
			  969,    0,    0,  969,  970,    0,  970,  970,  970,  970,
			  970,  970,  970,  970,  970,  970,  970,  970,  970,  970,
			  970,  970,  970,  971,  971,  971,  971,  971,  971,  972,
			    0,  972,    0,  972,  972,  972,  972,  972,    0,    0,
			    0,    0,  972,  972,  973,    0,  973,  973,  973,    0,
			  973,  973,  973,  973,  973,  973,  973,  973,  973,  973,
			  973,  973,  973, yy_Dummy>>,
			1, 93, 2536)
		end

	yy_base_template: SPECIAL [INTEGER]
			-- Template for `yy_base'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 975)
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
			    0,    0,    0,  104,  111, 1827, 2629, 1807, 2629, 1798,
			 1794,  102,  100,  196, 2629,  107,  111, 2629, 2629,  106,
			  108, 2629,  110,  111,  118,  121,  129, 1770, 2629,  138,
			  141,  144,  113,  294,  378,  447,  155,  131,  174,  164,
			  197,  191,  101,  205,  100,  125,  290,  204,  129,  214,
			  149,  143, 2629,  246, 2629,  150,  166,    0,  294,    0,
			  498,  294,  288,  302,  501,  289,  189,  509,  191,  208,
			  513,  504,  207,  516,  288,  296, 2629, 2629,  279,  328,
			  330,  360, 1776, 1774,  362,  377,    0,  555, 2629,  595,
			  561, 2629,  597, 1576, 2629, 1550,  385, 1537,  454,  497,

			 2629, 1529,  605,  689,  538,  792,  384,  167, 1532,  889,
			    0, 1507,  415, 1489,  596,  488, 1472,  604,  521, 2629,
			  608, 1471,  626,  553,  570,  574,  635,  651, 1467,  602,
			  639,  922,  659, 2629, 1251,  643,  672,  615, 1237,  701,
			 1232,  705,  621,  650, 1231, 2629, 1207, 1189,  990,  712,
			    0,  301,  373,  671,  610,  603,  636,    0,  651,  670,
			  672,  675,  681,  686,  703,  708,  696,  709,  704,  722,
			  727,  723,  734,  725,  776,    0,  781,    0,  753,  780,
			  777,  754,  781,  778,  762,  785,  780,  790,  802,  792,
			    0,  792,  880,    0,    0,  793,  987,    0,  800,  833, yy_Dummy>>,
			1, 200, 0)
		end

	yy_base_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			  801,  842,  822,  827,  830,  846,  848,    0,  843,  869,
			  883,    0,  893,  895,  988, 1060,  905,  891,  901,  981,
			  909,  917,  933,  975,  993,  978, 1056, 1063,  982,  992,
			  985,  995, 1005, 1006,  994,  995,  674, 1187,  733,  631,
			 1185,  743, 1177, 1156, 1144, 1139, 1136, 1135, 1127,    0,
			 1107, 1113, 1136, 2629, 1115,  962, 1120, 2629, 1145, 2629,
			 2629,  953, 1150, 1166, 1184, 2629, 1123, 2629, 1115, 2629,
			 2629, 1120, 1119, 1104,  971,  969, 1078,  967,  966,  960,
			  959,  948,  915,  886,  882,  871,  840,  832,  810,  750,
			  737,  690,  685, 2629, 2629, 2629, 2629, 2629,  671, 1155,

			 1160, 1208, 2629, 2629,  666, 1170,  596, 1199,  594, 1212,
			 2629, 1221, 1230, 1237, 1138,    0, 1216,  544, 1243, 1249,
			 2629, 2629,  742,  586,  850, 1198,  584, 1253, 2629, 2629,
			 2629, 2629,  577, 1269,  550, 1267, 2629, 1298, 1304, 2629,
			  547, 2629,  492,  999, 1000, 1002, 1047, 1072,    0, 1074,
			    0,    0,    0, 1094, 1125, 1231, 1265, 1175, 1213, 1244,
			 1248, 1260, 1262, 1286, 1287, 1271, 1272, 1271, 1288, 1293,
			 1275, 1292, 1299, 1296, 1297,    0, 1282,    0, 1283, 1308,
			 1300, 1312, 1301, 1288, 1289, 1290, 1291, 1304, 1305, 1300,
			 1334, 1342, 1343, 1335, 1351, 1348, 1349, 1340, 1356, 1353, yy_Dummy>>,
			1, 200, 200)
		end

	yy_base_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			 1355, 1360, 1348, 1364, 1350, 1362, 1363, 1354, 1355,    0,
			    0, 1366, 1367, 1370, 1371, 1370, 1371, 1376, 1360, 1391,
			 1364, 1382, 1386, 1394, 1389, 1408, 1397, 1411, 1416, 1413,
			 1419, 1416, 1417, 1415, 1416, 1414, 1416, 1426, 1427, 1428,
			 1417, 1426, 1431, 1420, 1429, 1430, 1431, 1437, 1441, 1432,
			 1437,    0,    0,  456, 1489, 2629, 2629, 2629, 2629, 2629,
			 2629, 2629, 2629, 2629, 2629, 2629, 2629, 2629, 2629,  284,
			 1495, 1500, 2629, 1509, 2629, 2629, 2629, 2629, 2629, 2629,
			 1514, 1519, 2629, 2629, 2629, 2629, 2629, 2629, 2629, 2629,
			 2629, 2629, 2629, 2629, 2629, 2629, 2629, 2629, 2629, 2629,

			 1530, 1549, 1562, 2629, 2629, 2629, 2629, 2629, 2629, 1566,
			 1587, 1572, 1591, 1597, 1484, 1542,  225,  264, 1603, 1609,
			  263,  259,  242, 1183, 2629, 2629, 2629, 2629, 2629, 2629,
			 2629, 1617, 2629,  250, 1476, 1495, 1508, 1516, 1518, 1524,
			 1537, 1559, 1583, 1583, 1602, 1597, 1600, 1601, 1594, 1595,
			 1610, 1611, 1597, 1599, 1615, 1616, 1615, 1616, 1607, 1608,
			 1624, 1626, 1621, 1622, 1614, 1615, 1621, 1618, 1625, 1623,
			 1624, 1632, 1651, 1655, 1645, 1648,    0, 1665,    0, 1667,
			 1666, 1667, 1653, 1654, 1661, 1662, 1676, 1678, 1666, 1667,
			    0,    0, 1674, 1675,    0,    0,    0,    0, 1677, 1678, yy_Dummy>>,
			1, 200, 400)
		end

	yy_base_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			    0,    0, 1670, 1672, 1688, 1689, 1678, 1679, 1686, 1687,
			 1694, 1696, 1685, 1702, 1699, 1712, 1705, 1708, 1731, 1733,
			 1721, 1722,    0,    0, 1725, 1726,    0,    0,    0,    0,
			 1737, 1738, 1724, 1726, 1736, 1737, 1749, 1750,    0,    0,
			    0,    0, 2629, 2629,  754,  757,    0, 1767,  250,  885,
			 1763,    0, 1794, 1798, 1802, 1809, 1814, 1818, 1825, 1836,
			 2629, 2629, 1745, 1793,    0,    0,    0,    0, 1805, 1806,
			 1813, 1814, 1821, 1829,    0,    0,    0,    0, 1814, 1815,
			 1829, 1832, 1822, 1825,    0,    0, 1824, 1825, 1837, 1839,
			 1842, 1843, 1845, 1851, 1853, 1854, 1839, 1840, 1847, 1858,

			    0,    0, 1858, 1860, 1869, 1870, 1880, 1881, 1878, 1885,
			 1886, 1887, 1894, 1895, 1890, 1891,    0,    0, 1896, 1897,
			 1885, 1887, 1897, 1898, 1904, 1906, 1907, 1908, 1896, 1902,
			 1916, 1917, 1903, 1904,    0,    0, 1905, 1916, 1939, 1941,
			    0,    0, 1938, 1939, 1944, 1945,    0,    0, 1937, 1944,
			 1970, 1973,  160, 2629, 1980, 1986,  589, 1995, 2004, 2015,
			 2022, 2031, 2043, 2049,    0,    0,    0,    0, 1961, 1962,
			 1972, 1979, 1996, 1998,    0, 2004,    0, 2014, 2011, 2018,
			 2038, 2039, 2044, 2045,    0,    0,    0,    0, 2042, 2044,
			    0,    0, 2052, 2054, 2051, 2052,    0,    0, 2039, 2041, yy_Dummy>>,
			1, 200, 600)
		end

	yy_base_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			 2048, 2050, 2045, 2046, 2047, 2048, 2068, 2070, 2052, 2053,
			 2055, 2061, 2068, 2069, 2070, 2077,    0,    0, 2088, 2090,
			    0,    0,    0,    0,    0,    0, 2082, 2087, 2094, 2095,
			    0,    0, 2090, 2091, 2127, 2129,  194,  206, 2138,  185,
			 2140,  180,  120,  158, 2145, 2154, 2158, 2174, 2183, 2187,
			 2162, 2191, 2206, 2120, 2153, 2142, 2152,    0,    0, 2171,
			 2172,    0,    0, 2183, 2184, 2188, 2198, 2197, 2198, 2191,
			 2193,    0,    0,    0,    0, 2199, 2200,    0,    0,    0,
			    0, 2194, 2195, 2205, 2206, 2197, 2198, 2209, 2210, 2213,
			 2218,    0,    0, 2218, 2220, 2221, 2222,    0,    0, 2629,

			 2629, 2629, 2223, 2259, 2271, 2275, 2279, 2283, 2292, 2299,
			 2303,    0,    0, 2273, 2275,    0,    0,    0,    0, 2269,
			 2274,    0,    0,    0,    0,    0,    0, 2267, 2277,    0,
			    0, 2280, 2281,    0,    0, 2295, 2296,    0,    0,    0,
			    0, 2297, 2313, 2324,    0,    0, 2302, 2303,    0,    0,
			    0,    0,    0,    0,    0,    0, 2629, 2370, 2387, 2405,
			 2422, 2440, 2459, 2476, 2486, 2502, 2340, 2519, 2538, 2554,
			 2569, 2578, 2592, 2609, 2248, 2354, yy_Dummy>>,
			1, 176, 800)
		end

	yy_def_template: SPECIAL [INTEGER]
			-- Template for `yy_def'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 975)
			yy_def_template_1 (an_array)
			yy_def_template_2 (an_array)
			an_array.area.fill_with (956, 269, 297)
			yy_def_template_3 (an_array)
			an_array.area.fill_with (956, 474, 512)
			yy_def_template_4 (an_array)
			yy_def_template_5 (an_array)
			yy_def_template_6 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_def_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			    0,  956,    1,  957,  957,  956,  956,  956,  956,  956,
			  956,  958,  959,  960,  956,  961,  962,  956,  956,  958,
			  958,  956,  963,  956,  958,  964,  964,  956,  956,  958,
			  958,  958,  956,  956,  956,  956,   35,   35,   35,   35,
			   35,   35,   35,   35,   35,   35,   35,   35,   35,   35,
			   35,   35,  956,  958,  956,  958,  958,  965,  966,  966,
			  966,  966,  966,  966,  966,  966,  966,  966,  966,  966,
			  966,  966,  966,  966,  966,  966,  956,  956,  958,  958,
			  958,  958,  956,  956,  958,  958,  967,  956,  956,  967,
			  956,  956,  968,  956,  956,  956,  958,  963,  958,  959,

			  956,  969,  959,  960,  960,  960,  103,  961,  970,  970,
			  970,  963,   98,  963,   98,  958,  956,   98,  958,  956,
			  956,  963,   98,  958,  958,  958,  956,  964,  964,  971,
			  971,  971,  964,  956,  963,   98,  958,  958,  963,   98,
			  963,   98,  958,  958,  956,  956,   33,  972,  956,   33,
			   35,   35,   35,   35,   35,   35,   35,  966,  966,  966,
			  966,  966,  966,  966,   35,   35,   35,   35,   35,  966,
			  966,  966,  966,  966,   35,   35,  966,  966,   35,   35,
			   35,  966,  966,  966,   35,   35,   35,  966,  966,  966,
			   35,   35,   35,   35,  966,  966,  966,  966,   35,   35, yy_Dummy>>,
			1, 200, 0)
		end

	yy_def_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  966,  966,   35,  966,   35,   35,   35,   35,  966,  966,
			  966,  966,   35,  966,   35,  966,   35,   35,   35,  966,
			  966,  966,   35,   35,  966,  966,   35,  966,   35,   35,
			  966,  966,   35,  966,   35,  966,  958,  963,   98,  965,
			  963,   98,  963,  963,  963,  956,  956,  963,  963,  967,
			  956,  956,  973,  956,  967,  968,  956,  956,  963,  956,
			  956,  956,  959,  105,  960,  956,  103,  956,  960, yy_Dummy>>,
			1, 69, 200)
		end

	yy_def_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  963,   98,  956,  956,  956,  956,  258,   98,  258,   98,
			  258,   98,  956,  956,  956,  964,  971,  971,  971,  131,
			  964,  964,  956,  956,  958,  258,  958,  958,  258,   98,
			  956,  956,  956,  956,  258,   98,  258,  958,  956,  148,
			  972,  956,   33,  956,  972,   35,  966,   35,  966,   35,
			   35,  966,  966,   35,  966,   35,  966,   35,  966,   35,
			  966,   35,  966,   35,  966,   35,  966,   35,  966,   35,
			   35,   35,  966,  966,  966,   35,  966,   35,   35,  966,
			  966,   35,   35,  966,  966,   35,  966,   35,  966,   35,
			  966,   35,  966,   35,   35,   35,   35,  966,  966,  966,

			  966,   35,  966,   35,   35,  966,  966,   35,  966,   35,
			  966,   35,  966,   35,  966,   35,  966,   35,   35,   35,
			   35,   35,   35,  966,  966,  966,  966,  966,  966,   35,
			   35,  966,  966,   35,  966,   35,  966,   35,  966,   35,
			  966,   35,   35,   35,  966,  966,  966,   35,  966,   35,
			  966,   35,  966,   35,  966,  258,   98,  956,  956,  956,
			  956,  956,  956,  956,  956,  956,  956,  956,  956,  956,
			  956,   98,  956,  956,  956,  103, yy_Dummy>>,
			1, 176, 298)
		end

	yy_def_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  964,  971,  971,  131,  956,  964,  964,  258,  956,  136,
			  136,  956,  956,  956,  956,  956,  956,  956,   33,  956,
			  148,   35,  966,   35,  966,   35,  966,   35,  966,   35,
			   35,  966,  966,   35,  966,   35,  966,   35,  966,   35,
			  966,   35,  966,   35,  966,   35,  966,   35,  966,   35,
			  966,   35,  966,   35,   35,  966,  966,   35,  966,   35,
			  966,   35,  966,   35,   35,  966,  966,   35,  966,   35,
			  966,   35,  966,   35,  966,   35,  966,   35,  966,   35,
			  966,   35,  966,   35,  966,   35,  966,   35,  966,   35,
			  966,   35,  966,   35,  966,   35,  966,   35,  966,   35,

			   35,  966,  966,   35,  966,   35,  966,   35,  966,   35,
			  966,   35,  966,   35,  966,   35,  966,   35,  966,   35,
			  966,   35,  966,   35,  966,   35,  966,   35,  966,  956,
			  956,  956,  956,  974,  956,  956,  956,  956,  975,  956,
			  956,  956,  956,  956,  956,  956,  964,  956,  956,   35,
			  966,   35,  966,   35,  966,   35,  966,   35,  966,   35,
			  966,   35,  966,   35,  966,   35,  966,   35,  966,   35,
			  966,   35,  966,   35,  966,   35,  966,   35,  966,   35,
			  966,   35,  966,   35,  966,   35,  966,   35,  966,   35,
			  966,   35,  966,   35,  966,   35,  966,   35,  966,   35, yy_Dummy>>,
			1, 200, 513)
		end

	yy_def_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  966,   35,  966,   35,  966,   35,  966,   35,  966,   35,
			  966,   35,  966,   35,  966,   35,  966,   35,  966,   35,
			  966,   35,  966,   35,  966,   35,  966,   35,  966,   35,
			  966,   35,  966,   35,  966,   35,  966,  956,  956,  974,
			  956,  956,  956,  975,  956,  956,  956,  956,  956,  956,
			  956,   35,  966,   35,  966,   35,  966,   35,  966,   35,
			  966,   35,   35,  966,  966,   35,  966,   35,  966,   35,
			  966,   35,  966,   35,  966,   35,  966,   35,  966,   35,
			  966,   35,  966,   35,  966,   35,  966,   35,  966,   35,
			  966,   35,  966,   35,  966,   35,  966,   35,  966,   35,

			  966,   35,  966,   35,  966,   35,  966,   35,  966,   35,
			  966,   35,  966,   35,  966,   35,  966,   35,  966,   35,
			  966,  956,  956,  974,  956,  956,  956,  956,  956,  975,
			  956,  956,  956,  956,  956,  956,  956,  956,  956,  956,
			   35,  966,   35,  966,   35,  966,   35,  966,   35,  966,
			   35,  966,   35,  966,   35,  966,   35,  966,   35,  966,
			   35,  966,   35,  966,   35,  966,   35,  966,   35,  966,
			   35,  966,   35,  966,   35,  966,   35,  966,   35,  966,
			   35,  966,   35,  966,   35,  966,  956,  956,  956,  956,
			  956,  956,  956,  956,  956,  956,  956,  956,   35,  966, yy_Dummy>>,
			1, 200, 713)
		end

	yy_def_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			   35,  966,   35,  966,   35,  966,   35,  966,   35,  966,
			   35,  966,   35,  966,   35,  966,   35,  966,   35,  966,
			   35,  966,   35,  966,   35,  966,   35,  966,  956,  956,
			  956,   35,  966,   35,  966,   35,  966,   35,  966,   35,
			  966,   35,  966,    0,  956,  956,  956,  956,  956,  956,
			  956,  956,  956,  956,  956,  956,  956,  956,  956,  956,
			  956,  956,  956, yy_Dummy>>,
			1, 63, 913)
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
			    0,    1,    2,   19,   19,    1,    3,    4,    3,    5,
			    6,    7,    8,    8,    3,    3,    5,    3,    9,   10,
			   11,   11,   11,   11,    5,    5,   10,    3,   10,    5,
			    3,   12,   12,   12,   12,   13,   12,   14,   15,   14,
			   14,   14,   15,   14,   15,   14,   14,   15,   15,   15,
			   15,   15,   15,   14,   14,   14,   14,    5,    3,    5,
			    3,   16,   17,   13,   13,   13,   13,   13,   13,   14,
			   14,   14,   14,   14,   14,   14,   14,   14,   14,   14,
			   14,   14,   14,   14,   14,   14,   14,   14,   14,    5,
			    5,    3,    3,    3,    3,    5,   18,   18,   18,   18,

			   19,   19,   18,   18,   19, yy_Dummy>>)
		end

	yy_accept_template: SPECIAL [INTEGER]
			-- Template for `yy_accept'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 957)
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
			   14,   17,   21,   23,   27,   30,   32,   35,   38,   41,
			   45,   49,   52,   55,   58,   62,   65,   68,   71,   74,
			   78,   82,   86,   89,   94,   98,  102,  106,  110,  114,
			  118,  122,  126,  130,  134,  138,  142,  146,  150,  154,
			  158,  162,  166,  169,  172,  175,  179,  182,  184,  187,
			  190,  193,  196,  199,  202,  205,  208,  211,  214,  217,
			  220,  223,  226,  229,  232,  235,  238,  241,  244,  248,
			  252,  256,  260,  263,  266,  270,  274,  276,  278,  280,
			  283,  285,  287,  289,  290,  291,  292,  293,  293,  294,

			  294,  295,  296,  298,  300,  301,  302,  304,  304,  305,
			  306,  307,  307,  308,  308,  309,  310,  311,  312,  314,
			  315,  316,  316,  317,  319,  321,  323,  324,  326,  327,
			  328,  329,  330,  331,  332,  332,  333,  335,  337,  337,
			  338,  338,  339,  341,  343,  343,  344,  346,  347,  348,
			  350,  352,  354,  356,  358,  360,  363,  365,  366,  367,
			  368,  369,  370,  372,  373,  375,  377,  379,  381,  383,
			  384,  385,  386,  387,  388,  390,  393,  394,  396,  398,
			  400,  402,  403,  404,  405,  407,  409,  411,  412,  413,
			  414,  417,  419,  421,  424,  426,  427,  428,  430,  432, yy_Dummy>>,
			1, 200, 0)
		end

	yy_accept_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			  434,  435,  436,  438,  439,  441,  443,  445,  448,  449,
			  450,  451,  453,  455,  456,  458,  459,  461,  463,  465,
			  466,  467,  468,  470,  472,  473,  474,  476,  477,  479,
			  481,  482,  483,  485,  486,  488,  489,  491,  491,  492,
			  492,  492,  493,  493,  493,  493,  493,  493,  493,  493,
			  494,  495,  495,  495,  496,  497,  498,  499,  500,  501,
			  502,  503,  503,  504,  506,  507,  508,  510,  512,  514,
			  515,  517,  518,  519,  520,  521,  522,  523,  524,  525,
			  526,  527,  528,  529,  530,  531,  532,  533,  534,  535,
			  536,  537,  538,  539,  541,  543,  545,  547,  548,  548,

			  549,  550,  550,  552,  554,  555,  556,  557,  558,  559,
			  560,  561,  562,  562,  564,  567,  569,  572,  575,  577,
			  578,  580,  582,  584,  586,  587,  588,  589,  590,  592,
			  594,  596,  598,  599,  600,  601,  602,  603,  605,  606,
			  607,  609,  612,  614,  616,  617,  619,  620,  622,  625,
			  626,  628,  631,  633,  635,  636,  638,  639,  641,  642,
			  644,  645,  647,  648,  650,  651,  653,  654,  656,  658,
			  660,  661,  662,  663,  665,  666,  669,  671,  673,  674,
			  676,  678,  679,  680,  682,  683,  685,  686,  688,  689,
			  691,  692,  694,  696,  698,  700,  701,  702,  703,  704, yy_Dummy>>,
			1, 200, 200)
		end

	yy_accept_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			  706,  707,  709,  711,  712,  713,  716,  718,  720,  721,
			  724,  726,  728,  729,  731,  732,  734,  736,  738,  740,
			  742,  744,  745,  746,  747,  748,  749,  750,  752,  754,
			  755,  756,  758,  759,  761,  762,  764,  765,  767,  768,
			  770,  772,  774,  775,  776,  777,  779,  780,  782,  783,
			  785,  786,  789,  791,  792,  793,  795,  797,  798,  799,
			  801,  803,  805,  807,  809,  810,  811,  813,  815,  816,
			  817,  817,  817,  819,  821,  822,  823,  824,  825,  826,
			  827,  828,  829,  830,  831,  832,  833,  834,  835,  836,
			  837,  838,  839,  840,  841,  842,  843,  844,  845,  847,

			  849,  850,  850,  851,  853,  855,  857,  859,  861,  863,
			  864,  864,  864,  865,  867,  869,  871,  873,  873,  875,
			  877,  878,  880,  882,  884,  886,  888,  890,  892,  894,
			  896,  898,  900,  901,  902,  904,  905,  907,  908,  910,
			  911,  913,  914,  916,  918,  919,  920,  922,  923,  925,
			  926,  928,  929,  931,  932,  934,  935,  937,  938,  940,
			  941,  943,  944,  947,  949,  951,  952,  954,  956,  957,
			  958,  960,  961,  963,  964,  966,  967,  970,  972,  974,
			  975,  977,  978,  980,  981,  983,  984,  986,  987,  989,
			  990,  993,  995,  997,  998, 1001, 1003, 1006, 1008, 1010, yy_Dummy>>,
			1, 200, 400)
		end

	yy_accept_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			 1011, 1014, 1016, 1018, 1019, 1021, 1022, 1024, 1025, 1027,
			 1028, 1030, 1031, 1033, 1035, 1036, 1037, 1039, 1040, 1042,
			 1043, 1045, 1046, 1049, 1051, 1053, 1054, 1057, 1059, 1062,
			 1064, 1066, 1067, 1069, 1070, 1072, 1073, 1075, 1076, 1079,
			 1081, 1084, 1086, 1088, 1090, 1090, 1090, 1090, 1090, 1091,
			 1091, 1091, 1091, 1091, 1092, 1092, 1093, 1093, 1094, 1095,
			 1097, 1099, 1100, 1102, 1103, 1106, 1108, 1111, 1113, 1115,
			 1116, 1118, 1119, 1121, 1122, 1125, 1127, 1130, 1132, 1134,
			 1135, 1137, 1138, 1140, 1141, 1144, 1146, 1148, 1149, 1151,
			 1152, 1154, 1155, 1157, 1158, 1160, 1161, 1163, 1164, 1166,

			 1167, 1170, 1172, 1174, 1175, 1177, 1178, 1180, 1181, 1183,
			 1184, 1186, 1187, 1189, 1190, 1192, 1193, 1196, 1198, 1200,
			 1201, 1203, 1204, 1206, 1207, 1209, 1210, 1212, 1213, 1215,
			 1216, 1218, 1219, 1221, 1222, 1225, 1227, 1229, 1230, 1232,
			 1233, 1236, 1238, 1240, 1241, 1243, 1244, 1247, 1249, 1251,
			 1252, 1252, 1252, 1252, 1253, 1253, 1253, 1253, 1253, 1253,
			 1254, 1255, 1255, 1255, 1256, 1259, 1261, 1264, 1266, 1268,
			 1269, 1271, 1272, 1274, 1275, 1278, 1280, 1282, 1283, 1285,
			 1286, 1288, 1289, 1291, 1292, 1295, 1297, 1300, 1302, 1304,
			 1305, 1308, 1310, 1312, 1313, 1315, 1316, 1319, 1321, 1323, yy_Dummy>>,
			1, 200, 600)
		end

	yy_accept_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			 1324, 1326, 1327, 1329, 1330, 1332, 1333, 1335, 1336, 1338,
			 1339, 1341, 1342, 1344, 1345, 1347, 1348, 1351, 1353, 1355,
			 1356, 1359, 1361, 1364, 1366, 1369, 1371, 1373, 1374, 1376,
			 1377, 1380, 1382, 1384, 1385, 1385, 1385, 1385, 1385, 1385,
			 1385, 1385, 1385, 1385, 1385, 1385, 1386, 1387, 1387, 1387,
			 1388, 1388, 1389, 1389, 1391, 1392, 1394, 1395, 1398, 1400,
			 1402, 1403, 1406, 1408, 1410, 1411, 1413, 1414, 1416, 1417,
			 1419, 1420, 1423, 1425, 1428, 1430, 1432, 1433, 1436, 1438,
			 1441, 1443, 1445, 1446, 1448, 1449, 1451, 1452, 1454, 1455,
			 1457, 1458, 1461, 1463, 1465, 1466, 1468, 1469, 1472, 1474,

			 1475, 1476, 1477, 1478, 1478, 1479, 1479, 1480, 1481, 1481,
			 1481, 1482, 1485, 1487, 1489, 1490, 1493, 1495, 1498, 1500,
			 1502, 1503, 1506, 1508, 1511, 1513, 1516, 1518, 1520, 1521,
			 1524, 1526, 1528, 1529, 1532, 1534, 1536, 1537, 1540, 1542,
			 1545, 1547, 1548, 1548, 1549, 1552, 1554, 1556, 1557, 1560,
			 1562, 1565, 1567, 1570, 1572, 1575, 1577, 1577, yy_Dummy>>,
			1, 158, 800)
		end

	yy_acclist_template: SPECIAL [INTEGER]
			-- Template for `yy_acclist'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 1576)
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
			    0,  164,  164,  178,  176,  177,    2,  176,  177,    4,
			  177,    5,  176,  177,    1,  176,  177,   11,  118,  176,
			  177,  176,  177,  118,  125,  176,  177,   18,  176,  177,
			  176,  177,  154,  176,  177,   12,  176,  177,   13,  176,
			  177,   34,  118,  176,  177,   33,  118,  176,  177,    9,
			  176,  177,   32,  176,  177,    7,  176,  177,   35,  118,
			  176,  177,  166,  176,  177,  166,  176,  177,   10,  176,
			  177,    8,  176,  177,   39,  118,  176,  177,   37,  118,
			  176,  177,   38,  118,  176,  177,   19,  176,  177,   41,
			  118,  122,  176,  177,  116,  117,  176,  177,  116,  117,

			  176,  177,  116,  117,  176,  177,  116,  117,  176,  177,
			  116,  117,  176,  177,  116,  117,  176,  177,  116,  117,
			  176,  177,  116,  117,  176,  177,  116,  117,  176,  177,
			  116,  117,  176,  177,  116,  117,  176,  177,  116,  117,
			  176,  177,  116,  117,  176,  177,  116,  117,  176,  177,
			  116,  117,  176,  177,  116,  117,  176,  177,  116,  117,
			  176,  177,  116,  117,  176,  177,   16,  176,  177,  118,
			  176,  177,   17,  176,  177,   36,  118,  176,  177,  118,
			  176,  177,  176,  177,  117,  176,  177,  117,  176,  177,
			  117,  176,  177,  117,  176,  177,  117,  176,  177,  117, yy_Dummy>>,
			1, 200, 0)
		end

	yy_acclist_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  176,  177,  117,  176,  177,  117,  176,  177,  117,  176,
			  177,  117,  176,  177,  117,  176,  177,  117,  176,  177,
			  117,  176,  177,  117,  176,  177,  117,  176,  177,  117,
			  176,  177,  117,  176,  177,  117,  176,  177,   14,  176,
			  177,   15,  176,  177,   40,  118,  176,  177,   44,  118,
			  176,  177,   42,  118,  176,  177,   43,  118,  176,  177,
			   47,  176,  177,   48,  176,  177,   46,  118,  176,  177,
			   45,  118,  176,  177,  164,  177,  159,  177,  161,  177,
			  162,  164,  177,  158,  177,  163,  177,  164,  177,    2,
			    3,    1,  118,  118,  165,  165, -156, -333,  118,  125,

			  125,  125,  118,  125,  154,  154,  154,  118,  118,  118,
			    6,  118,   26,  118,   27,  173,  118,   20,  118,   22,
			  118,   23,  118,  173,  166,  172,  172,  172,  172,  172,
			  172,   31,  118,   28,  118,   25,  118,  118,  118,   24,
			  118,   29,  118,   30,  118,  122,  122,  122,  118,  122,
			  116,  117,  116,  117,  116,  117,  116,  117,  116,  117,
			   53,  116,  117,  116,  117,  117,  117,  117,  117,  117,
			   53,  117,  117,  116,  117,  116,  117,  116,  117,  116,
			  117,  116,  117,  117,  117,  117,  117,  117,  116,  117,
			   63,  116,  117,  117,   63,  117,  116,  117,  116,  117, yy_Dummy>>,
			1, 200, 200)
		end

	yy_acclist_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  116,  117,  117,  117,  117,  116,  117,  116,  117,  116,
			  117,  117,  117,  117,   75,  116,  117,  116,  117,  116,
			  117,   80,  116,  117,   75,  117,  117,  117,   80,  117,
			  116,  117,  116,  117,  117,  117,  116,  117,  117,  116,
			  117,  116,  117,  116,  117,   88,  116,  117,  117,  117,
			  117,   88,  117,  116,  117,  117,  116,  117,  117,  116,
			  117,  116,  117,  116,  117,  117,  117,  117,  116,  117,
			  116,  117,  117,  117,  116,  117,  117,  116,  117,  116,
			  117,  117,  117,  116,  117,  117,  116,  117,  117,   21,
			  118,  118,  118,  164,  159,  160,  164,  164,  158,  157,

			  118,  121,  119, -156,  118,  125,  125,  126,  118,  125,
			  121,  127,  119,  125,  154,  128,  154,  154,  154,  154,
			  154,  154,  154,  154,  154,  154,  154,  154,  154,  154,
			  154,  154,  154,  154,  154,  154,  154,  154,  154,   34,
			  121,   34,  119,   33,  121,   33,  119,   32,  118,  173,
			   35,  121,   35,  119,  118,  118,  118,  118,  118,  118,
			  167,  173,  166,  172,  170,  171,  172,  171,  172,  169,
			  171,  172,  168,  171,  172,  166,  172,  172,   39,  121,
			   39,  119,   28,  118,   28,  118,  118,  118,  118,  118,
			   37,  121,   37,  119,   38,  121,   38,  119,  118,  118, yy_Dummy>>,
			1, 200, 400)
		end

	yy_acclist_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  118,  118,   19,  118,  122,  122,  123,  118,  122,   41,
			  121,  124,  119,  122,  116,  117,  117,  116,  117,  117,
			  116,  117,   51,  116,  117,  117,   51,  117,   52,  116,
			  117,   52,  117,  116,  117,  117,  116,  117,  117,  116,
			  117,  117,  116,  117,  117,  116,  117,  117,  116,  117,
			  117,  116,  117,  117,  116,  117,  116,  117,  116,  117,
			  117,  117,  117,  116,  117,  117,   66,  116,  117,  116,
			  117,   66,  117,  117,  116,  117,  116,  117,  117,  117,
			  116,  117,  117,  116,  117,  117,  116,  117,  117,  116,
			  117,  117,  116,  117,  116,  117,  116,  117,  116,  117,

			  117,  117,  117,  117,  116,  117,  117,  116,  117,  116,
			  117,  117,  117,   84,  116,  117,   84,  117,  116,  117,
			  117,   86,  116,  117,   86,  117,  116,  117,  117,  116,
			  117,  117,  116,  117,  116,  117,  116,  117,  116,  117,
			  116,  117,  116,  117,  117,  117,  117,  117,  117,  117,
			  116,  117,  116,  117,  117,  117,  116,  117,  117,  116,
			  117,  117,  116,  117,  117,  116,  117,  117,  116,  117,
			  116,  117,  116,  117,  117,  117,  117,  116,  117,  117,
			  116,  117,  117,  116,  117,  117,  108,  116,  117,  108,
			  117,  118,  118,   36,  121,   36,  119,  175,  174,   40, yy_Dummy>>,
			1, 200, 600)
		end

	yy_acclist_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  121,   40,  119,   44,  121,   42,  121,   43,  121,   47,
			   48,   46,  121,   45,  121,  120,  118,  120,  126,  118,
			  125,  127,  145,  143,  144,  146,  147,  155,  155,  148,
			  149,  129,  130,  131,  132,  133,  134,  135,  136,  137,
			  138,  139,  140,  141,  142,   26,  121,   26,  119,  173,
			  173,   20,  121,   20,  119,   22,  121,   22,  119,   23,
			  121,   23,  119,  173,  173,  166,  172,  171,  172,  171,
			  172,  171,  172,  166,  172,  166,  172,  118,   28,  121,
			   28,  118,   28,  118,   25,  121,   25,  119,   24,  121,
			   24,  119,   29,  121,  120,  123,  121,  124,  118,  122,

			  124,  122,  116,  117,  117,  116,  117,  117,  116,  117,
			  117,  116,  117,  117,  116,  117,  116,  117,  117,  117,
			  116,  117,  117,  116,  117,  117,  116,  117,  117,  116,
			  117,  117,  116,  117,  117,  116,  117,  117,  116,  117,
			  117,  116,  117,  117,   64,  116,  117,   64,  117,  116,
			  117,  117,  116,  117,  116,  117,  117,  117,  116,  117,
			  117,  116,  117,  117,  116,  117,  117,   73,  116,  117,
			  116,  117,   73,  117,  117,  116,  117,  117,  116,  117,
			  117,  116,  117,  117,  116,  117,  117,  116,  117,  117,
			   81,  116,  117,   81,  117,  116,  117,  117,   83,  116, yy_Dummy>>,
			1, 200, 800)
		end

	yy_acclist_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  117,   83,  117,  113,  116,  117,  113,  117,  116,  117,
			  117,   87,  116,  117,   87,  117,  116,  117,  117,  116,
			  117,  117,  116,  117,  117,  116,  117,  117,  116,  117,
			  117,  116,  117,  116,  117,  117,  117,  116,  117,  117,
			  116,  117,  117,  116,  117,  117,  114,  116,  117,  114,
			  117,  116,  117,  117,  100,  116,  117,  100,  117,  101,
			  116,  117,  101,  117,  116,  117,  117,  116,  117,  117,
			  116,  117,  117,  116,  117,  117,  106,  116,  117,  106,
			  117,  107,  116,  117,  107,  117,   21,  121,   21,  119,
			  155,  173,  173,  173,  173,  166,  172,   28,  121,   28,

			  116,  117,  117,   49,  116,  117,   49,  117,   50,  116,
			  117,   50,  117,  116,  117,  117,  116,  117,  117,  116,
			  117,  117,   55,  116,  117,   55,  117,   56,  116,  117,
			   56,  117,  116,  117,  117,  116,  117,  117,  116,  117,
			  117,   61,  116,  117,   61,  117,  116,  117,  117,  116,
			  117,  117,  116,  117,  117,  116,  117,  117,  116,  117,
			  117,  116,  117,  117,  116,  117,  117,   71,  116,  117,
			   71,  117,  116,  117,  117,  116,  117,  117,  116,  117,
			  117,  116,  117,  117,  116,  117,  117,  116,  117,  117,
			  116,  117,  117,   82,  116,  117,   82,  117,  116,  117, yy_Dummy>>,
			1, 200, 1000)
		end

	yy_acclist_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  117,  116,  117,  117,  116,  117,  117,  116,  117,  117,
			  116,  117,  117,  116,  117,  117,  116,  117,  117,  116,
			  117,  117,   96,  116,  117,   96,  117,  116,  117,  117,
			  116,  117,  117,   99,  116,  117,   99,  117,  116,  117,
			  117,  116,  117,  117,  104,  116,  117,  104,  117,  116,
			  117,  117,  150,  173,  173,  173,  109,  116,  117,  109,
			  117,   54,  116,  117,   54,  117,  116,  117,  117,  116,
			  117,  117,  116,  117,  117,   58,  116,  117,  116,  117,
			   58,  117,  117,  116,  117,  117,  116,  117,  117,  116,
			  117,  117,   65,  116,  117,   65,  117,   67,  116,  117,

			   67,  117,  116,  117,  117,   69,  116,  117,   69,  117,
			  116,  117,  117,  116,  117,  117,   74,  116,  117,   74,
			  117,  116,  117,  117,  116,  117,  117,  116,  117,  117,
			  116,  117,  117,  116,  117,  117,  116,  117,  117,  116,
			  117,  117,  116,  117,  117,  116,  117,  117,   92,  116,
			  117,   92,  117,  116,  117,  117,   94,  116,  117,   94,
			  117,   95,  116,  117,   95,  117,   97,  116,  117,   97,
			  117,  116,  117,  117,  116,  117,  117,  103,  116,  117,
			  103,  117,  116,  117,  117,  173,  173,  173,  173,  116,
			  117,  117,  116,  117,  117,   57,  116,  117,   57,  117, yy_Dummy>>,
			1, 200, 1200)
		end

	yy_acclist_template_8 (an_array: ARRAY [INTEGER])
			-- Fill chunk #8 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  116,  117,  117,   60,  116,  117,   60,  117,  116,  117,
			  117,  116,  117,  117,  116,  117,  117,  116,  117,  117,
			   72,  116,  117,   72,  117,   76,  116,  117,   76,  117,
			  116,  117,  117,   77,  116,  117,   77,  117,   78,  116,
			  117,   78,  117,  116,  117,  117,  116,  117,  117,  116,
			  117,  117,  116,  117,  117,  116,  117,  117,   93,  116,
			  117,   93,  117,  116,  117,  117,  116,  117,  117,  105,
			  116,  117,  105,  117,  153,  152,  151,  173,  173,  173,
			  173,  173,  110,  116,  117,  110,  117,  116,  117,  117,
			   59,  116,  117,   59,  117,   62,  116,  117,   62,  117,

			  116,  117,  117,   68,  116,  117,   68,  117,   70,  116,
			  117,   70,  117,  115,  116,  117,  115,  117,  116,  117,
			  117,   85,  116,  117,   85,  117,  116,  117,  117,   91,
			  116,  117,   91,  117,  116,  117,  117,   98,  116,  117,
			   98,  117,  102,  116,  117,  102,  117,  173,  173,  111,
			  116,  117,  111,  117,  116,  117,  117,   79,  116,  117,
			   79,  117,   89,  116,  117,   89,  117,   90,  116,  117,
			   90,  117,  112,  116,  117,  112,  117, yy_Dummy>>,
			1, 177, 1400)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER = 2629
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER = 956
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER = 957
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

	yyNb_rules: INTEGER = 177
			-- Number of rules

	yyEnd_of_buffer: INTEGER = 178
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
