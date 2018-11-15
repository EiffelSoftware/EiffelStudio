note
	description: "[
		When calling encryptor or decryptor on a SSL_CIPHER object with an AEAD (Authenticated encryption (AE) with with associated data (AD ) mode (e.g. GCM) the result will conform to the AEADCipherContext and CipherContext interfaces. 
		If it is an encryption or decryption context it will additionally be an SSL_AEAD_ENCRYPTION_CONTEXT or SSL_AEAD_DECRYPTION_CONTEXT instance, respectively. 
		SSL_AEAD_CIPHER_CONTEXT contains an additional method authenticate_additional_data() for adding additional authenticated but unencrypted data (see note below). 
		You should call this before calls to update. When you are done call finalize to finish the operation.
		Note
		In AEAD modes all data passed to update() will be both encrypted and authenticated. 
		Do not pass encrypted data to the authenticate_additional_data() method. It is meant solely for additional data you may want to authenticate but leave unencrypted.
	]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=AEADCipherContext", "src=https://cryptography.io/en/latest/hazmat/primitives/symmetric-encryption/?highlight=aeadciphercontext#cryptography.hazmat.primitives.ciphers.AEADCipherContext", "protocol=uri"

deferred class
	SSL_AEAD_CIPHER_CONTEXT_I

inherit
	SSL_CIPHER_CONTEXT_I

feature -- Aditional data

	authenticate_additional_data_hex_string (a_data: READABLE_STRING_8)
			--	Any data `a_data' as hex string, that you wish to authenticate but not encrypt.
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
