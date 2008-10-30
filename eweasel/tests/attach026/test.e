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
			l_test.display

			create l_test.make
			l_test.display
		end

end
