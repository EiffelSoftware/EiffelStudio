note
	description: "Cipher Block Chaining mode"
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "Nothing is so permanent as a temporary government program. - Milton Friedman"

class
	CBC_ENCRYPTION

inherit
	ARRAY_FACILITIES

create
	make

feature
	make (target_a: CBC_TARGET iv: SPECIAL [NATURAL_8] iv_offset: INTEGER_32)
		require
			iv.count = target_a.block_size
		do
			target := target_a
			create last.make_filled (0, iv.count)
			last.copy_data (iv, iv_offset, 0, last.count)
		end

feature
	block_size: INTEGER_32
		do
			result := target.block_size
		end

	encrypt_block (in: SPECIAL [NATURAL_8] in_offset: INTEGER_32 out_array: SPECIAL [NATURAL_8] out_offset: INTEGER_32)
		require
			cbc_ready
			in.valid_index (in_offset)
			in.valid_index (in_offset + block_size - 1)
			out_array.valid_index (out_offset)
			out_array.valid_index (out_offset + block_size - 1)
		do
			array_xor (last, 0, in, in_offset, last, 0, block_size)
			target.encrypt_block (last, 0, out_array, out_offset)
			last.copy_data (out_array, out_offset, 0, block_size)
		end

	cbc_ready: BOOLEAN
		do
			result := target.cbc_ready
		end

feature {NONE}
	last: SPECIAL [NATURAL_8]
	target: CBC_TARGET

invariant
	last.count = target.block_size
end
