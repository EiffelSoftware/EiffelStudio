indexing
	description: "A Demo for points."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class 
	SEGMENT_ITEM

inherit
	FIGURE_ITEM

create
	make_with_title

feature -- Access

	figure: EV_SEGMENT is
		local
			pt1, pt2: EV_POINT
		do
			create Result.make
			create pt1.set (110, 30)
			create pt2.set (200, 50)
			Result.set (pt1, pt2)
			Result.set_line_width (2)
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


end -- class SEGMENT_ITEM

