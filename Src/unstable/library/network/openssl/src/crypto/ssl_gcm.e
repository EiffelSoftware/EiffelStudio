note
	description: "Object representing Galois/Counter Mode (GCM)  mode of operation for symmetric key cryptographic block ciphers"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Galois/Counter Mode", "src=https://en.wikipedia.org/wiki/Galois/Counter_Mode", "protocol=uri"
class
	SSL_GCM

feature -- Access

	decrypt (a_key: READABLE_STRING_8; a_iv: READABLE_STRING_8; a_tag: READABLE_STRING_8; a_text: READABLE_STRING_8; a_aad: detachable READABLE_STRING_8): READABLE_STRING_8
			-- key `a_key',  iv: `a_iv', tag: `a_tag' and text `a_text' are required fields, aad `a_aad' is optional.
		local
			l_key: MANAGED_POINTER
			l_iv: MANAGED_POINTER
			l_ct: MANAGED_POINTER
			l_tag: MANAGED_POINTER
			l_aad: MANAGED_POINTER
			l_converter: BYTE_ARRAY_CONVERTER
		do
				-- TODO aes gcm has 128, 192 and 256. at the moment using 256.
				-- we can add a new param algorithm <<128, 192 or 256).
				-- String Key
			create l_converter.make_from_hex_string (a_key)
			create l_key.make_from_array (l_converter.to_natural_8_array)

				--  String iv
			create l_converter.make_from_hex_string (a_iv)
			create l_iv.make_from_array (l_converter.to_natural_8_array)

				--  String authTag
			create l_converter.make_from_hex_string (a_tag)
			create l_tag.make_from_array (l_converter.to_natural_8_array)

				-- Encrypted text
			create l_converter.make_from_hex_string (a_text)
			create l_ct.make_from_array (l_converter.to_natural_8_array)

			if attached a_aad  then
				create l_converter.make_from_hex_string (a_aad)
				create l_aad.make_from_array (l_converter.to_natural_8_array)
			end

			Result := gcm_decrypt_impl (l_key, l_iv, l_tag, l_ct, l_aad)
		end


	encrypt (a_key: READABLE_STRING_8; a_iv: READABLE_STRING_8; a_text: READABLE_STRING_8; a_aad: detachable READABLE_STRING_8): READABLE_STRING_8
		local
			l_key: MANAGED_POINTER
			l_iv: MANAGED_POINTER
			l_aad: MANAGED_POINTER
			l_pt: MANAGED_POINTER
			l_converter: BYTE_ARRAY_CONVERTER
		do
				-- TODO need to be tested.
				-- String Key
			create l_converter.make_from_hex_string (a_key)
			create l_key.make_from_array (l_converter.to_natural_8_array)

				--  String iv
			create l_converter.make_from_hex_string (a_iv)
			create l_iv.make_from_array (l_converter.to_natural_8_array)

				-- Plain text
			create l_converter.make_from_hex_string (a_text)
			create l_pt.make_from_array (l_converter.to_natural_8_array)


			if attached a_aad  then
				create l_converter.make_from_hex_string (a_aad)
				create l_aad.make_from_array (l_converter.to_natural_8_array)
			end

			Result := gcm_encrypt_impl (l_key, l_iv, l_pt, l_aad)
		end


feature {NONE} -- Implementation

	gcm_decrypt_impl (a_key, a_iv, a_tag, a_ct: MANAGED_POINTER; a_aad: detachable MANAGED_POINTER): READABLE_STRING_8
		local
			l_ctx: POINTER --EVP_CIPHER_CTX
			l_outlen, l_tmplen: INTEGER
			l_outbuf: MANAGED_POINTER
			l_res: INTEGER
			l_index: INTEGER
			l_result : STRING_8
		do
			-- TODO add error handling.

			create l_outbuf.make_from_array (create {ARRAY [NATURAL_8]}.make_filled (0, 1, 1024))

				-- Initialize the context
			l_ctx := {SSL_EVP}.c_evp_cipher_ctx_new

				--    /* Select cipher */
				--    EVP_DecryptInit_ex(ctx, EVP_aes_256_gcm(), NULL, NULL, NULL);
			l_res := {SSL_EVP}.c_evp_decryptinit_ex (l_ctx, {SSL_EVP}.c_evp_aes_256_gcm, default_pointer, default_pointer, default_pointer)

				--    /* Set IV length, omit for 96 bits */
				--    EVP_CIPHER_CTX_ctrl(ctx, EVP_CTRL_AEAD_SET_IVLEN, sizeof(gcm_iv), NULL);
			l_res := {SSL_EVP}.c_evp_cipher_ctx_ctrl (l_ctx, {SSL_EVP}.c_evp_ctrl_aead_set_ivlen, a_iv.count, default_pointer)

				--    /* Specify key and IV */
				--    EVP_DecryptInit_ex(ctx, NULL, NULL, gcm_key, gcm_iv);
			l_res := {SSL_EVP}.c_evp_decryptinit_ex (l_ctx, default_pointer, default_pointer, a_key.item, a_iv.item)

				--    /* Zero or more calls to specify any AAD */
				--    EVP_DecryptUpdate(ctx, NULL, &outlen, gcm_aad, sizeof(gcm_aad));
			if attached a_aad then
				l_res := {SSL_EVP}.c_evp_decryptupdate (l_ctx, default_pointer, $l_outlen, a_aad.item, a_aad.count)
			end
				--    /* Decrypt plaintext */
				--    EVP_DecryptUpdate(ctx, outbuf, &outlen, gcm_ct, sizeof(gcm_ct));
				--    printf("Ciphertext:\n");
				--    BIO_dump_fp(stdout, gcm_ct, sizeof(gcm_ct));
			debug
				print ("Ciphertext: ")
				l_res := {SSL_EVP}.bio_dump_fp (io.output.file_pointer, a_ct.item, a_ct.count)
				io.put_new_line
			end

			l_res := {SSL_EVP}.c_evp_decryptupdate (l_ctx, l_outbuf.item, $l_outlen, a_ct.item, a_ct.count)

				--    /* Output decrypted block */
				--    printf("Plaintext:\n");
				--    BIO_dump_fp(stdout, outbuf, outlen);
			debug
				print ("Plain text: ")
				l_res := {SSL_EVP}.bio_dump_fp (io.output.file_pointer, l_outbuf.item, l_outlen)
				io.put_new_line
			end

				--    /* Set expected tag value. */
				--    EVP_CIPHER_CTX_ctrl(ctx, EVP_CTRL_AEAD_SET_TAG, sizeof(gcm_tag),
				--                        (void *)gcm_tag);
			l_res := {SSL_EVP}.c_evp_cipher_ctx_ctrl (l_ctx, {SSL_EVP}.c_evp_ctrl_aead_set_tag, a_tag.count, a_tag.item)

				--    /* Finalise: note get no output for GCM */
				--    rv = EVP_DecryptFinal_ex(ctx, outbuf, &outlen);
			l_tmplen := l_outlen
			l_res := {SSL_EVP}.c_evp_decryptfinal_ex (l_ctx, l_outbuf.item, $l_outlen)
				--    /*
				--     * Print out return value. If this is not successful authentication
				--     * failed and plaintext is not trustworthy.
				--     */
				--    printf("Tag Verify %s\n", rv > 0 ? "Successful!" : "Failed!");
			debug
				print ("Tag Verify: " + l_res.out)
			end
			create l_result.make_empty
			from
			until
				l_index > l_tmplen
			loop
				l_result.append_character (l_outbuf.read_character (l_index))
				l_index := l_index + 1
			end

			if l_result.item (l_result.count).code = 0 then
				l_result.remove_tail (1)
			end

			{SSL_EVP}.c_evp_cipher_ctx_free (l_ctx)

			Result := l_result
		end


	gcm_encrypt_impl (l_key, l_iv, l_pt: MANAGED_POINTER; l_aad: detachable MANAGED_POINTER): READABLE_STRING_8
		local
			l_ctx: POINTER --EVP_CIPHER_CTX
			l_outlen: INTEGER
			l_outbuf: MANAGED_POINTER
			l_res: INTEGER
			l_index: INTEGER
			l_tmplen: INTEGER
			l_result: STRING_8
		do
				-- TODO: test
			create l_outbuf.make_from_array (create {ARRAY [NATURAL_8]}.make_filled (0, 1, 1024))

				-- Initialize the context
			l_ctx := {SSL_EVP}.c_evp_cipher_ctx_new

				--    /* Set cipher type and mode */
				--    EVP_EncryptInit_ex(ctx, EVP_aes_256_gcm(), NULL, NULL, NULL);
			l_res := {SSL_EVP}.c_evp_encryptinit_ex (l_ctx, {SSL_EVP}.c_evp_aes_256_gcm, default_pointer,default_pointer,default_pointer)

				--    /* Set IV length if default 96 bits is not appropriate */
				--    EVP_CIPHER_CTX_ctrl(ctx, EVP_CTRL_AEAD_SET_IVLEN, sizeof(gcm_iv), NULL);
			l_res := {SSL_EVP}.c_evp_cipher_ctx_ctrl (l_ctx, {SSL_EVP}.c_evp_ctrl_aead_set_ivlen, l_iv.count, default_pointer)

				--    /* Initialise key and IV */
				--    EVP_EncryptInit_ex(ctx, NULL, NULL, gcm_key, gcm_iv);
			l_res := {SSL_EVP}.c_evp_encryptinit_ex (l_ctx, default_pointer, default_pointer, l_key.item, l_iv.item)

				--    /* Zero or more calls to specify any AAD */
				--    EVP_EncryptUpdate(ctx, NULL, &outlen, gcm_aad, sizeof(gcm_aad));
			if attached l_aad then
				l_res := {SSL_EVP}.c_evp_encryptupdate (l_ctx, default_pointer, $l_outlen, l_aad.item, l_aad.count)
			end

				--    /* Encrypt plaintext */
				--    EVP_EncryptUpdate(ctx, outbuf, &outlen, gcm_pt, sizeof(gcm_pt));
			debug
				print ("Plain Text: ")
				l_res := {SSL_EVP}.BIO_dump_fp (io.output.file_pointer, l_pt.item, l_pt.count)
				io.put_new_line
			end

			l_res := {SSL_EVP}.c_evp_encryptupdate (l_ctx, l_outbuf.item, $l_outlen, l_pt.item, l_pt.count)

				--    printf("Ciphertext:\n");
				--    BIO_dump_fp(stdout, outbuf, outlen);
			debug
				print ("Ciphertext: ")
				l_res := {SSL_EVP}.BIO_dump_fp (io.output.file_pointer, l_outbuf.item, l_outlen)
				io.put_new_line
			end

			l_tmplen := l_outlen
			--    /* Finalise: note get no output for GCM */
				--    EVP_EncryptFinal_ex(ctx, outbuf, &outlen);
			l_res := {SSL_EVP}.c_evp_encryptfinal_ex (l_ctx, l_outbuf.item, $l_outlen)

				--    /* Get tag */
				--    EVP_CIPHER_CTX_ctrl(ctx, EVP_CTRL_AEAD_GET_TAG, 16, outbuf);
			l_res := {SSL_EVP}.c_evp_cipher_ctx_ctrl (l_ctx, {SSL_EVP}.c_evp_ctrl_aead_get_tag,16, l_outbuf.item)

				-- To be check
			create l_result.make_empty
			from
			until
				l_index >= 16
			loop
				l_result.append_character (l_outbuf.read_character (l_index))
				l_index := l_index + 1
			end
			Result := l_result

			debug
				io.put_new_line
					-- tag
				print ("Tag: ")
				l_res := {SSL_EVP}.BIO_dump_fp (io.output.file_pointer, l_outbuf.item, 16)
			end
			{SSL_EVP}.c_evp_cipher_ctx_free (l_ctx)
		end

end
