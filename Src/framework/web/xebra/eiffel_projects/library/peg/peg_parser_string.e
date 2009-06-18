note
	description: "[
		{PEG_PARSER_STRING}.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	PEG_PARSER_STRING

inherit
	ANY
		redefine
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
			end_pivot := a_string.count
		ensure
			base_string_set: base_string = a_string
		end

	make_from_string_and_index (a_string: STRING; a_start, a_end: INTEGER)
			-- <Precursor>
		require
			a_string_attached: attached a_string
		do
			base_string := a_string
			start_pivot := a_start
			end_pivot := a_end
		end

feature {NONE} -- Access

	start_pivot, end_pivot: INTEGER
			-- The indexes defining the *actual* string. String goes from start_pivot to end_pivot-1

	base_string: STRING
			-- The base string

feature -- Debugging

	debug_information: TUPLE [line: INTEGER; row: INTEGER]
			-- Retrieves line and row
		local
			l_i, l_line, l_row: INTEGER
		do
			from
				l_i := 1
				l_line := 1
				l_row := 1
			until
				l_i > start_pivot
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
		do
			if (1 <= a_start_index) and (a_start_index <= a_end_index) and (a_end_index <= count) then
				create Result.make_from_string_and_index (
					base_string,
					start_pivot + a_start_index - 1,
					start_pivot + a_end_index)
			else
				create Result.make_from_string_and_index (base_string, start_pivot, start_pivot) -- Empty string
			end
		end

	substring_index (a_start_index: INTEGER): like Current
			-- <Precursor>
		do
			if (1 <= a_start_index) then
				create Result.make_from_string_and_index (
					base_string,
					start_pivot + a_start_index - 1,
					end_pivot+1)
			else
				create Result.make_from_string_and_index (base_string, start_pivot, start_pivot) -- Empty string
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

end
