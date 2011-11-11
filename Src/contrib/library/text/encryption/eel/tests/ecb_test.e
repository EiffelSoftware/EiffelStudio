note
	description: "Tests Electronic Codebook mode"
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "Ask not what you can do for your country; ask what your government is doing to you. - Joseph Sobran (1990)"

class
	ECB_TEST

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
			create ciphertext.make_from_hex_string ("3ad77bb40d7a3660a89ecaf32466ef97")
			create ciphertext_1_128.make_filled (0, 16)
			ciphertext.to_fixed_width_byte_array (ciphertext_1_128, 0, 15)
			create ciphertext.make_from_hex_string ("f5d3d58503b9699de785895a96fdbaaf")
			create ciphertext_2_128.make_filled (0, 16)
			ciphertext.to_fixed_width_byte_array (ciphertext_2_128, 0, 15)
			create ciphertext.make_from_hex_string ("43b1cd7f598ece23881b00e3ed030688")
			create ciphertext_3_128.make_filled (0, 16)
			ciphertext.to_fixed_width_byte_array (ciphertext_3_128, 0, 15)
			create ciphertext.make_from_hex_string ("7b0c785e27e8ad3f8223207104725dd4")
			create ciphertext_4_128.make_filled (0, 16)
			ciphertext.to_fixed_width_byte_array (ciphertext_4_128, 0, 15)

			create ciphertext.make_from_hex_string ("bd334f1d6e45f25ff712a214571fa5cc")
			create ciphertext_1_196.make_filled (0, 16)
			ciphertext.to_fixed_width_byte_array (ciphertext_1_196, 0, 15)
			create ciphertext.make_from_hex_string ("974104846d0ad3ad7734ecb3ecee4eef")
			create ciphertext_2_196.make_filled (0, 16)
			ciphertext.to_fixed_width_byte_array (ciphertext_2_196, 0, 15)
			create ciphertext.make_from_hex_string ("ef7afd2270e2e60adce0ba2face6444e")
			create ciphertext_3_196.make_filled (0, 16)
			ciphertext.to_fixed_width_byte_array (ciphertext_3_196, 0, 15)
			create ciphertext.make_from_hex_string ("9a4b41ba738d6c72fb16691603c18e0e")
			create ciphertext_4_196.make_filled (0, 16)
			ciphertext.to_fixed_width_byte_array (ciphertext_4_196, 0, 15)

			create ciphertext.make_from_hex_string ("f3eed1bdb5d2a03c064b5a7e3db181f8")
			create ciphertext_1_256.make_filled (0, 16)
			ciphertext.to_fixed_width_byte_array (ciphertext_1_256, 0, 15)
			create ciphertext.make_from_hex_string ("591ccb10d410ed26dc5ba74a31362870")
			create ciphertext_2_256.make_filled (0, 16)
			ciphertext.to_fixed_width_byte_array (ciphertext_2_256, 0, 15)
			create ciphertext.make_from_hex_string ("b6ed21b99ca6f4f9f153e7b1beafed1d")
			create ciphertext_3_256.make_filled (0, 16)
			ciphertext.to_fixed_width_byte_array (ciphertext_3_256, 0, 15)
			create ciphertext.make_from_hex_string ("23304b7a39f9f3ff067d8d8f9e24ecc7")
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
			ecb: ECB_ENCRYPTION
			aes: AES_KEY
			ciphertext: SPECIAL [NATURAL_8]
			correct: BOOLEAN
		do
			create aes.make_spec_128
			create ciphertext.make_filled (0, 16)
			create ecb.make (aes)
			ecb.encrypt_block (block_1, 0, ciphertext, 0)
			correct := ciphertext.same_items (ciphertext_1_128, 0, 0, 16)
			assert ("test encryption 128 1", correct)
			ecb.encrypt_block (block_2, 0, ciphertext, 0)
			correct := ciphertext.same_items (ciphertext_2_128, 0, 0, 16)
			assert ("test encryption 128 2", correct)
			ecb.encrypt_block (block_3, 0, ciphertext, 0)
			correct := ciphertext.same_items (ciphertext_3_128, 0, 0, 16)
			assert ("test encryption 128 3", correct)
			ecb.encrypt_block (block_4, 0, ciphertext, 0)
			correct := ciphertext.same_items (ciphertext_4_128, 0, 0, 16)
			assert ("test encryption 128 4", correct)
		end

	test_decryption_128
		local
			ecb: ECB_DECRYPTION
			aes: AES_KEY
			plaintext: SPECIAL [NATURAL_8]
			correct: BOOLEAN
		do
			create aes.make_spec_128
			create plaintext.make_filled (0, 16)
			create ecb.make (aes)
			ecb.decrypt_block (ciphertext_1_128, 0, plaintext, 0)
			correct := plaintext.same_items (block_1, 0, 0, 16)
			assert ("test decryption 128 1", correct)
			ecb.decrypt_block (ciphertext_2_128, 0, plaintext, 0)
			correct := plaintext.same_items (block_2, 0, 0, 16)
			assert ("test decryption 128 2", correct)
			ecb.decrypt_block (ciphertext_3_128, 0, plaintext, 0)
			correct := plaintext.same_items (block_3, 0, 0, 16)
			assert ("test decryption 128 3", correct)
			ecb.decrypt_block (ciphertext_4_128, 0, plaintext, 0)
			correct := plaintext.same_items (block_4, 0, 0, 16)
			assert ("test decryption 128 4", correct)
		end

	test_encryption_196
		local
			ecb: ECB_ENCRYPTION
			aes: AES_KEY
			ciphertext: SPECIAL [NATURAL_8]
			correct: BOOLEAN
		do
			create aes.make_spec_196
			create ciphertext.make_filled (0, 16)
			create ecb.make (aes)
			ecb.encrypt_block (block_1, 0, ciphertext, 0)
			correct := ciphertext.same_items (ciphertext_1_196, 0, 0, 16)
			assert ("test encryption 196 1", correct)
			ecb.encrypt_block (block_2, 0, ciphertext, 0)
			correct := ciphertext.same_items (ciphertext_2_196, 0, 0, 16)
			assert ("test encryption 196 2", correct)
			ecb.encrypt_block (block_3, 0, ciphertext, 0)
			correct := ciphertext.same_items (ciphertext_3_196, 0, 0, 16)
			assert ("test encryption 196 3", correct)
			ecb.encrypt_block (block_4, 0, ciphertext, 0)
			correct := ciphertext.same_items (ciphertext_4_196, 0, 0, 16)
			assert ("test encryption 196 4", correct)
		end

	test_decryption_196
		local
			ecb: ECB_DECRYPTION
			aes: AES_KEY
			plaintext: SPECIAL [NATURAL_8]
			correct: BOOLEAN
		do
			create aes.make_spec_196
			create plaintext.make_filled (0, 16)
			create ecb.make (aes)
			ecb.decrypt_block (ciphertext_1_196, 0, plaintext, 0)
			correct := plaintext.same_items (block_1, 0, 0, 16)
			assert ("test decryption 196 1", correct)
			ecb.decrypt_block (ciphertext_2_196, 0, plaintext, 0)
			correct := plaintext.same_items (block_2, 0, 0, 16)
			assert ("test decryption 196 2", correct)
			ecb.decrypt_block (ciphertext_3_196, 0, plaintext, 0)
			correct := plaintext.same_items (block_3, 0, 0, 16)
			assert ("test decryption 196 3", correct)
			ecb.decrypt_block (ciphertext_4_196, 0, plaintext, 0)
			correct := plaintext.same_items (block_4, 0, 0, 16)
			assert ("test decryption 196 4", correct)
		end

	test_encryption_256
		local
			ecb: ECB_ENCRYPTION
			aes: AES_KEY
			ciphertext: SPECIAL [NATURAL_8]
			correct: BOOLEAN
		do
			create aes.make_spec_256
			create ciphertext.make_filled (0, 16)
			create ecb.make (aes)
			ecb.encrypt_block (block_1, 0, ciphertext, 0)
			correct := ciphertext.same_items (ciphertext_1_256, 0, 0, 16)
			assert ("test encryption 256 1", correct)
			ecb.encrypt_block (block_2, 0, ciphertext, 0)
			correct := ciphertext.same_items (ciphertext_2_256, 0, 0, 16)
			assert ("test encryption 256 2", correct)
			ecb.encrypt_block (block_3, 0, ciphertext, 0)
			correct := ciphertext.same_items (ciphertext_3_256, 0, 0, 16)
			assert ("test encryption 256 3", correct)
			ecb.encrypt_block (block_4, 0, ciphertext, 0)
			correct := ciphertext.same_items (ciphertext_4_256, 0, 0, 16)
			assert ("test encryption 256 4", correct)
		end

	test_decryption_256
		local
			ecb: ECB_DECRYPTION
			aes: AES_KEY
			plaintext: SPECIAL [NATURAL_8]
			correct: BOOLEAN
		do
			create aes.make_spec_256
			create plaintext.make_filled (0, 16)
			create ecb.make (aes)
			ecb.decrypt_block (ciphertext_1_256, 0, plaintext, 0)
			correct := plaintext.same_items (block_1, 0, 0, 16)
			assert ("test decryption 256 1", correct)
			ecb.decrypt_block (ciphertext_2_256, 0, plaintext, 0)
			correct := plaintext.same_items (block_2, 0, 0, 16)
			assert ("test decryption 256 2", correct)
			ecb.decrypt_block (ciphertext_3_256, 0, plaintext, 0)
			correct := plaintext.same_items (block_3, 0, 0, 16)
			assert ("test decryption 256 3", correct)
			ecb.decrypt_block (ciphertext_4_256, 0, plaintext, 0)
			correct := plaintext.same_items (block_4, 0, 0, 16)
			assert ("test decryption 256 4", correct)
		end
end
