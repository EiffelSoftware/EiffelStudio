note
	description: "[
		{PEG_PARSER_STRING}.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	PEG_PARSER_STRING

inherit
	ANY
		redefine
			out
		end

	PEG_SHARED_LONGEST_MATCH
		undefine
			out
		end

create
	make_from_string, make_from_string_and_index

feature {NONE} -- Initialization

	make_from_string (a_string: STRING)
			-- <Precursor>
		require
			a_string_attached: attached a_string
		do
			base_string := a_string
			start_pivot := 1
			end_pivot := a_string.count+1
			longest_match.reset
			line := 1
			colon := 1
		ensure
			base_string_set: base_string = a_string
		end

	make_from_string_and_index (a_string: STRING; a_start, a_end, a_line, a_colon: INTEGER)
			-- <Precursor>
		require
			a_string_attached: attached a_string
		do
			base_string := a_string
			start_pivot := a_start
			end_pivot := a_end
			line := a_line
			colon := a_colon
		ensure
			base_string_set: base_string = a_string
			start_pivot_set: start_pivot = a_start
			end_pivot_set: end_pivot = a_end
			line_set: line = a_line
			colon_set: colon = a_colon
		end

feature {NONE} -- Access

	start_pivot, end_pivot: INTEGER
			-- The indexes defining the *actual* string. String goes from start_pivot to end_pivot-1

	base_string: STRING
			-- The base string
	line, colon: INTEGER

feature -- Internal Access

	substring_internal (a_start_index, a_end_index: INTEGER): STRING
			-- Extracts the string at the *absolute* coordinates. Use substring if you're not sure
			-- what this means
		require
			a_start_index_valid: a_start_index > 0 and a_start_index <= a_end_index+1
			a_end_index_valid: a_end_index <= internal_count
		do
			Result := base_string.substring (a_start_index, a_end_index)
		ensure
			Result_attached: attached Result
		end

	current_internal_position: INTEGER
			-- Returns the absolute position at which the string currently is
		do
			Result := start_pivot
		end

	internal_count: INTEGER
			-- The internal count of the whole string
		do
			Result := base_string.count
		end

feature -- Debugging

	debug_information: TUPLE [a_line: INTEGER; a_colon: INTEGER]
			-- Retrieves line and row
		do
			Result := [line, colon]
		end

	debug_information_with_index (a_index: INTEGER): TUPLE [line: INTEGER; row: INTEGER]
				-- Retrieves line and row. THis is the slow variant which checks everything!
				-- Use debug_information if you just want to know the position in the current string
		local
			l_i, l_line, l_row: INTEGER
		do
			from
				l_i := 1
				l_line := 1
				l_row := 1
			until
				l_i > a_index
			loop
				if base_string [l_i].is_equal ('%N') then
					l_line := l_line + 1
					l_row := 1
				else
					l_row := l_row + 1
				end
				l_i := l_i + 1
			end
			Result := [l_line, l_row]
		end

feature -- Basic functionality

	item alias "[]" (a_index: INTEGER): CHARACTER
			-- <Precursor>
		do
			Result := base_string [start_pivot + a_index - 1]
		end

	substring (a_start_index, a_end_index: INTEGER): like Current
			-- <Precursor>
		local
			l_new_start, l_new_end: INTEGER
			l_new_line_colon: TUPLE [line: INTEGER; colon: INTEGER]
		do
			if (1 <= a_start_index) and (a_start_index <= a_end_index) and (a_end_index <= count) then
				longest_match.update_length (start_pivot)
				l_new_start := start_pivot + a_start_index - 1
				l_new_end := start_pivot + a_end_index
				l_new_line_colon := update_line_colon (l_new_start)
				create Result.make_from_string_and_index (
					base_string,
					l_new_start,
					l_new_end,
					l_new_line_colon.line,
					l_new_line_colon.colon)
			else
				create Result.make_from_string_and_index (base_string, start_pivot, start_pivot, line, colon) -- Empty string
			end
		end

	substring_index (a_start_index: INTEGER): like Current
			-- <Precursor>
		local
			l_new_start, l_new_end: INTEGER
			l_new_line_colon: TUPLE [line: INTEGER; colon: INTEGER]
		do
			if (1 <= a_start_index) then
				longest_match.update_length (start_pivot)
				l_new_start := start_pivot + a_start_index - 1
				l_new_end := end_pivot
				l_new_line_colon := update_line_colon (l_new_start)
				create Result.make_from_string_and_index (
					base_string,
					l_new_start,
					l_new_end,
					l_new_line_colon.line,
					l_new_line_colon.colon)
			else
				create Result.make_from_string_and_index (base_string, start_pivot, start_pivot, line, colon) -- Empty string
			end
		end

	starts_with (a_character: CHARACTER): BOOLEAN
			-- <Precursor>
		do
			Result := base_string [start_pivot].is_equal (a_character)
		end

	count: INTEGER
			-- <Precursor>
		do
			Result := end_pivot - start_pivot
		end

	is_empty: BOOLEAN
			-- <Precursor>
		do
			Result := count = 0
		end

	out: STRING
			-- <Precursor>
		do
			Result := base_string.substring (start_pivot, end_pivot-1)
		end

feature -- Helper

	update_line_colon (a_new_start: INTEGER): TUPLE [line: INTEGER; colon: INTEGER]
			-- Generates a new line/colon position according to the new start
		local
			l_i: INTEGER
		do
			Result := [line, colon]
			from
				l_i := start_pivot + 1
			until
				l_i > a_new_start
			loop
				if base_string [l_i].is_equal ('%N') then
					Result.line := Result.line + 1
					Result.colon := 1
				else
					Result.colon := Result.colon + 1
				end
				l_i := l_i + 1
			end
		end

end
