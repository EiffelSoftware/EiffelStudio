note
	description: "A block cipher that can be the target of CTR mode"
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "Everything that is really great and inspiring is created by the individual who can labor in freedom. - Albert Einstein"

deferred class
	CTR_TARGET

feature
	block_size: INTEGER_32
		deferred
		ensure
			Result > 0
		end

	ctr_ready: BOOLEAN
		deferred
		end

	encrypt_block (in: SPECIAL [NATURAL_8] in_offset: INTEGER_32 out_array: SPECIAL [NATURAL_8] out_offset: INTEGER_32)
		require
			ctr_ready
			in.valid_index (in_offset)
			in.valid_index (in_offset + block_size - 1)
			out_array.valid_index (out_offset)
			out_array.valid_index (out_offset + block_size - 1)
		deferred
		end
end
