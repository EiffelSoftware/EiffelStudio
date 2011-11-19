class
	SUITE1

inherit
	ES_SUITE -- This class becomes a suite of unit test classes

create
	make

feature

	make
			-- Need a make routine to initialize the tests
		do
			add_test (create {TEST_1}.make) -- adds a unit tests class to this suite
			add_test (create {TEST_2}.make) -- adds a unit tests class to this suite
		end

end
