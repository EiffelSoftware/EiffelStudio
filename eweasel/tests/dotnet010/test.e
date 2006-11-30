class TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Run test.
		local
			l_cell1, l_cell2: MY_CELL [STRING]
			s: STRING
		do
			s := "This is a nice string"
			create l_cell1.put (s)
			create l_cell2.put (s)

			print (l_cell1.is_equal (l_cell2))
			print ("%N")
		end

end
