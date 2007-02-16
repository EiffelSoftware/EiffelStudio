indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_GRID_PICKABLE_ITEM

feature -- Access

	grid_item: EV_GRID_ITEM is
			-- Grid item
		deferred
		ensure
			result_attached: Result /= Void
		end

	last_picked_item: INTEGER
			-- Index of last picked component

	set_last_picked_item (a_index: INTEGER) is
			-- Set `last_picked_item' with `a_index'.
		require
			not_a_index_is_negative: a_index >= 0
		do
			last_picked_item := a_index
		ensure
			last_picked_item_set: last_picked_item = a_index
		end

feature -- Actions

	on_pick: ANY is
			-- Action to be performed when pick starts
			-- Return value is the picked pebble if any.
		deferred
		end

	on_pick_ends is
			-- Action to be performed hwne pick-and-drop finishes
		deferred
		end

end
