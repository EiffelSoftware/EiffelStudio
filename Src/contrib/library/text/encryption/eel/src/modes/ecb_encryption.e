note
	description: "Electronic Codebook encryption mode"
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "Necessity is the plea for every infringement of human freedom. It is the argument of tyrants; it is the creed of slaves. - William Pitt (1783)"

class
	ECB_ENCRYPTION

create
	make

feature
	make (target_a: ECB_TARGET)
		do
			target := target_a
		end

feature
	block_size: INTEGER_32
		do
			result := target.block_size
		end

	encrypt_block (in: SPECIAL [NATURAL_8] in_offset: INTEGER_32 out_array: SPECIAL [NATURAL_8] out_offset: INTEGER_32)
		require
			ecb_ready
			in.valid_index (in_offset)
			in.valid_index (in_offset + block_size - 1)
			out_array.valid_index (out_offset)
			out_array.valid_index (out_offset + block_size - 1)
		do
			target.encrypt_block (in, in_offset, out_array, out_offset)
		end

	ecb_ready: BOOLEAN
		do
			result := target.ecb_ready
		end

feature {NONE}
	target: ECB_TARGET
end
