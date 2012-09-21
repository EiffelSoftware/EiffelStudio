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
			l_b := l_i >= 1                 -- ok
			l_b := l_i.is_greater_equal (1) -- fails with segmentation violation
			
			l_b := 5 > 0 -- ok
			l_b := (5).is_greater (0)		-- fails with segmentation violation
			   
			l_b := (2).divisible (10)		-- fails with segmentation violation
			
			l_b := (2).exponentiable (10)	-- ok
			l_b := (2).is_hashable	-- ok
			l_b := (2).is_equal (10)	-- ok
		end

end
