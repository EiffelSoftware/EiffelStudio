indexing
	description: "Demo for arcs."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ARC_ITEM

inherit
	FIGURE_ITEM

create
	make_with_title

feature -- Access

	figure: EV_ARC is
		local
			pt: EV_POINT
			angle1, angle2, angle3: EV_ANGLE
		do
			create Result.make
			create pt.set (150, 150)
			Result.set_center (pt)
			Result.set_radius1 (100)
			Result.set_radius2 (100)
			create angle1.make_in_degrees (0)
			create angle2.make_in_degrees (110)
			create angle3.make (0)
			Result.set_angle1 (angle1)
			Result.set_angle2 (angle2)
			Result.set_line_width (2)
			Result.set_orientation (angle3)
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


end -- class ARC_ITEM

