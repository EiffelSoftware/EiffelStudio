﻿note
	description: "[
			When calling encryptor() or decryptor() on a SSL_CIPHER object the result will conform to the SSL_CIPHER_CONTEXT interface. 
			You can then call update(data) with data until you have fed everything into the context. Once that is done call finalize() to finish the operation and obtain the remainder of the data.
			
			Block ciphers require that the plaintext or ciphertext always be a multiple of their block size. 
			Because of that padding is sometimes required to make a message the correct size. 
			SSL_CIPHER_CONTEXT will not automatically apply any padding; you’ll need to add your own. 
			For block ciphers the recommended padding is PKCS7. If you are using a stream cipher mode (such as CTR) you don’t have to worry about this.
	]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=SSL_CIPHER_CONTEXT", "src=https://cryptography.io/en/latest/hazmat/primitives/symmetric-encryption/?highlight=aeadciphercontext#cryptography.hazmat.primitives.ciphers.CipherContext", "protocol=uri"

deferred class
	SSL_CIPHER_CONTEXT

feature -- Update

	update_with_hex_string (a_data: READABLE_STRING_8)
			-- Processes the provided bytes `a_data' through the cipher and returns the results as bytes.
			-- a_data (bytes) – The data you wish to pass into the context.
		require
				is_not_finalized: not is_finalized
		deferred
		end

feature -- Status Report

	is_finalized: BOOLEAN
			-- Is the context finalized?		
		deferred
		end

feature -- Finalize

	finalize
			-- Process the final block as bytes.
			-- Once finalize is called this object can no longer be used.
			-- The output will be available in `hex_string`.
		require
			is_not_finalized: not is_finalized
		deferred
		end

feature -- Results

	hex_string: STRING
			-- Returns the results of processing the final block as a hex string.
		require
			is_finalized: is_finalized
		deferred
		end

	string: STRING
			-- Returns the results of processing the final block as string.
		require
			is_finalized: is_finalized
		deferred
		end
end
