class 
	TEST
create
	make

feature
	
	make
		local
			i: INTEGER
			c: CHARACTER_32
		do
			io.put_string ("To lower:%N")
			from
				i := 0
			until
				i > 65535
			loop
				c := i.to_character_32.as_lower
				if (c /= i.to_character_32) then
					io.put_integer (i)
					io.put_character (' ')
					io.put_natural_32 (c.natural_32_code)
					io.put_character ('%N')
				end
				i := i + 1
			end

			io.put_string ("%NTo upper:%N")
			from
				i := 0
			until
				i > 65535
			loop
				c := i.to_character_32.as_upper
				if (c /= i.to_character_32) then
					io.put_integer (i)
					io.put_character (' ')
					io.put_natural_32 (c.natural_32_code)
					io.put_character ('%N')
				end
				i := i + 1
			end

		end

end

