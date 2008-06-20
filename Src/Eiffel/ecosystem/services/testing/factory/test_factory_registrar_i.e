indexing
	description: "[
		Interface of an registrar for test factories
		
		Instances of factories can be registered or unregistered based
		on their type. Clients can then query for a certain factories.
		
		Add and remove events are observerable so clients can be
		notified when a new factory is available or beeing disposed.	
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEST_FACTORY_REGISTRAR_I

inherit
	USABLE_I

	ACTIVE_COLLECTION_I [!TEST_FACTORY_I [TEST_CONFIGURATION_I]]
		rename
			items as factories,
			item_added_event as factory_added_event,
			item_removed_event as factory_removed_event
		redefine
			factories
		end

feature -- Access

	factories: !DS_BILINEAR [!TEST_FACTORY_I [TEST_CONFIGURATION_I]]
			-- List of registered factories
		deferred
		ensure then
			result_contains_usable_items: Result.for_all (agent {!TEST_FACTORY_I [TEST_CONFIGURATION_I]}.is_interface_usable)
		end

feature -- Status report

	is_registered (a_type: !TYPE [TEST_FACTORY_I [TEST_CONFIGURATION_I]]): BOOLEAN
			-- Is a factory available for `a_type'?
		require
			is_interface_usable: is_interface_usable
		deferred
		end

feature -- Query

	factory (a_type: !TYPE [TEST_FACTORY_I [TEST_CONFIGURATION_I]]): !TEST_FACTORY_I [TEST_CONFIGURATION_I]
			-- Registered factory associated with `a_type'
		require
			is_interface_usable: is_interface_usable
			a_type_is_registered: is_registered (a_type)
		deferred
		ensure
			result_is_interface_usable: Result.is_interface_usable
			factories_has_result: factories.has (Result)
		end

feature -- Basic operations

	register (a_factory: !TEST_FACTORY_I [TEST_CONFIGURATION_I]; a_type: !TYPE [TEST_FACTORY_I [TEST_CONFIGURATION_I]])
			-- Register `a_factory' associated with `a_type'
		require
			is_interface_usable: is_interface_usable
			a_factory_is_interface_usable: a_factory.is_interface_usable
			not_is_registered: not is_registered (a_type)
		deferred
		ensure
			is_registered: is_registered (a_type)
			factories_has_a_factory: factories.has (a_factory)
		end

	unregister (a_type: !TYPE [TEST_FACTORY_I [TEST_CONFIGURATION_I]])
			-- Unregister factory associated with `a_type'
		require
			is_interface_usable: is_interface_usable
			is_registered: is_registered (a_type)
		deferred
		ensure
			not_is_registered: not is_registered (a_type)
		end

end
