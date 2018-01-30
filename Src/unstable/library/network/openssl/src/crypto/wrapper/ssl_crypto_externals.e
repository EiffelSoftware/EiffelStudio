note
	description: "Open SSL Crypto Externals"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=LibCrypto API", "src=https://wiki.openssl.org/index.php/Libcrypto_API", "protocol=uri"
	EIS: "name=EVP", "src=https://wiki.openssl.org/index.php/EVP", "protocol=uri"

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


	c_evp_des_ofb: POINTER
			-- Function DES_OFB.
			-- Return a pointer to an EVP_CIPHER.
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return EVP_des_ofb();"
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

end
