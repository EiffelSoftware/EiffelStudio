class 
	TEST

creation
	make

feature {NONE} -- Creation

	make
			-- Run test.
		local
			b: B [INTEGER_8]
		do
			create b.make
		end

end
