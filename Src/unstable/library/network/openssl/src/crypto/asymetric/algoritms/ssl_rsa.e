note
	description: "{SSL_RSA}."
	date: "$Date$"
	revision: "$Revision$"

class
	SSL_RSA


feature -- Access

	encrypt (a_message: READABLE_STRING_GENERAL; a_pub_key: SSL_KEY_PAIR): STRING_8
		local
			l_encrypt: C_STRING
				-- Encrypted message.
			l_encrypt_len: INTEGER
			l_msg: C_STRING
		do
				-- messsage to encrypt.
			create l_msg.make (a_message)

				-- Encrypt
			create l_encrypt.make_empty ({SSL_CRYPTO_EXTERNALS}.c_rsa_size (a_pub_key.rsa))

			l_encrypt_len := {SSL_CRYPTO_EXTERNALS}.c_rsa_public_encrypt (l_msg.count + 1, l_msg.item, l_encrypt.item, a_pub_key.rsa, {SSL_CRYPTO_EXTERNALS}.rsa_pkcs1_oaep_padding)
			check  Success_RSA_public_encrypt: l_encrypt_len /= -1 end
			create Result.make_from_string (l_encrypt.string)
		end

	decrypt (a_message: READABLE_STRING_GENERAL; a_priv_key: SSL_KEY_PAIR): STRING_8
		local
			l_decrypt: C_STRING
			l_msg: C_STRING

		do
				-- Encrypted message.
			create l_msg.make (a_message)

				-- Decrypt
			create l_decrypt.make_empty ({SSL_CRYPTO_EXTERNALS}.c_rsa_size (a_priv_key.rsa))

			check Success_RSA_private_decrypt: {SSL_CRYPTO_EXTERNALS}.c_rsa_private_decrypt ({SSL_CRYPTO_EXTERNALS}.c_rsa_size (a_priv_key.rsa), l_msg.item, l_decrypt.item, a_priv_key.rsa, {SSL_CRYPTO_EXTERNALS}.rsa_pkcs1_oaep_padding) /= -1 end
			create Result.make_from_string (l_decrypt.string)
		end


end
