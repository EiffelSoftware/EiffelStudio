note
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
	default_create

feature {EV_GRID_COLUMN_I}

	set_column (a_column: EV_GRID_COLUMN_I)
			-- Set `Column
		do
			column := a_column
		end

feature -- Access

	column: detachable EV_GRID_COLUMN_I note option: stable attribute end
		-- Grid column to which `Current' is associated with.

invariant

	parented_whilst_in_grid: attached column as l_column and then l_column.is_show_requested and then attached l_column.parent as l_column_parent implies l_column_parent.header = parent

note
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







