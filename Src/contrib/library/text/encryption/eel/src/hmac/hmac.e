note
	description: "Common ancestor for Hash-based message authentication code"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Wikipedia", "protocol=URI", "src=http://en.wikipedia.org/wiki/Hash-based_message_authentication_code"
	EIS: "name=RFC2104", "protocol=URI", "src=http://tools.ietf.org/html/rfc2104"

deferred class
	HMAC [H -> HASH]

inherit
	BYTE_FACILITIES

feature {NONE} -- Initialization

	make (k: READABLE_INTEGER_X)
			-- Initialize Current with key `k'
		local
			reduced_key: READABLE_INTEGER_X
			ipad_x, opad_x: READABLE_INTEGER_X
			l_block_size: like hash_block_size
		do
			message_hash := new_message_hash
			hash_block_size := message_hash.block_size
			hash_output_size := message_hash.output_size

			l_block_size := hash_block_size
			if k.bytes <= l_block_size then
				reduced_key := pad_key (k)
			else
				reduced_key := reduce_key (k)
			end

			ipad_x := reduced_key.bit_xor_value (create {INTEGER_X}.make_from_bytes (create {SPECIAL [NATURAL_8]}.make_filled (0x36, l_block_size), 0, l_block_size - 1))
			opad_x := reduced_key.bit_xor_value (create {INTEGER_X}.make_from_bytes (create {SPECIAL [NATURAL_8]}.make_filled (0x5c, l_block_size), 0, l_block_size - 1))

			ipad := ipad_x.as_fixed_width_byte_array (l_block_size)
			opad := opad_x.as_fixed_width_byte_array (l_block_size)

			create hmac

			feed_inner_mix
		end

	make_ascii_key (k: READABLE_STRING_8)
			-- Initialize Current with ascii key `k'	
		local
			l_key_bytes: SPECIAL [NATURAL_8]
			i: INTEGER
		do
			if k.is_empty then
				make (create {INTEGER_X}.default_create)
			else
				create l_key_bytes.make_filled (0, k.count)
				from
					i := 1
				until
					i > k.count
				loop
					l_key_bytes [i - 1] := k [i].code.to_natural_8
					i := i + 1
				end
				make (create {INTEGER_X}.make_from_bytes (l_key_bytes, 0, l_key_bytes.count - 1))
			end
		end

feature -- Access

	finish
			-- Finish the HMAC computation.
		local
			hash_inner, hash_outer: SPECIAL [NATURAL_8]
			l_hash: like message_hash
		do
			create hash_inner.make_filled (0, hash_output_size)
			create hash_outer.make_filled (0, hash_output_size)

			message_hash.do_final (hash_inner, 0)

			l_hash := new_message_hash
			l_hash.sink_special_lsb (opad, 0, hash_block_size - 1)
			l_hash.sink_special_lsb (hash_inner, 0, hash_output_size - 1)
			l_hash.do_final (hash_outer, 0)

			create hmac.make_from_bytes (hash_outer, 0, hash_output_size - 1)
			finished := True
		ensure
			finished
		end

	finished: BOOLEAN
			-- Is HMAC computation completed?

	hmac: INTEGER_X
			-- Computed HMAC value

	reset
		do
			message_hash.reset
			finished := False
			feed_inner_mix
		ensure
			not finished
		end

feature {NONE} -- Access: message hash

	hash_block_size: INTEGER
			-- Blocksize for associated hash.

	hash_output_size: INTEGER
			-- Bytes size of result for associated hash.

	new_message_hash: like message_hash
			-- New message hash object.
		deferred
		end

	message_hash: H
			-- Hash calculation for messages.

feature {NONE} -- Implementation

	reduce_key (k: READABLE_INTEGER_X): INTEGER_X
		local
			h: like new_message_hash
		do
			h := new_message_hash
			Result := h.hash (k)
		end

	pad_key (k: READABLE_INTEGER_X): INTEGER_X
		local
			l_key_bytes,
			l_result_bytes: SPECIAL [NATURAL_8]
		do
			create l_result_bytes.make_filled (0, hash_block_size)
			l_key_bytes := k.as_bytes
			l_result_bytes.copy_data (l_key_bytes, 0, 0, l_key_bytes.count)
			create Result.make_from_bytes (l_result_bytes, 0, hash_block_size - 1)
		end

	feed_inner_mix
		do
			sink_special_lsb (ipad, 0, hash_block_size - 1)
		end

	byte_sink (in: NATURAL_8)
		do
			message_hash.update (in)
		end

	ipad: SPECIAL [NATURAL_8]
	opad: SPECIAL [NATURAL_8]
end
