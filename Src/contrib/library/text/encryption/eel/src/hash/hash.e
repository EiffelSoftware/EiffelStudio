note
	description: "Summary description for {HASH}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=RFC2104", "protocol=URI", "src=http://www.ietf.org/rfc/rfc2104.txt"

deferred class
	HASH

feature -- Access

	hash (k: READABLE_INTEGER_X): INTEGER_X
			-- Computed hash value for `k'
		local
			l_key_bytes,
			l_result_bytes: SPECIAL [NATURAL_8]
		do
			l_key_bytes := k.as_bytes
			sink_special (l_key_bytes, l_key_bytes.lower, l_key_bytes.upper)
			create l_result_bytes.make_filled (0, block_size)
			do_final (l_result_bytes, 0)
			create Result.make_from_bytes (l_result_bytes, 0, block_size - 1)
		end

	block_size: INTEGER
			-- block size of the hash function
		deferred
		end

	output_size: INTEGER
			-- byte-length of hash outputs
		deferred
		end

feature -- Operations				

	do_final (output: SPECIAL [NATURAL_8] out_off: INTEGER)
		require
			valid_offset: out_off >= 0
			out_big_enough: out.count - out_off >= 32
		deferred
		end

	reset
		deferred
		end

feature -- Byte sinks

	sink_special (in: SPECIAL [NATURAL_8] in_lower: INTEGER_32 in_upper: INTEGER_32)
		require
			in.valid_index (in_lower)
			in.valid_index (in_upper)
		deferred
		end

	sink_special_lsb (in: SPECIAL [NATURAL_8]; in_lower: INTEGER_32; in_upper: INTEGER_32)
		require
			in.valid_index (in_lower)
			in.valid_index (in_upper)
		deferred
		end

	sink_character (in: CHARACTER_8)
		deferred
		end

	sink_natural_32_be (in: NATURAL_32)
		deferred
		end

	sink_string (in: STRING)
		deferred
		end

	update (in: NATURAL_8)
		deferred
		end

end
