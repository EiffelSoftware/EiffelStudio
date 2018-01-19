note
	description: "Summary description for {SSL_CRYPTO_TEST_SET}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SSL_CRYPTO_TEST_SET

inherit

	EQA_TEST_SET
		select
			default_create
		end
	SSL_SHARED
		rename
			default_create as dc_shared
		end

feature -- Test

	test_cipher_get_by_name
		local
			c_name: C_STRING
		do
				-- DES
			create c_name.make ("DES")
			assert ("Not default pointer DES", {SSL_CRYPTO_EXTERNALS}.c_evp_get_cipherbyname (c_name.item) /= default_pointer)

				-- UNKOWN
			create c_name.make ("UNKOWN")
			assert ("default pointer UNKOWN", {SSL_CRYPTO_EXTERNALS}.c_evp_get_cipherbyname (c_name.item) = default_pointer)

		end


	test_cipher_gcm
		local
			aes_128_gcm, aes_192_gcm, aes_256_gcm: POINTER
				-- cipher
		do
			initialize_ssl
			aes_128_gcm := {SSL_EVP}.c_evp_aes_128_gcm
			assert ("Expected GCM mode",{SSL_CRYPTO_EXTERNALS}.c_evp_cipher_mode (aes_128_gcm) = {SSL_CRYPTO_EXTERNALS}.evp_ciph_gcm_mode)

			assert ("Expected 12 bytes", {SSL_CRYPTO_EXTERNALS}.c_evp_cipher_iv_length (aes_128_gcm) = 12)
			assert ("Expected 16 bytes", {SSL_CRYPTO_EXTERNALS}.c_evp_cipher_key_length (aes_128_gcm) = 16)
			assert ("Expected 1 block", {SSL_CRYPTO_EXTERNALS}.c_evp_cipher_block_size (aes_128_gcm) = 1)

			aes_192_gcm := {SSL_EVP}.c_evp_aes_192_gcm
			assert ("Expected GCM mode",{SSL_CRYPTO_EXTERNALS}.c_evp_cipher_mode (aes_128_gcm) = {SSL_CRYPTO_EXTERNALS}.evp_ciph_gcm_mode)
			assert ("Expected 12 bytes", {SSL_CRYPTO_EXTERNALS}.c_evp_cipher_iv_length (aes_128_gcm) = 12)
			assert ("Expected 16 bytes", {SSL_CRYPTO_EXTERNALS}.c_evp_cipher_key_length (aes_128_gcm) = 16)
			assert ("Expected 1 block", {SSL_CRYPTO_EXTERNALS}.c_evp_cipher_block_size (aes_128_gcm) = 1)

			aes_256_gcm := {SSL_EVP}.c_evp_aes_256_gcm
			assert ("Expected GCM mode",{SSL_CRYPTO_EXTERNALS}.c_evp_cipher_mode (aes_256_gcm) = {SSL_CRYPTO_EXTERNALS}.evp_ciph_gcm_mode)
			assert ("Expected 12 bytes", {SSL_CRYPTO_EXTERNALS}.c_evp_cipher_iv_length (aes_128_gcm) = 12)
			assert ("Expected 16 bytes", {SSL_CRYPTO_EXTERNALS}.c_evp_cipher_key_length (aes_128_gcm) = 16)
			assert ("Expected 1 block", {SSL_CRYPTO_EXTERNALS}.c_evp_cipher_block_size (aes_128_gcm) = 1)
		end




end
