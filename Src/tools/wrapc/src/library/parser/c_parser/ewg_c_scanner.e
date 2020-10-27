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
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 125 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 125")
end
 last_token := TOK_INT; last_string_value := text 
when 33 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 126 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 126")
end
 last_token := TOK_INT; last_string_value := text 
when 34 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 127 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 127")
end
 last_token := TOK_LONG; last_string_value := text 
when 35 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 128 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 128")
end
 last_token := TOK_REGISTER; last_string_value := text 
when 36 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 129 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 129")
end
 last_token := TOK_RETURN; last_string_value := text 
when 37 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 130 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 130")
end
 last_token := TOK_SHORT; last_string_value := text 
when 38 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 131 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 131")
end
 last_token := TOK_SIGNED; last_string_value := text 
when 39 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 132 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 132")
end
 last_token := TOK_SIZEOF; last_string_value := text 
when 40 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 133 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 133")
end
 last_token := TOK_STATIC; last_string_value := text 
when 41 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 134 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 134")
end
 last_token := TOK_INLINE; last_string_value := text 
when 42 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 135 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 135")
end
 last_token := TOK_STRUCT; last_string_value := text 
when 43 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 136 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 136")
end
 last_token := TOK_SWITCH; last_string_value := text 
when 44 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 137 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 137")
end
 last_token := TOK_TYPEDEF; last_string_value := text 
when 45 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 138 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 138")
end
 last_token := TOK_UNION; last_string_value := text 
when 46 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 139 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 139")
end
 last_token := TOK_UNSIGNED; last_string_value := text 
when 47 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 140 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 140")
end
 last_token := TOK_VOID; last_string_value := text 
when 48 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 141 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 141")
end
 last_token := TOK_VOLATILE; last_string_value := text 
when 49 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 142 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 142")
end
 last_token := TOK_WHILE; last_string_value := text 
when 50 then
	yy_column := yy_column + 10
	yy_position := yy_position + 10
--|#line 143 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 143")
end

				-- gcc extension
				last_token := TOK_SIGNED; last_string_value := text 			   
when 51 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 146 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 146")
end

				-- gcc extension MacOs
				last_token := TOK_SIGNED; last_string_value := text 			   
when 52 then
	yy_column := yy_column + 13
	yy_position := yy_position + 13
--|#line 153 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 153")
end
 
when 53 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 156 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 156")
end
 last_token := TOK_CONST; last_string_value := text 
when 54 then
	yy_column := yy_column + 10
	yy_position := yy_position + 10
--|#line 157 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 157")
end
 
when 55 then
	yy_column := yy_column + 13
	yy_position := yy_position + 13
--|#line 159 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 159")
end

				 -- eat, hopefully this thing is not usefull for us
					gcc_attribute_bracket_counter := 0
					set_start_condition (SC_GCC_ATTRIBUTE)
				
when 56 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 165 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 165")
end

				gcc_attribute_bracket_counter := gcc_attribute_bracket_counter + 1
			 
when 57 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 168 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 168")
end

				gcc_attribute_bracket_counter := gcc_attribute_bracket_counter - 1
				if gcc_attribute_bracket_counter = 0 then
					set_start_condition (INITIAL)
				end
			 
when 58 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 174 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 174")
end

when 59 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 176 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 176")
end

when 60 then
	yy_column := yy_column + 10
	yy_position := yy_position + 10
--|#line 178 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 178")
end

when 61 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 181 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 181")
end

					if is_msc_extensions_enabled then
						last_token := TOK_CL_INT_8
						last_string_value := text
					else
						report_type_or_identifier (text)
					end
				
when 62 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 189 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 189")
end

					if is_msc_extensions_enabled then
						last_token := TOK_CL_INT_16
						last_string_value := text
					else
						report_type_or_identifier (text)
					end
				
when 63 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 197 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 197")
end

					if is_msc_extensions_enabled then
						last_token := TOK_CL_INT_32
						last_string_value := text
					else
						report_type_or_identifier (text)
					end
				
when 64 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 205 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 205")
end

					if is_msc_extensions_enabled then
						last_token := TOK_CL_INT_64
						last_string_value := text
					else
						report_type_or_identifier (text)
					end
				
when 65 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 213 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 213")
end

					if is_msc_extensions_enabled then
						-- ignore, we don't need it
					else
						report_type_or_identifier (text)
					end
				
when 66 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 220 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 220")
end

					if is_msc_extensions_enabled then
						-- ignore, we don't need it
					else
						report_type_or_identifier (text)
					end
				
when 67 then
	yy_column := yy_column + 10
	yy_position := yy_position + 10
--|#line 227 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 227")
end

					if is_msc_extensions_enabled then
						last_token := TOK_CL_FASTCALL
						last_string_value := text
					else
						report_type_or_identifier (text)
					end
				
when 68 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 235 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 235")
end

					if is_msc_extensions_enabled then
						-- last_token := TOK_CL_BASED
						-- last_string_value := text
						-- ignore, we don't need it
					else
						report_type_or_identifier (text)
					end
				
when 69 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 244 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 244")
end

					if is_msc_extensions_enabled then
						last_token := TOK_CL_ASM
						last_string_value := text
					else
						-- This is a gcc extension, we ignore it
						gcc_attribute_bracket_counter := 0
						set_start_condition (SC_GCC_ATTRIBUTE)
					end
				
when 70 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 254 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 254")
end

					if is_msc_extensions_enabled then
						-- ignore, we don't need it, it's a gcc extension
					else
						-- This is a gcc extension, we ignore it
						gcc_attribute_bracket_counter := 0
						set_start_condition (SC_GCC_ATTRIBUTE)
					end
				
when 71 then
	yy_column := yy_column + 4
	yy_position := yy_position + 4
--|#line 263 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 263")
end

					if is_msc_extensions_enabled then
						last_token := TOK_CL_ASM
						last_string_value := text
					else
						report_type_or_identifier (text)
					end
				
when 72 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 271 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 271")
end

					if is_msc_extensions_enabled then
						-- last_token := TOK_CL_INLINE
						-- last_string_value := text
						-- ignore, we don't need it
					else
						report_type_or_identifier (text)
					end
				
when 73 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line 280 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 280")
end

					if is_msc_extensions_enabled then
						last_token := TOK_CL_CDECL
						last_string_value := text
					else
						report_type_or_identifier (text)
					end
				
when 74 then
	yy_column := yy_column + 6
	yy_position := yy_position + 6
--|#line 288 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 288")
end

					if is_msc_extensions_enabled then
						last_token := TOK_CL_CDECL
						last_string_value := text
					else
						report_type_or_identifier (text)
					end
				
when 75 then
	yy_column := yy_column + 9
	yy_position := yy_position + 9
--|#line 296 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 296")
end

					if is_msc_extensions_enabled then
						last_token := TOK_CL_STDCALL
						last_string_value := text
					else
						report_type_or_identifier (text)
					end
				
when 76 then
	yy_column := yy_column + 8
	yy_position := yy_position + 8
--|#line 304 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 304")
end

					if is_msc_extensions_enabled then
						last_token := TOK_CL_STDCALL
						last_string_value := text
					else
						report_type_or_identifier (text)
					end
					
when 77 then
	yy_column := yy_column + 12
	yy_position := yy_position + 12
--|#line 312 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 312")
end

					if is_msc_extensions_enabled then
						-- ignore, we don't need it
					else
						report_type_or_identifier (text)
					end
					
when 78 then
	yy_column := yy_column + 13
	yy_position := yy_position + 13
--|#line 319 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 319")
end

					if is_msc_extensions_enabled then
						-- ignore, we don't need it
					else
						report_type_or_identifier (text)
					end
					
when 79 then
	yy_column := yy_column + 11
	yy_position := yy_position + 11
--|#line 326 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 326")
end

					if is_msc_extensions_enabled then
						-- ignore, we don't need it
					else
						report_type_or_identifier (text)
					end
					
when 80 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line 334 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 334")
end
 
when 81 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 337 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 337")
end
 report_type_or_identifier (text)	
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
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 341 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 341")
end
 last_token := TOK_CONSTANT; last_string_value := text 
when 85 then
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 342 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 342")
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
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 346 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 346")
end
 last_token := TOK_CONSTANT; last_string_value := text 
when 89 then
yy_set_line_column
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 348 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 348")
end
 last_token := TOK_STRING_LITERAL; last_string_value := text 
when 90 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 350 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 350")
end
 last_token := TOK_ELLIPSIS; last_string_value := text 
when 91 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 351 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 351")
end
 last_token := TOK_RIGHT_ASSIGN; last_string_value := text 
when 92 then
	yy_column := yy_column + 3
	yy_position := yy_position + 3
--|#line 352 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 352")
end
 last_token := TOK_LEFT_ASSIGN; last_string_value := text 
when 93 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 353 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 353")
end
 last_token := TOK_ADD_ASSIGN; last_string_value := text 
when 94 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 354 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 354")
end
 last_token := TOK_SUB_ASSIGN; last_string_value := text 
when 95 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 355 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 355")
end
 last_token := TOK_MUL_ASSIGN; last_string_value := text 
when 96 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 356 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 356")
end
 last_token := TOK_DIV_ASSIGN; last_string_value := text 
when 97 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 357 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 357")
end
 last_token := TOK_MOD_ASSIGN; last_string_value := text 
when 98 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 358 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 358")
end
 last_token := TOK_AND_ASSIGN; last_string_value := text 
when 99 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 359 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 359")
end
 last_token := TOK_XOR_ASSIGN; last_string_value := text 
when 100 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 360 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 360")
end
 last_token := TOK_OR_ASSIGN; last_string_value := text 
when 101 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 361 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 361")
end
 last_token := TOK_RIGHT_OP; last_string_value := text 
when 102 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 362 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 362")
end
 last_token := TOK_LEFT_OP; last_string_value := text 
when 103 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 363 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 363")
end
 last_token := TOK_INC_OP; last_string_value := text 
when 104 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 364 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 364")
end
 last_token := TOK_DEC_OP; last_string_value := text 
when 105 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 365 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 365")
end
 last_token := TOK_PTR_OP; last_string_value := text 
when 106 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 366 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 366")
end
 last_token := TOK_AND_OP; last_string_value := text 
when 107 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 367 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 367")
end
 last_token := TOK_OR_OP; last_string_value := text 
when 108 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 368 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 368")
end
 last_token := TOK_LE_OP; last_string_value := text 
when 109 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 369 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 369")
end
 last_token := TOK_GE_OP; last_string_value := text 
when 110 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 370 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 370")
end
 last_token := TOK_EQ_OP; last_string_value := text 
when 111 then
	yy_column := yy_column + 2
	yy_position := yy_position + 2
--|#line 371 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 371")
end
 last_token := TOK_NE_OP; last_string_value := text 
when 112 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 373 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 373")
end
 last_token := Semicolon_code; last_string_value := text
when 113 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 374 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 374")
end
 last_token := Left_brace_code; last_string_value := text 
when 114 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 375 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 375")
end
 last_token := Right_brace_code; last_string_value := text 
when 115 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 376 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 376")
end
 last_token := Comma_code; last_string_value := text 
when 116 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 377 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 377")
end
 last_token := Colon_code; last_string_value := text 
when 117 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 378 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 378")
end
 last_token := Equal_code; last_string_value := text 
when 118 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 379 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 379")
end
 last_token := Left_parenthesis_code; last_string_value := text 
when 119 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 380 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 380")
end
 last_token := Right_parenthesis_code; last_string_value := text 
when 120 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 381 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 381")
end
 last_token := Left_bracket_code; last_string_value := text 
when 121 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line 382 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 382")
end
 last_token := Right_bracket_code; last_string_value := text 
when 122 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 383 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 383")
end
 last_token := Dot_code; last_string_value := text 
when 123 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 384 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 384")
end
 last_token := 38; last_string_value := text 
when 124 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 385 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 385")
end
 last_token := Exclamation_code; last_string_value := text 
when 125 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 386 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 386")
end
 last_token := 126; last_string_value := text 
when 126 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 387 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 387")
end
 last_token := Minus_code; last_string_value := text 
when 127 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 388 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 388")
end
 last_token := Plus_code; last_string_value := text 
when 128 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 389 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 389")
end
 last_token := Star_code; last_string_value := text 
when 129 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 390 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 390")
end
 last_token := Slash_code; last_string_value := text 
when 130 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 391 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 391")
end
 last_token := 37; last_string_value := text 
when 131 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 392 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 392")
end
 last_token := Less_than_code; last_string_value := text 
when 132 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 393 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 393")
end
 last_token := Greater_than_code; last_string_value := text 
when 133 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 394 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 394")
end
 last_token := Caret_code; last_string_value := text 
when 134 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 395 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 395")
end
 last_token := Bar_code; last_string_value := text 
when 135 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 396 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 396")
end
 last_token := Question_mark_code; last_string_value := text 
when 136 then
yy_set_line_column
	yy_position := yy_position + 1
--|#line 398 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 398")
end
 
when 137 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line 399 "ewg_c_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'ewg_c_scanner.l' at line 399")
end
 
when 138 then
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
			create an_array.make_filled (0, 0, 972)
			yy_nxt_template_1 (an_array)
			yy_nxt_template_2 (an_array)
			yy_nxt_template_3 (an_array)
			yy_nxt_template_4 (an_array)
			yy_nxt_template_5 (an_array)
			an_array.area.fill_with (475, 900, 972)
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
			   58,   59,   60,   12,   61,  474,   64,   65,   84,   62,
			   66,   67,   64,   65,   65,   93,   66,   67,   70,   70,
			   71,   71,   77,   78,   65,   88,   65,  473,   65,   86,

			   87,   94,   77,   78,   80,   81,   80,   81,   95,  113,
			  114,   72,   72,   83,   85,  108,   89,  116,  472,   68,
			   73,   73,   96,   97,   98,   68,   99,   99,   99,   99,
			   99,   99,   99,   99,  109,  128,  110,  111,  126,  227,
			  127,  131,  129,  136,  139,  151,  137,  228,  130,  471,
			  132,  140,   74,   74,   75,   75,  101,  166,  102,  102,
			  102,  102,  102,  102,  102,  102,   84,  153,  158,  133,
			  118,  134,  154,  170,  103,  143,  144,  104,  104,  105,
			  135,  119,  120,  164,  121,  145,  152,  122,  146,  103,
			  123,  156,  229,  167,  230,  104,  157,  475,  124,  161, yy_Dummy>>,
			1, 200, 0)
		end

	yy_nxt_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  162,  161,   85,  104,   90,   91,  105,  101,  223,  106,
			  106,  106,  106,  106,  106,  106,  106,  104,  104,  215,
			  218,  221,  153,  224,  158,  103,  216,  154,  104,  104,
			  166,  219,  245,  246,  158,  104,  156,  312,  222,  164,
			  103,  157,  470,  104,  313,  248,  104,  162,  162,  162,
			  161,  162,  161,  163,  104,  249,  252,  164,   99,   99,
			   99,   99,   99,   99,   99,   99,  167,  271,  272,  253,
			  362,  257,  469,  363,  172,  173,  178,  173,  178,  158,
			  258,  179,  179,  179,  179,  179,  179,  179,  179,  172,
			  173,  177,  177,  468,  467,  173,  174,  174,  174,  174,

			  174,  174,  174,  174,  163,  297,  297,  297,  164,  177,
			  466,  465,  175,  176,  236,  176,  236,  177,  464,  237,
			  237,  237,  237,  237,  237,  237,  237,  175,  176,  238,
			  239,  463,  239,  176,  101,  462,  102,  102,  102,  102,
			  102,  102,  102,  102,  238,  239,  387,  388,  387,  461,
			  239,  242,  103,  242,  460,  177,  177,  179,  179,  179,
			  179,  179,  179,  179,  179,  459,  242,  103,  296,  297,
			  296,  242,  345,  177,  458,  243,  243,  388,  388,  388,
			  457,  177,  184,  185,  186,  187,  188,  189,  456,  358,
			  190,  359,  455,  243,  360,  361,  191,  192,  193,  454, yy_Dummy>>,
			1, 200, 200)
		end

	yy_nxt_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  194,  243,  195,  161,  162,  161,  240,  439,  240,  453,
			  440,  241,  241,  241,  241,  241,  241,  241,  241,  439,
			  232,  232,  232,  232,  232,  232,  232,  232,  296,  297,
			  296,  237,  237,  237,  237,  237,  237,  237,  237,  173,
			  451,  173,  438,  438,  438,  232,  232,  232,  232,  232,
			  232,  232,  232,  450,  173,  300,  449,  300,  448,  173,
			  301,  301,  301,  301,  301,  301,  301,  301,  241,  241,
			  241,  241,  241,  241,  241,  241,  176,  447,  176,  243,
			  243,  297,  297,  297,  239,  345,  239,  446,  437,  438,
			  437,  176,  452,  180,  180,  180,  176,  243,  179,  239,

			  179,  445,  179,  444,  239,  243,  301,  301,  301,  301,
			  301,  301,  301,  301,  387,  388,  387,  438,  438,  438,
			  443,  452,  115,  115,  115,  115,  115,  442,  441,  436,
			  435,  418,  418,  418,  418,  418,  418,  418,  418,  437,
			  438,  437,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,  434,  433,  432,  431,  418,  418,  418,  418,
			  418,  418,  418,  418,   69,   69,   69,   69,   69,   69,
			   69,   69,   69,   69,   76,   76,   76,   76,   76,   76,
			   76,   76,   76,   76,   79,   79,   79,   79,   79,   79,
			   79,   79,   79,   79,   83,   83,   83,   83,   83,   83, yy_Dummy>>,
			1, 200, 400)
		end

	yy_nxt_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			   83,   83,   83,   83,   90,   90,   90,  430,   90,   90,
			   90,   90,   90,   90,  154,  429,  154,  154,  154,  154,
			  154,  154,  154,  154,  155,  428,  427,  155,  155,  155,
			  155,  155,  155,  155,  159,  159,  159,  159,  159,  159,
			  159,  159,  159,  159,  165,  165,  165,  165,  165,  165,
			  165,  165,  165,  165,  233,  233,  426,  237,  233,  237,
			  241,  237,  241,  301,  241,  301,  425,  301,  419,  419,
			  424,  423,  419,  420,  420,  420,  420,  420,  420,  420,
			  420,  420,  420,  440,  440,  440,  440,  440,  440,  440,
			  440,  440,  440,  422,  421,  420,  417,  416,  415,  414,

			  413,  412,  411,  410,  409,  408,  407,  406,  405,  404,
			  403,  402,  401,  400,  399,  398,  397,  396,  395,  394,
			  393,  392,  391,  390,  389,  386,  385,  384,  383,  382,
			  381,  380,  379,  378,  377,  376,  375,  374,  373,  372,
			  371,  370,  369,  368,  367,  366,  365,  364,  357,  356,
			  355,  354,  353,  352,  351,  350,  349,  348,  347,  346,
			  344,  343,  342,  341,  340,  339,  338,  337,  336,  335,
			  334,  333,  332,  331,  330,  329,  328,  327,  326,  325,
			  324,  323,  322,  321,  320,  319,  318,  317,  316,  315,
			  314,  311,  310,  309,  308,  307,  306,  305,  304,  303, yy_Dummy>>,
			1, 200, 600)
		end

	yy_nxt_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  302,  299,  298,  295,  294,  293,  292,  291,  290,  289,
			  288,  287,  286,  285,  284,  283,  282,  281,  280,  279,
			  278,  277,  276,  275,  274,  273,  270,  269,  268,  267,
			  266,  265,  264,  263,  262,  261,  260,  259,  256,  255,
			  254,  251,  250,  247,  244,  475,  235,  234,  160,  231,
			  226,  225,  220,  217,  214,  213,  212,  211,  210,  209,
			  208,  207,  206,  205,  204,  203,  202,  201,  200,  199,
			  198,  197,  196,  183,   91,  182,  181,  171,  475,  165,
			  169,  168,  160,  150,  149,  148,  147,  142,  141,  138,
			  125,  117,  112,  107,  100,   92,   91,   82,  475,   11, yy_Dummy>>,
			1, 100, 800)
		end

	yy_chk_template: SPECIAL [INTEGER]
			-- Template for `yy_chk'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 972)
			an_array.put (0, 0)
			an_array.area.fill_with (1, 1, 73)
			yy_chk_template_1 (an_array)
			yy_chk_template_2 (an_array)
			yy_chk_template_3 (an_array)
			yy_chk_template_4 (an_array)
			yy_chk_template_5 (an_array)
			an_array.area.fill_with (475, 899, 972)
			Result := yy_fixed_array (an_array)
		end

	yy_chk_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			    2,  470,    3,    3,   16,    2,    3,    3,    4,    4,
			    7,   23,    4,    4,    5,    6,    5,    6,    7,    7,
			    8,   18,    9,  469,   10,   17,   17,   23,    8,    8,
			    9,    9,   10,   10,   25,   34,   34,    5,    6,   37,
			   16,   32,   18,   37,  468,    3,    5,    6,   25,   25,
			   26,    4,   26,   26,   26,   26,   26,   26,   26,   26,
			   32,   44,   32,   32,   43,  148,   43,   45,   44,   47,
			   49,   58,   47,  148,   44,  467,   45,   49,    5,    6,
			    5,    6,   28,   70,   28,   28,   28,   28,   28,   28,
			   28,   28,   83,   61,   68,   46,   41,   46,   61,   90,

			   28,   52,   52,   28,   28,   28,   46,   41,   41,   68,
			   41,   52,   58,   41,   52,   28,   41,   64,  149,   70,
			  149,   28,   64,   91,   41,   67,   67,   67,   83,   28,
			   91,   90,   28,   29,  145,   29,   29,   29,   29,   29,
			   29,   29,   29,  104,  104,  140,  142,  144,  153,  145,
			  158,   29,  140,  153,   29,   29,  165,  142,  184,  184,
			   64,  104,  156,  254,  144,  158,   29,  156,  465,  104,
			  254,  186,   29,  162,  162,  162,  157,  157,  157,   67,
			   29,  186,  189,   67,   99,   99,   99,   99,   99,   99,
			   99,   99,  165,  206,  206,  189,  314,  193,  464,  314, yy_Dummy>>,
			1, 200, 74)
		end

	yy_chk_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			   99,   99,  103,   99,  103,  156,  193,  103,  103,  103,
			  103,  103,  103,  103,  103,   99,   99,  177,  177,  463,
			  462,   99,  101,  101,  101,  101,  101,  101,  101,  101,
			  157,  233,  233,  233,  157,  177,  461,  457,  101,  101,
			  172,  101,  172,  177,  455,  172,  172,  172,  172,  172,
			  172,  172,  172,  101,  101,  174,  174,  453,  174,  101,
			  102,  451,  102,  102,  102,  102,  102,  102,  102,  102,
			  174,  174,  346,  346,  346,  450,  174,  179,  102,  179,
			  448,  102,  102,  178,  178,  178,  178,  178,  178,  178,
			  178,  447,  179,  102,  296,  296,  296,  179,  296,  102,

			  446,  180,  180,  388,  388,  388,  445,  102,  119,  119,
			  119,  119,  119,  119,  444,  313,  119,  313,  443,  180,
			  313,  313,  119,  119,  119,  442,  119,  180,  119,  161,
			  161,  161,  175,  420,  175,  441,  420,  175,  175,  175,
			  175,  175,  175,  175,  175,  440,  161,  161,  161,  161,
			  161,  161,  161,  161,  232,  232,  232,  236,  236,  236,
			  236,  236,  236,  236,  236,  237,  431,  237,  419,  419,
			  419,  232,  232,  232,  232,  232,  232,  232,  232,  430,
			  237,  238,  429,  238,  428,  237,  238,  238,  238,  238,
			  238,  238,  238,  238,  240,  240,  240,  240,  240,  240, yy_Dummy>>,
			1, 200, 274)
		end

	yy_chk_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  240,  240,  241,  427,  241,  243,  243,  297,  297,  297,
			  301,  297,  301,  426,  437,  437,  437,  241,  437,  487,
			  487,  487,  241,  243,  489,  301,  489,  425,  489,  424,
			  301,  243,  300,  300,  300,  300,  300,  300,  300,  300,
			  387,  387,  387,  438,  438,  438,  423,  438,  482,  482,
			  482,  482,  482,  422,  421,  417,  416,  387,  387,  387,
			  387,  387,  387,  387,  387,  418,  418,  418,  476,  476,
			  476,  476,  476,  476,  476,  476,  476,  476,  414,  412,
			  411,  409,  418,  418,  418,  418,  418,  418,  418,  418,
			  477,  477,  477,  477,  477,  477,  477,  477,  477,  477,

			  478,  478,  478,  478,  478,  478,  478,  478,  478,  478,
			  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,
			  480,  480,  480,  480,  480,  480,  480,  480,  480,  480,
			  481,  481,  481,  408,  481,  481,  481,  481,  481,  481,
			  483,  407,  483,  483,  483,  483,  483,  483,  483,  483,
			  484,  406,  405,  484,  484,  484,  484,  484,  484,  484,
			  485,  485,  485,  485,  485,  485,  485,  485,  485,  485,
			  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,
			  488,  488,  399,  490,  488,  490,  491,  490,  491,  492,
			  491,  492,  398,  492,  493,  493,  397,  396,  493,  494, yy_Dummy>>,
			1, 200, 474)
		end

	yy_chk_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  494,  494,  494,  494,  494,  494,  494,  494,  494,  495,
			  495,  495,  495,  495,  495,  495,  495,  495,  495,  395,
			  391,  389,  386,  385,  384,  377,  373,  372,  371,  370,
			  369,  367,  366,  365,  364,  363,  362,  360,  359,  358,
			  357,  356,  355,  354,  353,  352,  351,  350,  349,  348,
			  347,  343,  342,  340,  339,  338,  337,  336,  335,  333,
			  332,  331,  329,  328,  327,  326,  323,  322,  321,  320,
			  318,  317,  316,  315,  312,  311,  310,  309,  308,  307,
			  306,  305,  304,  303,  299,  298,  295,  294,  292,  291,
			  290,  289,  288,  287,  286,  285,  284,  283,  282,  280,

			  278,  277,  274,  273,  272,  271,  268,  265,  264,  263,
			  262,  260,  259,  258,  257,  256,  255,  253,  252,  251,
			  250,  249,  248,  247,  246,  245,  244,  235,  234,  231,
			  230,  229,  228,  227,  226,  225,  224,  223,  222,  221,
			  220,  219,  218,  217,  215,  214,  212,  211,  210,  209,
			  208,  207,  205,  204,  203,  202,  201,  200,  199,  198,
			  197,  196,  195,  194,  192,  191,  190,  188,  187,  185,
			  183,  167,  164,  163,  159,  150,  147,  146,  143,  141,
			  138,  137,  136,  135,  134,  133,  132,  131,  130,  129,
			  128,  127,  126,  125,  124,  123,  122,  121,  120,  118, yy_Dummy>>,
			1, 200, 674)
		end

	yy_chk_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  116,  114,  110,   98,   85,   73,   72,   71,   66,   56,
			   55,   54,   53,   51,   50,   48,   42,   40,   33,   30,
			   27,   22,   19,   15,   11, yy_Dummy>>,
			1, 25, 874)
		end

	yy_base_template: SPECIAL [INTEGER]
			-- Template for `yy_base'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 495)
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
			   96,  898,  899,  899,  899,  868,   73,   70,   87,  855,
			  899,  899,  866,   72,  899,   93,  108,  865,  140,  191,
			  863,  899,  108,  863,   80,  899,    0,  108,  899,  899,
			  862,  137,  827,   80,   90,   92,  114,   88,  831,   94,
			  830,  838,  123,  819,  828,  826,  831,  899,  116,  899,
			  899,  166,    0,    0,  190,  899,  880,  198,  124,  899,
			  152,  851,  873,  874,  899,  899,  899,  899,  899,  899,
			  899,  899,  899,  161,  899,  876,  899,  899,  899,  899,
			  164,  195,  899,  899,  899,  899,  899,  899,  861,  240,

			  899,  278,  318,  263,  180,    0,    0,  899,  899,  899,
			  847,  899,  899,  899,  846,    0,  833,  899,  815,  337,
			  811,  823,  812,  812,  806,  805,  808,  816,  803,  818,
			  805,  811,  797,  798,  795,  795,  798,  795,  792,    0,
			  164,  796,  169,  794,  170,  163,  798,  791,   86,  139,
			  796,  899,  899,  221,    0,    0,  235,  249,  180,  846,
			  899,  402,  246,  794,  786,  225,  899,  843,  899,  899,
			  899,  899,  301,  899,  295,  393,  899,  254,  339,  316,
			  338,  899,  899,  786,  171,  798,  197,  793,  775,  211,
			  783,  777,  789,  218,  780,  812,  779,  785,  773,  777, yy_Dummy>>,
			1, 200, 0)
		end

	yy_base_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			  783,  772,  774,  783,  778,  766,  206,  780,  778,  774,
			  766,  772,  775,    0,  761,  765,    0,  766,  763,  752,
			  754,  756,  763,  749,  747,  747,  759,  749,  753,  757,
			  759,  748,  427,  304,  745,  756,  413,  404,  442,  899,
			  450,  441,  899,  442,  745,  743,  736,  736,  747,  738,
			  747,  731,  731,  731,  182,  730,  728,  737,  739,  741,
			  763,    0,  737,  736,  729,  734,    0,    0,  726,    0,
			    0,  717,  725,  714,  721,    0,    0,  715,  712,    0,
			  716,    0,  711,  711,  708,  720,  710,  714,  719,  718,
			  716,  706,  711,    0,  699,  711,  367,  480,  710,  707,

			  488,  449,    0,  713,  696,  706,  707,  692,  697,  702,
			  688,  702,  695,  370,  249,  685,  689,  698,  689,    0,
			  688,  693,  684,  695,    0,    0,  682,  683,  688,  679,
			    0,  686,  672,  676,    0,  684,  681,  683,  667,  676,
			  678,    0,  669,  672,    0,  899,  345,  668,  679,  669,
			  673,  665,  657,  657,  660,  669,  666,  657,  689,  692,
			  689,    0,  690,  687,  648,  658,  661,  652,    0,  651,
			  654,  647,  638,  638,    0,    0,    0,  650,    0,    0,
			    0,    0,    0,    0,  648,  648,  641,  513,  376,  650,
			    0,  648,    0,    0,    0,  634,  610,  625,  613,  607, yy_Dummy>>,
			1, 200, 200)
		end

	yy_base_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			    0,    0,    0,    0,    0,  573,  577,  560,  556,  498,
			    0,  499,  504,    0,  492,    0,  482,  480,  538,  441,
			  405,  465,  478,  467,  448,  444,  443,  430,  414,  401,
			  396,  385,    0,    0,    0,    0,    0,  487,  516,  899,
			  417,  347,  352,  334,  333,  325,  330,  303,  310,    0,
			  300,  282,  899,  282,    0,  261,    0,  258,    0,    0,
			    0,  262,  237,  249,  228,  185,    0,  100,   74,   53,
			   26,    0,    0,    0,    0,  899,  541,  563,  573,  583,
			  593,  603,  517,  613,  623,  633,  643,  488,  653,  493,
			  652,  655,  658,  667,  672,  682, yy_Dummy>>,
			1, 96, 400)
		end

	yy_def_template: SPECIAL [INTEGER]
			-- Template for `yy_def'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 495)
			yy_def_template_1 (an_array)
			an_array.area.fill_with (482, 118, 150)
			yy_def_template_2 (an_array)
			an_array.area.fill_with (482, 183, 231)
			yy_def_template_3 (an_array)
			an_array.area.fill_with (482, 244, 295)
			yy_def_template_4 (an_array)
			an_array.area.fill_with (482, 302, 344)
			yy_def_template_5 (an_array)
			an_array.area.fill_with (482, 348, 386)
			yy_def_template_6 (an_array)
			an_array.area.fill_with (482, 390, 417)
			yy_def_template_7 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_def_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			    0,  475,    1,  476,  476,  477,  477,  478,  478,  479,
			  479,  475,  475,  475,  475,  475,  480,  475,  475,  481,
			  475,  475,  475,  475,  475,  475,  475,  475,  475,  475,
			  475,  475,  475,  475,  475,  475,  482,  482,  475,  475,
			  475,  482,  482,  482,  482,  482,  482,  482,  482,  482,
			  482,  482,  482,  482,  482,  482,  482,  475,  475,  475,
			  475,  475,  483,  484,  484,  475,  485,  484,  484,  475,
			  486,  475,  475,  475,  475,  475,  475,  475,  475,  475,
			  475,  475,  475,  480,  475,  480,  475,  475,  475,  475,
			  481,  481,  475,  475,  475,  475,  475,  475,  475,  475,

			  475,  475,  475,  475,  475,  487,   29,  475,  475,  475,
			  475,  475,  475,  475,  475,  482,  481,  475, yy_Dummy>>,
			1, 118, 0)
		end

	yy_def_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  475,  475,  475,  483,  484,  484,  484,  484,  485,  475,
			  484,  488,  484,  484,  486,  475,  486,  475,  475,  475,
			  475,  475,  475,  101,  475,  475,  475,  475,  489,  487,
			  475,  475, yy_Dummy>>,
			1, 32, 151)
		end

	yy_def_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  484,  488,  484,  484,  475,  490,  475,  475,  475,  491,
			  475,  475, yy_Dummy>>,
			1, 12, 232)
		end

	yy_def_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  484,  475,  484,  484,  475,  492, yy_Dummy>>,
			1, 6, 296)
		end

	yy_def_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  475,  484,  484, yy_Dummy>>,
			1, 3, 345)
		end

	yy_def_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  484,  493,  484, yy_Dummy>>,
			1, 3, 387)
		end

	yy_def_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  484,  493,  494,  482,  482,  482,  482,  482,  482,  482,
			  482,  482,  482,  482,  482,  482,  482,  482,  482,  484,
			  475,  475,  495,  482,  482,  482,  482,  482,  482,  482,
			  482,  482,  482,  482,  475,  482,  482,  482,  482,  482,
			  482,  482,  482,  482,  482,  482,  482,  482,  482,  482,
			  482,  482,  482,  482,  482,  482,  482,    0,  475,  475,
			  475,  475,  475,  475,  475,  475,  475,  475,  475,  475,
			  475,  475,  475,  475,  475,  475,  475,  475, yy_Dummy>>,
			1, 78, 418)
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
			create an_array.make_filled (0, 0, 475)
			yy_accept_template_1 (an_array)
			an_array.area.fill_with (81, 183, 212)
			yy_accept_template_2 (an_array)
			yy_accept_template_3 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_accept_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,  139,  137,  136,  136,  124,  137,  130,  123,  137,
			  118,  119,  128,  127,  115,  126,  122,  129,   84,   84,
			  116,  112,  131,  117,  132,  135,   81,   81,  120,  121,
			  133,   81,   81,   81,   81,   81,   81,   81,   81,   81,
			   81,   81,   81,   81,   81,   81,   81,  113,  134,  114,
			  125,  136,    1,    5,    5,  138,  138,    5,    5,   10,
			   10,   10,   10,   10,    7,    8,   14,   12,   13,   58,
			   56,   57,  111,    0,   89,    0,   97,  114,  106,   98,
			    0,    0,   95,  103,   93,  104,   94,  105,    0,   87,

			   96,   88,   83,    0,   84,    0,   84,  121,  113,  120,
			  102,  108,  110,  109,  101,   81,    0,   99,   81,   81,
			   81,   81,   81,   81,   81,   81,   81,   81,   81,   81,
			   81,   81,   22,   81,   81,   81,   81,   81,   81,   30,
			   81,   81,   81,   81,   81,   81,   81,   81,   81,   81,
			   81,  100,  107,    0,    1,    5,    5,    5,    5,    0,
			    6,    5,    0,    5,    5,    0,    9,    0,    8,    7,
			   85,   90,    0,   87,   87,    0,   88,   83,    0,   86,
			   82,   92,   91, yy_Dummy>>,
			1, 183, 0)
		end

	yy_accept_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			   28,   81,   81,   31,   81,   81,   81,   81,   81,   81,
			   81,   81,   81,   81,   81,   81,   81,   81,   81,    5,
			    0,    5,    5,    0,   87,    0,   87,    0,   88,   86,
			   82,   81,   81,   81,   81,   81,   81,   81,   81,   81,
			   81,   81,   81,   81,   81,   81,   81,   81,   71,   81,
			   81,   81,   81,   15,   32,   81,   17,   18,   81,   81,
			   81,   81,   24,   25,   81,   81,   29,   81,   34,   81,
			   81,   81,   81,   81,   81,   81,   81,   81,   81,   81,
			   47,   81,   81,    5,    0,    5,    5,    0,   87,   33,
			   69,   81,   81,   81,   81,   81,   81,   81,   81,   81,

			   81,   81,   81,   81,   81,   81,   80,   81,   81,   81,
			   81,   16,   19,   81,   81,   81,   81,   27,   81,   81,
			   81,   37,   81,   81,   81,   81,   81,   81,   45,   81,
			   81,   49,    2,    5,    5,   81,   81,   81,   81,   81,
			   81,   81,   81,   81,   81,   81,   81,   81,   61,   81,
			   81,   81,   81,   81,   81,   74,   81,   81,   81,   81,
			   81,   23,   26,   41,   81,   36,   38,   39,   40,   42,
			   43,   81,   81,   81,    5,    0,    5,   70,   81,   68,
			   73,   53,   81,   81,   81,   81,   81,   62,   63,   64,
			   65,   66,   81,   81,   81,   81,   81,   72,   81,   81, yy_Dummy>>,
			1, 200, 213)
		end

	yy_accept_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			   21,   81,   44,   81,   81,    5,    0,    5,   81,   81,
			   81,   81,   81,   59,   81,   51,   81,   81,   81,   76,
			   20,   35,   46,   48,    5,    0,    4,    0,   81,   81,
			   81,   81,   81,   81,   81,   81,   75,   81,   81,    3,
			   81,   11,   81,   67,   81,   60,   54,   50,   81,   81,
			   81,   81,   81,   79,   81,   81,   81,   81,   77,   55,
			   52,   78,    0, yy_Dummy>>,
			1, 63, 413)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER = 899
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER = 475
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER = 476
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

	yyNb_rules: INTEGER = 138
			-- Number of rules

	yyEnd_of_buffer: INTEGER = 139
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
