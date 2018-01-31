note
	description: "[
		Object wrapping OpenSSL EVP interface
		The EVP functions provide a high level interface to OpenSSL cryptographic functions.
	]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name= wiki EVP interface", "src=https://wiki.openssl.org/index.php/EVP", "protocol=URI"
	EIS: "name= Doc EVP interface", "src=https://www.openssl.org/docs/man1.1.0/crypto/EVP_EncryptInit.html", "protocol=URI"

class
	SSL_EVP

feature -- C externals

	c_evp_cipher_ctx_new: POINTER
			-- EVP_CIPHER_CTX_new() creates a cipher context.
			-- returns a pointer to a newly created EVP_CIPHER_CTX for success and NULL for failure.
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return EVP_CIPHER_CTX_new();"
		end

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

	c_evp_decryptinit_ex (a_ctx: POINTER; a_type: POINTER; a_impl: POINTER; a_key: POINTER; a_iv: POINTER): INTEGER
			--	 int EVP_DecryptInit_ex(EVP_CIPHER_CTX *ctx, const EVP_CIPHER *type,
			--         ENGINE *impl, unsigned char *key, unsigned char *iv);
			--  return 1 for success and 0 for failure.
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return EVP_DecryptInit_ex((EVP_CIPHER_CTX *) $a_ctx, (const EVP_CIPHER *)$a_type, (ENGINE *)$a_impl, (unsigned char *)$a_key, (unsigned char *)$a_iv);"
		end


	c_evp_decryptinit (a_ctx: POINTER; a_type: POINTER; a_key: POINTER; a_iv: POINTER): INTEGER
			-- int EVP_DecryptInit(EVP_CIPHER_CTX *ctx, const EVP_CIPHER *cipher,
			--	const unsigned char *key, const unsigned char *iv);
			--  return 1 for success and 0 for failure.
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return EVP_DecryptInit((EVP_CIPHER_CTX *)$a_ctx, (const EVP_CIPHER *)$a_type, (const unsigned char *)$a_key, (const unsigned char *)$a_iv);"
		end

	c_evp_cipher_ctx_ctrl (a_ctx: POINTER; a_type: INTEGER; a_arg: INTEGER; a_ptr: POINTER): INTEGER
			-- allows various cipher specific parameters to be determined and set.
			--	int EVP_CIPHER_CTX_ctrl(EVP_CIPHER_CTX *ctx, int type, int arg, void *ptr);
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return EVP_CIPHER_CTX_ctrl((EVP_CIPHER_CTX *)$a_ctx, (int)$a_type, (int) $a_arg, (void *) $a_ptr);"
		end

	c_evp_ctrl_gcm_set_ivlen: INTEGER
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return EVP_CTRL_GCM_SET_IVLEN"
		end

	c_evp_ctrl_gcm_set_tag: INTEGER
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return EVP_CTRL_GCM_SET_TAG"
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


	c_evp_decryptupdate (a_ctx: POINTER; a_out: POINTER; a_outl: TYPED_POINTER [INTEGER]; a_in: POINTER; a_inl: INTEGER): INTEGER
			--	 int EVP_DecryptUpdate(EVP_CIPHER_CTX *ctx, unsigned char *out,
			--  int *outl, const unsigned char *in, int inl);
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return EVP_DecryptUpdate((EVP_CIPHER_CTX *)$a_ctx, (unsigned char *)$a_out, (int *)$a_outl, (const unsigned char *)$a_in, (int) $a_inl);"
		end

	c_evp_decryptfinal_ex (a_ctx: POINTER; a_outm: POINTER; a_outl: TYPED_POINTER [INTEGER]): INTEGER
			-- int EVP_DecryptFinal_ex(EVP_CIPHER_CTX *ctx, unsigned char *outm,
			--         int *outl);
		external
			"C inline use %"eif_openssl.h%""
		alias
			"[
				//return EVP_DecryptFinal_ex((EVP_CIPHER_CTX *)$a_ctx, (unsigned char *)$a_outm, (int *)$a_outl);
				return EVP_DecryptFinal_ex((EVP_CIPHER_CTX *)$a_ctx, NULL, (int *)$a_outl);
			  ]"
		end

	c_evp_decryptfinal (a_ctx: POINTER; a_outm: POINTER; a_outl: TYPED_POINTER [INTEGER]): INTEGER
			-- int EVP_DecryptFinal_ex(EVP_CIPHER_CTX *ctx, unsigned char *outm,
			--         int *outl);
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return EVP_DecryptFinal((EVP_CIPHER_CTX *)$a_ctx, (unsigned char *)$a_outm, (int *)$a_outl);"
		end

	c_evp_encryptinit_ex (a_ctx: POINTER;  a_cipher: POINTER; a_impl: POINTER;  a_key: POINTER; a_iv: POINTER): INTEGER
			--	int EVP_EncryptInit_ex(EVP_CIPHER_CTX *ctx,
			--                                  const EVP_CIPHER *cipher, ENGINE *impl,
			--                                  const unsigned char *key,
			--                                  const unsigned char *iv);	
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return EVP_EncryptInit_ex((EVP_CIPHER_CTX *)$a_ctx, (const EVP_CIPHER *)$a_cipher, (ENGINE *)$a_impl, (const unsigned char *)$a_key, (const unsigned char *)$a_iv);"
		end

	c_evp_encryptupdate	(a_ctx: POINTER; a_out: POINTER; a_outl: TYPED_POINTER [INTEGER]; a_in: POINTER; a_inl: INTEGER): INTEGER
			--	int EVP_EncryptUpdate(EVP_CIPHER_CTX *ctx, unsigned char *out,
			--                                 int *outl, const unsigned char *in, int inl);
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return EVP_EncryptUpdate((EVP_CIPHER_CTX *)$a_ctx, (unsigned char *)$a_out, (int *)$a_outl, (const unsigned char *)$a_in, (int)$a_inl);"
		end


	c_evp_encryptfinal_ex (a_ctx: POINTER; a_out: POINTER; a_outl: TYPED_POINTER [INTEGER]):INTEGER
			--	int EVP_EncryptFinal_ex(EVP_CIPHER_CTX *ctx, unsigned char *out,
			--                                   int *outl);	
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return EVP_EncryptFinal_ex((EVP_CIPHER_CTX *)$a_ctx, (unsigned char *)$a_out, (int *)$a_outl);"
		end

	c_evp_cipher_ctx_free (a_ctx: POINTER)
		external
			"C inline use %"eif_openssl.h%""
		alias
			"EVP_CIPHER_CTX_free($a_ctx);"
		end

	BIO_dump_fp (fp: POINTER; s: POINTER; len: INTEGER): INTEGER
		external
			"C inline use %"eif_openssl.h%""
		alias
			"return BIO_dump_fp((FILE *)$fp, (const char *)$s, (int)$len);"
		end
end
