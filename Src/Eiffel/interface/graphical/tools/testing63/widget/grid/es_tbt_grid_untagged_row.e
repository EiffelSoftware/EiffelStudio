indexing
	description: "[
		Objects representing the row having subrows for all untagged items in a {ES_TBT_GRID}.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TBT_GRID_UNTAGGED_ROW [G -> TAGABLE_I]

inherit
	ES_TBT_GRID_DATA [G]

create
	make

feature {NONE} -- Initialization

	make (a_row: like row)
			-- Initialize `Current'.
		do
			row := a_row
			row.set_data (Current)
		ensure
			row_set: row = a_row
		end

feature -- Basic functionality

	populate_row (a_factory: ES_TBT_GRID_LAYOUT [TAGABLE_I]) is
			-- <Precursor>
		do
			a_factory.populate_untagged_row (row)
		end


end
