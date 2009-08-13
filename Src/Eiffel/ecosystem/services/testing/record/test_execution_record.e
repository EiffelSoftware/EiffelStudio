note
	description: "[
		Records containing testing results.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_EXECUTION_RECORD

inherit
	TEST_SESSION_RECORD
		redefine
			make
		end

create {TEST_SESSION_I}
	make

feature {NONE} -- Initialization

	make
			-- <Precursor>
		do
			Precursor
			create result_map.make_default
		end

feature -- Access

	tests: DS_ARRAYED_LIST [READABLE_STRING_GENERAL]
			-- Name of tests for which `Current' contains a result
			--
			-- Note: names are sorted in the order they were originally added to `Current'.
		do
			create Result.make_from_linear (result_map.keys)
		ensure
			result_attached: Result /= Void
			results_valid: Result.for_all (agent has_result (?))
		end

	result_for_name (a_name: READABLE_STRING_GENERAL): EQA_RESULT
			-- Result for test with given name
			--
			-- `a_name': Unique name of test for which result should be returned.
		require
			has_result: has_result (a_name)
		do
			Result := result_map.item (a_name)
		end

	frozen result_for_test (a_test: TEST_I): like result_for_name
			-- Result for given test
			--
			-- `a_test': Test for which result should be returned.
		require
			has_result_for_test: has_result_for_test (a_test)
		do
			Result := result_for_name (a_test.name)
		ensure
			definition: Result = result_for_name (a_test.name)
		end

feature {NONE} -- Access

	result_map: DS_HASH_TABLE [like result_for_name, READABLE_STRING_GENERAL]
			-- Table mapping test names to the corresponding result
			--
			-- Note: names are sorted in the order they were originally added to `Current'.

feature -- Status report

	has_result (a_name: READABLE_STRING_GENERAL): BOOLEAN
			-- Does `Current' have a result for given test name?
			--
			-- `a_name': Unique test name.
		require
			a_name_attached: a_name /= Void
		do
			Result := result_map.has (a_name)
		end

	frozen has_result_for_test (a_test: TEST_I): BOOLEAN
			-- Does `Current' have a result for given test?
			--
			-- `a_test': Arbitrary test.
		require
			a_test_attached: a_test /= Void
			a_test_usable: a_test.is_interface_usable
		do
			Result := has_result (a_test.name)
		ensure
			definition: Result = has_result (a_test.name)
		end

feature {TEST_EXECUTION_I} -- Element change

	add_result (a_test: TEST_I; a_result: like result_for_name)
			-- Add new test result to the end of `result_map'.
			--
			-- `a_test': Test from which result was obtained.
			-- `a_result': New result for test named `a_name'.
		require
			a_test_attached: a_test /= Void
			a_result_attached: a_result /= Void
			a_test_usable: a_test.is_interface_usable
			not_added_yet: not has_result_for_test (a_test)
		do
			result_map.force_last (a_result, a_test.name)
		ensure
			has_result_for_test: has_result_for_test (a_test)
			valid_result: result_for_test (a_test) = a_result
			result_is_last: result_map.last = a_result
		end

invariant
	result_map_attached: result_map /= Void

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
