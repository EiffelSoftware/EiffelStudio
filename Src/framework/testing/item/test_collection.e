indexing
	description: "[
		Objects representing an active collection of tests.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEST_COLLECTION

inherit
	TEST_COLLECTION_I

	EVENT_OBSERVER_CONNECTION [!ACTIVE_COLLECTION_OBSERVER [!TEST_I]]

feature {NONE} -- Initialization

	make is
			-- Initialize `Current'
		do
			create test_added_event
			create test_removed_event
			create test_changed_event
			create tests_reset_event
		end

feature -- Events

	test_added_event: !EVENT_TYPE [TUPLE [collection: !ACTIVE_COLLECTION_I [!TEST_I]; active: !TEST_I]]
			-- <Precursor>

	test_removed_event: !EVENT_TYPE [TUPLE [collection: !ACTIVE_COLLECTION_I [!TEST_I]; active: !TEST_I]]
			-- <Precursor>

	test_changed_event: !EVENT_TYPE [TUPLE [collection: !ACTIVE_COLLECTION_I [!TEST_I]; active: !TEST_I]]
			-- <Precursor>

	tests_reset_event: !EVENT_TYPE [TUPLE [collection: !ACTIVE_COLLECTION_I [!TEST_I]]]
			-- <Precursor>

end
