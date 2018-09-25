class
	TEST

create
	make

feature

	make
		local
			c, i: CHARACTER_32
			p: CHARACTER_PROPERTY
		do
			io.put_string ("To lower:%N")
			from
				i := '%U'
			until
				i > {CHARACTER_32}.max_unicode_value.to_character_32
			loop
				c := i.as_lower
				if c /= i then
					put (i)
					io.put_character (' ')
					put (c)
					io.put_new_line
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
				if c /= i then
					put (i)
					io.put_character (' ')
					put (c)
					io.put_new_line
				end
				i := i + 1
			end

			io.put_string ("%NTo upper and title:%N")
			from
				create p.make
				i := '%U'
			until
				i > {CHARACTER_32}.max_unicode_value.to_character_32
			loop
				c := p.to_title (i)
				if c /= p.to_upper (i) then
					put (i)
					io.put_character (' ')
					put (p.to_upper (i))
					io.put_character (' ')
					put (c)
					io.put_new_line
				end
				i := i + 1
			end
		end

feature {NONE} -- Output

	put (c: CHARACTER_32)
			-- Print Unicode code of `c`.
		local
			s: STRING
		do
			from
					-- Strip 4 leading zeroes.
				s := c.natural_32_code.to_hex_string
			until
				s.count <= 4 or else s [1] /= '0'
			loop
				s.remove (1)
			end
			io.put_string (s)
		end

end

