indexing
	description: "[
		Objects that represent data for a row in a {ES_TAGABLE_GRID}. Given a layout it will fill the
		corresponding row with items based on the data.
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_TAGABLE_GRID_DATA [G -> TAGABLE_I]

feature -- Access

	row: !EV_GRID_ROW
			-- Row to which `Current' is attached

feature -- Basic functionality

	populate_row (a_layout: ES_TAGABLE_GRID_LAYOUT [TAGABLE_I])
			-- Populate `a_row' with data represented by `Current'.
		deferred
		end

invariant
	row_attached: row.data = Current

end
