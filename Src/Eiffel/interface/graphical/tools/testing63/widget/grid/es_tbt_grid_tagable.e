indexing
	description: "[
		Objects that represent a tagable item associated with a grid row for {ES_TBT_GRID}. These rows
		represent the leaves in the underlayint {TAG_BASED_TREE}.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TBT_GRID_TAGABLE [G -> TAGABLE_I]

inherit
	ES_TBT_GRID_DATA [G]

create
	make

feature {NONE} -- Initialization

	make (a_row: like row; an_item: like item)
			-- Initialize `Current'
			--
			-- `a_row': Row representing leaf which hold tagable item.
			-- `an_item': Actual item held by leaf.
		do
			row := a_row
			item := an_item
			row.set_data (Current)
		ensure
			row_set: row = a_row
			item_set: item = an_item
		end

feature -- Access

	item: !G
			-- Item represented by leaf

feature -- Basic functionality

	populate_row (a_layout: ES_TBT_GRID_LAYOUT [G])
			-- <Precursor>
		do
			a_layout.populate_item_row (row, item)
		end

end
