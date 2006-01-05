indexing
	description: "Objects that represent a row for ES_OBJECTS_GRID_ROW"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_OBJECTS_GRID_ROW

inherit
	EV_GRID_ROW

create
	{EV_GRID} default_create

feature -- Parent objects grid

	parent_objects_grid: ES_OBJECTS_GRID is
		do
			Result ?= parent
		end

end
