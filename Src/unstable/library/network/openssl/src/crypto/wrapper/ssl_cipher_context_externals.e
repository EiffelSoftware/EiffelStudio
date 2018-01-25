note
	description: "Summary description for {SSL_CIPHER_CONTEXT_EXTERNALS}."
	date: "$Date$"
	revision: "$Revision$"

class
	SSL_CIPHER_CONTEXT_EXTERNALS

create
	make

feature {NONE} -- Initialization

	make (a_cipher: SSL_ALGORITHM; a_mode: SSL_MODE; a_operation: INTEGER)
			-- Create an object context with a cipher `a_cipher'
			-- mode `a_mode' and type of operation: `a_operation'.
			-- if 1 encrytp, 0 decrypt.
		local
			l_res: INTEGER
		do
			clean_context

			cipher := a_cipher
			mode := a_mode
			operation := a_operation
			tag := Void

			if attached {SSL_BLOCK_CIPHER_ALGORITHM} cipher  as l_algo then
				block_size_bytes := l_algo.block_size // 8
			else
				block_size_bytes := 1
			end

			ctx := {SSL_CRYPTO_EXTERNALS}.c_evp_cipher_ctx_new

			evp_cipher := cipher_by_name (cipher, mode)
			if evp_cipher /= default_pointer then

				if attached {SSL_MODE_WITH_INITIALIZATION_VECTOR} mode as l_mode then
					iv_nonce := l_mode.initialization_vector
				elseif attached {SSL_MODE_WITH_TWEAK} mode as l_mode then
					iv_nonce := l_mode.tweak
				elseif attached {SSL_MODE_WITH_NONCE} mode as l_mode then
					iv_nonce := l_mode.nonce
				elseif attached {SSL_MODE_WITH_NONCE} cipher as l_cipher then
					iv_nonce := l_cipher.nonce
				else
					iv_nonce := Void
				end

					-- init with cipher and operation type
		        l_res := {SSL_CRYPTO_EXTERNALS}.c_EVP_CipherInit_ex(ctx, evp_cipher,
		                                                   default_pointer,
		                                                   default_pointer,
		                                                   default_pointer,
		                                                   operation)

		        check success: l_res /= 0 end

			        -- set the key length to handle variable key ciphers
		        l_res := {SSL_CRYPTO_EXTERNALS}.c_EVP_CIPHER_CTX_set_key_length (ctx, cipher.key_bytes.count)

		     	check success: l_res /= 0 end

				if attached {SSL_GCM_MODE} mode as l_mode then

					if attached iv_nonce as l_iv_nonce then
						l_res := {SSL_CRYPTO_EXTERNALS}.c_evp_cipher_ctx_ctrl(ctx, {SSL_CRYPTO_EXTERNALS}.C_EVP_CTRL_AEAD_SET_IVLEN, l_iv_nonce.count, default_pointer)
    	 	    		check success: l_res /= 0 end

						if attached l_mode.tag as l_tag then
							l_res := {SSL_CRYPTO_EXTERNALS}.c_evp_cipher_ctx_ctrl(ctx, {SSL_CRYPTO_EXTERNALS}.C_EVP_CTRL_AEAD_SET_TAG, l_tag.count, l_tag.item)
							check success: l_res /= 0 end
							tag := l_tag
						end
        	    	else
        	    		-- iv_nonce not attached
        	    	end
				end

					-- pass key/iv
				if attached iv_nonce as l_iv_nonce then
			        l_res := {SSL_CRYPTO_EXTERNALS}.c_evp_cipherinit_ex(ctx, default_pointer, default_pointer, cipher.key_bytes.item, l_iv_nonce.item, operation )
			    	check success: l_res /= 0 end
			    end

				 	--Disable padding here as it's handled higher up in the API.
       			l_res := {SSL_CRYPTO_EXTERNALS}.c_evp_cipher_ctx_set_padding(ctx, 0)
			else
				-- TODO add error handling.
				-- Unsupported algorithm, cipher {cipher}
				-- in {mode} mode is not supported.

			end
		end

feature -- Access

	ENCRYPT: INTEGER = 1
			-- to encrypt.

	DECRYPT: INTEGER = 0
			-- to decrypt.

	cipher: SSL_ALGORITHM
			-- current cipher (algo).

	mode: SSL_MODE
			-- current mode to be used.

	operation: INTEGER
			-- encrypt or decrypt.

	block_size_bytes: INTEGER
			-- size of the block used.

	tag: detachable MANAGED_POINTER
			--  tag bytes to verify during decryption.
			--  tag generated when finalizing encryption.

	iv_nonce: detachable MANAGED_POINTER
			-- initialization vector.

	finalized : BOOLEAN
			-- has the crypt/decrypt process finished?

feature -- Update

	update (data: MANAGED_POINTER): MANAGED_POINTER
		local
			l_buffer: MANAGED_POINTER
			l_res: INTEGER
		do
			create l_buffer.make (data.count + block_size_bytes - 1)
			l_res := update_into (data, l_buffer)
			create Result.make_from_array (l_buffer.read_array (0, l_res))
		end

	update_into (a_data, a_buffer: MANAGED_POINTER): INTEGER
		require
			valid_size: a_buffer.count >= a_data.count + block_size_bytes - 1
		local
			l_outlen: INTEGER
			l_res: INTEGER
		do
			l_res := {SSL_CRYPTO_EXTERNALS}.c_evp_cipherupdate(ctx, a_buffer.item, $l_outlen, a_data.item, a_data.count)
       		check
       			success: l_res /= 0
       		end
       		Result := l_outlen
		end

feature -- Finalize

	finalize: MANAGED_POINTER
		local
			l_buffer: MANAGED_POINTER
			l_outlen: INTEGER
			l_res: INTEGER
			l_tag_buff: MANAGED_POINTER
		do
			create Result.make (0)
			if
				operation = decrypt and then
				attached {SSL_MODE_WITH_AUTHENTICATION_TAG} mode as l_mode and then
			   	tag = Void
			then
				-- TODO handle error
				-- Authentication tag must be provided when decrypting
			else
				create l_buffer.make (block_size_bytes)
				l_res := {SSL_CRYPTO_EXTERNALS}.c_evp_cipherfinal_ex(ctx, l_buffer.item, $l_outlen)
				if l_res = 0 then
					-- todo HANDLE ERROR
					-- check error
				else
					if l_outlen > 0 then
						create Result.make_from_array (l_buffer.read_array (0, l_outlen))
					end
				end

				if
					attached {SSL_GCM_MODE} mode and then
					operation = encrypt
				then
					create l_tag_buff.make (block_size_bytes)
					l_res := {SSL_CRYPTO_EXTERNALS}.c_EVP_CIPHER_CTX_ctrl(ctx, {SSL_CRYPTO_EXTERNALS}.C_EVP_CTRL_AEAD_GET_TAG, block_size_bytes, l_tag_buff.item)
					check success: l_res /= 0 end
					tag := l_tag_buff
				end
			end
			l_res := {SSL_CRYPTO_EXTERNALS}.c_evp_cipher_ctx_reset (ctx)
			check success: l_res /= 0 end
			finalized := True
		end

	finalize_with_tag (a_tag: MANAGED_POINTER): MANAGED_POINTER
		local
			l_res: INTEGER
		do
			 l_res := {SSL_CRYPTO_EXTERNALS}.c_evp_cipher_ctx_ctrl(ctx, {SSL_CRYPTO_EXTERNALS}.C_EVP_CTRL_AEAD_SET_TAG, a_tag.count, a_tag.item)
			 check success: l_res /= 0 end
			 tag := a_tag
			 Result := finalize
		end


	authenticate_additional_data (a_data: MANAGED_POINTER)
		local
			l_outlen: INTEGER
			l_res: INTEGER
		do
			l_res :={SSL_CRYPTO_EXTERNALS}.c_evp_cipherupdate(ctx, default_pointer, $l_outlen, a_data.item, a_data.count)
			check success: l_res /= 0 end
		end

feature {NONE} -- Implementation


	ctx: POINTER
			-- cipher context.

	evp_cipher: POINTER
			-- cipher algorithm


	cipher_by_name (a_cipher: SSL_ALGORITHM; a_mode: SSL_MODE): POINTER
			--  GetCipherByName("{cipher.name}-{cipher.key_size}-{mode.name}")	
		local
			l_name: STRING_8
			c_name: C_STRING
		do
			if
				attached {SSL_CIPHER_ALGORITHM} a_cipher as l_algo
			then
				create l_name.make_from_string (Cipher_name_template)
				l_name.replace_substring_all ("#cname", l_algo.name)
				l_name.replace_substring_all ("#key", l_algo.key_size.out)
				l_name.replace_substring_all ("#mname", a_mode.name)
				l_name.to_lower
				create c_name.make (l_name)
				Result :=  {SSL_CRYPTO_EXTERNALS}.c_evp_get_cipherbyname (c_name.item)
			end
		end


	Cipher_name_template: STRING = "#cname-#key-#mname"


feature -- Clean context

 	clean_context
			-- Cleans up the cipher context.
		local
			l_res: INTEGER
		do
			if attached ctx as l_ctx then
				l_res := {SSL_CRYPTO_EXTERNALS}.c_evp_cipher_ctx_reset (l_ctx)
				{SSL_CRYPTO_EXTERNALS}.c_evp_cipher_ctx_free (l_ctx)
				ctx := default_pointer
			end
		end
end
