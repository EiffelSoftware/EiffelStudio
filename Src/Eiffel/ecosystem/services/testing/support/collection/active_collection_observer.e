indexing
	description: "[
		Observer for events in {ACTIVE_COLLECTION_I}
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	ACTIVE_COLLECTION_OBSERVER [G -> ACTIVE_ITEM_I]

inherit
	EVENT_OBSERVER_I

feature {ACTIVE_COLLECTION_I} -- Events

	on_item_added (a_collection: !ACTIVE_COLLECTION_I [G]; a_item: !G) is
			-- Called when `a_item' is added to items in `a_collection'.
		require
			is_interface_usable: {l_usable: USABLE_I} Current implies l_usable.is_interface_usable
			a_collection_usable: a_collection.is_interface_usable
			a_item_usable: a_item.is_interface_usable
			a_collection_contains_a_item: a_collection.items.has (a_item)
		do
		end

	on_item_removed (a_collection: !ACTIVE_COLLECTION_I [G]; a_item: !G)
			-- Called when `a_item' is removed from items in `a_collection'.
		require
			is_interface_usable: {l_usable: USABLE_I} Current implies l_usable.is_interface_usable
			a_collection_usable: a_collection.is_interface_usable
			not_a_collection_contains_a_item: not a_collection.items.has (a_item)
		do
		end

	on_item_changed (a_collection: !ACTIVE_COLLECTION_I [G]; a_item: !G)
			-- Called when `a_item' has changed in items of `a_collection'.
		require
			is_interface_usable: {l_usable: USABLE_I} Current implies l_usable.is_interface_usable
			a_collection_usable: a_collection.is_interface_usable
			a_collection_contains_a_item: a_collection.items.has (a_item)
			a_item_usable: a_item.is_interface_usable
			a_item_changed: a_item.has_changed
		do
		end

	on_items_reset (a_collection: !ACTIVE_COLLECTION_I [G]) is
			-- Called when items of `a_collection' have been wiped out and may or may not be available.
		require
			is_interface_usable: {l_usable: USABLE_I} Current implies l_usable.is_interface_usable
			a_collection_usable: a_collection.is_interface_usable
			items_wiped_out: a_collection.are_items_available implies a_collection.items.is_empty
		do
		end

	frozen hacked_on_item_added (a_collection: !ACTIVE_COLLECTION_I [G]; a_item: !G) is
			-- Called when `a_item' is added to items in `a_collection'.
		require
			is_interface_usable: {l_usable: USABLE_I} Current implies l_usable.is_interface_usable
			a_collection_usable: a_collection.is_interface_usable
			a_item_usable: a_item.is_interface_usable
			a_collection_contains_a_item: a_collection.items.has (a_item)
		do
			on_item_added (a_collection, a_item)
		end

	frozen hacked_on_item_removed (a_collection: !ACTIVE_COLLECTION_I [G]; a_item: !G)
			-- Called when `a_item' is removed from items in `a_collection'.
		require
			is_interface_usable: {l_usable: USABLE_I} Current implies l_usable.is_interface_usable
			a_collection_usable: a_collection.is_interface_usable
			not_a_collection_contains_a_item: not a_collection.items.has (a_item)
		do
			on_item_removed (a_collection, a_item)
		end

	frozen hacked_on_item_changed (a_collection: !ACTIVE_COLLECTION_I [G]; a_item: !G)
			-- Called when `a_item' has changed in items of `a_collection'.
		require
			is_interface_usable: {l_usable: USABLE_I} Current implies l_usable.is_interface_usable
			a_collection_usable: a_collection.is_interface_usable
			a_collection_contains_a_item: a_collection.items.has (a_item)
			a_item_usable: a_item.is_interface_usable
			a_item_changed: a_item.has_changed
		do
			on_item_changed (a_collection, a_item)
		end

	frozen hacked_on_items_reset (a_collection: !ACTIVE_COLLECTION_I [G]) is
			-- Called when items of `a_collection' have been wiped out and may or may not be available.
		require
			is_interface_usable: {l_usable: USABLE_I} Current implies l_usable.is_interface_usable
			a_collection_usable: a_collection.is_interface_usable
			items_wiped_out: a_collection.are_items_available implies a_collection.items.is_empty
		do
			on_items_reset (a_collection)
		end

end
