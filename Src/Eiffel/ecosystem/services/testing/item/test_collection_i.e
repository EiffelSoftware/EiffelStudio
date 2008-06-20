indexing
	description: "[
		Observable interface containing a list of tests
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEST_COLLECTION_I

inherit
	TAGABLE_COLLECTION_I [!TEST_I]
		rename
			items as tests,
			item_added_event as test_added_event,
			item_removed_event as test_removed_event,
			item_changed_event as test_changed_event
		end

end
