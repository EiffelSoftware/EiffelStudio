note
	description: "AES_GCM example based on C example https://github.com/openssl/openssl/blob/master/demos/evp/aesgcm.c"
	date: "$Date$"
	revision: "$Revision$"

class
	AES_GCM



feature -- Data

	gcm_key: ARRAY [NATURAL_8]
		do
			Result := {ARRAY [NATURAL_8]}<<0xee, 0xbc, 0x1f, 0x57, 0x48, 0x7f, 0x51, 0x92, 0x1c, 0x04, 0x65, 0x66,
    				   0x5f, 0x8a, 0xe6, 0xd1, 0x65, 0x8b, 0xb2, 0x6d, 0xe6, 0xf8, 0xa0, 0x69,
    					0xa3, 0x52, 0x02, 0x93, 0xa5, 0x72, 0x07, 0x8f
					>>
		end

	gcm_iv: ARRAY [NATURAL_8]
		do
			Result := {ARRAY[NATURAL_8]}<<0x99, 0xaa, 0x3e, 0x68, 0xed, 0x81, 0x73, 0xa0, 0xee, 0xd0, 0x66, 0x84>>
		end


	gcm_pt: ARRAY [NATURAL_8]
		do
			Result := {ARRAY [NATURAL_8]}<<0xf5, 0x6e, 0x87, 0x05, 0x5b, 0xc3, 0x2d, 0x0e, 0xeb, 0x31, 0xb2, 0xea,0xcc, 0x2b, 0xf2, 0xa5>>
		end

	gcm_aad: ARRAY [NATURAL_8]
		do
			Result := <<0x4d, 0x23, 0xc3, 0xce, 0xc3, 0x34, 0xb4, 0x9b, 0xdb, 0x37, 0x0c, 0x43,  0x7f, 0xec, 0x78, 0xde>>
		end

	gcm_ct: ARRAY [NATURAL_8]
		do
			Result := <<0xf7, 0x26, 0x44, 0x13, 0xa8, 0x4c, 0x0e, 0x7c, 0xd5, 0x36, 0x86, 0x7e,0xb9, 0xf2, 0x17, 0x36>>
		end

	gcm_tag: ARRAY [NATURAL_8]
		do
			Result := <<0x67, 0xba, 0x05, 0x10, 0x26, 0x2a, 0xe4, 0x87, 0xd7, 0x37, 0xee, 0x62,0x98, 0xf7, 0x7e, 0x0c>>
		end


feature -- Encypt - Decrypt


	gcm_encrypt
		local
			l_ctx: POINTER --EVP_CIPHER_CTX
			l_outlen, l_tmplen: INTEGER
			l_outbuf: MANAGED_POINTER
			l_res: INTEGER
			m_key: MANAGED_POINTER
			m_iv: MANAGED_POINTER
			m_aad: MANAGED_POINTER
			m_pt: MANAGED_POINTER
			l_index: INTEGER
		do
			create l_outbuf.make_from_array (create {ARRAY [NATURAL_8]}.make_filled (0, 1, 1024))

				-- Initialize the context
			l_ctx := {SSL_EVP}.c_evp_cipher_ctx_new

				--    /* Set cipher type and mode */
				--    EVP_EncryptInit_ex(ctx, EVP_aes_256_gcm(), NULL, NULL, NULL);
			l_res := {SSL_EVP}.c_evp_encryptinit_ex (l_ctx, {SSL_EVP}.c_evp_aes_256_gcm, default_pointer,default_pointer,default_pointer)

				--    /* Set IV length if default 96 bits is not appropriate */
				--    EVP_CIPHER_CTX_ctrl(ctx, EVP_CTRL_AEAD_SET_IVLEN, sizeof(gcm_iv), NULL);
			l_res := {SSL_EVP}.c_evp_cipher_ctx_ctrl (l_ctx, {SSL_EVP}.c_evp_ctrl_gcm_set_ivlen, gcm_iv.count, default_pointer)

				--    /* Initialise key and IV */
				--    EVP_EncryptInit_ex(ctx, NULL, NULL, gcm_key, gcm_iv);
			create m_key.make_from_array (gcm_key)
			create m_iv.make_from_array (gcm_iv)
			l_res := {SSL_EVP}.c_evp_encryptinit_ex (l_ctx, default_pointer, default_pointer, m_key.item, m_iv.item)

				--    /* Zero or more calls to specify any AAD */
				--    EVP_EncryptUpdate(ctx, NULL, &outlen, gcm_aad, sizeof(gcm_aad));
			create m_aad.make_from_array (gcm_aad)
			l_res := {SSL_EVP}.c_evp_encryptupdate (l_ctx, default_pointer, $l_outlen, m_aad.item, gcm_aad.count)

				--    /* Encrypt plaintext */
				--    EVP_EncryptUpdate(ctx, outbuf, &outlen, gcm_pt, sizeof(gcm_pt));
			create m_pt.make_from_array (gcm_pt)
			print ("Plain Text: ")
			l_res := {SSL_EVP}.BIO_dump_fp (io.output.file_pointer, m_pt.item, 16)
			io.put_new_line
			l_res := {SSL_EVP}.c_evp_encryptupdate (l_ctx, l_outbuf.item, $l_outlen, m_pt.item, gcm_pt.count)

				--    printf("Ciphertext:\n");
				--    BIO_dump_fp(stdout, outbuf, outlen);
			print ("Ciphertext: ")
			l_res := {SSL_EVP}.BIO_dump_fp (io.output.file_pointer, l_outbuf.item, l_outlen)
			io.put_new_line

				--    /* Finalise: note get no output for GCM */
				--    EVP_EncryptFinal_ex(ctx, outbuf, &outlen);
			l_res := {SSL_EVP}.c_evp_encryptfinal_ex (l_ctx, l_outbuf.item, $l_outlen)

				--    /* Get tag */
				--    EVP_CIPHER_CTX_ctrl(ctx, EVP_CTRL_AEAD_GET_TAG, 16, outbuf);
			l_res := {SSL_EVP}.c_evp_cipher_ctx_ctrl (l_ctx, {SSL_EVP}.c_evp_ctrl_aead_get_tag,16, l_outbuf.item)
			from
				l_index := 1
			until
				l_index > 16
			loop
				print (l_outbuf.read_natural_8 (l_index - 1))
				l_index := l_index + 1
			end
			io.put_new_line
				-- tag
			print ("Tag: ")
			l_res := {SSL_EVP}.BIO_dump_fp (io.output.file_pointer, l_outbuf.item, 16)
			{SSL_EVP}.c_evp_cipher_ctx_free (l_ctx)
		end

	gcm_decrypt
		local
			l_ctx: POINTER --EVP_CIPHER_CTX
			l_outlen, l_tmplen: INTEGER
			l_outbuf: MANAGED_POINTER
			l_res: INTEGER
			m_key: MANAGED_POINTER
			m_iv: MANAGED_POINTER
			m_aad: MANAGED_POINTER
			m_ct: MANAGED_POINTER
			l_index: INTEGER
			m_tag: MANAGED_POINTER
		do
			create l_outbuf.make_from_array (create {ARRAY [NATURAL_8]}.make_filled (0, 1, 1024))

				-- Initialize the context
			l_ctx := {SSL_EVP}.c_evp_cipher_ctx_new

				--    /* Select cipher */
				--    EVP_DecryptInit_ex(ctx, EVP_aes_256_gcm(), NULL, NULL, NULL);
			l_res := {SSL_EVP}.c_evp_decryptinit_ex (l_ctx, {SSL_EVP}.c_evp_aes_256_gcm, default_pointer, default_pointer, default_pointer)

				--    /* Set IV length, omit for 96 bits */
				--    EVP_CIPHER_CTX_ctrl(ctx, EVP_CTRL_AEAD_SET_IVLEN, sizeof(gcm_iv), NULL);
			l_res := {SSL_EVP}.c_evp_cipher_ctx_ctrl (l_ctx, {SSL_EVP}.c_evp_ctrl_aead_set_ivlen, gcm_iv.count, default_pointer)

				--    /* Specify key and IV */
				--    EVP_DecryptInit_ex(ctx, NULL, NULL, gcm_key, gcm_iv);
			create m_key.make_from_array (gcm_key)
			create m_iv.make_from_array (gcm_iv)
			l_res := {SSL_EVP}.c_evp_decryptinit_ex (l_ctx, default_pointer, default_pointer, m_key.item, m_iv.item)


				--    /* Zero or more calls to specify any AAD */
				--    EVP_DecryptUpdate(ctx, NULL, &outlen, gcm_aad, sizeof(gcm_aad));
			create m_aad.make_from_array (gcm_aad)
			l_res := {SSL_EVP}.c_evp_decryptupdate (l_ctx, default_pointer, $l_outlen, m_aad.item, gcm_aad.count)


				--    /* Decrypt plaintext */
				--    EVP_DecryptUpdate(ctx, outbuf, &outlen, gcm_ct, sizeof(gcm_ct));
			create m_ct.make_from_array (gcm_ct)
				--    printf("Ciphertext:\n");
				--    BIO_dump_fp(stdout, gcm_ct, sizeof(gcm_ct));
			print ("Ciphertext: ")
			l_res := {SSL_EVP}.bio_dump_fp (io.output.file_pointer, m_ct.item, gcm_ct.count)
			io.put_new_line

			l_res := {SSL_EVP}.c_evp_decryptupdate (l_ctx, l_outbuf.item, $l_outlen, m_ct.item, gcm_ct.count)

				--    /* Output decrypted block */
				--    printf("Plaintext:\n");
				--    BIO_dump_fp(stdout, outbuf, outlen);
			print ("Plain text: ")
			l_res := {SSL_EVP}.bio_dump_fp (io.output.file_pointer, l_outbuf.item, l_outlen)
			io.put_new_line

				--    /* Set expected tag value. */
				--    EVP_CIPHER_CTX_ctrl(ctx, EVP_CTRL_AEAD_SET_TAG, sizeof(gcm_tag),
				--                        (void *)gcm_tag);
			create m_tag.make_from_array (gcm_tag)
			l_res := {SSL_EVP}.c_evp_cipher_ctx_ctrl (l_ctx, {SSL_EVP}.c_evp_ctrl_aead_set_tag, gcm_tag.count, m_tag.item)

				--    /* Finalise: note get no output for GCM */
				--    rv = EVP_DecryptFinal_ex(ctx, outbuf, &outlen);
			l_res := {SSL_EVP}.c_evp_decryptfinal_ex (l_ctx, l_outbuf.item, $l_outlen)
			--    /*
			--     * Print out return value. If this is not successful authentication
			--     * failed and plaintext is not trustworthy.
			--     */
			--    printf("Tag Verify %s\n", rv > 0 ? "Successful!" : "Failed!");

			print ("Tag Verify: " + l_res.out)
			{SSL_EVP}.c_evp_cipher_ctx_free (l_ctx)

		end



end
