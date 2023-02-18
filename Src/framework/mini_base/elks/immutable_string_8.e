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
	IMMUTABLE_STRING_8

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
	make_empty,
	make_from_cil,
	make_from_c_byte_array

convert
	to_cil: {SYSTEM_STRING},
	make_from_cil ({SYSTEM_STRING}),
	as_string_32: {STRING_32}

feature {NONE} -- Initialization

	make (n: INTEGER)
		do
			count := 0
			internal_hash_code := 0
			create area.make_filled ('%/000/', n + 1)
		end

	make_empty
		do
			make (0)
		end

	make_from_cil (a_system_string: detachable SYSTEM_STRING)
		do
			create area.make_empty (0)
		end

	make_from_c_byte_array (a_byte_array: POINTER; a_character_count: INTEGER)
			-- Initialize from contents of `a_byte_array' for a length of `a_character_count`,
			-- given that each character is encoded in 1 single byte.
			-- ex: (char*) "abc"  for STRING_8 "abc"			
		require
			a_byte_array_exists: a_byte_array /= Default_pointer
		do
			make (a_character_count)
		end

feature -- Access

	new_cursor: INDEXABLE_ITERATION_CURSOR [CHARACTER_8]
			-- <Precursor>
		do
			create Result.make
		end

	as_string_8: STRING_8
			-- Convert `Current' as a STRING_8. If a code of `Current' is
			-- not a valid code for a STRING_8 it is replaced with the null
			-- character.
		local
			i, nb: INTEGER
		do
			if attached {STRING_8} Current as l_result then
				Result := l_result
			else
				nb := count
				create Result.make (nb)
				Result.set_count (nb)
				i := 1
				across
					Current as ic
				loop
					Result.put_character (ic, i)
					i := i + 1
				end
			end
		ensure
			as_string_8_not_void: Result /= Void
		end

	as_string_32: STRING_32
			-- Convert `Current' as a STRING_32.
		do
			create Result.make (0)
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

	internal_hash_code: INTEGER

	count: INTEGER
			-- Actual number of characters making up the string

feature -- Element change

	plus alias "+" (s: STRING_8): like Current
			-- <Precursor>
		do
			create Result.make (10)
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
			Result := as_string_8
		end

note
	copyright: "Copyright (c) 1984-2023, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
