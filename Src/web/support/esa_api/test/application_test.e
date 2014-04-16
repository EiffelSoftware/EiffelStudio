class APPLICATION_TEST

create
	make

feature -- Initialization

	make
		do
--			l_root_api_test
			l_register_api_test
		end



	l_root_api_test
		local
			l_test: ESA_ROOT_API_TEST
		do
			create l_test
			l_test.test_home_unnaceptable
			l_test.test_home_accept_cj
			l_test.test_home_accept_html
		end

	l_register_api_test
		local
			l_test: ESA_REGISTER_API_TEST
		do
			create l_test
			l_test.test_register_html_get_request
		end


end
