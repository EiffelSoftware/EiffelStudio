note
	description: "Single element inventory"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	INVENTORY

create
	make

feature -- Initialization

	make
			-- Initialize with empty.
		do
			implementation := 0
		ensure
			empty: not has_item
		end

feature -- Access

	item: INTEGER
			-- Current item
		require
			inventory_has_item: has_item
		do
			Result := implementation.item
		end

feature -- Status report

	has_item: BOOLEAN
			-- Is there an item in inventory?
		do
			Result := implementation.item > 0
		end

feature -- Element change

	put (a_value: INTEGER)
			-- Enter value of `a_value' into inventory.
		require
			valid_value: a_value > 0
			inventory_empty: not has_item
		do
			implementation := a_value
		ensure
			entered: has_item and then item = a_value
		end

	remove
			-- Empty inventory.
		require
			inventory_has_item: has_item
		do
			implementation := 0
		ensure
			empty: not has_item
		end

feature -- Implementation

	implementation: INTEGER
			-- Implementation of inventory item. Zero when empty, otherwise the item's value.

invariant

	valid_implementation: implementation >= 0
	empty_definition: not has_item implies implementation = 0
end
