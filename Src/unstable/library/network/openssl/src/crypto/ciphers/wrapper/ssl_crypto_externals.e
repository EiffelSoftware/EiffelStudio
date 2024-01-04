note
	description: "Open SSL Crypto Externals"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=LibCrypto API", "src=https://wiki.openssl.org/index.php/Libcrypto_API", "protocol=uri"
	EIS: "name=EVP", "src=https://wiki.openssl.org/index.php/EVP", "protocol=uri"
	EIS: "name=BIO_s_mem", "src=https://www.openssl.org/docs/man1.1.0/crypto/BIO_s_mem.html", "protocol=uri"
	EIS: "name=BN_set_word", "src=https://www.openssl.org/docs/man1.1.0/crypto/BN_set_word.html", "protocol=uri"
	EIS: "name=Bio_pending", "src=https://www.openssl.org/docs/man1.1.0/crypto/BIO_pending.html", "protocol=uri"
	EIS: "name=Bio_read", "src=https://www.openssl.org/docs/man1.1.0/crypto/BIO_read.html", "protocol=uri"
	EIS: "name=RSA public encrypt/ private decrypt", "src=https://www.openssl.org/docs/man1.1.0/crypto/RSA_public_encrypt.html", "protocol=uri"

class
	SSL_CRYPTO_EXTERNALS

feature -- Ciphers Modes

	EVP_CIPH_STREAM_CIPHER: INTEGER = 0x0

	EVP_CIPH_ECB_MODE: INTEGER = 0x1

	EVP_CIPH_CBC_MODE: INTEGER = 0x2

	EVP_CIPH_CFB_MODE: INTEGER = 0x3

	EVP_CIPH_OFB_MODE: INTEGER = 0x4

	EVP_CIPH_CTR_MODE: INTEGER = 0x5

	EVP_CIPH_GCM_MODE: INTEGER = 0x6

	EVP_CIPH_CCM_MODE: INTEGER = 0x7

	EVP_CIPH_XTS_MODE: INTEGER = 0x10001

	EVP_CIPH_WRAP_MODE: INTEGER = 0x10002

	EVP_CIPH_OCB_MODE: INTEGER = 0x10003

	EVP_CIPH_MODE: INTEGER = 0xF000
			-- TODO: evaluate if this is better than create an external like
			-- c_evp_ciph_stream_cipher


	EVP_PKEY_RSA: INTEGER
		external
			"C inline use %"eif_openssl.h%""
		alias
			"EVP_PKEY_RSA"
		end

	EVP_MAX_IV_LENGTH: INTEGER
		external
			"C inline use %"eif_openssl.h%""
		alias
			"EVP_MAX_IV_LENGTH"
		end

	NID_sha256: INTEGER = 672
			-- defined as NID_sha256 672
			--| obj_mac.h

	NID_sha384: INTEGER =  673
			-- defined as NID_sha384 673
			--| obj_mac.h

	NID_sha512: INTEGER =  674
			-- #define NID_sha512 674
			--| obj_mac.h


	SHA256_DIGEST_LENGTH: INTEGER = 32
			-- define SHA256_DIGEST_LENGTH    32
			-- |sha.h		

	SHA384_DIGEST_LENGTH: INTEGER = 48
			-- define SHA384_DIGEST_LENGTH    48
			-- |sha.h		

	SHA512_DIGEST_LENGTH: INTEGER = 64
			-- define SHA512_DIGEST_LENGTH    64
			-- |sha.h		

feature -- Ciphers

	c_evp_aes_128_gcm: POINTER
			-- Function AES Galois Counter Mode (GCM) for 128.
			-- Return an pointer to an EVP_CIPHER.
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return EVP_aes_128_gcm();"
		end

	c_evp_aes_192_gcm: POINTER
			-- Function AES Galois Counter Mode (GCM) for 192.
			-- Return an pointer to an EVP_CIPHER.
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return EVP_aes_192_gcm();"
		end

	c_evp_aes_256_gcm: POINTER
			-- Function AES Galois Counter Mode (GCM) for 256.
			-- Return an pointer to an EVP_CIPHER.
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return EVP_aes_256_gcm();"
		end

	c_evp_aes_256_cbc: POINTER
			-- Function AES with a 256-bit key in CBC.
			-- Return an pointer to an EVP_CIPHER.
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return EVP_aes_256_cbc();"
		end

	c_evp_des_ofb: POINTER
			-- Function DES_OFB.
			-- Return a pointer to an EVP_CIPHER.
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return EVP_des_ofb();"
		end

	c_evp_md_ctx_new: POINTER
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return EVP_MD_CTX_new();"
		end

	c_evp_pkey_new: POINTER
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return EVP_PKEY_new();"
		end

	c_evp_sha256: POINTER
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return EVP_sha256();"
		end

	c_evp_sha384: POINTER
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return EVP_sha384();"
		end

	c_evp_sha512: POINTER
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return EVP_sha512();"
		end

feature -- Error

	c_error_get_error: NATURAL_64
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return ERR_get_error ();"
		end

feature -- Access

	c_evp_cipher_nid (a_cipher: POINTER): INTEGER
			--  int EVP_CIPHER_nid(const EVP_CIPHER *cipher);
			--	return the NID of a cipher when passed an EVP_CIPHER or EVP_CIPHER_CTX structure.
			--  The actual NID value is an internal value which may not have a corresponding OBJECT IDENTIFIER.
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return EVP_CIPHER_nid((const char *)$a_cipher);"
		end

	c_evp_get_cipherbyname (a_name: POINTER): POINTER
			-- const EVP_CIPHER *EVP_get_cipherbyname(const char *name);
			-- Return cipher algortihm using textual name as in openssl command line, void if cipher is unknown.
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return EVP_get_cipherbyname((const char *)$a_name);"
		end

	c_evp_cipher_block_size (a_cipher: POINTER): INTEGER
			-- int EVP_CIPHER_block_size(const EVP_CIPHER *cipher);
			-- Returns block size of the cipher.
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return EVP_CIPHER_block_size((const EVP_CIPHER *)$a_cipher);"
		end

	c_evp_cipher_key_length (a_cipher: POINTER): INTEGER
			-- int EVP_CIPHER_key_length(const EVP_CIPHER *cipher);
			-- Returns key length of the cipher.
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return EVP_CIPHER_key_length((const EVP_CIPHER *)$a_cipher);"
		end

	c_evp_cipher_iv_length (a_cipher: POINTER): INTEGER
			-- int EVP_CIPHER_iv_length(const EVP_CIPHER *cipher);
			-- Returns initialization vector length of the cipher
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return EVP_CIPHER_iv_length((const EVP_CIPHER *)$a_cipher);"
		end

	c_evp_cipher_flags (a_cipher: POINTER): NATURAL_64
			-- unsigned long EVP_CIPHER_flags(const EVP_CIPHER *cipher);
			-- Return cipher flags.
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return EVP_CIPHER_flags((const EVP_CIPHER *)$a_cipher);"
		end

	c_evp_cipher_mode (a_cipher: POINTER): INTEGER
			-- EVP_CIPHER_mode(e) (EVP_CIPHER_flags(e) & EVP_CIPH_MODE)
			-- Return cipher mode.
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return EVP_CIPHER_mode($a_cipher);"
		end

	c_evp_cipher_ctx_free (a_ctx: POINTER)
			-- void EVP_CIPHER_CTX_free(EVP_CIPHER_CTX *c);
			-- Cleans up cipher a_ctx and free.
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return EVP_CIPHER_CTX_free((EVP_CIPHER_CTX *)$a_ctx);"
		end

	c_evp_cipher_ctx_new: POINTER
			-- EVP_CIPHER_CTX *EVP_CIPHER_CTX_new(void);
			-- Create cipher context.
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return EVP_CIPHER_CTX_new();"
		end

	c_evp_cipher_ctx_set_padding (a_ctx: POINTER; a_pad: INTEGER): INTEGER
			-- Sets padding mode of the cipher.
			-- EVP_CIPHER_CTX_set_padding() enables or disables padding.
			-- This function should be called after the context is set up for encryption or decryption with EVP_EncryptInit_ex(), EVP_DecryptInit_ex() or EVP_CipherInit_ex().
			-- By default encryption operations are padded using standard block padding and the padding is checked and removed when decrypting.
			-- If the pad parameter is zero then no padding is performed, the total amount of data encrypted or decrypted must then be a multiple of the block size or an error will occur.
			-- int EVP_CIPHER_CTX_set_padding(EVP_CIPHER_CTX *c, int pad);
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return EVP_CIPHER_CTX_set_padding((EVP_CIPHER_CTX *)$a_ctx, (int)$a_pad);%T"
		end


	c_evp_cipher_ctx_set_key_length (a_ctx: POINTER; a_keylen: INTEGER): INTEGER
			--	int EVP_CIPHER_CTX_set_key_length(EVP_CIPHER_CTX *x, int keylen);
			--	EVP_CIPHER_CTX_set_key_length() sets the key length of the cipher ctx.
			-- If the cipher is a fixed length cipher then attempting to set the key length to any value other than the fixed value is an error.
		external
			"C inline use %"eif_openssl.h%""
		alias
			"[
				return EVP_CIPHER_CTX_set_key_length((EVP_CIPHER_CTX *)$a_ctx, (int)$a_keylen);
			]"
		end

	c_evp_cipherinit_ex (a_ctx: POINTER; a_cipher: POINTER; a_impl: POINTER; a_key: POINTER; a_iv: POINTER; a_enc: INTEGER): INTEGER
			--	int EVP_CipherInit_ex(EVP_CIPHER_CTX *ctx,
			--                                 const EVP_CIPHER *cipher, ENGINE *impl,
			--                                 const unsigned char *key,
			--                                 const unsigned char *iv, int enc);
			-- Functions that can be used for decryption or encryption. The operation performed depends on the value of the enc parameter.
			-- It should be set to 1 for encryption, 0 for decryption and -1 to leave the value unchanged (the actual value of 'enc' being supplied in a previous call).
		external
			"C inline use %"eif_openssl.h%""
		alias
			"[
				return EVP_CipherInit_ex((EVP_CIPHER_CTX *)$a_ctx, (const EVP_CIPHER *)$a_cipher, (ENGINE *)$a_impl,(const unsigned char *)$a_key, (const unsigned char *)$a_iv, (int)$a_enc);
			]"
		end

	c_evp_cipherupdate (a_ctx: POINTER; a_out: POINTER; a_outl: TYPED_POINTER [INTEGER]; a_in: POINTER; a_inl: INTEGER): INTEGER
			--			int EVP_CipherUpdate(EVP_CIPHER_CTX *ctx, unsigned char *out,int *outl, const unsigned char *in, int inl);
			--            EVP_CipherUpdate function that can be used for decryption or encryption. The operation performed depends on the value of the enc parameter.
			--            It should be set to 1 for encryption, 0 for decryption and -1 to leave the value unchanged (the actual value of 'enc' being supplied in a previous call).
		external
			"C inline use %"eif_openssl.h%""
		alias
			"[
				return EVP_CipherUpdate((EVP_CIPHER_CTX *)$a_ctx, (unsigned char *)$a_out, (int *)$a_outl, (const unsigned char *)$a_in, (int)$a_inl);
			]"
		end

	c_evp_cipherfinal_ex (a_ctx: POINTER; a_outm: POINTER; a_outl: TYPED_POINTER [INTEGER]): INTEGER
			-- int EVP_CipherFinal_ex(EVP_CIPHER_CTX *ctx, unsigned char *outm, int *outl);
			-- EVP_CipherFinal_ex function that can be used for decryption or encryption.
			-- The operation performed depends on the value of the enc parameter.
			-- It should be set to 1 for encryption, 0 for decryption and -1 to leave the value unchanged (the actual value of 'enc' being supplied in a previous call).
		external
			"C inline use %"eif_openssl.h%""
		alias
			"[
				return EVP_CipherFinal_ex((EVP_CIPHER_CTX *)$a_ctx, (unsigned char *)$a_outm, (int *)$a_outl);
			]"
		end

	c_evp_cipher_ctx_reset (a_ctx: POINTER): INTEGER
			--	int EVP_CIPHER_CTX_reset(EVP_CIPHER_CTX *c);
			--	EVP_CIPHER_CTX_reset() clears all information from a cipher context and free up any allocated memory associate with it, except the ctx itself.
			--	This function should be called anytime ctx is to be reused for another EVP_CipherInit() / EVP_CipherUpdate() / EVP_CipherFinal() series of calls.	
		external
			"C inline use %"eif_openssl.h%""
		alias
			"[
				return EVP_CIPHER_CTX_reset((EVP_CIPHER_CTX *)$a_ctx);
			]"
		end

	c_evp_cipher_ctx_ctrl (a_ctx: POINTER; a_type: INTEGER; a_arg: INTEGER; a_ptr: POINTER): INTEGER
			-- allows various cipher specific parameters to be determined and set.
			--	int EVP_CIPHER_CTX_ctrl(EVP_CIPHER_CTX *ctx, int type, int arg, void *ptr);
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return EVP_CIPHER_CTX_ctrl((EVP_CIPHER_CTX *)$a_ctx, (int)$a_type, (int) $a_arg, (void *) $a_ptr);"
		end

	c_evp_ctrl_aead_set_ivlen: INTEGER
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return EVP_CTRL_AEAD_SET_IVLEN"
		end

	c_evp_ctrl_aead_get_tag: INTEGER
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return EVP_CTRL_AEAD_GET_TAG"
		end

	c_evp_ctrl_aead_set_tag: INTEGER
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return EVP_CTRL_AEAD_SET_TAG"
		end

	c_evp_pkey_ctx_new_id (a_id: INTEGER; a_engine: POINTER): POINTER
			-- The EVP_PKEY_CTX_new_id() function allocates public key algorithm context using the algorithm specified by id `a_id' and ENGINE `a_engine'.
			-- It is normally used when no EVP_PKEY structure is associated with the operations, for example during parameter generation of key generation for some algorithms.
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return EVP_PKEY_CTX_new_id((int)$a_id, $a_engine);"
		end

	c_evp_pkey_ctx_free (a_ctx: POINTER)
			-- EVP_PKEY_CTX_free() frees up the context ctx. If ctx is NULL, nothing is done.
		external
			"C inline use %"eif_openssl.h%""
		alias
			"EVP_PKEY_CTX_free((EVP_PKEY_CTX *)$a_ctx);"
		end

	c_evp_pkey_keygen_init(a_ctx: POINTER): INTEGER
			-- The EVP_PKEY_keygen_init() function initializes a public key algorithm context using key pkey for a key generation operation.
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return EVP_PKEY_keygen_init((EVP_PKEY_CTX *)$a_ctx);"
		end

	c_evp_pkey_ctx_set_rsa_keygen_bits (a_ctx: POINTER; a_mbits: INTEGER): INTEGER
			-- The EVP_PKEY_CTX_set_rsa_keygen_bits() macro sets the RSA key length for RSA key generation to bits. If not specified 1024 bits is used.
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return EVP_PKEY_CTX_set_rsa_keygen_bits((EVP_PKEY_CTX *)$a_ctx, (int)$a_mbits);"
		end

	c_evp_pkey_keygen (a_ctx: POINTER; a_ppkey: TYPED_POINTER [POINTER]): INTEGER
			-- The EVP_PKEY_keygen() function performs a key generation operation, the generated key is written to ppkey.
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return EVP_PKEY_keygen((EVP_PKEY_CTX *)$a_ctx, (EVP_PKEY **)$a_ppkey);"
		end


	c_evp_pkey_size	(a_pkey: POINTER): INTEGER
			-- EVP_PKEY_size() returns the maximum size of a signature in bytes. The actual signature returned by EVP_SignFinal() may be smaller.
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return EVP_PKEY_size((EVP_PKEY *)$a_pkey);"
		end

	c_evp_sealinit (a_ctx: POINTER; a_type: POINTER; a_ek:TYPED_POINTER [POINTER]; a_eki: TYPED_POINTER [INTEGER]; a_iv: POINTER; a_pubk: TYPED_POINTER [POINTER]; a_npubk: INTEGER ): INTEGER
			-- EVP_SealInit() initializes a cipher context ctx for encryption with cipher type using a random secret key and IV. type is normally supplied by a function such as EVP_aes_256_cbc().
			-- The secret key is encrypted using one or more public keys, this allows the same encrypted data to be decrypted using any of the corresponding private keys.
			-- ek is an array of buffers where the public key encrypted secret key will be written, each buffer must contain enough room for the corresponding encrypted key: that is ek[i] must have room for EVP_PKEY_size(pubk[i]) bytes.
			-- The actual size of each encrypted secret key is written to the array ekl. pubk is an array of npubk public keys.

			-- The iv parameter is a buffer where the generated IV is written to. It must contain enough room for the corresponding cipher's IV, as determined by (for example) EVP_CIPHER_iv_length(type).

			-- If the cipher does not require an IV then the iv parameter is ignored and can be NULL.
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return EVP_SealInit((EVP_CIPHER_CTX *)$a_ctx, (const EVP_CIPHER *)$a_type, (unsigned char **)$a_ek, (int *)$a_eki, (unsigned char *)$a_iv, (EVP_PKEY **)$a_pubk, (int)$a_npubk);"
		end

	c_evp_sealupdate (a_ctx: POINTER; a_out: POINTER; a_outi: TYPED_POINTER [INTEGER]; a_in: POINTER; a_ini: INTEGER): INTEGER
			-- EVP_SealUpdate() encrypts ini bytes from the buffer in and writes the encrypted version to out.
			-- This function can be called multiple times to encrypt successive blocks of data.
			-- The amount of data written depends on the block alignment of the encrypted data: as a result the amount of data written may be anything from zero bytes to (inl + cipher_block_size - 1) so out should contain sufficient room.
			-- The actual number of bytes written is placed in outl. It also checks if in and out are partially overlapping, and if they are 0 is returned to indicate failure.
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return  EVP_SealUpdate((EVP_CIPHER_CTX *)$a_ctx, (unsigned char *)$a_out, (int *)$a_outi, (unsigned char *)$a_in, (int)$a_ini);"
		end

	c_evp_seal_final (a_ctx: POINTER; a_out: POINTER; a_outi: TYPED_POINTER [INTEGER]): INTEGER
			-- https://www.openssl.org/docs/man1.1.0/crypto/EVP_SealFinal.html
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return EVP_SealFinal((EVP_CIPHER_CTX *)$a_ctx, (unsigned char *)$a_out, (int *)$a_outi);"
		end

	c_evp_open_init (a_ctx: POINTER; a_type: POINTER; a_ek: POINTER; a_val: INTEGER; a_iv: POINTER; a_priv: POINTER): INTEGER
			-- EVP_OpenInit() initializes a cipher context a_ctx for decryption with cipher a_type.
			-- It decrypts the encrypted symmetric key of length a_val bytes passed in the a_ek parameter using the private key a_priv. The IV is supplied in the a_iv parameter.
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return EVP_OpenInit((EVP_CIPHER_CTX *)$a_ctx, (EVP_CIPHER *)$a_type, (unsigned char *)$a_ek, (int)$a_val, (unsigned char *)$a_iv, (EVP_PKEY *)$a_priv);"
		end

	c_evp_open_update (a_ctx: POINTER; a_out: POINTER; a_outi: TYPED_POINTER [INTEGER]; a_in: POINTER; a_ini: INTEGER): INTEGER
			-- https://www.openssl.org/docs/man1.1.0/crypto/EVP_OpenInit.html
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return EVP_OpenUpdate((EVP_CIPHER_CTX *)$a_ctx, (unsigned char *)$a_out, (int *)$a_outi, (unsigned char *)$a_in, (int)$a_ini);"
		end

	c_evp_open_final (a_ctx: POINTER; a_out: POINTER; a_outi: TYPED_POINTER [INTEGER]): INTEGER
			-- https://www.openssl.org/docs/man1.1.0/crypto/EVP_OpenInit.html
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return EVP_OpenFinal((EVP_CIPHER_CTX *)$a_ctx, (unsigned char *)$a_out, (int *)$a_outi);"
		end

	c_evp_pkey_assign_rsa (a_pkey: POINTER; a_key: POINTER): INTEGER
			-- https://www.openssl.org/docs/man1.1.0/crypto/EVP_PKEY_set1_RSA.html
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return EVP_PKEY_assign_RSA((EVP_PKEY *)$a_pkey, (RSA *)$a_key) ;"
		end

	c_evp_digestsigninit (a_ctx: POINTER; a_pctx: POINTER; a_type: POINTER; a_engine: POINTER; a_key: POINTER): INTEGER
			-- https://www.openssl.org/docs/man1.1.0/crypto/EVP_DigestSignInit.html
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return EVP_DigestSignInit((EVP_MD_CTX *)$a_ctx, (EVP_PKEY_CTX **)$a_pctx, (const EVP_MD *)$a_type, (ENGINE *)$a_engine, (EVP_PKEY *)$a_key);"
		end

	c_evp_digestsignupdate (a_ctx: POINTER; a_digest: POINTER; a_cnt: INTEGER): INTEGER
			-- https://www.openssl.org/docs/man1.1.0/crypto/EVP_DigestSignInit.html
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return EVP_DigestSignUpdate((EVP_MD_CTX *)$a_ctx, (const void *)$a_digest, (size_t)$a_cnt);"
		end

	c_evp_digestsignfinal (a_ctx: POINTER; a_signed: POINTER; a_count: TYPED_POINTER [INTEGER]): INTEGER
			-- https://www.openssl.org/docs/man1.1.0/crypto/EVP_DigestSignInit.html
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return EVP_DigestSignFinal((EVP_MD_CTX *)$a_ctx, (unsigned char *)$a_signed, (size_t *)$a_count);"
		end

	c_evp_digestverifyinit (a_ctx: POINTER; a_pctx: POINTER; a_type: POINTER; a_engine: POINTER; a_pkey: POINTER): INTEGER
			-- https://www.openssl.org/docs/man1.1.0/crypto/EVP_DigestVerifyInit.html
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return EVP_DigestVerifyInit((EVP_MD_CTX *)$a_ctx, (EVP_PKEY_CTX **)$a_pctx, (const EVP_MD *)$a_type, (ENGINE *)$a_engine, (EVP_PKEY *)$a_pkey);"
		end

	c_evp_digestverifyupdate(a_ctx: POINTER; a_d: POINTER; a_cnt: INTEGER): INTEGER
			-- https://www.openssl.org/docs/man1.1.0/crypto/EVP_DigestVerifyInit.html
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return EVP_DigestVerifyUpdate((EVP_MD_CTX *)$a_ctx, (const void *)$a_d, (size_t)$a_cnt);"
		end

	c_evp_digestverifyfinal(a_ctx: POINTER; a_sig: POINTER; a_siglen: INTEGER): INTEGER
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return EVP_DigestVerifyFinal((EVP_MD_CTX *)$a_ctx, (const unsigned char *)$a_sig, (size_t)$a_siglen);"
		end

	c_evp_digestverifyfinal_2(a_ctx: POINTER; a_sig: POINTER): INTEGER
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return EVP_DigestVerifyFinal((EVP_MD_CTX *)$a_ctx, (const unsigned char *)$a_sig, sizeof($a_sig));"
		end

	c_evp_md_ctx_free(a_ctx: POINTER)
			-- https://www.openssl.org/docs/man1.1.0/crypto/EVP_DigestInit.html
		external
			"C inline use %"eif_openssl.h%""
		alias
			"EVP_MD_CTX_free((EVP_MD_CTX *)$a_ctx);"
		end

	c_evp_digestinit_ex(a_ctx: POINTER; a_type: POINTER; a_impl: POINTER): INTEGER
			-- https://www.openssl.org/docs/man1.1.0/crypto/EVP_DigestInit.html
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return EVP_DigestInit_ex((EVP_MD_CTX *)$a_ctx, (const EVP_MD *)$a_type, (ENGINE *)$a_impl);"
		end

feature -- SHA

	c_sha256 (a_d: POINTER; a_n: INTEGER; a_md: POINTER)
		external
			"C inline use %"eif_openssl.h%""
		alias
			"SHA256((const unsigned char *)$a_d, (size_t)$a_n, (unsigned char *)$a_md);"
		end

feature -- RSA

	c_rsa_generate_key_ex (a_rsa: POINTER; a_bits: INTEGER; a_e: POINTER; a_cb: POINTER): INTEGER
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return RSA_generate_key_ex((RSA *)$a_rsa, (int)$a_bits, (BIGNUM *)$a_e, (BN_GENCB *)$a_cb);"
		end

	c_rsa_new: POINTER
			-- RSA_new() allocates and initializes an RSA structure. It is equivalent to calling RSA_new_method(NULL).
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return RSA_new();"
		end

	c_rsa_new_method (a_engine: POINTER): POINTER
			-- RSA_new_method() allocates and initializes an RSA structure so that engine will be used for the RSA operations.
			-- If engine is NULL, the default ENGINE for RSA operations is used, and if no default ENGINE is set,
			-- the RSA_METHOD controlled by RSA_set_default_method() is used.
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return RSA_new_method ($a_engine);"
		end


	RSA_F4: INTEGER
		external
			"C inline use %"eif_openssl.h%""
		alias
			"RSA_F4"
		end

	RSA_PKCS1_OAEP_PADDING: INTEGER
		external
			"C inline use %"eif_openssl.h%""
		alias
			"RSA_PKCS1_OAEP_PADDING"
		end

	RSA_PKCS1_PADDING: INTEGER
		external
			"C inline use %"eif_openssl.h%""
		alias
			"RSA_PKCS1_PADDING"
		end

	RSA_NO_PADDING: INTEGER
		external
			"C inline use %"eif_openssl.h%""
		alias
			"RSA_NO_PADDING"
		end

     c_rsa_public_encrypt (a_flen: INTEGER; a_from: POINTER; a_to: POINTER; a_rsa: POINTER; a_padding: INTEGER): INTEGER
			-- RSA_public_encrypt() encrypts the flen bytes at from (usually a session key) using the public key rsa and stores the ciphertext in to.
			-- to must point to RSA_size(rsa) bytes of memory.
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return RSA_public_encrypt((int)$a_flen, (const unsigned char *)$a_from, (unsigned char *)$a_to, (RSA *)$a_rsa, (int)$a_padding);"
		end

	c_rsa_private_decrypt (a_flen: INTEGER; a_from: POINTER; a_to: POINTER; a_rsa: POINTER; a_padding: INTEGER): INTEGER
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return RSA_private_decrypt((int)$a_flen, (const unsigned char *)$a_from, (unsigned char *)$a_to, (RSA *)$a_rsa, (int)$a_padding);"
		end

	c_rsa_size (a_rsa: POINTER): INTEGER
			-- RSA_size() returns the RSA modulus size in bytes. It can be used to determine how much memory must be allocated for an RSA encrypted value.
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return RSA_size((const RSA *)$a_rsa);"
		end

	c_set_rsaprivatekey	(a_key_buffer: POINTER): POINTER
			-- Call external PEM_read_bio_RSAPrivateKey
		external
			"C inline use %"eif_openssl.h%""
		alias
			"[
				BIO *kbio;
				RSA *rsa = NULL;
				kbio = BIO_new_mem_buf((void*)(const char *)$a_key_buffer, -1);
				rsa = PEM_read_bio_RSAPrivateKey(kbio, NULL, 0, NULL);
				BIO_free(kbio);
				return rsa;
			]"
		end

	c_set_rsapubkey (a_key_buffer: POINTER): POINTER
			-- Call external PEM_read_bio_RSAPublicKey
		external
			"C inline use %"eif_openssl.h%""
		alias
			"[
				BIO *kbio;
				RSA *rsa = NULL;
				kbio = BIO_new_mem_buf((void*)(const char *)$a_key_buffer, -1);
				rsa = PEM_read_bio_RSA_PUBKEY(kbio, NULL, 0, NULL);
				BIO_free(kbio);
				return rsa;
			]"
		end

	c_set_rsapublickey (a_key_buffer: POINTER): POINTER
			-- Call external PEM_read_bio_RSAPublicKey
		external
			"C inline use %"eif_openssl.h%""
		alias
			"[
				BIO *kbio;
				RSA *rsa = NULL;
				kbio = BIO_new_mem_buf((void*)(const char *)$a_key_buffer, -1);
				rsa = PEM_read_bio_RSAPublicKey(kbio, &rsa, NULL, NULL);
				BIO_free(kbio);
				return rsa;
			]"
		end

	c_rsa_sign (a_type: INTEGER; a_m: POINTER; a_m_len: INTEGER; a_sigret: POINTER; a_siglen: TYPED_POINTER [INTEGER]; a_rsa:  POINTER): INTEGER
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return RSA_sign((int)$a_type, (const unsigned char *)$a_m, (unsigned int)$a_m_len, (unsigned char *)$a_sigret, (unsigned int *)$a_siglen, (RSA *)$a_rsa);"
		end

	c_rsa_verify (a_type: INTEGER; a_m: POINTER; a_sigbuf: POINTER; a_siglen: INTEGER; a_rsa:  POINTER): INTEGER
		external
			"C inline use %"eif_openssl.h%""
		alias
		 	"return RSA_verify((int)$a_type, (const unsigned char *)$a_m, (unsigned int )sizeof($a_m), (unsigned char *)$a_sigbuf, (unsigned int) $a_siglen, (RSA *)$a_rsa);"
		end

	c_rsa_free (a_rsa: POINTER)
		external
			"C inline use %"eif_openssl.h%""
		alias
		 	"RSA_free((RSA *)$a_rsa);"
		end

feature -- BIGNUM

	c_bn_new: POINTER
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return BN_new();"
		end

	c_bn_set_word (a_bn: POINTER; a_w: INTEGER_64): INTEGER
			-- BN_set_word set a to the values 0, 1 and a_w respectively.
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return BN_set_word((BIGNUM *)$a_bn, (BN_ULONG)$a_w);"
		end

feature -- BIO

	c_bio_new_file (a_filename: POINTER; a_mode: POINTER): POINTER
			-- BIO_new_file() creates a new file BIO with mode mode the meaning of mode is the same as the stdio function fopen(). The BIO_CLOSE flag is set on the returned BIO.
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return BIO_new_file((const char *)$a_filename, (const char *)$a_mode);"
		end

	c_bio_new (a_type: POINTER): POINTER
			-- The BIO_new() function returns a new BIO using method type.
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return BIO_new((const BIO_METHOD *)$a_type);"
		end

	c_bio_s_mem: POINTER
			-- BIO_s_mem() return the memory BIO method function.
			-- A memory BIO is a source/sink BIO which uses memory for its I/O. Data written to a memory BIO is stored in a BUF_MEM structure which is extended as appropriate to accommodate the stored data.
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return BIO_s_mem();"
		end

	c_bio_s_secmem: POINTER
			-- BIO_s_secmem() is like BIO_s_mem() except that the secure heap is used for buffer storage.
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return BIO_s_secmem();"
		end

	c_pem_write_bio_rsaprivatekey (a_bp: POINTER; a_x: POINTER; a_enc: POINTER; a_kstr: POINTER; a_klen: INTEGER; a_cb: POINTER; a_u: POINTER): INTEGER
		external
			"C inline use %"eif_openssl.h%""
		alias
			"[
				return  PEM_write_bio_RSAPrivateKey((BIO *)$a_bp, (RSA *)$a_x, (const EVP_CIPHER *)$a_enc,
								(unsigned char *)$a_kstr, (int)$a_klen,
								(pem_password_cb *)$a_cb, (void *)$a_u);
			]"
		end

	c_pem_write_bio_rsapublickey (a_bp: POINTER; a_x: POINTER): INTEGER
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return PEM_write_bio_RSAPublicKey((BIO *)$a_bp, (RSA *)$a_x);"
		end


	c_pem_write_bio_pubkey (a_bp: POINTER; a_x: POINTER): INTEGER
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return PEM_write_bio_PUBKEY((BIO *)$a_bp, (RSA *)$a_x);"
		end


	c_pem_write_bio_private_key (a_bp: POINTER; a_x: POINTER; a_enc: POINTER; a_kstr: POINTER; a_klen: INTEGER; a_cb: POINTER; a_u: POINTER): INTEGER
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return PEM_write_bio_PrivateKey((BIO *)$a_bp, (EVP_PKEY *)$a_x, (const EVP_CIPHER *)$a_enc, (unsigned char *)$a_kstr, (int)$a_klen, (pem_password_cb *)$a_cb, (void *)$a_u);	;"
		end


	c_bio_pending (a_b: POINTER): INTEGER
			--Bio_pending return the number of pending characters in the BIOs read and write buffers.
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return BIO_pending((BIO *)$a_b); "
		end


	c_bio_read (a_b: POINTER; a_buf: POINTER; a_len: INTEGER): INTEGER
			-- BIO_read() attempts to read len bytes from BIO b and places the data in buf.
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return BIO_read((BIO *)$a_b, (void *)$a_buf, (int)$a_len); "
		end

	c_bio_free_all (a_b: POINTER)
			-- BIO_free_all() frees up an entire BIO chain, it does not halt if an error occurs freeing up an individual BIO in the chain. If a is NULL nothing is done.
		external
			"C inline use %"eif_openssl.h%""
		alias
			"BIO_free_all((BIO *)$a_b);"
		end

feature -- OpenSSL base64 encoding.

	c_base64_encode (buffer: POINTER; length:INTEGER): POINTER
		external
			"C inline use %"eif_openssl.h%""
		alias
			"[
				BIO *bio, *b64;
				BUF_MEM *bufferPtr;
				b64 = BIO_new(BIO_f_base64());
				bio = BIO_new(BIO_s_mem());
				bio = BIO_push(b64, bio);
				
				BIO_set_flags(bio, BIO_FLAGS_BASE64_NO_NL); //Ignore newlines - write everything in one line
				
				BIO_write(bio, $buffer, $length);
				BIO_flush(bio);
				BIO_get_mem_ptr(bio, &bufferPtr);
				BIO_set_close(bio, BIO_NOCLOSE);
				BIO_free_all(bio);
				return (*bufferPtr).data;
			]"
		end

note
	copyright: "Copyright (c) 1984-2024, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
