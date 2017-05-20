note
	description: "Providing shared features for ES_TEST and ES_TEST_SUITE classes."
	author: "Software Engineering Lab (York University)"

deferred class
	ES_TESTABLE

inherit
	SHARED_EXECUTION_ENVIRONMENT

feature

	run_espec
			-- New feature instead of `run_all`.
		local
			problem: BOOLEAN
		do
			if not problem then
				run_es_test
				print_console_report
			end
		rescue
			problem := True
			print_to_screen ("Error: No test cases found, Please add ES_TEST classes to the class that inherits from ES_SUITE%N")
			retry
		end

	show_errors
			-- Print error traces to the output.
		do
			show_err := True
		end

	show_browser
			-- Show the default browser.
		do
			browser := True
		end

	set_html_name (s: STRING_8)
			-- Set the output html name.
		do
			default_html_name := s
		end

feature
	set_error_report (v: BOOLEAN)
			-- Show the contract violations if set to true.
		do
			show_err := v
		end

	run_es_test
		deferred
		end

	curr_os_dir_separator: CHARACTER_8
			--  Return path separator for current OS.
		do
			Result := (create {OPERATING_ENVIRONMENT}).Directory_separator
		ensure
			separator_is_a_slash: Result = '/' or Result = '\'
		end

	print_to_screen (message: STRING_8)
			-- Prints the message to the screen, handles both GUI and standard output.
		do
			safe_put_string (message)
		end

	safe_put_string (message: STRING_8)
			-- Socket.putstring with exception handling.
		do
			print (message)
		end

--	check_browser2
--			-- run the browser on the generated HTML
--		local
--			env: EXECUTION_ENVIRONMENT
--			command: STRING_8
--		do
--			create env
--			if browser then
--				if (curr_os_dir_separator = '\') then
--					check
--						attached get_html_name as html_name
--					then
--						command := "%"explorer%" " + (html_name.twin) + "%""
--					end
--					env.launch (command)
--				else
--					check
--						attached get_html_name as html_name
--					then
--						env.launch ("firefox" + " '" + html_name.twin + "'")
--					end
--				end
--			end
--		end


	check_browser
			-- Run the browser on the generated HTML.
		do
			check attached get_html_name end
			if browser then
				if {PLATFORM}.is_windows then
					execution_environment.launch ("%"explorer%" " + get_html_name + "%"")
				elseif {PLATFORM}.is_mac then
					execution_environment.launch ("open" + " '" + get_html_name + "'")
				else
					check{PLATFORM}.is_unix end
					execution_environment.launch ("xdg-open" + " '" + get_html_name + "'")
				end
			end
		end

	get_html_name: STRING_8
			-- Return the name of the default html for this unit test.
		do
			if default_html_name /= Void then
				check
					attached default_html_name as d
				then
					Result := d.twin
				end
			else
				Result := (generating_type.name + ".html").as_string_8
			end
		end

	passed_cases: LIST [STRING]
			-- List of the name of all the successful test cases.
		deferred
		end

	failed_cases: LIST [STRING]
			-- List of the name of all the failed test cases.
		deferred
		end

	print_console_report
			-- Print a summary of all the test case results to the console.
		local
			failed: LIST [STRING]
			success: LIST [STRING]
			passed, total : INTEGER
		do
			failed := failed_cases
			success := passed_cases
			passed := success.count
			total := success.count + failed.count
			io.put_string (create {STRING}.make_filled ('=', 60))
			io.put_new_line
			safe_put_string ("passing tests%N")
			across success as it loop
				safe_put_string ("> " + it.item + "%N")
			end
			safe_put_string ("failing tests%N")
			across failed as it loop
				safe_put_string ("> " + it.item + "%N")
			end
			safe_put_string (passed.out + "/" + total.out + " passed%N")
			if number_of_tests = number_passed_tests then
				safe_put_string ("passed%N")
			else
				safe_put_string ("failed%N")
			end
		end

	default_html_name: detachable STRING_8

	number_of_tests: INTEGER_32

	number_passed_tests: INTEGER_32

	show_err: BOOLEAN

	browser: BOOLEAN

end
