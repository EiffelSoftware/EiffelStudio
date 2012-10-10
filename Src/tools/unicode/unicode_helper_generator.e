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
			initialize_data
			create l_parser.make
			l_parser.execute (agent do_nothing)
			if l_parser.is_successful and attached l_parser.input_file as l_file then
				density := l_parser.density
				is_statistic_requested := l_parser.has_statistic
				generate_case_tables (l_file)
			end
		end

	initialize_data
			-- Initialize various datastructure holding some Unicode information.
		do
		end

feature -- Access

	density: REAL_64
			-- Density of the table we generate.

feature -- Status Report

	is_statistic_requested: BOOLEAN
			-- Is generation of statistics required?

feature -- Basic operations

	generate_case_tables (a_file: READABLE_STRING_32)
			-- Using `a_file' representing the Unicode standard for lower and upper tables,
			-- generate Eiffel code for CHARACTER_32 that will let you perform the operation
			-- `to_lower' and `to_upper'. We only perform simple case folding.
		local
			l_input, l_output: PLAIN_TEXT_FILE_32
			l_data: UNICODE_CHARACTER_DATA
			l_list: ARRAYED_LIST [UNICODE_CHARACTER_DATA]
			l_lowers, l_uppers, l_titles: like generate_ranges
			l_different: INTEGER
		do
				-- First read the Unicode data file and create a list describing all
				-- Unicode characters.
			create l_input.make (a_file)
			l_input.open_read
			create l_list.make (2000)
			from
				l_input.read_line
			until
				l_input.end_of_file
			loop
				if attached l_input.last_string as l_line and then not l_line.is_empty and then l_line.item (1) /= '#' then
					create l_data.make (l_line)
					l_list.extend (l_data)
				end
				l_input.read_line
			end
			l_input.close

				-- We generate the various mapping. Those mappings are sparse, meaning that if a value is not present it means that
				-- this is corresponding `case' character is the same (`case' here means either lower, upper, title).
			l_lowers := generate_ranges ("lower", l_list, agent {UNICODE_CHARACTER_DATA}.has_lower_code, agent {UNICODE_CHARACTER_DATA}.lower_code)
			l_uppers := generate_ranges ("upper", l_list, agent {UNICODE_CHARACTER_DATA}.has_upper_code, agent {UNICODE_CHARACTER_DATA}.upper_code)
			l_titles := generate_ranges ("title", l_list, agent {UNICODE_CHARACTER_DATA}.has_title_code, agent {UNICODE_CHARACTER_DATA}.title_code)

				-- We have noticed that the table for upper and title cases are very similar.
				-- As of Unicode 6.2.0, there were really 9 differences (i.e. 3 characters) that
				-- had a different title case than the upper case. Instead of regenerating
				-- almost the same data twice, we collect the differences that will be used
				-- to generate the title tables using the upper data and the override.
			l_different := 1
			if l_uppers.count = l_titles.count then
				from
					l_uppers.start
					l_titles.start
				until
					l_uppers.after
				loop
					if l_uppers.item.count = l_titles.item.count then
						from
							l_uppers.item.start
							l_titles.item.start
						until
							l_uppers.item.after
						loop
							if l_uppers.item.item /~ l_titles.item.item then
								l_different := l_different + 1
							end
							l_uppers.item.forth
							l_titles.item.forth
						end
					else
						l_different := l_different + l_titles.count
					end
					l_uppers.forth
					l_titles.forth
				end
			end

				-- Let's create groups of contiguous segments and find out how many groups.
--			create l_output.make ("character_32_property.e-out")
--			l_output.open_write
--			generate_lower_table
--			l_output.close
		end

	generate_ranges (
				a_table_name: STRING;
				l_list: ARRAYED_LIST [UNICODE_CHARACTER_DATA];
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
			l_previous_group: like generate_ranges
		do
				-- We compute `Result' iteratively until we reach a density that is no less
				-- than `density'. To do that, we always store the previous result as as soon
				-- as we go under `density' we should stop and return the previous result.
				-- This works because the density can only go down since our groups will contain
				-- larger gaps.
			from
					-- We store the previous group as a starting point.
				create Result.make (1)
				l_previous_group := Result
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
				across l_list as l_char_data loop
						-- Only care if the Unicode character has some case transformation.
					if l_char_data.item.has_case then
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
					l_used_space_count := l_used_space_count + l_set.item.last.key - l_set.item.first.key + 1
				end
					-- If our filling density ratio is less than `density' we should stop
					-- and retrieve our previously computed group. Of course if we end up
					-- with no entries at all, we should stop and return `l_previous_group'
					-- too which would be empty.
				if l_used_space_count = 0 or ((l_total_count / l_used_space_count) <= density) then
					l_done := True
					Result := l_previous_group
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
					l_used_space_count := l_used_space_count + l_set.item.last.key - l_set.item.first.key + 1
				end
				io.put_string ("Table " + a_table_name + " has a density of " + (l_total_count / l_used_space_count).out + " in " + Result.count.out + " group(s)")
				io.put_new_line
			end
		end

end
