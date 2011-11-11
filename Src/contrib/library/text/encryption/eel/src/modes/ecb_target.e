note
	description: "A block cipher that can be the target of ECB mode"
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "A government that is big enough to give you all you want is big enough to take it all away. - Barry Goldwater (1964)"

deferred class
	ECB_TARGET

feature
	block_size: INTEGER_32
		deferred
		ensure
			Result > 0
		end

	ecb_ready: BOOLEAN
		deferred
		end

	decrypt_block (in: SPECIAL [NATURAL_8] in_offset: INTEGER_32 out_array: SPECIAL [NATURAL_8] out_offset: INTEGER_32)
		require
			ecb_ready
			in.valid_index (in_offset)
			in.valid_index (in_offset + block_size - 1)
			out_array.valid_index (out_offset)
			out_array.valid_index (out_offset + block_size - 1)
		deferred
		end

	encrypt_block (in: SPECIAL [NATURAL_8] in_offset: INTEGER_32 out_array: SPECIAL [NATURAL_8] out_offset: INTEGER_32)
		require
			ecb_ready
			in.valid_index (in_offset)
			in.valid_index (in_offset + block_size - 1)
			out_array.valid_index (out_offset)
			out_array.valid_index (out_offset + block_size - 1)
		deferred
		end
end
