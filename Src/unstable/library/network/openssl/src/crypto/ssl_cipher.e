note
	description: "[
		Object responsible to perfom encryption/decryption
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	SSL_CIPHER

create
	make_by_pointer

feature {NONE} -- Creation Procedure

	make_by_pointer (a_pointer: POINTER)
			-- Create an object cipher with `a_pointer'
		do
			item := a_pointer
		ensure
			item_not_default: item /= default_pointer
		end

	item: POINTER
			-- pointer to an EVP_CIPHER.

	ctx: detachable POINTER
			-- pointer to the cipher context.
			-- EVP_CIPHER_CTX.			

feature -- Access

	key: detachable READABLE_STRING_8
			-- string representing the key.
		note
			option: stable
		attribute
		end

	iv: detachable READABLE_STRING_8
			-- string representing the initalization vector.
		note
			option: stable
		attribute
		end

	encrypt: BOOLEAN
			--  True: encrypting, otherwise decrypting.

	iv_length: INTEGER
			-- iv length of the current cipher algorithm.
		do
			Result := {SSL_CRYPTO_EXTERNALS}.c_evp_cipher_iv_length (item)
		end

	key_length: INTEGER
			-- key length of the current cipher algorithm.
		do
			Result := {SSL_CRYPTO_EXTERNALS}.c_evp_cipher_key_length (item)
		end

	flags: NATURAL_64
			-- flag of the current cipher algorithm.
		do
			Result := {SSL_CRYPTO_EXTERNALS}.c_evp_cipher_flags (item)
		end

	block_size: INTEGER
			-- block size of the cipher algorithm.

	finalized: BOOLEAN
			-- is the cipher operation already completed?		

feature -- Error

	error: detachable READABLE_STRING_8
		-- last error.


feature -- Initialization

	initialize (a_key: READABLE_STRING_8; a_iv: READABLE_STRING_8; a_encrypt: BOOLEAN)
			-- Initialize cipher instance.
			-- with key `a_key', initialization vectionr iv `a_iv' and encrypt mode `encrypt'.
		require
			valid_id_length: (create {BYTE_ARRAY_CONVERTER}.make_from_string (a_iv)).count = iv_length
		local
			l_key:  MANAGED_POINTER
			l_iv: MANAGED_POINTER
			l_res: INTEGER
		do
			clean_context

			encrypt := a_encrypt

				-- create cipher context
			ctx := {SSL_CRYPTO_EXTERNALS}.c_evp_cipher_ctx_new
			if ctx /= default_pointer then
				create l_key.make_from_array ((create {BYTE_ARRAY_CONVERTER}.make_from_string (a_key)).to_natural_8_array)
				create l_iv.make_from_array ((create {BYTE_ARRAY_CONVERTER}.make_from_string (a_iv)).to_natural_8_array)
				if l_key.count /= key_length then
					if 	(flags & 8 ) /= 0	then
						-- Variable key length cipher.

					else
						error := "Invalid key length for this algorithm"
					end
				else
					l_res:= {SSL_CRYPTO_EXTERNALS}.c_evp_cipherinit_ex (ctx, item, default_pointer, l_key.item, l_iv.item, encrypt.to_integer)
					if l_res = 0 then
						clean_context
						error := "Unable to initialize cipher"
					else
						block_size := {SSL_CRYPTO_EXTERNALS}.c_evp_cipher_block_size (item)
					    finalized := False
					end
				end
			else
				error := "Unable to create cipher context"
			end
		end


feature -- Update

	update (a_data: READABLE_STRING_8)
			-- Process the ecryption/decryption.
			-- data `a_data' part of the plain text/ciphertext to process.
			-- Update outptut_buffer with part of ciphercext/plain text.
		require
			updates_allowed: not finalized
		local
			l_len: INTEGER
			l_buffer: MANAGED_POINTER
			l_data: MANAGED_POINTER
			l_res: INTEGER
			l_output_buffer: MANAGED_POINTER
		do

			if a_data.count > 0 then
				create l_data.make_from_array ((create {BYTE_ARRAY_CONVERTER}.make_from_string (a_data)).to_natural_8_array)
				create l_buffer.make_from_array (create {ARRAY [NATURAL_8]}.make_filled (0, 1, block_size + l_data.count))

				l_res := {SSL_CRYPTO_EXTERNALS}.c_evp_cipherupdate (ctx, l_buffer.item, $l_len, l_data.item, l_data.count)
				if l_res <= 0 then
					clean_context
					error := "problem processing data"
				else
					l_output_buffer := output_buffer
					if attached l_output_buffer then
						l_output_buffer.append (l_buffer)
					else
						create l_output_buffer.make (l_buffer.count)
						l_output_buffer.copy (l_buffer)
						output_buffer := l_output_buffer
					end
				end
			else
			 	-- do nothing.
			end
		end


feature -- Finish

	finish
			-- Finalizes processing, encrypting or decrypting.
		require
			not_finalized: not finalized
		local
			l_buffer: MANAGED_POINTER
			l_len: INTEGER
			l_output_buffer: MANAGED_POINTER
			l_res: INTEGER
		do
			create l_buffer.make_from_array (create {ARRAY [NATURAL_8]}.make_filled (0, 1, block_size))
			finalized := True
			l_res := {SSL_CRYPTO_EXTERNALS}.c_evp_cipherfinal_ex (ctx, l_buffer.item, $l_len)
			if l_res = 0 then
				clean_context
				error := "Unable to finalize cipher"
			else

				l_output_buffer := output_buffer
				if attached l_output_buffer then
					l_output_buffer.append (l_buffer)
				else
					error:= "Unexpected error"
				end
			end
		end

feature -- Output

	output_buffer: detachable MANAGED_POINTER
			-- part of ciphercext/plain text.

	string_output: READABLE_STRING_8
			-- String representation of cyphertext/plain text.
		local
			l_index: INTEGER
			l_result: STRING_8
		do
			create l_result.make_empty
			if attached output_buffer as l_buffer then
				from
				until
					l_index >= l_buffer.count
				loop
					l_result.append_character(l_buffer.read_character (l_index))
					l_index := l_index + 1
				end
			end
			Result := l_result
		end



feature -- Clean

	clean_context
			-- Cleans up the cipher context.
		local
			l_res: INTEGER
		do
			if attached ctx as l_ctx then
				l_res := {SSL_CRYPTO_EXTERNALS}.c_evp_cipher_ctx_reset (l_ctx)
				{SSL_CRYPTO_EXTERNALS}.c_evp_cipher_ctx_free (l_ctx)
				ctx := default_pointer
				finalized := True
			end
		end

end
