note
	description: "Helper routines"
	date: "$Date$"
	revision: "$Revision$"

class
	HELPER

feature -- Helper

	rotate_left_32 (in: NATURAL_32 count: INTEGER_32): NATURAL_32
			-- Left rotate operation
		require
			count_too_small: count >= 0
			count_too_big: count <= 32
		do
			result := (in |<< count) | (in |>> (32 - count))
		ensure
			rotate_definition: Result = (in |<< count) | (in |>> (32 - count))
		end

	rotate_right_32 (in: NATURAL_32 count: INTEGER_32): NATURAL_32
		require
			count_too_small: count >= 0
			count_too_big: count <= 32
		do
			result := (in |>> count) | (in |<< (32 - count))
		ensure
			rotate_definition: result = (in |>> count) | (in |<< (32 - count))
		end

	as_natural_32_le (source: SPECIAL [NATURAL_8] offset: INTEGER_32): NATURAL_32
			-- NATURAL_32 from bytes.
		require
			valid_start: source.valid_index (offset)
			valid_end: source.valid_index (offset + 3)
		do
			Result := source [offset].to_natural_32
			Result := Result | (source [offset + 1].to_natural_32 |<< 8)
			Result := Result | (source [offset + 2].to_natural_32 |<< 16)
			Result := Result | (source [offset + 3].to_natural_32 |<< 24)
		ensure
			byte_0: source [offset] = Result.to_natural_8
			byte_1: source [offset + 1] = (Result |>> 8).to_natural_8
			byte_2: source [offset + 2] = (Result |>> 16).to_natural_8
			byte_3: source [offset + 3] = (Result |>> 24).to_natural_8
		end

	as_natural_32_be (source: SPECIAL [NATURAL_8] offset: INTEGER_32): NATURAL_32
		require
			valid_start: source.valid_index (offset)
			valid_end: source.valid_index (offset + 3)
		do
			Result := source [offset].to_natural_32 |<< 24
			Result := Result | (source [offset + 1].to_natural_32 |<< 16)
			Result := Result | (source [offset + 2].to_natural_32 |<< 8)
			Result := Result | source [offset + 3].to_natural_32
		ensure
			byte_0: source [offset] = (Result |>> 24).to_natural_8
			byte_1: source [offset + 1] = (Result |>> 16).to_natural_8
			byte_2: source [offset + 2] = (Result |>> 8).to_natural_8
			byte_3: source [offset + 3] = Result.to_natural_8
		end

	from_natural_32_le (source: NATURAL_32 target: SPECIAL [NATURAL_8] offset: INTEGER_32)
			-- Put `source' into `target'.
		require
			valid_start: target.valid_index (offset)
			valid_end: target.valid_index (offset + 3)
		do
			target [offset] := source.to_natural_8
			target [offset + 1] := (source |>> 8).to_natural_8
			target [offset + 2] := (source |>> 16).to_natural_8
			target [offset + 3] := (source |>> 24).to_natural_8
		ensure
			byte_0: target [offset] = source.to_natural_8
			byte_1: target [offset + 1] = (source |>> 8).to_natural_8
			byte_2: target [offset + 2] = (source |>> 16).to_natural_8
			byte_3: target [offset + 3] = (source |>> 24).to_natural_8
		end

	from_natural_32_be (source: NATURAL_32 target: SPECIAL [NATURAL_8] offset: INTEGER_32)
		require
			valid_start: target.valid_index (offset)
			valid_end: target.valid_index (offset + 3)
		do
			target [offset] := (source |>> 24).to_natural_8
			target [offset + 1] := (source |>> 16).to_natural_8
			target [offset + 2] := (source |>> 8).to_natural_8
			target [offset + 3] := source.to_natural_8
		ensure
			byte_0: target [offset] = (source |>> 24).to_natural_8
			byte_1: target [offset + 1] = (source |>> 16).to_natural_8
			byte_2: target [offset + 2] = (source |>> 8).to_natural_8
			byte_3: target [offset + 3] = source.to_natural_8
		end

	ch (u: NATURAL_32 v: NATURAL_32 w: NATURAL_32): NATURAL_32
		do
			result := (u & v) | (u.bit_not & w)
		end

	maj (u: NATURAL_32 v: NATURAL_32 w: NATURAL_32): NATURAL_32
		do
			result := (u & v) | (u & w) | (v & w)
		end

	parity (u: NATURAL_32 v: NATURAL_32 w: NATURAL_32): NATURAL_32
		do
			result := u.bit_xor (v).bit_xor (w)
		end

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
