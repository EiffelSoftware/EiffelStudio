indexing
	description: "[
		Interface containing a list for which observers can be
		notified whenever elements are added or removed from the list
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ACTIVE_COLLECTION_I [G]

inherit
	EVENT_OBSERVER_CONNECTION_I [!ACTIVE_COLLECTION_OBSERVER [G]]

feature -- Access

	items: !DS_LINEAR [!G]
			-- List being observed
		require
			usable: is_interface_usable
			available: are_items_available
		deferred
		ensure
			result_consistent: Result = items
		end

feature -- Status report

	are_items_available: BOOLEAN
			-- Can `items' currently be accessed?
		require
			usable: is_interface_usable
		deferred
		end

feature {NONE} -- Query

	events (a_observer: !ACTIVE_COLLECTION_OBSERVER [G]): DS_ARRAYED_LIST [TUPLE [event: EVENT_TYPE [TUPLE]; action: PROCEDURE [ANY, TUPLE]]]
			-- <Precursor>
		do
			create Result.make (3)
			Result.put_last ([item_added_event, agent a_observer.on_item_added])
			Result.put_last ([item_removed_event, agent a_observer.on_item_removed])
			Result.put_last ([item_changed_event, agent a_observer.on_item_changed])
			Result.put_last ([items_changed_event, agent a_observer.on_items_changed])
		end

feature -- Events

	item_added_event: !EVENT_TYPE [TUPLE [collection: !ACTIVE_COLLECTION_I [G]; item: !G]]
			-- Called after an item was added to `items'.
			--
			-- collection: `Current'
			-- item: Item which was added to `items'
		require
			usable: is_interface_usable
		deferred
		end

	item_removed_event: !EVENT_TYPE [TUPLE [collection: !ACTIVE_COLLECTION_I [G]; item: !G]]
			-- Called after an item was removed from `items'.
			--
			-- collection: `Current'
			-- item: Item which was removed from `items'
		require
			usable: is_interface_usable
		deferred
		end

	item_changed_event: !EVENT_TYPE [TUPLE [collection: !ACTIVE_COLLECTION_I [G]; item: !G]]
			-- Called after the state of an item has changed
			--
			-- collection: `Current'
			-- item: Item in `items' which changed
		require
			usable: is_interface_usable
		deferred
		end

	items_changed_event: !EVENT_TYPE [TUPLE [collection: !ACTIVE_COLLECTION_I [G]]]
			-- Called to indicate that `items' has changed.
			--
			-- collection: `Current'
		require
			usable: is_interface_usable
		deferred
		end

end
