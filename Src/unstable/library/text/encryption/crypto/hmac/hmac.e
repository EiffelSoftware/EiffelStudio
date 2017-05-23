note
	description: "Common ancestor for Hash-based message authentication code"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Wikipedia", "protocol=URI", "src=http://en.wikipedia.org/wiki/Hash-based_message_authentication_code"
	EIS: "name=RFC2104", "protocol=URI", "src=http://tools.ietf.org/html/rfc2104"

deferred class
	HMAC [H -> MESSAGE_DIGEST]

inherit
	HELPER

feature {NONE} -- Initialization

	make (k: SPECIAL [NATURAL_8])
			-- Initialize Current with key `k'
		local
			reduced_key: SPECIAL [NATURAL_8]
			ipad_x, opad_x: SPECIAL [NATURAL_8]
			l_block_size: like hash_block_size
		do
			message_hash := new_message_hash
			hash_block_size := message_hash.block_size
			hash_output_size := message_hash.digest_count

			l_block_size := hash_block_size
			if k.count <= l_block_size then
				reduced_key := pad_key (k)
			else
				reduced_key := reduce_key (k)
			end

			check block_size: reduced_key.count = hash_block_size end

			ipad_x := bit_xor_value (reduced_key, create {SPECIAL [NATURAL_8]}.make_filled (0x36, l_block_size))
			opad_x := bit_xor_value (reduced_key, create {SPECIAL [NATURAL_8]}.make_filled (0x5c, l_block_size))

			ipad := as_fixed_width_byte_array (ipad_x, l_block_size)
			opad := as_fixed_width_byte_array (opad_x, l_block_size)

			create hmac.make_filled (0, hash_output_size)
			update_from_bytes (ipad)
		end

	make_ascii_key (k: READABLE_STRING_8)
			-- Initialize Current with ascii key `k'	
		do
			make (bytes_from_ascii_string (k))
		end

	make_hexadecimal_key (k: READABLE_STRING_8)
			-- Initialize Current with hexadecimal key `k'	
		require
			is_hexadecimal_string: is_hexadecimal_string (k)
		do
			make (bytes_from_hexadecimal_string (k))
		end

feature -- Change

	update_from_byte (a_byte: NATURAL_8)
			-- Append byte.
		do
			finished := False
			message_hash.update_from_byte (a_byte)
		end

	update_from_bytes (a_bytes: SPECIAL [NATURAL_8])
			-- Append bytes.
		do
			finished := False
			message_hash.update_from_bytes (a_bytes)
		end

	update_from_string (a_string: READABLE_STRING_8)
			-- Append bytes from `a_string'.
		do
			finished := False
			message_hash.update_from_string (a_string)
		end

	reset
		do
			message_hash.reset
			hmac.wipe_out
			finished := False
			update_from_bytes (ipad)
		ensure
			not finished
		end

feature -- Digest access		

	digest: SPECIAL [NATURAL_8]
		do
			finish
			Result := hmac
		end

	digest_as_string: STRING_8
			-- Hexadecimal string representation of Current digest.
		local
			l_digest: like digest
			index, l_upper: INTEGER
		do
			l_digest := digest
			create Result.make (l_digest.count // 2)
			from
				index := l_digest.lower
				l_upper := l_digest.upper
			until
				index > l_upper
			loop
				Result.append (l_digest [index].to_hex_string)
				index := index + 1
			end
		end

	base64_digest: STRING_8
			-- base64 string representation of Current digest.
		do
			Result := (create {BASE64}).bytes_encoded_string (digest)
		end

	lowercase_hexadecimal_string_digest: STRING_8
			-- Lowercase hexadecimal string representation of Current digest.	
		do
			Result := digest_as_string.as_lower
		end

	uppercase_hexadecimal_string_digest: STRING_8
			-- Uppercase hexadecimal string representation of Current digest.	
		do
			Result := digest_as_string.as_upper
		end

feature {NONE} -- Operation		

	finish
			-- Finish the HMAC computation.
		local
			hash_inner: SPECIAL [NATURAL_8]
			l_hash: like message_hash
		do
			if not finished then
				hash_inner := message_hash.digest

				l_hash := new_message_hash
				l_hash.update_from_bytes (opad)
				l_hash.update_from_bytes (hash_inner)

				hmac := l_hash.digest
				finished := True
			end
		ensure
			finished
		end

	finished: BOOLEAN
			-- Is HMAC computation completed?

	hmac: SPECIAL [NATURAL_8]
			-- Computed HMAC value

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

	reduce_key (k: SPECIAL [NATURAL_8]): SPECIAL [NATURAL_8]
		local
			h: like new_message_hash
		do
			h := new_message_hash
			h.update_from_bytes (k)
			Result := h.digest
			if Result.count < hash_block_size then
				Result := pad_key (Result)
			end
		end

	pad_key (k: SPECIAL [NATURAL_8]): SPECIAL [NATURAL_8]
		do
			create Result.make_filled (0, hash_block_size)
			Result.copy_data (k, 0, 0, k.count)
		end

	ipad: SPECIAL [NATURAL_8]
	opad: SPECIAL [NATURAL_8]

;note
	copyright: "Copyright (c) 1984-2017, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
