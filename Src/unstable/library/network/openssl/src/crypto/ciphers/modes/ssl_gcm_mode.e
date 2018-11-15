note
	description: "[
				GCM (Galois Counter Mode) is a mode of operation for block ciphers. 
				An AEAD (authenticated encryption with additional data) mode is a type of block cipher mode that simultaneously encrypts the message as well as authenticating it. 
				Additional unencrypted data may also be authenticated
			]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=gcm mode", "src=https://en.wikipedia.org/wiki/Galois/Counter_Mode", "protocol=uri"
	EIS: "name=cryptography library doc", "src=https://cryptography.io/en/latest/hazmat/primitives/symmetric-encryption/?highlight=GCM#algorithms", "protocol=uri"

class
	SSL_GCM_MODE

inherit

	SSL_MODE
	SSL_MODE_WITH_AUTHENTICATION_TAG
	SSL_MODE_WITH_INITIALIZATION_VECTOR

create
	make

feature {NONE} -- Intialization

	make (a_iv: READABLE_STRING_8; a_tag: detachable READABLE_STRING_32)
			-- Initialize gcm mode with
			-- initialiazation_vector `a_iv'
		do
				-- convert the `a_iv' hex string to byte array.
			create initialization_vector.make_from_array ((create {BYTE_ARRAY_CONVERTER}.make_from_hex_string (a_iv)).to_natural_8_array)
			if attached a_tag then
				create tag.make_from_array ((create {BYTE_ARRAY_CONVERTER}.make_from_hex_string (a_tag.to_string_8)).to_natural_8_array)
			end
		end

feature -- Access

	name: STRING_8 = "GCM"
			-- <Precursor>

	MAX_ENCRYPTED_BYTES: INTEGER_64 = 68719476704
			-- (2 ^ 39 - 256) / 8

	MAX_AAD_BYTES: INTEGER_64 = 2305843009213693952
			-- (2^ 64) / 8

feature -- Validate algorithm

	is_valid_for_algorithm (a_algo: SSL_ALGORITHM): BOOLEAN
			-- <Precursor>
		do
			Result := is_valid_aes_key (a_algo)
		end

feature -- Status Report

	is_valid_aes_key (a_algo: SSL_ALGORITHM): BOOLEAN
		do
			if
				attached {SSL_CIPHER_ALGORITHM} a_algo as l_algo and then
				l_algo.key_size > 256 and then l_algo.name.same_string ("AES")
			then
				Result := False
					-- Only 128, 192, and 256 bit keys are allowed for this AES mode
			elseif 	attached {SSL_CIPHER_ALGORITHM} a_algo as l_algo and then
				l_algo.key_size <= 256 and then l_algo.name.same_string ("AES")
			then
				Result := True
			end
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
