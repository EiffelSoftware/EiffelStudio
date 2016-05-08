note

	description:

		"Eiffel preparsers"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 2002-2014, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class ET_EIFFEL_PREPARSER

inherit

	ET_EIFFEL_PREPARSER_SKELETON

create

	make

feature -- Status report

	valid_start_condition (sc: INTEGER): BOOLEAN
			-- Is `sc' a valid start condition?
		do
			Result := (INITIAL <= sc and sc <= LAVS3)
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
	yy_column := yy_column + 3
--|#line 34 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 34")
end

				-- Ignore byte order mark (BOM).
				-- See http://en.wikipedia.org/wiki/Byte_order_mark
			
when 2 then
yy_set_line_column
--|#line 42 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 42")
end

			
when 3 then
	yy_column := yy_column + 1
--|#line 43 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 43")
end

			
when 4 then
	yy_column := yy_column + 2
--|#line 44 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 44")
end

			
when 5 then
	yy_column := yy_column + 5
--|#line 49 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 49")
end

			
when 6 then
	yy_column := yy_column + 5
--|#line 50 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 50")
end

			
when 7 then
	yy_column := yy_column + 3
--|#line 51 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 51")
end

			
when 8 then
	yy_column := yy_column + 3
--|#line 52 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 52")
end

			
when 9 then
	yy_column := yy_column + 2
--|#line 53 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 53")
end

			
when 10 then
	yy_column := yy_column + 6
--|#line 54 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 54")
end

			
when 11 then
	yy_column := yy_column + 5
--|#line 55 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 55")
end

			
when 12 then
	yy_column := yy_column + 7
--|#line 56 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 56")
end

			
when 13 then
	yy_column := yy_column + 6
--|#line 57 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 57")
end

			
when 14 then
	yy_column := yy_column + 8
--|#line 58 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 58")
end

			
when 15 then
	yy_column := yy_column + 7
--|#line 59 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 59")
end

			
when 16 then
	yy_column := yy_column + 5
--|#line 60 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 60")
end

			
when 17 then
	yy_column := yy_column + 8
--|#line 61 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 61")
end

			
when 18 then
	yy_column := yy_column + 2
--|#line 62 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 62")
end

			
when 19 then
	yy_column := yy_column + 4
--|#line 63 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 63")
end

			
when 20 then
	yy_column := yy_column + 6
--|#line 64 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 64")
end

			
when 21 then
	yy_column := yy_column + 3
--|#line 65 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 65")
end

			
when 22 then
	yy_column := yy_column + 6
--|#line 66 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 66")
end

			
when 23 then
	yy_column := yy_column + 8
--|#line 67 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 67")
end

			
when 24 then
	yy_column := yy_column + 6
--|#line 68 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 68")
end

			
when 25 then
	yy_column := yy_column + 8
--|#line 69 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 69")
end

			
when 26 then
	yy_column := yy_column + 5
--|#line 70 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 70")
end

			
when 27 then
	yy_column := yy_column + 7
--|#line 71 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 71")
end

			
when 28 then
	yy_column := yy_column + 4
--|#line 72 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 72")
end

			
when 29 then
	yy_column := yy_column + 6
--|#line 73 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 73")
end

			
when 30 then
	yy_column := yy_column + 2
--|#line 74 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 74")
end

			
when 31 then
	yy_column := yy_column + 7
--|#line 75 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 75")
end

			
when 32 then
	yy_column := yy_column + 8
--|#line 76 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 76")
end

			
when 33 then
	yy_column := yy_column + 5
--|#line 77 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 77")
end

			
when 34 then
	yy_column := yy_column + 7
--|#line 78 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 78")
end

			
when 35 then
	yy_column := yy_column + 7
--|#line 79 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 79")
end

			
when 36 then
	yy_column := yy_column + 9
--|#line 80 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 80")
end

			
when 37 then
	yy_column := yy_column + 2
--|#line 81 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 81")
end

			
when 38 then
	yy_column := yy_column + 4
--|#line 82 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 82")
end

			
when 39 then
	yy_column := yy_column + 5
--|#line 83 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 83")
end

			
when 40 then
	yy_column := yy_column + 4
--|#line 84 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 84")
end

			
when 41 then
	yy_column := yy_column + 3
--|#line 85 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 85")
end

			
when 42 then
	yy_column := yy_column + 8
--|#line 86 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 86")
end

			
when 43 then
	yy_column := yy_column + 3
--|#line 87 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 87")
end

			
when 44 then
	yy_column := yy_column + 4
--|#line 88 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 88")
end

			
when 45 then
	yy_column := yy_column + 2
--|#line 89 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 89")
end

			
when 46 then
	yy_column := yy_column + 9
--|#line 90 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 90")
end

			
when 47 then
	yy_column := yy_column + 6
--|#line 91 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 91")
end

			
when 48 then
	yy_column := yy_column + 8
--|#line 92 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 92")
end

			
when 49 then
	yy_column := yy_column + 6
--|#line 93 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 93")
end

			
when 50 then
	yy_column := yy_column + 7
--|#line 94 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 94")
end

			
when 51 then
	yy_column := yy_column + 6
--|#line 95 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 95")
end

			
when 52 then
	yy_column := yy_column + 6
--|#line 96 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 96")
end

			
when 53 then
	yy_column := yy_column + 5
--|#line 97 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 97")
end

			
when 54 then
	yy_column := yy_column + 6
--|#line 98 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 98")
end

			
when 55 then
	yy_column := yy_column + 8
--|#line 99 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 99")
end

			
when 56 then
	yy_column := yy_column + 5
--|#line 100 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 100")
end

			
when 57 then
	yy_column := yy_column + 4
--|#line 101 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 101")
end

			
when 58 then
	yy_column := yy_column + 4
--|#line 102 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 102")
end

			
when 59 then
	yy_column := yy_column + 8
--|#line 103 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 103")
end

			
when 60 then
	yy_column := yy_column + 6
--|#line 104 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 104")
end

			
when 61 then
	yy_column := yy_column + 5
--|#line 105 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 105")
end

			
when 62 then
	yy_column := yy_column + 7
--|#line 106 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 106")
end

			
when 63 then
	yy_column := yy_column + 4
--|#line 107 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 107")
end

			
when 64 then
	yy_column := yy_column + 4
--|#line 108 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 108")
end

			
when 65 then
	yy_column := yy_column + 3
--|#line 109 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 109")
end

			
when 66 then
	yy_column := yy_column + 5
--|#line 111 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 111")
end

				class_keyword_found := True
			
when 67 then
	yy_column := yy_column + 8
--|#line 114 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 114")
end

				if use_attached_keyword then
					-- Do nothing.
				elseif class_keyword_found then
					last_token := E_IDENTIFIER
					last_literal_start := 1
					last_literal_end := 9
					last_break_end := 0
					last_comment_end := 0
					last_classname := ast_factory.new_identifier (Current)
				end
			
when 68 then
	yy_column := yy_column + 9
--|#line 126 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 126")
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
			
when 69 then
	yy_column := yy_column + 10
--|#line 138 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 138")
end

				if use_detachable_keyword then
					-- Do nothing.
				elseif class_keyword_found then
					last_token := E_IDENTIFIER
					last_literal_start := 1
					last_literal_end := 9
					last_break_end := 0
					last_comment_end := 0
					last_classname := ast_factory.new_identifier (Current)
				end
			
when 70 then
	yy_column := yy_column + 4
--|#line 150 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 150")
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
			
when 71 then
	yy_column := yy_column + 9
--|#line 162 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 162")
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
			
when 72 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 178 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 178")
end

				if class_keyword_found then
					last_token := E_IDENTIFIER
					last_literal_start := 1
					last_literal_end := text_count
					last_break_end := 0
					last_comment_end := 0
					last_classname := ast_factory.new_identifier (Current)
				end
			
when 73 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 192 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 192")
end

			
when 74 then
	yy_column := yy_column + 3
--|#line 201 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 201")
end

			
when 75 then
	yy_column := yy_column + 4
--|#line 202 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 202")
end

			
when 76 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 203 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 203")
end

			
when 77 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 206 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 206")
end

					-- Syntax error: missing character / at end
					-- of special character specification %/code/.
				column := column + text_count
				set_syntax_error
				error_handler.report_SCAS_error (filename, current_position)
				column := column - text_count
				last_token := E_CHARERR
			
when 78 then
	yy_column := yy_column + 3
--|#line 215 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 215")
end

					-- Syntax error: missing ASCII code in
					-- special character specification %/code/.
				column := column + 3
				set_syntax_error
				error_handler.report_SCAC_error (filename, current_position)
				column := column - 3
				last_token := E_CHARERR
			
when 79 then
	yy_column := yy_column + 2
--|#line 224 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 224")
end

					-- Syntax error: missing character between quotes.
				column := column + 1
				set_syntax_error
				error_handler.report_SCQQ_error (filename, current_position)
				column := column - 1
				last_token := E_CHARERR
			
when 80 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 232 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 232")
end

					-- Syntax error: missing quote at
					-- end of character constant.
				column := column + text_count
				set_syntax_error
				error_handler.report_SCEQ_error (filename, current_position)
				column := column - text_count
				last_token := E_CHARERR
			
when 81 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 245 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 245")
end

			
when 82 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 248 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 248")
end

					-- Verbatim string.
				verbatim_marker := text_substring (2, text_count - 1)
				set_start_condition (VS1)
			
when 83 then
	yy_line := yy_line + 1
	yy_column := 1
--|#line 256 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 256")
end

				last_literal_start := 1
				last_literal_end := 0
				set_start_condition (VS2)
			
when 84 then
	yy_column := yy_column + 1
--|#line 261 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 261")
end

					-- No final brace-double-quote.
				last_token := E_STRERR
				report_syntax_error (current_position)
				set_start_condition (INITIAL)
			
when 85 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 277 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 277")
end

				if is_verbatim_string_closer (last_literal_end + 1, text_count - 1) then
					verbatim_marker := no_verbatim_marker
					set_start_condition (INITIAL)
				else
					more
					set_start_condition (VS3)
				end
			
when 86 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 286 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 286")
end

				more
				set_start_condition (VS3)
			
when 87 then
	yy_line := yy_line + 1
	yy_column := 1
--|#line 290 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 290")
end

				more
				last_literal_end := text_count - 2
			
when 88 then
	yy_line := yy_line + 1
	yy_column := 1
--|#line 294 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 294")
end

				more
				last_literal_end := text_count - 1
			
when 89 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 298 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 298")
end

					-- No final brace-double-quote.
				last_token := E_STRERR
				report_syntax_error (current_position)
				set_start_condition (INITIAL)
			
when 90 then
	yy_line := yy_line + 1
	yy_column := 1
--|#line 314 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 314")
end

				more
				last_literal_end := text_count - 2
				set_start_condition (VS2)
			
when 91 then
	yy_line := yy_line + 1
	yy_column := 1
--|#line 319 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 319")
end

				more
				last_literal_end := text_count - 1
				set_start_condition (VS2)
			
when 92 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 324 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 324")
end

					-- No final brace-double-quote.
				last_token := E_STRERR
				report_syntax_error (current_position)
				set_start_condition (INITIAL)
			
when 93 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 338 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 338")
end

					-- Left aligned verbatim string.
				verbatim_marker := text_substring (2, text_count - 1)
				set_start_condition (LAVS1)
			
when 94 then
	yy_line := yy_line + 1
	yy_column := 1
--|#line 346 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 346")
end

				last_literal_start := 1
				last_literal_end := 0
				set_start_condition (LAVS2)
			
when 95 then
	yy_column := yy_column + 1
--|#line 351 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 351")
end

					-- No final bracket-double-quote.
				last_token := E_STRERR
				report_syntax_error (current_position)
				set_start_condition (INITIAL)
			
when 96 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 367 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 367")
end

				if is_verbatim_string_closer (last_literal_end + 1, text_count - 1) then
					verbatim_marker := no_verbatim_marker
					set_start_condition (INITIAL)
				else
					more
					set_start_condition (LAVS3)
				end
			
when 97 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 376 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 376")
end

				more
				set_start_condition (LAVS3)
			
when 98 then
	yy_line := yy_line + 1
	yy_column := 1
--|#line 380 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 380")
end

				more
				last_literal_end := text_count - 2
			
when 99 then
	yy_line := yy_line + 1
	yy_column := 1
--|#line 384 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 384")
end

				more
				last_literal_end := text_count - 1
			
when 100 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 388 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 388")
end

					-- No final bracket-double-quote.
				last_token := E_STRERR
				report_syntax_error (current_position)
				set_start_condition (INITIAL)
			
when 101 then
	yy_line := yy_line + 1
	yy_column := 1
--|#line 404 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 404")
end

				more
				last_literal_end := text_count - 2
				set_start_condition (LAVS2)
			
when 102 then
	yy_line := yy_line + 1
	yy_column := 1
--|#line 409 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 409")
end

				more
				last_literal_end := text_count - 1
				set_start_condition (LAVS2)
			
when 103 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 414 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 414")
end

					-- No final bracket-double-quote.
				last_token := E_STRERR
				report_syntax_error (current_position)
				set_start_condition (INITIAL)
			
when 104 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 428 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 428")
end

					-- Manifest string with special characters.
			
when 105 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 431 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 431")
end

					-- Manifest string with special characters which may be made
					-- up of several lines or may include invalid characters.
					-- Keep track of current line and column.
				ms_line := line
				ms_column := column
				more
				set_start_condition (MS)
			
when 106 then
	yy_line := yy_line + 1
	yy_column := 1
--|#line 442 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 442")
end

					-- Multi-line manifest string.
				more
				set_start_condition (MSN)
			
when 107 then
	yy_end := yy_start + yy_more_len + 2
	yy_column := yy_column + 2
--|#line 447 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 447")
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
			
when 108 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 462 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 462")
end

				more
			
when 109 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 465 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 465")
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
			
when 110 then
	yy_column := yy_column + 2
--|#line 477 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 477")
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
			
when 111 then
	yy_column := yy_column + 2
--|#line 489 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 489")
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
			
when 112 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 502 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 502")
end

				more
			
when 113 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 505 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 505")
end

				set_start_condition (INITIAL)
			
when 114 then
	yy_column := yy_column + 2
--|#line 508 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 508")
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
			
when 115 then
	yy_column := yy_column + 1
--|#line 520 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 520")
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
			
when 116 then
	yy_line := yy_line + 1
	yy_column := 1
--|#line 533 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 533")
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
			
when 117 then
	yy_line := yy_line + 1
	yy_column := 1
--|#line 561 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 561")
end

				more
				set_start_condition (MSN)
			
when 118 then
	yy_column := yy_column + 1
--|#line 565 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 565")
end

					-- Should never happen.
				last_token := E_STRERR
				report_syntax_error (current_position)
				set_start_condition (INITIAL)
			
when 119 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 580 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 580")
end

				more
				set_start_condition (MS)
			
when 120 then
	yy_line := yy_line + 1
	yy_column := 1
--|#line 584 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 584")
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
			
when 121 then
	yy_column := yy_column + 1
--|#line 596 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 596")
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
			
when 122 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 627 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 627")
end

			
when 123 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 633 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 633")
end

			
when 124 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 635 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 635")
end

			
when 125 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 637 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 637")
end

					-- Syntax error: an underscore may not be
					-- the first character of an integer.
				set_syntax_error
				error_handler.report_SIFU_error (filename, current_position)
				last_token := E_INTEGER
			
when 126 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 644 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 644")
end

					-- Syntax error: an underscore may not be
					-- the last character of an integer.
				set_syntax_error
				error_handler.report_SILU_error (filename, current_position)
				last_token := E_INTEGER
			
when 127 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 651 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 651")
end

			
when 128 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 653 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 653")
end

					-- Syntax error: an underscore may not be
					-- the first character of an integer.
				set_syntax_error
				error_handler.report_SIFU_error (filename, current_position)
				last_token := E_INTEGER
			
when 129 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 660 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 660")
end

					-- Syntax error: an underscore may not be
					-- the last character of an integer.
				set_syntax_error
				error_handler.report_SILU_error (filename, current_position)
				last_token := E_INTEGER
			
when 130 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 667 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 667")
end

			
when 131 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 669 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 669")
end

					-- Syntax error: an underscore may not be
					-- the first character of an integer.
				set_syntax_error
				error_handler.report_SIFU_error (filename, current_position)
				last_token := E_INTEGER
			
when 132 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 676 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 676")
end

					-- Syntax error: an underscore may not be
					-- the last character of an integer.
				set_syntax_error
				error_handler.report_SILU_error (filename, current_position)
				last_token := E_INTEGER
			
when 133 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 683 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 683")
end

			
when 134 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 685 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 685")
end

					-- Syntax error: an underscore may not be
					-- the first character of an integer.
				set_syntax_error
				error_handler.report_SIFU_error (filename, current_position)
				last_token := E_INTEGER
			
when 135 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 692 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 692")
end

					-- Syntax error: an underscore may not be
					-- the last character of an integer.
				set_syntax_error
				error_handler.report_SILU_error (filename, current_position)
				last_token := E_INTEGER
			
when 136 then
	yy_end := yy_end - 1
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 703 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 703")
end

			
when 137 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 704 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 704")
end

			
when 138 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 705 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 705")
end

			
when 139 then
	yy_end := yy_end - 1
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 707 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 707")
end

			
when 140 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 708 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 708")
end

			
when 141 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 709 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 709")
end

			
when 142 then
	yy_column := yy_column + 1
--|#line 719 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 719")
end

				last_token := E_UNKNOWN
			
when 143 then
yy_set_line_column
--|#line 0 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 0")
end
last_token := yyError_token
fatal_error ("scanner jammed")
			else
				last_token := yyError_token
				fatal_error ("fatal scanner internal error: no action found")
			end
		end

	yy_execute_eof_action (yy_sc: INTEGER)
			-- Execute EOF semantic action.
		do
			inspect yy_sc
when 0 then
--|#line 718 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 718")
end
terminate
when 1 then
--|#line 545 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 545")
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
--|#line 609 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 609")
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
--|#line 571 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 571")
end

					-- Should never happen.
				last_token := E_STRERR
				report_syntax_error (current_position)
				set_start_condition (INITIAL)
			
when 4 then
--|#line 267 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 267")
end

					-- No final brace-double-quote.
				last_token := E_STRERR
				report_syntax_error (current_position)
				set_start_condition (INITIAL)
			
when 5 then
--|#line 304 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 304")
end

					-- No final brace-double-quote.
				last_token := E_STRERR
				report_syntax_error (current_position)
				set_start_condition (INITIAL)
			
when 6 then
--|#line 330 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 330")
end

					-- No final brace-double-quote.
				last_token := E_STRERR
				report_syntax_error (current_position)
				set_start_condition (INITIAL)
			
when 7 then
--|#line 357 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 357")
end

					-- No final bracket-double-quote.
				last_token := E_STRERR
				report_syntax_error (current_position)
				set_start_condition (INITIAL)
			
when 8 then
--|#line 394 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 394")
end

					-- No final bracket-double-quote.
				last_token := E_STRERR
				report_syntax_error (current_position)
				set_start_condition (INITIAL)
			
when 9 then
--|#line 420 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 420")
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

	yy_nxt_template: SPECIAL [INTEGER]
			-- Template for `yy_nxt'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 1888)
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
			Result := yy_fixed_array (an_array)
		end

	yy_nxt_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			    0,   22,   23,   24,   23,   25,   26,   27,   22,   28,
			   25,   25,   29,   30,   31,   32,   33,   34,   34,   35,
			   36,   25,   37,   38,   39,   40,   41,   42,   43,   44,
			   40,   40,   45,   40,   40,   46,   40,   47,   48,   49,
			   40,   50,   51,   52,   53,   54,   55,   56,   40,   40,
			   25,   57,   25,   58,   39,   40,   41,   42,   44,   40,
			   46,   47,   40,   50,   51,   52,   53,   54,   25,   25,
			   25,   22,   22,   59,   61,   61,  233,   62,   62,   63,
			   63,   65,   66,   65,   65,   66,   65,   67,   81,   82,
			   67,   69,   70,   69,   69,   70,   69,   72,   73,   72,

			   72,   73,   72,   75,   76,   77,  233,   78,   75,   76,
			   77,  328,   78,   81,   82,   84,   85,   84,   84,   85,
			   84,   87,   88,   89,  329,   90,   87,   88,   89,  512,
			   90,   93,   94,   93,   94,   95,   95,   95,   95,   95,
			   95,   98,  106,   99,  237,   96,  104,  105,   96,  153,
			  107,  107,  107,  108,  108,  108,  108,  107,  107,  107,
			  109,  147,  110,  110,  111,  111,  107,  107,  128,  408,
			   79,   91,  116,  153,  237,   79,   91,  109,  129,  111,
			  111,  111,  111,  147,  140,  100,  189,  190,  156,  130,
			  141,  131,  118,  149,  162,  511,  163,  119,  408,  120, yy_Dummy>>,
			1, 200, 0)
		end

	yy_nxt_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  115,  132,  116,  101,  121,  122,  107,  109,  150,  110,
			  110,  111,  111,  507,  130,  131,  156,  115,  250,  112,
			  113,  133,  119,  120,  123,  134,  121,  122,  124,  506,
			  150,  125,  136,   95,  126,  191,  190,  127,  135,  137,
			  138,  114,  217,  154,  151,  139,   95,  115,  250,  112,
			  113,  133,  123,  124,  152,  217,  126,  155,  143,  127,
			  135,  136,  179,  180,  138,  181,  505,  139,  144,  263,
			  145,  238,  151,  154,  146,  503,  152,  158,  158,  158,
			  158,  171,  172,  171,  174,  175,  174,  173,  143,  176,
			  177,  176,  234,  144,  145,  238,  146,  179,  186,  263,

			  187,  502,  178,  192,  193,  192,  195,  196,  501,  197,
			  205,  206,  207,  206,  234,  159,  164,  165,  166,  167,
			  164,  168,  164,  168,  168,  168,  164,  164,  164,  169,
			  164,  164,  164,  164,  164,  168,  164,  168,  164,  168,
			  168,  168,  168,  164,  168,  164,  168,  164,  164,  164,
			  168,  164,  168,  164,  164,  168,  168,  168,  168,  168,
			  168,  164,  164,  164,  164,  164,  164,  164,  164,  170,
			  170,  170,  170,  170,  170,  170,  170,  170,  170,  170,
			  170,  170,  170,  164,  164,  164,  164,  164,  164,  182,
			  179,  183,  499,  181,  182,  185,  183,  308,  181,  198, yy_Dummy>>,
			1, 200, 200)
		end

	yy_nxt_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  195,  199,  418,  197,  198,  201,  199,  235,  197,  195,
			  202,   98,  203,   99,  194,   95,   95,   95,  210,  211,
			  210,  308,   98,  240,   99,   96,  212,  213,  212,  235,
			   98,  418,   99,  108,  108,  108,  108,  221,  221,  221,
			  221,  189,  190,  223,  223,  240,  218,  191,  190,  200,
			  222,  225,  225,  225,  200,  100,  184,  162,  488,  163,
			  109,  184,  110,  110,  111,  111,  100,  229,  229,  229,
			  229,  219,  116,  101,  100,  109,  244,  111,  111,  111,
			  111,  224,  231,  241,  101,  232,  247,  242,  245,  226,
			  248,  162,  101,  163,  249,  261,  259,  264,  244,  262,

			  115,  243,  116,  246,  478,  115,  274,  272,  260,  276,
			  232,  273,  248,  241,  280,  115,  242,  261,  245,  249,
			  253,  262,  254,  243,  255,  246,  259,  264,  274,  277,
			  476,  276,  272,  283,  278,  256,  280,  290,  257,   99,
			  158,  158,  158,  158,  474,  279,  158,  158,  158,  158,
			  253,  254,  255,  179,  180,  283,  181,  256,  330,  277,
			  257,  266,  472,  267,  286,  287,  286,  279,  286,  288,
			  286,  268,  185,  180,  269,  181,  270,  271,  159,  289,
			  289,  289,  289,  330,  159,  205,  206,  171,  172,  171,
			  309,  266,  267,  173,  313,  268,  269,  469,  270,  271, yy_Dummy>>,
			1, 200, 400)
		end

	yy_nxt_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  174,  175,  174,  176,  177,  176,  182,  179,  183,  354,
			  181,  182,  185,  183,  464,  181,  179,  186,  361,  187,
			  309,  178,  185,  186,  313,  187,  404,  178,  192,  193,
			  192,  195,  196,  354,  197,  201,  196,  314,  197,  198,
			  195,  199,  361,  197,  198,  201,  199,  392,  197,  195,
			  202,  404,  203,  316,  194,  201,  202,  432,  203,  314,
			  194,  207,  206,  291,  291,  291,  291,  463,  210,  211,
			  210,  392,   98,  184,   99,  212,  213,  212,  184,   98,
			  459,   99,  320,  316,  292,  432,  223,  223,  457,  200,
			  293,  293,  293,  293,  200,  294,  294,  302,  302,  295,

			  295,  295,  295,  456,  296,  296,  296,  296,  221,  221,
			  221,  221,  320,  299,  299,  315,  100,  300,  300,  300,
			  300,  297,  311,  100,  301,  225,  225,  225,  304,  304,
			  304,  317,  318,  322,  101,  224,  326,  315,  327,  312,
			  335,  101,  219,  323,  337,  307,  298,  229,  229,  229,
			  229,  346,  311,  317,  318,  322,  342,  324,  326,  343,
			  327,  312,  347,  303,  348,  350,  226,  352,  357,  360,
			  335,  405,  455,  323,  337,  362,  362,  362,  362,  435,
			  454,  346,  349,  436,  347,  115,  342,  350,  343,  452,
			  357,  286,  287,  286,  348,  451,  405,  352,  449,  360, yy_Dummy>>,
			1, 200, 600)
		end

	yy_nxt_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  295,  295,  295,  295,  349,  363,  289,  289,  289,  289,
			  208,  291,  291,  291,  291,  364,  293,  293,  293,  293,
			  295,  295,  295,  295,  296,  296,  296,  296,  367,  367,
			  371,  371,  368,  368,  368,  368,  448,  366,  369,  369,
			  369,  369,  300,  300,  300,  300,  300,  300,  300,  300,
			  302,  302,  372,  372,  372,  304,  304,  304,  365,  377,
			  378,  380,  219,  383,  375,  375,  375,  375,  301,  389,
			  385,  447,  388,  391,  393,  394,  298,  376,  396,  401,
			  403,  377,  378,  406,  370,  383,  409,  412,  224,  413,
			  303,  380,  385,  226,  388,  391,  393,  394,  415,  389,

			  396,  401,  403,  416,  419,  406,  420,  421,  409,  412,
			  162,  441,  163,  305,  413,  161,  362,  362,  362,  362,
			  423,  423,  423,  423,  422,  416,  419,  433,  415,  424,
			  424,  420,  431,  425,  425,  425,  425,  421,  368,  368,
			  368,  368,  368,  368,  368,  368,  369,  369,  369,  369,
			  428,  428,  428,  428,  371,  371,  431,  433,  365,  427,
			  372,  372,  372,  375,  375,  375,  375,  429,  429,  434,
			  437,  430,  430,  430,  430,  438,  427,  439,  440,  442,
			  426,  443,  444,  450,  298,  498,  445,  446,  370,  462,
			  453,  434,  301,  458,  437,  460,  461,  438,  303,  465, yy_Dummy>>,
			1, 200, 800)
		end

	yy_nxt_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  470,  298,  417,  443,  414,  439,  444,  440,  445,  442,
			  498,  446,  453,  450,  411,  458,  410,  460,  461,  462,
			  471,  473,  470,  465,  423,  423,  423,  423,  425,  425,
			  425,  425,  425,  425,  425,  425,  466,  466,  466,  466,
			  467,  467,  471,  473,  468,  468,  468,  468,  428,  428,
			  428,  428,  430,  430,  430,  430,  430,  430,  430,  430,
			  475,  477,  365,  479,  480,  481,  483,  482,  486,  407,
			  365,  484,  402,  485,  426,  487,  489,  490,  491,  466,
			  466,  466,  466,  492,  495,  479,  370,  481,  480,  482,
			  475,  477,  486,  484,  370,  485,  483,  493,  489,  487,

			  491,  490,  468,  468,  468,  468,  468,  468,  468,  468,
			  494,  496,  497,  492,  495,  500,  504,  426,  508,  493,
			  400,  399,  398,  509,  397,  510,  227,  227,  395,  390,
			  227,  227,  227,  387,  494,  386,  384,  382,  381,  500,
			  379,  496,  497,  508,  426,  509,  504,  510,   60,   60,
			   60,   60,   60,   60,   60,   60,   60,   60,   60,   60,
			   60,   60,   60,   60,   60,   60,   60,   60,   60,   60,
			   60,   60,   64,   64,   64,   64,   64,   64,   64,   64,
			   64,   64,   64,   64,   64,   64,   64,   64,   64,   64,
			   64,   64,   64,   64,   64,   64,   68,   68,   68,   68, yy_Dummy>>,
			1, 200, 1000)
		end

	yy_nxt_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			   68,   68,   68,   68,   68,   68,   68,   68,   68,   68,
			   68,   68,   68,   68,   68,   68,   68,   68,   68,   68,
			   71,   71,   71,   71,   71,   71,   71,   71,   71,   71,
			   71,   71,   71,   71,   71,   71,   71,   71,   71,   71,
			   71,   71,   71,   71,   74,   74,   74,   74,   74,   74,
			   74,   74,   74,   74,   74,   74,   74,   74,   74,   74,
			   74,   74,   74,   74,   74,   74,   74,   74,   80,   80,
			   80,   80,   80,   80,   80,   80,   80,   80,   80,   80,
			   80,   80,   80,   80,   80,   80,   80,   80,   80,   80,
			   80,   80,   83,   83,   83,   83,   83,   83,   83,   83,

			   83,   83,   83,   83,   83,   83,   83,   83,   83,   83,
			   83,   83,   83,   83,   83,   83,   86,   86,   86,   86,
			   86,   86,   86,   86,   86,   86,   86,   86,   86,   86,
			   86,   86,   86,   86,   86,   86,   86,   86,   86,   86,
			   92,   92,   92,   92,   92,   92,   92,   92,   92,   92,
			   92,   92,   92,   92,   92,   92,   92,   92,   92,   92,
			   92,   92,   92,   92,   97,   97,  228,   97,   97,   97,
			   97,   97,   97,   97,   97,   97,   97,   97,   97,   97,
			   97,   97,   97,   97,   97,   97,   97,   97,  102,  305,
			  359,  358,  356,  355,  102,  102,  102,  102,  102,  102, yy_Dummy>>,
			1, 200, 1200)
		end

	yy_nxt_template_8 (an_array: ARRAY [INTEGER])
			-- Fill chunk #8 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  102,  102,  102,  102,  102,  102,  102,  102,  102,  102,
			  102,  102,  103,  103,  353,  103,  103,  103,  103,  103,
			  103,  103,  103,  103,  103,  103,  103,  103,  103,  103,
			  103,  103,  103,  103,  103,  103,  117,  117,  351,  345,
			  117,  117,  117,  117,  117,  117,  117,  117,  117,  117,
			  117,  161,  161,  344,  161,  161,  161,  161,  161,  161,
			  161,  161,  161,  161,  161,  161,  161,  161,  161,  161,
			  161,  161,  161,  161,  161,  178,  178,  178,  178,  178,
			  178,  178,  178,  178,  178,  178,  178,  178,  178,  178,
			  178,  178,  178,  178,  178,  178,  178,  178,  178,  184,

			  184,  184,  184,  184,  184,  184,  184,  184,  184,  184,
			  184,  184,  184,  184,  184,  184,  184,  184,  184,  184,
			  184,  184,  184,  188,  188,  188,  188,  188,  188,  188,
			  188,  188,  188,  188,  188,  188,  188,  188,  188,  188,
			  188,  188,  188,  188,  188,  188,  188,  194,  194,  194,
			  194,  194,  194,  194,  194,  194,  194,  194,  194,  194,
			  194,  194,  194,  194,  194,  194,  194,  194,  194,  194,
			  194,  200,  200,  200,  200,  200,  200,  200,  200,  200,
			  200,  200,  200,  200,  200,  200,  200,  200,  200,  200,
			  200,  200,  200,  200,  200,  204,  204,  204,  204,  204, yy_Dummy>>,
			1, 200, 1400)
		end

	yy_nxt_template_9 (an_array: ARRAY [INTEGER])
			-- Fill chunk #9 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  204,  204,  204,  204,  204,  204,  204,  204,  204,  204,
			  204,  204,  204,  204,  204,  204,  204,  204,  204,  208,
			  208,  208,  208,  341,  340,  339,  208,  208,  208,  208,
			  208,  338,  208,  208,  208,  208,  208,  215,  215,  336,
			  215,  215,  215,  215,  215,  215,  215,  215,  215,  215,
			  215,  215,  215,  215,  215,  215,  215,  215,  215,  215,
			  215,  106,  106,  106,  106,  106,  106,  106,  106,  106,
			  106,  106,  106,  106,  106,  106,  106,  106,  106,  106,
			  106,  106,  106,  106,  106,  220,  220,  220,  220,  220,
			  220,  220,  220,  334,  220,  220,  220,  220,  220,  220,

			  220,  220,  220,  220,  220,  220,  220,  220,  220,  161,
			  161,  161,  161,  333,  332,  331,  161,  161,  161,  161,
			  161,  325,  161,  161,  161,  161,  161,  208,  208,  321,
			  208,  208,  208,  208,  208,  208,  208,  208,  208,  208,
			  208,  208,  208,  208,  208,  208,  208,  208,  208,  208,
			  208,  306,  306,  319,  310,  306,  306,  306,  373,  373,
			  228,  305,  373,  373,  373,  374,  374,  374,  374,  374,
			  374,  374,  374,  292,  374,  374,  374,  374,  374,  374,
			  374,  374,  374,  374,  374,  374,  374,  374,  374,  285,
			  284,  282,  281,  275,  265,  258,  252,  251,  239,  236, yy_Dummy>>,
			1, 200, 1600)
		end

	yy_nxt_template_10 (an_array: ARRAY [INTEGER])
			-- Fill chunk #10 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  230,  228,  214,  216,  214,  209,  106,  160,  107,  157,
			  148,  142,  107,  107,  513,   21,  513,  513,  513,  513,
			  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,
			  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,
			  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,
			  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,
			  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,
			  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,
			  513,  513,  513,  513,  513,  513,  513,  513,  513, yy_Dummy>>,
			1, 89, 1800)
		end

	yy_chk_template: SPECIAL [INTEGER]
			-- Template for `yy_chk'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 1888)
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
			    1,    1,    1,    1,    3,    4,  120,    3,    4,    3,
			    4,    5,    5,    5,    6,    6,    6,    5,   13,   13,
			    6,    7,    7,    7,    8,    8,    8,    9,    9,    9,

			   10,   10,   10,   11,   11,   11,  120,   11,   12,   12,
			   12,  251,   12,   14,   14,   15,   15,   15,   16,   16,
			   16,   17,   17,   17,  251,   17,   18,   18,   18,  508,
			   18,   19,   19,   20,   20,   23,   23,   23,   24,   24,
			   24,   26,   29,   26,  124,   23,   28,   28,   24,   53,
			   31,   30,   29,   30,   30,   30,   30,   31,   36,   36,
			   33,   49,   33,   33,   33,   33,   37,   37,   42,  344,
			   11,   17,   33,   53,  124,   12,   18,   34,   42,   34,
			   34,   34,   34,   49,   46,   26,   80,   80,   55,   43,
			   46,   43,   39,   51,   60,  504,   60,   39,  344,   39, yy_Dummy>>,
			1, 200, 0)
		end

	yy_chk_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			   33,   43,   33,   26,   39,   39,   31,   32,   51,   32,
			   32,   32,   32,  493,   43,   43,   55,   34,  134,   32,
			   32,   44,   39,   39,   41,   44,   39,   39,   41,  490,
			   51,   41,   45,  106,   41,   82,   82,   41,   44,   45,
			   45,   32,  106,   54,   52,   45,  217,   32,  134,   32,
			   32,   44,   41,   41,   52,  217,   41,   54,   48,   41,
			   44,   45,   74,   74,   45,   74,  489,   45,   48,  144,
			   48,  125,   52,   54,   48,  486,   52,   58,   58,   58,
			   58,   65,   65,   65,   69,   69,   69,   65,   48,   72,
			   72,   72,  121,   48,   48,  125,   48,   79,   79,  144,

			   79,  485,   79,   84,   84,   84,   86,   86,  484,   86,
			   92,   92,   94,   94,  121,   58,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   75,
			   75,   75,  480,   75,   77,   77,   77,  230,   77,   87, yy_Dummy>>,
			1, 200, 200)
		end

	yy_chk_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			   87,   87,  356,   87,   89,   89,   89,  122,   89,   91,
			   91,   97,   91,   97,   91,   95,   95,   95,  100,  100,
			  100,  230,  100,  127,  100,   95,  101,  101,  101,  122,
			  101,  356,  101,  108,  108,  108,  108,  109,  109,  109,
			  109,  188,  188,  112,  112,  127,  108,  190,  190,   87,
			  109,  113,  113,  113,   89,   97,   75,  161,  458,  161,
			  110,   77,  110,  110,  110,  110,  100,  115,  115,  115,
			  115,  108,  110,   97,  101,  111,  130,  111,  111,  111,
			  111,  112,  119,  128,  100,  119,  132,  128,  131,  113,
			  132,  168,  101,  168,  133,  142,  141,  145,  130,  143,

			  110,  128,  110,  131,  445,  115,  150,  149,  141,  152,
			  119,  149,  132,  128,  154,  111,  128,  142,  131,  133,
			  138,  143,  138,  128,  138,  131,  141,  145,  150,  153,
			  442,  152,  149,  157,  153,  138,  154,  208,  138,  208,
			  158,  158,  158,  158,  438,  153,  159,  159,  159,  159,
			  138,  138,  138,  178,  178,  157,  178,  138,  252,  153,
			  138,  148,  436,  148,  165,  165,  165,  153,  167,  167,
			  167,  148,  180,  180,  148,  180,  148,  148,  158,  169,
			  169,  169,  169,  252,  159,  204,  204,  171,  171,  171,
			  231,  148,  148,  171,  236,  148,  148,  432,  148,  148, yy_Dummy>>,
			1, 200, 400)
		end

	yy_chk_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  174,  174,  174,  176,  176,  176,  182,  182,  182,  275,
			  182,  183,  183,  183,  419,  183,  184,  184,  282,  184,
			  231,  184,  186,  186,  236,  186,  337,  186,  192,  192,
			  192,  194,  194,  275,  194,  196,  196,  237,  196,  198,
			  198,  198,  282,  198,  199,  199,  199,  323,  199,  200,
			  200,  337,  200,  239,  200,  202,  202,  380,  202,  237,
			  202,  206,  206,  209,  209,  209,  209,  418,  210,  210,
			  210,  323,  210,  182,  210,  212,  212,  212,  183,  212,
			  412,  212,  243,  239,  216,  380,  223,  223,  410,  198,
			  216,  216,  216,  216,  199,  218,  218,  224,  224,  218,

			  218,  218,  218,  409,  219,  219,  219,  219,  221,  221,
			  221,  221,  243,  222,  222,  238,  210,  222,  222,  222,
			  222,  221,  235,  212,  223,  225,  225,  225,  226,  226,
			  226,  240,  241,  246,  210,  224,  249,  238,  250,  235,
			  257,  212,  219,  247,  259,  229,  221,  229,  229,  229,
			  229,  268,  235,  240,  241,  246,  265,  247,  249,  265,
			  250,  235,  269,  225,  270,  271,  226,  273,  278,  281,
			  257,  340,  408,  247,  259,  285,  285,  285,  285,  385,
			  407,  268,  270,  385,  269,  229,  265,  271,  265,  405,
			  278,  286,  286,  286,  270,  403,  340,  273,  401,  281, yy_Dummy>>,
			1, 200, 600)
		end

	yy_chk_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  294,  294,  294,  294,  270,  289,  289,  289,  289,  289,
			  291,  291,  291,  291,  291,  293,  293,  293,  293,  293,
			  295,  295,  295,  295,  296,  296,  296,  296,  297,  297,
			  301,  301,  297,  297,  297,  297,  399,  296,  298,  298,
			  298,  298,  299,  299,  299,  299,  300,  300,  300,  300,
			  302,  302,  303,  303,  303,  304,  304,  304,  295,  308,
			  309,  311,  296,  314,  307,  307,  307,  307,  301,  320,
			  316,  398,  319,  322,  324,  325,  298,  307,  327,  333,
			  335,  308,  309,  342,  300,  314,  345,  348,  302,  349,
			  303,  311,  316,  304,  319,  322,  324,  325,  351,  320,

			  327,  333,  335,  352,  357,  342,  358,  359,  345,  348,
			  363,  391,  363,  373,  349,  362,  362,  362,  362,  362,
			  365,  365,  365,  365,  364,  352,  357,  381,  351,  366,
			  366,  358,  379,  366,  366,  366,  366,  359,  367,  367,
			  367,  367,  368,  368,  368,  368,  369,  369,  369,  369,
			  370,  370,  370,  370,  371,  371,  379,  381,  365,  369,
			  372,  372,  372,  375,  375,  375,  375,  376,  376,  384,
			  386,  376,  376,  376,  376,  388,  375,  389,  390,  392,
			  368,  393,  394,  402,  369,  477,  396,  397,  370,  416,
			  406,  384,  371,  411,  386,  413,  415,  388,  372,  421, yy_Dummy>>,
			1, 200, 800)
		end

	yy_chk_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  433,  375,  353,  393,  350,  389,  394,  390,  396,  392,
			  477,  397,  406,  402,  347,  411,  346,  413,  415,  416,
			  434,  437,  433,  421,  423,  423,  423,  423,  424,  424,
			  424,  424,  425,  425,  425,  425,  426,  426,  426,  426,
			  427,  427,  434,  437,  427,  427,  427,  427,  428,  428,
			  428,  428,  429,  429,  429,  429,  430,  430,  430,  430,
			  439,  444,  423,  447,  448,  449,  451,  450,  455,  343,
			  425,  452,  334,  453,  426,  456,  462,  463,  465,  466,
			  466,  466,  466,  469,  474,  447,  428,  449,  448,  450,
			  439,  444,  455,  452,  430,  453,  451,  470,  462,  456,

			  465,  463,  467,  467,  467,  467,  468,  468,  468,  468,
			  472,  475,  476,  469,  474,  483,  487,  466,  496,  470,
			  332,  331,  330,  500,  329,  502,  538,  538,  326,  321,
			  538,  538,  538,  318,  472,  317,  315,  313,  312,  483,
			  310,  475,  476,  496,  468,  500,  487,  502,  514,  514,
			  514,  514,  514,  514,  514,  514,  514,  514,  514,  514,
			  514,  514,  514,  514,  514,  514,  514,  514,  514,  514,
			  514,  514,  515,  515,  515,  515,  515,  515,  515,  515,
			  515,  515,  515,  515,  515,  515,  515,  515,  515,  515,
			  515,  515,  515,  515,  515,  515,  516,  516,  516,  516, yy_Dummy>>,
			1, 200, 1000)
		end

	yy_chk_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  516,  516,  516,  516,  516,  516,  516,  516,  516,  516,
			  516,  516,  516,  516,  516,  516,  516,  516,  516,  516,
			  517,  517,  517,  517,  517,  517,  517,  517,  517,  517,
			  517,  517,  517,  517,  517,  517,  517,  517,  517,  517,
			  517,  517,  517,  517,  518,  518,  518,  518,  518,  518,
			  518,  518,  518,  518,  518,  518,  518,  518,  518,  518,
			  518,  518,  518,  518,  518,  518,  518,  518,  519,  519,
			  519,  519,  519,  519,  519,  519,  519,  519,  519,  519,
			  519,  519,  519,  519,  519,  519,  519,  519,  519,  519,
			  519,  519,  520,  520,  520,  520,  520,  520,  520,  520,

			  520,  520,  520,  520,  520,  520,  520,  520,  520,  520,
			  520,  520,  520,  520,  520,  520,  521,  521,  521,  521,
			  521,  521,  521,  521,  521,  521,  521,  521,  521,  521,
			  521,  521,  521,  521,  521,  521,  521,  521,  521,  521,
			  522,  522,  522,  522,  522,  522,  522,  522,  522,  522,
			  522,  522,  522,  522,  522,  522,  522,  522,  522,  522,
			  522,  522,  522,  522,  523,  523,  306,  523,  523,  523,
			  523,  523,  523,  523,  523,  523,  523,  523,  523,  523,
			  523,  523,  523,  523,  523,  523,  523,  523,  524,  305,
			  280,  279,  277,  276,  524,  524,  524,  524,  524,  524, yy_Dummy>>,
			1, 200, 1200)
		end

	yy_chk_template_8 (an_array: ARRAY [INTEGER])
			-- Fill chunk #8 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  524,  524,  524,  524,  524,  524,  524,  524,  524,  524,
			  524,  524,  525,  525,  274,  525,  525,  525,  525,  525,
			  525,  525,  525,  525,  525,  525,  525,  525,  525,  525,
			  525,  525,  525,  525,  525,  525,  526,  526,  272,  267,
			  526,  526,  526,  526,  526,  526,  526,  526,  526,  526,
			  526,  527,  527,  266,  527,  527,  527,  527,  527,  527,
			  527,  527,  527,  527,  527,  527,  527,  527,  527,  527,
			  527,  527,  527,  527,  527,  528,  528,  528,  528,  528,
			  528,  528,  528,  528,  528,  528,  528,  528,  528,  528,
			  528,  528,  528,  528,  528,  528,  528,  528,  528,  529,

			  529,  529,  529,  529,  529,  529,  529,  529,  529,  529,
			  529,  529,  529,  529,  529,  529,  529,  529,  529,  529,
			  529,  529,  529,  530,  530,  530,  530,  530,  530,  530,
			  530,  530,  530,  530,  530,  530,  530,  530,  530,  530,
			  530,  530,  530,  530,  530,  530,  530,  531,  531,  531,
			  531,  531,  531,  531,  531,  531,  531,  531,  531,  531,
			  531,  531,  531,  531,  531,  531,  531,  531,  531,  531,
			  531,  532,  532,  532,  532,  532,  532,  532,  532,  532,
			  532,  532,  532,  532,  532,  532,  532,  532,  532,  532,
			  532,  532,  532,  532,  532,  533,  533,  533,  533,  533, yy_Dummy>>,
			1, 200, 1400)
		end

	yy_chk_template_9 (an_array: ARRAY [INTEGER])
			-- Fill chunk #9 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  533,  533,  533,  533,  533,  533,  533,  533,  533,  533,
			  533,  533,  533,  533,  533,  533,  533,  533,  533,  534,
			  534,  534,  534,  264,  262,  261,  534,  534,  534,  534,
			  534,  260,  534,  534,  534,  534,  534,  535,  535,  258,
			  535,  535,  535,  535,  535,  535,  535,  535,  535,  535,
			  535,  535,  535,  535,  535,  535,  535,  535,  535,  535,
			  535,  536,  536,  536,  536,  536,  536,  536,  536,  536,
			  536,  536,  536,  536,  536,  536,  536,  536,  536,  536,
			  536,  536,  536,  536,  536,  537,  537,  537,  537,  537,
			  537,  537,  537,  256,  537,  537,  537,  537,  537,  537,

			  537,  537,  537,  537,  537,  537,  537,  537,  537,  539,
			  539,  539,  539,  255,  254,  253,  539,  539,  539,  539,
			  539,  248,  539,  539,  539,  539,  539,  540,  540,  244,
			  540,  540,  540,  540,  540,  540,  540,  540,  540,  540,
			  540,  540,  540,  540,  540,  540,  540,  540,  540,  540,
			  540,  541,  541,  242,  234,  541,  541,  541,  542,  542,
			  228,  227,  542,  542,  542,  543,  543,  543,  543,  543,
			  543,  543,  543,  215,  543,  543,  543,  543,  543,  543,
			  543,  543,  543,  543,  543,  543,  543,  543,  543,  163,
			  160,  156,  155,  151,  147,  140,  137,  135,  126,  123, yy_Dummy>>,
			1, 200, 1600)
		end

	yy_chk_template_10 (an_array: ARRAY [INTEGER])
			-- Fill chunk #10 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  118,  114,  105,  104,  103,   99,   96,   59,   57,   56,
			   50,   47,   38,   35,   21,  513,  513,  513,  513,  513,
			  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,
			  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,
			  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,
			  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,
			  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,
			  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,
			  513,  513,  513,  513,  513,  513,  513,  513,  513, yy_Dummy>>,
			1, 89, 1800)
		end

	yy_base_template: SPECIAL [INTEGER]
			-- Template for `yy_base'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 543)
			yy_base_template_1 (an_array)
			yy_base_template_2 (an_array)
			yy_base_template_3 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_base_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			    0,    0,    0,   71,   72,   79,   82,   89,   92,   95,
			   98,  101,  106,   85,  110,  113,  116,  119,  124,  128,
			  130, 1814, 1815,  133,  136, 1815,  135,    0,  138,  130,
			  138,  136,  194,  147,  164, 1792,  138,  145, 1791,  162,
			    0,  193,  140,  154,  197,  203,  152, 1773,  233,  120,
			 1782,  165,  213,  112,  219,  157, 1771, 1757,  262, 1736,
			  188, 1815, 1815,  315, 1815,  279, 1815, 1815, 1815,  282,
			 1815, 1815,  287, 1815,  259,  387, 1815,  392, 1815,  294,
			  183, 1815,  232, 1815,  301, 1815,  303,  397, 1815,  402,
			 1815,  406,  307, 1815,  309,  413, 1794,  405, 1815, 1791,

			  416,  424,    0, 1795, 1789, 1793,  230, 1815,  418,  422,
			  447,  462,  428,  436, 1748,  452, 1815,    0, 1772,  450,
			   49,  250,  364, 1771,  120,  234, 1770,  382,  458,    0,
			  434,  461,  447,  459,  194, 1759,    0, 1757,  493,    0,
			 1761,  470,  452,  457,  242,  471,    0, 1766,  534,  472,
			  465, 1765,  465,  502,  473, 1760, 1763,  492,  525,  531,
			 1718,  451, 1815, 1775, 1815,  562, 1815,  566,  485,  564,
			 1815,  585, 1815, 1815,  598, 1815,  601, 1815,  550, 1815,
			  569, 1815,  604,  609,  613, 1815,  619, 1815,  438, 1815,
			  444, 1815,  626, 1815,  628, 1815,  632, 1815,  637,  642, yy_Dummy>>,
			1, 200, 0)
		end

	yy_base_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			  646, 1815,  652, 1815,  582, 1815,  658, 1815,  531,  648,
			  666, 1815,  673, 1815, 1815, 1764,  675,  243,  684,  689,
			 1815,  693,  702,  671,  682,  710,  713, 1708, 1707,  732,
			  360,  566,    0,    0, 1722,  698,  568,  595,  670,  629,
			  690,  688, 1725,  658, 1701,    0,  689,  719, 1693,  694,
			  695,   75,  523, 1687, 1682, 1685, 1654,  716, 1611,  720,
			 1592, 1597, 1586,    0, 1595,  730, 1425, 1411,  727,  718,
			  738,  724, 1410,  743, 1382,  572, 1365, 1364,  728, 1359,
			 1358,  742,  581,    0, 1815,  760,  789, 1815, 1815,  791,
			 1815,  796, 1815,  801,  785,  805,  809,  817,  823,  827,

			  831,  815,  835,  837,  840, 1336, 1313,  849,  816,  818,
			 1110,  835, 1106, 1103,  821, 1108,  827, 1107, 1103,  831,
			  843, 1097,  832,  610,  833,  834, 1100,  834,    0, 1096,
			 1090, 1074, 1073,  838, 1044,  839,    0,  591,    0,    0,
			  736,    0,  839, 1037,  140,  845,  980,  982,  843,  854,
			  956,  872,  862,  963,    0,    0,  373,  860,  871,  883,
			    0,    0,  901,  904,  915,  905,  918,  923,  927,  931,
			  935,  939,  945,  860, 1815,  948,  956,    0,    0,  895,
			  626,  902,    0,    0,  928,  751,  933,    0,  934,  946,
			  949,  883,  952,  938,  945,    0,  945,  950,  843,  804, yy_Dummy>>,
			1, 200, 200)
		end

	yy_base_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			    0,  766,  957,  763,    0,  761,  949,  733,  740,  675,
			  660,  952,  652,  952,    0,  953,  965,    0,  635,  586,
			    0,  962, 1815, 1009, 1013, 1017, 1021, 1029, 1033, 1037,
			 1041,    0,  569,  956,  977,    0,  524,  978,  516, 1036,
			    0,    0,  502,    0, 1037,  476,    0, 1021, 1027, 1022,
			 1024, 1042, 1028, 1031,    0, 1031, 1038,    0,  430,    0,
			    0,    0, 1033, 1040,    0, 1035, 1064, 1087, 1091, 1056,
			 1054,    0, 1073,    0, 1057, 1086, 1085,  950,    0,    0,
			  362,    0,    0, 1078,  280,  263,  247, 1090,    0,  238,
			  201,    0,    0,  185,    0,    0, 1083,    0,    0,    0,

			 1080,    0, 1084,    0,  167,    0,    0,    0,  101,    0,
			    0,    0,    0, 1815, 1147, 1171, 1195, 1219, 1243, 1267,
			 1291, 1315, 1339, 1363, 1387, 1411, 1426, 1450, 1474, 1498,
			 1522, 1546, 1570, 1594, 1614, 1636, 1660, 1684, 1116, 1704,
			 1726, 1741, 1748, 1764, yy_Dummy>>,
			1, 144, 400)
		end

	yy_def_template: SPECIAL [INTEGER]
			-- Template for `yy_def'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 543)
			yy_def_template_1 (an_array)
			yy_def_template_2 (an_array)
			yy_def_template_3 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_def_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			    0,  513,    1,  514,  514,  515,  515,  516,  516,  517,
			  517,  518,  518,  519,  519,  520,  520,  521,  521,  522,
			  522,  513,  513,  513,  513,  513,  523,  524,  525,  513,
			  513,  513,  513,  513,  513,  513,  513,  513,  513,  526,
			  526,  526,  526,  526,  526,  526,  526,  526,  526,  526,
			  526,  526,  526,  526,  526,  526,  526,  513,  513,  513,
			  527,  513,  513,  513,  513,  513,  513,  513,  513,  513,
			  513,  513,  513,  513,  528,  528,  513,  528,  513,  529,
			  530,  513,  530,  513,  513,  513,  531,  531,  513,  531,
			  513,  532,  533,  513,  533,  513,  513,  523,  513,  534,

			  523,  523,  524,  513,  535,  513,  536,  513,  513,  537,
			  513,  513,  513,  513,  538,  513,  513,  526,  526,  526,
			  526,  526,  526,  526,  526,  526,  526,  526,  526,  526,
			  526,  526,  526,  526,  526,  526,  526,  526,  526,  526,
			  526,  526,  526,  526,  526,  526,  526,  526,  526,  526,
			  526,  526,  526,  526,  526,  526,  526,  526,  513,  513,
			  513,  527,  513,  539,  513,  513,  513,  513,  527,  513,
			  513,  513,  513,  513,  513,  513,  513,  513,  528,  513,
			  528,  513,  528,  528,  529,  513,  529,  513,  530,  513,
			  530,  513,  513,  513,  531,  513,  531,  513,  531,  531, yy_Dummy>>,
			1, 200, 0)
		end

	yy_def_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  532,  513,  532,  513,  533,  513,  533,  513,  540,  513,
			  523,  513,  523,  513,  513,  513,  513,  536,  513,  513,
			  513,  513,  513,  513,  513,  513,  513,  538,  541,  513,
			  526,  526,  526,  526,  526,  526,  526,  526,  526,  526,
			  526,  526,  526,  526,  526,  526,  526,  526,  526,  526,
			  526,  526,  526,  526,  526,  526,  526,  526,  526,  526,
			  526,  526,  526,  526,  526,  526,  526,  526,  526,  526,
			  526,  526,  526,  526,  526,  526,  526,  526,  526,  526,
			  526,  526,  526,  526,  513,  513,  513,  513,  513,  513,
			  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,

			  513,  513,  513,  513,  513,  542,  541,  543,  526,  526,
			  526,  526,  526,  526,  526,  526,  526,  526,  526,  526,
			  526,  526,  526,  526,  526,  526,  526,  526,  526,  526,
			  526,  526,  526,  526,  526,  526,  526,  526,  526,  526,
			  526,  526,  526,  526,  526,  526,  526,  526,  526,  526,
			  526,  526,  526,  526,  526,  526,  526,  526,  526,  526,
			  526,  526,  513,  527,  513,  513,  513,  513,  513,  513,
			  513,  513,  513,  542,  513,  513,  513,  526,  526,  526,
			  526,  526,  526,  526,  526,  526,  526,  526,  526,  526,
			  526,  526,  526,  526,  526,  526,  526,  526,  526,  526, yy_Dummy>>,
			1, 200, 200)
		end

	yy_def_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  526,  526,  526,  526,  526,  526,  526,  526,  526,  526,
			  526,  526,  526,  526,  526,  526,  526,  526,  526,  526,
			  526,  526,  513,  513,  513,  513,  513,  513,  513,  513,
			  513,  526,  526,  526,  526,  526,  526,  526,  526,  526,
			  526,  526,  526,  526,  526,  526,  526,  526,  526,  526,
			  526,  526,  526,  526,  526,  526,  526,  526,  526,  526,
			  526,  526,  526,  526,  526,  526,  513,  513,  513,  526,
			  526,  526,  526,  526,  526,  526,  526,  526,  526,  526,
			  526,  526,  526,  526,  526,  526,  526,  526,  526,  526,
			  526,  526,  526,  526,  526,  526,  526,  526,  526,  526,

			  526,  526,  526,  526,  526,  526,  526,  526,  526,  526,
			  526,  526,  526,    0,  513,  513,  513,  513,  513,  513,
			  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,
			  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,
			  513,  513,  513,  513, yy_Dummy>>,
			1, 144, 400)
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
			    1,    1,    2,    5,    6,    7,    5,    8,    7,    9,
			   10,   10,    5,   11,    5,   12,   13,   14,   15,   16,
			   17,   17,   17,   17,   17,   17,   18,   18,   19,    5,
			   20,   21,   22,   23,    7,   24,   25,   26,   27,   28,
			   29,   30,   31,   32,   33,   34,   35,   36,   37,   38,
			   39,   40,   41,   42,   43,   44,   45,   46,   47,   48,
			   49,   50,   51,   52,    5,   53,    1,   54,   55,   56,

			   57,   28,   58,   30,   59,   32,   33,   34,   60,   36,
			   61,   38,   39,   62,   63,   64,   65,   66,   67,   46,
			   47,   48,   49,   68,    7,   69,   70,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,   71,    1,    1,
			    1,   72,    1,    1,    1,    1,    1,    1,    1,    1, yy_Dummy>>,
			1, 200, 0)
		end

	yy_ec_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,   73,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1, yy_Dummy>>,
			1, 57, 200)
		end

	yy_meta_template: SPECIAL [INTEGER]
			-- Template for `yy_meta'
		once
			Result := yy_fixed_array (<<
			    0,    1,    2,    3,    4,    1,    5,    1,    6,    7,
			    8,    1,    1,    9,    7,   10,   10,   10,   11,    1,
			   12,    1,   13,    1,   14,   14,   14,   15,   10,   16,
			   17,   18,   17,   17,   17,   19,   17,   20,   17,   17,
			   21,   21,   21,   21,   21,   22,   17,   17,   17,   23,
			    1,    1,    1,   10,   10,   10,   10,   10,   10,   17,
			   17,   17,   17,   17,   17,   17,   17,   24,    1,    1,
			    1,    1,    1,    1, yy_Dummy>>)
		end

	yy_accept_template: SPECIAL [INTEGER]
			-- Template for `yy_accept'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 514)
			yy_accept_template_1 (an_array)
			yy_accept_template_2 (an_array)
			yy_accept_template_3 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_accept_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			    0,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    2,    3,    4,    5,    5,    5,    6,    7,
			    8,    9,   10,   12,   15,   17,   20,   23,   26,   29,
			   32,   35,   38,   41,   44,   47,   50,   53,   56,   59,
			   62,   65,   68,   71,   74,   77,   80,   83,   86,   89,
			   92,   95,   98,  101,  104,  107,  110,  113,  115,  117,
			  119,  121,  123,  125,  127,  129,  131,  133,  136,  138,
			  140,  142,  144,  146,  148,  150,  152,  154,  156,  158,
			  160,  162,  164,  166,  168,  170,  172,  174,  176,  178,
			  180,  182,  184,  186,  188,  190,  191,  191,  192,  194,

			  194,  196,  198,  199,  200,  201,  203,  204,  205,  207,
			  207,  208,  209,  210,  210,  210,  211,  212,  213,  214,
			  215,  216,  218,  219,  220,  221,  222,  223,  224,  225,
			  227,  228,  229,  230,  231,  232,  233,  235,  236,  237,
			  239,  240,  241,  242,  243,  244,  245,  247,  248,  249,
			  250,  251,  252,  253,  254,  255,  256,  257,  258,  259,
			  259,  259,  260,  261,  261,  262,  263,  264,  265,  267,
			  269,  271,  271,  272,  273,  273,  274,  274,  275,  276,
			  277,  278,  279,  280,  281,  282,  284,  285,  287,  288,
			  289,  290,  292,  292,  293,  294,  295,  296,  297,  298, yy_Dummy>>,
			1, 200, 0)
		end

	yy_accept_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			  299,  300,  302,  303,  305,  306,  307,  308,  310,  311,
			  311,  312,  313,  314,  315,  316,  317,  319,  320,  320,
			  320,  321,  323,  324,  325,  325,  326,  326,  327,  327,
			  328,  329,  330,  332,  334,  335,  336,  337,  338,  339,
			  340,  341,  342,  343,  344,  345,  347,  348,  349,  350,
			  351,  352,  353,  354,  355,  356,  357,  358,  359,  360,
			  361,  362,  364,  365,  367,  368,  369,  370,  371,  372,
			  373,  374,  375,  376,  377,  378,  379,  380,  381,  382,
			  383,  384,  385,  386,  388,  389,  389,  389,  390,  392,
			  393,  394,  394,  395,  396,  396,  398,  399,  399,  399,

			  399,  401,  402,  403,  404,  405,  406,  407,  407,  408,
			  409,  410,  411,  412,  413,  414,  415,  416,  417,  418,
			  419,  420,  422,  423,  424,  425,  426,  427,  428,  430,
			  431,  432,  433,  434,  435,  436,  437,  439,  440,  442,
			  444,  445,  447,  448,  449,  450,  451,  452,  453,  454,
			  455,  456,  457,  458,  459,  461,  463,  464,  465,  466,
			  467,  469,  471,  471,  473,  474,  474,  474,  474,  478,
			  479,  479,  480,  481,  482,  483,  484,  485,  487,  489,
			  490,  491,  492,  494,  496,  497,  498,  499,  501,  502,
			  503,  504,  505,  506,  507,  508,  510,  511,  512,  513, yy_Dummy>>,
			1, 200, 200)
		end

	yy_accept_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			  514,  516,  517,  518,  519,  521,  522,  523,  524,  525,
			  526,  527,  528,  529,  530,  532,  533,  534,  536,  537,
			  538,  540,  541,  542,  543,  543,  544,  544,  544,  545,
			  545,  546,  548,  549,  550,  551,  553,  554,  555,  556,
			  557,  559,  561,  562,  564,  565,  566,  568,  569,  570,
			  571,  572,  573,  574,  575,  577,  578,  579,  581,  582,
			  584,  586,  588,  589,  590,  592,  593,  595,  595,  597,
			  598,  599,  601,  602,  604,  605,  606,  607,  608,  610,
			  612,  613,  615,  617,  618,  619,  620,  621,  622,  624,
			  625,  626,  628,  630,  631,  633,  635,  636,  638,  640,

			  642,  643,  645,  646,  648,  649,  651,  653,  655,  656,
			  658,  660,  662,  664,  664, yy_Dummy>>,
			1, 115, 400)
		end

	yy_acclist_template: SPECIAL [INTEGER]
			-- Template for `yy_acclist'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 663)
			yy_acclist_template_1 (an_array)
			yy_acclist_template_2 (an_array)
			yy_acclist_template_3 (an_array)
			yy_acclist_template_4 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_acclist_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			    0,   89,   89,   92,   92,  100,  100,  103,  103,  144,
			  142,  143,    2,  142,  143,    2,  143,    3,  142,  143,
			  105,  142,  143,   73,  142,  143,   80,  142,  143,    3,
			  142,  143,    3,  142,  143,    3,  142,  143,  123,  142,
			  143,  123,  142,  143,  123,  142,  143,    3,  142,  143,
			    3,  142,  143,    3,  142,  143,    3,  142,  143,   72,
			  142,  143,   72,  142,  143,   72,  142,  143,   72,  142,
			  143,   72,  142,  143,   72,  142,  143,   72,  142,  143,
			   72,  142,  143,   72,  142,  143,   72,  142,  143,   72,
			  142,  143,   72,  142,  143,   72,  142,  143,   72,  142,

			  143,   72,  142,  143,   72,  142,  143,   72,  142,  143,
			   72,  142,  143,  142,  143,  142,  143,  142,  143,  112,
			  143,  116,  143,  113,  143,  115,  143,  121,  143,  121,
			  143,  120,  143,  119,  121,  143,  118,  143,  118,  143,
			  117,  143,   84,  143,   84,  143,   83,  143,   89,  143,
			   89,  143,   88,  143,   89,  143,   86,  143,   89,  143,
			   92,  143,   91,  143,   92,  143,   95,  143,   95,  143,
			   94,  143,  100,  143,  100,  143,   99,  143,  100,  143,
			   97,  143,  100,  143,  103,  143,  102,  143,  103,  143,
			    2,  105,   81,  104,  105, -236,  105, -225,   73,   80, yy_Dummy>>,
			1, 200, 0)
		end

	yy_acclist_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			   80,   79,   80,    2,    4,  138,  141,  123,  123,  122,
			  126,  122,   72,   72,   72,   72,    9,   72,   72,   72,
			   72,   72,   72,   72,   72,   18,   72,   72,   72,   72,
			   72,   72,   72,   30,   72,   72,   72,   37,   72,   72,
			   72,   72,   72,   72,   72,   45,   72,   72,   72,   72,
			   72,   72,   72,   72,   72,   72,   72,   72,  125,  112,
			  113,  114,  114,  106,  114,  112,  114,  110,  114,  111,
			  114,  120,  119,  117,   83,   89,   88,   89,   86,   89,
			   89,   89,   87,   88,   89,   85,   86,   92,   91,   92,
			   90,   91,   94,  100,   99,  100,   97,  100,  100,  100,

			   98,   99,  100,   96,   97,  103,  102,  103,  101,  102,
			  105,  105,  -93,  105,  -82,   74,   80,   78,   80,    2,
			  136,  138,  141,  136,  133,  130,  127,  124,   72,   72,
			    7,   72,    8,   72,   72,   72,   72,   72,   72,   72,
			   72,   72,   72,   72,   72,   21,   72,   72,   72,   72,
			   72,   72,   72,   72,   72,   72,   72,   72,   72,   72,
			   72,   72,   41,   72,   72,   43,   72,   72,   72,   72,
			   72,   72,   72,   72,   72,   72,   72,   72,   72,   72,
			   72,   72,   72,   72,   72,   72,   65,   72,    1,  107,
			  106,  107,  109,  104,   75,   77,  138,  141,  141,  137, yy_Dummy>>,
			1, 200, 200)
		end

	yy_acclist_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  140,  135,  134,  132,  131,  129,  128,   72,   72,   72,
			   72,   72,   72,   72,   72,   72,   72,   72,   72,   72,
			   19,   72,   72,   72,   72,   72,   72,   72,   28,   72,
			   72,   72,   72,   72,   72,   72,   72,   38,   72,   72,
			   40,   72,   70,   72,   72,   44,   72,   72,   72,   72,
			   72,   72,   72,   72,   72,   72,   72,   72,   72,   57,
			   72,   58,   72,   72,   72,   72,   72,   63,   72,   64,
			   72,  108,  112,   80,  137,  138,  140,  141,  141,  133,
			  130,  127,  139,  141,  139,    5,   72,    6,   72,   72,
			   72,   72,   11,   72,   66,   72,   72,   72,   72,   16,

			   72,   72,   72,   72,   72,   72,   72,   72,   26,   72,
			   72,   72,   72,   72,   33,   72,   72,   72,   72,   39,
			   72,   72,   72,   72,   72,   72,   72,   72,   72,   72,
			   53,   72,   72,   72,   56,   72,   72,   72,   61,   72,
			   72,   76,  141,  141,  140,  140,   10,   72,   72,   72,
			   72,   13,   72,   72,   72,   72,   72,   20,   72,   22,
			   72,   72,   24,   72,   72,   72,   29,   72,   72,   72,
			   72,   72,   72,   72,   72,   47,   72,   72,   72,   49,
			   72,   72,   51,   72,   52,   72,   54,   72,   72,   72,
			   60,   72,   72,  140,  141,  140,  141,   72,   72,   12, yy_Dummy>>,
			1, 200, 400)
		end

	yy_acclist_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			   72,   72,   15,   72,   72,   72,   72,   72,   27,   72,
			   31,   72,   72,   34,   72,   35,   72,   72,   72,   72,
			   72,   72,   50,   72,   72,   72,   62,   72,   67,   72,
			   72,   14,   72,   17,   72,   72,   23,   72,   25,   72,
			   32,   72,   72,   42,   72,   72,   48,   72,   72,   55,
			   72,   59,   72,   68,   72,   72,   36,   72,   46,   72,
			   71,   72,   69,   72, yy_Dummy>>,
			1, 64, 600)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER = 1815
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER = 513
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER = 514
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

	yyNb_rules: INTEGER = 143
			-- Number of rules

	yyEnd_of_buffer: INTEGER = 144
			-- End of buffer rule code

	yyLine_used: BOOLEAN = true
			-- Are line and column numbers used?

	yyPosition_used: BOOLEAN = false
			-- Is `position' used?

	INITIAL: INTEGER = 0
	MS: INTEGER = 1
	MSN: INTEGER = 2
	MSN1: INTEGER = 3
	VS1: INTEGER = 4
	VS2: INTEGER = 5
	VS3: INTEGER = 6
	LAVS1: INTEGER = 7
	LAVS2: INTEGER = 8
	LAVS3: INTEGER = 9
			-- Start condition codes

feature -- User-defined features



end
