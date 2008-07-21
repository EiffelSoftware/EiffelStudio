indexing
	description: "[
		Observer for events in {EIFFEL_TEST_PROCESSOR_I]
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EIFFEL_TEST_PROCESSOR_OBSERVER

inherit
	ACTIVE_COLLECTION_OBSERVER [!EIFFEL_TEST_I]

feature -- Events

	on_status_changed (a_processor: !EIFFEL_TEST_PROCESSOR_I [ANY])
			-- Called when processor changes its status
			--
			-- `a_processor': Processor that changed its status.
		require
			usable: is_interface_usable
			a_processor_usable: a_processor.is_interface_usable
		do
		end

end
