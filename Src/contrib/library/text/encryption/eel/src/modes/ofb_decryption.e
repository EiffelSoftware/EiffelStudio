note
	description: "Output Feedback decryption mode"
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "Sometimes it is said that man cannot be trusted with the government of himself. Can he, then, be trusted with the government of others? - Thomas Jefferson (1801)"

class
	OFB_DECRYPTION

inherit
	ARRAY_FACILITIES

create
	make

feature
	make (target_a: OFB_TARGET iv: SPECIAL [NATURAL_8] iv_offset: INTEGER_32)
		require
			iv.valid_index (iv_offset)
			iv.valid_index (iv_offset + target_a.block_size - 1)
		do
			target := target_a
			create last.make_filled (0, block_size)
			last.copy_data (iv, iv_offset, 0, block_size)
		end

feature
	block_size: INTEGER_32
		do
			result := target.block_size
		end

	decrypt_block (in: SPECIAL [NATURAL_8] in_offset: INTEGER_32 out_array: SPECIAL [NATURAL_8] out_offset: INTEGER_32)
		require
			ofb_ready
			in.valid_index (in_offset)
			in.valid_index (in_offset + block_size - 1)
			out_array.valid_index (out_offset)
			out_array.valid_index (out_offset + block_size - 1)
		do
			target.encrypt_block (last, 0, out_array, out_offset)
			last.copy_data (out_array, out_offset, 0, block_size)
			array_xor (last, 0, in, in_offset, out_array, out_offset, block_size)
		end

	ofb_ready: BOOLEAN
		do
			result := target.ofb_ready
		end

feature {NONE}
	last: SPECIAL [NATURAL_8]
	target: OFB_TARGET
end
