class TEST

create 
	make

feature {NONE} -- Creation

	make is
			-- Run test.
		local
			one: POINTER
			two: POINTER
			three: POINTER
			a: ARRAY [POINTER]
			b: SPECIAL [POINTER]
		do
			create a.make (1, 1)
			b := a.area
			one := $b
			two := b.base_address
			three := b.item_address (0)
			print (one = two)
			io.put_new_line
			print (two = three)
			io.put_new_line
			print (one = three)
			io.put_new_line
		end

end
