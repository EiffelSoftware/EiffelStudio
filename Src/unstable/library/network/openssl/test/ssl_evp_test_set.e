note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	SSL_EVP_TEST_SET

inherit
	EQA_TEST_SET
		select
			default_create
		end
	SSL_SHARED
		rename
			default_create as dc_shared
		end

feature -- Test routines

	test_evp_cipher_ctx

		do
			assert ("not default_pointer", {SSL_EVP}.c_evp_cipher_ctx_new /= default_pointer)
		end

	test_evp_ctrl_gcm_set_ivlen
		do
			assert ("gsm_set_ivlen=0x9", {SSL_EVP}.c_evp_ctrl_gcm_set_ivlen = 0x9 )
		end

	test_byte_array
		local
			l_converter: BYTE_ARRAY_CONVERTER
			l_array: ARRAY [NATURAL_8]
		do
				-- keyFromConfiguration = "000102030405060708090a0b0c0d0e0f000102030405060708090a0b0c0d0e0f";
				-- [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]
			create l_converter.make_from_hex_string ("000102030405060708090a0b0c0d0e0f000102030405060708090a0b0c0d0e0f")
			l_array := l_converter.to_natural_8_array
		end


	test_gcm_decrypt
		note
			eis: "name=example", "src=https://docs.acaptureservices.com/tutorials/webhooks/decryption-example","protocol=uri"
		local
			l_gcm: SSL_GCM
		do
			create l_gcm
			assert ("Expected value={%"type%":%"PAYMENT%"}",l_gcm.decrypt ("000102030405060708090a0b0c0d0e0f000102030405060708090a0b0c0d0e0f", "000000000000000000000000", "CE573FB7A41AB78E743180DC83FF09BD", "0A3471C72D9BE49A8520F79C66BBD9A12FF9", Void).same_string_general ("{%"type%":%"PAYMENT%"}"))
		end




--	test_cipher_object
--		local
--			l_cipher: SSL_CIPHER
--			l_cipher_external: SSL_CIPHER_CONTEXT_EXTERNALS
--			l_result: MANAGED_POINTER
--			l_index: INTEGER
--			l_value: STRING
--		do
--			create l_cipher.make (create {SSL_AES}.make ("000102030405060708090a0b0c0d0e0f000102030405060708090a0b0c0d0e0f"), create {SSL_GCM_MODE}.make ("000000000000000000000000","CE573FB7A41AB78E743180DC83FF09BD"))

--			create l_cipher_external.make (l_cipher.algorithm, l_cipher.mode, 0)
--			l_result := l_cipher_external.update (create {MANAGED_POINTER}.make_from_array ((create {BYTE_ARRAY_CONVERTER}.make_from_hex_string ("0A3471C72D9BE49A8520F79C66BBD9A12FF9")).to_natural_8_array))
--			l_result.append (l_cipher_external.finalize)


--			create l_value.make_empty
--			from
--			until
--				l_index >= l_result.count
--			loop
--				l_value.append_character (l_result.read_character (l_index))
--				l_index := l_index + 1
--			end
--			assert ("Expected value={%"type%":%"PAYMENT%"}",l_value.same_string_general ("{%"type%":%"PAYMENT%"}"))

--		end

end


