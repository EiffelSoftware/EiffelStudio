note
	description: "Tagging class for various size/speed tradeoffs of AES"
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "Talk is cheap - except when Congress does it. - Cullen Hightower"

deferred class
	AES_ENGINE

inherit
	AES_COMMON
	BYTE_FACILITIES

feature
	make_tables
		do
			two_table := multiply_table (0x2)
			three_table := multiply_table (0x3)
			nine_table := multiply_table (0x9)
			eleven_table := multiply_table (0xb)
			thirteen_table := multiply_table (0xd)
			fourteen_table := multiply_table (0xe)
		end

	block_size: INTEGER = 16

feature
	mcol (x: NATURAL_32): NATURAL_32
		local
			f2: NATURAL_32
		do
			f2 := FFmulX (x)
			result := f2.bit_xor (rotate_right_32 (x.bit_xor (f2), 8)).bit_xor (rotate_right_32 (x, 16)).bit_xor (rotate_right_32 (x, 24))
		end

	-- State matrix columns
	column_0: NATURAL_32
	column_1: NATURAL_32
	column_2: NATURAL_32
	column_3: NATURAL_32

feature --Prepare input blocks for processing and return
	unpack (bytes: SPECIAL [NATURAL_8] offset: INTEGER)
		require
			bytes.valid_index (offset)
			bytes.valid_index (offset + 15)
		local
			index: INTEGER
		do
			index := bytes.lower
			column_0 :=  as_natural_32_be (bytes, offset + index)
			column_1 :=  as_natural_32_be (bytes, offset + index + 4)
			column_2 :=  as_natural_32_be (bytes, offset + index + 8)
			column_3 :=  as_natural_32_be (bytes, offset + index + 12)
		ensure
			bytes_match_blocks (bytes)
		end

	pack (bytes: SPECIAL [NATURAL_8] offset: INTEGER)
		require
			bytes.valid_index (offset)
			bytes.valid_index (offset + 15)
		local
			index: INTEGER
		do
			index := bytes.lower
			from_natural_32_be (column_0, bytes, offset + index)
			from_natural_32_be (column_1, bytes, offset + index + 4)
			from_natural_32_be (column_2, bytes, offset + index + 8)
			from_natural_32_be (column_3, bytes, offset + index + 12)
		ensure
			bytes_match_blocks (bytes)
		end

	bytes_match_blocks (bytes: SPECIAL [NATURAL_8]): BOOLEAN
		do
			result := true
			result := result and bytes [0] = (column_0 |>> 24 & 0xff).to_natural_8
			result := result and bytes [1] = (column_0 |>> 16 & 0xff).to_natural_8
			result := result and bytes [2] = (column_0 |>> 8 & 0xff).to_natural_8
			result := result and bytes [3] = (column_0 & 0xff).to_natural_8
			result := result and bytes [4] = (column_1 |>> 24 & 0xff).to_natural_8
			result := result and bytes [5] = (column_1 |>> 16 & 0xff).to_natural_8
			result := result and bytes [6] = (column_1 |>> 8 & 0xff).to_natural_8
			result := result and bytes [7] = (column_1 & 0xff).to_natural_8
			result := result and bytes [8] = (column_2 |>> 24 & 0xff).to_natural_8
			result := result and bytes [9] = (column_2 |>> 16 & 0xff).to_natural_8
			result := result and bytes [10] = (column_2 |>> 8 & 0xff).to_natural_8
			result := result and bytes [11] = (column_2 & 0xff).to_natural_8
			result := result and bytes [12] = (column_3 |>> 24 & 0xff).to_natural_8
			result := result and bytes [13] = (column_3 |>> 16 & 0xff).to_natural_8
			result := result and bytes [14] = (column_3 |>> 8 & 0xff).to_natural_8
			result := result and bytes [15] = (column_3 & 0xff).to_natural_8
		ensure
			bytes [0] = (column_0 & 0xff).to_natural_8
			bytes [1] = (column_0 |>> 8 & 0xff).to_natural_8
			bytes [2] = (column_0 |>> 16 & 0xff).to_natural_8
			bytes [3] = (column_0 |>> 24 & 0xff).to_natural_8
			bytes [4] = (column_1 & 0xff).to_natural_8
			bytes [5] = (column_1 |>> 8 & 0xff).to_natural_8
			bytes [6] = (column_1 |>> 16 & 0xff).to_natural_8
			bytes [7] = (column_1 |>> 24 & 0xff).to_natural_8
			bytes [8] = (column_2 & 0xff).to_natural_8
			bytes [9] = (column_2 |>> 8 & 0xff).to_natural_8
			bytes [10] = (column_2 |>> 16 & 0xff).to_natural_8
			bytes [11] = (column_2 |>> 24 & 0xff).to_natural_8
			bytes [12] = (column_3 & 0xff).to_natural_8
			bytes [13] = (column_3 |>> 8 & 0xff).to_natural_8
			bytes [14] = (column_3 |>> 16 & 0xff).to_natural_8
			bytes [15] = (column_3 |>> 24 & 0xff).to_natural_8
		end

feature
	encrypt_work (max_index: INTEGER)
		local
			index: INTEGER
		do
			add_round_key (index)
			from
				index := 4
			until
				index >= max_index - 4
			loop
				sub_columns
				shift_rows
				mix_columns
				add_round_key (index)
				index := index + 4
			variant
				max_index - index + 2
			end
			sub_columns
			shift_rows
			add_round_key (index)
		end

	decrypt_work (max_index: INTEGER)
		local
			index: INTEGER
		do
			index := max_index - 3
			add_round_key (index)
			from
				index := index - 4
			until
				index = 0
			loop
				inv_shift_rows
				inv_sub_columns
				add_round_key (index)
				inv_mix_columns
				index := index - 4
			variant
				index + 1
			end
			inv_shift_rows
			inv_sub_columns
			add_round_key (index)
		end

	inv_sub_columns
		do
			column_0 := inv_sub_bytes (column_0)
			column_1 := inv_sub_bytes (column_1)
			column_2 := inv_sub_bytes (column_2)
			column_3 := inv_sub_bytes (column_3)
		end

	inv_mix_columns
		do
			column_0 := inv_mix_column (column_0)
			column_1 := inv_mix_column (column_1)
			column_2 := inv_mix_column (column_2)
			column_3 := inv_mix_column (column_3)
		end

	mix_columns
		do
			column_0 := mix_column (column_0)
			column_1 := mix_column (column_1)
			column_2 := mix_column (column_2)
			column_3 := mix_column (column_3)
		end

	inv_mix_column (in: NATURAL_32): NATURAL_32
		do
			result := inv_mix_0 (in)
			result := result | inv_mix_1 (in)
			result := result | inv_mix_2 (in)
			result := result | inv_mix_3 (in)
		end

	inv_mix_0 (in: NATURAL_32): NATURAL_32
		local
			part_0: NATURAL_32
			part_1: NATURAL_32
			part_2: NATURAL_32
			part_3: NATURAL_32
		do
			part_0 := multiply_and_reduce ((in |>> 24 & 0xff).to_natural_8, 0xe)
			part_1 := multiply_and_reduce ((in |>> 16 & 0xff).to_natural_8, 0xb)
			part_2 := multiply_and_reduce ((in |>> 8 & 0xff).to_natural_8, 0xd)
			part_3 := multiply_and_reduce ((in & 0xff).to_natural_8, 0x9)
			result := part_0.bit_xor (part_1).bit_xor (part_2).bit_xor (part_3) |<< 24
		end

	inv_mix_1 (in: NATURAL_32): NATURAL_32
		local
			part_0: NATURAL_32
			part_1: NATURAL_32
			part_2: NATURAL_32
			part_3: NATURAL_32
		do
			part_0 := multiply_and_reduce ((in |>> 24 & 0xff).to_natural_8, 0x9)
			part_1 := multiply_and_reduce ((in |>> 16 & 0xff).to_natural_8, 0xe)
			part_2 := multiply_and_reduce ((in |>> 8 & 0xff).to_natural_8, 0xb)
			part_3 := multiply_and_reduce ((in & 0xff).to_natural_8, 0xd)
			result := part_0.bit_xor (part_1).bit_xor (part_2).bit_xor (part_3) |<< 16
		end

	inv_mix_2 (in: NATURAL_32): NATURAL_32
		local
			part_0: NATURAL_32
			part_1: NATURAL_32
			part_2: NATURAL_32
			part_3: NATURAL_32
		do
			part_0 := multiply_and_reduce ((in |>> 24 & 0xff).to_natural_8, 0xd)
			part_1 := multiply_and_reduce ((in |>> 16 & 0xff).to_natural_8, 0x9)
			part_2 := multiply_and_reduce ((in |>> 8 & 0xff).to_natural_8, 0xe)
			part_3 := multiply_and_reduce ((in & 0xff).to_natural_8, 0xb)
			result := part_0.bit_xor (part_1).bit_xor (part_2).bit_xor (part_3) |<< 8
		end

	inv_mix_3 (in: NATURAL_32): NATURAL_32
		local
			part_0: NATURAL_32
			part_1: NATURAL_32
			part_2: NATURAL_32
			part_3: NATURAL_32
		do
			part_0 := multiply_and_reduce ((in |>> 24 & 0xff).to_natural_8, 0xb)
			part_1 := multiply_and_reduce ((in |>> 16 & 0xff).to_natural_8, 0xd)
			part_2 := multiply_and_reduce ((in |>> 8 & 0xff).to_natural_8, 0x9)
			part_3 := multiply_and_reduce ((in & 0xff).to_natural_8, 0xe)
			result := part_0.bit_xor (part_1).bit_xor (part_2).bit_xor (part_3)
		end

	mix_column (in: NATURAL_32): NATURAL_32
		do
			result := mix_0 (in)
			result := result | mix_1 (in)
			result := result | mix_2 (in)
			result := result | mix_3 (in)
		end

	mix_0 (in: NATURAL_32): NATURAL_32
		local
			part_0: NATURAL_32
			part_1: NATURAL_32
			part_2: NATURAL_32
			part_3: NATURAL_32
		do
			part_0 := multiply_and_reduce ((in |>> 24 & 0xff).to_natural_8, 0x2)
			part_1 := multiply_and_reduce ((in |>> 16 & 0xff).to_natural_8, 0x3)
			part_2 := in |>> 8 & 0xff
			part_3 := in & 0xff
			result := part_0.bit_xor (part_1).bit_xor (part_2).bit_xor (part_3) |<< 24
		end

	mix_1 (in: NATURAL_32): NATURAL_32
		local
			part_0: NATURAL_32
			part_1: NATURAL_32
			part_2: NATURAL_32
			part_3: NATURAL_32
		do
			part_0 := (in |>> 24 & 0xff)
			part_1 := multiply_and_reduce ((in |>> 16 & 0xff).to_natural_8, 0x2)
			part_2 := multiply_and_reduce ((in |>> 8 & 0xff).to_natural_8, 0x3)
			part_3 := in & 0xff
			result := part_0.bit_xor (part_1).bit_xor (part_2).bit_xor (part_3) |<< 16
		end

	mix_2 (in: NATURAL_32): NATURAL_32
		local
			part_0: NATURAL_32
			part_1: NATURAL_32
			part_2: NATURAL_32
			part_3: NATURAL_32
		do
			part_0 := in |>> 24 & 0xff
			part_1 := in |>> 16 & 0xff
			part_2 := multiply_and_reduce ((in |>> 8 & 0xff).to_natural_8, 0x2)
			part_3 := multiply_and_reduce ((in & 0xff).to_natural_8, 0x3)
			result := part_0.bit_xor (part_1).bit_xor (part_2).bit_xor (part_3) |<< 8
		end

	mix_3 (in: NATURAL_32): NATURAL_32
		local
			part_0: NATURAL_32
			part_1: NATURAL_32
			part_2: NATURAL_32
			part_3: NATURAL_32
		do
			part_0 := multiply_and_reduce ((in |>> 24 & 0xff).to_natural_8, 0x3)
			part_1 := in |>> 16 & 0xff
			part_2 := in |>> 8 & 0xff
			part_3 := multiply_and_reduce ((in & 0xff).to_natural_8, 0x2)
			result := part_0.bit_xor (part_1).bit_xor (part_2).bit_xor (part_3)
		end

	sub_columns
		do
			column_0 := sub_bytes (column_0)
			column_1 := sub_bytes (column_1)
			column_2 := sub_bytes (column_2)
			column_3 := sub_bytes (column_3)
		end

	inv_shift_rows
		local
			column_0_new: NATURAL_32
			column_1_new: NATURAL_32
			column_2_new: NATURAL_32
			column_3_new: NATURAL_32
		do
			column_0_new := column_0 & 0xff000000
			column_0_new := column_0_new | (column_3 & 0x00ff0000)
			column_0_new := column_0_new | (column_2 & 0x0000ff00)
			column_0_new := column_0_new | (column_1 & 0x000000ff)
			column_1_new := column_1 & 0xff000000
			column_1_new := column_1_new | (column_0 & 0x00ff0000)
			column_1_new := column_1_new | (column_3 & 0x0000ff00)
			column_1_new := column_1_new | (column_2 & 0x000000ff)
			column_2_new := column_2 & 0xff000000
			column_2_new := column_2_new | (column_1 & 0x00ff0000)
			column_2_new := column_2_new | (column_0 & 0x0000ff00)
			column_2_new := column_2_new | (column_3 & 0x000000ff)
			column_3_new := column_3 & 0xff000000
			column_3_new := column_3_new | (column_2 & 0x00ff0000)
			column_3_new := column_3_new | (column_1 & 0x0000ff00)
			column_3_new := column_3_new | (column_0 & 0x000000ff)
			column_0 := column_0_new
			column_1 := column_1_new
			column_2 := column_2_new
			column_3 := column_3_new
		ensure
			column_0 |>> 24 & 0xff = old column_0 |>> 24 & 0xff
			column_0 |>> 16 & 0xff = old column_3 |>> 16 & 0xff
			column_0 |>> 8 & 0xff = old column_2 |>> 8 & 0xff
			column_0 & 0xff = old column_1 & 0xff
			column_1 |>> 24 & 0xff = old column_1 |>> 24 & 0xff
			column_1 |>> 16 & 0xff = old column_0 |>> 16 & 0xff
			column_1 |>> 8 & 0xff = old column_3 |>> 8 & 0xff
			column_1 & 0xff = old column_2 & 0xff
			column_2 |>> 24 & 0xff = old column_2 |>> 24& 0xff
			column_2 |>> 16 & 0xff = old column_1 |>> 16 & 0xff
			column_2 |>> 8 & 0xff = old column_0 |>> 8 & 0xff
			column_2 & 0xff = old column_3 & 0xff
			column_3 |>> 24& 0xff = old column_3 |>> 24 & 0xff
			column_3 |>> 16 & 0xff = old column_2 |>> 16 & 0xff
			column_3 |>> 8 & 0xff = old column_1 |>> 8 & 0xff
			column_3 & 0xff = old column_0 & 0xff
		end

	shift_rows
		local
			column_0_new: NATURAL_32
			column_1_new: NATURAL_32
			column_2_new: NATURAL_32
			column_3_new: NATURAL_32
		do
			column_0_new := column_0 & 0xff000000
			column_0_new := column_0_new | (column_1 & 0x00ff0000)
			column_0_new := column_0_new | (column_2 & 0x0000ff00)
			column_0_new := column_0_new | (column_3 & 0x000000ff)
			column_1_new := column_1 & 0xff000000
			column_1_new := column_1_new | (column_2 & 0x00ff0000)
			column_1_new := column_1_new | (column_3 & 0x0000ff00)
			column_1_new := column_1_new | (column_0 & 0x000000ff)
			column_2_new := column_2 & 0xff000000
			column_2_new := column_2_new | (column_3 & 0x00ff0000)
			column_2_new := column_2_new | (column_0 & 0x0000ff00)
			column_2_new := column_2_new | (column_1 & 0x000000ff)
			column_3_new := column_3 & 0xff000000
			column_3_new := column_3_new | (column_0 & 0x00ff0000)
			column_3_new := column_3_new | (column_1 & 0x0000ff00)
			column_3_new := column_3_new | (column_2 & 0x000000ff)
			column_0 := column_0_new
			column_1 := column_1_new
			column_2 := column_2_new
			column_3 := column_3_new
		ensure
			column_0 |>> 24 & 0xff = old column_0 |>> 24 & 0xff
			column_0 |>> 16 & 0xff = old column_1 |>> 16 & 0xff
			column_0 |>> 8 & 0xff = old column_2 |>> 8 & 0xff
			column_0 & 0xff = old column_3 & 0xff
			column_1 |>> 24 & 0xff = old column_1 |>> 24 & 0xff
			column_1 |>> 16 & 0xff = old column_2 |>> 16 & 0xff
			column_1 |>> 8 & 0xff = old column_3 |>> 8 & 0xff
			column_1 & 0xff = old column_0 & 0xff
			column_2 |>> 24 & 0xff = old column_2 |>> 24 & 0xff
			column_2 |>> 16 & 0xff = old column_3 |>> 16 & 0xff
			column_2 |>> 8 & 0xff = old column_0 |>> 8 & 0xff
			column_2 & 0xff = old column_1 & 0xff
			column_3 |>> 24 & 0xff = old column_3 |>> 24 & 0xff
			column_3 |>> 16 & 0xff = old column_0 |>> 16 & 0xff
			column_3 |>> 8 & 0xff = old column_1 |>> 8 & 0xff
			column_3 & 0xff = old column_2 & 0xff
		end

	add_round_key (schedule_index: INTEGER)
		do
			column_0 := column_0.bit_xor (key_schedule [schedule_index])
			column_1 := column_1.bit_xor (key_schedule [schedule_index + 1])
			column_2 := column_2.bit_xor (key_schedule [schedule_index + 2])
			column_3 := column_3.bit_xor (key_schedule [schedule_index + 3])
		end

feature -- GF(2^8) arithmetic
	add (one: INTEGER two: INTEGER): INTEGER
		do
			result := one.bit_xor (two)
		end

	multiply_and_reduce (field: NATURAL_8 multiplier: NATURAL_8): NATURAL_8
		local
			field_expanded: NATURAL_32
		do
			field_expanded := multiply (field, multiplier)
			result := reduce (field_expanded)
		end

	multiply (field: NATURAL_8 multiplier: NATURAL_8): NATURAL_32
		local
			counter: INTEGER
			field_expanded: NATURAL_32
		do
			field_expanded := field
			from
				counter := 0
			until
				counter > 7
			loop
				if
					multiplier.bit_test (counter)
				then
					result := result.bit_xor (field_expanded.bit_shift_left (counter))
				end
				counter := counter + 1
			end
		end

	reduce (in: NATURAL_32): NATURAL_8
		local
			counter: INTEGER
			result_expanded: NATURAL_32
		do
			from
				counter := 31
				result_expanded := in
			until
				counter = 7
			loop
				if
					result_expanded.bit_test (counter)
				then
					result_expanded := result_expanded.bit_xor (reducer.bit_shift_right (31 - counter))
				end
				counter := counter - 1
			end
			check
				result_expanded <= result.max_value
			end
			result := result_expanded.to_natural_8
		end

	s_box (in: NATURAL_8): NATURAL_8
		do
			result := s [in.to_integer_32]
		end

	two_table: SPECIAL [NATURAL_8]
			-- Table of {02} * x in GF(2^8)

	three_table: SPECIAL [NATURAL_8]
			-- Table of {03} * x in GF(2^8)

	nine_table: SPECIAL [NATURAL_8]
			-- Table of {09} * x in GF(2^8)

	eleven_table: SPECIAL [NATURAL_8]
			-- Table of {0b} * x in GF(2^8)

	thirteen_table: SPECIAL [NATURAL_8]
			-- Table of {0d} * x in GF(2^8)

	fourteen_table: SPECIAL [NATURAL_8]
			-- Table of {0E} * x in GF(2^8)

	multiply_table (multiplier: NATURAL_8): SPECIAL [NATURAL_8]
		local
			counter: INTEGER
		do
			create result.make_filled (0, 256)
			from
				counter := 0
			until
				counter = 256
			loop
				result [counter] := multiply_and_reduce (counter.to_natural_8, multiplier)
				counter := counter + 1
			variant
				256 - counter + 1
			end
		end

	reducer: NATURAL_32 = 0x8d800000

feature {NONE}
	byte_sink (in: NATURAL_8)
		do
			do_nothing
		end

	key_schedule: SPECIAL [NATURAL_32]
		deferred
		end
end
