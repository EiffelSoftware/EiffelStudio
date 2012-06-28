note
	description: "[
		Sequences of immutable 8-bit characters, accessible through integer indices
		in a contiguous range.
		]"
	library: "Free implementation of ELKS library"
	copyright: "Copyright (c) 1986-2008, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class
	IMMUTABLE_STRING_8

inherit
	READABLE_STRING_8
		undefine
			is_immutable
		redefine
			copy, area_lower
		end

	IMMUTABLE_STRING_GENERAL
		rename
			same_string as same_string_general
		undefine
			is_equal, out, copy
		end

create
	make,
	make_empty,
	make_filled,
	make_from_string,
	make_from_c,
	make_from_cil

create {IMMUTABLE_STRING_8}
	make_from_area_and_bounds

convert
	make_from_string ({READABLE_STRING_8, STRING_8}),
	make_from_cil ({SYSTEM_STRING}),
	to_cil: {SYSTEM_STRING},
	as_string_32: {STRING_32},
	as_string_8: {STRING_8}

feature {NONE} -- Initialization

	make_from_area_and_bounds (a: like area; low, n: like count)
			-- Initialize current with area `a' with lower bounds `low' and count `n'.
		require
			a_not_void: a /= Void
			a_valid_count: (a.count - low) >= count + 1
			low_non_negative: low >= 0
			n_non_negative: n >= 0
		do
			area := a
			area_lower := low
			count := n
		ensure
			area_set: area = a
			area_lower_set: area_lower = low
			count_set: count = n
		end

	make_from_cil (a_system_string: SYSTEM_STRING)
			-- <Precursor>
		local
			l_count: INTEGER
		do
			if a_system_string /= Void then
				l_count := a_system_string.length
			end
			make (l_count)
			if l_count > 0 then
				dotnet_convertor.read_system_string_into_area_8 (a_system_string, area)
			end
		end

feature {IMMUTABLE_STRING_8} -- Duplication

	copy (other: like Current)
			-- <Precursor>
		do
				-- Because it is immutable we can simply share the `area' from `other'.
			standard_copy (other)
		ensure then
			new_result_count: count = other.count
			-- same_characters: For every `i' in 1..`count', `item' (`i') = `other'.`item' (`i')
		end

feature -- Elment change

	plus alias "+" (s: READABLE_STRING_8): like Current
			-- <Precursor>
		local
			a: like area
		do
			create a.make (count + s.count + 1)
			a.copy_data (area, area_lower, 0, count)
			a.copy_data (s.area, s.area_lower, count, s.count)
			create Result.make_from_area_and_bounds (a, 0, count + s.count)
		end

	mirrored: like Current
			-- <Precursor>
		local
			a: like area
		do
			create a.make (count + 1)
			a.copy_data (area, area_lower, 0, count)
			mirror_area (a, 0, count - 1)
			create Result.make_from_area_and_bounds (a, 0, count)
		end

	as_lower: like Current
			-- <Precursor>
		local
			a: like area
		do
			create a.make (count + 1)
			a.copy_data (area, area_lower, 0, count)
			to_lower_area (a, 0, count - 1)
			create Result.make_from_area_and_bounds (a, 0, count)
		end

	as_upper: like Current
			-- <Precursor>
		local
			a: like area
		do
			create a.make (count + 1)
			a.copy_data (area, area_lower, 0, count)
			to_upper_area (a, 0, count - 1)
			create Result.make_from_area_and_bounds (a, 0, count)
		end

	substring (start_index, end_index: INTEGER_32): like Current
			-- <Precursor>
		local
			a: like area
		do
			if (1 <= start_index) and (start_index <= end_index) and (end_index <= count) then
				create a.make (end_index - start_index + 2)
				a.copy_data (area, area_lower + start_index - 1, 0, end_index - start_index + 1)
				create Result.make_from_area_and_bounds (a, 0, end_index - start_index + 1)
			else
				Result := empty_string
			end
		end

	shared_substring (start_index, end_index: INTEGER_32): like Current
			-- <Precursor>
		do
			if (1 <= start_index) and (start_index <= end_index) and (end_index <= count) then
				create Result.make_from_area_and_bounds (area, area_lower + start_index - 1, end_index - start_index + 1)
			else
				Result := empty_string
			end
		end

	is_empty: BOOLEAN
			-- Is structure empty?
		do
			Result := count = 0
		end

	linear_representation: LINEAR [CHARACTER_8]
			-- Representation as a linear structure
		local
			temp: ARRAYED_LIST [CHARACTER_8]
			i: INTEGER
		do
			create temp.make (capacity)
			from
				i := 1
			until
				i > count
			loop
				temp.extend (item (i))
				i := i + 1
			end
			Result := temp
		end

feature {NONE} -- Implementation

	new_string (n: INTEGER_32): IMMUTABLE_STRING_8
			-- <Precursor>
		do
			create Result.make (n)
		end

	empty_string: IMMUTABLE_STRING_8
			-- Shared empty immutable string
		once
			create Result.make (0)
		ensure
			empty_string_not_void: Result /= Void
			empty_string_empty: Result.is_empty
		end

feature {READABLE_STRING_8, READABLE_STRING_32} -- Implementation

	area_lower: INTEGER
			-- Index where current string starts in `area'

end
