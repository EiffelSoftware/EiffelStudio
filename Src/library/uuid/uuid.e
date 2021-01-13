note
	description: "UUID representation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	UUID

inherit
	HASHABLE
		redefine
			out
		end

	COMPARABLE
		undefine
			is_equal
		redefine
			out
		end

	STRING_HANDLER
		undefine
			out
		end

	DEBUG_OUTPUT
		undefine
			out
		end

create
	default_create,
	make,
	make_from_string

create {UUID_GENERATOR}
	make_from_array

feature {NONE} -- Initialization

	make (d1: like data_1; d2: like data_2; d3: like data_3; d4: like data_4; d5: like data_5)
			-- Initialize a UUID from data segments: `d1', `d2', `d3', `d4' and `d5'.
		note
			ca_ignore: "CA011", "CA011: too many arguments"
		do
			data_1 := d1
			data_2 := d2
			data_3 := d3
			data_4 := d4
			data_5 := d5
		ensure
			data_1_set: data_1 = d1
			data_2_set: data_2 = d2
			data_3_set: data_3 = d3
			data_4_set: data_4 = d4
			data_5_set: data_5 = d5
		end

	make_from_string (a_uuid: READABLE_STRING_GENERAL)
			-- Initialize UUID from a string.
			-- `a_uuid' must be in the form of "FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF".
		require
			a_uuid_attached: a_uuid /= Void
			is_valid_uuid: is_valid_uuid (a_uuid)
		local
			l_segs: ARRAY [NATURAL_8]
			i, nb, l_index: INTEGER
		do
			create l_segs.make_filled ({NATURAL_8} 0, 1, 16)

			from
				i := 1
				nb := a_uuid.count
				l_index := 1
			until
				i > nb
			loop
				if a_uuid.item (i) = separator_char then
					i := i + 1
				else
					check enough_char_to_read: i + 1 <= nb end
					l_segs [l_index] := (hex_to_natural_8 (a_uuid.item (i)) |<< 4) | hex_to_natural_8 (a_uuid.item (i + 1))
					l_index := l_index + 1
					i := i + 2
				end
			end
			make_from_array (l_segs)
		end

	make_from_array (a_segs: ARRAY [NATURAL_8])
			-- Initializes UUID from an array of `NATURAL_8's.
		require
			a_segs_attached: a_segs /= Void
			a_segs_one_based: a_segs.lower = 1
			a_segs_has_16_elements: a_segs.count = 16
		local
			l_16: NATURAL_16
			l_32: NATURAL_32
			l_64: NATURAL_64
		do
				-- Set `data_1'
			l_32 := a_segs [1]
			l_32 := l_32.bit_shift_left (8)
			l_32 := l_32 + a_segs [2]
			l_32 := l_32.bit_shift_left (8)
			l_32 := l_32 + a_segs [3]
			l_32 := l_32.bit_shift_left (8)
			l_32 := l_32 + a_segs [4]
			data_1 := l_32

				-- Set `data_2'
			l_16 := a_segs [5]
			l_16 := l_16.bit_shift_left (8)
			l_16 := l_16 + a_segs [6]
			data_2 := l_16

				-- Set `data_3'
			l_16 := a_segs [7]
			l_16 := l_16.bit_shift_left (8)
			l_16 := l_16 + a_segs [8]
			data_3 := l_16

				-- Set `data_4'
			l_16 := a_segs [9]
			l_16 := l_16.bit_shift_left (8)
			l_16 := l_16 + a_segs [10]
			data_4 := l_16

				-- Set `data_5'
			l_64 := a_segs [11]
			l_64 := l_64.bit_shift_left (8)
			l_64 := l_64 + a_segs [12]
			l_64 := l_64.bit_shift_left (8)
			l_64 := l_64 + a_segs [13]
			l_64 := l_64.bit_shift_left (8)
			l_64 := l_64 + a_segs [14]
			l_64 := l_64.bit_shift_left (8)
			l_64 := l_64 + a_segs [15]
			l_64 := l_64.bit_shift_left (8)
			l_64 := l_64 + a_segs [16]
			data_5 := l_64
		end

feature -- Access

	data_1: NATURAL_32
			-- First data segment.

	data_2: NATURAL_16
			-- Second data segment.

	data_3: NATURAL_16
			-- Third data segment.

	data_4: NATURAL_16
			-- Fourth data segment.

	data_5: NATURAL_64
			-- Fifth and final data segment.

	hash_code: INTEGER
			-- <Precursor>
		do
			Result := data_5.hash_code
		end

feature -- Status report

	is_null: BOOLEAN
			-- Does `Current' represent a null UUID?
		do
			Result := data_1 = 0 and
				data_2 = 0 and
				data_3 = 0 and
				data_4 = 0 and
				data_5 = 0
		end

	is_valid_uuid (a_uuid: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `a_uuid' a valid uuid?
		require
			a_uuid_attached: a_uuid /= Void
		local
			i: INTEGER
		do
			if a_uuid.count = 36 then
				Result := True
				from
					i := 1
				until
					not Result or i > 36
				loop
					if i = 9 or i = 14 or i = 19 or i = 24 then
						Result := a_uuid [i] = separator_char
					else
						Result := a_uuid [i].is_hexa_digit
					end
					i := i + 1
				end
			end
		ensure
			instance_free: class
		end

feature -- Comparison

	is_less alias "<" (other: like Current): BOOLEAN
			-- Is current integer less than `other'?
		do
			Result := data_1 < other.data_1
			if data_1 = other.data_1 then
				Result := data_2 < other.data_2
				if data_2 = other.data_2 then
					Result := data_3 < other.data_3
					if data_3 = other.data_3 then
						Result := data_4 < other.data_4
						if data_4 = other.data_4 then
							Result := data_5 < other.data_5
						end
					end
				end
			end
		end

feature -- Conversion

	string: STRING_32
			-- New string containing terse printable representation.
		do
			create Result.make (36)
			append_to_string_32 (separator_char, Result)
		ensure
			result_attached: Result /= Void
			result_is_valid_uuid: is_valid_uuid (Result)
		end

	out: STRING
			-- New string containing terse printable representation.
		do
			create Result.make (36)
			append_to_string (separator_char_8, Result)
		ensure then
			result_attached: Result /= Void
			result_is_valid_uuid: is_valid_uuid (Result)
		end

feature -- Custom conversion

	append_to_string (a_delimiter: CHARACTER_8; a_string: STRING_8)
			-- Append terse printable representation of Current to `a_string` using `a_delimiter` as separator.
		local
			start_index, end_index, i, j, l_offset: INTEGER
			n: NATURAL_64
		do
			l_offset := a_string.count
			a_string.grow (l_offset + 36)
			a_string.set_count (l_offset + 36)
			a_string [l_offset + 9] := a_delimiter
			a_string [l_offset + 14] := a_delimiter
			a_string [l_offset + 19] := a_delimiter
			a_string [l_offset + 24] := a_delimiter
			from j := 1 until j > 5 loop
				inspect j
				when 1 then
					n := data_1
					start_index := 1; end_index := 8
				when 2 then
					n := data_2
					start_index := 10; end_index := 13
				when 3 then
					n := data_3
					start_index := 15; end_index := 18
				when 4 then
					n := data_4
					start_index := 20; end_index := 23
				else
					n := data_5
					start_index := 25; end_index := 36
				end
				from i := end_index until i < start_index loop
					a_string [l_offset + i] := (n & Nibble_15_mask).to_hex_character
					n := n |>> 4
					i := i - 1
				end
				j := j + 1
			end
		end

	append_to_string_32 (a_delimiter: CHARACTER_32; a_string: STRING_32)
			-- Append terse printable representation of Current to `a_string` using `a_delimiter` as separator.
		local
			start_index, end_index, i, j, l_offset: INTEGER
			n: NATURAL_64
		do
			l_offset := a_string.count
			a_string.grow (l_offset + 36)
			a_string.set_count (l_offset + 36)
			a_string [l_offset + 9] := a_delimiter
			a_string [l_offset + 14] := a_delimiter
			a_string [l_offset + 19] := a_delimiter
			a_string [l_offset + 24] := a_delimiter
			from j := 1 until j > 5 loop
				inspect j
				when 1 then
					n := data_1
					start_index := 1; end_index := 8
				when 2 then
					n := data_2
					start_index := 10; end_index := 13
				when 3 then
					n := data_3
					start_index := 15; end_index := 18
				when 4 then
					n := data_4
					start_index := 20; end_index := 23
				else
					n := data_5
					start_index := 25; end_index := 36
				end
				from i := end_index until i < start_index loop
					a_string [l_offset + i] := (n & Nibble_15_mask).to_hex_character
					n := n |>> 4
					i := i - 1
				end
				j := j + 1
			end
		end

feature -- Status report

	debug_output: STRING
		do
			Result := out
		end

feature {NONE} -- Implementation

	nibble_15_mask: NATURAL_64 = 0xF

	hex_to_natural_8 (a_char: CHARACTER_32): NATURAL_8
			-- Converts hex character `a_char' to a `{NATURAL_8}`.
		require
			a_char_is_hexa_digit: a_char.is_hexa_digit
		local
			n: INTEGER
		do
			if '0' <= a_char and a_char <= '9' then
				n := a_char.code - ('0').code
			elseif a_char >= 'a' then
				n := a_char.code - (('a').code - 10)
			else
				n := a_char.code - (('A').code - 10)
			end
			Result := n.to_natural_8
		end

	separator_char: CHARACTER_32 = '-'
	separator_char_8: CHARACTER = '-'
			-- UUID separator character.

;

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
