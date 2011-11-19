note
	description : "Example of a Test Suite class"
	date        : "$April 29, 2010$"
	revision    : "$1.0$"

class
	APPLICATION

inherit
	ES_SUITE -- This class becomes a suite of unit test classes

create
	make

feature {NONE}

	make
			-- Need a make routine to initialize the tests
		do
			add_test (create {TEST_1}.make) -- adds a unit tests class to this suite
			add_test (create {TEST_2}.make) -- adds a unit tests class to this suite
			add_suite (create {SUITE1}.make) -- adds a suite of tests to this suite
			add_suite (create {SUITE2}.make) -- adds a suite of tests to this suite
			-- add more unit tests/suites if needed
			set_html_name ("results1.html") -- changes the name of the result html file (to be shown in the browser) [optional]
			show_browser -- this shows the HTML results in a browser at the end of tests [optional]
			show_errors -- this shows the full error trace in the HTML generated (this will show erros in all test cases as well)
			run_espec -- this causes tests to run [required]
		end

end
