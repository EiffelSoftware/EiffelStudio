indexing
	description: "Represents a UUID"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

frozen expanded class
	UUID

inherit
	COMPARABLE
		redefine
			out
		end

create
	default_create,
	make,
	make_from_string

create {UUID_GENERATOR}
	make_from_array

feature {NONE} -- Initialization

	make (d1: like data_1; d2: like data_2; d3: like data_3; d4: like data_4; d5: like data_5;) is
			-- Initialize a UUID from data segments: `d1', `d2', `d3', `d4' and `d5'.
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

	make_from_string (a_uuid: STRING) is
			-- Initialize UUID from a string.
			-- `a_uuid' must be in the form of FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF
		require
			a_uuid_attached: a_uuid /= Void
			is_valid_uuid: is_valid_uuid (a_uuid)
		local
			l_parts: LIST [STRING]
			l_segs: ARRAY [NATURAL_8]
			l_part: STRING
			l_index: INTEGER
			l_count: INTEGER
			i: INTEGER
		do
			create l_segs.make (1, 16)

			l_parts := a_uuid.split (separator_char)
			from
				l_parts.start
			until
				l_parts.after
			loop
				l_part := l_parts.item
				check
					factor_of_2: l_part.count \\ 2 = 0
				end
				from
					i := 1
					l_count := l_part.count
				until
					i > l_count
				loop
					check
						l_index_small_enough: l_index < 16
					end
					l_index := l_index + 1
					l_segs[l_index] := (hex_to_natural_8 (l_part.item (i)).bit_shift_left (4) + hex_to_natural_8 (l_part.item (i + 1)))
					i := i + 2
				end
				l_parts.forth
			end
			make_from_array (l_segs)
		end

	make_from_array (a_segs: ARRAY [NATURAL_8]) is
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
			l_32 := a_segs[1]
			l_32 := l_32.bit_shift_left (8)
			l_32 := l_32 + a_segs[2]
			l_32 := l_32.bit_shift_left (8)
			l_32 := l_32 + a_segs[3]
			l_32 := l_32.bit_shift_left (8)
			l_32 := l_32 + a_segs[4]
			data_1 := l_32

				-- Set `data_2'
			l_16 := a_segs[5]
			l_16 := l_16.bit_shift_left (8)
			l_16 := l_16 + a_segs[6]
			data_2 := l_16

				-- Set `data_3'
			l_16 := a_segs[7]
			l_16 := l_16.bit_shift_left (8)
			l_16 := l_16 + a_segs[8]
			data_3 := l_16

				-- Set `data_4'
			l_16 := a_segs[9]
			l_16 := l_16.bit_shift_left (8)
			l_16 := l_16 + a_segs[10]
			data_4 := l_16

				-- Set `data_5'
			l_64 := a_segs[11]
			l_64 := l_64.bit_shift_left (8)
			l_64 := l_64 + a_segs[12]
			l_64 := l_64.bit_shift_left (8)
			l_64 := l_64 + a_segs[13]
			l_64 := l_64.bit_shift_left (8)
			l_64 := l_64 + a_segs[14]
			l_64 := l_64.bit_shift_left (8)
			l_64 := l_64 + a_segs[15]
			l_64 := l_64.bit_shift_left (8)
			l_64 := l_64 + a_segs[16]
			data_5 := l_64
		end

feature -- Access

	data_1: NATURAL_32
			-- First data segment

	data_2: NATURAL_16
			-- Second data segment

	data_3: NATURAL_16
			-- Third data segment

	data_4: NATURAL_16
			-- Fourth data segment

	data_5: NATURAL_64
			-- Fifth and final data segment

	is_null: BOOLEAN is
			-- Does `Current' represent a null UUID?
		do
			Result := data_1 = 0 and
				data_2 = 0 and
				data_3 = 0 and
				data_4 = 0 and
				data_5 = 0
		end

feature -- Conversion

	out: STRING is
			-- New string containing terse printable representation
		do
			create Result.make (37)
			Result.append_string (data_1.to_hex_string)
			Result.append_character (separator_char)
			Result.append_string (data_2.to_hex_string)
			Result.append_character (separator_char)
			Result.append_string (data_3.to_hex_string)
			Result.append_character (separator_char)
			Result.append_string (data_4.to_hex_string)
			Result.append_character (separator_char)
			Result.append_string (data_5.to_hex_string.substring (5, 16))
		ensure then
			result_attached: Result /= Void
			result_is_valid_uuid: is_valid_uuid (Result)
		end

feature -- Comparison

	infix "<" (other: like Current): BOOLEAN is
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

feature -- Query

	is_valid_uuid (a_uuid: STRING): BOOLEAN is
			-- Is `a_uuid' a valid uuid?
		require
			a_uuid_attached: a_uuid /= Void
		local
			i: INTEGER
		do
			if a_uuid.count /= 36 then
				Result := False
			else
				Result := True
				from
					i := 1
				until
					not Result or i > 36
				loop
					if i = 9 or i = 14 or i = 19 or i = 24 then
						Result := a_uuid.item (i) = separator_char
					else
						Result := a_uuid.item (i).is_hexa_digit
					end
					i := i + 1
				end
			end
		end

feature {NONE} -- Implementation

	hex_to_natural_8 (a_char: CHARACTER): NATURAL_8 is
			-- Converts hex character `a_char' to a NATURAL_8
		require
			a_char_is_hexa_digit: a_char.is_hexa_digit
		local
			n: INTEGER
		do
			if a_char.is_digit then
				n := a_char.code - ('0').code
			elseif a_char >= 'a' then
				n := a_char.code - (('a').code - 10)
			else
				n := a_char.code - (('A').code - 10)
			end
			Result := n.to_natural_8
		end

	separator_char: CHARACTER is '-';
			-- UUID separator character

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class UUID
