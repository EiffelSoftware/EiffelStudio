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
			create an_array.make_filled (0, 0, 2651)
			yy_nxt_template_1 (an_array)
			yy_nxt_template_2 (an_array)
			yy_nxt_template_3 (an_array)
			an_array.area.fill_with (147, 478, 503)
			yy_nxt_template_4 (an_array)
			an_array.area.fill_with (154, 510, 535)
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
			an_array.area.fill_with (945, 2548, 2651)
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
			  145,  127,  127,  127,  127,  124,  199,  126,  209,  127,
			  127,  127,  127,  129,  130,  134,  135,  102,  138,  139,
			  211,  140,  141,   92,  136,  137,  171,  234,  235,  742,
			   92,  142,  143,  223,  100,  131,  172,  101,  200,  107,
			  210,  831,  132,   97,   98,  129,  130,  229,  231,  102,
			  132,  890,  212,  161,   92,  181,  889,  162,  173,  182, yy_Dummy>>,
			1, 200, 0)
		end

	yy_nxt_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  163,   92,  103,  164,  103,  224,  165,  131,  174,  125,
			  103,  103,  183,  105,  106,  103,  175,  888,  176,  230,
			  232,  825,  103,  103,  103,  166,  103,  184,  177,  167,
			  195,  185,  168,  187,  200,  169,  196,  201,  170,  210,
			  188,  189,  219,  212,  186,  225,  190,  202,  178,  203,
			  179,  224,  220,  204,  103,  830,  103,  103,  103,  226,
			  180,  825,  197,   97,   98,  191,  200,  742,  198,  205,
			   96,  210,  192,  193,  221,  212,  650,  227,  194,  206,
			  649,  207,  307,  224,  222,  208,  213,  103,  103,  103,
			  103,  228,   96,   96,   96,   96,  214,  831,   96,   96,

			  103,  215,  103,  230,  233,  173,  232,  510,  103,  103,
			   97,  146,  106,  103,  178,  174,  179,  631,  216,  522,
			  103,  103,  103,  520,  103,  155,  180,  184,  217,  156,
			  335,  185,  191,  218,  157,  230,  158,  173,  232,  192,
			  193,  159,  160,  197,  186,  194,  178,  174,  179,  198,
			  237,  238,  103,  518,  103,  103,  103,  155,  180,  184,
			  515,  156,  336,  185,  191,  510,  157,  501,  158,  239,
			   98,  192,  193,  159,  160,  197,  186,  194,  240,   98,
			  499,  198,  241,   98,  497,  103,  103,  103,  103,  492,
			   96,   96,   96,   96,  244,   98,   96,   96,  147,  147, yy_Dummy>>,
			1, 200, 200)
		end

	yy_nxt_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  147,  147,  245,   98,  255,   98,   97,   98,  337,  147,
			  147,  148,  147,  147,  147,  149,  147,  147,  147,  147,
			  150,  147,  151,  147,  147,  147,  147,  152,  153,  147,
			  147,  147,  147,  147,  147,  291,  291,  291,  291,  147,
			  338,  154,  154,  155,  154,  154,  154,  156,  154,  154,
			  154,  154,  157,  154,  158,  154,  154,  154,  154,  159,
			  160,  154,  154,  154,  154,  154,  154,  147,  147,  147,
			  147,  255,   98,  491,  257,  257,  257,  257, yy_Dummy>>,
			1, 78, 400)
		end

	yy_nxt_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  295,  296,  100,  490,  147,  101, yy_Dummy>>,
			1, 6, 504)
		end

	yy_nxt_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  166,  216,  205,  227,  167,  221,  261,  168,  301,  302,
			  169,  217,  206,  170,  207,  222,  218,  228,  208,  247,
			  102,  489,  248,  248,  248,  250,  248,  251,  248,  248,
			  253,  343,  166,  216,  205,  227,  167,  221,  449,  168,
			  303,  304,  169,  217,  206,  170,  207,  222,  218,  228,
			  208,  249,  102,  305,  306,  249,  488,  254,  259,  487,
			  246,  259,  259,  344,  100,  260,  486,  101,  265,  265,
			  265,  265,  293,  293,  293,  293,  485,  249,  300,  300,
			  300,  300,  252,  484,  249,  945,  945,  945,  945,  450,
			   97,  945,  945,  294,  294,  294,  294,  297,  297,  297,

			  297,  307,  483,  308,  308,  308,  308,  345,  249,  311,
			  311,  482,  298,  252,  102,  249,  323,  324,  309,  126,
			  347,  310,  310,  310,  310,  313,  313,  313,  481,  945,
			  480,  315,  315,  315,  315,  318,  318,  318,  318,  346,
			  319,  479,  320,   98,  298,  478,  102,  262,  477,  262,
			  309,  321,  348,  322,  339,  262,  262,  340,  264,  262,
			  262,  336,  132,  326,  326,  326,  326,  262,  262,  262,
			  476,  262,  316,  328,  328,  328,  328,  329,  330,  331,
			   98,  338,  341,  344,  346,  342,  341,  348,  349,  342,
			  332,  351,  353,  336,  355,  357,  350,  352,  354,  262, yy_Dummy>>,
			1, 200, 536)
		end

	yy_nxt_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  473,  262,  262,  262,  356,  445,  446,  514,   98,  358,
			  365,  739,  739,  338,  341,  344,  346,  342,  472,  348,
			  350,  366,  375,  352,  354,  471,  356,  358,  350,  352,
			  354,  470,  262,  262,  262,  262,  356,  115,  115,  115,
			  115,  358,  366,  115,  115,  268,  377,  469,  269,  270,
			  271,  272,  379,  366,  376,  743,  743,  273,  448,  448,
			  448,  448,  105,  359,  274,  254,  275,  360,  459,  276,
			  277,  278,  279,  458,  280,  457,  281,  456,  378,  362,
			  282,  361,  283,  363,  380,  284,  285,  286,  287,  288,
			  289,  314,  314,  314,  314,  362,  371,  364,  376,  363,

			  372,  378,  314,  314,  314,  314,  314,  314,   96,  367,
			  514,  362,  369,  364,  373,  363,  741,  741,  374,   96,
			  745,  745,  380,  381,  368,  382,  391,  370,  373,  364,
			  376,  393,  374,  378,  314,  314,  314,  314,  314,  314,
			  262,  369,  262,  394,  369,  392,  373,  455,  262,  262,
			  374,  334,  262,  262,  380,  382,  370,  382,  392,  370,
			  262,  262,  262,  395,  262,  383,  387,  395,  397,  384,
			  388,  398,  399,  401,  403,  396,  400,  392,  402,  396,
			  385,  389,  404,  386,  390,  405,  406,  419,  423,  425,
			  424,  420,  262,  454,  262,  262,  262,  387,  387,  395, yy_Dummy>>,
			1, 200, 736)
		end

	yy_nxt_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  398,  388,  388,  398,  400,  402,  404,  453,  400,  426,
			  402,  396,  389,  389,  404,  390,  390,  406,  406,  421,
			  424,  426,  424,  422,  427,  262,  262,  262,  262,  429,
			  115,  115,  115,  115,  428,  421,  115,  115,  407,  422,
			  408,  426,  413,  430,  414,  451,  437,  447,  409,  439,
			  333,  410,  415,  411,  412,  416,  428,  417,  418,  438,
			  440,  430,  441,  431,  442,  443,  428,  421,  432,  444,
			  413,  422,  414,  327,  413,  430,  414,  434,  438,  433,
			  415,  440,  435,  416,  415,  417,  418,  416,  325,  417,
			  418,  438,  440,  436,  442,  434,  442,  444,  255,   98,

			  435,  444,  452,  452,  452,  452,  468,  516,  317,  434,
			  945,  436,  247,  299,  435,  248,  248,  248,  261,  248,
			  248,  248,  251,  248,  249,  436,  294,  292,  249,  290,
			  254,  248,  267,  246,  248,  253,  460,  460,  460,  460,
			  460,  462,  463,  463,  463,  464,  464,  464,  464,  464,
			  260,  259,  256,  461,  259,  259,  258,  100,  255,   98,
			  101,  264,  465,  466,  466,  466,  466,  466,  256,  517,
			  249,  474,  475,  475,  475,  249,   95,  252,   93,  467,
			  493,  493,  493,  493,  243,  945,  945,  945,  945,  249,
			  523,  945,  945,  498,  498,  498,  498,  945,  945,  945, yy_Dummy>>,
			1, 200, 936)
		end

	yy_nxt_template_8 (an_array: ARRAY [INTEGER])
			-- Fill chunk #8 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  945,  249,  242,  945,  945,  133,  249,  102,  252,  494,
			  494,  494,  494,  500,  500,  500,  500,  740,  740,  740,
			  249,  495,  524,  495,  298,  524,  496,  496,  496,  496,
			  502,  502,  502,  502,  503,  503,  503,  503,  505,  102,
			  505,  311,  311,  506,  506,  506,  506,   95,  126,  504,
			  507,  507,  507,  507,   94,   93,  298,  524,  945,  945,
			  945,  945,  525,  526,  945,  945,  313,  313,  313,  511,
			  527,  512,  512,  512,  512,  945,  528,  513,  513,  513,
			  513,  504,  508,  519,  519,  519,  519,  521,  521,  521,
			  521,  132,  255,   98,  526,  526,  529,  530,  531,  533,

			  535,  536,  528,  143,  537,  538,  539,  509,  528,  540,
			  541,  542,  316,  543,  544,  532,  534,  545,  316,  547,
			  549,  546,  548,  550,  551,  552,  553,  554,  530,  530,
			  533,  533,  536,  536,  559,  560,  538,  538,  540,  561,
			  562,  540,  542,  542,  563,  544,  544,  534,  534,  546,
			  555,  548,  550,  546,  548,  550,  552,  552,  554,  554,
			  557,  564,  565,  569,  556,  567,  560,  560,  570,  571,
			  573,  562,  562,  575,  558,  566,  564,  577,  568,  572,
			  574,  576,  557,  578,  579,  580,  581,  583,  582,  584,
			  585,  586,  557,  564,  567,  570,  558,  567,  587,  588, yy_Dummy>>,
			1, 200, 1136)
		end

	yy_nxt_template_9 (an_array: ARRAY [INTEGER])
			-- Fill chunk #9 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  570,  572,  574,  589,  590,  576,  558,  568,  591,  578,
			  568,  572,  574,  576,  592,  578,  580,  580,  582,  584,
			  582,  584,  586,  586,  593,  595,  597,  599,  605,  601,
			  588,  588,  594,  596,  598,  590,  590,  600,  606,  607,
			  592,  609,  608,  610,  603,  611,  592,  602,  612,  613,
			  614,  615,  616,  617,  618,  619,  594,  596,  598,  600,
			  606,  603,  604,  621,  594,  596,  598,  623,  620,  600,
			  606,  608,  622,  610,  608,  610,  603,  612,  624,  604,
			  612,  614,  614,  616,  616,  618,  618,  620,  625,  626,
			  627,  628,  629,  630,  604,  622,  467,  945,  945,  624,

			  620,  945,  651,  652,  622,  632,  632,  632,  632,  945,
			  624,  945,  945,  107,  463,  463,  463,  463,  945,  945,
			  626,  626,  628,  628,  630,  630,  633,  634,  107,  463,
			  463,  463,  463,  105,  652,  652,  265,  265,  265,  265,
			  945,  637,  475,  475,  475,  475,  945,  945,  635,  637,
			  475,  475,  475,  475,  945,  636,  945,  653,  633,  634,
			  945,  945,  638,  639,  642,  642,  642,  642,  945,  945,
			  636,  496,  496,  496,  496,  945,  945,  945,  945,  298,
			  635,  945,  945,  641,  640,  496,  496,  496,  496,  654,
			  945,  641,  311,  311,  638,  639,  945,  644,  644,  644, yy_Dummy>>,
			1, 200, 1336)
		end

	yy_nxt_template_10 (an_array: ARRAY [INTEGER])
			-- Fill chunk #10 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  644,  645,  945,  645,  945,  643,  646,  646,  646,  646,
			  945,  298,  504,  313,  313,  313,  640,  506,  506,  506,
			  506,  506,  506,  506,  506,  647,  654,  507,  507,  507,
			  507,  655,  511,  508,  648,  648,  648,  648,  511,  656,
			  513,  513,  513,  513,  504,  657,  658,  659,  661,  945,
			  660,  662,  663,  664,  509,  665,  666,  667,  654,  668,
			  669,  670,  671,  656,  672,  673,  674,  675,  316,  676,
			  677,  656,  678,  679,  680,  316,  681,  658,  658,  660,
			  662,  316,  660,  662,  664,  664,  682,  666,  666,  668,
			  683,  668,  670,  670,  672,  685,  672,  674,  674,  676,

			  684,  676,  678,  686,  678,  680,  680,  687,  682,  688,
			  689,  690,  691,  692,  693,  694,  695,  696,  682,  697,
			  698,  699,  684,  700,  701,  702,  703,  686,  704,  705,
			  706,  707,  684,  708,  709,  686,  710,  711,  712,  688,
			  713,  688,  690,  690,  692,  692,  694,  694,  696,  696,
			  714,  698,  698,  700,  715,  700,  702,  702,  704,  716,
			  704,  706,  706,  708,  717,  708,  710,  718,  710,  712,
			  712,  719,  714,  721,  720,  722,  723,  724,  725,  726,
			  727,  728,  714,  729,  730,  731,  716,  732,  733,  734,
			  735,  716,  736,  737,  738,  945,  718,  945,  945,  718, yy_Dummy>>,
			1, 200, 1536)
		end

	yy_nxt_template_11 (an_array: ARRAY [INTEGER])
			-- Fill chunk #11 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  744,  744,  744,  720,  945,  722,  720,  722,  724,  724,
			  726,  726,  728,  728,  945,  730,  730,  732,  945,  732,
			  734,  734,  736,  753,  736,  738,  738,  463,  463,  463,
			  463,  746,  746,  746,  746,  642,  642,  642,  642,  748,
			  748,  748,  748,  749,  749,  749,  749,  754,  755,  756,
			  747,  646,  646,  646,  646,  754,  945,  945,  504,  646,
			  646,  646,  646,  757,  758,  759,  760,  761,  636,  762,
			  945,  307,  641,  749,  749,  749,  749,  767,  768,  754,
			  756,  756,  747,  763,  750,  769,  770,  764,  751,  752,
			  504,  513,  513,  513,  513,  758,  758,  760,  760,  762,

			  945,  762,  765,  771,  772,  773,  766,  774,  775,  768,
			  768,  776,  777,  778,  779,  765,  780,  770,  770,  766,
			  751,  781,  782,  783,  784,  785,  786,  787,  788,  789,
			  790,  791,  132,  792,  765,  772,  772,  774,  766,  774,
			  776,  793,  794,  776,  778,  778,  780,  795,  780,  796,
			  797,  798,  799,  782,  782,  784,  784,  786,  786,  788,
			  788,  790,  790,  792,  800,  792,  801,  802,  803,  804,
			  805,  806,  807,  794,  794,  808,  809,  810,  811,  796,
			  812,  796,  798,  798,  800,  813,  814,  815,  816,  817,
			  818,  819,  820,  821,  822,  945,  800,  945,  802,  802, yy_Dummy>>,
			1, 200, 1736)
		end

	yy_nxt_template_12 (an_array: ARRAY [INTEGER])
			-- Fill chunk #12 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  804,  804,  806,  806,  808,  945,  945,  808,  810,  810,
			  812,  945,  812,  107,  739,  739,  945,  814,  814,  816,
			  816,  818,  818,  820,  820,  822,  822,  107,  740,  740,
			  740,  826,  743,  743,  828,  744,  744,  744,  832,  746,
			  746,  746,  746,  833,  945,  833,  842,  945,  834,  834,
			  834,  834,  945,  945,  843,  823,  835,  835,  835,  835,
			  749,  749,  749,  749,  838,  838,  838,  838,  844,  824,
			  845,  836,  945,  827,  846,  837,  829,  839,  843,  839,
			  641,  847,  840,  840,  840,  840,  843,  307,  848,  838,
			  838,  838,  838,  849,  850,  851,  852,  853,  854,  855,

			  845,  856,  845,  836,  841,  857,  847,  837,  858,  859,
			  860,  861,  862,  847,  863,  864,  865,  866,  867,  868,
			  849,  869,  870,  871,  872,  849,  851,  851,  853,  853,
			  855,  855,  873,  857,  874,  875,  841,  857,  876,  877,
			  859,  859,  861,  861,  863,  878,  863,  865,  865,  867,
			  867,  869,  879,  869,  871,  871,  873,  880,  881,  882,
			  883,  884,  885,  886,  873,  887,  875,  875,  739,  739,
			  877,  877,  740,  740,  740,  743,  743,  879,  744,  744,
			  744,  945,  900,  901,  879,  834,  834,  834,  834,  881,
			  881,  883,  883,  885,  885,  887,  902,  887,  834,  834, yy_Dummy>>,
			1, 200, 1936)
		end

	yy_nxt_template_13 (an_array: ARRAY [INTEGER])
			-- Fill chunk #13 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  834,  834,  891,  891,  891,  891,  945,  945,  945,  823,
			  945,  945,  945,  824,  901,  901,  827,  836,  892,  829,
			  892,  945,  945,  893,  893,  893,  893,  894,  903,  894,
			  903,  904,  895,  895,  895,  895,  896,  896,  896,  896,
			  840,  840,  840,  840,  840,  840,  840,  840,  898,  836,
			  898,  897,  905,  899,  899,  899,  899,  906,  907,  908,
			  909,  910,  903,  905,  911,  912,  913,  914,  915,  916,
			  917,  918,  919,  920,  921,  922,  923,  924,  925,  926,
			  927,  928,  929,  897,  905,  893,  893,  893,  893,  907,
			  907,  909,  909,  911,  836,  945,  911,  913,  913,  915,

			  915,  917,  917,  919,  919,  921,  921,  923,  923,  925,
			  925,  927,  927,  929,  929,  893,  893,  893,  893,  945,
			  643,  895,  895,  895,  895,  933,  836,  895,  895,  895,
			  895,  930,  930,  930,  930,  931,  934,  931,  935,  936,
			  932,  932,  932,  932,  937,  938,  897,  899,  899,  899,
			  899,  899,  899,  899,  899,  939,  940,  934,  941,  942,
			  897,  932,  932,  932,  932,  943,  944,  945,  934,  945,
			  936,  936,  932,  932,  932,  932,  938,  938,  897,  128,
			  945,  128,  128,  128,  128,  128,  750,  940,  940,  945,
			  942,  942,  897,  945,  945,  945,  945,  944,  944,   86, yy_Dummy>>,
			1, 200, 2136)
		end

	yy_nxt_template_14 (an_array: ARRAY [INTEGER])
			-- Fill chunk #14 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			   86,   86,   86,   86,   86,   86,   86,   86,   86,   86,
			   86,   86,   86,   86,   86,   86,   96,  154,  154,  154,
			  154,  154,   96,   96,  945,  945,  945,  945,   96,   96,
			   99,  945,   99,   99,   99,   99,   99,   99,   99,   99,
			   99,   99,   99,   99,   99,   99,   99,  104,  945,  104,
			  945,  104,  104,  104,  104,  104,  104,  104,  104,  104,
			  104,  107,  945,  107,  107,  107,  107,  107,  107,  107,
			  107,  107,  107,  107,  107,  107,  107,  107,  108,  945,
			  108,  108,  108,  108,  108,  108,  108,  108,  108,  108,
			  108,  108,  108,  108,  108,  115,  312,  312,  312,  312,

			  312,  115,  115,  945,  945,  945,  945,  115,  115,  236,
			  945,  236,  236,  236,  945,  945,  236,  236,  236,  236,
			  236,  236,  236,  236,  246,  236,  246,  246,  246,  246,
			  246,  246,  246,  246,  246,  246,  246,  246,  246,  252,
			  945,  252,  252,  252,  252,  252,  252,  252,  252,  252,
			  252,  252,  252,  252,  252,  252,  107,  945,  107,  107,
			  107,  945,  107,  263,  107,  263,  107,  263,  263,  263,
			  263,  263,  263,  263,  263,  263,  263,  266,  945,  266,
			  266,  266,  266,  266,  266,  266,  266,  266,  266,  266,
			  266,  266,  266,  266,  249,  945,  249,  249,  249,  945, yy_Dummy>>,
			1, 200, 2336)
		end

	yy_nxt_template_15 (an_array: ARRAY [INTEGER])
			-- Fill chunk #15 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  249,  249,  249,  249,  249,  249,  249,  249,  249,  249,
			  249,    5, yy_Dummy>>,
			1, 12, 2536)
		end

	yy_chk_template: SPECIAL [INTEGER]
			-- Template for `yy_chk'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 2651)
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
			an_array.area.fill_with (962, 2536, 2546)
			an_array.area.fill_with (945, 2547, 2651)
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
			   29,   37,   55,   55,  832,    4,   31,   31,   48,  107,
			   25,   37,  107,   42,  741,   44,  831,   25,   56,   56,
			   25,   25,   50,   51,   12,   26,  830,   45,   36,    3,
			   39,  828,   36,   37,   39,   36,    4,   13,   36,   13,

			   48,   36,   25,   37,   24,   13,   13,   39,   13,   13,
			   13,   38,  826,   38,   50,   51,  741,   13,   13,   13,
			   36,   13,   39,   38,   36,   41,   39,   36,   40,   66,
			   36,   41,   43,   36,   68,   40,   40,   47,   69,   39,
			   49,   40,   43,   38,   43,   38,   72,   47,   43,   13,
			  745,   13,   13,   13,   49,   38,  825,   41,   53,   53,
			   40,   66,  637,   41,   43,  516,   68,   40,   40,   47,
			   69,  515,   49,   40,   43,  514,   43,  511,   72,   47,
			   43,   46,   13,   13,   13,   13,   49,   13,   13,   13,
			   13,   46,  745,   13,   13,   33,   46,   33,   74,   53, yy_Dummy>>,
			1, 200, 105)
		end

	yy_chk_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			   61,   75,  510,   33,   33,  461,   33,   33,   33,   62,
			   61,   62,  445,   46,  331,   33,   33,   33,  329,   33,
			   58,   62,   63,   46,   58,  148,   63,   64,   46,   58,
			   74,   58,   61,   75,   64,   64,   58,   58,   65,   63,
			   64,   62,   61,   62,   65,   78,   78,   33,  323,   33,
			   33,   33,   58,   62,   63,  320,   58,  148,   63,   64,
			  314,   58,  305,   58,   79,   79,   64,   64,   58,   58,
			   65,   63,   64,   80,   80,  303,   65,   81,   81,  301,
			   33,   33,   33,   33,  295,   33,   33,   33,   33,   84,
			   84,   33,   33,   34,   34,   34,   34,   85,   85,   96,

			   96,  115,  115,  149, yy_Dummy>>,
			1, 104, 305)
		end

	yy_chk_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  112,  112,  112,  112,   34,  149, yy_Dummy>>,
			1, 6, 435)
		end

	yy_chk_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			   35,   35,   35,   35,   98,   98,  289,   98,   98,   98,
			   98, yy_Dummy>>,
			1, 11, 467)
		end

	yy_chk_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  118,  118,   99,  288,   35,   99, yy_Dummy>>,
			1, 6, 504)
		end

	yy_chk_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			   60,   70,   67,   73,   60,   71,  104,   60,  123,  123,
			   60,   70,   67,   60,   67,   71,   70,   73,   67,   87,
			   99,  287,   87,   87,   89,   89,   90,   89,   89,   90,
			   90,  151,   60,   70,   67,   73,   60,   71,  236,   60,
			  124,  124,   60,   70,   67,   60,   67,   71,   70,   73,
			   67,   92,   99,  125,  125,   92,  286,   92,  102,  285,
			   92,  102,  102,  151,  102,  106,  284,  102,  106,  106,
			  106,  106,  114,  114,  114,  114,  283,   87,  122,  122,
			  122,  122,   89,  282,   90,  104,  104,  104,  104,  236,
			  117,  104,  104,  117,  117,  117,  117,  120,  120,  120,

			  120,  126,  281,  126,  126,  126,  126,  152,   87,  129,
			  129,  280,  120,   89,  102,   90,  137,  137,  126,  127,
			  153,  127,  127,  127,  127,  130,  130,  130,  279,  132,
			  278,  132,  132,  132,  132,  135,  135,  135,  135,  152,
			  136,  277,  136,  136,  120,  276,  102,  105,  275,  105,
			  126,  136,  153,  136,  150,  105,  105,  150,  105,  105,
			  105,  155,  127,  139,  139,  139,  139,  105,  105,  105,
			  274,  105,  132,  141,  141,  141,  141,  142,  142,  143,
			  143,  156,  157,  158,  159,  157,  150,  160,  161,  150,
			  143,  162,  163,  155,  164,  165,  166,  167,  168,  105, yy_Dummy>>,
			1, 200, 536)
		end

	yy_chk_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  272,  105,  105,  105,  169,  233,  233,  319,  319,  170,
			  175,  633,  633,  156,  157,  158,  159,  157,  271,  160,
			  161,  178,  181,  162,  163,  270,  164,  165,  166,  167,
			  168,  269,  105,  105,  105,  105,  169,  105,  105,  105,
			  105,  170,  175,  105,  105,  109,  182,  268,  109,  109,
			  109,  109,  183,  178,  181,  638,  638,  109,  235,  235,
			  235,  235,  262,  171,  109,  249,  109,  171,  245,  109,
			  109,  109,  109,  244,  109,  243,  109,  242,  182,  173,
			  109,  171,  109,  173,  183,  109,  109,  109,  109,  109,
			  109,  131,  131,  131,  131,  171,  177,  173,  184,  171,

			  177,  185,  131,  131,  131,  131,  131,  131,  517,  176,
			  517,  173,  179,  171,  180,  173,  963,  963,  180,  517,
			  964,  964,  186,  188,  176,  192,  195,  179,  177,  173,
			  184,  196,  177,  185,  131,  131,  131,  131,  131,  131,
			  146,  176,  146,  196,  179,  197,  180,  241,  146,  146,
			  180,  146,  146,  146,  186,  188,  176,  192,  195,  179,
			  146,  146,  146,  196,  146,  189,  193,  198,  199,  189,
			  193,  200,  201,  202,  203,  196,  205,  197,  206,  198,
			  189,  193,  207,  189,  193,  209,  210,  213,  214,  215,
			  217,  213,  146,  240,  146,  146,  146,  189,  193,  198, yy_Dummy>>,
			1, 200, 736)
		end

	yy_chk_template_8 (an_array: ARRAY [INTEGER])
			-- Fill chunk #8 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  199,  189,  193,  200,  201,  202,  203,  239,  205,  218,
			  206,  198,  189,  193,  207,  189,  193,  209,  210,  213,
			  214,  215,  217,  213,  219,  146,  146,  146,  146,  220,
			  146,  146,  146,  146,  221,  216,  146,  146,  211,  216,
			  211,  218,  212,  222,  212,  237,  225,  234,  211,  226,
			  144,  211,  212,  211,  211,  212,  219,  212,  212,  227,
			  228,  220,  229,  223,  230,  231,  221,  216,  223,  232,
			  211,  216,  211,  140,  212,  222,  212,  224,  225,  223,
			  211,  226,  224,  211,  212,  211,  211,  212,  138,  212,
			  212,  227,  228,  224,  229,  223,  230,  231,  321,  321,

			  223,  232,  238,  238,  238,  238,  263,  321,  134,  224,
			  128,  223,  247,  121,  224,  247,  247,  248,  265,  251,
			  248,  248,  251,  251,  252,  224,  116,  113,  252,  111,
			  252,  253,  108,  252,  253,  253,  255,  255,  255,  255,
			  255,  258,  258,  258,  258,  260,  260,  260,  260,  260,
			  103,  259,  255,  255,  259,  259,  101,  259,  322,  322,
			  259,  260,  260,  261,  261,  261,  261,  261,   97,  322,
			  247,  273,  273,  273,  273,  248,   95,  251,   93,  261,
			  296,  296,  296,  296,   83,  263,  263,  263,  263,  253,
			  335,  263,  263,  302,  302,  302,  302,  265,  265,  265, yy_Dummy>>,
			1, 200, 936)
		end

	yy_chk_template_9 (an_array: ARRAY [INTEGER])
			-- Fill chunk #9 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  265,  247,   82,  265,  265,   27,  248,  259,  251,  297,
			  297,  297,  297,  304,  304,  304,  304,  634,  634,  634,
			  253,  298,  335,  298,  297,  336,  298,  298,  298,  298,
			  306,  306,  306,  306,  308,  308,  308,  308,  309,  259,
			  309,  311,  311,  309,  309,  309,  309,   10,  310,  308,
			  310,  310,  310,  310,    9,    7,  297,  336,  261,  261,
			  261,  261,  337,  338,  261,  261,  313,  313,  313,  315,
			  339,  315,  315,  315,  315,  316,  341,  316,  316,  316,
			  316,  308,  311,  324,  324,  324,  324,  330,  330,  330,
			  330,  310,  332,  332,  337,  338,  345,  346,  347,  348,

			  349,  350,  339,  332,  351,  352,  353,  313,  341,  354,
			  355,  356,  315,  357,  358,  347,  348,  359,  316,  360,
			  361,  362,  363,  364,  365,  366,  368,  370,  345,  346,
			  347,  348,  349,  350,  372,  374,  351,  352,  353,  375,
			  376,  354,  355,  356,  377,  357,  358,  347,  348,  359,
			  371,  360,  361,  362,  363,  364,  365,  366,  368,  370,
			  373,  378,  379,  381,  371,  380,  372,  374,  382,  383,
			  384,  375,  376,  385,  373,  379,  377,  386,  380,  387,
			  388,  389,  371,  390,  391,  392,  393,  394,  395,  396,
			  397,  398,  373,  378,  379,  381,  371,  380,  399,  400, yy_Dummy>>,
			1, 200, 1136)
		end

	yy_chk_template_10 (an_array: ARRAY [INTEGER])
			-- Fill chunk #10 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  382,  383,  384,  403,  404,  385,  373,  379,  405,  386,
			  380,  387,  388,  389,  406,  390,  391,  392,  393,  394,
			  395,  396,  397,  398,  407,  408,  409,  410,  412,  411,
			  399,  400,  413,  414,  415,  403,  404,  416,  418,  419,
			  405,  420,  421,  422,  417,  423,  406,  411,  424,  425,
			  426,  427,  428,  429,  430,  431,  407,  408,  409,  410,
			  412,  411,  417,  432,  413,  414,  415,  433,  434,  416,
			  418,  419,  435,  420,  421,  422,  417,  423,  436,  411,
			  424,  425,  426,  427,  428,  429,  430,  431,  437,  438,
			  439,  440,  441,  442,  417,  432,  468,    5,    0,  433,

			  434,    0,  523,  524,  435,  446,  446,  446,  446,    0,
			  436,    0,    0,  462,  462,  462,  462,  462,    0,    0,
			  437,  438,  439,  440,  441,  442,  462,  462,  463,  463,
			  463,  463,  463,  465,  523,  524,  465,  465,  465,  465,
			    0,  475,  475,  475,  475,  475,    0,    0,  462,  474,
			  474,  474,  474,  474,    0,  462,    0,  525,  462,  462,
			    0,    0,  474,  474,  494,  494,  494,  494,    0,    0,
			  463,  495,  495,  495,  495,  468,  468,  468,  468,  494,
			  462,  468,  468,  475,  474,  496,  496,  496,  496,  525,
			    0,  474,  508,  508,  474,  474,    0,  503,  503,  503, yy_Dummy>>,
			1, 200, 1336)
		end

	yy_chk_template_11 (an_array: ARRAY [INTEGER])
			-- Fill chunk #11 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  503,  504,    0,  504,    0,  494,  504,  504,  504,  504,
			    0,  494,  503,  509,  509,  509,  474,  505,  505,  505,
			  505,  506,  506,  506,  506,  507,  526,  507,  507,  507,
			  507,  527,  512,  508,  512,  512,  512,  512,  513,  528,
			  513,  513,  513,  513,  503,  529,  530,  531,  532,    0,
			  533,  534,  535,  536,  509,  537,  538,  539,  526,  540,
			  541,  542,  543,  527,  544,  545,  546,  547,  507,  548,
			  549,  528,  550,  551,  552,  512,  553,  529,  530,  531,
			  532,  513,  533,  534,  535,  536,  554,  537,  538,  539,
			  555,  540,  541,  542,  543,  556,  544,  545,  546,  547,

			  557,  548,  549,  558,  550,  551,  552,  559,  553,  560,
			  561,  562,  563,  564,  566,  568,  569,  570,  554,  571,
			  572,  573,  555,  574,  575,  576,  577,  556,  578,  581,
			  582,  587,  557,  588,  591,  558,  592,  593,  594,  559,
			  595,  560,  561,  562,  563,  564,  566,  568,  569,  570,
			  596,  571,  572,  573,  597,  574,  575,  576,  577,  598,
			  578,  581,  582,  587,  599,  588,  591,  600,  592,  593,
			  594,  601,  595,  602,  603,  604,  605,  606,  607,  608,
			  609,  610,  596,  613,  614,  619,  597,  620,  621,  622,
			  623,  598,  624,  625,  626,    0,  599,    0,    0,  600, yy_Dummy>>,
			1, 200, 1536)
		end

	yy_chk_template_12 (an_array: ARRAY [INTEGER])
			-- Fill chunk #12 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  639,  639,  639,  601,    0,  602,  603,  604,  605,  606,
			  607,  608,  609,  610,    0,  613,  614,  619,    0,  620,
			  621,  622,  623,  651,  624,  625,  626,  636,  636,  636,
			  636,  641,  641,  641,  641,  642,  642,  642,  642,  643,
			  643,  643,  643,  644,  644,  644,  644,  652,  657,  658,
			  642,  645,  645,  645,  645,  651,    0,    0,  644,  646,
			  646,  646,  646,  659,  660,  661,  662,  667,  636,  668,
			    0,  647,  641,  647,  647,  647,  647,  671,  672,  652,
			  657,  658,  642,  669,  644,  675,  676,  669,  647,  648,
			  644,  648,  648,  648,  648,  659,  660,  661,  662,  667,

			    0,  668,  670,  677,  678,  679,  670,  680,  681,  671,
			  672,  682,  683,  684,  685,  669,  686,  675,  676,  669,
			  647,  687,  688,  691,  692,  693,  694,  695,  696,  697,
			  698,  699,  648,  700,  670,  677,  678,  679,  670,  680,
			  681,  701,  702,  682,  683,  684,  685,  703,  686,  704,
			  707,  708,  709,  687,  688,  691,  692,  693,  694,  695,
			  696,  697,  698,  699,  710,  700,  711,  712,  713,  714,
			  715,  716,  717,  701,  702,  718,  719,  720,  721,  703,
			  722,  704,  707,  708,  709,  725,  726,  727,  728,  731,
			  732,  733,  734,  737,  738,    0,  710,    0,  711,  712, yy_Dummy>>,
			1, 200, 1736)
		end

	yy_chk_template_13 (an_array: ARRAY [INTEGER])
			-- Fill chunk #13 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  713,  714,  715,  716,  717,    0,    0,  718,  719,  720,
			  721,    0,  722,  739,  739,  739,    0,  725,  726,  727,
			  728,  731,  732,  733,  734,  737,  738,  740,  740,  740,
			  740,  743,  743,  743,  744,  744,  744,  744,  746,  746,
			  746,  746,  746,  747,    0,  747,  757,    0,  747,  747,
			  747,  747,    0,    0,  758,  739,  748,  748,  748,  748,
			  749,  749,  749,  749,  750,  750,  750,  750,  759,  740,
			  760,  748,    0,  743,  761,  749,  744,  751,  757,  751,
			  746,  762,  751,  751,  751,  751,  758,  752,  764,  752,
			  752,  752,  752,  766,  767,  768,  769,  770,  771,  772,

			  759,  777,  760,  748,  752,  778,  761,  749,  781,  782,
			  783,  784,  787,  762,  788,  789,  790,  791,  792,  793,
			  764,  794,  795,  796,  797,  766,  767,  768,  769,  770,
			  771,  772,  798,  777,  799,  800,  752,  778,  801,  802,
			  781,  782,  783,  784,  787,  803,  788,  789,  790,  791,
			  792,  793,  804,  794,  795,  796,  797,  807,  808,  815,
			  816,  817,  818,  821,  798,  822,  799,  800,  823,  823,
			  801,  802,  824,  824,  824,  827,  827,  803,  829,  829,
			  829,    0,  842,  843,  804,  833,  833,  833,  833,  807,
			  808,  815,  816,  817,  818,  821,  844,  822,  834,  834, yy_Dummy>>,
			1, 200, 1936)
		end

	yy_chk_template_14 (an_array: ARRAY [INTEGER])
			-- Fill chunk #14 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  834,  834,  835,  835,  835,  835,    0,    0,    0,  823,
			    0,    0,    0,  824,  842,  843,  827,  835,  836,  829,
			  836,    0,    0,  836,  836,  836,  836,  837,  844,  837,
			  845,  848,  837,  837,  837,  837,  838,  838,  838,  838,
			  839,  839,  839,  839,  840,  840,  840,  840,  841,  835,
			  841,  838,  849,  841,  841,  841,  841,  852,  853,  854,
			  855,  856,  845,  848,  857,  858,  859,  864,  865,  870,
			  871,  872,  873,  874,  875,  876,  877,  878,  879,  882,
			  883,  884,  885,  838,  849,  892,  892,  892,  892,  852,
			  853,  854,  855,  856,  891,    0,  857,  858,  859,  864,

			  865,  870,  871,  872,  873,  874,  875,  876,  877,  878,
			  879,  882,  883,  884,  885,  893,  893,  893,  893,    0,
			  891,  894,  894,  894,  894,  902,  891,  895,  895,  895,
			  895,  896,  896,  896,  896,  897,  903,  897,  908,  909,
			  897,  897,  897,  897,  916,  917,  896,  898,  898,  898,
			  898,  899,  899,  899,  899,  920,  921,  902,  924,  925,
			  930,  931,  931,  931,  931,  935,  936,    0,  903,    0,
			  908,  909,  932,  932,  932,  932,  916,  917,  896,  953,
			    0,  953,  953,  953,  953,  953,  930,  920,  921,    0,
			  924,  925,  930,    0,    0,    0,    0,  935,  936,  946, yy_Dummy>>,
			1, 200, 2136)
		end

	yy_chk_template_15 (an_array: ARRAY [INTEGER])
			-- Fill chunk #15 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  946,  946,  946,  946,  946,  946,  946,  946,  946,  946,
			  946,  946,  946,  946,  946,  946,  947,  955,  955,  955,
			  955,  955,  947,  947,    0,    0,    0,    0,  947,  947,
			  948,    0,  948,  948,  948,  948,  948,  948,  948,  948,
			  948,  948,  948,  948,  948,  948,  948,  949,    0,  949,
			    0,  949,  949,  949,  949,  949,  949,  949,  949,  949,
			  949,  950,    0,  950,  950,  950,  950,  950,  950,  950,
			  950,  950,  950,  950,  950,  950,  950,  950,  951,    0,
			  951,  951,  951,  951,  951,  951,  951,  951,  951,  951,
			  951,  951,  951,  951,  951,  952,  961,  961,  961,  961,

			  961,  952,  952,    0,    0,    0,    0,  952,  952,  954,
			    0,  954,  954,  954,    0,    0,  954,  954,  954,  954,
			  954,  954,  954,  954,  956,  954,  956,  956,  956,  956,
			  956,  956,  956,  956,  956,  956,  956,  956,  956,  957,
			    0,  957,  957,  957,  957,  957,  957,  957,  957,  957,
			  957,  957,  957,  957,  957,  957,  958,    0,  958,  958,
			  958,    0,  958,  959,  958,  959,  958,  959,  959,  959,
			  959,  959,  959,  959,  959,  959,  959,  960,    0,  960,
			  960,  960,  960,  960,  960,  960,  960,  960,  960,  960,
			  960,  960,  960,  960,  962,    0,  962,  962,  962,    0, yy_Dummy>>,
			1, 200, 2336)
		end

	yy_base_template: SPECIAL [INTEGER]
			-- Template for `yy_base'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 964)
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
			    0,    0,    0,  104,  111, 1433, 2547, 1190, 2547, 1188,
			 1178,  102,  100,  196, 2547,  107,  111, 2547, 2547,  106,
			  108, 2547,  110,  111,  118,  121,  129, 1114, 2547,  138,
			  141,  144,  113,  294,  378,  447,  155,  131,  174,  164,
			  197,  191,  101,  205,  100,  125,  251,  204,  129,  214,
			  149,  143, 2547,  246, 2547,  150,  166,    0,  292,    0,
			  498,  270,  272,  296,  296,  304,  189,  506,  191,  208,
			  502,  503,  207,  508,  265,  261, 2547, 2547,  333,  352,
			  361,  365, 1121, 1103,  377,  385,    0,  554, 2547,  559,
			  561, 2547,  586, 1113, 2547, 1107,  387, 1087,  454,  499,

			 2547, 1073,  593, 1069,  525,  677,  584,  167, 1057,  774,
			    0, 1048,  415, 1046,  588,  389, 1045,  609,  487, 2547,
			  613, 1032,  594,  527,  559,  572,  619,  637, 1028,  625,
			  641,  807,  647, 2547, 1027,  651,  661,  635, 1007,  679,
			  992,  689,  696,  698,  969, 2547,  870,    0,  282,  373,
			  651,  533,  594,  606,    0,  649,  682,  679,  685,  671,
			  673,  689,  696,  684,  695,  683,  697,  702,  690,  705,
			  697,  767,    0,  783,    0,  697,  811,  786,  708,  814,
			  804,  716,  751,  743,  792,  806,  813,    0,  813,  867,
			    0,    0,  815,  868,    0,  821,  834,  840,  870,  854, yy_Dummy>>,
			1, 200, 0)
		end

	yy_base_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			  857,  859,  875,  877,    0,  863,  880,  885,    0,  886,
			  887,  940,  944,  881,  881,  877,  929,  883,  897,  925,
			  914,  935,  928,  965,  979,  934,  946,  947,  957,  963,
			  965,  953,  957,  724,  966,  774,  563,  964, 1018,  926,
			  912,  866,  796,  794,  792,  787,    0, 1047, 1052,  794,
			 2547, 1054, 1059, 1066, 2547, 1071, 2547, 2547, 1057, 1086,
			 1080, 1098,  781, 1025, 2547, 1037, 2547, 2547,  772,  756,
			  750,  743,  725, 1087,  695,  673,  670,  666,  655,  653,
			  636,  627,  608,  601,  591,  584,  581,  546,  496,  462,
			 2547, 2547, 2547, 2547, 2547,  372, 1096, 1125, 1142, 2547,

			 2547,  367, 1109,  363, 1129,  350, 1146, 2547, 1150, 1159,
			 1166, 1157,    0, 1182,  304, 1187, 1193, 2547, 2547,  726,
			  343, 1017, 1077,  336, 1199, 2547, 2547, 2547, 2547,  306,
			 1203,  302, 1211, 2547, 2547, 1081, 1116, 1154, 1155, 1175,
			    0, 1181,    0,    0,    0, 1193, 1194, 1203, 1204, 1203,
			 1204, 1191, 1192, 1190, 1193, 1215, 1216, 1201, 1202, 1202,
			 1220, 1225, 1206, 1223, 1228, 1225, 1226,    0, 1211,    0,
			 1212, 1255, 1235, 1265, 1236, 1226, 1227, 1230, 1247, 1255,
			 1258, 1257, 1262, 1270, 1271, 1263, 1282, 1280, 1281, 1271,
			 1288, 1285, 1286, 1291, 1277, 1293, 1279, 1291, 1292, 1289, yy_Dummy>>,
			1, 200, 200)
		end

	yy_base_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			 1290,    0,    0, 1304, 1305, 1311, 1317, 1325, 1326, 1331,
			 1312, 1332, 1316, 1333, 1334, 1339, 1322, 1347, 1326, 1340,
			 1346, 1343, 1348, 1346, 1349, 1346, 1347, 1343, 1344, 1354,
			 1355, 1356, 1352, 1364, 1369, 1361, 1375, 1385, 1386, 1392,
			 1393, 1384, 1385,    0,    0,  300, 1421, 2547, 2547, 2547,
			 2547, 2547, 2547, 2547, 2547, 2547, 2547, 2547, 2547, 2547,
			 2547,  293, 1430, 1445, 2547, 1452, 2547, 2547, 1415, 2547,
			 2547, 2547, 2547, 2547, 1466, 1458, 2547, 2547, 2547, 2547,
			 2547, 2547, 2547, 2547, 2547, 2547, 2547, 2547, 2547, 2547,
			 2547, 2547, 2547, 2547, 1480, 1487, 1501, 2547, 2547, 2547,

			 2547, 2547, 2547, 1513, 1522, 1533, 1537, 1543, 1508, 1529,
			  246,  264, 1550, 1556,  263,  259,  242,  829, 2547, 2547,
			 2547, 2547, 2547, 1389, 1390, 1443, 1512, 1518, 1526, 1544,
			 1545, 1550, 1545, 1553, 1548, 1547, 1548, 1542, 1543, 1558,
			 1560, 1546, 1547, 1563, 1565, 1564, 1565, 1555, 1557, 1573,
			 1575, 1570, 1571, 1564, 1574, 1582, 1583, 1592, 1591, 1595,
			 1597, 1611, 1612, 1597, 1598,    0, 1615,    0, 1616, 1613,
			 1614, 1601, 1602, 1609, 1611, 1625, 1626, 1614, 1616,    0,
			    0, 1623, 1624,    0,    0,    0,    0, 1625, 1627,    0,
			    0, 1619, 1621, 1637, 1638, 1628, 1638, 1647, 1652, 1661, yy_Dummy>>,
			1, 200, 400)
		end

	yy_base_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			 1664, 1656, 1667, 1659, 1669, 1657, 1658, 1681, 1682, 1668,
			 1669,    0,    0, 1673, 1674,    0,    0,    0,    0, 1685,
			 1687, 1673, 1674, 1684, 1686, 1698, 1699,    0,    0,    0,
			    0, 2547, 2547,  727, 1133,    0, 1743,  256,  771, 1716,
			    0, 1747, 1751, 1755, 1759, 1767, 1775, 1789, 1807, 2547,
			 2547, 1710, 1734,    0,    0,    0,    0, 1740, 1741, 1761,
			 1762, 1769, 1770,    0,    0,    0,    0, 1755, 1757, 1784,
			 1803, 1769, 1770,    0,    0, 1773, 1774, 1801, 1802, 1805,
			 1807, 1809, 1812, 1814, 1815, 1800, 1802, 1813, 1814,    0,
			    0, 1811, 1812, 1817, 1818, 1828, 1829, 1826, 1827, 1828,

			 1830, 1844, 1845, 1844, 1846,    0,    0, 1851, 1852, 1840,
			 1852, 1863, 1864, 1869, 1870, 1871, 1872, 1860, 1863, 1877,
			 1878, 1864, 1866,    0,    0, 1871, 1872, 1892, 1893,    0,
			    0, 1886, 1887, 1892, 1893,    0,    0, 1885, 1886, 1930,
			 1944,  160, 2547, 1948, 1951,  236, 1955, 1964, 1972, 1976,
			 1980, 1998, 2005,    0,    0,    0,    0, 1947, 1955, 1953,
			 1955, 1960, 1967,    0, 1979,    0, 1984, 1980, 1981, 1997,
			 1998, 2003, 2004,    0,    0,    0,    0, 2002, 2006,    0,
			    0, 2013, 2014, 2011, 2012,    0,    0, 1999, 2001, 2007,
			 2008, 2003, 2004, 2005, 2007, 2027, 2028, 2010, 2018, 2021, yy_Dummy>>,
			1, 200, 600)
		end

	yy_base_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			 2022, 2030, 2031, 2037, 2044,    0,    0, 2058, 2059,    0,
			    0,    0,    0,    0,    0, 2045, 2046, 2053, 2054,    0,
			    0, 2049, 2051, 2084, 2088,  200,  206, 2091,  185, 2094,
			  180,  120,  158, 2101, 2114, 2118, 2139, 2148, 2152, 2156,
			 2160, 2169, 2084, 2085, 2082, 2116,    0,    0, 2123, 2144,
			    0,    0, 2159, 2160, 2163, 2164, 2163, 2166, 2159, 2160,
			    0,    0,    0,    0, 2166, 2167,    0,    0,    0,    0,
			 2161, 2162, 2172, 2173, 2164, 2165, 2176, 2177, 2180, 2181,
			    0,    0, 2180, 2181, 2182, 2183,    0,    0, 2547, 2547,
			 2547, 2195, 2201, 2231, 2237, 2243, 2247, 2256, 2263, 2267,

			    0,    0, 2226, 2237,    0,    0,    0,    0, 2232, 2233,
			    0,    0,    0,    0,    0,    0, 2230, 2231,    0,    0,
			 2243, 2244,    0,    0, 2259, 2260,    0,    0,    0,    0,
			 2261, 2277, 2288,    0,    0, 2266, 2267,    0,    0,    0,
			    0,    0,    0,    0,    0, 2547, 2334, 2349, 2365, 2380,
			 2396, 2413, 2428, 2306, 2444, 2342, 2457, 2474, 2488, 2496,
			 2512, 2421, 2529,  841,  845, yy_Dummy>>,
			1, 165, 800)
		end

	yy_def_template: SPECIAL [INTEGER]
			-- Template for `yy_def'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 964)
			yy_def_template_1 (an_array)
			yy_def_template_2 (an_array)
			an_array.area.fill_with (945, 266, 294)
			yy_def_template_3 (an_array)
			an_array.area.fill_with (945, 469, 506)
			yy_def_template_4 (an_array)
			yy_def_template_5 (an_array)
			yy_def_template_6 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_def_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			    0,  945,    1,  946,  946,  945,  945,  945,  945,  945,
			  945,  947,  948,  949,  945,  950,  951,  945,  945,  947,
			  947,  945,  952,  945,  947,  953,  953,  945,  945,  947,
			  947,  947,  945,  949,  945,  945,   35,   35,   35,   35,
			   35,   35,   35,   35,   35,   35,   35,   35,   35,   35,
			   35,   35,  945,  947,  945,  947,  947,  954,  955,  955,
			  955,  955,  955,  955,  955,  955,  955,  955,  955,  955,
			  955,  955,  955,  955,  955,  955,  945,  945,  947,  947,
			  947,  947,  945,  945,  947,  947,  956,  945,  945,  956,
			  945,  945,  957,  945,  945,  945,  947,  952,  947,  948,

			  945,  958,  948,   33,  949,  959,   33,  950,  960,  960,
			  960,  952,   98,  952,   98,  947,  945,   98,  947,  945,
			  945,  952,   98,  947,  947,  947,  945,  953,  953,  961,
			  961,  961,  953,  945,  952,   98,  947,  947,  952,   98,
			  952,   98,  947,  947,  945,  945,  959,   35,   35,   35,
			   35,   35,   35,   35,  955,  955,  955,  955,  955,  955,
			  955,   35,   35,   35,   35,   35,  955,  955,  955,  955,
			  955,   35,   35,  955,  955,   35,   35,   35,  955,  955,
			  955,   35,   35,   35,  955,  955,  955,   35,   35,   35,
			   35,  955,  955,  955,  955,   35,   35,  955,  955,   35, yy_Dummy>>,
			1, 200, 0)
		end

	yy_def_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  955,   35,   35,   35,   35,  955,  955,  955,  955,   35,
			  955,   35,  955,   35,   35,   35,  955,  955,  955,   35,
			   35,  955,  955,   35,  955,   35,   35,  955,  955,   35,
			  955,   35,  955,  947,  952,   98,  954,  952,   98,  952,
			  952,  952,  945,  945,  952,  952,  956,  945,  945,  962,
			  945,  956,  957,  945,  945,  952,  945,  945,  945,  948,
			  146,  959,   33,  949,  945,  949, yy_Dummy>>,
			1, 66, 200)
		end

	yy_def_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  952,   98,  945,  945,  945,  945,  255,   98,  255,   98,
			  255,   98,  945,  945,  945,  953,  961,  961,  961,  131,
			  953,  953,  945,  945,  947,  255,  947,  947,  255,   98,
			  945,  945,  945,  945,  255,   98,  255,  947,  945,  945,
			   35,  955,   35,  955,   35,   35,  955,  955,   35,  955,
			   35,  955,   35,  955,   35,  955,   35,  955,   35,  955,
			   35,  955,   35,  955,   35,   35,   35,  955,  955,  955,
			   35,  955,   35,   35,  955,  955,   35,   35,  955,  955,
			   35,  955,   35,  955,   35,  955,   35,  955,   35,   35,
			   35,   35,  955,  955,  955,  955,   35,  955,   35,   35,

			  955,  955,   35,  955,   35,  955,   35,  955,   35,  955,
			   35,  955,   35,   35,   35,   35,   35,   35,  955,  955,
			  955,  955,  955,  955,   35,   35,  955,  955,   35,  955,
			   35,  955,   35,  955,   35,  955,   35,   35,   35,  955,
			  955,  955,   35,  955,   35,  955,   35,  955,   35,  955,
			  255,   98,  945,  945,  945,  945,  945,  945,  945,  945,
			  945,  945,  945,  945,  945,  945,   98,  945,  945,  945,
			   33,  945,  945,  959, yy_Dummy>>,
			1, 174, 295)
		end

	yy_def_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  953,  961,  961,  131,  945,  953,  953,  255,  945,  136,
			  136,  945,  945,  945,  945,  945,   35,  955,   35,  955,
			   35,  955,   35,  955,   35,   35,  955,  955,   35,  955,
			   35,  955,   35,  955,   35,  955,   35,  955,   35,  955,
			   35,  955,   35,  955,   35,  955,   35,  955,   35,   35,
			  955,  955,   35,  955,   35,  955,   35,  955,   35,   35,
			  955,  955,   35,  955,   35,  955,   35,  955,   35,  955,
			   35,  955,   35,  955,   35,  955,   35,  955,   35,  955,
			   35,  955,   35,  955,   35,  955,   35,  955,   35,  955,
			   35,  955,   35,  955,   35,   35,  955,  955,   35,  955,

			   35,  955,   35,  955,   35,  955,   35,  955,   35,  955,
			   35,  955,   35,  955,   35,  955,   35,  955,   35,  955,
			   35,  955,   35,  955,  945,  945,  945,  945,  963,  945,
			  945,  945,  945,  964,  945,  945,  945,  945,  945,  945,
			  945,  953,  945,  945,   35,  955,   35,  955,   35,  955,
			   35,  955,   35,  955,   35,  955,   35,  955,   35,  955,
			   35,  955,   35,  955,   35,  955,   35,  955,   35,  955,
			   35,  955,   35,  955,   35,  955,   35,  955,   35,  955,
			   35,  955,   35,  955,   35,  955,   35,  955,   35,  955,
			   35,  955,   35,  955,   35,  955,   35,  955,   35,  955, yy_Dummy>>,
			1, 200, 507)
		end

	yy_def_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			   35,  955,   35,  955,   35,  955,   35,  955,   35,  955,
			   35,  955,   35,  955,   35,  955,   35,  955,   35,  955,
			   35,  955,   35,  955,   35,  955,   35,  955,   35,  955,
			   35,  955,  945,  945,  963,  945,  945,  945,  964,  945,
			  945,  945,  945,  945,  945,  945,   35,  955,   35,  955,
			   35,  955,   35,  955,   35,  955,   35,   35,  955,  955,
			   35,  955,   35,  955,   35,  955,   35,  955,   35,  955,
			   35,  955,   35,  955,   35,  955,   35,  955,   35,  955,
			   35,  955,   35,  955,   35,  955,   35,  955,   35,  955,
			   35,  955,   35,  955,   35,  955,   35,  955,   35,  955,

			   35,  955,   35,  955,   35,  955,   35,  955,   35,  955,
			   35,  955,   35,  955,   35,  955,  945,  945,  963,  945,
			  945,  945,  945,  945,  964,  945,  945,  945,  945,  945,
			  945,  945,  945,  945,  945,   35,  955,   35,  955,   35,
			  955,   35,  955,   35,  955,   35,  955,   35,  955,   35,
			  955,   35,  955,   35,  955,   35,  955,   35,  955,   35,
			  955,   35,  955,   35,  955,   35,  955,   35,  955,   35,
			  955,   35,  955,   35,  955,   35,  955,   35,  955,   35,
			  955,  945,  945,  945,  945,  945,  945,  945,  945,  945,
			  945,  945,  945,   35,  955,   35,  955,   35,  955,   35, yy_Dummy>>,
			1, 200, 707)
		end

	yy_def_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  955,   35,  955,   35,  955,   35,  955,   35,  955,   35,
			  955,   35,  955,   35,  955,   35,  955,   35,  955,   35,
			  955,   35,  955,  945,  945,  945,   35,  955,   35,  955,
			   35,  955,   35,  955,   35,  955,   35,  955,    0,  945,
			  945,  945,  945,  945,  945,  945,  945,  945,  945,  945,
			  945,  945,  945,  945,  945,  945,  945,  945, yy_Dummy>>,
			1, 58, 907)
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
			    0,    1,    2,   17,   17,    1,    3,    4,    3,    5,
			    6,    7,    8,    8,    3,    3,    5,    3,    9,   10,
			   11,   11,   11,   11,    5,    5,   10,    3,   10,    5,
			    3,   12,   12,   12,   12,   11,   12,   13,   14,   13,
			   13,   13,   14,   13,   14,   13,   13,   14,   14,   14,
			   14,   14,   14,   13,   13,   13,   13,    5,    3,    5,
			    3,   15,   16,   11,   11,   11,   11,   11,   11,   13,
			   13,   13,   13,   13,   13,   13,   13,   13,   13,   13,
			   13,   13,   13,   13,   13,   13,   13,   13,   13,    5,
			    5,    3,    3,    3,    3,    5,    3,    3,    3,    3,

			   17,   17,    3,    3,   17, yy_Dummy>>)
		end

	yy_accept_template: SPECIAL [INTEGER]
			-- Template for `yy_accept'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 946)
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

			  294,  295,  296,  298,  300,  301,  301,  303,  303,  304,
			  305,  306,  306,  307,  307,  308,  309,  310,  311,  313,
			  314,  315,  315,  316,  318,  320,  322,  323,  325,  326,
			  327,  328,  329,  330,  331,  331,  332,  334,  336,  336,
			  337,  337,  338,  340,  342,  342,  343,  343,  345,  347,
			  349,  351,  353,  356,  358,  359,  360,  361,  362,  363,
			  365,  366,  368,  370,  372,  374,  376,  377,  378,  379,
			  380,  381,  383,  386,  387,  389,  391,  393,  395,  396,
			  397,  398,  400,  402,  404,  405,  406,  407,  410,  412,
			  414,  417,  419,  420,  421,  423,  425,  427,  428,  429, yy_Dummy>>,
			1, 200, 0)
		end

	yy_accept_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			  431,  432,  434,  436,  438,  441,  442,  443,  444,  446,
			  448,  449,  451,  452,  454,  456,  458,  459,  460,  461,
			  463,  465,  466,  467,  469,  470,  472,  474,  475,  476,
			  478,  479,  481,  482,  484,  484,  485,  485,  485,  486,
			  486,  486,  486,  486,  486,  486,  486,  487,  488,  488,
			  488,  489,  490,  491,  492,  493,  494,  495,  496,  496,
			  497,  499,  500,  502,  503,  505,  507,  508,  510,  511,
			  512,  513,  514,  515,  516,  517,  518,  519,  520,  521,
			  522,  523,  524,  525,  526,  527,  528,  529,  530,  531,
			  532,  534,  536,  538,  540,  541,  541,  542,  543,  543,

			  545,  547,  548,  549,  550,  551,  552,  553,  554,  555,
			  555,  557,  560,  562,  565,  568,  570,  571,  573,  575,
			  577,  579,  580,  581,  582,  583,  585,  587,  589,  591,
			  592,  593,  594,  595,  596,  599,  601,  602,  604,  605,
			  607,  610,  611,  613,  616,  618,  620,  621,  623,  624,
			  626,  627,  629,  630,  632,  633,  635,  636,  638,  639,
			  641,  643,  645,  646,  647,  648,  650,  651,  654,  656,
			  658,  659,  661,  663,  664,  665,  667,  668,  670,  671,
			  673,  674,  676,  677,  679,  681,  683,  685,  686,  687,
			  688,  689,  691,  692,  694,  696,  697,  698,  701,  703, yy_Dummy>>,
			1, 200, 200)
		end

	yy_accept_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			  705,  706,  709,  711,  713,  714,  716,  717,  719,  721,
			  723,  725,  727,  729,  730,  731,  732,  733,  734,  735,
			  737,  739,  740,  741,  743,  744,  746,  747,  749,  750,
			  752,  753,  755,  757,  759,  760,  761,  762,  764,  765,
			  767,  768,  770,  771,  774,  776,  777,  778,  780,  782,
			  783,  784,  786,  788,  790,  792,  794,  795,  796,  798,
			  800,  801,  802,  802,  802,  804,  806,  807,  808,  808,
			  809,  810,  811,  812,  813,  814,  815,  816,  817,  818,
			  819,  820,  821,  822,  823,  824,  825,  826,  827,  828,
			  829,  830,  831,  833,  835,  836,  836,  837,  839,  841,

			  843,  845,  847,  849,  850,  850,  850,  851,  853,  855,
			  857,  859,  859,  861,  863,  864,  866,  868,  870,  872,
			  874,  876,  878,  880,  882,  883,  885,  886,  888,  889,
			  891,  892,  894,  896,  897,  898,  900,  901,  903,  904,
			  906,  907,  909,  910,  912,  913,  915,  916,  918,  919,
			  921,  922,  925,  927,  929,  930,  932,  934,  935,  936,
			  938,  939,  941,  942,  944,  945,  948,  950,  952,  953,
			  955,  956,  958,  959,  961,  962,  964,  965,  967,  968,
			  971,  973,  975,  976,  979,  981,  984,  986,  988,  989,
			  992,  994,  996,  997,  999, 1000, 1002, 1003, 1005, 1006, yy_Dummy>>,
			1, 200, 400)
		end

	yy_accept_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			 1008, 1009, 1011, 1013, 1014, 1015, 1017, 1018, 1020, 1021,
			 1023, 1024, 1027, 1029, 1031, 1032, 1035, 1037, 1040, 1042,
			 1044, 1045, 1047, 1048, 1050, 1051, 1053, 1054, 1057, 1059,
			 1062, 1064, 1066, 1068, 1068, 1068, 1068, 1068, 1069, 1069,
			 1069, 1069, 1069, 1070, 1070, 1071, 1071, 1072, 1073, 1075,
			 1077, 1078, 1080, 1081, 1084, 1086, 1089, 1091, 1093, 1094,
			 1096, 1097, 1099, 1100, 1103, 1105, 1108, 1110, 1112, 1113,
			 1115, 1116, 1118, 1119, 1122, 1124, 1126, 1127, 1129, 1130,
			 1132, 1133, 1135, 1136, 1138, 1139, 1141, 1142, 1144, 1145,
			 1148, 1150, 1152, 1153, 1155, 1156, 1158, 1159, 1161, 1162,

			 1164, 1165, 1167, 1168, 1170, 1171, 1174, 1176, 1178, 1179,
			 1181, 1182, 1184, 1185, 1187, 1188, 1190, 1191, 1193, 1194,
			 1196, 1197, 1199, 1200, 1203, 1205, 1207, 1208, 1210, 1211,
			 1214, 1216, 1218, 1219, 1221, 1222, 1225, 1227, 1229, 1230,
			 1230, 1230, 1230, 1231, 1231, 1231, 1231, 1231, 1231, 1232,
			 1233, 1233, 1233, 1234, 1237, 1239, 1242, 1244, 1246, 1247,
			 1249, 1250, 1252, 1253, 1256, 1258, 1260, 1261, 1263, 1264,
			 1266, 1267, 1269, 1270, 1273, 1275, 1278, 1280, 1282, 1283,
			 1286, 1288, 1290, 1291, 1293, 1294, 1297, 1299, 1301, 1302,
			 1304, 1305, 1307, 1308, 1310, 1311, 1313, 1314, 1316, 1317, yy_Dummy>>,
			1, 200, 600)
		end

	yy_accept_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			 1319, 1320, 1322, 1323, 1325, 1326, 1329, 1331, 1333, 1334,
			 1337, 1339, 1342, 1344, 1347, 1349, 1351, 1352, 1354, 1355,
			 1358, 1360, 1362, 1363, 1363, 1363, 1363, 1363, 1363, 1363,
			 1363, 1363, 1363, 1363, 1363, 1364, 1365, 1365, 1365, 1366,
			 1366, 1367, 1367, 1369, 1370, 1372, 1373, 1376, 1378, 1380,
			 1381, 1384, 1386, 1388, 1389, 1391, 1392, 1394, 1395, 1397,
			 1398, 1401, 1403, 1406, 1408, 1410, 1411, 1414, 1416, 1419,
			 1421, 1423, 1424, 1426, 1427, 1429, 1430, 1432, 1433, 1435,
			 1436, 1439, 1441, 1443, 1444, 1446, 1447, 1450, 1452, 1453,
			 1454, 1455, 1456, 1456, 1457, 1457, 1458, 1459, 1459, 1459,

			 1460, 1463, 1465, 1467, 1468, 1471, 1473, 1476, 1478, 1480,
			 1481, 1484, 1486, 1489, 1491, 1494, 1496, 1498, 1499, 1502,
			 1504, 1506, 1507, 1510, 1512, 1514, 1515, 1518, 1520, 1523,
			 1525, 1526, 1526, 1527, 1530, 1532, 1534, 1535, 1538, 1540,
			 1543, 1545, 1548, 1550, 1553, 1555, 1555, yy_Dummy>>,
			1, 147, 800)
		end

	yy_acclist_template: SPECIAL [INTEGER]
			-- Template for `yy_acclist'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 1554)
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
			  174,    5,  173,  174,    1,  173,  174,   11,  118,  173,
			  174,  173,  174,  118,  122,  173,  174,   18,  173,  174,
			  173,  174,  151,  173,  174,   12,  173,  174,   13,  173,
			  174,   34,  118,  173,  174,   33,  118,  173,  174,    9,
			  173,  174,   32,  173,  174,    7,  173,  174,   35,  118,
			  173,  174,  163,  173,  174,  163,  173,  174,   10,  173,
			  174,    8,  173,  174,   39,  118,  173,  174,   37,  118,
			  173,  174,   38,  118,  173,  174,   19,  173,  174,   41,
			  118,  122,  173,  174,  116,  117,  173,  174,  116,  117,

			  173,  174,  116,  117,  173,  174,  116,  117,  173,  174,
			  116,  117,  173,  174,  116,  117,  173,  174,  116,  117,
			  173,  174,  116,  117,  173,  174,  116,  117,  173,  174,
			  116,  117,  173,  174,  116,  117,  173,  174,  116,  117,
			  173,  174,  116,  117,  173,  174,  116,  117,  173,  174,
			  116,  117,  173,  174,  116,  117,  173,  174,  116,  117,
			  173,  174,  116,  117,  173,  174,   16,  173,  174,  118,
			  173,  174,   17,  173,  174,   36,  118,  173,  174,  118,
			  173,  174,  173,  174,  117,  173,  174,  117,  173,  174,
			  117,  173,  174,  117,  173,  174,  117,  173,  174,  117, yy_Dummy>>,
			1, 200, 0)
		end

	yy_acclist_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  173,  174,  117,  173,  174,  117,  173,  174,  117,  173,
			  174,  117,  173,  174,  117,  173,  174,  117,  173,  174,
			  117,  173,  174,  117,  173,  174,  117,  173,  174,  117,
			  173,  174,  117,  173,  174,  117,  173,  174,   14,  173,
			  174,   15,  173,  174,   40,  118,  173,  174,   44,  118,
			  173,  174,   42,  118,  173,  174,   43,  118,  173,  174,
			   47,  173,  174,   48,  173,  174,   46,  118,  173,  174,
			   45,  118,  173,  174,  161,  174,  156,  174,  158,  174,
			  159,  161,  174,  155,  174,  160,  174,  161,  174,    2,
			    3,    1,  118,  118,  162,  162, -153, -327,  118,  122,

			  122,  118,  122,  151,  151,  151,  118,  118,  118,    6,
			  118,   26,  118,   27,  170,  118,   20,  118,   22,  118,
			   23,  118,  170,  163,  169,  169,  169,  169,  169,  169,
			   31,  118,   28,  118,   25,  118,  118,  118,   24,  118,
			   29,  118,   30,  116,  117,  116,  117,  116,  117,  116,
			  117,  116,  117,   53,  116,  117,  116,  117,  117,  117,
			  117,  117,  117,   53,  117,  117,  116,  117,  116,  117,
			  116,  117,  116,  117,  116,  117,  117,  117,  117,  117,
			  117,  116,  117,   63,  116,  117,  117,   63,  117,  116,
			  117,  116,  117,  116,  117,  117,  117,  117,  116,  117, yy_Dummy>>,
			1, 200, 200)
		end

	yy_acclist_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  116,  117,  116,  117,  117,  117,  117,   75,  116,  117,
			  116,  117,  116,  117,   80,  116,  117,   75,  117,  117,
			  117,   80,  117,  116,  117,  116,  117,  117,  117,  116,
			  117,  117,  116,  117,  116,  117,  116,  117,   88,  116,
			  117,  117,  117,  117,   88,  117,  116,  117,  117,  116,
			  117,  117,  116,  117,  116,  117,  116,  117,  117,  117,
			  117,  116,  117,  116,  117,  117,  117,  116,  117,  117,
			  116,  117,  116,  117,  117,  117,  116,  117,  117,  116,
			  117,  117,   21,  118,  118,  118,  161,  156,  157,  161,
			  161,  155,  154,  118,  121,  119, -153,  118,  122,  122,

			  118,  122,  122,  121,  124,  119,  122,  151,  125,  151,
			  151,  151,  151,  151,  151,  151,  151,  151,  151,  151,
			  151,  151,  151,  151,  151,  151,  151,  151,  151,  151,
			  151,  151,   34,  121,   34,  119,   33,  121,   33,  119,
			   32,  118,  170,   35,  121,   35,  119,  118,  118,  118,
			  118,  118,  118,  164,  170,  163,  169,  167,  168,  169,
			  168,  169,  166,  168,  169,  165,  168,  169,  163,  169,
			  169,   39,  121,   39,  119,   28,  118,   28,  118,  118,
			  118,  118,  118,   37,  121,   37,  119,   38,  121,   38,
			  119,  118,  118,  118,  118,   19,   41,  121,  124,  116, yy_Dummy>>,
			1, 200, 400)
		end

	yy_acclist_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  117,  117,  116,  117,  117,  116,  117,   51,  116,  117,
			  117,   51,  117,   52,  116,  117,   52,  117,  116,  117,
			  117,  116,  117,  117,  116,  117,  117,  116,  117,  117,
			  116,  117,  117,  116,  117,  117,  116,  117,  117,  116,
			  117,  116,  117,  116,  117,  117,  117,  117,  116,  117,
			  117,   66,  116,  117,  116,  117,   66,  117,  117,  116,
			  117,  116,  117,  117,  117,  116,  117,  117,  116,  117,
			  117,  116,  117,  117,  116,  117,  117,  116,  117,  116,
			  117,  116,  117,  116,  117,  117,  117,  117,  117,  116,
			  117,  117,  116,  117,  116,  117,  117,  117,   84,  116,

			  117,   84,  117,  116,  117,  117,   86,  116,  117,   86,
			  117,  116,  117,  117,  116,  117,  117,  116,  117,  116,
			  117,  116,  117,  116,  117,  116,  117,  116,  117,  117,
			  117,  117,  117,  117,  117,  116,  117,  116,  117,  117,
			  117,  116,  117,  117,  116,  117,  117,  116,  117,  117,
			  116,  117,  117,  116,  117,  116,  117,  116,  117,  117,
			  117,  117,  116,  117,  117,  116,  117,  117,  116,  117,
			  117,  108,  116,  117,  108,  117,  118,  118,   36,  121,
			   36,  119,  172,  171,   40,  121,   40,  119,   44,  121,
			   42,  121,   43,  121,   47,   48,   46,  121,   45,  121, yy_Dummy>>,
			1, 200, 600)
		end

	yy_acclist_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  120,  118,  120,  123,  118,  122,  123,  124,  142,  140,
			  141,  143,  144,  152,  152,  145,  146,  126,  127,  128,
			  129,  130,  131,  132,  133,  134,  135,  136,  137,  138,
			  139,   26,  121,   26,  119,  170,  170,   20,  121,   20,
			  119,   22,  121,   22,  119,   23,  121,   23,  119,  170,
			  170,  163,  169,  168,  169,  168,  169,  168,  169,  163,
			  169,  163,  169,  118,   28,  121,   28,  118,   28,  118,
			   25,  121,   25,  119,   24,  121,   24,  119,   29,  121,
			  116,  117,  117,  116,  117,  117,  116,  117,  117,  116,
			  117,  117,  116,  117,  116,  117,  117,  117,  116,  117,

			  117,  116,  117,  117,  116,  117,  117,  116,  117,  117,
			  116,  117,  117,  116,  117,  117,  116,  117,  117,  116,
			  117,  117,   64,  116,  117,   64,  117,  116,  117,  117,
			  116,  117,  116,  117,  117,  117,  116,  117,  117,  116,
			  117,  117,  116,  117,  117,   73,  116,  117,  116,  117,
			   73,  117,  117,  116,  117,  117,  116,  117,  117,  116,
			  117,  117,  116,  117,  117,  116,  117,  117,   81,  116,
			  117,   81,  117,  116,  117,  117,   83,  116,  117,   83,
			  117,  113,  116,  117,  113,  117,  116,  117,  117,   87,
			  116,  117,   87,  117,  116,  117,  117,  116,  117,  117, yy_Dummy>>,
			1, 200, 800)
		end

	yy_acclist_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  116,  117,  117,  116,  117,  117,  116,  117,  117,  116,
			  117,  116,  117,  117,  117,  116,  117,  117,  116,  117,
			  117,  116,  117,  117,  114,  116,  117,  114,  117,  116,
			  117,  117,  100,  116,  117,  100,  117,  101,  116,  117,
			  101,  117,  116,  117,  117,  116,  117,  117,  116,  117,
			  117,  116,  117,  117,  106,  116,  117,  106,  117,  107,
			  116,  117,  107,  117,   21,  121,   21,  119,  152,  170,
			  170,  170,  170,  163,  169,   28,  121,   28,  116,  117,
			  117,   49,  116,  117,   49,  117,   50,  116,  117,   50,
			  117,  116,  117,  117,  116,  117,  117,  116,  117,  117,

			   55,  116,  117,   55,  117,   56,  116,  117,   56,  117,
			  116,  117,  117,  116,  117,  117,  116,  117,  117,   61,
			  116,  117,   61,  117,  116,  117,  117,  116,  117,  117,
			  116,  117,  117,  116,  117,  117,  116,  117,  117,  116,
			  117,  117,  116,  117,  117,   71,  116,  117,   71,  117,
			  116,  117,  117,  116,  117,  117,  116,  117,  117,  116,
			  117,  117,  116,  117,  117,  116,  117,  117,  116,  117,
			  117,   82,  116,  117,   82,  117,  116,  117,  117,  116,
			  117,  117,  116,  117,  117,  116,  117,  117,  116,  117,
			  117,  116,  117,  117,  116,  117,  117,  116,  117,  117, yy_Dummy>>,
			1, 200, 1000)
		end

	yy_acclist_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			   96,  116,  117,   96,  117,  116,  117,  117,  116,  117,
			  117,   99,  116,  117,   99,  117,  116,  117,  117,  116,
			  117,  117,  104,  116,  117,  104,  117,  116,  117,  117,
			  147,  170,  170,  170,  109,  116,  117,  109,  117,   54,
			  116,  117,   54,  117,  116,  117,  117,  116,  117,  117,
			  116,  117,  117,   58,  116,  117,  116,  117,   58,  117,
			  117,  116,  117,  117,  116,  117,  117,  116,  117,  117,
			   65,  116,  117,   65,  117,   67,  116,  117,   67,  117,
			  116,  117,  117,   69,  116,  117,   69,  117,  116,  117,
			  117,  116,  117,  117,   74,  116,  117,   74,  117,  116,

			  117,  117,  116,  117,  117,  116,  117,  117,  116,  117,
			  117,  116,  117,  117,  116,  117,  117,  116,  117,  117,
			  116,  117,  117,  116,  117,  117,   92,  116,  117,   92,
			  117,  116,  117,  117,   94,  116,  117,   94,  117,   95,
			  116,  117,   95,  117,   97,  116,  117,   97,  117,  116,
			  117,  117,  116,  117,  117,  103,  116,  117,  103,  117,
			  116,  117,  117,  170,  170,  170,  170,  116,  117,  117,
			  116,  117,  117,   57,  116,  117,   57,  117,  116,  117,
			  117,   60,  116,  117,   60,  117,  116,  117,  117,  116,
			  117,  117,  116,  117,  117,  116,  117,  117,   72,  116, yy_Dummy>>,
			1, 200, 1200)
		end

	yy_acclist_template_8 (an_array: ARRAY [INTEGER])
			-- Fill chunk #8 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  117,   72,  117,   76,  116,  117,   76,  117,  116,  117,
			  117,   77,  116,  117,   77,  117,   78,  116,  117,   78,
			  117,  116,  117,  117,  116,  117,  117,  116,  117,  117,
			  116,  117,  117,  116,  117,  117,   93,  116,  117,   93,
			  117,  116,  117,  117,  116,  117,  117,  105,  116,  117,
			  105,  117,  150,  149,  148,  170,  170,  170,  170,  170,
			  110,  116,  117,  110,  117,  116,  117,  117,   59,  116,
			  117,   59,  117,   62,  116,  117,   62,  117,  116,  117,
			  117,   68,  116,  117,   68,  117,   70,  116,  117,   70,
			  117,  115,  116,  117,  115,  117,  116,  117,  117,   85,

			  116,  117,   85,  117,  116,  117,  117,   91,  116,  117,
			   91,  117,  116,  117,  117,   98,  116,  117,   98,  117,
			  102,  116,  117,  102,  117,  170,  170,  111,  116,  117,
			  111,  117,  116,  117,  117,   79,  116,  117,   79,  117,
			   89,  116,  117,   89,  117,   90,  116,  117,   90,  117,
			  112,  116,  117,  112,  117, yy_Dummy>>,
			1, 155, 1400)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER = 2547
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER = 945
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER = 946
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
