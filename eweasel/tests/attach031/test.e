class
	TEST

create
	make

feature {NONE} -- Initialization

	make
		local
			l_test: ATTRIBUTES
		do
			create l_test
			print (l_test.test_a)
			print ("%N")
		end

end

