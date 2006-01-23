indexing
	description: "[
			Objects that are used to convert SPECIAL [EV_COORDINATE] to ARRAY [EV_COORDINATE]
					(workaround for the EV_FIGURE_DRAWER)
					]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_COORDINATE_ARRAY
	
inherit
	ARRAY [EV_COORDINATE]
	
create
	make_from_area
	
feature {NONE} -- Initialization

	make_from_area (a: SPECIAL [EV_COORDINATE]) is
			-- Make an ARRAY using `a' as `area'.
		require
			area_exists: a /= Void
		do
			area := a
			lower := 1
			upper := a.count
		end

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




end -- class EV_COORDINATE_ARRAY

