indexing
	description: "[
		Interface of an registrar for test executors
		
		Instances of executors can be registered or unregistered based
		on their type. Clients can then query for a certain executor.
		
		Add and remove events are observerable so clients can be
		notified when a new executor is available or beeing disposed.
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEST_EXECUTOR_REGISTRAR_I

inherit
	USABLE_I

	ACTIVE_COLLECTION_I [!TEST_EXECUTOR_I]
		rename
			items as executors,
			item_added_event as executor_added_event,
			item_removed_event as executor_removed_event
		redefine
			executors
		end

feature -- Access

	executors: !DS_BILINEAR [!TEST_EXECUTOR_I]
			-- List of registered executors
		deferred
		ensure then
			result_contains_usable_items: Result.for_all (agent {!TEST_EXECUTOR_I}.is_interface_usable)
		end

feature -- Status report

	is_registered (a_type: !TYPE [TEST_EXECUTOR_I]): BOOLEAN
			-- Is an executor available for `a_type'?
		require
			is_interface_usable: is_interface_usable
		deferred
		end

feature -- Query

	executor (a_type: !TYPE [TEST_EXECUTOR_I]): !TEST_EXECUTOR_I
			-- Registered executor associated with `a_type'
		require
			is_interface_usable: is_interface_usable
			a_type_is_registered: is_registered (a_type)
		deferred
		ensure
			result_is_interface_usable: Result.is_interface_usable
			executors_has_result: executors.has (Result)
			conforming_type: a_type.attempt (Result) /= Void
		end

feature -- Basic operations

	register (a_executor: !TEST_EXECUTOR_I; a_type: !TYPE [TEST_EXECUTOR_I]) is
			-- Register `a_executor' associated with `a_type'
		require
			is_interface_usable: is_interface_usable
			a_executor_is_interface_usable: a_executor.is_interface_usable
			conforming_type: a_type.attempt (a_executor) /= Void
			not_is_registered: not is_registered (a_type)
		deferred
		ensure
			is_registered: is_registered (a_type)
			executors_has_a_executor: executors.has (a_executor)
		end

	unregister (a_type: !TYPE [TEST_EXECUTOR_I])
			-- Unregister executor associated with `a_type'
		require
			is_interface_usable: is_interface_usable
			is_registered: is_registered (a_type)
		deferred
		ensure
			not_is_registered: not is_registered (a_type)
		end

end
