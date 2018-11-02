note
	description: "Object Responsible to generate a public/private key pair"
	date: "$Date$"
	revision: "$Revision$"

class
	SSL_KEY_PAIR

create
	make

feature {NONE} -- Initialization

	make (a_size: INTEGER)
			-- Create an RSA pair (public/private key) with size `a_size'.
		require
			valid_size: a_size = 512 or else a_size = 1024 or else a_size = 2048 or a_size = 4096

		local
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
			l_temp: STRING
		do
			l_bits := a_size

				-- 1 generate RSA key.
				-- Key Length
			l_bne := {SSL_CRYPTO_EXTERNALS}.c_bn_new
			check Set_word_success: {SSL_CRYPTO_EXTERNALS}.c_bn_set_word (l_bne, {SSL_CRYPTO_EXTERNALS}.rsa_f4) = 1 end

			rsa := {SSL_CRYPTO_EXTERNALS}.c_rsa_new

			check Generate_RSA_key_success: {SSL_CRYPTO_EXTERNALS}.c_rsa_generate_key_ex (rsa, l_bits, l_bne, default_pointer) = 1 end

				-- 2 save private and public key
			l_priv := {SSL_CRYPTO_EXTERNALS}.c_bio_new ({SSL_CRYPTO_EXTERNALS}.c_bio_s_mem)
			l_pub := {SSL_CRYPTO_EXTERNALS}.c_bio_new ({SSL_CRYPTO_EXTERNALS}.c_bio_s_mem)

			l_ret := {SSL_CRYPTO_EXTERNALS}.c_pem_write_bio_rsaprivatekey (l_priv, rsa, default_pointer, default_pointer, 0, default_pointer, default_pointer)
			l_ret := {SSL_CRYPTO_EXTERNALS}.c_pem_write_bio_rsapublickey (l_pub, rsa)


			l_priv_len := {SSL_CRYPTO_EXTERNALS}.c_bio_pending (l_priv)
			l_pub_len := {SSL_CRYPTO_EXTERNALS}.c_bio_pending (l_pub)


			create l_priv_key.make_empty (l_priv_len + 1)
			create l_pub_key.make_empty (l_pub_len + 1)

			l_ret := {SSL_CRYPTO_EXTERNALS}.c_bio_read (l_priv, l_priv_key.item, l_priv_len)
			l_ret := {SSL_CRYPTO_EXTERNALS}.c_bio_read (l_pub, l_pub_key.item, l_pub_len)


			private_key := l_priv_key.string
			public_key := l_pub_key.string
		end

feature {NONE} -- RSA Implementation.

	rsa: POINTER
		-- rsa key pair.

feature -- Access

	private_key: STRING
		-- rsa private key.

	public_key: STRING
		-- rsa public key.

end
