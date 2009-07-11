note
	description: "[
		Interface containing a list for which observers can be notified whenever elements are added,
		removed or modified.
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ACTIVE_COLLECTION_I [G -> ACTIVE_ITEM_I]

inherit
	USABLE_I

	DISPOSABLE_I

	EVENT_CONNECTION_POINT_I [ACTIVE_COLLECTION_OBSERVER [G], ACTIVE_COLLECTION_I [G]]
		rename
			connection as active_collection_connection
		end

feature -- Access

	items: DS_LINEAR [G]
			-- List being observed
		require
			usable: is_interface_usable
			available: are_items_available
		deferred
		ensure
			result_consistent: Result = items
				-- Not supported yet
--			results_usable: Result.for_all (agent {!G}.is_interface_usable)
		end

feature -- Status report

	are_items_available: BOOLEAN
			-- Can `items' currently be accessed?
		require
			usable: is_interface_usable
		deferred
		end

feature -- Events

	item_added_event: EVENT_TYPE [TUPLE [collection: ACTIVE_COLLECTION_I [G]; active: G]]
			-- Events called after an item was added to `items'.
			--
			-- collection: `Current'
			-- item: Item which was added to `items'
		require
			usable: is_interface_usable
		deferred
		end

	item_removed_event: EVENT_TYPE [TUPLE [collection: ACTIVE_COLLECTION_I [G]; active: G]]
			-- Events called after an item was removed from `items'.
			--
			-- collection: `Current'
			-- item: Item which was removed from `items'
		require
			usable: is_interface_usable
		deferred
		end

	item_changed_event: EVENT_TYPE [TUPLE [collection: ACTIVE_COLLECTION_I [G]; active: G]]
			-- Events called after the state of an item has changed
			--
			-- collection: `Current'
			-- item: Item in `items' which changed
		require
			usable: is_interface_usable
		deferred
		end

	items_reset_event: EVENT_TYPE [TUPLE [collection: ACTIVE_COLLECTION_I [G]]]
			-- Events called to indicate that `items' is empty and may or may not be available.
			--
			-- collection: `Current'
		require
			usable: is_interface_usable
		deferred
		end

feature -- Events: Connection point

	active_collection_connection: EVENT_CONNECTION_I [ACTIVE_COLLECTION_OBSERVER [G], ACTIVE_COLLECTION_I [G]]
			-- <Precursor>
		local
			l_result: like internal_active_collection_connection
		do
			l_result := internal_active_collection_connection
			if l_result = Void then
				create {EVENT_CONNECTION [ACTIVE_COLLECTION_OBSERVER [G], ACTIVE_COLLECTION_I [G]]} Result.make (
					agent (ia_observer: ACTIVE_COLLECTION_OBSERVER [G]): ARRAY [TUPLE [event: EVENT_TYPE [TUPLE]; action: PROCEDURE [ANY, TUPLE]]]
						do
							Result := <<
								[item_added_event, agent ia_observer.on_item_added],
								[item_removed_event, agent ia_observer.on_item_removed],
								[item_changed_event, agent ia_observer.on_item_changed],
								[items_reset_event, agent ia_observer.on_items_reset] >>
						end)
				automation.auto_dispose (Result)
				internal_active_collection_connection := Result
			else
				Result := l_result
			end
		end

feature {NONE} -- Implementation: Internal cache

	internal_active_collection_connection: EVENT_CONNECTION_I [ACTIVE_COLLECTION_OBSERVER [G], ACTIVE_COLLECTION_I [G]]
			-- Cached version of `active_collection_connection'.
			-- Note: Do not use directly!

end
