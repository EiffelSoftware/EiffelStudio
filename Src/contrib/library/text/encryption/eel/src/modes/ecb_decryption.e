note
	description: "Electronic Codebook decryption mode"
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "There are just two rules of governance in a free society: Mind your own business. Keep your hands to yourself. - P.J. O'Rourke (1993)"

class
	ECB_DECRYPTION

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

	decrypt_block (in: SPECIAL [NATURAL_8] in_offset: INTEGER_32 out_array: SPECIAL [NATURAL_8] out_offset: INTEGER_32)
		require
			ecb_ready
			in.valid_index (in_offset)
			in.valid_index (in_offset + block_size - 1)
			out_array.valid_index (out_offset)
			out_array.valid_index (out_offset + block_size - 1)
		do
			target.decrypt_block (in, in_offset, out_array, out_offset)
		end

	ecb_ready: BOOLEAN
		do
			result := target.ecb_ready
		end

feature {NONE}
	target: ECB_TARGET
end
