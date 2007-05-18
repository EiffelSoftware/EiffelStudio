class TEST

create
	make

feature {NONE} -- Creation
	
	make is 
			-- Run test.
		local
			a: A [ANY]
		do
			create {C} a.make
			io.put_string (a.a.out)
			io.put_new_line
			a.f (2)
			a.g (3)
			a.h (4)
		end

end
