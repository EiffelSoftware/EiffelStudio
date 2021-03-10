class TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run the test.
		local
			c: CHARACTER_32
		do
			from
			until
					-- Limit checks to the first `0x10000` characters.
				c.natural_32_code >= 0x10000
			loop
				if
					c.is_space /= spaces.has (c) or else
					c.to_reference.is_space /= c.is_space or else
					c.is_character_8 and then c.to_character_8.is_space /= c.is_space or else
					c.is_character_8 and then c.to_character_8.to_reference.is_space /= c.is_space
				then
					report (c)
				end
				c := c + 1
			end
		end

feature {NONE} -- Tests

	spaces: ARRAY [CHARACTER_32]
			-- All characters interpreted as spaces.
		once
			Result := <<
				'%/0x0009/',
				'%/0x000A/',
				'%/0x000B/',
				'%/0x000C/',
				'%/0x000D/',
				'%/0x001C/',
				'%/0x001D/',
				'%/0x001E/',
				'%/0x001F/',
				'%/0x0020/',
				'%/0x0085/',
				'%/0x00A0/',
				'%/0x1680/',
				'%/0x2000/',
				'%/0x2001/',
				'%/0x2002/',
				'%/0x2003/',
				'%/0x2004/',
				'%/0x2005/',
				'%/0x2006/',
				'%/0x2007/',
				'%/0x2008/',
				'%/0x2009/',
				'%/0x200A/',
				'%/0x2028/',
				'%/0x2029/',
				'%/0x202F/',
				'%/0x205F/',
				'%/0x3000/'
			>>
		ensure
			class
			not Result.is_empty
			∀ c: Result ¦ c.natural_32_code > 0
			∀ c: Result ¦ c.natural_32_code < {NATURAL_16}.max_value
			∀ i: Result.lower |..| Result.upper ¦ ∀ j: Result.lower |..| Result.upper ¦ i < j ⇒ Result [i] < Result [j]
		end

feature {NONE} -- Output

	report (c: CHARACTER_32)
			-- Report expected and actual status of the space property for `c`.
		do
			io.put_string ("U+")
			io.put_string (c.natural_32_code.to_natural_16.to_hex_string)
			io.put_string (" expected: ")
			io.put_boolean (spaces.has (c))
			io.put_string (" CHARACTER_32 (ref): ")
			io.put_boolean (c.is_space)
			io.put_string (" (")
			io.put_boolean (c.to_reference.is_space)
			io.put_string (")")
			if c.is_character_8 then
				io.put_string (" CHARACTER_8 (ref): ")
				io.put_boolean (c.to_character_8.is_space)
				io.put_string (" (")
				io.put_boolean (c.to_character_8.to_reference.is_space)
				io.put_string (")")
			end
			io.put_new_line
		end

end
