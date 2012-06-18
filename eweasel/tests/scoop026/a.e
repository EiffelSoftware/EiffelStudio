class
	A

create
	make

feature {NONE} -- Creation

	make (a_test: separate TEST)
			-- Initialize `Current'
		do
			test := a_test
		end

feature

	perform_creation_logging
		do
			test_test (test)
		end

	test_test (a_test: separate TEST)
		do
			a_test.test_test
		end

	test: separate TEST

end
