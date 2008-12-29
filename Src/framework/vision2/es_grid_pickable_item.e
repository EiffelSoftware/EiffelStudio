note
	description: "Grid item which supports customized defined pick behavior"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_GRID_PICKABLE_ITEM

feature -- Access

	grid_item: EV_GRID_ITEM
			-- Grid item
		deferred
		ensure
			result_attached: Result /= Void
		end

	last_picked_item: INTEGER
			-- Index of last picked component

	set_last_picked_item (a_index: INTEGER)
			-- Set `last_picked_item' with `a_index'.
		require
			not_a_index_is_negative: a_index >= 0
		do
			last_picked_item := a_index
		ensure
			last_picked_item_set: last_picked_item = a_index
		end

	pebble_at_position: ANY
			-- Pebble at pointer position
			-- Void if no pebble found at that position
		deferred
		end

feature -- Actions

	on_pick: ANY
			-- Action to be performed when pick starts
			-- Return value is the picked pebble if any.
		deferred
		end

	on_pick_ends
			-- Action to be performed hwne pick-and-drop finishes
		deferred
		end

end
