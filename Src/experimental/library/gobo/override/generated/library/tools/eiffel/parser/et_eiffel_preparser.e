indexing

	description:

		"Eiffel preparsers"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 2002-2009, Eric Bezault and others"
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
if yy_act <= 71 then
if yy_act <= 36 then
if yy_act <= 18 then
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
if yy_act <= 14 then
if yy_act <= 12 then
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
	yy_column := yy_column + 6
--|#line 47 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 47")
end

			
end
else
if yy_act = 13 then
	yy_column := yy_column + 8
--|#line 48 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 48")
end

			
else
	yy_column := yy_column + 7
--|#line 49 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 49")
end

			
end
end
else
if yy_act <= 16 then
if yy_act = 15 then
	yy_column := yy_column + 5
--|#line 50 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 50")
end

			
else
	yy_column := yy_column + 8
--|#line 51 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 51")
end

			
end
else
if yy_act = 17 then
	yy_column := yy_column + 2
--|#line 52 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 52")
end

			
else
	yy_column := yy_column + 4
--|#line 53 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 53")
end

			
end
end
end
end
else
if yy_act <= 27 then
if yy_act <= 23 then
if yy_act <= 21 then
if yy_act <= 20 then
if yy_act = 19 then
	yy_column := yy_column + 6
--|#line 54 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 54")
end

			
else
	yy_column := yy_column + 3
--|#line 55 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 55")
end

			
end
else
	yy_column := yy_column + 6
--|#line 56 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 56")
end

			
end
else
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
end
else
if yy_act <= 25 then
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
else
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
end
end
else
if yy_act <= 32 then
if yy_act <= 30 then
if yy_act <= 29 then
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
else
	yy_column := yy_column + 7
--|#line 65 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 65")
end

			
end
else
if yy_act = 31 then
	yy_column := yy_column + 8
--|#line 66 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 66")
end

			
else
	yy_column := yy_column + 5
--|#line 67 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 67")
end

			
end
end
else
if yy_act <= 34 then
if yy_act = 33 then
	yy_column := yy_column + 7
--|#line 68 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 68")
end

			
else
	yy_column := yy_column + 7
--|#line 69 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 69")
end

			
end
else
if yy_act = 35 then
	yy_column := yy_column + 9
--|#line 70 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 70")
end

			
else
	yy_column := yy_column + 2
--|#line 71 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 71")
end

			
end
end
end
end
end
else
if yy_act <= 54 then
if yy_act <= 45 then
if yy_act <= 41 then
if yy_act <= 39 then
if yy_act <= 38 then
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
else
	yy_column := yy_column + 4
--|#line 74 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 74")
end

			
end
else
if yy_act = 40 then
	yy_column := yy_column + 3
--|#line 75 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 75")
end

			
else
	yy_column := yy_column + 8
--|#line 76 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 76")
end

			
end
end
else
if yy_act <= 43 then
if yy_act = 42 then
	yy_column := yy_column + 3
--|#line 77 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 77")
end

			
else
	yy_column := yy_column + 4
--|#line 78 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 78")
end

			
end
else
if yy_act = 44 then
	yy_column := yy_column + 2
--|#line 79 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 79")
end

			
else
	yy_column := yy_column + 9
--|#line 80 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 80")
end

			
end
end
end
else
if yy_act <= 50 then
if yy_act <= 48 then
if yy_act <= 47 then
if yy_act = 46 then
	yy_column := yy_column + 6
--|#line 81 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 81")
end

			
else
	yy_column := yy_column + 8
--|#line 82 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 82")
end

			
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
else
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
end
end
else
if yy_act <= 63 then
if yy_act <= 59 then
if yy_act <= 57 then
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
	yy_column := yy_column + 4
--|#line 92 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 92")
end

			
end
else
if yy_act = 58 then
	yy_column := yy_column + 8
--|#line 93 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 93")
end

			
else
	yy_column := yy_column + 6
--|#line 94 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 94")
end

			
end
end
else
if yy_act <= 61 then
if yy_act = 60 then
	yy_column := yy_column + 5
--|#line 95 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 95")
end

			
else
	yy_column := yy_column + 7
--|#line 96 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 96")
end

			
end
else
if yy_act = 62 then
	yy_column := yy_column + 4
--|#line 97 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 97")
end

			
else
	yy_column := yy_column + 4
--|#line 98 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 98")
end

			
end
end
end
else
if yy_act <= 67 then
if yy_act <= 65 then
if yy_act = 64 then
	yy_column := yy_column + 3
--|#line 99 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 99")
end

			
else
	yy_column := yy_column + 5
--|#line 101 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 101")
end

				class_keyword_found := True
			
end
else
if yy_act = 66 then
	yy_column := yy_column + 8
--|#line 104 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 104")
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
			
else
	yy_column := yy_column + 9
--|#line 116 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 116")
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
else
if yy_act <= 69 then
if yy_act = 68 then
	yy_column := yy_column + 10
--|#line 128 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 128")
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
			
else
	yy_column := yy_column + 4
--|#line 140 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 140")
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
			
end
else
if yy_act = 70 then
	yy_column := yy_column + 9
--|#line 152 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 152")
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
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 168 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 168")
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
end
end
end
end
end
else
if yy_act <= 107 then
if yy_act <= 89 then
if yy_act <= 80 then
if yy_act <= 76 then
if yy_act <= 74 then
if yy_act <= 73 then
if yy_act = 72 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 182 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 182")
end

			
else
	yy_column := yy_column + 3
--|#line 191 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 191")
end

			
end
else
	yy_column := yy_column + 4
--|#line 192 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 192")
end

			
end
else
if yy_act = 75 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 193 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 193")
end

			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 196 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 196")
end

					-- Syntax error: missing character / at end
					-- of special character specification %/code/.
				column := column + text_count
				set_syntax_error
				error_handler.report_SCAS_error (filename, current_position)
				column := column - text_count
				last_token := E_CHARERR
			
end
end
else
if yy_act <= 78 then
if yy_act = 77 then
	yy_column := yy_column + 3
--|#line 205 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 205")
end

					-- Syntax error: missing ASCII code in
					-- special character specification %/code/.
				column := column + 3
				set_syntax_error
				error_handler.report_SCAC_error (filename, current_position)
				column := column - 3
				last_token := E_CHARERR
			
else
	yy_column := yy_column + 2
--|#line 214 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 214")
end

					-- Syntax error: missing character between quotes.
				column := column + 1
				set_syntax_error
				error_handler.report_SCQQ_error (filename, current_position)
				column := column - 1
				last_token := E_CHARERR
			
end
else
if yy_act = 79 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 222 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 222")
end

					-- Syntax error: missing quote at
					-- end of character constant.
				column := column + text_count
				set_syntax_error
				error_handler.report_SCEQ_error (filename, current_position)
				column := column - text_count
				last_token := E_CHARERR
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 235 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 235")
end

			
end
end
end
else
if yy_act <= 85 then
if yy_act <= 83 then
if yy_act <= 82 then
if yy_act = 81 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 238 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 238")
end

					-- Verbatim string.
				verbatim_marker := text_substring (2, text_count - 1)
				set_start_condition (VS1)
			
else
	yy_line := yy_line + 1
	yy_column := 1
--|#line 246 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 246")
end

				last_literal_start := 1
				last_literal_end := 0
				set_start_condition (VS2)
			
end
else
	yy_column := yy_column + 1
--|#line 251 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 251")
end

					-- No final brace-double-quote.
				last_token := E_STRERR
				report_syntax_error (current_position)
				set_start_condition (INITIAL)
			
end
else
if yy_act = 84 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 267 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 267")
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
--|#line 276 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 276")
end

				more
				set_start_condition (VS3)
			
end
end
else
if yy_act <= 87 then
if yy_act = 86 then
	yy_line := yy_line + 1
	yy_column := 1
--|#line 280 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 280")
end

				more
				last_literal_end := text_count - 2
			
else
	yy_line := yy_line + 1
	yy_column := 1
--|#line 284 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 284")
end

				more
				last_literal_end := text_count - 1
			
end
else
if yy_act = 88 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 288 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 288")
end

					-- No final brace-double-quote.
				last_token := E_STRERR
				report_syntax_error (current_position)
				set_start_condition (INITIAL)
			
else
	yy_line := yy_line + 1
	yy_column := 1
--|#line 304 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 304")
end

				more
				last_literal_end := text_count - 2
				set_start_condition (VS2)
			
end
end
end
end
else
if yy_act <= 98 then
if yy_act <= 94 then
if yy_act <= 92 then
if yy_act <= 91 then
if yy_act = 90 then
	yy_line := yy_line + 1
	yy_column := 1
--|#line 309 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 309")
end

				more
				last_literal_end := text_count - 1
				set_start_condition (VS2)
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 314 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 314")
end

					-- No final brace-double-quote.
				last_token := E_STRERR
				report_syntax_error (current_position)
				set_start_condition (INITIAL)
			
end
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 328 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 328")
end

					-- Left aligned verbatim string.
				verbatim_marker := text_substring (2, text_count - 1)
				set_start_condition (LAVS1)
			
end
else
if yy_act = 93 then
	yy_line := yy_line + 1
	yy_column := 1
--|#line 336 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 336")
end

				last_literal_start := 1
				last_literal_end := 0
				set_start_condition (LAVS2)
			
else
	yy_column := yy_column + 1
--|#line 341 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 341")
end

					-- No final bracket-double-quote.
				last_token := E_STRERR
				report_syntax_error (current_position)
				set_start_condition (INITIAL)
			
end
end
else
if yy_act <= 96 then
if yy_act = 95 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 357 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 357")
end

				if is_verbatim_string_closer (last_literal_end + 1, text_count - 1) then
					verbatim_marker := Void
					set_start_condition (INITIAL)
				else
					more
					set_start_condition (LAVS3)
				end
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 366 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 366")
end

				more
				set_start_condition (LAVS3)
			
end
else
if yy_act = 97 then
	yy_line := yy_line + 1
	yy_column := 1
--|#line 370 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 370")
end

				more
				last_literal_end := text_count - 2
			
else
	yy_line := yy_line + 1
	yy_column := 1
--|#line 374 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 374")
end

				more
				last_literal_end := text_count - 1
			
end
end
end
else
if yy_act <= 103 then
if yy_act <= 101 then
if yy_act <= 100 then
if yy_act = 99 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 378 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 378")
end

					-- No final bracket-double-quote.
				last_token := E_STRERR
				report_syntax_error (current_position)
				set_start_condition (INITIAL)
			
else
	yy_line := yy_line + 1
	yy_column := 1
--|#line 394 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 394")
end

				more
				last_literal_end := text_count - 2
				set_start_condition (LAVS2)
			
end
else
	yy_line := yy_line + 1
	yy_column := 1
--|#line 399 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 399")
end

				more
				last_literal_end := text_count - 1
				set_start_condition (LAVS2)
			
end
else
if yy_act = 102 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 404 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 404")
end

					-- No final bracket-double-quote.
				last_token := E_STRERR
				report_syntax_error (current_position)
				set_start_condition (INITIAL)
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 418 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 418")
end

					-- Manifest string with special characters.
			
end
end
else
if yy_act <= 105 then
if yy_act = 104 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 421 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 421")
end

					-- Manifest string with special characters which may be made
					-- up of several lines or may include invalid characters.
					-- Keep track of current line and column.
				ms_line := line
				ms_column := column
				more
				set_start_condition (MS)
			
else
	yy_line := yy_line + 1
	yy_column := 1
--|#line 432 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 432")
end

					-- Multi-line manifest string.
				more
				set_start_condition (MSN)
			
end
else
if yy_act = 106 then
	yy_end := yy_start + yy_more_len + 2
	yy_column := yy_column + 2
--|#line 437 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 437")
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
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 452 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 452")
end

				more
			
end
end
end
end
end
else
if yy_act <= 125 then
if yy_act <= 116 then
if yy_act <= 112 then
if yy_act <= 110 then
if yy_act <= 109 then
if yy_act = 108 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 455 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 455")
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
			
else
	yy_column := yy_column + 2
--|#line 467 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 467")
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
			
end
else
	yy_column := yy_column + 2
--|#line 479 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 479")
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
else
if yy_act = 111 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 492 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 492")
end

				more
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 495 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 495")
end

				set_start_condition (INITIAL)
			
end
end
else
if yy_act <= 114 then
if yy_act = 113 then
	yy_column := yy_column + 2
--|#line 498 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 498")
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
--|#line 510 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 510")
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
else
if yy_act = 115 then
	yy_line := yy_line + 1
	yy_column := 1
--|#line 523 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 523")
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
--|#line 551 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 551")
end

				more
				set_start_condition (MSN)
			
end
end
end
else
if yy_act <= 121 then
if yy_act <= 119 then
if yy_act <= 118 then
if yy_act = 117 then
	yy_column := yy_column + 1
--|#line 555 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 555")
end

					-- Should never happen.
				last_token := E_STRERR
				report_syntax_error (current_position)
				set_start_condition (INITIAL)
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 570 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 570")
end

				more
				set_start_condition (MS)
			
end
else
	yy_line := yy_line + 1
	yy_column := 1
--|#line 574 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 574")
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
			
end
else
if yy_act = 120 then
	yy_column := yy_column + 1
--|#line 586 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 586")
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
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 617 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 617")
end

			
end
end
else
if yy_act <= 123 then
if yy_act = 122 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 623 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 623")
end

			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 625 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 625")
end

			
end
else
if yy_act = 124 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 627 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 627")
end

					-- Syntax error: an underscore may not be
					-- the first character of an integer.
				set_syntax_error
				error_handler.report_SIFU_error (filename, current_position)
				last_token := E_INTEGER
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 634 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 634")
end

					-- Syntax error: an underscore may not be
					-- the last character of an integer.
				set_syntax_error
				error_handler.report_SILU_error (filename, current_position)
				last_token := E_INTEGER
			
end
end
end
end
else
if yy_act <= 134 then
if yy_act <= 130 then
if yy_act <= 128 then
if yy_act <= 127 then
if yy_act = 126 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 641 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 641")
end

			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 643 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 643")
end

					-- Syntax error: an underscore may not be
					-- the first character of an integer.
				set_syntax_error
				error_handler.report_SIFU_error (filename, current_position)
				last_token := E_INTEGER
			
end
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 650 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 650")
end

					-- Syntax error: an underscore may not be
					-- the last character of an integer.
				set_syntax_error
				error_handler.report_SILU_error (filename, current_position)
				last_token := E_INTEGER
			
end
else
if yy_act = 129 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 657 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 657")
end

			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 659 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 659")
end

					-- Syntax error: an underscore may not be
					-- the first character of an integer.
				set_syntax_error
				error_handler.report_SIFU_error (filename, current_position)
				last_token := E_INTEGER
			
end
end
else
if yy_act <= 132 then
if yy_act = 131 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 666 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 666")
end

					-- Syntax error: an underscore may not be
					-- the last character of an integer.
				set_syntax_error
				error_handler.report_SILU_error (filename, current_position)
				last_token := E_INTEGER
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 673 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 673")
end

			
end
else
if yy_act = 133 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 675 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 675")
end

					-- Syntax error: an underscore may not be
					-- the first character of an integer.
				set_syntax_error
				error_handler.report_SIFU_error (filename, current_position)
				last_token := E_INTEGER
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 682 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 682")
end

					-- Syntax error: an underscore may not be
					-- the last character of an integer.
				set_syntax_error
				error_handler.report_SILU_error (filename, current_position)
				last_token := E_INTEGER
			
end
end
end
else
if yy_act <= 138 then
if yy_act <= 136 then
if yy_act = 135 then
	yy_end := yy_end - 1
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 693 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 693")
end

			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 694 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 694")
end

			
end
else
if yy_act = 137 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 695 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 695")
end

			
else
	yy_end := yy_end - 1
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 697 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 697")
end

			
end
end
else
if yy_act <= 140 then
if yy_act = 139 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 698 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 698")
end

			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 699 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 699")
end

			
end
else
if yy_act = 141 then
	yy_column := yy_column + 1
--|#line 709 "et_eiffel_preparser.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_preparser.l' at line 709")
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
			create an_array.make (0, 1877)
			yy_nxt_template_1 (an_array)
			yy_nxt_template_2 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_nxt_template_1 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			    0,   22,   23,   24,   23,   25,   26,   27,   22,   28,
			   25,   25,   29,   30,   31,   32,   33,   34,   34,   35,
			   36,   25,   37,   38,   39,   40,   41,   42,   43,   44,
			   40,   40,   45,   40,   40,   46,   40,   47,   48,   49,
			   40,   50,   51,   52,   53,   54,   55,   56,   40,   40,
			   25,   57,   25,   58,   39,   40,   41,   42,   44,   40,
			   46,   47,   40,   50,   51,   52,   53,   54,   25,   25,
			   25,   60,   60,  231,   61,   61,   62,   62,   64,   65,
			   64,   64,   65,   64,   66,   80,   81,   66,   68,   69,
			   68,   68,   69,   68,   71,   72,   71,   71,   72,   71,

			   74,   75,   76,  231,   77,   74,   75,   76,  325,   77,
			   80,   81,   83,   84,   83,   83,   84,   83,   86,   87,
			   88,  326,   89,   86,   87,   88,  509,   89,   92,   93,
			   92,   93,   94,   94,   94,   94,   94,   94,   97,  105,
			   98,  235,   95,  103,  104,   95,  152,  106,  106,  106,
			  107,  107,  107,  107,  106,  106,  106,  108,  146,  109,
			  109,  110,  110,  106,  106,  127,  405,   78,   90,  115,
			  152,  235,   78,   90,  108,  128,  110,  110,  110,  110,
			  146,  139,   99,  187,  188,  155,  129,  140,  130,  117,
			  148,  160,  508,  161,  118,  405,  119,  114,  131,  115,

			  100,  120,  121,  106,  108,  149,  109,  109,  110,  110,
			  504,  129,  130,  155,  114,  248,  111,  112,  132,  118,
			  119,  122,  133,  120,  121,  123,  503,  149,  124,  135,
			   94,  125,  189,  188,  126,  134,  136,  137,  113,  215,
			  153,  150,  138,   94,  114,  248,  111,  112,  132,  122,
			  123,  151,  215,  125,  154,  142,  126,  134,  135,  177,
			  178,  137,  179,  502,  138,  143,  261,  144,  236,  150,
			  153,  145,  500,  151,  157,  157,  157,  157,  169,  170,
			  169,  172,  173,  172,  171,  142,  174,  175,  174,  232,
			  143,  144,  236,  145,  177,  184,  261,  185,  499,  176,

			  190,  191,  190,  193,  194,  498,  195,  203,  204,  205,
			  204,  232,  158,  162,  163,  164,  165,  162,  166,  162,
			  166,  166,  166,  162,  162,  162,  167,  162,  162,  162,
			  162,  162,  166,  162,  166,  162,  166,  166,  166,  166,
			  162,  166,  162,  166,  162,  162,  162,  166,  162,  166,
			  162,  162,  166,  166,  166,  166,  166,  166,  162,  162,
			  162,  162,  162,  162,  162,  162,  168,  168,  168,  168,
			  168,  168,  168,  168,  168,  168,  168,  168,  168,  168,
			  162,  162,  162,  180,  177,  181,  496,  179,  180,  183,
			  181,  305,  179,  196,  193,  197,  415,  195,  196,  199,

			  197,  233,  195,  193,  200,   97,  201,   98,  192,   94,
			   94,   94,  208,  209,  208,  305,   97,  238,   98,   95,
			  210,  211,  210,  233,   97,  415,   98,  107,  107,  107,
			  107,  219,  219,  219,  219,  187,  188,  221,  221,  238,
			  216,  189,  188,  198,  220,  223,  223,  223,  198,   99,
			  182,  160,  485,  161,  108,  182,  109,  109,  110,  110,
			   99,  227,  227,  227,  227,  217,  115,  100,   99,  108,
			  242,  110,  110,  110,  110,  222,  229,  239,  100,  230,
			  245,  240,  243,  224,  246,  160,  100,  161,  247,  259,
			  257,  262,  242,  260,  114,  241,  115,  244,  475,  114,

			  272,  270,  258,  274,  230,  271,  246,  239,  278,  114,
			  240,  259,  243,  247,  251,  260,  252,  241,  253,  244,
			  257,  262,  272,  275,  473,  274,  270,  281,  276,  254,
			  278,  287,  255,   98,  157,  157,  157,  157,  471,  277,
			  157,  157,  157,  157,  251,  252,  253,  177,  178,  281,
			  179,  254,  327,  275,  255,  264,  469,  265,  283,  284,
			  283,  277,  283,  285,  283,  266,  183,  178,  267,  179,
			  268,  269,  158,  286,  286,  286,  286,  327,  158,  203,
			  204,  169,  170,  169,  306,  264,  265,  171,  310,  266,
			  267,  466,  268,  269,  172,  173,  172,  174,  175,  174,

			  180,  177,  181,  351,  179,  180,  183,  181,  461,  179,
			  177,  184,  358,  185,  306,  176,  183,  184,  310,  185,
			  401,  176,  190,  191,  190,  193,  194,  351,  195,  199,
			  194,  311,  195,  196,  193,  197,  358,  195,  196,  199,
			  197,  389,  195,  193,  200,  401,  201,  313,  192,  199,
			  200,  429,  201,  311,  192,  205,  204,  288,  288,  288,
			  288,  460,  208,  209,  208,  389,   97,  182,   98,  210,
			  211,  210,  182,   97,  456,   98,  317,  313,  289,  429,
			  221,  221,  454,  198,  290,  290,  290,  290,  198,  291,
			  291,  299,  299,  292,  292,  292,  292,  453,  293,  293,

			  293,  293,  219,  219,  219,  219,  317,  296,  296,  312,
			   99,  297,  297,  297,  297,  294,  308,   99,  298,  223,
			  223,  223,  301,  301,  301,  314,  315,  319,  100,  222,
			  323,  312,  324,  309,  332,  100,  217,  320,  334,  304,
			  295,  227,  227,  227,  227,  343,  308,  314,  315,  319,
			  339,  321,  323,  340,  324,  309,  344,  300,  345,  347,
			  224,  349,  354,  357,  332,  402,  452,  320,  334,  359,
			  359,  359,  359,  432,  451,  343,  346,  433,  344,  114,
			  339,  347,  340,  449,  354,  283,  284,  283,  345,  448,
			  402,  349,  446,  357,  292,  292,  292,  292,  346,  360,

			  286,  286,  286,  286,  206,  288,  288,  288,  288,  361,
			  290,  290,  290,  290,  292,  292,  292,  292,  293,  293,
			  293,  293,  364,  364,  368,  368,  365,  365,  365,  365,
			  445,  363,  366,  366,  366,  366,  297,  297,  297,  297,
			  297,  297,  297,  297,  299,  299,  369,  369,  369,  301,
			  301,  301,  362,  374,  375,  377,  217,  380,  372,  372,
			  372,  372,  298,  386,  382,  444,  385,  388,  390,  391,
			  295,  373,  393,  398,  400,  374,  375,  403,  367,  380,
			  406,  409,  222,  410,  300,  377,  382,  224,  385,  388,
			  390,  391,  412,  386,  393,  398,  400,  413,  416,  403,

			  417,  418,  406,  409,  160,  438,  161,  302,  410,  159,
			  359,  359,  359,  359,  420,  420,  420,  420,  419,  413,
			  416,  430,  412,  421,  421,  417,  428,  422,  422,  422,
			  422,  418,  365,  365,  365,  365,  365,  365,  365,  365,
			  366,  366,  366,  366,  425,  425,  425,  425,  368,  368,
			  428,  430,  362,  424,  369,  369,  369,  372,  372,  372,
			  372,  426,  426,  431,  434,  427,  427,  427,  427,  435,
			  424,  436,  437,  439,  423,  440,  441,  447,  295,  495,
			  442,  443,  367,  459,  450,  431,  298,  455,  434,  457,
			  458,  435,  300,  462,  467,  295,  414,  440,  411,  436, yy_Dummy>>,
			1, 1000, 0)
		end

	yy_nxt_template_2 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			  441,  437,  442,  439,  495,  443,  450,  447,  408,  455,
			  407,  457,  458,  459,  468,  470,  467,  462,  420,  420,
			  420,  420,  422,  422,  422,  422,  422,  422,  422,  422,
			  463,  463,  463,  463,  464,  464,  468,  470,  465,  465,
			  465,  465,  425,  425,  425,  425,  427,  427,  427,  427,
			  427,  427,  427,  427,  472,  474,  362,  476,  477,  478,
			  480,  479,  483,  404,  362,  481,  399,  482,  423,  484,
			  486,  487,  488,  463,  463,  463,  463,  489,  492,  476,
			  367,  478,  477,  479,  472,  474,  483,  481,  367,  482,
			  480,  490,  486,  484,  488,  487,  465,  465,  465,  465,

			  465,  465,  465,  465,  491,  493,  494,  489,  492,  497,
			  501,  423,  505,  490,  397,  396,  395,  506,  394,  507,
			  225,  225,  392,  387,  225,  225,  225,  384,  491,  383,
			  381,  379,  378,  497,  376,  493,  494,  505,  423,  506,
			  501,  507,   59,   59,   59,   59,   59,   59,   59,   59,
			   59,   59,   59,   59,   59,   59,   59,   59,   59,   59,
			   59,   59,   59,   59,   59,   59,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   67,   67,   67,   67,   67,   67,   67,   67,   67,   67,

			   67,   67,   67,   67,   67,   67,   67,   67,   67,   67,
			   67,   67,   67,   67,   70,   70,   70,   70,   70,   70,
			   70,   70,   70,   70,   70,   70,   70,   70,   70,   70,
			   70,   70,   70,   70,   70,   70,   70,   70,   73,   73,
			   73,   73,   73,   73,   73,   73,   73,   73,   73,   73,
			   73,   73,   73,   73,   73,   73,   73,   73,   73,   73,
			   73,   73,   79,   79,   79,   79,   79,   79,   79,   79,
			   79,   79,   79,   79,   79,   79,   79,   79,   79,   79,
			   79,   79,   79,   79,   79,   79,   82,   82,   82,   82,
			   82,   82,   82,   82,   82,   82,   82,   82,   82,   82,

			   82,   82,   82,   82,   82,   82,   82,   82,   82,   82,
			   85,   85,   85,   85,   85,   85,   85,   85,   85,   85,
			   85,   85,   85,   85,   85,   85,   85,   85,   85,   85,
			   85,   85,   85,   85,   91,   91,   91,   91,   91,   91,
			   91,   91,   91,   91,   91,   91,   91,   91,   91,   91,
			   91,   91,   91,   91,   91,   91,   91,   91,   96,   96,
			  226,   96,   96,   96,   96,   96,   96,   96,   96,   96,
			   96,   96,   96,   96,   96,   96,   96,   96,   96,   96,
			   96,   96,  101,  302,  356,  355,  353,  352,  101,  101,
			  101,  101,  101,  101,  101,  101,  101,  101,  101,  101,

			  101,  101,  101,  101,  101,  101,  102,  102,  350,  102,
			  102,  102,  102,  102,  102,  102,  102,  102,  102,  102,
			  102,  102,  102,  102,  102,  102,  102,  102,  102,  102,
			  116,  116,  348,  342,  116,  116,  116,  116,  116,  116,
			  116,  116,  116,  116,  116,  159,  159,  341,  159,  159,
			  159,  159,  159,  159,  159,  159,  159,  159,  159,  159,
			  159,  159,  159,  159,  159,  159,  159,  159,  159,  176,
			  176,  176,  176,  176,  176,  176,  176,  176,  176,  176,
			  176,  176,  176,  176,  176,  176,  176,  176,  176,  176,
			  176,  176,  176,  182,  182,  182,  182,  182,  182,  182,

			  182,  182,  182,  182,  182,  182,  182,  182,  182,  182,
			  182,  182,  182,  182,  182,  182,  182,  186,  186,  186,
			  186,  186,  186,  186,  186,  186,  186,  186,  186,  186,
			  186,  186,  186,  186,  186,  186,  186,  186,  186,  186,
			  186,  192,  192,  192,  192,  192,  192,  192,  192,  192,
			  192,  192,  192,  192,  192,  192,  192,  192,  192,  192,
			  192,  192,  192,  192,  192,  198,  198,  198,  198,  198,
			  198,  198,  198,  198,  198,  198,  198,  198,  198,  198,
			  198,  198,  198,  198,  198,  198,  198,  198,  198,  202,
			  202,  202,  202,  202,  202,  202,  202,  202,  202,  202,

			  202,  202,  202,  202,  202,  202,  202,  202,  202,  202,
			  202,  202,  202,  206,  206,  206,  206,  338,  337,  336,
			  206,  206,  206,  206,  206,  335,  206,  206,  206,  206,
			  206,  213,  213,  333,  213,  213,  213,  213,  213,  213,
			  213,  213,  213,  213,  213,  213,  213,  213,  213,  213,
			  213,  213,  213,  213,  213,  105,  105,  105,  105,  105,
			  105,  105,  105,  105,  105,  105,  105,  105,  105,  105,
			  105,  105,  105,  105,  105,  105,  105,  105,  105,  218,
			  218,  218,  218,  218,  218,  218,  218,  331,  218,  218,
			  218,  218,  218,  218,  218,  218,  218,  218,  218,  218,

			  218,  218,  218,  159,  159,  159,  159,  330,  329,  328,
			  159,  159,  159,  159,  159,  322,  159,  159,  159,  159,
			  159,  206,  206,  318,  206,  206,  206,  206,  206,  206,
			  206,  206,  206,  206,  206,  206,  206,  206,  206,  206,
			  206,  206,  206,  206,  206,  303,  303,  316,  307,  303,
			  303,  303,  370,  370,  226,  302,  370,  370,  370,  371,
			  371,  371,  371,  371,  371,  371,  371,  289,  371,  371,
			  371,  371,  371,  371,  371,  371,  371,  371,  371,  371,
			  371,  371,  371,  282,  280,  279,  273,  263,  256,  250,
			  249,  237,  234,  228,  226,  212,  214,  212,  207,  105,

			  106,  156,  147,  141,  106,  106,  510,   21,  510,  510,
			  510,  510,  510,  510,  510,  510,  510,  510,  510,  510,
			  510,  510,  510,  510,  510,  510,  510,  510,  510,  510,
			  510,  510,  510,  510,  510,  510,  510,  510,  510,  510,
			  510,  510,  510,  510,  510,  510,  510,  510,  510,  510,
			  510,  510,  510,  510,  510,  510,  510,  510,  510,  510,
			  510,  510,  510,  510,  510,  510,  510,  510,  510,  510,
			  510,  510,  510,  510,  510,  510,  510,  510, yy_Dummy>>,
			1, 878, 1000)
		end

	yy_chk_template: SPECIAL [INTEGER] is
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make (0, 1877)
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
			    1,    3,    4,  119,    3,    4,    3,    4,    5,    5,
			    5,    6,    6,    6,    5,   13,   13,    6,    7,    7,
			    7,    8,    8,    8,    9,    9,    9,   10,   10,   10,

			   11,   11,   11,  119,   11,   12,   12,   12,  249,   12,
			   14,   14,   15,   15,   15,   16,   16,   16,   17,   17,
			   17,  249,   17,   18,   18,   18,  505,   18,   19,   19,
			   20,   20,   23,   23,   23,   24,   24,   24,   26,   29,
			   26,  123,   23,   28,   28,   24,   53,   31,   30,   29,
			   30,   30,   30,   30,   31,   36,   36,   33,   49,   33,
			   33,   33,   33,   37,   37,   42,  341,   11,   17,   33,
			   53,  123,   12,   18,   34,   42,   34,   34,   34,   34,
			   49,   46,   26,   79,   79,   55,   43,   46,   43,   39,
			   51,   59,  501,   59,   39,  341,   39,   33,   43,   33,

			   26,   39,   39,   31,   32,   51,   32,   32,   32,   32,
			  490,   43,   43,   55,   34,  133,   32,   32,   44,   39,
			   39,   41,   44,   39,   39,   41,  487,   51,   41,   45,
			  105,   41,   81,   81,   41,   44,   45,   45,   32,  105,
			   54,   52,   45,  215,   32,  133,   32,   32,   44,   41,
			   41,   52,  215,   41,   54,   48,   41,   44,   45,   73,
			   73,   45,   73,  486,   45,   48,  143,   48,  124,   52,
			   54,   48,  483,   52,   58,   58,   58,   58,   64,   64,
			   64,   68,   68,   68,   64,   48,   71,   71,   71,  120,
			   48,   48,  124,   48,   78,   78,  143,   78,  482,   78,

			   83,   83,   83,   85,   85,  481,   85,   91,   91,   93,
			   93,  120,   58,   62,   62,   62,   62,   62,   62,   62,
			   62,   62,   62,   62,   62,   62,   62,   62,   62,   62,
			   62,   62,   62,   62,   62,   62,   62,   62,   62,   62,
			   62,   62,   62,   62,   62,   62,   62,   62,   62,   62,
			   62,   62,   62,   62,   62,   62,   62,   62,   62,   62,
			   62,   62,   62,   62,   62,   62,   62,   62,   62,   62,
			   62,   62,   62,   62,   62,   62,   62,   62,   62,   62,
			   62,   62,   62,   74,   74,   74,  477,   74,   76,   76,
			   76,  228,   76,   86,   86,   86,  353,   86,   88,   88,

			   88,  121,   88,   90,   90,   96,   90,   96,   90,   94,
			   94,   94,   99,   99,   99,  228,   99,  126,   99,   94,
			  100,  100,  100,  121,  100,  353,  100,  107,  107,  107,
			  107,  108,  108,  108,  108,  186,  186,  111,  111,  126,
			  107,  188,  188,   86,  108,  112,  112,  112,   88,   96,
			   74,  159,  455,  159,  109,   76,  109,  109,  109,  109,
			   99,  114,  114,  114,  114,  107,  109,   96,  100,  110,
			  129,  110,  110,  110,  110,  111,  118,  127,   99,  118,
			  131,  127,  130,  112,  131,  166,  100,  166,  132,  141,
			  140,  144,  129,  142,  109,  127,  109,  130,  442,  114,

			  149,  148,  140,  151,  118,  148,  131,  127,  153,  110,
			  127,  141,  130,  132,  137,  142,  137,  127,  137,  130,
			  140,  144,  149,  152,  439,  151,  148,  156,  152,  137,
			  153,  206,  137,  206,  157,  157,  157,  157,  435,  152,
			  158,  158,  158,  158,  137,  137,  137,  176,  176,  156,
			  176,  137,  250,  152,  137,  147,  433,  147,  163,  163,
			  163,  152,  165,  165,  165,  147,  178,  178,  147,  178,
			  147,  147,  157,  167,  167,  167,  167,  250,  158,  202,
			  202,  169,  169,  169,  229,  147,  147,  169,  234,  147,
			  147,  429,  147,  147,  172,  172,  172,  174,  174,  174,

			  180,  180,  180,  273,  180,  181,  181,  181,  416,  181,
			  182,  182,  280,  182,  229,  182,  184,  184,  234,  184,
			  334,  184,  190,  190,  190,  192,  192,  273,  192,  194,
			  194,  235,  194,  196,  196,  196,  280,  196,  197,  197,
			  197,  320,  197,  198,  198,  334,  198,  237,  198,  200,
			  200,  377,  200,  235,  200,  204,  204,  207,  207,  207,
			  207,  415,  208,  208,  208,  320,  208,  180,  208,  210,
			  210,  210,  181,  210,  409,  210,  241,  237,  214,  377,
			  221,  221,  407,  196,  214,  214,  214,  214,  197,  216,
			  216,  222,  222,  216,  216,  216,  216,  406,  217,  217,

			  217,  217,  219,  219,  219,  219,  241,  220,  220,  236,
			  208,  220,  220,  220,  220,  219,  233,  210,  221,  223,
			  223,  223,  224,  224,  224,  238,  239,  244,  208,  222,
			  247,  236,  248,  233,  255,  210,  217,  245,  257,  227,
			  219,  227,  227,  227,  227,  266,  233,  238,  239,  244,
			  263,  245,  247,  263,  248,  233,  267,  223,  268,  269,
			  224,  271,  276,  279,  255,  337,  405,  245,  257,  282,
			  282,  282,  282,  382,  404,  266,  268,  382,  267,  227,
			  263,  269,  263,  402,  276,  283,  283,  283,  268,  400,
			  337,  271,  398,  279,  291,  291,  291,  291,  268,  286,

			  286,  286,  286,  286,  288,  288,  288,  288,  288,  290,
			  290,  290,  290,  290,  292,  292,  292,  292,  293,  293,
			  293,  293,  294,  294,  298,  298,  294,  294,  294,  294,
			  396,  293,  295,  295,  295,  295,  296,  296,  296,  296,
			  297,  297,  297,  297,  299,  299,  300,  300,  300,  301,
			  301,  301,  292,  305,  306,  308,  293,  311,  304,  304,
			  304,  304,  298,  317,  313,  395,  316,  319,  321,  322,
			  295,  304,  324,  330,  332,  305,  306,  339,  297,  311,
			  342,  345,  299,  346,  300,  308,  313,  301,  316,  319,
			  321,  322,  348,  317,  324,  330,  332,  349,  354,  339,

			  355,  356,  342,  345,  360,  388,  360,  370,  346,  359,
			  359,  359,  359,  359,  362,  362,  362,  362,  361,  349,
			  354,  378,  348,  363,  363,  355,  376,  363,  363,  363,
			  363,  356,  364,  364,  364,  364,  365,  365,  365,  365,
			  366,  366,  366,  366,  367,  367,  367,  367,  368,  368,
			  376,  378,  362,  366,  369,  369,  369,  372,  372,  372,
			  372,  373,  373,  381,  383,  373,  373,  373,  373,  385,
			  372,  386,  387,  389,  365,  390,  391,  399,  366,  474,
			  393,  394,  367,  413,  403,  381,  368,  408,  383,  410,
			  412,  385,  369,  418,  430,  372,  350,  390,  347,  386, yy_Dummy>>,
			1, 1000, 0)
		end

	yy_chk_template_2 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			  391,  387,  393,  389,  474,  394,  403,  399,  344,  408,
			  343,  410,  412,  413,  431,  434,  430,  418,  420,  420,
			  420,  420,  421,  421,  421,  421,  422,  422,  422,  422,
			  423,  423,  423,  423,  424,  424,  431,  434,  424,  424,
			  424,  424,  425,  425,  425,  425,  426,  426,  426,  426,
			  427,  427,  427,  427,  436,  441,  420,  444,  445,  446,
			  448,  447,  452,  340,  422,  449,  331,  450,  423,  453,
			  459,  460,  462,  463,  463,  463,  463,  466,  471,  444,
			  425,  446,  445,  447,  436,  441,  452,  449,  427,  450,
			  448,  467,  459,  453,  462,  460,  464,  464,  464,  464,

			  465,  465,  465,  465,  469,  472,  473,  466,  471,  480,
			  484,  463,  493,  467,  329,  328,  327,  497,  326,  499,
			  535,  535,  323,  318,  535,  535,  535,  315,  469,  314,
			  312,  310,  309,  480,  307,  472,  473,  493,  465,  497,
			  484,  499,  511,  511,  511,  511,  511,  511,  511,  511,
			  511,  511,  511,  511,  511,  511,  511,  511,  511,  511,
			  511,  511,  511,  511,  511,  511,  512,  512,  512,  512,
			  512,  512,  512,  512,  512,  512,  512,  512,  512,  512,
			  512,  512,  512,  512,  512,  512,  512,  512,  512,  512,
			  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,

			  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,
			  513,  513,  513,  513,  514,  514,  514,  514,  514,  514,
			  514,  514,  514,  514,  514,  514,  514,  514,  514,  514,
			  514,  514,  514,  514,  514,  514,  514,  514,  515,  515,
			  515,  515,  515,  515,  515,  515,  515,  515,  515,  515,
			  515,  515,  515,  515,  515,  515,  515,  515,  515,  515,
			  515,  515,  516,  516,  516,  516,  516,  516,  516,  516,
			  516,  516,  516,  516,  516,  516,  516,  516,  516,  516,
			  516,  516,  516,  516,  516,  516,  517,  517,  517,  517,
			  517,  517,  517,  517,  517,  517,  517,  517,  517,  517,

			  517,  517,  517,  517,  517,  517,  517,  517,  517,  517,
			  518,  518,  518,  518,  518,  518,  518,  518,  518,  518,
			  518,  518,  518,  518,  518,  518,  518,  518,  518,  518,
			  518,  518,  518,  518,  519,  519,  519,  519,  519,  519,
			  519,  519,  519,  519,  519,  519,  519,  519,  519,  519,
			  519,  519,  519,  519,  519,  519,  519,  519,  520,  520,
			  303,  520,  520,  520,  520,  520,  520,  520,  520,  520,
			  520,  520,  520,  520,  520,  520,  520,  520,  520,  520,
			  520,  520,  521,  302,  278,  277,  275,  274,  521,  521,
			  521,  521,  521,  521,  521,  521,  521,  521,  521,  521,

			  521,  521,  521,  521,  521,  521,  522,  522,  272,  522,
			  522,  522,  522,  522,  522,  522,  522,  522,  522,  522,
			  522,  522,  522,  522,  522,  522,  522,  522,  522,  522,
			  523,  523,  270,  265,  523,  523,  523,  523,  523,  523,
			  523,  523,  523,  523,  523,  524,  524,  264,  524,  524,
			  524,  524,  524,  524,  524,  524,  524,  524,  524,  524,
			  524,  524,  524,  524,  524,  524,  524,  524,  524,  525,
			  525,  525,  525,  525,  525,  525,  525,  525,  525,  525,
			  525,  525,  525,  525,  525,  525,  525,  525,  525,  525,
			  525,  525,  525,  526,  526,  526,  526,  526,  526,  526,

			  526,  526,  526,  526,  526,  526,  526,  526,  526,  526,
			  526,  526,  526,  526,  526,  526,  526,  527,  527,  527,
			  527,  527,  527,  527,  527,  527,  527,  527,  527,  527,
			  527,  527,  527,  527,  527,  527,  527,  527,  527,  527,
			  527,  528,  528,  528,  528,  528,  528,  528,  528,  528,
			  528,  528,  528,  528,  528,  528,  528,  528,  528,  528,
			  528,  528,  528,  528,  528,  529,  529,  529,  529,  529,
			  529,  529,  529,  529,  529,  529,  529,  529,  529,  529,
			  529,  529,  529,  529,  529,  529,  529,  529,  529,  530,
			  530,  530,  530,  530,  530,  530,  530,  530,  530,  530,

			  530,  530,  530,  530,  530,  530,  530,  530,  530,  530,
			  530,  530,  530,  531,  531,  531,  531,  262,  260,  259,
			  531,  531,  531,  531,  531,  258,  531,  531,  531,  531,
			  531,  532,  532,  256,  532,  532,  532,  532,  532,  532,
			  532,  532,  532,  532,  532,  532,  532,  532,  532,  532,
			  532,  532,  532,  532,  532,  533,  533,  533,  533,  533,
			  533,  533,  533,  533,  533,  533,  533,  533,  533,  533,
			  533,  533,  533,  533,  533,  533,  533,  533,  533,  534,
			  534,  534,  534,  534,  534,  534,  534,  254,  534,  534,
			  534,  534,  534,  534,  534,  534,  534,  534,  534,  534,

			  534,  534,  534,  536,  536,  536,  536,  253,  252,  251,
			  536,  536,  536,  536,  536,  246,  536,  536,  536,  536,
			  536,  537,  537,  242,  537,  537,  537,  537,  537,  537,
			  537,  537,  537,  537,  537,  537,  537,  537,  537,  537,
			  537,  537,  537,  537,  537,  538,  538,  240,  232,  538,
			  538,  538,  539,  539,  226,  225,  539,  539,  539,  540,
			  540,  540,  540,  540,  540,  540,  540,  213,  540,  540,
			  540,  540,  540,  540,  540,  540,  540,  540,  540,  540,
			  540,  540,  540,  161,  155,  154,  150,  146,  139,  136,
			  134,  125,  122,  117,  113,  104,  103,  102,   98,   95,

			   57,   56,   50,   47,   38,   35,   21,  510,  510,  510,
			  510,  510,  510,  510,  510,  510,  510,  510,  510,  510,
			  510,  510,  510,  510,  510,  510,  510,  510,  510,  510,
			  510,  510,  510,  510,  510,  510,  510,  510,  510,  510,
			  510,  510,  510,  510,  510,  510,  510,  510,  510,  510,
			  510,  510,  510,  510,  510,  510,  510,  510,  510,  510,
			  510,  510,  510,  510,  510,  510,  510,  510,  510,  510,
			  510,  510,  510,  510,  510,  510,  510,  510, yy_Dummy>>,
			1, 878, 1000)
		end

	yy_base_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,   68,   69,   76,   79,   86,   89,   92,
			   95,   98,  103,   82,  107,  110,  113,  116,  121,  125,
			  127, 1806, 1807,  130,  133, 1807,  132,    0,  135,  127,
			  135,  133,  191,  144,  161, 1784,  135,  142, 1783,  159,
			    0,  190,  137,  151,  194,  200,  149, 1765,  230,  117,
			 1774,  162,  210,  109,  216,  154, 1763, 1749,  259,  185,
			 1807, 1807,  312, 1807,  276, 1807, 1807, 1807,  279, 1807,
			 1807,  284, 1807,  256,  381, 1807,  386, 1807,  291,  180,
			 1807,  229, 1807,  298, 1807,  300,  391, 1807,  396, 1807,
			  400,  304, 1807,  306,  407, 1787,  399, 1807, 1784,  410,

			  418,    0, 1788, 1782, 1786,  227, 1807,  412,  416,  441,
			  456,  422,  430, 1741,  446, 1807,    0, 1765,  444,   46,
			  247,  358, 1764,  117,  231, 1763,  376,  452,    0,  428,
			  455,  441,  453,  191, 1752,    0, 1750,  487,    0, 1754,
			  464,  446,  451,  239,  465,    0, 1759,  528,  466,  459,
			 1758,  459,  496,  467, 1753, 1756,  486,  519,  525,  445,
			 1807, 1769, 1807,  556, 1807,  560,  479,  558, 1807,  579,
			 1807, 1807,  592, 1807,  595, 1807,  544, 1807,  563, 1807,
			  598,  603,  607, 1807,  613, 1807,  432, 1807,  438, 1807,
			  620, 1807,  622, 1807,  626, 1807,  631,  636,  640, 1807,

			  646, 1807,  576, 1807,  652, 1807,  525,  642,  660, 1807,
			  667, 1807, 1807, 1758,  669,  240,  678,  683, 1807,  687,
			  696,  665,  676,  704,  707, 1702, 1701,  726,  354,  560,
			    0,    0, 1716,  692,  562,  589,  664,  623,  684,  682,
			 1719,  652, 1695,    0,  683,  713, 1687,  688,  689,   72,
			  517, 1681, 1676, 1679, 1648,  710, 1605,  714, 1586, 1591,
			 1580,    0, 1589,  724, 1419, 1405,  721,  712,  732,  718,
			 1404,  737, 1376,  566, 1359, 1358,  722, 1353, 1352,  736,
			  575,    0,  754,  783, 1807, 1807,  785, 1807,  790, 1807,
			  795,  779,  799,  803,  811,  817,  821,  825,  809,  829,

			  831,  834, 1330, 1307,  843,  810,  812, 1104,  829, 1100,
			 1097,  815, 1102,  821, 1101, 1097,  825,  837, 1091,  826,
			  604,  827,  828, 1094,  828,    0, 1090, 1084, 1068, 1067,
			  832, 1038,  833,    0,  585,    0,    0,  730,    0,  833,
			 1031,  137,  839,  974,  976,  837,  848,  950,  866,  856,
			  957,    0,    0,  367,  854,  865,  877,    0,    0,  895,
			  898,  909,  899,  912,  917,  921,  925,  929,  933,  939,
			  854, 1807,  942,  950,    0,    0,  889,  620,  896,    0,
			    0,  922,  745,  927,    0,  928,  940,  943,  877,  946,
			  932,  939,    0,  939,  944,  837,  798,    0,  760,  951,

			  757,    0,  755,  943,  727,  734,  669,  654,  946,  646,
			  946,    0,  947,  959,    0,  629,  580,    0,  956, 1807,
			 1003, 1007, 1011, 1015, 1023, 1027, 1031, 1035,    0,  563,
			  950,  971,    0,  518,  972,  510, 1030,    0,    0,  496,
			    0, 1031,  470,    0, 1015, 1021, 1016, 1018, 1036, 1022,
			 1025,    0, 1025, 1032,    0,  424,    0,    0,    0, 1027,
			 1034,    0, 1029, 1058, 1081, 1085, 1050, 1048,    0, 1067,
			    0, 1051, 1080, 1079,  944,    0,    0,  356,    0,    0,
			 1072,  277,  260,  244, 1084,    0,  235,  198,    0,    0,
			  182,    0,    0, 1077,    0,    0,    0, 1074,    0, 1078,

			    0,  164,    0,    0,    0,   98,    0,    0,    0,    0,
			 1807, 1141, 1165, 1189, 1213, 1237, 1261, 1285, 1309, 1333,
			 1357, 1381, 1405, 1420, 1444, 1468, 1492, 1516, 1540, 1564,
			 1588, 1608, 1630, 1654, 1678, 1110, 1698, 1720, 1735, 1742,
			 1758, yy_Dummy>>)
		end

	yy_def_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,  510,    1,  511,  511,  512,  512,  513,  513,  514,
			  514,  515,  515,  516,  516,  517,  517,  518,  518,  519,
			  519,  510,  510,  510,  510,  510,  520,  521,  522,  510,
			  510,  510,  510,  510,  510,  510,  510,  510,  510,  523,
			  523,  523,  523,  523,  523,  523,  523,  523,  523,  523,
			  523,  523,  523,  523,  523,  523,  523,  510,  510,  524,
			  510,  510,  510,  510,  510,  510,  510,  510,  510,  510,
			  510,  510,  510,  525,  525,  510,  525,  510,  526,  527,
			  510,  527,  510,  510,  510,  528,  528,  510,  528,  510,
			  529,  530,  510,  530,  510,  510,  520,  510,  531,  520,

			  520,  521,  510,  532,  510,  533,  510,  510,  534,  510,
			  510,  510,  510,  535,  510,  510,  523,  523,  523,  523,
			  523,  523,  523,  523,  523,  523,  523,  523,  523,  523,
			  523,  523,  523,  523,  523,  523,  523,  523,  523,  523,
			  523,  523,  523,  523,  523,  523,  523,  523,  523,  523,
			  523,  523,  523,  523,  523,  523,  523,  510,  510,  524,
			  510,  536,  510,  510,  510,  510,  524,  510,  510,  510,
			  510,  510,  510,  510,  510,  510,  525,  510,  525,  510,
			  525,  525,  526,  510,  526,  510,  527,  510,  527,  510,
			  510,  510,  528,  510,  528,  510,  528,  528,  529,  510,

			  529,  510,  530,  510,  530,  510,  537,  510,  520,  510,
			  520,  510,  510,  510,  510,  533,  510,  510,  510,  510,
			  510,  510,  510,  510,  510,  535,  538,  510,  523,  523,
			  523,  523,  523,  523,  523,  523,  523,  523,  523,  523,
			  523,  523,  523,  523,  523,  523,  523,  523,  523,  523,
			  523,  523,  523,  523,  523,  523,  523,  523,  523,  523,
			  523,  523,  523,  523,  523,  523,  523,  523,  523,  523,
			  523,  523,  523,  523,  523,  523,  523,  523,  523,  523,
			  523,  523,  510,  510,  510,  510,  510,  510,  510,  510,
			  510,  510,  510,  510,  510,  510,  510,  510,  510,  510,

			  510,  510,  539,  538,  540,  523,  523,  523,  523,  523,
			  523,  523,  523,  523,  523,  523,  523,  523,  523,  523,
			  523,  523,  523,  523,  523,  523,  523,  523,  523,  523,
			  523,  523,  523,  523,  523,  523,  523,  523,  523,  523,
			  523,  523,  523,  523,  523,  523,  523,  523,  523,  523,
			  523,  523,  523,  523,  523,  523,  523,  523,  523,  510,
			  524,  510,  510,  510,  510,  510,  510,  510,  510,  510,
			  539,  510,  510,  510,  523,  523,  523,  523,  523,  523,
			  523,  523,  523,  523,  523,  523,  523,  523,  523,  523,
			  523,  523,  523,  523,  523,  523,  523,  523,  523,  523,

			  523,  523,  523,  523,  523,  523,  523,  523,  523,  523,
			  523,  523,  523,  523,  523,  523,  523,  523,  523,  510,
			  510,  510,  510,  510,  510,  510,  510,  510,  523,  523,
			  523,  523,  523,  523,  523,  523,  523,  523,  523,  523,
			  523,  523,  523,  523,  523,  523,  523,  523,  523,  523,
			  523,  523,  523,  523,  523,  523,  523,  523,  523,  523,
			  523,  523,  523,  510,  510,  510,  523,  523,  523,  523,
			  523,  523,  523,  523,  523,  523,  523,  523,  523,  523,
			  523,  523,  523,  523,  523,  523,  523,  523,  523,  523,
			  523,  523,  523,  523,  523,  523,  523,  523,  523,  523,

			  523,  523,  523,  523,  523,  523,  523,  523,  523,  523,
			    0,  510,  510,  510,  510,  510,  510,  510,  510,  510,
			  510,  510,  510,  510,  510,  510,  510,  510,  510,  510,
			  510,  510,  510,  510,  510,  510,  510,  510,  510,  510,
			  510, yy_Dummy>>)
		end

	yy_ec_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
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
			    8,    1,    1,    9,    7,   10,   10,   10,   11,    1,
			   12,    1,   13,    1,   14,   14,   14,   15,   10,   16,
			   17,   18,   17,   17,   17,   19,   17,   20,   17,   17,
			   21,   21,   21,   21,   21,   22,   17,   17,   17,   23,
			    1,    1,    1,   10,   10,   10,   10,   10,   10,   17,
			   17,   17,   17,   17,   17,   17,   17,   24,    1,    1,
			    1, yy_Dummy>>)
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
			  206,  207,  208,  208,  208,  209,  210,  211,  212,  213,
			  214,  216,  217,  218,  219,  220,  221,  222,  223,  225,
			  226,  227,  228,  229,  230,  231,  233,  234,  235,  237,
			  238,  239,  240,  241,  242,  243,  245,  246,  247,  248,
			  249,  250,  251,  252,  253,  254,  255,  256,  257,  257,
			  258,  259,  259,  260,  261,  262,  263,  265,  267,  269,
			  269,  270,  271,  271,  272,  272,  273,  274,  275,  276,
			  277,  278,  279,  280,  282,  283,  285,  286,  287,  288,
			  290,  290,  291,  292,  293,  294,  295,  296,  297,  298,

			  300,  301,  303,  304,  305,  306,  308,  309,  309,  310,
			  311,  312,  313,  314,  315,  317,  318,  318,  318,  319,
			  321,  322,  323,  323,  324,  324,  325,  325,  326,  327,
			  328,  330,  332,  333,  334,  335,  336,  337,  338,  339,
			  340,  341,  342,  343,  345,  346,  347,  348,  349,  350,
			  351,  352,  353,  354,  355,  356,  357,  358,  359,  360,
			  362,  363,  365,  366,  367,  368,  369,  370,  371,  372,
			  373,  374,  375,  376,  377,  378,  379,  380,  381,  382,
			  383,  384,  386,  386,  386,  387,  389,  390,  391,  391,
			  392,  393,  393,  395,  396,  396,  396,  396,  398,  399,

			  400,  401,  402,  403,  404,  404,  405,  406,  407,  408,
			  409,  410,  411,  412,  413,  414,  415,  416,  417,  419,
			  420,  421,  422,  423,  424,  425,  427,  428,  429,  430,
			  431,  432,  433,  434,  436,  437,  439,  441,  442,  444,
			  445,  446,  447,  448,  449,  450,  451,  452,  453,  454,
			  455,  456,  458,  460,  461,  462,  463,  464,  466,  468,
			  468,  470,  471,  471,  471,  471,  475,  476,  476,  477,
			  478,  479,  480,  481,  482,  484,  486,  487,  488,  489,
			  491,  493,  494,  495,  496,  498,  499,  500,  501,  502,
			  503,  504,  505,  507,  508,  509,  510,  511,  513,  514,

			  515,  516,  518,  519,  520,  521,  522,  523,  524,  525,
			  526,  527,  529,  530,  531,  533,  534,  535,  537,  538,
			  539,  540,  540,  541,  541,  541,  542,  542,  543,  545,
			  546,  547,  548,  550,  551,  552,  553,  554,  556,  558,
			  559,  561,  562,  563,  565,  566,  567,  568,  569,  570,
			  571,  572,  574,  575,  576,  578,  579,  581,  583,  585,
			  586,  587,  589,  590,  592,  592,  594,  595,  596,  598,
			  599,  601,  602,  603,  604,  605,  607,  609,  610,  612,
			  614,  615,  616,  617,  618,  619,  621,  622,  623,  625,
			  627,  628,  630,  632,  633,  635,  637,  639,  640,  642,

			  643,  645,  646,  648,  650,  652,  653,  655,  657,  659,
			  661,  661, yy_Dummy>>)
		end

	yy_acclist_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,   88,   88,   91,   91,   99,   99,  102,  102,  143,
			  141,  142,    1,  141,  142,    1,  142,    2,  141,  142,
			  104,  141,  142,   72,  141,  142,   79,  141,  142,    2,
			  141,  142,    2,  141,  142,    2,  141,  142,  122,  141,
			  142,  122,  141,  142,  122,  141,  142,    2,  141,  142,
			    2,  141,  142,    2,  141,  142,    2,  141,  142,   71,
			  141,  142,   71,  141,  142,   71,  141,  142,   71,  141,
			  142,   71,  141,  142,   71,  141,  142,   71,  141,  142,
			   71,  141,  142,   71,  141,  142,   71,  141,  142,   71,
			  141,  142,   71,  141,  142,   71,  141,  142,   71,  141,

			  142,   71,  141,  142,   71,  141,  142,   71,  141,  142,
			   71,  141,  142,  141,  142,  141,  142,  111,  142,  115,
			  142,  112,  142,  114,  142,  120,  142,  120,  142,  119,
			  142,  118,  120,  142,  117,  142,  117,  142,  116,  142,
			   83,  142,   83,  142,   82,  142,   88,  142,   88,  142,
			   87,  142,   88,  142,   85,  142,   88,  142,   91,  142,
			   90,  142,   91,  142,   94,  142,   94,  142,   93,  142,
			   99,  142,   99,  142,   98,  142,   99,  142,   96,  142,
			   99,  142,  102,  142,  101,  142,  102,  142,    1,  104,
			   80,  103,  104, -234,  104, -223,   72,   79,   79,   78,

			   79,    1,    3,  137,  140,  122,  122,  121,  125,  121,
			   71,   71,   71,   71,    8,   71,   71,   71,   71,   71,
			   71,   71,   71,   17,   71,   71,   71,   71,   71,   71,
			   71,   29,   71,   71,   71,   36,   71,   71,   71,   71,
			   71,   71,   71,   44,   71,   71,   71,   71,   71,   71,
			   71,   71,   71,   71,   71,   71,  124,  111,  112,  113,
			  113,  105,  113,  111,  113,  109,  113,  110,  113,  119,
			  118,  116,   82,   88,   87,   88,   85,   88,   88,   88,
			   86,   87,   88,   84,   85,   91,   90,   91,   89,   90,
			   93,   99,   98,   99,   96,   99,   99,   99,   97,   98,

			   99,   95,   96,  102,  101,  102,  100,  101,  104,  104,
			  -92,  104,  -81,   73,   79,   77,   79,    1,  135,  137,
			  140,  135,  132,  129,  126,  123,   71,   71,    6,   71,
			    7,   71,   71,   71,   71,   71,   71,   71,   71,   71,
			   71,   71,   71,   20,   71,   71,   71,   71,   71,   71,
			   71,   71,   71,   71,   71,   71,   71,   71,   71,   71,
			   40,   71,   71,   42,   71,   71,   71,   71,   71,   71,
			   71,   71,   71,   71,   71,   71,   71,   71,   71,   71,
			   71,   71,   71,   71,   64,   71,  106,  105,  106,  108,
			  103,   74,   76,  137,  140,  140,  136,  139,  134,  133,

			  131,  130,  128,  127,   71,   71,   71,   71,   71,   71,
			   71,   71,   71,   71,   71,   71,   71,   18,   71,   71,
			   71,   71,   71,   71,   71,   27,   71,   71,   71,   71,
			   71,   71,   71,   71,   37,   71,   71,   39,   71,   69,
			   71,   71,   43,   71,   71,   71,   71,   71,   71,   71,
			   71,   71,   71,   71,   71,   71,   56,   71,   57,   71,
			   71,   71,   71,   71,   62,   71,   63,   71,  107,  111,
			   79,  136,  137,  139,  140,  140,  132,  129,  126,  138,
			  140,  138,    4,   71,    5,   71,   71,   71,   71,   10,
			   71,   65,   71,   71,   71,   71,   15,   71,   71,   71,

			   71,   71,   71,   71,   71,   25,   71,   71,   71,   71,
			   71,   32,   71,   71,   71,   71,   38,   71,   71,   71,
			   71,   71,   71,   71,   71,   71,   71,   52,   71,   71,
			   71,   55,   71,   71,   71,   60,   71,   71,   75,  140,
			  140,  139,  139,    9,   71,   71,   71,   71,   12,   71,
			   71,   71,   71,   71,   19,   71,   21,   71,   71,   23,
			   71,   71,   71,   28,   71,   71,   71,   71,   71,   71,
			   71,   71,   46,   71,   71,   71,   48,   71,   71,   50,
			   71,   51,   71,   53,   71,   71,   71,   59,   71,   71,
			  139,  140,  139,  140,   71,   71,   11,   71,   71,   14,

			   71,   71,   71,   71,   71,   26,   71,   30,   71,   71,
			   33,   71,   34,   71,   71,   71,   71,   71,   71,   49,
			   71,   71,   71,   61,   71,   66,   71,   71,   13,   71,
			   16,   71,   71,   22,   71,   24,   71,   31,   71,   71,
			   41,   71,   71,   47,   71,   71,   54,   71,   58,   71,
			   67,   71,   71,   35,   71,   45,   71,   70,   71,   68,
			   71, yy_Dummy>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER is 1807
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER is 510
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER is 511
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

	yyNb_rules: INTEGER is 142
			-- Number of rules

	yyEnd_of_buffer: INTEGER is 143
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
