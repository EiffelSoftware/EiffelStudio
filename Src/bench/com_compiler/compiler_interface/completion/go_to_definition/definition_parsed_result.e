indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DEFINITION_PARSED_RESULT

create
	make
	
feature {NONE} -- Initialization

	make (a_class_text: STRING; a_row, a_col: INTEGER) is
			-- create instance passing Eiffel source text `class_text'
			-- and parse start position (`col', `row')
		require
			non_void_class_text: a_class_text /= Void
			valid_class_text: not a_class_text.is_empty
			valid_row: a_row > 0
			valid_col: a_col > 0
		do
			class_text := clone (a_class_text)
			class_text.replace_substring_all ("%R", "")
			parse_row := a_row
			parse_col := a_col
			retrieve_truncated_lines
		ensure
			class_text_set: class_text.is_equal (a_class_text)
			parse_row_set: parse_row = a_row
			parse_col_set: parse_col = a_col
			lines_set: lines /= Void
			valid_line_count: lines.count = parse_row
		end

feature -- Access

	class_text: STRING
			-- original unmodified class text
			
	lines: LIST[STRING]
			-- individual lines of `class_text'
			
	parse_row: INTEGER
			-- parse start row
			
	parse_col: INTEGER
			-- parse start column

	parse_successful: BOOLEAN
			-- was parse sucessful?
			
	parsed_result_string: STRING
			-- resulting parsed class name or expression
			
	parsed_result_is_class: BOOLEAN
			-- does `parsed_result_string' contain a class name?
			
	parsed_result_containing_feature: STRING
			-- name of feature `parsed_result_string' was located in
			
	parsed_result_containing_feature_return_type: STRING
			-- return type name of feature `parsed_result_string' was located in

	parsed_result_containing_feature_row: INTEGER
			-- row number of feature `parsed_result_string' was located in

feature {DEFINITION_PARSER} -- Status setting

	set_parse_successful (success: BOOLEAN) is
			-- set `parse_successful' to `success'
		do
			parse_successful := success
		ensure
			parse_sucessful_set: parse_successful = success
		end
		
	set_parsed_result_string (a_string: STRING) is
			-- set `parsed_result_string' with `a_string'
		require
			non_void_string: a_string /= Void
			valid_string: not a_string.is_empty
		do
			parsed_result_string := clone (a_string)
			determine_is_class
		ensure
			parsed_result_string_set: parsed_result_string.is_equal (a_string)
		end
		
	set_parsed_result_is_class (a_is_class: BOOLEAN) is
			-- set `parsed_result_is_class' with `a_is_class'
		do
			parsed_result_is_class := a_is_class
		ensure
			parsed_result_is_class_set: parsed_result_is_class = a_is_class
		end
		
	set_parsed_result_containing_feature (a_feature_name: STRING) is
			-- set `parsed_result_containing_feature' with `a_feature_name'
		require
			non_void_feature_name: a_feature_name /= Void
			valid_feature_name: not a_feature_name.is_empty
		do
			parsed_result_containing_feature := clone (a_feature_name)
		ensure
			parsed_result_containing_feature_set: parsed_result_containing_feature.is_equal (a_feature_name)
		end
		
	set_parsed_result_containing_feature_return_type (a_type_name: STRING) is
			-- set `parsed_result_containing_feature_return_type' with `a_type_name'
		require
			non_void_type_name: a_type_name /= Void
			valid_type_name: not a_type_name.is_empty
		do
			parsed_result_containing_feature_return_type := clone (a_type_name)
		ensure
			parsed_result_containing_feature_return_type_set: parsed_result_containing_feature_return_type.is_equal (a_type_name)
		end	
		
	set_parsed_result_containing_feature_row (a_row: INTEGER) is
			-- sets `parsed_result_containing_feature_row' with `a_row'
		require
			valid_row: a_row > 0
		do
			parsed_result_containing_feature_row := a_row
		ensure
			parsed_result_containing_feature_row_set: parsed_result_containing_feature_row = a_row
		end		
			
feature {NONE} -- Implementation

	retrieve_truncated_lines is
			-- remove all unwanted information from `class_text' pertaining to location (`parse_col', `parse_row') in `class_text'
		require
			non_void_class_text: class_text /= Void
			valid_class_text: not class_text.is_empty
			row_big_enough: parse_row > 0
			col_big_enough: parse_col > 0
		local
			last: STRING
			done: BOOLEAN
		do
			-- Split and remove all unwanted lines
			lines := class_text.split ('%N')
			lines.go_i_th (parse_row)
			if not lines.last.is_equal (lines.item) then
				from
					lines.forth
				until
					lines.after
				loop
					lines.remove			
				end
			end	
			from
				lines.start
			until
				lines.after
			loop
				if lines.item.is_empty then
					lines.remove
				else
					lines.forth
				end	
			end
			parse_row := lines.count
			truncate_last_line
		ensure
			non_void_lines: lines /= Void
			valid_row_count: lines.count = parse_row
		end
		
	truncate_last_line is
			-- last item in `lines' needs special attention because all garbage after
			-- `parse_col' is not required
		require
			non_void_lines: lines /= Void
			valid_row: parse_row = lines.count
		local
			last_line: STRING
			done: BOOLEAN
			i: INTEGER
		do
			-- truncate last line, which is also line `parsed_row'
			last_line := lines.last
			from
				i := parse_col
			until
				i > last_line.count or done
			loop
				if not last_line.item (i).is_alpha and not last_line.item (i).is_digit and last_line.item (i) /= '_' then
					-- this is next non-valid Eiffel identifier character
					if i >= 1 then
						if last_line.count > 1 then
							last_line := last_line.substring (1, i - 1)
						else
							create last_line.make_empty
						end
					else
						create last_line.make_empty
					end
					done := True
				else
					i := i + 1
				end
			end
			
			check
				non_void_last_line: last_line /= Void
			end
			
			-- Replace last line with truncated line
			lines.finish
			lines.replace (last_line)
		end
		
	determine_is_class is
			-- is `parsed_result_string' a class and not an expression
		require
			non_void_parsed_result_string: parsed_result_string /= Void
			valid_parsed_result_string: not parsed_result_string.is_empty
		local
			i: INTEGER
		do
			if parsed_result_string.index_of ('.', 1) > 0 then
				parsed_result_is_class := False
			else
				if not parsed_result_is_class then
					parsed_result_is_class := True
					from
						i := 1
					until
						i > parsed_result_string.count or
						parsed_result_is_class = False
					loop
						if parsed_result_string.item (i).is_lower then
							parsed_result_is_class := False
						end
						i := i + 1
					end
				end
			end 
		end
		
end -- class DEFINITION_PARSED_RESULT
