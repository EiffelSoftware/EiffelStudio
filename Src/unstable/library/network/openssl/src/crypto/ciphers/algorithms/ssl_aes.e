note
	description: "[
				AES (Advanced Encryption Standard) is a block cipher standardized by NIST. AES is both fast, and cryptographically strong. It is a good default choice for encryption.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	SSL_AES

inherit

	SSL_ALGORITHM

	SSL_CIPHER_ALGORITHM

	SSL_BLOCK_CIPHER_ALGORITHM

create
	make

feature {NONE} -- Initialization

	make (a_key: READABLE_STRING_8)
		do
			key := a_key
		ensure
			key_set: key = a_key
			valid_key: verify_key_size
		end

feature -- Access

	name: STRING_8 = "AES"
			-- <Precursor>

	block_size: INTEGER = 128
			-- <Precursor>

	key_sizes: ARRAY [INTEGER]
			-- <Precursor>
		do
			Result := {ARRAY[INTEGER]}<<128,192,256,512>>
		end

	key_bytes: MANAGED_POINTER
			-- <Precursor>
		do
			create Result.make_from_array((create {BYTE_ARRAY_CONVERTER}.make_from_hex_string (key)).to_natural_8_array)
		end

note
	copyright: "Copyright (c) 1984-2018, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
