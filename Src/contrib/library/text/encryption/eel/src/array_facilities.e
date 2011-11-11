note
	description: "Summary description for {ARRAY_FACILITIES}."
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "The human race divides politically into those who want people to be controlled and those who have no such desire. - Robert A. Heinlein"

deferred class
	ARRAY_FACILITIES

feature {ARRAY_FACILITIES} -- Array manipulation
	array_xor (source_1: SPECIAL [NATURAL_8] source_1_offset: INTEGER_32 source_2: SPECIAL [NATURAL_8] source_2_offset: INTEGER_32 destination: SPECIAL [NATURAL_8] destination_offset: INTEGER_32 count: INTEGER_32)
		require
			source_1.valid_index (source_1_offset)
			source_2.valid_index (source_2_offset)
			destination.valid_index (destination_offset)
			source_1.valid_index (source_1_offset + count - 1)
			source_2.valid_index (source_2_offset + count - 1)
			destination.valid_index (destination_offset + count - 1)
		local
			counter: INTEGER_32
		do
			from
				counter := count
			until
				counter = 0
			loop
				destination [destination_offset + counter - 1] := source_1 [source_1_offset + counter - 1].bit_xor (source_2 [source_2_offset + counter - 1])
				counter := counter - 1
			variant
				counter + 1
			end
		end

feature {ARRAY_FACILITIES} -- Big endian NATURAL_32
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

	as_natural_32_be (source: SPECIAL [NATURAL_8] offset: INTEGER_32): NATURAL_32
		require
			valid_start: source.valid_index (offset)
			valid_end: source.valid_index (offset + 3)
		do
			result := source [offset].to_natural_32 |<< 24
			result := result | (source [offset + 1].to_natural_32 |<< 16)
			result := result | (source [offset + 2].to_natural_32 |<< 8)
			result := result | source [offset + 3].to_natural_32
		ensure
			byte_0: source [offset] = (result |>> 24).to_natural_8
			byte_1: source [offset + 1] = (result |>> 16).to_natural_8
			byte_2: source [offset + 2] = (result |>> 8).to_natural_8
			byte_3: source [offset + 3] = result.to_natural_8
		end

	from_natural_32_le (source: NATURAL_32 target: SPECIAL [NATURAL_8] offset: INTEGER_32)
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

	as_natural_32_le (source: SPECIAL [NATURAL_8] offset: INTEGER_32): NATURAL_32
		require
			valid_start: source.valid_index (offset)
			valid_end: source.valid_index (offset + 3)
		do
			result := source [offset].to_natural_32
			result := result | (source [offset + 1].to_natural_32 |<< 8)
			result := result | (source [offset + 2].to_natural_32 |<< 16)
			result := result | (source [offset + 3].to_natural_32 |<< 24)
		ensure
			byte_0: source [offset] = result.to_natural_8
			byte_1: source [offset + 1] = (result |>> 8).to_natural_8
			byte_2: source [offset + 2] = (result |>> 16).to_natural_8
			byte_3: source [offset + 3] = (result |>> 24).to_natural_8
		end

feature {ARRAY_FACILITIES} -- Big endian NATURAL_64
	from_natural_64_be (source: NATURAL_64 target: SPECIAL [NATURAL_8] offset: INTEGER_32)
		require
			valid_start: target.valid_index (offset)
			valid_end: target.valid_index (offset + 7)
		do
			target [offset] := (source |>> 56).to_natural_8
			target [offset + 1] := (source |>> 48).to_natural_8
			target [offset + 2] := (source |>> 40).to_natural_8
			target [offset + 3] := (source |>> 32).to_natural_8
			target [offset + 4] := (source |>> 24).to_natural_8
			target [offset + 5] := (source |>> 16).to_natural_8
			target [offset + 6] := (source |>> 8).to_natural_8
			target [offset + 7] := source.to_natural_8
		ensure
			byte_0: target [offset] = (source |>> 56).to_natural_8
			byte_1: target [offset + 1] = (source |>> 48).to_natural_8
			byte_2: target [offset + 2] = (source |>> 40).to_natural_8
			byte_3: target [offset + 3] = (source |>> 32).to_natural_8
			byte_4: target [offset + 4] = (source |>> 24).to_natural_8
			byte_5: target [offset + 5] = (source |>> 16).to_natural_8
			byte_6: target [offset + 6] = (source |>> 8).to_natural_8
			byte_7: target [offset + 7] = source.to_natural_8
		end

	as_natural_64_be (source: SPECIAL [NATURAL_8] offset: INTEGER_32): NATURAL_64
		require
			valid_start: source.valid_index (offset)
			valid_end: source.valid_index (offset + 7)
		do
			result := source [offset].to_natural_32 |<< 56
			result := result | (source [offset + 1].to_natural_32 |<< 48)
			result := result | (source [offset + 2].to_natural_32 |<< 40)
			result := result | (source [offset + 3].to_natural_32 |<< 32)
			result := result | (source [offset + 4].to_natural_32 |<< 24)
			result := result | (source [offset + 5].to_natural_32 |<< 16)
			result := result | (source [offset + 6].to_natural_32 |<< 8)
			result := result | source [offset + 7].to_natural_32
		ensure
			byte_0: source [offset] = (result |>> 56).to_natural_8
			byte_1: source [offset + 1] = (result |>> 48).to_natural_8
			byte_2: source [offset + 2] = (result |>> 40).to_natural_8
			byte_3: source [offset + 3] = (result |>> 32).to_natural_8
			byte_4: source [offset + 4] = (result |>> 24).to_natural_8
			byte_5: source [offset + 5] = (result |>> 16).to_natural_8
			byte_6: source [offset + 6] = (result |>> 8).to_natural_8
			byte_7: source [offset + 7] = result.to_natural_8
		end
end
