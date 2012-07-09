note
	description: "Class for defining EV_GRID object types"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GRID_TYPES

feature

	row_type: EV_GRID_ROW
			-- Type used for row objects.
			-- May be redefined by EV_GRID descendents.
		require
			callable: False
		do
			check False then end
		end

	column_type: EV_GRID_COLUMN
			-- Type use for column objects.
			-- May be redefined by EV_GRID descendents.
		require
			callable: False
		do
			check False then end
		end

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
