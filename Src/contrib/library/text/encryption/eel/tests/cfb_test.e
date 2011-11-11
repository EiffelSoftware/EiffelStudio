note
	description: "Tests Cipher Feedback mode"
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "Liberty is the only thing you cannot have unless you are willing to give it to others. - William Allen White"

class
	CFB_TEST

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
			create ciphertext_1_128_128.make_filled (0, 16)
			ciphertext.to_fixed_width_byte_array (ciphertext_1_128_128, 0, 15)
			create ciphertext.make_from_hex_string ("c8a64537a0b3a93fcde3cdad9f1ce58b")
			create ciphertext_2_128_128.make_filled (0, 16)
			ciphertext.to_fixed_width_byte_array (ciphertext_2_128_128, 0, 15)
			create ciphertext.make_from_hex_string ("26751f67a3cbb140b1808cf187a4f4df")
			create ciphertext_3_128_128.make_filled (0, 16)
			ciphertext.to_fixed_width_byte_array (ciphertext_3_128_128, 0, 15)
			create ciphertext.make_from_hex_string ("c04b05357c5d1c0eeac4c66f9ff7f2e6")
			create ciphertext_4_128_128.make_filled (0, 16)
			ciphertext.to_fixed_width_byte_array (ciphertext_4_128_128, 0, 15)

			create ciphertext.make_from_hex_string ("cdc80d6fddf18cab34c25909c99a4174")
			create ciphertext_1_128_196.make_filled (0, 16)
			ciphertext.to_fixed_width_byte_array (ciphertext_1_128_196, 0, 15)
			create ciphertext.make_from_hex_string ("67ce7f7f81173621961a2b70171d3d7a")
			create ciphertext_2_128_196.make_filled (0, 16)
			ciphertext.to_fixed_width_byte_array (ciphertext_2_128_196, 0, 15)
			create ciphertext.make_from_hex_string ("2e1e8a1dd59b88b1c8e60fed1efac4c9")
			create ciphertext_3_128_196.make_filled (0, 16)
			ciphertext.to_fixed_width_byte_array (ciphertext_3_128_196, 0, 15)
			create ciphertext.make_from_hex_string ("c05f9f9ca9834fa042ae8fba584b09ff")
			create ciphertext_4_128_196.make_filled (0, 16)
			ciphertext.to_fixed_width_byte_array (ciphertext_4_128_196, 0, 15)

			create ciphertext.make_from_hex_string ("dc7e84bfda79164b7ecd8486985d3860")
			create ciphertext_1_128_256.make_filled (0, 16)
			ciphertext.to_fixed_width_byte_array (ciphertext_1_128_256, 0, 15)
			create ciphertext.make_from_hex_string ("39ffed143b28b1c832113c6331e5407b")
			create ciphertext_2_128_256.make_filled (0, 16)
			ciphertext.to_fixed_width_byte_array (ciphertext_2_128_256, 0, 15)
			create ciphertext.make_from_hex_string ("df10132415e54b92a13ed0a8267ae2f9")
			create ciphertext_3_128_256.make_filled (0, 16)
			ciphertext.to_fixed_width_byte_array (ciphertext_3_128_256, 0, 15)
			create ciphertext.make_from_hex_string ("75a385741ab9cef82031623d55b1e471")
			create ciphertext_4_128_256.make_filled (0, 16)
			ciphertext.to_fixed_width_byte_array (ciphertext_4_128_256, 0, 15)
		end

feature
	ciphertext_1_128_128: SPECIAL [NATURAL_8]
	ciphertext_2_128_128: SPECIAL [NATURAL_8]
	ciphertext_3_128_128: SPECIAL [NATURAL_8]
	ciphertext_4_128_128: SPECIAL [NATURAL_8]

	ciphertext_1_128_196: SPECIAL [NATURAL_8]
	ciphertext_2_128_196: SPECIAL [NATURAL_8]
	ciphertext_3_128_196: SPECIAL [NATURAL_8]
	ciphertext_4_128_196: SPECIAL [NATURAL_8]

	ciphertext_1_128_256: SPECIAL [NATURAL_8]
	ciphertext_2_128_256: SPECIAL [NATURAL_8]
	ciphertext_3_128_256: SPECIAL [NATURAL_8]
	ciphertext_4_128_256: SPECIAL [NATURAL_8]

	test_encryption_128_128
		local
			cfb: CFB_ENCRYPTION
			aes: AES_KEY
			ciphertext: SPECIAL [NATURAL_8]
			correct: BOOLEAN
		do
			create aes.make_spec_128
			create ciphertext.make_filled (0, 16)
			create cfb.make (aes, iv, 0, 16)
			cfb.encrypt_block (block_1, 0, ciphertext, 0)
			correct := ciphertext.same_items (ciphertext_1_128_128, 0, 0, 16)
			assert ("test encryption 128 128 1", correct)
			cfb.encrypt_block (block_2, 0, ciphertext, 0)
			correct := ciphertext.same_items (ciphertext_2_128_128, 0, 0, 16)
			assert ("test encryption 128 128 2", correct)
			cfb.encrypt_block (block_3, 0, ciphertext, 0)
			correct := ciphertext.same_items (ciphertext_3_128_128, 0, 0, 16)
			assert ("test encryption 128 128 3", correct)
			cfb.encrypt_block (block_4, 0, ciphertext, 0)
			correct := ciphertext.same_items (ciphertext_4_128_128, 0, 0, 16)
			assert ("test encryption 128 128 4", correct)
		end

	test_decryption_128_128
		local
			cfb: CFB_DECRYPTION
			aes: AES_KEY
			plaintext: SPECIAL [NATURAL_8]
			correct: BOOLEAN
		do
			create aes.make_spec_128
			create plaintext.make_filled (0, 16)
			create cfb.make (aes, iv, 0, 16)
			cfb.decrypt_block (ciphertext_1_128_128, 0, plaintext, 0)
			correct := plaintext.same_items (block_1, 0, 0, 16)
			assert ("test decryption 128 128 1", correct)
			cfb.decrypt_block (ciphertext_2_128_128, 0, plaintext, 0)
			correct := plaintext.same_items (block_2, 0, 0, 16)
			assert ("test decryption 128 128 2", correct)
			cfb.decrypt_block (ciphertext_3_128_128, 0, plaintext, 0)
			correct := plaintext.same_items (block_3, 0, 0, 16)
			assert ("test decryption 128 128 3", correct)
			cfb.decrypt_block (ciphertext_4_128_128, 0, plaintext, 0)
			correct := plaintext.same_items (block_4, 0, 0, 16)
			assert ("test decryption 128 128 4", correct)
		end

	test_encryption_128_196
		local
			cfb: CFB_ENCRYPTION
			aes: AES_KEY
			ciphertext: SPECIAL [NATURAL_8]
			correct: BOOLEAN
		do
			create aes.make_spec_196
			create ciphertext.make_filled (0, 16)
			create cfb.make (aes, iv, 0, 16)
			cfb.encrypt_block (block_1, 0, ciphertext, 0)
			correct := ciphertext.same_items (ciphertext_1_128_196, 0, 0, 16)
			assert ("test encryption 128 196 1", correct)
			cfb.encrypt_block (block_2, 0, ciphertext, 0)
			correct := ciphertext.same_items (ciphertext_2_128_196, 0, 0, 16)
			assert ("test encryption 128 196 2", correct)
			cfb.encrypt_block (block_3, 0, ciphertext, 0)
			correct := ciphertext.same_items (ciphertext_3_128_196, 0, 0, 16)
			assert ("test encryption 128 196 3", correct)
			cfb.encrypt_block (block_4, 0, ciphertext, 0)
			correct := ciphertext.same_items (ciphertext_4_128_196, 0, 0, 16)
			assert ("test encryption 128 196 4", correct)
		end

	test_decryption_128_196
		local
			cfb: CFB_DECRYPTION
			aes: AES_KEY
			plaintext: SPECIAL [NATURAL_8]
			correct: BOOLEAN
		do
			create aes.make_spec_196
			create plaintext.make_filled (0, 16)
			create cfb.make (aes, iv, 0, 16)
			cfb.decrypt_block (ciphertext_1_128_196, 0, plaintext, 0)
			correct := plaintext.same_items (block_1, 0, 0, 16)
			assert ("test decryption 128 196 1", correct)
			cfb.decrypt_block (ciphertext_2_128_196, 0, plaintext, 0)
			correct := plaintext.same_items (block_2, 0, 0, 16)
			assert ("test decryption 128 196 2", correct)
			cfb.decrypt_block (ciphertext_3_128_196, 0, plaintext, 0)
			correct := plaintext.same_items (block_3, 0, 0, 16)
			assert ("test decryption 128 196 3", correct)
			cfb.decrypt_block (ciphertext_4_128_196, 0, plaintext, 0)
			correct := plaintext.same_items (block_4, 0, 0, 16)
			assert ("test decryption 128 196 4", correct)
		end

	test_encryption_128_256
		local
			cfb: CFB_ENCRYPTION
			aes: AES_KEY
			ciphertext: SPECIAL [NATURAL_8]
			correct: BOOLEAN
		do
			create aes.make_spec_256
			create ciphertext.make_filled (0, 16)
			create cfb.make (aes, iv, 0, 16)
			cfb.encrypt_block (block_1, 0, ciphertext, 0)
			correct := ciphertext.same_items (ciphertext_1_128_256, 0, 0, 16)
			assert ("test encryption 128 256 1", correct)
			cfb.encrypt_block (block_2, 0, ciphertext, 0)
			correct := ciphertext.same_items (ciphertext_2_128_256, 0, 0, 16)
			assert ("test encryption 128 256 2", correct)
			cfb.encrypt_block (block_3, 0, ciphertext, 0)
			correct := ciphertext.same_items (ciphertext_3_128_256, 0, 0, 16)
			assert ("test encryption 128 256 3", correct)
			cfb.encrypt_block (block_4, 0, ciphertext, 0)
			correct := ciphertext.same_items (ciphertext_4_128_256, 0, 0, 16)
			assert ("test encryption 128 256 4", correct)
		end

	test_decryption_128_256
		local
			cfb: CFB_DECRYPTION
			aes: AES_KEY
			plaintext: SPECIAL [NATURAL_8]
			correct: BOOLEAN
		do
			create aes.make_spec_256
			create plaintext.make_filled (0, 16)
			create cfb.make (aes, iv, 0, 16)
			cfb.decrypt_block (ciphertext_1_128_256, 0, plaintext, 0)
			correct := plaintext.same_items (block_1, 0, 0, 16)
			assert ("test decryption 128 256 1", correct)
			cfb.decrypt_block (ciphertext_2_128_256, 0, plaintext, 0)
			correct := plaintext.same_items (block_2, 0, 0, 16)
			assert ("test decryption 128 256 2", correct)
			cfb.decrypt_block (ciphertext_3_128_256, 0, plaintext, 0)
			correct := plaintext.same_items (block_3, 0, 0, 16)
			assert ("test decryption 128 256 3", correct)
			cfb.decrypt_block (ciphertext_4_128_256, 0, plaintext, 0)
			correct := plaintext.same_items (block_4, 0, 0, 16)
			assert ("test decryption 128 256 4", correct)
		end
end
