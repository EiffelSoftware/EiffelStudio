indexing
	description: "Demo for ellipses."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ELLIPSE_ITEM

inherit
	FIGURE_ITEM

create
	make_with_title

feature -- Access

	figure: EV_ELLIPSE is
		local
			pt: EV_POINT
			angle: EV_ANGLE
		do
			create Result.make
			create pt.set (150, 150)
			Result.set_center (pt)
			create angle.make_in_degrees (0.0)
			Result.set_orientation (angle)
			Result.set_radius1 (100)
			Result.set_radius2 (50)
			Result.path.set_line_width (2)
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


end -- class ELLIPSE_ITEM

