note
	description: "[
		Analyze the UnicodeData reference specification to produce helper classes that can
		be used by STRING_32 and CHARACTER_32 to perform some complex string operations.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	UNICODE_HELPER_GENERATOR

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			l_parser: ARGUMENT_PARSER
		do
			create l_parser.make
			l_parser.execute (agent do_nothing)
			if l_parser.is_successful and attached l_parser.input_file as l_file then
				density := l_parser.density
				output_path := l_parser.output_path
				is_statistic_requested := l_parser.has_statistic
				read_unicode_data (l_file)
				if unicode_data /= Void or has_error then
					process_properties (l_parser.property_template)
				else
					io.error.put_string (l_file + " has not unicode character data in it.%N")
				end
			end
		end

feature -- Access

	density: REAL_64
			-- Density of the table we generate.

	output_path: detachable STRING_32
			-- Path where files will be generated.

	unicode_data: detachable ARRAYED_LIST [UNICODE_CHARACTER_DATA] note option: stable attribute end
			-- List collecting all the unicode characters and their properties.

	unicode_table: detachable HASH_TABLE [UNICODE_CHARACTER_DATA, NATURAL_32] note option: stable attribute end
			-- Same as `unicode_data' but indexed by the Unicode code.

feature -- Status Report

	is_statistic_requested: BOOLEAN
			-- Is generation of statistics required?

	has_error: BOOLEAN
			-- Did we encounter an error of some sort?

feature -- Basic operations

	read_unicode_data (a_file: READABLE_STRING_32)
			-- Read the unicode data `a_file' and store it into `
		local
			l_input: PLAIN_TEXT_FILE_32
			l_list: like unicode_data
			l_table: like unicode_table
			l_data: detachable UNICODE_CHARACTER_DATA
			retried: BOOLEAN
		do
			if not retried then
					-- First read the Unicode data file and create a list describing all
					-- Unicode characters.
				create l_input.make (a_file)
				l_input.open_read
				create l_list.make (2000)
				create l_table.make (2000)
				from
					l_input.read_line
				until
					l_input.end_of_file
				loop
					if attached l_input.last_string as l_line and then not l_line.is_empty and then l_line.item (1) /= '#' then
						create l_data.make (l_line)
						l_list.extend (l_data)
						l_table.put (l_data, l_data.code)
					end
					l_input.read_line
				end
				l_input.close

					-- Patch the following values for charcter to lower.
				l_data := l_table.item (978)
				if l_data /= Void and then not l_data.has_lower_code then
					l_data.set_lower_code (965)
				end
				l_data := l_table.item (979)
				if l_data /= Void and then not l_data.has_lower_code then
					l_data.set_lower_code (973)
				end
				l_data := l_table.item (980)
				if l_data /= Void and then not l_data.has_lower_code then
					l_data.set_lower_code (971)
				end

					-- Patch the following values for charcter to upper/title.
				l_data := l_table.item (912)
				if l_data /= Void then
					if not l_data.has_upper_code then
						l_data.set_upper_code (938)
					end
					if not l_data.has_title_code then
						l_data.set_title_code (938)
					end
				end
				l_data := l_table.item (944)
				if l_data /= Void then
					if not l_data.has_upper_code then
						l_data.set_upper_code (939)
					end
					if not l_data.has_title_code then
						l_data.set_title_code (939)
					end
				end

				unicode_data := l_list
				unicode_table := l_table
			else
				has_error := True
			end
		rescue
			retried := True
			retry
		end

	process_properties (a_template_file: READABLE_STRING_32)
			-- Using `a_file' representing the Unicode standard for lower and upper tables,
			-- generate Eiffel code for CHARACTER_32 that will let you perform the operation
			-- `to_lower' and `to_upper'. We only perform simple case folding.
		require
			unicode_data_set: unicode_data /= Void
		local
			l_input, l_output: PLAIN_TEXT_FILE_32
			l_lowers, l_uppers, l_titles: like extract_case_ranges
			l_properties: like extract_case_ranges
			l_diffs, l_simplified_diffs: like mismatches
			l_tables, l_class, l_filter: STRING
			l_filename: FILE_NAME_32
		do
				-- We generate the various mapping. Those mappings are sparse.
			l_lowers := extract_case_ranges ("lower", unicode_data, agent {UNICODE_CHARACTER_DATA}.has_lower_code, agent {UNICODE_CHARACTER_DATA}.lower_code)
			l_uppers := extract_case_ranges ("upper", unicode_data, agent {UNICODE_CHARACTER_DATA}.has_upper_code, agent {UNICODE_CHARACTER_DATA}.upper_code)
			l_titles := extract_case_ranges ("title", unicode_data, agent {UNICODE_CHARACTER_DATA}.has_title_code, agent {UNICODE_CHARACTER_DATA}.title_code)
			l_properties := extract_case_ranges ("property", unicode_data, agent {UNICODE_CHARACTER_DATA}.has_property, agent {UNICODE_CHARACTER_DATA}.property_flags)

				-- We have noticed that the table for upper and title cases are very similar.
				-- As of Unicode 6.2.0, there were really 9 differences (i.e. 3 characters) that
				-- had a different title case than the upper case. Instead of regenerating
				-- almost the same data twice, we collect the differences that will be used
				-- to generate the title tables using the upper data and the override.
			l_diffs := mismatches (l_uppers, l_titles)

				-- Generate the code to build the tables in `l_tables'.
			create l_tables.make (5120)
			generate_case_ranges (l_tables, l_lowers, to_lower_table_name, True)
			generate_case_ranges (l_tables, l_uppers, to_upper_table_name, True)
			if l_diffs = Void then
				generate_case_ranges (l_tables, l_titles, to_title_table_name, True)
			end
			generate_case_ranges (l_tables, l_properties, property_table_name, False)


				-- Let's generate our class now.
			create l_input.make (a_template_file)
			l_input.open_read
			l_input.read_stream (l_input.count)
			l_class := l_input.last_string
			l_input.close

			if attached output_path as l_path and then not l_path.is_empty then
				create l_filename.make_from_string (l_path)
				l_filename.set_file_name (character_32_property_filename)
				create l_output.make (l_filename)
			else
				create l_output.make (character_32_property_filename)
			end
			l_output.open_write

			l_class.replace_substring_all (tables_marker, l_tables)

			create l_filter.make (10)
			generate_filter (l_filter, l_lowers, to_lower_table_name, 4, True)
			l_class.replace_substring_all (to_lower_helper_marker, l_filter)

			create l_filter.make (10)
			generate_filter (l_filter, l_uppers, to_upper_table_name, 4, True)
			l_class.replace_substring_all (to_upper_helper_marker, l_filter)

				-- Special cases for `title' case where if there are not too many
				-- differences we simply generate an override.it de
			if l_diffs /= Void then
				create l_filter.make (10)
				l_simplified_diffs := title_fix_up (l_diffs)
				if l_simplified_diffs = l_diffs then
					generate_override (l_filter, l_diffs, "l_code", 4)
				else
					generate_override (l_filter, l_simplified_diffs, "Result.natural_32_code", 4)
				end
			else
				create l_filter.make (10)
				generate_filter (l_filter, l_titles, to_title_table_name, 4, True)
			end
			l_class.replace_substring_all (to_title_helper_marker, l_filter)

			create l_filter.make (10)
			generate_filter (l_filter, l_properties, property_table_name, 3, False)
			l_class.replace_substring_all (property_helper_marker, l_filter)
			l_output.put_string (l_class)

			l_output.close
		end

	extract_case_ranges (
				a_table_name: STRING;
				a_list: ARRAYED_LIST [UNICODE_CHARACTER_DATA];
				a_filter: FUNCTION [ANY, TUPLE [UNICODE_CHARACTER_DATA], BOOLEAN];
				a_value: FUNCTION [ANY, TUPLE [UNICODE_CHARACTER_DATA], NATURAL_32];
				): ARRAYED_LIST [ARRAYED_LIST [TUPLE [key, value: NATURAL_32]]]
			-- Helper function that generate the ranges for the various conversion of
			-- a Unicode character to either lower, upper or title case. This function
			-- tries to optimize the total density so that it is no less than `density'.
		local
			l_group: ARRAYED_LIST [TUPLE [key, value: NATURAL_32]]
			l_upper_group_code: NATURAL_32
			l_total_count, l_used_space_count: NATURAL_32
			l_done: BOOLEAN
			l_offset, l_smallest_offset: NATURAL_32
			l_previous_group: detachable like extract_case_ranges
			l_formatter: FORMAT_DOUBLE
		do
				-- We compute `Result' iteratively until we reach a density that is no less
				-- than `density'. To do that, we always store the previous result as as soon
				-- as we go under `density' we should stop and return the previous result.
				-- This works because the density can only go down since our groups will contain
				-- larger gaps.
			from
					-- We store the previous group as a starting point.
				create Result.make (1)
					-- To compute the groups, we first group the characters so that they
					-- are contiguous. Then at each iteration, we calculate `l_smallest_offset'
					-- which is the smallest gaps between 2 groups of characters for the current
					-- grouping. This avoids having to increase by just one at each iteration
					-- for no benefits if the minimum gap is larger than one.
				l_offset := 1
			until
				l_done
			loop
					-- Reset `l_smallest_value' to the maximum possible value. If this
					-- does not change, it means we reached the case where only one grouping is being done.
				l_smallest_offset := {NATURAL_32}.max_value

					-- Create our first group.
				create Result.make (1)
				create l_group.make (1)
				Result.extend (l_group)

					-- Reset `l_total_count' to compute the number of characters that will be in `Result'.
					-- Note that at each iteration it is being recomputed even though the value will always
					-- be the same.
				l_total_count := 0

					-- Store the initial character code, which will be used to calculate the gap between
					-- groups.
				l_upper_group_code := 0

					-- Iterate through the unicode data.
				across a_list as l_char_data loop
						-- Only care if the Unicode character has some case transformation, but
						-- since we optimized ASCII value, we ignore them.
					if l_char_data.item.code > {CHARACTER_8}.max_ascii_value.to_natural_32 then
							-- Only care about our particular case transformation
						if a_filter.item ([l_char_data.item]) then
							if l_upper_group_code = 0 then
									-- This is the first character we encounter that have a case transformation.
									-- We initialize the upper bound of the group for the first time.
								l_upper_group_code := l_char_data.item.code
							end
								-- Increment our number of characters.
							l_total_count := l_total_count + 1
								-- If the previous code is more than `l_offset' character away, we create a group.
							if l_char_data.item.code > l_upper_group_code + l_offset then
									-- Calcualte the gap between the previous group and this new one.
								l_smallest_offset := l_smallest_offset.min (l_char_data.item.code - l_upper_group_code + 1)
									-- Create a new group where characters will be added
								create l_group.make (10)
								Result.extend (l_group)
							end
								-- Set `l_upper_group_code' with the new upper bound of the group.
							l_upper_group_code := l_char_data.item.code
								-- Extend our character and its cased transformation in our group.
							l_group.extend ([l_upper_group_code, a_value.item ([l_char_data.item])])
						end
					end
				end

					-- Let's compute our density ratio and find out if we should stop or not.
					-- First compute the space used by our tables.
				l_used_space_count := 0
				across Result as l_set loop
					if not l_set.item.is_empty then
						l_used_space_count := l_used_space_count + l_set.item.last.key - l_set.item.first.key + 1
					end
				end
					-- If our filling density ratio is less than `density' we should stop
					-- and retrieve our previously computed group if any.
				if l_used_space_count = 0 or ((l_total_count / l_used_space_count) <= density) then
					l_done := True
					if l_previous_group /= Void then
						Result := l_previous_group
					end
				else
						-- Otherwise we continue if we haven't reached the minimum number of
						-- group that one can do, i.e. one.
					l_done := l_smallest_offset = {NATURAL_32}.max_value
					if not l_done then
							-- We are not done yet, we continue with a larger offset.
						l_previous_group := Result
						l_offset := l_smallest_offset
					end
				end
			end

			if is_statistic_requested then
					-- Let's compute our density ratio and find out if we should stop or not.
					-- First compute the space used by our tables.
				l_used_space_count := 0
				across Result as l_set loop
					if not l_set.item.is_empty then
						l_used_space_count := l_used_space_count + l_set.item.last.key - l_set.item.first.key + 1
					end
				end
				create l_formatter.make (4, 3)
				io.put_string ("Table " + a_table_name + " has a density of " + l_formatter.formatted ((l_total_count / l_used_space_count)) + " in " + Result.count.out + " group(s) for " + l_total_count.out + " character(s)")
				io.put_new_line
			end
		end

	generate_case_ranges (a_output: STRING; a_ranges: like extract_case_ranges; a_table_name: STRING; is_identity: BOOLEAN)
			-- Generate all the tables for `a_table' in `a_output' using `a_table_name' as prefix to the table names.
			-- If a value is not present in the table and `is_identity' we generate the character code value, otherwise we generate `0'.
		require
			a_ranges_not_empty: across a_ranges as l_entry all not l_entry.item.is_empty end
			a_table_name_not_empty: not a_table_name.is_empty
		local
			l_data_type: STRING
			l_output, l_values: STRING
			i, l_row_count: INTEGER
			l_code: NATURAL_32
			l_count: INTEGER
		do
			i := 0
			across a_ranges as l_range loop
				i := i + 1
					-- First compute the type for the current range. To optimize
					-- we try to fit everything into NATURAL_8, NATURAL_16, we keep NATURAL_32
					-- for high unicode values.
				if across l_range.item as l_val all l_val.item.value <= {NATURAL_8}.max_value end then
					l_data_type := "NATURAL_8"
				elseif across l_range.item as l_val all l_val.item.value <= {NATURAL_16}.max_value end then
					l_data_type := "NATURAL_16"
				else
					l_data_type := "NATURAL_32"
				end

				l_output := table_template.twin
				l_output.replace_substring_all ("$table_name", a_table_name + i.out)
				l_output.replace_substring_all ("$data_type", l_data_type)
				l_output.replace_substring_all ("$low", l_range.item.first.key.to_hex_string)
				l_output.replace_substring_all ("$high", l_range.item.last.key.to_hex_string)

					-- Approximation of the size of the string needed to store all the values
				create l_values.make ((l_range.item.last.key - l_range.item.first.key).to_integer_32 * 5)
				l_code := l_range.item.first.key
				l_row_count := 0
				across l_range.item as l_char loop
					l_row_count := l_row_count + 1
					if l_char.item.key > l_code then
							-- If there is a gap, we fill it
						from
						until
							l_code >= l_char.item.key
						loop
							if is_identity then
								l_values.append_natural_32 (l_code)
							else
								l_values.append_natural_8 (0)
							end
							l_count := l_count + 1
							l_values.append_character (',')
							if l_row_count > 20 then
								l_values.append_character ('%N')
								write_tab (l_values, 4)
								l_row_count := 0
							else
								l_row_count := l_row_count + 1
								l_values.append_character (' ')
							end
							l_code := l_code + 1
						end
					end
						-- Update to new value
					l_code := l_char.item.key + 1
					l_values.append_natural_32 (l_char.item.value)
					l_count := l_count + 1
					if not l_char.is_last then
						l_values.append_character (',')
							-- Insert a new line for each
						if l_row_count > 20 then
							l_values.append_character ('%N')
							write_tab (l_values, 4)
							l_row_count := 0
						else
							l_values.append_character (' ')
						end
					end
				end

				l_output.replace_substring_all ("$values", l_values)
				a_output.append (l_output)
				a_output.append_character ('%N')
				a_output.append_character ('%N')
			end
		end

	generate_filter (a_output: STRING; a_ranges: like extract_case_ranges; a_table_name: STRING; a_nb_tab: INTEGER; is_converted_to_char: BOOLEAN)
			-- Generate a binary search tree of `ifs' statement to quickly access our values except for the
			-- first range which is checked all the time since most characters are in that range.
		require
			a_table_name_not_empty: not a_table_name.is_empty
			a_ranges_not_empty: not a_ranges.is_empty
			a_ranges_content_not_empty: across a_ranges as l_entry all not l_entry.item.is_empty end
		do
				-- We generate the if statement for the current range of values.
			write_tab (a_output, a_nb_tab)
			a_output.append ("if (")
			a_output.append_natural_32 (a_ranges.i_th (1).first.key)
			a_output.append (" <= l_code) and (l_code <= ")
			a_output.append_natural_32 (a_ranges.i_th (1).last.key)
			a_output.append (") then")
			write_tab (a_output, a_nb_tab)
			a_output.append_character ('%N')
			write_tab (a_output, a_nb_tab + 1)
			a_output.append ("Result := ")
			a_output.append (a_table_name)
			a_output.append_integer (1)
			a_output.append (".item ((l_code - ")
			a_output.append_natural_32 (a_ranges.i_th (1).first.key)
			a_output.append (").to_integer_32)")
			if is_converted_to_char then
				a_output.append (".to_character_32")
			end
			a_output.append_character ('%N')
			if a_ranges.count > 2 then
					-- No need to generate a binary search tree if there is only one range available.
				write_tab (a_output, a_nb_tab)
				a_output.append ("else")
				a_output.append_character ('%N')
				generate_binary_search_filter (a_output, a_ranges, 2, a_ranges.count, a_table_name, a_nb_tab + 1, is_converted_to_char)
			end
			write_tab (a_output, a_nb_tab)
			a_output.append ("end")
		end

	generate_binary_search_filter (a_output: STRING; a_ranges: like extract_case_ranges; a_lower_bound, a_upper_bound: INTEGER; a_table_name: STRING; a_nb_tab: INTEGER; is_converted_to_char: BOOLEAN)
			-- Generate a binary search tree of `ifs' statement to quickly access our values.
		require
			a_table_name_not_empty: not a_table_name.is_empty
			a_lower_bound_not_too_small: a_lower_bound >= 1
			a_upper_bound_not_too_big: a_upper_bound <= a_ranges.count
			valid_bounds: a_lower_bound <= a_upper_bound
			a_ranges_not_empty: across a_ranges as l_entry all not l_entry.item.is_empty end
		local
			l_middle: INTEGER
		do
			if a_lower_bound = a_upper_bound then
					-- We generate the if statement for the current range of values.
				write_tab (a_output, a_nb_tab)
				a_output.append ("if l_code >= ")
				a_output.append_natural_32 (a_ranges.i_th (a_lower_bound).first.key)
					-- Special case to generate the leaf node that check for all values greater than
					-- can be handled by the last range.
				if a_ranges.upper = a_lower_bound then
					a_output.append (" and l_code <= ")
					a_output.append_natural_32 (a_ranges.i_th (a_lower_bound).last.key)
				end
				a_output.append (" then")
				write_tab (a_output, a_nb_tab)
				a_output.append_character ('%N')
				write_tab (a_output, a_nb_tab + 1)
				a_output.append ("Result := ")
				a_output.append (a_table_name)
				a_output.append_integer (a_lower_bound)
				a_output.append (".item ((l_code - ")
				a_output.append_natural_32 (a_ranges.i_th (a_lower_bound).first.key)
				a_output.append (").to_integer_32)")
				if is_converted_to_char then
					a_output.append (".to_character_32")
				end
				a_output.append_character ('%N')
				write_tab (a_output, a_nb_tab)
				a_output.append ("end")
				a_output.append_character ('%N')
			else
				l_middle := (a_lower_bound + a_upper_bound) // 2

					-- We generate the if statement for the current range of values.
				write_tab (a_output, a_nb_tab)
				a_output.append ("if l_code <= ")
				a_output.append_natural_32 (a_ranges.i_th (l_middle).last.key)
				a_output.append (" then")
				a_output.append_character ('%N')
				generate_binary_search_filter (a_output, a_ranges, a_lower_bound, l_middle, a_table_name, a_nb_tab + 1, is_converted_to_char)
				write_tab (a_output, a_nb_tab)
				a_output.append ("else")
				a_output.append_character ('%N')
				generate_binary_search_filter (a_output, a_ranges, l_middle + 1, a_upper_bound, a_table_name, a_nb_tab + 1, is_converted_to_char)
				write_tab (a_output, a_nb_tab)
				a_output.append ("end")
				a_output.append_character ('%N')
			end
		end

	generate_override (a_output: STRING; a_diffs: attached like mismatches; a_variable: STRING; a_nb_tab: INTEGER)
			-- Generate code in `a_output' to select the new values
		do
			write_tab (a_output, a_nb_tab)
			a_output.append ("inspect ")
			a_output.append (a_variable)
			a_output.append_character ('%N')
			across a_diffs as l_entry loop
				write_tab (a_output, a_nb_tab)
				a_output.append ("when ")
				across l_entry.item as l_codes loop
					a_output.append_natural_32 (l_codes.item)
					if not l_codes.is_last then
						a_output.append (", ")
					end
				end
				a_output.append (" then%N")
				write_tab (a_output, a_nb_tab + 1)
				a_output.append ("Result := (")
				a_output.append_natural_32 (l_entry.key)
				a_output.append (").to_character_32")
				a_output.append_character ('%N')
			end
			write_tab (a_output, a_nb_tab)
			a_output.append ("else%N")
			write_tab (a_output, a_nb_tab)
			a_output.append ("end")
		end

feature {NONE} -- Helpers

	title_fix_up (a_table: attached like mismatches): attached like mismatches
			-- Special case of simplifying mismatch based on our knowledge that we are trying to compute
			-- the title case using first the upper case conversion and then patching what needs to.
		require
			unicode_table_set: unicode_table /= Void
			a_table_has_no_empty_list: across a_table as l_entry all not l_entry.item.is_empty end
		local
			l_list: ARRAYED_LIST [NATURAL_32]
			l_same: BOOLEAN
			l_upper_char: NATURAL_32
		do
			create Result.make (a_table.count)
			l_same := True
			across a_table as l_entry until not l_same loop
					-- Compute the upper character for the set
				if attached unicode_table.item (l_entry.item.first) as l_char then
					if l_char.has_upper_code then
						l_upper_char := l_char.upper_code
					else
						l_upper_char := l_char.code
					end
				end
				l_same := True
				across l_entry.item as l_codes until not l_same loop
					if attached unicode_table.item (l_codes.item) as l_char then
						if l_char.has_upper_code then
							l_same := l_char.upper_code = l_upper_char
						else
							l_same := l_char.code = l_upper_char
						end
					else
						l_same := False
					end
				end
				if l_same then
					create l_list.make (1)
					l_list.extend (l_upper_char)
					Result.extend (l_list, l_entry.key)
				else
						-- We could not optimized, keep the original set.
					Result.extend (l_entry.item, l_entry.key)
				end
			end
		end

	mismatches (l_table1, l_table2: like extract_case_ranges): detachable HASH_TABLE [ARRAYED_LIST [NATURAL_32], NATURAL_32]
			-- Compute the differences between two sets `l_table1' and `l_table2', and return the necessary information
			-- required to patch `l_table1' to get to `l_table2'.
			-- If blocks are different we return nothing as they are too many differences
		local
			l_diffs: detachable HASH_TABLE [NATURAL_32, NATURAL_32]
			l_matches: detachable ARRAYED_LIST [NATURAL_32]
		do
				-- We use `l_diffs' to collect all the mismatches between the two lists.
			create l_diffs.make (1)
			if l_table1.count = l_table2.count then
				from
					l_table1.start
					l_table2.start
				until
					l_table1.after or l_diffs = Void
				loop
					if l_table1.item.count = l_table2.item.count then
						from
							l_table1.item.start
							l_table2.item.start
						until
							l_table1.item.after
						loop
							if l_table1.item.item /~ l_table2.item.item then
									-- Note the different usage of `put' and `force'.
									-- When overriding a value in `l_table1' we use `put'
									-- as if we have previously entered a value for `l_table2'
									-- we don't want to loose it.
								l_diffs.put (l_table1.item.item.key, l_table1.item.item.key)
								l_diffs.force (l_table2.item.item.value, l_table2.item.item.key)
							end
							l_table1.item.forth
							l_table2.item.forth
						end
					else
						l_diffs := Void
					end
					l_table1.forth
					l_table2.forth
				end
			end
				-- Now that we have the list, we are going to merge the values with the same output
				-- in `l_table2' to create a list that will more compact.
			if l_diffs /= Void then
				create Result.make (l_diffs.count)
				across l_diffs as l_entry loop
					l_matches := Result.item (l_entry.item)
					if l_matches = Void then
						create l_matches.make (3)
						Result.extend (l_matches, l_entry.item)
					end
					l_matches.extend (l_entry.key)
				end
			end
		end

	write_tab (a_string: STRING; a_nb_tab: INTEGER)
			-- Write `a_nb_tab' in `a_string'.
		local
			i: INTEGER
		do
			from
				i := 1
			until
				i > a_nb_tab
			loop
				a_string.append_character ('%T')
				i := i + 1
			end
		end

	table_template: STRING_8 = "{
	$table_name: SPECIAL [$data_type]
			-- Table for Unicode characters in the range 0x$low .. 0x$high.
		local
			l_array: ARRAY [$data_type]
		once
			l_array := <<
				$values
			>>
			Result := l_array.area
		end
		}"

	character_32_property_filename: STRING_32 = "character_32_property.e"
			-- Name of output file

	to_lower_table_name: STRING = "to_lower_table_"
	to_upper_table_name: STRING = "to_upper_table_"
	to_title_table_name: STRING = "to_title_table_"
	property_table_name: STRING = "property_table_"
			-- Name of various entities we generate.

	tables_marker: STRING = "--$TABLES"
	to_lower_helper_marker: STRING = "--$TO_LOWER_HELPER"
	to_upper_helper_marker: STRING = "--$TO_UPPER_HELPER"
	to_title_helper_marker: STRING = "--$TO_TITLE_HELPER"
	property_helper_marker: STRING = "--$PROPERTY_HELPER"
			-- Various marker in the template file that will be replaced.

end
