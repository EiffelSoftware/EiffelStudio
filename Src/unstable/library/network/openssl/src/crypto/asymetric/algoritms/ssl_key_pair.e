note
	description: "Object Responsible to generate a public/private key pair"
	date: "$Date$"
	revision: "$Revision$"

class
	SSL_KEY_PAIR

create
	make

feature {NONE} -- Initialization

	make_pcks1 (a_size: INTEGER)
			-- Create an RSA pair (public/private key) with size `a_size'.
			-- Using public key with PCKS1 format.
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

			l_key: POINTER
		do
			l_bits := a_size

				-- 1 generate RSA key.
				-- Key Length
			l_bne := {SSL_CRYPTO_EXTERNALS}.c_bn_new
			l_ret := {SSL_CRYPTO_EXTERNALS}.c_bn_set_word (l_bne, {SSL_CRYPTO_EXTERNALS}.rsa_f4)
			check sucess: l_ret = 1 end

			l_key := {SSL_CRYPTO_EXTERNALS}.c_rsa_new_method (default_pointer)

			l_ret := {SSL_CRYPTO_EXTERNALS}.c_rsa_generate_key_ex (l_key, l_bits, l_bne, default_pointer)
			check generate_rsa_key_success: l_ret = 1 end

				-- 2 save private and public key
			l_priv := {SSL_CRYPTO_EXTERNALS}.c_bio_new ({SSL_CRYPTO_EXTERNALS}.c_bio_s_mem)
			l_pub := {SSL_CRYPTO_EXTERNALS}.c_bio_new ({SSL_CRYPTO_EXTERNALS}.c_bio_s_mem)

			l_ret := {SSL_CRYPTO_EXTERNALS}.c_pem_write_bio_rsapublickey (l_pub, l_key)
			l_ret := {SSL_CRYPTO_EXTERNALS}.c_pem_write_bio_rsaprivatekey (l_priv, l_key, default_pointer, default_pointer, 0, default_pointer, default_pointer)


			l_priv_len := {SSL_CRYPTO_EXTERNALS}.c_bio_pending (l_priv)
			l_pub_len := {SSL_CRYPTO_EXTERNALS}.c_bio_pending (l_pub)


			create l_priv_key.make_empty (l_priv_len + 1)
			create l_pub_key.make_empty (l_pub_len + 1)

			l_ret := {SSL_CRYPTO_EXTERNALS}.c_bio_read (l_priv, l_priv_key.item, l_priv_len)
			l_ret := {SSL_CRYPTO_EXTERNALS}.c_bio_read (l_pub, l_pub_key.item, l_pub_len)

			private_key := l_priv_key.string
			public_key := l_pub_key.string

			{SSL_CRYPTO_EXTERNALS}.c_bio_free_all (l_priv)
			{SSL_CRYPTO_EXTERNALS}.c_bio_free_all (l_pub)
--			{SSL_CRYPTO_EXTERNALS}.c_rsa_free (l_key)
		end

	make (a_size: INTEGER)
			-- Create an RSA pair (public/private key) with size `a_size'.
			-- Public Key with PEM format.
		require
			valid_size: a_size = 512 or else a_size = 1024 or else a_size = 2048 or a_size = 4096

		local
			l_priv: POINTER
			l_pub: POINTER
				-- BIO Private and public key	

			l_ret:  INTEGER

			l_priv_len: INTEGER
			l_pub_len: INTEGER

			l_priv_key: C_STRING
			l_pub_key: C_STRING
			l_key: POINTER
		do
			l_key := generate_rsa_key (a_size)

				-- Extract private key as String
				-- Dump the IO to Memory
			l_priv := {SSL_CRYPTO_EXTERNALS}.c_bio_new ({SSL_CRYPTO_EXTERNALS}.c_bio_s_mem)
				-- Dump the KEY `l_key' to IO
			l_ret := {SSL_CRYPTO_EXTERNALS}.c_pem_write_bio_private_key (l_priv, l_key, default_pointer, default_pointer, 0, default_pointer, default_pointer)
				-- Retrieve the buffer len
			l_priv_len := {SSL_CRYPTO_EXTERNALS}.c_bio_pending (l_priv)
			create l_priv_key.make_empty (l_priv_len + 1)
				--  read the key from the buffer and put it into priv_key
			l_ret := {SSL_CRYPTO_EXTERNALS}.c_bio_read (l_priv, l_priv_key.item, l_priv_len)

				-- Extract public key as String
				-- Dump IO to Memory
			l_pub := {SSL_CRYPTO_EXTERNALS}.c_bio_new ({SSL_CRYPTO_EXTERNALS}.c_bio_s_mem)
				-- Dump the key `l_key' to IO
			l_ret := {SSL_CRYPTO_EXTERNALS}.c_pem_write_bio_pubkey (l_pub, l_key)
				-- Retrieve buffer len
			l_pub_len := {SSL_CRYPTO_EXTERNALS}.c_bio_pending (l_pub)

			create l_pub_key.make_empty (l_pub_len + 1)
				--  read the key from the buffer and put it into pub_key
			l_ret := {SSL_CRYPTO_EXTERNALS}.c_bio_read (l_pub, l_pub_key.item, l_pub_len)


			private_key := l_priv_key.string
			public_key := l_pub_key.string

			{SSL_CRYPTO_EXTERNALS}.c_bio_free_all (l_priv)
			{SSL_CRYPTO_EXTERNALS}.c_bio_free_all (l_pub)
--			{SSL_CRYPTO_EXTERNALS}.c_rsa_free (l_key)
		end

feature -- Access

	private_key: STRING
		-- rsa private key.

	public_key: STRING
		-- rsa public key.

feature {NONE} -- Implementation

	generate_rsa_key (a_size: INTEGER): POINTER
		local
			l_pkey_context: POINTER
				-- EVP_PKEY_CTX
			l_ret: INTEGER
		do
				-- https://www.openssl.org/docs/man1.1.0/crypto/EVP_PKEY_keygen.html
			l_pkey_context := {SSL_CRYPTO_EXTERNALS}.c_evp_pkey_ctx_new_id ({SSL_CRYPTO_EXTERNALS}.evp_pkey_rsa, default_pointer)

				-- int EVP_PKEY_keygen_init(EVP_PKEY_CTX *ctx);
			l_ret := {SSL_CRYPTO_EXTERNALS}.c_evp_pkey_keygen_init (l_pkey_context)

				-- EVP_PKEY_CTX_set_rsa_keygen_bits
				-- https://www.openssl.org/docs/man1.1.1/man3/EVP_PKEY_CTX_set_rsa_keygen_bits.html
			l_ret := {SSL_CRYPTO_EXTERNALS}.c_evp_pkey_ctx_set_rsa_keygen_bits (l_pkey_context, a_size)
			l_ret := {SSL_CRYPTO_EXTERNALS}.c_evp_pkey_keygen (l_pkey_context, $Result)
			{SSL_CRYPTO_EXTERNALS}.c_evp_pkey_ctx_free (l_pkey_context)
		end

;note
	copyright: "Copyright (c) 1984-2019, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
