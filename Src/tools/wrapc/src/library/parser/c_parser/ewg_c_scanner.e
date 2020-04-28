note
	description: "Scan C header file for type definitions"
	status: "See notice at end of class"
	author: "Based on http://www.lysator.liu.se/c"
	date: "$Date$"
	revision: "$Revision$"
	info: "Based on: http://www.lysator.liu.se/c"

deferred class EWG_C_SCANNER

inherit

	EWG_C_SCANNER_SKELETON


feature -- Status report

	valid_start_condition (sc: INTEGER): BOOLEAN
			-- Is `sc' a valid start condition?
		do
			Result := (INITIAL <= sc and sc <= SC_GCC_ATTRIBUTE)
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
		end

	yy_execute_action (yy_act: INTEGER)
			-- Execute semantic action.
		do
			inspect yy_act
when 1 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 37 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 37")
end

				set_start_condition (SC_FILE)
				less (0)
			
when 2 then
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 48 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 48")
end
 -- GNU CPP style
				set_header_line_number ((text_substring (3, text_count - 2)).to_integer)
				
when 3 then
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 51 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 51")
end
  -- Visual C++ style
				if (text_substring (7, text_count - 2)).is_integer then
					set_header_line_number ((text_substring (7, text_count - 2)).to_integer)
				elseif (text_substring (11, text_count - 2)).is_integer then
					set_header_line_number ((text_substring (11, text_count - 2)).to_integer)
				else
					set_header_line_number ((text_substring (15, text_count - 2)).to_integer)
				end			
			
when 4 then
	yy_line := yy_line + 1
	yy_column := 1
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 60 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 60")
end
  set_start_condition (INITIAL) 
when 5 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 61 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 61")
end
 set_header_file_name (text) 
when 6 then
	yy_line := yy_line + 1
	yy_column := 1
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 62 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 62")
end
set_start_condition (INITIAL) 
when 7 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 65 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 65")
end

					implementation_bracket_counter := implementation_bracket_counter + 1
				
when 8 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 68 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 68")
end

					implementation_bracket_counter := implementation_bracket_counter - 1
					if implementation_bracket_counter = 0 then
						last_token := Right_brace_code
						last_string_value := text
					end
				
when 9 then
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 76 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 76")
end
 
when 10 then
yy_set_line_column
	yy_position := yy_position + 1
--|#line 78 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 78")
end
 
when 11 then
	yy_column := yy_column + 10
	yy_position := yy_position + 10
--|#line 81 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 81")
end

					check
						msc_declspec_bracket_counter_is_zero: msc_declspec_bracket_counter = 0
					end
					if is_msc_extensions_enabled then
						-- grammar for "__declspec" construct is ambiguos.
						-- we don't need this information -> we ignore it
						-- (now we need to the "(dllimport)" part too)
						set_start_condition (SC_MSC_DECLSPEC)
					else
						report_type_or_identifier (text)
					end
				
when 12 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 94 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 94")
end

				msc_declspec_bracket_counter := msc_declspec_bracket_counter + 1
			
when 13 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 97 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 97")
end

					msc_declspec_bracket_counter := msc_declspec_bracket_counter - 1
					if msc_declspec_bracket_counter = 0 then
						set_start_condition (INITIAL)
					end
			
when 14 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 103 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 103")
end

when 15 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 108 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 108")
end
 last_token := TOK_AUTO; last_string_value := text
when 16 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 109 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 109")
end
 last_token := TOK_BREAK; last_string_value := text 
when 17 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 110 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 110")
end
 last_token := TOK_CASE; last_string_value := text 
when 18 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 111 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 111")
end
 last_token := TOK_CHAR; last_string_value := text 
when 19 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 112 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 112")
end
 last_token := TOK_CONST; last_string_value := text 
when 20 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 113 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 113")
end
 last_token := TOK_CONTINUE; last_string_value := text 
when 21 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 114 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 114")
end
 last_token := TOK_DEFAULT; last_string_value := text 
when 22 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 115 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 115")
end
 last_token := TOK_DO; last_string_value := text 
when 23 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 116 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 116")
end
 last_token := TOK_DOUBLE; last_string_value := text 
when 24 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 117 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 117")
end
 last_token := TOK_ELSE; last_string_value := text 
when 25 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 118 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 118")
end
 last_token := TOK_ENUM; last_string_value := text 
when 26 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 119 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 119")
end
 last_token := TOK_EXTERN; last_string_value := text 
when 27 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 120 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 120")
end
 last_token := TOK_FLOAT; last_string_value := text 
when 28 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 121 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 121")
end
 last_token := TOK_FOR; last_string_value := text 
when 29 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 122 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 122")
end
 last_token := TOK_GOTO; last_string_value := text 
when 30 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 123 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 123")
end
 last_token := TOK_IF; last_string_value := text 
when 31 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 124 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 124")
end
 last_token := TOK_INT; last_string_value := text 
when 32 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 125 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 125")
end
 last_token := TOK_INT; last_string_value := text 
when 33 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 126 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 126")
end
 last_token := TOK_LONG; last_string_value := text 
when 34 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 127 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 127")
end
 last_token := TOK_REGISTER; last_string_value := text 
when 35 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 128 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 128")
end
 last_token := TOK_RETURN; last_string_value := text 
when 36 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 129 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 129")
end
 last_token := TOK_SHORT; last_string_value := text 
when 37 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 130 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 130")
end
 last_token := TOK_SIGNED; last_string_value := text 
when 38 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 131 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 131")
end
 last_token := TOK_SIZEOF; last_string_value := text 
when 39 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 132 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 132")
end
 last_token := TOK_STATIC; last_string_value := text 
when 40 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 133 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 133")
end
 last_token := TOK_INLINE; last_string_value := text 
when 41 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 134 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 134")
end
 last_token := TOK_STRUCT; last_string_value := text 
when 42 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 135 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 135")
end
 last_token := TOK_SWITCH; last_string_value := text 
when 43 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 136 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 136")
end
 last_token := TOK_TYPEDEF; last_string_value := text 
when 44 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 137 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 137")
end
 last_token := TOK_UNION; last_string_value := text 
when 45 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 138 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 138")
end
 last_token := TOK_UNSIGNED; last_string_value := text 
when 46 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 139 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 139")
end
 last_token := TOK_VOID; last_string_value := text 
when 47 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 140 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 140")
end
 last_token := TOK_VOLATILE; last_string_value := text 
when 48 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 141 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 141")
end
 last_token := TOK_WHILE; last_string_value := text 
when 49 then
	yy_column := yy_column + 10
	yy_position := yy_position + 10
--|#line 142 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 142")
end

				-- gcc extension
				last_token := TOK_SIGNED; last_string_value := text 			   
when 50 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 145 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 145")
end

				-- gcc extension MacOs
				last_token := TOK_SIGNED; last_string_value := text 			   
when 51 then
	yy_column := yy_column + 13
	yy_position := yy_position + 13
--|#line 152 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 152")
end
 
when 52 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 155 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 155")
end
 last_token := TOK_CONST; last_string_value := text 
when 53 then
	yy_column := yy_column + 10
	yy_position := yy_position + 10
--|#line 156 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 156")
end
 
when 54 then
	yy_column := yy_column + 13
	yy_position := yy_position + 13
--|#line 158 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 158")
end

				 -- eat, hopefully this thing is not usefull for us
					gcc_attribute_bracket_counter := 0
					set_start_condition (SC_GCC_ATTRIBUTE)
				
when 55 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 164 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 164")
end

				gcc_attribute_bracket_counter := gcc_attribute_bracket_counter + 1
			 
when 56 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 167 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 167")
end

				gcc_attribute_bracket_counter := gcc_attribute_bracket_counter - 1
				if gcc_attribute_bracket_counter = 0 then
					set_start_condition (INITIAL)
				end
			 
when 57 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 173 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 173")
end

when 58 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 175 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 175")
end

when 59 then
	yy_column := yy_column + 10
	yy_position := yy_position + 10
--|#line 177 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 177")
end

when 60 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 180 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 180")
end

					if is_msc_extensions_enabled then
						last_token := TOK_CL_INT_8
						last_string_value := text
					else
						report_type_or_identifier (text)
					end
				
when 61 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 188 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 188")
end

					if is_msc_extensions_enabled then
						last_token := TOK_CL_INT_16
						last_string_value := text
					else
						report_type_or_identifier (text)
					end
				
when 62 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 196 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 196")
end

					if is_msc_extensions_enabled then
						last_token := TOK_CL_INT_32
						last_string_value := text
					else
						report_type_or_identifier (text)
					end
				
when 63 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 204 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 204")
end

					if is_msc_extensions_enabled then
						last_token := TOK_CL_INT_64
						last_string_value := text
					else
						report_type_or_identifier (text)
					end
				
when 64 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 212 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 212")
end

					if is_msc_extensions_enabled then
						-- ignore, we don't need it
					else
						report_type_or_identifier (text)
					end
				
when 65 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 219 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 219")
end

					if is_msc_extensions_enabled then
						-- ignore, we don't need it
					else
						report_type_or_identifier (text)
					end
				
when 66 then
	yy_column := yy_column + 10
	yy_position := yy_position + 10
--|#line 226 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 226")
end

					if is_msc_extensions_enabled then
						last_token := TOK_CL_FASTCALL
						last_string_value := text
					else
						report_type_or_identifier (text)
					end
				
when 67 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 234 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 234")
end

					if is_msc_extensions_enabled then
						-- last_token := TOK_CL_BASED
						-- last_string_value := text
						-- ignore, we don't need it
					else
						report_type_or_identifier (text)
					end
				
when 68 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 243 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 243")
end

					if is_msc_extensions_enabled then
						last_token := TOK_CL_ASM
						last_string_value := text
					else
						-- This is a gcc extension, we ignore it
						gcc_attribute_bracket_counter := 0
						set_start_condition (SC_GCC_ATTRIBUTE)
					end
				
when 69 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 253 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 253")
end

					if is_msc_extensions_enabled then
						-- ignore, we don't need it, it's a gcc extension
					else
						-- This is a gcc extension, we ignore it
						gcc_attribute_bracket_counter := 0
						set_start_condition (SC_GCC_ATTRIBUTE)
					end
				
when 70 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 262 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 262")
end

					if is_msc_extensions_enabled then
						last_token := TOK_CL_ASM
						last_string_value := text
					else
						report_type_or_identifier (text)
					end
				
when 71 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 270 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 270")
end

					if is_msc_extensions_enabled then
						-- last_token := TOK_CL_INLINE
						-- last_string_value := text
						-- ignore, we don't need it
					else
						report_type_or_identifier (text)
					end
				
when 72 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 279 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 279")
end

					if is_msc_extensions_enabled then
						last_token := TOK_CL_CDECL
						last_string_value := text
					else
						report_type_or_identifier (text)
					end
				
when 73 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 287 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 287")
end

					if is_msc_extensions_enabled then
						last_token := TOK_CL_CDECL
						last_string_value := text
					else
						report_type_or_identifier (text)
					end
				
when 74 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line 295 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 295")
end

					if is_msc_extensions_enabled then
						last_token := TOK_CL_STDCALL
						last_string_value := text
					else
						report_type_or_identifier (text)
					end
				
when 75 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 303 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 303")
end

					if is_msc_extensions_enabled then
						last_token := TOK_CL_STDCALL
						last_string_value := text
					else
						report_type_or_identifier (text)
					end
					
when 76 then
	yy_column := yy_column + 12
	yy_position := yy_position + 12
--|#line 311 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 311")
end

					if is_msc_extensions_enabled then
						-- ignore, we don't need it
					else
						report_type_or_identifier (text)
					end
					
when 77 then
	yy_column := yy_column + 13
	yy_position := yy_position + 13
--|#line 318 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 318")
end

					if is_msc_extensions_enabled then
						-- ignore, we don't need it
					else
						report_type_or_identifier (text)
					end
					
when 78 then
	yy_column := yy_column + 11
	yy_position := yy_position + 11
--|#line 325 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 325")
end

					if is_msc_extensions_enabled then
						-- ignore, we don't need it
					else
						report_type_or_identifier (text)
					end
					
when 79 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 333 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 333")
end
 
when 80 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 336 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 336")
end
 report_type_or_identifier (text)	
when 81 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 338 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 338")
end
 last_token := TOK_CONSTANT; last_string_value := text 
when 82 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 339 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 339")
end
 last_token := TOK_CONSTANT; last_string_value := text 
when 83 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 340 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 340")
end
 last_token := TOK_CONSTANT; last_string_value := text 
when 84 then
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 341 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 341")
end
 last_token := TOK_CONSTANT; last_string_value := text 
when 85 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 343 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 343")
end
 last_token := TOK_CONSTANT; last_string_value := text 
when 86 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 344 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 344")
end
 last_token := TOK_CONSTANT; last_string_value := text 
when 87 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 345 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 345")
end
 last_token := TOK_CONSTANT; last_string_value := text 
when 88 then
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 347 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 347")
end
 last_token := TOK_STRING_LITERAL; last_string_value := text 
when 89 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 349 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 349")
end
 last_token := TOK_ELLIPSIS; last_string_value := text 
when 90 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 350 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 350")
end
 last_token := TOK_RIGHT_ASSIGN; last_string_value := text 
when 91 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 351 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 351")
end
 last_token := TOK_LEFT_ASSIGN; last_string_value := text 
when 92 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 352 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 352")
end
 last_token := TOK_ADD_ASSIGN; last_string_value := text 
when 93 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 353 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 353")
end
 last_token := TOK_SUB_ASSIGN; last_string_value := text 
when 94 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 354 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 354")
end
 last_token := TOK_MUL_ASSIGN; last_string_value := text 
when 95 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 355 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 355")
end
 last_token := TOK_DIV_ASSIGN; last_string_value := text 
when 96 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 356 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 356")
end
 last_token := TOK_MOD_ASSIGN; last_string_value := text 
when 97 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 357 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 357")
end
 last_token := TOK_AND_ASSIGN; last_string_value := text 
when 98 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 358 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 358")
end
 last_token := TOK_XOR_ASSIGN; last_string_value := text 
when 99 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 359 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 359")
end
 last_token := TOK_OR_ASSIGN; last_string_value := text 
when 100 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 360 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 360")
end
 last_token := TOK_RIGHT_OP; last_string_value := text 
when 101 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 361 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 361")
end
 last_token := TOK_LEFT_OP; last_string_value := text 
when 102 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 362 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 362")
end
 last_token := TOK_INC_OP; last_string_value := text 
when 103 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 363 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 363")
end
 last_token := TOK_DEC_OP; last_string_value := text 
when 104 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 364 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 364")
end
 last_token := TOK_PTR_OP; last_string_value := text 
when 105 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 365 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 365")
end
 last_token := TOK_AND_OP; last_string_value := text 
when 106 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 366 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 366")
end
 last_token := TOK_OR_OP; last_string_value := text 
when 107 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 367 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 367")
end
 last_token := TOK_LE_OP; last_string_value := text 
when 108 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 368 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 368")
end
 last_token := TOK_GE_OP; last_string_value := text 
when 109 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 369 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 369")
end
 last_token := TOK_EQ_OP; last_string_value := text 
when 110 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 370 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 370")
end
 last_token := TOK_NE_OP; last_string_value := text 
when 111 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 372 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 372")
end
 last_token := Semicolon_code; last_string_value := text
when 112 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 373 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 373")
end
 last_token := Left_brace_code; last_string_value := text 
when 113 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 374 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 374")
end
 last_token := Right_brace_code; last_string_value := text 
when 114 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 375 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 375")
end
 last_token := Comma_code; last_string_value := text 
when 115 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 376 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 376")
end
 last_token := Colon_code; last_string_value := text 
when 116 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 377 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 377")
end
 last_token := Equal_code; last_string_value := text 
when 117 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 378 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 378")
end
 last_token := Left_parenthesis_code; last_string_value := text 
when 118 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 379 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 379")
end
 last_token := Right_parenthesis_code; last_string_value := text 
when 119 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 380 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 380")
end
 last_token := Left_bracket_code; last_string_value := text 
when 120 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 381 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 381")
end
 last_token := Right_bracket_code; last_string_value := text 
when 121 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 382 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 382")
end
 last_token := Dot_code; last_string_value := text 
when 122 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 383 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 383")
end
 last_token := 38; last_string_value := text 
when 123 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 384 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 384")
end
 last_token := Exclamation_code; last_string_value := text 
when 124 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 385 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 385")
end
 last_token := 126; last_string_value := text 
when 125 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 386 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 386")
end
 last_token := Minus_code; last_string_value := text 
when 126 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 387 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 387")
end
 last_token := Plus_code; last_string_value := text 
when 127 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 388 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 388")
end
 last_token := Star_code; last_string_value := text 
when 128 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 389 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 389")
end
 last_token := Slash_code; last_string_value := text 
when 129 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 390 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 390")
end
 last_token := 37; last_string_value := text 
when 130 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 391 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 391")
end
 last_token := Less_than_code; last_string_value := text 
when 131 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 392 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 392")
end
 last_token := Greater_than_code; last_string_value := text 
when 132 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 393 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 393")
end
 last_token := Caret_code; last_string_value := text 
when 133 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 394 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 394")
end
 last_token := Bar_code; last_string_value := text 
when 134 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 395 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 395")
end
 last_token := Question_mark_code; last_string_value := text 
when 135 then
yy_set_line_column
	yy_position := yy_position + 1
--|#line 397 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 397")
end
 
when 136 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 398 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 398")
end
 
when 137 then
yy_set_line_column
	yy_position := yy_position + 1
--|#line 0 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 0")
end
default_action
			else
				last_token := yyError_token
				fatal_error ("fatal scanner internal error: no action found")
			end
			yy_set_beginning_of_line
		end

	yy_execute_eof_action (yy_sc: INTEGER)
			-- Execute EOF semantic action.
		do
			terminate
		end

feature {NONE} -- Table templates

	yy_nxt_template: SPECIAL [INTEGER]
			-- Template for `yy_nxt'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 969)
			yy_nxt_template_1 (an_array)
			yy_nxt_template_2 (an_array)
			yy_nxt_template_3 (an_array)
			yy_nxt_template_4 (an_array)
			yy_nxt_template_5 (an_array)
			an_array.area.fill_with (472, 897, 969)
			Result := yy_fixed_array (an_array)
		end

	yy_nxt_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			    0,   13,   14,   13,   15,   16,   12,   17,   18,   19,
			   20,   21,   22,   23,   24,   25,   26,   27,   28,   29,
			   29,   29,   29,   29,   29,   29,   30,   31,   32,   33,
			   34,   35,   36,   36,   36,   36,   36,   37,   36,   36,
			   38,   12,   39,   40,   41,   42,   43,   44,   45,   46,
			   47,   48,   36,   49,   36,   50,   36,   36,   36,   36,
			   51,   52,   53,   54,   55,   56,   36,   36,   36,   57,
			   58,   59,   60,   12,   61,  471,   64,   65,   84,   62,
			   66,   67,   64,   65,   65,   93,   66,   67,   70,   70,
			   71,   71,   77,   78,   65,   88,   65,  470,   65,   86,

			   87,   94,   77,   78,   80,   81,   80,   81,   95,  113,
			  114,   72,   72,   83,   85,  108,   89,  116,  469,   68,
			   73,   73,   96,   97,   98,   68,   99,   99,   99,   99,
			   99,   99,   99,   99,  109,  127,  110,  111,  130,  132,
			  135,  133,  128,  136,  138,  150,  359,  131,  129,  360,
			  134,  139,   74,   74,   75,   75,  101,  157,  102,  102,
			  102,  102,  102,  102,  102,  102,  152,  468,  165,   84,
			  118,  153,  163,  472,  103,  142,  143,  104,  104,  105,
			   90,  119,  120,  216,  121,  144,  151,  122,  145,  103,
			  123,  155,  169,  221,  217,  104,  156,  152,  124,  160, yy_Dummy>>,
			1, 200, 0)
		end

	yy_nxt_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  161,  160,  153,  104,  166,   85,  105,  101,  222,  106,
			  106,  106,  106,  106,  106,  106,  106,  104,  104,  213,
			  219,  227,  225,  228,   91,  103,  214,  155,  104,  104,
			  226,  246,  156,  157,  157,  104,  165,  220,  243,  244,
			  103,  247,  250,  104,  268,  269,  104,  255,  163,  467,
			  160,  161,  160,  162,  104,  251,  256,  163,   99,   99,
			   99,   99,   99,   99,   99,   99,  161,  161,  161,  466,
			  157,  465,  166,  309,  171,  172,  177,  172,  177,  464,
			  310,  178,  178,  178,  178,  178,  178,  178,  178,  171,
			  172,  176,  176,  463,  462,  172,  173,  173,  173,  173,

			  173,  173,  173,  173,  162,  294,  294,  294,  163,  176,
			  461,  460,  174,  175,  234,  175,  234,  176,  459,  235,
			  235,  235,  235,  235,  235,  235,  235,  174,  175,  236,
			  237,  458,  237,  175,  101,  457,  102,  102,  102,  102,
			  102,  102,  102,  102,  236,  237,  384,  385,  384,  456,
			  237,  240,  103,  240,  455,  176,  176,  178,  178,  178,
			  178,  178,  178,  178,  178,  454,  240,  103,  293,  294,
			  293,  240,  342,  176,  453,  241,  241,  385,  385,  385,
			  452,  176,  183,  184,  185,  186,  187,  188,  451,  355,
			  189,  356,  450,  241,  357,  358,  190,  191,  192,  436, yy_Dummy>>,
			1, 200, 200)
		end

	yy_nxt_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  193,  241,  194,  160,  161,  160,  238,  436,  238,  448,
			  437,  239,  239,  239,  239,  239,  239,  239,  239,  447,
			  230,  230,  230,  230,  230,  230,  230,  230,  293,  294,
			  293,  235,  235,  235,  235,  235,  235,  235,  235,  172,
			  446,  172,  435,  435,  435,  230,  230,  230,  230,  230,
			  230,  230,  230,  445,  172,  297,  444,  297,  443,  172,
			  298,  298,  298,  298,  298,  298,  298,  298,  239,  239,
			  239,  239,  239,  239,  239,  239,  175,  442,  175,  241,
			  241,  294,  294,  294,  237,  342,  237,  441,  434,  435,
			  434,  175,  449,  179,  179,  179,  175,  241,  178,  237,

			  178,  440,  178,  439,  237,  241,  298,  298,  298,  298,
			  298,  298,  298,  298,  384,  385,  384,  435,  435,  435,
			  438,  449,  115,  115,  115,  115,  115,  433,  432,  431,
			  430,  415,  415,  415,  415,  415,  415,  415,  415,  434,
			  435,  434,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,  429,  428,  427,  426,  415,  415,  415,  415,
			  415,  415,  415,  415,   69,   69,   69,   69,   69,   69,
			   69,   69,   69,   69,   76,   76,   76,   76,   76,   76,
			   76,   76,   76,   76,   79,   79,   79,   79,   79,   79,
			   79,   79,   79,   79,   83,   83,   83,   83,   83,   83, yy_Dummy>>,
			1, 200, 400)
		end

	yy_nxt_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			   83,   83,   83,   83,   90,   90,   90,  425,   90,   90,
			   90,   90,   90,   90,  153,  424,  153,  153,  153,  153,
			  153,  153,  153,  153,  154,  423,  422,  154,  154,  154,
			  154,  154,  154,  154,  158,  158,  158,  158,  158,  158,
			  158,  158,  158,  158,  164,  164,  164,  164,  164,  164,
			  164,  164,  164,  164,  231,  231,  421,  235,  231,  235,
			  239,  235,  239,  298,  239,  298,  420,  298,  416,  416,
			  419,  418,  416,  417,  417,  417,  417,  417,  417,  417,
			  417,  417,  417,  437,  437,  437,  437,  437,  437,  437,
			  437,  437,  437,  417,  414,  413,  412,  411,  410,  409,

			  408,  407,  406,  405,  404,  403,  402,  401,  400,  399,
			  398,  397,  396,  395,  394,  393,  392,  391,  390,  389,
			  388,  387,  386,  383,  382,  381,  380,  379,  378,  377,
			  376,  375,  374,  373,  372,  371,  370,  369,  368,  367,
			  366,  365,  364,  363,  362,  361,  354,  353,  352,  351,
			  350,  349,  348,  347,  346,  345,  344,  343,  341,  340,
			  339,  338,  337,  336,  335,  334,  333,  332,  331,  330,
			  329,  328,  327,  326,  325,  324,  323,  322,  321,  320,
			  319,  318,  317,  316,  315,  314,  313,  312,  311,  308,
			  307,  306,  305,  304,  303,  302,  301,  300,  299,  296, yy_Dummy>>,
			1, 200, 600)
		end

	yy_nxt_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  295,  292,  291,  290,  289,  288,  287,  286,  285,  284,
			  283,  282,  281,  280,  279,  278,  277,  276,  275,  274,
			  273,  272,  271,  270,  267,  266,  265,  264,  263,  262,
			  261,  260,  259,  258,  257,  254,  253,  252,  249,  248,
			  245,  242,  472,  233,  232,  159,  229,  224,  223,  218,
			  215,  212,  211,  210,  209,  208,  207,  206,  205,  204,
			  203,  202,  201,  200,  199,  198,  197,  196,  195,  182,
			   91,  181,  180,  170,  472,  164,  168,  167,  159,  149,
			  148,  147,  146,  141,  140,  137,  126,  125,  117,  112,
			  107,  100,   92,   91,   82,  472,   11, yy_Dummy>>,
			1, 97, 800)
		end

	yy_chk_template: SPECIAL [INTEGER]
			-- Template for `yy_chk'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 969)
			an_array.put (0, 0)
			an_array.area.fill_with (1, 1, 73)
			yy_chk_template_1 (an_array)
			yy_chk_template_2 (an_array)
			yy_chk_template_3 (an_array)
			yy_chk_template_4 (an_array)
			yy_chk_template_5 (an_array)
			an_array.area.fill_with (472, 896, 969)
			Result := yy_fixed_array (an_array)
		end

	yy_chk_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			    2,  467,    3,    3,   16,    2,    3,    3,    4,    4,
			    7,   23,    4,    4,    5,    6,    5,    6,    7,    7,
			    8,   18,    9,  466,   10,   17,   17,   23,    8,    8,
			    9,    9,   10,   10,   25,   34,   34,    5,    6,   37,
			   16,   32,   18,   37,  465,    3,    5,    6,   25,   25,
			   26,    4,   26,   26,   26,   26,   26,   26,   26,   26,
			   32,   44,   32,   32,   45,   46,   47,   46,   44,   47,
			   49,   58,  311,   45,   44,  311,   46,   49,    5,    6,
			    5,    6,   28,   68,   28,   28,   28,   28,   28,   28,
			   28,   28,   61,  464,   70,   83,   41,   61,   68,   91,

			   28,   52,   52,   28,   28,   28,   91,   41,   41,  141,
			   41,   52,   58,   41,   52,   28,   41,   64,   90,  144,
			  141,   28,   64,  152,   41,   67,   67,   67,  152,   28,
			   70,   83,   28,   29,  144,   29,   29,   29,   29,   29,
			   29,   29,   29,  104,  104,  139,  143,  148,  147,  148,
			   90,   29,  139,  155,   29,   29,  147,  185,  155,  157,
			   64,  104,  164,  143,  183,  183,   29,  185,  188,  104,
			  204,  204,   29,  192,  157,  462,  156,  156,  156,   67,
			   29,  188,  192,   67,   99,   99,   99,   99,   99,   99,
			   99,   99,  161,  161,  161,  461,  155,  460,  164,  252, yy_Dummy>>,
			1, 200, 74)
		end

	yy_chk_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			   99,   99,  103,   99,  103,  459,  252,  103,  103,  103,
			  103,  103,  103,  103,  103,   99,   99,  176,  176,  458,
			  454,   99,  101,  101,  101,  101,  101,  101,  101,  101,
			  156,  231,  231,  231,  156,  176,  452,  450,  101,  101,
			  171,  101,  171,  176,  448,  171,  171,  171,  171,  171,
			  171,  171,  171,  101,  101,  173,  173,  447,  173,  101,
			  102,  445,  102,  102,  102,  102,  102,  102,  102,  102,
			  173,  173,  343,  343,  343,  444,  173,  178,  102,  178,
			  443,  102,  102,  177,  177,  177,  177,  177,  177,  177,
			  177,  442,  178,  102,  293,  293,  293,  178,  293,  102,

			  441,  179,  179,  385,  385,  385,  440,  102,  119,  119,
			  119,  119,  119,  119,  439,  310,  119,  310,  438,  179,
			  310,  310,  119,  119,  119,  437,  119,  179,  119,  160,
			  160,  160,  174,  417,  174,  428,  417,  174,  174,  174,
			  174,  174,  174,  174,  174,  427,  160,  160,  160,  160,
			  160,  160,  160,  160,  230,  230,  230,  234,  234,  234,
			  234,  234,  234,  234,  234,  235,  426,  235,  416,  416,
			  416,  230,  230,  230,  230,  230,  230,  230,  230,  425,
			  235,  236,  424,  236,  423,  235,  236,  236,  236,  236,
			  236,  236,  236,  236,  238,  238,  238,  238,  238,  238, yy_Dummy>>,
			1, 200, 274)
		end

	yy_chk_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  238,  238,  239,  422,  239,  241,  241,  294,  294,  294,
			  298,  294,  298,  421,  434,  434,  434,  239,  434,  484,
			  484,  484,  239,  241,  486,  298,  486,  420,  486,  419,
			  298,  241,  297,  297,  297,  297,  297,  297,  297,  297,
			  384,  384,  384,  435,  435,  435,  418,  435,  479,  479,
			  479,  479,  479,  414,  413,  411,  409,  384,  384,  384,
			  384,  384,  384,  384,  384,  415,  415,  415,  473,  473,
			  473,  473,  473,  473,  473,  473,  473,  473,  408,  406,
			  405,  404,  415,  415,  415,  415,  415,  415,  415,  415,
			  474,  474,  474,  474,  474,  474,  474,  474,  474,  474,

			  475,  475,  475,  475,  475,  475,  475,  475,  475,  475,
			  476,  476,  476,  476,  476,  476,  476,  476,  476,  476,
			  477,  477,  477,  477,  477,  477,  477,  477,  477,  477,
			  478,  478,  478,  403,  478,  478,  478,  478,  478,  478,
			  480,  402,  480,  480,  480,  480,  480,  480,  480,  480,
			  481,  396,  395,  481,  481,  481,  481,  481,  481,  481,
			  482,  482,  482,  482,  482,  482,  482,  482,  482,  482,
			  483,  483,  483,  483,  483,  483,  483,  483,  483,  483,
			  485,  485,  394,  487,  485,  487,  488,  487,  488,  489,
			  488,  489,  393,  489,  490,  490,  392,  388,  490,  491, yy_Dummy>>,
			1, 200, 474)
		end

	yy_chk_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  491,  491,  491,  491,  491,  491,  491,  491,  491,  492,
			  492,  492,  492,  492,  492,  492,  492,  492,  492,  386,
			  383,  382,  381,  374,  370,  369,  368,  367,  366,  364,
			  363,  362,  361,  360,  359,  357,  356,  355,  354,  353,
			  352,  351,  350,  349,  348,  347,  346,  345,  344,  340,
			  339,  337,  336,  335,  334,  333,  332,  330,  329,  328,
			  326,  325,  324,  323,  320,  319,  318,  317,  315,  314,
			  313,  312,  309,  308,  307,  306,  305,  304,  303,  302,
			  301,  300,  296,  295,  292,  291,  289,  288,  287,  286,
			  285,  284,  283,  282,  281,  280,  279,  277,  275,  274,

			  271,  270,  269,  268,  265,  263,  262,  261,  260,  258,
			  257,  256,  255,  254,  253,  251,  250,  249,  248,  247,
			  246,  245,  244,  243,  242,  233,  232,  229,  228,  227,
			  226,  225,  224,  223,  222,  221,  220,  219,  218,  217,
			  216,  215,  213,  212,  210,  209,  208,  207,  206,  205,
			  203,  202,  201,  200,  199,  198,  197,  196,  195,  194,
			  193,  191,  190,  189,  187,  186,  184,  182,  166,  163,
			  162,  158,  149,  146,  145,  142,  140,  137,  136,  135,
			  134,  133,  132,  131,  130,  129,  128,  127,  126,  125,
			  124,  123,  122,  121,  120,  118,  116,  114,  110,   98, yy_Dummy>>,
			1, 200, 674)
		end

	yy_chk_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			   85,   73,   72,   71,   66,   56,   55,   54,   53,   51,
			   50,   48,   43,   42,   40,   33,   30,   27,   22,   19,
			   15,   11, yy_Dummy>>,
			1, 22, 874)
		end

	yy_base_template: SPECIAL [INTEGER]
			-- Template for `yy_base'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 492)
			yy_base_template_1 (an_array)
			yy_base_template_2 (an_array)
			yy_base_template_3 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_base_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			    0,    0,   73,   75,   81,   83,   84,   82,   92,   94,
			   96,  895,  896,  896,  896,  865,   73,   70,   87,  852,
			  896,  896,  863,   72,  896,   93,  108,  862,  140,  191,
			  860,  896,  108,  860,   80,  896,    0,  108,  896,  896,
			  859,  137,  824,  826,   90,   89,   84,   85,  827,   94,
			  826,  834,  123,  815,  824,  822,  827,  896,  116,  896,
			  896,  165,    0,    0,  190,  896,  876,  198,  113,  896,
			  163,  847,  869,  870,  896,  896,  896,  896,  896,  896,
			  896,  896,  896,  164,  896,  872,  896,  896,  896,  896,
			  183,  171,  896,  896,  896,  896,  896,  896,  857,  240,

			  896,  278,  318,  263,  180,    0,    0,  896,  896,  896,
			  843,  896,  896,  896,  842,    0,  829,  896,  811,  337,
			  807,  819,  808,  808,  802,  801,  813,  800,  815,  802,
			  808,  794,  795,  792,  792,  795,  792,  789,    0,  164,
			  793,  132,  791,  169,  148,  795,  788,  169,  168,  793,
			  896,  896,  196,    0,    0,  226,  249,  189,  843,  896,
			  402,  265,  791,  783,  231,  896,  840,  896,  896,  896,
			  896,  301,  896,  295,  393,  896,  254,  339,  316,  338,
			  896,  896,  783,  177,  795,  183,  790,  772,  197,  780,
			  774,  786,  194,  777,  809,  776,  782,  770,  774,  780, yy_Dummy>>,
			1, 200, 0)
		end

	yy_base_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			  769,  781,  776,  764,  183,  778,  776,  772,  764,  770,
			  773,    0,  759,  763,    0,  764,  761,  750,  752,  754,
			  761,  747,  745,  745,  757,  747,  751,  755,  757,  746,
			  427,  304,  743,  754,  413,  404,  442,  896,  450,  441,
			  896,  442,  743,  741,  734,  734,  745,  736,  745,  729,
			  729,  729,  218,  728,  726,  735,  737,  739,  761,    0,
			  735,  734,  727,  732,    0,  724,    0,    0,  715,  723,
			  712,  719,    0,    0,  713,  710,    0,  714,    0,  709,
			  709,  706,  718,  708,  712,  717,  716,  714,  704,  709,
			    0,  697,  709,  367,  480,  708,  705,  488,  449,    0,

			  711,  694,  704,  705,  690,  695,  700,  686,  700,  693,
			  370,  125,  683,  687,  696,  687,    0,  686,  691,  682,
			  693,    0,    0,  680,  681,  686,  677,    0,  684,  670,
			  674,    0,  682,  679,  681,  665,  674,  676,    0,  667,
			  670,    0,  896,  345,  666,  677,  667,  671,  663,  655,
			  655,  658,  667,  664,  655,  687,  690,  687,    0,  688,
			  685,  646,  656,  659,  650,    0,  649,  652,  645,  636,
			  636,    0,    0,    0,  648,    0,    0,    0,    0,    0,
			    0,  646,  646,  639,  513,  376,  648,    0,  625,    0,
			    0,    0,  611,  605,  611,  573,  576,    0,    0,    0, yy_Dummy>>,
			1, 200, 200)
		end

	yy_base_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			    0,    0,  562,  559,  500,  503,  496,    0,  497,  481,
			    0,  469,    0,  480,  478,  538,  441,  405,  457,  454,
			  448,  432,  420,  414,  409,  409,  385,  362,  354,    0,
			    0,    0,    0,    0,  487,  516,  896,  397,  330,  341,
			  322,  319,  310,  310,  287,  291,    0,  282,  265,  896,
			  262,    0,  253,    0,  241,    0,    0,    0,  245,  222,
			  227,  225,  192,    0,  118,   74,   53,   26,    0,    0,
			    0,    0,  896,  541,  563,  573,  583,  593,  603,  517,
			  613,  623,  633,  643,  488,  653,  493,  652,  655,  658,
			  667,  672,  682, yy_Dummy>>,
			1, 93, 400)
		end

	yy_def_template: SPECIAL [INTEGER]
			-- Template for `yy_def'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 492)
			yy_def_template_1 (an_array)
			an_array.area.fill_with (479, 118, 149)
			yy_def_template_2 (an_array)
			an_array.area.fill_with (479, 182, 229)
			yy_def_template_3 (an_array)
			an_array.area.fill_with (479, 242, 292)
			yy_def_template_4 (an_array)
			an_array.area.fill_with (479, 299, 341)
			yy_def_template_5 (an_array)
			an_array.area.fill_with (479, 345, 383)
			yy_def_template_6 (an_array)
			an_array.area.fill_with (479, 387, 414)
			yy_def_template_7 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_def_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			    0,  472,    1,  473,  473,  474,  474,  475,  475,  476,
			  476,  472,  472,  472,  472,  472,  477,  472,  472,  478,
			  472,  472,  472,  472,  472,  472,  472,  472,  472,  472,
			  472,  472,  472,  472,  472,  472,  479,  479,  472,  472,
			  472,  479,  479,  479,  479,  479,  479,  479,  479,  479,
			  479,  479,  479,  479,  479,  479,  479,  472,  472,  472,
			  472,  472,  480,  481,  481,  472,  482,  481,  481,  472,
			  483,  472,  472,  472,  472,  472,  472,  472,  472,  472,
			  472,  472,  472,  477,  472,  477,  472,  472,  472,  472,
			  478,  478,  472,  472,  472,  472,  472,  472,  472,  472,

			  472,  472,  472,  472,  472,  484,   29,  472,  472,  472,
			  472,  472,  472,  472,  472,  479,  478,  472, yy_Dummy>>,
			1, 118, 0)
		end

	yy_def_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  472,  472,  472,  480,  481,  481,  481,  481,  482,  472,
			  481,  485,  481,  481,  483,  472,  483,  472,  472,  472,
			  472,  472,  472,  101,  472,  472,  472,  472,  486,  484,
			  472,  472, yy_Dummy>>,
			1, 32, 150)
		end

	yy_def_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  481,  485,  481,  481,  472,  487,  472,  472,  472,  488,
			  472,  472, yy_Dummy>>,
			1, 12, 230)
		end

	yy_def_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  481,  472,  481,  481,  472,  489, yy_Dummy>>,
			1, 6, 293)
		end

	yy_def_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  472,  481,  481, yy_Dummy>>,
			1, 3, 342)
		end

	yy_def_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  481,  490,  481, yy_Dummy>>,
			1, 3, 384)
		end

	yy_def_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  481,  490,  491,  479,  479,  479,  479,  479,  479,  479,
			  479,  479,  479,  479,  479,  479,  479,  479,  479,  481,
			  472,  472,  492,  479,  479,  479,  479,  479,  479,  479,
			  479,  479,  479,  479,  472,  479,  479,  479,  479,  479,
			  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,
			  479,  479,  479,  479,  479,  479,  479,    0,  472,  472,
			  472,  472,  472,  472,  472,  472,  472,  472,  472,  472,
			  472,  472,  472,  472,  472,  472,  472,  472, yy_Dummy>>,
			1, 78, 415)
		end

	yy_ec_template: SPECIAL [INTEGER]
			-- Template for `yy_ec'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 257)
			yy_ec_template_1 (an_array)
			an_array.area.fill_with (73, 127, 257)
			Result := yy_fixed_array (an_array)
		end

	yy_ec_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			    0,   73,   73,   73,   73,   73,   73,   73,   73,    1,
			    2,   73,    3,    3,   73,   73,   73,   73,   73,   73,
			   73,   73,   73,   73,   73,   73,   73,   73,   73,   73,
			   73,   73,    1,    4,    5,    6,   73,    7,    8,    9,
			   10,   11,   12,   13,   14,   15,   16,   17,   18,   19,
			   20,   21,   22,   23,   24,   23,   25,   23,   26,   27,
			   28,   29,   30,   31,   73,   32,   33,   32,   32,   34,
			   35,   36,   36,   36,   36,   36,   37,   36,   36,   36,
			   36,   36,   36,   36,   36,   38,   36,   36,   39,   36,
			   36,   40,   41,   42,   43,   44,   73,   45,   46,   47,

			   48,   49,   50,   51,   52,   53,   36,   54,   55,   56,
			   57,   58,   59,   36,   60,   61,   62,   63,   64,   65,
			   66,   67,   68,   69,   70,   71,   72, yy_Dummy>>,
			1, 127, 0)
		end

	yy_meta_template: SPECIAL [INTEGER]
			-- Template for `yy_meta'
		once
			Result := yy_fixed_array (<<
			    0,    1,    2,    1,   10,    3,   10,   10,   10,    4,
			   10,   10,   10,   10,   10,   10,   10,   10,    5,    5,
			    5,    5,    5,    5,    5,    5,   10,   10,   10,   10,
			   10,   10,    6,    6,    6,    7,    8,    9,    8,    8,
			   10,   10,   10,   10,    8,    6,    6,    6,    6,    6,
			    7,    8,    8,    8,    8,    9,    8,    8,    8,    8,
			    8,    8,    8,    8,    8,    8,    8,    8,    8,   10,
			   10,   10,   10,   10, yy_Dummy>>)
		end

	yy_accept_template: SPECIAL [INTEGER]
			-- Template for `yy_accept'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 472)
			yy_accept_template_1 (an_array)
			an_array.area.fill_with (80, 182, 210)
			yy_accept_template_2 (an_array)
			yy_accept_template_3 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_accept_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,  138,  136,  135,  135,  123,  136,  129,  122,  136,
			  117,  118,  127,  126,  114,  125,  121,  128,   83,   83,
			  115,  111,  130,  116,  131,  134,   80,   80,  119,  120,
			  132,   80,   80,   80,   80,   80,   80,   80,   80,   80,
			   80,   80,   80,   80,   80,   80,   80,  112,  133,  113,
			  124,  135,    1,    5,    5,  137,  137,    5,    5,   10,
			   10,   10,   10,   10,    7,    8,   14,   12,   13,   57,
			   55,   56,  110,    0,   88,    0,   96,  113,  105,   97,
			    0,    0,   94,  102,   92,  103,   93,  104,    0,   86,

			   95,   87,   82,    0,   83,    0,   83,  120,  112,  119,
			  101,  107,  109,  108,  100,   80,    0,   98,   80,   80,
			   80,   80,   80,   80,   80,   80,   80,   80,   80,   80,
			   80,   22,   80,   80,   80,   80,   80,   80,   30,   80,
			   80,   80,   80,   80,   80,   80,   80,   80,   80,   80,
			   99,  106,    0,    1,    5,    5,    5,    5,    0,    6,
			    5,    0,    5,    5,    0,    9,    0,    8,    7,   84,
			   89,    0,   86,   86,    0,   87,   82,    0,   85,   81,
			   91,   90, yy_Dummy>>,
			1, 182, 0)
		end

	yy_accept_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			   28,   80,   80,   31,   80,   80,   80,   80,   80,   80,
			   80,   80,   80,   80,   80,   80,   80,   80,   80,    5,
			    0,    5,    5,    0,   86,    0,   86,    0,   87,   85,
			   81,   80,   80,   80,   80,   80,   80,   80,   80,   80,
			   80,   80,   80,   80,   80,   80,   80,   80,   70,   80,
			   80,   80,   80,   15,   80,   17,   18,   80,   80,   80,
			   80,   24,   25,   80,   80,   29,   80,   33,   80,   80,
			   80,   80,   80,   80,   80,   80,   80,   80,   80,   46,
			   80,   80,    5,    0,    5,    5,    0,   86,   32,   68,
			   80,   80,   80,   80,   80,   80,   80,   80,   80,   80,

			   80,   80,   80,   80,   80,   79,   80,   80,   80,   80,
			   16,   19,   80,   80,   80,   80,   27,   80,   80,   80,
			   36,   80,   80,   80,   80,   80,   80,   44,   80,   80,
			   48,    2,    5,    5,   80,   80,   80,   80,   80,   80,
			   80,   80,   80,   80,   80,   80,   80,   60,   80,   80,
			   80,   80,   80,   80,   73,   80,   80,   80,   80,   80,
			   23,   26,   40,   80,   35,   37,   38,   39,   41,   42,
			   80,   80,   80,    5,    0,    5,   69,   80,   67,   72,
			   52,   80,   80,   80,   80,   80,   61,   62,   63,   64,
			   65,   80,   80,   80,   80,   80,   71,   80,   80,   21, yy_Dummy>>,
			1, 200, 211)
		end

	yy_accept_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			   80,   43,   80,   80,    5,    0,    5,   80,   80,   80,
			   80,   80,   58,   80,   50,   80,   80,   80,   75,   20,
			   34,   45,   47,    5,    0,    4,    0,   80,   80,   80,
			   80,   80,   80,   80,   80,   74,   80,   80,    3,   80,
			   11,   80,   66,   80,   59,   53,   49,   80,   80,   80,
			   80,   80,   78,   80,   80,   80,   80,   76,   54,   51,
			   77,    0, yy_Dummy>>,
			1, 62, 411)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER = 896
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER = 472
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER = 473
			-- Mark between normal states and templates

	yyNull_equiv_class: INTEGER = 73
			-- Equivalence code for NULL character

	yyMax_symbol_equiv_class: INTEGER = 256
			-- All symbols greater than this symbol will have
			-- the same equivalence class as this symbol

	yyReject_used: BOOLEAN = false
			-- Is `reject' called?

	yyVariable_trail_context: BOOLEAN = false
			-- Is there a regular expression with
			-- both leading and trailing parts having
			-- variable length?

	yyReject_or_variable_trail_context: BOOLEAN = false
			-- Is `reject' called or is there a
			-- regular expression with both leading
			-- and trailing parts having variable length?

	yyNb_rules: INTEGER = 137
			-- Number of rules

	yyEnd_of_buffer: INTEGER = 138
			-- End of buffer rule code

	yyLine_used: BOOLEAN = true
			-- Are line and column numbers used?

	yyPosition_used: BOOLEAN = true
			-- Is `position' used?

	INITIAL: INTEGER = 0
	SC_FILE: INTEGER = 1
	SC_IMPL: INTEGER = 2
	SC_MSC_DECLSPEC: INTEGER = 3
	SC_GCC_ATTRIBUTE: INTEGER = 4
			-- Start condition codes

feature -- User-defined features


feature
end
