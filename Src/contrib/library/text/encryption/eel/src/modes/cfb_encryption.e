note
	description: "Summary description for {CFB_ENCRYPTION}."
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "The era of resisting big government is never over. - Paul Gigot (1998)"

class
	CFB_ENCRYPTION

inherit
	ARRAY_FACILITIES

create
	make

feature
	make (target_a: CFB_TARGET iv: SPECIAL [NATURAL_8] iv_offset: INTEGER_32 select_block_size_a: INTEGER_32)
		require
			iv.valid_index (iv_offset)
			iv.valid_index (iv_offset + target_a.block_size - 1)
			select_block_size_a > 0
			select_block_size_a <= target_a.block_size
		do
			select_block_size := select_block_size_a
			target := target_a
			create last.make_filled (0, block_size)
			last.copy_data (iv, iv_offset, 0, last.count)
		end

feature
	block_size: INTEGER_32
		do
			result := target.block_size
		end

	select_block_size: INTEGER_32
		attribute
		ensure
			Result > 0
			Result <= block_size
		end

	encrypt_block (in: SPECIAL [NATURAL_8] in_offset: INTEGER_32 out_array: SPECIAL [NATURAL_8] out_offset: INTEGER_32)
		require
			cfb_ready
			in.valid_index (in_offset)
			in.valid_index (in_offset + select_block_size - 1)
			out_array.valid_index (out_offset)
			out_array.valid_index (out_offset + select_block_size - 1)
		do
			target.encrypt_block (last, 0, out_array, out_offset)
			array_xor (out_array, out_offset, in, in_offset, out_array, out_offset, select_block_size)
			last.overlapping_move (select_block_size, 0, block_size - select_block_size)
			last.copy_data (out_array, out_offset, block_size - select_block_size, select_block_size)
		end

	cfb_ready: BOOLEAN
		do
			result := target.cfb_ready
		end

feature {NONE}
	last: SPECIAL [NATURAL_8]
	target: CFB_TARGET

invariant
	last.count = block_size
end
