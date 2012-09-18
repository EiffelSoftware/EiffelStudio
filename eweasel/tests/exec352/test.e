class
	TEST

create
	make

feature {NONE} -- Initialization

	make
		local
			l_i : INTEGER_32
			l_b : BOOLEAN
		do
			l_i := 5
			l_b := l_i >= 1                 -- This works
			l_b := l_i.is_greater_equal (1) -- This fails with segmentation violation
		end

end
