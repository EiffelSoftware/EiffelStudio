note
	description: "Summary description for {TEST_RSA_LOW_LEVEL}."
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Simple Public Key Encryption with RSA and OpenSSL", "src=https://shanetully.com/2012/04/simple-public-key-encryption-with-rsa-and-openssl/", "protocol=uri"
	EIS: "name=Rsa tests", "src=https://github.com/openssl/openssl/blob/master/test/rsa_test.c", "protocol=uri"

class
	TEST_RSA_LOW_LEVEL

inherit

	EQA_TEST_SET


feature -- Test

	test_rsa_generate_key_encrypt_and_decrypt
		local
			l_rsa: POINTER
				-- RSA keypair.
			l_bne: POINTER
				-- BIGNUM
			l_bits: INTEGER

			l_priv: POINTER
			l_pub: POINTER
				-- BIO Private and public key	

			l_ret:  INTEGER

			l_priv_len: INTEGER
			l_pub_len: INTEGER

			l_priv_key: C_STRING
			l_pub_key: C_STRING

			l_encrypt: C_STRING
				-- Encrypted message
			l_decrypt: C_STRING
				-- Decrypted message
			l_msg: C_STRING
				-- Message to encrypt.	
			l_encrypt_len: INTEGER
		do
			l_bits := 2048
				-- 1 generate RSA key.
				-- Key Length
			l_bne := {SSL_CRYPTO_EXTERNALS}.c_bn_new
			assert ("Set_word success", {SSL_CRYPTO_EXTERNALS}.c_bn_set_word (l_bne, {SSL_CRYPTO_EXTERNALS}.rsa_f4) = 1)

			l_rsa := {SSL_CRYPTO_EXTERNALS}.c_rsa_new

			assert ("Generate RSA key success", {SSL_CRYPTO_EXTERNALS}.c_rsa_generate_key_ex (l_rsa, l_bits, l_bne, default_pointer) = 1)

				-- 2 save private and public key
			l_priv := {SSL_CRYPTO_EXTERNALS}.c_bio_new ({SSL_CRYPTO_EXTERNALS}.c_bio_s_mem)
			l_pub := {SSL_CRYPTO_EXTERNALS}.c_bio_new ({SSL_CRYPTO_EXTERNALS}.c_bio_s_mem)

			l_ret := {SSL_CRYPTO_EXTERNALS}.c_pem_write_bio_rsaprivatekey (l_priv, l_rsa, default_pointer, default_pointer, 0, default_pointer, default_pointer)
			l_ret := {SSL_CRYPTO_EXTERNALS}.c_pem_write_bio_rsapublickey (l_pub, l_rsa)


			l_priv_len := {SSL_CRYPTO_EXTERNALS}.c_bio_pending (l_priv)
			l_pub_len := {SSL_CRYPTO_EXTERNALS}.c_bio_pending (l_pub)


			create l_priv_key.make_empty (l_priv_len + 1)
			create l_pub_key.make_empty (l_pub_len + 1)

			l_ret := {SSL_CRYPTO_EXTERNALS}.c_bio_read (l_priv, l_priv_key.item, l_priv_len)
			l_ret := {SSL_CRYPTO_EXTERNALS}.c_bio_read (l_pub, l_pub_key.item, l_pub_len)


			print ("%N" + l_priv_key.string + "%N")
			print ("%N" + l_pub_key.string + "%N")

				-- Message to encrypt
			create l_msg.make ("Eiffel")

				-- Encrypt
			create l_encrypt.make_empty ({SSL_CRYPTO_EXTERNALS}.c_rsa_size (l_rsa))

			l_encrypt_len := {SSL_CRYPTO_EXTERNALS}.c_rsa_public_encrypt (l_msg.count + 1, l_msg.item, l_encrypt.item, l_rsa, {SSL_CRYPTO_EXTERNALS}.rsa_pkcs1_oaep_padding)
			assert ("Success RSA_public_encrypt", l_encrypt_len /= -1)

				-- Decrypt
			create l_decrypt.make_empty (l_encrypt_len)

			assert ("Success RSA_private_decrypt", {SSL_CRYPTO_EXTERNALS}.c_rsa_private_decrypt (l_encrypt_len, l_encrypt.item, l_decrypt.item, l_rsa, {SSL_CRYPTO_EXTERNALS}.rsa_pkcs1_oaep_padding) /= -1 )
			assert ("Decrypted Message", l_decrypt.string.same_string (l_msg.string))
		end
end
