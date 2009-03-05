indexing

	description:

		"Eiffel preparsers"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 2002-2008, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class ET_EIFFEL_PREPARSER

inherit

	ET_EIFFEL_PREPARSER_SKELETON

create

	make

feature -- Status report

	valid_start_condition (sc: INTEGER): BOOLEAN is
			-- Is `sc' a valid start condition?
		do
			Result := (INITIAL <= sc and sc <= LAVS3)
		end

feature {NONE} -- Implementation

	yy_build_tables is
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

	yy_execute_action (yy_act: INTEGER) is
			-- Execute semantic action.
		do
if yy_act <= 66 then
if yy_act <= 33 then
if yy_act <= 17 then
if yy_act <= 9 then
if yy_act <= 5 then
if yy_act <= 3 then
if yy_act <= 2 then
if yy_act = 1 then
yy_set_line_column
--|#line 32 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 32")
end

			
else
	yy_column := yy_column + 1
--|#line 33 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 33")
end

			
end
else
	yy_column := yy_column + 2
--|#line 34 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 34")
end

			
end
else
if yy_act = 4 then
	yy_column := yy_column + 5
--|#line 39 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 39")
end

			
else
	yy_column := yy_column + 5
--|#line 40 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 40")
end

			
end
end
else
if yy_act <= 7 then
if yy_act = 6 then
	yy_column := yy_column + 3
--|#line 41 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 41")
end

			
else
	yy_column := yy_column + 3
--|#line 42 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 42")
end

			
end
else
if yy_act = 8 then
	yy_column := yy_column + 2
--|#line 43 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 43")
end

			
else
	yy_column := yy_column + 6
--|#line 44 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 44")
end

			
end
end
end
else
if yy_act <= 13 then
if yy_act <= 11 then
if yy_act = 10 then
	yy_column := yy_column + 5
--|#line 45 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 45")
end

			
else
	yy_column := yy_column + 7
--|#line 46 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 46")
end

			
end
else
if yy_act = 12 then
	yy_column := yy_column + 6
--|#line 47 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 47")
end

			
else
	yy_column := yy_column + 8
--|#line 48 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 48")
end

			
end
end
else
if yy_act <= 15 then
if yy_act = 14 then
	yy_column := yy_column + 7
--|#line 49 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 49")
end

			
else
	yy_column := yy_column + 5
--|#line 50 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 50")
end

			
end
else
if yy_act = 16 then
	yy_column := yy_column + 8
--|#line 51 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 51")
end

			
else
	yy_column := yy_column + 2
--|#line 52 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 52")
end

			
end
end
end
end
else
if yy_act <= 25 then
if yy_act <= 21 then
if yy_act <= 19 then
if yy_act = 18 then
	yy_column := yy_column + 4
--|#line 53 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 53")
end

			
else
	yy_column := yy_column + 6
--|#line 54 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 54")
end

			
end
else
if yy_act = 20 then
	yy_column := yy_column + 3
--|#line 55 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 55")
end

			
else
	yy_column := yy_column + 6
--|#line 56 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 56")
end

			
end
end
else
if yy_act <= 23 then
if yy_act = 22 then
	yy_column := yy_column + 8
--|#line 57 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 57")
end

			
else
	yy_column := yy_column + 6
--|#line 58 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 58")
end

			
end
else
if yy_act = 24 then
	yy_column := yy_column + 8
--|#line 59 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 59")
end

			
else
	yy_column := yy_column + 5
--|#line 60 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 60")
end

			
end
end
end
else
if yy_act <= 29 then
if yy_act <= 27 then
if yy_act = 26 then
	yy_column := yy_column + 7
--|#line 61 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 61")
end

			
else
	yy_column := yy_column + 4
--|#line 62 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 62")
end

			
end
else
if yy_act = 28 then
	yy_column := yy_column + 6
--|#line 63 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 63")
end

			
else
	yy_column := yy_column + 2
--|#line 64 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 64")
end

			
end
end
else
if yy_act <= 31 then
if yy_act = 30 then
	yy_column := yy_column + 7
--|#line 65 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 65")
end

			
else
	yy_column := yy_column + 8
--|#line 66 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 66")
end

			
end
else
if yy_act = 32 then
	yy_column := yy_column + 5
--|#line 67 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 67")
end

			
else
	yy_column := yy_column + 7
--|#line 68 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 68")
end

			
end
end
end
end
end
else
if yy_act <= 50 then
if yy_act <= 42 then
if yy_act <= 38 then
if yy_act <= 36 then
if yy_act <= 35 then
if yy_act = 34 then
	yy_column := yy_column + 7
--|#line 69 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 69")
end

			
else
	yy_column := yy_column + 9
--|#line 70 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 70")
end

			
end
else
	yy_column := yy_column + 2
--|#line 71 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 71")
end

			
end
else
if yy_act = 37 then
	yy_column := yy_column + 4
--|#line 72 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 72")
end

			
else
	yy_column := yy_column + 5
--|#line 73 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 73")
end

			
end
end
else
if yy_act <= 40 then
if yy_act = 39 then
	yy_column := yy_column + 4
--|#line 74 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 74")
end

			
else
	yy_column := yy_column + 3
--|#line 75 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 75")
end

			
end
else
if yy_act = 41 then
	yy_column := yy_column + 8
--|#line 76 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 76")
end

			
else
	yy_column := yy_column + 3
--|#line 77 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 77")
end

			
end
end
end
else
if yy_act <= 46 then
if yy_act <= 44 then
if yy_act = 43 then
	yy_column := yy_column + 4
--|#line 78 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 78")
end

			
else
	yy_column := yy_column + 2
--|#line 79 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 79")
end

			
end
else
if yy_act = 45 then
	yy_column := yy_column + 9
--|#line 80 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 80")
end

			
else
	yy_column := yy_column + 6
--|#line 81 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 81")
end

			
end
end
else
if yy_act <= 48 then
if yy_act = 47 then
	yy_column := yy_column + 8
--|#line 82 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 82")
end

			
else
	yy_column := yy_column + 6
--|#line 83 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 83")
end

			
end
else
if yy_act = 49 then
	yy_column := yy_column + 7
--|#line 84 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 84")
end

			
else
	yy_column := yy_column + 6
--|#line 85 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 85")
end

			
end
end
end
end
else
if yy_act <= 58 then
if yy_act <= 54 then
if yy_act <= 52 then
if yy_act = 51 then
	yy_column := yy_column + 6
--|#line 86 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 86")
end

			
else
	yy_column := yy_column + 5
--|#line 87 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 87")
end

			
end
else
if yy_act = 53 then
	yy_column := yy_column + 6
--|#line 88 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 88")
end

			
else
	yy_column := yy_column + 8
--|#line 89 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 89")
end

			
end
end
else
if yy_act <= 56 then
if yy_act = 55 then
	yy_column := yy_column + 5
--|#line 90 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 90")
end

			
else
	yy_column := yy_column + 4
--|#line 91 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 91")
end

			
end
else
if yy_act = 57 then
	yy_column := yy_column + 4
--|#line 92 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 92")
end

			
else
	yy_column := yy_column + 8
--|#line 93 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 93")
end

			
end
end
end
else
if yy_act <= 62 then
if yy_act <= 60 then
if yy_act = 59 then
	yy_column := yy_column + 6
--|#line 94 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 94")
end

			
else
	yy_column := yy_column + 5
--|#line 95 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 95")
end

			
end
else
if yy_act = 61 then
	yy_column := yy_column + 7
--|#line 96 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 96")
end

			
else
	yy_column := yy_column + 4
--|#line 97 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 97")
end

			
end
end
else
if yy_act <= 64 then
if yy_act = 63 then
	yy_column := yy_column + 4
--|#line 98 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 98")
end

			
else
	yy_column := yy_column + 3
--|#line 99 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 99")
end

			
end
else
if yy_act = 65 then
	yy_column := yy_column + 5
--|#line 101 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 101")
end

				class_keyword_found := True
			
else
	yy_column := yy_column + 9
--|#line 104 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 104")
end

				if use_attribute_keyword then
					-- Do nothing.
				elseif class_keyword_found then
					last_token := E_IDENTIFIER
					last_literal_start := 1
					last_literal_end := 9
					last_break_end := 0
					last_comment_end := 0
					last_classname := ast_factory.new_identifier (Current)
				end
			
end
end
end
end
end
end
else
if yy_act <= 99 then
if yy_act <= 83 then
if yy_act <= 75 then
if yy_act <= 71 then
if yy_act <= 69 then
if yy_act <= 68 then
if yy_act = 67 then
	yy_column := yy_column + 4
--|#line 116 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 116")
end

				if use_note_keyword then
					-- Do nothing.
				elseif class_keyword_found then
					last_token := E_IDENTIFIER
					last_literal_start := 1
					last_literal_end := 4
					last_break_end := 0
					last_comment_end := 0
					last_classname := ast_factory.new_identifier (Current)
				end
			
else
	yy_column := yy_column + 9
--|#line 128 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 128")
end

				if use_reference_keyword then
					-- Do nothing.
				elseif class_keyword_found then
					last_token := E_IDENTIFIER
					last_literal_start := 1
					last_literal_end := 9
					last_break_end := 0
					last_comment_end := 0
					last_classname := ast_factory.new_identifier (Current)
				end
			
end
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 144 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 144")
end

				if class_keyword_found then
					last_token := E_IDENTIFIER
					last_literal_start := 1
					last_literal_end := text_count
					last_break_end := 0
					last_comment_end := 0
					last_classname := ast_factory.new_identifier (Current)
				end
			
end
else
if yy_act = 70 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 158 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 158")
end

			
else
	yy_column := yy_column + 3
--|#line 167 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 167")
end

			
end
end
else
if yy_act <= 73 then
if yy_act = 72 then
	yy_column := yy_column + 4
--|#line 168 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 168")
end

			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 169 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 169")
end

			
end
else
if yy_act = 74 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 172 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 172")
end

					-- Syntax error: missing character / at end
					-- of special character specification %/code/.
				column := column + text_count
				set_syntax_error
				error_handler.report_SCAS_error (filename, current_position)
				column := column - text_count
				last_token := E_CHARERR
			
else
	yy_column := yy_column + 3
--|#line 181 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 181")
end

					-- Syntax error: missing ASCII code in
					-- special character specification %/code/.
				column := column + 3
				set_syntax_error
				error_handler.report_SCAC_error (filename, current_position)
				column := column - 3
				last_token := E_CHARERR
			
end
end
end
else
if yy_act <= 79 then
if yy_act <= 77 then
if yy_act = 76 then
	yy_column := yy_column + 2
--|#line 190 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 190")
end

					-- Syntax error: missing character between quotes.
				column := column + 1
				set_syntax_error
				error_handler.report_SCQQ_error (filename, current_position)
				column := column - 1
				last_token := E_CHARERR
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 198 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 198")
end

					-- Syntax error: missing quote at
					-- end of character constant.
				column := column + text_count
				set_syntax_error
				error_handler.report_SCEQ_error (filename, current_position)
				column := column - text_count
				last_token := E_CHARERR
			
end
else
if yy_act = 78 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 211 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 211")
end

			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 214 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 214")
end

					-- Verbatim string.
				verbatim_marker := text_substring (2, text_count - 1)
				set_start_condition (VS1)
			
end
end
else
if yy_act <= 81 then
if yy_act = 80 then
	yy_line := yy_line + 1
	yy_column := 1
--|#line 222 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 222")
end

				last_literal_start := 1
				last_literal_end := 0
				set_start_condition (VS2)
			
else
	yy_column := yy_column + 1
--|#line 227 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 227")
end

					-- No final brace-double-quote.
				last_token := E_STRERR
				report_syntax_error (current_position)
				set_start_condition (INITIAL)
			
end
else
if yy_act = 82 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 243 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 243")
end

				if is_verbatim_string_closer (last_literal_end + 1, text_count - 1) then
					verbatim_marker := Void
					set_start_condition (INITIAL)
				else
					more
					set_start_condition (VS3)
				end
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 252 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 252")
end

				more
				set_start_condition (VS3)
			
end
end
end
end
else
if yy_act <= 91 then
if yy_act <= 87 then
if yy_act <= 85 then
if yy_act = 84 then
	yy_line := yy_line + 1
	yy_column := 1
--|#line 256 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 256")
end

				more
				last_literal_end := text_count - 2
			
else
	yy_line := yy_line + 1
	yy_column := 1
--|#line 260 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 260")
end

				more
				last_literal_end := text_count - 1
			
end
else
if yy_act = 86 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 264 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 264")
end

					-- No final brace-double-quote.
				last_token := E_STRERR
				report_syntax_error (current_position)
				set_start_condition (INITIAL)
			
else
	yy_line := yy_line + 1
	yy_column := 1
--|#line 280 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 280")
end

				more
				last_literal_end := text_count - 2
				set_start_condition (VS2)
			
end
end
else
if yy_act <= 89 then
if yy_act = 88 then
	yy_line := yy_line + 1
	yy_column := 1
--|#line 285 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 285")
end

				more
				last_literal_end := text_count - 1
				set_start_condition (VS2)
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 290 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 290")
end

					-- No final brace-double-quote.
				last_token := E_STRERR
				report_syntax_error (current_position)
				set_start_condition (INITIAL)
			
end
else
if yy_act = 90 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 304 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 304")
end

					-- Left aligned verbatim string.
				verbatim_marker := text_substring (2, text_count - 1)
				set_start_condition (LAVS1)
			
else
	yy_line := yy_line + 1
	yy_column := 1
--|#line 312 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 312")
end

				last_literal_start := 1
				last_literal_end := 0
				set_start_condition (LAVS2)
			
end
end
end
else
if yy_act <= 95 then
if yy_act <= 93 then
if yy_act = 92 then
	yy_column := yy_column + 1
--|#line 317 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 317")
end

					-- No final bracket-double-quote.
				last_token := E_STRERR
				report_syntax_error (current_position)
				set_start_condition (INITIAL)
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 333 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 333")
end

				if is_verbatim_string_closer (last_literal_end + 1, text_count - 1) then
					verbatim_marker := Void
					set_start_condition (INITIAL)
				else
					more
					set_start_condition (LAVS3)
				end
			
end
else
if yy_act = 94 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 342 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 342")
end

				more
				set_start_condition (LAVS3)
			
else
	yy_line := yy_line + 1
	yy_column := 1
--|#line 346 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 346")
end

				more
				last_literal_end := text_count - 2
			
end
end
else
if yy_act <= 97 then
if yy_act = 96 then
	yy_line := yy_line + 1
	yy_column := 1
--|#line 350 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 350")
end

				more
				last_literal_end := text_count - 1
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 354 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 354")
end

					-- No final bracket-double-quote.
				last_token := E_STRERR
				report_syntax_error (current_position)
				set_start_condition (INITIAL)
			
end
else
if yy_act = 98 then
	yy_line := yy_line + 1
	yy_column := 1
--|#line 370 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 370")
end

				more
				last_literal_end := text_count - 2
				set_start_condition (LAVS2)
			
else
	yy_line := yy_line + 1
	yy_column := 1
--|#line 375 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 375")
end

				more
				last_literal_end := text_count - 1
				set_start_condition (LAVS2)
			
end
end
end
end
end
else
if yy_act <= 116 then
if yy_act <= 108 then
if yy_act <= 104 then
if yy_act <= 102 then
if yy_act <= 101 then
if yy_act = 100 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 380 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 380")
end

					-- No final bracket-double-quote.
				last_token := E_STRERR
				report_syntax_error (current_position)
				set_start_condition (INITIAL)
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 394 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 394")
end

					-- Manifest string with special characters.
			
end
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 397 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 397")
end

					-- Manifest string with special characters which may be made
					-- up of several lines or may include invalid characters.
					-- Keep track of current line and column.
				ms_line := line
				ms_column := column
				more
				set_start_condition (MS)
			
end
else
if yy_act = 103 then
	yy_line := yy_line + 1
	yy_column := 1
--|#line 408 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 408")
end

					-- Multi-line manifest string.
				more
				set_start_condition (MSN)
			
else
	yy_end := yy_start + yy_more_len + 2
	yy_column := yy_column + 2
--|#line 413 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 413")
end

					-- Multi-line manifest string.

					-- Syntax error: no space allowed after character
					-- % at end of line in multi-line manifest strings.
				column := yy_column - 1
				line := yy_line
--				set_syntax_error
--				error_handler.report_SSNS_error (filename, current_position)
				column := ms_column
				line := ms_line

				more
				set_start_condition (MSN1)
			
end
end
else
if yy_act <= 106 then
if yy_act = 105 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 428 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 428")
end

				more
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 431 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 431")
end

					-- Syntax error: missing character / at end of special
					-- character specification %/code/ in manifest string.
				column := yy_column
				line := yy_line
--				set_syntax_error
--				error_handler.report_SSAS_error (filename, current_position)
				column := ms_column
				line := ms_line

				more
			
end
else
if yy_act = 107 then
	yy_column := yy_column + 2
--|#line 443 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 443")
end

					-- Syntax error: missing ASCII code in special character
					-- specification %/code/ in manifest string.
				column := yy_column
				line := yy_line
--				set_syntax_error
--				error_handler.report_SSAC_error (filename, current_position)
				column := ms_column
				line := ms_line

				more
			
else
	yy_column := yy_column + 2
--|#line 455 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 455")
end

					-- Syntax error: special character specification
					-- %l where l is a letter code should be in
					-- upper-case in manifest strings.
				column := yy_column - 1
				line := yy_line
--				set_syntax_error
--				error_handler.report_SSCU_error (filename, current_position)
				column := ms_column
				line := ms_line

				more
			
end
end
end
else
if yy_act <= 112 then
if yy_act <= 110 then
if yy_act = 109 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 468 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 468")
end

				more
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 471 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 471")
end

				set_start_condition (INITIAL)
			
end
else
if yy_act = 111 then
	yy_column := yy_column + 2
--|#line 474 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 474")
end

					-- Syntax error: Invalid special character
					-- in manifest strings.
				column := yy_column - 1
				line := yy_line
--				set_syntax_error
--				error_handler.report_SSSC_error (filename, current_position)
				column := ms_column
				line := ms_line

				more
			
else
	yy_column := yy_column + 1
--|#line 486 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 486")
end

					-- Syntax error: invalid special character
					-- %l in manifest strings.
				column := yy_column
				line := yy_line
				set_syntax_error
				error_handler.report_SSSC_error (filename, current_position)
				column := ms_column
				line := ms_line

				last_token := E_STRERR
				set_start_condition (INITIAL)
			
end
end
else
if yy_act <= 114 then
if yy_act = 113 then
	yy_line := yy_line + 1
	yy_column := 1
--|#line 499 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 499")
end

					-- Syntax error: Invalid new-line in manifest string.
				column := 1
				line := yy_line
				set_syntax_error
				error_handler.report_SSNL_error (filename, current_position)
				column := ms_column
				line := ms_line

				last_token := E_STRERR
				set_start_condition (INITIAL)
			
else
	yy_line := yy_line + 1
	yy_column := 1
--|#line 527 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 527")
end

				more
				set_start_condition (MSN)
			
end
else
if yy_act = 115 then
	yy_column := yy_column + 1
--|#line 531 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 531")
end

					-- Should never happen.
				last_token := E_STRERR
				report_syntax_error (current_position)
				set_start_condition (INITIAL)
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 546 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 546")
end

				more
				set_start_condition (MS)
			
end
end
end
end
else
if yy_act <= 124 then
if yy_act <= 120 then
if yy_act <= 118 then
if yy_act = 117 then
	yy_line := yy_line + 1
	yy_column := 1
--|#line 550 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 550")
end

					-- Syntax error: empty line in middle of
					-- multi-line manifest string.
				column := 1
				line := yy_line - 1
--				set_syntax_error
--				error_handler.report_SSEL_error (filename, current_position)
				column := ms_column
				line := ms_line

				more
			
else
	yy_column := yy_column + 1
--|#line 562 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 562")
end

					-- Syntax error: missing character % at beginning
					-- of line in multi-line manifest string.
				column := yy_column - 1
				line := yy_line
				set_syntax_error
				error_handler.report_SSNP_error (filename, current_position)
				column := ms_column
				line := ms_line

				last_token := E_STRERR
				set_start_condition (INITIAL)
			
end
else
if yy_act = 119 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 593 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 593")
end

			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 599 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 599")
end

			
end
end
else
if yy_act <= 122 then
if yy_act = 121 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 601 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 601")
end

			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 603 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 603")
end

					-- Syntax error: an underscore may not be
					-- the first character of an integer.
				set_syntax_error
				error_handler.report_SIFU_error (filename, current_position)

				last_token := E_INTERR
			
end
else
if yy_act = 123 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 611 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 611")
end

					-- Syntax error: an underscore may not be
					-- the last character of an integer.
				set_syntax_error
				error_handler.report_SILU_error (filename, current_position)

				last_token := E_INTERR
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 619 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 619")
end

			
end
end
end
else
if yy_act <= 128 then
if yy_act <= 126 then
if yy_act = 125 then
	yy_end := yy_end - 1
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 625 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 625")
end

			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 626 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 626")
end

			
end
else
if yy_act = 127 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 627 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 627")
end

			
else
	yy_end := yy_end - 1
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 629 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 629")
end

			
end
end
else
if yy_act <= 130 then
if yy_act = 129 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 630 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 630")
end

			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 631 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 631")
end

			
end
else
if yy_act = 131 then
	yy_column := yy_column + 1
--|#line 641 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 641")
end

				last_token := E_UNKNOWN
			
else
yy_set_line_column
--|#line 0 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 0")
end
last_token := yyError_token
fatal_error ("scanner jammed")
end
end
end
end
end
end
end
		end

	yy_execute_eof_action (yy_sc: INTEGER) is
			-- Execute EOF semantic action.
		do
			inspect yy_sc
when 0 then
--|#line 0 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 0")
end
terminate
when 1 then
--|#line 0 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 0")
end

					-- Syntax error: missing double quote at
					-- end of manifest string.
				column := yy_column
				line := yy_line
				set_syntax_error
				error_handler.report_SSEQ_error (filename, current_position)
				column := ms_column
				line := ms_line

				last_token := E_STRERR
				set_start_condition (INITIAL)
			
when 2 then
--|#line 0 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 0")
end

					-- Syntax error: missing character % at beginning
					-- of line in multi-line manifest string.
				column := yy_column
				line := yy_line
				set_syntax_error
				error_handler.report_SSNP_error (filename, current_position)
				column := ms_column
				line := ms_line

				last_token := E_STRERR
				set_start_condition (INITIAL)
			
when 3 then
--|#line 0 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 0")
end

					-- Should never happen.
				last_token := E_STRERR
				report_syntax_error (current_position)
				set_start_condition (INITIAL)
			
when 4 then
--|#line 0 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 0")
end

					-- No final brace-double-quote.
				last_token := E_STRERR
				report_syntax_error (current_position)
				set_start_condition (INITIAL)
			
when 5 then
--|#line 0 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 0")
end

					-- No final brace-double-quote.
				last_token := E_STRERR
				report_syntax_error (current_position)
				set_start_condition (INITIAL)
			
when 6 then
--|#line 0 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 0")
end

					-- No final brace-double-quote.
				last_token := E_STRERR
				report_syntax_error (current_position)
				set_start_condition (INITIAL)
			
when 7 then
--|#line 0 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 0")
end

					-- No final bracket-double-quote.
				last_token := E_STRERR
				report_syntax_error (current_position)
				set_start_condition (INITIAL)
			
when 8 then
--|#line 0 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 0")
end

					-- No final bracket-double-quote.
				last_token := E_STRERR
				report_syntax_error (current_position)
				set_start_condition (INITIAL)
			
when 9 then
--|#line 0 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 0")
end

					-- No final bracket-double-quote.
				last_token := E_STRERR
				report_syntax_error (current_position)
				set_start_condition (INITIAL)
			
			else
				terminate
			end
		end

feature {NONE} -- Table templates

	yy_nxt_template: SPECIAL [INTEGER] is
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make (0, 1775)
			yy_nxt_template_1 (an_array)
			yy_nxt_template_2 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_nxt_template_1 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			    0,   22,   23,   24,   23,   25,   26,   27,   22,   28,
			   25,   25,   29,   30,   31,   32,   33,   34,   35,   36,
			   25,   37,   38,   39,   40,   41,   42,   43,   44,   40,
			   40,   45,   40,   40,   46,   40,   47,   48,   49,   40,
			   50,   51,   52,   53,   54,   55,   56,   40,   40,   25,
			   57,   25,   58,   39,   40,   41,   42,   44,   40,   46,
			   47,   40,   50,   51,   52,   53,   54,   25,   25,   25,
			   60,   60,  224,   61,   61,   62,   62,   64,   65,   64,
			   64,   65,   64,   66,   80,   81,   66,   68,   69,   68,
			   68,   69,   68,   71,   72,   71,   71,   72,   71,   74,

			   75,   76,  224,   77,   74,   75,   76,  311,   77,   80,
			   81,   83,   84,   83,   83,   84,   83,   86,   87,   88,
			  312,   89,   86,   87,   88,  483,   89,   92,   93,   92,
			   93,   94,   94,   94,   94,   94,   94,   97,  105,   98,
			  150,   95,  103,  104,   95,  106,  106,  106,  107,  107,
			  107,  106,  108,  137,  109,  109,  110,  144,  108,  138,
			  109,  109,  110,  111,  150,   78,   90,  106,  106,  111,
			   78,   90,  108,  125,  110,  110,  110,  106,  106,  144,
			   99,  480,  115,  126,  127,  112,  128,  116,  146,  117,
			  158,  113,  159,  111,  118,  119,  129,  113,  100,  111,

			  106,  153,  130,  147,  175,  176,  131,  177,  479,  127,
			  128,  113,  116,  117,  120,  133,  118,  119,  121,  132,
			  148,  122,  134,  135,  123,  147,  151,  124,  136,  153,
			  149,  478,  130,  155,  155,  155,  170,  171,  170,  476,
			  152,  132,  120,  121,  133,  140,  123,  135,  148,  124,
			  136,  475,  149,  185,  186,  141,  151,  142,  167,  168,
			  167,  143,  187,  186,  169,  172,  173,  172,  175,  182,
			  156,  183,  158,  174,  159,  140,  188,  189,  188,  474,
			  141,  142,  472,  143,  160,  161,  162,  163,  160,  164,
			  160,  164,  164,  164,  160,  160,  160,  165,  160,  160,

			  160,  160,  164,  160,  164,  160,  164,  164,  164,  164,
			  160,  164,  160,  164,  160,  160,  160,  164,  160,  164,
			  160,  160,  164,  164,  164,  164,  164,  164,  160,  160,
			  160,  160,  160,  160,  160,  160,  166,  166,  166,  166,
			  166,  166,  166,  166,  166,  166,  166,  166,  166,  166,
			  160,  160,  160,  178,  175,  179,   94,  177,  178,  181,
			  179,  463,  177,  191,  192,  213,  193,  194,  191,  195,
			  239,  193,  194,  197,  195,  453,  193,  191,  198,   97,
			  199,   98,  190,  201,  202,  203,  202,   94,   94,   94,
			  206,  207,  206,  313,   97,  239,   98,   95,  208,  209,

			  208,  451,   97,  228,   98,  107,  107,  107,  217,  217,
			  217,  108,  450,  110,  110,  110,  196,  214,  313,  180,
			  218,  196,   99,  108,  180,  109,  109,  110,  220,  220,
			  220,  225,  222,  228,  111,  223,  226,   99,  448,  231,
			  100,  235,  215,  229,  232,   99,  234,  237,  233,  240,
			  113,  238,  441,  225,  251,  100,  236,  249,  226,  252,
			  223,  231,  113,  100,  111,  113,  253,  229,  234,  250,
			  254,  235,  264,  238,  232,  266,  251,  233,  236,  240,
			  243,  252,  244,  270,  245,  273,  267,  249,  262,  185,
			  186,  268,  263,  387,  264,  246,  253,  266,  247,  158,

			  254,  159,  269,  175,  176,  270,  177,  273,  187,  186,
			  243,  244,  245,  262,  201,  202,  267,  246,  203,  202,
			  247,  256,  387,  257,  269,  155,  155,  155,  155,  155,
			  155,  258,  181,  176,  259,  177,  260,  261,  276,  277,
			  276,  276,  278,  276,  279,  279,  279,  167,  168,  167,
			  383,  256,  257,  169,  440,  258,  259,  436,  260,  261,
			  191,  192,  274,  193,  434,  156,  170,  171,  170,  172,
			  173,  172,  178,  175,  179,  383,  177,  178,  181,  179,
			  293,  177,  175,  182,  280,  183,   98,  174,  181,  182,
			   94,  183,  397,  174,  188,  189,  188,  197,  192,  213,

			  193,  194,  191,  195,  293,  193,  194,  197,  195,  296,
			  193,  191,  198,  433,  199,  294,  190,  197,  198,  297,
			  199,  397,  190,  281,  281,  281,  206,  207,  206,  298,
			   97,  296,   98,  208,  209,  208,  432,   97,  180,   98,
			  282,  431,  300,  180,  429,  294,  283,  283,  283,  297,
			  196,  298,  284,  284,  299,  196,  285,  285,  285,  286,
			  286,  286,  217,  217,  217,  289,  289,  301,  302,  290,
			  290,  290,  300,   99,  287,  291,  299,  220,  220,  220,
			   99,  305,  309,  306,  310,  318,  320,  329,  330,  301,
			  302,  100,  325,  331,  337,  326,  215,  307,  100,  288,

			  335,  343,  344,  305,  309,  333,  310,  340,  371,  428,
			  330,  332,  426,  306,  292,  318,  320,  329,  337,  345,
			  345,  345,  325,  331,  326,  394,  344,  333,  425,  340,
			  335,  343,  371,  332,  346,  346,  346,  276,  277,  276,
			  347,  279,  279,  279,  204,  281,  281,  281,  348,  283,
			  283,  283,  285,  285,  285,  394,  274,  285,  285,  285,
			  286,  286,  286,  351,  351,  424,  418,  352,  352,  352,
			  358,  359,  350,  353,  353,  353,  290,  290,  290,  290,
			  290,  290,  363,  356,  356,  356,  220,  220,  220,  365,
			  368,  370,  358,  359,  349,  357,  372,  215,  373,  375,

			  380,  384,  382,  385,  363,  388,  391,  392,  395,  398,
			  288,  365,  368,  370,  399,  400,  354,  158,  372,  159,
			  373,  375,  380,  292,  382,  385,  384,  388,  391,  401,
			  395,  398,  392,  345,  345,  345,  402,  402,  402,  399,
			  157,  346,  346,  346,  410,  400,  403,  403,  415,  396,
			  404,  404,  404,  352,  352,  352,  352,  352,  352,  353,
			  353,  353,  407,  407,  407,  356,  356,  356,  410,  412,
			  274,  406,  415,  349,  408,  408,  411,  406,  409,  409,
			  409,  413,  416,  417,  419,  414,  420,  421,  422,  423,
			  427,  412,  393,  405,  430,  435,  288,  437,  439,  354,

			  438,  442,  288,  390,  416,  446,  411,  389,  420,  386,
			  422,  421,  417,  423,  419,  381,  430,  435,  379,  437,
			  427,  447,  438,  378,  377,  442,  376,  446,  439,  402,
			  402,  402,  404,  404,  404,  404,  404,  404,  443,  443,
			  443,  444,  444,  447,  452,  445,  445,  445,  407,  407,
			  407,  409,  409,  409,  409,  409,  409,  449,  454,  455,
			  456,  374,  457,  458,  459,  460,  349,  464,  461,  369,
			  462,  465,  349,  468,  452,  405,  466,  367,  469,  449,
			  454,  470,  456,  455,  457,  354,  459,  460,  467,  464,
			  471,  354,  461,  458,  462,  465,  473,  468,  466,  443, yy_Dummy>>,
			1, 1000, 0)
		end

	yy_nxt_template_2 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			  443,  443,  445,  445,  445,  445,  445,  445,  469,  477,
			  467,  470,  481,  482,  366,  471,  364,  219,  219,  362,
			  473,  219,  219,  219,  361,  360,  342,  341,  339,  338,
			  336,  334,  328,  327,  481,  482,  405,  324,  323,  477,
			  322,  321,  405,   59,   59,   59,   59,   59,   59,   59,
			   59,   59,   59,   59,   59,   59,   59,   59,   59,   59,
			   59,   59,   59,   59,   59,   59,   59,   59,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   67,   67,   67,   67,   67,   67,   67,

			   67,   67,   67,   67,   67,   67,   67,   67,   67,   67,
			   67,   67,   67,   67,   67,   67,   67,   67,   70,   70,
			   70,   70,   70,   70,   70,   70,   70,   70,   70,   70,
			   70,   70,   70,   70,   70,   70,   70,   70,   70,   70,
			   70,   70,   70,   73,   73,   73,   73,   73,   73,   73,
			   73,   73,   73,   73,   73,   73,   73,   73,   73,   73,
			   73,   73,   73,   73,   73,   73,   73,   73,   79,   79,
			   79,   79,   79,   79,   79,   79,   79,   79,   79,   79,
			   79,   79,   79,   79,   79,   79,   79,   79,   79,   79,
			   79,   79,   79,   82,   82,   82,   82,   82,   82,   82,

			   82,   82,   82,   82,   82,   82,   82,   82,   82,   82,
			   82,   82,   82,   82,   82,   82,   82,   82,   85,   85,
			   85,   85,   85,   85,   85,   85,   85,   85,   85,   85,
			   85,   85,   85,   85,   85,   85,   85,   85,   85,   85,
			   85,   85,   85,   91,   91,   91,   91,   91,   91,   91,
			   91,   91,   91,   91,   91,   91,   91,   91,   91,   91,
			   91,   91,   91,   91,   91,   91,   91,   91,   96,   96,
			  319,   96,   96,   96,   96,   96,   96,   96,   96,   96,
			   96,   96,   96,   96,   96,   96,   96,   96,   96,   96,
			   96,   96,   96,  101,  317,  316,  315,  314,  308,  101,

			  101,  101,  101,  101,  101,  101,  101,  101,  101,  101,
			  101,  101,  101,  101,  101,  101,  101,  101,  102,  102,
			  304,  102,  102,  102,  102,  102,  102,  102,  102,  102,
			  102,  102,  102,  102,  102,  102,  102,  102,  102,  102,
			  102,  102,  102,  114,  114,  303,  295,  114,  114,  114,
			  114,  114,  114,  114,  114,  114,  114,  114,  114,  157,
			  157,  282,  157,  157,  157,  157,  157,  157,  157,  157,
			  157,  157,  157,  157,  157,  157,  157,  157,  157,  157,
			  157,  157,  157,  157,  174,  174,  174,  174,  174,  174,
			  174,  174,  174,  174,  174,  174,  174,  174,  174,  174,

			  174,  174,  174,  174,  174,  174,  174,  174,  174,  180,
			  180,  180,  180,  180,  180,  180,  180,  180,  180,  180,
			  180,  180,  180,  180,  180,  180,  180,  180,  180,  180,
			  180,  180,  180,  180,  184,  184,  184,  184,  184,  184,
			  184,  184,  184,  184,  184,  184,  184,  184,  184,  184,
			  184,  184,  184,  184,  184,  184,  184,  184,  184,  190,
			  190,  190,  190,  190,  190,  190,  190,  190,  190,  190,
			  190,  190,  190,  190,  190,  190,  190,  190,  190,  190,
			  190,  190,  190,  190,  196,  196,  196,  196,  196,  196,
			  196,  196,  196,  196,  196,  196,  196,  196,  196,  196,

			  196,  196,  196,  196,  196,  196,  196,  196,  196,  200,
			  200,  200,  200,  200,  200,  200,  200,  200,  200,  200,
			  200,  200,  200,  200,  200,  200,  200,  200,  200,  200,
			  200,  200,  200,  200,  204,  204,  204,  204,  275,  272,
			  271,  204,  204,  204,  204,  204,  265,  204,  204,  204,
			  204,  204,  211,  211,  255,  211,  211,  211,  211,  211,
			  211,  211,  211,  211,  211,  211,  211,  211,  211,  211,
			  211,  211,  211,  211,  211,  211,  211,  105,  105,  105,
			  105,  105,  105,  105,  105,  105,  105,  105,  105,  105,
			  105,  105,  105,  105,  105,  105,  105,  105,  105,  105,

			  105,  105,  216,  216,  216,  216,  216,  216,  216,  216,
			  248,  216,  216,  216,  216,  216,  216,  216,  216,  216,
			  216,  216,  216,  216,  216,  216,  216,  157,  157,  157,
			  157,  242,  241,  230,  157,  157,  157,  157,  157,  227,
			  157,  157,  157,  157,  157,  204,  204,  221,  204,  204,
			  204,  204,  204,  204,  204,  204,  204,  204,  204,  204,
			  204,  204,  204,  204,  204,  204,  204,  204,  204,  204,
			  355,  355,  355,  355,  355,  355,  355,  355,  210,  355,
			  355,  355,  355,  355,  355,  355,  355,  355,  355,  355,
			  355,  355,  355,  355,  355,  212,  210,  205,  105,  106,

			  154,  145,  139,  106,  106,  484,   21,  484,  484,  484,
			  484,  484,  484,  484,  484,  484,  484,  484,  484,  484,
			  484,  484,  484,  484,  484,  484,  484,  484,  484,  484,
			  484,  484,  484,  484,  484,  484,  484,  484,  484,  484,
			  484,  484,  484,  484,  484,  484,  484,  484,  484,  484,
			  484,  484,  484,  484,  484,  484,  484,  484,  484,  484,
			  484,  484,  484,  484,  484,  484,  484,  484,  484,  484,
			  484,  484,  484,  484,  484,  484, yy_Dummy>>,
			1, 776, 1000)
		end

	yy_chk_template: SPECIAL [INTEGER] is
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make (0, 1775)
			yy_chk_template_1 (an_array)
			yy_chk_template_2 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_chk_template_1 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			    0,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    3,    4,  117,    3,    4,    3,    4,    5,    5,    5,
			    6,    6,    6,    5,   13,   13,    6,    7,    7,    7,
			    8,    8,    8,    9,    9,    9,   10,   10,   10,   11,

			   11,   11,  117,   11,   12,   12,   12,  241,   12,   14,
			   14,   15,   15,   15,   16,   16,   16,   17,   17,   17,
			  241,   17,   18,   18,   18,  477,   18,   19,   19,   20,
			   20,   23,   23,   23,   24,   24,   24,   26,   29,   26,
			   53,   23,   28,   28,   24,   31,   30,   29,   30,   30,
			   30,   31,   32,   46,   32,   32,   32,   49,   33,   46,
			   33,   33,   33,   32,   53,   11,   17,   36,   36,   33,
			   12,   18,   34,   42,   34,   34,   34,   37,   37,   49,
			   26,  467,   39,   42,   43,   32,   43,   39,   51,   39,
			   59,   32,   59,   32,   39,   39,   43,   33,   26,   33,

			   31,   55,   44,   51,   73,   73,   44,   73,  465,   43,
			   43,   34,   39,   39,   41,   45,   39,   39,   41,   44,
			   52,   41,   45,   45,   41,   51,   54,   41,   45,   55,
			   52,  464,   44,   58,   58,   58,   68,   68,   68,  461,
			   54,   44,   41,   41,   45,   48,   41,   45,   52,   41,
			   45,  460,   52,   79,   79,   48,   54,   48,   64,   64,
			   64,   48,   81,   81,   64,   71,   71,   71,   78,   78,
			   58,   78,  157,   78,  157,   48,   83,   83,   83,  459,
			   48,   48,  455,   48,   62,   62,   62,   62,   62,   62,
			   62,   62,   62,   62,   62,   62,   62,   62,   62,   62,

			   62,   62,   62,   62,   62,   62,   62,   62,   62,   62,
			   62,   62,   62,   62,   62,   62,   62,   62,   62,   62,
			   62,   62,   62,   62,   62,   62,   62,   62,   62,   62,
			   62,   62,   62,   62,   62,   62,   62,   62,   62,   62,
			   62,   62,   62,   62,   62,   62,   62,   62,   62,   62,
			   62,   62,   62,   74,   74,   74,  105,   74,   76,   76,
			   76,  435,   76,   85,   85,  105,   85,   86,   86,   86,
			  130,   86,   88,   88,   88,  422,   88,   90,   90,   96,
			   90,   96,   90,   91,   91,   93,   93,   94,   94,   94,
			   99,   99,   99,  242,   99,  130,   99,   94,  100,  100,

			  100,  419,  100,  121,  100,  107,  107,  107,  108,  108,
			  108,  110,  416,  110,  110,  110,   86,  107,  242,   74,
			  108,   88,   96,  109,   76,  109,  109,  109,  113,  113,
			  113,  118,  116,  121,  109,  116,  119,   99,  414,  124,
			   96,  128,  107,  122,  125,  100,  127,  129,  125,  131,
			  110,  129,  398,  118,  139,   99,  128,  138,  119,  140,
			  116,  124,  109,  100,  109,  113,  141,  122,  127,  138,
			  142,  128,  147,  129,  125,  149,  139,  125,  128,  131,
			  135,  140,  135,  151,  135,  154,  150,  138,  146,  184,
			  184,  150,  146,  327,  147,  135,  141,  149,  135,  164,

			  142,  164,  150,  174,  174,  151,  174,  154,  186,  186,
			  135,  135,  135,  146,  200,  200,  150,  135,  202,  202,
			  135,  145,  327,  145,  150,  155,  155,  155,  156,  156,
			  156,  145,  176,  176,  145,  176,  145,  145,  161,  161,
			  161,  163,  163,  163,  165,  165,  165,  167,  167,  167,
			  320,  145,  145,  167,  397,  145,  145,  391,  145,  145,
			  190,  190,  155,  190,  389,  156,  170,  170,  170,  172,
			  172,  172,  178,  178,  178,  320,  178,  179,  179,  179,
			  221,  179,  180,  180,  204,  180,  204,  180,  182,  182,
			  213,  182,  339,  182,  188,  188,  188,  192,  192,  213,

			  192,  194,  194,  194,  221,  194,  195,  195,  195,  226,
			  195,  196,  196,  388,  196,  222,  196,  198,  198,  227,
			  198,  339,  198,  205,  205,  205,  206,  206,  206,  228,
			  206,  226,  206,  208,  208,  208,  387,  208,  178,  208,
			  212,  386,  230,  179,  384,  222,  212,  212,  212,  227,
			  194,  228,  214,  214,  229,  195,  214,  214,  214,  215,
			  215,  215,  217,  217,  217,  218,  218,  231,  232,  218,
			  218,  218,  230,  206,  217,  220,  229,  220,  220,  220,
			  208,  236,  239,  237,  240,  247,  249,  258,  259,  231,
			  232,  206,  255,  260,  265,  255,  215,  237,  208,  217,

			  263,  271,  272,  236,  239,  261,  240,  268,  306,  382,
			  259,  260,  380,  237,  220,  247,  249,  258,  265,  274,
			  274,  274,  255,  260,  255,  334,  272,  261,  378,  268,
			  263,  271,  306,  260,  275,  275,  275,  276,  276,  276,
			  279,  279,  279,  279,  281,  281,  281,  281,  283,  283,
			  283,  283,  284,  284,  284,  334,  274,  285,  285,  285,
			  286,  286,  286,  287,  287,  377,  370,  287,  287,  287,
			  293,  294,  286,  288,  288,  288,  289,  289,  289,  290,
			  290,  290,  298,  291,  291,  291,  292,  292,  292,  300,
			  303,  305,  293,  294,  285,  291,  307,  286,  308,  310,

			  316,  323,  318,  325,  298,  328,  331,  332,  335,  340,
			  288,  300,  303,  305,  341,  342,  290,  347,  307,  347,
			  308,  310,  316,  292,  318,  325,  323,  328,  331,  348,
			  335,  340,  332,  345,  345,  345,  349,  349,  349,  341,
			  346,  346,  346,  346,  360,  342,  350,  350,  366,  336,
			  350,  350,  350,  351,  351,  351,  352,  352,  352,  353,
			  353,  353,  354,  354,  354,  356,  356,  356,  360,  364,
			  345,  353,  366,  349,  357,  357,  361,  356,  357,  357,
			  357,  365,  368,  369,  371,  365,  372,  373,  375,  376,
			  381,  364,  333,  352,  385,  390,  353,  392,  395,  354,

			  394,  400,  356,  330,  368,  411,  361,  329,  372,  326,
			  375,  373,  369,  376,  371,  317,  385,  390,  315,  392,
			  381,  412,  394,  314,  313,  400,  312,  411,  395,  402,
			  402,  402,  403,  403,  403,  404,  404,  404,  405,  405,
			  405,  406,  406,  412,  421,  406,  406,  406,  407,  407,
			  407,  408,  408,  408,  409,  409,  409,  415,  424,  425,
			  426,  309,  427,  428,  429,  430,  402,  439,  432,  304,
			  433,  440,  404,  448,  421,  405,  442,  302,  450,  415,
			  424,  451,  426,  425,  427,  407,  429,  430,  446,  439,
			  452,  409,  432,  428,  433,  440,  458,  448,  442,  443, yy_Dummy>>,
			1, 1000, 0)
		end

	yy_chk_template_2 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			  443,  443,  444,  444,  444,  445,  445,  445,  450,  462,
			  446,  451,  473,  475,  301,  452,  299,  509,  509,  297,
			  458,  509,  509,  509,  296,  295,  270,  269,  267,  266,
			  264,  262,  257,  256,  473,  475,  443,  254,  252,  462,
			  251,  250,  445,  485,  485,  485,  485,  485,  485,  485,
			  485,  485,  485,  485,  485,  485,  485,  485,  485,  485,
			  485,  485,  485,  485,  485,  485,  485,  485,  486,  486,
			  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,
			  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,
			  486,  486,  486,  487,  487,  487,  487,  487,  487,  487,

			  487,  487,  487,  487,  487,  487,  487,  487,  487,  487,
			  487,  487,  487,  487,  487,  487,  487,  487,  488,  488,
			  488,  488,  488,  488,  488,  488,  488,  488,  488,  488,
			  488,  488,  488,  488,  488,  488,  488,  488,  488,  488,
			  488,  488,  488,  489,  489,  489,  489,  489,  489,  489,
			  489,  489,  489,  489,  489,  489,  489,  489,  489,  489,
			  489,  489,  489,  489,  489,  489,  489,  489,  490,  490,
			  490,  490,  490,  490,  490,  490,  490,  490,  490,  490,
			  490,  490,  490,  490,  490,  490,  490,  490,  490,  490,
			  490,  490,  490,  491,  491,  491,  491,  491,  491,  491,

			  491,  491,  491,  491,  491,  491,  491,  491,  491,  491,
			  491,  491,  491,  491,  491,  491,  491,  491,  492,  492,
			  492,  492,  492,  492,  492,  492,  492,  492,  492,  492,
			  492,  492,  492,  492,  492,  492,  492,  492,  492,  492,
			  492,  492,  492,  493,  493,  493,  493,  493,  493,  493,
			  493,  493,  493,  493,  493,  493,  493,  493,  493,  493,
			  493,  493,  493,  493,  493,  493,  493,  493,  494,  494,
			  248,  494,  494,  494,  494,  494,  494,  494,  494,  494,
			  494,  494,  494,  494,  494,  494,  494,  494,  494,  494,
			  494,  494,  494,  495,  246,  245,  244,  243,  238,  495,

			  495,  495,  495,  495,  495,  495,  495,  495,  495,  495,
			  495,  495,  495,  495,  495,  495,  495,  495,  496,  496,
			  234,  496,  496,  496,  496,  496,  496,  496,  496,  496,
			  496,  496,  496,  496,  496,  496,  496,  496,  496,  496,
			  496,  496,  496,  497,  497,  233,  225,  497,  497,  497,
			  497,  497,  497,  497,  497,  497,  497,  497,  497,  498,
			  498,  211,  498,  498,  498,  498,  498,  498,  498,  498,
			  498,  498,  498,  498,  498,  498,  498,  498,  498,  498,
			  498,  498,  498,  498,  499,  499,  499,  499,  499,  499,
			  499,  499,  499,  499,  499,  499,  499,  499,  499,  499,

			  499,  499,  499,  499,  499,  499,  499,  499,  499,  500,
			  500,  500,  500,  500,  500,  500,  500,  500,  500,  500,
			  500,  500,  500,  500,  500,  500,  500,  500,  500,  500,
			  500,  500,  500,  500,  501,  501,  501,  501,  501,  501,
			  501,  501,  501,  501,  501,  501,  501,  501,  501,  501,
			  501,  501,  501,  501,  501,  501,  501,  501,  501,  502,
			  502,  502,  502,  502,  502,  502,  502,  502,  502,  502,
			  502,  502,  502,  502,  502,  502,  502,  502,  502,  502,
			  502,  502,  502,  502,  503,  503,  503,  503,  503,  503,
			  503,  503,  503,  503,  503,  503,  503,  503,  503,  503,

			  503,  503,  503,  503,  503,  503,  503,  503,  503,  504,
			  504,  504,  504,  504,  504,  504,  504,  504,  504,  504,
			  504,  504,  504,  504,  504,  504,  504,  504,  504,  504,
			  504,  504,  504,  504,  505,  505,  505,  505,  159,  153,
			  152,  505,  505,  505,  505,  505,  148,  505,  505,  505,
			  505,  505,  506,  506,  144,  506,  506,  506,  506,  506,
			  506,  506,  506,  506,  506,  506,  506,  506,  506,  506,
			  506,  506,  506,  506,  506,  506,  506,  507,  507,  507,
			  507,  507,  507,  507,  507,  507,  507,  507,  507,  507,
			  507,  507,  507,  507,  507,  507,  507,  507,  507,  507,

			  507,  507,  508,  508,  508,  508,  508,  508,  508,  508,
			  137,  508,  508,  508,  508,  508,  508,  508,  508,  508,
			  508,  508,  508,  508,  508,  508,  508,  510,  510,  510,
			  510,  134,  132,  123,  510,  510,  510,  510,  510,  120,
			  510,  510,  510,  510,  510,  511,  511,  115,  511,  511,
			  511,  511,  511,  511,  511,  511,  511,  511,  511,  511,
			  511,  511,  511,  511,  511,  511,  511,  511,  511,  511,
			  512,  512,  512,  512,  512,  512,  512,  512,  104,  512,
			  512,  512,  512,  512,  512,  512,  512,  512,  512,  512,
			  512,  512,  512,  512,  512,  103,  102,   98,   95,   57,

			   56,   50,   47,   38,   35,   21,  484,  484,  484,  484,
			  484,  484,  484,  484,  484,  484,  484,  484,  484,  484,
			  484,  484,  484,  484,  484,  484,  484,  484,  484,  484,
			  484,  484,  484,  484,  484,  484,  484,  484,  484,  484,
			  484,  484,  484,  484,  484,  484,  484,  484,  484,  484,
			  484,  484,  484,  484,  484,  484,  484,  484,  484,  484,
			  484,  484,  484,  484,  484,  484,  484,  484,  484,  484,
			  484,  484,  484,  484,  484,  484, yy_Dummy>>,
			1, 776, 1000)
		end

	yy_base_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,   67,   68,   75,   78,   85,   88,   91,
			   94,   97,  102,   81,  106,  109,  112,  115,  120,  124,
			  126, 1705, 1706,  129,  132, 1706,  131,    0,  134,  126,
			  133,  131,  139,  145,  159, 1684,  148,  157, 1683,  153,
			    0,  184,  146,  150,  179,  187,  122, 1665,  221,  117,
			 1674,  161,  190,  104,  203,  171, 1663, 1649,  218,  184,
			 1706, 1706,  283, 1706,  256, 1706, 1706, 1706,  234, 1706,
			 1706,  263, 1706,  201,  351, 1706,  356, 1706,  265,  250,
			 1706,  259, 1706,  274, 1706,  360,  365, 1706,  370, 1706,
			  374,  380, 1706,  382,  385, 1686,  373, 1706, 1683,  388,

			  396,    0, 1687, 1681, 1669,  353, 1706,  390,  393,  410,
			  398, 1706,    0,  413,    0, 1620,  401,   46,  390,  394,
			 1612,  380,  407, 1606,  399,  420,    0,  405,  415,  409,
			  336,  426, 1595,    0, 1593,  454,    0, 1577,  432,  412,
			  418,  440,  445,    0, 1527,  495,  454,  432, 1519,  432,
			  460,  443, 1509, 1512,  445,  510,  513,  266, 1706, 1524,
			 1706,  536, 1706,  539,  493,  529, 1706,  545, 1706, 1706,
			  564, 1706,  567, 1706,  500, 1706,  529, 1706,  570,  575,
			  579, 1706,  585, 1706,  486, 1706,  505, 1706,  592, 1706,
			  557, 1706,  594, 1706,  599,  604,  608, 1706,  614, 1706,

			  511, 1706,  515, 1706,  578,  608,  624, 1706,  631, 1706,
			 1706, 1352,  631,  587,  641,  644, 1706,  647,  654,    0,
			  662,  544,  592,    0,    0, 1315,  569,  594,  588,  610,
			  619,  627,  625, 1318, 1293,    0,  638,  660, 1271,  641,
			  642,   72,  359, 1270, 1265, 1268, 1256,  662, 1243,  663,
			 1003, 1013, 1001,    0, 1010,  667, 1006, 1005,  664,  645,
			  668,  665, 1004,  677,  999,  658, 1002, 1001,  668,  996,
			  995,  675,  666,    0,  704,  719,  735, 1706, 1706,  726,
			 1706,  730, 1706,  734,  737,  742,  745,  752,  758,  761,
			  764,  768,  771,  728,  730,  996,  993,  986,  741,  989,

			  747,  987,  948,  750,  938,  751,  672,  756,  758,  934,
			  756,    0,  899,  893,  877,  872,  760,  888,  762,    0,
			  516,    0,    0,  767,    0,  760,  878,  465,  765,  872,
			  872,  763,  773,  845,  700,  768,  811,    0,    0,  564,
			  766,  780,  792,    0,    0,  818,  826,  811,  820,  821,
			  835,  838,  841,  844,  847, 1706,  850,  863,    0,    0,
			  808,  852,    0,    0,  829,  854,  812,    0,  842,  855,
			  739,  858,  844,  851,    0,  848,  853,  738,  697,    0,
			  681,  865,  678,    0,  617,  854,  595,  605,  586,  537,
			  855,  530,  855,    0,  858,  875,    0,  523,  425,    0,

			  865, 1706,  914,  917,  920,  923,  930,  933,  936,  939,
			    0,  862,  879,    0,  401,  915,  385,    0,    0,  374,
			    0,  921,  348,    0,  917,  923,  918,  920,  940,  922,
			  924,    0,  932,  934,    0,  334,    0,    0,    0,  925,
			  935,    0,  934,  984,  987,  990,  946,    0,  937,    0,
			  952,  955,  956,    0,    0,  253,    0,    0,  960,  252,
			  214,  212,  984,    0,  204,  181,    0,  154,    0,    0,
			    0,    0,    0,  970,    0,  973,    0,   98,    0,    0,
			    0,    0,    0,    0, 1706, 1042, 1067, 1092, 1117, 1142,
			 1167, 1192, 1217, 1242, 1267, 1292, 1317, 1333, 1358, 1383,

			 1408, 1433, 1458, 1483, 1508, 1529, 1551, 1576, 1601, 1007,
			 1622, 1644, 1669, yy_Dummy>>)
		end

	yy_def_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,  484,    1,  485,  485,  486,  486,  487,  487,  488,
			  488,  489,  489,  490,  490,  491,  491,  492,  492,  493,
			  493,  484,  484,  484,  484,  484,  494,  495,  496,  484,
			  484,  484,  484,  484,  484,  484,  484,  484,  484,  497,
			  497,  497,  497,  497,  497,  497,  497,  497,  497,  497,
			  497,  497,  497,  497,  497,  497,  497,  484,  484,  498,
			  484,  484,  484,  484,  484,  484,  484,  484,  484,  484,
			  484,  484,  484,  499,  499,  484,  499,  484,  500,  501,
			  484,  501,  484,  484,  484,  502,  502,  484,  502,  484,
			  503,  504,  484,  504,  484,  484,  494,  484,  505,  494,

			  494,  495,  484,  506,  484,  507,  484,  484,  508,  484,
			  484,  484,  509,  484,  497,  497,  497,  497,  497,  497,
			  497,  497,  497,  497,  497,  497,  497,  497,  497,  497,
			  497,  497,  497,  497,  497,  497,  497,  497,  497,  497,
			  497,  497,  497,  497,  497,  497,  497,  497,  497,  497,
			  497,  497,  497,  497,  497,  484,  484,  498,  484,  510,
			  484,  484,  484,  484,  498,  484,  484,  484,  484,  484,
			  484,  484,  484,  484,  499,  484,  499,  484,  499,  499,
			  500,  484,  500,  484,  501,  484,  501,  484,  484,  484,
			  502,  484,  502,  484,  502,  502,  503,  484,  503,  484,

			  504,  484,  504,  484,  511,  484,  494,  484,  494,  484,
			  484,  484,  484,  507,  484,  484,  484,  484,  484,  509,
			  484,  497,  497,  497,  497,  497,  497,  497,  497,  497,
			  497,  497,  497,  497,  497,  497,  497,  497,  497,  497,
			  497,  497,  497,  497,  497,  497,  497,  497,  497,  497,
			  497,  497,  497,  497,  497,  497,  497,  497,  497,  497,
			  497,  497,  497,  497,  497,  497,  497,  497,  497,  497,
			  497,  497,  497,  497,  484,  484,  484,  484,  484,  484,
			  484,  484,  484,  484,  484,  484,  484,  484,  484,  484,
			  484,  512,  484,  497,  497,  497,  497,  497,  497,  497,

			  497,  497,  497,  497,  497,  497,  497,  497,  497,  497,
			  497,  497,  497,  497,  497,  497,  497,  497,  497,  497,
			  497,  497,  497,  497,  497,  497,  497,  497,  497,  497,
			  497,  497,  497,  497,  497,  497,  497,  497,  497,  497,
			  497,  497,  497,  497,  497,  484,  484,  498,  484,  484,
			  484,  484,  484,  484,  484,  484,  484,  484,  497,  497,
			  497,  497,  497,  497,  497,  497,  497,  497,  497,  497,
			  497,  497,  497,  497,  497,  497,  497,  497,  497,  497,
			  497,  497,  497,  497,  497,  497,  497,  497,  497,  497,
			  497,  497,  497,  497,  497,  497,  497,  497,  497,  497,

			  497,  484,  484,  484,  484,  484,  484,  484,  484,  484,
			  497,  497,  497,  497,  497,  497,  497,  497,  497,  497,
			  497,  497,  497,  497,  497,  497,  497,  497,  497,  497,
			  497,  497,  497,  497,  497,  497,  497,  497,  497,  497,
			  497,  497,  497,  484,  484,  484,  497,  497,  497,  497,
			  497,  497,  497,  497,  497,  497,  497,  497,  497,  497,
			  497,  497,  497,  497,  497,  497,  497,  497,  497,  497,
			  497,  497,  497,  497,  497,  497,  497,  497,  497,  497,
			  497,  497,  497,  497,    0,  484,  484,  484,  484,  484,
			  484,  484,  484,  484,  484,  484,  484,  484,  484,  484,

			  484,  484,  484,  484,  484,  484,  484,  484,  484,  484,
			  484,  484,  484, yy_Dummy>>)
		end

	yy_ec_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    1,    1,    1,    1,    1,    1,    1,    1,    2,
			    3,    1,    1,    4,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    2,    5,    6,    7,    5,    8,    7,    9,
			   10,   10,    5,   11,    5,   12,   13,   14,   15,   16,
			   17,   17,   17,   17,   17,   17,   17,   17,   18,    5,
			   19,   20,   21,   22,    7,   23,   24,   25,   26,   27,
			   28,   29,   30,   31,   32,   33,   34,   35,   36,   37,
			   38,   39,   40,   41,   42,   43,   44,   45,   46,   47,
			   48,   49,   50,   51,    5,   52,    1,   53,   54,   55,

			   56,   27,   57,   29,   58,   31,   32,   33,   59,   35,
			   60,   37,   38,   61,   62,   63,   64,   65,   66,   45,
			   46,   47,   48,   67,    7,   68,   69,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,

			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1, yy_Dummy>>)
		end

	yy_meta_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    1,    2,    3,    4,    1,    5,    1,    6,    7,
			    8,    1,    1,    9,    7,   10,   10,   11,    1,   12,
			    1,   13,    1,   14,   14,   14,   15,   10,   16,   17,
			   18,   17,   17,   17,   19,   17,   20,   17,   17,   21,
			   21,   21,   21,   21,   22,   17,   17,   17,   23,    1,
			    1,    1,   24,   10,   10,   10,   10,   10,   17,   17,
			   17,   17,   17,   17,   17,   17,   25,    1,    1,    1, yy_Dummy>>)
		end

	yy_accept_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    2,    3,    4,    5,    5,    5,    6,    7,
			    8,    9,   10,   12,   15,   17,   20,   23,   26,   29,
			   32,   35,   38,   41,   44,   47,   50,   53,   56,   59,
			   62,   65,   68,   71,   74,   77,   80,   83,   86,   89,
			   92,   95,   98,  101,  104,  107,  110,  113,  115,  117,
			  119,  121,  123,  125,  127,  129,  131,  134,  136,  138,
			  140,  142,  144,  146,  148,  150,  152,  154,  156,  158,
			  160,  162,  164,  166,  168,  170,  172,  174,  176,  178,
			  180,  182,  184,  186,  188,  189,  189,  190,  192,  192,

			  194,  196,  197,  198,  199,  201,  202,  203,  205,  205,
			  206,  207,  208,  208,  208,  209,  210,  211,  212,  214,
			  215,  216,  217,  218,  219,  220,  221,  223,  224,  225,
			  226,  227,  228,  229,  231,  232,  233,  235,  236,  237,
			  238,  239,  240,  241,  243,  244,  245,  246,  247,  248,
			  249,  250,  251,  252,  253,  254,  254,  254,  255,  256,
			  256,  257,  258,  259,  260,  262,  264,  266,  266,  267,
			  268,  268,  269,  269,  270,  271,  272,  273,  274,  275,
			  276,  277,  279,  280,  282,  283,  284,  285,  287,  287,
			  288,  289,  290,  291,  292,  293,  294,  295,  297,  298,

			  300,  301,  302,  303,  305,  306,  306,  307,  308,  309,
			  310,  311,  312,  314,  315,  315,  315,  316,  318,  319,
			  320,  321,  322,  323,  325,  327,  328,  329,  330,  331,
			  332,  333,  334,  335,  336,  337,  339,  340,  341,  342,
			  343,  344,  345,  346,  347,  348,  349,  350,  351,  352,
			  353,  354,  356,  357,  359,  360,  361,  362,  363,  364,
			  365,  366,  367,  368,  369,  370,  371,  372,  373,  374,
			  375,  376,  377,  378,  380,  380,  380,  380,  381,  383,
			  384,  385,  385,  386,  387,  387,  389,  390,  390,  390,
			  390,  392,  392,  393,  394,  395,  396,  397,  398,  399,

			  400,  401,  402,  403,  404,  406,  407,  408,  409,  410,
			  411,  412,  414,  415,  416,  417,  418,  419,  420,  421,
			  423,  424,  426,  428,  429,  431,  432,  433,  434,  435,
			  436,  437,  438,  439,  440,  441,  442,  443,  445,  447,
			  448,  449,  450,  451,  453,  455,  456,  456,  458,  459,
			  459,  459,  459,  463,  464,  464,  465,  466,  467,  469,
			  471,  472,  473,  475,  477,  478,  479,  480,  482,  483,
			  484,  485,  486,  487,  488,  490,  491,  492,  493,  494,
			  496,  497,  498,  499,  501,  502,  503,  504,  505,  506,
			  507,  508,  509,  510,  512,  513,  514,  516,  517,  518,

			  520,  521,  522,  523,  523,  524,  524,  524,  525,  525,
			  526,  528,  529,  530,  532,  533,  534,  535,  537,  539,
			  540,  542,  543,  544,  546,  547,  548,  549,  550,  551,
			  552,  553,  555,  556,  557,  559,  560,  562,  564,  566,
			  567,  568,  570,  571,  573,  573,  575,  576,  578,  579,
			  581,  582,  583,  584,  586,  588,  589,  591,  593,  594,
			  595,  596,  597,  598,  600,  601,  602,  604,  605,  607,
			  609,  611,  613,  615,  616,  618,  619,  621,  622,  624,
			  626,  628,  630,  632,  634,  634, yy_Dummy>>)
		end

	yy_acclist_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,   86,   86,   89,   89,   97,   97,  100,  100,  133,
			  131,  132,    1,  131,  132,    1,  132,    2,  131,  132,
			  102,  131,  132,   70,  131,  132,   77,  131,  132,    2,
			  131,  132,    2,  131,  132,    2,  131,  132,  120,  131,
			  132,  120,  131,  132,  120,  131,  132,    2,  131,  132,
			    2,  131,  132,    2,  131,  132,    2,  131,  132,   69,
			  131,  132,   69,  131,  132,   69,  131,  132,   69,  131,
			  132,   69,  131,  132,   69,  131,  132,   69,  131,  132,
			   69,  131,  132,   69,  131,  132,   69,  131,  132,   69,
			  131,  132,   69,  131,  132,   69,  131,  132,   69,  131,

			  132,   69,  131,  132,   69,  131,  132,   69,  131,  132,
			   69,  131,  132,  131,  132,  131,  132,  109,  132,  113,
			  132,  110,  132,  112,  132,  118,  132,  118,  132,  117,
			  132,  116,  118,  132,  115,  132,  115,  132,  114,  132,
			   81,  132,   81,  132,   80,  132,   86,  132,   86,  132,
			   85,  132,   86,  132,   83,  132,   86,  132,   89,  132,
			   88,  132,   89,  132,   92,  132,   92,  132,   91,  132,
			   97,  132,   97,  132,   96,  132,   97,  132,   94,  132,
			   97,  132,  100,  132,   99,  132,  100,  132,    1,  102,
			   78,  101,  102, -222,  102, -211,   70,   77,   77,   76,

			   77,    1,    3,  127,  130,  120,  120,  119,   69,   69,
			   69,   69,    8,   69,   69,   69,   69,   69,   69,   69,
			   69,   17,   69,   69,   69,   69,   69,   69,   69,   29,
			   69,   69,   69,   36,   69,   69,   69,   69,   69,   69,
			   69,   44,   69,   69,   69,   69,   69,   69,   69,   69,
			   69,   69,   69,   69,  109,  110,  111,  111,  103,  111,
			  109,  111,  107,  111,  108,  111,  117,  116,  114,   80,
			   86,   85,   86,   83,   86,   86,   86,   84,   85,   86,
			   82,   83,   89,   88,   89,   87,   88,   91,   97,   96,
			   97,   94,   97,   97,   97,   95,   96,   97,   93,   94,

			  100,   99,  100,   98,   99,  102,  102,  -90,  102,  -79,
			   71,   77,   75,   77,    1,  125,  127,  130,  125,  124,
			  121,   69,   69,    6,   69,    7,   69,   69,   69,   69,
			   69,   69,   69,   69,   69,   69,   69,   20,   69,   69,
			   69,   69,   69,   69,   69,   69,   69,   69,   69,   69,
			   69,   69,   69,   69,   40,   69,   69,   42,   69,   69,
			   69,   69,   69,   69,   69,   69,   69,   69,   69,   69,
			   69,   69,   69,   69,   69,   69,   69,   69,   64,   69,
			  104,  103,  104,  106,  101,   72,   74,  127,  130,  130,
			  126,  129,  123,   69,   69,   69,   69,   69,   69,   69,

			   69,   69,   69,   69,   18,   69,   69,   69,   69,   69,
			   69,   69,   27,   69,   69,   69,   69,   69,   69,   69,
			   69,   37,   69,   69,   39,   69,   67,   69,   69,   43,
			   69,   69,   69,   69,   69,   69,   69,   69,   69,   69,
			   69,   69,   69,   56,   69,   57,   69,   69,   69,   69,
			   69,   62,   69,   63,   69,  122,  105,  109,   77,  126,
			  127,  129,  130,  130,  128,  130,  128,    4,   69,    5,
			   69,   69,   69,   10,   69,   65,   69,   69,   69,   69,
			   15,   69,   69,   69,   69,   69,   69,   69,   25,   69,
			   69,   69,   69,   69,   32,   69,   69,   69,   69,   38,

			   69,   69,   69,   69,   69,   69,   69,   69,   69,   69,
			   52,   69,   69,   69,   55,   69,   69,   69,   60,   69,
			   69,   73,  130,  130,  129,  129,    9,   69,   69,   69,
			   12,   69,   69,   69,   69,   19,   69,   21,   69,   69,
			   23,   69,   69,   69,   28,   69,   69,   69,   69,   69,
			   69,   69,   69,   46,   69,   69,   69,   48,   69,   69,
			   50,   69,   51,   69,   53,   69,   69,   69,   59,   69,
			   69,  129,  130,  129,  130,   69,   11,   69,   69,   14,
			   69,   69,   69,   69,   26,   69,   30,   69,   69,   33,
			   69,   34,   69,   69,   69,   69,   69,   69,   49,   69,

			   69,   69,   61,   69,   69,   13,   69,   16,   69,   22,
			   69,   24,   69,   31,   69,   69,   41,   69,   69,   47,
			   69,   69,   54,   69,   58,   69,   66,   69,   35,   69,
			   45,   69,   68,   69, yy_Dummy>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER is 1706
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER is 484
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER is 485
			-- Mark between normal states and templates

	yyNull_equiv_class: INTEGER is 1
			-- Equivalence code for NULL character

	yyReject_used: BOOLEAN is false
			-- Is `reject' called?

	yyVariable_trail_context: BOOLEAN is true
			-- Is there a regular expression with
			-- both leading and trailing parts having
			-- variable length?

	yyReject_or_variable_trail_context: BOOLEAN is true
			-- Is `reject' called or is there a
			-- regular expression with both leading
			-- and trailing parts having variable length?

	yyNb_rules: INTEGER is 132
			-- Number of rules

	yyEnd_of_buffer: INTEGER is 133
			-- End of buffer rule code

	yyLine_used: BOOLEAN is true
			-- Are line and column numbers used?

	yyPosition_used: BOOLEAN is false
			-- Is `position' used?

	INITIAL: INTEGER is 0
	MS: INTEGER is 1
	MSN: INTEGER is 2
	MSN1: INTEGER is 3
	VS1: INTEGER is 4
	VS2: INTEGER is 5
	VS3: INTEGER is 6
	LAVS1: INTEGER is 7
	LAVS2: INTEGER is 8
	LAVS3: INTEGER is 9
			-- Start condition codes

feature -- User-defined features



end
