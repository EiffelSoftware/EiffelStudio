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

	sign (a_priv_key: SSL_RSA_PRIVATE_KEY; a_message: READABLE_STRING_GENERAL): detachable STRING_8
			-- Create a signed digest in a Base64 encoded string
			--| Sing the message `a_message' with private key `a_priv_key'.
			--| Using the hash function `sha_256'. (todo support other Hashes).
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
		do
				-- https://www.openssl.org/docs/man1.1.0/crypto/EVP_DigestInit.html
			l_sign_ctx := {SSL_CRYPTO_EXTERNALS}.c_evp_md_ctx_new
			l_prikey := {SSL_CRYPTO_EXTERNALS}.c_evp_pkey_new

			l_res := {SSL_CRYPTO_EXTERNALS}.c_evp_pkey_assign_rsa (l_prikey, a_priv_key.rsa)
			if l_res = 0 then
				create last_error.make (({SSL_CRYPTO_EXTERNALS}.c_error_get_error))
			end

			if not has_error then
				l_res := {SSL_CRYPTO_EXTERNALS}.c_evp_digestsigninit (l_sign_ctx, default_pointer, {SSL_CRYPTO_EXTERNALS}.c_evp_sha256, default_pointer, l_prikey)
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
					create Result.make_from_string ((create {BASE64}).encoded_string (c_encmsg.string))
				end
			end

			{SSL_CRYPTO_EXTERNALS}.c_evp_md_ctx_free (l_sign_ctx)
		end

end
