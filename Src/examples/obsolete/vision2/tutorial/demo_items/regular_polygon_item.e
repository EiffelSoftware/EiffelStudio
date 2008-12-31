note
	description: "Demo for regular polygons."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	Id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	REGULAR_POLYGON_ITEM

inherit
	FIGURE_ITEM

create
	make_with_title

feature -- Access

	figure: EV_REGULAR_POLYGON
		local
			pt: EV_POINT
			angle: EV_ANGLE
		do
			create Result.make
			Result.path.set_line_width (2)
			create pt.set (150, 150)
			Result.set_center (pt)
			Result.set_radius (100)
			create angle.make_in_degrees (30)
			Result.set_orientation (angle)
			Result.set_number_of_sides (13)
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


end -- class REGULAR_POLYGON_ITEM

