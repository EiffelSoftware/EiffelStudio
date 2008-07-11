indexing
	description: "[
		Interface representing an active collection containing a list of tests.	
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEST_COLLECTION_I

inherit
	ACTIVE_COLLECTION_I [!TEST_I]
		rename
			items as tests,
			are_items_available as are_tests_available,
			item_added_event as test_added_event,
			item_removed_event as test_removed_event,
			item_changed_event as test_changed_event,
			items_changed_event as tests_refreshed_event
		end

feature -- Access

	tests: !DS_LINEAR [!TEST_I]
			-- <Precursor>
		deferred
		ensure then
			result_contains_usables: ({!DS_LINEAR [!USABLE_I]} #? Result).for_all (agent {!USABLE_I}.is_interface_usable)
		end

feature -- Query

	is_subset (a_list: like tests): BOOLEAN
			-- Are all items of some list also in `tests'?
			--
			-- `a_list': Arbitrary list of tests.
			-- `Result': True if all tests in `a_list' are also in `tests', False otherwise.
		require
			usable: is_interface_usable
		do
			Result := a_list.for_all (agent tests.has)
		end

end
