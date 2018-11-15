note
	description: "[
		When creating an encryption context using encryptor on a SSL_CIPHER object with an AEAD mode such as GCM an object conforming
		to both the SSL_AEAD_ENCRYPTION_CONTEXT and SSL_AEAD_CIPHER_CONTEXT interfaces will be returned. 
		This interface provides one additional attribute tag. tag can only be obtained after finalize has been called.
	]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=AEAD_ENCRYPTION_CONTEXT", "src=https://cryptography.io/en/latest/hazmat/primitives/symmetric-encryption/?highlight=aeadciphercontext#cryptography.hazmat.primitives.ciphers.AEADEncryptionContext", "protocol=uri"

deferred class
	SSL_AEAD_ENCRYPTION_CONTEXT_I

inherit
	SSL_CIPHER_CONTEXT_I

feature -- Status Report

	is_finalized: BOOLEAN
			-- Is encryption finalized?		
		deferred
		end

feature -- Tag

	tag_hex_string: detachable STRING
			-- Returns tag value as hex string. This is only available after encryption is finalized.
		require
			is_finalized: is_finalized
		deferred
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
