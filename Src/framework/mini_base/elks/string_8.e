note
	description: "[
		Sequences of 8-bit characters, accessible through integer indices
		in a contiguous range.
		]"
	library: "Free implementation of ELKS library"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	STRING_8

inherit
	COMPARABLE
		redefine
			out
		end

	ITERABLE [CHARACTER_8]
		undefine
			is_equal
		redefine
			out
		end

create
	make,
	make_from_cil

convert
	to_cil: {SYSTEM_STRING},
	make_from_cil ({SYSTEM_STRING})

feature {NONE} -- Initialization

	make (n: INTEGER)
		do
			count := 0
			internal_hash_code := 0
			create area.make_filled ('%/000/', n + 1)
		end

	make_from_cil (a_system_string: detachable SYSTEM_STRING)
		do
			create area.make_empty (0)
		end

feature -- Access

	new_cursor: INDEXABLE_ITERATION_CURSOR [CHARACTER_8]
			-- <Precursor>
		do
			create Result.make
		end

feature -- Comparison

	is_less alias "<" (other: like Current): BOOLEAN
			-- Is string lexicographically lower than `other'?
		do

		end

feature -- Status report

	is_empty: BOOLEAN
		do
			Result := count = 0
		end

	valid_code (v: NATURAL_32): BOOLEAN
			-- Is `v' a valid code for a CHARACTER_32?
		do
			Result := v < {NATURAL_32} 256
		end

	area: SPECIAL [CHARACTER_8]

	set_count (n: INTEGER)
		do
			count := n
		end

	internal_hash_code: INTEGER

	count: INTEGER
			-- Actual number of characters making up the string

feature -- Element change

	plus alias "+" (s: STRING_8): like Current
			-- <Precursor>
		do
			create Result.make (10)
		end

	put_code (v: NATURAL_32; i: INTEGER)
			-- Replace character at position `i' by character of code `v'.
		do
			area.put (v.to_character_8, i - 1)
			internal_hash_code := 0
		end

feature -- Conversion

	frozen to_cil: SYSTEM_STRING
			-- Create an instance of SYSTEM_STRING using characters
			-- of Current between indices `1' and `count'.
		do
			create Result.make (' ', 0)
		end

feature -- Output

	out: STRING
			-- Printable representation
		do
			Result := Current
		end

;note
	copyright: "Copyright (c) 1984-2015, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
