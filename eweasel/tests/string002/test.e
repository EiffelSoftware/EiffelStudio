class 
	TEST
create
	make

feature
	
	make
		local
			c, i: CHARACTER_32
		do
			io.put_string ("To lower:%N")
			from
				i := '%U'
			until
				i > {CHARACTER_32}.max_unicode_value.to_character_32
			loop
				c := i.as_lower
				if (c /= i) then
					io.put_natural_32 (i.natural_32_code)
					io.put_character (' ')
					io.put_natural_32 (c.natural_32_code)
					io.put_character ('%N')
				end
				i := i + 1
			end

			io.put_string ("%NTo upper:%N")
			from
				i := '%U'
			until
				i > {CHARACTER_32}.max_unicode_value.to_character_32
			loop
				c := i.as_upper
				if (c /= i) then
					io.put_natural_32 (i.natural_32_code)
					io.put_character (' ')
					io.put_natural_32 (c.natural_32_code)
					io.put_character ('%N')
				end
				i := i + 1
			end

		end

end

