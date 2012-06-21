note
	description: "Providing shared features for ES_TEST and ES_TEST_SUITE classes"
	author: "Software Engineering Lab (York University)"

deferred class
	ES_TESTABLE

feature

	run_espec
			-- new feature instead of run_all
		local
			problem: BOOLEAN
		do
			if not problem then
				run_es_test
			end
		rescue
			problem := True
			print_to_screen ("Error: No test cases found, Please add ES_TEST classes to the class that inherits from ES_SUITE%N")
			retry
		end

	show_errors
			-- print error traces to the output
		do
			show_err := True
		end

	show_browser
			--shows the default browser
		do
			browser := True
		end

	set_html_name (s: STRING_8)
			-- set the output html name
		do
			default_html_name := s
		end



feature 
	set_error_report (v: BOOLEAN)
			-- show the contract violations if set to true
		do
			show_err := v
		end

	run_es_test
		deferred
		end

	curr_os_dir_separator: CHARACTER_8
			--  return path separator for current OS
		do
			Result := (create {OPERATING_ENVIRONMENT}).Directory_separator
		ensure
			separator_is_a_slash: Result = '/' or Result = '\'
		end

	print_to_screen (message: STRING_8)
			-- prints the message to the screen, handles both GUI and standard output
		do
			safe_put_string (message)
		end

	safe_put_string (message: STRING_8)
			-- socket.putstring with exception handling
		do
			print (message)
		end

	check_browser
			-- run the browser on the generated HTML
		local
			env: EXECUTION_ENVIRONMENT
			command: STRING_8
		do
			create env
			if browser then
				if (curr_os_dir_separator = '\') then
					check
						attached get_html_name as html_name
					then
						command := "%"explorer%" " + (html_name.twin) + "%""
					end
					env.launch (command)
				else
					check
						attached get_html_name as html_name
					then
						env.launch ("firefox" + " '" + html_name.twin + "'")
					end
				end
			end
		end


	get_html_name: STRING_8
			-- return the name of the default html for this unit test
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

	default_html_name: detachable STRING_8

	number_of_tests: INTEGER_32

	number_passed_tests: INTEGER_32

	show_err: BOOLEAN

	browser: BOOLEAN

end -- class ES_TESTABLE

