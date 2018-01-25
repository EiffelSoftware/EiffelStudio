note
	description: "Summary description for {EXAMPLE_GCM}."
	date: "$Date$"
	revision: "$Revision$"

class
	EXAMPLE_GCM

create
	make
feature -- Initialization

	make
			-- Authenticated Decryption using GCM mode (128)
		local
			l_ctx: POINTER -- EVP_CIPHER_CTX
			l_cipher: POINTER -- EVP_CIPHER
			l_key: STRING
			l_iv: STRING
			l_tag: STRING
			l_encripted_text: STRING
			c_key: C_STRING
			c_iv: C_STRING
			c_tag: C_STRING
			c_encripted_text: C_STRING
			l_res: INTEGER
			l_output: MANAGED_POINTER
			l_outl: INTEGER
			l_bytes: INTEGER
		do

				-- Create and initialise the context
			l_ctx := {SSL_EVP}.c_evp_cipher_ctx_new
				-- Select cipher
			l_cipher := {SSL_EVP}.c_evp_aes_128_gcm

			-- Initialise the decryption operation.
			l_res := {SSL_EVP}.c_evp_decryptinit_ex (l_ctx, l_cipher, default_pointer, default_pointer, default_pointer)
			l_bytes := 0

				-- data
			l_key := "000102030405060708090a0b0c0d0e0f000102030405060708090a0b0c0d0e0f"
			l_iv := "000000000000000000000000"
			l_tag := "CE573FB7A41AB78E743180DC83FF09BD"
			l_encripted_text := "0A3471C72D9BE49A8520F79C66BBD9A12FF9"

			create c_key.make (l_key)
			create c_iv.make (l_iv)
			create c_tag.make (l_tag)
			create c_encripted_text.make (l_encripted_text)

			l_res := {SSL_EVP}.c_evp_cipher_ctx_ctrl (l_ctx, {SSL_EVP}.C_EVP_CTRL_GCM_SET_IVLEN, 16, default_pointer)
			l_res := {SSL_EVP}.c_evp_decryptinit_ex (l_ctx, default_pointer, default_pointer,c_key.item, c_iv.item )
			l_res := {SSL_EVP}.c_evp_cipher_ctx_ctrl (l_ctx, {SSL_EVP}.C_EVP_CTRL_GCM_SET_TAG, 16, c_tag.item)


			create l_output.make_from_array (create {ARRAY [NATURAL_8]}.make_filled (0, 1, 1024))

			l_res := {SSL_EVP}.c_evp_decryptupdate (l_ctx, l_output.item, $l_outl, c_encripted_text.item, c_encripted_text.bytes_count)
			l_output.put_integer_32 (l_outl, l_output.natural_8_bytes)
			l_res := {SSL_EVP}.c_evp_decryptfinal_ex (l_ctx, l_output.item, $l_outl)

			{SSL_EVP}.c_evp_cipher_ctx_free (l_ctx)

		end


--        // Data from configuration
--        String keyFromConfiguration = "000102030405060708090a0b0c0d0e0f000102030405060708090a0b0c0d0e0f";
--
--        // Data from server
--        String ivFromHttpHeader = "000000000000000000000000";
--        String authTagFromHttpHeader = "CE573FB7A41AB78E743180DC83FF09BD";
--        String httpBody = "0A3471C72D9BE49A8520F79C66BBD9A12FF9";
--
--        // Convert data to process
--        byte[] key = DatatypeConverter.parseHexBinary(keyFromConfiguration);
--        byte[] iv = DatatypeConverter.parseHexBinary(ivFromHttpHeader);
--        byte[] authTag = DatatypeConverter.parseHexBinary(authTagFromHttpHeader);
--        byte[] encryptedText = DatatypeConverter.parseHexBinary(httpBody);




--/ decrypt ciphertext.
--// key, ivec and tag buffers are required, aad is optional
--// depending on your use, you may want to convert key, ivec, and tag to NSData/NSMutableData
--+ (BOOL) aes256gcmDecrypt:(NSData*)ciphertext
--                plaintext:(NSMutableData**)plaintext
--                      aad:(NSData*)aad
--                      key:(const unsigned char *)key
--                     ivec:(const unsigned char *)ivec
--                      tag:(unsigned char *)tag {

--    int status = 0;

--    if (! ciphertext || !plaintext || !key || !ivec)
--        return NO;

--    *plaintext = [NSMutableData dataWithLength:[ciphertext length]];
--    if (! *plaintext)
--        return NO;

--    // set up to Decrypt AES 256 GCM
--    int numberOfBytes = 0;
--    EVP_CIPHER_CTX *ctx = EVP_CIPHER_CTX_new();
--    EVP_DecryptInit_ex (ctx, EVP_aes_256_gcm(), NULL, NULL, NULL);

--    // set the key and ivec
--    EVP_CIPHER_CTX_ctrl(ctx, EVP_CTRL_GCM_SET_IVLEN, AES_256_IVEC_LENGTH, NULL);
--    status = EVP_DecryptInit_ex (ctx, NULL, NULL, key, ivec);

--    // Set expected tag value. A restriction in OpenSSL 1.0.1c and earlier requires the tag before any AAD or ciphertext
--    if (status && tag)
--        EVP_CIPHER_CTX_ctrl(ctx, EVP_CTRL_GCM_SET_TAG, AES_256_GCM_TAG_LENGTH, tag);

--    // add optional AAD (Additional Auth Data)
--    if (aad)
--        EVP_DecryptUpdate(ctx, NULL, &numberOfBytes, [aad bytes], [aad length]);

--    status = EVP_DecryptUpdate (ctx, [*plaintext mutableBytes], &numberOfBytes, [ciphertext bytes], (int)[ciphertext length]);
--    if (! status) {
--        //DDLogError(@"aes256gcmDecrypt: EVP_DecryptUpdate failed");
--        return NO;
--    }
--    EVP_DecryptFinal_ex (ctx, NULL, &numberOfBytes);
--    EVP_CIPHER_CTX_free(ctx);
--    return (status != 0); // OpenSSL uses 1 for success
--}

end
