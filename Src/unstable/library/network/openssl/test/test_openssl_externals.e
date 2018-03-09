note
	description: "Summary description for {TEST_OPENSSL_EXTERNALS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_OPENSSL_EXTERNALS

inherit

	EQA_TEST_SET
		select
			default_create
		end
	SSL_SHARED
		rename
			default_create as dc_shared
		end
feature -- Test routines

	test_cipher_get_by_name
		local
			c_name: C_STRING
		do
			initialize_ssl
				-- DES
			create c_name.make ("DES")
			assert ("Not default pointer DES", {SSL_CRYPTO_EXTERNALS}.c_evp_get_cipherbyname (c_name.item) /= default_pointer)

				-- UNKOWN
			create c_name.make ("UNKOWN")
			assert ("default pointer UNKOWN", {SSL_CRYPTO_EXTERNALS}.c_evp_get_cipherbyname (c_name.item) = default_pointer)

			create c_name.make ("aes-256-gcm")
			assert ("default pointer AES-256-GCM", {SSL_CRYPTO_EXTERNALS}.c_evp_get_cipherbyname (c_name.item) /= default_pointer)

		end
end
