indexing
	description: "Demo for rectangles."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	Id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	RECTANGLE_ITEM

inherit
	FIGURE_ITEM

create
	make_with_title

feature -- Access

	figure: EV_RECTANGLE is
		local
			pt: EV_POINT
		do
			create Result.make
			Result.path.set_line_width (2)
			create pt.set (150, 150)
			Result.set_upper_left (pt)
			Result.set_origin_to_center
			Result.set_width (100)
			Result.set_height (70)
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


end -- class RECTANGLE_ITEM

