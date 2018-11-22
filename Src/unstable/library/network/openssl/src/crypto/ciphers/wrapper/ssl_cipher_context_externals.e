note
	description: "Object representing a low level cipher context with direct access to the Crypto Externals"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Cipher Context", "src=https://github.com/pyca/cryptography/blob/master/src/cryptography/hazmat/backends/openssl/ciphers.py", "protocol=uri"

class
	SSL_CIPHER_CONTEXT_EXTERNALS

inherit

	SSL_SHARED_EXCEPTIONS

create
	make

feature {NONE} -- Initialization

	make (a_cipher: SSL_ALGORITHM; a_mode: SSL_MODE; a_operation: INTEGER)
			-- Create an object context with a cipher `a_cipher'
			-- mode `a_mode' and type of operation: `a_operation'.
			-- if 1 encrytp, 0 decrypt.
		local
			l_res: INTEGER
			l_description: STRING
		do
				-- clean conext, reset, free and void.
			clean_context
			cipher := a_cipher
			mode := a_mode
			operation := a_operation
			tag := Void
			if attached {SSL_BLOCK_CIPHER_ALGORITHM} cipher as l_algo then
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
				l_res := {SSL_CRYPTO_EXTERNALS}.c_EVP_CipherInit_ex (ctx, evp_cipher, default_pointer, default_pointer, default_pointer, operation)
				check
					success: l_res /= 0
				end

					-- set the key length to handle variable key ciphers
				l_res := {SSL_CRYPTO_EXTERNALS}.c_EVP_CIPHER_CTX_set_key_length (ctx, cipher.key_bytes.count)
				check
					success: l_res /= 0
				end
				if attached {SSL_GCM_MODE} mode as l_mode then
					if attached iv_nonce as l_iv_nonce then
						l_res := {SSL_CRYPTO_EXTERNALS}.c_evp_cipher_ctx_ctrl (ctx, {SSL_CRYPTO_EXTERNALS}.C_EVP_CTRL_AEAD_SET_IVLEN, l_iv_nonce.count, default_pointer)
						check
							success: l_res /= 0
						end
						if attached l_mode.tag as l_tag and then operation = DECRYPT_MODE then
							l_res := {SSL_CRYPTO_EXTERNALS}.c_evp_cipher_ctx_ctrl (ctx, {SSL_CRYPTO_EXTERNALS}.C_EVP_CTRL_AEAD_SET_TAG, l_tag.count, l_tag.item)
							check
								success: l_res /= 0
							end
							tag := l_tag
						end
					else
							-- Note:
							-- iv_nonce not attached
							-- should we call c_evp_cipher_ctx_ctrl with iv_nonce with 0 like
							-- l_res := {SSL_CRYPTO_EXTERNALS}.c_evp_cipher_ctx_ctrl(ctx, {SSL_CRYPTO_EXTERNALS}.C_EVP_CTRL_AEAD_SET_IVLEN, 0 , default_pointer)
					end
				end

					-- pass key/iv
				if attached iv_nonce as l_iv_nonce then
					l_res := {SSL_CRYPTO_EXTERNALS}.c_evp_cipherinit_ex (ctx, default_pointer, default_pointer, cipher.key_bytes.item, l_iv_nonce.item, operation)
					check
						success: l_res /= 0
					end
				end

					--Disable padding here as it's handled higher up in the API.
				l_res := {SSL_CRYPTO_EXTERNALS}.c_evp_cipher_ctx_set_padding (ctx, 0)
			else
					-- Note: at the moment Error Handling is using Excpetion.
				create l_description.make_from_string ("Cipher ")
				if attached {SSL_CIPHER_ALGORITHM} a_cipher as l_algo then
					l_description.append (l_algo.name)
				else
					l_description.append ("Unknown")
				end
				l_description.append (" in ")
				l_description.append (a_mode.name)
				l_description.append (" mode is not supported")
				raise_exception (l_description)
			end
		end


feature -- Constants

	ENCRYPT_MODE: INTEGER = 1
			-- to encrypt.

	DECRYPT_MODE: INTEGER = 0
			-- to decrypt.

feature -- Access


	cipher: SSL_ALGORITHM
			-- current cipher (algo).

	mode: SSL_MODE
			-- current mode to be used.

	operation: INTEGER
			-- The operation value can be ENCRYPT_MODE or DECRYPT_MODE.

	block_size_bytes: INTEGER
			-- size of the block used.

	tag: detachable MANAGED_POINTER
			--  tag bytes to verify during decryption.
			--  tag generated when finalizing encryption.

	iv_nonce: detachable MANAGED_POINTER
			-- initialization vector.

	hex_string: STRING
			-- <Precursor>
		local
			l_byte_array: BYTE_ARRAY_CONVERTER
		do
			if attached computed_value as l_value then
				create l_byte_array.make (l_value.count)
				l_byte_array.append_bytes (l_value.read_array (0, l_value.count))
				Result := l_byte_array.to_hex_string
				Result.to_lower
			else
				create Result.make_empty
			end
		end

	string: STRING
			-- <Precursor>
		local
			l_index: INTEGER
		do
			create Result.make_empty
			if attached computed_value as l_result then
				from
				until
					l_index >= l_result.count
				loop
					Result.append_character (l_result.read_character (l_index))
					l_index := l_index + 1
				end
			end
		end

feature -- Update

	update_with_hex_string (a_data: READABLE_STRING_8)
		local
			l_data: MANAGED_POINTER
		do
			create l_data.make_from_array ((create {BYTE_ARRAY_CONVERTER}.make_from_hex_string (a_data)).to_natural_8_array)
			computed_value := update (l_data)
		end

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
			l_res := {SSL_CRYPTO_EXTERNALS}.c_evp_cipherupdate (ctx, a_buffer.item, $l_outlen, a_data.item, a_data.count)
			check
				success: l_res /= 0
			end
			Result := l_outlen
		end

feature -- Status Report

	finalized: BOOLEAN
			-- has the crypt/decrypt process finished?

	is_finalized: BOOLEAN
			-- <Precursor>
		do
			Result := finalized
		end

	is_encrypt_operation: BOOLEAN
			-- Is the current mode ENCRYPT_MODE?
		do
			Result := operation = ENCRYPT_MODE
		end

feature -- Finalize

	finalize
		local
			l_buffer: MANAGED_POINTER
			l_outlen: INTEGER
			l_res: INTEGER
			l_tag_buff: MANAGED_POINTER
			l_result: MANAGED_POINTER
		do
			create l_result.make (0)
			if operation = decrypt_mode and then attached {SSL_MODE_WITH_AUTHENTICATION_TAG} mode as l_mode and then tag = Void then
				raise_exception ("Authentication tag tag must be provided when decrypting")
			else
				create l_buffer.make (block_size_bytes)
				l_res := {SSL_CRYPTO_EXTERNALS}.c_evp_cipherfinal_ex (ctx, l_buffer.item, $l_outlen)
				if l_res = 0 then
					if attached {LIST [SSL_ERROR]} ({SSL_ERROR_FACTORY}.errors) as l_errors then
						if l_errors.at (1).lib_and_reason_match ({SSL_ERROR_EXTERNALS}.ERR_LIB_EVP, {SSL_ERROR_EXTERNALS}.EVP_R_DATA_NOT_MULTIPLE_OF_BLOCK_LENGTH) then
							raise_exception ("The length of the provided data is not a multiple of the block length.")
						end
					elseif attached {SSL_GCM_MODE} mode as l_mode then
						raise_exception ("Invalid Tag")
					end
				else
					if l_outlen > 0 then
						create l_result.make_from_array (l_buffer.read_array (0, l_outlen))
					end
				end
				if attached {SSL_GCM_MODE} mode and then operation = encrypt_mode then
					create l_tag_buff.make (block_size_bytes)
					l_res := {SSL_CRYPTO_EXTERNALS}.c_EVP_CIPHER_CTX_ctrl (ctx, {SSL_CRYPTO_EXTERNALS}.C_EVP_CTRL_AEAD_GET_TAG, block_size_bytes, l_tag_buff.item)
					check
						success: l_res /= 0
					end
					tag := l_tag_buff
				end
			end
			l_res := {SSL_CRYPTO_EXTERNALS}.c_evp_cipher_ctx_reset (ctx)
			check
				success: l_res /= 0
			end
			if attached computed_value as l_value then
				l_value.append (l_result)
			end
			finalized := True
		end

	finalize_with_tag_hex_string (a_data: READABLE_STRING_8)
		local
			l_data: MANAGED_POINTER
		do
			create l_data.make_from_array ((create {BYTE_ARRAY_CONVERTER}.make_from_hex_string (a_data)).to_natural_8_array)
			finalize_with_tag (l_data)
		end

	finalize_with_tag (a_tag: MANAGED_POINTER)
		local
			l_res: INTEGER
		do
			l_res := {SSL_CRYPTO_EXTERNALS}.c_evp_cipher_ctx_ctrl (ctx, {SSL_CRYPTO_EXTERNALS}.C_EVP_CTRL_AEAD_SET_TAG, a_tag.count, a_tag.item)
			check
				success: l_res /= 0
			end
			tag := a_tag
			finalize
		end

	aad_hex_string (a_data: READABLE_STRING_8)
		local
			l_data: MANAGED_POINTER
		do
			create l_data.make_from_array ((create {BYTE_ARRAY_CONVERTER}.make_from_hex_string (a_data)).to_natural_8_array)
			authenticate_additional_data (l_data)
		end

	authenticate_additional_data (a_data: MANAGED_POINTER)
		local
			l_outlen: INTEGER
			l_res: INTEGER
		do
			l_res := {SSL_CRYPTO_EXTERNALS}.c_evp_cipherupdate (ctx, default_pointer, $l_outlen, a_data.item, a_data.count)
			check
				success: l_res /= 0
			end
		end

feature {NONE} -- Implementation

	computed_value: detachable MANAGED_POINTER
			-- Intermediate results of processing blocks.

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
			if attached {SSL_CIPHER_ALGORITHM} a_cipher as l_algo then
				create l_name.make_from_string (Cipher_name_template)
				l_name.replace_substring_all ("#cname", l_algo.name)
				l_name.replace_substring_all ("#key", l_algo.key_size.out)
				l_name.replace_substring_all ("#mname", a_mode.name)
				l_name.to_lower
				create c_name.make (l_name)
				Result := {SSL_CRYPTO_EXTERNALS}.c_evp_get_cipherbyname (c_name.item)
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
