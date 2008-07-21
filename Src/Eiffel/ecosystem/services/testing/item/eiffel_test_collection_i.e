indexing
	description: "[
		Interface representing an active collection containing a list of tests.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EIFFEL_TEST_COLLECTION_I

inherit
	ACTIVE_COLLECTION_I [!EIFFEL_TEST_I]
		rename
			items as tests,
			are_items_available as are_tests_available,
			item_added_event as test_added_event,
			item_removed_event as test_removed_event,
			item_changed_event as test_changed_event,
			items_wiped_out_event as tests_wiped_out_event
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
