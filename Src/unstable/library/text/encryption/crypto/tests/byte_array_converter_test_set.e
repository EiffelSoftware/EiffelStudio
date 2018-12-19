note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	BYTE_ARRAY_CONVERTER_TEST_SET

inherit
	EQA_TEST_SET

feature -- Test routines

	test_make_from_hex_string
		local
			hex: STRING
			ba: BYTE_ARRAY_CONVERTER
			i,n: INTEGER
		do
			hex := "000102030405060708090a0b0c0d0e0f000102030405060708090a0b0c0d0e0f"
			create ba.make_from_hex_string (hex)
			assert ("same hex", ba.to_hex_string.is_case_insensitive_equal (hex))
			assert ("nat8 [1] = 0", ba.natural_8_item (1) = 0)
			assert ("nat8 [2] = 1", ba.natural_8_item (2) = 1)
			assert ("nat8 [12] = 11", ba.natural_8_item (12) = 11)
			assert ("nat8 [32] = 15", ba.natural_8_item (32) = 15)
			assert ("hex  [12] = 0b", ba.hex_item (12).is_case_insensitive_equal ("0B"))
			assert ("bin  [12] = 0b", ba.bin_item (12).is_case_insensitive_equal ("00001011"))
			assert ("make from bin", (create {BYTE_ARRAY_CONVERTER}.make_from_bin_string (ba.to_bin_string)).to_hex_string.is_case_insensitive_equal (hex))
			assert ("make from string", (create {BYTE_ARRAY_CONVERTER}.make_from_string (ba.string)).to_hex_string.is_case_insensitive_equal (hex))
			from
				i := 1
				n := ba.count
			until
				i > n
			loop
				assert ("i_th[1]", ba.to_natural_8_array[i] = ba.natural_8_item (i))
				i := i + 1
			end

			hex := "040f"
			create ba.make_from_hex_string (hex)
			assert ("same hex", ba.to_hex_string.is_case_insensitive_equal (hex))
			assert ("nat8 [1] = 4", ba.natural_8_item (1) = 4)
			assert ("nat8 [2] = 15", ba.natural_8_item (2) = 15)
			assert ("make from bin", (create {BYTE_ARRAY_CONVERTER}.make_from_bin_string (ba.to_bin_string)).to_hex_string.is_case_insensitive_equal (hex))
			assert ("make from string", (create {BYTE_ARRAY_CONVERTER}.make_from_string (ba.string)).to_hex_string.is_case_insensitive_equal (hex))
			assert ("make from nat64", (create {BYTE_ARRAY_CONVERTER}.make_from_natural_64 (ba.count, ba.to_natural_64)).to_hex_string.is_case_insensitive_equal (hex))

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
