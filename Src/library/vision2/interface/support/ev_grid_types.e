indexing
	description: "Class for defining EV_GRID object types"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GRID_TYPES

feature

	row_type: EV_GRID_ROW is do end
		-- Type used for row objects.
		-- May be redefined by EV_GRID descendents.

	column_type: EV_GRID_COLUMN is do end
		-- Type use for column objects.
		-- May be redefined by EV_GRID descendents.

end
