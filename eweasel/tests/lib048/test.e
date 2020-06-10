class TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run the test.
		local
			c: CHARACTER_8_REF
		do
			create c
			across
				0 |..| 255 is i
			loop
				c.set_item (i.to_character_8)
				if i.to_character_8.as_lower.to_character_32 /= i.to_character_32.as_lower then
					io.put_string ("Code: ")
					io.put_integer (i)
					io.put_string (" CHARACTER_8.as_lower=")
					io.put_integer (i.to_character_8.as_lower.code)
					io.put_string (" CHARACTER_32.as_lower=")
					io.put_integer (i.to_character_32.as_lower.code)
					io.put_new_line
				end
				if c.as_lower.to_character_32 /= i.to_character_32.as_lower then
					io.put_string ("Code: ")
					io.put_integer (i)
					io.put_string (" CHARACTER_8_REF.as_lower=")
					io.put_integer (c.as_lower.code)
					io.put_string (" CHARACTER_32.as_lower=")
					io.put_integer (i.to_character_32.as_lower.code)
					io.put_new_line
				end
				if i.to_character_8.as_upper.to_character_32 /= i.to_character_32.as_upper then
					io.put_string ("Code: ")
					io.put_integer (i)
					io.put_string (" CHARACTER_8.as_upper=")
					io.put_integer (i.to_character_8.as_upper.code)
					io.put_string (" CHARACTER_32.as_upper=")
					io.put_integer (i.to_character_32.as_upper.code)
					io.put_new_line
				end
				if c.as_upper.to_character_32 /= i.to_character_32.as_upper then
					io.put_string ("Code: ")
					io.put_integer (i)
					io.put_string (" CHARACTER_8_REF.as_upper=")
					io.put_integer (c.as_upper.code)
					io.put_string (" CHARACTER_32.as_upper=")
					io.put_integer (i.to_character_32.as_upper.code)
					io.put_new_line
				end
			end
		end

end
