indexing
	description: "Demo for slices."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	Id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	SLICE_ITEM

inherit
	FIGURE_ITEM

create
	make_with_title

feature -- Access

	figure: EV_SLICE is
		local
			pt: EV_POINT
			angle1, angle2, angle3: EV_ANGLE
		do
			create Result.make
			Result.path.set_line_width (2)
			create pt.set (90, 150)
			Result.set_center (pt)
			Result.set_radius1 (100)
			Result.set_radius2 (100)
			create angle1.make_in_degrees (69)
			Result.set_orientation (angle1)
			create angle2.make_in_degrees (69)
			Result.set_angle1 (angle2)
			create angle3.make_in_degrees (90)
			Result.set_angle2 (angle3)
			Result.set_pieslice_arc
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


end -- class SLICE_ITEM

