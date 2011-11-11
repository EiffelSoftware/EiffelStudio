note
	description: "Tests Cipher Block Chaining mode"
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "Government is the great fiction, through which everybody endeavors to live at the expense of everybody else. - Frederic Bastiat"

class
	CBC_TEST

inherit
	MODE_TEST_DATA
		undefine
			default_create
		end
	EQA_TEST_SET
		redefine
			on_prepare
		end

feature {NONE}
	on_prepare
		local
			ciphertext: INTEGER_X
		do
			make_data
			create ciphertext.make_from_hex_string ("7649abac8119b246cee98e9b12e9197d")
			create ciphertext_1_128.make_filled (0, 16)
			ciphertext.to_fixed_width_byte_array (ciphertext_1_128, 0, 15)
			create ciphertext.make_from_hex_string ("5086cb9b507219ee95db113a917678b2")
			create ciphertext_2_128.make_filled (0, 16)
			ciphertext.to_fixed_width_byte_array (ciphertext_2_128, 0, 15)
			create ciphertext.make_from_hex_string ("73bed6b8e3c1743b7116e69e22229516")
			create ciphertext_3_128.make_filled (0, 16)
			ciphertext.to_fixed_width_byte_array (ciphertext_3_128, 0, 15)
			create ciphertext.make_from_hex_string ("3ff1caa1681fac09120eca307586e1a7")
			create ciphertext_4_128.make_filled (0, 16)
			ciphertext.to_fixed_width_byte_array (ciphertext_4_128, 0, 15)

			create ciphertext.make_from_hex_string ("4f021db243bc633d7178183a9fa071e8")
			create ciphertext_1_196.make_filled (0, 16)
			ciphertext.to_fixed_width_byte_array (ciphertext_1_196, 0, 15)
			create ciphertext.make_from_hex_string ("b4d9ada9ad7dedf4e5e738763f69145a")
			create ciphertext_2_196.make_filled (0, 16)
			ciphertext.to_fixed_width_byte_array (ciphertext_2_196, 0, 15)
			create ciphertext.make_from_hex_string ("571b242012fb7ae07fa9baac3df102e0")
			create ciphertext_3_196.make_filled (0, 16)
			ciphertext.to_fixed_width_byte_array (ciphertext_3_196, 0, 15)
			create ciphertext.make_from_hex_string ("08b0e27988598881d920a9e64f5615cd")
			create ciphertext_4_196.make_filled (0, 16)
			ciphertext.to_fixed_width_byte_array (ciphertext_4_196, 0, 15)

			create ciphertext.make_from_hex_string ("f58c4c04d6e5f1ba779eabfb5f7bfbd6")
			create ciphertext_1_256.make_filled (0, 16)
			ciphertext.to_fixed_width_byte_array (ciphertext_1_256, 0, 15)
			create ciphertext.make_from_hex_string ("9cfc4e967edb808d679f777bc6702c7d")
			create ciphertext_2_256.make_filled (0, 16)
			ciphertext.to_fixed_width_byte_array (ciphertext_2_256, 0, 15)
			create ciphertext.make_from_hex_string ("39f23369a9d9bacfa530e26304231461")
			create ciphertext_3_256.make_filled (0, 16)
			ciphertext.to_fixed_width_byte_array (ciphertext_3_256, 0, 15)
			create ciphertext.make_from_hex_string ("b2eb05e2c39be9fcda6c19078c6a9d1b")
			create ciphertext_4_256.make_filled (0, 16)
			ciphertext.to_fixed_width_byte_array (ciphertext_4_256, 0, 15)
		end

feature
	ciphertext_1_128: SPECIAL [NATURAL_8]
	ciphertext_2_128: SPECIAL [NATURAL_8]
	ciphertext_3_128: SPECIAL [NATURAL_8]
	ciphertext_4_128: SPECIAL [NATURAL_8]

	ciphertext_1_196: SPECIAL [NATURAL_8]
	ciphertext_2_196: SPECIAL [NATURAL_8]
	ciphertext_3_196: SPECIAL [NATURAL_8]
	ciphertext_4_196: SPECIAL [NATURAL_8]

	ciphertext_1_256: SPECIAL [NATURAL_8]
	ciphertext_2_256: SPECIAL [NATURAL_8]
	ciphertext_3_256: SPECIAL [NATURAL_8]
	ciphertext_4_256: SPECIAL [NATURAL_8]

	test_encryption_128
		local
			cbc: CBC_ENCRYPTION
			aes: AES_KEY
			ciphertext: SPECIAL [NATURAL_8]
			correct: BOOLEAN
		do
			create aes.make_spec_128
			create ciphertext.make_filled (0, 16)
			create cbc.make (aes, iv, 0)
			cbc.encrypt_block (block_1, 0, ciphertext, 0)
			correct := ciphertext.same_items (ciphertext_1_128, 0, 0, 16)
			assert ("test encryption 128 1", correct)
			cbc.encrypt_block (block_2, 0, ciphertext, 0)
			correct := ciphertext.same_items (ciphertext_2_128, 0, 0, 16)
			assert ("test encryption 128 2", correct)
			cbc.encrypt_block (block_3, 0, ciphertext, 0)
			correct := ciphertext.same_items (ciphertext_3_128, 0, 0, 16)
			assert ("test encryption 128 3", correct)
			cbc.encrypt_block (block_4, 0, ciphertext, 0)
			correct := ciphertext.same_items (ciphertext_4_128, 0, 0, 16)
			assert ("test encryption 128 4", correct)
		end

	test_decryption_128
		local
			cbc: CBC_DECRYPTION
			aes: AES_KEY
			plaintext: SPECIAL [NATURAL_8]
			correct: BOOLEAN
		do
			create aes.make_spec_128
			create plaintext.make_filled (0, 16)
			create cbc.make (aes, iv, 0)
			cbc.decrypt_block (ciphertext_1_128, 0, plaintext, 0)
			correct := plaintext.same_items (block_1, 0, 0, 16)
			assert ("test decryption 128 1", correct)
			cbc.decrypt_block (ciphertext_2_128, 0, plaintext, 0)
			correct := plaintext.same_items (block_2, 0, 0, 16)
			assert ("test decryption 128 2", correct)
			cbc.decrypt_block (ciphertext_3_128, 0, plaintext, 0)
			correct := plaintext.same_items (block_3, 0, 0, 16)
			assert ("test decryption 128 3", correct)
			cbc.decrypt_block (ciphertext_4_128, 0, plaintext, 0)
			correct := plaintext.same_items (block_4, 0, 0, 16)
			assert ("test decryption 128 4", correct)
		end

	test_encryption_196
		local
			cbc: CBC_ENCRYPTION
			aes: AES_KEY
			ciphertext: SPECIAL [NATURAL_8]
			correct: BOOLEAN
		do
			create aes.make_spec_196
			create ciphertext.make_filled (0, 16)
			create cbc.make (aes, iv, 0)
			cbc.encrypt_block (block_1, 0, ciphertext, 0)
			correct := ciphertext.same_items (ciphertext_1_196, 0, 0, 16)
			assert ("test encryption 196 1", correct)
			cbc.encrypt_block (block_2, 0, ciphertext, 0)
			correct := ciphertext.same_items (ciphertext_2_196, 0, 0, 16)
			assert ("test encryption 196 2", correct)
			cbc.encrypt_block (block_3, 0, ciphertext, 0)
			correct := ciphertext.same_items (ciphertext_3_196, 0, 0, 16)
			assert ("test encryption 196 3", correct)
			cbc.encrypt_block (block_4, 0, ciphertext, 0)
			correct := ciphertext.same_items (ciphertext_4_196, 0, 0, 16)
			assert ("test encryption 196 4", correct)
		end

	test_decryption_196
		local
			cbc: CBC_DECRYPTION
			aes: AES_KEY
			plaintext: SPECIAL [NATURAL_8]
			correct: BOOLEAN
		do
			create aes.make_spec_196
			create plaintext.make_filled (0, 16)
			create cbc.make (aes, iv, 0)
			cbc.decrypt_block (ciphertext_1_196, 0, plaintext, 0)
			correct := plaintext.same_items (block_1, 0, 0, 16)
			assert ("test decryption 196 1", correct)
			cbc.decrypt_block (ciphertext_2_196, 0, plaintext, 0)
			correct := plaintext.same_items (block_2, 0, 0, 16)
			assert ("test decryption 196 2", correct)
			cbc.decrypt_block (ciphertext_3_196, 0, plaintext, 0)
			correct := plaintext.same_items (block_3, 0, 0, 16)
			assert ("test decryption 196 3", correct)
			cbc.decrypt_block (ciphertext_4_196, 0, plaintext, 0)
			correct := plaintext.same_items (block_4, 0, 0, 16)
			assert ("test decryption 196 4", correct)
		end

	test_encryption_256
		local
			cbc: CBC_ENCRYPTION
			aes: AES_KEY
			ciphertext: SPECIAL [NATURAL_8]
			correct: BOOLEAN
		do
			create aes.make_spec_256
			create ciphertext.make_filled (0, 16)
			create cbc.make (aes, iv, 0)
			cbc.encrypt_block (block_1, 0, ciphertext, 0)
			correct := ciphertext.same_items (ciphertext_1_256, 0, 0, 16)
			assert ("test encryption 256 1", correct)
			cbc.encrypt_block (block_2, 0, ciphertext, 0)
			correct := ciphertext.same_items (ciphertext_2_256, 0, 0, 16)
			assert ("test encryption 256 2", correct)
			cbc.encrypt_block (block_3, 0, ciphertext, 0)
			correct := ciphertext.same_items (ciphertext_3_256, 0, 0, 16)
			assert ("test encryption 256 3", correct)
			cbc.encrypt_block (block_4, 0, ciphertext, 0)
			correct := ciphertext.same_items (ciphertext_4_256, 0, 0, 16)
			assert ("test encryption 256 4", correct)
		end

	test_decryption_256
		local
			cbc: CBC_DECRYPTION
			aes: AES_KEY
			plaintext: SPECIAL [NATURAL_8]
			correct: BOOLEAN
		do
			create aes.make_spec_256
			create plaintext.make_filled (0, 16)
			create cbc.make (aes, iv, 0)
			cbc.decrypt_block (ciphertext_1_256, 0, plaintext, 0)
			correct := plaintext.same_items (block_1, 0, 0, 16)
			assert ("test decryption 256 1",  correct)
			cbc.decrypt_block (ciphertext_2_256, 0, plaintext, 0)
			correct := plaintext.same_items (block_2, 0, 0, 16)
			assert ("test decryption 256 2", correct)
			cbc.decrypt_block (ciphertext_3_256, 0, plaintext, 0)
			correct := plaintext.same_items (block_3, 0, 0, 16)
			assert ("test decryption 256 3", correct)
			cbc.decrypt_block (ciphertext_4_256, 0, plaintext, 0)
			correct := plaintext.same_items (block_4, 0, 0, 16)
			assert ("test decryption 256 4", correct)
		end
end
