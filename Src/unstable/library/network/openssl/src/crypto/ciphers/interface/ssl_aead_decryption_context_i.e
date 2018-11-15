note
	description: "[
		When creating an encryption context using decryptor on a SSL_CIPHER object with an AEAD mode such as GCM an object 
		conforming to both the SSL_AEAD_DECRYPTION_CONTEXT and SSL_AEAD_CIPHER_CONTEXT interfaces will be returned. 
		This interface provides one additional method finalize_with_tag that allows passing the authentication tag for validation after the ciphertext has been decrypted.

	]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=AEAD_DECRYPTION_CONTEXT", "src=https://cryptography.io/en/latest/hazmat/primitives/symmetric-encryption/?highlight=aeadciphercontext#cryptography.hazmat.primitives.ciphers.AEADDecryptionContext", "protocol=uri"

deferred class
	SSL_AEAD_DECRYPTION_CONTEXT_I

inherit
	SSL_CIPHER_CONTEXT_I

feature -- Finalize

    finalize_with_tag_hex_string (a_tag: READABLE_STRING_8)
			--	Process the final block as bytes and allows
			--	delayed passing of the authentication tag.
			--  tag `a_tag'(as hex string) – The tag bytes to verify after decryption.
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
