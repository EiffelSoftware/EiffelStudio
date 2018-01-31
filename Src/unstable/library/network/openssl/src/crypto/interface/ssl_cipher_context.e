note
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

	update (a_data: MANAGED_POINTER): MANAGED_POINTER
			-- Processes the provided bytes `a_bytes' through the cipher and returns the results as bytes.
			-- a_data (bytes) – The data you wish to pass into the context.
		deferred
		end

   update_into(a_data, a_buf: MANAGED_POINTER): INTEGER
			-- Processes the provided bytes 'a_data' and writes the resulting data into the
			-- provided buffer `a_buf'. Returns the number of bytes written.
			-- a_data (bytes) – The data you wish to pass into the context.
			-- a_ buf – A writable buffer that the data will be written into.
			--			This buffer should be len(data) + n - 1 bytes where n is the block size (in bytes) of the cipher and mode combination.
			-- Note: we need to find a way to express an abstract precondition like
			--                 valid_size: a_buffer.count >= a_data.count + block_size_bytes - 1
			--  is_valid_size (a_buff_size, a_data_size): BOOLEAN
		deferred
		end

feature -- Finalize

   finalize: MANAGED_POINTER
			-- Returns the results of processing the final block as bytes.
			-- Once finalize is called this object can no longer be used.
		deferred
		end
end
