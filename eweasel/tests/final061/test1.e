class
	TEST1 [G]

create 
	make

feature

	make is
		local
			t2: TEST2 [INTEGER, G]
		do
			t2.set_value (Void)
		end

end
