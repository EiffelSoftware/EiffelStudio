note
	description: "Summary description for {EWB_TEST_CMD}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EWB_TEST_CMD

inherit
	EWB_CMD

	ES_SHARED_TEST_SERVICE

feature -- Basic operations

	execute
			-- <Precursor>
		do
			if test_suite.is_service_available then
				execute_with_test_suite
			end
		end

feature {NONE} -- Access

	max_identifier_count: INTEGER
		-- Count of longest identifier created by `create_identifier'.

feature {NONE} -- Query

	outcome (a_test: TEST_I): STRING_GENERAL
			-- String representation for the current outcome of `a_test'
		do
			if a_test.is_outcome_available then
				inspect a_test.last_outcome.status
				when {EQA_TEST_OUTCOME_STATUS_TYPES}.passed then
					Result := "passes"
				when {EQA_TEST_OUTCOME_STATUS_TYPES}.failed then
					Result := "FAIL"
				else
					Result := "unresolved"
				end
			else
				Result := "[untested]"
			end
		ensure
			result_attached: Result /= Void
			result_not_empty: not Result.is_empty
			result_not_too_long: Result.count <= max_outcome_count
		end

feature {NONE} -- Basic operations

	print_string (a_string: STRING_GENERAL)
		require
			a_string_attached: a_string /= Void
		do
			command_line_io.localized_print (a_string)
		end

	print_statistics
		require
			test_suite_available: test_suite.is_service_available
		local
			l_service: TEST_SUITE_S
		do
			l_service := test_suite.service
			print_string ("%N")
			print_string (l_service.tests.count.out)
			print_string (" tests (")
			print_string (l_service.count_executed.out)
			print_string (" executed, ")
			print_string (l_service.count_passing.out)
			print_string (" passing, ")
			print_string (l_service.count_failing.out)
			print_string (" failing)")
			print_string (")%N%N")
		end

	print_multiple_string (a_string: STRING_GENERAL; a_count: INTEGER)
		require
			a_count_not_negative: a_count >= 0
		local
			i: INTEGER
		do
			from
				i := 1
			until
				i > a_count
			loop
				print_string (a_string)
				i := i + 1
			end
		end

feature {NONE} -- Implementation

	execute_with_test_suite
		require
			test_suite_available: test_suite.is_service_available
		deferred
		end

feature {NONE} -- Factory

	create_identifier (a_test: TEST_I): STRING_GENERAL
			-- Create a identifier for `a_test'.
		local
			l_id: STRING
		do
			create l_id.make (a_test.name.count + a_test.class_name.count + 1)
			l_id.append (a_test.class_name)
			l_id.append_character ('.')
			l_id.append (a_test.name)
			Result := l_id
			max_identifier_count := max_identifier_count.max (l_id.count)
		ensure
			result_attached: Result /= Void
			result_not_empty: not Result.is_empty
			max_identifier_count_set: max_identifier_count = (old max_identifier_count).max (Result.count)
		end

feature {NONE} -- Constants

	max_outcome_count: INTEGER = 10
			-- Max length for `outcome'

invariant
	max_identifier_count_valid: max_identifier_count >= 0

note
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
			 5949 Hollister Ave., Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end
