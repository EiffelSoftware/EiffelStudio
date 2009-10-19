note
	description: "[
		Class which provides common functionality to descendants of {TEST_SESSION_RECORD} which contain
		information on a per-test basis. The information associated with the test is the parameter G.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEST_COMMON_SESSION_RECORD [G]

inherit
	TEST_SESSION_RECORD
		redefine
			make
		end

feature {NONE} -- Initialization

	make (a_session: like session)
			-- <Precursor>
		do
			Precursor (a_session)
			create test_map.make (10)
			create internal_tests.make (10)
		end

feature -- Access

	frozen tests: ARRAYED_LIST [READABLE_STRING_8]
			-- Name of tests which are part of `Current'
			--
			-- Note: names are sorted in the order they were originally added to `test_map'.
		do
			Result := internal_tests.twin
		ensure
			result_attached: Result /= Void

		end

	item_for_name (a_name: READABLE_STRING_8): G
			-- Result for test with given name
			--
			-- `a_name': Unique name of test for which result should be returned.
		require
			has_item: has_item (a_name)
		do
			Result := test_map.item (a_name)
		end

	frozen item_for_test (a_test: TEST_I): like item_for_name
			-- Item for given test
			--
			-- `a_test': Test for which result should be returned.
		require
			has_result_for_test: has_item_for_test (a_test)
		do
			Result := item_for_name (a_test.name)
		ensure
			definition: Result = item_for_name (a_test.name)
		end

feature {NONE} -- Access

	internal_tests: ARRAYED_LIST [READABLE_STRING_8]
			-- List containing all test names (keys of `test_map') in the order they are represented in by
			-- `Current'

	test_map: TAG_HASH_TABLE [G]
			-- Table mapping names of tests to the corresponding information.
			--
			-- keys: Names of tests.
			-- values: Corresponding information.

feature -- Status report

	has_item (a_name: READABLE_STRING_8): BOOLEAN
			-- Does `Current' have an item for given name?
			--
			-- `a_name': Unique test name.
		require
			a_name_attached: a_name /= Void
		do
			Result := test_map.has (a_name)
		ensure
			definition: Result = test_map.has (a_name)
		end

	frozen has_item_for_test (a_test: TEST_I): BOOLEAN
			-- Does `Current' have an item for given test?
			--
			-- `a_test': Arbitrary test.
		require
			a_test_attached: a_test /= Void
			a_test_usable: a_test.is_interface_usable
		do
			Result := has_item (a_test.name)
		ensure
			definition: Result = has_item (a_test.name)
		end

feature {NONE} -- Element change

	add_item (an_item: G; a_name: IMMUTABLE_STRING_8)
			-- Add given item to `test_map' associated with name which is appended to then end of `tests'.
			--
			-- `an_item': Item to be added to `test_map'.
			-- `a_name': Test name associated with `an_item'.
		require
			an_item_attached: an_item /= Void
			a_name_attached: a_name /= Void
			not_added_yet: not has_item (a_name)
		do
			internal_tests.force (a_name)
			test_map.force (an_item, a_name)
		ensure
			added: has_item (a_name)
			added_item: item_for_name (a_name) = an_item
			added_last: internal_tests.last = a_name
		end

invariant
	test_map_attached: test_map /= Void
	internal_tests_count_equals_test_map_count: internal_tests.count = test_map.count
	internal_tests_contains_test_map_keys: internal_tests.for_all (
		agent (a_name: READABLE_STRING_8): BOOLEAN
			do
				Result := test_map.has (a_name)
			end)

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
