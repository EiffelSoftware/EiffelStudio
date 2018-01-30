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
	SSL_AEAD_ENCRYPTION_CONTEXT

feature -- Tag

	tag: detachable MANAGED_POINTER
			-- Returns tag value as bytes. This is only available after encryption is finalized.
		deferred
		end
end
