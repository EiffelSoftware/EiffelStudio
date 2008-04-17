indexing
	description: "[
					All information of one eWeasel test case run result.
					This class can be used for session data storage.
																							]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EWEASEL_TEST_RESULT_ITEM

feature -- Query

	title: STRING_GENERAL
			-- eWeasel test result title

	execution_error_in: STRING_GENERAL
			-- Error line in eWeasel test

	orignal_eweasel_ouput: STRING
			-- eWeasel orignal intact output

	test_run_time: DT_DATE_TIME
			-- Last test run time

	tag: STRING_GENERAL
			-- End user defined tag

	result_type: INTEGER
			-- See value from {EWEASEL_RESULT_TYPE}

	root_class_name: STRING_GENERAL
			-- Root test class name

feature -- General data about current index in whole test run

	total_test_cases_count: INTEGER
			-- How many test cases?

	test_case_result_index: INTEGER
			-- This result's index in all test case runs

feature -- Command

	set_test_run_time (a_time: like test_run_time) is
			-- Set `test_run_time' with `a_time'
		do
			test_run_time := a_time
		ensure
			set: test_run_time = a_time
		end

	set_title (a_text: STRING_GENERAL) is
			-- Set `title' with `a_text'
		do
			title := a_text
		ensure
			set: title = a_text
		end

	set_execution_error_in (a_text: STRING_GENERAL) is
			-- Set `execution_error_in' with `a_text'
		do
			execution_error_in := a_text
		ensure
			set: execution_error_in = a_text
		end

	set_original_eweasel_ouput (a_text: like orignal_eweasel_ouput) is
			-- Set `orignal_eweasel_ouput' with `a_text'
		do
			orignal_eweasel_ouput := a_text
		ensure
			set: orignal_eweasel_ouput = a_text
		end

	set_tag (a_tag: like tag) is
			-- Set `tag' with `a_tag'
		do
			tag := a_tag
		ensure
			set: tag = a_tag
		end

	set_result_type (a_type: like result_type) is
			-- Set `result_type' with `a_type'
		require
			valid: (create {ES_EWEASEL_RESULT_TYPE}).is_valid (a_type)
		do
			result_type := a_type
		ensure
			set: result_type = a_type
		end

	set_root_class_name (a_name: like root_class_name) is
			-- Set `root_class_name' with `a_name'
		do
			root_class_name := a_name
		ensure
			set: root_class_name = a_name
		end

feature -- General data setting

	set_total_test_cases_count (a_count: like total_test_cases_count) is
			-- Set `total_test_cases_count' with `a_count'
		do
			total_test_cases_count := a_count
		ensure
			set: total_test_cases_count = a_count
		end

	set_test_case_result_index (a_count: like test_case_result_index) is
			-- Set `test_case_result_index' with `a_count'
		do
			test_case_result_index := a_count
		ensure
			set: test_case_result_index = a_count
		end

feature -- Contract support

	is_valid: BOOLEAN
			-- If valid?
		do
			Result := title /= Void
		end

feature -- Not used for the moment

	description: STRING_GENERAL
			-- Test result description

	test_result: STRING_GENERAL
			-- Test result

	test_case_folder: STRING_GENERAL
			-- Test case SVN folder

	original_text: STRING_GENERAL
			-- Orignal text in eWeasel

	set_description (a_text: STRING_GENERAL) is
			-- set `description' with `a_text'
		do
			description := a_text
		ensure
			set: description = a_text
		end

	set_test_result (a_text: STRING_GENERAL) is
			-- set `test_result' with `a_text'
		do
			test_result := a_text
		ensure
			set: test_result = a_text
		end

	set_test_case_folder (a_text: STRING_GENERAL) is
			-- set `test_case_folder' with `a_text'
		do
			test_case_folder := a_text
		ensure
			set: test_case_folder = a_text
		end

	set_original_text (a_text: STRING_GENERAL) is
			-- set `orignal_text' with `a_text'
		do
			original_text := a_text
		ensure
			set: original_text = a_text
		end
indexing
	copyright: "Copyright (c) 1984-2008, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
