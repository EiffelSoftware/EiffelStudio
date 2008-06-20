indexing
	description: "[
		An observer for events of {TEST_COLLECTION_I}.
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEST_COLLECTION_OBSERVER

inherit
	ACTIVE_COLLECTION_OBSERVER [!TEST_I]
		rename
			on_item_added as on_test_added,
			on_item_removed as on_test_removed,
			on_item_changed as on_test_changed
		end

end
