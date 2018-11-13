note
	description: "[
		RSA encrypt/decrypt using EVP interface.
		Advantage: The EVP functions do implicit symmetric encryption for you so you don't get hung up on the max length limitations of RSA. Plus, it has an AES implementation.
	]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Example using RSA ", "src=https://stackoverflow.com/questions/9406840/rsa-encrypt-decrypt", "protocol=uri"
	EIS: "name=OpenSSL Wiki ", "src=https://wiki.openssl.org/index.php/EVP_Signing_and_Verifying", "protocol=uri"
	EIS: "name=OpenSSL, RSA, AES and C++", "src=https://shanetully.com/2012/06/openssl-rsa-aes-and-c/", "protocol=uri"

class
	TEST_RSA_EVP_LOW_LEVEL

inherit

	EQA_TEST_SET

feature -- Access

	test_rsa
			-- RSA encrypt/decrypt using EVP interface.
		local
			l_rsa_encrypt_ctx: POINTER
			l_rsa_decrypt_ctx: POINTER
				-- EVP_CIPHER_CTX

			l_remote_pub_key: POINTER

			l_message: C_STRING

			l_encrypted_key: C_STRING
			l_ec_ptr: POINTER

			l_iv: C_STRING
			l_encrypted_message: C_STRING
			l_encrypted_message2: C_STRING
			l_encrypted_message_length: INTEGER
			l_encrypted_key_length: INTEGER
			l_block_length: INTEGER

			l_decryped_message: C_STRING

			l_key: POINTER
		do
				-- Initialize Contexts
			l_rsa_encrypt_ctx := {SSL_CRYPTO_EXTERNALS}.c_evp_cipher_ctx_new
			l_rsa_decrypt_ctx := {SSL_CRYPTO_EXTERNALS}.c_evp_cipher_ctx_new
			check
				l_rsa_encrypt_ctx /= default_pointer
				l_rsa_decrypt_ctx /= default_pointer
			end

				-- Generate RSA keys
			l_remote_pub_key := generate_rsa_key

				-- Encrypt Message
			create l_message.make ("Eiffel")

			create l_encrypted_key.make_empty ({SSL_CRYPTO_EXTERNALS}.c_evp_pkey_size (l_remote_pub_key))
			create l_iv.make_empty ({SSL_CRYPTO_EXTERNALS}.evp_max_iv_length)
			create l_encrypted_message.make_empty (l_message.count + {SSL_CRYPTO_EXTERNALS}.evp_max_iv_length)
			l_ec_ptr := l_encrypted_key.item

			assert ("EVP_SealInit success", {SSL_CRYPTO_EXTERNALS}.c_evp_sealinit (l_rsa_encrypt_ctx,  {SSL_CRYPTO_EXTERNALS}.c_evp_aes_256_cbc, $l_ec_ptr, $l_encrypted_key_length, l_iv.item, $l_remote_pub_key, 1) /= 0)

			assert ("EVP_SealUpdate success", {SSL_CRYPTO_EXTERNALS}.c_evp_sealupdate (l_rsa_encrypt_ctx, l_encrypted_message.item, $l_block_length, l_message.item, l_message.count) /= 0)

--		    check same_block_size: {SSL_CRYPTO_EXTERNALS}.c_evp_cipher_block_size (l_rsa_encrypt_ctx) = l_block_length end

			l_encrypted_message_length := l_encrypted_message_length + l_block_length

			create l_encrypted_message2.make_by_pointer_and_count (l_encrypted_message.item, l_encrypted_message.count + l_encrypted_message_length)

			assert ("EVP_SealFinal success", {SSL_CRYPTO_EXTERNALS}.c_evp_seal_final (l_rsa_encrypt_ctx, l_encrypted_message2.item, $l_block_length) /= 0)

			l_encrypted_message_length :=  l_encrypted_message_length + l_block_length

				-- Decrypt Message
			create l_decryped_message.make_empty (l_encrypted_message_length + l_iv.string.count)
			l_key := l_remote_pub_key

			assert ("EVP_OpenInit success", {SSL_CRYPTO_EXTERNALS}.c_evp_open_init (l_rsa_decrypt_ctx, {SSL_CRYPTO_EXTERNALS}.c_evp_aes_256_cbc, l_encrypted_key.item, l_encrypted_key_length, l_iv.item, l_key) /= 0)

			l_block_length := 0
			assert ("EVP_OpenUpdate success", {SSL_CRYPTO_EXTERNALS}.c_evp_open_update (l_rsa_decrypt_ctx, l_decryped_message.item, $l_block_length, l_encrypted_message2.item, l_encrypted_message_length) /= 0)
			assert ("EVP_OpenFinal success", {SSL_CRYPTO_EXTERNALS}.c_evp_open_final (l_rsa_decrypt_ctx, l_decryped_message.item, $l_block_length) /= 0)
			assert ("Expected value: Eiffel", l_decryped_message.string.substring (1, l_block_length).same_string_general ("Eiffel"))
		end

	RSA_KEYLEN: INTEGER = 2048

feature {NONE} -- Implementation

	generate_rsa_key: POINTER
		local
			l_pkey_context: POINTER
				-- EVP_PKEY_CTX
		do
				-- https://www.openssl.org/docs/man1.1.0/crypto/EVP_PKEY_keygen.html
			l_pkey_context := {SSL_CRYPTO_EXTERNALS}.c_evp_pkey_ctx_new_id ({SSL_CRYPTO_EXTERNALS}.evp_pkey_rsa, default_pointer)

				-- int EVP_PKEY_keygen_init(EVP_PKEY_CTX *ctx);
			assert ("Keygen success", {SSL_CRYPTO_EXTERNALS}.c_evp_pkey_keygen_init (l_pkey_context) > 0)

				-- EVP_PKEY_CTX_set_rsa_keygen_bits
				-- https://www.openssl.org/docs/man1.1.1/man3/EVP_PKEY_CTX_set_rsa_keygen_bits.html
			assert ("Keygen rsa set success", {SSL_CRYPTO_EXTERNALS}.c_evp_pkey_ctx_set_rsa_keygen_bits (l_pkey_context, RSA_KEYLEN) > 0)
			assert ("Pkey keygen success", {SSL_CRYPTO_EXTERNALS}.c_evp_pkey_keygen (l_pkey_context, $Result) > 0)
			{SSL_CRYPTO_EXTERNALS}.c_evp_pkey_ctx_free (l_pkey_context)
		end

	message: STRING = "[
			Hola este es un mensaje
			para poder ser encryptado
		]"

end
