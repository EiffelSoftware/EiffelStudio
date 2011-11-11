note
	description: "Counter decryption mode"
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "If you have been voting for politicians who promise to give you goodies at someone else's expense, then you have no right to complain when they take your money and give it to someone else, including themselves. - Thomas Sowell (1992)"

class
	CTR_DECRYPTION

inherit
	ARRAY_FACILITIES

create
	make

feature
	make (target_a: CTR_TARGET iv: INTEGER_X)
		do
			target := target_a
			create counter
			counter.copy (iv)
			max := counter.one.bit_shift_left_value (block_size * 8)
			create counter_array.make_filled (0, block_size)
		end

feature
	block_size: INTEGER_32
		do
			result := target.block_size
		end

	decrypt_block (in: SPECIAL [NATURAL_8] in_offset: INTEGER_32 out_array: SPECIAL [NATURAL_8] out_offset: INTEGER_32)
		require
			ctr_ready
			in.valid_index (in_offset)
			in.valid_index (in_offset + block_size - 1)
			out_array.valid_index (out_offset)
			out_array.valid_index (out_offset + block_size - 1)
		do
			counter.to_fixed_width_byte_array (counter_array, 0, block_size - 1)
			target.encrypt_block (counter_array, 0, out_array, out_offset)
			array_xor (out_array, out_offset, in, in_offset, out_array, out_offset, block_size)
			counter := (counter + counter.one) \\ max
		end

	ctr_ready: BOOLEAN
		do
			result := target.ctr_ready
		end

feature {NONE}
	counter_array: SPECIAL [NATURAL_8]
	counter: INTEGER_X
	max: INTEGER_X
	target: CTR_TARGET
end
