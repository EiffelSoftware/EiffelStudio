indexing
	description: "[
		Observer for events in {ACTIVE_COLLECTION_I}
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ACTIVE_COLLECTION_OBSERVER [G]

inherit
	EVENT_OBSERVER_I

feature {ACTIVE_COLLECTION_I} -- Events

	on_item_added (a_collection: !ACTIVE_COLLECTION_I [G]; a_item: !G)
			-- Called when `a_item' is added to items in `a_collection'.
		require
			is_interface_usable: is_interface_usable
			a_collection_usable: a_collection.is_interface_usable
			a_collection_contains_a_item: a_collection.items.has (a_item)
			a_collection_observed: a_collection.is_connected (Current)
		do
		end

	on_item_removed (a_collection: !ACTIVE_COLLECTION_I [G]; a_item: !G)
			-- Called when `a_item' is removed from items in `a_collection'.
		require
			is_interface_usable: is_interface_usable
			a_collection_usable: a_collection.is_interface_usable
			not_a_collection_contains_a_item: not a_collection.items.has (a_item)
			a_collection_observed: a_collection.is_connected (Current)
		do
		end

	on_item_changed (a_collection: !ACTIVE_COLLECTION_I [G]; a_item: !G)
			-- Called when `a_item' has changed in items of `a_collection'.
		require
			is_interface_usable: is_interface_usable
			a_collection_usable: a_collection.is_interface_usable
			a_collection_contains_a_item: a_collection.items.has (a_item)
			a_collection_observed: a_collection.is_connected (Current)
		do
		end

	on_items_changed (a_collection: !ACTIVE_COLLECTION_I [G]; a_item: !G) is
			-- Called when items of `a_collection' have completely changed
		require
			is_interface_usable: is_interface_usable
			a_collection_usable: a_collection.is_interface_usable
			a_collection_observed: a_collection.is_connected (Current)
		do
		end

end
