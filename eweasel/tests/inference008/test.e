class
	TEST

create
	make

feature {NONE} -- Initialization

	make
			-- Perform test.
		local
			b
			t
			a: SPECIAL [INTEGER]
			s
		do
			t := Current
			b := attached t as x and then attached x.out as o and then not o.is_empty
			create a.make_filled (5, 3)
			s := a
			b := across
				s as c
			all
				c.item = 5
			end
			across
				s as c
			loop
				if attached c.item as x then
					print (x)
				end
			end
			io.put_new_line
		end

end
