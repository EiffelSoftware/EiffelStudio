indexing
	description: "Abstract test root class"
	keywords:    "test application"
	revision:    "%%A%%"
	source:      "%%P%%"
	copyright:   "See notice at end of class"

deferred class TEST_SUITE

feature -- Access
	test_cases:LINKED_LIST[TEST_CASE] is
			-- the list of tests available
		deferred
		end

	title:STRING is
	        -- title of this suite of tests
	    deferred
	    end

feature -- Initialisation
	make(arg:ANY) is
		deferred
		end

	finalise is
		deferred
		end

feature -- Execution
	do_all is
		local
			str:STRING
		do
			!!test_case_results.make(0)
			io.put_string("===============> Executing All Test Cases in Suite%N")

			from test_cases.start until test_cases.off loop
	 			io.put_string("----------- TC ") io.put_string(test_cases.item.title) io.put_string(" -----------%N")
				test_cases.item.execute
				test_cases.item.check_result
				!!str.make(0) str.append("TC ") str.append(test_cases.item.title)
				if test_cases.item.failed then
					str.append(" FAILED; reason: ") str.append(test_cases.item.fail_reason)
				else
					str.append(" PASSED")
				end
				test_case_results.extend(str)
				test_cases.forth
			end
			io.put_string("---------------------------------%N")
	    end

	display_results is
		do
			io.put_string("RESULTS:%N")
			from test_case_results.start until test_case_results.off loop
				io.put_string(test_case_results.item) io.new_line
				test_case_results.forth
			end
		end

	store_results(a_directory:STRING) is
		require
			Directory_exists: a_directory /= Void
		local
			result_file:PLAIN_TEXT_FILE
			directory:STRING
		do
			directory := clone(a_directory)
			directory.append_character(operating_environment.directory_separator)
			directory.append(title)
			directory.replace_substring_all(" ", "_")
			directory.append(".txt")
			!!result_file.make_create_read_write(directory)
			if result_file.exists then
				io.put_string("Writing to file ") io.put_string(directory) io.new_line
				from test_case_results.start until test_case_results.off loop
					result_file.put_string(test_case_results.item) result_file.new_line
					test_case_results.forth
				end
				result_file.close
			else
				io.put_string("Failed to create file ") io.put_string(directory) io.new_line
			end
		end


feature -- Access
	test_case_results:ARRAYED_LIST[STRING]	

end

--         +---------------------------------------------------+
--         |                                                   |
--         |                 Copyright (c) 1998                |
--         |           Deep Thought Informatics Pty Ltd        |
--         |        Australian Company Number 076 645 291      |
--         |                                                   |
--         | Duplication,   modification   and   distribution  |
--         | permitted with this notice  intact.  Please send  |
--         | modifications  and suggestions  to  Deep Thought  |
--         | Informatics, in  the  interests  of  maintenance  |
--         | and improvement.                                  |
--         |                                                   |
--         | Use of this software is on the understanding that |
--         | the  author(s)  accept no  liability of any kind. |
--         |                                                   |
--         |           email: info@deepthought.com.au          |
--         |                                                   |
--         +---------------------------------------------------+

