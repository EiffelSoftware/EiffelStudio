class TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run the test.
		do
			test_character_8 ("0123456789ABCDEF")
			test_character_8 ("0123456789abcdef")
			test_character_32 ("0123456789ABCDEF")
			test_character_32 ("0123456789abcdef")
			test_character_32 ("０１２３４５６７８９ＡＢＣＤＥＦ")
			test_character_32 ("０１２３４５６７８９ａｂｃｄｅｆ")
		end

feature {NONE} -- Test

	test_character_8 (s: STRING_8)
			-- Test that hexadecimal digits from `s` are correctly converted to their values.
		require
			∀ c: s ¦ c.is_hexa_digit
		do
			across
				s as c
			loop
				if
					c.item.to_hexa_digit /= c.target_index - 1 or else
					c.item.to_reference.to_hexa_digit /= c.target_index - 1
				then
					io.put_string ("Character: '")
					io.put_string (create {STRING_8}.make_filled (c.item, 1))
					io.put_string ("' expected value: ")
					io.put_integer (c.target_index - 1)
					io.put_string ("' actual value: ")
					io.put_natural_8 (c.item.to_hexa_digit)
				end
			end
		end

	test_character_32 (s: STRING_32)
			-- Test that hexadecimal digits from `s` are correctly converted to their values.
		require
			∀ c: s ¦ c.is_hexa_digit
		do
			across
				s as c
			loop
				if
					c.item.to_hexa_digit /= c.target_index - 1 or else
					c.item.to_reference.to_hexa_digit /= c.target_index - 1
				then
					io.put_string ("Character: '")
					io.put_string_32 (create {STRING_32}.make_filled (c.item, 1))
					io.put_string ("' expected value: ")
					io.put_integer (c.target_index - 1)
					io.put_string ("' actual value: ")
					io.put_natural_8 (c.item.to_hexa_digit)
				end
			end
		end

end
