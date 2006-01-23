indexing
	description: "Demo for polylines."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	POLYLINE_ITEM

inherit
	FIGURE_ITEM

create
	make_with_title

feature -- Access

	figure: EV_POLYLINE is
		local
			pt1, pt2, pt3: EV_PIXEL
		do
			create Result.make
			Result.set_line_width (2)
			create pt1.set (110, 30)
			Result.add (pt1)
			create pt2.set (200, 50)
			Result.add (pt2)
			create pt3.set (250, 78)
			Result.add (pt3)
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


end -- class POLYLINE_ITEM

