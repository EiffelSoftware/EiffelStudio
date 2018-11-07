note
	description: "Object responsible to RSA_public_encrypt, RSA_private_decrypt - RSA public key cryptography"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=RSA", "src=https://www.openssl.org/docs/man1.1.0/crypto/RSA_public_encrypt.html", "protocol=uri"

class
	SSL_RSA

create
	make

feature {NONE} --Initialization
	make
		do
				-- default padding	
			padding := {SSL_CRYPTO_EXTERNALS}.rsa_pkcs1_oaep_padding
		end


	padding: INTEGER
			-- padding mode that was used to encrypt the data.

feature -- Error

	error_message: detachable STRING
			-- Error message.
		do
			if attached last_error as l_error then
				Result := l_error.error_reason
			end
		end

	has_error: BOOLEAN
			-- there was an error during the last operation?
		do
			Result := attached last_error
		end

	last_error: detachable SSL_ERROR
			-- Last SSL error, if any.

feature -- Status Report

	is_pcks1_padding: BOOLEAN
		do
			Result := padding = {SSL_CRYPTO_EXTERNALS}.rsa_pkcs1_padding
		end

	is_no_padding: BOOLEAN
		do
			Result := padding = {SSL_CRYPTO_EXTERNALS}.rsa_no_padding
		end

	is_pkcs1_oaep_padding: BOOLEAN
		do
			Result := padding = {SSL_CRYPTO_EXTERNALS}.rsa_pkcs1_oaep_padding
		end

	is_sslv23_padding: BOOLEAN
		do
			Result := padding = {SSL_CRYPTO_EXTERNALS}.rsa_sslv23_padding
		end

feature -- Element  Change.

	mark_pkcs1_padding
			-- PKCS #1 v1.5 padding. This currently is the most widely used mode.
		do
			padding := {SSL_CRYPTO_EXTERNALS}.rsa_pkcs1_padding
		ensure
			pckse_padding_set: padding = {SSL_CRYPTO_EXTERNALS}.rsa_pkcs1_padding
		end

	mark_no_padding
			-- This mode should only be used to implement cryptographically sound padding modes in the application code. Encrypting user data directly with RSA is insecure.
		do
			padding := {SSL_CRYPTO_EXTERNALS}.rsa_no_padding
		ensure
			no_padding_set: padding = {SSL_CRYPTO_EXTERNALS}.rsa_no_padding
		end

	marl_pkcs1_oaep_padding
			-- EME-OAEP as defined in PKCS #1 v2.0 with SHA-1, MGF1 and an empty encoding parameter. This mode is recommended for all new applications.
		do
			padding := {SSL_CRYPTO_EXTERNALS}.rsa_pkcs1_oaep_padding
		ensure
			pkcs1_oaep_padding_set: padding = {SSL_CRYPTO_EXTERNALS}.rsa_pkcs1_oaep_padding
		end

	mark_sslv23_padding
			-- PKCS #1 v1.5 padding with an SSL-specific modification that denotes that the server is SSL3 capable.
		do
			padding := {SSL_CRYPTO_EXTERNALS}.rsa_sslv23_padding
		ensure
			rsa_sslv23_padding_set: padding = {SSL_CRYPTO_EXTERNALS}.rsa_sslv23_padding
		end

feature -- Access: Public Encrypt - Private Decrypt

	public_encrypt (a_message: READABLE_STRING_GENERAL; a_pub_key: SSL_RSA_PUBLIC_KEY): STRING_8
			-- Encrypt message `a_message' with public key `a_pub_key'.
			--| public key encryption supports all the paddings.
		local
			l_encrypt: C_STRING
				-- Encrypted message.
			l_encrypt_len: INTEGER
			l_msg: C_STRING
		do
			last_error := Void

				-- messsage to encrypt.
			create l_msg.make (a_message)

				-- Encrypt
			create l_encrypt.make_empty ({SSL_CRYPTO_EXTERNALS}.c_rsa_size (a_pub_key.rsa))

			l_encrypt_len := {SSL_CRYPTO_EXTERNALS}.c_rsa_public_encrypt (l_msg.count + 1, l_msg.item, l_encrypt.item, a_pub_key.rsa, padding)
			if l_encrypt_len = -1 then
				create last_error.make (({SSL_CRYPTO_EXTERNALS}.c_error_get_error))
			end
			create Result.make_from_string ((create {BASE64}).encoded_string (l_encrypt.string))
		end

	private_decrypt (a_message: READABLE_STRING_8; a_priv_key: SSL_RSA_PRIVATE_KEY): STRING_8
			-- Decrypt message `a_message' with private key `a_priv_key'.
			--| decrypt with a private key.
		local
			l_decrypt: C_STRING
			l_msg: C_STRING
			l_res: INTEGER
			l_len: INTEGER
		do
			last_error := Void

			create l_msg.make ((create {BASE64}).decoded_string (a_message))

				-- Decrypt
			create l_decrypt.make_empty ({SSL_CRYPTO_EXTERNALS}.c_rsa_size (a_priv_key.rsa))

			l_len := {SSL_CRYPTO_EXTERNALS}.c_rsa_size (a_priv_key.rsa)

			l_res := {SSL_CRYPTO_EXTERNALS}.c_rsa_private_decrypt (l_len, l_msg.item, l_decrypt.item, a_priv_key.rsa, padding)
			if l_res = -1 then
				create last_error.make (({SSL_CRYPTO_EXTERNALS}.c_error_get_error))
			end
			create Result.make_from_string (l_decrypt.string)
		end

feature -- Sign

	sign_sha256 (a_priv_key: SSL_RSA_PRIVATE_KEY; a_message: READABLE_STRING_GENERAL): detachable STRING_8
			-- Create a signed digest in a Base64 encoded string using the hash function sha256
		do
			Result := sign_implementation (a_priv_key, a_message, {SSL_CRYPTO_EXTERNALS}.c_evp_sha256)
		end

	sign_sha384 (a_priv_key: SSL_RSA_PRIVATE_KEY; a_message: READABLE_STRING_GENERAL): detachable STRING_8
			-- Create a signed digest in a Base64 encoded string using the hash function sha384
		do
			Result := sign_implementation (a_priv_key, a_message, {SSL_CRYPTO_EXTERNALS}.c_evp_sha384)
		end

	sign_sha512 (a_priv_key: SSL_RSA_PRIVATE_KEY; a_message: READABLE_STRING_GENERAL): detachable STRING_8
			-- Create a signed digest in a Base64 encoded string using the hash function sha512
		do
			Result := sign_implementation (a_priv_key, a_message, {SSL_CRYPTO_EXTERNALS}.c_evp_sha512)
		end

feature -- Verify

	verify_sha256 (a_pub_key: SSL_RSA_PUBLIC_KEY; a_plain_text:READABLE_STRING_GENERAL; a_signature: READABLE_STRING_8): BOOLEAN
			-- Ensures that the signature matches the original code.
			-- Using the public key `a_pub_key' and the signature encoded in BASE64 with the origin text `a_plain_text'.
			-- usign the same algorithm as the author of the signature.
		do
			Result := verify_implementation (a_pub_key, a_plain_text, a_signature, {SSL_CRYPTO_EXTERNALS}.c_evp_sha256)
		end

	verify_sha384 (a_pub_key: SSL_RSA_PUBLIC_KEY; a_plain_text:READABLE_STRING_GENERAL; a_signature: READABLE_STRING_8): BOOLEAN
			-- Ensures that the signature matches the original code.
			-- Using the public key `a_pub_key' and the signature encoded in BASE64 with the origin text `a_plain_text'.
			-- usign the same algorithm as the author of the signature.
		do
			Result := verify_implementation (a_pub_key, a_plain_text, a_signature, {SSL_CRYPTO_EXTERNALS}.c_evp_sha384)
		end

	verify_sha512 (a_pub_key: SSL_RSA_PUBLIC_KEY; a_plain_text:READABLE_STRING_GENERAL; a_signature: READABLE_STRING_8): BOOLEAN
			-- Ensures that the signature matches the original code.
			-- Using the public key `a_pub_key' and the signature encoded in BASE64 with the origin text `a_plain_text'.
			-- usign the same algorithm as the author of the signature.
		do
			Result := verify_implementation (a_pub_key, a_plain_text, a_signature, {SSL_CRYPTO_EXTERNALS}.c_evp_sha512)
		end

feature {NONE} -- Implementation

	sign_implementation (a_priv_key: SSL_RSA_PRIVATE_KEY; a_message: READABLE_STRING_GENERAL; a_sha: POINTER): detachable STRING_8
			-- Create a signed digest in a Base64 encoded string
			--| Sing the message `a_message' with private key `a_priv_key'.
			--| Using the hash function `sha_256/sha_384/sha_512
			--| If the digital signature is ok, return it as Base64 encoded.
		local
			l_sign_ctx: POINTER
				-- EVP_MD_CTX*
			l_prikey: POINTER
				-- EVP_PKEY*
			l_res: INTEGER
			c_msg: C_STRING
			l_count: INTEGER
			c_encmsg: C_STRING
			l_base64: POINTER
			l_result: C_STRING
			l_data: STRING
		do
				-- https://www.openssl.org/docs/man1.1.0/crypto/EVP_DigestInit.html
			l_sign_ctx := {SSL_CRYPTO_EXTERNALS}.c_evp_md_ctx_new
			l_prikey := {SSL_CRYPTO_EXTERNALS}.c_evp_pkey_new

			l_res := {SSL_CRYPTO_EXTERNALS}.c_evp_pkey_assign_rsa (l_prikey, a_priv_key.rsa)
			if l_res = 0 then
				create last_error.make (({SSL_CRYPTO_EXTERNALS}.c_error_get_error))
			end

			if not has_error then
				l_res := {SSL_CRYPTO_EXTERNALS}.c_evp_digestsigninit (l_sign_ctx, default_pointer, a_sha, default_pointer, l_prikey)
				if l_res <= 0 then
					create last_error.make (({SSL_CRYPTO_EXTERNALS}.c_error_get_error))
				end
			end

			if not has_error then
				create c_msg.make (a_message)
				l_res := {SSL_CRYPTO_EXTERNALS}.c_evp_digestsignupdate (l_sign_ctx, c_msg.item, c_msg.count)
				if l_res <= 0 then
					create last_error.make (({SSL_CRYPTO_EXTERNALS}.c_error_get_error))
				end
			end

			if not has_error then
				l_res := {SSL_CRYPTO_EXTERNALS}.c_evp_digestsignfinal (l_sign_ctx, default_pointer, $l_count)
				if l_res <= 0 then
					create last_error.make (({SSL_CRYPTO_EXTERNALS}.c_error_get_error))
				end
			end

			if not has_error then
				create c_encmsg.make_empty (l_count)
				l_res := {SSL_CRYPTO_EXTERNALS}.c_evp_digestsignfinal (l_sign_ctx, c_encmsg.item, $l_count)
				if l_res <= 0 then
					create last_error.make (({SSL_CRYPTO_EXTERNALS}.c_error_get_error))
				else
						-- Build an string from the managed pointer
					create l_data.make (l_count)
					across c_encmsg.managed_data.read_array (0, l_count) as it loop
						l_data.append_character (it.item.to_character_8)
					end
                    Result := (create {BASE64}).encoded_string (l_data)

				   		-- Base64 encoding using OpenSSL http://doctrina.org/Base64-With-OpenSSL-C-API.html
				   	-- l_base64 := {SSL_CRYPTO_EXTERNALS}.c_base64_encode (c_encmsg.item, l_count)
				   	-- create l_result.make_by_pointer (l_base64)
				    -- Result := l_result.string
				end
			end

			{SSL_CRYPTO_EXTERNALS}.c_evp_md_ctx_free (l_sign_ctx)
		end

	verify_implementation (a_pub_key: SSL_RSA_PUBLIC_KEY; a_plain_text:READABLE_STRING_GENERAL; a_signature: READABLE_STRING_8; a_alg: POINTER): BOOLEAN
		local
			l_decoded_sig: STRING_8
			l_pubkey: POINTER
				-- EVP_KEY
			l_res: INTEGER
			l_verify_ctx: POINTER
				-- EVP_MD_CTX
			l_msg: C_STRING
			l_origin: C_STRING

			l_b64message: C_STRING
			l_buffer: C_STRING
			l_ret: INTEGER
			l_character: CHARACTER_8
		do
			Result := True

			l_decoded_sig :=(create {BASE64}).decoded_string (a_signature)
			l_pubkey := {SSL_CRYPTO_EXTERNALS}.c_evp_pkey_new
			l_res := {SSL_CRYPTO_EXTERNALS}.c_evp_pkey_assign_rsa (l_pubkey, a_pub_key.rsa)
			if l_res = 0 then
				create last_error.make (({SSL_CRYPTO_EXTERNALS}.c_error_get_error))
				Result := False
			end

			l_verify_ctx:= {SSL_CRYPTO_EXTERNALS}.c_evp_md_ctx_new
			l_res := {SSL_CRYPTO_EXTERNALS}.c_evp_digestinit_ex (l_verify_ctx, a_alg, default_pointer)
			if l_res /= 1 then
				create last_error.make (({SSL_CRYPTO_EXTERNALS}.c_error_get_error))
			end

			if not has_error then
				l_res := {SSL_CRYPTO_EXTERNALS}.c_evp_digestverifyinit (l_verify_ctx, default_pointer, a_alg, default_pointer, l_pubkey)
				if l_res <= 0 then
					create last_error.make (({SSL_CRYPTO_EXTERNALS}.c_error_get_error))
					Result := False
				end
			end
			if not has_error then
				create l_origin.make (a_plain_text)
				l_res := {SSL_CRYPTO_EXTERNALS}.c_evp_digestsignupdate (l_verify_ctx, l_origin.item, l_origin.count)
				if l_res <= 0 then
					create last_error.make (({SSL_CRYPTO_EXTERNALS}.c_error_get_error))
					Result := False
				end
			end

			if not has_error then
				create l_msg.make_empty ({SSL_CRYPTO_EXTERNALS}.c_rsa_size (a_pub_key.rsa))
				l_decoded_sig.append_character ('%U')
				l_msg.set_string (l_decoded_sig)
				l_res := {SSL_CRYPTO_EXTERNALS}.c_evp_digestverifyfinal (l_verify_ctx, l_msg.item, {SSL_CRYPTO_EXTERNALS}.c_rsa_size (a_pub_key.rsa))
				if l_res = 1 then
					Result := True
				elseif l_res = 0  then
					create last_error.make (({SSL_CRYPTO_EXTERNALS}.c_error_get_error))
					Result := False
				else
					create last_error.make (({SSL_CRYPTO_EXTERNALS}.c_error_get_error))
					Result := False
				end
			end
			{SSL_CRYPTO_EXTERNALS}.c_evp_md_ctx_free (l_verify_ctx)
		end

	verify_with_sha256_imp (a_text: READABLE_STRING_GENERAL; a_signed: READABLE_STRING_8; a_pub_key: SSL_RSA_PUBLIC_KEY): BOOLEAN
		local
			l_buffer: C_STRING
			l_message: C_STRING
			l_sign: C_STRING
			l_res: INTEGER
			l_temp: STRING
		do
			create l_buffer.make_empty ({SSL_CRYPTO_EXTERNALS}.SHA256_DIGEST_LENGTH)
			create l_message.make (a_text)
			{SSL_CRYPTO_EXTERNALS}.c_sha256 (l_message.item, l_message.count, l_buffer.item)

			l_temp := (create {BASE64}).decoded_string (a_signed)
			l_temp.append_character ('%U')
			create l_sign.make (l_temp)
			l_res := {SSL_CRYPTO_EXTERNALS}.c_rsa_verify ({SSL_CRYPTO_EXTERNALS}.nid_sha256, l_buffer.item, l_sign.item, {SSL_CRYPTO_EXTERNALS}.c_rsa_size (a_pub_key.rsa), a_pub_key.rsa);
			if l_res /= 1 then
				create last_error.make (({SSL_CRYPTO_EXTERNALS}.c_error_get_error))
			else
				Result := True
			end
		end


end
