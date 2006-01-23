indexing
	description: "Objects that represent an EiffelVision2 header item for EV_GRID_COLUMN."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GRID_HEADER_ITEM

inherit
	EV_HEADER_ITEM

create {EV_GRID_COLUMN_I}
	make_with_grid_column

feature {NONE} -- Initialization

	make_with_grid_column (a_column: EV_GRID_COLUMN_I) is
			-- Create and associate `Current' with `a_column'
		require
			a_column_not_void: a_column /= Void
		do
			default_create
			column := a_column
		end

feature {NONE} -- Implementation

	column: EV_GRID_COLUMN_I
		-- Grid column to which `Current' is associated with.

invariant
	column_not_void: column /= Void
	parented_whilst_in_grid: column.is_displayed implies column.parent.header = parent

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end

