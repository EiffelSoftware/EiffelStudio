indexing
	description: "[
		Objects representing the row having subrows for all untagged items in a {ES_TAGABLE_GRID}.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TAGABLE_GRID_TEXT_DATA [G -> TAGABLE_I]

inherit
	ES_TAGABLE_GRID_DATA [G]

create
	make

feature {NONE} -- Initialization

	make (a_row: like row; a_text: like text)
			-- Initialize `Current'.
		do
			row := a_row
			row.set_data (Current)
			text := a_text
		ensure
			row_set: row = a_row
			text_set: text = a_text
		end

feature -- Access

	text: !STRING
			-- Text shown in grid

feature -- Basic functionality

	populate_row (a_layout: ES_TAGABLE_GRID_LAYOUT [TAGABLE_I]) is
			-- <Precursor>
		do
			a_layout.populate_text_row (row, text)
		end

end
