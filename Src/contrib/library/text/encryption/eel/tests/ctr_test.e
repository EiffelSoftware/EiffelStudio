note
	description: "Tests Counter mode"
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "We contend that for a nation to try to tax itself into prosperity is like a man standing in a bucket and trying to lift himself up by the handle. - Winston Churchill (1903)"

class
	CTR_TEST

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
			create ciphertext.make_from_hex_string ("874d6191b620e3261bef6864990db6ce")
			create ciphertext_1_128.make_filled (0, 16)
			ciphertext.to_fixed_width_byte_array (ciphertext_1_128, 0, 15)
			create ciphertext.make_from_hex_string ("9806f66b7970fdff8617187bb9fffdff")
			create ciphertext_2_128.make_filled (0, 16)
			ciphertext.to_fixed_width_byte_array (ciphertext_2_128, 0, 15)
			create ciphertext.make_from_hex_string ("5ae4df3edbd5d35e5b4f09020db03eab")
			create ciphertext_3_128.make_filled (0, 16)
			ciphertext.to_fixed_width_byte_array (ciphertext_3_128, 0, 15)
			create ciphertext.make_from_hex_string ("1e031dda2fbe03d1792170a0f3009cee")
			create ciphertext_4_128.make_filled (0, 16)
			ciphertext.to_fixed_width_byte_array (ciphertext_4_128, 0, 15)

			create ciphertext.make_from_hex_string ("1abc932417521ca24f2b0459fe7e6e0b")
			create ciphertext_1_196.make_filled (0, 16)
			ciphertext.to_fixed_width_byte_array (ciphertext_1_196, 0, 15)
			create ciphertext.make_from_hex_string ("090339ec0aa6faefd5ccc2c6f4ce8e94")
			create ciphertext_2_196.make_filled (0, 16)
			ciphertext.to_fixed_width_byte_array (ciphertext_2_196, 0, 15)
			create ciphertext.make_from_hex_string ("1e36b26bd1ebc670d1bd1d665620abf7")
			create ciphertext_3_196.make_filled (0, 16)
			ciphertext.to_fixed_width_byte_array (ciphertext_3_196, 0, 15)
			create ciphertext.make_from_hex_string ("4f78a7f6d29809585a97daec58c6b050")
			create ciphertext_4_196.make_filled (0, 16)
			ciphertext.to_fixed_width_byte_array (ciphertext_4_196, 0, 15)

			create ciphertext.make_from_hex_string ("601ec313775789a5b7a7f504bbf3d228")
			create ciphertext_1_256.make_filled (0, 16)
			ciphertext.to_fixed_width_byte_array (ciphertext_1_256, 0, 15)
			create ciphertext.make_from_hex_string ("f443e3ca4d62b59aca84e990cacaf5c5")
			create ciphertext_2_256.make_filled (0, 16)
			ciphertext.to_fixed_width_byte_array (ciphertext_2_256, 0, 15)
			create ciphertext.make_from_hex_string ("2b0930daa23de94ce87017ba2d84988d")
			create ciphertext_3_256.make_filled (0, 16)
			ciphertext.to_fixed_width_byte_array (ciphertext_3_256, 0, 15)
			create ciphertext.make_from_hex_string ("dfc9c58db67aada613c2dd08457941a6")
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
			ctr: CTR_ENCRYPTION
			aes: AES_KEY
			ciphertext: SPECIAL [NATURAL_8]
			correct: BOOLEAN
		do
			create aes.make_spec_128
			create ciphertext.make_filled (0, 16)
			create ctr.make (aes, iv_counter)
			ctr.encrypt_block (block_1, 0, ciphertext, 0)
			correct := ciphertext.same_items (ciphertext_1_128, 0, 0, 16)
			assert ("test encryption 128 1", correct)
			ctr.encrypt_block (block_2, 0, ciphertext, 0)
			correct := ciphertext.same_items (ciphertext_2_128, 0, 0, 16)
			assert ("test encryption 128 2", correct)
			ctr.encrypt_block (block_3, 0, ciphertext, 0)
			correct := ciphertext.same_items (ciphertext_3_128, 0, 0, 16)
			assert ("test encryption 128 3", correct)
			ctr.encrypt_block (block_4, 0, ciphertext, 0)
			correct := ciphertext.same_items (ciphertext_4_128, 0, 0, 16)
			assert ("test encryption 128 4", correct)
		end

	test_decryption_128
		local
			ctr: CTR_DECRYPTION
			aes: AES_KEY
			plaintext: SPECIAL [NATURAL_8]
			correct: BOOLEAN
		do
			create aes.make_spec_128
			create plaintext.make_filled (0, 16)
			create ctr.make (aes, iv_counter)
			ctr.decrypt_block (ciphertext_1_128, 0, plaintext, 0)
			correct := plaintext.same_items (block_1, 0, 0, 16)
			assert ("test decryption 128 1", correct)
			ctr.decrypt_block (ciphertext_2_128, 0, plaintext, 0)
			correct := plaintext.same_items (block_2, 0, 0, 16)
			assert ("test decryption 128 2", correct)
			ctr.decrypt_block (ciphertext_3_128, 0, plaintext, 0)
			correct := plaintext.same_items (block_3, 0, 0, 16)
			assert ("test decryption 128 3", correct)
			ctr.decrypt_block (ciphertext_4_128, 0, plaintext, 0)
			correct := plaintext.same_items (block_4, 0, 0, 16)
			assert ("test decryption 128 4", correct)
		end

	test_encryption_196
		local
			ctr: CTR_ENCRYPTION
			aes: AES_KEY
			ciphertext: SPECIAL [NATURAL_8]
			correct: BOOLEAN
		do
			create aes.make_spec_196
			create ciphertext.make_filled (0, 16)
			create ctr.make (aes, iv_counter)
			ctr.encrypt_block (block_1, 0, ciphertext, 0)
			correct := ciphertext.same_items (ciphertext_1_196, 0, 0, 16)
			assert ("test encryption 196 1", correct)
			ctr.encrypt_block (block_2, 0, ciphertext, 0)
			correct := ciphertext.same_items (ciphertext_2_196, 0, 0, 16)
			assert ("test encryption 196 2", correct)
			ctr.encrypt_block (block_3, 0, ciphertext, 0)
			correct := ciphertext.same_items (ciphertext_3_196, 0, 0, 16)
			assert ("test encryption 196 3", correct)
			ctr.encrypt_block (block_4, 0, ciphertext, 0)
			correct := ciphertext.same_items (ciphertext_4_196, 0, 0, 16)
			assert ("test encryption 196 4", correct)
		end

	test_decryption_196
		local
			ctr: CTR_DECRYPTION
			aes: AES_KEY
			plaintext: SPECIAL [NATURAL_8]
			correct: BOOLEAN
		do
			create aes.make_spec_196
			create plaintext.make_filled (0, 16)
			create ctr.make (aes, iv_counter)
			ctr.decrypt_block (ciphertext_1_196, 0, plaintext, 0)
			correct := plaintext.same_items (block_1, 0, 0, 16)
			assert ("test decryption 196 1", correct)
			ctr.decrypt_block (ciphertext_2_196, 0, plaintext, 0)
			correct := plaintext.same_items (block_2, 0, 0, 16)
			assert ("test decryption 196 2", correct)
			ctr.decrypt_block (ciphertext_3_196, 0, plaintext, 0)
			correct := plaintext.same_items (block_3, 0, 0, 16)
			assert ("test decryption 196 3", correct)
			ctr.decrypt_block (ciphertext_4_196, 0, plaintext, 0)
			correct := plaintext.same_items (block_4, 0, 0, 16)
			assert ("test decryption 196 4", correct)
		end

	test_encryption_256
		local
			ctr: CTR_ENCRYPTION
			aes: AES_KEY
			ciphertext: SPECIAL [NATURAL_8]
			correct: BOOLEAN
		do
			create aes.make_spec_256
			create ciphertext.make_filled (0, 16)
			create ctr.make (aes, iv_counter)
			ctr.encrypt_block (block_1, 0, ciphertext, 0)
			correct := ciphertext.same_items (ciphertext_1_256, 0, 0, 16)
			assert ("test encryption 256 1", correct)
			ctr.encrypt_block (block_2, 0, ciphertext, 0)
			correct := ciphertext.same_items (ciphertext_2_256, 0, 0, 16)
			assert ("test encryption 256 2", correct)
			ctr.encrypt_block (block_3, 0, ciphertext, 0)
			correct := ciphertext.same_items (ciphertext_3_256, 0, 0, 16)
			assert ("test encryption 256 3", correct)
			ctr.encrypt_block (block_4, 0, ciphertext, 0)
			correct := ciphertext.same_items (ciphertext_4_256, 0, 0, 16)
			assert ("test encryption 256 4", correct)
		end

	test_decryption_256
		local
			ctr: CTR_DECRYPTION
			aes: AES_KEY
			plaintext: SPECIAL [NATURAL_8]
			correct: BOOLEAN
		do
			create aes.make_spec_256
			create plaintext.make_filled (0, 16)
			create ctr.make (aes, iv_counter)
			ctr.decrypt_block (ciphertext_1_256, 0, plaintext, 0)
			correct := plaintext.same_items (block_1, 0, 0, 16)
			assert ("test decryption 256 1", correct)
			ctr.decrypt_block (ciphertext_2_256, 0, plaintext, 0)
			correct := plaintext.same_items (block_2, 0, 0, 16)
			assert ("test decryption 256 2", correct)
			ctr.decrypt_block (ciphertext_3_256, 0, plaintext, 0)
			correct := plaintext.same_items (block_3, 0, 0, 16)
			assert ("test decryption 256 3", correct)
			ctr.decrypt_block (ciphertext_4_256, 0, plaintext, 0)
			correct := plaintext.same_items (block_4, 0, 0, 16)
			assert ("test decryption 256 4", correct)
		end
end
