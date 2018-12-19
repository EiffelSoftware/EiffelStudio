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
		select
			default_create
		end
	SSL_SHARED
		rename
			default_create as ssl_create
		end


feature -- Test routines

	test_gcm_ciphertext_with_no_aad
		local
			cipher: SSL_CIPHER
			l_algo: SSL_AES
			l_mode: SSL_GCM_MODE
			l_encryptor: SSL_CIPHER_CONTEXT_I
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
			l_encryptor.update_with_hex_string ("28286a321293253c3e0aa2704a278032")
			l_encryptor.finalize

			assert ("Expected ct:5a3c1cf1985dbb8bed818036fdd5ab42",l_encryptor.hex_string.same_string_general ("5a3c1cf1985dbb8bed818036fdd5ab42"))

			if
				attached {SSL_AEAD_ENCRYPTION_CONTEXT_I} l_encryptor as l_encryptor_tag and then
				attached l_encryptor_tag.tag_hex_string as l_tag
			then
				assert ("Expected tag:23c7ab0f952b7091cd324835043b5eb5",l_tag.same_string_general ("23c7ab0f952b7091cd324835043b5eb5"))
			else
				assert ("Expected tag", False)
			end
		end


	test_gcm_ciphertext_with_only_aad
		local
			cipher: SSL_CIPHER
			l_algo: SSL_AES
			l_mode: SSL_GCM_MODE
			l_encryptor: SSL_CIPHER_CONTEXT_I
		do
			initialize_ssl
			-- Code in Python
			--  def test_gcm_tag_with_only_aad(self, backend):
			--        key = binascii.unhexlify(b"5211242698bed4774a090620a6ca56f3")
			--        iv = binascii.unhexlify(b"b1e1349120b6e832ef976f5d")
			--        aad = binascii.unhexlify(b"b6d729aab8e6416d7002b9faa794c410d8d2f193")
			--        tag = binascii.unhexlify(b"0f247e7f9c2505de374006738018493b")

			--        cipher = base.Cipher(
			--            algorithms.AES(key),
			--            modes.GCM(iv),
			--            backend=backend
			--        )
			--        encryptor = cipher.encryptor()
			--        encryptor.authenticate_additional_data(aad)
			--        encryptor.finalize()
			--        assert encryptor.tag == tag		

			create l_algo.make ("5211242698bed4774a090620a6ca56f3")
			create l_mode.make ("b1e1349120b6e832ef976f5d", "0f247e7f9c2505de374006738018493b" )
			check is_valid: l_mode.is_valid_aes_key (l_algo) end
			create cipher.make (l_algo, l_mode)
			l_encryptor := cipher.encryptor
			if attached {SSL_AEAD_CIPHER_CONTEXT} l_encryptor as ll_encryptor then
				ll_encryptor.authenticate_additional_data_hex_string ("b6d729aab8e6416d7002b9faa794c410d8d2f193")
				ll_encryptor.finalize
				if attached ll_encryptor.tag_hex_string as l_tag then
					assert ("Expected tag: 0f247e7f9c2505de374006738018493b", l_tag.same_string ("0f247e7f9c2505de374006738018493b"))
				end
			end
		end

	test_gcm_tag_encrypt_decrypt
		local
			cipher: SSL_CIPHER
			l_algo: SSL_AES
			l_mode: SSL_GCM_MODE
			l_encryptor, l_decryptor: SSL_CIPHER_CONTEXT_I
			tag: STRING_32
		do
				-- Code in Python
				--    def test_gcm_tag_decrypt_mode(self, backend):
				--        key = binascii.unhexlify(b"5211242698bed4774a090620a6ca56f3")
				--        iv = binascii.unhexlify(b"b1e1349120b6e832ef976f5d")
				--        aad = binascii.unhexlify(b"b6d729aab8e6416d7002b9faa794c410d8d2f193")

				--        encryptor = base.Cipher(
				--            algorithms.AES(key),
				--            modes.GCM(iv),
				--            backend=backend
				--        ).encryptor()
				--        encryptor.authenticate_additional_data(aad)
				--        encryptor.finalize()
				--        tag = encryptor.tag

				--        decryptor = base.Cipher(
				--            algorithms.AES(key),
				--            modes.GCM(iv, tag),
				--            backend=backend
				--        ).decryptor()
				--        decryptor.authenticate_additional_data(aad)
				--        decryptor.finalize()


			create l_algo.make ("5211242698bed4774a090620a6ca56f3")
			create l_mode.make ("b1e1349120b6e832ef976f5d", Void)
			create cipher.make (l_algo, l_mode)
			l_encryptor := cipher.encryptor
			if attached {SSL_AEAD_CIPHER_CONTEXT} l_encryptor as ll_encryptor then
				ll_encryptor.authenticate_additional_data_hex_string ("b6d729aab8e6416d7002b9faa794c410d8d2f193")
				ll_encryptor.finalize
				if attached ll_encryptor.tag_hex_string as l_tag then
					tag := l_tag
				end
			end

			create l_mode.make ("b1e1349120b6e832ef976f5d", tag)
			create cipher.make (l_algo, l_mode)
			l_decryptor := cipher.decryptor
			if attached {SSL_AEAD_CIPHER_CONTEXT} l_decryptor as ll_decryptor then
				ll_decryptor.authenticate_additional_data_hex_string ("b6d729aab8e6416d7002b9faa794c410d8d2f193")
				l_decryptor.finalize
			end
		end

	test_aes_decryption_acaptureservices
		note
			eis: "name=acaptureservices example", "src=https://docs.acaptureservices.com/tutorials/webhooks/decryption-example","protocol=uri"
		local
			l_decryptor: SSL_CIPHER_CONTEXT_I
			cipher: SSL_CIPHER
			l_algo: SSL_AES
			l_mode: SSL_GCM_MODE
		do
			create l_algo.make ("000102030405060708090a0b0c0d0e0f000102030405060708090a0b0c0d0e0f")
			create l_mode.make ("000000000000000000000000", "CE573FB7A41AB78E743180DC83FF09BD")
			create cipher.make (l_algo, l_mode)
			l_decryptor := cipher.decryptor
			l_decryptor.update_with_hex_string ("0A3471C72D9BE49A8520F79C66BBD9A12FF9")
			l_decryptor.finalize

			assert ("Expected value={%"type%":%"PAYMENT%"}",l_decryptor.string.same_string_general ("{%"type%":%"PAYMENT%"}"))
		end


note
	copyright: "Copyright (c) 1984-2018, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end


