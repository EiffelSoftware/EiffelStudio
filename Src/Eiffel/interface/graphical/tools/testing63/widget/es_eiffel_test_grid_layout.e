indexing
	description: "[
		Objects representing a {ES_TBT_GRID} layout for eiffel tests.
		
		See {ES_TBT_GRID_LAYOUT} for more information.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EIFFEL_TEST_GRID_LAYOUT

inherit
	ES_TBT_GRID_LAYOUT [EIFFEL_TEST_I]

create
	make

feature {NONE} -- Initialization

	make (a_project: like project)
			-- Initialize `Current'
			--
			-- `a_project': Project used to retrieve class and feature instances
		do
			project := a_project
		ensure
			project_set: project = a_project
		end

feature -- Access

	project: !E_PROJECT
			-- <Precursor>

feature -- Factory

	populate_item_row (a_row: !EV_GRID_ROW; a_item: !EIFFEL_TEST_I) is
			-- <Precursor>
		do
			a_row.set_item (1, create {EV_GRID_LABEL_ITEM}.make_with_text (a_item.name))
		end

end
