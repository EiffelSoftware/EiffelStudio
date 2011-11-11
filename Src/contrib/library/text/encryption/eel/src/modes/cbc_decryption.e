note
	description: "Cipher Block Chaining mode"
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "Just because you do not take an interest in politics doesn't mean politics won't take an interest in you. - Pericles (430 BC)"

class
	CBC_DECRYPTION

inherit
	ARRAY_FACILITIES

create
	make

feature
	make (target_a: CBC_TARGET iv: SPECIAL [NATURAL_8] iv_offset: INTEGER_32)
		require
			iv.valid_index (iv_offset)
			iv.valid_index (iv_offset + target_a.block_size - 1)
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

	decrypt_block (in: SPECIAL [NATURAL_8] in_offset: INTEGER_32 out_array: SPECIAL [NATURAL_8] out_offset: INTEGER_32)
		require
			cbc_ready
			in.valid_index (in_offset)
			in.valid_index (in_offset + block_size - 1)
			out_array.valid_index (out_offset)
			out_array.valid_index (out_offset + block_size - 1)
		do
			target.decrypt_block (in, in_offset, out_array, out_offset)
			array_xor (last, 0, out_array, out_offset, out_array, out_offset, block_size)
			last.copy_data (in, in_offset, 0, block_size)
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
