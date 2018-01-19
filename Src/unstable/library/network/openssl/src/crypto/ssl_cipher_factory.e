note
	description: "Summary description for {SSL_CIPHER_FACTORY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SSL_CIPHER_FACTORY

feature -- GCM factory

	aes_128_gcm: SSL_CIPHER
			-- AES Galois Counter Mode (GCM) for 128
		do
			create Result.make_by_pointer ({SSL_CRYPTO_EXTERNALS}.c_evp_aes_128_gcm)
		end

	aes_256_gcm: SSL_CIPHER
			-- AES Galois Counter Mode (GCM) for 256
		do
			create Result.make_by_pointer ({SSL_CRYPTO_EXTERNALS}.c_evp_aes_256_gcm)
		end

	des_ofb: SSL_CIPHER
		do
			create Result.make_by_pointer ({SSL_CRYPTO_EXTERNALS}.c_evp_des_ofb)
		end



end
