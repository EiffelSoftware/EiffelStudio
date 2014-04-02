class APPLICATION_TEST

create
	make

feature -- Initialization

	make
		local
			l_test: ESA_ROOT_API_TEST
		do
			create l_test
			l_test.test_home_unnaceptable
			l_test.test_home_accept_cj
			l_test.test_home_accept_html
		end

end
