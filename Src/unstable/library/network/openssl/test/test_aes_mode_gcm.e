note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"
	EIS: "name=AES test cases","src=https://github.com/pyca/cryptography/blob/master/tests/hazmat/primitives/test_aes.py", "protocol=uri"

class
	TEST_AES_MODE_GCM

inherit
	EQA_TEST_SET

feature -- Test routines


	test_gcm_ciphertext_with_no_aad
		local
			cipher: SSL_CIPHER
			l_algo: SSL_AES
			l_mode: SSL_GCM_MODE
			l_encryptor: SSL_CIPHER_CONTEXT
			l_computed_ct: MANAGED_POINTER
			l_index: INTEGER
			l_value: STRING
			byte_array: BYTE_ARRAY_CONVERTER
		do
				-- Code in Python
				--	 def test_gcm_ciphertext_with_no_aad(self, backend):
				--        key = binascii.unhexlify(b"e98b72a9881a84ca6b76e0f43e68647a")
				--        iv = binascii.unhexlify(b"8b23299fde174053f3d652ba")
				--        ct = binascii.unhexlify(b"5a3c1cf1985dbb8bed818036fdd5ab42")
				--        tag = binascii.unhexlify(b"23c7ab0f952b7091cd324835043b5eb5")
				--        pt = binascii.unhexlify(b"28286a321293253c3e0aa2704a278032")
				--        cipher = base.Cipher(
				--            algorithms.AES(key),
				--            modes.GCM(iv),
				--            backend=backend
				--        )
				--        encryptor = cipher.encryptor()
				--        computed_ct = encryptor.update(pt) + encryptor.finalize()
				--        assert computed_ct == ct
				--        assert encryptor.tag == tag


			create l_algo.make ("e98b72a9881a84ca6b76e0f43e68647a")
			create l_mode.make ("8b23299fde174053f3d652ba", Void)
			create cipher.make (l_algo, l_mode)
			l_encryptor := cipher.encryptor
			l_computed_ct := l_encryptor.update (create {MANAGED_POINTER}.make_from_array ((create {BYTE_ARRAY_CONVERTER}.make_from_hex_string ("28286a321293253c3e0aa2704a278032")).to_natural_8_array))
			l_computed_ct.append (l_encryptor.finalize)

				-- check ct
			create byte_array.make (l_computed_ct.count)
			byte_array.append_bytes (l_computed_ct.read_array (0, l_computed_ct.count))
			l_value := byte_array.to_hex_string
			l_value.to_lower
			assert ("Expected ct:5a3c1cf1985dbb8bed818036fdd5ab42",l_value.same_string_general ("5a3c1cf1985dbb8bed818036fdd5ab42"))

				-- check tag
			if
				attached {SSL_AEAD_ENCRYPTION_CONTEXT} l_encryptor as l_encryptor_tag and then
				attached l_encryptor_tag.tag as l_tag
			then
				create byte_array.make (l_tag.count)
				byte_array.append_bytes (l_tag.read_array (0, l_tag.count))
				l_value := byte_array.to_hex_string
				l_value.to_lower
				assert ("Expected tag:23c7ab0f952b7091cd324835043b5eb5",l_value.same_string_general ("23c7ab0f952b7091cd324835043b5eb5"))
			else
				assert ("Expected tag", False)
			end
		end

	test_aes_decryption_acaptureservices
		note
			eis: "name=acaptureservices example", "src=https://docs.acaptureservices.com/tutorials/webhooks/decryption-example","protocol=uri"
		local
			l_cipher: SSL_CIPHER
			l_cipher_external: SSL_CIPHER_CONTEXT_EXTERNALS
			l_result: MANAGED_POINTER
			l_index: INTEGER
			l_value: STRING
		do
			create l_cipher.make (create {SSL_AES}.make ("000102030405060708090a0b0c0d0e0f000102030405060708090a0b0c0d0e0f"), create {SSL_GCM_MODE}.make ("000000000000000000000000","CE573FB7A41AB78E743180DC83FF09BD"))

			create l_cipher_external.make (l_cipher.algorithm, l_cipher.mode, 0)
			l_result := l_cipher_external.update (create {MANAGED_POINTER}.make_from_array ((create {BYTE_ARRAY_CONVERTER}.make_from_hex_string ("0A3471C72D9BE49A8520F79C66BBD9A12FF9")).to_natural_8_array))
			l_result.append (l_cipher_external.finalize)

			create l_value.make_empty
			from
			until
				l_index >= l_result.count
			loop
				l_value.append_character (l_result.read_character (l_index))
				l_index := l_index + 1
			end
			assert ("Expected value={%"type%":%"PAYMENT%"}",l_value.same_string_general ("{%"type%":%"PAYMENT%"}"))

		end


end


