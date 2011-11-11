note
	description: "Summary description for {MODE_TEST_DATA}."
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "The only thing necessary for evil to triumph is for good men to do nothing. - Edmund Burke"

deferred class
	MODE_TEST_DATA

feature
	make_data
		local
			block_1_text: INTEGER_X
			block_2_text: INTEGER_X
			block_3_text: INTEGER_X
			block_4_text: INTEGER_X
			iv_text: INTEGER_X
		do
			create block_1_text.make_from_hex_string ("6bc1bee22e409f96e93d7e117393172a")
			create block_1.make_filled (0, 16)
			block_1_text.to_fixed_width_byte_array (block_1, 0, 15)
			create block_2_text.make_from_hex_string ("ae2d8a571e03ac9c9eb76fac45af8e51")
			create block_2.make_filled (0, 16)
			block_2_text.to_fixed_width_byte_array (block_2, 0, 15)
			create block_3_text.make_from_hex_string ("30c81c46a35ce411e5fbc1191a0a52ef")
			create block_3.make_filled (0, 16)
			block_3_text.to_fixed_width_byte_array (block_3, 0, 15)
			create block_4_text.make_from_hex_string ("f69f2445df4f9b17ad2b417be66c3710")
			create block_4.make_filled (0, 16)
			block_4_text.to_fixed_width_byte_array (block_4, 0, 15)
			create iv_text.make_from_hex_string ("000102030405060708090a0b0c0d0e0f")
			create iv.make_filled (0, 16)
			iv_text.to_fixed_width_byte_array (iv, 0, 15)
			create iv_counter.make_from_hex_string ("f0f1f2f3f4f5f6f7f8f9fafbfcfdfeff")
		end

	block_1: SPECIAL [NATURAL_8]
	block_2: SPECIAL [NATURAL_8]
	block_3: SPECIAL [NATURAL_8]
	block_4: SPECIAL [NATURAL_8]

	iv: SPECIAL [NATURAL_8]
	iv_counter: INTEGER_X
end
