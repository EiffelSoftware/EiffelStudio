note
	description: "Tests Output Feedback mode"
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "Government is actually the worst failure of civilized man. There has never been a really good one, and even those that are most tolerable are arbitrary, cruel, grasping, and unintelligent. - H. L. Mencken"

class
	OFB_TEST

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
			create ciphertext.make_from_hex_string ("3b3fd92eb72dad20333449f8e83cfb4a")
			create ciphertext_1_128.make_filled (0, 16)
			ciphertext.to_fixed_width_byte_array (ciphertext_1_128, 0, 15)
			create ciphertext.make_from_hex_string ("7789508d16918f03f53c52dac54ed825")
			create ciphertext_2_128.make_filled (0, 16)
			ciphertext.to_fixed_width_byte_array (ciphertext_2_128, 0, 15)
			create ciphertext.make_from_hex_string ("9740051e9c5fecf64344f7a82260edcc")
			create ciphertext_3_128.make_filled (0, 16)
			ciphertext.to_fixed_width_byte_array (ciphertext_3_128, 0, 15)
			create ciphertext.make_from_hex_string ("304c6528f659c77866a510d9c1d6ae5e")
			create ciphertext_4_128.make_filled (0, 16)
			ciphertext.to_fixed_width_byte_array (ciphertext_4_128, 0, 15)

			create ciphertext.make_from_hex_string ("cdc80d6fddf18cab34c25909c99a4174")
			create ciphertext_1_196.make_filled (0, 16)
			ciphertext.to_fixed_width_byte_array (ciphertext_1_196, 0, 15)
			create ciphertext.make_from_hex_string ("fcc28b8d4c63837c09e81700c1100401")
			create ciphertext_2_196.make_filled (0, 16)
			ciphertext.to_fixed_width_byte_array (ciphertext_2_196, 0, 15)
			create ciphertext.make_from_hex_string ("8d9a9aeac0f6596f559c6d4daf59a5f2")
			create ciphertext_3_196.make_filled (0, 16)
			ciphertext.to_fixed_width_byte_array (ciphertext_3_196, 0, 15)
			create ciphertext.make_from_hex_string ("6d9f200857ca6c3e9cac524bd9acc92a")
			create ciphertext_4_196.make_filled (0, 16)
			ciphertext.to_fixed_width_byte_array (ciphertext_4_196, 0, 15)

			create ciphertext.make_from_hex_string ("dc7e84bfda79164b7ecd8486985d3860")
			create ciphertext_1_256.make_filled (0, 16)
			ciphertext.to_fixed_width_byte_array (ciphertext_1_256, 0, 15)
			create ciphertext.make_from_hex_string ("4febdc6740d20b3ac88f6ad82a4fb08d")
			create ciphertext_2_256.make_filled (0, 16)
			ciphertext.to_fixed_width_byte_array (ciphertext_2_256, 0, 15)
			create ciphertext.make_from_hex_string ("71ab47a086e86eedf39d1c5bba97c408")
			create ciphertext_3_256.make_filled (0, 16)
			ciphertext.to_fixed_width_byte_array (ciphertext_3_256, 0, 15)
			create ciphertext.make_from_hex_string ("0126141d67f37be8538f5a8be740e484")
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
			ofb: OFB_ENCRYPTION
			aes: AES_KEY
			ciphertext: SPECIAL [NATURAL_8]
			correct: BOOLEAN
		do
			create aes.make_spec_128
			create ciphertext.make_filled (0, 16)
			create ofb.make (aes, iv, 0)
			ofb.encrypt_block (block_1, 0, ciphertext, 0)
			correct := ciphertext.same_items (ciphertext_1_128, 0, 0, 16)
			assert ("test encryption 128 1", correct)
			ofb.encrypt_block (block_2, 0, ciphertext, 0)
			correct := ciphertext.same_items (ciphertext_2_128, 0, 0, 16)
			assert ("test encryption 128 2", correct)
			ofb.encrypt_block (block_3, 0, ciphertext, 0)
			correct := ciphertext.same_items (ciphertext_3_128, 0, 0, 16)
			assert ("test encryption 128 3", correct)
			ofb.encrypt_block (block_4, 0, ciphertext, 0)
			correct := ciphertext.same_items (ciphertext_4_128, 0, 0, 16)
			assert ("test encryption 128 4", correct)
		end

	test_decryption_128
		local
			ofb: OFB_DECRYPTION
			aes: AES_KEY
			plaintext: SPECIAL [NATURAL_8]
			correct: BOOLEAN
		do
			create aes.make_spec_128
			create plaintext.make_filled (0, 16)
			create ofb.make (aes, iv, 0)
			ofb.decrypt_block (ciphertext_1_128, 0, plaintext, 0)
			correct := plaintext.same_items (block_1, 0, 0, 16)
			assert ("test decryption 128 1", correct)
			ofb.decrypt_block (ciphertext_2_128, 0, plaintext, 0)
			correct := plaintext.same_items (block_2, 0, 0, 16)
			assert ("test decryption 128 2", correct)
			ofb.decrypt_block (ciphertext_3_128, 0, plaintext, 0)
			correct := plaintext.same_items (block_3, 0, 0, 16)
			assert ("test decryption 128 3", correct)
			ofb.decrypt_block (ciphertext_4_128, 0, plaintext, 0)
			correct := plaintext.same_items (block_4, 0, 0, 16)
			assert ("test decryption 128 4", correct)
		end

	test_encryption_196
		local
			ofb: OFB_ENCRYPTION
			aes: AES_KEY
			ciphertext: SPECIAL [NATURAL_8]
			correct: BOOLEAN
		do
			create aes.make_spec_196
			create ciphertext.make_filled (0, 16)
			create ofb.make (aes, iv, 0)
			ofb.encrypt_block (block_1, 0, ciphertext, 0)
			correct := ciphertext.same_items (ciphertext_1_196, 0, 0, 16)
			assert ("test encryption 196 1", correct)
			ofb.encrypt_block (block_2, 0, ciphertext, 0)
			correct := ciphertext.same_items (ciphertext_2_196, 0, 0, 16)
			assert ("test encryption 196 2", correct)
			ofb.encrypt_block (block_3, 0, ciphertext, 0)
			correct := ciphertext.same_items (ciphertext_3_196, 0, 0, 16)
			assert ("test encryption 196 3", correct)
			ofb.encrypt_block (block_4, 0, ciphertext, 0)
			correct := ciphertext.same_items (ciphertext_4_196, 0, 0, 16)
			assert ("test encryption 196 4", correct)
		end

	test_decryption_196
		local
			ofb: OFB_DECRYPTION
			aes: AES_KEY
			plaintext: SPECIAL [NATURAL_8]
			correct: BOOLEAN
		do
			create aes.make_spec_196
			create plaintext.make_filled (0, 16)
			create ofb.make (aes, iv, 0)
			ofb.decrypt_block (ciphertext_1_196, 0, plaintext, 0)
			correct := plaintext.same_items (block_1, 0, 0, 16)
			assert ("test decryption 196 1", correct)
			ofb.decrypt_block (ciphertext_2_196, 0, plaintext, 0)
			correct := plaintext.same_items (block_2, 0, 0, 16)
			assert ("test decryption 196 2", correct)
			ofb.decrypt_block (ciphertext_3_196, 0, plaintext, 0)
			correct := plaintext.same_items (block_3, 0, 0, 16)
			assert ("test decryption 196 3", correct)
			ofb.decrypt_block (ciphertext_4_196, 0, plaintext, 0)
			correct := plaintext.same_items (block_4, 0, 0, 16)
			assert ("test decryption 196 4", correct)
		end

	test_encryption_256
		local
			ofb: OFB_ENCRYPTION
			aes: AES_KEY
			ciphertext: SPECIAL [NATURAL_8]
			correct: BOOLEAN
		do
			create aes.make_spec_256
			create ciphertext.make_filled (0, 16)
			create ofb.make (aes, iv, 0)
			ofb.encrypt_block (block_1, 0, ciphertext, 0)
			correct := ciphertext.same_items (ciphertext_1_256, 0, 0, 16)
			assert ("test encryption 256 1", correct)
			ofb.encrypt_block (block_2, 0, ciphertext, 0)
			correct := ciphertext.same_items (ciphertext_2_256, 0, 0, 16)
			assert ("test encryption 256 2", correct)
			ofb.encrypt_block (block_3, 0, ciphertext, 0)
			correct := ciphertext.same_items (ciphertext_3_256, 0, 0, 16)
			assert ("test encryption 256 3", correct)
			ofb.encrypt_block (block_4, 0, ciphertext, 0)
			correct := ciphertext.same_items (ciphertext_4_256, 0, 0, 16)
			assert ("test encryption 256 4", correct)
		end

	test_decryption_256
		local
			cbc: OFB_DECRYPTION
			aes: AES_KEY
			plaintext: SPECIAL [NATURAL_8]
			correct: BOOLEAN
		do
			create aes.make_spec_256
			create plaintext.make_filled (0, 16)
			create cbc.make (aes, iv, 0)
			cbc.decrypt_block (ciphertext_1_256, 0, plaintext, 0)
			correct := plaintext.same_items (block_1, 0, 0, 16)
			assert ("test decryption 256 1", correct)
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
