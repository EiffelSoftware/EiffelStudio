indexing
	description: "[
		Interface containing a list for which observers can be
		notified whenever elements are added or removed from the list
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ACTIVE_COLLECTION_I [G -> USABLE_I]

inherit
	EVENT_OBSERVER_CONNECTION_I [!ACTIVE_COLLECTION_OBSERVER [G]]

	USABLE_I

feature -- Access

	items: !DS_LINEAR [!G]
			-- List being observed
		require
			interface_usable: is_interface_usable
		deferred
		ensure
			result_consistent: Result = items
			result_contains_usable_items: Result.for_all (agent (v: !G): BOOLEAN do Result := v.is_interface_usable end)
		end

feature {NONE} -- Query

	events (a_observer: !ACTIVE_COLLECTION_OBSERVER [G]): DS_ARRAYED_LIST [TUPLE [event: EVENT_TYPE [TUPLE]; action: PROCEDURE [ANY, TUPLE]]]
			-- <Precursor>
		do
			create Result.make (3)
			Result.put_last ([item_added_event, agent a_observer.on_item_added])
			Result.put_last ([item_removed_event, agent a_observer.on_item_removed])
			Result.put_last ([item_changed_event, agent a_observer.on_item_changed])
		end

feature -- Events

	item_added_event: EVENT_TYPE [TUPLE [collection: !ACTIVE_COLLECTION_I [G]; item: !G]]
			-- Called when an item is added to `items'
		require
			is_interface_usable: is_interface_usable
		deferred
		end

	item_removed_event: EVENT_TYPE [TUPLE [collection: !ACTIVE_COLLECTION_I [G]; item: !G]]
			-- Called when an item is removed from `items'
		require
			is_interface_usable: is_interface_usable
		deferred
		end

	item_changed_event: EVENT_TYPE [TUPLE [collection: !ACTIVE_COLLECTION_I [G]; item: !G]]
			-- Called when an item is removed from `items'
		require
			is_interface_usable: is_interface_usable
		deferred
		end

end
